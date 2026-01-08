Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08B9CF6AB2
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:31:30 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3045.1767864684979417494
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:31:25 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=saboq5M2;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.61, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVoJPl8QwgMU4EFlrNcnnF7iIuFr1yTWY735n449mCF/ilPCdr2E+qd8agUErPrXrS7GLksNEQtZdjfSZZ/30GOFK+f/zQNwFNbfuazdE6C2DJe1gyDZjR7+B1L70QESMhbA1eWzWbyhxunV8q2TxmgrPy3tf0PAURhm+O/IghPqyjQ4pqlpnVuD8o2TPDkZJ5I0+TkUb91mUi9Fco0kY9l0al29w2MnBC4TklrH2+Fo5yPt4lKLpA6jWD1/v8AgNoPvZuyGraccj6HG/NSk2smxO8oC9XGJwrJeBK908AoDvRQPtQTsEo439uEDt+4kTbTDU2Ij1wnFnyfuaLXZfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaiYx8wAJvgH+DHWbO0qNx+dLDbG0cpFqLjDMegZHOU=;
 b=l0iWxrn9bmHUJgaDsiQeHaTqUDniMJ7IJTU4X+1vC9LBHeJz3VplDKJ3ZFFV622hc04zxaoIeu0QoYcrLjZror/FQjDAu1KoJZym/lyYJwybratfz+9JNS5YVBOBHqaiby0fwgZAZVxx4cPo9HHfmDImSYgdul8R1qS9FR4eKXZGIClCyo7m2sGmLR3UTrmVHl3PNVmOSADxAQEHVtlQt+zEKYaKPap353ExY2vG7jtyQI6gIC8P5ucFroPdwGl10WvDnRdCUOwSUaWMjtR7codVB3K2gJ0eUtw4lIxf+5atxgDTQ0qqAnnaBe0BO5M9IGnacntxYo91yMGu6356hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaiYx8wAJvgH+DHWbO0qNx+dLDbG0cpFqLjDMegZHOU=;
 b=saboq5M2Ni/gE+KMcipjIPmOQw6AK7d0xOZxTQ5potVFR8DihKpm5RBhwx31h4CpvZyvxCnAj+sE/qG7ja7Wys5RAvnYg8MpO0WGrstU34nd2/iaNpDwvlQUcKTxCBQyCQ4iJx+SP5jpqVTnVVpyg75Vp9L5mqFb3lC+HdQFTvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYRPR01MB12872.jpnprd01.prod.outlook.com (2603:1096:405:1b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.0; Thu, 8 Jan
 2026 09:31:22 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:31:22 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 13/19] arm64: dts: renesas: r9a09g047: Add I3C node
