From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 08 Feb 2018 21:51:45 +0000
Subject: [cip-dev] [PATCH  0/7] Add i2c/iic support for r8a7743
In-Reply-To: <1517492789-44830-1-git-send-email-biju.das@bp.renesas.com>
References: <1517492789-44830-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1518126705.3422.15.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu, 2018-02-01 at 13:46 +0000, Biju Das wrote:
> This patch series aims to add i2c/iic support for r8a7743 SoC.
> 
> Backported dt-bindings patch
> Backported per-Generation fallbacks
> 
> It is tested against linux-v4.4.112-cip18
> 
> This patch depends on the below patch series
> https://lists.cip-project.org/pipermail/cip-dev/2018-January/000820.html

All looks good to me.??I've applied and pushed these changes.

Ben.

> Biju Das (4):
> ? dt-bindings: i2c: Document r8a7743/5 support
> ? ARM: dts: r8a7743: Add I2C DT support
> ? dt-bindings: i2c: sh_mobile: Document r8a7743/5 support
> ? ARM: dts: r8a7743: Add IIC cores to dtsi
> 
> Geert Uytterhoeven (1):
> ? dt-bindings: i2c: Spelling s/propoerty/property/
> 
> Simon Horman (2):
> ? i2c: rcar: Add per-Generation fallback bindings
> ? i2c: sh_mobile: Add per-Generation fallback bindings
> 
> ?Documentation/devicetree/bindings/i2c/i2c-imx.txt??|???2 +-
> ?Documentation/devicetree/bindings/i2c/i2c-rcar.txt |??35 ++++--
> ?.../devicetree/bindings/i2c/i2c-sh_mobile.txt??????|??20 ++-
> ?Documentation/devicetree/bindings/i2c/i2c-sirf.txt |???2 +-
> ?arch/arm/boot/dts/r8a7743.dtsi?????????????????????| 137 +++++++++++++++++++++
> ?drivers/i2c/busses/i2c-rcar.c??????????????????????|???5 +-
> ?drivers/i2c/busses/i2c-sh_mobile.c?????????????????|???4 +-
> ?7 files changed, 186 insertions(+), 19 deletions(-)
> 
-- 
Ben Hutchings
Software Developer, Codethink Ltd.
