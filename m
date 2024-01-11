Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43289C47077
	for <webhook@archiver.kernel.org>; Thu, 11 Jan 2024 13:52:01 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.64])
 by mx.groups.io with SMTP id smtpd.web10.11645.1704981111815352979
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jan 2024 05:51:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fTqe7z1/;
 spf=pass (domain: siemens.com, ip: 40.107.241.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3Fux8bI0SAgftO7zZAKfvy3GDbrZR+jE9qGBs6TIwQNABg9Gt+zQKGRrr62dQKtNxF3pdFZZlAnF1lVcm0MlPk4lxZqWZS18uT2XhZMdHkpmlnMJd+5T7BH4as8CPAHUQpsMiuN8PNiETbKqov47ztTCQ32ZAJ44k6O7vOf6Kqh4nCt3HF0RabcuXMQ6zPm26TbwKsaZNadgQKcLB/KZJ355R71Hw04i5Wi1+tB2TSzm6Y7eG0QtzVz8QUTZNGghyAaTcmrBqkBSaw5z32Oy2akEuJXsekftCNcxTOxpjc05K7514sRHenvJrB/O6R1n806i0rEkAEZVwmIxj/Tpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmT8TTL7abxu7l/sJu8Slv5FObb8sQaPZUVMBfDrUP8=;
 b=PXNjVfnZfQnpRyseC85riJ2xYWwBDp0BInnvcFx3S92XLFbh4ktDui4VdeSSv5mjwmqkgbxtG8HrHre02Nr+3e8B47JMmAQC9ZREI7Ueh6v+C0LPyrxxyxGd+0bdfETxnmHf0094CX2k8n6VjgdBw5IYNBxkwxx6TCgv3p2QhBouKp43xnB01I74NCE6umsI35BLjH2SQRVO+zUzWHxs89V0QI0snIoyXMxRCfWguSK++pbK78y0J36BM1d7zAsShRiqo8ngLrm8lUQfEDRCa9QiUpRjpq+f+2R/m5m69BQ777iPVvzeA7ThxMxoQw5ZoVE+nKBNv69gA1VAtnBeLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmT8TTL7abxu7l/sJu8Slv5FObb8sQaPZUVMBfDrUP8=;
 b=fTqe7z1/IsveYHO1UrPxRkUEbF6qGgtHRG0OQzZgOglFpm7dnOXsPcqtMPxhZxMu68Nh2e2+OEIXJcDE4tCbEmI+fuIOGbYQOXzuoRyGxQiSd181SV1ph1gmbp+GJrXN0KMPPQ+FdEH39atjbP8NZF0evI263XP2OZIcUWPXAPfhSNkwI+94Xs2t86WTIPABBct2m0bSvgWRUMuwH+zi8YpxTXSjmU/t92TMi1n1D8gX2fMEjO9ZmO8TgS9th8A33xrGCgXsrDIo/oB3qtXgvlhdug+DNGdh3ruEtnrDcxCFBPO4Dm4AP1fsa4tF31mAx2w9m6qkAvlicDSrXiiSpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6297.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 13:51:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 13:51:49 +0000
Message-ID: <1cd81bc4-a52e-4dcb-9ff6-48b163bd6edd@siemens.com>
Date: Thu, 11 Jan 2024 14:51:49 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] Migrate RISC-V support to Debian sid
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0468.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e8be074-c43f-43a2-0d26-08dc12ac75af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	04cSMuFvm1TU5dBuVg4B76AFMLGdtDFQET+oUykCnDr0VlmwOzNxChlvPZQLOQDBq457YRVYMX7ElkWzFIN8IVxD2bYLPw+njhKIbUfM6rhVCrINssH8piwZOL/f4RwdIBHkZinpYmYx1NnRRLqwFHPy8vGz2yw8i/2rHbvqzMhEg+sMI2/doDFR2N/MNSiwqqpegGC4cbFVdbiSCoz+TeBeoStOMvOg3YJ5hGAgtYjnWQVH7/xFqIKipIg/tFSrht5s111tF3Uz09ITrWChVmiPuiSFEdGxQ3NcCwBXOzZSXoYR1G+GkoLQ7GzCEXHaZmxgdmnY/3+bphkEyiqhxN8GJJXqqsPb7WRBgK0ALwuUNNVGZ8YSLUDrRP+CMPxl0DIaa27aEGEC9XEJ25QO/vEsgvWkXPoFxeTdBVCftKGg+IKXAuumKnvO2moZKvdJTEUqR7fKazyl/NaLNgC7+AHqS9urRKMjsvLFweYsHVJdYjVsLsPSEIQ3rQCAxrooMsTyXUary0M6Gm2BYvL4KhePH5uSRO6d/7rdneOVEWyQutyT4JUIzPpYs4D5jeblHGErw64KtL5Ul9h2XlVsQln12PgYUdGnIHsky6YCak/L38EuXaPRaQj/hHLqCOeYa57Vjp9ina7UNMDEwe0uYA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39860400002)(376002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(31686004)(478600001)(6506007)(966005)(2616005)(6512007)(26005)(86362001)(31696002)(38100700002)(82960400001)(36756003)(2906002)(41300700001)(44832011)(83380400001)(5660300002)(6916009)(8676002)(66946007)(6486002)(66556008)(8936002)(66476007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WkVMMXQ3ZXhYaytHOTlhQmQ2UWNoc0JqeHplR1NOVFdid2h4QUt1R1UzUWUw?=
 =?utf-8?B?N1RzY2RMNGlOby9QQ243OU1ZcWZTZThnQVdtMzlNRlVvTVk5ZEVYNzFxRHFU?=
 =?utf-8?B?ajAvYUprWkNjWGNtaHNDWDMrczhhREMwZTNzeXp2eVVyVWwvMmpIOUE5VTYr?=
 =?utf-8?B?NUxhbWxtYXg1eFhvUjcvMDArVEt3VFVTaFYrdzJSRDhjR2Z5Z2JwbVRsUm00?=
 =?utf-8?B?TThCcHVNQ1hBNU9XdWVQRE1mUGQzbklPdnUxN2N2VnRRT05ScFlSMG9IRzZw?=
 =?utf-8?B?L1NmYXVuZEJ0VzJ2TUNCM3pENTY0alRXbmdFZUNtQ2N0QTlUdXphOUxRcElk?=
 =?utf-8?B?Y0tSNXNKZDNqRFZWTHJMc3dyVHcrQTRvK3Q1c3FsTDJ0c1VmaGIydnhLaUdw?=
 =?utf-8?B?TVNLUDJlTCtIVE1qa2FBTTFOSDZuVHVrblI5N0lzSHpNdGNWVzdRdjNoMS9q?=
 =?utf-8?B?MDhVbytTdGk1UTRseW9hODBDR0RNaUVzWGN2a3ZZbGRiRGRsVUNvRk1TRVJI?=
 =?utf-8?B?bitMcmgvdjV2TWt6dzFUM1N4cnVBWFovUzhSOWZiMFJyOU5yS1hxckd2eDVR?=
 =?utf-8?B?SmY1WkQ2T0NlK0FkVG4yVWRScUtBNVFISlRhWlluYVRQUzMybTVCcFVIdVlW?=
 =?utf-8?B?K1dKSGdvbDFnd0toRVdCRUVCNzNkREdkOWkvZjZaQ3JxNWNjN2VQVC9zazB5?=
 =?utf-8?B?QzJ3V3ZCWEVFUU1DWktheVA1ekNzbWNrc3dGcllQYUF1d1d2cVh6TVFxR3Nn?=
 =?utf-8?B?aUcvdEN3ZWFoNHNlaS94OXJhM1FadnV3cHdoanBGbmFhMVpVNG15WldtWS8v?=
 =?utf-8?B?UjBPM1NmQmp3eVVDNXd0aUczRzlZVHN0S1J5bXBpZkxCMndkenVPUWJFOFRN?=
 =?utf-8?B?WjVNZWpseDVSZHQ5djBvb3BkZmdoU1l2VmZWc3lxNVdIdWMrWE1lZmtxSFJV?=
 =?utf-8?B?MERKbS9MQ0NWbWJtdm9EL1hBMFdVWXhQcEt1MXdkZldySkJpT1ZLaGV4NkRK?=
 =?utf-8?B?YUY1SFRBYUZBaStZeUE2Y3dVTi9JcEhlSmtRNy9lMVB3R0FUQVBrVDRHeGlI?=
 =?utf-8?B?VHlVZnNsNkF4TVlRN2w3TzRRbXNUcnJnZldMeFZSTkdnMEhreStTOXZIa3hV?=
 =?utf-8?B?dzNEVVE5L0lwaXoxU1Ntd0FHaWkyeUJ5cndCWGtFdXQwLzdCbjZXbXd2aUhp?=
 =?utf-8?B?eEFmeHlERTloQjBKZGgyVnowMDQ3Ui9wakpLV04rTjNMMFZCcDcvMmpZd3lQ?=
 =?utf-8?B?REVWRFZxTHVoR2h6K3JGL09TWGVaWnI4c2pMaUYzYlJibndHRWcwRC9iT1Bj?=
 =?utf-8?B?UXlyMEtIelZORmVXaTFuVVh6TWJIS0p6LzNOQm9Qd1pGZ3FxUllneVdiSlpO?=
 =?utf-8?B?L2t3TDlRam1TNkVSSTV6OGlxYkdYVWNBZ0N3NlN2ZGxCbkpRY1RqN1NsMHBC?=
 =?utf-8?B?aitXb0g1ODNheWE0NG9WMC8wQWorWnRvMEtBWC9VbFNOWmlUOHRMZ1BxeGFN?=
 =?utf-8?B?N2pFanlGNXBNTVZ5VWRzVmdUeFhrOUNZODR5ZGpaRkd5WWY1T2NaNEV2NVpV?=
 =?utf-8?B?cEcvdDVJaStYaUNaY0UzcjArRllLNnVnbUVKZHhzcFRBdGQ0VGJQRjFmbmlT?=
 =?utf-8?B?OSt2MS9KdDZtd0cxWGtJS0pLR3Q2SW1BSXpOV2tJK1JmdDdlVVloTzRvRE5w?=
 =?utf-8?B?a2w0OWlJMjQ4Z0FjNThCZG5raWhsM3VhQ1paR2p6Qm9KaTZtSW9kaGZBaFBO?=
 =?utf-8?B?dUowZ2NjTFRIUHR0NEtjREFoSFF6WUVVd1BXVWlIWXRYMXpURGloRHJPcTEz?=
 =?utf-8?B?RlN6YmRQbUo2MG9ETWhOWVpVNXJiaDgwSkZZOW9LWXk5UHdaK1hIOGl6cEc3?=
 =?utf-8?B?OXh1bVRsdUUzN3R2SlM0K3FaSGc0V1Y0MWZjZng0Y2FPcXhFbmFud3N4d1k2?=
 =?utf-8?B?YjZCZXhhR0dwRkpnSjl5WnZDMWpISXVEbE83NFpzQkpoN3MvY3hCMm5KWTFI?=
 =?utf-8?B?VW54b3pDYzJXRkNDSXdWQ0p2S1h5ckhseEkvajB0MXd4ZUpkcDE4Qm1idWg4?=
 =?utf-8?B?YkNxd3FzY2pvQWpaRDkzKzE1SEhZWENhcFhBamI0U2l4ajhTbTY1aXRDcGhR?=
 =?utf-8?B?KzJPWlJkVXpLbzJ5SVhKK3FvTXp1QmxiTm9uMkQwQXlCUEorRUR5QVhjZjc2?=
 =?utf-8?B?bXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8be074-c43f-43a2-0d26-08dc12ac75af
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 13:51:49.8584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wAQeKezNPuwqMa+5Rea4/fG4NV7EC4TRF9tQergk86fNDxScfA9a9xFyL+s1y+FkNrFqzpJ+Fpp7CN0dbcwMPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6297
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jan 2024 13:52:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14330

From: Jan Kiszka <jan.kiszka@siemens.com>

With the promotion of riscv64 to an official port, building from
sid+sid-ports became broken long ago. Then cross-building from sid was
broken, but this has been fixed recently, and the release team is also
trying to keep it working. So it's time for us to migrate our
qemu-riscv64 to this new configuration.

We keep the "allow_failure" in CI as we are still building against
unstable, though. That may change once things move on into trixie.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml                                |  8 ++++----
 Kconfig                                       |  8 ++++----
 conf/distro/cip-core-sid-ports.conf           | 20 -------------------
 conf/distro/cip-core-sid.conf                 | 17 ++++++++++++++++
 .../distro/cip-debian-sid-ports-snapshot.list |  2 --
 conf/distro/cip-debian-sid-snapshot.list      |  2 --
 kas/opt/{sid-ports.yml => sid.yml}            |  4 ++--
 .../secure-boot-secrets/files/sid-ports       |  1 -
 .../swupdate-certificates/files/sid-ports     |  1 -
 start-qemu.sh                                 |  6 +++---
 10 files changed, 30 insertions(+), 39 deletions(-)
 delete mode 100644 conf/distro/cip-core-sid-ports.conf
 create mode 100644 conf/distro/cip-core-sid.conf
 delete mode 100644 conf/distro/cip-debian-sid-ports-snapshot.list
 delete mode 100644 conf/distro/cip-debian-sid-snapshot.list
 rename kas/opt/{sid-ports.yml => sid.yml} (70%)
 delete mode 120000 recipes-devtools/secure-boot-secrets/files/sid-ports
 delete mode 120000 recipes-devtools/swupdate-certificates/files/sid-ports

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 1de6570b..81a31c5e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019-2023
+# Copyright (c) Siemens AG, 2019-2024
 # Copyright (c) Toshiba Corporation, 2020
 #
 # Authors:
@@ -56,7 +56,7 @@ default:
     - if [ "${release}" = "buster" ]; then base_yaml="${base_yaml}:kas/opt/buster.yml"; fi
     - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
     - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
-    - if [ "${release}" = "sid-ports" ]; then base_yaml="${base_yaml}:kas/opt/sid-ports.yml"; fi
+    - if [ "${release}" = "sid" ]; then base_yaml="${base_yaml}:kas/opt/sid.yml"; fi
     - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-partitions.yml"; fi
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
@@ -329,13 +329,13 @@ build:qemu-amd64-secure-boot-buster:
     deploy: disable
     encrypt: enable
 
-# riscv64 (sid-ports)
+# riscv64 (sid)
 build:qemu-riscv64:
   extends:
     - .build_base
   variables:
     target: qemu-riscv64
-    release: sid-ports
+    release: sid
     use_rt: disable
     wic_targz: disable
     deploy: disable
diff --git a/Kconfig b/Kconfig
index f5ea5aff..d0dc13b1 100644
--- a/Kconfig
+++ b/Kconfig
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021-2022
+# Copyright (c) Siemens AG, 2021-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -136,8 +136,8 @@ config DEBIAN_BOOKWORM
 	bool "bookworm (12)"
 	depends on !ARCH_RISCV64
 
-config DEBIAN_SID_PORTS
-	bool "sid (unstable) with unofficial ports"
+config DEBIAN_SID
+	bool "sid (unstable)"
 	depends on ARCH_RISCV64
 
 endchoice
@@ -147,7 +147,7 @@ config KAS_INCLUDE_DEBIAN
 	default "kas/opt/buster.yml" if DEBIAN_BUSTER
 	default "kas/opt/bullseye.yml" if DEBIAN_BULLSEYE
 	default "kas/opt/bookworm.yml" if DEBIAN_BOOKWORM
-	default "kas/opt/sid-ports.yml" if DEBIAN_SID_PORTS
+	default "kas/opt/sid.yml" if DEBIAN_SID
 
 comment "Image features"
 
diff --git a/conf/distro/cip-core-sid-ports.conf b/conf/distro/cip-core-sid-ports.conf
deleted file mode 100644
index 2e74af73..00000000
--- a/conf/distro/cip-core-sid-ports.conf
+++ /dev/null
@@ -1,20 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2022-2023
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-require conf/distro/debian-sid-ports.conf
-require cip-core-common.inc
-
-PREFERRED_VERSION_linux-cip ?= "5.10.%"
-PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
-PREFERRED_VERSION_swupdate ?= "2023.05%"
-
-DISTRO_APT_SOURCES = "conf/distro/cip-debian-sid-ports-snapshot.list"
-HOST_DISTRO_APT_SOURCES = "conf/distro/cip-debian-sid-snapshot.list ${DISTRO_APT_SOURCES}"
diff --git a/conf/distro/cip-core-sid.conf b/conf/distro/cip-core-sid.conf
new file mode 100644
index 00000000..028b6c00
--- /dev/null
+++ b/conf/distro/cip-core-sid.conf
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022-2024
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require conf/distro/debian-sid.conf
+require cip-core-common.inc
+
+PREFERRED_VERSION_swupdate ?= "2023.05%"
+PREFERRED_VERSION_linux-cip ?= "6.1.%"
+PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
diff --git a/conf/distro/cip-debian-sid-ports-snapshot.list b/conf/distro/cip-debian-sid-ports-snapshot.list
deleted file mode 100644
index bd08a742..00000000
--- a/conf/distro/cip-debian-sid-ports-snapshot.list
+++ /dev/null
@@ -1,2 +0,0 @@
-deb	[check-valid-until=no trusted=yes] https://snapshot.debian.org/archive/debian-ports/20230430T091331Z sid main
-deb-src	[check-valid-until=no trusted=yes] https://snapshot.debian.org/archive/debian/20230430T091331Z sid main
diff --git a/conf/distro/cip-debian-sid-snapshot.list b/conf/distro/cip-debian-sid-snapshot.list
deleted file mode 100644
index 87e0b95b..00000000
--- a/conf/distro/cip-debian-sid-snapshot.list
+++ /dev/null
@@ -1,2 +0,0 @@
-deb	[check-valid-until=no trusted=yes] https://snapshot.debian.org/archive/debian/20230430T091331Z sid main
-deb-src	[check-valid-until=no trusted=yes] https://snapshot.debian.org/archive/debian/20230430T091331Z sid main
diff --git a/kas/opt/sid-ports.yml b/kas/opt/sid.yml
similarity index 70%
rename from kas/opt/sid-ports.yml
rename to kas/opt/sid.yml
index b11a1c2b..be2eeb47 100644
--- a/kas/opt/sid-ports.yml
+++ b/kas/opt/sid.yml
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022
+# Copyright (c) Siemens AG, 2022-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -12,4 +12,4 @@
 header:
   version: 14
 
-distro: cip-core-sid-ports
+distro: cip-core-sid
diff --git a/recipes-devtools/secure-boot-secrets/files/sid-ports b/recipes-devtools/secure-boot-secrets/files/sid-ports
deleted file mode 120000
index 91bf492f..00000000
--- a/recipes-devtools/secure-boot-secrets/files/sid-ports
+++ /dev/null
@@ -1 +0,0 @@
-bullseye
\ No newline at end of file
diff --git a/recipes-devtools/swupdate-certificates/files/sid-ports b/recipes-devtools/swupdate-certificates/files/sid-ports
deleted file mode 120000
index 7d00e075..00000000
--- a/recipes-devtools/swupdate-certificates/files/sid-ports
+++ /dev/null
@@ -1 +0,0 @@
-../../secure-boot-secrets/files/sid-ports
\ No newline at end of file
diff --git a/start-qemu.sh b/start-qemu.sh
index b6f9d012..080f939c 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -2,7 +2,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -40,8 +40,8 @@ if [ -n "${QEMU_PATH}" ]; then
 fi
 
 if [ -z "${DISTRO_RELEASE}" ]; then
-	if grep -s -q "DEBIAN_SID_PORTS: true" .config.yaml; then
-		DISTRO_RELEASE="sid-ports"
+	if grep -s -q "DEBIAN_SID: true" .config.yaml; then
+		DISTRO_RELEASE="sid"
 	elif grep -s -q "DEBIAN_BUSTER: true" .config.yaml; then
 		DISTRO_RELEASE="buster"
 	elif grep -s -q "DEBIAN_BOOKWORM: true" .config.yaml; then
-- 
2.35.3

