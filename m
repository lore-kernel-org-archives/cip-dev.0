Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F27C3600B
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:46:01 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.14])
 by mx.groups.io with SMTP id smtpd.web10.49052.1743417960564487065
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:46:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Dr/ZrypO;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.14, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fy5D7SKnk/iyOoPLmVvRTRcWjPT23w+XxjHiS4g1nwgDL9mzJLp26d/N0bwWJSaNPwLvF1/Gg6R7oFZM0NFyOhXx+VAeK1wXSXYz1ckBc6HVO5RpFqtV7kH33QMR99gOG4T32JI4VdF4iG+a6M8fLkAk8vhtoWFH3xI4fztXKH/+yUIaktc7V+wPzepJAJajkkkp/kU/S/Ref4fZQWjBKL6+FYXQibJ5JTp5RJrymOIgcSHHqL9DrSTE2zrOI1Jlu1s4b8RtfuCgw0qBKXK/jH9gFeAdr2ThmuP2Q+4KRVq4Po8kbXgR1mrsuSEmeoDosDrNfmfC7Tkta/MDCwwIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFicCzmJs8mrRo3iByyT7L2GzUWBiK3CGQTf7uQZRRc=;
 b=iklP5FEh7LNbImzLkg7blG0Ls9xSNAe0jOEeFMvd072h50aEz1aOWaVUJGaAzdW0XpkZKIhRnsue/hF6oxRFByLL+N5paQI793bfBu7TEULiBgmlgZ1Sq02DhyQYw2GVrjMsvQnQqUvEe+cWxoE8YVBDXaX6fhQf+yvKnehcZiGsB7awwbmwugWYMhOcbB1vWm9NIK9nQMpVDx8lFKJF+0pQxIiuUu4MyckmXyHTGE9gstv7GbGYGtlcy/4ekfutjKkezjLI48k7JOwQdbsFZPemgcCYFCOBzr7/8048cnLwq7UMOQELmtXxPYMiw+O1Whs5cgIBOPI/nQZVkz/WtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFicCzmJs8mrRo3iByyT7L2GzUWBiK3CGQTf7uQZRRc=;
 b=Dr/ZrypORza6DuHPWfEeXRwngpoV7m1MjJR9q/bkakM5ujxKQI0eDwZmCmnkMg1aBFGs7ZMNlr7i2drJrQUjSU+u0HzwlFzxl4am0MBOKI+M+WiovughzLTZJBZxyeV89QdZ63xIJxvI1p7aAwExkW+erLp2ynBNVK2m7J0PCvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYCPR01MB9796.jpnprd01.prod.outlook.com (2603:1096:400:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 10:45:58 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:45:58 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 09/43] pinctrl: renesas: rzg2l: Enable variable configuration for all
