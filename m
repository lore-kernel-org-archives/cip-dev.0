Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C07C7115B
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 10:29:29 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.19])
 by mx.groups.io with SMTP id smtpd.web10.16494.1750674568112961336
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 03:29:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ljJoKkeW;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.19, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7wSPsicJts0cUzxBJWXass25RAnAC21O477mrxU35IbLOXAHPyI3HdB5TDJN5X4WcFqlkNRuo4XpFHRLvMqiUY3XzW4ge2LOP1ieipC6c6W2YUmno68gW4RQEm//O7igz1FyvJ3NCCAfwonuWXbDyfIB5x7IXZNp3AhwUI3n/LlnXa3acskyABwqHS2So4huKXcV7pB9qN0COukt6zV2+7WRcdWdwKR80cUplu7HUiuk6Eq9xpbi9kWikiSvOQfVmVYN9zpIJFZuHsSXCRy0AT2oi0oD71CTQxQqotQ9HnA7tLKx4U5BTmvXLRdqUBN7W/zw1lzIvu5kQOi2pt2tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7RjadAbX+aqLT3H3b9pY1b68il5GNqmqL3UNJfJwNg=;
 b=y+ImBrFFY2dC4ppXRejR6p2IkBRAa1jl9+QL+XZxZYw3qHJVl7mWWf2lQG9TxvTr7ov8o+q2hUpyvu5BTuSV7zCbJ9lDIxUZbwYpzWhpdpAGugElJuh9n4umstmWXF+C60VCWoKCbfflQGQbz3iCU4/UvTmcXK8xnEKnzEBegXw9VWJSJVQb06PsHM/IQ/ol05h3eOranYBYWpxH3STGas6HvwhyeAUYrGoEeLVU22NIcWuPX7DpCEZYM0tGYFBoQtaFPmymuk/itRniOCiIKQunvfnyCAjUveqcGg7cBXD2EWlnICLYfvkPJBUtDIghLZ40smoE2ZKGiJDz14oBSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7RjadAbX+aqLT3H3b9pY1b68il5GNqmqL3UNJfJwNg=;
 b=ljJoKkeWndfJ9KToXIxg6+mLfz1vOI6SWyONgGdWuNIsfXMqJaEyacBe5ChsqYLkYLNMOKbxp1++U/1J0lWN8qTBDAS/sAO6LAdeu2NoVTTrRKyFNFDcsyvG71ENTorbXocvpiT/wXnsaZdOMV9xm1o5m3maxRzzA+nDgUMQuJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS7PR01MB15129.jpnprd01.prod.outlook.com (2603:1096:604:36e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 10:29:21 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 10:29:21 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 2/7] dt-bindings: watchdog: renesas,wdt: Document RZ/G3E support
