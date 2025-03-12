Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55859C28B28
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:05 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.49])
 by mx.groups.io with SMTP id smtpd.web11.34804.1741778686841613467
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:24:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Dc1GXSZx;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.49, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yz2IiFoSVixkXhq06yWFUvB8JX1LMQMnmw7mLY+JCHUUoRSYGviUsFCMGu24v+0tDepFEta5avO/gIZe4wMSfZH4GjBfmGNzq6Eak+uy2/LrFuIV99gR97LyDwbZuOpYFXNARdvrNk0hLmol1tzjujnf5NohX7Hx7NoitFVvlERvpnTVydF4k2RDQD4g2GHQ6/MCU5vVsISgTr2DKywOnb0fgxMbSjI3Pv7gY8Hy0xuUrwGBqjIC1mM6H3iQfZyXwdBJKFuIi+RSKlIbOL/QpbXnxbDlmMoiwWOMoDADv/7TCKncAof8+BLjXOSRAJelNgKQUpUAicFqg4r/PGj44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIeh+AAMG1mecrNT94EVI4VUUsSQSSL8bjSO4bQ8uvo=;
 b=aPnneuT/MIz3ryceQwrmUDktlo/EBeRHd9DsY01JGHjPscYeJ0x1qA7z/AkrwLGayXI2syYyaE+AjdWaolAnHfFfCGyzf0rjKF7Tl7cBkoqzFMGvrk4UgBeeWle+pmNb/2PFCi6veVE5zdyK5Sl5Y39Wr248H5IcZTQ25XCjlBWjCygxFC/Zyfmx/k4vVtcv27NrzKzpryc5WA0lHoRooRE4c19VDLoUu9lgWNOySUW+xxkuuNShXAixAVrquMNu53YFuglM1CPuS18akVMAn7UvhdKsWT5lHE0MdYgMbOnZ1tihC+Wbb9k9KVSL+ImFJ5nAYuDzrgrDYC3/m9+pmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIeh+AAMG1mecrNT94EVI4VUUsSQSSL8bjSO4bQ8uvo=;
 b=Dc1GXSZx6NlocLhI5VeSrCkpzcipgj4U4gHevUBkdP9TXhbtMuPEamMz7s5oyuk3C/iFyNR6daMbP7fb1LASnRtAEO3CPYYbDfFLIKcqWukosFX7Ce7fVjx5XXr4ZDfUNiNRaNsWowi2NDjO4HK0l3bVyvwqFLqPDX9845Gcj7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB12752.jpnprd01.prod.outlook.com (2603:1096:604:33e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 11:24:41 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:24:41 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 22/85] arm64: defconfig: Enable R9A09G047 SoC
