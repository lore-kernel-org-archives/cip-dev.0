Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED152CA0EED
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:06:43 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.59])
 by mx.groups.io with SMTP id smtpd.web10.995.1755705994583577248
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:06:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=lP/41qap;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.59, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1MtqJE5BUtq6yWNhRT8LRYGH/F0ECQoiMoCUaVaBbUXpyuQG2KV8wuzg1ZiDKHeWdRihAvXHLQj39rBOWU9GjPHasZSVCVQEP+A6+0web8U4KQMy/2GP3RNyH5CZWuTG3m5N40BfhdGYqBIOtHjVL41Q22qp5mKlFjdrzyupWBq+N9Q9RaXDgKXZxyx1YRDJpmo5eKaOpVkTx/F8E2WvocbDP4Tg2hO87ujMSpHz7rpbAwejew4D2md7sk7yLzqbzlqVEY+U84x0SQ74OsDcj/9O0rdONdb0eYolyVv8i2A1CkvVeFyoFpX22T6+bK8so5bC86sC0Yic1ylNzVe5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BxnUfvUoPphB7/Fx9N1/94B2LT4MOflLuT3cokEcK4=;
 b=qeJdCUIqEkyQwrvQCosFw8Y/G044CD7l+ZQ73z7nYFro9ke/xT21w6Ub0bcbNkPAgLLrxfNe2INRdAkFpPFin0dsD4lP6713dlABhDpBekd8OM47FEQDN+Wa+7C+0fXT4o3JqnSNNjqH1P9Y8CBSNDttfejCRy1La+ZlBX01M64GeAxdCw784qdDuM351PJACco/7zee2Kxp6tDdLxL0FauzdLGj5+53epAyl6ydEx8ZrjltAbwSNHQrcbnE8nv243lBsdHY2COY81Yp4Vf5LEapd/abcHXy1J/s+b0qs/OxrQpQAZQ6I+w6fWZtD78JYZdNLcW+88O/XM41R9Plrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BxnUfvUoPphB7/Fx9N1/94B2LT4MOflLuT3cokEcK4=;
 b=lP/41qapFQEW6B4M7SneUQu+sfJ7sXmgZfSHtDv/ECFV/xmM8V9FIeF1L3HAtFMrNfXXX0wnFRv5L8qQMmukRO2JcMUudQDlNtAD+sOI3uZjNcjpABnLS4S+FAh+40TPjCj6AQFX0CwArdTvSEZxBWsb0vPqMR3Z6LOv6icnekU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB12116.jpnprd01.prod.outlook.com (2603:1096:400:3da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 16:06:32 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:06:32 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 45/55] arm64: dts: renesas: r9a09g047: Add CRU, CSI2 nodes
