Return-Path: <fabrizio.castro.jz@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00AFEB64D9
	for <webhook@archiver.kernel.org>; Tue,  4 Jul 2023 15:34:59 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.61638.1688484896860911751
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Jul 2023 08:34:57 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: fabrizio.castro.jz@renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,181,1684767600"; 
   d="scan'208";a="166817068"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 05 Jul 2023 00:34:55 +0900
Received: from dev.ree.adwin.renesas.com (unknown [10.226.38.7])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3458740062A9;
	Wed,  5 Jul 2023 00:34:52 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip v2 0/4] Add Renesas RZ/V2M PWC support
Date: Tue,  4 Jul 2023 16:34:48 +0100
Message-Id: <20230704153452.11780-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jul 2023 15:34:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12213

Dear All,

this series adds support for the PWC IP found inside the Renesas
RZ/V2M SoC.

Thanks,
Fab

Fabrizio Castro (4):
  dt-bindings: soc: renesas: Add RZ/V2M PWC
  soc: renesas: Add PWC support for RZ/V2M
  arm64: dts: renesas: r9a09g011: Add PWC support
  arm64: dts: renesas: v2mevk2: Add PWC support

 .../soc/renesas/renesas,rzv2m-pwc.yaml        |  56 +++++++
 .../boot/dts/renesas/r9a09g011-v2mevk2.dts    |   5 +
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi    |   8 +
 drivers/soc/renesas/Kconfig                   |   4 +
 drivers/soc/renesas/Makefile                  |   1 +
 drivers/soc/renesas/pwc-rzv2m.c               | 151 ++++++++++++++++++
 6 files changed, 225 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/renesas/renesas,rzv2m-pwc.yaml
 create mode 100644 drivers/soc/renesas/pwc-rzv2m.c

-- 
2.25.1


