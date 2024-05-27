Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686FDC25B74
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 10:22:52 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.57])
 by mx.groups.io with SMTP id smtpd.web11.24455.1716805369327755760
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 May 2024 03:22:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hFdf9ORc;
 spf=pass (domain: siemens.com, ip: 40.107.8.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8ynpPws1zWXg8IssLKIRL69l0C7dhJx6mED2Q52KY1NbrTLG/x6SHYHGGdmbtBLqeIus/havDeJq6vOf/6CcfVCbqREBZ/5ixHypzoz0yP17vPlTahJZrd0RBsn1Z6GdbcltRgALhntJKNphbC30Hdz/NHi/KOjqG7TQM/Z+csWk2RWc1QcNGxPDdVub/FdAaYmkzK9UGobCrmsYdkLcNhx1kiLoKmoV6djzJYwVy3NZF0P4oweNlr+IiVNA7DhV4Va/oW+IaQIm5mfBpAs4LId8TH+BY3Ur2ow4ehtfjn1uljEgZVzUbSBfCXtumRqucFPZQfPnB/jOARPoU4GmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91E6t9e0iDCwHR0m3ZnRfl0YCyznpiBV4k6xkeAGmLE=;
 b=h4kP/MYhqMnFfRr0XWikOJH7duk7sMHtucQvaDhmh9bt2RBAhOMhBxR4v/uInvg/RiHv59zDjBXQSJ4OJiKXTUg+R+gUlM+gOQNqX30J/9BInxLyE9TMltAoI7JTI00VLtvG1kY06n42UX5F8TX/WG8UUEhrfkplSvlDTMxQVf/zIoZxSnAzCyGLw5+VMbUt8EsEA+qzFHEfcdPqGzwjgND6BPvfyJCA7tI+iKqdEj25/iZMPFHyCiBWpsGPRSiEsyqWYsi8ChINVmK8iGgvfXlekN52NYvo50UUjVX9ASxQCJLWoHzPA6Ts4Qlbvrr7d1jRUgHmdWDhwq/NAEqvuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91E6t9e0iDCwHR0m3ZnRfl0YCyznpiBV4k6xkeAGmLE=;
 b=hFdf9ORcEjUXWpTt9uho4bTU2xlqPyAoa/4tXswcv/WIJHuQzdhP8Pcqpn9BanuTRSzAqO1iBsgzLnnERfX1+HbdCDIqQsa2fVmU2oxXtMXsjBanc4bzkH4xBn78PT8m+Jn2ebYWTHXQzcWfHM/6TVUmFlhpoA49NyethGZLSYuVLmjTuA78Y/UYr6smeCvnjapJ/oYVDBHMSJcZqI2HDKBhNOZG+QgG0/BwaHpTVdExZJ+kNFjiyVNEjj3+8x1DIxUw0R4+1eM+uHJZEM0NPft747tKd1biY6zEQ+xA84SS0Af9u/QgcOL53P4pmcxX7c1S1fhNCzX6FjDEbz+4Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8365.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 10:22:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 10:22:46 +0000
Message-ID: <b25897ad-d013-4949-b6f8-5954d39f35f7@siemens.com>
Date: Mon, 27 May 2024 12:22:44 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.19.312-cip109-rt36 and
 6.1.91-cip21
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0351.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: 7abbf2cf-92e4-4663-a2dc-08dc7e36f3a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?V1FheFVMcHNMT05IVTBpd2tPYW1ZMGo0SVgvU1JQdWpWQnM0Kzl6aEZ3aG90?=
 =?utf-8?B?R2JocEJOUGlPcVdRdDdEQ2kzb3hJb0dWVEpEa1dZZU1QY2ZXNXl5bXVURnMr?=
 =?utf-8?B?V0ZUc2tRUXBhMnRvRldTZ2NUK045cmUzaW0rOHU0cEszVndRMzRqRzg0bVRU?=
 =?utf-8?B?eGtFRlIyV3Z4TXlhQThYdjFDN09SQVNWVHdVVndNQ0p1aS95em1rRVdxb3E5?=
 =?utf-8?B?SThPR0t6elB6eDVNTkhXOXdodHRHWjd4Mm8xbzN0R1FNcTJOalp6M3RqQytj?=
 =?utf-8?B?N0N3aXRmTGNjUk1aR1NucTZQTWJTWXdJZ3RvcVl5V2Y3OVF5NHcvUGtjWkZt?=
 =?utf-8?B?b28rWHlDY09yYUZsTUU5ZGJrYzJhenM0dXViRVA1M2xGZ1ZHRTQ0emRKOGdq?=
 =?utf-8?B?YXhJYWJzYk5kOUtVMmJrWXpZcEJHQm9vVVdKQURjVERWcUJTaTYzSmVLUTND?=
 =?utf-8?B?RGViM0dmNDdHMEcrUFlMOS9teHN3T1dYSWFzSmdWRzBNeDNPOXFVS3dUWXBS?=
 =?utf-8?B?cXF5Yjdqb0Rrb1FiZG9odjVFWlRRUEI5bnJ4bmRpS3ljWVpnU05LbXd2VjB2?=
 =?utf-8?B?NW5BT25jOXBiVk1vZm9ETktiUGVZZUdWVE4zQ2VEdk82SFVJcCtqMTFhbHU1?=
 =?utf-8?B?MGFma3p4d00xNldqZ0ZJc3hBRVd5VHlucGttdkhMT2kzdWNtbFRCaDN3aFoz?=
 =?utf-8?B?Y1EvZXZQMGlvMFg5eGRGaGg3QVFBV0R6ZTkrOXVYT3BBczlEWk0xNWR2NDZn?=
 =?utf-8?B?NTBVNlBNNUJnaWhSWG9seGhLb3lZek0wODlZd0FBRDQyZVBieVZlRWhLay9p?=
 =?utf-8?B?NkJwTjdZMGlyaGRkZjZJWVo4YlViRmp4Y05EWVVzWGhpZm5sZ3lnTVNYTXMz?=
 =?utf-8?B?dGg1L1pMajc3K25HUnRXQjlXek1DY0dTY0ZCVDdZL1NVdDFBbmE5VWsyc2sy?=
 =?utf-8?B?ZzdwR1A5OHZ0L3VtbkVjOFBxQWtKMDFjT0xUQnFKQXpJc1JqRURHR0tMdTNj?=
 =?utf-8?B?TEE5RGUxMHhheFFISlNGV1U2MFlob1QwVzVnRkJCVE1XQ2d3M1d0MTZHSzU1?=
 =?utf-8?B?NHRGdlNyV09vN1Y1UG55RkVNTEU4SGRwdnVpeTNUS3IxOVpqTGN5NVRPUWVs?=
 =?utf-8?B?OWVxS0JDS1J4UzBNTmpIQW9mYm9xQjdnaEJwbEJkdG1NblNnanVTc21JWXB2?=
 =?utf-8?B?aERidHNsYnpBdENxVlJmK24ySDc2dUxqWHM2T1dXOUtTMXkyQjZJU0J6bmtT?=
 =?utf-8?B?OTlra1JaNE9UZWdBbzdhbnJRNGN5NzlxUTJLYUxPYkd3US9IMjJlZUVwN2M3?=
 =?utf-8?B?UzhrSGF6bkxoakIwZDhPRC95dzhySmdXVmt3NHpjNXJUUTNtSlk0dXYvVDFQ?=
 =?utf-8?B?UmNJbXRLaURSMWNJTld4dUxUV0o2OFVJaHdxUkErSm0wdzVVckhON1BTaTNr?=
 =?utf-8?B?VmVNWnJHdml0OFVSVFRJL3R1eXJFUXlWZXF4SzAwSlFpU0ZZcjNhRnlJY2xD?=
 =?utf-8?B?U05FbWJua1ZyZm9PS3cwU3g3cmpJRmlFWldYdkhZT2pBcXFKSkc5M3Bwb0sr?=
 =?utf-8?B?WmJGNWVVaGcrdGp5bHF3aUpXV2FMbEhkdFVlSnNBeDlsM3JpZkFHUk9SRmZT?=
 =?utf-8?B?NUx5VkQrV2NrSjVxcHk4YXI1WnIzS2cydU5VQnVrOXNicXBiamRxNThQdi9B?=
 =?utf-8?B?YTNwWmNnK3FuMGd2WER5YWZQMWZzdHlVZ09xSk1rTWE5VTRCYW5lOS9BPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WmJMUnlrbThZWDhUbnhCTFNLWU00SWZLVUNrQVBJd1ppbERwdUcyczNzdEMv?=
 =?utf-8?B?Z0xjVHQzQ0lKUGY5ekh6MzFWYnN0UE41NnNoMERzTGdUWlFZTzI3TFZJK0Nt?=
 =?utf-8?B?VkxnbUQ4WVhJK3VGYUY5bEtkUjJ5VnBnZFZGTUgyeUVMZnlKMndlb1g4TVBs?=
 =?utf-8?B?cUxIWXluTHZsUGhMa3Y2a2lXL0FPeWdUQ2srNjZoQU5WWFowSHhldkt2S0th?=
 =?utf-8?B?MWp0NzF1d2JWNnQwMlRUdlZGMU4zT1dIaURVUGdPYWI2WFk0c3Y1anliRkJ5?=
 =?utf-8?B?N1ZvUlAwUklwMXY1Y1ExQm1qUU5WVXJMNytadWRGN1dtL3NkeWV0cnoyWmZt?=
 =?utf-8?B?ZjBIUDJ1Q2N0dm1oY083cGNhSVhhME16eC9pME9NNjVMSkFRMHIvZ2p2aWpO?=
 =?utf-8?B?TnQ3ZEtuOGlaNEdyL2JmbUMxR1RKdWd0eUNJSExxeFN3SDN1cTl6Qk1EMmgz?=
 =?utf-8?B?RDVBa1VsYVRWa1RTZFM3SVlxZkx3NVM3OHkyYUxXWEM3eGVOREw5L3VSOWJp?=
 =?utf-8?B?S2UrdG9XTkJTWE12Nytuc1orRTU3bUxkMDNGWGxCd255TGd3VklualArQVNG?=
 =?utf-8?B?Q1UxZlFYbHdjUWJlNll3RGlNaHo3eWREclNjNFVWSjljVWFnS2IxUklYcm1l?=
 =?utf-8?B?NnFJRnZYU2E4L1RZQUd5M1FFYlQ4RGhleHVuYmVPT2ZKTTk0S3oxK3hvRkp5?=
 =?utf-8?B?cEdHUTdrYkM4dTBYRzZSL3dFbmMwcmNqWDVIdlRPM3d4RWw1MHBsYitrd0xP?=
 =?utf-8?B?RThRSTVWL1prZ1VxaEF2ekpNQ0VOajJGeVJzV2NsdjlrRlA4OG1DWkREd2NG?=
 =?utf-8?B?RW15T2VvN1UwZFBIU21NZ2ZlNkFUOTlKTXlYRFNRSnQ3VWpEcWtWR0Q4ZEE2?=
 =?utf-8?B?RU9pZHB1NTlzSG5zNVpFbkpBK2M5T0dicGxucTZXSXg3NXNURUY2clRFcUQ3?=
 =?utf-8?B?RVVTQitjOGxqRnpRR3FIU2tNRFdNdmhQb3hUaDdTbmwwcTdUVmFSUWtBSGcz?=
 =?utf-8?B?SzhUUlBER1FYc0YydkVobW1ZVFhoeVgvWjR5OHBJWFY5S2xtalNzMk9UOUJv?=
 =?utf-8?B?b0I5Z3I1NFcvb2hyamVHMHpLY2NPdDladWppZEhtenk2WURhYXl1S3l4NmJn?=
 =?utf-8?B?WFlacktQTHVZQWhlaG55eXR0Qkh3aVB6VG82VStEcFRMN25FTDVLOXhWaHIy?=
 =?utf-8?B?eDAwcEs0RUhQcGtnMjhhcTJ4bjZLYUJBQ0J0MHRoYjd0NXRoMjV2QTV6RzZ4?=
 =?utf-8?B?MG4rc1M5blZYMndhbGR3R2JHVEV5Yyt5UG9kMTNaYU9hcUJKVlR2cUR5czFH?=
 =?utf-8?B?U0lRclAwNlFXRk9BNmtUQ1BMbjFlSHQxSEZRSTNaMTNveSs1OUtnNVZJaTBs?=
 =?utf-8?B?emMyUnpTL2plMUozUG9pckZpM01zTlNrTkpGSEIxczFzZ0M1cU1ObE1STjhC?=
 =?utf-8?B?dE1PcUVNU2phRUdWaDkwZ05ERnR6c21iTUQzZHAyVFkxcFh3blJ5ZE15UlBT?=
 =?utf-8?B?TFc5eU4vS2sxc3Q1RHBFTUVuTVlPV1NZSkY4UlRVcE1TeHJNWnFQVkNIcG1h?=
 =?utf-8?B?MVNkRk9pSS9OWC8rMUJ0R0lrOERlczJ2Q1NlY0lPczRkVG9xTzhHYlJDNFho?=
 =?utf-8?B?TUE1bVowbDJNUFhhYWN3Qlc2Nnk3d2NxZmdQMVFkSmI1NVVKWTJ6ajFRd2Rk?=
 =?utf-8?B?NnBhSi9vTmYzMzM5a0o5Y3Q3cm9IYmRDNmM5VmlOS2QwdDZUVVN0c2ZoalN1?=
 =?utf-8?B?M0JQd0pObnZla1haMXVReWwwRCswbWdaZHpZN09FK1NERWVqRERRODFhWGU4?=
 =?utf-8?B?NzlwU2tvNUFvNVhqZWlUSkF5S2kxRHJlc2xqRUpaK3Ewemd0b1F6a3gyMnVm?=
 =?utf-8?B?MjR3ME9SYXpvVjJINU9PTWRnNEdzWU5tcTcxZXJiM1BiZi9UN1NwVWJSS3lJ?=
 =?utf-8?B?QkdKcHBxUGwyazAxbmVMM05WK1FzSWZsMkZWVXpGcFkvUXI3ZWRlZGdKY3FS?=
 =?utf-8?B?ZEVFMzMyK1h0MVNpakRGSWlRTi9yUS9RQmxDbkJsMUFOV1kvQlU5OG1iTkhi?=
 =?utf-8?B?emZON09jRnI2V1lPS2lzSFYvVzgxZ29pQTB6WHZjOTlQYjVSc21idmdZZFh6?=
 =?utf-8?B?aE4yT0hIcHRkSWhrS01UU1Q5TDJYN2pvWGozUW9zcTZQa1FBS2NGTzI5eSt0?=
 =?utf-8?B?R0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7abbf2cf-92e4-4663-a2dc-08dc7e36f3a4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 10:22:46.1529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjoyiDyy7Ae8vKyG0VIaYU3Q4eazLMzrZw3eYLQXLKe9dySSt6Lm78NqIIWR/MbQJanAqJTT9mBFyZRJUh/P+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8365
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 May 2024 10:22:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15954

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ....306-cip107-rt35.bb => linux-cip-rt_4.19.312-cip109-rt36.bb} | 2 +-
 .../{linux-cip_6.1.90-cip20.bb => linux-cip_6.1.91-cip21.bb}    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.306-cip107-rt35.bb => linux-cip-rt_4.19.312-cip109-rt36.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.90-cip20.bb => linux-cip_6.1.91-cip21.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.306-cip107-rt35.bb b/recipes-kernel/linux/linux-cip-rt_4.19.312-cip109-rt36.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.19.306-cip107-rt35.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.312-cip109-rt36.bb
index cc95e0e0..9fbac343 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.306-cip107-rt35.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.312-cip109-rt36.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "91feddff1eeb7cefe7099d3c2c5333d14287080885e82d396420226421f85711"
+SRC_URI[sha256sum] = "95cc4750293f594921577d97751f8e32787f55c7dda07e19ca2731cbe487daef"
diff --git a/recipes-kernel/linux/linux-cip_6.1.90-cip20.bb b/recipes-kernel/linux/linux-cip_6.1.91-cip21.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.90-cip20.bb
rename to recipes-kernel/linux/linux-cip_6.1.91-cip21.bb
index e2af4d63..a0095dbe 100644
--- a/recipes-kernel/linux/linux-cip_6.1.90-cip20.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.91-cip21.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "7bea37feb3001e6c11489eccbe9a1899a1a735c149e675ccd55bdacacc565d80"
+SRC_URI[sha256sum] = "fb1ddf33bdadf8a03a72824e3ed9a6e0f74247b8ed00ff41611d08ed3b31ee2a"
-- 
2.43.0

