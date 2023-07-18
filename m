Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0697EB64DC
	for <webhook@archiver.kernel.org>; Tue, 18 Jul 2023 19:33:05 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.66])
 by mx.groups.io with SMTP id smtpd.web11.4950.1689708775696109279
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jul 2023 12:32:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xfMeJao/;
 spf=pass (domain: siemens.com, ip: 40.107.21.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nL1xYD/rUxvOA/32nXUD9dsWXdIZNmfiK/GbV0Ntr2uCXBi1S13vOO4QYNBdYMZj4jsKtP7FrOMyuaWyf39AZMKEhA4OTWJqLrqjx40jwx8xbqm4lHovzk5pseTWtGUlCnVqzGlgGvfuNtr3B+V60Mg5S4MIwPbbGEs1pJ8FkAyNsw98+TC/7PLENHRF3oa4sYBOiqTVF9xMS6mCSqKzM2EkbyWeNCEmzCRV85Qp/tQe3TWm1LcnlEIkMQgG02Kk/cNqTCRMf8MyAbYf9V1ztc09mmpXKllkN5ucGXA7938HQpa6hmqhbVG8oyrDqG4Z526qULaZSrx6MfVf+3hY/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTf9d2YQiN/FJICGgkssMXmrrQf0y/MvLRfB/ZlHuOQ=;
 b=hd9A1Ljiv09aSRA70upiLh5vpZR7DFq4/6NrBSUFd3p3dEemzBZaBqUG28EO5dhkkh1q1P85JganYjAY5golA8Z9D2+tm5QKG5JdqB1DUeNbEWAm12baMZ/yNkaPGAsXGygBS2zv06AqOS+96hqzdGzo6BW5knPg6Du41h5kpJAM734Eq+3pn0e4n2YFuTAgHsrAq+zHww08yu7RS7/Yu0sXwQfwBtqREVb8/oRy5d+OosNlRzLdw2w2H2kS5VEj5j2LJeXLO7NvWMn3Rri/kTLuaSQtRoZIusPXvs/8VpQDSg8xR90DNg0Q5FHbfs3/V3cFfBuSbjgqO99kk+EbqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTf9d2YQiN/FJICGgkssMXmrrQf0y/MvLRfB/ZlHuOQ=;
 b=xfMeJao/GDdKuUKVS6v/00eUtVNTquHQs6+Ki8ZRrLsx6fc6+LuJpLolr25PapGrvHf/aJg5H0tf7cTAjENuIiMpwNe8ttAzBzv7bJzXX/sHHXlF/94HDyyt8t07uY8DfF0ZAx4cXKeuABcadKW/r0P9mQxEuUGnUKIAmq/22VLWuYxYRhv/0IR6kAUJuOM38t65NnrmyOPxrFwiLoaXuQhQin9A6dGTsSUmYCX0z8xVCj+H67ZEQ0mHRiwbmK/ioo92XJdzr6K89M7dpQIkkQVdIa5sYaEpeVR+ZFUEcAQk/I5PrLK4uxrIaLkFMOmWvyaDk0xfxpfcpKE4iF1Waw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3863.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:168::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 19:32:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::77d2:3a68:9741:67cf]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::77d2:3a68:9741:67cf%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 19:32:52 +0000
