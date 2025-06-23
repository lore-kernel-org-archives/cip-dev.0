Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13374C7EE2A
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 10:28:19 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.64])
 by mx.groups.io with SMTP id smtpd.web10.16473.1750674491219293444
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 03:28:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=IIbzKjiI;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.64, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTRbSQlIsJ7eKge34RzUs7ysBO92rEK5dZeRpccTUePgOYOPd9E45XHuxoYOm9xbbG5Ki9WN6+6wDaf09fTrG+o6Xn3tZjXjV49NduaBNPft38Z2OU/ZM7+k/L5xoskM4J9exlFiFOwTnCDWZzagfjAnikuUOBy/USU7+Dwf22BbZwcGEebvVm9DrwdHFkmoZ1HOLe2dihRXMGvNgs6qUxBtKOZBQL03g3koEQJuWMN5X4kbyLRZ0ESD+0fuHFs+CBrwzuBVbxH2iNmmmj5zhqF7HrXVi0zpfFuuFhZKI6EsUgT+zZe66F1eFmUyQnA1O0SaNkLYIdWNpd4Kwqs0lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/cI7KSBVY1hzRztdBSUgsH273MlHWyMdoqUzZGf3H8=;
 b=mKRyRSsZHqKP3WABLPoBalmelOlEf720pUujY6R3UF/9UDSchPHKbmH7X5my5Zu67opUtV+krmA+i+be8wLOz8gd7afkqhLXqyA0T/iPWLwxAia7F0mJTg81EkDIx+rU1GaG2dYUmGkkPASO6EJq40GF3HXUfJvc5lDMv7V4dqzsIw6JoohU5RJlPSgGFo3HxwsLq1TJjNtCSMqCg2jBIkV6vxN2Ecq5GX/jXG/Mb5XpbbqXNYRbz+KVK129TI9p4ZmOMABXIxVNu1SeqL4MoICrCItYKBwphj/bwGrKc9arweP3tOtwbh36sIY+kKN1c48+OTxfoQHJSM0nqjvIdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/cI7KSBVY1hzRztdBSUgsH273MlHWyMdoqUzZGf3H8=;
 b=IIbzKjiIA/fJHEKI8/4FpgzOgOvrjPPrnDjbGyYanuraY7xe8UcdwyhyYTsECeyTIxCK6vQmK3BU4XvPYF2SgYUBtJA292mmBN9LsctTk+fu0eW30v32RjzLmTmqx/QokrnKmoTp4NWkf8N4qbu8EDSC6md2wSccquPKjiFfyF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS0PR01MB5747.jpnprd01.prod.outlook.com (2603:1096:604:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 10:28:09 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 10:28:09 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 6/8] arm64: dts: renesas: r9a09g047: Add WDT1-WDT3 nodes
