From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Tue, 12 Nov 2019 07:29:31 +0000
Subject: [cip-dev] Build fail for linux-4.4.y-rc
In-Reply-To: <20191111134737.GA23643@amd>
References: <TYAPR01MB2285C54E0BFE44F1970EFA7DB7740@TYAPR01MB2285.jpnprd01.prod.outlook.com>
	<20191111094226.GA15737@amd> <20191111134737.GA23643@amd>
Message-ID: <TYAPR01MB2285B33B65F68145719362BFB7770@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello all,

> From: Pavel Machek <pavel@denx.de>
> Sent: 11 November 2019 13:48
>
> Hi!
>
> > > I've seen a failure this morning with our linux stable-rc build testing.
> > >
> > > Version: 4cb9b88c651a2fff886dd64b6d797343e7ddb4dd Linux 4.4.201-rc1

Thanks to Pavel's reporting, Greg has now fixed this build issue in Linux 4.4.201-rc2 (ca1d1b5f0f2a).
https://gitlab.com/cip-playground/linux-stable-rc-ci/-/jobs/347861814

Kind regards, Chris

> > > Arch: arm
> > > Config: moxa_mxc_defconfig
> > >
> > > Pipeline: https://gitlab.com/cip-playground/linux-stable-rc-
> ci/pipelines/95016985
> > > Failure: https://gitlab.com/cip-playground/linux-stable-rc-
> ci/pipelines/95016985/failures
> > > Log: https://gitlab.com/cip-playground/linux-stable-rc-ci/-/jobs/346974180
> > > Config: https://gitlab.com/cip-playground/linux-stable-rc-ci/-
> /jobs/346974180
> > >
> > > All other configurations that we build were successful.
> >
> > Thanks for heads-up!
> >
> > I see warning during configuration:
> >
> > HOSTLD? scripts/kconfig/conf
> > arch/arm/configs/moxa_mxc_defconfig:745:warning: symbol value 'm'
> > invalid for RTC_DRV_DS1374_WDT
> > #
>
> This one seems to be reponsible. I have mailed author & lists...
> .
>
> commit df82285ab4b974f2040f31dbabdd11e055a282c2
> Author: Mel Gorman <mgorman@techsingularity.net>
> Date:?? Tue Nov 5 21:16:27 2019 -0800
>
>???? mm, meminit: recalculate pcpu batch and high limits after init
>???? completes
>
>? commit 3e8fc0075e24338b1117cdff6a79477427b8dbed upstream.
>
> Best regards,
> ????? ??????? ??????? ??????? ??????? ??????? ??????? ??????? Pavel
>
> --
> DENX Software Engineering GmbH,????? Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
