Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408BCC44500
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 15:28:27 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.26])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.94851.1783092502784670070
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 08:28:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=wIvg2gpf;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.26, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/GUyCcKfrKF3bho3kh14nrrhdMbsPGI4kIypiQPeoX48G5laa9q+KhuDVVRm9ih+60EXKwSgmd+eA55+6lYWwqlzxXAlA3NaqbbSPYoCsrbT7EkFozlPyRtnXV2duw2U5iWnro7Bfbo1sGLtvKgSG06e6He4ERYk76sBpcIVLxRCSszSIZgGXp3EC2E3JQ/QDnMovcXPqzNJZt+U5DB7MCZHjiOm3xSGBhMK29ihvATZzX47IYCoxrqeybi/gsvUE9dNxBaDXpTJtEGZsUGJSnBr5I6Zaoy5fWN4W7OjPceCHOO/28lX13bCJyC+wK8f7Yt/tPNs5TByOznx0lhZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeHP7Xwol7xaewmwFFMjH6rf2H46W1bfVQDlbEaXDj4=;
 b=iY7pQpyf5v1Q7ZNBZ2IK/hezsmUm8crfdEw4sB1J98JgXi2dOXDkQWAZt6lixULJDl9otW0huy5j3MBD14LAW5U7xBm8vGQhTQHkjQrj8+fMsaYxH3wtWyTDGRnInU+2ELrx/fOgHMX4KEmw6+EPTwlsGisxKNto2+baqC5xpK066Y3gsy8YEG6THj1HOmYFjoKZ4BuExiS3PhNyJJ4i2+tpbOdSDnUth5SHi4kjtSTzIY7cbMSGI8hGx5QUCCCzHbvYi5quUVedKMdNdFnDsWz361jx+bpbx516FzTzk5Jn5nI9bkR4yNGDsCqDIC4rQ6go3u6AfI/BLtx/wacw4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeHP7Xwol7xaewmwFFMjH6rf2H46W1bfVQDlbEaXDj4=;
 b=wIvg2gpfXk4fCbMq6OLLjuYvcyjhLF8d0Q4GflnngBJbRndU+7W/1jgHS+LjgRgALQpWzhTUPhVbdhJ+43+xJw+DKNPGQ0bcadF1jLWx6zDSwMy54OFRxQAhSBaq3M5bVWF8WRpYJ14cDQF/egU/SxVVTlH9vo8hCt1WGJ/7jog=
Received: from TYCP286CA0247.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:456::18)
 by OSCPR01MB14424.jpnprd01.prod.outlook.com (2603:1096:604:39f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 15:28:14 +0000
Received: from TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456:cafe::2f) by TYCP286CA0247.outlook.office365.com
 (2603:1096:400:456::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 15:28:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005025.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Fri, 3 Jul 2026 15:28:14 +0000
Received: from Ubuntu-22.. (ukr-5cg4053kvs.diasemi.com [10.24.0.5])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id C3720300023C;
	Sat,  4 Jul 2026 00:28:12 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 3/4] arm64: dts: renesas: r9a09g056: Add PCIe node
Date: Fri,  3 Jul 2026 16:28:02 +0100
Message-ID: <20260703152803.29302-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703152803.29302-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260703152803.29302-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005025:EE_|OSCPR01MB14424:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8e14fe2b-e867-4503-323b-08ded917b339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|13003099007|22082099003|18002099003|11063799006|56012099006|20052099010;
X-Microsoft-Antispam-Message-Info: 
	46I3ER0/VYh+QUCSjw1Fw22QhDOS7pvSqtHCJxkHzguTYQIo62m6K95Fm/aZbGfM5s7a20laX8Wa4b8G/4k8aj0ZPsV+bVWAJWXW24T/pAA03BLu8xpDJ5sTBPvVXPdVqEX5UuRsPLaPnc/1RQmrX4o+O57BckYcvRvtdxJu4xCzsRK7sidvUZ9OX8a4bsjBuiVpLmkAY4UEGQ24nSsLocEkjufVkCFMqz/y6w9TTank8AbG0jbu+kvSUri7gtGGPrkZhVqzX9uy3BHFxx30HWpclr6chuHYj6UMQKUkJVrU7pt+yPxu7IzkTvJSkGTNA/+erlNv+tpf2LTx0mMBIkn7UKkkgT43GkYcEqVg2MwjRtg+KeTE3lNJec7uBA0MUzE/UkU0kq2Q9OEdJGqsdpAwMWCdlIr8acIveNHP+bUoJFiLcCERSb5B6ugmxUuuZP45F/lnn3q2wPw+w0B03gU5iOhPkBTmUTkCtQHYop1rcjsaYfzLRFLZkzE1LRMm+072YL+TuXKgy/9lB2cRndl28NktUFG9sfrHHSvbKZ2U7SHARBAtDg87UP63OmPwvw1qwn0fBymTYikawbyXkQIpE5I7eLxKTw/PnsyXkjnB/erd440tg86v3yb0xZ2oQ+1dtpPnzlxjNERrsuPm8I0r8k8GEKV4L7qVD/6lhf0=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(13003099007)(22082099003)(18002099003)(11063799006)(56012099006)(20052099010);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	u+Z1lUxPLPULiEYSTIu2Cfvedl+ZHFlT4POp914Fzll6WE6tPrFplExsARw+Z4yMwtW3i4AaDZJGGk3a9GoRfmFjszXHcwZgQuOrmMke6jr1ezsOCpF7e9chHfaMQelK8dda1CjQb/sg+9jzdJTWDBmxQVYQcHZpWA6PDaaY2FrVhKeqTkPc/MIRULVqmtST+wU31/9AMG5SMxdm1jOI1vVjHqPI9H86FimSHfbIY4x7piFJqPDLWgIHMH3HciUmtCqWUpvv39DznFAd5HZEbr8x+qmrdPEYR/0tj9Y0RdbYWJl9xGBot8SIlJ75JPO7HxOBbDBXijUrawdIluttp/rwpsh0703gRcGOFJzpF4st/pe/TPsThaM5tdpdXvvvC8NeXZCRb7cwCngMKZVqhtZy7JYQ15d+zBqIzqnLp+N2c6pSfEu3fJSzfssOPw5n
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 15:28:14.7024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e14fe2b-e867-4503-323b-08ded917b339
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14424
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 15:28:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23447

