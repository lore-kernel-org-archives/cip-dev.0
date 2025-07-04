Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DD5C83F05
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:06:26 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.41])
 by mx.groups.io with SMTP id smtpd.web11.8447.1751619985196915919
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:06:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=F5HSTilh;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.41, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ahz8w9Lc2SjUMhVdMO7nczzLyIphSVpnjQQ95Pj5+NV/4UnvG1pFg9Jzl6XeqIVKvFvNNzSKKBhUV+HWUaHO2lz7MFSCB5BdjsTEdtnleBt2ass7oRL55gEg0y7noFJdvA/+MxqlASdWDaENiVJwUmeY4IjLFjsScmhvXcXK9nAsil42uKPwVIPmwcxNzZtPoPUT0hlddoFuFvjIkr1b9yGd/KsQzbSqsObgMVLZC769spFNDBt+1Vbe1IH/xtZh0G39NiWngxS1K50QxIsz+YAtiOw00D/RUcKHUaZqGv33HNnwzsVBhbfQwLP5mRSirEN6nyK8EcJPsAKSdWaoAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zZIEZAXXLbWSxk8eBLdZDcQw6RoQibI2/B408yEtzE=;
 b=WMi80bQOIIG8vRa7Zd3hPeQHtkwFu32i6NiAcTD1eO+LkdNP/7LRr84/dw9XSL44JVLRSxL3H2BJfbjd4fMs0G7xp+LMmubH/gMG0Fs1pqUHegbw2rjLZEG0oy+gPKW3vFvKPbZgbnhTqDgxFo5WTs+ExEM3zHK4k1GTYdeXlffbSOBrEiwaTCxD5jA0K0xKtHR5DhYocpmNvHJf8cEjGsqi2wnS63IJiQxXKRgV0DDp+7fYtcdJrOP5cnnGztZqXj0DxUIZpV+Lajsea8TgXV4JyO7jl5laaXOCRpE+xzZfT1zcV4MZzjnLRPL620cCxLApVlrWjiuB1ERwfo77tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zZIEZAXXLbWSxk8eBLdZDcQw6RoQibI2/B408yEtzE=;
 b=F5HSTilhmu5TZfJbFcQo2QZm9go6SPX0e3ZscAOdn3s4JZBgG8HtKFtpwgi5JCwi1WcRk6PBTMbArDWz9fF4D1GMAENqZHzKef6RfcSZ5fJebo+JF/oR/xfquNUiBwnavVFUWsV1AlnIzTFfMENuPUNF0B0pv+psDcpHbdXlfzw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYYPR01MB13039.jpnprd01.prod.outlook.com (2603:1096:405:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 09:06:22 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:06:22 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 02/14] dt-bindings: interrupt-controller: renesas,rzv2h-icu: Document RZ/G3E SoC
