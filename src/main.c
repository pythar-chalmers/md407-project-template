/*
 * Example LED with md407 project template
 * */

// STD
#include <stdbool.h>

// Drivers/lib
#include "stm32f4xx.h"
#include "stm32f4xx_gpio.h"
#include "stm32f4xx_rcc.h"

int main(void) {
	GPIO_InitTypeDef init;
	GPIO_StructInit(&init);

	init.GPIO_Mode = GPIO_Mode_OUT;
	init.GPIO_Pin  = GPIO_Pin_0;

	// Init GPIO
	GPIO_Init(GPIOD, &init);

	// Enable the bits
	GPIO_ResetBits(GPIOD, GPIO_Pin_0);
	GPIO_SetBits(GPIOD, GPIO_Pin_0);

	while (true)
		;

	return 0;
}
