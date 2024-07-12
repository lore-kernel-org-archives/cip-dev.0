Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0882C3DA45
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 08:12:10 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.57])
 by mx.groups.io with SMTP id smtpd.web10.3116.1720771920681530655
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 01:12:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=DRp/JIND;
 spf=pass (domain: siemens.com, ip: 40.107.20.57, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwpUemaGGIXMCIA5VxUp97O92QmgyFCljACDkU6JRs+WJeZrQat5OGxjveaUDoFM2b7OCSc1IfPh6ErcxUmSfI+J2YLQGrfPvroLDdwelnmEBHHVzvGGTqnbzxvWgwL4h4RyWhBDfNqGBSNxeonuoMd7rPKuzFc2PqGxW/qqwdKeXPhOpqBacYssAwAtMmPbI7/6YL2lR6SNqCkZB0PsWsKiEewt5uhJlkRxMTQGWWQfc+yD8sgVeyCffZczJr1DmvByW5b6FM101UVX8J7dQEP3WZbb+OW7jUbQglqZur2Fwa1y+wxv2uE+BN3NLwdiMa9KiScnun8hGmDVGSsYCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDFKkQykj7N89n+n2HVmJjrDY62BxlYiTvEIbhe+Iv8=;
 b=nu7lu1soHco8UszAnzCSO9jbI7QiHWc1jr2LGlikEy0NnAAn0pCv5WTFlTW6ZLTEkOHmDPjfhO55dVzRxxpzEuIrxCGMqPM31i8HX7EHXjSdFatXOJPfaXTMrvbyuqfDq2IHx231idpOkQXfiMr73IgV79546U5mkuaM+yZ0qnFqI8LGJueN/WCBr04RZYkAJELe8XIPqmn+DuhfelJL+tAE+947/8gbYBsm+JLsXZDGt2goec7Fjq/DEnXSkHIqhQWb5ls/L2GO9xD3Iz2FNLOQSgRV1Gb8PBGwWQKEvYo3zbmVUMmpts53mcOI57h/iEnsRx379ikGoP+FFxaCDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDFKkQykj7N89n+n2HVmJjrDY62BxlYiTvEIbhe+Iv8=;
 b=DRp/JINDrWXYslLWKe/WQlDMFXkpGWfnTWjCkSYf8EMtHM+9YBydiojr8wiSTLXsZNpTdZLrrLoTXMfKXxWai+QkhqU8bDtwJ8u7ugU0W3I/5vaej0xCLj1+pLsGDf1Eypidjoii5EU5fkjLrdcjbqh6X4gqCyB1X+v2VkEW+NTQpEhWux2d8Q9vtWYKWIoM/RcIom+dEvwEkt8YVKPbAtli1aiZcJy2Vx4Yz1cE8geUrByJQEhFcVai5HOMFSjMLkIQlubjJ7hDIk6e3Q6DvMmH+AehyogTVO9K6p7OBUL3FKeplZOxl+ia6j0L2wSqueaUYca0KlLnzgWM+wAtXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by GVXPR10MB8316.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 08:11:56 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 08:11:56 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	christian.storm@siemens.com,
	michael.adler@siemens.com,
	simon.sudler@siemens.com,
	stefan-koch@siemens.com
Subject: [PATCH 4/4] initramfs-crypt-hook: Add missing mountpoint executable
Date: Fri, 12 Jul 2024 10:11:43 +0200
Message-ID: <20240712081143.1376952-5-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240712081143.1376952-1-stefan-koch@siemens.com>
References: <20240712081143.1376952-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|GVXPR10MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 9caa251a-3f1e-4ddd-cebc-08dca24a4be5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9d3YPHim4yzkAO52/LFszJxURYC/1mCWcIqb3QSWLMmmA9a695/wlN3QBoef?=
 =?us-ascii?Q?6tXb6h8pH+de1oJQr1PrhiS+xtnB69yZXObIrEUF3Gmy6oaooyXs4juWC9o/?=
 =?us-ascii?Q?+0CyOjOTAQ8IqwIOoDDjvTl48IfP6yZ2I2U5GX0c5B6Oy4lqVIJMS25IPidj?=
 =?us-ascii?Q?gZfMnAleqCVZ2jFRC4XPKBMnTEXtIUqtJnpa2qH6/XjfdgqAjQmfGfWOCq8D?=
 =?us-ascii?Q?ZvkLp+65UehQohliKoM3EJkLkxUioajGdDSAQAmebiB5BgW/S+vb8vzO7orG?=
 =?us-ascii?Q?Wg70NrGYt8ZvtXmvG3lrcEemDowJHOIm0FhLdc//uGszyqrfRH+d578iz/hv?=
 =?us-ascii?Q?k5qPSo5ylAUO/jJapZKM+zR0fXIUXkAMsxkDcD+8ojLZ4tqsgd+p+FJHYzEy?=
 =?us-ascii?Q?WBMFuSijzhv2PVhNkYV/eTNIgnSyoRMzYa+Kgv34OpDTYHPe0D0LGioDK3D8?=
 =?us-ascii?Q?liPO6tAwjUnZwf+CuAA05WUZHy1E0wFJqo4gge9k66k4PgKfASUAZAc/CDsI?=
 =?us-ascii?Q?pfCHlmQAuVvv7v4ACpXfSG1QOYJpFWPDa+ZSO8z4H23SUY8r2Cj2Fc49DJEN?=
 =?us-ascii?Q?6WgHk6jbku6FuVJofzYdrDiolQ5S9lD7e96lP7G9MEE+8T2ONbcopM7S/dg/?=
 =?us-ascii?Q?DYLsll4x3TH1dTJUkXA143KWwYxRjkwf8ceERnor7A0AYwRqqxtJ3w/1PDCK?=
 =?us-ascii?Q?eViMjT4FLmyp917EKmFoot1iM0ycOh41Wz2Ezc6GzIVfnIH+aF+EsBC08QBT?=
 =?us-ascii?Q?AH1UFrvYJACDivCkDfFc27+8L3hUjjyX1DMXdf4yS7HWzh3YLgTrvrHfCTHm?=
 =?us-ascii?Q?Pkis2rcc1MhwS+1ao4Z8ApC2Vfu52ZjxHYfiH2TO0qQO7lZ71ZsPIWY5SaTD?=
 =?us-ascii?Q?/IougUz0qytlrd3O0zsJK+H1DjWNV1XEJI/lGevLWkIIZoBj6hbrR6PYb+gG?=
 =?us-ascii?Q?WnEDxGkHy/4Ohxv/azOks3WXRlji6oMygW+E/L0i4DpFoDUE5u5BoeDYmUqU?=
 =?us-ascii?Q?gDkJtIVxXju967mTYa+pEBOAu/i+0Bhet49Gi0b95ow823CzX21HxDpjUBTi?=
 =?us-ascii?Q?KcS/TQv0BPnq3SidXIZbjOKI4ZkJWbGHiqyCSE6inx7qMjENGKOzRc3cCfuG?=
 =?us-ascii?Q?el4NMsqXzXqwaAi37TeofI0uIR1ES+u8ZK9E2+2vSD5yyRUexd2z4+yVkFr1?=
 =?us-ascii?Q?cG6SI85ZybBG4HIB8QOCwAQ15ayY85lxj//qAdEMWGFv3xfPrvw6ujwkMYxJ?=
 =?us-ascii?Q?CKAUQA3zQr+RKFs1WefgpHjlyFYqt+jqkBV1EE0YbGXlrwT0etGtADyTEgv6?=
 =?us-ascii?Q?8pGZb3FPIoFy7ZexTudGPdsM97x9Lp8aNoAYuPlwuBpVAg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?h6P4g8lUfwhItSuDb2sq7clGj55kLOErG00OVKeovvzi6n745blh9wfmGlvE?=
 =?us-ascii?Q?Bcjq8f9DCnz3Zky7uz5gUw+aR9tDsvkTWfVqCj0G9RK1kLPAlM7a+Pe3nBty?=
 =?us-ascii?Q?05MRWyr/p73Nmf7l6PUnQzc7O6jow+zJjm8KdTCz8CRW0ICbgoyqftyuAiY1?=
 =?us-ascii?Q?LRT0OS48c9Xjf5cqN9l7TyLGL1D3Kn4XBKOh7D8E43kgR+h6agOxZVVmTdNY?=
 =?us-ascii?Q?rzCG+TbEGURyEnnXo1AdfSpO1LoKt6zbJ/sx0dgPknKk4vGexSAiEe9r9QvR?=
 =?us-ascii?Q?kCTli4Auj2EXNQQfXvWygPbxaA9E97+aavmQMQ7/c6TUX+stp7JKP4Y0FKqt?=
 =?us-ascii?Q?NHCjmOFenNj7fbTFCVKfQMj9mUOBj89FdbqUfZq7tMWDSR9D8ITtr6eTHOcF?=
 =?us-ascii?Q?spjEnN5RE27V2+1oWR1KvL/sUwpEsKkkhwNwmTJoSiLeKtnWLGk5nh4xHhMC?=
 =?us-ascii?Q?9k4qeT82UmQFxx5aVL74N5dzzDtKmmNRAglaiiqRjP3Z2MtDejdjWosOYpbi?=
 =?us-ascii?Q?YmuUS7ouTdzhExj5pviysEkz4IJfccvF+hwyRhjro6Zoy3S/xMgBbabqPBUY?=
 =?us-ascii?Q?QXzqh6vJ/9+dVMKHYK9C8hnv1RJwSjFhcGzbrPqZsqmh3p10vVsxK52rkmns?=
 =?us-ascii?Q?jyc40iRBv11JFV527ex3sZR4igp3GRwINGJvKCNHnaZ1byqZGED+xtKXx+q/?=
 =?us-ascii?Q?mGF7zpFAXTwrX5awKMN3ZGnOa9SZjH/6yIqgfuFuuXIQaug8w1Eh43I9Puko?=
 =?us-ascii?Q?U+y6BJEoidwuLB3cke6nAzSGvVwIy5lsN3ufh+nlY6iVbWakLoqVQcYh8jwm?=
 =?us-ascii?Q?B1U1l/eo4aGPAhz3P4WKjeWx+9LMU/g65XP8zVoaRbwh63/M08YOpxpw9r1A?=
 =?us-ascii?Q?ADG4Cg35VoHYbuFouXCOhQflbsXWS+acER3YHSq2CIEGOw9KV1KT9THmcGtl?=
 =?us-ascii?Q?YJtkac7/a8poHV+vxPSix/pYCziq6J1OHNavBr/R12NyyzqcGKLOhGeYnZV4?=
 =?us-ascii?Q?5NaYrcqjejnCYtXPjJ+FyjheyGP2CnFKcEgkGkI7wemfj7JwOOcdTQdGEJ42?=
 =?us-ascii?Q?gWJ2CC54ft0ttXfbrTfzxtgize2KEYYJng+A4/OS7dSh72h9P0S0gcKZ9nCg?=
 =?us-ascii?Q?oYi1zN2TpQVEmeEGx1rE94K+dz/+mjdD+njghPV3dHm2OMUM8ElBdKWnBCRR?=
 =?us-ascii?Q?2IV0d650Z4+hmZkiXjO/xXsOpUHCeOJuqLGzps0MI4NgTHnzverqrCxuoxIo?=
 =?us-ascii?Q?T6orL50JStGIqb01U3U64+FSliuMw6k7+p6EQlmDJpSi8Su+iFXwtTqEWODs?=
 =?us-ascii?Q?iXo2iNtf+l8E9EyaNrm/2tghDQ34eAw00QdbriKJdOH5IO6OP57cB7UEPT/E?=
 =?us-ascii?Q?0b4cfpzaq+CzowuD633rhHkUddJ+aTq3lGW917LOtJCMZEMcx4WgfbWYcwJO?=
 =?us-ascii?Q?e2IEF0w9kR6VeMuCWol6G06qXW46ABHvVfCxLrWM+BDoV3wKhfWx/wby08Sf?=
 =?us-ascii?Q?jhmgW4pagDLuXB6a1A5t0FwbaYKL6YGFZ6avxZD54R6BpXYb08uYj4LihEMR?=
 =?us-ascii?Q?PQlcKTr/T9OsYanJjtqPv2S0X/IqLj2Lpnq9luI1lEZbK7FrB4lkRSEV8AVe?=
 =?us-ascii?Q?JNa3Z9oxIiLn5PxPmDKNoeVQ2P/Hava9oPWmJm3ygXiT?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9caa251a-3f1e-4ddd-cebc-08dca24a4be5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 08:11:56.5395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOMN5Kyvg/yUTyrFwHXIAQI2s+28R3WGbT0+UbPNeT+JaXq6UbIDKjqBxWgjcvTfDlbdCcFSFa1ZuOUQnJxriQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8316
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 08:12:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16461

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.clevis.hook    | 1 +
 .../initramfs-crypt-hook/files/encrypt_partition.systemd.hook   | 1 +
 .../initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb            | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.clevis.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partiti=
on.clevis.hook
index 4e62ef7..275461d 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.hook
@@ -45,6 +45,7 @@ copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2f=
s not found"
 copy_exec /usr/bin/grep || hook_error "/usr/bin/grep not found"
 copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
 copy_exec /usr/bin/expr || hook_error "/usr/bin/expr not found"
+copy_exec /usr/bin/mountpoint || hook_error "/usr/bin/mountpoint not found=
"
 copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
 copy_exec /usr/sbin/resize2fs || hook_error "/usr/sbin/resize2fs not found=
"
 copy_exec /usr/sbin/cryptsetup || hook_error "/usr/sbin/cryptsetup not fou=
nd"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partit=
ion.systemd.hook
index 2ace533..4aa3e91 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.hook
@@ -45,6 +45,7 @@ copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2f=
s not found"
 copy_exec /usr/bin/grep || hook_error "/usr/bin/grep not found"
 copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
 copy_exec /usr/bin/expr || hook_error "/usr/bin/expr not found"
+copy_exec /usr/bin/mountpoint || hook_error "/usr/bin/mountpoint not found=
"
 copy_exec /usr/bin/seq || hook_error "/usr/bin/seq not found"
 copy_exec /usr/bin/sleep || hook_error "/usr/bin/sleep not found"
 copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.=
2.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
index 76ce72c..1364248 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
@@ -12,7 +12,7 @@ inherit dpkg-raw
 DEBIAN_DEPENDS =3D "initramfs-tools, mount, cryptsetup, \
     awk, openssl, libtss2-esys-3.0.2-0 | libtss2-esys0, \
     libtss2-rc0 | libtss2-esys0, libtss2-mu0 | libtss2-esys0, \
-    e2fsprogs, tpm2-tools, coreutils, uuid-runtime"
+    e2fsprogs, tpm2-tools, coreutils, util-linux, uuid-runtime"
=20
 CLEVIS_DEPEND =3D ", clevis-luks, jose, bash, luksmeta, file, libpwquality=
-tools"
=20
--=20
2.39.2


