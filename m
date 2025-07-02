Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA400C83F05
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:36:23 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.47])
 by mx.groups.io with SMTP id smtpd.web10.20512.1751452582132772918
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:36:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=cpdFJo0p;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.47, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PN471lyPeWAk2cnmV5EDXZjWYB8H9PxS8IU03f8kAqL4Qo4MvPIwYI3q+Qft2zNyV688bcrDsziNxxNNHkSZdhVbrJc97cY92lx71hWsR+/mDL0oSlYBMQ1kbVpg0lQkn/db9X56Lln/tBEt/VMRJLKI5c+bR07UFUmbo3tHx9n/aUweVdlkx5i1fJQDxr2Pvrqh7Xt4jci3WbQIRRO+NM81zF7TYLS/9TCpTKV2N5YFX7oyAIAAY3HmwoiPjZLwdkoNWSUu3rVJFbXokx0aQ0ZJWjP5Wa8LRQwOFxIJuv6VS7YdQxJFQewu9MNkwjteUJy45GyDhKN7o/RG22PEmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HPL1EiJskDiwNv6KQpt3HfLX+Xb16B6Ao9b7Rr5NBc=;
 b=lO7bXxbmzvHJEWppDvXBB7hdnYMTBXRomHohgXl60gXsudwqlwUCqrKGaPfZeef99fKUnZEsOBEo4/UNhJVdCNRy6nEIHqZaBgQZi6kM43fvc74dAEtSlXC12dKtcUZ2REv6scA3Rnq32EVsPfcyNdkNA/sCZDxSJVslKZyIbHLEpdqS3649a6ViUBGhEYCcXjJil3qJuydZp2xTtVtC2XGDqLDtSPnmQxt9buOHP0b+qfjFvNDqu8O78kZCwi0996SG+zSIad0yTgXbrE1XB4G8GGlckRUNXH7NkSXv7e3XJbNXAK6Nvs8NI8nkOZCK5y5TGOvE1DFk7vKkfDZDyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HPL1EiJskDiwNv6KQpt3HfLX+Xb16B6Ao9b7Rr5NBc=;
 b=cpdFJo0pv2Xn0TVnWfLJSUXUeVs6m06PHoQUkM4qAGLMP2izAo+Pc2ih/6Ri74gFKGRCOLOdDXIwgiTq2dUSEwj4012Vr78Eg2uEfTEsgDmdJZUe0CTYaVCbgIcYdmx8qbyOvTMSNVeWKQ2Jypy6R2KfjCbr1u16fFZOcr9vm9g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB14154.jpnprd01.prod.outlook.com (2603:1096:604:363::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 10:36:19 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 10:36:19 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 11/12] arm64: dts: renesas: r9a09g047: Add Mali-G52 GPU node
