From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Thu, 11 Apr 2019 14:15:13 +0200
Subject: [cip-dev] Supported kernel and Debian versions in Isar
In-Reply-To: <OSBPR01MB2774CEC142FC42D93728BD65E12F0@OSBPR01MB2774.jpnprd01.prod.outlook.com>
References: <OSBPR01MB27743E33CB9ED2B9B5885577E12F0@OSBPR01MB2774.jpnprd01.prod.outlook.com>
	<a3ddd6c7-799b-001f-e134-752766536744@siemens.com>
	<OSBPR01MB2774CEC142FC42D93728BD65E12F0@OSBPR01MB2774.jpnprd01.prod.outlook.com>
Message-ID: <4ca0a48f-b728-b7af-eb78-c57f3bf71840@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 11.04.19 13:39, kazuhiro3.hayashi at toshiba.co.jp wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Jan Kiszka [mailto:jan.kiszka at siemens.com]
>> Sent: Thursday, April 11, 2019 6:02 PM
>> To: hayashi kazuhiro(? ?? ????????)
>> <kazuhiro3.hayashi@toshiba.co.jp>
>> Cc: cip-dev at lists.cip-project.org
>> Subject: Re: Supported kernel and Debian versions in Isar
>>
>> On 11.04.19 10:33, kazuhiro3.hayashi at toshiba.co.jp wrote:
>>> Hello Jan,
>>>
>>> Do you have any policies about the version combinations of CIP kernel
>> and Debian supported in Isar?
>>>
>>> Currently, Isar seems to support 4.4 CIP + stretch/buster:
>>>
>> https://github.com/ilbers/isar/blob/master/meta-isar/recipes-kernel/li
>> nux/linux-cip_4.4.166-cip29.bb
>>
>> That's just an example for a custom kernel recipe.
>>
>>>
>> https://github.com/ilbers/isar/blob/master/doc/user_manual.md#getting-
>> started
>>>
>>> isar-cip-core additionally supports 4.19:
>>>
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/tree/master/reci
>> pes-kernel/linux
>>> but "linux-cip" is default to 4.4.
>>>
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/commit/02fdfbd03
>> ec994d8282de4851293687116a7f311
>>
>> Yes, that was a conservative choice we should change.
> 
> OK.
> I would like to confirm the meaning of "change" (override or add) in the following questions.
> 

I mean: Set the default to 4.19, leave an option (e.g. a kas config fragment) to switch back to 4.4.

>>
>>>
>>> Do you any plans to provide the kernel recipes for all CIP versions (4.4,
>> 4.19, ...) in master branch
>>> and validate them with all Debian versions?
>>
>> All (released) versions exist already, validation is the key now. We do
>> not have isar-cip-core hooked up with our test labs yet. I only started
>> artifact generation, but only for the combinations 4.4-rt with BBB and
>> IPC227E. We should add 4.19 as well, and then we need tests. I'm low on
>> bandwidth to look into the test hook-up myself ATM, unfortunately, but I
>> will at least try to finish the uploading (more variants, upload of rootfs
>> as well, not only bootable image - or can the latter be used for LAVA as
>> well?)
> 
> Thank you for the information.
> The current Debian version used in the above testing is stretch?
> After the buster released, are you planning to validate all of the followings with isar-cip-core?
> 
> 4.4-rt + stretch + BBB/ IPC227E
> 4.19-rt + stretch + BBB/ IPC227E
> 4.4-rt + buster + BBB/ IPC227E
> 4.19-rt + buster + BBB/ IPC227E

That would be the plan. Of course, the more variables we add, the more we need to think about designing our test matrix, rather than just fully populating it.

> 
>>
>>> I guess that the supported combinations would be limited to practical
>> ones.
>>> For examples:
>>> 	4.4 + stretch => SUPPORTED
>>> 	4.4 + buster => NOT SUPPORTED
>>> 	4.4 + bullseye => NOT SUPPORTED
>>> 	4.19 + stretch => SUPPORTED
>>> 	4.19 + buster => NOT SUPPORTED
>>> 	4.19 + bullseye => SUPPORTED(?)
>>
>> You meant
>> 	4.19 + buster => SUPPORTED
>> 	4.19 + bullseye => SUPPORTED(?)
>>
>> Yes for buster, specifically when it is released. I don't think we need
>> to rush with the next release then.
> 
> OK.
> What do you think about the targets of validation in future?
> 
> In Isar, we can choose any Debian versions available in
> https://github.com/ilbers/isar/tree/master/meta/conf/distro (now stretch & buster)
> In isar-cip-core, we can choose any kernel versions available in
> https://gitlab.com/cip-project/cip-core/isar-cip-core/tree/master/recipes-kernel/linux
> but now isar-cip-core only provides one version combination specified by
> https://gitlab.com/cip-project/cip-core/isar-cip-core/blob/master/conf/distro/cip-core.conf
> When the new CIP kernel version or Debian version released,
> will isar-cip-core overriede "distro/cip-core.conf" for the specific version combination and validate?
> e.g. 4.4 + stretch => 4.19 + buster => 5.xx + bullseye => ...
> or, will add new files like "cip-core_2.conf", "cip-core_3.conf", ... to provide multiple version combinations?
> e.g.
> 	cip-core.conf: 4.4 + stretch
> 	cip-core_2.conf: 4.19 + buster
> 	cip-core_3.conf: 5.xx + bullseye
> 	...
> 

As I said above, we will soon hit a point we will have to reduce our test matrix again and rely on some version being indirectly tested via a similar combination. E.g. if you test all generic features of a kernel version against a specific Debian version on a specific board, the chances are fairly high that those will also work on other boards. So the need to test all Debian versions on all boards is rather low.

>>
>> Enabling buster should be straightforward, Isar works with it already.
> 
> Great, how can I know that the buster is officially enabled in isar-cip-core?

When someone writes the patch(es) :). It's kas magic, I don't think we need more.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
