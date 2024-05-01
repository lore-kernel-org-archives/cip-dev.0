Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF52FC4345F
	for <webhook@archiver.kernel.org>; Wed,  1 May 2024 21:16:26 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.54])
 by mx.groups.io with SMTP id smtpd.web10.8648.1714598184807824027
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 May 2024 14:16:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CT2e2WPY;
 spf=pass (domain: siemens.com, ip: 40.107.8.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXG3sSh6JcuJcDH+0BQLg8OjhkuoaEZWiZV3Ri5Pv5ep349dD15piWdsTpiNTeAwPg4xMk7n3BFKe0mOltctPS3oUnyjR6qUCTzMxc70TCKS82ooTIJc2V66rDdGZ9IPGlVrfwnMARMdfnaw52v8w9TGUI1W6uwESbsZX24wvLxezaLuuSbxZ9g5fMCOXKsRaXNM2EqH1lEUhMrxSXiXAec85LxhTz0Rk0coEfBsJmtQbsAsNtRa1+cv6kxaXuS6oShC4ykfLPyJNZObbpQ8NitXuFtTXWly6gWcunSp5PJlX9IQa4wYIymBRfYTONG2Lgg9X1ZwxMiG+xpLHSnYlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3OCF8NaptuJL0FP3mQdYRqquWI3/5OaTAlZnd8aOGc=;
 b=LAoe0ehMC0XwdpnHyz3mmXlHAnkltJgJgksb20Q973vEoYYGn2OJhXHEXAPK79v/4d9pcTljBBMBfEDYiv1MLDeRtGg0DDpRJ8F1l9yuKHmmloyt7hm0XjwRtbMLOOv6/zKo+74q+AjsSqug4BzeMAEdb76SxqDod4Nsvu3eap+cqMZsrVf1erLCnj1kMUBOI7DiuVHKI/ybPD+KaNnsJMKM4zLEivRzl48q/pWZNdthhMYHtx4Yc1/xv3PXFQAchi8zr8knk8ImRexz4pMmCqX0+XNjhrQwcnA2dyfa0EJMAVkpWOVb4K0h2jbFuCXc2nppDROgBuWCyP4wioAXqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3OCF8NaptuJL0FP3mQdYRqquWI3/5OaTAlZnd8aOGc=;
 b=CT2e2WPY48HtWmu/uv8jDqbXREfv7/VLu3D0RK83eRP6i0HyaQuWzzi6u++kXtb/56C6wvOeitTLVhvhL0DXN9aGFh69WAPcE0fbIGxpGmmiUNx2a8toul/oi1h7hLFYEAtn3QoL93+w41XDVErkkAZAMmzrjUSk5sgbZwVugzbSeLY7bxSSyukfey62CQw2Ex6h1HA6+dxgNw0mWnUfC8S66PB3IU0dNFkAEW+6KDCIs/3c+uq1yNWLnFDzqczT3dABogAY/1qGmFI8at81JQ9cSXpQxj9p+bEodFm2SpG28Sn9EcmI9iyzFAa8r4ggXfaj1QrSuC/VOta6ikCr+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6653.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:403::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Wed, 1 May
 2024 21:16:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.029; Wed, 1 May 2024
 21:16:20 +0000
Message-ID: <65324277-b333-4ecc-883b-a81f49b60da5@siemens.com>
Date: Wed, 1 May 2024 23:16:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] [PATCH v3] update ISAR to latest version
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Rakesh Kumar <kumar.rakesh@siemens.com>, cip-dev@lists.cip-project.org,
 "Moessbauer, Felix (T CED SES-DE)" <felix.moessbauer@siemens.com>
References: <238f7a31-1684-4503-a835-e0162e9b33a1@siemens.com>
 <20240501120001.855311-1-kumar.rakesh@siemens.com>
 <edcf5d93-d624-4a09-a613-4bc66f197b6c@siemens.com>
