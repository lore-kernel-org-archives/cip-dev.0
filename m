Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C8EC43458
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 15:28:27 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.17])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.94847.1783092498942715263
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 08:28:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=cr3+Y0yo;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.17, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLVymbpTgKeMGP1fUDZTUQvu3Pl1wDCIicyFQRY4mDueR7nQiyPQGiQ/coeSgmzz9GOJJhWbvFJA0b8oFvbOjSSF3R35pJSYcv1fdOGrSqL1RwyNt7pRe9P/sLrhNqSE/vR+GMaE2JEeCBGqV+HsuTeiIHrYa/lU+uIT1D+0AeM0AF3re1CKpYhnke6o6cY2eYkKseSNNbz0T3yd8Qdfxc/GhlJmlo3dc/iqc4/OzI4lKczrOgKfhSDDPycagYAezsy/Ajb/v8BRIoT9zIxGVmC3+r8nYUAzdEQawvygb/QXxeKCNixC74lL5TOZjjuf+JYv+sSesx1HJ+Bfosla5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/NRKk45IF0Ew6OVy0kQ+cjFQbI5WUevXgIyfdM6OUk=;
 b=Vm+omChjtFMoBi0sdj3uU4ukDQ//7ccpA5H0JmLNfA88OYXQzqgqFO9PwhkPxtSWSOmv4t6G4ZYKk6q+9Z8h0j6zsAa2MoXSIPe2x70ta7OnPib3liCGVD129TOhcQevXzciPDjo+vyHypgBN4CWWf1GeSa93NFxtTqrot4Ul1BOZUFxJ96TeOdAprkW6DYjAcc7t9vGrNfJ4i3O2eTShCMDkesJYN7tHTQ5zWZ1daqWNSrYTZ5bR0dA4Ck7L8ZOd6kr0DgOTUtWPhmXCHBAcHa9tSAfXg7x84HgSUaOeTl22kV/TvosTVwy4SC++wsfA4AmM8FYcV2LVUUSGD8eNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/NRKk45IF0Ew6OVy0kQ+cjFQbI5WUevXgIyfdM6OUk=;
 b=cr3+Y0yoJS4DbpIU091fn+Wtwqjc+eo25XNca6W/TvgXMkaIgTjYzSIGdUWA8Vlx5gQslRjmL6HkWM2ORsej7rcpqdHGYgfVcYg8tDesadk6Isd+ILuPWDOmoF657xTq4xfIGClZmDmmKRrYcUgVA8LSeOKSKU+Y5S7lHWPwjoY=
Received: from TYCP286CA0230.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c7::10)
 by OSCPR01MB15894.jpnprd01.prod.outlook.com (2603:1096:604:3ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 15:28:12 +0000
Received: from TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7:cafe::41) by TYCP286CA0230.outlook.office365.com
 (2603:1096:400:3c7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 15:28:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD9.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Fri, 3 Jul 2026 15:28:12 +0000
Received: from Ubuntu-22.. (ukr-5cg4053kvs.diasemi.com [10.24.0.5])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 4B3C6300023C;
	Sat,  4 Jul 2026 00:28:09 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 2/4] dt-bindings: PCI: renesas,r9a08g045-pcie: Add RZ/V2N support
