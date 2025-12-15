Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F80D5B16F
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 13:41:45 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.5])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48835.1765806096376926914
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 05:41:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=up9uAlcJ;
 spf=pass (domain: siemens.com, ip: 40.107.159.5, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuOEPMlAcf+RCY4DSoiJi6KIWjGCNFmFC+MyGIw+go5+EKSoZtbtV/6PuQXZ523qSHOQTPUofUlk6BgMuG3bm6QUoRrT2/uom2qWxx3QR81T6lSrYJpnI+ZQZOu0BVjiIGaMODX325ZzKIXglT/ePVC5U+PTN3KCjDutydPSRT4JKRv0+5+E1mhnRwFoGN2DVY2Z2dFV0VDwCQ0fOkSi8zzLNGvHWHEww2OQ4VR1ciSbtaDSaNN2+SumwFKfa/VBw8YHcgj88aOKNgt1iwPsX2wPOgFJRnoNJTs5FgJFBvbUS8c5l6Ms0vNTrOO1YK2rjYyJS6YNntVtlcboeAypXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YqU3+Ml+RzKrNFTYbeqTWVxN/ZfoNnPOM8SUjBavz0=;
 b=rkX38K1EyKuwnz0x9lebCKdAKznhSU1LdyTYQtlVCDtNZurXKcscfOeMhXZihfqQVDoUzOyqdvZHVNNu0Z727bbdVyaOOmW0bCbTHCnZ8vQ+0Vr58Nlg/UI2JSI2bLAad8dLX+eUagaAOL4q/u8OZ2Dm8sybiK08aoPHlBxPia7Cxko+mGW3/GUO6EJjxGVkhkl8s9HO2VANM/U7haDYcYFUqXLWmXWu+SMhP6ZOn1DSIOWAXMZOyMBOh1c+9hvZBHXlRVLY9lbRRwEO7Hoy+pup0/OSu8OtDzfdPjLw6fowIfgCLuqNfSbSctF1KGtFq827c/DagKOx9iL/PcDGQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YqU3+Ml+RzKrNFTYbeqTWVxN/ZfoNnPOM8SUjBavz0=;
 b=up9uAlcJz9xulT4kZCq7YWOXAHjNXHe8sp7n5I3FDjVgq8LSdq5GFd0gy4S9PUry/26K0CaqbyPJoXK1rwR2Oz/TOZa3UU2J9C/zLoNklaA1CJjVg7WZdEs7abEJEqqILOX5zN6NTm+BwWLz73U75kYkNxKFqT4XyrTEm/lqrMbuNweHwEUVuFEdoCMswNWwz7sYo+qpqk9UVrLKT39tGBq0tyV5n4I5w8/+Klm9BT20i7zB6De3T5FU3KLZqs0jNi+D3N/IltnaV0a0FgvDFIwaVtKbYpzhGTh+GyO1ooK9y70OEEtoPtoswNhj98bqIRG7vKGV2PL1PZrfvdJclg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:89::19)
 by GVXPR10MB5885.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:68::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 13:41:31 +0000
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314]) by VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 13:41:31 +0000
Message-ID: <72963f77-062e-49ca-8cc5-f3aff38a616a@siemens.com>
Date: Mon, 15 Dec 2025 14:41:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 0/3] Fixes for Factory-reset
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20251215093719.323668-1-Quirin.Gylstorff@siemens.com>
 <31048511-86da-4ac0-98c7-3148bae34143@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <31048511-86da-4ac0-98c7-3148bae34143@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0355.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::8) To VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:89::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2319:EE_|GVXPR10MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: 29d85c01-f3bc-4c80-7798-08de3bdfa809
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?c1hPaW1IeEt5ZjhiQjdEd3c0K0VBTG9IRGI4NHdENDF1amlYS3pXeUF0bVB0?=
 =?utf-8?B?Y0tDTU5VaUErWEp6Mmt6aWV3SSsrTE9aT3EvTXBmb0NFUjZIVVR5dHhzek9h?=
 =?utf-8?B?SnpSK1pJT3U0YU9WS2twVDUybGpxeWduVGY5M0VNeUpVZnRpZXB5eGJNTE4r?=
 =?utf-8?B?cHRQdTI0TjZXeStrQTJ6ZzE1SklKWHZEVmdDYmNSMTJ6alpONm1abkRiVXVy?=
 =?utf-8?B?N0xmVlVTRERKWVN6bGt5andic0w0a05IN1pGOVZoZjhSN3NrVFlBQ2pxLzgy?=
 =?utf-8?B?UkIwZ0ZJSkptKzY5aUVYMzBXNURsSWJlZFE3UTJzSzdZRnlqU0JpL1l4OE5p?=
 =?utf-8?B?RkdWVFJGd3AyTTFBZ3ozNVc4UHBlNUtTWUJwK3Z4ekdVQjA1KzJ3Q1I4WUR6?=
 =?utf-8?B?Wmk3U0kvbUtwNldudW5rSWVpa3hBZG5HeW54U1RZT0gvMyt5OGpaT3ZMNjFr?=
 =?utf-8?B?TCtyOU1RbWhDd1hCOGovU3dXaWJDR3lUdHZRK0N5ekhPU05zZU1nK0pMLzVI?=
 =?utf-8?B?cjVYdUw1c0l3YzRrZlFZVHljWUFQZC92eDJtSUI3V0ZtY0RyVWx3UzRNNGM1?=
 =?utf-8?B?M3JPQS94QVVFejhkOXFramZ2VVhGdG9lUHhmWDJOSnIzRytKMEJBdHpHK3hN?=
 =?utf-8?B?TE1DV0h4U0pXV3kwWEJ1Ym1kTzZ4WGZSQ1F6Z3JsRTZGa1hCTEFXR3hYamIw?=
 =?utf-8?B?YmhJRXdBQVF2ZytobjNCeGUrSGdQazIvT1N0enZBZUVNR3N1bnMrSVB3TGdP?=
 =?utf-8?B?RGhLWWZPc3pRa0hZOTdCS1pwLzFXZm51QjA0MTdVWTh6dzFnakQrUjhaT1RC?=
 =?utf-8?B?ajJrMjJZVE9WODhGM3M1Z0NLOG43OXpkaUhxWGpMZnF4QVBxQytZQTd6OU51?=
 =?utf-8?B?MHliRnJGT3JuUWEva1FkcEVncTBqdFRPRWVyY0YvME52dE9CeEVRd0h6d2dn?=
 =?utf-8?B?UVhoZGk3WWpKbkx5dVJsRkprbk9tdys2bm9tWWxWZXRmaHdMUkVuOUorT2lW?=
 =?utf-8?B?UzFJU0tUdmp4aUZmaGw5YkMwQTkwME9sSTA5bU53eS9SRGtEZGI5NzVPSXBj?=
 =?utf-8?B?aDU5WEhoN3hvOHdJQlBFdUFQR0lZVGI1T3IrVWxSVGxRcHo1aUFuaUIvWlRk?=
 =?utf-8?B?WHZ1RUQrM3QvZmNkVEdjMEttSExpU0FlaVQvckJTcm5CcGttZUJRUy84MlNL?=
 =?utf-8?B?YkxhOE1EbC9FZkdxZ0w2VWxpTW1uZFo3ZTZReGFLYUFsQUNlSUVDckFEMTFH?=
 =?utf-8?B?bnpMNTduNFExSDlrd1lITm1TQlJaM0RqK2dvend0d0dPZG8yVTF4aW9XR0hF?=
 =?utf-8?B?djZjNkpZRGF3UGlBNDU4WTBpNGJJSXBEUklHOXZtMmZnb2dycEcyektRQWo2?=
 =?utf-8?B?cGE3UUNJUlNRZ3NKWVZCck96TFd1ZnlTakR1Y2ZvOXpMQmltZWpOTUVsSlho?=
 =?utf-8?B?YjJ3eEhVaXJ6YUJMSGN3aXg3aUllMzBLNGdxUXNlYWxuNnhhN1QwQ2VKWjRW?=
 =?utf-8?B?UWNYQ3pGNlFVNWx2UGhiZUZiMVR2b2R5bSsyTUs5R0QzSkJBcnhmaXRyQVVa?=
 =?utf-8?B?aGR3bW4xOGJLSi9oNTIvMkJrZC9pSmZ1bEFhKzFOMG1DVHJhc3ArMExUS0pU?=
 =?utf-8?B?UXYwRVJjYmVVSmx6dEV2cE5sSHNhTnhrNEZhK3BGY2FSODRVNjZhVGxGWmZv?=
 =?utf-8?B?THhyRUlWcnpJanNNOGMxbllNYkR3MDArdjJIZW1rNUZNdXJQQXhabVQ1L2RV?=
 =?utf-8?B?ZCtiSnhCMjhZVmpCTFp3dWhuOTljSkJiWmNYTURrNlc2UjBLTGFIZTc3QVJ0?=
 =?utf-8?B?WWVOMFlhanFnNXRDOTVQMFB3QTBoSGVnNVVWOVM3MUpSOHh2aG9zTk90dXFK?=
 =?utf-8?B?OTRqWm5pU3UvdVFMNmRWQ0o2TENuU1VwaUIvSWZaaWFaZHZTM0xxdVRQeEhT?=
 =?utf-8?B?K1BYZStPYkR1V0dvL1dQU3FlVmtDRWxFUHlZa2FTRTVMeTlCejNxTFFtU21X?=
 =?utf-8?B?eWZMcGYwdDN3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bTY3aDRpeG11VkVNdEtQREtKNGF1WHJ1NEp6eWx1UkhONWFHSWxvNGh5VmFF?=
 =?utf-8?B?bWsySmp4RmxkQ1pjNmFiaVp6WXZOaitKT2Zldkx6QStJZ1ZFSnBueUljMzJR?=
 =?utf-8?B?S3ZnQXJPUWxxa0tUenJodVJYeXRJcEdUUlgrdWF3SGxETS93YWlJanFyRHNY?=
 =?utf-8?B?eXRwekxFYnZoOFdGS0t5YnRDOE9NRXk1SVh0ZHN1Uy9oZGJlSldIUFIycWhv?=
 =?utf-8?B?R3lGVXRiSFp4aVlYWEptd0xvdWFFY0tOVWVieHJFVUNnRWZlTkxENWxUNmxI?=
 =?utf-8?B?UTRPSWhlY3czU0RiT051QjdrSGJyTldISDNFTmljVVNlMXZtb3RlcXc1U3Ry?=
 =?utf-8?B?clhGTFo2Mmo1VjQ0aU41VVNjVlRPaVBwQ2NwRUdaRUJyQ0s0Znc3M0tmNFdH?=
 =?utf-8?B?MkJTMlptT2hrN3Bkc0ZwWk40VFVSM00rbW8rYllSMzc1WDJzYzdRQWNTT2dX?=
 =?utf-8?B?Z0NKOHhKTFFmYUFqcHJ5K2hTVUtaM0d6UE5VQjA3Q1JFemtJZmh1VHZSelJj?=
 =?utf-8?B?WkgxdkpKZ1JHbE1jTVI1OUc2ZXFEOExqNGNndW5MaVFtYUxCNURUbFczalhR?=
 =?utf-8?B?ZlBXUjVaZXg1elZDSmhzelBYajdHVjJuQ09nS2txMGVNN2VaNDdIZXBTbVJq?=
 =?utf-8?B?aWJaNDdaVVUwMjRtRC9kYi9VMXZFd3FjaHdBTHJJMGlZUWNTOFN1ejdGSFNq?=
 =?utf-8?B?OHIwb2xUSkVrNk9yY0kwZVhxaUVNcVNTQmFsL2QxUXUrQ29ZeElOc0M5YlVM?=
 =?utf-8?B?TmJqTTNDTVpWMExGY3BxS0Q4OG1GNk9CTFkxcWJmNnA4YXdlMFNIbzlYbmt3?=
 =?utf-8?B?VW1ka3FrSGJZMlB5cXJneEFqUzlWQUlXZitydTVFNTllRGd1L01sWk9qbjhP?=
 =?utf-8?B?MGxKMmNwOG1MbUYrbU5KSVlVTm5OY1dURjZmK3FDR25KQStyeFB5OUwxNDJk?=
 =?utf-8?B?VVBXYnhtVTVrT24zQ1YxWjh3ZWlxME52aHppWG4wYWJVc1AyN0VDL2pDTmZl?=
 =?utf-8?B?WkNBTWtoWmVwaFNFc3lBdkp5ZGhmNGFPU1poQTRNOXdHdkJJMEk2YlNoNjVB?=
 =?utf-8?B?RHE5QzdKTnBBOEJGcmJGTFZVdEs4dWM2TXlRVStWTjF5ZUZHUE1wMmRjTlFT?=
 =?utf-8?B?VmRxY3NNMEgrMnlBaTMxMFR4eEZkQkRjeHVEc0R0WDJtS2NqZkVUdkF3VVFQ?=
 =?utf-8?B?NTN3VnVLSE9IOE1QNzY1dGVad0hsSHRzK01hUWtlZzBkNEtnOCsxMmFuQUZ1?=
 =?utf-8?B?NUJadytJS2F3Z0JEN1JYSGxqcDdYd3NEV2ZTbGF6V25sdTM5T1BFZUJ1WDNY?=
 =?utf-8?B?T3JwY0Q0RVNBTUtXMHVMbnNDSThUcFBtdTExRnozaERpdXh2SnBBazlDR3Fw?=
 =?utf-8?B?Z0xtWlZSZkRZREhRdGdWa2ZNdVV6d3A3UDZLdmh0MWs4M1lwUVdQTld3R2Y1?=
 =?utf-8?B?aUpNYks0cFp3T2JRMmh1RVpCOW5GMkI2N1hGV1U5L20xa2xtNHJZWlU1L1lL?=
 =?utf-8?B?SG11UWV2aVhldTQ1aDlxTndHU21hTDNBODVGMFBwL0ZlZkF3Sld5Y005clc5?=
 =?utf-8?B?d2RySnJRaFdrcmFIVjVla0NlNk1qa3pMNXMxNTJ1Z1VHRzFyWU1UcTVnZWlN?=
 =?utf-8?B?VmIybWQ5YjIwV3BsRmNiSjNvc3lTRUJVek1UNlBDeHRFU1BIYVJQM3dObzhB?=
 =?utf-8?B?cnFvN2N5dWJqTmJRVmFnS1lDMXFKT2JqQ2JuQnMxM2tRZ0o3amxwbkhrMC9N?=
 =?utf-8?B?dVhJSUoxd21hanBXTEh4WlNyYzYrbmprMDRwaEdCdUlCcUpGWUNWYUE1b2d4?=
 =?utf-8?B?Um9QME0wYXp4cFkwNGVTZzV1VEZsVzhCaFkyQzExVVUzUFNBZlJETy96Qkcx?=
 =?utf-8?B?UUpHL0EwbDk0Y084M3lyblpuSmQxTHdTcUlMUnNKNnJkUkZ1Ujc1anVqaDRW?=
 =?utf-8?B?aURxSjVIUU0yaFc4cC9XUjRqczM4TC92ZXNOaFdnbERobm5XOVJBSG9HMzMv?=
 =?utf-8?B?V3FhM1laNS9vTDhVNGpBY1NGYkQ0ZGdvU3piL1NFZzhLTFJpS0kva2RlcmI1?=
 =?utf-8?B?dHhlRjFoWm9udFQvUDAwQTZ3MzZWK3RzVmtqZUVzZFVwTmUrOFZBaFNlUGpy?=
 =?utf-8?B?cVZrS2dZR3dud0o0WndYSGlleEE3VXo0VUhYdTFZUzlmYUdWYlFXWUYxWGsr?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d85c01-f3bc-4c80-7798-08de3bdfa809
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 13:41:31.7243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAQ2PLnQ7UJ+bge/xZXNsWIcmzM5WJA3G52UzATkgjt0dUypLmcZMburQTKEnkmhS6SOgbWD5EYygrO8AYho/nKBWg4rkNDxQOxSg0jDT0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5885
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 13:41:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21064



