Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A86CD98E2
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:31:04 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10744.1781685059190129072
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:30:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=PRdryXvG;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.41, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxErb2K9vI/PgUntzsO5ZvzM7OTduQZVhHhc7cfv6o6SuSQEVdQupdnT6I0maaZNA6driBoy15thJU7MNq1IJgekLY63J6wDujGmuuid/x8NnXy9Ov/Fi+4tWtBo11kOJZKFTcxhStdc7QsgZtUYoOnmoaAaODGJoIM7ihyJrdQEfvnzSlu/+dQW9qUl16oc+fwFhz2Hq2qFqdErbFzdl86l62zzb9dzIr7wJztLSq9+t5LRKyI7AtKVeLQTZpchPPGU5Sc+5sfvdPpWTwezRDyHs7Xv6cKYpiDaUayEdAnCBCKmKScFWRRLa6HQ21i9tkcbAHDSVZDD2FMmBdDUbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSMdYtFXDjqqFNuvXCHSkPDcJ6bAx8dPrDN0tR5W6QY=;
 b=nzikhzFqpvFfc+/LtvP546M0NWdgq+WpDl7pmdiiePNeQawZfGkJKO3vGiN2grUH+jX2jIPQ5jqCplP9ckPoABEYH98U98odjfSH6Rq7XnGEUY644dRGVAZfmM86RS1pD36wPd1S2iGAi97znDdhG6hoA3OG1yzF8JC+OsYXnGfFUVmeYo4ivdrX812rcuze+hgs3dclRHTJR52SAq16abXxL+UphXXZPIg3a1K+paTGk8Y9IMEEp4LGGVcb7riIyJBcu4ki0ukRySfSDdHyNfHbkS0SOPvqZrr3qS/oc0AToCr/Svtzz03A+a6adfozV/dO689RzwTFobc0hAFw8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSMdYtFXDjqqFNuvXCHSkPDcJ6bAx8dPrDN0tR5W6QY=;
 b=PRdryXvG1WEugLZgNNKZ7kHUKTWA4GWNJqV/N2K/HSZ/d2Rt0Q90t/N4eV5om8axuQiMc280CLxBayub+HkxhoRhz1txLUz9qFmaWZti+3ea3vLdA2VaF5dAC/H1y7Z8zp2mdL8Y9pgKAYL191nIYN3qD3d0SMzAgZOdEgFLbL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8217.jpnprd01.prod.outlook.com (2603:1096:604:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:30:56 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:30:56 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 10/32] spi: rzv2h-rspi: make clocks chip-specific
