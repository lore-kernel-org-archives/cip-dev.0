Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4229CA0EFC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:05:03 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.1])
 by mx.groups.io with SMTP id smtpd.web10.921.1755705899501990784
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:05:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=pPkZ8Cup;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.1, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKlXmVUrjhQsANJ1lSEGAFuZC2DcOUWfF8bBrZQpZaL4SqA4JiRlM1VUpo6RI9Ny9XPwanlcpHI4ixEelAbCIADdKj7yJdf3O9p9budfGVt9Q7warkWKYqGNiZaghg5sjxqisXvaaCR/YnxoIjzN0dCgzvX6sOEU5pIkauaepjuuGuJr5lbrBcey3oAZlzF+eGOmRbgkN5rGdXEhcXpDDOe8i9OqJsaF8nk/PLSQL4RIj8QDCKWblYGy0FEBcALV5L/CVSKVI7JFaQNlC7n/URZjRG/Q15Y3mmcHEZQoHPs/aLpTGNC0KziqUlbivjzFZJZkyq6SlZIUSsGdT594rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxeTPIFcByER2tpFEN1TARnuw/tZfTyklXJU+/vlVNk=;
 b=e/jDXuBNNB3wixZNygnnSHSKQHXu2JcOrZugneA2RrtKJfZjxztmjUUA0aAWeYXgINuwHFYnt3+6rABlj9fpR/O7oUegvX9y6iQyzdZqzC9T6gyYpTmVC1rnySRTyzhep5awHzKxD06dSfIZQnCPQFMf8Yf+47A8k6ms/7l7vc1LIBOj/4iARpGV/YKTbDWryimJ+X4689PqzQDWTbfkJxSvvVZJ6DJOk3iRDYWr4pYaP1Sg24xRd7La7KBZMUywnM6V3O6VCdo++Wlh+L/1ECeb3NLgb0S26l+stop6qdVLPjGelvAmkw/AtAqGB3MxnIuKDA1BOwsj/PnuSrmQBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxeTPIFcByER2tpFEN1TARnuw/tZfTyklXJU+/vlVNk=;
 b=pPkZ8CupHdFmlb05ukG3Mkbfmsq/OZqtdVQpgywWNmf9Jq6/0CnuadqfTYG7N1d3t9PvOT/aOC7vYSuVg7z6KqBTw/q8AcyN6O1kPJIItGCjz3MlGtJOf9FDzaw9hJIbGpAL3W/Lmreiq2WiLBZ5cRQvBjUCg7J9FdBNEE9cfiQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS3PR01MB7078.jpnprd01.prod.outlook.com (2603:1096:604:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:04:58 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:04:58 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 07/55] media: rzg2l-cru: Mark sink and source pad with MUST_CONNECT flag
