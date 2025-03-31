Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACD2C3600C
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:46:21 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.69])
 by mx.groups.io with SMTP id smtpd.web10.49060.1743417975425535079
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:46:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=dEvUxjM7;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.69, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPhDnDTqgfJWZ//qlCrhWZI1BpO6WToQ3mzdhcTfnkcgoxpN38nKhpBHOS5nOKs+aQHhO05XBYzZ62QhrQ0RacFlB75Cgucz/VEMUZKUW2nFKaW0Njd/45bJhYtT1Eeoc6UUu4QnwKFTzW09lcse5euWnoOBR0mnmRtSQ2YqF9fv6ur+EMV+nP91uuKgT1X45vHzcaUPHz/K6AM06L460gsXyV0CCAcb1zEcXAWJbn7BNWgKf46LYSNXza6VQeaEVhn8P6BQOJZ3b37+Ona27+DCrEIIYANYkVeXA+sseescGIY73Y/BBKRgF65AwwT4QnKmx8YZHLvoS1PhZj41gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iM99AvQnh5R/wbCFRc67HaBSCYqoyM23b4nTsnu+8w4=;
 b=hVsV3lGljJWYvtC3ETugkg7qq2f/boiZlCg8noFXDHcgJ8p0/V8TE5Dc1Mv+fRskUrfstffVVaLcELOf5LThb6A5RW6IT0xEb32Lyw+0YNzg9F36oI+6zQIXXROlNCWQWOvoUUb+yFJUyzQ/L8EQQeCtgZCMBpKcws+6aY4CAIJW/2pKOCr4sBTAta6PRZ6sxmgTuqoYcU5GgRRDO3HMBO166ykYGegSrBGswnLvIgIJwyOPY3/xNhhwqzdk77F0FTr5KdPh0ph40WRq/rZPS0M2a0DOcwm1swuvA5IftWHss5mnmiwaFmy5x2wDTc68HEUWRxXwCPDODptqNHncPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iM99AvQnh5R/wbCFRc67HaBSCYqoyM23b4nTsnu+8w4=;
 b=dEvUxjM7NA1DRfX9pbewvGuJF4I/m7DBjZi1YIuS/zCrJk0Qu3j+WxoBdozBEBvVEnCVIFl5qtzdocMKuhOh9ufm63R0RlUzYgH0GpDQEn+kJ+0uGBkbLEsngkFzYmM5KvLzD0+h7/PBNNeHSyfxdykfOlT1eNd2Yu2SXbnT0JA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYCPR01MB9796.jpnprd01.prod.outlook.com (2603:1096:400:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 10:46:13 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:46:13 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 14/43] pinctrl: renesas: rzg2l: Add support to configure slew-rate
