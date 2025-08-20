Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E85CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:07:04 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.55])
 by mx.groups.io with SMTP id smtpd.web11.957.1755706017077047229
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:06:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=UVvd8on+;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.55, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7T/63i5OZ0q2zpWsKG0IC0PkM2+3DyNM96WQqbZOG6w6qnEk88D/0yu1D2BPhyat0o2V+/2XGMhGMkRhhBsH/3Yr+MYJ++NO/Lbtm7s0MwiHbFlD6oauEPOKERMlmfcN1WnFD7DM8fIvU2BERL5r41Tw7IIF+/82T3HQstPgNhvrPoIa0y6kVfrt9KvG3SmVrc0Lxl2q6jp2ea3/uXZTZ7PMu7MIVA0ZCV8QeCWyXzw49RJPjd6SjV0D9EpXBd7xfOG/0Zg0EkmN3x+g/Hax/XSkAR3hHeo3n20IoEmpWxyEgkwiMB1RFyuJeNFhNqO/69nHVRdlOBf6Atu1D22eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljnDQlWxPFNAjbKd2hZHSwQV/KSFz/IwGN7AtgvWJQw=;
 b=e5dAgdO74lyH6ADfdCgCCjpuNayA+zkVnTU38ygTI0SBib49kiAL00N2aCgv1rZohBwZUibaQb1M1AAl1ft0LApvHNtmJQcVa/eYjnAffWhXi9N7sQioFQJ+7TuicjPeJ8mpp14H/6Has7IECFUuedOBGU+q9ZMopYk4ZL6t4R7daZxxrC12vHG4Pq+fKNxwsCZ44yvxBWUSEV7mbX2oAcHYz4lAfo5ShFJfg7w62v1xANoJ3zrjDUEjyQUODh/m8SS8cbe1IWSJg9c/6ywIltli6r2uDxQhWfWiocG+b39g+zxMJmC5+ufHOvKNoLzQdjDU8bidkpsYLAT8jX0YFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljnDQlWxPFNAjbKd2hZHSwQV/KSFz/IwGN7AtgvWJQw=;
 b=UVvd8on+KgOt842Bcp1+/5NtxU34y4xm1glUzHF1ygMQ6Kci5QbNs5REw2XcstIp23Mo+x+6U6MwPb1h6uJRr+glYK7KrS4CHbF/HCTNIgf3ONi9SgHiK3qUxFADL6dc+u0TYFuxTfQ574Nk9mYSBVUBSXE7kn1zgLCA0NQTjwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB12116.jpnprd01.prod.outlook.com (2603:1096:400:3da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 16:06:55 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:06:55 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 54/55] media: i2c: ov5645: Drop `power_lock` mutex
