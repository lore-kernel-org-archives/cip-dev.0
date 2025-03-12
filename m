Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37D8C28B30
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:15 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.64])
 by mx.groups.io with SMTP id smtpd.web10.34467.1741778741795642098
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:25:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=O+mTu1aV;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.64, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5gFxSMXnc4q6qESJSaOo6QN0U63NaJZDFRebicRMaJIzMBGY53F/FzzVke2slx9iBryPrasdZPZmmDtlvMEMwpa/GGK9g8TSl+Y3eVgV3EN28hTTFLBdKUyv9+77eydfnPoILhEjT3ecT+FqeT6azGRYIBbEsIwgdmkt9LiuoV/mRx+4mSkYTSokcumMF67q2kfQvw2md3GihbjHMAnkQuhScRu+Y+2KN5jsCx496vRTySMxnCJuZDeDqmvFHDyzGk7vfzAWh7mgNNgFJ66063/NsIxeN2YZljr4PNFSSV1ZLETzIxHeLvq7wHp1smdB09+4ZFOTwhN/rj7Uhf4Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86+Y49fkaXZNuuXXV8G1rtFwIvOMoMIj4z5vOr0wuxg=;
 b=S54ckcF2njQIRJvutD47H+mX6VVa4X33GLofQmbg9MeaXWRy/HfrW6uUclixIgHnPXoSOqbzCd/A+u9CwtY3NrO7/OP72FToIbpOjaL+TUHiLfyRIFKeMPn2RGUx9939PJWVOFcU7QC5NieYGVdI5TjqGTPas24ky0R5KmV7xr45fjiv/+Cdx78Se7rycl1C1dtQd9TllXkZqX0aZX4dGHD2veHZX2vGc18M/0OMsq04fqbcfF/fQT0R7V5WEYy80KNQvvY1cWQ4oGCqc8zSPIsQQ+g/LJlRnsRuJe76tJLyhjroRWPKVbuMgdjsyCjK3qr0Fd0JNI+cGbuq+6m4fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86+Y49fkaXZNuuXXV8G1rtFwIvOMoMIj4z5vOr0wuxg=;
 b=O+mTu1aVL3Uu1ZhLSmZHIE4NHa5QOKhDLRBAvq3Mz647KrjQJK/PUMqO3G38EtC0f/v3MLzGJtoP/e1RL+yuxWaurdWO5W9RygHYTUnY3hXaXQpwKAFawbQplaoa6YHTVrUGDChlaN2/Fl+nlmG4Z74ju5943JUCddlnNGhen0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYWPR01MB10982.jpnprd01.prod.outlook.com (2603:1096:400:397::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:25:39 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:25:39 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 42/85] pinctrl: renesas: rzg2l: Update PIN_CFG_MASK() macro to be 32-bit wide
