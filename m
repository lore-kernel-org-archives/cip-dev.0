Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B40CD98E2
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:36:16 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.20])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11001.1781685369963926563
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:36:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=h/8Prs4m;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.20, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqFF+2dRmf0+dEPK9wniudAlqWqI0tty9yrxRV9bNmIzrVzoc6Y9XcaN5mzEtGt/ff9j8NDAkA7ZFIw1HvSYrY9L3F91bLddAAwa81hHOJgsd+Tpz72lVo8AxSUEtrmkI80BmG5AbWOSDMde4vE7CTmp2K4c3YFdwFWE0Zj9DIDEDuRapoGmbKJtgH9LKjksIC32SfNNZIDXjWdwYZtE0JCVBLVmFForZCLA0CLXdf02+U+AA9QgMcVhVf/VwaN46dyl+tdkCf2VJePcjtl8t+/I7Mg6e5zK1BJh1C35Y4aJOHRSY1R19sce60nEZhyLmyEyLyvkfQZuVMXzKIJWHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WhoxyRA/FC4aRJRBQohprRpK9T/asxneHqtuPlai8E=;
 b=rEXxwoKNQD3rqmgpcDU5MTFgeXStbVt6H4s2ApnXrLl8vMJeoWIx49z3lee7OnWZa8XoK4/se14iUVnH5c4TRm0axXFD+9DGx9VNNvMCZq6sygcPgtEHGcwqPdHpF90oKcT+ndDg2lavD4baDbAjhQ01SmnTE8DgfidmnPk2GoAFFLysR757tjzkVFItD1yUYLPfIRJ0sdaKguUrjoNR0z+tXh4sad9C0I3Qy/2xDt4gw6AaugyR4Yb/FHEzp+rwktWdrXGb2ePvSTEEMieBiPSI4/K5mbF3k7qt6yG851GLU1sQzAXcrHR6zRErJsLH3Pnul1HG5XMeaY7t4I5LFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WhoxyRA/FC4aRJRBQohprRpK9T/asxneHqtuPlai8E=;
 b=h/8Prs4miUJdb1OMaRxEnYyNnvNG48nWjOoCckGv2A02+9bxGu/zzQu0gChZIEkUoZmxKpIF/NjmS9id3ovUCPWNQbCoQiYAHSCCbiTgnF2PwTI8/XCQRFqmH45sHe3cO7A1zmxFZvdu4vRG71eSos6BKOLjwwxoWqJ0vozHKr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY4PR01MB12634.jpnprd01.prod.outlook.com (2603:1096:405:1ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:36:09 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:36:09 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 15/24] spi: rzv2h-rspi: enable TX buffer empty interrupt
