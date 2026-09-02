Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B92C624D7
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:24:31 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.40])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8279.1788341062903666227
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 02:24:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=OKMaOMP6;
 spf=pass (domain: renesas.com, ip: 52.101.125.40, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZyFGlevuPOp/mqZ49y8j7jJMOE+PqlLr6WvaM6ADvQEKERV2cLIbo0l9DvmkKAK3D+mBY1gY6E8A3IO5EcxR4vvk84XGm9urJnVto3AYdQ3H2YRiGopsptT3n5nIuMuCTD58Cv612Q8QCRAoLlCbEceQmffmxaltppzVV6TyvRKKyXGYU7M0+SJJiAL01cSdhsUIvl6J4HBRJtZbFbaVl63dG3eK0PwFT9Y5BXpcDunQasm2Grot/jWMT3boJdu195mO01HE+GfMhOlxtjqvKUUUcZZVd5BMONy9aDJRVW0PODPMYK4yl+816c+c9b1Ty7Aog7GDJKimhYHgGzq8GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYjfxTns7Dun/RwkY5FPsf2YvdCGGM4wHNzTADlM8oM=;
 b=mJT5kAoLqmMet/pVBZpjGAofRkNHCYSLxTE03i9R/xLZJDI93BX8mtHvZkhXjO9a9GBJja2PJUnt0BgYHSpbNWemFZTWxmZ9GJN6wItyWukX1/YYWbvqKTK3Z4JK6b5GooSlhEcBsrDGFUCnrsgqjGZWxPy2G7FMeSfymsVgfDD2b7h19CPf6k+6fpoN+5GrRLtfOddtVUA3H1b/DjEY0XXfboibHrIgdAKRUnarq4Ey7EZA913+y9TEtjIto4Y/rujvuFtaLzK+W36pQ2mJtiZxjlDo+7cMhcNeoKzX8qu0CLDo5gdsrOP1zkE9Rvb1G0JPLEOOq5OHHrzerKzZ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYjfxTns7Dun/RwkY5FPsf2YvdCGGM4wHNzTADlM8oM=;
 b=OKMaOMP652BpA0vv46f5V8tTmKODBbYhv9EsTj00MEwVEfwd4F7jw+owwyqpL/wHjGKaZGRKLqDFO9hJkkG+Y1+TmgA3m17+sifTmjBV0tNM30Rx8bim0DV9tmZNlgI82e7I94mTwYoleZyugF12OvYoZj/FaLpJcYYxE4s+RwU=
Received: from TYCP286CA0260.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:455::18)
 by TYCPR01MB7894.jpnprd01.prod.outlook.com (2603:1096:400:183::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:24:15 +0000
Received: from TY1PEPF0000BADA.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455:cafe::76) by TYCP286CA0260.outlook.office365.com
 (2603:1096:400:455::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:24:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BADA.mail.protection.outlook.com (10.167.240.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 09:24:14 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.24])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id C20DD300034C;
	Wed,  2 Sep 2026 18:24:13 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 05/11] irqchip/renesas-rzv2h: Clarify IRQ range definitions and tighten TINT validation
