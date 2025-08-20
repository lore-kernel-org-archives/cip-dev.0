Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229E6CA0EED
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:09:14 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.10])
 by mx.groups.io with SMTP id smtpd.web10.1076.1755706146379550956
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:09:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Y39UBC/a;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.10, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8edgaFhof1VKCtRJFVDQOxc+2PRAvp3YCC+0prEOHeYecp6YYXr/6t1jzUnKbIPTfqPaRytLRA1kRWK0HquKEMtszS1eY521yFlUSOatn/HkNFWMzwlZrYs9dcDJAuI3uWzz7f5N4WU/BD/z7hnc8Kjab6681Gf0ZljFWMC1nsvaWOCEmJo2ZzxWk4QjSBmx/EyszbVsUSOVK37Sj/5G0/KybI36jJF7u7CgvNa5IpqlqmTpYONau9vektB1Qk3Ag/sQWZ4UlIWVVg3rKT3wj/BW7ATyQe4lOSHTVlW1ZYfHKnBGUx1HnTg9UaGxpsqnv6LulbUcexTqW8TrnRx4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jXDFeDMvucPWgzIpDsKs6PEE0QJF49svWV9bMCFLxA=;
 b=zU9FYR6FwyJeEWnXwUn7SW8rg7o0P/dDcjpFcjbAtAwLdK2f8d/m9gt93gIh/y+HRLjvXagyrePs8N4pbaIdnyAgiOLko7XljHtihZ5on7VHq/Bn4fh36ivj48Ng7XsGGpAp+a6S0W0GVHjW4EE7gS+BvKfI2seUKkRf7offkTsquz2EBlrJNGSRvxNk4ebM8y5vAcVAubq1avXQZcRynEjnLhhfQta0K8uytpKI/1peAp8RHO8PHQrAJSLx3WHsP9Gejnz7+II3qUOxA548IkYYZFW1mBN6+Agb7gSHWjc9ujJxHnJQreesqm1ni2x/6gA31cNvGJFQWcE95RzV9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jXDFeDMvucPWgzIpDsKs6PEE0QJF49svWV9bMCFLxA=;
 b=Y39UBC/a/TY37uc2l8EUKYCyoMVgyJV05QmCpSKyudYYkgZyVSNuZ99Pff7qTsLfo5WaNMNxehMRgP5CXuu+fMezAtd7lu2XLGInCdEcH/cGgcnJ8MtpMpj17Hoy4iC5xL82FKaVekBcpWfzMWynAeX2/Yowph9z3y3h3i6ddWs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSCPR01MB15595.jpnprd01.prod.outlook.com (2603:1096:604:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:09:03 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:09:03 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 16/55] media: rzg2l-cru: Simplify configuring input format for image processing
