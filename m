Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEAAC25B7C
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 11:06:42 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.60])
 by mx.groups.io with SMTP id smtpd.web10.25105.1716807998091757869
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 May 2024 04:06:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qZasy3J9;
 spf=pass (domain: siemens.com, ip: 40.107.247.60, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlQGht+eC1FB3SH+tf+I8rrxliInZJ+0RgguyiQYy8xt3PWcLyP3pd7E1y83czBbw5CSSfw+86LBGPxPw402XbhMPIq83upjUfX/fmNiKYwvldwsFrCkCDI9G3qZDjHCJuYhogIMNxOsx1TyDiZrx8jOjDf3IdKUQa0uW/LUYhlh5/Fjy6WrGPisj9sh8gxLQWlAs4DGEEvwi+0WTIr7QdHDSoQ0cmN/TaAup+kXYci1f76YMX121pOFoVjyDzMaUJ4+QGuikVyTytSkkG32dE0A1qialNxbsuIjYqQesnk1w9fp9KWOxoszsE0pVuzUeis1akP7cjS1WCso7JxR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h57+RCgEbxeFulXDLLCQKdHu7nwwO4YK4KajLLZcZ0A=;
 b=c0TsPC+Lwhzv0O2vp3ZQconj5nrnzPdDtfx3+Lg1M+6rJkRQ6oDoJncMIjjIUKO56TfoeSbdDIeefFhznutu3xVKTZoXrqXNiRb9rVXxOF48M2YuSCJiTToxojL3z7NSpurByYa40OnwIEg5H9VqkVNc4P4FG1WajyC9QIOPhX9/SeiHHVeZ0ggQyg3kmz6iXh6ZQUZ1uxLl2B+GW8a6+3bKxclSB3JaZDvvXzOEzxmakK2chMs3CVCUMOQxB7r+AiUdp5Q9vwahaPyK0Q86WHgjVbxbiZlhWh+YTbbrc1HJXFFnHamGI6Si4rIDj0Dfp35oxmVBgACq18ft0OTcbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h57+RCgEbxeFulXDLLCQKdHu7nwwO4YK4KajLLZcZ0A=;
 b=qZasy3J9P71dW4hSnNW10CWPHGnA0LWwce1wcn3uJM9d47v9aAxdTF/+cbgSKMjfh/DmGFvPN+fy+BRLGAkMMosE9+cktryKmElEMvxMoOqi5F+0G/KMN/mDi5q81L2o5feezOs222FkGFSUtGshg4IpwxVbBhgc3imMpKxx77LLgajN6g/fGninUVb26YqBVXCo0qDAWYaFhwa8IYEVaukFbapZ1bDxXV5QzFHdi6x11nIef5lVjRzuFPOIegpDXVTdoafAFeo5Kb2uWo62AAxuOvcmlAQwsa6r2pi9kPpSs4caOAz1PjevZaCfgd8vOGUnZg02uXZx/5g8nkgOmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by GV1PR10MB9059.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Mon, 27 May
 2024 11:06:34 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 11:06:34 +0000
Message-ID: <9c12851c-d29d-46d7-8769-ade8aac4debd@siemens.com>
Date: Mon, 27 May 2024 13:06:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] encrypt_partition.clevis:
 select tpm2_device for encryptition
To: Jan Kiszka <jan.kiszka@siemens.com>, gokhan.cetin@siemens.com,
 cip-dev@lists.cip-project.org
