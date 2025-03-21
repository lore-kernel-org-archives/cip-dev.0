Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CA6C36000
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 11:01:49 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.25])
 by mx.groups.io with SMTP id smtpd.web10.18706.1742554901050587368
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 04:01:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=waa/FpJM;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.25, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4S1GYmeco4g7dsEK5WYFViFQsyPRjMnRte6dwPJOkz8BKprPeijtxesKkrbz5gM5FTvG0TbZMOQ0ME+GdamgVyetRC6TuOt3zs0bMgxI85AYNDSMQNmGCP0PMHVeaOVefn44qUnUyuY4kTHB5YzIqpHtBw513xF6+mIno3I+ceGpdxgSBxDFfucrYMO6BTH7silHBqEOC6sU/GutLmkNKS8bUet7tcfFdXW62edlyf6Br8/8sFznm5WS0sDtsvOOTuGl5ucHuVzvoq0gyF9+tXUEua9LgEqRclcJ9uio5qniCHl+jknCRho42Oa3pMyrnj8K1FC+bj68UFtXUgXLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ig0cQrtVfW0fN5KKTCj2zBiN6iZmUAsW4Q/Kcc1JIw4=;
 b=ymPesUJL0jItabFjVj3P0nJW6wSE8RXkPA6bjvittQsXGilZrXqHkRbw51IFHBhRgsqBy88ICuJQhxI80FeBsa9T9Gp/E1R22sweAHAkSIhadQonC0pDfR74bBdKM8RXPHqlJ3csX4sv42DIg5HN7B5mepMfq/A2UbTIBpSzTL6p5rQGFRYD014eQTGk9BEpVgSaaYi4YER6eK5B0Kdk+a18oRw51meR4lY8gfEyXIzWawjrTMKG/xA/JJPuA7Su6tDVxXVyiM4CLAkPw56Pb58RmlgQ/3kyWciOhHUJutI4UPFuYPSpA63ssSHvVKx0/T3HdWGG8GDonTV61MRuKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ig0cQrtVfW0fN5KKTCj2zBiN6iZmUAsW4Q/Kcc1JIw4=;
 b=waa/FpJMHE9j89Xz8HK1gsT6tmVFA0drjr0qjhkUPR7pJs9wlRDrqC6FBLx58YxLGd1T0RUPIXlGAqxH9o/FgomESU5GTEk0yaymRfpsiysLtBBYluHWU+nvF0LKkSYhLLa4xJy6Bv+IRCmPA1Q9hR1gthZAphOnnNucpWPdUGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS3PR01MB8652.jpnprd01.prod.outlook.com (2603:1096:604:19a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 11:01:39 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 11:01:39 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 20/21] soc: renesas: Add RZ/G3E (R9A09G047) config option
