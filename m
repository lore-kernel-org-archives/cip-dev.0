Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8DFC3600C
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 11:07:51 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.56])
 by mx.groups.io with SMTP id smtpd.web11.49168.1743419263690991017
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 04:07:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=mwKSH+n/;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.56, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vo1Ota2GGWI2wNxMFr0eorc3e+dBg8BsEKA4HtYbZitc+ML8CzD9TNxc+ykvPFHxHavWDrOLmxY8KStUITVfk6nhUe48dpJpQN50T5hu78dfQwPmxmeZk8C5I1HJakHk76DAlNuY/3r7/tcdNvCSqhua0kJ+ksW9oLktk4F55k0MEWVxyMP6yjyb+k2U2CHW3k86GNIra1AplSRAgpynU9WTtDgGeyYl28X1Tw1v5HuGhx9dI+OXS75Jc/CS8+d8Mp7RnaIkvRNtBXALihoErAySVNJMvKQ+YPlMHO/KLYx9Mutk4BeLxvRUq7HSmmB3dTmWOVpqS+BMbv8+BWNDGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0s9qrixEaB0S8v4kJZEQ+g8Z0UShweGHoqgPJ/9eLE=;
 b=Ii8xBCpLXUYJcLOkbnTAD7XKyryV8K4GKYOY2UaF1a0mo3aLY+Vfru3z4LuRXlJIcXW1d4W7t8eaEupAm7UAL7LKffNmdeyaMIpMmvdBKzCbyJYrlwwBSx+qdsJbSR0Jlii20Tdp/dgCk4YtlXeBl3LNZtF3nhtAEjN9MHXBV6wNl0bvUfE3N0zdMZbf5Oc/MyVVr6HvNosXbfxAxHbF8sYjeuQzrOWZUx/IjOpRakllE5Ur4iF9iyOptr48FEQaD+F2WiAbc31nSPN88nMJ3akdup3cfzOeky4BZyldfquLMSQsCTm/Vk069hzCIhwLFySLJfbM81erv4TMOUSitw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0s9qrixEaB0S8v4kJZEQ+g8Z0UShweGHoqgPJ/9eLE=;
 b=mwKSH+n/U60NGCmj/sfdsJ2BGtga/55XUcfuM+i2jsBupVRXYXYukMr1UDJtoxHxpjmnSsoC9CrdcC4+WrZVHuLOZn6xVF5/6nYYuTXKmgJUMFY9qPJc7WIAwLwbIGHv4rRGpeXdDN0dZfvdCrVtSAuYl+4fkRBnjD62es1zxqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS7PR01MB15065.jpnprd01.prod.outlook.com (2603:1096:604:370::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Mon, 31 Mar
 2025 11:07:40 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 11:07:40 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 07/13] pinctrl: renesas: rzg2l: Add support for enabling/disabling open-drain outputs
