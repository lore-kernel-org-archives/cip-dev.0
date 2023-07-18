Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D410DEB64DC
	for <webhook@archiver.kernel.org>; Tue, 18 Jul 2023 19:32:55 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.62])
 by mx.groups.io with SMTP id smtpd.web10.5044.1689708768598621981
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jul 2023 12:32:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=X61sKvDX;
 spf=pass (domain: siemens.com, ip: 40.107.21.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahrHSOm1oqN1MWhsmaG6fvdQpNF8R+YWjSaciWgGdwKKmZFwwqrzljjouKSbiZwrg0NRNHHX50GpWZHpUp2nCDdyIPbEczxKaxfx03TYNJsxE2nglcSNes8C4fpZwIub1qce6V3oZ+iI4GKQtEP+9M079V8He1gJ5hzZ4xjJ3q90DAczoCOTyrIBmPrN7nf9OrvC/cCXTqRggXlrnwBlKKNCQz3lZrYrWmxFn2t41QqjOscGqsm41JF26U3uHHGvIw5MCWa/qHHodyggn9ON29ehQpdxl6kUXOk4Rh3mf5dS1CrrOJH+VmQSa6U/aP5ZDDe4rSYeJ9BQcUk1upFSLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNx5UWQYAVZYHGKyu09IHGGtUH3er7N/5osS8amBeq0=;
 b=boiBy22CcRPRt4tECnQ0g3rhKY6A967KeJHRTv6Q39u2z4F+MjyiWRuM+xOrDz4F8uiaVrYk5yX8oDn86Zz/NqlscvYxvsn/yAep9valgo0yHL0ms5B4T6HltG8MMTzaylcMLjlKVrTNdzX2wKOvJtM/VEa6ePzKLlzNqGwQJEqyEtsiAZDGWoldSlT7vpMIJ/ggZ/L2GvGd6GCw1XffPY8k0obH+LTdIm5ZihOW02aoChLzTdcy3SA+heYH4Jn1KS+VCwfsYBP+YwYBLLV7zB99CcYPOwOTvkmbuTkz5ZdU00Cz3SNhx2qWhDnmz2yHOdijVvBWprNsDquAJV99aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNx5UWQYAVZYHGKyu09IHGGtUH3er7N/5osS8amBeq0=;
 b=X61sKvDX62f5fgXcAiM3p8Vdfbze1HSUWNQrQ4WeEUxkrWM+Sfth/qzSiRncB6lBU3XBs3CxO8v6T2xlqWfXABf2euxOBKxOw3oe3LiiQFplGo+KQo5O0cNVPcGIweOzFMh66T8ArMxYXTggrl8DeYSxKGyTCDblggggUHDxghptVPzoMnMdHYUCjNUVG98L0kx6hseqJMxWngPL+MQKgXa4uEnx1xGuV3aktOtnueyt0lMNZgJUTXHlAOJdA9Anp+bZvB5TKOYGqpbNJnej56jpE9AUzKuwOsCHkHnBLJQJk0cWAHFbcBwCnVD1hwJmMkQ0a7+YPjGK8Blh9RLuAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3863.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:168::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 19:32:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::77d2:3a68:9741:67cf]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::77d2:3a68:9741:67cf%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 19:32:45 +0000
