Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F89C3DA4A
	for <webhook@archiver.kernel.org>; Mon, 19 Aug 2024 12:29:57 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.84])
 by mx.groups.io with SMTP id smtpd.web11.209276.1724070595066193407
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Aug 2024 05:29:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kfOBrecv;
 spf=pass (domain: siemens.com, ip: 40.107.21.84, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFUZKtZNycBNMLcWdS8mxE3b34sNt7grE3JYm0rjELtFIuq3ILrVLOEGkCjm2HFow3Mvi+bHSMsaTC9mAxMIoVERuLYc7PKLquwAo220X1l3DGY44GRXg/PzhO536xozPp5pf6vc25sysC+YP6K6A7B6DlVSXIU/C3nAn9G14DYU479FPyGLv8rsPq/WB/eOhF7CHDEHOOeyvHOk6R9FqaPIt4iCbRhIEI9lwY5zhjh4hRUPmRlBp/O46Pd9U3fr4qyRKmgKLekkHpG74lHp6jht59K3/Z0goFc7Lr2uHqM93dw4ChPBqi0/d8khy9iLIrlJPp6b5ajLvOe0jTHSVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/AxUuXaQWgjQ//EU1le6oohaM/efNgwVr6Y0dTrFP0=;
 b=JjZsVzfRtGEyZtHEYV8JO6bDRa/40wPLsUOg1Gdr674JVsDN+vByfaZyk7BQ9ah3cgK0MyXCJC2maW8N7k6PEDNleIBsvP/e6W1txwL10p1t+eJWwYfb0VHpRJzsvg78+Y7kLRpVQXQI9vocdm6OF6fSOfwKv+EEGr2+kD7v3isUJxFcPSLrfJsHPza9boYZKpRBtYXBy3mDuDAHoIldHPP0JOGlem9w7l1DNJ6OgR28mHRncV4Z1QOh/vEV+4d5o5jiPe0SgeeLsnsJ5RZxPBlLukEW45Bwqgs2i7yzAgJTFvoEHTjOuAkcRWYbSVsNYH9wE9sd8Y1dS+HJ2FqZxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/AxUuXaQWgjQ//EU1le6oohaM/efNgwVr6Y0dTrFP0=;
 b=kfOBrecvV6+Y72zjUEPAvZKHzkulFcZZ67p7VWhxWuOhz3/6wICpbqMGN9MWdF6RhhjyRxVvCm36yxXJHMnMLM+ehCJkcrwJFwfeT2Du+AUAL16jOkwJjZlM2UuH0DnxHCrhMZgaaFhFy+ZBGm5t1yAJZXpeGtG41wpiZiuVJjFEFe7Hm+klYhlAinNGjRPweq/inDGhxsBQ2NuQ7EKjhs/B0plalf9ReVSde1JOV/pPdWyMik1GjxIlmhp4NlhYRUsK44547F/keSTTqBUdxHF0NKJdmpI3G68ag8m00r1mingcdfF66uOedacwuZgCquRXw3dGa0Uz2CkeL9JntA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS4PR10MB5342.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 12:29:51 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%7]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 12:29:51 +0000
Message-ID: <a136353e-0f79-40b6-b414-2875fb37672c@siemens.com>
Date: Mon, 19 Aug 2024 14:29:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC] fix: Check return code value of
 e2fsck
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
 Sai.Sathujoda@toshiba-tsip.com, florian.bezdeka@siemens.com
References: <20240819121045.1533891-1-Quirin.Gylstorff@siemens.com>
 <8dc1de98-857c-4aac-9f68-db58dfde3c85@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <8dc1de98-857c-4aac-9f68-db58dfde3c85@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0221.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::18) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS4PR10MB5342:EE_
