Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CA2C64EBE
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:10 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.13570.1650490470612843250
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Apr 2022 14:34:31 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,276,1643641200";
   d="scan'208";a="118607246"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Apr 2022 06:34:27 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7471741088D8;
	Thu, 21 Apr 2022 06:34:26 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 00/24] Add sound support to Renesas RZ/G2L SoC
Date: Wed, 20 Apr 2022 22:34:00 +0100
Message-Id: <20220420213424.27837-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Apr 2022 16:46:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8122

Hi All,

This patch series adds sound support to Renesas RZ/G2L SoC and enables
SSI and codec on Renesas RZ/G2L SMARC EVK.

All the patches have been cherry picked from v5.18-rc3.

Sound support patches were already sent earlier as part of bulk series
[0], but due to some review comments the patches were rejected, now that
the driver is fixed upstream, re-sending the series with all the fixes.

[0] https://patchwork.kernel.org/project/cip-dev/cover/
20211229101530.22783-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Biju Das (16):
  ASoC: dt-bindings: Document RZ/G2L bindings
  ASoC: dt-bindings: sound: renesas,rz-ssi: Document DMA support
  ASoC: dt-bindings: renesas,rz-ssi: Update slave dma channel
    configuration parameter
  ASoC: sh: Add RZ/G2L SSIF-2 driver
  ASoC: sh: rz-ssi: Add SSI DMAC support
  ASoC: sh: rz-ssi: Fix dereference of noderef expression warning
  ASoC: sh: rz-ssi: Fix wrong operator used issue
  ASoC: sh: rz-ssi: Improve error handling in rz_ssi_dma_request
    function
  arm64: dts: renesas: r9a07g044: Add external audio clock nodes
  arm64: dts: renesas: r9a07g044: Add SSI support
  arm64: dts: renesas: r9a07g044: Add DMA support to SSI
  arm64: dts: renesas: rzg2l-smarc: Add WM8978 sound codec
  arm64: dts: renesas: rzg2l-smarc: Enable audio
  arm64: dts: renesas: rzg2l-smarc: Add Mic routing
  arm64: defconfig: Enable SOUND_SOC_RZ
  arm64: defconfig: Enable SND_SOC_WM8978

Heiner Kallweit (1):
  ASoC: sh: rz-ssi: Check return value of pm_runtime_resume_and_get()

Lad Prabhakar (7):
  ASoC: sh: rz-ssi: Drop calling rz_ssi_pio_recv() recursively
  ASoC: sh: rz-ssi: Make the data structures available before
    registering the handlers
  ASoC: sh: rz-ssi: Drop ssi parameter from rz_ssi_stream_init()
  ASoC: sh: rz-ssi: Make return type of rz_ssi_stream_is_valid() to bool
  ASoC: sh: rz-ssi: Use a do-while loop in rz_ssi_pio_recv()
  ASoC: sh: rz-ssi: Add rz_ssi_set_substream() helper function
  ASoC: sh: rz-ssi: Remove duplicate macros

 .../bindings/sound/renesas,rz-ssi.yaml        |  118 ++
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |   98 ++
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |   79 ++
 arch/arm64/configs/defconfig                  |    2 +
 sound/soc/sh/Kconfig                          |    6 +
 sound/soc/sh/Makefile                         |    4 +
 sound/soc/sh/rz-ssi.c                         | 1078 +++++++++++++++++
 7 files changed, 1385 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
 create mode 100644 sound/soc/sh/rz-ssi.c

-- 
2.17.1


