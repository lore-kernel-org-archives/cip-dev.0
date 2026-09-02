Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE23C624D5
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:27:42 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.3])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8333.1788341257176717466
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 02:27:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=NsuXho33;
 spf=pass (domain: renesas.com, ip: 52.101.228.3, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1wwMIRWDC0QSwObKvhbx6Yo9Rf0xrDPuktWRGc9OikqqbJRrIDUVodSI2CX6YTienjYETCb+EF44fr66KwtWI9ogcs5wKE1cCcTNGEd3QSqBuSZtGg4LMAyeiZuFE7ZJVvwCTvnP45oV26Id4A7oy1LvVjUyQXMwgCUFLD6sTrEux2wwmtspryIsj1Ja3hjywOJ/gTb9SxJvf5HYv0QsvOSCDuEEWGcdD4yOrxOPh0NpgRyv1uyDnIsf+vrcs5znuPuM94FHvQ4ZSePFqdx9q1+KmdEXIX35htQw7yB4PqB1jlCSibebONQj1V6buFTUSjRbjJL/bqbFSfgKzi40A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vuzltgdijl5W/AHP7PT3ViBXcBjs4RCgo//IBsWh/o=;
 b=Dhrcuzhnh2l2e5vkyea9XvG460i6EpODUxjzv4wmSdKmqOAGcoetxkoXcR1u4NwTaUWRM40HSUu/gNIDzaaSDgJiFVbIwpRUNymfdS8mqNUdTdqTpGLQtXKz6lBX2zJuJ4MeNyEircd6R0cLsJzOaK979wwrN9UKzyR69nHUohQrnqf2KZff4vfMz1lEhaZ4W3fcvx4S5nJYzdBy1nFwiYA4TuXSI9/cBWnZH7mlilqsRrQVOSaTx/lF1znIYKD3IjAYWp2C0LBGe+sHXYE9sX/DVyK1jUyQWCWKIFwusSaK0F92RNKNjOdj+69ZR9tQgYd9cYc3FM0yIXEJpgBpOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vuzltgdijl5W/AHP7PT3ViBXcBjs4RCgo//IBsWh/o=;
 b=NsuXho3376t8d38R6TOMCvJJc7665TmJPOj0P/jqIuFWBveHav5JXPjadLFNgKAVTXK99+KhIDCqNUfAU1Nfj9/jsH9uaesoqfSYhgFdMZ56OuqsnZ3baEm0pIxV+lsrX+u+jM/lFrG+9l8+YKdT21x8jXQJWM0L0EsC0cr+uIo=
Received: from TY6P301CA0030.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:3ba::17)
 by OS9PR01MB13131.jpnprd01.prod.outlook.com (2603:1096:604:30c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:27:32 +0000
Received: from TY2PEPF00005621.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3ba:cafe::8) by TY6P301CA0030.outlook.office365.com
 (2603:1096:405:3ba::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:27:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005621.mail.protection.outlook.com (10.167.240.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 09:27:32 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.24])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 6D864300034C;
	Wed,  2 Sep 2026 18:27:31 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 10/11] irqchip/renesas-rzv2h: Kill swint_names[]
