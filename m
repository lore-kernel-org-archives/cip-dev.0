Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.25])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.595.1795708937271167410
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 08:02:17 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=al4W1LtY;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.25, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3a62X2EZsflrmNbLlIxs4HtR30xiwudvKvxBjv6MrN/wZxr6PG2rL6kl8f26I4Yu9InFLZAHNaqClhUySEltXxR8qNCrVS+UwpMVPxHR87/zz417OUur9aPzDLDxj/dPVXlL10axzsnggnNITqbbTBS4xYWJc/rNLLtJisrB19rGIHaDaOBEdoYS9NeEtP1qW570AmTWs6vP1pivOYlXjpzlvzXVXFMqYR6trX3JsXN3avYyacFoRQ0ctUWHBcUTjFThdOZhlkmhNFni4+2VkIh2ckNnTL8HFnC37o3xZrcGYaLS4Hi2f2WKfXHkLVhPUuQoP1epSxujETCToIP7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaeM2v3UQ80npTWppny2toibd4s9ovy2f6ybXCX9nUE=;
 b=CErZsqTE+LdKmre5I7GP0g/+aiAU2Po3ossgztrbibHMwCnrr6jcT8LKgsMsZlATkkDrOa1lt5X04BxIKXKTXphmgBjvWIio8UG86PKj9FcfkW09H4WavxHoKc4HUSBCnl+OAFgkY0Qsq9skS7zyFu+WhwRkTvasyzaGNE2g9JL0KmPddjgeBNAz0CTgUEK/c6DuFObPDlIKjpdCzUqckiXHfC+A1cKzdl6MZ8quYk3bk6sJFQ+uVLss8b4zVVz7cMcmiNI6iSf9PlEuXp7V0GEN7aJBX+/BmBYjf9DW7fAxTO9/UGz80D8PlkK52ts942bg83JX5bVZLM3Ar+yJDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaeM2v3UQ80npTWppny2toibd4s9ovy2f6ybXCX9nUE=;
 b=al4W1LtYjH/NhsWEgIrwQ7rngpXBIWRBZDRqfgO+atuu4anU5exLi4ANB4WPvbmzqPKcMoYH37PbMryO0teP479vdtXp+WUwzBjbT4wJKZLa6SMeFd1blCgxtrj6o6llv+2WFpTUjCaGMXP1rtD/QXvT3VXOgty7cXfwI0jJeAk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TYWPR01MB7306.jpnprd01.prod.outlook.com
 (2603:1096:400:e8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 16:02:11 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 16:02:11 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 8/8] spi: rzv2h-rspi: Add suspend/resume support
