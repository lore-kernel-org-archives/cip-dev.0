Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039F8CA0EFC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:06:54 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.61])
 by mx.groups.io with SMTP id smtpd.web11.949.1755706009454711068
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:06:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=TlYsxrRp;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.61, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1kIJQfrvVa1z4/bvG39zEtokxtjLPkPJxHfY7u6iwGxyQVQdKgbOHHfQ89mR2GdJjGftCeTgnMqO2t9qLlQZCbBiM8jP79QgTI/ysRpzukKbBr0PtOxATbCcgbtrEf+5D9ykOOp0tRzCMQaTql/LiT5OfeE6m20eWvV2saPr70o2ZtiujCTh57++fPBoacUy+Lwrp1hq8b2DVNG7e1RU5SdHa/c62YmuTZen6L9ROnM7vhQm1X8kmAgS7oQnuSeMWY4/4TIfNoL5GTGS1KRH8Em60CNjCGD5wh+IkG5JSqIP9pZutRm5/prjBjjAeI1po2qhGBJ69Bdtpag2wgL8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmwxsL3M9zYZk+8lfzJYWfIgRe2Rs7sMtfxqAoZgnSY=;
 b=jdUdHjcaXOMC/3uAPKdL2x0tuYGk5Ab8N8JfYZ3n342cxiUDDr25XMlyAoRBfkPrFlKbHg26Ost3LubemI8mvgBDtjWKsvTGlJdE0cCZCbc6iRlfcNNAbYQHb73LsKe+YHZKqpYd3/gZFDmNOFAkU8P61J9E6SmbxEG0UFN7bZvoJgMukNB7Pzak5LcMoOclX9Ul+lr2wPH9cqLCn0C6UAlDeVdj1h1xaeGdScazIJLJFb4wGB3Fhnk2rAjyYQJkFMRznycIvYf33CrNwHVvWvtlYfmH1MXTKCul2QUshgM5iP6Iyktuko7zNpf8jm/pbXLsxfNnvMi7Yb4mAky02w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmwxsL3M9zYZk+8lfzJYWfIgRe2Rs7sMtfxqAoZgnSY=;
 b=TlYsxrRpOTR4jW4EHyicm6nqX7QB2DDTfyJkxY2dvLR++cyYuKwHg5O2EJo/zUnvf8oYTEwBGaSJFTaXu4QJybCZx+rf5n0QOU0gPdbz+6kS6cLEqmVYJqoyoZx8ltAWeXhSdebJNnXcDAdqixTBVDHp/dcPGlSg1pm4+djlubQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB12116.jpnprd01.prod.outlook.com (2603:1096:400:3da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 16:06:47 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:06:47 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 51/55] media: i2c: ov5645: Use local `dev` pointer for subdev device assignment
