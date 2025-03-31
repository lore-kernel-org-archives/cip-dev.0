Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA67C36010
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 11:07:51 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.56])
 by mx.groups.io with SMTP id smtpd.web11.49168.1743419263690991017
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 04:07:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=u2JNMyrv;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.56, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJGrL/7I5Ib4nh5cyb6feZwICG4/B08lGMyB1hyoBu/pKujxJwsLF3VCd3e+l3kf59e9homRapWDQ2KiIZlp2vBMcO5+917rxzm9px7lDowhSPJrO5dTTQ07YckySlrWvmTIHnj2O0n0x+K5DKiLp0Bcg653Q+8ZfdOOqKXVD/ZLjnKBhIJ8sXwrOOv1+ho3+Bovmem5MurO5887/ZWTTrPQiaByyrZbZFzpIRFrILLa6srLSozjRBRJR/F6IRdKsG0ii7H1Kcwc579yBcUrk5C4fC6CzNI6MqjNQqa22anlrdXLrOBYluVA/XL1YJdlt22slgL6cZlqGmVzgv0WRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4t7X9i9x76FHle6Xvrg7BnalxKFrM8vOQVLHWC8Yy8s=;
 b=hkyM/RnK9Ks73p53S1rbLiDvGVe1F7M48poMmED6VcfQRJSs6H1cA8cuL0SaVCxCYXKk+yu2VhNtb+MqfgExXMQngJu3C/7Wp9FLBCGbj4givLOaHgrJ10nDmagJaUoV+Wkf/xtPBZGposfUafMfhG3FYIBPzRpVQnZUvCdK64fBkTJR9UQhRvec5fcIdCoJNOCwIrBomyDNpqnJ0X+831alY+wND0/bij+hiT+SCL1U7J1O7t6FXALaR+20RzBzLFFP6mEEgbm8pbyJJsOYccMo73aJfX5JCvlVY7bVWfMYNLZ5cLcqor+jABUb/cBYsADYZLBkaxJ+kwQIezTKEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4t7X9i9x76FHle6Xvrg7BnalxKFrM8vOQVLHWC8Yy8s=;
 b=u2JNMyrv0UUNVsZDMqgCHYIltg5ChpOZQxaBcziZ+FDS08rcm1+gPYNsrzfJl1GX4K6Ev0Dp5Pflaw18ClXoN/T/syCgzeTCYRnqY/R5ZD/0CqjnAQhKUS8ngPgIzEnawOnWxmEfmrQqkEc7xdfJdnmGyccPaIrXWORm3BYZtHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS7PR01MB15065.jpnprd01.prod.outlook.com (2603:1096:604:370::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Mon, 31 Mar
 2025 11:07:43 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 11:07:43 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 08/13] pinctrl: renesas: rzg2l: Add support for configuring schmitt-trigger
