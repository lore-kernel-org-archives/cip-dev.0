Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E353BCD98F3
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:36:16 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.20])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11001.1781685369963926563
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:36:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=agvKnsGq;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.20, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NigGIzXqcJN3f73O5ZwJ7xfEY9ZTET+2jxormZz3oqIs/40Bv38M563JqWjmb5YBAmhv98TZHImWwS0nuxNCmSTyYlApPv4WwnKotHL0PL9AGBrvN0P6CNk5in79pwAfWNG8+AxZNRBmxlTEqyfP5nFUMwy/PBquF8FSKFy3wCnNLwnNVrBqMDdps7/FxQfvKSqTipHtjsWKgiQueosNZlyrsHofV/YWjlNjZNBrRdMINb+KLmnoHUKkx00f4hFwVqftZFHI6GIip41vYQAbrZnrrD1xKnx04f/YKSgViKrFxf7qUxvfryVCxelBHfYsLuIx5snca52rkd2qXcVaFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6KYAAWWeu/fc/knZDfEfSTdnoIY8FMNkCdH2lcTQN4=;
 b=TkONK/+wUw73VJIk+5ft8TxVfiueYGmBLpWP2gUfHX2S/l4AYoMQ0qdlN5t/5IRDvoPVQhowAPVfA9GjiLeoQ50/asC5bsl1xd3UovaifqLHUlgVmumYYwFYfjiEFD5MAmPFA6IO4JA+Z4TfhgYlMhDLXEcZV7b8AIBTSzZAAZPNw44uy6Flj2TCpR156eERl4rbTqp9qEvOAcdevHVnAKr2GREvQBksjusKjoWIRRZBueF/fsyf9HTLXddi0fo1I3GMshnR+Ca8eTlFfinJAsdM+oJdtz9Kexw9jwieunrvDgm7UD9UFOQk6Bio3RCgnTId7EDxvLOeKcds0gI5sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6KYAAWWeu/fc/knZDfEfSTdnoIY8FMNkCdH2lcTQN4=;
 b=agvKnsGq2qOadmij9brHqWU9WxRe28zDLPhMrZ6JCk1HAKVo8vbLD8oVTN8uHQDZEUx8QzJ3Ehp/Fbp90p4ym9voKwpwu6+B5qia+7Nq5GQ6TujsTbTcN9hsrMyfh56ch8rUwFK1o0KmJYoXqzI+cqEuIz4+LyGzMsr+OgIRDtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY4PR01MB12634.jpnprd01.prod.outlook.com (2603:1096:405:1ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:36:06 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:36:06 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 14/24] spi: rzv2h-rspi: set TX FIFO threshold to 0
