From: pavel@denx.de (Pavel Machek)
Date: Fri, 6 Dec 2019 23:29:02 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 00/12] Add
	CAN/IRQC/THERMAL/VIN/Audio support
In-Reply-To: <20191206214827.i4y7wc565piblhy7@toshiba.co.jp>
References: <1575634348-10954-1-git-send-email-biju.das@bp.renesas.com>
 <20191206214827.i4y7wc565piblhy7@toshiba.co.jp>
Message-ID: <20191206222902.GA7298@duo.ucw.cz>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> > This patch series add CAN/IRQC/THERMAL/VIN/Audio support for iWave iwg20d platform based on RZ/G1N.
> > 
> > This patch series is based on linux-4.4.y-cip and all the patches in this series are cherry-picked from linux rc tree.
> > 
> > 
> > Biju Das (11):
> >   dt-bindings: can: rcar_can: Add r8a7744 support
> >   ARM: dts: r8a7744: Add CAN support
> >   dt-bindings: irqchip: renesas-irqc: Document r8a7744 support
> >   ARM: dts: r8a7744: Add IRQC support
> >   dt-bindings: thermal: rcar: Add device tree support for r8a7744
> >   ARM: dts: r8a7744: Add thermal device to DT
> >   media: dt-bindings: media: rcar_vin: add device tree support for
> >     r8a7744
> >   ARM: dts: r8a7744: add VIN dt support
> >   ASoC: rsnd: Add r8a7744 support
> >   ARM: dts: r8a7744: Add audio support
> >   ARM: dts: r8a7744-iwg20d-q7-dbcm-ca: Add device tree for camera DB
> > 
> > Kuninori Morimoto (1):
> >   thermal: trip_point_temp_store() calls thermal_zone_device_update()
...
> 
> Looks good to me. I will apply if there is no other opinion.

I quickly reviewed the series, and it looks good to me, too.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191206/065679fc/attachment.sig>