Date: Fri,  4 Jul 2025 11:05:44 +0200
Message-ID: <20250704090556.669652-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704090556.669652-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250704090556.669652-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::8) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYYPR01MB13039:EE_
X-MS-Office365-Filtering-Correlation-Id: 49426514-86f8-4b9b-1075-08ddbada0bf6
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?SJBgyxFaNxmRDKAss7tSnfleDHQBEHov07xbOy1Qnqo5bBDkYTRe/0Zv7UG+?=
 =?us-ascii?Q?a2h45zNTtboROPjL2BOImjdjHseCJGtbhIKze3KR3qOMoOqcPkWehEQTk9Jf?=
 =?us-ascii?Q?DQyXxk0gKfc6XJ3w9oBRrm2YRl7MR5Rilkxba9no3PabfSKAWPrLx6BD9Ik6?=
 =?us-ascii?Q?EJ4qwLLiK+2l/30ZCeDd0Ju5+MecbyxeKnAYa/RUq/EYnB9u4IMBheh+g8P5?=
 =?us-ascii?Q?G1awZCxXokSfA1qir9r8G82IVxg2BoiFX3zFfLIo8VIg03ZNpvujN9lD7UNb?=
 =?us-ascii?Q?jiCOeTPz0xFjB1V66db+XqUDDlhcMcHeUr1Uavf/Bvo/0z8qqKd4fFvaGYRN?=
 =?us-ascii?Q?qK7HNuBUFkguhZOnPoUYmm65dvupYPCZMva7Du/50CAsZJqpIEpIC6vQToRb?=
 =?us-ascii?Q?Ox3xshGWm7eLAyiV6nrjl8uFLNlskwIGqVJEl3DSmKuZZMF5UPByZcErXWDJ?=
 =?us-ascii?Q?DswHHQ+tMAonwiFnjkxTaTduIenqNx0cJck7DzD5QMNg9kUzz8IlPFfsXrKw?=
 =?us-ascii?Q?TK3W8JF75iEVqIURJwX23UzRqOdbphkYN6fYiV4Jk5+Y2bBnxkSZPUeK6lpK?=
 =?us-ascii?Q?y6PrTWEXnegWNBAuUMRdzcGpUMMFKVQ58MfVs9QF76hqojAG3Ed0NSa5Qsnr?=
 =?us-ascii?Q?rsiLqRgmyDFMGnN8C9IrahOEV6Sp2khyALy3BS9RL//ylSc2y3RXP1ift+fi?=
 =?us-ascii?Q?LB2HtNtxQMWwV+iLsJJodTzTvAVtlNiCnVXJJ/EWdjub1//48gGYf/pqZH59?=
 =?us-ascii?Q?laFQrz//ghxfCpDjJQceWOF/4m7HVn4v6lPWMxTMLhcpvslivqbfROfOmbP6?=
 =?us-ascii?Q?HH/u+9JGVB6tHfC8AbrnP9vrgmEcv5qDlpHRZrMpUw5Halgob9YcME5NVR8F?=
 =?us-ascii?Q?LAojHZ2GZ+a3XtwaFtcCCmDoEdYLxLrOjRhoW4fvO8j9rgPiriIoLFap6twF?=
 =?us-ascii?Q?gkyiKM5vlwzKTlkHrjruAvZB/Othp2BN4QwfArAU+Xj63hd+CQJBdXVkRpUk?=
 =?us-ascii?Q?nIk7YFM/gV84RXNeQ3HvNVaTnbeWRuUVMazU+gi3dJZzNZi3fDjsdgO0PrpA?=
 =?us-ascii?Q?EJpI7320Eid89ni+OGagbQRj8jm0weRDGMnf2xNxEOKUXguTxz6DtIAMvY3v?=
 =?us-ascii?Q?KmudGHVvjnnjRr9o4IUFbPRaGNF5Tdgt3euRSblcqR8h2CRpanbc23FzoByg?=
 =?us-ascii?Q?iccW1ldWglBbQEa3EAuBCQ9pLWcd6kq8UbwheyyMzgH+jIHIBBrQjZ9Bf/SD?=
 =?us-ascii?Q?M98LN6c8Gbq4Mjae3NpBh7C9L46L76LLubUo3OeHdeATCUpgQqigFZ8+HlZj?=
 =?us-ascii?Q?0Df3JGpvRcQLAq9uzWd8oei2ZWVACSYplz7w3cwko6NRborhfB0OF16Xs4Tu?=
 =?us-ascii?Q?NtbNkX+hfH2QN3IL1MnDHNsz0KvB1Hj7iUtooMldRrAvRpmNTXjxadUaCbS3?=
 =?us-ascii?Q?8Na4368cQ7A=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1h7CQ2ghm6sLK3x9q4tCQZrquKG0rJXHQLtduNnmL1vqMYVa6CVgNcN6xUF2?=
 =?us-ascii?Q?16Ig8u7fpqnnEAQzYIeqM7GS1FtdVPbNv3e/zD3zeHgQy51Bz6h8eCzFfNg/?=
 =?us-ascii?Q?ZzU8gAQw+/s1LvoaZL5TAdMbXv2NETCq2XKZVz3jdD+SUObfNWfWjEHhnoEm?=
 =?us-ascii?Q?N/dt9jiuTn7HYAkSLP//d5YjT+0n/e8D9TOQjrxga5tuCXQcwRNRGsP/mfS7?=
 =?us-ascii?Q?3G4tE//O2VB9rx0LsFH19jYLR3QCgAsu2j9mO4dj9hYZLN1l13erpCuI6mOQ?=
 =?us-ascii?Q?YGbjgn34kt5f+5CjpsLGdqX6YGJTFNLnM1UXD/dffrkfY58khvSLzC37S8xp?=
 =?us-ascii?Q?1hNYwYwLYeFxozbFBWmBx+gg7YtJQ5aZ/Boi4AJpxi5nwmuEapoRFfrCd6Gm?=
 =?us-ascii?Q?7/1xHy4sSVZKkxyfeykfVbgXpN74E/FwMZv+Ww/jyQ7myPBvQyTP4eBIYI7S?=
 =?us-ascii?Q?ClX4BdnR5mFC2iVGKcmZxAvvGzxiEMmgAfbY19GTUrTlbIKzKnwT9MHokXjk?=
 =?us-ascii?Q?v5kiHJh8RBY7bypsLe560BSiCl9J30KwL9U4lKitXLqBe4o4q0AwYoX7fLOk?=
 =?us-ascii?Q?EIF+Y24kYJRroynPFVqH2bFHUVasTTtzM8AvBDFg+9qsc0QWD+UyTxYCpaOY?=
 =?us-ascii?Q?VtIkEd5ZeFiav1Ufgor3Pjos99jFgeXq/DDTHRJ4QVde1qAUnalGOBrxUQ3A?=
 =?us-ascii?Q?jU/Xg8O+xOEdJGpuQ7Lb12g0S6lS4yYDcMnJTyD7ObnQeqkekNTFcnRM40Sq?=
 =?us-ascii?Q?SwZ9lgLIq3t9xDd0q5IXAsMy+qTxH+w6ZziOLo45UaEPXy410xy2jeINLG5Q?=
 =?us-ascii?Q?NNhO4F7X3HFBN9KmqnAMkrBvCidw26HmRXy355k0Ock36SPiWcvtWCkXYsWX?=
 =?us-ascii?Q?jIsnNgq91f1bpplC7TCXv1hjQ3HMrlMs65g2PlgAH+VhQZk86s92nldRXY36?=
 =?us-ascii?Q?LD4n+8hyCe1lLtIlb9WNJ8hU8j4AHkcWFb5IeUslF+7CU5DksYHkxu0c2BfY?=
 =?us-ascii?Q?bo0KzeDsJO7vNeq32AUyl2kzG+gvrKnfDfFSGKjUg5Z0EgaHUnn22UP4SGYb?=
 =?us-ascii?Q?zrnN0vfLNNGW0Luy6CRol98RUoODu/I1zSxbjRgEQuifB/OpdZaGkj0O3Z03?=
 =?us-ascii?Q?wWUH+q8EQthU7IQEdjHts8xAhNNN+fBxCh9P9lYOKwIb/MQXeGlSOyZvUj47?=
 =?us-ascii?Q?8tQxMtF/QIM65IsH9OenYZgpN1GsQEG0eDh/fodmZMXCgjlu+UPViM51Es7h?=
 =?us-ascii?Q?YK2VA0LBoe2vZNMhvtdQBDP03C+AQfC9MeMdoSyZOP3+3AnM0LjMWbykbOPk?=
 =?us-ascii?Q?LpaSI4pm4WHrCAXIiETwd6BkaOJqN+SZNZ2lP5s0EWg6cW/pfWeItRqiDonQ?=
 =?us-ascii?Q?4u2ACneQPoYet+VWu4famdZYYsctRMB0opmMke5eLKfk2t8rhhlU/IrPDb6N?=
 =?us-ascii?Q?h+/SAWABHiM5szwjBPZv7s6O0l17CkmiUWju1q/2MOqtxcJcb9SjY3pFVrzJ?=
 =?us-ascii?Q?lkDk67dG7LnM/6IThAqtxY0uCpp2UGNER89xGOfU0TZozZB3r2yVqKec5NmL?=
 =?us-ascii?Q?hDaejH8vrfssdfmwxFIbcKr2uPpwlTEvqNga94Lxu+DZLn1XWS4m4ydqNqpG?=
 =?us-ascii?Q?Ujtn0mqQv2nhMZPCvOWSLR8=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49426514-86f8-4b9b-1075-08ddbada0bf6
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:06:22.6121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vU7ZTagHRBUaTFBgGewNwdUCrgV1FncDOLNRWQALdPcG3qD324hwuDr9CiX4D2qsgFyph9tUJ9w+TJafOSfdEhB7jDbO9+WbNyAN6zl1aEj2Oin08ccba/Bc4/F1n8lD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13039
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:06:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19331

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 9d245214b683e9e4fe2d5c588691337b22c48841 upstream.

