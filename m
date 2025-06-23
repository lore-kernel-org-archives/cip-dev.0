Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FEEC7115B
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:49:12 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.71])
 by mx.groups.io with SMTP id smtpd.web10.438.1750690146608586172
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:49:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ckVZnrBs;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.71, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upiu9dQh6X98tSpbMcu67b1al+neOL7oOL/vMeKATaPyfpVrUQJHx3g/3x3q1CtstHCU4WJKI84B3vIz0+xVeWNxJA11lr8xQI73YUnpAWskqaDw2kDBh4ceGb+u5+Agqf9kQuYE2STM/pzqHIuyT+MqH/s+ZhDqk0TXNOvL8DRdWVUTcBjppvKB6qcB3B3SuLseS+9Rd+NBOOCa6o2B8UgHoMbqLrWABP8sGLFe2I89kzNU5XFrk6kodT9EmTFnLsLuBPZil9zVUWFuN9lTsDvGGcuF5GjBasuDl2nYiAknNfSut5SL9V0hKtH4ORh21v/6/WzCCzEcFr7t0dKPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJQUVtslxUboFtDWpkKGfVhhsRg3Koak5muzQSsRNhg=;
 b=Fn9+dgrebbmN2yMSE3dBQwVg0MFXMDfIlNShwAOp6V/3xzoynCf6k3lzkFx4Y17vpJfDFY8fcKMtqUeXnxio4sL8YQOuxSmH8LEZH9X+Kp/T4N04pOaihUMamD09VyHgY6mcOSd0tn3NH+bIhNn7vB7N5whR7NUzKkp42cR6pkLqnCG6/PshfePKel4j5qeqo6xMVTMY1BIM2njhfEs7h/V1hSiBD5EXd9uyEqqS1LX65MkTXdjkghJIyuLDU56dLaD0qfYAiGNrU7yE0p+HtSgVrvJsR4PsA7YAEP/25DNonToruldyZ+E1+ODuKMUx+3bs5sQeTs2qC9+0Awtf2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJQUVtslxUboFtDWpkKGfVhhsRg3Koak5muzQSsRNhg=;
 b=ckVZnrBsmluLlt/QUGz+VvPdGiiekGIV3BBAJ2LAUAf/04qdaYD6EFCalZRgR/w2WX5CSwOQV2TBuRekFX7UBs1VuaWXxa3T3EeNyzLArO6xvu6+5PIWCll+geYCsDQmiZ5kb6p2nDMdy5Z18FSaum176C8GVskXCv+1N/P1qCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYAPR01MB5851.jpnprd01.prod.outlook.com (2603:1096:404:8057::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 14:49:04 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:49:04 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 10/10] arm64: dts: renesas: r9a09g047e57-smarc: Enable SDHI1