Date: Mon, 31 Mar 2025 13:06:54 +0200
Message-ID: <20250331110659.252237-9-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 85b18bd5-c56d-45df-440d-08dd70444256
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?AaOis7dwwZsMsrKc3n1CNIUQ8LafpZ4u+LmTqJYkYw6ilvi/6qEDYXtzh6zV?=
 =?us-ascii?Q?EeIkABp5vEKwQQQegp/iscEKwnUzoKYppl2xjEjeGPbrNfs3nhvt5KOjC7Hr?=
 =?us-ascii?Q?b32qQik9CefmklCarYuHBKm5UYQOR39ZL8kbc3RS2v2tH8YR+KIQj9SLB4Nv?=
 =?us-ascii?Q?BzfMcWVj5xWQowGOG8Y57kvW8+cRjYbw8JziDYlQAfr2dNB8RnWBbh3sIWzW?=
 =?us-ascii?Q?asEyjiEIOJMR4e7X64Mp1ZbQpXy403WNgOh0rnul9litMHZk2nk27H1/yER1?=
 =?us-ascii?Q?rNrSwfTn2QnNCXUKeSNm4Suns6XZHf50GLTejEGq2wMfynoXCuisBpL9zK9x?=
 =?us-ascii?Q?ezpiuMuaHsJFnAU95b9KR9KwyoVwMZFTlIaO1Ae/le4hfOpdSxDVZcU2+d27?=
 =?us-ascii?Q?nUX1oSr8yWwvqwXZoKobIvOpENuYBlDaZ99lOQ2LcIP4FV814/Kr2FWSSfZC?=
 =?us-ascii?Q?KOfEuDb83sH4eVA7UMc7qbYzhbB0sB+pHSMC89L3TfoSS+EIaJsjux+HL2fI?=
 =?us-ascii?Q?7PZRUtk4CVo6Rfiog7JrZhR4qmklBIxB4qCn2TJ4ujhynRQDsgCXutn32bi/?=
 =?us-ascii?Q?+fl8IRFLzxHoQwvapfZxofLDsoRnBmyI+CdUDfDGBxPtpi0SgK10noyjI9qv?=
 =?us-ascii?Q?FRONdncutCftvd6mdfp79OB6IWBmplLQP70J7zJLKs1AKmmOY98g2Htohddo?=
 =?us-ascii?Q?AsdfHndCSRZrGqKR5V2B2yC8++cUXMorV9zvkXEHyMXzOkKamhvkzeyvJL/X?=
 =?us-ascii?Q?dNNPVdsud2gl4ybyFRHLL4aBnZVz1f0qyu/cHiIwyRKqN+EbbGRugE/Xeeos?=
 =?us-ascii?Q?uXtsAHIhb8qGq1BZNDwL8Ug3jds812MtVfAMlOKYzLdaOuCvc0wDEbk5JAZy?=
 =?us-ascii?Q?lYT+K1MHXa41GqrIPOmEWLQhJhHykTr+UpociFo9WyBWxdDtnwMZ58prDdYu?=
 =?us-ascii?Q?9XvTbG/hKakh/cyKROyFGTHbO0BirPZdqMRzW0VCizzapP9ZKbOGRk2+FrTr?=
 =?us-ascii?Q?fCUXG1FG8w9y7bP5UxurVi9k5x6jIIifJ5b9wJn7zQYGdDgi7B9g1nt07CMr?=
 =?us-ascii?Q?O/L+h9xJjvbrf090xUxr0/ZUiWzLgVdOFVy3vi16RL9tX9DeyecBUfX3yCAe?=
 =?us-ascii?Q?jNq6mKch1xVBj+Lpr6PtSeWSk7QybWZLbXT3OMYNqWdTyUdQFyCpo9lJ1auJ?=
 =?us-ascii?Q?xZw7QAbBmsdLzqDr1uwslfGNvjWxtfRWYUa8K0/g/3uxBGsVPeqyvIGPC8hq?=
 =?us-ascii?Q?hpuR9YG7QE3YIWlfebC4HUXRW5KmdDm2M8y/WSDWUYNgOpzNpwAfnI/Ef1B5?=
 =?us-ascii?Q?R02ldm1/6JZ9wEE3kRlUEFCCqzVsaA8j4zmRz2ePnpv/0IImUo/Y+kVes8Th?=
 =?us-ascii?Q?3I8Xe9DoQK1Iue05p6uhajmBulGpysGLest1VuC2hTBoJTQHT7PV5IubJTcO?=
 =?us-ascii?Q?hpZaFU/tt90+QP/5d9mtAlyDjsPklfRz?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rWE2nNoVKuhnLOVhLvqCHE9lBsQV1PfT9IhIKfF5A5Y1ExNk0aEghfneqJbc?=
 =?us-ascii?Q?QhwV/6ibwlS2UUwELd2JqPvZtvWUF4UGEiCtzeEEWrEJERcQJJ+9+kzoftG/?=
 =?us-ascii?Q?u49RwK9dqUU3WjJZR+flhgpJsKkrhQ2BLarUHcNTSF7ZReXH95uyHJpsUp3f?=
 =?us-ascii?Q?EGMvnQT25JOXRSpVSUf+Q6n3lccXegFqDn3tyawdYM7mfoaESGrNpU4oSlgS?=
 =?us-ascii?Q?M0ibtxb+PLrDgDrKOCx90jp/BGU5IVb4eld7/knXIdKYz4Xtz2w38ja277yv?=
 =?us-ascii?Q?vHWTXlGMBOAdAS8eiK+TaTOdV0wQHshVU3PmRaXHskBUtMF98r8puU1MxHvX?=
 =?us-ascii?Q?nW0IMYgNJ6RqmN/jthKIrDs0NerzzeD7CcVGVuLJKPQ7nMl7FZxut0qhZpUK?=
 =?us-ascii?Q?M9PBcWVW3aNmjZAy5YMbxjKxU1zduYAvDWOMGhJUFr/g7gQfSqkm5G+UdqaM?=
 =?us-ascii?Q?dHA0ddX0V2wMANs0F5qMrPvyLCeWGaMUeansHFiWCZf1oCqwnF9waoPPlwDs?=
 =?us-ascii?Q?HQZPIjbwF/ySAdzFM6EyrP9SJO5KfeL69f/8OYLriozMtltPyQK2Ogyaiciz?=
 =?us-ascii?Q?W+kK7HEhDRrQJuBpBEstRZNbU4kEyn8XmR3vdf7PKvkuxU+Rcok4MyUXD7xV?=
 =?us-ascii?Q?Qw5cXnz+aSPvDQ8eEGTQIfi3+NO1KD6nqISSPSbM9pcBRIvYyFGyYfHa7BIt?=
 =?us-ascii?Q?lXWvx7KyNkhBS9GAlHWSJmAWJ2fyTKhdNhCsA/WhvoK4eSX3Ay/368t171fB?=
 =?us-ascii?Q?0YKs6uHV4tTu/vDAjdzVppXOy5kZMve3pztdyk3vESpwfG7vbwevdhiYBZpS?=
 =?us-ascii?Q?8e0IOK6juUDGC5snFU93mPW/6FPhY9ZJuSatnqLm8j5Z8rtvqcFsa3WLGoJM?=
 =?us-ascii?Q?akMI8uIuTncXRaCBToea7qVOMEZreYQisJJpsULREQ0PDX6u9oWTzKImiZ/R?=
 =?us-ascii?Q?iuXzY5GPK3FyYklAZF/PK1TxkoYIuBCwC2xPssrY8zdmPgImqM6p3uJsv529?=
 =?us-ascii?Q?RLWwiA+0qKU6ryGO7khTMkdzwSj6p2tT3Vhq6jHzeOd4tetbAWBqSur5EENj?=
 =?us-ascii?Q?s5CNwp2IsjQd9a3OZRIXSImhDk1hAaeRdinv7msoiJEpP2Gd905do4CzxJrq?=
 =?us-ascii?Q?GkdEjMVnEo4ERm7DbIKXDSj/vt3DwbqNKtkkkz1GuvyCtD6GtLt49L4tFszO?=
 =?us-ascii?Q?Kc3gzBkaiKTu98ZPudFfVzNjPapQ//CXvyd8gZWb+Y2L1UQeUK/TstLMRKEj?=
 =?us-ascii?Q?5KTmMH2GSja31y2pIzyJ48L7PbZ8f5/aCpv5g773zNU+Hi899XEHpOzIkzcA?=
 =?us-ascii?Q?eIyUXlmPJBWCZRKJA4XdFpgIJ0IZYezw880V8WAQ7DSQKPMYKdmeVlPvp8aX?=
 =?us-ascii?Q?iYNmfZieafLuQShD4OjGcjP1go8yiGY5WaDq7Vv+KiS8Lr8t1w4g14hOJjPM?=
 =?us-ascii?Q?0q7pAhVDZ0LfJAj+ZiM9mrjkE5NTB4ohW4flacrpp2o8XUO1Lsfih5NeuywE?=
 =?us-ascii?Q?JuBlCsYzeEP8zYGthPpd6iHaGAbaquTZSo9H+6UnspRHUbgdfTNUuOYalbRK?=
 =?us-ascii?Q?RUT2JVVq8nkCHRlhX8J2kXQmoPGcqyVL7JTDqa9p4x79wxH6m6qVS6DVTQLl?=
 =?us-ascii?Q?P94FU6lX2xxODYtBV8xWqg8=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b18bd5-c56d-45df-440d-08dd70444256
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 11:07:43.2731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yKoGtvwsQOT18T5/eDYZCkz2pAJDAm8sGsj8J3Tlj54mjNyULriCS3EpMpJJa8p9jeBebhHWDfqE0ybPSTRMgm9wWzcdx1sT9x7R66NpqEwVfbBQt/7/1c79LhrmqXm5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15065
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 11:07:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18440

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 725933a54f718af5362ec39971b2933d8bdf6994 upstream.

