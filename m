Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.40])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5793.1794388774023294336
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 01:19:34 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=WpC3i/QH;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.40, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=acZ7hfDqg6HpCvavu0ALjLjiyfYh3+W/Ii6AZgsC2Yt84F4VuEvZzAES6qf7RG5Zkm8xdl68AMry8PFJEW6DAR423ziScNSIeC1+OqdJOggXJ/4R1lxCp/pquGxsCgVRtZb0l4ujPzZVFwPehEFr2vPDGmyuWxtnGbwZKIEliNnsY+I11Ohktv0R52sultwIU116wTi1IIMy/UfThaqu0ulxlZchEdbCNUi1e0P584fOa5TNY9Yp97BxKyreE0gqiewTyalRW4p6yETy+xmfcpnq6v+V8r8JwEuKxBfGQ4brRPDYu3+k/Y8Q7lwHjDSTCvXWvfVKFdZnY54jK2dhYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guPouyKZXysIxewAWEgQ7hcoSAcE9nf9YazdBmKNg6E=;
 b=y6c9GNValki8dxfM431gCAXCUpG3XphNDAxgiKMLPztzZ9mSiADOGdpiyTHoNQAP0B42nVIRGSFVQR4LRlHSciAd19qBzZyPvD1IeR9UZY+vixvrYneSu2wnv/+24/6VYxpYtGW9vPCeVLLWzaRFrptSfTHL7bP/Qe3/xNIxGrDdZq4eW/qfVIqcUmQdYs2hTuFGFR/zanrxauMP2dgbUi7X523GGmVMzKTOk9LKwd7oiy9OC3o1JMV4QI9GvOtzN+LRKc1D4E46bffuBdAIvWE+0caObHzGSwVmO0OkCoy/AodnHrJ3VgZJJpa8WqALuYB/wyGSv+a/REebcxDxlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guPouyKZXysIxewAWEgQ7hcoSAcE9nf9YazdBmKNg6E=;
 b=WpC3i/QHEb5L9/DCnQ5fxjOwBmFb2bbot3VIr2lg21nayNlg2JSW470wRzR70x4QCgE2BD2fC0HMg5jyYGb2dlpH8D3oiE/N6aMQRi0vEepseH4vLV/tOsjPPGVu7hXS5IitSBHpbKQqK78H9xUBD4Ez6K0TrNBXWWtQgNQ5bZA=
Received: from TYCP286CA0330.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3b7::19)
 by TY4PR01MB17800.jpnprd01.prod.outlook.com (2603:1096:405:34e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:19:21 +0000
Received: from TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7:cafe::32) by TYCP286CA0330.outlook.office365.com
 (2603:1096:400:3b7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 09:19:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005020.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 11 Nov 2026 09:19:21 +0000
Received: from Ubuntu-22.. (deu-5cg22344cp.diasemi.com [10.24.0.52])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 6E3853001DF5;
	Wed, 11 Nov 2026 18:19:20 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 11/21] rtc: rzn1: Replace remove callback with devm_add_action_or_reset()
