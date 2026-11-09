Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.40])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4569.1794226505415712947
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 04:15:05 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Um0qOXiH;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.40, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDjDRgGNJkYmDIwALtdcEIECrCLomUiIkamXAkCfE3EIiFhAzy7jAuLWrs0Z/9hVfNhr+OIvr+mKLnPfuovACzmEBzeaKMug/hK9wl2EfXi67Zrr9jC5WJSDCk3eSlztIdGfC0FLxeIA9XMptdZS2tAaJsjrgcLSZhqwfHHxX06Njj7EM05Cl6KbRjQBdHd0FMvhNQ9ULvNkX9GFXaHIzjQr9ocOF0wz2FJ0hk1OfSk+EHSqkoUTP24ldarDsEPrTtZYm4U2uDH/Nw0aACzx10KxjVSZziW+947tnvvM3DmqkQS22GYoyuE/P7LCoTpqATf1vRwWClSgHPNPVSibRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFVWqtI14YTRdR7zA4Nj6/5n0hskn95kBjExFlKMbWc=;
 b=R0S4kXA/lnyRJT7hbYLQK1HJhvoN7tAr1S89N2i4yraN2nDXo9J6crWhE+XuUhegKdzzMMwMF0kED6vUSVdb3DhcjcmpYVmeNgqPrYC7j54xA2BXdt3M18qb+q80I9eiTVJ/L5R5jYkco6yGZgstAjljOrZQ5TeoD1rkoanB5WxXPPHDf5Ss6ReYZ6xUrX0svsRPWltAYUFm71qMBGrhC71Ug8yutPf0tj57NBzf3OeeOjHdjNuGI57ZciKKVXVDcfEgQjSDzKTOWkSH8eFOQNkVOhkteHnK1i4bN1fkn6UBnVPjaBwRB3LaZoBWp9E+v2Sd5tOHqnzhfxUEtWGLig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFVWqtI14YTRdR7zA4Nj6/5n0hskn95kBjExFlKMbWc=;
 b=Um0qOXiH9GcbZbGVv8bBcwGBtzgByzUc8wjNHGv/7MdY2jJXRhgs6RIaeMI23wqRYjNpWOasu2BlorPRGsgG3Y6vKzW/bUj0/eabkiVheUIIP6OjYMcb0nbgrknFad99Mg4lc3CaiWnqKNyzfptVxFCxdk5WEn+kNaG1hP0H8tw=
Received: from TYCP286CA0244.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:456::19)
 by TY4PR01MB15500.jpnprd01.prod.outlook.com (2603:1096:405:272::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:14:57 +0000
Received: from TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456:cafe::7c) by TYCP286CA0244.outlook.office365.com
 (2603:1096:400:456::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 12:14:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005023.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 12:14:57 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.1.30])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id F3DFB30002A8;
	Mon,  9 Nov 2026 21:14:55 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 02/24] dt-bindings: display: renesas,rzg2l-du: Add RZ/T2H and RZ/N2H support
