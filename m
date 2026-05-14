Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CE2CD4851
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:43:14 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7035.1778751792839156177
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:43:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=nUCWV00O;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.43, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ms2zRNsXgH7RJyd5OA4fzZaey729ynK6jWgWqQPGt9KioBkAjMrKKiUehZGaMMjtPo13IyuXf8uhPx7VjHv0buAqsgI2jOB0qqM20sZKoBLX1R6+/TC2mUGEsiQJXS7X+B8aSNbrXg5Qx2WV6DKRgTPTWE//YM7XMi8m8tFv/1clon2mEm5JYO1084jxp+nVIeZMvEx6c1+yLfQiFtiWvpC5Rdu7G0aV+nFPeuA1lxk9b8KXQv9TkLyEcViKETR1apkA3mPifxTAXF9eY45Ebitjr7IFYEOhUGOOM1/r6rlUIqmyghZEBcgG7is39hB8BI1zHDCZgXsRVKeiTtd+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yb/poaYCi4OeLqsR9rDkvZAR/NgwcG1SS2Qiv7hmDIw=;
 b=VHC3lkbkFv423vyeuwTJgG7lkJKgewvBdqUaGK/R0GKEelNQ9MTbQvRT+oTM/2gUYiCrALc9NUH/Bj5+AVy3bMqEaAW6a4oaUCJ4jG7l6wNLs2nwcPleVeMSkESeXgeFctvoOGjRtfdn4aO1wjxYVP9bz04nA6AqVlDcn7owvfz2hy2cvOw9L3t65BsM3LoZ4ZsRz2dj66vITJTlrGoLJiwAYj9LZ+6LwhTKrLa0qkI3LiwYRbztcaDQrhKRxd3i0BnIt/o0R+VyyX11RRoaiOsGSeS3mlhgdB+yhxVMKtxIxnZkBdpx1UGUZKkVBKJ2Z/+45jRa0YDhIpSo9hg29Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yb/poaYCi4OeLqsR9rDkvZAR/NgwcG1SS2Qiv7hmDIw=;
 b=nUCWV00OgiY8dtOzfr0HrTdUq+5MJ0/z8NhMMwGctfBP9TLtC20tjqVkk9ZsLKUIE+EPJjPOtEcLvAgwBYkPtTnJgQEUdSJMYhNfTFwoAl4zAs8YQKf0huaGcmXISKwbZ9mJQSNbznIaVFV/8UaFqsM3g0j9gib6O6JQ9IuWPwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYCPR01MB8192.jpnprd01.prod.outlook.com (2603:1096:400:105::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 09:43:11 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:43:11 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.1.y-cip 17/17] arm64: dts: renesas: r9a09g047e57-smarc: Enable PCIe
