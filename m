Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850A8C44520
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:15:50 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.2])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13209.1784294147058521316
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:15:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=iU08IphI;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.2, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYUSeW4oV4+pDzqMpdU1K3glic54JYAckJr82HqZCzNDsftOAvNu9H9kfQUTtZkIr3Hiepsgov0FFdnA1NOSI4kuHgTYN3KpBGcXXSg0Xpny14K+1qy4xNg5TrHf3KmR06Mhw1M6FJ/tB0TJrGUqTTcoGCgLsL+iZJiSisnV24RbL47R49J+gSwNUrObsm9cNCIhwT0sbnVVSm0Qd2683Mm/1+OfRKarAeT0hOE0JjpqzWQr2/H249h+4N2B1r/CvY63EF77oFVJKqhNLAdeEkM1H2RIFpZO2xnOfqulROyGb6x7ETFydFRGZZEKINVtlmPqt4JVDHtoNEU09wzfPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cu4ko9MqArGxhbfUm2GW+6kPqt9wU1xunoJjlGdAI4M=;
 b=oLx9ziL2V52OUAdBbVz4PN8zLXiQr87hXI83w4WfWnMkypofVHqfooGTN/imgtwsjTtA8BXPWJBa9Y9In+ZoKsMufHqh2RDj1LE52rACi1gsBOYQTH1Vi+7bBdmcQZuhQLuyxIULGkinZSJYUu9gZCxVO2PQOC6F6reaCNCrKV7mFMUnQY7gqRtwtAfNs6+IiR5XdykCDa/qW+ap9tpEaibi8ob0wr4M47VWvy69tMH0zw6XoGGxr8xG1Eg0LPhJTRaxQy7VqJBk89u+Y1m/LD797eSQ2NwCBddosCcUPo43IkUPDnAGE19uCZ2VCjkc8cJeZjigREGoA7v/Jf6k/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cu4ko9MqArGxhbfUm2GW+6kPqt9wU1xunoJjlGdAI4M=;
 b=iU08IphIXuWQsU2/9cuShNfjpOUcv9BZK6FR434cu8T47004ZhGdsxe+ig1ERraLpsHanGcJfcCgQllHSNPaKHDMmV9rplRxtq+Ju4Ca2z5CEsria6wzQ7t7LgeupwdYSLJj9IKiSUR30LbgeW0tOk4ae+Zlx99+fuREyx0qcX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYWPR01MB8447.jpnprd01.prod.outlook.com (2603:1096:400:174::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:15:44 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:15:44 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 07/15] dt-bindings: hwmon: lm75: Add NXP P3T1755
