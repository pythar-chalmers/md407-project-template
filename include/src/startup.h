#pragma once

// Constants
#define BASE_STACK_ADDRESS 0x2001BFF0

// Defines
#ifndef str
#define str(x) #x
#endif

#ifndef xstr
#define xstr(x) str(x)
#endif

#define SET_STACK_ADDR(ADDR)                                                 \
	__asm__ volatile(" LDR R0,=" xstr(ADDR) "\n");                           \
	__asm__ volatile(" MOV SP,R0\n")
