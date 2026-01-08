Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CE5CF6A99
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:29:20 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2996.1767864553150078230
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:29:13 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=mOtPlfal;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.45, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjvlCuSLax1ULBiDzYhIIlgEEsYkZ8uySvg8PysteA2neZ6WLeB1VO+X+dF1yc06lykaCA/wzRZW8LdndZMIWTX8K/6ZdmYJKql1WC2smU7kaR+ah+cwPYwlsOsWqHZ52swfscxMoHVEFFXpVF9b9/lgJVb2nbjqzM4t1iIG0sp+EJIuJzE2DUqVqZViwm7s8kOZSzJfDiGfJRG5LiqWiwacMwvJH1X9JqQ0air8mRX7RTWj7SD18XET/DK7Zp9OaAb5ADHx9oBhwmsxUBGL9e6MvGFl/jcQ5/pj3L+JmdnGX/7cvnXtj7ENscvAd/X8+DYQgkwPiNttBCbMH9SIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZcD46vazFyYLBvFX1k8ZFTg3NwmzSNoFRVtGuuPeV0=;
 b=vsZ+fokbVFf9kFB0yvwr9Z89bfUj9QEd594oOBg0At0Ha98hYxjNid6s0qPzHJDPveljQ0T6siGGFhoy3b0GJ7yYNW4faByWRFhN7y1GtOtVzhi5sMyJNoRCSMb3iOAhMN3paDNusGggg7xaxKa1VU9cVHDpfc/Mkp4QLCyUKnnq8YE1KXMK0f9QtCi8HQZznzxkbTKEmjP0Foy9KN97qHQk0jSry+wKSXn7djrGd+zYUNS4emtP+1qXoVnILUbzXWvpw7YfUB0NoC2O18Q3B5wFtAEIUgT3A95aAZTMnTNb/9nQVLX6w1vdrJKdlmmBu2sXXiDOaJd+IecHhX7M6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZcD46vazFyYLBvFX1k8ZFTg3NwmzSNoFRVtGuuPeV0=;
 b=mOtPlfalLSYyMU+nXf4q3mSOTnbd6WkdyDNwT0pVTPXjWpMXpoADD4SeQz55k7GqUQVpbCi7rxw32LqK6ly22olh9DaxURaGqyU8K7l0AsY+Efp8XVm/qcuf4e5q/9uUN9vtHfuMmTOrm39oyTmwN7VTv/R+l7+RifyM0XQtn84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14750.jpnprd01.prod.outlook.com (2603:1096:405:257::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:29:10 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:29:10 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 08/22] i3c: Add more parameters for controllers to the header
