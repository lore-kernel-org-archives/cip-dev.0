Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED78CD98F4
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:31:45 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.5])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10769.1781685104207294512
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:31:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=lH8XRLAS;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.5, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UX8SPdMpqa2WhUv0smJLjFHnsTvqpMAyiwhYMBiCXF9DpWzKtgw2uI1E9KevFDYu+FilIoNVi0lcm1oMY+cWUj7BpgcEPwxeI7SgYfRbBBmUeDjWLJXvu8jgRJ9/AbCqREi5U++BHplFpY4pNhas/E9Otpojwx0tlqtxgqP2KZhqfmNls8oUlRBth1p9AbUAwWWMK94NEqRZkoaaFRSXULo5YTliPXbY5bGGxpEmJ3zDs5XSL94KzobViKm1bxi/cjHRS8PfPm+KAPzk2Y8Bt89/5DZDj3INy6xWBy1VyXr9NClRN6UhihDLq8EUqwVzrz79s90ztKE7nAhXdhJm5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRKPLCHAq4B8f0g663seilYByKbitEm8dkK6hvHAhiI=;
 b=msPTm5kNoP0nfuFG9bGZLzFdA+hUHLiGLQgv62ROewx3FIPTcpYb887kpCARLB0zWwMl2lhRg0i+zbzqb1hn+wr5ZS6gX0IH0hhN2Af2qdHw8XRbCX0lkNFcPf/x0HhIhHLUvteq0z/bkDWz+cj1hiO16VzMebV90o8Zbu0nQgmgwH2s5xNnYE/DAlymlUabyLHlzBmFBx7TFYVQI+3qfj/I0Ol1jjCFrUWybWlxhhBMuel05lsuEISXkIQq5xILUMBZ54sORhJLU0rt2N8iu6xMNPyHKRU47Rf/Qi/sdKUsYZAF69ax1yC7Qc64C98y9JJBqtTdrA0/kEmqMuT0fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRKPLCHAq4B8f0g663seilYByKbitEm8dkK6hvHAhiI=;
 b=lH8XRLASRse9Z8+TjKVNuHFyM/ey0ev4WsOBpKxKqsCY9dVeYWKsC0b+Dhlj15W1GWSaF8uwOI1XUTAwkP2W0fVZwgp3Y8L07rpuFqlafMI6mo3CqIQnypLConcjer4/4OgvN3tTzuoymmREX4YwZcmntAuaBW7OJm7ZnQ+XarU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8108.jpnprd01.prod.outlook.com (2603:1096:604:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:31:41 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:31:41 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 25/32] spi: rzv2h-rspi: split out PIO transfer
