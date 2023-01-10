Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17320C46467
	for <webhook@archiver.kernel.org>; Tue, 10 Jan 2023 19:01:45 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.52])
 by mx.groups.io with SMTP id smtpd.web10.2165.1673377301636128098
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Jan 2023 11:01:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ACXfz1rE;
 spf=pass (domain: siemens.com, ip: 40.107.20.52, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNlNNclPtkVgmBOyRiNRyNj/Fj36Oq2w3wAcE7RaafLKML3LAkCZFylY/j5kmCY8N0HiMiy7fzZxURjUfkr9VtopGi6X2w5asYrXNQdOjzN+Lh9XqdMG/NjeZciMbGu+Aobba/tKohjHU4tmpLJu83y+xncLsEpfSdcDEnpgxzd+80DdbxZicV/kYCczyZOc4Gt9VgFV1ySNfsCj4W9pc5QsGzShuezTdMMK2T921oRZjHyKS6lx78/QeJLOmYmRPnZwc7S8DZRKd1ujso0HUWRCZNsIphZX2P4oSq0Mrr8C+qyyPF61cAOP5ozM5EJIM76j49F0IjS1lqQA+tWGjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SEhwrC64DeBuB6CuXNJcVYKBB94Z3vBE3t6C3R6iXA=;
 b=AfJMNhi0a3MnRyKRcH5gtPEhb9lrHFTtUgJUZc1AvSpxLigFWe46w3zTaYDXMmvLrHzIKTZs71eRYUrZapyEhzDbIvZjmj3mKsl4stNsk/hab1d5fgIjQugaGmkGKWgZyii8Czaqy+LK/7x/HMuBUvqDQnVAYWwlqSVG8bnXosodyKvZ7S2+238tK5qpENkSMjbVPA9QbBmam8iV8jA91fEaSdZHN765xrR8jBNY9E6bmDanGC8MjhJ8jYjZToXSwS8fQ1+dH0bDcyVowFEzDSIHPMofBMI7yPaqs0YLYHVMuANdGIP2ofOwSGZ3EClNkpdeqmPajUGgOPn5KR/3DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SEhwrC64DeBuB6CuXNJcVYKBB94Z3vBE3t6C3R6iXA=;
 b=ACXfz1rEMaD4fmEu4uLDuquylx8q3tcKL11mNf1MNdB0oDNX6fog8bINZfB6iZbAi3Kzjku7ELHaCyjzCxIZu61Ma6drmG6qtyS2VGzAj7Z88TUIv2at32VMu8Ezs/qp8GszA231mL4A8i1KvMq3PggKnv0LmgnAE+iElKxYNBPgUvJdKHZrTbNUfOqQ6UZfpSpGeHHD4KCEFlT+cIfAVyHrgS/zv93X9wPUK362EFFNOm5+/4hOL9rW/VJpWyeMDo/BgavQ/BvhfFCB+RzHQiZAHPj5pfXwcAQ2mFrQKBBAXfH2yd2tHrtBLel4zfa0FebyOAf3J7EuSIeKzm83mQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS8PR10MB7969.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:569::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 19:01:39 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::793f:57e:21e9:3741]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::793f:57e:21e9:3741%3]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 19:01:39 +0000
