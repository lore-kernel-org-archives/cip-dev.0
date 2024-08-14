Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6285BC3DA4A
	for <webhook@archiver.kernel.org>; Wed, 14 Aug 2024 04:43:08 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.80])
 by mx.groups.io with SMTP id smtpd.web11.90781.1723610586841380767
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Aug 2024 21:43:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jO8gW3FU;
 spf=pass (domain: siemens.com, ip: 40.107.21.80, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bx2ByH7q0FHAFPczh3UzOZ3EhQlKgzDUxtUCwz9Na2DJSZBbqQbrnSXBXrWQ5wgtBt/C2XSfymKU1VCXgJ8Ce+oYY9CLd13qXSi0lTuniK96LZVKqJlp4aIQvd64vI80+RXcWPe9Hiy4OnYyf36WnhqADKXMgy4JbKN/NIyQuv+0T+yxJNaHvS0pnIvvsCXc/oAxcYplzDHhotdyOng9Y/u8ObXl/CNmlkl6rIWcXzoS6UGcgEox/EHKeSy6R6auwkxVeStt73HSpLrp4lwMkrgoqG2nNQKuX/wEetDtEyyhynNCBKF4SKawWZUEHR0SbwHvskmJ016so18uPZ0sWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuqy7xgQK4AWDVYiBx/kYVCQKPcHqp8Oc0MZ6mPh+qM=;
 b=myzilra1bVmRhpaNVX6mM1gAsvRmqQybk1MFj5QuOAaMyAOc7F9KuvXNeMpK93XE5gvgpBWd49lnzgrs4+QNxionWrVlhHdiZ/sRbp745XVwG+zGIr1d7i+82GeIvCgbIclLeOGmZRY5ZST/41EndG6FrUU/gWffRNVb8xI06cqZjMZDsck19pIlPIhJJskxklpP4+1UfdNb29WlmIlX359kOONQYIoyazGa8OIjooGSkD2qtut1dN739msiQNBhkUy25ED+z2QhqIAzd1mYMe+YXHDZXqcNLzezJitsqJCMgBmPz6lJdKQEmk1TTmPyUYksji++0C79pAKtmImg2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuqy7xgQK4AWDVYiBx/kYVCQKPcHqp8Oc0MZ6mPh+qM=;
 b=jO8gW3FUa75Wi8OEbFqKy+QKnI/HaIfiHNJnR3UaoNuYdExrOgJb2yy+6IjFael7ZZW4KFNec/WC4bIrEmM2IMQDjZ4SC0NSiEAZbDa1VXcgbaqwGlDwl4ANH3ShhpC3xm6EHTggim8YumfWX7xTAJwxVYjKsw31wLT3hFJtKWO+aHnDcskmR/7kwd+j+Qk9bIG1HN9ga5BNOdCGIfm9p18Yrx1k+0uE3YHQGtPmux5XS4NGfrEhF5NukeB43mfxut5DUSRPfpy2MyLsKOZUpu6snCISXaISWq5yL0x+QI6hOCpg232PqjNdQ9fz8FVMS0kppb7JMcbJfX6QOjkAZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8776.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 04:43:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 04:43:02 +0000
Message-ID: <034146a1-95b8-421b-9d3d-1070b2a162a5@siemens.com>
Date: Wed, 14 Aug 2024 06:43:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] v6.1.102-cip26
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com,
 nobuhiro1.iwamatsu@toshiba.co.jp