Message-ID: <dd337a88-1d57-6d61-0412-a42a8de26939@siemens.com>
Date: Tue, 18 Jul 2023 21:32:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update 4.4, 4.19 and 5.10 to latest
 releases
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3863:EE_
X-MS-Office365-Filtering-Correlation-Id: 7411fd1a-3b34-41a3-900b-08db87c5c2a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QoUYsEp39nWH27e04bEuQFfCZ/iRkakL32iOKpBVqWCpv6IArVYJgSlAmUR/oQ/xpsW39Cnnk7yQEUU5FY2wA9FeeuAG5qCTCWne4W8/HeZgYve+Wo1i9QLDvxftqNAxxLZJfhLTdFEPUqQzxUuAuh2rV2vAy8qxtI7Dcj8fsB5lQnqjuFD+VkkPfQchrYW0ovyAbeFK0e7Qb+hdY/x6hQgBmVBqoAQu6zpCOE+Q15ItysCJACKB4XjBWeFqihJZUnfU187YeWtw8paRO1/zaAhdJf+q/CTnmbJowgNxnCPGqBer6WRtB0bIchwPrRjeAphK33Wbj3lHvEyjVbKJgQ9kwnmNOxmn/K6KNzXAE3Z/X6+1sB+GX8Tb+Xh4Ex44Ilyv6v4ih4SSSqWic5ShIMjUZhMjjHGhcDWWBXVbnl/L9ime4P52G3JeMU3tRAackH4BJOqudbSwjLyNGocOle28mgy+OivBpXUVUdvinggnmUZMMNCi4332fQfVdVhxwK//4G2OrJ8CYfHtXVIKG7lM1mwJYajbSbmIEgqELTUvG9sjzstxS2Z4GFzzz3xDKTE3GWO6UdqXlB23rqiit3JTFZENOZtQ1GGC4Qxvj4VB/4Hazk5tFRzwtYL7CbznSopxArsVJm9XyqtCPzA38w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199021)(26005)(6506007)(41300700001)(316002)(83380400001)(31686004)(2616005)(186003)(6512007)(6486002)(82960400001)(478600001)(6666004)(44832011)(66476007)(66556008)(66946007)(6916009)(38100700002)(86362001)(31696002)(5660300002)(8936002)(8676002)(36756003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SUhGQTNWbGZjcGQvVnZONlhnSzVyeG1aR092cHhmMlN4VTZGbElCbG9wNW5Y?=
 =?utf-8?B?ZW0wUlQ4YmZJbWxuQXp3SkZNRG96Z3A3c2dUR1lYdHFoQlNqdHFwYU9RUk1y?=
 =?utf-8?B?Rys2Zk92REF2R3NENE1vc3FjMk5iVlV1U3Q0T3VXSlRUdDlmaFVJYXZBa3Nv?=
 =?utf-8?B?R3kydXJRNkdQYjR0WVVIeXEyb3BPWk5FUWFQd3pMUk5jbG5oTExiL1FUVE14?=
 =?utf-8?B?dGN4NkVpVmNFc09yOWw2Y2RQa2Q1SGNOaWhCZkkrMUd1Mm93OVptVUpVVzdl?=
 =?utf-8?B?c3I3Z2ZXdGptbWJzQmhNY1RrajBJTmlEMW9SUEhoNU1rOXcyeUtFZytlNi9Q?=
 =?utf-8?B?bUd1VVRPWitEaTFndUt5TGpBZzZLU1REdW96MStGKzBUNXBGdnA4bm1xcFJ1?=
 =?utf-8?B?a0dteUR2Qkt1em1hMEdPRVpWanhHaUJmMzNwaDY4aFBqdUV2Zmp3SHg3SXVI?=
 =?utf-8?B?SHRXUjhCZjkwRm5ESFAzS3lpRUZxaDc5Sm5KVzVFNXgzUWVXNXRidzdnV1pI?=
 =?utf-8?B?S28rQW01VnQ4aFAreHVTTXNTSUhHYkw5UDlKM1Z1K3NUSUF4bjBVVVNmSjJw?=
 =?utf-8?B?ZW9kWG9QZmUvT0NqQzRwL3pJaE1QMVp3OGtGM2MrcGIza3FDdzdzQkpyYWFQ?=
 =?utf-8?B?emoxVTBlZW1mcFQxOUU1YVJySjdPYnRWd01iSitKVG4vZ2h5aDlCOE9LODNk?=
 =?utf-8?B?ckRTSEdXWnZDc1lBZnJDaEdiMDE4SVdwN1RYdS9jNWZKWmFyMGtIYkFiWjlG?=
 =?utf-8?B?OS9vUGIyR3YxNkM5NmRiVmlIN0xuc040cFNrSXRPNjByY2pZekxkOVg4QTNO?=
 =?utf-8?B?cnVTRW42ckhWanZHZDJPOFBoeHhiNmNmYjEzbGZxUW0yYlpVMGdvQ0Mrb3VE?=
 =?utf-8?B?NUFQRXBTaGV0SGZ6aUFwSDlVSDJLQlc0cnVBU3NwTGF3b0tiaHRsbnNhaDA1?=
 =?utf-8?B?Rk5ZWEdmMTZEN0hYbG9oUm4zZGdtTjAxOGpDZ29oV3cwcHJRbkNyYjI1d0RN?=
 =?utf-8?B?T2tIdzlJTndJVWRqNjVOYmlDOXd6MUE2RDl3WlVIcmZPYW5kcmMrRlluSUJS?=
 =?utf-8?B?VXVCdFltcFd5Z0orR29mRXVOVU5SV282c253QnRLVmVtcmVPZUN3NHVNeThD?=
 =?utf-8?B?TXVpQWY1QmFoeDloSEUwUjlKUGdRcnhEWE9IVU9FTVE4RVhZUlAwVUlSSDVM?=
 =?utf-8?B?akNhOGJXbk01T3Q3ZE9uQnpBOGVLV1J5YXRLZWFpRnJyNUpscVpRVzBUc0pa?=
 =?utf-8?B?ODhkbGpUeXpCalZSb214ZWlwcEQrREk3MjJnLzg1NzlKNzlEU2I2QkZZWWtY?=
 =?utf-8?B?Z2poS29KV2lOTXFrcUN0ZVdyOGJQWFlLeXpEOENjOGtXU284SnFOdjc3VlNs?=
 =?utf-8?B?aGJsa3Z1NE1UUWpQN1lPb1h5T2NKYzJ1TEt5aXdubFlvTS9hL2VTVDYxZGJv?=
 =?utf-8?B?MkZMcXlYZUIrUVNVd29IcHIzOS9kYURWcmtRZm91YjJoUmtnalA5VGlRRHNF?=
 =?utf-8?B?WjNqK3VraGZZeXliMCt1Q0VudFl4NlpldGJvMzJ5ZGFFUk9JWElFSW9nWXpG?=
 =?utf-8?B?UzYxKytyZ1FKR1NZVHh6NTNiei9KOEtyS1Vhdk1QYTIraDl2QWIyNXovdjJ0?=
 =?utf-8?B?c0Y4d3hvYVlkaGlqMklwSjY5SkFFeEJIekFWQVFaM3h1ODRkbit1aElRTzVq?=
 =?utf-8?B?RDB1NlpETlVaRUxDY2Z0UVoyc2ljVFREeDBQSDZGajcyZkoyc2RoMXNlZits?=
 =?utf-8?B?KzV4Rk0rWFhGODZGQ1p6Y1M5bEIzbVRWb3g4bW5uMVNnT0MyVGMvdE9ZaFp3?=
 =?utf-8?B?SUlUN2V5czNEWnRULzcyNW93WXBRSThXdnBZeldkRjNVTGc3TENZWnZVTjRQ?=
 =?utf-8?B?ZFVvVXlabnQ4UTluR043N2hUaGpYR1pIckhSWEM5N1BUWlBCL2ZYRTFKcjFi?=
 =?utf-8?B?dGFPb2p3QVhDSWZsL2U3bE4yVVFkMGVVS2pBTCs3c3lSSG1LT3FPbWdkay9J?=
 =?utf-8?B?Zmc4eXJtKzhlY1FaSkgzT2EyaWZVQTl2MkZUMXhDVjZJM1AzTFpmVGJ4Rzdj?=
 =?utf-8?B?YU5ydTAwMWIvMFN2aVhFc0srM1dkMUtnUm0xSjdOK096d1pyUmdQTkxVYUhP?=
 =?utf-8?B?UnIxdGFBTmVEeHJhbVhHdmdQOU1YQVM1TzU2UmJFU3p2MVd6TlIvK0JSRUhU?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7411fd1a-3b34-41a3-900b-08db87c5c2a6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 19:32:44.8251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kY+RHhP38td6QjyR2sLs8QRgfHKysMBKVDf3eU4IvMHqmz3AAe36Xp4+7HWTnxJfxZWObp3rWSq/GYAFZPd18g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3863
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jul 2023 19:32:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12414

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...10.184-cip36-rt14.bb => linux-cip-rt_5.10.186-cip37-rt15.bb} | 2 +-
 ...linux-cip_4.19.284-cip99.bb => linux-cip_4.19.288-cip101.bb} | 2 +-
 .../{linux-cip_4.4.302-cip76.bb => linux-cip_4.4.302-cip77.bb}  | 2 +-
 ...{linux-cip_5.10.184-cip36.bb => linux-cip_5.10.186-cip37.bb} | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.184-cip36-rt14.bb => linux-cip-rt_5.10.186-cip37-rt15.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_4.19.284-cip99.bb => linux-cip_4.19.288-cip101.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip76.bb => linux-cip_4.4.302-cip77.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_5.10.184-cip36.bb => linux-cip_5.10.186-cip37.bb} (72%)

diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.184-cip36-rt14.bb b/recipes-kernel/linux/linux-cip-rt_5.10.186-cip37-rt15.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip-rt_5.10.184-cip36-rt14.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.186-cip37-rt15.bb
index 044f55b0..34dfee72 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.184-cip36-rt14.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.186-cip37-rt15.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "f45c47c9944c53920d483eb9b9be205e42c7d0af89f8c8c9bc0d3fb56a95e5c8"
+SRC_URI[sha256sum] = "754f2dba8d1fa098299007d2b8384e349be0ca7533bda497c98df110d8b95728"
diff --git a/recipes-kernel/linux/linux-cip_4.19.284-cip99.bb b/recipes-kernel/linux/linux-cip_4.19.288-cip101.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.19.284-cip99.bb
rename to recipes-kernel/linux/linux-cip_4.19.288-cip101.bb
index e223a1f1..44f1e2d1 100644
--- a/recipes-kernel/linux/linux-cip_4.19.284-cip99.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.288-cip101.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "eb64e6f848e8c60e00b5234e7460cf4bfbdd138047bc31244f692c33b83226cc"
+SRC_URI[sha256sum] = "6d737010f07b27838247880e7aa4699bbf881b587f5b5eb6cfbe98bd523c7969"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip76.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip77.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip76.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip77.bb
index 6c45b5d4..0b87de57 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip76.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip77.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
 
-SRC_URI[sha256sum] = "a3437df29f07a2dbfcc2dbee94fc0397b37b5eb63c6e4453fcb0bff694c0169f"
+SRC_URI[sha256sum] = "88686014daf17f1b2c64b24c36e1064b7dc1616a8a1ba4b3651362fb3b1aaa85"
diff --git a/recipes-kernel/linux/linux-cip_5.10.184-cip36.bb b/recipes-kernel/linux/linux-cip_5.10.186-cip37.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_5.10.184-cip36.bb
rename to recipes-kernel/linux/linux-cip_5.10.186-cip37.bb
index 433a6ad7..06ad14c8 100644
--- a/recipes-kernel/linux/linux-cip_5.10.184-cip36.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.186-cip37.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "a6405d852023099891f8d0530bf332c6cdba7654d6497ce83452df6ec1293152"
+SRC_URI[sha256sum] = "0a0eafb33490fbf6116c69f65846745dd0cb288119889ed87d336447683d46bb"
-- 
2.35.3

