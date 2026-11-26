Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.17])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.441.1795708459570829782
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:54:19 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=qUPEV49v;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.17, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TyEZxSsiKz0XPPXkXYYl3uk8EealUL4+fTJVdQX1758Ja2S5uh/rA1D7E8XPzODV/Okkhj44Kn8T5Fq9ErjR05DdkuAZun1KGaf6hdM2bKuTvO3RKnhj0NGfkNSvlzM2VlrdaIWgSRx3Qwb6BfWPSC8GpJEbft1iJ+X+16zrReajaVdZQz5bDoASuLrlruT6j4iNincYUgruM1YS7zX7VIBah7f73eg3vi4YTv02Zv7cMvG18jQ11iQ2b7YEocfGZ0EDXCFEr8NNhpm8rF5Loar68rxLWGhNji7ktIutxU57BHVMOiSmXAdprGdfqleU4hTBDaOgcR698qDWHmod1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldgbfpe4MobCUEhPrmThkXj3UtDPhnICQxhZ3zOQFUE=;
 b=TKI+VJoJ5S6WsveS/IzeXAFASaFzaRhJWyPrzt6nhPbW/B767e+56OKdmW2McxL9TzHWdiDam5C3NBrx56Kxn0+Ts6t/thZNyWycZcMO4abRQAh9roF7CGm/jCagSskr1MH4o9OkpIQ53vLNKgfxMzeiBVd7kRXd6RbICtARPRIC0bRtFhFylzigMTdA9W1N645vZVqTQbl8YrEISXlhNHOJNfnR2otL8SoLN4sR+jkthSu8taqp0W1VxAmncAyzC9w1VHHC5bUxOxo983FD/u/FgvrT7XQWsWBnj97mT81Kl6oHJJr78IOXARVQbrOIXJNOUhPSF0dCoRlTVN2QXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldgbfpe4MobCUEhPrmThkXj3UtDPhnICQxhZ3zOQFUE=;
 b=qUPEV49vdXBSeH8k4DnrXtPOzOOt7TFbLNjq9n8VWjvDI1qYaaeFUwnqKTLkdPsMKgzMExEmf9KvSCbIXedDBgCqe7cn/w1thJjQ7+3DF1IjxtsQKXfSxLyGsqGZQmAThxwYYwT3bbr1c8JYem66CLxkaYcEuIHY5/loeZ0hNl4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OS9PR01MB16957.jpnprd01.prod.outlook.com
 (2603:1096:604:410::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:54:17 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:54:17 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 10/12] ASoC: renesas: rz-ssi: Add pause support
