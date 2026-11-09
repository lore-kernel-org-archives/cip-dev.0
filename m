Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.16])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4690.1794226531813277955
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 04:15:32 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=SEm+A77f;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.16, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSHKAgvVCxCjbcXh1Jpee2D09mHfDkAe8mDemB1N2epw8SAADgRdvGS71Ay//V6n7vqdyJwl+PiRF5P/+w+CtDg7hVBZYJF/wmlhInCxqRsEkUi5P3TBXxIdy5Hpfup49hqlLgUzXbH3Xp5hjtACa4qPqkzAsT2H5geDaa4Vj9IW7gDHlpilaYqXenCt8byeFgmgjST8pbMQHB1Jq96nN95palBvMkvt/PGmi01sjtmheTgDTt5swiutH54EH6rHaBOVgg+wrdzwxQ9rwTLiEgJkNLFqxZimMS2nuKzA/6Dfaa9wk3lSJ+Ak9QDUd5iNPymhv9ae5shUiryZZJkTcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrhktIqUxETm+6qUrRAI/qoot4PhRj4vD2/BdAbMkm8=;
 b=Y0SqC2DV/DK5OQMWzIh1EHDBLkP4EYoithhLR6rMa9l233TF7zWhwHtvDbRXhBRI1nXbTWZynRbaYMpf1WOfWdJCa/8RX/NqBpX33jwnVG7uJxKtmzzPGHgcnmbme8eQaZjXKXV19veWXSO5cHvRos8cd/tIpC/WStjNKB932e+PNdQprLDFmMMtjU5+pLa9nR0A/UMp8LnWkxtM7yhsLRIGrcMXa8+5wPr11B+aDQRni8nurRxgv5yDk99vnerBwjKrAPvPDfzrmpj9s1cEXOmjY/366uxS2JLNXFaKufUJ3kYxaVFMuqYEyByOUAF8kn8sLCCikGlc58oiYEL23A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrhktIqUxETm+6qUrRAI/qoot4PhRj4vD2/BdAbMkm8=;
 b=SEm+A77fLoK60eJJEEMb3cK0RzbO6RTW60YtILV8f7Gg0mphw7WZQL6OryNSq34UyEb/OihumiRJVbB+bNH8cC1zR+zkAyCZdRQ9AZpDbBlKJsQf+T0j4AyOVq8ObvjA/Ez5XVzMwuMisyhN0hWM6yBrJrTDd8JdUWqbpBzwJOw=
Received: from TY4P286CA0105.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:380::9)
 by TY7PR01MB17956.jpnprd01.prod.outlook.com (2603:1096:405:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:15:27 +0000
Received: from TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380:cafe::af) by TY4P286CA0105.outlook.office365.com
 (2603:1096:405:380::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 12:15:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD9.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 12:15:27 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.1.30])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 397DD300022D;
	Mon,  9 Nov 2026 21:15:25 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 20/24] arm64: dts: renesas: r9a09g077: Add DU node
Date: Mon,  9 Nov 2026 12:14:47 +0000
Message-ID: <20261109121451.6042-21-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD9:EE_|TY7PR01MB17956:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c7e5dc7-9b81-435b-d240-08df3e5b23e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: R1upEBumAt09omFdOtt8+ZhUsnK8acX4j2msnL1UGF1BnKQimMtT2N1Y8cVZNjMEAVpF2JxlBJDTovlVozEGuezTrxA4prexRbNhUoxacqbc2/K55TJUGTlFojzDS28XCm5HlVp8PFtPlxquubCemdbvARmEEu0Tfiu4QW/9VpY2CoIkeCKjkAtGKyyAjV988LZZ3iyECyBTs4+EBvDIOESZ/9xBr2n4+TKgYyl8eVhv5C0IlouGC57s+pC+EClFaO5tWbs4ona7fSm7CI6zDkj0NPgmckp63/cCD3wa1MeRzuAiBYfco5EipxU8zd/TmUk7njenUnkhv9BaU72JfjeqaMd8cs9oXdHgns1pzqUqorEXBuBCk1WvdTBQoMAZfrqDMEfkJEuu2V7uQZbsobDO2jgUsu7hmpsxzJqwXqelNktTwVx1ez5optuNLq21xA4eU8FfT3NBo8XQG8iBkJ+JFOjYlejpIVL7f9g5CiUwRx/X2xOi395e9vEiXS8pOvv5XTjNtkwHHSHq63iChNF/AYLG199lNPqMe9tww0mopkr5BUqO8o2miBCcHEtW+Jh2s6GsBLO8gnrvMzGJORz3U68HZ02q2Ep1Hen82P8SG16MU2L0P0/F5MFs4HutEhpLDHCiEG3XYQSAO0Cl+Flo3WCfPEDskTdf5mnPCuM=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SsqCHIA+KrkzU8o4HW0jWWvFGQQu6TpXUZQ3UGFuQwejoHP7iziupzES9QYt9p0rASylfqk7qe11kMlZO638jgfVzQyQapnuQ2ZlpxMqZS5MT1M/ujSoh/nHoFShvouehG7aGjGh/3KCFm0OmkpS8mpSJVe4lHFe7SZ05hsTePyOnbkaM4Pc1aRKyK8u5h7FEhcbhIF1RZmPjrqUKTrH+2LtYXJKTcBkbi/cRGegMGTI1uCuGY8iBnJCIql7Q8jvp+lqgUMXdT1xjDasWWAzKFBbYmVGGJ9j+6JM+MSP76c5UVSnNwzbNt81FeBTbopQM0aFdUHTDigBOkc3Js9rDFi9SPyCjDh10e4aavMy0/kFQiXCg3IF0Ujk48JMLnQYGEiNPvxbcyzER5gtTjiyVPiQSs3NjMs3LSMK8Rkm3ffk1vyIXOpTOxQsqddZs6hA
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:15:27.4843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7e5dc7-9b81-435b-d240-08df3e5b23e9
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB17956
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 12:15:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24722
Content-Type: text/plain; charset="utf-8"

commit d49ff6f93605319f99b2416a61c0c40ae52dbd23 upstream.

Add Display Unit (DU) node to SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260615115455.1412098-3-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g077.dtsi
index 6b26549997718..ef84bb19ec63a 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -1270,6 +1270,30 @@ sdhi1_vqmmc: vqmmc-regulator {
 			};
 		};
=20
+		du: display@920c0000 {
+			compatible =3D "renesas,r9a09g077-du";
+			reg =3D <0 0x920c0000 0 0x10000>;
+			interrupts =3D <GIC_SPI 781 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&cpg CPG_CORE R9A09G077_CLK_PCLKAH>,
+				 <&cpg CPG_MOD 1204>,
+				 <&cpg CPG_CORE R9A09G077_LCDC_CLKD>;
+			clock-names =3D "aclk", "pclk", "vclk";
+			power-domains =3D <&cpg>;
+			renesas,vsps =3D <&vspd 0>;
+			status =3D "disabled";
+
+			ports {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				port@0 {
+					reg =3D <0>;
+					du_out_rgb: endpoint {
+					};
+				};
+			};
+		};
+
 		fcpvd: fcp@920d0000 {
 			compatible =3D "renesas,r9a09g077-fcpvd", "renesas,fcpv";
 			reg =3D <0 0x920d0000 0 0x10000>;
--=20
2.43.0

