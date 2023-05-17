Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD55C77B7D
	for <webhook@archiver.kernel.org>; Wed, 17 May 2023 06:19:47 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.87])
 by mx.groups.io with SMTP id smtpd.web11.43375.1684304386384198431
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 May 2023 23:19:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=EJIYKMxd;
 spf=pass (domain: siemens.com, ip: 40.107.241.87, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfrhTBc3Kp91NBbuO4+i/O4wV9ava+yl8zMmeGhjz749VxBVA7schGi1ebvzzpHS26t6DWymwmXyHsHyibrEj0Q7aw4pnX6R5PAinib/k5GlPBMwwnE47DkX18+cHYe99vU5i9BPwq1zzVk/uR+4iod1fSB0+MLteUwJ52AAx7grvRk+LCqzF1i+grLjRITsEm0XCblHZgwXNzJ9KfBayjiqWeRijpshU7fX9JbhCJTJ72wjKoeMGggZ5CpzrdwHNEokJDm5/gDDFmipZWYCwy53jy/t0B3Ob5y5tlk44uJw8lvgblMiF33NXQdaBNmdpPYyKlzuyIz89vmFwFyujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RikYGoDmP4fGPEeQYDZRa39WcznmzhYqyXnksmTD6Cw=;
 b=S9rDkW5NUqKrmXrquMGp1wU2cgCYA3mpPx6fgsL9IfMdqAKV5x3dcNXWf0c+iTzc2YypIf2AkfkpGmGWHA9pzr5E5KcUh6ggyUrU5vHFe6h9cJg7x31lKujfAUQWnoiR5TMmjtNLdRK89mTkALOs+WSlHX8kn5rxXJm0K4Th+q/6NLTlQpcZOSvpbXbulzMdAR0TtIUPsZ9n2L+4YEUuXCyQvwbEl5Xg8HpygrvWji32lJPhscOGC2zc0TWqa35frEP5vaE0imSUGAdLspoUxiKshF0igOL9dvfcwPAnRIC5/POOEMbDEtaSlNCjqrpGwYnHbMYQBog2rS9MyrAnXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RikYGoDmP4fGPEeQYDZRa39WcznmzhYqyXnksmTD6Cw=;
 b=EJIYKMxdsa4oxpXxs14KEpODi7rQaRnwGxSpU2JcMOnZQvFn4pXYuWeMw6lA/9bpZo30n8aK5VnJMfRmao9r7T7BxPn3Xzv8puaFhk/aPo+TBkj4Js/pG4dvNP5MlGdznsAX5QqXpMW47Uglz/hsKwc/olLPICwLNVKwHoZR8sYizrBGIw72bOKP+suG4UvzEygRbeKMRTRhVT5xuVitjvB9ok47c7RRjFo0tAik5q4Z4jsJX0XgSwAYsb1SuNfaD7EvFeCCkOmCENlLjxnA03KstEKMhBLmTNbrycqEYFHpm4TLOdnhRL7ESakaFtzY1T5V94fixNV35ZuXerEpZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3601.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:158::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 06:19:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%6]) with mapi id 15.20.6387.032; Wed, 17 May 2023
 06:19:43 +0000
