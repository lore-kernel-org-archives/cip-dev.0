Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.26])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.434.1795708446843928626
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:54:07 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=sJ7cTTZt;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.26, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMtv/sP0+x39cOuyKnBU9Tq3NQRhjiaf8zeeTV/c8+zbnmAIG1PiAeCzW6CT3BXqWyWOHrQCzGbPQ5idmPxCQpU58lJ3gOTR3rnVoVPAXwuUQgOU/rChnrA2WzRcbeV95Jka2knw4IJmdIcmhSJoKF7rN0AbFaapGPWlWS8XaCBAOlKV9VTXMh+//2g2jj8Wqh3DPxn7OCBKQLwvIgN8GFakgxhgfFErEgxfNDXHIetBLJuxzZx2kXn1FTFuGWuk9mAuFk7L11Oeo2glYXhVvV+jgxvNVzbAAXjQovdIrAL7eLNXSoUUqFYtdelu0qVKn7ucJS6r8/kKVunLtrNXag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FhmTCQ6toN/o8XEH21Xa7/9r7IO7N9j3S0Z6ls1n0k=;
 b=KjJxMcZ9zT1BPtqNAHCBYWBb4zrY7uZPm8GOTf31A7i73MeP2KUpdf3yziWKR2xXoeiyZBaMvC43GRjek/8cKFjxQyo2jSx8h4q6s3QLIdDA5rwIvgg5iynUWX4SKZczMrK88ApqHVbi1pyPPgajm1aXRSS9xC8UPnu+e3bUP+n82WIYx8U+SkYCHirtsWxYJEZF1CKPJEv8LbKBRloCY3ZEy4Ui4tAGtptBr0JYKIZo50+DDBlRMfKCNZXLKxIM5SShXqn5Cix5flCL1AjxbziLsCwsjxzIZ2vzxv/NMX6oZJ69LZ4eKlgrp0/hvyiQ+lFFuolsidNWyYlg7u8ttQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FhmTCQ6toN/o8XEH21Xa7/9r7IO7N9j3S0Z6ls1n0k=;
 b=sJ7cTTZthztcOKTy09f7cPbQt7SwcspRJaqB73D/KDdk0XCqsKHRzVKIfiWGF/El1U281gMtuRDpZqqRnOIIS1FRLJt/449DQBu8oUEYTI8fjsHSjkux5j/073JdJBNlM30c4dfULWwSG+zV2qjJLUrrjrP74XjoV9a4/0kjO+g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB13015.jpnprd01.prod.outlook.com
 (2603:1096:405:1dd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:54:03 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:54:03 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 05/12] ASoC: renesas: rz-ssi: Simplify the logic in rz_ssi_stream_is_play()
