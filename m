Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CD1C7EE30
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:36:13 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.64])
 by mx.groups.io with SMTP id smtpd.web11.20550.1751452563685648177
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:36:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=OR8WkrIX;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.64, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KY9g3Igny8r7/CDPKkLEufCMUcZ2o8o7U2Mjs/HwUerfVK6XPKl8OEludHyl1W1dWnykaKkRcY8fJslMOy66XFx6S4WltkIgpekSSS75o/rV7DBiHVt/uMjmXbENyGCk194BUGSbP3XRDv5ehnqt+kWHkFvXBionE7dSp2zD0ct4GxPz6mbeWF4I9FZLRXWyePw436JWYsVw78ZLnoiQFrSUpOCKANOQXpmXxHrzGvZOCEl9UB0V0J8M/j+7PD9RZzi+FwAGDFnAuSnfUOlmoSLefoAoyY9Eo7ycciOdHnsCHfy/l3zzgpCth52C1H1QsHOabeebJGRfDkJlwrnCFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBMDynYCnWpssBNu5+WenTqQs+KRVUU9mQvw2TqxCV0=;
 b=EVheHRNpz5ElNtFWYW5u3XLTgUOQJz2hgXGCsSZuJBSDLDxDJhf+bgRhsI1UFSZ6GxEhphyDwPDGMYhEKgpd0V1723gevc+v2dru8vt7czrxt8FEkO1HG/mvf7Eb6Ny++HknVuzHLBNav1g2a3nN5dJU0rVgZJin0mnoeRLchRoux8jj/RXZBcKL0yQylesbKe08ZUs3Z5g9RWngiotWj3VkrXmcpipjqSrGvR4zeuyzzKFnhywOVjDRuSMCHhYKbHHmIWveSNzl5rHqKqpesUfQFEKCt48A8xFkezjKJ+ErBRvOB/eVFctnyF719m8Vdf2NUJsAuhxCXzrzH7kGbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBMDynYCnWpssBNu5+WenTqQs+KRVUU9mQvw2TqxCV0=;
 b=OR8WkrIXP2zqY7i+E6QTVTptzJWmWDc4OUDjGrJOjp2hJDvwqCFIYhqXKuP0k3H9zzjspy2H58t90J0Q7ij48zYkSntBqWc4lI5+zsNSaMKGae0BZFWNjeZM2wA+BMPP53ZTT9XXyeqk87I/3gY1zOnsc8xNrt7pACT9il/JxIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB14154.jpnprd01.prod.outlook.com (2603:1096:604:363::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 10:35:59 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 10:35:59 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 04/12] clk: renesas: r9a09g047: Add clock and reset signals for the TSU IP
