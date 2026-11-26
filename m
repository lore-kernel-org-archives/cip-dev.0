Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.68])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.583.1795708916234460591
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 08:01:56 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=tKt7xnea;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.68, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Unrk/Hl7mKLCg5/xuTGKiMMGTlD7z0SRQQjD6Uq5k24ZSdaZlg87BCZqZ6MonZpv8Ha/+JIv1UHxKbepqSdpNftiCvx5MBLGVypaYp9hxrOPVbzbNN4zWpAEacsk5AQ+GUWYRd9ZkOnLdue/LTTaj5L1c3GiDlg7QfneyT+kSV4zLQZJl1dUsIRA1KElw5teGLMZI52jnoHBIw4nyL4qeHUeZusKKN75P0wWj/5XLdc72mLtI/+ozGzhilUL/i65rnlZB8b6t0TXVIfeVh40yy+aHSughO9sB7OmmzBtZe4zID+TCW+EqpJ5H0FaYUhCA2cGr/uIBOjGtS6mEju0sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/GAUtQBnOMKG3YIoRgcV+f5gUG4H7tpY8FoGlPLNwk=;
 b=yqAtLJCH79Jo9slGAHgKVPwRLxcXGEYpYwQM5B+WHEd6NB2yBfcsYlTASY3//b1sc3ZQBJuHwEyt+cuLMZ4uUmmneun8A9FPF5hOHz2DT+zsDGkCjYbuTw5DLJlBGdXVyS3J086A331uDfEV5GxN/XYDMCVWPLrDHBElwOMipb915OAXuAWHQJQe3KyAaAZ+L9A4QXK4dxk5vnFngZj8QtcbZvRgCZMcO5EqCR2oLVToPQiaezVFnvgQveemaOE8KHWMiCVHXXGibrUSvol1BNpAvzUTCRuJyXgVqPQ3S/n3DYQSKmns/+1mGumI1d6Q/3MGkzJAIbY2FE1TBVzraQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/GAUtQBnOMKG3YIoRgcV+f5gUG4H7tpY8FoGlPLNwk=;
 b=tKt7xneagJdqKffURAh7kS8C741U/eXq1LMVlR8lxNk7Hy6kuhTy/nfVMkA+dCALRjGLQkuIF6NrLnGfZL6fVTo7kLWCvD0ubh5D4jDUcQIwnRLUImCLnDE4lsEmF1nYMlhvjfxxEnKgt+MZ+9toUbnpQc0x26XhGpMmQ8Xr2uw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY5PR01MB181845.jpnprd01.prod.outlook.com
 (2603:1096:403:50b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 16:01:50 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 16:01:50 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 1/8] ASoC: renesas: rz-ssi: Simplify the logic in rz_ssi_stream_is_play()
