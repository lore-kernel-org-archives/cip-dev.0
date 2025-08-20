Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08077CA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:07:04 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.38])
 by mx.groups.io with SMTP id smtpd.web10.1016.1755706019716093705
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:07:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=L3Wni8cI;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.38, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFgyXyWLj6sxhWvVcxjbbeT3B1/hKEAmdwYhWGICc69RJS94C6o3nXlX7Odmmk0XeLagyfLTsZ+TBplQ8UtEYNjJ/w5UoRodunY1+aoLJi2+8gH0VWCwUTkmIhsRhPgpub6+7EkPi+6m0SPN5sHnqddfK2rwpUueri2DEcYzR4vH/Oo6mCrDgBvzd+Zzjxgj2AIdJUGLZ85cHcvp9Z5RF4bQVIimBWYpNirw4dAk0GHMmdPunwxXXbCMg4VYAgdRfvmutvTts591LakDDp3Y42xpLoWONGyC3NLCI1qY+Kg2p/3g3kuOYMK2YjnsY5vz3R2RpO4tLz+G7/r9d12dPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3T7iqerTMRkL4coqGsozfJCJSg3VhteZuyrZWCxIwoM=;
 b=AhufVyO6TjtekrI6A+LvUblss1Q1UUV40C/G5dUXp4g7ScjZub6/k8v1f2sTu7apQk1OEs3QfvA87PiWkLp42jbsPVKY0ft6WhC89d1iQ+r3b4+C8vbwAE9snz/2yL5/M18B/xwMAO1NwgN69Gndb/1ls0dKT9Qs4Fy9ziU5rUczX34rhw9A56gq4LdCXCMFUx4O2JyXXl1yTVyv8MhCcIo0+2vrUOtGNyIRc9b1FDWNhPKnHQFqen3Wyrk6UkZTcKHd3b1ug8Z6WjwwZhauRASg33LqoCONtYSiNYk87pfeFPIgVQtpLZkHHaabuf+Vue9joKZEloysqavTqjSNKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T7iqerTMRkL4coqGsozfJCJSg3VhteZuyrZWCxIwoM=;
 b=L3Wni8cIs6C+Apmsc55U7n2tm0S7CL+j6ZlQMLAchi74oRJupyyGtKkwrTTIhxxLMbYPpROsFbXZtbDS6KgOc+rBpl8vlOKUWzX93T6E+pHAKK9G5tQCQ6+qUPITd0kF3blGlGEz2cB9JG28cFIKo5dqVQOo8ylP1wcEzeYxwHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB12116.jpnprd01.prod.outlook.com (2603:1096:400:3da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 16:06:57 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:06:57 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 55/55] media: i2c: ov5645: Set V4L2_SUBDEV_FL_HAS_EVENTS flag
