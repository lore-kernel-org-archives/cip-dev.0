Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3998CD98EE
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:36:26 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.18])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10838.1781685380937689646
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:36:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=wPYgaojo;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.18, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRPoXxH4/UAzkQ9kapzoo6v+GxAL1SoMwD6m9/OuaYSld6fiLqpCMGz5vB5IhqXmmmqLX6he4b0xgkQlhpS4g/drwTUSDm38wfeoi8L06AzZjVoSRSPpE93w4PwBT4kuo3F3gLU9KMTE8Oi8+cUrZbHMZMMmdx7PGbwtXlPbI4ssA9n8Hqwjv3gGASQSGyit40Fjg1/saaoEBx8YwamGTpSEzeQqvQprNy4VbvKOM7qhQbFt/zxEueOdcR0zgN6RUVb11oCcXxN+Qz93MV7SdK+ZsCqbMpFDhcDx6MMgFAVT7VUpxLxSNYepdZ4msaf2kYTFe8wGVHsxZVQijW65NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSFYTzRWDO+XNTqPY5+/a0jtGgodwUljI20Y8GO26XQ=;
 b=mJwFCyP06IWFcC4PKZv9MyKh5GrhTxb9fkP/5zi1I9ANI4waSR8DcRb7XfGiWAztgv+S1wW6U5KH3UvxRYMDugvaFpXFUzb9FEfhKzoRzjS3UeNfoezImGTdF3eRb82rEMMfi/RfDdCeJhzH9r3mpKXPOZpn19Npm1JTnO2L/WhbfCX+JfcAFaA7ZiwfGQcszacS5yfMXgNd/H9U1CPiaxzKimwoUW+rCFqLQl2VaouKx/J9ydQeV/I4fOevou8mgaGoXjQoPOEOl6ifrKWpyMRRumn3ald75t5Ms8nuMGz2Yg5Triw2HU1xtKeE4EYX87GVufGL0QG8HrqQROGcKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSFYTzRWDO+XNTqPY5+/a0jtGgodwUljI20Y8GO26XQ=;
 b=wPYgaojoPFDCVni+kXIVwQ21Kn+AdYDmkLvlcMVQETt4Huy78KSVAQkXG9X5zu5lo2o5Hzlg15tnXsGKoqeLtqxBZh7g9B53YRO4HA1IFv6Bpujudq+JrGxV2pv5SLBowBUFOSXXOCXyDheFQzZIU1dTSFU/OzV3bkkrpSWRfAo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYCPR01MB11915.jpnprd01.prod.outlook.com (2603:1096:400:387::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:36:18 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:36:18 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 18/24] spi: rzv2h-rspi: Add support for RZ/G3L (R9A08G046)