Date: Mon, 23 Jun 2025 16:48:17 +0200
Message-ID: <20250623144817.2119838-11-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623144817.2119838-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623144817.2119838-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0422.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::16) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYAPR01MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: df716745-1929-46c9-ecf6-08ddb265190c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?FOo5Uf/kxAce0r2Y/v5givVrdCS67I+vptgkmaVlCTclfj+TpKcfbxgxPjDc?=
 =?us-ascii?Q?nRQeW5N9o38URVLixzppusQKlmnsPJ1ZSRAyNhsvWhnzw9MU7UG030TUH7IJ?=
 =?us-ascii?Q?rlzn0hUf3ZLF795el4+922jOym5MPo29pRaWZCEqPgo/COFs/aUbRToNf1JU?=
 =?us-ascii?Q?clC9yGj+wZ9MB3Lrjj93TQxCbh4jN+VKpS8RCeBrOb49Cgi4LzGuoZQ9Z6OH?=
 =?us-ascii?Q?hTXBC6Q4BH00DkDvL1GTWvJkr7+F1VtRTBA4QWbxnVdItELeOljKoVqgraa9?=
 =?us-ascii?Q?hpzc4SZ3xA2rc4L70EnJSmbOl33ykGww+xOiT+jAAUJbje3Ngihz9Y2aNQu/?=
 =?us-ascii?Q?jA07qXs05ixLDkQthhretKLKn7tIUvtZK1TWi8ducJPSFAWJVPeobzKKkz4H?=
 =?us-ascii?Q?XVtZv/kXlhxSpW70IIrJnDiDuyYu0MhgZrsWK1Yz6xKJ+ztMhQ2SvK0tgNOf?=
 =?us-ascii?Q?cj8QVqn3u0V+JNOOm2Gzy5PL4TtrybT36S5VH8x5hPVr2b7J3D9eQ++YULbh?=
 =?us-ascii?Q?CSp/GmU51qcMzjR+M0L2FJEeMG9MYq2cqPidCwGl/OaZ3U+9QzrNDsNxd9q5?=
 =?us-ascii?Q?AtvRx2oRGjQLep+n4ayqdlDy2cPCBg0f0Ru1qYsszT7QLsWpZhO6X2R1z2Nc?=
 =?us-ascii?Q?3O4SeD6EpgWIacQZsZ9bMI/UemadlDWeKfVEugd8QT1fwz7zet3vJFbeLfTg?=
 =?us-ascii?Q?+1T6N/REKNGmfLYQpTwM/kLcrsK109Eyy1C02pUbMJlJGQtNEg4Uw2GhK6Jz?=
 =?us-ascii?Q?HVcAwyl1FSwIeQUAib0juULdZ++NmjWYc8dBMk6VuNbA3QK3S2qBUjqgmlUv?=
 =?us-ascii?Q?lMe5W+aYqZ3KCkhlrr3lfZGpQulnkgAvwDGPru/EcQx6raWm/bwFOoqmq1El?=
 =?us-ascii?Q?nwDYjQaBOMSS0/kTwSwU2gPFzMc4EDQ6Njf4nU8hl78o/stS3+kCyK5GV0jE?=
 =?us-ascii?Q?o3j8t6ib6+KidAoxRrWrUqP4skELEMgum5x/5jTt5iJjsNTUpF4DdYP97Kpp?=
 =?us-ascii?Q?jN8I/52SUf8UgxZ85s031TvCvgCEeC0RFukVZPmOWLrWpogGinoSUeEMdYMo?=
 =?us-ascii?Q?BoToA623xhkqnnzv0fKgTAlPu7IpPCAql3MdduQ1ku7i580DsxT3HRFUbE5r?=
 =?us-ascii?Q?u7x9oJFX34Md4Awu7kDSZnE8bG4Ou99N0YSMqhy5CAxUSPVtpeGcwPFF4Sja?=
 =?us-ascii?Q?/59JY4HNq92TKZ3MIzMZyi2y/3OV1xit5XtuRf/YEwlVIBiHt+kOGd31UY4r?=
 =?us-ascii?Q?Oy1ENH7R+qACKel76CRM2MkrSzRjzLuhh8tinqkHpSO5peuH+/HkngFWRMpQ?=
 =?us-ascii?Q?20lBkG16n4aw9/NVm7wmoNDxJRSnaYqh7PaDztoCEnSAnqaGOU9Lg6PI+uKW?=
 =?us-ascii?Q?9oBRUcUBx9g+k7X4uUm7ruT7LbLr3AaKrtnBkoxXaY40ie2CUM72Z+GSr9cA?=
 =?us-ascii?Q?ZJyeZPYslOH1SvUhd93admxQ4rMMCQuB6Y0bUFAXNPdEAKqGt2xM5+w9n/sJ?=
 =?us-ascii?Q?SnzDVoqVhFlsUg0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QX2lFLUjaS2IxxaPwZ0oF64Bs+6TwEC1w9qxaTMquM3uaw7hFc7xxzV+X/hV?=
 =?us-ascii?Q?IzjfvU8pTlDPnkYyZOLAgZCqTDfNVV0gPsMwJrA55JXBIzjI/ZscBbfYtycb?=
 =?us-ascii?Q?7r3v/85bTGaxr+L83i8SjKK43ox4gsoNcjzCboh+4UjZqSTi4jla2HoqXo5e?=
 =?us-ascii?Q?Hl3w0Og1LasJCQYa3aGWLBfzq7Xy5sUWhyhBRUHnf4pgIpYENLTY5yQMNwl7?=
 =?us-ascii?Q?AgJ96Gk2Pbqw93LnP+rpOpeQBypDbXQ8T0W5UZVU6ulS8Imoc8NXFfCnaUmq?=
 =?us-ascii?Q?LQwyhwELOwsxajXohO1QWsysllwRQlvtEByYqnRs1xeMfo70BjHW+ZJligig?=
 =?us-ascii?Q?xnX5H9Kx9x/yVgNKfGqE7T7AmhU8MRDdn0ccq0gCQWjgZIgHFewKcXw1LFTt?=
 =?us-ascii?Q?A+f7WDnJmOwx1j9AWAEY07yqp5eimnmmi9dvThHhhaZlTwvE2S5dJtF69UtZ?=
 =?us-ascii?Q?62TUK8U2CTWT2IEYQHMjWbDP44wELQl2tUn9/yI1sGJa6lufA22klWChjMa7?=
 =?us-ascii?Q?NE66gYWPlzWjs44f+YWSSadkyg40trMmNrvL7hiY9mGaXLXArbZU1jS3yukT?=
 =?us-ascii?Q?xSooJxsXbnU0gc/I8/SxwYJhfzuz+T7oEMtYE0qE74vfzDrO3griWTO9PLPI?=
 =?us-ascii?Q?g5XVvfZbfbBne9F+6TeiVK54xQG0qkMryxPtH0Jo0PwT4qUS4uOSgZcopPc5?=
 =?us-ascii?Q?BKCwU4gAJV1h0F9RxbZ6KDZFk4dhLW7tlLW/y6uKMXNZJNk/SidEKeR5Psem?=
 =?us-ascii?Q?PnJxVTrutCpUYpQKsoCQNT8sENHhqCvngajkb1aFmvFQqooVcFfRAooP1UTk?=
 =?us-ascii?Q?L25Geh1wsW3h+l+IomP/t/kzIvA7HQT/3syzEH8zw0ERDK3zgK+ccAQxbn/a?=
 =?us-ascii?Q?aD2nDE5P+DMAg+HmyxqoiXNEQ8uL9hAX6A9K4PwybuCn5i7MdsvJHoztKM7o?=
 =?us-ascii?Q?Mbpu6gbJIlzuWRymmY46YWPQzryD+9RZ2pu4m9rHGq/y5Ts6TUZBZZgZUtQd?=
 =?us-ascii?Q?dbJGmGs+MCgXyesNnuO2+LqPf3t3BmPssGI3sg/eQ9TXh6/vLIEV4cngYIdg?=
 =?us-ascii?Q?2r+Jz8eKGheORk9B2PBc1kAh6+/mQ6fgZdZnZuuOv+1Vm3/jaKAnI4pwNQbm?=
 =?us-ascii?Q?yYLJHmFsf4cfCb8isq2AdeO+ayy73CtKlpyqXZlgqPUNJKpUSdQ7gR4ImLDA?=
 =?us-ascii?Q?81Sh+GCp1zqU/gI1GNvAysxadavRT9sfflwnI0RwwA85oRKxK1t6OpvF34gi?=
 =?us-ascii?Q?/Uw6xM8Malp+AQakOwH+hSLd4/UV8Akqa/TSnkf9NqOPyToaSaINlEqgRtYX?=
 =?us-ascii?Q?qStTRmTkKhPaMO0D3aElfgeEHlayzClVIxAXy/YQdW+nl/mCgpHM3LmuH74s?=
 =?us-ascii?Q?qp4Fa3MHaBDsMPJHZwBRtjoimLVcIjMIrM1Dlg7E5JVA/Yld10v87hL7TXdw?=
 =?us-ascii?Q?98ey+d4VuH8MYkSibUCyDh7Y1jjiJPgm8X5yGoxJwfYx4incK6zIPQUxbNl1?=
 =?us-ascii?Q?9mw/blhGuAfeO9eG77AdXOIoiRfpt5oTC6hHVe/dTlxC/xzpg7g6s1BFXylX?=
 =?us-ascii?Q?dr51DFVXOjc2axuwDMmGLr/RXd10pnpRowngaBn9wpZpEm5ny4+g695kOE6Z?=
 =?us-ascii?Q?H/sGxJ1cRhVQCpx9pevmL84=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df716745-1929-46c9-ecf6-08ddb265190c
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:49:04.1191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snIKz0UyutHloezWNsjfeuA9OUko0AFFRB3FelSIqw9CuWb2dsFnw+JIe9qQM4z1Rhb/xKFQeIE3M+vYQheaX3pZQupoFigdB6sBB1K/fOykm2DfnD0pC7gfh+umKT9h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5851
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:49:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19215