References: <20240527052948.2471630-1-Quirin.Gylstorff@siemens.com>
 <990c3a80-79b4-4be8-865d-c1162a5988a4@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <990c3a80-79b4-4be8-865d-c1162a5988a4@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::10) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|GV1PR10MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c6e5f50-4cca-42ce-5780-08dc7e3d11f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RGw2L3pTQlFYc2dmN05Dd3RsOTAzTDEzcUE5ZXlRQktTSklCSTNsQVhYTWtW?=
 =?utf-8?B?d0VibVJkYWp5YXdyU241Z05FY3dETkFFRlZoVTV4YjI5VW9BMVZjZXJVYTg2?=
 =?utf-8?B?Umwzc0swOVVTTVBSZ1BaSUJzam92RXJ4YUVlRWNkcWMxSm1HL1R5L1lRalJR?=
 =?utf-8?B?amNiM3A5UW42UHg2bms5UDl3MjZQOEp5YkNMcGZwTUluYVJvM2k1ZStJUzNM?=
 =?utf-8?B?R2lWMDMyaEZyMHRZQVQrUElVVmtDQUpUNHhsUUNrMXRQL2w0RFRvdjlFZHFa?=
 =?utf-8?B?bk8vV0oyQ3l1ZGxaRTJaTEJzbWZqM0g4b0JHdzh5TnorOUNqbi9CK0JiQ0VM?=
 =?utf-8?B?UzhBZCt5TURzclloQ05FVVdXc0h0aTdFTTlPSXpOYTAvSmRFOExxM2wyUzUy?=
 =?utf-8?B?dFhVbWM3em90ckpwWG9yaXZucC81Y0t1RmdBRFFuTU83RXIrOWtLaE5JcEVi?=
 =?utf-8?B?Nm9SMGlIL2FQSll2OFFPdXdtVE5GYzBaVURYUHpPOC84a2JBZ1I2WnVtYXZh?=
 =?utf-8?B?UXJkckgvYXN3ek5NYTN4aU5oRUZ2NVVaTEZNSHZhOXY2YkdyOU44NDYyNlpR?=
 =?utf-8?B?QlU4NnNVSmRrKzFRVVVJQ2loZEhXOTZJbVRublVjTlRZUC8rZkhJcnA4MlNo?=
 =?utf-8?B?cmJCaURxZVZiTXhRbndvcUNTeUFEd3hWdUtTU2pZckUxRlB5OG5TTzJsc3Br?=
 =?utf-8?B?VjErUnphdlNEM3o0UnpIaEtCODlJV05YTWl4dmpNcFd1MDc2ZFByc0tnc1RN?=
 =?utf-8?B?YUs1V291QzViUm5CWjhXMjM5MnZvbUl3ZXVmZ29nTkZVOVBROVE3eGVFWGJn?=
 =?utf-8?B?TVlMcFYvR2tGZTVoYUVyWGhsM3N4UndyOTVjRW5xbW1lVExRSzRrVzhObU9W?=
 =?utf-8?B?Y3B4bEpBVzFCdVRocllCWmR0U2RjZDZtUlFkcjlZZjBMUFVCVHJZWFVBdzVO?=
 =?utf-8?B?RUR1RFNPWnR5MSs2QWIvc0w3TldjRlBLODNYSXFLSk51bTZrTVdwOXJaOU9s?=
 =?utf-8?B?WVdnamZKaEw5Q0srdFpEMkRzeXE2RmdNSkNhdjRIOFEwU3R4QkNyMUEyd3Nm?=
 =?utf-8?B?a013SUQ2Q2NTT2FlVkRydW1ybGVRWG51VFp4S2t5czdVYlRvTU9WSTBNMWRM?=
 =?utf-8?B?cXZNUWo4WjVoVjlCR2I5aDdlYy83M20yMW1oODhJc0MvdE1XSUlGUWR1Zml2?=
 =?utf-8?B?c1hFQVNiZ2srcjkzNHpWaktOZEFoVUYyN3R3am05ay9zRm1ybkVmQUlzeEFV?=
 =?utf-8?B?eWU5M29zbUg4V3BtM0NGdWFmTGpsanBTTU1nL3p3R21NaUsvSENtN08zNmtO?=
 =?utf-8?B?R09peUxjRE9nMWpQcVNGY2kvQlBPK1orQzlXSE1peDB0RzZiTGZBQW96cC9H?=
 =?utf-8?B?NXRRbzkraVVNWENHQVJzYnBneHlwaXJvaHBrR3k2TnRvKzRwenR3Zk0xZHho?=
 =?utf-8?B?SGNHYlphS2MwSmZuRWFzK1YwVjR6ZkxQcURaQ0tjNmMzY2dEOCtXSnRTRDY2?=
 =?utf-8?B?WmFMRFdJbXlVUkZDaGhWbkxxN284eXc5TXBDWjhRUFp0WjYvNi83MUd2aXZy?=
 =?utf-8?B?MFJaSk53Wk5tNG5RZ3FKRHZnYytuT0xEemt6M3M4ZWl0WWtSeWM4QlpuSDlQ?=
 =?utf-8?B?MENJUzF5bWtDYVBoS3FkOC80V1RURUE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NTRCSFpUKzQrdTlDb2lTWFBTUkx6ZHR3RjNxYW1oaTlKNVFXYkZOMGcvSXRs?=
 =?utf-8?B?dWN5cFRhZ0NQWE41TVVLbFpaNWxuYnREOFdsMTFQUjQyWk40VkNKT2xDMWVq?=
 =?utf-8?B?aVNIK0Foei83RXVJVFBaZnFFRkZEbjljOCtES012ZDBMcnhyVFhiakFvTFRp?=
 =?utf-8?B?UEtxRTdIWDVEelNPc1FLcndqdHNFem4vK2F5WENHWnJOOVczc1NDNmwrK2sy?=
 =?utf-8?B?VEM1UHhtanlJZjFtVHhSaiszVS9zL1JZa2wvMmlmM2IrNk9maUM1aWxSRmZE?=
 =?utf-8?B?TWRaOW8yOHpvMjlqSGJ4aTVvUGZZS0ZaNHg3a1R3NHZCZTBWYWJTTWNiM2dZ?=
 =?utf-8?B?YmFQc1FzNHpVREpBQWZITmtBanc2a0ZKTGlaVEZENndBUHEycmxkbTBKTUd6?=
 =?utf-8?B?OWo1NWtDRFJXRnNBQ0gyeVk5bWFGRUwva2ZONXI1VHhBbVY1d25LdHFsaGp0?=
 =?utf-8?B?bFp3bWFNRDh1eWd0TDg0b3NBRks0SWNNYThhdytwbmpUZ3pXclRVVjhVdFhV?=
 =?utf-8?B?Tm1RaEh5OEh5ZXMvMC81UThOenFUaTR0RUd0OU1PcnRZUk4weFdsSFBxa0ta?=
 =?utf-8?B?Tk5BNVJSWnVVeGV1bVZEUjU5YllEVEVyb08wbEpqb0RVV2Q2R3Y4cXk4NnpP?=
 =?utf-8?B?YXJTS052ZzZmY1dMYkZLbFEreGpxeHRQUnNOV1B4WFJTOGlDWDFCanBWbEFE?=
 =?utf-8?B?VytJdDRuWXFrRXBKZzdUYkN5VVhqWFdrNXFZUjd4Rjg4RlB6NHhkZGFsVWxG?=
 =?utf-8?B?ekJSdzNnNllZbDNKSHllbCtXRzdWUFJjeFdjVGh5NDZEZlBsL1ptM1BNZGFn?=
 =?utf-8?B?RWhDclU2R0JQNWVCeFhVNHpyQkJVZmpIMzcvZGM2amxCMmhLdDJXZG5tZDVR?=
 =?utf-8?B?N1cxR0VQMURkekZuV3lJMUtCUytmSkFVQ1VFb0w4bDFCSGo3cEhkNmM3K1Bz?=
 =?utf-8?B?cU1xNHdYN3plS2NjbGM1THRhN3NmRUc1ZzZIY2xaVUFQZTlIT0kyTVhjRWhr?=
 =?utf-8?B?eWV0V29QUkhVRFFFMitYVTFyWTJuVnNHWFYyMXVFTjZNVjBwUG1NOUVhUzFQ?=
 =?utf-8?B?TnBiRVJiNzYwa25ZUmZTdmRwVWNVc0RGd3VhYUVnSnlFZGs5cHNHc05ua0JX?=
 =?utf-8?B?OFhZZ3FZL3hrRWRLOWduYW1kYXJOUkJkWTBqalFxdW9LSkhBblp0UW12ak9v?=
 =?utf-8?B?b0JibmJXVXdHOStkQ3hncEZCZ3dpKysxYzVsWk1sNi80bm1DODdJaGdsbEFu?=
 =?utf-8?B?UnZLb0tCY0t1R0JsZ1FMTm5oK1prNjZYaUhnNXRYa2lQQVRhbks2UUVoZENv?=
 =?utf-8?B?ZmlCcUpheVg1VXdIRVhBcTNFRVl0QmV6V1o1bTVlN0x3d0cza3NuSkdFUHlF?=
 =?utf-8?B?NlhkUVhCeHJuTWxqckJybjFhd0VWRmhUL3VmSU91emhTUlJncVhWMHlNUWtx?=
 =?utf-8?B?MDhqbStxcldCZ3BOM0x3Rnlwa20zdHVCV2ZJWkNLMkREYjZkbFV1b2JEQU5W?=
 =?utf-8?B?Rm0vYzR4NGphTFBkMk5kVUhXWG5ZeXVJa2ZLeTh4ZnUyS3hycnNyTWxPOVNt?=
 =?utf-8?B?R3Q3OS9wd2tnWm5RdlZpL3dkV1ZjdmtZREE1bVovbVBnV0JuSG9Zb3h3VUJB?=
 =?utf-8?B?NGxKWGQ1ZElNbmhaTW9Ra0xQRVNwSG9SWVJtaGZJank0UkdXZ0t6b0U4dGVs?=
 =?utf-8?B?NUtLR0ZidlFlMlhUcjdLNmI0NmJDaWJIa3hXQTlFd2lManFtN1FHZDJySStw?=
 =?utf-8?B?ZzBIMDdGQ2E1c0Q4SjNWWjZpVFRJU3hlWkQvNEFSVzZGd2JtZzVRVDVjeXF2?=
 =?utf-8?B?OHdSYS9zV1JyMVR3b3VLN1p3K2NOSGMzcVBLaDE2enBDUmJlYmIvYkFYOERW?=
 =?utf-8?B?T21xajFKU0hEOHRiTnRlQXoxaVZJbkhHQTBYYmNBenNUcGJPNW5Cb0VnSFJL?=
 =?utf-8?B?QWFXUi9aOWw5bFJ5a0wrWXFIT2dCZmNxcnBONmxONDh1QnJxZ2h3MXVhbTBK?=
 =?utf-8?B?b2JyQ0V4aUpyTHpyVDVmQzdZSDNuMUtiNU5CVWtnYVY2Nlo2TVJiTE1tYVhl?=
 =?utf-8?B?LzJIaHMxa0ZRZysvam5ORlFqaGtBbTY0VTJaUiswdXFlZHZ2VlpoQmhzOXB1?=
 =?utf-8?B?Z0ozNUtzcHZRRk5OOHdRalg5SzgzR29tUUdzbVM0SUFFMU1kMWhSaWErS05k?=
 =?utf-8?Q?Fwi2UNe/vYXQIS3+wYONZ9g=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6e5f50-4cca-42ce-5780-08dc7e3d11f4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 11:06:34.0438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZPmqDktKXFhLDh6b12zavlLo3z1Omcfs2IopRhzPkJ62guuK32b80Oj24nbp7MRMMnYEsiFV0SICXzbTpjCOccv5d7YLwb7e9/3l0atHfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9059
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 May 2024 11:06:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15955



