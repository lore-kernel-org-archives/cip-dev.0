Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A628ECF6AB0
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:31:10 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.35])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3032.1767864656958039376
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:30:57 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ZEEW+zu2;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.35, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCE1r0v8IgBHBWZ3lTmRKazkwDvaptZJCoVv8YnuAeMZvLsI8sCNWBv6dEYr7IA47iF0/itpyufJfG6z1DdXao/ILhdiAiu5YDD2ok1k4eZpxu/GN5buTUaO67j5ST0sGxeVTJ5UZA0PDOFFLJBT9ZYAmX2El/kCeVGGimgUUygL0cMeKclW/1Tpp7DjkNBSrLK/4GWt1Cz2mFnhWlTZ+t3/hbZOtJHBdFWmFgxRo6F20+HcZ6r9yFJYEP932lnH8S4oWgv0Ymr9EOwA2c8vtqN7ZQ7ZzlyjKMcN9QFU2TxUXGx2tbZQu/4KBbOHCwwpC18+duUYM4jynU/HOLobBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mpe8s7L36hmW8woCZMx/7+TI5NjZFdsxxvq3577ZNbI=;
 b=kZiVs8/K+NHgwNffWGwbDDf/wITAe2KGudKXu/FBebYi7tGRAzsfsnw6in2ztnd8l5WHa3tL+TX7fhjScfABr1nOCOTs6MamwE2NscqrjdfEL1keLfCvHFeEcXwo2hZ0ii48rgc97Mc6TtGk9YcXG/qHy98T8yZCR8bc0ZBYMVBjqgB9YMKhsNFIHJ6YtKI6ZmSSPEDJ7hE0ovuFSaop6rjtzh/6Ql7+qiqpWmwc28Lxcf0uKh7Y9KHXZVAcZWVMbKt7yENZVI0hLaQzH3SxsdoxShQV+FUh+aSousxWgFHWAaVHFEGmfrBFgVmsw20YkqKbVOZxYrBHk7koZTqaDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mpe8s7L36hmW8woCZMx/7+TI5NjZFdsxxvq3577ZNbI=;
 b=ZEEW+zu27epXUVNMMAaEEqEshdlMn6hP9KI6rlRwZdSvvbDbqm+J/8tpHhukXWJds/49Ur9AeN++8EQPPpkxTVYF5HImk7hjAQLa//TD8se7qJDawhvuLsTumdkTH612EXfsnm2dZHK1xyM7Dokqau+5/W/joqiRfOmWzDi2JJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14326.jpnprd01.prod.outlook.com (2603:1096:405:240::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.1; Thu, 8 Jan
 2026 09:30:53 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:30:53 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 03/19] i3c: controllers do not need to depend on I3C
