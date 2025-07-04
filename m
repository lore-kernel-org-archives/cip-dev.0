Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5042FC83030
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:08:06 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.50])
 by mx.groups.io with SMTP id smtpd.web10.8419.1751620080203179816
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:08:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=cISar9nW;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.50, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3GZTT2X58xx7LVoomhe5fmuM3avSwlxpgLIecEjoR2PNU9w05eH2fbFZxxuZMYYQzbk355HmCOavUfaZQY/cDbozTi/0XM4uxarKLfozAZz5swiQonPta8d3bLSXTxZ1+v3xVYP3sdCt3FAjWnw9Oh+NXKA9feq4Q3fl4koOJGSWVS5VWu+O1LIvhCnkt466Ukr71JDpg9iJaRFjb49odQwAIRvvn9bCyl2uBBcLqVY1Eg6NqP2bQ8VJpe+JEZJ/HusAwGEsqaYK5XCLf653BTQp0bTpa+Irnp/DN/VE4+aAHDLZ2SJ5s7Jbo7vMG5kI8Lrf5DWwuwA0qlTX7pbCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zZIEZAXXLbWSxk8eBLdZDcQw6RoQibI2/B408yEtzE=;
 b=T1Mc/vHBFX66aRTqekVF6P7lMSS5w92/u0k2tEVmjNpIT+0E9pbEUVDPrU3WfE1Pxuv0pxhjDmfefvsSvICWOIdUo1XxRGeH0HMY/E2XAm23ZbEQuNYTGWqzXDj0rSOKDMbx1f63ZIkPTsj6Q5Yi19jps3IS2SBD59894dAeW9YhJCUJfQ25zry6y3Zk2aC1LPb/ILlFIkeEXzyRgf41mWvmdzpDIK+ipCU5eeUFMDrhwZlYTZLDbFRHG5MuabIVcOEvZSduVRzYN8mP3gKxv7LCdOkmayaHb/I/0O9xXObOWzy6RXJRZ8w2T0VuAednwfLYMJ+crH3NiIDSn0i2hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zZIEZAXXLbWSxk8eBLdZDcQw6RoQibI2/B408yEtzE=;
 b=cISar9nWAgOB0fjZ0hSvYLtR7Bo96UzVG8GYBIxY6r5iO0rFzUdnrt/nrVjtW2lcgBj3pPs7bFqEUfBv2k65W9VNWd82TXR431gbj0cwMqL0DsIuIdqyf5eLFL4k9KeAIC/0iwEOTbz9HENfBZ4CZlPBT8P9QNvwWqtaMFmwBtI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB14451.jpnprd01.prod.outlook.com (2603:1096:405:23b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 09:07:58 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:07:58 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 04/18] dt-bindings: interrupt-controller: renesas,rzv2h-icu: Document RZ/G3E SoC