Date: Wed, 17 Jun 2026 10:34:52 +0200
Message-ID: <20260617083502.1074160-15-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY4PR01MB12634:EE_
X-MS-Office365-Filtering-Correlation-Id: f729ea3f-7f7a-4061-1c82-08decc4b794b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|52116014|366016|376014|11063799006|56012099006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	hflLDk1DZU7Snfg7BXjBQ+rzuL5RJZgE58W93rIG6TP28xZG4+Gvi12pOsL8pcD4uHGRrnVqx18U098cIpZCYHOi8l+ng9anTgXFdi/Ljnr2ek+6FATjlD8Hvi22QOHPIvEZwvi+g/o5C4HgIcoDpgcy2XDz0KIsaCBKSox8OQxiYKhz3OHE/m1CgQDTaRtru6LfLUM9U7UDyw6p38BYF1+dPVlPlUw/6YYvNg00CA1q4fCZfNDvQNoWhaI07NwfEiBLhifdXa1Wan4Tpeg05p+v5F/4PX1x9JrQ4kSSwGt7sYMrsGGUOsuKnItEL6apUoPg9wUU8eIwqhNAf/MGcIoyEy8eKqV45bgGqv+ees/ENX8CHxDjq9kod4aiqPa0l3rkQ1p3TFEo299IVgXsI29SpjZK94Vtxkyj5yIhl5Fyrdn5zFWnE1Wft3gQEAupr4lBL6f3l2HYRAO0qK7elEtXegNheNkrQnz3+/grQfi05iIxSxxG3dRKWSopmZU0rgN7VcZGfIFP8+fYxV8jERwk+eePTAg7sUwGdTm/7cdgeNiHXEKALQplBZLxHW08B7Q+/9greyBDQDvR23f4zNBXnxCFpl0V+HW9Q93qZLPoMQJVRhvwP1tfohtg80OHYOZm4jtbpXRo7wpk8VuabImEiEqXWIcKOe2uWNFCk36bjZsDxbZMw2bld4Grdt6VE6GS72uLXz45y/JLbxYL8w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(52116014)(366016)(376014)(11063799006)(56012099006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Zt/v6t1pb017kvaE3tHYN9iYDD8nCPnsZ5dgbU6YTnQkajfANSzvcuNsZN58?=
 =?us-ascii?Q?yPKYYQvIq41r+cR3w3W+IRAksdiD2p0JV1b4A00heQp8YlpoIOX40KFspHpt?=
 =?us-ascii?Q?eAORsoTDeeceaGsDk3Vw6X1YZm7hpCxv4isD4kcAPO+k4mKTSGoVeMYm4D2B?=
 =?us-ascii?Q?PZ4BNa94Pn38dcB8rP6X3HUBruoXaoyu8Zi5MieD6Q3JoaPA9hSNn0B8TV4n?=
 =?us-ascii?Q?vXFI12589H0MoGcCfq4UAmscjZ2IHQbYPVpcHwThLksxwApKlulQV0WF0iuy?=
 =?us-ascii?Q?j3euI6wdry9VVAs8bE4xY7G76P5oRHp2BAbYhFtefKeQjbZZgCsEXacJvAEi?=
 =?us-ascii?Q?nyi/WwTojPtTBe8mwOLnYD93FkWukU3+bIag+Ge3Ooa6RBxSFRJz/yHFcjCM?=
 =?us-ascii?Q?pLXqmHuXamcJghp7B++yUlMw0zEulVG03Hw3FjVCIGD+d9d/3N72uj9vdsYt?=
 =?us-ascii?Q?c9sgmWvofcWHKVYxhFhLs6O8uA1SvD5pokM/+fAcc0M8/L0B5sqTI4xcxDE/?=
 =?us-ascii?Q?9EIKyYVdQxY7scDoCQjsNQNMaMH/ssYGJUsoeo/yzefqej/jniiJwnDawFvh?=
 =?us-ascii?Q?4bVHcY4SO5w6FpB+/1OmXDIbxnwDfGZ9EAIN0/6hNGSQeXS/rh5aQVY9M8js?=
 =?us-ascii?Q?gYf1KVaf8QLLuTzZk3C2Jvtp89x9/Ll5qoGnBy0WMOIydA0/A2kxDTdThgsT?=
 =?us-ascii?Q?7bL0z5EQFPoX9X1l39sHYVhRYtEg3dNoDpMgC/nZrpBCFVGlIZM45E/HRpwA?=
 =?us-ascii?Q?jQY+muZjZodkxZGuPJbGInhDVItwtIkOGYKKHEGAeUz6PZFQgPJlDCzBR++p?=
 =?us-ascii?Q?8VcIAHKzrdauGJofMkDsl1CIJp+Jg0zNsNfK/TruDd7TqbCfLEu+E4b5TQOA?=
 =?us-ascii?Q?i8XLph7jN8j0izQBkqjhciynV910HSKD0J1teriEpAZOrBV1vWxHadjdZ7wX?=
 =?us-ascii?Q?E3JaEBjwI12kzLtX9KkJ5icw/mbyxslow0YZCVWi+DWl/VEXuqu4GZtp+J2h?=
 =?us-ascii?Q?t+j/bTwCgyPFR6CK8iaN0Smd2U+wB8VCJqI0v9mUylGgWJ1uquG1P3uPedZ8?=
 =?us-ascii?Q?HWD8wggA8xSHruBhWAvy6cj5hAxxng9bindgE4XFQe/Xt3w28GaakYE4WL2f?=
 =?us-ascii?Q?4RRs/9J7ncyB0AChKt5Nwgix3VdfpnrS6zuuxYULue6mmMqcgfdjcqIbMcx/?=
 =?us-ascii?Q?R4KrnowqEdWWVzqRp+mIwVKWkcWaKZnULLWjUytCO2KpHV6R4oHuZfe9PF0b?=
 =?us-ascii?Q?+4AFHhAVq4PC3y4LduJ/RsINeXxLaiSu+FOZofOvo7Uyhy2BnQTGVSxGW7Gs?=
 =?us-ascii?Q?G2Zn7mBR+vPPtKESA5eCtZ81/MEnlLBiNaG9tncXZqieIgCrA7zLWo5iNyfh?=
 =?us-ascii?Q?3j5Tn00ZO2BBThpPtcnprBabkPEBZxNEcLw3XJ4VhSdk8gkSLzX7UBHbRZoh?=
 =?us-ascii?Q?4aselc+l/oTcw5IYZJfMQby+7pQoQfzCy5mk1MNeWEagG+zdGCKdRjGmAzgS?=
 =?us-ascii?Q?u1NEQMzuR8Jm7BWGkDDW3Lhn9xYoLRaYFNYYK8AJjwYKDGailECdObA4iG8t?=
 =?us-ascii?Q?gG5yf+4SR9WaeLo/uibdTQ3u/RMKo15k52P8apOyDX0vjPM00cgLUL/iLkGq?=
 =?us-ascii?Q?i/FwR6vhQHgFRTM+upMEH7O+qKUKoWmouugqKwzf9VJEfiFVqO8hxXnTVrBv?=
 =?us-ascii?Q?hEb+qHHKCDEWTEqAubi+Fcwug0MZAn9Ll9DWg3908K0lrsg19m/ovW+awnsB?=
 =?us-ascii?Q?be7qRZIbq/eFuq2ZydemJHufvQIlY3fr7boPW1SdtT4u6bp4LUQf?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f729ea3f-7f7a-4061-1c82-08decc4b794b
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:36:06.3643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4qvHhqFR8U5XvTCEgvd/N9Y7OrtnpOYi6rPGh90cOm5QW4xyU1TvzHDYR4Q78xw2BpZPxtb2oqnkf4aK7nj/800EIFX5vBiy4encnbOW29yiL67UNG8tu+CFTkyqb8U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12634
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:36:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23206

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit a886baaaa6e12a9b7d5a9687d11d3b895f1b87c9 upstream.

In PIO mode we send data word-by-word, and wait for the received data
to be available after each sent word, making no use of the TX interrupt.

In DMA mode, we need to set the RX and TX FIFO thresholds to 0, as
described in the User Manual.

In preparation for implementing DMA support, set TX FIFO threshold to 0,
as RX FIFO threshold is already 0.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251201134229.600817-8-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index f0bbbd21c763..83bb0b7400b2 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -501,7 +501,7 @@ static int rzv2h_rspi_prepare_message(struct spi_contro=
ller *ctlr,
 		writeb(0, rspi->base + RSPI_SSLP);
=20
 	/* Setup FIFO thresholds */
-	conf16 =3D FIELD_PREP(RSPI_SPDCR2_TTRG, rspi->info->fifo_size - 1);
+	conf16 =3D FIELD_PREP(RSPI_SPDCR2_TTRG, 0);
 	conf16 |=3D FIELD_PREP(RSPI_SPDCR2_RTRG, 0);
 	writew(conf16, rspi->base + RSPI_SPDCR2);
=20
--=20
2.54.0


