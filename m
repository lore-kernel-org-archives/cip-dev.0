From: pavel@denx.de (Pavel Machek)
Date: Fri, 20 Dec 2019 09:15:59 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 0/3] Add DU support
In-Reply-To: <OSAPR01MB3667CE946915D631AF73F3E0922D0@OSAPR01MB3667.jpnprd01.prod.outlook.com>
References: <1576767952-15873-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <OSAPR01MB3667CE946915D631AF73F3E0922D0@OSAPR01MB3667.jpnprd01.prod.outlook.com>
Message-ID: <20191220081559.GA24208@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> > This patch series add DU support for iWave iwg20d platform based on RZ/G1N.
> > 
> > This patch series is based on linux-4.4.y-cip and all the patches in this
> > series are cherry-picked from upstream.
> > 
> > Biju Das (3):
> >   dt-bindings: display: renesas: du: Document the r8a7744 bindings
> >   drm: rcar-du: Add R8A7744 support
> >   ARM: dts: r8a7744: Add DU support
> > 
> >  Documentation/devicetree/bindings/display/renesas,du.txt |  2 ++
> >  arch/arm/boot/dts/r8a7744.dtsi                           | 10
> > +++++++++-
> >  drivers/gpu/drm/rcar-du/rcar_du_drv.c                    |  3 ++-
> >  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> Looks good to me these patches.
> If other reviewer have no opinion, I will apply this series.

Looks good to me, too. Go ahead :-).
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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191220/5ef2b6f3/attachment.sig>
