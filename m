Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733F5C44516
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:15:50 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13328.1784294143903091978
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:15:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Y10px1KD;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.41, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCGHYVWPy1J0o/2mQ61MFrHEtUFfz/zL60a/GXKUKpZx/j2m6Tvhs9Dyw9FX2f5o4QOMPyIZna6ryZUBN4qmMhM4Pe32CGEKKUxYHjg1lZfaqBgA/X7Ny1SsThqN8Yma1Q6H3/7FEOaIdOqJcRWKsbAnJIQz8J1b+zrP+A0fzU6daR0/C17/HKxGI+Gw7B8KygxZIfik8AgAsRglVS8RQs1Ik83fJhSXkUi8UkuALOU2/XyP3iXcFfxbgHeTxNbTwZXc/3c80VGx0KMKposFT+vWsV8j4KYME/j6At1/fYwgCEChf9soTv6ePoNkceBp2X0KlO/s/Xs+LUF28wvQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9wIeN6qGPdiagqkogVoDpLeReukKj48M1Lm8LDmTlk=;
 b=nVEgUnmSGIP9jWk0SklWb0ciGK9/Q/ulnKYcdkMZhEqAUGJVE7gS+1eNPlIl77WDMGKaAZEMadbqDpGF+x46VlHtWsT5aKwvRiuH4VJ+vK6eGqBD6899/ev0Ez2Sp/PY9Vs1IyOZ2nK6oBMIxyQl8l1W2X7Qwe/Gehz+g59x7osgltQb3/3RMKL9nwkCHnKR2e9DbLWsm1Wm+/SaA0qU5cu0cD0HyU40G5D03KMabtC4Y2hvBo49q0U+uzoJZj4kLzRj+cRWrXwblRcqQAunt+UBAlTYk/Ux8WStJQAMhkXGD2AA260zA4vLE/WbltPmJ3mmWmECnuENP4vFzarr7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9wIeN6qGPdiagqkogVoDpLeReukKj48M1Lm8LDmTlk=;
 b=Y10px1KDookdgGQ562+FqDhEdOzsDYlCtq1o/8mjfRzFON92LjIYa54NAAhkBfs+GdCqtOMZdnMhwPsEs+ypFtUOjJ4mx7PWErUs+gqtXEQ7D6/oChrZHw2hHNrFVctnBUHF+BUuxcVZsIRzMJqU6JRX8SlIziuvsLiOu6Ty/DY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYWPR01MB8447.jpnprd01.prod.outlook.com (2603:1096:400:174::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:15:41 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:15:41 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 06/15] hwmon: (tmp108) Add basic regulator support