Date: Fri, 17 Jul 2026 15:14:54 +0200
Message-ID: <20260717131502.2234020-8-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717131502.2234020-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260717131502.2234020-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::6) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TYWPR01MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc04794-d190-4c00-2cfb-08dee4058225
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|52116014|38350700014|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	NscHqdRjwNyCx+LrCvlTmJbVfB9FjL1sfwTzX3IsHPcwoix4Dy9N2/SyEnNFx+V8VqKjfKOvaoWX1WJ5Xwq+rPpILX+0UBtJPsK5ei8/CltaIGkq+GdngtnxHUNEW6JwMCziZcI0m568wcg+0YBGBhvANzA0328aSRaaY2EDZhuhEyATt4yalA3vJvo74ErKizp7GuRe2IclwQ18e8mJXpeNvqajFRWuk3ZodL1Gh7r7yT6bNyyCAyTUc9oRPGUGroXsRS7aViZgY85WaKL+g/EDGQkgs6I4mo7fdXa5kfMMUHhbK2Aw3CtZ2/lNJevG1y2umqa/QHLN6F138I2LpZECMp5pIPMdPtGafdbvGYkPYK56TOdeOeEzZGXq6aHs1Alwl/X/HLntvUbhoagXFZCg/urJWxc/7FpUiCynq72qHLu6NJFruBNhQIJuaQ9DN+dUV+775/oQGy2laFgelcJj8T8y1ru6VKU8A3LPXz3EcwWI7MaI4X5/XxuovFB4mE4muOoBVWjeJtXmIffTNQjddN/V38cfqT31HCFtngnPZzvsfbKCOmX3QxcYWEdO+5lOvYQrK3SYzZ3jIlR3DBDkt3sl2CxGaTRrowJHRBzF9h0CylSlQCslERyXH9FfqgI6n7I03G4OaU64ILg6D8GDNq6rkNBo4w25sZoxSFe5FLDsdq8n4A9uye4J1lLWJbSNM+rQhjI8uz0XdT7SIbnpHa7mxlyiDnghM4f9hSc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(52116014)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dwu1z6KpZO7DxME5rCrGA4V6wk+TOFKfeiOHFKyVFMyzI7X2W+18tslb0te1?=
 =?us-ascii?Q?8rIU0sBgEWDtO/SywuOE/iRpnI/zsFbxkQHi1+Ux6sJs5nfvK4mnkRyP+/V2?=
 =?us-ascii?Q?z1Nat8vZJcK9geC0AfBkVu0JqLjdbKPb3MFV65gJ8lsd9KkPwGYj8vQrZeqv?=
 =?us-ascii?Q?CM9aByR35VVLl/OyBA8G4S++wc1sMmidYvhs2c2UHAaacfc9w4iIvj3y0AZ7?=
 =?us-ascii?Q?8+Ir0jVcR6okgZGhfmNLQCbqOaxnk+Txsitf9AozKQbrnpqViel+c3U1LETl?=
 =?us-ascii?Q?LtRcC3r1Okzqnfq1u6JdMNyIWqLSXqV58Jn87Ze/fXMM2Clwr0bBRN4WeIWu?=
 =?us-ascii?Q?Tfnm6NbPfod8eCgy7gUoogf2EXmHZqmudXKWu0fHfmrHSHLQeklokK3n1iZ/?=
 =?us-ascii?Q?m0Hw/w5mPqsK5VZZrbVx4duflSAFtF1YAHqKHLssbOrLLesjKzEA6lJS8Cmk?=
 =?us-ascii?Q?NxRl11W8vHCbV4J/plSDfkf7fE7t2EMQSQ/qbwfRk5aOah7Wppw39AJjXOJD?=
 =?us-ascii?Q?moNbfa4c2oU+LAC2N2CWFYZMkPUFOwo378rMpIcSq5pQA5OBr4RX5JZwbQQu?=
 =?us-ascii?Q?oH3Pi9BBQyLa0VJLc8ELGMZ5bji75N87BLYiT+YkJkl58Tujag8ZmuZYE9go?=
 =?us-ascii?Q?Xd7MFrLzwqiebjD2vgCYHTYBzb1jXoiDExuHIDVIwIENxG+S0lrG3EulMiIe?=
 =?us-ascii?Q?79feo0BSm/s4d6Y9F0fn7Uom4k8/HjS1Z4zNr2xeuibAZcBIJQJok9rVwzxV?=
 =?us-ascii?Q?74Ecs1XhhSbMAho/9QiPz6BJIgMnIsnVpawHuyOTzngaH9uHXaWbrUIsuLqt?=
 =?us-ascii?Q?A+gPgBRKBwSiI0j2MSBCa83hrP1wpgEXe0uEpiVQboqpUm/jjQoY4ZEDSqSK?=
 =?us-ascii?Q?tKyaXcq7iVCldPFjth0cpfxFP55hyoZidgOwtU0sAvOUqTHULp280NyetSc9?=
 =?us-ascii?Q?lSpY0PAnVsDhRrN6TY76Pwkac/tIRN6IkNLegbzB9ago34aArbCL69pAKtq6?=
 =?us-ascii?Q?Uo1T06AKyjix6mRfmAYp1cjpNkiCTZWiOMo6LeUrIolGUtJbJsOeYs5ssRD6?=
 =?us-ascii?Q?wLzj25CM++RU3w9SBByswsT9Av3v3fZYqMjPiFlzNqzeDWCWfixjpV9lzxNv?=
 =?us-ascii?Q?A9Marzrr6KTXaOQx55S0o35lQmRQIH9mJ/iGSVHNrfLvNLQJbLUivkY07BSi?=
 =?us-ascii?Q?A85B1Sv00rpKfAxFVpFUFAoB854TZ78RvavAjcSHJv49jvvlBUCwv29mb3iA?=
 =?us-ascii?Q?mZP7GKt2xF8bVoV64XNXMHuNXhOa2vg7tk5VUE52ATvtkq4Q1RMwAzhlpZks?=
 =?us-ascii?Q?OXi6ykEvUeIFkNHvkmXIUVYpS2B0fEKs4zEiIffRiCuVn8rtar4TQaIuPVXD?=
 =?us-ascii?Q?aP6wr4f0/RgdHu1mxX6qHrM2ZYQpFgD70+mZJhZOxsFMZAHMjjDAhZKKmaEE?=
 =?us-ascii?Q?Nqu2vN96Zrae4hozrKyZ/i7veaFAu2Zt3nhnYJN3K42oXTTulSVlmVpDVa/f?=
 =?us-ascii?Q?7cpPUSe7Ig2OqOY9sM1tn182aaCwTsvsIBBcEnK73Ef6ofHoFm6lDBeT3A/h?=
 =?us-ascii?Q?qec3p6V/kzgWOUeX9SPP/sDvDXpSeyxGGGYaynVhAQCeDp6+5BbmLQZtS+K+?=
 =?us-ascii?Q?joxXHvZEgTsktmXQLrtf69cwAyW1Wxdt0TzLXP5cRe/HWbxyU8cYp4izfL+H?=
 =?us-ascii?Q?LDSGp3AzUKfrfQTdZq9O3g6u4DBYVq044KEZc3b/974+0oSYSMKoXcVe/Vj0?=
 =?us-ascii?Q?GKExbtrKhFUk0dmTR1y/Pq2cIUD3IBj9YEj5ksvaKrxA7fDBL1up?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc04794-d190-4c00-2cfb-08dee4058225
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:15:44.6345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oe84FSXQm7RmGpUDMFnLSI4wEkK4gZTXvBVBdF1NOz0atiaSvUMoYdLmXjNb9Zo/Y32ZFDUvEVZncdgW0LiCgSRTP2pwh4CTQUMCMmmUhYmWQ1Ni6AmCJ5k25nDm0oPR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8447
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:15:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23659

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 844029c59d44c590871b93fdc9720245a71f63c4 upstream.

Add this LM75 compatible sensor which needs a separate entry because of
its default sampling time and SMBusAlert handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20241218074131.4351-6-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/devicetree/bindings/hwmon/lm75.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentat=
ion/devicetree/bindings/hwmon/lm75.yaml
index 29bd7460cc26..c38255243f57 100644
--- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
+++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
@@ -28,6 +28,7 @@ properties:
       - maxim,max31725
       - maxim,max31726
       - maxim,mcp980x
+      - nxp,p3t1755
       - nxp,pct2075
       - st,stds75
       - st,stlm75
--=20
2.54.0


