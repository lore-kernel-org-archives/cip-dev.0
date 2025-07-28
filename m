Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F54C87FCB
	for <webhook@archiver.kernel.org>; Mon, 28 Jul 2025 13:49:07 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.58])
 by mx.groups.io with SMTP id smtpd.web10.81585.1753710544498144925
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Jul 2025 06:49:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Kyk5wpjq;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.58, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgJy6nIoSdcD+aSh/Ie3S30h81Z4UVYaEmQ8GWQoO6JNO77OiznE5iucyZtkxs5GL4TJVJsQrRvjh4yoaGExUH2B9rzAmC7p97E+U5MBHhHU5zM6mbrsm7tzvyhTeqfhPHjDcNiZOxuwWRTcBlocS0D6uvYzp+ZkMeEudnJ8OAYm61GGjW9Ex+KhLnLO807deyP1MJKTO0Ku47artHCRef4ESSFDTYcZVoiIOLX8QN9rjV2zh96AqfL/Q2mkgp3B/HQoVBvwsB1cy4tYH42hqpLiqhYo9QLr1IBVqZ+CbmzOo/h7S+VNmHqehht2W9z9ZXo1GihJPt2UlBhiUTRbog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TavbvZ9j8J+6Tn7KgiIG7XTePUPq/LMzV7L7kDOBIk=;
 b=lTGsnfQxM9I9ZabeVwqaTyktWW6DS6gZAVWf3PNiOOGjyihDsHxWSDGe9yv43+AIV6U7AS9da1kkKfXdoKloqlRNzGPFCZCqTErWgVYmqZTyVtWQM7Z3enVqfRDGfbxzauDjRcexPyZFbNfWlQakMxfGkmuAqDMC+Isry3TozY8cS3efeQm6emHTwA9yZrO7Qn4U3CRj5OCp7OW6mfdME2+RyBRbtYscyKkdx1vTOWmWoHBpe1CbZuI784uUjp7+TvUwoKtMun7c6wpDRUM53RFF/WO1r94ftGxCh4RfPkxJWXeaxWIWaigchGMh3ceJy3Tveg/ls0e9Rqlxd9eEbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TavbvZ9j8J+6Tn7KgiIG7XTePUPq/LMzV7L7kDOBIk=;
 b=Kyk5wpjqLMmWL0xcpvD/ZNRh71md3vPWNgt4Yni9KHXGTdPuomPH7wEmJR/fDzK+hmhjcQLEXC0NoKHfZM7QmsBTB1+Uao5SQDjbcebD+y9f3RE+5ROgMzKYmXBmugsu3eBS752S2qLbHDteeg55pO4EhCvM9v4sZoapF3RE0Q4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS3PR01MB6657.jpnprd01.prod.outlook.com (2603:1096:604:10b::10)
 by TY4PR01MB14280.jpnprd01.prod.outlook.com (2603:1096:405:209::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 13:49:03 +0000
Received: from OS3PR01MB6657.jpnprd01.prod.outlook.com
 ([fe80::8575:e22a:3c44:76f0]) by OS3PR01MB6657.jpnprd01.prod.outlook.com
 ([fe80::8575:e22a:3c44:76f0%5]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 13:49:03 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 1/2] arm64: dts: renesas: rzg3e-smarc-som: Add I2C2 device pincontrol
Date: Mon, 28 Jul 2025 15:48:43 +0200
Message-ID: <20250728134844.1288347-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728134844.1288347-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250728134844.1288347-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0150.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::6) To OS3PR01MB6657.jpnprd01.prod.outlook.com
 (2603:1096:604:10b::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB6657:EE_|TY4PR01MB14280:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd765f9-d823-4495-066d-08ddcddd839c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?spxCgnGLb09tkYhLxjZxWsqGjcgpxRCxqB9TVlsxfCgmVNXeAbTUv+s8lXbO?=
 =?us-ascii?Q?5WVf6XcLXb97ypZPUBf2nVmzfHHWwWOkHZdPnzQm8Is74joS5FL98T+BEaql?=
 =?us-ascii?Q?BJYACCSghQNOx9Pf49V2GvrsUUVVC+szTy/nXbrElDK2C5oR5C8YMbyplyOy?=
 =?us-ascii?Q?G+RDWXBOpXXwscSjdRQjqbRLDMZZAEVDhaC3Rp7v/wpfe79sy1nGM03OM/bl?=
 =?us-ascii?Q?SSKy6oE5IVXLgqftP7iJQbV26UrkhdFbj27mjl+y70JqNKNBWMA0kO+BZfes?=
 =?us-ascii?Q?K1TMmMrzZ6+oToCrSb09hjmThxrcMQOdA2Jog+hcvbbVyzaTX6PwygFm8lBN?=
 =?us-ascii?Q?RYwGM0piiTBnoGR7f9tPwvLncLGrYnNsLv+1n04u8+PIf+d/jNp1K9fFwkKY?=
 =?us-ascii?Q?FltXevHqIaLnKZFPpDiQ5MmHcuOPPYdDqMrkRcu/9EbUb4GYaDmr3cgo9Xtc?=
 =?us-ascii?Q?8XeJveAkZPTg8o9MKkdQ4guWsyvVFNz/vMJo9gB/CVy8t+vFXGkHIB5mxC2V?=
 =?us-ascii?Q?rcbAJQCAhUyrsWLskwkYhA8oL4HwjaGfoLLR1dkCGfoAkMx5pn9nypPvesL1?=
 =?us-ascii?Q?rEq4QHI/85rtobtpJfPkhla/Pn/Hn3oSL/+ZyAxnfFCVPNgt3a98h1K0D8Ki?=
 =?us-ascii?Q?xjCxd9CM121+kgXGYLTWvUkQpmKvZQ+WlSm6AM7XLU4VDGkfDf0ylRrwqdiW?=
 =?us-ascii?Q?bgtEyC8WmXiNtBw/+dxc53nCkgdZ2V7zLYz51tn9Tqtt29NVShY1SojNv6hL?=
 =?us-ascii?Q?V7CgysZbfUiCC22Yyct2gUBWw+yQofQXS1ae7SLZy7d5zfLxbSGugGFOag9/?=
 =?us-ascii?Q?7zGSytavTnhwDOoOgaszBWqRxDrbBFztJqfwUJbOq/uRGPF5AGk9SD1HOv7z?=
 =?us-ascii?Q?Klfb2fKB8yDB+mtH4g3MkB2hj57yH8kelnFBUXLuRncJmY1pIdr00UQGWEpj?=
 =?us-ascii?Q?zFiv/Ns4lfiefq9oxg/gobrEAtozkgVCivfbhXsF+6qBBkQw46yG2LvV5wcs?=
 =?us-ascii?Q?DKySc6iYAvotBgi3hvhb/5UdjMrEythj9jjE5s2o3bK43qHkixKa4FwOWMIa?=
 =?us-ascii?Q?QEgpxIz7jleiVJFG+VoEzHTEDNIQFSjXNvRG+abyJFArch8PCg1uG0l4hjKy?=
 =?us-ascii?Q?O4ejcf+aGBJ2EULAQ6TAJXUjHjNeU+A/UxHGZD0Usp/On3cAf2Ylq3fCXb9N?=
 =?us-ascii?Q?sJKHqJFuLp/N8/Mhd4xcLMj7JY8Sccb4jw1S8IzDoykaknniXGizwxAEHY/8?=
 =?us-ascii?Q?0PeDnxxdBTVt/Fza9zj4QBydRW+NKW00Orl2VveW2A3+zOvOWciRdT/la8DV?=
 =?us-ascii?Q?McH9b+DvmzM1BTCaZpKGF+T9IoucxPWQ+V62ky25kmkVHiVP3iF68V3Ra8XD?=
 =?us-ascii?Q?XEXuhD60ubSi5ue3Q6iyu4F3wHHE+PTS1rVK8smB+WUJxmsEFuAj22OhTr5j?=
 =?us-ascii?Q?7SW+54s8dH/IffTjV71UwaT92+xPyHx2+z9z9OI6dGXV4QWrrYopzMR/e4h8?=
 =?us-ascii?Q?XFaWYz5+WttumnI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6657.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?AVxSCFCPwr5FTM4KbSu1Lqlgy34f07VMAJT/0Og/iK1Erv50pFeQ3zHHxnjK?=
 =?us-ascii?Q?2R9fD/MFkqjZo0XhdAHiJ8prxjBWXr+xoU29uW/5uyIf/jABndhY4ydnUZ0y?=
 =?us-ascii?Q?IN9a4JRESs4zzKbTLLPv8/AOyrpM69yFnGDEQUBnugvNh4oYKda7sdVNUV+0?=
 =?us-ascii?Q?mtp18vV9sZcjW0fsNZ0JQdA1FTcd/GKAmsUTjBeujDrOmAv7ZC3yvjqJ0fpV?=
 =?us-ascii?Q?ON+VF+xePiiBFqCV/foj86P9ywdWOLdN+rFLxIwe8EbqHoOXbCkORzrwJcW9?=
 =?us-ascii?Q?vivO7Gb2kC2w8eHYG8O/f3FQgxlnjaN4Urj448zDKXeK020gF70VmOdN6hqe?=
 =?us-ascii?Q?IyL2OhjlAb358/anVbEGQjoBJ9Y1UwZuo6nQTsqxzoFaiapTRu7ag4QLIY/p?=
 =?us-ascii?Q?e6BymHqjT/QQ8KjZLIx3RcLS31TzQVZEy2WsfLT4OK7JFLnVVaMKV/DnywuN?=
 =?us-ascii?Q?nPJ39s8XAPjrE5MK55ZNQX5lomSEV4x4SY74geu8BVustDO2oV73yd60sf3n?=
 =?us-ascii?Q?fZlNDi67WBtbhBZzI7mkag4D+mlYo/QS9hdFndVR9ynGGXCtlCskh8ZjSxuy?=
 =?us-ascii?Q?C7aFrUQ3vnNSGDxwJ5OLC1cKZRt+sBduQIUql1ELdT84qX6k7IECzIfIpAg9?=
 =?us-ascii?Q?mgrTOgU7lncTRDzZf5lEwApVXxoN0xUHiHUHAH3IdPCWveqoB3e7Vh44Lvnc?=
 =?us-ascii?Q?MjfC6U9tyfs7vA/1oLxX1jOVL0UltOXNVMlhSQAZL/SrZMlUXWkbiwVYkwiW?=
 =?us-ascii?Q?QjG8OSLVzky4RdoeQhya3QKqJMkejUkPml6y/c+FJc1qM1QuXDwJ4sPSwHQn?=
 =?us-ascii?Q?c9ajyUnjspeYgRRve9a7r3jgRGtEsU6g0soB0TLarcc1or5i5c8VWHvPxhQD?=
 =?us-ascii?Q?nlZPh89HngBPO6c+zTcZC2Pp+xBkdfVfAgI7kIxFpVjxjt10FLQgO8P/6Prr?=
 =?us-ascii?Q?s38Bc1boI/Y/lClyPvD2vgEjpvgdB0O7a9Og2X+VHs611+779IHchLuKKG9X?=
 =?us-ascii?Q?+KU2NxOJaJxSXI/OuY/2CTOQjdkT2DWi0mdaMHj6KhZDRziBzmCpGH/EoIdQ?=
 =?us-ascii?Q?0OwrgXHsVGe6HXJrsSlf1AHYMlbBgns1JY3o5SqMoQNE+w4iBOgcAH9HU0iv?=
 =?us-ascii?Q?v8TWvRiXXpTmM8hu83ZcapCqOdmenYo+wR4CNC5owOwU2cLzvt5vlsGRxNq1?=
 =?us-ascii?Q?qpNSPb/YZB7squpx7qOBlA5sqVqesh+SyOQmda3KvZrdoP3WlPhI3fXFlmWZ?=
 =?us-ascii?Q?oEqiapqh8VBINEqv/XVUtxGBtPiWZ9PMKUeSCgymfKSiJ0ZjAyXuhN0hMhxN?=
 =?us-ascii?Q?cMSi1V6KozqrPUT6pffyV7+AKGMcj9luLCI2Og369G2CaCH4ZWTAZ8+kHu+1?=
 =?us-ascii?Q?ojkEnJT+Qq5nZesgLLdHmIPVv/rC0OaYrr67rMybVLUBjSK8urOVOJSFPIfA?=
 =?us-ascii?Q?IiAZ2IZ3npcLu9sNdLoLBFQ6+0a3ePpyBceO62mLeEv8b/iFOwB1V3YMTyGf?=
 =?us-ascii?Q?gYmITyFIt/lp8BOyYaQ9T05spDvcadyvP5QWRwnSNKUgVEccdRK2++uij5aV?=
 =?us-ascii?Q?HOtMu9Mkr51e/LmWK41+N/Ua9A6GavD4pl1SyjUIyQ98QZkp4kf9TUn85RCp?=
 =?us-ascii?Q?DIJKBjthn71accrorGCt8Lo=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd765f9-d823-4495-066d-08ddcddd839c
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6657.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 13:49:03.6962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9JHjZ3ssSBKcDBN31mnCr/J0RbIXq9rZktEM5UJkyYYY3upsroaF011ATJfAQYmxOFXrg/3waoBw0fBlnqjYSL1G438c8PTtqjbUzGsSeaoReeR3FO+FV7xcpKUeW8f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14280
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Jul 2025 13:49:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19607

From: John Madieu <john.madieu.xa@bp.renesas.com>

commit f7a98e256ee30f50de1e7b43cc383828834e8c9e upstream.

Add a device node for I2C2 pincontrol.  Also enable the I2C2 device node
with 1MHz clock frequency as it is connected to the RAA215300 PMIC on
the RZ/G3E SoM.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250329121258.172099-2-john.madieu.xa@bp.ren=
esas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/=
boot/dts/renesas/rzg3e-smarc-som.dtsi
index e9327cf9077f..d93c846ad391 100644
--- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
@@ -26,6 +26,7 @@ / {
 	compatible =3D "renesas,rzg3e-smarcm", "renesas,r9a09g047e57", "renesas,r=
9a09g047";
=20
 	aliases {
+		i2c2 =3D &i2c2;
 		mmc0 =3D &sdhi0;
 		mmc2 =3D &sdhi2;
 	};
@@ -74,7 +75,19 @@ &gpu {
 	mali-supply =3D <&reg_vdd0p8v_others>;
 };
=20
+&i2c2 {
+	pinctrl-0 =3D <&i2c2_pins>;
+	pinctrl-names =3D "default";
+	clock-frequency =3D <1000000>;
+	status =3D "okay";
+};
+
 &pinctrl {
+	i2c2_pins: i2c {
+		pinmux =3D <RZG3E_PORT_PINMUX(3, 4, 1)>, /* SCL2 */
+			 <RZG3E_PORT_PINMUX(3, 5, 1)>; /* SDA2 */
+	};
+
 	sdhi0_emmc_pins: sd0-emmc {
 		sd0-ctrl {
 			pins =3D "SD0CLK", "SD0CMD";
--=20
2.43.0


