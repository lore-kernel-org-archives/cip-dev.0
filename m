Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25689D5C0D6
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 08:37:04 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17840.1765874213768584700
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Dec 2025 00:36:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Gg4Mz7io;
 spf=pass (domain: siemens.com, ip: 52.101.72.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlwDbHnp5uiHfVdUoYKnXbW8vN0sX3UGGj9j9Q8+l3xMGyGG65DDNBojWcV0IZwydH7zU2d2MYfa/tOXZcNztiEHn4FrXNjApvwfC7P3oJ+iWF4mUyfy3vYeh3OPv113r28xPejIoEexTfijGKIfN25bt5P4G9vQRV5ae9yGUxqoM2kRVoTMK97MbHTZ38Lzrx5oj9UC5+gJCi1V9RvVzQfYl7siLDuClUx/9O5A8I5QE4/uKgbZZabAk8wfVn+CK4PrSj5jfkou/TkGPt0nHxFB4ZMDrYVLU1kSMTSCt3CyML8IUvuKa7/8uNxf71Uca3yu4ApT1rfSskyAIujqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muhElsPKPy4tfLnDgcB0tLJ6w+wEQYE93C31a1rUVjg=;
 b=M8GBUTLK3pKBUemijN6eWP2e2HN1W1Se8kl3UilEiKkaHvQ0r+pA6B/tTJLBZPJcufdNg+pz9/c13IGWHBA5B8h090Os6W/2QVhiD5/Z/IgesLvl9KvIuHaV7KG4IX7PZONqqAi2BFuseCeaEH6+BQlLTNZaSGGnj8eLHlduCJKo8mkLEha58pCgopsHQs0NrsjW1CFo4ZJLBhK2/1/PoD8RM/FkCXf/ZLofoj+1o/CEdtp2WN5tlBR7XzMcZ36ARwgLMWHlnkcozLSGbHk1zCyBg7PqHk4vADQBOPoFoxqZn30CJPRDZ6bLWERdoVsW4OpnSaqA17eIc68uS7VsAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muhElsPKPy4tfLnDgcB0tLJ6w+wEQYE93C31a1rUVjg=;
 b=Gg4Mz7ioMtBro+V9KiU52hAgfRhYkqQhnVr4VNKMp4NeTlOdQqIZGzC1beOUilLWPUKE5ilMeIcvhkMzvH+CNARyyRclwjuzY4jmIgaVt8NOimHFWYwrsGn/BIoHN7aY3pCnUrIbiXkT9vfnvGVVFN7J1UrZ6F2l0bFnyMOw0/xFeY89fIlWafrTCnE8iDg7xB2FbUXEwDJ7lvigaLxf0WA3xLckGwZafhYXZV98rkOkj2ZdcFwEfaY5/S/EmTWE0A8yI+mfGwOYY9hsv0aiFUGUz25OXyoaPph7ZLJR/IPX14RWMBz7hglA+MJFI3Hg7W0TA/DlSchZnV4DJjx2UQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7433.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:421::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 08:36:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 08:36:48 +0000
Message-ID: <e556f13e-5cfc-4ca2-8afa-1aab6057ab7d@siemens.com>
Date: Tue, 16 Dec 2025 09:36:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 4/4] fix: ensure separate root
 home dir is recreated after factory-reset
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20251216082559.327416-1-Quirin.Gylstorff@siemens.com>
 <20251216082559.327416-5-Quirin.Gylstorff@siemens.com>
 <d4aace53-d48e-4ee6-84ac-7083ccb580d2@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <d4aace53-d48e-4ee6-84ac-7083ccb580d2@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0330.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: e2198810-7da4-4403-b5bd-08de3c7e407e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bWNCSjdVSUhLRnVYaVdodlR4Sk9jMUNiVFgzWmgvaFpBU25haTg1QzRiRzdB?=
 =?utf-8?B?aEpVbFIyOTA4MUFQSXFVRGVMb01DTGs5cHZhMi9xRkU2bGo5c0dGRnV4Z0cx?=
 =?utf-8?B?ZHZaZTIvSnJwa1RmN29jeFFVUVJaRndmTXc2RFI1ZVhrSFY0YWY1dlozbnUr?=
 =?utf-8?B?Zi82U2tIYzU3NDBxSHloSzBxOWtYdjBBNU0xcW1UY09qV3VvSkhHWWRWcSt5?=
 =?utf-8?B?MURZSHk2VWxLK2k5YkRiQmxIRXJxZTZPTU95dFlGMlkycVlWVkVHREwrZ3o0?=
 =?utf-8?B?SjFES05FUzA0T2Z5R3Q0K2tSUGpwUXp0cUxCMnF6akZ3VDVDSnJzK1RBLzU5?=
 =?utf-8?B?YlMyMGIvdkMyZjNxU1dLQkQzNzJkUjNPbXQvd3JHcDlGQnY5MEZtODNUSEov?=
 =?utf-8?B?NStUMW9OY2RYVEM2ZHBoYXNxMkpjcHFOa1pHZ2dkZEpZMkR0YlBaOHlVb2R3?=
 =?utf-8?B?WTdMYjJJM1lPRWsya003UEp4bWtTemsyVnBBNmIySjZ5ckJKTDRtRllqUjEx?=
 =?utf-8?B?eDI3YW15VWVNSzgzaVVlcGd2MUtRSzVvdXFNUEFkZjM3Y29GaFRkQmNQSVhY?=
 =?utf-8?B?a29CTVp4VlBOZW0wVFBQUEhGZFd0N09wT2xWbmF2Nm5DMDc3SU1xMWZBZkpF?=
 =?utf-8?B?UlB6elNoRXFEYW41N3BwcG9ZT3VsOWxJNmF2V0VRVWZIR0JrUkdCUXdLQkxU?=
 =?utf-8?B?SkJMWGNMazkxc0tIYzBoL0VtTEpCQlNIakEzSGVnaDFpUTRYQlU0L1duS01P?=
 =?utf-8?B?OW9FVW9jWHRjb0FNc1Z3OWw5ZGxIUXNuTThzN0FXaW5FUUhFa3krYmtTVCth?=
 =?utf-8?B?QnlKdFMrSFBJR0RnUkNUT2djQUxvY0FPZVhWcTJiaHlicWRhOEFNWE01Q3JE?=
 =?utf-8?B?MHdDYldQVklXUjBZZ1IrTFVkOXF6Q1pZYTZWOGkvUXFXZlpBUDFvOTliWHBY?=
 =?utf-8?B?eXRkRC93SzNubGVyRmdBa293ZkpYRExVeHY0L0tlVW1WdldHMTBpZG1XS3ZV?=
 =?utf-8?B?VDJNMGJUTVhDREVlTVAvTTJMY29ZRnNpMU9tTEt2emV5UnNTWXMvTDZDeVMr?=
 =?utf-8?B?TGZsTXhRZVArVEZzOTRYOWo5M3dZRndEU3k0aGhDODhiaFhjQUVzelU1UWNM?=
 =?utf-8?B?R002dFF1VTIrUnBtZ1dmREpYSW4vQlVEVnFnMmw0WE9hcDlCYzJpZG9qRndR?=
 =?utf-8?B?bCt6T2VUbFdUL05YV0dXNjVDWUp4bHFIWG9mWEI3R0xlV2s4N28zeWdXWE4r?=
 =?utf-8?B?TWFwak9GcWV1UVlRTXNFMzlWVzZxU1QzNWVMNDBkMHIxRUwxVlNGN3RnOVF5?=
 =?utf-8?B?aFRlRURkUzJwVFIwd25VODBhQzlIdnlwK2NsR2E0dmlmR3U1SnJROXpURXUy?=
 =?utf-8?B?aUpiVWxIOWpSK0hWL0xGOFlaenZlTUFwRlZWM21wTFBzSHEwTGx3NjNYdENw?=
 =?utf-8?B?bmFLR0lDVTE4bzRzSk50cDVoMHh3NEd6WCtwL1Z6dWtqTTFkd0pHdU1YL0lL?=
 =?utf-8?B?djVNcTdITGYyTm90S0hYbnBodW10c0N0dWdvUEJuTHpZcGNNM2dESHFCY2s1?=
 =?utf-8?B?bnJ6OXdXbVFRaGE0QTBaVHMzZ2plOEVOOW9UZnVkdGZkWVYvRE0wL3UwM1RO?=
 =?utf-8?B?ZUhnS09UcWREeFYyaW9uQnlQZFFCRlIwOGJIZHJPa2NGelRHNFRVUERzdHdI?=
 =?utf-8?B?QzJmYitwcW1yeHVJVDBWR0Iya3F0LzJoUjdKSVNHUXhLNVhua0JZbXk1dnFR?=
 =?utf-8?B?UGFLNzZHa0JVZjNIQVNTMENBSXpRMkRjMnI3cFhjRTlMUVdjUFMxOXpNVmpI?=
 =?utf-8?B?Z0x5K2xXNzBFSUlnMVZ6TEJCMFdBYW9qNW5TV09VeDBhMEhwT1IwTCsxK0Y2?=
 =?utf-8?B?L0t1b05udDJUd2lYSmgvUk5nWHZpUHNxdytaekFNSExvL2swaENKZStmM09a?=
 =?utf-8?Q?nW7xObrZCQ9LzDLRGJKoLN+P54KilbyJ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QlNuZ1pZZ21yUnhjbkRUN0lnMkUzZVY2S3VOM0NRRzFlWXZzSmxpekk2ekF6?=
 =?utf-8?B?cDNvRTg1RTE5UnM2WHoyUkMxZU9HSjg2SjFFd0RCUXNEYmJNTHZzVUs5eTVa?=
 =?utf-8?B?cEhWeFhOU2tROXg4TlZVMDB5Y0dyQVNZVGx0YnpnODF4NFhMS0dndlhPRW9L?=
 =?utf-8?B?NWNzSWJwV1FtOFA0Nkl6dXVOdzlrKzJZRW5lb1VkZGFRdVovZUc1aUsrbnFV?=
 =?utf-8?B?U2ZMYnNoOFoybVptVlVUSE1JNlJyOXdhbEZKbm9UVDVvSnI3NzkwbWlGcjBI?=
 =?utf-8?B?eCtmVldubVRTdG1ISlNkR3hpSTJEZEVpeXRxUExxVTlocDhxWDhPczNQYnlH?=
 =?utf-8?B?MW11Vk1Xa0gwQTJHVStCeWJNNm0yUGtMMHVPNWdoaHVudE5YVWJURGplWjVG?=
 =?utf-8?B?MkRDMk5XZ1RHTU5IYTNZSFlmL0ZpNlBjalJ5NC95OUlIYy9EaUd4cjE3MHZW?=
 =?utf-8?B?SGd0YzJOZDFmLzJObVBXOExDY2dmQUNhakwzbUt2aUtDdytDMmlpdmpGb292?=
 =?utf-8?B?TjBtd2tEZkRZRit3ZTN0d0JSZ0xTTTFUb3RwUm84aTN0S1BHSHAwdVlLcTN2?=
 =?utf-8?B?YXJHUzFSQ2JCd2RiSHVJbHNuY054ZVh2WnpsY2lmc1h0ZmEyQW0vTklLZ3Fw?=
 =?utf-8?B?d01ZQjh6UGtWTWhNUmUxMExWcEZkSG1QQ1E0OXpBeVR3eFp1cnQ0RHd0L1RK?=
 =?utf-8?B?cG5mYVNXN0xvZXR0YUFWRm1sbjlyejR6d3FpMTlmRUF1MmZRZ2k3Snp0NWFl?=
 =?utf-8?B?bVRySkplcHR5LzB6d253S2ZkSk1EazdtZE9VbVNzMmZtVG5ROVJiSjJaMll6?=
 =?utf-8?B?R040Ykd6RG1vYkcraytSNGswNWN6UjJjUnpSMXRIWExhMUc2ejVqQ1cxMzNG?=
 =?utf-8?B?cjNzUTYycnhZbm9SYmFWMStWaVRYR1ZQSlU5Z25GaExKT1lBQmlxOEtBbks3?=
 =?utf-8?B?ZHRsYkdQbXdaZytteGFHY3N3aWQxQUNWSWc0VXBBT3NDRUVWaGYzWkRZQkQz?=
 =?utf-8?B?SGxBVHNEZ2NJSmJPZW9WcWt4S0o3WlFTZFltUjZNdkE5NkRRbFcrV0FnMFJG?=
 =?utf-8?B?SXJJcmFnSldNVjNDZXQyem5jNFZ2ZkZQaitrcVVmSGZVS2tkbmFKZ2w2WlJT?=
 =?utf-8?B?TjVhZDNSVm1FRWo3ZXUwUW1WQUd3a3ptWHpCc2crV3RKY0p1OElveDI1eHZt?=
 =?utf-8?B?dTl4MnphZ3hOeThzdisxUGFhOHR0aDNxMlFOT2tIVjZkR1ZYVFZXSE9QUGRm?=
 =?utf-8?B?S1JUZnRmc295NlJMYVcrY1NFbThhWHpOZkJsbGErRWZMaDIvWlJIdlN4VFNn?=
 =?utf-8?B?ZjBxNk9KOGduVk01WkZvaTJjZFVWdjNFTHdMTWU2TkVOWUdWeE5ScHpXSG1w?=
 =?utf-8?B?REpsTnNiSU5WU0FlL0g4eStTOENzZ3JPZEJwSytmS0dQVTA2SWNTSmJydVFa?=
 =?utf-8?B?cllLcXNNZGhRb1pndEVGcHVEdEpnM2VDQ3lIeURVNzQ2Q3hLWXJNbXdvK0Uy?=
 =?utf-8?B?NGhvWDVGSTlSQ25pRTRnOW4xVEFrVFAwNmlOK2ozUnA0OVF1bC9GTEpaTzJ1?=
 =?utf-8?B?czdVTXRicnhRbkpkc29uS281Q1F6Tjl0dzI3bnBaeC9KYlhYWW5Ud1VMZ0p5?=
 =?utf-8?B?QWtEaHVPcWQxU3ZjWWNHSXdDWmQ2em1qdUVTTVV1ZXh4TmxFV0p3empGbVVU?=
 =?utf-8?B?NyswVHpyS0xMR3QxaHN3d0pxT01ZRXhjVEtGTytjZTlyOFMwWDJOOU5KdXRO?=
 =?utf-8?B?NjcwK2FkWWE2b243c1RUSGxuMjl6dktRanZwM09ER2s5cW1GYmVDQi8vNUlL?=
 =?utf-8?B?bDVEOTkxOVlZSS83SkphWjVvbjZ2dEFGR3ZiamIxU1lDc2YwZlh2RTFhK0Y2?=
 =?utf-8?B?a0NsOHpuZzNlUHRFanhicEZjUVkzNk4wT3lYbmJNK1ZRTFNGV2RwVEplVkxi?=
 =?utf-8?B?ZnBWQ1pkY0ZRLzBZSWZUcExxdkdPV294ejE4QzgzMW1aVUpMZXEvZiszdU94?=
 =?utf-8?B?UjZPVzc0RGJEaXI2aHlvUFhsTGUxZXZNNzI0ODdXU1F3eHJMVm9GV3d1emRG?=
 =?utf-8?B?Vm8xYzN2U0VyMTBZb0w4NDhUQ1RYV2NkUjFqc2NRVjBkS3NNcXZxOHVGYzNK?=
 =?utf-8?B?UVdPV0xLM1J3R1JpT294UVBFZGxxQVpUMC9VTnhCaTZIRG14bHE1aFJUaGt1?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2198810-7da4-4403-b5bd-08de3c7e407e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 08:36:48.3344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fYSkyuvg0aaAhuLTzo1HQf3qpPFtrvnQQSWIxfhCpqzDf0rYXrd+8CPtK6kWAhoorYQzLUbdDpE16j9IPMJyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7433
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Dec 2025 08:37:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21079

