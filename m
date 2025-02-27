Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45923C021BE
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 12:30:09 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.66])
 by mx.groups.io with SMTP id smtpd.web10.9415.1740659404754473846
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 04:30:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FMaIpa00;
 spf=pass (domain: siemens.com, ip: 40.107.241.66, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HApeJE1dbXi8mDDNWrBp5BhXcUPJilsNhD1A+Mh5ISZdrfCow5OcaDRwiWC1Ag9BXnQZDq7IEEXgDR/CB54K3wnBHvlJdJnewP/7kVsnxs3ZcRdcouCxdVHgfMuaWWPNGXYKT0BHoBkKGxmRKBmsiB4uYoFaVhbQOGINjbzUp0wFES/nbs8E44RIpbK2l2mbCDsgvGXm8b/0gGlOUhdvr919k1Mt8Tt0jXq9BGGy3qRn7FG6bUPCWUPoR3y7uLHMoo61ApaLlBzl19b7wA1k1np+b74qU2zWkTAlbkRG6k2p/7TX5ZD388HtJzRnC2uF4F0DsjvD75bpUkx+NkpcZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=305NCayZb/sch1RYLc8emPirSRJ9GCdYsY6cNWuWyYk=;
 b=Yx0iVy7+SLWuq7tOF9fzse61n/W8NqLybqssFBXf7Yyx14hzf1GGxFZNDt94zNzguLweITpIfAOYwqJ1jyMolQwPwNyp+GZOVGdhenSyXhENKvSYos9ndCTq6WxMRBFpsdzRLLmzXXELgHE8XMqM7MgYo9FOQEkZMZX0kiGjR/+7cLhJIoSP1JxI9doxSbA3VUqO885h0dQCT3EZh/koZ3eGfXftHuJPBzyCJ0qTMv01oPGw4neDyOQOUa8MoJPc+CIC139T2TDDIS+sj2kdGkuPOa9INA7j9sgoQ6Walz1o9gSMl7CCUjqMJPhPyC35Fhhm++VEpNfBs5U9Kq582Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=305NCayZb/sch1RYLc8emPirSRJ9GCdYsY6cNWuWyYk=;
 b=FMaIpa00lCEeygiBgzCOJOt0tih/G2RlaQpWdboSoN7jFH9VyfCO3vHW4+DvmKnYmkU2nbnULo/uw49jA1U3z8HgnQUr5u0ANIH6zUp7rZitvZB5uj6xoGbqUY2z0X6IJu/HqR7/9aRLr2C32XnjjyasHPp6sv9+qxBd+JFliYldmXwwMe4Bzse5TvL13xxlPMmnTozvtLoypZvqpk66ITwuAyc4nwhoT/zWLBWMetVU0R7fSEnE5Hnn136msHVy3piJJsIQ/krS8sk2KTKuWQvOV3LGPUVzpXzF8VPiSr7cz93KiR1yDPtz1wYo2KpwzBoTuuMLlFEkRhBG34IFoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB5311.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 12:30:00 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 12:30:00 +0000
Message-ID: <ab056b18-b274-4e42-8d68-9eff0d1dccf7@siemens.com>
Date: Thu, 27 Feb 2025 13:29:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v3] initramfs-crypt-hook: Optimize disk
 encryption in combination with expansion of last partition
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com, clara.kowalsky@siemens.com
References: <20250226232812.374892-1-alexander.heinisch@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <20250226232812.374892-1-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0004.namprd18.prod.outlook.com
 (2603:10b6:610:4f::14) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB5311:EE_
