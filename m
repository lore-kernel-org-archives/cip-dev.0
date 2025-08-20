Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2E9CA0EFC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:08:54 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.25])
 by mx.groups.io with SMTP id smtpd.web11.1016.1755706125862790564
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:08:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Lgbx6wWM;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.25, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yz8Q61XAbnUO0ahucJQsgFZmwgqkte7lFk42pOSKLGaE7Xei5/1fA8QA5Ffjwn4FQjQ9w2eZbtHL3oFNHz9MAo3ITjj6liGgGUTA8i8p9XmD9b5yFsOR1ijgwaCWpLxA8mJ39tx+Rn9s1l7GMWlEUnb9MjrAxEO/fp3+sIrWM/CY7vvRJ64fwn4lvuovBYFDsIHp0uHHNOagVbrpAoPscukiqFjYEt4mmNt156f3ZtVxcFLp1ubwDsclsL1OoLK50mgj2bq2pWXidZWWu3S7M08RrKVXCG0Z5XvtVXse9TyiuAAvpVEhwO9hVU3CP3KZypmLSI0+Ly3z3qHK/5N54g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D25vIBtYaJwh6+3zFTig6MKUprG7nolH0bRZ5fzORWc=;
 b=TepJNZwPwRsd+uKbOgBcCk/yBB/rnYKxXAtmmuYXT2n69lE5pMOJsj6gSi0N6RLYcbGJ/PdswXIhovnkaLS22NhvBM8wnTxMtJ4AlHGihIpZJioOw0IIQskzBOsM4tenpULShLLcInsJnzrBnt0vlmTXEGnFBRJZj+slNSdBceGRzAZ0QLYYLnbglMd4RzeetGV0IduiF826I45fpgMpPQiL9WbINTd/ePicWd2GYwCI0z7zFCI4QsI4yy7qC92IKDlDw+TQPo+0Jis9m8WaALWKXZGzSBNVZxz55Mktz7Q1pTOTKkhpMEUlQfDQfbaRSugbSyvYnZ603S8HJ2rJRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D25vIBtYaJwh6+3zFTig6MKUprG7nolH0bRZ5fzORWc=;
 b=Lgbx6wWMVvBIf9gE2MJ0AKo28x06gXrNFU1wY501BohjeYkWwvVPmQCmxL9idd9C90eVG0wVHfZXKPCWIB8eBpJANQPChXJkko0HpQFDVcrPdty1bCjJUkOtsvw4svAonI1gmt2gBeZypUOr5A7zyxDC6m/jGzj0dVYfV5pZZ90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSCPR01MB15595.jpnprd01.prod.outlook.com (2603:1096:604:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:08:43 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:08:43 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 08/55] media: rzg2l-cru: csi2: Mark sink and source pad with MUST_CONNECT flag
