Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80542C3600C
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:45:51 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.18])
 by mx.groups.io with SMTP id smtpd.web11.48792.1743417941343694802
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:45:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=t0TnrLIE;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.18, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8xb1juE8nx1vhdnU2Df2j/kixRYuveU1TULjRa44/KuOOPOsjnIBb8Cuv0YeE78o+DgRq8Iw47SA5JtkB8zhppLiqT6ltG2udPfuTjuNMdMBdqKizzA0yjWsdMNxI5W7PH6TnSsGLRWPeFuiIBKWVIFLZYpy82xivoHrIPXQ+d4iyCN9Rqq3f+9c2wvw95HT3Nd18jyhdgT82JSwEyEPtHNNVOnB6K3tdAAjgw8RDjMQ1pjDqOSva7ejmbBY7hWcCw5YIV2DDHSETp3hm9eXeC0eS1bl1TM6Y2qIfKrCYjEjk1ICqMtK1Gtvb2fOmL12MsLGDHHM4cgQiLDfoOaKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CL8L9OYEFFXdz48RLOjMed5itZKQGzaOOd/R2WZY1tE=;
 b=BL8akpxA3VHYmmOLVL+wAeRCJ1ZjLsvSrfv5IKDdVqYqX2Mmbbmz8woMN4dmHeQGGVpXyz5uZTQNXY38VjxO/je2STgjIjNPUOhhQHabIAOW5aGdWRFkxDVTx5xnBa8KiYtMcKwk9L69XXnLOJe1maqb8GVjP66MgBrIrHKRCrId/U0PCXADik2I82F+27gEro5tCsSFuZud+NSNe0YPSK88TSQIBItSNASTLpR9YBxkmkTiY6BabZawRoPg6X/K5kzsBBlbM/lcfcpxouQ16zOsUK1w9AUpP7f7be7KuTtuBxb8Ttm8lE8aWw8i5BEzKKh4lvPW8oP3fZK08NPDUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CL8L9OYEFFXdz48RLOjMed5itZKQGzaOOd/R2WZY1tE=;
 b=t0TnrLIEpOz93B7f1km3xJbkfjphwDlpDVNT0tcd6sFtdYmsEeya+JkSEXPPsRo4b+HozrT1C2lerglDTgM7+ZRqQ1OTTdp5iPs7kWymJ6/NGmlJkh2V6C2pK//qBNEvSLBA16juckVSSxM1iDAaY2gMVp98eIxQCat2iajVBJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYCPR01MB9796.jpnprd01.prod.outlook.com (2603:1096:400:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 10:45:37 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:45:37 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 02/43] dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Allow 'input' and 'output-enable' properties