Message-ID: <f1be8d8c-d58d-715f-b6c0-39d76826450e@siemens.com>
Date: Wed, 17 May 2023 08:19:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] linux: Factor out cip-kernel-config and use it
 for 6.1 mainline as well
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3601:EE_
X-MS-Office365-Filtering-Correlation-Id: 99507134-f2ec-4090-ecd6-08db569eb41a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ytMijFm6JbilK8SauZjRgxsBBwuzIJkDwaFNo2agr96Hq15Yd9MpIV5rREfkAQltJF6uBg6YUyc+uVV4FZ1u78OE3ppETfFtePekLjhdp2hJmTstP/QiiTXjcqNtB56E1Q2hYmJ8axh6+B2IxzgD86KBpkDTmWTFT+pu0v3xFjfIAT8iAi+W6UKCdDAi+rP8ZWOUIMKy2unhEaYWWFbTtpXBNzyyeWkyyw+/KYpshffMgIy/djQYhE58cFi4rFvXeAiwKTGQrXRGREuT0oYd9dfE9MytDVNNzDH1xiGnhMCPD97dpdm7CUOSo1qi0yr4V6WGj5Ev+K8Ce0XtrU0eQEWCmejrp9dlwGHKQzUDXhzaNK/mpgTL7WPiwhiPudod1aqf9Ij9No+ZbBp0KsS+RYJLZCKhrgPxsrgtkemx9XSUPmTqX1Oua1zni98bD1Su9jbADvRSqoyk6aiC6K399GNwRuBpaBtMJp/EyyHysONk7GRyhKDMH8k/YViR/czkw57HTfSOuUYMO7tjY88FBHQIUUIJM8KjApN6IcT+blDz98hWSBg2aeY90Ia9dZI2IYO3Upp+mx6+U7rRbsKhKwo6KrzNaS9pQ7tl4hkqNB2FMrvmaJMdS+LE17UnVqdPcAIUFiG1fNXBRzLjZWZkoQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199021)(31686004)(82960400001)(41300700001)(8676002)(2906002)(8936002)(36756003)(6916009)(5660300002)(31696002)(86362001)(316002)(38100700002)(66476007)(66556008)(66946007)(83380400001)(966005)(6512007)(6506007)(26005)(186003)(44832011)(478600001)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bzUxSHE2Zk9oR0t1L3o5dHg4QVlYamF3TTNpVlVJMFF5eitneWhnU0huYkwy?=
 =?utf-8?B?bGowNVMwK3dKZUhKdUtCR3hGekdheDR5bG5RUTdkNzlLVUxEMy9EdzhXQXdu?=
 =?utf-8?B?SENISWZVeXVzUGlOdUw3NzRJR2g1NmRIVGJmYTY3MjJ2Z2QzQnk2MHFlSVB6?=
 =?utf-8?B?YVUySWJZSlZKWVZlRGZrdGNSaVVTRkMxNSttTDNZQzhRejdnaitJMENSWjcw?=
 =?utf-8?B?KzB0M2Fhb29VZVFYWXRseWhiTDlmQllhcnRFaHVHeXdHN2R3Sjlwc28rMVhT?=
 =?utf-8?B?ZUptb2VYTTh2NjBRTFVwTndxUG1nOUFyS1RzWEExWGttUkhCcjIvZmM0amxO?=
 =?utf-8?B?OW50TUFFRndUek41aU1tcERuSHNUOFJhcW14OERQNEJnRzNFWGxqaHhoZ29E?=
 =?utf-8?B?OVVUcjh4STJXSzN6Qk95Nm5vSlM5Vnd0NWtHaVhTZzJsMG1QazFIajVmTXFN?=
 =?utf-8?B?bHhWRURPNTlKV3NVQmZMdGsxNHpNb1h2eldsaDlhem56SFBQNTBJS0IrOE1y?=
 =?utf-8?B?aWExVjg2K2hTRlI2Z282RHN6em9lWEZwUjErK3dGSXhUaEowRE9VajlhUENk?=
 =?utf-8?B?WHZXMlBydEVyTnJiOVFTYkJob1hvRU8zaFNvaVVrdXlMQmo5VklEUlYyQnJH?=
 =?utf-8?B?SjhCTE5qeVpMRDdzaHhXNzQ3UGVCU1RqUHRyRjBMNDdRd0d5R0hXVUs4MnZl?=
 =?utf-8?B?M21XeThBVStydFRhbzE4NWhBMGhCRHdlSWptcXZ4ZDZ5WSt6SDRCWEJVV05z?=
 =?utf-8?B?b0g0L0tCN29qYkdMdFRENm8rT0pZb1RFbjhFNTVtVnJXMXRBRWVnZGprTWYx?=
 =?utf-8?B?M1AzbGFYWlBqRDk1c0FTODBFNnMyMGcrRm0xNzRlNFJjNGs0YkFoTWZTT2to?=
 =?utf-8?B?a0w1YW1mdjR0Y2pQMGxKWENCTTFsbXlSNC9FWFR5bUE0Z1BXb3NyMHJkWUFU?=
 =?utf-8?B?d3hOdWRoZ0ZIZ2xhY3VXRmFYVWV0Ym9CRGowSjdDMHhjNkxRYWtmRlNXcGZ5?=
 =?utf-8?B?UGYzSkxBYWR5SERidnBDQTF5bDdyVkJMdDhURENrNTFwWVAvZ01PemI2V2Zn?=
 =?utf-8?B?ZnMvb1pkSEU2UWJXc29qVjRzZU1nM2t6Yng5UFczT3BoR2s3K1Q4YWVkalNo?=
 =?utf-8?B?ZFdTS0tLbmhzWmhSc2FQZm5YUitvOEZhN0kvd0ZCWDJMZDBqSCtqOGUvTi81?=
 =?utf-8?B?ZnhMWnlyUjljeS9EREZhUnVPNmx0ZW9WbDZHeDc4ajNmK2hSNFpPbUtKcy9p?=
 =?utf-8?B?dGZaZk5xakRUY01vM0RZekQzQUlzc0dEamtsWVdSK0dGdThLM0JCQTNBZ1dp?=
 =?utf-8?B?enNoSDZSdENXYm9Lb3JQYVJWT0VYTUdCL1RYeE55cGNLQ3BIaU5ndDdTWWNS?=
 =?utf-8?B?RjZvMlNFdi8zL3J6Tjk4bnZXQzgvSDg4ckx0WTRibWxnNlh2VklZbnRZM2I5?=
 =?utf-8?B?elBtVFI2NUdUNFpTRzN0d2Q0ZWYzLy8xRlY3YVF4a284bDNtMVJOYitNbGRi?=
 =?utf-8?B?dVgxVkpQOU5FakpId0M3azduaWR4ZCtsanhrQzdBM0RhcW5XeTc4OUlWaGlq?=
 =?utf-8?B?KzlDNW1kcWx2VC9CbnJCa0g2R3A1SGswT21lMWVIV0huczJ5RHllNVVDOUM3?=
 =?utf-8?B?Y0FYWDVZbi9uSTQ3ZmZYY3hnNGQ1Rk5hc2R2UXBiZ0V3T1lVL3hORU9nUE95?=
 =?utf-8?B?eHc3azlYQnd5QU82WUxQWkpCZXNDWGlkbFp4WG1DMjBrWFhlWm1WcVZabHRs?=
 =?utf-8?B?U0xXS1RoK0RqTWtIYlUvd2ZsM3FRaCtvTTEwNVg0STEvRk5NNDdyc0VzWWdW?=
 =?utf-8?B?Z2p3TExhWXRiM2J3TXJrWmoxbi8rTWIyNTdZSTJFazRrWDgyZ2ZIdFhCUUdj?=
 =?utf-8?B?aTlSRWFJZzJYQjQ1WHNnV3FyMFV6WWM2eEk3dHpxUmY3MktnMm0xRDJOckh0?=
 =?utf-8?B?aURzMFZ1bTJwRkpvaGpFV0ZIRG9SRWhCZ0tkVll0WHpyVWhYcS9HdXNOTlFH?=
 =?utf-8?B?bmVkUnRWT3dVNmowRU1EdmF3RmNPQnJXQ2dZcHZKQzVqbVNFbEdmMkpjcTFr?=
 =?utf-8?B?NDJKVlJpdDlvd2xGOFNCMzBISFV6MzN6ejZVQ1ozU0lZM1IvYy8xckt6U08z?=
 =?utf-8?Q?rJueidDM0jkbvlaPPHEzbdxAR?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99507134-f2ec-4090-ecd6-08db569eb41a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 06:19:43.0615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hzu0NhZ3ykpkvKo8np9a4YaL77szzFO57V9Ly6P+nFakah9HR4OugyEJeWwAMgOBqHPGs+8jrBqK2pi6idf+Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3601
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 May 2023 06:19:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11483

