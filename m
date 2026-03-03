Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22257EC0472
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 09:22:37 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.10])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14378.1772529754382664367
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Mar 2026 01:22:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=I2ivjzlW;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.10, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrMs+tEYBrZNHLybX1iXu5IT+9nZOz3YBhfz1cPbCqmXSPPEMVnNM9St54wvAvjep3GyWxIHgguCsumA/y5aSgqpGNB4XrJ/L8Mctla2XDZM4Lg6l2ZVwaVfH+XnQYbL9uQ98BpyoTOyRSH3cXGWDb/tX5bzLc9BSkr+Pgh+wiqW8W/MKNEn3566Hjn+7ZLq/0hGp4juPNO7qOJHfxaKFLg2ZpiAJftyhdalr9APgYsRIHH+BQx/vFU/Favf5oC3Ev0JwwAMJeASXmJksb67gsoPs/dbpD6X1wj3nm9P9or5QN44KtYtybo0LhbT0gTbnZ8xMIlyeD+Efn8ojubMYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lp5uCBhTTv8YjLIkN9msWuGO/mWr5fYxAIWCbFYttIk=;
 b=ZoZi4FOVj9wBLyR3Qw1XyKo9V/+a4Av3ytuJ1PU1JVaGf7fGOtLdzCFeimk12LBYo8JSBUFaeI1qL3I1GOIZadPMa89Ke6LazwJwv92a5JblfKPYwgWlw/+fpBHw75LL+ZqKvyq4OWO3am9G/WdPeLl9Ovo6kAkMJIM3wNc+1bs68rlZP0PUauoJX+zIOHaPUagszB7t9W4m7Z2w4WS0ct/8ccHhgFwZ/m9lVCk/yRF9hYRt+L2e1ImxmF3EvvxOUxHfZ2zb9emo/FD1ylRPKnWmOOIpyxh2w1M8bWdjZUFBdvhgHS+2Iedu9STwEz64uZNMjGotLFvizWG4mEalSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp5uCBhTTv8YjLIkN9msWuGO/mWr5fYxAIWCbFYttIk=;
 b=I2ivjzlWs/MRzFsQTEBka0ZyziVglYDTyg0fYN+GUjZJABxy0vhy1i8479P5ILzgLTNWKD3Pvld28eBxIBvQeHzup+txhc8wVHqTa9jW2k1+YTQd9OF37/vn/IwkuGGi4KIn6Ye/4JQOd21UMS4q1rz4M3aGmvGxMrYpimBI4T8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYCPR01MB8342.jpnprd01.prod.outlook.com (2603:1096:400:15f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 09:22:30 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 09:22:30 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 5/9] i3c: renesas: Simplify return statement in 'renesas_i3c_daa'