Date: Mon, 31 Mar 2025 13:06:53 +0200
Message-ID: <20250331110659.252237-8-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::20) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS7PR01MB15065:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f072c8-1829-4c62-75ab-08dd7044409c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?L82dcEFGG+ffKB644Ttzuq/yHM5DE8ffrJu/nBNLAMNbUi4aAbb1UnKdja7s?=
 =?us-ascii?Q?N8xsUrsfABbYE2ROUoQT56WTY1UCN9gcvxxv16whtb9Mf7t5k5l2mlcSBuhu?=
 =?us-ascii?Q?0hPYdkU72i5FZOV3kf2ycG88IcbO3+PkwFMc/P0N0/a/7GTWhWTHo/1BgY2u?=
 =?us-ascii?Q?Gnys9lAAdbT8qmdSV+gS06kSG6Iszw0+Lrr4kxw0Ps+kk091BuG7uQqBgPJ3?=
 =?us-ascii?Q?UQvLMXzajYrgFfM+Kj6wiEWb0UQZq9JlBM6mF2lFvcIYEBsqU6RW8HXW5Ox5?=
 =?us-ascii?Q?n/5XkJPr+xj6fSqSkCCt8en5vWz5CfJ5Coe2DDJ1QN6zccGJkVmmIVvXnxSl?=
 =?us-ascii?Q?6aHRf5TFpAVCL2PeWGnDY+dljCkuMSsrQZJdFTlXa9uflGrNbfdnNak6S6MZ?=
 =?us-ascii?Q?cjlvUzKKy4hsuYpBW+DkmrvRq/V5I/98a24A5g2veuhw19nSX/PtoLUTduiR?=
 =?us-ascii?Q?/n7d42Tu4KEXVwfHG+DGq5krekmVh8dvedfixowIKiDpuUHvJou0AtdIrhR6?=
 =?us-ascii?Q?4Pc1nNQHBuFwfavW5GJbTCINfxVVgs/tixpWbNflN7FL8vpWx7eUEV54XE9Q?=
 =?us-ascii?Q?cdfXymMC1sHfNMfXkjNkUDrzVja1UAqG5C1FRyCDMGI7WvGixA4WeN7Snu/f?=
 =?us-ascii?Q?jp1DPZJ4/UBnBM3g+nAUoMZCrfiItl63CfEcRWmfS7a0KlZ6Fm2vSaF3r4IG?=
 =?us-ascii?Q?faa0q9+ymlOs6QmvTjBs/94Mr1v5RTbzIuledh7OSZJw72Hw/W+yEEjMxJpz?=
 =?us-ascii?Q?lk9OVkjGODzX1MvZkfsaRC1gR8PoT4VmA1y+xhjeYTBp80aanmkiUDWroLn8?=
 =?us-ascii?Q?nffQbkhyq9mz4de0hXGbtf2UMQb+jC/m+joHR9GUWHKllypYzMK6fU6QUjOb?=
 =?us-ascii?Q?jauXTv0ItkK1Qz8J3sipTGwVdjzirXn9H104PI+R+mxxCHkOOSlOkxMf2Te0?=
 =?us-ascii?Q?TsgtTg16lcaJrFHGLt7Ggm9Y2MHkh/Ug9UNNt02r6yTchBAFLh8Xc0/vHWAr?=
 =?us-ascii?Q?VIQU937GVzpgBqd0tFbaL2KBJB9LTC4KU/W8VQh/xV7+ZoZ0btmdWHe2DJt4?=
 =?us-ascii?Q?qwjagIrPGdEyeMAqfZQ7qw5k98VfbFkG9j7lG1s3VgiAmmViVHIH5fjkC2PP?=
 =?us-ascii?Q?qB7LJ/O/KKSxL8px5bpZtWDGpMqz0iAcfRaJBHeyzJ+cvBgFtUocWF+E8dcE?=
 =?us-ascii?Q?ndcrg9CoQxkQVnq6rgakW9hRyt6ba6hjY7uHAw+1004F+QTt9dp+c2WmOeNl?=
 =?us-ascii?Q?+UtUX+od1iuqBDtp7zvUOPF0sZ0r0VYCqKO6vp8wRtEhiuwfegyGTjbcdkmn?=
 =?us-ascii?Q?T5qLyYKsep8zPYctr37mzWgQwt/Iu5SBJ2A/t5Hgj2xRjQt1S4PJC11vcoxo?=
 =?us-ascii?Q?WtkDgC//m5UtRY7mqyDxRRuz4jF1LIfRgKcK/rtvI6L5vJ9yp81OlaXTMyFK?=
 =?us-ascii?Q?FtxfDw8kyRe8Nv/+6ZMhN4ZJtH9gqRtY?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tMNcA4LXmI3ZbNRuyTB80KF3goYT1FZhTbOEHMM2EFqt+yVK/7SIBpdREeX1?=
 =?us-ascii?Q?la/B2sjLhlX4zw+C6Olmy12M+zUScJrzKavJ/eDbantoSTnro3HJYYey3Fv+?=
 =?us-ascii?Q?Yf+LrPB4X8J8Pg6n82Akk/SNlg6bLOwvLSwIQYJ43X8MSZ5RbzVQRiSnaNDN?=
 =?us-ascii?Q?UEYdXt0B/GXKvFmBcwYvVQauXu2mQ5wKMMNiTSStEot5L5aLE6aFBC5D/PWO?=
 =?us-ascii?Q?Uop5EpHqwbfE8CrNCrkH/XDxG0RFDxUMQL7ycFY/K6fYsiHLdPcVMd5HpOYs?=
 =?us-ascii?Q?dnNLPne/Ypld/eoRjhcrEfHPGqcbez6KATzrwHndfuAvBNv8Nicg57C3wpqx?=
 =?us-ascii?Q?0V4goiXV6MRR3WmzQPUFauzKGO+knD9HPkUUwzTpKLSRl5TXl6n1FgqLc6Br?=
 =?us-ascii?Q?2yrY3oZDzDMdqm16ie04P5VP8HCXxlRHJ2/+1OtgIP08P1V25vjTIzVOcWv/?=
 =?us-ascii?Q?lV7mmElyrWsZhUFrp//SWZzCmf/fFUGGO9z2spFrk51+DWCPzIdKc7Do4aSm?=
 =?us-ascii?Q?l0vWZADP+gKcq1oFTFKb/Inwd8WeoYiCmV7R2+4iZvhNJZOpzol/PzcmNwm5?=
 =?us-ascii?Q?M429j5CWnD1wKeDkD7kx4z3VpFhcHhRhpBZElwtBWhfMUUHBX/+k7obnQkUq?=
 =?us-ascii?Q?QScpbyHT6R2RjOrFwBp/kVHIK0v8r/5mjUy5jJfRF9OlnakyGTUlzoAE63oz?=
 =?us-ascii?Q?kuuTR9Xsfno6xPca+91KGcZ7iEpTEjQQH9jpyQJXSJvFzcH/A+IMcKlSCg86?=
 =?us-ascii?Q?UIeD2QqMwOWTKtEVXDhwYi1oukEvqY5DGc+hleXv2LeWwJ9i0i2Z+txc46Wd?=
 =?us-ascii?Q?NEsSsDbU7TcQKFXE2M9xpxpbc62cdrCjgpC5FusWfEfsFCcCerQUpcOCQ7VX?=
 =?us-ascii?Q?sJvY+hUtFl2gsRaXdyubiBQYV0VJwqf53o6UMM/e0aNtXIR0f7aJ5k2GNill?=
 =?us-ascii?Q?avi8BjtKxZMo17AWZTg/OHfSj4apaTNmVOqxLK+uE9dyAEoIugKHj8nJyRnS?=
 =?us-ascii?Q?B5f1GtmrJVSBCeAMmI/QcyeLoSoOXs74JL6g3+v7UvRgeW5i9dWsaxcvvyAF?=
 =?us-ascii?Q?oW2gIr9jgWZVSKQfBwpWannnJauaiQOKKiZQCTwn4sETpIvEcUUMrH8V2Rn3?=
 =?us-ascii?Q?43e8S7v8wAaRakaRI51AJAvv5pnyNQ7US0XA/NH7/g+HIMLMmoY6IqqhtQIV?=
 =?us-ascii?Q?udq+oyBNSmkp3Rc01kBf1Ln3xp7+fOnxpROtoBcfCyZbsUNZKjlQ6Z1xTATj?=
 =?us-ascii?Q?+MzFZfA/XbsPhi1GyRGion1GBCMoBid2LIHqnmEiyVBoYfr+5cdQ6VmCjXtV?=
 =?us-ascii?Q?K9w0488gZa3NmjZOLMjJqY7W6OY7gJwywpyC0vPhe549fA6Os1XtkAKMsiMW?=
 =?us-ascii?Q?UEvYwQDXdmuFXkBE0IY+y5V1RBQyLUyqaihUZ/QwRtRnbmZjbr5ztSd0fHCn?=
 =?us-ascii?Q?eS6AwLSDDyJB9Sn3WnYtIdDchSbO5yJy5ru9cJTxZT+JoT604TvG5Eu6TcZC?=
 =?us-ascii?Q?xZTFZf4HpnAdlphV3estdHvvDPa9qO68nNQYkWxnzfxh/domnd3MCGYNGUin?=
 =?us-ascii?Q?N062gmv6ynoZhKpSbVpN3d/1JmBv1vUO7pehhknoLzj0vGVo4rqmMlsOO5Xt?=
 =?us-ascii?Q?CSGnuTEKqEGXtUi4BYtHcNQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f072c8-1829-4c62-75ab-08dd7044409c
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 11:07:40.3602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOZ8KORJk4gFvO5l2USyTBb0l2b4sMLFRxLZH3Q8zGCNRaF7ZeYY/xu+4HQOTqcve5Y9AfoqZHqdACkBeYvELDanGf32SDn8P2plssGO1+qyeqgIEbO58CaEnoNXAEbz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15065
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 11:07:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18439

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 9d75b70061917fbfe3247e2594879e5a14d3e24a upstream.

