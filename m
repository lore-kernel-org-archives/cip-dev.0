Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEE3C46CCD
	for <webhook@archiver.kernel.org>; Wed, 20 Dec 2023 23:06:54 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.34645.1703113611129381758
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Dec 2023 15:06:51 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,292,1695654000"; 
   d="scan'208";a="187185227"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Dec 2023 08:06:49 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.50])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id CE11740BF751;
	Thu, 21 Dec 2023 08:06:47 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH RFC 00/30] Add support for Renesas RZ/Five RISC-V SoC
Date: Wed, 20 Dec 2023 23:06:16 +0000
Message-Id: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Dec 2023 23:06:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14136

Hi All,

The RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP Single)
1.0 GHz, 16-bit DDR3L/DDR4 interface. And it also has many interfaces such
as Gbit-Ether, CAN, and USB 2.0, making it ideal for applications such as
entry-class social infrastructure gateway control and industrial gateway
control.

This patch series adds initial SoC DTSi support for Renesas RZ/Five
(R9A07G043) SoC and updates the bindings for the same. Below is the list
of IP blocks which will be supported by this series:
- ADC
- AX45MP CPU
- CANFD
- CPG
- DMAC
- Ethernet
- I2C
- OSTM
- PINCTRL
- PLIC
- RSPI
- SCIF
- SDHI/eMMC
- SSIF
- SYSC
- Thermal
- USB Host/Device
- WDT

Apart from first two patches all the patches have been cherry picked from
upstream kernel.

Sending this series as an RFC mainly beacuse, as the kernel image is not
generic to all RISC-V platforms as the HW is noncoherent.

Complete defconfig file for RZ/Five can be found at [0].

[0] https://gitlab.com/prabhakarlad/cip-kernel-config/-/raw/rzfive/6.1.y-cip/riscv/renesas_defconfig

Cheers,
Prabhakar

Arnd Bergmann (2):
  riscv: dma-mapping: only invalidate after DMA, not flush
  riscv: dma-mapping: skip invalidation before bidirectional DMA

Conor Dooley (1):
  riscv: dts: renesas: Clean up dtbs_check W=1 warning due to empty phy
    node

Jisheng Zhang (1):
  riscv: mm: mark noncoherent_supported as __ro_after_init

Lad Prabhakar (25):
  arm64: dts: renesas: rzg2ul-smarc: Drop including RZ/G2UL SoM DTSI
  arm64: dts: renesas: rzg2ul: Move PMOD_SCI0_EN macro to board DTS
  mmc: host: Kconfig: Make MMC_SDHI_INTERNAL_DMAC config option
    dependant on ARCH_RENESAS
  clocksource/drivers/riscv: Get rid of clocksource_arch_init() callback
  riscv: Kconfig: Enable cpufreq kconfig menu
  dt-bindings: riscv: Sort the CPU core list alphabetically
  dt-bindings: riscv: Add Andes AX45MP core to the list
  riscv: dma-mapping: switch over to generic implementation
  riscv: asm: vendorid_list: Add Andes Technology to the vendors list
  riscv: errata: Add Andes alternative ports
  riscv: mm: dma-noncoherent: nonstandard cache operations support
  dt-bindings: cache: andestech,ax45mp-cache: Add DT binding
    documentation for L2 cache controller
  cache: Add L2 cache management for Andes AX45MP RISC-V core
  soc: renesas: Kconfig: Select the required configs for RZ/Five SoC
  riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option
  riscv: dts: renesas: Add initial devicetree for Renesas RZ/Five SoC
  riscv: dts: renesas: Add minimal DTS for Renesas RZ/Five SMARC EVK
  riscv: dts: renesas: r9a07g043f/rzfive-smarc-som: Enable
    ADC/OPP/Thermal Zones/TSU
  riscv: dts: renesas: rzfive-smarc: Enable CANFD/I2C
  riscv: dts: renesas: rzfive-smarc-som: Enable WDT
  riscv: dts: renesas: rzfive-smarc-som: Enable OSTM nodes
  riscv: dts: renesas: rzfive-smarc-som: Drop PHY interrupt support for
    ETH{0,1}
  riscv: dts: renesas: r9a07g043f: Add L2 cache node
  riscv: dts: renesas: r9a07g043f: Add dma-noncoherent property
  riscv: dts: renesas: rzfive-smarc: Enable the blocks which were
    explicitly disabled

Samuel Holland (1):
  clocksource/drivers/riscv: Increase the clock source rating

 .../cache/andestech,ax45mp-cache.yaml         |  81 +++++++
 .../devicetree/bindings/riscv/cpus.yaml       |  11 +-
 MAINTAINERS                                   |   7 +
 .../boot/dts/renesas/r9a07g043u11-smarc.dts   |   3 +
 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi |   4 -
 arch/riscv/Kconfig                            |  10 +-
 arch/riscv/Kconfig.erratas                    |  21 ++
 arch/riscv/Kconfig.socs                       |   5 +
 arch/riscv/boot/dts/Makefile                  |   1 +
 arch/riscv/boot/dts/renesas/Makefile          |   2 +
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi   |  72 ++++++
 .../boot/dts/renesas/r9a07g043f01-smarc.dts   |  27 +++
 .../boot/dts/renesas/rzfive-smarc-som.dtsi    |  24 ++
 arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi |   8 +
 arch/riscv/errata/Makefile                    |   1 +
 arch/riscv/errata/andes/Makefile              |   1 +
 arch/riscv/errata/andes/errata.c              |  66 ++++++
 arch/riscv/include/asm/alternative.h          |   3 +
 arch/riscv/include/asm/dma-noncoherent.h      |  28 +++
 arch/riscv/include/asm/errata_list.h          |   5 +
 arch/riscv/include/asm/vendorid_list.h        |   1 +
 arch/riscv/kernel/alternative.c               |   5 +
 arch/riscv/kernel/time.c                      |   9 -
 arch/riscv/mm/dma-noncoherent.c               | 105 ++++++++-
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/cache/Kconfig                         |  11 +
 drivers/cache/Makefile                        |   3 +
 drivers/cache/ax45mp_cache.c                  | 213 ++++++++++++++++++
 drivers/clocksource/timer-riscv.c             |   7 +-
 drivers/mmc/host/Kconfig                      |   4 +-
 drivers/soc/renesas/Kconfig                   |   4 +
 32 files changed, 713 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
 create mode 100644 arch/riscv/boot/dts/renesas/Makefile
 create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
 create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dts
 create mode 100644 arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
 create mode 100644 arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
 create mode 100644 arch/riscv/errata/andes/Makefile
 create mode 100644 arch/riscv/errata/andes/errata.c
 create mode 100644 arch/riscv/include/asm/dma-noncoherent.h
 create mode 100644 drivers/cache/Kconfig
 create mode 100644 drivers/cache/Makefile
 create mode 100644 drivers/cache/ax45mp_cache.c

-- 
2.34.1


