Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.23])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.476.1795708594163042665
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:56:34 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=nZ6ULR9Z;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.23, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+hEVzzuvJIadh6JMVTonYVJbqYPmH3WDf/RVOgieEHqdUtz37ZmK1Z6CUAfTEg+eYOpaZ0TJEVYa/ThAX8HqeL6XW7EF1DXFl/yfJxM/lc45+D5fMpIqoP9PiONkZajhJSZb8BdZ7+QOC9ugvwtoiRzmTsXPaGFHVPWIJNdYK2P5lg6NxeCzNejtXFU55OBKi7+vst7mCTr1vAbAyiNxPGaoDt1rO3VqH+W2maumU4k1e58qwNspYS3BwxNftJIBR5YT+mMhi6caUxc8rFIh/0Ua5Cnu4ENx8gaHwwXEFkKVDnug9v3rj7WkFqAHlirmFvwo6NNZ4PVcZF1I9qjew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rktW9hu68g+x0s/K027f1RmpnyDHYEbrH4ujxV900tc=;
 b=qJt6rDLZ2zs4GhjTUEH8Zf5aGpzIMXkhKGqLnFTRgaMUTAMVDMY8jZUXgQozT0pXfE5L2Eaqg01d9KfdVEqw6ocHHdHfKoHxFay0d9iCESkQ89BytJ+dqbfs2VaVmErNxBm842RedKMX9nIpTgUN2OZelcbDEJyTiO5qheNTooziVDQJrIQ1JTKqNckMbvHaJxiINBF3lmm+aKuZamQMGunqbp6thkkKPadMyKfoMnl4y2lgmmV3xvnXSKKaeZFpe1vuVcfLF8nPYSUaQlNoxqCX9yqOee1DuKl1ui8XMdqXuoS3W28qhI9gsFdl6MQcbtUjKojiHZvcWSfd+q6sHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rktW9hu68g+x0s/K027f1RmpnyDHYEbrH4ujxV900tc=;
 b=nZ6ULR9ZDYnfUABOvTL1B0IbLC0xL8DMbHiwv0dTUKUXeRqndJAXT8090ArLV/wOsiZ76jBma/iKOGkrbNP8PEGSoX1W/QWGfoICxEa8QKjyeBB1Evpzs/E7ZJc+sfAJdSuf8aPMIyr8tPDxewhe5ltuvetpYaQZjJwSGideLYw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OS9PR01MB16957.jpnprd01.prod.outlook.com
 (2603:1096:604:410::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:56:30 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:56:30 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 09/23] dmaengine: sh: rz-dmac: Use list_first_entry_or_null()