Date: Wed, 11 Nov 2026 09:18:50 +0000
Message-ID: <20261111091901.41995-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005020:EE_|TY4PR01MB17800:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a458b6c-7180-4c99-5513-08df3fd4df0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|22082099003|18002099003|11063799006|261028144727099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261022105027099003|56012099006|261102123227099003|261009223027099003|10067099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: 7zyf2Z203uIRUTaEL+gBg31dYF3WSzOGTGKmFpS0/S1hCaH4LtPaxrWU1DG6HFjjJW6S+q6Heba4vooh3rxMu7JhP1PO4GXRpIO2UVvEq2uNILTXLSg3112LchRaJSWDvEryf5B5LfxADz+GUG7ox0OUtqednswlNV/X5JJJGej9ksx7OxBYsHpc3OGjB7IUSvxRY/KM5CwxHLcwN6J33Xtz2Tc7BW3PL/NgBlIo1h+N7xW8lq2ddnhLOwR7fXRIACgYaCI2ULMA2EhYblsmoBhYqwoIIGcl1WHG7rr8V9rg33AGDGK4JK1fowdeSQF2CpzL0DqDgxEo3uT4Mxop2FOVBj0Er8OY4WVbmc5rWCfbSilijZmvnHfiiOC9oxekw1mwLBgWw8WBvnLF3PomVXQPtjuUaZfX/Oi3ENwOOM0/K7gEe4zUqnzz3ZxJeydBjexnK0IB9Rttr8eNRcrH/B0t5TRjGgkMyKRtU5BX7vl9qR12BErXrMjPqtqMeF3Fz37L13+PbxPH7nKMbA++rhVMcAwBZK3mzfJ3Ol0bkzNQJa6XxSGfpqhy7FcMSq8l3GJcBgAfQ0S0Yhc7pMoR/p/gt7NSvK0LLpsUZbCOKEi3mhfLqqPdqx1b8H9R+8tohpOq9jxf54oIaCyEZupyUQ==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(22082099003)(18002099003)(11063799006)(261028144727099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022105027099003)(56012099006)(261102123227099003)(261009223027099003)(10067099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qt6Fo86YCpk9xZhhuIGNYIza4CRPyVTzg5mEkVfQDdAGqf1PoSsVTtNyPjgkUReRhFqe/TQHglRDjTx60Rl0QM1U2QZDCamUqZ0ekCgBi4zOf7AfBdaS3oCfLMXZ5bwsTCqBGrcgnk1h+TU5LxMVdaapoqcgoriCrIAn03uhNd8phxPsQCVGfjLAEvVYIFgli0OOEQT8pPnScH5OBZQgn84hxUxuP6sXbXClZX+luQ+NyZLAbLpu1Uds6Fo8HTuIxXNRA+FjKpYeqSeJAoY4jMjricFWRev6KmMIQkgdp6geB2QKTMk3B5KWQ57ErMW9xAKMoHVHrqU2Nw7RPOW9Fm10OAk4u4MGlbBg3T+mbJkQwG4cHooK5JCABg+S5CgPrw4iTIX1PF5koEOXzZxYYDiXme34/PPkzRywuY4qqO4z/NB1I7pOLzyXPdckFU4N
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:19:21.7078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a458b6c-7180-4c99-5513-08df3fd4df0b
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB17800
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 09:19:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24753
Content-Type: text/plain; charset="utf-8"

commit 6e0d7d480f2df83dba82e2fa8f6cd453e9a8326f upstream.

Simplify the driver teardown by registering a managed cleanup action with
devm_add_action_or_reset(). This eliminates the explicit probe error path
and allows the .remove() callback to be dropped.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://patch.msgid.link/20260821211032.13554-11-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/rtc/rtc-rzn1.c | 56 +++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 7c582f9264923..fdf603ab4f246 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -385,6 +385,17 @@ static const struct rtc_class_ops rzn1_rtc_ops_scmp =
=3D {
 	.alarm_irq_enable =3D rzn1_rtc_alarm_irq_enable,
 };
=20
+static void rzn1_rtc_disable_hardware(void *data)
+{
+	struct device *dev =3D data;
+	struct rzn1_rtc *rtc =3D dev_get_drvdata(dev);
+
+	/* Disable all interrupts */
+	writel(0, rtc->base + RZN1_RTC_CTL1);
+
+	pm_runtime_put_sync(dev);
+}
+
 static int rzn1_rtc_probe(struct platform_device *pdev)
 {
 	struct rzn1_rtc *rtc;
@@ -422,18 +433,19 @@ static int rzn1_rtc_probe(struct platform_device *pde=
v)
 	if (ret < 0)
 		return ret;
=20
+	ret =3D devm_add_action_or_reset(&pdev->dev, rzn1_rtc_disable_hardware, &=
pdev->dev);
+	if (ret)
+		return ret;
+
 	/* Only switch to scmp if we have an xtal clock with a valid rate and !=
=3D 32768 */
 	xtal =3D devm_clk_get_optional(&pdev->dev, "xtal");
 	if (IS_ERR(xtal)) {
-		ret =3D PTR_ERR(xtal);
-		goto dis_runtime_pm;
+		return PTR_ERR(xtal);
 	} else if (xtal) {
 		rate =3D clk_get_rate(xtal);
=20
-		if (rate < 32000 || rate > BIT(22)) {
-			ret =3D -EOPNOTSUPP;
-			goto dis_runtime_pm;
-		}
+		if (rate < 32000 || rate > BIT(22))
+			return -EOPNOTSUPP;
=20
 		if (rate !=3D 32768)
 			scmp_val =3D RZN1_RTC_CTL0_SLSB_SCMP;
@@ -446,7 +458,7 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 	ret =3D readl_poll_timeout(rtc->base + RZN1_RTC_CTL0, val,
 				 !(val & RZN1_RTC_CTL0_CEST), 62, 123);
 	if (ret)
-		goto dis_runtime_pm;
+		return ret;
=20
 	/* Set desired modes leaving the controller disabled */
 	writel(RZN1_RTC_CTL0_AMPM | scmp_val, rtc->base + RZN1_RTC_CTL0);
@@ -469,14 +481,12 @@ static int rzn1_rtc_probe(struct platform_device *pde=
v)
 	ret =3D devm_request_irq(&pdev->dev, irq, rzn1_rtc_alarm_irq, 0, "RZN1 RT=
C Alarm", rtc);
 	if (ret) {
 		dev_err(&pdev->dev, "RTC alarm interrupt not available\n");
-		goto dis_runtime_pm;
+		return ret;
 	}
=20
 	irq =3D platform_get_irq_byname_optional(pdev, "pps");
-	if (irq =3D=3D -EPROBE_DEFER) {
-		ret =3D irq;
-		goto dis_runtime_pm;
-	}
+	if (irq =3D=3D -EPROBE_DEFER)
+		return irq;
 	if (irq >=3D 0)
 		ret =3D devm_request_irq(&pdev->dev, irq, rzn1_rtc_1s_irq, 0, "RZN1 RTC =
1s", rtc);
=20
@@ -486,26 +496,7 @@ static int rzn1_rtc_probe(struct platform_device *pdev=
)
 		dev_warn(&pdev->dev, "RTC pps interrupt not available. Alarm has only mi=
nute accuracy\n");
 	}
=20
-	ret =3D devm_rtc_register_device(rtc->rtcdev);
-	if (ret)
-		goto dis_runtime_pm;
-
-	return 0;
-
-dis_runtime_pm:
-	pm_runtime_put_sync(&pdev->dev);
-
-	return ret;
-}
-
-static void rzn1_rtc_remove(struct platform_device *pdev)
-{
-	struct rzn1_rtc *rtc =3D platform_get_drvdata(pdev);
-
-	/* Disable all interrupts */
-	writel(0, rtc->base + RZN1_RTC_CTL1);
-
-	pm_runtime_put_sync(&pdev->dev);
+	return devm_rtc_register_device(rtc->rtcdev);
 }
=20
 static const struct of_device_id rzn1_rtc_of_match[] =3D {
@@ -516,7 +507,6 @@ MODULE_DEVICE_TABLE(of, rzn1_rtc_of_match);
=20
 static struct platform_driver rzn1_rtc_driver =3D {
 	.probe =3D rzn1_rtc_probe,
-	.remove =3D rzn1_rtc_remove,
 	.driver =3D {
 		.name	=3D "rzn1-rtc",
 		.of_match_table =3D rzn1_rtc_of_match,
--=20
2.43.0

