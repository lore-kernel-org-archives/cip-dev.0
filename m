Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E3CCA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:06:03 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.7])
 by mx.groups.io with SMTP id smtpd.web11.913.1755705958786965057
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:05:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=pcQGfkUK;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.7, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkjWpdBvsW92YyvV2D4n6/Mhkivxl8OwJvqcRueUt3KEWwOxo4WkCqGn1MqrtU5t9jdFIHL4BrbQyHbuf9psHTIruuuSmYXOAt6rxc6HeBzctaBipTpdHMdadRcGubpIv+9QM43g+gzZeGtyaF1QrVYXtP5agUMtxlvRc2pAW/u44938Cx+oGNr/kGGyFbMEUXSoMcU2MQ8w0c6tQiQoHVO/TiNDWFapvD6y1GBXe8gs4UNBSBcbFdMfWgss1AR6qRxtTf89ZUk5PIyZJfPJRPuMNkUcJZxq24Bdqncrguubj+o7ojAbG6ImoB2qVAeb/cS+uCgDQZz/wWxyCP3xaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXFscXBtgUNsa5AScpI1dkXpzgkNwWbGfoaIo+JF92g=;
 b=lCbdf8eFfYliqLFu4rxTsQ06h2tx9p0D8imr/qMXopmnvt4QLcDirvRoYIiEOUada9rfQNyoThvNWYUaotuJC5l7bXSJfwFay/JuC8ZZdKvgm2X1oZbRh5P7qiAWFUgc3uhJJVhMpH4gIRaa82kfW409P4Pn+dvm9XJi7Dk10KoDezGgN8TGscGkz9+0TosyQeFYyD1+hFIzCoK/WlkikQYgCnQ+zbzsMi5FYGyndjnMkfOhcMAEGjYOWntB9MJ6o49vbasBrpPmFx8bmpBG7V8l9Wo8eIwidESM3diBJASJkAmMdjsa9WNfIOMiHpHba7Ec+JGvJWIHptkJzQencA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXFscXBtgUNsa5AScpI1dkXpzgkNwWbGfoaIo+JF92g=;
 b=pcQGfkUKdRmGTSDdoJwRFQHQBniKioHdMgd9miOnr2apDk7dd/KRqsuPhsTT/wc17SxDlMfDecAaHfx3z9I3skQxhy6tnbw3WiCAejCmuaECl9Kv50Y2suKqauMzaYzois0f+vLxaIXtXDSJmnUgFOD5/7ZdvjvC9ErDEeHW/Lo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYWPR01MB10458.jpnprd01.prod.outlook.com (2603:1096:400:2fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:05:55 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:05:55 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 30/55] media: rzg2l-cru: csi2: Use local variable for struct device in rzg2l_csi2_probe()