Date: Wed,  2 Jul 2025 12:35:17 +0200
Message-ID: <20250702103525.117166-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702103525.117166-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250702103525.117166-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::10) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB14154:EE_
X-MS-Office365-Filtering-Correlation-Id: ce527cbd-f0ea-4420-126a-08ddb9543c04
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?X1AEWa6C0KSIhgzUu+AXZvOilw/xvnw3lIsK82c3f2m8J9dfo+QBdaXJMNRS?=
 =?us-ascii?Q?06ZZDxaFDy1RuuOod3Xwn+cocwv7AAz9sVDP/Fhgn9TpHySF8gSczbq8HB+E?=
 =?us-ascii?Q?uhf/g2me+P5iEJV65X3KGmewZJF7x+H/EaAeJEV8k8nELsWTbMtqMyc70x2T?=
 =?us-ascii?Q?ztUl+jGmtSa64HosxspBDou8oDd+RJB96A/Pw2kvFJtBCC2N1E5aAFPBtxTc?=
 =?us-ascii?Q?ez6wd918Z8+2JzOuEa++v9AEs3eXTmLKX7s9WVSy8d80Pk0uNjR3VQv7uPGO?=
 =?us-ascii?Q?mz5EATZv5fEK++TgJHKyF1lwuIjcBh3ej6LuVgG41a6seXeXN3BusOaOSmmx?=
 =?us-ascii?Q?3ubXBnlUsmoCcE3S3aom3bnwA7chQ3+lUb6PY/uw6fNKi/4kj6xpr5BlunIL?=
 =?us-ascii?Q?bHyBMZUPrO9VAEgTJImDW7qZvRjTlXEjiyns9xv8m9xtJt3m15OnQWVuEK7b?=
 =?us-ascii?Q?s1M0Begn5civx04b6ckGoXcMWToYBFLeXY3Qpq776wFkLqbl6fTcLb1R2YsA?=
 =?us-ascii?Q?9ABJrfxR9oQPoEVRSRuv5NVH4DRfbeE9sj9FuUWmPSY7/sqTdqJfCdqiy4/M?=
 =?us-ascii?Q?C8fbns+5Oy3G1Zbbf2Ex75acTBj5XWWloOPA9HOA3XSnqN8r5MEmVtiZKh4d?=
 =?us-ascii?Q?/GJ1TFT52zz5iuv7tBik0nRAIIrDd2RQ13FjWwNRPFkxOio9qhV77eAcXQvU?=
 =?us-ascii?Q?/a0lZuxHuAmDsXCe7duOKsRWeOE1B/d1XTxtANbhc4uz4eF9hP5NOMop5sj3?=
 =?us-ascii?Q?uEP04VvVUelZCLZgJjnLQmjai9scfZNvaUBRSlR+Vjc3xLBTckdEOechbdwv?=
 =?us-ascii?Q?FdL755wZWhjH1w2ahNqctq1tUybMV3x0L6b8am+XPLxDYJdtcFLilFMGEIMP?=
 =?us-ascii?Q?jQymUK325ZKYVYuZiA+lSbGC9oDB0lW3yYScOBJhnnYTWtO+I+1dG+bIm9nb?=
 =?us-ascii?Q?L6QVr0CzwlWOClI0++x2DSXe/Ns8HXhcipwZxIN7DieCjukd91WMZLdMHFf+?=
 =?us-ascii?Q?fh8c6hSfY/RfvlR0VKH0cJGjLIg6jaCPK1zMwbjCmV77oWP5KnGPen/NQHNP?=
 =?us-ascii?Q?Y72JZcOJZqxv9bk5sA9TTuBclUz3BXOFyzJiTAMAvmv84rK3ntmzsK1SCLAs?=
 =?us-ascii?Q?MWQfKMSt443vDP1dBSwxZgqA43uWz0+1b0/OUxShBLWaVH+TnyRLEoFp9NiT?=
 =?us-ascii?Q?qLz5luukgcwYfY7HzZ4WyUEyL5g4aHvzqWGZU9SX7nVkYgnmQ8mxmFXAZeZm?=
 =?us-ascii?Q?K7nadyQKD5Zu27XMqK6CHP8fKvApBR5Bq1C5slW1LqgSNnRm6iEDmhkWrnVM?=
 =?us-ascii?Q?c5x22Vbvb6F9h6EkZSkJuwmi0xUtbJod9SHwUVqaafDjdgSKb46x2RwiTG7Z?=
 =?us-ascii?Q?sP+010SJYLyVdGdNMh4NeyE9CAcElqWtFyH8UuaIHhhUKX8+0jLbVqQfa/LA?=
 =?us-ascii?Q?oMH56AawH3L0Ii3gT0d+dmOBGEiChNaHts8ktXa+c89Rs+R35WIOA0lusf7m?=
 =?us-ascii?Q?AEJk96JmW0CFgAk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?k5LntP1vor5EXaZe3TiSKXsrWBWEx95vBg7Y950OE+kzgUEliOxIRxZKDG6F?=
 =?us-ascii?Q?maTCvTmTveCANJ0zDqb3iDuqTGk4zxJU/jRPKHCuZmyZMGiaNHq/0YkHv/0+?=
 =?us-ascii?Q?5V7MBKk6DPs5bAn0urNNj1B7tkmxHXgyYXTINdRHkqVRbGsiJaaMGLPwNl99?=
 =?us-ascii?Q?0IHarNIeMd49nTDhXkocp0jLs9/G2B3damGLnIO/yEMHen0/per6FRp4wrDT?=
 =?us-ascii?Q?8AxcmY0XTXEkijIBDzHIDNkoq/n7kcgq4NytcXGXCd0Wp8yp/TB144aYogYF?=
 =?us-ascii?Q?ZrfA8LtPXp20sNx4CqzfnLjMX69f5XVA+NJwnMtiyJueTRCCju1rVCAyROIo?=
 =?us-ascii?Q?C7nidqxMbk6dDPD9wPxJ3YV1nWtDRknh7TR9snRm9XZthEBR6FLGnIVYKorU?=
 =?us-ascii?Q?xI9D8I/uO32M1TPSymy3NuluAH+Lv44lZayfYcZX0vtQCMBeQqJNgRopMkMc?=
 =?us-ascii?Q?XXid4Um2YTYFRpYR0lz/HhUDxmYBd9mCFbpUJ7UrxQ4gl7SN5QknTmPqGKx1?=
 =?us-ascii?Q?o+dqgKO6ovZcg68fF2HA4r39YpGVKo1u1mDT6nNwzYkrC9G1UyQ4NpgbUQ8P?=
 =?us-ascii?Q?QoV4hi01eM84CwiR7ba2ObDyQEKbWchT/1H8INuoEi4PMLNq7U2ijOB7DiIq?=
 =?us-ascii?Q?+xXaP0rtQKsovIA4uADmpbuAsPDBi9+TsFvRF/s5hPk//UgYTA23RbS7kxLX?=
 =?us-ascii?Q?yWV0bEm1uPITQdY93TCki7A6LMhFALiPCptaQTPz0jevfB/eOxgDA3VWzWei?=
 =?us-ascii?Q?uOENZNX1Vim4MKyVjnrK+8Y//18jPm7AzpEqTUMs1jHkBhQ7hVfmM7PyZAMe?=
 =?us-ascii?Q?WnSp6+IcaNyLXoBR74RNkxW6U+Vs15iGzxPJj+pqBY0CGDBAjYm/6oz6tymY?=
 =?us-ascii?Q?rDJJrgm6q9Ko7aM32XRkxOX86rVasea5N00VZ8MO3FS6FYsmUQgSSza89Xkz?=
 =?us-ascii?Q?7ba2ZPwkqJelf1vQJAw26Fst3yF/+ShWsyLO0mUPfmltmNYsRUUuFpVbRH9K?=
 =?us-ascii?Q?ncLS7BMZr0SCtHkGSCvMKqBylWC4Cn+xzanKkThyJ98nO+ioY5hIUpoZX4wI?=
 =?us-ascii?Q?RlgSm1Z8zeXqwkdgs2sUgMWt8eKHsAi8Vhm7R8v45UqWr8zYw3yGDvqSdv2v?=
 =?us-ascii?Q?eXhqYKPfRLNdJz0/x+PnConwoPQ6a9c61Yk/ZtfQQcJlNNpl+Np2NR0sBo28?=
 =?us-ascii?Q?CmSFS5Ca80jizJGG0m0ok/iYus9Qi+LHKYU8PpiP8V4hOC9noOsvEirc/jfi?=
 =?us-ascii?Q?ijo9usFYMN4fM+3NWD5qn7qQNYj3828s70C7b2GZmvA55/KUU0R08QFjn64h?=
 =?us-ascii?Q?jjiSXu1zN7e4yrxZ+XenZBWBJPdt1tAB9/kdSjKYFaeVqLpiwoRgUHUsQGOc?=
 =?us-ascii?Q?wTT0xSx8k+HsRjtlDgQOkgTagbpemV0IYlGNoQwxTuFvVgSJyoCDfcL8Ha7r?=
 =?us-ascii?Q?nO0oe8tZRhthnhnqMHNmauGePTbUcZuZfwCsDqMVi4FhhPBQc23RA7j/X09r?=
 =?us-ascii?Q?y/sfUQkyAJyKmUptkusfLrQr6BG/5DaALk90zCNCN4exM+K31xDv7Gz6/WvA?=
 =?us-ascii?Q?8S30ksYbWbiP0vLrDVQHX9NXRB6GFyNQz4avvWEgzaHhkBDOKQWbx6YMGwLA?=
 =?us-ascii?Q?EHc/2VW3vW2aWHyQ+RUGUXM=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce527cbd-f0ea-4420-126a-08ddb9543c04
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:35:59.2810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeXwEDYsaaJJj9fFAx8UN8hOgviRB1SxYFWMbUefgTX+Xgvzytn3RtsG4ZscgX70HbvuYR10p7Io11M7XF3Ni2och6WNto/TCsCT1nrCoArq8pD0znUqECBcWHl83zwd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14154
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:36:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19289