Date: Thu, 26 Nov 2026 16:53:14 +0100
Message-ID: <20261126155321.3834347-6-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY4PR01MB13015:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6b84e1-d64e-4e7a-2bfb-08df4bd57e57
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|52116014|23010399003|1800799024|38350700014|10067099003|11063799006|56012099006|261022105027099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|261026140227099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: orHGTcOtgvulMH2f53UV12nshD99AryDAYQBVtwC5DM1/4q0VJMT2qoiXL59rM/+cOpYky3g3kifad/MTcetafyG/PJtdIkQ3V5iagHSO5FC0cBMV9kSCN9In0GUs0YEEfHey4ZIjvikdAtnZNLTYqJ2bDP0eKGYesBdFgK33Ux0i2+KOKirX4alJTc4uHsoytGE8aWfL+2dXAvtNFX9MlLcuC7766YKskqykFajCGdFdBJ/AKOefDqWiI9vhSjp+3oLml0kK65HlU9nyEhPMOHK/CBFMBbK6szYDJJ6x1yrDXrFtw6fgt+8tt95ieJ/Sah13Z34xjU31FdPsCafWd+O9yE4CtxRPVsj8hGRVeD3Z76rMLS9E7kipW2lcgP67/spqrLHP1oHyl0arGM6WPCDAyHuWr7aZn3zVmPwYQAaQdGR+GcB8Tlany0RTTbfr6kPzMaGHBFx9blVuXvwaK4nXJWjelzsNGEEjPkwgR8IZAOZC1wFyM06x01ufzhh4Szurl2Olbg/Z0+3riTMeNMAup70tM2Aph9bjrY4bjANRSPRPbAuAVTCCCv3KLWBSbuaWSHB22embvTitKpqRkkjrugUz0zISs6a8XpFmw+idRP4vndif5zMJS2eoG7pVsw69uwYDlkqs2Eo66lwU3/lyaZJKeijFrVDE9/WEPQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(23010399003)(1800799024)(38350700014)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4iXRg7is906GfZTjvcym3yTTgD5HNuky4GYVkzkw+94220LK1YQlvoBJQz8u?=
 =?us-ascii?Q?GSEq2/QHE0RiuPE4IhKybTEbyICj06wtFqs9Fe+YnUrIGEKz8bDfIhAmfO5K?=
 =?us-ascii?Q?GWEC4/bMbNdza/QectD283ONg0xk7D2Vl8eHhfud0Ma24VfSHw7dX0MYP1wC?=
 =?us-ascii?Q?FHWkAAbm4W7CMsXFk7H2hxovcAzkXqT+cXRqJdvVCsy7nwG9OMF9sa9EGVL4?=
 =?us-ascii?Q?h4qbXutfbagkc6w4/gkHtBGY5lxhtRH1hvARUV/evkGhCErcczmnOSSTODl+?=
 =?us-ascii?Q?bk3wOB1VCsnTS5FzAhb119cWahzRxLz7pl9pcD6YcwTdzc7K+bEkmd2Nfgzm?=
 =?us-ascii?Q?lkvpvA8zZ7CvK6lqO3n97OuvA+zAUKBBq2Adwjo9I+yHlESHaEC/tKenBtmR?=
 =?us-ascii?Q?h1SufRvjUf3Gwzu32lFlvmJkR/H6h6W5FRZ8S/sxdVeiXn+rH0wDvFfFQdsY?=
 =?us-ascii?Q?mcshHrvTwsLGw6v8KL6E+SH7i9uIKofd9pbCYK11dXgs8p2VnOMKV8GZUYRr?=
 =?us-ascii?Q?qpkZBbNgfaLkuc9yqu9NXWfUE/ojRvoQDKeqtx9aCeBXTbmOuwoQ6Vf41/zE?=
 =?us-ascii?Q?1EG1VIQ8MbbQQBgQB8Pq8c8uUO/F6x6Iumix0qSpK9vuFVEoVajCfNSsYrHw?=
 =?us-ascii?Q?Pbuy0/v6fkYcnhHbmyII+btDM66teJNe+dUgZ7GRlViaiw7urgJkXyBhI8Ld?=
 =?us-ascii?Q?Z7XBoRbka3d1ZqEGNIPAKEfHWv2M1LqkRbVEK4Gb7PBZaSH+PTlUAExoyqkb?=
 =?us-ascii?Q?+O2MkNV7SFyRqQd5xPelijKFkoDUJD+ojo5ve2LqhlcrHYw/R18YbuL2BJoQ?=
 =?us-ascii?Q?KqF/3zd6gzJH7O2eO5kwTF4+bnMR4vtz0ZvkeAeV1KMLfNElBXjJ9uG9CLoD?=
 =?us-ascii?Q?rIrWBZgnu/u2w+8zQHQgzdssNo1kqVEtru/if8J4E3NXy5K6ZA9lmLuPCpoF?=
 =?us-ascii?Q?6S74bf6hLYTrvNZTmFWbie0TWOrn1FJ7uvLRZ+RDpkKU48WlwTDY9+dnnZay?=
 =?us-ascii?Q?9Hp4c5vFPjMRubq/IY9pu4V+Zk+azXattM0bUAdgzA5RKk4zFre8V0obu0T/?=
 =?us-ascii?Q?lnO2bRSg3PO+54E7FJDGjx2IaU6/UMhrDCFIyBOIg8G7sREA+eTlHQIAVWAl?=
 =?us-ascii?Q?0UNAWbmAf1gZeLxAXEk3+sVKMzpy23dX5sClyxYqsSKyzYQMh1er6fs2uY8L?=
 =?us-ascii?Q?W3narVBp6cucxgSxyEL3onnPY69aFGqA7HabHPj5f3gyexJ9eD7HTFLhP+H9?=
 =?us-ascii?Q?t1+EZpZOYZ+ddjM2IRpuEuQFb6oDUeNEJg0TTokNaffibF1lmK0b7KhZlo6X?=
 =?us-ascii?Q?hXH7l4EiPP+OB/Y/nTnF+j2z/XRpYzsJKjlC7fZCgOea2RxYV29zf11ncLkQ?=
 =?us-ascii?Q?6KozlwqVdd6KuyXZLmZ5iTqP36Hja0rOPCL04xxLqhvEE/JWGtCxO1JaUmAI?=
 =?us-ascii?Q?V9NH0D4GJxlIZV2/z2slEKTn5HJGt1D1zXvHBIGpWvMAPvAi3h+Uxc/bEHNH?=
 =?us-ascii?Q?Odx/eXsi/QPyid3rJ80Ln7ukynLoP6IhUfhgr/uGy2JQTUNDwbPBXYhYqRh+?=
 =?us-ascii?Q?0HajSWA4vphVZEvNDNFotgGY0cdm53W7TdwvOBG2uhaDanH+f7OPpd99Be8z?=
 =?us-ascii?Q?6qVgMvd+xbI8O9z+KNMJqulXLms79ILbhVCl70SZND0j94YHdJ0y4UlM94YH?=
 =?us-ascii?Q?Mw8H0/1ibrcodprhA2boxtOfF64jhzUR7gNE+SkEVYp5suNDtAKgf+obsBvf?=
 =?us-ascii?Q?gCwMYjEYXJyWodfBqPCZbMfmfVXxiweKQ5Nk/fmW8u0F/5L8DTLS?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6b84e1-d64e-4e7a-2bfb-08df4bd57e57
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:54:03.0414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDI2sil7WLJVR8XQSTzAyYcHGncuTGdAC+5zRIJ0sXgFIVLxFqNybdO4dR8OwekOS1FtXNPLQ2NxgLB2GYHWsHFAr9CdEXjFg/tlLco4Dfor0E3eO9acJBs//wv9wz1a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13015
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:54:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25183
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 53dfb2ad6fcff111f58aa506afbbf6fd82f32cb1 upstream.

The code in rz_ssi_stream_is_play() checks whether substream->stream is
different from SNDRV_PCM_STREAM_PLAYBACK and returns the capture
struct rz_ssi_stream in that case. The logic is easier to follow if
substream->stream is compared directly against SNDRV_PCM_STREAM_CAPTURE
and return the capture struct rz_ssi_stream.

Use the conditional operator to simplify the code.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260119195252.3362486-2-claudiu.beznea.uj@b=
p.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 401fce5b1918..73b6c75adb8a 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -181,12 +181,7 @@ static inline bool rz_ssi_stream_is_play(struct snd_pc=
m_substream *substream)
 static inline struct rz_ssi_stream *
 rz_ssi_stream_get(struct rz_ssi_priv *ssi, struct snd_pcm_substream *subst=
ream)
 {
-	struct rz_ssi_stream *stream =3D &ssi->playback;
-
-	if (substream->stream !=3D SNDRV_PCM_STREAM_PLAYBACK)
-		stream =3D &ssi->capture;
-
-	return stream;
+	return (ssi->playback.substream =3D=3D substream) ? &ssi->playback : &ssi=
->capture;
 }
=20
 static inline bool rz_ssi_is_dma_enabled(struct rz_ssi_priv *ssi)
--=20
2.54.0