From: Biju Das <biju.das.jz@bp.renesas.com>

commit ae9edcbc712249832beb3f5457cb03cc809f72c4 upstream.

Enable SDHI1 on the RZ/G3E SMARC EVK platform using gpio regulator for
voltage switching.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250206134047.67866-9-biju.das.jz@bp.renesas=
.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   | 46 +++++++++++++++++++
 .../boot/dts/renesas/renesas-smarc2.dtsi      | 18 ++++++++
 2 files changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm6=
4/boot/dts/renesas/r9a09g047e57-smarc.dts
index 152a00aa354b..5d7983812c70 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -9,7 +9,9 @@
=20
 /* Switch selection settings */
 #define SW_SD0_DEV_SEL		0
+#define SW_SDIO_M2E		0
=20
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/renesas,r9a09g047-pinctrl.h>
 #include "r9a09g047e57.dtsi"
 #include "rzg3e-smarc-som.dtsi"
@@ -19,6 +21,16 @@ / {
 	model =3D "Renesas SMARC EVK version 2 based on r9a09g047e57";
 	compatible =3D "renesas,smarc2-evk", "renesas,rzg3e-smarcm",
 		     "renesas,r9a09g047e57", "renesas,r9a09g047";
+
+	vqmmc_sd1_pvdd: regulator-vqmmc-sd1-pvdd {
+		compatible =3D "regulator-gpio";
+		regulator-name =3D "SD1_PVDD";
+		regulator-min-microvolt =3D <1800000>;
+		regulator-max-microvolt =3D <3300000>;
+		gpios =3D <&pinctrl RZG3E_GPIO(1, 5) GPIO_ACTIVE_HIGH>;
+		gpios-states =3D <0>;
+		states =3D <3300000 0>, <1800000 1>;
+	};
 };
