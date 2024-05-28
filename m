Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA52C25B78
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 14:47:42 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.80])
 by mx.groups.io with SMTP id smtpd.web11.24236.1716907661811231922
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 May 2024 07:47:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=EUxjST/i;
 spf=pass (domain: siemens.com, ip: 40.107.15.80, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G37IlHewmp5+wd2btOBhyRiAJd1okus3hw8nd6I8EbG3AH7ukXV004OVWc1LW/a8kHytJFrexbUlE8lRO6nYKhOPplN3H44MPxO7JnUxIPz8km5bmIXA+NXEk6weTcyfISkHcBnzApxec9fGZl3H1IGhHFYNeIViS0nC9O5lSSdAGD4baqPZJONWAauyzenGxsAsbs2NuO5Tn42eg/bIjVSbrhZttSDXjZRYloQtJyE5VN3/QkdYkslcu8A4AvV9cHS+AmWAhKNkXAL3cPlOmIiPd2nBMwMAbQjIAc5KflYf3lAXECkzoSMeuSs4FhwkzOb4MRZN2DwusD7CfGPB4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mztG9Rb/gC+Z0/uhRtzOIWtyoxfL1PBka9Nq3o2P48=;
 b=OMqB8ZCbh3awNOz8AicLwtnuNbwimKO8Bc7gOi0GHwETUhsxqaypataOhzW86ZWRT8m6wltZXM4U2VXSeDT7h9wiC04hw1MgSZTcaS+zzqxeRuwiN6DAxWl6Q4y8XRX1+aMUU4i0Qw7Hwa1iNATLVbI5b9qE3Tvzfgxg573C2CIOwlK96Ekhn6u7HEuRrr/8lwXkbZOLv/cjYhQ7G+yze92PwwLDbWeuoW8PLhTxvhi4xuhrecBCw9WszXRikKdGQXY8DZO34xKY38/LgUl6rpPMWJvgjlAWVsQgYPrYi1ZLjsuPMbB95sOfzE4WSxrSPuLj62RT7OhE8cdTdezv5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mztG9Rb/gC+Z0/uhRtzOIWtyoxfL1PBka9Nq3o2P48=;
 b=EUxjST/iSMgQDJgECaXQCJqqX+Ufz+vOiMLgdhOTS4bLP5TDbE/SrYI8hwUOyEhuNDwNtK0CHLRGk6tFkI11Ue0zSTe5E9c0sY+BSeuulWYaBQkNXseALnAxVaKxMWn3cXXbzEbcfwJA+RBwZV1I6RtU5TUkGp3f/PqGfBcZffG58bW6f686g0/DEMpP4ltM8DvX/pXs/YYNna9Xtpdq+QWFP/ct4/IprIax/jT5Jl34dKy8OgjpiXyS/2LvjT5j3v8k4p2aDG28qM3TV3V4acvyj7MoVgksdbS8+8W/oNOUUTdXXlHDZmMyqzPg/Zfv6Iqc/l7u1gVcahoDITKLsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS4PR10MB6304.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 14:47:38 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 14:47:38 +0000
Message-ID: <06c224f3-add7-487a-8f6a-c5e4d6b705bd@siemens.com>
Date: Tue, 28 May 2024 16:47:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/2] linux-cip: Switch x86 targets to new
 cip_merged_defconfig
