Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1A2C5DF95
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 13:17:12 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.21])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7132.1787318225950137508
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2026 06:17:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=ZzZqzp3S;
 spf=pass (domain: renesas.com, ip: 52.101.228.21, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiLYysDwP5KyyU17af9mviYN8Dfjfq8VVKY4SPFk3oMf4d3ssMrsessW7+oyp9dNZkNzip0vPUUigjZLW1DaX5tc3gR0rEAXEafgPCzHCGLAOK7I1Qcta06vHpTD+i6VO4gZPv4kWrrVUuHUodn9q1OQ4CjRE/nZp1nEN0ciOUMFyQhAzaadMa2HOCyQ3K5SXLeHnM8sRq9fUhlcGLfN0Nia3rfmqhCNv+LkVOPnrloXh4cG4bxgv2V5iGOMt0Gkydr0od40rooNt/08TIQkQFvDWkeUMZIQ9XsBivkLKZvM9YQ4briZwaW+Bymi33HdtLxapi0CZ0jid4MaH/Cscw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxbpdwWLRS2TyX29yfDpcq6OlGC6R8i4wBIKZjl+f3I=;
 b=FCCTWpGHtDiNjXUMz6pi3jAvuZbm+YQL/lpjMztByU3+XqYVHWg0KX7z1eB52I8WSOFNaeQwIreW0H/gB1srytA8D3KNSqGHoCpLQn6WmZfM2EksTemAA6qQZI11dz5nzaC9JuhUKTR+4lse4bI6YPhI1Dof+1IjvoGOzcGiAgYigZT8CeeqVbVxBTJ/PvpXylXhoi4ou2d0GAm1a99jg8RV5dnleZxMRtlXYrTX/CrSMz3yKhzMbr18+uvuawp/fcN07t5QewOBk/dsZjr0FFmE7ugRTjB8V8/FDLwGO143O0DAns/WKoiSuchBCy5ORTxDR0CYygv/HG0byCA5tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxbpdwWLRS2TyX29yfDpcq6OlGC6R8i4wBIKZjl+f3I=;
 b=ZzZqzp3SP+sFKR1rSADLOhg+Ul/CKQ3p8mgAvW/WiBOjIxwxpZ+aSe+NIFzJcrp6I7HPkHDPopoGO0JZRUo0cvq24xWuOiFSBk2R9kFx1Vx91Lki+H4Qyoo5pNDb7NAM75G42EroqjjidJPMfFoon4QFCsmpi29jrYTrijBvmZo=
Received: from TY6P286CA0001.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3b8::18)
 by OS9PR01MB15459.jpnprd01.prod.outlook.com (2603:1096:604:3c0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 13:17:00 +0000
Received: from TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8:cafe::3d) by TY6P286CA0001.outlook.office365.com
 (2603:1096:405:3b8::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 13:16:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005023.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 13:16:59 +0000
Received: from demon-pc.localdomain (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.179])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 0083D3000374;
	Fri, 21 Aug 2026 22:16:57 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 07/18] dt-bindings: pinctrl: renesas,r9a09g077-pinctrl: Document GPIO IRQ