Date: Thu,  8 Jan 2026 10:30:17 +0100
Message-ID: <20260108093023.489513-14-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::13) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYRPR01MB12872:EE_
X-MS-Office365-Filtering-Correlation-Id: 5732c683-cb81-4f30-d035-08de4e98af8f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?AiY2LpInxo1u/MAVO3kuJiL4UqiWLdnp2C0ntag1J8xCLss5py6Mie8+qV+5?=
 =?us-ascii?Q?VLQP3DnSN+VK3KnYbewT1llymuGXKESOjfLC0UnMLJ6/P0qqSAuqNKKt4wvm?=
 =?us-ascii?Q?N6aOTXICA+c2NBqiJpOm0ZNKk03MEEduFbrD5CEYy0+kN2hzswUtUmOerB96?=
 =?us-ascii?Q?efkRGO7MtXl9AfkF5jmTYIbNrI67FTCjCz9HtfIOnBAMiuvqOvg2fuObypt3?=
 =?us-ascii?Q?sVhALHBvZ8jfewAQFg/7E9kHVWCNYNK2V5BlMErsUUiO2o1xDW7d0qHD6eGr?=
 =?us-ascii?Q?6XWOsnuxIVhaEMFzEkjW4ktBqgFtBBjxoqqo9FUJDAOlJy6RFMe1OuCfSIpI?=
 =?us-ascii?Q?oilUkfbHkVM9s8C7IgbA3Dz8iJKeMOvBkTuxVzhW/JogIFzCKq6DagQT2cNd?=
 =?us-ascii?Q?GXPEERyuQ/f59TMyxiUtzbLk91/5TjbheAo8ON3RC8U4X3g1S5wTdxUEWWBF?=
 =?us-ascii?Q?ncW8B6Gx47UBWyfDPArYhix18ZcBrxaOVcmVIAD54FztAmnesmd7qCCCBKVI?=
 =?us-ascii?Q?gXwY38WZ2MqlfYwiCJ/PQPHuCM+IrpAeGxg7avWXfM/Vt0Oukjcu8bPMZ5uv?=
 =?us-ascii?Q?ZyAhebYdIh4KyoNeGXnP/mWG2C26CKWl+ojYirGahzyXznaQUKPqU5ghid+u?=
 =?us-ascii?Q?xb6eZB8PY+YjespDQwGhthrG4263bTNLFlLWdu8D4JSWwZ8YvzhMX+dDSr2i?=
 =?us-ascii?Q?EyVD37MTrHKGgKoci5LXdT2ukdQT+rnVKJVR3ELlNzgyCd6MyQ1GbXQbIGb2?=
 =?us-ascii?Q?SL9IsBCVYGwXHruGVbk+YD4mJX0HT2TmPtt3vMZ9bG6S/0OVcUsPyJK9GaAe?=
 =?us-ascii?Q?I6iupQCvVtT9imgkBgGqsH/MzFkOy4nIuhLgshlemdghbX/YeuvYCzbIeIjS?=
 =?us-ascii?Q?Ii65pAe1ig8B4QOKxpBVEenw0hs+mMTC6U1qhFbhsod33mC21/33/LHzEI+s?=
 =?us-ascii?Q?C+ynqipVfmsdHlWcy0BztG1nVgtUe9mfcopDZ+6J+SBkPUFip062CM0fIEVk?=
 =?us-ascii?Q?49/IDPR4a1v5x/mZX+/zDW3POgjrGfBmBzZoP+f0qKVF79o2ESF65R48AfXk?=
 =?us-ascii?Q?vLptlfT1SUk9SX0/V8KF0VfMMuy6T79/HjvY/yCtFK4NH3xijeOqz57TqkRz?=
 =?us-ascii?Q?z6HZHsKuWfCdcYUR9DAQ0zpf0tsh/5TcpUvR9C9xxdftMHanHGoX+y3JmB/J?=
 =?us-ascii?Q?9f+OIgUoo9riZsKJ8TQtsWzWj6+b2fxpyqa8L7J7UY+aQZnoiSM2IcQhe+iv?=
 =?us-ascii?Q?Z1tpBpuIWD9DhjsP40D/odrjfHVp10y4EBnleUqqU28AnNrVMVTLSMORsf67?=
 =?us-ascii?Q?8mkXe8H1kaYyGVmBpumeRQgnrbuxy21GCEPzNS4wv1/1HoMKLuRjNNXmQCcs?=
 =?us-ascii?Q?AtFZ63dtYKWBJXjZkpbgNkNRKrU9fgnw61ntxCM/k809+lSw7kuuEFkwznU4?=
 =?us-ascii?Q?THnc5ScvZH4/E2tZb+aCSu6EgiBYu+AiyrdyhM4EzGCRA4I2QrVfAA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?h1UYs4NdTI0MWJrOF9G8+Lyix1vdl0dolmatxE8us6bgsDK1un48l4D04LCM?=
 =?us-ascii?Q?Zq0k9+JUIwLJ5T+T4/2FDNHizL3Gztz1HecjcT6TmT1PvvgDKQhHDXk0K0nR?=
 =?us-ascii?Q?LtPNM+WfDv7sfqYQhVGiXp8WEHtDV3wahFdSyoSKZFfWohAASKQx5Z9+JxeH?=
 =?us-ascii?Q?SNGS/eRL9uBdHZ4nrIqma4OOdi+/UqF4qeCv4zkLJnUGkJif0hjOXqEVkr+j?=
 =?us-ascii?Q?yHjWqzChMKZxW51wF+UHfHeEkvO+AafHd0Xjc+ivgqyqyr12l5eqf/2DGM4D?=
 =?us-ascii?Q?rAzn/fjUZ6bq2Ezm8wsXJcgmatcPt+LNrARJClykMK0Rfk4ad9Wl80XlfTE9?=
 =?us-ascii?Q?zZj+Rnbzb3UBzRbIBfmd7WIfh0uwjK/boC3oqAjq/hHHX2EQqw681ncvWtwj?=
 =?us-ascii?Q?aq+2KIB0eCzXK7dK2GWTBowoEAwOe7hDsgDFShoisNWoTYrIzStD8sXfBDJ+?=
 =?us-ascii?Q?SAl+Dfo43AQ2HcSRDSjKX3bj4soFczMQP46uV+su/16l1V1F609CDmDwDfcf?=
 =?us-ascii?Q?rmSLBhFaYa7XSMcqPl+BDV+MG9Y4jht4PUc6CA0TZUUJp0401SosYEKD3ERX?=
 =?us-ascii?Q?LO76RYJGbSVVeBD7lIMaswWmFIVMelXWfxMjQSBxrxrj+shTTjHn6BPji7Ms?=
 =?us-ascii?Q?09a0kiZTkvWZhRTee4pIME9koeWuiPmEN+vpVwoCAVx/mYRxpIyt0Ohkusye?=
 =?us-ascii?Q?pPqx9H0UOziv/tEcA7Y5ffbKpbaeQIPrGWw2z5eA7B1OlKZNmYiTJxUO3gcV?=
 =?us-ascii?Q?cu12HzzVznwmPbMmOSpuDMrO0NkwGBmE+LLNC/2wNaY/5/nPUpqDRBQJN0Vg?=
 =?us-ascii?Q?2Fi9NUjfSXSEfNJw9KUYzZVEKMnJyXaKysx+1BRqbUcQ/q9uJgXyVmsLvAUI?=
 =?us-ascii?Q?BEjbPwn+lRiCoXY4LHWQiIz69QRmCBokvTKTQwnryb7ZQe2DunFqSwCfoHZD?=
 =?us-ascii?Q?ic8AkR9+GBOwIvasO5vNdsO+RW/6Ro5X+N8sLJ/x1T+MTAbBC+HWlNSBVmQZ?=
 =?us-ascii?Q?Wduxb57RJFodwpa55NnPU4t0gO7NivuMolxG4kf/JBYkZb7VuW4djccV3zqi?=
 =?us-ascii?Q?Zh0y57WlRO2OEGWVsoMGM2mwPTR3rQfUZomJ3j/9x3gWLqKoB855a1CUWoXP?=
 =?us-ascii?Q?18hlkdei7hmAoStrKKbex3FJyqw0DNti4I/eETEmvp6ZX/lpkG1VwAkBNnwK?=
 =?us-ascii?Q?M7XLsjvfxofo2xzGtGTryM1Ro4UEzej+UZ8KhUJaREXDK6Dwu4MnE7IP6+mW?=
 =?us-ascii?Q?zhZ4BggLR0uSifvcVazhGGB2Uu5SH6k26/IdrO+76mPz4Ysc9mc+xh+oivFp?=
 =?us-ascii?Q?K5PlZY3ezBLmJJ1KTzkQLl+ZmwRUsXAVjpu5ecN2xNVMXc/w4o9cYSOGF+zR?=
 =?us-ascii?Q?COpo4wfJeUcW29RcVCh1oPzY3NFoyFQKRf1r0bCWV/Cxigx73fAvxhb4i39M?=
 =?us-ascii?Q?cgcQ55vI23v4gyj1jbadEIJX22UgP1LrEBuovZkvzX5hTkKQTYzjAXN0ftJE?=
 =?us-ascii?Q?bnx57fMYVF3LeW77ZAyyRaAAvPSQ2HpJjAEdF4/BXnSBh/v+Gkgxb3sK4NOR?=
 =?us-ascii?Q?F7HOfUS+MKVQtv/x+/EMDBhsFHkFoU2MZeu+r3aQ0hQ0bd5gQvJANI+qX8q3?=
 =?us-ascii?Q?Z7tAEgYRVpWVW9AlpFcZMgSswJgwTeuYMXETK4tzRhnTP1NQ59bqIdcBCILd?=
 =?us-ascii?Q?GPgxIP2o//ZvEu1SCtGZySxbdgGWHaq8dXmJ34lIgpWZL5moFjpC1+/kBlJF?=
 =?us-ascii?Q?mqH1ubl3YMLNFitdDmbzHCTtJ/7nNoVbGRmz0p7TB8IUCfp6YHkA?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5732c683-cb81-4f30-d035-08de4e98af8f
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:31:22.4647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /X7EwddKonpMqKVH30X7fPv4If5pqBm6OF1+G548g76441vQX4Sc8GSmQh7fZ3o3jMnTLA3ddeR31zrtA0e1hCbQnIioTAGNiCpbgzJ7WCG/RHejFXHfNLnUOPAruHCa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12872
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:31:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21472

