Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3D4E6B27E
	for <webhook@archiver.kernel.org>; Fri,  1 Nov 2024 14:15:55 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.39016.1730470552520763213
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Nov 2024 07:15:52 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,250,1725289200"; 
   d="scan'208";a="227647407"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Nov 2024 23:15:51 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.182])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 79CA942147C2;
	Fri,  1 Nov 2024 23:15:39 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 0/2] media: platform: rzg2l-cru: Trivial code cleanup
Date: Fri,  1 Nov 2024 14:15:36 +0000
Message-ID: <20241101141538.34849-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Nov 2024 14:15:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17163

Hi All,

This patch series aims to fix trivial code changes to RZ/G2L CRU driver.

Cheers,
Prabhakar

Lad Prabhakar (1):
  media: platform: rzg2l-cru: rzg2l-csi2: Enclose the macro in
    parentheses

Yang Li (1):
  media: rzg2l-cru: Remove unneeded semicolon

 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c  | 10 +++++-----
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.43.0