On 5/27/24 8:18 AM, Jan Kiszka wrote:
> On 27.05.24 07:29, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This allows use to select a tpm2 device which supports
>> all requirements if the hardware provides multiple device.
>>
> 
> This is fixing a regression of cfef8103, isn't it? If so, call this a
> fix, bonus for linking to introducing commit.

It more of a improvement for clevis with Debian Bookworm and later than 
a fix - clevis in bullseye does not support this feature and this was 
the target for the clevis implementation.


Quirin
> 
> Jan
> 
>> Since clevis v19 the tpm2 device can be selected with the
>> variable TPM2TOOLS_TCTI[1].
>>
>> Setting the variable as no effect in older versions, so
>> no version check.
>>
>> No interface change as systemd-cryptenroll already allows
>> selecting the tpm2 device.
>>
>> [1]: https://github.com/latchset/clevis/commit/c6fc63fc055c18927decc7bcaa07821d5ae37614
>>
>> Reported-by: Gokhan Cetin  <gokhan.cetin@siemens.com>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>
>> Changes v2:
>>   - reword commit message to clarify intent
>>
>>   .../files/encrypt_partition.clevis.script                 | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
>> index ddb3eab..a7a5009 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
>> @@ -13,8 +13,8 @@
>>   open_tpm2_partition() {
>>   	partition_device="$1"
>>   	crypt_mount_name="$2"
>> -	#tpm_device="$3"
>> -	if ! /usr/bin/clevis luks unlock -n "$crypt_mount_name" \
>> +	tpm_device="$3"
>> +	if ! TPM2TOOLS_TCTI=$tpm_device usr/bin/clevis luks unlock -n "$crypt_mount_name" \
>>   		 -d "$partition_device"; then
>>   		panic "Can't decrypt '$partition_device' !"
>>   	fi
>> @@ -23,11 +23,11 @@ open_tpm2_partition() {
>>   enroll_tpm2_token() {
>>   	partition_device="$1"
>>   	passphrase="$2"
>> -	#tpm_device="$3"
>> +	tpm_device="$3"
>>   	tpm_key_algorithm="$4"
>>   	pcr_bank_hash_type="$5"
>>   	if [ -x /usr/bin/clevis ]; then
>> -		clevis luks bind -d "$partition_device" tpm2 '{"key":"'"$tpm_key_algorithm"'", "pcr_bank":"'"$pcr_bank_hash_type"'","pcr_ids":"7"}' < "$passphrase"
>> +		TPM2TOOLS_TCTI=$tpm_device clevis luks bind -d "$partition_device" tpm2 '{"key":"'"$tpm_key_algorithm"'", "pcr_bank":"'"$pcr_bank_hash_type"'","pcr_ids":"7"}' < "$passphrase"
>>   	else
>>   		panic "clevis not available cannot enroll tpm2 key!"
>>   	fi
> 

