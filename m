Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.14])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.290.1795708130515110919
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:48:50 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=m8EZya0b;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.14, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLpOchZ6qIKBd3ql7aq43rZH7j2n8EGu7ngXkbZ/Sz8DeaEWqzlTmqGg2x/myeKVV6/zgH2Zxsm9TQuZ2QzI/Ue1HT3Nl0BNhf/r3lNGYeWkAcxXtMiBTQJ3abifHuSbSMUA5Bjhr2m9C08QrHeZPUB5Rcw6cxebvvn3XeGenwvQ7Ev1w7qgJTgSNvWRZcpcol55BVDyf/fFyEPeIQlNho/flB12APol2U5DjzCdbay/ZOf3e0rlaIqGRaqdEUQJoT0i8j3ozns1nLQUS6SJ3Us/g68xXXJhSlufyDV0AsQEQkZdwL2EvXVd7xK6GUW1cYXMjdX6MQFEBbuJ5U7R4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYJ29K5kb6XdmM5fbm/RgwoFQHB0EpVxjqgaLLApEXU=;
 b=hENRgJCpt1ImyA4qknQptDK10BRRa1pj9UAOdV6IAoJ7OP/N5KBv/qEPxFdjRYTSSnsRU9w1dNy0dDfvfP/zXedT8cRYUbqqvMpo1A0nJuLwr5s3Y0vYsikkvDpXFJ7WEA7ikq+Ah2hZPIcQbl3Cgqft7HKSlMe4E0/OLP4ux6zxbyErjGztA0e0M5PxcaBTblwO5yGh+CG+Pon2zKQU+3TDWzTK3gpiCs3cjGQ7txcfclKmjoz1OQGiRIBCf5pXPIjvF3eD/p4HMzdqiLvUh/F3QDEo2BhqyLLIJSY0Fj6xsGb0w+nd2TdG5sLQO2OTqpHlW6XaVWCAuTdOq4LVcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYJ29K5kb6XdmM5fbm/RgwoFQHB0EpVxjqgaLLApEXU=;
 b=m8EZya0bWWpTYRij0ps705JDZbcxrR1Ptjx2rZeagBiZOZV+4fmKBvFAgsqp1rUkUF9HGHRvQ0G+osaB+dyFusJ+3yhJCp+n9rZ1n54QbOroSs2Izrtk43UFhXF9udISjyL0qzrO1+4t685vWB6kCdAKvOe+yrcNBWQ0gaWg3Vs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OSCPR01MB12784.jpnprd01.prod.outlook.com
 (2603:1096:604:33b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:48:47 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:48:47 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 13/27] dmaengine: sh: rz-dmac: Use list_first_entry_or_null()
