Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AB5C35FF6
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:05 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.49])
 by mx.groups.io with SMTP id smtpd.web11.34804.1741778686841613467
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:24:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=GteRfXy7;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.49, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5qs3YVhQ+7CF0g81IgnHh8937ws28cBQ7DTgOHwfG1Nne5w5D6adfi4NLPPmw3/mQUCNDFSriYNDnP97TWfWoVIpDhIZrb6igNf7ob9Y20bLKn39/KjtWp6ABqdEJI0iHqpu6fbNTG8CwvilSebd95jJSkDVbIzfPagWgBO/uSnzT3UJLXMGEOlUcB+1XsMlYBgDEm7UypIabUO/RqLHrXs6CR9zSAf3lLxXkvCML9RY+0ttuWZ5IzJ4fLBGn+DtwF+WOtswqoJBDRR/qECe83gRij95e1b53vL985O2/UXkIRgLLZKuYZtSaf9fE8kjxnnqTwrN2b1XwOX/QOJqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24Pudq/2ayj0f9Pc234pjc8uNjeSKYLP2fgXUaR2Cb8=;
 b=mjRyu6ciHoEtzOQDV/k3EAsCIX+6w8tzirzpFoWXMG4o4t8gs/8RAwgqcNMRrDuPX/H3GJ8coUfkZXAOft8UhMRgNZU6BgoRPZ/gzoMuBV3zQc9MhTe2ZKExOC7Zwffh4L5Nuk4m6jwbLHIJHcyq4ToSaEWkE/TQVv9hyMujisPTJavWjH9IYOH9zpzq1qmvk/TyyTmoamZXRBnheoGtlZ8h/reUyLHlPwdMnscgwaOYGOmfLTSLCi5EJz/yBXt45Ei7xM+xFavSzqjxr95JS4zVn5R11JmHILb8y3nd+RuyTl0+bjboij2yHyDaQtUhqowchNGNvHlIl8dP1ILKSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24Pudq/2ayj0f9Pc234pjc8uNjeSKYLP2fgXUaR2Cb8=;
 b=GteRfXy7DgmXMnfRIa/nuCumeK/RsQKLdeH6DV6u0xVHuQpQ4qvOwxBKEUSmtEcBo6NEAXZ3PazgleydfR9D7GMMXmTc4FncX4BUe2D9nR9A2l1yMTZ/rsiTs7EoTnwUZWz0FAkxWNemHKlR8fIZVZ6b5z7ag4JVv5nrB4qa3Z4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB12752.jpnprd01.prod.outlook.com (2603:1096:604:33e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 11:24:47 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:24:47 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 24/85] dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Allow 'input' and 'output-enable' properties