Date: Wed, 17 Jun 2026 10:34:56 +0200
Message-ID: <20260617083502.1074160-19-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYCPR01MB11915:EE_
X-MS-Office365-Filtering-Correlation-Id: 4457378b-f524-4e88-1883-08decc4b805d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|23010399003|52116014|376014|1800799024|56012099006|11063799006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	4yE3frdHxflTJzygk4JtPEmx87JFVx+yG/F/4tVqkJdntRUudRJbXTeTsACxypraYND/f8+PkJLXC1PwIkS71STA+la70HnjHIYWuMUzEc419VcMVrn5cFOq9BbYiwE2qx0WE+enqBzr7GmfxmpQYadXrXAkHVdNuBSw9/1xMfsPKkDjHKmzHICZROLBkslPJZnh0SkyIleqdU0owgEg1MApBOworBfI4gITaQ2z69/NIv4nof212qt49b7z20Cu+z1rQEHk3SRXtIGVFfgLvuuHKEAxIRV+NHr/X9Vj2PsCTsDeTQfIdR+JChReHDRTsVduV0CHHLV1jTeVjTLUoUYBe6ilSacQOnXzyHSechBaU7huHllwb19cP110QztWBk012Abuv3+6j0n15FhEe17saRnyArIGeoyPPqIQ+iFIXEu1BqwamMU85s+lIS3R8RJMnACl85Me9vsyIAvqHAHnhlmMb4qAZJ7zjvRjyTzEkwR9wNHYmecMZP8+LYdgDIY1uwpOyE0ALDDS6Pd7W0zde0kf5evmuFklthbukmEm3Mt07KyUE75PmAOXOYVGoY0LYhRKVQKhCw7J7l2qheRK1kHKmKOGod2OC34iVIdPfQ9NICcoGDNvtzmuMhh11zlu+MW3uTFBIUNiHifoWeevvPs/UI6MSuLro/sHMtLHLTYdZ5dhHagds+3GPoaYjL2aPWmipY/hZnu1c0dmRw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(376014)(1800799024)(56012099006)(11063799006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NWnNGb1QvZvs+4MD9LQUJXIqdXiAMMjExyudtxL68Z6I15W0U7QGNwLInfx3?=
 =?us-ascii?Q?rSzFyWznyYjBP3bah7EqX4O1xtkZsFVim3q2pvkrhJbHMfDnbsUrjV2GKUsE?=
 =?us-ascii?Q?AjqlCrDg034j8bhpentdCG3a65rxVFBv0PJ+CjpSyt1eDhqWKyW+6GisLWVP?=
 =?us-ascii?Q?U/MC91WUV/QZsggnA+fB5GWKKuNAMTt8k4Ns4iUde/XHaY/F2G6/NBaF2tKk?=
 =?us-ascii?Q?USdS7eFSAQlC8YNz27wwH/LkQ9HI58Oj7Y+emh4FPzT2moUw3m7/Kul/AmtJ?=
 =?us-ascii?Q?Fr/vB+AY+MG1LB1A+0FZ+/SZBgMYmGRnqz9CbQDMok96/gRrUS94tis0spMl?=
 =?us-ascii?Q?caG+vUwG9G3ak3kbwJvYyQLLZDF0QhfxJg6mmMa2Y6ut+9v5MMg9I4fseme0?=
 =?us-ascii?Q?GA+WwiPjVPbCnZRCRzNHFyKN/JNt+NHR3tJxDaxWGEyBGpTQ5t3L2rEusPHO?=
 =?us-ascii?Q?r53Q83jWsn3oNHFh5weEAaPbCqDEAoa6qsg/RhJP7zeLw4ueGzWkaLKYQeWa?=
 =?us-ascii?Q?+tNxIGTSB9ikfb2IAiG5/O/fm4d4JrEjHfmDVK9vYruAxikTwvlr/DwHKUDy?=
 =?us-ascii?Q?qt+57R7Ucc9R01ByKbnuuUObXZdRThsrsz4ekW8T8Ar46S3ZS5SStRu6fxec?=
 =?us-ascii?Q?hrGPhdlLeVXOazGQcfzPdB00Llq3bYdk0Um0BgBae315F7YpS8QxoOHKdVRR?=
 =?us-ascii?Q?y8SsmTzV7Y29Ox7ujcFABvLiRiEJbQYy/7B36i+A4gIEsbA/HoCrP5FYxtSs?=
 =?us-ascii?Q?2y1mgpfOMx8Y2r7wDfOZfq24I0jrLozFDKl6jXQxXdImFui80BQ4Fqxzmyby?=
 =?us-ascii?Q?5UFX8rA66WrgD8Bq5Zrz1wrdjkwZ02VFCOxM9wPcwMcCqbAlcQbF7CGKdk/k?=
 =?us-ascii?Q?ptMuJi9LWkFBSepR/WpPBiydXXjD+QTJgvxlPKT968+Mjb7evnWE5ljYfifO?=
 =?us-ascii?Q?UNDLl3otEVtO67FCdl+7sv5RLfg4TaEBX8q0zwKvCFk1vqrXY11ND+zwtzA4?=
 =?us-ascii?Q?ViuyDXOwDojbClACvNa+vet25vrWDIqoXPdxOITFKWgla/Rf+1LmsEzIwbmQ?=
 =?us-ascii?Q?3WHhsR0Rby0ECfDVS0vWI9nYEfeJULAc7EOmCiX8ee6mxXX1yqZIkK87f0O0?=
 =?us-ascii?Q?YqV72QqZAGsttK98b+xmiY8fxw3TUYtJmqOITvLnYGDsn5n+g0CsCbUuMfXs?=
 =?us-ascii?Q?Yu9y7tbZ/xXi8T5n3GtRB7x/Sjb6V46A+IFBdkrE3IldwbFzDjgHm6OdX0IW?=
 =?us-ascii?Q?xRChJB6oevJt9/P0zSG3tolJcfudA8ZYS/XzAQyNvPCiHbr1b/we5RtxSFAz?=
 =?us-ascii?Q?qOOVp08q7SufwNVGhoNykPFk0z/DhHXewrvrRHS3NYEgCVnuhq+RCyJ1n8CR?=
 =?us-ascii?Q?8KS176H4Qe00zkDT9Db2o03zpmUh8MtnAFxRi/qwKjIpbkfphxbVds/GaOeP?=
 =?us-ascii?Q?lEFLat8tKbzErnXJCnEptYOrMpDZZoqsgSXNeXI46ogqsFpCq46nsrlPmwEv?=
 =?us-ascii?Q?NUJJb0KfW453NRe4H2zU2GQFwBpLOYZ3gYdgiJZm+QQE9IfO6UoRWH+4sCEy?=
 =?us-ascii?Q?Z6AB3T4eiBOrtZZDcAsqhxMfDAVeA8GkcfyEZdLBL36IOrulfI/8YNSt3/F9?=
 =?us-ascii?Q?hZsGHKoW9SRYgLBrJ1L5e+8IkU89cUeUINo80uOgUjPrqPr9G+D9XQeFp+hH?=
 =?us-ascii?Q?soU+weDR9w6YHCbpN9uYuJanisDG6D3rAAl7iPntpIbrDYsMq617DOF8+MRO?=
 =?us-ascii?Q?gIA+Ck/abs7cjoNM3rKfuxPs2JEXZ6n2OGYPoNzZbG2HRibtYBJv?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4457378b-f524-4e88-1883-08decc4b805d
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:36:18.2382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8kCVTbqmKa44vqNnZpO2Lv8sYbEK5Nu5KV4x7V6MSUnbjZH524ddnwyS1xO6piQIQ7xLqpTPtrwEwixOi/S0wwZW9hk6wUSedMWgpyiCc2Q22m4Qc7i3HavgJY4laKz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11915
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:36:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23210

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 9be1143516473694ffd731304198a8b02e832d1d upstream.

Add support for RZ/G3L RSPI. The RZ/G3L variant requires only
2 clocks (pclk + tclk), unlike the RZ/V2H which needs 3.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20260408085418.18770-3-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index aae916882915..5589e361fd10 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -813,6 +813,13 @@ static const struct rzv2h_rspi_info rzv2h_info =3D {
 	.num_clks =3D 3,
 };
=20
+static const struct rzv2h_rspi_info rzg3l_info =3D {
+	.find_tclk_rate =3D rzv2h_rspi_find_rate_fixed,
+	.tclk_name =3D "tclk",
+	.fifo_size =3D 16,
+	.num_clks =3D 2,
+};
+
 static const struct rzv2h_rspi_info rzt2h_info =3D {
 	.find_tclk_rate =3D rzv2h_rspi_find_rate_variable,
 	.find_pclk_rate =3D rzv2h_rspi_find_rate_fixed,
@@ -822,6 +829,7 @@ static const struct rzv2h_rspi_info rzt2h_info =3D {
 };
=20
 static const struct of_device_id rzv2h_rspi_match[] =3D {
+	{ .compatible =3D "renesas,r9a08g046-rspi", &rzg3l_info },
 	{ .compatible =3D "renesas,r9a09g057-rspi", &rzv2h_info },
 	{ .compatible =3D "renesas,r9a09g077-rspi", &rzt2h_info },
 	{ /* sentinel */ }
--=20
2.54.0


