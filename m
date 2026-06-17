Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F73CD98EE
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:31:25 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10922.1781685084001305291
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:31:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=agWE9NCQ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.41, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPCcGkWtiQSHukcm3VwRTFqFrQ/HDBGw1Ehpl4upQIoN6y92XR5i8OU3/rKP9phepZ0Zz6Sy2YGViE/9mpvtMjVV7lykWrJgCGlip3w5UgLiNNQQL9NVGK19TmKwNKRMNz2WAJUc0ccTWaBuQCcyDHBDKAjazEA43aP+60HtxBc5gC0Aq0CFW+bOQphjAQBB3SCpXzvObQX6cedhatbi0KRJZrHRsbs1LGuwR0/6w8FUMu4G7mnE31Fic7TkWl1GQXa0i5xLSbl/GTEXO8ROjvEQ0G2Zfj1vBlJEpJ89VBZHhKqPSF/xewM0chmFD+4fn8DcEsJPKOpz0aPd+8RGMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9T6AAbYbnuLVfU5DJZft8pJ7/ApxNJeYWLTk1CKrDAo=;
 b=KSdAK7a7osDjDM5/mCsGK2W7ycvK56GC64OU7dFCbt/IBXkfY7NKA2/wNErc8AuNYBrwpXeutSbYiyGxxvIiQagT+wrHSn1SgyuMySbLfVC8MMZsJsRCbHtiXI1vl57i+ZJqcSplrHV+GyCyVQRKwcly75MC5zJib1oKQPlDt96Qu0MswV085xaNYEawmKSWA/80Mdo7eRNkd5CtYZmThhCjQtRX4/GXgNy1rFhxKki1Inw9He1HFx4KWlyzIbQj/sG7orTlMqoY0ppd6CPe2c02rx48Q4sXNzx/k8azX5Ih/5+JjKZ47v9rFjurXSRyL8zKl/8Lqs0tTKMEajdeJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9T6AAbYbnuLVfU5DJZft8pJ7/ApxNJeYWLTk1CKrDAo=;
 b=agWE9NCQjXbL2GqFL9hpqofDHKp45QINNse8g/2rV2OcRKvyCF9ULYr76qBLptTBJ7oseCoAG7sNkU4Y9QaLSmd9Q1aF1a/KiDyShfQ1oElv7IjN8kVc/gGZ+6+9VexPVax1cnl4pZO/hKFvFpD8KMsu+e+QRonwS5RhhGQyZ9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB10286.jpnprd01.prod.outlook.com (2603:1096:400:1de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:31:21 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:31:21 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 18/32] spi: rzv2h-rspi: fix rzv2h_rspi_transfer_one() indentation
