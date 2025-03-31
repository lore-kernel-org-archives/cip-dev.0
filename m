Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E42C3600B
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:47:41 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.58])
 by mx.groups.io with SMTP id smtpd.web10.49099.1743418053531490893
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:47:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=N/koP9oF;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.58, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGIfxj4pxKjRZ6TLLj3u4iVCek0Ds+xN081R0F+a7wDNSLjTMBfDFUhH3h7Ogq+/C9DLvtg6cUyLfB4i5slT3B4BPV7yJGLQ2YoqnkwK5S2d+seZQQ3rdY2IaieBXaNGGNHPDMWp4pPtYOIf8Vwz8vh9nQNhKdpvrCQqpCDev+EMMTJDETC6QaHtMjKNG5ZI3vhW8lit9NcYIB0z7Afu4rP7IIqn6XlWcN6NlD7Tq/ty3zWYwJubekgzGVwSSJMTs7sa+mCVXXBJhEuPV+vxA5+kfILAXii6ws9dBDklzMcx31lLi4tn4oasImmY1w2pcTB6/hytfzcEsKHZJUhWHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfuDy4HR9wSPuUlsjaC6QUhOScXXmubm98+2136OEq4=;
 b=CcN+KmfjlGRIHZZKA315NyqRuPKH0IHcQX//Vie/US5puxkNgqqpBVbZirG8nl6YKaBR1F37CQYUwlioC750A33kb02c+u7LbZ5qhk6VFyt8ZrjJEVkpV4/igKvkS1r7hqf56L+kAsCVNQCgZDCSyyIDV/jokFpBfALO6waUag1C4UuaatUoCTlYi0wJXOeqiq8YZD/oGHyXy3Ia4Pntj5uvR2fV1pb0ds4xUSOuqygshU3N0hYmpx+/q9ZIx+9629pKDKE4c+JlihTrHVE/azFjGxpGyUEDEnZt8xTyhsc2r10WMn7SQ7gqmiK+O9rs53YzRtv+KMVCTXYDILTq5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfuDy4HR9wSPuUlsjaC6QUhOScXXmubm98+2136OEq4=;
 b=N/koP9oFe7F5t81NqvS46JpFS60X+Mc/iQdrPX3I61xPFAh/Kc+6Sg80Ne1EeRSArHWd2vO2cZW/Ffi9jKWfNJwgorVMMRne6hrB0u4i+oPdUmtbw3ARU/CFy13lq1tuhlRYcowEZTCOIdZpzq7FZ0uZs2tcKMgxF4hGZJOlcsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY7PR01MB13744.jpnprd01.prod.outlook.com (2603:1096:405:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.33; Mon, 31 Mar
 2025 10:47:31 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:47:31 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 40/43] pinctrl: renesas: rzg2l: Add support for RZ/G3E SoC