Date: Wed, 17 Jun 2026 10:29:56 +0200
Message-ID: <20260617083003.1071543-26-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: cc07633a-2b8b-4cd2-1a42-08decc4adb4c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|23010399003|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	DmaN1/horzqolhdINDxnb/MAmAAxXstp7T1FvR6q8W8PsH5kJDV+a5FmtwbD+nbd9HPJ10Grf87itIw21GKOPB+RUfz3hBAJnzdnnP4UUrmDZRAyc16qh8ehFe/rP7EB1zf0DfNDZFvxV8b77kjGErJ3cNLgfZeKk9GcOfGeueYV9RS6G9oW8FCjNRESNYu603Cqcm2YTFBBSVETtgSP4Xvcr4pgrAXrKVT64YipiaMvX39x/U+/grf82FgZ9QzpXS5JYCDnHRchYx8wQw7tTwLvpXef4ETRYKvp603bNLBR2wxPFwWNbdgX/ON/mBBzrHgwrWNfwCvrZ3Ee/tmIJSEJYdg5HNB8HLXIpyF5f5hJXlWp2/sJYEHgjn1YFdBAvnRnWxEPQUDs0dJ9fn1ZK8DuyfiUcnr7Zs+2MnHnrU5b+iTXXDx+fKsvwhMJFtCY3EuvEJPyiubYWcK7LoPDtu5XSlCNjHKWxU8EtHUXhA620bSudn41et4NvQsq07w83/geNwVB5t1RRbqZQcbas2BtqfMr03p4cSr/kbvxIURfdsRWE0B9tuaUOXLNOblLq7kL9tWcpi8SqafDqKBDa9XxO+HTZzETZCxaKqZHS2JmeOWZVxkSsuKfMlJbxG5JRSTZfQOLnpX9THnvL3Il77k64yUVs9mUJuk4LTzzTVuK4j3JHzqC+X5teLmqLSoi9uSx+Hb6cBV8PUBYKSEcIw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(23010399003)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NGd+WTIY6N0z00dQg/4zwoFBh7YfZK/RSFWkUUqwgejf/LhYksF6rj4uCcjx?=
 =?us-ascii?Q?vpaG7ny+xbvhDEroKR6sxsXvIW3b+d3rn9NuArIUnt6RKgAbtQ1CCfVu4Sf0?=
 =?us-ascii?Q?Mrgg6WFGt3d5SgaXqwUrWNp2xPRoKttBGwyopS+xaWy2EeCsTEXc80Mc6/iY?=
 =?us-ascii?Q?FqGMdHZXQsPTkGmEg69i8R6luCRuIdlsqWTMRqXO3Qw+nIsXcMr8tQVs0pEa?=
 =?us-ascii?Q?8kxeOclMvLkX3URCecSdc4reBStf/n1zOjeL7fDDfDTJhmRHRlGVXTaLimPM?=
 =?us-ascii?Q?n1V+xIKO/wVHsj74xSkYdPwrj3slmpzgwtOyltS9pqfBdgSkaO/foZ+pWKbv?=
 =?us-ascii?Q?IUyq76InxuZaRpuLoUacPNtwPVX0hSeWb+/0OBZGnVXzJ9qqB/pUfpSE5mxG?=
 =?us-ascii?Q?8/B6kwtMiqvjUjjldozQWDYIpmNT3SROv/aBfoi9ceWmHUxPyLydpwT13QGU?=
 =?us-ascii?Q?l1U8e14kFPCZEw1hY8HxD3STmyOyBezpq/V2OVv1w76iqFqM0wivBIG/A96r?=
 =?us-ascii?Q?QGqTyUnWQvcnuewcDCWc+gA7v/0eJK8Lm21L8NE5FZhswDdS+PNwR/pKo9sl?=
 =?us-ascii?Q?VV8i7gX8J+G6iBiLiSBuMfZUBXwR92sDJcRwriXgnrhAcxxq/gBtEgt3h+Bb?=
 =?us-ascii?Q?xJFLhIi7wYE2J2sSuk+l8h4mfrFRHhywpoJtrdhzltNGosHjDTyjtaBtYeKb?=
 =?us-ascii?Q?BL9X9RWpjWwT6Ob0U+mwzODMVDVfNyKAtPheQgIQixr2JcXlJvhFPBldVpi4?=
 =?us-ascii?Q?y4tjby2+mbf+9e3lk48LFRyXEEQ/4f5JKYvXJl/LqBDX3AVfwzi6iUkLRQqv?=
 =?us-ascii?Q?vZbDp3SbKI5DNw/w6Q+2Y5nPtnFRMYr4mWNMvVML5OseEciV46neSBoYAOYq?=
 =?us-ascii?Q?G6j1dGcKzwwS+6wQ6lkqrk77UGLNDpvv1CFDCnl0XjdT6dzbf1ad9y72x8mZ?=
 =?us-ascii?Q?6sGN6tedSi5uAdlrrw2jfoXn4wHRpIX9gbfsf2ToE4Vhzk/0DRHJEsMg4+uM?=
 =?us-ascii?Q?4SM81/jZn+UX38XdUxQpNkKfNqwKvmRCGnt+O00uEhva4ZQGBJbEscCpFquJ?=
 =?us-ascii?Q?+jLnoa1DNDHekpnAkT/kebNTJ6eG2j/Jx7w2VNKqh66RzumfWxI0JTyFKzYX?=
 =?us-ascii?Q?padwu20Zo/6/7YZ0n8Es28LiHcew97kXrySEoBTfUYJOL4x1iUWlDgGUkpd6?=
 =?us-ascii?Q?iUDbz1eBUsE5hYptFJf5H4WpIbhyhYFbu2XiA6eSP76gBXL3bZ6Axy1XRmjO?=
 =?us-ascii?Q?ilrsGmGPWuSfJbluTvOXMAzt4vKvG1exoFPwFVUppGqAz/L6ZI0yj/DjRiqq?=
 =?us-ascii?Q?/wh8gtcYsykL8u9O0UOQVCGd5CVuyFrhxj7BORHzkYHURI9a9DrVlJzU0UAu?=
 =?us-ascii?Q?Xp9SIXb60hBlaaiG5h9pWRzdwfYkgMhZsrB5jqXrJ0c5b3ad+Yme/vqj5Hcf?=
 =?us-ascii?Q?ts3pUJC5l2sV27dMe1tzAcexcMKuk/tPU3frFs43tbDdpZ9QcpGd5FzLtYtL?=
 =?us-ascii?Q?sXvM51ij1waOTND1fI2wnFXDMha6wFc0P7m6pfrkYtd0nOpgVx6R1e9u7aYF?=
 =?us-ascii?Q?9NMyxqOuQoCF3weBuH9fBfsC3hyi0AgBRn+KD8vc8fhgqWdBjhDZ0yKLWKdO?=
 =?us-ascii?Q?1C2xatiTQoKg/c9pASxYRmZrMA1wi1Vf7v75IIeiVFmtiOWEDwfGo+g4eGx3?=
 =?us-ascii?Q?W7yNd1mD4paQ2sWU4PPMQhfXYyK597HWPAmR/dapS5ueTv3dW4XeKeTJ12hZ?=
 =?us-ascii?Q?XyJgNQSsPvZg+XIAD9M315qQZdC66weT26zQziiH60SAyRrK7Sxi?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc07633a-2b8b-4cd2-1a42-08decc4adb4c
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:31:41.5740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ekxq02V93DDxUyJW8JZtwT4THo0/ajnr/c14/3ToF1TcqnfAc30myTHbboJ6q+1T4zjGZiHRjQZD/BPi7EuTw0se/PLrrdc0KMT0LhIWYxKFzBifd4k/r7U2P5nvX41T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8108
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:31:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23184

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit 1e5e10df8b9be71ca64435cbe7c96b189e5ee293 upstream.

