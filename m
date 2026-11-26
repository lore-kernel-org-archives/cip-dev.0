Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.68])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.583.1795708916234460591
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 08:01:57 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=TQAhnt08;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.68, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Obr51Se6vdKBGeBdu0FoTfRKAwiQBnmwLxyiS1XQEnm3gx6CCcZ6nA1mjrDCSjMUV8tS3oKnQUNMlLqt4JtOOzJ3bb12R7m+UdkQb1inoQ8DT2iHnE4WIjZuGpvaGy6VTYSQS+wksR5kbLdmq6b5nDXIIikDR7O+F0LaDN/f1n8mBNpjVmC1jv7Z6iOxRYG1dqvZZw1V00xa4Ql2il/ej39tIZIhQvTfZDc++BnMn0CHVX/+Jk+SDsjqtEFKtEYCmGcBwoOf+WEUcZ+jZAPVsd1gk6arw0OMJVz0bYHHCbs8EtfQleWEl9SBWAFZRGKo4/bylpTuWwNlfA0WhcysVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hZ3yzx/8QyIiRrZnmfwW5y1KlNuAlbSPM2dYo/47Rs=;
 b=eYpVVN6Ws8EmisheWCLVaWOVPvEZi+wckpiwRuyqdqeVvxSBuQzT2J3nAj7yqFqTLggyUoCqfEPi+NZDggu+hbHtUJdKJxRCd09YWjFK94ffZMBygXa7mjpeWTnmuqIjuf0zZxlhVibLgUy5HaLAQp9tr+cPV1vFW3G71ZpHPx3IvYkf4TOqr6qh5O4foxqccipNtNFZy4PaB4KUKfP5GHuS1nTutrGD8u0yPeUo1rm2JuoT9kaUrtQPEQqAX1TcC9eVJVqzgwIclL+XXuS49Wk8GEydlpPlF/2S05vRkny1BND3ybvs0rZwuiquuZ5AKadTBnozUOOtibK/MGe+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hZ3yzx/8QyIiRrZnmfwW5y1KlNuAlbSPM2dYo/47Rs=;
 b=TQAhnt080TQYKvKicXDIpqHjTe8rIM5bQD4zwrolSfPnhb6hwN/lTm7HvF+RgP6eGFSTBKElPOUAHIdEXxgrryjb8OJbfzzRIneLPBnWQ3cA9aM1sFPZutlXSBWBW+7WZUxoTgIlZubAIbh0pFFpwc2kxltKTEs1ZxFRsepp6OA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY5PR01MB181845.jpnprd01.prod.outlook.com
 (2603:1096:403:50b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 16:01:56 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 16:01:56 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 3/8] ASoC: renesas: rz-ssi: Drop the & operator in front of function name
