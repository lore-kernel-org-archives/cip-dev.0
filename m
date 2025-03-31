Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811B0C3600B
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:46:21 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.10])
 by mx.groups.io with SMTP id smtpd.web11.48805.1743417978322730371
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:46:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=NJdoNujs;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.10, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MggjfGAtjkYsFlUnPWFNVjrPo89kuycPBjceTJSGYTNluCH9+J9tkP1TeNKOz1IASETmdy/cfCMCts0otQoM7SfCwY6fhNKhqk4/P9T5dVTi0qvihCqKSPhwhKaWB5QnHDTmc5cu4nqfby9S9u6rRJaVpFJImkkadJTtGtOOBKiWXa0bs78aSE/AiFaKm56GZEPiUF1spt7K2AGWdvhKHWiqZGVkM1IExFXeqY6K3jbT4iwUYZr035K/SYS62rfqoU1QvM6fOI8qVqCN7ozbFWgOcSPcxvU3HNg322KNt3ZJfogvU9n30B4MjlVDlEgqtftvj9iJM1QcydAUpfKu+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHLOdaZ+9EDpZ0pvp8et5M2qza69vo6KeCEjSEQdoiQ=;
 b=hzWIu7fckcKlkefmZbtwLViIUR4ooQUeZKViG+xREpZpJJbHZZCQKOn4W+PW+3HpUjDStep1l2QnV4OuLcmYMot7saE77ydQPrYJ2AXO/NNLXMhK53FykuNaq7MAixUtbZnuIppR2w9hknL6JBoEsMWJndSIgsYgoabk7nkNKOP23PgcAdfumVkTDhKDMUJ9yNHSJr7+G9owbbCKDdYqOJDgd+iGpU4gwbVBgfaugEJko3aHobJgZs6BBIQv81832p1D6klWbnZ3rKBJhQWONpygL1AE2Jw7mdZnJaF6eQIDO/qloUreJmGJ5Y4G3b0FqJ5Rubk/lkRZAAz5y3RdaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHLOdaZ+9EDpZ0pvp8et5M2qza69vo6KeCEjSEQdoiQ=;
 b=NJdoNujsE8pg3LVNuxYk9QhuBBmSWBwZVuu4rcy54MWr7/y5SXVone7kXYM0Md2TM9x8OsEZ39LSil1oKBr5YcJWPhhCs1dKIFSk9uOG/PHnfRebb4KULS6AgEUJqQfDQF3eqTBbZEYRd8Es1/06cGQxUGHi5k6OHHaLFEbU8/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYCPR01MB9796.jpnprd01.prod.outlook.com (2603:1096:400:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 10:46:16 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:46:16 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 15/43] pinctrl: renesas: rzg2l: Add support for pull-up/down