In preparation for implementing DMA support, split out the PIO transfer
code into its own function.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251201134229.600817-10-cosmin-gabriel.tani=
slav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index ffdf8d8c490c..3191eaddc9d5 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -219,17 +219,14 @@ static int rzv2h_rspi_receive(struct rzv2h_rspi_priv =
*rspi, void *rxbuf,
 	return 0;
 }
=20
-static int rzv2h_rspi_transfer_one(struct spi_controller *controller,
+static int rzv2h_rspi_transfer_pio(struct rzv2h_rspi_priv *rspi,
 				   struct spi_device *spi,
-				   struct spi_transfer *transfer)
+				   struct spi_transfer *transfer,
+				   unsigned int words_to_transfer)
 {
-	struct rzv2h_rspi_priv *rspi =3D spi_controller_get_devdata(controller);
-	unsigned int words_to_transfer, i;
+	unsigned int i;
 	int ret =3D 0;
=20
-	transfer->effective_speed_hz =3D rspi->freq;
-	words_to_transfer =3D transfer->len / rspi->bytes_per_word;
-
 	for (i =3D 0; i < words_to_transfer; i++) {
 		rzv2h_rspi_clear_all_irqs(rspi);
=20
@@ -240,6 +237,22 @@ static int rzv2h_rspi_transfer_one(struct spi_controll=
er *controller,
 			break;
 	}
=20
+	return ret;
+}
+
+static int rzv2h_rspi_transfer_one(struct spi_controller *controller,
+				   struct spi_device *spi,
+				   struct spi_transfer *transfer)
+{
+	struct rzv2h_rspi_priv *rspi =3D spi_controller_get_devdata(controller);
+	unsigned int words_to_transfer;
+	int ret;
+
+	transfer->effective_speed_hz =3D rspi->freq;
+	words_to_transfer =3D transfer->len / rspi->bytes_per_word;
+
+	ret =3D rzv2h_rspi_transfer_pio(rspi, spi, transfer, words_to_transfer);
+
 	rzv2h_rspi_clear_all_irqs(rspi);
=20
 	return ret;
--=20
2.54.0


