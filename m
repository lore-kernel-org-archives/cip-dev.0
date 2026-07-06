Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B304C44501
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 18:23:54 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.156747.1783362225859442455
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Jul 2026 11:23:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=IL/bXATc;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.9, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nijd0O8mY9dgs5dSnRgsOqFReVNiltTBnu2IAyGUuSWs9lSeK4eJTNaa11zbgkytSFFWs/azJ95myx3ERs+0AiofUE+JZ7jdob749BWujyi+9G7fw5Zko7FobPiDR1Nfgp2gRsKP5Z/0d5RrnNb8i0vKk5g2K9AwGMMrfAKENDMEq+3xopwLboruMefKHEFHOz71mGeWAN7p/OH9m8RaBAvzvj+5FvmQD+jIWnfSo4XQAdv+GP4eUQqxOZhnx3OG/KqW5XX+Km+1pmw44zlBsslSU1ydax9uKhZiUYaO8K/G3EOaXKit3yVOZbnp+93uz6etfZI4b44dxlGqDcHlAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFfOvWxR5xdG+YKUPCzhdGrtoknyL6acfrXJMmAiGpY=;
 b=zUq9n5atAa4Sy6ZiY9IyoKVwH9fvhWShvwa8hZL+1fOcXzdkSYMju9TzZfY6CGpjGefUoHG7CoKxiYMOZXiYrB5d6MMKQC/pLisON4WmPhdzY3so7VhF/YT681XUZijKHlZyJFAz6mvBPSnsToGMlLxgJAeoGlIyyC7PiaJ+y+2+2vYMKINhP3PQ79x94UrrQRsQiJiKDRGL7P7p6d0LwU9GruQKlp99/CGK/qBqg/Lc+hJ3AI9UGd9MhVE6b2DwlPlUk/VbyNSndG4ZRM/8GTn/YbgEo//9AAbVgCKvNw0CZ1EVjkh9qN+ld7qAP9Gyb04s/E57QZZSLh0avK04Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFfOvWxR5xdG+YKUPCzhdGrtoknyL6acfrXJMmAiGpY=;
 b=IL/bXATcWV8jGvAmpmSpz84d30v9bYQIB1aKyz/ZvLPr7Sz93xwDR/EdVH6Zu0F+TYq6MecuDW0EiZ74BuiHfAymBOwD7O4sSeD5Sr8Lat2vciP4X9OSPaFUo2awxNjMtT3Vh6sndgdQCjjZuCBQ3MRM+SpH00H5NTaKIgNVJoQ=
Received: from TYCP286CA0223.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c5::11)
 by OSCPR01MB15647.jpnprd01.prod.outlook.com (2603:1096:604:3b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 18:23:40 +0000
Received: from TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5:cafe::11) by TYCP286CA0223.outlook.office365.com
 (2603:1096:400:3c5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 18:23:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD7.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Mon, 6 Jul 2026 18:23:40 +0000
Received: from Ubuntu-22.. (ed-eng-lt-ism.diasemi.com [10.24.0.36])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id C67E43000152;
	Tue,  7 Jul 2026 03:23:38 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 5/8] memory: renesas-rpc-if: Add suspend/resume support
Date: Mon,  6 Jul 2026 19:23:25 +0100
Message-ID: <20260706182328.5237-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD7:EE_|OSCPR01MB15647:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 354b2758-679a-4ffc-1fbf-08dedb8bb419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|13003099007|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	89TqeSPzJe4VTEM5k8r8z2HIVnJCyAA+vUfgqqidcpAzfypCIPadTBAyTyw+pLvBp2FAUBIpD0CAW6Eh60gIq8Rr2ZE1nWPwM+VMcEg2zgX1I4Xl95/obWxl5vO8XqnkPrG98f/iH9uH8TKRpwvYsEFPFTlBdOHidLf9sIQg4tq3I6ihPEc5l/GEVFHdDFlZrAl1cQ1rnoHomZ72xA+a1ewu1FV6sJtzmFW9GNDONLsFyQhOiBsXSG/qx7AOy+pC8sVDin6ComxNHCYItVT7v4JOH40t6KqcDvvSZdsTQaQjOXZYxlLEFID50paxeKBSXjQmolWRji86AdCt10Xy36XR4CudW41tswvJQCq4Bd3JChdsD+FtJl6OeTZpjQijBW247QmdM7R4MN/aDrkCz5T238XKRpz4T1q9zz91KDXjsoKlzkHTikkRXDa0E1t/py/62Y383+HqK1Gdd/vDkURVLfH+Day5dsO+DEXDReM9pxN216BlTEwpJTwawH3wOXPyK2jZ3jOTRpiRHhYJ0JM/QxWMFx2P8M/RAexwLasq62cV0Acqdz6s1+rqgu/d0ra7+VvkZhtnqkooCk9VWQpBOL76tjviiuIPKfP8DvLCa40UKkDPIbqMUseV83JFHC9z7SFl7P1WSwnAYM6JcvHhPfQhbiK0ozrbOuPecXQ=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(13003099007)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	QL/6CH6UWMto4qExR9i340OkHEjmHK38Hub4dVJzK37jZMvf1xLXhVS6yz5cGdyXSpZpFyaSx2qzywQSwfU7H73mDhaHUHpADL+1YxlnuJs7RadiGE/lkEYXNvkG9AkSHGJoHuBaKb7olblWqy1f1DYJ6XlnF2YNfeZfzSHYd9ZlQsxxDt4qwsUF00rm8x377wc6V1TafeRWavmVYlhU/SDXrOclMhQn9COqk0Ofb7pqVtNsDLNDeZwvbbjuQPaYvxIgNxHOKvYdntuWeoc5bkGcxMrjn5y4PW1w/s5fCEHzq7wQr5TxqZ7/gM79CIBnGQVYICGbfJvshHb9Qnf7XBmX5Qe44y1BOY/4ddOH8rHLbDo/8Hsprr/rsZeMgM8PXQgg94rWNv5hopX+3+hZuXSORZAmirFSNMzUsRjrk1trN6FJJC3GofOp30NGOwEb
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:23:40.1164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 354b2758-679a-4ffc-1fbf-08dedb8bb419
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15647
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Jul 2026 18:23:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23467

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 42ec0bc61f052beb0d9a6a889fe746591de74508 upstream.

