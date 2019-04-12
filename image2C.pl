# --COPYRIGHT--,BSD
#  Copyright (c) 2018, Texas Instruments Incorporated
#  All rights reserved.
# 
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions
#  are met:
# 
#  *  Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
# 
#  *  Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
# 
#  *  Neither the name of Texas Instruments Incorporated nor the names of
#     its contributors may be used to endorse or promote products derived
#     from this software without specific prior written permission.
# 
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
#  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
#  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
#  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
#  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
#  EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# --/COPYRIGHT--

#Perl script used to convert MSP430 .txt or intel .hex to C array in .h file
# format:
#   perl image2c.pl src dest struct
#       src:    Source file in MSP430 .txt or intel .hex format
#       dest:   Destination file in .h format
#       struct: Name of output array
#

use Getopt::Long;
use File::Basename;

## Get input parameters
print( "\n image2C.pl V1 \n");
print( "Texas Instruments Inc 2018 \n");

$file430;
$fileH;
$struct;
$large_mem_model = 0;
$AddrArray;
$SizeArray;
$DataArray;
$SegmentArray;
$total_segments = 0;
$total_data_in_seg = 0;
$total_data_in_file = 0;
my $help = 0;

# Parse the command line arguments
GetOptions ("src=s"        => \$file430,      	# string
            "20_bit" => \$large_mem_model,    	# string, optional
            "dst=s"    => \$fileH,      		# string
            "struct=s" => \$struct,    			# string
			"help" => \$help
            )
	or die("Error in command line arguments\n");
	
# Check that all necesary data has been entered
if ((!$file430) || (!$fileH)||(!$struct)||($help))
{
	print("Error in command line arguments\n");
	help();
    die;
}

# Specify the name of output file
my $outputdir = './output/';
mkdir $outputdir unless -d $outputdir;
my $output_file = $outputdir.$fileH;

###############
# Process Input
# Get all input file lines
##############################
open( InFile, $file430  ) || die "Cannot open source file: $file430 \n";
($file_name, $path, $file_ext) = fileparse($file430, '\.[^\.]*');
#print $file_ext."\n";
if( $file_ext eq ".txt") # is it MSP430 txt
{
	while( $txtline = <InFile> )
	{
		#print ($txtline);
		$ret = processtxt_line();
		if ($ret == 0)
		{
		}
	}
}
elsif( $file_ext eq ".hex") # is it intel hex
{
	$seg_addr = -1;
	while( $txtline = <InFile> )
	{
		#print ($txtline);
		$ret = processhex_line();
		if ($ret == 0)
		{
		}
	}
}
close InFile;
close_segment();    # Close last segment

###############
# Process Output
# Send to .h file
##############################
# open file to write to
open( OutFile, ">$output_file" ) || die "Cannot open destination file: $output_file\n";
##### File Header
    print OutFile ( "//\n" );
    print OutFile ("// Filename: ", $fileH, "\n");
    print OutFile ("// Generated from ", $file430, "\n");
##### File Time
    print OutFile ("// ".localtime."\n\n\n");
##### include file
    print OutFile ("#include <stdint.h>\n\n\n");
##### define size
    print OutFile ("#define ".$struct."_SIZE   ".$total_data_in_file."\n\n");
##### Address Array
	if($large_mem_model)
	{
		print OutFile ("const uint32_t ".$struct."_Addr[".$total_segments."] = {\n");
	}
	else
	{
		print OutFile ("const uint16_t ".$struct."_Addr[".$total_segments."] = {\n");
	}
    print OutFile ($AddrArray."};\n\n");
##### Size Array
	if($large_mem_model)
	{
		print OutFile ("const uint32_t ".$struct."_Size[".$total_segments."] = {\n");
	}
	else
	{
		print OutFile ("const uint16_t ".$struct."_Size[".$total_segments."] = {\n");
	}
    
    print OutFile ($SizeArray."};\n\n");
##### Data Array
	for ($i=0; $i < $total_segments; $i+=1)
        {
			print OutFile ("const uint8_t ".$struct."_".$i."[] = {\n");
			print OutFile ($DataArray[$i]."};\n\n");
        }

##### Pointer Array
    print OutFile ("const uint8_t *".$struct."_Ptr[".$total_segments."] = {\n");
    for ($i=0; $i < $total_segments; $i+=1)
        {
			print OutFile ($struct."_".$i.",\n");
        }
	print OutFile ("};\n\n");

print "\n********File ".$fileH." generated OK! ***********\n";
    #print "\nFile ".$fileH." generated OK!\nPress Enter to close\n\n\n";
#<STDIN>;
close OutFile;

###############
# Sub-routines
##############################
sub close_segment {
	$SizeArray = $SizeArray.$total_data_in_seg.",   // Size segment".($total_segments-1)."\n";
	$total_data_in_file+=$total_data_in_seg;
    $total_data_in_seg = $total_data_in_seg/2;
    #$DataArray = $DataArray."    ".$total_data_in_seg.",\t//Number of words in segment\n";
    $DataArray[$total_segments-1] = $SegmentArray;
	#print "\nSegment".($total_segments-1)."\n";
	#print $SegmentArray;
	#print $DataArray[$total_segments-1];
    # start next segment
    $total_data_in_seg = 0;
    $SegmentArray = "";
}