Date: Thu,  8 Jan 2026 10:30:07 +0100
Message-ID: <20260108093023.489513-4-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::13) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY7PR01MB14326:EE_
X-MS-Office365-Filtering-Correlation-Id: c109cba4-95fc-4511-f467-08de4e989e57
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?WQZTE0J52u4DL497+JFmUZDbbOW0OGFXAij/jbGFbmMolLLsaWO9yivCHAlH?=
 =?us-ascii?Q?TVwlMQx+tmEjAH1FUiBCXR7wfI0zrfX9bMlH0CzbLIPICqhMf2HzwWUrx6Pn?=
 =?us-ascii?Q?SlnsjWrsUYi9j0CX9n29kvrKunLKC2yN/tF7Zs3LFROdeqK7TswSwb2ZHd7a?=
 =?us-ascii?Q?JCeC7qI9sVz3pGoppx6axLR7DoWVHzJdiAMFRvpf8YpCg44cEvZr70R4ko3f?=
 =?us-ascii?Q?YZuHG9LGDoY+elVvD+ShinlfJiFvDa3bF7LwepmbFFh5UQKX0wrXqBz/Fned?=
 =?us-ascii?Q?u/WQ+HneHgXcC/s6Ba4yrJZNSedEYCMU1twzFc87VZC2VWltskYProvxHPHY?=
 =?us-ascii?Q?CGUz7ySXJ/66keCUx9pvObRsSN6NK2z3tgvmYQvSWcnNI6HcU+ugQ1va0vo7?=
 =?us-ascii?Q?ue7az08a1O0nJJMXx7ud5kvjWPj0pp9GNvgEN4Uisg4JQJard4XCezf0PMph?=
 =?us-ascii?Q?sylsr5mu+VgqqjcClsOsHyptvf3ZC93iBkCEUq6f3dMrZ+NLxWBUebngYIuA?=
 =?us-ascii?Q?5y22Qfci1ueyXZAp8R3H4Mc8xq6plmQJPO89JO2my6rSpdeMjM2HgOMuLcD9?=
 =?us-ascii?Q?ix4keoeL+oj2LBg0g7SNmKBfpGKYK1mCEyy5RgmA+wXbhZUora6xqCKePso2?=
 =?us-ascii?Q?Mbl+Df/GFk9ZxrmTvBTMJfR6Py3UQkuOUfBGKXm/DoRnFRtsvtSy/SS52NTC?=
 =?us-ascii?Q?1Ew6hNx7/cwAIfsZC51U50ASeX1zi1L5aAcKofP5OyCSl1dg5s/kO1L/mf9s?=
 =?us-ascii?Q?7zPGihpLnfXT/U0Lh5BN5Arl0dMvLm3wDPets4hHVmkOjobRIM7I1s1iYcwi?=
 =?us-ascii?Q?b6nWEZ29eYjDGxEAxOtEtK4MwaIoNMLaVj2ce/dNkDITy1nZHrnv1wcTREHX?=
 =?us-ascii?Q?SjSYQqjCye5RDTC9erxdje2s9i3RARUZzw4ZQ7Mpgv3CD5NGITiXQdqFjDBf?=
 =?us-ascii?Q?NWahAKt6HPnK5+uJf1vkTZTjwwxb0k0BUy8PrV7rvBQnEFQrUjF++YmAvYZr?=
 =?us-ascii?Q?eLPPhJcNgZVLG7GfHEMVZcncCOVhY5g4FYq5EG3ubBD1wxJoPiQecqplDRvZ?=
 =?us-ascii?Q?J+QlNhi7GYHwkjdckTgsJJYT5FRZ+iIP/EtigfQeNHKPK2wZEkqaiwdXZdZz?=
 =?us-ascii?Q?ggKD+Vl+WpGqkRBLO2JrqwCM5yl4PgIYHLvQvM/iIvGWSRB6BFkYCw8tasSJ?=
 =?us-ascii?Q?Nlm5i0D3yUZkQnOTAossTs8vIKLczDYYd1PlAFKdpn8ZBdLxgVyQn1CzkMcJ?=
 =?us-ascii?Q?5lP2gI1Hxz7nOw1ukw1ScCmEtmSFD6hmzFbLldCGJMrJ4CULahuOyS7H+l6R?=
 =?us-ascii?Q?Pvl9DYl3UVvYX18pDNGk150zPMeATM8rVLD40fIwn+H/PURgCdBVWSgTnKlc?=
 =?us-ascii?Q?lq+oKxWqAM7wgM5oh2QRqLnYNmVUkLOdGOaYA/kWJb4oQK9n7upACS/ZcdAw?=
 =?us-ascii?Q?iHJJ12vmH6P4sXAz80ePIF1PXwxjXRc6hbCDYCoSJTINOJWiBYXE4Sl19WZq?=
 =?us-ascii?Q?HLeTT4WN80HH3tVXVsiH9iZVpp985koM26TD?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xl7t331qL1iMv1V+666MNiq0lhvIHuLZbysAIbfbC+NymRx18MwF+OkAWsin?=
 =?us-ascii?Q?VEWusjEfBSpOzyyEM+BDkAf2F1N9B//jKWRG+Q0Qv50DnmCf428QkYLKDRes?=
 =?us-ascii?Q?pLnOh6W4c0DcR81p1Be8yuZxVHZYDJEt6JAB8BohOKKgo1yiXtenIBVoQsJo?=
 =?us-ascii?Q?CfkHzIr7BBm5ihvHSMSBQTFm0Jw7GwTiXSXBpy2o7kkS0SffDGKT6Ig5DHJz?=
 =?us-ascii?Q?A2U1P94Ve6px9r6TwyAbX5FU3ER+4Ey8YuIeKBv/Bza7t4LxT9X6kLJJzgkd?=
 =?us-ascii?Q?b0gohpliFUfzFUxiAptKEe4w5ZrZR6o8XVvuchOScAnJDJyYrlLKiyGaXSV0?=
 =?us-ascii?Q?tpF7JBrNhU4lpUDL3+taqY9AUxfFXJvCz+/m8+yH6vyvpm8J/fTY2ZKZSf4F?=
 =?us-ascii?Q?Kqm+zcY4suYy2mKkD3ihq/ZDVWTnkLA4HA6lt4z521O0bOipet1op0qRE0HV?=
 =?us-ascii?Q?5CG7Ytc4CgmbXoBhQxRMpGg70RzXkE35c8c21IFOjNSLHXnvH6RonIb+SYpW?=
 =?us-ascii?Q?5UgOidltFnsbjoVzmSxldLZ/3cFk5/eJB5/OtnzdCuMD2JeGH6miSEz0N1UT?=
 =?us-ascii?Q?6Fdm7jb75c11gG5miDQ6N3L6ejTQS3e2oXnclLX+n3+cABA1mVzJiu0lP8Ah?=
 =?us-ascii?Q?hNearT8SmyaHHIpCCtZYIqYLx2jJOMcsCo/Uz0yp5+YXFPcC7CENAyoJBZ/L?=
 =?us-ascii?Q?l832ph9o1f974nUqb6zOM89HrmRBSL98WpSkBh40o3j667Re9TQ314cK3XOI?=
 =?us-ascii?Q?lOCEYIKleU3O32LCDOi3JO5f+X9+C9/eKiSWXWgMWKEZyklCkL/SUB9BlFVj?=
 =?us-ascii?Q?x9HViT9WidAMJyYVIxKUriCanYuY7KSV1pb6s80/40RJjh4QvgyWwx7Qkm0h?=
 =?us-ascii?Q?tmZD+StZP9pjKzygPDsv33ExBKbSmjbgpUPTUpd1NCSmNqXgb4HG4GNdTNG+?=
 =?us-ascii?Q?3hqMP2VMkTCrGinkOUYuWKhnWa9JMONYWR+FSuFc7GLKcjrmkD2H02cW2VaU?=
 =?us-ascii?Q?kjdf9GwL4ZCSXL2+l1BVWHLuT2QVzywaWiNmmflbZtmKfB5wEngkfYPjkahQ?=
 =?us-ascii?Q?ORQIziE7IAhYNmydXx3k9LHMS8msPV6ojXRHK4fSYZYBzjzP6LowcUFtM1WC?=
 =?us-ascii?Q?j52XoPkikAdm1keMD4dPl0PZvgtG6SQ3ryilKQubnnKpFBpTh4srvs3OHSHy?=
 =?us-ascii?Q?qLu8NzCrR6i/D9tylFjNj3nDeaXIe/NtnNeKJWq9FpCW4VvAzJpTht3sHlcn?=
 =?us-ascii?Q?wN1S6h2eYfHRQZ6ebNPKx/DmQrnVuqqZh49+IWSgwqfVtF3glDzzrlY2nVmv?=
 =?us-ascii?Q?LjID05uMhRqT9tzT/Tb2hIX4W/4q8lZfKGVfvyOylAiNscrpxMdNT7mYzqHL?=
 =?us-ascii?Q?ryszC4xagwH5xM+Mdp7Y9FBwuPtN7W4JneZizTAt7UtmmKJtRntuCesZjkPd?=
 =?us-ascii?Q?ejBIvUVO4cCzU4eUv8gQFLfs62pQE8pFnYnyrJG6yG6SaM6mPaGhqsMLXn91?=
 =?us-ascii?Q?cA4/ERB5OQK44k06umKnAfJnoTIkvzx2vuNh/3WDCXGTqF3gfHFFsAzzjnYD?=
 =?us-ascii?Q?ozHysQJaiZNk4dTUgxuTeeL4/pjqF95Ph9x+dZhyc2Ge/dPAOQK/FA8HrOLJ?=
 =?us-ascii?Q?IQKhVr1/R5F0kv6awzO8CDVsP5dAEq1BCY0kwSTcsG34dW45y6Lwn1l1Ggoa?=
 =?us-ascii?Q?7tWW0cqFB/RTbX2kbpWUDwztxg1n6jSjrdSUVgPV/qypNmcyE3N7r3Im0FiB?=
 =?us-ascii?Q?jP/28Yb3SuNx8bwxPTTjMcm/934XLs5W1nr/yY4EkAnnDn3kQb2R?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c109cba4-95fc-4511-f467-08de4e989e57
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:30:53.4760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWcPBA6MsfGCpbMQmXpAmW7w4uYFpCjas/FeJtoN9cJc7pAweg9HQ7Lv4SlPx2l7kPRo6msewTsVGMd2uw3HuVU72brC3obIJ93p3uG1IsEGFfdTIWkKXqbtFiM0DV+5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14326
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:31:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21462

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 00286d7d643d3c98e48d9cc3a9f471b37154f462 upstream.

