Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3942C47DDF
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 20:33:57 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.7251.1706646835418574585
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jan 2024 12:33:55 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,230,1701097200"; 
   d="scan'208";a="192272178"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 31 Jan 2024 05:33:48 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.7])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8F60940A3D1D;
	Wed, 31 Jan 2024 05:33:47 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [RFC PATCH 5.10.y-cip 00/39] Add support for Renesas RZ/Five RISC-V SoC
Date: Tue, 30 Jan 2024 20:33:07 +0000
Message-Id: <20240130203346.94488-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jan 2024 20:33:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14513

Hi All,

This patch series aims to add support for Renesas RZ/Five RISC-V SoC,
support for this SoC has already been added to 6.1-cip kernel.

Sending this series as an RFC as,
1] Support for Global DMA cohernet pool is added
2] As support for non-coherent DMA is missing for RISC-V core,
   required changes have been added directly in ax45mp_cache.c
   (ie patch #26)
3] Patch #26 has been newly added, rest of the patches have been
   cherry-picked from upstream kernel.

Note,
- This patch series applies on top of series [0].

[0] https://patchwork.kernel.org/project/cip-dev/cover/20240130161555.85042-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Christoph Hellwig (5):
  dma-direct: add support for dma_coherent_default_memory
  dma-mapping: allow using the global coherent pool for !ARM
  dma-mapping: simplify dma_init_coherent_memory
  dma-mapping: add a dma_init_global_coherent helper
  dma-mapping: make the global coherent pool conditional

Conor Dooley (1):
  riscv: dts: renesas: Clean up dtbs_check W=1 warning due to empty phy
    node

Heiko Stuebner (1):
  of: also handle dma-noncoherent in of_dma_is_coherent()

Lad Prabhakar (25):
  riscv: Kconfig: Enable cpufreq kconfig menu
  irqchip/sifive-plic: Add support for Renesas RZ/Five SoC
  clocksource/drivers/renesas-ostm: Add support for RZ/V2L SoC
  clocksource/drivers/riscv: Get rid of clocksource_arch_init() callback
  mmc: host: Kconfig: Make MMC_SDHI_INTERNAL_DMAC config option
    dependant on ARCH_RENESAS
  dt-bindings: riscv: Sort the CPU core list alphabetically
  dt-bindings: riscv: Add Andes AX45MP core to the list
  dt-bindings: clock: r9a07g043-cpg: Add Renesas RZ/Five CPG Clock and
    Reset Definitions
  dt-bindings: cache: andestech,ax45mp-cache: Add DT binding
    documentation for L2 cache controller
  soc: renesas: Identify RZ/Five SoC
  clk: renesas: r9a07g043: Add support for RZ/Five SoC
  cache: Add L2 cache management for Andes AX45MP RISC-V core
  cache: ax45mp_cache: Add non coherent support
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

Niklas Cassel (2):
  irqchip/sifive-plic: Improve naming scheme for per context offsets
  irqchip/sifive-plic: Disable S-mode IRQs if running in M-mode

Samuel Holland (4):
  of/irq: Use interrupts-extended to find parent
  irqchip/sifive-plic: Make better use of the effective affinity mask
  irqchip/sifive-plic: Separate the enable and mask operations
  clocksource/drivers/riscv: Increase the clock source rating

Xiongfeng Wang (1):
  cacheinfo: clear cache_leaves(cpu) in free_cache_attributes()

 .../cache/andestech,ax45mp-cache.yaml         |  81 +++++++
 .../devicetree/bindings/riscv/cpus.yaml       |   7 +-
 MAINTAINERS                                   |   7 +
 arch/riscv/Kconfig                            |   3 +-
 arch/riscv/Kconfig.socs                       |   5 +
 arch/riscv/boot/dts/Makefile                  |   1 +
 arch/riscv/boot/dts/renesas/Makefile          |   2 +
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi   |  72 ++++++
 .../boot/dts/renesas/r9a07g043f01-smarc.dts   |  27 +++
 .../boot/dts/renesas/rzfive-smarc-som.dtsi    |  24 ++
 arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi |   8 +
 arch/riscv/kernel/time.c                      |   9 -
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/base/cacheinfo.c                      |   1 +
 drivers/cache/Kconfig                         |  12 +
 drivers/cache/Makefile                        |   3 +
 drivers/cache/ax45mp_cache.c                  | 222 ++++++++++++++++++
 drivers/clk/renesas/r9a07g043-cpg.c           |  32 +++
 drivers/clocksource/renesas-ostm.c            |   2 +-
 drivers/clocksource/timer-riscv.c             |   7 +-
 drivers/irqchip/Kconfig                       |   1 +
 drivers/irqchip/irq-sifive-plic.c             | 178 ++++++++++----
 drivers/mmc/host/Kconfig                      |   4 +-
 drivers/of/address.c                          |  17 +-
 drivers/of/irq.c                              |  13 +-
 drivers/soc/renesas/Kconfig                   |  12 +
 drivers/soc/renesas/renesas-soc.c             |  13 +
 include/dt-bindings/clock/r9a07g043-cpg.h     |  20 ++
 include/linux/dma-map-ops.h                   |  18 +-
 kernel/dma/Kconfig                            |   4 +
 kernel/dma/coherent.c                         | 161 ++++++-------
 kernel/dma/direct.c                           |  17 ++
 33 files changed, 822 insertions(+), 164 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
 create mode 100644 arch/riscv/boot/dts/renesas/Makefile
 create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
 create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dts
 create mode 100644 arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
 create mode 100644 arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
 create mode 100644 drivers/cache/Kconfig
 create mode 100644 drivers/cache/Makefile
 create mode 100644 drivers/cache/ax45mp_cache.c

-- 
2.34.1