Date: Wed, 20 Aug 2025 18:04:01 +0200
Message-ID: <20250820160413.801341-46-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB12116:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc5059e-930f-4d51-8d83-08dde00387dc
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2eAAP7RqJ+iXvU4/UgB5627f3H9sDVuMdCUHOpS68AxRCac1glGJ2axs9CX1?=
 =?us-ascii?Q?kDMkjTx+ee9hHhKGid7j9arpC2geSFnn1aSpl8e+1grhyWRZjW+hU6Z4sGbm?=
 =?us-ascii?Q?+EhN3rUatNUKWB400R0XgY5mhrsRSrqDFasj/UOA8kVM3UgpeFdM+htfYbuv?=
 =?us-ascii?Q?eVfSpOULKwycG/Duhsqdm1J4ugfghxUR9uTzh92d9VYuuh4oAYU5678+dVst?=
 =?us-ascii?Q?pYs1nEWm7JG446roEMBj79Z/a+xBUAL4SAe7i6KemQTVg1/kXhwqXAagrW7r?=
 =?us-ascii?Q?qyOfH40IV3pnUvh/pLBhbmJyqSN/ez/Jd0PHcnI3NsI58tmbmEWiZ51McX4a?=
 =?us-ascii?Q?0UeQSEfWSqpNm8CbQpv4thAykuPkZ62/21EgfLW140lwroTL4Dv+itQkDMf3?=
 =?us-ascii?Q?MEMWfszDKAVlVDap4Lq5EtK6s5lq5bfGweORsBPZ4LUJoiRFucqtU0pLk8d9?=
 =?us-ascii?Q?V2xo0ATFnejYKlz3sM+TBl4ULutS1ZmR70U9+cgVDh6qlaXWW+Jlgci2K3gk?=
 =?us-ascii?Q?Hq8SAjdds3220iP45Ws7p3LgPhtC2fZ9jbTmg95sVjN7dhkEsWDjofLd+OxU?=
 =?us-ascii?Q?mOX3Z1N8vkvqWv0RhPjp1Ui8DdV0j/JqEV3tDtt5Z1Biw83aORXoW/qYoavx?=
 =?us-ascii?Q?dQgRoIBfCa7UAkMXVz4BaqdOU+QvH1jcC9k/q3i7ZjKUZ7WHDu0VgLe8JErx?=
 =?us-ascii?Q?BXC7/+QGxmClwgQlLRlvUW4x3K67Zx3nb+/YVLxFAHSQznRu0Zk+KqHtt5Bg?=
 =?us-ascii?Q?2lL4eBSm5qqYiePns2piZcB1EVGYHLvwJXgIVMtjRae+0ECeXQ9hhTmtEtCc?=
 =?us-ascii?Q?+45jYpe2YTOt5+yLBtzQeA7f3LiI3cyejlclzXJXvpV0LLnepXqzddH1pERO?=
 =?us-ascii?Q?o6URCQ1+303maIPvxbGmSjG6yW6EuJNrZVkJPHheskRzetTtnBnExg1pIQoS?=
 =?us-ascii?Q?iQV9wD1QXXzlUfRZaHiIc2k2MkadhPOHK/h+Oxcknhm1x6gcQeOxrrS9gGGT?=
 =?us-ascii?Q?KevZICAvDRLKLlRNNav2vQwO9k2dRmM9psuB/ZoeE//mkID54Z+LV2ICI+zP?=
 =?us-ascii?Q?8NuFY93qp5HfBo0BQOsnGIIIsPBFuNLpnmY/PJhedduttNmCrqjkglVIT4YK?=
 =?us-ascii?Q?2eGmeXAT7bu+u2vCix9zC8VUAx+06MKvAthXfcGwkk+TN9Rim9LKD0hQpEA1?=
 =?us-ascii?Q?TDM5RE2eYXCOk7+0ky7P8C0JDZlRcR2hl4X9yPKJzUd8XphxYlyA8BSz9P4r?=
 =?us-ascii?Q?NDB7+qFra+uE4JgRJK2sTdQe3FHiSaV8qZjUN+2vOOwutqWDdHdZN94wvasN?=
 =?us-ascii?Q?w2Tt+MUDbb9tYbXizD7+1yRy37JKHfAPbtcAu4YXtuwpBM6vOaz4IAfAyniA?=
 =?us-ascii?Q?s7gZ9jXobhXPzg2zXucyVyZ8M+a+rU3s6JNzYSImDteFm1heWHaGvheF7ca1?=
 =?us-ascii?Q?RwYDthcpuWb/aDDkqgzK3LE8Ivr0/QKTGnqVoe4UGWQmVeMS9W0/KQNr0Im4?=
 =?us-ascii?Q?oGqSOjVQl+GNbtc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lVk6BBwCXKAL+Yttcn5F2DNZMn6WODNDznHLLbaYj9rpiA3+w71b0RSIRUBI?=
 =?us-ascii?Q?8+7L4o7J2vq0LWCZigFM1erIjKaPqhzoERsSyupOotydT4AV2pTvEqf6ARKm?=
 =?us-ascii?Q?REILAh+7cW88pLO/aVkhJ8jNNIP205h9375aGw7DBC1RPB2NZspt+y1FVxJf?=
 =?us-ascii?Q?nbcPjIEouqrgTWeAid8bGZzwODsEyulYEUjUTyODcQa2fKSILtBbZFf/Ogn/?=
 =?us-ascii?Q?pS94nw1y1n+pKedG2qCCDXDpFBcsFEap+OoHN5DdvcFKYgWpBzkKhhBP3DW5?=
 =?us-ascii?Q?ATsbqduuPXwPJcaij9Z88T2knOnZpb0YRYliJ7iemht2lieExUpU91hsvgik?=
 =?us-ascii?Q?Wl5SSgyG10M41fToAEcO72ZI3tt1f6jbbLIiYx5v3O5sHbsKZJmc8AsLRFRr?=
 =?us-ascii?Q?hywQDkM+7OXF74ZCNceVpsKtYhYLFZ/kOgIDthachxSoWGmZNNNb4+xpJAiM?=
 =?us-ascii?Q?8sQMTm0mPWxsyeR06yD8AI973gDRLzScnccKGHtSDOGix88Qq2ptdXWNaYxq?=
 =?us-ascii?Q?ZEHkBzVOQyP9h9sXBzLbNuiWkrP7mT+h9kLQVWSYJ+pFiDubYHnejmTfMBNK?=
 =?us-ascii?Q?JAX+sybBIPmmd2RNmnbR+Pqp7IfrWiXniikVqhyOm7sKpjOYpo54OD9lottD?=
 =?us-ascii?Q?Uy2d55YBY0J3Afm6d1ExaJa7DvY95cWMffqWnt7/i8XrR6QYC3AESIBq5Q4n?=
 =?us-ascii?Q?wVOM4bD8mQv0gNJP00/HxizNjyxRgZkUtQv32Haol61sC9wGCrS6oD8zFXy0?=
 =?us-ascii?Q?6ivlEJsV9wKK0tXDjCeM0xUhNoiGPn+n6+iA1Yue10p6olXekt9YG53AA3gc?=
 =?us-ascii?Q?gQQ2RvxZxuC10Z1XLIvEbol3Riy43rmQxT34TtKUH2/vI+6/Y4kXXIDTu/wJ?=
 =?us-ascii?Q?2PBGzWRVYKJHpug3GP/ywIoJybWxdTQ9aN6ZvbRPTdU4JZ7J5HpZtvfdC2/L?=
 =?us-ascii?Q?bHDL5XMJrec4Bz05xPnOITtGKgpOUCvj+miHI9hfwyn0wnHJVyVQNdmn8hDv?=
 =?us-ascii?Q?g8m+5vVyJosB3ZZcr3yu8aqcdKXKb6UczmlHSIqjLN/IsL9JD2GtFEZemEBF?=
 =?us-ascii?Q?ImQlgKhdBfWbofnNKf19iRnlYOAoIuMrkVVIFF8VudnJOvHaNGXgKDYRTFw0?=
 =?us-ascii?Q?49k2JcOrNYbIMq77V6VE+UXSa4DckjAsumQTVdlQ1wqNS1yRLdT4cvQzUoTY?=
 =?us-ascii?Q?OCtbyEVLFB0vDgI6VSrb3iLt6OZE60V1Z08ueIbh3t1Ib0c0DLf73v64+qqN?=
 =?us-ascii?Q?P2gSb4PrBLbP2UgAZLuhqsVKlZvO2N0FzWKNODUREht3nZ6LqcvXQ08VhQYu?=
 =?us-ascii?Q?w1yFmtg62F3pcpUzqEPVEmfvSDiRfuoLNCp7/u17zRTvpHOa6cHnLBeaaUyk?=
 =?us-ascii?Q?ZSpaESKNeNs5I8a4O2jWUX820nbzNrpn+l6dQm5vcTnSjt8+Cu6sSN+tyodO?=
 =?us-ascii?Q?15IFWGQPRCV0iLCtr9p3FsflZq7c84TO7yZll8qPED28IUlmZG+F2j5eVYoI?=
 =?us-ascii?Q?Tdz5tdB+rAE1W1vOioQw6g7h/W2b+w+++MevOLLywye4B+UPkwim+T+eQR6r?=
 =?us-ascii?Q?t/myQIeX6DN9m3OJfJ/uWrH/bmfpwC7274f8r1/ScDJGGwL5cEgpUl5YT91Q?=
 =?us-ascii?Q?ZAV8xxKbAgD3GOByzVtmK0c=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc5059e-930f-4d51-8d83-08dde00387dc
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:06:32.8247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znY5c319lwiaDPq3S5hedxX3xcz+Xl6vmtBP710fyhqjcWfmJWCpPpnpIrVY9KshTiNzxIiQZM0317uJRTUARZv+m+oXsaTF+/Nz7YQFcc1PLV908GmUUXgoMNotxA2m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:06:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19870