The Kconfig file for controller drivers is only sourced if the I3C
symbol is enabled. No need to check for that in individual drivers.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20250506075247.1545-2-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/i3c/master/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
index 77da199c7413..7b30db3253af 100644
--- a/drivers/i3c/master/Kconfig
+++ b/drivers/i3c/master/Kconfig
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config CDNS_I3C_MASTER
 	tristate "Cadence I3C master driver"
-	depends on I3C
 	depends on HAS_IOMEM
 	depends on !(ALPHA || PARISC)
 	help
@@ -9,7 +8,6 @@ config CDNS_I3C_MASTER
=20
 config DW_I3C_MASTER
 	tristate "Synospsys DesignWare I3C master driver"
-	depends on I3C
 	depends on HAS_IOMEM
 	depends on !(ALPHA || PARISC)
 	# ALPHA and PARISC needs {read,write}sl()
@@ -38,7 +36,6 @@ config AST2600_I3C_MASTER
=20
 config SVC_I3C_MASTER
 	tristate "Silvaco I3C Dual-Role Master driver"
-	depends on I3C
 	depends on HAS_IOMEM
 	depends on !(ALPHA || PARISC)
 	help
@@ -46,7 +43,6 @@ config SVC_I3C_MASTER
=20
 config MIPI_I3C_HCI
 	tristate "MIPI I3C Host Controller Interface driver (EXPERIMENTAL)"
-	depends on I3C
 	depends on HAS_IOMEM
 	help
 	  Support for hardware following the MIPI Aliance's I3C Host Controller
--=20
2.43.0


