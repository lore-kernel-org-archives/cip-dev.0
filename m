From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Tue, 19 Mar 2019 19:11:24 +0100
Subject: [cip-dev] Testing update + cip-core
In-Reply-To: <OSBPR01MB2055DD55592F4E4AC3F794AAE9400@OSBPR01MB2055.jpnprd01.prod.outlook.com>
References: <OSBPR01MB2055F3150CC418B4FFA7A740E94B0@OSBPR01MB2055.jpnprd01.prod.outlook.com>
	<OSAPR01MB376303BDABB64E54B07645C2D0400@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<d351d297-c7fc-1e43-2470-d96f5c69a9f8@siemens.com>
	<OSBPR01MB2055DD55592F4E4AC3F794AAE9400@OSBPR01MB2055.jpnprd01.prod.outlook.com>
Message-ID: <dfb75e5e-f77f-f9db-c088-663bcc667561@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 19.03.19 17:25, Patryk Mungai Ndungu wrote:
> Hello Jan,
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: 19 March 2019 10:39
>> To: daniel.sangorrin at toshiba.co.jp; Patryk Mungai Ndungu <patryk.mungai-
>> ndungu.kx at renesas.com>
>> Cc: cip-dev at lists.cip-project.org
>> Subject: Re: [cip-dev] Testing update + cip-core
>>
>> On 19.03.19 04:00, daniel.sangorrin at toshiba.co.jp wrote:
>>> Hello Patryk,
>>>
>>> Sorry for the late reply.
>>>
>>>> -----Original Message-----
>>>> From: Patryk Mungai Ndungu <patryk.mungai-ndungu.kx@renesas.com>
>>>> Sent: Friday, March 15, 2019 1:41 AM
>>>> To: sangorrin daniel(????? ???? ????????)
>> <daniel.sangorrin@toshiba.co.jp>
>>>> Cc: cip-dev at lists.cip-project.org
>>>> Subject: Testing update + cip-core
>>>>
>>>> Hello Daniel,
>>>>
>>>> Thanks again for adding lsusb to cip-core.
>>>>
>>>> I managed to add internet support to the boards in our LAVA lab the other
>> day. Now that this is the case, it would
>>>> be really useful to have apt-get installed in cip-core, in case any
>> dependencies are missing in the rfs.
>>>
>>> I will send the AWS instructions to Jan and create an account for him so that
>> he can upload ISAR images.
>>> We will need to port ISAR to the Renesas board though.
>>
>> About which boards are we talking? How does the boot process and imaging
>> look
>> like for them? That will help assessing the effort (which can vary a lot,
>> specifically with modern, complex ones).
>>
> 
> I believe Daniel means the Renesas iwg20m. I'm not sure what you mean by boot process and imaging, but I believe it's straightforward.
> To boot the board, you provide it the kernel image and dtb via tftp, and access to a RFS and it boots. There is no secure layer.

Isar-cip-core generally has to goal to generate fully bootable images 
("turn-key" solution). That means an SD card or eMMC or raw flash image that 
contains all necessary artifacts at the right location, like with the BBB 
(U-Boot at the right sector, configured in distro boot mode to pull dt and 
kernel from the Debian rootfs). If you have a U-Boot preinstalled on the board, 
it should either support distro boot, or we need some instruction what to add to 
its env in order to compensate what might be missing.

However, that does not exclude tftp+nfs boot for testing purposes. You will have 
all needed binaries available along with the self-standing image.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
