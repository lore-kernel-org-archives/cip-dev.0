Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85484C77B7A
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 07:52:59 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.3523.1686037970188610868
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 00:52:55 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,219,1681138800"; 
   d="scan'208";a="162379969"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Jun 2023 16:52:54 +0900
Received: from localhost.localdomain (unknown [10.226.92.247])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id AC6154187F12;
	Tue,  6 Jun 2023 16:52:52 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 6/8] MAINTAINERS: Add entries for Renesas RZ/G2L MTU3a counter driver
Date: Tue,  6 Jun 2023 08:52:33 +0100
Message-Id: <20230606075235.183132-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
References: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 07:52:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11847

commit 5dee9439cc2d60ff35cad04b618ee53f48a7cfc2 upstream.

Add the MAINTAINERS entries for the Renesas RZ/G2L MTU3a counter
driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/20230330111632.169434-6-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 301b9ba6af79..43149bc51752 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17613,6 +17613,14 @@ S:	Supported
 F:	Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
 F:	drivers/iio/adc/rzg2l_adc.c
 
+RENESAS RZ/G2L MTU3a COUNTER DRIVER
+M:	Biju Das <biju.das.jz@bp.renesas.com>
+L:	linux-iio@vger.kernel.org
+L:	linux-renesas-soc@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
+F:	drivers/counter/rz-mtu3-cnt.c
+
 RENESAS RZ/N1 A5PSW SWITCH DRIVER
 M:	Clément Léger <clement.leger@bootlin.com>
 L:	linux-renesas-soc@vger.kernel.org
-- 
2.25.1


