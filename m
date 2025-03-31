Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D54DC36010
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:45:51 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.18])
 by mx.groups.io with SMTP id smtpd.web11.48792.1743417941343694802
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:45:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=mVCWIMOk;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.18, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhAOKuu9IxcrQvB6FU4dT1qsGFnDJha3P+Vna74N8UPHpUbzeVkW9rMvdLsU8MfEv4mdmFtCt7Ly0tKiZVxtNMy+PrYggFFALZnLwGkHSnCuY1LGkeq5IFv+w9T4+F+xmBNTUuxYxKkaW9IMkLxfC03BiEMcMAOYOH+oqJWdrq8HKl5QRekJKEDOVklWrVuECH0+6+HqO1iDpUztm4KAMXsgcykwa6FJmQN874Z7lSn9Vz0JFVt+i44A+CGMKEtnhJ5gJ+hR6/FliRHZ64IzrB8QoNGqxWCmDlHJ73FQx6cx5BCwJLBoew285pxGR7lvBMBK1tfI8hs4eNNaOtiE/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75I8bj2PnrXxgLdH6PPLVUNkkDRPCl91xzt9j8QjYJQ=;
 b=m2Omgnp9qOn4832g/KqvioPqMoACKwHfqVEAfzfDvUhHYHW252gr71qI1BH3OMAsz8hED/E/DNmO468KC+1123aomoq3RNPLWrwlRzSHYSTBCXvkc/S4C95QPeVChA40lFkAZJkYmpA32Jq0Ro6s5hbFWpucG1LBdFIT5UYntmoRpaeGicvRrI3m9Bhv5Jl8yRYS2NJV587hYSb6bmsPJDOqzg76s7d++QiDhxepYqdpxzOrfrp7mowPQm/ixrYFn8P6S3tc/2drBs593GrVhUVK0e0zpndzUneKTNnD8FCgyazvA3Fjq9e0FIZg9uSAgVyzabjLT6+4wO82p7ZQvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75I8bj2PnrXxgLdH6PPLVUNkkDRPCl91xzt9j8QjYJQ=;
 b=mVCWIMOkcFHLtsDkpUnXn+NpLEvPZoZF28Y+1SLuUPdz4zZVUV353v1MONXtu9huCu3f59zoS40jE0E8rfk9d+b7IARj7n5WTS98uysmOM/Q0hJtJuodI/jH2M46tZ5GDahB4kZ6xcBvAgmbXlbbfcD7Z4nAUBi2cBgmAP8bRCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYCPR01MB9796.jpnprd01.prod.outlook.com (2603:1096:400:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 10:45:40 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:45:40 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 03/43] dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Remove the check from the object
