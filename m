Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA6BC282D0
	for <webhook@archiver.kernel.org>; Tue,  4 Mar 2025 09:01:22 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.89])
 by mx.groups.io with SMTP id smtpd.web11.18106.1741078874422747015
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Mar 2025 01:01:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Xe3VaQdb;
 spf=pass (domain: siemens.com, ip: 40.107.241.89, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIE0K7dP709jW9IYrZ01pzapOEPqk3klIbjTLyij+7r/mKfvIRDsYS9qohmtCerSp/H08uA7E2+hKSRjNjxq0CWX78+wz3yeDoRQVjotlzVOyU6Jgx4QT6HA/MtpVrm0haq7w2lKQLgzG91cu1KmVBeGib/GucNgDyL6O7r8I/o2epCEuA2L5bN0t7D9FUbcjBsJDkYbWUV4hojSfeFm61QSoKxTwJZ6AlVnpveKYI+2P1zdrC2YLhFfSWILfMaBK227z5Sn1LifUD0vhJahCLM3+BETR8pUze7rHL0GZkmLs/LyvMNlBAd7g3AmOPb4kSUKFQ0ZmGxPoUaA50QuUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iasHPvbQUsOLcm7l/eAxtwVmWcG4Qs/vBayZhsE1Ks0=;
 b=ivI9hf7o5zkaQvnMseKm9uEDuvZQY8YxOqIbMBJMdI3Gb0BjoL/kSSvgrzaSqSL1UZlqa0jcG3MSeYmw2/wivVXTJ+RBerVcgTw1g2357ZIz/oDFPnNauGSHKKBbdeiR4I+d+Ac4gmBbKaB4gi225BeyKITSClFsOtQBG7Bg8xqF1udG+dEIPxRcXjTomdQj6QT+b/YMee58Z+SvUCElL0SV34k3I0o9d+cb/6U8v6pevGoaAYy4R+/if9Mvh3M/h46rpFujR1keU8aUlFFpaezZzpruPU+nmcrNfj1MWjz5qWmIYirTU8HEofYsy3oAfoY7QnQJvMdIQsrfAKHGuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iasHPvbQUsOLcm7l/eAxtwVmWcG4Qs/vBayZhsE1Ks0=;
 b=Xe3VaQdbbaL4cC1AdZP3lV+iMMhW9Ir8ajCSNX+bWEETyvP2ncgaDNB7CS4fdUYpoDB94wNY+u5ceR1tmoC0pk4Jq80VKD0N3VdDAqKoqSEv1A8cEU72zfgems1A7KCvsxDQ9hkcPxU/g5S1ilAL4jXEtAK5rjz58bAx/UZZWQpDCk7PcBP6TqyQGUWbRYrWAN221k+pG8P7uI/BL/Ly05QrAYv+vJwCdHnOLep9c2zTOIEmco6x1X8BITk/tC9SaW5R9+KvbhF0nCyU7+AjZ++xb/C891fDajDuigxFSVA8eRJs4e/KaKWwaKoc/rirs1pJpD2hQZeedvdmYah0tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB9PR10MB7411.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:460::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 09:01:10 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 09:01:10 +0000
Message-ID: <c8219ab4-167f-4d58-8cd3-ab8ea119349d@siemens.com>
Date: Tue, 4 Mar 2025 10:01:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 4/4] Move content of home to
 IMMUTABLE_DATA_DIR
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com, ludwig.nussel@siemens.com
References: <20250303112342.851020-1-Quirin.Gylstorff@siemens.com>
 <20250303112342.851020-5-Quirin.Gylstorff@siemens.com>
 <0ca20183-6884-400a-a53e-73f74fd8dd9b@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <0ca20183-6884-400a-a53e-73f74fd8dd9b@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::13) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB9PR10MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ff17f2-4f53-461c-cc74-08dd5afb1b70
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bTJRSWxvS3BqcVlTbWFwbTJlNEJqN1ZBUjZPREFSQ3pEQjlZMm1vRkl2WnN6?=
 =?utf-8?B?QTRWc3N2MlZSMk45a3c1elV1QkFDYSszOExqUGZKNzNFeEVVWEROVHhOdmhX?=
 =?utf-8?B?dDVuTkkyYjFUUzJYMkRWN1N5R1Nuc1B1SVZWMW5WYXA1QlJDaUJ3R0NIbzJw?=
 =?utf-8?B?SHBWelNLYmtZeW1JZFdNLys5Y1NNdnovTFowYkxsb20xTk92ZmNudzFERFJI?=
 =?utf-8?B?aWxiRVVKdEZrMkltRTZITDM0WEVFWGhzTmhmdWkzaVcybmJJR2R4MmZ1bk9J?=
 =?utf-8?B?TXBrclhuNEd3UmpuL1pNZGprdS8vVnNYTWFib2d1dDN6ZlY0OEJoMzlvQ0hn?=
 =?utf-8?B?NlpXc2dWYWY4cWY4by9WMldiYVN0cUJsT3VNdXhIVnBiTXRPUGh2d2VFN0t3?=
 =?utf-8?B?b1NDZ3lEVnc3WllJL203Z1hFWFhLb1Z5VkhUZGhnV2hFWnRCVTRxR0ZSWTBO?=
 =?utf-8?B?QTM2cEdXcm03dTQzR3liNHIrbjJkM01IYVRJTXpiM3lEemN1aFpUTFpET29M?=
 =?utf-8?B?c2o3d0ZONEdxMUdiL21QMVdLR2h2cXdYb1h4R01wWFhlaVBFOWtqYlVUcCtP?=
 =?utf-8?B?cnhVODZjMzVrbURVbWt1b2JTYVNpenZlbEZRVUdIVFZaR3lkZ2ZjYkdaVVkr?=
 =?utf-8?B?U3hiWWc3djNqTG5zYURlQ0YwSm84a3hRQVY2QUM2YklRZ2IyRm8vMGJSMWRW?=
 =?utf-8?B?NkZOV25ITG5KT0dtQWxiNTFKSm1CNWtGR2lyRmUwSVFyeStOMXFCTVlNbXRX?=
 =?utf-8?B?REpqMkw1ODQ0Tjdtd1RlVTBQSlBjb1E5M3ZQMWVBUkJYWTFsZ2EyNFBDNmpz?=
 =?utf-8?B?QjhaZGZ3MDlpRSt5N1Uybm9WQmx3bGxlRXh2Sk5VUkd0eFRleXpGdE1mTkFO?=
 =?utf-8?B?Lyt4alowdWtkTll0OEFRUVVvRUFxRDlmbWxNeWdDWWZ6VmdaTGV0UjdySTlr?=
 =?utf-8?B?Mm5xOXM4d05SMDlPcnFNdk9FLzFjRnUvRVFsMnM2Qzl4Rk0yTjd0Y0ZxVVZp?=
 =?utf-8?B?TExjaXdkbEJiS0VBeEF4ZU4wcFhsWkhGN01rSEpJaFFDK09DcmxQU21qNnly?=
 =?utf-8?B?MlB5Z096TkFIbTUxS2d6WGRyUk10Nm9PZnI2VmIyNlYwdEwxeUZvZTljcnVm?=
 =?utf-8?B?ekZQUjZ6Y0IrQ2VSSW5IUXFZdWRPWHR4VlNESnp0bjFINGJpV2FyWWdTamox?=
 =?utf-8?B?dTluVWNjTHp4Mng0WDMvelYrWG5IM2cwRTVabDF3NVAzcFpWV0tGVDhsTWcx?=
 =?utf-8?B?MXdtNWZ4UWhXbnpkU1U1OW1TRVdGMDJacDhPSUVlamwzOFJYc09kNjVpR0Rv?=
 =?utf-8?B?UVZwUVJ3N2U4bHZxK25Sd2s0ZDhrUk0wbUdTR0gxUXNsMVhENXR0MGpvWEZ0?=
 =?utf-8?B?NXl2R3hnd0lQTzVjTCs1bnpQVFR0c2VXNWU4RTFET243Mnd2cXVqM3BSOXNn?=
 =?utf-8?B?dE9PcjI4ZU1uWnNrWWRjUk1NQnhIUUpHazhnWnFKN0lrMWVmbmRyam1EN3lu?=
 =?utf-8?B?MVJWaWcwUzdxOG83S3Yzb1hpWkp1YjVJbFpzSHRFK29vdHJydjRzb21hQ3g0?=
 =?utf-8?B?VnRCVVpyakpkUmNJN1JwU0NlejBTNTkzVm5oelhyc3RDVFIxWjh5VDBqZGFR?=
 =?utf-8?B?YURRQW1ZWUFOM0JYQWtPb2hrdFNUeXhwc1luRTFza2VHMXVqS2RtZnkzV2VU?=
 =?utf-8?B?MzVibE5SSkJrSi9ELzlNY2RaZk9EODFVNVhla05KT2Nqa2ZHVFJYMVQ4N1hz?=
 =?utf-8?B?eDJSU25XUzkzUGdaem9wb3E1Vm8rN3NWVWVBTjVycEMvUlptUFZtR0RIYnNo?=
 =?utf-8?B?b3ZyRmFva1F6dHZEalU4V09zTW5MNTB1WkE0czh3Q3g1ZDRmK0hCT3dZYm96?=
 =?utf-8?Q?F4TMIHJlQ7YVn?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dVRlVVI5S2pXcFNsbGpwVkpzT0JhbHVLcXBlbU84OHowWU41TXhWaWJpUTBI?=
 =?utf-8?B?cHFMSHpLZXBRRHk2blg3WGdtcE0vL3NjZjd2ZE1pY0VnSlFnbFB1NmcxN1ds?=
 =?utf-8?B?UjdJemJVeHVHemFlMVk3Ky9uNmUyeUl1dUxUcUV5UVRRMUo4dmowYm9McUZU?=
 =?utf-8?B?UmJWaSs4ci9URVJCWndVR051UTFtMmo5anJ4VFBSWnBMMEhERTRaQzg3UGZ1?=
 =?utf-8?B?a1lLbjBNRnpQV2NrSUZJdlIwcERmUW84cnFOcnJKSDFTYUsxSXRNaTl1UU9u?=
 =?utf-8?B?SktONFNLS3NkTFlLUDNIa2t2Q05hbVBUcUxhV1BnVHBTeTZvYm05NGliN0dQ?=
 =?utf-8?B?RGxSTHlYZWdPOWp3ZEJ0bmZsREc1dGZuTzBZcE1NNEVldVZxdXRvVHRJOUw1?=
 =?utf-8?B?Tnc2QTN4K3BmaTBobm0yMm1pOHNnOVBqRWs0UzNLWmNKMU4yQlNIT04rRnI5?=
 =?utf-8?B?bE9BV3VMY3o4WUxlc0hLTHRPVnZSb2E0eEh6UUdWcVgvV2pKNTJ4dnh1alF2?=
 =?utf-8?B?bWMyQlA1c1E3L0J0Q3ZUaDlYNVJuNnBmMzIxOHlIbHlqeWZwa2MyZWJvUFRz?=
 =?utf-8?B?ZTBNMWdxR0gzQmFSNkVONTArdXpFZFlrSVhUQnpKUER5SXFxUzIwdmY0OVFC?=
 =?utf-8?B?dVI1dFRyMUlIUUJaVnFwb3V1VGM1K1dOeGM3emdvKytrQ2RzOWNEL2lBQVJQ?=
 =?utf-8?B?Z2h6Zy9QVmI4cFZTTWFMcGgrZlA3ZDVjYlZzVVNMY012T2N0MW13ZFd4bGFr?=
 =?utf-8?B?MUdUT2xYTVBxNlFKZ2NZdkpYTUdzZktTNFFjV0tVaFJ2b1RmTDVaQmllNENh?=
 =?utf-8?B?cmZ3TUNTangyNDNwa0hGcXYzV2crOHJpeFJTOW80N01oSlZPVk03Q0dlV1hy?=
 =?utf-8?B?RU1WUUJwMFVRMURQV3pwYXNGdXFKVnJReExzU2YvcDFDcVJHZ2VhaktqU1dq?=
 =?utf-8?B?YjY3YXM5WXMvTWw1RmU3VGVmZlR6TmM1OHZ6elBEenFGTkxudENBdUN6Z2JH?=
 =?utf-8?B?cWZxRXdtbXZkU2V1REVyY2NiRDA0OWhVcGhlTmtOWkpSV2RNMEtaVXpjMFJP?=
 =?utf-8?B?S3VXekJKNlByenNzeWFHdzNUaWJ0TGJjcVBuOGJnTDdqMTJCQzJQa3g4MFBh?=
 =?utf-8?B?WHg0SCtpbHBTOW84MmZONWUwckFvSkgzNG03azQ2VXNtSHFuR3dtb1YzTmFM?=
 =?utf-8?B?MGQreWNZTGQ1cyt3bXFKSFB6ZGVVM2w4UnMwblltZUZCWGtHTWt0UnNId0hX?=
 =?utf-8?B?Nmw4VlYzL0ZsUkJqN2Y3Z0xWKzBtWTdHUk1saWJpMEM5S3k3WTg5c01takxn?=
 =?utf-8?B?NFVzOUFtN0QrT1lTcDlhak1kRlJkNndoOUZOdnJDd0YwUFQrNTFTWDBwQlk0?=
 =?utf-8?B?cGJSVGtvR0w2U3VacUY4TkN1MFJWTU9rZlFOSWZ5YUZYSm9nckhwM053eHRi?=
 =?utf-8?B?OFFzZTRycm50cm9KYlh5ZDhGUklCdHhBTjFhNm55ekdpSWFGRThKcklxYzB1?=
 =?utf-8?B?cXNOWFZlT0VNcUpPS0wvYzdvdVZVR1o3dGJLSklOb2pINGpXMVFOdFNkVDA5?=
 =?utf-8?B?YUNZOXQxZ0kxSTNITDh0QmZDa1M1cnQzK0VBZ01JazFhR0dvL3lSRG1xc2Q2?=
 =?utf-8?B?T2JJNTB0QjljMUhKOHNMSjlPUVhmOHR2T0dUTFA5Z05HdW1rYTZkdjIyYWxo?=
 =?utf-8?B?WEErS2pSNkh6QVVudU5PR2pKNVFQNHYxTzkzZzJTT1ZGUVdNeHBFMEtJSThp?=
 =?utf-8?B?bThTbVRyeWpOMmlTazlISHN4VXo5RHhnVk9OTUxmVDNLSkx3c29Fa1h2bXAy?=
 =?utf-8?B?T3JRdHNsMTFQem5na1NsZ3RIVHRhR0dCdFN5L3k5RWJlZkVjYjFhWnFjL2tE?=
 =?utf-8?B?ekRVSHd0b09xRmNJdEt4QWtBRkZxcmlJT0l4U3dnT1piY0p1c29ZMGNJM3hO?=
 =?utf-8?B?cGYwcXdzMm8vVlFiUXpzY012ZGlwbG5mbHo4Y0QzV0dWVnpyRDlQVXZkenp1?=
 =?utf-8?B?TFlOdnhXVCs4d2ZkSkcwVnoyalNxenBKQ0hDanp2S20wUCtEMzk1VWJEbnVN?=
 =?utf-8?B?a2FySGltQWpHOHludnVmM0VibXdINjN6VzZYaEhQbXZ5aUFvTkx4cTQvSXpx?=
 =?utf-8?B?d3NENXlCeDgzRTFxT01WMGp2WWVmTmxZUTVlQVZtaVh2OUM0NHpKcFZESDc1?=
 =?utf-8?B?MVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ff17f2-4f53-461c-cc74-08dd5afb1b70
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 09:01:10.1915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17T+LHRO4Bfy+ejEkqVDVzJTNyd4bs1UCcpWRreR+a0pWWqi8sH/beH234qa8BaDmLyZI63yj8bLRqrD6x549/ho4rgeKySAWsNHdvZkpNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7411
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Mar 2025 09:01:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18011



