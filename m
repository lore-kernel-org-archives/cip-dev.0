Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2CAC3600C
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 14:57:12 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.43])
 by mx.groups.io with SMTP id smtpd.web10.67884.1742914631188034508
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Mar 2025 07:57:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=LoCFijPv;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.43, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fD0HmqlsMS+sDLtqcfX31cGWWV+DBy8+r2GNbczow9qVg9faNa8k35nyRprOa5oSsPFtJLH0JSKfJcOwAknGYb5scQDg2ZDRvFDa0/DYsQV31S3KESkc+sb8pwkI5JHB0/Uvwpc1205oxeEbxVQfPwLABoWdW/DOwcuMXDnkWOAKdqOuYgxWOz9H8lYSi4+iEXT30BTNWGs0lGx+P9sm/3skLKi/5hQvZk5gpKwGX7qdhQURdyUdrNSHMh4SOcITkqwLzv2SjPfwPXvtGHxecRVBMuEDbH2VMaFG252jO1eAWudqbf+c8E+GWxifN42pbplS5F4uoDrF96ayTQzjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWRK/NTUo/nXhK5/kDtnmUlfmsMwv7vMIc3OssmrZ9Q=;
 b=XcsuXpDHnuNjJ4KuC4QjSfstMG42+F03IonM5PJgkw8F83Qo08fezizz0QdgmiRgtkT82FH5mmRnkev133adkvJroIX/WCnWR8pCmgwWQbw24DKE2dnUtax0qm2/cWYtJSR1jp/+pDe/Oudl7g4plSSMX+ywG+/JD10xzf2jo+tGHGl8ONZx8TfGUmgJG9A/shy9oPzASkI7TSNbyYJn1LZygPnoAgSLIG0EQctA6RPsqSJsKuHuK1ueGZr51YKk7PbD3DgYxNssK/VganR3HEkzlk3I1g5MhNAsYIoAe+hH0aGjtz1UDtVU4QY0XfePX/E7ZeZKD3ZsG7mMtvby9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWRK/NTUo/nXhK5/kDtnmUlfmsMwv7vMIc3OssmrZ9Q=;
 b=LoCFijPvDMO+2irW/x/e9OcLAIPitH35br69fXlss3OJ8+WzV5VP7miRdNl2gaT1DfBthwZhzK788IwdsqZjB18Je0Hr/umbVxOIdFMHtcIo77tGVzJ0VyihLdQ9zH3SWXnoSaLFIaBhldKr2qJ1lRS4JHptDlA1mU3Sx/nPK0I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB13248.jpnprd01.prod.outlook.com (2603:1096:405:117::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 14:57:08 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 14:57:08 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 12/16] arm64: dts: renesas: r9a09g047: Add OPP table
