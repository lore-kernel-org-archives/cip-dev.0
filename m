Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD151D3F088
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 16:00:31 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.727.1769616022994293473
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 08:00:23 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=FjlRgiBI;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.42, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oy839LtkB7cB5H/QwioywmZTU8YbbWF1HI+vgjIiCMlDV3DNN0t0or8FiuZiXfQX0RULlS/YQxU+6YrRTG4rFlGd/x7CO3g8y1FAPgodbHaJ7dqK3Pi9iImF+FFuk5b8Tz2muAfYE8gcsBg70Gs9qHl/NMCaEChf46Goa9y0DjgSnwR0Y6MTw8PglWTqJ6cDeOoOFwT/lAuTGinnKSn1bu6JBU+SFd9g4sw0lsnUE5cgcwSnwrGmAUCQEVeBFIl+lH92luL8frDMYgdq4Ltm66VS0B0ckXevow91Jh4mFBMLFg3mxrOV2SjMPjFaazJ1LlWHyQUX5TyZh4OMU+6m5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhOvlB2BxQq3yRXlHnPuyyiRk4/LyaG6YvqvTMIHQWs=;
 b=hVoW3qsmQSuQG2a5T0vDHX/5nAhe2xE1f/+TV+m9FL2GZNFtl5t80MKc//aykifPvjsxAKsqs0aRwV6NmsL7mLjY2poUOAeAjeffYqEYhDFjGEJgUIa5il4yNs1Q7MZhINpjmpTH4NYp+xCKp3HdIc5XLFO3KlWIlugY3VN/PFQc9HUxDJV0G8iNuZAA7p2m84vixZsz63+8cUygxdVIj2TnrdGv6Z3D0eXt5lunui0DzXHta1QFQ3LW9lz/0i+6hY2qKWLGgyLqZOTUvBHq2yLGl3l8w/0xKxS+Nn3oZbExnjRW038CC9HFoz81zcLaCKo4IPu/a4J99jGOm3uTCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhOvlB2BxQq3yRXlHnPuyyiRk4/LyaG6YvqvTMIHQWs=;
 b=FjlRgiBIpqmykFWCETusf6M69Bx1ujuDhX2nhFTo35mANDLz+OukHFRfHmmff05xuy6DvhEabNyZmtT1pHn2aBBnHMxcwkmX6ePOshkKQSFGhZT1Unidg57jAGpeeKB1tq/lej/DXXjOvsXLG1w/3tLK5Eh4aw2Z2PUqYmsbhik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY3PR01MB11948.jpnprd01.prod.outlook.com (2603:1096:400:409::5)
 by OS9PR01MB12487.jpnprd01.prod.outlook.com (2603:1096:604:2f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 16:00:17 +0000
Received: from TY3PR01MB11948.jpnprd01.prod.outlook.com
 ([fe80::b718:17d0:6c0f:1495]) by TY3PR01MB11948.jpnprd01.prod.outlook.com
 ([fe80::b718:17d0:6c0f:1495%6]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 16:00:17 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 4/4] arm64: dts: renesas: r9a09g047: Move interrupt-parent to root node
Date: Wed, 28 Jan 2026 16:59:40 +0100
Message-ID: <20260128155940.1445842-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128155940.1445842-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260128155940.1445842-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::15) To TY3PR01MB11948.jpnprd01.prod.outlook.com
 (2603:1096:400:409::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11948:EE_|OS9PR01MB12487:EE_
X-MS-Office365-Filtering-Correlation-Id: e88c998b-86ca-47aa-31bf-08de5e8654c7
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1ejAangzZtCY/XunGFJYO/8/yhysQAfcfHzFL4kNjBQx8go8xVhC2+qL7kl5?=
 =?us-ascii?Q?p0JNt/0CrQymfDsaOsL6ucUXXEV2944A66bG3Q/v8nEu3yW5ggrEjQmnEcdq?=
 =?us-ascii?Q?4yAlvv4P+J0g73DTt+U4m7f9C5rmsTjGKkU3lxEleTFwN5CBtSgjhZnCTg7Y?=
 =?us-ascii?Q?r8gyj9Vb+eEfLr0Y/eLhNfhxwh19KKeFR8DvfKHb2ibcRDrjakEWd/sloXf7?=
 =?us-ascii?Q?qcCkJQyzPHqkT85hak/RJyGXOT3fJS2XcZHRdyXTJH9uHJKgxcev4r7Xdaz3?=
 =?us-ascii?Q?kfkz5odjjlcJ05ECrMZrSasOS+OEPEV/R+kgvsNvqFW8oxSUmOFTzte7vFe2?=
 =?us-ascii?Q?pcf2hSkKpmFQ+ejxl7IC8C62vvSTaYYQJZQx2ydAI3eGdfy7kBwL5sH5ZDUD?=
 =?us-ascii?Q?9WGtbHY08GJXTseq+UyrGOGQxCMWCmxaQRGTQNT6Buel0ydaSWPe9A3VfY1N?=
 =?us-ascii?Q?z1c9G5jhRYvjyxYtHMvpHLob38b+UgQ1V5cOkHi/F7oofTx/tgxs5oFwbZgt?=
 =?us-ascii?Q?UKLD4slKSIuAyLNqrjSDgxQ2PlwVpb8kUw1KnIJuRphHZRNLQKkgWBFKfoFT?=
 =?us-ascii?Q?4+1HZ90c2MiCPvg3YPsdNVRdHMmp9ut3aKULEXHUl8vzWIY8JX5Upsydd8vy?=
 =?us-ascii?Q?ZSYmV3xltdevVTd2fdyXyALFsIVaTzZ3hlsvxQ2ozHAdhYPG2vFLlaC+9EcG?=
 =?us-ascii?Q?AxjmUKZDL2Wl4kQ4lHXZup/fPDH90QkH/u1yvi2xPcVrYYC9S20pSXsqONrK?=
 =?us-ascii?Q?6MEWdCoS30iQ1fxJ2a5K2oP8ukO4cSBr7FANw6yvoRqABuKVintYalsMJ//6?=
 =?us-ascii?Q?jmVdF4+5zpp/f+cdkCib78X432pg2LzgESLNHUm4qp4w4pKZJU3bEaiRJ4iU?=
 =?us-ascii?Q?rW5IQ/3NMlxVjmL8BIwcMkNCJ2VCd9ITuXdD9QWP3DI76m5GYjpCp931YJWW?=
 =?us-ascii?Q?Q5Al39CyXRT8cF4Y5Vqf4p+0kHrLLBIDtj0WxJ70gP6JMTMdaFKdpiyJ9C4u?=
 =?us-ascii?Q?ZAn/zCsxtkCOSu25+OLNU8NJuAMrVaCe4DmK5+U/gaeSSiNrNhSWwuPcJQOH?=
 =?us-ascii?Q?9AQGxz09oEC2ogpPO5iyXG0mp9rxrbROK2XSyxUorSKVr+4hMw3upUeRnsT3?=
 =?us-ascii?Q?6KLT4W0gUPV+lm2ZRAEFe9waStqlF5wXAvlF7Tf188ehYxII1ShgBo3pKxS+?=
 =?us-ascii?Q?IYfjgjwI+y3UsHKe5RPOmCUjbheMsRm9HFJRqX6U80YEV/qaMgxvrdRKZfS4?=
 =?us-ascii?Q?SDTK2+LI4M3m9aEYuKtoRlAVcAQbG+uX3HaXyS/3Hbitiu0f6uyDnEyYY6Fg?=
 =?us-ascii?Q?sFRibhF50s/YmD9ZTYm3UTZXFUmhjTj69+IzDU3qQ2SsdB4ODkA1m26Dj85t?=
 =?us-ascii?Q?KPs5+F2aoWuQO4ECX2a2R+A8dyHyTyC3u51KcE8AYeyD8p00MkeaZufWrmFV?=
 =?us-ascii?Q?m5WOwoCVOopgmYK2lluhTVuZW0nG5k5Ta2jZcsv6YmBYmsOyLsF86DemtDHe?=
 =?us-ascii?Q?lOA1gSjYfLvgIimNTeaTXlghiMc0VrJ/BaMwqGifmW0gZwLvUGm9PNtIHnWC?=
 =?us-ascii?Q?8giOKoS1P/Ppc5m4e/Bl1KvtxtdaZqyvdUrAJ3zE?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11948.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lbNfAPS9qDAwewKESf2NIn/r4y56BHM7Vtwghc/xhODrkW9VVoMhPTlfV8X8?=
 =?us-ascii?Q?5axC03h4RcO3xQBFZQYboF/9yxqVBNA3Lw91/7zjkmbGyxsMWuwXCO0EtfWu?=
 =?us-ascii?Q?fE4jp6uwxTuPBqOxfjv05bm7Pnj1e7yRt3W3NalfoRjS8zIv8nayIiB0avNu?=
 =?us-ascii?Q?e80bvxDP7hY9PE8jn/1VV1p+YeF61n4Pef9fHmozStsH54pgmINisRdxVi1B?=
 =?us-ascii?Q?K/L88qoGKns+6cIlFUKaWXwiR4HL4WZqPlnD9HOPIhDVySJNJrxWZKt29oR7?=
 =?us-ascii?Q?kZrOwiwOuXCAlBRLgbWL+VuZLAUEByEHlQZ5gDnHkiXUNXRMDjTrYiPGInVM?=
 =?us-ascii?Q?KCT/9uQLFclpXTkd6NWjAiwiDt2FVP5TAFDVf4w/0QewalDZf447+Jndd7Xr?=
 =?us-ascii?Q?9ytew/B57hRLSgk8dYM5b7FuMR8jB8W7/hht/yAxW5rEwmK6+BMfpg5IOG+D?=
 =?us-ascii?Q?U7ICwQCEq9aYTtF6JqL6GBybFY6al6nU1VWoqGHkl0WEouCYKrawe8FWCI8G?=
 =?us-ascii?Q?gkeOgdUU/XckRnCOSAbkFOutmOmbt843Jjs4/aBZOGOJCtOf/5eed2+hbe0v?=
 =?us-ascii?Q?71F2dGJmHy6CzniyJU/kHam1BYonZgV2Z8S3a/5LHPgZ965JwMtj3cYtXBdC?=
 =?us-ascii?Q?/b8nQ0PwvDEq+MMhoqmxdSTUTH6h9fPCLp8SFzlAN/g92FuZegbeIjvfj41x?=
 =?us-ascii?Q?A8JK570XfWOLDdZy7P3quAmoQkl8EmweeftOXtXr8/TLgQNNLrqlGbkGDk68?=
 =?us-ascii?Q?dE1Y+XU8wB+N4L4w5wts/iLFFI98lAceNDKrhg81pgJhIe6cObEuWAeyskdI?=
 =?us-ascii?Q?du+JqWFj+gczKz/lJqyg/M46muZeB+kq6bRKJn437MVhfXWyypH8y2aCJdW1?=
 =?us-ascii?Q?3qTBaIh6W1YQ1XzAnAVcZetvPXb14SR3qQePTqxH+4eneuy9xEhQeDhTaLhp?=
 =?us-ascii?Q?fOCUywa2ho8VZLFGTpU+yO2ZKK8pnAugN9neqFmffVcwlyBKYjah0fvjhZv+?=
 =?us-ascii?Q?6enG1GUbPfqGNBb91q1zxHbejuzXj3Tjvul72S0pQTiDtQSIXUpGGEvbxExX?=
 =?us-ascii?Q?mZNy/PVnCV5jpz29aqebrz36QTi/ojjeGJXwHdXTSOhZA1/bO/kvfqlOvQX5?=
 =?us-ascii?Q?HB7srsZtT9utWZ6/fmbbtecLpEsxUpNMJQgyRKXIuEbkcE2Gj8wupgn6z3vG?=
 =?us-ascii?Q?3bvZ3zbBEVk3tvgoE7vdrRIYKxJkf4U+nDjCvYcYWQ4CP3rvheLr58zjt7OI?=
 =?us-ascii?Q?BXTqVnsPpspXvalxCQiip+NZw/+E5RycOeQEX8uNkBXOlDmGGXt1pgVwlEkd?=
 =?us-ascii?Q?eXN66x8TZnm6OVCn1roQvmm/tL5s0uizVWVSLNSDcdQvRcmnrIiMtABBHQac?=
 =?us-ascii?Q?VGxXts0YyGNVjy8YkbxyngBfDv2DmMN7fqZogI38jgPyIibVjK16vEg1cooB?=
 =?us-ascii?Q?w7lYoEh//FjeeRY6hVUc5v72cyzuF6ntIbftce9aP+/7YvYhFjV50wwXg+wX?=
 =?us-ascii?Q?tAPKoVgnsiOFvKtVyP/71gyYeLiCK7Qs3stLjmLm5/+R7o8qsXUmV1TLY8j4?=
 =?us-ascii?Q?a+U+H4oODp+qoVfA9bEeMuM13KhgECGEfbDf++Ss5O9BacNzhooRsn908Mn+?=
 =?us-ascii?Q?WhAtpdp9WiT/W6Dk7t16JHTqAzcZ4j+jNdfbqGjAQv9bIzEFc5+Jod486xT0?=
 =?us-ascii?Q?egOj0SX/WLxqOdcZHhmiVWhvrvR7UgXt9ceoNoO55SOz6/7yU0+ZSrt2zbzz?=
 =?us-ascii?Q?jtcfADk7HR+mwaniM4mF35eNvjYb4SpDlWdcxebyXiDRJbOgm0ZD?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88c998b-86ca-47aa-31bf-08de5e8654c7
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 16:00:17.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CB3Vinrtr44lYLSfKaoxDQ3jXvPAUKDUgjXxCpX4VYRdTS3S5FCIKSTDDGJgaobv24zLbewlE+xYGvSuM19oaL4eJqC21DO0a9oPsNmh3FI6CTkpET+zYIJwYBwuZKsl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12487
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 16:00:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21772

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit e57389d5547ee24b472ac5c8f8a7dc21b063ad73 upstream.

Move the "interrupt-parent =3D <&gic>" property from the soc node to the
root node, and simplify "interrupts-extended =3D <&gic ...>" to
"interrupts =3D <...>".

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/87h5ws8o8g.wl-kuninori.morimoto.gx@renesas.c=
om
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g047.dtsi
index 47d843c79021..c8cbe53ad4b0 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -12,6 +12,7 @@ / {
 	compatible =3D "renesas,r9a09g047";
 	#address-cells =3D <2>;
 	#size-cells =3D <2>;
+	interrupt-parent =3D <&gic>;
=20
 	audio_extal_clk: audio-clk {
 		compatible =3D "fixed-clock";
@@ -155,7 +156,6 @@ rtxin_clk: rtxin-clk {
=20
 	soc: soc {
 		compatible =3D "simple-bus";
-		interrupt-parent =3D <&gic>;
 		#address-cells =3D <2>;
 		#size-cells =3D <2>;
 		ranges;
@@ -1175,11 +1175,11 @@ stmmac_axi_setup: stmmac-axi-config {
=20
 	timer {
 		compatible =3D "arm,armv8-timer";
-		interrupts-extended =3D <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
-				      <&gic GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
-				      <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
-				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
-				      <&gic GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>;
+		interrupts =3D <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-names =3D "sec-phys", "phys", "virt", "hyp-phys", "hyp-virt";
 	};
 };
--=20
2.43.0


