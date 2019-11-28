From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 28 Nov 2019 11:21:38 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip] dt-bindings: mmc: renesas_sdhi: Add
 r8a77470 support
In-Reply-To: <20191128111927.GA5634@amd>
References: <1574928934-18465-1-git-send-email-biju.das@bp.renesas.com>
 <20191128111927.GA5634@amd>
Message-ID: <OSBPR01MB21036BD8F829F9AE7CD1C61AB8470@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Thursday, November 28, 2019 11:19 AM
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: cip-dev at lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>;
> Chris Paterson <Chris.Paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>
> Subject: Re: [PATCH 4.4.y-cip] dt-bindings: mmc: renesas_sdhi: Add r8a77470
> support
> 
> Hi!
> 
> > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> >
> > commit be6f8db406a49511a8d213f9443ae79fe5b086c3 upstream.
> >
> > The RZ/G1C (a.k.a. R8A77470) comes with three SDHI interfaces,
> > SDHI0 and SDHI2 are compatible with R-Car Gen2 SDHIs, and
> > SDHI1 is compatible with R-Car Gen3 SDHIs, as it comes with an
> > internal DMAC, therefore SDHI1 is fully compatible with driver
> > renesas_sdhi_internal_dmac driver. As a result, the compatible strings
> > for the R8A77470 SDHI interfaces are a little bit special.
> > Document SDHI support for the RZ/G1C SoC.
> 
> Applied, thank you.
> 
> gitlab is down, but patches should be on kernel.org.
> 
> AFAIU this was last outstanding patch from you, and there's nothing more to
> apply for me, right?

It is correct. No outstanding patches

Regds,
biju