Date: Mon, 23 Jun 2025 12:27:28 +0200
Message-ID: <20250623102730.1493286-7-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623102730.1493286-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623102730.1493286-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::10) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS0PR01MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 99b173e5-1859-44dd-79db-08ddb240a622
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0irs67VZu/gWZ4aw5h4+WcOqnE0Dwzx6cLJcFVztN/8I6IeOM1o2MLlfVVLE?=
 =?us-ascii?Q?5oMURe+MByHc31ujj8NTsM7bPKa8xe2QK/5RRTvRk/L9FtAvc/ZqhjQh7nJd?=
 =?us-ascii?Q?uBqX+/CTqPA/ioxZRYYw14lkNhqMg9GHzJWT9SW3DxI7q+J4LJE8bfFvVs0Z?=
 =?us-ascii?Q?ZV7olFdqIYsAoxfQML/2zC8KOYg96wfED6DgisqEtX8ipAlNUI8yXHNlhiMi?=
 =?us-ascii?Q?8cY9iAqgPRybT1ZM2SRvOxT93Ll7uNK71MCCNxvLJCKL9/MWM7zVtTpXJAk1?=
 =?us-ascii?Q?nFKUkw7rqA5dxd6Jjc/NLRrMl7lX2oBHlGxvcw2X6FvkzxSLZ27MiPRohlBI?=
 =?us-ascii?Q?tC/xouuoe2jbhCzQIidDuNGrrL7AmOGN7/NtmXav6dlaiOYxyy3RS8zA267S?=
 =?us-ascii?Q?s3WQ4QSclBL75OEjcuKA44RwsfEPjngM1uhmUMouqihQtY5edRt3k3GLydx1?=
 =?us-ascii?Q?kh+ikwqf0gxJ1F7MWIajnT79ZQFK8Fl/jzjLqWVjcLc0mAS7k5Oo0Fg+MxVa?=
 =?us-ascii?Q?xVD7reh5tBDN8gxMGDYkZ1uXB8V46i5FZ3z5FdjKkxROFmaztqnm4GeT2tP0?=
 =?us-ascii?Q?UH+vBS3IoLaIjLZPccfXGDrKuxj28/SkNNQhSh6f8r1Ih468LLpPNDB8VE4z?=
 =?us-ascii?Q?u9v+HPnrnzV+KsWpFU9koWT7WuqYJJkoO9M4rjhN44GZwvWMOguEiGeJgfmc?=
 =?us-ascii?Q?EvBhbTxWNagjjlKloBTdhS1vEJgB2KTNvjq1X/3v71qqduqYOwtB8/4r8FIW?=
 =?us-ascii?Q?lphcEELwwkuqUJFcUjhUWkPPXlMITMqN/uweRcqPcH676W0o9t4HzW0gHdWW?=
 =?us-ascii?Q?GR315A8D+u3JK+QBhpp+8S1W/r0kR6Carp5rGP02PsNgucJfXXSF66Bgqo1p?=
 =?us-ascii?Q?FjODAUiOxdzCGK3Equp+lkwqibljSRn2wvQkq30FSdMCad2Mw1U+sVbQJtkH?=
 =?us-ascii?Q?lwtDWeDMKWa6qsLy4MCQn3XrOAO13pyPwg6yousry/6NxPzpqoqYIjTqAHzd?=
 =?us-ascii?Q?f1EkY7/kvJY8AbfL9FiKuosuSszXXobUhCG4j/zTo4Kf6bU8QhiwOBrv1Ua5?=
 =?us-ascii?Q?i21FRfCAfjFzhEyh3KwPkL7AmPBbP0xmqEL4zudx1RE0xl6Ido2r4gii2p9A?=
 =?us-ascii?Q?3hxD4gXiuawuNgBf7vgcs360G6Ms1wxgMgOjXEX+KykJGKQXMwAOvcn0RfZO?=
 =?us-ascii?Q?RXgLJjH2YHT7/oQudqBh9Y55V9+xqAIgY5dRmiF+V27BNV/VWM75JhlC5ZlU?=
 =?us-ascii?Q?LkId3zEoz4q2SFyzYOsjw1wXs7axZnaBNKZgk+BlAguCSIm74ZLyPNAVhQ5J?=
 =?us-ascii?Q?N6t7SM0f4GD3mbaQFCGEc/9/SGkD6ie3P1VZbv1YS12Xt9sFWtFda6jBn8Zk?=
 =?us-ascii?Q?0zNa2M5Y9LafbuxNQNI/jUGXnnx/Xy1u5Yop5km5JMLoq1OS95hzVN+bnqG+?=
 =?us-ascii?Q?E4lJu789VLlOjgYfU3bOGSlyQZrXTFycrP9WjGj8p7HRHWlVBjFv2nDUwqoZ?=
 =?us-ascii?Q?MQkAS+ciOwnz714=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0FaiHZGNHfAkXooQRUBItwMii8qa0sdkgbB39MRF5PiwCTpq6sZZr1si0E5A?=
 =?us-ascii?Q?V7p2lPKDcxm+5e0r5KG70FWHfQcNEDe80+jvzGIJdzSt/uetg2pwNaGLvWda?=
 =?us-ascii?Q?4+sGRxXBA8QL6twQNhLWXZ57wWf4HpDalXDzeR+y1tULPx5w6B9X1UZ8Evq/?=
 =?us-ascii?Q?yNVmx64BgWry2bQY2cWgupEMyEAzPbRb74K0DLiQED8VxSLJSvswu9c1B2tg?=
 =?us-ascii?Q?maUEbR9U6sw028MXjOFArcfGLix3hGkBsbzY+UH7kChEfedxTI6eL9CbwZX6?=
 =?us-ascii?Q?p2mOFxvulFT3VhjFO7FHYT0WWzl/6YxAcUkHDB7134Pdw8AyNQMrwMFcvhZD?=
 =?us-ascii?Q?cUup5iPCsQUXE9YeZYO3m9vQLvxGKY6MpoEeeY6pNfNqzL22KzrnO85BvwCN?=
 =?us-ascii?Q?NciniMGM1lGAQDd6l/gUGBSgTRnuw+OPySgBzUC99akmPWS8sBj/ilSKd8M9?=
 =?us-ascii?Q?4cuP3Mz8DE62nuLArtim67/uQz6YB+9S4Fj4wsnECgonTUOMGepKGPHF+T0Q?=
 =?us-ascii?Q?1Jj/blTkzFRTH6GL/JCdnvxBIlf0pSt3Do4dc+O1rSgUyFnyadMZwURDoNz/?=
 =?us-ascii?Q?WZzo8I/seGkPGj9+2jS/yy1MBGzljw1ZNM0fapsKUAey+DfpBqLPOdVZLky2?=
 =?us-ascii?Q?XHTN0TmcWwAK7S5eQ0WzvCXXX1S/2s0+pXs1XG6ur0MLXTuqG7e0AraJF0uF?=
 =?us-ascii?Q?fa8fIG1fNq3Re9WD9ENkbD3r8IkqnvVUXFf/WpfZVsvucJwTS2wiWjrDI591?=
 =?us-ascii?Q?kn+WOKhlNULs1vtqQpiK79HP0n+o2QvFYuPYqKIKY/AJ5BCEqTHNpvOn9U3w?=
 =?us-ascii?Q?dicHRioKhYkJlC6Du2Y3UhFpQFX48LM5tr3VoaGFUlpOqYhAdGXu5CvozRqj?=
 =?us-ascii?Q?lYT1peCmmLsJhX6ywY0dan7IDnK2gZa9PYxr3ZL8IxBcae8brEZa93yIkHlm?=
 =?us-ascii?Q?XWFDNhD9VXgbsDgb9pjxaDEYRFj3edFK94fqa8ys73flEfUh6Pt+1tLL+SoV?=
 =?us-ascii?Q?y9YyKM6d962rUA+ubIW/OF/HOKkM+Fgro643D+uFrmKDWLOMB//a0qhZCZJ/?=
 =?us-ascii?Q?gGafJc72HA05DlpIzZHjr6qXy9t0zaoEM426Boc81ZF2GlgZ6NqeGIXaqv27?=
 =?us-ascii?Q?JZZ1H7fjpJhCG/pTTaZEbZ4RYuBdq9STQaI0ZI7Zv/GplfYU19ood/mgp2Tg?=
 =?us-ascii?Q?Yheix1JNyjJp4HWEg2NT0pXopyIOHsKj9V3w1r8fyNj+gewoBgl/9QfRGnrI?=
 =?us-ascii?Q?NWQhBuZyZnNpiHad6ZKf+F/3Vj72ppXZKw7sIK/bHmQU+lOffNc7HAyyWDhg?=
 =?us-ascii?Q?aLhYQ7f0oeYhMzgBl169HaGH430Pk6U1hZueHHxB6VeN12S1b1kYaOY+1xz+?=
 =?us-ascii?Q?Pg6gxeccgZV5mqMkkQ58d9xlOgajGCg972cz4lYo4ONq1QDD7goxY3gMnjV0?=
 =?us-ascii?Q?4DxDc9S9MUYBNOEreoOx2es2w5JednPUHf4kntKbr4KNA6h9W3YR4p+N/S5b?=
 =?us-ascii?Q?vBnAiVuNv/PVhHMjK7AiWW+XEpGHk+V91hDCPXnncdykMZoxz33Lb9P86VqO?=
 =?us-ascii?Q?FUErhu91ud97FlDpfC3QKZUkwsZLTLHjQbOerBNJViJdiJ+1EYNVSv4tZT8L?=
 =?us-ascii?Q?ig0I47Ef+YuLCOE58PmYIXQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b173e5-1859-44dd-79db-08ddb240a622
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 10:28:09.4564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lnojEn2vm+L3AByB120osccydsQqWQuwqInetDRFuH7PSqi+EhTT0Z9iJqWlDeL+a8dfSlghUdrvSCGCd4CJczhLcBPnlsaQhrSpsZXzi5qKMU12Mz1+ykzg5NAUNH0f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5747
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 10:28:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19171

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