X-MS-Office365-Filtering-Correlation-Id: 80afed42-9fa1-45ff-a09a-08dd572a73ed
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SWgxQTQ5MkplRDB5UTRSdDN1bjRzMCs4L2FFWEtNRWoxdFgrK1pDaUM2OUlC?=
 =?utf-8?B?THp5OVB5V3VadEk5V0JjeWdjUTVoS1JBUXNnYVBpR1BxYlVVTExqSkhFUDVn?=
 =?utf-8?B?SzNnRnZpR1o0a0MzZDFxZW1MVnZUVXVTdFMvdG05cHMrVXk4azc1TVRFblJE?=
 =?utf-8?B?dkQyd1pOdzVWcGo5OUJmZXpPODd6LzlHbjBXbGNoVE1CTms0V283TUtZc2d5?=
 =?utf-8?B?V2lCZDg5SmVyajdSTDFleFZCMGZ1MmMrZXJ1bnpBM0V2Q2wyVERJYkljeWhp?=
 =?utf-8?B?MlNwL20xWlllLzEzUWVJVzVzbG5DRmo5b1ZRUXFnV1dNL0dVbnd0dVJJcXNw?=
 =?utf-8?B?bFArWVQrS1lCYzREbStUWjdZOHo1NVkrZ1hTa3RQUitJVWVUV2VVU1NRRkV5?=
 =?utf-8?B?ZW05YTlxeTNvTlNwNUhmUTdqS3pvL0hRM2lsZFhKUWNWZDdOSklHakUzbFov?=
 =?utf-8?B?ZWFSYk9YUmd5NEdWYzFLWFNVdDJGaTk5SExTYXRsQU5vc081QjQ1bU9xbzJE?=
 =?utf-8?B?S1RiQWxvNzBtK3ZEaXo2TmcyTFkyVSt2UUkreUtmSWtnaG1uK0l3Q3NlTDdX?=
 =?utf-8?B?enVJbFY0bjRkVFd4Y0xlWXdsbzV1STlrYnJDUitPR2xqay9NSUMxNE9GNW03?=
 =?utf-8?B?ZmZpWWppRFhlcnVUd3BodXBtb1dWOTN3NklyVXIrWHhBT21ETW9lVVY4WDYv?=
 =?utf-8?B?Q3M1MEoyaXo5aXk2VXljV3VKeFkyN1BnMk45NkFNZmMybmVDZTRCdy9hWkJp?=
 =?utf-8?B?RytvalAyZVl5T0pQNHdXaHJZRkpPNWFhV3JwL0tTTHF1Sm5BVmI0akxzRE9P?=
 =?utf-8?B?WXBXWVpXeWVUbllucHFyNVp5SEYzcXZpN0RFbGtlVXpDcFNtbTJ1ZEllczBY?=
 =?utf-8?B?RnZ0QkhROWtSejVSNXpLREF2KzJWQmhWVVJpSlBJSHN0WlFhY0xKYUxsOW9H?=
 =?utf-8?B?SEFEbWgyVWhka3NhNk1IbVJ2K0pUdFlCZFRyVkRvNDlUQU1TZUdHbFdzWnJS?=
 =?utf-8?B?QnpsRFNEYmE2c3VXMHNLbnNpVXZaWWdnRVdIVG5UdlZ2Y1dPZUFSemErVWVG?=
 =?utf-8?B?L3ZvV1RBSUJNdnFEdUN5NVZWa291NUk2MEM0OS90OERhc1hXZjFkbjZuRGR4?=
 =?utf-8?B?K3NnN0t1SDdSWHVhNGRFMHBOcUM3NFF4bFUxUnhJS0tQRUR1N1B4aE9aclJM?=
 =?utf-8?B?WFFsc2poYVljU0RLRWR2WVdYRVh4Y0htaTYrS0xkN3hNMGpoRjBTc0xjTFRm?=
 =?utf-8?B?dXVrUEpzdmNQQkhkczJNYVA2M0FUR0lSWXp3eXF0RkFrVFRpeklXSmZhTXgy?=
 =?utf-8?B?eTdxQnMwU1lvdG9uMnRINWJnZmtrLzhUcG1sNGZRM2U2NDVCN1NlNlJ6Tmp1?=
 =?utf-8?B?WlUxNDRUVCt0a3FJcEIwVldKRG9qRU1BRnhkaHRldk1TYUNZTU96ZWFPOEcw?=
 =?utf-8?B?aG5mUUoyaWRmZVhSZjZiaGkzckE3dzMrRFAySU9ybTU3WlRuNVVmZHIrUDJZ?=
 =?utf-8?B?MGkveEVLMW1vVDB4T0hBQkNPdnV0QlFjWmgrbzNIdWpOYWVRcGtVS2Vldlhl?=
 =?utf-8?B?R3N2OHRPWnBpMnQ0RHZSVGNHMEpiR1JqZU9aWEJlLzBtbTVDWVU4NkxzTFd0?=
 =?utf-8?B?YkV4RVZmZjZQbTFSeTErV0ZuMkdaY3kzbGE5VDZMNUVRVzlUNGJWcGVRdjAv?=
 =?utf-8?B?NElXZVFBN3VNNkY3T0RHUHpVYmlRa0V1ZUFoeEVwaG8xUG9ZdXR6TjVZcGxB?=
 =?utf-8?B?Q0ZmVGtvTzNFWTMwZ1RoZW5JZ1M1cGtKL3N1NHFoZ01oaitLK2NHT0RkaFNh?=
 =?utf-8?B?S0hyTDhKNnpxdU55OU02YmUyeTg5VDdiQjRlS3M2Zm94cWgrYXNPWVl2Z0xH?=
 =?utf-8?Q?ugXlQF7Q4ugUi?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RmxFdkIxT3ZPdzFmS3pVVGVVWEpTc2d3WFRONHlxTWp3c3VlaThORExITDRF?=
 =?utf-8?B?NWFnTTdXekd3STJMTFc2L0lIZWhxeVl4c0RYRkU3MUR1RFJRN2Y2SWdEOFpL?=
 =?utf-8?B?L2E3ZUFnczN6cGRFZUNOQjNCOFM2WFBEeTdRNE5QdWc5cDJiTVFtWVBGQWRF?=
 =?utf-8?B?WFZ2TmNMTHp4N2xZZVdMUVI0Q3FsK2N2aW1CNjVoOG1CYzZFV2ZkTnZMcC83?=
 =?utf-8?B?TkY0dVhNL0QyTWVIZ1pneENrOW40MDZHRjFsYkR1L0V2QUpaYmlmZGdVYURs?=
 =?utf-8?B?bFFYeEpTNUlBRlFXc1YvZ05RRVB2SFYxbTBNYUYwM0JYMDgwdHpiTklKQm1Y?=
 =?utf-8?B?WEI0VGNDZ3BmWVV0SkVVbE1EU3ZWUzhNZW0xOVM5alVrUWcrdnZMaUZmQ3BY?=
 =?utf-8?B?YWN5WE1xandleEwxbTJEVXl6bE93UnRxeEdsTzBBSExtTzlaMSswV29nK2Jq?=
 =?utf-8?B?OGJsQ0IyVHFvRkx3L28xemhhTDVXc1lZSlJCZzRZbFVzY3dkKzZ5MERTMWNW?=
 =?utf-8?B?NHphMUpGWmdyNkd5ZThHMnVBUmJTTW1KM0R3NlhZV0hsRU1nNUFiT2czMUtp?=
 =?utf-8?B?Kyt0RXZrNzVpUVJrRW5RMU1XU3d2eTJlbHR1cC94aCt3RS9ocHFUamZodWF3?=
 =?utf-8?B?UmpwdEZsL0lKQzVnYWlzelhkdmJ2UmdnTmkrWElkMDkrVmRYM0xKZmVPN1Zn?=
 =?utf-8?B?Tm13VUYrRk5KWGYwaE0yd0JYWWQrdHlURHNsV0tlV2lmOUVZVm5KME5PV3Vq?=
 =?utf-8?B?Zm1GRFRqbFoyNGNOelRha2NENHBLd3psa1pxQkJKaWZaQzFzV25DekdiWjlC?=
 =?utf-8?B?VUtxb3VXN2grejIzTkZFOUxkUjJvVXdFNWhzNlF2V2t3dHliOWZmVjNqdCtx?=
 =?utf-8?B?RjVsREVlQVJndWJSd200cjhwbVJwd3V3UC9jNElnTjhmcUoybHJqeWxWd29F?=
 =?utf-8?B?RWxTMW4yaEl2Y0IrN0hmQWc0V0E4MHZNdUZFcjNadlN0ZUc2ZXFEWEIwdWVi?=
 =?utf-8?B?OTV1c2lyRUxvTVVXYnFwUnNzWWJoZU5HUXlLV0xOZU5aeUdTOUJiY0UxYWhw?=
 =?utf-8?B?ZWhLRTJ2TjdPMHBETjZveEZVR1J6NHBXVzFid2YxUnN2U1RSOEExNDhUKzdC?=
 =?utf-8?B?YUVjeXJMYWREdUoyejhYRjVERzliMkk1KzNhdUZRMGZheHkxVGxib3pUVEFp?=
 =?utf-8?B?S2U0VUdkV2hoRDFZMDhzRktxajlPS3NsbGpDekgxMjNjRitHMmljcGw1YVFO?=
 =?utf-8?B?ZWRWZ0RvNHdaWllDbnVQOWFHMlp3VFRPUS9lalNsVjUwbVROdml5bTgyUThY?=
 =?utf-8?B?WFVIcXVTMzhWazZXeXFhT29pRld6QkVzUnlvcDZpYTVZeEVWaExnQkhGSENH?=
 =?utf-8?B?UW1NbmxXdGpsUU1PVWttZmlmVGlMT3drbUl6OWdUOWg1d1lUa2p5S29CVFNL?=
 =?utf-8?B?cEtYdHBFZ0xaSzFNUFpWWkVkbVI3RGdWbVQwMWZQazZCT3JrU0IzMVRlK0kz?=
 =?utf-8?B?K1JkSTEwMllaVGhBZkJxMFNvbXFMOTFscmlXRERVek9od1VVS3RTZTFMNy9V?=
 =?utf-8?B?R1NxVGZDbjEzWEU5aUpwMVhaMDJMZ2ZiZUl4ZDlwN2lONmwwZFNwM21jTzFY?=
 =?utf-8?B?b1QvZHk0ZHM3VEdneW1uNmcwZTZWR3lrZFdsakE3d3lHbWdTZEx2MTBFdTF2?=
 =?utf-8?B?a0VSRmtIUFZuZllvMUd4N0hXam5mWTlJR1dhRnRON1EwR0hyN3hEcEdBMmxL?=
 =?utf-8?B?ZWtmOGhiVDJ6Um96NFBWbUFvbE51bTlWb0g1d2VBWEZUT2lvYWF5TXJoU2tP?=
 =?utf-8?B?UHp5Qk1xeHNwYzVnc2hlZzM1My9sUlhUWXRNZFBhbktmaUhaaTNWeVFJczE4?=
 =?utf-8?B?dWxucFIvdzhNYitmc3pNYk9RZ0JiV0d3Sy9FZXRleHdPMlZVeWpGMTVReGpx?=
 =?utf-8?B?SHRrdHg3UWVmT2hJNjFVd293aGQ5UlVwNGNBUTlJTFpSc1dQQXpNbXNESVZs?=
 =?utf-8?B?UGthY2E3Y29hVXRtZCtWWmcvR3dBWEVyT1E3SkZ0UG4zdnQ3VkJhWGJSaVdF?=
 =?utf-8?B?bmY0L3p3SlZ4S1E4ZHBCeTBMa2RONTI5QzVsdE1zQXJVRHF2TytOeVd0eGhV?=
 =?utf-8?B?eUhkT2F4RkpuViszcHY4OTMwVTladEkwcVg2WlBuWSs5dlVuZXRqdkw0U3Vw?=
 =?utf-8?B?SWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80afed42-9fa1-45ff-a09a-08dd572a73ed
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 12:30:00.3723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+rpzZGiVtm5c5kllkSsnaRUYHTim8IbNC6SH3SKIsx74ZvtKG4u+Ys67JkCNx466zs4dzdp53MKgaY2Uqf48mmy2L28CDb05dQzy0F8tRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5311
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 12:30:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17935



