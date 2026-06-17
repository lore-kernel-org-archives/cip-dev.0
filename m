Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DD7CD98EE
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:35:56 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.7])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10823.1781685351277537932
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:35:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=LaPCgm/D;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.7, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adiXvFjgYJ4NStmqpz3giKPQ3za/NfZE3cC57dznhVx/bJyo6WL9pMo6kFhebd0b7Vydks4US1ONpNZojbtB8YcUGHPWTZrlAaphvT1mEtpWBYUlpYbVWT3Y2pnFrtyduqJA3vNN7bTRcxiqpHO9oFBNobkieD6XzjZis2T0zHv5JzNQRAc0u0YBt7xHORqfb8EEwUa8da6tmgDJKFSF0xKdw42ceOvJjZhP2hYgNNtMQRxeI6qKWhkREfDuFanQCYGnFMe4n+2GGQJDpRlkWypS0fVLKPG3z97PafPsgj3qckE+V1GL+znyRpNmJ+wh1uJkmCVxFxji9EKObUL7IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgiQwkmW5oFB4Z7lYub2qRKZx05ypj8yu5Q1OCLQuYg=;
 b=XXIgOgkPH8wRPSXsjGBp6lYzgyZqBwEDQiqB7/pmAB89w0xysRkBRp7cDzn90ew0wOkEeaF8r1b2zlMik2AG69QVJFlG8MouVE1JVy7vu/RJ0GlivyQiDPatEq2sxzFT28FBSP6NyWCfs8d9jVQoU1JWoaZfPGQW3gpHpUB3oGbO2oJnhywyIGXGf+4WvEFBS7wATQX8za4KSN4hzwL7F/Ht/BoQ7t2guVOmPwm+y0Mf2Hzwb5tSMYtNvxQhsw+leNcgphMzezMWdnXDssRA2QOduhur7FoeSQcGwiN/dXQlZI6Ow4LJ02ieBbdxaYVCrjgQTMnMIdC1YJRMd7R6QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgiQwkmW5oFB4Z7lYub2qRKZx05ypj8yu5Q1OCLQuYg=;
 b=LaPCgm/DD+Z5OiaHp9xY7oUTI3wK3bnjIIp7AxDwQSJ0J0ex1MmOz3DpXa42HJvHSRPt37xfXbVHL1rqH1kH6hbZd2DLrB6KyLfhc6zSp2xTyg85jQf4DEovrHlf7e9HJCF/X6GKJBCDhOr2y+OmpLxA8xPzYulw6d4cree1xnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYYPR01MB13245.jpnprd01.prod.outlook.com (2603:1096:405:162::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:35:48 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:35:48 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 08/24] spi: rzv2h-rspi: fix rzv2h_rspi_transfer_one() indentation