On 3/3/25 13:29, Jan Kiszka wrote:
> On 03.03.25 12:21, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This reduces the amount of necessary partitions. It also
>> allows to use a A/B-update scheme for the var partition.
>>
>> This fixes issue #123.
>>
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/123
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   classes/read-only-rootfs.bbclass              | 19 +++++++++++++++--
>>   kas/opt/encrypt-all.yml                       |  2 +-
>>   kas/opt/separate-home-partition.yml           | 21 +++++++++++++++++++
>>   ...ook_0.6.bb => initramfs-crypt-hook_0.7.bb} |  2 +-
>>   4 files changed, 40 insertions(+), 4 deletions(-)
>>   create mode 100644 kas/opt/separate-home-partition.yml
>>   rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.6.bb => initramfs-crypt-hook_0.7.bb} (98%)
>>
>> diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
>> index 0c8ae24..4e70d81 100644
>> --- a/classes/read-only-rootfs.bbclass
>> +++ b/classes/read-only-rootfs.bbclass
>> @@ -14,8 +14,12 @@ INITRD_IMAGE = "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
>>   
>>   do_image_wic[depends] += "${INITRAMFS_RECIPE}:do_build"
>>   
>> -IMAGE_INSTALL += "home-fs"
>> -WIC_HOME_PARTITION = "part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f-3448-46dc-9c0f-58904f369524"
>> +WIC_HOME_PARTITION:separate-home-part = "part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f-3448-46dc-9c0f-58904f369524"
>> +
>> +WIC_HOME_PARTITION = ""
>> +IMAGE_INSTALL += " move-homedir-var"
>> +IMAGE_INSTALL:append:separate-home-part = " home-fs"
>> +IMAGE_INSTALL:remove:separate-home-part = " move-homedir-var"
>>   
>>   IMAGE_INSTALL:append:buster   = " tmp-fs"
>>   IMAGE_INSTALL:append:bullseye = " tmp-fs"
>> @@ -37,6 +41,17 @@ copy_dpkg_state() {
>>       sudo cp -a ${ROOTFSDIR}/var/lib/dpkg "$IMMUTABLE_VAR_LIB/"
>>   }
>>   
>> +ROOTFS_POSTPROCESS_COMMAND:append = " copy_home_to_immutable_data"
>> +ROOTFS_POSTPROCESS_COMMAND:remove:separate-home-part = " copy_home_to_immutable_data"
>> +copy_home_to_immutable_data() {
>> +    IMMUTABLE_HOME_DIR="${ROOTFSDIR}${IMMUTABLE_DATA_DIR}/"
>> +    sudo mkdir -p "$IMMUTABLE_HOME_DIR"
>> +    sudo mv ${ROOTFSDIR}/home "$IMMUTABLE_HOME_DIR/"
>> +    # as the rootfs is read-only we need to create the link
>> +    # between /var/home and /home during creation.
>> +    sudo chroot ${IMAGE_ROOTFS} ln -s /var/home /home
>> +}
>> +
>>   RO_ROOTFS_EXCLUDE_DIRS ??= ""
>>   EROFS_EXCLUDE_DIRS = "${RO_ROOTFS_EXCLUDE_DIRS}"
>>   SQUASHFS_EXCLUDE_DIRS = "${RO_ROOTFS_EXCLUDE_DIRS}"
>> diff --git a/kas/opt/encrypt-all.yml b/kas/opt/encrypt-all.yml
>> index b6d4041..faf7206 100644
>> --- a/kas/opt/encrypt-all.yml
>> +++ b/kas/opt/encrypt-all.yml
>> @@ -20,4 +20,4 @@ local_conf_header:
>>       # As we use a weak default assignment in the intramfs-crypt-hook recipe we need
>>       # to set all partitions
>>       CRYPT_PARTITIONS = "${ABROOTFS_PART_UUID_A}::reencrypt ${ABROOTFS_PART_UUID_B}::reencrypt \
>> -                         home:/home:reencrypt var:/var:reencrypt"
>> +                         var:/var:reencrypt"
>> diff --git a/kas/opt/separate-home-partition.yml b/kas/opt/separate-home-partition.yml
>> new file mode 100644
>> index 0000000..aaf349b
>> --- /dev/null
>> +++ b/kas/opt/separate-home-partition.yml
>> @@ -0,0 +1,21 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2025
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +# This kas file adds swupdate and generates a ${IMAGE_NAME}.swu
>> +# from the first wic partition
> 
> Copy & pasted?
> 
> May explain that this primarily provides compatibility support for
> existing deployments with separate home partitions.
>
Added in v3.