Date: Wed, 20 Aug 2025 18:07:17 +0200
Message-ID: <20250820160758.801813-17-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 02125a15-45a0-4fd9-aaf8-08dde003e1be
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qf3WwRNnOAZfz/GSeNZqWwwUruDPGvl12XFmuuDfJIP2cTDS44YqPMoCWkUU?=
 =?us-ascii?Q?BDYPqwCsZfd5HWWmh9t/2ixdNjYXofv9hwszpgPThaKItIpMtAlh6BNox9l9?=
 =?us-ascii?Q?nIET7ejAodnYu0mW0nzE4FV1vTK3j79xLWmtzVRpZ4XXgs0Qtj4Pn8g36sq+?=
 =?us-ascii?Q?UHF9DGRNx1a6lukMJMYMKTcFQhDo0D6rNxkPyeVZKN6seth5OUmQihjoJlVW?=
 =?us-ascii?Q?ptGsfmLIKLxboCtkAsuC/REgyE0hKV4VVlbGV00p2xlf6AaapS0d02PXpE/m?=
 =?us-ascii?Q?HFkkHOQ6WZimVooudUHy3UnBbzwbhZhOp7kcqqa3sp28r0aYGsXe+4Ha89tT?=
 =?us-ascii?Q?C/UV56MRtUb51ej5NzgJKMgiZVyQ/tQ9YPexawYxVAklaJQSY4BWpbNwwP2O?=
 =?us-ascii?Q?7zFk8z0PdalihyesDpiZuuPyJxBqRMEiYbY7x6qertqVug6MEU7qFJY8OhFa?=
 =?us-ascii?Q?rTym4h+9gysrdLX9erjoRfAcE/j2qJxWCw+WDDUqoQbhbsk6LubZliKAq8pu?=
 =?us-ascii?Q?Jxp1EKP7dXZpQftkP1LGZizpz0WV+YFfVoqn3fnnaCbO06KkaH4VWX+i09DA?=
 =?us-ascii?Q?NLesb3+h+BqcZvnDJA3yCvoNrf4GlffzNf1hu/yfApd7bmn9MHUgIePr5xFa?=
 =?us-ascii?Q?lyLjB1u68CBO4Olc0UDVRaFkRubLtK937s/jQmwP+YUmLO9rITZI0NeYfCby?=
 =?us-ascii?Q?sg3c7zNQsYndzym25hQssZ5c8s5CdAI4RtI+A3Zsmwr//S55W50J2Yl3pFwk?=
 =?us-ascii?Q?np45QGzfwZ2FWzktSoNP05kAkLycw7Ck6t6I9Yq5yJajAZsvCWRmZpP9BhbG?=
 =?us-ascii?Q?U9rNJsylaUjkTVYsgzOaCqsM0Y9RPv43ChDM92/5FxChTzqm5eyscHa0Yl4H?=
 =?us-ascii?Q?tFxgFOd9SQPuymznFrfeAydWSjBaVgqlzJXokA4YVHUZzF01SzUdHTBd1C5i?=
 =?us-ascii?Q?FNIyWtyhkpyKKJ0TiKynlaqmUCWt8Y2Y4F/FOszguQkYT2I7SX9xLn4t3Jq6?=
 =?us-ascii?Q?ZGuiae9+TRjRU1TsMguGf7rZOeAHicZJGqTJJ8Ffuh8X/F8pU5Eu6bLNOe1e?=
 =?us-ascii?Q?LJVndHDYqiCPyvhpzRaEjJeNFsYre8MOa84vfExs53sfE4DyQpgsCcu9wux1?=
 =?us-ascii?Q?ZNEkjEnyrDhqXxrBwH/sYvi08aY6eMGEHycCvaa9en30WMNwqnMSWzmxt219?=
 =?us-ascii?Q?Zmoj77v67+n6PjBimL8egmsKhqDN8gX2tCnfmVQRO2y9BzginF3kG1oSzhTt?=
 =?us-ascii?Q?k3psOTnNLz1xmlpvz5uB30s5g9IliT4/szaBxp4L5V07faZdtHLvdpjpTzPX?=
 =?us-ascii?Q?9sTYusupSGYNJ+sH3mHbuGFHDOF9psYuV8KQQlGf8SZs2xk3E5Dmu3W7x+7p?=
 =?us-ascii?Q?fAj4NwUF5SZnd8+DafV4yjl3IlzeOlHYNnHVSVRfct/gSQEHKbtH3vkPbA1W?=
 =?us-ascii?Q?RUZF+G5VYf4zVU0IaoUVPmYFReyYmRmcGi67+NwKisE4E9+tT/DsevFIiE/1?=
 =?us-ascii?Q?ELY1MZinB/VX92Y=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GJjPccxGiYBkFhCKCTktXkmVkxdr3jZFUn2TZtsrkIggJlOpOMlqRqPa7DLp?=
 =?us-ascii?Q?SPpq1YKT7f8sc738bgVavOVvGgdsrQtqHr1dKgZgi3IoZDeitS/cFoI1WNfr?=
 =?us-ascii?Q?UG/W4irTQnHsyOLxtVFikQCgd593FzzmDXC9nM/wcE8nNxrbtvsks0a/mXZk?=
 =?us-ascii?Q?hZ65PaxwrF6fa4PtUaKmUxiOrIUeLw+JCxF27zKNT0PpJHIC6O4IMjUwu0tw?=
 =?us-ascii?Q?EXuOwqqm4BjKInqC+KA33JSNo1rZiINTaRu71kzklcxL3ZSq5wtJfONGv6jU?=
 =?us-ascii?Q?YkIHgsK18htuqJceFOSXNRE1CUvkaCJtz5IzInx8ZON+8Z/bs9GIUixPa7T8?=
 =?us-ascii?Q?2/mB3kWQJmmaxZ38O9Mia4ivZ30Zo2iAUqIpXr6DDSJF8pamsE79Qo7FkTvq?=
 =?us-ascii?Q?MQdFj13AVqx5fKEtA/mVMHA7YJO9ZbbS/ForXRPm3Uj3ETrmOcsNKdVYJgNR?=
 =?us-ascii?Q?BrADly84TWYLxMfH1pZY9vUCVUD8AdpqLlDs6+xyq3RAq/WtRO1C9kdBKPT+?=
 =?us-ascii?Q?HYV1eNzObypu+N4Ax0VYfsA5s1Xt+roH6bejYxwTnHLPihQPHDxsmSzQZlyI?=
 =?us-ascii?Q?LK/xxfhvdWAd8EWAzGOJhXOQNPD4zW8L3orrOktt30cSc2R6slRmKEFm+s6g?=
 =?us-ascii?Q?MNZ4CzgapUyl4jOvWIlu20Rz9lmttZ9D7zE/ieBZBggOq2peFqMpyJ++qrrU?=
 =?us-ascii?Q?mguLrGcCZD/ItnEGInX0SJfTiMTLyk3X+Wf63420n945pJj+005dpHRVCTUX?=
 =?us-ascii?Q?KLBZ2kRwBfWePvvNrbsZuO2p/ZmTizynefzRhCgkH6+O77U41euduif7/4gG?=
 =?us-ascii?Q?JgQAbPlJzfTV8XXjljdZiQYRGM0S9a1NGHDo03iRbprZUEgpKON/gk+vD6io?=
 =?us-ascii?Q?mSfQQjDaRKnmRDC1YYsD/QCnm5Rd8CAC3D+mUmFvOxVgIQV1xgB2Q0ehH59K?=
 =?us-ascii?Q?LSyv5ld12IAioF0T29AswXXLVRVvh5LpaknWlnqalt+mpYHcosIaT+n8y6iA?=
 =?us-ascii?Q?u13Byn/YoOTEjylhTAhnIcfnWqe6pCAz/LrumnQuSLB6sbOJfb0Ol9Bl1pxf?=
 =?us-ascii?Q?1VheetgYfAqGwKUTXy0jD3Flju0sifQ7WM1WI9ySQiLYPCROb8rVD1jQussT?=
 =?us-ascii?Q?cbTADtSge9q+5kJoJxtbOkiTg1XmHdAW+Sd4FqJWA+1CYnkbbJX9f6ZAu1Wt?=
 =?us-ascii?Q?krVUiGqWd7rG4FxH+v7pJaaSfkrrRxEmp3Wh376UiDTIl4Id7pRbKQH7M5pX?=
 =?us-ascii?Q?dPIB4ORnAPthqBZ12oEoGrWy6/bxexaIc2+0QMBXUclFJ9NFBlvan47vE93V?=
 =?us-ascii?Q?LF9sNa1hvMNny53H5IVTlyv4xgBd2TmUmdiRYOPnUurbl9T0+frjQs2X5YKC?=
 =?us-ascii?Q?gDf/5+cAljps7Mo/NG0HpWghVIrrKdKQ8VOCnDIC/j+VeKlOgELjbQ3Fnduq?=
 =?us-ascii?Q?SF6YQx+5l/B2rzfAQQjXqNgfn6pxcnthQcbNRa3un0LWqDtbpkUQU71zT/Dm?=
 =?us-ascii?Q?ZFMAoHYT5JoF1ewXrG0O4Zo43Udl0mAv6lPZb2gprv8z5tPiDz2Etum2p2aH?=
 =?us-ascii?Q?rJ0oyZkwkJuDqQCDlGJ+ZsV4mEWjfP2YH7wAI1i3CQh7ORf5jvbCxxOLfjvE?=
 =?us-ascii?Q?MxVyO6BKsbGVTHABpDOtexY=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02125a15-45a0-4fd9-aaf8-08dde003e1be
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:09:03.6292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CP8RUGTdWp9yFEWBOK4f8qQeHjOh/GWRRqvudtY5E9zAW+wRpkHJUsJIZeESu4ZS4NU7y0Kj13ZHGVtWBqf5TBjS24ZDK1jjOW1lIQEwn6LOLuwV6MmvOH4jS1L3ERaj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:09:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19897

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit b56dccafda941dba44b02fa3b41b95feacaff9f3 upstream.

