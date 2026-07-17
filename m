Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6468AC4451C
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:15:50 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.70])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13203.1784294140933471342
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:15:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=dne9aUZ2;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.70, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DnGAxOXlAo4ZROIg8agRktLtbIBFHXrlRA+Ll3U0lDPaw41qsbk7uG57wk4whoBibVQHNbPKsr5kIEVT80QBzwvWXo8lrWZP1er31jVUbZvr8u21Jnvbqywf8ClgooRzt8eWEU5rNjFURDnFm5CG8A2cZpcpwrJ150T6jKLX9MhPEddrg5NLrk3JBv5GGpnMXMmaziLjrZSxlgvo53UcCWyFU0WSTSFBa/XaKlEI+dz0Q3haYfONP0sVXRh81rpcIAETwQatx3x4FmCrT3GbtgkXkkPBw3RArEbefWVy4LJgaznrag0xdJQY0OMetOkKNgxLbWH5rY6c55H3ulmzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoCdS1x1TL9ycXc8KqtdZVgMCxyTnZfH2fwNTFyXbHs=;
 b=OLy/vYgqn8Lt6jFvSUaBXAwcdahFhRCJpbQTY+Id5OceJPzB0vBtnb3SZI9Q8bAJYfCGb47PSjOyJW4Pj1BaF2ujrutD0KBnUZ312gyxM2nB8looSVR6eb/Ms0C3MCowHJjNuEB6cxu73sjaBdZmyVKF+diMkxr0onaIhSoWrFAo9mmWtjK6wSJu6QfPEogsIbD0Q8/RJl4R9tuE+0gIzaU2mHtxYWCoim6I596AKA4L4YlH9tdEhZ7yjStPCRRsTbP9eLS38yXfGEM4ugM8TvJFFBUne3fqFRBKCxWAalKbu8NKlIc8VlDh0MGmlinm7+h/8LCa78KKEybpB+xQ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoCdS1x1TL9ycXc8KqtdZVgMCxyTnZfH2fwNTFyXbHs=;
 b=dne9aUZ2x6J6Izux1xYMR8PelVitfjz7lif/dO6NRNRJiGXtDMUGC6YX3t1zl3ENJD9gLLhu9JFLJL/x51f2Wc0RTU9JWsZplMklR3InTMxadhQrLgXWxJCfGd1hbJDNAA8LrNkzC6L/MU5hFvnMd+b6g+Lmzw5B1jXijd+UDS4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYWPR01MB8447.jpnprd01.prod.outlook.com (2603:1096:400:174::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:15:38 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:15:38 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 05/15] hwmon: (tmp108) Do not fail in I3C probe when I3C regmap is a module
