Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171FBC54E5D
	for <webhook@archiver.kernel.org>; Thu, 14 Mar 2024 07:56:14 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.43])
 by mx.groups.io with SMTP id smtpd.web10.7269.1710402969112703699
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Mar 2024 00:56:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fEgYw3+u;
 spf=pass (domain: siemens.com, ip: 40.107.6.43, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezjvo3gmhV+snSgH5aZoAStuwtciDnEGMfhHWpz1kmgbd0UvFjnlBMDGY9ZB9HvR95bDAgjvk7BDXE9Z5VwonKHsp51DmWxXAvSqocmA1zNdUrUJuWOgv+wRIBal2T4gE+IEwKnjAUgKl5ydAuw+D+5tYokhf8fNBNrQcZ2iLCQDBaP0i/g22e2+7I9shc2bKA78MUtPX1Cz3UjFZow2AMFNjEr0dbGKgmnP2TWvlnNoLMJ7qoBIHkcJdoLACGgkkMT7RBHoaImM+Ufe69XhbmC5g5BXNuYicbFxjQGLo6FkwgyjDXqEy1aRaAYlQGfcYJIONf4rQUm5CzgqwvoWnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhFLeK+fmFNy47bjR+rGlwcW+UhimTN5c43sCfaiAqo=;
 b=VpIm3VbFCZOPr5VEpqUpbwGk6/vZfMWF7ZyigvuW52f6D4Fnc9e0GjSVdIrixI/rVMAtfqSEn9oVUCb6gfw8UQIFLTIfN5mq99oq7CfFhVK+YmUimG0DlavbLbada81PRGUyeQQ+ALnI7lecwJBs1LG5XTAsnlxhYUB5LWa6I+G8k8seug/mn3Jn+llPWTqVdWxX8NZEr+Z9afVhHU7f+t9t0X2n3vhxnwy+AVnliy3hcJ7R4wEM5Ab4V8QCFkLU4nAZJ+fJT8a0FfDeX1qC4O9HzYQfDnUbueyZ+Acyt7ot2IcQzzK+kINvfeplQJuouf1FLZEoKx0wYtLd7DU0Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhFLeK+fmFNy47bjR+rGlwcW+UhimTN5c43sCfaiAqo=;
 b=fEgYw3+uJJenz1kyC/GlIJ5h9FBCE5Hqjjkl78HH8Uq4Geyenvku9cObrc9N+rLYkVRqJosTdQjNwfrks6s1Or0/HTQJqVYEgBu5Wpga53qLX6YbCmleRIlfCRQTaByvscIuJkx9v9Hv89PlD+X58633d/L21gIPv03/y2PL4XzVHMmWPvEMt8DFupSJClCZVzgG7oL1PtOeW5ZRi7YZ4dYNaTY+6ibKEkKUSfR71xVp3/E5ax+IjbvjssvF0EUNlAoHNJeuT5NYo3sSGZS0qvjn+QnL8v3YnjemyVrp1WqBM/fg9fmCHjXXMrtOMXCs02mVzT7GjhLlZdv0LZUgCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AM0PR10MB3249.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:186::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Thu, 14 Mar
 2024 07:56:06 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 07:56:06 +0000
Message-ID: <9924d25c-a95b-4c63-ae89-98076ce75c38@siemens.com>
Date: Thu, 14 Mar 2024 08:55:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC v1 1/6] conf: Use bookworm
 backports for enabling delta handler in swupdate
Content-Language: en-US, de-DE
To: cip-dev@lists.cip-project.org,
 Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240307074612.1996609-2-Adithya.Balakumar@toshiba-tsip.com>
 <7a8e08bb-0d82-49c2-be8c-03ecb9511304@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <7a8e08bb-0d82-49c2-be8c-03ecb9511304@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::14) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AM0PR10MB3249:EE_
