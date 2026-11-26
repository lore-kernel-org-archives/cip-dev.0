Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.23])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.424.1795708434438055543
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:53:54 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=owkdFzSw;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.23, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SW7z81FA5Ln+yqthcJaRhWPLGl+FIvPrMfF83fA8bl1rLURasOJXkND/VmR6XIHYTbYbATegK5FusSPFBqvTAyw7X/9QLN0JAQtsejUGgpR3fyJCEgNRP4kEM1I+lPvT+Bd/yBipgdBQ6p9FZVd8YPt0eF7huMSGuc8f9DXPusXkqreq6KFV1wX5MBBgD0Pt8zeSm6KPG4NvNki50jGgIQaLn+DjXzu/VwbD1XOAipQOGxLdEXmUOCtArEjlF96CvpGXs5YyCSdl/gQa1GaiSxi5n2OX5/YDUFc7nhmhPF5Jdt9YOpEVVxE+RFPkAVcqL+wjeO8jKhRgAD2chKDvaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeAQ0ycJ3b15JCoXBG08c3H04hAhw/oqZfr2ZlSRjHY=;
 b=Ldrj6tWzubX6Mds8mMPGGzz9TjVpJR6M5RMjy4Kt0Oa4eZ53KEHcoEaqx0dJ7rwBk7HQcBHZs14rWsGbiXxkkqMyVxtu8qdiQfbiQ0ya4ThZRYJNTKXpjMXgaJRMPZJmvYpdrTvpd1Ot4fy3FX5n9qCYKlo7K6wT1fTEpbzzu2kNbU4FWL28SGCmxwEVTaphYmHDSzybmmCG7VRFyRZ4S0Ea/kWJw6tWSaRoTqxFIRRtiff77BvFqrzb+f+KraNUbPdz7ygmZu+iOye4Ktge9JHmxxVeITT4hcqEUJG4PoeB2gQFxOrO06hLXUkVYRfzvPTWa9U1W+0bSLiW+ZdxwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeAQ0ycJ3b15JCoXBG08c3H04hAhw/oqZfr2ZlSRjHY=;
 b=owkdFzSwkM6rOQ8q9A6ObjCp3l3REi+rb8N2+xHOniElrq+lv4M+k7le+CXfukVE2LrQTI/R58ZDXxq93A819IIZTaqX1jgHSPRF0CDql1XasEQdFvmgVXck+mhIajTSmd8tn79mNZ7vJS9fVsee9bD3a06m/o3qWAY7e0Un0DU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB13015.jpnprd01.prod.outlook.com
 (2603:1096:405:1dd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:53:52 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:53:52 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 01/12] ASoC: sh: rz-ssi: Convert to platform remove callback returning void
