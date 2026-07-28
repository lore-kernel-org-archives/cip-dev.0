Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0855C53219
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 13:13:00 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11067.1785244370667933537
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2026 06:12:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=lLpkQOc8;
 spf=pass (domain: siemens.com, ip: 40.107.130.47, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQvAHIJfxcWpRlNpKc3dDfNsuqKCtDaqRmoW7Em1YFVkysoYpmRFBN08VbHkkGtuHWQdJPnzvvonKHisvtokZIAlA9b13Anm8F9x5JekWtmqqF4HggihQc7axm+Kxm1sfLkQT8hpBvUQIR8tgLFtotDO1T6g8aIina8uKogIJhwBkgaAI644rOK2+kkzsK7mNEsCkNikBjUH+2jBY+92ObwRJWOqOl2Oyh2h90IoNoLZyQCh379VaFvn/hwnpVHGtPu9eVHTWBm8jCWnPeDmmHqMqqtsTNnua2ZL0JtzTdhrFaKJhrn3NxiueWnjtQEtJackbeT4YvZFTbFEdzLyJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bazmkojm6ep0AxJXp2rmrjY2oPYabzq6B2LRUoEngAY=;
 b=jQ76cHhO93qzVowzO5g2oPwpPSgEgMsxOxsXhcZayEpIy+G/wD/vwP3xxkjmv/IXBxOOKHVZOhDzXj4TP4GFjpHBaveN5oJa2smWWK1r8SNzvvVs0C66PVlXPrdf7c9SUqnhxwNfX3xHSPQxiGaJ06Cqe2vxuJLTdDgWPpWv8mmFlckJxMSQz49Td22DvCcKzcDEd+bRwueIkSXDC2BTMGy8k1YzDtZKGOU7QFedQ3pJkBxC+VV5K6SFy5A9B6JjMQMgU84/w496rE8VeBmdzNquKssEdsbYZsEMlJWgb41H66rqe8QxPF+V9mWqThus72ikw0yUgqmhtRrByNe35g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bazmkojm6ep0AxJXp2rmrjY2oPYabzq6B2LRUoEngAY=;
 b=lLpkQOc8DSJEMDPhvSVnQLmQz0qc0QJGqXLjjqvq8UYEAGpsaghZhYrajFyiWmo5Z9Or8gTQBru0ygPErPNPC5nu1CjIK8oEMMQIvEcBRwxUcb7W5gLZsf65iQoiUT3gAu5n48wp0SrHwYvKvQ7V3++VlEVxBQEkszQ2UAVshNVqZl3B4Hinf6e/jHFDPgcgCZripBzt90xRRd4bXnSNZ5g0QnTOM793iFUZasfeWffx/VGqmt74Jk9fDSnxFSYqF3WQowoHKtfdR1M3Pbr9RDMWq6PVLB0ZzzWNx9uvZnaw28zRg9Joa7P4uAl8EQ9I0m6izpK/G8pxJzQbQuz0Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DU0PR10MB6083.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 13:12:50 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 13:12:50 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 4/5] switch to isar-rootless
