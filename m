Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AFAC0218D
	for <webhook@archiver.kernel.org>; Fri, 31 Jan 2025 11:24:20 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.83])
 by mx.groups.io with SMTP id smtpd.web11.16675.1738322650173510268
 for <cip-dev@lists.cip-project.org>;
 Fri, 31 Jan 2025 03:24:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lfO6BS+w;
 spf=pass (domain: siemens.com, ip: 40.107.20.83, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZRRFRXDNXbS89lySMzSJIWZLiBKWRTkYEt8HG8LC5Qt55UPebVLEn+bEYTUKUNKGRNcPQhZe3IW4UMQ8aT6xxsKI8T5zviZa0x472zmOcSHWgO4sTYMxhCIHAGgucr2VtubhfV5q2ulCsQG8zXdOOkGgDZx5Cic4MCs5H8Fy7Da4DezZ10Kb86wcDvrCPQZZ64yTgNY5Vs7bXlsJAg5EhVn56fZm6Xgg1pq9/PJ51ccUbwfz1HosuCrEzDjG9mm+X1S5jhRDTjNGJFRUyr5CgXs4I8Nh1d0jph7NebAqYrQIWGmUO3NI/7Fhr4JaQCbf26/qUt7WFZ8zERZRbnL8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WO37fYhzKhls1mYKgiTTNAhsfv42Nt60ntWUx1jGQ/g=;
 b=kK3JDlbdss7WK9K0hrdF9aFnqqSNHLmDQ9hCLKCmbvqp7U2CmiImUGQIgUZ3bRN1b7Am0zCZbvOM5Y+2+SObFkE4l0TlXtc9u2KXkdR+TvCq2a5SzJ+aArsNvW2HX2oDOW/bIecI0I9BbbX127iCKtyYnp9L4BjcXWTzmCusVUHojrlk/S7D1BZELlN90e61Yv9u/e1omhysi8UtuYYupluDhZ3TVjOBjVviUhBDuRrHBYUlR2yhJL4/KfsvgErCbC+wLyVl6IIKPSRcxdb3HQ5pdLLI0nSywkKiDo2MpNAOeCF/x/wmfgKid29hlOOKu1pKC0S7v8w12MaCdDXwrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WO37fYhzKhls1mYKgiTTNAhsfv42Nt60ntWUx1jGQ/g=;
 b=lfO6BS+wwEJR5I47DJ+08v7/Mm+ODcKFYDSo9h173mF7CtamFWw+x0GpwuBYEU/ZxFgBNx5buBqk7NrwyXCp/15XiQyv8aQFWjHLdlLWPXP+4ZsIr1c+rCz4sQdw8P33P9EMtfxszuGwUXk484mqTcXau/9jNlbrmnCOrJ5FCGdfTxc5Ex5piW0K9/8ivxpJnoEvBIWDRfCjWL8r+OdDBoKPUDqQoVbwbuI0HB0AAF6qsL9AU5QWXp6TAF27/c3wWLmqlH6AAOh3aprzfkNFDVKSG7llVfZnDEEtNNYjy9l66/UMukehN6irBBJx6Nq9W8HhhJwMOWB7AD9Wi2uE3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAVPR10MB6813.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.7; Fri, 31 Jan
 2025 11:24:06 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8422.005; Fri, 31 Jan 2025
 11:24:06 +0000
Message-ID: <3457f056-b66b-4878-9362-9a9be14ec252@siemens.com>
Date: Fri, 31 Jan 2025 12:24:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][isar-cip-core] efibootguard: update to 0.19
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Badrikesh Prusty <badrikesh.prusty@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: cedric.hombourger@siemens.com
References: <20250129102528.272043-1-badrikesh.prusty@siemens.com>
 <823dfe07-e0d8-464b-a864-c0cf30d7ea26@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <823dfe07-e0d8-464b-a864-c0cf30d7ea26@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::17) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PAVPR10MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f028d17-6bb8-403e-1b30-08dd41e9c60d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QnFSRkkzZDZYRmYwd21Lajc3ZmFKTm1UenhFcWdmbTErelNGMzBvRUZmK0Z5?=
 =?utf-8?B?dDBpelBheW9zdU9abnAxOXM1aDdNZFhxZXJ2aVNzbUF0SzRhUndXTG42MFVn?=
 =?utf-8?B?Y3RNcTBMQnZXdVpoeDhocU4rUWVEMzZzTHRlRGk5aXV2aXpHc2YyMEx4V3ht?=
 =?utf-8?B?UEg5SzJQZDZsRUdpcnFPaHl5Rm9CMU05QU1BeHltVjhxMDVpdjRIaStHRnpV?=
 =?utf-8?B?Qm93UVljNW9udHNiOGJMYXhTZ2ZhQ29vRWxMSTV4M3pOSXl0dUdQNTBmOHd2?=
 =?utf-8?B?QUY3OXFpMHJBdFY1d1M0YnQyZFBHdXQ2RnF1VUJURXp4V04rSUQ2TVp4Vjl3?=
 =?utf-8?B?NVRBeEgrWlRuZTYrN3pSblB2NUM1cnFDQUI5WEdwZ3lnZ3AxUlNKSFFPdVcw?=
 =?utf-8?B?YnVENE9wMlphVmhwaGV0eTdBYkhpS01IWFRwb1AwTXE1QTY0T1ErblZpVzRp?=
 =?utf-8?B?WFB5bWN3NEplQUppdFdUWmlIQ08vcWVIenoyYng4WmQwMUEvc1lxenptWlNw?=
 =?utf-8?B?R1lOdWFRM0VqWTNKbGJ5NVVXQ3o0czdKRHVPTTltMEM2cjJQM1pNQk4vZ3VF?=
 =?utf-8?B?RWRnWjh4MDZ0U2lEMVdnS3U5emI0Vi9yZHdiYzFPaFp6ZUpLak1pS0NlQ3hi?=
 =?utf-8?B?TkZocmp5REJidEg1SUx6Wi9WT0VEc1NYdGtpSGJ0YitDMHE2c1VDVk8zSFlZ?=
 =?utf-8?B?ZFV0R3NzU2hqU2R1VStiOWx3a1Vqdmt3K0hVemNVekc0bUFnQm9DRnlVN2xU?=
 =?utf-8?B?b0VJUUlJZUdVUHNCWTEwNzBxcEcyUktpTWc0dU02bUpPZG1EbnR0czZEZEs0?=
 =?utf-8?B?emljSWlRZnRuaE5lVzI2K2NHcUJINmNWTC8ySDdQa0NHOTBiTGpRZWd5S25x?=
 =?utf-8?B?NjFvSkN3UitlOGc0Q3pGWEV0eElNblBIeGtDc29NSkdJSTlwMzM2LzJXSjlu?=
 =?utf-8?B?SllxRExjdHdxL3dpYStCcmlzZHFtbExNY0RkQWUyZDN0ZWZhblpNVXRsT1ZC?=
 =?utf-8?B?RGUxa0FyN2lWNWtYU1J1NElaNVQ5UlB2TmtJY1JoVE9ub1ZTQzRBZFg3a3R2?=
 =?utf-8?B?MC93K0RGUFd5Tlc5dmd0OVlrK0F2RGUyWTdMcHJvRmNIV1QzODlHb3lVVTFX?=
 =?utf-8?B?bGNvVjNzV2JIZkpQK1F1R0NQWVlJRlh3bU9QVG56VVNOL1k5Y3JJM2krYXdh?=
 =?utf-8?B?US9ZUnhYRmRRNE5zSm80WTQvVzBNVmN6anBsa2lmdVZkbVQ0MjVlWXJ2S2ty?=
 =?utf-8?B?MlFySG8xNU8wV3BFQ1IvK0tJTE5sOWUyVjRtMEdCQ1RNN2tHVkpuUGloNUpt?=
 =?utf-8?B?ZXgydEUyQUNiTXpRTWRnMWhmdVp5ZzNDWkdFTXZqeStGSEZ4aHlYVmtSdjJq?=
 =?utf-8?B?UkJ6QUpscndqUkV4TTQ0QTV0VlcwaEFwVzFvbVEwSzJzV1AwM0FnYkc5bk04?=
 =?utf-8?B?aE1mWVBheEhPWGZZVkNaSUljYmdXTytxZnF5VnJ0UnEyczBRbUVzQUpOK0Rx?=
 =?utf-8?B?M2QwNGwyQk0wT0YxSmFQQWRQRURFU2t2WTFPKzA3dFBUZXRFVUJPcE1aVlhH?=
 =?utf-8?B?OThkZWFTcnByKy9FblpjSWUyeE1NeDRJTG5neldKVW9BbEtwaThMRkk1Ty9S?=
 =?utf-8?B?cDB6ejY4MHhoaFpSZ2NBdkF4RkE5TTlBR205L1pTQysybWdIZDFkMDI0M2tF?=
 =?utf-8?B?TmkvVHFIUFFFc3lnL3JlQ1NQeEI2VGp2ZkR1aFYwRjNmNXNJZDlnZnJPaGtR?=
 =?utf-8?B?SnRwZTBHT3ZTV1k2c3JUWkFackVmTWNVMWhlak00MjV1Qkd4Yk5SdC9Cdyt5?=
 =?utf-8?B?bWpaZU9RaEdvUTF3THA3Zz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UkxmeWI5c2loUmVZQ2J2ZHBlemFXS1pOUlk2NmhJOXBoNktaWFo4NUx6cDVT?=
 =?utf-8?B?K0dYQVlKQ2lObENZUCtmaWJMcWFyL1hISVdaWW9VeGgyeXBuOWRWWlZZc0pN?=
 =?utf-8?B?QnZFZ0tWNFNRZ3k2V2hZZHZRWVQ1UFdmL09oayswTDBOTU1jbXRzaFB2eGRk?=
 =?utf-8?B?UjNpd3lIUTJJakZPaTJYanVON21sdytMS2d1dlY4TWF4SUEzK3J1UE5Mby9k?=
 =?utf-8?B?azZ1SzRNR2x4R24zN2pyQnd2aTZYempxMFNDTWxtZzJYSUthSnBnQmRPWEgz?=
 =?utf-8?B?TnBkWEp0R3plL1hJVXhIOTEwRllNQm4xVW5wbTBSYlJrakt3V3A3WFBZbVhz?=
 =?utf-8?B?cndXUitoNHlhZDBVZUR3V0RMUzJObkVjYU5iYjFOUlFFSFhjNjVLTjJralk1?=
 =?utf-8?B?RHoyYzFGNFhPOTdpQlJlQUZZSWlUNmZ5dWZWL2N3bXE1NXR3SXMyeGJNV2xl?=
 =?utf-8?B?RHMvZmZyeTU5eEJWZjFMdXVsRTB5ZmtVcUdJVG1pMTYycWh3TGEzcDR4clZv?=
 =?utf-8?B?WTVOMzRadHBKc0tlVFB3M2JlZlU4Y0ZSZC9jU1Q5RCt4dmYvbllkalBXV2l6?=
 =?utf-8?B?bnFxMlU4ZWt1alh1bTRFZk1QaUQyWUk0aDA5V1pOQVJLaHIwNysycWVWbUE5?=
 =?utf-8?B?ZzZtRUViTmxrMzI0R3Z3VFZUdERlaEgzbUJRTzduZU5ka093aWJ3Y1JwR25U?=
 =?utf-8?B?VXMrTWd5UU5LdFAyaG5Ta1Z5eFRXZkdtNzA2UGtzWmt1UGVsMWMyajBZeER6?=
 =?utf-8?B?RGh2WGZySFVkSWVTVjFlenlFbWU0ZitBbFhmMUxCaDcwc0k4eWJpOHA1eFhB?=
 =?utf-8?B?NklvOHlES1RhNmpISUxkOWx6ZGZvNlc5WTlvUWQvcGlOTGY3SnphUkk3TGV1?=
 =?utf-8?B?d3Y5bWd2dlpJbnhSQ0tFdlJnYXZBNzg2SWpnNnF3WjJEeTY0UngrWHNtMnR4?=
 =?utf-8?B?ZjNzdnVnbTFxUjF3Z0k3Tmh1VE9vQW9Qbnk2SFdNRUxDSG5pU2NUd0h3K3d6?=
 =?utf-8?B?T0lNR0RSYWxMankwTS94OURoNEo4TU1RcDVWZjY3Y3d1RzJleUxBTnZ1TkFS?=
 =?utf-8?B?Q00vc0xSZE5ydnppRklvZW9qM0VhTkhYMHd3NTdsZ0xRYnJ5MnBHSXJkbm43?=
 =?utf-8?B?U1Y2c3l3WmN4OFZ4YmNoSStUMURIWHJGQWxOcmZGY2JyU2lGQzlqcUp1WWhC?=
 =?utf-8?B?SlIrM0pPOTVuTjJWMzhWeTRNZlJqajRBUW54Wit5WStCVEowS1duZnZxUU82?=
 =?utf-8?B?bjFMdEJBeEUxYS9BRGlzaThLYjVIWHJmVWdEOW1FdWsrbWg4ditJbDJwN3Nn?=
 =?utf-8?B?MEVZREF4QUM4dUdpM1N4LzdUcHlOM0xNR215NjhEb1BTTkhRMjRLSUdXbXdU?=
 =?utf-8?B?WDNVMFVuQXBuRldCVWR2K2JTanpLQVN1TmVZQ2NnbElTZ2QwMDRYZnRiM0Ev?=
 =?utf-8?B?MXJmRHRJRllNVFNpNnJ6RVlHUEwrb0NncjllWjJHNUQvZzRpUDNqUUR2bEdW?=
 =?utf-8?B?c2VNM3VQZDlIaExKWDB6R0hqUXVERDc4SXZ0R2g4TWkreHkxdFJ1UGU3M0xE?=
 =?utf-8?B?c1puQWtRNVpDZ1hMQ01CenFiSTIwcnkvM0dSdUpVV1RobmtHUGtqTkxJamFD?=
 =?utf-8?B?NnpQbTRkU3h6Y0s2REd5QTJpRm5vSzREejkzRWhoL0JHczNqMjlxay9zUnho?=
 =?utf-8?B?ZEZZeFVnOWJuMWJoUmFRczZnaW11M3NZY1BCdVF5V1FXU2FhNzNBZEtpTHVB?=
 =?utf-8?B?d0VoSmpHTjcrZ2ovRElRT2p3c0JJbjBCclVidW1iTjVlZ21aN3ErSTVpKzdn?=
 =?utf-8?B?aHFhL2JBL0Z6YUpEK0NKTHVGMjBEaTFzdDFoa3JEeFM4b2FnY0VaSmV0Y2N3?=
 =?utf-8?B?Z01PaXVRUTRIMWN6Y1RZMlBaYVo0SFo5K3FmVitIalZkalZFcUswcjJ6OHlw?=
 =?utf-8?B?Y3dxc0hRSWJMRlR6a0pEenZUcFZwVGlRV09CeVNscEJJcTgrT3NnNzBzSi9Q?=
 =?utf-8?B?MFJjTDZBeGZFZ09QOGtCS280eDhmODNkSklGSUFTL0dkRmVuSmZTdkZPQjQ1?=
 =?utf-8?B?QnA1Rm9EQzlPWnVoSGZ5WVppek0wd3Fwbk1uQ01DQm9tLzVOYjArYWcra2pO?=
 =?utf-8?B?cGE0Qy9XY1FkRlg4OW9vV0U0em0wL0xQNENPSUl0bFFVdEJyU3BCLytrVysv?=
 =?utf-8?B?NVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f028d17-6bb8-403e-1b30-08dd41e9c60d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 11:24:06.4033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YufCidM4AUiKybQZ58R+ZMn4s12ZcVBb3nH4U8OuE748fKT5D0+rITvBboM61YSCt+SNTTcWypfgG/kGcKmvqNvx6CfRgZuxwURRqv7qEg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6813
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 31 Jan 2025 11:24:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17717



