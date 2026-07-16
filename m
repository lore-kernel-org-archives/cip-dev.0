Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDECC43458
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 05:43:33 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.22])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6329.1784180603261150593
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jul 2026 22:43:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=q72OSQIJ;
 spf=pass (domain: siemens.com, ip: 40.107.159.22, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wt0N+/Qfkr7wqHaOEB2kY3May/A1IbCOmULmi9pf37tp5b00nHUg/U6KAhIzHX00h6BA9K+lQiOk8x4L1+dT98QJpPpzsK+QEMqLP3dJAyOOoE5Wr2vntmjW1fAxA+vHx6169aIy7+/mdyN3rEVH7cMX3+EUDfZe8DjEIsUgeREh5LErt7Sj9qWMOkQ6Vye1BB6ZXm6SyK1dHRwhkyu40k7vVCHFki4DspgjkUh2qhAkvdcQnJHEkWi8GwF3BLvTeeA7ECsZMKKKY7KgrrSR6JIV0o3keCbKQsIr8LzUeVlQnXJl6K42NSrkkJHvXN2uYEGcT/Whzb/kgTB/Ft1ODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOU26BuCdZErZ0j/dazbR1f7wmrOaTY4bZB8Sk/67uU=;
 b=K2UclnAau9ucNyFRoje5L/V5FRnq9HlHSqFBvnYscWjuaI5dpSoLqguvPKAep05H+62AE3brXwevJENCLQf9ZOo+mpTy2UbE6T6jL8smZfuyKzK4AudNlfATnQCI3IqIyK9JvcDloDNmcQcO3DsaIIzBrt+9j1QXYMf1o0xCXxoIYDFhGnUiLfr7vBjkjUWqgYFecODze9nbtwk/CY4PKpe8pzV64/t6sQs3RkuCkqwGS/tB7sUfxk+qWb3cxdobd6uKnnetZyZIQwBptI25QqFSC9sPByrowBq/MQmD/j7g8NnsACL1BvypSyNnMTTDtkE10Vmej4opMh2QgAkNZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOU26BuCdZErZ0j/dazbR1f7wmrOaTY4bZB8Sk/67uU=;
 b=q72OSQIJWBt6dSBaavN5DPm+boGr4dvksKs4mosXoSxkzupDAKxDIkw8JYif75UHtD0N7ZCAE3S74caFGdJb0Cr0baTyhsBf6vtJsvAu0BXjJgMAmOjERUPKEHH25trFyE1f88IxH5jRE4jADNiUyQE9Npg5YYCkcNkDpEuvl5Q/TW++9B7f982fokj1A0ShZrCcMnTZMaCNp8EBLftDcwdRVvqiHqjd+qLyCD4P8STeZf07oBMUVWMnnrrF3Xd5U8ajsdosCJI9b/ud9mDWA7G6ivETneXCgxitJTh5C9l3gKk39ZcwgEBuZ7pENhqoYoCLGu9jsrI1A07xqxKICw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5366.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 05:43:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 05:43:19 +0000
Message-ID: <34f92500-d552-49ab-827e-9ae38e91e44c@siemens.com>
Date: Thu, 16 Jul 2026 07:43:18 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 5.10.260-cip75[-rt33] and
 6.12.95-cip27
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5366:EE_
X-MS-Office365-Filtering-Correlation-Id: 39802141-9878-4765-1be3-08dee2fd23fb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|56012099006|11063799006|10067099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	3qYq6MA/sWP4tgDcJqIq3IIdKO3i/9/bUGmoMgY4ip0MwyKPTLrH30QG+SDons9qm9e9lZGgNBk9vaoWHAs6aNPI+cEl8Krzvuavonum8lFPtsxCdcGLs+vbystzgK67PllalVms13M3as/MP9Si5V390uys2wGcV2sUy1d/GZ5baa22+7Hai9SzQE2GDfSfFSjffW/C1RnsO5Fn2EXx9Qfbg2LauFg2n7JGdxvVLPnDlE/qCtfmdz4WaPNdHQO78XIpriO4J14iCNJrC6YiX26wYl5jhrN7/DmIAaGlgWmq24k1R7XJX8R67Q1vyiVvjqlhIOr4P9PFTPt984kw8/WbS/0oGiECXGm7kCR8PM3Xj222yK7sF7JYL6cFkQovSbMW62gejBYACj/DhwFkaecnvkiVfdcYr1MFydBLVJYwTtur8bYTZu0/qmD0EM68gwlw3i0VawCR5XRy1N+HLqQhELt3TgAXHGXcQ118Oo4lA0W62eS0fUrMwEwJUoSFk1oICh2ccGkM/7SWAAUKjvmB+zUi6rlry/l7fLonOjvB1KFr27VJW7d1L+V1T/nVGqKiemZMdZzWcwywsdwx+wNGf2SyOMmdMt39wTO3HIl9ewk6uKOmgiWwevPY6qTmQ8gQw2u946BeUUp5lJiUTq/hkjLSUEERibHmDkcRbdg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(11063799006)(10067099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QzFWSWZlZnE0dXJwOUtJSllSeW50cW9nVTlVMXpRaDd1UHA5VnBWM3J4OXFm?=
 =?utf-8?B?RzRFcDZkdTJZY0hDTHNqN01CNm5TdHRrdkROaFVkaUY5Vk45R0lYcjFKZURi?=
 =?utf-8?B?RnVBVll3WlN2VlFzd1JGZFltZWhLdnB1bHB2NTVIT0Y2QStWaUU0VEJJVXVm?=
 =?utf-8?B?b3oycFFOblpyTzhiTzU2YWdBZ2R1ODE0ajRFcnRUQVV4dmhGQnBIK0cxZXF0?=
 =?utf-8?B?M2FOREVMOWwxL3hFSHZuME5NVUxscDdwTTlOUmZRcDBnUndWdXVrMEswYmNV?=
 =?utf-8?B?UTlYdzNnMUR3UVhOTzc0SkVWMkIwT2JmSE0xNlBNdXg3MmZYcnErYzFqcGtn?=
 =?utf-8?B?UXZhcE83cGhHQnI5MU5WeHY0d3o2bGg2RFhWc0Z0MCtVMEpLVllJd3pKNVc2?=
 =?utf-8?B?UDFPdEtpL1lUQkdVRzNsQXFWZHhqSEF1UjIzaVF5WHlWdS9DUEtTUGtTY3Jj?=
 =?utf-8?B?ZEFLdDlBd0I4amlQUTNUM0JXZ1doWlZIQkU0WWFnRU5zZjZUcVFYOFVhL2Ru?=
 =?utf-8?B?K0FncVZicHBVQXVESkxPbnZ4ZW5xRXhIcld3bit5a2RFQmlFV1dYb1hJZ3NV?=
 =?utf-8?B?SFRZdTNNR3VNdmU1SlNzK1BkTG5UNnNhRU81cDg2Zkc0eHpRRUcxUjVZQUha?=
 =?utf-8?B?NEFyQlZHU2d6eHRNTGdrZnZsaVlJcm5XanNIWG5LeGJYRmlLeVh1K245dys5?=
 =?utf-8?B?QUQzaGVhZ3lJRXM5UmI2UTRvSlFFbWFpLzh3bFRpRE01QWs0TWF1NHdHL3BH?=
 =?utf-8?B?ZFdIUlQzTFZSa0p6TnZ6Q2F4WThlRDJMUEh0aG1BV1lFT1pmR0IwMno1cUUw?=
 =?utf-8?B?S3hFSEM4N2EyYzNMcE0wa2s2L3NyNFlzTzlLTVZlTjBDVTdEOEhhbDdKTUNV?=
 =?utf-8?B?UU5LMkpPNm1XUktENGZHVk0ybTJxODBMa0pXZ09ZbHN4MjcrU1podHZPNkRu?=
 =?utf-8?B?K01YQW9NRnVJS3JjUHhmRmtxRzZWQ2tiRCtHeGJvWGJlQTQrN0hmQlRSdlJZ?=
 =?utf-8?B?a05PbCs1U254dUVKQi80RkRRdVMyNVZNUkdDd05Wd0FYelpveldNWS9HSk10?=
 =?utf-8?B?N2FyMGo0ZU82ZER3a29nWUFEaTlwUEI4L0RCRDQ0Z0tmTi9zMjhxcllEODFI?=
 =?utf-8?B?UUZjQTArVlRYeFlWaGV3QXZXaHBrUzhBalhZeVM0OXR1M3pkTG1ocVB0empz?=
 =?utf-8?B?VGxBc2V3VG16RDduRWM4UVhxZWdOQ1FwOHVBV2RQY3BHMGpyZW9QVzcza1VU?=
 =?utf-8?B?VGxpRnhwdWhZUTRjSEtUaithZ3JGc2RLSkk2SkFaSmkrVjRrMkxTc3ZGaDll?=
 =?utf-8?B?NmpOS1ZFdnFIMW5tTlVTVUVILzZwVXNCYmt0bUx2dWtOWVpocSt5eFBvOTRa?=
 =?utf-8?B?NE9FVHljT0tLTXV6YStXSG16S3Foc2Z4dmkwdnZVaStXMlB0a0hGTFZYK0N1?=
 =?utf-8?B?TkNHRVhvM1ZxZkR6bHRwME1MWGwwWXJFNm1WbzhrK0FXTEVINkFoRnRUVUQ3?=
 =?utf-8?B?L0s4Um5EYkh6aDUxNFM1YndjZWx4RUt1SE13blBDUGw3UU1PaVNHS09DZHE0?=
 =?utf-8?B?TzArOGxteHdVMFZUV0V0N05ydk8zZzJhQUJhOTd1UExhODdRQ21iYzRyOUMx?=
 =?utf-8?B?c1FSVjlhcXYzT1hsZkJaZStFaGVncUY4MVJMYmljd2lCdHdkSGhLMnh6MDNt?=
 =?utf-8?B?NmRKS3NyamxINkFJQ045SHp5NkszZG1qbWkzbmQyWDdOdzFsckh6V2FvU3NT?=
 =?utf-8?B?SjBhMmxtWUhEcEZhMktRMGxrdUw4VDNPR3hQaXVKNy9oeVRZN01GSHprdDZq?=
 =?utf-8?B?cDJKa2dCcEd4QXh0d2FsOEJHYkJTYXVHZkhTS0VBZWpJcDNkbThFWDMrLzVZ?=
 =?utf-8?B?YklVVVgzZndEV1RNSkk2cE9jS1pJQ0o0VWEySHNsblpFNU5DNlBaaEpZNVNy?=
 =?utf-8?B?M2tlQ0loQlF1Tm4rQ0ZFYjNQdzdiVzVHNE5OdFA5ZXRvcmp6VE1EMWlMVi9w?=
 =?utf-8?B?MGFMSmFLaEsxYzNkN29UUEk0djFYVWp5TDlBdC9mKy9ZSEJGa0FHZEtyVitR?=
 =?utf-8?B?OFlZSVUreW9pb3VwbUpySUt2MHk4MktBUUJEd3p1ZFptdTNnMkJNLzN0NFBM?=
 =?utf-8?B?U05YK0pvQjJ1REIwQzgzOVRMaWxRa1Vqa3hsTTVwYWJjK1U1aXgxQzZlTFdC?=
 =?utf-8?B?ZVJqSExzYnRiNFU3OFZESEZRWkI2cnNEVFpJdHZnQXZHV1JZV1pFSzVXelpL?=
 =?utf-8?B?NmVPZTArVVVLYVNhTlkwSGhjcENLOWxlbk5vbzVTK2ZCNjNFSzZBZDdGSldW?=
 =?utf-8?B?dGpLT3V5YVAyaUxuNURudHhaWktJOS9OcmFlaEt1aDJJTStSUjU3UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39802141-9878-4765-1be3-08dee2fd23fb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 05:43:19.2872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uv+fhSB4eyvKFYgQKuZ2zLWc/OVdcHhsaGw1iErc6Dd/2VB+3nIwtzmQe+wC+NkEnwG/PvVfIwEIkmSOLarhaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5366
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jul 2026 05:43:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23606

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...10.254-cip72-rt32.bb => linux-cip-rt_5.10.260-cip75-rt33.bb} | 2 +-
 recipes-kernel/linux/linux-cip-rt_6.12.94-cip26.bb              | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.95-cip27.bb              | 1 +
 ...{linux-cip_5.10.258-cip74.bb => linux-cip_5.10.260-cip75.bb} | 2 +-
 .../{linux-cip_6.12.94-cip26.bb => linux-cip_6.12.95-cip27.bb}  | 2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.254-cip72-rt32.bb => linux-cip-rt_5.10.260-cip75-rt33.bb} (68%)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.94-cip26.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.95-cip27.bb
 rename recipes-kernel/linux/{linux-cip_5.10.258-cip74.bb => linux-cip_5.10.260-cip75.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.12.94-cip26.bb => linux-cip_6.12.95-cip27.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.254-cip72-rt32.bb b/recipes-kernel/linux/linux-cip-rt_5.10.260-cip75-rt33.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_5.10.254-cip72-rt32.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.260-cip75-rt33.bb
index 9fe4937c..f90be775 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.254-cip72-rt32.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.260-cip75-rt33.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "650fbe9ca95dd0d3d7aa388fcc892a9f0df1dafa77f9c30f3cf76998e440f60b"
+SRC_URI[sha256sum] = "26e596bc891d4c539badf604ce34cc53049711de50d3f9495984563ee5af4d45"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.94-cip26.bb b/recipes-kernel/linux/linux-cip-rt_6.12.94-cip26.bb
deleted file mode 120000
index 9866e05a..00000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.94-cip26.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.94-cip26.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.95-cip27.bb b/recipes-kernel/linux/linux-cip-rt_6.12.95-cip27.bb
new file mode 120000
index 00000000..4280432a
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.95-cip27.bb
@@ -0,0 +1 @@
+linux-cip_6.12.95-cip27.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_5.10.258-cip74.bb b/recipes-kernel/linux/linux-cip_5.10.260-cip75.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.258-cip74.bb
rename to recipes-kernel/linux/linux-cip_5.10.260-cip75.bb
index 3d6df804..45ae2360 100644
--- a/recipes-kernel/linux/linux-cip_5.10.258-cip74.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.260-cip75.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "6f6c15a038ab580786c2c0fe3c499fccadebd0c1c0957457506b0fc01141e6bc"
+SRC_URI[sha256sum] = "8b6200b2820ed0dee04bb3824b797e77e010f586fb3195cc5965b2b8316b6482"
diff --git a/recipes-kernel/linux/linux-cip_6.12.94-cip26.bb b/recipes-kernel/linux/linux-cip_6.12.95-cip27.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.94-cip26.bb
rename to recipes-kernel/linux/linux-cip_6.12.95-cip27.bb
index 71c50324..e10e788f 100644
--- a/recipes-kernel/linux/linux-cip_6.12.94-cip26.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.95-cip27.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "cea8e7a9e8d00822a4445e096784d8add80662cd9f1f3c426ef17bb331c62c30"
+SRC_URI[sha256sum] = "4b396f0d3505a3c119e16cc67d53f9c71d9da652b07ffe96a9c150c80aad783e"
-- 
2.47.3

