From: pavel@denx.de (Pavel Machek)
Date: Wed, 20 Nov 2019 15:38:29 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 00/17] Add
 SYS-DMAC/GPIO/AVB/SMP/SCIF/HSCIF/I2C/IIC/CMT/RWDT support
In-Reply-To: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
References: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191120143829.GB4940@duo.ucw.cz>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> This patch series add SYS-DMAC/GPIO/AVB/SMP/SCIF/HSCIF/I2C/IIC/CMT/RWDT
> support for iWave RZ/G1N platform.
> 
> Backported the relevent patches to linux-4.4.y-cip.

I don't see any problems with this series, and will apply it later
today if there are no objections.

Best regards,
								Pavel
								
>  .../devicetree/bindings/dma/renesas,rcar-dmac.txt  |   1 +
>  .../devicetree/bindings/gpio/renesas,gpio-rcar.txt |   1 +
>  Documentation/devicetree/bindings/i2c/i2c-rcar.txt |   1 +
>  .../devicetree/bindings/i2c/i2c-sh_mobile.txt      |   1 +
>  .../devicetree/bindings/net/renesas,ravb.txt       |   1 +
>  .../devicetree/bindings/power/renesas,apmu.txt     |   1 +
>  .../devicetree/bindings/timer/renesas,cmt.txt      |   2 +
>  .../devicetree/bindings/watchdog/renesas-wdt.txt   |   1 +
>  arch/arm/boot/dts/iwg20d-q7-common.dtsi            |   9 +
>  arch/arm/boot/dts/r8a7743-iwg20m.dtsi              |   9 -
>  arch/arm/boot/dts/r8a7744.dtsi                     | 596 ++++++++++++++++++++-
>  11 files changed, 598 insertions(+), 25 deletions(-)

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191120/b1989867/attachment.sig>
