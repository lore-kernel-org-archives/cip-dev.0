Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03ADCF6AB7
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:31:50 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.2])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3059.1767864701788187293
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:31:42 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=N7k4rgw+;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.2, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q04GjeiH6gG9gvxitzhkwzqZL/+1rqBLE7sPayZcsDahHGwlR/osuduRjlGb1Gfsa1vJhyDwcqG6Gxl4Pcrm+3rnerG2Y+quJQbHqJm+K0DObg7AvQsY/qh0LxL4YxCX/cwB0XWRA+Ff3NZKh7aHq8RR0JYSd6yUiSHaqE/+FrkcEZMVZyxexRHUyaNsYxIKdCwsoWKLXNSrhZlZfCbalrzuAmp+GNvwjCRxylF1dkHkeGCgLoKhXTjL3IytKyPcsY7ae836o87aC6himnWTJP9snRkLxLEzYC2R3AWUysid/YBvLvIOAKNxq1iYRYEuznYeYugiVtOBz0iCOuxzmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/I3wOBh+ER3t7/+wxfU3+NqI4xdIVW7X9UejWknkoMQ=;
 b=OVJp6G/nN0zIUOfRffD2VIcKVckteOvvxVhF1fk1e8lu9OV8aKmpvV6TQGKIprTBps4S30YFTn8dmvyQ6SPUc9wltON5G9kcciBFV5IIvwneRIQj0Y+TPq2l3jSw0RatUyO1zDc+EPF5x7qulynlThzvsefjxZAq/PPKSyrtM1RRnPTg8cO0OyOuJOTIMvnTv9FWTD7tHyw3N+jMgnpu+FeLZf4Ytt2nLr0IALNtjftCaIR/4AIxJ1x67w3iRc7RotGgkVigxI2e6XWarxEbCjFqZ4zQlbvUpfmK3P8FL6Ztoj0Dxq21h2+/06rJGbuFB9XunuJZqulpLb8u5KiCZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/I3wOBh+ER3t7/+wxfU3+NqI4xdIVW7X9UejWknkoMQ=;
 b=N7k4rgw+fwaMdvLSwvNyI1gwx17UONZFzF/VaMjzoq7NfKpqobpT+yUxFrt8JChPmiZOzYSiVjy2coyPQCrQ9VqOA4GB9eJqyfHt5U3bJsscZhWP56IksghDLg5isyZ2ahy6rdX/xaLHMFKzmkAvaqyR0i6RFnvkuPtc19QRRPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYRPR01MB12872.jpnprd01.prod.outlook.com (2603:1096:405:1b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.0; Thu, 8 Jan
 2026 09:31:39 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:31:39 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 19/19] hwmon: (tmp108) Add basic regulator support