Date: Thu,  8 Jan 2026 10:28:09 +0100
Message-ID: <20260108092823.489287-9-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::12) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY7PR01MB14750:EE_
X-MS-Office365-Filtering-Correlation-Id: 6548116a-6045-4b42-8236-08de4e9860b5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0WUc16Q6hMNKXKOu1Cpe9JcO6RgMY7DmBF4aKPqWdp3bP7un4X+dzmnHrduz?=
 =?us-ascii?Q?wZZ8ecjIFGjk1PDoqtAJCqenLOUPc+h1KokuxAiQUdbIpGlP9Z/Y3g0x6602?=
 =?us-ascii?Q?I8kUFadKpRNde+PruBVgXb6oQsRV3hZMQw0Dyedn9Md49jtq+R+XpXkMmsBY?=
 =?us-ascii?Q?4V8equWmZZ/Py9X9eIke8rGo/5EWn1TetZICsBueSmPI0zd0x5g+0xzDiayC?=
 =?us-ascii?Q?kOH+GujZRi9q2PHwgpq2UUjfaese+MCjtL5FT46fcW9A+6WmrOfrrsXaHg5g?=
 =?us-ascii?Q?7SHzl2sPe5UkY2WXX8090uaOMYe3GD3OL0eC5reRqcG/PVS69qAITAKwCeVJ?=
 =?us-ascii?Q?Z5kcJUZfwHXtP4o2O4bAcLWEteO8HmpZyjWY2jXGGYN86mI+3x+pv5SFchv9?=
 =?us-ascii?Q?Oyo2MRmTxHSrrO2RgrT96/Lf6aVSDoS382w7U+5C6ZrkFMMCm+vMZ5syc9Cn?=
 =?us-ascii?Q?BQlaJElo1woKFv/UPTm2QGG102yabvU2ltLut/sguqa8rboZp9Y+u9xxI6YQ?=
 =?us-ascii?Q?/+C7nHArggUS/qQZSOEKDOKfavh2eMtdWspUPKPMDiSdfFT87AAAQFZgPaoM?=
 =?us-ascii?Q?/8b1SUnXUkSnhtL21qOQAT9T0kGhuSKIMnZOZnlJ07G9jQDYOBx6xwpp9e5o?=
 =?us-ascii?Q?eXVPELHn9qk13yirgIr4zm1eCHvslp9+nCyTL+O5RzfYbwbCuXFhLE6tI6Gv?=
 =?us-ascii?Q?Mi03F/KkGaU8YKq7/NGphvU+ewYmNnSHTSnGVVZyJ6FozG10pr2bHx5Sddk1?=
 =?us-ascii?Q?iI5sfiYtLCwlJQR71YmfHzW75L1XeBfLYsoLIZb5cNpu85m+2WUaQo0gJ8Wi?=
 =?us-ascii?Q?yF4bQ/bxgYjekmNOddRJ0CFs9FKb/7ZPHalpo17Ct7gi1rjAbgMgDwrIGgJq?=
 =?us-ascii?Q?zuq92lcuMnbH8TpaKRRzs0VWiOIcSeqGhV0wpewlMDiZiGJbf5L8qT/5LJXa?=
 =?us-ascii?Q?k7SmUSWjWkiWAt/qzKUBfnmxg+/+QmS/gUPmvWWPSbB+Y01vT89NNBVU88UU?=
 =?us-ascii?Q?OTva6/8/CFJy20GN0wdDFNLudTDHs5ef8XVSeh1R2eQs2gHV9mOKKOBeqWoN?=
 =?us-ascii?Q?ALsr6K6DmFv9M0+6ho8SGtcY9hYK2waH0aj+VvW2lAY8X9qVxy3DwlRFoM78?=
 =?us-ascii?Q?knsCEKqn57Q0zQwG0Gq1hCIB4VeGEjsi0QYcw9oTBqnYDU4UqxWw7RKGr6XI?=
 =?us-ascii?Q?77raVUinIl+X39N0Sm2k1IHu5mUUrhykLwD6mbPCWmqerKbnzNxLCugTjs0Q?=
 =?us-ascii?Q?vG3Ei4voujENto57kz5wNDOxxq0JQLvGnnGjBTfZHNEQge+ImsvP60UZWdlN?=
 =?us-ascii?Q?bn1+8aDMC+iKBLyoRYMnl8KOHNOveqjbK7BVTpSHZi/q690j1kIxFwn4GsvB?=
 =?us-ascii?Q?tDRd3VHKDW0J7/e0Utq7gVMoaVzxnS2jboAvD/4Qa6oZeIz7msAL85h2+ov6?=
 =?us-ascii?Q?hnaVzlROts/mGOJQjYW5KSYIWIXQNA7Fxwvdhxc1RNM7sF7NweWoHhUhxmHb?=
 =?us-ascii?Q?mMd4lBH3c67gMLUhuo+H1FzNXyIT8SlRxMnp?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?j7KZMB46ClBjEj6SNovdJcLdYXWuW2OmsXnPn5nIJfhi0OoIqQ5twC5X4WVu?=
 =?us-ascii?Q?VELwVqtoSeEEvQO3m5L8V+V37DTY4N8jnKUtAW0vAC0GhA856SR0FilagpZz?=
 =?us-ascii?Q?FQudhznaT57AgrPAoKXhLxR2qTv0E0ooQuF1sFk0oWNoDxD6mD1IZTR8vPuq?=
 =?us-ascii?Q?COJ8Xjrs+qLGZYvG+kXBMZD2gW771xPNQCJeiwODrMzt3y7j2fXqCh3QiYUU?=
 =?us-ascii?Q?ywYxNrVCD6xQZ08PRGeyy0AQymWlVbYVd5RBWzSpwX62Sy5cLqn3M9bpCO+3?=
 =?us-ascii?Q?vWx/1wRs5zlnRUTzxbpPeh3IimNtlU8wRvBDEfScqRaAL6rh38f3RsXgO/cv?=
 =?us-ascii?Q?eXPnXblcR7huEVp8kTlgwEM47h8o0AHUUHjCRmgskE2udqhBtMfwNLtkICOg?=
 =?us-ascii?Q?qJS/fviibHG1BTXlr0kcQjmXwBFqiGO3a0rLy3QcOvP1jKiSmDPlGLF9b+dF?=
 =?us-ascii?Q?zJGbr9zItG4gt+bToMivWJcG+QlMOIQdnQMFThcgoq47bT91YisqZyU6sXMo?=
 =?us-ascii?Q?dWRGf4hI4dRYuN8FgsqiEwG8kRLQyKCGHAiUxdBz4p+D3xB7IWtqhHJf7ZRo?=
 =?us-ascii?Q?3dZw1v01JrQzfID1pfVCkF1pYrbgjv0xFARhCoEnz9hm2KxWtnGM01/QOona?=
 =?us-ascii?Q?Oh6IWRuD66g7S7dtIxHn/4eGr0SmXxDH94OD7SAzkg+/u3Z/sLvTNSWTFB0G?=
 =?us-ascii?Q?DVJ/0VkehW/eSFno8WJKzdKYMXtcSgK9usDWCDqroIc4tpfPR7S/+Pwze7ao?=
 =?us-ascii?Q?+y0UpbIgnCuX9532TgQoraUywLOjuVd8Rue5uKYbXaUEVqqpnZpfYnZxsLHB?=
 =?us-ascii?Q?RC4+rDNlzl+3Hld5+e1ambc4T3shjOfzWhM8lydJxtEybA004foLZaFbj+Xz?=
 =?us-ascii?Q?9jSi2a1kUx49u22f4AjZbR1/kT4VYjX7RJjhwBC0nAQhu2roXi7J1uBhNkmN?=
 =?us-ascii?Q?Hc7egyj8v2UZ9jjotliJWyRCvvgBnQWKk1K+5K1g5AgVaaSnBdvkgvLhzkYW?=
 =?us-ascii?Q?gor5+lrHKFvMKFh3o5liozAvbgzgXW4cNvi7kajeANGtkow7mX5/8/Jj5HUV?=
 =?us-ascii?Q?t9mdBWDAoGoNHgNw1/Fi8C6ioq+BEWZaackipUdxtyED03DnS6ZwI2K9rFvv?=
 =?us-ascii?Q?LS9mUMZoMq0uPOwyhSwSdf06TFZ8fBcprb5hJjDwebQ8D3spRHD6C1biRI/S?=
 =?us-ascii?Q?i9pgHbSqyjxMwbfu1Hxd1BXtYdk6+pZqlsyh7/NScQ9QUvmy5VptQQXUgVZC?=
 =?us-ascii?Q?2gDdo0aU6RHaeOakEFd3b9+/Wo76CcyyMJI1k0Ctrngzv0Gy87hOmgvhGzg8?=
 =?us-ascii?Q?iKFp/1ixuvnxDWfuNq4yBgCC7JNejgsVlEF+p3EBZDAyDzY152e91S7q25U0?=
 =?us-ascii?Q?wDmPG/CueymzsGBUjxoZpqYPmmvOwZ85qiP63mxErFtxhfgZ/LIZte8lGRdq?=
 =?us-ascii?Q?IOMUxEEGK362FHTfWUcG1bbeG6N7ViFd5iCfQoEH+glPyvJaJmXWt8aMh5dl?=
 =?us-ascii?Q?3gPzeGpl+lPoMcdHNq73cy71Ge9Me4HYGnYUpJh9Y18DxCFVxcZooknzfEey?=
 =?us-ascii?Q?UnNUe6Dfa2dZ7S6GZk6XAmhmUxqQ0bHwI1ru0PGnIUDMvaD7ElQULIJQyejC?=
 =?us-ascii?Q?fodq1OURCgA/e011F61r2XaRHgV2fZMACq23zCvfn1mkOBkMRY9Fe9SNh29D?=
 =?us-ascii?Q?zwBgVXL7l7v6hGnA5Wi2dbjJ10ABlQgvkeAqZP0sRA/3tfBnGnYvEZqI1iin?=
 =?us-ascii?Q?eB5LMKKL8u77pe+2LlfGqMF+qiXqYqCkZwD3n32Ss6ugscUHQvAe?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6548116a-6045-4b42-8236-08de4e9860b5
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:29:10.1731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQE4i8O242qHyO6ifyidZp5APjxrw4LNIW6U3HPnxE8IYSYZ5fjyeBGbaikELw4XWgyqZPyDMa9BjNA2mlc8WNjONxzPD60AKBslpYCK3EZhMyzTK23xXysz469hB+Mt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14750
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:29:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21444

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 8acf1f3bae1ea48949458b67d68a72a95c3244a4 upstream.

Add standard timing value definition from specification.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20250724094146.6443-3-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 include/linux/i3c/master.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index b399ef2a9359..fd5f35b2385c 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -245,6 +245,10 @@ struct i3c_device {
 #define I3C_BUS_I2C_FM_SCL_MAX_RATE		400000
 #define I3C_BUS_I3C_SCL_MAX_RATE	12900000
 #define I3C_BUS_I3C_SCL_TYP_RATE	12500000
+#define I3C_BUS_TAVAL_MIN_NS		1000
+#define I3C_BUS_TBUF_MIXED_FM_MIN_NS	1300
+#define I3C_BUS_THIGH_MIXED_MAX_NS	41
+#define I3C_BUS_TIDLE_MIN_NS		200000
 #define I3C_BUS_TLOW_OD_MIN_NS		200
=20
 /**
--=20
2.43.0


