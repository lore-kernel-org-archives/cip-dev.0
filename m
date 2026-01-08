Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BAECF6AA0
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:29:40 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3002.1767864571380245744
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:29:32 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=mEC0C+W7;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.45, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmZ2nuJAl15byl+8DatYnBP9fvwjDKLcg91qkKMXSlq1x0eat8kGJaTRx5Vy/4nIHp5tKtcRjXAYZksjfh9/K59mFW1zk4SNGvjD/CqXocYCbCFzmwJmmHWGb6vDMVGlGIB4L7CgrbHRDqAByLlfP2DnNpFgZ4DX9Cyl85KDLGIUSfHQi0T2mVApgTVvs1zfyT42h0S+kJetizZ1Jd6/6k/FOX78Zgul7H7QbArh2ua+tHvUzyOsMcx9/EsQrRzUmTzqIh6znzL2McRMLBiyzy2qwdt/tkDGEr/MNu/USrCaijjBm6pTcAsBaYhQolNz9Ty8w83f8ItTmPn/flJQcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaiYx8wAJvgH+DHWbO0qNx+dLDbG0cpFqLjDMegZHOU=;
 b=hFsQA+tmO4CMf+Q18ZYjatAlxFhUXj9i6tCeQ00c4O/9X1qe0qI2JSga4rsCSwFXNBR7H4nsiaBnClD7K2EF6giFXMPpr69cEvstB0yItJvWXeLXz1wP3IlS8ti4Z1sDCeo4V3aZAMoPxWLnLosVuWXOJL2Pw0seya7cuWpdEwhYTPgxq8icPAXhBVaFMIePMDQfozvVFoK8c/KQryoZvsptruur5SFGdW7ntfkfoVEv/fiox5H0ecS4FOKG3L3iPIQXSb4eGYEku0aZaXEs4k4te1i2FAOEPvBD+FbnX3SGZC2YNZCgwmV8sGi1pZcghnCmQsdYd8Zk+v/8GkB5Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaiYx8wAJvgH+DHWbO0qNx+dLDbG0cpFqLjDMegZHOU=;
 b=mEC0C+W7yKqGTGYKaICUQ3Qnli2x4baEHIFLVGgzL9VJ3W38dPT6h3XEivHigkGMB2m8Lx1PLMGU0HrYqi/mNOTRq/6I4kM7+Hlu5jVcfJXJ8zqAsUp9mgWvhEHVfLiJCMuilaSQEqoZER/ZwXeJZvH5KzshamWROFdx1ZJObqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14750.jpnprd01.prod.outlook.com (2603:1096:405:257::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:29:30 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:29:30 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 15/22] arm64: dts: renesas: r9a09g047: Add I3C node