Date: Fri,  4 Jul 2025 11:07:10 +0200
Message-ID: <20250704090724.669848-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY4PR01MB14451:EE_
X-MS-Office365-Filtering-Correlation-Id: b5e6d3f1-be43-42ce-5e88-08ddbada44e8
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?OS7yqCVvRDYpdrLRayjACuBG7oDmRXIp/yXKq6Fdujflnhgw1mr5jMs6Pa/T?=
 =?us-ascii?Q?FGla2ORKuA2hm+ys+hRc6v0oIP5RjbQd26HEdPdpf+0XFubbFWT/oy6+ckmB?=
 =?us-ascii?Q?TDBI4O+STfO42EPAE/xHzi8gWhiUB6ZhF9KWPuSMBuE2kofW3awPLKXHNJDm?=
 =?us-ascii?Q?QpfxQ57zPetcsCi1B7n1ciphXR4haAr9qjcpKE2Xqs3GXMObcToXdlElIM40?=
 =?us-ascii?Q?9lK+kh24BQ/dzKEm2r1kKJRaLMnyp3pYj7TAzr950BpwOB0cDkgovbH+txod?=
 =?us-ascii?Q?PuoY88kL0bS+Way7hb+Bw7wH4cnhnoImWWIY+HKRvIzaVeXURuGN/l3qA3uW?=
 =?us-ascii?Q?5ylOhAOL4FO4i0toPn86ccj5lTQSH4LEqkOZJahcwMuDgeGpN3t21ia5kAoZ?=
 =?us-ascii?Q?cpen5jx+MUdSHxWjsExyC3sojHeLxPBN7++keZ5G39FMGcp0eAbrjEh6J4OC?=
 =?us-ascii?Q?0NgxXarfyzjSQ1EE4Dd2nzRPfa6JL5UVfqbjMsrbV0cpwnyqTfhmuO+4hE/u?=
 =?us-ascii?Q?j1D6rmAy29i4qpOAPJgMjQQry6TgZwFgG1HnJXU3tpsyjJaOkZl05iAwsnA/?=
 =?us-ascii?Q?0Umd3blh5vFJCT0wwT78zdFBXL+mLyreiV7s+MA1y5Zyt+GQoGbhnShEJ3Gd?=
 =?us-ascii?Q?6kT77jXt1qE+82mv42fUT+S90xXrGupLAQpeiiitDi/2DTc8pEXk6QiDjRGa?=
 =?us-ascii?Q?p6XKqLL1z9lEgdaaN0/StHeCSfHCw3LxCw/QksQ6cvF+i1Yre0NNCquecP+k?=
 =?us-ascii?Q?iLBpYvO2YV/C7cuJRaFzdN6p1qerJbzUlRF5r8t4JI3LbSYvBeCCAQYoQtbm?=
 =?us-ascii?Q?oMMIvtDMaQM73qXkI9yn5EZBQIqN2+Fw1t0UhKP0lLDaccFktn2Q6tOit/ER?=
 =?us-ascii?Q?xpIujBykNqX5F1St8zqpub7TrGKJHaxdNhcR5Ov6cI+0NDMfKdCu9gYQqk7+?=
 =?us-ascii?Q?/M+NKUfS6iIvDLg9KsFy4T6BZVIQlyrnh0WR54KpFaOiV8kpjb1D6163EWk/?=
 =?us-ascii?Q?/vfSr0AGQV8MQ9DVi751I93f6enfb/XFaNRscSGyqbW5g2rfvdt0K0lYBF4D?=
 =?us-ascii?Q?uIODixFcCW2TcxdHBjZmFx5bQuxPvQsEY2fYtNzZ90Bh2Hdo28xvEmKCB7bq?=
 =?us-ascii?Q?/qmRNUWpTnt4SL3VvdboxpU6FCRA2BajN0TRX9HXZgxckam72vgz2/7y/I4t?=
 =?us-ascii?Q?9BJwZXn+CFMCdZlFODyTptsDDRVtzUeWLUHDMW58IFZiP0/IsOiOYap6zcQu?=
 =?us-ascii?Q?n1Xmb87RU845bTnsRvMAZD3WqarwA9ctC32nRlzMBaqp/f5Qu6wtYhosL2B1?=
 =?us-ascii?Q?gLYLuEd3oYvuK7vqJ/+Ku1OuYHs93+ybRcLawDCK8x1hU6Qy8g8eQGR0/rXZ?=
 =?us-ascii?Q?0YAI/qOpMjrdvkVKv0EIOZxeq1+9yhdrUs/Aw2PAcqwRLHlbkVja9ZVFFPAQ?=
 =?us-ascii?Q?ijM8YYY6o1o=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nRryydyZvDH0Mhu4ZqSvJ+5gWDtGo+MR8IcqrFgiNYZED+tgYjMf+dpGaeU2?=
 =?us-ascii?Q?NsDyBYJu1VqkARdtQHYB8Co76u55H88EWpDkFCsy1oqCthVinkb9/puNYrnp?=
 =?us-ascii?Q?PKSH37gFcrxXf01oQdXaL8DlauVv1iLzpgpOZb0YOoscj6vWHJJeSl5AmF5q?=
 =?us-ascii?Q?7941ypD+EFD2WrjE42OI9YeMSjjj+Fa/DfuHbiXy3a1o6dG8EJSepEJeAo8M?=
 =?us-ascii?Q?ia5tslJm5KaE5TjxtzH7WLUqKKXsmuM+p3YWFLtyu9VGqHF3+C1WuUWCAKcj?=
 =?us-ascii?Q?y0ILJnUynjEANm3EsbcN6ESY67gQFH/Z982DA0wWQRUmJW3bwwgTnRQIKNzA?=
 =?us-ascii?Q?0j1tNCgZfpIdciNpAtCmw7f7b1mUhZVjbPNiYVQdsvNkwbsRKD99hCFUyhAP?=
 =?us-ascii?Q?ly/uW5iGwnuY8rJ7gh48phBMbMRIhhjGsqP1PQzpeTEjZKOEA0Q2fOtxtU+a?=
 =?us-ascii?Q?nWUHt65sVw3bs1u2XFaqdYIiD/fFl1LCH0ODX6vhTAx0otIYjCGCX5rGc187?=
 =?us-ascii?Q?W+VBO7NUXEM3DJ3D8p0e6vo2AsdXZpk+CxqxJDDZc8DAOXDSaf3R2gNcuar6?=
 =?us-ascii?Q?GqnzwlV9nDNCErT+RSxt5mIL1TA7Huc9LZ43L2QvAyPBWy3vacxHrjPpTvUt?=
 =?us-ascii?Q?iyHnKInnV0kOS8/GhyilcwmGLSne2SOnNMiJ3J1pv/wIkubxQlHAXrnZlwtW?=
 =?us-ascii?Q?Iq1KS3HXWICG+bJNaPmwhTgjsKvtqOyCQA2IyENFHg/7Kfu4OlBWhkM40oJl?=
 =?us-ascii?Q?h+wF1Qldjw8IQaMOZUkwOe72IXNqa3YM666NmIvKYGDz1NCnGf3NCLY3F47U?=
 =?us-ascii?Q?vVHfGKjCF+QSm/b5BNjrnY508eGvhfSYop4gE1wzxq3/a9SCarcyECLWqmDc?=
 =?us-ascii?Q?Vea4oU4wNNLpV7XR+GFSU4DvN/X8z3JIxxc1vvUoAt0/WA2aSSolYpZKFDoh?=
 =?us-ascii?Q?0MS3kvjHBuRuKnZ3vsZdBQGHUVHUGiaqYVGlACncmGO/t+KQNe/IScTLjx0F?=
 =?us-ascii?Q?QD8qAJLLhrPupaU5tkHwBb6G+2vZ48lwyWHErVHzXEDH24md34JmiB8s8WOc?=
 =?us-ascii?Q?bOmZtnT419KL1vyIYRoGnEruY5zpXiYWgFRow3pIGIObJk5/cZ2L0firnWoH?=
 =?us-ascii?Q?12DmYJ2iHltuNdCC0wJeQ4leIcWcJk82l22sYtMhFOzK4MZVAAuUX1IlCF4A?=
 =?us-ascii?Q?iyZnooPGYpJswpg14rX7gH3ewyru25XX4HY3F4E7Wb5Loxs4irunNPFdP779?=
 =?us-ascii?Q?HgQ7t2MYZ3jUhQucPh9J4E/ZUpHhUe34jyiTY1SUWBb6U74PuTovm8UbE/h0?=
 =?us-ascii?Q?s0fC3vOX+/kI/6r92SpBhQLZGhfkiHzx8YKOH1cz8xez1lA+Dzr4FUhlK2ht?=
 =?us-ascii?Q?Cd+BhaCQ0kpsasSkwrLNw/VO6vZFlA5rsEOgX9AQBrFkRyOu+LjMm9egwdyb?=
 =?us-ascii?Q?TtEEMMV4p2IU825Z4lAAwiI+SNppi9NpYEnyBwDOrnxJOTNZe0nZ8OhIH3kP?=
 =?us-ascii?Q?ckqrBni9lpMgHMunI/bzfJJPgtjCVLKhDcp2dUHeq96tTRO8DeqpcfD9U17y?=
 =?us-ascii?Q?2fyRfoz4s8C22jwyv8V0E/LWymDOroKvliLpS2mr5Eh6YXEodSzzvXRZO3VJ?=
 =?us-ascii?Q?vgZdTLPTi2Zz+3f2rgv55wc=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e6d3f1-be43-42ce-5e88-08ddbada44e8
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:07:58.1187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXWngIXtoLrWVbvxCfRFAlxvhnnv9XsJ53M1nFoSHHlmUi00jolLw2VH7SsfoiiB63ljeH+d//Tspam4GWWqxBIow7A3JMDNNzGcCDtJao8JAf4cwvBEHiR9/7SU9WJ7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14451
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:08:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19348

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


