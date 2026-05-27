Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23E0CD4F54
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 16:21:29 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.13])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24387.1779898886576934284
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2026 09:21:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=HYX3p4NX;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.13, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOns13fkehuMU6/UmyE/M7vkb+SqEGKvmSNC5YSthfRjTkEH+XrisJA1M4v2ULbgZF+b0Wnm4bRHC5EeriMR2Dj6rFAY8p6ZQDphXPakwJ3+3Pae4bju2jg55RAZnm9yP4EXkyQIvNRjVor39jbqwxoEl6751aWFpNxgtlqPvEBtuufrz36KpG+IWbtK+yMY39q/90Qsml33FMz4DRlsvlCFh8jgu6soThZimKoPKFzIZSvNFITp+mwyxvudvpHyLwlx6FNHh4HTJTdQ6+9Vt08prAC/gybdtdO4fY4NJrbZVspVuDL3tDp5Dznr0F4ii4mCFIfK3KrQLVwbyokNhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxZ5Qn7TDGIGMc6D9VcNsHcCLroa0RTqup6UrLTLBFA=;
 b=yVfb+CtmmhDxhYHga7inV+kgVr3bTTeObJhEv0dSMnykSeuNMNaEPgk7yRkU6b4P7vA9htlwPc9UbEgEk0OBouRnzsQ/Txpn0CZ3tXAU1k9Kz2OrSGNnD5U8FlZMgDBUGD0FRltuYUagKeq3Wg94EMqxb3hwymSHQW60Kf8vROL8POqJAxe6xK3HgrgvbSELZUHBuVIIxt1p909Ip04sCa/AlW0BzV6jEOkB7y3k7CshvpEIqsRKBqhjeYmX8w8Kn540ia/RHNCs71kddsks/sXSipwX9071xW83UTcXAip9NV+F+GdqI6qAIXcWM/FkYBhgGGznJI1wGG9MUUWwSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxZ5Qn7TDGIGMc6D9VcNsHcCLroa0RTqup6UrLTLBFA=;
 b=HYX3p4NX1PUcqAKAW8jIQNuEw8FfDJs+SiEk+kGAb0fY/qHT1J6Ize5BnSTYq6KssTuNizbgpcFe0QNvvZnvEccMWS1WfVIYjNjHSULqmkm65eonPOAEcaT4G80EWYiocB/lJFY/+eMnol7I9T9MrUUbiKHZb0KuIxdJ7ZxGU1s=
Received: from OS0P286CA0025.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:9d::12)
 by OSCPR01MB14646.jpnprd01.prod.outlook.com (2603:1096:604:3a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 16:21:21 +0000
Received: from OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:9d:cafe::2b) by OS0P286CA0025.outlook.office365.com
 (2603:1096:604:9d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 16:21:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20E.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Wed, 27 May 2026 16:21:21 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.0.181])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 7CF243010416;
	Thu, 28 May 2026 01:21:20 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip] i2c: riic: Implement bus recovery
Date: Wed, 27 May 2026 17:21:19 +0100
Message-ID: <20260527162119.52245-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20E:EE_|OSCPR01MB14646:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ed844eaa-caf8-4a5a-83af-08debc0bfda1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|13003099007|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	r/DqtgiwUIxlPSNI9vE0C39Gcj0GSGdljuAB7IavCo/W7VJatMoN5mzRHKxu/2cqHJwnZmeE4A1M/Hq3R/nyNVvlZHtP030MKQAM/00neNSvTVA6RF+RZX6rae74O2MgrsxM1sBx3K0jsKvOIovq1q7owi7uPiAdbmrnwlMMJ32OZREjaBH6y/D/wHWZ4FIv5+gw8xEp/SjWf204EFq8NcvPC+NhHG+P7xXXFry8iIPHYzHlaRT64GXTy4lh54mrgvfVJKCKGqEMgwwP/zhw+K7Ijmpi1FrZ8pWheYoXwogOpj/J8rjFq7iczXfGaipB1lWPDPkU7BkrbC5iRvFnUDWkuj7keKiYSAA6LGvOJqsNo9Z/YKoklXy7HA2TA48+i9Rva6CNiIYgRvzRb3g/91vBLOjTaDiiQPOW9w1N3x2WkJ2bnE0p9OiCJ0VTMYkJKWtPLOFo8bQdrQQf+11hLivqwYuIWcvj1QXbk8/p38PsfbBqfW1FrXqDKzNhWSo3H4dXI7JXoSxLWitrLuYc40JbX6BePyiq7pjfPKEDNJerGS9rY4zGGn7LOzGAWaI9Uo7RdUlFWR1cG+HP8TAfugf6UeTpFWtxOJlSwXNJMJ+5SRbJHL1dbeMlzcmBFkXXC2oVeIVc97a883270YY/mGx7gWPWY7vLVz7BjtrFwVU6YxatDp+zh2jivFOKhdMceID2joXLqDzCS+wY/m/2bxY+DPyVppoL+iJGJcdhYC0=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(13003099007)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	HfNWzj1Di/T6Geyd5GF7/2vl0y4JTuvXRfIES+bJYDAQtMdMKcKbYEuWBxTDtXXmzY+csNPn3BQtbxwCSMUGxzhhQSvDeIxGij7SAx4H7AxV8TgrpA0sIFsLcvlAqdJ9PRjhIonDb5BU6EgJRTyVITZ3k98ua/7h2/ysRJYASbOMQnIvqGcOcEswOySPyb6aM3enyxtZhqRJQHEorkhw8UZysqQ5fpIU14Jmqrtho6fu8986P6V3eyBfTjG2Q9OAvvgczMdch67Lwnb+JXVlQSMTpk7qN4o1hjx5hmf8pjs6qZDC2v8bAUBw1EIm+mcaoO7vfYlsg5pMNEsLQaGissr5DL3O0V+HNMMOG8lj0ZiemO9JpD7RFb13vb7E72dIWuAMxYq7pyDomcpMRDwtiYgG6dMNN/BfdmYvE90mdK50rxrdkrnQc0DwQWrVLtBV
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 16:21:21.8419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed844eaa-caf8-4a5a-83af-08debc0bfda1
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14646
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 May 2026 16:21:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23025