Date: Thu, 26 Nov 2026 17:01:14 +0100
Message-ID: <20261126160119.3836850-4-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126160119.3836850-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126160119.3836850-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VIVP296CA0010.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:357::14) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY5PR01MB181845:EE_
X-MS-Office365-Filtering-Correlation-Id: afd6b03f-7c7c-4448-25a3-08df4bd69868
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|52116014|1800799024|261009223027099003|18002099003|22082099003|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261022105027099003|261021121427099003|38350700014|261021123027099003;
X-Microsoft-Antispam-Message-Info: 0g3j8nKnmhQEe09m578Bs0mu7muvy+XLOGJNqoL9PtrrtChhGp7AjZECWxWF0f7GJqbEvFiUk97CyGi1lvoM8uFubdUVtGSIXwz7yaajTV5lFuYdWYwWctQWu91vFqWSxz12jjel7D1ChUc1uxuQbOXhxeGx0jOCwaPq5g6kZPINb/GKqVubTH9jUE9/ZGvVMU7dekiRl5khUFV6wJNR2U/67seqYCf57CwtLT9EUUBDswkfSh7CJVZCrM2qVe3jPRFZ/dB3ls/LH/y6e25xCpQ7GfFbqgGSYB3Cilt7BPIyC/u4DZAf2Wj28IxV/u22qjfFsrrMtJeLoZW8yi9S5yB8guciX4++7lnPAlQY93ffgOM+zaOGpoVg7nLu0NMpeIvg9o5AJZEdFu7XcCYPkzqxZasP+rFDZdTh8qgKt6RFX9hIL5ziZDUfqVOTtcpOBzJbQdBISCZxs5DdNF7hZ1nIFt0fWBP8UMYtjnqpOn1kjwIhLRD65HeByaTkg+c6SdPCWw3xWs94lOf3tL2ApcZuLoMpqEeOX36DQLMkgmHUDJIefJ19AkxI2FsOsLoA8cDHv3ihGtscjcEtWHrcK2Z6+oWnnq6uu5W9NhNaKQTU1IyT352czysrEZRSXk+AcyLBPglGc613kz1cVpfXISS5SLhxa7z2OiqkPaqFADQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(52116014)(1800799024)(261009223027099003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(261021121427099003)(38350700014)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DzC/GuLZ8FV6ILyOnJpsrjpAcwbV4TiiKNM8fhZGK22XwDiXYeGGMp9O8gY5?=
 =?us-ascii?Q?yaxhzO3cS6QPKnZhBB/axaggNKGZOTlqepsdDfcOSpCBnrXVrHMoI7wD9CAs?=
 =?us-ascii?Q?xPb8Wx488wcoqb6Thx4I4vDnU8xx3lPV30o77mbsImqAw0f6lMNgl3V4jZia?=
 =?us-ascii?Q?iAhMJA6YsF0PVhnEH21GIhptjyHZCnXeqkz3LdHjcZjaJtgt/bpOQohEpMd8?=
 =?us-ascii?Q?YeiINGryWf+epnwwFCPv4BCEMzosJww2nnB62pew0eXOGzOq+kdVqax5Zkk0?=
 =?us-ascii?Q?+Y75YHKUXdjMd3fgA+dXe+txnfd3oFChpFytv8vG6QRNtcroZCC/8P2M0Ek8?=
 =?us-ascii?Q?ypxQ8uw0nIDugVNn7wxJLbz+DKFPk+PI9xVH1+TB5GqFoyMb6dQ7+XxAGDbv?=
 =?us-ascii?Q?1i1vbBXhtsg5rQtil0JEx3os2NpF0NNrFt3u7iM7IgK3rJScu1CXS8nS7LZ1?=
 =?us-ascii?Q?KkK/poLuycYtvb33tzNxYrXjV6HuTrV69G736WfClARgiLHSqI5JRvtT/Wy/?=
 =?us-ascii?Q?Fch6JEEQJBO19hHkmdhQhOmc9kSPGpaCRkVNDDrQF0WpsGZjmElxsGT2RyXR?=
 =?us-ascii?Q?GnNKWG9lzeIhnIFbFdUjvqJDprh9icFsi3Y7z7npObB+MtTQphOOJwBUOo85?=
 =?us-ascii?Q?n4qO8TKJqTgXtPK5+zqvkWNqle3hzblOojREpyMeNH7+Mkj4fxYpGjmgK31V?=
 =?us-ascii?Q?OSWJZLjph4T5EnLmjDB4xv6EBkPNu6He1vY6gTiDsfmrtY0JSGZCGIiX/Y76?=
 =?us-ascii?Q?shdatZrxPsoOmRmVoPw6T4JQZCmb+065lgZ0cgPURmNO2FHWAo9ZRhC+woi0?=
 =?us-ascii?Q?cdq+yUIVumsPK8gvyWjPfbeYGAGKqFd86TP2JbZAQsHhVJfQdSNfgV/YrEPf?=
 =?us-ascii?Q?aBNh7NUnRdQKfWyxS0qlh4z53LcYk4sPsCALw3ZbVWTtZlZMjme0IPZ0qUsC?=
 =?us-ascii?Q?jgTTjD7hGitnznC2NbHYuFzcExuWU5CmuTy49XWC7ZnddGVU11osWiObH3Fj?=
 =?us-ascii?Q?H+SRAck4UOU9xxX0ImnNBbg1gTKtvpV8iLV4n5ibAJz96Uo/08Z13Kz90nER?=
 =?us-ascii?Q?YBsaUFSunkedQJocCx0VpTU3dHpUZyWPEQ+H2oRZesZ91zuDpnU3JCeXys5r?=
 =?us-ascii?Q?ns6AiVDKeGOC0H7EfSyKF1siC8xvKk1jlBDCUAzL4CaacZnzVYfR+5q36Kc/?=
 =?us-ascii?Q?I/C4dTMm1x2srrzX/Q/PNWuDc0JP9qd+9IVAhgVn+hfKF3uJeyxtwPqxOuKJ?=
 =?us-ascii?Q?5zkJ82ti7rlk1CwhPB1nFHoOa08v3FTHjfV0+v13t5hueRx7KSi+jvCLgv1V?=
 =?us-ascii?Q?mIF8HK/dbLbBVRkt7hhfRMhyoWpM1z2QyWrEofOg9QnGALU+KZA8sTqZnM5M?=
 =?us-ascii?Q?K4RUqpAvm2w3Lu+PrQwzcxHDfPfx9H8tehJQ8dXSaFT2isufcjGFZouhINi2?=
 =?us-ascii?Q?KToOq5k4MA7Ci+chbThEjuMj7PcR24qbpgpltkmDlJpbtGbRKHp3rdU6wbrQ?=
 =?us-ascii?Q?ZDfGHjEIbv9l4/rJqS1RcWU2+wg4kysC8CP0RsHyrlCmncJe85xxXmuOJw3s?=
 =?us-ascii?Q?+8kPgY7EzFOhIleZzUlN2AsJuCXltDdJ5s9kBBYZurBMPIuvG8ISFkwLnrNx?=
 =?us-ascii?Q?Zwd8FTZdiyV19L5S8mi6EQz48PpzwI80tr9TwGTjxjsPhRSa0mY+Y/n2KN7U?=
 =?us-ascii?Q?zzpReh2BFSwHt5b1Hd02H5bjj2FSxh58HQUJlG54MyHG4zCsuqYdh9wgxPkY?=
 =?us-ascii?Q?SgDuNHvIzoyq3Rl08MiBAwSZgkXWLATGlGpYxv2TmJIhioXMni34?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd6b03f-7c7c-4448-25a3-08df4bd69868
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 16:01:56.4927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7tJn9FQTXD93NX3yI5TNfoqDaj4KdFRJ9JzHMc9WpZZcfnC6agF8lfHKNyw3KRVToXlz4pNofGoXLZlAYuXB4wjspBqKbow4ntj3aCQUe78MuzV/8U3oW8TdcJUPWzz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB181845
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 16:02:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25218
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c7a4c368e7135046c358ff15c4f7897e2522dedc upstream.

There is no need for & operator in front of the function name. Drop it.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260119195252.3362486-4-claudiu.beznea.uj@b=
p.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 86ae5869cae7..11165dafe51a 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1196,7 +1196,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
 		goto err_release_dma_chs;
 	}
