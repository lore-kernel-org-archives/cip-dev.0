From: trung.huynh.uw@rvc.renesas.com (Trung. Huynh)
Date: Tue, 5 Dec 2017 09:09:00 +0000
Subject: [cip-dev] B@D run on Renesas board - issue
In-Reply-To: <5A205F1A.1040200@codethink.co.uk>
References: <d06c1efd762e425b9fdbc5c263747828@RVC-EX13-M02.rvc.renesas.com>
	<87k1z7nyad.fsf@ctlt579.codethink.co.uk>
	<014601d356a5$9a4349d0$cec9dd70$@toshiba.co.jp>
	<8a55899a02944c42911a1d0ec002d703@RVC-EX13-M02.rvc.renesas.com>
	<008801d35eb2$73f63020$5be29060$@toshiba.co.jp>
	<d279e51b2e1b4d6394b0d77606efac0b@RVC-EX13-M02.rvc.renesas.com>
	<009c01d35eb8$82d1b050$887510f0$@toshiba.co.jp>
	<87mv3ljmb3.fsf@ctlt579.codethink.co.uk>
	<dee93a68610e47209dd15daddc393837@RVC-EX13-M01.rvc.renesas.com>
	<005701d369b0$4bb04480$e310cd80$@toshiba.co.jp>
	<5A205F1A.1040200@codethink.co.uk>
Message-ID: <f93c0e9ee418452da29dce2c5497ba50@RVC-EX13-M01.rvc.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear Daniel,

Once they to become ready for download, please ping me, thank you!

Regards,
Trung

-----Original Message-----
From: cip-dev-bounces@lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Agustin Benito Bethencourt
Sent: Friday, December 1, 2017 2:42 AM
To: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Cc: Binh Thanh. Nguyen <binh.nguyen.uw@rvc.renesas.com>; O365-Toru Oishi <toru.oishi.zj@renesas.com>; cip-dev at lists.cip-project.org
Subject: Re: [cip-dev] B at D run on Renesas board - issue

Hi,

On 29/11/17 23:53, Daniel Sangorrin wrote:
> Hi Trung, Agustin, Robert
>
>> -----Original Message-----
>> From: Trung. Huynh [mailto:trung.huynh.uw at rvc.renesas.com]
>> Sent: Monday, November 27, 2017 7:45 PM
>> To: Robert Marshall; Daniel Sangorrin
>> Cc: Binh Thanh. Nguyen; O365-Toru Oishi; 'Chris Paterson'; 
>> cip-dev at lists.cip-project.org
>> Subject: RE: B at D run on Renesas board - issue
>>
>> Dear Daniel, Robert,
>>
>> Thank for your advices.
>> BTW, could you please give me uImage and device tree file as well as file system you have already built to use in your sample test?
>> I appreciate that.
>
> I was planning to upload them to B at D AWS S3 account, but I haven't received an account yet.
> Agustin: could you try again please? should I send you some information?

I am travelling. Will do it Mon or Tue next week. Sorry about this delay. You should have full access to S3.