Date: Thu, 26 Nov 2026 16:47:33 +0100
Message-ID: <20261126154747.3832917-14-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126154747.3832917-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126154747.3832917-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::17) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OSCPR01MB12784:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ce8dc4d-d7d0-41bc-a275-08df4bd4c22e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|23010399003|366016|376014|1800799024|38350700014|261102123227099003|10067099003|11063799006|56012099006|261026121527099003|261026130827099003|261026140227099003|261026135527099003|261028144727099003|261022113327099003|261021130227099003|261021121427099003|261021133027099003|261021123027099003|261021135927099003|261022105027099003|261022075727099003|261022115727099003|261009223327099003|261009221227099003|261009221727099003|261009220027099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: E5eKixIh+nd/yzMu8/Q60sx7bCb/UzBsPGcIvsZIAi7VJiBdqI2zWUqW9k0xbg/i/HtyaLCHEPE3YRZwJU7crSsFvfINHc2JYGqCZWt9v6SVEEHUlpVcl1Kc7J35xjkTqK4scIzdw+IiQoSOAXwiw0FNqJrxzQvbSKTy2LQJMySZTcFzYtszmcUx62tbo/eiwVcq3rw9K1VToSnQ+9W9IyNkh4sOxYUP4hdEOZbzf/YYCSLJ2nX0j4txuC0XHrlnx0alRbVhMDiBylqhXy2Xe++cqdXta4xhWLMVoPkLTcil/I2pj9snzZ+MVCEHPvFRVG32j3iu2MOtNh3UfgdC6qi5knu+z+MKfd/Eu5s7akFtUKmSX3B1im43Xxp/+RW7RrgAu6GA0xmZzBRS/YHOWlortfiTyT+GgrdZLwM4vkZOsNQ/HtAnKJXCUOlagrulErU8Ry7ItPXL74O22JQv6Dk5swMEdEDM4qIqQN9A0ebzqmtigr3AQbqmi1uHql8ZmKkz6EIrWouqm8JvLU4FrPMZ1m/wKywZUGmejJC1OyHBxNFS1sm/qo5m3MS7uUjzVYl3qsxM8N+CBUjT87TO2F2iRD3PnrQpcEcmdiLhP0ENCe+anY/TjapzTDTBZmFRCGrYHWG7jSU9iIrG0HqEi403pgCZUBn/EfPNgcE34qQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(366016)(376014)(1800799024)(38350700014)(261102123227099003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026130827099003)(261026140227099003)(261026135527099003)(261028144727099003)(261022113327099003)(261021130227099003)(261021121427099003)(261021133027099003)(261021123027099003)(261021135927099003)(261022105027099003)(261022075727099003)(261022115727099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009220027099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+YD8A66wCrXdLV5S6vNiQzf1vEb/RJbGZGm74RhIrAUdFR6ppa0yrdbM/wB6?=
 =?us-ascii?Q?CXxSWe+JVkimGQc5HDr/nojguEv6/5RdgQFOupzHBu5sR9RZiT0cOeDyhqxh?=
 =?us-ascii?Q?caY2B4m7/NoH2W+SbLmsNpOxnfA03BmOfDnIYVhpI5LYYEs1SeD1W5xqxvXU?=
 =?us-ascii?Q?p2nzVYQcs5XANXTKD/ShKhCIr3RaJy3gaOIWuhuo1B3whMrDnTciVJdsxVTZ?=
 =?us-ascii?Q?5PABua7EBUl4XpJs/G9O3k0c16e2ylVFi7bxSs5xJFAnS3S7KWPKJAVnRLfh?=
 =?us-ascii?Q?fTyqYk39sbnHatxMgh8YRUvC86zv1jQAP8LKT6pSvDW0l5Cs6PJu9d39PFyn?=
 =?us-ascii?Q?Hsb9b9vo/cSNHY7w11W7r8lRd6AClV2KHNyuQLrRQAXGeHNq43OdsXAp8Dog?=
 =?us-ascii?Q?nR5uGDIn51Rpu4Dp5FiWdykppN8XOExRZSA/Ly4kjC0nqwPVQrVsxQTJZuGe?=
 =?us-ascii?Q?lJ7wlhrOEDuFnmszLtVwUGMD38qh3aZpJErpa8UhNlXXPRvJV5hP6zVhvqYn?=
 =?us-ascii?Q?mNj0VBQSAyAL6LjpnNCL/NwJUeYQIDcA2RRO+yvMIAlP2lJqPlZds9MXutmR?=
 =?us-ascii?Q?R4gGMyHpyByQXj8jt6h86x42b6vWrYHkXvgOH7DTYD9Zld7TLYCufGVTtM58?=
 =?us-ascii?Q?Nmr+3d1MWUt3IIVSnnEuxuTKWoFAVtxUsP+NrPeT/e7ve9Y7BrLSTHMTKVJ5?=
 =?us-ascii?Q?OIDDUiQonEnxCEopOfxjDoIHiy6RD30o+5QsHz9Zf+Di/C9qR+l4myxM+lHW?=
 =?us-ascii?Q?wvDXrcy8MdTyJsPEcYDa6XSUlSrSiIDoQBCcYFkl1BNR4FnJiFW1B5xacJUI?=
 =?us-ascii?Q?Y7PYc8s3I+ptUqOjeZty9ag+s5ZPUAEsrLC4jmTEeSxYV8Re4ZA5EwGrvMvj?=
 =?us-ascii?Q?GIUW+Mds+bk6wkBLaWdmACZ77CV6XWVvKyH6zGlaHotI+G3/SpzAqwh2t/X1?=
 =?us-ascii?Q?4AOLCU7+GjZ8eyd4G83zGEWRoKo80JfnoTjjFaQ1gp2iqNxnF1JM4uoSeQKb?=
 =?us-ascii?Q?C2bvBxCieAe29QMV//P+eRPSz5sQX9KovxbMJmvcumnchhXvsYWQbpZlqUJ0?=
 =?us-ascii?Q?p6vPOzOTGp+g4hhhPUboz4hKk1tMe+8wJ3ITKTq5VxWciDZIGrZpMSpx3A9/?=
 =?us-ascii?Q?CR8zE25hdx19tHkt1vZuF4NPutJdKMo65xA7FhOvUNV+uQ3fcFZzqk3x+krv?=
 =?us-ascii?Q?N+JxK9bRJi8e6lobk68VvcKUQlqno4k4oy576ZfmLdjaO0oEwzxG4Sq0gR7O?=
 =?us-ascii?Q?04jYPYwa+Zsqp9r9CBwv9JMLCuPx7UMz/yW9RIFiLM5QhmtBUXb63pLk1zF6?=
 =?us-ascii?Q?GloGvAIBM9cjjttBGy4ckW4FtMQNHFL2v/Y0pvO9bW042DCjHcQ3WXb3LgvO?=
 =?us-ascii?Q?sy93niqBjrtJ8DfLhpVFwlsLTYYTK7w6mpCUz0WF/5gVebSfdw0DqDVuCoiB?=
 =?us-ascii?Q?U7AjAAYTJqIvQv5aLlae+AWyBnOf5muJ0pUTFkV02hKkafLQYssXOyq51RuD?=
 =?us-ascii?Q?G92afhZTcWduBlPKw1gBxMDLAEwVcMXb7tv/sCfF2GthOMA4fmkOnPKVTjU/?=
 =?us-ascii?Q?VYyhfMO7l6DLDFRDWop4PB5Av6Zu/lChfbbz6xI043DuFYzVPJMvmXbO7hyO?=
 =?us-ascii?Q?7/VnV6MZ6bjfCs4MJSJDfkP+bEkwTV/iCBxmPlPPqEGmn70nzpDW0KMTbNmo?=
 =?us-ascii?Q?orS4I2T76qUcPebEb8jifPAUHghSQAjCybfV+I5ueZ3anGSF+CP40bwwHMer?=
 =?us-ascii?Q?551tq0yP/NAqfn3BurtnwEh3/YWbVzkLg0o8ExAm1/sPjvqpOpbH?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce8dc4d-d7d0-41bc-a275-08df4bd4c22e
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:48:47.3373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sEkRJOwm1EBM89VX4mppWYYYdqnwsr+rBw9bhQuACAiLErs7R/YhVPQMZvi0JBaAp7s1D3in2lhcpBaYPCO920bmwSfmYbqFtpDZzb78efpmbZf3DLaHQDjGKuyCqK5S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12784
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:48:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25163
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
index 3cd3687f1949..0adb1e372116 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -502,11 +502,10 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_ad=
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
@@ -532,11 +531,10 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct s=
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