Date: Wed, 17 Jun 2026 10:34:46 +0200
Message-ID: <20260617083502.1074160-9-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::23) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYYPR01MB13245:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd09f07-bfb9-4541-da81-08decc4b6e39
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|52116014|376014|1800799024|56012099006|11063799006|22082099003|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info: 
	zlhlKVac9R/y2sPm81viLKS9wPXIHwYbowqSufKYRm3T5EP2samsG1WWO9rylsdZUi/jnIJzNYMezwMTptDBnPuHGdeHH8+uBTC/BLtd+cUXXTwpcyg8CsUogpNvXjUowV556dF8fFUfSCNkyepyyAAM0Ux4I016Q7wRpNiBs9hibQo25ioMrw3FpXKES2M1SVDVqoxALyG54+IHV0x+5iRioFmSERbMQqbZRn+tBGtolmEWNfzKF77g04IyWmiCcJ463QcoPecc1cdVsPtEnKWSJUsH+Pq77rplLdUk3LX1ANlpPkfMBw1+/u38Q87KUUfY9Uo0O9HyCpxJ+rJMm82FSle13QzcbbhmoluetVrxNbdqzH52ZDzvHGPdPfD+R5dhI3kuyAgU+U8Qau7Bv5ThfDAexKcI6MLIaHik1VVVORSQBAQEHXX/6fG7gckFTfTYPTGbi+2o4qzd+TNFBfu1pNK5IPMFfTbedrQ/8I+mRYcFnQ1xeTitxwnpekL6nN1V3nJbmNJjgXrxqqnm2jk/km6qWXmGSNw3034hdoFNH7SCUtSd6beRSCO+Nec/EpgnRYLhQG7MK6wK/hxNHV6jJrs2Ot7uo/DscPQZoe6mDQ5WTQ6iagDHtR3xLelMeTp8B6QGF2zD1l7dETvojbubUfa8hA8fVQ1Rxa0XT1zoSQ/kSCJx0/GoAA6JO8SjMbLd9n311+V2Crh3tOmNxg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(52116014)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(38350700014)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bdj916zjuw7g/Ay6dg/mJgbrI1ujHcFPuHDP3cGuO0Jyka/Z+7Rax3C6FRSQ?=
 =?us-ascii?Q?lmHMcfs8J+J7DIpYvdFOa/kF8u9CM+y7C/GM2cpOidNX9ZQQ5f9k5zbRlnbG?=
 =?us-ascii?Q?P+6XDNgXeyuIuUyoXMbYaVj/YI94AJ4WSwJTZwVe9uwXGEypOvZr5t6lucFB?=
 =?us-ascii?Q?yTxKAP7rAuucOOzsK505KL3bDa1pSkg6kq2soLRJ9AKyhA8pEAoPy5n+hO/K?=
 =?us-ascii?Q?EQfrPelobN0V8MkwYVNQwx5Ht8HGNUOFsqVZnx/sAAk4DMM6mKmCLDQ6y4+h?=
 =?us-ascii?Q?QgwGAOHDTvETl4aSmkx8Te3c4sUkDqPlZV2bg1dW72STGiB5TIpEqjO1Ekn9?=
 =?us-ascii?Q?aqthirkl3BQWif1P9D88B9Asq5z4xl4KwOrohtFX5zR6YLHXfsSiFQYqaFkH?=
 =?us-ascii?Q?219idJP0E3BMIrZDSQaJ/MpMNGyNspN59BvX2IJQN1mM9iGxcpfvWMHUMM/s?=
 =?us-ascii?Q?baK8QH7zneQa3DWpR49xJroSyyCqtXEaEkS7TBlGbRmp6oVlMlFRBEgPyQgg?=
 =?us-ascii?Q?V45YcCHDpRKNH4pZf+iCjcV3L3GbnIVgvKPIBnAM1HsOxAHEB5BKyLT4pnRf?=
 =?us-ascii?Q?5WKAeJjga/d/UBVGuzHBDrrASRtKWdLzvbFhoryWziMAF/ZniXuE6rukYyNu?=
 =?us-ascii?Q?4t3glXqBlMcn5/wQQJLUdY/c9Ba09ajQcSB0peCDbgcGd8pa/cgEci0T6+Bg?=
 =?us-ascii?Q?ykLifmuLi30gowBHX9VSFe5lnmycgWJZ8OU6Tu8TUAAQjHBZLSWS+U4Q+v1a?=
 =?us-ascii?Q?NBXgE9JrzdlZcGN2Stl1YtgDpLYGe2F8IZgZq3GFPrCOSJShndOJ2y2IkhaS?=
 =?us-ascii?Q?r/nyQrkWrx/3ZyKtSPJcGhjqtU+pNY73BsaqZW2lgoyBLq2YoTkqn666tmKr?=
 =?us-ascii?Q?quO0YyZzLDmCltG7iyJ9+PvWJbzWiGr9/OSXNb1UOhfDJctjb9TYZD5S5wRo?=
 =?us-ascii?Q?Yi4zbfSp7+EOdI1npFQnrYJ2eQ1sL/lmxaFsPO4pl6Wc4jdtd3blOdRSSSOv?=
 =?us-ascii?Q?qU8U8R+n4EhyLlMXtuFQvJsq6WhkdedHb5HV3kpo96E6xO76Yr1FPYqfMra0?=
 =?us-ascii?Q?5A5zeB/7sukecGfAhYQ9PTkmAP/lnWEFmTULGB9uepwExIDAOh0i2F7tUkER?=
 =?us-ascii?Q?zQed11YNpIRW1Z7xuRNtGhqPNph5h34pNsko52ZdG/OdatBNyqGvxaAjtDgI?=
 =?us-ascii?Q?OKtelHtI94oVwZO8PgEcvUxroF2ey+GU4iE3SDVdJG8SyuMObBdTjqszl+et?=
 =?us-ascii?Q?Rqe/EfsIgVQT1Md7uVP5yZzShAXRY63rMn+caRe3N+G6RSZHJDlWlGzpivaD?=
 =?us-ascii?Q?1oZCnMyLZclnZuMa6qk9b2aQ2wUIBq/mLeW8u0D7TNpBHXep9lX35Kc1MxlP?=
 =?us-ascii?Q?ENfOWGaM33oeJLCWnNgJXeYho4XftpYd8aEzpJyHbAYePCq9OnepLnNLS/E9?=
 =?us-ascii?Q?Ojct8rt2wSOkfuZqEvrN6ht2oysp5QENedL946PdccXbI06B46F5F0x4OjRO?=
 =?us-ascii?Q?uutNJgsMWe3JASLMeylaQRl0JYt5YyQWQV9RjZwfo6tJ2ofjt6CBjSqvjZrJ?=
 =?us-ascii?Q?WncIqPO332l0DScJSDwM2H/AgYysABomyV+8mew82CfhHwCbBfiL7cRO3cme?=
 =?us-ascii?Q?+o/ZugLMLaTo0oXPcf+d6a7E64Cfk0XoDf4p+WE/hzaCkR+MBZefJeATYswH?=
 =?us-ascii?Q?gPVIhoFkaynVDcbsszsl9vt0DbP4M6vr+L83HB/Sgdhprj5aGa7RjrIlSZ7h?=
 =?us-ascii?Q?251yhj3wnRnS/lUrvzdoVPHFQ2y8aDbHXdmGhVq+droCzn1HVnEE?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd09f07-bfb9-4541-da81-08decc4b6e39
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:35:48.1192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IbHtkXn4TWDCdSyWWaLyZ69QF89jQGeF1uuixGKPFt/Ob2tvoS0c1u1XBD0x1RehDt1xSXIsxGbEPLlsFbqh3bk5azcepoI43kV3i7/8CG/y1ey1G353/VIJHzVnTJof
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13245
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:35:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23200

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
index 1db7e4e5d64e..8cffc9cb6b6b 100644
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


