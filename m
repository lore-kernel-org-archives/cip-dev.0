Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB74CD98EE
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:36:47 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.0])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11011.1781685398326652896
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:36:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=eD3bSvMl;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.0, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMphxRShqk3avOQMm+8MKxAPYpIYdVg2lAHfptbuz52HSJlXpahDOEB/RCv8fPgq628p7YFdiY5V5mKr4fDfDHPR0AvXa+27lGQ9HTqC9TZ/vrZ8B+BGPoaez1W6xxjHoM/WSyWOcpce4v9zJIFIvZsnj66HuMEBe4yy10v780HORWcq3KeReMZj//2mRIAwl8EtisOvhA9RBWiaeTwlYY5uNrn7Y9sBDyK8VPPFduMVLti917Gr1YOu57nI+pkFpDkHQR0H+FcKQatu5jyNaoCc38q/rRQWJ2Zy0sK0cgp2j0HnrtM19qyJLMArzqM7i8JitxojCZVc5RYXDC942Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cD8vCjN/anLtWk3gVFpKTWYUNsCFrohhtdPI6L3Ozg=;
 b=ZpKPpDVVsw+cNZ1wXX1J7d5xeaxOe5fnyqLnFd1cZzl8cJTbIsrD3UfaWw+ZYXWp/nlwI3Xddl4EbQa/39eJt61LZMsQDpUAHOb0aGzkmzUdmw9OKNk3KSuQk+7OcRm/lPnbw9tvLeSc6FIh/T3s4QY2WTnH5UcjtIyPJQB8hWziLpIiKlz9KNk/9OL034Mui1yb7eA0TDbmQcnSQkudggN2f4vSzN/UudHF59L29GtagpRUTtFE2vLmWdUyop5cMByg4u26LSftygg6V84aGLg2+lxPHR7/yO0JsTRJ1yQ0u0ZInVUQO+xZu8WlR77tSmIjX2iK8RtbbCQVudwt3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cD8vCjN/anLtWk3gVFpKTWYUNsCFrohhtdPI6L3Ozg=;
 b=eD3bSvMlXVzA/fu/pvA3xy6f9PMEbzmVqK+cMuK/9FfI79531rCnrORT10cE4UHr7tjuaTcPpjVqhEquC3ZrbEEeASyoLNN41Tt9D5an9R6wvmPGv9LnSFNXuI0pvxQWfIaemOSg4eQhyiBUnPxLri7q2IRuRpfIESs3VFsuarw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY4PR01MB12634.jpnprd01.prod.outlook.com (2603:1096:405:1ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:36:36 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:36:36 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 24/24] arm64: dts: renesas: r9a09g047e57-smarc: Enable RSPI0