Date: Fri, 21 Mar 2025 12:00:20 +0100
Message-ID: <20250321110021.3612805-21-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS3PR01MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: ca55d31f-7295-453e-c124-08dd6867c123
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?VZ72u3fcFBZDVVeMYmqTEc145R6A7efAVTjZpBSseS837A3B1dJzDAm16Qd4?=
 =?us-ascii?Q?Be2ZnLKo+Fbv59dcnkVY8dLVi62ctB1ZBXWZv5lplvYb3R/2/62/s5eEV1rQ?=
 =?us-ascii?Q?+qwuDOcHt1289IwRx0r7gEhhdiE2fyJw2inQFo1VuE3TyQVIpGAJBa9LCsAd?=
 =?us-ascii?Q?jf3TlE4hM+yM/oil4QF9R6hIjdDXVKW0JRvnQIeb9orrg8B84xep0mJFm80V?=
 =?us-ascii?Q?Zjzik4BeDjA/VlFUj9Pjt4805JbNUNf9C/fcQEp82/lxM29hAUrW5Rj+7oC5?=
 =?us-ascii?Q?dQ1/h5XR/R+WB/FZ5P+ER2YgvKtJPd3jMCUmSDdx4d4zikZptOObZeZPE1EK?=
 =?us-ascii?Q?GKUU4BVXt0wpynxSTN+jRe02XU+PfYjzH+8mhdHTl/fqOWCd5YT0gvZnkaWO?=
 =?us-ascii?Q?mDvuLdo5CHJIjY/fZRcFryEbgfSJ+ElD+QRLnUuNEJTeGeK2GPrPs5NJJ1he?=
 =?us-ascii?Q?MyhOoEGnkA0hNRwrsyG8F/567YvvU3+Ml8QoKfRsjgehJjghM0Px56EYJhN0?=
 =?us-ascii?Q?gbaY+qtxlVxaU5656VvhOUBR5miq8d3mfhj0Vd976HUuuFDb4AzR0mnLxQ3I?=
 =?us-ascii?Q?kJZTFYzovTaRu+vNR6zt9RvBDChbN/LVTEIRqLLslYiAiw8+gLc+Fi7mEUCE?=
 =?us-ascii?Q?ObDyH7BPAuyoT+yKO9BFI8Vpn831mTDeSgz9P17P3XbrR/jfuZ4IbrHu7Ell?=
 =?us-ascii?Q?6nwAO/EzVAAk9250cf0QeZjw82QDITPgcH7LI7jvcyt2+TU7V2lmEcUU8Onj?=
 =?us-ascii?Q?VYmz6X7gcVXSq2G+HPighYjaGvrb0wIZwfweQU84JSxjWW63mGqVOzEwhklp?=
 =?us-ascii?Q?g0T/AaXwblyYjvRb795ydGSOpIfXzIkfv0TqNty5hUg60C71rNfdqVYQ8k8d?=
 =?us-ascii?Q?y0huV2YRLhvIS808/1i7IS9tUjDlpdAK7ARMoJS6wxQLOIumuqyS5mh1W2+Y?=
 =?us-ascii?Q?tq2Lk3J5BPgj/KdUEZmi8wwh0hjxjt+NifcssAwpLj0X3iUd3QvAcS1MQg/N?=
 =?us-ascii?Q?k1vqQYQWhE4cvrNStXVTLc6nogXVn+ApU6UmMubYTtL0CfK0P3H5jP8KfdDw?=
 =?us-ascii?Q?5Mq8M8lb+ewyT9ZMRRdk0RQ956A1M52Z2qTdUzYSQU/mFPSBFjvBeZya04jW?=
 =?us-ascii?Q?Nwt+lvrMi3nS0YgveyfyB5aESpI5AAQy1HP9JQObRG0Z2rAB2aqVNZDwsgQ9?=
 =?us-ascii?Q?MVNw265WqcRgvXoJlwoE0a6xgwJYsxAUrqlO432ht0iX5ZCpVvc95z3m+L0B?=
 =?us-ascii?Q?VjzIFCPVUR8mT/nN8K27K+7E4KbGomAtLwqHlWOCcu+vpSv/qaYgYJbTtvKd?=
 =?us-ascii?Q?kAxMlUWJntpRvkDbwWQwo8LYnCadt2PaC6FcZsx8b6eZ9Gu7q45CDZ5W85In?=
 =?us-ascii?Q?Ogo3NyCw/yvmSpVAcMRoHP+yxskeSJRloijn14/fYoEJV8QteD5G+Bm5xadn?=
 =?us-ascii?Q?hfdIu7uxMfhmcXmbL/VYCwrSa00Yy968?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UU0MA+Q/MlLEcns+Fa1XZFIe/RIGns/Ts815pqRUvfFPtmLoEVYvHbYSXsBg?=
 =?us-ascii?Q?xBDaGqI1/Wii6shlPwBCOWELBFqIrv5B6m72IuRIVp9U7CgOqq03lXCh3OwM?=
 =?us-ascii?Q?UZqR7IltO58hgJefoXcPzZFOnBcdx6vAUJBVWrdYWDedD2QquzDvm6lxa0k/?=
 =?us-ascii?Q?9yQIWFVIjV1fEHqIYcDaRmpi3ONFrraXQOTpt90U3SSFxpDMPJoNEwZCo38E?=
 =?us-ascii?Q?9BjT5FBOOeUogSFoMl7/NcsHV6ubVrN3vr2VXJ9eCNYtOvlosfty/zhgE8Zd?=
 =?us-ascii?Q?J+A97iSyTTYx596tGiIm1gYY4gltDqbxOrAOtRT3nX6LGlP9fo5u8ZODSJAX?=
 =?us-ascii?Q?5sv/Xws2X+1iq/AM7I1bhkC21Jl39DOHkFmXZR38TS48YsOsSF0UNqjG/fh0?=
 =?us-ascii?Q?60pLgoq3T5khrTy4j5UIu3JOHBt1Y//6SplplYigNDkG8wMJV2Us6HSfFaFE?=
 =?us-ascii?Q?qqO89eMr6J0kt2ecB5BwVFVCWmgpULY+yLs9gAFJj7tdJ3DMZbzFpLTNvB6o?=
 =?us-ascii?Q?vmxVvyS/bawePgYVNZR2K+SdXY3V0ffFHQ2owDMU6xf8RXl5/meIQ2j1UzL9?=
 =?us-ascii?Q?KPslnpNZt7+RtVMW99lCjh/QrBNl82Tucu8G1P7PRmWVqzIGQ/yv4F/pZ7Ru?=
 =?us-ascii?Q?6tpI1cco4/D39+FFaytOMvuXMKUcobOmVaaZRotAgnTI1hRbCovv9YLNvD6x?=
 =?us-ascii?Q?mE65RdfqFVY/4yWDSmUABBSFoQI1KhU3+rAsZ4U8uVrP3UdN2fQ1oxiB5F17?=
 =?us-ascii?Q?bvfyuqcYQgh4G+G4ReuC4Z42xODPW1vQ5geknqrbo4jpxPdZa7iUVZiq2o9G?=
 =?us-ascii?Q?UfyCwNOCVhu0SeTE5LiZKtSc6JLt5Hk4ozsdBPoYfqnwI9mmVB7Jcez24CPZ?=
 =?us-ascii?Q?mDCsqdumMKK7mrVTOrFZxEHzPVGmGyKQ4d3t+P4jZDqNvDVxlSYYFSEsfMIr?=
 =?us-ascii?Q?KF3tJozg9tCv3VyW3p+1X0qiN6vSyZs8Ov95UkRoX2/zWsh8Nvzf1s3eBfg1?=
 =?us-ascii?Q?ojp+WrVeCvXGcUxtbCclhvdX4N2ZgT32qv2+YZgwMdQtvRuzYC2NSwu7OLBv?=
 =?us-ascii?Q?7xwAh9gTszo3eNu0I34c4gmWqroAZ/jEekWmkOqSeR19YSCAAORgrZKSMQeZ?=
 =?us-ascii?Q?wRk6OOC+ADd7jpNCA5BREYgKBTjYQUWTOPvsXp3RVX7rgBzAJaMiSfk6hOKD?=
 =?us-ascii?Q?yMY9WsKjLdxWhYJtgYx++zxmfA5I2IFtqP8X/McwbOPcXmJXXrJrCXwkMkKY?=
 =?us-ascii?Q?Wpz5dnjWHaIBhIm/RCPle6VmtWw1W8dznqAfdI6z8iXU/TGgHdqp+oJNs6D2?=
 =?us-ascii?Q?n9l3T+s4gl8vTzYZ1Su9kXXEYxDls7JfN0fmpeiyd4TNqnsHC8FBKGI69L9f?=
 =?us-ascii?Q?Fxfhf81WPeDZe7RR7KXMMm6ExukSR/qX95FoiY+0KuTIswPCbiS6wtVY6hPk?=
 =?us-ascii?Q?pbDjHfNz8vkUUP0TvE872ceap0bRUiDCgQE2ezRcQ570MrypiCIxy4C0irhN?=
 =?us-ascii?Q?zbvncx0ijjmjNK3WOWpZriSjDNcgSny1X80dG1AT0JQZ6D1KSDM2XgxKTUBV?=
 =?us-ascii?Q?yKp8rRPDciC1a3EqZ5TaJIGhOsurLfUDzgpaJBAo6HHJVnmrkVdtUHh98a4q?=
 =?us-ascii?Q?b7rYSolq+NZRcJsxM2jkJd4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca55d31f-7295-453e-c124-08dd6867c123
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:01:39.1442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OioUrrKGFxJwI3fTGz3mTZtHfzyGB/5k2Mnfedzlhl3cpuh7MC88v+opm329KrSN/HDbx/imqOWpn05473Qp4owt3LoyqXbq2p8ZpEqsPbpNjVTs/SO0MWs32/MtaaSY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8652
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 11:01:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18327

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 12e0bd600e3c2f33f9db0e3b91f6b8d8d95b7dbe upstream.

Add a configuration option for the RZ/G3E SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241203105005.103927-6-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/soc/renesas/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 171be915cdac..e0eb3fbc3ca6 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -338,6 +338,11 @@ config ARCH_R9A09G011
 	help
 	  This enables support for the Renesas RZ/V2M SoC.
=20
+config ARCH_R9A09G047
+	bool "ARM64 Platform support for RZ/G3E"
+	help
+	  This enables support for the Renesas RZ/G3E SoC variants.
+
 endif # ARM64
=20
 if RISCV
--=20
2.43.0