Date: Mon, 31 Mar 2025 12:45:11 +0200
Message-ID: <20250331104514.79090-41-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4ff27c33-4d34-43d3-9827-08dd70417020
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Kcs5KxT5OWcPVWngNx0UQy9ckAYyJiVbmWPJYILfVK8Y/UNJV/03GZtFiyXE?=
 =?us-ascii?Q?E7nyps8kWFOZtad4B2qy5ogGX8KVtJN+I7lp9qYLiIR5m6EKCVHDSBL2c9Jv?=
 =?us-ascii?Q?Ct9el+4aUpo4MrydSH38kOh93yQfWxZvxp5AZao8hqJkz17LbPy74iOVpz0b?=
 =?us-ascii?Q?FuOuzUOvIK0o8XpRBbdvb2K5Cm+6HV9jPrX06btbgXs/IH7ZmupE1aO/LRki?=
 =?us-ascii?Q?894JjVIvKgqT7lEbpADJCLhU5CXUlhvLxFZVorB+rhly0Wo6t28z8XCXsqTK?=
 =?us-ascii?Q?3W1ic5qPpgrXaTABi+jm4dcRseBfDUmF4H2hheEwqpM2YQ35cXG4vaTlpwXu?=
 =?us-ascii?Q?RfBiu+MvPF/Tz56tAw+s2lQNuj55Qzr8UbvwkzWQRWbJrxqckafOI50/TCUv?=
 =?us-ascii?Q?DVNK4j4ZEJ3I8nZZxrYwJ2bUYuNJnWFkLXfvHRRXmDcG972CSdPT5ZD+vZmT?=
 =?us-ascii?Q?BJ/E64McmWVlS0NMI0DdRjhNPvv3YwUK9C8KieFSpZ1zBeUnpWdAzk3gc9A3?=
 =?us-ascii?Q?VMbe2vNmD+f0G8yrH/XGJ5mBWf2OXTjZnIygKnrnu+Bj/3cgLqnhMm6w933w?=
 =?us-ascii?Q?ODdPJll/J5MJnPK5kQLht6YQCcMDFKTZvIug8n6eun8J/gJIOCmIjSsSPfXL?=
 =?us-ascii?Q?6ADjxn355cQxkFrT6SGeUbAY1uWmdF1+za2filhLcbfG4rABJueorL8tpIbI?=
 =?us-ascii?Q?X8xaEHQ0Qf1as5Ij6AYAW+ZdQiaUGeIAa/8eC188ajJalElYjLOG4ZIwfh03?=
 =?us-ascii?Q?xgu8WO6IMYKVzm4sxb9sCC/aqtJlYC2yMekb98tYzThyweDVQyvxZGqmEW21?=
 =?us-ascii?Q?MESr9B+/HUW7GVGIimKM1DZxQgMxpr4icvxwlZItau0jSi9B1/LHOTAcVcjy?=
 =?us-ascii?Q?l30sI4GWCEWzylfanKHGqQt73f5SeifRbQ68MexjRuG3tnXRZqB5Zjedo6DJ?=
 =?us-ascii?Q?hfsDsW85rNIMT+XrsADnAGrC0X5cJOzF35uOxoaMxGNnnWPL0poX+hkupoTE?=
 =?us-ascii?Q?pQLJWBA9wCcHvFVDxiATMYaOTI1JeStr4bPQJQNvI+0kEY1Ej/n9NIXGUQ5g?=
 =?us-ascii?Q?Dxxvem5bqhDNfx4iuPwRxAMShTsL8pPq3C8RacUHH9xOxhv+r/S2wDA6u0/5?=
 =?us-ascii?Q?tF2ACMiwbk9kKee4rirJDcWcL+ge+hIhV4kRZwPdIpoF2QHmbwuBle1opsoK?=
 =?us-ascii?Q?JEagh8N5R30U8LgXVoQLIcZdQz1Xk2bdKtod5gCMBFmCuyxulogFfcjgJaYA?=
 =?us-ascii?Q?pkYsHdveIKz0TgQktWz/RnNGls3iwh0zSLIpE7pWJlFlITJ6MzZG02MHdX2e?=
 =?us-ascii?Q?VL7FcA7OmpBMEzJVjVg6h+UJoLCsmI7gjYG3wRzLc2aLbiiCqdCX+dcCLvha?=
 =?us-ascii?Q?1FJh23R4zpbqeTUsax7mjKGnc5TyuhzNxXpcRPYMEGVUW1mxJ4ryfQOtIU0a?=
 =?us-ascii?Q?ajMthWall0vj63k+ex1tIY9ILVOspCeh?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?snREEd5nYJONqw9oh2f758i8s81Sn80PK49W2zyci63z03naJDU74h0QrEnv?=
 =?us-ascii?Q?gY8s3/1TYBSiE73FvCXQ6Sx3VMRtg8cC6+30qgcA28kLvmVqugvYfyF0nvsK?=
 =?us-ascii?Q?xwEb5fbBqWG536n5r1WU9KWqzASgGHyoi+E3YhdGUElwFzuntv2QUKG3emoy?=
 =?us-ascii?Q?TTcN7Pq41O+VhtskRu7uzEq9emHAGXYLV3Q6rTOnTSyjDJICAQDjLwl9iaJY?=
 =?us-ascii?Q?DRRcu9vtJQQfPiIlAAGLppV5QMydW2ZLdXBO1iZc905KGjTRpFWMbkOorfbX?=
 =?us-ascii?Q?oJB4bYzfNe/3uCatTmBbTUYNofhdvbFaTPHBV5fRTPzFstdJevHFf7vanOw3?=
 =?us-ascii?Q?8UDsCemdkGsPWhlbRXtJPVCHCFz7abMKtp+C2gYDScEMnKXsxdIt5SCkohiR?=
 =?us-ascii?Q?4vO8H6eD8KtQXL4VpxQfCihrhAmYJLIeaSftO+gpcv9NWRb0QxKmOr2x0lN9?=
 =?us-ascii?Q?sdViSkH3C6SoZLaAiaLuaDPkHDcf7sDEldsIVvyFSNaBCaOBjQTARlzzYYEx?=
 =?us-ascii?Q?o/YI+NPlHTytrPIp2xMeb8zC7OB1Z+FTT3GiUObZhaXQEtE9VEp52PC/jPU0?=
 =?us-ascii?Q?sv1FmYReOmUCRO5UViW/Ze0j5plUzqQjRR9OWlx7Qp3E1zXmhjIzwL3MPMgL?=
 =?us-ascii?Q?fcVAFCzKwSkynY19ZBgPZwFoaMk30aYDtOHBSTjU967XF/1DMyyxcfNSdfBL?=
 =?us-ascii?Q?KpvS4zhTZ2O2EboZOc9D9EyneLac774zVFVWp0URPzTWAEsAhGK6upsC5PX/?=
 =?us-ascii?Q?FdOcXxIHTTNvvFH1P4ax8rYlKNaLb9ZELkkJEuSZVCllkUJmXroBOJps8plV?=
 =?us-ascii?Q?hsR1hsCf0u1SBWY3xLgGPEJWlyXXzt93/9QnS4dFZayZaacz+r/PSz3S/8sd?=
 =?us-ascii?Q?iV8noLUywCuzxekNI/ujZselc1z46XenI16mSwir1XHz3o+4BGhpOFPPE1wt?=
 =?us-ascii?Q?nQ8PCNPFM6TXQtmESTgIy4ORnt3wSGVcT1Z4QsefVwHV5TPsbpR/WtFOyVIn?=
 =?us-ascii?Q?R/MKUdNUOuKCgD+8ihqVJeeC+xmfOGv9uDzxX0OiOkyTJ8QT7Jbur4x4OPcA?=
 =?us-ascii?Q?pPq2YoGL1FOZw6dqwr28ta9iLf5O49dq0gBoN+Lq3QO98A71iHLUhizFOgkZ?=
 =?us-ascii?Q?4SDCbLlF73VA6KDG82WnE6Uc1u5P5B+zRrG7NjZOQ7ve1GgYjQ8k4d6MZHyx?=
 =?us-ascii?Q?lfEveFCGq5wWza9hatb00C5YpzLNCnPy7wUWwp90PvkPzLb1e8/OHWCvBm1f?=
 =?us-ascii?Q?Nfv6Oiay0LDelp6MussYsaG2+KnQA2CSJRMxtX1f+2KTOrqS7H04YGy9c5P4?=
 =?us-ascii?Q?GdfFbJEF+g/kyE51YAw3u2hrQrzuIQ39mgYgH8GwpVYSiuNNEvUrjPNrsO5j?=
 =?us-ascii?Q?YCCFRNwQXYI4VPJQe6zPzwuzZgAOKU94mSpLlSn6W+nUCtdeU0CdrE9LTxde?=
 =?us-ascii?Q?cc7CpKtYCtta6yng/Vit1FJfXdoGACsMr+ihusjWFaWIisFfimC3PcMt37vh?=
 =?us-ascii?Q?Z8Nuc2jQrWHGcFcWmnxYMStuKixmc87UIgHMpeD9RgYBQ47xkmvOj4xN7EOp?=
 =?us-ascii?Q?KtATrZ4aIOukqAUnA9q1oD6cmlBp+pNrUArkL5pWrJRleLBsX2b15rjNM2p/?=
 =?us-ascii?Q?8JfB9bEVMlNzBnwO7swsRww=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff27c33-4d34-43d3-9827-08dd70417020
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:47:31.6417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTsl9o6n2cvo2LLSVyJ+HCXEt8Uc87nZoXmTnZsFbvyCJGhiusCPZXreOlxOTxx0wByt6J3fJmr8UWBgzgUiHATdkhmo7p5nrHp1Lv2XWPqE65g0z7ASODfZ8ws+QFbS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13744
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:47:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18428

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 	829356da700bbe07e13b4403997bf8c5aac64660 upstream.

