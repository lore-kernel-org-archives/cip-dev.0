Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76240C54E5D
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 12:00:34 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.84])
 by mx.groups.io with SMTP id smtpd.web11.41635.1710763223767459415
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Mar 2024 05:00:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qhMavoj2;
 spf=pass (domain: siemens.com, ip: 40.107.7.84, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCp80yfAJEf8Ah8xLNr5cNacbc7L3GDq4Vv1J2zP6/JSH7yRnSCbYJN9A/c3mJUU754ZLEV+zyuPhHai2My1HRG0yPSor0+ZKKQI4inJV6epM1SfNK76xYBgwXFlwC1vXLkeuwB8zsHx5eI0llA9EFbq4AljQcDP2n166JAIM+hmqsMrrwZ+3KnlxN6z7VJ85F8Z7aHL+5gftcqCK+Tr7bQXLNOxu3wI7DsrUxyBFQuRUESmk4NpROIxFWNZRIZKd82K7fd4INCPUHR4PtBwH/jRVeG9WNdj9P2hqDejePJ8ty3StuScLhkA91d4aNu5Aj6iScTuu5qToX+gvwkmjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAkJkCtamTF9iyyBCifkvM8McL5MujS3gkcIBCU4BsE=;
 b=GK+z/t0s7ftfux1MclDXo5YCkpkn6Mxnvp47D1hL4DbuejWV0ghdS9NjuI43/rogTf3UFIBsM7LpAyvkRqTRzFBefUaWkUtE7r+myzIdGbwFF4jgK5jCphPgUSh0mVTQVpmM/ZtzpD76q/i+rr5QvkcLXYziVmmzDQK8bOcY8fdPqEYvbWlwWJ5Xu5B/cZ0U6n3ZsJzhr9JETuD9zpe25MeuM+EKqT6aPqqZoOsgtlUhQMI6TO34LWnw0fhFZq0IyHrc5nV7BGRvAC5JKNdN8De+WnIXGQ93B5/llxc17ltJ5jHHFlL+76NhS+EmguvTJAbQy0FmcaY7n1hF3mBiHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAkJkCtamTF9iyyBCifkvM8McL5MujS3gkcIBCU4BsE=;
 b=qhMavoj2bvIIn3vhAz4cdT2U6InubRxcRHuglo+/HBYl72fNGhLsnWVGNLdrb78i/F+X2fxibugZtzLCb5AJyW5peVZ3oD7PAaRbUkUN2BVtsagi22QmD/M/FW0xZia6ayTh549i3py+EGRZqQwKt/WROdEmZnkq8Y0iH79DCM8Gywnu1/MKvX7CGgevV2bq6cW/2Mx2Udfwa9zmp0nWwP1ZnrlCPnzyNfmMp2F2H2gWL5PhGlMjwHjJOVh2E7/zRAhZtDivMJYek7Xiq5mxqPIlEDPJrGoTKAD3UmRkw11UsgeZb4a62oems+jl6Y76inDGZWmVfzfAJZKwoFjnrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS2PR10MB7372.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:604::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 12:00:20 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 12:00:20 +0000
Message-ID: <16dd03c7-c521-4331-afd7-c5f39fc07606@siemens.com>
Date: Mon, 18 Mar 2024 13:00:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/3] conf/distro/cip-core-*:
 prefer swupdate 2023.12 for all distro except buster
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20240314123736.1100948-1-Quirin.Gylstorff@siemens.com>
 <20240314123736.1100948-3-Quirin.Gylstorff@siemens.com>
 <8397cef6-2e9c-40c3-8ac4-8e48a3ccbaf0@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <8397cef6-2e9c-40c3-8ac4-8e48a3ccbaf0@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::19) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS2PR10MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ecdbf2b-3cd4-4e63-752b-08dc4742fc0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ICTzJ9lLfLGXPC/Ac7aIyoAINCWk8igkIgdMcL+pwF4eptXrt6VYtGVtJI8yDRZ4upUDADnMuVKQCf4/0ObU82agBpowdQaAagE3pbq+8BhMZm/2Q+6Xi5BzG2wlta4iEx+CKuHk/BdAvY4CqtyAxc+UXRbD4vYoEavTocJEqBNAtCEfZcklPr4xL16b2IhTD32mhF2U+gQeMcmLSFMhMvLHiR4V5OwAbdDEDuyy3/RU8BXI+N8mfNbecV8axhw0KvjGabYXr2g9n06TrWNFJNeRnR79QKu/a67j8QxSvk17HNdi9tQRjZPcZjadyBevLfPuSryJ4HlJsiCNQ+7YqzUobGfGGDvYsSQeqA+IvPg/4te4as/6Ka2pvmhUI9Dktlj+5ktmrPDifVGM51fHNXAbuKEH62r1PFszglFY+JyFZEHaQ49oK7DFrx9xx2bYyFJ9bUs3zzy8rTiJJDwu/+6z3z4kz0YTIAWm/JGmH7AlB1srNuinVleDH7ZI/ogNri2YBjZQWGnnL62NoFuJq8N5M7vFt+wHlrWkj7ZMkkQ166J7CngJWtj5PLKw7SF/v9pzINXMiBfTHKIuRll757Dv6rNnzqdsApxx25X9SJiQVX3SP6lq6bV5n+A05tdpmzoksh1/HK/ns2E9C0GEimrrzciq/1Qlh9bBQ54eHio=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b2FGb1NmM0p4amtjUWZQeXRVT2F1MjVCWjZuVmRXNEdPODNzZWVLRndWalNM?=
 =?utf-8?B?VTB3U2pBSG1GcHFWQ3V5d2ZOZEdhWDZhb0FVN3JUaXUwbjQ5SktjbnhuYjFY?=
 =?utf-8?B?bzQwdmhFbExTRS9qNUxlY1dEUXBwQllKZ3hwQmtwYVlOVE96dFVyTzJRRzV2?=
 =?utf-8?B?V1RUN1dvbTQwUnBrK0ZqcHZOUi90S3ZzSEwxbjdUT2hFVTFXRDVlRFRySWlH?=
 =?utf-8?B?ejhmbUVFQTZscGRnRDhERVVxcTh4TFpvN0VMU3dxaUdnSXoyM25MVzBiSmZM?=
 =?utf-8?B?dmVJYkpyVzNBSkIxWGY5YWh3bCs5RzJtZDdraGpBSkM2Y3VoWjRjQ2pzYk01?=
 =?utf-8?B?MnZvcmVyekg0REVPOGRpUDM4NGVDK2wwT1REVDVldXVBWGM2SVdvY3VZY1N0?=
 =?utf-8?B?TEpxUXVnYjZiNUpLK0gxc1c0Tlh4RmJrcmkxS2lNamdocUltSHRsV3h4MFB3?=
 =?utf-8?B?ZnJkQWl4VWZ2ZGZlMjN5Z1dLUjc2dlRVRnFRN3lneVpUZjRwYWxnOUdIRzZr?=
 =?utf-8?B?MlJ6ci9nbllnSzUyaTRtdm1tbDdaWEFrQWRibG56SmtjdVFzakVoQWFVbHli?=
 =?utf-8?B?SEdIY2Q4ZEZRbEh4S0k3K3p5dUNleFVodElwckNXbm0zN3ltQWt1SDltQ1Jr?=
 =?utf-8?B?MlM0SWVWQi9uemd1czVmR0hVdmdmRWJ0Ui9OWFZkbEFqa1U4anJDU1V1MHp5?=
 =?utf-8?B?aWFkOW1zV0x4VmNaejlDa0pkRW13V0htQ1lRZzRBa25PUEZPUDZ6RXZjOTFN?=
 =?utf-8?B?ZzNEeFZKSVo4VzhqaFVlYWgvUStqSmhTanpPWmZhM2xGWUxCbjhPa2JvcnJL?=
 =?utf-8?B?OUVVUnBIdWg5TW9KVFB1QkxjdkxlSVBlNkdwYmxmMHllbmJmSDY0djU0N0dX?=
 =?utf-8?B?VUthRkVIWGNFZC9mYW5ndFQxTGIrUTgvWC9IVlorRFFkbXNWaWJvRkkyQ3Fx?=
 =?utf-8?B?MXJUNkg0UGJ3a2FJaTA1VGdITzRPMVY3SXFYZHJKa0JyZUFGVXVTakYxcFBL?=
 =?utf-8?B?VWlOUThGaStycGxiUUpFaTFDNjB0WW16RVMyVFZTR0RqVWdjU2RzdFk0UGhX?=
 =?utf-8?B?N3BkMERQbUVOUm9vdERGVTlCYmZyRk1kRFJUSkpPQU10ZUxCaGpoTzVpcVhK?=
 =?utf-8?B?MVV3WW1ickZ3bklnSDhPaEdjR3dhZ1BHdU5ld29yeDNocjhCNVpQaG5TYnJT?=
 =?utf-8?B?blBHVXBoZXpnTk02M3laY2JlYkRJTWZ4ZmVFb05GbWlGUk5XaFd2cXRTbkx6?=
 =?utf-8?B?VjdVZ3dSV1V3WWpiVVppVU4zNVJJWE9HNjFaVnNHdURjVndVRGwvR1A1a0t3?=
 =?utf-8?B?U3BKV3FjU2xLOWlYaWdNalBkSWFHclEyVEcvTWp3NXhxOHRBWnFpb1hiV1V4?=
 =?utf-8?B?YVZmMGhmaGM5empESmlvSDUvZFdKWDRLVUhGUGpMaTZHUTRNbHE5LzZYZGtH?=
 =?utf-8?B?WHhvZHhYczNtSEsxZlJEb09UL1FqOVpBRDhIVktUYjRYN2c1dzE2YTBjeGNO?=
 =?utf-8?B?OS95aGVwRGFuVnNpTGI3WjBzMFFqZmZ6ZkF5NXQvU21HaERMYzJiR1hJU0tH?=
 =?utf-8?B?WUNBZG02SGprZVVNSXFjSDFUNDRFeGpZQnhrQ2YrVHAzekNQdDNEd01pTWt5?=
 =?utf-8?B?c2h4MTNzdjlybnRVekRQUFUvRkhyelFvYUlLRW5Wc041cUdjNzhMUjd5L2xl?=
 =?utf-8?B?RXlLTHgwWVdJQlVBbm14MWI1RlZKdDZJUTBsSU5oZG1FbXI4ZGFtMytLclU3?=
 =?utf-8?B?cHk1YytoTjVlL2IrQ0g0bjFQSHZoRkJVaEUra1doUXF4VExEdS9uUHpDQjhx?=
 =?utf-8?B?UjB1aTZwTTFsS3hWek5nejhnN1psbHA1U0Z6NUhLWitPZFJIZ0RmLzRIRnFO?=
 =?utf-8?B?T1J5M01uN1lUTkc4STc1MXV6YjhvT2tiVU1MOStLTlJRZmRzd2lPb1dZRENT?=
 =?utf-8?B?WGlYZnZDSENFVEhTdlF2Y25vMVkrd1pxMkphc3hVTEhPUk1GcmFyYVVDOCtY?=
 =?utf-8?B?N2dEM3RUT1Rwd2tKcXVuTVppYWJZSW1wSnNrTUU5dXp3czN2Yy9BaTlPdEdw?=
 =?utf-8?B?QmZpQ25rNlI3SUNmamg4ZkRNV25YZkdnTGpoUTRWVUxiSjJoNkNTcklYdzJt?=
 =?utf-8?B?c2czMGpxeWtxaWpHOC9BMUFyWmR6S1M3Sk9USXBlY2N4cUkrL0RPY2Myd3ZZ?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ecdbf2b-3cd4-4e63-752b-08dc4742fc0d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 12:00:20.3575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWDIKU8oVFHrNHeBtP8zDXEmUeiYWM6/CGnNjcuNeGCUuSSKTmCShrT2foqpJg3gy5k2xPaSq9HVHC72ZyRD1FuDyNCO3QdaAhzFC7BX33A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7372
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Mar 2024 12:00:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15351