To: Jan Kiszka <jan.kiszka@siemens.com>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <be7c406d-ee6c-4270-b9d7-52b6f24078c2@siemens.com>
 <fb9a3c40-cf83-478a-aa5c-6c53ea5c8ec4@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <fb9a3c40-cf83-478a-aa5c-6c53ea5c8ec4@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::13) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS4PR10MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 6968cd05-5beb-4dbe-4a8a-08dc7f251ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Q2ZNS1NDS2JvRDJRaE1TY3JtYzh6UCtvM2xFa2xLZC9UVERULzBaalo2NVlG?=
 =?utf-8?B?SjdJOEM1VjFWMlRDQzNUdnFSR244N2hkSk96NHJPSmVublpac3g4VnN3THc2?=
 =?utf-8?B?MUZFTzFkMXlZNndKS0srUUtLY1pnOFJ6Q3ZJNXQxRHNyejVJZ0M2ZGtwNWJx?=
 =?utf-8?B?TWNXdnJ1ZnY2N2tLY3A4dlFmK213VkdDUjNkdVIveEpoZG1iRm9pazZFdmNX?=
 =?utf-8?B?RXFPMURLMjZYMkFBcWpleGFVQ09HRlpFdmlLY3VnV2kyNExZemxXby9UanIr?=
 =?utf-8?B?WEwySUVVYUc3OE9lbUp5REgyV09KWitHNmpHTXFCbEpvSDdVM05FL3Z4MnZw?=
 =?utf-8?B?aFhac002U2M5S0R3OU1sWFo4VU9VNERLV3lpVFdtTjZVTDh1cjdveDFIZWh0?=
 =?utf-8?B?QmNraDBpdnVvbDF4elRhLzVwQzE1ZHliZDRMdGJQUzBaUDNiL2F2Sml6K2JS?=
 =?utf-8?B?RzFkOXE0aDA5TXFuZ2dBOTNwQVNWSWI0VWN6c3NWVTR4c00rWWx3UVZTTmZC?=
 =?utf-8?B?NWFUbFR3Si81MkVDMGNhcWhEclgzVjlDNEpVUlErcml4WFB1eGN5RGpYK2pv?=
 =?utf-8?B?Y3RTV0JMT2Y3a2dCQWc5c25naEtWbStWcXhiOXd0cWtjVzYyRzk2b21uVnNJ?=
 =?utf-8?B?UFo4THNWNFUzanZDMTdCNmVxbnlUQW1HR3VHRHVZaXFLcGw0MTBEd3NpNFNW?=
 =?utf-8?B?NG4zeE93cHk5b29vL2hNQi92L1ZwbzhVaWxOeXlmeHFaaE92ZnNmZENLajkr?=
 =?utf-8?B?eGVleTJ3aXhHQVdFM0RHc2pBaUZVaTIzemZwaC9jUGxwc3J2T0VJUVE2Y0Fo?=
 =?utf-8?B?aUwzbjlZOEsxNmtZbysrb2lrK28xSGNpT3J6b3JjeE1qVHJ5dE1aNkZ1Q3k2?=
 =?utf-8?B?S0Z4VVlRWkloOE83SmZtM2t3ZkpIdWdobks0UERSRldvU1VyRzg5RWtrVmFo?=
 =?utf-8?B?M1VFVmE2K3kxWjJPVU9EeS9KZG1KMFlDSlRtSmwzSUYyRzJKV3k1WnY1c1d0?=
 =?utf-8?B?WjFkdWNadXRBL1hJdGN3YXMxZW5MdDlkd1JVeVU2Y25ZZHJoYU4zR3UvZ3VK?=
 =?utf-8?B?ZXpiK3ZYR1lDSThJeG8yYWNGOURSQm02MFczdVk0VkZwZjlmdnhZQ1V2NUY0?=
 =?utf-8?B?V2dibXVyVFFHNUxEU2llY3FZM1lxVDg5KzV4TDZWVFBLeTBFRHE0TlBmMTJV?=
 =?utf-8?B?Q3VTQU1IQmJxc3NFazVENDl1aC8yQkpoRlN5UGV4cjJIV0l1ei9INHFuWm9M?=
 =?utf-8?B?Mm5pUDREcE40TVVUY0hvT0dOZDMwMHoxUTAwR0poMHJ0eFc1c0Z5MlpSZXJP?=
 =?utf-8?B?QUdBSEhzVHdXK251S2J1enptUUdGWlIzRXV1NDc1aFFPYStteHhreFdpdFZv?=
 =?utf-8?B?ZlRpeHd3d0VyMk4zS25mUDdJcjZtK1VtMzVTWjB0bFQ4d2tTRHNCTlB4L2ph?=
 =?utf-8?B?RjIxT0VmaDhaWSt4aFJmQ0ZnZ2tmNDlLNExHeDFjODF1bllQOXpFU044eUZ3?=
 =?utf-8?B?UVJKRnNSSWhycHBFZ2dDWmd6TWxXdCtrT2JYNmhJZHZQQ1QvZWsranV1M2tZ?=
 =?utf-8?B?ak1EZzkxRGVHbXh3MDFuN0JGNXVOS1FhUE9meEIrUjdBVUlQajh6RmlJTWFn?=
 =?utf-8?Q?5UZ7pCfGNauAHOJQz38dVqNUd6LiSSUuSxQglan8Mfoo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V2Q2c1c0azN6Q2toZm1KTDRzUE9TSGVhRG9kTURuVnU4THlxMDJscWhuU00w?=
 =?utf-8?B?OEdjeVQyWjFqWGlKcTgyNDcxd3Jramw5WFFLUCt0aTFydWQwdWtqeCtHR3NP?=
 =?utf-8?B?WlRXbTg5UHk4c2hzV2JzQll2cjl0bU5JNHh1ZE5rcFExcHJvZkdiYXBmMm1X?=
 =?utf-8?B?Z1BxUk5VMEFLMytYLzVWNDFYbmw4SmZENno1MG9xL1hyaGVqT1JFL2pFVDBi?=
 =?utf-8?B?VXR3ZTVYdTJMNmg1V0RtN0RLYW9CWUh6YS96NmI0L3habzV6bDRMc1MwejRB?=
 =?utf-8?B?N21oSGVCNnJyRG85R1NGMWFqeENqZkZkYWMyMWFaMU5TeTlWN2xRMkpJRkNp?=
 =?utf-8?B?bjVLV0dSZVhRMy9OMUxydkkxcWJpNjRJTm0wc2poR0Q1L2tFWTY5dDMwV1RR?=
 =?utf-8?B?S0x5dGF3bnRDYWtzNkJwQW1RZjdYckpJYjg3YzRsdkwvVVdDb3czb294aVVS?=
 =?utf-8?B?QVRXRDI5SU1oZlV2em45aktFTm1lOUxZcnRyVlBlUm5YbGJka1QrdWtlcDJM?=
 =?utf-8?B?U3JZZVlDcVNYcUI5K2RnUGFwZ3B4TXhwQzIzV0ZveUZYTHpNekpJREhLTWJQ?=
 =?utf-8?B?QjRnaTdjRWFFdFM3VmVscHlHdjZKdEpXaEdoZUI2MHNJZFJMWnR1Q1pNMVV4?=
 =?utf-8?B?RlRjOS9WVW5FN1FERU5ZU0dDdDJHK3NiVnp4alFMUDJXRWlNL1B0RkNHV2sy?=
 =?utf-8?B?MlJiMjkwQmxEOTJWWk1KUS80T0hIdXlBMkpOeHVNOFBvNHFPSVFobjFGeHJM?=
 =?utf-8?B?MHRUVWtBcGRueVAwanlESDNVYzMwVmVuL0RrTDlWZ05YcFNqa2NST0dLalpQ?=
 =?utf-8?B?THprWit2Rk02OXZSQnFqOFN1K0hJWUZvR3VydmFjTy9wdGdIUGcwWjdTcHV3?=
 =?utf-8?B?TlZYbTc3SENKQWVQczFma2NoMmRReDlUc0JFc0ZLMTZRcTlkbEV4SlV6SCtC?=
 =?utf-8?B?RkRVV2JVWTdHRUJhUGxLakowMVY3eUhrUUprRmptNnJOSThScUQ0TFk2dEtF?=
 =?utf-8?B?ajFIS3hVdVNUS3R5WDQvRU5TZWE4U1NEZGRLZVZ0Yk10NWpZKzMya0p1cnBC?=
 =?utf-8?B?dWRLVXJqakRNbW5ZNElqL2JINUhGeUNkYnhDR3lBaHU0bGJGajhPSFZ5ZERw?=
 =?utf-8?B?TUJIOTFUcWtIRmthUUltZ2tMamgwQTlqcUF0ekpaWjdrNGV0RHRWNmszUHZD?=
 =?utf-8?B?SjBBSEI4MjdBek5LU3JTV3IxWGN4cUhRaDlpMFpnNDlwLzltZUZ2NDZnRXZo?=
 =?utf-8?B?bGNnMU5wQ1E1alQrbkVueTI3NVl4MEM3QS9tcjZKN2h3OEZRbGFKZ2xIQUNY?=
 =?utf-8?B?ZWx5MXdpaHhjWHNTSHFxUnRpNFV1WUp3Y0phRDVmNjZuSEkwOTE1a29mWTNh?=
 =?utf-8?B?UGR4bHgrMDFnbm4xSkNXUVB1ZUU5NmxWRnhYNk16aDhLbG5heWM2S3Byc21j?=
 =?utf-8?B?SVN1UXg5ZWZrNGpiQjFKQ2toeDRDaTF0eWZOQkl4ZWJDbnc5K0RoS3MxazZp?=
 =?utf-8?B?SlllWlJWd0ZtdHpUaE5aQnRLY3ZOY216eUZId255WlVnN3pSQVZZQkJoYUNL?=
 =?utf-8?B?cWxrQlozakZRTVdMdzJPQTRzZE1oV1pKMTN0NVVHNnkyQXlwS3g5RUg5ZzdX?=
 =?utf-8?B?NklqSVBVdFROY256a1NNY21TOU83YmxySWlpclFJdGNMazZsaG9KTWdjeGpM?=
 =?utf-8?B?ZVJyWmkySGw5ZkRpTHNBWm50UXFRdlU0cE5jV0NjVmc1OUhFL2t5SnBXaVhW?=
 =?utf-8?B?QitGb2Y0NGtiSGVBWUtDTzgxK3lTcVpnTit1SFNhQWFFeHc4T2gycEtrcFlZ?=
 =?utf-8?B?TDBEd3psbHgxamdQdVlJMUhuTlpXcUw4dTV4cFZGNkVoSUR1bWVZNUJ3b0Zi?=
 =?utf-8?B?bCtVcFdJMVJFclpKNERjMm4vQnhrZURQU0lScTB1MTRxTTFIU2Y3QTA4ZC9W?=
 =?utf-8?B?VnJEWnBNY3QzTnJRZ2xoWlA5N09lQUY1VmJDSTVWL21YbDcySTRSc3o4YnE0?=
 =?utf-8?B?VkJOaHAzc05abGYxV3VRN0Q4YitPZTYwNURMLy9QM0c4YjJML01CdkJsWUl2?=
 =?utf-8?B?SnpRSHhBU3lWUzJYME96ZkVMZmx3TWozU0hycWZXeGI5U05JT3FwSnVDWVdw?=
 =?utf-8?B?OVlzOTZtYlk0eU1KWkxuU0NGSnlzRTUvT1JTdWhyYWdIL0xkNWVEbFJBelNC?=
 =?utf-8?B?VEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6968cd05-5beb-4dbe-4a8a-08dc7f251ecb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:47:38.8356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +clsmYTMFCNzLh+/j0nOILugxxTPtZzN1PHqfO6YNTeDY2JMtmcQVAVHYjfV9bsDnIC9hZD75KXdBQ0W0wISUTJFGYfeZZv97KZo1kX/eeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6304
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 May 2024 14:47:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15963