Add pinctrl driver support for RZ/G3E SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241216195325.164212-5-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/Kconfig         |   1 +
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 173 ++++++++++++++++++++++++
 2 files changed, 174 insertions(+)

diff --git a/drivers/pinctrl/renesas/Kconfig b/drivers/pinctrl/renesas/Kcon=
fig
index 5fc190fa2f685..6efe4bc698316 100644
--- a/drivers/pinctrl/renesas/Kconfig
+++ b/drivers/pinctrl/renesas/Kconfig
@@ -41,6 +41,7 @@ config PINCTRL_RENESAS
 	select PINCTRL_PFC_R8A779G0 if ARCH_R8A779G0
 	select PINCTRL_RZG2L if ARCH_RZG2L
 	select PINCTRL_RZV2M if ARCH_R9A09G011
+	select PINCTRL_RZG2L if ARCH_R9A09G047
 	select PINCTRL_PFC_SH7203 if CPU_SUBTYPE_SH7203
 	select PINCTRL_PFC_SH7264 if CPU_SUBTYPE_SH7264
 	select PINCTRL_PFC_SH7269 if CPU_SUBTYPE_SH7269
diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 045033fc84f26..36ef1b558ae34 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -25,6 +25,7 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
=20
+#include <dt-bindings/pinctrl/renesas,r9a09g047-pinctrl.h>
 #include <dt-bindings/pinctrl/renesas,r9a09g057-pinctrl.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
