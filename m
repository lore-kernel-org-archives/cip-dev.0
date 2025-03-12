Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3369C28B28
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:15 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.11])
 by mx.groups.io with SMTP id smtpd.web10.34469.1741778744573915875
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:25:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=vRUclxpf;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.11, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLv+XFgvZeubHnya3ndB6HYYdNFsHgF5wKDX6Qd4rxH7bLV4EIm7OpARxXeIRSqPiwpBPqOBW2nZmMQc0BxDwBShJ+IKQS0XFvRbcYEz1lzuV5DPosBUjBe9GxwzaywNwbvdRZfgYl0FHIFmEaZddmKORVEFIVwJmMuaGIbu0heAQALJDJNCLbD1W+SvaHitwsTBHVQ2pHO/0RssD96xIFnkdFfAPvpa5DUBYAlFLgUGwLEn9VBfXHUlZC+Cb7NjTFldy2J3WKk7l7S3AM4BgB9MFD4K/vL7ykkbkmnM4kCGMyjx/4GpJ/E4jEk3dN5ymTW+KrvZudrZR1VQRQByqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4iiXBIYYQ3lGGbVqV5mQQj57Ppu5u4myXmZJdn8esA=;
 b=nuGlc44oHZCvAYx0K/KyhMzeJXzLwYGblrPQOUKk0xIQoAUsr1uV+HOtUj2FmmlmX+VOkiTdXWrmZS+31QjWv7GMVB6wbmUFNjHu6otxI+OI0abnUsyRkGjh9RdZ1P5gATgESmfu0qbdW5x7jV6IjDZGcrFGIVlcboO9gsTOZiGdQS02KmT88BHJc1aTvBDlYvvX/dhyDu6QTId2mzPM81OgRtL1xMeQWt2ZlQgbxe/yoruqgEbYFVuJGmHLWsH+Sr9Mxs20vUUubh2ai6lxvRtAYlbu1+OP4Y6/47N4W/gxKh8b14ftnD5Ye1DhcUg/BBuZDls7Ih/0QUZ3+ZWZqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4iiXBIYYQ3lGGbVqV5mQQj57Ppu5u4myXmZJdn8esA=;
 b=vRUclxpfHcWGWlgX6hXQbkV5vUBmFtJn562HLW1FyQQI/ix4Rx7hLthieRyab5fhC+yUMFCuGh8yr13JdlmKJ0orW8rTC3qHiwbZHi9NSrfw5buE/+eKADjdxkiBX4tayPhv5eWTFsJ+Jq4966dsgWg7NYOSPklHTBMDSgwFhKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYWPR01MB10982.jpnprd01.prod.outlook.com (2603:1096:400:397::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:25:42 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:25:42 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 43/85] pinctrl: renesas: rzg2l: Adjust bit masks for PIN_CFG_VARIABLE to use BIT(62)