From: Jan Kiszka <jan.kiszka@siemens.com>

This fixes the build of linux-mainline for targets that have
USE_CIP_KERNEL_CONFIG set.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/cip-kernel-config.inc    | 17 +++++++++++++++++
 recipes-kernel/linux/linux-cip-common.inc     |  9 ++-------
 recipes-kernel/linux/linux-mainline_6.1.15.bb |  3 +++
 3 files changed, 22 insertions(+), 7 deletions(-)
 create mode 100644 recipes-kernel/linux/cip-kernel-config.inc

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
new file mode 100644
index 00000000..329b9f7e
--- /dev/null
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022-2023
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+SRC_URI:append = " ${@ \
+    'git://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git;protocol=https;branch=master;destsuffix=cip-kernel-config;name=cip-kernel-config' \
+    if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
+    }"
+
+SRCREV_cip-kernel-config ?= "d1efa37258380c7f4f39a8dee1bdb4d85f1c0199"
diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index a700d30e..c0f076a9 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022
+# Copyright (c) Siemens AG, 2022-2023
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -14,15 +14,10 @@ FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
 KERNEL_DEFCONFIG ?= "${MACHINE}_defconfig"
 
 require recipes-kernel/linux/linux-custom.inc
+require recipes-kernel/linux/cip-kernel-config.inc
 
 SRC_URI += " \
     https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/snapshot/linux-cip-${PV}.tar.gz \
     "
 
-SRC_URI:append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git;protocol=https;branch=master;destsuffix=cip-kernel-config;name=cip-kernel-config" \
-    if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
-    }"
-
-SRCREV_cip-kernel-config ?= "d1efa37258380c7f4f39a8dee1bdb4d85f1c0199"
-
 S = "${WORKDIR}/linux-cip-${PV}"
diff --git a/recipes-kernel/linux/linux-mainline_6.1.15.bb b/recipes-kernel/linux/linux-mainline_6.1.15.bb
index f6cd7b8b..690f6dd0 100644
--- a/recipes-kernel/linux/linux-mainline_6.1.15.bb
+++ b/recipes-kernel/linux/linux-mainline_6.1.15.bb
@@ -5,9 +5,12 @@
 # SPDX-License-Identifier: MIT
 
 require recipes-kernel/linux/linux-custom.inc
+require recipes-kernel/linux/cip-kernel-config.inc
 
 ARCHIVE_VERSION = "${@ d.getVar('PV')[:-2] if d.getVar('PV').endswith('.0') else d.getVar('PV') }"
 
+KERNEL_DEFCONFIG_VERSION ?= "6.1.y-cip"
+
 SRC_URI += " \
     https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-${ARCHIVE_VERSION}.tar.xz \
     file://squashfs.cfg"
-- 
2.35.3

