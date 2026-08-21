Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682F8C5DF95
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 13:17:23 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.64])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7173.1787318238483832932
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2026 06:17:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=ALxJ128a;
 spf=pass (domain: renesas.com, ip: 52.101.228.64, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYnyes8hAsL0h2hDgbRVUUyN0sbWnQwAh4wM/V53PWTQOzDQbs3pwopvYsozMMCMS/pVCvYGn+RaQaht3vEI+hv57Zb+3WoilYz0W+diMYonT1LMaSpPeKiPgtD/w635yxWrnxiCz6dxkBNzGznbGaBey4upuoHIYD0OFcrUQUQnppl/KsEykmJz/Vw0iTVCEPD2nknH5bjNAkPggIYwOlu6+ak3ZkhhsyZfdb9gGVH9pEtzY0rHwJ1Tg+vNjlhaqFzyeBteRJFITLWuLaxZ9BjkaPknwjUXUEkQX/meN9iDt29iAUM6TnDS/4N5ZnuUSvJNfl0tASkIbL0KpOT15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkiYT9tMfyuu4cj877iGHEE7BXhBjPL2EYD//y8mLl4=;
 b=mXoNzuyRhaOYz0hzCfjbddTcjuqDXPQja9ijesDqMZsJ0FZ7Xtt9aJYiIV2Y8bmpQAZMxHMt7XAgiBzMgGucGML6HhFUcrRauchd1N38wowRpQ84U7DgUEKy2GzJFbB3wjhHnS+NBt3ufI3zkgouoGks8GYfH7DTQKQewbce7qgWAQu/2luUP+o5RHrcByC8zW4fhnWuAS2QAQniptDEBXOrYBL3Bv0+mt6q886zDo1dj5Z8jl36/KNmnfy4TPZQzqukVy4hibpWe4A7iVBEexJ7QQdsyoQZkydYb8wjoKmUDT6Ln+6sE17PElgU7gavn4I7IvTnbDeI68sTrjK/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkiYT9tMfyuu4cj877iGHEE7BXhBjPL2EYD//y8mLl4=;
 b=ALxJ128aSr2em3yToMr9Wa7CgwBKSfOlk8AeGPa/IKuOHSZMMwSBV3pkIW2Krr78QXpdBK6TihEIfNjuA4aDsK6/A8JZWuCV1av7yTBLuztJhwAugACj1QG6/YQKJh/CdLlT99dR7m5DqVArqYVKqvIjyUa/dE4FGUxYQB2tvpo=
Received: from TY6P286CA0001.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3b8::18)
 by TY4PR01MB17262.jpnprd01.prod.outlook.com (2603:1096:405:334::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 13:17:14 +0000
Received: from TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8:cafe::7c) by TY6P286CA0001.outlook.office365.com
 (2603:1096:405:3b8::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 13:17:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD7.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 13:17:14 +0000
Received: from demon-pc.localdomain (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.179])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 72E48300037D;
	Fri, 21 Aug 2026 22:17:13 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 16/18] arm64: dts: renesas: r9a09g087: Add GPIO IRQ support
Date: Fri, 21 Aug 2026 16:15:52 +0300
Message-ID: <20260821131554.638741-17-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD7:EE_|TY4PR01MB17262:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 010d87f6-1c5b-40e5-0975-08deff868486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|56012099006|10067099003|22082099003|18002099003|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info: 
	afuQSOkz10vMqUhxn3IcJMlSYPpZySLlv2SGUq3se4uOwJitmrKhuMCSwFP/gXnEfjo1FIoDijN8PdMojJHyznPr9/K0MU9FILjaE8+vNM1/bBFvPEGLKs5ZwT1fkSW5Or2JLx8WnPh+UJXEom/gP221Sq4Ixr+ey1LbTr6NfP32VYSl+tZGzU6IQn13MjYnLrIF0tytkbIGPgXyQC724tEI5NTrRLZmCJuKYQTM+wnUBzAJHsMOlHePkUxAyDtA4lkrn2xBxYeVjzvf+uD0ozEqE4OlNc+qFBjxztKlXJpnClQ4PoguapmhVttKWlR19+pclJ07Y35UFAwo8ZEGy1O2R+LMC5c11BwrUw5mOIkHIfX441FNvtpdqFH3EfkTVigBhllFFQczvkpt+HqTzBmAWp5Z46tapX3LrDxw51Mv8NOU22p4xW423dcgTBjWgjgqVzxwYrWR585k+nMw+d1MFDBTGG5tteNjDmYRmKY3SlgZiACx6XGVeG/kTQuYP6bJMXfBmyBd6MgxMNFOWVZIvi5d/qYGT5PyEW0tapLrMGtnd8/wzTS0qBv+ffXNWGFoJ4WyxH6s9M8GkTqEJ8gkgSAkQjPEegNLWv1nKqK8BoycTLNU53SWDnubYFIJVvyoSJ3Cm4joLS0zFIfUm5/OV052Zw4XfKz+ypOFNhs=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	pVMF1pSEBkyET7HzLef7vCNYM8OU0KuuplWcUn1MMIsk70O2GC7Y54lGhkXEXV7YbQwMkwmk4w+h9yiNEawP1RWyMV7HpfKIVA4kzchU94I0X5OTzdjBY1qi6S9CCOVBn80ZranuCeaTAhocWfNIKm/qf+eXEM2FEBEYhEMP4OVzMlV3OUsK8uj6VKV5/xb5p6Y6cBVQO8RpDcWSDRDA6Ujrb0URwvZhvtJRZIafkbi7f1bqvmGJ0NpOzJPDE8RxUwg7PCCBHBKZLhVanFnFDBuz6nhDW5y7m6nhI60e4gH2H8JnztfbCDDkGbkhTQ1veU3pc9DdnPNlkIAQdVhjjit7cjXPJTCS1K2x5e5KjlvuqgJAyxMHITcyDOAj1piJvilHyCEZ5/hUURY2VXk8YO86KHv9CLzaZVFHsk760RuWml3F5U8614E0XzQprw2x
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 13:17:14.6764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 010d87f6-1c5b-40e5-0975-08deff868486
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB17262
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2026 13:17:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23973

commit 7c9cf4eb9d600a51e4770e6ab876e123dd6b5165 upstream.

The Renesas RZ/N2H (R9A09G087) SoC includes pins which can be routed via
the ICU to generate interrupts.

Add support for using the pin controller as an interrupt chip.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251205150234.2958140-7-cosmin-gabriel.tani=
slav.xa@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g087.dtsi
index 48b56a196929..eb405ae6f03e 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -1014,6 +1014,9 @@ pinctrl: pinctrl@802c0000 {
 			gpio-controller;
 			#gpio-cells =3D <2>;
 			gpio-ranges =3D <&pinctrl 0 0 280>;
+			#interrupt-cells =3D <2>;
+			interrupt-controller;
+			interrupt-parent =3D <&icu>;
 			power-domains =3D <&cpg>;
 		};
=20
--=20
2.55.0


