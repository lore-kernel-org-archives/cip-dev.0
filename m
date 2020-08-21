Return-Path: <SRS0=bQGU=B7=lists.cip-project.org=bounce+64572+5179+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E60AC433ED
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:35 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31AED20656
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="s/h67raY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31AED20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5179+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id hw2AYY4521723xlYS1m1iaBw; Fri, 21 Aug 2020 03:58:34 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.130424.1598002997752220163
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:43:18 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="54954520"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Aug 2020 18:43:16 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BAAA64231AD9;
	Fri, 21 Aug 2020 18:43:14 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 00/36] Add Hihope RZ/G2H basic board support
Date: Fri, 21 Aug 2020 10:42:36 +0100
Message-Id: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: vBCUYr11eGZ7mUKmhtpSTnB7x4520388AA=
Content-Type: multipart/mixed; boundary="NoaHMy8gd3fkYlSZ6JEM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598007514;
 bh=46ad7hAAuuRrRLoA4HwLWHOZ4j9K3GELiKYEm6wpQ4Q=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=s/h67raYWtlwwSzHaefLLhyp1wiqDMP/nI2O4C7HtQkDj3kPLhaBxUPDly1bDngd+xt
 ZLCog4yM78nrWXIqHQT3xdwfjR9YoE8rY5k9dk70j7l4PoMWys+6SgfY+Ty0zz1/TTSEv
 AY0qb7Wkz77Mav+EcA1uOBeF1dKVvQ0z9E8=

--NoaHMy8gd3fkYlSZ6JEM

This patch series add basic support for Hihope RZ/G2H based on
r8a774e1 SoC to 4.19.y-cip kernel. All patches in this series
are cherry-picked from mainline.

This patch series depends on [1]
[1]: https://patchwork.kernel.org/project/cip-dev/list/?series=335409

Geert Uytterhoeven (7):
  pinctrl: sh-pfc: r8a77965: Fix DU_DOTCLKIN3 drive/bias control
  pinctrl: sh-pfc: r8a7795: Deduplicate VIN5 pin definitions
  pinctrl: sh-pfc: r8a7795-es1: Add TPU pins, groups and functions
  pinctrl: sh-pfc: r8a7795: Add TPU pins, groups and functions
  pinctrl: sh-pfc: r8a7795-es1: Use new macros for non-GPIO pins
  pinctrl: sh-pfc: r8a7795: Use new macros for non-GPIO pins
  pinctrl: sh-pfc: Split R-Car H3 support in two independent drivers

Jacopo Mondi (1):
  pinctrl: sh-pfc: r8a7795: Fix VIN versioned groups

Keiya Nobuta (2):
  pinctrl: sh-pfc: pfc-r8a7795-es1: Fix typo in pinmux macro for SCL3
  pinctrl: sh-pfc: pfc-r8a7795: Fix typo in pinmux macro for SCL3

Lad Prabhakar (1):
  pinctrl: sh-pfc: pfc-r8a77951: Add R8A774E1 PFC support

Marek Vasut (1):
  pinctrl: sh-pfc: rcar-gen3: Retain TDSELCTRL register across
    suspend/resume

Marian-Cristian Rotariu (17):
  dt-bindings: power: Add r8a774e1 SYSC power domain definitions
  dt-bindings: power: renesas,rcar-sysc: Document r8a774e1 SYSC binding
  soc: renesas: rcar-sysc: Add r8a774e1 support
  soc: renesas: Add Renesas R8A774E1 config option
  dt-bindings: arm: renesas: Document RZ/G2H SoC DT bindings
  soc: renesas: Identify RZ/G2H
  dt-bindings: reset: rcar-rst: Document r8a774e1 reset module
  soc: renesas: rcar-rst: Add support for RZ/G2H
  clk: renesas: Add r8a774e1 CPG Core Clock Definitions
  dt-bindings: clock: renesas,cpg-mssr: Document r8a774e1
  clk: renesas: cpg-mssr: Add r8a774e1 support
  arm64: defconfig: Enable R8A774E1 SoC
  dt-bindings: pinctrl: sh-pfc: Document r8a774e1 PFC support
  arm64: dts: renesas: Initial r8a774e1 SoC device tree
  dt-bindings: arm: renesas: Add HopeRun RZ/G2H boards
  arm64: dts: renesas: Add HiHope RZ/G2H main board support
  arm64: dts: renesas: Add HiHope RZ/G2H sub board support

Sergei Shtylyov (2):
  clk: renesas: rcar-gen3: Add RPC clocks
  clk: renesas: rcar-gen3: Allow changing the RPC[D2] clocks

