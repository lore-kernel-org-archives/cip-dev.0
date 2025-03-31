Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C530C36014
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:46:41 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.14])
 by mx.groups.io with SMTP id smtpd.web11.48817.1743417997231010548
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:46:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=JLIxlcoc;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.14, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4m7LmAOqeanwesx0XhWOYNljqJf5VkrOM9J6aP65us5Fz/+jwJDR6tkv0arWSEs8VCJs1DCK+UFtJDAPeI22nmEoni4mEyv7AC4vBt24jnP8kaTx6nsxOy/i3O5EGpnT9t8qnCTzK20CPQbbXpGEJ7xBTC1OJpvaOOSbn95qB1q2iXHY916QvNxFuwzgeYhyWa54W7M742UlXNG6pCHchKdU2vZYU5iLWRUW5xL7tXAd+EB75RhXcZcNvinDlmEAovPNqakf3/6u9nLCvYsVwTSzxPbo003DLOgjN3z1gUXYhewsvLXrq0WVFh+OgfuyLz9REOB+GU50blt+Ql/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiUJ80mJQQkcEcVeG5cHRZGdPnsJv7eNh5zkMZOSrzw=;
 b=gui+TwkRpDHvXn/SGoOVWV5FpV/hHWZ+O+XXAw5wmVLI8EAYE9ymLW6Sl8ZCyK1aP+yNK37nOLV3kGpGX03x/CyOvQET34IVOQquUwjCIw4QBA7aO11PFcircqjAk7NNPmhy/ZET3Fedu0NBK3qv9dUqNPeyb/IztvIVaJF39RHd95FsE5Eikd1iBPNkBjvARYj4rxvd/H6KekLWWSr04KZe+Rz6HZsBzs3WV3nv5oVTdVk2C2+yU2Rb1Zr5g7GRdye3DkR6DmHw6QQE5JEBMKajNQ7NpYunjQ0D6lh4M1RYqQuQQV5punxf267u5zeeaZEaSsPr2H8jr/YzthsIGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiUJ80mJQQkcEcVeG5cHRZGdPnsJv7eNh5zkMZOSrzw=;
 b=JLIxlcocpSW+OT70AG+2I/LHNyCNPqv1NcBsw/JQSsnoJBo28z85YZkoN9np1XDgcDwFgsWkN8fsjcAFJ4E04m2xbaYvwaU3Tl2N18R0kRJIrrySbb9OznZpsts/XeaNCoF8iCv0poUIaKwG7VCis9Dze9uwqYJCgY18IjoJbFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYWPR01MB10032.jpnprd01.prod.outlook.com (2603:1096:400:1e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.36; Mon, 31 Mar
 2025 10:46:34 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:46:34 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 21/43] pinctrl: renesas: rzg2l: Adjust bit masks for PIN_CFG_VARIABLE to use BIT(62)