X-MS-Office365-Filtering-Correlation-Id: 7609e393-0cd4-40cc-6842-08dcc04a9f7a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZTdZYjlYK2FObUg1NkVISWVKMEdCSzFYWEtJZFN5ME1SUStzOUpmTEI5SWFO?=
 =?utf-8?B?bUp0b3N2bisxTmt3aUxQVk1rWVRmY2ZRdWlhR1V6dnR3Qnh4M3J0L295UXZw?=
 =?utf-8?B?Y2gxWnpvSGcvVjVsVU5kVnNkN0NldkhEalVnQ0R1Q2FMa1Y3cTdGOFBaZmU1?=
 =?utf-8?B?YmVSRW1VQ3pTb0FCaEtsL0VMbVYyR2Z6Y3lVTjhMdThxSGNyNXhTNnNPcWdS?=
 =?utf-8?B?aFJkYW5ySmhXRnp1WFU5VUV5eVNwbmZGVTh0RlFIaGlONHFRMGNkU0gyckxB?=
 =?utf-8?B?MU1vdkxRbFdDQU1mQ2IwWkFRNzM0aU9hTFlKUEFTYm5nRlZRMWl6VnBCWkJ3?=
 =?utf-8?B?WHJJZDF1YndNNlJtVmRmL0YzanpaTTZWNWVrQ3hlaSs0WE1DbVhRWlJKOWJS?=
 =?utf-8?B?K1ZVKzVHNmRZNjV0bTI5NFZuTzJoSllkRGF2bW16UU1pWjduVGtEUDBucnVu?=
 =?utf-8?B?UC9wS0JtMFcxVTR1dDVyakR2bTREZGdkMXFLUG12MTZpQndGRFIrb0ZlZEpv?=
 =?utf-8?B?YncxbUV2anNJcTBneFJOeWIxZFE1aDVSajF2S2hOY3NLbUc2a3MrZkpXU2dH?=
 =?utf-8?B?VWRleFNDektEZVNQVlNqR01JcFV4cndZTGFOWVE5UU1HS0Z3UFFHdWFjRXdw?=
 =?utf-8?B?SlBaVkFNUGY4bFhROUtlUmtyMjdRSTFJOXdVbUhJNksrcEhVSHgydzM0bys3?=
 =?utf-8?B?ZWlXbEhaSUJKYVk1cDBoUklTdTFVMDB2dHA4U2tjRTdMWk90d1JtRU83emlB?=
 =?utf-8?B?MnBCcTJrOWxMaFpwVWxWTlJXT2xFWE5IcXBTVmxUVTVhNEJtMjRwdlRQYTFS?=
 =?utf-8?B?SmRJYXFpUnYvaDQxekFFNXdoc0JKNUFrWWNVVXNlN0VFSHR6L0k1eVFTdTA4?=
 =?utf-8?B?c3FtVW5zZHYwb3pUeUwxUlU5eVhvSUZVam1uU0xFR25aL0xpQnR4R2kwSVhB?=
 =?utf-8?B?cDcrNER3RXp6TC92NFRzclp3K3REWEpuUTQ0azNFSnI4TTV4QmNjaEIydFdP?=
 =?utf-8?B?SkxIeGFkVG9saUdvTWNUc0pMUWI5c2xrajZXc2ZER2JkdVo5Mll5U2Z3OFpY?=
 =?utf-8?B?VkRvWXlicVMvRXJDSlBNQ3YvK1lVMnp1bXhuS29iZ0pzdmlIWEkyK05HYXdq?=
 =?utf-8?B?VDhQT2VmZ1daUG9yUXdZU2VYc2c0YkRqWFlTMHFRcGMrSi9UNEJhK0F3b2JG?=
 =?utf-8?B?Y3UwdHNGTVVXS0JKV3ZXeWo1V2o5NGtiZURjNEUwVVBtOHZ4UHNCM2xVRVpP?=
 =?utf-8?B?dmRVS2hlR2JLd2xtUEZTbkNGWEhzdGxtVk56aGNtWUxOdk0yZzdOTzErZFJE?=
 =?utf-8?B?Qm1xYUxmaTRPT3U5SU9VWkFrelFrM3F6ZElHVEdKN2ZIYWZ0azN6TkN3UzRK?=
 =?utf-8?B?VzQ2Z0Y0ODhiUGplQ2pEdzJIV3hjRDJtS25DTmU2c2IzdXpvMFJ3dDlpdWIx?=
 =?utf-8?B?ZzhsMllnTGR1OUdCa25pOE84RmY4b3ZjaDQ1VEdDODBhaDRmWHEvMXRCWnhW?=
 =?utf-8?B?OTBWNzllY1dGZFlUNUp4eXVHY1hyM1VKQ1VNNGZwN0hlNW00RExJTHprWEs4?=
 =?utf-8?B?dytrSCt5cTNJM29ybnZHSUx5bG45THBZMWdHeklsRWh4aHdKSXZ3YlZNVUhY?=
 =?utf-8?B?eGd5NUJGTGcxY3dwSHNFMlArNFZ6RkhBRk9SMXYrU3VLN3RvT0ROelljOXlG?=
 =?utf-8?B?M2VrcUVzdXpHNnRacTNmOE9jMU9sRlM2WmdLMVVSdWlVdUFkb0xHU2oxTGUw?=
 =?utf-8?Q?VG6+qx9NZ5kO5ogSZA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OFJrVi9WeC82R2dySi9zYTMzVEo3T2F4VHloQklPUis1eGkvNU1RMWthNUNq?=
 =?utf-8?B?Y2x5TUttZUpmQnhoQjVlQmtIM2FFQkNRWnMxSm1yeWVVcEdHdDZuNWptNzJm?=
 =?utf-8?B?OGxRSjUzL01Hdjc2VU1uYnFKRDdTTEQwd0R5SGVwWE8yUytMcHFvSk1aTlh2?=
 =?utf-8?B?VEROaVNBU0lwb1JGQ3pmMm9La280MzJGa0w5QnQ5U05IL3dwSGlNWHhrNDBK?=
 =?utf-8?B?OGorbEszQ2lKbmR3Mjh1U3lUdDRCbzAvRytYSkR3eEhsRHRoVC81eXQya0ZL?=
 =?utf-8?B?NU9EL3J6RFBtS2l6eisxdVZwMkhMbThsWSsra1dMZG9ubkpvdC9jVEV5dERG?=
 =?utf-8?B?OGovZmZFVzQyYzlvaDJESkRMVzdBMGFETXR6K2t4cERINXFTSVl6Z01FTmIz?=
 =?utf-8?B?K0lycjF4NEo4OW1FQnBNSjhBMlRKbDRTYk5JVXdOclA2N3V6clFzVitnSTEy?=
 =?utf-8?B?aHJvdUV5TTZETEVvMWZGc2UrYU9URGZEeFBMc0RhSHluUDU3MHJFQ3BDcEp4?=
 =?utf-8?B?QXd5TWw1ZHlMeW0zVzJpOXZKbitIRHlUSDAvVkoxVng1eXUzSWRLVDJ0alls?=
 =?utf-8?B?ZHNacWNsTm45aFluQ2tQTjk0SkdNY2pvU2pNdEp6dngrSGJ6Q2RUTmFOTlMx?=
 =?utf-8?B?V2UzTk9laTZaRnhXVTRnTEhzWVYxTXNvS1E5aVVnSFlxTnpZY3lwL2EvVFov?=
 =?utf-8?B?NzZkL2kxQ3M2N2p3T0lIT1FhRGNLM1c3VnRZcll2YjEwNlM3T29uR0NWYlhL?=
 =?utf-8?B?L201bWttOSthWnlHMVpqczNQQjRoL24vaGtOdHJlSEZSY2MvRnB4citvYWE1?=
 =?utf-8?B?cXBqekhtOU1sZFZzZk0rYVFoUXBmS1JXNTQ3dWlFd2hocjJiWlpJR3NTQkRr?=
 =?utf-8?B?amhrUVJVbDlXcjNxS0JIYldIUi9RTEE4Z3l3dmZObUJzQ0NJV3VaNVNxaVEy?=
 =?utf-8?B?QnptZnFmZzNKVXExK1N0cjZjQm9IaUtzQU9Ba2RyVi9iNTdjbE03NGhScEZM?=
 =?utf-8?B?T3IrOXFGL3VHZnhUZ0VwNGQwdVBGMHRnZXc4cWxVV21VbE95OGpua0dHT0RJ?=
 =?utf-8?B?K0VsbXgxMWJtanpTMmRBQVpjZjRHSHlqaXpSNUV4WnlzbHNXS1NpSVdUQTND?=
 =?utf-8?B?UENaaXdBeEM0UXNJWVFUM1h3cUk2cDVFWjBlT0R5Q2YzZytieG5Dd2E3d2JF?=
 =?utf-8?B?UWNibVF2RW40dEhPY2xqeUcxekU4Z1dSaStQRmsvUjlzaDZJbUI5REM0OXUw?=
 =?utf-8?B?VnYybVNLSjRiU1NDeHZqbE9yWENVWFBGKyt5UXVJamIybDNHODk3cWJDbXhn?=
 =?utf-8?B?cWRiYmhITFZUOGRPZml2Q2xPcmdtU0FUelo1cW9tUmNLVDNDT1RXSXgyTmlI?=
 =?utf-8?B?QVRYamVrdjhsU214THNrNkZvcjgwMG1IT2o0cGVJTFFhSzhDcFhiaThacE5z?=
 =?utf-8?B?ckNkcE9hMzNpM2RUalVzVTlJQlpqOVNEZlN0cmN0NGxxbWt2VitUZDY0Vy91?=
 =?utf-8?B?YVpNSkkzc0hmcXF0QjRyTkFzMkhDNjFKbDJZYXJyQVlRVnRUbFZpQ2NFeGZi?=
 =?utf-8?B?QU9UbElCYTlRdFFJVG1xV2RUeUQxSjgyVTNCNUlCWDZaTytsS0g4T1Qxdjd4?=
 =?utf-8?B?ZUt4d1paQkRoSDdGTHhHYVBLWGJXR3l5WTFCVGJ2bmJ3ZkRWR2dacG9UZTFO?=
 =?utf-8?B?cklYaEZqekJydUMxazF4Vnc0alkrZm1QU3pBQVFMMHdhRVJTYlQ0aGxxWktx?=
 =?utf-8?B?T2lMdThMbW1MMnZDRHBMSDcyQ1dCaFloT2hqTWZNcEY5ZjUzSmJqSEQ3MXdo?=
 =?utf-8?B?TmVqMlVsajcyMGhIZk4yb1FIWEFUTStFc3lhRlpERnNxcTA1NEhQM1FBZHdr?=
 =?utf-8?B?aEU1ejE0aHI4SzVoWEQ1OVBBVE91L0NYNDFFTU8xVXFaRklkVWNBOWIrR01F?=
 =?utf-8?B?ZlZuZEtWUHZQTDU2ODY1YkdxSVNVZEJzQy9Ickc4SkJTNGZiSC9pNi9XM3FP?=
 =?utf-8?B?UGl0azMxUEpKa3A1VEo3NXFPaEE2ZTh3V0hLZWxwZEN0bjErUHdraTRuMW5s?=
 =?utf-8?B?QVVmWWNsLzVzUC91TlZ6dk1WYzRwZ2pOTjFaSnRpWTYyRnVlTDNrMjE4WEdm?=
 =?utf-8?B?am51czk0WHFneDMza2RERzBEVUkzVlRmT2x6MnYwS1hla3hxcENsQjhSd2lY?=
 =?utf-8?B?MWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7609e393-0cd4-40cc-6842-08dcc04a9f7a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 12:29:51.6251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGhtJxxPCKkH74gdkwRkFoppVCR+NaNLDEnEzXyjtSv6vSP+zi4KZApQyt0RwS/8QHGdPBdAn7Y8vU6zmICKCt61x5dMmuML+fsK3vEAktk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5342
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Aug 2024 12:29:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16801



