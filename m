Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F22C25B74
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 15:12:23 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.42])
 by mx.groups.io with SMTP id smtpd.web10.30336.1716822737777194586
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 May 2024 08:12:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eWk9ebuP;
 spf=pass (domain: siemens.com, ip: 40.107.22.42, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCg9G0/IYIdcMW+oIDS785liTGnkGCOF4JTqzCWEF7HJwxEqcXgbTc8ThBUv7bhO6xPQTmThhwpzCsoAbTceng+5Bo4iyB/EEjpxxy303Yt2gUR7SCuZdRHie1duUanZJuWiFDF7MYHz97lv5SVESU70qJDVn+A2eoKtgWsLmJA5Zu0OXWVdx1kBLb/LKkCADoNDRdSZEDuY5ZW161mAVJ/bS/jwHMtytLAWOlpGFlmihMiMMyvO5I9gtKuw7CqpmfQ3kTcS1t7O+jqjQQAkK1JwqR0H98OkVd/6RFPLkEKt1EUssNx55eHj8lKI30PI5NnhraoxE3/QzrF7VCo+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Agz0KYHIPSyoZvXbH1d/XqYk/habnRpB9B8Kr3hbsQQ=;
 b=AWWsXCNbEjnfC9umAhNeSCVH8w4fsk5O9k08JEZIrJryVp/AvxlMPqqo4kYjIjLAJJMtx49A1y1M3aCTFpD4HIJnnnO1FeYCKL3ZG/5QbBKXnlmVFvkJ8CmxmFmTe3T6xamtVL439oEcW2Up1Yp7T/bkBQ/1BZr8hk9lR1A4gpHSTyukXG3hO2jseAVmMx999JiU3yLeQYtj8lrZ18mG4hX0bpQis6PxqMXZEliQkFsUt7juFfGMhAtU0Fb1rVT6ULCUPgZNXcrQcgRLXwSY06bC0YA/O/KiXmJbTO7X859rkg867DWAgEgnrV/NBq8U1ryp4+Ni/J462Lzd1ctq/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Agz0KYHIPSyoZvXbH1d/XqYk/habnRpB9B8Kr3hbsQQ=;
 b=eWk9ebuP4pe//Zj6Emdy3dYHXAHXuWV2qoiw6kr1qDmdxoVtAFS2FfWzXVXumA6u7Bui6HJoCJ7DBOrVdyzPmkWsQgq9XnoM5J1GE4GYe0+YZR4D3RIdKbp+k9FhmEf62JLq3YevzMN9AaHiLTDGuhkTl0sdQ30ayxhGZDmqYdszPXGMJyml/Fp7ok4lwFRJvG3b2gC6jI32p9Vn5KgtuTg3vBa5aipp/UG2wz4gUR9p5Or4l6UcGEcB45u+jdZsoUjfi3dQVuGG3SJfrfEX/8+zEFGPpTL8Jd12MrAterd/pQ0MOKZz9Qxx/IIbQpNje7AgGPfsWS+onGk+1VrGZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS4PR10MB6254.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 15:12:10 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 15:12:10 +0000
Message-ID: <2c2de146-d524-4222-829f-692b1b8e5426@siemens.com>
Date: Mon, 27 May 2024 17:12:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3] encrypt_partition.clevis:
 select tpm2_device for encryptition
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
 gokhan.cetin@siemens.com