From: John Madieu <john.madieu.xa@bp.renesas.com>

commit e1a098330ef0555ad216e549a018d99aee7752c1 upstream.

Add required clocks and resets signals for the TSU IP available on the
Renesas RZ/G3E SoC

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250227122453.30480-3-john.madieu.xa@bp.rene=
sas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index ff015b3b4d2f..e9cf4342d0cf 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -183,6 +183,8 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[] =
__initconst =3D {
 						BUS_MSTOP(9, BIT(4))),
 	DEF_MOD("cru_0_pclk",			CLK_PLLDTY_DIV16, 13, 4, 6, 20,
 						BUS_MSTOP(9, BIT(4))),
+	DEF_MOD("tsu_1_pclk",			CLK_QEXTAL, 16, 10, 8, 10,
+						BUS_MSTOP(2, BIT(15))),
 };
=20
 static const struct rzv2h_reset r9a09g047_resets[] __initconst =3D {
@@ -211,6 +213,7 @@ static const struct rzv2h_reset r9a09g047_resets[] __in=
itconst =3D {
 	DEF_RST(12, 5, 5, 22),		/* CRU_0_PRESETN */
 	DEF_RST(12, 6, 5, 23),		/* CRU_0_ARESETN */
 	DEF_RST(12, 7, 5, 24),		/* CRU_0_S_RESETN */
+	DEF_RST(15, 8, 7, 9),		/* TSU_1_PRESETN */
 };
=20
 const struct rzv2h_cpg_info r9a09g047_cpg_info __initconst =3D {
--=20
2.43.0


