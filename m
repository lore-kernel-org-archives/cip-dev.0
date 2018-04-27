From: wagi@monom.org (Daniel Wagner)
Date: Fri, 27 Apr 2018 13:33:18 +0200
Subject: [cip-dev] Linux 4.4.126-cip22
In-Reply-To: <90f2920d-abbb-affc-35f7-54161a13173c@monom.org>
References: <1523476441.2951.8.camel@codethink.co.uk>
	<1523477437.2951.10.camel@codethink.co.uk>
	<90f2920d-abbb-affc-35f7-54161a13173c@monom.org>
Message-ID: <1fe18b95-eb3d-09a8-7e78-e686a8fc41ff@monom.org>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

>       all annotations:
>       ~~~~~~~~~~~~~~~~
>       ERROR: "mctrl_gpio_disable_ms" [drivers/tty/serial/sh-sci.ko]
> undefined!
> 
>       ERROR: "mctrl_gpio_init" [drivers/tty/serial/sh-sci.ko] undefined!
> 
> 
> I think this was introduced by 8bac17a7f510 ("serial: sh-sci: Add
> support for GPIO-controlled modem lines"). serial_mcrtl_gpio.h provides
> for GPIOLIB and !GPIOLIB an implementation.
> 
> I am slightly confused, though I haven't spend a lot of time yet to
> figure out what's going on.

I guess those two symbols are just missing the export. Patch in the works.
