Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238C4CD4F39
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:41:04 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.20])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6987.1778751657032489195
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:40:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=RAV4xEc8;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.20, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxkfyTBCbJ62ZK+fzE5XJbS2WJXuYS7tNlwK3pjQDuWjEC61dDi2GKL/AskG9Jr/rkr7yHOUZvmQiLBnhyIjp+p0Ci4qPTKii4yLH5DuSnjH6uJzco6OXEobPxHSgcwO/zotprIgzuvh4IvZ0b6d/Iv5IqDxilW/mFUqIAtJ8Fw3i6mKrWV8MNFmrFnlLl3oZd9cgUyzNPi0JztIKXxJMDc9jf9U8lY0vZKtqGRoIsU4av3IuYzR/+dEzWkfZOJDmV0bU+kAxI5WNcbuGEnB4hQztoYHHeDRUTPcMbGYgJY+M9a784vtWV9ytwM92RBIQ1RFsjty3cimu3wuewxn1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRIHaCrUEPwNq5OXGuAMt8vaykuko4xIdJZHQMvM/pg=;
 b=SMSdjRem4UsKYWDoi+ReWEBqbcMFZSlsRPo8A9VFHEOdug4wyb0POBs5EraPJLU2Tzgbd8SYUOw3KRAR6IBfhgY+J77LP4QIVcya/mtZAUpXDH9muAKsbYVgjxDQHwOrKokNiDNTHD1b+dR/pLupxzBqYszGcgXVmm051okDk+aOx+cXvEfe7MfjJzz1/S642wE2kCHs4TyWLtp73VKxhqOBSRGcmxi3UvpO/LRo7dvzaQIvPGEGsU0fxlJvv/fzKtbmIRGD8zQTWdbwSFUXx3BEidee9VkusNWVe1DmhR5X18cYnwQT/IXLvG0j7PuSLt+mXoFlPLVbqJc3bjrwPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRIHaCrUEPwNq5OXGuAMt8vaykuko4xIdJZHQMvM/pg=;
 b=RAV4xEc8OPTzrqBWHms40NsjX8D3I3/sjlnGpKyyjVpOYklE/Mmh1u+eP+lFyahtccmmybSDcgEub2QOsjxfGwRZmREaHKEgiSloqH/gs3zoSrPyHOF0c4Hsnm0DGuxdZL+dne4eCDS6DWXMzt2JjHuJym7iItWEXqylcpbvNYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYRPR01MB13674.jpnprd01.prod.outlook.com (2603:1096:405:18f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:40:54 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:40:54 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.12.y-cip 17/17] arm64: dts: renesas: r9a09g047e57-smarc: Enable PCIe
