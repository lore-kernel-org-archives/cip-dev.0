Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234C5C36009
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:16 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.33])
 by mx.groups.io with SMTP id smtpd.web10.34479.1741778777114479858
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:26:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=f8BQIEYA;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.33, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8o5cPpjaeKXYLscEpEEJUKVgWjhwyoUQC0banHHdu/LHfHsEbEgkAW3eSDub2LNBy0XQqR6qQKR3JA177Xs72mXsLGhwlZ63mDxnweTZMjH5oD/WRITr/1bhkdbNfd98nHOCJr8kHQBec/2AjtHnm51CcHknsYE6SWeCJYgqmPwhxPpIgbWMRQiivwjUmFaWR6IPDsfVzUaJDT2rKbsUpTcSsAq+rPlTPE+HFm1b0fUlNz6V2cJDNOtfHH0iet01T04RUGB+PwPKcrswELVuAKhN9i9JYkKfmg6lHyWIT99s6nWHBJpyBW+g5ah9S8cDGak9poPBWrxD8PMhRGdBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZzKcWeO00J9pdOxs0xYOU398mP9qWhUK5RWJ+/V7+Y=;
 b=yH6jTqgvti+YiiLyQGUJbGfRpVjwK9S3Sa+1f8HjVf3Am+5fsGyyjN9FPz/Mp9dc/U4RtXODAXTITiQSc5iQDQ0E4C0Il2taisCM94rhZMeRFNCwEhjdDh+8Wxkoem2ShBdPMrrZhKsMXVjOWiOgN/tcef/eYJNv1+eWEwQUVwqQv+4dO3Ot14kSsCGp+HRroFjbUvSnT0l7pUAkuZSjm2ek0q8qiN4xdtG1FRyjrjjh8LMElCr71csa/KYxBK1/+jHR5As4mS2a4KJ/Gxa5CzNsL9r17YNBe/S1/v5UCBIqPNEWNBKxSQxLwPd40XW0kUUpayneIq0pwBEfpVCY5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZzKcWeO00J9pdOxs0xYOU398mP9qWhUK5RWJ+/V7+Y=;
 b=f8BQIEYAqfSNrboWQnptAuO47hbWPm1bWoay06P8uzufQc8SJK1S2v17p8iPTyiNhMM93lj3pqorZ+Qz33VW8kAqXM2TTxBEacTXiL/zQcelQ/+/N45lbR2UXnZTvBUyor+Q0/6w4rB6pQ0dayNGQKSSnczlCrTUUT+X5HVNzS4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYWPR01MB10982.jpnprd01.prod.outlook.com (2603:1096:400:397::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:26:15 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:26:15 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 54/85] pinctrl: renesas: rzg2l: Introduce single macro for digital noise filter configuration
