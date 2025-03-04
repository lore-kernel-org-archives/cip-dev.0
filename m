Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08544C282D2
	for <webhook@archiver.kernel.org>; Tue,  4 Mar 2025 15:10:36 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.57])
 by mx.groups.io with SMTP id smtpd.web11.24039.1741101026548668290
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Mar 2025 07:10:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=D24o0ppO;
 spf=pass (domain: siemens.com, ip: 52.101.66.57, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmBQxnAC7av+XSgCR/q5NYpHWuweM6lMYpLc4DQv98YyHvc+L7012kZ6IDF+wONLrbQThKw+P37Vq4JWoUWX9nyZqwz/jSwCQpFHwAoMK5G/Vqc8dlecGA8LTD6wwGuCmS3A47oxpqk9APd27S7wLEDJG2NxhN4wP6cc5R1G/Kw1RpsCXDHUadNYMiqO4uxVEPQXvKJT4ibzt1hXV21N3Trcpfif3CuKKZsEfeGf31JjC2LN7zDzvrVqw132x7qu0d85l7gmHE0P0iXo94f3kWVbma61y5UOD43E2q9oC4vAKRKdMPB26j0AcMym3KHG6qOrLRBweVrnRL2x2kn0UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIY1xOKzIJvjRRICi0knSP04Zm3oYUTV8XEkmo0RQP8=;
 b=LX4PaxOuuJD1ms+44twz742/YBBW7yeBffTX58mIo1FjqY8ekpGZgZSPMiqingjY0NV4sxuuWnQ2U2ECmJTfx8nBkPgHM9HnJ5PlAZrKTXCpP9KeeQDbp2AjlBUlXJi94oSKQsMmFdNTzUganQRQUUOtR3ZH547e9lG3g4U2IhH4uJ0lQn4QhtoHiRUIZzsv6kMjvJyDewL/DgwhQ9Zx2ilwNvDGOVPHSMJNFBekPGURvTlPOoR0GbBqChSBeHvuw6GkoQicnwXNHUDyPU9j+Jlz+RbGObESGCucsoWzNW6hGjtElkYxjPhjh6TalnaN/OuEA/Nll+CUzyb4okqlDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIY1xOKzIJvjRRICi0knSP04Zm3oYUTV8XEkmo0RQP8=;
 b=D24o0ppOrWKsoCQ20N9uWTpJFGbsoUlW/PfcuygOYC7eKN95TyEZu72nU5xMXRobMRXd8WqRUhX9zzYjMEsbND+Jc3BUd8FJjlUbZx6F0A/7LpDbKw/6AKj7KCTGI5AWeeQ7od68Ua2kH0+JVVrAi7IvWDvubMlHGkXHcTQgRGIwx0nXKnfQw+5VrkaXJhZLI34PWitw5zmm4GpEpVN7pRxNZ5X+EDM3qr6r+tXtvEFTdDB58zo+/yqSVf/KzMmIlNGy7dafC6LvmRewPl3YqQ5iSFwIClmSTQlUm6bcVK4P7HEBDLrn7H5Wjs7Q79xPsBQwNMvQrWxiQLMqv2NIvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by VI1PR10MB7691.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 15:10:23 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 15:10:23 +0000
Message-ID: <24d1b6ba-f774-4616-9c1f-6de0b555932a@siemens.com>
Date: Tue, 4 Mar 2025 16:10:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] initramfs-crypt-hook: add re-encryption recovery
To: Jan Kiszka <jan.kiszka@siemens.com>, Claudius Heine <ch@denx.de>,
 cip-dev@lists.cip-project.org
