Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37E9C3600C
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 11:08:01 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.47])
 by mx.groups.io with SMTP id smtpd.web10.49423.1743419276963118111
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 04:07:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=NYd9tt/O;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.47, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYhs0rkYZRmwqBfFNLZ5aKdf3ytWcth2YE0bR9GKQ5+kxttAf00oO+xlNlFe4aBQ+kmKkDMEsVL6nnn93zS93zxstIzrCQSfBooEU4ZTYKJF+d8sm/05fkWwkTTvuW7RZeWX8U/ht6kJR7yyn/o4r2Ul/e8mVyTLE82QcEw04G13F6c82iZMbD0H0nVl3WSaGy6hv/2w3CnWzBBOzfIelGyhJlqowBMzitz5HxoL6oNT6xTCdAVUEnEmJyizvBTIcNLLUdWlmCk2ibBATqpoC1fUk3CL3RXx4ZYsYYhPByc9lml/VA+R36z2BywCfbDqeicsyqzsSIQgq6t+l2kKSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Yq9Jz04NjuZNbgb4MZkft1h7sVkRAZ/Ed1ufs3vzjU=;
 b=PFiklBfHDhIh8JMUADPU1OIpdbYByGfJMAhkxn2nkZiJtyc6MOCHaW2c2zC8dCfBDq/58wMy0FEsCLlRjDhOO1KH2E1SBGOrA5v5Sxu9dAUKVZ27oXzPjVhUq1FSB8Vs3+q9LKxoyUbTz4mOIqbCvVR0yGa02QR1WMD6gJFhQ8gjzGnwSp9GMiFtr56bqovVp8JmMEeTR213h1egxhnn/0Oc09TpH1t9vxRsG3hHQqVZc3+vZSkp+dpFBqMUZNms1Hmlq9HcvDyZ8nKtvjNxoW9pXnpMP09v90z2Cfnu0fPLwgWBpf7lnpg8eVc8t+VkNK7KZCu1Eh+H9d2XIW3hew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Yq9Jz04NjuZNbgb4MZkft1h7sVkRAZ/Ed1ufs3vzjU=;
 b=NYd9tt/OE4xJs4hpGVA0xqwE0b4ayd0JUvP5kU2OM7klUkHosoHcjyXDdVxI4b217Et5QvLhnLELCRZGSAI+RXL+k6BigjTYEYcOWxl0TtARSxlUtpb7BgAYfMTcz/qUq0I/Zl5vWl3l388UiWZl1iPjNsaPFk0Am23RNyoImGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS7PR01MB15065.jpnprd01.prod.outlook.com (2603:1096:604:370::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Mon, 31 Mar
 2025 11:07:54 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 11:07:54 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 12/13] arm64: dts: renesas: r9a09g047: Add pincontrol node
