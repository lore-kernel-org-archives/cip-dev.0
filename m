Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E04CCFA18
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 14:03:58 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.40])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18061.1762869828649919948
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Nov 2025 06:03:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=H5bOU43V;
 spf=pass (domain: siemens.com, ip: 52.101.70.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ic+XnjmzQAjWu6c+DWK859alnRvgHEk/EqWp8XOM3FjgmlFZjsFYASMXpCh2pE+UhtUgmTdTAWbu2HW1bw+buTbmVyBXLE0u6LblpE+l1Hpdcbhs4onWDLXA6og6He/k1/zBpzfnlz/qKMc1bOOSNOqsw49y8KiKJHOZmSLx4JVp0Z20tG8zogwen890heEIKkmWURfEFYxGtAP5e3wMpaOGBStFZq4dzmNbaqzM3Zv50M8bJELH3q/aoG5UOyqBQucESLFaldF1eP3NrtrBP4MWLPqoyPAe+dDthNU70+09G4dtq4L0lXtMdDusLZ48jQ0ktE4fARruTu0aOT4qWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaHBuAxfgW5DT5m+5c2oKrVBylEw2KeJ7J2VTWefvuc=;
 b=bwerSr+pBa+xXIFUZSiabQcGNUxMWR/g7RLhLDEwKA9ISI/E2vdacwHAeJ6xTrytLEusnpm7GUclXU7xnR4vjNz1h+b2ySykDQQ6lmdIAvXDp1dkJvPvXvTcTcx+aowhmx90bYLR5ZYSNEQ1z9RrZwy77kKlOqFT+QLjpfvt4Y3iHGz+B4JRBUKraOTTVkm5QJ1BET3ij3eLEe1tHcY5GKW75Z4nlJHkl2kMusfDor64mqrbyaKr+YPUop1/leeoWFvwUFgVPUEkGagfUG1wv9qCJFcCA4lpM2YZwXJeYLtDDW551jzgcHgAgqfIZ6OD+fYOSLngp3yTTTJS9TGwJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaHBuAxfgW5DT5m+5c2oKrVBylEw2KeJ7J2VTWefvuc=;
 b=H5bOU43V0c6DzzfQbDub5GZYMQAhvOwU9Y7LkqNTbtI6AE1d2IQOsSQfKI5mcPxyUQQl0MxCCVmTvZHQAHRfdrBrYLfSALgmxQ/hiWMEzMBOFau2uG8piPzEvYYwOdCbWxWKtinRr7mjFctiOZCFttanAB10yo3SzMSoFbK0MczMN8oK3cwseXFGqEluqLqZ9ZQmjhyeSileCD6dDImtpTgxcikwEk4/PWgByh77EWXMN1n4zoGHbH0FKfcqypqlfuDVj6nrWhI/4d+ZzIQV2RiZqHBcDbz9B9zmLIdDq2CXBGF1N+7uuooXi54nWytGG2XV4fE0D4LlkE1WKFr4tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA6PR10MB9598.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:519::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 14:03:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 14:03:45 +0000
Message-ID: <62a8ff54-596c-4a18-9b09-be0c7cbe4d6d@siemens.com>
Date: Tue, 11 Nov 2025 15:03:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] swupdate: generate reproducible source
 tarballs
