Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE26C83013
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:38:03 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.44])
 by mx.groups.io with SMTP id smtpd.web11.20599.1751452681159212894
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:38:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=MHQpJV5K;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.44, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snK3XsVmDpZsFe/T3i6HW4huH33si2ihNtCKkvoHCZY1XhpHURmox4fKw4lqjVijSEmj8Z3S1Rb1Jcm3uVbU4D2vCD4KaKDI7fOQbDQ6sxXXqxBpunyOlM0CF/AXdWhU+yW94E1RMFMw8LfvGBIErNee1au/Ak1OcrHaDbWiIDeLTB5aT3C/V7YfbD3RFKnYGyagG3m/G/pmH2J6fLdYNJyvl0EQak/b02m3NfYVPDP7yRa9/2kNLKFQCbrDZzonJ7dOxehis2iNjptAbDeWVUWTU6vQ4Ixaa9n8sUb2jO25XrKli2pZ5lvkCs9vibSCNTsQ2XrJjBR89WjdQYM3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qg/WzrdNrFY0SgmQZFuXjCzJStjbQ/QXLf+xFWln6eI=;
 b=rfkn+pXVWdLykU6lREAfJG1RWVjrxevOURckMTmjTtfvPJIDdR4XjH3zQ+iD+T3069cyV+jpmyrA/EFmi/Ohf4DHSQdFOTO0cZ/A7jBx1x9t0H4TMauEATYEKHok64FuLdz1O2Jm3De05O17gbuLnTFGyrcrSEuCfZcrBI6uljKZ6L+TNcoGHOFMCadbk2RQaHh94Gpq34fSBiw/7mP+YW6tvZLPQVuwSxgOEPOkK7mmocFweU3EHJwLiGyQGdi3liYfpCLCSdaAzIuFH7rrjp3UBIMJ6za+tNM7+n5JsTLxVTlcENGOWUmnhj8ODcHqIUCHdvQk1jTP/DR1q5NLIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qg/WzrdNrFY0SgmQZFuXjCzJStjbQ/QXLf+xFWln6eI=;
 b=MHQpJV5KWA+vE4bnYcsRdEqDVVuntS9pkJUTT9NH3JCn1anmlzf492aqE455U8U794YvppGNpZxF+r180CiDqarWdaXp8CLXlcNUu+B1dKYTS7maxBMf+T5zYJJxbQc7H95hJmKtg2H3wCz+RsGLSCpC+69LYyUfwEfziNPV37g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS3PR01MB10187.jpnprd01.prod.outlook.com (2603:1096:604:1e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 10:37:57 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 10:37:57 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 10/12] dt-bindings: gpu: mali-bifrost: Add compatible for RZ/G3E SoC
