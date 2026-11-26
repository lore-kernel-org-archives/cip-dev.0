Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.650.1795708923051588618
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 08:02:03 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=FULnzg+m;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.47, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsCqE83oQBtMgoCu55hhNt4HWmdwCPAQdsIZPtSOpjPXy9+1TblkskoFKGCYiO1Y2BCbIrc5o97OavYGsz53yiazVqsVIql02qTuRYKJ9CrTLJhlGI6koxffiZHMNZdwpUg+h9FTcj9Zu2A5fvMf77kLNIHEqGBnn77UU5re7ajX7PSZzsxiIam/Pcd0QGPNVFfujXfYZEPqxnbfku0jJt6qBolrcdbQObQ1V+vgF7quxTL8F6J039Wog0NBaI4uirQHYH8HcoS0un7KoFHaKUeS3kcUF5Ws76ezX6xsEJ3avOYXuoTJKSNQRwi5+vzX/J78waiwtduAckCYDRqGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7u9bq/9K9vHP72Peb+YefNepw4irzVYheFzldLT3YM=;
 b=N602Xbbf9Q6qhKycdqXR2hu1bZv0wSUoncgB/r5jXuGF20J1XPe1dvNARSZyjPv2b/tWVxiyePvTwDfw37eB7rZ5JMzp2uKqkuXl0i4f5zHhEVb12cLb8wmppQxwz4GlGGFZABsHCPQL6D0NP44wz+laPxTD6s3aOLkieWo0LbNwGVgQzDZ2Nqc+Zot+HzOoVNO+9eHDzrFffjOVonjdvt1FSzPNflCOO3HLr5yvd/6VBYaJ6z8M4L8logfe++5iAcQSCfZSWByJBJraoIxzDJuPYDiVtxxno1jnZHHQTryFGfyGt0Z0elWf4m31vn0PfmTtCmM5SF/Ne5E1vQBB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7u9bq/9K9vHP72Peb+YefNepw4irzVYheFzldLT3YM=;
 b=FULnzg+mPeGOJkFDZgVMxlmeGQ0aGKUpc+QjoUWTDNDkEN7iSmsKiZEMsigfhXzyApw0b2U9LcSyFCrNFL1uIbZp1mgscVywy3NxqAr2AD04VbO/cMl54l4SQ0AtSmYQ5hLGr3sCHMnR0iEqc10CgDgnaOUkEI+XhFzGLG0NkYg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY5PR01MB181845.jpnprd01.prod.outlook.com
 (2603:1096:403:50b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 16:01:59 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 16:01:59 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 4/8] ASoC: renesas: rz-ssi: Drop goto label
