Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14F1CD98F0
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:36:06 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.40])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11000.1781685365972080763
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:36:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=B8q2vRXG;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.40, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGqkNJ/P4VkG2pvr7rAidCFyA63XYjuksCPG4Da2RVI9nKMQBbFdZbed8B/pHIr/NNqS7aRebtla6QiIvYAcOnIpNSDwxK3NAx3F/9cL+u/KJF1zZWKKeGb0EKGaA1+WWwHhOwNIjgkeXrG+VIMSw+R0++FH16GtwVWvlIj6cm/ip0xteGIwee3bfh1FZYZfHAaVQE9zF12vc9vZi3Fout6R2a89aIjgoLNyx1tWEAwJXjzstFxnE65pzxXbiw5MLHA8PRhHc8/+jHyg651euYkc7+KZ2HD8LihYOCPOq7ICXV2uz/8Ky2f/py5G/7yuNKHJMoDExRO+sqlBHXaRUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwMu30akKzVewEisp8qLcwzuWNkHQViO8UUC0jNjhFU=;
 b=O2AzoZBmUIOWG2cjCFyHYFxChfcFdUBTq6yCJXa6AxDfPkp0wiCmQT1e9LoNOTP/BAvDuBs/UWa95mW5iE4T4/hY5rQwYwy3WouhxpPjiIJgC112+lp5ToiJ7JpXFfP7tNwsr+1zHk8oeITc4flk/hbM3X5Ewvj/hwUIBH7PLFfhb6SSPhTj3cRs2LzrCrj5oMnRQCLfqUVX0ak7+yP2O1FLhPa1tbq44Qsyt4XoTJhGvlbKB9601NyDqmtJSl8o6TMjM6n/ebtEPyXRx6aDMX3MNKAki8rEbdKUI0+A4PmNaAYJM7WpVz0FesFSp5lTOjd6aX4TxXmwghNoHmdAlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwMu30akKzVewEisp8qLcwzuWNkHQViO8UUC0jNjhFU=;
 b=B8q2vRXGeeYIw8V+UYozR1AE7NNVha5CdOX7QoAr6dEPH7EgzudKG7j2P3A0VqKbL4Yg14LMry4ytnMIQknoB/Dc5HTXtR8o1IJbbKPDUnARuP94Z6uIT6CzFlUJs/kJEENWqjw90+lu1TCH2nMZfxtOej899U0Inh3Z91mld5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY4PR01MB12634.jpnprd01.prod.outlook.com (2603:1096:405:1ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:36:03 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:36:03 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 13/24] spi: rzv2h-rspi: set MUST_RX/MUST_TX