Date: Mon, 31 Mar 2025 12:44:45 +0200
Message-ID: <20250331104514.79090-15-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 26e4a47e-6fc5-43af-6bf3-08dd7041418a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?eq/koqHMhvD9+2KV4vwQx8mG/pgLfUoWLgBFCRdGgvC4d6sZM/ypLUomDQFo?=
 =?us-ascii?Q?8REnmj/YqE9MO6C1lepPNXOTOcz8n4x4X9wPZrIxltbuNT0mX7nYEcOIO5yE?=
 =?us-ascii?Q?S5eM0F+pQvCV9eZZM0OlFkUDcRDsHueQtiNAp8oHAaj5yl7bJk11HkjdMUNm?=
 =?us-ascii?Q?JQpBJXTBbcYYfLqoK00+YoCgQoqr94qz54o0OsVZnV1DeMskgZ/Zia6CDrEr?=
 =?us-ascii?Q?T5A2SIQpWYVI1Pl7aH2bO6u7weoWiXdibTrlx5iu5n7uTcOhjpBAejK8XmZ3?=
 =?us-ascii?Q?sP7NqspuglfaZzl0xsfC7uODoOfERFi2jV7m11aystMVr9O5wfJ8yge74ynk?=
 =?us-ascii?Q?0kTMTj21R5Xxfsig+mBA/sd5gXl/ygfyq9+UryYum2VEKpryrokoX5Ptebj5?=
 =?us-ascii?Q?NezBJQ0U5jpOq8s98F/PW7ljN0NWWje7gBdfG1oqegValcniLFQIWAVuveYu?=
 =?us-ascii?Q?ILZ/tL3lM2erYYSgChJ7xxH0IVjP2otwPyQLg7GnmOSlHpOios7y/l7g6BkV?=
 =?us-ascii?Q?WeakRVGMIzm32unMsz4s+JppqgfDYO7kSlmpLdo3E4BNIzEyXj5twUwicP6/?=
 =?us-ascii?Q?Odq2pDHf9D2SHzcFy4OypQNTIs9xpCogvbfvhYulPe/zYcWWLtATCkQztasG?=
 =?us-ascii?Q?jIvrWe3kvpekEOXeFBeImiE4Z4npyaf17lQ0My17sg8saoQyVBt1VrLfA6P+?=
 =?us-ascii?Q?m0TWvot0B/JbBVgemr/eI/B7EhRl6ksubU+JNfaJmVFj/KMqDLNC0ZtOEpFO?=
 =?us-ascii?Q?j+ztRZl6tC4o/SyBeZN0JpYlUcCh5XHHsjlvuACiJoRA/1F4DF8x68RWELJB?=
 =?us-ascii?Q?TVwZZcQYS+CQVGMtQUhiqXu2kyGRJzKrNvK9qjWIOK/BCzOE1wSNOyPNNtBZ?=
 =?us-ascii?Q?Fd5nQWMMTBMN017hpGBB1pEZyzX7XFF3IxfJY7zt/b1qKRtrlBPFYwqJ/XYN?=
 =?us-ascii?Q?R5qQdNvIjKac9qY4qrGp1SIUs6kUxa/qRyVUaLQPWmnjCz1I8ZQl3ijTgUxM?=
 =?us-ascii?Q?S1Z9j++s6sWPsCRkr5JAZoSvu1qaAa42oUubDJgwkId99m5pW8YQ3mUt3XYv?=
 =?us-ascii?Q?Kojvke1bcX2CEnH4yVVboeICoVzBO33z49ATaYen4QjkY+dtmlWwjKF3A6g4?=
 =?us-ascii?Q?KHBPGWVSy0PnMcTLB7mYtU7ba46u9wFtuxnLHsIdbE6jy2ZiqrdYVLKH6+NV?=
 =?us-ascii?Q?BDTyeX7H4gu3d8snbtfT+yfesUm35kfNWtC40hr4g/j6I2EYZcC2S7TwZKY0?=
 =?us-ascii?Q?VFgbvGX4pRYCQLEk2dn1ZpP/2d5WZgqVVjsnMOnuHZ/TjHbB/CXHx5MFFfMC?=
 =?us-ascii?Q?qHZNlsxwkR9UY2s7f1R5PJIdn0X6sy6yB+X+vPF5RGJKz6NM0qSIVVQl08zg?=
 =?us-ascii?Q?qGzzNhMo68GXzDGCWFw1jZAZeMnj2ZPbNrWSj3UO/K9ZCX6e7UAbvEmIJiiS?=
 =?us-ascii?Q?BephdAIh6xDZJzDZrYrnSujSuG7s95QY?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vOrwAyph4I3hoG6NMFXBjjiMqJRIH16P9iN26bBSM1npFADzxN3S5ZXNAzt1?=
 =?us-ascii?Q?E5x9qwquqkLxfEJlIbyyzMG13DNNZ24yvMSRXdykExJj5D9X8mWpapjv+QcK?=
 =?us-ascii?Q?3xkOlfIq6u/FBWIYQBtqfJWAEIba0eH3M9y+1C4GXAz5q2priKwFxlrYH+nc?=
 =?us-ascii?Q?msg57WoctIG7Vj6cQSVhr/sedI8TJczvpKqr2woTdpUQqjMw+5yvVUAwkhSb?=
 =?us-ascii?Q?cOz5x0XHWv4SCfC59jYXQjyJobypu8AWOJPhKS+jOAemwmqBO/Rru/BJ2bEG?=
 =?us-ascii?Q?kh3GEe3Go7jblSJxBM19ntxrIte80OU5vY5e+DW/8qvaJAS1c6jSL5iBKMzN?=
 =?us-ascii?Q?TBrN6C7h+paUuSUuDRxhudT/XtdJV6fqW9ElHslqOcarRmJOwLWWy4MvS6A7?=
 =?us-ascii?Q?CUWauRVp0H/FuOcBAisF0DmwKGkbdg9EKY5iI3P1rrhbYDSniWtPPntHj1Ge?=
 =?us-ascii?Q?j8QZ+x4L/L4ujp6xz3eAyuJPNWGPfwEfjUXCIWYW3GMuXJMhPedCWmCTyvRp?=
 =?us-ascii?Q?79RWsj0oe12CNgk3QM6jEx76u+MXgOE3n3AWaK26H/W0khoy6H5ThjxVxApM?=
 =?us-ascii?Q?0HijoFi7FgMRdUzgJQs/4joptdOVIVx9ROViQphO5GqK3q6kYQSuDu6hucX9?=
 =?us-ascii?Q?KpOULqZlC54SwKTUOmAN4sQpLhEHkFk6CRnnVtJUGpit7+G33rSm4Ysgb7Vk?=
 =?us-ascii?Q?e8t4vwDGkF7EWSTLVDA2z6R53E6WV2sPx8RUnKHCxYonPZ4cqMqKP7xneiTh?=
 =?us-ascii?Q?kjG/hOg3kShZnvmAfOtd7BOnueah7Y1CIoFlelyHb4chln4D3LO0fGlvNhOR?=
 =?us-ascii?Q?+hA4FsGyLVXMbawpzKq9aUx093frm+bY/hpA5c2nQ4OXq743qL7xS/hw+5DU?=
 =?us-ascii?Q?LlOlzTU/ATa5Nt8FeR95exGIOcJfVGYs16AE3AAIhsCdAP9WSGH3itOTi7j6?=
 =?us-ascii?Q?y6wjTNktJtcDZBY8+KytZvd2hsJip2It9nbS3Po6Dh4dRVnBkuKkXEdHZg3M?=
 =?us-ascii?Q?deh4Rn9hl1rkDBaBWWZUKQVnKrlt5XNiWXX4k5ac6WMnfIJMiZEaDcx3d5D9?=
 =?us-ascii?Q?wy4fDRdmU/XcFiNmbkYouAMaC0DPe12Bg7QqGuSN3gyVltAvNk+bG886H2n7?=
 =?us-ascii?Q?oJ+CE1xWk5SMbQFlblT677vqrwXDVzSZqawMgm3zwu0KH8TECA0e03ffolRs?=
 =?us-ascii?Q?4QINa5KXgbPeswTaGLfJvh7hKRf1VCJFSyyLfdS0WGHGZG4yMRPXQ7/P4f5J?=
 =?us-ascii?Q?1y7+lZu1tR4o653p8SsPMQfOyPgUKtpml69f51fOc1aH1fEafkYWX0rrBGq8?=
 =?us-ascii?Q?W3oQLVQfgsxU1ZBlz4bvHpABs7V9qJ4Z+Iz60Sg+2jhSVV3n8X0jwDyFwBIn?=
 =?us-ascii?Q?XpoYkqV4jUczHOVMrm+eKWCuDaNgoAbGmHqRtOiLe9pYWfeuDu2N6bDD/WJj?=
 =?us-ascii?Q?0xtcKtcnS9KMyVxkC6UwTkjZoKAkNRuL2QJ3cDxDtBssZtuq7lodtkr/27pw?=
 =?us-ascii?Q?XpuCfcdyWl665n7TFXi6op9CvafEu6tOnxg84M/XvTVmupt2flrFKsqFG7sb?=
 =?us-ascii?Q?7rftgHuMREqzHwMCdqXGWb74+KZ2KByDXsv89Ej+OwaIq3WaKGvy2Usf6C8+?=
 =?us-ascii?Q?77nmUDwNTdQf2m86UTfyVqc=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e4a47e-6fc5-43af-6bf3-08dd7041418a
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:46:13.4744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7EJjP5HRotxkU3ccyoD2wVhAbvyqIqp0a1LqDo71xSezqvWPXq5L10wZBvKTORqPsZBvQ5OSqyz7sx5mw169Xt/0Lug1gGZeWqeZKXJaGfs/v6NTJXLNhZ1uuohtt8S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9796
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:46:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18402

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit b588b53b2c474bdebbac0a663e0a6a0390db2fdf upstream.

