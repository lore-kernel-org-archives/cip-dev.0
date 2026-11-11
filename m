Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.11])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5778.1794388756096748129
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 01:19:16 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=cpbv6BBU;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.11, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLE1KDVdyrn5AQPOwTnuZmdCfbiijdf1q7lDRXHer91DsR8NTMgT1fu+jjrFjH6g+nxhqiEVE/pARP70+JdgqktLl0KA/wO3+FjZpqMKQbn/2oX6KLd+biXz/Hbyr2x1/lVYUMNcQarlMEUCTtFFCS5EXL77XAA1vH1XiZZ/cXD+3Ne9Y/ezK8d48CVRxFiUYBHy5Rhtsp9WBARZkLadjzPoRFRlQEh+H8fG8mpfW4n3KJ7MOSxZtXgG+dTa5P9cRJ9R8joTiqkLVd2H4BpCQBjoIaks+hgReAffg4wR7E8OUL88oMsVAz9FHB5jg5wsFRUejpRPMjlcWqg93AlOTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTrn/8X9boSEnOjlHyvi5zMKvFj2etIzr1KqetoL8ao=;
 b=hTjFR7K4HlkvUbN92phFKQQhp9z20PN76Qnh+mi1LWYMgVvWdGf0Xkh1kNEJBkLZ+ZG4f1BujJ1tOjbBiU7D9u/JLXzFA+DTo9DU2E1Tj8M1N26XPLUmSDCoVIejGI+eWen3E7iIJYNWNK7SE0kJldFOpXfShptJ4saJiBGQZM73JMLNTsobgoO402tk+nn1RXlV3jw6USiEWDZuzQWgByI6kbzZwm83W/jzJXePTxsRYQfB24i8o6l8w/haha4E10IiX5ZNLGEA37ENeNo4tL9rQk1aAUf5Zx+nDlMPPLJams/McbUHOU1SbM+GRZlrk+qAi6rG4uHh3NE9YTEVkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTrn/8X9boSEnOjlHyvi5zMKvFj2etIzr1KqetoL8ao=;
 b=cpbv6BBU+Y+yQ4rQraPOTFdZmO+5XEcvbpUdKmGBIFgeB+ms9VA92/0va8yZovzqMCRj0veWppSi+Xh5bjLhurXVocl3oNMfGQ+qwcaYAG05eVepk7NSUPSAQrjlSL40r6tClKill94gi/oO3WH1s9S4DRuSMNDgSDTrQKtfeKY=
Received: from OS7P286CA0027.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:26d::8)
 by TY4PR01MB17495.jpnprd01.prod.outlook.com (2603:1096:405:356::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:19:10 +0000
Received: from OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:26d:cafe::75) by OS7P286CA0027.outlook.office365.com
 (2603:1096:604:26d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 09:19:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20D.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 11 Nov 2026 09:19:10 +0000
Received: from Ubuntu-22.. (deu-5cg22344cp.diasemi.com [10.24.0.52])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id CB8FD3001DE8;
	Wed, 11 Nov 2026 18:19:08 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 04/21] rtc: rzn1: clear interrupts on remove
Date: Wed, 11 Nov 2026 09:18:43 +0000
Message-ID: <20261111091901.41995-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20D:EE_|TY4PR01MB17495:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b1b0d2-70bc-4d40-b3f6-08df3fd4d82f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|261009223027099003|10067099003|261022105027099003|261026140227099003|261022075727099003|261028144727099003|261021121427099003|261102123227099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: RaqcSjcJbyXydiuSVkV/ZXc8D/WXtdfCMzsHWioWo9KvDAraCPL8RxWohT5/tPrYEgFr3X0SR8pw46ZaNGL/O/mjaeEda1HYeAlezvdgO7FLtMf52l4J7vfBbaEix51qrFDNr36yTYizUsAzyhCb8ToENbUrrd1ShCS5UWXj5su11frEtbTkePCrLQxEnno46BSC3FFYBAW17qiZWXHYQfSV7PyLWpU8Fbsu/R8troQnqc4NDJ/C6ox31ViproSZcFsv5VJFWPsd2ixs7BLr36F6O2bk+tFycMWRuGm8w5EdTgwk80x31kHwll/Hv7pRV9S9oMGNGMIgby0SYj/Qf69R46Of9wHhVdpLm6rzic4Wj9xMK8k2128bxk9JcGGjn3nt+MzRUp6KZNgU4qxj+t5L6RrV5swf5YSMK7/niWDEYSRKgnQJkvoHREu5L9RjO/jTEYVhgI0FC6iZy0/wuR/HtqTTYbFb2zFz4bSmf1eSN+r4Csb83OZKXuX/O/QmZyql+zNIk4b3QP36lvGJcTwPgaP6h1npX6V+2jJ5WCvm74wQTm+zC8UiqQhoUXD0vl1BXa1124LQEnpe80NGVqJUeVPVkpz6jPioyAbrhRNARc15rbh+/zjl4s9OCRP6ODFndVEKtYV8y4AACfeAGA==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(261009223027099003)(10067099003)(261022105027099003)(261026140227099003)(261022075727099003)(261028144727099003)(261021121427099003)(261102123227099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YrzywOUBpZ9no2gdQtpe2GUJwPJVlJXeBfLJZ5TrHlAizkAZVw2Q0Zu9WSDv8UgTDgsbaupAhSRX4kwUsPG6aKSkIpZC+vKpZjk2vPJ6MqWKJtr+AQrjgu4nfqBlavo5Gp6bmPL4Qkxd9J+KDbFaZhPB2o8iL38XHXxEzJmbCkyTM5HSMzlC8Lj0MyUuyI75UgqzUkbLmG6UsssdT+ybwYnSrfNY1+eiX8BwWneXGdQ0ZQvm/c1GWoG9hBI/M+lxAcHCm2fVS3z22jwcqw4UM+VkKQ8IcRkRal2eLnevfwrsKuhRWVZ2DHXz87XaCP4eaJtNJnxol64+7qsGZRJyl+guzWdqIBTtNrT9W3aIRtVlq1+328j7xirQnhyMnZ3Bd+Ey93BE+ymvBb6b1ZvVCWnFtuUV/Sc62F7Wcy8oYq0e7plZUVld77timVsJduxh
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:19:10.1887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b1b0d2-70bc-4d40-b3f6-08df3fd4d82f
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB17495
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 09:19:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24746
Content-Type: text/plain; charset="utf-8"

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 0bddd060a6a3a10e6ebd386cc4d9a897e8a60861 upstream.

It is good practice to clear running interrupts before removing the
driver. This is not really a bugfix because on current systems RuntimePM
will disable the module clock, so interrupts won't be initiated. The
dependency on that behaviour is subtle, though. Better be self-contained
and clean up when removing.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20250312100105.36767-2-wsa+renesas@sang-eng=
ineering.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/rtc/rtc-rzn1.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 0fe6137a9f7d4..8aa42e433a04e 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -452,6 +452,11 @@ static int rzn1_rtc_probe(struct platform_device *pdev=
)
=20
 static void rzn1_rtc_remove(struct platform_device *pdev)
 {
+	struct rzn1_rtc *rtc =3D platform_get_drvdata(pdev);
+
+	/* Disable all interrupts */
+	writel(0, rtc->base + RZN1_RTC_CTL1);
+
 	pm_runtime_put(&pdev->dev);
 }
=20
--=20
2.43.0