Date: Mon, 31 Mar 2025 12:44:40 +0200
Message-ID: <20250331104514.79090-10-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4c09e864-1db9-4652-ec34-08dd7041388e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?IL0W9u37MYIZ6XMND8H6M6lqIXWeIpJ+4PkusEUTl9cyMvMulBmK3UcctC8K?=
 =?us-ascii?Q?2d/txMtZEAqR62hTW2eooqpf6+aoP8TjjXrfuFe+HSJmtETeEhtwswCGhSg7?=
 =?us-ascii?Q?SKFEaI+MCl87CEx6xYoB16gtFSQ7zCt9zhOc/bn14aalBFNqXb9eZCXW6jj+?=
 =?us-ascii?Q?NokHo+5GL9QlwqBl3X389hcNGZvf1jYrDGqYn3BRCfjVLKfHzgf41BA2rbRo?=
 =?us-ascii?Q?NZawzk1JvGOxuTfUfvN9iIsDQcAqivhlW1RAtOoG9u0TslIYxu1Pq06Lrhef?=
 =?us-ascii?Q?A1+oBaL2q1YTaEOzimeq0dY3FHWzCmkVws11kJIsCaYyYJlSYkElGVLmK59P?=
 =?us-ascii?Q?Mc8FWg+xh9LIrt4DmegUWMsuRZhTcRCF6OjbkuHmrnfFJkDlkWrL8aQbRhyN?=
 =?us-ascii?Q?hlYabttxxBONAWy3MLD1CYpKIJlcatbljhVGCRZhUYSrWk51fyUa8zs1Lb62?=
 =?us-ascii?Q?fJahg5cbJrWQikL/jJtKhdzuYc7ykZzPBfTuwa4vHdIY4/e4YUpxMWtsTFPS?=
 =?us-ascii?Q?laiPKEm1S+A4JSBiFPoB3MmO9vxsH/AsQP8LCjWTiQHsPmkxhGSo3rAudtii?=
 =?us-ascii?Q?1iUuZa6yNU9OgMk5Eyrd+cnoRvf+pEKLMqWYoNq0/FWB8VQ9pGflVEOqL2gT?=
 =?us-ascii?Q?DIyinly5dCwL0qq9Q3c++ZurPSp4sVhRT9dW3aLf5jWuJORcgqxjK/STkKDk?=
 =?us-ascii?Q?cdPveo91rVIleu/4FM41T5bz9NCP7+4tioNv6vjnYUrvM1J28A6dfnXhcBOw?=
 =?us-ascii?Q?JTnDDIJPHvnz0VwyZhVG2kl9dFtYP8RZyea4cYTWxiycPPX38RD3A4sfmdb2?=
 =?us-ascii?Q?JDFLKaO1ErgQQUwB8CAw1Qyc5GTZpk5+Kj6y4GaFiNHVtmYVOAMOYB9Phl3U?=
 =?us-ascii?Q?GVR8P06/dqLu46x4IE/R8kx+8JBhWR/Wk+EZcNjCg5xBMFzBpAMOqwTL+TRo?=
 =?us-ascii?Q?b0WoLH5mV4RVTJToIWtykS35IWQKFSLtOQ4GaoP0t5STFDccUIwv1QsIJASx?=
 =?us-ascii?Q?oJWUNizhYt3s954HvBeJJgj2PMrA8UpY7rvBFCN47aPNjzvofzCPndx8ccqx?=
 =?us-ascii?Q?xgb6TjBQcScHgXa2hT4QyTy5AHUkv9vsbTpMBu7WjtjPW/BysAVtSIEFudlL?=
 =?us-ascii?Q?OLAck2a6JgEydp9nHRjmpACVkd/B03N752NfLD5FJsNvMYN/aTs25ZoKpvHY?=
 =?us-ascii?Q?QLNQuUP6aX0K+ZrtIC426et6e+nj0z97LuF8LknrCmfb7avhXaNw40OM0HHP?=
 =?us-ascii?Q?pJRUjYpFmR39RLNQpi0sf5YoV3zAVLArmxNkOh0QUqnZ///cWJFYNdCwITdu?=
 =?us-ascii?Q?jdtAnkiyZIBBnix3J/vbXZKC9Xgc0i8bxFWbV/2qpVTu6ztLr8k7QlJuW14B?=
 =?us-ascii?Q?msduIlXbLH1xA4GibKag888M0x4R5p4CZNzRDUpBlvcqzcr4f/Kr1Yf/1T6f?=
 =?us-ascii?Q?fHrE9Vn21YOVR5s2S8gUfK4qylib1C5R?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BXe/J6SwYftlIJToA1pZCM2LsVGQlkniIReh9sj80DCVMDVK/9pAAXHe/dAk?=
 =?us-ascii?Q?kbeVZZNmxL6AG3gr40C5mYVNtXWOgCH6YaeRUE/KHirJH3M0BCU/Kus+u7h4?=
 =?us-ascii?Q?2stjndpEeMlST9rLn9jAgtFSd7Qf7eEsG2OT77m38EbqP3Is1O4fQ+3bSxjY?=
 =?us-ascii?Q?RjhhYaLUC5ouIeKyLjNCKetPY/kB9d7c+dgCcrN/koUlK+TjVmE1XOlvyyFb?=
 =?us-ascii?Q?ArST2cELCibqfcyj2UyEnOs87A/LsPz/A8UZPXzLAOD1Yb2xV1TToOiVpajY?=
 =?us-ascii?Q?SWDjSh6/hgTi+5CWl3TKN3cUkG9K/NuzOBD5DM64sEtpxCWKjHlScL6cJ+aa?=
 =?us-ascii?Q?ylQWn0Aw9XhFqCXscx5r6D9syC103HVPSN07mMGsi7ZK03levihkeK2Q2FZ/?=
 =?us-ascii?Q?DQ4He5FqxqBzQWj1TELaaEmkzx3+beKnPsIdpbhzmfBkoz3w4xm5Cnvv+Sil?=
 =?us-ascii?Q?wEuJsa13IDVh/q8alxiIPnNxdiZmjxFVU84sQy3YlxNJILMKfMTf5/cFG0lH?=
 =?us-ascii?Q?Gy7RW+K+9+FG6u1s+Z7TXv2N2cCNu+E0v/FN4cbnC/yoGAGY5KeKuLWiagv9?=
 =?us-ascii?Q?bZAYjUgnMQ4YzbTjzOcfUFwM1iUDIsX+U2cA+tALF3GxzI7nAv5HyNpNOXhN?=
 =?us-ascii?Q?cT17p5NfcPOEwweNXZU4dskmux/S9SKK8bkeoqVYd1S0Osdq4aFbt8+HqK23?=
 =?us-ascii?Q?bPsikyE9mJazdLPrrstCzju5rfLyHVQ8mCuyJ0aazQhMmk+ww2thp5TUzxIv?=
 =?us-ascii?Q?qLDdnUyjOM+txHwAkBbtU2dPdT6EJESzYTfFsraik8O7KtMNt0OzAzgFWoB/?=
 =?us-ascii?Q?dDGUYK0ccz152X/NrbHhDgya13PSVmNUOPLVFZdqT8JyXcSzaKq200xa+fVo?=
 =?us-ascii?Q?dI03JXnYNZHkLkqXZRKD3zFHPSinO5lnwvVtPYUoMw/8bPGwrpPdTj4sgloM?=
 =?us-ascii?Q?01Y0Ci91q9pqrk2Nad4PDr1ibryQN5EDS3nyTEfT7JDyvMz5SqXY0kEPVvio?=
 =?us-ascii?Q?E5dAqGtBYk8TGHpm8FvDjiM7LsSgXHH58c77GgWXYgg35dV9Jr3rxHBk5eOj?=
 =?us-ascii?Q?xIXt2pNBF15bDs4tgPFqjr+Wv2AhD22co+7Db5oEAzQodwdbtNa6vojqsDH7?=
 =?us-ascii?Q?QBI0SXRB2FV++nq1R9fSFKSyE0qnEOmtc20NGWLUrPU03fGVuNr9QjwC8Spy?=
 =?us-ascii?Q?SRkCxp6x/p39NVS2sWtndH4EKdYhD7o+ucrzLFmpQ/bhDcOjmulJkSDwzTwY?=
 =?us-ascii?Q?2sm/GabhT+Qr9QpHwNL4hXJ17QF40waj9qrrQnfCEK7X4mHLdoxwCMspbaBs?=
 =?us-ascii?Q?ASYFaFahRcCHpz2uPQnm6JHAF8gwGCgXasNMoFW0lmFsstl8mQxZxXqlHTQ/?=
 =?us-ascii?Q?b4donMEd9SBZzu1ZviunS4sF8JtaQuN8MH5uZh+OUis0wb3xgDcjJWG+lpva?=
 =?us-ascii?Q?E5HK1f0aagEzav9oHdH+IYsyJTnVvlVGISufGgleXd3xJ5d+lvl334bEApfO?=
 =?us-ascii?Q?MGblMKeW3AgaZx+V7m/rN/1AbgXuN3t5XdKp86X3Kk1QS2EOhdrxkUhZTytQ?=
 =?us-ascii?Q?n9mQQ3U+zskZvmccNLMRRhyXvnayxsIqytV5ZnWh1W573THWi0XUXs6jsTk8?=
 =?us-ascii?Q?H0/OU/86Z2vwbQuoJscY2HA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c09e864-1db9-4652-ec34-08dd7041388e
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:45:58.4229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgnk4N5jKNavSuwwuh96NlBDIYIit1s17MKiMFb3MaALtpyBNrPiB0nLF0vjzgyVZvIgPyrkrHwl62a3M1zmxLvjwPIRMzTIU3VzKqnduQyvT1fsr+Z+AimMCSDJF6+o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9796
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:46:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18397

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 08b68ae5a0276f293c8da602f963f6de68b3599b upstream.