Date: Wed, 20 Aug 2025 18:04:10 +0200
Message-ID: <20250820160413.801341-55-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2f66228e-ff32-44f9-e3ca-08dde0039523
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?P2GWJ5/wZoJpyJV1bXF83XudPGeN2oYaXa+fhoF9oUkdYsms0sn33DSj5WR8?=
 =?us-ascii?Q?utjhGaXJaBxdOse+IK8kd7guDeM1ztvWVRdvuMeioq6xol/T7S3/K7ZKjC3R?=
 =?us-ascii?Q?Q+kVPYSFH2bBjBqdO3Oh+qz545AysKImyZdpXLGTFb68tamB4qKp5TfEmgWg?=
 =?us-ascii?Q?cBR0UfGFFeVEXRVrwHx2NpV1lJtx5icLL2WpNcuiL0a2vH8BsJelVgxiV3V+?=
 =?us-ascii?Q?USEIxjVAIaLerkOjmKmIobcJkOlQfA8GHA6kM5FDXJPAdH8/buPiqh2rg0WE?=
 =?us-ascii?Q?QMQdNs3Js4wem+5Ni2rbIA+iWT0o+3GnNNWCK30+c9Nk7q1fD9MOkgrMNxlC?=
 =?us-ascii?Q?tkvqQ8LINawHw74JXyqaaKSkKG+J5HWeTXvw45N7q6WAdr27LgVNjAhpEUpW?=
 =?us-ascii?Q?RIhbrfTkuEmaSzm2dWj2R6elQOQDfEaWhcHuqHcMSyrioqO61O5Wj6xb5ndg?=
 =?us-ascii?Q?qi4mZX2iI4YdNBBq4HNm/4bTjRhDHP5LGinYkSdM4A0gP6MN4kP6/rKKYwfA?=
 =?us-ascii?Q?yeWgOM/lYigAG0PXQPNeoGUibgRMwjCaX4IhJPOC58lXNhKZXGEwV6tgjUYL?=
 =?us-ascii?Q?iZCzQdTDZHjhMDcvT/mfsYWluOAE/6xT7BMth3pE+BNUcAVuI94SRZh84lO0?=
 =?us-ascii?Q?DrV7Zs7lK50mlhZ86PT4nAvVvp4AvIQaP4yY9XODZ5zyG4gDJxsY5PYbmDDe?=
 =?us-ascii?Q?TWqlLcLvnu6OyV19+hbTpwMKz1BpDX1Zf7Ej1prulXnVoh2zrhLqWVWblHr5?=
 =?us-ascii?Q?tZ50Gymt/r6o2pV06YD/eVtLgdjGaaEKU4Dk9/gpl4kdgdtXpt24knhhMTDe?=
 =?us-ascii?Q?HkwzsKu78HY5WNFahsSGR5YC+0t8xbrSPebfVn+wH+6LXLa7mWteeVnLUgRi?=
 =?us-ascii?Q?3tM/3o8gZrvY8g6S6vWoJIUBW7l/96YGRakqXIDzgWcgomD9+TyYqIkoDevS?=
 =?us-ascii?Q?N7q8kGv+gwg3lfH2WVDpciWM1M+b+pWOHojYJ+YDjolI1MSh7eOOeXNNwIfu?=
 =?us-ascii?Q?gHgxD8hSWDVCIeEQ9kCuybtQmpPh3HuXO2jLTKTM7xyNhS9i2AFFa75OedVA?=
 =?us-ascii?Q?CRHYQVjgMXQslScZ0UNrIMDAO5G777L2DCklC+xspKv+GKgFGBMiBJYW0Lkc?=
 =?us-ascii?Q?UnvbTmHVnkEujqPMXYeYNaHFVsltzhz8MOrk5yu3jDirT5uyQ3RB4JVa/T0S?=
 =?us-ascii?Q?POjSc0aVfnQYoid2WpYxaRWc8ve0YWq7HNYy3h876zEd6rT8KNnbP2pJ3auA?=
 =?us-ascii?Q?FgEj1BLlbl++4KCbgwj7us1PPpCxoxSZOmRj5qA7Ui6W779HutKb2QFnIIhk?=
 =?us-ascii?Q?/pIaDHiVF/1pFihjI52V4UjXhvE+4A380mF2BXdv0FtNs6cXgZG+ucKyRx1C?=
 =?us-ascii?Q?2sS4e2CFB0Fp54SIHqxaeZw2wsWjwqS64YYNPElzMdosikD5MD3dK+aiv9zg?=
 =?us-ascii?Q?xbhrqU1yD58qlE0xzGZeKsODwTOxrjZFj1sqOQp0V2QXG0iXX6TBqA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Lw8gvODqGTt8eUFFDefkZ7dcCIPBZcNmf1fL/R24GsDMNKc0AXj0dhSs+AtY?=
 =?us-ascii?Q?s6HmLuBv6SO/VXHVpvi66dUymj2g5Dj3KdrDnLawyk8mQmKksmLqr5ByUngh?=
 =?us-ascii?Q?i3q56+44WpQ1czX67kebCsDrGSPAOYpGuSCd1qz1iQtSdbHxx8mkV3AZA3IE?=
 =?us-ascii?Q?fceO6C9qCGmx6Ks8qgTUZX0fMSgXURIM0o2uzf7v208nAdL3OlrnQAFsFV94?=
 =?us-ascii?Q?4brMumtzINTfFNsMvoDQnHVsqpy3eHdDhpiy7M39otbNcDYSVmvvB7ojVrqY?=
 =?us-ascii?Q?eIJkDiwFTw+G5cbcQ/vRU2SThLJIydq4hQmsWVwMm5A7H9+sMg04xfYlwBPO?=
 =?us-ascii?Q?10vq7a6w8vWgFUZv4B3K+L+5vaXrjkH/dUTy6fJPpA8zk1RrtsCv4x74El3A?=
 =?us-ascii?Q?6pVnORY9C4C1ViTPyrZBgk4D9JsUSJb3lbvShjjDcF7pwxS49lo9N+jOQWpk?=
 =?us-ascii?Q?am5+wNIB/Mdbwv19FiyJhTL4MCTNx0vnSF60hdusFknV0qrvDFOc+fyWELEl?=
 =?us-ascii?Q?EjPmcKq4Z56IFavezxLVia9rBFa99vrR/OCGNpgdbGM5W6z2vCvNbrb/Ygig?=
 =?us-ascii?Q?cQIeAhYyEIIPtrykIU8OV1nraaVt0CUZrvjWboPao+qRCHDC0+ooRDTdf4xM?=
 =?us-ascii?Q?NkDJeF1b0hA5a3L9cv9YIJbjQG0AKHoOWrbiXmaNSCADxaJg7DiclbqfLHul?=
 =?us-ascii?Q?W+pN74qQcFiKniwOmuvKKJo/Wy/a6D8kjJbNl0dMwMXGhSNHyMBm51+D0mPG?=
 =?us-ascii?Q?JTJmhLD1I6XK8vTLNAiIK8FnsMMVU1tzjAWIsVFoU87pDbaL6mzQNI/Goks8?=
 =?us-ascii?Q?u5tEjtGmVmm0/EPju96BG4XLNebwLowOwommr1ym79/Q7Yq3TrvMZ7xAE2Ep?=
 =?us-ascii?Q?sFp0MrF7aiTPf//bATQRg0fWXuYHzhVCzkl6uA5UgKVoMqyjxMjT38HNa1fO?=
 =?us-ascii?Q?Cd5+kviagTJqJMZWyhUpWpPSg3QEAwBA7c+p8e+lzeSkrs8iJNX+plL6SX85?=
 =?us-ascii?Q?bxyNotI8WvlNFy0vPIVEcbBjSjI+iAXpQk34yiU9ukQXgd1dZ2YNMA3Lc5tK?=
 =?us-ascii?Q?gXXfg/eZ3NKYfhlcueNpvs4BToLI0wNtNi44xYrXT4ZVT3PUrPlrTwpSEpay?=
 =?us-ascii?Q?wtxwQdwQmQqRTqWlw5nDCfnoAiWrKPgS2ZeVoMbRB1Zag5cEO+iXdJr0CCK2?=
 =?us-ascii?Q?OVYpCU4edPo8SnKZxXoBIQUtUwE1ZNUc/IrByMIncNPQMFmkLvOT/OKM+6AJ?=
 =?us-ascii?Q?r6dn13GA/F29/RYGZsROeQT3UkUCB8YEW/h8dmAxOF2ZMzULTfLLWX9N9CiO?=
 =?us-ascii?Q?O4mQy3gyDT8xMk5mnddJww/Ot+44COu8JhEPohtWeGoYtOplfEk3ro6z0ers?=
 =?us-ascii?Q?HqTHRbroJQ13r3m4Gw0T5QpeYje6DOT8GLeDNDvV1mR883oHrAU7Xi4s37k0?=
 =?us-ascii?Q?PSrsY9npdYXmqQkPQQeyzSlmU3MMrNdRQBq6r0I6uscXzW6+Gth6n670kfNY?=
 =?us-ascii?Q?0g+voG0nT8/oGp7oop8WXY2XzJv7PlfjI0/HLwl3rpz+xxV129gWdmqafuxc?=
 =?us-ascii?Q?Ib/XptyCS4RaI+2nam9FBk33Cfwe8FXi6FZSLr7gu/IoNdZRMHpzD3iPB6Kk?=
 =?us-ascii?Q?ru4kW5qqO1X+KYJLj5QEw/4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f66228e-ff32-44f9-e3ca-08dde0039523
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:06:55.0986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8ny3ZQXPhz6t762B9b4vgCDBywsAUtMFd8F6qLbQ41kF4Nwt0NTOr4Jko63+f1XaPQ3K4rMjo/BbhfWpkzcpwJ0cYS0fHw11Cra5eajn5OCo5rKtjzZ4pkapqH4nC1O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:07:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19879

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit ecf85e03b4ab5a387895f71cf13a231277af9fa0 upstream.

