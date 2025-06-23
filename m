Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC04C77B7F
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:47:52 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.26])
 by mx.groups.io with SMTP id smtpd.web11.385.1750690069142333873
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:47:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=P4dKRVqe;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.26, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8fsBwPpaA68/EsZaC3LoqZvmVVhNT11EEYkkaxVUSnX8pcYnGIt5X1fk/097h25yl+CL3tMurCo7qyCT2oj5k/YGHAe80HRDrdnQAWNYjjB9hNs7fiLgWPGgEZu6tLmM+E8AM5O1QkjvIcN2/1+vKtGyvbxRFRiNXgnYT/xpvw0kMZgpF5XZkDy3VH6JP5LhJIovi8a6QNEHwm2u/Ysr/2eL2cEY3WDc37gQKBhX0i+CVuQoq1sps2ORDIWdR/bs/XLCYT34ueEvMmHtTysauMHrh6qmHlnCJphgwXJNham08sT4hMXyLhjyym3LqKtw3LnqwVHBaqiRQkrNSRzeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=176Oxg0fL1Aprd0KVRLskWNJpIBsX9dtbgBvMmXK+zs=;
 b=SYCfjX5Bs5dnVsuGuc0UDjpl39NCGD3k8hCrLzka1nu21PZI/Nn8QGpQ4v3FdvSpncNhHYQ1Fbf5xEjuL7B7SQgC/30+itFuwrZ082OlocgcHKOK8BTGkO+2vSwMiZ/Cg1bszi4LWH8o1d2Ji7cuG0JLffiuKTBT8B4NrPTfz7001Syaa6z01bagKYS0s2ez0qGBiQr2EVyDBSctFTWfItDZrzrbXJUh0hSMJlo05TIX0oIJdmoZ+8oxAEWC7nPwmBN6wED9xoa/MFH/ya0W8hErmLLNNSIqmjdwMK38Zeo3vANYaZddLVXY2oeCdTWw29gnSSeozVOwYUyoZ+pE5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=176Oxg0fL1Aprd0KVRLskWNJpIBsX9dtbgBvMmXK+zs=;
 b=P4dKRVqeVZxRivMFh/fmU7GtB2t7aK0RmFlt8Y8SMOm18RtBy1IRXAcuLPobKAC8jzwOL5Ap1umg3LXhloWS3Rlag8f5aN3fEyZwfgXna5F2rPIsUtqKnXUdmeHVziElGa0W28ePqxyAbyke8Gy12IfDPCtc5r1BemlYBDvt3gA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB16379.jpnprd01.prod.outlook.com (2603:1096:604:342::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Mon, 23 Jun
 2025 14:47:45 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:47:45 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 14/17] arm64: dts: renesas: r9a09g057: Add support for enabling SDHI internal regulator