Date: Wed, 20 Aug 2025 18:03:46 +0200
Message-ID: <20250820160413.801341-31-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYWPR01MB10458:EE_
X-MS-Office365-Filtering-Correlation-Id: fcef2458-07a6-4b13-30fc-08dde00371d1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?BbUvcJ4ijJWKF+ksQimlQT6IkBOiq/N4tCGiYffzdCrVZ8JRhP4HmaxPWegT?=
 =?us-ascii?Q?eQ4EaTvSCjV9T7ZLccyOoujijyHR2M7OnOUbeslI2j9xSJDxiTdzdo9EgeTL?=
 =?us-ascii?Q?rZbiFFZk4kQ0RdiovTperNPMjvZ1Y30Im8dokpZsBiq44shWkmAxeE4J1ugg?=
 =?us-ascii?Q?tQzJO6RHMdfQJiQI0sslJwUvPeWwJ66BibMg1se3Hxo72LSPGQoDfa0aorpu?=
 =?us-ascii?Q?bFRuD2NTj21oCCiakFV6Z7hSrcJazGSd8mLZBxob5jQ5/RVnmyofvSKKBYEd?=
 =?us-ascii?Q?Sd5+mK/zYnA5v3xNnqNPHK2sSkjWOofvWDVZAwfKzBjIFNS4+UNw0oeOE7H8?=
 =?us-ascii?Q?L+F1mdAugWF4AG83+ptQefhfcYYGI9SxfYGMM+ujJJmb3FkIQOSenFTjMKDP?=
 =?us-ascii?Q?r66oW8JvuOuzqqOFKGpaDdxadfGxhjX4cyFDL9p6YUUioqIhpca/qjaEzRfs?=
 =?us-ascii?Q?eS4DJ5w3neWSCkfBTwdiNpvbHavf7dsOaxx6ePAV/oNtMaPOi+XmLNEvjIa8?=
 =?us-ascii?Q?yMsj3v8MLAcK/C9yVpRCwAuzcj/JhHj0t51CKm+pC6YjOUR/TRKkIwallUjY?=
 =?us-ascii?Q?tv+IgE7tpw/bC7fSJDENC+vpM1WSGYcvmf9F83sBINyZioohcOf7WafdkhZZ?=
 =?us-ascii?Q?fdhChDJeDLdsizFfb6mpO04TobdH6aLvjFn6rhU0lcnw42SGjctYguCdcZ78?=
 =?us-ascii?Q?Df7P1W0+pV369T5hIRFExLCa0UUrSkuwIZtzFI/8ak2sRbvw7dmEb/EtzSBK?=
 =?us-ascii?Q?A8l0nJADHsX0mue5N+sA0KsIoeMcJsfA5ED0eucZlH8ihprIYejtTgbnQizI?=
 =?us-ascii?Q?P4Z6R0chvnJ0JsC1PRsIXLqhNBUhoe7sJoC/6Wrd5VNhVvK3bAwtduWYLy/B?=
 =?us-ascii?Q?EILhnPY1UR0iJ9nLl87TLI0eL+Nb9AnZQU8MBO2APqS7ejF0rlBREG79kSBv?=
 =?us-ascii?Q?eyhXno98MAVr+7L+zpBtku20rRRff2pHzST1J/LnzfCMkZs3ZcxYLoW+Krdq?=
 =?us-ascii?Q?KgVooJ5nbCvW6U+P4Z43Bf7C0x5dQVInGrZQiSYEwT61jDNj8rl4INvsc/FG?=
 =?us-ascii?Q?O16OHdHYPjaM/00GtmWDLNV1prUnw2ZGztA8GnCxlttRwIiuEI8DoQV5korH?=
 =?us-ascii?Q?Rzv7E1rQQ/dWpkD+C3c4u6AY4r6llRM9c5D88kCbW2SCY5jsnrObkPiwRAfu?=
 =?us-ascii?Q?STW9XGOR+x3ZrMa94CupkzqvjI9oZPn9k6bYDyNhjYpDn1Un8jvPHEQNnR8I?=
 =?us-ascii?Q?aTJnpi7nBZTYZsV8VHiBAO5C/x0a2IKCHlyt+bQeJkQh4Viqmb2qu2GJMDfl?=
 =?us-ascii?Q?4l7zCKdLtRzHC1IRD+8anSOzdfcQRikkHbYQNZrrm6SxQWBhKX+90OECebFk?=
 =?us-ascii?Q?9SO/hjVBE4nEi0kKw23RcjGHMmv6WK+4wlUykPlW9X3Iwu1tsXlg4jHojBYn?=
 =?us-ascii?Q?EOAOLUb1QMHRdvmxCMpRbGlyApieBoPfQA9m7vZDHWz9Uj4a2op5k9WPNIVq?=
 =?us-ascii?Q?7TL/w/AdbmKagv8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?S6eOitJElBEiVaVN8TI7Qvcn/si/ZWYDlUTOS2kw88FIYYZKh0xa9a4P+YJA?=
 =?us-ascii?Q?cXBHGR0Qf2LZlGCaNdEw32P6SS6BYJkjJG1Umi+yd9XSFWdNb1QEK276n+ga?=
 =?us-ascii?Q?BaBK79zpc6vEHPHq41XWPjJb8IUSnBOincpeVv7XDxIZvtJA0q9rMocnmTFF?=
 =?us-ascii?Q?bYRcnqi7H6bSJzPBJHkNkIME/8zjBywgiHycq6V0OJg0AQgDcZrwH8cTR/GF?=
 =?us-ascii?Q?eJTR7RKBVVMt4jsY4RYUNLUGtw5twE27rXwEu4imNge2DFlYTZrFdnUUzlrg?=
 =?us-ascii?Q?EIk1gf1bvjVzH/sqFtYPb+RKBhJ8pbv+0+9V4mpqw6NzSaML2Y3zsdFF+hyB?=
 =?us-ascii?Q?P+RWd+r8Jy6piKI1YYfpt19hS7gfZYL1XeMH1EY9pHNvyDHVwjpXq570ZhoA?=
 =?us-ascii?Q?eKb/7VNw8dU+ERKPqtvYP2/37Won2pKccRGOxoczNBnu3R9Ta2s7WW8LDx71?=
 =?us-ascii?Q?wRPEA8J5gvuxy9PS6hkIbh3IHQgfml7LaBqzqbYpO8/bqcGEawymOjmTchqc?=
 =?us-ascii?Q?iig41wi3zM7gq9wsiYWlW3t6TT2zYrheOf4tFjxVlFrj3LrLGahRz53MVzXX?=
 =?us-ascii?Q?21uce3ZGU7cSQrkjyRhkg0g2H0qbOc/+bWLLJ6/wLsX+9zdE2WcWohdFwM24?=
 =?us-ascii?Q?K1yJCnASkeTGrBjKWU4cXGJWYZJmSqBXXDvrT2EThJ2oSbEpKeSBZj9OInCz?=
 =?us-ascii?Q?VXhxqjawS6PhxuwBjhQIrRQHXkNz4Qkf8Sib69GkkJ6aJZk/EmneFfpmcZPb?=
 =?us-ascii?Q?P05LYxcA8ueJsH/r8kX+v3zEnrsi8l5IboXIcBaz7YMk3dNfSsn364s+G7n0?=
 =?us-ascii?Q?rK+YzxltBwKmy+yMrDPGAPh/9kW3yJHsUyYieTKyMXIQxyYvosK8QN69VIyJ?=
 =?us-ascii?Q?POPT6CB5v4xH8RGm9/XN88Nlrfpb4D3LbUav633y6WVIN7hjDq2y8j99v/m4?=
 =?us-ascii?Q?qPdai3jAUG3sVaYFyiAPa8uxsYmdAyPybZew8pY4C9BHxq0215LLZev5GQsI?=
 =?us-ascii?Q?zmsBO1dClOszt7DWDS6s4RmIlDFdVkKvs71AXSv2na9jhmUli7tsxHFBZplj?=
 =?us-ascii?Q?Xny8laWiFWN5ffvAV2WP4iiXx7agZJWmp2kHSJDkRHSG6655rqPC1dxBF8eS?=
 =?us-ascii?Q?1VUN07DvxwC4WBvnXVMOQxoThuiu3NqlrHLgh7x2IWu81SyANOTZCRD82QIx?=
 =?us-ascii?Q?d0mNZjfmpUWTcxjgRs3A0jSNUjsMYy7yQvj45nGAdqG++M5+lepCul8bOr98?=
 =?us-ascii?Q?xFRHJhwWvu82Ra2lCzXzb7zipx29CWhJuNNcgvWD7lwDQUJDpf8U3hKWcyPr?=
 =?us-ascii?Q?MsKnCTecETCeim7lf1BQFUYxt4sf+AMkGqNBmQGFYfNjE4ir00xFeV176yLX?=
 =?us-ascii?Q?sm1IovM6ZBJGMELhKUkPgyc7xYIq7AiAcGpnPu+VWdxMoB/ckkWCJArxV154?=
 =?us-ascii?Q?ePJ1JftHo0buXFa8P9pz8EXPf+nS3rCPuacu8yeTQ+bAAJczynYI8DfHAJFR?=
 =?us-ascii?Q?iEHq6DhuVGWFwwrGNmndk8VpvMhetf66iKXV+DKUFTfcW11hqfn3GcY4S03f?=
 =?us-ascii?Q?Ij9hqqGPqlmMhiTKEhb83+AkkEDNDfBRXwvCQW1+/t1yoeBe0bFCBJggGDKj?=
 =?us-ascii?Q?YUxZ2ZRZWp0sk9Lij2YObX0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcef2458-07a6-4b13-30fc-08dde00371d1
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:05:55.8364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9drom0lpZEFpFSo6KJHnracPpzmzAr2cnI9EAiXAH7wlM3Sb4Wr7Pp4dSnfAUQwar73h25CudWn9hCRRtmz5RW70OA5W9S++Xi9fGBtCCB3kD7Aiuqa70eTJRYa8qMS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10458
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:06:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19855

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 7c537ccfe8982b186a6becc646872cde6061c8a6 upstream.

