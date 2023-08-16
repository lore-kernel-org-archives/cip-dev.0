Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82500C001E0
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 07:12:47 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.155805.1692169963684121190
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 00:12:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,176,1684767600"; 
   d="scan'208";a="176760843"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 16 Aug 2023 16:12:42 +0900
Received: from localhost.localdomain (unknown [10.226.92.162])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 87908400EF74;
	Wed, 16 Aug 2023 16:12:40 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 0/2] Enable PMU support for RZ/{G2L,G2LC,V2L} SoCs
Date: Wed, 16 Aug 2023 08:12:37 +0100
Message-Id: <20230816071239.3310-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 07:12:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12657

This patch series aims to enable PMU support for RZ/{G2L,G2LC,V2L}
SoCs.
 
All the patches are cherry-picked from the mainline.

Lad Prabhakar (2):
  arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
  arm64: dts: renesas: r9a07g054: Add Cortex-A55 PMU node

 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 5 +++++
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 5 +++++
 2 files changed, 10 insertions(+)

-- 
2.25.1


