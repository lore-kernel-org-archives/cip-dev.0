Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90805C36014
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:47:21 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.35])
 by mx.groups.io with SMTP id smtpd.web11.48839.1743418035632409241
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:47:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=eqtOA0aG;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.35, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmaKhHGjdRtzFKpm94R84xsHzkjfS6zfXxaQ3Bn5UrkCsgzVZtaCTmph+sf8IdTlc7JoY5LxjOHiGHaPnxYIt9Xzwl5BJqUuKIIOFihkLlukD7dW4dIElD6e5TFJb22EYAKSCJpZvDgZnosz/igVEKcNFqIEXbAU+Ivp9qMykyEQePbE9N0JJ+B8wskXA3WEAn+YHNG8zR4Hm7wpBenylVzWDfqLia1rsUsbTel3q5PP5kp+8y8J2rbcdCbfEu5Jekp0C7fUeG9GVoPX7krcM3uqgFX9Uni3aS//mq8JGdXcHjj2x3giB60Nga+xB2GArd0IofkGygJm3IX0NYybZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbsXovNSlnDQr2TLZDgxbiaHxK6EROaScwpRo1XF9CY=;
 b=CsV4dfb69xCXXZEGQzCqKJ7y+fjZ2I8GrRrIUZu7wer+zxsxzezfC8euVtGkIFyZ1sC2jpLAV81vO8vlXtTWS+aV6edSLkuEfnx3nlgpHab45G8A6SXiGEchGDLtLsd7/G9MuYUgr4MTZ0UYqXshp3liXJQkKVfdjgdIA0gE0pRG2VWK2RMWaGoswruyeybow2NuhRNHP6xpiRFMHSyUz7ziTthXQfH3SGc6BfIZxGRShE1sROiMLHPjmdShh07b4oQCtMco4R7RtL0HRpJ/CEvGRtm/ql47FZ+77Rm8TKoOcdMb8toPsrgkR1KLH2WrDuxcod7I1wOEznHPBDeGsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbsXovNSlnDQr2TLZDgxbiaHxK6EROaScwpRo1XF9CY=;
 b=eqtOA0aG4kDrmtw67M0RPijjZDHlNxrWwks8WeqXs/SJc5osSaZsOVLes2lAEnKHaOC2cJvsoWpj6eabEug2+XI75phv3OdMYxnNPofenjS6JSgF5D1hbIWlwoMI1aeLIkJutfm3W3K/jfKpjqiRI8OIJROvyJJBACNbD17tDTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY7PR01MB13744.jpnprd01.prod.outlook.com (2603:1096:405:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.33; Mon, 31 Mar
 2025 10:47:13 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:47:13 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 34/43] pinctrl: renesas: rzg2l: Remove RZG2L_TINT_IRQ_START_INDEX
