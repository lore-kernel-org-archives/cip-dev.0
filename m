From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Mon, 23 Dec 2019 02:16:24 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 0/3] Add DU support
In-Reply-To: <20191220081559.GA24208@amd>
References: <1576767952-15873-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <OSAPR01MB3667CE946915D631AF73F3E0922D0@OSAPR01MB3667.jpnprd01.prod.outlook.com>
 <20191220081559.GA24208@amd>
Message-ID: <OSAPR01MB3667C58E140CA265676E63D8922E0@OSAPR01MB3667.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

> -----Original Message-----
> From: Pavel Machek [mailto:pavel at denx.de]
> Sent: Friday, December 20, 2019 5:16 PM
> To: iwamatsu nobuhiro(?? ?? ????????)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: marian-cristian.rotariu.rb at bp.renesas.com;
> cip-dev at lists.cip-project.org; pavel at denx.de;
> chris.paterson2 at renesas.com; biju.das at bp.renesas.com;
> fabrizio.castro at bp.renesas.com
> Subject: Re: [PATCH 4.4.y-cip 0/3] Add DU support
> 
> Hi!
> 
> > > This patch series add DU support for iWave iwg20d platform based on
> RZ/G1N.
> > >
> > > This patch series is based on linux-4.4.y-cip and all the patches
> in
> > > this series are cherry-picked from upstream.
> > >
> > > Biju Das (3):
> > >   dt-bindings: display: renesas: du: Document the r8a7744 bindings
> > >   drm: rcar-du: Add R8A7744 support
> > >   ARM: dts: r8a7744: Add DU support
> > >
> > >  Documentation/devicetree/bindings/display/renesas,du.txt |  2 ++
> > >  arch/arm/boot/dts/r8a7744.dtsi                           | 10
> > > +++++++++-
> > >  drivers/gpu/drm/rcar-du/rcar_du_drv.c                    |  3
> ++-
> > >  3 files changed, 13 insertions(+), 2 deletions(-)
> >
> > Looks good to me these patches.
> > If other reviewer have no opinion, I will apply this series.
> 
> Looks good to me, too. Go ahead :-).

Thanks, Pavel.
Applied.

Best regards,
  Nobuhiro