commit ba9e1b5254783528e10b45b1f0fb40e21f4ff88a upstream.

Implement I2C bus recovery support for the RIIC controller by making use
of software-controlled SCL and SDA line manipulation. The controller allows
forcing SCL and SDA levels through control bits, which enables generation
of manual clock pulses and a stop condition to free a stuck bus.

This implementation wires up the bus recovery mechanism using
i2c_generic_scl_recovery and provides get/set operations for SCL and SDA.

This allows the RIIC driver to recover from bus hang scenarios where SDA
is held low by a slave.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Link: https://lore.kernel.org/r/20250501204003.141134-1-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 53 +++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index f1570872a63fc..e6a45bc7a0876 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -53,6 +53,8 @@
 #define ICCR1_ICE	BIT(7)
 #define ICCR1_IICRST	BIT(6)
 #define ICCR1_SOWP	BIT(4)
+#define ICCR1_SCLO	BIT(3)
+#define ICCR1_SDAO	BIT(2)
 #define ICCR1_SCLI	BIT(1)
 #define ICCR1_SDAI	BIT(0)
=20
@@ -152,11 +154,11 @@ static int riic_bus_barrier(struct riic_dev *riic)
 	ret =3D readb_poll_timeout(riic->base + riic->info->regs[RIIC_ICCR2], val=
,
 				 !(val & ICCR2_BBSY), 10, riic->adapter.timeout);
 	if (ret)
-		return ret;
+		return i2c_recover_bus(&riic->adapter);
=20
 	if ((riic_readb(riic, RIIC_ICCR1) & (ICCR1_SDAI | ICCR1_SCLI)) !=3D
 	     (ICCR1_SDAI | ICCR1_SCLI))
-		return -EBUSY;
+		return i2c_recover_bus(&riic->adapter);
=20
 	return 0;
 }
@@ -440,6 +442,52 @@ static int riic_init_hw(struct riic_dev *riic)
 	return 0;
 }
=20
+static int riic_get_scl(struct i2c_adapter *adap)
+{
+	struct riic_dev *riic =3D i2c_get_adapdata(adap);
+
+	return !!(riic_readb(riic, RIIC_ICCR1) & ICCR1_SCLI);
+}
+
+static int riic_get_sda(struct i2c_adapter *adap)
+{
+	struct riic_dev *riic =3D i2c_get_adapdata(adap);
+
+	return !!(riic_readb(riic, RIIC_ICCR1) & ICCR1_SDAI);
+}
+
+static void riic_set_scl(struct i2c_adapter *adap, int val)
+{
+	struct riic_dev *riic =3D i2c_get_adapdata(adap);
+
+	if (val)
+		riic_clear_set_bit(riic, ICCR1_SOWP, ICCR1_SCLO, RIIC_ICCR1);
+	else
+		riic_clear_set_bit(riic, ICCR1_SOWP | ICCR1_SCLO, 0, RIIC_ICCR1);
+
+	riic_clear_set_bit(riic, 0, ICCR1_SOWP, RIIC_ICCR1);
+}
+
+static void riic_set_sda(struct i2c_adapter *adap, int val)
+{
+	struct riic_dev *riic =3D i2c_get_adapdata(adap);
+
+	if (val)
+		riic_clear_set_bit(riic, ICCR1_SOWP, ICCR1_SDAO, RIIC_ICCR1);
+	else
+		riic_clear_set_bit(riic, ICCR1_SOWP | ICCR1_SDAO, 0, RIIC_ICCR1);
+
+	riic_clear_set_bit(riic, 0, ICCR1_SOWP, RIIC_ICCR1);
+}
+
+static struct i2c_bus_recovery_info riic_bri =3D {
+	.recover_bus =3D i2c_generic_scl_recovery,
+	.get_scl =3D riic_get_scl,
+	.set_scl =3D riic_set_scl,
+	.get_sda =3D riic_get_sda,
+	.set_sda =3D riic_set_sda,
+};
+
 static const struct riic_irq_desc riic_irqs[] =3D {
 	{ .res_num =3D 0, .isr =3D riic_tend_isr, .name =3D "riic-tend" },
 	{ .res_num =3D 1, .isr =3D riic_rdrf_isr, .name =3D "riic-rdrf" },
@@ -509,6 +557,7 @@ static int riic_i2c_probe(struct platform_device *pdev)
 	adap->algo =3D &riic_algo;
 	adap->dev.parent =3D dev;
 	adap->dev.of_node =3D dev->of_node;
+	adap->bus_recovery_info =3D &riic_bri;
=20
 	init_completion(&riic->msg_done);
=20

base-commit: d71d7aba7486b2803b7ca15255ba5f643ace1e9b
--=20
2.43.0


