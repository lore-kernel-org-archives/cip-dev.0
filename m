Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2435C88E5C
	for <webhook@archiver.kernel.org>; Sun, 13 Sep 2026 16:37:59 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.65])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2211.1789317476399695658
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Sep 2026 09:37:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=T1ovhzqz;
 spf=pass (domain: renesas.com, ip: 52.101.125.65, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBa7ZUKlUkZBM27OAdz6AChAD2SttbdjmL++MoelF8lsmVGTFsNIGOi+IIfRLR/Gojk9VTOdFqVWeu3QnRbNt/Ed1UuL+aPVX0V29mXSYd8W3+T97IbBfigLKbbBixUrxLy5q+Bvm+d8EE25BlDfj7QG57x/x1RVqVYM1aOeYV2EENQ/S/qngjIREuOE0twy8DCA2o1flzH8wK6hl9QIG9IPT04Q2UkiB3lwB9y+HbSlTUQ9qkI/r4q6N7p0SE+EM4DoubL1h6k05sbrrjCGH8cGcEGl3gZUsCOrFPlJsX3HdiE0wg6m3E/7sZfsjNQq5qQQxyzmdW+PkCGkF4anbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r437O7Vs8QfdYbechYIA1/bRiGWSqQxqOnsOR4BKXZg=;
 b=F/7aFY1RAgOo7ouiGBIj5kO/0548OdcxN6naHsdqV3/AgWbKZCDbxgRzXpYwJAQr32+zy6kj8gg8THI+HYeOoH5L7ALNjw30lPbCcNm3hEd/6uhD4XDvL7eWEyTD+uP9hggJoEvC7J8M12Lfs8pc0R0MejfGUJdDyCJk4cuaAcmGaVy4TaRSE47zcZUrq9qeQ+jSYP+xWc/GOhcUk14iT+DjZnQXa1lx6MheLfDt+RzjMXh4KR2bGWqWnq0gPwFmUNKdO2RaD/E/IZyifqYmiHrNDjA/V0gnr3pz5UY5emWbsRMMc7BFAh2oIsRh9e29DxNtvYJKKhFsM/SaupLNuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r437O7Vs8QfdYbechYIA1/bRiGWSqQxqOnsOR4BKXZg=;
 b=T1ovhzqzfFmmk9UwUFwDHyYAATS4+PsZFmgHW4i+AH160yTKeYCMHZJSmRjI9kCc28ksHUDyfzSjv7N5l7z7tRhxz9XLF+G57Mf3j2J6lBJ4WVKLfpM3YvG8NL/xqmJN+rzwxcOOn5CmFqthiQpWdQWSeMbp7krXYnux5cC0RAU=
Received: from TYCP301CA0082.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:7b::20)
 by OSZPR01MB8321.jpnprd01.prod.outlook.com (2603:1096:604:184::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Sun, 13 Sep
 2026 16:37:50 +0000
Received: from TYO1EPF0000501F.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7b:cafe::73) by TYCP301CA0082.outlook.office365.com
 (2603:1096:405:7b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Sun,
 13 Sep 2026 16:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF0000501F.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Sun, 13 Sep 2026 16:37:49 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.2])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id F2736300024D;
	Mon, 14 Sep 2026 01:37:47 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 2/2] arm64: dts: renesas: r9a09g057: Add DMA support for RSPI channels
