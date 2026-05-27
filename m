Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635DBCD4F54
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 16:15:09 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24339.1779898503221422665
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2026 09:15:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Q4yepHeW;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.61, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5+aYmxe3EH0gT26XbhCou1uxiZWBRURJohOvGFlydt1k6sM9aMDiIALb6s8qnld/WxUgBzpp6fb2+Gvn8mXTja8v4OK1ELdXDmeksw9Qst1sja6bcKfewjKLlEEGO3JnbnXw0QO2eBbT55R7om3nFiPqCV1R/opv0F10ywPH9Y/hHnppBNnpvph0q5oTWbG2U+JFDxxrQq14V0s/xlhiYyqHzlzE0nAu7PSQLwtqO8ffY9O9CvKQZHDnI3stpJLsgmX4SelGpdkdVPHLgh1tdu9UCWxFVZsNqhIgzKJr5YlH9DDCYJyQnGwF6vawDU+6aGzAVthSjkaFFQT2oAILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=124rUj4QtcNJJtEaWb4x7NGs7O9bYPupoEPhDB1Lhbw=;
 b=Zywpbt3vrjeRJVbCgacOMLb07yM6nwluwxjIP5NXU+R83UKHJZYONeGBfEMp5wapbgLtKewD5eWezwODChPWPv8orgCkxFoCc+RomjytxwSCYkLaQB/uyeAUMBus+LMLZEwcJSeGXTzIdXm8dHMrHGGmwRrAF10H8utbYWdPMxGad8Sfnz6JjF1dZk2T2ww1xZM8brlK5WTWCMKNLllQ7WU3JtRw09JHQOJaBJvLI9jiPiJQc/0s6B/rifO1zdYTavP95YPSJ102RB1v6rTSQFvtNT1OWbllK6+dIepnUg3mJfvQfc4LIJq6OK2cE4zmUMym/6Hpwwh/2QZ0xOaDEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=124rUj4QtcNJJtEaWb4x7NGs7O9bYPupoEPhDB1Lhbw=;
 b=Q4yepHeWsp3wgWWK1Hj1ZyDzzul+yxlCJMl0AoDcpOIq3czYl60CoxO2dnM7R8LgoE8biHi2Nu9bSP0y7Z4D+bH/UpWxJczp0d09x6F546T8MkiogNkuzJtlgAxtTFTuZHnsxa9Lp1YOek/lSdgVjTddktmiml7ba0dvsWBEcVs=
Received: from TY4P301CA0084.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:36f::12)
 by TYCPR01MB7339.jpnprd01.prod.outlook.com (2603:1096:400:f2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 16:14:58 +0000
Received: from TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36f:cafe::a1) by TY4P301CA0084.outlook.office365.com
 (2603:1096:405:36f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 16:14:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005020.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Wed, 27 May 2026 16:14:58 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.0.181])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 7F7913000255;
	Thu, 28 May 2026 01:14:57 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 6/9] i2c: riic: Mark riic_irqs array as const
Date: Wed, 27 May 2026 17:14:40 +0100
Message-ID: <20260527161446.48789-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527161446.48789-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260527161446.48789-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005020:EE_|TYCPR01MB7339:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8e465092-49df-4747-6440-08debc0b194e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	h4U/5GlFTu1FyLyhCl0R2M+H0qDiASV716nvus8sPzOLMkOBkxbe3jkLYwry2X8fxjTeACclxQn2exflRMHdRMBY0ch7tneceOh7aZrj6JIMHLxJoBjpBM2GaFSYFRcKTYfBXMLIcN5HP6yicD3K5NjFsmX9RjpUz2edIOK7YYjrQWAYXk2kBOVA0yter8UGy8XEITktYx+NP/fGuDRV2Enn3KSrSUjVZTZ+4Ey8660NO9pC9Dnla/SqlRTSjiHc7QYPJgn1U+/vCbkcPcHQdfzuOPZP5eepEKwxqzxUuyhdV5heel71CLXMmnXHA7GMhCnaCSkkO0pm14ycDkTltr5Y3ktesA76oZQiIu9wZM4yuKWvuNcFJTa/oVEXqek7iod+9C3tpDUFiUuJGUKWDcigNfas3ywVT6ihL1AEBR7pt6cLABSRpbGnlV6jua/XdSV66LA/mpUMbFvIiOuYg5vEInZz2mItLyaFv4L0WVguMTtxNFA1UdmDaxDFWit0bI3uBcdzORxPqUbiemVQoTpSzVPKOSO3CxVpNsclp08MByZDuxXEEN+TqdhqhSbqd0DcVzeyH/6TymfElHG6Cjui0M7aFNfAsUc7TVVKvxnXcODVEyCKz0jUnLB83L3hJk8kIdkQKKQNcgL0ClNoOSrCWcgkWtUtw/73Bp6et+0IyCOxiPV+SIg7e+w8I8l2Zj8LmECZbqqfsuANc7zWhGOx4KvI2t06aibMvBv1JgI=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	R7AdpbN/AQzi0mbdmehcmEL2rtYg/m+OXe4+5bnxQU+yw1gbYohJVOfrSmQIdPLB022dlCtCyDcEqx2JidDBqEmcSFkcxfQ9UM4f9Ru8f0/10LYCBHGaDKsU1W4l8SrTpo7zIeKTjefF1O4NRTglUXjAG2sFc5Sr7F9RwnbAH+cEkVU3ksu4gVaWQip52HGFy3p7Q4fxsTUAFK5CRVqN56LaeW9+FJU+tdjIuiZhB9znDwujQNDOYWWEn1rXTT4QPnzjDPDk5k6yjFWLDSJPadhD1N2eWyPhrofckUC2QPYejRC3Oe9+komhcjYhJqQ+KZtNnIK16v665niVVyMZ4QNsZMOUisvLFs1uac+ih88LSByPY0q0mfGO3JECuk6zNtPlLB45XyTMHOnksFwyT+xoGvw7VTJzuC3I+zn9ueV8+KXTHJ6Ia/JwGLVPH+QL
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 16:14:58.7919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e465092-49df-4747-6440-08debc0b194e
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7339
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 May 2026 16:15:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23021

commit 9ae0e7f77cfb638c3cd4198ad1ce7a3bce9a5c2a upstream.

The riic_irqs array describes the supported IRQs by the RIIC driver and
does not change at runtime.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index c884faa0d4ad2..98d5c2f512a3c 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -416,7 +416,7 @@ static int riic_init_hw(struct riic_dev *riic)
 	return 0;
 }
=20
-static struct riic_irq_desc riic_irqs[] =3D {
+static const struct riic_irq_desc riic_irqs[] =3D {
 	{ .res_num =3D 0, .isr =3D riic_tend_isr, .name =3D "riic-tend" },
 	{ .res_num =3D 1, .isr =3D riic_rdrf_isr, .name =3D "riic-rdrf" },
 	{ .res_num =3D 2, .isr =3D riic_tdre_isr, .name =3D "riic-tdre" },
--=20
2.43.0