Date: Wed, 20 Aug 2025 18:07:09 +0200
Message-ID: <20250820160758.801813-9-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 420eccc9-fcb5-456c-2d79-08dde003d61e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?NY9oU34fLDjhRLNpQWVD992nKRTZMfgU01/6nb07nbjxaxqZCCxqOpurFunG?=
 =?us-ascii?Q?sO7BehI3p1D6PcmgzQkhiERsbTw/hnAhij+zFFCuDPlAGrb4vt/MQJs4e28d?=
 =?us-ascii?Q?iy8B0fsHkLXv83KDc7dpvu8bYl3M5G35W7EJIGk2k17aFYuO5QiUJnii8IpH?=
 =?us-ascii?Q?9Gy2MtFrPuxc5BxTunVt7C3RP6WfCmpsTHdT3MYTE3vmEVt9IXylixe9OymO?=
 =?us-ascii?Q?rmdjrSaG5m7mQiH0Bjx8p6pT3aUU0kgI8+vuOIUchy8KgWTrXI5S1HNuVAN+?=
 =?us-ascii?Q?/mTqeuzgHx1k1vWglJz+118Gt4hNne/MjI3vXnWQfUYzPFmxQFmeIYFquSMb?=
 =?us-ascii?Q?P+1F5HO2zNq85bjytApeWjkrbP1TTsHNu8Dwa5753BQcvpJj0y1rP7qIgRmQ?=
 =?us-ascii?Q?IVGt6WtDXI+4JDXC1dZecQBBKw7GP1z9sAqwOdxv847WuCDMXH2jd41yUixN?=
 =?us-ascii?Q?SZ/bblMjCvJIggS+epq7UvB1NXsBeYbCwDNnlgCwV1tPCFNMCxPB0yoYyoRe?=
 =?us-ascii?Q?PqvvugbAhKfLMWX3P1Qm87sa6ZRexiDAmdv5Cme5mRRnxAOy1nGSsK7jv6hF?=
 =?us-ascii?Q?ZNcvXJ7/y0GL7O/Dofq38JiPFJ0L8kK7vci3WP9o+/XWrXP7B4oD5OPGVwlQ?=
 =?us-ascii?Q?P1iLBPUU6CkbeShzFM30xMtVN3zNRdgy37+FLpUE2dw9ygoOSaaLWSrqM2Pl?=
 =?us-ascii?Q?HimA7zpJKMY4qbzl3JJL9LMcs5SxHDOfyGGFwL2PF7uJQM6xI4HC5u7Zg0Yj?=
 =?us-ascii?Q?xVPu+ueSJ5D1FuaCULpHeX2UiE7KpOXhyJVyqYaKu3nzWX+rILGIbiSypCFm?=
 =?us-ascii?Q?S4IlfYi/hJ+6gSz33c9RRUfuZI/dEm/8BrcGDD7BcvRAR2pQladFGKkyvqRS?=
 =?us-ascii?Q?nnO84NXKFVBzVP8L/YEdAOBZVgYx6ymxGL90vH/M27La+UUjYSPtZWuk6a2x?=
 =?us-ascii?Q?XI94nSRvrBPhu0RFfvb6YvdT2jVx/ob7+1FwDrH9FjGeW9xg8vCDR5VFOTVD?=
 =?us-ascii?Q?P6bMDK0LhvvPcL4f9wIZhRn3GHCAIlybfiPdmGduZaS4Sxk57kSxHM0/dNix?=
 =?us-ascii?Q?ESlWKQkB122Z92J6jweLizdu36nXhzZDRVgHbs8BdCnZbcqjMT7ctL+ZUBXs?=
 =?us-ascii?Q?4ya1qBkECbSdRTbsMJxkFIiFOnvdRln4VqIbl6YllVauK/KxuLxlwgCR1R+8?=
 =?us-ascii?Q?WOiGDE/PDlWINyDx1IN2zku6XQ7PjT8oLzc2RQnVIxeoohEZP38aOQsBRULj?=
 =?us-ascii?Q?45m6xoDKFZ+ZfM8UECmm8aMyfdudMrk8ZMl7ftasbzdDfYDEto+zGdBU1FSH?=
 =?us-ascii?Q?oquD2nzKVLHt/FD/FxMt4mdndDEc++i47daOLUNwwkMynD6CiaGOihcNSoPI?=
 =?us-ascii?Q?M2/B72CtjfxnqsRO6BicaRAa6paNoBSme/GSDMqBzkMCAbssau5rXLrWZgYG?=
 =?us-ascii?Q?SkngeGe3c43RrL6FQ7eJm7+SobgdtizQnb4Q2DZOfpCBXa/JB/+MzZqys70U?=
 =?us-ascii?Q?7+2in7V8BCQymd8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+CvWBCqBXVFOaaEggFW6Wm+hQABi0V3iwQQCmR8jp9GUzJcop6Jdie1tZSrX?=
 =?us-ascii?Q?ttSsnjZdz3v+VhMQXYPk7744yJCHb+9vkDBLf2ltGzc2O2KL9QlMAC4KsC8R?=
 =?us-ascii?Q?tk1EP4527JzX/SS4gnvxrgJc2RKBw7SYek/YPQ1cF5WPXcSIkfye9OsGGfRp?=
 =?us-ascii?Q?+2cpD6Ey6Y1X1MeHFj+/HQs7PrGBumySIugkuF6r1wEiAGOTbeIbKpSPe1kM?=
 =?us-ascii?Q?HIX8K1DzTKfgw1Or8WVmQ/DSDe8CHUJPyPpeeRcT8006n7f2oBFB9i3+Uzyg?=
 =?us-ascii?Q?6UcSs8VtR1lylpjgasLWc96pd4braVcKx9a1RQ0EU2rPOGA9yYcPoTkI7lwO?=
 =?us-ascii?Q?D9bmr96nCXSUfz056KHs1I6ENEfE9iju/ouenNInekWzmDY0kdYkvsDBWYcA?=
 =?us-ascii?Q?OCUgnfFL8tVslnLWOuO7AipoT7BgBjWkKQ4Awmwhg15bDzIV+U+VyiVVou/p?=
 =?us-ascii?Q?DUO5R4AF8/uhHrgZTXVCP52ljxU4HrVsitVcqfmHtQJp87+OjU4VjuwG3vpK?=
 =?us-ascii?Q?E1K42u1M2EYFxu9Tek9oqS93m4YCLDw11P1/shD439jjIW4cROhg6XNRIhWB?=
 =?us-ascii?Q?J7tBNsqqTg3+Oq2DRK7YhAVxC8dL1C4kMH5zUbvnJNCjN3XKaM4BSGsiqdVU?=
 =?us-ascii?Q?RpOrhs/zmst6LjqN8PFv9PglpgR4FNE+POp0tjO+ezzVvyQvQyLWwFqzreLG?=
 =?us-ascii?Q?uoDLlk6PH5KklO9wWvMgMvZGApIpsF+ot3Lgc7waCGQ0HmVdBuGP869DSFQX?=
 =?us-ascii?Q?xA1PAtbJ4rCdfqTHe50IwR1a4JsNt7ffmoPNITifHLv5Glv4Uzk26YW97PBR?=
 =?us-ascii?Q?IVZtPrpqrJLkMpCWHwEt3khM8bxMKzPhYt+t0qvQjj8M4Ow73K5XFN7No842?=
 =?us-ascii?Q?rQcaHLO6iBG/DheKNQ4tzu+Aoww4uJQUVsfNVCOMuDpRyQ0Qaok4s/Hhm5Jy?=
 =?us-ascii?Q?VWgDaOUGKFAGs7jxOoaUEUYYIg8OCJ7m9c/qxLgLqzpraUGv2c+mztC8bjIy?=
 =?us-ascii?Q?FFhsH/NZXMBFR/Dga088nY+RP3VqiiPvHb90Y4BPU90CFqbxlUCO2RU5GLnY?=
 =?us-ascii?Q?SnaZaRcBelWNzXW1iv+jB18KIAveAq6EiODsEvbwH/j+0uN70GJCkdY6HZRb?=
 =?us-ascii?Q?73FKUgGNU4pW7cqkEJekDGp0jj9eCV7kORi8UzqS9ux5jFkWgLHal4n5TdoN?=
 =?us-ascii?Q?oVoZ5H8TLxLty+PISXT/+M8ua9JkNh9GU5tIPaGw4BnoPG8r3ov1LgVVNSgq?=
 =?us-ascii?Q?ZnYUCqnP/u8bA/+vUBPCozxLeDKq7zZYi8rSlGFvGacu1TJtB1EpdXS+/sys?=
 =?us-ascii?Q?OujcNstOfrSslVFZu9zEmm2N6IqHv8r6UVYjGvHBndnAzni2dP9LKpc41/VD?=
 =?us-ascii?Q?Amr8p11I5shOA3PI6XNZsOObei1pza4neUlhQ0pGoLoc/FJqxIQNaSo1j60W?=
 =?us-ascii?Q?L5D/9iO8+L6rEoEPAJycbw42ScQB6lY0uuRcfp+yxJ4ww9cwHUruPzR8+wZb?=
 =?us-ascii?Q?D0Z/89lwR03aHJza77zkuLtjdLcejhdlW1UrBepABr/au+f8qCh+rHrOBACP?=
 =?us-ascii?Q?MBWau9+5pOvweAl69zzJfqjLtBSJcJJu2fJm/CSldliLTSKLG6TPEdOxLNwI?=
 =?us-ascii?Q?cyIPJxHPf8pixqgCmzP7PDw=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 420eccc9-fcb5-456c-2d79-08dde003d61e
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:08:43.8986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aze3LuzNA9oU7Im6hXoWg9FAOsAq2ToLE06ynHUfM+2f6Gl2UPAnaBRNnc3fTuJ1r+fJ2LDxcVo//5lMbF0F17+Zb590ycqQtiC0rBdG2fcEt54v96oZEw4vsC009eSG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:08:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19889

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit a4e014bfdaa029223429c02b6fb0aa39c34e06e7 upstream.