Date: Wed, 17 Jun 2026 10:29:49 +0200
Message-ID: <20260617083003.1071543-19-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::18) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB10286:EE_
X-MS-Office365-Filtering-Correlation-Id: e5dcfaf0-00ef-496a-f2dd-08decc4acf00
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|52116014|376014|366016|1800799024|11063799006|56012099006|22082099003|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info: 
	OGkof822hZUL3dfSKBjjv8oX4tXubqxhVsxoYOfpXcvCh/VX3D3B0tYzzeg9+coiCfnroHEID3WVcaglVd+1OEyeH4lRivEWMLuaq1+aJZcavSbX+A5VyprTPW5xWXp84pJ2XFUWfx24In4MWcDEBLWv2rv43iWC02DWHzeBdqFWVui4mzVNcjwkzbODhOlMiNC0JBkrkMmy2qubRuLkCfOtj5xskbaZe5AgRHMmwODNqcT/yIJWMFcqaE6MAPqwJwZAdYfYxd/jMKwQKz4d1R4fKy60j90vWxYQ0seg9Ynqe6qMQ30jHXIwKaecbH2uUh61NXqpoUC1w7WKYt/DnOtJhvYt6uAafNjD9wTsLcijsQEqHCvS4Txu4h0JjFy/dNcLk4E9ZPC8PqDUMquytcfPeTZA/0spxOMcGJaeIRFz+eA6BJjEJ21j+qx3YsYla0gCO2uYpog5vFE3V1ReUhhk59SBu3k3F10iXjv6LOFP5i3b9MoUW2QDSFECQJvJgPmxOuUY6U/1vXPDe9bXc7gAZzln+5t1wiiBrB4PxuZTxRcEasoHNflDdklUrDst2kCTQ4wegIVmEpX0ITjL1l1nhfur9UtESg90LKjtmfOZ/gnZDl77p2vYQ2DNnbBNrtsmYo7pvWOESKjt1pOnYI3dLsfdUhxNPYzWh0AilNZ1XOHDbacvfQZOU+PEvz5iRmA3LhsOcPbYMQIEJqdPOg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(376014)(366016)(1800799024)(11063799006)(56012099006)(22082099003)(38350700014)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hXlbK9bxOkOtRlE3UYui5lx+5aMECitQijD3xIiINk+xpIJaDZi+giVdkQqp?=
 =?us-ascii?Q?F39KQHkz0Yux+Y2wGct50QT8HFueMViDL/m2s58cFVBunI5LTCjb19TohqZS?=
 =?us-ascii?Q?amwBYAGm68YAka9E6vD29wEHjMPcBDklRcf+lVEQ0MWiH3d8mC5Puse9C/aS?=
 =?us-ascii?Q?Erf66BEn80xuMYlPMrQVU5nFTNdykVdc/7BhUptFVPeLQwkx7lhlVfXlQvw/?=
 =?us-ascii?Q?46AahaToIU2dPRect6QaJ+Opls76BpEIO2xhtKS+EO/eNoO9+GSRyzB0AgIa?=
 =?us-ascii?Q?M1Oh0m9tcd76BqQk8FYet2Z8MLmeCugiD5AQkLWTCX+WBdIOwemmm49CT1ue?=
 =?us-ascii?Q?oXQlOtlvsS4GQ8FPRjtC6IDSbpXr+zoU9UVhoDoVkE7Wmq2HQ+6y6AR7QLYE?=
 =?us-ascii?Q?v6aXSokiGRZXT4bI+G9/RMI78VrdFmN/6mgFYQuqvZH+j+/aZkZbrza6gOeY?=
 =?us-ascii?Q?y5WHZEMGDaC74wh96da2QYVDLNcjBqYQlEKkJtAIcP8/121X//ysfURelOZC?=
 =?us-ascii?Q?3QRc8TDdPv9Z5r1dcJ2StLg5rNIbXcXae22FxC/rQ87XaK5ghaM1iThDR962?=
 =?us-ascii?Q?1TeuBT+24hO2DjxGphHygejPC2gpGY2ry2z+cudYFE848Q8d9ZHX1EI55mJM?=
 =?us-ascii?Q?f+KnAj6gAVGnJSWfxGoahcNQ9HHz5Omi/PBgbawmPywH2YS9PBw6I/+ryfkD?=
 =?us-ascii?Q?7DWZhY8UYkxYGr4ryvtzXRnuJVdRoUF5Ext0RC8yYNyENLT21J2t1bRupprD?=
 =?us-ascii?Q?0fzWqX44k3K/oT7BCIzZU2HNkL0/NA23bf+OSollErXcGeKrrKvnpJeCh2+W?=
 =?us-ascii?Q?RxLn/g7LaKHQuX4Tw4Jf27OI8oNmcB/XZ5Sf34YLkK4BPpvVi6e0zZKez+Xk?=
 =?us-ascii?Q?u9/8SWZspR4BwCbaRY/w/us1gRIyZpX0OTqZfAOqVu68jh4Tno4XDfY4/boe?=
 =?us-ascii?Q?DC8kSuWaY6nnrEnbbxiczXuVwNUZ8jqmeBrjHNxP/FQq4IFOac82eNwEfiXt?=
 =?us-ascii?Q?xWN2rX45LR23lUROOtS/LI5LvnDaw0yTWAa+k3eLuWUYfFgGdAgCo5VAgOiO?=
 =?us-ascii?Q?yJrMl/pKCpDII+z4E54mq6noeBPhhME/PrcP+fsjcGd+kfP/5XzADXwnp4Jv?=
 =?us-ascii?Q?L2Ge/6vkhhs3xAVQe2pGRNXR7fkIt8RDKjq2VJrrhp49FMPWgdkZJdpb3F6k?=
 =?us-ascii?Q?+Bb+pV0yTEGpBQMNfrLmXZ/miVUax8qjJIi58J6oAS+mSQPohtNJvHLQQ4iC?=
 =?us-ascii?Q?FSDS+5EVJrlX2mBADMN/hPWwb2Rz2wP186cN7goRuAuxgBPugbAMzhgNsN4J?=
 =?us-ascii?Q?sSjPhAyEix68QTiaaLLXv5UQzI24WPz2FfdqC0knCjRu3OwibG2yPeCvAaY1?=
 =?us-ascii?Q?N7Mv1gQLcZyBJxKXWZrv8Lk5bRebTJJ4YmSrQKBhdEGdk+FrOxpj1ac91CiN?=
 =?us-ascii?Q?h0XOYLAi9N49eH6G7XNCECQRCsSTnyqz2jTrHpqPmMNOOjvV5IxWY1LoWRCW?=
 =?us-ascii?Q?qzCrKuJ2AikXBH7rsmWg+A0S7o6IhiPZBGP7LJadPn6bJ1T91oP+VYCpAH5t?=
 =?us-ascii?Q?3+ZgcUiaxOAJ/FnfwjBzbKCjn2CvIQYDcbv9uqtBD7/UW7Y6Z/otEv6tTHY6?=
 =?us-ascii?Q?ztJUtOBuYfBvWqQ6I85oyqXx9Uwf5Sne3j1WAWQWqQ9B35TF0Ydk562e09H7?=
 =?us-ascii?Q?9fU/UWpR8g3fdk4gFF3eVnMn8NapemY2Ua60egjGv9/QfSRVCJOABJE/V/rb?=
 =?us-ascii?Q?kwSDu+6RYqSHKEYQEsrhgyyyS/3K4igKbitTxy91aKcNtXC6ROt7?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5dcfaf0-00ef-496a-f2dd-08decc4acf00
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:31:20.9730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/A5vyJW/xnryN9aB4AaN2Fj+OHHsp2BqTvfqHoWmBMxImvcl0jmgkxMFq5+A1T5BAWICa564GNDI1/Z00htzgVLJ2pH48c/9UgBj+2f6sU0HyBmvOoc2pUvEnXw7KT9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10286
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:31:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23177

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit fb0140774aff45b8dc326987cc1da89484ecb081 upstream.

Add the missing space to align to open pararenthesis.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251201134229.600817-2-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 2f4feaedaf97..d0c8e6fce025 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -225,8 +225,8 @@ static int rzv2h_rspi_receive(struct rzv2h_rspi_priv *r=
spi, void *rxbuf,
 }
=20
 static int rzv2h_rspi_transfer_one(struct spi_controller *controller,
-				  struct spi_device *spi,
-				  struct spi_transfer *transfer)
+				   struct spi_device *spi,
+				   struct spi_transfer *transfer)
 {
 	struct rzv2h_rspi_priv *rspi =3D spi_controller_get_devdata(controller);
 	unsigned int words_to_transfer, i;
--=20
2.54.0