Date: Thu, 14 May 2026 09:41:52 +0000
Message-ID: <20260514094152.2215176-18-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
References: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0025.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::12) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TYCPR01MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f380b3-d787-4574-0c70-08deb19d35fe
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|3023799003|56012099003|22082099003|18002099003|38350700014|11063799003;
X-Microsoft-Antispam-Message-Info: 
	ee0tNjl/LuwM8HJszw8tgycaqfXiV5UQjx69YAL1kFYxpn1ePV2/zmBdsTEv9a2qZOjhkxsBDTKeCR4HWMAxBhBuHNHx9naIhdX7zrjKiG8l/WdZ8UsWm7DZ7yRJJUp9ZUaFk1I91VY3YsVDfWYtEYKRcnxrGu8mdtMXWUvBxzIVwqyqECZv562t4ns1Yx1hZhMczTZEznteWb48ROIKu0v+R0tJEIJV+sPioLaruyYPvY34AoHLtamweQjeBqtlsKZpdMIFVFyfp92g15LT2a8wheZXaawlbRDAO8ReVeZi/Rt4v4BOz/Jsr6ET47eQ/34lieJamz3Zk0Xukl/Mw3y8FKi0KaevpgULzR8URsOyW58F0LoCEXmBlnjpZARdi0Jk8+2IxtLIEO9yAbM2IegpkHXRHOdD1tOdOijh/xoaUjzySNlUxvRcxRSHNp94F/pM8/FU1e6LWFQJbg7M0/BUvNXQHE7trS1pBKTz90RrWmCfkcQgEAznGLdtFs0jKUmJ9GD/rRgCGxVi5fnX6DzlwLsolVI0H1ud5IV60Cg01nXKRnymSTKGSaz50i89wOyfGnQvsIOCqcv3y5U+3YxBd5utwW7hl9Bf5x/36LevZ41WsvZYJpp8vocx0lRgA+UfPhbYWAsextZ1OE7imLFgGrthzW67J7qKVaq/DyOSKFd59aiFL5WsfHTesqe7puWLuJCs3S61aU3gKw14yQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(3023799003)(56012099003)(22082099003)(18002099003)(38350700014)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vydJvNBim9MqWobPNi36uCyrhhxr9bQkyIkDkPxhWx9XDfvXWEHatlC/aqrY?=
 =?us-ascii?Q?76yBsfd9izIU5mq5Uc8ZKbp/4ylIGK184lfjkb59mABVbFt6hUPyQnlM9ubU?=
 =?us-ascii?Q?6RXmOcEq3uKsCh3AvT1ay0zBJhmQmjF9ucqpeLkIcsSNrSuLSBsb2itmK3BA?=
 =?us-ascii?Q?JbwE64gbR5VU+d4FKBawr4XmOlpwgvOWfm1yfKa9KYmE80nGECJHzXZSNvik?=
 =?us-ascii?Q?pPIE6GTa3EFG4SUiAr30S7+ddDwkJ/ieFbCVb7SAI4fAni9PDe/dZzj3N7ui?=
 =?us-ascii?Q?wBpKeie2mEW0Nq++a4i8DVb89Zh7rt+h0/OhsmMIEexc4yGz4wbZc7fRPhWf?=
 =?us-ascii?Q?cm+A4XC8kpfZT2z4Rg007034+f5sICMTtrjG8ixGGT5cW0VxvIfVASH/t+U7?=
 =?us-ascii?Q?RchwsgqXUXSicw1ihW39B6bGxzcplQkvzM+cGVQIMWgV0vGDumbCiwRYV0T1?=
 =?us-ascii?Q?cgozJoRfgKzH0MelmymRRtHBb/s8oUCnWKWlGdLB+D/ELjnsFixYVqjxSHDR?=
 =?us-ascii?Q?aaPAk8tm6xHpRnvoyaxP48wgw4ZBm5SB8Gk66L/bD/fnZcf+AU8Pd1c3jgzQ?=
 =?us-ascii?Q?FleJRIIq1oiz25IYlUW4YC7Gw6ei4o57ILcWGCkRs1dBFI6qBsL6NEHOKzhF?=
 =?us-ascii?Q?4DXOBf+bWdLsjQyQ0LPZXisoTWzwUfQP6ATf1hR/EqDeg6/ETFA18Fmbkup2?=
 =?us-ascii?Q?S58Q6bHPuKC8H8EsALSTSiftPNedQrBsTXqQ91SeGpqZPQMGo4hBHell8Fqs?=
 =?us-ascii?Q?f+L5EuWBVRd+kDDTqoDdTzCRafAsnxd/lhKP2kPaNoxJn3IbAbUvaHysFPeA?=
 =?us-ascii?Q?cpz7g3ROfZi2PjEKCNx9iw7uimEcaQbzv+Y2/MfZlnAjpGDdmw+by7Chfztm?=
 =?us-ascii?Q?TQGUACSiVf0yovpLawAdLsItg5ukBiNsxfy6KnGGiKMJIBVM2624QswgK3YA?=
 =?us-ascii?Q?MaOlaf6+D11Y5hp3zvGdViE/SYq9T5a9aivQJblNbPd8+YVOP0TMMm+CWbUQ?=
 =?us-ascii?Q?H+xzB8pfiR9irVb/KsngEMueESdrr8BD/DQq6+zoC4sVCNrrOc1q2jLHMj0B?=
 =?us-ascii?Q?FnPVK3zgmMoARMOPIzSlQTgD5uZ4yWMoc8ikBm9TWEM6rN0Ji+smuzyecihz?=
 =?us-ascii?Q?FDx6sWvVp5DEkQBR5gMak0R8DWCgl+vsDzrBjQelZSSeBxmCOkISOuaH9i6o?=
 =?us-ascii?Q?ECNX2WcvdwRipH1ka+MXQHO0uGxmSqJnvrKBPXQAuO4eLMLyTSZCR0mBXeFO?=
 =?us-ascii?Q?VVwMOgh1lO9gy+VB1qednKg74snQRLm1M/FsaH3rLKP+CwxxSdJxlBA6GFUV?=
 =?us-ascii?Q?qEeEthg4cVbFuLIGjWWwGIWxLvIZ8zV9uYqeqYcqwKXRr9YyM3T8ndnX1xyc?=
 =?us-ascii?Q?QBPekJohlvxz40sK/BPSErN+QC5z/cDiPwShwNf2FPHTX1h4mJ3Kq5DP5aUD?=
 =?us-ascii?Q?4Q7iMjdNl2X/ShuZPTMJcjHoFoNtKAy9pUuv9YMRG4pY3Qu48QchZHCwYnYZ?=
 =?us-ascii?Q?uo+/on+UVL0uybAnblWqSjVNe4yNfCMyd4EYqvXoOlCGMUiSQ7S3O4PEKoAm?=
 =?us-ascii?Q?+NNUw0/8kqC8CtUfmTMXnCG7aCu44kxgwRvZgTUH43yI2VhW9DCfsAyjypq/?=
 =?us-ascii?Q?2BuHrcLRF8bqGKuU7IIshbVY61p9OJmZ+f3bpgoaZrm2wn//ySoWwl7AHLQF?=
 =?us-ascii?Q?psMU3cJhiBQzFnJsrMCnqe2jNB2VQLs4TBEKtkr22g0Cjfp403gfUCNUrD4Z?=
 =?us-ascii?Q?VMwc2DCj/6XDJ69azizg0NkAMyHtDMQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f380b3-d787-4574-0c70-08deb19d35fe
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:43:11.0607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VtjFv/pU7hgcovnQkXsL8e7SVBDn89sYbbfNMvOBPcszJPJv5jbTe/tqoHW6rVO9e9RC+O3dKiYKJ4DCAJQGteWCVcQxNHQGCEEIfg1TwY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8192
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:43:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22969