Date: Mon, 23 Jun 2025 12:28:51 +0200
Message-ID: <20250623102857.1493371-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623102857.1493371-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623102857.1493371-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::7) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS7PR01MB15129:EE_
X-MS-Office365-Filtering-Correlation-Id: ae662f54-5f32-41d2-731a-08ddb240d107
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?pLqoq0U9ZXLxV7HRtk6rAOXDK4ld8imM7a7t1PvCzRMhGp3kj0OpylrKdkQS?=
 =?us-ascii?Q?sjx7UGs+q5qhIrHEgCFwIHORxvXYv1ANNh0sesY9kwdCU95ey3EAIwRuu4po?=
 =?us-ascii?Q?9jSnQHX1SaAvXGVmkixoV2OlB1UDErv/mzoIFeggy9Yer0juyayRa8063SQ/?=
 =?us-ascii?Q?E6X/szdvBX4ZQZ8wVRY/NYey5E0s2VqNKXFZimWQ3Xu4YwR0IAL/uYxFUPmP?=
 =?us-ascii?Q?g/5BlnYmR9bSy4vkadg1AUitAARwAf+v4+cdSYy5D80H3fstqTbLyiCM5ciK?=
 =?us-ascii?Q?4l4PFfYZXhED7ToKabyUURhjOgrpNL4Kn2aq8wKMQPbIVaQCdTU6ctY3oGJ5?=
 =?us-ascii?Q?wNAa5s/ELmg5kPNOb72oAjFve2XaDGwUJa7TZ2Kg7s1NsQPnap60u/2tIOjg?=
 =?us-ascii?Q?gK5mrFUZX9OjVYTo13/R8kpuTQrTXzUkQYNCweW7zHdom5WPanAQebYmKKpA?=
 =?us-ascii?Q?tWkr27EaVxxGhSe9GYihOz42YlUpVqZ1AyewkRYJ7NlroYsQpJitdXxxd0+9?=
 =?us-ascii?Q?s4+c3zHVLkTNpBCtc5UTa4VVnOoFoUD0/g5HW2JP8QyDmxVyDSE5LuOENtoo?=
 =?us-ascii?Q?UxcBihU63sFKisPRhGIYRKc/GMBfO6GQeaiacRvXcCtZbm15rNcdNxcmJNIk?=
 =?us-ascii?Q?mZGBGDTjNTMKssYhwEa3YXob5Bh7dTsbrlojMSoChenRnCFX7LFoC/BtvmB+?=
 =?us-ascii?Q?QMmukTPZw1lE0ae3IdFdt72MibS6rUezkEtCIBDfS5VVnJ/F2dMfui8z6gxQ?=
 =?us-ascii?Q?ePM0UnYIvY8BzHUlM7CCLu7YnYcaGTeVbxvSFXrurKXguaZXxG4xkDB6kAep?=
 =?us-ascii?Q?S3b69Lju7c23jHh7BqEuJpm8LwRWUepYB2yw8F5KAe00oB82yLC1DBIAilf7?=
 =?us-ascii?Q?bLNu8VMYxdrE0wiWTPw+1I50ow+sAUDlPcPrSPDx6bekKle62gFigfDq3JZA?=
 =?us-ascii?Q?OD2vp9TGJuB2OfhUxYfQIvkTWyCRcaiCX5pbx4Dxa634rmocP1ELbZoqeOFW?=
 =?us-ascii?Q?nPJgAjGloC19La0TJzxk9Dkwnpc58LYH6VPjot8cmjlaw0Teszz1dmNwqC4U?=
 =?us-ascii?Q?HYjUIeLm+YXlpv/H3RH4lsTMOw3GeuGT+RLfnT4A5/h00NDvfiIkP1kDnfbv?=
 =?us-ascii?Q?TFYQYw9TexXwvepDiw9aVVgXWTvVwSw7wAI7PdPqPjI3k9uWeMkR3EFjx7iN?=
 =?us-ascii?Q?Uy/vbZ5fQtDdZ9oQd3XyIF1Xgtb0Xmjwpmb16mogM6y6uGIj+7z1GUaYH0Vp?=
 =?us-ascii?Q?v/c9ou5d0MDX0w0O/X+EgVGcTZCopiScf5h5ecXB4rc8HhsANlBzu2joQOHM?=
 =?us-ascii?Q?BGr9VnqyBFYrA9FmvRvN6OYiz40cNi722lNs65PxrDOqrSXAwzL7w6iwHYkU?=
 =?us-ascii?Q?UD84VO3t5v/MkEQ07+yxkyQp8ai09dulTU+Mi5cR56efhYpWU9jgsQP4WnWx?=
 =?us-ascii?Q?1Le99LfcLOuNydCFD4Ro1rkBNXPo+WwLJ9GQV4Jtzfc4pEAAafl7r1FA4bHV?=
 =?us-ascii?Q?ILfCrhKsAt79L1k=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sukL6CcsxcaQ4j2xyY4/iFw+yHk8RyIggZrZ9qiLMHJnmAr13ETGOUfGTnm/?=
 =?us-ascii?Q?JEmwLEvBKiLRFGUpp7eS8TPWeUbnGxL+OujZNrsziwh1BQVkyFYVbTB1uncV?=
 =?us-ascii?Q?N6ELJmAxOKOeUDQPWfWbr1RTf7PBgaok143VQ2kQBnMSVddTLxx4HQYSjLhf?=
 =?us-ascii?Q?po7IwQvpwCL/OrCFBsPxaGy6y1NYXlCCz1gk71mA7NwInMKgYx6el3mBUQg/?=
 =?us-ascii?Q?YQTYFGZr+ae+ILWS6pB/7lvypReclsXJOF80TkUf8ldLZe1UMAMN9vj68465?=
 =?us-ascii?Q?G7Q3/I3nX7yMeXJH0x3rjXUIqDoJO4cI6gEPiiurvz3UhwVEF7/jzVXtPfD2?=
 =?us-ascii?Q?8JMHfu/g7i2WYSkNVhi3oB7+Cu9OIoZQIE8KjBSW546OkUIVnDhxQwsM8zWE?=
 =?us-ascii?Q?TqOqg/G1N/uAcIXerS4A2fzrBTSbFlz40/0g+3m/7BXMehzNExtgQb9Zfymw?=
 =?us-ascii?Q?vNWw6jMojKrJEdZYCqLyzyvKgNGwV6HTremUsUqhYkCE/e9y1N/gSJEYg4G8?=
 =?us-ascii?Q?efzmoJw7Ls9R7hHmlWp/hebGUEdr/psbnI/pMhAj8elLJa3nhMtuFR1uimJr?=
 =?us-ascii?Q?TwPbRfDb9oTHdaV0T5cmBbf9mcNrcqA1UeIajzgHI+WnnVNw2bPGfdpBkJIg?=
 =?us-ascii?Q?DT7AvK8CaYQSC1/i6xHs1gEthDHYbcr7FhUA1Btqx+KmULHPI3AgvkK+MChU?=
 =?us-ascii?Q?nP3oFGA6ePEJ2yP2YPMEf3kfsQLnnFP1KY/57IroJCcdZ46BlXhMWC1x64uF?=
 =?us-ascii?Q?z1Xe4gMdnGMbGeTfCpsW8Bjm5W5XoHiY4fdeHgKsiaeQY8RmZuffbckMwB+E?=
 =?us-ascii?Q?NEQg5OukXRO+73p2SopYp179QU5qLnOJd7TNQaf2vu5ruK+mOD+nF2jVD/+4?=
 =?us-ascii?Q?gQfrv2x13MOO75plGLizI+Tte/75CZanX7hfKWltIZ+UaC/xo9xv6QgqQacv?=
 =?us-ascii?Q?mYxan6CwKWUQ3Zqv8P7MHR4BE6BOQug7Qkzxk1ybKTTYakpdO7ADromFdVgO?=
 =?us-ascii?Q?2pF/XrnjAEGHlFafje0/XZ51FY0mlWDNOFq08snWNZZT6cCfTd2tC5+4vS6D?=
 =?us-ascii?Q?k3gIUwGGRdyq25xMIiLDgJ/pKwh6KNPVuE0O/pDC9ZwEvxmYicMHUac2iBd3?=
 =?us-ascii?Q?0mQP1ulqnQ10DDMfBXB7AtejSNlIkYasG97S9TKgvuT6Djuhq5EGjoLQJSTY?=
 =?us-ascii?Q?xEdd1bpKumrLitC60ruqWuZp43eNNgaAmK4o9d3WJxd6p9qFh25C5ejKJ0LH?=
 =?us-ascii?Q?RBKzFepq5Tg/WvoxFntJyID3aJV07+ChmbP4flSgAU39p0JD0bcwh1YT5fxr?=
 =?us-ascii?Q?t+6koJlQg2N7269Px+cQk46zo/0GUnd51YcI0LXfsN7k9OkGObByfeVMq9a2?=
 =?us-ascii?Q?l9Sl20bOTNS3q+WvBeJIWpbZ1pm3yWKujwYrWtHdEpclmmK1CATvCiVVntNX?=
 =?us-ascii?Q?hNEXfhsNsUnCeVbgbdjdC+lC+5xrP582OWH3Q9mZGsKOuJ6oMvNWFZHWz2XJ?=
 =?us-ascii?Q?qgAjwyt4v72z2t9JKPf/Y6GtNhATFY/B0WIBvIFc2TYm2grhIJceNyIgM68N?=
 =?us-ascii?Q?IEuMFvbFJgIRgPO0Vh3rMkz3prk2x19IxQZ9XDVGRzmhwEpTIXLpFUtbNrmt?=
 =?us-ascii?Q?2lDQgTs0ATSgzBmwO2GYKI4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae662f54-5f32-41d2-731a-08ddb240d107
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 10:29:21.2423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7fcT4YFQwU9TzcB4X3wS26DsOLkvCeh0q/AI3JfGXgYPhYOy16ho5Jf7/8zYm7EJq3nuhR8S67qjWxjaJYSIimt5mw3AP9dldskTH5YKhHeHMvrGjCWVUlb8txC3Olq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15129
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 10:29:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19176

From: Biju Das <biju.das.jz@bp.renesas.com>

commit c40524d1615a72548adc30dbfb15c981fd03dacb upstream.

Document the support for the watchdog IP available on RZ/G3E SoC. The
watchdog IP available on RZ/G3E SoC is identical to the one found on
RZ/V2H SoC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20250126132633.31956-2-biju.das.jz@bp.renes=
as.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml b/=
Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
index 29ada89fdcdc..3e0a8747a357 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
@@ -75,6 +75,10 @@ properties:
               - renesas,r8a779h0-wdt     # R-Car V4M
           - const: renesas,rcar-gen4-wdt # R-Car Gen4
=20
+      - items:
+          - const: renesas,r9a09g047-wdt # RZ/G3E
+          - const: renesas,r9a09g057-wdt # RZ/V2H(P)
+
       - const: renesas,r9a09g057-wdt       # RZ/V2H(P)
=20
   reg:
--=20
2.43.0


