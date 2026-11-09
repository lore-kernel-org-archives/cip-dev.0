Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.8])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4572.1794226510182672468
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 04:15:10 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=dZFHDZ0A;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.8, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ey5X3YbZCuOlUEkQoVkoF3R3xtlL0jlbuXGGtqFnA8yI7RdvULUTDzJit54reOJTzcJ1YvKuAnFj2gna8kCFdsWtvCsLW1gd/8XlDLsK9qKY7JXI3qnQB7BKBh1ftnErgto6ctRxZe7vqEl+5qUlGUIivLExzil8KiPLMFKeg584jH6fzA2XgNwwsgRsXvJi+2Co2sO7kH8VZx4BmqvDTNsxSXIcsjZYVIQ2B+fI5WzM0w0y/pVbQBPzPIoaHvrwpCpLQCVAmWsNP9aD+N4qTlly5LTezwxt275GrTA0tGUHUKYOu1ZFzTXH0ytnSNiXtnNbYub8IznwucfJBbOZ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7fIhXaWQ7siQW2kwV8Fx1UySqR7u/yOkhnhsm6EbGQ=;
 b=vAUMamMo4ftWjGr1I1PX1M6gkockfomVUyCZk6J1V8wYm3A0ryK01A4rhER/o2w/ye6Bt24kP6yH7WxgLZPpSFxzoBB/vF/dlVgAAaklOUMOpZqWSJml8pX5uMPYLaia8nSBe00V6Z2mCJoFIxmZdgxhamKLXG7j5rX+Iw5icuGu8himpmD2RJUTsFbeRfIp9nLi2apMQFhg6YqkwQgi2k0a9BI3jnpG+fEL7K+pgyID7QWN9LUQ2mJdiddu9A9Auv0J2FS9eI1lAwnQ4Tui7lu/BUfoSl5TSraPj/aYzFhkjHAuGNTqQV675IV3LlgjcNsZn/BW2/Ju+pf6AU2U2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7fIhXaWQ7siQW2kwV8Fx1UySqR7u/yOkhnhsm6EbGQ=;
 b=dZFHDZ0AGeFCLtDR9Lc2mmpf3VticaXyufAUfFYB1jrj3MQvbBKoyQ2FHeq200pnq88t97GMbgivrUXXb/71V12vA2RBW5kcdnwkjrrmA0taXYnB7gvchdRtb/sVk+dTJvkDxTrFs2VTaQZSevmjLsVSoqhymQoLIAm7Hu2Pinc=
Received: from OS0P286CA0108.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:b1::23)
 by TYRPR01MB15633.jpnprd01.prod.outlook.com (2603:1096:405:288::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:15:02 +0000
Received: from OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:b1:cafe::8a) by OS0P286CA0108.outlook.office365.com
 (2603:1096:604:b1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 12:15:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003D.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 12:15:02 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.1.30])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id F3A01300028E;
	Mon,  9 Nov 2026 21:15:00 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 05/24] media: dt-bindings: media: renesas,vsp1: Document RZ/T2H and RZ/N2H SoCs
