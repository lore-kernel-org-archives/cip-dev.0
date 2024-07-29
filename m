Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1AFC49EA1
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 15:35:39 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.58893.1722267324064889186
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jul 2024 08:35:32 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,246,1716217200"; 
   d="scan'208";a="217878981"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 30 Jul 2024 00:35:32 +0900
Received: from localhost.localdomain (unknown [10.226.92.63])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9B847401A444;
	Tue, 30 Jul 2024 00:35:30 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 11/13] dt-bindings: watchdog: dlg,da9062-watchdog: Drop blank space
Date: Mon, 29 Jul 2024 16:34:56 +0100
Message-ID: <20240729153504.510443-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729153504.510443-1-biju.das.jz@bp.renesas.com>
References: <20240729153504.510443-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jul 2024 15:35:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16679

commit 63d097d46799dc6ab4d1430482cd5ab6a409c4ec upstream.

Drop unnecessary blank space from binding documentation.

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://lore.kernel.org/all/ZpemkYsK6zQgGCF2@duo.ucw.cz/
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20240717115649.131914-1-biju.das.jz@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml b/Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml
index f058628bb632..0fd1d4759e00 100644
--- a/Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml
+++ b/Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml
@@ -24,7 +24,7 @@ properties:
       Add this property to disable the watchdog during suspend.
       Only use this option if you can't use the watchdog automatic suspend
       function during a suspend (see register CONTROL_B).
-  
+
   dlg,wdt-sd:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 1]
-- 
2.43.0


