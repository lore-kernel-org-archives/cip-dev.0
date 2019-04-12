From: kazuhiro3.hayashi@toshiba.co.jp (kazuhiro3.hayashi at toshiba.co.jp)
Date: Fri, 12 Apr 2019 06:05:20 +0000
Subject: [cip-dev] Supported kernel and Debian versions in Isar
In-Reply-To: <4ca0a48f-b728-b7af-eb78-c57f3bf71840@siemens.com>
References: <OSBPR01MB27743E33CB9ED2B9B5885577E12F0@OSBPR01MB2774.jpnprd01.prod.outlook.com>
	<a3ddd6c7-799b-001f-e134-752766536744@siemens.com>
	<OSBPR01MB2774CEC142FC42D93728BD65E12F0@OSBPR01MB2774.jpnprd01.prod.outlook.com>
	<4ca0a48f-b728-b7af-eb78-c57f3bf71840@siemens.com>
Message-ID: <OSBPR01MB27743C65D403FD9027F2CCF9E1280@OSBPR01MB2774.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org


> -----Original Message-----
> From: Jan Kiszka [mailto:jan.kiszka at siemens.com]
> Sent: Thursday, April 11, 2019 9:15 PM
> To: hayashi kazuhiro(? ?? ????????)
> <kazuhiro3.hayashi@toshiba.co.jp>
> Cc: cip-dev at lists.cip-project.org
> Subject: Re: Supported kernel and Debian versions in Isar
> 
> On 11.04.19 13:39, kazuhiro3.hayashi at toshiba.co.jp wrote:
> > Hi,
> >
> >> -----Original Message-----
> >> From: Jan Kiszka [mailto:jan.kiszka at siemens.com]
> >> Sent: Thursday, April 11, 2019 6:02 PM
> >> To: hayashi kazuhiro(? ?? ????????)
> >> <kazuhiro3.hayashi@toshiba.co.jp>
> >> Cc: cip-dev at lists.cip-project.org
> >> Subject: Re: Supported kernel and Debian versions in Isar
> >>
> >> On 11.04.19 10:33, kazuhiro3.hayashi at toshiba.co.jp wrote:
> >>> Hello Jan,
> >>>
> >>> Do you have any policies about the version combinations of CIP kernel
> >> and Debian supported in Isar?
> >>>
> >>> Currently, Isar seems to support 4.4 CIP + stretch/buster:
> >>>
> >>
> https://github.com/ilbers/isar/blob/master/meta-isar/recipes-kernel/li
> >> nux/linux-cip_4.4.166-cip29.bb
> >>
> >> That's just an example for a custom kernel recipe.
> >>
> >>>
> >>
> https://github.com/ilbers/isar/blob/master/doc/user_manual.md#getting-
> >> started
> >>>
> >>> isar-cip-core additionally supports 4.19:
> >>>
> >>
> https://gitlab.com/cip-project/cip-core/isar-cip-core/tree/master/reci
> >> pes-kernel/linux
> >>> but "linux-cip" is default to 4.4.
> >>>
> >>
> https://gitlab.com/cip-project/cip-core/isar-cip-core/commit/02fdfbd03
> >> ec994d8282de4851293687116a7f311
> >>
> >> Yes, that was a conservative choice we should change.
> >
> > OK.
> > I would like to confirm the meaning of "change" (override or add) in the
> following questions.
> >
> 
> I mean: Set the default to 4.19, leave an option (e.g. a kas config fragment)
> to switch back to 4.4.
> 
> >>
> >>>
> >>> Do you any plans to provide the kernel recipes for all CIP versions
> (4.4,
> >> 4.19, ...) in master branch
> >>> and validate them with all Debian versions?
> >>
> >> All (released) versions exist already, validation is the key now. We
> do
> >> not have isar-cip-core hooked up with our test labs yet. I only started
> >> artifact generation, but only for the combinations 4.4-rt with BBB and
> >> IPC227E. We should add 4.19 as well, and then we need tests. I'm low
> on
> >> bandwidth to look into the test hook-up myself ATM, unfortunately, but
> I
> >> will at least try to finish the uploading (more variants, upload of rootfs
> >> as well, not only bootable image - or can the latter be used for LAVA
> as
> >> well?)
> >
> > Thank you for the information.
> > The current Debian version used in the above testing is stretch?
> > After the buster released, are you planning to validate all of the
> followings with isar-cip-core?
> >
> > 4.4-rt + stretch + BBB/ IPC227E
> > 4.19-rt + stretch + BBB/ IPC227E
> > 4.4-rt + buster + BBB/ IPC227E
> > 4.19-rt + buster + BBB/ IPC227E
> 
> That would be the plan. Of course, the more variables we add, the more we
> need to think about designing our test matrix, rather than just fully
> populating it.

