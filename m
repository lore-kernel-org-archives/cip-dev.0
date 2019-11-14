From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 14 Nov 2019 16:13:41 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 00/83] Add RZ/G1C SD/eMMC support
In-Reply-To: <20191108195823.GA23750@amd>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<20191107210149.GA26444@amd>
	<TYAPR01MB2285DD15243063CDEA363B91B77B0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
	<20191108113209.GQ1017@amd>
	<OSBPR01MB21039D7435442185F6280EADB87B0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
	<20191108195823.GA23750@amd>
Message-ID: <OSBPR01MB21032A76533C40F71367C4A4B8710@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 4.4.y-cip 00/83] Add RZ/G1C SD/eMMC support
> 
> Hi!
> 
> > > Plus we need to figure out how to review the renames.
> > >
> > > > If the former, I'm not actually sure this will always be technically
> possible.
> > > > If the latter, do you want Biju to update each of the patches in his
> series?
> > > Or submit the new cip-specific changes in a new patch?
> > > >
> > >
> > > Not sure really.
> > >
> > > One possible way forward would be to submit 1..33/ as separate
> > > series, then figure out 34.. first rename, then figure out the rest.
> >
> > OK. I will send 1--33 as a separate series and then rest.
> 
> Actually, it seems that review on 1--33 is "minor updates are possible in
> mainline", so if you want (and there are no other comments from other
> maintainers), I can just take 1--33 and apply them to -cip tree.

Yes please, if other maintainers are happy.

Please apply the below patch patch before 33,
https://patchwork.kernel.org/patch/11232167/

Can you please suggest, how you want to handle rest of the patches?

Regards,
Biju
