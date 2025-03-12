Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51426C35FFA
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:26 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.43])
 by mx.groups.io with SMTP id smtpd.web11.34866.1741778814555193267
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:26:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=n7ZuS+X4;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.43, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyTFoLR1xDeNzGItaVICZ+D46Ocj23GewqIfBh4knQyQa96owzN0rItxFn/xIqpMLNA1zAKafWeJQHCrV572UKB+VUeL/N1eWqBJQpdR8NZg10IKFtwc6ZjUYtmXFTyzpyh1PT5jv0rpzNiIK3IdWxrJrXzmB6o1QsSu75D06xqotupkFa6ozXiIRk4CKb0mVNicLIpV6pV/6SQS1uhrRS4QT1Vbc3IC+xkW2ZLFRwTwHIe2Ie0+47And30VyOSRJKk4UrdQbiSgPparjG0QYvvRLUrOyfs/XtChQJ+TnhkvwugWMUgQ7gDOHMD6Ac1/93TekrrxLAxkIA2yKmH7Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhWE05paqSoroCW7spMzwjkXeqVfsCKGcmLbOdJyQQI=;
 b=EYnff2y4SGXNZ9bZtmJb6beUuFSSh9R7pS3B/1JAI4ZN4ZCRVvL3Mcy/n3XyzHPmzdn/0+hSrbgDcZkXSxpfSXi7KWHyrP1/iTDi6mlHSsYDH3rmhOr6Ir84xugqTNNFhLY3NGJ1drGkz3pu8eS/Red3R1StRtF8q7J2eAQxGN8bynxsB36liH5YVgZNSiRZnWhTciEyp7ARlY1fJJXt5NatcPxGUqb8ZPHao/08djShjMm10tT5/euf29pEEAhCg6BBLBtitSi7x6D769QibuMM/hXrE1Et4mNPYzSZJEDsNq8wULUfVl+M4am7eccBUL3E0JstSH6oeoZNPelNbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhWE05paqSoroCW7spMzwjkXeqVfsCKGcmLbOdJyQQI=;
 b=n7ZuS+X4/xg3SuEocD3nQMTaKvgKPnf5cKHx3L3I6T9eCEWc2QNxs/L300LgtNoGHumNE1jv3Ox5+nNsOfXOm+Xe+/LoEHGyLBwSc/U286lAx4qtYvFLYuanb+VnTMcIBoWHG+hO2IvSUnE1urXSACrJEPLH6TWdPjfPq2iuRo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13175.jpnprd01.prod.outlook.com (2603:1096:604:30b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:26:52 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:26:52 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 67/85] dt-bindings: serial: renesas,scif: Make 'interrupt-names' property as required
