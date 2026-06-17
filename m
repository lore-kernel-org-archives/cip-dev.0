Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7917CD98EE
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:36:16 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.32])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10836.1781685374481959458
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:36:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=h3PDZFGB;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.32, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JR84qhWZerrwwlZxUmbwkwOUutN/kOrDTglO9q8DA4QWzUiCk1CuXjwYdL1r+7fdGpLCTloVmB7NugYZxil8nZBJa4td8+TrOABs/rN/zzZlo9j3ByUnzOhUgARVAksWGOqgdY3bnEf/cD3tmwrxosfUL01d0pOCDX+BIWpKKh0qNHIrA4IW5lWaCeb593B5ghKtjrZZ61QNlUAF4xsSCbsWp3+b1fNKwDtsqZRO7OXJ3XBgr9qOwUMc8OTOcgZMxFYaMALJCUZGTxs9dSFQK8EsOkIrnX41esLsEzIfPD9O393t/sxOuMcZMRyJenKAzCVUXI/AeMW+KyNNjSCh8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzTN5BYaZJPnA2MG+QOg7JRw5E8ccdyiN2NABEN14Do=;
 b=BgFLqB5TUctRiKvtprCsXPkZX0ce3DgH+ApEDgODy3IdN2BMQmuNg4OGDC1RaxVosx4cIrRpH+bx+7OP5E0Vk2+pwdwaMxqX4jf9yBv7ApQRi0ygdgjEEsgdZ3aqttSAQ1SJs6ATX2prS2mau20PBslncKCmI76WJ7blXsUKMQPpb2yrxqsgpbdGRetLlt+ykG69srVZ/RBCIr5CuumEduGwNfqS64SZjYnZ4QFOZvDWchvFuxLiMYDSPwmmtsMp25PzKPO1cnwdv8BvOSHCFc9eYyb/9MZj+6eRSrgd6HS2wedNq602GbzlYQsBbvEC2IDTr/jwwQE1NWRG7utmdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzTN5BYaZJPnA2MG+QOg7JRw5E8ccdyiN2NABEN14Do=;
 b=h3PDZFGBpTTBGJ28fwCzChRExzwDFBCpeIZCk31iWdDQVXFbvzPMAD65NmLSfdADyp0sjlT+1+afxvwniJ3C4ESFbIwcgGRHso4WeIlCBv0eW7MjcQSMa2PHiGmviIxjOjSFo7dyuO7jMjGG/lD1lEbcGqqJgYT14p2w6SG8HT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY4PR01MB12634.jpnprd01.prod.outlook.com (2603:1096:405:1ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:36:12 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:36:12 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 16/24] spi: rzv2h-rspi: split out PIO transfer
