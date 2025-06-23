Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA3DC77B7C
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:48:02 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.57])
 by mx.groups.io with SMTP id smtpd.web10.390.1750690076340392678
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:47:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=NAQUVRNn;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.57, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1CFIjgQqJnWCNCPFusxM2cidn/+hiTx2OBHBg2bL4HgtNDMPMMV5vcy5xbNNdxNTeF6TwIa72+KYRlCucLENmy/zy00cHYSRAcGek8awkHzHRJM0b7sEVQNReK0QgbMRl/ONsAz8COzHh4rNFirgn9/amQF1ntqCOaUWDX3WR0TmoQLEgKM+Sd7iwwisVdtLrYMKOSDsKjZdznvrDEnfqnjfUbb2J2XSfh8xgkyAtXb2OXZKVb/MTz96Aikd/G0+BXu6D7vGD9OgG7yaLNe0yY7Ylp0nMf4BjBVSwftzdD0JHkkrGK75KYS2Hkax2ECNDfKvSzPyUUaMzDDr/6Zig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJQUVtslxUboFtDWpkKGfVhhsRg3Koak5muzQSsRNhg=;
 b=lgalxpURHrmKdcl1v/S1cUxp2HjC1M3lHUDUI33cHlu8jeMBKFSL0RTNlvHdr4LYO4h0o8yKXHW+oxaT63NeB39w2sWMFjMfkcJiFauo3qprkRxy+YUipkpGSS7scTkCic4u22K1dLG7c+EHtBaPuFifkCFsOSnmsfOdDhcsdw1XNWHsiUBZ618mjY0/ZR43m1NkXRJkXROTphvMMYIchSDfyLW60WFBGMZgQ7I/wyZayVhGiShQcjsdd3mBYwXHQjuhv2M9LP7+t2l0JWQzD0cJoj9NTuFhnLoh45MvzIu6pmWR+msLGEVG5pqR4PLBrh5pO1Y2abcr29kNBgaGdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJQUVtslxUboFtDWpkKGfVhhsRg3Koak5muzQSsRNhg=;
 b=NAQUVRNnVIYyB75gNbX/WNJ/RHsKAIwFWibC5P3Oa56gGyc1v3G2QytV0u4Tudgi58dAJqqqj37e5FCPcLz1MbZ6ThEyLXa2hO8uMcNdNS6a8zPJPFH0vC0STqVY3MsnHxUMgsUTXLvydFRi2ARLeIXfbOgKTIKnq7t/x0irepk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB16379.jpnprd01.prod.outlook.com (2603:1096:604:342::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Mon, 23 Jun
 2025 14:47:53 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:47:53 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 17/17] arm64: dts: renesas: r9a09g047e57-smarc: Enable SDHI1