On 8/19/24 2:16 PM, Jan Kiszka wrote:
> On 19.08.24 14:09, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This fixes the overlay script in case of a recoverable file system error.
>> In that case we execute the erronously the recouvery script and mke2fs
>> ask if the filesystem should be overwritten.
>>
>> The issue was introduced with:
>>
>> 8644fb1 initramfs-overlay-hook: Check file system of INITRAMFS_OVERLAY_STORAGE_DEVICE
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> This fixes the issue but we need to address the problem in case of a
>> return code of 2 which requires a reboot of the system. Should we:
>> 1. panic
>> 2. silently reboot
>> 3. execute the user defined recovery action (add the return value as a
>>    additional argument)
>> 4. do nothing
>> In my testing i used 4.
> 
> Why does e2fsck require a reboot in some cases?
After looking into it:
In case of a ext2 system an the check file system is root.
https://github.com/tytso/e2fsprogs/blob/950a0d69c82b585aba30118f01bf80151deffe8c/e2fsck/unix.c#L2133
https://github.com/tytso/e2fsprogs/blob/950a0d69c82b585aba30118f01bf80151deffe8c/e2fsck/util.c#L70

I will remove that check and say that greater than 1 needs the recovery 
script in v2.


> 
>>
>> Also should we force mke2fs?
> 
> I would say so. Who knows in which state that target partition was left.