Date: Wed, 12 Mar 2025 12:22:20 +0100
Message-ID: <20250312112302.1605750-44-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYWPR01MB10982:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd6c101-e85a-4910-df9c-08dd61589fce
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?aA6/pShQxvGlAatC8jD2m9yP26yFMfioXufmCVlU1ZgXywqxkAKN6kMHs/sp?=
 =?us-ascii?Q?a+A5/imKV98JuMzd6AhfoxWqr0/jHgoUG3ccgD+nttMc5VRmTsQCRxM5fdOj?=
 =?us-ascii?Q?72hz171W7PwBPVyOuvP4jqi6BhhzE7LzxeZBMWjsmpr+M3rQSW1OxxJUfqhC?=
 =?us-ascii?Q?iKQrqRnWihDHjBhsPaj5Qfi1z47X+Bm36q54JEnZ38jZdbaoMEeysL6n0w6M?=
 =?us-ascii?Q?V2tqr3zeWvIoViJIZsFQ/owiGOshXrEkoprrAUkpnFjETA58yg4Ne1D+gwgX?=
 =?us-ascii?Q?IwdHSR7QD23BArQL6HxJKGVJtSV7pUk9fjna8TstLjZ1d2jTbSrEgswaOGl9?=
 =?us-ascii?Q?2REB3QzcPQnjdSJmB/fwwaPoMYAVadshIARGNx7cAG9V7TiI5+F+Wj3WKtWB?=
 =?us-ascii?Q?5GA2OdVAe6A38khKGWzg56UT8M2QR0g5XU37MDh7LE6V5sqKep+S8R6Ky0s9?=
 =?us-ascii?Q?zf/Bq1BzooSPt5HfH5N941GGBSCVZ5Fb6W2NWHGSrbtN+4rhl42YFspmES5+?=
 =?us-ascii?Q?QRyeuOyY3gLAzU++aRBGqZJROIeu5TZpq96Rx30H8735leOEbWJpUcRXGIhs?=
 =?us-ascii?Q?zCbjiS8qbDijH5riuBpkii+VoTflwkOJFFD+3gnGPPdkR47X+Jc7OQtq/RPP?=
 =?us-ascii?Q?90VC57Ne9bBEQsGdIoSrBWZpxW7KXr8K185gc9dZZkjkpv0FqUjIAf7LPgBY?=
 =?us-ascii?Q?K40YXRUN3eRjRfeky26xk7Jko5wE1LCDTRaHZdJpexKaJkxqkVQnhVbDTTmY?=
 =?us-ascii?Q?HEDDSqWQSLgT43j/NKTf/UbUu3Bw0gz9WGNsXjeAStWO24aSxt7bv/KRsu//?=
 =?us-ascii?Q?UHvU8NvsbLFCzL4OGO80f/LkeOoteHgUnU7mFKWfxxBgvdz1D69RvFjCFM1u?=
 =?us-ascii?Q?1Y59B79+qqlIf9hvI/tMdUzNdcM1q2TprSy/yc4kZExlIrAuTClnj3ac0yfp?=
 =?us-ascii?Q?8pP4+m+YlMBbpnXBk9IlfX5Tmcn6TX3pl+2M4W9mCwPno1gY9wBYXFjpCvzC?=
 =?us-ascii?Q?ZOXFiRfsyEY/1L65ffdBl8WdlHJiUB+1j9ceryi2tuT88gDVoy8AAhEMkZFa?=
 =?us-ascii?Q?Rbbfv3tv0XMa9WOMAUgDNRIknbh6UEK3triyK+wxs1NgcJiy9QFbxSLn63xf?=
 =?us-ascii?Q?gem382e2z75jIfb/2Sko1sgTUOGrv79n9ngZaScirqaXqlbMWqF858zGHQx6?=
 =?us-ascii?Q?6XU/tJGa07oSAn0Jid/TNiLHUKfFSPeObNg4ODbF0NgCf1oUKBkEVKoLwK3T?=
 =?us-ascii?Q?ylHh9fpCirFlssRgq6lEI6p/t+kEJkuoeR9JAv9yTOx5eX5vzyGSThFHIpzJ?=
 =?us-ascii?Q?SA2SCDxoCTKZFxBvC2jWjL3LIqHSYXCRMXh7qZz4EOrmwrU/O9ONaqyrpS8y?=
 =?us-ascii?Q?jroff8aWXEfmHQiWeLLR9VGpcFY7Uvw8Aj/n6EtbxBGberDSCl4t/JQG9Mj8?=
 =?us-ascii?Q?5qJDlUz/Pz1PHuPeWKO38ERIKaroHCzi?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sDWuycJt9skI7sdcV1rvQJFOSd53BaAYF9yFYEzJFEkqRiKNAPsotY/xcU5l?=
 =?us-ascii?Q?Tgwis1FbK6F+R28xc6ZaF4lI1uhcbk6MZlmrS9cX6/iAPe5tvi003GiZRxXd?=
 =?us-ascii?Q?SBLitdqMoEUpJCh0P99p//jSXIGMjQnxtIF7V2J0F7iXvV/vsEEQy8Vf2D9v?=
 =?us-ascii?Q?YkiFBZzLAa1l1ZpJVn1Y/8o1UZt5tOZHkY8A1xf8wGr45u8tkqDp/1BKrI+v?=
 =?us-ascii?Q?jEE4Icd11fDwc9BoZL+JfheXQhGV3FbWRrIe8x3gtIFeJNlcihusCt1dpVDY?=
 =?us-ascii?Q?bFpa9YZ441YlnMTzz26SDKtsfgjkzB7gY90ojm3xnH/quzm6g+R2pnc0QMYe?=
 =?us-ascii?Q?hTB4lagL+iT3vklgbunur02ycNAujiYwzCPoIAKrtjIqmtFzgg7eiY3V1/jl?=
 =?us-ascii?Q?XCbgZ4SALAR1e0duKaxS3X52vo3yCKrNVVtImn1HoYUW+Zr+ssMA+veL7FmY?=
 =?us-ascii?Q?Otyh+NftII5Wqypc1V7Hqi5/JeV9AUWpzt6hwwl8bCcPmpqtC92qqdhjWwLi?=
 =?us-ascii?Q?s9pINUxvA8AcPoWFRecUdrRQyB3IoS0sGF0zMXglwrR6XFopLRWsgJZOchXT?=
 =?us-ascii?Q?jbQ5doc9SMS/z5uLj5WACkkPH02VuCotcFbqfRj5E0dSUz4K3Q0BILO1o+hl?=
 =?us-ascii?Q?WmprqtB+L66pekuW69uRDNSxo6GhxPGLYmlQDJmwOFU6p7gnvlp7LWtMEQTy?=
 =?us-ascii?Q?7s897yNpHIAWCY2/hm5lS4fUYo4NaEYzanRC0qfgFNEEBxtRab31/YJArpc4?=
 =?us-ascii?Q?qlSzkx594CRltXqF6V3qdv7VVWMi1BR9YLE6rqaYqFMDZYDVpcy8ZVYcumQp?=
 =?us-ascii?Q?vZyBYo617ac6BLAaKOPAbI+tdqFv4sCvfx7xD52JFsRmat3zvxwgUjdHUxbo?=
 =?us-ascii?Q?eHf9vVWUPR1CudnEKtk/z4boJ0SWsUcnbq13HeGeLebSLlXrosIQ5cz0yskj?=
 =?us-ascii?Q?dfNcRG6KH4dJ9zczY7sQSXID5znbOEg1uXPVREMCMCQ/mSnT7IcDOml6X80a?=
 =?us-ascii?Q?HIatZ+41wSdn2aVOUeRXxoPTgJWMVq15ydhr6/NOcRRRiFC3xWW+9zNCXUM8?=
 =?us-ascii?Q?5F7hvGawqPwKnUhIk5WQ8rQnbRmdbbfvsNrCcgl69+Vif1t5SZaBqaLgbXA+?=
 =?us-ascii?Q?vYA3lj7LZNxw49JkZdWXyL2uQWA16N+iELqpRetBgQj0BGMEm26Q0mOismKH?=
 =?us-ascii?Q?ZTQ3fqOQp9R5Zf1G8zLz/HsUgCjGvvSqnd9VBfW0bLaPLFaia5PJQROPIUnm?=
 =?us-ascii?Q?gP5ufe1JAiqj3ilvBaKzcfQm3T1J+p6GmHFTSghXJt0QuicgNRffcx9wvQmu?=
 =?us-ascii?Q?ndg4mgP88gzgRzmTOSQMcbiFeyW6fZcNJRzNayaSXh2eBBGwZvyBwCqTPRZ/?=
 =?us-ascii?Q?G8fri6GRMKaUvSVT+YumgiskH77iLo1U54xvBTwFHeTx8/q4e+p159VkBRbe?=
 =?us-ascii?Q?03CtkPTjwlh8NCRvcEP/P+FvYGYB/suVMA9iYYMqZnVZiVat/7m69AqCPWXo?=
 =?us-ascii?Q?1vVKfxdo4WCasD4l45M3iuhUlAWGSnc8QLwhl8BEUk8YULiWgZ/Lm/OFanPk?=
 =?us-ascii?Q?UNy3xM+SZ6+PhPuLBImlj1rbytHaefpnzM/OyI4YE7y7KFEibvmdqHPAK7CE?=
 =?us-ascii?Q?GGbhQhGurw4r/SXYflOIfII=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd6c101-e85a-4910-df9c-08dd61589fce
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:25:42.3677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kN+S1w1ZBoTK90ikNeExnBrDLBg623bjQVjuXsY/OiMREOXHmsnbierMA9IrpdXMd10jcrUMVrbPN2JRs+p7wTqGj4bKd+U8aVgE5BDGEGlcqZxp3EG9tj5VfXMaQTx0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10982
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18135

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit f0cdf878a22b91141d6050deed0eac70ab982ebc upstream.

