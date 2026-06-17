Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBA9CD98EE
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:31:45 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10764.1781685095186416275
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:31:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=UJwIv5dq;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.45, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PE6igoMLRoUSaR/r6bWs0L7RE7gvQQm29jcCGnPEsQobq6GfyBmNK2oqeZCkw+MWyqU8nu6LETM4s4woUubKEbxqpH7xMKrRNY1slIsUJC9U7rTwwwRR990vSyG1GFTDjzRj6bRyUglVtinZy3b87wMRnzUv18wWqEtrBSN9yTinaV/6yKXqX74vJc0hbyi9zI0RPIOIuXCLJwdhXkoRSLnN8q+Gg0PdVbtASiLO+Sn/9gIhHduE2fwmH3Jt6ENqfmAW1zCJeuquJ420JUo4FBcZFtpUVk9RpDx7POvwpbh+/V2GAdn8Q1ZIF2s23bs3jg3SHFJrHBkVMPGchoQQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81VCrZTuYl1fjKmZnm7PlmmV7Ibe7k3UCkcyqaEhM/8=;
 b=hEeKA5uOmi94H5d0asmXR+sfs9Yit+dv//Q1Rpz+asv03WYLcDO8sqhNyNqgeAvyTdKOpU4mgldw82HXL3i0+kI7flIBeApsRZKzfwbLlnENc9H+ku7Rah4yXAZnF26oyzHDgaD5KQt7NGyl4QXh/hxlQh9TN83SL0Gv90L8px4JhiUBwVSw60VjlyHEsQ8nUzeQKiQ9+lGUQGyD9oM/bn1JensCK78P8yh5Xj0J/PTJTHQYG4abv2L3g10kvZv1Rv+UkhuhVMcVD/fkJ/dFzp9lDcjZfeOD+3ikMApJxVmzaOQcQ9Q75RA+1PYzku5wdLeSKGNUeOAA72XPOi9/Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81VCrZTuYl1fjKmZnm7PlmmV7Ibe7k3UCkcyqaEhM/8=;
 b=UJwIv5dquOLPFHn61DEmJmhmJAtql9lunxHp5a/jO7HeAXGFVD/8b3tBFpxLQWPj/5Suh8R5DdaZZaveE31iaZ3FeketjCPWAT2uVAt9zapMedeBqkt53bMpuJT1rYNa5Hvds4npS7l5EuTlRtsBkL/GGlW2hgCqt2nSntNap7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8108.jpnprd01.prod.outlook.com (2603:1096:604:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:31:33 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:31:32 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 22/32] spi: rzv2h-rspi: set MUST_RX/MUST_TX
