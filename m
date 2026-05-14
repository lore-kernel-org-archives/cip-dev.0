Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D764CD4F25
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:41:04 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.26])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6984.1778751654130198457
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:40:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=YSz/ZkI4;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.26, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfHkaRcwS6/WYZCBlX7IUZSzSmjRTuT0xDt7a8oIPC2BdKCp66NulMvBGTcRVTfFDjmpq7s2MyyAUE2NGKn2GqGwfiNE+UQWGeB14uxQCdp4U0wYeUE/K82+0FWpV53crVYBsMZuUF+7u1pyMdW19fIMR5MhfPOvQGyz0UK8R7VN3eNIyFewoCfy4y1jdc/WWuY45l5apGJz9qcYA6j6oYUuAfa6lHNsZsvc9yc8G2ewMAAKYUpADLtzuG6jtm4eUmM5YpEScZqc8ilcdvoMaaNhHH9O8lCpbtOnd/xkCG9w32JhWU+/XSxs+3fU71jEdAUWtOs6BbObfFE9IcckDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raTNPBYXCO+Skoe4rL466KUp1Yu+SHNYc+/Zmbn8sck=;
 b=XsgG0cOwF6Do7dTwN48awgChkLQ1w0Z2iPE7F/HO6fci/PhNa42WqIxjX6mal6Bv4hhOkQqOCKivETWv7FAJonlgLGAJ1jCOMNT+RDW0INq8njYvaZWaQBii3adTlSxoI9asaGKfAfWKDSsedZl/kEsI3k4kJxb7Dm2pEtmkXToUMJudWP5ycO3grV+Yjy4dRjolJFcsGqYEPJYSOThq5J3x5PYCJ2pt2R3lqE+5v39ajegfLQttiIzy6OHpXbpA3FDUu2VCKTneqBeYwbuN14NifelnVKvDsI939ECIO5vmEgKc3CcZFQjiskDKTyugp24mlCyjdMAJW8/r2Xg/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raTNPBYXCO+Skoe4rL466KUp1Yu+SHNYc+/Zmbn8sck=;
 b=YSz/ZkI4Qkrdb3bI4+ulWLi4MKxd0EH9iX6JU0cPe9AavfmKoN2zLcL8ny2I6rYmiduLmxjl3HAndD+DZKr3LX38EO+Ca0vU/9D+fhqr65n/CrMc7Xa8tDV1Ly0z6SUu+P3NCzoEkbcoPESrJUDegez5reuAqRtbCVA9GPxmtNc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYRPR01MB13674.jpnprd01.prod.outlook.com (2603:1096:405:18f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:40:51 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:40:51 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.12.y-cip 16/17] arm64: dts: renesas: r9a09g047e57-smarc-som: Add PCIe reference clock
