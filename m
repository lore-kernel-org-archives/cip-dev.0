Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8839C7EE30
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:36:33 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.15])
 by mx.groups.io with SMTP id smtpd.web10.20515.1751452584341455288
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:36:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=YJzcC1xl;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.15, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFfC8wYyFQW3DzuAk58MEQve/hjJLIbvN9cHA+vYYOh46TOR35VAzPsC6D+I1KvsiFJoi+/W9jnXMy/9F+8X2ag7NXzh+hAmQvcsTq0HWsmZlNsgzkoSBZNm53Ap6kZQcQngJG18ceVW62unRowNMWE1ViJ6uO1+RQpF2LXNvndEqG16wjw+3XMV83CGnTnThf/1XjhmF3uOEcz97CnxuP+IyvBqDZW08xr1IuIHNTeOX5QecBUmnlg9CQENDlaZRc4ZHwjLuePRqT4orNYajwLWgQkTV3UVhx0KIaxAR6pOx9KWIxegjdnwqgo4fEjm5T3LZO4RJQTBYsJsXKS05w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILBohkh9QFIJjq8WPxEL3/xY8TIAZMxOJh/AVzxSmC0=;
 b=ChwafcnhIMcvHRKJYbtiVSzYFn9ntn3cmWyTRfoB6ypKFM1zVqz8Wn+elXEaNSSnpfPz8lMhmJ7DlFrsztTLoVZK9WfncisHy/xN9HronPdhq0lhVzVWV9rTwGryh1iGOtYXB4COFlbIXsimtZBPwYKwv3ncB/rroMHLeZHrxf6/6k7wovk1NYSFbW8oYzEQDQtFs1Vzc06jA5pDtGjL0XjkisGaOdXZgmgosn/q2/h9hKi0uUTZM1yrUN3PpqYuhg/y+nxTljqzWBqKwoNS+jH2Aw+Kp+u6O+EfVY9+C++qu3bW9/kgEl7Q7c7OJmRyozzuSVMSxFGB5J2utuC62g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILBohkh9QFIJjq8WPxEL3/xY8TIAZMxOJh/AVzxSmC0=;
 b=YJzcC1xlnbZTQhns/2VvD1tI8Qr5P/CZd+q3trMSKRNK1j8U5063diNLZ9306wfouqDxMoXli7w112Ibccb32M0nMA+0CDcIOEDe/BJhb8pFiZKfUecu07nraDoGOMgE4MW62nR/6+e2u8zXwrw0UIJCYpMcmRaURKVqi7P7Xgc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB14154.jpnprd01.prod.outlook.com (2603:1096:604:363::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 10:36:22 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 10:36:22 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 12/12] arm64: dts: renesas: rzg3e-smarc-som: Enable Mali-G52