Date: Mon, 31 Mar 2025 12:44:52 +0200
Message-ID: <20250331104514.79090-22-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYWPR01MB10032:EE_
X-MS-Office365-Filtering-Correlation-Id: 6448f24b-153b-4af2-8505-08dd70414e10
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ayFT10ivliTLiddmWNrPN7Bm1QsiM4rKgyIrkmnMgU+yubLgo00F/x3AqGEJ?=
 =?us-ascii?Q?bOpzvEk3nHBOJThQ3qF2Et52PibIVc0IRjiZF1qu5UW9Jp3ZJUlv2KJAPdMT?=
 =?us-ascii?Q?p7T8CE+zFspoUmJj5OPYVxSvH9iLycz6uJAPVuJAci1tFG1NV+ruhwnnwKg7?=
 =?us-ascii?Q?8NuwrKD9Rn35ZPX+da5DZNYRpMgvlRsYS0i0FGFBzrsjwKQfwpeIlJGgLHOt?=
 =?us-ascii?Q?ptAaSYqUtdBtluQgaY7kjXdWYgrWJq0eUDFypI69Yuh6CbC2uTfFq4jKRx9S?=
 =?us-ascii?Q?awMB9vy3mXHBTQnjEU8ST8F2x98xYVmooTCPIrzgPhrrSQidTr+NAIiFfMQm?=
 =?us-ascii?Q?Atw4qvNZYbFEV3/1Hg/+OoIgviT0MZNWr66Qpyk5nMhbL9iDCDRjEQKHxeGE?=
 =?us-ascii?Q?7XPacX1ExFvzD4Y9uhe1crJAA9VA4kKKJN+b97xwY2u3yzrnlVehmUTFajbr?=
 =?us-ascii?Q?ZcC35xYQjKjAme0P6gmtp39oBuNe50hgW4EtJ435tTQuUHsuNkMOrsV38SOq?=
 =?us-ascii?Q?SZfnSmmklnILsWKkzRW3hC0pnJNZjyN0SDcKThVm7SPl8vXglyHaTG55HLyK?=
 =?us-ascii?Q?I+aRYg/YA0U7VQO/qNs9uXFIInZVaxV4jn+QoeWzHHJRWQtRVjDMSyKl3zYV?=
 =?us-ascii?Q?UvqO4QI/BQzqUcnM2farrIPsNYnPdlD9uoACEyAeUpxTUVc/ybuXKtRo6SA2?=
 =?us-ascii?Q?U5PInN2zgTQGW1pSLnTGYunuvkPM9XBzJPjwfMoLTZcNTiUWIXzFIubTJXhj?=
 =?us-ascii?Q?35xLvcSCC87O1YQFKxl2IFf1r6YLsVXsB+/dM5FYJUQ9tmB1XNYBw9/+6mKJ?=
 =?us-ascii?Q?t3+/9WQ3wwmUfHmFe14JV8exghK0JCSjU2nU+0fAlL8795D3lRVUoXder3LU?=
 =?us-ascii?Q?eb8bTqSOK2T2I/rdbZAgzdT7JRQBqA2Ujya6XkSZjg5PDN/ANh8IgqqUgwsu?=
 =?us-ascii?Q?hX2C2FGdrlQVeeAO28jn+cZrsLh9Plak5kIk6LAf4miIPDmausnHa/xNQoJR?=
 =?us-ascii?Q?kLhst6LLHjOwdKy+JT6ctbmccqjkyrCyydLvVxGQVmTT1PyGZi6yCs2tcHkn?=
 =?us-ascii?Q?YkCPEUKPBVcrg/2U0qBdVN+tRMio+RpvqQ+qNdH5EMgBE4WTqMQD4jTyPGuI?=
 =?us-ascii?Q?g5tpRKg7DsX9UMrFwi0QfycUn6S0UcCZNUyKpb5PsTfCJUDwvdypbY/xqILl?=
 =?us-ascii?Q?FPe7MVeSQE/tYuBCq4mcL4jR6y3ySXzkkXan/D3cUjgRmUsgP37YciO0v0iF?=
 =?us-ascii?Q?QGSrGFOrBN3sQI/qOaZTGcpkGWWJUgT62+GYaOv5HUL3uC8T6jJWUU5MnOsJ?=
 =?us-ascii?Q?Y2o3Wm+i8l/phr0tT6+HIdgt1uGKkyCY3T9lSO1t9jUfwLKtP07YtrbvhXZ7?=
 =?us-ascii?Q?Om3UbHZf6VJZoiiE6S0hQHY6QSOhLzmFdr9xl+zPdOVnNyVvIjpVD/G1h7Qh?=
 =?us-ascii?Q?SlwkGRqmROd7YIrzHIKtOxMOJSqLQJdHZIUxlNbPSpjnPAg8QMr3JEpe61LL?=
 =?us-ascii?Q?ZCTg6fHp8tP67+w=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sAKRQSbwM6wjYa5LZxF827UBMOr4ssUUKI54EuNEr6A4WOpASz/5b34J4Ygt?=
 =?us-ascii?Q?LcLvKJ+8wmwmCdeKlEZv0/dF/2qR2tQRhlBWZMyDB2DccKqIi343hnepChuC?=
 =?us-ascii?Q?6qK0x5Kqop2LAJnb7Sl8WOBzHGjKstGIpExYvInTDFOFAOk0CNrc4Dr82X25?=
 =?us-ascii?Q?wQR0CNED0Xveh3eDGzbGj20qglwGDTY9M3UnvXNaEPwWE7b6m5E7bSateVSE?=
 =?us-ascii?Q?CusQNWF8a+izQ9p7lafEF3LNyYiUsCBkVbOJNZKSzOGVhuGYjkm1bZMVPFX7?=
 =?us-ascii?Q?v4NcIoOfihlDge9Nn5Oj7h7WW1tgSnaATuTitCiQ6xLyw313vq8t+T/d8Bez?=
 =?us-ascii?Q?j50d0gwDhDqGP6GSjn7sRLaF10Hv/0ROKcGF0Fwh29I/I7tGswXUVpcJcmbH?=
 =?us-ascii?Q?/QX7cwh6LdueoNqcdtwNHfLCaGA1xQiNvtuDe0HKPpUQI9+qLIhuUPbkLXIL?=
 =?us-ascii?Q?WMPc//BhWsMuv9KGmy8xNlzGslnXLpt8TEsys+4o4wRxoYmiDnY+O1nXWW3M?=
 =?us-ascii?Q?E7sytYnTOEjk24mpAZIdZ3ePkoAiggqL//1+0HxyB0zeKDbf6FXxhh27xute?=
 =?us-ascii?Q?2pRbQPtZE8Y5s2CQlbw1xufY5XY+nK2SqYjBvL2nIlBmK2iFFoD8eF6HZn5o?=
 =?us-ascii?Q?i78xPApZAZYwCoA9NzLPPgESAyYt3tpfztYKo2gSy69M0ln2DbISLIE1rz5y?=
 =?us-ascii?Q?0sEm7DVWZ8dv09SkEjVXzwseqcMSmV7AxWQFMxhrKQqQBPH4RbGvolwTwxII?=
 =?us-ascii?Q?gmMC/WiweWxTLmldwz+pE8a3gD6axeR8J9gQ0GHlvZJX27g+E3oVNnSoNYgj?=
 =?us-ascii?Q?5qpivpky3NfHpA07hmrd1X1cPqZAmQ8kcoIFx/ekExvLiquEkxp3F1jWM89k?=
 =?us-ascii?Q?HnhNK2MZd0F6sSD1iqqf8TgPsZoiO0FkQKqjapq580NufHXxsxlWPNddvQ9v?=
 =?us-ascii?Q?zTW2Tu44viQNWQSa6A7s+/Td81Gi1v4c5RJ/OladZqSFjiCtkZga8CHKixYz?=
 =?us-ascii?Q?OxQYcddsDsXcUFtFSnmXr0qaKyTf7x85qvCloQGgmoltjcleU1pt6NrdfaZQ?=
 =?us-ascii?Q?P9GcEAuPLb0Y/9umSiFMyRMzbSPZ12/fE7DWnbjK8HkRfEnknKy2R0fnzuDB?=
 =?us-ascii?Q?cmaAFgeSszb/QjKdOG4KGuteDteL5Eoy+J1QWvjCQDt6HKFM1kLupb33n2Hx?=
 =?us-ascii?Q?KWVIhd6nT+MhJoT02T7eHirk0Pp2d3nOjs0QncVQqd7or+n1hfoUlIPDXlao?=
 =?us-ascii?Q?ixgpm8Qu7GmhvmG4J8DzmCYIiYBxRuCagA4N1LkV2RoS7n/3erCRPb7/cdod?=
 =?us-ascii?Q?jAoVzYFdniKN1DAZAS6QzG+dyI5YMV7rwTeJNnzX/koUOrOzYYJtaFzJitUk?=
 =?us-ascii?Q?IDpx2iRrY6M/hZvzzFH1Q7Vw+oaNIK4RZtinLW0GxV+lTJCSwGYeZK+zZXuu?=
 =?us-ascii?Q?iKIJ6PFei0sUBlYR+rArQ6sTnCOJKpKf0qB8U1cSRBkGIiu+anNo3YKz372T?=
 =?us-ascii?Q?wgXps70kC6VX+TTQ6sSdbTM+H+FT/yrEn71tgM0E6DAzbjOSvTBWsrPKR3lW?=
 =?us-ascii?Q?L5BfvAms11FfbJ6N3nyxLhfT3Z29k+p03zjbRBQbiwwEsrtForBB+5+9sHuN?=
 =?us-ascii?Q?+1fAxGAmnXKPpGD73hLcblM=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6448f24b-153b-4af2-8505-08dd70414e10
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:46:34.2407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trnVaCnrdCP1lLKBF6qUNqahtovdJPvvvk6wNpQjHLWmb9qjXI56lJDyxJfJUdoNaT3lf/t/N5wi37qFfu1J0RbQbLBlojb1jVDzWf+909Yfcbh45aZpUtgEf6OkNI3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10032
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:46:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18409

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit f0cdf878a22b91141d6050deed0eac70ab982ebc upstream.

