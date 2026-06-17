Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64C3CD98E4
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:32:15 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.6])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10944.1781685127948834677
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:32:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Z8bLEhwq;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.6, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9gStIApD/RWLJXo+aetbIOZtVonIhKxVkfJANIJoU0IkaENGtWId2hpHnATsPzJygCrxsd1eJrXcZ98N8ClRV60D+nvs0QeuBV4ZiEsJe1dNJ65ZuARY38hnYnVE5qh4IQAihpNIjQN2dEKNrFP4fykNs45r8B9IuAL7FWS+nX/BHA1c3z7wH+DgP6yXykKZP9CM028WqdcF9Ec71Z8Xvtrj1UvEjKIxBAmhVkFhZxvK+ynwdbIBBnYe9UZ7th4G6j0m53OO+n28OAcw2KxN1uzWulqCub+uCmPvqJiUz6lUJZJughIBeNeLZJ26nXv6SL1KFW7o2tndjiGCl/Zpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcsSHbwWfupduB3GHEfAff5xSwuynwVB3MEwEnAfxT4=;
 b=k+1OoNY8U1P01tbSTKX7wTpPaxuoS94xzO2W6DlLzPRpTkNS6KqtzZ+asKfamSXKNcCgMlP4UXXetg8tV6c9bz0ikD6fObpxkRuAE8FUu3d33EJgt6ZAv4U7rn1oF4ueBYBlZZKH30Q0ho7FNK5ktBXrlTwPdwWcBgLSF1ZsZzbkNq+JUw5fNb2RSpbC2I6VC/xagG6OAPzTPLC++wkb3aUCP+QMhc8YRJs8poqjQEUI+YcpfEHaDmVIss71pdgsuot0L8SMfAHNxR2Wy2EoDVha0070gaeGMBIyZc44nY4cf4QZ3xQIe8YYIZUggnGEJJHfeWbGWVKVrfQFdIiuhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcsSHbwWfupduB3GHEfAff5xSwuynwVB3MEwEnAfxT4=;
 b=Z8bLEhwqZlghGH6dC7I5ZvMATYVMLZfTX+3JrAt2L9qe/oqbfZYVfZVZKFZyOo+edkMIdv3krQlSqrY/LmIJ82KoTzQkqaOun1B1FdGoIPQ75UD7Er1arBxqsFbv9zgQEfKDwu6n/ZFYINud7+7lw3eRedSksJpbkNwMIeZ+Ewc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8108.jpnprd01.prod.outlook.com (2603:1096:604:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:32:05 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:32:05 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 32/32] arm64: dts: renesas: r9a09g047e57-smarc: Enable RSPI0