Date: Wed, 12 Mar 2025 12:22:31 +0100
Message-ID: <20250312112302.1605750-55-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYWPR01MB10982:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d45f0d-7652-4710-34a3-08dd6158b332
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?JOYTjyZ10n43WjqAUmPrqSaAJL9aJ/SO1Z2vr2f4MI6WZslh/45iGUAVLSOs?=
 =?us-ascii?Q?zhBBPsUGTzTteIbzBNQPpf6b22GXodYsYNY4OmHoL4iOeLXVxwXvJy7Ac8KU?=
 =?us-ascii?Q?TxPWxhqH1i22TkR8QbepZ8XqssFLLDvE7Eurq+I52wnMSDkhAN9094XqKBcY?=
 =?us-ascii?Q?k6oedd8OuIvKKzmjZpf5VynUocYgq+1VpPJ99FotimST9NoPhf2flQkQOvQH?=
 =?us-ascii?Q?rktzWnPSMHpo07tgvENtb8fhFBpITwyUicAs2oWg5BTSPotETCHV8+unpUSw?=
 =?us-ascii?Q?e2lBYxbpifLiGd3ZvfRbbKOjZ+OnarWKaPI1Gd9XaVgNw1ugoKoNigF1jqIY?=
 =?us-ascii?Q?2MyOnUOZg9M4KxxrChRVC2mUYJHXigy3VkGAP58vpv7ycTt6mw2g4rGoGoZ7?=
 =?us-ascii?Q?usJo9ekhkWLRiW8dVw6CMY2le7KocFMx1TGv/tKRZldzMVWlf57OqVqgFI5g?=
 =?us-ascii?Q?QK+6PNC3DT4ZVx7jqA0tCOGQl25BZAHXSw6oOWSr8V47OMiFRYUEQAa9YIWp?=
 =?us-ascii?Q?BPmESHqNotz3krFVySxts26ezlUvNuw0aFKUdaHdP6gvfg590JHWVlHFiVLN?=
 =?us-ascii?Q?LGu8fP2FcRfqOaq1mPvbbFA4ES/uYxDT5hkR09F4iy2pOSKsQj7zoVjR5R6Z?=
 =?us-ascii?Q?GF8yhU1FT6d2NV5TYnEQADUNc+85bDIWOtH7Vnl1q7505N3RKmxLxzX3VRRi?=
 =?us-ascii?Q?roSGYO5/FQ3aDbHaVvSay2J7SSxyRrkhGLBZM++ackPkjzsjWDRXFHRAWppP?=
 =?us-ascii?Q?0OFBaedlSBmwHNSyiTiVy+HNp3osowFEwYdxxtmnSPqPur6K+y1gHW8ab6zr?=
 =?us-ascii?Q?ulG6s2pdQ/PuTcwIPJjO+eAvwj0siHlm7mS5D9jXyQFBwrFT/jhR6qaTftWF?=
 =?us-ascii?Q?T/63X/4YC5ge/Xq7YfcdbOL7DySsF5fkWCEFaXONWvF0dEx/buPbTAXQ7hsp?=
 =?us-ascii?Q?zeVmMnmS1KJ758IyXKu+p57Yg8J2hONjQo/PT86SltC6EEpyoimjmM4VIMl0?=
 =?us-ascii?Q?tzF69252uIc0VbejE6iNfqDXeCI7wNEnOCRnzjaqXgjgSGdX7yfCgReDLjbr?=
 =?us-ascii?Q?A/2/P7AGmHrUyt0H/1FOZWuqzeq0EjEihxFVZuZTRcp3Nmx0xwpjm7paliLf?=
 =?us-ascii?Q?ZLjxCVqsEXCo+GfxbEL2BsF0BMGN8SigsVY7kW4v8nlwXrm2xqPv5Ml7riVc?=
 =?us-ascii?Q?53BnYtTSWrKXGnNp8fJGjXFJMo/kFjpSt9CJx40eSld/OkgU1HLs9wqZPaLy?=
 =?us-ascii?Q?rp2MYAwMMe12GC7J4m4xNlpMrXam4WhYSlJj3K87VfYddO1x1DNNe+0b/nGu?=
 =?us-ascii?Q?L9UDVfhDDyXE1R/fgO8lgsoGKSmntsuMD6ALcC/QFaud1EzJgTg9+vzcr7ey?=
 =?us-ascii?Q?ji2CHBkv8aHS8WQGrgj0S5X1YL85aLSNNwema3fy04PRez0Z7oLMq9WbeNA8?=
 =?us-ascii?Q?zNWdbTexW/Ptf0cP0QDY2e3uHDrLgVms?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5LvOYpP6Wlmb8j+HysuqCsgBkSoPPueJaDz1oA07k9rYOH+WCRJOl6o5R5FE?=
 =?us-ascii?Q?7pesLqKzEkfEuip/Imuh/5A8I6BqxiVcZ/CXX1pX9BD0Cwyo40KPXJJstZ2m?=
 =?us-ascii?Q?uwnAaDmJDT+cBmPXh2aHZXh4b1aWbdOA/CUpFFTthzQSW6TDwULM5zin3Bnv?=
 =?us-ascii?Q?9PMktl44K6LyWSYO7jgxrf4WbCUdGWkidROBPNit+TcL8WO+Vrdm1wR0vYx7?=
 =?us-ascii?Q?89fi7V4ONE/vM6YSMzWygj9+lEve7jvc9VoFC4ua4wCs5javEBzWb04Jtln4?=
 =?us-ascii?Q?0q0dmBz4fAoKtlXkqHzvjEd9RA9ADTUGYnrHU9qPhrATSZMpiwS99aWdfapx?=
 =?us-ascii?Q?FpfBbkUitm0sKkKZNnWY7x5IWl+GAB7eCuNEi4XT0JrQS9f8S5wPIC9Hk7kq?=
 =?us-ascii?Q?aEwZ8PUWSNVjmgrAEnFfLvWdBTD+6DQhHdn85bY8n+7Vnih5p628VKlZogdq?=
 =?us-ascii?Q?9+0992fG4yQloTQ1xzu3KJZvc7xYVxFXONU+KO3WHlmH2YW+Lvl5z2gbaIO6?=
 =?us-ascii?Q?z3i2/TWDB0J792vMPTeJLcBesU8KOyoEKMF4lZr3t7PByLREqlgOleBJg8VG?=
 =?us-ascii?Q?UGpeZuAufElZSZzfA177k4X0hPaT34k7wuH/Rud0b1puVzQhuErpIAKdbsPy?=
 =?us-ascii?Q?daolyMZSsGZygMC4MTsV6Ly4Zp0KBDsluhSROG6aFpzAOebR7KVocxZAE0+B?=
 =?us-ascii?Q?kwcKgKPyrQktqpM8OJuqIfhubIpcMCDfeBp3XkSqahIm5HeHMQWhsgTwhEle?=
 =?us-ascii?Q?LX5Y9sGmV2cFAulfOJV3b6UkRaed21/p1RSwTxvNllGs/btJ0qZGCwd5Yeog?=
 =?us-ascii?Q?oL5tWeupe5t/XlpWyua+mdwT/1yQTqwhP37RsmMhH06DIMFYVunbfNzTbRkJ?=
 =?us-ascii?Q?5icqqc0v76uLwYbUjOpMCV9O1wSmgydozCrQBWmR3epd/X2/0JbB21aofGxW?=
 =?us-ascii?Q?g+SEkjDD55yR3MH+EbljCakzQcjUHFXyqASE/jMUSKG9n/i59lfhIl7WTS5Z?=
 =?us-ascii?Q?03ZfOuvSIx/2ew78y/PBONmWNzf+re1Zk+QVHVbcML1c6rzvhCLfmABqYQRA?=
 =?us-ascii?Q?3wzWgvyd8JjwLVdshbm6tdMb64sA+asYuLAELnlQbN2Ixb+hJn+PF4EvB7VS?=
 =?us-ascii?Q?nQx4+LIADPlYWurhjl48BxUFHNazmr0Z9TETACWyF63+PvBZLc37p8efnlFo?=
 =?us-ascii?Q?KeBa2RkOUMYoyajtPrneo7MFHBAuMlHGExP6PqtqQrkL+EQvVIYaPXySmt7o?=
 =?us-ascii?Q?vKtSeXidRKdBUyEoHoGdCfLctZklG27VXjOWY6f5BqoiGhH1tIICyk5idqZu?=
 =?us-ascii?Q?OtIs7xVddfGMS3OPYOLkjKnpGSvou9MgO5dkAD2Q7+I9TsKNQlpKV48tKdFa?=
 =?us-ascii?Q?hLG7BdihsIfBW1y2GVl6iNcuNPId+0tI9Arr1VmsWIE+FikNpJJEoE8pyxM0?=
 =?us-ascii?Q?PZsiUfGyS5GXIUF+lYAuLU1h4qBgSSQdHJzdOA19xD0dtX1R77ANahU822zj?=
 =?us-ascii?Q?kXf2D0qpkXETwpYwL5Vk2QMts7XCta+ZHMbKraIQ3kP122Ijrsl0TjSQ/Fj5?=
 =?us-ascii?Q?hoE1M+WSkxBvgOQbkbJz1ibdfo/dcu0htKnGRzazgg+1snRLjBJGJbrdMM8v?=
 =?us-ascii?Q?oEbnfJ1O9LjIb+/4JSSi4BA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d45f0d-7652-4710-34a3-08dd6158b332
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:26:15.1351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8L+q4VHo2HZ77btV2uCz5dthNy57SfS1sSw0NCAgQ8RD61VAsIIp6Smsxu9mR/0wb5VpoJJk2WnYVQMrcuxAqJzdYpA5LX6FjEmMXBzjuOTSR+68jWtoYf1VHcrGa/+V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10982
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18146

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit befcded23454825ca2cc4c24626b68c75fcb1528 upstream.

