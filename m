Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308CFC46CA7
	for <webhook@archiver.kernel.org>; Tue,  5 Dec 2023 20:39:42 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.5121.1701808774788924818
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Dec 2023 12:39:35 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,253,1695654000"; 
   d="scan'208";a="185417446"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Dec 2023 05:39:32 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.32])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E58CE4075A4E;
	Wed,  6 Dec 2023 05:39:30 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 0/5] Drop WDT2 support from RZ/G2L family
Date: Tue,  5 Dec 2023 20:39:24 +0000
Message-Id: <20231205203929.444113-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Dec 2023 20:39:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13786

Hi All,

This patch series aims to drop WDT2 support from G2L family of SoCs and
along with SPI1 pinmux movement.

All the patches have been cherry-picked from upstream kernel.

Cheers,
Prabhakar

Lad Prabhakar (5):
  arm64: dts: renesas: rzg2ul-smarc-som: Drop enabling wdt2
  arm64: dts: renesas: rzg2l: Drop WDT2 nodes
  arm64: dts: renesas: rzg2ul-smarc: Move spi1 pinmux to carrier board
    DTSI
  clk: renesas: r9a07g044: Drop WDT2 clock and reset entry
  clk: renesas: r9a07g043: Drop WDT2 clock and reset entry

 arch/arm64/boot/dts/renesas/r9a07g043.dtsi        | 15 ---------------
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi        | 15 ---------------
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi        | 15 ---------------
 arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi  |  5 -----
 arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi |  5 -----
 .../dts/renesas/rzg2ul-smarc-pinfunction.dtsi     |  7 +++++++
 arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi | 12 ------------
 drivers/clk/renesas/r9a07g043-cpg.c               |  5 -----
 drivers/clk/renesas/r9a07g044-cpg.c               |  7 +------
 9 files changed, 8 insertions(+), 78 deletions(-)

-- 
2.34.1