Date: Mon,  9 Nov 2026 12:14:29 +0000
Message-ID: <20261109121451.6042-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005023:EE_|TY4PR01MB15500:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a44574b-37b3-4027-1d27-08df3e5b11fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|11063799006|56012099006|261021121427099003|261021123027099003|261022075727099003|261022105027099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: kl1I/PAuB+ofpVS9WvkZYo3EjVKqFnuN1ckOaE3rJF73WhEiZNhVtTciZwbDB3gMTeuHkDAG3IhTaWAfweHfOgnAJrlpl1D+TgDkfvH7/4L5xFcQp0qftp7N6eQe1TSLYhtKlvnOt+vJVwhJ65kT8Ydi+BD/YYQj5ib7jK04osrPpD0VZb+pf6lPC2ea997e9xB7pLECCg41USUTiMnMZEYtK2HVC4lYEbF5owUENVqjdDsfQDo5hqZsO3P/CjH7bOZjlTKGCE8v7HMXlrU1yK5KBUbt9ayof4LwktkOx5ztGkq/cmt79LKj9EcIJxffVXB99blR+v4z39NSUvwuaItTZ6HCi4s/OywkH4RiG1PDCFhTfcOrZ6GCV8zBOelPMhGT4xP7w1FMI3vxGE2SAaUue86hMwNrdFV8XjPxs8hp/Z+Eezz66iM/eGjrvbwUuACeVCHrn0VeFXmNeiiA3RXvZ1xSrDqPHCA/vmHmO8Wm6PQf1pVPQo6J6anTGHAmHFkbSAHqapoCP6u0EulvVGx40Y+GYpmGGHEgxPe9qDv1yETpw/YZzLySKAgRJtyeN6+ugSfGk/G3O/rITToZfqlP+OhfPlzyUlatWNG4CX8z5NbFqYTB14slQM6/pS2s7wCP0wyiFmECIQ7YUp51tHcJRNy4GYuPxnRkt2fcvoY=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8KJs/x0T/FxUyoadh57AWVBxAel5NWdkOD0XvGp7SjewjryobKRwLxcfszM3TEitFSdiBqaZCTuK3ezxg8Ndic7cw7e79zCq9qwqV7rxbol3Tx8hudtzAYvaIqBnFzvCoz8pjDC6nzviJUOit0KzUFqHE78z4Z8YZxifQjFXfz7q4BwiYbEq/cyUvmUSX1rwlWImD3ko1SpJYiByKsdfOZJbGMyHCcJYVWSYQeebEWhew6s1qn/VkqgrBKbtNbsExpnn00Z2vxTaOhQLUU5JKJyg5QEC7bT0ewuqJfQd03jbxpZg2aLh5POVwTDv6F+6Nvr8G2CJwv9d+3m0cRA95T6M3liN0JSgt5azIGPWSWC0dGFnSSMQsMBI7tsIUUu8ZuNAV2JBn15Q+SlBXiS8xIRdy+KVSzv3hEnvBem8xMPSwlEyrdlT+DPHz8ZpTfQG
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:14:57.4204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a44574b-37b3-4027-1d27-08df3e5b11fe
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15500
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 12:15:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24708
Content-Type: text/plain; charset="utf-8"

commit 4608f1ce7a4cc53973bfc6a7fc7999e53fbb0309 upstream.

Document the Display Unit (DU) support for the RZ/T2H and RZ/N2H SoCs.

The DU block on RZ/T2H is functionally equivalent to the RZ/G2UL DU and
supports the DPI interface, but includes SoC-specific register differences
and has no reset control. Add a dedicated compatible string to represent
this variant and update the allOf constraints accordingly.

As the DU implementation on RZ/N2H matches RZ/T2H, describe it using an
RZ/N2H specific compatible string with the RZ/T2H compatible as fallback.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/20260519160825.4082566-3-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/display/renesas,rzg2l-du.yaml    | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yam=
l b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
index 5add3b832eab0..7c84a9ecc7a70 100644
--- a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
+++ b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
@@ -21,6 +21,7 @@ properties:
           - renesas,r9a07g043u-du # RZ/G2UL
           - renesas,r9a07g044-du # RZ/G2{L,LC}
           - renesas,r9a09g057-du # RZ/V2H(P)
+          - renesas,r9a09g077-du # RZ/T2H
       - items:
           - enum:
               - renesas,r9a07g054-du    # RZ/V2L
@@ -28,6 +29,9 @@ properties:
       - items:
           - const: renesas,r9a09g056-du # RZ/V2N
           - const: renesas,r9a09g057-du # RZ/V2H(P) fallback
+      - items:
+          - const: renesas,r9a09g087-du # RZ/N2H
+          - const: renesas,r9a09g077-du # RZ/T2H fallback
=20
   reg:
     maxItems: 1
@@ -83,7 +87,6 @@ required:
   - interrupts
   - clocks
   - clock-names
-  - resets
   - power-domains
   - ports
   - renesas,vsps
@@ -95,7 +98,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,r9a07g043u-du
+            enum:
+              - renesas,r9a07g043u-du
+              - renesas,r9a09g077-du
     then:
       properties:
         ports:
@@ -138,6 +143,17 @@ allOf:
=20
           required:
             - port@0
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g077-du
+    then:
+      properties:
+        resets: false
+    else:
+      required:
+        - resets
=20
 examples:
   # RZ/G2L DU
--=20
2.43.0