Date: Thu, 26 Nov 2026 16:53:10 +0100
Message-ID: <20261126155321.3834347-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126155321.3834347-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126155321.3834347-1-tommaso.merciai.xr@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::20) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY4PR01MB13015:EE_
X-MS-Office365-Filtering-Correlation-Id: a49d52ef-a8ff-4c42-bb28-08df4bd577b3
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|52116014|23010399003|1800799024|38350700014|10067099003|11063799006|56012099006|261009221727099003|261022105027099003|261009221227099003|261021121427099003|261009223327099003|261009220027099003|261022075727099003|261021123027099003|261102123227099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261021135927099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: EvDYrAc4WqJ84ZuSI2QynAhI9AjAm29W6KKn+ielKzPAwL0nxseUwhFBdMiIuDDVLcDyX+AnL18atMb+FeyXEmQZYFmpdbFsjg9AYn0EluqVozMX4h9wtjGTngbt97HJmAEeLOHNMMgu7QAaQyyf5ZITOUnKzA5AUun9U+C0Jmk4yF7J1QJdrq96eudLV+HIvExDURLs3l8XoxE16om4lvl1j3kHbWpswn5g1JW8JeFfFYuVlPNxjxk8AkQHXePxXCFBUOKMvfWSi6ngFX+GV9WqQWSdSdmAJ6MgklVUr62CFLxHzGp485qdOuZEhpds/ZIIsPxDzbEFewefnG7+cEBhnedFwNET/onw8K20F+30JN2pgrsk0s1Ac7T/VxZaXv0czqoFX98YpiykBHmuthao+FPvKPAnyXczzSVQMtsPG3TKgXXViHWS/ckZIc056k9ST6ursV6eL2+axofe6SCGuYi1czHN1xDj+ZEiQ8dJM6PtyRM2vda9BS8nMjkkbWsZwBPcRhSc+Q8QZ3+lZs+4Skx3BbPMAqNb2m3ff1IMCCCq1MW6OuKU9yD8ea8D3uMp8gjkWMuBiZ4IMPgw0/Yiu2ipMiVLP3amlEGL/fUYDP9C1RtBCWzzQbGlFwS0yZm1w1Wzxn43alwUAFPr7/eBQWi1P6iVTfnNYDgSJBc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(23010399003)(1800799024)(38350700014)(10067099003)(11063799006)(56012099006)(261009221727099003)(261022105027099003)(261009221227099003)(261021121427099003)(261009223327099003)(261009220027099003)(261022075727099003)(261021123027099003)(261102123227099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021135927099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sgwOu+8VBZbvzL5ZeR0/RisUp4MV68teIuBxZp1aVlp2RTJJuok5FZbwQU6m?=
 =?us-ascii?Q?ch415J+70UmOVE2VSxXVK/Wode+f49/RbnqtdipBkt/RVV0wI7rTP18PUnEf?=
 =?us-ascii?Q?BkCEQoG0lkpvOROc3eRspFeX/JcuGKcw3RJWJQZoRr3gqIa2bm9g1L0Dl4+V?=
 =?us-ascii?Q?YE4TbEC3/SJGERu2ywWIjOY01KcGh+228Z2hp1KuTsApb7RHRaoRrf8H2SmZ?=
 =?us-ascii?Q?sdvvjVla0yNz67kPaVX8E3OAAOvjlGsgl/6ku/DeioyXlRD0FBfKTWe1k49t?=
 =?us-ascii?Q?Zh6OMBR/9Lak/QjsE+lNSiKr648k4MlNOwh9Tl2NmKWNUP8wAiS8ZTttpqms?=
 =?us-ascii?Q?1cdfYSfOascjUCJH9NC6CXN28Sx69UVw1L58DjMLyt4tIVbOpS8rxNxWzvWr?=
 =?us-ascii?Q?AZWsFp5Y1b2uJ42BD4ayUSslievWyEoKIU+LJ2zmw5LPYL+To3vjvtXeiABG?=
 =?us-ascii?Q?HavughRtsrQ+ilCs2KbzOI57VdnjEpreUZOXOSWdLbNFsRWGtyjwi7Vujdnh?=
 =?us-ascii?Q?BMiAxR9Pyj+PWTMg6RUrf2LErPGzUD5o/iX/qOAOIPotD6eBYoYU+jH4MNL3?=
 =?us-ascii?Q?NhH3yZF/o85qtmGgQc4Hs0OS5yy21bD0ir/hbAhH1t99GMckFu4Dt7w1quQw?=
 =?us-ascii?Q?LCaHmPc7ESaj6Ou9tk42vkxCn5OFDavDCm9j/MFJK1ijTsQoJ+Fl7VP2taap?=
 =?us-ascii?Q?yvFLOiBzmlUHL3omIyuv7CuoF4AJ9AoNwLobOU5wIf5IE69SPky2riBqjzqg?=
 =?us-ascii?Q?kmylo0991u3THeyLnOsQY40klxWCpRs9Yk0FimiNQ+rpSWJm+F0Fw6xXbFhQ?=
 =?us-ascii?Q?faT4cAlkQzbFlt+NjOYLnLKyYGL8Yn3K3OfVhMYDBvUtR5PKOFSqCO99ieYy?=
 =?us-ascii?Q?W6+8joOwIPlhe55JdSk2odh8aTvZLZCVUcrJf61fGzVRuygfF5PDuP2wYaPI?=
 =?us-ascii?Q?L9VTtsV9YQMZ6Cjj/TA+Pjb7kniNg3DuZkMMEFQxdtQKoS270bVL/vaYtgtn?=
 =?us-ascii?Q?qfjGgi1ltO0P/OBFTMqu0XCG4tAOtFQ0Um1VFbYzNEHb8Zs/Y/adUbWlsISA?=
 =?us-ascii?Q?/RddX9HBgxSXXT1DHnBzIwmJgK20GKyfKXPF/k8i6E1CG4dPEX1Q5iQmQ3h0?=
 =?us-ascii?Q?Sl71VUrn6T3kqrwsNJ2edrAyqfKnXrXP4DNtD+uS4aS0XwkHLgwQpuqGC3xA?=
 =?us-ascii?Q?dlHJQGD7z+9biPeHbzup7RZCo8lpiwjSNPokUNrInOxPUMNAFXHnVaFR8zx5?=
 =?us-ascii?Q?S+ABCCZco3xQOI0hsHORJZzirwy/hL/TRMKnTqAzSNCFb3CUx3UMJDCEuP3b?=
 =?us-ascii?Q?cZeJzKdhtx6CbvEpS3HV9EY1YWCU+08ueaA+iDt8bffsvFcQMncFArB9zURl?=
 =?us-ascii?Q?BcVMrK2M0OGKemBWK3vgS+CqbqDNQDEHwzcl0VfSG1FvQ3pmISB5rY049QFI?=
 =?us-ascii?Q?GBxN7c5tm3Dxgqir8DgJ+32DT8c/TtEnk+urjQDYda+Xzh5zwShe1an/hHIr?=
 =?us-ascii?Q?0J/dhcp6Ph2IpP0sBp+El8VQaYrhMHuAWF21vrNWL+EVkMcVz/V4cAOYiXpi?=
 =?us-ascii?Q?YrHYT43YzHw/85sMw/d9w4uHqIuamivGIB6tYlmXoXMc0qgXewukO4QT1Cdd?=
 =?us-ascii?Q?aIFWcEipFBlcjj+Z9U2K2bG2QabA3WIrnm+132lYyT90zqAKknrQTgyDTJoU?=
 =?us-ascii?Q?gDJ2IGAjQW1CqZmxpNv3arvqO1qSTbxDRgh7NTw2umgFX07Non4khPyk/fLX?=
 =?us-ascii?Q?pvfMdwvZsQIzhnzPxfNGnCIe0QXGZiVAI73eK0NFIn9mP/VJwReR?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a49d52ef-a8ff-4c42-bb28-08df4bd577b3
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:53:52.1071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aVNY0xCkJSOOgtBL/tqr1TAecvdLaRT9YhlDWs1ZWc9LGC0Fk6bLvE8nW+Q2sO+P+kceoY4IVHwD92XuV+4kMAVyPjjRG4q1hD2bkQJfA3oVxAa229yyz9SdCT4ef6RN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13015
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:54:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25179

From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

commit b89438c71d72a9afbf72836630bfc995fed59e68 upstream.

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Acked-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Link: https://lore.kernel.org/r/20230315150745.67084-134-u.kleine-koenig@pe=
ngutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index b50868a9d2db..bb3be2c338e2 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1287,15 +1287,13 @@ static int rz_ssi_probe(struct platform_device *pde=
v)
 	return ret;
 }
=20
-static int rz_ssi_remove(struct platform_device *pdev)
+static void rz_ssi_remove(struct platform_device *pdev)
 {
 	struct rz_ssi_priv *ssi =3D dev_get_drvdata(&pdev->dev);
=20
 	rz_ssi_release_dma_channels(ssi);
=20
 	reset_control_assert(ssi->rstc);
-
-	return 0;
 }
=20
 static const struct of_device_id rz_ssi_of_match[] =3D {
@@ -1330,7 +1328,7 @@ static struct platform_driver rz_ssi_driver =3D {
 		.pm =3D pm_ptr(&rz_ssi_pm_ops),
 	},
 	.probe		=3D rz_ssi_probe,
-	.remove		=3D rz_ssi_remove,
+	.remove_new	=3D rz_ssi_remove,
 };
=20
 module_platform_driver(rz_ssi_driver);
--=20
2.54.0

