From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Fri, 8 Nov 2019 10:32:49 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 00/83] Add RZ/G1C SD/eMMC support
In-Reply-To: <20191107210149.GA26444@amd>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<20191107210149.GA26444@amd>
Message-ID: <TYAPR01MB2285DD15243063CDEA363B91B77B0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 07 November 2019 21:02
>
> Hi!
>
> > This patch series add SD/eMMC support support for RZ/G1C sbc.
> >
> > RZ/G1C eMMC IP is different from other RZ/G1 SoC's. It is having an
> > internal DMA for data transfer which is similar to R-Car Gen3.
> >
> > Support for internal DMAC is added in 4.14 kernel and support for
> > RZ/G1C added on 4.20 kernel.
> >
> > Backported the relevent patches to linux-4.4.y-cip.
> >
> > This patch series is based on linux-4.4.y-cip and all the patches
> > in this series are cherry-picked from linux rc tree.
>
> Thanks for the series. I'm currently reviewing it, I have some
> comments but nothing really bad so far. I'm now around the middle.

Thank you for your work on reviewing this series.

Looking at some of your comments, it looks like there are lots of issues to do with the original patches that were upstreamed, rather than changes that were made specifically for the CIP Kernel.

My understanding is that the CIP project follows an upstream first policy, i.e. code must all be upstreamed before being backported to the CIP kernel(s).

For the changes that you're pointing out, should we be upstreaming the relevant fixes, waiting for them to be released upstream, then re-submitting the whole patch series? Or should we be modifying the patches that we're submitting to the CIP kernel directly?

If the former, I'm not actually sure this will always be technically possible.
If the latter, do you want Biju to update each of the patches in his series? Or submit the new cip-specific changes in a new patch?

Kind regards, Chris

>
> Best regards,
> ????? ??????? ??????? ??????? ??????? ??????? ??????? ??????? Pavel
> --
> DENX Software Engineering GmbH,????? Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
