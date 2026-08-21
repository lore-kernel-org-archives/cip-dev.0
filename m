Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DF3C5DF94
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 13:17:23 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.24])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7172.1787318238310962227
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2026 06:17:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=X2CkGawa;
 spf=pass (domain: renesas.com, ip: 40.107.74.24, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJ4H4nk5OSNqsMXtw63W0WUBd9umlyiuv0Kcv2MqzIaLSvT+h1+DpB457M/P91dQVH5pCCiXDNiTfH5g/EL1lIv8F6NQMCdhZ5hVHVSyq5Pfzb23/Vo0O1ZCwHJKjhyY6voz3H72R5sd334HW+1OiHJOI3vkOaa/UNeO9rGVawxpSrLRGZox6fPGQ74+qACPeCnJkWrg6zmE35KFM8SL3rCj2rKAkHWIuxWwVckY+gwaD6ZDPJt3O7JIAglFb+M/t5Jyh0KaOY9YceFTueGind8smYbAbOWIa3D2xGJlWymW49kn6d57VQeiGDyIj4FY5F+rs2U3WdR5bBuVcnhhnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xnJLE+4ZC7rlQBWwTk8pZ2Svf5HJa/S4e33CzB2M5M=;
 b=MhS1F6fKgbuNyZMH8EBdtsihKUQFh8uMuyvM5pyDwkTbhRdDGOIuEUnTBAju8n/a4oqQMtmfcNdKYWCowMaTrspARDEd4mlXB2ORjK1HmfInn8X2NNv7lcF9yUOXFDBIMVjdV2P0+6Is7se9EsZNGDJ5zihwtemJygyjVWUbkyoO+s9Gtz2+QnaH6dGEjbgeML8d0ldPi22m5VoSg3EpNQSHK2GDHFTpa8qV4Vihkblx8nTv+6fNOYPC4ktFd3yxYa6B0o9BQs/wyRHrg2eMQ3VnnVBs9li7UHcxlP2tEwad1LI9InpqQezC87ZNw31nXH4J8ygQBJHn1+xdP2fiqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xnJLE+4ZC7rlQBWwTk8pZ2Svf5HJa/S4e33CzB2M5M=;
 b=X2CkGawamzgG/rz9wjdQ4YPoaKq9ZrnaZGS3wo8ZSG4aYmFuc8qnzVrHw8y67O7Yf6O4YHGen8b4LdvVrKI1B83IhF0w/2fYEJobSYDL629DK4MLTZtiISdXBSbE7nN+eFWc+yfgHHpeuCxweBvu64z4iGyZ584PwF29R85KL2I=
Received: from TYWPR01CA0051.jpnprd01.prod.outlook.com (2603:1096:400:17f::7)
 by OS7PR01MB14350.jpnprd01.prod.outlook.com (2603:1096:604:38c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 13:17:14 +0000
Received: from TYO1EPF00005026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:17f:cafe::42) by TYWPR01CA0051.outlook.office365.com
 (2603:1096:400:17f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 13:17:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005026.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 13:17:12 +0000
Received: from demon-pc.localdomain (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.179])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id BA9C23000374;
	Fri, 21 Aug 2026 22:17:11 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 15/18] arm64: dts: renesas: r9a09g077: Add GPIO IRQ support
Date: Fri, 21 Aug 2026 16:15:51 +0300
Message-ID: <20260821131554.638741-16-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005026:EE_|OS7PR01MB14350:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e2c370b7-1e6f-476f-a739-08deff868383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|13003099007|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	TZMbD3fRrk/DCZeeV6cVhxkogfuK+hTfueRZtpVcKlm8GDDwPQ9SxFhLI67ps68sJnTmVollYEBDq8uRS+olx/9HrLVXEeFTaLCOUUW5ALNpTdw0E2HoraLsvZgx9n4cGyPDFCKR4qa0oX/n15zAmW/kuhqQkvtSF+5GrDAztNb1M3hO9Yspg2KtG/Iofub477aCxJQwsj2OXzxpX7i88LTT34G91ThRrbXbxIdVGrG0wKLccXB5Kd6S1vrhqZZwG9KOaRrU9iDYzfLkmStjd/Vea78233Erm7a3IOarPC5LYLC9990cJMzC1TbcWoHH5dPrPSY2cBAh3zazwt1gZPShILYajXez3BP4aYToU+DHSHRvEl8ZKlg6XEdV5iT+9RxjGgTPdTTJq/3uHv/Fy3qoVwNsomG1UWJ9E24XOhDRPOJv/NvKYgTpLndkSLx0BxFe+vpN86Br817McSex4mIOAPPfGnK9qLPvWbN1QNHlhc7poF/czGQArXI0ghAJUxl4jh97EUG01voRUX3qlhda10R/RWAhTz3njd+B8JcQafAnX8qEtXmz3NwHBfUhtWk/+cqw9qohXXg7SJMTLIYp2dmfNUabCgO/ubiWgpDTulnNZ54iHRkedS8hXXAOVi5uRTuyoMXm63UfUVJltyzExT+ZrqrueBFurndRwek=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(13003099007)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	qhhampi13URy5Q9Fa5PyaOrA9VFtT7XfQG5FQy671xFbveiVZhQczb3myzLrRjnTJicixfYL5VSIKtSu9CTiLATBTzKYuoOheEGbxufoPYadTdYkvUCeCWmtNeZSmSY8lsSRz+YSe7RoqIYMf/XFBN2pT5AUU2tVNLWYWHpJOWaLJdNgMqlmE5TOFDGZ1yShXmvXNPyfI+VHmUCA/C6KVUMpZ8GaTIRQERhMY7SNQTK1kgt5lmv12btSl8Cnz4RmYk1uKXnKbvqdheMAz79l98CxwCoUUz9pilQoo7lSl33NsFGbDps1zfK7xSdkowbGbaRwt/2Ks2HSSucYdp7X3DhLll/4TjEdd7lffn8k2Fa32gxpxKojmlP1+Chg8thrnawgqXJRuYAz4t0iFyCvPp76VF3PdqIgRv+hg9fPlsmBmxtdoH1mzSfb+N756IDR
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 13:17:12.9827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c370b7-1e6f-476f-a739-08deff868383
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005026.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14350
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2026 13:17:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23972

commit a0c0b921b63902b3993bf60bd0ab8c3041a23481 upstream.

The Renesas RZ/T2H (R9A09G077) SoC includes pins which can be routed via
the ICU to generate interrupts.

Add support for using the pin controller as an interrupt chip.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251205150234.2958140-6-cosmin-gabriel.tani=
slav.xa@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g077.dtsi
index 824e1a17050e..00a1ef6ac7df 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -1011,6 +1011,9 @@ pinctrl: pinctrl@802c0000 {
 			gpio-controller;
 			#gpio-cells =3D <2>;
 			gpio-ranges =3D <&pinctrl 0 0 288>;
+			#interrupt-cells =3D <2>;
+			interrupt-controller;
+			interrupt-parent =3D <&icu>;
 			power-domains =3D <&cpg>;
 		};
=20
--=20
2.55.0


