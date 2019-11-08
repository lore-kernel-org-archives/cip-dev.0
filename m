From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 8 Nov 2019 13:43:46 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 00/83] Add RZ/G1C SD/eMMC support
In-Reply-To: <20191108113209.GQ1017@amd>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<20191107210149.GA26444@amd>
	<TYAPR01MB2285DD15243063CDEA363B91B77B0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
	<20191108113209.GQ1017@amd>
Message-ID: <OSBPR01MB21039D7435442185F6280EADB87B0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 4.4.y-cip 00/83] Add RZ/G1C SD/eMMC support
> 
> Hi!
> 
> > Thank you for your work on reviewing this series.
> 
> (For the record, I'm now done with the review... with exception of
> renames&modifications in 66-69).
> 
> > Looking at some of your comments, it looks like there are lots of issues to
> do with the original patches that were upstreamed, rather than changes that
> were made specifically for the CIP Kernel.
> >
> > My understanding is that the CIP project follows an upstream first policy,
> i.e. code must all be upstreamed before being backported to the CIP
> kernel(s).
> >
> > For the changes that you're pointing out, should we be upstreaming the
> relevant fixes, waiting for them to be released upstream, then re-submitting
> the whole patch series? Or should we be modifying the patches that we're
> submitting to the CIP kernel directly?
> >
> 
> It really depends on case by case basis -- on severity of the problem.
> 
> I can take explanations, maybe I'm just misunderstanding the code.
> 
> Or perhaps code is really right, but unclear/needs additional comment, etc...
> In such case I guess we can take patch as is, and just queue
> cleanups/comments to the mainline.
> 
> But patch 34/ introduces data corrupting bug, which is only fixed at the end
> of the series. I'd prefer having patches changed / reshuffled / something so
> that it does not corrupt someone's data during bisect.
> 
> Plus we need to figure out how to review the renames.
> 
> > If the former, I'm not actually sure this will always be technically possible.
> > If the latter, do you want Biju to update each of the patches in his series?
> Or submit the new cip-specific changes in a new patch?
> >
> 
> Not sure really.
> 
> One possible way forward would be to submit 1..33/ as separate series, then
> figure out 34.. first rename, then figure out the rest.

OK. I will send 1--33 as a separate series and then rest. 

Regards,
Biju