=20
 &pinctrl {
@@ -26,9 +38,43 @@ scif_pins: scif {
 		pins =3D "SCIF_TXD", "SCIF_RXD";
 		renesas,output-impedance =3D <1>;
 	};
+
+	sd1-pwr-en-hog {
+		gpio-hog;
+		gpios =3D <RZG3E_GPIO(1, 6) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name =3D "sd1_pwr_en";
+	};
+
+	sdhi1_pins: sd1 {
+		sd1-cd {
+			pinmux =3D <RZG3E_PORT_PINMUX(1, 4, 8)>; /* SD1CD */
+		};
+
+		sd1-ctrl {
+			pinmux =3D <RZG3E_PORT_PINMUX(G, 0, 1)>, /* SD1CLK */
+				 <RZG3E_PORT_PINMUX(G, 1, 1)>; /* SD1CMD */
+		};
+
+		sd1-data {
+			pinmux =3D <RZG3E_PORT_PINMUX(G, 2, 1)>, /* SD1DAT0 */
+				 <RZG3E_PORT_PINMUX(G, 3, 1)>, /* SD1DAT1 */
+				 <RZG3E_PORT_PINMUX(G, 4, 1)>, /* SD1DAT2 */
+				 <RZG3E_PORT_PINMUX(G, 5, 1)>; /* SD1DAT3 */
+		};
+	};
 };
=20
 &scif0 {
 	pinctrl-0 =3D <&scif_pins>;
 	pinctrl-names =3D "default";
 };
+
+&sdhi1 {
+	pinctrl-0 =3D <&sdhi1_pins>;
+	pinctrl-1 =3D <&sdhi1_pins>;
+	pinctrl-names =3D "default", "state_uhs";
+
+	vmmc-supply =3D <&reg_3p3v>;
+	vqmmc-supply =3D <&vqmmc_sd1_pvdd>;
+};
diff --git a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi b/arch/arm64/b=
oot/dts/renesas/renesas-smarc2.dtsi
index e378d55e6e9b..fd82df8adc1e 100644
--- a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
+++ b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
@@ -5,6 +5,15 @@
  * Copyright (C) 2024 Renesas Electronics Corp.
  */
=20
+/*
+ * Please set the switch position SW_OPT_MUX.1 on the carrier board and th=
e
+ * corresponding macro SW_SDIO_M2E on the board DTS:
+ *
+ * SW_SDIO_M2E:
+ *     0 - SMARC SDIO signal is connected to uSD1
+ *     1 - SMARC SDIO signal is connected to M.2 Key E connector
+ */
+
 / {
 	model =3D "Renesas RZ SMARC Carrier-II Board";
 	compatible =3D "renesas,smarc2-evk";
@@ -16,9 +25,18 @@ chosen {
=20
 	aliases {
 		serial3 =3D &scif0;
+		mmc1 =3D &sdhi1;
 	};
 };
=20
 &scif0 {
 	status =3D "okay";
 };
+
+&sdhi1 {
+	bus-width =3D <4>;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+
+	status =3D "okay";
+};
--=20
2.43.0