Date: Wed, 17 Jun 2026 10:34:53 +0200
Message-ID: <20260617083502.1074160-16-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4c6bc9c3-bcea-47fa-2266-08decc4b7afc
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|52116014|366016|376014|11063799006|56012099006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	ufTQ9CbDxw8QYkamUfW3FaCMkWB/PwZauhws4INzvgHkDKgdgmaSo//D688huGsidChTRGJu4L8uPct+L2QJ5UfRqsncCUWcP5IwjtRCnNAArPecuo0hOAdAj4xMMm38hzxIu3FeZn+FlUTW70NBO/eMoW5X2SbHoHeXdRuy+dSg2h8mASv1W3svp1eIgm2EOFp8UaRo/wu9AMMrFLlFssO+iU7EIzUh0T5vsgaYL7CCKILtalcjv8TvmC9JnZ/wg9v91Fha/cBnOwEebzWPOumNiAtLTUQK/RqjcHwM5lSGQHxfYYyRYUaam7eIOaI9+Iwp4khdLJylHboOmeGAmmivB5k0OB5arxr0ymGe+IgJer5opGORaL5N/XLjO6iYZiOozQ6z9hnMrf3O1VDAKxNnX0o5i3kSeaenM0U1zM0PXESH2erUlaTV+6DR3SCM3CxwUSyi8JSwdGj47VoPzFRTs2zkl8Ulh/8DX/g2wW9xKebICiLEP9FoXMROyhmxXZzSr/W9fOzd5hJM6PlY+3w7xlmDscAnbfgZw2wNcioykwWcYV6yKR8FiwyWimmSxfd1ThfqLLfgpBV6dIqiuve/m89AOexzw6HGn8vNpbxapt8JculqB/b/LAnTfPFGNqZCdHGWJsCWsOKgQp3XkmJg9ePJTRrctE3fgdGmUPpn3BL6prdDNks+YPPttRamDAKT1xxsExIEnfnwSdlQsQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(52116014)(366016)(376014)(11063799006)(56012099006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PzVHnwYYI37hpCkGS6SknlsolN/IUZvvsRng2wOkm3JA+O2M78g1jPRDb81f?=
 =?us-ascii?Q?RELFQjWdI/FeTMs806jFOnJj8xMPn7SwJoKOVb3ASVj8dx7lfRVm4AoQIPfA?=
 =?us-ascii?Q?2RyQwcy2q23W94WPXHXR9lcgPEEHlsPhZ7VYi68z8HWfkHtXjJ+ko6C9py/0?=
 =?us-ascii?Q?tLaUnGCSEG6GSvGTX4pDsxBWnlKGC1UBqfHsN0oWsUbHNB0SK2tSJKB+m+wN?=
 =?us-ascii?Q?ecQFopLFkn6hWrxtkiVA2DxKEbE/kSkOuubYaPSgnN6xXZxDNOCxBFItzRsn?=
 =?us-ascii?Q?t0PTuF7wqLEbN0R/2lGtV/jsqo0Bv+ahk1tHX7ijaxIIsGlCpZwO+zcafTGd?=
 =?us-ascii?Q?7yAa+eSa2nF65xsDJvwIcS3Ro4l7jaZj/c9MA3nnvP+igHDjeW+AZtFWMnSo?=
 =?us-ascii?Q?k6WQEyveJZ/ruc0aNV5itFTjwM4jUdKM/7/5fAD3VPLIj2MkYF2MFhhXUk/1?=
 =?us-ascii?Q?/gWRBoiYz2lJe0tty0HPuQ1sCf4/jzQnM0b3mLTMZXuK3Jnw8/Vy5Y+o/wnG?=
 =?us-ascii?Q?/WbX3KAw35KPxOzOIV3EYrrQBpBZ3dxU1677cYh0fdDSwnCwOCoug7MS1FMp?=
 =?us-ascii?Q?QmcyqPDXcMx/xKiYNtaMW+18WkVtd6O/wzmZARi3tjom3IW57TgBP0eJeY6F?=
 =?us-ascii?Q?JNkhEaspstSHX+9JXwK2X386/pJCAsI0ZYMo4ixTd0on85OTeHROcFpbuhpM?=
 =?us-ascii?Q?SgzL6xgR83TdlKUH0nnYEewABJsqg9kXc3mjpVXwUsAmPiH0yDAfkn5blOuO?=
 =?us-ascii?Q?/cF+D7OVmRa6OcN3FQ2KYwPXZqIrMnn+uA8L3owJ9PFtOLn8hgyioucBchE6?=
 =?us-ascii?Q?XAe/pbJqQgx4DCAmp3rfVMUr2qlWgHwHcBcQSYSj9P925S+JsjLMZTqnWLmh?=
 =?us-ascii?Q?ZEjTY51l2jq64POfwufRtXHeuM0XlSCeZm2vJMUrXlp6CCF09fPzwN/iV4L0?=
 =?us-ascii?Q?qAkeHh6Qn99rXZRE4wbVD2+a8URHNtS15bQj/D8IdDiR3/QzuDbkL/vBKRDT?=
 =?us-ascii?Q?zacMV1WqRH2XCDI70pYIcVdoH220Hsf33Akz5zkMy6ZvUKTM+ab1LJsec776?=
 =?us-ascii?Q?fw8lQkEc3p9Xc3UX0Hjni8OPmZfCb0mGsWPsuCVzUZC17ri2ZXfg/xyGdrZ8?=
 =?us-ascii?Q?iEukx4+DmVaLgOyJ4wsD49Umq25Ok5WHOL8o9dhZwBZVW3NCuflQbq4qhXHE?=
 =?us-ascii?Q?RxrW6+eO82rljPEQZdHL6gcoupIzk348kvYctQ3bmW12ZziGQ66VHw8xIR16?=
 =?us-ascii?Q?gzmM+vYTzXsM50PPRl07fmag/I3rpD7PqCquZp+Zp9+89T7uNVZXw+RxAhV7?=
 =?us-ascii?Q?uRJk0bcwbwmOSNs2j75k2l4x+kW/glAs/eE1OCCw1VQ8ST97t1jOi/Y/4GYh?=
 =?us-ascii?Q?S+sgYDBf10xo2mMp+dmtnsCKjtXOg1kB6Ua5ygn2zoQCSmcV0bdQZarig/Aa?=
 =?us-ascii?Q?8Hb8XFWNAcVyICOEwESxPvCp7q347tfsg6HdIaJ401wSLWJB/fJ5gRO5ExXs?=
 =?us-ascii?Q?R/Si5mZTmOvSYd2g7F4ISzjfjCUXOzrZ5wNO1o1zqGFJM0ydwTPtJdKffBvL?=
 =?us-ascii?Q?umkbVUx5xNB3YaIhdxaBYvrYtEFMh0KeXdZRebbqZWLpXuAw5Bc+Eq+MlWQk?=
 =?us-ascii?Q?mO3CQuO0WLvMyIKgNkarMUnQUt1FIXUbfhkiad0AfdthIRqLPc1IamJFg0Ow?=
 =?us-ascii?Q?ll9FNwVWdE6633KEIvwYSAjpYTDlmfAaqshQYr6l4YBDeiAL9yOCpir1Qvom?=
 =?us-ascii?Q?Pw5WREU3x1IugNDaYsx+SH6Fh3BQfUS/UUGsxCCj+uJ/b17Uhf8r?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6bc9c3-bcea-47fa-2266-08decc4b7afc
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:36:09.2331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOxAh1dYu0UcX68LltdRms+Z0dHyYQj5a9g7rD4M7cEMsJuTQMGiA9W2LyF79nUoIRELqD3ATwYoE0gtk5Gjb+ZWHy0dOrjRA1pCB6Dbev5JtVoNuePwrAAD3JrANsYZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12634
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:36:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23207

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit d49eea07de5851e1b8941ad6b6179be7ec36a986 upstream.