Date: Wed, 17 Jun 2026 10:29:53 +0200
Message-ID: <20260617083003.1071543-23-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSZPR01MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 614721e5-2ea1-4a6a-1c03-08decc4ad621
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|23010399003|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	pws6WigvRVx5cofmZ2/yLzKDY66Q/lo0X87oHhAb1o0YLE7at89ELr3nVyYGWlILqCtLEX9XaUkDClBOGSkP/8DuCj0NFu0TcwklK7W+6Zt5a3qx3xn3Xd9wo3lmhxTmg5VaCIwuO8ec26SwquVVDuekvKJJHNIPoawD7JBsGQ4gGRsnyaVjjW6n3byoxcJpGpen2falNyfZt3R/vOg8TuFannkWNtXXGNSDQSm3h83GKItiSpQTSIgQ3ejxsBJpwIk1JZdqICOaWfw2BmmyVKsDQCV4dSkbAFmj87loXzjBhRoH5w1wnaPwD+PPjFFBV1ewMgqSbPsVyZGAV9u6xy2cWDO2LWlCz0+Gy7iOYKRJOW/kHbLHisz/VfBhu2XqV5+ynkdGIOx5g0E791g68NkqTCD0fxG8peI+wR7ghohn1NR5d0oGEwX7t3Mp8JbJca0+tXvLsKewh1JF2G3rMwp+47+3lB2iKKY+34LpEVBSI3Gok8cXVN1ZmWoM66K06Lo9v176ekSsggQvUw839eOLjXs7Hd5ATfGva9ppwKGSYh+HsI3pOZp9uUiLyHL2QQj+i1pYjKBfaIUSzgKnngzU5Uwf8i6obhl/0NOpzx0Rz/Pg0aMrtUM4f3h6fvIGlp/Z4xGrCVsjzboYEQT4BnF0PnLRm+GAEOhtFW/NM1fn2B5V6IUi3z+rz5/Y1HOQ6WsRH4w+VfASINf4NN6jqQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(23010399003)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1pXm/g0NQx1FNdcLsaaxCsYO+EIW6Ka4ERySCOytaZblddAo+pwikWkJXYqU?=
 =?us-ascii?Q?qSiUHeQVqEfCyE/XajijjethwEzeArW4/tyELeY8zVdPwYRJ+YJKi6Ymp+d/?=
 =?us-ascii?Q?XYi35YVxGebTH+UGIIZC7NpCUZkIxi/ME8r3jv/C+BEkS8sHSSzu0DSxdR+K?=
 =?us-ascii?Q?SrEiLIH1x0cBtWJ/wWTa1NyLXW9fvit8oJ2ZNCEHhTHC70BrYAg4pqR2RGmJ?=
 =?us-ascii?Q?rRQ8i0CpZCl6BHcqDsUHTJcw+PB/RJlyeoO8fHkWzku2/dcgoEyHAFUAxoMh?=
 =?us-ascii?Q?FLA7sh97sXPx9Wc3BEmQtmfIUJnSp7TYK3xFdo0oY3D7emdHF7GND4SqyCIW?=
 =?us-ascii?Q?UjMlvB5lx6PMrUCxnCu33vJeOktbJV94cvFMrupO0ORFMgDyju0AcXocQtyw?=
 =?us-ascii?Q?/sM93WvOkH7KOD6TnclLHU/jDm9NQrujivWObIMIORxwn/o04fKj2XPCRMYe?=
 =?us-ascii?Q?CMLRf8qNk5dyg09HBTYqcCfAiuZdejR1ClOBRYXTwYHbiQli5vD6+JgggbAB?=
 =?us-ascii?Q?xs0GieNuRmwu00e9tD+p9m8nIMvrvgJq8tzQFQ3fS0AxFwd/ka3XbGX2agJR?=
 =?us-ascii?Q?bc1JM6QJaN/0qmbugSbbdcChMV4ptPVX0rR7Dgfao/uXwzWF7hRSNiYkKzAa?=
 =?us-ascii?Q?KiEToThOZ1ifkitGWKM6Dch1G6JWRCVVMv6O9eNH18xPEANlYiZT5EbryU/s?=
 =?us-ascii?Q?bV50buLhh6tzu7AHpy+AXRcx8SkBMifcchQxNfYTMW/EHPKvbL+8u8wScfzv?=
 =?us-ascii?Q?RhxUwtTJyyT74q2/D5w4r2MNdTgvJbgwD2hSS4nF1x0jZthxuRRtNeXSK0s9?=
 =?us-ascii?Q?8ZrS5WdNFAV1fNsTmgIF1pxWsxR9u1lv1MJceWPIERjK8o3zlJoWXYCdy9mq?=
 =?us-ascii?Q?MQlGFGX5i5FxIDw85Fan+w0dhANs8jIc2JOGqUIL5nv2Ruy7oEjRD6uKXLFg?=
 =?us-ascii?Q?tM03QcpHXgSw1+Ul1ZsAgW1tKEbajGvOS3MK0dEXIY+azJF6MskkpfKFhXvR?=
 =?us-ascii?Q?ioKpRqRAaYxO4079Tcer+EvzuUfkX4OgC8DVoNLqc4TY04HVxEtvu4HzWLXp?=
 =?us-ascii?Q?bXXOIht2LRv2XKQAhIO8xNK7R4MQBZD8u27i/U+DNna2mFu3RMHlaPiRii47?=
 =?us-ascii?Q?NvhMVBA0Ph1vY3rIrE+bYMYr5wLxeUCHq7vuCnWdhfX9MEEQB7F9x3apfdNE?=
 =?us-ascii?Q?XeC4B0sbaIhC3CZ7PDswyn18xoXlFSDm82B3Uuqqn1xuNt+ShRSssdFo5BVr?=
 =?us-ascii?Q?sOhcJabv6Xfqw6PJ2OObh354IuNHeEuaJS7JH4RiHFSyOfEAjR0sXJjUpyV0?=
 =?us-ascii?Q?gu7+Y4ZtoRemJ/guOvclAiImNlYP8oh0HXtN6E0jZeF9bjRxxYkUYDTVAhMS?=
 =?us-ascii?Q?/vNRjA/V+SOhFrtxGpOJcKwl9BrHUgVc+IiYnm2YvmcZP57ByDZJR33YivOP?=
 =?us-ascii?Q?3lV4CkuZmWEV1v3ou5t6WmsvB23yE3h/6urWfrx6EUv6JgQdqat3+yqdeaY/?=
 =?us-ascii?Q?sOFSUMSbVRH65S5IEGA5PHy69/iCss3DELgB0NgWDV3YbMLMiqx28//2+gU8?=
 =?us-ascii?Q?rJRLeMHaipqm/EQ50fkmnIdCsmQS7BjhbBQPyY797kWpBWkcmGHC+W3M8/XP?=
 =?us-ascii?Q?sM4iOOqQu7WBkdoKF7ifBUQdbm3NOdASzjtuN6pDa+aUgUKNfnOyx3jUUYO+?=
 =?us-ascii?Q?qxWGzSxoIgzVPOIbg2aZF4NaoXqUy2HxzVDkjsxUHF3/Q3/9u2KAwN0bBz6a?=
 =?us-ascii?Q?1VWSISe3/hZ3kNIx5bBE3c8FsOau5t7ymqAdtfJqBBFwpXA9uQbG?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614721e5-2ea1-4a6a-1c03-08decc4ad621
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:31:32.8790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUF4XQO9QXjrd1P3CqNnoaqTBVh4+JA9psg2AagYUjB73/PwoEGmbGcLg4EjE4e5xXkgsXol/3TKtsQ5kno4CbArBs6RP9Tsvk/xeigI+hSlrLJBY62RpAhQdSW9XIHe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8108
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:31:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23181

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit 6f9026b5a18acdf190d1622831b100aacfca0eb3 upstream.

