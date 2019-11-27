From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 27 Nov 2019 10:03:46 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 04/17] mmc: renesas-sdhi: make
 renesas_sdhi_sys_dmac main module file
In-Reply-To: <20191126174834.GB30387@duo.ucw.cz>
References: <1574341247-46652-1-git-send-email-biju.das@bp.renesas.com>
 <1574341247-46652-5-git-send-email-biju.das@bp.renesas.com>
 <20191122110321.GF30479@amd>
 <OSBPR01MB2103BFB10F91429B778AEAC9B8450@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <20191126174834.GB30387@duo.ucw.cz>
Message-ID: <OSBPR01MB2103CE263402451395939136B8440@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 4.4.y-cip 04/17] mmc: renesas-sdhi: make
> renesas_sdhi_sys_dmac main module file
> 
> Hi!
> 
> > > There is real code change hidden between the move. Is that
> > > intentional / is that okay thing to do? Unmapping DMA buffers before
> > > the DMA is completed sounds strange.
> > >
> >
> > Looks like to avoid confusion, We need to backport this patch before the
> renaming.
> >
> > 5f07ef8f603ace496ca8c20eef446c5ae7a10474 (mmc: tmio: always unmap
> DMA
> > before waiting for interrupt)
> >
> > What do you think?
> 
> Yes, that is good way forward.

OK. Will send V4.

Regards,
Biju