Takeshi Kihara (3):
  pinctrl: sh-pfc: r8a7795-es1: Add I2C{0,3,5} pins, groups and
    functions
  pinctrl: sh-pfc: r8a7795: Add I2C{0,3,5} pins, groups and functions
  pinctrl: sh-pfc: rcar-gen3: Rename RTS{0,1,3,4}# pin function
    definitions

Ulrich Hecht (2):
  clk: renesas: cpg-mssr: Mark clocks as critical only if on at boot
  clk: renesas: rzg2: Mark RWDT clocks as critical

 .../devicetree/bindings/arm/shmobile.txt      |    7 +-
 .../bindings/clock/renesas,cpg-mssr.txt       |    1 +
 .../bindings/pinctrl/renesas,pfc-pinctrl.txt  |    1 +
 .../bindings/power/renesas,rcar-sysc.txt      |    1 +
 .../devicetree/bindings/reset/renesas,rst.txt |    1 +
 arch/arm64/Kconfig.platforms                  |    6 +
 arch/arm64/boot/dts/renesas/Makefile          |    2 +
 .../arm64/boot/dts/renesas/hihope-common.dtsi |    4 +-
 arch/arm64/boot/dts/renesas/hihope-rev4.dtsi  |    4 +-
 .../boot/dts/renesas/hihope-rzg2-ex.dtsi      |    2 +-
 .../dts/renesas/r8a774e1-hihope-rzg2h-ex.dts  |   15 +
 .../dts/renesas/r8a774e1-hihope-rzg2h.dts     |   26 +
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi     |  652 ++++++++
 arch/arm64/configs/defconfig                  |    1 +
 drivers/clk/renesas/Kconfig                   |    5 +
 drivers/clk/renesas/Makefile                  |    1 +
 drivers/clk/renesas/r8a774a1-cpg-mssr.c       |    1 +
 drivers/clk/renesas/r8a774b1-cpg-mssr.c       |    1 +
 drivers/clk/renesas/r8a774c0-cpg-mssr.c       |    1 +
 drivers/clk/renesas/r8a774e1-cpg-mssr.c       |  349 ++++
 drivers/clk/renesas/rcar-gen3-cpg.c           |  103 ++
 drivers/clk/renesas/rcar-gen3-cpg.h           |    4 +
 drivers/clk/renesas/renesas-cpg-mssr.c        |   23 +-
 drivers/clk/renesas/renesas-cpg-mssr.h        |    1 +
 drivers/pinctrl/sh-pfc/Kconfig                |   14 +-
 drivers/pinctrl/sh-pfc/Makefile               |    5 +-
 drivers/pinctrl/sh-pfc/core.c                 |   63 +-
 .../{pfc-r8a7795-es1.c => pfc-r8a77950.c}     |  546 ++++---
 .../sh-pfc/{pfc-r8a7795.c => pfc-r8a77951.c}  | 1420 +++++++++--------
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c         |    8 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77970.c         |   24 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77980.c         |   32 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77995.c         |   22 +-
 drivers/pinctrl/sh-pfc/sh_pfc.h               |    5 +-
 drivers/soc/renesas/Kconfig                   |   11 +-
 drivers/soc/renesas/Makefile                  |    1 +
 drivers/soc/renesas/r8a774e1-sysc.c           |   43 +
 drivers/soc/renesas/rcar-rst.c                |    1 +
 drivers/soc/renesas/rcar-sysc.c               |    3 +
 drivers/soc/renesas/rcar-sysc.h               |    1 +
 drivers/soc/renesas/renesas-soc.c             |    8 +
 include/dt-bindings/clock/r8a774e1-cpg-mssr.h |   59 +
 include/dt-bindings/power/r8a774e1-sysc.h     |   36 +
 43 files changed, 2547 insertions(+), 967 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774e1.dtsi
 create mode 100644 drivers/clk/renesas/r8a774e1-cpg-mssr.c
 rename drivers/pinctrl/sh-pfc/{pfc-r8a7795-es1.c => pfc-r8a77950.c} (93%)
 rename drivers/pinctrl/sh-pfc/{pfc-r8a7795.c => pfc-r8a77951.c} (87%)
 create mode 100644 drivers/soc/renesas/r8a774e1-sysc.c
 create mode 100644 include/dt-bindings/clock/r8a774e1-cpg-mssr.h
 create mode 100644 include/dt-bindings/power/r8a774e1-sysc.h

-- 
2.17.1


--NoaHMy8gd3fkYlSZ6JEM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5179): https://lists.cip-project.org/g/cip-dev/message=
/5179
Mute This Topic: https://lists.cip-project.org/mt/76326718/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--NoaHMy8gd3fkYlSZ6JEM--