[ Upstream commit 092ff7ab721d2a096705b3ebb9501ace31184f50 ]

The RZ Smarc Carrier-II board has PCIe slots mounted on it.
Enable PCIe support.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260318085119.44717-5-john.madieu.xa@bp.ren=
esas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[john.madieu: Fixed cherry-pick conflict]
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 .../boot/dts/renesas/r9a09g047e57-smarc.dts      | 16 ++++++++++++++++
 arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi  |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm6=
4/boot/dts/renesas/r9a09g047e57-smarc.dts
index 8ee74d3d05d1..c303f7c66e42 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -130,6 +130,11 @@ &ov5645 {
 	reset-gpios =3D <&pinctrl RZG3E_GPIO(D, 7) GPIO_ACTIVE_LOW>;
 };
=20
+&pcie {
+	pinctrl-0 =3D <&pcie_pins>;
+	pinctrl-names =3D "default";
+};
+
 &pinctrl {
 	canfd_pins: canfd {
 		can1_pins: can1 {
@@ -153,6 +158,17 @@ nmi_pins: nmi {
 		input-schmitt-enable;
 	};
=20
+	pcie-clkreq-n-hog {
+		gpio-hog;
+		gpios =3D <RZG3E_GPIO(4, 5) GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name =3D "PCIE_M2B_CKREQ";
+	};
+
+	pcie_pins: pcie {
+		pinmux =3D <RZG3E_PORT_PINMUX(G, 7, 1)>; /* PCIE_RST_OUT# */
+	};
+
 	rsci2_pins: rsci2 {
 		pinmux =3D <RZG3E_PORT_PINMUX(1, 0, 1)>, /* RXD2 */
 			 <RZG3E_PORT_PINMUX(1, 1, 1)>, /* TXD2 */
diff --git a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi b/arch/arm64/b=
oot/dts/renesas/renesas-smarc2.dtsi
index b607b5d6c259..e2a34577a1a1 100644
--- a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
+++ b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
@@ -96,6 +96,10 @@ &i2c0 {
 	clock-frequency =3D <400000>;
 };
=20
+&pcie {
+	status =3D "okay";
+};
+
 &scif0 {
 	status =3D "okay";
 };
--=20
2.25.1


