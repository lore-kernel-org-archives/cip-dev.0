From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed,  1 May 2019 11:21:54 +0100
Subject: [cip-dev] [PATCH 4.19.y 00/29] Add further support for the RZ/G2M
Message-ID: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear All,

this series adds further support for the RZ/G2M SoC
(a.k.a. R8A774C0), including IPMMU, VIN, CSI2, Sound, PWM,
and Thermal.

Thanks,
Fab

Fabrizio Castro (22):
  iommu/ipmmu-vmsa: Hook up R8A774A1 DT maching code
  iommu/ipmmu-vmsa: Hook up r8a774c0 DT matching code
  dt-bindings: iommu: ipmmu-vmsa: Add r8a774a1 support
  dt-bindings: iommu: ipmmu-vmsa: Add r8a774c0 support
  arm64: dts: renesas: r8a774c0: Add IPMMU device nodes
  media: rcar-vin: Add support for RZ/G2E
  media: rcar-csi2: Add support for RZ/G2E
  media: dt-bindings: rcar-vin: Add R8A774C0 support
  media: dt-bindings: rcar-csi2: Add r8a774c0
  arm64: dts: renesas: r8a774c0: Add VIN and CSI-2 device nodes
  ASoC: rsnd: Add r8a774a1 support
  ASoC: rsnd: Add r8a774c0 support
  arm64: dts: renesas: r8a774c0: Add audio support
  dt-bindings: pwm: rcar: Add r8a774a1 support
  dt-bindings: pwm: rcar: Add r8a774c0 support
  arm64: dts: renesas: r8a774c0: Add PWM support
  arm64: dts: renesas: r8a774c0: Connect RZ/G2E SYS-DMAC to IPMMU
  arm64: dts: renesas: r8a774c0: Connect RZ/G2E AVB to IPMMU
  arm64: dts: renesas: r8a774c0: Connect RZ/G2E Audio-DMAC to IPMMU
  thermal: rcar_thermal: add R8A774C0 support
  dt-bindings: thermal: rcar-thermal: add R8A774C0 support
  arm64: dts: renesas: r8a774c0: Add thermal support

Jacopo Mondi (5):
  media: rcar-vin: Add support for R-Car R8A77990
  media: rcar-csi2: Add R8A77990 support
  media: rcar: rcar-csi2: Update V3M/E3 PHTW tables
  media: rcar-csi2: Handle per-SoC number of channels
  media: rcar-csi2: Fix PHTW table values for E3/V3M

Simon Horman (1):
  arm64: defconfig: Enable R-Car thermal driver

Yoshihiro Shimoda (1):
  iommu/ipmmu-vmsa: Modify ipmmu_slave_whitelist() to check SoC
    revisions
