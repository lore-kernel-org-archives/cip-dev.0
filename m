Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB8FCD98EE
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:31:05 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.40])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10739.1781685055262869849
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:30:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=rXw8GPcr;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.40, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAREYAnBynA1jgx+ZL1zb8M3fwHQunfzRl/wtKQP0koKBmqFS9qoua5svFRiqiSoMJbHiUEWhp/hDuqh14k6TouTTRjfyXrdRwS1y5ROVFyQcnIjDMhWQyqZ6UoGK031eLaCtDCyCmXAvs7f0FmyxKbZQ6CDmt1VS93SEYWci1yTbO1m0UpCRcrr2HXAU1n/IBWa36/yYLkAdjis83xOMKbVeY3zIXoW7GDj5Ab6ijse489LDbg8Xccp/nxX3XQU8S9rrNwUz6NDHLyau8IRBT/iJpez/RlKStEfWG1P388QphVuAnbxnmgiBFV4ui9fYqxMHeiPS3vx6Eu8yefTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LW+kDWC+HeXDL/edrxEUMnjULVpf0oMNLWvPdPt3L88=;
 b=wXrXwOqcCWNHZ3Yd2rYTNCp7mWLmD3vTtJlAHiy6NqiVrPE8WDpkGoICcozrNFv0QVwW4S7smq1ulJ2RwGzFD4/QsnZIq0sGTydpQxj1gOVbZag2H//0RphbinDTyGY4mTKmoGvEh+B0ATB44GcBoE/ObV5BU44ce+l48Xb7lhandAfNVUctu+sk4O3w0mk99BFOSpyczvM3IgzlSCA9fFrhJ+1rlovsTXkOxp/51l5GUdBUdMSKnJkkDNlgvblaz9dLY5ztLuLFtsG8qPu735ixplCkdOV/EDrAeW8MIckgrIp4rucl/TFZSdwZ32eWoV5BD0ScFW01UvGa1Le7cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LW+kDWC+HeXDL/edrxEUMnjULVpf0oMNLWvPdPt3L88=;
 b=rXw8GPcrHd/inUvycXk85U2qBkPc42TMU+V6MvCBmSYpL3bb9ioN9XZBTTP/S9GHaskZRegn7M6LnHaD1vq/gi6umWLgrr6u+c+REWolrkZrBuqbLsPd3NaTdc6eI+1qZKF8OZpRTu7/40DwvKYJPXIsu+to9vuSW2rAYTxK9qM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8217.jpnprd01.prod.outlook.com (2603:1096:604:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:30:52 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:30:50 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 08/32] spi: rzv2h-rspi: make resets optional
