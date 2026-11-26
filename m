Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.16])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.588.1795708926365728708
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 08:02:07 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=qfO6Ecfh;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.16, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMZfrSoT7F0ZH+1N+dorDHLrK4FgSizqcYede+QK8CDqIneUl39iXDl0Wrk5YwvZVi4PQZInbfAN/3QrTH4l5PycPJebqMGJoPcUuAB9yVSDzXZdpIoOMi467e/WAPTlSnW0e74LyVzw8omfp0509DNFl0qOEMmJkN5XdV3hXNd2urhzlOfZnxAuro3IBcpZDdD6T/yq88r8Mx9XM2CO5SEEGO3K1JwV8m0At3i3FogqXPfrf37abqDm0vOHUOX68rOjJGykXSVuKwT5aAUWg8Hbl5co7QtImp8O3g2fJPZ2TnNYXjMgBvSFKqZSWRnpz6ggJ0y0nrf1CIDbwu7ylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VelVl1HljVHaEwJ01aWn0SA7E6s7tTAs+DfzgiOp9fA=;
 b=hwsyy9vb09hTRmV6kanhoVM3KXT1Xk/AhYL4YJqHwuVz64377QzfAm2YlYcdh0mEck3g+wVc88N4dvzSOEwFIbJ6J39XgHvL/XR/KTbNDMxkAkmZ9TxQPKG5ECSRcKThqWYZASLU4q1ooiaT/wZXBZt4s+D+tEmDG4iyUrwjeEmMA/yZ0WnFSStv34TMkM3nCFVnhCzORRm200mlNazQYC0IC1EvAudRf0YtFH8csCNW46MMVdv690t8R3/AnjOdiPsYwWidK50Ee87qnHn0SkQWDwRQKtxvNLVdmNKCtXdouJXbDfBhtosR9a/jr7kHEXoiOdoy5BPz3cjhg80GXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VelVl1HljVHaEwJ01aWn0SA7E6s7tTAs+DfzgiOp9fA=;
 b=qfO6EcfhzE2GX2H49bfR3ydj0rq8Xi0jajo535a1WxISqg577M3yeiM0Hb7Ipo3rvuTa9mZHPscwrZM4WGrZbx4LJbV5QfWsSMtp1+cP0Fxl3bglrtavsVu297luZU9aXt2ImJHcWfl826JPzTMWHZVZDqbyidz4sJg1J4B5Feo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY5PR01MB181845.jpnprd01.prod.outlook.com
 (2603:1096:403:50b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 16:02:05 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 16:02:05 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 6/8] ASoC: renesas: rz-ssi: Add pause support