Shift the bit masks for `PIN_CFG_PIN_MAP_MASK` and `PIN_CFG_PIN_REG_MASK`,
to accommodate `PIN_CFG_VARIABLE` using `BIT(62)`.

Previously, these bit masks were placed higher up in the bit range, which
did not leave room for `PIN_CFG_VARIABLE` at `BIT(62)`. By adjusting these
masks, we ensure that `PIN_CFG_VARIABLE` can occupy `BIT(62)` without any
conflicts. The updated masks are now:
- `PIN_CFG_PIN_MAP_MASK`: `GENMASK_ULL(61, 54)` (was `GENMASK_ULL(62, 55)`)
- `PIN_CFG_PIN_REG_MASK`: `GENMASK_ULL(53, 46)` (was `GENMASK_ULL(54, 47)`)

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20240618174831.415583-3-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index b4ad4a4d20463..2a8223a9e226b 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -86,8 +86,8 @@
 					 PIN_CFG_FILNUM | \
 					 PIN_CFG_FILCLKSEL)
=20
-#define PIN_CFG_PIN_MAP_MASK		GENMASK_ULL(62, 55)
-#define PIN_CFG_PIN_REG_MASK		GENMASK_ULL(54, 47)
+#define PIN_CFG_PIN_MAP_MASK		GENMASK_ULL(61, 54)
+#define PIN_CFG_PIN_REG_MASK		GENMASK_ULL(53, 46)
 #define PIN_CFG_MASK			GENMASK_ULL(31, 0)
=20
 /*
--=20
2.43.0


