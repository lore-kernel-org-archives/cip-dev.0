Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A29C36000
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 11:01:39 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.31])
 by mx.groups.io with SMTP id smtpd.web11.18713.1742554892532213576
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 04:01:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ibklFU8B;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.31, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BdbD5peclVLJ0DeWkA/yc23m392C2jlVNeke1T9b/WBPD7BQ3f/xY7NCS7upgj0mcyhsHf0Ese5uq05j7o2nWpCQdxi3/+a/I6XblEGkQCaGl5XA9xI/+DnGMuWo3492FmbPWa8jz32pDRW9UYK8r0xXqtziRGyZfXVKDnEQnLrRos4TuYzi8jvdXlhjOnXcgJs7n1YDLxWQq0WnERfxT/9qoyt+Pm+5ubfUNL+JmZlLgPGbOD3baZcBk1bpyvZWD6KsVR97saWOhYYgvrtJK6dg4ss3Bo8Bi1CCYB33FLComOLURG5TXFnHnmkhX2J7mt8tgRaXt6SGPCdqbYzOAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBOwOG9p8YvZcrsfKNQiRyOl3cRqymGPE1IF/kOnwgw=;
 b=Uka5KOD1xgy8VnX6CbqPk5kmuB1U0yiGQpZTKX3FmIiYEPS/bTaKi/3MFKhuFJeJsvHOSCYcw2Gq9+hFYqTy1iQVEjphpdk3wHOqDzGdlaT3a8SSxXeDxoLDPM5zDkQrqkbYy8Qf5yQjkbpFWLNcoxBKaWXhItDNeCauQjvh+iqFF6CysgKvfBnCNyJ2DwW2ysSOAeSKYEGtuN7BsEermx9ERloqQtjgdJn5jJaQjvprNkJc49OcKtjLG6D+j6idq0FgPnhK/hzn0BJV9NsWShArzuSyUcCsAhOHe+LkA2AfW15FX32tVkAY5qQFG1MiMMeH+w2RCX8DpinmtKy8hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBOwOG9p8YvZcrsfKNQiRyOl3cRqymGPE1IF/kOnwgw=;
 b=ibklFU8BTTidEYAaoYTQeq/o3dCHx68nMDI+4EGpfMYq97nQoSSPKkJSG8dJTShXodMhnqBLdfim8JGv4q0tfYkJq3vlJnRPT9IHISLXdh9gb6gpSeZKbr1NLEW4FeS5FyOt4jGhY7tlo+z6emIqyRnW6YZdLJXqQsuKGKVYK6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS3PR01MB8652.jpnprd01.prod.outlook.com (2603:1096:604:19a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 11:01:30 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 11:01:30 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 17/21] arm64: dts: renesas: r9a09g047: Add OPP table
