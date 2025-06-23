Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A4CC7EE39
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 10:29:39 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.56])
 by mx.groups.io with SMTP id smtpd.web10.16495.1750674572018760158
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 03:29:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=e79bE5tY;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.56, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGrwJIjL59I3TZpHfwkI/V8tnnpDsVDCYea+IJtz7nkamn+wdXExDckUwDKjGKpvEmHEm6EySYwFMbkK9rL+rwHX0d/NpWwBJyuotTku4tYltq4LhAdzusaxZiTK4ExM52DFFBSFl329pEdo5SQ2tvdCHyZgvvz6naofCg69gBHel6CVLk87evT22iWpGaKNRAaIk8EQbwC50VTKb3zLvVlG583d37DEIAzNbI88jCbH5XuXWUT0DpMWB/MqDWUTp4HxK7aTKbN6kwTaf4QrHPniHdwuUmVmy96m1QqqgPO2/noF5vrTeSdsCufnwAgpoCzOQfR9a5/bi2ESO77CHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/cI7KSBVY1hzRztdBSUgsH273MlHWyMdoqUzZGf3H8=;
 b=Ok07lTcmQN6O8gxHNWONLgzKCiWw8wswO8nUPDtg3b13sv9rVJ1K1E9IJIFOABi/kEuoYIzX94WH264T8EyedmxOSckhGgFbP8YEgq7AVxDRoZfvim5nlx/9GHT32yBudwmx/MrWTT4xd/uzrc8Y87+XzQ6Sv2bPYH/DpOCCtaI8YlabGrGmr70QGzwJSy8wr0rbQy9JbPm8jPTeulnFklygxs5xflA8iHbJzZjj5k+j0kK2kv06rSz0R3C0KaxVd2al0ELSWvMPRFb3r6ksiAtwzTIATARP/onBiFfivA9FDttXJXYVkvaJX5Evpel4Z5Sxe7U7851OLNL57+qB3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/cI7KSBVY1hzRztdBSUgsH273MlHWyMdoqUzZGf3H8=;
 b=e79bE5tYwVmVLJJud9QiYZQ7/YqoQyz/8iv1zwt/KpcmLbe/0qk3EEbk35E8ZIeUrs56+Nc/eIKHukC7N+Kbn6tipcte4+eaiFD6uhLdlIOMV9B+q31+4/si2zPbNZfGI0rBHHRLdnoBGw8p8JFcVSN5kAbLTOXqmoobVyz1Z38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS7PR01MB15129.jpnprd01.prod.outlook.com (2603:1096:604:36e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 10:29:30 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 10:29:29 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 5/7] arm64: dts: renesas: r9a09g047: Add WDT1-WDT3 nodes