Message-ID: <00856a85-3d39-cb39-d8a9-e86e257ef4ed@siemens.com>
Date: Tue, 18 Jul 2023 21:32:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Switch to 6.1-cip release
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3863:EE_
X-MS-Office365-Filtering-Correlation-Id: fb4cece2-35ba-4791-2d8b-08db87c5c702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kMzVcJiz+BpfiqHtP357iJfr6ugKz1BWOf8weeHe1pzVpkCa1oSSUyZY7xRtNZfmL0RkdXJ5mEriV4N9daNg9gYFUByZaYGLibKDkyQ5V0ZMpoLdMJpXygUpa8goyQ8T4SOLIOLznEq8zo4sUgzT4BNTHehwndxP9F4x6n/IUUxoFszewepfKTb1ZsAkB2w+KcNlnl1aHidjQVkY42IdCq5Zq+oTgRZJEXhmvRak36pTeco5MH9K1XEn3p0XSXQmlpVNkd8nRkRbpfNj3QlKQ69FeaduVck0cFiCb/uu5BBhTqrl8nwpFCI7HzXGU8ZnQY9vHV6So7UAbkhHcQhKT77fO/WMAAhpCQh9XIRPXdHOAhynn8VF7Mk4YO6sJ3SIkFngLs1l9To5z+4bAfi8ZwH1znD9f5sgZYA//J66QYmxfcBLK9GwXM/ZJ/zbdfVNKtgtNhnKVuKr3zmRZ1j3TBTOh1bZK24e66sfTMGief7zdzHqkyZGFR3VJ0/GldaOllVDl1dceoszHTL1SWiz9PmJb/s4fgM9DKo/CaA+w0cne+iJCHhJQ/cYHoaW7bWwSkBYISry/ZH/+DC1VHIiVtCiYYLW+Om0SfkO8fp+d6ZEqsCzKnOAbdbg+NhRjLebM8mjy6OBuPW3jKbEo/xTqQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199021)(26005)(6506007)(41300700001)(316002)(83380400001)(31686004)(2616005)(186003)(966005)(6512007)(6486002)(66899021)(82960400001)(478600001)(44832011)(66476007)(66556008)(66946007)(6916009)(38100700002)(86362001)(31696002)(5660300002)(8936002)(8676002)(36756003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M0dsaGM3YktjQjFGTHNJL241dlN4ZzUrWWVFODAzTWZwcFRHclBUbExGWTVC?=
 =?utf-8?B?R0ViR2tEUERtNzloL1ZQUkFLWERZNk1pTjJzV3JqWGE0OXFWcHFyUWplNDMz?=
 =?utf-8?B?K1UwbXFiSUllWDdwbjFxVG10VjVFaUw5MG15YUdZWTNqaWVkWXNYL0NwUnk0?=
 =?utf-8?B?dWpRVUo5UEp2YTRLYWJDK2l4NGp4b292WmRXUmhVRUdUenNGb2t6aXNEZmVM?=
 =?utf-8?B?cTVYUy9rb2Y5NUlSeWRxamNSNE0wZlhWcW9jNzVDMHBrNmtPWXFQOVR1UzBY?=
 =?utf-8?B?YkFRWU00cFVUTEJqTUQxcExBQzl1WkExdG1GNk5yQitHTHNlWWtKWXNMOG8z?=
 =?utf-8?B?TXMwRWt3RUg3ZHZBTWFuL0ZZdUhUMFVRd1F5a05rWFhSYkIzWCtKNGRPalJK?=
 =?utf-8?B?WkZwOXFCVitmUkpSMmp4UlIvaFRWWUhFRFhpVjh0aDVHbkRPM0luMXdCR1Va?=
 =?utf-8?B?M1d1SzRjYU1IQk1Ga2w5T3dzUTdqdUc0VlhvNTJwT1h0d2puaVVZYVB2OTF0?=
 =?utf-8?B?M2dNcWZkamFKRWVtMzlsZ1VFTGZ5NmswWk5GZThyaFE2VnhHbHBmUWp6U3Fy?=
 =?utf-8?B?MTR5ZVdhanFQWkJld0I1SkJCcWs5TmpKOFRxMlI0bVBxaStCTlBjT2xTOERk?=
 =?utf-8?B?Y3MxdVpPWjdYbkczWHE1MSs0RjgwaHFXNHg0OEJIYm5qMEdBWFYyV0pkN2pB?=
 =?utf-8?B?OTJyS3FhL1ovOW1BUmpxWU9JTnZNRmN1aVFpQmpUakt2NzVYV2gvdFd2TENv?=
 =?utf-8?B?U0JHMmZHbGQwYXhCdXZhdVlvU2V3aFo1VWFpQUdUYWFzWW1Hb3BJc0VsZzJZ?=
 =?utf-8?B?VW1yYm1uanJvTWJvVmt1L0lxR0tmTFVrK2FWSUpTWmY2K0RzRzRxMlJrS05k?=
 =?utf-8?B?VUUxbndHZmtvelZ1YWNWSzdPRi91TE4wR1IxNWlMSDdncGVvKzRWZ0Z5bEhi?=
 =?utf-8?B?MDZnZStnVWVoWGFORVlSR1pQVWtQOWlCUE90M09FQ2E5VFZySTdVV3JTUlJj?=
 =?utf-8?B?ZDdxN0xnenordUZaemRuTlBmb055dWZlbVZraVcyRDRQaDd5SE43dERxNnNT?=
 =?utf-8?B?NXNlRElZMTZTQkZXWVlBQVZGSnhxY21jNUdyY0wrWFhlZTBqa0dEZUpiUkNw?=
 =?utf-8?B?Q1JQemM5eHc0cEV0Um9tOTAydUlrRlVxd3grZ2wyczVXdVNCYXhwbENRdHZm?=
 =?utf-8?B?WEJuSHUveUk5R21rVHh1ZWk2b3ZRZDNJK1lkTXR2cnMveXZCbTRNbVN4Q2xL?=
 =?utf-8?B?RDd3emxuYmtnTkF0NFQxWTcreUVyWGIxMzM0SytuK29ma2hNSHNQaVJLbFQx?=
 =?utf-8?B?UUZ5UlRtOVF4a2VwMi96MTFKenExMmthMUNxZTFGdXpNM3FiZG1wNW1qYWlY?=
 =?utf-8?B?OXpOWEgyeW1tWGdsREx5TVJnMUZmS1pqK0RhS05OWk1zTGg3OVp5OEYrRTBX?=
 =?utf-8?B?OWlPMnpyMGx3dGZaL1h5N3NLdmJpUWgxVitnUDJkZ3pTQnpxWVVzY0lBSU92?=
 =?utf-8?B?Y2xTbEhaTlFCSXpMYnc3WGdoOEluYVRGeFkzYytLWmpXNHZEUVdPVTVOUW81?=
 =?utf-8?B?cS9sNUJaakVLNENiOTYvSTFaeWhKeFNxWmNPNW0xb1BCZDczRXlxTUFIR0Zn?=
 =?utf-8?B?ZksvVnhTRnFZeE9ZdGFLQy80ZWNDeVgxcTBMRjdERUFvTmEwNzd0V085T3Er?=
 =?utf-8?B?YkFDVkJPK0o3dE1sT21WcXM1OGg4S3NhNHZvNFV3OWZLWFpLZWo5YVhHR2M0?=
 =?utf-8?B?aDZPWjZiNTl4c3B6enBMMCtjM3p1V0U0eXdtNWFVenRFNWtzY2thRWFoSE5M?=
 =?utf-8?B?bnM4MUpEYkVwTFRDNVFyNVFmT3FFU080MkNsL0p1RTlQNXhTYVE3VnJlaVBM?=
 =?utf-8?B?cC9nbHNuMGJhZFZJb0Fyb0RtbjBLQnNKMWdFQmpINzV6ZDJrS09FR1R1aHhv?=
 =?utf-8?B?ZDZkbmxldy9FL2VyelRObThWVHNWRG1uNFNpWXUxelRLSnJ5UWViMy9pQnlI?=
 =?utf-8?B?d2s5bnRVYjBOYmRmM0FOcGlMWmlCWmhRcVZySU04UUg4QzZGeGlEdmt5cjVm?=
 =?utf-8?B?NFZOalZYVExDY3FiQ1QzbXkxUE14UDNjKzNZNHVyS2RyZzBaa09QTlM1SlZv?=
 =?utf-8?B?OUp4TWhxbU8wL3hBVUlZdXFka0RwWFZ0ZWdWYjYwQWYyTFArN1FwMXZTR1dK?=
 =?utf-8?B?R2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4cece2-35ba-4791-2d8b-08db87c5c702
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 19:32:52.0990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dafnva9UwH3T23QzK7TlBk7EoMDW7H9ufAz+kkWahR+FjPgMmTD/ixEFX4W40ZaiGaBOe16Nzz4SfpAf8zO2WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3863
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jul 2023 19:33:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12415