Date: Mon, 31 Mar 2025 12:44:46 +0200
Message-ID: <20250331104514.79090-16-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYCPR01MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: 8161ae78-f8f7-4fed-a1e2-08dd70414354
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Vm2QR9+EFdesX9MJpepEFzxdWHgQGT9JHTrzXEzyKQT+V5K1OV95W9EFgqna?=
 =?us-ascii?Q?ZIHe8JUbRuqKz2z5uylIiuJWf2DWvzbY9w8TzLeCQ2pHQQsL7eq7L8zNUk/+?=
 =?us-ascii?Q?p/8M3wudahEfUeyf16t7QsBDN4M5ZFMKn794Lff/166VsNkwt4TCLhUrw2Rd?=
 =?us-ascii?Q?EpifmWLHyyZ/7YaauC8hm9m9S6fDbUBwWsbxof7jNIdjiX2MkjvtxNO6I7r1?=
 =?us-ascii?Q?1yAzN8O3X2WzPS0khmZbg2BRcbZUIRjiUIBJwfwcWVU6FT55iNr33wrPlZzs?=
 =?us-ascii?Q?dmD5xZo6M7BpPaTcz2rK/HPbisP/bfZ7iRWBTTFNubkHh4gumqEWqG5zu8Pu?=
 =?us-ascii?Q?CH37IA+oGYOc3ppeNHHJBOX53cjt9EjtuVMAKZ/d8Z7kl77RQIIujM0CQnDh?=
 =?us-ascii?Q?9xjjAlQdvMbtg1oZfLofs3jUJ55HGBA/a64iJdK8dCLJmtRUrClJpTsuPN1y?=
 =?us-ascii?Q?oX7Ti/mbFyoFoW3DTYGSdSv9VOJBqAYiQbPtDnVaAuRZgEH/bneLlwpXsBg1?=
 =?us-ascii?Q?Tq0IKjhtffRB7q+3KMgToQBt17FuqTtJtCek0FbRNVyfkP2OE0KWHu9m0mxp?=
 =?us-ascii?Q?Mi1sCCLEUNdHNPf0FXAzWj6yGFoWyQGFdNtljKqOBSV+AXzetcNKrBFV90wf?=
 =?us-ascii?Q?vcRqOEJZL8/9lU/gZjlQWDNBYjpbsPHhJ80QXRJYCjSAMz85CfbhsBohafZo?=
 =?us-ascii?Q?1s1RfKlqx0kBMN6tMzSx/M5WcZnxWvo3gkNjuwf2AmDbK9BLiglDrJR5G5R9?=
 =?us-ascii?Q?peWkKcBsiOdczVx8q8KknMwzWcNE8O8frNSEMiNF8usXCGVIqfEqkOA2wRbX?=
 =?us-ascii?Q?cEe2ZMMRu096HrehjQCHgQHtSSrqOL4sOGML9uvOeOVAQPYC6QWolPMEkJ0l?=
 =?us-ascii?Q?EKNqACod9q/rzSXa1d32a9GZG2AYN1Kh7G5C6SM9C1ulr67De14M2Z+4vKGh?=
 =?us-ascii?Q?PKVqvYjH7AhHOZhMuDeSNNWmLJUBOXXQQjqTbUSBZpH7EViH1i14Uog57tHg?=
 =?us-ascii?Q?l0uEh2m/U1BlAa03/YxBF1UZjfSYUDoaPcSFF19msAOoVJ6p++d3Eo4JUb83?=
 =?us-ascii?Q?IJ+E9cZ5oqGPXgPGG8AyJE9cfOeE1fyOU6ckrKjwh320QXiFQ+YXchMzaCNH?=
 =?us-ascii?Q?XwxxTn4PYOsFGhobqbxQpklztd/SyniPkBTVNg5Z/zMbsYP7hm63xH77igt9?=
 =?us-ascii?Q?3ETaFJKiZbpnVOxMLYlBfD0emvDoNy7F4MA5gVQ6br4PWpMmGNpoY99lJd83?=
 =?us-ascii?Q?FseT7PbEB0UTtKYJVrMfNaAUYbFDVIk+DLGPiY/d1nxbOZijNFTXtMg9sNOh?=
 =?us-ascii?Q?lDTxJ71r/pvsY+WMITjNGtk5F21bXJ8cl3FPYQIgoAZRluZHlfWaToHhnUFc?=
 =?us-ascii?Q?aYyLQj0l/ghvr+90JfL6teVvqnK5aqx+lioDo6ZKUJTcn27qXzCu5RMfk+jM?=
 =?us-ascii?Q?8OucnSsugNHsQhMooO4ASO1zDLtsycIp?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4bQTInE5UaQC2ex7hoI9GSLjtbD+7pyZLEDnzuY4qze7iDaNBrRnfV4Pa+Hg?=
 =?us-ascii?Q?NSFp3kqKmab8vyWWDs3hht++xTroWxleHjJPbcbB0jArQJBVUbEteEwrydih?=
 =?us-ascii?Q?YGpYdt55cqGD6ls0yde71jzdME6BQmUMZPCZqnBxqAtzGjvnwkujBA0OA7ZE?=
 =?us-ascii?Q?tP4zvVD2u26B9zJbGJj6gHd/bptpwx3HdCUHXOPwVmf1kKUZh26j9BX/lXyG?=
 =?us-ascii?Q?dD6OvnvPLyn6OHYakPqNTkYsBInxFURMO6tmwnpj4WmPAgZo0BF4oEoARBkA?=
 =?us-ascii?Q?Jw7pLOhdkvUH0YjeOulRk48/F8bDFPk10BVp6ONK6+YmzBqgthasWbClAo0n?=
 =?us-ascii?Q?Jf4EMlpedDQFl/jd5a6cM3ALf6KUAHKxX/sqD3AgCyADyAv+e6o9rgszhrzL?=
 =?us-ascii?Q?1hMGsFDzHxFLmyzmQ8YSsAZAHVX0SxWNIsHR6X9342fhfvIvcG+ESa2Z1ha0?=
 =?us-ascii?Q?N0IY5vSnXOxnP1mAJSU5LyxcOduMyk54IoT1MbzkntMDGPWKwtUP9bqe7xeI?=
 =?us-ascii?Q?cRV5SuugOHI+tX0zMWS/T8NNJDZpzVwcDmf9k3v0A+O1s3/ToRQIKI63Fxew?=
 =?us-ascii?Q?eaWt1bpGyHS8c00M5CJrj3D971ZIvLIAlIKZ2UHo5PDuG0wdxtnbVH1faR7L?=
 =?us-ascii?Q?O7E8PxeN4iQdhi/eyLnvSBonpbzyvPviIj6jEkhD/EOryCHicKXm5HKNsU55?=
 =?us-ascii?Q?GWKWqSTWZoAmS/iPDine+ti1XgWs8toot+WFyBBb8rczVnt7WLeCbu7L77T6?=
 =?us-ascii?Q?JRVMRO48Z3Cp8Wj5oWC5fy0jWX2AGsKcKorvIYnU+F4V8p2pJxpZlnD9tpYZ?=
 =?us-ascii?Q?2LZ76xiF2zDEOvW2nUeeyrwCw4RRceq3gQ7WJYZJnxM1k1gmln6Nbet1SGjV?=
 =?us-ascii?Q?ZZUHWJiGea9p9HVVG28vpQC1haj15VWLoGbNcSl90W3ADsaUjGEhzVTewlt3?=
 =?us-ascii?Q?Q/W1vnvkTjOgzuQA8SmkIFviUXTQ7UFyP+3/nt/K+vBUuGAIGEaMwhWecTCb?=
 =?us-ascii?Q?Ugt1jTAVMAv9jP9BjnlaZCWEtTjTBJAelJ/WBGSg/KiHSacSUDBTVbqmTOzo?=
 =?us-ascii?Q?3o0NNqrALvSTgaG1w8sD3Kbp180pDWHW2pyZUhFVCXKZ8IUV6yOAH9Zub3TV?=
 =?us-ascii?Q?kTl3INhuIsYYGOxgh5HcDgl7i8zGLYDtnpV9qryXcvq6RWD4oR/6w9G1xu7O?=
 =?us-ascii?Q?/gTL6qNL+Vji08/+R38bfYN5UWsCpbeXg+mmghoTRIdZe//EZWMZbPnlMoEg?=
 =?us-ascii?Q?de/HsIB516xMnkSzwa/nnZ9b5QW6OmwYSn8C7NeuJHaGXtzFjc71YXWEnLQ2?=
 =?us-ascii?Q?AeO1WO3IgjQNbgGYvuByxwsEIMwl7WOfaCIrwdJ1fSAhjEaHs9c+5rE8Do34?=
 =?us-ascii?Q?1DAtckQDULjUH5027VpSCagpDd15ELpG+khvvlvotGftQpPGDJcsgJ+It/9N?=
 =?us-ascii?Q?w9EcgqzDFODgJoDxIXfSFOGMqS0vK886t1KMEocecCAbm9V0ayQ1SEE76elG?=
 =?us-ascii?Q?N9binEsvnTUqBp3GL6TyWgeWc9XBP/kAcMAzYuZuwGmUO5iCNhw2iJ2XCiDY?=
 =?us-ascii?Q?NkxSv1N+w+Pygq+Ac1JGTQzh7pXXNAwgUXsnCxNE/xpSU7gU+5VeYaDhAkY6?=
 =?us-ascii?Q?UnsBnsNC/p9QSRaoAcZuWNA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8161ae78-f8f7-4fed-a1e2-08dd70414354
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:46:16.4614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqkA8IkC6lFRSfIsP/4j2wu1o+uxfpzdUG4JjzO9PebHuFGONXaEEk3Bfml+acTdGpI+Z5d4//sj174/suSrw7ktgEhOZaar3+pydRaLiRADIVsPnyka12phlV4+TgqE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9796
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:46:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18403

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 19d4bce9ce876ad0ee4240ebd849b730b3dc3763 upstream.

