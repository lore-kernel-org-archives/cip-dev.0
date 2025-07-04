Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EC0C83F0B
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:08:46 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.69])
 by mx.groups.io with SMTP id smtpd.web10.8440.1751620120789321241
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:08:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=mdHdUUrM;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.69, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otmXtFJ1Ecu5+XcnyUcOcVvOGCMx1OP7qdxmcjykbmKfHOvXH6ZD6VxXgucOHNtDWyamn5idGxqDl9opdRzJvGk2gydFwB4p43kwAiX5yNgwOWwCtZVX602s6gTM65fl9/cBYZSgBpcwTe+tzRGVlamBcPjnHgzvtfsp2S3XkU6WzY32kLRVgtxaU4eAoDJbGJwlx0zwEU8lcU67EJy9eZZ9ckYc+Xw43Ua1916ea7VdSRcEoYyCTioO6hGruAAoVQIcs2fJ58Y4PHZTVXOzu7C01oJlgTgTwj0ILDELMt9cfrv86Cb7tm8OrnLdddbboG1Gr2wZIMtYBXmzfgF0ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eo/f7gU7dUvbdrslV9Gqw5WHAK7JInU9zOIdiFBuBbk=;
 b=aZ5ZdHqqLc9bzBzeRtcpPPVyFR6vYC1VLlNkwUR2M05NHpffrYlX9pQkb1JfUTBO5O/SVGSlyWv7eGoxJ08r5qBIrNoIHvhs//M7tU7/VZ/lmDJRkf4u4pS/oESFPnoBUn+sHja7FCJIoVtMRsPRCVqfJG5/UJjFeu2+5fd/UncozRm9E4zmPY2P7P6WMtM0Ru7stHVUbIdv63y00b4s7f6hDh+hton+HuGFf9/5DhcintOB57DfITdFElgvgsgD/zTJ/9bVCyKty4o3kA6XsixgP0wA5FXbXqnGuXwI72BVa4MU+y01vbW/Er7XrOjgsPv8f0S9VpZKg2NJ6vWV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eo/f7gU7dUvbdrslV9Gqw5WHAK7JInU9zOIdiFBuBbk=;
 b=mdHdUUrMjMj82ueu0CIdn0ohjrvVy/kIdlgzksphnjjc0qnDzx0etUK8qWQE+1MpX15hqZEmYB+D1xT1Kehpibd/Tvi27WL64w2kjVOBFQB9afvMui9vC+1nwmcQjBzjbJK7sd25DztdL0v4gwMokkrL6QvYtsiD+VG5T20CieI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYCPR01MB8801.jpnprd01.prod.outlook.com (2603:1096:400:18a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 09:08:39 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:08:39 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 18/18] arm64: dts: renesas: r9a09g047: Add ICU node