Date: Fri,  3 Jul 2026 16:28:01 +0100
Message-ID: <20260703152803.29302-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703152803.29302-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260703152803.29302-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD9:EE_|OSCPR01MB15894:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: af756fab-2a81-4c6d-dc6b-08ded917b1b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|11063799006|3023799007|56012099006|22082099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	+JZ4bKL/lyu1QIGnQPtugkZd/c/GpUa+q/MKpnbZE9csambst3Lm58qGCn31D4FPr0IkVkcOKs2giqhEptSTu2ddFRbw3KBHD4g9xdnCmV+VDkG+WJHWZUp3vzSddkxpwVTs2ka8Upa0N9gAUyp0hBEDS6EcM56mSkyyh0Nt/JcKp+yzkbXYEulXWGeJbQMLI6tyVXs6tU5AW0ofW6W7do4furWx0Mx9JMwzsSOH06jSrdpfyKmW4sG79L6oC9MQxK7cufqRPFNyu64Wob9iKDpM670pKu3w2/mrdEI+oy+R4Ki48D5SZnypgNkgtdo08dj09+sgPITKD4ohF//mwfPNAkh/HV+oEIGqYR/2/nui0hZ5ij/da10as/Umuw0Vi69FFON1IsjRLFId4EqrbhRTvIIsS3Lm6qctM3jlUeZ1zruRfLr4YMW26148hnLsXviMbk1sUtVwjsveB/k/+QxHVLOj6sw5nooqym2SgQE6o5ptZ5Dwz/vIc8+eptlLo4BjyTvkivGf6u9HzmNQJthPfp1Ojp+uAneRcx1IIaBXOAtwdsV13r11+92KInlZqa1se0HRHx+8F1Np2QVPWFb7TdigIvtMYoVjjCc1mbxUrFBXJwlIv2TvrQ3HI3Xz34cx9ruxIJ9IKtj8YHDj6A==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(11063799006)(3023799007)(56012099006)(22082099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	+vNNP5e+D+jPTOKSZD7TU4s7k2UWeAxmjZOB6OwNtX/LBrWvSTd+6AGAruQUIv9vOBSKyPwLghP25joq9owF2Q6hvbRPu/uOcsIl30/6gDh0GLBw2FtRtwjU6Spjz4cXJNlKhChIXmM7zJGYmNjVCGG6sofVvPtfBp3xmYsGI8ugnxdBLxVnge3To+HRaIxf/qjJXMPp1fXr+g7ggz6rJtUZJXyymMZo2wYZOYIMhODcs+NdohcNts265JWWna1DmHnnT0Qc0aJhYb7qKThFq1PkyALgl+0NPtTzL9mdhDae1JrccR/yIpqF4fTswr7EUzzzntxl+j3LXEhi+CuGYZyGlif37x37xVreRhX0w6IZny0fONe9ER0o3Gh8crQDH+gq/dno1Pmu0y5hxYKn8EQL3R84By/ddkAVsn1ey6/989RIJlNUb1zD/i0aPha7
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 15:28:12.1907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af756fab-2a81-4c6d-dc6b-08ded917b1b9
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15894
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 15:28:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23445

commit e8433f632171c5a8c9c43dfa61d347b09ab1ecc3 upstream.

Document the Renesas RZ/V2N PCIe host controller, which is compatible with
the RZ/G3E PCIe IP and therefore uses it as a fallback compatible. The
only difference is that it uses device ID 0x003B.

Make the binding title generic to avoid extending the title for each new
SoC, and update the description to list the supported SoCs and their
capabilities.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/20260501102407.29462-1-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 23 ++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.y=
aml b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
index a67108c48feb..90086909e921 100644
--- a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
@@ -4,21 +4,27 @@
 $id: http://devicetree.org/schemas/pci/renesas,r9a08g045-pcie.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: Renesas RZ/G3S PCIe host controller
+title: Renesas RZ/G3S PCIe host controller (and similar SoCs)
=20
 maintainers:
   - Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
=20
-description:
-  Renesas RZ/G3{E,S} PCIe host controllers comply with PCIe
-  Base Specification 4.0 and support up to 5 GT/s (Gen2) for RZ/G3S and
-  up to 8 GT/s (Gen3) for RZ/G3E.
+description: |
+  PCIe host controller found in Renesas RZ/G3S and similar SoCs complies
+  with PCIe Base Specification 4.0 and supports different link speeds
+  depending on the SoC variant:
+    - Gen2 (5 GT/s): RZ/G3S
+    - Gen3 (8 GT/s): RZ/G3E, RZ/V2N
=20
 properties:
   compatible:
-    enum:
-      - renesas,r9a08g045-pcie # RZ/G3S
-      - renesas,r9a09g047-pcie # RZ/G3E
+    oneOf:
+      - enum:
+          - renesas,r9a08g045-pcie # RZ/G3S
+          - renesas,r9a09g047-pcie # RZ/G3E
+      - items:
+          - const: renesas,r9a09g056-pcie # RZ/V2N
+          - const: renesas,r9a09g047-pcie
=20
   reg:
     maxItems: 1
@@ -152,6 +158,7 @@ patternProperties:
         enum:
           - 0x0033
           - 0x0039
+          - 0x003b
=20
       clocks:
         items:
--=20
2.43.0


