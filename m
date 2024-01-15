Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62712C3DA79
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 08:10:34 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.52])
 by mx.groups.io with SMTP id smtpd.web10.72853.1705306225761493384
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jan 2024 00:10:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rVDpHZva;
 spf=pass (domain: siemens.com, ip: 40.107.21.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDZYEEcwiQ42J+ViIOAGTnE0CU8WzbxP+FlDsC8hlq+5g7YoA88ITAbF682o10MzwDvSzzMHdqFpQhAbGYl6Qa2X2Ks+SYFbjBfZcxu7YvGieSOl2AKzI+hi7vhZkBTtYASQ378nENAay68/CgWL580d8Wr48sSYqH53q/G7B1FIUNe+HndLmFgpQQivhLlSWpL2WyFeIi57P+JlPdM0Lx2sikrXsiU0wmKF2IRw4QH1XXr901gc7PzUTqY3VzL38vCQaHjrmxn135c8J9o4fQ9cy2QOa5HYrO9Md860ba1xJ790/bWXdheNYXNWtaFv5dl3p6L0pF5p7L3Ws19gtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWg7jrgxW774FjvL9Jnbooo1uVucQOGC8S3nroIocJQ=;
 b=FJbl8alIcEewtxOL4fEmMq/VeLk6+ETNYi5AuqH8TWI2ACnXu7uo0qLER0lvWJtwln9jdFO/QDF7j1mpcYVjyw+w1fuzkCZIeX96cXMusMmDdHBY+pdqcl7gZ4Nkcxu1JDbMptBioSKjAfabwMKoZxJII/fA8lGdS/VevBkur7tnuHWaXBFxyFVJgpzYLn927PSiku/qRBise469vOG+skhsl4ODlSCiYVLgCXOjhSOxoohXaByGPYZyL8koS+sHDRsy9cwHax6OG3fm7MoWh6PDxwxpapETAqtV0+vtFcRDcSkKUetHCBPlkqcCTlv1O0x7ggFUrsblNq0qI+m9Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWg7jrgxW774FjvL9Jnbooo1uVucQOGC8S3nroIocJQ=;
 b=rVDpHZvaMB6mC22CbsniEC2zSyTpOqIcvxqsJ8yCSKXurYol3AhlC9bsJ3Xh4AVjkV0C3eBnUHKhrzV12APeiRIjHPBZ+c8ncrc8R+eZ90CcCPgc8uWWh/KZ4OLeXQFE5GTj53UZJFysveJJWF8Y+ewwUiaYMuZev/HkrKBhZ9h3OsEiiFi1CXWc8+Am3rmSwlLdx49Ftft/qb6DJA7SpOYajjLSQkL+CyxWbMzLXa8WzKgyI47SeAILvv9d8af4Rpx3QFA9wKcrci9xEoKjYrUPFQAX5E4GHlRGSxfRGB+TXSRTLz9TM1FVjQonLtYlA7lEdXybJNxC7le6w6zAwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3529.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Mon, 15 Jan
 2024 08:10:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 08:10:22 +0000
Message-ID: <de204e94-5c9f-42c2-8d6d-951d2ad8fc4b@siemens.com>
Date: Mon, 15 Jan 2024 09:10:22 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] u-boot: Update to 2024.01
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3529:EE_
X-MS-Office365-Filtering-Correlation-Id: a1047928-7f7e-4926-9f48-08dc15a16bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4X0C0VMGoaaRfJU741qNz4xbY6HAwsaGvAbT+KtGWm7oXvGLQpL32hSMV5Sq69sTeqUcQnr5hcmxOC+DV342ZC9WNUem1TXSnRYled1ihePzljJ79CU9q0I2PZgFxtIg+FvyKMt6Jky9goKWCKKhwMkAtiXG11ZJn2+Z4dcyD+7xo4O47eGDjk6X5UtsVCBRwjJCCaKa+40dsALj+F38geJaxZT/dqSmJ3muF7qrzch8zNabDb00RBs+WDmvErFub7EgPkP5VA2GTn6UkMMoCQ0u0O6aSsh6e2SlzADXHj6ciR2xgoGlVOPRG8MZVbK+J50TtM0m/c32+PlQvJFmokA6A+qcqGCZUU4zLxiJmpO3qoWBjyHqdsrAP4oxeS+WzWMR3Sl72ckjGPQVaq8ByOkOYMruBICsKozrQUSDhizH/xV6XKxqARPPxoDGpKG39ztM+JO4zqa0TwtFfU8fk2i7ELu1PGOmOVpIGDx8LWIWz50DcrTWNj2oOCK/r+iw6+YxpGqrEM1fu+dyONoXn94fhk8il4vyvjExAscWtgbYwiqAqu68oINVh1a6hTiu6gWN7pxwYgltgI0RYIPiDmYgjkVgele3vpLqbilu7H+JxmPZNSHY6Hdq/ZUYDLE2oacTIuScB1iC5MfZehXM2w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(31686004)(2616005)(26005)(6512007)(478600001)(38100700002)(36756003)(31696002)(82960400001)(86362001)(5660300002)(2906002)(41300700001)(15650500001)(6506007)(83380400001)(66556008)(66946007)(316002)(66476007)(44832011)(6486002)(966005)(8936002)(8676002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a1gxY2tKcGlHbUtxSEc1MkhFZE43aTVFZU5hRWFQVktiMGVxSVpCVkpNSkRJ?=
 =?utf-8?B?dnlhNXQyRVArNDExd3d6UW56TXBkUkJrVm1oajZpVVZ6US9RRWhsOWVOem5P?=
 =?utf-8?B?a0xnd21nU2lrWkR2MUR3ZDdtZXpSdjlpbDhnQ3o4TXpEdG1oZDBhRE95NGEx?=
 =?utf-8?B?aVhmTnQreWNUUmFYMGo0eEFJUjBRYVZTNyszVzJzUHJ0VWEyaDRRREFUTS9o?=
 =?utf-8?B?Si9pQXlWMno0NGZ4NURXNFFZa01DQ09xcnkxK00vcWdxSEZuYWZyU01MaWln?=
 =?utf-8?B?OWQrRVV0TU4xZjBRTUhKNnRJV1JBRzJyamFxRzhMOFBUM3laUGRYZkZlMnlp?=
 =?utf-8?B?ZFZpc2pIUTk1dkowYkZDSkJOcHN4Sy9hSWV4eHBFYzFKR0tseGVJN1hZZC9O?=
 =?utf-8?B?eEJHaDdNYnIyVWRpcGNwd2hGM1VXb1pmQlZXeStiQXRublhwc085SW05djFM?=
 =?utf-8?B?VGtadktTalFmczU0blZYMTBsdDVMUHN1bWhxYmxBK1VneFlwYTAvMWF6SkNQ?=
 =?utf-8?B?YnF1Z0F0MGpadXgzUXE0cHVqd29aK1pFZG9maElNNk1lZGtmajdRUGEzUmhs?=
 =?utf-8?B?K2dKK1FCdXlHdk94MnFCVXdydkQ1SmhGcGlpQjhxMExDd3h4eEQ4T2RVaURm?=
 =?utf-8?B?L05wOFJnRC8wa1dIY25NbVkzeHpyMGxTczIxSm4rYlhzcU1ZenVpQmE5S0Y5?=
 =?utf-8?B?cHRnR2dhdW5uTkU5eTUvMC9vdHgzSEpEcmxlSjRHYWdSSlVqMWo0SWN5bkVW?=
 =?utf-8?B?eE9BWVJncmpCdzVyRkdKaUNuckZZWmljcDQ5OU14Y3hmWURqbmFrR2t2Tmtr?=
 =?utf-8?B?VFFjM2tmeWljcUY0VUozSk5yNVpNaVRHcTExM3MrYmpHeWdUMVJaYmE3aE9k?=
 =?utf-8?B?RU15azlrTzdwWkdyekR0NGE3b0d6RS9FOUhjVTErVnhwcnZkSExFQjhseDdC?=
 =?utf-8?B?RS9pNHdtcnpaaHp6RGJkL25QV0hFWUN1bkZnUkxQYUpoTlRvYUNGSHVNVlVN?=
 =?utf-8?B?dUJ1OTl3M3hmTDVHNjdERnZJNllhYk91L1FMUzZHYWVzbldqR1FibDI5eWIw?=
 =?utf-8?B?ZmV2ZHlxTjFId3F5N1U4VWh2bEt5Mkw5ZVNSUTcwSzlPTDZoa1pNTlVwUUNs?=
 =?utf-8?B?UkxPQjczTHlwZmZmSnNlVG5sQS9sYWY0WmZEZVVXOWllVmVNZXZxcjMyODdw?=
 =?utf-8?B?ajBwakdXSmxhZmI4dmhndjE5dTRyY3VtR2o1ZXF5TkhNWk9sVVJvTU4yMVlF?=
 =?utf-8?B?WHdJQTFmblhwV1Y1M1ZuZWtnNmtKQWovR3lYMCtqNkhDOVB5NDdGSUlyUFVO?=
 =?utf-8?B?VHAxemRHLzR1bFBwVGhwNy9jQjlPOG1iUUZzSWE4VngyOGNodTJEU1BuTlBw?=
 =?utf-8?B?S1p0MlRid1VmQXlPQTI0UnBTVnZsRUcrN2VwT3JnSVFVdTh3K05zd01MZ1dJ?=
 =?utf-8?B?Vkl1Q281bEQ0ckVCb1VmcEkxWHdHLzREU1BuR3d5U0RqNVk0ZFJDMHpuM0Jj?=
 =?utf-8?B?cDMrWEpqRDRBbTVhSXVqQXhyZEJadGRIMldrdDRJbjd4blFQWWV6YzZYYlpT?=
 =?utf-8?B?bUpGZ01Kb091RVZlSzdUYk5NNkhESnpwNENEUjdRbEFFQkx3Rk83N2EvZ1c5?=
 =?utf-8?B?eGVoV05tci9iaFJDdGtWQUZDVGRud2NCSkxacmRrcTYrUXlQOWl0S29mUUZj?=
 =?utf-8?B?R0FMdzZnUGlVTXE2Zk4rNjlycGRPTVpPMW8rTFVTMHdJRjcrNUFZOE96M09i?=
 =?utf-8?B?bUUzR0I5RkRGcERmWlJCL1puK2RkRXVaWCs1UEpRT3V4SU9yRzQwcy9BekVB?=
 =?utf-8?B?VHlOT2JqMEJRZHZkbW4wdncvYnB1Z2s4S2dXMGgxc1lET3FBWTVBTU5hY3Zl?=
 =?utf-8?B?cVA0QVVrU3NyRW10S2xjak5Fb3lCcUdtdjQwQ3M0UWoycW4vRXE1YnZ4SzBR?=
 =?utf-8?B?VDN6TzBSeThOU2NKK01MVVNaazBLSWRkRDVlRUszdUN1Vmd3MHpqUW96OSt1?=
 =?utf-8?B?bkk4WU5CbDhzamYwcmRpUmJhNkR5OW5nTVRHSTlONGRuTU51dFZjWituNUty?=
 =?utf-8?B?SDZEdDhHVDR3cEVVam5GUXJpVW8xVU5VVFB3YnZGRXBWL29PYzN3WllzNEtH?=
 =?utf-8?B?ekRPbngrUm9zbzAwWWlJZ2FwMFlQSnd2bmVOVDdOZWFpRUgyb1lMNDBtV1FE?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1047928-7f7e-4926-9f48-08dc15a16bf1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 08:10:22.5445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EaN66GQCjzGj/A/V0nqXj4eML2CMXunbHUioXDywpyAq5FA7uOn2Q0Z/DCdNZ4l7iVhXghsggHAl/QWPdqdCFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3529
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jan 2024 08:10:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14378

From: Jan Kiszka <jan.kiszka@siemens.com>

Allows to drop the riscv patch.

u-boot-common is actually version-specific as it carries the sha.
Reflect that in the file name. Using ${PV} for its inclusion only works
directly, not via u-boot-qemu-common.inc, so do that from the respective
.bb files.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...iscv-Fix-build-against-binutils-2.38.patch | 55 -------------------
 ...t-bbb_2022.07.bb => u-boot-bbb_2024.01.bb} |  4 +-
 ...t-common.inc => u-boot-common-2024.01.inc} |  4 +-
 ...022.07.bb => u-boot-qemu-arm64_2024.01.bb} |  1 +
 ..._2022.07.bb => u-boot-qemu-arm_2024.01.bb} |  1 +
 recipes-bsp/u-boot/u-boot-qemu-common.inc     |  3 +-
 ...2.07.bb => u-boot-qemu-riscv64_2024.01.bb} |  6 +-
 7 files changed, 9 insertions(+), 65 deletions(-)
 delete mode 100644 recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch
 rename recipes-bsp/u-boot/{u-boot-bbb_2022.07.bb => u-boot-bbb_2024.01.bb} (82%)
 rename recipes-bsp/u-boot/{u-boot-common.inc => u-boot-common-2024.01.inc} (87%)
 rename recipes-bsp/u-boot/{u-boot-qemu-arm64_2022.07.bb => u-boot-qemu-arm64_2024.01.bb} (88%)
 rename recipes-bsp/u-boot/{u-boot-qemu-arm_2022.07.bb => u-boot-qemu-arm_2024.01.bb} (88%)
 rename recipes-bsp/u-boot/{u-boot-qemu-riscv64_2022.07.bb => u-boot-qemu-riscv64_2024.01.bb} (71%)

