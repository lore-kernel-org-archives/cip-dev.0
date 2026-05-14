Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131FBCD4F39
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:40:54 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.0])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6983.1778751650974444175
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:40:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=iqPzJVJb;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.0, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Au7DmAbAhOaMG4xTSJh8Qx535JGlskB3b23Qg/oJ9iWxRKf2SQp7OMx0rX+AhzOGbIJTiCWJKlnU85LpT+5IRHaxLTz1leKQmPjjvw3FNJ5EOtAfII3TkuSk2q3vcLEcGcqJjO0+w49+OysTvcEyigyvFgUZb8bs4naJj+7Fz37dTm+pGTKEAPDEw74DsI83XLWY7TYwFmOjQMbiFpLw+ZUkNggOiSmCZ0+kz6Qu45rqSTy4KfEHHXZ2MkeGm/zaJdpOpcIIp6jHA2yKbe9zWlqa7AgqNghtLqMQVQV1oJ4JQcZSDFqNatUB5WDCMG+WmKKttF3kg3sDluNUF/iQ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZhmaSkvj780ZY0X+DPYEsp/7HYZtaCK9NDwgz6zNgc=;
 b=YyqKof7BGcHUBdGjWBoZXJJ956aZd2KxT2wx5GKtxB5VZ9ZjkdZsd7u7QBlRKsMTdEShXJgeXaQi68RMa31kLgEL9z/cZ6cExX6r7RWkuIWD3dtXq6Kgqsa8FQAe7IxGklCIRwmuZ+1r4vzcStIMk+DVPdkmphaUwSVD6x1H1Hb34npaGGQ4iKidocM6Homynh6+k0uV/VXiZMHx7SzQQW73CqhhF046JIjFeKcXQ81XTwLrf1KQ05s6EM4W9CqEaB5MvzKq0vahR39/G8xhkiNldxdwKkbQuUPzvK/zAE2GhPXiyJoSkRS1uWPAXPi3SIkNFBIdMP11XyCkP3AE+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZhmaSkvj780ZY0X+DPYEsp/7HYZtaCK9NDwgz6zNgc=;
 b=iqPzJVJb0FPTLyTivvoT9O9yT/2pwMsRf4oQz5gesoksHgeATg12F7Kr+5ahxVWtudiUgXD2VOGN/DaJHdqGUA/CWHo/MrRYFHotepJSZrfmynUaBNh1kwl6SV/dhFrJpcdFmIgtT41+N48jLG6ofoGo0nAiG+DLCt56iMml+lI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYRPR01MB13674.jpnprd01.prod.outlook.com (2603:1096:405:18f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:40:48 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:40:48 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.12.y-cip 15/17] arm64: dts: renesas: r9a09g047: Add PCIe node
