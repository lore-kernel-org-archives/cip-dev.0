Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09489C2BD09
	for <webhook@archiver.kernel.org>; Mon,  1 Jul 2024 05:08:52 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.58])
 by mx.groups.io with SMTP id smtpd.web11.12817.1719810530587639677
 for <cip-dev@lists.cip-project.org>;
 Sun, 30 Jun 2024 22:08:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MnAQpUWT;
 spf=pass (domain: siemens.com, ip: 40.107.22.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMUp4o6vCq9kvrop5lc7mIXAe+DJydrWrKNVd7QoiMvr699B4Wb14cUk+1MJyG+1fcDdKYxHalJjrNQEj5EHFiFylXtb/OZUuAR1xq4p+YCBzfa39hJZxCA86xOtiJ+2BaCB5NhlSUYuKDpS22je/rCAAd9+73/SghJkYZkbFm6Mp387DzN3TAoQ7FurpHKAQEaAEBmGQW+qWH5ea1fjR70NZExBgR4R/vdUPlrCRKezwjvY9s5Z1ZI5F+eOTJO5/cZcKMiYkDQuFxZmNT+gIkS6Sc5zrqiYVVq50aeGkrQt7XdYhInv/6ZhFXcWG+J+WqxVs+0gRiTtz+MomMxYuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DyE4PMKgnjV6ZVG5iBxnaofL+R9iYzrtZPl7cqlMwA=;
 b=FwOi8wNHbhFqD8iKN/iI6MsiuOFwbnTR3CTNDV/U9XwGrUZFUuMGJzOau3KXx+AGLju5fNGBrNq8eOwnIxjucz5ft0su64apIkdit+x3XjJCSned+rxHZfC1NXkU8Wg2vp1hYFSIxE5ufz2HkJctj4mnAz/+ifzVC6Dkj2SqzF6RNcUSiBlvA6ZcYHVWOUOrNwqOvzcs2r3LDpjtp2MDjJ4SMFe0Es1DbD+e654+zvcq+/f3kLHYsn++hKxf/vadH0SHnwoktkGajhtxdqFWvqBLAm//w6IEylMia1vV/aE9t+CJw+f9RJm5DnNiunXJ4iMM9A4O4eFWDYr8kCPUbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DyE4PMKgnjV6ZVG5iBxnaofL+R9iYzrtZPl7cqlMwA=;
 b=MnAQpUWT0CixykPBTlIzGPql4MJ7312Y4ky1kWyT5kzrRcOvPupJng7BlFh1ssrbIuInZ2Jk6VBCz7WAbuTotBj2sS7Zl93OTlckx17//6vp3Oh4B8VKHSuRnr3wLJjAe8MQd6yTvSI9u1bItq7bW9zUYIIB1E06Hd+5/Y0lfigx0TO5lQGNFqaFZYx0B6WwfXKyMEJSjIhjTvxAh+lBDXamZSmy0jSydwAB6TQJOE9bDO4b+TTcbZ4ecvMvf25F4SkVqcS735dZtF7BbQvFCFc57wQOzpwNeUrLnuMrtNNdBiO5UZdwnp1YDgTopzueZeJJ0UBZGy5XFeIZFT056Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6038.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:575::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 05:08:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 05:08:45 +0000
Message-ID: <063a4e8a-4daa-48f4-9dba-2df7961f5b95@siemens.com>
Date: Mon, 1 Jul 2024 07:08:43 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] ci: Only allow IEC tests to still fail
Content-Language: en-US
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e40e56-9e92-4f15-9282-08dc998be237
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cjBpRVZXdzR6Y1JIeTJFWWJETUFwNzB6Yk9jenhZSHBkalRNSndpcU9lUFFn?=
 =?utf-8?B?ODRzVW10dTRZL2ZiU3cyUHlSZUxpbEYvRHNTZmxtK0JXOVBwTGl5bGo5OENj?=
 =?utf-8?B?QmhhUkJicXN2QWQ3S3F0SDJhMnIrOGRqZit4ZjZVdDNUelZTVTVnN2dCcm0v?=
 =?utf-8?B?Nm9KbUYzOERZSFhGLzBLMmE1ZmYrSHR5MXdHbmZXemlIR2wvQVFKNmtFMzNW?=
 =?utf-8?B?Ymg3TEZibjgwRjBVWTBwb0JnTjIyNWdPOCtPRmxlK1N0WCswOEZzRC84d3Rr?=
 =?utf-8?B?a3U3VTdUajlpc29sNkhJTDIxdnJlcGlNSzY5STYzUTNBSUVTOVhXTHlBeU1J?=
 =?utf-8?B?ODB0ZDFteFJDaE4vejA1VlRHR2hwOUE4RGxtRXh0SzExMi8rRXBRU2pXZm14?=
 =?utf-8?B?L09IWHVZcXZxVUU3NUFIc0dSZGtKN1c0dnNBdXRHMjlBNEpjNG5QVW1kNmI1?=
 =?utf-8?B?bFJmRmNINjU1cjBSbDFEYk54SWpXVXZ2RWwzRzR5dDhhWks1UUhIM2d0Ykg2?=
 =?utf-8?B?bmlocTMzZFRUUlhmeDZaQXVnMXZ4Z1J4Q1A3VU9UbGVDaGEwczhqLzFNY3U2?=
 =?utf-8?B?bHlaRFRqa1NNWEdrMEt6M0VrVnAvSGxYeHQ4clltYjkwZ2RzQXhsUGhrL3lp?=
 =?utf-8?B?YmF1OEtTZVRseU5oaG45L2hSWGZCZTVKbTRBd0xtdWJ5WEltVytyWkdEbmxS?=
 =?utf-8?B?RWx2OUNzei8xaDBMUG1qbXk5WmxEdXRkUko0SXhxL1hLQkMxOTd3cjVmQUxk?=
 =?utf-8?B?eW8wRTVFdkJoU2MzWWNPL3RrQjFQMlFFQndJSjhac1VQWGVZSEYxb2V1S3dh?=
 =?utf-8?B?bkRXRDVVcjl5OFg4MTVTNUE5cUMxMkp0eDQvMzRkRDdWY3hzL0h4RUVVUDBB?=
 =?utf-8?B?Vm4wKzB0eGZORWN1VmFYOE8zS0VFMkk2b3E3OFRpZEVHRmYzOHVNa1dhSEMv?=
 =?utf-8?B?dDNBbFExZlcwNmt1MlpSSkVZNk9SNUVLQjF2WVhrcDZ2UzdueVpMRWRTOExN?=
 =?utf-8?B?YTNTbUxWbjNYRFpSUmlxOGlGTkNWSDhQM05aYkdla085ZnhYdXNhanJHek9R?=
 =?utf-8?B?NkdXZXFYWnErWlhyTkdXWHE1ZlVtcnRIOVVsaHlYNFlYREFrd0JmV2FvNUw0?=
 =?utf-8?B?NUVXVWZTMUhEckJnVU5HU29KWEl3aDN4QlhOd1dXSW9zV0MwRkZBMXJ3Qmdl?=
 =?utf-8?B?czF4SE1KdlB1SnEyaDBxRzUwZEwvLzhTWGh5SjhKcTJzK2s3dG9BODlGVzdu?=
 =?utf-8?B?eVFKcUNKdHlZY21xYmR2ZmJsQWs2NG1Ja3loaDY2blZjRXVwS3BReUtlYWNF?=
 =?utf-8?B?cnRpUjQxajFMKzV0dEg4aUdyTWRGM2x3YUNVcGs5REZMamlJMVNORzIxUktp?=
 =?utf-8?B?R3Qvdi9BU3dsZS9CQkNnL3hMRGx4K015OVFKQkJReVpzRE1ZWlhVTTR0UGEy?=
 =?utf-8?B?Tk5ib0lYR0M0Zjc4SitoZHVtVms4cEZZTnZZUWY5bmt1Vm5pTEdJbW9GT09I?=
 =?utf-8?B?b1FsNXhZODVyaFV2aHZ0ejV5TTRNUGgvYmlxWmlLdjhPUUZlcmlrb0RkM0R3?=
 =?utf-8?B?NzFSUEU0NGd6UkF2aE9XMnB1bkFXR3pvT0NkaGVWTlUxbFk4di9VdUE5OU9B?=
 =?utf-8?B?dWkzemZEd2Q2elNEbGpYVGwySjE4U2dBalNuVDhtNDRmY0xkRWpzWkRrd1lj?=
 =?utf-8?B?Z3Rtd1NPQVRORXNGSnpMUlpYQUpRaTlEZndqay9Ya282ODNqbC9SdmU0TlNT?=
 =?utf-8?B?ZFRXR1UxWWN3Y3h5VTJLMUNBa214cDRaVU5VcytKYTZ6SkV2aVM3c3FFdk8y?=
 =?utf-8?B?QnFjMUEwTDN2ZEVRQnI3QT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UHdPWCs5aUw3MXlyL29McDhqSk4xYTBtM3Jtdm9taG5PYkR0N1JhQ1JVSCtQ?=
 =?utf-8?B?b1hYcHRXRVhuSHIwRlViaEFNMGdoNDNZYzlISVd2YVZUSkNhK2xlVE43WExp?=
 =?utf-8?B?SUhBRWs2N0UyY0p3eFgzYmFVUUZ0ZFpnWDBFRWxSaDRhdGw3c2dISTJBSyts?=
 =?utf-8?B?M002VU5kcFJGR2swNFEvdGlBVWprMWJ1TFFHbFRsYlBvUkZBYVhTZUFaMDli?=
 =?utf-8?B?NC9LZ2poV0VFVFNCQWxBL3V0V1U3dkkxK09NV05RTHZ3aUdIY3pEais1VXBn?=
 =?utf-8?B?TU9vTldLYzdHTys2WGFTRVVXdkdOOWFSREc3L2JUaGhYTkJvNVdwZGJKMzhi?=
 =?utf-8?B?YUpVWCt0TzNGSkQzbHNKVW9nRUx3Z3FlRnRYVTF2QTZIK25sZHhtVWxQMWtZ?=
 =?utf-8?B?bVlsM2lMWmNyRGNRUUxzK0JVYVQyVnRVQXJDSFVWd0xiemlsblRkUEEwZ3RE?=
 =?utf-8?B?NzFBb0I5V0d3TXNiWGVXa3ptblJGNVFWOE5SMVB6WW52bDQxYmZDYm1hRHhC?=
 =?utf-8?B?Z2sva1VHcFlJUEF4OVVyL1Z1dnBDK2IxQXhBK3VRYmJXdGFOeDJ0OWpyQ1o2?=
 =?utf-8?B?SzBma0tPOWJkWjJZc3h2MHliZ3cwYTNHd0VQOGhoclBrN005OEFwWkxBcDRT?=
 =?utf-8?B?TkM0aTFNM2ZROFdSMW9CbmU0ZDlZRmlwd3dJd21EbGtmVHU4NThPK1VhZUtz?=
 =?utf-8?B?aVg2dzNpTVZ1dFBBVXVVa3VXdmg0SUw3MHZ5N3Y3V3ZtRThiSStkeHViZkEz?=
 =?utf-8?B?VUZ4MCs1ZWJ5dTk3YnpWWHNFejVyWDJqYXR0NE1DV1hUd0UxVWZnTTc1STRw?=
 =?utf-8?B?bHZWNnFreWFuUm9reTVpcUxOaU1uMndwU0wxaU4zLzFrWFVoUVVlTGI4Q01k?=
 =?utf-8?B?eXNIZjl6aFcycS9keWtMVDB1cmdXNzNhZHg0SUdmWU44bTFlK0V2bzZrL21W?=
 =?utf-8?B?d25Vc3BpZkpScnI0MUJ5Nnl3OExtM05TY21aMlkxUHExUytESXdHc3JpR3VD?=
 =?utf-8?B?NUc4SG1odGUxaXNOSU0yMDhRYjNZb1pmMm9ZNkVaNEZ0dXBlM21sR3lyR1F2?=
 =?utf-8?B?a2cyL0dBNXliZCtsMTNXUTdlTm8xTlVqSW55WnY3eVhSbWwwUFdnRWpmME53?=
 =?utf-8?B?akJnTDlpdzdmOHVRb2VDd2orUGNJSHg3MFMxR0txQUZGNDI5VmI2SlN4eUU3?=
 =?utf-8?B?S0pCUitCMngwSDlKcm1VMkFQeGpCaG1jNEowWFV5RXhZWFFCUUI3OXFlTlVi?=
 =?utf-8?B?TkRkb05GaVFycDZZa2xCcVJOUFFPYWZSN094ME5UUkN1TmxnakQyWjhtTmdj?=
 =?utf-8?B?MjBUQmRETGx5SjJBWjUvNWl5MVU1S0Jwc0tGK0JGOFBONzN0Z2Q0S3BOTzhj?=
 =?utf-8?B?ZDNyTXl2Y250VUxBY1ZhdHA0eWd5WmhiOHk2WDVjcEMrbWVTTTdiaDBVMU5W?=
 =?utf-8?B?dlltZWZ1V0JScUJGdHIzVU42OERmWlBKaXJGcnlmaWY2MmpVRFZ0clhFK1FX?=
 =?utf-8?B?bS9sWEsxOG9xOFprNXByWWl3M3FNdzlwSFlCbkdjRXdwU0VUSTliU1NaMENH?=
 =?utf-8?B?K2N0enNlM3Ewb0daTVM2YWNJUXNUUjE3RUkzUmNaWkdnT3I4bElRS09qdjdG?=
 =?utf-8?B?ME1RWHAwelp6cm9BN24reHlMcUVaUWdvZk5OOUdBRWNkZ2lCaklIbmh4WjM4?=
 =?utf-8?B?YklXWFpXN01zcVdZbmtKWlRaVWFNa3l5OVZBM0pGV3plbFhaZ3FuN3gybER1?=
 =?utf-8?B?T3NHV0kvM2xMdHR1eklHRXUzRWZONC81S3ZpM1FGbnJRM2N4SDBPNEk0UW9E?=
 =?utf-8?B?VFJtTDdWSnZQWnZLQXE2aktROG1aRW9rZVJBb1BNSmFJRzIwOVh2YWJzVGp3?=
 =?utf-8?B?OGovZ1RiazlmaXlxZUQycE1XM0JPM0ZKOGhQVEFtYXFuNXJwcTNScUl6VExS?=
 =?utf-8?B?b2FNbStpVytwZWw0THMwYnlucjVXUkw5aWxyRUZpaFF0RTQ3ei9wOFdLVDNt?=
 =?utf-8?B?UW43ZVRUZkEwZmpqSkNYenVyVWZlSFJ1MjJRUkhVQXJNbDVRL0M1Q0toZW1T?=
 =?utf-8?B?OXRTQTFKdUMzRmtjVHdQM1d0RDU1TVNqbEo3bGtKZUd2K0lGY0QydWtqTk1v?=
 =?utf-8?Q?gLdO1iwUcx+arJQR66F1m3jJ1?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e40e56-9e92-4f15-9282-08dc998be237
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 05:08:45.5573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSsA2RjkIBKvsAG3oxgxcSnPo4RMyeEx1mcgOT1bo7/gtaq9VVBwvNJxt1aNikJJ4CsWkbihj30r+uS7gc9kbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6038
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 01 Jul 2024 05:08:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16351

From: Jan Kiszka <jan.kiszka@siemens.com>

Secure boot and SWUpdate tests are passing now and are supposed to keep
that on future changes as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3cb98f7f..683790f4 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -354,7 +354,6 @@ build:qemu-riscv64:
     - if: $CI_COMMIT_BRANCH != "master"
   tags:
     - small
-  allow_failure: true
   script:
     - scripts/submit_lava.sh ${test_function} ${target} ${CI_COMMIT_SHORT_SHA} ${release} ${CI_COMMIT_REF_SLUG}
   artifacts:
@@ -437,6 +436,7 @@ test:qemu-amd64-IEC:
   variables:
     target: qemu-amd64
     test_function: IEC
+  allow_failure: true
 
 test:qemu-arm64-IEC:
   extends:
@@ -445,6 +445,7 @@ test:qemu-arm64-IEC:
   variables:
     target: qemu-arm64
     test_function: IEC
+  allow_failure: true
 
 test:qemu-arm-IEC:
   extends:
@@ -453,6 +454,7 @@ test:qemu-arm-IEC:
   variables:
     target: qemu-arm
     test_function: IEC
+  allow_failure: true
 
 cve-checks:
   stage: cve-check
-- 
2.43.0

