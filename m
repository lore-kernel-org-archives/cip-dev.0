Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653ECC35FF2
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:05 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.70])
 by mx.groups.io with SMTP id smtpd.web11.34825.1741778727134609213
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:25:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=T83HbO0R;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.70, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpAVVE9GXz4HLBooYQKnB1wEV9KSl8GN60+FActfoPQ6pJ5r+PjIsxZ3UcjvoIBNdFH7GAlhYYFczAY/+uLp0mNBXlToYXyrjf6Tyj2ShiaYH1Fdm/5WoQWZ9kgCGGkJMvlceumyNBg8WM9rCXWjSOH18oO/klyClzlc78NKVBdNATp9aH3BFaesLZqxWnZmd7UP0LTRkY8sZUPYCY2PpAAT3TU5N81Qm6ACA7BWi6IBRjwKe2vXTYmWH+l6IKDmZvji7AG3jTj6y3jUTiie7Zc61A8YncSOLQabnfjl33kThAV6ssBkK0o84kQMm2likzLVkYe37jmamH3PLYdiQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vccGepsxBynBMBiSS8rGiil22eMCeVTSjT8qWqucI/8=;
 b=IWl0+pZA+CC1oV5EzvGdbOErWjo2W1MIoJXKGjdmuHIsOz9ogl4qe/0CV70V0lZkT93kZ9Q7OLUA7j9JD9IOIu4PtQZPopy9H8oOIFSN73vgblPBxQgprSVMLL90tG9NCVn1oulcVkCfpqtqGxUG9OCMKuxhozH6z9SGmca4JnujRKQGHeEDp2jkeHgRlN2Jw5sxeSXpJui0iuczl/h44vdahdZVv4NW0lti0oU2GzdOz90NBBmkKSiwl+iH876x7wAnehNJ8hOZp31B+p5XpJIm1xnZ1fmlfchLOpMK2JyWDaD30+bjCynonhP4Xn5Km0UtxoeaD71/5F87knZZwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vccGepsxBynBMBiSS8rGiil22eMCeVTSjT8qWqucI/8=;
 b=T83HbO0RfUNrNWCJaUIT0i/EyYxiVAo6KYbits4qS4W7zx4xG+hQ6MBSZxOHI6RV1MMM6fkvbZy2jNmbQdbHKrRaLN+fbI47wh+0qw9EheIjigmcSWDoTsL7P/TwhmwHOhA/xheEGZWFeKJEG0w2K/JhpltkzwZMQL5Gpf3ucGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB12752.jpnprd01.prod.outlook.com (2603:1096:604:33e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 11:25:24 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:25:24 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 37/85] pinctrl: renesas: rzg2l: Add support for pull-up/down
