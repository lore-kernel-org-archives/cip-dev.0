Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2541C54E5D
	for <webhook@archiver.kernel.org>; Tue, 12 Mar 2024 16:44:22 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.45])
 by mx.groups.io with SMTP id smtpd.web11.1329.1710261857161580332
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Mar 2024 09:44:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=PCZExCsa;
 spf=pass (domain: siemens.com, ip: 40.107.8.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8gGw6FodY39HAV43twXqqvh6Tq8J4AE9+P1D3ulgyiHn0tkMNMZxssv2w6tF11yn7aTmzxIAfbDhledt3wuKf1hwdqlTO+/TWSHPQl4RBYAs1CxQ13rxWlxQ1hgfW4ICyP6FutEosidIrACSJ1Pjjj7mNkZwg1PY+Bp+D31VTR4ckIGqKEWP6nRAP9rtA3xMC0N5t0U+GYWylkpwn4KmredTO5RrW5h4E6mU4PltmQ11EgC5pw1zYGpulCJFdpLKyMUnUlxwG/87SbhjI+/nZcGZilVtv8hq/tNzAw4LE70nyC/R0Z6GHbjQbZ/8RaspN/KPkoEBGKxhK/2IB29Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ctfdcvbs/vSl1z/UjHtToVphqFUjzald75UOxdKEqc=;
 b=NqSGZa/9t+/fZnZVhAlC8R30kGORihYggTOFl1K8ReNKHVh2eX0Oaf0xjm7EotvQRPq42H3lysX7Mk7T4eop8JfSo2sDttsIWH9R1n1SDyhrFhT0PyUR0JnSvLcmHDs496L5dDaS8/hVEWSNOPBHTebmTaKibFDECROR6btODNgxYqVXmquR0m2rm0zRU8WhNLVzKk/vD1atJimRXZmv12VPXCf9XxVp4ggO//1G/N0dRkum3hzOOiKUqanElubqQS/QWrH74Ak2vIfnlW9Xyef/Wlysxz20pUPfYJbpYU7zOLeHmEG6p9gtjnpo4PLY8DJQqI82cGfGYWkkOBJnuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ctfdcvbs/vSl1z/UjHtToVphqFUjzald75UOxdKEqc=;
 b=PCZExCsaJWkKH11CPtNdmO4NPmEpP9u5Fg+2Vihnap5UF9DPSLws+IW/QcYCJAaswJPPZqhb7MUi/3VH+3XKXKZUEUh02FdvGRDt8gAiDRBojixqwnistp9pKAhzAFx6QCe/oCG6ESxBzvq+uN8sksMtezGQunRMs/X/7VjLUhYH+TRlQ0MbgNnfiQV7C30iVYnWEAMkjkFh45GFPLVo/UvXtP9A/+PACarRSEpqCLHshu4YvR+EtYw91aMj3DpN2fYTMT2GvkUUTtXrOtHu/eLBdU63HaGmrcp3ZAzrgPuzQQJVFScSo57Tf1kekFGykjz0OyBX2nsiuzBWWbHYeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6891.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 16:44:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 16:44:13 +0000
Message-ID: <7208ae2f-04bc-4571-bd7c-f75d7cb82816@siemens.com>
Date: Tue, 12 Mar 2024 17:44:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Migration to Debian Bookworm and compiler updates for KernelCI
Content-Language: en-US
To: Chris Paterson <Chris.Paterson2@renesas.com>,
 Denys Fedoryshchenko <denys.f@collabora.com>,
 "kernelci@lists.linux.dev" <kernelci@lists.linux.dev>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 clang-built-linux <llvm@lists.linux.dev>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <42c7f5a3e07c274c2a9d2e45a973c6306b2ba74f.camel@collabora.com>
 <TYWPR01MB11862CF20936D7CD75B2BDF87B72B2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <TYWPR01MB11862CF20936D7CD75B2BDF87B72B2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: 57100ffb-6ac3-4e46-3048-08dc42b3a609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	r3xp0KH9y8O2nQbxtBfg4QbqPjKbkBln1lE8UeiSAHDCjcx70t3rKfe2FzizK1GR3uqc5wxB26kQ9HcJLhgFmun4n5ftqz42H8kJPfe2qxEo+uR4qqOavw3CJWUXb9rgcO/A2XxU6a9PUW7lzWMuSs8MmKttezcXbb8gogWg0fXxRytyrJw9dw/NRvlCkTneMNawlq08ohlaLgfHYQncN40Xnj16bGK5MnrhEeuNtX9JG4ZAyxH0sITFtMlydRhwDARaprhIaWSWXnesY6QFSN1XxPoBs+KlF8PdHqw1HYItV089ebs3gPAfnX/pe5NyilLSgth+zg/Jp7c4I6uWVhO0uaObqoUAxDsi8jsf/Xrmx/KuTR6WHs4QSBmpCMcmZmkm5QhRc69L4ONyjBHbCZzppEwkLhX7bJwgXXfEKD58IX/SQEO0vP4Ot/3hPWF0Us4SflKk5vbHqU5Bp2xSfjmYytOOh3W+OpKtEb32Uh/JQw1gbHjElg46qSEoXkMtVpBFddHuyMqjcqptGvJ1A23WA+9dJo7ojI98KTEOBV+bTpDp0dKxj4U9hnhAwPh9jmXnCrF04w4xkjf1jo6PmvWrMRkesTAwR/eIQyF5BpY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MElXUEs5Vm5Kb2VOdzNXQStDOWg5VXV6QW9RWTRHTFYrRWgvV3N4TkVzZTBH?=
 =?utf-8?B?Q2l3dmx3Kzg3bmxlTSszVXkxL0dRa3NyRmJvOHVFMzBLRC9Gd1QwaFVNc0tl?=
 =?utf-8?B?U3RvNFJlcnNxQkRiUGRUYlgzMWhyY1dHYkF6SXAzaStyZ3NXaFdqbXJlNmRm?=
 =?utf-8?B?UkUvSGYvdm41M1hqZisxTlRGOXIzM0FIRHpHdFJhQjJsQnJMOUhjSE0zR3VX?=
 =?utf-8?B?aUtWRWlyWDRralBzK0U2Nk1JSDVJazZZb3FmMi9Ic2RYN3JXSHlaMjBvSktj?=
 =?utf-8?B?QXpMNnErdWVXVDBPeHFLNUdKbVdlaWxseURKNkZTR0dMSjhZSjgzVVJLV25M?=
 =?utf-8?B?MGw1SVNDcWYxNkxMVWJWMEVkblNYUk5jMjFUTEgreWRMWkpUOEhmTWFINmY2?=
 =?utf-8?B?QXEzODVHMmoxUzlWVTJ0c2pkWjBQWkJaOFdlUUxkMDBQOFNzaTY0d2xZZGtu?=
 =?utf-8?B?SDlEV3Rwc3A5NktCOVdESFZ6RVlseHBpUy94Z3lwRE9sZ2UzbmNRUGpPaEo0?=
 =?utf-8?B?RnQ2S0UyYVg5YUxjQW5ZeVRwVjJVWi8yZzVyd0dWdWdTaklZUEJUbFpDSXRy?=
 =?utf-8?B?YUk0dXRtRUNQQzFlSmdndlFNUjlLbG44ZTZTdWxEbzBCZEdzMkRTNjVQR2ha?=
 =?utf-8?B?S0NmQ3dnOCtlL1ZoNlQvOUxHWlZRWkludUJ4M2pObWhoTThYUTNRajNaeTJs?=
 =?utf-8?B?bTFHcFBxRVdaKzRndFhQSDdGNGNLaUM3dVYxT1RJanRWWS9BYnRrZXRzYWMr?=
 =?utf-8?B?MXN4R0pCQldDcURrcTRmWThFN0hkR2VJQ09jb2F1UElsNkpOR0p5ajlhdDZF?=
 =?utf-8?B?ZjJuS3E1cG5naUFRNnFjaGdFbyt2K08xTXI2VGUyMHN2Z3RHa1RidE9BN0J5?=
 =?utf-8?B?QTB4blRXRVFXeHN1dkMzTDQ3NVJmK0cyaWUycHJlSzQ2bmV0L3E1TWJ3Z2FF?=
 =?utf-8?B?ZzY4cUl1S2U1aGFVYmF2czhtOVJEK3dUdngwZldPcThzNXE5SVdTVlcvMWpJ?=
 =?utf-8?B?M2pjTDNrVWlycUVjRDBJRE1RV3pwemRXN0JhS3EyaUIzSTRCWDBhK2orU3FV?=
 =?utf-8?B?bUkvLzBpR1ZNbDNvYklnWVd1UzVKL1A4N0RFU1NNMmJ2S3dNQTVlWUNoK2pU?=
 =?utf-8?B?SVNhbDRaVDJCMGoyWUxVbVd0WlpIK0dGSXgzSGdWeHlySjZFU2VxTzdqMEM2?=
 =?utf-8?B?WFNtd2NLRzg3NXE4N2QxNVV5L3JnS0twYlZxRExCMzRWSUk5NWxESXRuMlI2?=
 =?utf-8?B?Z0NrSXdndEFta0t5dnNmQ1NuSXA2K0kvRllzSFBzN3VWd2x5akpVSkxtY2Mx?=
 =?utf-8?B?dHlTRHdwYWZYUXBjN1pYQk45RDVPMXMrdllXWEpuVlJGWHFnUVZGVzhOR001?=
 =?utf-8?B?U3R0Nmo5dFp5VUpMTVpYKytVTDVTL3Vjc3Y4emhVbHFIc0hOSGV2VW1ZMmFk?=
 =?utf-8?B?eTlMQml2TUk5eDB1a2x1ckh1Z29VcnNaZDlMTXNQQjFmeWdGR2VLTGVhbXN6?=
 =?utf-8?B?NWZqMnFyWG42VVRNekEzWU85ZjNIOWJlWVNhZUFaTnlncjJZZXd2eUhmendX?=
 =?utf-8?B?TzJjWGtyODFyMFgyRVZwTEdmUWpXUnBqYkl4cldlWGtrdXpUYWhVYVh5RXZn?=
 =?utf-8?B?Z1BWN3h1eHJuN2hGM2ppWnpVQ1E1RkhIMEQwelZCT0FGMHVyTEhsVHUzKzZu?=
 =?utf-8?B?dXlPVitzeVhqdHoxTDFQb2c2V2Q3bmJlbW1LOFhZNllWb0RZWFk4cDhKL1hn?=
 =?utf-8?B?d0NFTjl6VkZmMXZKekF3aVJKRjVSUGZrT1AyRkRDZmRWSlVwbWxrS1A5QnhV?=
 =?utf-8?B?OGcyM2paNVdmNlI4MVB0SS9YNWFqc1NGNU1XeTVVUDVlWG5tUHRQOUhBbW1M?=
 =?utf-8?B?dUwxeGZOTVphTEw0OTE1dEJyb2h2dzFtM0JVZEtYQWEyT0p3NTY4OGk5QUwr?=
 =?utf-8?B?cEtVS2RnMThwWkN2Q2FpN3pQR1lJU1pWS0hpVHNiekhuY0VUVjdXM3p4QXE4?=
 =?utf-8?B?QzB5VEdtUWxUV3lhU3VYZTN3Zy9GLzRqOXV3UjJWVHhhaDRlbnJrU0U2SXpq?=
 =?utf-8?B?QW1qWkUwREtzVDNieGRWNjdWcGhFcmZFWmdpNDBxN2V1bUNxc0IvOUYxM0pr?=
 =?utf-8?B?YVpweU5ZbExuZWg5OU5WNE0yclJaVUFvR0xOelBVWjRoaUZFOEE4QTNBLzhF?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57100ffb-6ac3-4e46-3048-08dc42b3a609
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 16:44:13.2783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUiKiVon6B0b/XRsC9Y1kFUPi2+pjff+f1hLEb+9jlkxfy576J8RQ75RNskE/LclkPqadnwQZGUEGMIjxRlmUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6891
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Mar 2024 16:44:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15279

On 12.03.24 17:13, Chris Paterson wrote:
> + CIP people 
> (sorry for the delay)
> 
>> From: Denys Fedoryshchenko <denys.f@collabora.com>
>> Sent: Thursday, March 7, 2024 11:02 AM
>>
>> Hello,
>>
>> I'm reaching out on behalf of the KernelCI project team to discuss our
>> current compiler setup and planned migration to Debian Bookworm.
>>
>> As you may know, our compiler images are currently based on Debian
>> Bullseye, which is approaching its end of life in July 2024. We have
>> been testing using gcc-10, which has presented us with some recent
>> challenges, notably a significant bug that results in false positive
>> compilation errors (specifically, the -Werror memcpy issue in
>> security.c). This situation has prompted us to consider an urgent
>> migration to Debian Bookworm. Additionally, the migration is
>> necessitated by our requirement to upgrade to a newer Python version to
>> support KernelCI v2 development efforts.
>>
>> However, before we proceed, we have a couple of pending questions that
>> we hope to get clarity on:
>>
>> 1) We've noticed that the minimal available version of clang on
>> https://apt.llvm.org/bookworm/dists/ is 15, whereas our current minimal
>> requirement for the Linux kernel compilation is clang-13.0.1
>> (https://www.kernel.org/doc/html/next/process/changes.html). How
>> critical is it to continue providing compile tests for clang-13 (and
>> potentially clang-14)? This information would be vital for us in
>> planning our compiler support strategy moving forward.
>>
>> 2) We are also considering migrating to gcc-12 and would like to
>> inquire if the CIP (Civil Infrastructure Platform) could provide their
>> endorsement for this move. Should there be any reservations about
>> transitioning to gcc-12, we would greatly appreciate development
>> support in building gcc-10 for Bookworm. In the interim, we would like
>> to inquire if it's acceptable to continue using our current gcc-10
>> images based on Bullseye until such a migration is feasible.
> 
> Jan, Iwamatsu-san, Arisu-san,
> Do you have any comments here?
> 

My 2 cents: I'm not aware of compilation issues of our 4.4..6.1-cip
kernels with gcc-12 from bookworm. In different projects than CIP (e.g.
xenomai-images), we are also using bookworm as basis to build down to
4.4-cip, and that was not causing problems so far.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


