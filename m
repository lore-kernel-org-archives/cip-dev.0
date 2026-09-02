Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1702EC624D0
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:27:32 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8565.1788341250348671575
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 02:27:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=W/ph6FuB;
 spf=pass (domain: renesas.com, ip: 40.107.74.39, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGvYZHsHHRwKDPwV5iH+5xA+nRP4tP4qsC70w2bKNceIaWF8IpywPmIaMCib+GP561XRIKTnLrCNnTM7rqjKzCo8FD8RIzpUIk/i3MI+5xDlVKfshxhxoYcfSjpRaVw1OekzM67/se/KXQg4ldrmBiav6/7xyVPP7hxLscXrg1uzP9oeUfddQ+7zXzc+d/qOF3LjrCk/g6oz3FD/RQrQbJ5+NZhVf8+k/J/4HNuismdt/DKb5h995tXALl/mEcsES8FYkoi9bobzdkETpJa26gQuEB/wkIvARjiDec0ZB2yjK/go1VwjYNRTmUW5P4jXM6eITbaAE5HGd/mzWqdVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCAdsZ/Fu7kBwc+YhhlyKrUkMDm6hbEXJ9YGuwHeSAU=;
 b=Eynuq7jbqqOzJ8PLKwKz2QH+vxrT10hbzwqx6fBJaqSc63/93owmyhIvaNwOF5rLf0HYC+KR5s6JI6lUkJjUXCHGafwatzk3YnoAbpnL0/2CffEChTPcuVjh2j25jLwYk2A0kqRlL3CRUmZdE0RmkqCl6ajvSuxCl0lksrS8Ka5BI0EArhaz8IYFuSQa7TlV0iEcy/2Qd+6SlbjPJ2426Kd2kVHGzmYDYnqJElm4OO5xLL18phh7nlo7N4AX5h/tlj7tmYyyGAfA65S0gM8760Jx12BsMJEydLWJS+eC4Awi4y2DtxK935yim3XT3nK6R++Qw7lChdCITUHi0xhgtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCAdsZ/Fu7kBwc+YhhlyKrUkMDm6hbEXJ9YGuwHeSAU=;
 b=W/ph6FuBynMTuC+zUBEQ+45kpyTH5KqDgy4xF+8p/LdKMX3XidTqyiB0W0ohc8tUz+U5kgqaZ65EPdtk8eoX0ETu5CZhIFo28FfIcoVZmizKHP3kqnxqTfeUJ1U9PyiH2vpFQUCKbh5ZjW5nL4sjoWCXkWDyGXDgSTSVYN7tSy8=
Received: from OSTP286CA0038.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:224::11)
 by TY4PR01MB15093.jpnprd01.prod.outlook.com (2603:1096:405:281::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:27:24 +0000
Received: from OS1PEPF0000D216.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:224:cafe::6f) by OSTP286CA0038.outlook.office365.com
 (2603:1096:604:224::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:27:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D216.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 09:27:24 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.24])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 0122C3000363;
	Wed,  2 Sep 2026 18:27:22 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 05/11] irqchip/renesas-rzv2h: Clarify IRQ range definitions and tighten TINT validation
Date: Wed,  2 Sep 2026 09:26:56 +0000
Message-ID: <20260902092702.24746-6-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
References: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D216:EE_|TY4PR01MB15093:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: aae2546d-511b-4a84-12d9-08df08d465c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|30052699003|82310400026|36860700016|22082099003|18002099003|56012099006|13003099007|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	wIMBKU8/e46PsJ+5tNR12fPBtYdEfaX4Sn3Pg34LXdSQQ15PTB/51wYAgIJbVIp57veU026IXt1T3b2vm2h2YsprD2nMlcX+yBvdsotN99JioluLWnUC56gaykxTQCYRkJXPYDWRtCyUNv92Xat+Q0eM/qIuU9C744+iuvjmG5hF4nHoEFy0pQFstBAPAsOyjUFHXR7u+tCjsjHx8K5vZiPIk/G42HcslaQg9VeK/z9Jeewl83ZlVORbvleGKDryhXWmO9gnf9xiN/zN32rS1P7ijWn385TGKYsKmgOxecK1KW3ZO7/607LPTS/KpVwVGx3EPuPm9oFs33m/1ky+A0oLN5FGHnJ8c86jGvvuSYZevuN4/Z6/h/xbRRzZE1ZfATh8otvE3OLNG2MMRC/SdPDnwyGwU+WDq22WoHyQNivxEvTXJzxeLsyDnoyn+oqB6JUVvNpmaCQ+T/vpC6x1qMX8uhBp6Q6DmaRMQkiJUcad2ev9uYGTVxIt/RUCWhAGfGDPE4eYk1K4inZ0RhopxF6lb+t9LrbzAxIP7hPeBFEMJe3Q3s+IcQNMjYDidf13qRVJKWI28Vek6R7iD8BpgSUWeZG9+Ex8tiSeve+lSJyIz05zLqOnuv6MAVObau3tCTSwf2HZ3YTOXNF+2tZCp/kFPslppUVKYUNnz1NKsUo=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(30052699003)(82310400026)(36860700016)(22082099003)(18002099003)(56012099006)(13003099007)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	eZCRlKTtlNub9YBjoppiRvAnAmm21LG4EjofyrAbQbIkU0C7UQCqigqPAc/UX2fwhqb79JAAZFjL/G0sJREyKqSQRFD8QAQ9pNPptzcu6ePChUsqiAhk1T73KYlJRwYUIQZRAGfTDeo4+0FLSs4iZJbKlTeoODCKx3WJMkdvUhMEFSeVwfshIBoPmxdAfH1trBe9YpbpK0X4sCzjDQk7Bc7GnJ5ky3lth2HxJ0g4mSk5UflmweOLGgoCOe9CFlhIW1gs7J2gQmuevgC8T/cRfUmnC26tsTODuKgQHBzQulHh/S0bTqe0spakgVCvjJGnYwNccTWAN9fkqYKxPSbF9tqDueLaxCAS2lHnJuZw303dRt/bkF43n5aR1AQ3OVn2aT1PvmDbT1P/ViafTG+jELYgbcuwgUuN2PNZRXySbiDyUZkWmuUWr1+4o/cq1DHB
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:27:24.2845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aae2546d-511b-4a84-12d9-08df08d465c6
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D216.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15093
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 09:27:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24072

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
index 7468eaec6bad..8a95f19a40a9 100644
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


