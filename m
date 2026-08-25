Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6433C61DBE
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 14:38:17 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.59])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23566.1787668694022419751
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2026 07:38:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=UO+aZi74;
 spf=pass (domain: siemens.com, ip: 52.101.83.59, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsIH/CawZcrIxIfVG6PysWOXuF9RJKvaQAh83idWviQZhSmI7c2xyA9Vq8WzOicBZ505Wud+f3OWW9OGFW4AmjPJqE0yuNgFqqa7EXQ1396Z4LqFGQN7p4PvFJotvRZFxPwPc4/CwXxPMagDjzCmShrLQ+1eEtZnCoAP2JLmItezLszF78FrPmuz0JjxUCi1JA+uQ5o9Z2fQClFXjWsicrqZjOaeWvMH1fjpC33GQKJpu0/OMfnCE9z9YxytX+J4FUXf/AMhgWarvCOaIE8KYYJZHOJ57rpRki4r8ajZM57xHoHvUF59PtJSuuAK9DuVHoM2O4MAVQtcoka2Tkr4Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyKr/y0jnwv1TvvsVQ8ZxAJckGobhFz6e5hywphwh3Y=;
 b=FS6SQ4HDg9LP6oK+rAz4gYs1sStEXFYCLOka6PT5KOkxzGDTTWiWquJdmOethDP+Gv9DYNuRJXIxlGS3AfMPO+5yAID1WuESfNlFMnJA4vx8/+35aFy21mF7iyW1JddBzg3IptbEN2m+4TqvwAYPbZriugmkRYWV8UcBHodcCMVrhioSOZdo4iApKtyssWq82Ot2nxtNFy36DhAQp45uTGNGqX3dOrd7+kCCtX9noCUcaWDHgObClv0Bp03jPUfVY2tpM6hQt9nFZxUyUoQamEnA5dETogFrDbQ0I6+T5gDr6YLcMpnfBOiWK3ftIOR+wqpbNZfnCwlBvSIvDaO6IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyKr/y0jnwv1TvvsVQ8ZxAJckGobhFz6e5hywphwh3Y=;
 b=UO+aZi74d57K6h1+EEFp94ppwUsCr6Z+p91tFvDhrA6T5M0EbkSYu7valN/BUGZ4uO7POp8fM0eJ7bepmt9lbj6L8iXyOD2OM1nvcblEPsDchupQPRBb9dI+91Pz8yWaTHSm9uIpdkI++ymTpiZqsUwbOJa62huazQ6u316xTc9RaLR1YYHVhXIN5iAqyv8tC7EkPreqq11iDMiG0YhvNRvAzqrCPEg12qqLzUWmSAkAOBLBWkMCjgsNzHMy8VjmjHiAhEY2eW2oXzgKrLLuBLIrl63uu26VdPVLx1UoGRwrb6WA6cdjFv7evH+Eyx+3C8pLaZdBw03QfFGx2eZ0VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PAWPR10MB7126.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 14:38:08 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 14:38:08 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	alexander.heinisch@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 0/2] Add option to clear partition before new fs