Date: Wed,  2 Jul 2025 12:35:25 +0200
Message-ID: <20250702103525.117166-13-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 785b45ef-aec4-4b32-3f86-08ddb9544990
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?q6CZf+XLNrNI+1Tf/VUZAJ5FcPbHxB/VaEm4VsW2ebWuUTRR1jmbIc4U9QQh?=
 =?us-ascii?Q?8/8Yvm5aCf0P6bMiFOljE+JsGXfVDXnT3+YaDJMCcP0YLxK3ysrBsO+pYtkT?=
 =?us-ascii?Q?DMQYt0nG8B/nuDBA3TLNwGH4IJqX6+8t2rFRRlUm+jl6Z5RbI+brt2SNz/1H?=
 =?us-ascii?Q?g1KYeQjMAk6U2xjDP7wmTMSm60UbfqBGuJt1rZzaIXulfjc7ft3olFjnJQPP?=
 =?us-ascii?Q?rUp2P/GkEjD4LxSiLUHIuxDAsFpv+l0dIY8CSDyAHMdD/bX46rX5kdPdXbHx?=
 =?us-ascii?Q?ianFSQ0RlqnSBCHA+dH25cb7b64qq7dEnbqHbtTMsKX5kfEXkeASpIYNW2vt?=
 =?us-ascii?Q?GAPJS++Dw7+bUECkaMu+3tM+t3ZuO++O6tn66JwtwcmvLwh6KnfbtbCMtELt?=
 =?us-ascii?Q?A7WlpIGUYF01iyR7NT9TDcghpohwgkIdDUzMsEce1MxnL93L0Ks03aOF8qj2?=
 =?us-ascii?Q?5L+Ka5xk79Y/D8KdvND3bLng4u+lMjAmZAzOAvo31+RntBIWqbFx1tKkKSAp?=
 =?us-ascii?Q?nBkQ0bCvk0jL2cZkyixkF85oioumCC0zrkcH5MjEwIjjNcTCwqoxdUSER/kd?=
 =?us-ascii?Q?Jk54ExVwWSHrcW+6iD2YCxKk4Qm1tQYaB1cE0hjOcaMqbPjympevjVgR8rb0?=
 =?us-ascii?Q?mMu2u7Ii7FgVwzLJZvG3BJKegvZuNzA7aR/3l4ZRdB4gApPwA2Pff0GcN6AG?=
 =?us-ascii?Q?JHi5zPJbONFELj23V8Mnqc4qEPv6xdlbFME1G/xf3wKjf3VCEtUUSGRMO5eL?=
 =?us-ascii?Q?uvbOMzuQ0q/zrNxHrM+wc8M1np+Ail7wyKIb5AyEgItTcRC4MDx+lEZE+A+d?=
 =?us-ascii?Q?6dG86ZQ6VMVUIBburcLHTNiNm+EwxClUbVgcGmwR4SkNhy9YsjfnNKTsxUUi?=
 =?us-ascii?Q?DS/gwV44j2STlCfhA3uMCCOb3/GIRBXzAuJ5oIizJotYh0I7C0tqLS3gdplU?=
 =?us-ascii?Q?Mm+zSeoGMaUB5h/o1LDisKW9xMN6HMPjTc+xZjMS/FEvKPjuppiaVxdtxmBR?=
 =?us-ascii?Q?L0fEu/nqC8ovx4fzKGGiTol2x+lGPINxvQIdFlWyS31agQMJi9BbyNnpae2o?=
 =?us-ascii?Q?X9EQ1O9SGBK2m4GyeVASjqxQm5oJF/1A2p92TM82JJb+mj5u2PkfTUlz9TwV?=
 =?us-ascii?Q?R+zTVC3OYkdRFlAYD35cG1j9mnnlAD5r81zjI5eMUU4+KTuB+2lzH70uVQAV?=
 =?us-ascii?Q?Eu1uPMeiG61v0JXWxewmGqBVk+HauZqCXkBAbefFDariBanK2LTUg/bpSngK?=
 =?us-ascii?Q?SutIbI64giY6G4ej/wL/qxjdhcOi7gIDhbcnomnfSYGmZgUFUyFdX4yyehKB?=
 =?us-ascii?Q?dJTDS22bouMPSF8bhtXfDgaeNvDPjN0FicKmrQ9Ef3wO2bCecQ9bmKqYKCph?=
 =?us-ascii?Q?ECntSLCN0njvwcQrbPbyYurFE2jD/JzKyX6gNVNq47tKYZsd64wEu4qZOJhE?=
 =?us-ascii?Q?0+Jfyx6o66pf+N3K3XpsobyO/n69hBXKgQ1RFq/ZgAasv6dAOkVtLWMKKAUh?=
 =?us-ascii?Q?M7T09kpffZqjZTs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?A9SkqGjN3CZES0d4SBV5+sP1lBD8VsB2xONeHNqanp7AktU/w6Dc4B2if9X4?=
 =?us-ascii?Q?dnueMfdHsc9URg+aO2umHlQ3PBgCmmzX7PaarPGkQ9SEwxtQfR0nVupjkxb3?=
 =?us-ascii?Q?1cUSe3CBWnQ/dmkX45vknt/RQQtNjj10ynUglcIu//5FpwUOe4k4HRWtvEnG?=
 =?us-ascii?Q?3HhNRGitfnTprMrs/XPBH/WBA8+80oBThd53epIR0QtNyVbEZLS5wJiVMWVr?=
 =?us-ascii?Q?8G4nvF0dXLpAcl58U9ZSIQz4FOtd/o1Ru+I9cSpGjG9th1hPH7OeplYo2TzX?=
 =?us-ascii?Q?g6Yg5AxujO/Mk9iauk2EKnFe3F/vnwmY0Jrj0jisOrYi8kYaAFr1Jw2f49Us?=
 =?us-ascii?Q?rtovz6ut2kmPlxIpNTyEpv9id0lvCH7kCjvxzvdFBdyOI0Nsxu8LkcVPz+mX?=
 =?us-ascii?Q?PdZ+RrO+/x6mjbgeKYfYUtAFjkintqJCDYrzjaPmPnQeP8xJUFo+STgHgLWk?=
 =?us-ascii?Q?esA3AZbUXFKReyfwvefBXYKWrF0a2irFVmwHEZTONow8icz+mC4JjYX+gTb0?=
 =?us-ascii?Q?8b5KenaYWNN3vHKLir8OP5/xIT6bfd3MMc8O48JhI8GaK7akMgFwfyrQqK1m?=
 =?us-ascii?Q?jo3ukS4KJ9yegsmP/KnNHiGqkeRtMcRJ3MT7iKQAoJb8JtLNZKCFI0ZHgGmz?=
 =?us-ascii?Q?HEJvlNEg1WqsWlL6gZVBFT1crss9bo48P/+rWYFfmOixERz43yK9TcL7mbQY?=
 =?us-ascii?Q?M84E/lNFYkQpxIzpL0EaqQzsOVEH4nsWqqZ5jFwylRglK3zwYqviZvOM7G+J?=
 =?us-ascii?Q?vw+0fyYOZMHpqwHru50n7IFDQ4grHQfFO6ELp7EMAGVkIwKjCVYom6ODoO13?=
 =?us-ascii?Q?QZR7YbNHB+9clX5yCmzxS2EhNBwRceTVVhzeojEJ/UZgCmjT9UxrRxObUg8j?=
 =?us-ascii?Q?0mJRqP6iAS2VF2Qxog6QMeL0l0HEM+TvS7wNrm6ouuSvQ0+LK5kZjg2q8Xgo?=
 =?us-ascii?Q?Ag9EZeHAzdfb/Umspq7TBsqLcfAP/6HklfMH3gUffOVzwOQLceGIvgJe6fIc?=
 =?us-ascii?Q?4q06Z21oerbpUdzlpedyTn8ZSnwRQUf2gHBUe7B9MEbU+smsB5ttuGAE5MyV?=
 =?us-ascii?Q?5s+THGsUeJvh32QnCbND2hx3ZvvzJD6GIiFGcFhCdSDscy/5UvpHmHGZ55dA?=
 =?us-ascii?Q?odYwCs83l+GMnW/YMe+LDXD/iRpjM4AQCc61DLh2fW8vnr87ZGNVF9z6d+zZ?=
 =?us-ascii?Q?HV5dvrY5J6p2gIyrzEUPDHBsld6fuZYTwnzw2qbAaAPtqGHCrwMGvNlQUqLt?=
 =?us-ascii?Q?anS1JmEtiFnctCX7LO6uP7D1JmvLOlcr9IbYVb8EizZMmD6vl06Te+H06ZeP?=
 =?us-ascii?Q?nwzpSJcJfLRBDMGCDIKut45eVU2/uGNtpR7La5tZrNOXldi4i5hINeP2UAtM?=
 =?us-ascii?Q?r7h7GXVdt2f/vwjaw0COPs6d9DtBpiWRF6rhzfDGfVtMNI2Jwb1Ap+SkGFda?=
 =?us-ascii?Q?3Jf4/3gwIFqXwBjju9dsUAhFmiQIFbCe+cP5v5H5VZJJtFkDetesBYnmYesW?=
 =?us-ascii?Q?VMT0FTjc0o0WKuZnXCGRWTcXd7qCWqKDH0GHLsXRI1NGmRUe8GdHhDhmeYjR?=
 =?us-ascii?Q?oPLZLUiY27ypZeAk42GSFxDUGpcDOqv8LIG49TOgC0V9XM1wBLGxEHZRjeEs?=
 =?us-ascii?Q?Bs0DSdjZJ1awcTkektPkbrs=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785b45ef-aec4-4b32-3f86-08ddb9544990
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:36:22.2479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMx76WoHga80EdTBHFCHemYQv11R9j2maI7EJ2U6Rop2BEZ8/iIQteSS4Zyemw+mcM728YrIaF6l9qVOJGV0kkGZdGApePTbO2dfVRyLXSfJpHOboLJDQN0kchUHE6CV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14154
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:36:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19297

commit 4c5e0f0c89f0c54610ab6de29b0649f799a66542 upstream.

Enable the Mali-G52 (GPU) node on the RZ/G3E SMARC SoM board.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250402131142.1270701-5-tommaso.merciai.xr@b=
p.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/=
boot/dts/renesas/rzg3e-smarc-som.dtsi
index 72b42a81bcf3..051a43a7e2f0 100644
--- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
@@ -45,12 +45,27 @@ reg_3p3v: regulator-3p3v {
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	reg_vdd0p8v_others: regulator-vdd0p8v-others {
+		compatible =3D "regulator-fixed";
+
+		regulator-name =3D "fixed-0.8V";
+		regulator-min-microvolt =3D <800000>;
+		regulator-max-microvolt =3D <800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
 };
=20
 &audio_extal_clk {
 	clock-frequency =3D <48000000>;
 };
=20
+&gpu {
+	status =3D "okay";
+	mali-supply =3D <&reg_vdd0p8v_others>;
+};
+
 &pinctrl {
 	sdhi0_emmc_pins: sd0-emmc {
 		sd0-ctrl {
--=20
2.43.0