References: <20250304130743.2812183-1-ch@denx.de>
 <20250304130743.2812183-5-ch@denx.de>
 <3d4d80f3-64c0-4d2c-aa32-f4987f370eed@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <3d4d80f3-64c0-4d2c-aa32-f4987f370eed@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::19) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|VI1PR10MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e5d198-fb1e-4981-a457-08dd5b2eafde
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aHpibW52ZjRlNklPTjcwMW9LRjUzMFFwL3JZeVZSTnkxMklndmVrVUcvZHFZ?=
 =?utf-8?B?Y2hHNlFJKy9FUU1ETGVaNEw1MmMyNUJBUlBVUzJDNDB1b3g2dXJpZG1GK3lL?=
 =?utf-8?B?eGhPMXZxbVhOQWFCYlorb2U3SlljQm16WXpSSStMdWx5NXkyUlFURS9mZVIy?=
 =?utf-8?B?ZndzVEVuaUo3S0tvc3pIMEZaRC8weDErUlB2QTUxYXlzSG4yM0dSYzBqSW85?=
 =?utf-8?B?cFdvYW9qTS95VzlEQXNMdjZiMGFLNVp2M1h3WEx6MXZoeFF1YVJxYUZEU25T?=
 =?utf-8?B?YWU0a1ZLZHBpc1diZklEaDdvUHNpWFdGZmd2YWcxWnEyMkRjVGZ3cm5SRUUw?=
 =?utf-8?B?VFo2S29NOHo3QlJ0QmIydlQ5TTFTcUxoMVB2dUE5SzhtVmJkbjJiblFSbzVj?=
 =?utf-8?B?WDhaaG1OV1J6aDh0VkR1NXRGbmxpYWRKODZBSmVVM1BiWlhBM0N4UUZoTWF0?=
 =?utf-8?B?RFgyVkVibnRBS2FZMi9Ec0ZTOFNpUTBIYXVUU1RGaTNvN3Z6NWp0LzhhcVpJ?=
 =?utf-8?B?N3N1RXZBSFFVUnc2cUNuVitQaFN2SlBjVUI1aGp1QjV1QjNDZkt2bW0wWDcy?=
 =?utf-8?B?dzYwdnoraTEyQVE0cysrVXRDMllPaFFndUJwc0VVT1llWVU0cUxCK0dlTFRi?=
 =?utf-8?B?S3B6emJBeVVqRFlwMjhibVh2bGxwRkZETUNSeTdRL0plOEJOb09aZ2tiU1R3?=
 =?utf-8?B?d3ROdDVzeGtmOS9SRzVTZGZiYkljNDVJVVNaa3lRUkxscTF2c3V2YlpPMWFm?=
 =?utf-8?B?KzBTYm16WUZsclIxTFQycTM2eDhwWDdKcTRVYXVMNWdXMnI4a3hSTFNTbzZL?=
 =?utf-8?B?WGpFTXRXc0J2WGZRM1AyMklsV1h1TjhReW9vUURBOUV2T1NpL0JNR09PZzU3?=
 =?utf-8?B?aUhWdGUvVm5wT2d6cjhhOXhPL1RicWFKeU1IaHc4UktQKzBzcmFIQnBQakFo?=
 =?utf-8?B?TU5LaUFJWSt4eVVKN3Nmb0ZMQUVoTTFwMTYzKzFwTHF5Sm5mNzlDTE9MMVhZ?=
 =?utf-8?B?aHEwYUVZeHlPNE9PUEpXT3l2K1BUanB5Q21Vcy90bHFqL2Y5QXBZcjA0OXY2?=
 =?utf-8?B?WnVMd1pralJzRWk3eEh6UGxnWUxJcU53bXJiaXloK0ZTbU51OVg3UFBoSUxM?=
 =?utf-8?B?enErNHRMQW9kTVlWYVZvTmZBM3VJeExTRWxxTERKcnUvMFZEYjdjTjYycVpo?=
 =?utf-8?B?ZS9ERTkwdzRIZWJJbTFNYzkrTllzN1VwMEhMcTFpS3FsU3Rpd2pwU3VBZUhZ?=
 =?utf-8?B?MllHVjlndXdGVWFJbXlIQnI0NFV3bXFSS0ViS2prWGlHdzlHZUkyUWcxZmhW?=
 =?utf-8?B?ODRlaURVY2FWZ1NDZVZXU2I0WnozR2pyNFlFQ2xiQW92NmljZnp1Sjd2Y1dO?=
 =?utf-8?B?NEcwNHltNHdZNmpoazJ1cmFNblNZT21JdHdYRmpTd1BrdTZaMzZLbFhQUnNy?=
 =?utf-8?B?MDhwdkV6cnptd055Q1hTYUtvYXhtNS9KbGU3b1JwOGFtUGRRWDNzMU9xWlAr?=
 =?utf-8?B?QTRSMGVSeis2Z29KQUVjdW1PTG1tNm1sV0gvZWZPcnJZN0tJditKOEIvWjE2?=
 =?utf-8?B?M2tzWlMreE13bjU2c0VQdXI4UGRVTHNOaVEzMHNnOFFZS2V2NmtoNW8xMldB?=
 =?utf-8?B?NDJ2SUtqeUkreURNTW1halI3SDBvQkU0K1NrOHRFQVVzT2czWm1tekhaZ09q?=
 =?utf-8?B?ODAxcUw2ZEkxZTZnaG5Ea01QS2xJK1hXa05zeVkrUFRvN1BsdkRCQ0owU1BN?=
 =?utf-8?B?NWNNNkg5Q2kveU1qTmVjdW8ycUZVUERjdDNSWlRlUWYxcGhQTE13Qi9ZWW14?=
 =?utf-8?B?RTV0WkNDODZyTC9vclgvaHNLRVNtM3NuZVFQQ1JIbEFpbXNKRmpMWFBFNmpQ?=
 =?utf-8?Q?4IIirKZ4ve/1z?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?anpCakYvbGZvcVJnYzgrTXVQZzQ5MlJIQndDak01NXdwWlZ6c1lESmNtd05n?=
 =?utf-8?B?Q29uMDBib3IrTVRXMDRGY2N1SVZidUJTc29FY1BYYkI1L0RNWDdTUWZuTGlJ?=
 =?utf-8?B?R0t3Q2VucGI0bjhJeVM2N05kVVpEMHBQZnBZN3FZNkZyMGJTT0JHMmNKSDlJ?=
 =?utf-8?B?QWorb3ZpOHZLM0dQckRxclRyc1Raa09VUHNidTRYWWRJR090TmhNcWhaUkVH?=
 =?utf-8?B?V1g0cGIvWDMxYVBtRVliUEFHQzJBUTNQdHZ0QjhISG1ZS3NIcU1yZGhxL3ZQ?=
 =?utf-8?B?Tk9tN2pYZ094MjZ2emt2NGRTeWlac1FyanNFaCtvdU16OXp6WmxjeVhYR0NK?=
 =?utf-8?B?aEsyREt4RDNtVWVaU1UyRHMwaE82aFMxb1p2TTdDdm01NEltTGJUN2JKWUpm?=
 =?utf-8?B?REtGL3NzOHhtcGhaYVJSZ0d3cmpnRXVSd2prYkNTOWFwVk1ac3B6M0JxZ2NL?=
 =?utf-8?B?eE1VZEJhdmxKT2k2RHJML0F6dU1MdDFoSEVyNldjY0pKOHNzRVB3NU1WazBZ?=
 =?utf-8?B?ZUw5S3cwb1pHNVdHRExNckhPcS9BNVBrbXFhRGRXNFRrQWV4clpObUtIWDVM?=
 =?utf-8?B?VGE2aWZyWkhEbHNkMWxNWkcxd2JNYjRMVGJhajM1TjdSVHJlUGtraGJEKytm?=
 =?utf-8?B?Q0Z2cmd4dGRuVzNvdVFHc3RCU0JYTU0wa2ZVQ3RkN3RxRWhjM21mbkVvQk9C?=
 =?utf-8?B?K09ZOE9IcCtyYzJZSGcvdTQ5TGc2TlFyajhnTjF6cVlvUG9jRDdYNm9TNEVC?=
 =?utf-8?B?UlVLUmhWaUljOWN0bCtHd1lPSjlhU1plSkN5QW5pZm9KT2tnUlNiTjFuWHI3?=
 =?utf-8?B?VTEzYjBzV0dQOUVjdlFjTG1Vbm5aaUx2QXZEV0VSb0l3ZDJTOWUvYTBiUktv?=
 =?utf-8?B?WVorK0FqeWdHV1d0OEpHTkJLeXFCZkNuZThQUXJyTXFLNDhZdWdCdlBrNmZq?=
 =?utf-8?B?cE1EQk9GWTNwczZjdnFCTEtlaXpmUVRMNVBQNGVkTVVjOExvNDNNdVFzRUlQ?=
 =?utf-8?B?TXg5alFlckFvdGxFeXllWnNteWMraXg5TDVTM29NaDFFalBNcXZmOUQ4TzRl?=
 =?utf-8?B?SDJZUVgrL28vZVk1U1BBVnhhMVdIUUxvV3lIQzZXQUExYTJnK2pTRHNiZWMw?=
 =?utf-8?B?ZDV1ckZla05DbUduc0lyd2xuV2lBbEtEVVNQUHh0QzJTSFhHUCtwZCsrMFhr?=
 =?utf-8?B?blI3OUNudGFSTlV6bE4xR3lGODc3ZGFiMDlzZlc3TTg4MXdXL1Vxekc0TU1L?=
 =?utf-8?B?V01QWEJ4bEJ1Z2t6ZHoyS1pJNzNSL1prWTF1RWYvT3JCcVFSUTVrNThmMnhY?=
 =?utf-8?B?VndiSHpXNkxPaEJ6SmVFaFEraXpZU2hkWktFeVRwaFNaOWtlTEJxMU9MdFAz?=
 =?utf-8?B?RGdaL3BLc1Z1cFBVdi8xZXduQlRDa1ZUTStWcThOMnR2Q3lpdHBmR2hYQk5Q?=
 =?utf-8?B?YWFUY1NZblBnTm0vbWdxRGhWVllqZXVZUHAwa3ZvbDBKNzRiRUVTOFhkV0JX?=
 =?utf-8?B?dkR6MVRlb1h5SVcrUTFoaTJUZ00yaitUQjAvbDBia2Y4WTR5QS94TXBvSmc5?=
 =?utf-8?B?VTlWaGt0SmR5Wnh4ZFNLelVsdWRSMXN4aGJGSEdjbE9QY3ZjN0VJU3hPbnJV?=
 =?utf-8?B?ZE1PUTMzbG5EaDNEUEJkV1pZM09rY2w2RzUzbWxiejJTY2tlZ1dwL1kzekVG?=
 =?utf-8?B?ZjNaNWo2NXNOaVlhc3k2R2ZldzVaUDRSM29ibGt4ZUFkNnEzdDRUVjg4Q09x?=
 =?utf-8?B?V1lHemhMdUJHZFVyV3lXOFdUMElqNU5kQmphTTFuSURoNDkvN09QSnpheE05?=
 =?utf-8?B?b1p3TkpUZ1NEZVZMbjdsM0pPUS9pMVZZMkpWbXFBVmd6cGRPL3dFYjh0K252?=
 =?utf-8?B?Qm9UaEFDSzhReGc1bHdIMzdKVWZHRW5QdjhCQnpNYzY0VFl0M3lxeFp5WVND?=
 =?utf-8?B?RGVyL09vUTNkR2dTWmVBOUZnK0NSQ1RlNUtpZkozWExwTGlhcUlvUi8xeVEv?=
 =?utf-8?B?S2lpV3dxd3NRQ25aNlpqd200MzdReVdRNjBENS9GMXdpM3U4bmNvM0I4c0ht?=
 =?utf-8?B?bmg3RWVpZTRrQkZyTGczZUNaV1lTSEx6bHRnTVYxcElxVDRNZ3B2bEpTblhz?=
 =?utf-8?B?WE41MEZIcHBzNnhxSXZ1a1ZzMVFyOXNpejg4bldKcG40bGdqR0FsQ0V6VHdJ?=
 =?utf-8?B?dHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e5d198-fb1e-4981-a457-08dd5b2eafde
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:10:23.6561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DncLZd1htGnIPtSvkLIEkaD5Gg/3BY3bibHLhgXH/2aJwbmPwx9qicKPgRBOoo4eR7ZhN1kIHAdrJeeWJ5eoRxHH/uYmzBReF+fHQax3ydU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7691
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Mar 2025 15:10:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18022



