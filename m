Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5922C61D97
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 16:51:20 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.24748.1700671872199188480
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Nov 2023 08:51:12 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,219,1695654000"; 
   d="scan'208";a="187751694"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 23 Nov 2023 01:51:10 +0900
Received: from localhost.localdomain (unknown [10.226.92.150])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 98696402D12C;
	Thu, 23 Nov 2023 01:51:08 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 0/3] Document MTU3 IP on RZ/{G2UL,Five} SoCs
Date: Wed, 22 Nov 2023 16:51:03 +0000
Message-Id: <20231122165106.235838-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 16:51:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13635

This patch series aims to document MTU3 IP on RZ/G2{UL,Five} SoCs.

All the patches are cherry-picked from the mainline.

Biju Das (3):
  dt-bindings: timer: renesas,rz-mtu3: Fix overflow/underflow interrupt
    names
  dt-bindings: timer: renesas,rz-mtu3: Improve documentation
  dt-bindings: timer: renesas,rz-mtu3: Document RZ/{G2UL,Five} SoCs

 .../bindings/timer/renesas,rz-mtu3.yaml       | 67 ++++++++++---------
 1 file changed, 34 insertions(+), 33 deletions(-)

-- 
2.25.1