Support for enabling the digital noise filter, and support for
configuring the noise filter stages (via the FILNUM register) and the
sampling interval (via the FILCLKSEL register) are related: a pin
supports either all or none of them. Hence simplify declaring digital
noise filter support for a pin by using a single feature flag instead of
three separate flags.

This patch removes the PIN_CFG_FILNUM and PIN_CFG_FILCLKSEL configuration
macros and renames PIN_CFG_FILONOFF to PIN_CFG_NF.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240829194841.84398-2-prabhakar.mahadev-lad.=
rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 52 ++++++++++---------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index bd739879055a..d5249955c9a4 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -51,17 +51,15 @@
 #define PIN_CFG_IO_VMC_QSPI		BIT(7)
 #define PIN_CFG_IO_VMC_ETH0		BIT(8)
 #define PIN_CFG_IO_VMC_ETH1		BIT(9)
-#define PIN_CFG_FILONOFF		BIT(10)
-#define PIN_CFG_FILNUM			BIT(11)
-#define PIN_CFG_FILCLKSEL		BIT(12)
-#define PIN_CFG_IOLH_C			BIT(13)
-#define PIN_CFG_SOFT_PS			BIT(14)
-#define PIN_CFG_OEN			BIT(15)
-#define PIN_CFG_NOGPIO_INT		BIT(16)
-#define PIN_CFG_NOD			BIT(17)	/* N-ch Open Drain */
-#define PIN_CFG_SMT			BIT(18)	/* Schmitt-trigger input control */
-#define PIN_CFG_ELC			BIT(19)
-#define PIN_CFG_IOLH_RZV2H		BIT(20)
+#define PIN_CFG_NF			BIT(10)	/* Digital noise filter */
+#define PIN_CFG_IOLH_C			BIT(11)
+#define PIN_CFG_SOFT_PS			BIT(12)
+#define PIN_CFG_OEN			BIT(13)
+#define PIN_CFG_NOGPIO_INT		BIT(14)
+#define PIN_CFG_NOD			BIT(15)	/* N-ch Open Drain */
+#define PIN_CFG_SMT			BIT(16)	/* Schmitt-trigger input control */
+#define PIN_CFG_ELC			BIT(17)
+#define PIN_CFG_IOLH_RZV2H		BIT(18)
=20
 #define RZG2L_SINGLE_PIN		BIT_ULL(63)	/* Dedicated pin */
 #define RZG2L_VARIABLE_CFG		BIT_ULL(62)	/* Variable cfg for port pins */