Date: Wed, 12 Mar 2025 12:22:19 +0100
Message-ID: <20250312112302.1605750-43-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYWPR01MB10982:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed4f984-470d-4e55-9559-08dd61589e06
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?PFcyZ9Gr1uqK7+ZkfUUUEuYR3xZiA1j/HBPfpqcTJlcFb7iQc8WEBlUlTFW0?=
 =?us-ascii?Q?iXWZ1x8MM6yi2u4BPW6PuQ/9ojhlRq+qyLgsHfbLndsvb0YtQl0BtWMm9M+d?=
 =?us-ascii?Q?J7czKqomq+1QpWiSZAqImEy8RtjbuPEzshAZJMMl0O56uxKNT3e3CIvnk1Zg?=
 =?us-ascii?Q?OZNpg9ddG1WqcnMeG3YAqUh1gpqTtaaIuB172KsIjt5c4sGyfovGUlIZ+++P?=
 =?us-ascii?Q?qFjXHSrnIE+C+ZRzElsf3GGyf4tpRGLt0muJ2r+BWbIheEs11YU6NX7+2sUC?=
 =?us-ascii?Q?n7qJ+vvsqOINnghTKrM44VDP9ESnqK6y/TD7XR5dqXoc9ATRvrmMt3WNm39y?=
 =?us-ascii?Q?HZGsXEEmczBqaIVaeoITD+s9MQRL4DZSa6a7nWhMTPK1TBxWduAqmx1su0Mi?=
 =?us-ascii?Q?3ElASvM6eUYLCW8O26oByE2dXSpqk4XQE3TbTHCIu/ynMWFpxgzQaXQj1UY5?=
 =?us-ascii?Q?LYmZ2NLpEw81PLwNfXlvUKnDs8fqp1/20C7DQSVUzEX1ju+vlZMdvucoqs/f?=
 =?us-ascii?Q?bdloG5wrZ1lgoy3sFJeiPgJdWVPKj90frP9eVsKTPU44nIx6D/0FKVhgRGa8?=
 =?us-ascii?Q?HYDrwC4Ki1t4om0fSfor2enHoMV0Gd1HCMWcSR4giA+ypy2K5QDlQSX71H/9?=
 =?us-ascii?Q?R9k7dNGGdP2YqD3kV87+SuJ5Zg/m8Yfa7s5fcN4JUoflSWeG9xieuOjuVLKu?=
 =?us-ascii?Q?3/mck87HS3FSUnsnn5qeTvjCl+8PehMWgLWoX39Cwg5ADCM96u03QmR1YIZj?=
 =?us-ascii?Q?9ea8+E5ld8J/E72DQSmdokG4vQNbjElhnbxoueCXs8ibkcoa7A9Nme6CJhn4?=
 =?us-ascii?Q?xZDm9HwpDbBT8oH0m75AH9E71ipdmm6z0LgbJn8dytdcj1nJ0qZHj4YYMJRC?=
 =?us-ascii?Q?vgU1LY+nHbY3YvldKXMviIVxuaspzHO3wKq5VQq3XNiKms1uRnaYbLL7OyFs?=
 =?us-ascii?Q?GBCevD7yVSHBlnKpqOO07Y2ugcuii1cmmVbhIQYtDjTMBp6Ml1qHUD4svrZo?=
 =?us-ascii?Q?x1ro2dDAEy6FbbYqey9i03g2s0tjKjAxWbV4ZH5KApesqqyjp2ZtYElerL2t?=
 =?us-ascii?Q?w5bvAHCsDV+S3/Oet46E9HgMS5gSd3EA73l6h0iOFLGndjFQeQK9AbD4mjW9?=
 =?us-ascii?Q?FGeOcREZoswb8s4sLmdPEZsMlOSpkRCloZ7tAI5CjYntYwMp6OeDWDZUajZR?=
 =?us-ascii?Q?cygZ4pNpBYwmsSzcAxw/aP9v7+LThpJCa5QSHThndG/DlBr1ac2zoJ0I66Yh?=
 =?us-ascii?Q?3Sqo54u/sTnqUhyH8ILSuXhj8w9VD+UWwVBwLq0EH5i0pYKAS06D4vtztrQg?=
 =?us-ascii?Q?iMwjcBRELA/gWj5KqiSrQ4K9RFhwCZRTeaXJQcs6Mz0AemhNre7lPxXJWTBE?=
 =?us-ascii?Q?WabhP9giccqsSTOv9wOJkpZBtWlqj+3M4H97i7NA1oZIQ7ezHbcNUCv7+UWJ?=
 =?us-ascii?Q?CoeewBzdtsS3mVZtqtebtKZhkK0g+ygY?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bIeJ5GXdAbOxZC867ORr/MK12BEP7g0MFH12V+uVI08dWHhWYk0OUAsapJ/N?=
 =?us-ascii?Q?cn2Qd7xdR42aD/mNQUkRi1502A1vnJjHKJEOdCAlnyrCFGf3VIAMVLWXIWvD?=
 =?us-ascii?Q?cvC1NkT52rRavKyQ0zfPph+gc7UD+oCbrKAaQD+OgvHk4UrEZg/qr9n6CzCY?=
 =?us-ascii?Q?IE2xdEXnOiGf5QTevvd+GTvTQFQePZ6fVQO8WMbTaR0G6jjbLQDEPtUz9wj6?=
 =?us-ascii?Q?TAtuAPUo08MOXaTH0lQAgNK2I+CgjUONmJ+A+ZMrqo/3IPmciKydc4Vn32yp?=
 =?us-ascii?Q?Er7H/om0lMzauJK8fk55y26+OS998A2bhKvc6HtT92lndzTept0ULRie1oae?=
 =?us-ascii?Q?hNK1aUhFNZs+SJBasMaym1b82vPVssYSLfvTblvNohlIYKS+nW5Ynv/VV0+w?=
 =?us-ascii?Q?uOzotgX9tesRRUNAvT9zwz0BZGC1drCwWcRuQHGMLV1FB1GJxUYXoIb5iSJm?=
 =?us-ascii?Q?cxmoSgsjO3oz5DOI6FVQLhYd9gBLFKHqMQBhNX/6SE9jTBVpqudXtDiEp4Ue?=
 =?us-ascii?Q?xYfyJ9qJpE1/oH8Im+ADmRij939yTuxNfrQlEQY9EUjE0h008GchQief8NRu?=
 =?us-ascii?Q?eDCMp9SI8Q7JJldJjYYsND2ixu7pdfmLmNcCUcUN0Fe7HS2fYgHufVSJWjV/?=
 =?us-ascii?Q?EGbOkkc7M6aRbXrtEYdFdz536QzlFyIDrIkFcJhzfVtNfJRhoRJWsgtt4xYV?=
 =?us-ascii?Q?io343mXUmOkWfr9tlTS4SvKdxl8FqgExrkmES/ngsNDe5xXySh2AgLqg98bK?=
 =?us-ascii?Q?GQQckmmd6Hy29muDB1DGCbbno8dGMIgT/JZhUEuK5NZhizwgCUFBVCfR8mv9?=
 =?us-ascii?Q?POOp25KpKK6lY4pYiXJYVsmDWAloJ34DP5bZi62DeXrw/1luF5+tP/v8L0b1?=
 =?us-ascii?Q?/yhMbO2FbLLNka3dn7j967keq7T1u92mVcSHCGZ5IiEc+9vOtxRAUmAUIcbj?=
 =?us-ascii?Q?++evov6Rbi8Mqy1eTt3HQNDp2Qdirw9DnDXasgqQbnLtMCeTFrGRPEL/PfKM?=
 =?us-ascii?Q?ypqwrePyhdi36o6vS9KOVYChvcKbylNfU+Hum3blMfQPlWxgldE1vkMnaKye?=
 =?us-ascii?Q?hwMhjXdeHb4DJdF7LUYS8LHhEkB7R3gQ/uJ4ZAgsJkcie50G43m82j8NG617?=
 =?us-ascii?Q?y8OW1ShJJngfSO5iqcCCCOKI2vVyBaq47ljEw537oYaCE8Z+DF5vLrV69pEF?=
 =?us-ascii?Q?YLTG6IqUbbTryAVMWnYiQWnM5REoqn8WbuFFJLZgxpe/IFCtkP3qGp/OMxqy?=
 =?us-ascii?Q?C/jHpBeJ42KAe+3svJkm0kgy7nSnKCn01a/VT1iw9/XTfjb6sM2+Fv8hHMqe?=
 =?us-ascii?Q?yoMWdVAOVAfNLvEjyyakpt7qpsupxtF0KBQgScN/1284O+Dxd5jr3CAgyvyA?=
 =?us-ascii?Q?MKM/kkppP5jBCvEOpmjjKOSK5wBrD6sjbOEGZIJrZ+wfVnNAaW4nHmHPtvIo?=
 =?us-ascii?Q?euvy7eRXn4Y3x9jYCXkgMPQLLhxMpNA3VkohzjkpLejP2M2kS4AAEFDjWXU9?=
 =?us-ascii?Q?swG9mE//NexGfVU25q1uGukXc3qF+rBOsrb55VDyaADxbLbwnYlS/YwRmdnw?=
 =?us-ascii?Q?QIAqOtIjXqYNwa7ocDtDpf7H6JFliVdsTvGFIniIvWij3Tt0tRncihQ6hxtJ?=
 =?us-ascii?Q?LVgGZyyVo4b9LnNvLP1ImbE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed4f984-470d-4e55-9559-08dd61589e06
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:25:39.6176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcFpE7FzSM/KaZlsDgYXn4OQsqHRUJwFM9DDjsJGPwg+NWrzt3S/4imbL+t47ZDMth7EhHcBOs4+RNm8UQYPe9o2xLrfnA/9MUctWeycTD25vleRxcLeuS1WM6r+6MUZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10982
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18134

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 0a5e40f9c29756dec3da573edce3f4b3194e6f91 upstream.

