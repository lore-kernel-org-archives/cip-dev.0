From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Mon, 2 Oct 2017 13:14:16 +0200
Subject: [cip-dev] B@D support Renesas iwg20m board - issue
In-Reply-To: <004801d33752$7197b510$54c71f30$@toshiba.co.jp>
References: <FD48CE4B67D3004BAA683CC1E3106E2D07BABEAB32@RVC-MBS-CL.rvc.renesas.com>
	<87tw1jbjwa.fsf@ctlt579.codethink.co.uk>
	<FD48CE4B67D3004BAA683CC1E3106E2D07BB5C748C@RVC-MBS-CL.rvc.renesas.com>
	<000701d32abf$74cb3170$5e619450$@toshiba.co.jp>
	<FD48CE4B67D3004BAA683CC1E3106E2D07BD7458BF@RVC-MBS-CL.rvc.renesas.com>
	<005e01d32b67$81b2c940$85185bc0$@toshiba.co.jp>
	<FD48CE4B67D3004BAA683CC1E3106E2D07BDAC2D49@RVC-MBS-CL.rvc.renesas.com>
	<008e01d331db$47a6f800$d6f4e800$@toshiba.co.jp>
	<009b01d331e0$0312b7b0$09382710$@toshiba.co.jp>
	<TY1PR06MB0702376EAE797EB8AAECF90AB7610@TY1PR06MB0702.apcprd06.prod.outlook.com>
	<FD48CE4B67D3004BAA683CC1E3106E2D07BE062CF2@RVC-MBS-CL.rvc.renesas.com>
	<000101d336ac$c63abf50$52b03df0$@toshiba.co.jp>
	<59CA2D0C.8070302@codethink.co.uk>
	<004801d33752$7197b510$54c71f30$@toshiba.co.jp>
Message-ID: <59D21F88.3030401@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Daniel,

