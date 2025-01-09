Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433D7E77197
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 14:23:39 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.81])
 by mx.groups.io with SMTP id smtpd.web11.49420.1736432618082744533
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Jan 2025 06:23:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ub9o8Rgv;
 spf=pass (domain: siemens.com, ip: 40.107.21.81, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WAyflED80JrqgGWrcByxql+uoR9trLbMpk6HXe+7Ahx9HRP0FGvDzdMyCOzAHaVRsY/mYKO9iOAfGfzCDZA50klOHA1JG4FyR+FKP6ZwZwkJt6E1WuP0pHvQgAWTO3Qk7keTcqpmsDYfDOeKVvnNDf/d9tLXT5v07jmIDomv8mMSMqXvCUUEEsMYWmgOdD5Nt2NwyWXGh8mwjeXjlyf26qonHyO1+GF1n9HAfmYIhNYqqr+XYlXxAC2wIMwwqym/EZUI6DLfvCtJY8WUgkX6CqoNmo/hf2kolfFJyh5DNtWiBi6UxUhpD9CnEvbBFFxKk19X6fIV7NDjJ/fH/TuZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLFni5fKJIqdKN9OSnCudBi7/PJrVb3Y2Aggxr0LfKY=;
 b=Zlc9Rh95+o4VAzuSqKZdGdDy2i78l2sGXuTkd/TS8wkSM9+eqlPGOOAD/O6EZGNFFAJRSZI8RQY8PBvIUm+w8F4fmvB8ARcvrFCEUpzxitKHvSP5o7HGIwnimKBCMGU5DnAAzBdHfBE2umQRdnE5r3+eOojTkS/WcCW5Wb7toiKP+iiToqWzao8YAzApoG7zP6HIT0uAwo+y+FAP7pY72DE7QYBwj7k6BGkA+EHckglz9ZZ4OQsUW31czlFl3h5QEOe+ihScJSaiFyd7t7wQRoRCtPNwXamx1yMcBoPKcJERVNBE+rX3ZtM8N+b7AVxZbbnxviDdDblKL4IGyBB2Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLFni5fKJIqdKN9OSnCudBi7/PJrVb3Y2Aggxr0LfKY=;
 b=ub9o8RgvxvjqKR3Tg71nrk0KgBgUNo/W2U63yvIg5KHBD9nWpS5a8FTKjbaeyqR7iHpE+FGxCt6QEhMxVleCnscc7cA4jFQOXEMycblQUv2O3SphLbsmnTPzZThclRT4MXHqSXqJV/m8dxrZDhHeQlb38ps5b5vmUyqkWPMO0aO9xyXiq6iqEV2kjBZj6m+1zZ3gp5tPXvGADM1rEnKXdzYcxE+r9ogbXEYpG2B4GeM0TPiDRHI4c6N9okXuID784b4/tLpnMLy0nogI9M7O9vW1IbH7yhnKMIlRsklGIa4s0gGccfUb/BgdDu3XMEJeHOexK3L+sGLZBKqEy8r2rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS5PR10MB8124.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:677::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 14:23:34 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%6]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 14:23:34 +0000