Date: Wed, 20 Aug 2025 18:04:07 +0200
Message-ID: <20250820160413.801341-52-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB12116:EE_
X-MS-Office365-Filtering-Correlation-Id: c616518b-7326-4c32-5773-08dde00390d6
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?29KhIv+ONJ1XE0zCqVGezrkNd4R4QoZPzFYIR82/d7PvrXSMTzoYeBZkk7cw?=
 =?us-ascii?Q?6FMxUaLPJfKfPPpSgaOdT0ZYXRu+hQPYuGLPkgsFBdxINS/2c8xL1wTgtZI2?=
 =?us-ascii?Q?RUYFw+i8MNtt0yfAK+FT01XOM3F8gOFyQRLn0GJaLsGp3kjCKNB5hDoWtv4j?=
 =?us-ascii?Q?7wngZGO27kdAvI593tr2qfIolY53usy8ZT4ybmwcZRTfqlvu+Xg+3fkjZ+4L?=
 =?us-ascii?Q?0PIeiP6NCsvcfvQ7EFn9NZAt7yAxSef+c/YnPEf2CzZj+/KD0sRc63zb1sfp?=
 =?us-ascii?Q?1628B8UfsBR+iOUk+x3n9Eh+CiXOcosWPvl2b80Z31Z+3oK/eZa0FJJMN28D?=
 =?us-ascii?Q?jQD+tZkfuDxIyfhgNUPszeuzetxdfP0DEkr2ZQBAda6CaaMj2TCL0XHJZ9Jn?=
 =?us-ascii?Q?KIzVJlma5XeiiE63oPr/00T717B9m83aBkECt9Cd24ey47Wy96vGNLfcZlLo?=
 =?us-ascii?Q?ovni4D3XMbjAMRsQOII3y06mGuiWfLDWSqFuFnTiNuyDlKk3nN3mOJOlVNwh?=
 =?us-ascii?Q?LOn41UvgvRKEfU1Vi1qLeFxYspaK0kW3fa6tcTR6AFFveKv473f7kRvKIaDC?=
 =?us-ascii?Q?9LRlB2bDW7pzxTvgPA81lFNXhsDY56ObMg9786Knkt2YVTTMjoKE57Tjmf1n?=
 =?us-ascii?Q?cbu+SOyz4jPT6+U75P7MlpkVhSij3b0JIDOVY2uTqmj08heOM+oT8ibqDV1B?=
 =?us-ascii?Q?HPQ3oo4aTK8HBdmpF7pn338pZt4qeVEIQVHnLqawPGYB4T/qWRXa45n/zPPt?=
 =?us-ascii?Q?2rW7kRigWqAeGbF9mtsk8vB3+yC9ThN6dd+HImNLCDFgc14AcbxJfKhCWdfR?=
 =?us-ascii?Q?dVzuEZnErgV4GI/upc8s7qeMnRSLDLz7J7IxMlTm1OqWFzja74bRw62zr4w4?=
 =?us-ascii?Q?L2ZMNt6e5dM8LQBIc5JJ5DeNfXC1W3NwwLshMxd4TCkDq5pgetCQxntOuzlm?=
 =?us-ascii?Q?DS9gQN9ZiTbesly42seN9TqtPhzfZ5Ua4Gn1ZjHcCuL8nDtwBtzRkW3cfUtk?=
 =?us-ascii?Q?uj4kgqS8m2JwvPynqpCdUgCyoUmmEb8SbbJT+s/B0SOLked1nSGgFQo/fkCD?=
 =?us-ascii?Q?7WMTqYr40koIKtO2Dx+jETvjha1IQFwO3v9xdRjD0GMkZ9bcgX7Omv/NRpte?=
 =?us-ascii?Q?kFaHdQhXqhhE3eS24fci94QA+A83/2ai6+4XqTH8vjGER1BqLSBRKPxUoN1b?=
 =?us-ascii?Q?Pgu30aRskMiDxFd/cykBBN76vWNQysJ0nuIT0tKxIaMtYyBuT9/k0gqP1Qz6?=
 =?us-ascii?Q?BqlslPouME215oQoosga+3dkOLFIvAmElPGvAlDEOZMNAbQi6eVFwuc/PwKV?=
 =?us-ascii?Q?1MOvhSuSWTR4MvfatdsgASQ9Ibw0KoTim18I0nB/oqCGAbz6GpXWqa2hlo9e?=
 =?us-ascii?Q?wBT+PKSGr5SqyjPBuUmhohKXhm3bLpHr2OBnxvYsU7fKb3qpS63f0JBs0NmT?=
 =?us-ascii?Q?stBK5bynvQqHDKlPhGNrIyZgC0sIV3odzyqUC9mmRiOlrTFXE/j7XQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sR0cw40wadyefHFW7bgGXqiGZ7cAtAv9mgXkqCCTPltDPlIQdudPGwr9z4rB?=
 =?us-ascii?Q?UALbLLryW1M0MnD/wcioy/ap4dUJxigqdeDPwJzj223akLdGcObnUEU+nh54?=
 =?us-ascii?Q?lB5IK/GRJmKvl5kUAnh44fga8D4G+iwA+166yGmP45auG1aomLk3JLazoN0z?=
 =?us-ascii?Q?skG09TSPOJF5HSiS8hC2t6xp9nHTRp+//A/mX72J6Kui32oMzCerglWDMBwr?=
 =?us-ascii?Q?hOCK0hP/SsXyF+QvFReyjGeIqay0FwZKIarPNKNkIyFgjR1Ctlnv7o9r3qYO?=
 =?us-ascii?Q?P+2a/EE75KBIpPXHaDK7l/ELQInVBRm7GBb9P6ZfGwbocmJzQbT89bj89BGa?=
 =?us-ascii?Q?4F6meRnQ4Bmc2qwXQoxJvnvqdx6GL2Pj5fZzU6A/+rvywgRDXVhqC0dx2ipp?=
 =?us-ascii?Q?GIi0hLE77ic3307z8mjpyarj5XCFh7sFHfflznxtwuELi6TTnQM9y4jSzf1a?=
 =?us-ascii?Q?Xy8TR4MbZOTVXnAjjQrGk7EBESTHxlQQdRmSfZ9d9Yfj5KXcrYaTb/y2AzpA?=
 =?us-ascii?Q?ocVQtqGvQOcOQl1MKw2bey4q/LLU9BmHGlmIrxm1GA1zkk10WxzmNwWaCsPI?=
 =?us-ascii?Q?KFuw3zB05fGYxnOHjEcHL5ZLDLhxvQctUJW4sLCRlYMRlD0d5r0MLNCrX4Eh?=
 =?us-ascii?Q?qrvK+IJ29AyEzd+PuTjnN9byIoHPu10ZciZJ2KDv50EgVshi5uj0hanc0mX2?=
 =?us-ascii?Q?YJJWVZYUtofC78eDvRSlyXMCaALLB9tyq3lGahxm86ds6Tj9gENSm3MPb7ex?=
 =?us-ascii?Q?Gxa6X8qoKEJdezRUvnfZdpbIf/NcRI+SrGboEPp/K38hqd/MXlHjzufPCah7?=
 =?us-ascii?Q?kJvWGBUKeVqd78OBUJoK37CBicWD2x0d8/fkSR9j/B+3DoJAn9XrDqfDQSyN?=
 =?us-ascii?Q?BEpLDKPDBKA6Xgv7NpvYb0RjxkFC0LMvvuqI7pOzskSFENWJ97DlbwKHbrNL?=
 =?us-ascii?Q?txqOnKZ41Gwd/n//savopgM55eA4tVruf5GqA0sNK4peAy7uEzTGM5qChrHS?=
 =?us-ascii?Q?cT1Irk6Ki5nwVytv8Edpsasljuqz+QSxqpgeR3qcpCnshvjCg0ZFytb8tJ9R?=
 =?us-ascii?Q?kcZFS2dV5LshqjFRyhoyiyUJu62EwqK8/mWjN5okTk4qGPYE7grINqZtxPnK?=
 =?us-ascii?Q?7b0dC/1pg8wy6DoCnS11UnsNNjDnwekbRwyEH6cKC4ps8A42Ac/RxMRDO1/+?=
 =?us-ascii?Q?PqBmlEpH7G5i9DJaqtRQf6lDyMtDIKkouB4mbVF0cj+hBLOxc/iKYe/QKypN?=
 =?us-ascii?Q?3DwCEoTo4lGFjztuzhka/WF3S0uyDCBf5KZDdSXV6yLdfVvQNgerm5s+ZvAa?=
 =?us-ascii?Q?KDnNTCz36Y+Zrg9JvHW4xJooxqWyShDdn0l+OvY2k7zvrAao96ycl6CX9b27?=
 =?us-ascii?Q?n+3uiBMkDKrI9RlVXA0OV97x51C6fOsaS694Szwfxk5R2ibGuj62rTdUUlR5?=
 =?us-ascii?Q?jJDKHWu+VfYSgJx74gVPgL99jijAVi/yjLkTZy1jJCn8HSLpXt6uWACy4V2n?=
 =?us-ascii?Q?lZtRVjEqiu4ob80YRI2zlZ7d6iAB+wx3RTpD0VTVxun8uTpSl0HSU59ggser?=
 =?us-ascii?Q?zkzf5awtfmcTMu+VoVjaVaxlHTO1Q/JK7it4gNtGMDlUzYzfHeiZtfVC3kON?=
 =?us-ascii?Q?8rmmRTeZMU+K3HBJ3jLR/AA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c616518b-7326-4c32-5773-08dde00390d6
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:06:47.6679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vv+Ri8MoGZEcWDtKdhAB97bjN06o14WsY9lmfUHgx3+rJVITfm+Dr7zurmvW51qFGJnHjynpbu4HI2mQ2QbKNnw6xpUmmkQgcZJFAfv0tGPihsgFwLZFCU+6k2FaZxGE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:06:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19876

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 3b3a7440607e7981dcdbbf6db88152fd1a5e1037 upstream.

While assigning the subdev device pointer, use the local `dev` pointer
which is already extracted from the `i2c_client` pointer.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Tommaso Merciai <tomm.merciai@gmail.com>
Tested-by: Tommaso Merciai <tomm.merciai@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/i2c/ov5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index 7652136b0dda..013e162dde95 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -1176,7 +1176,7 @@ static int ov5645_probe(struct i2c_client *client)
 	v4l2_i2c_subdev_init(&ov5645->sd, client, &ov5645_subdev_ops);
 	ov5645->sd.flags |=3D V4L2_SUBDEV_FL_HAS_DEVNODE;
 	ov5645->pad.flags =3D MEDIA_PAD_FL_SOURCE;
-	ov5645->sd.dev =3D &client->dev;
+	ov5645->sd.dev =3D dev;
 	ov5645->sd.entity.function =3D MEDIA_ENT_F_CAM_SENSOR;
=20
 	ret =3D media_entity_pads_init(&ov5645->sd.entity, 1, &ov5645->pad);
--=20
2.43.0


