Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21529C761A6
	for <webhook@archiver.kernel.org>; Mon,  3 Apr 2023 10:02:24 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.51])
 by mx.groups.io with SMTP id smtpd.web10.66199.1680516137253482328
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Apr 2023 03:02:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=nWpqGSK0;
 spf=pass (domain: siemens.com, ip: 40.107.20.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhruUkNjcrP8mwHJLboJ5LIpN/VRe2DGRjrAqGfwTej5/qJgkhMmvX8QJ4x9PtM0mw2aW7baqbUiX2eL4+R3G+liLKtBSj84GIPwdUB9qMjW2R66eWViAgNBy8PEL5UOJRuV2+rjJTNERZRtkwewfZTaNkNW3LdH8x7S+mxY47xB9K6JCydenDAe6jMSjytYLVZXUVop1wX/f479K4co7X/pdt28CturR2nE7rl85BrftpvZB6Rve3VutD1lPWVEu2m9UVxV+0wjY3biRKHKLfBg69u/f1UupTcm0F6PH6DYOO6izDHmZ9pcORTdVZ2XQLDH6pC8x9IVJRlsSWW0BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oppCIxhut0JBZgUMMnggw4Z5Sj6qHzDqdc4s/Ol6w7Q=;
 b=hIklKC4GVmtyUuhiJ7BL1qeS9BVg2fOoWWImzD+b3Zw0sIDbd3pei2l8OQmV31RipNG9heBxpz6BeiwGDTy7qqRtClnyNJ2ouxzJBC2a8am7FKEK5GBo6rIDVdtzUmbmeJhHYACZRhAyMk+J9Y9P1spH3+UuP/Mdh4gUbKAAbgsFy7/Mt9AK2sFJObkwIoeWRaYMhfWgG8gW1avCLu0Ie196zsFvwMi4QfZFoRoY9nxiypP1I5OezQeo+P0X1/GxCkcNsYbL8axVkeBU+WF5rPkOIIhaw1XMELdj53fSVCLvdEkqMzHv+EkHKf4NLBM79aK/wGZhggeA06Bm9Fkzmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oppCIxhut0JBZgUMMnggw4Z5Sj6qHzDqdc4s/Ol6w7Q=;
 b=nWpqGSK0upEkP8hJnsb0tR+708c+5nFgD6B6uHjCPa5zpg1zyjWsUvEDEJqQrMqlM96+0Zqlzuy/zCEUwLaQpaYlemJTnL0tJxyO7JJTXYDl5QDAXidt92EOxgRpZQ//+RikZVR3237dS2WX8A0tLrXBANAEW2MrX5n9EXa+kM3H047d+j5YmwSoyClmszOgx34TPBkbCKlhIvSXAWSbdaMx9iV2B1gKnIGyrWdl46/CPtaHvnJfRW4aDuM013Hb7tlley7l1eT22qwlSmoPgIMxPG1ANiGViCmf3ghrFmGbGIM3j8Hk3kd7xkquQdsWv8u9Bs2L+edlVkCvTmgUhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6549.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.26; Mon, 3 Apr
 2023 10:02:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6277.012; Mon, 3 Apr 2023
 10:02:14 +0000
Message-ID: <857edf22-06f5-2197-a7d2-baa8108a86b5@siemens.com>
Date: Mon, 3 Apr 2023 12:02:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update to latest releases
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac429a7-d3e1-4a63-9109-08db342a7fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZzhATtSXRLsG4EZ0/mTQXvtoWXkjv2WH66ApDuUUckbUr8MOAby3DXak07HPhQ3ymdVgAC8tgqe9WCRnXZTjGqJOseltWeedIhyHiUmWpHDYWKkuhNsiTfne+l31c+7engsuA7JNhWqvl0NpyOX95CYzsXAwxXrkryVtxrNzWdlITUpYEDHM2mvXRUjkLddx+TxPoX7Am9N4O0y+4NnOHNsIyo6E+LieZM8D8xrRycvNJqPUP7Up5PXr80gH8XyiiJECWufP/ccaMrj+K7NS9T78V4uca+2x71FTHKlnwvhrye6qzQcUh4jt9Izn2yKGqwjvIiUiC/BGr6X6HvSm2J8K7eHoVyKGMiZjXFKghRtgwvRNdJDFOd/fF5eNgUZ4b8AjCYm6TOlpm2/0VZ+uWo9Ij+QrBkTicLlnj51FP8jZKtqnbla+bZETVgxEq+7K73sdPKR2nRcDLuvR3knZrpHsb+R8jbbQrHbo1dLQUqSXfxe1S7BkOMw0h65dKrZ5CyGsXS0k+X2IxgtZB1xRZo4LN0Gl7faubRzXIItJnhBRY0keYQ0/6dlO7lSTm6oemmGVyoWUMMoSr4XquPFKLO4tHeVknGZykAkDLSzyWD7/O0QCvrkH+gd1oR8q5DdUewXJ8rrEu7RDDKyNyMYYVQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(451199021)(31686004)(6916009)(44832011)(5660300002)(66946007)(66476007)(66556008)(316002)(8936002)(8676002)(478600001)(2906002)(6486002)(6506007)(6512007)(26005)(186003)(41300700001)(2616005)(83380400001)(82960400001)(38100700002)(36756003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QWhLRjBLVUFrZ1pIQ2J1K1AzMmJmMmdoUVBNdHFmQUI3ZVRONm1mTDdhOW9J?=
 =?utf-8?B?YXV1T01SMmRhRlRDNHIrbERwQWlpYUVKR2VZdysvOWtIemZGL2hvOUJnLzNP?=
 =?utf-8?B?TGN5ZE1jVzlYVkNxWlltUGRyVC9GU1dOdENTSU1oSHdHdFZvbWlDN2d1aUpG?=
 =?utf-8?B?bU94UXFVdno1QmV5dXFzanE3WVk3YlFNUDNDT0JpV3ZmWkNIdWxOc1R2SUpZ?=
 =?utf-8?B?bzhUVmxIcWI0UVlkNXdNbWxZUWYzODhWWmpDVncrQWpSTWFwbHcyZUZQdHZF?=
 =?utf-8?B?b0d5RW1kMUkrK0Y4VkhFS2pXODdXamJaODhxSXlRZWV1MU1wRXVtTnl0L3Fu?=
 =?utf-8?B?Z3B6MFFtRDg0VE5hVDBVQkZPMEFNWXY2Rys2Q00wOWNWb3ZHYktjUFhYR1ZE?=
 =?utf-8?B?MTJUNk1wb3Job3Y3RnRGNk5leG5DQkN2aXUvVFlnNmp1Q08xaFhUWTdONFZD?=
 =?utf-8?B?ZGVkOGo0WE5HUDZSOFpwLy81UklFY2JFeHk4S2xIcThEd081Z0Y5UXBKejdq?=
 =?utf-8?B?bDliS1d6UVFkclFZbkgycGRhTWpJUzVDellDditoUTNNSkx3SmJLamg1REw1?=
 =?utf-8?B?OU85MmFscnZUS0hRcnpucjczWEFWUEh5MGN4YkYrQlBLem9aUEdBbVh6SzZQ?=
 =?utf-8?B?TUJaLzM2ZG1vb0s5b21TNEpOOEM1RURMS2VCbmorRDlSdDlCNkkwbHIwTkZ6?=
 =?utf-8?B?VUYreGMzbGhtMS81cVJQYmJSWmkzdHUzdXFESXB4b0tvalh2bHlZS0ZYRjdk?=
 =?utf-8?B?YVBKVDBQQWhZT2NMejI3bUNPNXFtS3ZWWE5GbDAzbXU4TUZMYmdPVGVjMUUw?=
 =?utf-8?B?dzBQR2FIdUM3TDFCUCtXeU5nVVNDbUM2K3hEdG5qZVRWelo0akM5aXUrVE91?=
 =?utf-8?B?SFN1a2UzK1RNOExZODVEZHpuU2F0NWoxUE9US3pybVlCYUk0ODZzUGw0MU80?=
 =?utf-8?B?RnUrWTQvQ0U1ZWVoNkdJYml2b2xhRjNwekRUcURxalZvaUNSa0FrT0FUUFhh?=
 =?utf-8?B?TFhVcVd1V1BtNmRtUGw3dlFINHNaVVBEYUZTRFdQNXB4enRLMmZlbHU3WnNx?=
 =?utf-8?B?ZE9QOTZTSGNQUGF0THlEc2JtaHljMVhWbWpoM2dCRUt2dmtIUEl3bHdLOGhD?=
 =?utf-8?B?TkZ4dk05VXJ0aUFZZlBpYnJmL3d5ZUl2Y08vNEpYc3pyRGN4bjVJNDN4bFRu?=
 =?utf-8?B?VkNxZlB1UVJNL01TVmliRkNHVyt2b2JNditrZnZJOHVmKzdEaXpMeDA4UTYr?=
 =?utf-8?B?UnY5MEg2SFJXaUtXRkRLZjhIbGNnZzRVZmRBcmlOVVdxaWVJWEdKa3ZaVFBL?=
 =?utf-8?B?YXBUcUplb1lnR2pwZFlRclI3T1VKVitTWktncUJrRmZQR09jRkhGdjYwVUx3?=
 =?utf-8?B?Ym12RWNxMDhTcUxNVHNONUorN1JPTWlhMjlJV3VmaWtYWkNlWEo2NDZQbGxp?=
 =?utf-8?B?cnFJZ1NvR3BIWnBsTG1oSllUdmRDY0Rhc1NOQ3JzU1NZMnN0VlJCRmttU0tL?=
 =?utf-8?B?QUZvUEdlNVJuUEJSMEpnbW12VkY5c2NUWDlRUmFXWGlUOHlPSTJGdHJRNFhp?=
 =?utf-8?B?ZXFQMjUySzNvMlYxN1BWcVZwd2hQeDZSQk1wcnFadDRiYkNTN0VmVzB2UmQ3?=
 =?utf-8?B?dDVkREEyRXVieDVUejhya2pTQ1UvR21oSFRGbG9aM281aUJadi9NdFUvc0ph?=
 =?utf-8?B?TGNUK2xSU05Mb3RMMnV1V01FaFg3NStkMXFscVdDV0N0aEZTemswVkZ0RGJS?=
 =?utf-8?B?eTE4ZDIzNHl1NGJSR2d2eXBGSlN6UTBheHoyNkJaZGZ2UGN5ZlRORWluN01o?=
 =?utf-8?B?SGhtTmoxTDE2RXp1Vm5adXFTaDlSRHFXTWtBMVp5NWZoUGVBbGtWR3R4TVA0?=
 =?utf-8?B?UWY4c2xESjcyZWxtNFdPZno5SmpKRE9kUWpZdld4V0h4ZFZkMkVQaG0wN2xv?=
 =?utf-8?B?YTlqQjJwc0hwNnA3czBVNlY0M1NzblFIb2RkRmZwNFg1QVhacVlEQVpyN21D?=
 =?utf-8?B?QUc4SlFETWJCRnkzL2lKMWRRTW1OenF4eVZ4TnFuMy80M1kydUpySU5FSnBn?=
 =?utf-8?B?TStJYWdVVzlXOFBJTjRDL01CcWtGYXFCOHhZS2F0RkQ2d2hzTSt2Uk5UVDRU?=
 =?utf-8?B?VnRBL3RXOUF2YjBIQjd0Zm9EbnpmNVEvL2VMT0lYb0Y3UHZTeklEblozbXZ2?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac429a7-d3e1-4a63-9109-08db342a7fd0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 10:02:14.1751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXZrLiy0ZBo7flbl8oCe/L/aVFSExkD8plKgdfb3rrNxLjkwBGTV+vSRMKRG+9HFG5UQV5XDxAW931/ZeTmYZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6549
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Apr 2023 10:02:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11149

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ....269-cip88-rt28.bb => linux-cip-rt_4.19.277-cip94-rt29.bb} | 2 +-
 ....162-cip24-rt10.bb => linux-cip-rt_5.10.175-cip29-rt12.bb} | 4 ++--
 ...inux-cip_4.19.272-cip91.bb => linux-cip_4.19.279-cip95.bb} | 2 +-
 ...{linux-cip_4.4.302-cip72.bb => linux-cip_4.4.302-cip74.bb} | 4 ++--
 ...inux-cip_5.10.167-cip26.bb => linux-cip_5.10.176-cip30.bb} | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.269-cip88-rt28.bb => linux-cip-rt_4.19.277-cip94-rt29.bb} (72%)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.162-cip24-rt10.bb => linux-cip-rt_5.10.175-cip29-rt12.bb} (60%)
 rename recipes-kernel/linux/{linux-cip_4.19.272-cip91.bb => linux-cip_4.19.279-cip95.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip72.bb => linux-cip_4.4.302-cip74.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_5.10.167-cip26.bb => linux-cip_5.10.176-cip30.bb} (72%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.269-cip88-rt28.bb b/recipes-kernel/linux/linux-cip-rt_4.19.277-cip94-rt29.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip-rt_4.19.269-cip88-rt28.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.277-cip94-rt29.bb
index 9ea66f5f..1a269734 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.269-cip88-rt28.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.277-cip94-rt29.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "da6d67e1de1bf314d0938ec2f2a87b91128a1df6a12262e649933078b36d7c23"
+SRC_URI[sha256sum] = "1fa134ac4daa88ffb2c787d05358c1039df1f350b3953b879b6ffb207d3374ea"
diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.162-cip24-rt10.bb b/recipes-kernel/linux/linux-cip-rt_5.10.175-cip29-rt12.bb
similarity index 60%
rename from recipes-kernel/linux/linux-cip-rt_5.10.162-cip24-rt10.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.175-cip29-rt12.bb
index 4cb33897..c58e8b73 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.162-cip24-rt10.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.175-cip29-rt12.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021-2022
+# Copyright (c) Siemens AG, 2021-2023
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "b5539243f187e3d478d76d44ae13aab83952c94b885ad889df6fa9997e16a441"
+SRC_URI[sha256sum] = "60763c904a70b1596deb5d65a3260de2e8dbe0583b411b55a5b9a90edce16104"
diff --git a/recipes-kernel/linux/linux-cip_4.19.272-cip91.bb b/recipes-kernel/linux/linux-cip_4.19.279-cip95.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.19.272-cip91.bb
rename to recipes-kernel/linux/linux-cip_4.19.279-cip95.bb
index 7b321e40..802a8558 100644
--- a/recipes-kernel/linux/linux-cip_4.19.272-cip91.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.279-cip95.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "680405742299138b53247569855d13c737e07af1fd191aa69ab60ce9e65f51c8"
+SRC_URI[sha256sum] = "fb5808626317e464408203562941d287fc49f747f3af1c1a34c125229a5efa43"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip72.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip74.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip72.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip74.bb
index 7f4a3860..4b6a548f 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip72.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip74.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019 - 2022
+# Copyright (c) Siemens AG, 2019 - 2023
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
 
-SRC_URI[sha256sum] = "35ca43e814bb87b0da610b9682fe10494c54436f6de563bf3cd42d20746ca4d7"
+SRC_URI[sha256sum] = "0758c47f454d51fa80e3c63aac919d04ab4e6dc1a6ef8c34807e1e180d44d9d4"
diff --git a/recipes-kernel/linux/linux-cip_5.10.167-cip26.bb b/recipes-kernel/linux/linux-cip_5.10.176-cip30.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_5.10.167-cip26.bb
rename to recipes-kernel/linux/linux-cip_5.10.176-cip30.bb
index 7b0667e3..6f740f5c 100644
--- a/recipes-kernel/linux/linux-cip_5.10.167-cip26.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.176-cip30.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "982381137420cdf4ef96b95ebdf6654973bcc1238f497c455fcdbc272981b883"
+SRC_URI[sha256sum] = "722931b6291d1c796d571ff2e1bf4393734928edb6af7df7138ca0379d9a27c9"
-- 
2.35.3