Date: Sun, 13 Sep 2026 16:37:27 +0000
Message-ID: <20260913163727.77875-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913163727.77875-1-ovidiu.panait.rb@renesas.com>
References: <20260913163727.77875-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF0000501F:EE_|OSZPR01MB8321:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 30778003-2081-4fd5-0533-08df11b55928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|22082099003|18002099003|13003099007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	cUqnpTPM0HiYEcJNeN2uug/SwWPis1I28jayQR+mjNHeWMZBHUlzcv6nY6sBl2iiWlHIKsLDV2euX7KXggdOxw34F30PyLwVUx1zb7PW19MmZm4uvl55ppT+FDZHnDntjrMfd8qigkHGe9PuvoNypdlOGJixLIcGP+nPEqfgl/uNbu3GWODEvZ21f/E5cgsJ0T1LLFpAMvJaoKimxnD937gDC8WrYVw3v5EF4epINBXupsWBiwHA6+3P0defWAsZoBJ9XOB1ikznWQLxYHXxJZdCPygf1gAUfxWWgdBb5g7r0M+WTEPBTJq+oaLlPc6ImIPrp6U3ArOJIv2NkFDJBzHr/rb1V8707/sDQLmQT7jzTHqPTTB1lBHM+rcXJPXV/IoUBq4ejXdbmN078qtw8uuwepesDXHKwY3eGwYSD7m5a2Lalp5AEpj72CGaAG4MQnCtlQDKTXiuhg5zpSS9/2I4mbFBMJPCp4+MQmA0Mv1eThLhZ+45sY3stFh5ByDWIz/uW3bWWV8BK8JTLrLCiRLAZEZrFSG7SUyK3J5uoYVtiBuH2CxZKFPgpE8rb1AnSCz7rwZC86fbWnmic3tSuMQif/nyQ4bvI/1yQbASk7bp6lN4udH8KdST9lEOuOXHelFNud13SYqkny2wca4wRw==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(13003099007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Ks8YBlHrjWDqAxPPzsRrHQmpjxybTGerJndKw7+IC13IK6sTZ76a6a7Kc6TDhczpSalp+vdobhxEop8i+BVl2Yof0LyukIY5QSRJda05UPi0r/Y3Hsmn9a1hQ9af/FFH24xOgdgXTQUYKZIw2FWzu4YgdUyNWK4oHTcf73r2rEgNYUoZXO0ScnnlhKC1GBWzHUFIPfLO1i+lyO2CUt2L/VHgg77mvsxhVuCSzdwCxNiQfpEvYdMO8JFY/0u/WljRzgI7fAg/db/JCFP+HXh2Q4XYURS0wiEB9UduPywchSaBZTb817ZQG56MeiotG/B/biJochfofpAl41FdY7m/PNszOQPEf6/+yJ7jCpxyiMql9DOnz98jiGAxhubdzc9iZq0V7/n6ocFjaP8I7/nOlZAH6nrM4V9jmy6biMaYyx+rfqocWDxchfcZVqpt9/xQ
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2026 16:37:49.1918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30778003-2081-4fd5-0533-08df11b55928
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF0000501F.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8321
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 13 Sep 2026 16:37:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24160

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 6c9940cbf7f3e7f9dc8f0ba3de74640ca9e66feb upstream.

Enable DMA support for RSPI channels.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260303233314.2928711-3-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g057.dtsi
index 5ab873a4702e..d2cf6e2f7b6f 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
@@ -727,6 +727,13 @@ rspi0: spi@12800000 {
 			clock-names =3D "pclk", "pclk_sfr", "tclk";
 			resets =3D <&cpg 0x7b>, <&cpg 0x7c>;
 			reset-names =3D "presetn", "tresetn";
+			dmas =3D <&dmac0 0x448c>, <&dmac0 0x448d>,
+			       <&dmac1 0x448c>, <&dmac1 0x448d>,
+			       <&dmac2 0x448c>, <&dmac2 0x448d>,
+			       <&dmac3 0x448c>, <&dmac3 0x448d>,
+			       <&dmac4 0x448c>, <&dmac4 0x448d>;
+			dma-names =3D "rx", "tx", "rx", "tx", "rx",
+				    "tx", "rx", "tx", "rx", "tx";
 			power-domains =3D <&cpg>;
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
@@ -748,6 +755,13 @@ rspi1: spi@12800400 {
 			clock-names =3D "pclk", "pclk_sfr", "tclk";
 			resets =3D <&cpg 0x7d>, <&cpg 0x7e>;
 			reset-names =3D "presetn", "tresetn";
+			dmas =3D <&dmac0 0x448e>, <&dmac0 0x448f>,
+			       <&dmac1 0x448e>, <&dmac1 0x448f>,
+			       <&dmac2 0x448e>, <&dmac2 0x448f>,
+			       <&dmac3 0x448e>, <&dmac3 0x448f>,
+			       <&dmac4 0x448e>, <&dmac4 0x448f>;
+			dma-names =3D "rx", "tx", "rx", "tx", "rx",
+				    "tx", "rx", "tx", "rx", "tx";
 			power-domains =3D <&cpg>;
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
@@ -769,6 +783,13 @@ rspi2: spi@12800800 {
 			clock-names =3D "pclk", "pclk_sfr", "tclk";
 			resets =3D <&cpg 0x7f>, <&cpg 0x80>;
 			reset-names =3D "presetn", "tresetn";
+			dmas =3D <&dmac0 0x4490>, <&dmac0 0x4491>,
+			       <&dmac1 0x4490>, <&dmac1 0x4491>,
+			       <&dmac2 0x4490>, <&dmac2 0x4491>,
+			       <&dmac3 0x4490>, <&dmac3 0x4491>,
+			       <&dmac4 0x4490>, <&dmac4 0x4491>;
+			dma-names =3D "rx", "tx", "rx", "tx", "rx",
+				    "tx", "rx", "tx", "rx", "tx";
 			power-domains =3D <&cpg>;
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
--=20
2.34.1


