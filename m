From: marex@denx.de (Marek Vasut)
Date: Fri, 6 Jul 2018 10:50:59 +0200
Subject: [cip-dev] Altera CIP branch vs. Denali NAND driver
In-Reply-To: <c1021ce7-15d0-af10-101c-a045158065e5@siemens.com>
References: <95cf4467-b48b-6a80-931c-a7f664048c6d@siemens.com>
	<TYAPR01MB2160D07D4F9524CBF5A860D0D7470@TYAPR01MB2160.jpnprd01.prod.outlook.com>
	<fd6af125-0a28-d4a5-85cc-13e94778c7be@siemens.com>
	<58ce82ba-6cd8-be0e-0905-261431a93a1a@denx.de>
	<c1021ce7-15d0-af10-101c-a045158065e5@siemens.com>
Message-ID: <9ceb2908-287f-9049-152f-9fb0f161d0fa@denx.de>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 07/06/2018 10:34 AM, Jan Kiszka wrote:
> On 2018-07-06 10:21, Marek Vasut wrote:
>> On 07/06/2018 10:05 AM, Jan Kiszka wrote:
>>> On 2018-07-06 09:52, ???? / KOGUCHI?TAKUO wrote:
>>>> (2) Bootloader needs to set SPARE_AREA_SKIP_BYTES properly, which is used by denali_hw_init. (I do not remember the actual value off the top of my head). Without this, it resulted in ECC errors as far as I remember.
>>>
>>> We are using upstream U-boot (Marek sorted out the BSP U-boot
>>> differences for us). I suppose you were using the Altera's version,
>>> right? Marek, any comment on this tuning?
>>
>> This is selected based on the DT compatible value in mainline U-Boot,
>> instead of being hardcoded into the binary, see
>>
>> http://git.denx.de/?p=u-boot.git;a=blob;f=drivers/mtd/nand/denali_dt.c;h=65a7797f0f3819aace32ea4f8a8a8b5d504b5a62;hb=HEAD#l21
>>
> 
> Hmm, aren't the DT bindings different between upstream and the Altera
> BSP (thus also the cip-playground patches)? Or were we using a different
> DT for mainline U-boot than for the CIP kernel, Marek?

Mainline U-Boot is importing the DTS from mainline Linux, so it is
mostly in sync with DT properties used by Linux. U-Boot is using it's
own DT blob and this is not being passed to Linux, Linux also has it's own.

It is quite possible the Altera BSP invented some additional non
standard DT properties.

-- 
Best regards,
Marek Vasut
