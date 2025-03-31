Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3872C3DA4A
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 11:07:51 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.62])
 by mx.groups.io with SMTP id smtpd.web10.49417.1743419270908679435
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 04:07:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=CDArBOBl;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.62, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncVDhqCCVNdqs6sfedGQGv4dPMOmPFEx4zG0usECUlTold9Ll3RnU6xHPMafU5GmdXzYH1Srh2V2m/m+uX+AVqmbdrQbZUzodJAqalaguZLp+Iu/aViHm1kr0ng7jwkg858nvMvNv8H4cbLABJYN45fDIwg3btQpL0pl4jWFap9MYIofOrVIg/9eYxLpfW/byYSYUFpUZ1sktAwbQ3KYoJMtEBF3q5/85vjzholJymWh6zOQ7yBL1fPescNNEbPR3QLyJW0sG2mr8mSBxSRURec0hHZ1o2Dzq7/Y/Ujp7dia9lnRgu1PyBzwttKJCNfR3kQkgb0OQvYdUr5BYlsguw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGyLGwBhBBkz4qUJi+YdHXy+SdmusSLVl3C0xsu+5Ck=;
 b=sdwznlel1srLhGskVwQHfq59vGn8fshUN/+psCW2fSrzgm4eJgvp6paNBOLnmEYajn/CNEgN2BEiuF5B9dutZ46P7AG874Okk44fZT2qMmExSBAt8co9zcn7ehBDE5BodNjNfk9OGnyQfcPf/Rg63FYXAy5SMLf7JGAoBgQhFBRl/uMutaTamh2IloAwImWCAqdu4SbpomPnYh3RxDuLPUtEnISAr42kdqOf0IB9RdUdYDnVfVRdnNWRFK8lgV0TZGY88RfPX9LMFyfY9UHH4JIAQs32j1GV1EhUIB9/fNe2bBuM5b103elAdMDDcRo/T3JF9WeY9z1H44w5hX1NKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGyLGwBhBBkz4qUJi+YdHXy+SdmusSLVl3C0xsu+5Ck=;
 b=CDArBOBlA479sWCTYJVqPOs1QyzMk/DC8xHsyBfXXcLrQ/sus8moErP+MvTyqWAxS/O4Rf87JMQquo9knFyDrkHR0tcKToH3GNMrQu5xWg2Ke5TT/t0RGaS/NgqMlKKjXSKZFaO0FA1GKVk+n4Plq3cfA4NgPt0SJZ2YaxwrzBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS7PR01MB15065.jpnprd01.prod.outlook.com (2603:1096:604:370::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Mon, 31 Mar
 2025 11:07:49 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 11:07:49 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 10/13] pinctrl: renesas: rzg2l: Update r9a09g057_variable_pin_cfg table