Date: Mon, 31 Mar 2025 13:06:58 +0200
Message-ID: <20250331110659.252237-13-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::20) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS7PR01MB15065:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d3d8c2-261f-44d7-17f1-08dd70444927
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZvSNFM6tzZEgajWyyL9LoLVhP6VFyEfY8Qc4wgBb5Xzep7Gl6o3QDn0c/Kob?=
 =?us-ascii?Q?LezZRrd0Ih014ttljuj0+T7ZpM4/ci+Wixhltc45gvSdlUsB2H7JY3FMc6gF?=
 =?us-ascii?Q?wrLYgOlolDL0/tOwpBh+kX+FHNE2qdzJRv21Ybu5TlZwcfL4/VZvx4MSbWEJ?=
 =?us-ascii?Q?XLFRB1Ym+D9ihz6WIjD4m8Bh653orGlRQ3/i4AW51h/M5bCA1+ADMA4h7/AB?=
 =?us-ascii?Q?541yH8YauC45FhpoFzaM4mLpIqvhIqrnfQkBh3UM0YskUXrMWQlO7+Tc7yb0?=
 =?us-ascii?Q?35c0obtd5UZ1XwTrU7SKazLEA46mSYK4boVE+umnZyQWLOt8ZgXNTRkxNrIh?=
 =?us-ascii?Q?DhOpV76M6EHCW2b4PkCDojZ7BYygK+JA2F4YapQGDFapvXBVPu+Q3XTAhl6A?=
 =?us-ascii?Q?c+t1liQL82Am54TxeG6YUieEnhB6iYWlMtZBLjvzprFsEvTiwkq20A06Gj/J?=
 =?us-ascii?Q?Lz7HVBJlU+o4dZ4nqB0m76XD5+VdxlZqsqBwCh4tkLUvbAnC6gRWfAGx7tzE?=
 =?us-ascii?Q?qrmSI7nUsLyWB8SjiLRAOKC/gYVPzYUMizTY3AzKBPEZYSs3OOiMUsSJgGUX?=
 =?us-ascii?Q?fEmEVhmkncPgyTS8m8SHmaIepwLTlDR/EhIE2YZxYprLGvTYk4D+Vwgg0u8e?=
 =?us-ascii?Q?dOGnO0OdLl4BZ6nqlGgIsAnbSnkWS6e8tduAyGM30lFAb++b3EXEnInGxSv7?=
 =?us-ascii?Q?QKV6/+pa8Rdz3ot4jgaHgYKL6tRLLuZ9VaX0uxbujGODs1UKs/MrO50DUGdB?=
 =?us-ascii?Q?8cIxhpO1BIStA9+AHi9p98YpPwbcdjPgQ3zU4O/HtqKvU+3wl3nrZWj6PB69?=
 =?us-ascii?Q?Cw04umtS6mlKX4jovpgtswMMlUq0XTzwotG1CjySHNdnydKr8BWBuIn/Gxd4?=
 =?us-ascii?Q?SE52n5FnQ6/NR42qR4IOJTFmrBHW67fVQtjoklHBL733u0wS70HtaAQCVOO0?=
 =?us-ascii?Q?80jwb2/ZOaluRwUt638fHlmPBDuBrHumXyVcxvhDmQ6AQvYDakpTlc58iVgC?=
 =?us-ascii?Q?EiSFaCezW63mLJ/udMnoXu/WJYe1JW+zXa+0FaKWfrLj5efQyb3G3ItGAQBL?=
 =?us-ascii?Q?w3127iY2g/zLUrAnBp/DSjIs+eHEQpZbY7MJsBQOYE0r4RwouiYZ18f1bRVs?=
 =?us-ascii?Q?o4gujFfEjAwxryncPfdbLVveQrz+d37IarsqTnWcTzgYBK/3w4xU5SAVeTk6?=
 =?us-ascii?Q?M5vGGjsEhzQwXkErcw8cHzl5+HPiuNsYYb8/n26qkrNCjRTK7BiPeYmABz+S?=
 =?us-ascii?Q?QSOA5u+6AdFYOtvEMjqVsMbzzuLg0bRVvaRJVAZgilZWizW5reLGWtKlzcFZ?=
 =?us-ascii?Q?9+EAF9yA01CLgDvRjxyTZ8e0uZamL3kGM+ob0hVMnBvLgzFLkz1jxIjLTh2m?=
 =?us-ascii?Q?f/VJVbAlIrM8BB9l6yEiaqti2RnzF/n6NU6Ih5+/5iNTbLj4IxMkusPBeDqv?=
 =?us-ascii?Q?hwfN+MZY1HlWciN8++ycYUmTvrao2+nA?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?e7QlsEATFcFxzQBGIuxd8xTGiDjRb4HPXrpLdD3tDo+WObrKa+FyTvrAscBR?=
 =?us-ascii?Q?IXTyfT6McoRHE0ZtlDIUY20DLFJIy+/LtSgnpFxavQVqM7mDfGByL+aRbwT/?=
 =?us-ascii?Q?B3xgCHu92f8lsiYOTlO4DXz7y1ybJrgLwIa89eytWJIN/NoreA8xJ2gdqWZ7?=
 =?us-ascii?Q?ksLmc5SErmP0Lc1RHWlUTz/dIkdzp99fyUFphBZBlveJ3WRhNWwkrblwm0gI?=
 =?us-ascii?Q?KlaiPL2oTHJQXeM76MleQJ/8QDmDzTL4KPb4U/spFBiswynT3v5Pj1vb8rFu?=
 =?us-ascii?Q?Ge85yt/mB/QhouxJbKhu/HEgqmxt7kHPkgUgYYKi+muzU94PPmwm6Q9PDSF5?=
 =?us-ascii?Q?BrG7ZKbICdda7LH9RRoMs3ReX0enqkv3Kzrx6Ujes3Evm1t1PbbpRqNV7zc5?=
 =?us-ascii?Q?Tpar3fzawxQB1sUrfpCSIWpOxsLLkPo5m/ph8Wb6lssvnlXixw78L6RbDoNi?=
 =?us-ascii?Q?ss1L7DgHU80N4taiqasYQXISWSapFMukf+JSKTlwstXgGOQwE/2fJ6azQDW+?=
 =?us-ascii?Q?n/5olC926gdHdRUlCsI2ymJ+JTmWTqbHvrKpACmiTblVCb3ypZ2euevK38Cn?=
 =?us-ascii?Q?w45yT4Q8rJgJTWOPmJqLMWfCEbudd4DgUggePJcIo1zQH27OZOLILsIAYxyd?=
 =?us-ascii?Q?218QLECmc4U0wCpL0taqs4g+zA7IeA7oXwp1E5P/LzkB6D8F+aD5XSKRonDx?=
 =?us-ascii?Q?wsR8MN/sQz868CAmE+2lAHC4UQ3c7U6rG8muzOJy6nU2Pd0ec9J/ljBeqPvU?=
 =?us-ascii?Q?YoorvrL6AQ2DJountoOCsgLUNW4hEPvOGAW6gZIjI+72lEVjFkwdlEa61CGd?=
 =?us-ascii?Q?8kzOA5SNx5696xjtL4eN+tYjfhbuV80/EUaIaD4aA7XgasM0mR7uZw6DkUwx?=
 =?us-ascii?Q?2nay6tGN4yqp0pqjwKnwekeLK+koFUgVDHP1mY8w2hg56vMpMvVCqCKyWd9Z?=
 =?us-ascii?Q?3BKrLI3dJYi2AHj4WmbMalBVB9uaP/F5hJcliyGQ5AlhlGp+g3EiRPe/D1+F?=
 =?us-ascii?Q?agj9sEwGxnu/Z0+c97KJa4ukSb0CNYUPHRw4dSIFj8lQFpLnXW+GM0NjP6Ie?=
 =?us-ascii?Q?8LhQPXVmyf/hPiNd+wP6RdHCrrpytqtJauiyJjAyOdalhXwKTNVGXGGJtCZ8?=
 =?us-ascii?Q?EHPBd2e/7Sa2Lw3BvIuS2gw5P1JQQdardF+zgvVUazJv5qfpf+vosXRoLpJY?=
 =?us-ascii?Q?QV03DrlylgRRzO+3cBFXGhZHQIZ9EGqH3Dvs42tVMGA86TqLUdW0KUmehAEp?=
 =?us-ascii?Q?fVGlNDGB6XmAi58+4JPnUv+YOMI0oltPsvD4Yv4vZyzj8Btg0rpEWGotYbwW?=
 =?us-ascii?Q?RAYyPkwTocy/HGkXND66i26ST2fikr3dL5s1SkWkRrotrJPukBC+fx/Bd+w+?=
 =?us-ascii?Q?srQ0SGh5+31yG3DCbAg6SMYFKKV/NBZ4XzqkG9WJRGoZRRwYr7rWr+lpMBQb?=
 =?us-ascii?Q?vD9zwxZjVmH55IbTPW/RhuRlnaTN3/QnYK5uv4YAU1zjVhUp9WiHFR5c+Hv6?=
 =?us-ascii?Q?okh4sDEI6xXQDpEY0RT2xT6nhSafDDiG887FlNF6RO7+s7R8QKAk9tZYgrMi?=
 =?us-ascii?Q?+Iw2QdXR64q8v2iqjjHcJuULFv1w14bCWkoTS4w47UHFXa5xs6ZHaqaq1O1R?=
 =?us-ascii?Q?Q+Tu7WhEdiMoWLgmOKt4Hlw=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d3d8c2-261f-44d7-17f1-08dd70444927
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 11:07:54.4578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GirkLOW3oQq+KecDbsAnmgFmNXRU0PXGSi8Odkm2Z4zMazKV1LWzBR1kqX2lZpcrr3LChxZOxIzldGkDoQTETkxrAbxEW+mBcaFKM5amFGr534yMMQWby9kKTFr3lcI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15065
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 11:08:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18444

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


