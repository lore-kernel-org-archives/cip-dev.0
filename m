From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Fri, 30 Aug 2019 07:26:19 +0000
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 00/41] Fast forward sh-pfc
In-Reply-To: <20190829223526.GB31270@amd>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<20190829081221.GD10041@amd>
	<TY1PR01MB1770129C698AAE461CFCE4FDC0A20@TY1PR01MB1770.jpnprd01.prod.outlook.com>
	<20190829094751.GB20258@amd>
	<TY1PR01MB1770F6AE638C3F42AF85A480C0A20@TY1PR01MB1770.jpnprd01.prod.outlook.com>
	<TYAPR01MB228547C1D35538FE0A074410B7A20@TYAPR01MB2285.jpnprd01.prod.outlook.com>
	<20190829223526.GB31270@amd>
Message-ID: <TYAPR01MB228594322C02C3BCC71A2A71B7BD0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 29 August 2019 23:35
>
> Hi!
>
> > > > > Since nothing nasty was spotted during code review and it works ok, I
> > > believe
> > > > > merging this series could really help us with future development, so
> yes
> > > > > please, go ahead and merge.
> > > >
> > > > Ok, merged, and pushed out.
> >
> > Our CI is hitting some build errors with the latest v4.19-cip (commit
> b11ac993) with the renesas shmobile_defconfig configurations:
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/283063646
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/283063654
>
> Thanks for report. Applying two patches Ben identified did not do the
> trick; compelete series did.
>
> Let me know if something is still broken.

Looks okay to me.

Thanks, Chris

>
> Best regards,
> ????? ??????? ??????? ??????? ??????? ??????? ??????? ??????? Pavel
> --
> DENX Software Engineering GmbH,????? Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
