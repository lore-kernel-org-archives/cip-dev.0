Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C27DCD98F0
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:35:56 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.25])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10994.1781685353493350720
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:35:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=iMjEXgia;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.25, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6xpbThEGAlUvcFXxivikOtwnzMZWivkLuO/R2ww0ZUoT4k8kJZfHzUrxn0gmCLZXYxjkfVEnAmf3/2fjiZhhWbXUwXxydKsEnyVJrF9sGgkCAnY3jnsvJ0yceoBY/LkDCThZoT8pqF5l9uuVf6P807sdj1blx36VwNl5tWLyELigpVoL+0umPNJR+U4wXY6aFdTyxbN2jXZe3sFZ54XLDmlQtI6gvThgsrUK8j5LfDc5JD7EtL8g8iJgE7lkTY6TeIfy1LoZxNPKedHTCECIZxRv7k0hrEFocYUvx7hgLeKIMyHU2epn/K24L61loYR15HE1BIMmqkCvQcq5VpPZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDX4NDFB9d59O42KktZJujY0Ef44C5lKs17LwkCt1Lk=;
 b=UBcp1qhnFxE091FILSWK3Ut5pG4UoC/HZCoSJ40chRIdYZi/68cADWWH5vkXdWR3J2QiY7CFiQPDRP5eQDAW7OU3mCnmNyz0r/KZI81TLC3u05XppfE+5rtJs0JkRxXfQJx7pRVEjXfMJdn13aGcXGm234JWHUKptbhKXSkmseAVFY5ZaIwaAcy59Xzu62SYM4fmVjryu314EdEBJ5xWoN5qOxkuWlZdxj2JdSja+S0iTk08cl+Q/5ZaOkRLLloHgewffMy/eA0PnitgjffssZECwtpbTKKCLuSItgVgwvnOl4ANgPl//5YOVAliOJakBIDRi04qzP99SB+3mZnPSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDX4NDFB9d59O42KktZJujY0Ef44C5lKs17LwkCt1Lk=;
 b=iMjEXgiaIMe4W9dfpTm/az7g4UHHsqPnD1ZNxT0AjaA+yAeZ71oj0ms/TkSbutyew6VHd1Gx4rrLBqcftNu5loOnJ+OfsV4Haa8c25arysDSg175heglQh6nUEHh/yCn/NdtKOPQ/BwYQRtoh8gEA4hBRwl14nWpKNY1CztCpkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYYPR01MB13245.jpnprd01.prod.outlook.com (2603:1096:405:162::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:35:51 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:35:51 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 09/24] spi: rzv2h-rspi: remove call to spi_finalize_current_transfer()