References: <20240527143247.3098210-1-Quirin.Gylstorff@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <20240527143247.3098210-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::19) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS4PR10MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a79bb3b-06de-4a81-108f-08dc7e5f61be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bHJKMGx0dHFhTURtWGRGM0xMU3ZybVF2OFdqd2RQWVlRa3VDR0VXU0JzOHVp?=
 =?utf-8?B?Y1RWYnRQWmpQTEszam9RZTJRUHlDdGZPYmxWRGVIdWNjTVhHRnZTL1p5V2s5?=
 =?utf-8?B?NThUVFp6eGNNMkd5T2Zxa29pM1plM3YvZi9FdWJWS21hT2tNdWYxUDZWSUd2?=
 =?utf-8?B?cXdPRDVKZStDTk9tQjlZM1RmWTJRd1JPT3NKZHkraGVUTmtBOTluN0ZtZ2c3?=
 =?utf-8?B?aDd5cVpxT01KL3MxVFd5SjZ6dzVvY0NsME4zdFpFaVgycFJBb2I3di9EWXZK?=
 =?utf-8?B?akM4UjRRaDNURzEvNVpjR21DQnppUEFqR3padWJ4V1k5dlVDWERtTFFWUmsr?=
 =?utf-8?B?RDRucTV2WHJMeVVLWHR6enpkekgxTUdGQmJrQzNUbnlYTVhGLzR4UUQ1enJ4?=
 =?utf-8?B?a1lZVFFjK1dSOXZJOFM1bUNPN253MXZabm80NVJJRnJEallha2MvRm1jWDhx?=
 =?utf-8?B?NkJjNTdqRFA0RERIUkdaa2Jjelc2QVJ1RzlHVGhhM25BVnNhUzN4SzcwK1cw?=
 =?utf-8?B?a2NFR3hDeUJsbThwajl0MDJSbVJkb09SMVFuNkJ5N0duNWpPN0U1Vk9NU1gz?=
 =?utf-8?B?RkZGV0NQM1B2ZVhQZ0lIaEpVSm5GNFZvckFzWmtuL3RaVVpFR0p3M2g5TnVu?=
 =?utf-8?B?dGduNmxvWHdLcmhyUjA0Qmh4cFJxTm1hay9FRVZnV0IraFhiZ3V2Yk1vNDd0?=
 =?utf-8?B?T3dodkFrUVN6c0VvRUtPUlJ5emhxRU9aZHdZMGlHdTBzRVQ5dS83WjUxSXli?=
 =?utf-8?B?eWpRTkxjMExtZTJ4RGxNcEp6bTVpWjhNTGh3OHV3QTdRT2V3Q0s1MnNvbGQ4?=
 =?utf-8?B?MnYvUkxNMDlvekFJUG92dDJaS3lpVWY5blJ4bmpqZzhhUmk3d2h0WFNJV3Bz?=
 =?utf-8?B?ZXFYb09BeUgvclNVSE5HLzdyYUF6Syt6Tk9YU0lvQWR0eHczd3VESUZmV29p?=
 =?utf-8?B?S3haQzc0eUpPYWkxaHVmbHh2VUM3U2duVTNhSTgvb2E0N0p0a0J0UnU1WDIx?=
 =?utf-8?B?dEYxZGJIa0FicmY5dmMvUXhrZVM5S292dHJzNkYrRU5nNEkvUFk2SEJ6RHVO?=
 =?utf-8?B?SXJHYVJ1aHJCVWdpbVNrM3RiWFNtSUpXN1hzREZ0Tm1GLzVNRGVtd0RQQVh5?=
 =?utf-8?B?eEhzVkxONlZHWGNZL2lxdndxdURpL0NubG5wTmdkT1NkTXhJNU96ZTB6a3hF?=
 =?utf-8?B?TW03ZncvaEk5OVBDcnI3VzlCN2VVVXRReUdOaHM0aGVVOFVqdlJNWTRRRTZr?=
 =?utf-8?B?YnJKTmVKVjNsY3QzNitzZ2QvNTZCeStBNzdSREREWkIyc3U1ZWVhLzd0ZzZp?=
 =?utf-8?B?bWlOWVp6c1U0eG0rb0ZNSmpaQk1oV1JCSlljdGFFL3Z5L2U4Vk0xTDZacGZ2?=
 =?utf-8?B?Tzk1RmhmY1kwVGNMOWdJc1JsakRxc0wzZit2V3ErblZjZTFJWC9BUjBIVG83?=
 =?utf-8?B?bER2MGtHdUtkZ0x0a1ZqVW4xQ0dQRlNyaGtvREtkTWp2c3FLTEZ1VlZjMGkr?=
 =?utf-8?B?VXphYWY2ZGI2V2lLdmRwMWFJZW5DcmdsdUJvK2dOUXpEL1Bhb3c1NytIMTFm?=
 =?utf-8?B?cjhMSDJrQTZsZWpVaEpGeGZxaENTV25mdWlib0tPL05LdUhzT1lTK2dCd0hk?=
 =?utf-8?B?a3FKSUxXWndZa2xkUCtLUnFPcVZTd2c9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NUJHTVJKUGZVRkxxMkFPN2djK1B6ckxodHp5YkNhYUNNbzZjOC9ES2xZdVl0?=
 =?utf-8?B?ajJ6cmRwdjBBZlV5Q2VwUmZwQ1NMNGVPU3BOdGlKOUlqUCtMQVllT0RiN3R3?=
 =?utf-8?B?ZGRiVG9FRXJkRUlLZ3Y2Qk95ZlZHUXJPcTJ5YWt4RVlIdHJDVTY1TFYweFVv?=
 =?utf-8?B?WjNFRUNHaEpsTE8zUXZndU9heHk2NTRsMWZjbFREVnJoRmxEclJwRlc1TSt6?=
 =?utf-8?B?cjRTZklpT1VkaHhFUEtaNEp1L0kwRHRTbFc3ajJuZXExVkM0dVNoQXd1Uzlk?=
 =?utf-8?B?dVhxS0Y3U284WGZ6RjhKUDg0dmgvaE5pRlNyNm9DTzVHMjFyZ2xBQjY5czhQ?=
 =?utf-8?B?LzFJK0doTDJkZCtNeENTalE5WEJJSjVxSmhKVExuSWZ1V0huNytrSytPQ1h0?=
 =?utf-8?B?Qk1VQW9tU2xLSkQrd2FRNi9EdldiMlB4UE9YcVlQalJqcmhCZ0owamVOSVhw?=
 =?utf-8?B?ZEVjYlUxRTN6c2ExRDd3aFlXR0htRW5PenE3Wk1ySFBncytZcTRRcmh3Rlln?=
 =?utf-8?B?cTVLdVRCTzR1U2cyT3NXMFpQUkVUVmNwdm1UN3dPbFpqeW5tSE9wSnJGVDVa?=
 =?utf-8?B?MDNuSmhrcWN5QVkvWUV4QWVoNWZ4aUxmdDhBRXRNUU16NWFTZ2FsUFFYOXVa?=
 =?utf-8?B?MDMxakFkdHl0YXBFR1VhelJCWUxhamNNU1NGSmlyaUZKSVZWWVBMRXV5SXVN?=
 =?utf-8?B?bEF3NlcvQTVoVFAwU0dkUnZwUkFqUm1tVmovMWU3ZWhUb3A2K1pCREI5WUpO?=
 =?utf-8?B?NEUzWWJQbXBkSjlLRHMwMEkydSs3VXEvZHBPbDUzdkNpbDQ3cEdlUmllQUI3?=
 =?utf-8?B?c1Q2dUhPcjdUVEZGRFNEak5xd1ZLS2hudUVzOGdNbGZ0cjRjbzRhT2w5ek54?=
 =?utf-8?B?bFl6RDA5dURrbE0vUXJxeld0YzhJcHMvQld2d2Rydk1hZHVLdDNFTTduRWFH?=
 =?utf-8?B?SVJBMXArOHF4ZUJFbVRHb0FBc1lDUGd6ZWtPb084Njk1SWxCZlpjV2xIc3A1?=
 =?utf-8?B?WnlIM0YwQ0x3TWkzT2JibnBqTTZPeFNadXdSbURQcjV3TGh5K2dDSm15OGZs?=
 =?utf-8?B?WU9qeHd1RmVaQ1AzZnR3N090ZFEvRHV0ZmJnYUV4UkorTkJJcTNNZVNtQmR5?=
 =?utf-8?B?ZHFqbTRVUFE5aHRqSGJqV09RNTN5UzAySHlkZllvVHNxR1NHblJnZXVyTmVL?=
 =?utf-8?B?dEp6c1VoY2NEdVJYdUlEeFh2RGdWNktoSjBUd1RtQjYvZEZxcTJDVG56Yzhy?=
 =?utf-8?B?VlFMNmlHMlV1UEw0dmtiUENObXI5OXdGM252MS9uTDZ4Yi92c0dFUmNqZzJr?=
 =?utf-8?B?c3l1VHNpUk40YWVaS1MyU1dnaGtsQzM3Y3ZYY2FaaVNlZ0FoZW4zYnFPbmlz?=
 =?utf-8?B?UGIrVy9DQXFRNlU5YW5MdjJjRk1jY0luZGhMN0g5YXQxZVpVVTBrQmJueE9h?=
 =?utf-8?B?VUkrVDBtSml3ZWw3MDExQmMxYVI3Q3hlQ3lPbG1mQm9TR3lnNTF0cDIwSjlR?=
 =?utf-8?B?aFpIZHVuRGgyR0ZuSDV0Z0hkRHROMjhscmFhVnpSS1lSNGFRU3Q1bE0zYUV0?=
 =?utf-8?B?bFJ3cDFXVzdvQVdFVDhpV1FGcFhUdGhRTkFKa3dpTHNyN1N2cCs4bGxiWkQv?=
 =?utf-8?B?SzRYNDlrNE92a3NKUmpiQ05yNVJiUzlmSm1aajVPK2RHb0RGWVN1TU5RU3Nz?=
 =?utf-8?B?QlBDQW5nSVcxZ1JqeDloK3pJeXdGWU1UOWZIc09UVHdSVHhoK0NFbUhvTito?=
 =?utf-8?B?MXJVUWc4MlFaOUI5ejBacE53NUM3Ulo4b3hCYjg3M1ZxTDdpeHBmaUlmYkdV?=
 =?utf-8?B?Q3Y3ckpsNnl6blJlcHN4VE9IaUdyb1hHSlJRYU41QXJxOVZOdGRQc2pxeTh5?=
 =?utf-8?B?SXZFb2hJWEhyeWxmeWhvRGRKTkNOOU1SK0kxMTcyYWhnajdPQkc5YjFmOC9w?=
 =?utf-8?B?ajcwZWJzcnU1UVBzbnFBNHdIZ0xCZHBZZnNla0FNT3BiaHFKVHdOSEhUbG5z?=
 =?utf-8?B?clJHSTFHUXgvOUpxNmFDVCtiV3NWYUpOY3ByUFZrcXE3ZDhmWmQ0R1hqN1pl?=
 =?utf-8?B?WjU0NlRxZzJXcUtWY1BHc2ZOS25DUm13T0N2UkN0TnA4OS9jK3h4WHFoUXVD?=
 =?utf-8?B?NExTTEtFd1RCZDBpaXdNUDR3UmhxT0haK2xEVmtmZFllQmJVM3lwek1WQ2pR?=
 =?utf-8?B?cmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a79bb3b-06de-4a81-108f-08dc7e5f61be
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 15:12:10.8063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQQwmcdqeJXUFc8UETjvErMSvnjB/isJ5zMINJVzoBltrhXL/GfbntL9fjpTvZY2jzNeiCqhMiIDevODKYzKSI0DXw3/Bth6yAUzBpaNPdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6254
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 May 2024 15:12:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15959

