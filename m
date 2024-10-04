Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C35BCFA75F
	for <webhook@archiver.kernel.org>; Fri,  4 Oct 2024 10:25:33 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.18976.1728037526773267481
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Oct 2024 03:25:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,177,1725289200"; 
   d="scan'208";a="220808846"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Oct 2024 19:25:26 +0900
Received: from localhost.localdomain (unknown [10.226.92.178])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 96C2340062CE;
	Fri,  4 Oct 2024 19:25:24 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 1/3] ASoC: dt-bindings: renesas,rz-ssi: Document port property
Date: Fri,  4 Oct 2024 11:25:16 +0100
Message-ID: <20241004102521.73256-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004102521.73256-1-biju.das.jz@bp.renesas.com>
References: <20241004102521.73256-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Oct 2024 10:25:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16998

commit 2cc719983603f0e9d24da256b58d6abb79e3884a upstream.

Document optional port property that connects to I2S signals.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20240725084559.13127-2-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
index 5bd86a685cf7..2863b10ef12a 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
@@ -84,6 +84,10 @@ properties:
   '#sound-dai-cells':
     const: 0
 
+  port:
+    $ref: audio-graph-port.yaml#/definitions/port-base
+    description: Connection to controller providing I2S signals
+
 required:
   - compatible
   - reg
-- 
2.43.0