On 1/30/25 06:23, Jan Kiszka wrote:
> On 29.01.25 11:25, Badrikesh Prusty wrote:
>> The latest efibootguard brings the Watchdog support for SIMATIC IPC BX-21A
>> and Advantechs's EC EIOIS200, added support for and usage of the BIT(x) macro.
>>
>> Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
>> ---
>>   ...fibootguard_0.18-1+cip.bb => efibootguard_0.19-1+cip.bb} | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>   rename recipes-bsp/efibootguard/{efibootguard_0.18-1+cip.bb => efibootguard_0.19-1+cip.bb} (87%)
>>
>> diff --git a/recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.19-1+cip.bb
>> similarity index 87%
>> rename from recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb
>> rename to recipes-bsp/efibootguard/efibootguard_0.19-1+cip.bb
>> index 6d32833..981aa3d 100644
>> --- a/recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb
>> +++ b/recipes-bsp/efibootguard/efibootguard_0.19-1+cip.bb
>> @@ -1,7 +1,7 @@
>>   #
>>   # CIP Core, generic profile
>>   #
>> -# Copyright (c) Siemens AG, 2020-2024
>> +# Copyright (c) Siemens AG, 2020-2025
>>   #
>>   # Authors:
>>   #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> @@ -23,8 +23,8 @@ SRC_URI = " \
>>       git://salsa.debian.org/debian/efibootguard.git;protocol=https;branch=master;name=debian \
>>       file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch \
>>       "
>> -SRC_URI[tarball.sha256sum] = "023b96548e0779bd7aaf58899883099dba9993b1b4af0c858adc00382523ae52"
>> -SRCREV_debian = "7e31b8f9cc204d1210c6c03381f936a96c29b35f"
>> +SRC_URI[tarball.sha256sum] = "167a808d508558341b81d9a493f76161ac7fd7119e764435eae1b13e31a69737"
>> +SRCREV_debian = "040c116a61ffc99a92b6cbdb793abb7f51ef8d4a"
>>   
>>   PROVIDES = "libebgenv-dev libebgenv0 efibootguard"
>>   
> 
> Thanks, but we are holding back such an update for a reason: 0.19-1 has
> not been uploaded yet, thus is not yet an official Debian version. We
> had fun with prematurely adopted versions from salsa before.
> 
> Quirin, any news on this?
> 
Efibootguard is uploaded and taged 
https://salsa.debian.org/debian/efibootguard/-/tags/debian%2F0.19-1

SRCREV_debian is 040c116a61ffc99a92b6cbdb793abb7f51ef8d4a

So you can merge it.

Quirin

> Jan
> 