Content-Language: en-US
In-Reply-To: <edcf5d93-d624-4a09-a613-4bc66f197b6c@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: 97ff6e9b-6431-4502-228b-08dc6a23f282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QlFBZE5GcDY5c0xJYk1vdHV4WGtTVGRWbDN6K1hNRGNaZExmTUVjcXFNSWpJ?=
 =?utf-8?B?U2ZLcGhrWlJycFllazZ3aDFOVHVHMksvdE1pbG10VDFWTHFmeEIvY1RraDRq?=
 =?utf-8?B?SUZ6TTd5dTJTaE1WMnVvNkhMVW9qdlRZSG5VaE95bmgvTnN1cUh3T25yTUVi?=
 =?utf-8?B?dm1Vc3JLUkIwNEJrdFdoUERwcW01MERFdDdPUWZEc0ZnNXdWREIwdGM3dW9Q?=
 =?utf-8?B?dGlkTmhFL1dvNU9XelZ6SVNROVhrYnNpV0lmRWRhWisrOWU5UUtON2svKzN2?=
 =?utf-8?B?eVQ5SFNxdE03aEZoMXMvZGFwUGFoUG5YdnF5MlY0cmF0UjFrelh3Rm1xOVNo?=
 =?utf-8?B?WFNmNjNGd24rWXRDS2VTMnlZZVdVRXNwaEZjKzJTcmRvWWdVZERKeHh3TG5G?=
 =?utf-8?B?c0prcythVnkzOU9JNVlrSDA0LzZnNUhXS2g1Mnhwd3JrUFh3L0k0QUNyQ2c5?=
 =?utf-8?B?Y1FiNy96ZG04bFRLRnp1UTJua2hSeHIzVElJVmhSaGxianF1ems1NmdVTnY4?=
 =?utf-8?B?eG5nVFZIYXQ4cjdiSm5GZndxam5rWnR2WXRRM1doQ2tFTWJOTDB1WXFRc0Rp?=
 =?utf-8?B?YjFrNHZtdlp0bk51Mmd4Qi83d0NCMk84TUMrYmo3RWZ0R3lpMm9PRVp0akVi?=
 =?utf-8?B?WUlmZGNSZUF2SkNzUDlCdzgrblp2dlAwdE0yU1dwcGxlTGk5eUEzTmFNNDBx?=
 =?utf-8?B?QURmYThKcTBxQTFSRWt5VTc1ZStDT05ySGVOM2pjbHdmckFXR2t0UC9VaElE?=
 =?utf-8?B?UEFTbW14NTg5QVVTWTllTTJQK0R0SDk5c3gvNHZveEsxWWIxdlhMUkVpdU1w?=
 =?utf-8?B?TkJsbWwrWWpoNi9iYkF0d2RpajZmeXhJbGhhY2ZpL2x1QnFNeHF1WXdiRTZn?=
 =?utf-8?B?amhPeWFQdFpWMm54aVM5ZVhTM0NuMHhTTWp5Z1d3QXB2bG91S3FlZHBKcnQx?=
 =?utf-8?B?NEdUT2I4TFRMd2tXdnluNk55ckRyZm5pOWFQc3drYUFPSlhnYjJ5K3JBWWFE?=
 =?utf-8?B?c2o3enFCZXpLMTdMUk41VkdaM2JnYmpyODV4WDNmQnRwTitaYUQxSUd1S0l0?=
 =?utf-8?B?cWZ6RHRqcktTRFZzZkd6OEZRMUtsdFY1UTJtRm5GSnRHbi90YlBwTE1IZmta?=
 =?utf-8?B?UVZkdDZ5eFRNdGdLTWdsalpsTVF1NFNNYmJvUkZ4Z0RwWmE3RzgyelFsaVA4?=
 =?utf-8?B?TldpVmxOMU5zY2x4RStSOVEwa3ZhZ0dRS2pYTy9jUk1IbzVHdk9WN05aa0tH?=
 =?utf-8?B?ZVd6Mlo4Y3dnZWR6RTl4dHlUdkhHbUIzVE44L0hRaUhXY0dPbUJ2U1FPSG9w?=
 =?utf-8?B?SGZZTWx6dEZZUTJuM3lKOUxIeU9oZ3hhRnJsRkdEam5EcU5EeDdQWHk1MlRY?=
 =?utf-8?B?WFhaSW90MlVWL2lMZEVwRGlPb2o2dzNOQkhxK2lRcEc2d1FPblRxKy9UYUJH?=
 =?utf-8?B?UlcvL0FmN3RJQm5vQmFqOWJrQzVMYkpEYmx5cXlvd2lJcmRHK1d4UHZQTXBY?=
 =?utf-8?B?Y0RZMjIwWnE2TWxKUlZBYzNBMXlzeVR1REliN25EbjVnbkNWWG0rM0ZFTEJ5?=
 =?utf-8?B?a3ZKaTRuQUVrRkZEQlpvdndVSXRtd0xqT1UzK3I4N1Nob0xrYlhqVXlJRCty?=
 =?utf-8?B?TzJrVXlkN2syNndma2hTUjk0dWsrRTdVa2s0cTlxcmphbHR3TTZ2QXFnWDFN?=
 =?utf-8?B?UERiVEJEa3oxaWpyU011ZzUzOHdyQktod1lEWGgwUzc5L1BaejJEVmxRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TWRZWkdTYVhUSmUwZlg0clVsWXBuZmRTb0ZsSU4yWFBvaHN1ZVdJLzh3TlJK?=
 =?utf-8?B?TkNsK014a1V0Y2tyTURYdVZURDM5MGNhVXhRSVlHcTg3QXMyaWVuWnM2dGdP?=
 =?utf-8?B?MWIxb2ViblBOZ0xrUWNlQnhBZGY1aHJqc2M5U1BBL0VEUXRvUDFoVnp5WEM5?=
 =?utf-8?B?eDNCVG5TVGZYMk02T1cvRmllclEwUkN1ejZLVE5KK0lra2J5YkJ2QjR4VStx?=
 =?utf-8?B?dU9reFpKZVowZnJTYlF0SXhJVWdvZUtjTGJWdHNCN29telY1azhacjFiY0Zn?=
 =?utf-8?B?OEhvaUwwSk5zQlRMMVlvVE9zZEdVUHovM1I0MUpNYXRiU2pDbHpoMGpqSmdO?=
 =?utf-8?B?a1pMMDBzQk5ZVUdHUFN1dURRcFBOVnNqTHpCTHFPV0dMY2pRcE94d3BZWjRy?=
 =?utf-8?B?SjhOb1lleFNzVDBSbGlqMG5Vd3h1U09SeXlsTjV0bFV5REMrSzFjU2RhN1pn?=
 =?utf-8?B?WnFQZjg1VFppVjlDY05MNWNNTW5lRklGcEpYZnl6cnRRRFE2bHJtWmExeFFH?=
 =?utf-8?B?K3FUVUhrVXBZRW5ob2s3SjRiODliWUg5MDVkbHNId3ZMUHd3aHlvTkxvOVRZ?=
 =?utf-8?B?R3RhUCsxSUU4ajRWcHRFbzRla3BoZVpOdVRtK0pWdFRHcHZkdWIyNFB4NkNL?=
 =?utf-8?B?eVdPZGJNYzR5bzJTMDMyTTVOWUdBY21ZUjFOeVoyY1ZEWDJMUVBmYUFjVHk4?=
 =?utf-8?B?MmxOT29XKzc0aW5RR1VEY2VtNTNGVkdhVDJ3TmhLUGpIYmduUGZUcC9uWnQ5?=
 =?utf-8?B?QXhpOW1wbEtxSDBvQTN5VkluTUgzTjZha1ZwNHV4NE95dVNOd1RRWFV1cFEw?=
 =?utf-8?B?ZUdUV2ZjTkZ2N3kvbDJkbTFuSUdIN1BVa2x0TjZHeFpwMU8xMGhsbjlxYnY2?=
 =?utf-8?B?SkdRRmxXNWR5MEFEUGlXOW5xblZ0NXY1S2RQbXEwTHppeFg2b1ExOXRVMDhn?=
 =?utf-8?B?THdZM3F5VkRhQjJIb1Z4SVQ4S0FGaGJuNG9YVkE3bjNCQjJvL2xrdXNQcnU5?=
 =?utf-8?B?ZUt2dExwTnE3RkpabHYzRkhEbW82dEU0V3dibmowUko2YXhlREplV3RWd0py?=
 =?utf-8?B?YURyNmRYVTFKUWhsZTVBcVdjRWx0cVNWb1pFVGJtVHpDS3RHY3BOSG1sNWpP?=
 =?utf-8?B?S2NXdDkvRTRDZ01iQzc4MExMSXVzOWNyV1p0Zm9EWU4wMFZKK2tTeDV4b29j?=
 =?utf-8?B?QjltL0xJUnI2Sm5adWUzOWFHdmVHQko0T2duS0daZDQ3NFdFcmtJMG9MaDZl?=
 =?utf-8?B?U1RTNklWTUNKRzBKZk9OTzhuZ3lpZVF2Sk9Ya21NcVZjRkIvOTh2MGU5R0sx?=
 =?utf-8?B?dUJscVUwMWtPb1lUdE9xYzVQYWlQSWZUZEtEQ3JMNFZwa0xWcGEvWjMzSmJ1?=
 =?utf-8?B?U1haMFF3dWV5TGtrV0ZnZ0NCdzA1cDJ3cUtyRFBDZzYwSjhkenFxUHQwcFlk?=
 =?utf-8?B?RnVJWnFJTkxVSks3OGI5UnVEWEdBVmgydlFZMHZiL2ZScmxZaTBib0s4ekM2?=
 =?utf-8?B?Sm9BSDRVbjRZZk9jblNNTFBJRHMvRGYvbHhTVlBPZmZTa3l3ODYrUUhNd1No?=
 =?utf-8?B?QklLMy9wcjBmenY1MWFlN1NhTTZOaldqT2dURE1ZTG4yMzBQTEhWVUJRcUtm?=
 =?utf-8?B?TkJiNUNBWm5hY1phWkdJRXN6eldONE0vOHkrZnJPY0Zsd0owK0N3VnltV3pQ?=
 =?utf-8?B?cGRrbDFObUNsVzBtTTY0NjN5cnhxWWlTMFg2eXNweHJBNWlpaTJLcy9ZMFly?=
 =?utf-8?B?K0I3L1pZeU9LaGFxT0pkaGhMTC9lYUZnUjJIV3VyYzB6alFiQ2tqL05lbVh3?=
 =?utf-8?B?dTNIb3owdmVGaFdOZ2xMUkRIellwNG8wa1hOK2JORVM1c3lkK3VYenVuaGlF?=
 =?utf-8?B?OGx2RGtKTUhHa0lQMmNFcnQvUWxUOW5RckpGeVh4NEE0dVZWdmdZZDJCLzda?=
 =?utf-8?B?eHBnazVMelFSOHNoRnN0KzJ5WFdxZmRValRtT1VrVi9paWxPOTFLMHNkQUJQ?=
 =?utf-8?B?alJGMEJXcFhHdGhwVEo0a3pyYUdTcFFQT2NuU2lNa3N6WktzSmdnMDZDOE02?=
 =?utf-8?B?U3l6ZUNoL3pLbWVUOFBiZ3dDbkk5bjRUQWxKQ0lVakx1eEdyTlhtOWFKai9o?=
 =?utf-8?Q?n74bSSrLurSij5qywDKprZpcD?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ff6e9b-6431-4502-228b-08dc6a23f282
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 21:16:20.6079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfVAlOST+cLotvQsQtbOsiN4b7tz7Z42D27HSws7t65tS4hUpn/AJz6tRKFDA0FBuSPOxkz+A3tE0vw/9FGbTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6653
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 May 2024 21:16:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15790

