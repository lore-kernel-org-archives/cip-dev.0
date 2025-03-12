Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99A5C35FF7
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:15 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.54])
 by mx.groups.io with SMTP id smtpd.web11.34843.1741778773964270879
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:26:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=V8T3SzUT;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.54, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPRDKC8qGtKwXYD1Oqhf3fWsoTQ3vANtr89gVmHaphItEitBfmOonFg8zxMP9NsHuptnxj3eZKIwzQnBdSwzi4sZ9RhSWJ7QinodZ28A2/q9evFKFdgM6XLMCEroca5NBkrMSXyC9U2xib3Ik0DVakujjfGzgA1TY0b8bo3vQ1eEG454gduu96aDBWzypDvUInRsmO/EsAmZls1C/QXQ0h0gU7vl7MRbuT01Lc4BsT7L+z25yqIZYrqWBkOJ8CIqxuV5siYVN3eBR4FdobM8dyO/8pJ3eRHPJCoevcJHFfgrkgvhNdXVZQqEwjAlvnc3n5yydjUI9OFDx6THVbDKWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnCmc45gfuHlDXqA9YfBKAAwFds3vGiixtR2mAX/99k=;
 b=LS7KllEVRxW+lw3RNDGHqLV1GvkczVjeNaQZfSWFo+qQRuQRcUZi8vTTAtxCPT65aDc4+rG/AQ/0KYRASvQyQtT5p46H+xNs/DMMbnaGBE9V8WbAtj1jVFQCy1LvgIZ9xC5ft0cKAxIK+VLdr9DUafFNT5gBnBsOJzN0ahES2YyKq97s4GHPcDSbNnZInGVjseU/uXLgLTe2sle6PjrPjCZIP1ciJeYZqqbujKVMNPPcBQ4C4zHz1nsrDHExdm+9WQBwSIIEhVxVi68zAFXFEp34Ao8p5QmH96a6+mzRFeq4TjDlolC9g45y5IMB+l2yb4/9owBWNMOYvpJ9sRz5tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnCmc45gfuHlDXqA9YfBKAAwFds3vGiixtR2mAX/99k=;
 b=V8T3SzUTtXPcV8g/8K2PnqLfCR3R6OfzzWlCAqHofjz4sfpA5PkmQSb4cpFeJIoU0pd5fdIo/yJu+C3cAmuLudMdbYez0XVYAOaJ8ZQRlKR2y/i6lNrt9BjVmwWZmO1Z+9LjaYK16vPXYFc3I+EWn2L+zu3V2kHX6Q3w9apa0Eg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYWPR01MB10982.jpnprd01.prod.outlook.com (2603:1096:400:397::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:26:12 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:26:12 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 53/85] pinctrl: renesas: rzg2l: Replace of_node_to_fwnode() with more suitable API