Date: Wed, 17 Jun 2026 10:34:47 +0200
Message-ID: <20260617083502.1074160-10-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::23) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYYPR01MB13245:EE_
X-MS-Office365-Filtering-Correlation-Id: 94fb3d4a-83db-4b78-ee39-08decc4b701b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|52116014|376014|1800799024|56012099006|11063799006|22082099003|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info: 
	FcSCXlRldD6QeGLn2MONX8/Jt3QNMstLOSjFLQbfmXl7YHRQZGmlB5PTDrUJSgrN6RaMnYUYe6qkRYpR3UV0kRJrNCtmn+WZzGXtepMDhr+SAAv/ajkrh33JmTy94Vx4t2jdwu3wlBk+vgxHq3OUbLTLf+wg4z6K6v/CrTtUbzPcWbY5Nibx5iWUeyZjjISn3zV3NhepywYq2HUjlx3KtA9Vsyqs4f+Os4duWDdqJe31yFjIkoUEwyJ8qqtPPnejj5s58cOhYNAmuXmqe1uN+Aayoi+SNVBHMOHM/VBKCs8NeUtO+UzVdkFGMCWBLdE6/UnzGcXukY44py0YbSWsDOy4yK2D/VkkpM26xhu+jJjtOHs15cYqkIYCST/XKH4pfkX8/G2PN1BLZXm4DjqItcrJWOpY+oiTKV4qj+2UCoWqeGZUoipwWiAG2bD8iC4+CpciGyzQq2o7YH+RzkszRo+YujbbhCcbHw9bVk9YwWNc4CzH4XoV36C7TYKvKlqtILM2y+cqByQAeOBYa97fEWjn3wa4QupiXXYD0mxXu5ZFToChdJdLhxSrXMyO4xtxVKFXugmbOuyDCJ0bfG5LGbvd0Fc6V0rX+76zGoFNdK4hzCz6KJLbzn0TpR5xX4AruIQCxtwmBzcFme0+gLZlu+69VsZqVXpyCxVpssbbOWqVOTcHehWD4ELr49zcOvkkW8FnjcG7zWEVS0farSBrhw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(52116014)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(38350700014)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ErIWrNAJD6EmU3ZLgr7n6npa0yQBNIHwKPZZbAvIm7Fbv3P+2UnEJOF5JJJW?=
 =?us-ascii?Q?tBY1O5ZudhPZ3l1XMgX866w1joG3KW3aAQGi/V8ixR6jPIDABQjSx6WnK63R?=
 =?us-ascii?Q?m3CPBgIee50yxYaRTDmMZ5MNgT6NNytGyfbI8JMvgY1/TvkhT4vDSxF3BICO?=
 =?us-ascii?Q?xn/e1JLFiS2LwxwtowCXUu1Q9OXE0+8zf2qRpKrf2E8tXPUl/KNB3xe+tffa?=
 =?us-ascii?Q?drEfIUEVkrwQ2Xbr1gf9cb8XzEga6DEaUnFyZVVGCQNeis56VA8bX5y7V+UF?=
 =?us-ascii?Q?UNpb79kSk5ZJUje91NlZIFKm6PGJPYiML5KnfNDs9plWQ4Lgt4C3PErtUvjz?=
 =?us-ascii?Q?q1ecob4cAQ17s6U7MEg9cwSAcISCYqW1ZJ+/JBuvGLYICgqWBDrSHBieZlBv?=
 =?us-ascii?Q?kOkbL/a7m2gU8B2qFpKhAEAC1R0spGzZhOapzOGq5SKlm93aPu8vxH4BMOfz?=
 =?us-ascii?Q?iNnNOBUq7CowajICoeAJHS7QTkc8BFzoX7nSt11xZw3JvmzRnQNvik2UhkZu?=
 =?us-ascii?Q?5RWTzp1eWPFR6NF+lGY5Z7dV/dDyECjnyWzdNztn5l/05Bz0fy9c5q53A+T6?=
 =?us-ascii?Q?ysWCXZ9abS9sLFyQFsE2mv507r8EDdkjwTa/HNtcdk9kgqsESCBMDxzv3sNn?=
 =?us-ascii?Q?H/xHrAcD1yhfDx/SREcqvOBJ89NSCpHy5oy8QOKFCN6uxKrwsM+PoSkVazEB?=
 =?us-ascii?Q?Za5HT16sAB4mFXMA9cenJwV6/LEzyk98OcUEpV8iQ+y48Mk3mPG9Vb+zxWn/?=
 =?us-ascii?Q?f/tYjIaGEY5NBn4vCkVWcGqjbtGUWiowUMfL2ZJe9z27+2YcbDB9Sh7gD7Fm?=
 =?us-ascii?Q?gQC/jJRXgxCl0SZVY0iwbXzTzAWSmQ/jkS0JWszmL7d4Nnfdt2sn3lD98LWu?=
 =?us-ascii?Q?qsBe0A2dhMIrDd0CjugtP7fODAmbapkOODVPwiBOnmBiCGy5UIa6+agTUWP+?=
 =?us-ascii?Q?foUE1ubL4O0xrDR2f88UAE3mE9LDhMQir6t2JA9GIAhhxget35nrqTPh0Ghu?=
 =?us-ascii?Q?GoIwa4PCAmwI0bm8SsIBzwzcF3BDhjjdnliFeMu+YXbHznAwgpFcuMvfvkPy?=
 =?us-ascii?Q?3wIABP+tthtjZhxEtV8MPMz/17NhmBfYP0ZihqOalrwtenhkRaN79QcdzNbs?=
 =?us-ascii?Q?MJl46C3NAB3NpYwIe6BBh41UjlmoBxRzMxsAwpdI0JGg/k+4PGt/3Oz5Hg+G?=
 =?us-ascii?Q?uiev7GtixGaPQ3c+hBm+m+rvgwJaaPJCJv+8/moflxyJVbmZh2yaQEbjr4Bz?=
 =?us-ascii?Q?KeKSZim+lZZWz0pmAoDrsVTCXRfTpOgNLfPmqvLk2h7roR1XzJykuu7FgmSV?=
 =?us-ascii?Q?9rUUYuaEI8TL5JOgE/Por6Q2MRo3NuoERa57BEy5YNyGUXyBeuWeZX6nISm4?=
 =?us-ascii?Q?u/8i7GERLZ91EmeVwKNkQw9bwN7aFUf12trW4ujcjR1G0BNvhkgXV+pmbxbb?=
 =?us-ascii?Q?l4njxo+YtBliYCq7B0HgYcmrWk2+pMNisLlzMExc9Tq9Iep0Oe+RrvtSbOUD?=
 =?us-ascii?Q?Pl0Zp8rzO4BW1dW/FH4Vqt3Ej4SiSmW8GCWA6VKKEH4A+Oso+IRG42PLmbg9?=
 =?us-ascii?Q?uB8xcXLS/9EHFQ4INEo4YxhffFSBpzI68AjRNV3lG58tUSNW+d4un00CF+Ny?=
 =?us-ascii?Q?8TI5qIBCvyA1QhIpBDmC/loHGwS10infHIZ1+fJ5cgkWy8/Ed1LtMt1L8tsH?=
 =?us-ascii?Q?KE+TPY6P+htKq7EuslMXYfR+188jUolJV8DcxSzgj1G2K5NwvCkLT3mKOsWo?=
 =?us-ascii?Q?+HV1DDTApE3zS6oesSCJCYItEuVPdx6kkVblx7RdHrPrhuZei4Am?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fb3d4a-83db-4b78-ee39-08decc4b701b
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:35:50.9459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMvJF8wHrhAZMtth/k2XWVYvYQezaDMcRfcjehE/dhc+6ZjChqUqS9NJLxoHTOvK5zzcqJCCFxfNC1V6jd9mRS2A+ep4f+lbu+HGl/AsUoxkIOUr5Kfx0TlD2oYuoh16
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13245
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:35:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23201

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit 9e4830b35dc0d522f45e1ec3ee5b1ff1648afe1b upstream.

A call to spi_finalize_current_transfer() is only needed when the SPI
transfer is completed outside of the current context, when the
.transfer_one() implementation returns > 0.

Since the SPI transfer is completed in the current context, and we
return 0 from .transfer_one(), the SPI core assumes that the transfer
has completed and it does not wait for the completion variable that
would be set by a call to spi_finalize_current_transfer().

Remove the call to spi_finalize_current_transfer().

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251201134229.600817-3-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 8cffc9cb6b6b..beea4fb83d10 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -250,8 +250,6 @@ static int rzv2h_rspi_transfer_one(struct spi_controlle=
r *controller,
 	if (ret)
 		transfer->error =3D SPI_TRANS_FAIL_IO;
=20
-	spi_finalize_current_transfer(controller);
-
 	return ret;
 }
=20
--=20
2.54.0


