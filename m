Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC3BC7EE2A
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:47:52 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.26])
 by mx.groups.io with SMTP id smtpd.web11.385.1750690069142333873
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:47:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=v5m7EvVf;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.26, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+GRL70fHSbHkG1bRppssxtiGUUZodNGYXl0TvahqTuu/DkFzuLmHernbMXZdVzfLo1p1LrVytlba/uFSdpNjnvnDdZ/7hIIIyDMqbSopn24rVgFR1HOc9AmN4NqCol0/d4YZKJ2XjDdn4OP39Ed7OWb4Iw/Q13R2uqZqWMJ33VQ8pHc1iIgQFWtXdZoVf/faSWKdFsnLZpKpQWDs4chymhLt20Yr+MfO/3C8lxWJQXbyHQnkEwpiAqqh7779krKp4yxR51Da3aP/+42BqoezGBnX9u5ECKR2LvmMOnobHSucz7/H0l6iWlalsjyFznO9u5/1lsWYyjamX7D2ANdKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pvumz62MG/xTs/CRbo8VKsNEyP2a/n+ixGNltadO1/8=;
 b=i4yYF8Tlm2x7s3txNIBJgQXMcZWYJ0Pv5p5qnOwx/Phwh+Qc6n9El9WZcrap/OgnSEYW0QXejuCkQ7nIVQivbInF+EwdDuBzc0zH0iFejL/zVsMmn41qDgMVmhGDmd3yxqFiOAP9tmXhF9QGC1O+0oTe3YIZr0eo5eejjcq2uxddgwLlypfv0KcIMtSWr+dJLp1eVfppz7l8/wtdHwTblmK9hDxW0QeX4CXC/9HJkic+QxSlRpJWwFqMxvliCmf3TIJIL8KHM85XD3iokQ2UcgSeDLocglxzyJYiz0pT+ZpYcgdnQL7mFqrW6XvB42MaWj2bPLaPIL7H7k54I9tERg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pvumz62MG/xTs/CRbo8VKsNEyP2a/n+ixGNltadO1/8=;
 b=v5m7EvVfzEJRyK6zidd3HIlYySRIaXaGdSoMdQbFkvubzH+weIv8B545QKBXNded1ywHER77Kqh/Ys1KimbuFpY3K0+5ptAZb482wd8OaJUDCl9bYDuv19kzDzDUYM4moNEn+aJcY3KdjrqteNLfwuGDs063ANFu57dtOg+wiTw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB16379.jpnprd01.prod.outlook.com (2603:1096:604:342::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Mon, 23 Jun
 2025 14:47:48 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:47:48 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 15/17] arm64: dts: renesas: rzg3e-smarc-som: Enable SDHI{0,2}
