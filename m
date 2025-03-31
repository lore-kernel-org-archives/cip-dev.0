Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0721C36010
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 11:08:01 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.66])
 by mx.groups.io with SMTP id smtpd.web11.49175.1743419273592199430
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 04:07:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=lbSLBbsZ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.66, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrPM8WWIQZ0pOltQ1wMxendJRwOl+J2xJNqZPqPdlJ2QIQFbWfyzN6Y8pRUcrq2yKHMMF0p44p4gEJ9InPzXfmcRCeym+JwsojD6jdZjGANF9kiS9IoTN3ySdIWU34hFYvrIuxMAcY4Ze4wAyddJWGPK6QrZAHh7uRal848Y4FEbIs8pGdlitFp1cUnmviQ1MVflrwhg0Aj3VOb6PHwiFBpm+Ux6NnMcIqnnXSzs9sNrqZztkOiRSB8zFWNHPqDzhVf+sICK6krDI0ZeU9TQhArOXb7YrD+oAwPfPBqjk8vDC2prTwY9RQ6UD1iNUJL1OB8+/R6jVQnoKdOuL1Elpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xydo4BIE1j67mfmGch6QZ/wj2i3qLJw8/9yzaysHwLs=;
 b=DB/nlakBmG1bunvri0S3q/CcqUGJKs+0CVn18we8xpld/9cFmLBKZShWil+OLAh4eMQLiZnfSeOoT3buFchykQFsmloCxsTwCsXedjpNFiXs8UQ1nGsC/x4yIRsbW5Qe+7yekPMrGsJLb+IVesQkdDLxg9G/cWTd1jVJDOMy5afzjfE4EnvY7xL2svK8AeiQH/a8PtLETTSC+PrVjn2u5TbuTHD3bo7rj7bdKq8FXypNS7Y9SzDva1fUAjkYh/2s5IekWg4rmzPVCuIBKwxQqIyvMQIF2G1D6Bd9ujPgob5lZiydDQZCd5MKfUVS1lYqoiyAB6WS3NvyhZYzacjyNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xydo4BIE1j67mfmGch6QZ/wj2i3qLJw8/9yzaysHwLs=;
 b=lbSLBbsZ25E0rs+mmpC6NpF/5EMnxsTt+doIX4C+gmnLuo4x3qAq/VwYtfHL1LPylZ1FPrcoR4oO11dg/QTETSaA4KVFB4NNecdZcfJYIwiFCCNqnw31XLGYHWoLzF2IQEdL6LUtF/isEXhhyw9Lg7a2WEczeXY3gDviRnFRtT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS7PR01MB15065.jpnprd01.prod.outlook.com (2603:1096:604:370::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Mon, 31 Mar
 2025 11:07:51 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 11:07:51 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 11/13] pinctrl: renesas: rzg2l: Add support for RZ/G3E SoC