Date: Thu,  8 Jan 2026 10:28:16 +0100
Message-ID: <20260108092823.489287-16-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::12) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY7PR01MB14750:EE_
X-MS-Office365-Filtering-Correlation-Id: 5defc1ac-cd95-4722-a862-08de4e986d11
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?8aPiMhOwoDTfsjwGjhnLqDDW+kUbsbdZvxEHzPujKpGP2uIzaDBncZU8ye2F?=
 =?us-ascii?Q?WZG3uDGFsW7yp4jhbl8M/cyWBEZbvh4qzqUR4AFYj1M2KKxiSj7kvLaIsmxf?=
 =?us-ascii?Q?fpg9ifeDXXBLW5vdTELrWlodU2QzadUliy3lfcdxFa3nXNVeFhKm08wuNwos?=
 =?us-ascii?Q?JYxI592DlAOPCd/SmWbUyqvtQi+ZPiWQPuieRPwlMIqDYvvPKxjIf+DpsvGy?=
 =?us-ascii?Q?N7uwwJJuUUG4xXFIC1zdwsqGsmQMwsr8c3Drk8owK9auOwVBUsiJfClzZkmP?=
 =?us-ascii?Q?EHMtt59WsYRz34uwWyLZlfn/HS6SLMGm9UkgScKUJysSMLT2QbLNSqJTXsoQ?=
 =?us-ascii?Q?LBcKLLkKQ7y0tuL/gg+XUTYc1X1rUdgW3WkkFxzepllPFFbISm2OhpKmu45h?=
 =?us-ascii?Q?5RMSI1wHzZqAvFaUn6gR9NUqogiytx1g83JsTn2Ntq3O8czRoLE07n84n8Fi?=
 =?us-ascii?Q?im7fd6g7Y/CZWR2WGO/RIfr1ktNZWKP9gTwyvnwOupNSI9lrG5i1JIsPao4m?=
 =?us-ascii?Q?xPyiNX8ziP969Wj+N3JlIgI/Zx0IV/7jYm4X+iIB91aJ+DqNyVSMsRMG1zes?=
 =?us-ascii?Q?FN36p23NXZr/kzr5EaL0wuf7MpgF5gwwwtIcxI0n+0p52hefR0BcTt2W61LA?=
 =?us-ascii?Q?Ncn52+3QufZ31jg/1GhddZUcTZEnm6eK6hQ+XTnMItY+gMu4cJe1Znlv6Ma6?=
 =?us-ascii?Q?J0OImqGU1Z35Ymh0DVyhfvO80Cs7GvfryhDfA0Xlr2bi8IEV6XqpJHRBvASa?=
 =?us-ascii?Q?3/KX04FLyxPe7u9aMPKHk0M/OKfy5TC3SeXnmyKtnNAwvqJlTmC7P8IqVk5+?=
 =?us-ascii?Q?E+lsbSqySJuzSrqa4/ViKX2ROkCNmy3f54uX5PL3hQ4JNJgrJDMsiFsiHUK9?=
 =?us-ascii?Q?lUf66pAyeuk9uIgyEu/tVjxdsenSScV0POSynjWhZiYHIpMI89Zv6bixDLbT?=
 =?us-ascii?Q?7i3si3PoAU+whSgMmtDE2CteVvdj6vLTHMWlK3gXJa2e1WPkPC1O6WLZNwjp?=
 =?us-ascii?Q?8GIxDtIqXhSu98az5qlbz0MC1Qx795GjP3DplSed/ASFgA94wya6rYXprDhb?=
 =?us-ascii?Q?eioBV2av9salmMaAzbZxCqPsD1fBULL11eh/M8iHyM+rgUVaD9YYmzMTj0uA?=
 =?us-ascii?Q?bJLtzvodrkvy/MjLgL5402oE/TvGjdYs88QYYS3gX5hL3W9UV/ZvT5L5xRwE?=
 =?us-ascii?Q?wBeGWRaPGjMxhaoAG6W9KQ42w1sS7uA6poflvARZRrN5SqR+pVIyVatxavj8?=
 =?us-ascii?Q?wJcQsNCx8KVPAjbzE6QQ8ZWlRd2ISo6XnPYRjcealPvgqaSd5gXZtl6AjRWv?=
 =?us-ascii?Q?XAPDL5Az6RioqA9QfO7fwRXU6cTzCKbJ1vn244DbdD2l1Z0KlcyB/8VifQZz?=
 =?us-ascii?Q?n1CVY0ZVdb8lQa/BCPoFUnV56PZ9Xuf+u/4Xvk3RsYbJ6aZg6PegIZ2IvwgS?=
 =?us-ascii?Q?ukDZNNTrXWDJ6HG8wlV14yhDmUKe+AylcmcLdQxRTHMzMY8eiW/Xqg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KWm/uUvwB+FEIcQh/SGZThwJ3K8JF1/QmKRHqskJ5Hfc/ydFGxzXQe1pA3BO?=
 =?us-ascii?Q?YYpcKIbMP5PvUtouAitniVbmlD8pBVacf34s/DEHmhuSY8rwgqTCleKmjfVZ?=
 =?us-ascii?Q?h7xn+ZZLRgpU/GRoAfQO8V+Y4aoLxgA8M/h4zDedR9yCZmKXqNb/u9pULEZB?=
 =?us-ascii?Q?YC6fLJYQixikpkGWiaPCoUqh+GTz8VQXHfNfOhEQK0YmOQ2Hazq2JyJboawI?=
 =?us-ascii?Q?iKO2CHlZGzAjOdb1wyXvgQenVMEal6DQya76OLgQAasBpyz1STQ/UTKToClb?=
 =?us-ascii?Q?u7O7gLplGSYQ54fUb5Od29veVz0mNTRLjm4AmVWIwRw900XLhS8FcGy9l/kV?=
 =?us-ascii?Q?D/xnTdyOjzPFXmhxVhPxlUPZOCvGYCjCzfVnfRVfvoBe5elp2W4gvtOuC7ck?=
 =?us-ascii?Q?rwib7O4msyFNZMuWn+fzA/TOQ8yPxtbwNqTF9nh13U8kEtbpWH5SkNoTLvLz?=
 =?us-ascii?Q?eZCz5LDJ/pHXqoOWpucouTTOtWDs5IXvcIYU7ORi2NpQ+VR6EurqjEOIXg7a?=
 =?us-ascii?Q?SzQVTspR9ekdU/f83E5sgq2+aKikQzxWkTLfDWANsjglt7YE5f/ItjwQy0VW?=
 =?us-ascii?Q?/mFyR3TUMvd2LPZ2YNbzZ2rqun42n83TcwyUDFpqbUGT4oZtpLzgWczcucJr?=
 =?us-ascii?Q?AMR3VmuKZQ4Vj5N3Qf1jSRdQbM8EA7pgGYrBWdPMTKB/et14auxVmOyaxK9O?=
 =?us-ascii?Q?41qypg2x+ztPpZ0BLy9iPOOtYNQDCqb8PI3y0bX5fvr7/v5sLRrIxndO+G4h?=
 =?us-ascii?Q?cohnf0EjDVxbm6Dq+ipq6HRRCEoz4PQc45KDjgRYJaIMYFn78YyDY+H7Tzst?=
 =?us-ascii?Q?3b/WRrm1Hvg026Rk6d3T79x760PixnQdgoLk5aKJ9wzWy86gP/DcdhpkLoQp?=
 =?us-ascii?Q?27uEucj5g/kC9KqCa/wF9BgQLhqhM0rXcg9BINYm0Lb7cuPd4uF/CwAlbuBc?=
 =?us-ascii?Q?GDbscLIQqg+/fSfmIUA4fLVSNnq6xoCBeuGy4hKMdQQ5gQqFlDoyVPsU7SIN?=
 =?us-ascii?Q?E1ZpRsRCFG/Lsj1mFtv5nnzf2q5p5m5ZA1GWOA7mPNzErS6Hqy9PtcexWfFq?=
 =?us-ascii?Q?qmaKTl9IZX6AKhF/AlGby2FvsAoQ6R1ZYEeyPMehUBCL9zGxKFXwI2bqVk+T?=
 =?us-ascii?Q?3gVHWc2wJ2//CyPD3g8jog895ooql1ezU72Qf0HYSLyMpbStupFuGADuGyfI?=
 =?us-ascii?Q?LRAUbV9HTRSpwlUT5XjYYKJnIp8ASevC0Q+A5T5CqJLXGAB7afzlpM6+/Xxe?=
 =?us-ascii?Q?l79Y+0tVvoD4ZtE9KL/j2zQA2e36O0J0/PGJm5Qz/gmLxi/nahboGPdSUS5d?=
 =?us-ascii?Q?K8DwkSm5sFMvONLeLGBduXKcdkqqbvZbE+laKEw//KWEvEh2rcFBJfwQnDE+?=
 =?us-ascii?Q?7XsDTPFKRc5cU3FhyMNFwT+WMmFGvLjWidxqi4KE0XuwmK76LqnyFtmKyvL8?=
 =?us-ascii?Q?deV/wFOKh7vndftroZK6uGYGngPdEaMbF0sSnIBp6EwaOKsOem9fcLeAuFhD?=
 =?us-ascii?Q?RVNk/cFOvuNMNlxRUS6TGZlJ6BuzT+QGtcFEWWpySktMsTzRX7LReWR/7Ov9?=
 =?us-ascii?Q?wumyWwCAy02uzaeVYDdmdNypqetcuIhgJsCUSFKWFiElqxTSMCsFdb4Gmi+1?=
 =?us-ascii?Q?+v73tHASHU8fCAUzNCHrHd7Fxa6cdWv0N3AqiMd7cAjLZIGhXoznCBg632jI?=
 =?us-ascii?Q?C78sdj5YSWW/HMudBbf6lDW+zbf2S8zG2ndwIrg+oDjQa80lUJEOBzcy3YbN?=
 =?us-ascii?Q?LXUm5vo4WveYyE9wa2REJ25MGVD5llzj3A6UoobWU8X8FIubYTxb?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5defc1ac-cd95-4722-a862-08de4e986d11
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:29:30.8012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a14QXKIVNuNmzTXEm/4aXWeaHCtnH2SG1sSf6f84qbmRLTO4fVDCJUrO8OZTEyx/PaLAjFPldwAgzlf0KdJG5HVoNI8C/rBCV0nPmgKQ9u2jSEF86ivKqO2S+LtAvTiX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14750
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:29:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21451

