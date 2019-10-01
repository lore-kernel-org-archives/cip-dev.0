From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Tue, 1 Oct 2019 18:02:14 +0200
Subject: [cip-dev] Xiling MPSOC -- was Re: CIP IRC weekly meeting today
In-Reply-To: <OSBPR01MB24230274FED8FF03C87AB513A09D0@OSBPR01MB2423.jpnprd01.prod.outlook.com>
References: <HK0PR01MB2979E0408AE1A9C1323DCEFDE2860@HK0PR01MB2979.apcprd01.prod.exchangelabs.com>
	<CAFa_k0gBzv-2bOF_pGbpvZQyQ1ocEu-bsBNT_JsWi12cxrK-Pg@mail.gmail.com>
	<OSBPR01MB24239C49F9038EB86299B8D4A0860@OSBPR01MB2423.jpnprd01.prod.outlook.com>
	<CAFa_k0gKU3eudKOK-txbprBA4=B+9RnJXs5VX18GXxvr2SqPYg@mail.gmail.com>
	<20191001084749.GA1630@amd> <20191001091920.GA2353@amd>
	<OSBPR01MB24230274FED8FF03C87AB513A09D0@OSBPR01MB2423.jpnprd01.prod.outlook.com>
Message-ID: <535aded4-59db-f68d-1b20-3168387027ab@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 01.10.19 14:41, masashi.kudo at cybertrust.co.jp wrote:
> Pavel-san,
> 
> Thanks very much for your quick review and suggestions for the next steps!
> Those are very helpful for us, and should be the basis of the general guideline to contribute such code.

Indeed, creating some guide on how to write acceptable upstream backports would  
be useful.

> Anyway, I will wait for the official approval from the kernel team to move things forward.

For the decision process, I would say the kernel maintainers are first of all in  
charge to decide about accepting a backport set or not. If they see noteworthy  
consequences on the additional effort that needs to be spend in maintenance or  
testing (the latter implies a sync with the testing group), they should bring  
this topic forward to the TSC.

Again my proposal to try to get Xilinx folks involved, at technical level ("Did  
we get all dependencies?") as well as management level ("Strategically  
interesting for you and your other customers?"). I'm trying the same with other  
SoC vendors we are working with, and there is progress. At the bare minimum, it  
creates awareness.

Jan

> 
> SZ-san,
> 
> Please let me know if there is anything else I should prepare.
> 
> Best regards,
> --
> M. Kudo
> 
> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, October 1, 2019 6:19 PM
> To: Pavel Machek <pavel@denx.de>
> Cc: ??????CTJ? <masashi.kudo@cybertrust.co.jp>; SZ.Lin at moxa.com; cip-dev at lists.cip-project.org
> Subject: Re: Xiling MPSOC -- was Re: [cip-dev] CIP IRC weekly meeting today
> 
> Hi!
> 
>>> The current work which contains all CIP kernel files is compiled into a tar ball, and I uploaded the ball under the following repository.
>>> https://github.com/masashi910/tmp-cip-xilinx-mpsoc/
>>
>> Thanks, let me take a look.
>>
>> For the record, way to get the files is
> ...
>> I diffed that against v4.19.56; which unfortunately produced unclean
>> diff as it now also includes the -cip changes. I quickly reviewed and
>> hand-edited the diff.
>>
>> I notice this includes staging drivers.
>>
>> +obj-$(CONFIG_XILINX_APF)       += apf/
>> +obj-$(CONFIG_XILINX_FCLK)      += fclk/
>>
>> I believe you should get those reviewed and moved outside of staging
>> before attempting to backport them.
>>
>> Otherwise I don't see anything too scary.
> 
>  From my point of view, I don't see anything that would prevent merge to -cip. Steps to take would be:
> 
> a) Identify minimum usable subset of the patches. That would likely be "whatever is neccessary to get some kind of output on serial console", probably clock, pinctrl, serial, dts.
> 
> b) Verify that support is already in mainline, submit neccessary patches if not.
> 
> c) Add this point it may be useful to start running tests of mainline on your LAVA board.
> 
> d) Probably send a list of patches that will be needed for initial boot.
> 
> e) Start submitting patches for review & merge.
> 
> Thanks and best regards,
> 								Pavel
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
