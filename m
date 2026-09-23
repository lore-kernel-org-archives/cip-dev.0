Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12F9C9830D
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 22:29:09 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.25])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1917.1790202529870861091
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Sep 2026 15:28:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QHj66YcE;
 spf=pass (domain: siemens.com, ip: 52.101.65.25, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyVKpyPqhb3mEieyuPozxZFWHEljPvO2M0jdH+Y8Bg9sMG9AtTIwBqfelMMzbwisXqKn2tqv0RSvt3BTqv7r9RR/KnjLCJzWksQWsmji4+jLyYtbs6YtC8r98GZVU2dy92uB+Tx50uW8mZ2y5nhkYHOC89q3xoOhF6uM68Hy5LrSq5K4ywIBWOrvVS1wLJRTCbuICJlmLw1wdeiPPX8ynQsvHJN5jWZoubcO61tvStNOphbxMMI7NasJcr9WtyHOijCSxDSYS3d8B+H/+ApYyQj0XJJi47+I9+lCwCLLiM+/FyGnGY8078piAEsjkE8fpPidrSCaAAl+mDzN9rsm/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPSvRh2uVql9m/s18JQe00F87WulgCmzavL3rmmHwN4=;
 b=ZhwNN4ueJ6jkzR5hx/qRbqTRtoNM0kRLRa4Bf5G4X0xOm4kD4KnIjUT6/HOeDHmUFzqQOrm+Ck9aoPtaX1hFFhRh6OGbbUWbAgLYgccJcH9q9kxbMfEteS6QCBlwY/UasHMtew7DWU+yrmoHCl2c04lCnEirNIcxc2mCRhANv76XopYWUSw028ov6LLcnvR9WNtr3gpSO68iiRbjkMSFMK/Gv16QJ63HYTwEUyxrUXVJq/9EfQoTy2vOlCrsTSG7VUGPSGcIT4eQeUV7uMcHLW0SNc0T6JrgERrEL/vxtfOsHh1MD/M1hn6UIGTsKzYugqaVpACSvd6FhSjYCXGs0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPSvRh2uVql9m/s18JQe00F87WulgCmzavL3rmmHwN4=;
 b=QHj66YcE0xfoPDsuwi1l/TpqgPzVEF2iJXVZMEB5ZDJFncqErl6lqTv8j4BgkjkCFLe73lJJO2XLAjPdZeM69XLof8oHSCeS41M0MOTFSgvBE2uUyyT3i1VVgPxXx8KiDk/c8+r0dNNGcXmccTqZ1i6Lacei2K8D80Br9s2GgVfqOLGZFM89xN58Qgl4zqs4FEoFCcLRY7lq+zGMPqj/z22TtXWEd7V1ToK9CzpdDvEinRf9mmbwTLyTiP/Qslacyi0OkcGJdm+xKf4YulYprr+HPy5zD5dXP5oZNocE2ETIgtJAeqPbM/TxyyWiWoIQlutl7FSNBU+aHat9JCRstg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5517.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 22:28:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 22:28:45 +0000
Message-ID: <2af79ddb-ba67-4afb-9722-85a36b15602f@siemens.com>
Date: Thu, 24 Sep 2026 00:28:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add SECURITY.md for the CIP kernel
To: Pavel Machek <pavel@nabladev.com>
Cc: Ulrich Hecht <uli@fpond.eu>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <a1cfc8d4-5fb7-4f75-9600-92ebd7dbbeda@siemens.com>
 <arRBapEdmwCS7snS@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <arRBapEdmwCS7snS@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0361.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5517:EE_
X-MS-Office365-Filtering-Correlation-Id: ef71731f-d6a2-4a4c-a59a-08df19c207c3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|18002099003|22082099003|55112099003|3023799007|11063799006|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: 
	FebdyILbgxzjoaTgfcAGeTZUojhZLcXxDibQXVY/oJFlAg+QEH228did6QeNICynmaB3El97FQHyx6yJ2jeoCInYL83EUvOxi4M2wHnXG1cyyWBPgZpYy8CP7SWRzY0WDTpkmuQj+BS9rLRq3IJucYRAvOgFBh1U7ketr18dDpIbt0qiR9Zz9cRxkkfl3/F4m7/9qQUm2pt0XJdFSIZzNYAl1KAEC9VQgVjY0870PEmgTY/HYg38+WVEGwRqN15cR3fDMV5fprHeqMuxbxiZAUYYUp1QyqGXZXeRAslx+GfJnFfAlmLmtvJt4jqSeQF13EAds+708oBurWWzwiVuACuiwSqNzaCs4THNrxweFl1sLKlOMGmtDw2DwCfMuuFmm17ctHmkhLGHwmJJ8EhMxCupiPdm2w3pkOD5rW8Y++D/OWD8eDNq4ijbD/KcWGwsTqlXcyilIKc8bFXlnzTB+CTBhn/vcULl5VipU39EGx4Ir3zWoDEZj+q7tna25ZccRwmI2wF1hI1k5fAfPTRZ11/4Kxn5hczcmSIUtd4HANYMJOsMfofLCEmyty0PMEYPAnTFTZklyRSV4LitAO0EgTGkt57QBV8dPB302Z4jAsOl9lZobrER6A7YQn6Y/3BZ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(55112099003)(3023799007)(11063799006)(56012099006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YXo3L0pFRGxWTlZSSkg5L1lwUDluNllldSs5dnBYeE51Vk16SXI0d2VyOEtM?=
 =?utf-8?B?Nk5TbGZXVENvdHVRaUZIYVNnT1c2UGNmZ3RkYTk5RmhNZEZwdDZJeXh2Q1pl?=
 =?utf-8?B?ZFgyR0QyMEpHN1pPa0lxaElBbHZ2ZjdubkMrSiswMmp2QjVPdHhJcjJJVUxM?=
 =?utf-8?B?dkZwUUVlV0NONXhFYThaZVBPbitNdDFJU01kWXhEOGpRUFd5dHl1cThMNnhm?=
 =?utf-8?B?dEI0SVZrd1kxRkRvN2JzTURUaDZNcnR3c1EwZG1iajVBdWdjYWdzeUg2MXky?=
 =?utf-8?B?R1JKUEtFVjZlV3lOc0ZNUTVyYzZrVWg5dzQxWjEzSUVUa2tFbVg3WE8vbUJh?=
 =?utf-8?B?bWV2WUl0Yk5iNWZlOVF3bFNXME43SDhuMkpQb0JzTmpkYTAxdllnTUFVS3F6?=
 =?utf-8?B?ZVhqZ3l5a0g2bXpHdGdxbEhieWJZUjlOcDRnMlBIdDRiYjdSeFZPS1hBZUNj?=
 =?utf-8?B?aCtnK2pIK3BKOGxrNEpqZjV5ZTFvL0o4Yk03OWtlMkQ3UWZ0N0RTVEpuMFNn?=
 =?utf-8?B?cDMyVVFOd2JOOXFzTDh3cGduMkx2U2pZWEpwZ2hGUFZRN0t0N0dJaFVGZWV4?=
 =?utf-8?B?OStCMWRYQnJEM25UcWpabi9LTDFHaFQ1ejlXOVE3aGFISG5JTGFPRjBRYzBU?=
 =?utf-8?B?NDJDQndxYzMvTjMzV1dnMXorZFJQaUkxdlFjUTdVYlZ5THhhaWhxNlYrem5Y?=
 =?utf-8?B?Ky9iWU8raVJtQ3Y2S0hoUy9rald6c0RGT0xkK3JWTkNNbmltaGkyQWIzS3lV?=
 =?utf-8?B?UHUwd2FWZVR3bWFNcFVKNStDQXBiSmJnR09HeTAyS2tkTVJnL0N3Nm05MDdZ?=
 =?utf-8?B?dUpBdm90TlQyTnJVZVdVRGlqQXFuRzllcW1YMGFWb056cVVIZDlsR1c1WWM1?=
 =?utf-8?B?MlZyaFZTVXoxaW43S3lXekhsWnhZMFRyUks4TVJLSjM1RnB3VUhLL1dWR2p6?=
 =?utf-8?B?VnE3aHpaa2dzM1ZwYTlaOHg0NjEvcGVXS3VCVStwRzRsbjQ2YjNnaUYwU3pq?=
 =?utf-8?B?bDZ0dXFSeE44NmdpNWV4UUZrVHFRVkIzSFMyTEloTDBBUnRmQ0dmSGZzRGg2?=
 =?utf-8?B?WFdGeVY2UkFIT0lMTDY4bm9KZmlUbG9MZ2ZYVVdna1duQ0FiZm1wV0xtSDF4?=
 =?utf-8?B?ek5ZMWJndERmZ2lPOW5KT1VET0FKVCtxQ1NFVkQwdzhPWk04UmFtYVFBUWpk?=
 =?utf-8?B?ZlErZFhRVFdQMjNBRzIzaE5sK3dDTkl2em5zbUEvYnhEU3E3dkJqbWRrcHZk?=
 =?utf-8?B?ZFdJR1lyNS9BenJ5ejc5NXBuNDNaR05oVC9xN1k4cXYrVUxBRTUzN3ZCODlm?=
 =?utf-8?B?UndtL0ZzVnBVWGovd1JxKzdKc2FtbU0xdDg2YzJPcnMyQ255NHF6bFkwUTBp?=
 =?utf-8?B?YWR0M1pHVWtJWGxyak1Ob0VvNzlCNFlmZEpxTmp3aGwrYjlPU3dCNUxkWHNO?=
 =?utf-8?B?T2FIaWJKemhsV1B2MnZVbmtTckVwSjVZTm9GeU91dVdGa3B5dExMUlgwb2py?=
 =?utf-8?B?bmJ3Unp6N1h3UWZJUlpMcy8yb3ZVOGNGQVVXazZoUXdrWFJwS25YcDVzMVlS?=
 =?utf-8?B?WllkUU04R28zUmR4eHp2S0hVekE5UkVFZkx4NEtZL1pjN2xOcDZMeWl2OHBQ?=
 =?utf-8?B?bkpjUjlZNmx6Q1VLbVJOdEtOUEtnU2owLzRPSmdOWEU5YzZYZ0VPYkQ0L2Yw?=
 =?utf-8?B?YzY4bElESTdpcmpSR1dYSzd6TmlZSHJtMzN4Q0Z2ek9xR1lzTWtCTndwMnZJ?=
 =?utf-8?B?NERVTlJ0WFZqNnpKTi8wamd6UC9ndkFBUFc2Lzc1YjZNR1lFdVlvdWxMTU9k?=
 =?utf-8?B?Q3NhTURkcWVQL04xZXFuOTZFRFRMYTF3ZGN2aXFRZTkwQ3NDa2FjWFlxR2Ry?=
 =?utf-8?B?Wmo0R3hPNXZobHVZc0tIK0w2R1JRQkl2ZzB2ZVlLR0g4RUFjM1Q3SmE2VDMw?=
 =?utf-8?B?VUtPdU1kR3VLdm9LNkUvY2ZURWRVNU5ZeTlxTkhuQUMzRi9xL21EOUlqd3o3?=
 =?utf-8?B?SzN1Sm4xS1luWmJJZk8vcVpUNzdJSCtmV3JySldSaGpWTVB3aFZibktQRHcw?=
 =?utf-8?B?Uk1TZ2t4ZVFLMHg1T2Z5bnpQUEZxYkVoNThFWWF6di9pVi9IVXUrM1AxWjFI?=
 =?utf-8?B?MkNvU3VEKzE5WkhtQ0tWRUZvQ2N3VXhTT0oyTXlOSS9EZ1BGVlp6aGpPUGto?=
 =?utf-8?B?ZW14aG1nTEZuZ3RvbVZ3NG9PaUFpZ2t5bUUvZU1PeThlUmxnS1ArTWVBMkN6?=
 =?utf-8?B?U0Y5THNzbGFSR0ZZaWNMSWo0aTllNDllbWczVm42bERXdDhkNWttUWxCRTJq?=
 =?utf-8?B?UWJzWk13Lzh2dmk4eXB6bitoRzExeHg3eFdMdkE5VmgzUWtXallsQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef71731f-d6a2-4a4c-a59a-08df19c207c3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 22:28:45.6466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2tZrZUjEtKnRjVRDY/6YbgExUNzceecYI7geqWpipGRl7cUCKuXIYKfjIBPguWqgyxTVYm5Aw/DmU7151CQnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5517
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Sep 2026 22:29:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24283

On 23.09.26 23:15, Pavel Machek wrote:
> Hi!
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This describes at which time which ares of the CIP kernel are handled by
>> the CIP security team and how to report vulnerabilities to it. It
>> furthermore state the this projects falls under the LF stewardship
>> framework.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> First proposal. Please review and provide feedback. If we all agree, 
>> this should be merged into all CIP kernel branches.
> 
> So... latest kernel already has
> Documentation/process/security-bugs.rst as an entry point for security
> bugs. 6.1 and 5.10 have Documentation/admin-guide/security-bugs.rst .
> 
> security-bugs.rst tells people to basically do normal bug report,
> Cc-ing security@kernel.org, avoiding mailing list cc. That will be
> unencrypted email, and they offer up-to 7 to 14 days of embargo.
> 
> The "linux-distros" mailing list is mentioned there.

All clear - what is your concrete proposal for us? We are not upstream.

> 
>> +++ b/SECURITY.md
>> @@ -0,0 +1,37 @@
>> +# Security Policy
>> +
>> +This project is supported under the Linux Foundation CRA stewardship framework,
>> +as described at https://www.linuxfoundation.org/security. Security
>> +vulnerabilities should be reported through the mechanisms described below,
>> +which we will coordinate with our CRA steward. For actively
>> exploited
> 
> I don't believe all readers will know what "CRA" means in this
> context. I'm not sure, for example, and knowledge will be even lower
> for people outside EU.

This text is taken 1:1 from the LF template which we cannot modify here.
If you have legal or wording concerns, please follow up with suggestions
on the internal thread we had.

> 
>> +Please DO NOT report any potential security vulnerability via a public channel
>> +(mailing list, gitlab issue etc.). Instead, contact the CIP security team via
>> +security@cip-project.org via email. Please provide a detailed description of
>> +the issue, the steps to reproduce it, the affected versions and, if already
>> +available, a proposal for a fix. You should receive a response within 5 working
>> +days. If the issue is confirmed as a vulnerability by us, we will request a
>> +CVE, publish the fix and give credits for your report if desired. This project
>> +follows a 90 day disclosure timeline.
> 
> Ok, so here's security@cip-project.org , and we make promises
> different from what security@kernel.org promises (90 days vs. 7 days,
> for example). I'd suggest adopting policy from security-bugs.rst with
> different email address.

We can adopt the disclosure timelines and explanations of the kernel
here. Concrete ideas what all fits for us are welcome.

> 
> Plus there's cra-steward-something@linuxfoundation.org, I assume.

This is internal.

> 
> I guess I'm quite confused at this point, and whoever hit a security
> problem is confused, too.
> 
> First, what do we people to do? My understaning is:
> 
> if bug is actively exploited:
>        mail cra-steward-something@linuxfoundation.org
> elif there's misconfigured gitlab, someone stolen my passwords, malware in the repositories:
>        mail cra-steward-something@linuxfoundation.org

These are our tasks, not the reporter's.

> elif bug is in -cip specific code in kernel:
>        mail security@cip-project.org
> elif bug is in 4.4-cip or 4.19-cip:
>        mail security@cip-project.org

Yep.

> elif bug is in 5.10-cip or newer:
>        mail security@kernel.org

Nope. We surely don't want reporters to go to the upstream list on our
downstream kernels. Unless they reproduced with 5.10.y as well.

> else:
>        # there may be bugs in self-maintained kernels, in parts we
>        # don't support, such as arch/s390x. What to do with those?
>        # Can we document we just don't care? Or do we need to handle
>        # them?
>        mail security@cip-project.org

When in doubt, report to us. That applies to us as well as to externals
that are unsure about where is the origin of the issue.

Jan

> 
> Does that make sense? We probably should include real address for
> cra-steward-something@linuxfoundation.org here.
> 
> Best regards,
> 								Pavel

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

