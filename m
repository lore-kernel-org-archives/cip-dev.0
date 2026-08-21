Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1CEC5DF87
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 13:17:12 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.66])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7130.1787318224961058284
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2026 06:17:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=EaBVtH/S;
 spf=pass (domain: renesas.com, ip: 52.101.229.66, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrLkWdY18hgvWVChOFbYPUcLHKgy2bJmM5GqnDTM01rAD9S577BVZrbalip83NV/gA5h0hMPJVgKkyVHhPbUS1NUGNdRUtAWbB9qdEODBxBUJEe1tnA3OMci2Gxbth5nXrQ20wwwBuOBYBDzBd1aSy3cBg/FR1C+HM61OTDxWO9XbQQEcKKv8DUccccQBIQIND7PWUGTWxd+HrTaYeSbfTNA/mrryvy/t4+9so2vEUO2dPd35C3SN6QVzc/b5m5ctBfS2XcJlsmONpDenaFqifWuECd+JBFDs2ihd9y4UUIdPD9k+Dr43dOHQXnlPWhNR+fizGusHlNWtHF/88azBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYv5JoQb7Q8ehrUuFqj//O1FQBRRBv2AsCL9x3ww/rU=;
 b=iEt3yq6gw1rC0kS/IFFbk1w3Z+8mCOeRi/W9Keqv0P6se5i2ns6HjXpdGDk2GN7k4GJZtk/sLXvytn53FQwFpdfJbtMyR5ZSska89PF0OWaJVGK7k6gttl+qQZrSkPGEyV3Fzaa2kcJTnkKsTvmV7kcTaLjJn59/s206HxjaA2dHLo/IyuFW6b3HsroZfrqqQl0xRjAcqSHQZKrYR3Y2d9qGe33fTReC79He9nUB32rpFjAFWAbZYeRu8W3jMf1E1t5HgsDl2iJqCofMYYzccpkjgpIl87OjV6GknlqokRum4rUV9kZc5wEeEcpqCPCPo1LWTLyGLv4OTE562778rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYv5JoQb7Q8ehrUuFqj//O1FQBRRBv2AsCL9x3ww/rU=;
 b=EaBVtH/SwKywTzZZFADKvJ44tUZSNepoEKOpDfQIWA3S5DsWQUBS1rg6jG5NrUsHlKWL/0xrmbN0M8bvUg7271X5Z+u6VKY2/fEUyWP/fFGZ9taxsXq0m0zCE7MyAT4OgInsGZh5LHYIbhnC45b6ktjWP/SYSUiHZ3G4qRplyoE=
Received: from TYCPR01CA0161.jpnprd01.prod.outlook.com (2603:1096:400:2b1::11)
 by TY3PR01MB11241.jpnprd01.prod.outlook.com (2603:1096:400:3d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 13:17:01 +0000
Received: from TY2PEPF00005624.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b1:cafe::30) by TYCPR01CA0161.outlook.office365.com
 (2603:1096:400:2b1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 13:17:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005624.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 13:17:00 +0000
Received: from demon-pc.localdomain (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.179])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id ACC2B300037D;
	Fri, 21 Aug 2026 22:16:59 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 08/18] dt-bindings: interrupt-controller: renesas,r9a09g077-icu: Fix reg size in example
Date: Fri, 21 Aug 2026 16:15:44 +0300
Message-ID: <20260821131554.638741-9-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005624:EE_|TY3PR01MB11241:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3afd39b4-38fc-4359-9989-08deff867c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|6133799003|13003099007|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	dIBynRaeOzUFILX1Gq9wxFBlQhE9zWV+jSKvLip0oEnhIlvmszTS1AcCmYgxfkM3VQrOUPRYuFsy6CGKYqiR+mAbAi2uKuajj75YjteUZUflCb0T8vlw0BAIDXygijhd+oJKhJT7B+oSR04JxXMxR9ftHhuaG7/Ya9s9iQcdBfZgpSxdOWSXaHwiGw70r+YBdeatWztFe5wwj+/GGwBSDR2Uf/+gBR4WlupjJav6L0EuGZE4yq3gyo7yPV8mK6ENZyPF2VJVpyOuJMagn2qZiTHuaWweqk7opVjsuewHBxeMcEiEs1U2VMO7juY5wvz/YYyXLpp93QCa0l3abe3l0menmvVZ9DLBaNiJGVQwNO8YU13TlVKry2V0ymBHooEVHbT85W7b7imEhXk/BhamDucegiOa9LF7qOHVxkQ/YkpWVJzxjbwGNz3DtP7vwaLNI5SF2HOoWR/eVmQ/ModZj3BPiSAcxq+gKv8KxyxFErgpfA0CMUwojnmh5MnsX0twTo2339D0EvpWFn3EwdsZw45aiM9O6AXveOj1ZS9hm1Y0WYPpB2ydstYS/GkU8unk7eNNEySyBP+JYE0dWHoXqhLDL5qrf3B3VBCEm3FeT6M7egQKnZZXJgGXAY30aI0bCWTO1gDlZiPf29I0ROpAc4Ucnal/ScGtbUMLc6mXJmE=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(6133799003)(13003099007)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	B+5XA6YdOXzFzqnG8+Eo3PRLgkk737ATw6pmEmVVGmn8BdeYaf8ZPR1JfjUAIK/asHxs05Zss900EKccFH3i6iDevgfFLwNvN4W6Amwk7EBNbVc+WrLTGe6JHTK3sBVgDYxg7cDtKoJs3LkM/KhgVlRJ+GMt1b/ysTMeoTCu/gyGBc5jPueUIiSzPj4h6yh7zg8TEjC7InyLo8h8FSyIC6OkAFesB6UvuvbucUPc+qwx5WtEzfactcFS0UCyqaATDeEu99zh9qGP585kNCUsdj8wFaq5nUmXAxEydP7DMlycV/OZT3yokGlR/3nEL3JQRrPo2EW29LuTvRAPc1IAZVgjy+OEFPyMF5BchTIoWrL45UeofI/1yH1+6AUKjvIZP2aISwlY5slyF9gUrfxTYzUckbU59f3Gzz7P+GEGn/62YR30j8cB9ET45wtOqRf7
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 13:17:00.9529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afd39b4-38fc-4359-9989-08deff867c58
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005624.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11241
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2026 13:17:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23963

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 8e45719acdd6bf0bb6bf083957b53e40340dcd41 upstream.

According to Figure 5.1 ("Unified memory map"), the safety register
block is 64 KiB large, just like the non-safety register block.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Link: https://patch.msgid.link/364ff570c8a1845fab24bd89557f06c9e406f8de.178=
1105007.git.geert+renesas@glider.be
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 .../bindings/interrupt-controller/renesas,r9a09g077-icu.yaml    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas=
,r9a09g077-icu.yaml b/Documentation/devicetree/bindings/interrupt-controlle=
r/renesas,r9a09g077-icu.yaml
index 78c01d14e765..a809bc4f7515 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,r9a09g=
077-icu.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,r9a09g=
077-icu.yaml
@@ -165,7 +165,7 @@ examples:
     icu: interrupt-controller@802a0000 {
       compatible =3D "renesas,r9a09g077-icu";
       reg =3D <0x802a0000 0x10000>,
-            <0x812a0000 0x50>;
+            <0x812a0000 0x10000>;
       #interrupt-cells =3D <2>;
       #address-cells =3D <0>;
       interrupt-controller;
--=20
2.55.0


