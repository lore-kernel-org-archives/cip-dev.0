From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 20 Nov 2019 15:34:26 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 0/5] Audio SSIU BUSIF support
Message-ID: <1574264071-16816-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch add support for SSIU BUSIF.

This patch series is based on linux-4.19.y-cip and all the patches
in this series are cherry-picked from linux rc tree.

Fabrizio Castro (1):
  arm64: dts: renesas: r8a774a1: Add SSIU support for sound

Kuninori Morimoto (4):
  ASoC: rsnd: merge .nolock_start and .prepare
  ASoC: rsnd: move .get_status under rsnd_mod_ops
  ASoC: rsnd: add .get_id/.get_id_sub
  ASoC: rsnd: add SSIU BUSIF support

 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 251 +++++++++++++++++++++++++++---
 sound/soc/sh/rcar/adg.c                   |   2 +-
 sound/soc/sh/rcar/cmd.c                   |  11 +-
 sound/soc/sh/rcar/core.c                  |  45 +++---
 sound/soc/sh/rcar/ctu.c                   |  23 ++-
 sound/soc/sh/rcar/dma.c                   |  79 ++++++----
 sound/soc/sh/rcar/dvc.c                   |   3 +-
 sound/soc/sh/rcar/mix.c                   |   3 +-
 sound/soc/sh/rcar/rsnd.h                  |  51 +++---
 sound/soc/sh/rcar/src.c                   |  24 +--
 sound/soc/sh/rcar/ssi.c                   | 146 ++++++++---------
 sound/soc/sh/rcar/ssiu.c                  | 205 +++++++++++++++++++++---
 12 files changed, 636 insertions(+), 207 deletions(-)

-- 
2.7.4