> And where is this used, at least build-tested in CI?


I can add an additional option to the ci and/or add a Kconfig entry.

Which build jobs should enable that legacy feature. Currently I have it 
enable for `build:x86-uefi-secure-boot:`.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/9302304512

Quirin
> 
> Jan
> 
>> +
>> +header:
>> +  version: 14
>> +
>> +local_conf_header:
>> +  separate-home-partition: |
>> +    OVERRIDES .= ":separate-home-part"
>> +  add-home-partition-to-crypt: |
>> +    CRYPT_PARTITIONS:append:separate-home-part = " home:/home:reencrypt"
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
>> similarity index 98%
>> rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
>> rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
>> index df335c9..80a4755 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
>> @@ -70,7 +70,7 @@ SRC_URI += "file://encrypt_partition.env.tmpl \
>>               file://pwquality.conf"
>>   
>>   # CRYPT_PARTITIONS elements are <partition-label>:<mountpoint>:<reencrypt or format>[:expand]
>> -CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
>> +CRYPT_PARTITIONS ??= "var:/var:reencrypt"
>>   # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to create the filesystem
>>   # in a newly formatted LUKS Partition
>>   CRYPT_CREATE_FILE_SYSTEM_CMD ??= "/usr/sbin/mke2fs -t ext4"
> 


