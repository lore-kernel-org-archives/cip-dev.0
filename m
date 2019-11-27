From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 27 Nov 2019 10:03:01 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 03/17] mmc: renesas-sdhi: rename
 sh_mobile_sdhi.c => renesas_sdhi_core.c
In-Reply-To: <20191126174758.GA30387@duo.ucw.cz>
References: <1574341247-46652-1-git-send-email-biju.das@bp.renesas.com>
 <1574341247-46652-4-git-send-email-biju.das@bp.renesas.com>
 <20191122100917.GD30479@amd>
 <OSBPR01MB21037829719AED4A98989B2EB8450@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <20191126174758.GA30387@duo.ucw.cz>
Message-ID: <OSBPR01MB2103429AEB7B118CA29AE10EB8440@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, November 26, 2019 5:48 PM
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: Pavel Machek <pavel@denx.de>; cip-dev at lists.cip-project.org; Nobuhiro
> Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>; Chris Paterson
> <Chris.Paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>
> Subject: Re: [PATCH 4.4.y-cip 03/17] mmc: renesas-sdhi: rename
> sh_mobile_sdhi.c => renesas_sdhi_core.c
> 
> Hi!
> 
> > Looks like to avoid confusion, We need to backport  the patch
> > 13bbd8af65895c524c27850495fadf23449f9f3d (mmc: sh_mobile_sdhi: don't
> > use array for DT configs) 685d29ef1783af0049c4aeeec43722e410d5845d
> > (mmc: sh_mobile_sdhi: enable SDIO IRQs for RCar Gen3)
> > 2272c841ee301402ea7a01fc727619af1f97f0cc (mmc: sh_mobile_sdhi:
> simplify code for voltage switching) What do you think?
> 
> Yes, that sounds like reasonable way forward.
> 
> > > @@ -511,13 +505,14 @@ static int sh_mobile_sdhi_write16_hook(struct
> > > ...
> > >         case CTL_DMA_ENABLE:
> > >  -               return sh_mobile_sdhi_wait_idle(host);
> > > +       case EXT_ACC:
> > > +               return renesas_sdhi_wait_idle(host)
> > >         }
> > >
> > > (Additional case handled in a switch).
> >
> > Looks like to avoid confusion, We need to backport  the patch
> > 13bbd8af65895c524c27850495fadf23449f9f3d (mmc: sh_mobile_sdhi: don't
> > use array for DT configs) What do you think?
> 
> I looked up 13bbd8af65895c524c27850495fadf23449f9f3d, and it does not
> contain this piece. But yes, backporting patch containing that change will do
> the trick.

sorry it was below patch
ff741cfde98bd867eb4c9477bc9ba0df3507eed8 (mmc: sdhi: Add EXT_ACC register busy check)

Any way will send V4 with this changes.

Regards,
Biju