Modify the `PIN_CFG_MASK()` macro to be 32-bit wide. The current maximum
value for `PIN_CFG_*` is `BIT(21)`, which fits within a 32-bit mask.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20240618174831.415583-2-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 8c29c8d3c574..b4ad4a4d2046 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -88,7 +88,7 @@
=20
 #define PIN_CFG_PIN_MAP_MASK		GENMASK_ULL(62, 55)
 #define PIN_CFG_PIN_REG_MASK		GENMASK_ULL(54, 47)
-#define PIN_CFG_MASK			GENMASK_ULL(46, 0)
+#define PIN_CFG_MASK			GENMASK_ULL(31, 0)
=20
 /*
  * m indicates the bitmap of supported pins, a is the register index
@@ -1187,7 +1187,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_d=
ev *pctldev,
 	u64 *pin_data =3D pin->drv_data;
 	unsigned int arg =3D 0;
 	u32 off;
-	u64 cfg;
+	u32 cfg;
 	int ret;
 	u8 bit;
=20
@@ -1322,7 +1322,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_d=
ev *pctldev,
 	u64 *pin_data =3D pin->drv_data;
 	unsigned int i, arg, index;
 	u32 off, param;
-	u64 cfg;
+	u32 cfg;
 	int ret;
 	u8 bit;
=20
@@ -2755,9 +2755,9 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_=
pinctrl *pctrl, bool suspen
=20
 	for (u32 port =3D 0; port < nports; port++) {
 		bool has_iolh, has_ien;
-		u64 cfg, caps;
+		u32 off, caps;
 		u8 pincnt;
-		u32 off;
+		u64 cfg;
=20
 		cfg =3D pctrl->data->port_pin_configs[port];
 		off =3D RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg);
@@ -2801,7 +2801,7 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_=
pinctrl *pctrl, bool suspen
 static void rzg2l_pinctrl_pm_setup_dedicated_regs(struct rzg2l_pinctrl *pc=
trl, bool suspend)
 {
 	struct rzg2l_pinctrl_reg_cache *cache =3D pctrl->dedicated_cache;
-	u64 caps;
+	u32 caps;
 	u32 i;
=20
 	/*
--=20
2.43.0