=20
-	ret =3D devm_request_irq(dev, ssi->irq_int, &rz_ssi_interrupt,
+	ret =3D devm_request_irq(dev, ssi->irq_int, rz_ssi_interrupt,
 			       0, dev_name(dev), ssi);
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "irq request error (int_req)\n");
@@ -1213,7 +1213,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
 				return ssi->irq_rt;
=20
 			ret =3D devm_request_irq(dev, ssi->irq_rt,
-					       &rz_ssi_interrupt, 0,
+					       rz_ssi_interrupt, 0,
 					       dev_name(dev), ssi);
 			if (ret < 0)
 				return dev_err_probe(dev, ret,
@@ -1226,14 +1226,14 @@ static int rz_ssi_probe(struct platform_device *pde=
v)
 				return ssi->irq_rx;
=20
 			ret =3D devm_request_irq(dev, ssi->irq_tx,
-					       &rz_ssi_interrupt, 0,
+					       rz_ssi_interrupt, 0,
 					       dev_name(dev), ssi);
 			if (ret < 0)
 				return dev_err_probe(dev, ret,
 						"irq request error (dma_tx)\n");
=20
 			ret =3D devm_request_irq(dev, ssi->irq_rx,
-					       &rz_ssi_interrupt, 0,
+					       rz_ssi_interrupt, 0,
 					       dev_name(dev), ssi);
 			if (ret < 0)
 				return dev_err_probe(dev, ret,
--=20
2.54.0

