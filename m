From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Tue, 11 Dec 2018 07:17:40 +0100
Subject: [cip-dev] [PATCH 4.4-cip v2] ARM: dts: socfpga: Rename
 socfpga_cyclone5_de0_{sockit, nano_soc}
In-Reply-To: <003701d490e8$a71990f0$f54cb2d0$@toshiba.co.jp>
References: <b9e891af-405c-57b4-ae67-d61b2d989f7a@siemens.com>
	<003701d490e8$a71990f0$f54cb2d0$@toshiba.co.jp>
Message-ID: <3c7d6c81-0318-6e04-e760-98557e677c18@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 11.12.18 01:30, Daniel Sangorrin wrote:
> Koguchi-san, Jan-san:
> 
> The Deby reference implementation of CIP core contains the meta-cip-cyclonev layer. This layer is still using a separate repository (linux-cip-cyclonev.git, branch: socfpga-4.4-cip) created by Koguchi-san.
> 
> * What is the current status of the CIP kernel compared to that separate repository?

Didn't look into all details, we just once examined the NAND flash related 
changes. But then we decided to backport upstream changes instead (to my 
understanding, that tree is only Altera BSP). That happened in a project 
specific way, i.e. ignoring breakages of other drivers. Thus: no CIP material.

> * Is any of you planning to backport patches to the CIP kernel 4.4?

Not from our side any more. We will eventually move to 4.19-cip, specifically to 
overcome the long denali queue. We are lucky to have a window for this major 
update with our current Arria-10 design.

Jan

>> -----Original Message-----
>> From: cip-dev-bounces at lists.cip-project.org
>> <cip-dev-bounces@lists.cip-project.org> On Behalf Of Jan Kiszka
>> Sent: Monday, December 10, 2018 7:25 PM
>> To: cip-dev <cip-dev@lists.cip-project.org>
>> Subject: [cip-dev] [PATCH 4.4-cip v2] ARM: dts: socfpga: Rename
>> socfpga_cyclone5_de0_{sockit, nano_soc}
>>
>>
>>
>>> -----Original Message-----
>>> From: cip-dev-bounces at lists.cip-project.org
>>> <cip-dev-bounces@lists.cip-project.org> On Behalf Of Jan Kiszka
>>> Sent: Monday, December 10, 2018 7:25 PM
>>> To: cip-dev <cip-dev@lists.cip-project.org>
>>> Subject: [cip-dev] [PATCH 4.4-cip v2] ARM: dts: socfpga: Rename
>>> socfpga_cyclone5_de0_{sockit, nano_soc}
>>>
>>> From: Marek Vasut <marex@denx.de>
>>>
>>> Rename DT source for DE0 Nano SoC . The board name is really DE0-Nano-SoC
>>> or Atlas SoC, and it is not to be confused with SoCkit board, which is a
>>> different one. Rename the DT source file to match the board name and to
>>> avoid this possible mixup with another different board.
>>>
>>> Upstream commit 202eb5481421040e115526b75317b5ca72584806
>>>
>>> This commit is needed because it aligns the device tree name of U-Boot
>>> and kernel which helps distro boot procedures (fdtfile as set by U-Boot
>>> will match the kernel-provided dtb).
>>>
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> Cc: Dinh Nguyen <dinguyen@kernel.org>
>>> Cc: Jan Kiszka <jan.kiszka@siemens.com>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>
>>> Changes in v2:
>>>   - enhance upstream commit log with reason to adopt the patch
>>>
>>>   arch/arm/boot/dts/Makefile                                              | 2 +-
>>>   ...ocfpga_cyclone5_de0_sockit.dts => socfpga_cyclone5_de0_nano_soc.dts}
>> | 0
>>>   2 files changed, 1 insertion(+), 1 deletion(-)
>>>   rename arch/arm/boot/dts/{socfpga_cyclone5_de0_sockit.dts =>
>>> socfpga_cyclone5_de0_nano_soc.dts} (100%)
>>>
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>> index e0a0deaacd48..9871a7f0f92a 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>> @@ -562,7 +562,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) += \
>>>   	socfpga_arria5_socdk.dtb \
>>>   	socfpga_arria10_socdk_sdmmc.dtb \
>>>   	socfpga_cyclone5_socdk.dtb \
>>> -	socfpga_cyclone5_de0_sockit.dtb \
>>> +	socfpga_cyclone5_de0_nano_soc.dtb \
>>>   	socfpga_cyclone5_sockit.dtb \
>>>   	socfpga_cyclone5_socrates.dtb \
>>>   	socfpga_vt.dtb
>>> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
>>> b/arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dts
>>> similarity index 100%
>>> rename from arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
>>> rename to arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dts
>>> --
>>> 2.16.4
>>> _______________________________________________
>>> cip-dev mailing list
>>> cip-dev at lists.cip-project.org
>>> https://lists.cip-project.org/mailman/listinfo/cip-dev
> 