Date: Mon, 23 Jun 2025 16:46:39 +0200
Message-ID: <20250623144639.2119707-18-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB16379:EE_
X-MS-Office365-Filtering-Correlation-Id: 83233a43-5b06-450e-ebc9-08ddb264ef14
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?zAxGQk39izDAxOiEFQ4EJCTvy6laAVrSAyAL/K2tkEPhp1PmqF+bU24qeY+I?=
 =?us-ascii?Q?IYB8SEWPtBLiMmK3PxMt/aOVAPPL8NUDsNIKNIW0/WBwV62gmFof9LmkbjIX?=
 =?us-ascii?Q?MMM14YOqcpci9bZqcEb7rZnD0oTU0tl7TiXzs0pHhRsqZNJBWBgwdjLS9zlk?=
 =?us-ascii?Q?tGep/Y+4gcqN3rulgrZqh81dT6VEx6mn2dhWzurZDFX3+ytHr3DK5GT1QALV?=
 =?us-ascii?Q?inA6vVtab1A0pKwFRrf9Jvv3PtcGVdn3nZBO1TrZrj4X+hTwcg6Na2qxKmSY?=
 =?us-ascii?Q?5eVTERabQqrS1j+JJ/qShxP6egdM+zck3DepxLSNs7eIDXhyqyL0FzwtF6l3?=
 =?us-ascii?Q?B0DLuS7wlOpu2VmzwrlxNwq5Ssp54rTiC6Awd1fBDuzjr0UK+N2Syx4L2dlp?=
 =?us-ascii?Q?24x9gw37i/m68i8m0PFOR4oy9JOxR8/UQQXF4YN/5xZmXKIoAtzZAsBXVeuw?=
 =?us-ascii?Q?Yp6lfQJtoQd+AgLd0AX8w9vEZrrlN8bYLoeFTF1KVMuEQ/X1ovS1MzkNea4E?=
 =?us-ascii?Q?BsY0amty7ThGBcKXa2PZd64EALtnUnzOSx/D++NfgtNa1ib8MFdaciujzWv3?=
 =?us-ascii?Q?3565AO0/XTNZcU6yKUfdh23cr6udsSFEeFdA9BiMDg6d0ijmL27QwZUbm2ze?=
 =?us-ascii?Q?r8BXfYx9YKA139pv1PaqT38GdzePYhIEXBxgTjbuobqP9uQZcFqKB6DREGXk?=
 =?us-ascii?Q?PI2E3Z8AKhZjFxUgM/2MEhx72zlfnP+uNyVBUDSNLy9Vd+CI1vG5EXuQe+YT?=
 =?us-ascii?Q?iZHk9qRoADPxOPEaIWBXcB66UPrZ/XHl1wrQHuGHLZypVHjDK/o8TtDzYMDn?=
 =?us-ascii?Q?hECKpJqx7PET6sCJ0cQLXuOESGYp0fWN9JR72hKjejeOz+OLMTJEYJTJ3Iy3?=
 =?us-ascii?Q?54v0e+f4EEiLWYQXStZik42Zso/kOtDcWDL1DAliOU6X3oVCzUlbHwlecDp+?=
 =?us-ascii?Q?QT8TceNjQMiM9htMQpUqwWQrXKTNI18lNfjL3/PvItF45UH7GZnl0ruzxxks?=
 =?us-ascii?Q?xrREcis1N7Vdxkv5QiMHwntlrRcFO/OYPCc7tBN1DYuGnxzpg5vjbBS4goTc?=
 =?us-ascii?Q?NucL8KSz8jQdAn4raeGpY1wOwD2HIaXdYjp1BNs+Tvb2qNSuVK8oTZCSzTRc?=
 =?us-ascii?Q?LVk57xX3CGlkiTgjQO55yRKlX0LJfB0U/shB3Fosl/eGWPnstf7Ae3nch9YG?=
 =?us-ascii?Q?Dnyxns6r/XPXtksZ19ahCA8x3sy9/L1OBexj4XCCBDj3mp3swlPhXEJxLdeA?=
 =?us-ascii?Q?trjgm8W5OpHQjiqD7u6VZ9QkEaBMEX/Y/uHZgRCWUIvfgs0pLrGk5YpkXR8D?=
 =?us-ascii?Q?0fBhRIYto02ZM98uuORsxzezhT3jAaHjFofo304fTudEFIRHcsa4LQgMQnqa?=
 =?us-ascii?Q?SCThGVkOMxvNkb3NVrrPeGK0cMx8twJM/nMCYvyqG35sYTKwwHEUEvBFFn7A?=
 =?us-ascii?Q?ZjlGTFb3vNEIsdEbld0hCKn6LRFDy4QLGhtr7Z21ilAY/FiQxgDJNKb9Drsx?=
 =?us-ascii?Q?cw5PywaWHL8aC9s=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7Vd2gtl1jl+dGXkwfOmpwRQeYZFAr3CZwsh4UpCmvW+zZluFzR9Y4age0fHr?=
 =?us-ascii?Q?NjCSHvAoFeR897jKP9dHT5b53ixi6TgsL6kV+2H1FACILY+Z2IeIL3qGsMBI?=
 =?us-ascii?Q?OLYEsu9QpiNSWo3xXMY5/wU2Sg/Nk2yD6QIsyfCI/d0Hls4H2QdHgJYJNz51?=
 =?us-ascii?Q?PskYepFZjqsFJ9Uu/vub4GNJw7cF+PKNUFj/hw86MRoORJVc6lLQYGQPiCRz?=
 =?us-ascii?Q?TH7lPY8mimDye/18h/f9ETYLF3efiOKQVCYJsX+s5w2qS7Z/NwrCTdYK1Z8h?=
 =?us-ascii?Q?tISxlUN3yam1z0mcFoCLzolmCommEcbVHfRZlWuo9k2xLaxkjabXhGXWoq9H?=
 =?us-ascii?Q?UqbFhB1s9eYSnv0KvcnyIqbZXYfdfRLzbNF1+CAIgXAJD3meohJ78azC2qBa?=
 =?us-ascii?Q?VtiVVBSs0M752/aO4pL0F4OqrZ8L/opNpFCXK8J+9Ik2hwL5V30jlegXB+Yt?=
 =?us-ascii?Q?U8Z/2SlmbdFh1nTtvOcK31ooYufZxN2oJQinGBZ0bbO/jnZd+pee3krpBVF2?=
 =?us-ascii?Q?4ChFYwhr3+ZxUlk9SGG80nYr7a3ET+P9cFAX8y5oDnk9ZgxclaDFbpYRSeHm?=
 =?us-ascii?Q?bCCLz1w+Hkx2C73DxPZd2642v60T1nl913tpnEomvrMx7q/GRmZcEvZQUZ0V?=
 =?us-ascii?Q?XL061pdLB9fnbyIusSulCvfUzTDuErcfnhTq6/8EjWtuf6s/Nez+m2qjbct2?=
 =?us-ascii?Q?1GGZkw/2TtndctyrHiNrn5JK2DCxFXYP3Xe+vWgFBjb41oFIk1IiS1QdlnyT?=
 =?us-ascii?Q?BX69c/LfuChW7qxpe20Z+NaSo56SOCO5dLbdQ8cGPJr1kilWe/BkLEfo0ebg?=
 =?us-ascii?Q?9nSwwX+4rw4TlaskNwYtgitJ7c1ktFh4IkpyaF5j45Kr3I/9PuNmRliM9z4u?=
 =?us-ascii?Q?Y9oG6MVf4FSMD11ndX+kOSk0a+EGFumNaVO+KCoPC2rho8EOc67a6uS97HkE?=
 =?us-ascii?Q?h24sgbvakqvj/ROW1pkC54kcIppvmFQ4h6sZGlUxaZ6dyWmiHA5HnqtIxOQn?=
 =?us-ascii?Q?w3REoICi2Ng4/5UMb1L6F6COji1P5muwjiuQNNlL6LXbYFeDzrRlSZo8GoVv?=
 =?us-ascii?Q?XZdlo0UhkXOsXo6o896CAGvG96jITLfLDJepMFfQwFAWcpqInREeQZ5hnGZX?=
 =?us-ascii?Q?/2zCyDJ5cST0kl4o6+geqhTKIksDxCY/ou3A7Pf2YaT6jQz7jFveWZi2HYPP?=
 =?us-ascii?Q?bks9iyyw29vxX4KLtY5U5K+9ScO90Fmup+r9sZ10MQB63oFxh33TRMLjRW+y?=
 =?us-ascii?Q?SVa0MMm9EAYmWlLtAr/Lc8+BzDrsaFC4NhQMTn63O/QkuQEQTFUT637Uzfnk?=
 =?us-ascii?Q?uWMCePFKnS0smdbse48Rj8deAWbZJFt0MhY8T0hpCC9FSdAe6WxjD0wiA6j1?=
 =?us-ascii?Q?30ud6SCF6v75fMSrJhpDR67AngUH3d1Y4IIFF4h9BiVVa8jPKpPmFMDkqlIv?=
 =?us-ascii?Q?cz5a0q2k1nHPDs+xZ0uPe7kQvwCA7BGkybiRLZgCq0+RwBmf/A3m/qacn0fX?=
 =?us-ascii?Q?hiIt5KJTFgyYkCH3xuuAlbBGj1bVByvrbOEussG4Foi/Z94AhZkhOkhvo7RY?=
 =?us-ascii?Q?L0F+YopYOh2MTeC+F1h66wxmLeEVBcN0vJrVUErTnTL75N/wiYGdKMKDkgg+?=
 =?us-ascii?Q?vS/LcCbZT74JyAftrLmxpi8=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83233a43-5b06-450e-ebc9-08ddb264ef14
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:47:53.7096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNQnSmgg259SjDqWOVv7v/OAWR79NWMYg5NF+8rJ8cF8TezPkL/QIFjuXx7/1tKqy+E227MQsw2tx0b78NFt26X2ezLCd2AlRMpnMi6Ij3EJLshhK1uPD5ISEmBUiQuE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16379
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:48:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19204

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