> Robert: should I send the patches again to make sure that everyone is running the same code?
>
> Best regards,
> Daniel
>
>> -----Original Message-----
>> From: Robert Marshall [mailto:robert.marshall at codethink.co.uk]
>> Sent: Friday, November 17, 2017 4:18 PM
>> To: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
>> Cc: Trung. Huynh <trung.huynh.uw@rvc.renesas.com>; Binh Thanh. Nguyen 
>> <binh.nguyen.uw@rvc.renesas.com>; O365-Toru Oishi 
>> <toru.oishi.zj@renesas.com>; 'Chris Paterson' 
>> <Chris.Paterson2@renesas.com>; cip-dev at lists.cip-project.org
>> Subject: Re: B at D run on Renesas board - issue
>>
>> Hi
>>
>> "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp> writes:
>>
>>> Dear Trung san
>>>
>>>> -----Original Message-----
>>>> From: Trung. Huynh [mailto:trung.huynh.uw at rvc.renesas.com]
>>>> Sent: Thursday, November 16, 2017 5:49 PM
>>>> To: Daniel Sangorrin; 'Robert Marshall'; Binh Thanh. Nguyen
>>>> Cc: O365-Toru Oishi; 'Chris Paterson'; 
>>>> cip-dev at lists.cip-project.org
>>>> Subject: RE: B at D run on Renesas board - issue
>>>>
>>>> Dear Daniel,
>>>>
>>>> Thank for your reply.
>>>> The log in attachment is took from lava for easily observing instead of html page.
>>>> Regarding deploy section, YES, as you can see the log showing that 
>>>> has passed over it already to get into test section.
>>>>
>>>> Is there anything going wrong?
>>>> Looking for your feedback
>>>>
>>>
>>> It seems that you are not booting from a ramdisk, but rather the rootfs installed on the eMMC or SD Card.
>>>
>>
>> It would be useful to see the test yaml as it is now, but looking back in the thread the original has in the boot section:
>>
>>      commands: sd
>>
>> you should change that to
>>
>>      commands: ramdisk
>>
>> Robert
>>
>>> Regards,
>>> Daniel
>>>
>>>> Best Regards,
>>>> Trung
>>>>
>>>> -----Original Message-----
>>>> From: Daniel Sangorrin [mailto:daniel.sangorrin at toshiba.co.jp]
>>>> Sent: Thursday, November 16, 2017 3:11 PM
>>>> To: Trung. Huynh <trung.huynh.uw@rvc.renesas.com>; 'Robert Marshall'
>>>> <robert.marshall@codethink.co.uk>; Binh Thanh. Nguyen 
>>>> <binh.nguyen.uw@rvc.renesas.com>
>>>> Cc: O365-Toru Oishi <toru.oishi.zj@renesas.com>; 'Chris Paterson'
>>>> <Chris.Paterson2@renesas.com>; cip-dev at lists.cip-project.org
>>>> Subject: RE: B at D run on Renesas board - issue
>>>>
>>>> Dear Trung san,
>>>>
>>>>> -----Original Message-----
>>>>> From: Trung. Huynh [mailto:trung.huynh.uw at rvc.renesas.com]
>>>>> Sent: Wednesday, November 15, 2017 7:21 PM
>>>>> To: Daniel Sangorrin; 'Robert Marshall'; Binh Thanh. Nguyen
>>>>> Cc: O365-Toru Oishi; 'Chris Paterson'; 
>>>>> cip-dev at lists.cip-project.org
>>>>> Subject: RE: B at D run on Renesas board - issue
>>>>>
>>>>> Hi Daniel, Robert,
>>>>>
>>>>> We got into test section already, but have no idea why it attempts to execute the thing non-exist at all:
>>>>> # /lava-237/bin/lava-test-runner /lava-237/0 as you can see our 
>>>>> error log in attachment.
>>>>> I also take example log over here
>>>>> https://gitlab.com/snippets/1679749
>>>>> to see that it can create a directory by mkdir /lava-1
>>>>>
>>>>> Could you please tell us what does it make scene? How can we fix it?
>>>>> Thank you.
>>>>
>>>> Please could you send the complete log?
>>>>
>>>>> P/S: healthcheck script same as Binh-san attached to you before
>>>>
>>>> Did you make sure to uncomment the deploy section?
>>>>
>>>> Regards,
>>>> Daniel
>>>>
>>>>>
>>>>> Best Regards,
>>>>> Trung
>>>>>
>>>>> -----Original Message-----
>>>>> From: Daniel Sangorrin [mailto:daniel.sangorrin at toshiba.co.jp]
>>>>> Sent: Monday, November 6, 2017 9:19 AM
>>>>> To: 'Robert Marshall' <robert.marshall@codethink.co.uk>; Binh Thanh.
>>>>> Nguyen <binh.nguyen.uw@rvc.renesas.com>
>>>>> Cc: O365-Toru Oishi <toru.oishi.zj@renesas.com>; 'Chris Paterson'
>>>>> <Chris.Paterson2@renesas.com>; Trung. Huynh 
>>>>> <trung.huynh.uw@rvc.renesas.com>; cip-dev at lists.cip-project.org
>>>>> Subject: RE: B at D run on Renesas board - issue
>>>>>
>>>>> Hello Binh-san,
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Robert Marshall [mailto:robert.marshall at codethink.co.uk]
>>>>>> Sent: Saturday, November 04, 2017 1:05 AM
>>>>>> To: Binh Thanh. Nguyen
>>>>>> Cc: Daniel Sangorrin; O365-Toru Oishi; Chris Paterson; Trung.
>>>>>> Huynh; cip-dev at lists.cip-project.org
>>>>>> Subject: Re: B at D run on Renesas board - issue
>>>>>>
>>>>>> "Binh Thanh. Nguyen" <binh.nguyen.uw@rvc.renesas.com> writes:
>>>>>>
>>>>>>> Hello Daniel, Robert,
>>>>>>>
>>>>>>> We are facing an issue when trying to run healthcheck using B at D on Renesas board.
>>>>>>> I would like to attach the log and the healthcheck script (we 
>>>>>>> modified the healthcheck from Daniel)
>>>>>>>
>>>>>>> The boot action was passed, but after that, look like LAVA 
>>>>>>> cannot send command to Board, only send "#" (it supposed to be "uname").
>>>>>>> I wonder if you met same issue before?
>>>>>>> And if possible, please give us any hints you may have for debugging this issue!
>>>>>>>
>>>>>>> Best regards,
>>>>>>> Binh Nguyen
>>>>>>
>>>>>> Thanh
>>>>>>
>>>>>> Sorry for the delay in responding!
>>>>>>
>>>>>> That test is missing a deploy section (all commented out) are you 
>>>>>> trying to make the test too minimal? LAVA tends to swallow output 
>>>>>> if it is what is expected.
>>>>>>
>>>>>> Robert
>>>>>
>>>>> As Robert said, please do not comment out the deploy section. LAVA 
>>>>> does not just deploy the binaries as they are, it also copies some 
>>>>> scripts (LAVA Test shell) into the ramdisk (or network filesystem).
>>>>> # LAVA does not use scp (or a serial protocol) to copy them into 
>>>>> the target
>>>>>
>>>>> For deploying you need a PDU (remote power switch). If you don't 
>>>>> have one you need to buy one and then add the corresponding commands.
>>>>> # Note: I use an IP Power 9258 remote PDU.
>>>>> # Note: do not think you can get around without a PDU*
>>>>>
>>>>> Thanks,
>>>>> Daniel
>>>>>
>>>>> *There are ways to do it but they have limitations 
>>>>> https://validation.linaro.org/static/docs/v2/dispatcher-design.htm
>>>>> l
>>>>> #pr
>>>>> imary-
>>>>> connection
>>>>>
>>>>>
>>>>>
>>>>>
>>>>
>>>>
>
>
>
>


--
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink agustin.benito at codethink.co.uk _______________________________________________
cip-dev mailing list
cip-dev at lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