@@ -69,9 +67,7 @@
 #define RZG2L_MPXED_COMMON_PIN_FUNCS(group) \
 					(PIN_CFG_IOLH_##group | \
 					 PIN_CFG_PUPD | \
-					 PIN_CFG_FILONOFF | \
-					 PIN_CFG_FILNUM | \
-					 PIN_CFG_FILCLKSEL)
+					 PIN_CFG_NF)
=20
 #define RZG2L_MPXED_PIN_FUNCS		(RZG2L_MPXED_COMMON_PIN_FUNCS(A) | \
 					 PIN_CFG_SR)
@@ -84,10 +80,7 @@
 					 PIN_CFG_SR | \
 					 PIN_CFG_SMT)
=20
-#define RZG2L_MPXED_ETH_PIN_FUNCS(x)	((x) | \
-					 PIN_CFG_FILONOFF | \
-					 PIN_CFG_FILNUM | \
-					 PIN_CFG_FILCLKSEL)
+#define RZG2L_MPXED_ETH_PIN_FUNCS(x)	((x) | PIN_CFG_NF)
=20
 #define PIN_CFG_PIN_MAP_MASK		GENMASK_ULL(61, 54)
 #define PIN_CFG_PIN_REG_MASK		GENMASK_ULL(53, 46)
