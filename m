From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Fri, 6 Jul 2018 13:20:59 +0200
Subject: [cip-dev] Altera CIP branch vs. Denali NAND driver
In-Reply-To: <TYAPR01MB21605130719706B6F02E8F78D7470@TYAPR01MB2160.jpnprd01.prod.outlook.com>
References: <95cf4467-b48b-6a80-931c-a7f664048c6d@siemens.com>
	<TYAPR01MB2160D07D4F9524CBF5A860D0D7470@TYAPR01MB2160.jpnprd01.prod.outlook.com>
	<fd6af125-0a28-d4a5-85cc-13e94778c7be@siemens.com>
	<TYAPR01MB21605130719706B6F02E8F78D7470@TYAPR01MB2160.jpnprd01.prod.outlook.com>
Message-ID: <2426c261-d153-24e3-4ce3-6cbf8f52d7c7@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 2018-07-06 10:53, ???? / KOGUCHI?TAKUO wrote:
> Hi Jan,
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Friday, July 06, 2018 5:06 PM
>>> (2) Bootloader needs to set SPARE_AREA_SKIP_BYTES properly, which is used by denali_hw_init.
>> (I do not remember the actual value off the top of my head). Without this, it resulted in
>> ECC errors as far as I remember.
>>
>> We are using upstream U-boot (Marek sorted out the BSP U-boot
>> differences for us). I suppose you were using the Altera's version,
>> right? Marek, any comment on this tuning?
> Yes. I am using u-boot which came with Altera SoCSDK for the custom boards.
> 
>>
>>>
>>> Regarding to Denali Driver backport, "ignores other NAND drivers" is not a  good idea even
>> for the playground, though I am not quite sure.
>>
>> I know, but this is related to the fact that the backport started as
>> proof-of-concept and targets that single device only so far. This would
>> have to be resolved when we wanted broader use, but it only makes sense
>> if there is interest.
>>
> At lease I am interested.

That's a good start! To help the discussion, I just pushed our
work-in-progress branch here:

http://git.kiszka.org/?p=linux.git;a=shortlog;h=refs/heads/denali-cip-backport

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