Date: Thu, 26 Nov 2026 16:53:19 +0100
Message-ID: <20261126155321.3834347-11-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: f398a031-015f-4630-03df-08df4bd586b5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|366016|1800799024|23010399003|38350700014|261021121427099003|56012099006|10067099003|11063799006|261026130827099003|261028144727099003|261022105027099003|261022115727099003|261022113327099003|261026140227099003|261021130227099003|261021123027099003|261102123227099003|261026121527099003|261022075727099003|261021135927099003|261009221227099003|261009223027099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vAzyyL6tMj7asJYZytX8lTO+R1llRJYpc0bau0Uq7gz61B7CKOCWGcGU4I4T4Ne5GTGX7zEOJ/c6iV1PTNokazZ60kLA/QMG556ldLiVm+9/F0mMCbzjHqBPvFM99az5Zi9+fagxLaEfkO5NftJ11svmeCBh1Ayqcr8a16dh3E/tHK3mSM60Ybi/e4ic5DPN8TGP2yvevgNpQnjQmDS9K7+mW88M76qXjwpfOIOnPggjaxoBL9CknK1wHucWQULVa+nfn2ZyAF4zD41HVIUNgs+yVj8sQhj/LvhDBwdrilX4xeObn6QCfSc5/Eg4k63zuk36o7OT8dPPJHZyic3XhB7heEM+K6gudWlWe66iBs/uNCTcylst/KuWIY9otxrTXraQfxz0upslSYna0Lq4nZwZwbU1whON6Phkj7VyRcg1IUB9nN0cfNHMvtOkXTAmUgIo1stCWi9hYymp3nNcsJTlRNCfcolr3RGQ/IGiSnKqvoDEa9kgrZ7dt6k1WjgBYdCgIlzNjhLx5JQmH8aeRD0rJlBMaV/rKk27u7CiI5933fC9Nw+9yEH9qHB9K2gzmtldDklrOMxaxlqevPYiHRrph3BhdSAtjrJ3+Q91av4PyN2hdnXpEQaV+DGt6HKVTRMN/7qLcVRtWO2wmca6sL6+JEyDs+OSLZXjsTO8rps=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(23010399003)(38350700014)(261021121427099003)(56012099006)(10067099003)(11063799006)(261026130827099003)(261028144727099003)(261022105027099003)(261022115727099003)(261022113327099003)(261026140227099003)(261021130227099003)(261021123027099003)(261102123227099003)(261026121527099003)(261022075727099003)(261021135927099003)(261009221227099003)(261009223027099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TYkNkcvgRPRnqrTjbaw06le/bg6xazk88xbDMriN7eWf+Q3Dqf9e3MDm0CQw?=
 =?us-ascii?Q?FlkgXTxMYAHOqLvIGxpzLprk8tNoIKK9nYliCetqPDW2sRd+FnOo890TumuE?=
 =?us-ascii?Q?vrGJBHzS+PwDD+rzS/W4G50p8Z0RBI+kei8bCCR7How2Qc2fqir1aLsvdU2+?=
 =?us-ascii?Q?eOvEb1duAQVMmnHwP0/utkdWpS1NuTJoJHIVqeEYn6mGnputB6K9TLQbiqT0?=
 =?us-ascii?Q?DLf3EI3VIMszlK1sItKvc42pewGLEXYXQxFLgb1k5ZEJ+x3OQsHcPQPG/ndX?=
 =?us-ascii?Q?BFA4k5UHevOD3xnorD7+TgoAH720Nj8zn41/N+RdsKAe6UvE9H7R1EjjJlTq?=
 =?us-ascii?Q?iu+22ZWPur9wt9/WY195keMwOxmu2HZHwTYDRzC25m1otQ6DDbfOevWIXbwM?=
 =?us-ascii?Q?3tC7YxPxKV5j0WdbgyHN8UGWrPRpDRyX8OeKnWXtT1sndHeVfN+ASiGH3kwp?=
 =?us-ascii?Q?e9UW0oEOf/0646n3lNIOPbNOWd9K8j1jk0uXdQyRlO/va32BHPe2I/n5uWmz?=
 =?us-ascii?Q?t52iWXpOad4mUdSUmn9x+lWghLRyBbGj+P9NLLovvakhqGOkJYO/dG9INA83?=
 =?us-ascii?Q?fqY7ullGBRVPFk8hIlY+szjgpE88GVdEme/pXbUiEXrvbyKf9MOqJ5bROb3e?=
 =?us-ascii?Q?Jz5roHq1IYRviz/B14isL4Q5/wOxTOpLKZXuaXTegWLuUEOc5b7NojUOf6+Q?=
 =?us-ascii?Q?goNCd11o71qum/9HCUhaNwGmx9fw0lMzGZ3dxxtBNX/VLoVezBMr5DorM2kl?=
 =?us-ascii?Q?cJUedzKD1uKHQTQjL7vi1lvBEjXXhxlZ/cAM/Brd7OCP1l0KTLiYEDHhqVHP?=
 =?us-ascii?Q?aKwzTbC5zcZuhv0Zgcy+JNXSJDn+twDmGIAIJX1MfmJqqvhQYvtx2idBTUIo?=
 =?us-ascii?Q?vBVltuJYQ0jIVxV9N5TQjv4keotxzVT+eERwkj1Y0q66WV+2Lq6sbb9GKnHU?=
 =?us-ascii?Q?dOeKJ63xc7/3GNSsCQe6oG9VQmG6cuGLW8E9T4C278c4ZBNQpbLNgE963rqk?=
 =?us-ascii?Q?ECIFSwAquwGHpyC6wsiBl8IVcPmkfhWCMdFs6l+PLCkkYcVkb1S2FXD/H1k7?=
 =?us-ascii?Q?NtuLGRluq1J2SuuLt9qTMlhEWOm96DrSpvO8N9CB2sciemalLYpR15vCyfB3?=
 =?us-ascii?Q?MNzkG/WzFxXYOMcxeupbRfR2R7Z1buu1VwrFJEkeoglSY4TRvhFKGc71kTUY?=
 =?us-ascii?Q?kynW/MA8sI4uuUynMdbSmKws7s1G6eUgkrtiMJA7mllYoTK6fWpDGLgKKPsg?=
 =?us-ascii?Q?az+e1ovVBHTU0gm7RB9/xguviCiyFq2LpJceXmTZHuuZjkYvOnkrkMj6SFi3?=
 =?us-ascii?Q?SJMYyV1a9L+eTFiQ8P4KIFDQZjaaRy0XyzfYBt5d9Q6C8xXm/cl5pBX8HG/C?=
 =?us-ascii?Q?VQ+c9Sokugby8h1v2SH5iRqIfet6EQwZA+BNpzHSuHSr5+8bVrDYbZeO6gA1?=
 =?us-ascii?Q?db6NhBcZFYp4qhJSDODsZ1aMxekV7m+kPdkZZ+tG502wXsXGDN8gY07Bab3I?=
 =?us-ascii?Q?XMA4JfG8t+4SmF0jCRbSMRlT8KpqlnvtBEKAOyVNU01hFCIParZ7Rd3WwTFp?=
 =?us-ascii?Q?k4frAr3ITO7/8uPXyMrjLhmcNOd3aJJaxf280BPmFjC0U4zhC0Fn9NtFMSjC?=
 =?us-ascii?Q?m/RUpCzw5PVBFJzHFmMNLWZWk0KABl5nL6ihgycgHjWgL6eKx57zXUo6s8jd?=
 =?us-ascii?Q?8ZZzqX+FqlrhIZGeJq3NzVUzooZ9VuR6e4bQS65gB42JYzl8izmh4ilA7Ph3?=
 =?us-ascii?Q?HbYELLxeDkm/jr6LgPUW1Ao4x6NEvALNnhDfKIdTji0V2L09HFSM?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f398a031-015f-4630-03df-08df4bd586b5
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:54:17.0749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a6APNTxAC/QMP3pa9QMlYBJCvTltfitTeU06UZ7d2/ohBcx8Y2HQmN33l9q6Yz8avYlI8+CBaofO7PpYoENqoykqxawOn3HNqni7DL7KWdv0jilIOrxHeYCAF9Qhd4pw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16957
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:54:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25188
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit b4d34819a53964648bc53cabaa3ba9890d4fdf9c upstream.

Add pause support as a preparatory step to switch to PCM dmaengine APIs.

Acked-by: Mark Brown <broonie@kernel.org>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-17-claudiu.beznea@ker=
nel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 0491f0e46187..d9922850cf5e 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -848,6 +848,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream =
*substream, int cmd,
=20
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		ret =3D rz_ssi_trigger_resume(ssi, strm);
 		if (ret)
 			return ret;
@@ -889,6 +890,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream =
*substream, int cmd,
 		break;
=20
 	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		rz_ssi_stop(ssi, strm);
 		break;
=20
@@ -1055,7 +1057,8 @@ static const struct snd_pcm_hardware rz_ssi_pcm_hardw=
are =3D {
 	.info			=3D SNDRV_PCM_INFO_INTERLEAVED	|
 				  SNDRV_PCM_INFO_MMAP		|
 				  SNDRV_PCM_INFO_MMAP_VALID	|
-				  SNDRV_PCM_INFO_RESUME,
+				  SNDRV_PCM_INFO_RESUME		|
+				  SNDRV_PCM_INFO_PAUSE,
 	.buffer_bytes_max	=3D PREALLOC_BUFFER,
 	.period_bytes_min	=3D 32,
 	.period_bytes_max	=3D 8192,
--=20
2.54.0

