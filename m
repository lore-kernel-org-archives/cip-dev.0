Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BD8C36001
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 10:17:00 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.40])
 by mx.groups.io with SMTP id smtpd.web10.4361.1742379415027532589
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 03:16:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=hgL18Avi;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.40, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJfWPIaSmqb45C1Ru/NBx4XcdHor2qY+v7nDBK55BJwH2Qe/EyDno7XvDO9bG32DIz56cAL2vX+u5LT+cmDKe/j0c6hk5ui3JVHCg8yktBSPF2a1ijowi+pJi9cShftcA/EMTlSYCKV58NCjn25QrAZ6hvuE3zKtHDUx09Notr5jl96gaRIwumBnJBiZ09qk3m5UnFVj1rF0Y8G2wDDrU+75OYqcfnZFWIzc/GTD+Kdgeu30lQ+/fCvznkm9xpCW3Iy1ByD2s/polOtp45mKo57Oglld1cUdGJq7WUa8bGclfHhLVH1cFi50i1BSsJXX216z7vKl3aJTJjR5Xis5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpNm6GzNn9AlpzRxoGbTXKSvVK4b5uz3voQ3e/wSmvY=;
 b=W/sS+u2LAmBxvbVRipk4K5vxZQ9gucLReEOFfMJhIJgnvd2h751HGANmpsN5DfU4GSvI4/p9KJNq3ZRdIp33VI2AKFYJVZE8xfp43peGMbSgbCAfjU3RhgrbI146bVE6WBg23KQ2CMoEJWSKdp06dLuPSyMt9HGHLlJtdQBi484n1rJ7tnc0f/3rl6hyd6pO4Wt9fwGCGraN4PxNP7829oD2rFaqlb81bhE+D21I/Evnk4xE0v9UD0B4FIQA2ErmhaiXf1j202ZCqDp/wFaZmlfk0+0UCx6EYo9pKWKVHhKdTwW6Ubybmt9XibcRuqyOFFbJdtgNyRwhIGX/ZBHfjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpNm6GzNn9AlpzRxoGbTXKSvVK4b5uz3voQ3e/wSmvY=;
 b=hgL18AvipFQKhH9Lvz6Cx0epjMgyZ8vSLJWM3uh927FVX0J8Yrcx6dk3mwpMOAcooFz1p77/UAHUIOow2FjPcxDQo3raOOqVJnbB6oAXqnvk7c3dJpdOBSIDuHqz8Py/V+BX1WiOmRemSxEQVpNbHKn2sAK1dw+e7A8IDDvn3nw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB12680.jpnprd01.prod.outlook.com (2603:1096:405:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 10:16:54 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 10:16:54 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip v2 03/12] dt-bindings: serial: renesas,scif: Make 'interrupt-names' property as required