Shift the bit masks for `PIN_CFG_PIN_MAP_MASK` and `PIN_CFG_PIN_REG_MASK`,
to accommodate `PIN_CFG_VARIABLE` using `BIT(62)`.

Previously, these bit masks were placed higher up in the bit range, which
did not leave room for `PIN_CFG_VARIABLE` at `BIT(62)`. By adjusting these
masks, we ensure that `PIN_CFG_VARIABLE` can occupy `BIT(62)` without any
conflicts. The updated masks are now:
- `PIN_CFG_PIN_MAP_MASK`: `GENMASK_ULL(61, 54)` (was `GENMASK_ULL(62, 55)`)
- `PIN_CFG_PIN_REG_MASK`: `GENMASK_ULL(53, 46)` (was `GENMASK_ULL(54, 47)`)

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20240618174831.415583-3-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index b4ad4a4d2046..2a8223a9e226 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -86,8 +86,8 @@
 					 PIN_CFG_FILNUM | \
 					 PIN_CFG_FILCLKSEL)
=20
-#define PIN_CFG_PIN_MAP_MASK		GENMASK_ULL(62, 55)
-#define PIN_CFG_PIN_REG_MASK		GENMASK_ULL(54, 47)
+#define PIN_CFG_PIN_MAP_MASK		GENMASK_ULL(61, 54)
+#define PIN_CFG_PIN_REG_MASK		GENMASK_ULL(53, 46)
 #define PIN_CFG_MASK			GENMASK_ULL(31, 0)
=20
 /*
--=20
2.43.0