On 3/18/24 12:35 PM, Jan Kiszka wrote:
> On 14.03.24 13:36, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   conf/distro/cip-core-bookworm.conf | 3 ++-
>>   conf/distro/cip-core-bullseye.conf | 2 +-
>>   conf/distro/cip-core-sid.conf      | 2 +-
>>   3 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/conf/distro/cip-core-bookworm.conf b/conf/distro/cip-core-bookworm.conf
>> index 9bcf559..634a666 100644
>> --- a/conf/distro/cip-core-bookworm.conf
>> +++ b/conf/distro/cip-core-bookworm.conf
>> @@ -12,6 +12,7 @@
>>   require conf/distro/debian-bookworm.conf
>>   require cip-core-common.inc
>>   
>> -PREFERRED_VERSION_swupdate ?= "2023.05%"
>> +PREFERRED_VERSION_swupdate ?= "2023.12%"
>> +PREFERRED_VERSION_libubootenv-dev ?= "0.3.5%"
> 
> This line is not explained - is it actually related?
It was related - I will send a v2 to drop it.

Quirin
> 
> Jan
> 
>>   PREFERRED_VERSION_linux-cip ?= "6.1.%"
>>   PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
>> diff --git a/conf/distro/cip-core-bullseye.conf b/conf/distro/cip-core-bullseye.conf
>> index 4f26299..110f334 100644
>> --- a/conf/distro/cip-core-bullseye.conf
>> +++ b/conf/distro/cip-core-bullseye.conf
>> @@ -15,6 +15,6 @@ require cip-core-common.inc
>>   DISTRO_APT_SOURCES:append:swupdate = " conf/distro/debian-bullseye-backports.list"
>>   DISTRO_APT_PREFERENCES:append:swupdate = " conf/distro/preferences.swupdate-bullseye-backports.conf"
>>   
>> -PREFERRED_VERSION_swupdate ?= "2023.05%"
>> +PREFERRED_VERSION_swupdate ?= "2023.12%"
>>   PREFERRED_VERSION_linux-cip ?= "5.10.%"
>>   PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
>> diff --git a/conf/distro/cip-core-sid.conf b/conf/distro/cip-core-sid.conf
>> index aff4572..692c105 100644
>> --- a/conf/distro/cip-core-sid.conf
>> +++ b/conf/distro/cip-core-sid.conf
>> @@ -15,6 +15,6 @@ require cip-core-common.inc
>>   DISTRO_APT_SOURCES = "conf/distro/cip-debian-sid-snapshot.list"
>>   HOST_DISTRO_APT_SOURCES = "${DISTRO_APT_SOURCES}"
>>   
>> -PREFERRED_VERSION_swupdate ?= "2023.05%"
>> +PREFERRED_VERSION_swupdate ?= "2023.12%"
>>   PREFERRED_VERSION_linux-cip ?= "6.1.%"
>>   PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
> 