Date: Fri, 21 Mar 2025 12:00:17 +0100
Message-ID: <20250321110021.3612805-18-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS3PR01MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: 606707cc-1b8b-40ca-424e-08dd6867bc0d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KI16GPV5BdqG1DT5Z/UxkdIT9WfzFJD6PAbKmedTN4azETiO5RvYdO6tTVoS?=
 =?us-ascii?Q?k9rrZdYoLHS2A6cqJKChyCSSX94OMoZvXk8LbWUYUD9nviJ0enslTagNpvha?=
 =?us-ascii?Q?1FXpQf+YQ5vZx8mTp1pgs9SG6Pvmvxig12XzAXNocp+gyUylr17femxRxPxL?=
 =?us-ascii?Q?l1z8deWxlhauOBDYDKVOT7uvWf9Zi9WERP2Dima8llNdAawr8k20GUdshGvK?=
 =?us-ascii?Q?8/wg3iwVo+NNexpwCNMsds1G33MZNsOOVAjRgNtYXmvpMEFLZoOsQzXpRJmY?=
 =?us-ascii?Q?XzmdalSwhYnufoo97AH8G8utXJ5nruqFgIEIsyb0wDaVFf+LskO5CP4Hv6Nn?=
 =?us-ascii?Q?clwQL0oorSIY/RTeqQNzOB9wRak9INNnF7MqkYmwqAofh6JdDbhvttCs9dMN?=
 =?us-ascii?Q?hl74UNlD0xiKyLUp+PyScljYjkYllZAcVLHGBUtnGbdwChkIWBmsIT6it0fT?=
 =?us-ascii?Q?gfTuCChjodhQ3cnO8t1dEqb4oxNXnitTdN5ba2JfYZiz/jDJoXF2HmNpM5IB?=
 =?us-ascii?Q?h+9DAghM3tLHAKUQjjU+SW8+ylf9uL+cYtIJYALQDhwcrgwqPzyYBSo6X3lN?=
 =?us-ascii?Q?HRaP4Tna0nRIk8adN1e5aKvgCjU49Ge9mwaeOC9s6bkTD81VPHy4U1hG7d/x?=
 =?us-ascii?Q?eDohl6X3QsyvQEqjgv/tAadH6spM3ckmFx5gX7w/IKsIOACBjMae44zvfVG6?=
 =?us-ascii?Q?6KZiaKZQVsULcGQ7rpO4KAfMk51EgAxARYyHOaGisIMHMDRe0zD5QKxi0zhW?=
 =?us-ascii?Q?FtlsOaLAoXTy3fRaJmK3ZQuk8R1Ctj4DwgzYlqZlK8n8MuXUQa0+R0gVRtRG?=
 =?us-ascii?Q?90dU0Rzd68RE9VSUKfzBaZ6NDOr3mps434jXmTwtCZegkSgS99YJR9VCZRvH?=
 =?us-ascii?Q?WJmPdtGOKXcKgvWIG/zOC7z1J7vKMY91FQjps5YMWv7uSZiWqlIR4fyPpqpe?=
 =?us-ascii?Q?jXTqq9jdiflukLjvzWPAhB6ihlAJwbFS3NgCgTchLLS4i+E4kcRC+i+/Q9Qh?=
 =?us-ascii?Q?/0FqnRHop8VrMr/rd3daEy7WSXBlRy60typnsFIqeYIvJTbW7EXFg6HqSl2U?=
 =?us-ascii?Q?LQhFz91SvzCPrUZZOGZYY+fBFr4hUQjxABvLVuYpTwpa7HSK65lk3Yh9YaZH?=
 =?us-ascii?Q?9enFhDOICbl/HpBma9Av6gHEdwqpCIZWORQNgyEIWvUCdMqVltZrtr7TF2Iq?=
 =?us-ascii?Q?p6hRE0J9GC/kPyKQmEKb0fw0geefj4QS1ERSdYsjPEBiS2BT1CDj2C85RZ0P?=
 =?us-ascii?Q?5Ouq5kDWC5b8b6lwWbht1/MlAsqxyUMOgWfyd0Slc4dWcsp7W1svZ+f0h0WZ?=
 =?us-ascii?Q?QMshpg0juN2V/AdRj6Ms41hvqzgwvamtxcEJR08UGGWWEPNXJi83f307o0Cz?=
 =?us-ascii?Q?5WbizZoiQ7PoOce2HMyoqPsgc9AQHoJUFnAwjN+MMy6gvh4okAzzSXgZKBR1?=
 =?us-ascii?Q?VOB/WsjFxVw9FDFIDc0ft++OPa4CiNaC?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1j53i0fi7iydi6nmZwS1EsQFEb22mjkMRMjNFbyKvoCd4k7yZuOqs/DnMpGW?=
 =?us-ascii?Q?xw1US8NKFnDLi9ZvaOCi8AGIAH3Ca0vJL0/hHwbypjwSqnMgxu03Eddq0WUL?=
 =?us-ascii?Q?U5e5l4ye2+8QBfvYk5b7TgerOZ8tXDKjIJSeEoMB/k4PVZFKt1VBsiuUvNvx?=
 =?us-ascii?Q?QZeWvZqrqfRQBwDpBPHqBmtQNRvEpJC3kCBtwaOQHB+NG1nA6yrj1nTq9mw1?=
 =?us-ascii?Q?dbnUXAjjVyLbQv+T4rq+qP+4Ye2t0mlOhwHgT5LFii3OL69H5s4LFqisd5Eo?=
 =?us-ascii?Q?CC9FoGEpgnhcpSO1o85KADkvCYWT1BOOrjqMak+A8FGzdjdELdKASAKwv914?=
 =?us-ascii?Q?wowvPbs9f9e9ZC2efPM82VHTt+UJHfr1P5pI2MkE2HJSKA8K30S3U3vO0ePe?=
 =?us-ascii?Q?qYZWxHCbhNsEvccf13Y7AycahrP+CpKHpiXVdf+ouNgr6/Cvoutw9Gf3KxYB?=
 =?us-ascii?Q?jUXOe6WYzprBPuMNmENaZy8NT/TFeVQ9FbJsYl6rbQN+Kl+vyIzbHN+s4WkZ?=
 =?us-ascii?Q?98MuM3CvzE922aN3qUbR3fHnWuP5uVMoHd+mV56lTQpxLi5sf1qSq9gazXk8?=
 =?us-ascii?Q?AgrNLa/Ccu0hpXdtvycIPUY84grqzdQ0cQ/8xj2athjNz7/+T/cApAqo1gOV?=
 =?us-ascii?Q?wOInxkNDr/cIqRge/MuxiEASEioGjmPYRb0qo0N4OZjqbnsfEAO5t9gx75Wd?=
 =?us-ascii?Q?+XRtdKNOCo8ley18gR9xvrjNiat1zIlC7lVD1CmRMeeaFmXOVaAfrblDo5gS?=
 =?us-ascii?Q?47/N5P79BhBh5QeUOFnbC4NxTLC8HWJK+sYpGcL4Np3s5iAWusaigCX66KFg?=
 =?us-ascii?Q?WDi06t6TeUA41VgfJCo7f7mc+i8fI44tOYmhrmKVMJx1pFOhmo15DWlJ8vSj?=
 =?us-ascii?Q?XWdTA1cu47JBXouSyBTzgav3/phUkcAfn+eAtZNt06zsXRv09SOakDuNV1sV?=
 =?us-ascii?Q?wEiBEHPBY+RcgPeO2Ns9vPjkHRmTsGnJNB6UyhHQGui02hLPAFwBaHjtHncz?=
 =?us-ascii?Q?F71fmXm7Ms4Smt4bxunT9jHhuj5CvI4EFFSYKVS8EKeWyX/85IjgM03ncjvc?=
 =?us-ascii?Q?gRlTCfR2a8IUDVrVQlP45XjF8h7MlYqA/ChUMgoekmotQQpoeTo2SkmcSKns?=
 =?us-ascii?Q?ANrgA91kZb6QjttiETYZoZrHx7kDIFSGW2kAB6pM6hUOAKNdK9YRJB7CWUDo?=
 =?us-ascii?Q?VHMZR4c21LVWpxOg2Fwtyspy2Rs1DHzAsWdfo0/c8mv8mpb6l+HIa3qSK/S9?=
 =?us-ascii?Q?sV6OZ+CFRoNboGGwSGr/ofhUggZt0JosJgynywA3gQHFqAsU7del9Bga0JRb?=
 =?us-ascii?Q?9o5D79cQ7oN4mTVBEYU5VEE1ZNa7TQvZn4QGRtUqWcQRXI8sXYPERNn1gNYW?=
 =?us-ascii?Q?+CKchQrU9F22R8dksbOFET7HZIJCVh0hHL5AbQSL+yM1uJhY2gS6iZynT9HA?=
 =?us-ascii?Q?O164uNNQT8EthpMQ3UBwfm7wuhInHJwAk1UoM3Ekv0JPATq7kJVXb98IJgFI?=
 =?us-ascii?Q?rP90s9Y3d7fQ8/U4P4lGhMiCV9sE3Damg6JJOoHj6sWDGOw2VCC8pUbPrRRP?=
 =?us-ascii?Q?Yde/6hO2de/nh6b6IjlpCnGyInC2GtMEVZNjGqaly3a2Co+ft7DScFf86/Sl?=
 =?us-ascii?Q?epRXbRzHBG91hokKTNzVy6U=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606707cc-1b8b-40ca-424e-08dd6867bc0d
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:01:30.5623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9LyxDRPXz7ddQsbZxGAj6hHycRfkamel+7r8NYWR50ZURWCoRXvefOs3mFfaKBZPMrGjuNhZjtZwwjn5zLZgM1V9uS/GwRDTQCjoQGkRiAFGw7ZADoozD3egfPTsR3s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8652
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 11:01:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18324

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 8e96597f3c25007d292eabba9cfc9612e7d90f0f upstream.