commit 6fb1e70e7a918969573bc5258975456bb7165cc0 upstream.

Add the I3C node to RZ/G3E SoC DTSI.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250807151434.5241-8-wsa+renesas@sang-engine=
ering.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g047.dtsi
index b55b113d1f11..42bf6a57df97 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -322,6 +322,41 @@ scif0: serial@11c01400 {
 			status =3D "disabled";
 		};
=20
+		i3c: i3c@12400000 {
+			compatible =3D "renesas,r9a09g047-i3c";
+			reg =3D <0 0x12400000 0 0x10000>;
+			clocks =3D <&cpg CPG_MOD 0x91>,
+				 <&cpg CPG_MOD 0x92>,
+				 <&cpg CPG_MOD 0x90>;
+			clock-names =3D "pclk", "tclk", "pclkrw";
+			interrupts =3D <GIC_SPI 674 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 675 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 676 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 677 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 678 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 679 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 680 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 681 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 682 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 689 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 690 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 692 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 693 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "ierr", "terr", "abort", "resp",
+					  "cmd", "ibi", "rx", "tx", "rcv",
+					  "st", "sp", "tend", "nack", "al",
+					  "tmo", "wu";
+			resets =3D <&cpg 0x96>, <&cpg 0x97>;
+			reset-names =3D "presetn", "tresetn";
+			power-domains =3D <&cpg>;
+			#address-cells =3D <3>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
 		canfd: can@12440000 {
 			compatible =3D "renesas,r9a09g047-canfd";
 			reg =3D <0 0x12440000 0 0x40000>;
--=20
2.43.0