Date: Wed, 17 Jun 2026 10:34:54 +0200
Message-ID: <20260617083502.1074160-17-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: d7210f1d-a331-4355-f774-08decc4b7caf
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|52116014|366016|376014|11063799006|56012099006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	aCAlmSwInYrflLZIaoL2vqw0RJ5JTTK3UZth7xSybwRefvliHZrl6msbOvKoWSVHUjo9c56reOOMhLVIEf0VYQxLZSH6wDx9pnw0W1upu/Vj8BdlHNBqxp0CGqjTXmOtQcS+5qisZZHhgKiSzu7lgAIM7BQIcVGHSWfir2LFGTCbJseIo+mAhYqqoQXOjAqrgjyZ6x4vE2MwIQNw8lDjfEqRJtJ8SFbY7RqhB6gQKtdhfLOwh/qtiztdwh/JGYnxPOcTiP0X93jqodlRj91agIAr2hlVwoZefxEpxthw7y+kkQIgz5dNiIkfgEvKKEoRZ1Epkz08bacZ59lWfrFidh+g9NnLw8ohOAjTJk6XiQTHuTU5QCHMrKKNz3K+C1P9MCwFAwjlLkhVwwmCgUPdP+sr7zDZ+60wREU+4s4VJEfFIwhDEI+fxDOxsG6ORg7F254Ad465MM3zbqotQ9Cf/G8eSkBBbbzyeimSlwAGHEI2LPYkwo8mDS2ih1mNKRA0O/RVXdRYKfdQGrTDZxj0MGI3XwBZ0ynx4+I1XgZqcXMnhFLsmRgQGQk9l5n3DBK1ig0YIXOrnRhzhYeMo5lYqblOLo0xzKqSGTMnaCzlwvMB92zsN7jI9DA8ruLn5gdvfpcuEHZKSo+J6UGu1VE6BNDTuzpwS6u3fSgo5ECggz4Eggrhp7TlG1TEEfZAcODKeYiCueJY31v8Nrs6xo0e9A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(52116014)(366016)(376014)(11063799006)(56012099006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UKCBTM8MG597729UYkZzp+JvKMCIjz3acVHYX3Ey2usGm1Mx27Y/GsSrBqfz?=
 =?us-ascii?Q?IkJMJGbwNiknd5+q8Yv707i0CY8lpg/BMWKXu3lJefBiEU7YUe2hZEs8wKUd?=
 =?us-ascii?Q?wVCL5KWFGeu9N/yO3ezQ3bYwEXNYDApkmswPydUiAUMEySNqc4ce2OhuUYMB?=
 =?us-ascii?Q?Da9yxdCER/7c7ppQZDZVFkqBdNh1BHrsA6dPb9TY9Wii9GTmt5glVSTtxSl4?=
 =?us-ascii?Q?GS3+WuuROybKZ7S86hFZO/ltEpqbhNJ0S5IalZgLEm26EHv8EcXzX2whWUHM?=
 =?us-ascii?Q?oRgk1/elfwgfkH1ANEVzkePSENB6NRvM2Hed9x7dekXxDya5sK0jjWFMxYVX?=
 =?us-ascii?Q?HeQNKaF+uJ9ZIKu0KTI405KDhQkaZAbdqainlXXt3vGtPQTxkgi5fHrx4Bft?=
 =?us-ascii?Q?/f5JNfr9QZJEEx9KHMrz2pXZmG3YC+rUb5cNFjLYUcJPgpG5tfCvLugGM7g5?=
 =?us-ascii?Q?2Dr31B6Q1H3sSnbUttl9s7XZ5PmhRjajFApQVwUm5mt7wlHrs8fHGjo6A+xG?=
 =?us-ascii?Q?I1WWxV2L4N8MuL9SZG8NxGs/FN5LJQuPIJxIzpOvvwKNRrTVSKBxqkjQK1rN?=
 =?us-ascii?Q?nBeOPZbsjASJoLrUGmu4nfiSKmhPcpALVbThZLRFXX2I1rvbHQnwvO6twyZz?=
 =?us-ascii?Q?jSJH0O6+LPUpRfRrIhNgx0yQuUTziGEg5ZLlgnl0yjXOsADfLpJo5K5Z9qLk?=
 =?us-ascii?Q?4ftEzyC6chHQFHPSPWce/GcQjjNt5E2vPQdn5W8HXkuZHyiqmG9nfjY4dMhZ?=
 =?us-ascii?Q?XX95wBXL9Y7uT9E/a4PKd2mMPM1yzvGX+pGRvBnHnKdCHqpZDKK9+EcvtlGy?=
 =?us-ascii?Q?/Q/LxiUlohrN8IdHEkUCkbuR4+Y66fGwRTjadGjJCibJzygcvv2liyXW3TGc?=
 =?us-ascii?Q?0kUnMaiBmz0Su55Nj9VNMnubDSFDkH3nZxIp8acA7s+QcaUxg7htR0Ynuwp6?=
 =?us-ascii?Q?bXfgWcGahB3JfHaa/awSS0uBR4ZdXs+yoWoYlqDbekFOPirvmCrSNaukkooY?=
 =?us-ascii?Q?Ts6sr+ozJ3HcqfRt3Jsd85b2n4WvmekwW4kVSCac7CZp6j8dDLVfAgCCXFut?=
 =?us-ascii?Q?j1ywbSzFR6wD9JmhUSR7rawIAdJ1dsJSMHcbifkc7Q/Ma66WMbG9jBXyb7+L?=
 =?us-ascii?Q?SeTUl/XK5VaTUiumikIKPjHmZXlAg8QcFo2lxCvPMVFH5hjn7TQU33R6p49e?=
 =?us-ascii?Q?P40KzYADEzf9FNGQA7NS905IiC1WV2Ee+r14rJiY4VC3ng30yxA+HWkfbNrG?=
 =?us-ascii?Q?/pKOoAhitqMplwq6Uh96ap2YRu2RmIGadKzwwdsyV1Om37W9bNn/IZ/IvANL?=
 =?us-ascii?Q?V1qDOAycuYtNWduxRKf0xRLQ+mqmqqTYi3o5lXlzIxqJSGFJkTGfD5OwfYft?=
 =?us-ascii?Q?wPsrKz7VElxO4YKxPh0fMsMx0NgSUz9zbbiBOfMlnaqkgbVmvzAGhjNnmD/h?=
 =?us-ascii?Q?YJbS3fb/M17IaUKa0738dlQuKoI9ZNtQg6SuggEaLh0i7a4mjk7Mg1HHYHJ/?=
 =?us-ascii?Q?uQOew5pNOGai4V57SVVpjJz/FWF2FR2NjaVoDoBDwqYiL60qvkdrYSEnBu62?=
 =?us-ascii?Q?Zoeohd0T3+IP/+RE9B6VGEW5KjpjGBFZXYZCr0WUevSKcdQ98fG3OQXFEtvp?=
 =?us-ascii?Q?fY+Wl9T4r9XHL2nQ2zpZ0xF7D1DCPvOrfqk5uM4BfTeLEpcmr24Ngqxmk5wx?=
 =?us-ascii?Q?4Oc3i+/9Pab6eENfYmLUwF+/c/P6289EKhRTybOLjRph67N/bekRLD2hn0Lx?=
 =?us-ascii?Q?H8jSegOHQHfFIo5k2bQbEd3N+z5jpktv56TNLEBVyneWFK7A7tEr?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7210f1d-a331-4355-f774-08decc4b7caf
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:36:12.2787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UyeI4uHYT4OkaMSMxifnVE8heg1/Auw0YhPa960zKhTU+BWG35XyT7qlUHaTS4dG/h6KRRUulU63DV7LvMusy8GdO+mSNosufrInJ22mBvwM3YUaqpemqeFh8nohTr2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12634
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:36:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23208

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
index b31ef2f31f1b..9f5bc047b485 100644
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


