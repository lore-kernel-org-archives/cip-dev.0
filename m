Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC509C48297
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 13:27:46 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.60])
 by mx.groups.io with SMTP id smtpd.web10.21299.1707226061651268347
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 05:27:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dccACGwa;
 spf=pass (domain: siemens.com, ip: 40.107.22.60, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEMMiwNWbhQ85lbb12HKk1OVmAz9wDWn5Wb50P63kfSRpH+eAO/lzyaZ3Yizi7/e1XExoXGnkdbxYN+KGK/GuV6UhrTqDI05iRkhrBMLv2V3TXerVtZFeQ7h8BH1FWPgD1Wzp4IU7SeMmAGx3JL+XCb2f1FsGbq2UgMLMI5gNtk65oSVKShgFulQxm9+E3H0S4agEF2HkKCjc12QT85igunPnxosQfpQtXkCBKFxXUKH6y99ycu8xyczLlCs/fD4sNZRUz1MRgZkMsPNVPTym4O1JOkdww64RT8BtAauWyh4pVCupPz/2srq9+F+1+IqbQENEj46BP5sFQB/1btwLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9cfK4LU3jzhvb9tnfXBhjLyxR1zDQVzqvLZ/QL+v7o=;
 b=MKwTOPDQpyGzM41w4aVRD0ioTpxIGpu6LA5lvn7uCSVmHlWCkBCbLmKg6sCTJpk3JSVHiyyECyBPSmzd84mduuLfdFrOolz0DTN0zHUv47TqHiCatnZ9CaPzX21+Vnw2MjLljHfLE2qLDsOF2Xky7YNo2YZP9XslTecoGwqHCmgjATsn2Sa3OlJ4N4gXgT8NmkaQh7+m+H7IocdHU6CnjEYdHEO8rV4wkbK92jTQdstvTaBKuz7Bs/6H9+1rDf1z2+5+D8Ua7p57yizdqnsSUVrX36iHq/YfUFncYiIbstYAEASc36qZwa1/rnqf911H9C0iN1wvzDZEsCIF1MPbUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9cfK4LU3jzhvb9tnfXBhjLyxR1zDQVzqvLZ/QL+v7o=;
 b=dccACGwaagoWwMipRlMpynSlgGD1fW8zvdBxM5zPq1kC88bTL5bJBygVmUw1FCF6NsScR1OPFlg/fFi2+FkceLuBuwcQ48L5M9BP7ko0fzG9Y95lQOd5qy5FZ0QTM5jcrZYIhB4kht4XIOlJed4rimW63TGPWzlsE8SWXKE0jp4l6UmyuniApo8o937h/BUZax3TjR1cB0MclM/JlEEanJEduptU1HEhPY7N9rOQq3ngA5d5qsxLOuQf6YBu53GMVhn952HwfC1pxZyi5MQTbBQw81uvS3ET4W+tGtYTnL7nO5/WzEJCkUTGrNAMncnTvMLGCIPrZjxRy7QpOz9bjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6161.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 13:27:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 13:27:38 +0000
Message-ID: <d2e5d983-2966-465c-a6bf-bea280f04d66@siemens.com>
Date: Tue, 6 Feb 2024 14:27:34 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH v2] linux-cip: Update to 5.10.209-cip44[-rt18]
 and 6.1.75-cip14[-rt8]
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0030.namprd18.prod.outlook.com
 (2603:10b6:610:4f::40) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6161:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8d5e8a-923e-4b48-55c1-08dc27176356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZPx5Oko0i4MXqmFHsQ2Y5p2dng8MqO5WumVyjbcH3AtRbGeGRf12IWROupz7sSr+fdBVFOxV+gL6ICg5t/SmKJBbXhAtqwojG48RlCiQgaxppNhlOvMhvJ2V0xw04i5bbX1fx8eORw4Y53U9dMED7vbfbvcoNBpiMosfY6k8CtGxrC8Qp6++Xmin4ulE5ogtwm1gQ/wMskFcsDvUB8GWig9c0QbZAwJimcNZYu201Lulxaaq/ciQKtDAZACcrn+hIRQVXf09V8oZGA1+SzcdLRwYiy7hjwxkT9D9Qi9hRsrDgo84wwnxVSIyds+x7w5Nx4i+6cBQAUwFqtovzY2+hO15g762RwOS5BT9J8g9Ck+0j9Lo7ijbOaJFl+vxGWmMB+UYOg40AeEgzI9MiOFHICdOvP5UkXZtGQJo0AFhkZ/deiXqPPapMjEmyXmbEv8HfCP5JE1jEzenQJc/nCx9IPwJd2XFOHOzvyqHT/UiiV/0cFJVmd5OQg/cBxv03mBXjjNzx3IwPQ5anV3OZDYbTgZIam0reThXp2FvJUukix9awbHaBR1S8jbfJlYVuA+U6uFWNqB2EG5ObTwyw6bI4RHV7OXaTh+/72ksBT/fWukAdRH2qvMrdC/H+9UJ6DguFJE8z1FGWMVUeFbL1z7Lzg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(31686004)(83380400001)(2906002)(38100700002)(82960400001)(41300700001)(26005)(66556008)(6916009)(66476007)(66946007)(316002)(31696002)(86362001)(8676002)(8936002)(44832011)(2616005)(6506007)(6512007)(5660300002)(6666004)(6486002)(36756003)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S0ZhRHNLRnNjNENNcEEwbUVLRVNxQkhRSHhiMlVPSkFGcXR2MU9uRU5Ha3pY?=
 =?utf-8?B?NWhnYzdNaVZWaWtqTjFQVFhHSlg3QVJRZ2k2OHhBL05yakl3U05XcXkza0ZG?=
 =?utf-8?B?ekpZek96U0Y3QkVnR0tNTmpRcGloWmt5OFJnaUFNV0FDZmF3eGJ0YWQvRkNP?=
 =?utf-8?B?OUViUklrVFMyQ2lLSkN5QUVPbTRMcURkdm93ZXNBeWYwSkY1aFlUWm5PS25K?=
 =?utf-8?B?dStHa2hZeEd4R3h1SUlCamtqTTQ4cmRTSzRRc2FrOVJZQXJsOXBxc0pyVkEy?=
 =?utf-8?B?QVZka0JZbGNnODY0aktWV1U0b3libTRucFBrMkFCRURkdDZUck1jajlJODJJ?=
 =?utf-8?B?WHRFWmYwQjN3NTU1RUsxdDk3NjVRdHdMcVh5R0dBYkVneldSbDlySCtDMlk0?=
 =?utf-8?B?dlg2SmF4ZW1ZTW9nRzdKSFNmODE4L0pET2crTzZHRkxhVDZrTUhqV3FHVUxR?=
 =?utf-8?B?b3NwVlp6cnpjY29xZDlERW5RVVVCV3dLZ0tRWHYraTV2dXdqSlJYV2FCQnM5?=
 =?utf-8?B?enRzUkhZUGEzQndhZDJ4Mzg0VWcvTXdCckxOSGdDMDZBZ0ExRkF3Sm9QQkZa?=
 =?utf-8?B?Ui9hWGZWMHQyeHAvcGZJQnpRZUVjQlVrUkJKK2lWbmh0S05iVjlsYnUzbHlV?=
 =?utf-8?B?RWduaXJrdkZ5QjRQRUxqY2lwc0lvUkdFWS9mWHNCUE9JNldEdUFwWk5GQ2RW?=
 =?utf-8?B?ZW9zZTdpM0lZK0JUYWMzdlppQ3ovd0VHWGdiSWVKaDV2cmFYNkdLTW5DS1BE?=
 =?utf-8?B?WHBlQ2x1UVg4Zk5kYWNnZzg3SVFrZ3RLZk9aV3FiMmJIeU9zMVdVUno5QkpY?=
 =?utf-8?B?UVhwdTd6aUZQZ3hHR05ZQU4zalZYNkxRb0N6VTJBWmV4UDZhek8rT0xVdDhy?=
 =?utf-8?B?WmtoNnExOFk1cTlDL3hEWDhNbk9WTnc3T2w4QUpoZXgzZ0lFNUtYcmlnQTRi?=
 =?utf-8?B?UHZ4ZytYd2dXWWp4SEpnUXhDRmpYRDJsN09vdWt3cXRCZStaa1pMdGRNY0Y5?=
 =?utf-8?B?YnRwTXNHdnZJL3hqTnlDdmt3M253bHhuVVU2YTVsSkxpVHgyeGwrRktoQmdR?=
 =?utf-8?B?dWpjK0xtc3FYbDZQdzlxaExENVZWRVBrTTNtZ3k5cDNKenhrT25uM1JzQ1No?=
 =?utf-8?B?S1NYNEUzMUdnZjRxTmRsRHM2RHcwSTdVeDhkTFJCUXpybWV5cnhxYW44Mjc4?=
 =?utf-8?B?VWp4djJ3VkUzMzNzcWxOTlZDTW9sMEw2V3VTVm9TWUxEVWF1bnpMUGJrUGFh?=
 =?utf-8?B?VFYrMm9Lem1FaDIwWUo3aHQvS1ZWUkNIZTBCeFNqeEtrWW1FTUh0T0pJMFEr?=
 =?utf-8?B?bFByejhLZFdWRlpaZnREVTd0VWtDM3JuZElhK010TkRsTWJDWTdpQWtkcW5P?=
 =?utf-8?B?Z21xVjQranlqWjBiQm5IQjJCdEtBM0tmdWd3aERKbTQrUnJ0ZnlzUGU5bTVI?=
 =?utf-8?B?WWRKZkxLUWFMWTJHTUhyZlRScnROczUxOFdIL1hyZUl5UWVscEROaG1SZDV4?=
 =?utf-8?B?NEZWUDFSS3VCTTFvWG1udEVxRENhTytUcm45R2lFL0JpaWl6ODh4UGt0ZWl4?=
 =?utf-8?B?UktTRFNvWHg5T2R5WEhPK3pqdWlqWmJ0Q2EvNDJmWTJBekN3c3phR2ZFejAv?=
 =?utf-8?B?Mkd0OEJldnlvS1ZzQUFIek5lUDhBUWU0eFBuUGljYy9kVjg2aGsyYWRpdzBL?=
 =?utf-8?B?UDQwTXIvS0QySStHY1NxbFRWekRuNXFndERoSE0raEt3dzVUaEQzYmVrMTFl?=
 =?utf-8?B?R2RRNVVnWTYzUjlCRmhkZDJZdjJaUlJWTjFUTkFqeHU0ZkZLY1RKTmY0Z3pu?=
 =?utf-8?B?M09TLzJGZlR0ZG5vdjFKRmtwdFpXLzdSV0czcUVlY2V3SHJlVk4ra2MxSzFm?=
 =?utf-8?B?Zk5ad2NYQ2dEaUpSM3lRVDhkai8yZDVFS21uZWVHKytlRjFvL25RSVZoNG5L?=
 =?utf-8?B?dUZjMkRUZTB3dlN1bGYweHBXZVhsNW1qWFJPQUlHRTlvOWx4Q1VPekpQNkJF?=
 =?utf-8?B?QTJUUW9seWRvNHVReFZvZW91dmdpUnhSZzIvQmJ3cS9aTWZDaExidDRQcUpl?=
 =?utf-8?B?b2VtbXlScE02VkdzUFBLMlAxT3R2dThMT0FnZjR4bHpTTXlGQ211WWZIaEM5?=
 =?utf-8?B?SHYyaVRmTmp1dUtnUG5uaGd0ZGpFSEYrK09uOHZ3M01kbG5LTjJIREhtVGVU?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8d5e8a-923e-4b48-55c1-08dc27176356
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 13:27:38.5885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSouO0wRZW8SzNPiFgWJXm9OsyLUVCyYXwXXRfwDjyd/+yfkAyvK/yadiwV/euluFQsBsIGzBkCU3WxJ+uQXFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6161
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 13:27:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14829

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This is now really supposed to be the closing commit for 1.3.

 ...10.201-cip41-rt17.bb => linux-cip-rt_5.10.209-cip44-rt18.bb} | 2 +-
 ...-rt_6.1.67-cip12-rt7.bb => linux-cip-rt_6.1.75-cip14-rt8.bb} | 2 +-
 ...{linux-cip_5.10.208-cip43.bb => linux-cip_5.10.209-cip44.bb} | 2 +-
 .../{linux-cip_6.1.72-cip13.bb => linux-cip_6.1.75-cip14.bb}    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.201-cip41-rt17.bb => linux-cip-rt_5.10.209-cip44-rt18.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.67-cip12-rt7.bb => linux-cip-rt_6.1.75-cip14-rt8.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_5.10.208-cip43.bb => linux-cip_5.10.209-cip44.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.72-cip13.bb => linux-cip_6.1.75-cip14.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.201-cip41-rt17.bb b/recipes-kernel/linux/linux-cip-rt_5.10.209-cip44-rt18.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_5.10.201-cip41-rt17.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.209-cip44-rt18.bb