Date: Wed, 12 Mar 2025 12:22:14 +0100
Message-ID: <20250312112302.1605750-38-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB12752:EE_
X-MS-Office365-Filtering-Correlation-Id: 692f5dae-7002-4db2-945f-08dd6158953b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?PRdxc5owxw0g7mhjkYJA2PWnlYwspzJ7UPhRTjB5zVvdEVVFjkV5cuupiQko?=
 =?us-ascii?Q?S0ggoI7Pm9hYPjRi5ImczJ5SQqyI57EqE6Q3JWE31HZOZsB+Dyc2I0qf1g6D?=
 =?us-ascii?Q?m0Ix16psAH8bYzFMQyRu9nvu9qu6MJxCxgSockFGdg8fZ7EWtsAo8f8dLYq4?=
 =?us-ascii?Q?8ENxuL8l7HzqRuAhJKe1ZJWULzCeiR++U8cHjSQu6qdO2k1uOBmKPctQgQQQ?=
 =?us-ascii?Q?uNt2X7jeBuJMdGXlAkx1XoW8hsyqk+CCkelyVNatJvlTDmsVvdbO3ES0QfGd?=
 =?us-ascii?Q?N5+wQGbxuIiLpZ27vEjI5aT9kVAUKVp/9x+FrEpyQRzOwUgc44DSfZn788aI?=
 =?us-ascii?Q?xqX+nbUMpAg/kxl+gPXLXa/eOvkRXsgHTWfJ7uhEGknmnhpLFM/ujBr0BaqI?=
 =?us-ascii?Q?ZOPtITZQRfJgC1soNTCfnuoFGv6TsjshFhraz4y/8MK35BI31NFWC+dvsT9z?=
 =?us-ascii?Q?RayWn7vcuFKo9/FuhHVMBBXr0N8XcCW09Ev3kvvG3JZNebmRONpXqGWs8rgj?=
 =?us-ascii?Q?g3YYyN3ZgVfzE1M9cJjzfSpwUZLgwGTraMAqHLX5cfQwuwO48Guzk1thlOCj?=
 =?us-ascii?Q?5y33XFnkUoDzEgFjFC9QtkE656lSTuR2DQzVY9dicvk4sA+Pgclg64iYkkIh?=
 =?us-ascii?Q?TZeNQGlTxtvCETHPK5HyGcAfzOFzWwepNOVWSuRiTf/ZI7ehbvrTHpNGlKNi?=
 =?us-ascii?Q?4awv7v2Fauz37Gh+W33e3cl93bNHDvhwoxKogstjfvxxjQvVfqRLQ7CyDNGo?=
 =?us-ascii?Q?Uy3up9UUqbhyrcdoN6xA6tfP+E72oXNM4ENGrN6HW9+jrvUqQ1KLVHDXBpZ7?=
 =?us-ascii?Q?wh9uLZyzL/pJu3/zImR9x1tyxZ+4o1fIdOHRfE4ObkoC+zdJ2ekU3HZGb13D?=
 =?us-ascii?Q?iGn11VwpOcP75pgD0weQgG3bxgmRHJKPgzA8H07TJI+aubl3agReYMwg/aIo?=
 =?us-ascii?Q?hZ1MIH25N4yZledS/o355QVS5AcZ2LcvlMtDYxRwQ0ABkPfwT9D3sBLzpH1s?=
 =?us-ascii?Q?+EgqIpfNo2rwo2bZ0EV3GLJqLG8x1PQ/LXtdIWwvctMguBSyxUeO/Ki+Ueer?=
 =?us-ascii?Q?B9iq/W6H2W8i1SQNyT9h9AF4b2+LRTCnm+EuE0L9H/Go19TcwYw5sWasOSbb?=
 =?us-ascii?Q?6M9dlfhxhRGZu8GrhyU9UVXL9yGXA/PJD2M5HMHmo2mNhovGi4KiKlxdXhjz?=
 =?us-ascii?Q?+176HuHR7CSQjaOoHxxirzrFytdRFlKl3S+GE6zTbirvPEYaPLUYowPdSnrv?=
 =?us-ascii?Q?YhTtSXcJ6nmtymJJvwUQnf+xQqfTW483AxPr5o7JdaQxfqthsCCD94AZ6rsN?=
 =?us-ascii?Q?oJBggIvDAklasFV7ijxs0vrej4XMRgPFoW6eNWSnHECFF9DvNlgUBTdDJ55t?=
 =?us-ascii?Q?luefeVcZW2WIkhsg7a1PJDOr5DPWZU60LvfFKcDtOgVbzhN6/T+wMBIceLeZ?=
 =?us-ascii?Q?jwz5KRsd3Wu0bCxOAvfCqRRyNRzzc6QS?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mezooUWh3rJk9hWAC9afRt8yGcd6KsD+Ua+bmVVwPB0utioDapPm8Miazj4V?=
 =?us-ascii?Q?9fxOgly92RU/jK0P5kuOOA45HKGEIiO4sWL+JChcUUMAE7afg4no1h3I6EUy?=
 =?us-ascii?Q?t8EgSkKcSFLoJvErU89uYUp1n8RazLCs1Df9J7hS/8FTC0ytpPCKJnIOehZF?=
 =?us-ascii?Q?vLnoGtR5KWzU3FSRyDnZqIcTPlM0vwod9V7cQwDQaBZw5KGtNyrz2yGkgpDF?=
 =?us-ascii?Q?jyYD+USQfsTE4f4eVaIzMusYOgqsRKTJrL3tQwlqGUWeXHF0PXXi9zwry6vg?=
 =?us-ascii?Q?TurcQNfN8/OYW6KP/uNHbkTiupLFakCN5HqaCG3axp0zUQVdCR4ewJu00w8k?=
 =?us-ascii?Q?R6V6m95adZatMnUY7igJ11bUWx/7qkhSIIYMAPjUwLW58QDiJb1HXEEWELDP?=
 =?us-ascii?Q?TtRw8uL9/Gpzy2lvwdL0qpt1lqFpSuE2lot9CULvzvHSOsL5aj3gl+m9o0d1?=
 =?us-ascii?Q?wtxJEge0ZQOSfJGYwJA1c1y+9LR6A820R0HXDbWKXShtQqcfIDT1utBBoF5V?=
 =?us-ascii?Q?ujZ/L/Jdk5QVEXlV/mPOzh7ntDcjqtuwiHM/C4p/huHn4Ki6JdkZQh7kQSMV?=
 =?us-ascii?Q?8dw0tlTnT5wDdlI59dp/swS4s07sQakPAvc4HXIMyJZbV1sVEmcGMvHIvsRH?=
 =?us-ascii?Q?jzKrfJREkt0FwG/OPzyZNygYBXZ4QdlmaBBhc2t5kmQdotuDkZ8WoPhS9nBK?=
 =?us-ascii?Q?KV5gRoJI3ALPWJg4lRMSN+b2X/WGWHg1BuPjtJX5o20UyvWQbXMb3b6pF79k?=
 =?us-ascii?Q?7VhdyFClG4+h11Bg3AYwULs+WmWL6pIZGqaUG1wbh8sw8F7SGcbDkNjvh49T?=
 =?us-ascii?Q?jzjgQUWxz1tauNwJWorm79/z/vsfVGW3XW3m9ngHyy2/x5Dyj7icT66Xpti7?=
 =?us-ascii?Q?ASJnbrbtVSD4Xhhn7i5LVEJntQPvp3R2t9vlPOfaAPLbaiuiUkOVj/upRiYO?=
 =?us-ascii?Q?ECca9Nk7e4VDcuTqUk0Zy1rVm8OmvmRQK40vv+roTlhcMC0P8h2XaczOtbk8?=
 =?us-ascii?Q?EyVvWVMLWhCHYf0wHIv+fDfuTlDNdxIM/qxIJX7k/cRMpLGYjGTLbOrB8ikv?=
 =?us-ascii?Q?gjh2/RnktcuI03WrowXOPQA435bTkKs1Kurmo+C+rHa2dV7uvG6aCjWcPQFJ?=
 =?us-ascii?Q?wEJOxYwHH2jY6ZDnBKkGWbhURIUQic2pgLq10Zy14BfwScl66eLYr/L/+hMg?=
 =?us-ascii?Q?CyUR0coF1fAaDROwdAe3q4w/uwVjYQHAjRQ7Op4BakCNr/CYUx6vmcG0I7CC?=
 =?us-ascii?Q?HvB+swRTYz0k9EA54MjanTfLaFm4Bg7rzc3nBxETTlZfs8yLLLdl7mOWmYi6?=
 =?us-ascii?Q?2DJfEg2TMZOzj4pRrW+K/NQ2WL8uTUoxJRnL8QAQDf3/Nn2ufcgz1YD5m7kg?=
 =?us-ascii?Q?BoXl43Y9BC7y9tJzLUVko+YDXPLpDjHLL/GCAqgaa0xkgdzKTyoyyJgqMduj?=
 =?us-ascii?Q?TQCGtU8uNxNGlVPp0J+zBJXQX/SV7mCz0AGVtRFSuGTLoXOm887Da6nL6ztn?=
 =?us-ascii?Q?YHfb30OFGBPGmvTXIBEcr/0FFZdt9GPvoYkGTq9XajWAOsT6Qf/ygcySY8MG?=
 =?us-ascii?Q?EF0xsITzw/sJTtZTGAmxyQ/twMo7kviZLeoN3eOBsd1QmYLauDpKiNwm7SDX?=
 =?us-ascii?Q?B4XK1MtVgjmLAi/ywGPMFd4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692f5dae-7002-4db2-945f-08dd6158953b
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:25:24.8692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8wdGPbinj7jjMeCjxIyCh48sc3nz+IHMWFcSlOYRjQf5ymV6xM+PyZFVGO7Oxs2ZdiIx5ViAoHFcpKh3ftin40F6UCZYepagDX/jw6ldxPNpLX4MYMkWX5YyBFgqD7r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12752
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18129

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
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 72 +++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 596e101f5b2d..33c96661092b 100644
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