Date: Wed, 17 Jun 2026 10:35:02 +0200
Message-ID: <20260617083502.1074160-25-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::23) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY4PR01MB12634:EE_
X-MS-Office365-Filtering-Correlation-Id: b07ec34f-a30a-4508-dbcd-08decc4b8afd
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|52116014|366016|376014|11063799006|56012099006|3023799007|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	jGT6omt65XwgJwp5VAmmULGmQOKIPVYCtwRSfBZTg68z7hXs7JJ3rCvJh0/QqnJ43/xo65GchyONnsPZ4XRsoHpjSsyL3sDR7XWWfS5oo3vrmIw7jhKlxqAdqhaJ5kv6LIwfsAGOajI376ATO+UZMh/tfQwlHm3yavsMBIlwX0VXSzi+tEHKq7ivjwMaO4xWVwcDnQ8ToUTXq210pDDs364pskkqPT18uAceCrwdirMwVuDPqLCOaBtp21VIGNKIMhXXSmQszNmftknFMhDXTlHHkGbeKtNgU8OcXUdT+OjBRbQO33AV2nZrdc8Tg/2cMBs6wNemNRUWSjOx62VINE643XfJnGU8/L8J5KjaHFsYdEEev1Edn3lD9IBhRW/r2MylIpmDgjkb2xs1bWqCjdQU1pq5z5CO9iotueBMKJiROWHuKrpcJ8v5t02HS2IPhcaewuKiC5jcHVxqMZcf6Qdd6RhmKKD5IlGU42bsr8d7VSvOWPElAMKp46eBmfSVEMhj9NeQ4yMvkyrqnaOSd8w8PvjoQF2Klc4dO8jgYoN0n3M9VgzyZFEPEJwVzDe6HfH55I3rZGc++Nt90Rqbh35FBTIc3wN/csamnUndqrMhEZO8+QH0fDtzHl6s7PSz2MD8VUqB5A/KwZHh6zRAIv6rWtENkmYsY3KxKVa3rimqyfyvHskUu+VpzHZ2shZdd9rppWsoPd7xlLrtc16DGQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(52116014)(366016)(376014)(11063799006)(56012099006)(3023799007)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?AozaqIAjQSfSVjKrdBZ3MF5mPd6qSB0cvZFgd6RQ3OydAtltfHfdtPCNd3Mt?=
 =?us-ascii?Q?NA0MpBF8dSpd9mHPqjsF4qr5aiMa+3WtamymIEOG1qfyvosbZ8Qtay1Xi14U?=
 =?us-ascii?Q?R9OwB5Akk/DqBX0/NgdmwLmfzeNuD68KaVbe6RooYjH8Mlf1gFNNsqpWmVAP?=
 =?us-ascii?Q?6nS5mT8xyHrrhd7bi7qeDgzjq8LlXA4ehGZT9UqfW0D0HGPaUpMadHL5pczJ?=
 =?us-ascii?Q?PIa5IMS6q02IYi2lz0nib8zeq5Ib0k7EnEy2fJ3SMX+DPFjq9kBfWM+o//4o?=
 =?us-ascii?Q?nMxZEOwS85zcBQrywd/11kqHcnM2ZlW8DYzFeJDRkZXlOJ3hkCsQD6aRn80L?=
 =?us-ascii?Q?6I2aoivECTRMvoxYvf3A6W7Lr+wgYP/ER6V0bgkHAZgKfIdjKSYtFvZuME2t?=
 =?us-ascii?Q?3Ox30b6w+rJvfz6Ej4r8/SkGccdgzrYM8qixewSqdwf4Jqqy+72iL/HWUuMR?=
 =?us-ascii?Q?U4xpjhXCGPxQVglh5Nf7NKgRkzsJ68sMxyRsGTM0+5Z8R0ik+2ChTdRTQ11f?=
 =?us-ascii?Q?zAr9F/QCoP4yWMMPj95fo+BAkSywCwbcva1cTW3KxECPkgxttNMS2tDRLZin?=
 =?us-ascii?Q?MfbLdXc9qfq6wc9lACOZCYCTYk/Xbkh6MQRhe+WzhTDFc3zX9KWa9y5g7JMX?=
 =?us-ascii?Q?DzxiTeQLbB9LcC5gvVnYSXwwDplg+kllawcpuWYktAy+jL1hrLzJd/bLcS46?=
 =?us-ascii?Q?y8Q5/xE9EzxbHtpqgYHRrju63VRqgnR7xSFhJW+OnSqPbXMmGgfQrLMsFwHE?=
 =?us-ascii?Q?XtA1Lk+I4oMaI7JHAB3bSn25TBiQlgN3zpuIHQrXuBG754M8kgZjSgeARhF2?=
 =?us-ascii?Q?lx4QBCzNrGVnZqhBsnpr49meuXPy61g24mVIAatj6lUIlUoZstExx1UHwN7h?=
 =?us-ascii?Q?c7bPZODwoQZbJFJL+jQezS0YDby1ZHalShuYe0DJ3gmZCS/SmWJFtk7JDXgx?=
 =?us-ascii?Q?1jv9oZ0thxj6uqMX16guF6J2PqQu4H+J4/xVba+NAxu40BP9S8hsdynShSo/?=
 =?us-ascii?Q?VFYSYsLCEjpn5z3+Km0cc9tiOLxJ1Ze8nCAivKfgP56/IFcBg2n2oleAVlM7?=
 =?us-ascii?Q?7kawObwLX8ILL/yMwEYWY6Dcz5XQaQ9xkUTc7l1UOCwVNKOtMqo+4677dewh?=
 =?us-ascii?Q?o4Nlp8Hkyms9TG6yX4V62O6vn47ejXNeDmqneZgmWU3WutbrKJe0zQ0Zgb8J?=
 =?us-ascii?Q?rfnvntVVsb6PSsUI7kNUcGBxoZaU4uDIevbQ0yRGEvGc89Jpl6GKiAe8rJG7?=
 =?us-ascii?Q?vnEXaKDZSjt2QeI2uzB6S03xcXxDjc/tiGxV0iXB7R+RIPSEy02UoqB3vhE0?=
 =?us-ascii?Q?cw8vO/foV3b1tSW3Yj6xd4bzNSA4NPx1uX3PpwDSn67u17ADSydFM9UIlACf?=
 =?us-ascii?Q?UOHX7DOe13l4HCcOYhRbY7g3YKVpCm6FMjXQ/PA1kIi/X8XpkaHPyXYhzD6v?=
 =?us-ascii?Q?cStCv/PiQUXtKRWFW0GjbF8aZiGeHQtvrApUKXUYqTAfALHVgZb0tkMmiH/c?=
 =?us-ascii?Q?oTvjYUlnZK4xeiuIISWvH/kPWqOZ89Xl55ii2YU9Cu0vV58Hc90HGXUACIVk?=
 =?us-ascii?Q?t+D0SVnWsGdZGj7Yjx1Uh1kTGf+GSuQTUXnAZ6iUch5mcOv9jThq6+Hwnaru?=
 =?us-ascii?Q?gQbtHGAm0bs7XPIVgVY5NZcpPnYwXhiaDzbHWgyuZBaxo03B7AFPbGTEXRN4?=
 =?us-ascii?Q?f3UNLWDzkZjJIk/DHPtwal4/406hOAmKk2dsCsIbi20Pl+9/0slnTAu3wDFn?=
 =?us-ascii?Q?qidVjbTliN0uY2kFuqUqQS2LP3rWO0ETF0f9ySwgp/XFYdnTe3hi?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07ec34f-a30a-4508-dbcd-08decc4b8afd
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:36:36.0570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbHE7yeeEbkWbnjbdPo34XwhaL4gQRjDjAP8ez6ucGgaDrEfQBbI6XLNyYcqFrhvm4OisB//OGhUJMn5XdidIPARzr7BzYth8njX77c3H9CQInCBwi565DXjyyGs2Y0N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12634
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:36:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23216

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
index 3e24e916874f..9be57785d9d5 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -183,6 +183,13 @@ rsci9_pins: rsci9 {
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
@@ -250,6 +257,15 @@ &rsci9 {
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


