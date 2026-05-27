Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D542CD5BD0
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 16:15:09 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24344.1779898507747340715
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2026 09:15:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=LuyCj4GQ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.51, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIyW+LMG9RnbosxLAJ528ozOwo01TEAKmP5iTQw/qBC0Dm7qhIaHTbVf5DbJpliOkVJTu7t/AuvR9FR5/JhAF7vGATPHnc0FbeXtAQ4ZAtIbyoZb1bo8a50XRaG+r0z2vbULSidoghSw5dCzH8A1FqtHBddC6ByUvXNRhJMOeBE2D8WhHboNJPGPuPJh6gy5tRQ6ceTDTjVecHZlLdVctByL3DBQ5oKhjk+d4SydG0krxPuVPe72jlO9Y18OqGnFJvX++jfJOPbPcRbt7a7DlxFKodbcRv9ZmLiSNsrtkeXIcY4ZFPPP4R1m5SIhibagc9vvvxn0Cain98ail/dvTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEqltW2pie/8Ja3maODqMApLzNsdcvzD2OZbW060rm4=;
 b=AFW4TwbcxpmezRW1xO1SeAAI8hvZH4VM3X1r4iZjIk/2qdPy3WVNyDEU01KJ45xlEeY4IwmjcaNYg4Oq1HWNG5V50Af5Me2CpreGMEECT03w+GmZr0qptqnhxDJZtOf2hdAByBRehpZHhGrncn/R2w0se5l/McAjiBwAvfXzjiqi11xDXh5i6LnHUdM8e7gSIFO2XCKIT7LWKx2RN9Xpzb0C8mI4SwfWGUbUf3VEvZPJJgNCl2yItKjdr5XOW+OC08qlJFfVI3+jvBHTbXQ1L62JlJBL5KglNzprEaDU9eI6AJUTghGDOSJZC9S//0oMWHtc+ktMzNyXYmd4SFKePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEqltW2pie/8Ja3maODqMApLzNsdcvzD2OZbW060rm4=;
 b=LuyCj4GQLaEDzeTuxuyPTRHxLu42L/fnK7m1PXnlSbI5cIVxhfwh8d7/Y7VHmN8nN08Y2a3Jo7d8yElw5+1MCGtpm773Gh5W7tD1CicAeTnmf3kQrtssO3HqOjE2/jV2JS1Vd0D9EmJgf/JgMPQCeaMbHUwtXM1mPr/kiKl8ozU=
Received: from TY4P301CA0042.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:2be::18)
 by TY7PR01MB14819.jpnprd01.prod.outlook.com (2603:1096:405:257::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 16:15:03 +0000
Received: from TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2be:cafe::14) by TY4P301CA0042.outlook.office365.com
 (2603:1096:405:2be::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 16:15:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005025.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Wed, 27 May 2026 16:15:03 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.0.181])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 7325A3010426;
	Thu, 28 May 2026 01:15:02 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 9/9] i2c: riic: Implement bus recovery
Date: Wed, 27 May 2026 17:14:43 +0100
Message-ID: <20260527161446.48789-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527161446.48789-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260527161446.48789-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005025:EE_|TY7PR01MB14819:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2eea9f09-bc75-4681-d2e6-08debc0b1c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|11063799006|22082099003|18002099003|13003099007|56012099006;
X-Microsoft-Antispam-Message-Info: 
	mpNnWuCaN0kZY8H6WQBCE3BIR4p6ynsxRCYp7vabn/4HTEuPq8MzcKOsc/CTfzebNvNZK7nSTc7RswzBT62bouWFWmRufCrjx+AqhhJ6mCrVqkUqls41789rDMlNe/XHYLOSh1GyTtzx1GgsdwD/h3uToZyyknZlbk6VLishnVK/bMudQ89KxCOOzc9XEw/l7tU71dlaNtzIFAyxFUjRuG5xoxlh64jUckdtggaFOWKfbbSwY5uBoOplAav6CQjm76rvNBWz/4kPd2qvSORLJt4/aNAOMA5zI16ywWvlFtzMMao88NPNGaYUIbR8+PvkPpzxF+0BxmyjXehEr1lFNEvRZewi2RiXgFutRhEiiroGL1UbS+fISmByncHeu7efVcca15XOppGjsLHUePnQJ+hoDVD9+AaNL1B8JKYlkWj4JJiX7j7XmMCwms8tk01yVeX0PbDXh01q4wDrAg3WrtqoZIA7lMhHQpQHHyfWDTdi/SNZJ5Ij7XVYWr2lAut2SBgO6GMgEnLFil1DfcDRp2kavNZY08I9hQ/V1ZPaow4BgQ1LokRcD5Pbd6QRpMim8q8T8zrF2+SclMDUPhOFm/IcSrQfzXSOtQTfEKSZ9PRTIR4sSQTXCa8KvsLqrLelOvk4/iCJYFx+vnRtTQIkg7TRVjHIn/ODqZXSZEbSq/Su3nR1eKiRDDA+xlMX34JlTiGzChHht3f4WRO4EDVD81oTAWZRnIb6zhPBdBxHlsY=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(11063799006)(22082099003)(18002099003)(13003099007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	7kbGEpquHB/KeETkVwNfZztb1/3qMg98MVnzMlRt4AuLcyjpjckJcZz8DfGCmOOWHey4pJbZr8aWdN0EV4Z2P5lV05316UO79fktLLPG10PQsXBZI5Cmdv0iIsz0CHba/2C0+nwKr419lkZS7t3xoK91V9YVTRYiLruqsz/vFpyXKU6CI7C/EwelK9QPqGT5H+rLNHInJaQgTie9OFQwtyTWQnF9U3Xh0Yh5zJx+CdgS5yWC9n5lQQifVffwD/0+pb+FRRCFh5Vxnlt8J3cL6tAkr1OfFs9juBauJTTCzoe4pttrYbVMHO3cLRO8OT7jsQzTswXgXTpgnCuyFUs21AZh8sgYJ8LcfPpVg0E0SREYgS7KvoknY297e2/kuNgBmb0uSyYKVmcMRpckYbm0YEVOeS9MjZ3Aa7B5Xb2X42I9nMoDIyD5BCDAXAu3IiTL
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 16:15:03.7089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eea9f09-bc75-4681-d2e6-08debc0b1c3c
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14819
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 May 2026 16:15:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23024

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
index 0bde3c25878f9..a71e5fc678f15 100644
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
--=20
2.43.0