commit c3303e7162184551d82b88311922b7026dfdfdde upstream.

Add CRU, CSI2 nodes to RZ/RZG3E SoC DTSI.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250514162422.910114-2-tommaso.merciai.xr@bp=
.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g047.dtsi
index 3d3aa371dad8..a0d4fab4fe05 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -690,6 +690,75 @@ sdhi2_vqmmc: vqmmc-regulator {
 				status =3D "disabled";
 			};
 		};
+
+		cru: video@16000000 {
+			compatible =3D "renesas,r9a09g047-cru";
+			reg =3D <0 0x16000000 0 0x400>;
+			clocks =3D <&cpg CPG_MOD 0xd3>,
+				 <&cpg CPG_MOD 0xd4>,
+				 <&cpg CPG_MOD 0xd2>;
+			clock-names =3D "video", "apb", "axi";
+			interrupts =3D <GIC_SPI 838 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 839 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 840 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 841 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 842 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "image_conv", "axi_mst_err",
+					  "vd_addr_wend", "sd_addr_wend",
+					  "vsd_addr_wend";
+			resets =3D <&cpg 0xc5>, <&cpg 0xc6>;
+			reset-names =3D "presetn", "aresetn";
+			power-domains =3D <&cpg>;
+			status =3D "disabled";
+
+			ports {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				port@1 {
+					#address-cells =3D <1>;
+					#size-cells =3D <0>;
+
+					reg =3D <1>;
+					crucsi2: endpoint@0 {
+						reg =3D <0>;
+						remote-endpoint =3D <&csi2cru>;
+					};
+				};
+			};
+		};
+
+		csi2: csi2@16000400 {
+			compatible =3D "renesas,r9a09g047-csi2", "renesas,r9a09g057-csi2";
+			reg =3D <0 0x16000400 0 0xc00>;
+			interrupts =3D <GIC_SPI 837 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&cpg CPG_MOD 0xd3>, <&cpg CPG_MOD 0xd4>;
+			clock-names =3D "video", "apb";
+			resets =3D <&cpg 0xc5>, <&cpg 0xc7>;
+			reset-names =3D "presetn", "cmn-rstb";
+			power-domains =3D <&cpg>;
+			status =3D "disabled";
+
+			ports {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				port@0 {
+					reg =3D <0>;
+				};
+
+				port@1 {
+					#address-cells =3D <1>;
+					#size-cells =3D <0>;
+					reg =3D <1>;
+
+					csi2cru: endpoint@0 {
+						reg =3D <0>;
+						remote-endpoint =3D <&crucsi2>;
+					};
+				};
+			};
+		};
 	};
=20
 	timer {
--=20
2.43.0