=20
@@ -381,6 +382,44 @@ static u64 rzg2l_pinctrl_get_variable_pin_cfg(struct r=
zg2l_pinctrl *pctrl,
 	return 0;
 }
=20
+static const u64 r9a09g047_variable_pin_cfg[] =3D {
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PA, 0, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PA, 1, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PA, 2, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PA, 3, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PA, 4, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PA, 5, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PA, 6, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PA, 7, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PD, 0, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PD, 1, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PD, 2, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PD, 3, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PD, 4, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PD, 5, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PD, 6, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PD, 7, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PG, 0, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PG, 1, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PG, 2, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PG, 3, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PG, 4, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PG, 5, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PG, 6, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PG, 7, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PH, 0, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PH, 1, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PH, 2, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PH, 3, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PH, 4, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PH, 5, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PJ, 0, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PJ, 1, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PJ, 2, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PJ, 3, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PJ, 4, RZV2H_MPXED_PIN_FUNCS),
+};
+
 static const u64 r9a09g057_variable_pin_cfg[] =3D {
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZV2H_PB, 0, RZV2H_MPXED_PIN_FUNCS),
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZV2H_PB, 1, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
@@ -1963,6 +2002,73 @@ static const u64 r9a08g045_gpio_configs[] =3D {
 	RZG2L_GPIO_PORT_PACK(6, 0x2a, RZG3S_MPXED_PIN_FUNCS(A)),			/* P18 */
 };