diff --git a/recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch b/recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch
deleted file mode 100644
index 6f8a2ae0..00000000
--- a/recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch
+++ /dev/null
@@ -1,55 +0,0 @@
-From 5df4b2299f86933fa79aa3bc6a3986fc7e55b7e0 Mon Sep 17 00:00:00 2001
-From: Alexandre Ghiti <alexandre.ghiti@canonical.com>
-Date: Mon, 3 Oct 2022 18:07:54 +0200
-Subject: [PATCH 1/2] riscv: Fix build against binutils 2.38
-
-The following description is copied from the equivalent patch for the
-Linux Kernel proposed by Aurelien Jarno:
-
->From version 2.38, binutils default to ISA spec version 20191213. This
-means that the csr read/write (csrr*/csrw*) instructions and fence.i
-instruction has separated from the `I` extension, become two standalone
-extensions: Zicsr and Zifencei. As the kernel uses those instruction,
-this causes the following build failure:
-
-arch/riscv/cpu/mtrap.S: Assembler messages:
-arch/riscv/cpu/mtrap.S:65: Error: unrecognized opcode `csrr a0,scause'
-arch/riscv/cpu/mtrap.S:66: Error: unrecognized opcode `csrr a1,sepc'
-arch/riscv/cpu/mtrap.S:67: Error: unrecognized opcode `csrr a2,stval'
-arch/riscv/cpu/mtrap.S:70: Error: unrecognized opcode `csrw sepc,a0'
-
-Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
-Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
-Tested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
-Tested-by: Heiko Stuebner <heiko@sntech.de>
-Tested-by: Christian Stewart <christian@paral.in>
-Reviewed-by: Rick Chen <rick@andestech.com>
----
- arch/riscv/Makefile | 11 ++++++++++-
- 1 file changed, 10 insertions(+), 1 deletion(-)
-
-diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
-index 0b80eb8d86..53d1194ffb 100644
---- a/arch/riscv/Makefile
-+++ b/arch/riscv/Makefile
-@@ -24,7 +24,16 @@ ifeq ($(CONFIG_CMODEL_MEDANY),y)
- 	CMODEL = medany
- endif
- 
--ARCH_FLAGS = -march=$(ARCH_BASE)$(ARCH_A)$(ARCH_C) -mabi=$(ABI) \
-+RISCV_MARCH = $(ARCH_BASE)$(ARCH_A)$(ARCH_C)
-+
-+# Newer binutils versions default to ISA spec version 20191213 which moves some
-+# instructions from the I extension to the Zicsr and Zifencei extensions.
-+toolchain-need-zicsr-zifencei := $(call cc-option-yn, -mabi=$(ABI) -march=$(RISCV_MARCH)_zicsr_zifencei)
-+ifeq ($(toolchain-need-zicsr-zifencei),y)
-+	RISCV_MARCH := $(RISCV_MARCH)_zicsr_zifencei
-+endif
-+
-+ARCH_FLAGS = -march=$(RISCV_MARCH) -mabi=$(ABI) \
- 	     -mcmodel=$(CMODEL)
- 
- PLATFORM_CPPFLAGS	+= $(ARCH_FLAGS)
--- 
-2.30.2
-
diff --git a/recipes-bsp/u-boot/u-boot-bbb_2022.07.bb b/recipes-bsp/u-boot/u-boot-bbb_2024.01.bb
similarity index 82%
rename from recipes-bsp/u-boot/u-boot-bbb_2022.07.bb
rename to recipes-bsp/u-boot/u-boot-bbb_2024.01.bb
index 6632bb6c..52dec142 100644
--- a/recipes-bsp/u-boot/u-boot-bbb_2022.07.bb
+++ b/recipes-bsp/u-boot/u-boot-bbb_2024.01.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022
+# Copyright (c) Siemens AG, 2022-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-require u-boot-common.inc
+require u-boot-common-${PV}.inc
 
 U_BOOT_CONFIG = "am335x_evm_defconfig"
 U_BOOT_BIN = "all"
