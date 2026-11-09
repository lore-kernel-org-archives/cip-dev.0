Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4679.1794226505149975380
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 04:15:05 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=IU/TEPpV;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.57, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5M22je/5uLskqsphh2mqdZI3KQ/+GoszO3snsbisXZxDbXCUS+/kGVrEPSfTGDSc5QC0+Lh1H4xKJ8b0UUJpQyJH+bCUIKZ0NI8j3hME5eWY+2PNN91Qtaun5bYch+3c1+VAd8uEbjT7monkJ1k1axDSHZToHsaCVHTsF364P5c+BDFKQaiQIehyx9mKHh/nO1Mcj+kxvI+hHuhwWuel2GfRmZs31xCtKtKXxXRwDb4ztgWtdw7cS5V7ViAdwwmVsXqXl4QBei/lsef1nZwYPehdtWgbafa4MyAkB53Sy6PhzCNRaX4p8ssdUFVPs1OE1r+bQR67CHkP8g8g/STPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPuCB99j1BzE3y2uyK8k9+ZWoBCDNWJYgu0WaLW9Rxs=;
 b=nQFKb4XOj3bn7LdQnFF9pebL7W00nEWqfV0NdRUigO1fmbS7TfOyWY48uXfS7Xl4AzYgsdgs/lpdwVK/RyiDiERvEQi94OrNm778ZsehVjd8fOhDUtxs30Yk51MJNQFKV7KOw/d7Ob+sPICnVDCdiRobJUnNbyDHpxXhImHDueChjB+F4RJhiBLppjcYhXdiEp9IyYfEW3/tAQ5CmKaTSX0GWO+b4jVmv4CCF+12tr+YMEF3Gu1tsJwa+O7JD1x6slcSeN9MiagSayAh+Pl6nzyoK2sWW1NzwwNJmI5f7+W5KGSRSKg0HGQ/JKL5nCBmd8llVNs16IYL+G0eGpJvFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPuCB99j1BzE3y2uyK8k9+ZWoBCDNWJYgu0WaLW9Rxs=;
 b=IU/TEPpVPc1+Zj1IYtx48Wlnu5CT1EBLfNucfQT2+rqkMoXV60SmqpT4P45xVG5TL4twh0ZFe0fCH7bCBFCIIDZVtAZk3MI8PZ5ZZaBaJzu10SebMUvkwQiheTT5ZiTe5bhxnuwCkfdsmekHzDrOhCcYqsVzJcKyM0scvJdzfho=
Received: from TYCP286CA0241.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:456::6)
 by OSZPR01MB8137.jpnprd01.prod.outlook.com (2603:1096:604:164::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 12:15:00 +0000
Received: from TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456:cafe::97) by TYCP286CA0241.outlook.office365.com
 (2603:1096:400:456::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 12:15:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005023.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 12:15:00 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.1.30])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 4DEEA30002A8;
	Mon,  9 Nov 2026 21:14:59 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 04/24] media: dt-bindings: media: renesas,fcp: Document RZ/T2H and RZ/N2H SoCs
