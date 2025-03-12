Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52467C35FF9
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:32:55 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.46])
 by mx.groups.io with SMTP id smtpd.web10.34441.1741778671347722364
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:24:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=mgaBqdNC;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.46, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dx1mdpZSyUGiJRke4F6ZR4iaRHHpBM+nGf8NFMdy34Quyrhnl4wF/SCBLJaTv1FhB3nnFbNuytWQ9To3S1D7G7dPxdYflVlKi4i/6oZwGM7ct4D1thnzrhp/IEk0dcf6WcjifmaLWm9nQsHnd9EZHcN4u2GOjXyAraoDBkpXkVUa2KIu5Os9Zc6bNWPWgLxVlBg9EU6lrH08sOX2+Qtd4MCl8MnFZqFbWLue4RveuPSXUDtHsnOwM8WF5Cw7VsupsOrhSKSwbIYEk3HBD7UUqT3U10rxp8G+fn+d8TXMlfSYLCt4wEU7modAeC0hIATzg1w+k6FWGKXnKAh9+RL4+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n09enertoP/m3VjXnN+5NhX2ITCNrNmf8zu4qr96UI0=;
 b=G/Sn7RZLte9NUBVGpRZz9VxxQh6WOD+TLsQViMuWFSeOt7Bnw91tElZmPl6lqITs3hpnMq9o6A8pCvpB02GfRxBeGz7euLMOLoXpe7bOm3evfreSkPna4ObCI/mizcgXlmbF/jqPk7K1WvrjRCZlxlMwXvOeOL/JwWf3weeFKSl9fsLB5PC83TNpj7UUIKjhZ9jVVYX7rBGG4vmNmzShDXS6WE44o46lpbcoa4jB54T59piZMskZqXFWRch39forOhO0dVMWWqpLHx2b0r3qi1QW6wKYnngE0rqmU2znJiBUySBAZAWUs3A02JBsDtm+Azumytz/F2nPVZ3pWCl9OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n09enertoP/m3VjXnN+5NhX2ITCNrNmf8zu4qr96UI0=;
 b=mgaBqdNCwQsCSJCtLYD8pe97YueWK4qIBx3WVANakepkqZQLDJBFx/p5S4ujfNd8WZB9enbT+6TnWjnxNqmyszI0Vxc/caI5Yu26kTQ5MwB/weTao8C/8UTl2NtbiWz0vps/wffFnXWBprLdZjlAF0aWTXm807RJ/jBGeGOBzU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSZPR01MB8767.jpnprd01.prod.outlook.com (2603:1096:604:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:24:29 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:24:29 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 18/85] arm64: dts: renesas: r9a09g047: Add OPP table
