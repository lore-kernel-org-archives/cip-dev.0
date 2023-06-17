Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E45EB64D9
	for <webhook@archiver.kernel.org>; Sat, 17 Jun 2023 13:09:54 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.44])
 by mx.groups.io with SMTP id smtpd.web10.4764.1687007388776946041
 for <cip-dev@lists.cip-project.org>;
 Sat, 17 Jun 2023 06:09:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=SGxS9pug;
 spf=pass (domain: siemens.com, ip: 40.107.104.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9j64vZrQn3bKPa+9boPBpWdE5/E+gbibKX+o5ygOVO0q1npCoIqSC7PXnHwOCsKA9dDfH3VRJdaPglWMC6X8n6WOTdizlUJHFvpPRYajH9hBjFOwL4W6zIycu0lu/zWzyfE+TF90TH3X0dmBP07rS8S2rNyUUuya8eV8jm3jPQILDMqFCk8C+Nk041XINXPHOigfqSvQu9TLMBhR8IPTfH6TdyYkG98YIROSYFVeCJdFy3R5GJ6WZOwnqGEVrjrIG+4rabrVbJM0If051z5ezEr371wboPsbjoQ2Zkd61l+lT/7KkycJv0CD1VMwP/nBhtjdiUsRn7R7n1hQ7KLpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIn+8DsdLZ6JY558bMHCL8aFvLqYFb7qE/8oKglI1n0=;
 b=LJLw50BJIxp6ddy2xuORA+UxT1pnSMhGe8MgiI8BowmB5aJFE8KZQXVlBGpYFFadCi5JYkM+Z8wf0l8L1JWrloQeOB3LjHyx85s9iS9wwFYjghpZBbgh/uLYrnCOS6+Ae57z+CgYLZr5j6DsEEjwK6hVxsR8WmlrNlVYvtF7y0fzB10N0wcsPOA7HGDBQndU9Zn/Xv6ibxqhN1oRIRpMs5xEIpB3iLNezPWmxUyfz6yiL0UT4AAQqDRk/rgYr7Uby+YUAzm+ydd0AmFWdy9coF0vhOgD9OKiyUK1ybvgvac9ksq7lfTR0DTfGsxx6XfNKa4yxqlx/0bSmTgdi0ZrxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIn+8DsdLZ6JY558bMHCL8aFvLqYFb7qE/8oKglI1n0=;
 b=SGxS9pugMTI5w3ccJppAptwTSyFtoxqNJ+NJ/UyOJBOktCF0cPM4jB8SzNdokv2PVUPUmUgVHGVfOvYol6Da0VKB0g7cmrn7hlNYneLLN+6QinmVI9G0YiUcQiCcvMd7jVNwz1TI60g8/kHm1iLiGT2DK/TuAbvKBLb7TTvLoR2QfH+YRi+RMfu8XZzqGwFbK32F08JGnSGMKHkVM+r2OolRLisuS3I8fyJ79OFdM/3PND0pIdWYM1WaADernfUn/auN4LOjfokQD1gtcCmcjzEgvpJBZq+NAAiRP7QjBNP/rwFRdswBnEEiQh70Hg+A4ouedOkaBhy282gn6tet0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7735.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1bf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Sat, 17 Jun
 2023 13:09:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6500.029; Sat, 17 Jun 2023
 13:09:45 +0000
Message-ID: <795ab3b7-8aaf-3649-bc48-87bf780e11e4@siemens.com>
Date: Sat, 17 Jun 2023 15:09:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] efibootguard: Update to 0.14
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 "Moessbauer, Felix (T CED SES-DE)" <felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b79fb93-6608-4d9e-a298-08db6f341ec5
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QFNb4745tSuGuR1TKDrDoR7mcsB1PsCTT96Dk3lO7brpej2F6QkrPwZDFbwVXNGnK1bd/Cp9Ci89s3sm4mWtksbqx4HYp/5f8+oYyumXj027aNh/yy7IvShcArPKYIy7I6RwAX08I15BnYbSFOd7qNw1PdsU+8IwY8R4julSCO1QTYepD2Wymt4HgukHeXnrPCY+8GDth5cs2Qzy2ZItONqki88i3AUsALFQN6r7Ip/5sHSnu6keYzZicqoo1xSONJUzaCybJatPrHOa6CA90ckGEvhrv/dVOvgbvTNUwjAGS0BK953f+S4JoQLGrv1m3i56i02eGuA7m77vHkJBG41vcZTfeEBz6iyY4SPdPf9oF2fD2HmkRmakxOtdhlyR78PXem/sS/y/ICGETCZcdL/p5eYKuKbHVnJSFroPQDa64hSKy52hitjITLf5768XK+QsCXHMpvoScHMFUEE2B0AQP9Hv4qGzm8ORcOfdtB5voZ73X22JZL6IolPqMLgF42jtXWECsUPKXi/QGDNR1G29JUIvC4/3FpRoms+VNGAobmO4bHOXrYDBzpWMCo/54QKX8VvzMvI4lUQrOdiwBsuRvVnA/ZRSxtqiPfIF9gs505LK8km2db/qKgq+3kflofizE1rRtZzhfLWn/OvSHG7YDfMt7+Amjto2yhPwm98=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(54906003)(478600001)(966005)(6486002)(6666004)(44832011)(82960400001)(5660300002)(8936002)(41300700001)(2906002)(36756003)(86362001)(31696002)(8676002)(38100700002)(66476007)(316002)(66556008)(4326008)(6916009)(66946007)(2616005)(107886003)(6506007)(186003)(26005)(83380400001)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Wm5wbFgyeDRGaUFya2dkelY2R2twYWI4WHhLZTJjbEM5NlFlem10M3BOZUJU?=
 =?utf-8?B?VUZIeXpETFh3SkJKMUF5Nmd6ajhxUExES1VCdE1Ic1R2K2FRVFplemxSWmp4?=
 =?utf-8?B?NnpYY24zS0V2OVdVQXZFRE5FdWk5b1BsQjBjQm9ZZ1dMYTAvdUFTY1FJOWJT?=
 =?utf-8?B?dnYxQS8yWHhqZWFFVkZVOWJBZjIvbjhIN3o5R1VmWCtwNFY0R3BvMEE5NGRm?=
 =?utf-8?B?SEU2eWwyMnkreTRpNVN6TWxqeFBwcFVhR2U0RHE1ZHZUR3lVRGxsUzgwZWM4?=
 =?utf-8?B?amhabGNrc0RVNDc3MTJFbjhGcnhRL2FweHZva1ZyRHJVRUMrb0p0Y1FOL2h1?=
 =?utf-8?B?d0xpODdpQkYralVyWUFzQ2ZuYW1CNUhFU1J6aFljbmtnQ21yZUd3VFlIalJr?=
 =?utf-8?B?VTNJdERibU9lWWFmdTJmWi9zWjMvSGo2bko0bHU0dXBUNys5TUJJdllwY1JO?=
 =?utf-8?B?RllsZTJlYkxYQ2hSUDF4VzdXMDNLUWZndHowWExQK0FQLzB3aDJmNkxVWTVk?=
 =?utf-8?B?RFNMZ0hSYWt3TEFhcWNQb1o2bXloVUFGVUtGc0JoaytDZDBRQlZDOUtieHIz?=
 =?utf-8?B?ckZYWVZwQUs4ZnBRTDJsczBScnI5UU12ZUo0RitaTEc2MVpTQ05KMW8yamhr?=
 =?utf-8?B?VVpsVkErcjF4cjFsOTNURG5HbzBWbkF6dDdvZDZzbStJQzBjdWYwV2U0Q2tv?=
 =?utf-8?B?SVJoMTF6eUduczUwWGI0Rnc4MmtvMWFHeUJEcUxmL3RRaGhKYzBZbW1ZZzY3?=
 =?utf-8?B?cDVRMGlvVW5ERUlKQ0prMVBCTzVsN2xzZVJKNzdzOGdUNThXMWtCTVNnU1Vm?=
 =?utf-8?B?bTVnMVJTd0phQVpIOG5hVE1OTVF0L1VBSGpSQnBEU3JWVWF1M3NqZ0I1Wmlx?=
 =?utf-8?B?cHBsQ1pCQ3dZT2F0UDRDcDhlNkl6VDl1WWM4dFU4WkQzZnVnYlZ2MUFabTk5?=
 =?utf-8?B?SktMcWVIcEdNdXZYMUlTRFllQ0t0b2ZFczNCTUtJcmVpZ05JZjZ4U2JZdmxn?=
 =?utf-8?B?ZEtFRFNnTGRhM1hOYmVmdDlHaitNL1B0NGRUUytjMUVSK0N6Qi9lZDRlTHZh?=
 =?utf-8?B?cmZ3OElXQWhFQVBkNDd0YXhEcjFZUXdjUEg2OFBpSWRtbEhkNEFERXdWSWov?=
 =?utf-8?B?Ui9ZWkRxdjNNclcxZ0xOWndqL0lWQlR4c0tXa3g0NGgvSy9kRDg5dTI0WWFp?=
 =?utf-8?B?ZVFadll2WkhnNGVidmtrUzFxbkYySXNkeGMxQUhob21oU0JHdG01YXlPK2gx?=
 =?utf-8?B?V0VmdWtoUDBwR2tla1E5REVjdTdTYnJuci93bDYzMW1HdWdkY2Z5ZGYvMDRt?=
 =?utf-8?B?cDJMRDRZem5jZStZd21IZU5aam5lbkhUSktkNzNnNWszZGFQMG45RFZKTlNv?=
 =?utf-8?B?R0pISldMeGljY1h0Wi81MzN0bzdTL0V0aUJYUWhLQWVnOXJEdXcrVm1qc1d1?=
 =?utf-8?B?NnUxTzN6azc2c3ZmUm0rdk1iclIzb1dwdytXRnZWRkdlWUZSNVBvejVzTC9s?=
 =?utf-8?B?bmxoaDZmc0psWDZRcHI5ajNjWlBrMjA2UUFiRm02eFRweVE2VkJRMDFWcGxh?=
 =?utf-8?B?VHcwUGFveEJxUU9Tc0RzQnp1OTZPRTRjQ0lwVXFXOGlXRldibGhwQzNneWxR?=
 =?utf-8?B?VVlCU29oNGNPcEpKcW0yUVpXZXFlNWowQlViMTJHYjVIMFl1VVQ5S21aRGQ1?=
 =?utf-8?B?ZUIya1Rtd0VHVU0za05YMEtRL3FUT05yMVdGMGFJQlAvNUdITDlTUkQ2N0VM?=
 =?utf-8?B?SFVnY1JuQWN1RWdaZWVQOHRtYlV6NW9PS0ZYeTQ0L3Y5Z3VhUGRScE04cmJ0?=
 =?utf-8?B?SjhjaEpTend6bjFSTHA0MmJNak1MR3Rzb2ZsVzVkeE1HenlKWTAyR0pKZ1p3?=
 =?utf-8?B?ejluMVdhZUNvaWVRUEtUSEk4U2Zzdjl6ZlBZanBKYlZRZVFRUEFBemF0RUdM?=
 =?utf-8?B?M2s3Yk1iRlZtUkNwQkxVTkl3SFdiOVEzeFNQQi9KR0V4UE54bmdrNWp3V1N3?=
 =?utf-8?B?U2Y2aHkyVnlGdEFzYmpWVi9JcWxKZkJNUXpLRDlBMWcrRjNqbExpdTNiOXoz?=
 =?utf-8?B?K0VmTjhIMnFLSVdsbGdxRGRpTmpiNnZqV0g1VFhxWjd2MEFaVlpLaVVLaWhm?=
 =?utf-8?Q?G3Ax02aOu+HpbL3aE1n1dV6YP?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b79fb93-6608-4d9e-a298-08db6f341ec5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2023 13:09:44.9994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1Vcjf0grzGNbMUEycetSwnbJZ+55Q8axIjzi9SBW1q5esUmgJg+m5HHyIIDA6caSYdk6UNxNv04Zy9KuPY7kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7735
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 17 Jun 2023 13:09:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12070

