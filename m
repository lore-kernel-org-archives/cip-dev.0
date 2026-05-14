Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B7DCD4F39
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:43:14 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.33])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7033.1778751788090868899
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:43:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=SH5n449L;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.33, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZiU2Rla5Rt/IefmaENPETM1WtC/0VXyj+nOMlTLrjhSV5pi9SPG5j0At7bwEhOIwvCrNyerrtwwFbrEc9973n0tEiEHIJH9x0DqxH8qafOlmA2NyXZYAEiPojxOJyTALiDNhfLXlOVIKN4iagHmw2yKV8vwTF9SLffDjL6aUdFsVzRg8DDWu4PFHTy4SNicaXifEkY1vOvp4HXYgr0KqgQMM9I2SDjjE7hxo4CN1u8S1PKobDvCWzxBIcrHnCnnORsLM+j1b4l27B8zMbWUmnsViWY7M+2F2tmcaGQ23TTlmzN7Knr8tbpOk7CDW6B43CZKcEsmYORpWhWuxLNr8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZhmaSkvj780ZY0X+DPYEsp/7HYZtaCK9NDwgz6zNgc=;
 b=OoFZ1BhoZYo+9vZG8CnOABAJElqwNd1AfVVoolcgsEtLZ772mOvWmGIC6ipQM/gmSz/xpFiSxhb7+vStQ+GBGjgZOg5Yj4YrrDtMajB315O9QAqCFTuDSaOWi+a2aL9h41EX/k8h7zoU6P/kIp4ILp+TAjdzKntySkciF62JZ9cysRGcXS4iHfcOINLcQ4ntXoqD8yoPHOgx8F1KIwsxlLO7jbdBkIxDmhATJ+Q/TfvqmCTsrz174ncl+tt5+/sFXc75lxddY6KTLcaK5VdNCRpwSNHdpG0T07lWljLWMcdQLIY+57vre0XMYLKlrgI2mpd9Fvyvy6UaLznJxDeWaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZhmaSkvj780ZY0X+DPYEsp/7HYZtaCK9NDwgz6zNgc=;
 b=SH5n449L11NhBaBLIwA35GzolucwuWocZeXPSfPmCShgKTFNG8rfmSogzn9M+7exZYs/v/Db/2oOuItUyvQnjv2o2D9MRCKnpRM/jDFzxkotVG6EWD3Xs9pHFnMTljXLLuLjxCQAHpFfHK9eVRo+JLeWWf9T3q+2u5wpSfJ6rLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TY4PR01MB13906.jpnprd01.prod.outlook.com (2603:1096:405:1fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:43:05 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:43:05 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.1.y-cip 15/17] arm64: dts: renesas: r9a09g047: Add PCIe node
