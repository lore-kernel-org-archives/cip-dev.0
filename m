From: kazuhiro3.hayashi@toshiba.co.jp (kazuhiro3.hayashi at toshiba.co.jp)
Date: Thu, 11 Apr 2019 08:33:23 +0000
Subject: [cip-dev] Supported kernel and Debian versions in Isar
Message-ID: <OSBPR01MB27743E33CB9ED2B9B5885577E12F0@OSBPR01MB2774.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Jan,

Do you have any policies about the version combinations of CIP kernel and Debian supported in Isar?

Currently, Isar seems to support 4.4 CIP + stretch/buster:
https://github.com/ilbers/isar/blob/master/meta-isar/recipes-kernel/linux/linux-cip_4.4.166-cip29.bb
https://github.com/ilbers/isar/blob/master/doc/user_manual.md#getting-started

isar-cip-core additionally supports 4.19:
https://gitlab.com/cip-project/cip-core/isar-cip-core/tree/master/recipes-kernel/linux
but "linux-cip" is default to 4.4.
https://gitlab.com/cip-project/cip-core/isar-cip-core/commit/02fdfbd03ec994d8282de4851293687116a7f311

Do you any plans to provide the kernel recipes for all CIP versions (4.4, 4.19, ...) in master branch
and validate them with all Debian versions?
I guess that the supported combinations would be limited to practical ones.
For examples:
	4.4 + stretch => SUPPORTED
	4.4 + buster => NOT SUPPORTED
	4.4 + bullseye => NOT SUPPORTED
	4.19 + stretch => SUPPORTED
	4.19 + buster => NOT SUPPORTED
	4.19 + bullseye => SUPPORTED(?)
	...

As the background, please refer to the following discussion if you need:
https://lists.cip-project.org/pipermail/cip-dev/2019-April/002074.html

Regards,
Kazu
