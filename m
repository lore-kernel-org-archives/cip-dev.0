Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98003C36014
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:47:41 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.34])
 by mx.groups.io with SMTP id smtpd.web10.49100.1743418058978427029
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:47:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Ol8gH21G;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.34, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRJU2ZGSlEybFn3b8SNqiSGaJBuVafcecNhAMA7+a9pUhO40VXwr6yzWCwtvtjaM9DgVqOG5FTBliVpZV7AVhxrZhZWAKYjrwUAd4Hm7pdAfPpGG8rH/bCe2x3bXQI3vBVazfBBv/kyMn9+gVeZQvNQwiTF1KYaUe3ieHr0MzsFl5z0h8q3jJk2m9uYNNavpewVDGIb7rXI4BxEPsqH/Om9gbf1LoXPDqmFHwXi5JbWRFnty7BYn+uZoXvON9Jj+TROqI49oUxvFgPqiHSwnlf3OYeusQZbwviUnifV2O3/Cs56m1Yq3Eh1MnBR5Y3sxBNdnTMO+28ZZoTrVDvNdXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Yq9Jz04NjuZNbgb4MZkft1h7sVkRAZ/Ed1ufs3vzjU=;
 b=MwCXEWpx0QMP1030j3/pXBYSgYYDw+tRK2uswa4GQ8TAU3LJPAAUhvwm3KrpfzrtyYP06ahowMdhzFFDE1ZNSFF71UoIiadLAmsDiC7Wyc3dSgD5VVoxXcwibapID0uZrGRrBak07c+uDSzE1F1YK+j2en8UPvuoP61b4i/o/Oinw+mfBOi+7PxoLFmC6T1jn609tYNBgGfsQHRoTnSWn9sX+aELS2zbge1JUjxZn3D4M/+ewE/GT9VPbGcHxn8KhUBrZkfYeRZvsqf169JsunqWsP0TQqysI1EFMBtLvqrPbbSn4GZeMCB8ZVuwZLxKOdzWPr8GVPbTHzucuXH94w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Yq9Jz04NjuZNbgb4MZkft1h7sVkRAZ/Ed1ufs3vzjU=;
 b=Ol8gH21GWTEJNmsm4ojMkZyV5brCwmEJDgKuKSmrkvDB4h7ZWi9TyWHVjsuII/OZrgYeyAUsif/GnLvrRkBBUEZnvAujOThTYFPbvjTXnLozAPgj95vdulPBfJ78QmStbaNIpuwf92GTLoma8VqrB78QmzFzaJvdqtvBv5UuSGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB13299.jpnprd01.prod.outlook.com (2603:1096:604:34f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.31; Mon, 31 Mar
 2025 10:47:37 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:47:37 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 42/43] arm64: dts: renesas: r9a09g047: Add pincontrol node