Date: Thu,  8 Jan 2026 10:30:23 +0100
Message-ID: <20260108093023.489513-20-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::13) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYRPR01MB12872:EE_
X-MS-Office365-Filtering-Correlation-Id: b76e6ce5-c4b5-4f8f-2522-08de4e98b9d2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?uywAFlLlVsnPc7mtrjZQ9yZxXQ6Oi/Hv2xRKfS5RAfIvN/4m75fBZncMAXOX?=
 =?us-ascii?Q?+frN1yqj1uFlCSBlayks01jbdkQ8HjI0n42Jf8+qjq5mYvgCi6PPG0xWsTSp?=
 =?us-ascii?Q?lwIl4JjwujOvoERFuRZZGjjxGNpidVMqUB9lxvt19p5WOxMwTwG8FiB7bQwy?=
 =?us-ascii?Q?QT5h1tPtFi3TZyR2vpnV+U1zZZw+6eBE5rdaALk4Yx09A1x7OBlzXW16b25v?=
 =?us-ascii?Q?7kI2ixjXIK01agr8t8t6wT6Gb3eBIOb3hf5VRUwA1PCzDmR7cN7gGswzJVcf?=
 =?us-ascii?Q?0yRVQDqiMrEKRC/EQ9EW7jaKzkts67o9N7obOnA8piEd+Ia5APewRIk3xkO/?=
 =?us-ascii?Q?iqJ/ckzBaWRdz6NF6hIurke8gJbrjX4c7X4noIz6+K9WGZv/8+QDZY4PkTKk?=
 =?us-ascii?Q?gF9iFFBArpQrTiRIMKRQCcYDEp4oil1KCndTqyHb1tGZvxJ+pFncI3ffgJ8/?=
 =?us-ascii?Q?K0Of7aw5tMPtl0TjJHdLr+B6Y6QEHSEDe4Tk4E2PT8eSrCPZV25h3uztBRt9?=
 =?us-ascii?Q?GQ8HX70w000wAcUAhteMIdGuk5s36dxe92776ml0Y81jW8Ob+EhX+aAS6Lbj?=
 =?us-ascii?Q?7ediG3yv28ZsoxEIrknmoRd3qA7+2lQMjsatpo8k25zF9xd+lD0uUd3pEIV0?=
 =?us-ascii?Q?h0Wef4h5+8I95D1BNEFcpAFhyJAHJUW0ey4Ro7+/Tce9OIVoZTanxOoeG7N1?=
 =?us-ascii?Q?JL9zAiXT+VZzif/R2VNQ0CagkCc+SkJcF/bki5QJbdHxgZf7IPTPFyjmMg7X?=
 =?us-ascii?Q?oZFqT9NeJAq8NTIAFn8Qq7YGuJHS1Fq4fPMiFc6KR0nFK1y3rvxZhv4ZSHYN?=
 =?us-ascii?Q?YYnWWt6bmpC60Zipeofs+hjiGBnl6Cs5qlRGzbrv5pqUGyIX3wm8HAjyKHm8?=
 =?us-ascii?Q?Mq/MfC3BjVWC2fFkO9IELsgKT/OjUO4tIOUq3dKCIu5oGSX5qG7Hr/zIafCS?=
 =?us-ascii?Q?jzhh5qgjXTAm7mi/pSpsmg4FvUf+QrSQnpg/7jq5XBDTeAuSPJuyJJwRdMVF?=
 =?us-ascii?Q?nVSUmMicPo9HaNC/S2Ov+4PtsLwkE62wxYLlBQJC+o5ELKSAKmNCqEB+PSDn?=
 =?us-ascii?Q?ijyrn6ttDjcfJEi+FdsZJfLhzkRhsAJ8JCCWEORimFCj5rl3tccfklJVsQTr?=
 =?us-ascii?Q?1+mq/Tc5DqSP/ck5AGrY4xu+GnIdWOOHEP/ooar6MgWLve+7io8pF45QGLdl?=
 =?us-ascii?Q?4nOChgC6/8hsTz9rK16HikxWrEddxQvweYsfRQYDyRC+AkFm5WQLBDp+5gb0?=
 =?us-ascii?Q?XFZtYUzGdvG5mnXINUldksTo0oi16MrUn6hrnPHcz5WiaQ6Yd4MAZDtHD99H?=
 =?us-ascii?Q?5ZFrlvrlAugnXtw+Gez++joinLtopVgAC+h5TDFdxKmOc1wHkR2ItqFnYQub?=
 =?us-ascii?Q?qEDZb67LLSZsj7vce3M5KW3ebwRXYGSlKvDO8ClQeuRgOZH+jBdOzNIdn0XS?=
 =?us-ascii?Q?cDGND87weUNs4Lv6DAqSmTPJcMlLSz3wzmLIsbMVXkJQoFZejGE9L/OEBHXZ?=
 =?us-ascii?Q?7E0FjpTiwakbTmXNFFtDjC4XBDP+MFAuriRo?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kI1quB66PY9taVssg3fLEh8Ej6nycwL/hx3oYoyDiO02ZlelhbjjYiZTr/hn?=
 =?us-ascii?Q?iP/M3vU1SYYNzQ4a5OaC2qvg7L0lvg066Us2uemI3nj+y9QP0kK8DcgUx6J4?=
 =?us-ascii?Q?N+LGbHTBEm4GXfmoCy+X6MhspphAOg10eKdMCyeXS9+MDaPN49JkpBlG+4gQ?=
 =?us-ascii?Q?XU92FI6WDrRP+nvLri0oN8M9BysQcO9ZPLC8hZLzFwhzYxFhZoc7cmjjmkuY?=
 =?us-ascii?Q?VdN5lyvckho/sXmhqnVyQ8QEZWQFAC1JBkhbxoFTdXwuOGQFtrHaM7m+jIWu?=
 =?us-ascii?Q?wkqyx37k4024HLwUBTCkKTtDO0QhEbGmQTqAPv/s9tuVZJXxZz9ND1C1ze7E?=
 =?us-ascii?Q?vmm8gtNrbnMz39Bfa+lkMg4p29RTDLCtEJqkPxeqTCyxRhzvaUnABGrd6Azw?=
 =?us-ascii?Q?T0GT/yhvd+qnJX8i68nMSVOxQSGKMRnahJISoPB4L4DuBE6jpjI+eulgVYmA?=
 =?us-ascii?Q?iueJ+btFvJh1oRBoojp4u7SQPOr8aBCKrXoWARU+RKslLf3x7j16vE/PC2j5?=
 =?us-ascii?Q?HgIShTenh0Q2NRF0isChGaiVfmVjs1JI4CIChJQs4ktxT/7muZoxhQHTQS6O?=
 =?us-ascii?Q?u3x4g/v+C6uqaNkaZKxxiLFf1y3EK9xBMsVwLFteVcsJwyZ5yfetoch6F7w1?=
 =?us-ascii?Q?RUiQ6S3VXny8m4Sc8EC1Ccrw9lz0+MjsLEHGOKZkU3e5QKrP+Q+XH7WMiG94?=
 =?us-ascii?Q?08VNkNpZQIGYruqGN9ogbJfGPP/5x5Ruk85+TuL6p8tnLuOCy24IWEAu/NqZ?=
 =?us-ascii?Q?wwd4Km3bstx5h8a9NFhXcpVdfy6uFwTigHDH3A3+zSU5n/NU1962MGPe0dbw?=
 =?us-ascii?Q?sZwSHV0rlpE/5ryXjqIjZOcg2mlEoT+wfmZ44yXl2qDSnSOsJl5vb/u8iuj2?=
 =?us-ascii?Q?AMN4ZK3vxnCsVTOCvRYBAAkRmnnELdhuP+szoGwrgHOyDNJ0MH677bQgq5sV?=
 =?us-ascii?Q?i4aNbxBFO1szMKtbMMr2fvq+04H65zuepRK1SnDbjCLGDnuHL2FBv9SNLGNf?=
 =?us-ascii?Q?KIWMiCqmflzGmhLvynSR/hHQ/eR97VWWB3Rw5lXKEYT9U6jx0arq2WjzlaTi?=
 =?us-ascii?Q?9LXD0jWJ5HiEIVk5bWdCAOt1Aqg6Xdz0YvEV6v/C8PuD7E+UKNK2rWfwQ4IU?=
 =?us-ascii?Q?Kkn8/HmO+FG6PWaitGWXm8HrsP23JWe2fiZzdelIYH3B0ymn4w8rKB1Xzmmn?=
 =?us-ascii?Q?ogu1b/YEvNeKRzd//WC5VB6TJTEmVtcrSWJJIDiCpWy1+r/Jy08EDDmt4+j8?=
 =?us-ascii?Q?nQ4N2RX2LZqnmN+QYgo1FViAQFbIDAogYhMhoUuh/bMMmAMd37ufBKOufROb?=
 =?us-ascii?Q?zETr+yeqGHpMkYdYCt+gXoAY81lrjIsJNVYLZLgrJh9h4CqnF8k1y8FBHJfS?=
 =?us-ascii?Q?C5HxjGqi1ev7ICGrI4uwlAk50e1IHNk/nK+FKZofSSZiIjM30Qrg+MhuuhHy?=
 =?us-ascii?Q?q8vi6XZ/aXDQyjd3H8gDuqJlAHFHFV+Q8uSd4pWlUAT37BBhZFuvBBUM5jVi?=
 =?us-ascii?Q?88HJWLJ+295A87z8dLStj+ymcUGh5AYs54fRyWAyWsk1prVczGz50ztaFw72?=
 =?us-ascii?Q?CdXt8y7kaAZfIiWqvVuyPK7qIR7UMcxNLuHVpI6MDBuseBwg5MC/g6GduIjE?=
 =?us-ascii?Q?Zi7lFtWaGaTxjcaEi4b6FMGUw/sXaDOPSgoKWB2NtUOFlm4UCGUwZwz/CCdl?=
 =?us-ascii?Q?sOVtO38/79XpqsLOcbvOGi5OqS4wLQYkZ8NrkytCRygh80wiQvVpOq2u9Til?=
 =?us-ascii?Q?nyfmRPn1mvS+NKxBI++FKyN+dFwDtImk4EzREXPKKzHDx48nc9oH?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b76e6ce5-c4b5-4f8f-2522-08de4e98b9d2
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:31:39.6580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MoQm5WKufQm/h8IEdp/l1YJ/qE3lWOx32r50QrKOCLjjJvOaqcZ1xF/V5gawPQEQdh7s2FG3G6NHyqTpRnqAd6wOhazERrCzkyS/GvMbS2NIMwklC3lodd/d7S0GDtl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12872
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:31:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21478

From: Stanislav Jakubek <stano.jakubek@gmail.com>

commit bddbb9cff4ab97ad367692201a0abe680a59d44d upstream.

TMP108/P3T1085 are powered by the V+/VCC regulator, add support for it.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/hwmon/tmp108.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index fbe673009126..cd631e481d80 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
=20
 #define	DRIVER_NAME "tmp108"
@@ -331,6 +332,10 @@ static int tmp108_common_probe(struct device *dev, str=
uct regmap *regmap, char *
 	u32 config;
 	int err;
=20
+	err =3D devm_regulator_get_enable(dev, "vcc");
+	if (err)
+		return dev_err_probe(dev, err, "Failed to enable regulator\n");
+
 	tmp108 =3D devm_kzalloc(dev, sizeof(*tmp108), GFP_KERNEL);
 	if (!tmp108)
 		return -ENOMEM;
--=20
2.43.0