Date: Wed, 12 Mar 2025 12:22:30 +0100
Message-ID: <20250312112302.1605750-54-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYWPR01MB10982:EE_
X-MS-Office365-Filtering-Correlation-Id: 1585d66c-3a17-4f0c-0d43-08dd6158b190
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vZzerwAKF38t7J5mK9Buhfzc7hxqVkYYjzr0ixUxG6J/NTn8Tpkw6HMAfCpv?=
 =?us-ascii?Q?dUBHh02R0+Fdkr4S7XSW7rb58nnBmZH2azGW7ZOIlnfUJFn3KBj2ajW7b9yP?=
 =?us-ascii?Q?0oIKLwJYMaiTb2dgJnRwepRQhSqGNrXTJkem3UPA5T3cfK+5/hcptH3uRlCN?=
 =?us-ascii?Q?n1gt+1XtF+KyiqTe/PGExx1oYFt5btMngvEZNldfyo06//sgHp19ucuVjiJh?=
 =?us-ascii?Q?nAcRq+2oJXRKCYuIpc90yzofb23+SM7/mWgI40+Tw860lmpv3pYR2ganiIJY?=
 =?us-ascii?Q?UX0cQiIVNYOIgdI9S6THN9rxZzY7lslDlJwi2smtSeJFRYJ9xp5QJYMCK5k1?=
 =?us-ascii?Q?/EtWUr1KMORi4mXbsj4N+agbIaiPzNg5tiW59ZOB9wkdCllJoh9sEdVph3iK?=
 =?us-ascii?Q?8+egYCsEggt3jwkPKMx6Av2pmfp01CCq0DSYQwkSxPfRFNUAbZZAVp+bB5qH?=
 =?us-ascii?Q?TMy+DETg4paNBXpikN3D2PL/AbDJbtsIubzNe/xo4znoC4xV3+nSiDoce415?=
 =?us-ascii?Q?4O4kJRkDO8LCVm3v5qSDZPqZDI2MPcPRnSyo8MLqrvxZGIoewo6Vfr6nRwdA?=
 =?us-ascii?Q?bJNSof2fJvubnWv8+tc1fQ8gTNcqPxYvvvbueFqIzODdivk15SG6U7H56Bcr?=
 =?us-ascii?Q?wKGx/LlrNRZPhJms30xEFGoqb3Wstwk8E77I0SgGSOMzfXXyhLuyLq1/aDxv?=
 =?us-ascii?Q?UlhYB3Ys4r0s/w7wyd0Xad62VObqblH4TS6geM2ZC/of/5FpVPUkXJ/vQ3/g?=
 =?us-ascii?Q?zaWJ4F7d/2mJStJBP2q7WyAZetD7dH4MC3g6V8pUxQC7auVH835XgDrurS7k?=
 =?us-ascii?Q?3lUcE3Uc0fGVjZ/6LIEUN+G/LsYD8dBIfpXt+K87oeEDp+8ntGFl8eCUp5n4?=
 =?us-ascii?Q?EjJAC9GcABHedOuvtqzDZLi2FpJvxbXsfTB5agHN74GldaGRJICxS+gXDf0W?=
 =?us-ascii?Q?lwV2hBO5IBpkCsm2qNCl+GLkCkCHS+U/CXiLfU5UObMU9jD5Qppo03b0ERmJ?=
 =?us-ascii?Q?PkNCvxGJ/U1tIWfwSSsufz66RToh6owMcjnD1TuzkezEm0LUCDcrK86h9Ici?=
 =?us-ascii?Q?rccSBWLd/2Di54urA1TV6uCzSiHkF89NlKjLadjsUFWuBU64JbbSy0ENEyLH?=
 =?us-ascii?Q?tly6ttDJ3970VNq3kESmv7UXE8l9vWVjU4hifNc07pkwiEysrdehpjCF6D22?=
 =?us-ascii?Q?UnOmhpmLjFb/oFIxYwjoJ93HlXV+o8vwtsZ6Ku7ZgU9Zt1He720rWUgtDS4F?=
 =?us-ascii?Q?cn9Y2Myi+I2gssZ7ugVbUpw5VU2DBwsco44aMeuThJ4Kp/cPo8c69s+2y1EW?=
 =?us-ascii?Q?WbAIHT2Aq8Pqd7V2RAWPF3kSzwU4QEwymSE0M1nCmtjaZ5suu0pAK+unt25L?=
 =?us-ascii?Q?iPnoQWZY9wmQjspyO751moadfT6Vmt5oanpUU0Zx/7ckSR157GhnOHymldsa?=
 =?us-ascii?Q?ZjLq3kLrj2Xl9Ksl2natDF+aYPWkrbyO?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mN9hJIpSR/RKOdpdvEWHX9Li7iFJLTkGyQYuaf2IFGWpRkQwqX6YO5E0F+uc?=
 =?us-ascii?Q?KP2HlopAnB7JPJxsBOVEp6T/1KwCT5eADyhmoV4lbNBicjBFcSdYK9MOsTLA?=
 =?us-ascii?Q?3RS4Cr6oXafGWHrybESVmPgUIgOGpzuUZF3XoKLmnOvOOkn1hv1Vw6D7dgtm?=
 =?us-ascii?Q?qN8/0MGMNfcFRVXy2XJUkaryJhe0lFJ1YF3c+Ey8I9QWDcXWJaR9d8bpwOzS?=
 =?us-ascii?Q?SxSPftBhi3/lnQFlUUM66Q/g5A1ZP9kBJWe48SA0g1YDCf/50p6BYqq8tQ+S?=
 =?us-ascii?Q?MRMsAu2mdWsBxNJGbBUDtvLvYEYOBCUCDnIFOB0M0tFLURmqogQiRFtzOI0H?=
 =?us-ascii?Q?y4UpdypexDhCweBN1jwazMMbpxI4ss0KvYAraqbFW6gFCAazVHta2OkKc2d9?=
 =?us-ascii?Q?0XuBMsp35Z+jyhKyadR+GfQkVvP391q3RjJQviAj3X/Ysus1lmzNNYIHksbK?=
 =?us-ascii?Q?vZKyS1HLYiPHS7OBOCcEyC3qwmZ+9W3CG5MjnXAh8+O5EeZOg0EptxKNFB1w?=
 =?us-ascii?Q?MG7udhX1C7bcwqvbZmAAFfnzub9tm7j39LeD9KjA7kx7KdbxRa5lAiaTqEoY?=
 =?us-ascii?Q?n+bcBl+nZ6zG4p49QZCskVnl0bNVIFs5pX+PfHWcEFVPl61rwvDMp0pX2tpi?=
 =?us-ascii?Q?q2iR3PIUDetFif1l5fa2dY41vUkHryYJODfDU7nEWh6arDcXgB6htGBxlsT7?=
 =?us-ascii?Q?It9OJm+RJmPjPqHCaA0yi/0oHZGCBiUwmBcY7VTECS/ZwIzrgzMM4QzMnnKC?=
 =?us-ascii?Q?T7pAVk+Y0HrKTwt7mwMzGOu4WtKzLJdjNcWRQob+4xpyzCzg9HrU5kQ3Ek9E?=
 =?us-ascii?Q?ZiHVzGpghOUV7jftpcNZ744hHAbMlPG2vHHjhj8SbcHDc+R9MKx4IE+t7+Sd?=
 =?us-ascii?Q?sFpPEoNhmJF6qQr6c143Os0iTp+17PtOqN5E1G5E5578j1JZtwTR9oYLPuP3?=
 =?us-ascii?Q?TbnWSgKrknbuDKtuw6I+htOTaqN6e2KUIAtazFWKTqqh1QzWdOEYQ6EICURZ?=
 =?us-ascii?Q?U5iwu6rLwJoM4stHadXg+vt7+W8Q8wIzWNSAOmW6u7cu3PG2dorZiQh4Ne93?=
 =?us-ascii?Q?ESw9V3QuDJxmXZ9bzNNGO3o91A5cJe22iP36Z3vKciahL7tPzyazeOcH95Ab?=
 =?us-ascii?Q?BAJ2PR8ZTl6el9mNwgZmPJNhMFFeeC1EHJH48Z+a9+lx5ske0ls6e/ezqPsM?=
 =?us-ascii?Q?Lr+wcQWaSkH1cnvG65cArkXWpq7ZHFKIwYpzD5c1/Uk+NmsWKkwNI7d3wXR3?=
 =?us-ascii?Q?aDDVIAkxQNDBK52NK65QtvPNif+wATySJZv4eeFP/ay0s6v4Zf4xJ/fxodJ3?=
 =?us-ascii?Q?NMlk8W9PIj6zC1WgY/1jl5kVErDRJvJkT1LAIVEgg2Pok0OePsbdwLI+PP1m?=
 =?us-ascii?Q?X8+7qCkKkj5MMFxfffoblU47bXzC/T/06+JvnmQedAkLdFpmVEgX6ibKuQZU?=
 =?us-ascii?Q?9FnLVnskExhz78zXShack3gLyliWcwMCoJtBQGpZoyy6BWrhEbyLm9dTq2AE?=
 =?us-ascii?Q?6g3EWZeotsFnKJcNlnyfyctfPTouesKNI6cFzuhiTlwvnaeJtiQctrcrthux?=
 =?us-ascii?Q?Kh1kczk4hkM73aP1B/2cCy3kpibvd+mrQUklSvuCKqsfGrwWaliv1qefEZIa?=
 =?us-ascii?Q?nDXzuhIENI1R/Ztfe1fBzMw=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1585d66c-3a17-4f0c-0d43-08dd6158b190
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:26:12.1616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GW80iNySpfC2D3eipzm7yjVbnn8aKtxmUl+AP/SJ8rWMda8bXdX6yAeE71cGF/NiZ2KhCaJt+wLUWvmN/Baxa2UdcA49rWwZ7U+EfFT5fjApOoIrHi+KGUewUq536EuW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10982
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18145

From: Andy Shevchenko <andy.shevchenko@gmail.com>

commit dad83b9527030e29cc3148f7274910cf40fe7f1a upstream.

of_node_to_fwnode() is a IRQ domain specific implementation of
of_fwnode_handle(). Replace the former with more suitable API.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240822230104.707812-1-andy.shevchenko@gmail=
.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 4c111fb27845..bd739879055a 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -15,6 +15,7 @@
 #include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/property.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
=20
@@ -2623,7 +2624,7 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *=
pctrl)
=20
 	girq =3D &chip->irq;
 	gpio_irq_chip_set_chip(girq, &rzg2l_gpio_irqchip);
-	girq->fwnode =3D of_node_to_fwnode(np);
+	girq->fwnode =3D dev_fwnode(pctrl->dev);
 	girq->parent_domain =3D parent_domain;
 	girq->child_to_parent_hwirq =3D rzg2l_gpio_child_to_parent_hwirq;
 	girq->populate_parent_alloc_arg =3D rzg2l_gpio_populate_parent_fwspec;
--=20
2.43.0