Date: Mon, 31 Mar 2025 13:06:56 +0200
Message-ID: <20250331110659.252237-11-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0a09c90d-07cb-4ebc-450d-08dd704445d0
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ET0p5NljvPPEBdJhW/WGMoUhg9XsKdrE3FHwv30OzBxrbrcH3UOlHmIuSY5a?=
 =?us-ascii?Q?Jq2WWBEmU0sURbcyjCao/YInYRp4CPbn05phLRMbHwvEF99k+TY0gRWVvnsv?=
 =?us-ascii?Q?Dx2V4f7ia22lU4sc4q3QNKnF4hC5owBWqERoWB0jkT8yZ6H3qq0VNcC/mfbL?=
 =?us-ascii?Q?NIIOcOejp8th7ie+Na9m1VJSxnKT0cMseClBsgM8I9eckfJcA1Nmzp31NyAW?=
 =?us-ascii?Q?q7RQ3+SyXddrPAQ5e7vKHwILDR4vGkQSh/V8S2UAPXrnx9SVs2kp8PjmGw62?=
 =?us-ascii?Q?1VyAmuwAIAm7Ke4ieakNdbklGvmYMJ8FsXgn3ez2Nu27uPD/LTocaBZrK/XA?=
 =?us-ascii?Q?3/74WcXOf8MahACtW8OUihw2A9bHM5ZJ/CvDWuEdRZ2pgltl5vKHsVha3U/V?=
 =?us-ascii?Q?e9ZFwvqWCEDBKiHSV3helGxpY15mJxg5H3iZq76FPGEL19tl/Z6TQNE5p+tB?=
 =?us-ascii?Q?Q9gwTeD49lhBNQj2X8YSmdJrP+bKRcXUd5Glyr57WTdXwJTJu0ILNCxJ1FzQ?=
 =?us-ascii?Q?2ieBsbKB9ZYN5Ugbyd9Z+5msrVEVdI7LD+DNJ/h+MNdFnbHcuSahn6LMgpvR?=
 =?us-ascii?Q?ffMWPJYN4P9SEHUGCOlSIoUUd++RbZQFL0rT3syWkAWbITTqDVUQet8jX1nm?=
 =?us-ascii?Q?mcNZt0MW39OHR2tw14y/arcY98cAU58mpX0kNpiIOGqH0qB67JdxrC+0dWuO?=
 =?us-ascii?Q?UzgR/ZunP+kTDtWGrL/DuDbP0lRVmFmOz+WE5x5ySwiEnVZ6JY1U3IrSIH+B?=
 =?us-ascii?Q?8GG33q83Vnbw57rG3i5nYOhecd5GiJPj7apXmsLs37jv6cGY4+uESCHflxRJ?=
 =?us-ascii?Q?whL3fKPU/TzXi9C9fyohJcXgrI/VsAPU7pebkSHsH6voLzvaHtc+iG6pQ2nQ?=
 =?us-ascii?Q?gRTwcuQKd29RPWqZXj/Ors7DpzzkLkyVIRxdlmHxLkeM/Q6P2Aaga3gY4mnz?=
 =?us-ascii?Q?Jd3pe5ZBqkmF4AzZQpdUhdypCM5kF8eY0gAomJt2RXBMezhqNbO7jLWnpYxN?=
 =?us-ascii?Q?NFoMAwEPx+H0hnK1IkAdzsZlyktLrBPnaOWxY/ZPxOLqKWjqtGSG64MHsiMY?=
 =?us-ascii?Q?5UAxTWia7w3nubmNbtT8fPla7HHgl68l8lAdKJh+iw8KtAdar7x5nwQ0yK3G?=
 =?us-ascii?Q?LHS/QE/WWPKhJ1Q2jFu4xBAR1umaalE7VSHwD1sXVDUAHcTRT3236jS93ZN8?=
 =?us-ascii?Q?4S7mZPWIz7aVxnkJuoPGlM7u37Ox70qSSgGCo3BkYKWfRjDoHqJoD4nYScsz?=
 =?us-ascii?Q?xoq623fk7qNj1NO5VZ4JLvl7O3e8jXNh+HrH5+Ye2DnS1HkgRViLpFbCJ6md?=
 =?us-ascii?Q?cldOjlP97bf3JZe6470awbHlRFsZ266TBxTa0AwfawpUjRVs/RGgqeJo7FOH?=
 =?us-ascii?Q?e8YtBX/oSiAuND+/WOAmojXAQdXSEdPlXGfav8KrcDrnlgK8Rad2/QwZv0LG?=
 =?us-ascii?Q?FArudMa+f9hpCwpEeUk3e8iTvZXNTYAt?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?EqEGIFTP3i0N9zNMArdp7BZPcRI1sFJq3lRsxPrnD0gkiBkoUMnGFja+iBkX?=
 =?us-ascii?Q?39LOtFQ4msdW5Oljlh/CFLhJvTVNQXf0qKM+dhQprJZ6aTo1p0mojWUH4QOV?=
 =?us-ascii?Q?VeYDM/X/KdgTzWNgdWchhFdrkAp8ovFTSWi4RTJfLRpnEMi+I9YQ3TigX5KM?=
 =?us-ascii?Q?1cjCUSSWX4wkgSxiQxKNodH2yZySU9MCOaMRgwUjdRD1gBVBcypIkLtclkaZ?=
 =?us-ascii?Q?kERFF9ZHs3YkPUKvG/IijbhHF27BIxqVAq5vYz/nMB8P34EZ7yVyVS335Oxf?=
 =?us-ascii?Q?9+TThWFED1WinH2b1fvgsIB0J4NV63GfMjxazCnFGXVKcUvephaXul66FZ2L?=
 =?us-ascii?Q?q/2IbxVE/2RCiz69mwc+5ghstCheurVL8GuNnIRz55mhKgMJQbTD93APagia?=
 =?us-ascii?Q?pPxcyWgRDRMpp6naa6imZfWnpG+Z63ZE6S+9SWeDXCP4qjFQJKVFV0gU6Pd1?=
 =?us-ascii?Q?jqn0eOD8781ee9Q+OfLJdTBZohcmi7oqOEQbKspbJjphGx5q52/K5wKitaUj?=
 =?us-ascii?Q?eOA/ij0bhlm7PSbAQql+8UJhAwKtIybMiUxZdejCY4HMPqAUgTOvf6EvmMtx?=
 =?us-ascii?Q?qduRibLL0kXZj9dQNDsb2sbKvQiHqFkAwW3S+BJW077BdGp647tmYnd3krMI?=
 =?us-ascii?Q?FnqAbqz4sp3yP8xcavM8dH9EEzh0aWW56Q8w+1hSd+Povj1R4UBuandHhmBH?=
 =?us-ascii?Q?rUrcdeHNXCVwJ8D9e9+kf+VTIJE9X5O84q3Mv6tI6vqjdje+kv7pEg/BhQWg?=
 =?us-ascii?Q?eh4R5+a8dJObNqjCrGCQtXIvzJm6VNLaNp3dJoGiF6ZRu1z4TNq/f1o6f14O?=
 =?us-ascii?Q?lPcAzNv9Ky5N4nq+MzgEB0BvYeaFcAXsVcm+9U/7+EeYxPXvRS7dJ+z8vZR2?=
 =?us-ascii?Q?1mzl9FC2RWMg1zgHS1iFNxwZQqq8qLGeaqv1WjbQEZZ6/J9aKXnlOdTD8/bm?=
 =?us-ascii?Q?tCT5Iuqy6VCJ3YGMDLhd+tNkCqKkLyBghXfJMSHqIMIom1zTdJTXcl+O2gI7?=
 =?us-ascii?Q?ex75Kyboi5gMJgigfSyD9+JtbP02jOQkON1emoCu7XTjSsZtRFXnmoU6uSXs?=
 =?us-ascii?Q?YMDlypm769EQ71wZzzvfYGVCVpQKHdwp74ib21Tdhg4XOs6NLxlGLGeCh2fd?=
 =?us-ascii?Q?I53dNSHKmZ/M94/APDDJCedGygVnpK3DCscSFFS4M1/QJNtUGQin8NeeLMtv?=
 =?us-ascii?Q?HUgCKxazHgfHCDtxtg/o1G/Ri5ovg5NP6/bPAjkFyUEqGZvlDOBNpJ+kiEXK?=
 =?us-ascii?Q?JXxUueY3b07qb+UqrZnPasRA5Zq6PFzm9+MKelcTBZFMNVgyeyroG/3pB3Z3?=
 =?us-ascii?Q?z4uKf0naO2HDvllrPwxuy63sMAaqKWifNsxFZ+2zWuU3z1cWbMfAC5EidvSJ?=
 =?us-ascii?Q?0joPrU2uM4IMvbnZ6yvkmRBC9DBovmU1I7w5k25rVrG8ZE4CsVhXS7AB9KiR?=
 =?us-ascii?Q?6YQF8MjIFYhhBP276C68hYa/iRMSmBjYVZEhx6D4a6+8r6xUki7cKjmkLCC4?=
 =?us-ascii?Q?yZ3k712tuaG8Zmc1HI2RRE/qezG6oV0nO8k5e6u5k7pLfAbl9CmfHA0n4/DS?=
 =?us-ascii?Q?Ug/mW6tMFShE9JUgnMGC4GUGkosCwr8Q6qLfV5l1tXhWJb9OFFMOgBma+rsv?=
 =?us-ascii?Q?Te0YWYmOif7+GKSPcs2s2ls=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a09c90d-07cb-4ebc-450d-08dd704445d0
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 11:07:49.0978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tslWZsnAR58ek6PlktCeYURyQdbB+THnKJNIF1Zrf7usWH/DpPasPgrhmKRdpAjeAuZwwnRh15OZ1imjET0zTFwxxFnpiz4w6J7uKUixTvP3jZsWMrbIayKszsdaNze2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15065
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 11:07:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18442

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 0ce66380a7c7566c91d4a159751d5801280957c1 upstream.