Date: Wed, 12 Mar 2025 12:21:59 +0100
Message-ID: <20250312112302.1605750-23-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB12752:EE_
X-MS-Office365-Filtering-Correlation-Id: 060c3a40-14b5-4e8b-6261-08dd61587b3c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?VJCAYmH6DfjXiLnwQu+y0GJgnuZw89gJpzb4Q6tNNAnEnTmMdpZCthYr8ccB?=
 =?us-ascii?Q?Lwx2twai+6ThERpgB5vy3wLd6vjhvL0uiG1qbmUXdDr4ZxpnG5WLmKNf6LA3?=
 =?us-ascii?Q?vqZ39BEK61ZmbUPxFZZv+99BW725sptzjT+HfXT5XyzTE1YV4tkW1AeKyFmS?=
 =?us-ascii?Q?PdyJj0ZdM2iJYxVXqTKBOa9e6jHU0De068hedrcsS4E0n00J+fuGgSlvBwr3?=
 =?us-ascii?Q?Ds7G+A5QGDiPAiFETWsk9A6udWUQp1bkPgzlMMZiCuAu32hVIhZ/q7etuWnN?=
 =?us-ascii?Q?Y3ZekSRJNkGyGX+PgVCeBcrli5f7+/+lsZJS0OHTkaThHyuhbxwnQdpKmjIE?=
 =?us-ascii?Q?tSe6+JFuzA7i9Q1BVOnbtXvX7J5+ssKaCVCN9pzRi8SuIxCq4dZl+WC3O3vg?=
 =?us-ascii?Q?ZVTJaouIRJFp2T6bDItJS81o7P0b1WOiGnsi8P5IN7W9NfVf2dfCDbMQWgsL?=
 =?us-ascii?Q?gAvByG4htAlXdpPamC3/P3FeyL5946wNtrV2SUzk55OCZN/J48NEH8GJOFdC?=
 =?us-ascii?Q?doSBApBPty89CorkJFr8zey6AT+xXGgzeviFjmQjFjkMcHMG56Tnr+jX7H50?=
 =?us-ascii?Q?WpZfH6HOL4RyU14RZ7/niID6ExORPacDhew0vVIlOy66Vdxmnl60MbxLdFs8?=
 =?us-ascii?Q?ffj1XdzXjCCi6z7huoN4Wd6aRY8PL/LSmyNC0i9Lqcs0THicqiy7MRjd4UbX?=
 =?us-ascii?Q?0+kJpTMfENYC/NgKWP+Og3ket+Pfi6dqE+mLlDJTUungcT8bBGpmkNjia9nD?=
 =?us-ascii?Q?8mh+0JwW65Np1vZIoEm4IgAxb/aBxm1w8bWqnJHSzxkrdfSpp00VuNPsG5m5?=
 =?us-ascii?Q?xreU9bkZX3vPx6LZKJNG8wNgYu+bMadZu34yvZPVR7vdEoLiEmE7OkqHenqR?=
 =?us-ascii?Q?+YIvgGm9ryC2qUFOl9BYCjYQ50xS+N4YExo69tkCwZTFm9muiPiBqi2ulS6s?=
 =?us-ascii?Q?+dcsNKdHzhSvUBv79lx/HG+dLorzHw2w4nPFGVq+PJENdoecuNy+17BYR1zp?=
 =?us-ascii?Q?C7qZFA7f7P60ssyR/87JnCB5b4ZQJ033zsq12Xk8zIRRRjvSNnz4wllqTKyb?=
 =?us-ascii?Q?aS02nAknYH5G43U66BD/QEiCpYd5Jg0e9dE2xr60jNlH4ISI4vTtZSco72jE?=
 =?us-ascii?Q?jliplU7qLxypZk55gjt6JN2RAodp/C9sSEFrh7HoQR86o0ivkEu/LmN0kf8+?=
 =?us-ascii?Q?HwGKRsxvJ/eT+P5Kw9JD/jsmKg6ji/QQ+9fqiErQYE9lJpygHreMZmDAHg+G?=
 =?us-ascii?Q?cxBYCvVc5BcpZdzpgIZx782xNhUgr/duek3/Jr9yTQ+naY4RywQH6BHu7Up5?=
 =?us-ascii?Q?G00ePFafYkyoGe9pC/bF9DZzfbmqQ+lRvU8A2gxheplszV9bSvby+eN2pSXS?=
 =?us-ascii?Q?9hCrjjd1ET6EL4JVc5YMxN/bHZezIO4VNumnMbEdROkei0qXT7KipHxcwMYX?=
 =?us-ascii?Q?XBBEv+x9WWknQ/X8xx0YmRNi/yHZfwEo?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UmM2sIgupmLycdXH10EZ86MHREQOeCbZGpJJAtDAatPDJHeDDnDlSplV7Iyq?=
 =?us-ascii?Q?uANHMoQphaHhZH96ihgXgNsI7vaeGbAlPgCPKz/25Gpcatp25bAwB68XDvAw?=
 =?us-ascii?Q?bojZn/b29WOkNv46letTGWhG6O667XOUVJhQ6xx9uHhepQgUiFDEeCEqLOwx?=
 =?us-ascii?Q?M5csITuDMwcEK2BJ9Ia8gKUGAmX4+OBRDLzqOC6ZdZqd+r5nXFnRXqErIy3H?=
 =?us-ascii?Q?REAzA4dIgbsjLRzShtsyNO8P4wELGLBcuV8Z7ktLZNPBdRQ4fCGGNTdRTkmi?=
 =?us-ascii?Q?9UxBwnBwq/2jq3IObicmGwCN1qUvuIFkNSq19Jp0lFNTdq5TWRYTEzbxpWyM?=
 =?us-ascii?Q?LkSz75COGJhsVObh41AZ1BKOZJMXJkF5rq8cnzQAL/FiRx6mJv1ttvsBzz9h?=
 =?us-ascii?Q?8yueUT3XhKdaa/7XqOX+mP3lISpTK5U/Mu9JynK8dgTPeIIZ9GBs4LtVPh5h?=
 =?us-ascii?Q?wjedTziYmNQvlgu/Tr9qcLhD2GVNwSD+a/XGXlTPHdb/GqV/SkzQXQgnoJUa?=
 =?us-ascii?Q?KxrdZqnrgQvnoAUJgfCpmyVlo6ZNsLw+aPVm9ROQbOkbaO8ydHSlHL2gcJAr?=
 =?us-ascii?Q?dI07A0rn3XdjdvTdzDeAX1zYCnd1jt9NVdnwmhdL4euNl5/cotNFC/CC2pRq?=
 =?us-ascii?Q?PlWhG5nP3Wg+MEGzT8qtbyp0VVOBF0diBzKSndFUHK5ABfVcLj596kEIsla1?=
 =?us-ascii?Q?wm0oepk29rHbb+0kUm4PG3v40MpLziEaAozN501UHxJKah92SBjwJoveRyNu?=
 =?us-ascii?Q?P9SO92E26/mSMQcZmdRIvz1mWCSGNYfRXBlwDzsA4EHJ3IskxORcZdLEgJWR?=
 =?us-ascii?Q?D3o0Y/22OucZCcaCq6qQWzvqS+1YsVR1LSZKzboB2oOCyA2NMvbcQh9uzAdu?=
 =?us-ascii?Q?TNW5LSDf7Kayf60z0qjEyl7E+jFMCs+yS/s9Y8r+YcovBFn1Cf8r0VIIcgDv?=
 =?us-ascii?Q?XcAoCT9Ovo6zSE7b/EJkQsG/FIZbAk8wWg0fIjjKN9L+9Z6oNIsbafpvnAgQ?=
 =?us-ascii?Q?SSuiOfluYByiJOqaxeOWZONFJu7dOvW8KB1RvrUCZPkWbLDOLvnUIoiR2dWw?=
 =?us-ascii?Q?Zcs284gqy2F83O8NSzGkwcHurznANH6j1adUDqaLEYncV+iESiRRp0AvNcEl?=
 =?us-ascii?Q?d006FL/QGEGqjiYuIVcI4TFulu+vnBVTCdbV3IFgZMxKt69tiZEibtBhcgb8?=
 =?us-ascii?Q?a0b2LWZX9SxbV7lwFQnyZU5K+j900wNva/e6dqRNaZaPmRq4O9KgXnDvmEn4?=
 =?us-ascii?Q?MrkZV+upaS0vQ556Whmv1NjAscMCWsO+2BMJmX5Wq7kOFkkgpQ1D8Qnr/Ay9?=
 =?us-ascii?Q?pmCcTa4khPVxawbjd1UX3K6eCtXYESTktPOnGWpvVeB3MtWOxTgOQboBxyUh?=
 =?us-ascii?Q?pbnxPqHCKa3Ply7dRpf+NgTvrQhPWCC7VSyhFOm9XbVh5MMjVHKcSjZbp86i?=
 =?us-ascii?Q?sE0Mm+TrTjaBNLgpUefM5G3kqInAXoFBBaVhtn59R7rTPOcEOVXTjl+Q9rGN?=
 =?us-ascii?Q?vjggIGpd8VJQ5vr7twg/mLMg5UxfH0P6p9X5FwYM8kioOSDk9xNF+PjH7MKW?=
 =?us-ascii?Q?t+GYT6qMWcOoHjzeAzA8BPZmPrJMAnoI7Wa+tMW1sRspKs6j4h9iFo2Ux5IJ?=
 =?us-ascii?Q?vAUGphRePCwJIBHlfPgAnls=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060c3a40-14b5-4e8b-6261-08dd61587b3c
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:24:41.2965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSzcZJjtRJC842BN2DBGxTFcthbZestP2ZeqbRx5S7YdZdPJWSkj/PfKF6a3IGUquvSrQXE0JESU8cFEAVntmFoe3iGsj57M4L6fEEnLEKFrhlGmD9Np4NMdkFDBW4F7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12752
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18115

From: Biju Das <biju.das.jz@bp.renesas.com>

commit a40f02b2923b6d58e76cfef760b8ed61a00f1d53 upstream.

Enable support for the Renesas RZ/G3E (R9A09G047) SoC in the ARM64
defconfig.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241203105005.103927-14-biju.das.jz@bp.renes=
as.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a15bfa82fe59..459c1fac90ff 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1182,6 +1182,7 @@ CONFIG_ARCH_R9A07G044=3Dy
 CONFIG_ARCH_R9A07G054=3Dy
 CONFIG_ARCH_R9A08G045=3Dy
 CONFIG_ARCH_R9A09G011=3Dy
+CONFIG_ARCH_R9A09G047=3Dy
 CONFIG_ROCKCHIP_IODOMAIN=3Dy
 CONFIG_ROCKCHIP_PM_DOMAINS=3Dy
 CONFIG_ARCH_TEGRA_132_SOC=3Dy
--=20
2.43.0


