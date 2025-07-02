Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EACC83F04
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:38:03 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.44])
 by mx.groups.io with SMTP id smtpd.web11.20599.1751452681159212894
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:38:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=aQSYskZ1;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.44, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOslSNX/B9NED+JufMSKjLof1NgNSJwxXAkvdpmZhdaG5Ak3T6mfw7fNeMoI8hxc1hyL8HHsifKpsHdYfbPO1ykUE3r3WqVe+wCgaT33nZxSrZ+rKnuBTLIvBFNBc4v1sYAnNlhwku9BRoFvOXnd6Ds0U2xJCwHkDW50InKR2twx4qchHErjTsoHkE/QVC1mYUNtLBgQg7kYAMYIGwhu9oiK++Q204pKWcaSKSbEeEQz2tIg9NPIWnyQ7ulKGucBKpfalYEIqkRRXsw4h4k1Ba3GG5Pw34SXDiL1hLU5UuFtvxM7HYXdLV8qMidJdiDUfLifqKJgC/aup4wJiezMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HPL1EiJskDiwNv6KQpt3HfLX+Xb16B6Ao9b7Rr5NBc=;
 b=neh0kSNlRPCn+p2tqn8yiOkQTyd5G/AQx74sxNlR+bhqABgFjalWFR4VCAfiyFC0cinOPSBR+B/Uu6QxBqcCacC7Pc3kZxx3byfszWnL33eYpvkn/BJqLNDe6OIFTVNP6sO1p7Lpk8vZPAQpgIg9VEKtlRny+E1ivhKTXXrTNQScIGBqoYKGrDI7DpvFZKPNp06KidY1GoqhQda3msqPvbRNKpmeFq7LADRYJ2OMLNLP1HkIbCyqRNaCFs061HwPlyGIyrtXDYGgI1Eh+Xp1bMRVw1miHm7Y5Cz9sE0mbDDE8Uew0AgaJYTplqzkP+rrK08cx5LtTXTH7ZXmHC8jWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HPL1EiJskDiwNv6KQpt3HfLX+Xb16B6Ao9b7Rr5NBc=;
 b=aQSYskZ1jjlv+3lWkr+nP38D8ZqbG3oxL5aWOvR7c1AwaLzqKwavEgIeiDxkszreyoiwpPoU/GIS3zO2voX/EN3XhRWbJaZqXsDeJkDEUGqtycWD1KqZ2cJmqSMRyUoC5/pY21obLYELPMRhe2fa0K9+7Czj/ajobB1lhowZqkc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS3PR01MB10187.jpnprd01.prod.outlook.com (2603:1096:604:1e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 10:38:00 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 10:38:00 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 11/12] arm64: dts: renesas: r9a09g047: Add Mali-G52 GPU node