Date: Tue, 28 Jul 2026 15:12:18 +0200
Message-ID: <20260728131231.117214-5-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728131231.117214-1-quirin.gylstorff@siemens.com>
References: <20260728131231.117214-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::9) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DU0PR10MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: be1e715a-e369-4b2a-8494-08deeca9ec92
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|11063799006|56012099006|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	d1GCL3vdmlE90odTGYsa2+Ba3LDc36A1TqId5tbj5NyilA20F3AbtSiLmPf9KtmWx39xPwkNWR3xPtN76Jm9anjG6P8JXI7vOuUTYzQKh9mK8TEX0n+AXy2lJDEJPazBwzKsIBIjg5xQuccVWarsgewHTy5DQxndOqyMkyWOTs1wSSYCM4tQWD7xT1X3BhwKK+roTmCjlSYS2feZlLmTEObG3XzUDMCteR0reiQqoYTtZT5AcPQEavYguYpOeswOFiWaG80uDBMJNjXkCtKCx57cGaaaf1lI1aQ1KvQpVyYS3HyYsGnTc8QyF1OdtbtB/a2c57QCaPe48P7w+vpXgV9grPk7Of1Zz8EkRvfGm3ZR2mDKws+srGkIclzlttxrc8XvTgSa4BiVb+t95z+gUX8ibllBxIbGH/ZplvJM5vDmVla+4k3gx1BaoDfqf/06zJWjZ0ftyHHUUPES7QfBv0aAlqyd5czmv5mEq3PtMD7qx7W05H3xoh5Zt1fnZPlLooZRUg9YWx1x36qqN7tUOiAJCLo/Ba7LpOcK/QJAFmuwJ00cZHuC6VsP3uyYrSBswKFvHpuSiMZ4d1pMEbAWqPj+5GSOKCHTkWSNXGDSXLAD0+ZYCMf2kH1dCzIT30N2X22BPoUUzVfuz5q4e8rXR5DFWyXe3boki4C2VYstLXw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?43ZsQshNZT4MkUJ+YprvJQ35xDeMwBMCdhUokvZMoW/rBWlSPWgmh7x3WBet?=
 =?us-ascii?Q?jYCbxcwCHi22fcPDcHGDwEsDoLPjv7DUBKSVsNsY0YwfII9kpS3eDvbQzPk/?=
 =?us-ascii?Q?siWiPel33ZMgPLrvHZGNNRixVelISGCcFhzo4+hDTMU18iKVJj7EgGVVWcF0?=
 =?us-ascii?Q?uLGbPBN71uErxtwuAAwwuJsIoYQ47Kvox4M9DnV+nyHt5dFlEzVpyHnPoBuW?=
 =?us-ascii?Q?2B/7GItC3d4XtvSLfnGcL8Uqlii0wsnJqjqKLLuvOo9u0yoeg/EPL3PprmLA?=
 =?us-ascii?Q?6uMc9Gil9+ToYD9TxG7CqoD+HyaPCgvV0iD7qbRIPAG3Fgq94ctmDnPm9qsC?=
 =?us-ascii?Q?DlyPsPk/gfyaRrfRm9SI4qxPdh8Ha3HDueI4pYkG+NeiXMTAsrs/zcDE1KCr?=
 =?us-ascii?Q?+FS5bDuC19PtuxU2Hz7CfdSg3V0kyMq0bxlrOvac+H4at0HbfUP6XMoLwwO8?=
 =?us-ascii?Q?7ETaXdIPnfrBCPxZ/pCgu1+u7Fzxx1tnUqdXFR9W9NPGC5pol6vIsU5FcLd8?=
 =?us-ascii?Q?MuplmZgdWGEFBP21f2MaZlt4plSdkRpcJDZwjppSn/4lXpCKJKt+LpzJ+f+Y?=
 =?us-ascii?Q?wFHmNBRwdc3Lf+GjXNnN1PtYwKn4kX+Pz1ikjJ8yNllUg5WhNQO3VXav8o0y?=
 =?us-ascii?Q?uaKqf/UVnvxHnAIt78TkymoiFj7tnw5SWN2jjBV8ZF0aLzB8Njho+G07YByZ?=
 =?us-ascii?Q?FstsUGMSW5PuwyYG1wHNKnCtSWa0gOXIMDF5COxsBcQ1cLfavLPDZMHDa6J8?=
 =?us-ascii?Q?BjcaRLrNsMe+tyhJZ6MdNVZeHcscomoJpepOdNW1931EAkqA5BpThuy1iK+y?=
 =?us-ascii?Q?Zpjb+JN7EgBFfqosfGqHeO8dKOuWi1LjbLxsaSDEQYXww7K15bLJWbjIthXC?=
 =?us-ascii?Q?Ev8NGXTikkVrBlURzL/YZe/qYzcOX+KdnLJw3k9AEzl5G/Sx2q7UMzb1926N?=
 =?us-ascii?Q?FmxL05Zlt7RnYHfSFZBIBQ17Y6oRXthZNDpFutIfEK4iiJnxFEtciTcSynJ3?=
 =?us-ascii?Q?l1uHUsSVAnlgAFhWcNIE1BmHh8nmJRVTWngg6ZOVT+/qxugLovo6FPVo0b3Q?=
 =?us-ascii?Q?sCprTPc0qbQmDJLU60JQ+FWaxSEH1Zbld+Gj2tSLUDbKhZhwYVeWep4o3zpo?=
 =?us-ascii?Q?LjBM1olYicTxKps+P+Yrf1sdfMjb5FYYOcpU/mhmZAvZ3l4jYH7zBvESlI00?=
 =?us-ascii?Q?b65s0Bll/wXlGkGcoodQFI2n9uoaFokCGzSqoV3+vpvkalrNdFmwUzhFJYra?=
 =?us-ascii?Q?Z6YJIpw8wwJk1I9eDf9KXN4rsRbR93u+UjCzXOBcVqfXn3PWM6e8whxKE0rM?=
 =?us-ascii?Q?u+F+4rCXrRYXvxl2m+IkLrFdg0X384kkYQKhr+mJfzXcnQMOf4plP6vnI+PH?=
 =?us-ascii?Q?gHjefg5xnMx+glGgDh+9G2vkLcbedt8qA025xc6pP4FpuogJPysk7XnHjQRU?=
 =?us-ascii?Q?BWme9jF8ATSAAfXVP7d7zl4+ieCT63snWXerJB8IWjtk1pM7yUz0HfwOKYRR?=
 =?us-ascii?Q?K/C+CUAzAqdkDVSuqUM63YMmrmfvLjiTesUSzGdbs9BmTV4o65BhVoes4owj?=
 =?us-ascii?Q?C4MDp6TjF4F2OpmmwAVgn0Vqk61DGoJvGrbPdue7WDmKe2NIzyf8WPpLapqu?=
 =?us-ascii?Q?+em31t5p+loUBZbrZLGaBctyKA7QV32wWuts3uLLWTMi87kutDOv+fhDdgxe?=
 =?us-ascii?Q?Sy8OhhaI6ZAp27YZ1Y6hTrbs48ZXP3WI0H6/4T68A0WQyWKxr1lXKsDlbSn6?=
 =?us-ascii?Q?8rUgCM5pFYtdEcwpMAXbossXukoLKZ8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1e715a-e369-4b2a-8494-08deeca9ec92
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 13:12:49.8882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqajr/DVUotQxaFCSjTRiauUA9mc7SU5jJ/uPAu4KlokTswV+pSlXz5tkGiXtqpz2GrH0lZMOzElSpi7w32sJdfzGL0seIbbwXruZg2NMgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6083
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jul 2026 13:13:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23802

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .reproducible-check-ci.yml | 3 +--
 Kconfig                    | 2 +-
 kas-cip.yml                | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index fb24188..4f11b7d 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -37,8 +37,7 @@
     # Deploy .wic, .swu and wic partitions for build1
     - deploy_rb_artifacts build1
     # clean
-    - sudo rm -rf build/tmp
-    - sudo rm -rf build/sstate-cache
+    - kas purge --isar-rootless ${base_yaml}
     # Build 2nd time
     - !reference [.build_base, script]
     # Deploy .wic, .swu and wic partitions for build2
diff --git a/Kconfig b/Kconfig
index 5003bed..abf9aaf 100644
--- a/Kconfig
+++ b/Kconfig
@@ -17,7 +17,7 @@ config KAS_INCLUDE_MAIN
=20
 config KAS_BUILD_SYSTEM
 	string
-	default "isar-privileged"
+	default "isar-rootless"
=20
 config ARCH_AMD64
 	bool
diff --git a/kas-cip.yml b/kas-cip.yml
index cbccf63..eb26716 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -15,7 +15,7 @@ header:
 distro: cip-core-trixie
 target: cip-core-image
=20
-build_system: isar-privileged
+build_system: isar-rootless
=20
 repos:
   cip-core:
--=20
2.53.0