On 3/4/25 15:52, Jan Kiszka wrote:
> On 04.03.25 14:07, Claudius Heine wrote:
>> Integrate detection and recovery of power failures while a partition is
>> being encrypted.
>>
> 
> Why is this at the end of the series? It can already help the existing
> implementation during encrypt-on-first-boot.
> 
>> There are possible scenarios:
>> 1. Power-fail happens while the partition is reencrypted:
>>    - The LUKS header contains `online-reencrypt-v2` and needs to be
>>      repaired with `cryptsetup repair` before it can continue.
>>    - Also no resizing of the file system is necessary
>> 2. Power-fail happens before the systemd-tpm2/clevis token can be installed
>>    - The LUKS header does not contain 'systemd-tpm2'/'clevis', thus it
>>      needs to be registered and the temporary encryption key needs to be
>>      removed
>>
>> In both scenarios the system after the reboot needs to have access to
>> the temporary encryption key that was initially used. So using a random
>> one, generated via `openssl rand` is not possible. Since it is only a
>> temporary key and gets removed after the systemd-tpm2/clevis token was
>> installed, a known password can be used.
>>
>> The list of these scenarios is not complete, there might be other
>> instances where a sudden power-fail could be fatal to the system, but
>> these where the most obvious and risky ones.
> 
> For recovery of the first boot, this might be enough. But when proposing
> this for in-field recovery, we should be stricter with thinking the
> details through. If we fix them, immediately or later (or never if
> unfixable) is on a different page.
> 
>>
>> Signed-off-by: Claudius Heine <ch@denx.de>
>> ---
>>   .../files/local-top-complete                  | 33 +++++++++++++++----
>>   .../initramfs-crypt-hook_0.6.bb               |  5 ++-
>>   2 files changed, 29 insertions(+), 9 deletions(-)
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> index 47533b5..e67f26f 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> @@ -72,6 +72,9 @@ reencrypt_existing_partition() {
>>   	reduced_size="$(expr "$part_size_blocks" - 65536 )"
>>   	reduced_size_in_byte="$(expr "$reduced_size" \* 512)"
>>   	reduced_size_in_kb="$(expr "$reduced_size_in_byte" / 1024)K"
>> +
>> +	CRYPTSETUP_PARAMS="--reduce-device-size ${reduce_device_size}k"
>> +
>>   	case $partition_fstype in
>>   	ext*)
>>   		# reduce the filesystem and partition by 32M to fit the LUKS header
>> @@ -90,14 +93,25 @@ reencrypt_existing_partition() {
>>   	squashfs|swap|erofs|"")
>>   		[ "$debug" = "y" ] && echo "skip disk resize as it is not supported or unnecessary for fstype: '$partition_fstype'"
>>   		;;
>> +	luks)
>> +		# Check if reencrypt was aborted
>> +		if /usr/sbin/cryptsetup luksDump --batch-mode "$1" \
>> +				| grep -q "online-reencrypt-v2"; then
>> +			/usr/sbin/cryptsetup repair --batch-mode "$1" < "$2" || \
>> +				panic "cryptsetup repair was not successful"
>> +		fi
>> +
>> +		# already luks partition, don't resize
>> +		CRYPTSETUP_PARAMS=""
>> +		;;
>>   	*)
>>   		panic "cannot resize partition, unsupported fstype: '$partition_fstype'"
>>   		;;
>>   	esac
>>   	if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
>> -		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k "$1" < "$2"
>> +		/usr/sbin/cryptsetup-reencrypt --new ${CRYPTSETUP_PARAMS} "$1" < "$2"
>>   	else
>> -		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k "$1" < "$2"
>> +		/usr/sbin/cryptsetup reencrypt --encrypt ${CRYPTSETUP_PARAMS} "$1" < "$2"
>>   	fi
>>   }
>>   
>> @@ -244,7 +258,7 @@ for partition_set in $partition_sets; do
>>   	# If partition is already encrypted, decrypt and continue with next partition:
>>   	decrypted_part=/dev/mapper/"$crypt_mount_name"
>>   	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
>> -			| grep -q "luks2"; then
>> +			| grep -q "systemd-tpm2\|clevis"; then
>>   		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
>>   
>>   		# check if we are trying to mount root, set ROOT to decrypted partition:
>> @@ -255,6 +269,12 @@ for partition_set in $partition_sets; do
>>   		continue
>>   	fi
>>   
>> +	# If partition contains an aborted reencrypt luks header, switch to reencrypt mode:
>> +	if /usr/sbin/cryptsetup luksDump --batch-mode "${part_device}" \
>> +			| grep -q "online-reencrypt-v2"; then
>> +		partition_format="reencrypt"
>> +	fi
>> +
>>   	# If partition should not be encrypted, continue with next partition:
>>   	if [ "$partition_format" = "noencrypt" ]
>>   	then
>> @@ -272,10 +292,11 @@ for partition_set in $partition_sets; do
>>   		watchdog_pid=$!
>>   	fi
>>   
>> -	# create random password for initial encryption
>> -	# this will be dropped after reboot
>> +	# use partuuid of the partition for initial encryption password, this key
>> +	# will be removed after the reencryption has finished and the TPM2 token is
>> +	# registered:
>>   	tmp_key=/tmp/"$(basename "$part_device")-lukskey"
>> -	openssl rand -base64 32 > "$tmp_key"
>> +	lsblk -no partuuid "$part_device" > "$tmp_key"
> 
> This should be factored out into a separate commit. I don't disagree
> about it, it just deserves an own, clear reasoning. Without recovery, it
> looks to me like a nice size optimization for the initramfs by dropping
> the openssl dependency.

Why `lsblk` instead of `blkid -s PARTUUID -o value`, as blkid is already 
used in initramfs-verity-hook and initramfs-abrootfs-hook this would 
save more space.

Quirin
> 
>>   
>>   	case "${partition_format}" in
>>   		"reencrypt")
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
>> index c9a7f89..5e82521 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
>> @@ -14,7 +14,6 @@ require recipes-initramfs/initramfs-hook/hook.inc
>>   DEBIAN_DEPENDS .= ", \
>>       cryptsetup, \
>>       awk, \
>> -    openssl, \
>>       e2fsprogs, \
>>       tpm2-tools, \
>>       coreutils, \
>> @@ -40,8 +39,8 @@ HOOK_ADD_MODULES = " \
>>       ecb aes_generic xts"
>>   
>>   HOOK_COPY_EXECS = " \
>> -    openssl mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
>> -    e2fsck resize2fs cryptsetup cmp \
>> +    mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
>> +    e2fsck resize2fs cryptsetup cmp lsblk \
>>       tpm2_pcrread tpm2_testparms tpm2_flushcontext \
>>       /usr/lib/*/libgcc_s.so.1"
>>   
> 
> Jan
> 


