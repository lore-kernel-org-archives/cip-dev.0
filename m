From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Mon, 9 Dec 2019 22:13:30 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 00/12] Add
	CAN/IRQC/THERMAL/VIN/Audio support
In-Reply-To: <20191206222902.GA7298@duo.ucw.cz>
References: <1575634348-10954-1-git-send-email-biju.das@bp.renesas.com>
 <20191206214827.i4y7wc565piblhy7@toshiba.co.jp>
 <20191206222902.GA7298@duo.ucw.cz>
Message-ID: <OSAPR01MB32344E4E63E023E0A6D5298E92580@OSAPR01MB3234.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi all,

> -----Original Message-----
> From: Pavel Machek [mailto:pavel at denx.de]
> Sent: Saturday, December 7, 2019 7:29 AM
> To: iwamatsu nobuhiro(?? ?? ????????)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: Biju Das <biju.das@bp.renesas.com>; cip-dev at lists.cip-project.org;
> Pavel Machek <pavel@denx.de>; Chris Paterson
> <chris.paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>
> Subject: Re: [PATCH 4.4.y-cip 00/12] Add CAN/IRQC/THERMAL/VIN/Audio
> support
> 
> Hi!
> 
> > > This patch series add CAN/IRQC/THERMAL/VIN/Audio support for iWave
> iwg20d platform based on RZ/G1N.
> > >
> > > This patch series is based on linux-4.4.y-cip and all the patches
> in this series are cherry-picked from linux rc tree.
> > >
> > >
> > > Biju Das (11):
> > >   dt-bindings: can: rcar_can: Add r8a7744 support
> > >   ARM: dts: r8a7744: Add CAN support
> > >   dt-bindings: irqchip: renesas-irqc: Document r8a7744 support
> > >   ARM: dts: r8a7744: Add IRQC support
> > >   dt-bindings: thermal: rcar: Add device tree support for r8a7744
> > >   ARM: dts: r8a7744: Add thermal device to DT
> > >   media: dt-bindings: media: rcar_vin: add device tree support for
> > >     r8a7744
> > >   ARM: dts: r8a7744: add VIN dt support
> > >   ASoC: rsnd: Add r8a7744 support
> > >   ARM: dts: r8a7744: Add audio support
> > >   ARM: dts: r8a7744-iwg20d-q7-dbcm-ca: Add device tree for camera
> DB
> > >
> > > Kuninori Morimoto (1):
> > >   thermal: trip_point_temp_store() calls
> thermal_zone_device_update()
> ...
> >
> > Looks good to me. I will apply if there is no other opinion.
> 
> I quickly reviewed the series, and it looks good to me, too.

Thanks, applied.

Best regards,
  Nobuhiro