Enable parsing of variable configuration for all architectures. This
prepares for adding support for the RZ/V2H SoC, which utilizes the ARM64
architecture and features port pins with variable configuration.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Link: https://lore.kernel.org/r/20240530173857.164073-6-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 24eb4a375ce5f..0d3ffd7617625 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -316,7 +316,6 @@ struct rzg2l_pinctrl {
=20
 static const u16 available_ps[] =3D { 1800, 2500, 3300 };
=20
-#ifdef CONFIG_RISCV
 static u64 rzg2l_pinctrl_get_variable_pin_cfg(struct rzg2l_pinctrl *pctrl,
 					      u64 pincfg,
 					      unsigned int port,
@@ -335,6 +334,7 @@ static u64 rzg2l_pinctrl_get_variable_pin_cfg(struct rz=
g2l_pinctrl *pctrl,
 	return 0;
 }
=20
+#ifdef CONFIG_RISCV
 static const u64 r9a07g043f_variable_pin_cfg[] =3D {
 	RZG2L_VARIABLE_PIN_CFG_PACK(20, 0, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
 					   PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
@@ -2219,13 +2219,11 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinc=
trl *pctrl)
 		if (i && !(i % RZG2L_PINS_PER_PORT))
 			j++;
 		pin_data[i] =3D pctrl->data->port_pin_configs[j];
-#ifdef CONFIG_RISCV
 		if (pin_data[i] & PIN_CFG_VARIABLE)
 			pin_data[i] =3D rzg2l_pinctrl_get_variable_pin_cfg(pctrl,
 									 pin_data[i],
 									 j,
 									 i % RZG2L_PINS_PER_PORT);
-#endif
 		pins[i].drv_data =3D &pin_data[i];
 	}
=20
--=20
2.43.0


