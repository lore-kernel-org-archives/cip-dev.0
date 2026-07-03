Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C790CC44501
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 16:35:38 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.2])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.97050.1783096530096585631
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 09:35:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=TTlGfTv/;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.2, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smu5FUfr7M+fbSMc/qVOg6AqOmel3811fjXORfsd3q3PFX3VZLEZtKC11J+9ZpK7AQj48Rg445YmBWXt6rzXc57C4jLAhNtSPtBaSRIrWNy1mTbyoX8/ksYfSS0etT6nbPABWKBYHiXwTQt7Lmkoeq/4R4VUq1xxtIw0EprPoVPl4os3Q3gVNKrhwxo3Pb1xb7g7dgOITD3CUzQDmm7HlnjjANdwM+4AG9jYvQhjh2JTaCkm6EBFnJ71Ef/J/7BXBmjhWFz+C4TrwX9OTGWrkHKxokwkN1JgqnBmfM+3rjeRhdUwoXcf92bp2I6nkUlHfErgHQA4zfM0d99lFwb8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/NRKk45IF0Ew6OVy0kQ+cjFQbI5WUevXgIyfdM6OUk=;
 b=HmrE+zRGwKHVRH9WEESfwO4Ag9Qea27biAwahNJaUKE+elcdxvTWw3LC10YWjXG1UYsPpjsGQ8XhudtkoVlG4HioNXn7YkXsm7qGsiX9UT0HKxARBDiMT9qeoAFva5JezGafZ+mv4aGOSMvildu52ddkZuQwaTRq/9SWgUfnb2thh8ViWHtteEkQswIl+R5xCUmr5HHGXEOp05/XYEncjTcJuN+Pg3XKzJgjD85UyyZYVd2QKMkPP8WXdNzJHEr8mSeduN2yxyI1GJw4VAUw6LP5BiuZ7glv+5MZV/mAZny0yblUYo12gvQ1tP3RDn7Fh2WwgZPnqpCyLTA3jwdeLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/NRKk45IF0Ew6OVy0kQ+cjFQbI5WUevXgIyfdM6OUk=;
 b=TTlGfTv/KM6YwZcdW2lGw+YbhYwhVgyESDmcv4WXU7JX2h7ZYbwUWI1VO8I0Ls8dqS3IWIqJsg3FZ8IRa6fjHzx54JL+H7T4jFW0QyemtOv9MXxa/tovl7w56a/RCfZRBNT0o8qWafl5D0kPI+ZXb5/EJe4FfHLkrGIuJbPshz0=
Received: from TYCP286CA0250.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:456::14)
 by TY4PR01MB12649.jpnprd01.prod.outlook.com (2603:1096:405:1e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 16:35:24 +0000
Received: from TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456:cafe::96) by TYCP286CA0250.outlook.office365.com
 (2603:1096:400:456::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 16:35:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005622.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Fri, 3 Jul 2026 16:35:24 +0000
Received: from Ubuntu-22.. (nld-5cg2234fz3.diasemi.com [10.24.0.5])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 51EA4300026F;
	Sat,  4 Jul 2026 01:35:21 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 2/4] dt-bindings: PCI: renesas,r9a08g045-pcie: Add RZ/V2N support
Date: Fri,  3 Jul 2026 17:35:13 +0100
Message-ID: <20260703163515.35831-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703163515.35831-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260703163515.35831-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005622:EE_|TY4PR01MB12649:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 825e9ede-fa8d-4483-409c-08ded92114fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|56012099006|11063799006|6133799003|18002099003|22082099003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info: 
	Fap1LtiNip1mUBo23HpM7HvuYA0ZFUBgHdv6AAYFopz/yvy+esbmt/rrgkLCeQVSWLIb40SLijcnqC2ovEqzIWXKmpZe5p2Crml2ZQw1lecEVPnNcZjL4lrthAeE89bQpTRpz+Q3aDoRQPWdFcCArfvsF6ZhlPfqqfUlwNJE44oGbEjrIHw6YZj6iLRos0ThhhoQl9dlVnlS0XfiOE45vdflRUYVSxyB4FUzjDLtolcSWyP3/nttddM3Jp380LUSI17qIkq7B2HcVrUOOf6Jtevcja5CtirY1r41uRlQDuUWtebwxz0Cd6iJfzz9edXPTavF6m9og/r4j5WkHfar2UX6ji0JLv0YiKwWLrYaBM2OKNe7n8WEX0SH1req/dVw725eea/coSnKbzqifHzVkRrid4tz17ZqK9qkQxex0SzIr5hP1sJBXYQEsJdTIZFsBNVbbIBTXt7f/+Fx9q1QG+X/PbRHvWnlF3d5Rt4CBSm8k8IFvxnUXw3O8deSmdHU5xubgDJqtXUaKSTqvCL9vF4WuLGMLlUxgHRwURI/AOK5KCcZdaaNQOy/9rpt8Jk6gopO7K12c9bkJcqObX5BOzQBF73En+mJZ6LM80vUaftBKI9IevUbAoVM0szb5CWYFVFI2kXyctp74xCYBHuqag==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(3023799007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	c2BSstj//+JMV80FjcQEx8rpBILCmPp4UQd9NPRimh0kTtENYM2937axlsY3MI6wiPDtSDcsihYpmQAgDmq0ZtkIq9kpZT2OBIxlVyu9/fPmQVB8Vrk2gNtt/v95tsUl6Z/9rB07XgfvTFMqhw4Df+lle28uQN6tK85TqXAYdPSJU4I8TVBISS+lvHxfN1PI90gOQ1iwHzr+eIb8FL8cIP01ge1qBMFj9UZlBASTkDV+sj4LCctFXyZYFhaGd+NPYKQhN0BeE5HnDN17Mxbqzxqi8I0WbULdYv6zzlSe2y0pCUUobezRA7p6fTw8vmnmmJ6Eyz5LjfcnDPIYiIx3pJZY9n7ho/WKJ3Rs7BsSOotztH0LbO0wUnjkerwHpZoy0/ke4nAD30KxsMCdjyE3+Bonyn6z7Ro21Un7LoLpqP989gGlLm1eF8asTMWbfb7d
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 16:35:24.1846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 825e9ede-fa8d-4483-409c-08ded92114fb
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12649
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 16:35:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23450

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


