Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F45DC369D3
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 08:14:37 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.76])
 by mx.groups.io with SMTP id smtpd.web11.42936.1745827718552185162
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Apr 2025 01:08:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=r0NsMzfh;
 spf=pass (domain: siemens.com, ip: 40.107.241.76, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrkhHJDRzODDItuyLh/cBaHs2Kgs15aXGbo4vOUh4aWFTFYyAVRjnwuMOQX5XgwRJq8HrZMg2MysPDdEz6jk+7RByTozB3LkpldazYtrEXfeK9fHelHVL5syvWW6p8D7tc2IutCgm/T5vUZKKZz6nARzEduA5J60uUIT2uhud5iSCjI6UhsLqsA+EXG2ZPMBm0GhzgjUO2kjiEpAx8+BUiqmG8j3N9RQc4UYyqmjrtU2fQm7zfnRUKDHQ10kDwTdp1Y+hK+zBevXTq0HW/rv03yrpafwDxFZz4VLZcu1MqynhvpMw/EKZYSRMjn/cjRvJnoxq95X0QZvvDnnnyERew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOh19B93z6nq3CN7QQoyqD/381gMNB51Rl79ZCmREQ4=;
 b=G2KR9i29gjlm2LNbGFB/kbU07VVC5IrsJzq48Z8HT0fBNCcPldSOhNGT5W9MLmDaaEeSl5M+qZgNteX+RHu7CYWoZKJMB6xRlf0Qlz2FxJFuB49qQuPMggB1CC+xWutJmC1Njsob6SfoqdVGYZnviJaJGfTr+HVwm3L0IGfhtPFnV4rhRW1iVyuw6vJ8iwIvIQ7OpVs1IezxDv961PANld8VPifQ+WKfbL+vp3ivAqZH4WdSSNhMEoz/asGBzEok2wq4gTIZNNZeVOzdfrLeLKixvHD23dpzoye2SCKSCgYWyt6TnjLCQgmTR1UEUxuyibfETyHECHsDLTGdnIEYDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOh19B93z6nq3CN7QQoyqD/381gMNB51Rl79ZCmREQ4=;
 b=r0NsMzfhW40yb99br/HMmmmt38sz7DSwsqqQ1kerdz7vj56uWJaCJ31qDNaG2xppMdUtwnTGsVxiA6tZaBtN0ee7P1XScbBnzMep/S3iq5QguNEQn5sVuCXinLiazFnzyWAYmHi+/66VvBSU5xQmGfD4HZBq2iyQ+A+YYpcN7mIFlo3TEfqKZf0WkOJbx39qBfGKuUi9ZgvKOTIL/+4VNHQanIKOjcpVrgqYEKYjxJUEXdw7MTroT30pj4IuI9Emyf9k1bS30V2z6Og/C+y3E4C3V+RhMU2qCdyjSyHFsJUlN03qeOAkpjsEdWjTq1nRsC1IYsx1u1uTEEXRWVqZtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB4PR10MB7038.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 08:08:33 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%2]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 08:08:33 +0000