Add support for enabling and disabling open-drain outputs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241004123658.764557-3-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 37dbecb8bc6af..548f4a926b091 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -141,6 +141,7 @@
 #define IEN(off)		(0x1800 + (off) * 8)
 #define PUPD(off)		(0x1C00 + (off) * 8)
 #define ISEL(off)		(0x2C00 + (off) * 8)
+#define NOD(off)		(0x3000 + (off) * 8)
 #define SD_CH(off, ch)		((off) + (ch) * 4)
 #define ETH_POC(off, ch)	((off) + (ch) * 4)
 #define QSPI			(0x3008)
@@ -162,6 +163,7 @@
 #define IOLH_MASK		0x03
 #define SR_MASK			0x01
 #define PUPD_MASK		0x03
+#define NOD_MASK		0x01
=20
 #define PM_INPUT		0x1
 #define PM_OUTPUT		0x2
@@ -1340,6 +1342,18 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_=
dev *pctldev,
 		break;
 	}
=20
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		if (!(cfg & PIN_CFG_NOD))
+			return -EINVAL;
+
+		arg =3D rzg2l_read_pin_config(pctrl, NOD(off), bit, NOD_MASK);
+		if (!arg && param !=3D PIN_CONFIG_DRIVE_PUSH_PULL)
+			return -EINVAL;
+		if (arg && param !=3D PIN_CONFIG_DRIVE_OPEN_DRAIN)
+			return -EINVAL;
+		break;
+
 	case RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE:
 		if (!(cfg & PIN_CFG_IOLH_RZV2H))
 			return -EINVAL;
@@ -1469,6 +1483,15 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_=
dev *pctldev,
 			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, index);
 			break;
=20
+		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		case PIN_CONFIG_DRIVE_PUSH_PULL:
+			if (!(cfg & PIN_CFG_NOD))
+				return -EINVAL;
+
+			rzg2l_rmw_pin_config(pctrl, NOD(off), bit, NOD_MASK,
+					     param =3D=3D PIN_CONFIG_DRIVE_OPEN_DRAIN ? 1 : 0);
+			break;
+
 		case RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE:
 			if (!(cfg & PIN_CFG_IOLH_RZV2H))
 				return -EINVAL;
--=20
2.43.0


