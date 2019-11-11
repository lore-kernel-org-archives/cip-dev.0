From: sz.lin@moxa.com (=?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?=)
Date: Mon, 11 Nov 2019 22:59:52 +0800
Subject: [cip-dev] Build fail for linux-4.4.y-rc
In-Reply-To: <HK0PR01MB3521F7B55D2D37D84E963FA1FA740@HK0PR01MB3521.apcprd01.prod.exchangelabs.com>
References: <TYAPR01MB2285C54E0BFE44F1970EFA7DB7740@TYAPR01MB2285.jpnprd01.prod.outlook.com>
	<20191111094226.GA15737@amd> <20191111134737.GA23643@amd>
	<HK0PR01MB3521F7B55D2D37D84E963FA1FA740@HK0PR01MB3521.apcprd01.prod.exchangelabs.com>
Message-ID: <CAFk6z8PfZCa3PyjnToK=nNe=MSpdLvZPghV_9vp7drUjGOFSxg@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

Johnson CH Chen (???) <JohnsonCH.Chen@moxa.com> ? 2019?11?11? ?? ??9:53???
>
> Hi Pavel,
>
> Could you set ?RTC_DRV_DS1374_WDT=y? in moxa_mxc_defconfig and then build again?

Let's wait for the reply from author :-)

Apart from that, please send the MR via gitlab [1] if you want to
modify the kernel configuration.

[1] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config

SZ

>
> I can build uImage and kernel modules successfully with Linux 4.4.201-rc1 in my local part.
>
> Thanks,
> Johnson
>
> ?? iOS ? Outlook
> ________________________________
> ???: cip-dev-bounces at lists.cip-project.org <cip-dev-bounces@lists.cip-project.org> ?? Pavel Machek <pavel@denx.de>
> ????: Monday, November 11, 2019 9:47:37 PM
> ???: Pavel Machek <pavel@denx.de>
> ??: cip-dev at lists.cip-project.org <cip-dev@lists.cip-project.org>
> ??: Re: [cip-dev] Build fail for linux-4.4.y-rc
>
> Hi!
>
> > > I've seen a failure this morning with our linux stable-rc build testing.
> > >
> > > Version: 4cb9b88c651a2fff886dd64b6d797343e7ddb4dd Linux 4.4.201-rc1
> > > Arch: arm
> > > Config: moxa_mxc_defconfig
> > >
> > > Pipeline: https://gitlab.com/cip-playground/linux-stable-rc-ci/pipelines/95016985
> > > Failure: https://gitlab.com/cip-playground/linux-stable-rc-ci/pipelines/95016985/failures
> > > Log: https://gitlab.com/cip-playground/linux-stable-rc-ci/-/jobs/346974180
> > > Config: https://gitlab.com/cip-playground/linux-stable-rc-ci/-/jobs/346974180
> > >
> > > All other configurations that we build were successful.
> >
> > Thanks for heads-up!
> >
> > I see warning during configuration:
> >
> > HOSTLD  scripts/kconfig/conf
> > arch/arm/configs/moxa_mxc_defconfig:745:warning: symbol value 'm'
> > invalid for RTC_DRV_DS1374_WDT
> > #
>
> This one seems to be reponsible. I have mailed author & lists...
> .
>
> commit df82285ab4b974f2040f31dbabdd11e055a282c2
> Author: Mel Gorman <mgorman@techsingularity.net>
> Date:   Tue Nov 5 21:16:27 2019 -0800
>
>     mm, meminit: recalculate pcpu batch and high limits after init
>     completes
>
>  commit 3e8fc0075e24338b1117cdff6a79477427b8dbed upstream.
>
> Best regards,
>                                                                 Pavel
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
