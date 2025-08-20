Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB20CA0EFF
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:06:44 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.21])
 by mx.groups.io with SMTP id smtpd.web11.942.1755706002080416633
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:06:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=MKqMfmjb;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.21, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4gILkR9GXmnff0cdijeHYvvQIVc+2Hd1mJ6ZKGkvgyfxObD1G7O6xbuIwI996WAnUREIPCcC846PhbHFXQc0/pwdaJzg+VkxheFR1z8ceCLRVWirFPnedHgy+GsMNm4bL5Wt3GAIXwb5fuERuKXx6abYy4h6bsnAQvgENr9Q6PgaFcyXTSgLJ+/oIbJy2ICZTm8y7gqPciWOtJwsTkpfe/vz9mP4H5vFSrbDsSxSlNeYoq4yMaGEnjSFgu3VWI137YxIB4DKPBGqI8q1j6udwy3k5He4S2WuS0PvuU6ppeMFn5Hni5eDaAaThVcpT46EMpnk8FgBfg7flz55wUtUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEEfF1FkGpjTnKZkcZgUR+EDxAv3Hxvxm/5pJorFqPE=;
 b=h3av0vb6eFKomYEh3Y8VCkx0tVaEbojwVH4ATMJ5mBt0P0d4nL5z99XtR/FVokAtjGcDPF66yKukZx1RQikeBl2HdKuaBD1pDp7wN3121tey+y7wlKeyrZO0IaaNJrj4/5ObbtYTJdXRJXu4pHqz0cVJ22X0j4i+WORVnr5qsO7Ew3JeYd8dgJu/eEZ70xS+nH45pbFgcn8Y+0KzpwfbFlxJkO9Zl3ziMFnlMXN4ThWcTRUaeaws476mclzpUkCucfrwf1/3Ez6mtMRumL7/gqHgYjuGt9Bh1H42BiSjogh6Whq/zp03XMZmn6OygwhJZhNrFc4TiZs7zecVQqt4sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEEfF1FkGpjTnKZkcZgUR+EDxAv3Hxvxm/5pJorFqPE=;
 b=MKqMfmjb/PPvS2ZDe7w+F6iGv8infSsDD9TZtVr7WJwb0MTG++5H/i9rVHdSK23R0+BsUG3jb/pLD/y3zmg6B8LCfznU6tpjiUd6v2ZqJ+q+7SdIAqkhUj/J3DsffGYrB//Rml3bk87JLKwwPC1S1TtQYyucw+yVsHeUU7Ktaqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB12116.jpnprd01.prod.outlook.com (2603:1096:400:3da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 16:06:40 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:06:40 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 48/55] arm64: dts: renesas: r9a09g047e57-smarc: Enable CRU, CSI support