Date: Wed, 20 Aug 2025 18:04:11 +0200
Message-ID: <20250820160413.801341-56-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7a08a105-7e59-4af9-e9a9-08dde003969f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?b0EwwdgPpz2NV6NEVWPZTj0WGD3GiKR79Cpra+UppX6uvmn7o8xa+g5B0h1v?=
 =?us-ascii?Q?FqavM2Qjk7laq3dEqDv4XIiXkGIc498LUEkZageI9hRwiGPiQhqlglkvBlCO?=
 =?us-ascii?Q?YEyV1gUcTZO9de2qgq+0BYTJ6F9E3yJQ8+WFL9TnCqGCTINfe+DWuWMp84ST?=
 =?us-ascii?Q?BLQt9sClRs6vhQsvLxXJDT3rczOBAWjbeFXQEb1m4kta6fkQiKbBzVyea5uK?=
 =?us-ascii?Q?N126dkGzv5QtbaZ/uhyn4PEgaLX3Aqgf7HUHZJCbtChvvoNlM8Ws2aFlc6df?=
 =?us-ascii?Q?OSJFBYGaC6fVuflal2ZOTm6ClDvzwDFLfh31weEjNzjMVMgsc9tEizhxXqyS?=
 =?us-ascii?Q?cxtwRt1svVPoyvYeUcrzfM9botPEt4witiLfxaSPp7ny9uHzdJM7gtV9rpDz?=
 =?us-ascii?Q?j2Fy2tIdOTlzq/IikkZ+cHxDVJZafjrwno8rMk7TNJTGLibv6/U1prOyZIKr?=
 =?us-ascii?Q?OSs6oX03U/7VzfouQJwfxK68JSjyNIBgO97Tkh2uD9MSZnhT6apfGfv99FcC?=
 =?us-ascii?Q?ekrZ9DsZT+vgE9f7oWtz04bbXsx42FXV51wJbMyaHHzX1eUDzo6K9ra91j0a?=
 =?us-ascii?Q?Fd+373TA8ezliH5GMQmlq0RxqsMwScwoObJU48ZWN0blhqliSLaVaSqdqKz2?=
 =?us-ascii?Q?7vXXlOZaTBP9Epr2cDk0O6dW9jQHIkF/4H/GrQK61zlxFBfXu6RWOOOmmRly?=
 =?us-ascii?Q?rFXb6je5MUbR9x3fBwRPZfrOk9B8qFaclYDFkaUUN7fyfn63svGcT1Dguh5v?=
 =?us-ascii?Q?C7AWfsx1mxPa+eb4lzE6pcR0rO6cv5X5DaBRc/A+xQK7dhvD90DmtPo8jMzq?=
 =?us-ascii?Q?DkMwM1vWsBCB2pinBA+UxoHGUiKdZfHZIX7VV4IwJdy3YWW69/NhU3jqtZno?=
 =?us-ascii?Q?5t7TuVKLrSw1mygYMmGWxmlMKxYkD9U9TaqPd65iNe5JLWrfGRtajWfbZ7Ua?=
 =?us-ascii?Q?S7ZCr15TE2KFjnp4r7DK9vnfOmLPoKUkUcH2vm17p503jkPNNhQ3KBCiWE31?=
 =?us-ascii?Q?N22jX8NzAIA3A5zwpL18/46ChD9psF97BuRNIu86c1K5V8yQO8UARL4akLBU?=
 =?us-ascii?Q?mgDPuPz/rdlRzXpJ+Ml65Xv5MyMnk8ORpJlVTSszDDuUTsnUercIk2QQ8C5Y?=
 =?us-ascii?Q?+06/nvygMJbGWhVD4Cm1ITc86RqHfE4PApyp/5Bui/1Y3KnirkNINjgWbDCi?=
 =?us-ascii?Q?pwkSW0oVyB51R4YPeKwwMaoc0BRaSmxP2IoNXnDIZYf38KvaOWdnpiKuAtBL?=
 =?us-ascii?Q?aGH+WRQMnye5OBGLCk0O46Yx/cZORYnihWAUw49vCX/RV9CdJoLtfg48wopL?=
 =?us-ascii?Q?D3QCy9QEIVWiYOuXYzVfKQaR40ojtuR+TY2ZVU5peU6qtd/Db+U5/Uza8Fj4?=
 =?us-ascii?Q?bYGwKgbR7t79I1kTVt8xN2nnYAahfqP4jIDWyIeVuxqrumnb53FDDykevQ11?=
 =?us-ascii?Q?m3hXss/XcUQIxiCwR7lsWYAdMA8PLPQIzcda//8INSvQ9l+niToj3w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Oj1x+taDV+5J5hwTLwgONFW/vCZj+wwm3yu2oTUvv1XXvGQjARSNXPPbC3LP?=
 =?us-ascii?Q?0PYvm6Znj40Yr+v65e5/CcW+lI2GmW9ihT1MmSQwXx3hyufjoOAIJOhjsAlT?=
 =?us-ascii?Q?fx5AAQtB6S5HHA1thmt9FTwbF7ih9xCoGFTGEjYSldnzOuXXE+xkRPXkd+XI?=
 =?us-ascii?Q?Z+Of9eATrqgYx3HyEPTLDafvz/Pkdfmn6OLjh7BkXfDnra6LcP1WXPYpeLjX?=
 =?us-ascii?Q?u7XXCY5G7Yuqp0/GXvjDI6bWbv3DapGNa65PHhhwGVQGYTz4vGTGGaMeur9b?=
 =?us-ascii?Q?JQArVUfVcnlUYy5hnY7hhQ090L15Ro4e6ekNEayhXzZ/2zZo2Cy0GaO1eeE5?=
 =?us-ascii?Q?UTv85J/2v5pUqUBt42kLQwWLHd0QOSw+5r+faFIaM3Ra46xuoxfX7ve3/bM1?=
 =?us-ascii?Q?1iQRf9uQL8/WkTZa+n//E49XQaCbc84Ur49M5ICEPD+ZRZjs8bwKU9cElUXU?=
 =?us-ascii?Q?LPQephU41nCRtU0SYqZfDMvWne7rccOoO/6jA4Fs5+J4d9jxa0NvmOXJf/wg?=
 =?us-ascii?Q?ie8MHzUyqHAFH6n6MwZCNdsi5wnKUgJ0NnJrEOc+qq5Z075KvqLT9wZx6VaX?=
 =?us-ascii?Q?LCVLUo84YpFPGl9hfPSXlsqR65xVvFdEv7IjBJBlgcV/q91xqeg+wnsJXd9o?=
 =?us-ascii?Q?1pwUrUapBMQGiN/FzJvT6eUlvVS22SwytyNuj3shjbgpC+5DrnTH+bmXooja?=
 =?us-ascii?Q?ow6JM7T9M7dH6iJnYImVZou591vLLQovEjQwlfAxqQbzld6DmmkTaRpBcZcN?=
 =?us-ascii?Q?/DclzZT9sjIaW9VwVpcsNsaKx+4cjWKlza21FabkpnxpUKSj7QZA2PYVrZMB?=
 =?us-ascii?Q?2jGHgrG1bHcVZFnzQhn6YPG/G6JN1cnCtV9ovwKSYEkzLCTG8PYwKrP9BPDc?=
 =?us-ascii?Q?P76ALOQmIItrn4lqNLOj35WV34fTRVPq1u71hsT4+MX4zBNOmhCZt81O9pIG?=
 =?us-ascii?Q?nSrTSvCKkxT5C7R2xLcPhGoOCIWre9CV+hbHzgzV0CDwR3VhJPUtjwXZFClA?=
 =?us-ascii?Q?DN382S+apFWaaKwIijozY4pGN80etZjR1Y5onbU8S6h626m6XWBGwMZU+iia?=
 =?us-ascii?Q?XFUrMFMHXM9PtlTaXtI3qbzcw3TyTDlPMf2w56oMAePNICgjuHOsku6X9ydN?=
 =?us-ascii?Q?dDUJcG02m1Vcq6dDeOi/3y4jqQAbn6E0g4P3mr4IFSzD85dhNpzwmGSPcUIN?=
 =?us-ascii?Q?aGpVCv+jtp/NMch7mZJQsoGV6/69euog3c+9sayXMVaFE/idWRDoDW4EdBxR?=
 =?us-ascii?Q?Bqau9CANoiB826FLQfYiRpvtiCXXC9BzzGxupb+GaBT1QjLMaIS8ON4A8lJh?=
 =?us-ascii?Q?tY2JZ1hVixmLL1v64DNLjr7RrZsMVpa1U8VY0dcf3la9qOTaZ+E8IOG6hhBq?=
 =?us-ascii?Q?eLYjCHf6z47B0fZtVOQxP8dIsC17kalE9SZwQRI2l60c1WZrvLIQATso00hv?=
 =?us-ascii?Q?yr4IkxjiSuk0ajBaJ3QMDWkdiz9iAeJBVQR4kg0LS5Rwwtvu+26aGBjHjCFe?=
 =?us-ascii?Q?pcRB4HTyPJ4HQPcrWFYOlBV8Sm3LWBuff1rnHB3BVCLkS+tb4H8QkUBwJxP/?=
 =?us-ascii?Q?1mIJxQJndrYU0fjzEFUumfIpnh2smElh9zEjOmPNCn7IVW3MP7L1jK4aPf4Q?=
 =?us-ascii?Q?hkjfCPj4WRNde9eRwJ2Ev30=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a08a105-7e59-4af9-e9a9-08dde003969f
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:06:57.6510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HABAwbmL9a7hO1VsHs/ctiyZeIUEPYmyctw9y8de3lVfoQ97qPtezklEmx7Irpi6xALNHzzzedFopkfn2cCAHqSXJXtR0F9Cf9f089WeN8bdFVyw9GnFaEoRxJTPvPiD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:07:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19880

The ov5645 subdev can generate control events, therefore set
the V4L2_SUBDEV_FL_HAS_EVENTS flag.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/i2c/ov5645.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index d1fbd9ec8532..78651e71e9d5 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -1156,7 +1156,8 @@ static int ov5645_probe(struct i2c_client *client)
 	}
=20
 	v4l2_i2c_subdev_init(&ov5645->sd, client, &ov5645_subdev_ops);
-	ov5645->sd.flags |=3D V4L2_SUBDEV_FL_HAS_DEVNODE;
+	ov5645->sd.flags |=3D V4L2_SUBDEV_FL_HAS_DEVNODE |
+			    V4L2_SUBDEV_FL_HAS_EVENTS;
 	ov5645->pad.flags =3D MEDIA_PAD_FL_SOURCE;
 	ov5645->sd.dev =3D dev;
 	ov5645->sd.entity.function =3D MEDIA_ENT_F_CAM_SENSOR;
--=20
2.43.0


