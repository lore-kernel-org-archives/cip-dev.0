Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22425D4335D
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 13:01:25 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.76])
 by mx.groups.io with SMTP id smtpd.web11.71217.1730984478909519475
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Nov 2024 05:01:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yKSwtsJF;
 spf=pass (domain: siemens.com, ip: 40.107.22.76, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuM77jXu+zGYirdY9Fe3bJcKUwaUGsm+D6QoZKxFH4jUlfL83eUa+Ysi6XEans73WhMX91nXU8QmiLe12IpdJt6YIFzhm9qBibw+Q5v1daZlNEiacZV1Ji168b5x/gfhnnVMKrU9ny1BqpN9UK7xMNbExZWtBDMuKEpK9mJfY5WMeDzyqoqxUe24IkDU26Iz+lWAa9oYWlqAj2bcCams0r7B1l7m7lM4SvZ/DIWjvoreL6H11ksU+GMZOjyj/Vi18EdVXtM8lEIz77v5FZAcYAKqXrht53Lw8OR9BibFdKpmICoKRDr8rcWqr2EmVnU01gytBzGJ3yvTTDkudcB+Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IxhFV6osTCN5kj1MpRbNtXFv/lbeAdNDdXEBDKDklQ=;
 b=bpVqywKs5E0VXu+6cQ3MUD0+Lw0uGXWabzle3fj0jMq3C9hWQHFR7n8kg3V5XpwDhhWQcO2TKMpKp/SUSBXHWVCwVSiMNaDv6Tocqcl3kjPbWERN7vmKtyAJnQcUHLs0ATNfTiBmwrHkvOFvv7bU4vv0qwa+Y2rxVFy3sdeKQjKFmAM3cBUQ/6TbDf24lm0fsCqW5ncdCvqqNMI1e1xL+pR9V2a8wDY23S+JSi30am2iD2NxtnRRWfNbTIZdQEuXvadTc4zlY/vgVujA4CTfygmjLWBLklpacJSzG+BptvMjGa2FbUw4LkJLXZpcn2c6GJkzuf8L/2m3b1WL7z5bIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IxhFV6osTCN5kj1MpRbNtXFv/lbeAdNDdXEBDKDklQ=;
 b=yKSwtsJF87weMpdQSJxZ5QWpfeCpcA1x/HzsCS+Y+LZpa9TZQanBLENs1Wpxr1hu3V4VgDQTvvthBcQvBK7q8j5chpvBuwDWgZBHi8hojtMAnTqTx17HFos/NncOBIkZezIDt49qXM+d1WX4igjT+ffFbMdvTYEF7IfZlc4zELI2Vfzfs6ozXioWrtpxrL9qRB8LTOg1QSQWOqc5ywY1/AyMvoHylluCtHS43dmQXGNJ6zNHTNpg4vnzOVBt7/3GagipfWPjmQOMD1bWz7H9cJnYeHaEoOyg8LoIkJrRwDo8FEaFygn3lvWDLOWW8YRNbeoiyBN6Js2KNv6QCsunIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS8PR10MB7661.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:637::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.16; Thu, 7 Nov
 2024 13:01:16 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8137.014; Thu, 7 Nov 2024
 13:01:16 +0000
Message-ID: <8e46b4e7-828c-4f66-95ee-60992594b491@siemens.com>
Date: Thu, 7 Nov 2024 14:01:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 2/9] swupdate: Control self-building via
 boolean var
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
Cc: Cedric Hombourger <cedric.hombourger@siemens.com>,
 Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