Date: Wed, 17 Jun 2026 10:30:03 +0200
Message-ID: <20260617083003.1071543-33-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::18) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSZPR01MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 752bbc11-1728-4fb0-83f9-08decc4ae9bd
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|23010399003|18002099003|22082099003|38350700014|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: 
	uHAYwglvOTtiWo9fnYSzkLxLkrLHdCf+UFYo3Pb1tectSYCHledL1GgwIOjOxxSQMRenCbcCDxqRJBDwapCkkL+oYjuxeYyHa1OJI5Y+G4K83sAyKHv3ZdrIAH1sRU7MiZbrnFZx3R8ug4ESFRYGacOF06RGDX3o8RZpFG6X6oSgC+RqCnx4ps27btQxeVJXeHNgH0OVnAhxSKzZj9dO7NznDXxgWelnFnNG+Vvi5/muxnmAH5OqmnXmeBkxVvDLZuXWDmFKeJh9FGMHIzV8pBlr+C50I+kKTHTkkEE8aoG67TXt5mzZg6JqbIC1lUYzrJpHh3axfE6bRoNoPVnPyooUsWFhSCR4Y7mlJ/QG6rEBpudCKeX+Cc/YcVmmcROXSzZx+vjllSc3GKlGWtb8Go9KX+HBbT/MSyNRftd25XmsIynfrapHGOUrzQAy0Pg43699u4xVEiQcu3NbY2/6Qd5e/Qf5VUX29Jds/H8A7+ap8fqz9O37k338+QzEQTBwgVOwRGlxGFwUw4UEOHAKZj+V9V3E2VT9hfWroqjHFqvsHWJxjEHok3qpJGq3PUxo2Kbj2MLIPfy60NUmwWYWMEdOR0G0LR951A/F1CpzZCDx34aqj2b4XJ9Cgwiiwm5mRvfQ1C8WZiyULlKH27VSjfe2C5GnQi3eKJP1VsoJV3vT9zBGIm2Qrf5Qzr8YjHEyRYGjnR+rBHQv7d+X97EE9A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(23010399003)(18002099003)(22082099003)(38350700014)(56012099006)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+M2Ta5vYSjdGQp9Mx5kztFZ8E2P48b8t1zLWkE8WISBbsShyL6TqjxkEz+my?=
 =?us-ascii?Q?Fz/rLVNDJoK/S7GwEzAh1H7Tfc6oBLIYsHJMTlywmZJlxuMbUOy0qvySMXna?=
 =?us-ascii?Q?Wn+mp1wIMrma937AfGuzbXWJ53R8vs8E5kx8v3sko3KtGU19ExIfA7WIhua6?=
 =?us-ascii?Q?BMimW6Q8uwaDQ0ra2XqKqNptLRSGY6hVuWiz+Y9wB5YP34BY+imNFkXL0aH4?=
 =?us-ascii?Q?DDoKemW62sW0XFMd64Lw6/iNY7cOt4ffiQJJyaM6h5gtHQpU57/vsM3wrKYi?=
 =?us-ascii?Q?yo2Ae4Cve8B/b/bOah+MtyJSIVJd3c12VgrmjnC/Va0q2kUWkd4B1iBYDIx7?=
 =?us-ascii?Q?CRhleBRNFJtAHRXqHCZdIp+GtTJYo5roluGZYok3dSD/lGn5uj7/DQeJ6Fv8?=
 =?us-ascii?Q?9DpV5+c+NST4BaelEwbaxvTd11V8b4fdbxZZ7dsW+hFN1gWMbr27ZGLtr1eZ?=
 =?us-ascii?Q?DJqRZj7ZXgjZn/nM0e6/SZnb73mdcy+KtVR4rKMsu81q1mAHjnnzT4dgNhJ1?=
 =?us-ascii?Q?KBvXyTolb18kiiZSVGuDiVCf3BYQicHG1habUPQpsqRGJGVJIckaedYix+QF?=
 =?us-ascii?Q?6V7HLCG+VPRCvTopcDcGx29bym9srdEBb/CXoyWrIkxlVN+/xfnRaHMEWBbU?=
 =?us-ascii?Q?cgbm2RoolHUD+pa9M9Q4yKv4Aib8l+0fWOFZ2GavAlbS/ql+/PcluUvxm1fa?=
 =?us-ascii?Q?RVlEZjIVEwAbukbM6piNvolnjvPCnEF4xRQ3D1ctqfoWrs3LQ6vH+EAemiE4?=
 =?us-ascii?Q?GxZjDRQMEnu4ESYuroT5bWAUL9bHMPfv6eSEefxtO968P5cSFJC8m457OXFY?=
 =?us-ascii?Q?gKQl7DSv7aJe7BlZj2smWcfHnQvtPLeWM2LjaOpQGRxNDSV8pk4sYfPYOQAO?=
 =?us-ascii?Q?EBAv6P3pRqK9ZO/z7BIgGEiHt52du8xBirskhQrbmvBrqf+LfPGz0xCJwg+0?=
 =?us-ascii?Q?mvodSK3RHU9cnblcUWIJO1v4YfNiKNF9Oz8Uj3lk8DIkFEjDJKfuJwPLQU6G?=
 =?us-ascii?Q?sCqmVlWFVvvyU8RYxt5GkG3/gqkrPIkh/KjfBtVy1STW/aAGbQgZTEqzjcBN?=
 =?us-ascii?Q?/jsOZ9bYOaaZ85dKSkNtnVJD/ELgQdvSCGErmtru+1HQesPGP2zknHOA8zCC?=
 =?us-ascii?Q?TgioVf8sNr3/uvAB3VXbxPfijrVJ/N7j1KDeWLMtSHgVeMUgvD1sTYWA2cmy?=
 =?us-ascii?Q?GFpE4/BATKoV3rMjUSwgyicgKwUcUS8jL7fwXrDdhZ89UUqq1wWYf0zy1BIF?=
 =?us-ascii?Q?d5/6xqvo/kgWOImZ9Ev39KnzFlsJiidUm9cceNUdVfI+TcTWOJaRprE0XTrD?=
 =?us-ascii?Q?ipoz8kP+/URUWEd5IO3pakdKokmdTvzHWbmZ4jgKnivsxMoNlLkbY6HawvKf?=
 =?us-ascii?Q?uuM4caoqcFu867mVuB4EmHMRgCv0EM6LFiX2lDb8/BiBKb6eCaS4UF/4mrGf?=
 =?us-ascii?Q?zpb6mZPNpR8iFyQjoZBcCGX9T6hINjJlQAltQ1snxPPO4d7OXh94La7WgXrA?=
 =?us-ascii?Q?unhSRpsegRh796a6kf5b6f6qhXcaw/b8jdPp85GX6aFipa13IwGHSRjI+FbJ?=
 =?us-ascii?Q?USpAQLmeHq0QMg9nsdDAqnsc+L5+JNQb6DImXIE2WrK4lkR6/5qn/pFDoVf8?=
 =?us-ascii?Q?Axt/IbJSniwoI+TRJRphkPTzVll7u/CEeG1/1gmZ8lkfI09uJx84ZA/qTTr6?=
 =?us-ascii?Q?qayEBJ84CuWV4U34p3t0DD9+bxNu1XhdtupfpNbs+51GM6mOWkLQ2jfStuI0?=
 =?us-ascii?Q?Jtx1Igh7ATr73RjbxYWTTqhG5XBpXVqBzndWLs6ZTAPl2UvTRTyr?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752bbc11-1728-4fb0-83f9-08decc4ae9bd
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:32:05.5213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emGJ85nHFqh1D7GBWSgw/B1bcy7E9rart+oNZg7w4xy0d3/iRJuE6epqN4uEE4tOihz4Uo6xS/JUdE5kM2ZZSoWHES9udcwVGRiSHuIAITX9VsU0zYj9zbP8aQoQfHeX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8108
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:32:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23191

