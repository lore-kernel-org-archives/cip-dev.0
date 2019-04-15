From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 15 Apr 2019 08:10:20 +0000
Subject: [cip-dev] Renesas patches was Re: [PATCH 4.19y 01/10] pinctrl:
 sh-pfc: r8a77990: Add CAN pins, groups and functions
In-Reply-To: <20190412202842.GA3904@amd>
References: <1554126947-32747-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1554126947-32747-2-git-send-email-fabrizio.castro@bp.renesas.com>
	<20190409210354.GF3845141@pollux.denx.de>
	<TY1PR01MB1770D40D7734C44FE892D77CC02E0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
	<TY1PR01MB17708075ACA57D5581AFEE1AC02E0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
	<20190412202842.GA3904@amd>
Message-ID: <TY1PR01MB17704D961FDBDE1C3A8625F6C02B0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 12 April 2019 21:29
> To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Cc: Pavel Machek <pavel@denx.de>; cip-dev at lists.cip-project.org; Biju Das <biju.das@bp.renesas.com>
> Subject: Renesas patches was Re: [cip-dev] [PATCH 4.19y 01/10] pinctrl: sh-pfc: r8a77990: Add CAN pins, groups and functions
> 
> Hi!
> 
> > > > Current status of the tree is at:
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-cip
> > > >
> > > > Could the patches that depend on each other go into one series? If it is
> > > > hard identifying what depends on what, maybe the best way forward is to
> > > > create a big series on top of 64729dc0be4847961550cdcca4ddc66adf556aaa
> > > > with all patches you have pending. Your patches seem to be in good shape,
> > > > so applying it should not be a big deal.
> > >
> > > I went through the emails on the cip-dev mailing list and I could find all the
> > > necessary patches this patch depends on, this patch applies cleanly once
> > > its dependencies have been applied, so perhaps we should do what you are
> > > suggesting, which is sending you another big series to apply on top of the
> > > current branch.
> >
> > Actually, that would create an even bigger confusion at this point, so I am going to wait
> > for you guys to work this out for now.
> 
> Good news -- I believe we managed to sort it out.
> 
> Tree at
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-cip
> 
> should now be up-to-date with your patches. If you could run any
> tests and verify things look sane, it would be great.

Thank you for your efforts! I can confirm all of the patches have been applied and things look sane.

Thanks,
Fab

> 
> Best regards,
> 									Pavel
> 
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
