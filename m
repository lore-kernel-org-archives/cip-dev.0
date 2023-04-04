Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F63C7618D
	for <webhook@archiver.kernel.org>; Tue,  4 Apr 2023 06:14:40 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.72])
 by mx.groups.io with SMTP id smtpd.web11.94830.1680588876061787012
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Apr 2023 23:14:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=IujjsPRQ;
 spf=pass (domain: siemens.com, ip: 40.107.105.72, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZNR/B2fbSLkRXuKxde81XCUfPbVo2BO2d9ZwOjpFrhSaQATBv5KpCfOt33l/gvlEv2iFcuZG8XTCY6JhzAYm3/ODQLfY07pPTv2M0n5TVc13byJRz+vCsuDsPXC9n3UR8GBj54nMHDaTM3+tMarHlVESztoFD68gCn41WyStD4csjjTYLGdmhPOI32yggz7dksWCzjxD+PEjmyqnePAOb7WaH37gQHIqISo1QpiEWBnlBqYg6qEL2cO/vy9IMa8cmvq9a39Qeo7lH+cayNo5mmi4+muSK9lbnxkWT5jvGTD8wP52kF4J159FTa/7zxLt9KAUWNhuY368gwYSnjIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noFAQZTe2jtpJatLNxOvVEVRmyIkZZUiBQAercuG1XE=;
 b=UcKq5BWmzOkBXYKCYjyel/pqOqxR+zA8CxR559TfMYUqkEEwWzIAEI0mV/2lDOoAp2GLyKsxDrNceSjhy285NB9pCjofdk+8Uph0dfhMLuXpF6V7kAp869scMj96OchGYZwZVMoH7fnyBtJK/Om90xYlwkL/YIeFD2NYBf77QiVa0dhZvPB3mvOYkScYAzwCdvh3YPJMST8ZsshruwSxHaLwjplnemawgYLBeGORCoFXljcwxiyjc2o3CR9pRimIWw9bgVGoAhxt8UT6OZcFhX1xHtxzIDEc5XzCW8Bv6X0UDqa59x3n1prGPf+JP9ZVQ4Buj21Lqu445PARJrwVPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noFAQZTe2jtpJatLNxOvVEVRmyIkZZUiBQAercuG1XE=;
 b=IujjsPRQa4Eoe+rCRqeeA9B9kfCcg7+52OLsLdPd9VJiwKAjYxbWMvdmHGboXnRQQl/wt8t15G/DCyDygB25pjnYoOxEcdJvx6a/qV0tcqRaLYd1qmr8+5lUvKvP0RxWkifgr8lmBJ1trSwRI76K6+3ry1iaj+2QrWFfqkabxB35vWCb3dcAzJMrumAG+Ldu/7qKbY0MSZ5YTgaYvJymZpeu8VB910tFzGNypmElEmFiCN03Gwbezzg27mm+KGPUnnt3emPNjqYttYSpV+P5slfC7C6MdJsk+sOm/pMSr3oKI7HiuSkjtHhXpwKUNVPRc30e0yo/AnLmjfKxzDyPfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6802.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:472::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.22; Tue, 4 Apr
 2023 06:14:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6277.012; Tue, 4 Apr 2023
 06:14:33 +0000
Message-ID: <1a5badbd-82bb-0f68-37ec-040b95a15b37@siemens.com>
Date: Tue, 4 Apr 2023 08:14:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH v2] linux-cip: Update to latest releases
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: b52015ef-e266-4fb0-d81b-08db34d3db77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EjpwIKi9IUnii3tJKNrBcAzxjjiZgs4ZrRxzPsukIY1YO/ezGGq4wfRUUEH0uzl/0C9LJ0y/kFWBxFssYl7PMHkO0THFb8dTCGjYeXX5nELDcP7NRJHzJbHSJbwkETtDOJtgrfSnhYaripbap+zktgLvcVwUhSc1EAOBsZ3I/zSBWCJ1f8bb6iQeRpJiP5xBHuqVcFhefjA3dz3VkaRsPA9zLbVlQRSfgjB/O4GHC2Owk+ZisAKDbozxsUjauY7DSfZ05U8NS5tsCOEWUXMU/ow/L/BzSstNIWNDZ2fiKR78Ly824yKsuSvoJGBMPWZE5CYtJMG+Z/xfgsSvYiwIbYmgm8+Drpmwc73JTaj2fyXofQcfrcV0C7u7GMHoxwKT+iL9XPkEQ4mrngtZPapROxqCFqreTHKpUMRVHssEod7ZoiXDOw1bo5PiDgQRwDGJSZ3xCZj3Z/tbH14Vp+31dJKsfjpTj0RAX3TdtIHrMGsvYfQudk+yA94VlUgEaw1oPVfVqtDGNtFdS60HLeAmgV9LJ67m/ueZv75p+5veOVZDOduWJFV5hxjpZjQ9ukaLcM2GJ3twaly2Z+aHj5vuqM7irBeLJTlWZZbYEqzYLC3MBqSupbT/wpIoas28tCl5/ymeLyUl2R1ApRRMjdly2w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199021)(41300700001)(66556008)(66946007)(478600001)(8676002)(66476007)(6916009)(316002)(8936002)(5660300002)(82960400001)(38100700002)(186003)(83380400001)(2616005)(6666004)(44832011)(6512007)(6486002)(26005)(6506007)(31696002)(86362001)(36756003)(15650500001)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MndobXl0VGNjNTZaUGJnTTF4ZWh4RDY0Nml1bUdwa2lHcWt2V1VHSTJJcG4z?=
 =?utf-8?B?Ylg4TStVSklZMWtqVjNpVWR2TEtKUFpxaFRETmFaYjNlTTBWQno4UmEyVFNB?=
 =?utf-8?B?MFpVVDhIbk5zMXRrMkNSOWtRVkt4TWYraUlqQ1dIRnhveWhHY2xWTHYxTzZB?=
 =?utf-8?B?aUE2SndUUGtaNnd3MnROazl1aXBERWo4WXVmamxwQWp4bzVwdEdjZnlTbkJm?=
 =?utf-8?B?Rm1wd2xqRDl1djMvNTlkT2FVTVIzcHI1ZXBWWVEwTFNkclp1V2IvY3EvdHpa?=
 =?utf-8?B?RnNFbUZBdFRubWx4STdNZ3ZBeVpqeHNQWDd4WVU0cEZGczlVTFN3ZWpuOStV?=
 =?utf-8?B?T3h6ak8zRlJ4Skt4Q2FhQlNxYXVPVS9sZk44cHpkeXZ2QjdHbWdxb1VMSnht?=
 =?utf-8?B?dnBUZE0rZVBDZDk3YzVtNzFvMHBSZjBXbVlpMzBXWkVoeTIyeUMwTkdOU0Uv?=
 =?utf-8?B?N1JnYUtKQTE0QVgxdzkrb3pMSTUxUGxPNDRDUjVOSllCUk5kZXVvU1hCOVZw?=
 =?utf-8?B?Ym5tTDQ1b3podkVOVVFZSFZyT2ZpaS9rSzVVdlZmZXlFbmw0b0p0VXFFWFhS?=
 =?utf-8?B?eGlEMzJiaGFvMHNnRXVCYm1QNWM4MktISi9CYTFiTkd1U0xCT2U5ZHNkSlFL?=
 =?utf-8?B?WVVySVk5MWRWRCtXVnRpb3dlUms4UEEyOEFtWGVuTDhjbW5HWE9VcElBVDBZ?=
 =?utf-8?B?ZUJUeTlvaHlOQWJlcElXVkpRNjUzSVZFaHdib3Z0SGloc0dLUTVUSnpFSVhk?=
 =?utf-8?B?K1VrUk51dWV1Q3BmZEpkQmFXWUcyR1NOQXV3WFVsd05GSFY1VDJ0aXdMdVM0?=
 =?utf-8?B?RUNJQzNXbUN2amdBYnhVY3M5L1c2QkF4cjV2RHFJRUtod2RLdS9LS2JmNXdq?=
 =?utf-8?B?VUpPZUhudzhwNFFjQ09vZ3JsZWF4enRINCs3SjljaVNNeWcyZEI3UVJBMHVx?=
 =?utf-8?B?VlJVZEkwK0pMcEordkEvK3k4bWdiRGdWdThIL1FuTFV0ZlpzMnIydFllQXlE?=
 =?utf-8?B?SDd0c0lPamxaYnB3T2s1bzFNeW8rS3lTaDl2Zi8reWY2QXFyalpqQmE5M2J1?=
 =?utf-8?B?YXNIWUhZcnpuc2VMeUN1dmdyQzB4WUVQSVhqUmtHcU52R3VET2djWlFNbDdP?=
 =?utf-8?B?RzlCa01PV2IrdWM2NDcyM3hFQ3pOOERtM1RGSnVZUUUybEdlQjczTDB6Vndz?=
 =?utf-8?B?dHM3cjdKMEo2K01Ca1BiYXNLRnlJemxFRHNhalhadStpTGs4MnAyWDdmOS9D?=
 =?utf-8?B?OE5Qbk9IY0dOOEpFY3hiQ0lVdEhrWWF2ZkQrODJPcWpSSjVScnovOUZxa2lI?=
 =?utf-8?B?ZzVBRXZXRHNnTmlkc1hkT3p2TkZGOUpJV1d5RnhvZkRER242VkpNRERYZW1M?=
 =?utf-8?B?a1BMek5PQ2lUcXBqVlp5aTF1aXljSHE3WjN4TkExSkdOZE00VjFxYzF6MXNo?=
 =?utf-8?B?YkMyd0FLdWN0UGtUcG9aU0NCWG5DZjYzbDdtRkJhSUNVM1FiRm4yQUpHSXgy?=
 =?utf-8?B?Z25ueklIVW9oT2czc1NHdktuSGQ2OXhGbTRjbVZmSkFCUVR4UW1wTFFxL0JH?=
 =?utf-8?B?cEZzemlUc1EvQSt0akZHdWNjQ1NkcXQyWXZ0OWo5NklBUTBaRlR6TC9ua3pv?=
 =?utf-8?B?aCt3YktGNTZ5NlRmbXNFeFE0eHB1L21iYk1FVGx0OU5MWXltT09yZlovcTNp?=
 =?utf-8?B?U0NtZHZwanM5US9udmlOeE5Xa1V3Q0VFYUI0Nzk2ak9Vc05DQkQ1ZWdJSHZT?=
 =?utf-8?B?ZEtZZnJFMC9sUS94djFURFY1MnJhcHo2a0hkb1ZZT3Y3VVNPUXQxT0F0U0NS?=
 =?utf-8?B?TWZ4bWhZckpFKzFKcEFuRmc1NlEwS2MweWZPVU1kTWMyUm03bkp1cDV2REZq?=
 =?utf-8?B?VEZMa2xZVFBjV0I3a2tmVTVTMHRrb1dPV2lYSy96cjJkU041cGVISVJCRlgr?=
 =?utf-8?B?a2l5ZTdZaHUrZlZ1dXhhZi93bS8vRUpOalRiQmxUeVBkK3JPVUhzQThmckV4?=
 =?utf-8?B?ZTdwV1hDK05BSDBEKzFiaWMwUnIxbE5tVUlmSENyVDNDT3FWbXNqNTZ4TzR1?=
 =?utf-8?B?YThZYzBSSnNBYzluZXNPRVVZSWluOWRYeGxKRmpiNG9meHNaZ2tibGlVOFhp?=
 =?utf-8?B?eXZaZTBtTnpNVytrbmY1UUJ2YlVpUG5HWWNuUjA1WEppK3FBeWE3RFkrSVpM?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52015ef-e266-4fb0-d81b-08db34d3db77
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 06:14:32.9332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLR/HqIwv8JjaGWSBRxuL7tYOx66OVRAOLO8a3/YmPG8yXiJ0LfeF3NjilrcfINwpMK2OdelyVRn4IfJy0VzzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6802
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Apr 2023 06:14:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11161

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - update also 4.4-rt

 ....269-cip88-rt28.bb => linux-cip-rt_4.19.277-cip94-rt29.bb} | 2 +-
 ...4.302-cip72-rt42.bb => linux-cip-rt_4.4.302-cip74-rt43.bb} | 2 +-
 ....162-cip24-rt10.bb => linux-cip-rt_5.10.175-cip29-rt12.bb} | 4 ++--
 ...inux-cip_4.19.272-cip91.bb => linux-cip_4.19.279-cip95.bb} | 2 +-
 ...{linux-cip_4.4.302-cip72.bb => linux-cip_4.4.302-cip74.bb} | 4 ++--
 ...inux-cip_5.10.167-cip26.bb => linux-cip_5.10.176-cip30.bb} | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.269-cip88-rt28.bb => linux-cip-rt_4.19.277-cip94-rt29.bb} (72%)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip72-rt42.bb => linux-cip-rt_4.4.302-cip74-rt43.bb} (72%)
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
diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip72-rt42.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip74-rt43.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip72-rt42.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip74-rt43.bb
index d6d0a529..7380fb65 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip72-rt42.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip74-rt43.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
 
-SRC_URI[sha256sum] = "f06c3048ec3a18e3d25268374396a74b64c55cb858d3b4eb98ecc3b87e8d871c"
+SRC_URI[sha256sum] = "62b83cafae6009b407018178ce76ffe7d23be8b33b7cf1bb1af82eb7a323c02a"
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