Date: Thu, 26 Nov 2026 17:01:17 +0100
Message-ID: <20261126160119.3836850-7-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4d9af045-f57e-4c74-7333-08df4bd69e00
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|52116014|1800799024|6133799003|261009223027099003|261009221227099003|18002099003|22082099003|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261026130827099003|261026121527099003|261026140227099003|261022105027099003|261021130227099003|261022113327099003|261022075727099003|261022115727099003|261021121427099003|38350700014|261021123027099003|261021135927099003;
X-Microsoft-Antispam-Message-Info: WKv3VNZfIleULTeH0eJukvrNre14g3WE00IIzzK71u3PgMRjPBToMc218tOPiccZd31j7LsoRe58SKQG2+Z1yi9yW6tSm68omqykI9oBjf04Sz4VVfnIPdRXacPqm0zrj87s+MmJ1VlezSOmhAGVkjzD6T6FEyyHowW+eQEn34+uVmGMcgLqJ0FFyxDnNwFCiqoXcMgX9ZnBX5Ukdgk/6f5jy4C8kaJbrT4YiL1YZ4D/ZFUPlWrnSgjdL36GTmRvehVKrsheIRCVhq8BvOIPfFSnuQZ0LyGyqmdQoEeD2Kv2kFu7lRz1VrXz1AlH7PaeRnjMWyDlVIv/wbDl8w9JDQP2Xcoym49nu75LI9HDiUcr3pAABySUZTGBa0tJ2VGqYlGJLkCRv0AfBv/hAA7M1x1aB+74HKfGEcvr9o4DPxMNRDSLO/LIij9nkloDpifGh9sLYwmR9rp+WdxP+8M47b45Eq+hRyE3EV/TMakktiMVOG2RRkl3IAJW6qzxxn82CYt9dW3i/2cN9db/esvcFmUZ2QGIZzdkCqXNsxz/eAsIScYkpZOuSOn27Fo834zUM3Jc7E9ZcKzG0eDRNgsuBHg1ECM+dCvnfO99erK5cHfxDot4nMrJIPR8AOOZE2wSmrJWwXq1SAzN2jQmx5nfTO24RrRah09e0Q0RAIC0z4I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(52116014)(1800799024)(6133799003)(261009223027099003)(261009221227099003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026130827099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021130227099003)(261022113327099003)(261022075727099003)(261022115727099003)(261021121427099003)(38350700014)(261021123027099003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/qJ8Wsel6xOpDqXD1FCBQJco1Lx9ykFFz+ziRSTwSt0TyDTQkAnWDLKtJF3a?=
 =?us-ascii?Q?u8DDji9U4V+J5KPVjU5W1d3GHOxrFGzew0qPGb89W8l+jyhuCIR5yrI2RmoS?=
 =?us-ascii?Q?RfHS/iKxA4GQOlVNqVZPyQCKpLBy0SGCBAZaBPuzXfYvsrB1W5EnOSak+8Uk?=
 =?us-ascii?Q?J1r0Wbp85StehvoyPclxbpvuusTsdv3zas9xwWNptSYpVKedjSxkSRqgbeDX?=
 =?us-ascii?Q?NjtkMcadFDGwI7mIKUazjaaQzjvxaxguoX6mK13lcZrYXH1sWhiap0NwQ1dN?=
 =?us-ascii?Q?SzEGAVAwQiOO6Q76fcZVsFI7lCQUN/jd0XqaVulzwG5YnJdxZxMTqg2mLrVv?=
 =?us-ascii?Q?jqNBlOdF+fDgYT5DOhmRTqUJ+3c/6hqVE9cO7hJyHMTAZKZ35QiNhKaWEJP5?=
 =?us-ascii?Q?UIStoz0hxElqPHzzDUL+zS/p3fm1DA4inN5el+49GVKEGbvnnkJ3D0/Oj42J?=
 =?us-ascii?Q?5mWBL0Zqg7vxnC5lsZ4sYOHutHNY1ntB63Tjhjx5SiqVhjVTqvc1s3XPKV1f?=
 =?us-ascii?Q?hizN3sC8dYbd8SYMVqZVqRcdV+q3JR4lUsJES2JCvT8y/Gw01sfC6znq1gwC?=
 =?us-ascii?Q?zxJiA3jffhtqd1BZk17WE2+nz4J061FAt0xLgg06Fr6wFbwIduWq8Rw3l/OD?=
 =?us-ascii?Q?NC1ouhpDxMe4IfC+mhRvVfVFhvROpYkz0MWlKbFg4sNqq0ScOGGza+7e8sze?=
 =?us-ascii?Q?+HzaDtvYPPJaHKrM+l5PfonfVMu/wcyHvWf8QdRNvjWrJPNc81gQ01tShfNf?=
 =?us-ascii?Q?HfizJzT2WWlt1uZWBg3ip4jF//posx8FIQvBnFZQG6FgCb0TsN4tsj7wi+9L?=
 =?us-ascii?Q?vUpfgZ1HABMrvbCVRAFajowfIm8uicVFPIzF+HWcGHsyRXWGPXFS2erHBS8Q?=
 =?us-ascii?Q?dQbtJ82YgAJHCpVAKTLHyjUFBIR/QCQD/8zFSoYc9KY0nuS+LdWRCxZC5v8L?=
 =?us-ascii?Q?VrT8PhCx2SjLWirvzCQaClU/oHdR6+SSDVodB4N1gdSBYWpx/04V7YFU+dfl?=
 =?us-ascii?Q?UWbMXitZ4GVG3mgVaJ0E7yenseMZuBB3z/aXWvJ/uGXsSkGuvB3RHllujgzA?=
 =?us-ascii?Q?7akHwlnUKlZ9QqbtmfwdtLJEHUjndHFoYxXUeRAfskEbelvqzsu+mYwTxLsb?=
 =?us-ascii?Q?XRD+4Z7R3XtiMlDx9SekOWClqYMy51r+KEDCFRGWHjbpXZHmYdNjNNU+WnE7?=
 =?us-ascii?Q?XTAMTOemrt6KU0L3JZQsiWUiRGlrOvEa7c+YpwBg+SXzrP/Z5nG30SLK9djx?=
 =?us-ascii?Q?psRqxN5uyCPv0iI9Tq2iwOmU73BbsRi9zGh7ghg3vLzaFj7iZ67mo+xyxBih?=
 =?us-ascii?Q?T/yTH/X9XyREHdijGYe6p0GthxYaanfqoTV9IDCyAnTxZo4QWNgJ8RFL0rq3?=
 =?us-ascii?Q?SatjUwYGcfP1bub7LUrGeMKVteEQPVlU/tpv3THStHsmPzNK4NRC01DZw5SI?=
 =?us-ascii?Q?XHTDT6DF+E9WX+ryNU+rM5ZBIPsB7PA/yXAaFJUlwrXdAnC++Nspqlu2bLvT?=
 =?us-ascii?Q?Diqm7W4esRh7uViYMN1Cc3Nr6xrL5M5U4YySQ5VTsLvRcneeVniaSfXoQ2mu?=
 =?us-ascii?Q?wKCsTxvGGPkY+Buv8v/arLd4PkWWPtF0RanvsdZ7uA4bFoRiPjISyAreorka?=
 =?us-ascii?Q?f1qUGZdqrYvprAKwPLvNLukUAimo+bnozqxgQB2v34TcLAjHePEqvA3VrDEE?=
 =?us-ascii?Q?7Mm3S7hS3FTGX8F4ldBfaShZ/aV3RoK68Jf7qb4VbGa7tMJR8Ip/bpYGAwhd?=
 =?us-ascii?Q?oQKA1+BSINX5xixz1jG4JeZYcH+XTDSTBwPBk4wBNjxixfD+/a81?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9af045-f57e-4c74-7333-08df4bd69e00
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 16:02:05.6366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: paU4j7CJ2G+JTpTxr50KCNDJR1R0164pI4zhc9ynvG9p5oS/i5DhTZisLkgi/DCMOYEKQ0ih8NGH9M/H/CQwj57RlZy4w5HYYeWD4rA3XcpsthssCtvxcGHepTpIQDVB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB181845
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 16:02:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25221
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
index 90bf7ceddbe8..5ee356c78cc4 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -855,6 +855,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream =
*substream, int cmd,
=20
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		ret =3D rz_ssi_trigger_resume(ssi, strm);
 		if (ret)
 			return ret;
@@ -896,6 +897,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream =
*substream, int cmd,
 		break;
=20
 	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		rz_ssi_stop(ssi, strm);
 		break;
=20
@@ -1062,7 +1064,8 @@ static const struct snd_pcm_hardware rz_ssi_pcm_hardw=
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