Message-ID: <2000d33a-422d-4f06-987e-b0513656f110@siemens.com>
Date: Thu, 9 Jan 2025 15:23:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC] continue boot if not enough disk
 space for encryption is available.
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20241220103918.1165341-1-Quirin.Gylstorff@siemens.com>
 <5e4cc176-e945-4cb9-a3b1-bf2e4320a4db@siemens.com>
 <1e879d48-ed2b-4138-bb12-7a07c0379ca5@siemens.com>
 <40d957e9-4fec-4f1a-9027-1089b6f14ca3@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <40d957e9-4fec-4f1a-9027-1089b6f14ca3@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::11) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS5PR10MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: c65e6e8b-af3b-4081-39f9-08dd30b9335d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aE43SHFLU05SczMvUmcxUDdCNE1sMm90NlZaY2EzejdnNjJONnN0MStuSjJD?=
 =?utf-8?B?U1E5RVRCV0dJMjFsaG9KTVJHUEtNamVpakh5c0VUL2hkWmpaN2xZWWtUTC80?=
 =?utf-8?B?a1RTTjJmWnFZQWFGRkx3dlhaQmtFd1lYSkpKdUNBeDk3K0ZUdmE4T1dVUzYv?=
 =?utf-8?B?Uyt6Sno2Y2J0aTZsSGVXNEtFR0hPbVcxSlRtY1VEbUovYkxIZUswTXlaNHRK?=
 =?utf-8?B?c2NILy9hVi9nQXVZeU5GMk4vc2MxMm81d0FFR2NvRWFFanhFSWVhYjBReklh?=
 =?utf-8?B?MWlhWVAzUGgwSDRSZ0hVWDhNYXUrUkIyVjdLcTMyRHcvdUYwQTJRTWs1TXhL?=
 =?utf-8?B?bmdxTGh5V1ZpODVFQ1JlSVhFc0dzcnJMZStQQ1Q0dWdTejBoNDMvT2FyMEl4?=
 =?utf-8?B?bnE1ZWFjWkl6Q1pHMnlnMm1ZdkswQ2doVFB5YlpReUpGVk9ZT0hlMFlSTExo?=
 =?utf-8?B?ck1TZGZGaWdhSlVaenRwMnJOMVFTa2pEdXVRb1RhYy82ZzYrRGdKbVB4MmZa?=
 =?utf-8?B?bUtJc0M4cEdZU3NyVFAzVk1MTE5pakJyaUxucmNDREE2U0lyUG1BQ0doTSsy?=
 =?utf-8?B?eE1KOUp2WXZZWE9kWHZhbGRXVXZJL3NYVkNSTXlhc0poT0pnUEhTK3FDb0Z0?=
 =?utf-8?B?VXFMT2xzdFlxeUNCRnNHaGIwWEdTZHZzNWc3MTQramFYQTVwWnAwLzJXTFl2?=
 =?utf-8?B?YXVkTWNaUy8ybGpUczJKeStZcTE1WDhlcm4zemx4Z1lCRDB3WnpEN1dSVGRz?=
 =?utf-8?B?WEhlSFRwQ1Z0UnFHVXovSlpJcmNuUFZiQk1Bek5iVXBHREVESmtONFhxRVJ4?=
 =?utf-8?B?b1NKcUY3MlNWQmVITDV1OWFCR1psZjRpdWxvOWZ4aW12YzlwYld4azFIYUpJ?=
 =?utf-8?B?VUgzV2RWWE9qZlZpaU81WDBSU0xXcW5pdDFwZG1ScWdFRmo0eXcwVHY0Yk03?=
 =?utf-8?B?TVhUWmMvL25XQkt4czhzT0RLNDVrTDVXUWlyY0h2UDhhWlBGb2VVNXhSN1lW?=
 =?utf-8?B?TGpDMXlEMXFoeHMxdEJoOFNQWGRYTGxNejlMc0s1MTZEUTFaK2crc0pOeklI?=
 =?utf-8?B?eDBHNWUxMS9pb3JPY1RGTUZVMXYwUVJlL2kxbUhPa1IxSlJ5RDk3Uk1uUjFp?=
 =?utf-8?B?N290TkxyMklSTGtOOGJDdEJCS0pnZG9oaEF4aDBSL0M1WlZvQURXWVhKSzlU?=
 =?utf-8?B?VThnanM3S29RUWhtQSt2UGc1akJzM1F1eDV0MjQyZ09KN2JobS9RTEI4RE9z?=
 =?utf-8?B?dXp1YVM3SUFaeTZIRmtESEovMjR3UUltM0ZaNzAvWXIrVmNzamJKTEN2aXFV?=
 =?utf-8?B?SlBKTWxSQ3hjZGR1aWZEVmZ3YlcwS2dOaXJFdnNoTzdmalhKTVhtWHdiZzdE?=
 =?utf-8?B?YmZha0xwRDhnOU1NNmxOWDQrWW02d3poakcvQXcwUC9mb0s4STd1S0lRVXFW?=
 =?utf-8?B?WFZuYXp2MzR6RVdOUlQ5NVZIMk1qMUE3S0pvRUFoYjVTbjFkc25KMk9YMkFX?=
 =?utf-8?B?SkFVY1NieEpaaHRidk5veEJwQTZLWlpmRVhzTm0xK1JXUXppWlJsZ3hTK09U?=
 =?utf-8?B?bjU0eFQ2TGV6SFpvZmdTUU5GQ2o2dHZiVVhwd2gxYkJTRHpNWTMrYnJJQmNt?=
 =?utf-8?B?bUJPRHI0V0RleVZxMDVFcTFmYW5wMEwzb3A2YnBmOGE2blY2REwrWTlKQnRF?=
 =?utf-8?B?eHp3TG5VSVhEeitrWGtiUXZLKzBZeTdZMU1hQ0FVeE1ESWY5amM1L25mQldq?=
 =?utf-8?B?eTNQZDE3OG5BNG5FKzZ6VGU3YXFoRXhBM09MU2J0VUhHY00yWHkxMzc2WHR5?=
 =?utf-8?B?MGdxWStjczhSbW5LZmFQU0V1d1QydFdMTVVhZGtIdEdONWhTaFN3bGN1a3la?=
 =?utf-8?Q?gmqNqqE2fxRpx?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?LzVja0tDcFdkTm5nK2lPZVgyL1Ryb2Jjckt3WCtjZlNBT3pKTVNOdlhuWldi?=
 =?utf-8?B?cCtnTEVYUFRHOEZ6U3AwM3B4TU1EakJIYnZ5bHJMZk1hUzcyQ09rVUJXdkQv?=
 =?utf-8?B?T0tWcHd6T2NnQXlpQUFWRnIrRDRXbUxuaS9Ib0FOZGhwanVwTlNFN2xHcE10?=
 =?utf-8?B?SXBNZHJYV2J5cHI4WkFvcjJwYTVLZDFkT2lEUUg4Nk81VmxTRmFtdGRaUExG?=
 =?utf-8?B?QXIzdW14OVRtaXZHN2Z4RHdVRnZSbHo0N2NUYTI0TElJaFhHL2g1ZEtXbWpS?=
 =?utf-8?B?alBUZXlLSmdmWVhJT3I4KzVVWkdBYkdhWkNJV0psZDkwTGdkOUl6YWI5N05W?=
 =?utf-8?B?cUNoam1EVFZ3bVFWRGY2U1RQMk95YitXcTFUbHVwZjZaVlFZNWpiQW5HZXZR?=
 =?utf-8?B?Z1NnendaU0I3blhRWHZyMVZpWDVPOFVwbFBoSkhxL00yYlNnODZCNlp5czIz?=
 =?utf-8?B?NG5McGxsWk96a0U1SlhuY1NBN2xVWVlCTFV2WFRySmlpMUhjdXFCVTRxMm1F?=
 =?utf-8?B?WDJTRjJPeldsL2IwYnhxYkw0Vys2RTFidE1Ha2g4cjBqME91OEh1aVZOY2VK?=
 =?utf-8?B?RDhhTWZxMWNRRWdDOTRzNjRJMVRiYXZpMHJsYUhkTitNT3g3N0d4WVJETGZj?=
 =?utf-8?B?NnlOYXhJeFBiaEdpVURrdEs4ZzZCeFRhMzdpbHdpZHM1bHhvZEhCdWR0dDVw?=
 =?utf-8?B?UFZGU0NGWEowdWNnV2VCellQcVU0WjNHajdESmtYSDZvNXhTb0FUY1J6c1BR?=
 =?utf-8?B?dFJZMmY4bTVtNkF2S0JWaVg4SFFTUHFPaXNsci9od2J3aUd2WFNJL2xsUHg0?=
 =?utf-8?B?ZkFHcFZvbGhDTUN5cDE2eklEamV6MzVDaGRZTTNlbXZuc1p4SWQwams2M0pW?=
 =?utf-8?B?NklOL0J1cWpMZE9ORTNVdVMyYVdxS3VnaUZyMWNUVThQWkVCSitoMXNIU0lt?=
 =?utf-8?B?NGhCS2k0N2c1ME9CYXYzUXVsRG56bHFLSWJkaUtuSk9Ud3ZiS2czS3lCc0N4?=
 =?utf-8?B?V0VpeFUxNzhQaW45ekwzakRPZTB4YVorUTQyWFVKMGNrQUlQMUdQbjYvUk53?=
 =?utf-8?B?bHJCczhPREJmYUJQTktZbjc0SzBycVBlQWNqeTY4Q0VzVE1UL1pmamxoRHpF?=
 =?utf-8?B?V2hhbFdYZml2QTloSW50SHZ6SUdGeVhGNUcrN09LUjVRajVoWEtYZlZPMTVs?=
 =?utf-8?B?M3p6bFdQR0RmNzBxWWdLRmM4V1l0UjlYMjJIWmJyci9YZEJKVjI2Q1hhN3Z5?=
 =?utf-8?B?L1MzRm85bndqZThrNHlQNGorS25TZ2lrZFNITmdtVVQ0QTF0cXN3c2N5RWxC?=
 =?utf-8?B?MGtMamM1cnNHVGptOEI2aWVxbDBSaW1yS2l1K0JjdWNWWFNYMjlxMDlpSEl3?=
 =?utf-8?B?NHZKNHhuS0FscmwrMXJUMDBIZWFiSFpGMkJaWGdBT29xWTBZcksvaUJGRUJX?=
 =?utf-8?B?UlBpTlFMdjdFOGZyN25GSUdrRDNPbDhrYTNoem14RmdyZmRFUXN2WTByQ29w?=
 =?utf-8?B?Nk5nUGlnTGNLZnppVW1LTWs0VHFiS01pQmZqamtrMUlBNE5YWWxnbWJ1L25U?=
 =?utf-8?B?VTdYeGFLS2lFWEpybExYbVBINGFZYUdCeHZlRnFJQzdFYU9lRk16R3doTmc0?=
 =?utf-8?B?SWRJY3czdDJvSWNKanhucVV1UkgwVmRycGgvUGd3Q2w3cFFRVUhZV1cxY0lU?=
 =?utf-8?B?aHBxYm1PZXhJQmF5NDNOUnEvRmgydWR3NFJ0amJCdXVFbWtEc3dJQkVHUm5R?=
 =?utf-8?B?Umg3eHhhclBZM0EyTDZTeUFBTnYzZVE1T0pKb1hqT2dhTm1JYlczcEwrVG1w?=
 =?utf-8?B?S0VpWWhlZTh2amkzRVpWQ1lwUnYxS2tNZTQzaFNEc2xTd0VtOHE2SEF2MmlM?=
 =?utf-8?B?TVhQQUlvalh1NTdxMFpVYzVPSmRXS25Ic1VrdHN2OHNWNXJoZmFMTDRZWnlS?=
 =?utf-8?B?dEZJWDMrNmcrMlFjdWR3K2NNeXk4Y2dDUTVGQTNYd2krcW94TWNpRSt1cDJa?=
 =?utf-8?B?MFRBVFJ0ZFY1bTdYZW1vendxN1BvNys2WVRBcFN3L2V0NEhiUlVhKzdaNjAr?=
 =?utf-8?B?RklpdkF1MXR5UEpCSDNIaHVjanZCOG9NdmtBcGhLU1AzS1RtcUh4KzZYazV1?=
 =?utf-8?B?a3h0dHNSMDUvT3FETEVQbjNtMUtqUzNJc3pGWTd0KzBCdEpsZFd1V2J2b2xm?=
 =?utf-8?B?RVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c65e6e8b-af3b-4081-39f9-08dd30b9335d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 14:23:34.8013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y32zPCTrLq58oC7fmOXIeQkz7NaSWhSqpQ81SSrklgUGKpoopwR6rOtco8h/TLz9l0DzQU5TndE//j5Bm+IDYJu7k0b4m1LvEhzTc0X1rgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8124
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Jan 2025 14:23:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17514