Date: Thu, 14 May 2026 09:39:35 +0000
Message-ID: <20260514093935.2212718-18-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
References: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0033.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::11) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TYRPR01MB13674:EE_
X-MS-Office365-Filtering-Correlation-Id: cc894dfb-9a8b-4b7a-2b25-08deb19ce498
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014|11063799003|3023799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	SKdd+fAAhQKsTZMoYwa/lWAnnHEA56wYdczlpLbAWnNcm1AcEfAzx+ggAdhSoKegPIfI2YKyrxnmYBKsrHH9gm+ryvl4Ipr128niJBeK3SKx+zlxnu+oC/o/SbB6PEupwuBat1unFPnRjd7kt+Yy5E3AAA26r9XkaEoC+J/BmLyQ4KSaFPLNWjQ8EKimCo05CEUZffl4jEwJ43mFJU1gAwZriBAsRuqBKCfTHBT/hBqVbdGUreTilZ5irlll679IcivSMSilg/opeEH/C19TyaqZ3vzR2zwASbC2Di4i6UDF+12EeyoiQjEoPbevenp+Y1E21cHiObR6hGbqH8cCm6mZ2XbM5SavbrWDQMU8EKxc2LvNHui4WJ6BFToAFDyVUyTwV8/goe/4WkZjZz6xBYx2CNt22mB7HJ9leCaSjFFHLA0lQ63Nn5hy/qWYpWTsRVR84t7NSSe6p12mF3FIbZEEuMeMDSHz8Z8n1EKGjPmqlcXDH0RlTRnKGetPagQcU0mo6BXhNu02H2INvqeUx96p1wWS65KWrvwOkIvAHFmZUqQl9J1Kq58tVkjyzzak9vaC/WPkeam61BwLjPA3AWaMRYXCZIFChJkXZV3NIaydKmF4NnADD54wRXGiln5wpmxUa9ycPVZbLrrM7iXlNxGKPNtuLx4e+Q4wzZwjFowTLJXbpRn8BGCoMto0VC675tW93OAGsZAq2wBbWhnpKw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014)(11063799003)(3023799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?b3ZJtjb3lBETRW0v+3YOaF8k8WbwnXWVREwm51Gqvipn++fSxeb61bZb3JFk?=
 =?us-ascii?Q?wGh6OzBQe8gU08CWXxvexZ4njTJLPj4fz81o1UDPxJvvbX5l9uxvU0dJsjsh?=
 =?us-ascii?Q?3UBBmgzMLdgx8Pia2V3NCvmdd697RL+9nIhXSZ9ct0cnTSuwk0hSESnh7rCC?=
 =?us-ascii?Q?OTGO/yYl8WrLm8rpWDhHDQfGarFfFXVrHs88265iX6MFbiBR0bWOr+8lGVSy?=
 =?us-ascii?Q?CvuG05iIzVcxvnhpoRzzFnXCmZWH1+s7gindhrZTgTNuKqIkmKQ5jZODs06y?=
 =?us-ascii?Q?yTMzRjZPrrTm3h8hgohGoGl3MM1C5uDpG+1MruBQzWuyiLP/BKAJqzYfhbOW?=
 =?us-ascii?Q?NVnffDeeHDE48r37cFC7mbncnhTAcy2pHAStDvRLq46s4oJ7jswDgepRRj3u?=
 =?us-ascii?Q?eK4a8BdpNT4dsxkK8tfXCkNvtRrZDdSXNeqrkQ7p1sdW8PNWBH0mOJpP8sh0?=
 =?us-ascii?Q?LVcoM54NsRedR8ZLEZeFOOz0r9lyKLy38iT6iyhnn66TbUeK2V8Iaapwepu/?=
 =?us-ascii?Q?pMAo8w7cr7jnxSVHo2hK18I7GQqU1TzKeqBDbe1FlbP3u+R38LLRyzX07P71?=
 =?us-ascii?Q?bTkmpABzfQZ2U3zEf97CIpCRpaIBjTwTGBjEDPPp8dfJGzQBpUj/qQlslnW2?=
 =?us-ascii?Q?riC9ld0X+BJz0PUyKNS5tqvWe3+r0PVLc6DhIRfLCuaycS10RCbJ1wMtcuqt?=
 =?us-ascii?Q?JrFn/GgeqLO+FOhy0THlwtrX5GK5rxNja/pSsfJ5dPt9HCJhNJ7e760sajfD?=
 =?us-ascii?Q?LUY3UOy6QXOEopr6Tler4skLXAHHuaRmDsXlIvSGLJh9ObSRKZzbPf3Bbttp?=
 =?us-ascii?Q?6if+nvvjUYtQ/vcaGf/athqQzUcr8oURttpV17K0zdNp7PvcxAbiohmRJB5S?=
 =?us-ascii?Q?8K2AM3+IAY2O8KEhkwGL+0IGzXRzIRhlIJgAnG2giwCSBSiCW0AgHKUeZ7kl?=
 =?us-ascii?Q?dnpTubBgFnAuE2Z1HDHtFOfv0x5VN1H2rJFyv72OLVId9BBuVnC9M1kpwTmO?=
 =?us-ascii?Q?UJbWm1CqMcCp89D8cjHVJxSnvy32IOy4p+uE1wN3Oi332dmMr1DXIAG/DAvH?=
 =?us-ascii?Q?va4E3adm8m2V0Od5Zfuox3klJDtSJMxfOz7m/B17nQzHDoDkP4EmCNeHNFvp?=
 =?us-ascii?Q?mqnmz8kjcf9SGnsDetO1mocM2FVsWJexX83A59dLU/iSKVvcrLwWgP4E5Lc1?=
 =?us-ascii?Q?aSnoD+ZBFRvX4uMONgmthUjDsDOeoA0EpJpHf8tZu/GcNMGQFD6cquk/DM9J?=
 =?us-ascii?Q?QEbsfVgWFEl0Rw0tgOW2uemUiYmPXU58IR1OylKovSZtObAgPzF2Kf9FWu0H?=
 =?us-ascii?Q?SeMjYcUS0z98SRMGD6TZmlwmVve55WAcNNAA0WU0wJBCwCLDaOtil3va9JwR?=
 =?us-ascii?Q?lBwE7fDdZudS2HYV6tvWwYHfgsH8INKvNEBLegve7/d7otqTE5xSTV3/0zW+?=
 =?us-ascii?Q?6ZqqL+1xuhaLIp0hWqGfMdgrw82UqtKDCOeqr6xbCz7Q7Fb+vf1JaCn+kTGA?=
 =?us-ascii?Q?A9QM6mEkhrmz7u0/udTIG29KszY86pXW4N2zbeKoKrT+I+kT3tFE6QXA3Ev5?=
 =?us-ascii?Q?mF3Q9gql1ZWqLgWnQBJnZrLe/va+CNxMU2bcx30VVxm/xcKGaUJrR+Pb0wBL?=
 =?us-ascii?Q?BvP9dLkjazEtkoOqd5WDcDNcGWJhkRBVJd3PM8ISU+sA85MnVBGBa2p5omGy?=
 =?us-ascii?Q?nGBskRDw4+B1Y0+yIReFM8a5VTLP1We5EgQgan6FozN3pp+kqFWk2A4QrVFK?=
 =?us-ascii?Q?ivb4iaGUw9X0/xLBOdZBrbsEy4TZvHU=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc894dfb-9a8b-4b7a-2b25-08deb19ce498
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:40:54.4437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gqQz38VyfDhCOqxnDb5so29ZQZk8ck9rWsy4w18qAg/RzbpM3vTXTeSQrYkX5CgPgAs/b5/KrghJ7ekr/J+1wMWfSZYoG8ZZTtMuqA6Ex4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13674
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:41:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22951

[ Upstream commit 092ff7ab721d2a096705b3ebb9501ace31184f50 ]

The RZ Smarc Carrier-II board has PCIe slots mounted on it.
Enable PCIe support.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260318085119.44717-5-john.madieu.xa@bp.ren=
esas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 .../boot/dts/renesas/r9a09g047e57-smarc.dts      | 16 ++++++++++++++++
 arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi  |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm6=
4/boot/dts/renesas/r9a09g047e57-smarc.dts
index 696903dc7a63..3e24e916874f 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -122,6 +122,11 @@ key-sleep {
 #endif
 };
=20
+&pcie {
+	pinctrl-0 =3D <&pcie_pins>;
+	pinctrl-names =3D "default";
+};
+
 &pinctrl {
 	canfd_pins: canfd {
 		can1_pins: can1 {
@@ -145,6 +150,17 @@ nmi_pins: nmi {
 		input-schmitt-enable;
 	};
=20
+	pcie-clkreq-n-hog {
+		gpio-hog;
+		gpios =3D <RZG3E_GPIO(4, 5) GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name =3D "PCIE_M2B_CKREQ";
+	};
+
+	pcie_pins: pcie {
+		pinmux =3D <RZG3E_PORT_PINMUX(G, 7, 1)>; /* PCIE_RST_OUT# */
+	};
+
 	rsci2_pins: rsci2 {
 		pinmux =3D <RZG3E_PORT_PINMUX(1, 0, 1)>, /* RXD2 */
 			 <RZG3E_PORT_PINMUX(1, 1, 1)>, /* TXD2 */
diff --git a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi b/arch/arm64/b=
oot/dts/renesas/renesas-smarc2.dtsi
index b607b5d6c259..e2a34577a1a1 100644
--- a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
+++ b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
@@ -96,6 +96,10 @@ &i2c0 {
 	clock-frequency =3D <400000>;
 };
=20
+&pcie {
+	status =3D "okay";
+};
+
 &scif0 {
 	status =3D "okay";
 };
--=20
2.25.1