Date: Wed, 17 Jun 2026 10:29:41 +0200
Message-ID: <20260617083003.1071543-11-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: f673f083-1db3-4b9c-d761-08decc4ac08a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|56012099006|11063799006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	P9rl8p3e6CJRn82RvsrNrVG06WtuoSaYBTO+fIcKxVoRHqfb9uKcGA3+8FGxn0Z0K3aZcL0GL6OuIriiGNIC4T5a9BgzoJXFfW9dcg6AP3JwM/u/ZngoSPEi3hQkg+UWJ/5Njvkotfcp2ENqqqI/9qlEmhxCYTYPPfD2cD6HQrb0rp/cjIRjS7oMajrlQQP64RQg+EmwjL9bYxxNELoMRpbhaHlq8gmOJRtzny0EF2JBUerLc4Fns0jJR6sWzaPDWzc1USsf6tkPCFwosy7cdKoQMJ0d5D8a+Uq0xR5ol5v4imhbI67vnsWdAygTJu4RHql3pKDhDDXbJFzgo2n9BShEaOI04jrCGCbSLfrSKTLep6eIDznsB8DufgSqP1K4lIqZe0QO3oVChXEJKKRXdrS30ubI3hZyLGVQ7/wblT6+ANB+FdpJsO2muVxVbWUEulm97IAx6FqzcwjZRGOiLoy35Lnrd+41e9ZVs2YbiCkAfm4l4oCLF+wRqjOtc6hSFKKUasP6ddgeONM6G96WFrmaOOy4ujiCT7HFQfmfPZbqGf9Gt67kUyBn7iox7IHFp8pN+HbLt36RkcHl7rqQIHf73Qc2d+Nxd1QOSJgmaPGEug6jlaCe4GQYvDB3XvmrZpsYFgnUHsNr/qTOgsnnf5oTKw3a6o79IpyeDca+5V1ttTMToWaR4nNaZV8Tuwy7jdv9Qu+QY4a5Yvnzuw2pMA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UKfAwR1I106kAjh6hn9sj0jEt/lQr9rxQmORKcuePkwXacKSeJ4sVSXnL7wU?=
 =?us-ascii?Q?wreEM7HAxZNvS6PrxxBrMLwUmmtjnDMEBq8Wj13YgyKIMSuhr1KQMzuu6cfL?=
 =?us-ascii?Q?G+eNv0/rS2FJv9Ht/63HiGgyFmzn0rZ9g+IJQkA0BELyAG6yA6Z2pKJQ6srk?=
 =?us-ascii?Q?4vXS3cUBDKcclMXyCLPHKOzINfq6BdK8Oz1J2fKvUj7SMj45tW+Xu5kxCYYS?=
 =?us-ascii?Q?VDaSH+z8lOpwDKD7pH6aZ7FvVNfZutg/SI4g2zGsToFrjPJRL2GZIACh6/3w?=
 =?us-ascii?Q?jSIFG4FAmVJpPHpaBZTUibEAe9fcCAtpjGke17lej3n2vT/OrunEoBqM1Y3R?=
 =?us-ascii?Q?N1y80/xitOwP80Cmcx6CxoYrLwpdfq+WMCn5pTUFWABR8lxcPQcoJh8R/t/7?=
 =?us-ascii?Q?Gdr3RF023rnraX30UDfgksKxf4YJ/GseEfLC3el6Zv4nZg2mA+Ym8zmmWUXQ?=
 =?us-ascii?Q?7UGFZWpcUMc2dEo1yDoSAK8YAgpMHHNdjwS+F6i7cV/ocT8DCA8lSrJkwbBQ?=
 =?us-ascii?Q?dCwHVPNsMBBjkukIvcbZrtcYx45kDZkr3IA2J/NNe2yz/NZSKr2umcXU3uzN?=
 =?us-ascii?Q?w2V9X7or1hQnA97elTiLTn8jD80e5GBqcvJimOhjbGjAoC6gOAITUWO34J6v?=
 =?us-ascii?Q?1p+M4uVmKAtyd6hub4Akyom6hl9i6sP+JxqBvInd9/MOraDTx2h8KJVn+QIk?=
 =?us-ascii?Q?I8WgRmsXBN7w3Cj5suxfFClJkwyOE2a8Qf5j2VxcC7tIn7r+H4YvOA+O4o4U?=
 =?us-ascii?Q?r/4VzAC1jhvLlLfgyd70I4cxTPmCFXaVGlbvmoygHNHtyLsA/6Gf6lEj+VV7?=
 =?us-ascii?Q?zwgUIONwfFmg8XWCichhj5a+j3C6n6jQ+61sbOfwt8d1miRY6OxGAE6UjIk8?=
 =?us-ascii?Q?gFqcJ75yDT/NlIC9QQM+Au/up84fnyGW+8wlfZqwuIT7+n3FMQ7HCNAZ01oa?=
 =?us-ascii?Q?yNwR9olPiqGzUnRvSHbu7MKz2ZPuaNm1pPQsPE94BzbroHeGo1B0pEzw000g?=
 =?us-ascii?Q?vY/TYcexTeMK485AsUoUAOPZ3AegISREG4AxfryefWh8A+8OCXacbrgjbxdb?=
 =?us-ascii?Q?s7nWh3MZh9nI5t9XhFFqveLBqd0K7DoioQTs7LyN/DPWr4wW+2VjjIgKEbTB?=
 =?us-ascii?Q?AYEtcsI40LB9/O8h2n7uKNQgsM1hXNVqFLvfUmeaROBA0W7SkAp5RhmL3FnR?=
 =?us-ascii?Q?n4ql7sTm62OYkWiAaLoPllAtFMgrwu0EKEfcvYu/CDqxDPwTZG48awN8+/u3?=
 =?us-ascii?Q?yAAb137oQEzOjF5LE+eCETBIR1LDcGQVn9UHQ84GLtXAhgoJYjQXWzpYyU5g?=
 =?us-ascii?Q?8fHB7c6IHWBOEHuRr/tBsLPpatztbgpoQA1ARWgkMoPDOJwIAG3eM5WInaaP?=
 =?us-ascii?Q?boWpV4gnz1QQZeaBhc32s0ciTdYCBhdR67XEndt+32iqRhWqrURaTizEa9T3?=
 =?us-ascii?Q?veUKLf3MggRDWSjFKU+2lljMVuL8hrkOPEOUCkmVmyNh/FxxTf6egBHz0h/u?=
 =?us-ascii?Q?IdQmQDNZNxctSVNLsKWHbn5RTYcQyx2+bbDOOHtEej+70DXwX+dqi30tLhBU?=
 =?us-ascii?Q?Bf1in9pjnfky8wu9HjY9ru+42h7BmVV2+Cp+ubPIjMVP/nYLOandXSJjihd1?=
 =?us-ascii?Q?RO4mkFqAsGfTMcbjOZVtfIMybzUbSdvPj0TP/P9aQI4I/4uEtfv33s2koQRX?=
 =?us-ascii?Q?Nh0hfGNpeN7RINhiNxr9kIvbJOBqdjB237gFDa9rrxLrXOLlIghfC0AdRqtr?=
 =?us-ascii?Q?K9O2pqC/SO1Z0CjkJqtfESYQxzK+BADglicj/J64qYLn96sdyLh7?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f673f083-1db3-4b9c-d761-08decc4ac08a
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:30:56.6485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5qgMpAfsdqV1Eat5fBfQxCp4iFSQknSda+xMdD0/ktSzxFeUekK1PWUWlUiUfQrmRR6mQeEQvMTWFNAggFEDuL/VCC/VtPsq686uOJC2WEp4+ELn+qZqB71kkbozUgz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8217
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:31:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23169

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit ebd7d6ae0dc7d65e21460c928519f40ccf95f3b9 upstream.

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have
different clocks compared to RZ/V2H. Set the number of clocks and the
name of the transfer clock in the chip-specific structure to prepare for
adding support for them.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251119161434.595677-4-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 2914d356292b..4f8c653579ac 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -66,10 +66,11 @@
 #define RSPI_SPSRC_CLEAR	0xfd80