Date: Thu, 26 Nov 2026 17:01:15 +0100
Message-ID: <20261126160119.3836850-5-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY5PR01MB181845:EE_
X-MS-Office365-Filtering-Correlation-Id: 1386d13f-80e9-4207-5b84-08df4bd69a49
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|52116014|1800799024|6133799003|261009223027099003|18002099003|22082099003|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261021121427099003|38350700014|261021123027099003;
X-Microsoft-Antispam-Message-Info: wtBrLC3wWJmCkhwIcI2UhszC5cVnxgd4BI/f6YpAj4IDuAVw9psRArtyTRdPBO7uoVM8pUPDIu4N4roI1tPaF4b4qh16yb3d43DdTSmPnHkBcKe6NWFD6FeEOgnyj7Lq96qQFAVR2YlFywhD/ebWzvQe4IPlv/lRUt7h6R1yRcWf6WKMKZKXOhnVrz/BhksiWt06fJEgX8Y32a5HaRbx20WEXfNivekwoHx6m8K2NWR2dyanwEGkVRa+/pCZ1zDLsOrNnHPb0H+DqMliSh0POWIY9Z8ooDQ9qfQpuw6xf0EEwusKAyga26nf2NvDTye5e3gWoX2beg6SrFpKnwfHxvXn3+ndC3R7yPAxJlLDnDNB8f6vpwVNCjSbydtsxdqWqBfI2JA9cQdJwNQGEcwNVK+vuXkalF4SlCtXowFN5fbNUEw+PEut5AFGKhezsUQtAGzmrFT/dwbJJ5uyON81EEuy8Oy1XrAJ51YltbaEEcT4ZcEKOhZCzljc+YZNtZei6xQi+Jdu0XKk9J8DCAdclVvhSRh+9lJedkmFKP9zT+8/QHynRkvClN8G86/amUqwyL/kzg90nPI4Z7d1jWF9mlt9tSZlJAzHxttPMuPel7OqB8kbwW/q6xO1fa4Le1/7lnXk6XK//FoyTXC04hquWuzkoSXQfPt/258ZIv2V70A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(52116014)(1800799024)(6133799003)(261009223027099003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021121427099003)(38350700014)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wJqn5QLtdecN8IJrEc+V329iopLvFq4/BZMZOTHCG0h8N9snf7n4PBqfnieW?=
 =?us-ascii?Q?KEYPcuZVkPyTuQ3hEy+HnNHU9qoYB3KDf7INYwqrFm9ZdjiDyRqaHWrC3pwh?=
 =?us-ascii?Q?tcSoNY67gjLa3ZkiGqbVl1XlZn5zBVWlghDfE4Si2vt66vXMWN1p4TADlCOr?=
 =?us-ascii?Q?dfLVvUto1D6H7W+q0ST4YWcH8Eb/WjXsBlKGdrXz3suz5oqwtI0XOKnATy7L?=
 =?us-ascii?Q?PdwBEZ8r1Z2UWw8PF9yiqUoh7zXFjTjNX7RRg3xSK1uRhAw7F7wFP1s5B6mC?=
 =?us-ascii?Q?BysHLdZsIKyiaK8Fpwcg96H/gVhza/hVEk+bSaqjVh8GvtzMVuBkuty2z25K?=
 =?us-ascii?Q?7RHUeLq+umlvs5rdt6MJxNHe2482I6dQwIxiVgHhOoiySwWJ+gR4/GLiid30?=
 =?us-ascii?Q?DGOFUsKFHVcIG11O90ws8Yhubvlb3lRxCYA36QblaSzKxd/ytNS1LYA+HDqY?=
 =?us-ascii?Q?xPUowOIMxX+LZxSXrI5vkNNmrvqTAjO3hBui0X6o+ar9SZ45JWhNKfDOGkTq?=
 =?us-ascii?Q?+IkW9nL5seEMeAcXp+ww5oUcfKtNvYQBu9zusskY+NfG/4S3hzRUIQ648x/4?=
 =?us-ascii?Q?WV53CngUUXe3NMWGvgPj0JeDFn3aF/cKFFCy7kXKvzczIbYL19j1zKzD4Nyp?=
 =?us-ascii?Q?QwbsCkw6O7L9cuB3ssqkrPWc2vPf+lIy/4fMesmEGtV7Fj688wLeKC/LDN0R?=
 =?us-ascii?Q?RAST8Loigz+s2fpOG2EYb0n6fHlT7O7zAIxSdKOLAgCThE1RGTL6VKMftVj4?=
 =?us-ascii?Q?TLQziOg6O13ycH8g6I1w4q0Gb45oKiuzy7UuhMhNHDifdxNP8ercNacD7YUu?=
 =?us-ascii?Q?7IU+29vswTEpSvLXsKZUS2SvnVXzESTuPWxwNEzSUBM+KG4mWpZHvZprxmNZ?=
 =?us-ascii?Q?/iENDaIYErTc/AP8mIJZdRW2dzNsMszGIF1JIWQVkn1mVDU3sxTgSKNI3Nme?=
 =?us-ascii?Q?4VuYmlJ7Y2CSz6YyI8IsZCag5VbbtEO+Kjp7UnnHDvjXR6uH5cfo+sYLW9XJ?=
 =?us-ascii?Q?FtQ81mNJxY1a7ZeiqK1wSFpC6AjmPy3iWlmKsLMaKyffJDYluYAy6AosTN7D?=
 =?us-ascii?Q?nzuIQyqA6FOZQT8LfMFH68GvINW01wxRbqe1onuK5QnUwjM8ne5D4E9T3lAl?=
 =?us-ascii?Q?AJG3rtIEzrOiii9W6Iqzjdef8fxwCts2Mz6YEkh927nxIy0LU3W4HFt8wNxA?=
 =?us-ascii?Q?nuRcp978OGxTKzaFhHgLviOenUNo+f67z1MOZ7BkH6I0K3YGkuI4F8B/T9sI?=
 =?us-ascii?Q?pqo/dbOsqNHhLEJe3/3a3Em0TwIBu/RHwr9Ft5bNLPReOwj559KBv1uLtYFx?=
 =?us-ascii?Q?WcOfQTSNIO+4rjUOy0y5SA323aLZfLq0SgdplMwhuDr6m6MF8JaKyFtW1aFt?=
 =?us-ascii?Q?uUWBUbHkrC3QOBKdFs0iCVRZO9UCx+S8+c2IKUfFfLf+cuJBSZaccWvC/SMK?=
 =?us-ascii?Q?9GS3R34geQ78bsMheGMToK2HFIRvx+DQxUpevFNjUpgCeVTADHHKEwC9kwet?=
 =?us-ascii?Q?XCdJPfMUsxdHLaDxtuvA7Q9v3rXMypi/wDbZkqFTz5KAE9Uj0bmlWpGG8WF4?=
 =?us-ascii?Q?R1OtOiwGWVm9yYJyRC1fg5moLb8YgwKHJGLNe7KRWlIU/8FIFBgwQm4pzdxO?=
 =?us-ascii?Q?ISyxhVqtIpcD4AycwFeNetMvf9hb9/wTY+LbiduRyhwbu8Lihw0mL00BXKmy?=
 =?us-ascii?Q?lOG0RSSPaWcGz8vlw/EbIe0GWaCDZkysKjJLxGcjG2DwwFGtvfPTUb8BZIYb?=
 =?us-ascii?Q?7gWRghiBLJlg6xi45sXrEZGWNfJAKUsbYSlnYhizTGyaYsJK9xfo?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1386d13f-80e9-4207-5b84-08df4bd69a49
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 16:01:59.6853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gaMaobKezJOJkuTtul5SuQJDzuzl6sf9Ag2/tnnBc3lSgB7/ikfK/FxJRGfpOLha1MhzceXsmaa42KtYX+Zoyp4Tf1I/r2vs/XvN2Ic8dpgujOQdzJja578cD9dB8Hy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB181845
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 16:02:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25219
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
index 11165dafe51a..c892dcd1e619 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -889,7 +889,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream =
*substream, int cmd,
 		for (i =3D 0; i < num_transfer; i++) {
 			ret =3D strm->transfer(ssi, strm);
 			if (ret)
-				goto done;
+				return ret;
 		}
=20
 		ret =3D rz_ssi_start(ssi, strm);
@@ -905,7 +905,6 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream =
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