References: <ZrjoeDL95EC/rBlE@duo.ucw.cz>
 <9fe32cd5-7159-4e53-b8e1-3db1f29fe383@siemens.com>
 <Zrt/a+EkczsJFeGp@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <Zrt/a+EkczsJFeGp@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: 41440fde-231a-4f40-7a7d-08dcbc1b94a6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?a1EzYzdXaDQ2VnBJZm9CbmZHcHZ6Q2cwQXRaTlJuVmsxMnI0YVJ6Q2R1ZEI2?=
 =?utf-8?B?MFVaMkdJbW9Hdm52UWxEeUVEb2hCWERKQTlIVW92cGMxYnpKWFdWbUsxWHFX?=
 =?utf-8?B?TFhsTkdhSWI4a2RkbnR3K2cyS0FGVy8rUGQ2NEJWVVZCMWlzZmR5d0toQ1Zm?=
 =?utf-8?B?Mk9ORG9hS3R0bUM1US9BZERBVlg4TkJZSm9hTytRQlVuNGV6aFBGbVY3UVhD?=
 =?utf-8?B?dEdMMUZSQlIxWHo0UFVaNy9QcTFGTmwwbks4UjViZkFhZWhVQjBwUERqSGsy?=
 =?utf-8?B?NkJ6RkR4dHlWM3I1N2w0SmlEcm1Ec0ZUQklMTndiT2tKbm1uYlFIaTdlMm5n?=
 =?utf-8?B?bDAzQW1WUTgrWHJaOTJoNVc5NUJGdzcydnJRalhkYjduWUVicUtQTERWa1gz?=
 =?utf-8?B?NGM2c3FmSG8vKzJzMkpoRVRJam0rQ3AwcWNadlIvZ3JCSkhGU2xQV0ZOa00r?=
 =?utf-8?B?UHFFWXp2cFdQeUdub0hXcDhQWHFKMFpZL2VMUHZXSWMzdHVNblJJSWJyVlQr?=
 =?utf-8?B?NndsSTQrU0ZyMkYzME1CZWo0QThUM1luZk8reUh5dzV3S2xsUGV0SUpsLzZK?=
 =?utf-8?B?OFdXWk1aeEVIcmUzYW1GQ1AvcGRnTlpPTWN4UGw2aXJ6Yk50L3EvR0JXZS9Z?=
 =?utf-8?B?VzhpQXpOMmFOaFl2dXhNSE80NGsvNEJsTVUzOVZob3NUNjdlOHdQZ2tPYkhM?=
 =?utf-8?B?UUdUNlBnOEtsMzRjTVk1eDBRblBseVVwRG50YURVd2svcHF6blZpdElvVnpw?=
 =?utf-8?B?d1l1UForaTFmb2ZRaGs5N0dMNm1ieHRxaDJ0TTE5bkJmZ0NBVElZWWttdENI?=
 =?utf-8?B?QW0rL3dwUk40RFpFVG96SUlHZkZzakNJWFBhTFk2azQwTFA5eXpxWWZlOUF1?=
 =?utf-8?B?WU1OUENMWVBJY1RjVGRFdHFPRDEvWDNVSTd4Ym95TEpiRGQrMWthbGRzMEVy?=
 =?utf-8?B?Wml5NTlIME5UNG5JcnJydHZuZkwyV2lXWHg4Q0pQcjJQTG5GM2NuQk1HdTJi?=
 =?utf-8?B?SXRtQVB4NWFiZVZPWkx0SUFsMTJXUmVzcXhrSGoyMElCRVZGRnVDN05aWmlV?=
 =?utf-8?B?ck4wcGpxa0lvbXVpNUExc3hQVjcxU2tMd0ZQQ3RWTkNnN0Fvc1JoaHYrRmRX?=
 =?utf-8?B?dURiaWFRZE8yQ1dvRDQyc2t2NnBJakRMR1VPMi9UOWE0NE9NZmU1NjFXMHps?=
 =?utf-8?B?bnNVTEhlVVpOVTFSWFJuZWRieEJMK2hkUVhVdUYxbEsrREtxcjloN09lam5o?=
 =?utf-8?B?SkZ5dlpjZjJRUVhRcWxLKzRuazVvcDJvdVRpUWlrV201VGI4ZDhqcVAxeGVw?=
 =?utf-8?B?MGppK1c2R1VoeTZ5ZGVHdWNnS0pkQWUvdXY2cURoOTYvZ1ZBRUVtZTJMYXgr?=
 =?utf-8?B?N0tHSDZFUmZiZURUUk91NHBTYzBHYnBoUWRaNUIycEo2WXN5YXBTemZRR2dU?=
 =?utf-8?B?UFVqWnI1a3NpS2pEVXZVcEJRYVplblpmemdJWUxrMFZnMDc0dkpSWndrTlVC?=
 =?utf-8?B?WkpuclBEVWxPQ1BKcTZ1OU9RVFBhaVN0NDV0SExkbnVEbmZGZUMxc3dEUXJL?=
 =?utf-8?B?VHB0Mzc2WFBscUc0YzhpT1BTY2xoSk1taVdMd0lFb29HbnREMXN1d1RCT2hQ?=
 =?utf-8?B?U3lwOVBTRjQyNUVIWDYwcUNrTTM3aURqSnpNcVZhckZpVk1HWGZvMExqRFF4?=
 =?utf-8?B?SGJxN0doeHRoWWt5NDRWUEJiL1pLSXVuOFV5Q2JvWHBnWU0rN2FscU9yb200?=
 =?utf-8?B?QmVxWHhnVkFUSTNlaS9ha0VNYWl5Mm9GZVg2REw1VUo4NmpQd0wwZ1lXQjVD?=
 =?utf-8?B?TGxOQW5jMnpUVjJ6cGFRdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OFk1UkF5U2JMU2xGbXMxVEVLYTViU0laWXgrUnE3UlF5NHhvV3FaWUdKTGRn?=
 =?utf-8?B?MHFQcEdsUERSaFRGcHByQzdmYUF5SGxCMDkyOG9wOEZqYk13c1YwcWprOUl1?=
 =?utf-8?B?Z2orU1lRYXlWekEwVkhCS29HTTZ4ZXZ1d3lQcDJOMHFRVnYybzBsRzQ0QzUw?=
 =?utf-8?B?K0NKb2ZJc0hUWGM4TVV5SmRLZjI5bGZoS1Z6d1NYRHFxMDVZNnJmdlhyUzVR?=
 =?utf-8?B?QlZXdDJGWGFDUXNPWWsxNFZLYjVxWVQ0SFlDUUJJOXU3aW1wNXZEbWtEZHRu?=
 =?utf-8?B?ODdNaVpEWVFrNGkrNElyclhoUGpiU3BIMEQ2aDBpbzNFUTJrK3ZtWHBXaVp0?=
 =?utf-8?B?ZWpuaDdCdU5nR1lUOUdOaVg1MmdFOXloL0xPQWUvc0NWazlUQ3ZiakRpS05u?=
 =?utf-8?B?a2xFL1JTQThocXRjc1gyU3hBM29QdHlnNFBUdzFJSFlsSkd4UGMxYjRIWUsr?=
 =?utf-8?B?MlFsb2Z1WDhCMUZGN0tBbWttWldlemdjT1I4dlNNc01JVFFhWHMzTEFCbDVn?=
 =?utf-8?B?WVdZWjhiUHBqYVFiMHdua2tkSGs4dXoxTnFFVm1NeW42bEtSYlRZd1BtM2ZP?=
 =?utf-8?B?akRTWTFOcitUMTZydmdkQkRWNHlPd2VoZGxRdlZraWhsZGpQTnFFZnljVDE2?=
 =?utf-8?B?UUxaYTRoNzFrWCs2aWlTWGhhV2loeVFUUklIS3RlUm82VG54WFpPNitNMmJD?=
 =?utf-8?B?elRmQ2wxMlhNenBtdXRUVStKWVBYS2JBWkpod29iYThnanc1SDRlWGpNNDNi?=
 =?utf-8?B?R2pLZTZpbVNISlljWVFRWi9yWHNjZWNRWUNMeXd5MzQySlhmNlJzZ0NyZ3pH?=
 =?utf-8?B?c0xLSUQ4RktKdnRmd25MdkdRSno5ZG1EbGsxaHNiQS9uTVFaaVlFNHEwZ3ZS?=
 =?utf-8?B?NVZ5UFRoTkRwUDZPNnBzNlMzMkV4R093MHlQT1E1b1UxNTh4cnNhSmZPT1hN?=
 =?utf-8?B?UkJ2QzY4SXJKNitCTHFvalUrY0lpS3FWdmYxdVRSSDczY1EvRVNrL3pOd2tQ?=
 =?utf-8?B?MkM1c0RMVlp0aXJsdGdITWNYbnhtYytXU3QyaC9EOXVsbWw1cGx6eG9IZnhj?=
 =?utf-8?B?UE1SMC9aYVlUemNTY0Y1NHJsTEtFdmViS3lBdXN1bVh1UCs1cTRwZ1pKdWJk?=
 =?utf-8?B?WmtsaU0vQ25JdTgyUVVJZHNTRm5nMkVKaitEa2c2UGpmNUNQUlVrUWRBN29l?=
 =?utf-8?B?V09BNXNzcDNURGxlY1Vqa1JsRWpULzZEWXg5SFJCREJKcWZ1eW9DOEVOM3Ba?=
 =?utf-8?B?ZVk5ZkZhUGVHaFdaaFFLVmY5bzhwTGZ5RWFXeU43cXNHVCtaeE5uZGU0MVFD?=
 =?utf-8?B?b2p4TkNkZkUra0NPb0oxTmhrZTJ2S2tCQnhzbEdUOGh5M0pkU2xncXlRUFVr?=
 =?utf-8?B?OEpnU2lqd29QaE92c012clRndnNVcHhBLzdEeHdhRmY2R2tFckhkMDFtcmVZ?=
 =?utf-8?B?eHJ6dS90ZWEvR0hla0dibG9TOGhUeC94Wi9oUjBvdUUyUExHSUlnaXNWaHAv?=
 =?utf-8?B?VUxZcmNPdWdQWUt6TnR1UXE4ejN4NTl5disyTVJDWHhDaWpXQWRCU2JZOW9F?=
 =?utf-8?B?dzJsemVzQTBCaUhvZzhnMWlvQ21EUDRGOTdWZ3RWQ2RLOWw3M21KbnE2YjRE?=
 =?utf-8?B?Y3Z6Q2xwQnNNcDIyVGMrNXdOMzBsOEJwYnBOKzdTemYrTnJTSlZxbEJvWGJT?=
 =?utf-8?B?YTMvdFFDMDBWSDloY0FucjlNYlJlT2R0eGxhSi9wK2hUVXIzd0dOdHE1d3Vv?=
 =?utf-8?B?NCtybkhLMWUvRmpXTHVkRWsraHJ6Q0lGeXJYUVVkMS9qR09aVmtNcG1YdGp4?=
 =?utf-8?B?UElKUmpQeUNxZkVLUnpNaitTRTdRWnVwcGw1RWFVUkdYbXVYcUNxUGpSZHV4?=
 =?utf-8?B?TmNKWTI1VTRnS3RIZ0c0Rkg4eDd3bEJYL05CZXpJV1FoQTZjcm8vNmw5NUJY?=
 =?utf-8?B?cGZLTXNwUUl6N2lxdFJvUisvVkV4REo2MmxwUHdjREx4eW1DWlcxRndaeVVR?=
 =?utf-8?B?L1dJMUk3d05tMUxrYmE2TmU1N2NOVmMxalZ4Zi8yNDFGRDJmZlJ5RHJ6Y1Jt?=
 =?utf-8?B?SlFNb3N3ODc0ZlpIbjBoTHMyS3B3WXI2S0xwVGU5cjl5VFBQTy9GNXNIMVFQ?=
 =?utf-8?Q?L3pPASz4xFDsQ9pa9sU0dabia?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41440fde-231a-4f40-7a7d-08dcbc1b94a6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 04:43:02.4769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I07lgRhXGX1InbsxDBELocW5q0pMN8qqyNHKx0lK7lOAMwPe5WOqMTUdQjFLoiRCVw2sjaHcSm0uE1GdDcdnxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8776
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Aug 2024 04:43:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16785

On 13.08.24 17:44, Pavel Machek wrote:
> Hi!
> 
>> Did you push the tarball of this as well? I find 6.1.101-cip26-rt14 but
>> only 6.1.101-cip25.
> 
> So tarball should now be there.
> 
> Sorry for confusion,
> 								Pavel

Thanks, works now.

Without knowing all the details: I have the impression that there are
traps in the upload process so far. Maybe it is possibly to automate
them further and also share that automation across the cip maintainers?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