commit 6fb1e70e7a918969573bc5258975456bb7165cc0 upstream.

Add the I3C node to RZ/G3E SoC DTSI.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250807151434.5241-8-wsa+renesas@sang-engine=
ering.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g047.dtsi
index b55b113d1f11..42bf6a57df97 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -322,6 +322,41 @@ scif0: serial@11c01400 {
 			status =3D "disabled";
 		};
=20
+		i3c: i3c@12400000 {
+			compatible =3D "renesas,r9a09g047-i3c";
+			reg =3D <0 0x12400000 0 0x10000>;
+			clocks =3D <&cpg CPG_MOD 0x91>,
+				 <&cpg CPG_MOD 0x92>,
+				 <&cpg CPG_MOD 0x90>;
+			clock-names =3D "pclk", "tclk", "pclkrw";
+			interrupts =3D <GIC_SPI 674 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 675 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 676 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 677 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 678 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 679 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 680 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 681 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 682 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 689 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 690 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 692 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 693 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "ierr", "terr", "abort", "resp",
+					  "cmd", "ibi", "rx", "tx", "rcv",
+					  "st", "sp", "tend", "nack", "al",
+					  "tmo", "wu";
+			resets =3D <&cpg 0x96>, <&cpg 0x97>;
+			reset-names =3D "presetn", "tresetn";
+			power-domains =3D <&cpg>;
+			#address-cells =3D <3>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
 		canfd: can@12440000 {
 			compatible =3D "renesas,r9a09g047-canfd";
 			reg =3D <0 0x12440000 0 0x40000>;
--=20
2.43.0