Hi Jan,

On 5/27/24 4:32 PM, Quirin Gylstorff via lists.cip-project.org wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This enables the feature to preselect the TPM2 device also for clevis in Debian
> bookworm and later.
> 
> As clevis is intented to provided TPM2 based disk encryption
> for Debian bullseye and earlier the TPM2 device selection was not avaiable
> or implemented. Since clevis v19(part of Debian bookworm) the TPM2
> device can be selected with the variable TPM2TOOLS_TCTI[1].
> 
> Setting the variable as no effect in older versions, so
> no version check was implemented.
> 
> No interface change as systemd-cryptenroll already allows
> selecting the tpm2 device.
> 
> [1]: https://github.com/latchset/clevis/commit/c6fc63fc055c18927decc7bcaa07821d5ae37614
> 
> Reported-by: Gokhan Cetin  <gokhan.cetin@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v3:
>   - reword commit message that the disable setting was intentional
> 
> Changes v2:
>   - reword commit message to clarify intent
Please don't merge - in my latest testing I had some disk not found errors.

Quirin

>   .../files/encrypt_partition.clevis.script                 | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> index ddb3eab..a7a5009 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> @@ -13,8 +13,8 @@
>   open_tpm2_partition() {
>   	partition_device="$1"
>   	crypt_mount_name="$2"
> -	#tpm_device="$3"
> -	if ! /usr/bin/clevis luks unlock -n "$crypt_mount_name" \
> +	tpm_device="$3"
> +	if ! TPM2TOOLS_TCTI=$tpm_device usr/bin/clevis luks unlock -n "$crypt_mount_name" \
>   		 -d "$partition_device"; then
>   		panic "Can't decrypt '$partition_device' !"
>   	fi
> @@ -23,11 +23,11 @@ open_tpm2_partition() {
>   enroll_tpm2_token() {
>   	partition_device="$1"
>   	passphrase="$2"
> -	#tpm_device="$3"
> +	tpm_device="$3"
>   	tpm_key_algorithm="$4"
>   	pcr_bank_hash_type="$5"
>   	if [ -x /usr/bin/clevis ]; then
> -		clevis luks bind -d "$partition_device" tpm2 '{"key":"'"$tpm_key_algorithm"'", "pcr_bank":"'"$pcr_bank_hash_type"'","pcr_ids":"7"}' < "$passphrase"
> +		TPM2TOOLS_TCTI=$tpm_device clevis luks bind -d "$partition_device" tpm2 '{"key":"'"$tpm_key_algorithm"'", "pcr_bank":"'"$pcr_bank_hash_type"'","pcr_ids":"7"}' < "$passphrase"
>   	else
>   		panic "clevis not available cannot enroll tpm2 key!"
>   	fi
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15958): https://lists.cip-project.org/g/cip-dev/message/15958
> Mute This Topic: https://lists.cip-project.org/mt/106330929/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