I also want to consider the test matrix (for the both generic and tiny profiles) and
share the current state with CIP developers so that we can easily understand
which combinations are now tested and which ones we can contribute.
I would like to summarize such information later.

> 
> >
> >>
> >>> I guess that the supported combinations would be limited to practical
> >> ones.
> >>> For examples:
> >>> 	4.4 + stretch => SUPPORTED
> >>> 	4.4 + buster => NOT SUPPORTED
> >>> 	4.4 + bullseye => NOT SUPPORTED
> >>> 	4.19 + stretch => SUPPORTED
> >>> 	4.19 + buster => NOT SUPPORTED
> >>> 	4.19 + bullseye => SUPPORTED(?)
> >>
> >> You meant
> >> 	4.19 + buster => SUPPORTED
> >> 	4.19 + bullseye => SUPPORTED(?)
> >>
> >> Yes for buster, specifically when it is released. I don't think we need
> >> to rush with the next release then.
> >
> > OK.
> > What do you think about the targets of validation in future?
> >
> > In Isar, we can choose any Debian versions available in
> > https://github.com/ilbers/isar/tree/master/meta/conf/distro (now
> stretch & buster)
> > In isar-cip-core, we can choose any kernel versions available in
> >
> https://gitlab.com/cip-project/cip-core/isar-cip-core/tree/master/reci
> pes-kernel/linux
> > but now isar-cip-core only provides one version combination specified
> by
> >
> https://gitlab.com/cip-project/cip-core/isar-cip-core/blob/master/conf
> /distro/cip-core.conf
> > When the new CIP kernel version or Debian version released,
> > will isar-cip-core overriede "distro/cip-core.conf" for the specific
> version combination and validate?
> > e.g. 4.4 + stretch => 4.19 + buster => 5.xx + bullseye => ...
> > or, will add new files like "cip-core_2.conf", "cip-core_3.conf", ...
> to provide multiple version combinations?
> > e.g.
> > 	cip-core.conf: 4.4 + stretch
> > 	cip-core_2.conf: 4.19 + buster
> > 	cip-core_3.conf: 5.xx + bullseye
> > 	...
> >
> 
> As I said above, we will soon hit a point we will have to reduce our test
> matrix again and rely on some version being indirectly tested via a similar
> combination. E.g. if you test all generic features of a kernel version
> against a specific Debian version on a specific board, the chances are fairly
> high that those will also work on other boards. So the need to test all
> Debian versions on all boards is rather low.

Agreed.
It would be nice if the verified version combinations + target board
and what kind of test cases are used for these verifications.
For example, if I've tested LTP with 4.19+buster+BBB,
people who see the test matrix might be able to know at least
the basic APIs of 4.19+buster has been verified for other boards.

> 
> >>
> >> Enabling buster should be straightforward, Isar works with it already.
> >
> > Great, how can I know that the buster is officially enabled in
> isar-cip-core?
> 
> When someone writes the patch(es) :). It's kas magic, I don't think we need
> more.

I'm interested in what kind of variables is appropriate to provide the "options" with kas.
The most simple way I can guess is that:

* Provide another distro conf (e.g. cip-core_4.19_buster.conf) with the followings
	require conf/distro/debian-buster.conf
	...
	PREFERRED_VERSION_linux-cip ?= "4.19.%"
	PREFERRED_VERSION_linux-cip-rt ?= "4.19.%"
	...
* Change the default "distro" in kas.yml
	-distro: cip-core
	+distro: cip-core_4.19_buster
* The current combination (4.4 + stretch) still available by setting
	KAS_DISTRO="cip-core" (or should be renamed to "cip-core_4.4_stretch" ?)

If no objections or other ideas, I would like to create a simple patch to do that.

In addition, I'm also interested in the appropriate name for "distro"
because I'm just considering the branch name for the tiny profile (deby).
My first idea is the above. After it's decided,,
we can share the common names for specifying the version combinations between the both profiles.

Kazu

> 
> Jan
> 
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