Date: Mon, 23 Jun 2025 16:46:36 +0200
Message-ID: <20250623144639.2119707-15-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB16379:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b32c569-2112-4bcd-5a40-08ddb264e9ff
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?d0CEhPEE/TcMvZ47H67H9aED4wzrSfPM78SMnRfJW4qEJ+shoTLRRPotPWar?=
 =?us-ascii?Q?z0d4pv4W3foowJoGIcCCGE5nGoq89IKcFhYgqPIk99/IeoYzpGTIBB0jCode?=
 =?us-ascii?Q?Kf4HqP14C+d2Pz9VZzmJO+Jtip7ApenYKDuoOVJ0y0v+saaQnc3DTqk70iC2?=
 =?us-ascii?Q?vJNeFJHYUdEofo47IR3J1nsVGXLjh77K5GQpIZF0b1TlGaplJLUkzNXSSh2I?=
 =?us-ascii?Q?UgXR+uTrBbST4I4Huq2AXRje6EhI4zezrx6/H0lyALnCWA4uZ4BteoEXWMkA?=
 =?us-ascii?Q?Ly2IR7HFFaqR3MQESHUF3lIggqORhF4yGIMNx9/Gf6HB2mFMgvVn/Ndz3ly/?=
 =?us-ascii?Q?u3Yi/Ivk17REH5ZNI7Asc24MDl0aFFTnNUrhfY7OKbqo7Y24Mth6Uv6FHcXs?=
 =?us-ascii?Q?XI0wEchm0VOUeOJPXkf0JmZ4ZgpC9REaz4gjeASpg9s1l9TCwlb2nOUBEeUx?=
 =?us-ascii?Q?L8WZF8rD2XjelSaWLBe/8Wt7811MHyoo+EOLFiL6ba81pjcCVcakYPJCBRyr?=
 =?us-ascii?Q?3v3xxF4Bqmues0/TsPChQoovaVm4NN0nq1OQCxOLR+PdFOAmogK6oA+2CfdR?=
 =?us-ascii?Q?D5rwcdLDKYmqSx17O/19U8jPbNNunFe0wpbsGH9dz212QYdViO/uFx4mOyag?=
 =?us-ascii?Q?0Hd+oNrI87R/C65SAdcfxfrRuSeJ1XLGbFAsuhRB9MmfyenYKlilhJRfTen/?=
 =?us-ascii?Q?a0QFrzODJ2YXTHkD85Pz6Bw7kL1dGgaBaTRuDnS8Q8dVQQACo0c2+2I72d2k?=
 =?us-ascii?Q?mJVDvO2YJvcvdHfkohLtNbLPCvYZ8bGxhTwnl1L8o2zwSZoHY9U0BvU/hanA?=
 =?us-ascii?Q?6CQZaD+xnGwxML++os1SRrnEEArbgZBIakEsXvcKxenpZci5sxAZv26jWIvV?=
 =?us-ascii?Q?souSfOEUT9qT2fc7UAX+TAqcR1K93UE8xBnmDDbf/W+Jqkv6fqPkR1YbSoul?=
 =?us-ascii?Q?GQ6eO8mS2WSaQhHOD5fkGERr6Bm0R2ocaEY+/OZXpXtqdLVdvD/Phyv1x0If?=
 =?us-ascii?Q?RObba726NfkgbdNxZiPBA+lTR2iASGLKnGHAuh3mId1H0LYQ0pH0IyR4WSXT?=
 =?us-ascii?Q?NmHxo2snvS3mxuVeW1eNVIF/TdzhhP+ASJKfy/0kFF5oePiHTH+3kd70ebz1?=
 =?us-ascii?Q?Ej090PLe4+uaZfSRIJWC6fdE8tPBUA/dAeSAeMDbYsTZUKoHtW5JL8hLWnHl?=
 =?us-ascii?Q?PNqQDhIBibeLtxFYuMGR0b81eOYVDF9oB6sZAG7AuL9y0wl5qS1zgCFPtujX?=
 =?us-ascii?Q?i/SiMIuo+LfENvv6TfB1RQZhsP9MsQkVvyfTY9MEXpPbp5aQMjb5dYo74n/I?=
 =?us-ascii?Q?j+Ip7Qs5iJ/WCXLNoVFD1n4Mxl7uIm17W1SsJ7OtZEsXLqPmKdQ9Mc5DbKad?=
 =?us-ascii?Q?sFQ5Ht1Isd2jDWQkLIHp0H3VfHnirlhMC8k3AnQWBL6lMi1LzI20VRoiWHKf?=
 =?us-ascii?Q?Mm4BJpva4H86IFwIOeQG8PwO5Y1RcT9f8qtMhZSqa5TU1UkLplXk3Ch/JJPy?=
 =?us-ascii?Q?uhkOdUfcCHBHMRk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZIQ08Mlw+f3skroOwLqclDfSJdnWEF82aKJU4EXQl2V0x0tPGJuoyKgkzR1z?=
 =?us-ascii?Q?01WSvbNR/ZTM98REWsP56zHmfoe5QvnhEY0NSO/Gg/icfakWNfQUiJ/fpf86?=
 =?us-ascii?Q?vOaAPh5pC8odTg2FSYwXUgpPItnujImla/CsIgMtwDU945CWoLbcr/VfVyR0?=
 =?us-ascii?Q?olR7vfMzVEbyuEsqr9tyBc68ghEDlssn/7airzIb4FoiXE2zLT4nZjYUnuEv?=
 =?us-ascii?Q?o8d69lhRj0WcSfkVFdxBhNG1P48BQxS1CxXAC7bwREGbnQM7Yl54Jwm1DipR?=
 =?us-ascii?Q?gCPKiLSsdrOFrMsRR2bGDUOmlA3d9l0MNxdNBPDrSVoCHnu+6JK69wc3Sqhw?=
 =?us-ascii?Q?zAUgNIjxJJze1lCnocFxn8vIMdmezAllYCKySaNNyxY3XS1jR6NSKqoAakNx?=
 =?us-ascii?Q?DAmSLJu4soH0B4tJclG2O5fsbBKxjAVYjc4aCtXQNOoJznWK573GOH9KfTK9?=
 =?us-ascii?Q?oQdv1n/xidGSM1rE281U9Z0+b5EEpsocl5WO4alfFUtE87CTSTe3pZFWpikv?=
 =?us-ascii?Q?fBMTRI72ECpZa0CphLY+DmgD+Cjab4WH23Uj6OUMz8cI9ng1MFNloccksoHi?=
 =?us-ascii?Q?j8Xvpo5VH1XsyAErq5eEOM+3fEnZX6wRPvYb7OK+8AZDQGqMrXgmzJLZAI17?=
 =?us-ascii?Q?mMLTcchDZzqT1EknsmhV6nDkT668U5nRT/pLhgD9+44cd+olBL64IsE7aBus?=
 =?us-ascii?Q?sPtHMrkD5985TKef/i/n/ZMCTwkJvQmn8egWrMMSdame6b9U6ptA8fpXW6kz?=
 =?us-ascii?Q?QggSqzjxT7ZPz8h2+6QtapwjAS2CRhM/xP65dqS6qEaJIQ+bWMzsj0T491oa?=
 =?us-ascii?Q?dvajx1DctCOSf8Qb5wJmY/1fAYIrHAQI1lAx+R2tAyC5UG6lbhF7r3/UPWLM?=
 =?us-ascii?Q?U/Xp4sW1J3e34FgvlX2AZFIFNukB1EGTsC0YICGonT2nLykAoEQ20scKqbEV?=
 =?us-ascii?Q?ubMyuFctQ2gV1zM3PDjxqwvWUIYJwP0YzaVN3m2NRTLoFO1QZ1PIalFzQqg5?=
 =?us-ascii?Q?m3DrOyefW1RSrSZa4vUywduufLx6+igrBJLlRkVSNb2SbLczxSbqIgG3TnN2?=
 =?us-ascii?Q?EQWWfdoTZ97jjEA7HlLxqolSbk6TAEEarzESm9+Chu7d9TfegC4lknvVq3JD?=
 =?us-ascii?Q?s6J9MIEDLWtpgfU4JiLsX7F+UK/LdxfkQTx1IxUzWhbSnnZGnPuVIJZSE7nv?=
 =?us-ascii?Q?vKuZH7WFYH6csZ8H9M+DiVs1hwOcLTpkRWV7aTjnx3iE26pKpU/L3pH02W+Z?=
 =?us-ascii?Q?22xXgZLTDK4S/GcfcUhnUrZlhwrJfS16fXHAVtRd5IezWQy+Ne3cbVS8Ngy0?=
 =?us-ascii?Q?JlzmUPv8FWaD83/XpgoFFRfgcakaJLGVif4pdmYDRZN2jnaAg2I1f3ln+Eel?=
 =?us-ascii?Q?E1qJWZMz0CLasKd+lboGhdL6PgUs9xHkLxeh3XXsNw2qNIToEuDfp8vHiF2Q?=
 =?us-ascii?Q?JDZaAymBRHK+OyoJmsoRu3QkRiHZMI6uKxSYZ6xMXHacydPImnYKaNQ8OhHH?=
 =?us-ascii?Q?ma7eCReArO80kY+Z0dbupRQSldoiNEgDEpmRfq87RpegU5FcWbnLCJIdPdCO?=
 =?us-ascii?Q?xxTL01BjcBInsfqmyxxXjaTOk1RyxSoImNvts2cEN9CwBLtifO5935n/K9dO?=
 =?us-ascii?Q?QpDfi1+3wTuzeAqPmEAKlH0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b32c569-2112-4bcd-5a40-08ddb264e9ff
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:47:45.1809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOmR+zSQugPd+AS6iWWRxZNrw0J27nC0lKpkFd9xvqVCy+5TmEY0BiFTuddb7AOa/iVfoAI+rFcqM/mHm++guwv94SmUTOy+80GXoeOKtdtrXgGSLE4qtnNZOEPUNN0l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16379
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:47:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19201

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 674080a22768dd4c30f2272acbe03fe94c7387cf upstream.