Date: Thu, 14 May 2026 09:39:33 +0000
Message-ID: <20260514093935.2212718-16-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
References: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0033.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::11) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TYRPR01MB13674:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f9275a-ba37-4e07-b10c-08deb19ce114
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|20052099010|38350700014|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	t2ylibOwbD06l8XX4Oi1wfdDEOpFJp+SFQPsIGngeZ+iKHDG7OJDYQ3ds4IvcSglKTG6Go4jdsrJ/7w61fOdUoEQO0uJR8vzkW7lmPtDT3Glpoe5qR7l8e6a8Kb0L3qAxSs+bJ9Xv1aLN1cDEnViD5FLMG19gj35XPOR6Lu3Bq14SPa4fXnMmibdKqrrzGylGSzJbfLprFScIosVifccTq/+mId08nmCBTcA5vnOstR0hyZVEkTQBwQluYGlzr5gKbnSFeTGaPyHRWbAEhN56ZHgkb8cKt5h5ZNU622ufxTS6buD+ORkr+McDYP+wUszKtj9tjuV7zGpvaL1Aat3mYvgO4yYlxSVEC3poY+gsSKLMJcpI7m7mpSs517v0dW2qMruMBjLITLVn262DjHeHQM/MMZZvj45dMt9WlZBc41lIL/bJE0LSLNfI7LfKAiY4fn95hGX5uf83Pc5t2UVDm8R+A4GkTxAFb44c1harXnotpQM4kCq0OKnP8UTgdSQ5nao06a5EEqPpBM/l0CMr7HcdOGD6JLQNtZIYBwZsFx0eI7urlKtS9B9p/TKq4vkjS95J4evPESZTrhLnOB66Z5xwWASn5+qxETohQtwovfgbRV/b7svJky32zrGRgkO8VWsyq3BggbXvgj6jdWaWEZXMuKWBzMwHjQfAV8aLKEBWWRHDVQyYKHLJoa9JOVSFAQNjfUgg+VjzGZTpYylFA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(20052099010)(38350700014)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?S32vOBE0DBykGtXpfkDNvju0xeM4wWqHzn/XdHWLuL6vzwoxRjBLvRsruIdk?=
 =?us-ascii?Q?spArxcyQtinsyNbDBqYaKI54H3q0UW2YOgzRUxxuvWgUNONapyQ9lwaki80a?=
 =?us-ascii?Q?+FP0JUlVgqVtshsyc82H7Kg49AFExrFLrZ+ekIbRfV6jkpdWJ9cYYfT6bfiC?=
 =?us-ascii?Q?VBOY/mz3WnI1V/mDEMc2liKeIGPGnMQiLzDtEUectt3uQeghY7YPLvP8F28T?=
 =?us-ascii?Q?fP3JvgYb4PvUa/F/6+si4iIvsp6j5FN+tYKKV/oGT1oazMzlO4bjWIaDHQhQ?=
 =?us-ascii?Q?MiAeVRZ2bP8PZdWeEYz56kwXECQdcCHW6d3qWvWujL8ML/mWq+6BxwLYLhwW?=
 =?us-ascii?Q?oUE/P6iHqG8Otmb72Y2Sh8rHA5qCmByxMiUa663s2aIk3xJ8wchN/V3+XP+B?=
 =?us-ascii?Q?sTw1G/XVw715/NufFfNhwLsIj4fDiwj7JB0uLi3+cNrsjUinA2By45h1S0JE?=
 =?us-ascii?Q?QMxKu1/6TkVDSLe41euRDvEwpBj0fpdmxWxdzdJB+5c1DCv7RqyNGaBnxwbX?=
 =?us-ascii?Q?eRQwL1b80fycTDJowPJgeN+A5qLDPRrgDws/Aprlp78o58F4+Aww0knyA4SR?=
 =?us-ascii?Q?rIUmDrzMat05oKUhpMtG/l1I4E+eRHn1yDWbHKCWlQlbOaRI71opnhApdSGj?=
 =?us-ascii?Q?OiovPCd+mGymRPl0q1MDGrQ2s9CwXNEvgU64BbV0fzmt+2WLYtlQfwffVvj1?=
 =?us-ascii?Q?IKNc63ndCALep+zyezpK7qTPIAwdJFj+wZtISxj4TpgeVl/3gwxXoRoiHQ/f?=
 =?us-ascii?Q?5hgWo2ePcD78GRvB8TjdrmLlP422pUqHEEck1gTNkVlK+/slW7istbR4Y5Ep?=
 =?us-ascii?Q?EE/ZFOMYWDRJ7I1TCLQ6c+P2+KTKcqAzWx8FajoFdwlAhzP/vZcb3mYuIsWY?=
 =?us-ascii?Q?NZFt35kJM25Ro6vosNse9NzvnuKHSnqoXoJwOJkX5dHj2xnV6jfg3GSPNiEX?=
 =?us-ascii?Q?qQu7EQwRx/2QqKMLHgDbfUWY/MAF39amhI0/+giajCUugtH52/J37/HbuXlp?=
 =?us-ascii?Q?g55Auhsw+D7U5le7NWtywuSn4CSN0UvzIxGEBI19ecYdmABhXo+LIEfdmCbx?=
 =?us-ascii?Q?fLTiNh2JAuGCN4GJxEd4IIx1i8S/pqPM09UP6p/A5PrIFGWD0W+fPMHj5M0T?=
 =?us-ascii?Q?TPM8MmwtaAhjQgiuqFMyUvIedTQ1NJnsuqD9G9Ztn4T4+4lB0OZqTwny8iUz?=
 =?us-ascii?Q?RmfX3QOZzhK7d3gNCdfyx1j9CmHqa084EGD9t1dsVQ8vVFRmxzgzfICvc82M?=
 =?us-ascii?Q?HSd++hoao/ndVra+PX77nFP2t8xf66hpScG8hWItnMVGljRk9yf0DWJfu0Hh?=
 =?us-ascii?Q?3YW4jKF8faJ6ikRReImyDEYIuQ0LOXoP3EKhNq4kY+6DNtxZwvYrn2YI7Gkl?=
 =?us-ascii?Q?lp2tOgcSMoU7YBCunmFQIIlL2WfeyEYyMVd0u+kxupsWJOz2IJQyyjrUgxp1?=
 =?us-ascii?Q?HP6HLB0vOVJ7Ub1UZFRz4g/TqQoC10+SomNbuK2Z9bjyGrqxyNzt5BjOD9LL?=
 =?us-ascii?Q?ZFLNM7vhaTQq4RPYYvnXY+TRr2GmmjhqjMCOvuxf1DAf9a2chN+HtZmqLAFd?=
 =?us-ascii?Q?2GU/c2FXHQwaWKJPE2zidAhxPndoUJFZhtM4So6sMxMPUWPJ2sX+/rnWNSbW?=
 =?us-ascii?Q?x6sQT3eyjZLwlqq/lJrR2btop4X0JyU+gu5iMgtgJ/hIhcbKEsLH/2DZxecO?=
 =?us-ascii?Q?v+cnRmopvYZHgRJfb0o20i79SI69/p/cpN37MoIqzIFVsyOBNDYA3p8/+szQ?=
 =?us-ascii?Q?hyptuLjaj3ngXg0O3N0fTFVg+eBbJhw=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f9275a-ba37-4e07-b10c-08deb19ce114
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:40:48.5859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: enc4/ur2xgWwPGZBIeFOhpSLHycFTseClbIx8MPJ5KnQMxFr4fzt2kLXjcroQZoOnile3nL6v7QDoK1A0Z2IkIvmulP8hBQUmvsKiggDf54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13674
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:40:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22949