Date: Wed,  2 Jul 2025 12:37:08 +0200
Message-ID: <20250702103710.117760-11-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702103710.117760-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250702103710.117760-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS3PR01MB10187:EE_
X-MS-Office365-Filtering-Correlation-Id: c4bda00b-883e-4d99-cbdb-08ddb954829f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?DFwLsI8vkMFnEQCoFTNkGSA6jLJoZW1R22iymTKjG1xgMj6eI0kviRktA/4B?=
 =?us-ascii?Q?1sQiL30IkJ/ge5TDSRqlGaoNBHTnEU8XZHMVfVQxMmFFcexJOZ64MtUf9wzo?=
 =?us-ascii?Q?HYMhDfzQT88RfWezZenaxOrjBr6D08PggshTqOjoqdPvuhhGWF3RTv91D++4?=
 =?us-ascii?Q?gRBblWmNz0Z/wjcZUhJQGt8kRo+F2FM0WVNbF/f5887uqLAopDCo7C5YA+Ss?=
 =?us-ascii?Q?3JnxcEdDhv7gG+ctpC2CO5g20svuP97aQ0+qnQxVs153YGRirdYnDfNOU/sj?=
 =?us-ascii?Q?K1ECRYqtEFZtFs3Co1nszTNN0bjzvS65de6ejkbMPujASWhB6YAWm6+crlxJ?=
 =?us-ascii?Q?6ffQZVQiqchOvq3YO8ePjaNA1T/Up4Rxw45cQUjViLHrq4TT6Xgg5olZyYfr?=
 =?us-ascii?Q?eiU77cx4mj6wKgj3cwlJwMyaUGHhdhMPAHMSvS9kXBA5poKqyhrIBvmRyrvP?=
 =?us-ascii?Q?aMZjZn8xmAXD3LXLzdL3bGnJ1LcFPyZikHGzHpS41ujWoDEWqLSS0k+J1pO7?=
 =?us-ascii?Q?QobnY01qr1CbPZiVBwPwgIN24LG5Dt6E3yfxucHD9IPjjSpyRFoUprNZGqo2?=
 =?us-ascii?Q?aZ2PpiJPOcKPFQMlI74muWtMf7ePKE2GIonoKwLaB0c9USkjJk6fikXJC109?=
 =?us-ascii?Q?tp3EXnHU+SGF8up3IhJhMi6m9ErWf+PcoUtAf2NsCcy6Kc9wXXmKJxk/w/Bi?=
 =?us-ascii?Q?SNBC3RAVjc3jjZcZzgsSLqVJiYbuDC/sIE29EaQl1mXC76ZnPkQaOLdhWOVR?=
 =?us-ascii?Q?suWvxVRkSRrhDE6PaprsXu8OWrlkA39Wstpyrbv2G3+LTOsSToxH/yDpri8P?=
 =?us-ascii?Q?VAljqqZIcCK4QhlgJjoqPaWbon+oEnzff3YHpk6ipIqfcK9k84Bh2POpUaHi?=
 =?us-ascii?Q?BnZDRyhL1HxyIOlpqM99ZQwOQLz7xXAjwZFB1589MXLEoHmgiiXVUq24N0Tk?=
 =?us-ascii?Q?KZPHIuZes6Fdf3OLrVwHbhjhf6ubMj3isIAKuMpg9dQuoy5kWLz6waUXAtl+?=
 =?us-ascii?Q?3JBqQ9BmrZtvE/mmOE1CWdMCXDJpi4hdb3/LnTMCQ1CXeW6b2+o/ZScSdDS/?=
 =?us-ascii?Q?D0L+jVzNQJaNlW6za6WDo2xRsMvd/s+t07fW+pn8IulyVSyV5Xswvlu11ohM?=
 =?us-ascii?Q?65rPGDF7ClFhjyO4TmPhYXUdp6pHbkaCDcomBgdJK38pK6R2kXUab1bAPgE3?=
 =?us-ascii?Q?i8nuSQ61PPg2K9pK+qsK/KbgB2ZR3/C4mbEUaeyqDVpJ9zLvoWrW8VnP+sSM?=
 =?us-ascii?Q?XtT5qUl22kepWwXPYYhpyS31bN4KMy+pb114y7gwNnOsVM+1Z96cgamJoi02?=
 =?us-ascii?Q?k1Y5ZlU0Ayxyfbo0WG2YbcGt0yIqhh7kIYJ5T1M2rFFTSdq67EGU7JKx7VPJ?=
 =?us-ascii?Q?6rLiPeriV8nZwHBNVWmSAY7KExuHRwcuEJBY8g3HIZl9cBKJSu4JXkOdWpdK?=
 =?us-ascii?Q?Rfv6qeZ/Oa6lVsRAApQxGRejiQJ3K/+aTeCKSM8Q9yfMDVFwb5pyhMbDl9Gu?=
 =?us-ascii?Q?bcEaBaHug9HmIyY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FTZKPTDDVqXCktnRJvwUFERqk53BI/jFtBBwXdGhnfKmP0h4u5Bu/In1MeWm?=
 =?us-ascii?Q?y/oz/GPJHilxhBmQleBqfu9AW0pXFReX6wkHDU6jpSABM+K4AhRaNOVuwvQt?=
 =?us-ascii?Q?W8lvqLfcj2RNJJ9tQ0nxd1jZIoI5TPaBE28qdtcctqG5qWbvYf3qlvF8SOIs?=
 =?us-ascii?Q?6a4spxo4WTJKkm16QwQ0Xvot+5hXhbNouKOmXotibT4gVcb/Sxyw+hcjXJK1?=
 =?us-ascii?Q?pAwBSEuao2jfytfyHIWJyUwqjMiuDmUm7jbzCI7ZjvXFKEk7iMoYGU8BTMYD?=
 =?us-ascii?Q?tDTl3Zcgqr/hZhc4zHiqe08a6UCRRjPXOCWt/iE4Ow90/L2oOcWs3DfYYMFG?=
 =?us-ascii?Q?dS/bqotA+vRZaoq3QDCQORYGpBf0nK3A1goSSyyXdRbFYMVw85YslTaKdWbN?=
 =?us-ascii?Q?A9W9V00WaQbNAeydgI+/rpkSO1nkzDX+v+eqv4dHsF7E7hqHs8pFccryeuob?=
 =?us-ascii?Q?VnsVk3hRWmxxf6MFZ1FP5yGrxgRbTwbFsslj4obNlj7flH8m3N/9oaUeixoj?=
 =?us-ascii?Q?7YxZENISqK4eV5NXBHJE1eVv5GKV5ve4YFZM1YqVUj1f55DR5ENJj9OVNzhv?=
 =?us-ascii?Q?qaCyxDGCx/wKeOfjBxSLVz26AWuPQaQiUrXCR9Gia5fypezZU+o+RbB85Znq?=
 =?us-ascii?Q?5+027634d21S8EflvqQmOlQ2MQXLTVR0Q42XPXR9jXGPScbt3/fno0njNo3F?=
 =?us-ascii?Q?7uVXrt8Y8Iebs5HyD3VKE3S0J5ZezP/n6l5BlFKdVU6pUd1xjeMZ4Dsz4vWl?=
 =?us-ascii?Q?g7C020ZZIIJUktn4O48ms3JDk/au2NHGOYLLczOEMGkKo8CuWr2r+IVZFjhK?=
 =?us-ascii?Q?/3TILvoLRt7auHsmWNXGC2HPAQBAxX4/PLlYlY9Afo8AhxZj/c4yZZ3iZ6SI?=
 =?us-ascii?Q?Sv1T/OfXjssbKpVev8CC1E+lSzv9cLY/qE91x6qji2x9tAwIrHdGddkb1Ngt?=
 =?us-ascii?Q?y7r8hVQpdoPU5zpuPnQmgiXd2MvhEw+HFwIHk/7lmZ7XH9wFAKntXvs9dmW7?=
 =?us-ascii?Q?5UM3lJrgiqS/C30VHScfLqcjemnfkIGRPh2QOgyp9zzNuKFAoJ3NOVRqLva7?=
 =?us-ascii?Q?Cky4ZU3FklBZxNqs8/LUY1hrvgmCsdi74ow92YolUquf7yENZyZai8qZCmQd?=
 =?us-ascii?Q?GiwdwknWJJsQ9ZlvCTflLCXzzkPQmv8lgGJTarO+ImWpQyerBwj2EYaUzxqU?=
 =?us-ascii?Q?bq8Av6nSlvXYbDkhoB21yri+svyA5U+QBpQptjZvMKB5UzXcHk3t+YYNQZig?=
 =?us-ascii?Q?piZEoYVyd/rnKmxqYbASqvqex2jLOsJEys5VUsHfsBS8zV3lxlO5ZSdc2S5C?=
 =?us-ascii?Q?YFO1HIry2zPFPbLY47XN5iU5QMRchdmq8jz5P/KReRuh3qdVUepi+8w4sgX9?=
 =?us-ascii?Q?NdEpEhozdHRxZ9tw5i7Kq9AZScG/vQNyhGvYLWMUPCWM9nFzljSKTWTLirs1?=
 =?us-ascii?Q?cXHxLSJTwpYxgV/RbzUXXhI0ObjMt4Dd2TFNnS/V5WH9GlIZXyMI7Qon5icI?=
 =?us-ascii?Q?7409NjOht9/v4NzxWzCZcqDzvKx5E2ysuzo2b9tG+8QVM+HqMmimqOerqDYr?=
 =?us-ascii?Q?iSSkw15WjnoQ2i1dHU//vyZ4vEvb8fF7t/+gcdyTU255NPNsdeXe3TtOla9p?=
 =?us-ascii?Q?gmVUuFVs89T8OijKvOui5qg=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4bda00b-883e-4d99-cbdb-08ddb954829f
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:37:57.7443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RixaLmiJ9y7zDa+lqAkliF+3yvWCm49q+lqQZIDNPaI9PZDuPVy+SFYpqhWCGw+ab2vl0M8cRu3/dCDKHlHKzCuMrlzKHDCceFLLsbGROZzIBoIO342QxuRlBxxCfKjM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10187
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:38:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19308

commit b9457813016841df82eaa39f1f00ddebf385f352 upstream.

Add a compatible string for the Renesas RZ/G3E SoC variants that
include a Mali-G52 GPU. These variants share the same restrictions on
interrupts, clocks, and power domains as the RZ/G2L SoC, so extend
the existing schema validation accordingly.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250528073040.904033-1-tommaso.merciai.xr@=
bp.renesas.com
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/=
Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index d03e5c61e4dd..3090e2ab6bd1 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -24,6 +24,7 @@ properties:
               - realtek,rtd1619-mali
               - renesas,r9a07g044-mali
               - renesas,r9a07g054-mali
+              - renesas,r9a09g047-mali
               - renesas,r9a09g057-mali
               - rockchip,px30-mali
               - rockchip,rk3568-mali
@@ -142,6 +143,7 @@ allOf:
             enum:
               - renesas,r9a07g044-mali
               - renesas,r9a07g054-mali
+              - renesas,r9a09g047-mali
               - renesas,r9a09g057-mali
     then:
       properties:
--=20
2.43.0