Document RZ/G3E (R9A09G047) ICU bindings. The ICU block on the RZ/G3E
SoC is almost identical to the one found on the RZ/V2H SoC, with the
following differences:
 - The TINT register base offset is 0x800 instead of zero.
 - The number of supported GPIO interrupts for TINT selection is 141
   instead of 86.
 - The pin index and TINT selection index are not in the 1:1 map
 - The number of TSSR registers is 16 instead of 8
 - Each TSSR register can program 2 TINTs instead of 4 TINTs

Hence add the new compatible string "renesas,r9a09g047-icu" for RZ/G3E SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/all/20250224131253.134199-2-biju.das.jz@bp.re=
nesas.com

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../bindings/interrupt-controller/renesas,rzv2h-icu.yaml    | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas=
,rzv2h-icu.yaml b/Documentation/devicetree/bindings/interrupt-controller/re=
nesas,rzv2h-icu.yaml
index d7ef4f1323a7..3f99c8645767 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzv2h-=
icu.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzv2h-=
icu.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/interrupt-controller/renesas,rzv2h-icu.=
yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: Renesas RZ/V2H(P) Interrupt Control Unit
+title: Renesas RZ/{G3E,V2H(P)} Interrupt Control Unit
=20
 maintainers:
   - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
@@ -20,7 +20,9 @@ description:
=20
 properties:
   compatible:
-    const: renesas,r9a09g057-icu # RZ/V2H(P)
+    enum:
+      - renesas,r9a09g047-icu # RZ/G3E
+      - renesas,r9a09g057-icu # RZ/V2H(P)
=20
   '#interrupt-cells':
     description: The first cell is the SPI number of the NMI or the
--=20
2.43.0