Date: Thu, 14 May 2026 09:39:34 +0000
Message-ID: <20260514093935.2212718-17-john.madieu.xa@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0c846d1a-7fe7-44bd-76b2-08deb19ce2d7
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	FSEyzFvCDkl1zq7KCfIu3z9AYgSHiw3QXQHio7bi7qKUiBV7YZjG4XDvthg7y6Omfe5lD9qdsEBaQeaKiNDh+J1wO0JM3cWM8T9vZhQ8OXiAw9lIcgmKyycwIk4+mbcz19JpILnfxMAj2xKxd2hO5k8IuKMyX7kkOZB6ZCM0p9TDLOZlHn+d+VHQ+Sxyrz7+TxEbxejmIQRYxmv2zjm3bClrX8gvBo3rcpF2DHI49vYDIbsB0tKyRKvY5dQRYSJzeSA7SlWfG6ZQN3IJrenWw4d9MutSGKfW3mhO0XxvNDe/S/hI9LS47Qoc8ZZ42AQE7d20C1d7js7rmBQRDFpcJQyQVKT8bpS7OlEOKFbYkEl/on0P2MrgbllPDj1vZkxxaOFcNwLjTXv9N0TVtrXZyoX/C/Tfqr9gVT47ZqQoyA6AYUwMyFK2JbeqbaH0HWUCk0CKGTrSrcwzgvFYe6ouFY1pVtSvFb5kG9VgjB/zbXal8PqK6vtxLu6a1sBqqdO9pL9WnsSQkx4R+bhuDrqWIUroPFSlyGI3Rg815F5uSb1pMysioEHLzTtS+vPjgFuTR28xuGGV71s6imNp85/UCSUZWHEHjUtm+K8mEYyM3r+oBEn7zM6WZu3rBEzv06HnlJcV1ujsWLl7yhW8NsYgmouCXbkUW/GtpRcZ8IpaT3dcg3GcHiJJgY0dsc1A7XIXSvuQcXXyDlFZ5CQt/07ARA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WJZGEyNZQhsdHKq87y4lkpCponD9Noef5u0Ube6Rd3n87LCxbPPoFFG11ywc?=
 =?us-ascii?Q?Tj+5yeuTHcu+ifPpYrCrE6wE8aXVIAG+wEUxaaEL+mmqDMCRY86RUV0u5Cbi?=
 =?us-ascii?Q?i0iye+2ZcuIS/6XuztPxkfe4kznIxjUCsJoAfFfEMkegKWNMFnj35HVqABuU?=
 =?us-ascii?Q?2Vbl+ITH9igjQztLIQnMaOjn/eGgsezeQjipTGEDcYxH/M1aalqWVoHPC9je?=
 =?us-ascii?Q?ZeHxImVLWfNrJQNoiHEgOVrEVyhQlYvjOWfKc4l0wd9mByPHZxqrz8LoaXMD?=
 =?us-ascii?Q?3tqKR12aTKcACWeesyQpBBwOC1ZGJr+K49BeKvxrzWEvD/+MeOt6WMrvYVWk?=
 =?us-ascii?Q?dtoY26kDSSFxA5iGlOpdXkyMvLbextyxRoAoG+NgmkdmPbhm+NTxLvB4qvI1?=
 =?us-ascii?Q?wcBwl4OgnLOsFQRBEmU1mQ2qzHZUufgNpBajoT1mOw/RWzPBxwnfri0Bh0Ys?=
 =?us-ascii?Q?KmVbvzfoZ1D5A7yA7ADJLyx0AYiolC2QBtSq9CedwcIevBluF3FRw/nTGFok?=
 =?us-ascii?Q?tx3JPV8v9asH//VxzdoUf0QkiIyQQE01/vVWDSQVBw25N9n9S5cw313RwCn9?=
 =?us-ascii?Q?0w5ByvXFI6zjPsoYYvfH0pqpgDk2tKjWljPpMFURewCOgz35hk445Snwdwrh?=
 =?us-ascii?Q?uiWrNYGRMPTAT4gSsaTk0ohdWuTDtjOBVhhlHv3ocDCShdbv55WsM150E6f3?=
 =?us-ascii?Q?1hanOniphu1sCx+Y5t4T5Een9VyHxk6bwLLbcxQmOp9jFXKQa4o3HvQiN5Jl?=
 =?us-ascii?Q?Pg8S8UnBDCukNShbMm15vhDQ12eh2O2+49VfQwkA+dThNaARQSE8xYX/g0ql?=
 =?us-ascii?Q?4KBf2cFLp0XnzdifIfEbCN9vkufM3dQ2CGAL6dxTCbpAYyIIGMNpm1abYMte?=
 =?us-ascii?Q?hq0EnYcTxuK03BbAxJWfZsilCo1c/ou5QwFW0Xiic90tv2QmwrZ6+pkjz6V1?=
 =?us-ascii?Q?lewAuZnE8aR0Kfrf0cf2QDWOxEEK/Pw7YJdVd8NXfJYF0zARKTUQzfV05+g5?=
 =?us-ascii?Q?py4fYKhZfJbBamg6Y7teEKd2cztxznU3Sa735XYsSaBoyQJ54gku4O5QyNGu?=
 =?us-ascii?Q?N4VT9lH3NpPjua44E0BApFEtLOy3jHS/gdzKj7Br9x8TWuiQ7VSm2Q98Dcem?=
 =?us-ascii?Q?HXTMkQ51IqGl8xlYv4BzRyZDGBd3CylAHUpxk2XP7dthMAz2XvLDTv8jkB50?=
 =?us-ascii?Q?qQq95mBdQIFJT6RvL0gaB8nblJ4Y50QtuTZHXF0MsclsSaLGSR16bLsl4sWo?=
 =?us-ascii?Q?uMyPbFRCjkdko5LIZGD4XRZtAfym8PhxAfpehYT9fNXVa2uqiyAdPk9q3fyc?=
 =?us-ascii?Q?lHlFUyLrakOQSG+uUAtfTaimxC8k35D/+IIbfhDnVYW0NJTPv+Wc4ieqb8rk?=
 =?us-ascii?Q?XXr0IwxT9VBZR2v3jdqx6gtF322e6Hss2KvOEbOnngYvmu1oFP5GttZXQ2XH?=
 =?us-ascii?Q?vBcfL9/ezrLn+CgDfh0eWzsaSJUylv8VOMbJMSNLLYjlha/M1D+apLAcSgjK?=
 =?us-ascii?Q?6vO8SD+eMCXtTrearBikgvgfBif6tYUKe3IFT35N73ET6YAix2yNfbFrL73N?=
 =?us-ascii?Q?BqiQOnBo387d/KPDW7H4xboSUTAjxook37fKVp5XnAnEbCte1lQs9kWDWDQR?=
 =?us-ascii?Q?j7D/XeWbqKtCK9m2SflW618WWmXfDZXfT4/XQgkNsxo1Lf4TzQjmkGHTtHWc?=
 =?us-ascii?Q?MUV66a+qiV4xdonEVu3/HXoNER+h58HBLqhSDHQC5HT0hIvNeWW56usXl9pv?=
 =?us-ascii?Q?jzDn5huXDKDFmOsw75XiSI0e2fO1yfA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c846d1a-7fe7-44bd-76b2-08deb19ce2d7
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:40:51.5285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FCL6vNX++Tr6m13ZuKdtQMdT5ys/7QCYYJG9lQDIRn0idLpI3FMxaYWaWkD6yB22UrI+OCywtEJSYeX9Ql+kCJLKESsC9fJChHuNnahIxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13674
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:41:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22950

