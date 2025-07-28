Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0945C87FCB
	for <webhook@archiver.kernel.org>; Mon, 28 Jul 2025 13:48:07 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.62])
 by mx.groups.io with SMTP id smtpd.web11.81875.1753710481295114634
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Jul 2025 06:48:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=GuxcwlIX;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.62, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtncZ9FL2MoEzDB6d1wm3hfLaH8/iuk0+WvzpMiPqurgTaVZEWe0lkBPSvrHWg2qWSrLPfMeeSiLVOzA/WEN89TVLgxQQK/5YA4+V0phTaM2bQ+AuGs58cJqhj5jGADJd8NJNe1fARJBCvafxlRqbvav1m4OzVlby74nkUAzKr5/5KW2wBhUoHytL4SH0vfwi5hwHAkfyX+t9C1JAlgxRr/2McTat3/7d3cHFfe9jGlbjox+mHjhNmpiHZIdZOFyn+KrLEs/b6bvG37kzFxvWxnL1iqlXcfuGgSto+FG69OqErKO3c/2pqZPiARTfIaI0DGMdc4GET48dYKqOhVIeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i08l/hA/uH4alB/KQ1GAUBQ3BNw2wk9vIqyX7/ffMfQ=;
 b=vMFArHjFCL6Tg5hw2wUnMdiKUIvFQLSFs9lGGp3QbBaKUc2TwMK+JjSUPc1zUi7qbLxZx445Ngi1EkC7ekUNtvjOGayprspPOyPNhA29ticAJR/vZCrN0ZXNQWvFdfVEXFWHUFepI2YAZO/JEGtQIIr4qf0BP1fn6lxDb/gr+OPMz2GMasqY+TrbcK9IeAPpvX0MAf62nvaNB67zgOddw5/jQ283soqkvjnevGvskx/34LXhU94vkkkzBcT0YAgJx9r2zx0M+cQVrfJBNIGXfwy+Te9I3MfHLaP9lRwKg3MlrNPT/cwvzY2ziBuhN1J4Kl7U0AgvTUBIXQgYB/eEYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i08l/hA/uH4alB/KQ1GAUBQ3BNw2wk9vIqyX7/ffMfQ=;
 b=GuxcwlIXpUSF3P2Po3lRxJnY7am2XRwFcb70WQPoOlaNwcZnQWHdETpDyesmRk707R0hROcnZMoCvfQcjIlwq5L3rAWn4NivrxPm7WnHRZ7ylDQL+vNnMX9e1VjDqIS02WjdLZlolFaVistRBzh/Ta2k//dpMdu3JIZXBirArtI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS3PR01MB6657.jpnprd01.prod.outlook.com (2603:1096:604:10b::10)
 by TY4PR01MB14280.jpnprd01.prod.outlook.com (2603:1096:405:209::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 13:47:59 +0000
Received: from OS3PR01MB6657.jpnprd01.prod.outlook.com
 ([fe80::8575:e22a:3c44:76f0]) by OS3PR01MB6657.jpnprd01.prod.outlook.com
 ([fe80::8575:e22a:3c44:76f0%5]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 13:47:59 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 2/2] arm64: dts: renesas: rzg3e-smarc-som: Add RAA215300 pmic support
Date: Mon, 28 Jul 2025 15:47:31 +0200
Message-ID: <20250728134731.1287791-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728134731.1287791-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250728134731.1287791-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0017.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::22) To OS3PR01MB6657.jpnprd01.prod.outlook.com
 (2603:1096:604:10b::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB6657:EE_|TY4PR01MB14280:EE_
X-MS-Office365-Filtering-Correlation-Id: 361b5b87-999e-4ca5-fd6c-08ddcddd5d22
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ELDhm/okqpXwOa+EEV7vUWZ7F8Lg8iz94QMqQq2CH+aBxOIS7x1on7SGqsMR?=
 =?us-ascii?Q?CoW8r9Ldw6FeUDbjnx8aHCW3pYwVI0OowLrXZN1wyEB3rRm6Z3jc8LSWU9Oc?=
 =?us-ascii?Q?5+CnQJ73xO1QBrG+vSqE+0bojexUBgv4/MT7lsO0Ng/bgBRXP227nYDoQgW5?=
 =?us-ascii?Q?+qmihMUf8+r5x+c5EOYEDU2KC+4B/DWYJWPU1FVymDyeRjj20g6sDuP8yQJC?=
 =?us-ascii?Q?Ybaf8wVP2VzENVkqTObRQhnV2MSkayTP5xjUb8rQo5HTXRiqOgVG4TLMCcq0?=
 =?us-ascii?Q?8ZMJL46/Zv/6p33DrP8PFDTo2XVrh8BKnRvhNT4e/xK/5r3UUvEfhiuxkOWm?=
 =?us-ascii?Q?/2zur7fgIrtnREFM9IFjb9YBzlk8l68IvHdPVwobNlokSUTfCy2qgBtEDLF0?=
 =?us-ascii?Q?1IJlrsuZ7SymnTj4mFeRqrbXXZeqhsh1tLGTr2FoSQ9IjgosLoyD8Qme1jnR?=
 =?us-ascii?Q?0+TMlFpxyrdweqNOkBVxGQ/sb9ftgkTrPzFba3LIgBI+9xWHXKztNyYaibHq?=
 =?us-ascii?Q?rbYYUSyhjOICJXWKVFTmodRO9kWp7W2BbIfORZFdVzz17AHrckIgu9sOkyvr?=
 =?us-ascii?Q?YpveZNTiEgxfIwsnwX136tpXYZA4GxJ9NH2hFDmZ8VxMV8C7TOJ7P7cPMkmQ?=
 =?us-ascii?Q?shcxH0i/sgb3/NXQlao2pAcyVUBAnyBLD+PQd37rcUkSI23scSFyGU4RrB8j?=
 =?us-ascii?Q?01XnuJCusTzH25uxIcZkZffvwpsIomegGfzOMyIFxLqIeXwA3x/bp1zNU+pH?=
 =?us-ascii?Q?2KHRx9pvzeFfdvLlmFfxnKcYZQqacG+mxf2QxAHa3jgajwPDKB65R12kYJ/g?=
 =?us-ascii?Q?Jdcoy4oG8IRA47xOMWnrbrgt4AM7i6iKNAPqMOmqY5vK7Y2cVfM2RxRy66FO?=
 =?us-ascii?Q?WMa/P3z2L3ar4d0GnN5UW69aahG3QPzmRZPUeeyjyeK0DWJeAN2AjJqy0XYk?=
 =?us-ascii?Q?v1npV9XhVZRPtVeWNXFX8Qo34s/mF5zG9eYrgVBfa8cjvOJ+pOy70qCPEiMu?=
 =?us-ascii?Q?ag3sMB6+AO7q7I9mozwXcCiCM+lHZ90XtZa0CxiT5MYxuSIsy4Het/Xlk2cP?=
 =?us-ascii?Q?GJs7elU2FkgPBZpfBirRjvcOm0+CnfPlCkWUs43kajERN6XWEpgd4UxcaCPF?=
 =?us-ascii?Q?1kPM3gM81rDo1QpF0PvwXAS+X2xCbO6+af/K0HEzuB9F9Quc52r2W0Zobyk6?=
 =?us-ascii?Q?mKP2nU3t84Z8cKYC7X8LoQWJ7f8sUh28cx10iDcsJG5QGy202wR0W43J1d6U?=
 =?us-ascii?Q?vOCJNTw5L1U6oGYH7h7F6ZNNJUa9o34Y5V1BJHrN5yOtsr9WyfmIUXYtJvfV?=
 =?us-ascii?Q?YzZgFQmBYQV79xQj/ZbFl++0mLIAjOZJg+8Ueq8YOjMtAdm08tk+kRtklhHb?=
 =?us-ascii?Q?81pUgfXx4ONhfP1w3MKPI6ANhFkcUSoKu+bXNUoK02MiBK88xgqEBcsPfj/R?=
 =?us-ascii?Q?6wz0/z8LQrlFsiXT2a22Yn5+tm6CJkXH1tylTKMStfrYNRsWuNhz+OKj6O2y?=
 =?us-ascii?Q?3i+k1SofItWdIXQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6657.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bZPfKBziFhu/mP/Xufx6jeaAfhbXzCLt+dkEN3lkc1Rq4fdWsI+mA+Dxf59u?=
 =?us-ascii?Q?/ySWNLJN2QqWkbq6pEeVxSYcdwsRqSIqEqnbi9bTNjW4VYv0FRVvaK1UxXo/?=
 =?us-ascii?Q?ZlD13931UzV3vMuN61H4+SsZoXPufAR430aQAYH8GquJHbG3RTkGAMwmlMDS?=
 =?us-ascii?Q?osxWqGzAwPfq8aajNg57OEywr0+Ms7gzAWMOjbhf67qJ3lAXxUISM+ROSU60?=
 =?us-ascii?Q?ozRPjgizjA4rhFja3eoEX1a/6DwwNdYe30IM+H/jdEj2LX4GBdLxpxLlQp/G?=
 =?us-ascii?Q?IGb6LyzwYm+rwRL3Sfv9783qiOvufA0JnCi/0Jg46+dlEkjnvNE8b1efpZyD?=
 =?us-ascii?Q?hg9s/p1pz30QGUiJieJUXlxygztPnbXJT/8Fw/A7giWHrSxJedsZFpqeVhNH?=
 =?us-ascii?Q?Ld1GIxoPKpb9D3tvw4mh4Dx46FiGpxHep7OfmfSzskAzEEFUv9ZBqnwCMPzp?=
 =?us-ascii?Q?7aEH6JpjRyNMcaSBUlhZo7mcey0jrNYX9tirCnkcjVtqsVr15brn4/rn9LOu?=
 =?us-ascii?Q?XfzxONXXsVmWuuMW5ye4ze4Kbc/kd/iSAfTbhhcs1OmtBNKdBBN5///aNIto?=
 =?us-ascii?Q?EcPRg5Sd7peaSCAcjD5ZZ/HVr8eeZ6Yid9gUwA1I6kvY/AeoAPQbRyMJ6TOs?=
 =?us-ascii?Q?7ZheG/9Uwugk7VC+rBtXJAjizTxcHh3RE0TXGysjQsSKwW77ecG4aXLtdl9x?=
 =?us-ascii?Q?PxybOUxS0D4w/Vt1uaT+ViB2zt/X2kvAWQa/ai895VcMS2SCJEfUR0cmsFO+?=
 =?us-ascii?Q?580hoepgvVfYo29lJ2f2gpNqEhB3tmzQJ5b6oaPlz+Cb7Yyyd6AjiNJD1nOl?=
 =?us-ascii?Q?pj8ISqLJIl2cS7EkE0Xjb8P2n3Ag8ZFUDgpwYH0gYjX1ouKJML8U74J7gcoO?=
 =?us-ascii?Q?wOufZy6/g2J8n5PIovZQ31mCcZWJ1xtbohZPUS33t0JyqHnaWrZeijQGs7zB?=
 =?us-ascii?Q?zICJ1PMBawax0+H8iqLESRDp9FFNMAJ2zv9evU16V70xCAQ0xkLNAMRw5fA6?=
 =?us-ascii?Q?hVICSOTofJP21vmFlzhpIMzBG9QYsOgj4x3TeDupKrA24faD9p0NpCXlnQmL?=
 =?us-ascii?Q?YNhzanVUxhVkAEFEUGARtz5pgZih2WHUVDxTgxpGWyd8ibxHS//8owiq8KhI?=
 =?us-ascii?Q?WUwxhxb5PvqgaCAi2sySJHFxEmDbibmJgRzU0fzlCtfRbIuUmtncSPI4lk9N?=
 =?us-ascii?Q?Yydki1Y1yZbfdmED5aGdcW7+2uvnV6YSnG7HC4GPS39Jx4FzyE5JySDOx0pF?=
 =?us-ascii?Q?KFeEo2J9d/8GrZlhTnKSLzwKBLCza89xkorID29GsmjNerBxLd5JxvVv7W1L?=
 =?us-ascii?Q?lRl4CiW+Mo4cx47veM28OC8dON1bMQrkGBC4qbnlLp1t7hUbqNwGAEbKqPtl?=
 =?us-ascii?Q?G7dtAH1oJVITrdaQEGONo+8H5O+QyvhqHsCx2LCRXifhAWeze+bA9sBIZnVL?=
 =?us-ascii?Q?XwBWzKVx9h/Q0enryhhSkRdxTvJnMi4GHvDITgKwhUJulY5J9CNT9+Myrnxl?=
 =?us-ascii?Q?+8eFLVVJ6WC8vWbrxb7ofTy6MhfroTxWMbu0ysbSnzD22liVQIllrSbqCYT8?=
 =?us-ascii?Q?qGO4j2r08XxXuPIiknf6jKfk31z18DzekKcNVAlTH786iZ1b94pRcYPtazLZ?=
 =?us-ascii?Q?kn1EpoZvsY68fmYq/cn+eeU=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361b5b87-999e-4ca5-fd6c-08ddcddd5d22
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6657.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 13:47:59.3337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9rIMYUTR2DstfWBdMw+KhbPHqQ5PHaM/cGTsZ9ng80nWOgB1S7CjtYpDzP7QhBEQRVyf5ETGxRF1U0MAYwgINa8RRC3ayqr0uj75st04NtN4yEsi9CrbVtoUBTmsm4If
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14280
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Jul 2025 13:48:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19605

From: John Madieu <john.madieu.xa@bp.renesas.com>

commit 5ecd5a8261d00c1eb97bbe5392c9f2a7bc1fa2bd upstream.

Enable RAA215300 PMIC and built-in RTC support on the RZ/G3E SoM module.
Also add related clock and interrupt signals.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250329121258.172099-3-john.madieu.xa@bp.ren=
esas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[tommaso: Squashed the commits f62bb41740462("arm64: dts: renesas:
	rzg3e-smarc-som: Reduce I2C2 clock frequency") and
	5ecd5a8261d00 ("arm64: dts: renesas: rzg3e-smarc-som: Add
	RAA215300 pmic support")]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/=
boot/dts/renesas/rzg3e-smarc-som.dtsi
index d93c846ad391..ecea29a76b14 100644
--- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
@@ -64,6 +64,13 @@ reg_vdd0p8v_others: regulator-vdd0p8v-others {
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	/* 32.768kHz crystal */
+	x3: x3-clock {
+		compatible =3D "fixed-clock";
+		#clock-cells =3D <0>;
+		clock-frequency =3D <32768>;
+	};
 };
=20
 &audio_extal_clk {
@@ -78,8 +85,21 @@ &gpu {
 &i2c2 {
 	pinctrl-0 =3D <&i2c2_pins>;
 	pinctrl-names =3D "default";
-	clock-frequency =3D <1000000>;
+	clock-frequency =3D <400000>;
 	status =3D "okay";
+
+	raa215300: pmic@12 {
+		compatible =3D "renesas,raa215300";
+		reg =3D <0x12>, <0x6f>;
+		reg-names =3D "main", "rtc";
+		clocks =3D <&x3>;
+		clock-names =3D "xin";
+
+		pinctrl-0 =3D <&rtc_irq_pin>;
+		pinctrl-names =3D "default";
+
+		interrupts-extended =3D <&pinctrl RZG3E_GPIO(S, 1) IRQ_TYPE_EDGE_FALLING=
>;
+	};
 };
=20
 &pinctrl {
@@ -88,6 +108,11 @@ i2c2_pins: i2c {
 			 <RZG3E_PORT_PINMUX(3, 5, 1)>; /* SDA2 */
 	};
=20
+	rtc_irq_pin: rtc-irq {
+		pins =3D "PS1";
+		bias-pull-up;
+	};
+
 	sdhi0_emmc_pins: sd0-emmc {
 		sd0-ctrl {
 			pins =3D "SD0CLK", "SD0CMD";
--=20
2.43.0


