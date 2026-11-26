Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.37])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.411.1795708453005861810
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:54:13 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=P44nwhq3;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.37, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1m7VTARmv4J6+Boh7hhxoWFMUfmMYYJ1p0SoRLs3ZZcjGEflizxoPgEDBm8VgUSIBFesx4Gm7oOuy94ixT7/OJbQE07QSBL195YoUCoF5BMWCQg1Xn/xzKiX8aD2MliJ8UmoEycMPsrnPu/23KQ7dWfRyqUsCtsfXbdWbe7OrHv5MKLiXiEpYVLgl+9+iXYrDYEOkXOnbGgDwLnFMdgxO7EQOWaezfFJ2alCo4KGYApEdFme1JZ1dH4Tq3/DZgUZVPwBvuEAbKojmOv7XBriYGSFE0mNNbr6wFRCkFh9xVcGrRutlkA0ODent2obJ71CmOCnrq4Hcttcbe6G5RQfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0TWPijuwAaNRqJPeWr1waM8JKzTYirYQTd5s5F6CEc=;
 b=VzOPUYSGN1eoWE27ouGHgFOzcanS52HCpZxyi1CV2DbW3f0RsXnYdBP0FaMQOAhUq3hziziAdx5IPwkZTuwAW0OaMaPutrDuaDkNsBfUNomURYPSvo5yAi1kwOj23Xfeo08G6q529Bj6y+7xiu3fzJ0Iq9ZB4v4HL9ZlcQp0XC2R+8RxWu7eAWNmh5wWY00OxcjZtshNupI8eMveB3IM94IZg0wnYcj8iyf5cuCDkNI0II3vDpA5l8ZTPUehngGZhG62Or8gvRjfePWlulnt3qgXeIjCFUFGUnVM9w2SE9OrNOnC7/nCfHrOO3yIvvmgUoF3mD5yi310GXOcjFYInw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0TWPijuwAaNRqJPeWr1waM8JKzTYirYQTd5s5F6CEc=;
 b=P44nwhq3ZOCa7yNt753C3WlxsIhas/gWZtvUXFNE5SECIjmilJMpdUBJ96yEjGkGvV/fgIP5tIk5QKkOSyPzdluxPKyxOlffLWMhviKeDW7vQx6qjV0b5YOet94N7fkPmo9vXeoNqyYDcmEt6wm0Qm8huOhYIfnecamB6krc+Fs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OS9PR01MB16957.jpnprd01.prod.outlook.com
 (2603:1096:604:410::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:54:11 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:54:11 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 08/12] ASoC: renesas: rz-ssi: Drop goto label