Remove the `power_lock` mutex used during control applications, as it is
only utilized in the .s_ctrl() function. Since the control framework
already serializes calls to this function, the mutex is unnecessary.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/i2c/ov5645.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index 8f395a74ccaa..d1fbd9ec8532 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -105,8 +105,6 @@ struct ov5645 {
 	u8 timing_tc_reg20;
 	u8 timing_tc_reg21;
=20
-	struct mutex power_lock; /* lock to protect power state */
-
 	struct gpio_desc *enable_gpio;
 	struct gpio_desc *rst_gpio;
 };
@@ -781,11 +779,8 @@ static int ov5645_s_ctrl(struct v4l2_ctrl *ctrl)
 					     struct ov5645, ctrls);
 	int ret;
=20
-	mutex_lock(&ov5645->power_lock);
-	if (!pm_runtime_get_if_in_use(ov5645->dev)) {
-		mutex_unlock(&ov5645->power_lock);
+	if (!pm_runtime_get_if_in_use(ov5645->dev))
 		return 0;
-	}
=20
 	switch (ctrl->id) {
 	case V4L2_CID_SATURATION:
@@ -816,7 +811,6 @@ static int ov5645_s_ctrl(struct v4l2_ctrl *ctrl)
=20
 	pm_runtime_mark_last_busy(ov5645->dev);
 	pm_runtime_put_autosuspend(ov5645->dev);
-	mutex_unlock(&ov5645->power_lock);
=20
 	return ret;
 }
@@ -1123,8 +1117,6 @@ static int ov5645_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(ov5645->rst_gpio),
 				     "cannot get reset gpio\n");
=20
-	mutex_init(&ov5645->power_lock);
-
 	v4l2_ctrl_handler_init(&ov5645->ctrls, 9);
 	v4l2_ctrl_new_std(&ov5645->ctrls, &ov5645_ctrl_ops,
 			  V4L2_CID_SATURATION, -4, 4, 1, 0);
@@ -1246,7 +1238,6 @@ static int ov5645_probe(struct i2c_client *client)
 	media_entity_cleanup(&ov5645->sd.entity);
 free_ctrl:
 	v4l2_ctrl_handler_free(&ov5645->ctrls);
-	mutex_destroy(&ov5645->power_lock);
=20
 	return ret;
 }
@@ -1263,7 +1254,6 @@ static void ov5645_remove(struct i2c_client *client)
 	if (!pm_runtime_status_suspended(ov5645->dev))
 		ov5645_set_power_off(ov5645->dev);
 	pm_runtime_set_suspended(ov5645->dev);
-	mutex_destroy(&ov5645->power_lock);
 }
=20
 static const struct i2c_device_id ov5645_id[] =3D {
--=20
2.43.0


