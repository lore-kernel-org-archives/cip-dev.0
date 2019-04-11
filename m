From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Thu, 11 Apr 2019 11:01:45 +0200
Subject: [cip-dev] Supported kernel and Debian versions in Isar
In-Reply-To: <OSBPR01MB27743E33CB9ED2B9B5885577E12F0@OSBPR01MB2774.jpnprd01.prod.outlook.com>
References: <OSBPR01MB27743E33CB9ED2B9B5885577E12F0@OSBPR01MB2774.jpnprd01.prod.outlook.com>
Message-ID: <a3ddd6c7-799b-001f-e134-752766536744@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 11.04.19 10:33, kazuhiro3.hayashi at toshiba.co.jp wrote:
> Hello Jan,
> 
> Do you have any policies about the version combinations of CIP kernel and Debian supported in Isar?
> 
> Currently, Isar seems to support 4.4 CIP + stretch/buster:
> https://github.com/ilbers/isar/blob/master/meta-isar/recipes-kernel/linux/linux-cip_4.4.166-cip29.bb

That's just an example for a custom kernel recipe.

> https://github.com/ilbers/isar/blob/master/doc/user_manual.md#getting-started
> 
> isar-cip-core additionally supports 4.19:
> https://gitlab.com/cip-project/cip-core/isar-cip-core/tree/master/recipes-kernel/linux
> but "linux-cip" is default to 4.4.
> https://gitlab.com/cip-project/cip-core/isar-cip-core/commit/02fdfbd03ec994d8282de4851293687116a7f311

Yes, that was a conservative choice we should change.

> 
> Do you any plans to provide the kernel recipes for all CIP versions (4.4, 4.19, ...) in master branch
> and validate them with all Debian versions?

All (released) versions exist already, validation is the key now. We do not have isar-cip-core hooked up with our test labs yet. I only started artifact generation, but only for the combinations 4.4-rt with BBB and IPC227E. We should add 4.19 as well, and then we need tests. I'm low on bandwidth to look into the test hook-up myself ATM, unfortunately, but I will at least try to finish the uploading (more variants, upload of rootfs as well, not only bootable image - or can the latter be used for LAVA as well?)

> I guess that the supported combinations would be limited to practical ones.
> For examples:
> 	4.4 + stretch => SUPPORTED
> 	4.4 + buster => NOT SUPPORTED
> 	4.4 + bullseye => NOT SUPPORTED
> 	4.19 + stretch => SUPPORTED
> 	4.19 + buster => NOT SUPPORTED
> 	4.19 + bullseye => SUPPORTED(?)

You meant
	4.19 + buster => SUPPORTED
	4.19 + bullseye => SUPPORTED(?)

Yes for buster, specifically when it is released. I don't think we need to rush with the next release then.

Enabling buster should be straightforward, Isar works with it already.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