On 12/15/25 13:18, Jan Kiszka wrote:
> On 15.12.25 10:35, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This fixes the issue
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/145.
>>
>> The following kernel config fix is necessary:
>> https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_requests/152
>>
> 
> I don't think so. You are more likely missing a module dependency on
> efivarfs in the efi-based reset hook.

I will try it with only adding the hook.
Quirin>
> Jan
> 
>> Quirin Gylstorff (3):
>>    fix: initramfs-hook do_prepare_build is executed after do_install
>>    fix: ensure that the partitions are available
>>    fix: ensure separate root home dir is recreated after factory-reset
>>
>>   .../change-root-homedir_0.1.bb                | 15 -----------
>>   .../change-root-homedir_0.2.bb                | 25 +++++++++++++++++++
>>   .../files/change-root-homedir.tmpfiles        |  0
>>   .../files/factory-reset-script.tmpl           | 18 +++++++++++++
>>   ...bb => initramfs-factory-reset-hook_0.3.bb} | 15 ++++++-----
>>   5 files changed, 50 insertions(+), 23 deletions(-)
>>   delete mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.1.bb
>>   create mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.2.bb
>>   create mode 100644 recipes-core/change-root-homedir/files/change-root-homedir.tmpfiles
>>   rename recipes-initramfs/initramfs-factory-reset-hook/{initramfs-factory-reset-hook_0.2.bb => initramfs-factory-reset-hook_0.3.bb} (91%)
>>
> 
> 