commit 4c443296ff17f5670ce926f47de8ec5a1f50f857 upstream.

Add PCIe node to Renesas RZ/V2N ("R9A09G056") SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260501105116.33452-2-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g056.dtsi
index a766d35effc5..d76c0608524e 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
@@ -780,6 +780,75 @@ rspi2: spi@12800800 {
 			status =3D "disabled";
 		};
=20
+		pcie: pcie@13400000 {
+			compatible =3D "renesas,r9a09g056-pcie", "renesas,r9a09g047-pcie";
+			reg =3D <0 0x13400000 0 0x10000>;
+			ranges =3D <0x02000000 0 0x30000000 0 0x30000000 0 0x8000000>,
+				 <0x43000000 4 0x40000000 4 0x40000000 6 0x00000000>;
+			dma-ranges =3D <0x42000000 0 0x40000000 0 0x40000000 2 0x00000000>;
+			bus-range =3D <0x0 0xff>;
+			interrupts =3D <GIC_SPI 800 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 801 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 802 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 803 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 806 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 792 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 793 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 794 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 795 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 796 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 797 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 799 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 804 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 805 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 807 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 791 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 798 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 808 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 809 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 810 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 811 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 812 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 813 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "serr", "serr_cor", "serr_nonfatal",
+					  "serr_fatal", "axi_err", "inta",
+					  "intb", "intc", "intd", "msi",
+					  "link_bandwidth", "pm_pme", "dma",
+					  "pcie_evt", "msg", "all",
+					  "link_equalization_request",
+					  "turn_off_event", "pmu_poweroff",
+					  "d3_event_f0", "d3_event_f1",
+					  "cfg_pmcsr_writeclear_f0",
+					  "cfg_pmcsr_writeclear_f1";
+			#interrupt-cells =3D <1>;
+			interrupt-controller;
+			interrupt-map-mask =3D <0 0 0 7>;
+			interrupt-map =3D <0 0 0 1 &pcie 0 0 0 0>, /* INTA */
+					<0 0 0 2 &pcie 0 0 0 1>, /* INTB */
+					<0 0 0 3 &pcie 0 0 0 2>, /* INTC */
+					<0 0 0 4 &pcie 0 0 0 3>; /* INTD */
+			clocks =3D <&cpg CPG_MOD 0xc4>, <&cpg CPG_MOD 0xc5>;
+			clock-names =3D "aclk", "pmu";
+			resets =3D <&cpg 0xb2>;
+			reset-names =3D "aresetn";
+			power-domains =3D <&cpg>;
+			device_type =3D "pci";
+			#address-cells =3D <3>;
+			#size-cells =3D <2>;
+			renesas,sysc =3D <&sys>;
+			status =3D "disabled";
+
+			pcie_port0: pcie@0,0 {
+				reg =3D <0x0 0x0 0x0 0x0 0x0>;
+				ranges;
+				device_type =3D "pci";
+				vendor-id =3D <0x1912>;
+				device-id =3D <0x003b>;
+				#address-cells =3D <3>;
+				#size-cells =3D <2>;
+			};
+		};
+
 		i2c0: i2c@14400400 {
 			compatible =3D "renesas,riic-r9a09g056", "renesas,riic-r9a09g057";
 			reg =3D <0 0x14400400 0 0x400>;
--=20
2.43.0