In preparation for implementing DMA support, set MUST_RX and MUST_TX
flags on the controller so that we always receive non-NULL buffers.

The PIO mode already handles this manually by checking if rx_buf/tx_buf
are set on the transfer, and doing a dummy read/write if not.

DMA will not be able to implement this special handling, and although
the SPI controller advertises support for transmit-only or receive-only
transfers via SPCR's register TXMD bitfield, it does not seem to work.

Remove the special handling for PIO and let the SPI controller core
handle it.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251201134229.600817-7-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index df1eab16cefd..c5e66d188cc5 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -113,11 +113,7 @@ struct rzv2h_rspi_priv {
 static inline void rzv2h_rspi_tx_##type(struct rzv2h_rspi_priv *rspi,	\
 					const void *txbuf,		\
 					unsigned int index) {		\
-	type buf =3D 0;							\
-									\
-	if (txbuf)							\
-		buf =3D ((type *)txbuf)[index];				\
-									\
+	type buf =3D ((type *)txbuf)[index];				\
 	func(buf, rspi->base + RSPI_SPDR);				\
 }
=20
@@ -126,9 +122,7 @@ static inline void rzv2h_rspi_rx_##type(struct rzv2h_rs=
pi_priv *rspi,	\
 					void *rxbuf,			\
 					unsigned int index) {		\
 	type buf =3D func(rspi->base + RSPI_SPDR);			\
-									\
-	if (rxbuf)							\
-		((type *)rxbuf)[index] =3D buf;				\
+	((type *)rxbuf)[index] =3D buf;					\
 }
=20
 RZV2H_RSPI_TX(writel, u32)
@@ -615,6 +609,7 @@ static int rzv2h_rspi_probe(struct platform_device *pde=
v)
=20
 	controller->mode_bits =3D SPI_CPHA | SPI_CPOL | SPI_CS_HIGH |
 				SPI_LSB_FIRST | SPI_LOOP;
+	controller->flags =3D SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;
 	controller->bits_per_word_mask =3D SPI_BPW_RANGE_MASK(4, 32);
 	controller->prepare_message =3D rzv2h_rspi_prepare_message;
 	controller->unprepare_message =3D rzv2h_rspi_unprepare_message;
--=20
2.54.0