Mark the sink and source pad with the MEDIA_PAD_FL_MUST_CONNECT flag to
ensure pipeline validation fails if it is not connected.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-4-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index c7fdee347ac8..2f4c87ede8bf 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -795,13 +795,15 @@ static int rzg2l_csi2_probe(struct platform_device *p=
dev)
 	csi2->subdev.entity.function =3D MEDIA_ENT_F_VID_IF_BRIDGE;
 	csi2->subdev.entity.ops =3D &rzg2l_csi2_entity_ops;
=20
-	csi2->pads[RZG2L_CSI2_SINK].flags =3D MEDIA_PAD_FL_SINK;
+	csi2->pads[RZG2L_CSI2_SINK].flags =3D MEDIA_PAD_FL_SINK |
+					    MEDIA_PAD_FL_MUST_CONNECT;
 	/*
 	 * TODO: RZ/G2L CSI2 supports 4 virtual channels, as virtual
 	 * channels should be implemented by streams API which is under
 	 * development lets hardcode to VC0 for now.
 	 */
-	csi2->pads[RZG2L_CSI2_SOURCE].flags =3D MEDIA_PAD_FL_SOURCE;
+	csi2->pads[RZG2L_CSI2_SOURCE].flags =3D MEDIA_PAD_FL_SOURCE |
+					      MEDIA_PAD_FL_MUST_CONNECT;
 	ret =3D media_entity_pads_init(&csi2->subdev.entity, 2, csi2->pads);
 	if (ret)
 		goto error_pm;
--=20
2.43.0