Date: Mon, 31 Mar 2025 13:06:57 +0200
Message-ID: <20250331110659.252237-12-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: c3399641-8ae2-4ab5-e648-08dd7044478a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vhEnCPKEf3v2BM+DfjPsFZQxTOZgK5llk76FM66m4J7wpv7GUArALN8zr+Ay?=
 =?us-ascii?Q?+ZEovs6un8TF8a7zGArCV3cMuzFRRMNT5tMprRAgDKabEQ69i3gLuvKgrr32?=
 =?us-ascii?Q?lCcP9EvmLi5/b6RPMVhaNPeECgvPvhSzodjY9mKOQkPqadk9k5k/kIKygiGJ?=
 =?us-ascii?Q?HPKSeP0odFSOxuHSV2Qhq1gffIxeBDR8N5YoevQrnumKaOlwKqxBlEZ4CvSs?=
 =?us-ascii?Q?WhOIYZ37FRB+zjO4gZFiV9hLuqtKD/SZffx+VDwBzpeLwpwkqSX29SqR7Z9V?=
 =?us-ascii?Q?pyzlmHc8mdbs6FH0ErOMRIQ2oowCeEtq+4ps/gOziJG3F1MNoGzA4rk1gm4v?=
 =?us-ascii?Q?CqT4Vfhsq9LvAcOOMbouNBb4metFGtng+7mE8kSBoswdjxR55BiWV2AoWnvi?=
 =?us-ascii?Q?ZBij1tXMjtTeMncP0p4BBXx5AfPmNmPZzD/wIYQmUCo+O06tdkN/J+AKm91O?=
 =?us-ascii?Q?Enmi8/hf/2AJ+5gWcIJSgtruNwvAsZmFtrgHK5IvLeEvwpfAnwWmv34xJT2X?=
 =?us-ascii?Q?4Q3Gg5jFrAQBl/CvNg1C4TJgtuRFGPljB1gPN6qVOQ0VeJx5/LiAMbpP01u2?=
 =?us-ascii?Q?DfT0WFQrFi+LpC9FWqPtUoiJmkk2vGCe7KN+o31iCdqBWe/oGj4P7zC5OdSt?=
 =?us-ascii?Q?ae4/ggOD1F+cSd2joNf1bIqZdofWjo3ijtENpNtxbPJ+gi/anGIddfTw1i0i?=
 =?us-ascii?Q?OlZoeY8jvkNDDc+FCPkY9WEUpqXd+2aBY4UIp6/b81H8rsnveMCVqrdq8NBa?=
 =?us-ascii?Q?OH08qIxm5kUtu+5/79QeBcQbHjoWoKKM1EeCXeIdn8Zy43l8z2JeGDdcrKRy?=
 =?us-ascii?Q?EXRSdROKcWBY9T0721RisXmpQ5te2QhmkxHnEoqCRLxsEoygbTMlgtntvBbQ?=
 =?us-ascii?Q?XRn9HB1NTicpK9ZvQoXDbpRADtNVyPb1K1D2AnMN5XjJ2SH5cg9ouJukbOpg?=
 =?us-ascii?Q?FZjyJ7yxiErFSC1nYGAk5JbWZ4caDPZp2bFqZGV3LBbTlRn4tpjLKTCpVM3P?=
 =?us-ascii?Q?22CLHD0NXRCP7cyjyBB7jurgm8ge0V7M77HSVe4ySKU8PEWJCmEUoXD8cdAL?=
 =?us-ascii?Q?1gAjNYs7UZE1hT6iSe5RoIi/LnGyPLhAtz+N82fpuqB8jPtTuunOP8/pXNzZ?=
 =?us-ascii?Q?FCDCzN7Q9AvGBjCYxvfGadNltZxLsSUwPHMIwXtep434HZXcljWYAoW+rum8?=
 =?us-ascii?Q?qrLGveAx92OVjVbSa5UZK/M9CEIlcqX4vBVQrPweneaO904vE6E3G5Z0IO5D?=
 =?us-ascii?Q?63GpauD8IJeKsEyqaGgnXoL8jMDf1OtOibvnTLzy/lrl2wPDwmjiOJD1UKLP?=
 =?us-ascii?Q?Ktz3LG5FslGnwBT8uJqh5HOnuL7z9gCHEDkLpG6j5XY+VsfObWGjCU43N+T0?=
 =?us-ascii?Q?5qeWV4ii6q7i8uoDk0W9NxXwnIViAAxjpBdaaCHYmojaSWmYNz00pQQtrjMG?=
 =?us-ascii?Q?N6daN8ZxZRSRYa3obx6T3i2A3OeaX9Xk?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?J4l3R1c6UIobF2D/47UF68KFt7ewvVLaX37TOJ3u70/RZQ7wA8MZmQcWYecd?=
 =?us-ascii?Q?yZsVV1ihVnSctiaeXKpM5C8pbXTbHNOMUcjpFQfGy3xxlZsiC3j/kM6kKaQF?=
 =?us-ascii?Q?F7tosWaRjRIscRkkjuPvGkKYDmi/6V1IjaHBkpEgGXeldVsS7VkseaNcjzkW?=
 =?us-ascii?Q?zfwbv0lNgtpobNmZ48klmss19xb3gUziHWVLpOb/gDRRZ4vYsNtwdxWda9GP?=
 =?us-ascii?Q?3WfvIKyg2Uy2JpJPLC0lO1FI8kfSx7UZ7G6XPynFWCsQI4wld/MfKlXqqv2P?=
 =?us-ascii?Q?8COT98wsleqoXk+p8TWkQ35o9JrWKmrBtoyFTw+oXEpDj88nafN85vfigsU3?=
 =?us-ascii?Q?rD8g4wz5ypnN/k9eY77QvAaRvCdh3nnY1psrx9T/DvrFbJtYI87yAGC4r9uL?=
 =?us-ascii?Q?i7e2z0OZjwsIbx8zSw24MQ7BSTxJOj3ZIbmpzo2/LfowI5rdZLWhJqN0N5mh?=
 =?us-ascii?Q?qHquKP5NUNu/nQbXegZ1g0VjwdGH+K1x9qeuSzNh16TjOadKeB1MEaGSRUnW?=
 =?us-ascii?Q?ZcOQwZYjt6jZ7gVWVk7QxC/C7UWc5XNn03/j79F78WEn4tHhhBY6pPc2Eguv?=
 =?us-ascii?Q?T34vlsQ9Krflqb7v0/T5PslaOHx+oNFMFf214iasj54YHaBethbsw97oLhuO?=
 =?us-ascii?Q?m0FyPOR0i54yMIVslFhhGWzLfZhyQpB6uVIiu0oHFrqssT+4inZosrybcyG9?=
 =?us-ascii?Q?rNH7jJTBKVEunPmKf1pHTMpSOnvnMnRM+ilc9yjgfNQ8CNax3ZmQDMmumakW?=
 =?us-ascii?Q?dT/S1PyuEacCL5m1HDY6LFLwM5F/kMowls1vVB6n+nFYx++P8Vpv43JjiZVw?=
 =?us-ascii?Q?IcNCVmn+zo3RJ6NSfO9Onxx8141ux+wlXhi8PTCrMcbr8y+Pl+eE0JTXn/kR?=
 =?us-ascii?Q?quhSHAwrjDoLNiK6ojXw3ydUVju+geWLZO973MiYVJ1YP9gYiEt4OvY6yeVl?=
 =?us-ascii?Q?m9qV1Dbba7aCpOsxawND6U02JaOYIWYlnquG6QtAdmXx3vYZfq1H+6ebiHtF?=
 =?us-ascii?Q?7POtLL5JygcSURq24+thKeoriZPFiN2nCyX2DGjAt3PMIeGPxecRksD+lnKx?=
 =?us-ascii?Q?ozxdw6BnxlmaZ3ab+PZ3t2a94q6tYNpjkxZ5ffxza1CDv7X2VsxgrQoQ2q1O?=
 =?us-ascii?Q?mt3rVN1keEFNWdcvqBSsBlYjTflIj3PFJAJCPo6jfM67ipK7sjRj2zMAf+Z+?=
 =?us-ascii?Q?bGVrUpfVGRYILAxe0L0Rw07qcu/n4JYhLk7Pmc4YGh0E8Zs7d9m/DZL8wrcZ?=
 =?us-ascii?Q?c4aB/e71FiIGiMSOCJtcFP1sa9w3yU0OoUQx/OYu1ck2bI4hxZwwiatkNyOc?=
 =?us-ascii?Q?cpBEPsH2RxxnEcEDzjbbs4Xg91O6CWmwbdizWCKDZh5vYKdkFJQ8/XTMlvya?=
 =?us-ascii?Q?Tkr4zvABATM1GtMuMFM8kibnU33ioW8fB5p7bUJ9OmfVb8J/tIppb4nZ2oTt?=
 =?us-ascii?Q?2/L/K6IEeuYcD/korVOcYhtf16NjXxiV6e7EE1vp3r1PGpixIvHIZ/wB1yns?=
 =?us-ascii?Q?jwtYycE1HRBwmhi1EkrG/pLvWt46THipRR7QkxaU2YHsIyJl+A75K8/dO9wl?=
 =?us-ascii?Q?41KmFpFG0+UxKsLKebYQtVxFG9gbl6YuorbKp3PQeAYm9SswPR6UdOGzLyX+?=
 =?us-ascii?Q?0MJcZ0Tf1R/pY7f+2GcQTh4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3399641-8ae2-4ab5-e648-08dd7044478a
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 11:07:51.7768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hx/AXx3aEinbB8iqqfPTESS3Y/43WW+tI5jH+lJm1pmGgiYdGsr/5j3etoEIZNcGT1LyodLQQK6Suc3QXnMwyiebRRs9hA3bRMl9Y1rIawC9PN5kazPxGPgCtTyY6Dod
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15065
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 11:08:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18443

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
index 7f3f41c7fe54c..3c18d908b21e6 100644
--- a/drivers/pinctrl/renesas/Kconfig
+++ b/drivers/pinctrl/renesas/Kconfig
@@ -41,6 +41,7 @@ config PINCTRL_RENESAS
 	select PINCTRL_PFC_R8A779H0 if ARCH_R8A779H0
 	select PINCTRL_RZG2L if ARCH_RZG2L
 	select PINCTRL_RZV2M if ARCH_R9A09G011
