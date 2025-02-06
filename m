Return-Path: <michael.adler@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4108CC02194
	for <webhook@archiver.kernel.org>; Thu,  6 Feb 2025 12:57:45 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.44])
 by mx.groups.io with SMTP id smtpd.web10.40015.1738846655605822346
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Feb 2025 04:57:36 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=QlTPrTJk;
 spf=pass (domain: siemens.com, ip: 40.107.21.44, mailfrom: michael.adler@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qN4z4Ej3nGV67RN6x3TLdlH1k84Ootq3l5i8GNEQRtL/B4U0xkHfyEKfO8uQ0s27DyFZyo5j6v0C7j/uQvgOgehnoILOnVsCN16Pv3M1Tnc+C+wTKngBkY/ZnjLHpNE3u4aPTnPOZpcQv56Pzfr98ZqXpgk16V07B4mEWAvJlyzk52UKWE2OPdZ2IfBZqO+07nKJ/ELrsvjG7/isJq7D6T/QGGodAMeNjbuTC4PNtGYoFA6cYAktPW4noUXERGDrIHpO1tJzPSe6pc/w8Fw94WGLRAlJ5U/h8rPqOFXua5uA0ICk9DJwkVrQZB+yL9QCRPmPn32AOfpK4T8Ld/E/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lICbYfIxV82ZJZSgOIflkrH5pQaZzGWObkGx0cMznoY=;
 b=V06qGD07uCSZUxaBMYO2gjj1Xl5JYViBiVcivyKT1pMWkY/y2PDCCjrjkclyfjX/+Gzlt9Ai/M4dmiWFRbrMTzlbHMydW8M0SV4axETgrowK2Cuqzzcxdk635oPiLUQYKqIGeKwOZfhIck1sm9jBY9+b5SQDp579ZWX9ErpVa/436SNixvWfI7Ywp9nKvGFZJNWBP6iXSvGBHNNdnZpd1KAEffAKFiyJ5qREzSKql5YpCQsd7i9Bt/R1tC+UtkjRi/PnbvtJuPF3IwGovO0USSa8GT1Bld9cTVI81OeQvx6j200TFeS9J7WbD6e+Ctz/2bk/FnKJKvnWX8ZX9UG31Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lICbYfIxV82ZJZSgOIflkrH5pQaZzGWObkGx0cMznoY=;
 b=QlTPrTJkAgC6hwGnO7uADD7LNdKquTOC6ZfaX8oClNBCTUcn2f+Pbz8zI+JuRQk/D6j8xhBeR5XwajnCQb9UT0U1qA2E7J7vmaDnwbR0U0BuN4YdPbBhTa2g9q3//pnksB9QaauO2iO/rIcVCVcjQ865sqiNcEn7yPYibxxamkAlPeUyMtwX3a9VQKesu228I8CvLj6WkRuIEKF+k8oU5kFqLVEmklqPW3i1ntnwGEGYUGGdnM6xk1RIv/4sg2tC5GyxKoOmGFlRf/fK5aft/bbaeUAkyVwRQOWzITVxSnjpI6u5aYa/7V+Mfzc0u0LlgFh4LT3DAYQcMIPo7GovBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA1PR10MB8931.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:443::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 12:57:32 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7499:8576:c129:4b89]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7499:8576:c129:4b89%5]) with mapi id 15.20.8422.011; Thu, 6 Feb 2025
 12:57:32 +0000
From: Michael Adler <michael.adler@siemens.com>
To: cip-dev@lists.cip-project.org
CC: Michael Adler <michael.adler@siemens.com>
Subject: [PATCH] ci: update kas-isar from 4.5 o 4.7
Date: Thu,  6 Feb 2025 13:56:50 +0100
Message-ID: <20250206125650.164733-1-michael.adler@siemens.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::17) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4734:EE_|PA1PR10MB8931:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed4896a-bf52-4f0e-9bc4-08dd46add1a8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+3OUWjmlDXgwwErSBKrLDM3un57LHq1/DNQF6P3e5ekgzNWlTl4uq8jwObPO?=
 =?us-ascii?Q?OG4q3EG+sETAtoXpHlyCeQSNmg+todO3Sq9H5ifojKp8A8XmqLTFmNj58X1/?=
 =?us-ascii?Q?v6T+D93Gqhex1U9TGUsScaNYC2ycKkz9YJNk+C6GzDg/8yOAkMff++KoG2Vr?=
 =?us-ascii?Q?bTFXEtHgWhxyn87JsCBF9KvmUiPJ+jxk7bMmIB/eZ5SBrwrlL/rxut2pwU8j?=
 =?us-ascii?Q?lHdf58dHTkOPVyI4pTS9EV7SLhVrxNYxivWQHjqGzXW5oxNUPJFiTuYYC6Dc?=
 =?us-ascii?Q?YjNzqtMOK5KIpSEoQI1Aw55o+QvFyEF5RUeiYfNIa3OpjTSRAUZrnA0Yyn5k?=
 =?us-ascii?Q?jI0ljXheM+NQA5jW6LFw34wm4JWa+NhVhPxIIeQigDfZ+TtFAd5rT+bS5Ucw?=
 =?us-ascii?Q?u9Fyc/5j+oXaeg9Ai7WlPg0PEFkKtLOHidEzIwIV71IJ4Z5MsX1WM2hI4Rq2?=
 =?us-ascii?Q?bhN/ENKj9VEqnCZf1jq8Ryl8iZW5PdsAMLCtu6BYr5HrVY0/0JuXpGE6tCuV?=
 =?us-ascii?Q?ZplHMXdLf1a+9ck4ZFK3s96+HSqRrZX9ZYedOM8qgLD+VlFTD5B0fVmkhK9x?=
 =?us-ascii?Q?aUILWZSAr/btT7PvrU4VRgW0n1eIu+3lPt74VSrlPoA01LvbNHlQm7tNF3R0?=
 =?us-ascii?Q?xuJZTkLZOrOlsmLzTdA4zdCijg8ydA8D9fe78wFe3P3xnm9TSYYVGs2joIEf?=
 =?us-ascii?Q?UnaCQKyaH+sNN3j767J+M39/5e7YKkKgL48n/Cw5VkpIxW664ZNbvnpfggq8?=
 =?us-ascii?Q?i+hZP5MYw/aMj1NRannpsinMtHRXkdZ3RtZPwKCGU+mRiLNgCBaTL7+i1YAF?=
 =?us-ascii?Q?51SxgVb4GX2+MCO+oZHG5DAnREO4a5mnzna9B+pcN82HwBWVh13Lvw7FUtEO?=
 =?us-ascii?Q?r4QlDomIMuqKVQ9cKiC22hdJn8/+GjeZdlCu4PiH3e+/47dYvmWocJ3tO9pE?=
 =?us-ascii?Q?iPmLUyNiXllE2OhstTp60Tt44eo1/hrembeScmPia3RseOb5RAgJAEHVpZfe?=
 =?us-ascii?Q?yB7nwlprsc5jGcWAHXi35QDwEHmbA9hUGh2LDzZPTbTOVb7gvFTgAg+Y6Y0Y?=
 =?us-ascii?Q?838Bi9m5lvVWa+tfkZ3b0ZKisFHSVsBbaRtJ72CshLHIn5jtpk4yXjj5Nq/W?=
 =?us-ascii?Q?KU/YkRSC66Fzsvi2SFrMETi/fYri1sY4pMZuLj+s46DBeKwF2dMZGr7iQDuI?=
 =?us-ascii?Q?N/1wtWUpXehbWhQoWUR8jFgh9iowuDiI/oj/g2/+gsPkqbx55lrceduKt6z3?=
 =?us-ascii?Q?e9uo0YcsXov8v/Dlqo29x79QY4MuUiq2hq1ZUCXBElr88qQ7PtrCgfMfyV4F?=
 =?us-ascii?Q?nSrQsGfkPRU83Z+iIHtKAO02XiYFP+AiRiILzEi8DP9BzA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6GXIwQUC5ffeVpE781qjx2GzODnsw5p4Dpm7F721gT1m8lhP1CqTCa/41LpP?=
 =?us-ascii?Q?J7487PW9gL8uym/9wG07KhNGZNX4GvbrfuUIYqKV00A4HJEuiWaI9CzC5Jp8?=
 =?us-ascii?Q?oAQoa5opuTRPrE4DXRRuSPDNajbj+8F48MxabnY+6OYwu53fPLMa+VQ+ZUw3?=
 =?us-ascii?Q?s5m3pCrwAvAH4VFEP7dq3pNBthrBQmhSvMvp/BGC/V7s/Bq6uNdGxXx7G1qb?=
 =?us-ascii?Q?TXx+IapC0AOc7/viJw8yUwv3ojt2ZK+zIT3Y+wQQOxX/DFXCERfgNaihr/Lc?=
 =?us-ascii?Q?pc9REI7v6YM9hCDHvKj3qnyZtvtt0fZ+pT7aB4zhI/8kNBKVrKVQhpG9xyhl?=
 =?us-ascii?Q?eSq1CVxyLzLqJA/2tbaatMHERJwgtjkLdJHosQyqwRlpusDracgPA1Nlb1ya?=
 =?us-ascii?Q?4W5hTgi3VvepzgB7i+HNBO9X/8KfCAKP5JMQwkwB/np/cTeZJu8pPLsTTK5O?=
 =?us-ascii?Q?hlbs0lhQugX9gQ6lr5icbQtaVc3nOQzOx8iSbuIfZu0ElA5jYfB45B0d0xcY?=
 =?us-ascii?Q?51S8o0vbNO663S1PAsjGAlRI5OQ6Gz8yJgyfFb+A7mtBdd8n6ezFEj82vUXc?=
 =?us-ascii?Q?/GUxNqEgxJjWzPnMVDv5uOotBRNwBcDrlIDMmA5xfVvHoXeTyOr7ot8wAOvF?=
 =?us-ascii?Q?fXX93tcqAlW3Rnkz2aQTupA07sKTMY4Ehn+ZbKWqp1AyFZOVnWN4NjZkm4Dr?=
 =?us-ascii?Q?B68QUJQ00L65967uoToqygTvFrvDKHMh3HUd/qtbmRLxR0CVNEgs3Ax5KPE1?=
 =?us-ascii?Q?HuQFMaZ2Q2eCaMf2phsCgCmLLLLchXwOVylnyy1aAyNeWhxcXDzHUCVEo7hG?=
 =?us-ascii?Q?F4yXbRvkg4ToDFNKs10ofO/Xbr0LBgGO8+IntLGEr8G5/HfckMptWd2n08nY?=
 =?us-ascii?Q?Yn4vVxsr7wOZXjZvezUZ4lfxv/TPMx5eyXRpd1+57+S+4SCJx3ULllKjPN9H?=
 =?us-ascii?Q?Vggp/V7+Fa86mysv4gxDFbNnAezlzHUprn/hCNJNvAX8Y6YG9u+mUlyPopM5?=
 =?us-ascii?Q?bJFURasah8OyOcNm0qGaKkEBYd879K19VQff+dY5CZUD6+7BkKBFjVyj+ELx?=
 =?us-ascii?Q?+Ts6EpnPsL9r37CgyNVkN8QGs1wPW40L2sU1snCqxqzUx2ZFfKslHzXaBvG0?=
 =?us-ascii?Q?JuL5TyYWXwTHCTcyvBfrrd1A27u0y3WJDeEcBkxbgtt71Lfe7LhHQaXqLnSK?=
 =?us-ascii?Q?v1ZfBkeWpnrB80+vSp5Fh8v+wZcVp+Ty3oZAGISP4xrY2L2xV+A0AcBvWzvH?=
 =?us-ascii?Q?AL6RCC9iasZaCcPc6cBCrGkgawf8pfkD/a9MheLbg4XrmncCAQI5zXxVm6aq?=
 =?us-ascii?Q?rMvKcBw9jLLVmD/ejbpeuouKTb9Qkv1yB7KDs8OBgJkVyP1zP97VA/0mMOwN?=
 =?us-ascii?Q?xjglGtpLxnXv5HFc2yAvkxa/lyo+P80z1ap1gLFWPBK7Bd3n3CNkEtYXDga+?=
 =?us-ascii?Q?eCbFUYCY6wGLKU3r57FgBCqnS0KQicpyf232+BdFsm1umJ1e2jNSX5vBONO5?=
 =?us-ascii?Q?RC9qCDtK4fy4ZHzdU8Eq2KGJAwAGKxMqAxJWA6PQpSEXPByLLFa9nQmlRmwG?=
 =?us-ascii?Q?y8aNhUGc6ZO8DePdfa9WiZG2NbTTbe2L9tB6eAibbfPNmYRAVO94ELCsGgyr?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed4896a-bf52-4f0e-9bc4-08dd46add1a8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 12:57:31.9871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DG7yzm9U9T/oKNavmF/9/eVi5ffnYNATLVQpAYq6cuERqx/fB4dlsp/UmYqZxcb0ikVusftkh29A+7XJKI7OlX4wcLiJ8FDLR/3wACL0nys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8931
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Feb 2025 12:57:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17759

Signed-off-by: Michael Adler <michael.adler@siemens.com>
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index d4bd283..62f6edd 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -12,7 +12,7 @@
 # SPDX-License-Identifier: MIT
 #
=20
-image: ghcr.io/siemens/kas/kas-isar:4.5
+image: ghcr.io/siemens/kas/kas-isar:4.7
=20
 variables:
   GIT_STRATEGY: clone
--=20
2.48.1


