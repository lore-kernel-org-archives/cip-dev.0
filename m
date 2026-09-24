Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361BDC9830E
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 09:32:28 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.28])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3870.1790242346103218404
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 02:32:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=DLOwy3QM;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.28, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1+1VOCx1hp4VL1y5TkH0plgDyJO7zmIwe3cfMqrQDw5+IhLQCO9l1ZWwXB0rFeNQY35DBsd/vP0osA/v/F/eiyI9aK+J+AiX6BnuD0l/om/GgSqihOfdWrNBW23YffwHR4P+VpgZ1M7A3Jd50h7rYCJm6NhAk1eyJmc3sm2uDaER7uEEYJONDUsgKozBcCHzt9dYqatE7WXz7lqHat3yd95JvfKvSNYmSH4YEZd7ooTQNvovXjBA+V8o/DbCHAsqFaH1mBjPzaYLbffQq77IHEGu+3I865hUBzoy9uWNxFPX5Cc373SplSoDAx8jrZFRvsjGrSK+lzCe2nHNPHAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1UOZv/Otaoh9RwbO3rBHusrIWet1AOmTmc2hJgXbnM=;
 b=na78afyXR7KWgaH2UvoFQE6TFxDWntg92Jf7l9CdGnLezSAKixM+4XFok71/ksDKnXVGNwBzQxxBIODupIyhW/VJpwxn0WbdzYydYJ2tW+BUILKTJxoWYh1eJcVhE+EzZsMsijCPlSpAIztYwMLujZPtkhIk1J0fUNIMLfppg6X707L/U8DgYDwatAPy0d0tGQAZSe3ZGBFNfG8mIL4sQw4DmAs2LY1ZN/gpy68s2wDyuJmlikPDEPq246Q2DDETRV4ar2Eq+CKXvgK6Vk73oyVkJu01EG+FEoP196G8IJMFVeU8Us7NrZ7PUsEqer1T8tNCfEA+ogQNwEjKylWiyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1UOZv/Otaoh9RwbO3rBHusrIWet1AOmTmc2hJgXbnM=;
 b=DLOwy3QMCQkfdxIjDsHaR6Rp8zGVXsOqnbWopFGTQniqP9ljq7Llt/OSS7qYPOrl16lYskgGQyApIpxAEV4kNtt1QeJZVIagvPSMikfgJRIMaQ4sCCNJI6SPzsf9UZjUk5EWXyHpzHBqypiTC26Bw+gUwvZv1iM6TgEpTr5l+MM=
Received: from OS3P301CA0018.JPNP301.PROD.OUTLOOK.COM (2603:1096:604:21f::17)
 by TYYPR01MB15220.jpnprd01.prod.outlook.com (2603:1096:405:27d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 09:32:19 +0000
Received: from OS1PEPF0000D215.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:21f:cafe::47) by OS3P301CA0018.outlook.office365.com
 (2603:1096:604:21f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.17 via Frontend Transport; Thu,
 24 Sep 2026 09:32:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D215.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 24 Sep 2026 09:32:19 +0000
Received: from biju-VirtualBox.adwin.renesas.com (DEU-5CG6192QFB.adwin.renesas.com [10.226.92.107])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id C18353000225;
	Thu, 24 Sep 2026 18:32:16 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 1/3] spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/G3L SoC
Date: Thu, 24 Sep 2026 10:31:51 +0100
Message-ID: <20260924093156.131928-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924093156.131928-1-biju.das.jz@bp.renesas.com>
References: <20260924093156.131928-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D215:EE_|TYYPR01MB15220:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 312d2d80-367a-4249-ffe6-08df1a1ebae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	thDLRWkOyiYqb0UpMK4agJc7LGCXnlp8axpkBy32gwaqHbYGHXYKguvMsk1rL3dHCgQlPLsGlA1ImbcD308lQB1pcWo2TGn7dGuYws/W2T/isBLrkKVGa+djbMOx67L9MFJt6w+BZgVbzqi8wpQ53Cx0a2VNwT3CedEIrgNVwL20Ja26F4wSLt1H7ILGxMQlDRn1XQUevnjpPwys0nJuTtCgHu7m/eSyuwueQ0nNPOqq0PJFf+ROCiADmpjGyYQfrZpV0FbMOenn/Syfype5zcOvZts+hQVo0+8QHMU1b3Ttb0rI0TBvGARGac9EoO2MExoCBA6jk8WEDEsHs2+qcEsu1lJlLAWrekWhM12YI+K2PJ+LjGR5Jys9Vn3LJ+pftfAblEZDdRJLzR0lR6Y+jvtZO0a7VCi8NaqGKremEKl3y6SHSftWCGNLhtZwh8KIdKGRJ2S7uWZ4tsH172qEo+5L2gnf9YrJCfKEvCJ4d7DYzgJANUaFa+YUc4jue1JslmM5zcfnxtNOgb4s0CQGplmfj8rHqhnTYYR/S0ZQ3xrd30bKZpLygQgvn32aM8vJGfoj7uXKSCWoQrQoVGr50dP8Hv7kffxVVJfUKTni8ZkA5zWQDn1VZoMyHlb7Z4tLqvC75/BaPQXKlwuSZodpLA==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	7BKfGIZ8zmv0oRAMZZ2fwIOZhMLnIRXOITb9iXKWg/JXNxCBSzN8Xqe0bacyapakplRo4H8R3LnDJCvf0Qv20CJggQ2SXJPIxqKx3QOBUM+b/FLguWq20ued7tvUp5iismtX9tEcHBilVj8bOORrqMoW17lNoMrECCTzYM+g6zIiCU7LZp/RIuLGocSzfrY1Sn0eYIiL6OYCq2/tt6gDUJUq2tWVKmgvJY4P2ew0AE/rJYrC6ld5H+AKb9oql5IU1MTfRbDEbB/VMBDpMjktFVDs3k9qrcwsaU+D4ALMeVQf6TZMRlXERbrpcKDJnGr9oKKCstC5I6/i60M/2YIsOYUuXaAT7JxVtwV3FChyhhWs/0g+zjLhvU7Q7SScXw9gdBLxo/vrSi6O9RJwRW1hhMb+iXzvc+w3ctVKL7NtQ0B9Zei3j5FFo2wMlluxh+W1
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 09:32:19.6110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 312d2d80-367a-4249-ffe6-08df1a1ebae3
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D215.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15220
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 09:32:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24302

commit 5277c291968d87c6a093f50ef489df9d52cb3ca9 upstream.

Document RSPI IP found on the RZ/G3L SoC. The RSPI IP is compatible with
the RZ/V2H RSPI IP, but has 2 clocks compared to 3 on RZ/V2H.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20260408085418.18770-2-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/spi/renesas,rzv2h-rspi.yaml      | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml =
b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
index 2c9045fd51de..f40f316943ba 100644
--- a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
@@ -13,6 +13,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - renesas,r9a08g046-rspi # RZ/G3L
           - renesas,r9a09g057-rspi # RZ/V2H(P)
           - renesas,r9a09g077-rspi # RZ/T2H
       - items:
@@ -90,6 +91,34 @@ required:
=20
 allOf:
   - $ref: spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a08g046-rspi
+    then:
+      properties:
+        clocks:
+          maxItems: 2
+
+        clock-names:
+          items:
+            - const: pclk
+            - const: tclk
+
+        dmas:
+          maxItems: 2
+
+        dma-names:
+          items:
+            - const: rx
+            - const: tx
+
+      required:
+        - resets
+        - reset-names
+
   - if:
       properties:
         compatible:
--=20
2.43.0


