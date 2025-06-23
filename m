Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E421C77B7C
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:49:12 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.55])
 by mx.groups.io with SMTP id smtpd.web10.434.1750690141780351673
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:49:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=RXFOPHrS;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.55, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYNr5GlPnwKxeiT9E8Pj3x579gk2BH0kaLrjv9HEkHj6ZdcUr+Rv+BzhaZWsuDomH6N7WNc+udRqB3IBaAOHJPQ4BbybvH1bohDNOYuDE6EIN9p1BxTHmi3HdAWtiAkFeyigwh1O6ZRBlZs5A6VQzuXIuV8SmjqtUT5fbIuOy2dBEbB2fAB8qgLyHw3747V3YAYI4y13rnMjq2XuRyGX6Mj2uY0kkBL+d41Okma6hC4/aNvKDnRwhHqifJNVB2QW75Y1u39y9cv4mc14g2bnAXcKogJkyE9BAaNOt4OjQATMFj9l95vWYir+1U8b+FI1z92YQhllgveoFtmMEWYLtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pvumz62MG/xTs/CRbo8VKsNEyP2a/n+ixGNltadO1/8=;
 b=i+4NrEhGu3416iOZDUP/zfTn1QilAai0TG2hmKKUiQ2Wd2xfdMVAMGgmMFia+EUoe7MPoRgaE9050yUa5MSSbGIRKBChPiXBWi9hWTkNJk52UcoFCqbNZZM7LU7zwW7LjLuIlY+NzM3RoCr1Sx3chf3bYzR6NMIKDefr3sE4TvRcxmTpOZFsOFYkYGp3xn+DEfdgsZKAQXPpJO9s9A/aXdGX+dK2gu0P/4Hk1x9Du2XCHxKQrEmC8GAP2hwaCGZNrVT+Dkc1KfzMvquXiCopl8I4VGOccJ21m0fslG4mCkUXhEDN1I3Sv8jU7FIJkGoCx7bBfMuh/UmBu9MY5ysbXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pvumz62MG/xTs/CRbo8VKsNEyP2a/n+ixGNltadO1/8=;
 b=RXFOPHrS9w2SD71v3LFyz8M5g3SHvAAZjM80JNEO689iPwqZU81BcQdcn+VpjpyVy+vpO/5t2w3s+AZEwBDxiWOp5wQQXB/b5eAPsCBN7eAyty8qPPpChlL/1+fzPL9gRwxZVH4NIfFwBCX01niEiwxO0+8WgKxCPge3ZGJjsVo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYAPR01MB5851.jpnprd01.prod.outlook.com (2603:1096:404:8057::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 14:48:58 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:48:58 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 08/10] arm64: dts: renesas: rzg3e-smarc-som: Enable SDHI{0,2}