Date: Fri,  4 Jul 2025 11:07:24 +0200
Message-ID: <20250704090724.669848-19-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYCPR01MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: da5e2baa-8d04-4e94-4cb2-08ddbada5d5e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Ekd0hSZfiMHT7rOP60QcJ7QV8J9Pso46MMrXwmGpSdaCgL65eX3+Xxs2YOsa?=
 =?us-ascii?Q?fnmSoniMLCa9iekuyrOTTt0x757vwyCwqYg2Lj5vp2aU5yBnAu/GqtB84iZ7?=
 =?us-ascii?Q?T7lD0/yf1tIKxe5jQ7Sh2ZmRbyPvjJJn4DYQvhEvpezuO9FkEJ5qM0Vwhm4S?=
 =?us-ascii?Q?8mhVED2M08T4bQQoVVt1g5AGQ9CK92YhT1DhR+Gkg4s9AeGtkGb/YFyDQt96?=
 =?us-ascii?Q?6EUJaafAiGYBvbEPZy+VR+oyKMxQ/GcgK4dk1Urk6SAEF4fmtFpuM5jsZx4B?=
 =?us-ascii?Q?JnulzItFpsZUDplhvtz+65zk16uhMSnTG5N6li0HWQn+102JCFTZE18lq5Qp?=
 =?us-ascii?Q?+KCFUEztEzVKrOf5qqtRVH/OhjmbS1WV1HrPUiNk0KOacmG60+DYyneO+0cr?=
 =?us-ascii?Q?u1T319VsZ6oe3wJKZQ0DnkHnkOyGCDpW5B8gb6LDlEjNwfwLsmZf5FS0ZLQ9?=
 =?us-ascii?Q?k1/3T2jdLBjyKt2N95vcO7qULrwduAQAaJM+CUmNRPX1e6d9/vEXKxKxProw?=
 =?us-ascii?Q?OiNpqMwJyRMv1vPBrqPhEKlJGlQud371iOPplsX5yZ2dE3D17smQXlKRkdbn?=
 =?us-ascii?Q?+OW6H/gWIgI3jvpDuzUqCCdfd8pKcy390eo2JVkYNWcvbQHV3oC+cZ8HVRuL?=
 =?us-ascii?Q?J/bLCQUwTZeMdMxtNBTyGIHEPPm1BoHtq7x8xqxS/YE1FzncQY2LrNu3TBYH?=
 =?us-ascii?Q?UI19OPqddCVnJJu0qeB79hhHscd9M7gNwJNCHmzs9AuxQb5lxOd+coZoxINJ?=
 =?us-ascii?Q?u0koxapz29kuwk+bB44A50B/Y3uE0fIQ1jhofkkJemXkSm7VyyVnvmlgDxc5?=
 =?us-ascii?Q?99CCo/uWA/TAVFJIsn2GKRo25yp1nWcFWj68AINUpB5jIlHqBp/eM66nSfax?=
 =?us-ascii?Q?lz7YzWAfn+uj56RkImybRMcc5RKoRzOJZpw0nYgUF+GUTevA9Dl608mFutV9?=
 =?us-ascii?Q?LXs3DmB2LxyBtkiDtKgvTFlSWb0i7NAKAc2pIi15WiR9cP+/Z9XyBK/vhe/c?=
 =?us-ascii?Q?k5HDlSCYp8x9vGKAV/pqaZgU2LQrw1M+Gomf1L39lOHqo+WML3oYhd7Fo9SJ?=
 =?us-ascii?Q?KtPtLkmXlVt0Xma6mvHSgq3f1Kng5B5Fg4azpiTS9by/s3f2euhv4N1OAgxF?=
 =?us-ascii?Q?yPvw/60Nxt5T0Sip65elDQ87MKHl/UEbfgbsjbs2j4V2HmGvRXEHe4r9vpFM?=
 =?us-ascii?Q?VLam9bhNfaesnaTUqcvTItATV4ZUgtXEiO2V2qOZihn//zcYRbM43S4gQ+jw?=
 =?us-ascii?Q?dPD5+evUTjw3EmAev4mcugQOC/pBSeWR+692UgvG13J+b4UdCVqmQ5jGxGff?=
 =?us-ascii?Q?IV+EvGp4UEs2XwVfEPcK/zowdFPlnFc0FQmt+uUuqetX90NxyZgxneyKpIux?=
 =?us-ascii?Q?pCa5v+tNz2VVVsSJp2aZwcDxRFrJw9Ye30nu+5xdnDpAP7zaKdOQ1ouZ0u6t?=
 =?us-ascii?Q?WU9DHBGpiICfPxVsYoxoq6BM4XrAg13YcQydgICroezIhHDxxkgie3ZGIrlU?=
 =?us-ascii?Q?37mwSum2ryXqK3U=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xS799ZubT9MSVmq7ofl8hoHCm6QdL1p7yLC5Ojt/mCjMIk2jjMlbiHzqQHpx?=
 =?us-ascii?Q?ZmHmAXvwQ9xYnf84zxzSsNFFGKPpfrFUcT6WYld5IasGP1dA0U/pbmOLWmvh?=
 =?us-ascii?Q?ye9ZY9PfKdwdcE2zpQDIJVLI1ynTEXdezg7Aa6oyVNxAiC+m24gERHuGAvk8?=
 =?us-ascii?Q?ynfqFQ5799NeD2vxf9iIBLil3fC54eEMf4ZeCzAbnci4K/EnJS9x5dJ8WLOt?=
 =?us-ascii?Q?rHSIaJxctoOzBPwoNchC1hxR/ypapHrhiWypI0lQQ3EpocPy0rCoqE04QtSR?=
 =?us-ascii?Q?1boY83ZmuMr23EMlQBOgYzH1esT3B9Zn8Cq/6iFwjEUV+HGR6Mfu9EQYNnBh?=
 =?us-ascii?Q?ZcZPGa3Y8AWug0A4UIYcN2KX8FyPo1VX/IecUL2uLBAvrZkqjPQecXH99KU+?=
 =?us-ascii?Q?toyF2bDAggYdVDGfBIOFAA0wxYH+OHl/KiMrZsC4NE/JmzVULTV93PSAev/K?=
 =?us-ascii?Q?Qg5kiDmJqBOT+FJWdYN/JKYSHaf3mETouqN7RGhfVFV9wuSpe3dC5rXfkk4C?=
 =?us-ascii?Q?g0FaDL+DUTyp8Av2aa1WrKDPRrLz8Uy98Yf+sbk27/kxNEcgNMHFOkCZ6z9E?=
 =?us-ascii?Q?s/FCHOLFaQuxPcTuUTIFZbU6w26TVvCooDXxup+oYe0IK2MXH4CbLKiqy/qN?=
 =?us-ascii?Q?f2B0JBpYo1w/8d1kGPqjXve3rB3hXQ63w6Hohxz77uEsL1srn66i6SaTP4FB?=
 =?us-ascii?Q?fD5Ez552f79hkmG/ntFEa1VcvJl7i/sr1YmmsVWg2J5Rl6COCijHqHW4yEcK?=
 =?us-ascii?Q?URe2vfxc3//MKV6UOAwHagUaZxqHAG7eN/a4G9ZmQdPrxRH7HapyrsBIozNJ?=
 =?us-ascii?Q?UN8gaEOriSt3Wr9goHou2um9O6gnQbhZ2s1j+E06Yk7XIqdPv7Btqceq3U8X?=
 =?us-ascii?Q?2jqv8guJ9k5O15IUkFuthBaZ0xSCOfqp7dXJxAwQ6Hul8pkQntDQ4QsIEFeu?=
 =?us-ascii?Q?H6IphIpBdW6OvTGiYLvKPKcmJhtuegBMOmStni9PLmDXRw6zr85W2R1MIsp+?=
 =?us-ascii?Q?8KRguF7TcXRbc4Mr4k0vXlPVm0TLBsvTvwnBZmBArvO2IvCT/VrVitH71pyr?=
 =?us-ascii?Q?/ggKjzhZPakix4bDXxKP9gGCpSoSWRAa6mU295PxTcXCZc8z01wPUqqqPHTE?=
 =?us-ascii?Q?G87hmQnI7/hRiPhpdZ5GrlQFsdI/vzkKKhqq5ek6CKvI7OQQxds+fk/RxXvu?=
 =?us-ascii?Q?bcnkHJNzNGCw2ajITusvX+0SFPF3a/YF5bzyeGxLxPWMs7xMqPAR9hCASqh6?=
 =?us-ascii?Q?zca+AWVCMh/e+WY3sqstu2Mt52jkn3tI3XMBltnvrignihTOWU/+QzAOptzg?=
 =?us-ascii?Q?L0SmC1SpKpvpbdMUHb5mnQjAkjIczuVkxq6gbZUHavMWwopCxsNHjfINUHPd?=
 =?us-ascii?Q?E7+UZ2Js1GLAtszgI/th7PSt0QtOhmMaYFmnHZ3LnSYlmNK6tlBVSIYZNdb4?=
 =?us-ascii?Q?S/PH23PwN+6E1Mk+h4DGyNZkVBLZ475vZGPEfEqb4yhoQ0MnupXgjgSCIzuV?=
 =?us-ascii?Q?ev1R0X3ZDdPqy+9+Cj0Yu//eDG7gFZsOGh+XyjB6DNsw2tHPWjoyOPIakWKT?=
 =?us-ascii?Q?WdmXorXte2QUjkVMPg5ymPLg5fVEWd8YAe5f0Lw0ZG0Ega0fukxmbWuwz7B/?=
 =?us-ascii?Q?t/ep9iXZtnSyi5hVqEE3M00=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5e2baa-8d04-4e94-4cb2-08ddbada5d5e
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:08:38.9521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpMv0geRT0x2vFxzOn5zCr27KMjIqsh+RRWYRNzQ3pWMHT3L3tKNnlhTSwv7w0hxAkhruCgrOpU+jfVckGyOj8ugXYnhL6nFR+xEdCvH7Q4NeTUNP21rWrWLxrXHs4Fz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8801
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:08:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19362

