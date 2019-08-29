From: pavel@denx.de (Pavel Machek)
Date: Fri, 30 Aug 2019 00:35:26 +0200
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 00/41] Fast forward sh-pfc
In-Reply-To: <TYAPR01MB228547C1D35538FE0A074410B7A20@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<20190829081221.GD10041@amd>
	<TY1PR01MB1770129C698AAE461CFCE4FDC0A20@TY1PR01MB1770.jpnprd01.prod.outlook.com>
	<20190829094751.GB20258@amd>
	<TY1PR01MB1770F6AE638C3F42AF85A480C0A20@TY1PR01MB1770.jpnprd01.prod.outlook.com>
	<TYAPR01MB228547C1D35538FE0A074410B7A20@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <20190829223526.GB31270@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> > > > Since nothing nasty was spotted during code review and it works ok, I
> > believe
> > > > merging this series could really help us with future development, so yes
> > > > please, go ahead and merge.
> > >
> > > Ok, merged, and pushed out.
> 
> Our CI is hitting some build errors with the latest v4.19-cip (commit b11ac993) with the renesas shmobile_defconfig configurations:
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/283063646
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/283063654

Thanks for report. Applying two patches Ben identified did not do the
trick; compelete series did.

Let me know if something is still broken.

Best regards,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190830/64570ad8/attachment.sig>