Add support for enabling SDHI internal regulator, by overriding the
status on the board DTS, when needed.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/20250206134047.67866-6-biju.das.jz@bp.renesas=
.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g057.dtsi
index 3a433f1e940c..0f8a769f1cbc 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
@@ -512,6 +512,13 @@ sdhi0: mmc@15c00000  {
 			resets =3D <&cpg 0xa7>;
 			power-domains =3D <&cpg>;
 			status =3D "disabled";
+
+			sdhi0_vqmmc: vqmmc-regulator {
+				regulator-name =3D "SDHI0-VQMMC";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <3300000>;
+				status =3D "disabled";
+			};
 		};
=20
 		sdhi1: mmc@15c10000 {
@@ -525,6 +532,13 @@ sdhi1: mmc@15c10000 {
 			resets =3D <&cpg 0xa8>;
 			power-domains =3D <&cpg>;
 			status =3D "disabled";
+
+			sdhi1_vqmmc: vqmmc-regulator {
+				regulator-name =3D "SDHI1-VQMMC";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <3300000>;
+				status =3D "disabled";
+			};
 		};
=20
 		sdhi2: mmc@15c20000 {
@@ -538,6 +552,13 @@ sdhi2: mmc@15c20000 {
 			resets =3D <&cpg 0xa9>;
 			power-domains =3D <&cpg>;
 			status =3D "disabled";
+
+			sdhi2_vqmmc: vqmmc-regulator {
+				regulator-name =3D "SDHI2-VQMMC";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <3300000>;
+				status =3D "disabled";
+			};
 		};
 	};
=20
--=20
2.43.0