Date: Tue, 25 Aug 2026 16:37:46 +0200
Message-ID: <20260825143802.3764929-1-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0081.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::14) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PAWPR10MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: c396b30a-1c40-4484-94c3-08df02b67b59
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	OuvKJE1Z8fGSVvVPxogkMDfQHBHG6HO4XOQUvb5xpPPfti+EpE4svHBLRPDw02YKKkzSG07A94k3608pb/FXqkO0V94U3sZ0290/higdBYPKpQNGGielYo4+J8x0X68sWOiNGpyghisuc8CIZ53xgDi5qeulo/2yaUG5TPZHDOBfsRmdgxYKQAU+Co+70GXATqTv9E+Y2AhuvilAnzYECBed3GFk7Mj4sHJmIqOEVD+xf36VeTki8YsvR/pIejwYu0fpY72n1endJEeCeUVrXhmhH1C5wSSn8rlIjSTiy/wjrPCG1e/wdunG/kBMab2y7nRcz7+O+fODr8gmg6IMYyqU9A9DTHokkxup851Paglg9YfU3T1pGwEkUvA2A3brk3FRzmaWxca91WsuvJeNLIHkWpi4N9cOvtQwmanYk+gpneHJP6KcfrlPpcJ9r0SIyvFCM9ir1N+YRsHTIV4E9174NK789FKxVVeoXV08uTF8QWueCJhlTNCPlpbpqEsFg4JM13xBtdALtpgeRD8W1BJRR0WWQhC6JyblLRxi0Eio6qqH1wgiNuGF+i3P4XQb3gqMy4mmq1VDXf1CzlGhGRz/QThoMO8X1JyQOEJMR03aG+y9lhXterWFyKcTQfJep1m5KtEQdGA2P3njm0g9ngwI63ivMGU4SFSjB++v0C0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Ltv6vrwv7I5tsBwSMN4ljm5Deec8YST9MADiMM0TCeP7hXGLnO/zcwA9sNEn?=
 =?us-ascii?Q?4gWWUMOwyGisrN/3BvWePMxU5kOeo5YkyHfVMLob4g56mcf1UmUAy8eN+1GM?=
 =?us-ascii?Q?SJimzfn/ln+7f7aD1oKJJCOqKCAbNZWh5DAwF2uj0Wtc6ZjbisHG2XCktxZx?=
 =?us-ascii?Q?OTeNPvper3lrEL4mgffJDZUgy94KzGIsGV+EAOqzxC2skLiha8MkXmUnGOiJ?=
 =?us-ascii?Q?h5h8ebzI5W0dQPIUx6grLjmDnAWGUjMrhhlkEeBQAQAFnG6/CXtAG5vA8Our?=
 =?us-ascii?Q?fJM5NCBSdWpTEhe857Xlab9I0n4RivsQUkV6Bax0S/DFv+GRGfHss08Tg+L2?=
 =?us-ascii?Q?v/lefC3HaZ2SqtXY6syXU7rQqtnmx38QJCHYaKkwbQZrp6NXsOHGnQMvqKGB?=
 =?us-ascii?Q?dnxqf8l7QnmxEl7slcRT9Ofov/psJnMnqx7+Y1J5C9M8NoLPQMyxEp6qnL1b?=
 =?us-ascii?Q?NqugvTH/YP2L44EUqq6Go8GBziKDr30oKbEE/HkSL+6BzEwiHybdu/AV2Ind?=
 =?us-ascii?Q?3XlH8gFwfpBNlfIOa0Qg0I2dSmrGomnoc9BvG15BgntdQMVd//lX4b75+oq2?=
 =?us-ascii?Q?zM+XLicN8tfi1SSSK66q2coOFTNDGFHFE4kucgcvOhIc4QSfLx3onkxwzmHE?=
 =?us-ascii?Q?7KQwAscpSgfOWEcC3NG9/IB3mjz1Y6s8ygmNQ1WjqoJtTiMFx6m8K3hfItim?=
 =?us-ascii?Q?t1h6U8cnnKUpB5bK7Zc+Nec9FLzAK4C2uMbgjj15LjKxHkK0vIk/3U6VZiIw?=
 =?us-ascii?Q?SJqpl74dh/OWPYgJob1jTDD47U1JHMtrqIzu2AL02BtlE/MpKziLLiz6in+Q?=
 =?us-ascii?Q?pbLhjM1JLKNhiSoh94J5kx/dckKnRbTwZ11w9nIZXEYbojzKI/idtc2Fgcof?=
 =?us-ascii?Q?w28JStV5iMDJKrTbHWmePGdtvUbNEVCIU/JvanHooRR0bRDzA/JC1dU6/Ur8?=
 =?us-ascii?Q?QwN3RPDpotuhQWXX2dlQBWKqq8u/32HOydF3nHmUuEgo/CkNpqy7mpIYwa55?=
 =?us-ascii?Q?x0BnWmmvvLhsuLYVnbWaXbEDKyNvJVzFhDrNjCUA7XwM1ZbnWyJvG8wVU7pq?=
 =?us-ascii?Q?DpPsDfp34mwW5gmgnDIhMew0iplpB7OATmJvShUIdZ+uY0Wt1+7C/qX42aDO?=
 =?us-ascii?Q?uWMggzWKBWLyySP5jt8eILcj6cprR+1snbdu1fC4RjkNQYvVke/YoElGX2iY?=
 =?us-ascii?Q?BmE2zWGS2XTdtnlrvtzR2aR+LrtQqjrVHqVyeHdKFCcPa4Tv/xvyiSIvWOA7?=
 =?us-ascii?Q?SGNg2RsqXyeRgicG53ISHlFK5fKraOO6rJqO7d/p+wQNKS8UHQj+eHPsDPdG?=
 =?us-ascii?Q?EBiBe3qfcEm0g2khjAtvbvVHxtND2KLBbxAuOj+ydZWFzTlTn6b0CUgk1IWF?=
 =?us-ascii?Q?u2y3K27WiQQkTKMtPpN3VO9R+8HELV3u/m0vRoPc2bGePY+g97O3eMTIM5a1?=
 =?us-ascii?Q?/3zNMNM2CLX86QVZlyheEGfeJ5xTTZUIxxrUlPTVIcbC54obJfh8uxkh6alq?=
 =?us-ascii?Q?UO2XcVKlly5OVp6GosUbAxsmbvfAAoYZhsub0m3EuKtdoELkHgo48fxJfirt?=
 =?us-ascii?Q?BD4j7VEYXgdsbAzUIeK6N87QnKZ5XeZmtIBIdXNczZl9OF+R80lyvi81ivW/?=
 =?us-ascii?Q?dLxfSu7llf8KSPuFkr5iThMvdIi6KvscDxEh3wqace6QWdN3Bbt1EXLevsJa?=
 =?us-ascii?Q?B32aDbPWryNapSiJf6OIs8+0seG9igKkS6zdtNY/PkF7OzB4BhSi8SDSHsxs?=
 =?us-ascii?Q?9zxTLlJ98Wt8u0/J9alOXPUG9INpfZw=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c396b30a-1c40-4484-94c3-08df02b67b59
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 14:38:08.8454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myP61sTxNngPpeP4oe0wIbiqJkz7BJi47AANGAoHsyuRKENGhc/Y/YMBxYXnPVd+dZPnl61OWdaOaJdUCqDC/y7g8j5kn2rPaHHqAKHzN3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7126
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Aug 2026 14:38:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23998