Date: Mon,  9 Nov 2026 12:14:31 +0000
Message-ID: <20261109121451.6042-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005023:EE_|OSZPR01MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: 44da5c76-344a-428e-3625-08df3e5b13e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|22082099003|10067099003|3023799007|13003099007|11063799006|261028144727099003|261026121527099003|261102123227099003|261022105027099003|56012099006|261021123027099003|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: jk4/1ovMTUvRWIFHbW3XO5IK0hwd2kyMbhOUrjKPyV/QeFaRzk4oeqaY1z8ZAwpShIz17Q7SG4qrr81d1GFvyVErNa8ogyE/meZz2lfllUbfRMKEV7sHQA0WQUCgGor2LvsSzY/4c0Av3q76e26z5EgfiA9oEP7KDqHVycGGW0dU/Gu9BDidHlQUolgrv8+2spUAsPYsEfV+yeNOwC+srC2HJ6wa2QGwHALc6hzEMDVRZhTFyt2S+P87+DcSkQiLBZKIm6lOZu0nGKU+SETjc5E8UHYAmGALq6TzcKDHGR4QwNIMSqXJ/f0RCeHNCQzO37VZcXPrY2iQrDjjAElQE4rhk8v0sR95fCvS8yZRCSEYocnxeses4SoVAPHVWOFWUBvzX/sfvCOIM/PLk/DsR4oCkYyzNUnHsxZLgk9FvmUygrmX6l4dhwTUsp4plXzRhMhqn0Xy5Fb71e4rHmibdcdJAKUhzdgA/YzCAdBqHv//hFD/S2OPikRAjsV6OZyDU2Hy5cyLvQE0+AZ5NJtZ2jFixUNcm/ozUd0eIP6zmph7QugSsEbSM0VfxOqMm1doZb5oeWhKQrIrDqusS359r6q+JUBsDaAJkUNgZnLk5cE2QL85RGRq975eXuIzMkhRqg0mlS+zG+xZKpEb4UnTwQ==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(3023799007)(13003099007)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(56012099006)(261021123027099003)(261021121427099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Tn8hFYxKdre++eOPzu4qQk1lMjl1b/1a0/ZWzPSU7K1ciN/94zW1CMIt8b83pd7RY7fM2YxGY4D1VlfisozN0Gi65CZebHPyKzgYAyBDiJuxXTefNpKCkaXlVcVPUj34XKOgDiLZXTWQTkiRY1AVWwpvN9K2y/ZTpSDwMNC54Li3vCgYzhk8+7YfB4ePePK+QflcYZKogEZU51+yEZ3syHoSdhaW2ix5P4jsrf1+pvH0pRdPESyBbpjRwdgbEkY6pj4ZGwRXq+nLo6WwRbAe00HTCGs5B886kGutDgtCz3CB6gVBHG6t6YIE8nWy7mwtjq3L0h9meyH8JaMO7PMNSJBy1LBQzu5/fJpqhGmcgwk/1FR4AGO5RGRDbIQ0qeCC0jFm5Shr02SvdXAg9kmjH4C6owlZd8QXc84Gkosg5d/58EAqWEbXnlwi9hmgRtOS
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:15:00.6188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44da5c76-344a-428e-3625-08df3e5b13e6
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8137
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 12:15:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24707
Content-Type: text/plain; charset="utf-8"

commit 506742ca85b544fc22a3f448c9c54290aba5035d upstream.

Document the FCPVD blocks present on the RZ/T2H and RZ/N2H SoCs.

The FCPVD implementation on these SoCs is identical to that found on the
RZ/G2L family.

Update the schema to disallow the "resets" property for these SoCs,
reflecting the absence of a reset control for the FCPVD instance.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/20260430100929.1088281-2-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/media/renesas,fcp.yaml | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/renesas,fcp.yaml b/Doc=
umentation/devicetree/bindings/media/renesas,fcp.yaml
index 947c5d00088ec..dd347e9f4db20 100644
--- a/Documentation/devicetree/bindings/media/renesas,fcp.yaml
+++ b/Documentation/devicetree/bindings/media/renesas,fcp.yaml
@@ -32,6 +32,8 @@ properties:
               - renesas,r9a07g054-fcpvd # RZ/V2L
               - renesas,r9a09g056-fcpvd # RZ/V2N
               - renesas,r9a09g057-fcpvd # RZ/V2H(P)
+              - renesas,r9a09g077-fcpvd # RZ/T2H
+              - renesas,r9a09g087-fcpvd # RZ/N2H
           - const: renesas,fcpv         # Generic FCP for VSP fallback
=20
   reg:
@@ -55,7 +57,6 @@ required:
   - reg
   - clocks
   - power-domains
-  - resets
=20
 additionalProperties: false
=20
@@ -70,6 +71,8 @@ allOf:
               - renesas,r9a07g054-fcpvd
               - renesas,r9a09g056-fcpvd
               - renesas,r9a09g057-fcpvd
+              - renesas,r9a09g077-fcpvd
+              - renesas,r9a09g087-fcpvd
     then:
       properties:
         clocks:
@@ -89,6 +92,19 @@ allOf:
         clocks:
           maxItems: 1
         clock-names: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a09g077-fcpvd
+              - renesas,r9a09g087-fcpvd
+    then:
+      properties:
+        resets: false
+    else:
+      required:
+        - resets
=20
 examples:
   # R8A7795 (R-Car H3) FCP for VSP-D1
--=20
2.43.0