From: Jan Kiszka <jan.kiszka@siemens.com>

Allows to drop the RISC-V patch.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...0.13+cip.bb => efibootguard_0.14-1+cip.bb} | 13 +------
 ...01-add-machine-type-name-for-riscv64.patch | 39 -------------------
 2 files changed, 2 insertions(+), 50 deletions(-)
 rename recipes-bsp/efibootguard/{efibootguard_0.13+cip.bb => efibootguard_0.14-1+cip.bb} (78%)
 delete mode 100644 recipes-bsp/efibootguard/files/src-patches/0001-add-machine-type-name-for-riscv64.patch

diff --git a/recipes-bsp/efibootguard/efibootguard_0.13+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.14-1+cip.bb
similarity index 78%
rename from recipes-bsp/efibootguard/efibootguard_0.13+cip.bb
rename to recipes-bsp/efibootguard/efibootguard_0.14-1+cip.bb
index 9fc15a47..f58a3200 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.13+cip.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.14-1+cip.bb
@@ -17,18 +17,13 @@ LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260
 MAINTAINER = "Jan Kiszka <jan.kiszka@siemens.com>"
 
 SRC_URI = " \
-    https://github.com/siemens/efibootguard/archive/refs/tags/v0.13.tar.gz;downloadfilename=efibootguard_0.13.orig.tar.gz;unpack=0;name=tarball \
+    https://github.com/siemens/efibootguard/archive/refs/tags/v0.14.tar.gz;downloadfilename=efibootguard_0.14.orig.tar.gz;unpack=0;name=tarball \
     git://salsa.debian.org/debian/efibootguard.git;protocol=https;branch=master;name=debian \
     file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch \
     "
