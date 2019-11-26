From: pavel@denx.de (Pavel Machek)
Date: Tue, 26 Nov 2019 18:48:34 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 04/17] mmc: renesas-sdhi: make
 renesas_sdhi_sys_dmac main module file
In-Reply-To: <OSBPR01MB2103BFB10F91429B778AEAC9B8450@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1574341247-46652-1-git-send-email-biju.das@bp.renesas.com>
 <1574341247-46652-5-git-send-email-biju.das@bp.renesas.com>
 <20191122110321.GF30479@amd>
 <OSBPR01MB2103BFB10F91429B778AEAC9B8450@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Message-ID: <20191126174834.GB30387@duo.ucw.cz>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> > There is real code change hidden between the move. Is that intentional / is
> > that okay thing to do? Unmapping DMA buffers before the DMA is
> > completed sounds strange.
> > 
> 
> Looks like to avoid confusion, We need to backport this patch before the renaming.
> 
> 5f07ef8f603ace496ca8c20eef446c5ae7a10474 (mmc: tmio: always unmap DMA before waiting for interrupt)
> 
> What do you think?

Yes, that is good way forward.

Best regards,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191126/46e94ae0/attachment.sig>
