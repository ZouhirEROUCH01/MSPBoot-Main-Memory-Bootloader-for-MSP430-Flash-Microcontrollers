//
// Filename: App1_F5529_UART_Single_Image.c
// Generated from App1_MSPBoot_F5529_UART.txt
// Thu Mar 21 16:37:49 2019


#include <stdint.h>


#define App1_SIZE   816

const uint32_t App1_Addr[3] = {
    0x4402,	// Address segment0
    0xf702,	// Address segment1
    0xf7fe,	// Address segment2
};

const uint32_t App1_Size[3] = {
726,   // Size segment0
88,   // Size segment1
2,   // Size segment2
};

const uint8_t App1_0[] = {
0x81,0x00,0x00,0x44,0xb0,0x13,0x90,0x46,0x0c,0x93,0x02,0x24,0xb0,0x13,0x92,0x45,
0x0c,0x43,0xb0,0x13,0x22,0x44,0x1c,0x43,0xb0,0x13,0x8a,0x46,0xff,0x3f,0x03,0x43,
0xb2,0x40,0x80,0x5a,0x5c,0x01,0xd2,0xe3,0x02,0x02,0x1e,0x14,0x3d,0x40,0x64,0xc9,
0x3e,0x42,0x1d,0x83,0x0e,0x73,0xfd,0x23,0x0d,0x93,0xfb,0x23,0x1d,0x16,0x03,0x43,
0xd2,0xe3,0x02,0x02,0x1e,0x14,0x3d,0x40,0x64,0xc9,0x3e,0x42,0x1d,0x83,0x0e,0x73,
0xfd,0x23,0x0d,0x93,0xfb,0x23,0x1d,0x16,0x03,0x43,0xd2,0xe3,0x02,0x02,0x1e,0x14,
0x3d,0x40,0x64,0xc9,0x3e,0x42,0x1d,0x83,0x0e,0x73,0xfd,0x23,0x0d,0x93,0xfb,0x23,
0x1d,0x16,0x03,0x43,0xd2,0xe3,0x02,0x02,0xd2,0xe3,0x02,0x02,0x1e,0x14,0x3d,0x40,
0x64,0xc9,0x3e,0x42,0x1d,0x83,0x0e,0x73,0xfd,0x23,0x0d,0x93,0xfb,0x23,0x1d,0x16,
0x03,0x43,0xd2,0xe3,0x02,0x02,0x1e,0x14,0x3d,0x40,0x64,0xc9,0x3e,0x42,0x1d,0x83,
0x0e,0x73,0xfd,0x23,0x0d,0x93,0xfb,0x23,0x1d,0x16,0x03,0x43,0xd2,0xe3,0x02,0x02,
0x1e,0x14,0x3d,0x40,0x64,0xc9,0x3e,0x42,0x1d,0x83,0x0e,0x73,0xfd,0x23,0x0d,0x93,
0xfb,0x23,0x1d,0x16,0x03,0x43,0xd2,0xe3,0x02,0x02,0xe2,0xd3,0x03,0x02,0xe2,0xd3,
0x07,0x02,0xe2,0xd3,0x19,0x02,0xe2,0xd3,0x1b,0x02,0xf2,0xd0,0x18,0x00,0x2a,0x02,
0xf2,0xd2,0x24,0x02,0xd2,0xd3,0x04,0x02,0xd2,0xd3,0xc0,0x05,0xf2,0xd0,0x40,0x00,
0xc0,0x05,0xf2,0xd0,0x03,0x00,0xc6,0x05,0xc2,0x43,0xc7,0x05,0xf2,0x40,0x06,0x00,
0xc8,0x05,0xd2,0xc3,0xc0,0x05,0xd2,0xd3,0xdc,0x05,0x03,0x43,0x32,0xd2,0x03,0x43,
0xf2,0x40,0xab,0x00,0xce,0x05,0xff,0x3f,0x03,0x43,0x2a,0x14,0x78,0x4c,0x09,0x43,
0x14,0x3c,0x0b,0x4b,0xce,0x0d,0xfe,0x0b,0xbe,0x00,0x01,0x00,0xad,0x00,0x01,0x00,
0xfd,0x4e,0xff,0xff,0x1f,0x83,0xfa,0x23,0x04,0x3c,0xad,0x00,0x01,0x00,0xfd,0x4c,
0xff,0xff,0x58,0x03,0x19,0x53,0x39,0x92,0xe9,0x37,0x18,0xb3,0xf6,0x23,0x7b,0x4c,
0x7f,0x4c,0xce,0x0b,0x5e,0x0e,0xcb,0x0f,0x5b,0x0f,0x3b,0xf0,0x0f,0x00,0x0b,0xde,
0x3f,0xf0,0x0f,0x00,0x3f,0x50,0x03,0x00,0x3f,0x90,0x12,0x00,0x0c,0x20,0x7e,0x4c,
0x3e,0xb0,0x80,0x00,0x07,0x24,0x7a,0x4c,0x3e,0xf0,0x7f,0x00,0x4a,0x4a,0x46,0x18,
0x0a,0x5a,0x0e,0xda,0x0f,0x5e,0x3b,0x90,0xff,0x0f,0xcb,0x23,0x28,0x16,0x10,0x01,
0x2a,0x14,0x40,0x18,0x1a,0x42,0x5c,0x01,0x40,0x18,0xb2,0x40,0x80,0x5a,0x5c,0x01,
0x8f,0x00,0xb6,0x46,0x9f,0x00,0xc2,0x46,0x13,0x24,0x89,0x00,0xc8,0x46,0x88,0x00,
0xd8,0x46,0x0c,0x3c,0x0c,0x09,0x7f,0x4c,0x5f,0x06,0x00,0x18,0x5f,0x4f,0xb6,0x46,
0xa9,0x00,0x04,0x00,0x0d,0x09,0x4f,0x13,0xa9,0x00,0x04,0x00,0xd9,0x08,0xf2,0x23,
0x7a,0xc2,0x3a,0xd0,0x08,0x5a,0x40,0x18,0x82,0x4a,0x5c,0x01,0xb0,0x13,0x94,0x46,
0x28,0x16,0x10,0x01,0x0f,0x14,0xa2,0x93,0xde,0x05,0x0f,0x20,0xe2,0xb3,0xdd,0x05,
0xfd,0x27,0x5f,0x42,0x60,0x24,0xdf,0x42,0xcc,0x05,0x08,0x24,0xd2,0x53,0x60,0x24,
0xd2,0xe3,0x02,0x02,0xd2,0x42,0xcc,0x05,0xce,0x05,0x0f,0x16,0x00,0x13,0x1f,0x4c,
0x01,0x00,0x1e,0x4c,0x03,0x00,0x0e,0x93,0x02,0x20,0x0f,0x93,0x09,0x24,0xad,0x00,
0x01,0x00,0xcd,0x43,0xff,0xff,0x1f,0x83,0x0e,0x73,0xf9,0x23,0x0f,0x93,0xf7,0x23,
0x10,0x01,0xb2,0x40,0xde,0xc0,0x00,0x24,0xd2,0xd3,0x02,0x24,0x32,0xc2,0x03,0x43,
0xb2,0x40,0x0f,0x5a,0x5c,0x01,0xff,0x3f,0x03,0x43,0x0e,0x93,0x07,0x24,0xcf,0x0c,
0xaf,0x00,0x01,0x00,0xff,0x4d,0xff,0xff,0x1e,0x83,0xfa,0x23,0x10,0x01,0xcf,0x0c,
0xcc,0x0d,0xcd,0x0f,0xad,0x00,0x05,0x00,0x1e,0x4f,0x01,0x00,0x80,0x00,0x4c,0x46,
0x4f,0x14,0xc2,0x43,0x1c,0x02,0xb0,0x13,0x34,0x46,0x4b,0x16,0x00,0x13,0xd2,0xe3,
0x02,0x02,0x92,0xc3,0x42,0x03,0x00,0x13,0x03,0x43,0xff,0x3f,0x03,0x43,0x1c,0x43,
0x10,0x01,0x10,0x01,0x01,0xff,0x68,0x65,0x6c,0x6c,0x6f,0x20,0x49,0x20,0xff,0x6d,
0x20,0x52,0x65,0x64,0x6f,0x75,0x61,0xff,0x6e,0x65,0x00,0x00,0x48,0x24,0x00,0x00,
0x01,0x00,0xff,0xf0,0x10,0x46,0x00,0x00,0x1c,0x45,0x00,0x00,0x60,0x46,0x00,0x00,
0x00,0x00,0x40,0x00,0x00,0x00,0x96,0x46,0x00,0x00,0x48,0x24,0x00,0x00,0xc2,0x46,
0x00,0x00,0x08,0x24,0x00,0x00,
};

const uint8_t App1_1[] = {
0x30,0x40,0x1e,0x44,0x30,0x40,0x1e,0x44,0x30,0x40,0x1e,0x44,0x30,0x40,0x1e,0x44,
0x30,0x40,0x1e,0x44,0x30,0x40,0x1e,0x44,0x30,0x40,0x72,0x46,0x30,0x40,0x1e,0x44,
0x30,0x40,0x1e,0x44,0x30,0x40,0x1e,0x44,0x30,0x40,0x1e,0x44,0x30,0x40,0x1e,0x44,
0x30,0x40,0x80,0x46,0x30,0x40,0x1e,0x44,0x30,0x40,0x1e,0x44,0x30,0x40,0xe6,0x45,
0x30,0x40,0x1e,0x44,0x30,0x40,0x1e,0x44,0x30,0x40,0x1e,0x44,0x30,0x40,0x1e,0x44,
0x30,0x40,0x1e,0x44,0x30,0x40,0x1e,0x44,
};

const uint8_t App1_2[] = {
0x02,0x44,
};

const uint8_t *App1_Ptr[3] = {
App1_0,
App1_1,
App1_2,
};