[ Upstream commit 8af9fd59cb7737ca1c707db8e72774f5fa1576fd ]

The RZ/G3E SMARC SoM has a fixed 100 MHz reference clock generator
for PCIe.  Model it as a fixed-clock and assign it to the PCIe port.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # RZ/V2N=
 EVK
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260318085119.44717-4-john.madieu.xa@bp.ren=
esas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/=
boot/dts/renesas/rzg3e-smarc-som.dtsi
index 3b571c096752..0eb0c6e92fd5 100644
--- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
@@ -43,6 +43,12 @@ memory@48000000 {
 		reg =3D <0x0 0x48000000 0x0 0xf8000000>;
 	};
=20
+	pcie_refclk: pcie-ref-clock {
+		compatible =3D "fixed-clock";
+		#clock-cells =3D <0>;
+		clock-frequency =3D <100000000>;
+	};
+
 	reg_1p8v: regulator-1p8v {
 		compatible =3D "regulator-fixed";
 		regulator-name =3D "fixed-1.8V";
@@ -176,6 +182,11 @@ phy1: ethernet-phy@7 {
 	};
 };
=20
+&pcie_port0 {
+	clocks =3D <&pcie_refclk>;
+	clock-names =3D "ref";
+};
+
 &pinctrl {
 	eth0_pins: eth0 {
 		clk {
--=20
2.25.1