From: Jan Kiszka <jan.kiszka@siemens.com>

We have now an official CIP kernel for 6.1, so switch over from the
mainline recipe. Also switch bookworm builds to 6.1-cip by default.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig                                       |  9 ++++-----
 conf/distro/cip-core-bookworm.conf            |  4 ++--
 kas/opt/{6.1-mainline.yml => 6.1.yml}         |  3 ++-
 .../linux/linux-cip-rt_6.1.38-cip1-rt1.bb     | 12 ++++++++++++
 recipes-kernel/linux/linux-cip_6.1.38-cip1.bb | 12 ++++++++++++
 recipes-kernel/linux/linux-mainline_6.1.15.bb | 19 -------------------
 6 files changed, 32 insertions(+), 27 deletions(-)
 rename kas/opt/{6.1-mainline.yml => 6.1.yml} (72%)
 create mode 100644 recipes-kernel/linux/linux-cip-rt_6.1.38-cip1-rt1.bb
 create mode 100644 recipes-kernel/linux/linux-cip_6.1.38-cip1.bb
 delete mode 100644 recipes-kernel/linux/linux-mainline_6.1.15.bb

diff --git a/Kconfig b/Kconfig
index 94e807a1..ec49631e 100644
--- a/Kconfig
+++ b/Kconfig
@@ -97,8 +97,8 @@ config KERNEL_4_19
 config KERNEL_5_10
 	bool "Kernel 5.10.x-cip"
 
-config KERNEL_6_1_MAINLINE
-	bool "Kernel 6.1.x-mainline"
+config KERNEL_6_1
+	bool "Kernel 6.1.x-cip"
 
 endchoice
 
@@ -107,12 +107,11 @@ config KAS_INCLUDE_KERNEL
 	default "kas/opt/4.4.yml" if KERNEL_4_4
 	default "kas/opt/4.19.yml" if KERNEL_4_19
 	default "kas/opt/5.10.yml" if KERNEL_5_10