Date: Mon, 31 Mar 2025 12:45:13 +0200
Message-ID: <20250331104514.79090-43-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB13299:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c41809-9a35-48f9-4309-08dd70417399
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KqTEFu+GN3kqsYOuhiRKgs7I33hHa6pLsxDy7Dzj09xki6zURrJGbuZrcDWq?=
 =?us-ascii?Q?0dahnTejiApDnb5L6hf8Ia4Jo0plRNe9ivIrzwjQhuICfyZNXcwrZXfqm2tj?=
 =?us-ascii?Q?WvAa2QERoNfVju846s8wPRK3UGds0F+kXPBIWZEcK1XxI+wBejKwv3LD5Z8+?=
 =?us-ascii?Q?Kt80MWF20HVPFA+m2Pxk02v13jUoqF528NFFJ/l0NhDjA42kCTVcmdwkNx0H?=
 =?us-ascii?Q?jkTgX3n3etKOut7r40fguiwpBskHF/9Ds51lkaBaWg3qisdvpGeXXGuh1SWy?=
 =?us-ascii?Q?QawLMnUfeTpS6DuPRZrVe4GVYSuj9U70bYOj67VmhqaygOcTwf1D9z/FJgbj?=
 =?us-ascii?Q?EMMOqFtzI2IoTjt4EopO+qeIKaAxVNYBdCwA/3rqlyZoBmWBXF7za66ykTVU?=
 =?us-ascii?Q?emzQtd46+kIwtQwEF19r9miNh6tJIFSu0WAqpV/t7touFlnIejm0Rk51Jr5g?=
 =?us-ascii?Q?knnSEaGgtajxLiV1r2hgN9pg7hyPXN+GbtrLtF9025wbbs2nCeAs/krc98fC?=
 =?us-ascii?Q?b9CaK/FDP/977Z8/q3VCviz3mI0H07cTP1VdC/Y6PVHjXOxLRMW1pyHM5tia?=
 =?us-ascii?Q?XLK8vaHL1SWcDGuzDcVO12TO6Mf+A3+xzGCqJcG1fwE0XsxnGf4R9v2Uf9DW?=
 =?us-ascii?Q?2RpMi4TeLM1fP8c4yuMUOn2aoWJYNvUxLsRFW+us0uCBExhkW3HtlV4DzHFe?=
 =?us-ascii?Q?arbvot7X/zRhlquWmM6288Xf39FPHJ/VlPO4gUFyePdEUHGkBwH/3kNsVwXt?=
 =?us-ascii?Q?lO7qXgivT+NJAQ4qAQ8R13hcuikK+IgcGqACn8njnE58KeRCHFvIMqcBt4sw?=
 =?us-ascii?Q?Kj/Dbc6+jS7F325PvVBOBKkMegsf38jJpccQLUzr9uIxcKIr6o5jRrUKXeA9?=
 =?us-ascii?Q?SJElnnnXC9SKw58XJyiejI7F71Aowke5QanRhO3EEidyYS//R4C/YR32yODH?=
 =?us-ascii?Q?NUpDF3MEa4SK8NZ2ztCTwko0lPw6JJxLm5Idt0t6MR8Bo5I3WQ3mS8ArYWnu?=
 =?us-ascii?Q?mGHWAtJtwwpbPXk7gXi3muzmUlre2TWfzh94Z7eUDwK7xI7wGWGhONSTlKLb?=
 =?us-ascii?Q?fQZSSwtaobUCQOXJOFaAgyXncPoLeH+Fd4QJcPcF9Ceo3ZY0ZtOhvZOu9sAZ?=
 =?us-ascii?Q?iohDYvxa/RgoMkoA5UevZCF2t2jjvc4vFSGftHijoKfNdtcAwU0CyKtX4Bya?=
 =?us-ascii?Q?Bvk6bXinzUp7KNCCZiCEBdVKhvfn5syK0XiBCK0U8dvSaR8Qg18cWU23dAWo?=
 =?us-ascii?Q?UbyY1yY2aomoDYCnVFFZuC/SAffhnksez+EkT/+j2AwPJavEd1v861R8gryU?=
 =?us-ascii?Q?DLjrqVwQti3Zntc7VG79+1eN6SCpXYUSHmCZSBoD6m7XOHOhni+H0axeT0HB?=
 =?us-ascii?Q?sYtFA2M8zHLqKjkSsIAqODQwcxlHvgKL1QCyyWDcRXgSNOUpGhrwm+p6Jtzk?=
 =?us-ascii?Q?N/qmvUgonVZ/07HYzG7BxgirZutXmO2Y?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?y321iTeL03tbueLhoaDzjoz47q57DdbmC647rUNYoJDRpnlpNfSSzUDVQS0n?=
 =?us-ascii?Q?cjR4otHA5d2E6RBzh1hdixuYHfs0ObZ6Jaontxja2rF0nYvAOoeG8iX0uHed?=
 =?us-ascii?Q?2n3mMbYOPUQrXEBYtvGxRSr44kLZW6mkk3muYbUjxhD+AXZr7ywAO7bvgAbK?=
 =?us-ascii?Q?W2GrjpXVlPRGelk6JAGtM/AkcNrIUysO53W3HtLF272NqXf3TzTkzgODcjtq?=
 =?us-ascii?Q?9nM3puBuOjPgL0Zkt+DKn7VL55x0YRISFgA7/wY3L6cQHHMrSqv6ii7ImNtH?=
 =?us-ascii?Q?YOp3NZ1Pbv/gr1DhDDFCQ0CCsbg5pDAAgu/g8W1PzbDUzyROmbWB/+tH49dM?=
 =?us-ascii?Q?FueDKN5a8McpENt1CA8YJlgbwjYjktH3CoTiccQLbaDfvY2Mj5EGb86CwpTw?=
 =?us-ascii?Q?xffFVR8nOge4BNnurGnNtnPO5YvjsKFFAxTZd9L8MOYKdzUdBgmtNjY8WjFO?=
 =?us-ascii?Q?4Odq30vhIeNV9klbEhZZUdiBEJOcRi4VtMigqEX4ElEKUvgfVBg/w9ro0REY?=
 =?us-ascii?Q?H3AglrFLW441sw55LN5t6KHlRCQjcG7gRFHZLpbRB6Togpi+e6DoqPQ4VsDn?=
 =?us-ascii?Q?xWonLDLsItwM2/HGmsNdTAs+7fO+DgyAekTzxvTkkFgIf0IpkK4H6BYyVf/+?=
 =?us-ascii?Q?qQx7EOltBhZwJKlOR6a1SowFaT+lbta0yOotcq9F+dy9bP0g/kFHJeYxZKni?=
 =?us-ascii?Q?Pfd5bA439aCFOF9QE5CA9Tnga2M4xC34TqRup2Y/f7yqBSnJqklGHQMmBQua?=
 =?us-ascii?Q?D9Xm0ExSTW6CGv8/uMHKITF4uK0qIFWYwg8eqoh8ipOLPBlZ8a/hyytSp92Y?=
 =?us-ascii?Q?JJRymFAey2LNXJ97p+Mm4thCnXB+gfxmxY+VISKmUudhc1jcfS+nEZqM9/50?=
 =?us-ascii?Q?y/VE3QJhkFlY7xEVKViDhXxgZxljM6Pq8S1C4Mdj4jXOIlUiEvcXNBG7GlI6?=
 =?us-ascii?Q?eez9lxurW3oSfFpkteyQob8YhlUNo6Mq9L+daMywWHpTYpidkrffCbrs5mvg?=
 =?us-ascii?Q?Az+GRR3b9fMVABQtuuZHcKt4H2Ly5Esz28AIQWcytNv+I0CPhmFuRR0TV0Vl?=
 =?us-ascii?Q?gJWX2CSxeu1Ghx8yWtuG1eLhv8yVHDI4j56eZjuWt12EYXCxcibn2p8lHLBH?=
 =?us-ascii?Q?14+VCe7h5QRhnXzUGWRqjn7M0MFkN2RzWFKjuJCBuBPVzgFqJ5Y48S/Gw9LD?=
 =?us-ascii?Q?2eiqz9+3GZfdfWkNIVk9xGltFs+tLWlArv+IpFvciEXJkRCEws3Eid6HDQUs?=
 =?us-ascii?Q?PiHqGjaous/ix4qDqJJk8+fiGj8rdNckjPbBvGYrw6tkSXw0l+H0U3IBxQJB?=
 =?us-ascii?Q?xv4eoTyCU6Z6QLWcPNTOn0eJ1D0tS1CvZNlnqFkk1NfO0lzcmTqwHxUJ4AlM?=
 =?us-ascii?Q?NV4Xv95X94L3YbNHe9n8QrpZc4obD0kEwq1lRHbC8lFHZxrUVyLlX36Mucka?=
 =?us-ascii?Q?voQCF2/F2cU18guzliRSAPzFe6YdCyzfB8Ss96GYQj5cLp+b/gZ8pD17S3nM?=
 =?us-ascii?Q?sV4W64Yp7L71pMJP/U/ynlOBvsGeR2fNFx0tJVMfIQyYpYfEe+NSnQxVit6e?=
 =?us-ascii?Q?dEiq60iNS/8fZeYCOk3TfB1F2tqzSgaTbC/zClL1PSt5EFqBASpaTE0yUBS0?=
 =?us-ascii?Q?zTnhtXMiQtgjcAiVC8+OvuA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c41809-9a35-48f9-4309-08dd70417399
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:47:37.2252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRtIfnPY/A9W2fcpOcdA9nsCIMKssvU3sG+dLcAs4Sgogmfai75XyFcQW+7x4WZonXTtlD0C2FHDLx+Z0KtNAqdDMTgSDziV7vTvTjALf/vI4ouJKHSm0usfJGW8R/Va
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13299
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:47:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18430

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 987040d4601e98e32c53837ef76aad115c4966f7 upstream.

Add pincontrol node to RZ/G3E ("R9A09G047") SoC DTSI.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/20241216195325.164212-7-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g047.dtsi
index 39a7cfb3095b0..15711f9b6038c 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -131,6 +131,19 @@ soc: soc {
 		#size-cells =3D <2>;
 		ranges;
=20
+		pinctrl: pinctrl@10410000 {
+			compatible =3D "renesas,r9a09g047-pinctrl";
+			reg =3D <0 0x10410000 0 0x10000>;
+			clocks =3D <&cpg CPG_CORE R9A09G047_IOTOP_0_SHCLK>;
+			gpio-controller;
+			#gpio-cells =3D <2>;
+			gpio-ranges =3D <&pinctrl 0 0 232>;
+			#interrupt-cells =3D <2>;
+			interrupt-controller;
+			power-domains =3D <&cpg>;
+			resets =3D <&cpg 0xa5>, <&cpg 0xa6>;
+		};
+
 		cpg: clock-controller@10420000 {
 			compatible =3D "renesas,r9a09g047-cpg";
 			reg =3D <0 0x10420000 0 0x10000>;
--=20
2.43.0