X-MS-Office365-Filtering-Correlation-Id: c37273da-5ad8-483d-7b79-08dc43fc33b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UFRyV7q+xsj5p7SMJNAyMyZ2undTTa8z6d19LtQFOfSYVaTEvQcuqAtNjiBEK6wTEq/gboQNF3XnskDF0j0KJRHOEHqH9fE5QkqoELfW0/zdqfAHbqS67FL6+/NsLPrIZENqGQB5vwAfKTD2bmzSzmZPnxasm2Et4Iv7bMNXilpjhK35c7k/TP+Gu1shZhryzKsYpPLV4vjNQcTS+HK+OPvTeAVPbkGNCSp/ry4zbWu8iqzhBaJgsndNaliZlrwVQ8eLmlTzY+oLuFr2YDEEfgxRTwHvIdlBu6fT9Ew3FDHydKHp6CsLEtR5f4fwCZTHwXaCVbnWAzrvJEN9h7KUVfVxedzjBdzQeCc8aXxq2q9GxlhAGQlaoFb9VEIrews8R2+Ag1Kf6b8oHxrn7hDTvCPl6H8ZWXuQ1LvKuvFOoFfYpcQw99m40VybpBFLEdTuBXWyxfBHgnLhhq7CnDpHDGiZTtnBjSkUFU8oN2OiHQ+04TdJzbbFO+v3i4mTwy9Ub1kce0UVyTe58IAgmlwmiXXxrB3vz0v80rbAdTs7uk9FQUMkQzWlFAXsF+sROucl54Ocq6Lcx8y6W7aXbLL9GCJBN4AKrIr2UK7GHP0sLMw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R2ZIc2hIV3dXMDZMQU41YkJ5dDFJR0lTMzQrME15Nm43Z3lHdm9CZWlOOG1q?=
 =?utf-8?B?UG9xbndqa1R6QmF6THc4TFk1WmVIVWg5cGRiRWtHRC9DWWhBeTdLSHJXZ0pn?=
 =?utf-8?B?UlZIaHhRdldrbGpVbTUyajdleEhuZ3dqM29YZTQ3aWZjbytYZmRKQ2xoamFH?=
 =?utf-8?B?OWUzd3M2QXkybmZCTUQ4cXk1R3pWY1ByaGlIYzBvTFY5YnBDTllzcVVMSFZt?=
 =?utf-8?B?NW0waXBHOFRNMTRPdFFKRlpuOUVPWEZ2ak9KaVB3Rmx1aHYyNUt4cE5ReHJm?=
 =?utf-8?B?SzZhTGlwVTg0RFVtMnAvUXJZdDNTZWF6SkdzcjNreGlrTWU2YlM0MmZqQ0hD?=
 =?utf-8?B?MUFHYTA4VFZaSVMwZnJ1SzZ4ODViMGQ3R28zV3IwdU9xN0dZUExXRTBHVU9x?=
 =?utf-8?B?V1diNWpPK2E3RWI5cEJYaFUwVEJVMXlXbmh3RFBza29yUVNpOHk4NHU1YVJC?=
 =?utf-8?B?eEtTK0tRV2pqVnUvU000ZVZJaTgydUw0c2xjdlZmQlRQdWxrK1ZUeDhmb1cr?=
 =?utf-8?B?YW0rQ2dSNmJocDNHdiswdUtIZnAwWk1CWUw4UEk0Q2lDNWxzUklKbTF1YVlF?=
 =?utf-8?B?MGd5K0pmN3h0bWZvMW1za2FyTE1sK0IrTTFnRXFwcWRiQjM3dFdXUHpsdlc5?=
 =?utf-8?B?UVdEbXZELzBWd0lLQ2kzbkp1Zi91WXpEUm54OWVTa1V3SDVBUTBqQVp0ZlV6?=
 =?utf-8?B?dVVNcEFJKzZsVkZBbVpSSUg0WWF5V2xNWlJySllaaUhaOW5OZlNkanR0cjUx?=
 =?utf-8?B?NzI0eTZLczY1WTZXR2lIZzdUa0tzTUV1MVFya3ZlS0sva2hhYTZrdkRiL0ha?=
 =?utf-8?B?ZDFDanU5ZWl0N1ZQaDVmc2ZCbFhiNHJWa0ZJSUtsU0laNGp2TXIwMWRVTFp1?=
 =?utf-8?B?cldPSjV6cmxNTHNGbXhoRERPZzc1NE4xT3BUdisrSFE4cFhUdjJFQkxWQjNX?=
 =?utf-8?B?ZU1RZ0huMjRwVDREbTdxK3l5M0lrTUI5Q0oreERNWUljM0JNQ3JXY3NRbDJP?=
 =?utf-8?B?VDdkcWw1YnExQlY5aFlGU2dlTnN5cStYUGc5ZmlFY1NFM3BRNmV5b2dxdHA0?=
 =?utf-8?B?UnZhL095SjBHbHFFUWFOa0hvNUxlcFh6Q0xyenYzY3Z6bDc5NzdhWldCcVdk?=
 =?utf-8?B?ZVR6OHAwU1loZlVPd2xLMXFSbGUvcmd1a3FHcUVQaVV0RFBCNXBWTE9nWTI0?=
 =?utf-8?B?cm00dnMxRW5kUE5pTDZWdDRSTVJ5RC83NzN3QWlCTnpiMExiSHBLVThVS2ZG?=
 =?utf-8?B?eFIzUU5zSHZEeXVFVVZyWEFQbkFIcHRreDBhZERVYkFqaDZGaktKZFNDMU1k?=
 =?utf-8?B?QkdCQXhodW5HamxoZUFOY0lPUlI4ZXI4Y0FBVHdrb1h6dHoxem5UdWpaV0xI?=
 =?utf-8?B?Q0dxK1RyREhmYnNZSG5tVXh1YnRyZjZzeXlKdEFBWjIwSUthQVFHd3pBYWVu?=
 =?utf-8?B?aGpjaUpENkVwS2JDWFI5ei9NczdGUDk1TmtIclRtS01VbFZZMW9PZnZaT3c1?=
 =?utf-8?B?RjM3azY4VzhLUnZnRGdUd0xKeHdvSjlrTk5MNGoyblorMjVZZnZDWXZJTXZJ?=
 =?utf-8?B?TGlwYXB6dDVMK0ZoSlFVUnhncndCM2VWUjdlNktFVStnbVgvTDVEYmpPRHd2?=
 =?utf-8?B?MFoxOUx0ZEw0VmFocUMxL0xtYmIzVjJGYlJucUNGbWxieFoyQmFrU0MvSzVt?=
 =?utf-8?B?aXJ1eXNCZFI4TUkyam1ubGFZeWc4YVIyTDdzTGxPdEt3UVByTVROaWFpbytk?=
 =?utf-8?B?TnNQc3NlUlpHZUxNdmxEK3k4OFE3aWJTWEoyMVFPU0NJTDRTZlAraWdxTmpu?=
 =?utf-8?B?QTY3TU9nbGxyYXhvZE1FVEF4U25yb0pSUTIxcG4wNnh0akRHSS9VZGxSVEt0?=
 =?utf-8?B?bVZOWlZRK2FjRS9aMXNwajVGWHVnOEVkdWt6S3BqRWlNZnFVZCtOZ0Nmblhl?=
 =?utf-8?B?VGJ1VkhzVE1rYTF1TjJlSnBnaWxGVmdSemxTNEVwTnlXN2tZY011Mlhtb3VI?=
 =?utf-8?B?a3c3NU54KzgzL3BGbzQvT21xaGtBemdVc3RwbnIvd2tyS2lPbml0TjlYUGpB?=
 =?utf-8?B?b1FBMFNhU25STmlZUmw5M2E3cVNaRnFJOUNsU2oxdU5vQlEwREt6b2NFKy81?=
 =?utf-8?B?Um1FRmpaUE1zU0d0M1BSUEthWlhtd1dFbDdvbUR4ZktDRGJxckJLakVWdDF5?=
 =?utf-8?B?T0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c37273da-5ad8-483d-7b79-08dc43fc33b2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 07:56:05.9508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFDFjD8R4DrDmDhpM2WUOae/HJDIR0p6s6Euw8rptiAiYp63F0CwxMBNUH6BElJkLys0qrdfjIf99TM8w+uhmtWS+N+dvub+CcQvo49PLzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3249
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Mar 2024 07:56:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15301