Move the `rzg2l_cru_ip_format` struct to `rzg2l-cru.h` for better
accessibility and add a `datatype` member to it, allowing the
configuration of the ICnMC register based on the MIPI CSI2 data type.

Also, move the `rzg2l_cru_ip_code_to_fmt()` function to `rzg2l-cru.h`
to streamline format lookup and make it more accessible across the
driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-12-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../media/platform/renesas/rzg2l-cru/rzg2l-cru.h    | 12 ++++++++++++
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c | 13 +++++++------
 .../media/platform/renesas/rzg2l-cru/rzg2l-video.c  | 13 +++++++------
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index 4fe24bdde5b2..9b1ba015df3b 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -62,6 +62,16 @@ struct rzg2l_cru_ip {
 	struct v4l2_subdev *remote;
 };
=20
+/**
+ * struct rzg2l_cru_ip_format - CRU IP format
+ * @code: Media bus code
+ * @datatype: MIPI CSI2 data type
+ */
+struct rzg2l_cru_ip_format {
+	u32 code;
+	u32 datatype;
+};
+
 /**
  * struct rzg2l_cru_dev - Renesas CRU device structure
  * @dev:		(OF) device
@@ -150,4 +160,6 @@ int rzg2l_cru_ip_subdev_register(struct rzg2l_cru_dev *=
cru);
 void rzg2l_cru_ip_subdev_unregister(struct rzg2l_cru_dev *cru);
 struct v4l2_mbus_framefmt *rzg2l_cru_ip_get_src_fmt(struct rzg2l_cru_dev *=
cru);
=20
+const struct rzg2l_cru_ip_format *rzg2l_cru_ip_code_to_fmt(unsigned int co=
de);
+
 #endif
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c b/drivers/=
media/platform/renesas/rzg2l-cru/rzg2l-ip.c
index 7b006a0bfaae..8f9683bf31fa 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
@@ -6,17 +6,18 @@
  */
