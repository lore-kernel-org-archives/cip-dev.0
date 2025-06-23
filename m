Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E86C77B7C
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:47:52 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.27])
 by mx.groups.io with SMTP id smtpd.web10.381.1750690064143842461
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:47:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=GboZZLiQ;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.27, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjyoEYBo2u4mG3l28n+a0BfZjWjoXdoihSkhbkT0ubuWXfIT5HwIL0Xa+IuLAOYFgkRugnGF1xoIfNzo2W5ufOnax1N1sDnr8MDiTFCnFZjry37y8oD3EJT2ecQefhkNXkwOkXEBeDVGtt3NEvtYLhVPcsXer/256SkIIgbnwuYHAYk48C3q0j/ZOwCiycF0yHSxEpIPn+XINPqE0ouKXTsDnzYVMzhK0fQM8xc+Ed8DRWKzbzfqfmCndHU2pRSvkvhffm0jkXxv2oRFGYW0tBAJeis/e+6edLPnGMaefky6vwjevp8KM/EDq1UZX5mwGmYBtcJQT7fxROmzFPJl+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGXLuQJEwSRQLWyCwbyW5yUQ1arBICgtDcHGbRVoc6Q=;
 b=RDgm7T16umWrWs3UK2m09q/JRo9z1XVMMVOuSyXtGWFP8lISB1ioPfV5ezo2lRHpT0PEppBQGWWbmbcFRYzFFEpRkrGZC2hv0MAytjHa3H24HQlVfIKds+0gFZRvwOeXuY4XsuoHr/m8l8lw7BYhxgIHw8ePcLyYaFGodduNPNqUy6gIZu/JV3UXkIb4tJcSW8O7fHL804Orml9pFkNOwCnbDNdTZMc8GWNJat9h2ezw2o5nzTAcCEuscSLnEjImGfS3I86b0lduXbZVLDUCB3e/qe7ZYYIpflwPh7aOhBqtpVBqgWvN6tgX5YwKRJr/FkYGHb4VKXyUCzTofpcaUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGXLuQJEwSRQLWyCwbyW5yUQ1arBICgtDcHGbRVoc6Q=;
 b=GboZZLiQuhmPZtyQ/SfIkof7zlQA5VsotMuS7zqMFB2O6CxwN5ZYAMfOSQAr77xSgu2NhRlIxpt5CdPHo7MfkA+8P9gN4Z1nXn8eSZqpfe4GEsxVWIQ9Y1nexLOHDt3voD1XUk+dMEeE9erFTR7mzn6xu56l6oaYKZBV4RNGHnA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB16379.jpnprd01.prod.outlook.com (2603:1096:604:342::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Mon, 23 Jun
 2025 14:47:42 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:47:42 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 13/17] arm64: dts: renesas: r9a09g047: Add SDHI0-SDHI2 nodes