sub processtxt_line {
    if( $txtline =~ m/^@/ ) # does string start @
    {
        # Address
        $addr = hex( substr( $txtline, 1, 6 ) );
        $addrhex = sprintf("    0x%x", $addr);
        $AddrArray = $AddrArray.$addrhex.",\t// Address segment".$total_segments."\n";
        # close previous segment
        if ($total_segments > 0)
        {
            close_segment();
        }
        $total_segments++ ;
    }
    elsif ( $txtline =~m/^(1|2|3|4|5|6|7|8|9|0|A|B|C|D|E|F)/i )
    {
        # Data
        #print ("Data: ", $txtline, "\n");
        $txt_count = $txtline;
        $count = $txt_count =~ s/((1|2|3|4|5|6|7|8|9|0|A|B|C|D|E|F))(1|2|3|4|5|6|7|8|9|0|A|B|C|D|E|F)./$1/sg;
        #print ("Count: ", $count, "\n");
        $total_data_in_seg += $count;
        for ($i=0; $i < $count; $i+=2)
        {
            $SegmentArray = $SegmentArray.sprintf("0x%02x,0x%02x,", hex( substr( $txtline, $i*3, 2 ) ), hex( substr( $txtline, $i*3+3, 2 )) );
        }
        $SegmentArray = $SegmentArray."\n";
        #print ("Data Array:".$SegmentArray);

    }
    else
    {
        #not address or data
        return 1;
    }

    return 0;
}

sub processhex_line {
	
	#print "\nProcessing line: ".$txtline."\n";
	if( $txtline =~ m/^:/ ) # does string start with :
	{
		# Number bytes in lines
		$numbytes = hex( substr( $txtline, 1, 2));	# number of bytes in current line
		$addr = hex( substr( $txtline, 3, 4));		# address of bytes on current line
		$addr += $extended_addr;
		$addrhex = sprintf("0x%08x", $addr);		# convert to 0x00 format
		$rectype = hex( substr( $txtline, 7, 2));	# record type of line
		
		#print "number bytes: ".$numbytes."\n";
		#print "address: ".$addrhex."\n";
		#print "record type: ".$rectype."\n";
		
		if ($rectype == 4)	# found extended address
		{
			#print "found extended address\n";
			#$extended_addr_flg++;
			$extended_addr = hex( substr( $txtline, 9, 4));
			$extended_addr <<= 16;
			#print "extended address: ".sprintf("0x%08x", $extended_addr)."\n";
		}
		elsif ($rectype == 0)
		{

			
			#print "addr: ".$addr."\n";
			#print "expected addr: ".($sec_addr + $total_data_in_seg)."\n";
			
			# if address on current line is not equal to address of current section plus number of bytes in
			# section, then this line is not in the same contiguous section of memory
			if ($addr != ($seg_addr + $total_data_in_seg))
			{
				
				$AddrArray = $AddrArray.$addrhex.",\t// Address segment".$total_segments."\n";
				if ($total_segments > 0)
				{
					close_segment();
				}
				$total_segments++ ;
				
				#print "Section of length ".$total_data_in_seg." ended\n";	

				#print "Starting new section at address ".$addrhex."\n";
				$seg_addr = $addr;
			}
			
			if ($numbytes > 0)
			{
			
				$total_data_in_seg += $numbytes;
				for ($i=0; $i<$numbytes; $i+=1)
				{
					$SegmentArray = $SegmentArray.sprintf("0x%02x,", hex( substr( $txtline, $i*2 + 9, 2)));
				}
				$SegmentArray = $SegmentArray."\n";
			}

			#print "Line Data: ".$SegmentArray;
			#print "Data in section: ".$total_data_in_seg."\n";
		}
		else{
			#print "unrecognized record type\n";
			return 1;
		}
	
	}
	else
	{
		# improper format
		return 1;
	}

	return 0;
}

#Help 
sub help{ 

    print "
===============================================================================
    This script converts an MSP430 .txt or intel .hex file to C array
===============================================================================
[] denotes optional field
        image2C.pl   [-help] 
                      -src <filename_1>
                      -dst <filename_2>
                      -struct <struct_name>
                      [-20_bit]
        
  -src              Specifies the input file. 
   <filename_1>     Input file name. 
                    Must be in the same directory as 430txt2C.pl or specify path
   
  -dst              Specifies output file. 
  <filename_2>      Output file name. Generates:
                    ./output/<filename_2>(file containing the generated output)
                    
  -struct           Specifies the structure for the output file. 
  <struct_name>     Name of structure in output file.
  
  -20_bit           If enabled, the output file will be generated in a format 
                    suitable for large memory model MSP430 devices. Otherwise, 
                    small memory modle (16-bit) is assumed.

  -help             Displays this help dialog. 
===============================================================================
EXAMPLE: 
MSP430F5529 application with 20_bit support. 

This command generates both the C array files:
    
perl image2C.pl -src App1_MSPBoot_F5529_UART.txt 
    -dst App1_F5529_UART_Single_Image.c -struct App1
	-20_bit

"; 
    exit; 
}
