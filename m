Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE9AC7EE30
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:38:13 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.68])
 by mx.groups.io with SMTP id smtpd.web10.20555.1751452685695306462
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:38:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=pfS4G0Cq;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.68, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqOB12u+vZuAYDLtLdEoNGM/y+dhna1H/b0kjhMuPTvZnFIrFav9sszrK/FqNhUJViNntLr0P+eSJncYSMeJ8YsRTU1tASPcRbcD9UYK4HmRwbZG4KZNuLBImm9db5vZIVr3Mw9LG6XI1mHl4VMx00z02D8I4Yb8a5bsJEfh63ZXsAQ+JsV6HI/zTXodf8LU41ta3xxGLt9O1tbtM3/L+mQ57x5haGbWECOsRsE8D4qpbf+a3m2ITTPnT3C3RH/VlD1V5ORxmrCjFV93+/561jB+lLnZ9oUCGzlW2/2YCsA8ctOu9bw68Y1LVR+92ABwFVPAaA5OmNoDarhiSP+0kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILBohkh9QFIJjq8WPxEL3/xY8TIAZMxOJh/AVzxSmC0=;
 b=SJr4x2B0i0jNv7xmSUvXdCreC1RrfClMYhVB0JYyjBYIa/Fk+nJUSvDUCWjOSTj2ceoQ61pNbEuWFloiIotCJq1R7ffxoOOfZpLam+G+La07E4OwagOcQ4K/HQ7efz02EvtM6pn9W3ImTQ6tIifZAdyKJcmGNIhwXvEJrqzKOErFAd52cD/dKqZOo7jkM0uuci2wJkNwZ3H9hskoMtinS6GPM7fT41WoGlUe63ON7lnLFUSl/hSO9BqtOLv/tGf11QMRveGd943pMahkqMU/z7Va6iUX054zHawHIIZQmTsdk2nU0r0Q7+1BpXA/W7JAeYzc7kssDwA9UiW3rcKSyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILBohkh9QFIJjq8WPxEL3/xY8TIAZMxOJh/AVzxSmC0=;
 b=pfS4G0Cqry+gA2Ct2+kZLVl/FebP6Fc3ZyLeAJRItqaUFmig3JYilJAKqR/fUGw9xxpfrYLTnEO208GVcsCv1dKU/OGSFLco8NhpKkkgU3Hzz2fnwtHDttuvLlraNLUi7CSZy6f5EIAsJOUrVG1a9a+mX8uOnO0syTvrgEfuNfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS3PR01MB10187.jpnprd01.prod.outlook.com (2603:1096:604:1e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 10:38:03 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 10:38:03 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 12/12] arm64: dts: renesas: rzg3e-smarc-som: Enable Mali-G52