Date: Wed,  2 Sep 2026 09:23:46 +0000
Message-ID: <20260902092353.24648-6-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
References: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BADA:EE_|TYCPR01MB7894:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 01211e9b-c116-41d3-ee8e-08df08d3f4f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|30052699003|23010399003|376014|18002099003|22082099003|13003099007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	bSxoBR15K1tZ9Sqrd6E0vLopMf//UU6J/XwrVjD2x4zkw0i2XdqUPLwA+3Nfp60VmiXRUVOU8MJo+gx8wLk8nQk/Nd82/NZ1zUkO/kVMRZeu6iwLSUPfX2P8KP4T+VMnQVt7qOywm93OZ1fodDq6igTy7IKeKvRXxf6G0jn8LEVWmaqwfn220AGB/2/xNuabOHfBuD7gXa0qRnMTNzNLm1wwbbryd2tHikzbLC1eMpYgQMiEFY4OZqV9H4pmPoUhZpdD1R9y/HuJK4K4VwlfueJa/0ViUnOoVHuXhyLdQPRO3mw4foAUoH8CKT4vDB5yqrwlMVIWBE0dkjLjOoxfZntYZ5dZDViIvMg8CE9i2BR2xd5XZCOFAH4xwxmStfxiSaVq5Y0cU/LVJ/FDD+azI6Ib4l9pzjdo7WE1CdLhe5I3LwIWlCkWqUSAAQc8TIuQ9uDLIqIMb09GBiX+ZwqzpjWiIiI9sOeYUEDvfqJVxuk0PhvzbgH40QWd+bPuPIcWgi4tIEgdqk01QrEwLgtWOWjxQuq0U/tNZMuIJprqHDAt224SHDHokX34YLzWHtD5LYczjIB7VNaUl2AHLfzDezz4T226U/QeNuri8zVPeT1MPJc7JTmY0UemTSz+p1ZkZzYgjEqoejJgIjxQT3B9/3lW5xmuOvPVpFkGG7ax4Vw=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(30052699003)(23010399003)(376014)(18002099003)(22082099003)(13003099007)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	b7PzP6kcwJbM49rNTaeVl9s/pFZJOIJR9IK7FFn0RBINF4y/YNmSEYzBK3G62kL8dIG1cjiRNcnVvki3Se1hI1v+hv0rlmIj1kiAJT9P6N37cRKaLMl+vfM11vpFAtGQbs0d46np02jblo3RBWjoDVaet1b818TP6m5xO89t9iVBSfkqDKFmWXLRTf8T4DBEx8Gv9m2Wz+5alLdt7U1lraZduKTi3pDmDC+AI2CwWJMdJ4YZQyEk54P14x+vOSgKfgpmtQpR7h2TAufb7PI4t5wfCsa6KKN2ezD00hR9/7kxP7XQuRGSMSnHczb8ENr8CyIeJiAzbazSaYT0iXEV5AiUigU4aQ4WgNurSS4ipxts0x5jGusoFW7cCpH/cahbUfWr5LvmpyNL7gLNNQBL2PZUyNsJ3Ma9x8RmqV58CbhJzsDBQJW9gsxGpI8vbou4
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:24:14.9953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01211e9b-c116-41d3-ee8e-08df08d3f4f0
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BADA.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7894
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 09:24:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24060

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 9dc4335758c983045ab38871e2411fa1ae7e438d upstream.

Introduce ICU_IRQ_LAST and ICU_TINT_LAST macros to make range boundaries
explicit and reduce the chance of off-by-one errors.

Extract the TINT information up front in rzv2h_icu_alloc() and validate
the resulting hardware IRQ against the full TINT range
[ICU_TINT_START, ICU_TINT_LAST].

[ tglx: Convert the hard to parse inverse conditions to use a simple helper
  	macro hwirq_within() which is easy to read, less error prone and
  	avoids a lot of typing ]

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260304113317.129339-5-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index 3898ec70462a..b6ca865d9e9b 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -25,9 +25,11 @@
 /* DT "interrupts" indexes */
 #define ICU_IRQ_START				1
 #define ICU_IRQ_COUNT				16
-#define ICU_TINT_START				(ICU_IRQ_START + ICU_IRQ_COUNT)
+#define ICU_IRQ_LAST				(ICU_IRQ_START + ICU_IRQ_COUNT - 1)
+#define ICU_TINT_START				(ICU_IRQ_LAST + 1)
 #define ICU_TINT_COUNT				32
-#define ICU_NUM_IRQ				(ICU_TINT_START + ICU_TINT_COUNT)
+#define ICU_TINT_LAST				(ICU_TINT_START + ICU_TINT_COUNT - 1)
+#define ICU_NUM_IRQ				(ICU_TINT_LAST + 1)
=20
 /* Registers */
 #define ICU_NSCNT				0x00
@@ -487,6 +489,8 @@ static const struct irq_chip rzv2h_icu_chip =3D {
 				  IRQCHIP_SKIP_SET_WAKE,
 };
=20
+#define hwirq_within(hwirq, which)	((hwirq) >=3D which##_START && (hwirq) =
<=3D which##_LAST)
+
 static int rzv2h_icu_alloc(struct irq_domain *domain, unsigned int virq, u=
nsigned int nr_irqs,
 			   void *arg)
 {
@@ -506,11 +510,11 @@ static int rzv2h_icu_alloc(struct irq_domain *domain,=
 unsigned int virq, unsigne
 	 * hwirq is embedded in bits 0-15.
 	 * TINT is embedded in bits 16-31.
 	 */
-	if (hwirq >=3D ICU_TINT_START) {
-		tint =3D ICU_TINT_EXTRACT_GPIOINT(hwirq);
+	tint =3D ICU_TINT_EXTRACT_GPIOINT(hwirq);
+	if (tint || hwirq_within(hwirq, ICU_TINT)) {
 		hwirq =3D ICU_TINT_EXTRACT_HWIRQ(hwirq);
=20
-		if (hwirq < ICU_TINT_START)
+		if (!hwirq_within(hwirq, ICU_TINT))
 			return -EINVAL;
 	}
=20
--=20
2.34.1