Date: Mon, 31 Mar 2025 12:44:34 +0200
Message-ID: <20250331104514.79090-4-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYCPR01MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: c61017e3-49fe-4e48-db31-08dd70412e15
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?bFY9h7WDDvafInao+6XrZ7/FFSfa0MkTQx1UtFCbLuesn8/zJ9YdqXSI4MLZ?=
 =?us-ascii?Q?JDYhYLIN+y0rkoXwl3rPDaDmtsk19ZdcZvTFOmD3H30Qf0Db4medkgY/IdB7?=
 =?us-ascii?Q?+kiD8lz9Udyq4U7odTbSbtz7KLCnBXpJmaa5IzMJVZWPNR3a1FkHhW0aCsax?=
 =?us-ascii?Q?f/7jIQhj5jAIsbxL5HZT6aCZtMh2sNh9wzeY53/aaCTGkDEhg3O8a3UtUep9?=
 =?us-ascii?Q?ZRKoHYdCY8be9ysUcWPfZ4oNw4TgVfp1SGPMdEIA3XzrFhu+UIl/mAiDdBZb?=
 =?us-ascii?Q?ZRj32kEt20FGi59DjTn5EQeRrfIKNjs0qmqen9oK99FvOTY2v290b1a1gixu?=
 =?us-ascii?Q?oLvuTL2CWKgMJrcH8xPIlbXdhma1iU+EhyahZuKKA88KiTMn32EwzkfeeZtx?=
 =?us-ascii?Q?wdpHU1qmrCmNNh9tRHs35Y+b0DiMslOsdJFJSGonkJVMBLFfL+l5hbVmd3xG?=
 =?us-ascii?Q?TQ3dn/WvdW8FbsW/LPTxyrmKZCC+4XvGGR6RIFRO//AeE8rQZ2NZ5Vaharnv?=
 =?us-ascii?Q?xr25gUzITBUaub4dfpbIRf3lt9MwYK5QmjRETMpwKccCHWxqGm3+0xn0fofL?=
 =?us-ascii?Q?YOj/qaUbM8cK7gLx42Eoutad/WvzN6wW9jjbT7YVT/pVUyOG+rxw9xn9sxj7?=
 =?us-ascii?Q?td36cfTRrO/qDFQxhRsYwMienHeZZcsOC7hcczUC8fpMJ8JBW7txpZJGkn0j?=
 =?us-ascii?Q?+b7uZ2iE7w+o54xFZ8Wua2N4YYL3KPT9YjaFE+5ykKWvmoxfQlEQ2+lkRdDq?=
 =?us-ascii?Q?HAvTF1RUOJdcpd9E3XCfZWoct+m8AdMnu71r9TqgcmkzYTifKEuW18C6s/Qm?=
 =?us-ascii?Q?jRZzvs1YxhKHgpmtEGHhLh5FY+IDAbtD9w8zO9iaG7cBcLKd7j7UhC7MBUNs?=
 =?us-ascii?Q?ri307Jsqo5ibZItYdRVyeRlqa6UHpM238YHaCgzAXBXs8jsqXzPU//LM6Rm4?=
 =?us-ascii?Q?jFaQgfufoBq+u1zIzB+E9KecZqYNybiDeAHH/+HwHGAw3BbF2g9rxsI3vyKI?=
 =?us-ascii?Q?LTDzuoYBgx4Zk0p4A7zHOgOMtLlEGrQCYOgfPgUSO4T9hDrnXT02p6rW+oGH?=
 =?us-ascii?Q?1EbNtieoI9Fsdws8g0jo24bWqGIxvQBvCA2ZgI4KVM/sZuuuDm22QhwMiRwi?=
 =?us-ascii?Q?hqkHTJ8JnqWVzNpUevxWZ4pB6I6RPOoD5qruTTxPqTWR2kvP79E3Xb+2CHTw?=
 =?us-ascii?Q?zqIswC2qkg8tM+p7C5aY0FDbZN8cPLSKCT7YE4JrxeIlrc42pKmC+fA072jP?=
 =?us-ascii?Q?1GhrLCJT1XfILRzHG0NMtiHyisss3caQkd30ein10YqN70hTCowMytA0M9pr?=
 =?us-ascii?Q?xQOsO2yO/y+0tkC1UvI1CGnqUtaEATNKid+3IcRvp+TwKIdfUbNUjNLXHeWV?=
 =?us-ascii?Q?d0jyb+JIR1Zf9VRNQolcheOK4CjvmNGw16Cg3VLYjP8ILMSxsoi2Kzo1khzF?=
 =?us-ascii?Q?j8TaO7OJXgg8AZjekUIixCrzas1M9CCC?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FXEw2y9Gmxrd2Gzu2OhuQM+Cg32QxMzRruVYy7MWbfxKZP7aTS4ZdlX7+D8E?=
 =?us-ascii?Q?XrntP57ANakXrhqwvvh135pbxOQ8NTQF7WUsamUVrhYu9hA/GbfVZtulDkU6?=
 =?us-ascii?Q?mYz0BsNG78LIlFuYDu18QhnrzDqa2dVeEHs5ti6m+eSE+U5YfT+SViipP+Ha?=
 =?us-ascii?Q?TzLxygI2jgcDeDvdHa35HXt770OynK4x/fcIDmc9uFqDIXo2Sp9ILjbqcwUX?=
 =?us-ascii?Q?teslZmaenTmqzKvlulFrmbwWJV8/F8ioS5Fgfq+V0MexNG82u543LV5OTs2w?=
 =?us-ascii?Q?Zu+raA+G0rY17/T6FQztrG27yVzoH5YSZdVPPJcFobyGOszmaf/GbU0ytMfh?=
 =?us-ascii?Q?xWFEms3eGjmhKJHqclJNTkQPnf0msbSwYF/mO7XvvnSkfjtaRdZ8o/n4YKTO?=
 =?us-ascii?Q?dVjB2alwlJCdSI0SHgwumJ9yq7++6ZLgUQXWETbAzrwllOM5PMRC2d4gPBut?=
 =?us-ascii?Q?OZNDm7Xz5JerQi61JJIbpuubKjBV4YCO/+f2SXXWiFnsepHsvp+tUJcnlkcB?=
 =?us-ascii?Q?1O9qSmPRzzOycX/JvIQZqEcZRvxDA+KvxyhlSpwaACY4wEb2One5V9pYOQ8M?=
 =?us-ascii?Q?02IbHYAattCJKA2vTusPKyKfby6sQ/d0tp+e6PiuGNnRiCeGVJ00dZuKlu/G?=
 =?us-ascii?Q?9bdqQPYH+Y1xLMBAD4TSVHKbAS+2nQ+DrY+XU9t03uQKT1QFf7+bUyZkwY6f?=
 =?us-ascii?Q?4fNxDK4puYt1H5YGJ/SYCRur4U2pQNNcRQbbJ6cvkhkwClf0JkELNP5cu1X+?=
 =?us-ascii?Q?tOlSSPB5CEdeyDiws7fZ5sr6D4AYehPvmoMYyv/OL3E5BdSjibv3I0hQDZfN?=
 =?us-ascii?Q?xJBMRpgDpOPL/xUpy5JkYXc2RYvRlezfuTc+Z7WOzq4syNOD8CEGksN8/Rno?=
 =?us-ascii?Q?snAN7vl3PikCI0uA052FszU+q63iOe8rjE6gSCDig/g3V0xE53xOXLpWujzM?=
 =?us-ascii?Q?qs1dDQriAFvxfCm9AcO7n5JCSPUAmDscX0vlB01fQ83wJvdkK7ca3mK7R1du?=
 =?us-ascii?Q?4OcZPoCFWokBfYnMNsLcNIfGUAYWh+0s+birFfmwb351XygCG6E1qssQ8Fb6?=
 =?us-ascii?Q?2XtMIrsxPPsS/MhYDBZFMj6DdzK+ZFU+ofV7pvP1u+9XtIoPKZV0jg/EvDhr?=
 =?us-ascii?Q?IvRA8pOGpqpBUxMbybC7yrbJxEmBdvBTTFVzYCVyt4LrpNe3QERn31WddLu8?=
 =?us-ascii?Q?C1UUTKACPh/P/Kqhiclw5X/BtJ6wpR4u+VH1L6TigldlVHZJz/7h+pfZqIfj?=
 =?us-ascii?Q?me43qqzuVmN2SKGrQ5Q5LaGG+Aa+uph1KINsEIAhmeJdBKwABRuNsusXBBXf?=
 =?us-ascii?Q?b9rPOq11LZLbsSimChhR/F4JTvU5CR1k5ejSeuCFQtc9jddWOgeAKwKFDr09?=
 =?us-ascii?Q?sn3Z0FJz53NGsSpr/uef4lQAqx6GYBrrDzdHlqDbMzjkd6yrI4IlnMZQ//BP?=
 =?us-ascii?Q?4E3BYqzAHq75/50eo45CaCUhMGgSyIHa6F5LRtYjEjJW29RoLK6cgUrjpK6D?=
 =?us-ascii?Q?VkFoVeOHTu6XFou/rhYiqNeQqFWJQOVyPVkMJxOl3lptXtMc0SC/w6/YWmnr?=
 =?us-ascii?Q?vSPMYuHXnZfKfaxHV3FWjvb+8fwGnbfyQkPbJN//PFyy87MeH39cjK9k3UdP?=
 =?us-ascii?Q?ldb433/AcshRdIJA48oFezM=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61017e3-49fe-4e48-db31-08dd70412e15
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:45:40.5916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9W7vK45whbAW8iLh/2ERe9gkFAzQ2PZEz8eXXXJZ8BZzjQc4h4y9WdUwYq12maKDvuttRUF985oc9oW2hiXugDxn+uvVLt+W0RIEuhF+fXFX8N7V8QxR2RE+LuN69lZ6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9796
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:45:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18391

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 26771100519af263e3b04b635bc917f8dfbdb77c upstream.

Drop the bogus check from object as this didn't really add restriction
check.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240423175900.702640-2-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml   | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctr=
l.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.ya=
ml
index 845225d58cd01..235cefe60f5dd 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -78,21 +78,6 @@ additionalProperties:
         - $ref: pincfg-node.yaml#
         - $ref: pinmux-node.yaml#
=20
-        - if:
-            properties:
-              compatible:
-                contains:
-                  enum:
-                    - renesas,r9a08g045-pinctrl
-          then:
-            properties:
-              drive-strength: false
-              output-impedance-ohms: false
-              slew-rate: false
-          else:
-            properties:
-              drive-strength-microamp: false
-
       description:
         Pin controller client devices use pin configuration subnodes (chil=
dren
         and grandchildren) for desired pin configuration.
--=20
2.43.0