Date: Wed, 12 Mar 2025 12:21:55 +0100
Message-ID: <20250312112302.1605750-19-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSZPR01MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: dd2329ef-24ce-472f-b6d5-08dd61587439
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rBOwERlWxfGKzIstoZ5mtAHphL8+5W0NgRu8Y5iqyb5SbJYXE0diLmkN28W2?=
 =?us-ascii?Q?7hYMf/m47PGE7X5MCYgvKTlh/kUN+5tAPcidXwkFWrxmRXvBFR+MHsyYGo+l?=
 =?us-ascii?Q?DbpWfDbBAI3eii0uSPzPN0xAdWrrPuI0XOJ5j7ewPlp2ot1mWFzdd+lY1aSa?=
 =?us-ascii?Q?ihvH0vmw3kHZU2f2RxrvJ9NwXnWkI+v75snLoGo3XdCosuKb0H5FTd1PfY15?=
 =?us-ascii?Q?Tv1jgcal2GAeFIYXEx4gnckWIvgSjQLuWHGJx9ArEcoeUHYkXnpaHVSUNbRP?=
 =?us-ascii?Q?d9AIARChjq2Js7c0TfYSOGWnKudLG7nhTKjReOaHOVSx4z88xAUqkqNyVDnD?=
 =?us-ascii?Q?O5qZuZIUYBBjv68/zK8OGPAIJcoXS8fMuQjguoL3z0y7mQX+AGQ8TkCHxnp8?=
 =?us-ascii?Q?g4jqzKwUrEa/97Qn5SLKTpQCywwty03+S+p9KwYrGOWEPra+N+lNN/j5D4SJ?=
 =?us-ascii?Q?XLJhXcB880wSgk+njRycrwnkzrSXn5NZrA6m4onOgnKtJhJhMluDTD+lk4V9?=
 =?us-ascii?Q?Zi1VRBrqmDrNweWMgzZEol+/hD4au05MsB3t/WuUkeYfCNElUq6Ixd6wehuW?=
 =?us-ascii?Q?mZ9UqyUHa2Bf8xi356eyDszrfYupALgA9d2nYi8Hm/LPEhF1PEfEyYyznJ/V?=
 =?us-ascii?Q?rTxxBn6+9EuDv8hQ7Ms5U/ogxnZUP6KhgwGd+pomVT0WqE8b3EWuR7lwGUIG?=
 =?us-ascii?Q?oUt7U5vdgMqFUwJQwJpRRhflszJV9ACQFcCnnfr0rob/wdtMt4K24moc3Ug6?=
 =?us-ascii?Q?t9hNIG8HO14UiNrbZ6zZktfR8kd5OsVjvnfw1NYEM5E6SREL58cAK/YBJFv1?=
 =?us-ascii?Q?1YljM8bgjnuL46ddVRUtRjg0386/k26lpYKaC89P/mYNSbVdLCWOY24ptM00?=
 =?us-ascii?Q?ybtyFdgSxheh8qn+3Ka4Nk+48uhAZRuU1FHloDi4U5bx16e4h0FTZ8UmszXf?=
 =?us-ascii?Q?lnb0YyyBSfqGuhwPxh0aRJbRPybVA0ylJ++yClfkcLqZw+e/WudQ7VuCQuc7?=
 =?us-ascii?Q?Az5F6D4aGjlSdhzkfjGyf+inM7EKegvSBEcD1ideR0ls8yHC99f7+N+je62z?=
 =?us-ascii?Q?EVXlIoPcPKbR0f3E5WJyrE0hEvd56onieqeUgXpuaffaN4xLPy4QZCHorCkO?=
 =?us-ascii?Q?nRXMM1KYz09eKNUOoXUi4Onz6qt7VeJXHgb7K7hIsRkNbFjLFtNiyzMZ/6tD?=
 =?us-ascii?Q?ku/gGm3B/aQSV7eRBQiUS29VSBZ982l2JGS3GO1Fr289+ZZ1jdjgc47zo6Ev?=
 =?us-ascii?Q?FmV71xwTgDI8MCNspI3e6kzBBajncjpDtRVKMgYb8xic/5XFZtORp61qVTJ1?=
 =?us-ascii?Q?Ea3MtUEKUwke8gonOHKR1EJNMNAxyXwrG6LbddEQ+Wkc3WUO4JJd5tE5ePzo?=
 =?us-ascii?Q?2JwoviC3qKnv5I4AYubRcYhbneTm9C9QkV+tf2dKNBsESxYpIPsGg+LDC9El?=
 =?us-ascii?Q?9YAlbfcmfK7xeOdtwSPui3YxEOxMd7Qa?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?o1XUBduE6guLj20pEr7gFNwpk2cdOHIQ3xCwYWdGLvuB7oiw2Qd5VfLWYLY9?=
 =?us-ascii?Q?mUNGwsEMAKJ4nLDVlYVRbuvpl8rvGd2ptbPEgMq1xja+Bk+TjsgSDsSvzJE0?=
 =?us-ascii?Q?XpjOZ+eOX9DqdL81snKKsRHeA/C/w3V36Ig7Dq8ONZF1Bbld4zpRrWkggBim?=
 =?us-ascii?Q?WFO7Vik355ZN01HP6CGGDM3QTEzvyPs4p6kTKZu/msFuoYjPLhpLXLJc5DxK?=
 =?us-ascii?Q?KZWKotxm8qxL5zfgjCq7auD8r+DODlw0ZmdNCYyy6K3VkxxzXSLJ9M8l8+nV?=
 =?us-ascii?Q?0s2FmpLpsIXjPO1FkeZkS0ilY/QpMyY6kY0ZTqznAKYVBTzdYp4hrLdYywV+?=
 =?us-ascii?Q?5VE4wCQvZ0tbleYZb5JZa2AVDn3GT6MLjd5vn3UkfWONVKGBwakrDzZtZG6c?=
 =?us-ascii?Q?RRKdFbqUvBl9NUleNgFdZ24fiPrJ9OgdEphuoZNfEndzUZNShsge9zUfHfjb?=
 =?us-ascii?Q?FPEa8kgtr1MJRccJhNjxLmIGls4AOhWl5uRWZNgRuNKZlWmc174YATSuZe2n?=
 =?us-ascii?Q?KLyCqWmglygzZ+nGcL8p4qBd9tGXmxHda9b11vnJkgTkxv36zUvknftnjRkf?=
 =?us-ascii?Q?BdA6PRB1B79JhAqSpWu2/VUlZtZqTMaNQc2Dh3skbkBZZmF0b4bz0KHQ28nV?=
 =?us-ascii?Q?RgeEUd83/lgxQkiGQivZYKMLZ2Nm+itWmXea/tE4V91xVrzktqakeq9UA1Vm?=
 =?us-ascii?Q?hMueUPChVIaY/Wmm/xzVN6vCmGHd+YoSyaQhy6oxFbjZWUSRMThwY4gQMCUV?=
 =?us-ascii?Q?kXdJ5tOwpmE4fTWU2KGPMKJITF/7R31wsAeqsUlECrEOepXJpG+9OGUyWSUZ?=
 =?us-ascii?Q?DzRz3gkyDqs5IhiKlNDZtenT00v1doaeKYjeDfGwWFj9r/t3ADBmGmG9DGaD?=
 =?us-ascii?Q?nhPoMIDdeWCFau8bbb+j//0vHpr4ZSuP7NKGmQxTvu3XroZODQIUAyBjCYmv?=
 =?us-ascii?Q?5tsnfK3wIeMz2A28QEphKSNiDaNps57H3bCcpbHUOEwUgohgUFFTZzhIFYWT?=
 =?us-ascii?Q?fDMSwDReGNi74onJifMpXGuarNSs/WcYkbVEMpg/XNkdq/I0Q8a4yWK9ROHx?=
 =?us-ascii?Q?gOdXyhgrbgN8u3DiBBFPjD9razdiPussJrucYyD/c7fmSAdiF6hYA4QqvEtm?=
 =?us-ascii?Q?oSxvs7bta0nGPz41kNHJVM4ykl5bXHce2uQsZqh1XC5lHEzD1YwU5VgysDVn?=
 =?us-ascii?Q?PqLcZOwwJK3gIfc33LKIASGt++g7RN92RyVfh+TBvrPivJPnwDV3mJggWIsI?=
 =?us-ascii?Q?nXo1U6X6mc+G8vF8SVJ5CKBeiDqz+fcnJsq7Gx7xq4a/E3SbwPMsAesiMiVH?=
 =?us-ascii?Q?CODHLPzU+OMeOgJu9HHsqWXd0XPdAna2dqzBdQYecoImr8xUzKvRcByCe92b?=
 =?us-ascii?Q?fd7Ru8dvw3CqA2tfnkNL1S4+itmDAtyGfxrHlh0AZf+KHt7hDiGZv3o04C8l?=
 =?us-ascii?Q?uOWJqkl6zBOZa91oCSeOmOonKCGuVstRsyXTkIzo8SsObe1j1i9O706Oth1q?=
 =?us-ascii?Q?cAsnTCVESXXcZWPQfLs2maQ6ajhyvNjE3GipCXX64GIiKB8N+hla3S7OOmuY?=
 =?us-ascii?Q?dS0byIT+opXvorrFUbslkjhdjc5KAayGvs12PBS6mcGUsjZFaC+8yXV5T+Dw?=
 =?us-ascii?Q?MjgPWS5AMUqo6f9uC82tp+Q=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2329ef-24ce-472f-b6d5-08dd61587439
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:24:29.4869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+hCKHGPSHec/WGtJ4gKTz+p6Ak9SHEMB6hKQ+GYGiCKWuYy7H4v4qtd4G3d/FDh9ecLWyu3g/Y8ZnpNScWlSQORGE3UcFuyfpppvz+LaMUvJpkG69O2sKgsApV6SyWE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8767
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:32:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18110

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 8e96597f3c25007d292eabba9cfc9612e7d90f0f upstream.

Add OPP table for RZ/G3E SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241203105005.103927-11-biju.das.jz@bp.renes=
as.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
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


