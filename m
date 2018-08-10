From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 10 Aug 2018 10:52:43 +0100
Subject: [cip-dev] [PATCH 00/19] Add sound support to iwg22d
Message-ID: <1533894782-26239-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

this series adds sound support to the iwg22d board by backporting all the
necessary patches, including some fixes.

There is a dependency with series:
https://lists.cip-project.org/pipermail/cip-dev/2018-July/001462.html

This work is based on top of linux-4.4.y-cip, commit
4d769b2b8749e89dfc7ea179a44f652dcfbedb37 ("PM / OPP: Move error
message to debug level").

Thanks,
Fab

Biju Das (9):
  ARM: dts: r8a7745: Add audio clocks
  ARM: dts: r8a7745: Add audio DMAC support
  ARM: dts: r8a7745: Add sound support
  ARM: dts: iwg22d-sodimm: Enable SGTL5000 audio codec
  ARM: dts: iwg22d-sodimm: Sound PIO support
  ARM: dts: iwg22d-sodimm: Sound DMA support on DTS
  ARM: dts: iwg22d-sodimm: Sound DMA support via BUSIF on DTS
  ARM: dts: iwg22d-sodimm: Sound DMA support via SRC on DTS
  ARM: dts: iwg22d-sodimm: Sound DMA support via DVC on DTS

Kuninori Morimoto (5):
  ASoC: rsnd: remove platform boot support from src.c
  dmaengine: rcar-dmac: clear pertinence number of channels
  dmaengine: rcar-dmac: use list_add() on rcar_dmac_desc_put()
  dmaengine: rcar-dmac: ensure CHCR DE bit is actually 0 after clearing
  dmaengine: rcar-dmac: use TCRB instead of TCR for residue

Laurent Pinchart (1):
  dmaengine: rcar-dmac: Fix residue reporting for pending descriptors

Muhammad Hamza Farooq (2):
  dmaengine: rcar-dmac: use result of updated get_residue in tx_status
  dmaengine: rcar-dmac: Fixed active descriptor initializing

Niklas S?derlund (1):
  dmaengine: rcar-dmac: warn if transfer cannot start as TE = 1

Sergei Shtylyov (1):
  rcar: src: skip disabled-SRC nodes

 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts |  92 ++++++++++++
 arch/arm/boot/dts/r8a7745.dtsi              | 222 ++++++++++++++++++++++++++++
 drivers/dma/sh/rcar-dmac.c                  |  87 ++++++++++-
 sound/soc/sh/rcar/src.c                     | 165 +++++++--------------
 4 files changed, 451 insertions(+), 115 deletions(-)

-- 
2.7.4
