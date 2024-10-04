Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DDFCFA765
	for <webhook@archiver.kernel.org>; Fri,  4 Oct 2024 10:25:33 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.18977.1728037532749779008
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Oct 2024 03:25:32 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,177,1725289200"; 
   d="scan'208";a="224785750"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Oct 2024 19:25:32 +0900
Received: from localhost.localdomain (unknown [10.226.92.178])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6C93A40065D0;
	Fri,  4 Oct 2024 19:25:22 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 0/3] Add HDMI audio support**
Date: Fri,  4 Oct 2024 11:25:15 +0100
Message-ID: <20241004102521.73256-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Oct 2024 10:25:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17000

Add HDMI audio support for RZ/{G2L,G2L,V2L} SMARC EVKs
All the patches are cherry-picked from the mainline.

Biju Das (3):
  ASoC: dt-bindings: renesas,rz-ssi: Document port property
  arm64: dts: renesas: rzg2l-smarc: Enable HDMI audio
  arm64: dts: renesas: rzg2lc-smarc: Enable HDMI audio

 .../bindings/sound/renesas,rz-ssi.yaml        |  4 +++
 .../boot/dts/renesas/r9a07g044c2-smarc.dts    |  3 ++
 .../dts/renesas/rzg2l-smarc-pinfunction.dtsi  |  6 ++++
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  | 30 +++++++++++++++++
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi | 33 +++++++++++++++++++
 5 files changed, 76 insertions(+)

-- 
2.43.0