Currently r9a09g057_variable_pin_cfg table uses port 11 instead of port PB
as mentioned in the hardware manual. Update the r9a09g057_variable_pin_cfg
table with alpha-numeric port names to match with the hardware manual.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241216195325.164212-4-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index b06a6a2542cbb..7718c195cb382 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -26,6 +26,7 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
=20
+#include <dt-bindings/pinctrl/renesas,r9a09g057-pinctrl.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
=20
 #include "../core.h"
@@ -384,12 +385,12 @@ static u64 rzg2l_pinctrl_get_variable_pin_cfg(struct =
rzg2l_pinctrl *pctrl,
 }
=20
 static const u64 r9a09g057_variable_pin_cfg[] =3D {
-	RZG2L_VARIABLE_PIN_CFG_PACK(11, 0, RZV2H_MPXED_PIN_FUNCS),
-	RZG2L_VARIABLE_PIN_CFG_PACK(11, 1, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_IEN),
-	RZG2L_VARIABLE_PIN_CFG_PACK(11, 2, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_IEN),
-	RZG2L_VARIABLE_PIN_CFG_PACK(11, 3, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_IEN),
-	RZG2L_VARIABLE_PIN_CFG_PACK(11, 4, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_IEN),
-	RZG2L_VARIABLE_PIN_CFG_PACK(11, 5, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZV2H_PB, 0, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZV2H_PB, 1, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZV2H_PB, 2, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZV2H_PB, 3, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZV2H_PB, 4, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZV2H_PB, 5, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
 };
=20
 #ifdef CONFIG_RISCV
--=20
2.43.0