diff --git a/recipes-bsp/u-boot/u-boot-common.inc b/recipes-bsp/u-boot/u-boot-common-2024.01.inc
similarity index 87%
rename from recipes-bsp/u-boot/u-boot-common.inc
rename to recipes-bsp/u-boot/u-boot-common-2024.01.inc
index 0486cdaf..163532b0 100644
--- a/recipes-bsp/u-boot/u-boot-common.inc
+++ b/recipes-bsp/u-boot/u-boot-common-2024.01.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022
+# Copyright (c) Siemens AG, 2022-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -14,7 +14,7 @@ require recipes-bsp/u-boot/u-boot-custom.inc
 SRC_URI += " \
     https://ftp.denx.de/pub/u-boot/u-boot-${PV}.tar.bz2 \
     file://rules.tmpl;subdir=debian"
-SRC_URI[sha256sum] = "92b08eb49c24da14c1adbf70a71ae8f37cc53eeb4230e859ad8b6733d13dcf5e"
+SRC_URI[sha256sum] = "b99611f1ed237bf3541bdc8434b68c96a6e05967061f992443cb30aabebef5b3"
 
 SRC_URI:append:secureboot = " \
     file://secure-boot.cfg.tmpl"
diff --git a/recipes-bsp/u-boot/u-boot-qemu-arm64_2022.07.bb b/recipes-bsp/u-boot/u-boot-qemu-arm64_2024.01.bb
similarity index 88%
rename from recipes-bsp/u-boot/u-boot-qemu-arm64_2022.07.bb
rename to recipes-bsp/u-boot/u-boot-qemu-arm64_2024.01.bb
index 29ca0a55..db47ee93 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-arm64_2022.07.bb
+++ b/recipes-bsp/u-boot/u-boot-qemu-arm64_2024.01.bb
@@ -9,6 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
+require u-boot-common-${PV}.inc
 require u-boot-qemu-common.inc
 
 U_BOOT_CONFIG = "qemu_arm64_defconfig"