On RZ/G3E using PSCI, s2ram powers down the SoC. Add suspend/resume
callbacks to control spi/spix2 clocks.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251019180940.157088-1-biju.das.jz@bp.renes=
as.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 58 +++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-i=
f.c
index 2fd947ba5cce..36fc5fb41107 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -67,6 +67,8 @@ struct rpcif_priv {
 	void __iomem *dirmap;
 	struct regmap *regmap;
 	struct reset_control *rstc;
+	struct clk *spi_clk;
+	struct clk *spix2_clk;
 	struct platform_device *vdev;
 	size_t size;
 	const struct rpcif_info *info;
@@ -1024,19 +1026,15 @@ static int rpcif_probe(struct platform_device *pdev=
)
 	 * flash write failure. So, enable these clocks during probe() and
 	 * disable it in remove().
 	 */
-	if (rpc->info->type =3D=3D XSPI_RZ_G3E) {
-		struct clk *spi_clk;
-
-		spi_clk =3D devm_clk_get_enabled(dev, "spix2");
-		if (IS_ERR(spi_clk))
-			return dev_err_probe(dev, PTR_ERR(spi_clk),
-					     "cannot get enabled spix2 clk\n");
-
-		spi_clk =3D devm_clk_get_enabled(dev, "spi");
-		if (IS_ERR(spi_clk))
-			return dev_err_probe(dev, PTR_ERR(spi_clk),
-					     "cannot get enabled spi clk\n");
-	}
+	rpc->spix2_clk =3D devm_clk_get_optional_enabled(dev, "spix2");
+	if (IS_ERR(rpc->spix2_clk))
+		return dev_err_probe(dev, PTR_ERR(rpc->spix2_clk),
+				     "cannot get enabled spix2 clk\n");
+
+	rpc->spi_clk =3D devm_clk_get_optional_enabled(dev, "spi");
+	if (IS_ERR(rpc->spi_clk))
+		return dev_err_probe(dev, PTR_ERR(rpc->spi_clk),
+				     "cannot get enabled spi clk\n");
=20
 	vdev =3D platform_device_alloc(name, PLATFORM_DEVID_AUTO);
 	if (!vdev)
@@ -1063,6 +1061,37 @@ static void rpcif_remove(struct platform_device *pde=
v)
 	platform_device_unregister(rpc->vdev);
 }
=20
+static int rpcif_suspend(struct device *dev)
+{
+	struct rpcif_priv *rpc =3D dev_get_drvdata(dev);
+
+	clk_disable_unprepare(rpc->spi_clk);
+	clk_disable_unprepare(rpc->spix2_clk);
+
+	return 0;
+}
+
+static int rpcif_resume(struct device *dev)
+{
+	struct rpcif_priv *rpc =3D dev_get_drvdata(dev);
+	int ret;
+
+	ret =3D clk_prepare_enable(rpc->spix2_clk);
+	if (ret) {
+		dev_err(dev, "failed to enable spix2 clock: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	ret =3D clk_prepare_enable(rpc->spi_clk);
+	if (ret) {
+		clk_disable_unprepare(rpc->spix2_clk);
+		dev_err(dev, "failed to enable spi clock: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	return 0;
+}
+
 static const struct rpcif_impl rpcif_impl =3D {
 	.hw_init =3D rpcif_hw_init_impl,
 	.prepare =3D rpcif_prepare_impl,
@@ -1125,12 +1154,15 @@ static const struct of_device_id rpcif_of_match[] =
=3D {
 };
 MODULE_DEVICE_TABLE(of, rpcif_of_match);
=20
+static DEFINE_SIMPLE_DEV_PM_OPS(rpcif_pm_ops, rpcif_suspend, rpcif_resume)=
;
+
 static struct platform_driver rpcif_driver =3D {
 	.probe	=3D rpcif_probe,
 	.remove_new =3D rpcif_remove,
 	.driver =3D {
 		.name =3D	"rpc-if",
 		.of_match_table =3D rpcif_of_match,
+		.pm =3D pm_sleep_ptr(&rpcif_pm_ops),
 	},
 };
 module_platform_driver(rpcif_driver);
--=20
2.43.0