On 5/24/24 10:25 PM, Jan Kiszka wrote:
> On 24.05.24 12:50, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This also prepares for a generic x86 target.
>>
> 
> Found a config regression: qemu-amd64 lost its keyboard input in the
> text console. Not a major problem, but it would be good to understand
> how it happened.

It looks like this was disabled by plathome_obsvx2_defconfig and 
toshiba_atom_baytrail_cip_defconfig. All other config assumed the 
default of enabled for CONFIG_INPUT_KEYBOARD.

I posted a MR with a fix 
https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_requests/99.

Quirin
> 
> Jan
> 
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>   conf/machine/qemu-amd64.conf               | 4 ++--
>>   conf/machine/simatic-ipc227e.conf          | 4 ++--
>>   recipes-kernel/linux/cip-kernel-config.inc | 2 +-
>>   3 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
>> index da7e59cc..d7866468 100644
>> --- a/conf/machine/qemu-amd64.conf
>> +++ b/conf/machine/qemu-amd64.conf
>> @@ -1,7 +1,7 @@
>>   #
>>   # CIP Core, generic profile
>>   #
>> -# Copyright (c) Siemens AG, 2019
>> +# Copyright (c) Siemens AG, 2019-2024
>>   #
>>   # SPDX-License-Identifier: MIT
>>   #
>> @@ -10,4 +10,4 @@ DISTRO_ARCH = "amd64"
>>   
>>   IMAGE_FSTYPES ?= "ext4"
>>   USE_CIP_KERNEL_CONFIG = "1"
>> -KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_qemu_defconfig"
>> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_merged_defconfig"
>> diff --git a/conf/machine/simatic-ipc227e.conf b/conf/machine/simatic-ipc227e.conf
>> index 95e2c9a9..33f82b16 100644
>> --- a/conf/machine/simatic-ipc227e.conf
>> +++ b/conf/machine/simatic-ipc227e.conf
>> @@ -1,7 +1,7 @@
>>   #
>>   # CIP Core, generic profile
>>   #
>> -# Copyright (c) Siemens AG, 2019
>> +# Copyright (c) Siemens AG, 2019-2024
>>   #
>>   # SPDX-License-Identifier: MIT
>>   #
>> @@ -12,4 +12,4 @@ IMAGE_FSTYPES ?= "wic"
>>   WKS_FILE ?= "x86_64-generic.wks"
>>   IMAGER_INSTALL:wic += "${GRUB_BOOTLOADER_INSTALL}"
>>   USE_CIP_KERNEL_CONFIG = "1"
>> -KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/siemens_ipc227e_defconfig"
>> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_merged_defconfig"
>> diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
>> index 40c378bf..6839e1a9 100644
>> --- a/recipes-kernel/linux/cip-kernel-config.inc
>> +++ b/recipes-kernel/linux/cip-kernel-config.inc
>> @@ -14,4 +14,4 @@ SRC_URI:append = " ${@ \
>>       if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
>>       }"
>>   
>> -SRCREV_cip-kernel-config ?= "ee86aca8abbe7a41536bcb53142fbf0f57b1c9b7"
>> +SRCREV_cip-kernel-config ?= "5a81b70b8a158d44991da73cf01f310bcd2bff72"
> 