Date: Wed,  2 Jul 2025 12:37:09 +0200
Message-ID: <20250702103710.117760-12-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9540ed98-e841-4052-55f1-08ddb9548436
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?u1rCKA2MD7yGAK0bMiYbKSUbEz8lPEs9dIaKcFY0FDyVwrGTOKflFsaHbtsj?=
 =?us-ascii?Q?kuq/3CH/Cs81aoAHPf5KaYt0A27SYtpZs35XwzmzT08TMDdVc7bP+iDfsVL2?=
 =?us-ascii?Q?d7gWUVNTQeKNGbkyeMwagpoFy0o2TRChiIIP9JjOXGybZQyzc1eFgkOYctI7?=
 =?us-ascii?Q?cqA+ZYWhMD/vVC/NXjl+dnLHt8VTagIdBO2iXZ/xvTt+22BQ5rfOy3we2YUt?=
 =?us-ascii?Q?kmY3k9Y2ZBVJok4PAuSO3vqlBMCwZEFdJ2tpOAJ5RDJuyfuH5x+oaZCYoctD?=
 =?us-ascii?Q?MCxAbcvKZti30yKc3qJz7wSXmYvG8KCMdXdZkXHBs0RIP/P7fDP6rLBh2aku?=
 =?us-ascii?Q?6kcaNFjl9LTpdYN2Xs2lJCVi2TlMAMZm7nyFDz8uO0I5n4Td5ZMiDiqeTwml?=
 =?us-ascii?Q?mlnYDsqUsTgY+uN93SAgRgmjiifPPhMfGMrpb0sdgtsfcMGUPa84gf7DtzrQ?=
 =?us-ascii?Q?BiD5XyFXBGPWJo6t6x/WDe/4OJIW4xmFF4Gl7SyDhZyH0fkqUzdqpe+7vBsD?=
 =?us-ascii?Q?XSkj6QJWD1ViS6jN79VL1MNDPfKMrrEyxu4GUz47wnyRK6vPVRvSPI3RJom/?=
 =?us-ascii?Q?AVg6BpK0uuXv337BmZ0nlj2G7yFalH0+TZBNZG5nAqc/TlcxOCNpl8LQyYmY?=
 =?us-ascii?Q?CltB2W1TxrNeMY0Mh8l6JVyONzJGmW91n9KAyjuqNLV597a2HkPyVPqUPSm+?=
 =?us-ascii?Q?ys/0BhiSov+/LBFTqNigR54IU07UepMMlv9WdSk5hsqWXEX+AG4MTd9ZlMQP?=
 =?us-ascii?Q?MyUWI6W5fMqUweFVSIZ4jvzE1MG6w4nUo7stJSuJyYcxGBz4d233SgarH9Gd?=
 =?us-ascii?Q?2XBceGNEcFASIAB3WPY7Youy5gqGliMTopnWmpb4hlPZCMAqAvyD1scI+bpP?=
 =?us-ascii?Q?mRl2Z2TUU2JM8F0ZqFD0DZDUtqwuPtP2BX4gUv9jCtKWcFT7rHyiL27ENKEu?=
 =?us-ascii?Q?PVGzH6ORtmE2AxbeQFmM8hSySWBclU4iwWos5pISdD6K80vvXe6ZfhAyK5zy?=
 =?us-ascii?Q?12KQd/9/Gtr/Et5OrLMXt3LJGGpE4C7H8Hn08dXgO/kl2CWhiBDNfwZMHimm?=
 =?us-ascii?Q?iz9Tx43JaZqvrFYya3Ms6++aqh0mSCUxkfX51UGiBAoYZhtWcvxYvWV1T/A2?=
 =?us-ascii?Q?Vairr6kZeBqhchpDRWrOihWv7kR9aBx/c2m3YnhDAYKJGl8RTR3VlwPKLnxY?=
 =?us-ascii?Q?jUxg3PNCZJlHNSSGwd+s8RGPSmIssLE3E/tYZWbtUjAZkkhf2fdjNCKN6+ho?=
 =?us-ascii?Q?6SM8BsTZ9s62SbcsdMTqgYMZTdcBXoWzHkND6xa9jkOmhIsBMPGqCnUUAc74?=
 =?us-ascii?Q?Qxem7uoh1RSDJ1XQedajqsmKfd80nJfWoEugKxwbE+Gav6EzRVafVR+MPAKx?=
 =?us-ascii?Q?lrTylgy6Oxlo7jCLHxq39rbpAUuQkEhNUUfxJFX87CYCzBmdbqHoCsiSmuJN?=
 =?us-ascii?Q?DkM101cULh9pM3w5DVhddxo6F/osb/kcIiuSpFoI7cEK+MltTi7ajSJhgjz/?=
 =?us-ascii?Q?0EYyRyDztFOEaQw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sgSit4dxmAQ+S8vbWfFriKdufC1fgbT4+w0iceaCb+HbNopzmu+L0XtKFLWW?=
 =?us-ascii?Q?llTw+vxInAxXOH2Bk0ZCvZSS72CGtpLP/ayc5KSVF3j1xHrBntLmvUMujRrv?=
 =?us-ascii?Q?EUsRDdJJ7U10xfjfEHg84sh1ofauEZkDuBGahLG45Xfg6N9mTEr3gryyzWsk?=
 =?us-ascii?Q?TpgkGVOf3QOc1KgeWpqnbfxGQTXj1T1GoE/gp4z2e5oYsAC2vDd/rpgU8YOy?=
 =?us-ascii?Q?y/hWTfdpf4vE4kXAkg7BM5BW9qr6ws8tiXaa1OSJUA9c62WaoGrohaoptPz/?=
 =?us-ascii?Q?yA21PDVJPlrQh2nYuRMd3MNOH4rngxA5SUmUcCHNDZUHVbOEjRXniKEbSF+e?=
 =?us-ascii?Q?r+w98Klv6EnTcPESjNRmEemPOlHfBCXh1NLR1y5MAp+VvvM3jL3oMklE6B1C?=
 =?us-ascii?Q?gff+X070YNKjiKexm4C758O0uKuURyG3d8bKjB4T+8WgHl4LqjnxKlj7XYVW?=
 =?us-ascii?Q?g4CGquwSaq62+RE+KTychMrGaaPtjY+sfC02VO5vBHfCwVnKgCjhOmxOwXAe?=
 =?us-ascii?Q?EiBIwMVdU5apuUzD6VVKtAbRlt30nglMdZO2vAAETdNxrTf0ybvsffdnsaZX?=
 =?us-ascii?Q?TO+wUCaLxwoMCJOjc7mqp/whr64EYzLOHHC90QtLYtbQiAlfskIhoodUo57G?=
 =?us-ascii?Q?vUi99A5+wFySIAnoEXqOfo72vTn9Cz+F6N4KfN0jrHgukoYtXrSuGlGRiAcN?=
 =?us-ascii?Q?BS5Tao+9t/472OPtW20J2D2/IeqCGs0eE9SjpAZhTLQBNEH6QrHktLfsBwqi?=
 =?us-ascii?Q?8q1Cfqcce7/h0PXO0CCQ1TR1dJ/18FgXmsD8pP6C9On1XMKSFfNNf1vIOxzp?=
 =?us-ascii?Q?ebfU86u2UG98cb236wi4afb1xlK6imlXOo1s4w9lslWhP60MNg69FnoNk4VN?=
 =?us-ascii?Q?kGTwjjRloCsXnPijIhFbkQ/EIdBeX3xHOrDTe7WQpqV7uGneTgQV0M9+K1u1?=
 =?us-ascii?Q?huTD2GH6tyj0gOLRBXcd/qxKIHvRkNKeusw2e5osvL2p9sUTIHsskIf08k6d?=
 =?us-ascii?Q?rIKN0QlCIxKg8nsCyAsLNr/AMsyvH0B61fMhcJDwC50hWtp2EykWOVJJ9WPT?=
 =?us-ascii?Q?m9Z+fKKsjdn+wkRgbiUy3gxsCBbV229Euw4wd4FrwRJH12mjoxYDzCsdLmLB?=
 =?us-ascii?Q?uWwFwm4rt2ps66CUhzoLiVk/6q7wExNiDjp2/5U4MFxTCM2+ohKJ/HIz5TZ3?=
 =?us-ascii?Q?zjMi5HoV4xdsI4KcX33XrgvqvPo771HUc7Zq1xsJCYMX2DYLqOn/8cU6NbQi?=
 =?us-ascii?Q?yCagsTwn1kovAbfzvbthJxr7geXhWmD4WW/jIKQjvRs968hOJp0V0/jUWJtv?=
 =?us-ascii?Q?PgapSHBZfHhqH81c4o9GI7HAlalC960cQVlG9XtVwLIVTG03Fyywi57EEae5?=
 =?us-ascii?Q?xURkuu94Z7vTx8aTEqvtPMJZJwdDTD8VNn6Dt+XX+QeCPfwGgTWO3M6J5sOf?=
 =?us-ascii?Q?9CdawqOXQsvEXMboNuZBCNmCfMpOohHQU4ql4gzxrswt7E+HKjBqn/vNfAMs?=
 =?us-ascii?Q?PpEcXf1cfOm+axzFrLyfmRcAqmOhumb2LhTwQZjTuSJOL4M8DOyoFwidZ1Hc?=
 =?us-ascii?Q?s3NzYA7L5QO4fRj0ya3p86Zvqhsl30DU9bF79W8zHl8po+m8vFiMEg6epSfP?=
 =?us-ascii?Q?ZSPKvc958zBbl+IIDHtkRK8=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9540ed98-e841-4052-55f1-08ddb9548436
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:38:00.6075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvlUjzwEwnqs9baWdMQevcXW/M6MUeIZIeAbk2PeCjJsQICLLcNJiz10KfUwG3usV1LjicbAm70FPHzUE/iScXRR8g7eKG4ISMEypzbrpBII86YokD3eC9/+gXy9tyvf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10187
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:38:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19309