Date: Wed,  2 Sep 2026 09:27:01 +0000
Message-ID: <20260902092702.24746-11-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
References: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005621:EE_|OS9PR01MB13131:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 623fc838-4b60-431c-3ba9-08df08d46abc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|10067099003|11063799006|18002099003|22082099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: 
	pl4BeM88iyH8MIR08dxH5ZAVXwDdRwD2AmxSiZfUVFJ09H9SMoq3QpDseY8cpfXxGMJRxywquEcJzyUBj2CCeiAAjC/urBZ89uc+HWtw4h9khN0BbuP4F/vogpmKur0VXAIIv8SWFhgyogTRvRBhUH5AdJhofFFJkMsiFS1PUnlmGOW1Z3qWapGLglQhrHxZGqxF8ysob+bv49JKRJiPt9xfZzGAXtLgbSyMD1yX7SgfAO5Ps5ANqDxQLubiVdjXCCgE9bXeWqI7v98C+wynM22Irtxb5AMvtCPD7py5AY7hIVpGimAsdFKrxoGDWngU0rnydL3lJ+jwNDwuf8m/k31I6PR4e0voJDKGhS/m6m34rJEUtE5h/3UOMg+ALiRRyzkAreVzFBLqth62UVARDgKkd+et3f9dQYNxH3S0xHI0nvemnH80VbukIHDi51WuEf1EYZ1FtquvVB9D81nIm5GI0Nr9+hSpeOHedQrV6h28/t81oESz74p+P2EjvI4DCnwx02bgFiR/sTrCEJn9vFOvyNL8MrI9COSR8iUX7AKRle+kVZTFQ2NtYWVmQkhtz8hzt/1Ct7r4MrBOYjvZ2SuvrWQosvGgrtXy2KUPMCdcM8sTENZt3STSgDdSwdp2zzzqDIPeNHD+6vyoKYgY7g==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	DkjvoKnL3XFhqG/Nw66DDS4D+HLRqKnh6EYrkyZQKDKV8bvPKfZUZNtj6vy0HQKz6fxNtbml1E3Xz6Lb72GrxrE+/jxRCOyZkgBQm3Gfk0U+Q1GJcW9R9MvF1TvX75s5I/q2nnsE4tb/ZgjvKH6bkBM9LiyjogZce9xCSaib9kxIthFyb1YFXwVnEhnoDnA8cpx7PqZFkhPnxm6Q+s15eQHZLwZ4zS56fhcbfdewxEO9+jnUTSqKbY0czeD+V3VqOTVI0kewCipvyjv20y2VWcJ808P876VwmiPeSqWxR09Wy8d7tUgBTMrwLuZvMW9AkUnz2hACPk8GqHBXH+8XTar3fppiH4ivoJUEYkRIueidHoMmYLAfu9tVF+uTwykhdgUTMYdkR4dARo97EBOY/BzokP0KCYp18gCWkaOLhohE0qx5wUy7zljc9vNyM+3w
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:27:32.6210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 623fc838-4b60-431c-3ba9-08df08d46abc
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005621.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13131
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 09:27:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24076

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 8c7ffedff0db88837de11cfaf3e5367e0b77bc4c upstream.

The array swint_names[] just contains expansions of "int-ca55-%u".
Replace it by formatting the strings where needed, to improve
readability.

Despite the two error messages can no longer be shared with the ICU
error cases, this reduces generated code size by 56 bytes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/aceab3fbc307ef428dfd62d8d846b68704dea012.177=
5205874.git.geert+renesas@glider.be
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index 5a1fedb492ca..4f687510f903 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -758,10 +758,6 @@ static int rzv2h_icu_setup_irqs(struct platform_device=
 *pdev, struct irq_domain
 {
 	const struct rzv2h_hw_info *hw_info =3D rzv2h_icu_data->info;
 	bool irq_inject =3D IS_ENABLED(CONFIG_GENERIC_IRQ_INJECTION);
-	static const char * const rzv2h_swint_names[] =3D {
-		"int-ca55-0", "int-ca55-1",
-		"int-ca55-2", "int-ca55-3",
-	};
 	static const char *icu_err =3D "icu-error-ca55";
 	void __iomem *base =3D rzv2h_icu_data->base;
 	struct device *dev =3D &pdev->dev;
@@ -777,16 +773,14 @@ static int rzv2h_icu_setup_irqs(struct platform_devic=
e *pdev, struct irq_domain
=20
 		virq =3D irq_create_fwspec_mapping(&fwspec);
 		if (!virq) {
-			return dev_err_probe(dev, -EINVAL, "failed to create IRQ mapping for %s=
\n",
-					     rzv2h_swint_names[i]);
+			return dev_err_probe(dev, -EINVAL,
+					     "failed to create int-ca55-%u IRQ mapping\n", i);
 		}
=20
 		ret =3D devm_request_irq(dev, virq, rzv2h_icu_swint_irq, 0, dev_name(dev=
),
 				       (void *)(uintptr_t)i);
-		if (ret) {
-			return dev_err_probe(dev, ret, "Failed to request %s IRQ\n",
-					     rzv2h_swint_names[i]);
-		}
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to request int-ca55-%u IRQ\n", i=
);
 	}
=20
 	/* Unmask and clear all IP/CA55 error interrupts */
--=20
2.34.1


