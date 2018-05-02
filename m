From: wagi@monom.org (Daniel Wagner)
Date: Wed, 2 May 2018 08:35:58 +0200
Subject: [cip-dev] Linux 4.4.126-cip22
In-Reply-To: <OSBPR01MB21030BA75D24294F1D731CC5B8820@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1523476441.2951.8.camel@codethink.co.uk>
	<1523477437.2951.10.camel@codethink.co.uk>
	<90f2920d-abbb-affc-35f7-54161a13173c@monom.org>
	<TYAPR01MB228513B0546B4029878033C9B7820@TYAPR01MB2285.jpnprd01.prod.outlook.com>
	<OSBPR01MB21030BA75D24294F1D731CC5B8820@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Message-ID: <b552bb6e-df2a-9a0d-3f24-430435886246@monom.org>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Good Morning Biju,

On 04/30/2018 12:18 PM, Biju Das wrote:
> Hi Daniel,
> 
> We are trying to figure out the kernel defconfig  used for this build error.

Great!
>  From the logs you have provided, I am not able to locate "CONFIG_SERIAL_SH_SCI=m" in any of cip kernel config file for x86 (branch:-v4.4.126-cip22).
> 
> We planned to enable some more  kernel-config option in shmobile defconfig (for eg:- CAN,SGTL5000 etc..) in future.
> 
> We would like to avoid the build error like the below one in future. So can you please help us in locating the defconfig file?

I got this by triggering the CI build on [1]. Though from the report I'd
say it was triggered by running allmodconfig on x86_64. 


Let's try it on x85_64:

$ make O=/tmp/build-test allmodconfig
$ grep CONFIG_SERIAL_SH_SCI /tmp/build-test/.config
CONFIG_SERIAL_SH_SCI=m
CONFIG_SERIAL_SH_SCI_NR_UARTS=2
CONFIG_SERIAL_SH_SCI_DMA=y


On ARM I get the same:

$ CROSS_COMPILE=arm-linux-gnu- make ARCH=arm O=/tmp/build-test allmodconfig
$ grep CONFIG_SERIAL_SH_SCI /tmp/build-test/.config
CONFIG_SERIAL_SH_SCI=m
CONFIG_SERIAL_SH_SCI_NR_UARTS=2
CONFIG_SERIAL_SH_SCI_DMA=y


And now for shmobile_defconfig:

$ CROSS_COMPILE=arm-linux-gnu- make ARCH=arm O=/tmp/build-test shmobile_defconfig
$ grep CONFIG_SERIAL_SH_SCI /tmp/build-test/.config
CONFIG_SERIAL_SH_SCI=y
CONFIG_SERIAL_SH_SCI_NR_UARTS=20
CONFIG_SERIAL_SH_SCI_CONSOLE=y
# CONFIG_SERIAL_SH_SCI_DMA is not set


I'd say you need also to build with allmodconfig the kernel to
trigger this problem.


Thanks,
Daniel

[1] https://ci-rt.linutronix.de/RT-Test/

> 
> Regards,
> Biju
> 
> 
>> -----Original Message-----
>> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-
>> bounces at lists.cip-project.org] On Behalf Of Daniel Wagner
>> Sent: 27 April 2018 12:24
>> To: Ben Hutchings <ben.hutchings@codethink.co.uk>
>> Cc: cip-dev at lists.cip-project.org
>> Subject: Re: [cip-dev] Linux 4.4.126-cip22
>>
>> Hi Ben,
>>
>> On 04/11/2018 10:10 PM, Ben Hutchings wrote:
>>> On Wed, 2018-04-11 at 20:54 +0100, Ben Hutchings wrote:
>>> [...]
>>>> I also tagged an intermediate version 4.4.120-cip21 before merging
>>>> from 4.4-stable.
>>>
>>> Sorry, that intermediate version was actually 4.4.126-cip21.  It
>>> includes the stable changes but not the improvements to Renesas
>>> hardware support that are in -cip22.
>>
>> While working on the cip-rt spin I got following error from our ci build
>> server:
>>
>> Errors:
>> -------
>>       all annotations:
>>       ~~~~~~~~~~~~~~~~
>>       ERROR: "mctrl_gpio_disable_ms" [drivers/tty/serial/sh-sci.ko] undefined!
>>
>>       ERROR: "mctrl_gpio_init" [drivers/tty/serial/sh-sci.ko] undefined!
>>
>>
>> I think this was introduced by 8bac17a7f510 ("serial: sh-sci: Add support for
>> GPIO-controlled modem lines"). serial_mcrtl_gpio.h provides for GPIOLIB
>> and !GPIOLIB an implementation.
>>
>> I am slightly confused, though I haven't spend a lot of time yet to figure out
>> what's going on.
>>
>> Thanks,
>> Daniel
> 
> 
> 
> Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
> 
