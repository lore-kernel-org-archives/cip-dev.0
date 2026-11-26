Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.8])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.529.1795708619244898861
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:56:59 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Kcnpwhzd;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.8, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XW4PnXjFYPu6HF3fL7b41L8Fkj8NRIqXcHW+hdj23ys4S+5QnE7vNDSy7QlvA4CcAmY6FHgW6PVlB+RD58KIkpOD+CfJjBZHFWilnf6J3KnDvU/YaYwOhISKbCR/iKt0jRXCR+obGOyCYh4z+2COVCT86j92DhdExiIwF+fAejz5SEyKBqM95m9SgSGqtbrD09hW0bSLjjEyq0yohUp6vR3BjJIlVoLjJRO+kfmJdkVemjF8YDRFx9aEyecdk/p696bJXj4r9JTwQzOlHqJ1YLmC1JwfX36+a8FG0pDh6P1N67aBJ2ACssgt282zI1rkg3Uo+SDFXRuAJ/0sHmmDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPXHaO4NUhXG1tEIe5x3vg3O40Mcnj1Caq9vdY28UUw=;
 b=O2dwHLTPzeD+5D5Kiyw1rM8Rug0+aEoid14M0HfHwcFR8BJbpJ/bB15yzDhpHrHOja2HRScCDOxDrQ+u2JPPMAHi8pmIFNqMWeQZEudAZn6SC1mIB26scOILzCL1iEOTJAzA/qHblIGwpLwwdwq9MwckcyHNSrGbt68lpCuHNSxNfzOFA87f0dRAVZx9KC9u/WrEPxldiNPDGJxnZyZhVAUkzOeAeC6dk+SUsaFU7vgyosVWSmdnq2A7vLZGWJQ/TXW8jCsCiemSrykRVR3U1EPOUatrXQqPaO3S030UAuKWLoAvzT+kVI/cu/PUZifMk89Ngh1O0kdtURRPpPozvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPXHaO4NUhXG1tEIe5x3vg3O40Mcnj1Caq9vdY28UUw=;
 b=KcnpwhzdsPi7CpYN7mEFTy/XYKN/omljsh04t79M0iVg3/2GrJp1XRii8lxMR3vQ4jz/gFuS0WckT3V5zz9JahwtstpgzYiiFGdEQkvZ0MiojOtgiNoVYqUvdXPjp12hNX5GSIWQGupKFMo36IOzhJDpKsaKa2fhRTA0BXk0Rho=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY5PR01MB181845.jpnprd01.prod.outlook.com
 (2603:1096:403:50b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:56:57 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:56:57 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 19/23] dmaengine: sh: rz-dmac: Adjust rz_dmac_chan_get_residue() to return error codes
