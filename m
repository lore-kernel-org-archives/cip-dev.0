Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8B2CA0EFF
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:08:44 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.5])
 by mx.groups.io with SMTP id smtpd.web11.1014.1755706123471187884
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:08:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=XGHvNTUH;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.5, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIZKidateJ2VcaBe1dlcniQOzR36JHUoBjCKg5H02vJpm+oBormoeJuRbsKm97GwrUbWzBJh6cgpVxo2xOHgiqxK7r6H9WFemwzpHncIa45Swp0i2CRgCkT1fPkOZ/KdKraNlaPm2K0mDDZ51aR0BqPq04eqCB1sz0V6j4Umkswu4Gi2kbXFnziQHZ10aXpgYeNkUlYqsB3mUHRdCl4V+95AyN7901P2Bdq1oMeyIMqFUOmcHSpYJSU9BYRuhJA3xP3twDLPfCvU07bJ2CgZlNbf4I+NPFSTyUEC34N8wBicPVkzuMC8NreccWahPzyirBh1/zAPN9UL2l+xG3exPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4uwaneZHnWc+JSdsXzBWBp4E2a9oWB7lS9bqWyg6t8=;
 b=wvzEaWQoHeowU1StYMfQU4ikZdIjBATTa/gaeDlD1+LhRcmYvgaa/OgN2FkukN6BjsqMc7eK8p9eNRpYAc5m9Xc6C0vrQIfN6cZkeK1KahjbOiD5Mu9xhiwP1eX1hncUk+mqj++bOVF0TBGRqQGU7O76Boar41CHL8wuo/sLrF7P4Zmt6Ou1uf2ANw+qoAn08+VPL8B0Y8XSJAjuEXURYQj2g1xzj5d/CfYJYjWgg3gaBb/POMeWbHqC9Baqn+3lCuQIzb0Qi9l/W+tjJYIitpbYmX71Yef3loOSrVXI9KhLoY/ibjZjcQ63Y1A6cwB9rWVzuXQPVlc9hKyNpSTbjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4uwaneZHnWc+JSdsXzBWBp4E2a9oWB7lS9bqWyg6t8=;
 b=XGHvNTUHbffzRvHLZsbiULDF2hY6ELgTTRd5Qgcbaq4EbB1xvsKjwgceV87xn5zcigWB6r5qUrtWQ5SHcmVN/JFqr/A2rB9QOanAKBgH4Jh1LxKhL2mfJrVBwlba7C3MbGfK3Q1anLeRhcLOPcYeQ96IQpSMQUNq8Wof7poD+co=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSCPR01MB15595.jpnprd01.prod.outlook.com (2603:1096:604:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:08:41 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:08:41 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 07/55] media: rzg2l-cru: Mark sink and source pad with MUST_CONNECT flag