Date: Thu, 26 Nov 2026 17:01:12 +0100
Message-ID: <20261126160119.3836850-2-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 11813b70-1f9e-453b-2852-08df4bd694f2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|52116014|1800799024|261009223027099003|18002099003|22082099003|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261022105027099003|261021121427099003|38350700014|261021123027099003;
X-Microsoft-Antispam-Message-Info: SE/z4zzqOc0wC9K4fNO7OuBVDcbNi9ueph3afTft+k9i+qNRP0jU4n6AslhfjhUt9u6GKu8LD68d1WGX6RdpXLVIjk9BPlX9c7Jj3C/PCMofUXP1T5zys3U0lE0YqdHXdS5jiKjnGlb6Dul54GNaf5ayIl7cPccHjbMLBtAt0RCdEsUMVhJh6A0fI6MykI3zOpwE4Glpd0KTuBe7IsmkAnYmuP6qHGXKBLsgYASY/OZP2Q+vFcPikz+V6s4XZ9ndWHS5+FgZQSjDk7KbSy3LXGHKIPZj/YXdOToaZmZ4d62RJkOG0Xr2NIXMxNNJNGtqEPHQhYC59OQDnxuFN8Nc56S6xJ3HD9ZXBXl7DAv01E9hSi5z2HuygEv2k/WGEwyGIeH8brD/GSyiafYvdHoWzWGtgtHs7tUbfm8a+Uqdxr9O3bg2c3OXSNG8oTOz3u2PAdd/ZnRDkIPqe7EJLTbhV8HISeVqPouWHJ1S0iA4lyjBP9Zz3jNZ9x2qIyCWlKdd9Z9uy315f3xZkQXhTE79wjmWkLbwg+3yoUEUb83oI6Rp1AUWR/WYPJT4j0ljCMNg8zU3Q5805EcMj53zxXU60dEq/Y7s1dyVlxqqieATrimXNtysclNR9WQLiiL39nruQQVCve2aFkbeGzx4+lFAa/HaumUJGuUByQYvCgsHdeo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(52116014)(1800799024)(261009223027099003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(261021121427099003)(38350700014)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z840pSGgINx1ST+nWQnijnRKIYPpGrMhLE3YirZDUwKsfn2qsJl8MOnj99J9?=
 =?us-ascii?Q?fUhJQL+v4J7s1sQ/UXgPCWL4XPghWdsvvUev+1AVd3zj4fQFwIkrGqs0FrKG?=
 =?us-ascii?Q?KiFJ/Vpb8JGBs9eFicQR+KipSWRBYTjoYxmvTy8tvyQlqYRBs/+n7cXxIiT2?=
 =?us-ascii?Q?5S79C5OAfr0ScT33eDLfuWDi7n6Igf24nh6XngVe+yW1XDse+r+px/+YZ4F3?=
 =?us-ascii?Q?bTrmm79yLjfgb4J1Ug4CvVJZ0tvPh6AQD5SwPnWscc+9Fl3sJGKqIo7HPyBw?=
 =?us-ascii?Q?8akOdv04VPoOMsjOFSja986OTdZJ6sXDn38JxlJITrmqG+Hj8WlTyGG2lujL?=
 =?us-ascii?Q?vF9Uy9ggceWhepk50ItnOZ13Qggy00dxh/EOgGnsSURuBsnDCfRw6FEqde1P?=
 =?us-ascii?Q?dbE2BnCW7M8AK36VyIlbu+ag+4lqmZP/+OHiCy09EOTjUzBy7Lfj40O+zLE2?=
 =?us-ascii?Q?3k/SeYLbYnOMU6ssWwbocynYEncbBQrWbydggvr0P3hiiNk9jGGMg5G7uNAu?=
 =?us-ascii?Q?eF4PvW18CifTsNDWzWqPuNE/Xofp3mI0Uhi/hinATvvh4HuXWFVI+8Fm+P+w?=
 =?us-ascii?Q?Bi/G2UUaKxtBio2L2/AKQX4YsB+He5QgR5dE4lHTb5O77RJuk34klkHcYo5T?=
 =?us-ascii?Q?TDB4WR+UJkV/HqseG309Gw1GO5QI1YCtBMkGTr+BdVUN5Dxj82g/juYMudke?=
 =?us-ascii?Q?4BLR6lNKRymdKkPqcmhJ3KygwgQ8SLPwpEMF9VcbPQYLYw5X3ielvY8r6Eho?=
 =?us-ascii?Q?XaOGcCHf2t0AzCwZLpBlHX4glgsAJJghZYjMva8txI4buQjjG3J1Aqy6LE6M?=
 =?us-ascii?Q?FHXusjM/OkHXWAI+/uyvI0lfCca/R1bHAlfhy/KXYPoz+elgWm2m84hrcP3P?=
 =?us-ascii?Q?wQXTLQ/1y50U2OcaoOf9+ZzYkbPAd2GuYN4HLHhS/ffsWV3SZJcPGOABmICP?=
 =?us-ascii?Q?Va8nYuIfpDDPrTMgDDRKxUbC/xwyCoYSSMJTjBZmanoZF3HoE16FPnxfyz6k?=
 =?us-ascii?Q?H2K1UOXfhLTw16DDjBfaPcblFUBkVUbG1LGf3vuzD1gOxKEm5dwgD5/Y1Vrm?=
 =?us-ascii?Q?85Ub3hagbISRaMiHNdwLSyux9Sa0tKTA6CWl7C2UgoFL/SfOucNcsqFdrqol?=
 =?us-ascii?Q?VpJuOOVkatss2BA8luCUy2RXj7u6lIoR8SYrm1r1HuqEfTDujMEIAtPC0WYX?=
 =?us-ascii?Q?7Rxv2IAZYq91N3VE++zNmIw9xwOX//IdBB6vRV6c9wqKAeX0H8/YzgJORMf+?=
 =?us-ascii?Q?CrTpVmXtAYIedBqDmKfxYz6kt8+pppd0YdMdREZJlGVtNDIs302sBDQUpadZ?=
 =?us-ascii?Q?kmpE5Oqu6VIHXfuHFMBveWr1msxYDKtzIQGAFrM5O2J1fF1bI+fmkEcxcTvt?=
 =?us-ascii?Q?3hXdsOjUK7nh8seOINWWnRRmAOlLKDv7R8T4LwQG2VD1lL2n5q71u1LqUjcF?=
 =?us-ascii?Q?s5JDx23DzN3Pms+IF7/66SzVefzsJRwvOsFTMmW+z6RSKeaoDkHz/LUXGNnZ?=
 =?us-ascii?Q?ND+E3OunIkXxx9JEJcKzi1Ec9vO307ekFxxOZsQObAcpuXaPGhtTsmFuU+N5?=
 =?us-ascii?Q?cfddz1Z1j5lgmXowz09NgvFnZi4GIjdKetNMKkhAS3mrD7me3BvvOADzWEEa?=
 =?us-ascii?Q?e+1Tqpa5sGDcm8W1FUrExYrr10+Y4lLgPYdNK1yfvx+FsL6iccPAA0uip/5z?=
 =?us-ascii?Q?hs7cOkHOK6RwHwsrDx3RAX5bLT7udhNSKylcQCT9O5Aj7VTdktqf/OH6luur?=
 =?us-ascii?Q?6lQxmVjVrYTlYoo1OrF/qopcy0m4CnkenQS+RNQ4GM5yS8pJ6wVp?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11813b70-1f9e-453b-2852-08df4bd694f2
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 16:01:50.4433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DktA1GmbxEMue4obbAVgJYMRDz8/OHCRHXEouIjJ70CDxSzstlNkOq86JI8MElKuonEtHcnLEr6srqNu6oX5VaDq7Cz1UwdZtf2dOKiDhtGFskQyIEVqhIqmRSoFIOP7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB181845
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 16:02:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25216
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
index 808dd6dcbe12..30bcc98bcf2e 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -180,12 +180,7 @@ static inline bool rz_ssi_stream_is_play(struct snd_pc=
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

