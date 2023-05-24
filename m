Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DF1C7EE2E
	for <webhook@archiver.kernel.org>; Wed, 24 May 2023 12:49:55 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.7869.1684932594763331878
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 May 2023 05:49:55 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,189,1681138800"; 
   d="scan'208";a="160644153"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 May 2023 21:49:54 +0900
Received: from localhost.localdomain (unknown [10.226.93.65])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 050A74000AA0;
	Wed, 24 May 2023 21:49:51 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip v2 05/10] dt-bindings: i2c: renesas,rzv2m: Change maintainer to Fabrizio Castro
Date: Wed, 24 May 2023 13:49:32 +0100
Message-Id: <20230524124937.160355-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230524124937.160355-1-biju.das.jz@bp.renesas.com>
References: <20230524124937.160355-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 May 2023 12:49:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11639

From: Chris Paterson <chris.paterson2@renesas.com>

commit f30ec5df80a0a3328ad6b9c2434ccaa331505307 upstream.

Phil no longer works for Renesas.

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Acked-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Link: https://lore.kernel.org/r/20230426100736.11808-1-chris.paterson2@renesas.com
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml b/Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml
index 92e899905ef8..5d1e7885b64a 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml
+++ b/Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Renesas RZ/V2M I2C Bus Interface
 
 maintainers:
-  - Phil Edworthy <phil.edworthy@renesas.com>
+  - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
 
 allOf:
   - $ref: /schemas/i2c/i2c-controller.yaml#
-- 
2.25.1