Add support for configuring the multiplexed pins as schmitt-trigger
inputs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241004123658.764557-4-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 548f4a926b091..802c4795770a0 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -142,6 +142,7 @@
 #define PUPD(off)		(0x1C00 + (off) * 8)
 #define ISEL(off)		(0x2C00 + (off) * 8)
 #define NOD(off)		(0x3000 + (off) * 8)
+#define SMT(off)		(0x3400 + (off) * 8)
 #define SD_CH(off, ch)		((off) + (ch) * 4)
 #define ETH_POC(off, ch)	((off) + (ch) * 4)
 #define QSPI			(0x3008)
@@ -164,6 +165,7 @@
 #define SR_MASK			0x01
 #define PUPD_MASK		0x03
 #define NOD_MASK		0x01
+#define SMT_MASK		0x01
=20
 #define PM_INPUT		0x1
 #define PM_OUTPUT		0x2
@@ -1354,6 +1356,15 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_=
dev *pctldev,
 			return -EINVAL;
 		break;
=20
+	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		if (!(cfg & PIN_CFG_SMT))
+			return -EINVAL;
+
+		arg =3D rzg2l_read_pin_config(pctrl, SMT(off), bit, SMT_MASK);
+		if (!arg)
+			return -EINVAL;
+		break;
+
 	case RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE:
 		if (!(cfg & PIN_CFG_IOLH_RZV2H))
 			return -EINVAL;
@@ -1492,6 +1503,13 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_=
dev *pctldev,
 					     param =3D=3D PIN_CONFIG_DRIVE_OPEN_DRAIN ? 1 : 0);
 			break;
=20
+		case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+			if (!(cfg & PIN_CFG_SMT))
+				return -EINVAL;
+
+			rzg2l_rmw_pin_config(pctrl, SMT(off), bit, SMT_MASK, arg);
+			break;
+
 		case RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE:
 			if (!(cfg & PIN_CFG_IOLH_RZV2H))
 				return -EINVAL;
--=20
2.43.0