@@ -394,13 +387,13 @@ static const u64 r9a09g057_variable_pin_cfg[] =3D {
 #ifdef CONFIG_RISCV
 static const u64 r9a07g043f_variable_pin_cfg[] =3D {
 	RZG2L_VARIABLE_PIN_CFG_PACK(20, 0, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
-					   PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
+					   PIN_CFG_NF |
 					   PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),
 	RZG2L_VARIABLE_PIN_CFG_PACK(20, 1, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
-					   PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
+					   PIN_CFG_NF |
 					   PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),
 	RZG2L_VARIABLE_PIN_CFG_PACK(20, 2, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
-					   PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
+					   PIN_CFG_NF |
 					   PIN_CFG_IEN  | PIN_CFG_NOGPIO_INT),
 	RZG2L_VARIABLE_PIN_CFG_PACK(20, 3, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
 					   PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),
@@ -431,7 +424,7 @@ static const u64 r9a07g043f_variable_pin_cfg[] =3D {
 	RZG2L_VARIABLE_PIN_CFG_PACK(24, 4, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
 					   PIN_CFG_NOGPIO_INT),
 	RZG2L_VARIABLE_PIN_CFG_PACK(24, 5, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
-					   PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
+					   PIN_CFG_NF |
 					   PIN_CFG_NOGPIO_INT),
 };
 #endif
@@ -1887,8 +1880,7 @@ static const u64 r9a07g043_gpio_configs[] =3D {
 #ifdef CONFIG_RISCV
 	/* Below additional port pins (P19 - P28) are exclusively available on RZ=
/Five SoC only */
 	RZG2L_GPIO_PORT_SPARSE_PACK(0x2, 0x06, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_=
CFG_PUPD |
-				    PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
-				    PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),			/* P19 */
+				    PIN_CFG_NF | PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),	/* P19 */
 	RZG2L_GPIO_PORT_PACK_VARIABLE(8, 0x07),						/* P20 */
 	RZG2L_GPIO_PORT_SPARSE_PACK(0x2, 0x08, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_=
CFG_PUPD |
 				    PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),			/* P21 */
@@ -1896,8 +1888,7 @@ static const u64 r9a07g043_gpio_configs[] =3D {
 			     PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),				/* P22 */
 	RZG2L_GPIO_PORT_SPARSE_PACK_VARIABLE(0x3e, 0x0a),				/* P23 */
 	RZG2L_GPIO_PORT_PACK_VARIABLE(6, 0x0b),						/* P24 */
-	RZG2L_GPIO_PORT_SPARSE_PACK(0x2, 0x0c, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_=
CFG_FILONOFF |
-				    PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
+	RZG2L_GPIO_PORT_SPARSE_PACK(0x2, 0x0c, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_=
CFG_NF |
 				    PIN_CFG_NOGPIO_INT),				/* P25 */
 	0x0,										/* P26 */
 	0x0,										/* P27 */
@@ -1975,8 +1966,7 @@ static const struct {
 	struct rzg2l_dedicated_configs rzg2l_pins[7];
 } rzg2l_dedicated_pins =3D {
 	.common =3D {
-		{ "NMI", RZG2L_SINGLE_PIN_PACK(0x1, 0,
-		 (PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL)) },
+		{ "NMI", RZG2L_SINGLE_PIN_PACK(0x1, 0, PIN_CFG_NF) },
 		{ "TMS/SWDIO", RZG2L_SINGLE_PIN_PACK(0x2, 0,
 		 (PIN_CFG_IOLH_A | PIN_CFG_SR | PIN_CFG_IEN)) },
 		{ "TDO", RZG2L_SINGLE_PIN_PACK(0x3, 0,
@@ -2057,8 +2047,7 @@ static const struct {
 };
=20
 static const struct rzg2l_dedicated_configs rzg3s_dedicated_pins[] =3D {
-	{ "NMI", RZG2L_SINGLE_PIN_PACK(0x0, 0, (PIN_CFG_FILONOFF | PIN_CFG_FILNUM=
 |
-						PIN_CFG_FILCLKSEL)) },
+	{ "NMI", RZG2L_SINGLE_PIN_PACK(0x0, 0, PIN_CFG_NF) },
 	{ "TMS/SWDIO", RZG2L_SINGLE_PIN_PACK(0x1, 0, (PIN_CFG_IOLH_A | PIN_CFG_IE=
N |
 						      PIN_CFG_SOFT_PS)) },
 	{ "TDO", RZG2L_SINGLE_PIN_PACK(0x1, 1, (PIN_CFG_IOLH_A | PIN_CFG_SOFT_PS)=
) },
@@ -2097,8 +2086,7 @@ static const struct rzg2l_dedicated_configs rzg3s_ded=
icated_pins[] =3D {
 };
=20
 static struct rzg2l_dedicated_configs rzv2h_dedicated_pins[] =3D {
-	{ "NMI", RZG2L_SINGLE_PIN_PACK(0x1, 0, (PIN_CFG_FILONOFF | PIN_CFG_FILNUM=
 |
-						PIN_CFG_FILCLKSEL)) },
+	{ "NMI", RZG2L_SINGLE_PIN_PACK(0x1, 0, PIN_CFG_NF) },
 	{ "TMS_SWDIO", RZG2L_SINGLE_PIN_PACK(0x3, 0, (PIN_CFG_IOLH_RZV2H | PIN_CF=
G_SR |
 						      PIN_CFG_IEN)) },
 	{ "TDO", RZG2L_SINGLE_PIN_PACK(0x3, 2, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR))=
 },
--=20
2.43.0