Date: Fri, 17 Jul 2026 15:14:53 +0200
Message-ID: <20260717131502.2234020-7-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 837d5fc1-81b6-446d-b6b8-08dee405804c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|52116014|38350700014|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	8JbJ/u+EvfVFqmfPdDqg7R/JPpUKN1QVKjVzlDu8WJqtG8V1jgkU0r4p0cFWz21zDgDzRbwMVDU38nPQgw7X7JosnrtQ4Rch7WvB/v4nGRBhhwhfHcBzVo+QDQkVw6AHhB1b2lrQQQgCp+0sb+hgbHwsApAQ1/KRY4mZv7ojo9cdtNCWLwzUfeQ87gZkqsui3ly9hBMM7DESf+oxyaqJBD1iNFtHyUodSEMkoXLdRLSYuCYMRlegudiVbUXUrZt5e3KF8gpa1pvdUJJVkLq5tP2a3zPE/jDGrdhpbyWRHPukW+BzfDbl1oPSFvz5RoFmKeZjLkSg92d/pO5oUsWZviNN4pyWiZ28ZAsrPlqhuRk3/GgrTskQShGVki3gEodpFkuSgnm4PRyn0eZnKgJRg7SdXVKJlzeMdkGlCA/Ket6wStAaL4VfNckjiEY72zFCUv9wddL56iOrpmQhlpU6C63aloxqU20CTKNvSo1GTVRyQXeA6kkdeOaXzi9UObbuIXYz5joo/LwSOtFd2Ds25Np9+ASZhDM+cRa9bmxlWEeU7RXvTKIzVpp2l2KaNxt07qi4zlPPKe+shngtTS5qUoS58nLZddkrV1fRmMhZI+jSNoZ+2QtZEfqiiO5Mb0LdQ9LcQbozWQwBTR2dULl0fbJzIP2K5vNlLTLXPvji4jRDdnXqXLXZhu6HPx033ujGJ9IYFRwofCkpyEm4L8qDFCqZgeIV/4TWbV0afuEav74=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(52116014)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?X8YmkTsXG+b0wm6bn73lHBVrALL0WV8G4UYueo7hq+HmOQ3x4CkGSD+ycyhf?=
 =?us-ascii?Q?MU4rhxggUhN1uvv5FMYAnaGgu25kd3njgb/st8ueams+xjbINDJyeXuvmxMY?=
 =?us-ascii?Q?Y6t1Du8UG6azsC9o9Q5NRH5g01kcQgyGq8/rMDki26h2IC94CxD0TwAoAP1g?=
 =?us-ascii?Q?o8MSh26uyj7PdFNRbq4QRjMWK2/flXqbpwPXhBqPBkUgcl+jnPgRozB3lXxN?=
 =?us-ascii?Q?yVT6DNPf+drFfd39EpWR6d0hABaC8N9X+6qrgHbMq8uLxcVeSiFS93Ce3De3?=
 =?us-ascii?Q?msvfsgJ2KjP9OM6SJCG/ihyocbSiklTOWGsfHditJH/REyhciF/iMBMjJ4Q2?=
 =?us-ascii?Q?+W2l98NqpvUm70dDK3UjyeIKtsHGDYZBpKQ7gW9tvSEVRR1aZ/Z+CMTY9chd?=
 =?us-ascii?Q?TX4MkdyHflhBAo9J0u3xnazc0zuBqLQ+z8FKP79G4LbMBOKv4snLK+6xCDdw?=
 =?us-ascii?Q?RxOH9gcFGRuiT0XRHBBG+qK0HuTOtQrVnqQdrzmBDvPuDrWPf7WDoodBej12?=
 =?us-ascii?Q?57gGGzliZeGH+fn8LHUza4A+zxtjnk+vTJyFz0DotP2HduYMGPuiKS5ZKbAD?=
 =?us-ascii?Q?yi9F6C9IRrk14dvW8UkXA/2Ja6wXvFJSWXxVUFQNU8V08wRuXwyzsNbfHuSz?=
 =?us-ascii?Q?Q1HNA29i8TW9C0hQQL5wBriTRCOAKYyZ+GB9/IfsHVDImYy6TiyLIv0ixjd2?=
 =?us-ascii?Q?etH5dXms8qDpfMwxc0b4TTp/+JaWdIe5uqY/5Ie6ruKSE2uGbF2infKI3hA0?=
 =?us-ascii?Q?7XBaevHD/KYB+nKxqtrtSfGI3ON2TPhy7+qTuQxUos7ZiDUnszV1h1vMxNRD?=
 =?us-ascii?Q?r5Z2Bo9Da/P8t43KvZV+q/Qh92wnIrNJKjZDwx6wK1WT/mHDSc7bod7yYdSZ?=
 =?us-ascii?Q?hFBAtWfS/qRNWkqDjI3FmL2Gi20QogZdj0abr+Vfs0XzbixOYju4C15QMorT?=
 =?us-ascii?Q?RP+6srScvXU7fQFeH71Fg6163QRyb/AHeSkqYb4lh7+j3nWtnl85O5xuTjBk?=
 =?us-ascii?Q?NwNvIr8xcGQxZ+z7+tp+FT+7djrflPC36v+kyb7BeKUW+WVXeiytT3eWH8VE?=
 =?us-ascii?Q?hoYPkVVLPywvkagf6+6geyq8TTlvLD31nRDy5L9D1DjugqIDCuuDyGfV5nj6?=
 =?us-ascii?Q?C3RBLnz5hilLDPI1PDlZ0ajia7J7u3rD6aqNhn7UGtw1ortNxAhRxnWWwJA3?=
 =?us-ascii?Q?U2McJpe/xducKXCfvEQmRICASEm6+F6/RZVpRA+YUh4FOtBvW0TuVSda2JGw?=
 =?us-ascii?Q?jjVCClYYLKf90MUgYtagOa0jgEC3BcjdlW66QpxQG+mW43eBjIzeUOy3P6aN?=
 =?us-ascii?Q?sDEX3KXB1EAUhavh6jOpdAVvPtAji7RKvWByYslCT169HMhJ3sNSd1R6Hdmb?=
 =?us-ascii?Q?HSgeSEibq3fPjpsiLtzLHZYKrvAU2KEtveoY5NJ6UpV9hDJpSda/tu3gPI+e?=
 =?us-ascii?Q?NQ0kv7MMvmRIL2+GO3vdGXJQaWneasb9BTm8rD1yXbHZmQJs2D3sB0qJgibB?=
 =?us-ascii?Q?t5X7WeQXOOI+gTTfXoiOxoRr5LBdmN8McalxssX12+iMJ4h56QQ3Bq5BiXr8?=
 =?us-ascii?Q?e8S8Y7P6lgndnujT0P9gFy2NHJUG0cTSXxc5e9ccqc5bKhey9QiJhbvaO64f?=
 =?us-ascii?Q?gUOteLoQmnOSdD/pHRgQPtkQJ/WDra56FVRGSk4RVFWzUtCiADPEfy2ZeDk7?=
 =?us-ascii?Q?mLib7WpNZRFucPhQzDe86w/RftuegX50317uAns73nq43GARi2KwNOPskG+l?=
 =?us-ascii?Q?x5x0hq9QHeEr3auaH5+OAgNzRzgDjEkgjMMR/WrfX2IELAt0sjM1?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837d5fc1-81b6-446d-b6b8-08dee405804c
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:15:41.5659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KgbytOgylHwxZMY3X0Hz+TmUrqL5G7CaYAXcH7s/YadPKIA4yptJGhjWK4nQXQgnPei7v80adquPMgBGoULBvPqAqiShdmJ7DGIogvHEzf0ne2kD+ZmBXuZ42ag/nd7e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8447
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:15:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23658

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
2.54.0