Add support to configure bias-disable, bias-pull-up, and bias-pull-down
properties of the pin.

Two new function pointers, hw_to_bias_param() and bias_param_to_hw(),
are introduced in the struct rzg2l_pinctrl_data to configure bias
settings, as the values in the PUPD register differ when compared to the
RZ/G2L family and the RZ/V2H(P) SoC.

Value | RZ/G2L        | RZ/V2H
---------------------------------
00b:  | Bias Disabled | Pull up/down disabled
01b:  | Pull-up       | Pull up/down disabled
10b:  | Pull-down     | Pull-down
11b:  | Prohibited    | Pull-up

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240530173857.164073-12-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 72 +++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 596e101f5b2d4..33c96661092bf 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -128,6 +128,7 @@
 #define IOLH(off)		(0x1000 + (off) * 8)
 #define SR(off)			(0x1400 + (off) * 8)
 #define IEN(off)		(0x1800 + (off) * 8)
+#define PUPD(off)		(0x1C00 + (off) * 8)
 #define ISEL(off)		(0x2C00 + (off) * 8)
 #define SD_CH(off, ch)		((off) + (ch) * 4)
 #define ETH_POC(off, ch)	((off) + (ch) * 4)
@@ -146,6 +147,7 @@
 #define IEN_MASK		0x01
 #define IOLH_MASK		0x03
 #define SR_MASK			0x01
+#define PUPD_MASK		0x03
=20
 #define PM_INPUT		0x1
 #define PM_OUTPUT		0x2