Date: Tue, 25 Mar 2025 15:56:06 +0100
Message-ID: <20250325145611.3595454-13-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYRPR01MB13248:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d811631-fb2e-4dac-30b8-08dd6bad5069
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?p+Rrgc0Mc9wlczqo2agF/5sqigmBbxDApfrZy7ZCM70/SZE9AMNy/kDov9fp?=
 =?us-ascii?Q?TCSdn/m44yzEYtWxv4oNZSP+HDosrxT6vtTR7UJ8LlsbL6+8kLIRiEfo56Qf?=
 =?us-ascii?Q?Rl50SE6kdRJVKAEYkM/4j+ikVRSZOwWvNJnllTmbS9/QKojNfQ8DbN0eZMFF?=
 =?us-ascii?Q?kePhQkB/aSmccLlkaCkORTrqEOs316OgQtzqtS+dfyeImy4PP8HYTn/RTtNy?=
 =?us-ascii?Q?svRGLjztAq5mAfGDcxsK9WqJ9xKjAb47ZNXnBfgFjBwhV1eh2ZBqQgfXfTT9?=
 =?us-ascii?Q?ZY80Mr/Nd/cNDbj5nMlniSfbe38WWgU237asMUpJQrJvGVOs4eawNUSi5jjh?=
 =?us-ascii?Q?8yBRR5Fw3eQeQW4jss8eVs/H/d+Z64TdU1LR9dsD8lhG7XHLhVtqxFly6O0H?=
 =?us-ascii?Q?MoRpneB5IEOClghUxBn1IqbBYNqQrwn2x7LbAuC6/RyGgq0+kjIlm567nASb?=
 =?us-ascii?Q?SqN/w/tVZEZYRfx/2ejw3tf/Lbv508nxJzfJCWcxEqVMT/MS9l87FNQAOrni?=
 =?us-ascii?Q?XohMalHmj0pNRjQ9H6PyrJYuPxj/CtBMsWDPIc8FEhTElaKSXErixnNIK3Dh?=
 =?us-ascii?Q?DgweDr6eMRzBTjd2+kF/IxqDfNWUHaEhV+Ofz684b55XuM/GKPb21ZrvHHMP?=
 =?us-ascii?Q?N4D2PrrjtH3piW/QYVZOblc9SUj0TF93IeMmZjvX7b/36m10r0WOUoFPxmrR?=
 =?us-ascii?Q?6T0gXYm+qDIKIZSEvxsVf/L9teG43vQlRI7kD0ZxKHKUUPW7q2bPO3L0En2l?=
 =?us-ascii?Q?jWPFkEkkAqqOvFcoccjKnE88v2BhAORqyyAK0HBzWZusV/NKoNMCbjiZB747?=
 =?us-ascii?Q?d8b9/YUgtJudY5Pi8flA7/iCf2tnqIIHwBHqSszVF7ktsOp+dhrl5RKrG/my?=
 =?us-ascii?Q?HOEXEW0GAyh7FPaQcLBXqqxwctj0ql6qZJi3UlPJ3vmQxx7NtKWBKXGi/+hf?=
 =?us-ascii?Q?b8LkLvjMNkXCTiAtvSBoY9y6PDdLevqPxnXWznrX9cmulzfqveomC5wsWgcI?=
 =?us-ascii?Q?5h1Qlhx2kJwGcoE5/XryFu00dad0abwO+pMsn/UwDY7q5GrAFgxrTF/fpW4E?=
 =?us-ascii?Q?ghyJyaETdwNqxiL7LMlYIRbBgX6YBVBqMY0yHsrJS3ZBmu4r6WrAwUlkMqSK?=
 =?us-ascii?Q?G381Sv9KDDhshPhxuni5L5gu3L67rwBjk4bJ6rNZ5NlKEKt6LZjPjqDYTCHi?=
 =?us-ascii?Q?L9FUAP0+DVk7Xw+h22Pbc3aw771UmEke0jQCJ343JqQfpSy0ufx6syF7+wLJ?=
 =?us-ascii?Q?HeCztc6PBXvFSo0PU8zcURA33k55c+owOIser7v5JVNOotyLs4ERYWzqa82Z?=
 =?us-ascii?Q?N+xMT+f2OSlPHdl6Rt2A3ZkJvNzgIe0FM0npTHjbSEso8YbOSckeTN/h6ZvL?=
 =?us-ascii?Q?S8eFmu6DCiGzNHQMbHOc2MP+iYNK4gOvTEzX4RLqFsIGB48n7uz+n9nD9++A?=
 =?us-ascii?Q?B/Ci3c1pL3tIQzCyeJGNn6ySjllsNdK4?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yr3h0IoqDXGz75K+grOPxlhc5fKoQJ0S7LqGXf7BbHrJviIMe1gK9yI7Br2/?=
 =?us-ascii?Q?Gu0eK7AAcQChwb0RrekHJycRltQYdrMH7Wm6n2yRvtBLZWRs8w5PDzyEoiOf?=
 =?us-ascii?Q?6jUcXZla7kYs9JlviWHFq0Y7wvU3gh60WHXU1FlTFwHVv5LxzvAdQXeGMXVI?=
 =?us-ascii?Q?0XMbMFj9C535E0YD/82KsDm+Qt0eSxmJyrrl+r7YsA9rACky1XRSudD94YiX?=
 =?us-ascii?Q?8GtXE3gRop6zIfHxYSK9HtIahTiPYcVIeaYbl6+bCZh7Dz/KJoRqKgGvTtTP?=
 =?us-ascii?Q?zP8a3ue5GUJl93+UuOsoGDa4bkYy4EY6KGz9z1xzxnQB9WnCjMS3vOQACIyI?=
 =?us-ascii?Q?W5h4c5irLRiJhe0e7VfKAAEsDv+pzgZddwF5rcR3bloIiVLgu0OCeyo3kDkb?=
 =?us-ascii?Q?l+WbnFbn9O6XGeQHeBQbTPfSR8NzFMyPp3CnBXPtE6IUJGkIy6ysw1NX7hrR?=
 =?us-ascii?Q?39hJXtf/sd+H3CBZMyRXor5X6LFYnTQfSGFrZHtzFda4d7nMRjY/BniaVdt9?=
 =?us-ascii?Q?5jSvaQcsD/NF2Sq9hcmQCDAz2AI+pSoLF3Xgb0vQMtcy1aJNRPRufgYgUXH1?=
 =?us-ascii?Q?GwWlG+rEGE6VWbd9VGiBzbciXT2GaU2FwvD5pmXc69ZgAY8DQM/LtORd4dbW?=
 =?us-ascii?Q?tCbTBy2qV4zc+6SJ6sxX6xtRCV6+WjP072vs2jsWI6akKUd3wO5aGRKTJbUI?=
 =?us-ascii?Q?KRJNZreH81NCisUGDChMVdK/qv/GkKWvFe3q1g5g6OzyPwDfJ0Ol3HHTIwzc?=
 =?us-ascii?Q?o6B67HrP5HrvXbbjG3UlMq+uLXbSGXEfA1/V4EBeGNXuaNkuCwXDezqQS7m7?=
 =?us-ascii?Q?04NYEAPgzATMxwYTPuT2q5ktzOvugAT/zrzZMpfTKG3RpxjCVNEfzJXxcmeC?=
 =?us-ascii?Q?TFIZNcUX6N0UYm9bBku2H3kvILgu/PT4O8eI38yqfrAFWdiwCWShRkO7OQME?=
 =?us-ascii?Q?bmaI4d6zulR/i9IOIAHEbAphwaLqYVThze3cKm44V3X04qMiuy0kLFH/diY+?=
 =?us-ascii?Q?d3ArBtEXlF7WnKt8OwWxQlcWmjdNzSS7Ni7KYlkwTLMRcFC2npqptJk83UkW?=
 =?us-ascii?Q?t9I2iigxLGFgh+nAjfZ7Re6w+0jz3mRV9CymglgEpJz71q8VIenfniWPXg6z?=
 =?us-ascii?Q?ntQb+XWT8IXNyOzs/f3vo/K+IySPoBuZQp3SjiH5xVC+ts0QqInO066SpaO1?=
 =?us-ascii?Q?UKWiZ1CReI/w//f9SxZOxdR8TUpMN7GzKSgcaoWPQdecD1QmuYH+J143D8oj?=
 =?us-ascii?Q?oE3am3LIXjhIix/Hd4NDqnLS/ZBFD0R03U9wpAns1JMHJ3HJAwdMY/sjxzZi?=
 =?us-ascii?Q?G6xUnwbNVtrHFDALUVpOvTfUFNU/3rpffQu1Me0UIqnsxtIwEM8EdngWNl0K?=
 =?us-ascii?Q?DrCnMbthadeQ28W4cI8ffJT7SX/4RD+PYdMss/KKAf1asuAIZY+xq+lTwi7K?=
 =?us-ascii?Q?rlqbDFdUfAyI6NtGUxUNEj89kmEx6tPDyJPyPvzZEVn30fnfOCr5LYFgg88M?=
 =?us-ascii?Q?f2zPzeVkYppa5Ok4aHsPv4p128hPhAf2Hz0LLLuJ7zSD3RRMYAV1wi4gdQXm?=
 =?us-ascii?Q?Kc/GVB7AogyfJJkKKj0YQKxA8BhVjzoR8bh+tN1PXxbcyf3/SqnKahQX07LZ?=
 =?us-ascii?Q?JGxbja9aMuLSmf8/yEI2M68=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d811631-fb2e-4dac-30b8-08dd6bad5069
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:57:08.2110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7UxTZVN0rNMH/zOuNtg7EbGjAN/u5LZt4PTl46VhnMx+sPE78MDl3NR6MSIfZdjEd4Ni8P0Iyij8QUcy5h+3Qrx9Yzs8sUnz3itoEYvPtU2XSRZVylnKdooe9KErp2T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13248
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Mar 2025 14:57:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18362

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
index 4176b9aa6892b..39a7cfb3095b0 100644
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