References: <cover.1730977077.git.jan.kiszka@siemens.com>
 <c6ab307ddf903298d2fe23ad93b1e6a251ecc6b1.1730977077.git.jan.kiszka@siemens.com>
 <af85d99b-c02f-462d-b668-7a41ca966dd9@siemens.com>
 <e5081064-f132-4d95-9254-e2962ae7bcc9@siemens.com>
 <690f991a-a496-483a-8125-8245991ab25b@siemens.com>
 <244a95ad-fcdc-4ec7-b3e4-bf5e6e5bcb49@siemens.com>
 <05e39c4d-bc28-4646-af88-b6a52ab5dcb0@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <05e39c4d-bc28-4646-af88-b6a52ab5dcb0@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::8) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS8PR10MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: d4485939-6910-467e-65c8-08dcff2c43a2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MHFuNjhhbHk0OGhkalFyWU5OSjNWUkxCeDlDVWU4TWhUYW8wdVFTb0hDZDlh?=
 =?utf-8?B?VVdQMkl2SVk4R1N5em9UcjZPN2lRR2t2dlZRb1JkYndmZGNQSkZhNzZKNlFT?=
 =?utf-8?B?RWZVTHRhWjBBa21JNnFGcElzMTAwZTlCek1zdE00Q3p6Q0U1bWh3aXVBYXZL?=
 =?utf-8?B?MmZuRFZkZ0pCMEE4NWFBNFR0MWlacHZpWEtzelY2bmRjVzZmNDFjcHRKSlpz?=
 =?utf-8?B?RDZqRlRCQUprQVdKdDVPU0FkQkJWZnBOZVczbkdwY1hKaEd2V1F4Q2xJdzhW?=
 =?utf-8?B?OUtsQkVmMlplUFlzdloxUmx3bmNkNkJ2WkRSbFh6UGNERmNoc3VnRmx4OG5z?=
 =?utf-8?B?RzNTME9PbUkwSDZhNVIxdGlWNTIzajVqZDV4QzBtc0FJMHVINWhUanFWcWJH?=
 =?utf-8?B?L0o5RUpialo1eEljUmdUcnNmYWk5ZGJreHJZOEEvdFpVWW5kcG9DbnJ5b3ZE?=
 =?utf-8?B?TDFxV2lCZCthbDhOVjhMRFBQVW1panZLMU02RDFtUVNiaGc3bldsVCtQYUZI?=
 =?utf-8?B?OVFkTXRIMXF2VW0yVTAvL2w4SFlkRTUxa0Q1YVBSU0pmMVJxQjd0dGt4WnJH?=
 =?utf-8?B?aHlaQmZhK2pCV3BvU1Fnc0xmcWs5TGREZFlHZlNwbURBM0RCcEFsSFdrWndM?=
 =?utf-8?B?ZEVxdmU0aG9JK0NVSDFMOWF1bVJqdEU1dkpaNnZRelB5cld2MUJXbU11UFZj?=
 =?utf-8?B?Z1JvcWp1RGpZS2FyaThUdHBVK3pkR05PV2tqODdib0JaUDFvT0RiK0FvRDQ0?=
 =?utf-8?B?OCtiRTJtVXZ3S0I1YmpUZk81OXZMNlBRZVJabmI1bWhHY0I4Y1Bpb3NoYWdz?=
 =?utf-8?B?MjV1Sm0rbGlNaUtVSmU0bWpQbExVaHRwVEJWczVNVFpZM2RRWEZPTDkwYW9a?=
 =?utf-8?B?QUZPU2R2clFNVy9GL0Nud0c2UGREaERHUjU2VStDZFR6elEzdUxPUTZPNnda?=
 =?utf-8?B?aEZzRjY0NnVhTlI5MTd0bkFUMjlmV0xZYWdPYzFRZTFRdTc0V050eGpXR2ZD?=
 =?utf-8?B?Zm1aT0htWFBWaEZEdWdXVklpNlNSemxyK29hWmdXbDZDY2hScDlOK0kwYzlz?=
 =?utf-8?B?WE8vcEoxajU1QnFDalNTRytuMUV3ZHRFVmxGY0ZPTmVVSy9kTk1zdDFsNEtH?=
 =?utf-8?B?WkdGdndVajE2YTlmZXorNTYzdm10Vi9UUlVVYXBYM3JiUmx6SnAydFhaczBy?=
 =?utf-8?B?eHhBMFhocmFSVTlQcGNKWmljOVdOMjVla0lrSGJMK2huL3lNbWlTZkZQWnhl?=
 =?utf-8?B?dXhmRW5jRWwyMHM0bUkxdlBkMUVyVHlrYS9CeE1QWnZnSWNWaTB6NHR5eC9H?=
 =?utf-8?B?anZaa2NtdXdtOVJOaEVyS0VxY2c4ZnNSbFdtbFZ5ZTZwTjJSZFdVVnloQkhT?=
 =?utf-8?B?SDF2aHM5a0ZBcG9mL0VCbWE3b2grVVZDTVpPaUsxVndaaUlmTjdJQmc4elMw?=
 =?utf-8?B?cnZ1RmlVS0VIV25oMEprN0RIU3B0OGYrRXVXVk52b01EQXNDQTBkeE5uRE83?=
 =?utf-8?B?aktnUGJpTkVpRURIcjRzdmUvWDZJNFozS0dhVUhOc1RWMXpTVHpYQ2VZSmFj?=
 =?utf-8?B?L1Fvd3ZYOVVNcUxEa01ETUpBUzVqUjNUcHI5OE5KdlBMSnlFRE1lUkxiS0tR?=
 =?utf-8?B?TE5mLzJRbEtDd0FFSUU1V3ltSTNVd210ekc3ZjMrdFhHSzVpbHZqcUZSdXcv?=
 =?utf-8?B?Qm9pemV1c09pL1cxQm1zSUY1bzFjRGVmL0dpbHdJRTRFT0dlYWw1UjRqQ1J5?=
 =?utf-8?Q?FFDfvXjsEieuTEmWNw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VkE1RmZqc3F4M0tJMTFvVzREdEsyWmxBcUdNZUF4SG03b0NiWnJmUEwxM08x?=
 =?utf-8?B?aWpST2wvamk0bVFKVkhKRytGY1JlVXhKY0pySEJkWHZCTXFCMmZIemxBOStM?=
 =?utf-8?B?Q3J6eWl1K3p1Z2FrTTl1ZTFZVnVxek9LK2d6eWVTVy9ISzZTWkducVV6dGNU?=
 =?utf-8?B?M2hFL1ZwRnQwOWhqTXdJL1lQNHN2cldPNWVUcEdjeHhnbmpBRkRsYk00OWdm?=
 =?utf-8?B?dlRHeUIxVW1sTzR3QXV0M1JNZEFVd2UwMmJNbmRLSTZacnVYVzhpcHVxYnRM?=
 =?utf-8?B?Z0lROUZzcUVVRmFwNVM2RUNTUVVYK0lXVm0xV1VSc2pLN0JsWEJmcFB0MzRB?=
 =?utf-8?B?Y0JZdzJubkxwNlFiRmVTdWYycEZjMkRkRDYvUEc2bGR4bkYzZ003OHNqL1Uz?=
 =?utf-8?B?RkI2ODNHQ3NIaXNmSGZmNXJqa2N4UWlXUVBHRVJoQ1l6ZUxWSk8xR2JKdWFn?=
 =?utf-8?B?SytyaWw0UHRmQW05NytXbCtuNk50RHYrSUxiRFp0OWZSZS92UDM2UnV3aEh2?=
 =?utf-8?B?UFFCNWhzT0JVVGNJZm1uUk8xRExWZmYyemkzSWxBcUdJaE53MzJPSERTbERo?=
 =?utf-8?B?YVVWbFRTWkF0VjdMRHhuWjVmUSsvcUpISk5Nam5tYUJleStRaVlMa0xHbnBp?=
 =?utf-8?B?WFgvd3VsK2d2N3JlTmtiaVhXSGhyTlNTZVVnVEVGa2VFVmgvaE9jRytSY3hO?=
 =?utf-8?B?Slk3VUpIYy9XZFVYclBwV2ZDY0E5WkFSRDlHcnY3ZjVOekMyMFY0RGpZL3N3?=
 =?utf-8?B?bWpVQ2t5dyswOS9ieEFXM21wU09jM2FqRW8xQ1JYR21IRk1RSHhtZ3RtVHAr?=
 =?utf-8?B?dXRHVnFJSlBTZkVURGMwcXprM05tYWZnbFRTbjRQRlVYSW1SQnplQ1lIMjVr?=
 =?utf-8?B?Z1IwSmhmT2lGOEp3T1h1N01pYk4wbFFhQnlYWnJ3b3hpdWxPb0RRVGdEcmdo?=
 =?utf-8?B?WHhGb0FEYkpIM1MxT3NxUUtFWUE0YjZvbTFDdkJqWGRickhuVnZ2TVhUOXNW?=
 =?utf-8?B?NjAzVHhvSEZzaWJibXYvdkdDRE43YnlxNk9pL253VEtDb2JHT0p0N2ZPTnJp?=
 =?utf-8?B?K2RQczZXSlVVbld6bnFRT0ZpMWhGZVVXRHJlUnkrV1RiUHcvU1R1cEpvczRu?=
 =?utf-8?B?Tmp6OGNDWmo3Q3NOR2VxOTJFdngyTDNaWlpyNStIZHBPb253Tmk5M1RBaGto?=
 =?utf-8?B?VFdZSzBGYjEzK2FOdmdNeWlkaWw2NXZ2cVUzamJFMCtBSllXSmxjanZuWTRU?=
 =?utf-8?B?YTJGQjl4by9JamNGVzhYWFE4cDR4ZnprU1FORVkvSFAzWU4zc2ZLV2UxSURQ?=
 =?utf-8?B?bjVxcGcweHlaZkhDalBEdmpSUmpoa25NdDFLS3Q3ellFZjVuTnArTUllZks5?=
 =?utf-8?B?dVRVRjFIa21sRjQ0Q251SUJzWmtZZUxVL1Z4S0lIZ1dKdHR0aUFXREtlZjNZ?=
 =?utf-8?B?cmhwT3V4ZHZaWFpOSnNablUxOUgxNnJ0NGJ3NWdKNWtkR2hBRERWYk9GMmhv?=
 =?utf-8?B?WWpSY2xxd0RnNHMxbjZuNHpSOHNLMDNHSkt3WWZRcklCWm9taGNhUi9jQVJK?=
 =?utf-8?B?NWpNSkxOTkZBd3hIQlFTVklvNjFOeTRnQVNKYldLVHBscGtueDRSWjlBR2pu?=
 =?utf-8?B?RkZsRVVOUzlXUnZ2U1lIMzJ1VCtNcDRYc3dMRHdhLzUzYVMwT2E4VW5HMmpW?=
 =?utf-8?B?TSs5STB6RUVLYUFLRU82TTVhdzBKYjdQbFNZWFlQM1Y3TlJBemRtcGE2a0Za?=
 =?utf-8?B?SHJlS2xuYzRlRlZyUFJRMkM0RmRWSjNMYnRRUG5wbnMzRmtsdVlrSUxsVFYv?=
 =?utf-8?B?d1NLWmpyN2M1WlFENkJJZnNOVFpwSmh1R2xXVHp6elliTzZKMllWekJxRmlO?=
 =?utf-8?B?SjBuNnZIR2M0ZU9zeUx1N2FIV1ZQYWpUcG5JNXZrV3JLOVhoQmkvVW9KM2t5?=
 =?utf-8?B?anZSZDdVdVBTcUlIL0lxa0c4QzJaa29oblhiVmNZTXF2VkY5K3lnWGZNS2ow?=
 =?utf-8?B?Q0ptZjZzSENXbUVCRjFFcm9aTFRXWk9HZUhYNEx5SUVGcVpsWnB6S0RLc3Ba?=
 =?utf-8?B?WC9oNHVsanR5TEtEMG9LWGI3alZqNXVGVmR5dHoraDk4a3NqbXIzWm5pazlr?=
 =?utf-8?B?eHZseVprOTY4VWdXV3lmZ0xJS0N0OEVVNTZQRXBoYng0ODU0NmQ5bDVFc0dV?=
 =?utf-8?B?dUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4485939-6910-467e-65c8-08dcff2c43a2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 13:01:15.9783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tk6RjQv2RcpNqkNQ9ziyzumQuvZb/xHDCAHlX+WhET8/WohMHF+zCPB/vMm3mwaoLYjKXEojKQlHdl0OJ/QuGGBpWynt8FFVeSUehX4STCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7661
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Nov 2024 13:01:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17220