Date: Mon, 31 Mar 2025 12:44:33 +0200
Message-ID: <20250331104514.79090-3-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1e306ffb-df3c-4f28-5d62-08dd70412c77
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?PY5wIlDj0/+ILX1aCkZh9mbl911oMLe3Sh7YgVWu2U0zkV3P2Wn2j+4slDii?=
 =?us-ascii?Q?zcWVsWnNmYHkfxBVeDm5iQimfe/gurABTpupU2fT8sYhJhmPTYM3hY4cGMDw?=
 =?us-ascii?Q?DVIux2iXLNzgF10+IJ/sgCskQlRIgqFk6pbgT0VzHTLBl7qlmuflWnEs8aE1?=
 =?us-ascii?Q?4bNzrZCKQc5s3sqkBCRI8DfrSyzXMwwQB6ipvfuM8Rk4I3U9lXUXNZBQoCgY?=
 =?us-ascii?Q?YfH8OWkHiiD0bgO9khvcWlTxRxRNqz9yq7YEK84HAisFl8aYm3CUtSDkKmL2?=
 =?us-ascii?Q?8B+mBIvR5Qmw2CJvyGDJiBxk2yI5+rvm2cAxVY/Nrw8D3Qz68bVKPSb4nISZ?=
 =?us-ascii?Q?H+2VnM/GZyCFYrozSXo4r/8ZQ+3Rep6lZtgWTTIZdCLF5/33tk9k3cvpLaoE?=
 =?us-ascii?Q?J/83H7tqzzAQ0fQUbZujq42Osg17NL17C0hfXcZ6Mi2QHUilGKvB/O0heW0z?=
 =?us-ascii?Q?xVq4/SkX9afFovU3uZ1POgftIsk1h5mI79xC12TUWSUudM/QtkxSxw9p4Dpu?=
 =?us-ascii?Q?JMxhusZ3Ob6WYyDGkmWFMQdvgvklEwF8WEiRnKPa5pcZEauFov1Z0H6PQYMo?=
 =?us-ascii?Q?RaMdt0IgyMQ4aBJ6b+lRjehRjSW8Zxdp8olAVRumhMbYBFxd5FCPP1Ig5Ml1?=
 =?us-ascii?Q?Ucfe4RKsMZTy7Ql4chaeOf22GDm2b1nNSMAuoqaQvS/nJwxgOoZhqEswphZu?=
 =?us-ascii?Q?RH3jF2LQ0qYY0ND5n8ll0/B1UmIY+qvRV6oHjXEVw5vlk1H1Yg9nn3YVr2MM?=
 =?us-ascii?Q?MmpUfo1jb6OiM42K2rSk36xG7OSyBgZ1bkO+vsH+NWFOPBRuopyNGHwSn4LW?=
 =?us-ascii?Q?Dcyxqadb5y/ZhNT37HO+mZ5X/suJC42eps8HqfCEtumrhBWRenlTmNTSP1Oo?=
 =?us-ascii?Q?DWKknSjYsyQ7+volKlyj/rU6YKTDBpZ7p3BS0ILjqW+UMFxvCF4eMUrw7Nv6?=
 =?us-ascii?Q?ur3xiNrX4ZniCYos+jdWPQ5U92HRGnVt0SYczuWPIu2cRZRG5lCD3qaR96Aq?=
 =?us-ascii?Q?oEDOMYzz85HqVzFMFrXb10X3WubgNUuIRtsmPvqdspph9ZN9oYaKd5ucxomY?=
 =?us-ascii?Q?n6+9ubtO9Dfwbz3bQi5drq7b5XWNuyn+NWEJREynwSVT8/U4u9xlMcSrMui1?=
 =?us-ascii?Q?B3D44E8rulyqIHsiAybXTg8kV8B/m8F9XaZM1bDYex2pmQaQoJDwGDsDzN/m?=
 =?us-ascii?Q?u6FW0LegYEWXJ0INqTMYdkkCOMu/gfTSu3RMXD2544PTLYcy8cDcRxfqmZ9I?=
 =?us-ascii?Q?kkK1d9nP2xMvZ7bwtiYu2Fq1UUV/nVew50GxeH4qFG4ZI4vPJYWPxzF1XCFf?=
 =?us-ascii?Q?vymin7QrBXoOnEYKgLNXirt+l97cwS5IpoTJF4DKc785X+HJIqqOMkwPPGrN?=
 =?us-ascii?Q?qRcmxKqg28i8/dmo9vhlYtcnhavgu5uxD/jKgq7fQxbyFEE+A9iKoLH4dAvi?=
 =?us-ascii?Q?SQ2fP/hf6NyG8maHBVLRc2AR80tkAEVq?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GJ7wtfKKSEGE/uJpGPyaK0D/FV0uIrFQhRib6NJbe0tVP4RzYZDaVkBsLrcN?=
 =?us-ascii?Q?g1g3dYcg1Shg7vU6JJyhDVY/utt8cM66sMYuVc0sUvKtEuFke/TNcqzkWSY4?=
 =?us-ascii?Q?qAMZHXCZdVSAsyt724+LWT4fl5VA4sUbcN5DH0sh4Hbse4g/F5v5lYHgcjJv?=
 =?us-ascii?Q?AqlxiTlVZQcW/VhoGa6fKV9KDGCsloDufkvfMVAqFVmUAnbl9OY8+XafgwpW?=
 =?us-ascii?Q?UoJXS+Eon9SIODrKqBBXRa5SEvgxoka9smVnyR7TMmzNkDRtEhuA5XEVSDjX?=
 =?us-ascii?Q?Fhp9qwiLay37hGo6d5vb4BdhHvXGIzCQlwV00o7QggLjv6bjtqV61FNhmOc8?=
 =?us-ascii?Q?EBam5MPxiK4y2nSqnx9u0xxVCXF5p+QTW3sT8x2w6LsKCvr97ypYY5yH1cIT?=
 =?us-ascii?Q?+ZH3xWn82reX1ssoyh4W2A39ifkfoGiKkAuf6LWGvqgIsd94xlvYyXKKWylx?=
 =?us-ascii?Q?qmFZa/pyIu8nwojm8hXlgqpIDeq49imBDC0x7VxYnwSyZ9lGX/rL3cOWBchR?=
 =?us-ascii?Q?J1bYF/suh69jIu2eJdbY/kRbVFcqYwUOoSb8LyvApzlrhR3qhSoJkGS3enHK?=
 =?us-ascii?Q?YfBjHx0+9gDt0/CSHCdPweJ8DPYV18c3e0G/4Z7q0qSTklqmI7fGYNPadsAb?=
 =?us-ascii?Q?X9nfuOvnSse58viMd+IvgL8QoaPkTnldTUoUOiGc1VVDCKT+KUSHxiNQcMzk?=
 =?us-ascii?Q?RxpVAzel83hc+ynNVFrqv3Rl4z7FgeYe9b6wIOTLVHd7+GQFkgu7tyZ3j8zG?=
 =?us-ascii?Q?R2KXrxs9IfVTaLdvoAKju7WLow1KCVU4G/e/wIi5JAfPYQWLXS/74ZLW/Eoo?=
 =?us-ascii?Q?bpR3/7nBoZ4LECExoyeVGdDl4J3CPcx+cwFA3hvJAReR22BNQbNjAwrwi+HA?=
 =?us-ascii?Q?dtJ3eZQcuL/uhbRvK4G7A2v8fmSOP+nX14MhyfVjXkrnJ4KTStL35Q9wejB+?=
 =?us-ascii?Q?g4bLkAXjy4bs319nM0uWA59tyMqOLtHm9/+5ODtcVRaVUJegmwSHvX19PtVt?=
 =?us-ascii?Q?DNBa4bZ6ASxjShdpQ12Bsie/k1446OmUN65mEGLW5/m5VF3Wcoz1uyww8HJB?=
 =?us-ascii?Q?LW45Kw1EsHA6G2u9I1g5YUNORgyNmTcLnkrdtlUqG+L2Qg9NmkM19NaS84NZ?=
 =?us-ascii?Q?+7U6UMclsI6hB1HJB94kxIVC6ArKu4ZADdW2Ks7IbObYzwhDw3pqBSe+wgCK?=
 =?us-ascii?Q?Sscc3sUhTy27wuKIH/ZUXI+ICdcWUuH5rpU24HsFGRX0biZ6y63eYFLf60wT?=
 =?us-ascii?Q?h56cxdh05g7nSFqA9sROpvumRxsShMUZuTnjtZLH/bx9nZZRBoDH51bbdzgh?=
 =?us-ascii?Q?aXBwlUxqwO5b4i/p0acLvr7HXePAbGJc6WvidMyJ8p+UuCiMdpC60U6lCDd9?=
 =?us-ascii?Q?io1V2ORVhr83ly9pi+ZnS7TZs/fctnKBnAWMMSS28YuOsMQ3u7xnGemvv6NF?=
 =?us-ascii?Q?2zo0xwwuO8t064JaJS3lJ2rmgMWFxSc+2+VsvHDKVqgDzjBRiIz3O0PLySL7?=
 =?us-ascii?Q?C9W/DCWbdgnH5/ZhMH1P7AIguMyBYWHrFVPmn1VgnSScvjXO6Jm6gCTDsQZY?=
 =?us-ascii?Q?1FCXgJorVZwCCs8SOrWKQqA9zVD38+WQm/FcmgWINV3U3uP1qNPf+6+zTQKt?=
 =?us-ascii?Q?8IWhvVQR29eFIs/IUn7x0Fc=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e306ffb-df3c-4f28-5d62-08dd70412c77
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:45:37.8620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DM8B+5Adx5A0in7PWDeSW1iZbdidvaryD0YlZDHSYh9HMs4Em7t8u9kHlHNfvN6u3uOSivyfhZ7PbfcMWXz0NfT3EWQH6Y5x8xI5fSPurkGPg0DvwbMFB8kyEjXokprA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9796
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:45:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18390

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit a76932e45e9b56ac24ee947294fbb52c3713f839 upstream.

On the RZ/G3S SMARC platform, the 'input' property is utilized in
gpio-hog nodes, and the 'output-enable' property is used for ETH0/1 TXC
pins.  Update the binding documentation to include these properties,
addressing the following dtbs_check warnings:

    arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dtb: pinctrl@11030000: k=
ey-1-gpio-hog: 'anyOf' conditional failed, one must be fixed:
	    'input' does not match any of the regexes: 'pinctrl-[0-9]+'

    arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dtb: pinctrl@11030000: e=
th0: 'anyOf' conditional failed, one must be fixed:
	    'output-enable' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240313083828.5048-1-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctr=
l.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.ya=
ml
index b8937e01be922..845225d58cd01 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -120,7 +120,9 @@ additionalProperties:
         slew-rate: true
         gpio-hog: true
         gpios: true
+        input: true
         input-enable: true
+        output-enable: true
         output-high: true
         output-low: true
         line-name: true
--=20
2.43.0