Date: Thu, 26 Nov 2026 16:53:17 +0100
Message-ID: <20261126155321.3834347-9-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 860f5a57-f951-40a9-3cb4-08df4bd5835e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|366016|1800799024|23010399003|38350700014|261021121427099003|56012099006|10067099003|11063799006|261028144727099003|261022105027099003|261026140227099003|261021123027099003|261102123227099003|261026121527099003|261009223027099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qZBbRLbahOHzGtY6r6Rxd+eJAi9waenq84AzYlBnwC6UbXjxxLX9+u8M7UtbQ330eIurwAcGh8kHMQVkrqTA6NtTEzntBBq8NNqEifbwMWqRyfCHNn3U7b1E46NdhGDZQH/bEQmvgSTbmk+5yjGAM48fPfEuFmmLuynymV0eb6jExtr2cEbvhGM7fcyAvrE7V+deyj10n4Q9gZWmrTfKopRSGeqI1BiMjC4UrRIWamozZsA7a6jqMLmJ5DOW8SISNBUxUv6aRCEVg5EiYgFzEtwJ3msBWBgACxlIWFlZaA9ssUxJmSAizTduPZ9kPrH2UY0+tgyJcuNvlnk7FKdNaZhTM5WcdP7OpWu22RfeIe6lHCEIRs4HoKtT0APgYpvIQSs5X/UzgeDOqZWSso9BgBVpkdjVnaluBWRMTkNzIvjMj8T+TSwrI6pzZCehTfBb9Uk3laX/vcYQwQmB5T9sd8Zq9UaKPG8Pjp5NgensMuWvNsvbNyXZ0Ryrd9AXQrVIWkJpwlyS6FMTGBFgu8e+WFzaXFT8r+bvkT4QUcsHUVOeigTwDG53ctX08mFA3PoTaDfDhhN+I0r8jTPad1mKKRLfYfj6QnKiwDdP3USdsa3i94ELAawi0k1i+E/1UwrDh1N3A/OYEP++H+dZvSIVhnZbrUplPdpMolPnIW7fzJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(23010399003)(38350700014)(261021121427099003)(56012099006)(10067099003)(11063799006)(261028144727099003)(261022105027099003)(261026140227099003)(261021123027099003)(261102123227099003)(261026121527099003)(261009223027099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ww4ZOV/9eiJ9TktxbijL/gQq0zDshwXLRmsvGbmT6Cs2KOyOh4RPm1gCLxLz?=
 =?us-ascii?Q?t1W3mkb3s8pKgZoTnBxRg45pJyQM3z0MeyentOCM9PNwJUEn75U36oFEXK1J?=
 =?us-ascii?Q?n8hIh5JMg1dNC2oBeEs3goY0Bxqw6YF3Msi9G1CFFcH06omv/hL8y6dbvI08?=
 =?us-ascii?Q?c+1W4LVOIJ4oDeFjwASO03/V6lPHFLVIzVCz6xZSf5KA0qeSXpb+56IeMIfQ?=
 =?us-ascii?Q?ejPo0kUJQJPLaFby/x2OWLI7QjWzgmneVBxPo1TFLDB4Rw6TeQ37DS+w0R4j?=
 =?us-ascii?Q?9TBD0Rnyw8Fdojuj9KrxJ/Jpso8CPJlmWgGex3XdHcGW8RUgSwAt5P6ebja/?=
 =?us-ascii?Q?T3nRNwnWWu5MnrM+1Zx5XBwYBK5uaIjfdVRpp1MdCbjTSTKlbSZCBQhvNLkV?=
 =?us-ascii?Q?7/tUio0ZJG+ls+jVFLhzseP6pkzvswANjHE8YlL4cU5TkqxIqKo9/mdg5+uk?=
 =?us-ascii?Q?55zNpV+uEGyqxInLdo4Wcik53Rin2lOHwkFOYDoY8h0TMPjQ49bb4DtEekPz?=
 =?us-ascii?Q?dWzwjmnmDYPfI/XsCS8c+goZrzsnrckM00zqmB9QJmMgINjfsny75kMFa0sO?=
 =?us-ascii?Q?82LsubRlBSL9+bkj3QvQC8LJhDJKZ4ghT/9Dtf1IZtUY09cl1WdG5u5LxJEx?=
 =?us-ascii?Q?7C4ugG2Z//NIfZTCYkl1+ehC3uLfF6JcN1CKepqtFJC+gB0lD24DvwsbMCsQ?=
 =?us-ascii?Q?9kA3HuKzusVFoeNK7fTH6/aIXQAVfrwdxAFJ8HShm3gwpyB9WdGwqARtxVPJ?=
 =?us-ascii?Q?dMFpGAdcmMo/LZHNezTogmAlT/5pDhs3elJmhF/g8UUVRba2T4svsJ2Ht7AQ?=
 =?us-ascii?Q?yhgjkEDD02hfbOAH9gn4tbLKS3Ti7AyGjuPNpsoMHcHlGV+6oMP64junhzhx?=
 =?us-ascii?Q?8XGjQH95UP/LizY3+NGiRWq8qIuQnHsaPGGnY60xcCW46r8uL08B8Qhm2TFB?=
 =?us-ascii?Q?5yR8ZVN7Tq0EfXvr/RLrrP+Npkhzyx9n1jt/UpQ9XXrA/P3G/YoR2/8Hqrr/?=
 =?us-ascii?Q?xE6ykw6UYBDSVDzlMC0DfBXUXvKcCkcX+g+OeqcHR8Qs2AQK5EZI6uAcRprc?=
 =?us-ascii?Q?uW+aTYvOCQbc4S5Ws6w5Vv6OoVkcBk9v1kZLGfsTlJDeE2+MSY8RLdXSIivx?=
 =?us-ascii?Q?MGaHA5m3Wl5wg6zghoTpLGEUY+fZE9XEo/Olljo/NfgkhTCW6cBt/H/UsDuh?=
 =?us-ascii?Q?SMcaKS0nz6u3RhO2CyJU9HPgsxnBgu8aHBRXXg8JC3Ycwn9CoYIO/xr5WC0n?=
 =?us-ascii?Q?48Ci/hg1jSFkZcg+lAgw+VOFyOw9m4GN/yIC9rMeyVZegmcEpGmkv6scWE6z?=
 =?us-ascii?Q?LER+A2SOLgwEedDiWQGi9nmIXFcWEmvOQbaB/t0Iz6nv6oNoxo9hJg8yloKs?=
 =?us-ascii?Q?CFePo+ZPoW7rycY7r8SP1JwI8QWnrfMkDVXyNqGm/+Eof49wzRhH4oL6wIJ2?=
 =?us-ascii?Q?q4srznYAKHh5pKlf80kD6Pa0aHBEJY9vnJJvjK0a2U6j7XjXtfJ7fs6as/bi?=
 =?us-ascii?Q?B5BXwCzei8UbzoPDo+pQcwa1I0RPrTNxGzGbYbpbcQ8zESdyQvn8yqfPnK3G?=
 =?us-ascii?Q?nWixEemABZiYPIbHARvgCHMniD329LiHQ8O7XX5rYoRwXe3vdLdxuKx7+Kxg?=
 =?us-ascii?Q?OhLlNMLwfmOHwTr9tD4ErxAXyiSMMhjop91adg4MbUSAw0u6utJqiOTWUGXb?=
 =?us-ascii?Q?GFcQkAYXiUWy1Aat487aGIc60i5G8yaGVpf4hD0BwDo1v3FP/jFMUBI0sGxN?=
 =?us-ascii?Q?qzPrZtInPxH1sDqJ2qeGbbtSoVNdzj6jHUyW8rQgnELpc8IM5TjY?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860f5a57-f951-40a9-3cb4-08df4bd5835e
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:54:11.7275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDRPRmKJcduaQLDpIq3LQqd6X5E5Lx0dc9nptoEXyGIeAo2tCec2lw/95QIkl6n0BmDnoy9s3vfBW91P5jFz3TEX/Z8Qm1MMXhlJJ3348AO3VkydPGtu1iq61NNPMbAd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16957
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:54:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25186
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit cafadbf430f4b2f3ca4158de48ef6ba4d97fbf17 upstream.

There is no need to jump to a label just to return. Return directly
instead.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260119195252.3362486-5-claudiu.beznea.uj@b=
p.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 5893bc4d51e7..42eee8c480a5 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -882,7 +882,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream =
*substream, int cmd,
 		for (i =3D 0; i < num_transfer; i++) {
 			ret =3D strm->transfer(ssi, strm);
 			if (ret)
-				goto done;
+				return ret;
 		}
=20
 		ret =3D rz_ssi_start(ssi, strm);
@@ -898,7 +898,6 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream =
*substream, int cmd,
 		break;
 	}
=20
-done:
 	return ret;
 }
=20
--=20
2.54.0