=20
 #define RSPI_RESET_NUM		2
-#define RSPI_CLK_NUM		3
=20
 struct rzv2h_rspi_info {
+	const char *tclk_name;
 	unsigned int fifo_size;
+	unsigned int num_clks;
 };
=20
 struct rzv2h_rspi_priv {
@@ -370,11 +371,11 @@ static int rzv2h_rspi_probe(struct platform_device *p=
dev)
 		return PTR_ERR(rspi->base);
=20
 	ret =3D devm_clk_bulk_get_all_enabled(dev, &clks);
-	if (ret !=3D RSPI_CLK_NUM)
+	if (ret !=3D rspi->info->num_clks)
 		return dev_err_probe(dev, ret >=3D 0 ? -EINVAL : ret,
 				     "cannot get clocks\n");
-	for (i =3D 0; i < RSPI_CLK_NUM; i++) {
-		if (!strcmp(clks[i].id, "tclk")) {
+	for (i =3D 0; i < rspi->info->num_clks; i++) {
+		if (!strcmp(clks[i].id, rspi->info->tclk_name)) {
 			rspi->tclk =3D clks[i].clk;
 			break;
 		}
@@ -451,7 +452,9 @@ static int rzv2h_rspi_remove(struct platform_device *pd=
ev)
 }
=20
 static const struct rzv2h_rspi_info rzv2h_info =3D {
+	.tclk_name =3D "tclk",
 	.fifo_size =3D 16,
+	.num_clks =3D 3,
 };
=20
 static const struct of_device_id rzv2h_rspi_match[] =3D {
--=20
2.54.0