Date: Fri, 17 Jul 2026 15:14:52 +0200
Message-ID: <20260717131502.2234020-6-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717131502.2234020-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260717131502.2234020-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::6) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TYWPR01MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf09bb9-d137-44ae-7741-08dee4057ea0
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|52116014|38350700014|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	qXNrXyH9CqsLqzc2tROTjIS4ufE+qeK556MNkwvsQhdAiiQnCIW4kIP9Ivp6WcRCcnkYoiQ1hMAbiz/yMvQJLYqMFVDiQc2tLC7cnGpMpJm6h5CA8RfNhEUf5BSnMK18JgZ20qiSEpe+BIZxK99pj51s8/OGWrxukkOl4116DxzPWm4GMMNgGfj+Wkw7gT5zmWVU00cs35ilrWItfSuX2oxdrW9u7kqRT5qy6U54BX5AwR7UCi3a6JliHRz5BvfnC2Q9LbominOHyAvKnCHxb+1pH1Hk0KtbCGFr0zaLU7msPQVNulc/0GMVrClOpNBOZrX5oNe3KLgmTJzcurCavp3xRVjGLRvzJVnliK70X82hEfa0R/HAy5UwNEkQJE+GeeyG9WTEj7e3CStMAQLNgC0LYq0cjseN7hSAu2zBJkVBepk5qXTcOmtDmORwRHUTmt+7XzJdRftep4kqf/yUdZFLmXSD1vyy3fiTWnzEU2E8p1rvMLtB/Bj86jMiDGsCh8ZUHRVBhXCW66s4t9tQUD11odcWaQD198fW+nAlPiTnaFMsLtag3+W8Ecr6TsHyPGlDT3shOR/xNDb+ob+TUoHnbz2cm/1Q3qvyof1i1M8uZiAkz6Ir0ToE+2znoUftZ0AwO2FJ6lKk4dbAnW45zTC+XR+QvWO++9yG52KaT5ycHHMwKjAvB30YpJn/dULIY7nF4BU92GgO9kdfxs5XrnLmp8JBRbww6ixIWGIe+Lk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(52116014)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4oysIMNaekT1JIWwxVaR3jbbRxt0jztD6UlxwEV/cWv+LlUfEPBhuu1gtnJx?=
 =?us-ascii?Q?XG8JhzWPAb3es6AgT3mos7pD64E9Z6UmgIgewSilRVNmwHRuK469tg5vRgI8?=
 =?us-ascii?Q?FGpthKAEqJqqsxJErwGtMg3NSqlHKVW7/rCPPTyrD2hFUtq0MRAuI3t1yWi0?=
 =?us-ascii?Q?64IQqPs1g7xVSoSHfH9sBEi4SCKY3CN0X7NCdgsPcXWSiSdBfzeKwqNkdS1+?=
 =?us-ascii?Q?p2xZxotRQSw2T0SKuDsl59OXODEi4AtllZcpfG0BUjagOea4ZAyK9qeocW1D?=
 =?us-ascii?Q?FIon/gQuLzA1y95xUYk5PyJV6JQRchYVN/tkKlEGQZ9MZRLzImLbsU5qvEZH?=
 =?us-ascii?Q?MOE0I6aR7O0TkA1siub76vHWKVIsO90F7kyvaqxTdTRPEi9wHqKkm4k1ME0D?=
 =?us-ascii?Q?2gUr8YWNRagPZRlG402CuAi52xfTKV3HhX07p99UIf6NLstNaBvcTgGpPboZ?=
 =?us-ascii?Q?m1siP65FwdDI7JV2baZNtgJ4y68XfxT1lN1r51zPLzdU7AwSoGxAkLLoyd7L?=
 =?us-ascii?Q?LXkDdJkrICDyyWP/V19/71FTQWrWazjjOJaWciViJJakXhUQJp2gZ0F3zsU1?=
 =?us-ascii?Q?YV2H24XGVzHOt6JMI7kGRklmp0dgTyyr5l17e+CLKkNW0oSzZgHdIK1uiciO?=
 =?us-ascii?Q?WroLQJFRWeN+BzqNpkd4qp/pR4+SNLKPaxTf36ZXCGZ4r0S/k/vaAIOgVXKv?=
 =?us-ascii?Q?a1v/7r1u1kk9K39yeXi3Efc2011DKxsRoBWXQ69IPtBk4Bj9fHG5rT2Id5cd?=
 =?us-ascii?Q?hzz3ff6zCKI8T1u6vUF9hFr7QHuld6XCRwD7035GXLAMN2MQZEgqEtTGxEDP?=
 =?us-ascii?Q?Rp9a6bWApGdegjltENRg/x1aALU2mctOW6TwbwdaUbd/HVE/Ji0u2AthOZZx?=
 =?us-ascii?Q?3JQfxcwotAabOLvk/XqxWojYnwjN5osR2rR8KXLd1E1aRmbd2LnnNyu8ze6j?=
 =?us-ascii?Q?3W+9iiaNf3MrzZTaWQ1ZZxGJiGZqqwjzYZ8ogd3oz6vZPzx/DoQ9skF8dFwI?=
 =?us-ascii?Q?8Ca//dD9XBdWvUEkvYl01jK32nKhJfM8/EJ9R2l7kGF/0KnGBUyRkCcTFVMt?=
 =?us-ascii?Q?neuA+EplqhIm+EdkhTs4Ywy+HIYziiieRKcxf7diQ1MfytreNcEbKxSS00JF?=
 =?us-ascii?Q?r8U2uLaNdFznF7RzBA4/YJutlns2odMBtJvpBQaTglG+Fdv6L3Ls7hFdz+xl?=
 =?us-ascii?Q?QR74hw3H0HwzxdH0I3fcGYO4dOyCMWMybkTl5g/Zrz/OAFs/5II05KOWBSkt?=
 =?us-ascii?Q?8hvQ6jIG3urKfScAQWIAqTlpPDtxbipdKrBqucj+O52AfMpWlQMCG9hEndxw?=
 =?us-ascii?Q?6AnFEYBwc+wZcLiqxPU3tD0eunXtUQ2Ep/CcvBmMnPijDegN5MezUyiUGsUo?=
 =?us-ascii?Q?NcViEYZiOgiuKnIYIRI07k9VNQHmjNtEPFdsglHr82utoQm8oz9dJkicG8Vh?=
 =?us-ascii?Q?eUjmkYmesf7VVu/zE4miQFADDdvE+flPeL8CZWUKBsXnebOG6gQ1HdJOab3R?=
 =?us-ascii?Q?2xia/d2dQzvIIqYoMpbeMKyyYrhTkqyhY8f/gg1v0HRMn+XDIbt/IgSLn+r0?=
 =?us-ascii?Q?P4ywGtecIEBrDU/NV9O8BEcnDtTSR6AiO026NTFBIC7f6AoD1JJC8MtL7Kp8?=
 =?us-ascii?Q?kSBrVipulEzWeglzy3Ru9NHzC5jTK8tb4KiEEflNpGy7XyLazAN+7i3yL6PM?=
 =?us-ascii?Q?9/kdLXCKGaze+5RgsJzs6FHOS07MugeKg9mpWAoDqfDP0ETF1hRuOpJwDjHZ?=
 =?us-ascii?Q?w877qtDuh5XNDQhSZ2k5YlV3vqRoZChgUyglmfHIQb9BGtg9Hnar?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf09bb9-d137-44ae-7741-08dee4057ea0
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:15:38.4501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VkPY7SRnoSm9kSVLV9Am7DioRbh8iDt5ivNdXuZSNzJMi4Tt9GXiCvQIEVTLbJFQ8W1gl/BWRMkUcBnfILsTLNrQBQ3HAtLfZJqCWi6VI1hsokZZ80PjGGgAU0tJ/Ixh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8447
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:15:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23657

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