I will add it in v2.

Quirin
> 
>>
>>   .../initramfs-overlay-hook/files/overlay.script.tmpl   | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
>> index c655a4f..02df53d 100644
>> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
>> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
>> @@ -40,7 +40,15 @@ partition_fstype=$(get_fstype "${ovl_partition_device}")
>>   if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
>>   	case $partition_fstype in
>>   	ext*)
>> -		if ! e2fsck -p -f "$ovl_partition_device" && [ -x "$ovl_recovery_script" ]; then
>> +		e2fsck -p -f "$ovl_partition_device"
>> +		fsck_ret="$?"
>> +		# e2fsck returns 1 in case ofrepairing the file system or a 2 in case
>> +		# a reboot is required.
>> +		# https://man7.org/linux/man-pages/man8/e2fsck.8.html#EXIT_CODE
>> +		if [ "$fsck_ret" -gt "1" ]; then
>> +			# TODO should we force are reboot or customer action
>> +			panic "fsck requires a reboot"
>> +		elif [ "$fsck_ret" -gt "2" ]  && [ -x "$ovl_recovery_script" ]; then
>>   			"$ovl_recovery_script" "$partition_fstype" "$ovl_partition_device"
>>   		fi
>>   		;;
> 
> Please typo check everything.
> 
> Does this fix
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/113?
> 
> Jan
> 