Date: Mon, 23 Jun 2025 16:48:15 +0200
Message-ID: <20250623144817.2119838-9-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 21f7d81f-1452-4941-e519-08ddb26515d7
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?h5sE7/JnsakxBYWGnJtmfaCSjPKcDNxd4FAZDkknCQqLiiKkQHgXYU29b4lw?=
 =?us-ascii?Q?5IxcpHhTTycQZrGGaMNnW3VjYTNS8lROas+ru7+lD+uU4IOKOFj532rcTqgr?=
 =?us-ascii?Q?Qq2BID5wbyq2TtfBaUAxL1Khi6SiHYl+YglzyPVe+iiH3gVVGXQtcueZbVBi?=
 =?us-ascii?Q?kh+1RyxRAJnM5Kowms6cH8EKieLAbSvIIWFi7ZZ0tEe/EVinfAMahHRY+Ytp?=
 =?us-ascii?Q?FV8P8E8N7wFg7helUMRzWjj6WbJfIGuejqn/tvIoeoPkcylQTwVVS2tPhELk?=
 =?us-ascii?Q?uIPi/Hiyx0D7aW5a84RxxAoq6wwRQMI8GUP791L26rF8TnzzQqYeOy8qnI8A?=
 =?us-ascii?Q?ZHBLftd+mOtBXWFuQyvAczFiE6RZxl9dQb7MD2PTrZExMFfJ5rdXm/d3a4Kb?=
 =?us-ascii?Q?PwALaYlvVaxY8m8/g7Lzm1sBrXn5vuCtbhkvRyb5viPo0v86FucsJHugMYJQ?=
 =?us-ascii?Q?7sdotO5Ronb1F2nTh0u9ej9hIe5XPTKZuSrACvZIIdCyE+1T3igq2c19jmIt?=
 =?us-ascii?Q?HbzYnLjCpae6sXYTSe8qTlE/u5XqK8zyaPCoxD1T3ZA5e7P+ZmBBedcz0WUY?=
 =?us-ascii?Q?58d8vKseXVG4m8RUrww+bev6zGyaUbyTvV/vI2dqcsMt3MdQyzm2uUotO7qb?=
 =?us-ascii?Q?o1c1UgwxVZTAT0MksFmaBEFYCPu2E/zS6CO58MriKadRgF+5Y1/d5Z+l2iVD?=
 =?us-ascii?Q?JH7LzbCHwSk5iPwr5lj44lEUURyu1rO1WB1fb86YVYYP6vgHfsVb/8EMdb1N?=
 =?us-ascii?Q?F7ihvjJZrTA/CBfCX05WzDd0nKgAfu7JGaDkL/2M1t2B4NkiDvQkiW5iIbql?=
 =?us-ascii?Q?wH0tic7CVm2L9gSH7r+qWiaY6oWekHm7HRW4aBkZ7zlrb8YBKASNoURxTaCG?=
 =?us-ascii?Q?a5JhPC831zCbmu6PASY2zgLnOOAUXMNDO8BXqvGhAZ6+Thi98Fv5p8XVgNnV?=
 =?us-ascii?Q?ZOQcV50OKsqbEJ0FZAnmA5+XMtloMM3LybRAiLfThGIof0GvPkAL2ot8oZaT?=
 =?us-ascii?Q?GLWrMFcaFcJ/MDwdujePWsG4yYV2XDHj/oM76C2rNq3YugXqm4MoL7eo4IiB?=
 =?us-ascii?Q?PjZJrFyfL5AuIHe3UyQfu2SMeg12Q89UXON2KHfJbYxftqkPLL7SB6Pbv1Xm?=
 =?us-ascii?Q?6fOTErTOYPrLxusRFcNhHBLB+VnKchjz6SBmPUENXXskA/MRuVXKIZN96dDL?=
 =?us-ascii?Q?RjLrEiMj0HGhieH4nzXJrsQXUZOTeENqIujFZa4DfnJll3bTmGG35QXX7mlD?=
 =?us-ascii?Q?Hxa9VtoBJotH8SIZJbWMtdmAqkr4/Oysj9nJbyZJNc5a6z++BniQvFjRoN+i?=
 =?us-ascii?Q?2jjLZDcLvsoET8CBgazMb09gNv5EvWO65tJVkPnqs0cmEGR308rTAoak++iI?=
 =?us-ascii?Q?Xj4N8jRtD89T3R8mvVSHoLSpwTqt2PfNuGvhCSOv2A1JwYmzz0Q/CUCON6Kv?=
 =?us-ascii?Q?Fxfwam/CIT7JPGTpv3Q9nImy/MvksFc2cjb1WXLMhqAJRUUq4++RcdUzq84A?=
 =?us-ascii?Q?soN/iw2C+AJ5G7U=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5VG4XgN6oG4Rb9Mqi1RsxOxisoItWru7T3OfJW1z19HCqzuBtKpIVAfKydhz?=
 =?us-ascii?Q?36bCxSJwuPMopkQCnmib0kREU1//nQso1Zwrh7v+ydqkWRwqiSzMbCmGrLTF?=
 =?us-ascii?Q?x3Oz4daOTfqihlX2HjWUp49xF/t/2lcF8UI8lnKnrNx6AwZcUSOGGIji8CnT?=
 =?us-ascii?Q?Sw9oZ3qw5Nf9PvAXgU+qTjhyia5rio0B5E0CC92OwIiPHCvdMQt4aB6yNILs?=
 =?us-ascii?Q?DjGit2SLKzLRQg591R/KDJ/i2LgK9shk/ZGOXhYyVosrurbMzQa7toDXW9Ng?=
 =?us-ascii?Q?/52YtETFBIXWiVjmgiiMTIER3f2sviVyWs0dnY8AjsKqoNKGsFJY37s/jeUn?=
 =?us-ascii?Q?Q0Wuu4P02tpZCFpHpIETJr7bA5yXep1T3Al0hS4mKLmvxcZXQAofhe0s6JfG?=
 =?us-ascii?Q?dZVmehbhb51wAFMsA6jGlg7Yp6t8o7WXeR5BxA/1xKHXCCmVcbCvvAuD3PLC?=
 =?us-ascii?Q?RrvcHZv2qQBvsvSjqmVHxnUyZ9US/O6LTUMe3YEvwZyrImcXcWzWu2nxi8yA?=
 =?us-ascii?Q?AhUjPcUJCSm4wi9GFLe8fb4fmwqSD/jkj40G20IFV6Xm8iCJjAltKvrqcHJn?=
 =?us-ascii?Q?B+/gZ/Zs0sP1dxLukgLTz7kqZwjptaVWR/3lZW3oRb1GgEhrrXjTlQHhs5C7?=
 =?us-ascii?Q?6HgrZPHXAPQ1k9ntsmcenXEyxZ46Ff1wJ6CoVu+eAgelPOsUvMic4GOtOdal?=
 =?us-ascii?Q?MCfWLzC1T+DJsuGx6/PZiZuGUptC+/dzz5aLr8elzLXL8PftOsToVBqqDvgc?=
 =?us-ascii?Q?gmkxGnjEY3Sc+Xir8SetFfl6biBDs17d7o5MIb3TMnYDECnukeIP+CBdtrYU?=
 =?us-ascii?Q?I+3GDDKGHigPz2Yle0Fs4xHHycKEJC1idhdWg+UOIkdN9NhvVZoTWPKH0Igo?=
 =?us-ascii?Q?hwKihfuw0AXddjDoJihFWl3ms+8c9kHBt7IujRX7uhP/P6axchfiHuh/ddng?=
 =?us-ascii?Q?Z+IMCcovWiP0i7Frd6dHXqieDZTw7E3z9BCWjOdOzfbvI4LeDcKkTWTauwje?=
 =?us-ascii?Q?JA1YUbXiRBdzyVID8TQofHLQT131hdBcUsE20jBMyIv1N2QgX0VItFaopnu3?=
 =?us-ascii?Q?pHCfpA1RzAelPGY75wV09fQo99IX2H8JCi224ICVWUBp87J7rOVLSONZhslv?=
 =?us-ascii?Q?PAUC2/0jGWSJBdfX05ueeuYE06PXpA6QS4Lmb7Yjo7w+geaLkO01RtpoZyC7?=
 =?us-ascii?Q?DhokouHnvltkyqEVcPKOXAFte6U1ID38snTsNfpyI6AcbQHubPwxzZGmDowK?=
 =?us-ascii?Q?bE7LR9gxycghTMzaqw0drXqbmWCbMiwA8ua+ArM9Ezbbu2i5XZBXp08BoDU5?=
 =?us-ascii?Q?BkTEjipECNELKu/IH+gc4hqzb0VgU7Vlw0EwF9Rpl/u1LRJ0nu343z9yMpf5?=
 =?us-ascii?Q?283dSQlIDJoQVM2+Z+F/MN2uvcLkXHCpohBrORDg8QzVj2rOzg7hddu4pZ2R?=
 =?us-ascii?Q?ckZcG4zW9OW0vPr4xkRzPDxbxuL/J1Rt1Nb3qOV1PsXmVeqLHpYGY1QWUinw?=
 =?us-ascii?Q?IGCMjLo8nlGBljVvMMwZUMLWfFkCLdaQa0XuN7f+1zZ5abeDxdxOQMyDeb19?=
 =?us-ascii?Q?po10iHf3pfif2/IkQLyb7z9VHmGpgw/w3A9TsX1O2ivH10pqQ72DgG0FbO5H?=
 =?us-ascii?Q?nuQ+7lpnod1l16wmYf1ze+4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f7d81f-1452-4941-e519-08ddb26515d7
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:48:58.7260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMcWPSFX4gtxvuSIGeXtol9lO4XofIKQrs7aZIR3AFRMFt1qha1o5CGWBNa1Fht28+vWgeVWmDQGsZoIDwF0f1JOo60Epp9T/QviTu7iMbwMShTooz/ZGDPR8ARWvO6M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5851
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:49:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19213

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


