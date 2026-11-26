Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.37])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.411.1795708453005861810
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:54:13 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=tmFdJ3Aj;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.37, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGWA7RFIT7U0niIcWwltj3am95nPsYUmzqgloYcQXUa5jaNqgI+M/5S/Ju83nIixrP/vM5IOvdtUOC2PebSNztjAgJ0KpKZuzFrVmGZ6CMJP2kay74UwhY48P/LHmSZguJNhG78P2+RdxaNBN7ojHpyVRSPedlDINYdlsYbCFLD7LsfEqTKfnr5m/VLr8lkVoAPNk7lApOMLkKSNfJ9W+wfkdxmHn/Wcp6y5HzGVPyUEcakrPBrcPTig8/z1FnRxBnhkz3Vq8N6MxhJiiWZkZQOzDEawJCc1ZmkR3ZvXd1kKZd0JWh5zsvAhc6kI92VSSQ21nBv+5noF3GPlWNzdzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nv9xWkdJhbAfZ1BVgHKmV4gNoe5wSV2lqTUIRSWrb1Q=;
 b=WNL4qg3h2ved64kUTVhV1Ngp1AlqjXdSRjENQGAPGadEIOcYOFm4Fo7gex093+tgvgQpY4ZcZmSn5dGJPUTKJkODcvQPMedIVva2I/qROiLS0SEsJWxO1eVt00kXcu6y9BaMSH2DHhJjXvRert07RHERJ0tEI3Xr9cSoZoXFx8Z3wFJn5eYbKwadrEYF32xl7+D9p9z7KtEwAi3aaKVGJ5g0cC2HQD5l+RmFszoQaVco4Pdiq69NQ5zuUbn627xkUhz7JqGKHN0nj6wMm2MdCQPbnR4egXIJIXebefcvC+MwJ03FHlm7isUgBR8rU/sNEo+7Gk1KriqxlcTp/kLF6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nv9xWkdJhbAfZ1BVgHKmV4gNoe5wSV2lqTUIRSWrb1Q=;
 b=tmFdJ3Aj4bPzSinVmjXe8k/N8TftgS6R4HbDViot6yP0anGp4+1fDPPpALXYUBX5Tu45L4BBQd/xsMjvR83OyDCi14NGRIVYbu4530zxn6AGd8wg0APTOgryaN9lQo/nmh/+aGCU7FeDt62X0FVQ1gmN3W6BrXkvfqUQgYJ06Nw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OS9PR01MB16957.jpnprd01.prod.outlook.com
 (2603:1096:604:410::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:54:08 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:54:08 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 07/12] ASoC: renesas: rz-ssi: Drop the & operator in front of function name