Date: Wed, 12 Mar 2025 12:22:01 +0100
Message-ID: <20250312112302.1605750-25-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB12752:EE_
X-MS-Office365-Filtering-Correlation-Id: 08688810-0bf6-451b-8768-08dd61587ecb
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?5VLP+kntVUi4+Zk/rPWc3eG/VeVEmZk1jofDJu/yjoZlKnVvJi04JmvUNCAL?=
 =?us-ascii?Q?983J+78lOk3m6EISdfOuiNPBwbJyHELlrbuFc0Ej0aIXCoTq5V0xWxpvfuGz?=
 =?us-ascii?Q?Uw2HFJ56Luy91rnWxeN7i1qpWCcjFa7QUZhbx5zvc/Asd07rT+LL1tN9/B9N?=
 =?us-ascii?Q?sNWlWO6iA/uMHXDcLRCAZTRj232p5yq3HMrzQU8vckAxgF3hE4+cN9zfcFdv?=
 =?us-ascii?Q?VlzvKYKtxtkKgv4XwBDod5cYdTTGIkxXfMWAhw1QzMLiSDy51LiSA2i8oZi9?=
 =?us-ascii?Q?SWJSEEDkAVIw5fWLsvAEfBZ8/Zy4W0/UqHIn5Rvn98Ol1gibJCp89oZPAOGN?=
 =?us-ascii?Q?59eGvgoDT4jeXWLY7mH603kLChDoXb8Lu6NIKRyzwuwzXm41Kc7Hlukw3MEp?=
 =?us-ascii?Q?KRCC1xg1piA6wBGCDV5WU0r0vqLhVG5KwoTcFdEoS5YJGJeSeaLIc/INxkI0?=
 =?us-ascii?Q?Htcd1d6JmEFu7dIkP4S2mSf5pCodqKDP4FGdvqTmP6hE7v8rJwjxyrYy8wQ8?=
 =?us-ascii?Q?ehtqsgt/S2jcTL2jzRsA5YXMWeqvERz9ZxTR4FSsER/vzAeaUE48D06S6eWn?=
 =?us-ascii?Q?SYpmxYsoSt1jiScQSbA8QX7KpqDO8dOgJtQoZ7lEnRPAUdOsq++g1Oizgh6k?=
 =?us-ascii?Q?AqaGBX1X4T7WC1rmJSpHa33hwcTWF6xKwr4eHkgr87zql5zPczHQMLgOiXF/?=
 =?us-ascii?Q?exhiKMewP/NrGyIma1ud2hiiivj20OkigE0SGsw/kGMZqMbYW/u/kbEr19gW?=
 =?us-ascii?Q?wv+F/tO38EYrRRDBp5D3oN1t2jWrs3U53KC8v1hzqXXnkfxvlRTJxLdVlzYk?=
 =?us-ascii?Q?U2zTIXqmAf8q4Xw2YVaTy1vffOgcFoRiAM17Q6F4CZVe0p2PyzN0y6hfOaZr?=
 =?us-ascii?Q?jxD/WtKdfxRa5eq7D+NV8DwQYZy+ApC78P3Pfx4B5ZbDE0VQT5TXpzkQh7FJ?=
 =?us-ascii?Q?wtsd7TX3DDQb33C9LrV481R/0cJeDYIZRD35n3N9HkUMtavms80/B5Uut7E7?=
 =?us-ascii?Q?Fk6jM6Y3EqfpvEofykHuUpX4bRxymKaBtcR92zMIQewq+1sGIk3qDhZ68G2Y?=
 =?us-ascii?Q?FHvKJpyu8En56k9AoRg3dzzqlBF6MQ7OeCwksTt7EkdYLsigiyYM0/H+nxQg?=
 =?us-ascii?Q?ZMUAXpqhGq4/6dhZIHaOhC+uI5lU1AC8DgCN5+A7CpCri3+tyTxBI6CRvma4?=
 =?us-ascii?Q?WaNBPSN3BpWKrwJpMWcfu3kjaHYJQtshMCnRLCnuHOJnBibnopNltOJCeGcv?=
 =?us-ascii?Q?lWORjifTO7RFTnVq2k18XK1Yze4ZaoFziObuaEpdXrXtPWIsUxZbtnOa/OVj?=
 =?us-ascii?Q?QDjPt+cfUmjht7Ovzqku4NqLlhmDAuzGdMR0qUmFJMNvFX++NySEHjYV2t40?=
 =?us-ascii?Q?6zv7oKN64uZk57wHt0FVxqn8+CjbQJcnxp0IYgWqX21ZdUTy1kxckxjBVIyH?=
 =?us-ascii?Q?gAizwHqcnwCZLtKW6cps5ImSxmaQ2WsR?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eqBxcoJoe1wY7IMFWy8k2ADjkUfN50PNS24YFU9izkcDYME9s9VfRWtQiazY?=
 =?us-ascii?Q?D1y2nJjL9MnFmk1VGIW0rVAV3/5WdR0M1M/5ND9c5iXZTXYnXmxI8CY37+0y?=
 =?us-ascii?Q?Hwr7lwMTJNW8Tgtjlsvk/N/ECg/vFeKJG/yz3JVxcwlv5GMg967rXDOxFYYD?=
 =?us-ascii?Q?L6gtTYR6wlJF8CEffViRt2JXw/TBVYTJqTmPcK8LnnXdAiViyzs2y83l8BBR?=
 =?us-ascii?Q?eC/cSDVWlK+gcUNDEUlwIIyF8hZ5/sa19Ny9jqsjl4+bcvqbkS0a+qZo3mZ3?=
 =?us-ascii?Q?9Vsv4EIgDWlk2BdZk7WbXmcIobTZoTnFB/48UiX8QTmbUg9DGgx0X/U3rM7e?=
 =?us-ascii?Q?fw+Wf8Sa7FVle4UXMKbaOLKRB6kEVNczbjOQl98pKBAZl5W3W9BTp/Unh88I?=
 =?us-ascii?Q?XCnVzepjqiTFVQuNQZ4drYzig/gGIqf/2fXQIXJsSZ+n4fYfmiwYqm21ojAI?=
 =?us-ascii?Q?zZbZ5fb/J4RKuEqxuDLHK4btxDmFDvyTuP7lqRfbkDfRE3bQsgdl6XGcOdA4?=
 =?us-ascii?Q?JcbxQ3jwln5+Z4troFiVt1nk5pYCPefjc7jSuolhxCTs92DTsmu0K/rMVxHb?=
 =?us-ascii?Q?huP+YnzTuKVq1xfKoDYwb3g3MXHTqcHoZdgPfpW4WLYJk7YWppuoeNZSEPPk?=
 =?us-ascii?Q?rIJrjuQDuB0E6e0KXdBlfiz1GcirBDKVSN+g/VfkwYeJedbJ3ddH9VHcgk6V?=
 =?us-ascii?Q?+inD4j20IdJf1C3hQowA2NgllveTULIIAvVOADDCOQuIcycO57S2YUBoPvfb?=
 =?us-ascii?Q?2jFNkFQBLVHklvEN3e0HBZb1/i5lINBuSFtrfLVTsb7q/gKtAW1yN9vEd+0p?=
 =?us-ascii?Q?sTGfYfdMZAcIafT9k8qErqOnT+qRJ30A045aTr4s58E9GnVebKbu4eXCYJ5C?=
 =?us-ascii?Q?CEhOLV6HOy/PTC33sqCRM+hCVHnhGZlxZnxcphSyBFIr1MeyuOhf2LsacWWP?=
 =?us-ascii?Q?zMo9EkpLXPO3LnXI3BeIyUlLP2dju9k9vrpF3zXsAfM9W08VqvzrAC24Cvpe?=
 =?us-ascii?Q?uz7JoDQr4IZCv4JnmmaGJYPGtUcXgztGio6Z2gDP8QTUIZ0co2xGipnpyXjt?=
 =?us-ascii?Q?YMlIHijgKDT/Nmtm5ZKjtPHt+3fchuj3IiVpMNQ1vk/vx0i+3liuBfWwp6Vp?=
 =?us-ascii?Q?8XZpla1QGjBhZcm0XkHb9rjBQnoGz1sHbJ1uJjur9r3V+Hk5802mRnRKHuuI?=
 =?us-ascii?Q?k77jZtcOwfQ7dY8qlDQvyrvBDClg7Z192TuMwVbxI1HWfUONPYdBlIXZ04f+?=
 =?us-ascii?Q?b977i8Y/bGppthBhLT+j1jUqCOK4ibhp30NR+3l68WcHmL1TG76sJ46WkWsH?=
 =?us-ascii?Q?JbudcdkrmmwZXPb5QbuTn/OFPhKS0OyGLfeXuTFew2srynqStvcRzkgGlmh4?=
 =?us-ascii?Q?yrdyJ8RvcKn6flHonO3mwsOvsfTgvcoH5B2wcxrPX5btmjM0oWZY40ekJi87?=
 =?us-ascii?Q?HHNkeZtNlL6lOE9xviRWJWeYLl2gks5ufCzPivpjBgwfnmrEwXrhXGM2mMby?=
 =?us-ascii?Q?VFQdfgCzQG8CrY4wF0ibwEUuQep1t4o+Itcwinp3RTdGskFLRYH92ggJD+QP?=
 =?us-ascii?Q?FK6RS7PtWTLKSJc1NtnX5EQmt57XBFdUIlKzz/Gv8GaIwy/OPG9rNx9/4EgD?=
 =?us-ascii?Q?9pcRb7wO0K/d2z2lUIPhq54=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08688810-0bf6-451b-8768-08dd61587ecb
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:24:47.0035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLIPjkYbhfkO26bQxngtOZkKIOQMqt0JXoorK2wVDCAyJPyK7joWnpTQ370BkX40XDdEKy66fziX07RfCcPs8JDaTM+YdvGeb6vOh9jztqKFCOxQ/8o8QamjGmeNr8s2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12752
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18116

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
---
 .../devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctr=
l.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.ya=
ml
index b8937e01be92..845225d58cd0 100644
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