Date: Mon, 23 Jun 2025 16:46:37 +0200
Message-ID: <20250623144639.2119707-16-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7b6729df-07d2-4042-3863-08ddb264ebb0
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fvH0H8KDkhygVp9cDLXEu7VVhWL4kk5Y0VvCPjUAFnHMtQOGVvgwQ3BANVzj?=
 =?us-ascii?Q?QthKx0/mYHlpGUEXCTED+ySYYExzkliYMOBSvKEwMIDO2XhMUfGmL/sm3948?=
 =?us-ascii?Q?yvapcYms1pabUlSVpe2rNt61f3o2QMOa8rxoe9rKjmmNSuWQCtU7oWcNh1Vj?=
 =?us-ascii?Q?zJikVeDNzHz3sN9iQ+/uiqSJ3uuin5Do3xp7h+XjX85/Y/WwULmYkS1KMur/?=
 =?us-ascii?Q?bwqMvIGXUOGC0e99ecW6BAdkWYJ/iiRVsEHfWySUxR4LXOs9zcx7pCoPsecN?=
 =?us-ascii?Q?BA2nYOXIA7iolvT+LjEzOTc07+w2k+6LRmlgQWncWrFVaq/5k5UcMejoNxi3?=
 =?us-ascii?Q?rxfENrVBfjFXq89yVV7v2zVCay2Hz58RbjXk6tjUMJXYu0u7hFNCC7MZAnJx?=
 =?us-ascii?Q?70Qk5/nAEeoxXuQp4Shd7E5UUT2sTOCAL+BXqF1paBq4myOg1LKITo5oWNTK?=
 =?us-ascii?Q?Uxp5rzS68cLkLy3ZUN75IA98keaON19OGNUSBP4jCEyZg5GTN3SKXYTWXKoO?=
 =?us-ascii?Q?iLLrpoTPfqMdJkMWvfTbFnEYZoe2OgPunuGO04G+mPiEzN5SY5KWqez63dsI?=
 =?us-ascii?Q?3OAd0MTvFnWlRmLCjhEOPWFakWfl8jLktj6Q92w1ZITFtd3/t4YysohlUNQi?=
 =?us-ascii?Q?u1X4XuK3pD3t7vxktGh7/Qt/od3O3OT1da108A08xT2Jy2VL2WxF3yptNBY4?=
 =?us-ascii?Q?/bH3th//xfKCyO4BtWJ9+xIxt3KBWTDf5eEZfQFrfDrUSwAlb3V9hoR+4hdr?=
 =?us-ascii?Q?68ku47w4WC6/Lr6v8Hp0MxCbxDY3ednmOiCYR+dkQTuFh+RXJhWrF2YwcO2F?=
 =?us-ascii?Q?5xUTYd9wxWct/R+4rPsf690XYnYPaI4llZ0lYvuUyXgr8dTi4qu2uaXXsNSr?=
 =?us-ascii?Q?mVFtgibjJYKFEcPg/fMdHWliKyem6rXvMZ4Tu4nKZKmWn9wdA/ylnOlf2W4M?=
 =?us-ascii?Q?vz3RaagYOqYy5euRXfKAKAxHzGRICjQXppf6wVlavxsl4F0Vz9lj04WLvv80?=
 =?us-ascii?Q?1zfm0GVR01shfY0qO9gtL2Jz3dPwf8Gyem+XbTV6hGJwuhFHsyX0EhQg1f0Y?=
 =?us-ascii?Q?YpwR+aawBy8MV5zLeiiXVIc5A29k78f+f3E8SFy8GZPiS3QZKi5DjFjLO8xm?=
 =?us-ascii?Q?5kl9N3UD7XVbpsBl8WX2ww45kwjQd1b8li/xvVLsGad94YVucnRpJi6eSxC5?=
 =?us-ascii?Q?VCx6aL1X8uPDFgjFEQTGmNPPFy1IQEDxhYZt2+MaFdNMXRQ8G4oitOrBYKAp?=
 =?us-ascii?Q?CQROrwEl7vlLLPWShSBbrH+XpxcsYeZmzEAks88V6u4gewRs3k+l0TL0BFR0?=
 =?us-ascii?Q?EBIe7dPj1KoBK0UK8MS3fkn0TiP+l55bz3esitMXq7Y0SvZiMn/b+1gmzP/b?=
 =?us-ascii?Q?rT1eM/NgNmx0jOfVI7hMsEsOiN2KOEey3YqeO+eZPRGzhl5pj64OmG378VFY?=
 =?us-ascii?Q?H2oisbFKHqMau9/rdBYTKtEjdUq+yoJNiDKK7mqKVTYvSoLzPrI+YIVOZb9R?=
 =?us-ascii?Q?b735VCPquNiBXIs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?azfN0vRtvtA+BvO0Cw2XQpVTSC9vntz5V+xLpNV8tKUt9j37tZgy5qSdc2AZ?=
 =?us-ascii?Q?2fFlspM3SgQsOIlHNVWUFo+dxY8Oehk7+XyDh2jSR88I0tBhAdPA8nUmhzTD?=
 =?us-ascii?Q?JwiubadBe70R0UTqyr9GNq20XCmmzsff/2//+fXqSdvPGeWTZCBDSBMFvlN6?=
 =?us-ascii?Q?WIyFRPCynBOFflukkKCZH0GRm4t0U8sWS/TTJi1mbx3NJT/HxLqJcMOd9Z2s?=
 =?us-ascii?Q?9O/vEVGsiHE/kmn2M2vidkXCQvDOqBPEh+9kzkp9oRrTKswTh3hZKbbPITlX?=
 =?us-ascii?Q?h3/EvCNABWRiLrOt/veHgL7zZFCtUvt+XuAyrCzwDY506AqmOlwYDm29/OUP?=
 =?us-ascii?Q?T69mvuLfN8EDjAOdmCxZ65rfu6d3yzX7YXEKJSX6I9sW0dApi3M/n6K1MwtI?=
 =?us-ascii?Q?dkygy//iZhnQ/CJLuFdxf+0h49xesAoo8/aqZG2WC30IvyvIIMiSpgaBY16g?=
 =?us-ascii?Q?7uIwwQ3RA1Kp3Ci8+WLhZyCYuZknaE982pHHmlt51108dPUB3oGjpw+5ykLp?=
 =?us-ascii?Q?ATks0bgG0u6lCtjHz42Sn72X0uQ3S0ODAKag4YRtwnhiC7PpmcrAQp4gofLI?=
 =?us-ascii?Q?7liSUSgbufp2APMiq1OnH+QLWkRtBixokGvOHROm3efO9wQubpzQnxpijNDv?=
 =?us-ascii?Q?Xs9/VgStoAKYBbsLcGt3NDF2IgmOjAySxbRThIGqFo+KBGlY/9t5h7CAc7tZ?=
 =?us-ascii?Q?1V6LAK/z0PUt0MnKV9mLq8uJ2+NFSHMy3v6SMURycDPpNAR34zmd/80r+oaG?=
 =?us-ascii?Q?fVP++Oj5+l2b5kVyT8B6nF2+NLkVSt3mUXNWZl51cbWLul1asVQVtwfXoUar?=
 =?us-ascii?Q?KviCqP+T7Nm+k7e5o+gxHybBsYyFoqa1IVq8vwaRYchwCQ2ArYdb3uRMtZXu?=
 =?us-ascii?Q?vjiZdFxbVNVtmphW0Hs89/8NedEqSSwz29RStf0jsKiM0bWiCQCm0NazNkpY?=
 =?us-ascii?Q?s9QNrj1ybfeZRMQWZCTprcJwj5ydjzZ5UzQCLITG6ogFso1UrS2JAkpZY1nU?=
 =?us-ascii?Q?pzx+fyAhgtqMg14is1kbIc8G5dhw9gJgEKX/zBn/gKKjSCDlGK6AQNccZXE2?=
 =?us-ascii?Q?3343pCfW4Tg3i3umsveRbgbMIxEDS7m9zKW4e0kvoVY2EGalnHR43jDWe0bo?=
 =?us-ascii?Q?9jVjaGoCtW7WvdTCOwTHr07y1AnhuB50bdBnlunJKjw7cDTXv3lc10w7x7xF?=
 =?us-ascii?Q?Ifcb1f0AybWwi8Ln0liJd9MZ/ndn2q59kckQNo27onCVEjA+H1sUUGvcd/OY?=
 =?us-ascii?Q?643FeJZZiMaCPM+Bc2N6YcuNNST6e2Ok4gYt3AEW5a739Knar2LvbzcihWVx?=
 =?us-ascii?Q?TJUs3yYH5aeYHoq/wOOwH2qYvBGSeHjmxHqygDOPF2wPDniVF1JVIP2XwWOC?=
 =?us-ascii?Q?3exasb8tC1g2uLwxABAEhqER7V8WWwvAQch5S8wtRcBl9pUukhWYBAXdAOcL?=
 =?us-ascii?Q?eo6PFjfSY3aXrr5zfqVdhDBYdp8xoIOBRgm1f0rxSMqizSNI56T10nGCKfiL?=
 =?us-ascii?Q?cgZmzKwxKgfOnGCe8h6a/KKBMVngtZvK1iXPvbxKlrPB2j+1mc1ZX5uw+HZ2?=
 =?us-ascii?Q?L+5KaWMTBoN8gGR2VsYX4zrInikP5/DPMO9cM7ZuRhZnHd64Af+1Apf3mmJc?=
 =?us-ascii?Q?h6Akz1FMpXqAkm1nznvLRDM=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6729df-07d2-4042-3863-08ddb264ebb0
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:47:48.0012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7savrh05V+zTsUQ0l2gys+NRxwUFr1Z15R2JemdH+ehn6dEh5Q5pQew4gv2kcs9WMNWFssHuIjhgf0T5FK0/k7KQ7JvywVwGF6OzBRGNeemTpNaECiMxhl19qrwtPnMk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16379
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:47:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19202

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 16bce534a391487c56aa266dff2ac5733b207f5c upstream.