Use a local variable for the struct device pointers. This increases code
readability with shortened lines.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-5-tommaso.merciai.xr@=
bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-csi2.c   | 29 ++++++++++---------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index e592a363d531..5becd840d706 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -762,10 +762,11 @@ static const struct media_entity_operations rzg2l_csi=
2_entity_ops =3D {
=20
 static int rzg2l_csi2_probe(struct platform_device *pdev)
 {
+	struct device *dev =3D &pdev->dev;
 	struct rzg2l_csi2 *csi2;
 	int ret;
=20
-	csi2 =3D devm_kzalloc(&pdev->dev, sizeof(*csi2), GFP_KERNEL);
+	csi2 =3D devm_kzalloc(dev, sizeof(*csi2), GFP_KERNEL);
 	if (!csi2)
 		return -ENOMEM;
=20
@@ -773,28 +774,28 @@ static int rzg2l_csi2_probe(struct platform_device *p=
dev)
 	if (IS_ERR(csi2->base))
 		return PTR_ERR(csi2->base);
=20
-	csi2->cmn_rstb =3D devm_reset_control_get_exclusive(&pdev->dev, "cmn-rstb=
");
+	csi2->cmn_rstb =3D devm_reset_control_get_exclusive(dev, "cmn-rstb");
 	if (IS_ERR(csi2->cmn_rstb))
-		return dev_err_probe(&pdev->dev, PTR_ERR(csi2->cmn_rstb),
+		return dev_err_probe(dev, PTR_ERR(csi2->cmn_rstb),
 				     "Failed to get cpg cmn-rstb\n");
=20
-	csi2->presetn =3D devm_reset_control_get_shared(&pdev->dev, "presetn");
+	csi2->presetn =3D devm_reset_control_get_shared(dev, "presetn");
 	if (IS_ERR(csi2->presetn))
-		return dev_err_probe(&pdev->dev, PTR_ERR(csi2->presetn),
+		return dev_err_probe(dev, PTR_ERR(csi2->presetn),
 				     "Failed to get cpg presetn\n");
=20
-	csi2->sysclk =3D devm_clk_get(&pdev->dev, "system");
+	csi2->sysclk =3D devm_clk_get(dev, "system");
 	if (IS_ERR(csi2->sysclk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(csi2->sysclk),
+		return dev_err_probe(dev, PTR_ERR(csi2->sysclk),
 				     "Failed to get system clk\n");
=20
-	csi2->vclk =3D devm_clk_get(&pdev->dev, "video");
+	csi2->vclk =3D devm_clk_get(dev, "video");
 	if (IS_ERR(csi2->vclk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(csi2->vclk),
+		return dev_err_probe(dev, PTR_ERR(csi2->vclk),
 				     "Failed to get video clock\n");
 	csi2->vclk_rate =3D clk_get_rate(csi2->vclk);
=20
-	csi2->dev =3D &pdev->dev;
+	csi2->dev =3D dev;
=20
 	platform_set_drvdata(pdev, csi2);
=20
@@ -802,17 +803,17 @@ static int rzg2l_csi2_probe(struct platform_device *p=
dev)
 	if (ret)
 		return ret;
=20
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_enable(dev);
=20
 	ret =3D rzg2l_validate_csi2_lanes(csi2);
 	if (ret)
 		goto error_pm;
=20
-	csi2->subdev.dev =3D &pdev->dev;
+	csi2->subdev.dev =3D dev;
 	v4l2_subdev_init(&csi2->subdev, &rzg2l_csi2_subdev_ops);
 	v4l2_set_subdevdata(&csi2->subdev, &pdev->dev);
 	snprintf(csi2->subdev.name, sizeof(csi2->subdev.name),
-		 "csi-%s", dev_name(&pdev->dev));
+		 "csi-%s", dev_name(dev));
 	csi2->subdev.flags =3D V4L2_SUBDEV_FL_HAS_DEVNODE;
=20
 	csi2->subdev.entity.function =3D MEDIA_ENT_F_VID_IF_BRIDGE;
@@ -849,7 +850,7 @@ static int rzg2l_csi2_probe(struct platform_device *pde=
v)
 	v4l2_async_nf_cleanup(&csi2->notifier);
 	media_entity_cleanup(&csi2->subdev.entity);
 error_pm:
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(dev);
=20
 	return ret;
 }
--=20
2.43.0