Date: Tue,  3 Mar 2026 10:21:36 +0100
Message-ID: <20260303092140.12732-6-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303092140.12732-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260303092140.12732-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::8) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYCPR01MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d1d438-5b49-4cbe-2c59-08de79066113
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	3oq8smwLHGoKR91zyqB1AaAluIWJJlxi1SnT65jwMZ137L5EX+DAHMpQCfsV/04E6xznqT+QNLxM1Mv6dGooGhIjQ9YgipPpqBzF9kJFLAZ81SaM8i9VzP1R/vxUMkusm7X6RjdrX74fLZNdb1Dj+42TZCvQ5QvSaUFVjdM7JitLEHJA5lDC3IKXWLboG2c0fQstCAWyN3KPHwsY8SGWTYpYvtRtqVG5+FHkNFR3FX6MZNIjs907txjy1RRgAXFTaaQ1r33d49n/d2jQI4lwSmg+OkLQwrhx+4bhjYC/5Ok7/6YQ7qY/wc8tmFAQBEVDAYwFVQfp1Rtoh1eggAysOEuz9pHOpd2Slwc3/rCUzob1gxVw9iK4dI2rrYppWsCyeGYm0xeSbCLpzQWbYqc48ZHuuo7mTn6W03Cbw98FYVR4DGsLf4wZ8ub6YgOoFteRtb+ZhlqA2RSW9p3WCBY+Vik5paGv1kOCOWXBFXriGA2fZmaDgzfsJ668KqLYF7LhsTRNMk4ubzVbgCUKgQ6niMPl6+MWr34CnTSYNesihb5XitkxiIOLeWwa8/tmGF2BAZQNZ01ZydLj0Zv5HHhFr2shUBdlD97e3Ipfctvd5lFbUh0jiz8hlQDd/oWASJxqz7/FtG47hNj8VJVykU39EUbMSCeYj+/z9Ta65pafOH/GuclIsS1FafMNteO2aLCttpL5MEfrU09GcOlReIs+3O3bmuToqwkydIs5O1AVGQeyrEyr1kgp1oqcMPk2/1DVe3/yLlzBr/s92+sKqGXueaGfo68nHgaB1iLVlWZviyA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RINi55A5X9fWeES+Fzq98c+6ZvUiwWXIW9WWYx7AmL7DhYHM19Uz+wlyawkl?=
 =?us-ascii?Q?hA7oXqHKLyN7bf5B6ulpUC77XjIhuADR/a76sMnul67/1UK1s86tUNClLfbV?=
 =?us-ascii?Q?z7xfm3qVt5cIWJCeYcLtJMhGjladNJx3ALz+8zrKYcRbfKvcFzgYFWCCZ1EX?=
 =?us-ascii?Q?4hEyhUb/WJwE9PJFcB+hQ4gqw/WoJRrpYKeisQ3P0MjPfiDltq5HyEvLOOnU?=
 =?us-ascii?Q?lZeKP2EY3wuAmg0BdPf1g+rA5q1PHsN/JS6OZwq4hO4EzHo96FDfxV13PdNn?=
 =?us-ascii?Q?VBM/F2lbdN6QV4X/phj36qi3kzX/NorTv4gf5RAlzPIsRkVGjiWD94BvMUd7?=
 =?us-ascii?Q?zX3Z5ywrq5VbsZdOiPzg3IK2L7JGybBD/Ci9qeXmFD4pzvuA1ghdn5OX4ghr?=
 =?us-ascii?Q?tNgy/dsXLpkbWvNlTBfjWUpVrqZ3s1AgncO/z9xZmcaQr8a6HX8kxVfr1eUj?=
 =?us-ascii?Q?D/EEBVy45SOAetGnkNx0tUUufADIgJuff3S34j14nPyVvR4t3389Fw84qYJF?=
 =?us-ascii?Q?RNCZrfjonAb/H5J2yA9irzULmp4kj2OnFRGkNxtf23mfMJYU7pXQn2Krv/hT?=
 =?us-ascii?Q?GUnH/hKXBsOflLqVATEBdeDrSSJHlo2AIzzqWg4zatGKktu1ojX6+kfJNjIz?=
 =?us-ascii?Q?914WWSrYL76ARBp90Zu2/gUv8i6HKXGPe+3jKnaAdPr/IXl/rAn6CgLbhT0q?=
 =?us-ascii?Q?JRSXUBi5R/WG083le5SjGKPtTox1T2ZbnB19H8mwt1Am+yXikwRihB4lA8K2?=
 =?us-ascii?Q?2lL5CKE0jMAWnv9Fvj0LBy36fNkxre+yXW9hdmYxi7rwKz8Zw02xttZMQmin?=
 =?us-ascii?Q?YvSaj4cRzCB+lC9KfmK7fsBMsiCpbl+LC3/y/E+Ye8sDXPNlrL7RaPbCXmF+?=
 =?us-ascii?Q?/Ja/l80x7P5mFMqD0aFQ1CmiKuFoFfnVjxGssQdy7m5D8zc5jIgvGCw28ZXs?=
 =?us-ascii?Q?GqcK7tB01er7YNH7HZZg+ASBdkqIIkNtqKrBa5U8sLCfLP5i2/bCXM2nCAEj?=
 =?us-ascii?Q?pE5YZ89ZEPOJGdaixe37+I4jLPvRFshem8m4+RGcrSLilqmz6ldidb24AyMw?=
 =?us-ascii?Q?fqdspUSp5OwFNNgKbYD9nlcL3ab1Iwo2m4rGS+zXCYCHBQC0KKi3TU/yQ2NM?=
 =?us-ascii?Q?ij8ZvEAeyrZwhyK2QqwWdqX+f41pCTUdveFrN8IWphnlsFxz5cPf2cNfFXaK?=
 =?us-ascii?Q?OFXfLdSCkdcXBZ9O2+eNSFzdCLC4fKO2KTWvfQNC8QqU6gnHKKmgLwfqlw55?=
 =?us-ascii?Q?aU43ufupxLjBZcVD+KsjzSEnWlRBj9yYluw5a9TUosOdUAnVuyNDJDIfgdSp?=
 =?us-ascii?Q?rcuIiyN+JJn7bVLbWPADLAYIp3dH1IeRJAJsU0/JbQ9T6I+DvQsvkEyo7QQC?=
 =?us-ascii?Q?LPaDvygOxt1P+SQYTTmhLpbGGuIQGxY2iZVIWEJf/C8W84FcoKPvqSwpkXcC?=
 =?us-ascii?Q?uXFWsPgMD0mOWNuOwIFEvpBIYRCIFRSoXOxjBad1ckqLik3FbLf+/7/J0MOu?=
 =?us-ascii?Q?IV15RL5I8YJHr54GHdHDhlOfRpaHxpLAWZLi6xbysatHk2OiHhA+uJcC9fZ0?=
 =?us-ascii?Q?yoSE3/AaENba0DGkRpw3kwvgxJ9c9P3ee8VD35f/eJGfzx7ZrjBrpWZIqu7f?=
 =?us-ascii?Q?bRZfHgDTN9qEjrZanb3FZ3Eg/DxIslL3hNSPgUvCwDP+SdobeJyc4kI0IOAr?=
 =?us-ascii?Q?HSp1iGKVeFgEIFEOFLluFvdi8EnNsoK+COxmBqFXkAqZhEtvSICUzxT3e/ku?=
 =?us-ascii?Q?Y/v1w3nJBCHcQTGcctlADONVVJSkwz3eODbqfD7zwHA2t7wY3RKn?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d1d438-5b49-4cbe-2c59-08de79066113
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:22:24.4791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rit7CnqmI52Tez+MIGcdrKmTRVfmRO+BYWdrLbU8A4e+o83aORIkTqtS9RLHHAJt/9EdnjrNq9dAZ6XslLNRsGLqB5ZaUPqzoz58YjFqfYKZtaIHi3TpKABsWlDB1Nng
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8342
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 09:22:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22046

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit bc7dd24c114e37c67061f4651bbbbbc57106c617 upstream.

There was already a bail out for 'ret < 0', so we can always return
success at the end of the function.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/aIyzJ7HOENL1qp1l@stanley.mountain
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250803211256.18513-2-wsa+renesas@sang-eng=
ineering.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-=
i3c.c
index 432be328a4e4..040376903a98 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -682,7 +682,7 @@ static int renesas_i3c_daa(struct i3c_master_controller=
 *m)
 			i3c_master_add_i3c_dev_locked(m, i3c->addrs[pos]);
 	}
=20
-	return ret < 0 ? ret : 0;
+	return 0;
 }
=20
 static bool renesas_i3c_supports_ccc_cmd(struct i3c_master_controller *m,
--=20
2.43.0


