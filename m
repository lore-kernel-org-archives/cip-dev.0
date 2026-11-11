Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.60])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5739.1794388779894302172
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 01:19:40 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Gf48iA2/;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.60, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAy6Hu9jkf1xN2FKhsI8ba0kmYYhy1OICB2vHf4DYDr4w2I4eegNxbddWWO5xAtGWRRm34jh5iufWR6bKR1Jm75QfpNykHq+inilWx8xczBvuWL0meEacsRcv8xIhO0cnuCBKSYfzStQtIuwliLK4gQZq1G3Zuft1PUrPKKthvQUXujsokfhgqlago5ztG/EHh/pQIiE4IbzcFK+vxXEAwXJ6uEdgG6PNfOIDhf290p+GMQQGTRV/IX78luWl2yFA6rgvyOyHeHxwee1e3bgVbLB/A/XtieJy6IhRdsuZ4+6GSRQ7RtWX3OgAaZIBmTTreTHcn5I1riS+BGYcnASmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8NlNK+oJv2NwEcQDpJgMu3ELO/FmAjiExMfWtdKGuk=;
 b=SUSMOOPdKnei9I/hdTbm0kaX0aKAVj4ZbibklKT6t5PjgvjkdBZcVViVmUBSQLSIHQc+etRWN5rfA/KS08JaIdLEMhrNAIrhFJvQR8oVXL5/Rlh0MSCAIiz/F7vjjTtEqtCA8oh9BGbPn3ypAR2pd/2xu3F93r5AKAluCwuLIkCS8QjZ0xcObHtP+wBiimm81g/epXrnLbL8yTDhPoigc34W7f8WifIQJcXbPqz74se+1v2TsaMMnoTM4KbAnWhkOu9QWnVTvT4azNX7JCvf1XlolMzqtHfifnlBItxtgDkjB0xwf/R/CelWe4QJPUMYmfJRJBiIFCv2sqlfxBMEDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8NlNK+oJv2NwEcQDpJgMu3ELO/FmAjiExMfWtdKGuk=;
 b=Gf48iA2/aZznofW6s9cMDR00B6EXcmUS1Br/ge1QUxY/ziPpuvLG4k/Zw4Kr7C81xD9SXozO/za1QE7zXmmPrlpUm/oJt9qHpkCmaLUgh0IN3Ab6ZQNALMOPncvFg8OfTN833ukZxb+pyYJnYJQaUeEja7HoeOo41OL1d9jQo0U=
Received: from OS7P286CA0024.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:26d::20)
 by OS9PR01MB15929.jpnprd01.prod.outlook.com (2603:1096:604:3d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:19:35 +0000
Received: from OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:26d:cafe::55) by OS7P286CA0024.outlook.office365.com
 (2603:1096:604:26d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 09:19:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20D.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 11 Nov 2026 09:19:35 +0000
Received: from Ubuntu-22.. (deu-5cg22344cp.diasemi.com [10.24.0.52])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id B5C5C3019A06;
	Wed, 11 Nov 2026 18:19:33 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 19/21] arm64: dts: renesas: r9a09g077: Add RTC node
Date: Wed, 11 Nov 2026 09:18:58 +0000
Message-ID: <20261111091901.41995-20-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20D:EE_|OS9PR01MB15929:EE_
X-MS-Office365-Filtering-Correlation-Id: e4fc0a77-fe35-4463-d2a1-08df3fd4e708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|261009223027099003|10067099003|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6Yeo8YS+sHHTygv2lnWbr7pc03LyB7V/3r7AgYPdovLBHwmDfyYIxYVTuAuuClruTlX9CL7OZLJD9X01R7LU8nUJCkCv09alslxPIv2VbYNobaeoGXLK+0ixxedDff09Ik86dr6iD0upPvLrX3m/XFprduhkqAvJnhFWDk8rJK2HbKr1QbkA1erbpiUKc/4RteFhkTdvZ3bqtAcGaUsjJVwivYuV2aBd7s5BOEA54AVRNBtMhDTBizQz/Z+0hhrIBXSO9pNOKQc402WT309A6s4sROdSO+ie4tRlN3KGWeySz46Mj5H8ih+L6JQr5bAi2LRW3UiufyIlr+hvfro1BvFaBJbQD+k06bDD+ynUsmL00F3jAL5Q3OaysIFEglshvSIZpg8iTi1UwMEd/xg+9dgw5SnKMOGAvRKW2lcULLyulXgha19oKFjIjVwE38+GzE830+CWKxCGfycCGtyanjbhwI4JIfODaIwnAVZRWryyGfXJG2yCRPao7depxDTRvqUMor9qukfogBjQ0DWqZURwXQ3uw+ctliRtJzBmVcs3tFSrSzb/SJNDrqnYMZjPcVkmE84biDH/HuKxG0ykSKC4lqm3t1YhsDoL5MxXxdul1adCqhllyQ1t6bxc8aNW5gNEIEfEyLHh2RRQmuvxkUd+kqUyLzgtsD2c++SeFP0=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(261009223027099003)(10067099003)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TYIRJOyC8mx+erwGt7pFCuNcbRNw2YEJQq5TX7to9TfF3xdzj3SyQlEesInJIIEI1QeK+DJUNWavZHlOpuMO8NPBUAT9mbnxvMHmmCMV1CvgRgJofHKC+VNSuBlUiQRjWAczMqVUNGbfXfF2DvxJULSXYINQhnw89iH1C1THbHZe9Gk8JcQc5HRi2gjILgcYrKrHPz4Kz5ZqWT5F1wPSIqqgh2euUN/QSBVP1S+QUAtfA4EXZtazAVG1+0QhLIIhtiGSn+Fhee1EzGWX+84bK4VRqPWjZdS32ZcrR19jc2YCd0bKHBmsDtPWuk4X5SOEOwN/FoMxXnljwiZnuEFfKuEaELcbWTnh8dYaLjNhaCQ9XXmmJYBrs8a4iCALRcjTwMVNFfIFui8EgrWaGvH8UpZeUvs1MgxDF1cyz/AwEQ2hNvxTStc94cp3BG1n/0Jb
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:19:35.0982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fc0a77-fe35-4463-d2a1-08df3fd4e708
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB15929
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 09:19:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24760
Content-Type: text/plain; charset="utf-8"

commit 1e3a5bc8da6e6fb1a1167b6a4cf9c2d3e2a546e3 upstream.

Add Real Time Clock (RTC) node to SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260824075936.2904336-2-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g077.dtsi
index ef84bb19ec63a..0a741b76467f4 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -1107,6 +1107,19 @@ pinctrl: pinctrl@802c0000 {
 			power-domains =3D <&cpg>;
 		};
=20
+		rtc0: rtc@81009000 {
+			compatible =3D "renesas,r9a09g077-rtc";
+			reg =3D <0 0x81009000 0 0x1000>;
+			interrupts =3D <GIC_SPI 495 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 497 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 496 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names =3D "alarm", "timer", "pps";
+			clocks =3D <&cpg CPG_MOD 605>, <&cpg CPG_CORE R9A09G077_PCLKRTC>;
+			clock-names =3D "hclk", "xtal";
+			power-domains =3D <&cpg>;
+			status =3D "disabled";
+		};
+
 		gic: interrupt-controller@83000000 {
 			compatible =3D "arm,gic-v3";
 			reg =3D <0x0 0x83000000 0 0x40000>,
--=20
2.43.0