Add support to configure slew-rate property of the pin.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240530173857.164073-11-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 430a7638a9d39..596e101f5b2d4 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -126,6 +126,7 @@
 #define PFC(off)		(0x0400 + (off) * 4)
 #define PIN(off)		(0x0800 + (off))
 #define IOLH(off)		(0x1000 + (off) * 8)
+#define SR(off)			(0x1400 + (off) * 8)
 #define IEN(off)		(0x1800 + (off) * 8)
 #define ISEL(off)		(0x2C00 + (off) * 8)
 #define SD_CH(off, ch)		((off) + (ch) * 4)
@@ -144,6 +145,7 @@
 #define PFC_MASK		0x07
 #define IEN_MASK		0x01
 #define IOLH_MASK		0x03
+#define SR_MASK			0x01
=20
 #define PM_INPUT		0x1
 #define PM_OUTPUT		0x2
@@ -1049,6 +1051,13 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_=
dev *pctldev,
 		arg =3D ret;
 		break;
=20
+	case PIN_CONFIG_SLEW_RATE:
+		if (!(cfg & PIN_CFG_SR))
+			return -EINVAL;
+
+		arg =3D rzg2l_read_pin_config(pctrl, SR(off), bit, SR_MASK);
+		break;
+
 	case PIN_CONFIG_DRIVE_STRENGTH: {
 		unsigned int index;
=20
@@ -1155,6 +1164,15 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_=
dev *pctldev,
 			settings.power_source =3D pinconf_to_config_argument(_configs[i]);
 			break;
=20
+		case PIN_CONFIG_SLEW_RATE:
+			arg =3D pinconf_to_config_argument(_configs[i]);
+
+			if (!(cfg & PIN_CFG_SR) || arg > 1)
+				return -EINVAL;
+
+			rzg2l_rmw_pin_config(pctrl, SR(off), bit, SR_MASK, arg);
+			break;
+
 		case PIN_CONFIG_DRIVE_STRENGTH:
 			arg =3D pinconf_to_config_argument(_configs[i]);
=20
--=20
2.43.0