Date: Wed,  2 Jul 2025 12:37:10 +0200
Message-ID: <20250702103710.117760-13-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 099c5c12-cd2e-4067-b297-08ddb95485e5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HkALzqqfL1tipuKOE+Lp8Ids1ATLknTNx+KB5icI4ZREOVR3FQqVEo0rUV5h?=
 =?us-ascii?Q?C8Lx8U8X5mi6X6Ujcec/ltS+oMf31yGwrvbGk+tH/tfOqIKI348P5ybPzINn?=
 =?us-ascii?Q?SvWkUvTTBv3I6ObUqYqRzV1uarIhdBUkb+l0fL8w/EqrlDQ2gwoWMAdDtBVa?=
 =?us-ascii?Q?TWmru3GrSdenfI6J5fezNLlDbZmGGgoS7y0vTnBXVHXKF525YykOEJszqU6e?=
 =?us-ascii?Q?Ufa/0fozGRVi7vl2r2d6l3HJvUIlW0CdUt9BkfXN5jG+aLZOMG2zsjhuiDw7?=
 =?us-ascii?Q?4N0gaB274z0dXhFaX6MZJSv4bZBLvSU1nemM02HyvAO3MMiSpbiTi8uN1F/4?=
 =?us-ascii?Q?fHqbrXG1Fq+tyXPZY1cgsM2jyBVotC2zP+UnYIz9dItn5gb2dpJqEHPUmKyB?=
 =?us-ascii?Q?RNs7R1xJwPh80ACcwG2vjslIh8i3o9Ce9JyvewE8vj3vtuGW5fctkoT1wtgZ?=
 =?us-ascii?Q?91bVY6XwgeVZ1g3yPRhX3kJReeJF0Bro3Oneer92hHeCYEI2iDVSHelCRjDO?=
 =?us-ascii?Q?SXZVyQ1/D8sjnnygMnpLedehUd4/7rB+N0BuS/mlIxu2JQXfFsB2xUbSVsB/?=
 =?us-ascii?Q?PMdEXRTZMq372dWY+suBAM8b3F3uQGTtbuYPbjJ2A5PngqlEkJ9BDCr4vxZJ?=
 =?us-ascii?Q?4WrOhvlxPG8Jjry22rKBjl4FKi8kmYPtdExug9mJYfjv7AdNl4yMTrr5OVsx?=
 =?us-ascii?Q?VsNnB80Xbo4Im1deTLXbv6JW+cmhy75ahlHfN5l8fH23BEy/aa9yGOYbrd39?=
 =?us-ascii?Q?0Uh1UluvDYpQ4PCR965G628MrUhj9a9dnZhmv3+XOfjwDf26YL6FKvTg1fjR?=
 =?us-ascii?Q?eEAdTjtc8tIxIu4HBtL99EvlUXz+Fg+2H27N595tdHd5KpFpm2rplTGeD+ms?=
 =?us-ascii?Q?4kejkCLBYbmig9h9nagcXEyKChJDtvBQAEkpQA8azn1nsmmu8a71+RR82AHH?=
 =?us-ascii?Q?YeidUvjTijAzWagXcWBYLHz589j7124fe5MsmhHVoZRHAVurMLjQ/3c5k7Zx?=
 =?us-ascii?Q?2PoJfGEYoKzoeqXIHPdRTTc+dzd4EGmIQb6wTmtN3f0KkPqi6O/79IgOmRv2?=
 =?us-ascii?Q?rwSkHCUSYi1sU1EyQk0AsD3yCbiifptHMcRpneusuvPd14yr28N/VBEEggTN?=
 =?us-ascii?Q?s5pK84pFwHVRlEUroz6Tf5lFv1oEuf2FiHXCrVM1ExfhCtYIJ5yE8WUyeZ91?=
 =?us-ascii?Q?2xrAHudt+zeXGj7Vb6jIwuCVZj6e92knHRK+AJJfWu4Is+72WqLAuVl+xuHL?=
 =?us-ascii?Q?XCG5Unmtl2gVYa8hJtqHWz3QrSlmJn5K04fQTFP8p2CnkiKr7u04H95TQUUo?=
 =?us-ascii?Q?IYEzkyfdk685xWJPPZ/F7VPX9SMS9Y1AgEm3tH8k2KJqseyXYb64QisbKl0b?=
 =?us-ascii?Q?PxPFzy2OlV2glUJzMWXUNMd2miTZi6BmVqLGas6rG0QgaJ6VI1uHaO1ynqH+?=
 =?us-ascii?Q?3BQ2l5bI9H3Kinkl4jBV1td4984VY5ojJXADjj8Jdp7cBWzAP1jUcw7ch2B1?=
 =?us-ascii?Q?54M8F+1Op4Yq1NE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rapav/Gmi0XybswOC+NOCTD805Dgkq3J3k5by6zA0jyHtbM6ToaIVKGXtPZj?=
 =?us-ascii?Q?+/v7ierCq8Ixwo+N5Nr3naAiobv/282vgpnBUPFCc0cjy/N1ZP8AEFFKIa8M?=
 =?us-ascii?Q?FH0jH96NRpw3UheXltYLSP1Mnv40UrckxF14t8YuSHByATDrPiRp8iSFAH3V?=
 =?us-ascii?Q?4y8Vfrd+XdE1S8RQxmpof4LYL4ufG4m2Vejy7DwHx7xR54fglIA9LLjeFhbO?=
 =?us-ascii?Q?UJsZmzmtjAvTaLvaI8R01z+KuzjieeWX3/ao+/Q6vLslWD+ufAgKXiYkzo5C?=
 =?us-ascii?Q?SyP0I61xZ7ajR00sMTY6E9FfO3g8Q1pGMSmaVUFbfXZYLQF1tmogO2wX+G8z?=
 =?us-ascii?Q?4CesRCEDwjYj+7ubS+Fb2E3ntWQqWUeyAwb6bzm6S1Sra0AdGjjWqm6QkUqK?=
 =?us-ascii?Q?xYuh7HXy69/eut8GdwwGXiMVvsQGv/ZabMh4MzHwnSWf63zRV1MEkqqtheKb?=
 =?us-ascii?Q?aLADmMSBqdaXQG/RbtI2fi0x4m0vmUDu6kRB81J2GAoBaVmVUGcJD8UscdLH?=
 =?us-ascii?Q?cqpbUKC8xRTs4GOXqZXuXwxw2GsOS8HoP+u1yG40KHgPLPQ0WGE/6aB/aTa2?=
 =?us-ascii?Q?n0YJHmfc7nIyDrXCN6Ksa39njpyLmSbk68RvED0sLuezTsJ6uqaql6zOcjAK?=
 =?us-ascii?Q?xJn4rrHKy1OYdG2tIWoZUD+239ptgTAtA79FRG5525u6u8b/513pqUhP2PS8?=
 =?us-ascii?Q?Najo/Dp6h5JXx0tuYVVll4pbNVE6jKTm8wCV9WCz6tNolaflptwdaz8N1oAk?=
 =?us-ascii?Q?l3+sVvKcWoq8ErvSe+J7hBZ2VCFV529YEF5x53PwOBpl+xlrUl3x74BI6C+5?=
 =?us-ascii?Q?lEH8dSAsSSyg63gI20LjTieWR1Cr9xgKiZUL+qN+6UYhw94zYHo6nJIwtigl?=
 =?us-ascii?Q?zKAmEAT8aV5IYnBsVLxYl7FBx1xr0VMxak/NonJJMlZMK72eJSIf6tZFkExj?=
 =?us-ascii?Q?ZQsb9ZART49x/QzkuUJDdH861THd9oG1WKZNPgjkLV9L95J1+8051AHE8w0K?=
 =?us-ascii?Q?HLQlSg6pXvtsS8N4STp5xtW9ItfUevtU3UNDDyVPa9pINZgmov0q6RmeC3er?=
 =?us-ascii?Q?h30CKCSmMrRPPaTwiRXyqIYKthXapvdhETGLyOj0eTaLbmTIpU1dH02q9/T6?=
 =?us-ascii?Q?tSNTsELdGuttogsnrK1v7prpFKHAoVnIdlur5v4ggVDV7sZrWkQHbsx4KoeK?=
 =?us-ascii?Q?MsvYzBZHzHbdWK265mZsLM2eDYXLU7GnjvrBO/jd+tFj9VIWeeSKzcThq56G?=
 =?us-ascii?Q?yMf5g2ES+azUSH/WFbEwzYke2iKVXt9K2pWQiM0muSdYfwGFhjHKjPRGqpaf?=
 =?us-ascii?Q?EZkwVTTOkVcDEjyL+Y/0QiDQc3sjEugZt/6/LuBkO6zwo5VbnDSxS7E+Ik7f?=
 =?us-ascii?Q?UclSb5bqijamdXzXiLrJPLQB7lyyasjNJdgAvwR13eGJfe/uzxP6ZfMyuCZP?=
 =?us-ascii?Q?tnr9wwyOlnhtanKmbuw3u9JR2IBoDJiE4C4h2BpurrVVB4NZHCG9rHfds7Kn?=
 =?us-ascii?Q?W35jUbi5LIvBM9I9w3/VsVfPbVjOwX8avmeh7zPVDBmIyYQ3CrySL/r65SHI?=
 =?us-ascii?Q?Uh8dYS1DKmgmaP/SOyEgNxczjCPaz3QGMAMRYLnIqZ8bgR3eohtoywLZoH9T?=
 =?us-ascii?Q?wmbiFnQqHC3CKiI9tdz03W0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 099c5c12-cd2e-4067-b297-08ddb95485e5
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:38:03.2355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HIndxXiCLHrguRBixCttLa0tiJ2//dKCU5CAm7zB7mo5uTOG8BEZgb19FGsTT5oGL62kWCBi1hqc0p8yeHcaigCBiJrX3C0ZfpCkoEtQrgxJbRbomaNRFVs151XuwWI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10187
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:38:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19310

commit 4c5e0f0c89f0c54610ab6de29b0649f799a66542 upstream.

Enable the Mali-G52 (GPU) node on the RZ/G3E SMARC SoM board.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250402131142.1270701-5-tommaso.merciai.xr@b=
p.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/=
boot/dts/renesas/rzg3e-smarc-som.dtsi
index 72b42a81bcf3..051a43a7e2f0 100644
--- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
@@ -45,12 +45,27 @@ reg_3p3v: regulator-3p3v {
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	reg_vdd0p8v_others: regulator-vdd0p8v-others {
+		compatible =3D "regulator-fixed";
+
+		regulator-name =3D "fixed-0.8V";
+		regulator-min-microvolt =3D <800000>;
+		regulator-max-microvolt =3D <800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
 };
=20
 &audio_extal_clk {
 	clock-frequency =3D <48000000>;
 };
=20
+&gpu {
+	status =3D "okay";
+	mali-supply =3D <&reg_vdd0p8v_others>;
+};
+
 &pinctrl {
 	sdhi0_emmc_pins: sd0-emmc {
 		sd0-ctrl {
--=20
2.43.0


