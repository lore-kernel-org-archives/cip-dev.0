Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9072C36002
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:05 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.25])
 by mx.groups.io with SMTP id smtpd.web11.34822.1741778720749936679
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:25:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=OUnB5OUu;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.25, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBXhRgb3YI0xasFehxo3gL2zWTnUhwOR7+maGdP2cHD5BS1ZIL/WWtJ2hZ/pEU6f1uP4mAgOThKzATR3MYWBmMxRShQuhufX/RR6DDK8zitkQZLwY95arVBikgAX5D6h5gApMsUkR5AV04+RXeU3wpoCQdF/8k8fGynPjdiCDYHQyTY4Hud0GX83RO/PmQe4EZlw0W8TmATieTCvOnAKaJryd/A9s9OKX+JXerMUUC9dWxbWbuHgyDVADQlzJg6LB9sMXikbeO/frPdOKZSKszKMnsHUarKm9zWxeCfE7lpup3UGDBDM43YrmLYy4LuM1b8uSq+JfVJ/qrg+0WBC7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LR+EAjJ5dJPN0PzUsJAydtFmNwhCZzWnrMCZK3T9JQQ=;
 b=uuT++2jZtpmclR1lM+j2lKp0VTPjOrxKei2nvJD58RHc5S8/ERliIxpfqajSipmiabzTg3oHsJdhxmik8dsXabCskgAQ0jw4pedmRq0o9oI/MVlRdtX/bho1PsW7zicFiZO7IwjFzZU67HJWc8JIROZLlG/egHWvmyX8s11zNSKhCnxE/+LcPcuPdQeybkf9VY7F0yvgmILNd5ZZ7qshbt9yLZPs1T60H9DRCBahPb1hKSMiTyh1R9MEgfCTHH/UK8yUfvtqFHawEPWSza1L+dcMwEPOFfDyINicrtp0CNh6QmnU6f0brlCAN8q0+TzJu7np9FM8rB309+ulDR+Jfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LR+EAjJ5dJPN0PzUsJAydtFmNwhCZzWnrMCZK3T9JQQ=;
 b=OUnB5OUu4JsqmnR9s5agQD+3knHyco873JqtxAw4ydcRWphW33+i+/pAcFy30A/uRSOJwi/jqONAvHGf3DXB2gk/4ni2Jg0kVK79P+T/HEhMNBU+gYyu5DmOmNMArx710P42uon73zh3wXSBcMgEE8ZMkkCLhERy5oXhJM3TBNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB12752.jpnprd01.prod.outlook.com (2603:1096:604:33e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 11:25:19 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:25:19 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 35/85] pinctrl: renesas: rzg2l: Add function pointers for OEN register access