Date: Mon,  9 Nov 2026 12:14:32 +0000
Message-ID: <20261109121451.6042-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003D:EE_|TYRPR01MB15633:EE_
X-MS-Office365-Filtering-Correlation-Id: 583323a5-c9a5-4fbe-6cae-08df3e5b1514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|22082099003|10067099003|3023799007|11063799006|261028144727099003|261102123227099003|261022105027099003|56012099006|261021121427099003|261021123027099003|261026140227099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: asan3pHuzmEbLJHyyyctrsFG1uZRyItLR9sWDC0wq6mTiwAt2D5ftBa+q6oi/UBiNbzeZOHUToaBxMW1LUrN9TVehp9i4SFpOCN3I3BnMd7GcRTyn8ZT0itc2dAOMYUQJ3GyZaaN+hvfnIY8OVrIGZCIZkp3C1DxpzGtUaJ0u4Rgf6spSCKhVa5Ub3InY1w4AzbJVSERdi6rtHg5LWAf3FUPFaHzXqw6gm7UaSv6Z3aQpl7ADf8p/X2TtydY34bo+bUNmAGF429Ar+aC/It5VJ5Gg7RN2QY7FsfyE2W0NBbY2GiSCnPfpsgvNYcdgcRIraEcZGTi5OIkmnbOHuhu6pGc2JBmQ+9y3U/n7lTDzGq5KCiAmV92ZB6MQVcVHfrZhdQc68ylK/w3p8d9QxGFLonyAOkVQLHuNjnbbEw3hCMflZoP2CFEsPf+o8Kji4t0w1ACPICAZ0dBFOg1QpuUOAjYHloNR2DAkzkznj6mGNKkCyr1vrPWrKYbRlUSumrSLhtjcEAnFtEwAx7GAzH+u33y6jCB+XzVaTtG9MWjYlax8AOXheUmkeYSfInzWsZ3p9kYkNJyrHqUTPj1ouPncZVLGr4Tp6we9g7mqZxE2ONdeJ/PbVCxc2v2kQGcQCpJtB4jYMWBz0WTtqTqNum2zDeICZP+Q19iHVs7AGLOLQQ=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(261028144727099003)(261102123227099003)(261022105027099003)(56012099006)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KiT9A180jpA0rRUuRQTLYkpbI4hTSWgMBGm3dslXyY8tRRsQlkJNndvgFhT0vHaWe5RCqu7UpV7y6OILE2BOwlLPkXOEoOJZpZ5d4yGmYBC6w06nhNTvelByqeuprD4s5SdntUDcxRQ5ZlzW7rIKxCsLnHaoOl+lsgZXMWiy5urU4bs/g0Rmdi3rTfjtP1BdtnaIjsJ1Syzf/Lc9lNRnnuSqY+WjXVdACPRjaAaJO5ZC5+OQoWJiWVqXizPw2tNxVRfnxE/jUR9YUZTlnixLr3snvwUtMg7Nc94rJsInCBCfrFwioXrSGaGd1MMICAKoin7STGE/h1yrOdWi0aCIPBFR9nbGtqWOrZ2BquIkMVjNdeKlcrAh95+bumcNWiA3eStM64/jLuo49TTiaHzKLUdoU2Vzj42WYURxM7t2x7JeOQ3oGGpFtssaq+ieELp1
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:15:02.3552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 583323a5-c9a5-4fbe-6cae-08df3e5b1514
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15633
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 12:15:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24709
Content-Type: text/plain; charset="utf-8"

commit e98a1f15787430ed131207e83ba2f2b35dafafe3 upstream.

Document the VSP2 blocks present on the RZ/T2H and RZ/N2H SoCs.

The VSP2 implementation on these SoCs is identical to that on the
RZ/G2L SoC.

Update the schema to disallow the "resets" property for these SoCs to
reflect the hardware integration.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/20260430100929.1088281-3-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/media/renesas,vsp1.yaml | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/renesas,vsp1.yaml b/Do=
cumentation/devicetree/bindings/media/renesas,vsp1.yaml
index 722ae14718e0e..2fa4a1b672e93 100644
--- a/Documentation/devicetree/bindings/media/renesas,vsp1.yaml
+++ b/Documentation/devicetree/bindings/media/renesas,vsp1.yaml
@@ -27,6 +27,8 @@ properties:
               - renesas,r9a07g054-vsp2    # RZ/V2L
               - renesas,r9a09g056-vsp2    # RZ/V2N
               - renesas,r9a09g057-vsp2    # RZ/V2H(P)
+              - renesas,r9a09g077-vsp2    # RZ/T2H
+              - renesas,r9a09g087-vsp2    # RZ/N2H
           - const: renesas,r9a07g044-vsp2 # RZ/G2L fallback
=20
   reg:
@@ -55,7 +57,6 @@ required:
   - interrupts
   - clocks
   - power-domains
-  - resets
=20
 additionalProperties: false
=20
@@ -97,6 +98,20 @@ allOf:
           maxItems: 1
         clock-names: false
=20
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a09g077-vsp2
+              - renesas,r9a09g087-vsp2
+    then:
+      properties:
+        resets: false
+    else:
+      required:
+        - resets
+
 examples:
   # R8A7790 (R-Car H2) VSP1-S
   - |
--=20
2.43.0