On 3/8/24 12:35 PM, Jan Kiszka via lists.cip-project.org wrote:
> On 07.03.24 08:46, Adithya Balakumar wrote:
>> Delta handler requires zchunk > 1.3, but the required version is only
>> available in bookworm backports
>>
>> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>> ---
>>   conf/distro/cip-core-bookworm.conf                   |  3 +++
>>   conf/distro/debian-bookworm-backports.list           |  1 +
>>   .../preferences.swupdate-bookworm-backports.conf     | 12 ++++++++++++
>>   3 files changed, 16 insertions(+)
>>   create mode 100644 conf/distro/debian-bookworm-backports.list
>>   create mode 100644 conf/distro/preferences.swupdate-bookworm-backports.conf
>>
>> diff --git a/conf/distro/cip-core-bookworm.conf b/conf/distro/cip-core-bookworm.conf
>> index 9bcf559..e0a4f7f 100644
>> --- a/conf/distro/cip-core-bookworm.conf
>> +++ b/conf/distro/cip-core-bookworm.conf
>> @@ -12,6 +12,9 @@
>>   require conf/distro/debian-bookworm.conf
>>   require cip-core-common.inc
>>   
>> +DISTRO_APT_SOURCES:append:swupdate = " conf/distro/debian-bookworm-backports.list"
>> +DISTRO_APT_PREFERENCES:append:swupdate = " conf/distro/preferences.swupdate-bookworm-backports.conf"
>> +
>>   PREFERRED_VERSION_swupdate ?= "2023.05%"
>>   PREFERRED_VERSION_linux-cip ?= "6.1.%"
>>   PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
>> diff --git a/conf/distro/debian-bookworm-backports.list b/conf/distro/debian-bookworm-backports.list
>> new file mode 100644
>> index 0000000..c4873b4
>> --- /dev/null
>> +++ b/conf/distro/debian-bookworm-backports.list
>> @@ -0,0 +1 @@
>> +deb http://deb.debian.org/debian bookworm-backports main contrib non-free
>> diff --git a/conf/distro/preferences.swupdate-bookworm-backports.conf b/conf/distro/preferences.swupdate-bookworm-backports.conf
>> new file mode 100644
>> index 0000000..b6efffc
>> --- /dev/null
>> +++ b/conf/distro/preferences.swupdate-bookworm-backports.conf
>> @@ -0,0 +1,12 @@
>> +Package: libzck-dev
>> +Pin: release n=bookworm-backports
>> +Pin-Priority: 801
>> +
>> +Package: libzck1
>> +Pin: release n=bookworm-backports
>> +Pin-Priority: 801
>> +
>> +Package: zchunk
>> +Pin: release n=bookworm-backports
>> +Pin-Priority: 801
>> +
> 
> Backports are bad when it comes to use in production (they receive
> best-effort updates only). It this the only options?
> 

As we need only backports for zchunk i would propose that we support 
only rdiff based image for distros <= bookworm. The zchunk support can
be activiated for trixie and later.

Quirin

> Jan
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15264): https://lists.cip-project.org/g/cip-dev/message/15264
> Mute This Topic: https://lists.cip-project.org/mt/104783336/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