To: Cedric Hombourger <cedric.hombourger@siemens.com>,
 cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20251111101231.143022-1-cedric.hombourger@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251111101231.143022-1-cedric.hombourger@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0017.namprd20.prod.outlook.com
 (2603:10b6:610:58::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA6PR10MB9598:EE_
X-MS-Office365-Filtering-Correlation-Id: b0f0c6d5-c4eb-49be-8a7c-08de212b20c1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?d1RRLzFCR1lDdnZyZXpmak1yc0tKTVlMOElkNlRvd3kvZGo1a21mTXdZTFNw?=
 =?utf-8?B?S0dFZEpEbUJRb1ZKOG02aEROd2MzR2ZnSnVDdzdpdVNvK3lpcDViVWI3OXRt?=
 =?utf-8?B?NGliK3hzQmx1QUE2eVlvZ3JpeUt6ZThPY2ZxK3NtWE9IS0doWUFIUWZHNkxn?=
 =?utf-8?B?TWJJTEZvMGgxT0tIVDhOOVpReVVSSW9TemkwTXFGMDNWQ0J6MnpTU0VGczBk?=
 =?utf-8?B?OXF4d0dOS3hTS0RqalFYekdDN1Zyamg0eFZIQ29HYXR1QTBEa0JwRElWd0M4?=
 =?utf-8?B?TzJiZEZiZTR6M1MzVzRST0xkcEpMYmpzckJMTG9wbCtKK0JlTUNELzBpcjBk?=
 =?utf-8?B?NTJ0bjVLODFITmR5eWdkOVJVL3YrQXdPZk01T0thRy91cEVBdmxXeTNWdGlw?=
 =?utf-8?B?KzZFUkVrMU5wUTllRUlWb0VKU0cxYXc3WkRjNzZuZ0FWempDQzB5WmM1NUJP?=
 =?utf-8?B?WUpsaGVmTGVIM1cvL3o4MW1Ob0g0YjA4VUpFeDBmSUluVURBZkl5TEdpQklG?=
 =?utf-8?B?V1FuMkxUbkJ1aG5OK3ZMTTBaZ0lTcDVJSUZxSFg4eEsxWWpuVHhBQWh1KzdQ?=
 =?utf-8?B?QmVONWVjM1ZXVnpCSDBBMldrUzBkQjhvL1hmMW1DdmRDRjR5cTQ1djBLNVAv?=
 =?utf-8?B?aFc2SXlSa0x1Rzl3SmZPanpmdnF2Ulk4TGhkSVhXdlJNZlBhMlpQQUJ0Rmxw?=
 =?utf-8?B?NmNJNzRGSUdnY0czVm44MjNEakR3RnVvTktZNnJ1K3R0WkV0UXhrNldCZGZk?=
 =?utf-8?B?eTdpbHpTeFdnV1VCTUtJNjNsYWZOTjU3VmdydVB3V3c2OVJERFpWRzN3WU9Q?=
 =?utf-8?B?eWJSbDV2NmxYTmdpUEdjb3VXdU9SR211bUk3WUtrNVdDSzdEU1lKNmF5a1gr?=
 =?utf-8?B?S1hGa1g2SURyb0NhTldtV1FvRnp6N3JLREpHZzdEb2ZDS0JmTFNLSitzUzJO?=
 =?utf-8?B?MGtJamluaGlGdDZzWFpTcnEzbGF5K2ZWbHFpd25DbTRwT2ljWTRpOUVtSUpY?=
 =?utf-8?B?djBCOE9YOEltU2t0aWtubDBmUnF4eStoNzJlT2tES1lySzRvdzEwa1AyRVVn?=
 =?utf-8?B?LzJhMzgwdHVLSUl1cUJjMUJ6RFJ3WjA2UjJaT3hBMjZRMXpOcG52NUJ2b2ht?=
 =?utf-8?B?alpwUDdoMjAzdTVxSXE3MW9yemQrTFVjMnFOZnFnNDY2ekRwa3l3ZlFrL0Fk?=
 =?utf-8?B?YUQ1UTJMTXkveUpvbW1rZXEvY2RRSEhURXUvZVBESjNDdEdNeFdhcy92WUtI?=
 =?utf-8?B?a2FaS1FJMGRqMDFvNElaSWIydEo4RDUrY3lZb0Z1YUJzelQ1VWhtbHZISkJz?=
 =?utf-8?B?dFN4TVFsam1tbVZ2a0VtVEZXL2RrTU1iSStvaTdlRGhMRjZjWWI4emZPWEpR?=
 =?utf-8?B?c3p5VWwrUFRsRFozU3VZMEpRS0xoZ240UGNNSGRhcEFUcWRhNlFSU1lNZG1T?=
 =?utf-8?B?czdnRW81cmFPYURnYWF5UXpvdFhrNWhtZ1AydUdOcHZGQWdnOVpDSzRsZEVh?=
 =?utf-8?B?RERTTnVpM08yVEJiN0lTWHh5bFl5by9GdFFVbi9Ddm84SWRVaXBWZlZJZWh2?=
 =?utf-8?B?VjRzMzRqS3RSNGFQak1wQXdsQ1V2czZ6MGpaQ3Y0SG5EUHR4WXZmbm1GbzQz?=
 =?utf-8?B?ZXkrK3FpOU0yVzg2cERqVTV2bE1xaEYrTTcyL1FRY0RCRUtzYXNHeDQ0ekdP?=
 =?utf-8?B?RzlzUXBrNkFQS29UUFJuclYybGZLTk5WUFFYQmZRUm5JVnZHbVQ4amVoKzJo?=
 =?utf-8?B?NWd3dDhzcFdzK2hEU0Q2QjhZbnlwdHdBWlh3OEU1MmR0bmpPVEljQkhFYlFn?=
 =?utf-8?B?SDhHOHlZSFRFd0VtSEpqR3dnS3dkWEFlMm5rcDN0YXNjeHU3Vjl0UkE2YVNy?=
 =?utf-8?B?dkZEWDF4UHFhME11Yjl1WUFHUXNIWkNXcTlzamw0Vk1FK1oyOXpHZk1GYVdp?=
 =?utf-8?Q?PD1Z92YAtSz0M5jxoxEhMWhyMVct6g6u?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?em1xWDgyalZ4UThzK2J6UExNZ0QwUHc4R3l3bi9jdmJ3eC80VnZhZW4xUjhj?=
 =?utf-8?B?NzJQQ00yaFoyeGY1bmZtSWZUUlBEYUtZMlEvczdiMGs0Uks4ZndwcDdQdlNk?=
 =?utf-8?B?cmFYWjdjdUo3ODhZcjlTcTdHRmtPdlp1TmtTdzR0MDR4K3d3NG1hNTc2eGF5?=
 =?utf-8?B?SzA1cklGYVRmUTJhc3lPQUhGVlZteEkxaFNzMjhTL2c5b09qOUZCK1Z5VERI?=
 =?utf-8?B?MEZ2SjAwU0lXSWVlZ253VGhLdlNtNzZHK2dRcnlkOHluVm5OMGFKbXRCLzY0?=
 =?utf-8?B?SzRuNFdzQnNqbUlLNnpMdjJmV05zSmdJcjJDQ2lLbDA5KzFiRW44UzRJUXlM?=
 =?utf-8?B?SnhjdnhVbEJ2MDNjRFRqM0FkaUdybThjQ2RxUnpNL2dBRFJNV3pTdjZ1WUsx?=
 =?utf-8?B?K1l1TmNqU0s5UHpvNWVXaXBYOTNpMy85NlRoaXNZb1B2eEJacE9ac0I4RStK?=
 =?utf-8?B?SWF2Ri8zK3U0TitPZlQ2K2J0OWl5OHVRcmpQY1QwZVkyREV2S08vVXBISzZ0?=
 =?utf-8?B?UEpwY1Z1NGN0N09iNDBKQ2txMmxwenpsRHVzOGhhUDZ6WVhRRC9jY1NtUXJH?=
 =?utf-8?B?eW9KU3o5emJEVzlwa0lncjNpYW1jVFE1R0ZaNDdjUFpDVWNob2VTejZqSXRo?=
 =?utf-8?B?Z2g1dmxkY0R4WnJIODJaNDlxb25sQ3JGOXRyS0tHemt2WTZzVWEwNlVOMFQ3?=
 =?utf-8?B?bzg0cmtHYUlacHNTOWZhU3FpN0pzQ1UyQ2NzYXZxK01jVDg2TVlZbXpYTit1?=
 =?utf-8?B?bFdmOEd0QUVicjAzUGh5VTYwMkdBZWg2NVV6Yi8wcHJHQ253R1RNamRDOWJF?=
 =?utf-8?B?VmlxUmNvYUdieHk0ZEluOUU3eExVWDVnMmZ3aHNJcU5lcEtmMlBJSnJjMnpt?=
 =?utf-8?B?cWl3VlVrQjZlWmJ3VzNTcklvdmFzUDczMFpvMUNqS2N5L0VoQU5lOUt1TlFM?=
 =?utf-8?B?NVNybzQxVzlzbFZsdjFBYXdYcEVSTFJNYitqa1E3b1g1TnF2a0FuYmNxVUVZ?=
 =?utf-8?B?QmQyRmpNNHRrUU5yQlRZL2hHNjdWQnRJSFl0QTFoLy9rT1dsTk9PZnNvTTNk?=
 =?utf-8?B?cm9yZTVXT2d6azJoc1lCQThVaTZPZ1Avb3o0b0JOUk9hRkh0QWxFcWY0Rkp1?=
 =?utf-8?B?bDZQdHhjQXFtNkV3MmhUVUg4SFlkRUs5TzlqQ0ZCbWNoWGhvZElKbVVwb0Rs?=
 =?utf-8?B?bGZKQTNIUjZzNHpjNWpmOHNWZ2Fzd3E3dStPWUxpSnJYazY3RkxnTDk4S0Iv?=
 =?utf-8?B?bkhNRWZpeUcwdFcrS0xNdTdtZlFRY1M0Tk9aTVBLOUxlNW5pZDFLcm9lVTJ6?=
 =?utf-8?B?d1FtQ2d3VG8wRGJJcFU3aDJ0aGordHFTVDVMazREVkZvcjZiYmVQYWNaYXg3?=
 =?utf-8?B?dVZYWEpmMmM2Z3E4RHFNTG5uS0luOU9mdituczdlNi9xOUpNZm9OMzM2N1kw?=
 =?utf-8?B?WW4vNE5kSGtpNG1tUUdFMUtoNVk2aXJhcHpMYlk3NnREQnlzeEtiUXE5NWlq?=
 =?utf-8?B?T3RaRmtoOXAyajY0MGJUa2VEM3IvajJYYWJNamhFV3BOOGdyWUt0YXNHUlFH?=
 =?utf-8?B?d1ZhUm5HL1p3WGdvVDcrS3VsN2N0UXA4eEkyZ3BpQ2tDTzNIeVYrTkgyVlAz?=
 =?utf-8?B?VFJUclRCWFNUWE04WGlkSS9DNXROdGFQdXZNVmU3cTE2KzRkNEFJZlllTkFn?=
 =?utf-8?B?K0Q1T3hWdGNldmJtekswb0lmNys1Yy83K2Jqc3lxb3Vqdk81U3VjSVJIL3p4?=
 =?utf-8?B?WWxib3dJZ1UvYkhGd1liSTd3ekxlamJSZ0U5MHg2NjFwZi9nL0phaGJ3OHB2?=
 =?utf-8?B?YjladS9Qa0lnWkVRek1mdEZJb054Q1dqa3NqZmdDS3dZR3N4YzJoY0tZbXlv?=
 =?utf-8?B?VzFTeDBSWFV1eThTbVNNZnN2RU5nT0ovZnBZUVFzc0puQlJ1MEtad1F2Q1V1?=
 =?utf-8?B?YkpYMFdSd3JlMXJpOS9jbVlJaWtnQkxLSTBpY1R4eTlPcHc2MjBtcEgwNE91?=
 =?utf-8?B?ZVpBbWJFOUFwNUN1RzN0UDhEYmNaOVlNN0xMNEVLQUdCTjJKd1hmcnJyUXFY?=
 =?utf-8?B?WlBESjFCeENzYTNQNHRMQ1Z4NWd4cFJaZUdPa1RUMTE4TVlNYWZuOUg5cjgx?=
 =?utf-8?B?UGdjb3ZYdWlMeWR5R1JqR3Z1bWc5dEcvZWl1cHZRK3BXRGYzdkMvRkE3RTQ4?=
 =?utf-8?B?dFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f0c6d5-c4eb-49be-8a7c-08de212b20c1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 14:03:45.3773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJeDYOaPeU9lOJqIN31PAhxLqho8379CXHNEi1WVQk5/0EH9kOXCvDEuwN3J5W2DP2M/61loUWcAQ3cNuM7ukw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR10MB9598
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Nov 2025 14:03:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20494

On 11.11.25 11:12, Cedric Hombourger wrote:
> Apply additional options to the tar command used to generate
> reproducible source tarballs: (1) use numeric and null [GU]IDs,
> -clamp-mtime for file modification times to never be later than
> SOURCE_DATE_EPOCH (preserving mtimes for files not modified by
> the recipe) and --sort=name for consistent ordering within the
> archive.
> 
> Signed-off-by: Cedric Hombourger <cedric.hombourger@siemens.com>
> ---
>  recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb | 6 +++++-
>  recipes-core/swupdate/swupdate_2023.12.bb            | 6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb b/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
> index fcccc2c..b5becaa 100644
> --- a/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
> +++ b/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
> @@ -37,5 +37,9 @@ CHANGELOG_V ?= "${PV}-${SRCREV}"
>  do_prepare_build() {
>      deb_add_changelog
>      cd ${WORKDIR}
> -    tar cJf ${PN}_${PV}.orig.tar.xz --exclude=.git --exclude=debian ${P}
> +    tar cJf ${PN}_${PV}.orig.tar.xz \
> +        --exclude=.git --exclude=debian ${P}
> +        --mtime=@${SOURCE_DATE_EPOCH} --clamp-mtime \
> +        --owner=0 --group=0 --numeric-owner \
> +        --sort=name ${P}
>  }
> diff --git a/recipes-core/swupdate/swupdate_2023.12.bb b/recipes-core/swupdate/swupdate_2023.12.bb
> index cc01a98..50df215 100644
> --- a/recipes-core/swupdate/swupdate_2023.12.bb
> +++ b/recipes-core/swupdate/swupdate_2023.12.bb
> @@ -50,5 +50,9 @@ CHANGELOG_V ?= "${PV}+cip-${SRCREV}"
>  do_prepare_build() {
>      deb_add_changelog
>      cd ${WORKDIR}
> -    tar cJf ${PN}_${PV}+cip.orig.tar.xz --exclude=.git --exclude=debian ${P}
> +    tar cJf ${PN}_${PV}+cip.orig.tar.xz \
> +        --exclude=.git --exclude=debian \
> +        --mtime=@${SOURCE_DATE_EPOCH} --clamp-mtime \
> +        --owner=0 --group=0 --numeric-owner \
> +        --sort=name ${P}
>  }

Seems this pattern is limited to those older swupdate packages, at least
in isar-cip-core. In isar, there might be one similar case (libubootenv)
- and couple of them around vm image generation.

Back to package customization: Is this way of generating the orig
tarball the best approach here? If so, and given the longer list of
options, shouldn't isar provide some "reproducible_tar" helper that adds
what is needed?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