On 2/27/25 00:28, alexander.heinisch@siemens.com wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
> In the current implementation (since: 284175c3) disk expansion logic
> is done before the actual disk encryption.
> 
> This results in reencrypting the full expanded size of the disk, instead
> of only reencrypting the sections containing the actual data. This results
> in a drastic increase of time (approx 20x on our systems ) needed for reencryption!
> 
> Since relevant disk contents are only available in the sections of the disk
> available before the expansion, it is sufficient to reencrypt them only.
> 
> This patch changes order of encryption and disk expansion resulting in
> faster encryption (since only the necessary parts are encrypted).
> The resize operation does not reencrypt the added disk parts but just
> extends the LUKS container (cryptsetup resize) to reflect the maximum
> available disk space.
> 
> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
> ---
> 
> Changes v3:
> - Provide key to cryptsetup resize for clevis based setups.
> - removed export of EXT2FS_NO_MTAB_OK=1
Why? is it not necessary?

Quirin
> - Added support to expand partitions with btrfs
> 
> Changes v2:
> - Reuse get_fstype from mkinitramfs scripts/functions.
>    Therefore, we could also get rid of mounting the partition
> - Dropped support for btrfs (compared to v1) since crypt hook
>    does not support btrfs anyways
> 
>   .../files/local-top-complete                  | 37 +++++++++++++++++--
>   1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 5ef7ca4..fac6db6 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -102,6 +102,8 @@ reencrypt_existing_partition() {
>   }
>   
>   expand_partition() {
> +	key_file="$2"
> +
>   	boot_device="$(echo "${part_device}" | sed 's/p\?[0-9]*$//')"
>   	last_part="$(sfdisk -d "${boot_device}" 2>/dev/null | \
>   		     tail -1 | cut -d ' ' -f 1)"
> @@ -155,6 +157,33 @@ expand_partition() {
>   	# Inform the kernel about the partitioning change
>   	partx -u "${last_part}"
>   
> +	last_part_device_name=${last_part#\/dev/}
> +
> +	mapping_name=$(cat /sys/class/block/"$last_part_device_name"/holders/*/dm/name)
> +	# systemd based systems do not need to have the
> +	# key_file provided since systemd backend for
> +	# cryptsetup resolves the passphrase directly
> +	cat $key_file | cryptsetup resize "$mapping_name"
> +
> +	last_part_mapped=/dev/mapper/"$mapping_name"
> +	fs_type=$(get_fstype ${last_part_mapped})
> +
> +	case ${fs_type} in
> +	ext*)
> +		resize2fs "${last_part_mapped}"
> +		;;
> +	btrfs)
> +		mkdir /.mnt-tmp
> +		mount -t btrfs "${last_part_mapped}" /.mnt-tmp
> +		btrfs filesystem resize max /.mnt-tmp
> +		umount /.mnt-tmp
> +		rmdir /.mnt-tmp
> +		;;
> +	*)
> +		log_warning_msg "Unrecognized filesystem type ${fs_type} - no resize performed"
> +		;;
> +	esac
> +
>   	log_end_msg
>   }
>   
> @@ -217,10 +246,6 @@ for partition_set in $partition_sets; do
>   		echo "ROOT=$decrypted_part" >/conf/param.conf
>   	fi
>   
> -	if [ "$partition_expand" = "expand" ]; then
> -		expand_partition $part_device
> -	fi
> -
>   	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
>   			| grep -q "luks2"; then
>   		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
> @@ -260,6 +285,10 @@ for partition_set in $partition_sets; do
>   		 ;;
>   	esac
>   
> +	if [ "$partition_expand" = "expand" ]; then
> +		expand_partition $part_device $tmp_key
> +	fi
> +
>   	finalize_tpm2_encryption "$part_device"
>   done
>   