Date: Thu, 26 Nov 2026 16:53:16 +0100
Message-ID: <20261126155321.3834347-8-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126155321.3834347-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126155321.3834347-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::20) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OS9PR01MB16957:EE_
X-MS-Office365-Filtering-Correlation-Id: 42286f16-6a4b-4498-c122-08df4bd5818a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|366016|1800799024|23010399003|38350700014|261021121427099003|56012099006|10067099003|11063799006|261028144727099003|261022105027099003|261026140227099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HFXrO64iIYXafCVnhbXplWQinPs8DjPNoeHmzkWNQQYileDgrC5j0hKfvGQam457hkmA+pDLqkCCCjpSObb5MlcKQvpQ8yHhlryYhbHp+S5xqcAdktqah9YRqGl2BICGV8i0gayGRwhF7/yHz6gUbDikfxDef0/0jklfLQAeNqI53AsNaBJWAskrBfEuLXRjL5fZkFWm26bTE62obZnwA3f/eS3kbnMu9b9Gub0u+ZVjOe0tbrQKrVU30hk+AgJ7nsB0zpvj+7AQZUwSUR555tq4Z2kxcWXbNG3jvRTkIXxi9fyodrMaYnNyxULg+WuJ5lU2TjRl2ghpGKcy7IDQFLBhxJHYi2xOIe7XaBN0ChHaYLv05bq6rJsogEue8zU8RFw11w02B2BsnNku2LNAhstGr7l4E+gZhnmqGxiagnbHjgpbBL/HswyZnFH1b5Ki8r4gcicDcUdC4j5Su2WPSFUxlwYoGzZFETScfQI4pqasYtB/bKLwTCcANRTN4Sz9I6MDbRiOherqT9WKl49YOMpF/cs49JvqybF4DfZ0n5Ic12LsVMRbRZMgkV1jBpJL3YG006qis5PYT+Go4xeXBIG5Ad2QgrO37kvexz0j0CHsaKw2itsW1cKVE2dE1nCti0NTd11HRMChio+dB9NeER9sclmCL1KC2YFp9QNCBQE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(23010399003)(38350700014)(261021121427099003)(56012099006)(10067099003)(11063799006)(261028144727099003)(261022105027099003)(261026140227099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nLRTpT7HtZ9eqfw08hB2nKSDCqXLAKeeG+qbmgD8fZbb7VB1eZiAz/bLZP8K?=
 =?us-ascii?Q?h7QfwGXUsmBf2mk/GXzsvbT8xOZpRF4kJEz7aFgmn0iJSrcxCgEWHfxHJN95?=
 =?us-ascii?Q?WfS2iK/SSFJ59OjM092gYOZOqXBgp5uhnC2RyuFxBkhTjffPoRZZjxudvq6g?=
 =?us-ascii?Q?nsKehLbAdtrf9EkHVngp1zMWMwY1a/dBxWDJiDD/HY0kepWG/1+a5lx4K87+?=
 =?us-ascii?Q?Om2tiBYD67utXNPzLWuG2/haC4Zsld39LsfshKjXSc1/+YcEu2IH7nh/rVXs?=
 =?us-ascii?Q?GAKMbB7PhkCKzNt1iq5iczOqDFktpRePCNK6U/oYyuC4+Yj0dXzsr5shKJiJ?=
 =?us-ascii?Q?PI7Cl4v3NfaG4zaPes4oITNr41dk7+HRhMxOlGYfQHzppDa7aCy7McczfzzU?=
 =?us-ascii?Q?q88xShB+EOAVGUVMki27vTsTBmhFDbVOj+qSjynwrQWH5sFGCrOZ19J3lomK?=
 =?us-ascii?Q?9iI+BOF4+pd9NsaG6X5w4fthqmdqejl02eOiWR1RpyVqvCUJZIsXBB6aOoON?=
 =?us-ascii?Q?7DaW+MNilKHq6nZcFjHlsHPDshMCYq0OPDJPEdfVpMb8dTEJKxVC4pjYmOr7?=
 =?us-ascii?Q?r2Bix84BgkfYf6DIm3dZLTL4nboNJafN1QmHg2OjGtKnsWzJFzQJhgJvh2ON?=
 =?us-ascii?Q?ZxUCoZx9VhXKMCAsNBS2gELL+2Ztyb+xa3hSkTlWPFHY9Qaaub+0C7S8Fl85?=
 =?us-ascii?Q?2hWL+pLYDalvw2/61KW/syqawdpYsOQQeXcWRWlKv9zIbk44kSXOGflFNGED?=
 =?us-ascii?Q?YZMDxB0InJT3QDjvrvyf6LV1Y+uDYVaUwGj+zWaYurGj5GyiDuBg+7+KY0ON?=
 =?us-ascii?Q?qN5Xjd40lx+/zRTYDazHf74QRWumCZ6thCyOSiGP3Zk0kwASqfDTpc9INduI?=
 =?us-ascii?Q?9dyv4+000VaTbOVE2h9iy0iTanRRS6ey+lYUtffezUAVqOL86myB0+E3clwA?=
 =?us-ascii?Q?cB7YN8lSLuFktOdsMtGx8xbQeh+adw+/jNn1lDOLQ307uQciwS0kU6G59cTw?=
 =?us-ascii?Q?syfk0yXPh3yG4PgxolBmybBrWE3zDYxDLGkRw5ro3+Yaay1lj7jlF1PeHW5I?=
 =?us-ascii?Q?TANsyfoHx03UIVOGcfpLpzRQTS7JodXBWychW4wmq9N+RVFmAoEP8UnIJol8?=
 =?us-ascii?Q?I1bpw2QhPllLPIG5RAmsYDTG5AoAubeuXk8Dpc7XdLZASa24Zjlzjz6tLuNa?=
 =?us-ascii?Q?Z2Cli37PsEThFmNd3cbF799xPz/IVQVHu6G+cm+m5cYN2s5mtV9o5rm4E53o?=
 =?us-ascii?Q?tW6dyi7hjmV+OPnN6Hewd9NxL+bNUAUbtavsRNaA0Rej5RZtmfBOI0zlwsEM?=
 =?us-ascii?Q?jpwBpGS1MySJI0S9awHevZogDwlUZBTrXj0yzmq5xVSwbOaYCiPDezsNiAjq?=
 =?us-ascii?Q?x9iKQPGreRmjxEWZmyUmhJeL2lwqbgxU5kq9PCkl8TFS7LFLJzE3duYSAVqa?=
 =?us-ascii?Q?+bwfM+BwucSzmciZmjNpIZue4ksR02ew4hyqiE+JbpNysg4uAgG19AfB7e7N?=
 =?us-ascii?Q?hk7KFII9P93EmsD1QLaFFcP1rfWEubn9f9/crl+cruugmzDfNMF2W8ypGhKE?=
 =?us-ascii?Q?Baur7NG6/H6pr5vrhi7lO0KuPNKoR+2sovUiMQf6RNzjyebpAMKKfZ51LyHb?=
 =?us-ascii?Q?anZdNZ0KAh87UFq5wk2keGEoSKZ/33uPLBEB8UAWbHtAKo/1yLM8/VwaIdRw?=
 =?us-ascii?Q?QoBTjFM+3/jXPmRH5pMf+JiWQW/cjQ+yz9pArfSRqw1acEAav7Za/iSD9uBJ?=
 =?us-ascii?Q?rilJePufKtUB1HaTu3ijbqfg+tZBpfutDqi7nQoF9NEpc5ZH9bik?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42286f16-6a4b-4498-c122-08df4bd5818a
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:54:08.6240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEUBPgSkx+RKZYtwGl+59ssxsoaHhs7iOKUYMkCD1cm//06D4D+q89HCSg/tvq//12ywdhvrjiYczp1NFDQgHGZ8gTY+tqtbLkizywyFUQ/YBMFToHpkylpwBcb8dZqJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16957
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:54:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25185
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c7a4c368e7135046c358ff15c4f7897e2522dedc upstream.

There is no need for & operator in front of the function name. Drop it.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260119195252.3362486-4-claudiu.beznea.uj@b=
p.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index d38653a825ae..5893bc4d51e7 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1189,7 +1189,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
 		goto err_release_dma_chs;
 	}