Date: Thu, 26 Nov 2026 16:55:41 +0100
Message-ID: <20261126155545.3834937-20-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To OSOPR01MB295138.jpnprd01.prod.outlook.com (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY5PR01MB181845:EE_
X-MS-Office365-Filtering-Correlation-Id: 46646d58-552e-4be1-9035-08df4bd5e604
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|52116014|1800799024|261009223027099003|18002099003|22082099003|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261022105027099003|261022075727099003|261021121427099003|38350700014|261021123027099003;
X-Microsoft-Antispam-Message-Info: SyZNPUYdIbgHllkseneZJO1KYodRam5rEfWWRcmddsw57Z7OhfbPppx9PWt8nGCpIIFsqEYh0po7zcKLsQj0F2+1pOG5ancvh4VbsFEdBsJXbgUac/Og5ojyZFdB1+DNMzFfIIczJwyKr0nbGTY5RfAkOKZXJf4J9cG1oqM0eNPg3PhYoJNZ/4VJzUXhK3tWKtHRkmPzSEvrQxkUlUUXjRedfo/uOAIswX/lPh0pAHeX41ZROzWffPsuMc5hCspETaBepyagmdFVsd+GFtuaHrvQovg/dTiONJB5uB/KeEyBUh3ze5E0dduYFG7tZ+7j8nl8zUjjxl3obV0Mh0N9iZHtbAJc2f6VwcC6xO38dqbfzjrTpzDz2TCfTYFqw5kJL/syoWkVVtp8Tzu4KFLvOMTqsTxuGpg6WmFXgFzeOlG/WD+8ohUGGmVScuZMq+ct4RYzon4Yx8mM4XXhA459wGh1Ei2qHjBUFe/xTaLyaASHI1tEtQY7JiXhhpWhCoOnit+Mq7dLC5k1wFswcJHcRfd3sodrMR3qbYxti8WQdCQeNE/+74jjU1zzqmNGkM9ujlOyEyRnY4mRxNfTrTeiL3S+ppX0vRqTie3XSi6Y3G0bFGRkmcvZ9GHPaTWlVNWbAp+J1MtmGrWypHKQP79omloRHR7S0J5uWOSDndNxn30=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(52116014)(1800799024)(261009223027099003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(261022075727099003)(261021121427099003)(38350700014)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bxWzJ4R5q+CIypJEBC+OxOdSGoN3QDUenAshRK1UG7AOARVfbwSdSpOGPvyN?=
 =?us-ascii?Q?RfZXxLA7Q7P/sOiBSL/1A6XAMkvzSzs0sYxFFwnDvPDdWoGV4mnFScnpqVZ0?=
 =?us-ascii?Q?8D7oAJJarrqAgq6zbXRJHYTX/s+agGs95Cd2ZRdDMEgDM6YdIVgcrSY33yae?=
 =?us-ascii?Q?3dJtvQGvbzjNUg600+Sz8TiNvwgAG0LZ2AvFmlp8eUXa+60VSnQzvhsIvVRL?=
 =?us-ascii?Q?BuL3Xc+p36ax6Q4KzuBAAwKtrmdMtMhvrsyxapSCpCFFKbbfMLmhEF3CXJI9?=
 =?us-ascii?Q?Lcnor33UFP776yaKWq6HHUDM1cmGL9BcJy5z6cpklL1FluSsdsn0x8nzBFLt?=
 =?us-ascii?Q?Hwe1wZbiXNZAZtL7JRPVQLmqCx0hWV4hsbSv52gfPL+llhdCbULw3ismzTSa?=
 =?us-ascii?Q?Aw9Hf6zPJHxYL1NpGhItu7VcGgJTHhn1IHGB/vasVZI1RqLOUHGIXQJeKYrd?=
 =?us-ascii?Q?A5eIssNNYHXG+ALNZsbLZIs92GW9IqqY9VuE2dmySxNcYUo6EdJSIYFGSNGZ?=
 =?us-ascii?Q?w75M8qpSnXnZOUJGPQXtSiIfH5SbUkw2pnJ37NbmWa4+IktBks9Dia7rs9MX?=
 =?us-ascii?Q?BbmOEL2Qsy1+EDy7gKHIr7ahHW23gI9/tUDp6pqdXx9Fs07zVQgwH4uIckcI?=
 =?us-ascii?Q?wvoxC0jwit1CSst5RvEoIyKWv8v63phzuRyPMeGX3AjTvsr4F4KOnV1eWgus?=
 =?us-ascii?Q?X8NKBgay/JxPjDC7vp4syJF3+fijcg6DOeqj3yiQ/7lcFHxStHn2+HB0CQOw?=
 =?us-ascii?Q?Oq4ctPBzfPxC+MgktbcUI74ZVA/U/jqXGELYoUJf48rYU5I6I1i+vdGYwKl+?=
 =?us-ascii?Q?DD+ThHw2QiYWLup3/l45ngexsPUpwkM8Afpl1/VBN+5cIUZNfpRY5b1t3aE8?=
 =?us-ascii?Q?VRT0b3K+jHXuJpLaGtNHWuZ9m5QdPEUc/2m/xR3eMwQ37eFdXqjOUQaEKugp?=
 =?us-ascii?Q?pCkYXxNtdvXjnaCL1zL2tfi8BawgDNjr0Cmo8FpRUt7cFx2NIIjjN8ctq9hE?=
 =?us-ascii?Q?0/tZn6nH17kZvlvSgnETW9lPjAu18My6FmRDyk2+V7ayQ8CiYCCUwRoapfvT?=
 =?us-ascii?Q?G9a9ocvN5GKvRjdMgD/IYcuwyQQGT35vNcyY7bJYJue7Q/qiuP/yEEQVANZa?=
 =?us-ascii?Q?ckGJ9NDM2ZqNhUF92JSkPkFrwrb47ijdo6ctdLLQAeOJq3OPRatHAXGpTRY0?=
 =?us-ascii?Q?vBIU5TQMyo2YFBV7Z76SZ6njPqciH4PPcoMmuS4h/fN5Ni4cGGKT0Z3wgl9F?=
 =?us-ascii?Q?RfJA1olB4JqsMd2id4KoIG/qg3peCyW/O+nBjzmb0hvyJLsPUSTLjl2+N3Wp?=
 =?us-ascii?Q?VjMp7Iu5IZslyCamDsWsS6IQa7CyFjiCrhjKEG4ELvYydYrLoJE9Zcq0aBIj?=
 =?us-ascii?Q?pavI/I3wOMWgQHcPl7nRvwvF1JqCdmvKVx/KLrCBBOqoo6zs6CAijHECAX7K?=
 =?us-ascii?Q?CeyBBX3RijSUytnMRo60TPe4UUr/iFsUzbviPPoREQgi/0jhbBuDjjswVPBM?=
 =?us-ascii?Q?j+XEyZvZfIMzTgYxjm4C8E3zni8LJiAk6cEmJcd9Imknc3RYPRRdohdH6hvE?=
 =?us-ascii?Q?xuSJ8bLoVRbFXrsNvA//CMHAws6PcLp1lq6ePbZeCSJROSY1J3vdHMuMeVjM?=
 =?us-ascii?Q?tQgn6G231QNxsFknNjm1l/FcLXIbIdW2hWiROiPmhY4NbVHYU9SeCVrntfyf?=
 =?us-ascii?Q?17nDH46D3a6LXSp7VXXigyUBIICztzx5f3gun0TdH+gJDksVGSsmeDq86ERW?=
 =?us-ascii?Q?LS9hNk9K8shbIYIfPO9FCfplIDoxstGojzo6+YmvPj49UdphGwsX?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46646d58-552e-4be1-9035-08df4bd5e604
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:56:57.1656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWXdbToY3UH/49u94NEroiJzxdymTQs2lxzCrwwvr9IonT4qEhHe+rDiGS9pJrKCzH6ctq+vY+WX/tysBWx9btZJr5acH0fQkjh8hkeWVDXxYnv82ik0OCo/02Hmbcfx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB181845
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:57:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25210
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 16ba40151b1e6a52b28296a2173457bc6c31f022 upstream.

Adjust rz_dmac_chan_get_residue() to return error codes on failure and
provide the residue to callers through the residue parameter. This
prepares the code for the addition of runtime PM support.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-14-claudiu.beznea@ker=
nel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index cbb6c74c02e5..3d3ba95a14a4 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -860,8 +860,8 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(struct=
 rz_dmac_chan *channel,
 	return residue;
 }
=20
-static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
-				    dma_cookie_t cookie)
+static int rz_dmac_chan_get_residue(struct device *dev, struct rz_dmac_cha=
n *channel,
+				    dma_cookie_t cookie, u32 *residue)
 {
 	struct rz_dmac_desc *desc =3D NULL;
 	struct virt_dma_desc *vd;
@@ -871,7 +871,8 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan=
 *channel,
 	if (vd) {
 		/* Descriptor has been issued but not yet processed. */
 		desc =3D to_rz_dmac_desc(vd);
-		return desc->len;
+		*residue =3D desc->len;
+		return 0;
 	} else if (channel->desc && channel->desc->vd.tx.cookie =3D=3D cookie) {
 		/* Descriptor is currently processed. */
 		desc =3D channel->desc;
@@ -879,6 +880,7 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan=
 *channel,
=20
 	if (!desc) {
 		/* Descriptor was not found. May be already completed by now. */
+		*residue =3D 0;
 		return 0;
 	}
=20
@@ -901,7 +903,9 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan=
 *channel,
 	 * Calculate number of bytes transferred in processing virtual descriptor=
.
 	 * One virtual descriptor can have many lmdesc.
 	 */
-	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, desc, crla);
+	*residue =3D crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, desc, =
crla);
+
+	return 0;
 }
=20
 static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
@@ -909,15 +913,20 @@ static enum dma_status rz_dmac_tx_status(struct dma_c=
han *chan,
 					 struct dma_tx_state *txstate)
 {
 	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
+	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
 	enum dma_status status;
 	u32 residue;
=20
 	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
+		int ret;
+
 		status =3D dma_cookie_status(chan, cookie, txstate);
 		if (status =3D=3D DMA_COMPLETE || !txstate)
 			return status;
=20
-		residue =3D rz_dmac_chan_get_residue(channel, cookie);
+		ret =3D rz_dmac_chan_get_residue(dmac->dev, channel, cookie, &residue);
+		if (ret)
+			return DMA_ERROR;
=20
 		if (status =3D=3D DMA_IN_PROGRESS && rz_dmac_chan_is_paused(channel))
 			status =3D DMA_PAUSED;
--=20
2.54.0