Date: Wed, 19 Mar 2025 11:16:20 +0100
Message-ID: <20250319101629.2407727-4-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319101629.2407727-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250319101629.2407727-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::12) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYRPR01MB12680:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b1a3b66-ab79-47df-9777-08dd66cf2c0c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Jb5lXFbWJnmMbMuvPahsmgF9RABj/eUk5guqqGjRUY/9kjGnxbxZdgTGDB1Q?=
 =?us-ascii?Q?ZHpBAL/B4dIaevf55irUHeXIXha7FAFa72tLvMZY3aYl+PQ7VQjuGPyx5btM?=
 =?us-ascii?Q?LxyF81UJFJo/g/iT6RJrTaE4ZZh523ja9F72BefTgLuBpUVRC2BizmNqTFHc?=
 =?us-ascii?Q?1QlzEGCn5WgWc6DmQpN81i9r0P8wSbpazP63GXMjtcno199oNK+U+OPw4A9a?=
 =?us-ascii?Q?9Q8zzOcyl91eDqe5yv1gLP3Vlf0DgFzWdvkk+Ihj0PTZZwADLOZJ5wLk0nTN?=
 =?us-ascii?Q?QD65hvLqaLZMCGA/LangxyBG7ypUfktqWRspjKoHGPVS4dHY7JPLFeCkQXRC?=
 =?us-ascii?Q?6GUcHR8zeGiR2WtHFRmEYC2PC/3nb8aZepDJl5IYBB4cHpiZT/jmSj17wQXu?=
 =?us-ascii?Q?SZmyQoSBUK+ePUJixoxwZQEIRR8Xq1IZg5I3qstoRQadLM7LXSGvvFRG0yQw?=
 =?us-ascii?Q?OI4hIPEs1LiJ3i0MW7CfX+BNNqWV7Z8+kpu2pvadz82Ptk6/WEgPsE9kVCfb?=
 =?us-ascii?Q?BwxJ/Quf6HGf9Me+casoVCiuf7s0AcGXvPpwYB33/d8W0ML/YM39RKzjGCWP?=
 =?us-ascii?Q?DvK+4xrmTajcZCWHgKwGx37KM8PQyG17+sfaSeW66/8z8flf6Aa4VvYGGfKB?=
 =?us-ascii?Q?JkDQQX8/H3HfPsaG1f0mRXvIoYD4nx+aYuzS1waZeDCkBgAaoeejCEAUtDPs?=
 =?us-ascii?Q?qy1tCZF96T79ABVtvnCmGN8pQ71D7wRrPWrXT4OnYy6W9iyjYJVhI+QTOt/p?=
 =?us-ascii?Q?Ru+Erhkj6OBJE6/d/acHvkarcKOD3KJpG0KoXDUtZ4kXL51AOxGjf0SizFzq?=
 =?us-ascii?Q?8pBecEZ5XBb2chIetY0p98sphSDgE2Hm7/cAe0T43dM1F3j41zpCxzEJ/QuY?=
 =?us-ascii?Q?llQUNJCJunCuGUgI03jhzL1g2jCK6YpeR4ur3eMPZ4KIeBFDlJMdeUoIBOJb?=
 =?us-ascii?Q?UmuJ0HQDM2eQ0DKwAnc901Lf3GtXTl4imOq+hMsYASRw73Jhhcpr8q2tHs5Q?=
 =?us-ascii?Q?f1Eq8AuVbPSoRx2UvOVoiYvNTXtnoID8LFM0LIUrWAzCWf2lzqvSFPcTBtr4?=
 =?us-ascii?Q?ynSmNukgRZ2VH8lXlGUvxLtlj6lK7JZURZSFd5V/Crgty+x0AsvtRJBOm4NF?=
 =?us-ascii?Q?jmB+Lr9/50BGwbYlyBxNXlYZD0KyZBqDv1LzHYQEP+8ly82r0FMzfXlNRw9a?=
 =?us-ascii?Q?BhMOw76juxeA22aki7xYdc96Qayo3kFOf5wAJFmQ4gA1rs42o9oWfZEsQfNy?=
 =?us-ascii?Q?gzh1zHW4RUk052XzIPazJ47bHU5wKbO1EdhGKHZMQEPdS1SXQnAUG83Fb6EG?=
 =?us-ascii?Q?EahqjNp2zt6QwBBvBQaIFXL5W7+v1A9TfJVZWlOKC5DMfrFM2FSOp8GhAx2c?=
 =?us-ascii?Q?LPORGLNdazAROSnBvhG6UEWE7SO9oPrw1xm5+f5iV5L3PXUsYaUdA1ll7PNt?=
 =?us-ascii?Q?9gl2AOCBEc0GUzht6mO/utl+ev7kgAu7?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nTckzVYIvsU+EAUITwDM5dPhOiZOlBiegYh04spxXXZh6vs05Yn9OPkPW571?=
 =?us-ascii?Q?9P3sd6iLyfJ9iaqBuG7lolFbCXrw+lZbzvPSI5IBuYxDw/GqDhTMSWbiwGEm?=
 =?us-ascii?Q?5tUgUZlZZ7kby1fN5N4Y/wYHavBH5fmSnIAX7xqFYcdLhfAxS+P5Q1y3Q/TR?=
 =?us-ascii?Q?/t+RNw1QPigGOIgEKVHNj8qMFvx2x2gpLvX5pK66eATdL3I93YJT2DeVESWU?=
 =?us-ascii?Q?6ToWAtrRjosEXUfvW169YbJc7L4QTuAIOBay+UxAbJ3gEuROJC3AmATRStnb?=
 =?us-ascii?Q?2Z0H/9heMZco47gPIR6L1UT0+/ElJIuPEZlV8bFEysX33pYhoNAvn5sYSkGj?=
 =?us-ascii?Q?clZDrdrtkoGsiw1r9VBrbJbW+x4tG2FVMBVjoQ4aNlHUxJ0x8TSgyRUajoBz?=
 =?us-ascii?Q?d3KdIHPCyJqlwmzb0i2EpADTsNfr8Fl9n459EYExGFm/ineReytlarj59nee?=
 =?us-ascii?Q?JMcr1mxqbC+HIZ4RskWNYECuJiIfkwzxziO9QK+dVe6eK+vuwSYlwshsR/WU?=
 =?us-ascii?Q?ujpB3owb76la5g+C7KfmryzfqGsAfn27XPg0TKLd2Wazxg5bGCuHf9sANRvB?=
 =?us-ascii?Q?0J595B/K0fo3LoVH2fN6GMIsfCRtsGVYUv6lQNgVhVncgrzoXW5OtLG8jDZC?=
 =?us-ascii?Q?hExr3K914pSbU+gXEsv36Tkj0wwN3OgAGYvz/EOlEjOjfasofyIkCfp5B11/?=
 =?us-ascii?Q?zhMKGzvvvVZrVZnZ9hkPPtgIjFwyJ19CHuQTYWa4Bh/MpcSt9pX+XMl0Z6yJ?=
 =?us-ascii?Q?MxfmGS3OkGfpYN6EXUstA8Yomw1auWV9ExtjeMtuW7pHzfIu9kNXtjZZ6f05?=
 =?us-ascii?Q?Ahd1tSpUpt3Vlk/xltJH/HdHFSpu/SSONYYoru20AW8WgmETD/K/aY8//auh?=
 =?us-ascii?Q?Ve+NNe14vdzWGLrjNJuNTy+Fecdptp9M2VUvc40asT6sEy1cFOCiQiT7Jc43?=
 =?us-ascii?Q?q16qYv+emiw4ANfHRe/wk1P2GM7YRSARzdrvWjxMwzLztxgXW1nb7jNu93oO?=
 =?us-ascii?Q?8GIKYLVRPX+V6zgm8zR69O3tZ+18g+KsOaeP5fJ7tYsUVHucw1k0W/gY3SWp?=
 =?us-ascii?Q?pOc7b118Xh+M8gCKdCKZ7s3e1RPee8OhqLjNqzczNrZUa3m+VIDQvB1LriQv?=
 =?us-ascii?Q?9BINswfhG4k/cXe9Sm1fa1FBbHhsyUBNlQflJZxYaNvlJVT3LDTIMmmodAZH?=
 =?us-ascii?Q?Ex8Iag6fDpb+/+b0+mPKenaCDmWnZx0KBX8x/GWOUz/Y0YdbkDANi4kN9etE?=
 =?us-ascii?Q?SmOytvq68i+Bi5XZG7ywzw63LNYq7vR4pL2N9VsXgQfVaqHSdEStZQqrf362?=
 =?us-ascii?Q?AiFVvXZ4Zk/3O/cjJav9lX4ldygULOHhYvDeTFRPK/xY4Zw5RqU7sTHiULZq?=
 =?us-ascii?Q?NV+MCxukLmUnBGaijEhWnmlWwBUPayy5WtlLSwD4cxS5HaK6Pf+U8O2MM/wF?=
 =?us-ascii?Q?Qmhr8LVjSGhwZJAqWCDRvSg8G1a2XrSBPbcmSswQirhBwktKTKrWZushtMYw?=
 =?us-ascii?Q?pv//6CIs6C0bv4W6hXIhCOvkUbWPhL/XbaW2msfGAi3hJs/0LDf4IkA7ZL2G?=
 =?us-ascii?Q?T1XTBSGYcMgJmOH0jTngV2eYPh8ANjtBMNiCzU4OlbooBLRsHHhz2fvH+8TK?=
 =?us-ascii?Q?HEFYmC2UJ9NIXO0YL9TZnB4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1a3b66-ab79-47df-9777-08dd66cf2c0c
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:16:54.0878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjlkvkArM2ve16UsXBg+43osJfatgooF9xtxAMEg/gDnjOz2cI0K+1bpDKiQPryePlu+zmicAlpLokCY6FRrGRDonvj1VxDDk4xuzz9mzX3X4Lp3yqQnVrLiY7DheuHK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12680
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 10:17:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18264

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 034e4422ddb5ec9075d550f4668be0a3e85e6a3e upstream.

As all the SoCs having multiple interrupts have 'interrupt-names' property
in their respective DTSIs, make 'interrupt-names' property as required
so that we can validate them using dtbs_check.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240604170513.522631-4-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
Changes Since v1:
 - Added missing Signed-off-by

 Documentation/devicetree/bindings/serial/renesas,scif.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/D=
ocumentation/devicetree/bindings/serial/renesas,scif.yaml
index 20132a3202fd..252c1e6102a9 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -178,6 +178,9 @@ allOf:
           maxItems: 1
=20
         interrupt-names: false
+    else:
+      required:
+        - interrupt-names
=20
   - if:
       properties:
--=20
2.43.0