Date: Mon, 31 Mar 2025 12:45:05 +0200
Message-ID: <20250331104514.79090-35-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY7PR01MB13744:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c47a589-4206-4535-f035-08dd70416573
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?g/EqO4kK4l8+qX/VpNvDjLyC9ZL5hvN8dFyOh8pyoF/MvEYaSCsMYtEqdIFg?=
 =?us-ascii?Q?G/jZG5Z4KXqjU1RmHJU1hDN7VleL4Enpk4UoABnimET9VkUDT8HedcJe+EaA?=
 =?us-ascii?Q?BaUUJ5K3fqIITA2tx8Rgd1TY0mrXO18NB9u5C1r331F255B4FQfRvxLORPOp?=
 =?us-ascii?Q?t3498jz8nA5CULOYLLST318DolpEIjwWs7DHeXCHNA5LxxLvKkFZXDV5/N7e?=
 =?us-ascii?Q?2rdxeh7+AN25pBvhl1PHOpm9poK1gt06+cbgNOb+4u7XJnuA1EkA+1/+5N1P?=
 =?us-ascii?Q?OWTM6XwIhpszLvrxlm/AR4JwaQ+MUa2zwUfIPvAjDdWB5QgFStisvRE401J9?=
 =?us-ascii?Q?py+s864nGjq+9AqnciqY/6AO8059cQ7ZDtZ8vSHD655xQCpJFddY333zsAfw?=
 =?us-ascii?Q?jVcFWAFJDMP6KawoBIDqeh7b1RVEPPe6ByDhsDrQE40uCKk12wZp80Z+jh8Z?=
 =?us-ascii?Q?cAsxzXB0eLJW4tO+qUNUzyHlZDZgrU+2UhbMq0nfuJs2OT01PBSLIruaXBeu?=
 =?us-ascii?Q?XzTkrElkmgu9l91aU+QMpQvuNWeHjDarj97DkbjWA5HwBoYRPhRzti5yULnn?=
 =?us-ascii?Q?vWQrPQpEfGSrYegvgv1T03uZg+7SPt68UM0nfx2OvNzR5TXXlO6dj9SPkmTO?=
 =?us-ascii?Q?81Ixj9wcdR1OjYldLUkxr4QwEAU6BsEhsC83ArfAlNaT+x2Oj2Qot0Hv6C/G?=
 =?us-ascii?Q?HmXFEvEGNYu+02KutqzuaRW9xZpftdOokOZ60VX5JYq1wMo07Tg8GzFWad4N?=
 =?us-ascii?Q?IVGmgfozJ8wczywfX8QfgBuw8EYfpwgAVEvUk+TvD3pAMdQsDgMePMEKFZR9?=
 =?us-ascii?Q?n1BK46hcZ7Wfzh2jmbSWWZ4svhp7R4dyIKRqIP3paKCLXWLLeUb5iu//4A5p?=
 =?us-ascii?Q?0bc81WyxLLOdpZ1p2RQOUeoO1NxgoBsInGCfK/Dyzfx/xFK6pL61QcG795XK?=
 =?us-ascii?Q?291jetHgzcrEdFfyoqBx41L2KSlFWyEpijy2o2tMwhZXs/NAxiRWVXdBCmWd?=
 =?us-ascii?Q?KNnHL8WcjBFIX0DtxzKWgdjEJVfkWg+B8cfGtY7nR1f3TtnrrjLOWjsWKfrl?=
 =?us-ascii?Q?nezv1JnPLBypMHBdV+qExGKk+Md02MMWo6PwPB0/Dsd9iuhKtCH31DUDgkyp?=
 =?us-ascii?Q?MBIDAsn8KGlKR+CQ/1iJSs6t5UcWYg8D/9T9bo0Iaqkh4aaqHhLZ7+tnKk+b?=
 =?us-ascii?Q?jNIuO461s7Ord12vVNm2N/k3wFbyTnTlvXTjZIONJcdWrJ1kMuQYxDIU9+4h?=
 =?us-ascii?Q?KM42RVwsMQKSA0J3Ri9C2/Ox2YzMeqECjsLE4q27BLxk4AyddXCuvzX961yF?=
 =?us-ascii?Q?16IqiBs1SRHEQIA5UTVY/WSaN3pm60E7yOKAMcd5ZEl1H+XirfqaGzNOsOFi?=
 =?us-ascii?Q?3C6tYEfQhWS6GV9ZS9I4N7dN68cGtVxTb+uTRjCAu9JND/sIm2BULunZsr/D?=
 =?us-ascii?Q?HL3t7NsVG30IYwuZSdJS9JCK24Wgb/9y?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZXPzRE08GcBYoMZmGBeZtBZGrkNO4z4ShaLC0uFYFUPy1Jn8DOlZJ90Nbr+H?=
 =?us-ascii?Q?V6atcX2T8b4ATQAEWHnXHuNdLWv15GkZUVCc7ajt8y215qaZ2GBRSRih1LiN?=
 =?us-ascii?Q?76yoD8ul9X6S4ZoM98sV6ryFAQ3r4Kh6NBhrAIh0nib3Dg6cYG2bNv4YxYns?=
 =?us-ascii?Q?HEMPWVFEgqBQK9UfTeENVkOd1fVJrQSwCE6uw86r0EhUiD1dxes81D+dsI1b?=
 =?us-ascii?Q?kDIhVnbBLyfeI/l1U6ILcGzr4wo857P4EZWU3Gzkuh5aZ5nbvauAwTB1iQ7A?=
 =?us-ascii?Q?QhKacNywXioU7t3vmHxSBv+FJclm0C6E/iio73Ku5p4l3YUJhgErSL9kiYsn?=
 =?us-ascii?Q?toOb3NuSCVBThUkfE6uHn+7bP1Eo1wfo7il50eJuklFCdlL51753lWl5HnYI?=
 =?us-ascii?Q?Gz90z/lLLt23YDE3JipfJ9NdAf1uRDeo2vtv+Wxyvl0HCq5ngIezJ1P0RdLw?=
 =?us-ascii?Q?OoK0EsnKBOTzBrLyOCElBKo6Ci8VINRANTeQ8c7C7FcAMlof4fJOvq6EcvAp?=
 =?us-ascii?Q?jt522xqakx9HNk16ZOhefWgxuZyDnkaRh2jqPTCfkYBhOsTBpghLL8hEklvU?=
 =?us-ascii?Q?+PtCXfhrVaoxb4uC72ocNq9S4P2Pi3uTbiIJ6ejtU/Tpyq37g9aitch8oriD?=
 =?us-ascii?Q?1aQIkSo9N53eTVQOxPxTzsvFaiss1bqyI5+9hQzP18MguEcAHIScjFvFo96A?=
 =?us-ascii?Q?7iCL0J4HOWu0b0yftMfuxxJ3oOlvE2opj+C3H+3/MQh1Y2FRFYzGpj8hYMST?=
 =?us-ascii?Q?mo4Pxozo2qCr27qm+ShqgWBAGKrG62Fh68lHVls8E/gZzTwWFVpnyJhRtWv1?=
 =?us-ascii?Q?KyGOS+icM2TXQfuXBmITf36kpiNVBKZ4LQYdCNajphoCEDqvPJ65FBFjPYD7?=
 =?us-ascii?Q?Nl3lMmuFI71nKrtLmDAw93k7T17TWFy5wmqre/InAWlDM4M3bmQEOrIt7MuZ?=
 =?us-ascii?Q?7Y1LesxDPo9RQKg2hyU4uqDXnAGxwBIpvzUa9f2GmIYSZ5PXAiT7Up577WLv?=
 =?us-ascii?Q?s+joWVX5jj5fzGfAXMHs7cEEvLPcdCQZz8sRbUSQS4awhRFhnpCTdYtnDmlR?=
 =?us-ascii?Q?G0tMWrHB8YI834sDgKvdW0WeBcRwK479AuECigvT0AHA71pY06sjF/qAyjNL?=
 =?us-ascii?Q?FVYtRSYN2O5xgS+U/7i5EiKL1J9Y52aR2knTxSllKEzxqO1v39GAHKRSHLk/?=
 =?us-ascii?Q?rbhdPbJlMq6UGZs21SlM8LelCbZFZs+fPDQ6q3BVOzw+A68pCQaWmTe4XT9H?=
 =?us-ascii?Q?uhUIIJF4ZjHjPE1Rxik49n77E86TZu3dBQtywuPH/K53yXdKL8f9nTDI2HFI?=
 =?us-ascii?Q?1s8GeGzI/jleH5aqKEqphhwgXoP7DjW5Qye6GftF2CexfpSUQONLQOIPHJyR?=
 =?us-ascii?Q?2++8cbxu7hqhqeYRExwr7T73oUj/xQRFzxMKMYMIlbudgcLeGRzUR5Er/0wT?=
 =?us-ascii?Q?Bb26ygX2XS1uHXOkTY8cviBh6seSHS4LaV74GelV9NncJ68Ocpf0JjdMWCPJ?=
 =?us-ascii?Q?uBfx/P7QeDGvqDhfQ2qPFSLUpM3Vs9BgvXNH9stD3XzhO6sReTFgcuTb+nZd?=
 =?us-ascii?Q?1kTvmxRziKJjHTjXkE7ukNGbiL3/OsmRwOFOMCffSWVyz+76aDof1Bm8nfMk?=
 =?us-ascii?Q?4R8w7fYJgooD+tjYc9kIHQU=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c47a589-4206-4535-f035-08dd70416573
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:47:13.7508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eftg9l9dGLiDc1WLPXbslhgoKj+O+and8d3Nh36WeESzdNDpZF64burJKtU2vFJx+cXlVX6DwKqsw5X2OYQZG+Z8/Hxv23Eovwdqc6I/+p6cOubvKvvlBZTDxj7G2eR4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13744
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:47:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18422

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