Date: Wed, 17 Jun 2026 10:34:51 +0200
Message-ID: <20260617083502.1074160-14-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 41cf6fbf-0616-4ee9-ffa2-08decc4b7772
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|52116014|366016|376014|11063799006|56012099006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	k/gVZbIG6WE1vSD16+zxvFiQIKPO4o5COOdcJPt37+WeiTGPNR0yAcDnqVQqbRDPcxgQZEyq9hZQoz2ICEWQnmdOk4A2aOibXmARYkas5SAQ4s7/ty/W0iOeHIzGT7bTtQdfNhiZV4Pm3K71ml41f3lQW0gdZ0A9NByiTopJMG6djjaRbQqgWt7g7W3NfOqIKJyNky4a3RvU8/c7XiXSrMZLvQ6TFazP4B2KxnSKkNljDZa0OCPiOg7FYbQQ5tPMMqPV69dMNJ/vFuOWZqMAdDwZKCVy0sOifx3XvPwVOWZ9qFs4qN+b9wYKCzjOw9zrXsyrX01nbfBrNhSmSKRC9TZNfL7JSMI2EQn+InFckxMpUFWUDdg1KCWwzmbNApFXJZCu//3z3syeww7RiLjASJGHsK+gW+/nsRuNNAIUcla1w1OGXme5JyA5DmNUOIBYHzct2PoxkAqB+meW+fMdunkQTPyPrvDYdk8rijlV6EEsm3yQ7+5YPrOYqpIeHa2Weh+W9HCxJBIIULOj7PiUqEJMSyaTjXLYqifwNtqA/Pa/sIAyWXZknUrTFwXI57SRrfxN3sMp5xy78WdLDrV+XGRqB6+rW6sGv14jOK8GH9xnJz5tJzYi5NF7ompl1kXzjHCg8XP5a0uuW99Xk22Ih9WuLXmxXwQSVcFY1z6VJ955dznY6KyVQbg4FB7dyzj9Wp7vVyEexVZXyL2tmrIWsQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(52116014)(366016)(376014)(11063799006)(56012099006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Vtv5XAlQPpA6a187K7babKr6RrDLBk5CjpFmMjjNR1XSRwarAE71U2rJJ0ER?=
 =?us-ascii?Q?cBsuf/cPETo+EEm8l6ZfS+1DTVcn3xaQ51+GbENN2ZF/N2pd5b2c9EB1Nn8Q?=
 =?us-ascii?Q?oIwhDtZgkbDvgIpKkS60peRpqteoxnJlPgUfl8DLxiSNunp6XRayQJn0l8ZN?=
 =?us-ascii?Q?5Mu2t9+esfo+rUeXyjMgSpx/IQKgRvyRkVStk/kEVKrccz66AIU2LdIEsph6?=
 =?us-ascii?Q?1rvZomB8j2p8T71FJegw/4WO3IBkTLfrFacGFDnQVy1GSe9+su1cIdf9LtQX?=
 =?us-ascii?Q?0QKz7GGa1qJOC0UlG38VSuRaI7j8f42qZyGHPusHH4LqIKhVJhd2vEubcdp+?=
 =?us-ascii?Q?fQ6Ak4MkHudDdW+Nd/M/Xo516dFBRQt4xedj0mxcxzYOXWZ8ORMrVx7eXnUq?=
 =?us-ascii?Q?22xr7wVkg+4aQizultQuE08OwOM3mvJuK9EkNfwXuGUxU3XYkgnGexs774pZ?=
 =?us-ascii?Q?mMWIQSsB/rhqVNifABSYUGcNriY5btTJDv4Q8zt1Sr1u1vw/bOi6R6alBbCb?=
 =?us-ascii?Q?aYvez8VmzFnHrwgBHhbkicfBMnaq0DfcFlckaXC3/Qn0FBwzIU+CrDGGvvEk?=
 =?us-ascii?Q?1EJIIDPwv+OaqVeTYjasjQZ7KQ9cNoxbMBmdHlet88eAe+4SvKVdir8ELTHk?=
 =?us-ascii?Q?shqgFfWa68Tb72ASPDBy28/Fg9WMvzZUGymr6HynCUmxUr78Ga6WqpgWCoPj?=
 =?us-ascii?Q?SqlyPyPO+V0XTX/ZyZqVI8pz5fFWGcsASgK9Hmouehx/tV19I50pwFV9L2k5?=
 =?us-ascii?Q?XPCHM3HzdalQk3071OHB5b+ns0TyT4j2u1cVKfCgWr4fuw7jZWzvS8A4hfrL?=
 =?us-ascii?Q?oicH85077WOhroWy2Q4w6Ak/skie3bcpUPXTe0TjYsqVuxusj7XcEkJ7r5Jr?=
 =?us-ascii?Q?LIdjFQwZrvYLAQJ/1AdsFAisze5n7jXDT3wFzc53a9ALuqQ/+XdPsCi4YfAo?=
 =?us-ascii?Q?5ZN5OUj7IpoPdAuVOsUJPruPnAURtFFF0aRvMQFYYdxJgEGOymUmcEQBCZ7Q?=
 =?us-ascii?Q?mFcIkGOGdmKLZ/CpqRDS4n5HeXFL+1GABAeWvwy589kJMhkX3fRyC0u/ZnAP?=
 =?us-ascii?Q?b3Q+HUBAN3srZJWa55LnKx/SeammG3ubDWz7qq95QP1yAPHkjOncX47QSTya?=
 =?us-ascii?Q?KzuhS2+JFbr7Dr4A4LhjCIwA8DFrOzhsHN8ru71WQ+SkN6GJbaRcdbWqyLnK?=
 =?us-ascii?Q?NSlFDsPaZyTZ/r2yemXtoYNnPngfcKmtLmz9l3fXL/v9f2cNG/9/i6VPCd1D?=
 =?us-ascii?Q?N39OaQ8tlsMJ7gFmYUpia3SRVPyZWcpcT0ZhBxSQxvBZJsaCJAHIIXqbUtsE?=
 =?us-ascii?Q?kh69RgNENY49El2grDsX31YlJXJpXcpDUF4WXseekGo7IU06hq8CACwTyb4F?=
 =?us-ascii?Q?8QzwpmtjXnUp5VW+IGLtHWlhkARsN6iZjp7F3WpINqTrconObfQBVjT5YGHf?=
 =?us-ascii?Q?yVk2vAwety3F/JvmEk/SV3w40B9wTYbdoX3HAuCUkQRwFmT6Yj5Y2ubrpr3O?=
 =?us-ascii?Q?hdVpB14KPT3qsDQvrihDqjvFU98OSArX642rkiAq37lWnFnHvIBamnEdWRZ8?=
 =?us-ascii?Q?TgouHiDooUfAeRwT17tiQ1z4MJAi2qK6EEvWPqzIsECD9+BjTJGKY3fJPsSk?=
 =?us-ascii?Q?Mls0CAaLZdgsn9yzhW3vAGwTJknYyPDZPGmzUo9BRT0eaeLfc7AK+Uy+c/xT?=
 =?us-ascii?Q?Puz+vo68taabtIMNHSJ/9abIVS6ia9oCqQdMAfe+fA8LNzvqXaV1snkD6kqe?=
 =?us-ascii?Q?iGcR9voZqhshHf5D1TTSNn14KeBFPYB36fMAUgYMb/hTDCz1zroy?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41cf6fbf-0616-4ee9-ffa2-08decc4b7772
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:36:03.5092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIEeCvdyTSXmqNyW4yr2M4AxGdqs6dpF37sE/oaNoDqdlusXJwYJdYKCk78Tki4Ca0qbHuBmWo/kqd3VvSLdWX1uLjmmcHh2NLBVK4uyNDJu36rYnSyqeHEu/CPrPjzi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12634
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:36:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23205

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
index 50fd7ddef58d..f0bbbd21c763 100644
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
@@ -596,6 +590,7 @@ static int rzv2h_rspi_probe(struct platform_device *pde=
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