[ Upstream commit 1ac57c9830cb0b586387367f88dbb10d21ec166c ]

The RZ/G3E SoC family features an x2 PCIe IP.  Add the PCIe node.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # RZ/V2N=
 EVK
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260318085119.44717-3-john.madieu.xa@bp.ren=
esas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g047.dtsi
index 0a2fc3480a43..cc0dc3df9e7f 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -841,6 +841,75 @@ wdt3: watchdog@13000400 {
 			status =3D "disabled";
 		};
=20
+		pcie: pcie@13400000 {
+			compatible =3D "renesas,r9a09g047-pcie";
+			reg =3D <0 0x13400000 0 0x10000>;
+			ranges =3D <0x02000000 0 0x30000000 0 0x30000000 0 0x08000000>,
+				 <0x43000000 4 0x40000000 4 0x40000000 6 0x00000000>;
+			dma-ranges =3D <0x42000000 0 0x40000000 0 0x40000000 2 0x00000000>;
+			bus-range =3D <0x0 0xff>;
+			interrupts =3D <GIC_SPI 800 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 801 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 802 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 803 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 806 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 792 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 793 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 794 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 795 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 796 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 797 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 799 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 804 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 805 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 807 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 791 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 798 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 808 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 809 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 810 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 811 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 812 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 813 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "serr", "serr_cor", "serr_nonfatal",
+					  "serr_fatal", "axi_err", "inta",
+					  "intb", "intc", "intd", "msi",
+					  "link_bandwidth", "pm_pme", "dma",
+					  "pcie_evt", "msg", "all",
+					  "link_equalization_request",
+					  "turn_off_event", "pmu_poweroff",
+					  "d3_event_f0", "d3_event_f1",
+					  "cfg_pmcsr_writeclear_f0",
+					  "cfg_pmcsr_writeclear_f1";
+			#interrupt-cells =3D <1>;
+			interrupt-controller;
+			interrupt-map-mask =3D <0 0 0 7>;
+			interrupt-map =3D <0 0 0 1 &pcie 0 0 0 0>, /* INTA */
+					<0 0 0 2 &pcie 0 0 0 1>, /* INTB */
+					<0 0 0 3 &pcie 0 0 0 2>, /* INTC */
+					<0 0 0 4 &pcie 0 0 0 3>; /* INTD */
+			clocks =3D <&cpg CPG_MOD 0xc4>, <&cpg CPG_MOD 0xc5>;
+			clock-names =3D "aclk", "pmu";
+			resets =3D <&cpg 0xb2>;
+			reset-names =3D "aresetn";
+			power-domains =3D <&cpg>;
+			device_type =3D "pci";
+			#address-cells =3D <3>;
+			#size-cells =3D <2>;
+			renesas,sysc =3D <&sys>;
+			status =3D "disabled";
+
+			pcie_port0: pcie@0,0 {
+				reg =3D <0x0 0x0 0x0 0x0 0x0>;
+				ranges;
+				device_type =3D "pci";
+				vendor-id =3D <0x1912>;
+				device-id =3D <0x0039>;
+				#address-cells =3D <3>;
+				#size-cells =3D <2>;
+			};
+		};
+
 		tsu: thermal@14002000 {
 			compatible =3D "renesas,r9a09g047-tsu";
 			reg =3D <0 0x14002000 0 0x1000>;
--=20
2.25.1