commit 19ca423f61b66ee3328b6a2f35fbb3ff2c8566f5 upstream.

Enable RSPI0 on the RZ/G3E SMARC EVK, where it is accessible on the
PMOD0 connector.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/b634c10e632fed07b5652c11de060deca27ead90.177=
1344527.git.tommaso.merciai.xr@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../boot/dts/renesas/r9a09g047e57-smarc.dts      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm6=
4/boot/dts/renesas/r9a09g047e57-smarc.dts
index c303f7c66e42..7563e641b862 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -191,6 +191,13 @@ rsci9_pins: rsci9 {
 		bias-pull-up;
 	};
=20
+	rspi0_pins: rspi0 {
+		pinmux =3D <RZG3E_PORT_PINMUX(M, 4, 2)>, /* MISOA */
+			 <RZG3E_PORT_PINMUX(M, 5, 2)>, /* MOSIA */
+			 <RZG3E_PORT_PINMUX(M, 6, 2)>, /* RSPCKA */
+			 <RZG3E_PORT_PINMUX(M, 7, 2)>; /* SSLA0 */
+	};
+
 	scif_pins: scif {
 		pins =3D "SCIF_TXD", "SCIF_RXD";
 		renesas,output-impedance =3D <1>;
@@ -258,6 +265,15 @@ &rsci9 {
 };
 #endif
=20
+&rspi0 {
+	pinctrl-0 =3D <&rspi0_pins>;
+	pinctrl-names =3D "default";
+	#address-cells =3D <1>;
+	#size-cells =3D <0>;
+
+	status =3D "okay";
+};
+
 &scif0 {
 	pinctrl-0 =3D <&scif_pins>;
 	pinctrl-names =3D "default";
--=20
2.54.0