Date: Fri, 21 Aug 2026 16:15:43 +0300
Message-ID: <20260821131554.638741-8-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005023:EE_|OS9PR01MB15459:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7b078452-5473-4845-4efd-08deff867b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|13003099007|10067099003|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	ocdftfpUfci2Q06T6tneKVLz1nsDL8OB8QkVtYnqzzDNHmz6CWwULz2L5lvz5FE74gbVddovI7CEBDVJw3JZa2BpICqh+GSZkgcqNp0TNTBHfZ0t8X/Xzu9AyuqJpk6BY9lPonTKfDIxrZ+pA62YSrStvwjnu1FgUvx2vvks7Ntwnwn5Meco54pa2P1p6Dju2JCJxcM2t+0kkd95ZAcjPTx5MB7IKPQSANcNYmUAZandltYkWVRIcmwUTAMgkMTZWJ2wWN4f/bdePsMk3JxLqZqkz5z5VXl2a26tl4XikTg0nDzY76VKagp9N0OBgaX9Q4ij1lKg0hnEdGe1YedldHm/E/6qp+YrcknGT1MgFIJ4td6ckHWoGgUu4RBUSTp8o4J9GAGBRVqq70vlBIsRNg/EXGqee91blwCWRdj9lrngKN7XppfYVwiv+ZZpI/fUaQs4PUSUnTUUxJ8Q6TwRFUjgSAhRSkhfu5xT91enJ+2Q6I/fAdPazacJemjB+oRguw33C0L4gQ1MMdNI1DKq+Va4kwk7M0do77kM5KzdA2Nt6T7gNUX2xyKmwhAgur3J3HEZidaYlfp4Km9HFMxQc6cMnwbQrlF3h2r8oM3Nro40VnKESvYeLo9H0IUUaR4Ya2l3nsDDGSJVWGg1iPZfDVxC3q7xrt1EsYKBd60VPpY=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(13003099007)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	kPTb+UT0lrfdO7cHI8Z+6N5tiv/YwCOlAPVTcoyprhBzdeSD02FxOo8Wg3ghluF+8ookkUbWBTMlLkPAcxH4QCL7UMXYCYWi9qHzcf1Ue3ndV+EeNESRs51a7PjpVdQzfVh3xeoaXTbZ6OD2LZ0oUCK6JLGU4PJGQaWKuCyDp7bYHzGJSkVfQJYKBeTmALQGy6Jjs/q3buJWSsIWsb67c5xAafeySD7TrqYtHJ8PIdyvQ5MQWqjMv+C9qggSjR2+fh2mWz2UN6ZiciUo9gBfFVQSGK/nee/BCl4x0S5DpTIMS5i2A52hP5idiYIMmLS+i2c/eeMnonbAEMa7pATO+559jMMT5KsR0hpuZHVilEniGlS5qQ7TgxMvpsU0/z1dZ6/z3VSu8VXbG1oMUh9WvuCUn4M2lo+ePUOYG76KjGXdSu43EkuVtiydY1+7rdbV
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 13:16:59.4818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b078452-5473-4845-4efd-08deff867b7a
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB15459
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2026 13:17:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23964

commit 8b12070746854a70bd43d5763562561efc1840de upstream.

The Renesas RZ/T2H (R9A09G077) and Renesas RZ/N2H (R9A09G087) SoCs have
IRQ-capable pins handled by the ICU, which forwards them to the GIC.

The ICU supports 16 IRQ lines, the pins map to these lines arbitrarily,
and the mapping is not configurable.

Document the required properties to handle GPIO IRQ.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251205150234.2958140-4-cosmin-gabriel.tani=
slav.xa@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 .../bindings/pinctrl/renesas,r9a09g077-pinctrl.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,r9a09g077-pi=
nctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,r9a09g077-pi=
nctrl.yaml
index d622cd94340a..63993b20524f 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,r9a09g077-pinctrl.y=
aml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,r9a09g077-pinctrl.y=
aml
@@ -49,6 +49,17 @@ properties:
   gpio-ranges:
     maxItems: 1
=20
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description:
+      The first cell contains the global GPIO port index, constructed usin=
g the
+      RZT2H_GPIO() helper macro from <dt-bindings/pinctrl/renesas,r9a09g07=
7-pinctrl.h>
+      and the second cell is used to specify the flag.
+      E.g. "interrupts =3D <RZT2H_GPIO(8, 6) IRQ_TYPE_EDGE_FALLING>;" if P=
08_6 is
+      being used as an interrupt.
+
   clocks:
     maxItems: 1
=20
@@ -156,6 +167,8 @@ examples:
         gpio-controller;
         #gpio-cells =3D <2>;
         gpio-ranges =3D <&pinctrl 0 0 288>;
+        interrupt-controller;
+        #interrupt-cells =3D <2>;
         power-domains =3D <&cpg>;
=20
         serial0-pins {
--=20
2.55.0


