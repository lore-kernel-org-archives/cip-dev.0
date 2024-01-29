Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5008CC47DB3
	for <webhook@archiver.kernel.org>; Mon, 29 Jan 2024 19:18:36 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.4192.1706555913695547964
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jan 2024 11:18:34 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,227,1701097200"; 
   d="scan'208";a="192123967"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 30 Jan 2024 04:18:32 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.7])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A2DBF400C43E;
	Tue, 30 Jan 2024 04:18:30 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 0/2] Add IRQ affinity support for IRQC
Date: Mon, 29 Jan 2024 19:18:27 +0000
Message-Id: <20240129191829.45687-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jan 2024 19:18:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14484

Hi,

This patch series aims to add IRQ affinity support for IRQC driver.
Both the patches have been cherr-picked from v6.8-rc2.

Cheers,
Prabhakar

Lad Prabhakar (2):
  irqchip/renesas-rzg2l: Enhance driver to support interrupt affinity
    setting
  pinctrl: renesas: rzg2l: Enhance driver to support interrupt affinity
    setting

 drivers/irqchip/irq-renesas-rzg2l.c     | 1 +
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 1 +
 2 files changed, 2 insertions(+)

-- 
2.34.1