Message-ID: <fa23f634-bfa9-4aa3-8699-a9a83ea59ca3@siemens.com>
Date: Mon, 28 Apr 2025 10:08:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC v2 0/5] Use kernel commandline for
To: Jan Kiszka <jan.kiszka@siemens.com>,
 "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20250422145055.1095348-1-Quirin.Gylstorff@siemens.com>
 <95e952da10ed1a0f98eb69a32eeaf4ca239076af.camel@siemens.com>
 <46f5d079-c362-445a-b73d-beb5ed9fbd21@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <46f5d079-c362-445a-b73d-beb5ed9fbd21@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0449.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::9) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB4PR10MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 525b6ab6-12e8-44bc-709f-08dd862bde6c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?K0pnU1BwdFllbVhmdkxUaitmdENkOHpIUzdFcUlHMU9SeWZDNytBU3dOd2F3?=
 =?utf-8?B?akdINlMvTC9iUkg2TTI1NFNCWmNLRGVFNWVWNzdPTU8zKzNtYVZ6dyt2NFM3?=
 =?utf-8?B?YzRUSTljZHRvbmVCRUdPdlE4cXo2UUZNbFpUUXlTNzRSZ0NBNFZTU3Z3MGFy?=
 =?utf-8?B?U1RQcGhFYTFydzR1bjFOQUs5MWNhVVZpWmRWV2VOb3F0a3p6a25VYVp0Y2du?=
 =?utf-8?B?clhzMVd3N1Uxelduc0t1L21TdlRFc1lZVDZYMjhwdGx0RmhCQmFWMTZuYzRn?=
 =?utf-8?B?UlNJT0NsZmlDSVFkVHdvYjNGTzk0eTBSZzc2WC9rTjdqcm14bHZ5UnY4aGI0?=
 =?utf-8?B?MFVBL1lMS1ZQU0JhT2ZSWmFvaFBJYjYvYUpsQi9OV254R2Y1VzFnanV4T05K?=
 =?utf-8?B?NUdOaEZsa2V5MVgrVnp0eE4vMDkzZlhJWWpMQUIwd1JHaC83endvM1hJV0lN?=
 =?utf-8?B?YjFvTXFRYUh2YWczNm1OemQ2NHlhaTlQMmFRc3JSOVpRYUFwbWxiRDE1MTZn?=
 =?utf-8?B?M1BYL3JxWVFhM3M0NjhLQTdEYXFJbTFOTDBzUkI0anlpeXFtY1RpYmxFUTVt?=
 =?utf-8?B?U09Ma1JkazNIK2cxdGZ2TkpTQlVvWjByMHdPNzcrWEV1ZmhwWUl4Y0U0OE9O?=
 =?utf-8?B?aC9iNXNzQTN0Snk3ZzFCZEd0eFN3MG5uL3dGcFJNTlpPUTFXT1BGMWRWQTlB?=
 =?utf-8?B?TTZTRkJpb0FzOHFpT0RnTW9MWnRBMmNjb0RnUnoxMGhGMUhvR2hxV1RxOUNW?=
 =?utf-8?B?eU1jZnZPQ0h3ZmozSEsrSFlCcHBsdVNZOUdzeUdHZ2ZLWTYwNDlnNmlWaitP?=
 =?utf-8?B?VThadmN2OWFwUUdTL2Y1by85UFpLSUJJa2s0S3JXMEVVdEcvc3ZjbE45Yktt?=
 =?utf-8?B?VXFsYlRVSmxlV3llU2xEYU5wK2RQSzI0RVptdXVBbjB6aGxsdS9zN2ZpRDhr?=
 =?utf-8?B?QTVoRlJPWStmbUFzcDh1QlMrMWFrdzhsRVdqdzJ4SzRKQnpFMFRtdUtmcWN6?=
 =?utf-8?B?TXY4VkF2M3FEQ3FFTEQzVEZBa1VmMi9yZzNMcVBGSW13K1hhbnJzc01aUnk0?=
 =?utf-8?B?TUZlcFI4ZGhqcUxSbHI0WTR3ZHExSzBuZEFPOWxsMjUvc2FBUVYwVTdvS0VH?=
 =?utf-8?B?aURwRjdwSWZFMlVOVEdMSU1rdTU1bTJXKzFkRVJwa2IzWDc3RytJb0dlVWdz?=
 =?utf-8?B?VHBUN0dtbE9hbjd3RUhiQTRJcHkvaGh1TFUwYkg4NWt4aDZPaVVCd1ZBM1ZE?=
 =?utf-8?B?emwyc3BWMU5vVWFQYXJPUEdJMlZva1k4b2xhYlZoUUR3Z24wcGFZcXgxbllP?=
 =?utf-8?B?VzZFK2MwNFJQZlhianhpekVKNUVxN3puejBPRXN1Y1hUNTZvaWs2Z2hGQThZ?=
 =?utf-8?B?VmZRd2UvWlQyRXd2Q3Z3WEhhekg1NlVnNnBNcXZlYS93cmJ2N1ZzS0FSU3Fa?=
 =?utf-8?B?RFpDRmxMQUtNbGlkTjdWdUNxeUFqNzEyZ01GUFdrWXNYOTVtc2tLd2lEOGVz?=
 =?utf-8?B?SG0za2tqNXcvbk5Fb3lnNExWUndoeStxc1EzSnNqcHRSS3FBamJURXpMOXI4?=
 =?utf-8?B?ektKNndYNVdLbEdWRG5UUDcrN2NmSnB3ZmxLY1BYUVJLRGI2aFl6V3RsdGZQ?=
 =?utf-8?B?dEdwdll4WG1SL0NlSzdqV3hCbzEyN1JGRUlrT04wUVdLM092ZlZyTkpMcGcy?=
 =?utf-8?B?WnhydFdLZW9sOHFmZXJzOHA2RGE5aW5UMk5XclM1Zm9ld0hjZEx0dGMwbkJ6?=
 =?utf-8?B?bkZCZ3ZkbldaQ1YxdEo1UmNvcU15Y2F3Q1M2TW05OWJpTHkreVNxMnVwRTNh?=
 =?utf-8?B?WjZ3cVB1ME1QNkJGVDVEQ2FoZFhYamx0d3FYenFvZXJOMmg3Yll3RnhKbEhT?=
 =?utf-8?B?dCtaa2JUVFVTeVlPL0VsT1U0MXE4aVZ4cHJhbGU2Q3VZV2ZnMVZwM1JWaDli?=
 =?utf-8?Q?NAsWBbk9GU4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QWJUQlJEK0dLbGx2d3NhR05QWlRoWEpzcytjY1lKZ2dwbEpyVUw3QnRGRDlD?=
 =?utf-8?B?dzlyVHFmMGNrd1RSSWtTQjY2bk1VTTU3TTVnUVo3OVdRRnB0MWVtczV6OVIr?=
 =?utf-8?B?N0FONitqS3gwUXN4bEN2aFRSS2NRalVjZ3E0K0M5Y2w5NVlvbmhZN1Vla0pK?=
 =?utf-8?B?SUNtS0lZUTNuVHdJNUFESmZnN216dVFQYTVFTGFwMUV6clZTQWNycXNQem1H?=
 =?utf-8?B?Z2ZGSDBLR0JaWXBtNi9MSG15UVgxUzE4dmVoeFdMK1FKTzdBUXR6ODZZUGdC?=
 =?utf-8?B?Q2hmb25CR3h6OFBsamx0TlBRcjlnZmlBMWgvZEs3SklNZ2xlZWFXQkNPa3Ay?=
 =?utf-8?B?ZGMyQUJKNXZHRitHblA3NDVHTERpTSs2T2JXYi80cU5FTi9aUkRobVVsd3Q3?=
 =?utf-8?B?SGI1dUJXSzl0WVRBakNvazRNL3lTeFgwTkZSZzY0RmtGakFRTlF2dDJwNXRD?=
 =?utf-8?B?Q1NIelREOVNwUUdUaC9XclBpMTRSNjIwVGhic1NTMTVzV1I1VlM5RjR0blJM?=
 =?utf-8?B?MWdOWlZlWXZxS2UrVDcwZHkwVjdyc05za0dNeGxLR1BpOUgyS1krV1k1dEZv?=
 =?utf-8?B?elN3OUxlYUpSU1pwQ2pMTndKZWpZdzBMOTM4ZjdqLzRvY2hONVYyaUV1c1R4?=
 =?utf-8?B?T0s3RjFENDViS2tCZFlRWlFWZmN0Q2gzMGY2YXJLT0tyOXhuOU1FeXRpNHNx?=
 =?utf-8?B?eGhuaUdIVS9LVkJMbkl3NEtra1VXNzJrRFc1Y2laYmFDRnlIUWhCYmMxaVpw?=
 =?utf-8?B?d3J6bXdsejRLUitBbTNOQjM3QjJBYXVxRGVmc0I1RHNGaXJQd2haZ29FUWM0?=
 =?utf-8?B?VmNOUFo4RDJEa0I0azJaWm9XTzI4aXBFak82WUlzeXRUKzdiY1VnOXhGenVs?=
 =?utf-8?B?S3dLVDNyODdEcUo5d2xvRmRMSjRHRXRuakp1YVM5cXRvTGxXSHgvR3VDbE1C?=
 =?utf-8?B?aG9hRTZ0UzkvakdkNFhFMW5RZkpKUEVBbWlZZm9xUkt0aWswVWV6WE5QWFU4?=
 =?utf-8?B?UzRSUEVOUEk5NkJJbHpmNVNWOFJDcktOVml3aEZ1RVVNV3VRNVRlK1owRTZC?=
 =?utf-8?B?ckRYK2tsUHNDTmk3QWt6U042dnNPNG1BOWxtZit4aTFUdm1vT3E1VEFKNmVZ?=
 =?utf-8?B?dGllcngwZ2xoUkorNFljUnFDS2VFTkI4aDN0RVNaQWhNTVdYZjZMWkxaL3ky?=
 =?utf-8?B?RnBsMTlkaUtSTUhhVWIrc3ByZzNQejJRYWxnbmZLSUl6WTJGaXJCeDhVK0tC?=
 =?utf-8?B?WkhhOGdoYkVIRVpTTGdXcVMzZFZqYnhLRG9SVU5jV1RITUVROEhVaXk3UjJi?=
 =?utf-8?B?d09aZ0Vwa2pYNzlZY0I4bjJ6TjlWV1BVNlFWZzlwc0R4VEZ1UWkwUmFQUVhi?=
 =?utf-8?B?WTVCMWgyU002VS9oYlVHaitTcmNWcFRPeXdHTDFGZ1FyakFVY0pobzFyWGkz?=
 =?utf-8?B?U1hrdlBSUlg1Y051RTdOVlBIak5RWEN2L2ZxSUg3SXUzVjhGK1hZaXZnenZk?=
 =?utf-8?B?S3EzcVN4MGVtUW1TWWRwMlFLQis4dkY0Nm0xUThXa2oxRFBXcGtISUhWekZw?=
 =?utf-8?B?NWJUTUtQS3FhVzBYTFhPRzg1dEVlWWd1eGlXaEJzaGRsZXozeHRwY1ZPU3c3?=
 =?utf-8?B?VDU3OUluOC9iMVRmREJWL3dCUTFRVkViRkVsNVRsTkk0dU43TWpQT1MwYzlO?=
 =?utf-8?B?Rm9vT2RWWTl6eUNmYmJ5UVJKZEJsTG95ZGNQd1I4NVY3bytHUlBaQVlkM09M?=
 =?utf-8?B?dnVYdXh1enJMOUtLU3hLNjk4c3hDbUhJTlBBLzdwcDNaL1d0Vk1RT29oNzBL?=
 =?utf-8?B?QUxMMEs3TVlQbndnMTJyZmNBN0NsVkRCTVpwZGZzR0xodE14clZ0cERUOUFJ?=
 =?utf-8?B?bGtPdlZKZVdBZFR0SDh1UUN3NS9kb2tPSlluS0FEMFFGaVBWcEkxclA2eDho?=
 =?utf-8?B?SmR5dkVJN2wvNG9PTHh5NmJnWVArWE13djZpTk1ycWp5QU5NQjR2aVlYTE4v?=
 =?utf-8?B?QjYwUTJFallkc1R4Y2tQL0FaVjRMeUE4T0RFODBpNnQ1R0NCZklVdCtTTkxQ?=
 =?utf-8?B?bWZPUEV2bTdUUjFPVy95OEZpUGJQN1NsVUxIY2ZWcGhiWi9lZmJvTU9mZXUr?=
 =?utf-8?B?aDRwcVlDak5wWFhldDA4ZzRhSDMvWmVWeGFhcjJINGFmU1cxK1kvazNNeGFU?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525b6ab6-12e8-44bc-709f-08dd862bde6c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 08:08:33.1853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8T5l2I/mNLfEmal06Tmx7K9fHRywyWx4DKkmS6wH3h0Wkq8bVH69Ec9pVGiKzd70yFkVoLfUSo9hVaTocmTQRXE7HOgnAkScr2ciwyye/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7038
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 08:14:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18689



On 4/28/25 09:06, Jan Kiszka wrote:
> On 25.04.25 10:01, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
>> On Tue, 2025-04-22 at 16:35 +0200, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> Take Felix work and add the missing abrootfs recipe.
>>
>> Hi Quirin, thanks for taking over.
>>
>> I tested this on the new A/B rootfs MTDA image and can confirm that it
>> works. I did not test verity or crypt, though.
>>
>> It also makes the initrds sstate cacheable with is a huge benefit and
>> also solves the issue with broken verity hashes due to non binary
>> reproducible root filesystems.
>>
> 
> Looks good to me as well. But some code unification between patch 1 and
> 3 would be highly appreciated.

Will do that.

Quirin
> 
> Jan
> 