Enable eMMC on SDHI0 and SD on SDHI2 on RZ/G3E SMARC SoM.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250206134047.67866-7-biju.das.jz@bp.renesas=
.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/=
boot/dts/renesas/rzg3e-smarc-som.dtsi
index f4ba050beb0d..fcbabe2cb003 100644
--- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
@@ -8,17 +8,86 @@
 / {
 	compatible =3D "renesas,rzg3e-smarcm", "renesas,r9a09g047e57", "renesas,r=
9a09g047";
=20
+	aliases {
+		mmc0 =3D &sdhi0;
+		mmc2 =3D &sdhi2;
+	};
+
 	memory@48000000 {
 		device_type =3D "memory";
 		/* First 128MB is reserved for secure area. */
 		reg =3D <0x0 0x48000000 0x0 0xf8000000>;
 	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "fixed-1.8V";
+		regulator-min-microvolt =3D <1800000>;
+		regulator-max-microvolt =3D <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "fixed-3.3V";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
 };
=20
 &audio_extal_clk {
 	clock-frequency =3D <48000000>;
 };
=20
+&pinctrl {
+	sdhi0_emmc_pins: sd0-emmc {
+		sd0-ctrl {
+			pins =3D "SD0CLK", "SD0CMD";
+			renesas,output-impedance =3D <3>;
+		};
+
+		sd0-data {
+			pins =3D "SD0DAT0", "SD0DAT1", "SD0DAT2", "SD0DAT3",
+			       "SD0DAT4", "SD0DAT5", "SD0DAT6", "SD0DAT7";
+			renesas,output-impedance =3D <3>;
+		};
+
+		sd0-rst {
+			pins =3D "SD0RSTN";
+			renesas,output-impedance =3D <3>;
+		};
+	};
+
+	sdhi2_pins: sd2 {
+		sd2-cd {
+			pinmux =3D <RZG3E_PORT_PINMUX(K, 0, 1)>; /* SD2CD */
+		};
+
+		sd2-ctrl {
+			pinmux =3D <RZG3E_PORT_PINMUX(H, 0, 1)>, /* SD2CLK */
+				 <RZG3E_PORT_PINMUX(H, 1, 1)>; /* SD2CMD */
+		};
+
+		sd2-data {
+			pinmux =3D <RZG3E_PORT_PINMUX(H, 2, 1)>, /* SD2DAT0 */
+				 <RZG3E_PORT_PINMUX(H, 3, 1)>, /* SD2DAT1 */
+				 <RZG3E_PORT_PINMUX(H, 4, 1)>, /* SD2DAT2 */
+				 <RZG3E_PORT_PINMUX(H, 5, 1)>; /* SD2DAT3 */
+		};
+
+		sd2-iovs {
+			pinmux =3D <RZG3E_PORT_PINMUX(K, 1, 1)>; /* SD2IOVS */
+		};
+
+		sd2-pwen {
+			pinmux =3D <RZG3E_PORT_PINMUX(K, 2, 1)>; /* SD2PWEN */
+		};
+	};
+};
+
 &qextal_clk {
 	clock-frequency =3D <24000000>;
 };
@@ -27,6 +96,37 @@ &rtxin_clk {
 	clock-frequency =3D <32768>;
 };
=20
+&sdhi0 {
+	pinctrl-0 =3D <&sdhi0_emmc_pins>;
+	pinctrl-1 =3D <&sdhi0_emmc_pins>;
+	pinctrl-names =3D "default", "state_uhs";
+
+	vmmc-supply =3D <&reg_3p3v>;
+	vqmmc-supply =3D <&reg_1p8v>;
+	bus-width =3D <8>;
+	mmc-hs200-1_8v;
+	non-removable;
+	fixed-emmc-driver-type =3D <1>;
+	status =3D "okay";
+};
+
+&sdhi2 {
+	pinctrl-0 =3D <&sdhi2_pins>;
+	pinctrl-1 =3D <&sdhi2_pins>;
+	pinctrl-names =3D "default", "state_uhs";
+
+	vmmc-supply =3D <&reg_3p3v>;
+	vqmmc-supply =3D <&sdhi2_vqmmc>;
+	bus-width =3D <4>;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status =3D "okay";
+};
+
+&sdhi2_vqmmc {
+	status =3D "okay";
+};
+
 &wdt1 {
 	status =3D "okay";
 };
--=20
2.43.0