Date: Wed, 20 Aug 2025 18:07:08 +0200
Message-ID: <20250820160758.801813-8-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSCPR01MB15595:EE_
X-MS-Office365-Filtering-Correlation-Id: beb829ac-9b73-4b39-3367-08dde003d498
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?oc/W4Zq3rs2zuWQG7df/DAXgIH9vq9VKHyvx3OAMJyHhUI9gnLKlJ6ABMUcI?=
 =?us-ascii?Q?MfdHEbnSNOjy5V00el/BfoSJEM7pZv8V4/5bxdeQcQm8pH3X7BSHY2uu8CwL?=
 =?us-ascii?Q?//FxUXLR2IJYFyLHyiMUR/P5dby7adcOvH0StuZejjnNOmaW1Mnr9mgOzt3O?=
 =?us-ascii?Q?BanpcNenqL6oCXbpQM74JFeOfjGphCzVig3CkmlDYCAu5PvxeEgW34vDKCsM?=
 =?us-ascii?Q?w54OkKByymeswAOnXK48IIBXuwVTObi4DVXErIspZUHAA8bIOu6Zz94aFSxL?=
 =?us-ascii?Q?gCNW49mu0L4XT6s3/VQU58LhbLPL/hYjockYIjyPzQx37vBfG0oKBSIa05kz?=
 =?us-ascii?Q?Gl1dP+6HpGixbjVyab4KmWmQUWhk7+TaQ/uOxHOsUGYWfJlcYYi0QJHTe3zI?=
 =?us-ascii?Q?Xm3hcIqwAJ0QxwlPYW/A8IEtSwq7e+o8qmqQIYBuuqUkH14sgGv7Zs0cMpnR?=
 =?us-ascii?Q?rbUSY3BVCFLvC/AKBMOHItRM4mTARYu+WC7+4wIMB108ldXapBrBFNCrvLMw?=
 =?us-ascii?Q?I9vi/tcR9yb/u5rBXhkuQ7YWR+M3GBQglKzXrIwbFvhghUJ+zjK/qREwqwnA?=
 =?us-ascii?Q?t4u9kt3J4jXsCUqXj/5Z1aDTNh8nzDwcI3a4ZcWI4tDl5vYi0GJ5uviWeTGA?=
 =?us-ascii?Q?ND5IXo0IbfXzprQOiCTOqVEQfsik09Lvl9pEzt4XhkGG9MDwg1Z28kL4DqtY?=
 =?us-ascii?Q?0wiOVdbyjAs2TSuNZnZ31uuR9dKJ3PYMjyVhfzKLG4ci5dDgZv+dOK2MLvJI?=
 =?us-ascii?Q?u2ChwG0X6yC0Hyapj8kaJM/TDyrjhBtCuLx/zu7YtKNC3f3WYQvWbX9Lc9gw?=
 =?us-ascii?Q?G9lYH7H1U59dS12eegZ7z2gqYdDtel8ZXIQz0M8VR8p0xgKkwCjY9w+oXFl9?=
 =?us-ascii?Q?AFYvqUEEHMXhRWjPGAnUToDYq+QsdEenKlY0QIHotpAAez52Cct3tSdIopOU?=
 =?us-ascii?Q?SP6XOLdRayYxIhQLtls5Fi6Zq1NE3LpEneppaVph43zFZSV5uYwG7m8Z0VEL?=
 =?us-ascii?Q?MMGxBRjg0DoA6cNKsfkpivh1UeRf1vLMROK0mRF5mqHQ/2NqFdYtEqS9cbjH?=
 =?us-ascii?Q?i1p+ndSwqWw/2uTlRVEZ4bYYt/gQrUcSKdMPgFPQr3D8iWzTUso5P7t8s4tw?=
 =?us-ascii?Q?JL824EpoND08JXsLf2WKr+alxk1+IH7CkmSGVIaUQr3ozSSeez+oTZJSKsGA?=
 =?us-ascii?Q?0Y8RNYOOkrXS9MuzxzpC4HG1vIwskVwCcK7/1nTIqT7ZleeBC47GgVk1VF04?=
 =?us-ascii?Q?41xxu9Chu9+97vZ+Fx/6OjRZMfT1KyJ/LyMi1Nhp7E+Sga9b8M3iniaXGwZh?=
 =?us-ascii?Q?Xfg8DkLRHmrpxZ7pfpUgvohGsLXqpypGdamiZCVNWY+FGkM+z1ELaaK2xRKs?=
 =?us-ascii?Q?/hbEoxNiRS5MQhgs8i0NGDN7aG3CJkpEQnR4UoJOvFw+/S10TsMZLgGp0D9i?=
 =?us-ascii?Q?ypRPp4qPkZAdiuqsjbopYQ6C2oay32OvV51Mm4pXDA2JbPEe04t+So+Qu6RQ?=
 =?us-ascii?Q?dcyAdE/7WmQj/Z8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3b9BYcH5dEmnP/bbURAe7l4Z3N0IRAX4SR7cbDlZKgNF9EoID+a4VnPel+X9?=
 =?us-ascii?Q?qBl6AB0ZZH2tBR6BzPBpWYLZkf5tFW1e/lhWY6NwzTiRmKbJqltc++SHQOtf?=
 =?us-ascii?Q?sSttCozsNqZMkvvTHncm7z63/Ay05seuSTVvooEEYon4YTWap76R4D1PSiUp?=
 =?us-ascii?Q?Ptl5/gCu1wR3XtLlNI64yV76CUM/nI7J0en+IO3GzzkCCzEbCK9qSI2Tt47y?=
 =?us-ascii?Q?v4GRHGCZIYsEylXnuaebk4lDkRPkmsQoy3ASEzb5KUDjJ4u7X5Ny3GBN3N32?=
 =?us-ascii?Q?XpAhRYKWijAxEZzEMP7j0m0aRY7gK8GxyqU891jhDABw92kBtpV6do8u2iFn?=
 =?us-ascii?Q?3Gn/ksYgEp4C9M2qZ0QyQsbQlk+k6xz6ON7jvFyvGadF7CkrGOpZHcYNHOkj?=
 =?us-ascii?Q?jNk37WtjjJSQCl3YUzkqyotPYGHUNXpC7Us/n4ucDljGwJ+vIso57KFPOPBS?=
 =?us-ascii?Q?hsKiNMlRuU4iOlZGj7FGXz7QuAJmght9tQ38cCGrSxZiBbM829usJaYLZbqp?=
 =?us-ascii?Q?GJHEHX+mugvopqwdz6xTGH2TvDcneudblMSJekGck8xKNxuUnIcbU/ellWaZ?=
 =?us-ascii?Q?bXxlrKdwEmpPissPdBOBa3jLeEt8ZzgCzcG0les5NW9FalVZnPPMp3vseHTR?=
 =?us-ascii?Q?Cp4AJG2aKvf0rAvC+F3YLYKzU9Me3stDFRxIoKcXK8pQhV83cKEMnGQDZucL?=
 =?us-ascii?Q?u2pfIvU/0qI/wR+wUTAaOOqKoOjbWdxOLSME5flLe5A6fQvGIHbKAjjLWhb2?=
 =?us-ascii?Q?mVukQfJJ0AqyvtYeQCR8odwhY///YQZxrB/5bfC8qRePu+i/l9W+V7dI/9AT?=
 =?us-ascii?Q?8W2hIUlXfGWX96w489gbK8Acls/bkSAdrUh4u7k1f6KLWad5SJyGeNcu0mP4?=
 =?us-ascii?Q?JHwdo6Uzk33noOdl+SyWCGrsRTRlZl7gIaKK9pMqjTdgwVCHEB5iNWqikMII?=
 =?us-ascii?Q?P3mwJZAk4glCE0A/0hDX7gaZ387YkxhZ0YGbUfoCNLQPntIysULp0+vGyq0I?=
 =?us-ascii?Q?k7PgxsqyoA5d4h+C67RN3RZ7nPu5OcAh2mU1u3q/xaw1RUb9mhG483Aaq71z?=
 =?us-ascii?Q?/bgen2B7whSXZRAiEsVbl/lRobxvCLqXEFulS6/hlAi0oZxzmhVlGiYem81T?=
 =?us-ascii?Q?/2XIBnZXBoG3yQGI6BTHutKMK5Ah9YMoSLTnRuzBUT31mCQerIctgJ7oL2Z1?=
 =?us-ascii?Q?461DRw0WVcB/ABCNr0QYJ/+K6et19Ma8Sqz06MJU+eUNavwfjwS9mtPyNYqO?=
 =?us-ascii?Q?wOe835TiTJuQhpULlVW0p0TVPpoTmULc0c7ewxWAN1j12TYxCdnd9Zls3N6Y?=
 =?us-ascii?Q?nC+1UZaFd+jXAEnDWlNkB4wOvM6la20IME3oq3dtwknD7PNLM27z5naq1mua?=
 =?us-ascii?Q?D3lqPjrgP197gxBan51xg232Bq4Emlap7WXGDtyKK6SFj1UFYxYBkcB8N+r0?=
 =?us-ascii?Q?S3yvH61URPpqsqoeJ0QNl6wV/gjiiNhAl4cG/r7ZpL1zCOE+ba5C1wmXp7Xa?=
 =?us-ascii?Q?MSY2BzGP13YiC30hmt1B2mfpRYs1yePRCDBignwmatttXBnYS5UMoK3mVNr+?=
 =?us-ascii?Q?iiGyBrk6picUVwBwt+4MFHt/1uP5vSmV6dtgKnTP0Sqm68Hm2ZlGrd4AfdXj?=
 =?us-ascii?Q?gEuFUf1ZVKCcbXlOlNzcbIs=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb829ac-9b73-4b39-3367-08dde003d498
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:08:41.5722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guEsN9xOIln+Ss5sSuGjZZRcDyeNnNrk1mdDzYKz5yVVYYORgg6FcAXZQ7OFhc1Z8WdzU2GSe1JI4E5Wi7+877drc/KL+AFL0sSNp7B1sDEtcvdG41Fce/WGFJ09zpMd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:08:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19887

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
index 19e0ba9596c9..69cd45b26951 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -209,7 +209,7 @@ static int rzg2l_cru_media_init(struct rzg2l_cru_dev *c=
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
index 9f0ea1de50da..700d8b704689 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
@@ -217,8 +217,10 @@ int rzg2l_cru_ip_subdev_register(struct rzg2l_cru_dev =
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