Date: Wed,  2 Jul 2025 12:35:24 +0200
Message-ID: <20250702103525.117166-12-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702103525.117166-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250702103525.117166-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::10) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB14154:EE_
X-MS-Office365-Filtering-Correlation-Id: 966227e4-172d-40e1-db2f-08ddb95447dc
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?SDkJCMZD5nnFBtRb2ivj/mAusbxdnJLYmS3+7Ss8Ss2M3PpUQEKFSPpLjNod?=
 =?us-ascii?Q?SShMlh9AihTL7XB8RdEk5wa7FjdmMihSyT6HZwJExna08PLEHrcC5XPmRJv+?=
 =?us-ascii?Q?LhIa/nrvFX6Un9mqf/ecepcbxRZgIDBoZSR6L2v3o7whmwfJerIUCrPeUqdD?=
 =?us-ascii?Q?CBA9kmi10/p4SNo2W17AYkN6g4X5jr5xER3h0gzGe50THPPRaIDOsdHLY3qt?=
 =?us-ascii?Q?jHFVLbuRJkMsdaYXnFqd/o7iX9O3+5bnX1xXrvwdUSZ2AOF3AxXiddN/nfl7?=
 =?us-ascii?Q?jB4PSxpw7JjlDVcmpRCNIlIVUMZXhYGeF61sXPCmnEWNV+xTJD3Q/Xl5LnED?=
 =?us-ascii?Q?F//5wdQpgREOl5XFbcMfdvpkjZz0AUS9sKjy2/uFmwJ/veC4sb0zSEDxTmoX?=
 =?us-ascii?Q?nkIoDdevqrVsz4bVuyt/edaf4seIc0KrJotxSbRAT2eWGhP0cWQXELbGgcDt?=
 =?us-ascii?Q?DL29UkHMl6gCpitS7AMozD0mkjux5EnSVc6QqpeHVuBa2+ZjsuHx4dFa22b+?=
 =?us-ascii?Q?OUEnH5il0BI8Y8pvF7dXOnc25AbC7l+En0s2QXfLYYoFQH9917q/DY5Tug05?=
 =?us-ascii?Q?ZntAFLRLGA7lsWyfKWcloEQQnIxhoq4h2XZRu2HmckOTlgEcqwERYAnMAvQ9?=
 =?us-ascii?Q?yRpa+BHUJmAl9dFSNHSnj9WdUpqzBYF7Q/yy9YZVwuZ7fX5+VYH79hnTcYbn?=
 =?us-ascii?Q?YCZHHhIygSnV0xlAH/W1z4Mmhwp70W+rTwMuGUy0FGpTHo6O7E7EhwUE9GkQ?=
 =?us-ascii?Q?m5SsDhU4wCsXsCvT1jUjEim0g33/MHJA1LWf1mRVijmbxylDeitxTFXXlNip?=
 =?us-ascii?Q?LyJs19iG/FkD1Y7bx+CAlRoyKMEnDFMwFERLB772IeeUpSbPjwqDDMXL68Xt?=
 =?us-ascii?Q?C1TnzQIPXjW01jGvhlBQpeDcRaJIp2CntUmFkVibB4/EyfeS+dQLoZSGUN3W?=
 =?us-ascii?Q?pWA4ejmKZA9jWmbgMx51JPdc+uv1lu84cqOz5QreKnDuCBtvusvCHjEgFWC4?=
 =?us-ascii?Q?vMv7AnQshCi3RqUCjw5uMq0UoEbGZUYhz+Dh5myl0jBGHfi16HBnAfWrLxUV?=
 =?us-ascii?Q?AAQEKE2fhm9cJBkejuLYCm3HimKSKjx3xMDs5xXWE5TL/U48TB4lcUQBnvVb?=
 =?us-ascii?Q?Kqsc0jVp6UPgm53PbDGiMEyRpRqvDzU5eJRqAXaWDwJ9HustYlOOm5p24Ju5?=
 =?us-ascii?Q?3rB5Pz69zUlcu+xl/w0WfeOUgdAst77tJAj8sNIOqqst+VXEdarczuKLzMEq?=
 =?us-ascii?Q?alSu+AHAfK1So7RMsNyxlaYNsPTddJ6pcZ0BInhcn2lkKLNNwVgnJ42su3p9?=
 =?us-ascii?Q?z5Rr/1cQfN40BeJXK2fiBJy21xQAxD9EMyI3/phDRvnbqxd3zZ8RW+wkq9vo?=
 =?us-ascii?Q?6+hMRc80r5WhBU83zMaZTLWFiatqnAIneh4K6x1CPhiRT0+KctjL3uvxBDiG?=
 =?us-ascii?Q?W6H9O/vRQmeGLsEK43MG4KTibop99U3iAH+u1zxDvwdKHJNbj2VrWVnQ2AS0?=
 =?us-ascii?Q?nDOS1sQ7UDzX2ps=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?aoAgrotqlU7y3wNDtWlMVtYBhpoa7rM/MsQcCiz51Xr2xLqm2RFRXwvd+lO4?=
 =?us-ascii?Q?YKga5wm9/nDzhex1OtGpx3rLAN7UHZc/OcGNizvfuY2eL+EJShrBTIzzGbdh?=
 =?us-ascii?Q?dHfs+M9eUpGsOWVD0TZbePF1YGA/44nUiXBDQ/k1L0FOkd5ZQf47Myy4eVog?=
 =?us-ascii?Q?arbbI+bNF5ZramFGEvzM1hhubB+VMB1/wo8fcmXGi/Ka/eWqqn1yqKo8NbsK?=
 =?us-ascii?Q?EWr9ERywLx/viiCOvBIOAC4LZTRJUACl5REnHdllkZPcfzIHn+uBw+GH31md?=
 =?us-ascii?Q?G1U59um8n4ZTi5336oKdszOd+ow3MMDvfdVYDN1gUXbYmCDyI5gsRoGmCZ3c?=
 =?us-ascii?Q?Ltls4tpOuylohjVxBAtcvAMOlQ/T2vhdaIMED1WkVtKGyYG3Ibekh7hqwY6F?=
 =?us-ascii?Q?QZroxP8Z2z/t4bN2egVDnD0zC5SICl9sqI6Y5Jadsa3QhcfK2m7xDJ5KPiqf?=
 =?us-ascii?Q?TntjoIhFnA0ufmJ3rtvSPOrlQJlnI90TXe19jDoKCumlu/O+Ja7I0hYwMidq?=
 =?us-ascii?Q?4d66p1/VwtvfhcPJB+MZR3K5ORCrurON3JhsLjF7IQjgt3ADeHNcuu6ENu6F?=
 =?us-ascii?Q?gmzabXAlZZcX2MJ3E9M6hj9IOR177XDsaXUQieWHhq/dddoAhZsWqgmxzHZl?=
 =?us-ascii?Q?CJmePAt6mdw4Pw6AbboIS/djeWu9IWhF2vklbxYKwTwiSv+1nx9MAlt703i7?=
 =?us-ascii?Q?zMW9BvvnIRzm3LqhYIKDi0YoGid0c2wUKfiq9guvB9M2ADb0tAVhRfVln0vY?=
 =?us-ascii?Q?RSEUwyjsuVMY8UTizsDJJVZs9WtXShrzeVOh4JjudnAaxPnNJ3km9VAFu8sf?=
 =?us-ascii?Q?pEjZ1pPLKRc5CN1FdDVqxOKKVQNObLJ8LEWvECfzkEdk6qs7ftSmZdWour32?=
 =?us-ascii?Q?ZzcCxvav91B4esyx+oAH1P8VZktDVgLIoJbEqAcVyA53Lo3uXC/aX2N9rHaz?=
 =?us-ascii?Q?9+BiZykB/IFW9juIaYrchAEE0TUDR+NtGV4zb14myKw/pst0KqK8pgtJTFD7?=
 =?us-ascii?Q?VYaTwguaFIS/8F2LPihsUuSm/nxGyAGPvq8mu3bBTUxjc75aKxVC+xDuJP9s?=
 =?us-ascii?Q?2VFI5pdHfbQpkVyGVay4cW9cq7wX/yzQ1DSRGuF1IjiQ3P05oTk7j7mMZWvl?=
 =?us-ascii?Q?EczfS3kwLixBXkwhiuM5ORjM+ZU3iP6IaBj3Es0n8u4KQfFZRH4hYUQNvP7E?=
 =?us-ascii?Q?h9Pq/+KOQcI4Owq9N4RcJrsF7yqxT3ApEB0exvy+zkxc+6714O2X4CDH4/el?=
 =?us-ascii?Q?0FWPQkO03bQBmEAYfAFESItIAroEMaJkTNRDXk26ms7tdyTtmYCXPmW48Mf2?=
 =?us-ascii?Q?cxnlQ8Y0X3KEgSSgcmIY8cE6ZWnjJEXq+CG4McGtWMbvhtZtOaIeSDFlN5bt?=
 =?us-ascii?Q?iuJTd1u18auJr26QEafAa4i28JoOWFLtoJu1FzSB0n7+y8oMFJ/uXHQE6NG0?=
 =?us-ascii?Q?38FBuP0xxTy1D7rVGmzdZtliZz958f01BO70TquJRuUn4Lh963pLXppkaetB?=
 =?us-ascii?Q?KTE0zeg/ya6xW5Wgr5OYPHGtUudoGNyRTP4v/yjDLQUIxcsG4UIUSWf6G80F?=
 =?us-ascii?Q?M3driWEUmX3HV640hfo4eoiBX7G2KjzKCar1uZmyQ3agKmpySdLrtO1GUgVH?=
 =?us-ascii?Q?UgHdBHapKPqqfMEDZ3Mn97M=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966227e4-172d-40e1-db2f-08ddb95447dc
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:36:19.3707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVcUuyJTP+x0PRXWMIMlLqezD8waOJ/HZHafL70S/edFrPG+82a5SffH4h3HIypC/tENA9mZtGG1ScElhJXWII2wR1DtLe6ucXKLb6wZnGhD449frZVAz1GFGf0DaopR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14154
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:36:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19296

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