From: Biju Das <biju.das.jz@bp.renesas.com>

commit b7509775670d69999096b55c0e90a4e03a373bae upstream.

Add interrupt control node to RZ/G3E ("R9A09G047") SoC DTSI
and add icu as interrupt-parent of pincontrol.

Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250207113653.21641-13-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g047.dtsi
index b742e57f40b4..5b413d31b8cd 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -160,6 +160,95 @@ soc: soc {
 		#size-cells =3D <2>;
 		ranges;
=20
+		icu: interrupt-controller@10400000 {
+			compatible =3D "renesas,r9a09g047-icu";
+			reg =3D <0 0x10400000 0 0x10000>;
+			#interrupt-cells =3D <2>;
+			#address-cells =3D <0>;
+			interrupt-controller;
+			interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 433 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 437 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 441 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 442 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 443 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 262 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 263 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 265 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "nmi",
+					  "port_irq0", "port_irq1", "port_irq2",
+					  "port_irq3", "port_irq4", "port_irq5",
+					  "port_irq6", "port_irq7", "port_irq8",
+					  "port_irq9", "port_irq10", "port_irq11",
+					  "port_irq12", "port_irq13", "port_irq14",
+					  "port_irq15",
+					  "tint0", "tint1", "tint2", "tint3",
+					  "tint4", "tint5", "tint6", "tint7",
+					  "tint8", "tint9", "tint10", "tint11",
+					  "tint12", "tint13", "tint14", "tint15",
+					  "tint16", "tint17", "tint18", "tint19",
+					  "tint20", "tint21", "tint22", "tint23",
+					  "tint24", "tint25", "tint26", "tint27",
+					  "tint28", "tint29", "tint30", "tint31",
+					  "int-ca55-0", "int-ca55-1",
+					  "int-ca55-2", "int-ca55-3",
+					  "icu-error-ca55",
+					  "gpt-u0-gtciada", "gpt-u0-gtciadb",
+					  "gpt-u1-gtciada", "gpt-u1-gtciadb";
+			clocks =3D <&cpg CPG_MOD 0x5>;
+			power-domains =3D <&cpg>;
+			resets =3D <&cpg 0x36>;
+		};
+
 		pinctrl: pinctrl@10410000 {
 			compatible =3D "renesas,r9a09g047-pinctrl";
 			reg =3D <0 0x10410000 0 0x10000>;
@@ -169,6 +258,7 @@ pinctrl: pinctrl@10410000 {
 			gpio-ranges =3D <&pinctrl 0 0 232>;
 			#interrupt-cells =3D <2>;
 			interrupt-controller;
+			interrupt-parent =3D <&icu>;
 			power-domains =3D <&cpg>;
 			resets =3D <&cpg 0xa5>, <&cpg 0xa6>;
 		};
--=20
2.43.0


