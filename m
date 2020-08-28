Return-Path: <SRS0=jq+y=CG=lists.cip-project.org=bounce+64572+5290+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC2DC2BB4D
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:46 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FDBE208D5
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="BvlgIMRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDBE208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5290+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id JEVoYY4521723xvgbZEEdiq7; Fri, 28 Aug 2020 09:07:45 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.45837.1598629320009468924
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 08:42:00 -0700
X-IronPort-AV: E=Sophos;i="5.76,364,1592838000"; 
   d="scan'208";a="55587829"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Aug 2020 00:41:58 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.245])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id DCED9400C4F0;
	Sat, 29 Aug 2020 00:41:56 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 00/30] Add iWave RZ/G1H basic board support
Date: Fri, 28 Aug 2020 16:41:25 +0100
Message-Id: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: tvqoQNpyPY9sdTPnhHdHv9Hkx4520388AA=
Content-Type: multipart/mixed; boundary="wCNwTuFCuQFo6rVpyCMv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598630865;
 bh=4Vm0TNy7z+5o4q9ztc1+Q4KL76NY6Zm77r6ls/t/v/Y=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=BvlgIMRko+8XyAkxYk6HBDpO++P8lvSaIhUt9lxuuRFI15ihlF39TMCviuKfPg2hhJ4
 Rg8d/agdnDkTt+HgRc4SK/zsrpV3m7Ep4vP0fP/FB8DC8G31t9lfngHjKNxbgrPkI4c1A
 JDPsvNxyi+OvtxjOPSxSRFahAiGvVtSHM9w=

--wCNwTuFCuQFo6rVpyCMv

This patch series add basic support for iWave RZ/G1H platform based on
r8a7742 SoC to 4.4.y-cip kernel. Most of the patches in this series
are cherry-picked from mainline.

Biju Das (5):
  ARM: shmobile: r8a7742: Add clock index macros for DT sources
  clk: shmobile: Document r8a7742 CPG clock support
  clk: shmobile: Document r8a7742 MSTP clock support
  clk: shmobile: Document r8a7742 CPG DIV6 clock support
  clk: shmobile: Compile clk-rcar-gen2.c when using the r8a7742

Geert Uytterhoeven (4):
  ARM: shmobile: Document RZ/G1H SoC DT binding
  pinctrl: sh-pfc: r8a7790: Use PINMUX_SINGLE() instead of raw
    PINMUX_DATA()
  pinctrl: sh-pfc: r8a7790: Add SCIF_CLK support
  pinctrl: sh-pfc: r8a7790: Add missing TX_ER pin to avb_mii group

Lad Prabhakar (21):
  dt-bindings: reset: rcar-rst: Document r8a7742 reset module
  soc: renesas: rcar-rst: Add support for RZ/G1H
  ARM: shmobile: r8a7742: Basic SoC support
  soc: renesas: Add Renesas R8A7742 config option
  ARM: debug-ll: Add support for r8a7742
  ARM: shmobile: defconfig: Enable r8a7742 SoC
  ARM: multi_v7_defconfig: Enable r8a7742 SoC
  dt-bindings: serial: renesas,scifa: Document r8a7742 bindings
  dt-bindings: serial: renesas,scif: Document r8a7742 bindings
  dt-bindings: serial: renesas,scifb: Document r8a7742 bindings
  dt-bindings: serial: renesas,hscif: Document r8a7742 bindings
  dt-bindings: mmc: renesas,mmcif: Document r8a7742 DT bindings
  dt-bindings: pinctrl: sh-pfc: Document r8a7742 PFC support
  pinctrl: sh-pfc: r8a7790: Add r8a7742 PFC support
  ARM: dts: r8a7742: Initial SoC device tree
  dt-bindings: gpio: renesas, rcar-gpio: Add r8a7742 (RZ/G1H) support
  ARM: dts: r8a7742: Add GPIO nodes
  dt-bindings: arm: renesas: Document iW-RainboW-G21M-Qseven-RZG1H SoM
  ARM: dts: r8a7742-iwg21m: Add iWave RZ/G1H Qseven SOM
  dt-bindings: arm: renesas: Document iW-RainboW-G21D-Qseven-RZG1H board
  ARM: dts: r8a7742-iwg21d-q7: Add iWave G21D-Q7 board based on RZ/G1H

 .../devicetree/bindings/arm/shmobile.txt      |   6 +
 .../clock/renesas,cpg-div6-clocks.txt         |   1 +
 .../clock/renesas,cpg-mstp-clocks.txt         |   1 +
 .../clock/renesas,rcar-gen2-cpg-clocks.txt    |   1 +
 .../bindings/gpio/renesas,gpio-rcar.txt       |   1 +
 .../devicetree/bindings/mmc/renesas,mmcif.txt |   1 +
 .../bindings/pinctrl/renesas,pfc-pinctrl.txt  |   1 +
 .../devicetree/bindings/reset/renesas,rst.txt |   1 +
 .../bindings/serial/renesas,sci-serial.txt    |   4 +
 arch/arm/Kconfig.debug                        |  10 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts       |  37 +
 arch/arm/boot/dts/r8a7742-iwg21m.dtsi         |  53 ++
 arch/arm/boot/dts/r8a7742.dtsi                | 853 ++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig           |   1 +
 arch/arm/configs/shmobile_defconfig           |   1 +
 arch/arm/mach-shmobile/Kconfig                |   5 +
 arch/arm/mach-shmobile/pm-rcar-gen2.c         |   2 +
 arch/arm/mach-shmobile/setup-rcar-gen2.c      |   1 +
 drivers/clk/shmobile/Makefile                 |   1 +
 drivers/pinctrl/sh-pfc/Kconfig                |   5 +
 drivers/pinctrl/sh-pfc/Makefile               |   1 +
 drivers/pinctrl/sh-pfc/core.c                 |   6 +
 drivers/pinctrl/sh-pfc/core.h                 |   1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c          | 786 ++++++++--------
 drivers/soc/renesas/rcar-rst.c                |   3 +-
 include/dt-bindings/clock/r8a7742-clock.h     | 165 ++++
 27 files changed, 1586 insertions(+), 363 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
 create mode 100644 arch/arm/boot/dts/r8a7742-iwg21m.dtsi
 create mode 100644 arch/arm/boot/dts/r8a7742.dtsi
 create mode 100644 include/dt-bindings/clock/r8a7742-clock.h

-- 
2.17.1


--wCNwTuFCuQFo6rVpyCMv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5290): https://lists.cip-project.org/g/cip-dev/message=
/5290
Mute This Topic: https://lists.cip-project.org/mt/76477073/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--wCNwTuFCuQFo6rVpyCMv--