Date: Mon, 23 Jun 2025 16:46:35 +0200
Message-ID: <20250623144639.2119707-14-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2d377d2f-87ad-458f-bb02-08ddb264e854
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZAwGzy2chDFBW8fvYJezblZKbcDugf8D5TbzRlih9QDYqJL0esFvaN+Kmepa?=
 =?us-ascii?Q?0zEZnDagFN+j1hZjVeAM92KEKiaj1d0m0/nROlGz/j/4Z3EQLvl+RFuOR/6y?=
 =?us-ascii?Q?cjha5KHoafrEDuFAEzI809jC60oavnlmohloyCYxxuUsCOPD5Kd3cesgHs1U?=
 =?us-ascii?Q?KDQQ2S4sW3jSMRaNTUkeYYUasXJYM3UZTsiwlWpPMESEiwJR1pEZcvvxjaBC?=
 =?us-ascii?Q?HevueJnRmC6xmAU+w6T4OUWXIZP0Xk1jQ85GEJDAY+ibocdMNmqU9YjmFfZR?=
 =?us-ascii?Q?rZMa64MhlQK/+LADUF4ryYImbUBU5H7YX0GTA4k7GPv61DDKP0kzhh6cXxnj?=
 =?us-ascii?Q?0FxCnIrSoEXKMuxJQHjHAdJBqOTPYC6p0wwk7GZK0/nve+9CL4Z4ogzh9kDu?=
 =?us-ascii?Q?l0/e1wqgv8/TrfKEllDNFHKm13sT8n/jJv9Qs1soegRqEZq63aGJ4TQbDebf?=
 =?us-ascii?Q?vkXEM3Sp/ErhP8KEwowgvEulJ5mne4QCfxnXeRBw/pDdbmS5amypiP3R0Ri8?=
 =?us-ascii?Q?Jt4Hm7CfacJ9C7JlYAoa9hx0Oyssyrw40xrSl5jp1ANH1lx1I5G/hIHp0ude?=
 =?us-ascii?Q?2+dR6foON+hFw04B0Wb6W9ypAgvOMSmqRU/z5jLN0Rwh0/XawNLBuAoBBlZb?=
 =?us-ascii?Q?SwOnLS6Ul/TaYjl5jCvNWOAjB0aR7LY+0Al8zLngXTCXaq9oiYrx26S6l06e?=
 =?us-ascii?Q?FlA3TnkNosHRUZaciQBBKbTHh4DwFUVjI6vof/jwo0TbF1T/7OHeRb9y/Cl4?=
 =?us-ascii?Q?qmsN6BVFStTsrqe9RPRK6kQZ7Krzvvx3nGa9i40kJ0CCPZ70a1oTxh/AIJNn?=
 =?us-ascii?Q?BqtunTlTum2Zo78TiRCD/3T+K+Dm02deT7IHVLuEcyzota/SP1BSciXzB9LT?=
 =?us-ascii?Q?GW5VoiaG9prmO3FfPNVnWTUYBAcFWrvwJ4sTfLOWxn9fBxba3J9fyuzYKRqS?=
 =?us-ascii?Q?JGcb5pl+hKqVCJygrZ5jZacfNA/mrZoflIhSCZ7v8erl5L6cz4w7WbvSZXxb?=
 =?us-ascii?Q?vhD6SvXe8ZlfI3yPP0h1YVDFg0N5RRa/FwkqJ6WRGIBIRbOPSAPurgPLUNf1?=
 =?us-ascii?Q?clhhT5R4mdOghvAnvRr0aO+NFSD4gzXjZ6i1k+3wztBtYaY4NEhtC/0YY5SI?=
 =?us-ascii?Q?SAKesrONfi4MdCiE7ozyK0+N1GhCeJibj+0ZnBhBhv0nXb81rPSGECqF1dNa?=
 =?us-ascii?Q?lK6FA77046BBHnKnHhznzXWqNJST0dtUdBbfkDYEODPb5B0oGZ0ha8VuVXKe?=
 =?us-ascii?Q?PgLG6QtgS2x8wPsUdK3fK5nEGdmBZNIu0lU2JGTcrcxjfNnSQjEQpTKFZ2h4?=
 =?us-ascii?Q?PiGSdq6Eqjzbtm/pY0BymDhOKrMcsMPtbvfq9VpZhz2/WTzqFLsEBDxUUSXY?=
 =?us-ascii?Q?tBTdB8Wh2z9EOBcKfT+BEbdFfFXVgEncp/UfQuVkzV+g/XRGBY/C1l3T0YG7?=
 =?us-ascii?Q?vjB26r80xwf9bAdnV6nga5RHSH/5aQ2SPe2Qqj5cSdpWHcx7k/1fKGccdupr?=
 =?us-ascii?Q?CdSkK/mqz6kb2hw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?juVN7DTD/YjowPxs4ERqG+yX2QdQj7eLVYj2bcbnbq35ij6RJ0SqDvjGI2Z8?=
 =?us-ascii?Q?e9FwR8npQyEslseblYA43h0wXBrj+DhCleW01Y5LSaCTjnHCur1Vl7Ya9aFL?=
 =?us-ascii?Q?B304rDaTQWiLD1ux0rEWrx/3PeERb5HDsbLdiiYQzSKiYZ1ghBwa9SJ1Sgo7?=
 =?us-ascii?Q?rpjqi/tsgFsR6krIjMrrTL84fj6m32wxUq6L55Y0XobH7+8EM927oz9qPNMo?=
 =?us-ascii?Q?fFZCl/AhSbxNx2cLfFS+q7tchofW08CGJKjTm08LbEeKT4LlHSPVhoF4wbnY?=
 =?us-ascii?Q?GJGkbewN4cNY0fApu7fB25l/9G0jYJXgpa+ybnWEcspNGFtNnwWc0DZY0CHH?=
 =?us-ascii?Q?Jb899u4KRsFLHATgEkbQ7kQNuaFCbuacw6igMPjQAZLQLOM3z21xFSwr3I5B?=
 =?us-ascii?Q?HFUbVO3CmnkcvemVf+qdd4p8zphj/ujC1fFkfF/eDH0tkjr0mdg07Y78RYPO?=
 =?us-ascii?Q?P+q1FdArjXtDs32a/BNxnGl7oyWtoEvdyWLZJcgHFVTk/h1n9PsHc8T4JG1A?=
 =?us-ascii?Q?z6N74eY6ArxXr6OuOjYUpuE2pzIPYMS47PdgdCmH1YUrFq8xi3A62FHece9y?=
 =?us-ascii?Q?U9h/5hiyeDtrEKuclchzWOk6YI51D2wdkk3721E1u/ywvGaE/FdXqySfjCXN?=
 =?us-ascii?Q?oqYfvvFqwAeFPbPWaqyBzPBYttbKfJhzJtg266cYm9jD7KGlIrYpVs/a9kT4?=
 =?us-ascii?Q?BnpYvBvNx2M/6ySjq+0wS1zoMUg1IFtAXihl9sdo67YH7Eglkgzh0u8gJ8SS?=
 =?us-ascii?Q?8xpcUHYyhrRebmfN3psCUzv42w3KH55qmTrl+epTXkzC1imfVAdGm/dLB+js?=
 =?us-ascii?Q?qzkctXHVOWWyCoHYmStKd1TX28VKHmuqsQm8MHr8q8heAp82KYljYL+bzEAD?=
 =?us-ascii?Q?P5DBbJgWaunokBJ+9BPy32ueo3N/V+epeEUNlFSU+DKiwGQ/7i0dAlFfU063?=
 =?us-ascii?Q?odjqoynwbf7W0o5nFtzIEdH3D4KZ1fKiR61y5UfdMIvcR3s/zE3UxiThFcQy?=
 =?us-ascii?Q?9mjEVmcW3pgBdv8FYXNSN2T+U+10mMuj5Ggg5xRiYTYF1py9UPT9ixSPRB04?=
 =?us-ascii?Q?bRpsKAbxwxghy9bXqHGiUsRGrMLGIVdLkESawGoBGJiJ4XNWS4Q+MVN6Mmon?=
 =?us-ascii?Q?QxFP2c3mxynrQjD47Pm0PFqZEuMnbxx0uOHg2rczhzuC4O0K5cqz2dscPI8F?=
 =?us-ascii?Q?SJUOX/C/MUBLaPX+4F/Z5lKHUEI3fgX7mCO3GkvKiJs8fL14sApDwNDB7Osz?=
 =?us-ascii?Q?XC8/0i7A1NTt1rrdYLom+OXvfSWvwneG9KFuwDlQMGSStb6uhIBA0wlVomlx?=
 =?us-ascii?Q?JQPwZol3SGDY90zBhs/xL8tWPVyOYX3wttH9DidqEqip2qh/fNnIhaIPkMVD?=
 =?us-ascii?Q?2X70AsFFiloHWCCj1AgIZdsjtTanVY05x6G4RMWsjJDvr2x4dpss9f7ykc1n?=
 =?us-ascii?Q?bUuJFdJRfi/85Y04wSevTD9P4+WslfIvpRfaywLUa7Jxa97xY2S4CEFHoLq2?=
 =?us-ascii?Q?PDhar2JZ4dAi8g6Dv0+PhRJrPqJcGzfTaZViOvIyq1d/7bgUfD4zPZ8jK0j1?=
 =?us-ascii?Q?xAXbk/90ZrWOdSSOFYX60xR+cMl+K9PhNyqyIqTtvg6JY7ZaDNVFjgMf2H8i?=
 =?us-ascii?Q?hZbFxLIhqLb9P8rQjvhoQHM=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d377d2f-87ad-458f-bb02-08ddb264e854
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:47:42.3693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nynlTs6bh+9KoyqgUJ9bQ762dXK9Bs1XXGw441W3gWY8udD56sRdwV9Hvo8rRCZ0EQdSDQyCpM3+yM1lZmtE+zNnAtLp0nzFL/8bgNeZOkLCR5IbwYtSeoGVk1nlydWW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16379
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:47:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19200