Date: Wed, 20 Aug 2025 18:03:23 +0200
Message-ID: <20250820160413.801341-8-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS3PR01MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: ab85b803-52ca-45a6-3020-08dde0034fd3
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+6u3WEL3UITRJU/eQEg2edWclCGhCgmJYBX+2t1DFWWXnZK9dDGCse32YH3Y?=
 =?us-ascii?Q?6EXVEJ8zUr/JagyICo/mYdXickNiyDtDRpXb83exsChlUUdQHGdvLP8s6Ejp?=
 =?us-ascii?Q?Du804W5iV9ravroC8sQ8B+d1OdAiipe+2p3DxMEJGE6lGVfE7FOgF9KP8Bnf?=
 =?us-ascii?Q?4zWh4uDxsUs+ST0rjjgVSdBCJKrrIZOrRokrJRYzB3UPInMo98uBBYzq1e2e?=
 =?us-ascii?Q?mfRwZC5WTyS46noX5CQygQaO8Ai4vt58/sP6Ex1z7sncWD3jCVsKKv5u6JjO?=
 =?us-ascii?Q?jcxWkr2ZsukRxyrd7qNfz2vwm682ubW21qy1oNPyS0kkKvxL6WHOGkLihcLo?=
 =?us-ascii?Q?lnNigdFtUbkmgVIn4RYdHGzy3Y/grtWCOgtccpsTNpwtrciAn7hyeFTN78Rm?=
 =?us-ascii?Q?KkT7yPg8j22ZK1cCI9U5UvYp0oI7flvl57uzxp/Tb5mb4DRyCEg4SMhVeD5z?=
 =?us-ascii?Q?pJOYl6/xKL8Riw5SJ8quyP6rCAiHvT7RWJvJE4cN8EkBj626IuUMVPaS3Ace?=
 =?us-ascii?Q?R3G2I/nEnV6rw4V5BT9njBM4Fjrdid6igHhq/XnZ4X4ZQ2MHhw+36/qXpZM1?=
 =?us-ascii?Q?WOrsVS5t39rNXHFRnU0dCQxUONgOMV0ysOMXV0csgjV9+IMvaSwVVZTjAk2E?=
 =?us-ascii?Q?KFA64BZ++xQ1slETxb+fIWp3kPKF54zA+jAH7OS7qOiVHt0IzvOyYRcW5yfa?=
 =?us-ascii?Q?NrCrg1xXqXP/pv3SW94sAJFmhDK7YKFu/LlyppKDO8WvltIfqfWRUCQddCai?=
 =?us-ascii?Q?UOA1pNbmwGxRBl7iFc0uPJn7hOechf5kpIWo0LLkGSrF/FsUh9z8z4Pgeyn3?=
 =?us-ascii?Q?odvWzcjWzLW10+ywTEPrzR9k3I0ZobThTfqCvWPC/jbT3MFBASaNeylog2gg?=
 =?us-ascii?Q?vnhumKYw01OpCZ/AOHwg/ofarqXryf8rIaMEEdUIw83P7kVzNjGAw7t2/hpX?=
 =?us-ascii?Q?Vuzf62cjJDTSI1ljaoRklhI+pow1d1aQvAFB2Flmb/WFsOZRJTBKoMLdlzOi?=
 =?us-ascii?Q?bEFGS0iyPwkRsrS//Wf97iv4/yxUZnkcQPLzOQp/kgnwEOHOp5uLcRJh4Xps?=
 =?us-ascii?Q?S1yHqXrPCcAuZdZ0+0I+wv+4/kMd4AeQroasIc8U9XCNcgvya4WBsNl5u3dG?=
 =?us-ascii?Q?ABTM8Sqfez5DAgxYKJOgD6Rx11gjnBob64Hmem/0T9OC+nV7yfxWbje/X1Yu?=
 =?us-ascii?Q?iqfVA3e623PSWvXkE4RooRmDiTneMwOZcwEinnD3CaODY30eUmNezwQu4yO9?=
 =?us-ascii?Q?9UsXvOKHNxwECTKdHkoeXGvihV/bbfV6tUg+tTneXoy6/D89CrS43nGAaN6C?=
 =?us-ascii?Q?ElHK/KnvIMEMGs6o4wtUVof8QRMLXHw8m9iqEwjyt+5fB7CVtPbIAzLVIk+x?=
 =?us-ascii?Q?UoFsuyYfz+lFHLP/lRLvVeAiCEJAnUVZyCc8R7UsewtN+quyPhf/RvUdTQz8?=
 =?us-ascii?Q?m1m1viDeF8V5ssdZ7yxoJNWRMGYIs67/9AqfGRPHCCMhokMsQ5sv+ZrfLME9?=
 =?us-ascii?Q?U+SmT4rJY525RDA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wn4Z8nXA1Wc31g/w3MEt+/wvdFb/bQMi7uRFX4UwNpc7sH9vqfMLqLrLv//r?=
 =?us-ascii?Q?KZ71ydU99ik1hupyEm6xXxKZ+BJ6RwPV6YtRp1VrcyfkS0s4R0LIpjGCr2iO?=
 =?us-ascii?Q?QoSzQiEVyb+YGGQXU4OudLusrjZtc7/Z/wi/dBFm3keDn5B+ISUml2vwqXT5?=
 =?us-ascii?Q?Y3HpgqzD0Ch518gGi2zAB6RqNky4ODTxxN5z8Oa7qe3/CCuRrfMFSChBOu4i?=
 =?us-ascii?Q?gzqydBB1DTrViUFn1Cd/S7KhQD02PlHRa46tWn9Ngtw/huQz8eRli/327oqW?=
 =?us-ascii?Q?XLdblSO2cdljSneNQ9t6V/F5R8YwJNhkpCPOauff1ZlOI1JGAOSOQKaGkELO?=
 =?us-ascii?Q?Vm3TBchWuk7pahkFG1t/6soaw6eww/0jv9lJlaT7N4xki5kV1DONrQbcZmOw?=
 =?us-ascii?Q?RFJECpPoTfvNODMRhKlY55o7rID0le6PzbVu0HILDSx5TUUXtyJFDuVNIxSK?=
 =?us-ascii?Q?ubVN5C6btrItJIBRl9lWW79smv+WOoRCykQvJHQa33tEizrqsWcQhXK31ALU?=
 =?us-ascii?Q?H6WWuF2dmMf8AUF1pmfVIYa14mWr2xSfJDSz07/XgjUQe7KST1zi/VXSN7iK?=
 =?us-ascii?Q?drKOVhn2bQg/sZfo+vDGZVKF6euF+Bx4bkB1z21y0OnaDZSDNz3gxIvjGyxs?=
 =?us-ascii?Q?DdToRrYPPd6az9oONgMpNlW5P3v0mTFw6j8uiAy91flzh+ciZtBDyJiscu8Q?=
 =?us-ascii?Q?lHxUQ2oME+XXnbL/jyPm5q1bhyIs3NJrc4dLRFDKYMKTxWyrXhogaw2AXGnE?=
 =?us-ascii?Q?8YreEKT4hMWyGQP2oWaooYBFADmEwlNz6jYpEwn414kgS3a57cFv5hZ5PEZ/?=
 =?us-ascii?Q?V8Kqk+sowpWNZpYgJLv3HcXprRHT7DgKoUtpbFcgzW7CB/m+ZNH6SN+iO3DT?=
 =?us-ascii?Q?F8qXXLnq/VVh46m/g84xFKXekK+ahC9cJMhVtB004TWq96UcuyugCecPcEsv?=
 =?us-ascii?Q?cheZHtbUaNUM4hG4SSa4r3Wc0UHfNwfzgUixrj3YLLqO7uBjXKyKOysBaZa/?=
 =?us-ascii?Q?JDZyzHig6hi+L73ULPH9jJO3M4v5vufX5+L3uMKCuwEUFYFtpA3xSES45GdB?=
 =?us-ascii?Q?A9GH6+ue4CMBiw5CfyDK/BEuKWkEKFLpL4UbpHUqy17VLhudbMtrwBLgqZxb?=
 =?us-ascii?Q?EsztuF0ntdE01372RlyPbEX23iW+w3Faj+88881DMNQsiHw1GLX5XkaO2Z4M?=
 =?us-ascii?Q?cdMzY5FTmyyklOcY/I1zeFhcjnEsz37jpNGD+xl6yeGqBpcDwmzW5iKQ/wa2?=
 =?us-ascii?Q?oV/so+oLSkeoD44r/FLmyuHXHxRxOSCpOnK8dE5MBeGqlSfK3PNExjO4uLi0?=
 =?us-ascii?Q?bmyxyIrjccv4oWtarKa/Dne/94GNHITYxzNSy0aIS9zlsfUwurLoDGvkg/m8?=
 =?us-ascii?Q?w98bourHzMxELhfEo4BCD1slQ2rxmE6ljlrjonS2xe6wxaGjTNqFhQ1gWx00?=
 =?us-ascii?Q?JHgJaO2yInsri39U/SIe6YYwfYh6O1226Se3EzOP5CKHW4EcMmbMcNkhryUq?=
 =?us-ascii?Q?gMRkORqj5m8fBfaGyhCL5BKjJZ8kTNPHaMDX95/DgCOJNIUvyb3BJjDcWElM?=
 =?us-ascii?Q?cLlwL9+NEJfxueqdRKdwZLYkc3Lo3YDxTROjrmeYRYB5OiNuoJCu0AFOCBt8?=
 =?us-ascii?Q?o0QUbXszf45YqdztcS1NruA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab85b803-52ca-45a6-3020-08dde0034fd3
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:04:58.8198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbP0I+17ND0AJtuYhtyOQq9EzaVwL8y9TwzJcFviM03ah10/LQKZYFcGmJMZyeKg7KtQHGIAWyR1NC9EoB0Psx2daVVvLhS4AklHinIivC/LX+zBxJQ/NFXah/azdckQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7078
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:05:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19832

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit ad982f8522bac16ae2c07d9ff2ab3cf797c9965d upstream.