On 16.12.25 09:29, Jan Kiszka wrote:
> On 16.12.25 09:25, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> If the option `separate-home-part` is used the home partition is deleted
>> during a factory-reset. To ensure that the root home directory is
>> available recreate the directory via tmpfiles.
>>
>> Additional user directories need to be addressed the same.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  .../change-root-homedir_0.1.bb                | 15 -----------
>>  .../change-root-homedir_0.2.bb                | 27 +++++++++++++++++++
>>  2 files changed, 27 insertions(+), 15 deletions(-)
>>  delete mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.1.bb
>>  create mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.2.bb
>>
>> diff --git a/recipes-core/change-root-homedir/change-root-homedir_0.1.bb b/recipes-core/change-root-homedir/change-root-homedir_0.1.bb
>> deleted file mode 100644
>> index 79c7e67..0000000
>> --- a/recipes-core/change-root-homedir/change-root-homedir_0.1.bb
>> +++ /dev/null
>> @@ -1,15 +0,0 @@
>> -#
>> -# CIP Core, generic profile
>> -#
>> -# Copyright (c) Siemens AG, 2021-2023
>> -#
>> -# Authors:
>> -#  Henning Schild <henning.schild@siemens.com>
>> -#
>> -# SPDX-License-Identifier: MIT
>> -
>> -inherit dpkg-raw
>> -
>> -DESCRIPTION = "Move roots homedir to /home for read-only rootfs"
>> -
>> -SRC_URI = "file://postinst"
>> diff --git a/recipes-core/change-root-homedir/change-root-homedir_0.2.bb b/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
>> new file mode 100644
>> index 0000000..3cd415c
>> --- /dev/null
>> +++ b/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
>> @@ -0,0 +1,27 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2021-2023
> 
> 2025 - updated.
> 
>> +#
>> +# Authors:
>> +#  Henning Schild <henning.schild@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +inherit dpkg-raw
>> +
>> +DESCRIPTION = "Move roots homedir to /home for read-only rootfs"
>> +
>> +SRC_URI = "file://postinst"
>> +
>> +do_prepare_build:append:separate-home-part() {
>> +    if ! grep -q /home/root ${WORKDIR}/${BPN}.tmpfiles; then
>> +        echo "d /home/root 0700 root root -" >> ${WORKDIR}/${BPN}.tmpfiles
>> +    fi
>> +}
>> +
>> +do_prepare_build:append() {
>> +    if [ -f ${WORKDIR}/${BPN}.tmpfiles ]; then
>> +        cp ${WORKDIR}/${BPN}.tmpfiles ${S}/debian/
> 
> I'm folding this line into the block above on merge.
> 

OK, I'm getting the point of these complications: Account for the case 
that the change-root-homedir generates/provides a ${BPN}.tmpfiles 
already. But that this not the case. Let's not overcomplicate things 
without a user, rather do that once there is one:

diff --git a/recipes-core/change-root-homedir/change-root-homedir_0.1.bb b/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
similarity index 59%
rename from recipes-core/change-root-homedir/change-root-homedir_0.1.bb
rename to recipes-core/change-root-homedir/change-root-homedir_0.2.bb
index 79c7e67d..a0725c15 100644
--- a/recipes-core/change-root-homedir/change-root-homedir_0.1.bb
+++ b/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021-2023
+# Copyright (c) Siemens AG, 2021-2025
 #
 # Authors:
 #  Henning Schild <henning.schild@siemens.com>
@@ -13,3 +13,7 @@ inherit dpkg-raw
 DESCRIPTION = "Move roots homedir to /home for read-only rootfs"
 
 SRC_URI = "file://postinst"
+
+do_prepare_build:append:separate-home-part() {
+    echo "d /home/root 0700 root root -" > ${S}/debian/${BPN}.tmpfiles
+}


Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