Add OPP table for RZ/G3E SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241203105005.103927-11-biju.das.jz@bp.renes=
as.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g047.dtsi
index 4176b9aa6892..39a7cfb3095b 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -20,6 +20,39 @@ audio_extal_clk: audio-clk {
 		clock-frequency =3D <0>;
 	};
=20
+	/*
+	 * The default cluster table is based on the assumption that the PLLCA55 =
clock
+	 * frequency is set to 1.7GHz. The PLLCA55 clock frequency can be set to
+	 * 1.7/1.6/1.5/1.1 GHz based on the BOOTPLLCA_0/1 pins (and additionally =
can be
+	 * clocked to 1.8GHz as well). The table below should be overridden in th=
e board
+	 * DTS based on the PLLCA55 clock frequency.
+	 */
+	cluster0_opp: opp-table-0 {
+		compatible =3D "operating-points-v2";
+
+		opp-1700000000 {
+			opp-hz =3D /bits/ 64 <1700000000>;
+			opp-microvolt =3D <900000>;
+			clock-latency-ns =3D <300000>;
+		};
+		opp-850000000 {
+			opp-hz =3D /bits/ 64 <850000000>;
+			opp-microvolt =3D <800000>;
+			clock-latency-ns =3D <300000>;
+		};
+		opp-425000000 {
+			opp-hz =3D /bits/ 64 <425000000>;
+			opp-microvolt =3D <800000>;
+			clock-latency-ns =3D <300000>;
+		};
+		opp-212500000 {
+			opp-hz =3D /bits/ 64 <212500000>;
+			opp-microvolt =3D <800000>;
+			clock-latency-ns =3D <300000>;
+			opp-suspend;
+		};
+	};
+
 	cpus {
 		#address-cells =3D <1>;
 		#size-cells =3D <0>;
@@ -30,6 +63,8 @@ cpu0: cpu@0 {
 			device_type =3D "cpu";
 			next-level-cache =3D <&L3_CA55>;
 			enable-method =3D "psci";
+			clocks =3D <&cpg CPG_CORE R9A09G047_CA55_0_CORECLK0>;
+			operating-points-v2 =3D <&cluster0_opp>;
 		};
=20
 		cpu1: cpu@100 {
@@ -38,6 +73,8 @@ cpu1: cpu@100 {
 			device_type =3D "cpu";
 			next-level-cache =3D <&L3_CA55>;
 			enable-method =3D "psci";
+			clocks =3D <&cpg CPG_CORE R9A09G047_CA55_0_CORECLK1>;
+			operating-points-v2 =3D <&cluster0_opp>;
 		};
=20
 		cpu2: cpu@200 {
@@ -46,6 +83,8 @@ cpu2: cpu@200 {
 			device_type =3D "cpu";
 			next-level-cache =3D <&L3_CA55>;
 			enable-method =3D "psci";
+			clocks =3D <&cpg CPG_CORE R9A09G047_CA55_0_CORECLK2>;
+			operating-points-v2 =3D <&cluster0_opp>;
 		};
=20
 		cpu3: cpu@300 {
@@ -54,6 +93,8 @@ cpu3: cpu@300 {
 			device_type =3D "cpu";
 			next-level-cache =3D <&L3_CA55>;
 			enable-method =3D "psci";
+			clocks =3D <&cpg CPG_CORE R9A09G047_CA55_0_CORECLK3>;
+			operating-points-v2 =3D <&cluster0_opp>;
 		};
=20
 		L3_CA55: cache-controller-0 {
--=20
2.43.0