Date: Wed, 12 Mar 2025 12:22:12 +0100
Message-ID: <20250312112302.1605750-36-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB12752:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed1611b-8d23-4486-c9d8-08dd615891d9
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Nvpc+cn9CdF//AYh6adRVqrz2PFUj7g4Pg7fuafA9fOGUwEBB3bEadqgKHpN?=
 =?us-ascii?Q?C9FWRiTWThWhCq6XKa7wD6+7BJ7b0BH/y1zlddBCWoAu00wXl9ug0lWv9mFo?=
 =?us-ascii?Q?ZK4wHYoqpwgh//aZUDxtsagtK089/MIqiLQzwjnDmYf22Fy5oLfpr4vAj+HQ?=
 =?us-ascii?Q?HmCZbvnuuz5nNxVgPabqTts0sshrvsOPgc+SsJFTpPyfNAPBTrVTkyiID4rX?=
 =?us-ascii?Q?7Y993YroUlyVx8lvkbNI68WxcYOoUL1ue+Tu16oXkctKUgrSnDIMPpmfmyIK?=
 =?us-ascii?Q?A0gLTjiH+uNiV8LwuEN29DgCXDhgDiiX8DrPr2x8eCL98Bn4Hyjmbg/hzqX2?=
 =?us-ascii?Q?KezITTGfvc5jnDtVyvOARiYyrS9GrHERfH9s/P3FL9SOXsmxKeFW5wcmkC3j?=
 =?us-ascii?Q?kL90a6T/CTZ25kdtIbHZ8eZNxfOACeDlhBNJ6nQ2sG5d08p0mAZy9U2qvc+J?=
 =?us-ascii?Q?bAClrsAWVtbwZXuPnX75Oq87R+oBttO3gIPGyFOdpj62jLTYbxdBM/dTO02i?=
 =?us-ascii?Q?XZbuIM5c0QT97A6NOjWy5sZYMtWSae7QrhfThj56N1t0TQglOU9EPjZqgJRV?=
 =?us-ascii?Q?+BO3YI/FlGcB4vDRbPJWAH1ocenIMKUkGaEqtN50GqQ4bx/atr+W6rs3WqE8?=
 =?us-ascii?Q?dbXnZUIwwK8n2xJeuwHNfknEnh0LXNqCFOv5K0CRsvzkHwZ/woL4tIH/gQj7?=
 =?us-ascii?Q?LcGgI3gtIuFW8W4qLfcsS7gxpB666lpw2zoEnUVp/9xhwbv8IeJ3caWHpHzK?=
 =?us-ascii?Q?2Fp7TA80xmWodxf3b8f6m8pEpIdB1/FYigselZ/18gYcJS5jxHYx+HzT5CDV?=
 =?us-ascii?Q?YRZNEo+ZKj70qzXozQzr6QAK04ky5FWoztggwbmz4zelZzrDZ6xsva3tM5SY?=
 =?us-ascii?Q?q14uoXJMYS27anQT/DxOG0dR2sXXIHsbNUYygxUomEWEhwkQxAf/O7Exyaxl?=
 =?us-ascii?Q?IgS99GqFOv2r31bhZJl+1+OC8cxMLm+tfF+GthGY4J2WjNaX/8Iw6ZenE7Re?=
 =?us-ascii?Q?Phnv9zkJR0NzfNqxf/NJWWsNCijT0rnwQ+IHnl601lM0/LzgKrqpvxNvnHaf?=
 =?us-ascii?Q?2Jzx8hHdOTzHLlwyfb9/5MZbTmKxd0LnuTwbhxZR17zZ7slXgucWvalzK7JP?=
 =?us-ascii?Q?sgVZy3meliJz35JBykfNZSnLM3YigFjeasNaaELspaKSF4Af+jevC2tcLizV?=
 =?us-ascii?Q?Gceg67yOfqbusVQsvd+dSJhy5F2Dp5mtkPAbze9J1RFZmYw60orSrAI6n92k?=
 =?us-ascii?Q?W5a3ebIFGh+nnoqxsiyX/6C0Al3lg9P0weML8TD2FYf1+zjtmFTFrp7IW66e?=
 =?us-ascii?Q?FEK0Be1uKCe77Rc9DdaZw8lYrVe+ZAnIj87+kuXB2jAihwMMvX9QcRodHv4g?=
 =?us-ascii?Q?Qh7lCdlMAJlt4vgLvKh1UdbPpHoW/fX1ziqwa2tSJl9t9kOA/j3xNQCdcrQ/?=
 =?us-ascii?Q?BmiQqURduDjcPAU9npND40IrGUx7GmnG?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2ZuAJZHvS4foEANSwBWcjo5vVpLNnlfvHHNwPE4u/gocE7pU85VjW7qvPkIq?=
 =?us-ascii?Q?IcExNzeqzcoOkEcxftXjgy+swWCZErOKZmZgUqRh/54O+RaERS8vlvKs287G?=
 =?us-ascii?Q?HIfBdwMpE1dftjNwKA0wLSR6Jc/c+bjwJqtbfE+0uqxfJbELg06BxfwV46NN?=
 =?us-ascii?Q?uANIV7S6noj+BfA5pIKcGg6Jm22oiWBHkOlXh/zTBvJZEg2swZNQAUnmjw+a?=
 =?us-ascii?Q?kjbExXvUoiEgV6HCiV1Sj2H8wA0SHCLHX7vH0hX015491/JmSr7P50WrOp3d?=
 =?us-ascii?Q?oSqD/RlNLTtlPVlDxzKPL2hgiWdgQjTaBdHEHTq9NPCz0dpF62EJNKh7/C1g?=
 =?us-ascii?Q?aIoLE0tJmVnQJg9hqRKvpnVgsrtFOewVSPs6OGjqzjhRRYEDQjdyaUNEWG5f?=
 =?us-ascii?Q?nXo4GOQ74HHaE7cRdmxU8+Hm9YwqXk4KCd3DXd9+3p5ttspX8qEw3STtgyaN?=
 =?us-ascii?Q?wgueafWIr1fhh6K6PAVt0zTvqgNZfRoK+ZRARbQqjlmpFoBwV3JxxfKL1HPm?=
 =?us-ascii?Q?LGPFm+wI6vNQGzcBBJBdqVyIHoMUXpWQit1VtAxWs0MVGWFI/7DFp5sD0fwa?=
 =?us-ascii?Q?b42MTbYtOW5Dk47Febv2hcS10QNbeura8v8rID1FYMXjxo25Hylhxw8rpKHs?=
 =?us-ascii?Q?rjPXCHKoQInI8Ysc+GeUJwiOGgsKteuGrOyrijl0Ox2RUm9DqPH7mCWKmQfa?=
 =?us-ascii?Q?6FzCdy4peb8WKq/3GrmDApKqGjzWX0L6+CnkE7qC6HcBD8teB4Bp2ZCymz4E?=
 =?us-ascii?Q?cxwmJoyg+E8riZxrRrteAype28aztSa/MUD84LE1I/ZLgU0g/lw11Mm5voyv?=
 =?us-ascii?Q?g/Y4R+3E+4wyDZC1ZBDCcBZ3SddkwkOk6z8/Ue4MNcD3wU58i403hv92k7p7?=
 =?us-ascii?Q?oODgG2y1y4O9yT7KptiIztFH+OKDkVfgF6WbtMtaTFTPbV1AJAkxquZa0axm?=
 =?us-ascii?Q?tzaSERpq2V+Y7Uylb94YJHMAXrFoVHILqshgbONupBu/R7btGCOefSA9iOb5?=
 =?us-ascii?Q?7eMlG9cSnLxBoRXMLf6TR0WaZIBKxCy3Ha0M9knHDy4LUtPidvi16NfEC6yp?=
 =?us-ascii?Q?Wz5/9IqR8l6MJABO8t2dPi1EMDCp4RIhCvuLX8OCwHR9t99ZvBdQApk9Q8u0?=
 =?us-ascii?Q?Y00drTS0GvgNhuPn1U2+zmXL3XqsuO4iKftwPxhM0BR8TWbYJA7vl49p4w/U?=
 =?us-ascii?Q?xonEmxqusjofByDVVtGuZizGhNGP7q2nJ+xsZ0nWLllvCT0ziBtnoUSg2v42?=
 =?us-ascii?Q?uR2Ngw0poADRCM3kzlHAYbVoIYLkDUvLnr09c9I5908hxNoazVzLjHH2YywR?=
 =?us-ascii?Q?EjenrdG/t9D6kMTD0TGezXgBFgkBki4xJ6PZue9lVTC4KjAQKM6hdm+D69Cg?=
 =?us-ascii?Q?mTAUld2AM8VLEarjNu/CeIa+40ON06rZcKDlS3SCyJYPkM/vAP0wzrlbXbcR?=
 =?us-ascii?Q?zjwf4EjMV3Laz+Sn/QelOjKQsdYgJFtn3JFBYw69fByECSGPExHAKlKedl6S?=
 =?us-ascii?Q?W3byxFodxGB4xOVPYGOBJfegCLlD1I8tTo8IqZwdfqFRD4eFcW/jLmBDxJxd?=
 =?us-ascii?Q?voiZVIK1XwSK+2UVZDqGiqksikW/TBbux2Ee+KGF93hzXBT0JxbJ3NBPriSS?=
 =?us-ascii?Q?VVyvGQltg4Creq8FRiHQOws=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed1611b-8d23-4486-c9d8-08dd615891d9
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:25:18.9566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6JAu6XCxys/T/f3mZtdSsWixwc2th7a0i7WrylP9mK0sFkCNWXbH5J/lfqY/UD8xuENepyA29zLL2y2zMEkdzLidtp8h4max2CkWnACMr1eh76UsIbubi9YndBlQX7l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12752
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18127

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 7d566a4d270c52ffffd04b78b753bb3ce8cbb867 upstream.