commit 1d930d4bf8e68c2a7122a6d0899a99f0370c45b1 upstream.

The RZ/V2H(P) SoC has 16 IRQ interrupts, while every other SoC has 8,
and this affects the start index of TINT interrupts (1 + 16 =3D 17, rather
than 1 + 8 =3D 9).
Macro RZG2L_TINT_IRQ_START_INDEX cannot work anymore, replace it with a
new member within struct rzg2l_hwcfg.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20240930145244.356565-2-fabrizio.castro.jz@re=
nesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 5919a9c441be9..4ccdcb1457045 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -167,7 +167,6 @@
 #define RZG2L_PIN_ID_TO_PIN(id)		((id) % RZG2L_PINS_PER_PORT)
=20
 #define RZG2L_TINT_MAX_INTERRUPT	32
-#define RZG2L_TINT_IRQ_START_INDEX	9
 #define RZG2L_PACK_HWIRQ(t, i)		(((t) << 16) | (i))
=20
 /* Custom pinconf parameters */
@@ -246,6 +245,7 @@ enum rzg2l_iolh_index {
  * @iolh_groupb_ua: IOLH group B uA specific values
  * @iolh_groupc_ua: IOLH group C uA specific values
  * @iolh_groupb_oi: IOLH group B output impedance specific values
+ * @tint_start_index: the start index for the TINT interrupts
  * @drive_strength_ua: drive strength in uA is supported (otherwise mA is =
supported)
  * @func_base: base number for port function (see register PFC)
  * @oen_max_pin: the maximum pin number supporting output enable
@@ -257,6 +257,7 @@ struct rzg2l_hwcfg {
 	u16 iolh_groupb_ua[RZG2L_IOLH_IDX_MAX];
 	u16 iolh_groupc_ua[RZG2L_IOLH_IDX_MAX];
 	u16 iolh_groupb_oi[4];
+	u16 tint_start_index;
 	bool drive_strength_ua;
 	u8 func_base;
 	u8 oen_max_pin;
@@ -2379,7 +2380,7 @@ static int rzg2l_gpio_child_to_parent_hwirq(struct gp=
io_chip *gc,
=20
 	rzg2l_gpio_irq_endisable(pctrl, child, true);
 	pctrl->hwirq[irq] =3D child;
-	irq +=3D RZG2L_TINT_IRQ_START_INDEX;
+	irq +=3D pctrl->data->hwcfg->tint_start_index;
=20
 	/* All these interrupts are level high in the CPU */
 	*parent_type =3D IRQ_TYPE_LEVEL_HIGH;
@@ -3034,6 +3035,7 @@ static const struct rzg2l_hwcfg rzg2l_hwcfg =3D {
 		[RZG2L_IOLH_IDX_3V3] =3D 2000, 4000, 8000, 12000,
 	},
 	.iolh_groupb_oi =3D { 100, 66, 50, 33, },
+	.tint_start_index =3D 9,
 	.oen_max_pin =3D 0,
 };
=20
@@ -3063,6 +3065,7 @@ static const struct rzg2l_hwcfg rzg3s_hwcfg =3D {
 		/* 3v3 power source */
 		[RZG2L_IOLH_IDX_3V3] =3D 4500, 5200, 5700, 6050,
 	},
+	.tint_start_index =3D 9,
 	.drive_strength_ua =3D true,
 	.func_base =3D 1,
 	.oen_max_pin =3D 1, /* Pin 1 of P0 and P7 is the maximum OEN pin. */
@@ -3073,6 +3076,7 @@ static const struct rzg2l_hwcfg rzv2h_hwcfg =3D {
 	.regs =3D {
 		.pwpr =3D 0x3c04,
 	},
+	.tint_start_index =3D 17,
 };
=20
 static struct rzg2l_pinctrl_data r9a07g043_data =3D {
--=20
2.43.0