This adds the option to clear (dd if=3D/dev/zero) the factory reset
partition before creating a new filesystem on it. This ensures that
no data is left on the partition after a factory reset.

To avoid unnecessary writes to the flash, this option is disabled by
default. It can be enabled by attaching `:clear` to the device string.

Quirin Gylstorff (2):
  initramfs-crypt-hook: Move service watchdog to cip functions
  initramfs-factory-reset: Add option to clear partition before new fs

 .../files/cip-initramfs-functions             | 43 +++++++++++-
 ..._0.1.bb =3D> initramfs-cip-functions_0.2.bb} |  0
 .../files/encrypt_partition.env.tmpl          |  2 +-
 .../files/local-top-complete                  | 23 +------
 ...k_0.11.bb =3D> initramfs-crypt-hook_0.12.bb} |  9 +--
 .../files/factory-reset-script.tmpl           | 69 +++++++++++++++----
 .../files/reset-env.tmpl                      |  2 +
 ...bb =3D> initramfs-factory-reset-hook_0.4.bb} | 21 +++---
 8 files changed, 119 insertions(+), 50 deletions(-)
 rename recipes-initramfs/initramfs-cip-functions/{initramfs-cip-functions_=
0.1.bb =3D> initramfs-cip-functions_0.2.bb} (100%)
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.11.b=
b =3D> initramfs-crypt-hook_0.12.bb} (95%)
 rename recipes-initramfs/initramfs-factory-reset-hook/{initramfs-factory-r=
eset-hook_0.3.bb =3D> initramfs-factory-reset-hook_0.4.bb} (73%)

--=20
2.55.0