Date: Mon, 23 Jun 2025 12:28:54 +0200
Message-ID: <20250623102857.1493371-6-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623102857.1493371-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623102857.1493371-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::7) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS7PR01MB15129:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b627eb-e268-49be-d40e-08ddb240d5f0
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?cf7vO5EHHwPxF9e+rWsKI3Yp6mYl8jyJJMSV7XSndDhH7v0FsNwfe3xpbv72?=
 =?us-ascii?Q?HRIwGkJ+ZDCZ67SqqexsDGSURjMvvCxUio4HgzHbcDTsaMGzq8qITka1Br1Q?=
 =?us-ascii?Q?KHVKPZ9kQ3PWfhzHC4holWKBfERNrdwGtUWotHJaeSHI133zJIhQO44j/XMv?=
 =?us-ascii?Q?2YxCAqK/fu6TZRnWNBZ8NSLkHXUyZW5e+jqm9vLkj042KwQyWrDAU2sswQL6?=
 =?us-ascii?Q?96YvStgwq7NMmGiNOAuhckbX8rn82AY7yHdF8ze6l2uHqbvzTV6/QZcR0Iwc?=
 =?us-ascii?Q?iBT7p9qNsYEAlTeHWmNFYx578Nv+3TETf7lSURjEILiSPEPAztNX7RBWh0jg?=
 =?us-ascii?Q?I31PyxkgbjMM1fIJ+I2u9/0p02UJEao525rsLw9z/Sx0XFclinhuOWkUT92y?=
 =?us-ascii?Q?JNp2liVp0EJ/v3NSe6+FOfRqBM/s+1BeT2fOEzZR2HDF9xjftmIiXO9pnwLL?=
 =?us-ascii?Q?0dOUvxNJhdXWJEGwstCeCq7BV6fhshfSC7RsFV2RQ1eukjrjSxEHOIhcen85?=
 =?us-ascii?Q?1Q3xnnBJdqP8to5z4ZfS2DIktXvQDdB7r012JH8/Tyiw27jfbJGmZ4hq8bxt?=
 =?us-ascii?Q?c0kjxO0faVzk0UCiPKwLdEAExYqErdIi5OtWDWB7gDCuLKuqaMxLYVq3XUKr?=
 =?us-ascii?Q?28sDAqbsFPVYa7cKpfykdX01mP+e5bwihKyPdKtodH9a/SBRCTa7fPkR+d0z?=
 =?us-ascii?Q?YRzNopMNmPBKFk4Ta5B03lYupxplkm6jbFa4UyEFxAvoicIDCIct/K7t7IFS?=
 =?us-ascii?Q?S2NeEFWnHajh5fspw2zMC61o8t9VAorJOdcL6VJJZAei2wCTbZ13/XhlKa6m?=
 =?us-ascii?Q?Iolv3AMhSOFjKqjF7kE0TYni7vyJ+0awK8eKNPwYuHssRtqKa9VRbQQq67xk?=
 =?us-ascii?Q?igab9LfO62VwD/Mvm8DlxxOFqOvTB5q86AI+xrzsRw0AV37uh8WkjhfvBWbr?=
 =?us-ascii?Q?lqkorWuw2lgDB5gnEZXy24/YJV9o1VoCIRU2nH+wUFnD35kq7vBdgowUUxxS?=
 =?us-ascii?Q?4NmGH5zWAl9HJdhoSlhmbTOTdTujcw2gbezMqHVo+6Vqwj3Igt0j8PSKGsJq?=
 =?us-ascii?Q?i1OHQ0x7m+YuiMB3jpJTWdIFmLpWHkv2EcGBPGJGFgP+tD9Q7WDegCeqlRUd?=
 =?us-ascii?Q?yxC7npkJrl9nxQr8hNykb3jAW5vI6mVZiE2LGonkAu+j1qBLlD1VxbZI8UHf?=
 =?us-ascii?Q?HkJpGoWsVToExnrLGgRgr4uxsISoCyfOfr39Ij8EwlW14+zSOsbEP8/zY1i7?=
 =?us-ascii?Q?XS1xrfks1WeEc8rJwcPDGuttprRC/UhjdUWILW42rK86ZjCzmtv3MuOswOtY?=
 =?us-ascii?Q?xZb7k+BwuxKoH0FfqiijpRN8Hbz2Xoq3+c/WDSTC3Z+/W1vx1QomGWYrG9Pt?=
 =?us-ascii?Q?2EpFFBGNTd+cKpUU74LPtCGjWYq9lW287AemC2gsTKC3VrUVoMZg9Z+dsYLH?=
 =?us-ascii?Q?V/KEy71HZZrY35NMZ5oooIUbtiqQObnXuZTHEoc0sXv+0+OCuKc5X0rnNpkt?=
 =?us-ascii?Q?TMxCqNRVOBQalsM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Fyn8DlNsrAyHLB5b3OXrD63Xwwy3msYnGsp7f8ISu35gfW1jKwtdhHiN+UAx?=
 =?us-ascii?Q?rwWu6FnQp2xPvFHrv2iJD1FaWI2z6nbeKwJCuwAgkSQDkUQJhH+T436Iq7rw?=
 =?us-ascii?Q?J252YS/1Hck9UK2PkxsAQ5UMRk+wG2pCDnTCxpzoF4jA4SxMVNQ4i7012+9k?=
 =?us-ascii?Q?mgiKUW5BFZEWdeZuvYZ9ic3tn7yVUJsUXPkyaE8niq8r/+FO35q63gosoDlw?=
 =?us-ascii?Q?rIJGK4ZwqmuAZ/+tX+qzgV9+aPq/USFIiPgTY+IlCty79+L6D2m6UmTo1P3n?=
 =?us-ascii?Q?BPkKHklajxrEK26DTISj3ZfCkW1CnV0GkuyG6COadVTTzH8/CL6IbSzAAKfl?=
 =?us-ascii?Q?IMOtcsAoNJbY/v6BKXKwZmq+NiHhChjbdnZTLcNbMYqZLsUI4TFcq1ndYEcU?=
 =?us-ascii?Q?AtbNV7MYh9/7oFpQI5GVBMC+TwykC576Oz9ol8cpk/zN1jgaldikJ8bGC6xt?=
 =?us-ascii?Q?6xrwAE9VwmBGbf0TBEIyaBpXOOSJmJe1FTde0bUUoqoNd3XRLZSg77ezOnGu?=
 =?us-ascii?Q?veOhuqYg9FwrkfhzyaYVMU/KAgnF3tRbnhU9xC15CrxPgAtum9BZ6Fj7FAfe?=
 =?us-ascii?Q?fwvgIntfW9r+M/Dj4fVyRTGHy8HVq48TYGztZGnjUwTvHW5cDmaN5w0cw69i?=
 =?us-ascii?Q?cGeheyAsxlkYxv66Es3aKzyOtgX3FN6a8IwMYPIWhn2LMIuouaDdJForFL9w?=
 =?us-ascii?Q?FNI0SWXjY8VUdpsaI+8+FKEmnR7WBQ5N1iPaWry2JeOcJQvbvHs+Wpy15dd9?=
 =?us-ascii?Q?+vKHJL+OxMkZARXBjMzjFg1VsqMkWXR38Do06iyFaDCZ7hL8JQ52djF+/dX5?=
 =?us-ascii?Q?LY4eL9cZJD4vbpxUFGgQaRkyNzlAjelkkypDJM9DDkJbeiS+zfHIemGJFCjs?=
 =?us-ascii?Q?PGx962xIaL5ESkA8UpOe27/vPTkTOHD5Qn/owj1AeOEhiYzRyD1RRwpAVmzJ?=
 =?us-ascii?Q?wjxqnl0hv17fjR7Vp6lMlKSRL2irUoben0tYIkWUZDXPTs5VZYBvVZ0t7jR2?=
 =?us-ascii?Q?0mcC0wSqWIImArcaaUQ5ElQKmoFKT54NQoJ8zd+9LmOC3YeIrkYrUpZUglQ9?=
 =?us-ascii?Q?q2wjXw69Kp0ouu+iDFn8gmwS3uUJXH4ylQfV7C5luobPAr3YaK4M9inxuAry?=
 =?us-ascii?Q?pHjTegPA4nNZCyvALw4HeUP9W7FCb6FzXiYb/Zxn5ebpDW1pfIzRiwNDk8P3?=
 =?us-ascii?Q?zc9PwqIHYKqOPQctRckI0B+QIPQ9Hb/4K8flTJk5PD/9RvhkHSVI7XDWGlBQ?=
 =?us-ascii?Q?cvfuODyi32FBSy5wwGNBiEq6B7y2eBG5sIvyUaKyFe/m+UN8pmcWS9QWhYZo?=
 =?us-ascii?Q?gjMIgUX565eRAymMJOCyL/iiIGHkTt8lErENpwz9B9Lpyt/boG6vfnQn3Jod?=
 =?us-ascii?Q?Y2iLPlynHA4/mIzNbWNHWBRO+QM0umV6VhzGjTUF1D/uMETxeHMnnaUlvTy0?=
 =?us-ascii?Q?EZ32v/AcQ7uwgREjmmx8iGBdSX6XOYdRZCG/0Prec0GIyf+h10WlIQPYPSCe?=
 =?us-ascii?Q?3DSE7z7aPrNB7Kv9vel5b0r6iWE0o4coXG+c8WeifD6QF+KVGPurLQxKkYQG?=
 =?us-ascii?Q?cWHd2684+XklcAZCKGOxTrL8RqJ+A2lEXy5LxNOF9HgX+0xBFYkEujnsr+Ye?=
 =?us-ascii?Q?7VzDgnHW4wKUTNSvn66Bdhw=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b627eb-e268-49be-d40e-08ddb240d5f0
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 10:29:29.7118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vgbe2iEG4NikCxWfMePooxa0JUZJJkuPxTn7DUjPNeqHDDYHB835T9bu+JpF4Uw8pPuvKWSWS6SMIGX8IsSYodIDS+Xyn8ti/BQrvEQp3WBd2rzW5OX1RRyktNWz066
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15129
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 10:29:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19179

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 146a9b058ec780581f580b0de9bbc0264b59d701 upstream.