Date: Wed, 12 Mar 2025 12:22:44 +0100
Message-ID: <20250312112302.1605750-68-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB13175:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d08d9bc-730c-4c09-5fc2-08dd6158c989
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?QHXafow2rWpH1xSq9pssHtQ4YvoAHqHTqJcvDzPt8/JwDhyQsieyvZdGMf4S?=
 =?us-ascii?Q?sEZs6lFh7HDZLDk23KmORFZCIPiSM99hxHr/EsP05pNBQQUZXZRxbyHRiaaa?=
 =?us-ascii?Q?tUQaIkAupU9jAe16o1ps/kXQcH0PihRX5QxrqVZZmPODYXQn/vHZjwQFi78I?=
 =?us-ascii?Q?U4QiNkBHYX9AtMk51ocIHuiuVcianQsAIdnsi1ahho5g/zQ65cWaZTC2UkkW?=
 =?us-ascii?Q?Jr4T7LJuAd18nAYDX0JX9ToLzP8UXTpHu0gJu+S9RjbYckjegEs/bSayxgNg?=
 =?us-ascii?Q?NiA7pU+t1a22rTTlQGJgbGoZHLNdBIkStp9EDH242YdUG58GiBnd8aIcYsAH?=
 =?us-ascii?Q?AGp4z6ywK8ke8Vrkinc1tM2ReoKgQmeGhE/1Pl79V8yXH/jnKGEpmF1SQFEw?=
 =?us-ascii?Q?rQM3heKA+PyU+5GFxMyFT17zwf/JwP5wsGeDKgWonIgRNu9y91wcTduE2672?=
 =?us-ascii?Q?NkKzx4zbTM74+cb+BXM8k+wIKOSViZrElaJhNypOanyVctBKsuLfNZKMTDJs?=
 =?us-ascii?Q?pOloOdV3/sTik8VvLqCyHhJSNPoFl8DJVcaW6pqh9qxzLl9rZhVdNPWW65q7?=
 =?us-ascii?Q?UprbHafRG/hdiGBjglIEB9Y3FNpS8f6Ew5SWqqEpH9p+R0UkmMDjzdLKmHeJ?=
 =?us-ascii?Q?QchNWEtSAVgrQREoXp5C/7KXS6PjOVqvz03Ajv1iAU5v9VTcce0tQ9sRNcEV?=
 =?us-ascii?Q?Q8+c0Mi74bCF2s+0lrHJ2W8yodV88JFCvbtmIaEPE7HXBUiX1LO+gzW/Gyw5?=
 =?us-ascii?Q?AU1yDjSGaPhDfWCkfR6657WQy7fm82if5nEARWJafVkJtG2UvzXvmsBeupeG?=
 =?us-ascii?Q?hy1/g2lkKm3k9HSruu42MYEa//bZg9pNMHc/uTONeXk0j8DEkKD9gPjZeXM4?=
 =?us-ascii?Q?0Avx5Vcr/ZmQlwmiejLJZFclmkTYmlkh9f4E6ESE4IirmSybJh6XVXVabaaD?=
 =?us-ascii?Q?f/J5g90iDh5h+q3eRcd4ggUSrKum7sMFrbZrNZT299bWa9hqDHFjawnvZFN6?=
 =?us-ascii?Q?uVIYconPwNcqn0jziL+FnRX05nVR98CMYv8KeT4XjcAKSMEOkjRuVc6gJ4Cy?=
 =?us-ascii?Q?pyEKuCOxwI2qr3L0CZ3nPPsjSyHL+nudgWEU4ppOQMAG3VY18cFjzOGKReuz?=
 =?us-ascii?Q?NJEWlsEVNU9cJrOJK6X8asanttdNFDxs0856Ge3I2H2gbhYhDw/d1fkwAVhm?=
 =?us-ascii?Q?KeWZlrFU4ib/cCvKo56ev23swzEe1Q1DR0+n4ryP4Q6AIO9jh7NpoquZ63i0?=
 =?us-ascii?Q?tbA6frfwbiA495iGBNfp2J7XE3L+IGF4BOgUK2m6DZKGKK69956cHsSDw2hb?=
 =?us-ascii?Q?SxIyIAyUXxRth9VOC6X8f6K4DtiAh7/bx/QIpb3J0RIQxWLIM1KoZjOTkiVL?=
 =?us-ascii?Q?wxuJQa069KOI7RU3rTUweNuX+wYB6emi7JcJo60pd0ysXpAkn1mPRbbRDJJI?=
 =?us-ascii?Q?/h9F0/OvyFp+jacSfLc+r5W0urIX/sXp?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?avR8XoWBDppsXg89/kmPkyJ5jIBPL6sD48XPqLhsfhY801Vpyy/MP0Y9GbHg?=
 =?us-ascii?Q?UeoS7SS/tj412OPsekjfkAdj+qS69dFbTJ4WWp2Ocrn0H40cvUkOnLlfRqC5?=
 =?us-ascii?Q?sy8dMqg0jgiqnauMWA+TKN/m5AAzfvd9cOnVdQlSZk4Ykibnw6lM7+0DPJn0?=
 =?us-ascii?Q?5vWEgGHXXIOGbaWUqyOpcy6aFgfVABuUoi4gJYG9qengPv9vV8SNifdUyVPu?=
 =?us-ascii?Q?VZy7dwgRe4UTJRT10sZcmwzE1X3xpzHPakdWi9/JBsP04FSjX5t2qB584gCr?=
 =?us-ascii?Q?kSii9s8nlsig/Ykigb3HCo6mWkeK7AFYMXJg9FAO/4JEJEf2+hWriPlfbya2?=
 =?us-ascii?Q?eLIKPnfi2eOlDRPR137eTWVH5fohQpnTNwupyWhWf1SKmM3aWXp8AqNuRhMo?=
 =?us-ascii?Q?a2VVpPBr1ZbhmzxBKb/SkCV7QQMnIEwzi2RdcZlPE6Tt6v/HQYE1CaFHodSY?=
 =?us-ascii?Q?7CfJNFqhUT9/ZvPlnTSwKvXtfUemMort2ompccRfyBiP5UpXHlC8v+I/UTfC?=
 =?us-ascii?Q?azmS1psSMj9uYxPnBkuqdOAgHLpqmmJuZaLF165FPvBQXnud+nJr6LwGVERs?=
 =?us-ascii?Q?C8jh2mke8fYYgAY3ibQyu4HP0+c68GvdQCibCLckFqUokHTpQn0dLrLm8rrc?=
 =?us-ascii?Q?vMcQtgh7YNxmB/2ehZ0d/saf0x3wlqFGGrmaC8IOAN0GRDmCEiNlrxFCaB/R?=
 =?us-ascii?Q?fkz6qTcQwse8kqtR8q3TiTWKuhclkiCuAmC61oTiUq7CMMtehJMn92PctAUS?=
 =?us-ascii?Q?vKEybtnb1P25cG5AXTAv2tTXelumnirjY9QrLUjCWphD6B9tSHv9jqPz71Rg?=
 =?us-ascii?Q?Z1+54ThczIrrPxVqhKn4O16dHcODadYjG26ukvYeQjCARSLQqzR2HbryVquO?=
 =?us-ascii?Q?ZPoUUE76bz3NG/vPCPeCxKpx7CIKrFQwJihNBfXuH3b7JI0VJtrfKQB8VXVL?=
 =?us-ascii?Q?zYhGETwq31hQxPtqr/I0rjNiN7pVJ3+C8YXLSo+oshpoqSdcLfPX8VjbqwpE?=
 =?us-ascii?Q?7cS9xIx+bcM3FLI8Gm70GI5vyApJmnBUoxqdKiQZW9AT7KE8WwkJfkwAehbf?=
 =?us-ascii?Q?RNNib++KsryzTnEm0w7v3szfhJoCZVVcE6boPbb39PO4CvgTqD1/AjTl4K25?=
 =?us-ascii?Q?HxAPfS7Ma6qoault1Xd6PLZZU05W+8slmrKcRNHrRdHnG1OyRsW+w/WKbyW0?=
 =?us-ascii?Q?4Bmx1oiIbx2+Zv49PyOynJQPCqavgWyTxwo+NPpD9niKHiWD8gfN8TMiK6UA?=
 =?us-ascii?Q?GaEKZc7KmVckYwY3x0FY2/3pJlBQZgO9iP6MvXttfACeMZnmz6+iZ3GTBgtn?=
 =?us-ascii?Q?eoUnvy10Grq4sYA+dZj1nyipUoHPI2qP2W9v3cZfA2rVVg5U5kudublY+sgp?=
 =?us-ascii?Q?rYku/TXZfoAsFHiFzAM6wUvPD0ZSlErQe2aGdThez34hcKIMA5brMUAOotE1?=
 =?us-ascii?Q?Q2nV9GEiXhzm/UpSU2QF+RNvMxnUYLGBFavEWXqQW5bZBnoAfQkavlG1x1+Z?=
 =?us-ascii?Q?4ak+sBE1zW1T+jEeGso5/8l+U8HmWqiNDC9GaJaHqBFek7wzokgNUWOI/+/Y?=
 =?us-ascii?Q?twBNQ/cB1hc917ATQFfv4fruIjJhE3TQEE6ZWnRW7+I25/N+GnP3FrOPYVdZ?=
 =?us-ascii?Q?1rPgjYtwTO3tlwVNctFT/rs=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d08d9bc-730c-4c09-5fc2-08dd6158c989
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:26:52.6410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMNqdbOCvwe8VVOYruZ3Z2WnCGsKLMXlL4HX9kdhVq6ZFInLFTR+B4yyU/yAUv7Z68Mse7aO2uOVr9l4F3MONLz7eCBryOxR9vxdf4Fs8+nPGP/NE61Hmh9K0Aydqx8Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13175
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18159

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
---
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