On 01.05.24 22:54, Jan Kiszka wrote:
> On 01.05.24 14:00, Rakesh Kumar wrote:
>> One of the changes is DEBIAN_PROVIDES, which is required to
>> resolve the duplicate Provides problem in secure-boot-secrets
>> to ensure that the build process completes successfully.
>>
>> Signed-off-by: Rakesh Kumar <kumar.rakesh@siemens.com>
>> ---
>>  kas-cip.yml                                                   | 2 +-
>>  recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc  | 4 +---
>>  .../swupdate-certificates/swupdate-certificates-key.inc       | 4 +---
>>  .../swupdate-certificates/swupdate-certificates.inc           | 4 +---
>>  4 files changed, 4 insertions(+), 10 deletions(-)
>>
>> diff --git a/kas-cip.yml b/kas-cip.yml
>> index 2c3c8b0..1b97bd5 100644
>> --- a/kas-cip.yml
>> +++ b/kas-cip.yml
>> @@ -22,7 +22,7 @@ repos:
>>  
>>    isar:
>>      url: https://github.com/ilbers/isar.git
>> -    commit: 9dc362cd7115074c0f60843e687ed89db5c9339a
>> +    commit: 36c711e4ed6d5ca3c8ab71ffb4a51e78615aa1f0
> 
> This requires also SOURCE_DATE_EPOCHE-related changes:
> 
> | FATAL ERROR: SOURCE_DATE_EPOCH and command line options can't be used at the same time to set timestamp(s)
> NOTE: recipe cip-core-image-1.0-r0: task do_image_squashfs: Failed
> 
> I suspect we can simply drop the source_epoch block from kas-cip.yml 
> now. Felix?
> 

That error above is from squashfs.bbclass. IIUC, we no longer need the 
command line options for reproducibility, thus:

diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
index bf72133e..b39be0cd 100644
--- a/classes/squashfs.bbclass
+++ b/classes/squashfs.bbclass
@@ -31,12 +31,6 @@ SQUASHFS_MEMLIMIT ?= "${@int(get_free_mem() * 3/4)}"
 SQUASHFS_CREATION_LIMITS = "-mem ${SQUASHFS_MEMLIMIT} -processors ${SQUASHFS_THREADS}"
 
 python __anonymous() {
-    # Set file timestamps for reproducible builds
-    source_date_epoch = d.getVar('SOURCE_DATE_EPOCH')
-    if source_date_epoch:
-        args = " -fstime {time}".format(time=source_date_epoch)
-        d.appendVar('SQUASHFS_CREATION_ARGS', args)
-
     exclude_directories = d.getVar('SQUASHFS_EXCLUDE_DIRS').split()
     if len(exclude_directories) == 0:
         return

Jan

-- 
Siemens AG, Technology
Linux Expert Center