Date: Wed, 20 Aug 2025 18:04:04 +0200
Message-ID: <20250820160413.801341-49-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB12116:EE_
X-MS-Office365-Filtering-Correlation-Id: dfb70ba6-3016-474e-9bfc-08dde0038c6e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?BGSL8ViwtctMrVjz68vMpu2isjqUjxF0/903nx0dLGh8sp1sBTnDgMJfbkCl?=
 =?us-ascii?Q?I1FqBXCtA9yOwcrZ4Q90hu2aL8sDhyv7/l8FOMXM8fZF6ABzeO11LeZi6cxr?=
 =?us-ascii?Q?sy3tfMbpWM5h74gYLcez2D8h5sagKg3EcSMCZaH5oCaCpEVIRBey3cqdwVU9?=
 =?us-ascii?Q?YywUGscK5zzB7C4aNU/R9wNyOfh//kuR+qjRrcDc3aMkSgIWCq0zgre39xEi?=
 =?us-ascii?Q?S+wv+szlPjdP31OWuoAwGXGfNvh1QeLvZoWHECTCw03ZAV8QRtI58X3d4/Gw?=
 =?us-ascii?Q?KAjMry5oVzh5qZAcwnqo2pDTQ9cokA6bGewg98TQx4kXjTJoIDiQ5ZelH1dd?=
 =?us-ascii?Q?v5zF2e+bN8lvJ/dXtsQz9PwG1aXealQvJcgG3FO0OtH1UjtTp9QrBBSqKw35?=
 =?us-ascii?Q?XcD1hiBbLjslCmsdVe6BEn9JlkWfHlfS3JxDi/O2/FpS3aNux2JEDx0XXd1p?=
 =?us-ascii?Q?/PGs1Hdf3hjRr5Ob2djnfLPdxCKMXfl3aMJOrOsy9TUeG9P6tglNAsPXSLTG?=
 =?us-ascii?Q?WZom63VLvA3P1CyQo0IR++lu/YaEl0Lk1OyxCtgTHcYX7umtcYDrln0JdxhQ?=
 =?us-ascii?Q?9fN8WRPh9rj2GGgbxFeEUQmzBJ6xtsgCU4ctiNc5ZR2USTOSvwbrh5osdCEU?=
 =?us-ascii?Q?IkK64NwmZQCP/t6Va25eTaPDKHFJ8QRjb4mk2CU+bB402xq4Lojbt3sxWqCJ?=
 =?us-ascii?Q?jIpHsNdFIg+Iz/hKxrqxvUVag9lCfblKys9wPGKyNm09fnVatqUXaGXOLpW+?=
 =?us-ascii?Q?03Bvx9VsGVAr+R22QMJWDr1sCpSfsNS64KTt3/H8VBeH46OoQFaGNTxgZq34?=
 =?us-ascii?Q?cu/7G427WsJ79jjGAuHPh29JEz0itbM9ZJVOi4NHWu9oTFeP1XzKpAwAVxjx?=
 =?us-ascii?Q?f9253FZksVlYi8cfqOjDJvgrzGNMYiv9JKYYfBKGSpl7O/YrPBbGNuLCbriq?=
 =?us-ascii?Q?0aEkN64Ye+JcNnD/+esCyIls9D3Wyd0v+S6nXsrsmDj/D746J/YTrOpitFdC?=
 =?us-ascii?Q?NUrzfLSqu716zsIRS/kZobz8uiCeMj7GW+U7UVSMl0rXi01At7vZ0Rj6g7pU?=
 =?us-ascii?Q?deWzyKkaQWcrEXJTi5M7cGdwl52HPSm7URGa/Bn/yOarjgvDJ25e5ypgrtoD?=
 =?us-ascii?Q?PWtweGPbNWj8XimMUwn44bbLqVwu0CUiyu36nlhx9NUSwBA4cp4gQJsb6xkZ?=
 =?us-ascii?Q?XTakX4CEHSmpbZACbjvW5/BleFXeltmIVRPIfScFevH7auLE3Z/5Iy/cdwsG?=
 =?us-ascii?Q?Or7XI9ZfyM2eRY2ZloUYv8Z6FkxYiCi29n9YRJ0YPXMr2rX6UzBTWWRUDxid?=
 =?us-ascii?Q?StOutXWoL9VOHSVt5wfdZaWSH+eilCvPmLzXy7eS79Sbp0mZcB04UeFwFnn/?=
 =?us-ascii?Q?PcBZkE4ckQocxDKOB0t6Lj3CcBorwMDgrVF5UxNO5jFLMmaxC27QUQEv9bvM?=
 =?us-ascii?Q?9pnqJzC60a2wQXK9lKxqpZpETlNvwfFJ7+tTIahKUuajnX8vIoISD0OxStmF?=
 =?us-ascii?Q?ACo4MCcBry6E3SQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?W/w/vF8kNT2m3HXh8za1nH/2Pos77cctJrJKEw6mP1e0APxIo0T8I6mQZf/l?=
 =?us-ascii?Q?cGQBcbqchjgStRQCLIi2R8jyt7fSGUIlEnrs+JPuBDkG7S8zfB+ywEgaPtfr?=
 =?us-ascii?Q?GDmbOFix7egLyjHkQ0HqCLvIOiXLRqXNxd1u63lxMppIVlkGlAKCbwdrKwvX?=
 =?us-ascii?Q?mq8hREW0QqbwpZaYreZ48ucz2uwBKHllB5sTbZaqRaPvd7qjb3xc3J9QgNmo?=
 =?us-ascii?Q?fpB8J0EKz41eOFBiLi5VqHYizxz5y75BXHGCD16Y7vfsbL3voH8dokMukrZy?=
 =?us-ascii?Q?QmsDzpFSwCHag++Kn9xb9hezchE4aK8ogfScvP0A5TZv91/8SZsySMtP60R2?=
 =?us-ascii?Q?LgPmyXvaF352+ZdvMXtcaKcdP7QXPLUgjlp4KVf5+w19yTO8zVKb4pKOU4HV?=
 =?us-ascii?Q?u3nL1ScGnJS4uItPbzoDDGARCQSlQdDS0STLBvFhc32surGsCjAB7Z36+Wts?=
 =?us-ascii?Q?YXSUmHp+XsoNEukNtysOVM1wLJgmVp0DUTiAAUmkPeYApgDVO2rmdDJhKHqB?=
 =?us-ascii?Q?f2RlF+pGEItNMZ5m86UGDbAM6dERT/Wx9dTIbM9mXhnNCkCq5ZiPL8/wcehb?=
 =?us-ascii?Q?uvSNIX4VYHqZdRfB4pDxF2kvVjl/Erbziwmt4At9Abocbae+IsWhklqvMfzt?=
 =?us-ascii?Q?rUhCQl7VC/4WHQatJzYc7cUZ0pedAXZsEl+VJwd88wu9ziSpZv4ofcwF6wdU?=
 =?us-ascii?Q?tg5yxu3RLwojwFTuHFn2O3Re6T5YhgE4IldWg3Qktgvl3ceKZ4ugG4/UjDMp?=
 =?us-ascii?Q?iEaJvMphL9bHqDC0TGyT6UuNSJvnGi1jGt/V5SGB4R1FHPmbewttKnlC53zX?=
 =?us-ascii?Q?44Qq2Tpv0J2UOfD5CoyHcvbaVEsGwyMzuCZ9wS/07ZvV36OYQ2QIN73ZBtdY?=
 =?us-ascii?Q?/UQqrRm/hHF9A8vhN5YkfvxWCyROQ0me3TcfS+p1QlFf62PCl/+P1bG0tz6I?=
 =?us-ascii?Q?F9zBItdB3PO7ThplSLxvZZdv32HHZXGlBkXvrejsQoOI4b4QsVKxzPNgn3Rk?=
 =?us-ascii?Q?ZW0UD4vaXmFFVbySF8Orx8ps9UxXgacCn9T/TCbwCnGt6Avd5Wcsd6p0vCsN?=
 =?us-ascii?Q?RNlzBJl4E/j+mbcTYfpv8G60ELkBqplHUxRcOvhljfnd+P/hSyl4CD3R3vHb?=
 =?us-ascii?Q?pI6+mEkfldUI6vuXvNLrwr5C+ohKFxaW82RC9Fa0Em5bH02LLKI55A99EaDR?=
 =?us-ascii?Q?W2UtOw2Wnq51z8q01BRqeL6YFF6pAZKmR8fTEr9jKpTbFNLISMoO8TLqWGpk?=
 =?us-ascii?Q?h7z9xufovenHRcJoe1yAzEEzw19/r1b/JwlfnylSTPMimJt27Vwu3KHdAAqn?=
 =?us-ascii?Q?KFowOLCDW/7KrOSLoNGKELzfR8UgjJWN76L2VtAjUmJrCvyE4xJljPkSgMDf?=
 =?us-ascii?Q?W5cSDvRhA+IKoe3C9uL6a1A5qr7zinX4owHHegIch9nBLc8JLCLk7rh0V01f?=
 =?us-ascii?Q?JoJBxvVlExe+2VFlMm2+VGAg+Uft7qd99JgGiGvLFThVp19uN3Jvc/bF53tW?=
 =?us-ascii?Q?g4mLsQ1qnE87TR617+t6hXwqrK/G+3NFLBPhX8X20Hmi+YDHkvUtEd3XpMGJ?=
 =?us-ascii?Q?886DzufDALH/zOi5oc4ZRk8YT0EWhofBHN2CEpaKYtTDZFao7NhRWQi2Nuuj?=
 =?us-ascii?Q?SsXYwc/8mIZ5CzMWXtGHRdo=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb70ba6-3016-474e-9bfc-08dde0038c6e
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:06:40.2826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFKaUP2peNZ15wEbBP5at1oc1eIUzi3fp0EmsEargePafuP4Y2NiPdohfQYiKxN5mD5TTDjsTio+6RDfraHJF/Iu2WmgnJJluv4HIwB88TmRL34lqW/CEnu4XLJbY1rm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:06:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19873