@@ -258,6 +260,8 @@ struct rzg2l_pinctrl_data {
 	void (*pmc_writeb)(struct rzg2l_pinctrl *pctrl, u8 val, u16 offset);
 	u32 (*oen_read)(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pin=
);
 	int (*oen_write)(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pi=
n, u8 oen);
+	int (*hw_to_bias_param)(unsigned int val);
+	int (*bias_param_to_hw)(enum pin_config_param param);
 };
=20
 /**
@@ -1000,6 +1004,38 @@ static int rzg2l_write_oen(struct rzg2l_pinctrl *pct=
rl, u32 caps, u32 offset, u8
 	return 0;
 }
=20
+static int rzg2l_hw_to_bias_param(unsigned int bias)
+{
+	switch (bias) {
+	case 0:
+		return PIN_CONFIG_BIAS_DISABLE;
+	case 1:
+		return PIN_CONFIG_BIAS_PULL_UP;
+	case 2:
+		return PIN_CONFIG_BIAS_PULL_DOWN;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int rzg2l_bias_param_to_hw(enum pin_config_param param)
+{
+	switch (param) {
+	case PIN_CONFIG_BIAS_DISABLE:
+		return 0;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		return 1;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		return 2;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
 static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 				     unsigned int _pin,
 				     unsigned long *config)
@@ -1058,6 +1094,23 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_=
dev *pctldev,
 		arg =3D rzg2l_read_pin_config(pctrl, SR(off), bit, SR_MASK);
 		break;
=20
+	case PIN_CONFIG_BIAS_DISABLE:
+	case PIN_CONFIG_BIAS_PULL_UP:
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		if (!(cfg & PIN_CFG_PUPD))
+			return -EINVAL;
+
+		arg =3D rzg2l_read_pin_config(pctrl, PUPD(off), bit, PUPD_MASK);
+		ret =3D pctrl->data->hw_to_bias_param(arg);
+		if (ret < 0)
+			return ret;
+
+		if (ret !=3D param)
+			return -EINVAL;
+		/* for PIN_CONFIG_BIAS_PULL_UP/DOWN when enabled we just return 1 */
+		arg =3D 1;
+		break;
+
 	case PIN_CONFIG_DRIVE_STRENGTH: {
 		unsigned int index;
=20
@@ -1173,6 +1226,19 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_=
dev *pctldev,
 			rzg2l_rmw_pin_config(pctrl, SR(off), bit, SR_MASK, arg);
 			break;
=20
+		case PIN_CONFIG_BIAS_DISABLE:
+		case PIN_CONFIG_BIAS_PULL_UP:
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+			if (!(cfg & PIN_CFG_PUPD))
+				return -EINVAL;
+
+			ret =3D pctrl->data->bias_param_to_hw(param);
+			if (ret < 0)
+				return ret;
+
+			rzg2l_rmw_pin_config(pctrl, PUPD(off), bit, PUPD_MASK, ret);
+			break;
+
 		case PIN_CONFIG_DRIVE_STRENGTH:
 			arg =3D pinconf_to_config_argument(_configs[i]);
=20
@@ -2645,6 +2711,8 @@ static struct rzg2l_pinctrl_data r9a07g043_data =3D {
 	.pmc_writeb =3D &rzg2l_pmc_writeb,
 	.oen_read =3D &rzg2l_read_oen,
 	.oen_write =3D &rzg2l_write_oen,
+	.hw_to_bias_param =3D &rzg2l_hw_to_bias_param,
+	.bias_param_to_hw =3D &rzg2l_bias_param_to_hw,
 };
=20
 static struct rzg2l_pinctrl_data r9a07g044_data =3D {
@@ -2660,6 +2728,8 @@ static struct rzg2l_pinctrl_data r9a07g044_data =3D {
 	.pmc_writeb =3D &rzg2l_pmc_writeb,
 	.oen_read =3D &rzg2l_read_oen,
 	.oen_write =3D &rzg2l_write_oen,
+	.hw_to_bias_param =3D &rzg2l_hw_to_bias_param,
+	.bias_param_to_hw =3D &rzg2l_bias_param_to_hw,
 };
=20
 static struct rzg2l_pinctrl_data r9a08g045_data =3D {
@@ -2674,6 +2744,8 @@ static struct rzg2l_pinctrl_data r9a08g045_data =3D {
 	.pmc_writeb =3D &rzg2l_pmc_writeb,
 	.oen_read =3D &rzg2l_read_oen,
 	.oen_write =3D &rzg2l_write_oen,
+	.hw_to_bias_param =3D &rzg2l_hw_to_bias_param,
+	.bias_param_to_hw =3D &rzg2l_bias_param_to_hw,
 };
=20
 static const struct of_device_id rzg2l_pinctrl_of_table[] =3D {
--=20
2.43.0