=20
+static const char * const rzg3e_gpio_names[] =3D {
+	"P00", "P01", "P02", "P03", "P04", "P05", "P06", "P07",
+	"P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17",
+	"P20", "P21", "P22", "P23", "P24", "P25", "P26", "P27",
+	"P30", "P31", "P32", "P33", "P34", "P35", "P36", "P37",
+	"P40", "P41", "P42", "P43", "P44", "P45", "P46", "P47",
+	"P50", "P51", "P52", "P53", "P54", "P55", "P56", "P57",
+	"P60", "P61", "P62", "P63", "P64", "P65", "P66", "P67",
+	"P70", "P71", "P72", "P73", "P74", "P75", "P76", "P77",
+	"P80", "P81", "P82", "P83", "P84", "P85", "P86", "P87",
+	"",    "",    "",    "",    "",    "",    "",    "",
+	"PA0", "PA1", "PA2", "PA3", "PA4", "PA5", "PA6", "PA7",
+	"PB0", "PB1", "PB2", "PB3", "PB4", "PB5", "PB6", "PB7",
+	"PC0", "PC1", "PC2", "PC3", "PC4", "PC5", "PC6", "PC7",
+	"PD0", "PD1", "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
+	"PE0", "PE1", "PE2", "PE3", "PE4", "PE5", "PE6", "PE7",
+	"PF0", "PF1", "PF2", "PF3", "PF4", "PF5", "PF6", "PF7",
+	"PG0", "PG1", "PG2", "PG3", "PG4", "PG5", "PG6", "PG7",
+	"PH0", "PH1", "PH2", "PH3", "PH4", "PH5", "PH6", "PH7",
+	"",    "",    "",    "",    "",    "",    "",    "",
+	"PJ0", "PJ1", "PJ2", "PJ3", "PJ4", "PJ5", "PJ6", "PJ7",
+	"PK0", "PK1", "PK2", "PK3", "PK4", "PK5", "PK6", "PK7",
+	"PL0", "PL1", "PL2", "PL3", "PL4", "PL5", "PL6", "PL7",
+	"PM0", "PM1", "PM2", "PM3", "PM4", "PM5", "PM6", "PM7",
+	"",    "",    "",    "",    "",    "",    "",    "",
+	"",    "",    "",    "",    "",    "",    "",    "",
+	"",    "",    "",    "",    "",    "",    "",    "",
+	"",    "",    "",    "",    "",    "",    "",    "",
+	"",    "",    "",    "",    "",    "",    "",    "",
+	"PS0", "PS1", "PS2", "PS3", "PS4", "PS5", "PS6", "PS7",
+};
+
+static const u64 r9a09g047_gpio_configs[] =3D {
+	RZG2L_GPIO_PORT_PACK(8, 0x20, RZV2H_MPXED_PIN_FUNCS),	/* P0 */
+	RZG2L_GPIO_PORT_PACK(8, 0x21, RZV2H_MPXED_PIN_FUNCS |
+				      PIN_CFG_ELC),		/* P1 */
+	RZG2L_GPIO_PORT_PACK(2, 0x22, RZG2L_MPXED_COMMON_PIN_FUNCS(RZV2H) |
+				      PIN_CFG_NOD),		/* P2 */
+	RZG2L_GPIO_PORT_PACK(8, 0x23, RZV2H_MPXED_PIN_FUNCS),	/* P3 */
+	RZG2L_GPIO_PORT_PACK(6, 0x24, RZV2H_MPXED_PIN_FUNCS),	/* P4 */
+	RZG2L_GPIO_PORT_PACK(7, 0x25, RZV2H_MPXED_PIN_FUNCS),	/* P5 */
+	RZG2L_GPIO_PORT_PACK(7, 0x26, RZV2H_MPXED_PIN_FUNCS),	/* P6 */
+	RZG2L_GPIO_PORT_PACK(8, 0x27, RZV2H_MPXED_PIN_FUNCS |
+				      PIN_CFG_ELC),		/* P7 */
+	RZG2L_GPIO_PORT_PACK(6, 0x28, RZV2H_MPXED_PIN_FUNCS),	/* P8 */
+	0x0,
+	RZG2L_GPIO_PORT_PACK_VARIABLE(8, 0x2a),			/* PA */
+	RZG2L_GPIO_PORT_PACK(8, 0x2b, RZV2H_MPXED_PIN_FUNCS),	/* PB */
+	RZG2L_GPIO_PORT_PACK(3, 0x2c, RZV2H_MPXED_PIN_FUNCS),	/* PC */
+	RZG2L_GPIO_PORT_PACK_VARIABLE(8, 0x2d),			/* PD */
+	RZG2L_GPIO_PORT_PACK(8, 0x2e, RZV2H_MPXED_PIN_FUNCS),	/* PE */
+	RZG2L_GPIO_PORT_PACK(3, 0x2f, RZV2H_MPXED_PIN_FUNCS),	/* PF */
+	RZG2L_GPIO_PORT_PACK_VARIABLE(8, 0x30),			/* PG */
+	RZG2L_GPIO_PORT_PACK_VARIABLE(6, 0x31),			/* PH */
+	0x0,
+	RZG2L_GPIO_PORT_PACK_VARIABLE(5, 0x33),			/* PJ */
+	RZG2L_GPIO_PORT_PACK(4, 0x34, RZV2H_MPXED_PIN_FUNCS),	/* PK */
+	RZG2L_GPIO_PORT_PACK(8, 0x35, RZV2H_MPXED_PIN_FUNCS),	/* PL */
+	RZG2L_GPIO_PORT_PACK(8, 0x36, RZV2H_MPXED_PIN_FUNCS),	/* PM */
+	0x0,
+	0x0,
+	0x0,
+	0x0,
+	0x0,
+	RZG2L_GPIO_PORT_PACK(4, 0x3c, RZV2H_MPXED_PIN_FUNCS),	/* PS */
+};
+
 static const char * const rzv2h_gpio_names[] =3D {
 	"P00", "P01", "P02", "P03", "P04", "P05", "P06", "P07",
 	"P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17",
@@ -2251,6 +2357,43 @@ static struct rzg2l_dedicated_configs rzv2h_dedicate=
d_pins[] =3D {
 	{ "ET1_RXD3", RZG2L_SINGLE_PIN_PACK(0x14, 7, (PIN_CFG_PUPD)) },
 };
=20
+static struct rzg2l_dedicated_configs rzg3e_dedicated_pins[] =3D {
+	{ "WDTUDFCA", RZG2L_SINGLE_PIN_PACK(0x5, 0,
+	 (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR | PIN_CFG_PUPD | PIN_CFG_NOD)) },
+	{ "WDTUDFCM", RZG2L_SINGLE_PIN_PACK(0x5, 1,
+	 (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR | PIN_CFG_PUPD | PIN_CFG_NOD)) },
+	{ "SCIF_RXD", RZG2L_SINGLE_PIN_PACK(0x6, 0,
+	 (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR | PIN_CFG_PUPD)) },
+	{ "SCIF_TXD", RZG2L_SINGLE_PIN_PACK(0x6, 1,
+	 (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR | PIN_CFG_PUPD)) },
+	{ "SD0CLK", RZG2L_SINGLE_PIN_PACK(0x9, 0,
+	 (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR)) },
+	{ "SD0CMD", RZG2L_SINGLE_PIN_PACK(0x9, 1,
+	 (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0RSTN", RZG2L_SINGLE_PIN_PACK(0x9, 2,
+	 (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR)) },
+	{ "SD0PWEN", RZG2L_SINGLE_PIN_PACK(0x9, 3,
+	 (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR)) },
+	{ "SD0IOVS", RZG2L_SINGLE_PIN_PACK(0x9, 4,
+	 (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR)) },
+	{ "SD0DAT0", RZG2L_SINGLE_PIN_PACK(0xa, 0,
+	 (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT1", RZG2L_SINGLE_PIN_PACK(0xa, 1,
+	 (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT2", RZG2L_SINGLE_PIN_PACK(0xa, 2,
+	 (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT3", RZG2L_SINGLE_PIN_PACK(0xa, 3,
+	 (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT4", RZG2L_SINGLE_PIN_PACK(0xa, 4,
+	 (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT5", RZG2L_SINGLE_PIN_PACK(0xa, 5,
+	 (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT6", RZG2L_SINGLE_PIN_PACK(0xa, 6,
+	 (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT7", RZG2L_SINGLE_PIN_PACK(0xa, 7,
+	 (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+};
+
 static int rzg2l_gpio_get_gpioint(unsigned int virq, struct rzg2l_pinctrl =
*pctrl)
 {
 	const struct pinctrl_pin_desc *pin_desc =3D &pctrl->desc.pins[virq];
@@ -2761,6 +2904,9 @@ static int rzg2l_pinctrl_probe(struct platform_device=
 *pdev)
 	BUILD_BUG_ON(ARRAY_SIZE(r9a08g045_gpio_configs) * RZG2L_PINS_PER_PORT >
 		     ARRAY_SIZE(rzg2l_gpio_names));
=20
+	BUILD_BUG_ON(ARRAY_SIZE(r9a09g047_gpio_configs) * RZG2L_PINS_PER_PORT >
+		     ARRAY_SIZE(rzg3e_gpio_names));
+
 	BUILD_BUG_ON(ARRAY_SIZE(r9a09g057_gpio_configs) * RZG2L_PINS_PER_PORT >
 		     ARRAY_SIZE(rzv2h_gpio_names));
=20
@@ -3159,6 +3305,29 @@ static struct rzg2l_pinctrl_data r9a08g045_data =3D =
{
 	.bias_param_to_hw =3D &rzg2l_bias_param_to_hw,
 };
=20
+static struct rzg2l_pinctrl_data r9a09g047_data =3D {
+	.port_pins =3D rzg3e_gpio_names,
+	.port_pin_configs =3D r9a09g047_gpio_configs,
+	.n_ports =3D ARRAY_SIZE(r9a09g047_gpio_configs),
+	.dedicated_pins =3D rzg3e_dedicated_pins,
+	.n_port_pins =3D ARRAY_SIZE(r9a09g047_gpio_configs) * RZG2L_PINS_PER_PORT=
,
+	.n_dedicated_pins =3D ARRAY_SIZE(rzg3e_dedicated_pins),
+	.hwcfg =3D &rzv2h_hwcfg,
+	.variable_pin_cfg =3D r9a09g047_variable_pin_cfg,
+	.n_variable_pin_cfg =3D ARRAY_SIZE(r9a09g047_variable_pin_cfg),
+	.num_custom_params =3D ARRAY_SIZE(renesas_rzv2h_custom_bindings),
+	.custom_params =3D renesas_rzv2h_custom_bindings,
+#ifdef CONFIG_DEBUG_FS
+	.custom_conf_items =3D renesas_rzv2h_conf_items,
+#endif
+	.pwpr_pfc_lock_unlock =3D &rzv2h_pwpr_pfc_lock_unlock,
+	.pmc_writeb =3D &rzv2h_pmc_writeb,
+	.oen_read =3D &rzv2h_oen_read,
+	.oen_write =3D &rzv2h_oen_write,
+	.hw_to_bias_param =3D &rzv2h_hw_to_bias_param,
+	.bias_param_to_hw =3D &rzv2h_bias_param_to_hw,
+};
+
 static struct rzg2l_pinctrl_data r9a09g057_data =3D {
 	.port_pins =3D rzv2h_gpio_names,
 	.port_pin_configs =3D r9a09g057_gpio_configs,
@@ -3195,6 +3364,10 @@ static const struct of_device_id rzg2l_pinctrl_of_ta=
ble[] =3D {
 		.compatible =3D "renesas,r9a08g045-pinctrl",
 		.data =3D &r9a08g045_data,
 	},
+	{
+		.compatible =3D "renesas,r9a09g047-pinctrl",
+		.data =3D &r9a09g047_data,
+	},
 	{
 		.compatible =3D "renesas,r9a09g057-pinctrl",
 		.data =3D &r9a09g057_data,
--=20
2.43.0