Mark the sink and source pad with the MEDIA_PAD_FL_MUST_CONNECT flag to
ensure pipeline validation fails if it is not connected.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-3-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c | 2 +-
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c   | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-core.c
index d583fe1ca728..b29caffce844 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -210,7 +210,7 @@ static int rzg2l_cru_media_init(struct rzg2l_cru_dev *c=
ru)
 	const struct of_device_id *match;
 	int ret;
=20
-	cru->pad.flags =3D MEDIA_PAD_FL_SINK;
+	cru->pad.flags =3D MEDIA_PAD_FL_SINK | MEDIA_PAD_FL_MUST_CONNECT;
 	ret =3D media_entity_pads_init(&cru->vdev.entity, 1, &cru->pad);
 	if (ret)
 		return ret;
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c b/drivers/=
media/platform/renesas/rzg2l-cru/rzg2l-ip.c
index a7316ea9a6b3..c37c671ce2d5 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
@@ -213,8 +213,10 @@ int rzg2l_cru_ip_subdev_register(struct rzg2l_cru_dev =
*cru)
 	ip->subdev.entity.function =3D MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER;
 	ip->subdev.entity.ops =3D &rzg2l_cru_ip_entity_ops;
=20
-	ip->pads[RZG2L_CRU_IP_SINK].flags =3D MEDIA_PAD_FL_SINK;
-	ip->pads[RZG2L_CRU_IP_SOURCE].flags =3D MEDIA_PAD_FL_SOURCE;
+	ip->pads[RZG2L_CRU_IP_SINK].flags =3D MEDIA_PAD_FL_SINK |
+					    MEDIA_PAD_FL_MUST_CONNECT;
+	ip->pads[RZG2L_CRU_IP_SOURCE].flags =3D MEDIA_PAD_FL_SOURCE |
+					      MEDIA_PAD_FL_MUST_CONNECT;
=20
 	ret =3D media_entity_pads_init(&ip->subdev.entity, 2, ip->pads);
 	if (ret)
--=20
2.43.0