-	default "kas/opt/6.1-mainline.yml" if KERNEL_6_1_MAINLINE
+	default "kas/opt/6.1.yml" if KERNEL_6_1
 
 config KERNEL_RT
 	bool "Real-time CIP kernel"
 	depends on !ARCH_RISCV64
-	depends on !KERNEL_6_1_MAINLINE
 
 config KAS_INCLUDE_KERNEL_RT
 	string
@@ -187,7 +186,7 @@ if IMAGE_FLASH && !KERNEL_4_4 && !KERNEL_4_19
 
 config IMAGE_SWUPDATE
 	bool "SWUpdate support for root partition"
-	depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB || ( TARGET_QEMU_RISCV64 && KERNEL_6_1_MAINLINE ) || TARGET_HIHOPE_RZG2M
+	depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB || ( TARGET_QEMU_RISCV64 && KERNEL_6_1 ) || TARGET_HIHOPE_RZG2M
 
 config IMAGE_SECURE_BOOT
 	bool "Secure boot support"
diff --git a/conf/distro/cip-core-bookworm.conf b/conf/distro/cip-core-bookworm.conf
index adafc92e..9bcf5593 100644
--- a/conf/distro/cip-core-bookworm.conf
+++ b/conf/distro/cip-core-bookworm.conf
@@ -13,5 +13,5 @@ require conf/distro/debian-bookworm.conf
 require cip-core-common.inc
 
 PREFERRED_VERSION_swupdate ?= "2023.05%"
-PREFERRED_VERSION_linux-cip ?= "5.10.%"
-PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
+PREFERRED_VERSION_linux-cip ?= "6.1.%"
+PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
diff --git a/kas/opt/6.1-mainline.yml b/kas/opt/6.1.yml
similarity index 72%
rename from kas/opt/6.1-mainline.yml
rename to kas/opt/6.1.yml
index 0dcf3364..ac12adff 100644
--- a/kas/opt/6.1-mainline.yml
+++ b/kas/opt/6.1.yml
@@ -14,4 +14,5 @@ header:
 
 local_conf_header:
   kernel-version: |
-    KERNEL_NAME = "mainline"
+    PREFERRED_VERSION_linux-cip = "6.1.%"
+    PREFERRED_VERSION_linux-cip-rt = "6.1.%"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.38-cip1-rt1.bb b/recipes-kernel/linux/linux-cip-rt_6.1.38-cip1-rt1.bb
new file mode 100644
index 00000000..a1ba50a9
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.38-cip1-rt1.bb
@@ -0,0 +1,12 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# SPDX-License-Identifier: MIT
+
+require linux-cip-common.inc
+
+KERNEL_DEFCONFIG_VERSION ?= "6.1.y-cip"
+
+SRC_URI[sha256sum] = "5e4dd386aa8a4cce341b8efeec76320feed53770ead67c838ffb321edd47b157"
diff --git a/recipes-kernel/linux/linux-cip_6.1.38-cip1.bb b/recipes-kernel/linux/linux-cip_6.1.38-cip1.bb
new file mode 100644
index 00000000..417de504
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip_6.1.38-cip1.bb
@@ -0,0 +1,12 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# SPDX-License-Identifier: MIT
+
+require linux-cip-common.inc
+
+KERNEL_DEFCONFIG_VERSION ?= "6.1.y-cip"
+
+SRC_URI[sha256sum] = "188c2ee35a13058858d71aa9121ad9f75c3834126bd93d019ab1687ce0027aa7"
diff --git a/recipes-kernel/linux/linux-mainline_6.1.15.bb b/recipes-kernel/linux/linux-mainline_6.1.15.bb
deleted file mode 100644
index 9b45f28e..00000000
--- a/recipes-kernel/linux/linux-mainline_6.1.15.bb
+++ /dev/null
@@ -1,19 +0,0 @@
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2018-2023
-#
-# SPDX-License-Identifier: MIT
-
-require recipes-kernel/linux/linux-custom.inc
-require recipes-kernel/linux/cip-kernel-config.inc
-
-ARCHIVE_VERSION = "${@ d.getVar('PV')[:-2] if d.getVar('PV').endswith('.0') else d.getVar('PV') }"
-
-KERNEL_DEFCONFIG_VERSION ?= "6.1.y-cip"
-
-SRC_URI += " \
-    https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-${ARCHIVE_VERSION}.tar.xz"
-
-SRC_URI[sha256sum] = "2c16dfe2168a2e64ac0d55a12d625ebfb963818bb48b60c1868c7c460644c4fd"
-
-S = "${WORKDIR}/linux-${ARCHIVE_VERSION}"
-- 
2.35.3