commit 6aca83a0a80195005057b56b9f1d9ae6c41620b9 upstream.

Enable CRU, I2C0 and CSI on RZ/G3E SMARC EVK and tie the CSI to the
OV5645 sensor using Device Tree overlay.  RZ/G3E SMARK EVK is a RZ/G2L
alike EVK hence reuse rz-smarc-cru-csi-ov5645.dtsi.

DT overlay changes are different compared to mainline. So ported the
changes without using overlay.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250514162422.910114-5-tommaso.merciai.xr@bp=
.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[Tommaso: Dropped r9a09g047e57-smarc-cru-csi-ov5645.dtso file]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm6=
4/boot/dts/renesas/r9a09g047e57-smarc.dts
index 2454a9743df2..f9d73f30abfe 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -21,6 +21,9 @@
 #include "rzg3e-smarc-som.dtsi"
 #include "renesas-smarc2.dtsi"
=20
+#define OV5645_PARENT_I2C i2c0
+#include "rz-smarc-cru-csi-ov5645.dtsi"
+
 / {
 	model =3D "Renesas SMARC EVK version 2 based on r9a09g047e57";
 	compatible =3D "renesas,smarc2-evk", "renesas,rzg3e-smarcm",
@@ -79,6 +82,11 @@ &i2c0 {
 	pinctrl-names =3D "default";
 };
=20
+&ov5645 {
+	enable-gpios =3D <&pinctrl RZG3E_GPIO(D, 6) GPIO_ACTIVE_HIGH>;
+	reset-gpios =3D <&pinctrl RZG3E_GPIO(D, 7) GPIO_ACTIVE_LOW>;
+};
+
 &pinctrl {
 	canfd_pins: canfd {
 		can1_pins: can1 {
--=20
2.43.0