-SRC_URI[tarball.sha256sum] = "639a6d8f687cb099b2e9b01eb08ad1494267fe26b5d903b4d405d0737feb989b"
+SRC_URI[tarball.sha256sum] = "80452a9e37460708113292daf0050d3f4fa7d3d4b8b2308620701112cf18eaa1"
 SRCREV_debian = "e39728f63946d1af2d5edbecd89a30706dc31a9a"
 
-# add riscv64 support
-SRC_URI += "file://src-patches"
-
-CHANGELOG_V = "${PV}+cip"
-
 PROVIDES = "libebgenv-dev libebgenv0 efibootguard"
 
 S = "${WORKDIR}/git"
@@ -46,10 +41,6 @@ python() {
         d.setVar('DEB_HOST_MULTIARCH', proc.read())
 }
 
-CHANGELOG_V = "<orig-version>+isar"
-
 do_prepare_build() {
     deb_add_changelog
-    cd ${S}/debian
-    quilt import ${WORKDIR}/src-patches/*.patch
 }
diff --git a/recipes-bsp/efibootguard/files/src-patches/0001-add-machine-type-name-for-riscv64.patch b/recipes-bsp/efibootguard/files/src-patches/0001-add-machine-type-name-for-riscv64.patch
deleted file mode 100644
index adc7962c..00000000
--- a/recipes-bsp/efibootguard/files/src-patches/0001-add-machine-type-name-for-riscv64.patch
+++ /dev/null
@@ -1,39 +0,0 @@
-From 391dd5e04b17be6f5184afb2de4853795f1d5620 Mon Sep 17 00:00:00 2001
-From: Felix Moessbauer <felix.moessbauer@siemens.com>
-Date: Tue, 31 Jan 2023 09:27:31 +0100
-Subject: [PATCH 1/1] add machine type name for riscv64
-
-By adding the machine type name, the generated efi binary for
-riscv64 is suffixed with the corresponding efi machine name.
-
-Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
----
- configure.ac | 4 ++++
- 1 file changed, 4 insertions(+)
-
-diff --git a/configure.ac b/configure.ac
-index d8f9d3a..90d70b0 100644
---- a/configure.ac
-+++ b/configure.ac
-@@ -87,6 +87,7 @@ SET_ARCH(X86_64, x86_64*)
- SET_ARCH(IA64, ia64*)
- SET_ARCH(AARCH64, aarch64*)
- SET_ARCH(ARM, arm*)
-+SET_ARCH(RISCV64, riscv64*)
- 
- ARCH=$(echo $host | sed "s/\(-\).*$//")
- 
-@@ -103,6 +104,9 @@ AM_COND_IF(ARCH_AARCH64, [
- AM_COND_IF(ARCH_ARM, [
- 	   MACHINE_TYPE_NAME=arm])
- 
-+AM_COND_IF(ARCH_RISCV64, [
-+	   MACHINE_TYPE_NAME=riscv64])
-+
- AC_SUBST([ARCH])
- AC_SUBST([MACHINE_TYPE_NAME])
- AM_CONDITIONAL([ARCH_IS_X86], [test "$ARCH" = "ia32" -o "$ARCH" = "x86_64"])
--- 
-2.30.2
-
-- 
2.35.3