=20
-	ret =3D devm_request_irq(dev, ssi->irq_int, &rz_ssi_interrupt,
+	ret =3D devm_request_irq(dev, ssi->irq_int, rz_ssi_interrupt,
 			       0, dev_name(dev), ssi);
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "irq request error (int_req)\n");
@@ -1206,7 +1206,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
 				return ssi->irq_rt;
=20
 			ret =3D devm_request_irq(dev, ssi->irq_rt,
-					       &rz_ssi_interrupt, 0,
+					       rz_ssi_interrupt, 0,
 					       dev_name(dev), ssi);
 			if (ret < 0)
 				return dev_err_probe(dev, ret,
@@ -1219,14 +1219,14 @@ static int rz_ssi_probe(struct platform_device *pde=
v)
 				return ssi->irq_rx;
=20
 			ret =3D devm_request_irq(dev, ssi->irq_tx,
-					       &rz_ssi_interrupt, 0,
+					       rz_ssi_interrupt, 0,
 					       dev_name(dev), ssi);
 			if (ret < 0)
 				return dev_err_probe(dev, ret,
 						"irq request error (dma_tx)\n");
=20
 			ret =3D devm_request_irq(dev, ssi->irq_rx,
-					       &rz_ssi_interrupt, 0,
+					       rz_ssi_interrupt, 0,
 					       dev_name(dev), ssi);
 			if (ret < 0)
 				return dev_err_probe(dev, ret,
--=20
2.54.0