diff --git a/recipes-bsp/u-boot/u-boot-qemu-arm_2022.07.bb b/recipes-bsp/u-boot/u-boot-qemu-arm_2024.01.bb
similarity index 88%
rename from recipes-bsp/u-boot/u-boot-qemu-arm_2022.07.bb
rename to recipes-bsp/u-boot/u-boot-qemu-arm_2024.01.bb
index cdad19a3..621cf01b 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-arm_2022.07.bb
+++ b/recipes-bsp/u-boot/u-boot-qemu-arm_2024.01.bb
@@ -9,6 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
+require u-boot-common-${PV}.inc
 require u-boot-qemu-common.inc
 
 U_BOOT_CONFIG = "qemu_arm_defconfig"
diff --git a/recipes-bsp/u-boot/u-boot-qemu-common.inc b/recipes-bsp/u-boot/u-boot-qemu-common.inc
index b222155c..0bf7b621 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-common.inc
+++ b/recipes-bsp/u-boot/u-boot-qemu-common.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022
+# Copyright (c) Siemens AG, 2022-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -10,7 +10,6 @@
 #
 
 inherit deploy-firmware
-require recipes-bsp/u-boot/u-boot-common.inc
 
 U_BOOT_BIN = "u-boot.bin"
 
diff --git a/recipes-bsp/u-boot/u-boot-qemu-riscv64_2022.07.bb b/recipes-bsp/u-boot/u-boot-qemu-riscv64_2024.01.bb
similarity index 71%
rename from recipes-bsp/u-boot/u-boot-qemu-riscv64_2022.07.bb
rename to recipes-bsp/u-boot/u-boot-qemu-riscv64_2024.01.bb
index 8dfac457..1cc0afdd 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-riscv64_2022.07.bb
+++ b/recipes-bsp/u-boot/u-boot-qemu-riscv64_2024.01.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022
+# Copyright (c) Siemens AG, 2022-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -9,6 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
+require u-boot-common-${PV}.inc
 require u-boot-qemu-common.inc
 
 # we run as OpenSBI payload, hence use smode
@@ -16,7 +17,4 @@ U_BOOT_CONFIG = "${MACHINE}_smode_defconfig"
 
 EFI_ARCH = "riscv64"
 
-SRC_URI += " \
-    file://riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch"
-
 U_BOOT_BIN = "u-boot.bin"
-- 
2.35.3