Date: Thu, 26 Nov 2026 17:01:19 +0100
Message-ID: <20261126160119.3836850-9-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126160119.3836850-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126160119.3836850-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VIVP296CA0010.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:357::14) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TYWPR01MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: a94bde0f-1a48-4240-50aa-08df4bd6a198
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|261102123227099003|10067099003|261026140227099003|56012099006|11063799006|261028144727099003|261022105027099003|261021123027099003|261022075727099003|261021121427099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4bAi/Yra+oPjBAkD0xMqaN035pLVJvfhkn27iAa9XOXj6sPnIs1m+iEFy27nDwcKb7ZALeu9KIKyvWkGWSI21RNsUhdhp7bnbuYVohwtqVARAbflLvuEr0RIGUy2VJun4Ab0MSP9xiVcmylwKvvhfJNqX59Mh55w0NnqqBu0yJyCRT4Dzhyvpfv+pS92wlspbBlbp8FkhgvmjXOh4xIDvSnIUWuo/xo2Pdr52ZzBnCzRc3doZns2xfSW/JFhATQMNSMe3pYH5G/oyfnJur7vlekjM0ciBtgIviIhuiAqlldhHwOXdEmTLhFojs26SP1kLq0/VDBHmSaD+UEivj3Cwfi+XMGeHT0BhymvnHEd/Kj57jyWDbh88ki1FIbi+YdIYlJoRJgsnRD6i9AeBWdNjUJjLjWwUM2sZIHnqPNwBJaAA2L6RfASZTjc3cF7sUZwbfPzn79QHxiJ7RjgNCKLrVRDOLj58Cpfgv4BVsyFadkO9eHbcETLU0gPN0dNbOenLEdPxkwF9u3kS6Q44NtGJYtErf1ruzdf6uqv7ZGlLryDsO4/WG1N50AAl7wy8tjOfPUx6/j+AOVcZlLFCBEt/D54YTsc/S9UJ/4c5jSGrCYYxBPscjquRiSsl/gaKtM+G0FJ6+7k/QUFzHZAnkTfWpkXvyk19TYYCOIyWGGSPyM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(261102123227099003)(10067099003)(261026140227099003)(56012099006)(11063799006)(261028144727099003)(261022105027099003)(261021123027099003)(261022075727099003)(261021121427099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qNSPFnDRER2UcXGAePCtgiHV5EXvOn9mebnmah/mpzAkKslqIZoMXHLl99Rn?=
 =?us-ascii?Q?wyf6X7qF1e3c1huwYNvLEl4uR7s1De8vW40WBRLRML7hARgt8e/PI/twVHQr?=
 =?us-ascii?Q?5AsyWGLPDFhItIk6Wy+Aado/z83kRvm8dHDRKRwp7OZYHfP8h0FYsHAKM0BV?=
 =?us-ascii?Q?LRhoMBjrhUSglociMl0MVfDnLlm1Nbl9yL5kND1DqTuQckQCtqvNVyu8E8gL?=
 =?us-ascii?Q?vcTEnJIPi9UP53vKS4Aa3XIxQCxgtkA3aHzY5oIg2S6igZ13ubTZqO2dBh4/?=
 =?us-ascii?Q?ZUih0mYUzM/wcISjm4B7OdPWHE5zYD09WHGeswy+VCyXZuPtISb5zqoP62IJ?=
 =?us-ascii?Q?grlcqHUhe5gwNZltEyJrbM4jZB1vLDqd6Y1tWvev5tVpUpV1LZ75WwcTVC3I?=
 =?us-ascii?Q?dIwtsGam4BTIQbdrXow1miRuh2d3wRHlP22YnyUfp6t4p6lJMJfJKhzey5Kv?=
 =?us-ascii?Q?fhsrq5g2RIIZHDF/oXe4od+1HWLw0utbM5J1JiA/cWWjG+FI5Vvr8uwCnMCZ?=
 =?us-ascii?Q?/s7Sf48O+191qoOrRBoAR3G8JItebL4pGAA8P+e0kx9BrqejclWROOTJXtpw?=
 =?us-ascii?Q?oSuBWqEDOJovgqxMeRviT2+H720cJfKmaJ6OMvFpvJOb7c7oyUDJZzvt781I?=
 =?us-ascii?Q?OFE65zgr5LQYeTEocfX6OA0ViPCBjUOlpf28Qo2hp16PC0LvZM5/a7xUexdy?=
 =?us-ascii?Q?Mj81RIY5ta4ot3MWigTcmOlvvouq5xjjALMx0Q38RiuBdT0sh0Dd0+JngAeO?=
 =?us-ascii?Q?GFGmLf7cMl9sQ6BMtcgLhNt2bzViyTuSg6WLJ+QvAf0UTOeNY8RYAtqLHdmy?=
 =?us-ascii?Q?fHitAgTPe90GYuZ+llFlnzTYDPQ6Z96rgabVyJquZzI51UqQpXSOr8HOlhHv?=
 =?us-ascii?Q?7UxCXuJ2Jx15/MSu16zRkP78ftkAUyBPU5Ik04Iw+apwN2W1OC3Ny7gKOhrY?=
 =?us-ascii?Q?vXFn8b2YJso4Nea/P/HBl+cIf6ok8OsZLe6DzHLvfzoJ0dXzueNFXxbhBugX?=
 =?us-ascii?Q?dPI4TPpOd/WA1TLJ45ySrKIXQgkLX7H5MOXvl4JZ6yHrVbmptdtb+VOByCSL?=
 =?us-ascii?Q?0EKKYvmhpMQ3nYXvkf9spih2xlJm/6+8Z3AIQt7oQHGTfkOYY7NI2LOqFV5f?=
 =?us-ascii?Q?DATxDr4u0GANn/rRB/Co/pHcjoSTZo3Gt01jJk1Q4WGkcwSXrCTADQbzdN7V?=
 =?us-ascii?Q?3MzIS7HpmPZ4wE8l73MSig1nEsXOwsrXuZs6AqgD5g77sf/fGp0cLbLTRoQe?=
 =?us-ascii?Q?+aMfXVXIpwRmIKvysJBwuVndiTp3UsJ4pNI9ywhxmabsGovD3tvqT35LAXtf?=
 =?us-ascii?Q?yZPzrXLRMDUOcIdlEirC8OD156okCyokakLVYmdBNrao0uvKtLUfgNR7vZJX?=
 =?us-ascii?Q?sIEQS6laPE06koG+NenRhMNDpfpQgTsvaFSBRE43bTCs0O1K+Ptpa9RD3QKc?=
 =?us-ascii?Q?18nXyHVRh9AH6nIYEgqmwwpMf3cYdj1kCtz3TpaubQhGPjr+c4vUWNLoM6J1?=
 =?us-ascii?Q?wATxnJT6uGrl0ITd4z2IN5jk4CjM33gPYrDbS5O0YJ5NHnVXAWo4wCcA2wD/?=
 =?us-ascii?Q?Ickz1S4en/VTUdcwV3BJI5aRPFAW9Z5B3lgxAt4GyYect6GD3Ns+t7XyiR6z?=
 =?us-ascii?Q?kxkMFR6rHaZDac94oLLdwi/7+bQzJcQXFt2saAeDcdvg+XSdwUyPOY9Hr8tu?=
 =?us-ascii?Q?BVzVsWLvtoyLsIGgCIGBFvh62H3sw5soPLjNIHjpwjeKlbzUGu/mrWmHZgFB?=
 =?us-ascii?Q?xGdOvVmnoHE/10RMsvvpn8dmlm3AMzSHdiVpL/VGbLavoV5VSEht?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94bde0f-1a48-4240-50aa-08df4bd6a198
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 16:02:11.6576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4pXIUlIF6u5q9/Osp7X+qzDyLaK9BoMkbQxxPgvqQtKL4t4ApFQ+2wafMHLGeKHae2gE8tueLh3GQvBTOoYQT+ldKO8GeIMuDfyy29VK/RGp2GKqQDA4OJTqr/Fk233
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB7306
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 16:02:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25223
Content-Type: text/plain; charset="utf-8"

commit 2cf4ad412f90f54597be95a6ce297d016d2fbef9 upstream.

Add suspend/resume support to the rzv2h-rspi driver by implementing
suspend and resume callbacks that delegate to spi_controller_suspend()
and spi_controller_resume() respectively.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260608202509.3651345-1-tommaso.merciai.xr@=
bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index c94215a9a8e9..020869e6c492 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -804,6 +804,23 @@ static int rzv2h_rspi_probe(struct platform_device *pd=
ev)
 	return ret;
 }
=20
+static int rzv2h_rspi_suspend(struct device *dev)
+{
+	struct rzv2h_rspi_priv *rspi =3D dev_get_drvdata(dev);
+
+	return spi_controller_suspend(rspi->controller);
+}
+
+static int rzv2h_rspi_resume(struct device *dev)
+{
+	struct rzv2h_rspi_priv *rspi =3D dev_get_drvdata(dev);
+
+	return spi_controller_resume(rspi->controller);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(rzv2h_rspi_pm_ops, rzv2h_rspi_suspend,
+				rzv2h_rspi_resume);
+
 static const struct rzv2h_rspi_info rzv2h_info =3D {
 	.find_tclk_rate =3D rzv2h_rspi_find_rate_fixed,
 	.tclk_name =3D "tclk",
@@ -839,6 +856,7 @@ static struct platform_driver rzv2h_rspi_drv =3D {
 	.driver =3D {
 		.name =3D "rzv2h_rspi",
 		.of_match_table =3D rzv2h_rspi_match,
+		.pm =3D pm_sleep_ptr(&rzv2h_rspi_pm_ops),
 	},
 };
 module_platform_driver(rzv2h_rspi_drv);
--=20
2.54.0