Date: Thu, 14 May 2026 09:41:50 +0000
Message-ID: <20260514094152.2215176-16-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
References: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0025.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::12) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TY4PR01MB13906:EE_
X-MS-Office365-Filtering-Correlation-Id: 46b34ded-90f1-475d-b822-08deb19d3271
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|11063799003|18002099003|56012099003|22082099003|20052099010|38350700014;
X-Microsoft-Antispam-Message-Info: 
	cE1ZZ/Kn1WssMM6V89nDfsVOQwaKu0JgN/rpD7KT+eA0McyHT4ObOgFIxOOa1t0ZUtxRiRUvOF62r1ONdXG8myYEK3dAjYrYNSU0HjUgm8SfDwRVfKp1EzsHdqXtlobVp1F0OIDE+ImaHs/EuoULBuAPYZwqOjGGF1/hXtjndp0DGM8WBlcW3xpe82igJLXMDcdSrR5li3XXsX37r2Jn4TcOdWTmOKkGDJKN6vhpX1Z9qYcC6RLiIoavXb8v0TAn9U2gQunItv2CUUsz0UOMvrT1VKesshORqq+bvg6FjAE9QBkaiqCD/HgjHhJShbN4QYNPmjvuHeyscJCYJe/KFt7c+h6z3WC9FMlBQqQXhjQbki7hlw2EQ3d09DeQToFIg32kiK77YRvlDMywQb8R3Bi8h/ex87x49VNW7jP1P/ozgNA62hlE7rU3beUInqLCN+C2khjHCGS0yrsJcNd6s3NWEHRjRaOOqYBMB4lPW2FuNqJmASz2lJI9OdRVkEitqQPrQkD0Wjf4x9qQPqTkyjyv6YcE2WJ7eux/JMHgGeqN7ImbqNwueRxZzwiLEszha3rRFkglWmUaJt3MbrVrE8Mo0UhPYW5GdBC8s954Hol1CrO4w5DMzkykrvZOd1b8AD+jRL3qWuUj4al63Q2y8hrDDWj5vUQihllioYproZbES2RUS7AHjtMxFfhpp/4ZEBxMRZNIINA91JckeQifVg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(11063799003)(18002099003)(56012099003)(22082099003)(20052099010)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?J9cJFhaIVdDUbENdImB6D8btBRvhjFCVmnVM0PIrHZsn6JZycforP5AcA0/z?=
 =?us-ascii?Q?fYf4pkwuFDhM/9X7THPx+e9EKoo1UvI1jI9uJN1GNybwnrZ0pig3XZaxiZRV?=
 =?us-ascii?Q?jPXlwNDqDWdqvZQPDVwdrA9tp2HevPukNcTlrochgl9dWles+tdioJpUHOcI?=
 =?us-ascii?Q?5F6lJKzyr+yiv5tuNkp9eWQlcXbp+XQNUcdq918IjNem5kVDgIIaVo8NzhCP?=
 =?us-ascii?Q?Nku47j4BhWMTKbf4DtkSWEsHm49sYT3m8fcJoH4PF4bmW2iY3Q4XMMGodxpS?=
 =?us-ascii?Q?fB6whVBET3Hli5e8WZnkmabIk3k6Hz/y/zriuo9pQWAiJZ1r0eKrYKB6pEvv?=
 =?us-ascii?Q?tAwwHP1pfbr9wRGncWGQW3izd56REje/0hfOb5qUIOimk5tLI6PW4kGYSzMF?=
 =?us-ascii?Q?QCiOyOICAHs7wG/Gl7f2tHaA7bAhmXZGS6jgJb7xaRfbjHWzMj2xuPv5yjXs?=
 =?us-ascii?Q?WxUpDAPnldXppeyoj0JIf7RcJmX2edwMdRL0eZFVmZyqchWO794IQ3jrbKBE?=
 =?us-ascii?Q?8tjZ8OK7EvVAHRS5hEkXu+aei9tFAgVcBI8IbFfLvkuxpKt1TXfCIG4Bm5Yh?=
 =?us-ascii?Q?5NOxONIA4iaBnfJuYkZDdDP/7nBEmGIU7z2BLgHWX+RIBgUpMmeMUtmv1zqQ?=
 =?us-ascii?Q?hgMZAtjylpJi/kEkn7FLfTgxYq+3qsx9shJ/FikamEcZlWKdXWpRCjZ6SWzh?=
 =?us-ascii?Q?NEUEtCNSB0FNgc6OyR8C2oY9QRbif9oFI1ZEGiWUEYtWjf4mq9z0IQ+hNBxv?=
 =?us-ascii?Q?Zq0yUNDE3tmOhEcxLo1KsvXtDirfyWlThVmcCG+EVSF7ZmmbxPWC8GMxJJ0X?=
 =?us-ascii?Q?5XdBpBbPhK69x5MGghKgP8wNJYFKcNHY4pdacIbpOmPinK0yX9MS7h+L0JAx?=
 =?us-ascii?Q?rIeD+pCSFoo+lG+tHcFX2N/hQC9StBwLEfM7UwjzPo9o64SZL5uc0Lz70EcC?=
 =?us-ascii?Q?mhwZ09htFC8VNmHtv5sLgSS2I0WEFWOoQay1Ok95mhZy7OPiQQSJHlFRoWc4?=
 =?us-ascii?Q?LdwEOEYYh8wz9RJ/TaI6feYUjPyqwfu+myjrR7sYEqcSgBxrDSqBwj/mdw5i?=
 =?us-ascii?Q?fdJJ1X/hVQmzWRcmsaI44/YcgJPeMH/ALzvwlixnEkxZ5tATyxIc/r55mU9c?=
 =?us-ascii?Q?yslEemlnc7R24OJjlLaLnfaLYFhEdmQh01kDtmb9d9/CXjU4DJlr1cCf3mBR?=
 =?us-ascii?Q?ivNjORZPT+AAFeA+E8K423ad7vncFIkybsFlmsGCbvhm2eddWOdVllAH3Csk?=
 =?us-ascii?Q?SnN81oqz8xJYkZiaaW19kRXCfiwJPmhT8LbHDY/KDvkvQlt7mTWXN6o3eMg7?=
 =?us-ascii?Q?ThFIIuToiwgwWHBcb0gPA5H5RPVWZuX/VMWrN3o9kgNOu3X4yc4lPKeAmNe2?=
 =?us-ascii?Q?fUDQI8cPlH0eM5ZVvGAllrpmQ4sRuOHiHupfduCc74NZzxWV3rx0pbnuZ0Il?=
 =?us-ascii?Q?m9m1pC0EOgeXf8U7Mi/W5YWVmWbffPmch0ju0gtzO0003Ufl+mlR94T6bCjI?=
 =?us-ascii?Q?AHGXzbeI4EyF31eg3p/mdve21XHtccIOnAyg1auoLLdC/tjQEN7djlM0kg0M?=
 =?us-ascii?Q?s10OoNJ1Qek3OlZu0+Kb4Ch0WdHQJImBJg4n0c28oDbqvE9Vczm/9IcRxCNe?=
 =?us-ascii?Q?u7Rqi4iWO25bJHuzenkvBZy4HM7bg+HiNc1Npfz6pTW3JbkNxP0RvE+7b3ms?=
 =?us-ascii?Q?UqyjHqbdRxOW8l+sglO49ceclq/RFss767xdxr6ofheHP1Lf0E0W34L4BD9i?=
 =?us-ascii?Q?4KVCAhOCPxAw3VeRm+/gEdHfA2/f9fI=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b34ded-90f1-475d-b822-08deb19d3271
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:43:05.0698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ik4Wnpj9tp1A9JYfa/HgT5D1sXGGv7fjN5ibBxZz3mEHBMjPIfAbZc3Y5njQ1EXkdCgDfnfjdc4KB4EPI3yz43iGaSqpTKvSci7MsJTybZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13906
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:43:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22967

[ Upstream commit 1ac57c9830cb0b586387367f88dbb10d21ec166c ]

The RZ/G3E SoC family features an x2 PCIe IP.  Add the PCIe node.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # RZ/V2N=
 EVK
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260318085119.44717-3-john.madieu.xa@bp.ren=
esas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g047.dtsi
index 0a2fc3480a43..cc0dc3df9e7f 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -841,6 +841,75 @@ wdt3: watchdog@13000400 {
 			status =3D "disabled";
 		};
=20
+		pcie: pcie@13400000 {
+			compatible =3D "renesas,r9a09g047-pcie";
+			reg =3D <0 0x13400000 0 0x10000>;
+			ranges =3D <0x02000000 0 0x30000000 0 0x30000000 0 0x08000000>,
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
+				device-id =3D <0x0039>;
+				#address-cells =3D <3>;
+				#size-cells =3D <2>;
+			};
+		};
+
 		tsu: thermal@14002000 {
 			compatible =3D "renesas,r9a09g047-tsu";
 			reg =3D <0 0x14002000 0 0x1000>;
--=20
2.25.1


