Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7B7D31A26
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 08:23:32 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.24])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6018.1768379007274458028
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Jan 2026 00:23:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sC7GyyV6;
 spf=pass (domain: siemens.com, ip: 40.107.162.24, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRtB9q0IbmLbqTfFGG6L0O9gHI6iOb3/AAPsi/uDTlyZHbJ7eZ1Met7+Lg5a4npBF5lyJO22gbGorqotzM1xmDqcuq6uqcCBHJqurD/ZkjfROMz+vICWbQVFvifJWBnIkN50jlkBCj7ckotyZwyd0ArmcehvZQU842KlX8Gznk7wepgmi+94Odj2QGyWql98155EI7FnaiJQeArkkBZukLIkWd4ek3oadTMalBkCsRetAuBr2XzWR+lPgMTRWWkfir7t6ytIUrV/mjcw5EusoeexC8vA8NvDW+XAMy1GrXRSjSTBOK7Wi2pHWo3dPuhNozZsIhJp/0HlNqfJzRZRqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgQydUOsNv4Bc56WVq6lbnYIHgYUZlT7gZB4LmM+xhU=;
 b=lB+z1vPjY45K7U4MOTKb2S4GZNppDBb09HDkf4hI3Os9oYnuC2gjxZG8LVU95MqQfdZDEoWBioFqR8TBJg5zrtt2gXyzVffCCMQPDEwS9DV1dqiL0CKY7PVB3Yh8NSXIt5sFgtVvwOPlqQ2mvlleY7QjJmG/QUSXMbfRLQdv3M2g63NhRXU5BrwXcNyH3GZUGz93Uww/MwtU9t077Nxr2YIkId0WR+M3lnt0prsbe7do/TncskXBW5bOJEbRPg0OF36wlIpvkjX+nosSJv1/bikcR4XB6hjFTv2s3NU+hRd4xZMj9BUdsOgtZ/EdefUpV1m4nt0VBvggjstu9OBR8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgQydUOsNv4Bc56WVq6lbnYIHgYUZlT7gZB4LmM+xhU=;
 b=sC7GyyV6auWbU8b32dROLI0xzsGxu2bsno3E22kYyqcaQ3kIYOgmDj6fo3aDdhvnC53yWDP3pxACz7f78XC08ii1cEFeRw4oHo7EjHwQiQ/jmLUEHzwe5U5bGRHFxjk3SAi/s1MbHpiwjkHMSVywUDqecKISgCG4DF5Mx4pAnlAdHCzxjcKb/ymLT9jNNojaGh4FtqmY0vp8Uv7xzva+k40H5nuA8uiUk13ApWHvu4RFgzvOX9MNrZopSwoh8Bfdn4KiV7VtjWLACzhZa+c1ZSZN2M+BOLsDgBaDBo4T2ddKHULRcavfpFveG5jv3kMHbwQ9Sgwm8xBmqlHSuVy/Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6229.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 08:23:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 08:23:23 +0000
Message-ID: <6536af6c-abcd-4c20-bf75-ace70e85b985@siemens.com>
Date: Wed, 14 Jan 2026 09:23:22 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip106-rt59 and
 5.10.247-cip68-rt30
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f690a5b-be76-4d54-93da-08de53462f31
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NGZERkdSOC9kKzZiV0RudXR2czhFYlhGYUo2RHRUbjkyT1MrMDhiNS9SQzVa?=
 =?utf-8?B?OTFMSEROUjlyVWZkcUpQSjdhWHBEbmhtSWFBMnlSSTdjOGd0OWc5WVhXazB0?=
 =?utf-8?B?Ukx0clNHYWUzbUE0ZXRJU1RGTUZSQ3VHamx5ZmVUT3poa1RWY1dkdGx0eDdO?=
 =?utf-8?B?T0xxUW1SQWhkZW01Mzc0c0FoemFJRzZCMjNGdXhLS1VvR0VkUHp1NzBVVlJS?=
 =?utf-8?B?NGtrcVh3RTBkdm1yblZIYnBiTlpBSzUzMEdVSjQ4V2FsNnRkK3JoanpaWDhP?=
 =?utf-8?B?RUpQeDA2MFlqK3dNaWlhTXFURFltTVFLT0xucFVwK0R1L0liVUdCNE4ybUNM?=
 =?utf-8?B?WWZDQUJ0T05ZUWlCZWZlSzZEQUhnM2ZpQ2k1ZENCQmhiMUdLV2ZaYkxMM051?=
 =?utf-8?B?Rnc1ckpEYTJUU0dJY2VoYnFQK1I3ZlVneW1oY2pMTkhKWlZGZFVvWlNMbzZB?=
 =?utf-8?B?YklQQjhCSjIzM2ZBMlBkWlB2RGQ0STdMU0xPcVh0cHk3MTk2U2NlaW8zVkdv?=
 =?utf-8?B?NmtqZzBqTWNZMnRlSnIzY3ZHRnVzbmFYNU00ekFyUE1DWjNuK090dEhQckVs?=
 =?utf-8?B?U2xSclZua212VzdGbmptK3ZzeEpZS1loSDNsVUZkUmIzSGh1WlQxNm9jWStG?=
 =?utf-8?B?OWFVb0xhQ0p3dW13Z0VyRUpSOUhpRUtkc1g1RlRtSmptcWVkQjhtZTNjcG90?=
 =?utf-8?B?M2Y3ZW1vbDB0VXhWQ0hvR0YwVDJZa1dmRjdTSjYycWwrVEhzTUZOMitwMTI0?=
 =?utf-8?B?SlVYRk1JNjlLOEpJL0xiV0U4ZDdRK09iSlFudzQ2UDFxd0QyMk4zV3gwanlw?=
 =?utf-8?B?cm51NHhEWjM2RVQ2alV6bVpGQnNNQ1Z0RFc2K0czRlBlWTdSQ2VsdDJiNVU4?=
 =?utf-8?B?QXB0dDRxYk9lTVlBbnZ1MWt0dDczRmxMRFdENXFnWHp5eGNuNG5iNk9idFRQ?=
 =?utf-8?B?dko1YWE4aHc3VXNZc2JHT3pteldxTkthWnJmUnpoRkUxSm95dVNkczBFL1pw?=
 =?utf-8?B?enFIVmorSWZ0ZHREN21QVGtLRXNlUDdPWTJ3QWI4TTZ1T3J4ZERyZjBnK1hq?=
 =?utf-8?B?QjZFdmpFVDZMSzNtVi9JaTRPRi9kMVJMWDByc2xNZXlsWm10MVJkN0tlZDAx?=
 =?utf-8?B?T1lKRzA4b1ZEdmN5bWg1V0kwTCtMeTBNNjVOeDNpaFRPY0hTaE1sQWQxU1Vy?=
 =?utf-8?B?NXBlWXBYSnI1VnAvRVo4OEFrdVplWXo3bzlFNkZMOU1yMGpHOE1sclB6ZEhq?=
 =?utf-8?B?dXdYYkV5em0yU0d4VXEwdXRlbERwMjVtK0RvSExTODFlWnNzWU1iQmNWc1Vm?=
 =?utf-8?B?WXo3RlA3RTQyZHdkUWViMHpLaUxlcVl4MlhqSHVTNjNCZmZxSHd3TG04K3kv?=
 =?utf-8?B?TXloMXdlMEZVWXh6U2hYMmpIL1dLdi9OYjJ1bWZPVHZJTWVTaXFJSEVra2tW?=
 =?utf-8?B?eE9VQ2F3SjJ3UkpNenJybTBBVHRKTGVFdnNVT0Y2UkVvbmhEblFmUWE4UDI3?=
 =?utf-8?B?Z2sxb0VDYVFiT3NNRC9MUFNrNnNtQ1N4Sm9FdUFKSkZncjhvSUxqc1BSU1VV?=
 =?utf-8?B?MUMxK2w2cms4c2IzMlZCM3ZDNGw3VG5WazVBanFFUDk3N1ZNdG9xK3EvODlJ?=
 =?utf-8?B?V0k5MlF2c1d3LzczVGw5dUFpZ2NPR25GQVZQL0lQZFk0YUNHZGY1emZvcktD?=
 =?utf-8?B?a2htRldwN2VLdVMxaDZwOE4yMjZSV1FaOEZEeWtENUlzQ1grdWZPZ0FVMnVJ?=
 =?utf-8?B?Mzc5WDNWNzBVeTFKemxjWStWWXdBTGtLVWc5YVpmbTh2WUJ5WGtlMUcrWU5r?=
 =?utf-8?B?MjVKaFhrK1QveUgyeVgvL0lENDBKSkU2TUIxZWxNdVV0N21Xa1Z4VDFkS2xR?=
 =?utf-8?B?RGt0ODR5WTZYNkp2Y0JkOEJDVE4wVGQrTEhCV0VwVUpFTDdDdnlCTFNsV3lv?=
 =?utf-8?Q?RMaWb2Q1YYvjHH6Q1EMDrOk7+pxxVoix?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eVhLMXlFWnp0V0YxN3RGWEhGM09mM1lsak5qQWhvMi9zdGdkSjdYQm5Kbzlt?=
 =?utf-8?B?akZiVWJFaVFyZHl5cDJUZVV3ZFZjVW42cUJiUGZReTNNbStqVzhicG1aQ1dD?=
 =?utf-8?B?WjRvMVZZbmtEeXBpS2x1Z3ZNVWxKYjNleWFnVnFjekd6clpYY1R6VG1QMjNw?=
 =?utf-8?B?RFNWREtYdDkvUThLUGxaYW53aDVKNnc5eDV5TGdrSDZGc1ZnWXFJRFBqaGpw?=
 =?utf-8?B?c2NPT0hSM0xLSVUzVzNMdkhySUpCK2IxVmV4bDNTakgwY3ZWUGNRb2lNOXVi?=
 =?utf-8?B?NUgvNElxQXhHZFJiZ09ybVVoKzN6aUtxNWlHSHI1Y2JucVhzbElIMFVCckRn?=
 =?utf-8?B?bC9tMDRiTW1Udm1SSEIxSzQvQUN0eFgxd2hRWWdMbDBSS0dXZDY0dXdibzVO?=
 =?utf-8?B?Vm9FcG5KbFk5a3NjekphUlBZVmNKT1lZblgza1Y5OTNFSE5OcWZYVitXUmZC?=
 =?utf-8?B?NEc4VmxOaUFBdFhzNkV5QXdnVVRLMUh2RUlya0NqVlhqdVFHcFRHR3dWTlg5?=
 =?utf-8?B?MUpvS0lUTXhSTE10cC9jbEpPTm93TWY3YkZWcHRpQ3EyRjJLTU9lN25xbjFH?=
 =?utf-8?B?dk1Tb3VReTM1L0xOWExETndybm1yYWpZUGlYK1YvVlo5SExnSzBVZ2xkai8x?=
 =?utf-8?B?aVJHZkpOY0wyek5ualM3S2x2cVdZLzc2aVRiSE1ta0lpUjI2aDhEZDdPQkha?=
 =?utf-8?B?N0hUei9HK0g2K0dESDVZVVl5Q1dZTmRXTXdJZXEzYy9PTWlYTlhyY2p3c3Zi?=
 =?utf-8?B?UnpxNGlpL3N6TSs4Rmx0aWdCcW9mV1drV3FWMW5MekYzS1VXczViaERlK1Vj?=
 =?utf-8?B?YWZHb3VYSVo0blVOWTYzc2N1bDZLMS9qdVBwbTFUNjI4VUdYU1UyQWlBM3h3?=
 =?utf-8?B?cjNPMlBKWFNNTGUvUzc3ZUV2SlVkaWo3WmRKN2d5VmRFSlBtTGc5TkVtV2tq?=
 =?utf-8?B?RmFvVTc1NzJkdFVzc01JRnFhSDJCM0VLQ3pXSkozblROcis1ZER2elZ6WmNt?=
 =?utf-8?B?cngyOXZ6OXFjSk11UzZ3eTQzY0o0S0JoU2JMS0VoclR0T2pTdkxoaXZLNEdz?=
 =?utf-8?B?a2NUNWo2U3lqQVJaN2hRRHRwZkZybG9LcHlHWXZnMmFZRmdWbWN5aWlOVUMr?=
 =?utf-8?B?dEtwRHNDSGJja3JKU3pHY1pJQnVBTnRDMzNNQmIvTFNvQ1lIOUMzWXNLd2ZU?=
 =?utf-8?B?SW93MmJyblRJaE1VazFLeXN4eUNCQVJ4L1FMTDdqUmpQS3owZzBWYkY1aFdD?=
 =?utf-8?B?M3E5ay90eUlKM2YrUnRHVDBHa0NWRTJCZUZNQkRBMXJhb3poeUUyYjd0a1ZM?=
 =?utf-8?B?WDNzamgvT04zMnUvK0Q5eHlhL0hqSmhBeDdLSFA2ai9ZM2RoMTN5dG9VQjJk?=
 =?utf-8?B?ZFRWbE1iajRVQnNncG9MLzZsV2xkU3ZvZlZFUUJ0ZGl2ak1aalNmOFJXZ0lv?=
 =?utf-8?B?bi9VbURxN2gyZzJqOFlQNWV3eTFsQ09Odnh2WTlpbll0cjVldlNsdEVsRXhR?=
 =?utf-8?B?a3QzU3dLME9CUTgvc3RvQkdTVFFRdWM2dUJuSGptcVdsdnBhUU5oa1FzY3hs?=
 =?utf-8?B?YlJHUXRWWUxUQUlmQWlpWEFnYUJoZURBdGhSdE5NWUNhV1Uza2JLY3dVSDY5?=
 =?utf-8?B?R3k0L29CeVZ5cERCMWsxd0hCbHFrR3VWOEdsc2o4dHo0K2tQRnZhOXFVckda?=
 =?utf-8?B?aUd5Zk11WENSWWNQWW5FYUE0TkRHeHloQ1EzcUg5aDJFR3hDcWh2cWNEVTlO?=
 =?utf-8?B?cVJYSDEwY3NGaFp5dlJ3cVl3SVlYUW1KbXRPMnVpOVNqaFJpanc1ZVRqcm1k?=
 =?utf-8?B?dklNMndHUXFBeGV6SnBBbWJMYWdoR3ZkeTRQVTdHNEpnMXRtalg5QjBYcEI2?=
 =?utf-8?B?U0d2NXozdllnWkNPQlI5RGlVT1VXUlJuUXVCRlMvemhiUzN4VWZXeTRJNndJ?=
 =?utf-8?B?SFhoNmFNSHRiQzZiS1BvY0ZISU44OC95d09kZ2NZa2UxS3duRkIzbXNDV0FV?=
 =?utf-8?B?TWl3ZjlRc01LU2VMMkwyWGtqUlA4aHNJTDdDVzZQUmlpQURJeFpOOWZ2dFVH?=
 =?utf-8?B?aE9jbE5CbGRhamdxYXBIV0xnb3FOSXhydkMzWFZ3MGtHRVI4NFQyZmpHOStD?=
 =?utf-8?B?a2xvYmNqRW1ocG14QndnalNCYmYzRXBIT3FaTHkvUGpVaExvMWtHSDgwSkVh?=
 =?utf-8?B?ZUtMNHJsSzh2dTVYaDdmeUE1Y2NlWFdFVjRkUEZJeGJ2azcwQlNUWVZjaUVr?=
 =?utf-8?B?a3BhQVh3ZjQzNzFoRSsvKzducW4yVS9HOEFYdVV2M21LZ2pHR1VvQVJnU0h0?=
 =?utf-8?B?SG9Pck9FQWhGeFVlc0lDSXBwRDJmelp1SzhQVWhXcHZnL3BiMVZNUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f690a5b-be76-4d54-93da-08de53462f31
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 08:23:23.9486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8me8REOvsHAnaa2TWIB1kWLPUUSRWLXHD8BVaCRCcnHuKUMU+vuzm/E2D+g5nKTFXYkSk0IGmxonY2ITCv6A8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6229
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jan 2026 08:23:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21537

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...4.302-cip104-rt58.bb => linux-cip-rt_4.4.302-cip106-rt59.bb} | 2 +-
 ...10.246-cip66-rt29.bb => linux-cip-rt_5.10.247-cip68-rt30.bb} | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip104-rt58.bb => linux-cip-rt_4.4.302-cip106-rt59.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.246-cip66-rt29.bb => linux-cip-rt_5.10.247-cip68-rt30.bb} (68%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip104-rt58.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip106-rt59.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip104-rt58.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip106-rt59.bb
index df900fd9..1a341402 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip104-rt58.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip106-rt59.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "705c91e197198c7771af123164e51ad520daa9cee30e0b8ed914841be97ad7f0"
+SRC_URI[sha256sum] = "ea483f4282489e517440d6919306f030e738953a21d7c7fd6647e4063429dc07"
diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.246-cip66-rt29.bb b/recipes-kernel/linux/linux-cip-rt_5.10.247-cip68-rt30.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_5.10.246-cip66-rt29.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.247-cip68-rt30.bb
index 8386b246..0d2b2b85 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.246-cip66-rt29.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.247-cip68-rt30.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "ae5233fd7d570b1fbd537bb0a84c0de8a865a4317f4bd4bd6e963bf9ab24e64c"
+SRC_URI[sha256sum] = "dd9b650b078df62ea129311028e8e67301fffebb157996e0404f40bbf42c270a"
-- 
2.51.0