On 11/7/24 13:53, Jan Kiszka wrote:
> On 07.11.24 13:33, Quirin Gylstorff wrote:
>>
>>
>> On 11/7/24 13:17, Jan Kiszka wrote:
>>> On 07.11.24 13:11, Jan Kiszka wrote:
>>>> On 07.11.24 12:30, Quirin Gylstorff wrote:
>>>>>
>>>>>
>>>>> On 11/7/24 11:57, Jan Kiszka wrote:
>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>
>>>>>> Under the assumption that future versions of Debian will deliver us
>>>>>> the
>>>>>> needed versions of SWUpdate, this eases to opt-in for self-building.
>>>>>>
>>>>> Do we need some additional logic for SWU_SIGNED = 0? As swupdate from
>>>>> trixie requires signed updates?
>>>>
>>>> You mean we must enforce SWU_SIGNED = 1 from trixie onward?
>>>>
>>>
>>> ... or do you rather mean we should switch back to self-building if
>>> someone selected SWU_SIGNED = 0? The latter comes with the risk that
>>> self-building for >= trixie could quickly become untested and start to
>>> silently break.
>> I think documenting it would be enough as SWU_SIGNED = 1 is already the
>> default. If you want to deactivate signing you would need to set
>> SWU_SIGNED = 0 and activate self-building.
> 
> But what should be documented? These are just the technical steps. If
> those are not part of any test set, things will eventually break - in
> the best case already when trying to build.
> 
> I'm rather inclined to deny self-building on >bookworm until we have a
> concrete need and cover that via testing as well.

I concur with deactivating the self-building >bookworm.
Quirin
> 
> Jan
> 