Date: Thu, 26 Nov 2026 16:55:31 +0100
Message-ID: <20261126155545.3834937-10-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To OSOPR01MB295138.jpnprd01.prod.outlook.com (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OS9PR01MB16957:EE_
X-MS-Office365-Filtering-Correlation-Id: 38753a6d-2d11-46e6-72aa-08df4bd5d642
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|366016|1800799024|23010399003|38350700014|261021121427099003|56012099006|10067099003|11063799006|261026130827099003|261028144727099003|261022105027099003|261022115727099003|261022113327099003|261026140227099003|261021133027099003|261026135527099003|261021130227099003|261021123027099003|261102123227099003|261026121527099003|261022075727099003|261021135927099003|261009223327099003|261009221227099003|261009220027099003|261009223027099003|261009221727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /QpFKKUMR8cmxY+lu5bbhqgfsg8bPgBmoD0arTi0llV41xAAeH9fHcrkGz2s5zQZ3dzdOIPOyLaZaN/FMd1Wvw22NJz3qCpb0KBa18BGtbrQoewavyHErlSO6sBYnI87501NLK+oGA5Rf7yDRZ+8RAMWFZHITDwW7jOuNqKMliBf3kZXvkkTd+JKa3UDqIo6U//k97ZBlaRXhhiQf2gbXsNNAQMwB9Al5ib3a+TU9/PeHcayxzLo6A0hwMdoLpKBx/v/D+v3KS/rZMBgd7DYtaMR/Oxap7sZCEcxe8cwK2dpME3+TNQoNbe7At0jPa1LEwoIx3LESS8a0tmyECdXjKB4s7lcBryUCLdlAJdWCmvN6WNlcm7pfktJOMhsoqy6oLvqpMMLs1NJ86vVTz1tL48BU86qoLYct0WkN1f+TJN5HXCc4ENm8mMgjyNd5D/7fM3KrF8Ytmagsu9o9U8LcMA6emERHwrHzGR3CPN0YyapLVMBMACxYGAN/TGJ2DAPzc7kcqYPG2riwYqgOWFRKcMKmuCR+XJq/4O4OZgJwhqhmVmWVsIWPH7fHgNgOWhULTWmhum6PJevsPAWsoFug+6AP1sbhylWESatJ3+OJRr7wzNlY+xVuAbS8QWZTqp7EyrSWcmjAa68elBgG3BnAbmqFfS2FQzRvmxoHSoDO4A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(23010399003)(38350700014)(261021121427099003)(56012099006)(10067099003)(11063799006)(261026130827099003)(261028144727099003)(261022105027099003)(261022115727099003)(261022113327099003)(261026140227099003)(261021133027099003)(261026135527099003)(261021130227099003)(261021123027099003)(261102123227099003)(261026121527099003)(261022075727099003)(261021135927099003)(261009223327099003)(261009221227099003)(261009220027099003)(261009223027099003)(261009221727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dCTYIUc+xstG2iYTvhYMi1j9fCuS+UtAUGUex2w1AC+fTRLE2bIKJGltYHt8?=
 =?us-ascii?Q?XzRfYoKOYvEpPlaOHZw7TmBgReQGj3fx6ECfBZrxVYwLH/Nx2qmYmzCKhS/e?=
 =?us-ascii?Q?qpxKf18NB2jNfMVBdtm6H81Gv9hD5stJM5d61A1pfnz/BifjA2ZQtu5ltM9P?=
 =?us-ascii?Q?qGkvvRMgNF5aOHgrw4R6yskL47CH3Fdb3qOjm8I2FKAoyFEc/r+eLQ3ktxEm?=
 =?us-ascii?Q?og7nQ/SGzXQyiu/J4dshYLtrR6mZ3m5vnw0XTa85Qs2Lhjp/mM3iWP+TFSlA?=
 =?us-ascii?Q?8sFmKL9W+t5aqN2Qu+mOLMmvSmn20pENmFHKbv99skPdgrJv+Jr9Q/LWsx+n?=
 =?us-ascii?Q?XApXX6H0u00gSoEPMWxtfT0VfdEbHVzMyZf2ELQeSVcfgMRV6+iPiPDvRpcy?=
 =?us-ascii?Q?lOoc5UnUcS3C2b4uQGKWdXqzLoJUM+2EdFJanF8+dSWGIGqZwsldo473lwM0?=
 =?us-ascii?Q?1qjBtmu7rHMOAAgrFe+lkpEBWElDVYiD7V+EvZ59tnzdXRS5tCJL4Q5OuYHJ?=
 =?us-ascii?Q?ZiBe0q5zjrrSmqWZ0+4nM6LF46DwB+VL+6rVIg88xdDCocqSiLwVebkN8sIN?=
 =?us-ascii?Q?77Umv4+haED8Jgf5oeluBVLls1FYygDCt8VlkkwWCBLS+0xSugJMSN/jDrML?=
 =?us-ascii?Q?lWotNtrg7P8apTx3sJ5np9G4iu8VuKvmfGyKfVrjkCvOxBv6QQF9SZacCV7I?=
 =?us-ascii?Q?8R7AVR3PlJTO3gBQ02xMEK8VsGvWsWkHJSc2l45owdde+AjUqm045PXHYEFk?=
 =?us-ascii?Q?ma3VLsWCKa+nSU4+sdD1jf/Ftoo1Hb1qjAE7VfDn90gVtou/jXoxVbHdunXU?=
 =?us-ascii?Q?8MRs1C9TvZcVB4SzhbmXKjY52peaO48jZUYAJIsBoe2wXtO+P2x35kYi48ng?=
 =?us-ascii?Q?ujiZqS8ygm32zZInE17XVgiafYDi6ZRCqUq9Dkv32B/qRjkwgbC+2POcgys2?=
 =?us-ascii?Q?OnHdulCsXonzrQGbpsmU2F0qLSQ2ndlPOO+I5ahuvX2BZ0cWFKUNIqxEAOZL?=
 =?us-ascii?Q?zosmbnIkOZ4x9tvxST4wX0XYPq5EkD2NjkIZjIk2/xlYZOCRgSUo/iqbHYEc?=
 =?us-ascii?Q?qxk8f/MgFP83ZfZG0L7tVwUENZnq+l68i+NRetMq/6qIXr7PEnqHiTfmIxei?=
 =?us-ascii?Q?x3spXpcmus5PVLM+aOXBTTmiYNHDuCGCjYccc6/yhrQ4Dmm5WLq2JYmW1+cq?=
 =?us-ascii?Q?NbCRIx42UPKuu0QjUVk8/6X5LcZf0ngf51Z41fXVeMd5TWds0siAnetIYP0w?=
 =?us-ascii?Q?CNjPcM+NmJxsVrMiu9C/bBDz/rD9EdHUbF09RGDnhEc71+EzO8zFhJmQHTmx?=
 =?us-ascii?Q?9c447GM05WZVonUtvY8R1zmWnbBrj1uhp9BKmLyN2Gh96UxJplY0VsS3OT0u?=
 =?us-ascii?Q?wlp9J8p9/YtXo2lGIoMCNf2HGinlmEcOUT5TZ11oM5Uwt24Jqw0oX77T0end?=
 =?us-ascii?Q?wVX8Q3ZOSeqoFBwEdC07d70jQ0NpXGCx+FsTYHJJfR4e3WwRvSSxXnaDWPTY?=
 =?us-ascii?Q?lmmrSHlzIGF91IFKV65RPKzEJmgKev7ftv1cPxt9tiOmss9gsxOqqzRCc4UA?=
 =?us-ascii?Q?r46Deba51Jak34I7GJIkfgD02zcOPbRtFV2w9Av+Yjgbn1mJJF3shU1ctRkH?=
 =?us-ascii?Q?Ym6X6EXu4DC2u4PnPN0Pq2Eb23XFtTJ5kB1enbPE6GrW5TghI1M2ezI11mG1?=
 =?us-ascii?Q?XkJmMV4aOQmBibcVjAqejH91LgGmhJMpR0Pi7ZKZwaS+v8DqKEEYUTFKL77/?=
 =?us-ascii?Q?RS5Rz4v43DclmMBHBRKQpi1F8iAcJjLG+zfe+G3y9mUOeziPYwiA?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38753a6d-2d11-46e6-72aa-08df4bd5d642
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:56:30.7380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGTMQzGi9qXZkcUkECsKLHVeyn5dsWePlxiPCQz0qdJlsKSaR5LSquByt/giAp2SHd5oqJyYUCpirMc/9ooqVP2p4bG74EJP2+KxMg2oB18TzpzV3x0QzvqYhf6QQ4KP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16957
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:56:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25200
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 89975baaa9ea2490b75d69842561a32ca888b7e5 upstream.

Use list_first_entry_or_null() instead of open-coding it with a
list_empty() check and list_first_entry(). This simplifies the code.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-4-claudiu.beznea@kern=
el.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index d01e3f89da4b..8bffec73f556 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -503,11 +503,10 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_ad=
dr_t dest, dma_addr_t src,
 		__func__, channel->index, &src, &dest, len);
=20
 	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
-		if (list_empty(&channel->ld_free))
+		desc =3D list_first_entry_or_null(&channel->ld_free, struct rz_dmac_desc=
, node);
+		if (!desc)
 			return NULL;
=20
-		desc =3D list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
-
 		desc->type =3D RZ_DMAC_DESC_MEMCPY;
 		desc->src =3D src;
 		desc->dest =3D dest;
@@ -533,11 +532,10 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct s=
catterlist *sgl,
 	int i =3D 0;
=20
 	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
-		if (list_empty(&channel->ld_free))
+		desc =3D list_first_entry_or_null(&channel->ld_free, struct rz_dmac_desc=
, node);
+		if (!desc)
 			return NULL;
=20
-		desc =3D list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
-
 		for_each_sg(sgl, sg, sg_len, i)
 			dma_length +=3D sg_dma_len(sg);
=20
--=20
2.54.0