=20
 #include <linux/delay.h>
-#include "rzg2l-cru.h"
+#include <media/mipi-csi2.h>
=20
-struct rzg2l_cru_ip_format {
-	u32 code;
-};
+#include "rzg2l-cru.h"
=20
 static const struct rzg2l_cru_ip_format rzg2l_cru_ip_formats[] =3D {
-	{ .code =3D MEDIA_BUS_FMT_UYVY8_1X16, },
+	{
+		.code =3D MEDIA_BUS_FMT_UYVY8_1X16,
+		.datatype =3D MIPI_CSI2_DT_YUV422_8B,
+	},
 };
=20
-static const struct rzg2l_cru_ip_format *rzg2l_cru_ip_code_to_fmt(unsigned=
 int code)
+const struct rzg2l_cru_ip_format *rzg2l_cru_ip_code_to_fmt(unsigned int co=
de)
 {
 	unsigned int i;
=20
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 401ef7be58ec..37fea2bed00f 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -301,18 +301,17 @@ static void rzg2l_cru_initialize_axi(struct rzg2l_cru=
_dev *cru)
 }
=20
 static void rzg2l_cru_csi2_setup(struct rzg2l_cru_dev *cru, bool *input_is=
_yuv,
-				 struct v4l2_mbus_framefmt *ip_sd_fmt, u8 csi_vc)
+				 const struct rzg2l_cru_ip_format *ip_fmt,
+				 u8 csi_vc)
 {
-	u32 icnmc;
+	u32 icnmc =3D ICnMC_INF(ip_fmt->datatype);
=20
-	switch (ip_sd_fmt->code) {
+	switch (ip_fmt->code) {
 	case MEDIA_BUS_FMT_UYVY8_1X16:
-		icnmc =3D ICnMC_INF(MIPI_CSI2_DT_YUV422_8B);
 		*input_is_yuv =3D true;
 		break;
 	default:
 		*input_is_yuv =3D false;
-		icnmc =3D ICnMC_INF(MIPI_CSI2_DT_USER_DEFINED(0));
 		break;
 	}
=20
@@ -328,11 +327,13 @@ static int rzg2l_cru_initialize_image_conv(struct rzg=
2l_cru_dev *cru,
 					   struct v4l2_mbus_framefmt *ip_sd_fmt,
 					   u8 csi_vc)
 {
+	const struct rzg2l_cru_ip_format *cru_ip_fmt;
 	bool output_is_yuv =3D false;
 	bool input_is_yuv =3D false;
 	u32 icndmr;
=20
-	rzg2l_cru_csi2_setup(cru, &input_is_yuv, ip_sd_fmt, csi_vc);
+	cru_ip_fmt =3D rzg2l_cru_ip_code_to_fmt(ip_sd_fmt->code);
+	rzg2l_cru_csi2_setup(cru, &input_is_yuv, cru_ip_fmt, csi_vc);
=20
 	/* Output format */
 	switch (cru->format.pixelformat) {
--=20
2.43.0