Introduce function pointers oen_read() and oen_write(), in the struct
rzg2l_pinctrl_data to facilitate reading and writing to the PFC_OEN
register.  On the RZ/V2H(P) SoC, unlocking the PWPR.REGWE_B bit before
writing to the PFC_OEN register is necessary, and the PFC_OEN register
has more bits compared to the RZ/G2L family.  To handle these
differences between RZ/G2L and RZ/V2H(P) and to reuse the existing code
for RZ/V2H(P), these function pointers are introduced.

Additionally, populate these function pointers with appropriate data for
existing SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Link: https://lore.kernel.org/r/20240530173857.164073-10-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 947fcd39b168..430a7638a9d3 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -254,6 +254,8 @@ struct rzg2l_pinctrl_data {
 	unsigned int n_variable_pin_cfg;
 	void (*pwpr_pfc_lock_unlock)(struct rzg2l_pinctrl *pctrl, bool lock);
 	void (*pmc_writeb)(struct rzg2l_pinctrl *pctrl, u8 val, u16 offset);
+	u32 (*oen_read)(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pin=
);
+	int (*oen_write)(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pi=
n, u8 oen);
 };
=20
 /**
@@ -1035,7 +1037,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_d=
ev *pctldev,
 		break;
=20
 	case PIN_CONFIG_OUTPUT_ENABLE:
-		arg =3D rzg2l_read_oen(pctrl, cfg, _pin, bit);
+		arg =3D pctrl->data->oen_read(pctrl, cfg, _pin, bit);
 		if (!arg)
 			return -EINVAL;
 		break;
@@ -1144,7 +1146,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_d=
ev *pctldev,
=20
 		case PIN_CONFIG_OUTPUT_ENABLE:
 			arg =3D pinconf_to_config_argument(_configs[i]);
-			ret =3D rzg2l_write_oen(pctrl, cfg, _pin, bit, !!arg);
+			ret =3D pctrl->data->oen_write(pctrl, cfg, _pin, bit, !!arg);
 			if (ret)
 				return ret;
 			break;
@@ -2623,6 +2625,8 @@ static struct rzg2l_pinctrl_data r9a07g043_data =3D {
 #endif
 	.pwpr_pfc_lock_unlock =3D &rzg2l_pwpr_pfc_lock_unlock,
 	.pmc_writeb =3D &rzg2l_pmc_writeb,
+	.oen_read =3D &rzg2l_read_oen,
+	.oen_write =3D &rzg2l_write_oen,
 };
=20
 static struct rzg2l_pinctrl_data r9a07g044_data =3D {
@@ -2636,6 +2640,8 @@ static struct rzg2l_pinctrl_data r9a07g044_data =3D {
 	.hwcfg =3D &rzg2l_hwcfg,
 	.pwpr_pfc_lock_unlock =3D &rzg2l_pwpr_pfc_lock_unlock,
 	.pmc_writeb =3D &rzg2l_pmc_writeb,
+	.oen_read =3D &rzg2l_read_oen,
+	.oen_write =3D &rzg2l_write_oen,
 };
=20
 static struct rzg2l_pinctrl_data r9a08g045_data =3D {
@@ -2648,6 +2654,8 @@ static struct rzg2l_pinctrl_data r9a08g045_data =3D {
 	.hwcfg =3D &rzg3s_hwcfg,
 	.pwpr_pfc_lock_unlock =3D &rzg2l_pwpr_pfc_lock_unlock,
 	.pmc_writeb =3D &rzg2l_pmc_writeb,
+	.oen_read =3D &rzg2l_read_oen,
+	.oen_write =3D &rzg2l_write_oen,
 };
=20
 static const struct of_device_id rzg2l_pinctrl_of_table[] =3D {
--=20
2.43.0