index 32cc13a2..247330aa 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.201-cip41-rt17.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.209-cip44-rt18.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "b1dc1779a9b8e05c1b547c2b3f2b19c5829504431f09c1a82e24b98d1395c4a8"
+SRC_URI[sha256sum] = "37649406c37734e895ef7876a432a79994a4a7fe51fc4edf4ac8d34d5d0c13f7"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.67-cip12-rt7.bb b/recipes-kernel/linux/linux-cip-rt_6.1.75-cip14-rt8.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.67-cip12-rt7.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.75-cip14-rt8.bb
index 2e54a3d2..fd451452 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.67-cip12-rt7.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.75-cip14-rt8.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "5b2affdeca3822cdad6fb8a236cdad07ca14f15d6e3e9b263dc1916667586751"
+SRC_URI[sha256sum] = "5b03796de85dd71b0fc1c67ee0fb5071dae10f22c85ca7c502b5b21f141d16c3"
diff --git a/recipes-kernel/linux/linux-cip_5.10.208-cip43.bb b/recipes-kernel/linux/linux-cip_5.10.209-cip44.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.208-cip43.bb
rename to recipes-kernel/linux/linux-cip_5.10.209-cip44.bb
index 35a29fae..15d45e89 100644
--- a/recipes-kernel/linux/linux-cip_5.10.208-cip43.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.209-cip44.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "610da17b684132cc30480c496f8d75335d112ee20d683d68268d44717ae2be46"
+SRC_URI[sha256sum] = "25774a60893652d1412dafc8330f8f1fa41e2e3db794c5596283d83f0496bb86"
diff --git a/recipes-kernel/linux/linux-cip_6.1.72-cip13.bb b/recipes-kernel/linux/linux-cip_6.1.75-cip14.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.72-cip13.bb
rename to recipes-kernel/linux/linux-cip_6.1.75-cip14.bb
index 55e55786..4fdc6069 100644
--- a/recipes-kernel/linux/linux-cip_6.1.72-cip13.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.75-cip14.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "31baac22fe43d65797704c70b9bf91554f098f93b7731dd5ccbfe0ca7f0005c0"
+SRC_URI[sha256sum] = "a820699d7342d8ad8a8f580da90e03ee4db37e9d5dac4cf8d14015ab3bae5f62"
-- 
2.35.3