From: Biju Das <biju.das.jz@bp.renesas.com>

commit c4e4e22870acae3a3fe3fe0638f85175976dc906 upstream.

Add SDHI0-SDHI2 nodes to RZ/G3E ("R9A09G047") SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/20250206134047.67866-5-biju.das.jz@bp.renesas=
.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g047.dtsi
index 133aa3272d3a..928757b52b4a 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -403,6 +403,66 @@ gic: interrupt-controller@14900000 {
 			interrupt-controller;
 			interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
 		};
+
+		sdhi0: mmc@15c00000  {
+			compatible =3D "renesas,sdhi-r9a09g047", "renesas,sdhi-r9a09g057";
+			reg =3D <0x0 0x15c00000 0 0x10000>;
+			interrupts =3D <GIC_SPI 735 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 736 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&cpg CPG_MOD 0xa3>, <&cpg CPG_MOD 0xa5>,
+				 <&cpg CPG_MOD 0xa4>, <&cpg CPG_MOD 0xa6>;
+			clock-names =3D "core", "clkh", "cd", "aclk";
+			resets =3D <&cpg 0xa7>;
+			power-domains =3D <&cpg>;
+			status =3D "disabled";
+
+			sdhi0_vqmmc: vqmmc-regulator {
+				regulator-name =3D "SDHI0-VQMMC";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <3300000>;
+				status =3D "disabled";
+			};
+		};
+
+		sdhi1: mmc@15c10000 {
+			compatible =3D "renesas,sdhi-r9a09g047", "renesas,sdhi-r9a09g057";
+			reg =3D <0x0 0x15c10000 0 0x10000>;
+			interrupts =3D <GIC_SPI 737 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 738 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&cpg CPG_MOD 0xa7>, <&cpg CPG_MOD 0xa9>,
+				 <&cpg CPG_MOD 0xa8>, <&cpg CPG_MOD 0xaa>;
+			clock-names =3D "core", "clkh", "cd", "aclk";
+			resets =3D <&cpg 0xa8>;
+			power-domains =3D <&cpg>;
+			status =3D "disabled";
+
+			sdhi1_vqmmc: vqmmc-regulator {
+				regulator-name =3D "SDHI1-VQMMC";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <3300000>;
+				status =3D "disabled";
+			};
+		};
+
+		sdhi2: mmc@15c20000 {
+			compatible =3D "renesas,sdhi-r9a09g047", "renesas,sdhi-r9a09g057";
+			reg =3D <0x0 0x15c20000 0 0x10000>;
+			interrupts =3D <GIC_SPI 739 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 740 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&cpg CPG_MOD 0xab>, <&cpg CPG_MOD 0xad>,
+				 <&cpg CPG_MOD 0xac>, <&cpg CPG_MOD 0xae>;
+			clock-names =3D "core", "clkh", "cd", "aclk";
+			resets =3D <&cpg 0xa9>;
+			power-domains =3D <&cpg>;
+			status =3D "disabled";
+
+			sdhi2_vqmmc: vqmmc-regulator {
+				regulator-name =3D "SDHI2-VQMMC";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <3300000>;
+				status =3D "disabled";
+			};
+		};
 	};
=20
 	timer {
--=20
2.43.0