commit af06adb5106ad1e4ca8030bd9e15a9d8bc4baad8 upstream.

Add the Mali-G52 GPU node to the SoC DTSI.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250402131142.1270701-4-tommaso.merciai.xr@b=
p.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g047.dtsi
index 928757b52b4a..b742e57f40b4 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -105,6 +105,35 @@ L3_CA55: cache-controller-0 {
 		};
 	};
=20
+	gpu_opp_table: opp-table-1 {
+		compatible =3D "operating-points-v2";
+
+		opp-630000000 {
+			opp-hz =3D /bits/ 64 <630000000>;
+			opp-microvolt =3D <800000>;
+		};
+
+		opp-315000000 {
+			opp-hz =3D /bits/ 64 <315000000>;
+			opp-microvolt =3D <800000>;
+		};
+
+		opp-157500000 {
+			opp-hz =3D /bits/ 64 <157500000>;
+			opp-microvolt =3D <800000>;
+		};
+
+		opp-78750000 {
+			opp-hz =3D /bits/ 64 <78750000>;
+			opp-microvolt =3D <800000>;
+		};
+
+		opp-19687500 {
+			opp-hz =3D /bits/ 64 <19687500>;
+			opp-microvolt =3D <800000>;
+		};
+	};
+
 	psci {
 		compatible =3D "arm,psci-1.0", "arm,psci-0.2";
 		method =3D "smc";
@@ -394,6 +423,26 @@ i2c8: i2c@11c01000 {
 			status =3D "disabled";
 		};
=20
+		gpu: gpu@14850000 {
+			compatible =3D "renesas,r9a09g047-mali",
+				     "arm,mali-bifrost";
+			reg =3D <0x0 0x14850000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 884 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 885 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 883 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 886 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "job", "mmu", "gpu", "event";
+			clocks =3D <&cpg CPG_MOD 0xf0>,
+				 <&cpg CPG_MOD 0xf1>,
+				 <&cpg CPG_MOD 0xf2>;
+			clock-names =3D "gpu", "bus", "bus_ace";
+			power-domains =3D <&cpg>;
+			resets =3D <&cpg 0xdd>, <&cpg 0xde>, <&cpg 0xdf>;
+			reset-names =3D "rst", "axi_rst", "ace_rst";
+			operating-points-v2 =3D <&gpu_opp_table>;
+			status =3D "disabled";
+		};
+
 		gic: interrupt-controller@14900000 {
 			compatible =3D "arm,gic-v3";
 			reg =3D <0x0 0x14900000 0 0x20000>,
--=20
2.43.0