Date: Wed, 17 Jun 2026 10:29:39 +0200
Message-ID: <20260617083003.1071543-9-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSZPR01MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ccf6ed2-157e-4ff2-ad73-08decc4abcf5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|56012099006|11063799006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	OpXoTvl4ETR8y3dRS50eOAtaaSl6M8UR8XqmjifPju+cJRESSaW4XiFhIDnkjUpq1reMjoP+u3YoaniHHlPhlPFWfa3+VoN5dk06KSU9dE/rf10JFqXXAf99jvK1cHxfLt0DvTnt/uCEzGgg/K3NLMcvGqSEdYx8uLC+/wVAZDAa27czM4qifs6D00j80gCa56kMoYdfLNcrbN3pyOo/KbHzvjK0cG4wVNZpq8UCjyZ0HeSpUF5WuncV3yQe0cvPWRdx+loM6NOAEHo0ERD2c9ZCDZ44bwteIOaPb/oCYKukoWQ2ISnJetLIa/BGpUXV5kDGyUCN1n8XdoLE2X4r4GAQ/ULXRDmYWCJ80SjnRRsj7kCZxXgTFWGTULqTWt0fZ38N3oMZVXUzf5TL2EDZP9SFN9rUgYi9n/Tcdb6JkMu92Sg9RjQRrEMXp0teDhW2V84gQg8x3J0Qxm3qNwp4XDGkTEb0VqHGGmfyRV2mA8CeFD69BkNQGI+YdSH1PcNP9aKcZVUbGLeQsWw5DBftrPQRo5glTn3Zco3UAt+1xDhTnSxoGbQkzJxhteBZ8d3JpBz3GVphqaPHg/dBQjHVgEvJ9GlnNdBBontKSxsauK6z5SxqEg4IylwF2m/Dk2SfrWAzF7rsZWFkljW7sqfMY7NRhQL+tZsuN2VoE9mmQkGtwI/Gfc3f0JvSXPA5+AsYLmvc6Z7XT3xzD/IaHynSzA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?d9HbTOqritPU/B3H0LsuOwqsoWXMctvQcMc9IIc7Hnn+k84TNRV3ASQp/MK/?=
 =?us-ascii?Q?5+X3xdaMJBASI5jRbc69ag3c1b4Hq7vvm6XaHXM609R4LGqhHpaOul/FIo5a?=
 =?us-ascii?Q?jgdSVTbVnitK8aRD+VVEGdR855vVjwciGgdwguzDDFW8xM2y+zWqRs5RGm+m?=
 =?us-ascii?Q?Xb4/MqWSGpFdCh0eLo04qR2UUJNI8v3pwDjXmGp4vMZlpUDq+2kpFzhpJPj+?=
 =?us-ascii?Q?ZtJE591A6q1QC0NM8pOWV7c2XXAjrRE3pa1673w/YjUV5TpAZAjrQZ3C4rhb?=
 =?us-ascii?Q?e8A7WDoj79q5HrlhLHbskMJx/CCciy76OarsuQt8hQcl0bKxuHWQJHY0Q8zZ?=
 =?us-ascii?Q?WVJV7KuyP8v75rKCIR1XI/yH5vcSfTNvRw8SZjovw5xKJYmf9jMF+WHsrwiG?=
 =?us-ascii?Q?b8vYZxzG4qs9XRdq8taqlr4ItxmIpMaSRBnsH2gAGjm9l3nxgE7UV1TKwqZI?=
 =?us-ascii?Q?UYQDLeDraND452Hg0o2DdZFbFSHl6q45WYlxkGMiQCzhGyToduvLqUP98JGO?=
 =?us-ascii?Q?DBPimWFLPWWc+x80sSTEA0uxXKqyhyjoB4IxU/EfyN9pznuRaL2As2w4gjDd?=
 =?us-ascii?Q?t9dy6sGuLHIBMxB0Fn210QUht/sZ771bYbPVVzK83kdZEtAElIX1pCOnodbH?=
 =?us-ascii?Q?TePtVAHWrhvgEzbbb9iFOLgdAHVihtwFJpqDEv6+TBMiqxE2ih4YY3sc/YMT?=
 =?us-ascii?Q?VYBNKCDAUGIUb9dHsUiCky1F7JixXK2VRd1bL+bHIG2X/hTBqTbMsZW06bnM?=
 =?us-ascii?Q?Zqu8grav7eCy9jwHmtP/ilWb6MumTgponHEvLrKZ2AgiY6yUZeoyHUP4Umno?=
 =?us-ascii?Q?IUplZrNfwX57BjDwVoTDoFY19TYczSpMivwq1kVLYwXrskGpOzuddhW5l85J?=
 =?us-ascii?Q?uCvzjMYU/JBRnjRIpKsuRe4NPJdNtkEI4Yr0+O1ulk26z2CQnvF4pEYW9Uux?=
 =?us-ascii?Q?WltQv9oMAcgtvNr/votTDDE6pRcbXEewucNoxghbmfeStT1bFPrsmGmAMb9S?=
 =?us-ascii?Q?r9g+ELlfZYGccLKJW1TzNtouZGRFMnY4j11Bhsoa1HWbJ4bO6mvwkRMyR0Ye?=
 =?us-ascii?Q?CWdzy04LjVebTMLHoKD9WUfKoiN11xfbY7Fs3V7HZL3RcI5yVVDksmLvTODf?=
 =?us-ascii?Q?KOFUADVcB6IGCOrINl+G8L/dy/EGjbdPLpiBGY0iDi1rQE95k1Pa7iM2oBM/?=
 =?us-ascii?Q?WUeY1xobcciT1RQcRtadGEnMdrH38nxR1Sr2u6jYxkuw+2XbjoLrlkeKJUFs?=
 =?us-ascii?Q?teUjPZwZGKg7Pfn+iT3J/IX59qZ6p8tuX6VRTJsylt0Fn3A32tXsVSJ7owPN?=
 =?us-ascii?Q?sAWdbOCVHZXePSuZS+CGz03CPwKWu3V2Qh4/iFhEEYUqn8Keq6on51RSmGts?=
 =?us-ascii?Q?eLR0WRDL7iuBoLkwcn8jqvs8ybZnvky/MnGbPeD5gYfm0F5lxhbZNJOyqZK6?=
 =?us-ascii?Q?JYyupnX2dQTeiw1W3shXP3nhnpDbBllCcUuU5wB+vwRkcX+Kj8XebBoQ9Yt+?=
 =?us-ascii?Q?7xIWrBgR/eKFMY6IPgHk8QYd1mzqIiZNDt8DxoYQamEyZKtFwK0kGxgbZLMH?=
 =?us-ascii?Q?t3xJduHfJyImZe2Nl/002PyYYf6cs9yIh4EGmbw78pKt64L2cpz3XRVMhh4b?=
 =?us-ascii?Q?J7m4JQn21cNRnVeMZ/c4z8xjbEHYSFV+i7NsQhUl8yWgxXDW5U6uB+MiH8ql?=
 =?us-ascii?Q?GTiSCoEVXt41l8AlvDv3qe7XPre4mVaMfA4ZPNILCRB9XVt7BSl+YmwDCvET?=
 =?us-ascii?Q?UKzZ+k+GExbpVxkW3JEt/jDrquPwBOjGHWNyQMeDBCxzZmZerGlY?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccf6ed2-157e-4ff2-ad73-08decc4abcf5
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:30:50.6918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHxi2ys/tNbXIZq0RhBoDR70UnwSYXE/x1bTzEfG6CLy6ueKVpmU5XIVx9W1nVGJUMHC6aJJd5Zje5EMX6wDFgcawCPB0lzW5x7pZfcJM69bwOivGX7KJqNmrIDerW18
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8217
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:31:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23167

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit aead5ae91e4cbadac817d15737eca3b531237448 upstream.

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs don't have
reset lines for the SPI peripheral, make them optional to prepare for
adding support for them.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251119161434.595677-2-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index cf4272f99378..66006d3e7c73 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -381,8 +381,8 @@ static int rzv2h_rspi_probe(struct platform_device *pde=
v)
=20
 	rspi->resets[0].id =3D "presetn";
 	rspi->resets[1].id =3D "tresetn";
-	ret =3D devm_reset_control_bulk_get_exclusive(dev, RSPI_RESET_NUM,
-						    rspi->resets);
+	ret =3D devm_reset_control_bulk_get_optional_exclusive(dev, RSPI_RESET_NU=
M,
+							     rspi->resets);
 	if (ret)
 		return dev_err_probe(dev, ret, "cannot get resets\n");
=20
--=20
2.54.0