commit 8281d627905dc72241ca3969ee18f3e029e96d00 upstream.

I3C device probe fails when CONFIG_REGMAP_I3C=3Dm:

	p3t1085_i3c 0-23615290090: error -ENODEV: Failed to register i3c regmap

Fix this by using the IS_ENABLED(CONFIG_REGMAP_I3C) macro in the code.

Fixes: c40655e33106 ("hwmon: (tmp108) Add support for I3C device")
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <20241121121819.393104-1-jarkko.nikula@linux.intel.com>
[groeck: Remove #ifdef entirely; it is not needed due to dead code eliminat=
ion]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/hwmon/tmp108.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index 1f36af2cd2d9..fbe673009126 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -452,12 +452,7 @@ static int p3t1085_i3c_probe(struct i3c_device *i3cdev=
)
 	struct device *dev =3D i3cdev_to_dev(i3cdev);
 	struct regmap *regmap;
=20
-#ifdef CONFIG_REGMAP_I3C
 	regmap =3D devm_regmap_init_i3c(i3cdev, &tmp108_regmap_config);
-#else
-	regmap =3D ERR_PTR(-ENODEV);
-#endif
-
 	if (IS_ERR(regmap))
 		return dev_err_probe(dev, PTR_ERR(regmap),
 				     "Failed to register i3c regmap\n");
--=20
2.54.0