Message-ID: <dcc2133a-68f5-352c-138d-bb5e5ae86569@siemens.com>
Date: Tue, 10 Jan 2023 20:01:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] Create a generic initramfs
 overlay
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com
References: <20230110120055.463166-1-Quirin.Gylstorff@siemens.com>
 <308b3247-d201-317d-e3dc-ebf8edec817c@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <308b3247-d201-317d-e3dc-ebf8edec817c@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::14) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS8PR10MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: d11a86ae-277b-4366-8f57-08daf33d1a6c
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tyg9mCmeYxw+KKf4iTnU8st1OAeSog62HigICTwTKDUvghRwMtoQb5J64ZNUWRKvchmPLb5G2pt74Kp9v9PbdGmGU2GaJy+tK3086JfUDACa2ubTesBmFS76zFjNtqeDTevDcKEhwcsXj6xHkcbCmQ6jZ/Mq7rq/ntOr9kGww/yGOSd1vblvKQ2VhPe9HzUV6kTLriTAntoJ1hQ6x6Mye3+9NJtyQZ9YFfHkfiBRj3EYzcMhQlG0UsoQ42/g12iaQajdwaUvIKYg9VsFuvD+M6lOwKSV4LsK0xRdt8sgqZEIDA9YhRI34rfi7GZSGMHCMXfq9aF5VVj4iXpPZpKIFzBsJPFgIN8CTjytzZRRb0uJncAkRrP0Y5qeRsA0LER+IebNDZ8v0M6Ibsr5XksTeVzo2eVQJseOx01xquSKh3oO90QuHWC9sHPsV8VEVWmMQFWd49T5yxT6E1GwOG4n1moYd2q/TC+y2x4yScet48YJicEaHuWEanLdH+wsr+U34V83GYahzKO1gT6PfP5J991YC8EplwxGY3owLkwoBISEfDR0YCATQMSt5c4OKSAJ6lu0ehX0WM1O1dtmMggpBlc+3LvhdkZDRf0FXsv9Au5UZLMrPnhpLPxdp8J4/E0qZtRWK5MNmLiRkf0+OK57/TolHxZygdGTGURKo0ziqzB8zH8glZANLSMhjz/XcFFhLL1ueHL6aqcNtgP0N7i170EO6vGHwpDuRfvH/LQpTfKeZ+/lZ5UX2C6OPSaO8Ieu
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199015)(36756003)(186003)(6636002)(6666004)(53546011)(8936002)(31686004)(6512007)(6506007)(2616005)(36916002)(66946007)(5660300002)(66556008)(66476007)(316002)(86362001)(31696002)(38100700002)(82960400001)(478600001)(6486002)(41300700001)(8676002)(83380400001)(2906002)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RWkwMjFjUTFkOFYwQitpdHExazJQUll3TlovMDdaNGNjZ3grUzJQS0tMZkZE?=
 =?utf-8?B?WE1sVXk3clBZN0szWW1TMWxnbkFDV1BUR2dTTVBRRm9oeG51NG01bXY1ZVZF?=
 =?utf-8?B?dXM5YUZ6MDVaY0s3MW5HNWZTTndwWm02ZDJRYXRiNHczRGZKY2RwdmNIcU1p?=
 =?utf-8?B?MnlhZ3QzRU9iR3E5YzFMVlBMQ2dCNWlXb0JLVENnVmEvNmE5U2x1RU9aKzdl?=
 =?utf-8?B?bzFIV3pLbXJidyt1VDEzYnovU3NvVjdGb3djaFZTcE83Sk92YlZHZXplRHlv?=
 =?utf-8?B?Z1Y3bWNDcUhDM0tnWFY2eXRoNGZHQWEyWkxaWVpIb0FYZFUzbVVYb0IzTEtp?=
 =?utf-8?B?UHl5N2dNU3dsdFhVYnN4eWRacGg4RHBlZnRKSHhuclZSVjRKejJucDFTN2Nh?=
 =?utf-8?B?a0M0MEQ4VUd3czl0OGVRTEtlTjk3aHI1bWxGMnBwd3I3T25KSVVxSURlMlN0?=
 =?utf-8?B?N1d0aEF1OW5GcXQzNXc3UmVveXJzQmJWUGhZNFFtS0JCQjg0eEFMY1J6ZlUz?=
 =?utf-8?B?OU41TmhzZDdNZ0dJamw1UWkvWEkyK2pSQlFsQkQrcE03UEJNc1BZT2UrVnU2?=
 =?utf-8?B?NDdGdGpyQmkvTi9YS3FUb1pNSW03blY2dnJDcmFzbmwrckFrMXR6N2hSRlVZ?=
 =?utf-8?B?RlIrQUN6TDRTWlpxYklLaEk5QTJYNXlOWDhra1BFd3pQWk84NENpNnZVcXlO?=
 =?utf-8?B?a0E1K0FESk9FK0RrRldDbnJmUmpIZkFreFlSK2dNWWxHQUNqaGV2YUpvcVpu?=
 =?utf-8?B?aHlJNy9TOXBYWnlmYVVUMjZmcHJMMTNBVHJYZnIzNFYrN2ZYQzV4Z1ZKSk9Q?=
 =?utf-8?B?b1htRXJOSmlBUlo1Yk9vZ1lNeUdzaUFiSmV1aHpQOFpyVmVKVm1mZmFQV1Rp?=
 =?utf-8?B?Rk56dzdPTXhnVkNGNlhjQkxxLzk5S295eEMyUE05VlF3bDBMUEd5R085OEVj?=
 =?utf-8?B?d3FUL3V5clJIclVvbGN4RElFUXpjMlNObHAzS1kxT05tYU9HRUxvYnoxTzUw?=
 =?utf-8?B?cDZoYmw3Qkc3L3VQVUt3NnRJVWJTZElHaWI3bkwzOXhObGFlNndEMzJQZDZS?=
 =?utf-8?B?WDVaMlZLV3d3c0lpWExxL1dhTCtLd2FOQVFkR3ptY1dTc2NwVzVMRTUvMlIx?=
 =?utf-8?B?dUxlYWw2Q2dnMHNGQ0RHWnh5elFwSGZlbjhMNVRzTHU2c2dQNS9IWXhRMnY5?=
 =?utf-8?B?S0xFOGZKODFoUGVVQStyU2Nua1pLeFRES0M0NFRFQlZ0R09zWjVXTWxLT0JY?=
 =?utf-8?B?SkRneVBQQk4xRGRiVm84MktrcjJyZTdEMFJ3aERkdVdLK2FrY2Qvb0ZNcmZo?=
 =?utf-8?B?amNBOWxBY2dRWUFOL09VZk1yU3k3N1M2THZVVTRUNyt2OGhwUE5jM2JRNmM2?=
 =?utf-8?B?NnAzbm05aFJqR2t5cmtObjdZRmd1SXFNMGpFWnladzZzQTNSZmZra1VYOExw?=
 =?utf-8?B?MW1pRk1KY2VldDVSdTZ5elFBRXBaUTVQYnNGVElYYVpFbWs4YnNFYmpiOGNO?=
 =?utf-8?B?bW9XSkRWNCtTNU9BbEtNU3NwSlBIbXdRSWN4cmUrRVBrWEtJcENJTUpRV3Vz?=
 =?utf-8?B?bHFPWXhlNCt6Vitmc0NNc2QxT092UWdyaytqSlpOb1NCTjdUZlNrU3NEUkJS?=
 =?utf-8?B?d2RXcE9OMXZVZmVqU1FTMUlXNkxNYWFtSm4yM2szOFJKVGJ6SkpuWXN3NW9S?=
 =?utf-8?B?UDhTMkxaUSsvZnVtNVZ5L0tZekFWcXVQeW45NnR2MlZUWjRueHZuOUorWG4x?=
 =?utf-8?B?eC9HaXk1Q1RMbktFeGlza2F4Z1dlOFJKWElGQlhob0phZDN2QzdPcitIRlYr?=
 =?utf-8?B?RFA2cE9udW5xeTZkaDBpT01pNlF3ZlBVSlpjUEczKzRhMmxxdDc5YXZHQ3k1?=
 =?utf-8?B?YWhSbmZPK2hPVFp6SlQ3YU1xdDA5TDdIR2gzL3BUWVFjMmc4dUQ5S21qOVdV?=
 =?utf-8?B?VUJNOHF0VUFyOEpGTlJheE9xeDJXNVU4cktYTGp5L2lEZWEwREJkOVVNb0pm?=
 =?utf-8?B?OEJ0VjBpVE01Z3g4ZjFBSS9CWGF2bEVsTzZEbUVwcDFNT09UNEhjaHBrcFpG?=
 =?utf-8?B?eGxud3ZUYlVBSUdHRXg3L3lwODJSR1RHSk5xLzdzeGRhK25WdGcyYlVQSWxj?=
 =?utf-8?B?b2dwcHFHdlV1ekFBeTdIZVBTZUNmbHQ3WDNUQzVBd1FTQ0U1bHlVa0J4Z3Rj?=
 =?utf-8?B?THhUVTAxUHJzSktnaGpvVW5YNy8xekVpcTkxL2pFdm02aHZaQXZab1Y3SWVp?=
 =?utf-8?Q?Wcj3lQmLBpkqja8YnLyH09/hoKO3FU972/U8uhphto=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11a86ae-277b-4366-8f57-08daf33d1a6c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 19:01:38.9941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3bDXRJYJzaRFmmT9PKCgP6uSpq8MJR/GBN7vHbssEFXMEYvQLivTYTQ/8ZNm1NZSdm6h5IaiXCXOh0PhYG26I4l7W6w9wVYkNEqNmjqis8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7969
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Jan 2023 19:01:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10338



On 1/10/23 17:38, Jan Kiszka wrote:
> On 10.01.23 13:00, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This allows the user to generate multiple overlays in a given
>> location.
>>
>> The configuration used the following variables:
>>   - INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL: Label of the partition to store the overlays
>>   - INITRAMFS_OVERLAY_PATHS: space-separated list of overlay directories (lower overlay directories)
>>   - INITRAMFS_OVERLAY_STORAGE_PATH: path on the storage partition where the upper directory is stored
>>
>> e.g.:
>> ```
>> INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL ??= "var"
>> INITRAMFS_OVERLAY_PATHS ??= "etc"
>> INITRAMFS_OVERLAY_STORAGE_PATH ??= "/var/local"
>> ```
>> This will create an overlay for `/etc` and store it in `/var/local/etc`.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>
>> Changes v2:
>>   - INITRAMFS_OVERLAY_STORAGE_PATH contains the full path
>>   - updated copyright
>>   - formatting
>>   - fix typos in commit message
> 
> Could you also explain why my other suggestions are not feasible or
> reasonable? I would still prefer 2 over 3 variables, if possible.

I can add the 2 variable version but in my option this makes the 
configuration harder to understand. As the script tries to mount
a partition which is not mentioned before.

> Jan
> 
Quirin