On 27/09/17 07:35, Daniel Sangorrin wrote:
> Agustin, Robert:
>
>> -----Original Message-----
>> From: Agustin Benito Bethencourt [mailto:agustin.benito at codethink.co.uk]
>> Sent: Tuesday, September 26, 2017 7:34 PM
>> To: Daniel Sangorrin; 'cip dev'
>> Cc: 'Binh Thanh. Nguyen'; 'Chris Paterson'; 'Robert Marshall'; 'O365-Toru Oishi'
>> Subject: Re: [cip-dev] B at D support Renesas iwg20m board - issue
>>
>> Hi,
>>
>> On 26/09/17 11:49, Daniel Sangorrin wrote:
>>> Hi Binh, Robert, Everyone
>>>
>>> I have Project-X for iwg20m working with LAVA 2017.7 (boot test and a simple uname test so far).
>>> # I will send the patches another day.
>>>
>>> Robert: do you have plans to update to 2017.9?
>>
>> We will not before ELCE. We will concentrate on properly releasing what
>> we currently have for the event.
>
> Alright, then I will prepare the demo for 2017.7.
>
> Robert: until now I was using lava-docker, is the 2017.7 version fully working now?
> What branch should I use?
>
> Another question:
> Is it possible to upload artifacts (CIP Core's ramdisk, uImage, devicetree etc) to
> the AWS S3 storage so that we can share the same binaries for demos etc?

You should have received the credentials through mail. Sorry for the delay.

>
> Thanks,
> Daniel
>
>>>> -----Original Message-----
>>>> From: Binh Thanh. Nguyen [mailto:binh.nguyen.uw at rvc.renesas.com]
>>>> Sent: Wednesday, September 20, 2017 6:30 PM
>>>> To: Chris Paterson; Daniel Sangorrin; 'cip dev'
>>>> Cc: O365-Toru Oishi
>>>> Subject: RE: [cip-dev] B at D support Renesas iwg20m board - issue
>>>>
>>>> Hi Daniel,
>>>>
>>>>> -----Original Message-----
>>>>> From: Chris Paterson [mailto:Chris.Paterson2 at renesas.com]
>>>>> Sent: Wednesday, September 20, 2017 3:29 PM
>>>>> To: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>; Binh Thanh. Nguyen
>>>>> <binh.nguyen.uw@rvc.renesas.com>; 'cip dev' <cip-dev@lists.cip-
>>>>> project.org>
>>>>> Cc: O365-Toru Oishi <toru.oishi.zj@renesas.com>
>>>>> Subject: RE: [cip-dev] B at D support Renesas iwg20m board - issue
>>>>>
>>>>> Hello Daniel,
>>>>>
>>>>>> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-
>>>>>> bounces at lists.cip-project.org] On Behalf Of Daniel Sangorrin
>>>>>> Sent: 20 September 2017 08:14
>>>>>>
>>>>>> Hi Binh,
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: cip-dev-bounces at lists.cip-project.org
>>>>>>> [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Daniel
>>>>>>> Sangorrin
>>>>>>> Sent: Wednesday, September 20, 2017 3:40 PM
>>>>>>> To: 'Binh Thanh. Nguyen'; 'cip dev'
>>>>>>> Cc: 'O365-Toru Oishi'
>>>>>>> Subject: Re: [cip-dev] B at D support Renesas iwg20m board - issue
>>>>>>>
>>>>>>> Hi Binh,
>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Binh Thanh. Nguyen [mailto:binh.nguyen.uw at rvc.renesas.com]
>>>>>>>> Sent: Friday, September 15, 2017 8:46 PM
>>>>>>>> To: Daniel Sangorrin; 'cip dev'
>>>>>>>> Cc: O365-Toru Oishi
>>>>>>>> Subject: RE: [cip-dev] B at D support Renesas iwg20m board - issue
>>>>>>>>
>>>>>>>> Hello Daniel,
>>>>>>>>
>>>>>>>> Sorry for late reply. I got few days off for some reasons.
>>>>>>>>
>>>>>>>>> -----Original Message-----
>>>>>>>>> From: Daniel Sangorrin [mailto:daniel.sangorrin at toshiba.co.jp]
>>>>>>>>> Sent: Tuesday, September 12, 2017 8:36 AM
>>>>>>>>> To: Binh Thanh. Nguyen <binh.nguyen.uw@rvc.renesas.com>; 'cip
>>>>> dev'
>>>>>>>>> <cip- dev@lists.cip-project.org>
>>>>>>>>> Cc: O365-Toru Oishi <toru.oishi.zj@renesas.com>
>>>>>>>>> Subject: RE: [cip-dev] B at D support Renesas iwg20m board - issue
>>>>>>>>>
>>>>>>>>> Hi Binh,
>>>>>>>>>
>>>>>>>>>> -----Original Message-----
>>>>>>>>>> From: Binh Thanh. Nguyen
>>>>>> [mailto:binh.nguyen.uw at rvc.renesas.com]
>>>>>>>>>> Sent: Monday, September 11, 2017 8:00 PM
>>>>>>>>>>> Any updates on this topic?
>>>>>>>>>> I have no update. I was busy with other tasks with high
>>>>>>>>>> priority. I will
>>>>>>>>> manage to back to this task from next week.
>>>>>>>>>> I will let you know if there is any update.
>>>>>>>>>
>>>>>>>>> OK, I'm working on it now. There were several problems with your
>>>>>>>>> patches and we are upgrading to LAVA 2017.7.
>>>>>>>>> Before you start please let me know so we don't overlap.
>>>>>>>>
>>>>>>>> It is great to know that. Thank you for your work on Renesas board.
>>>>>>>> I will back to this task next week, if possible please let me know
>>>>>>>> your
>>>>>> status, anything need my support please let me know.
>>>>>>>
>>>>>>> I am preparing the board to boot from the network (tftp), both the
>>>>>>> kernel
>>>>>> and the Project-X file system (a ramdisk).
>>>>>>> Currently the kernel boots fine, but no login console appears.
>>>>>>> # Note, the same file system installed on the SD Card has no
>>>>>>> problems
>>>>>>>
>>>>>>> This are a few things I had to modify:
>>>>>>> - kernel configuration
>>>>>>>      CONFIG_BLK_DEV_RAM=y
>>>>>>>      CONFIG_BLK_DEV_RAM_COUNT=8
>>>>>>>      CONFIG_BLK_DEV_RAM_SIZE=102400
>>>>>>>
>>>>>>> - ramdisk
>>>>>>>       # mkdir ramdisk
>>>>>>>       # cd ramdisk/
>>>>>>>       # tar xvf ../iwg20m/core-image-minimal-iwg20m.tar.gz
>>>>>>>       # ln -s /sbin/init .
>>>>>>>       # find . | cpio --create --format='newc' > /tmp/newinitrd
>>>>>>>       # gzip /tmp/newinitrd
>>>>>>>       # mkimage  -A arm -T ramdisk -C gzip -d /tmp/newinitrd.gz uRamdisk
>>>>>>>       # mv uRamdisk /var/lib/tftpboot/
>>>>>>>
>>>>>>> - u-boot settings
>>>>>>>         iWave-G20M > setenv ramdisk_addr 0x41000000
>>>>>>>         iWave-G20M > setenv ramdisk_file uRamdisk
>>>>>>>         iWave-G20M > setenv bootm_low 0x44000000
>>>>>>>         iWave-G20M > setenv bootm_size 0x3000000
>>>>>>>         iWave-G20M > setenv bootargs_ramdisk setenv bootargs
>>>>>> ${bootargs_base} root=/dev/ram rootwait rw
>>>>>>>         iWave-G20M > setenv bootcmd_tftpboot 'run bootargs_ramdisk;run
>>>>>>> fdt_check;tftpboot ${loadaddr} ${kernel};tftpboot ${fdt_addr}
>>>>>> ${fdt_file};tftpboot ${ramdisk_addr} ${ramdisk_file};bootm ${loadaddr}
>>>>>> ${ramdisk_addr} ${fdt_addr}'
>>>>>>>         iWave-G20M > saveenv
>>>>>>>         iWave-G20M > run bootcmd_tftpboot
>>>>>>>
>>>>>>> I send you the bootlog attached as well.
>>>>>>>
>>>>>>> If you have any hint about the possible solution please let me know.
>>>>>>
>>>>>> OK, I solved it.
>>>>>> It seems that the dev folder wasn't being populated properly on the
>>>>>> ramdisk so I made it work with mdev.
>>>>>>
>>>>>> Now that I have a network deployment environment I will try running a
>>>>>> test on LAVA and see if it works this time.
>>>>
>>>> It is great that you could fix the issue.
>>>> Hope that your test run well. if you meet other issue and need my support, please let me know.
>>>>
>>>>>
>>>>> I'm glad that you managed to resolve the problem. Thank you for the update.
>>>>>
>>>>> Kind regards, Chris
>>>>
>>>> Best regards,
>>>> Binh Nguyen
>>>
>>>
>>>
>>> _______________________________________________
>>> cip-dev mailing list
>>> cip-dev at lists.cip-project.org
>>> https://lists.cip-project.org/mailman/listinfo/cip-dev
>>>
>>
>> --
>> Agustin Benito Bethencourt
>> Principal Consultant - FOSS at Codethink
>> agustin.benito at codethink.co.uk
>
>
>
>

-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