In preparation for implementing DMA support, enable the transmit buffer
empty interrupt, which is necessary for DMA to write more data to the
FIFO.

This does not affect the PIO mode as we do not even request the TX
interrupt line.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251201134229.600817-9-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 83bb0b7400b2..b31ef2f31f1b 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -37,6 +37,7 @@
 /* Register SPCR */
 #define RSPI_SPCR_BPEN		BIT(31)
 #define RSPI_SPCR_MSTR		BIT(30)
+#define RSPI_SPCR_SPTIE		BIT(20)
 #define RSPI_SPCR_SPRIE		BIT(17)
 #define RSPI_SPCR_SCKASE	BIT(12)
 #define RSPI_SPCR_SPE		BIT(0)
@@ -474,6 +475,9 @@ static int rzv2h_rspi_prepare_message(struct spi_contro=
ller *ctlr,
 	/* SPI receive buffer full interrupt enable */
 	conf32 |=3D RSPI_SPCR_SPRIE;
=20
+	/* SPI transmit buffer empty interrupt enable */
+	conf32 |=3D RSPI_SPCR_SPTIE;
+
 	/* Bypass synchronization circuit */
 	conf32 |=3D FIELD_PREP(RSPI_SPCR_BPEN, rspi->use_pclk);
=20
--=20
2.54.0