On 1/7/25 13:52, Jan Kiszka wrote:
> On 07.01.25 11:08, Quirin Gylstorff wrote:
>>
>>
>> On 12/20/24 12:03, Jan Kiszka wrote:
>>> On 20.12.24 11:38, Quirin Gylstorff wrote:
>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>
>>>> Encrypting a existing system with a full partition will lead to a panic
>>>> during resizing. To ensure the availability of the system continue
>>>> booting
>>>> if the flag `CRYPT_ENCRYPTION_OPTIONAL` is set to true.
>>>>
>>>
>>> Is that not overloading the semantic of CRYPT_ENCRYPTION_OPTIONAL? IIRC,
>>> it was introduced to handle devices that lack a TPM.
>>>
>>> What exactly is the scenario we want to handle now? Misconfigurations
>>> during image build should not be papered over via
>>> CRYPT_ENCRYPTION_OPTIONAL.
>>
>> The scenario is that we introduce disk encryption via an update for a
>> device in the field and the device has enough customer data on one of
>> the partition that the disk encryption fails.
> 
> That insecure scenario that we don't want to promote via upstream?

Ok, then lets drop that patch and work on the displayed error message so 
that the issue is clear for error reporting.

I will send a v2 with only an error message.

Quirin
> 
> Jan
> 