Add WDT1-WDT3 nodes to RZ/G3E ("R9A09G047") SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250115103858.104709-5-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g047.dtsi
index 200e9ea89193..133aa3272d3a 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -175,6 +175,36 @@ scif0: serial@11c01400 {
 			status =3D "disabled";
 		};
=20
+		wdt1: watchdog@14400000 {
+			compatible =3D "renesas,r9a09g047-wdt", "renesas,r9a09g057-wdt";
+			reg =3D <0 0x14400000 0 0x400>;
+			clocks =3D <&cpg CPG_MOD 0x4d>, <&cpg CPG_MOD 0x4e>;
+			clock-names =3D "pclk", "oscclk";
+			resets =3D <&cpg 0x76>;
+			power-domains =3D <&cpg>;
+			status =3D "disabled";
+		};
+
+		wdt2: watchdog@13000000 {
+			compatible =3D "renesas,r9a09g047-wdt", "renesas,r9a09g057-wdt";
+			reg =3D <0 0x13000000 0 0x400>;
+			clocks =3D <&cpg CPG_MOD 0x4f>, <&cpg CPG_MOD 0x50>;
+			clock-names =3D "pclk", "oscclk";
+			resets =3D <&cpg 0x77>;
+			power-domains =3D <&cpg>;
+			status =3D "disabled";
+		};
+
+		wdt3: watchdog@13000400 {
+			compatible =3D "renesas,r9a09g047-wdt", "renesas,r9a09g057-wdt";
+			reg =3D <0 0x13000400 0 0x400>;
+			clocks =3D <&cpg CPG_MOD 0x51>, <&cpg CPG_MOD 0x52>;
+			clock-names =3D "pclk", "oscclk";
+			resets =3D <&cpg 0x78>;
+			power-domains =3D <&cpg>;
+			status =3D "disabled";
+		};
+
 		i2c0: i2c@14400400 {
 			compatible =3D "renesas,riic-r9a09g047", "renesas,riic-r9a09g057";
 			reg =3D <0 0x14400400 0 0x400>;
--=20
2.43.0