+	select PINCTRL_RZG2L if ARCH_R9A09G047
 	select PINCTRL_RZG2L if ARCH_R9A09G057
 	select PINCTRL_PFC_SH7203 if CPU_SUBTYPE_SH7203
 	select PINCTRL_PFC_SH7264 if CPU_SUBTYPE_SH7264
diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 7718c195cb382..7133d539bb366 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -26,6 +26,7 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
=20
+#include <dt-bindings/pinctrl/renesas,r9a09g047-pinctrl.h>
 #include <dt-bindings/pinctrl/renesas,r9a09g057-pinctrl.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
=20
@@ -384,6 +385,44 @@ static u64 rzg2l_pinctrl_get_variable_pin_cfg(struct r=
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
@@ -1965,6 +2004,73 @@ static const u64 r9a08g045_gpio_configs[] =3D {
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
@@ -2253,6 +2359,43 @@ static struct rzg2l_dedicated_configs rzv2h_dedicate=
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
@@ -2763,6 +2906,9 @@ static int rzg2l_pinctrl_probe(struct platform_device=
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
@@ -3161,6 +3307,29 @@ static struct rzg2l_pinctrl_data r9a08g045_data =3D =
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
@@ -3197,6 +3366,10 @@ static const struct of_device_id rzg2l_pinctrl_of_ta=
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


