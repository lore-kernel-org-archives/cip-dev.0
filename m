Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6881DC282D0
	for <webhook@archiver.kernel.org>; Tue,  4 Mar 2025 07:01:02 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.54])
 by mx.groups.io with SMTP id smtpd.web11.16871.1741071660487096874
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Mar 2025 23:01:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Slz8VAlW;
 spf=pass (domain: siemens.com, ip: 40.107.22.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MalSGPjhnezAu9hLCJEQvS28GYWbCwpGQ90XWQN+kRzFRLWRPZX/WgLzlVXbC7MMgJ8cKn3eWDhcgoqKE6S736oj9tMO0Aj2Vm8YPPWhbP39peIckj6stJLmUFt1sjCPQSXd8x/ZnSvj6EOeCcBY9CVZd0TwN/S/0Hq7XfhtwxeCtA+oeOHzTOUyJvtOk3BJ0WLt7pTNNqcUWAvcoakQahWX3QIhHc25/GiSzwjkk11SilrWzITxRNcN5NO2RDDwkOSFp3Y7f7S12x2ownso27kAR7U+wvlPLlnXoSyFe8Ii5RiYI25PCpCfer6CxRPBwRbwJwH3oTHdMliPQVeHrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpDOUCr8xStIHUCk/12Ihd1AmZnWnNV3HyHNkCnm1tc=;
 b=gH4LaQYNUevZrWE6DuwXRsOkFyml4EedSLn5uJ9Ibp1ZCbCBK4Egd6k/MRLsCQolRFVSTMaSQt9vVXDma2HPlZFWZbaWni9HNk7NXjMqOu49dHi4U3oUVzXIh6Y+vuieucGXOywwijFnA9U6kjuThtmZshOu4MMjF2j+G1m8DY6Bf7ZkWk2sSuG1jXUAd+oCmJ67iaHpuLQssS1y8j2YETfH5XRsrHqqID7ZjwWUqzM67UKgfLZHxQjo6z5J5tVABd/YorkeuftWAJKuHHiFIwFQfEoGLbeeYFqsmjQv3AXmvtalIVrKrUz+IfKJ+9lwmBy3PZ5j0pUQopwJ9pgX0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpDOUCr8xStIHUCk/12Ihd1AmZnWnNV3HyHNkCnm1tc=;
 b=Slz8VAlWS07uEhOQMxu2OLqhlqv6Q2OWaOiHIB/9h7nT0F76E1cLVhSEjqNjDeXJtsnauoYkdHxCBwoPgDmG/dovCAIE4+D1hMB5Si44O6P2G/KC7pw5iWOySJaRH1MD6fTJdoq4XGJNoT09L/r4W4JI8IHGy46ukopMD+DJ7EywmZl9jQUrBaTKdLAfKUpYQ7fT4FekbJIO4xhpO49+qMLAfsjbzoPZ3ViE7g6OBLtSfJXlINyRw7QN3H0XbqsdlF9XO8r5A2dt6W0R1f3wyUuRBAmQEDm2wcSRvZhBJmQsfIirJwl2d3ptDzpu+5DHgpmyjcr4ny9jYKuEgz9I3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7923.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:321::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 07:00:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 07:00:57 +0000
Message-ID: <3a9aeb61-4d87-4181-9a93-1e23f249126e@siemens.com>
Date: Tue, 4 Mar 2025 08:00:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v3] initramfs-crypt-hook: Optimize disk
 encryption in combination with expansion of last partition
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com, clara.kowalsky@siemens.com
References: <20250226232812.374892-1-alexander.heinisch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250226232812.374892-1-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ff24fa-f248-43c6-43db-08dd5aea5009
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?enFmMW9CQTczelE3Sk5vRysya1pXcmUrR25GcDBkSDZ3d1d4VXBKOVhMWHhO?=
 =?utf-8?B?em1UMDk1a0pNTVVJS1lRbEhjdk5BSmFWOHZ6djdBbzZid1JRdlhTS2c4dHJK?=
 =?utf-8?B?ODB1bUhLMFNWMlhSazlSRnBYQzV6T0JVNi9DYnN0bmJHWm0vTDM4L2hhSnk3?=
 =?utf-8?B?aDNjajFIMWRLb3ZROUptYXBMVjBBRW1QZkFobWIzajRsU2lveG9KbjlvVnAx?=
 =?utf-8?B?eDkxY2thSERjQVB5QkZ5dkpsdG5WbDNOSnpDalJTS0o2ZlZjTlBGU29yZjRI?=
 =?utf-8?B?UFJrN0xaUGhHQU1wSjJZRnZEZ0d3NzFTcHFQMlFTNXZRWnYzUG9pZHRkRngx?=
 =?utf-8?B?REFPMTl2TlFxNklrNDcrTmo5cnZWY1ltcmJOcFIxQjNWdW5Yamg4bXU3YSsw?=
 =?utf-8?B?R0lQbVgvVmtHOWNhUDlYRXYrbHpqSUVhMHBXWk9VZklqZXgwUW9DR05sWXpT?=
 =?utf-8?B?Tkp1YVFhUFJCaWZ1aE5hQTdwbVNuWGxaTkMvakhORHhzVTljK2tOL0kxUk84?=
 =?utf-8?B?QVltb3lsNFVUL3lyd2ZPM3YvYzNBMTdjb1FaTmNRUXo5WkVqR2hFT1lDMVdH?=
 =?utf-8?B?STRUei9KeFg3WENSUFhrbmlSd2hreWF6eFpOSUdsWHFKNU43cVR4Yk05UTd1?=
 =?utf-8?B?UjFmM2w5OTlyc2pwSTZMMGlya3ZUenRiTHBVY0QvcEY4dVd0YTdvZGNBTWJB?=
 =?utf-8?B?ZXVXUlhoTy9tNUhIU24xR1M1allhZjVRb3hyNVp5b0xSOWE5dzR5dG1MZnNG?=
 =?utf-8?B?V2FzZWptekFTN1FtRXdVSncwMDZoak1sRUU0QVB5THRyQ0dBRXZmM2hRRzlp?=
 =?utf-8?B?d0d1bS9DbUxzT3E1djRDbHQxWnZZQXU3UlVzMWR3SDkxakdvdTIzcGpVeG9n?=
 =?utf-8?B?Y1Y0azdSVUR1VFdWVUJqeXZueDIzSFN3cU1ZT1RDMGtqNWtPM3ljSVhML1hL?=
 =?utf-8?B?bVo2L2t5WVNYRFlPcFZsT3c2bzFBNkpGcEo1aVdFc2hCQ2xQa3hYVE5zRlRE?=
 =?utf-8?B?Q2NKdlBhSXc0ejNkRGJlQzhOeEx4Y3FheUNocEowYy9jcDdtZVY2S2xwTTU1?=
 =?utf-8?B?a0E5SXRRSHFUWlp3ZFljY3c3RDllVzZlNHZWREdJNG1BNzlrd2dNcFZxbU9l?=
 =?utf-8?B?ckVCTUpHaVp6Qmo3c0REZlBHYUNHZUQ1MGVRUkNWUjhvYjRhZUtweXRCSDB5?=
 =?utf-8?B?c2hmNzRrWDRXanh6MGNqY3Z1ZFRMSWlRVFhicXdYNXgyWWh2bGp6SHBLQVZz?=
 =?utf-8?B?UldyTndEZnpXTG5Jc3ZkeHg3bDAxUXZFRXRKMHQycVJCekR4WC85NUFVdjBB?=
 =?utf-8?B?d0NYRE4rVk41d1RqTXVVVzZ5dHVJaDBkVU9DdWN0Y0FlU09icUNyU1N2ZllK?=
 =?utf-8?B?UFp3dDF2OGFXNHdta2Nyc2J6aG1ueElMR3VBS1B3aGRCNW1OM2dDa05jaFJt?=
 =?utf-8?B?cXErT0l4MUlwVUlRTG1VSTdpSkVlL3dUdDh4eU82T0RoVkR0aDZiVm12eHM5?=
 =?utf-8?B?RmlYS3NkVWZ2QjNORFZ6Zm5RQ2txV3Q2cW1ReFI5OGJLRmhrSklxTWhCOXNM?=
 =?utf-8?B?YXpiSjFweHBrQ1ZPTGZSV0UvNGJpUkpwT2hVYU9mR1p2dmVkNGkwQjZBS2g3?=
 =?utf-8?B?SDVsL3NxZ3g5V204R2ZlMldsbXg2NW5HRS9Obk5GTE9VM3o4RjRuaU92T1VG?=
 =?utf-8?B?Z3kvbzJOOGg4cWcvWUs4TzMrLzZuRmZmeDZ2U0Z3ZFNpdkdrV29sNXp3Q2Mz?=
 =?utf-8?B?VWMvZFVaZExVVzE1NTVpaUlsNWFxbkcwRndUa1JndDZ3TitIVVBETkFhZ2gr?=
 =?utf-8?B?Y2dzU0lBSnoxTjV3czgxRkxJemN6WFdXOUdXRU44OEYzU3Q1QVdZTkNkWkVX?=
 =?utf-8?Q?NSgbbPHtuTFtd?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QUU3NDlod0RIVkJtK09rc00rRHNMVkVtZmJtZ3BiKy9uT0M4M3FFOEg3YzJ5?=
 =?utf-8?B?NEEzUFNZVjQzUkV4bURJdC9waXcwSXROZzB2VC9BVGtoYm4vMGRTVDVBTS9J?=
 =?utf-8?B?emNycVMwdVFFMkdpM0VMdDA2NXl3MEQ4d2lMM3FRNmtKUFRPNXpSTU92Vm5t?=
 =?utf-8?B?WlM3czhpUEhXWnZDSHNwd0lzaUNsV0dqVTJNandXeStFUHRLRFU1OUhYOWQ4?=
 =?utf-8?B?b1pIRHU1QmpNbVJlL3FnWlQ0OUt0czBWcVpVQTd2Y1NIMU4zRDdUTExkUkU5?=
 =?utf-8?B?Z2lRLzkxZktIUlJtK0JvaW9JUDM1blg0WHU3UDJacyt4MTlyeXR0NjQwNkhv?=
 =?utf-8?B?NCtVZkJFUFhuU1pVblJiOW03azNnbGExclpYM2NCYVZxNDBuKzFGRmJrZ21k?=
 =?utf-8?B?U2xRUTh2OEhWUEJiYzg5clJRL3dKV3ZYVGFFMXVES29QanFRcmZLVUhqYldF?=
 =?utf-8?B?bkdCekxSSXNHbzVXR1ZiN2Fzd2tEZUFMTXVlTUpnNXVnRytQRFlFM3ZUTDY2?=
 =?utf-8?B?L3IyM2hzZzFnYjlSdTRIT2laQUxhTHVjOTlNWVhVN3JXVVVEUFVqWG1vbFdQ?=
 =?utf-8?B?NVlNU2ZwOS9vbERVeWIwYzFXOHllanNURmxLaE1CdHNFUjA1TFN0RUJhMHJL?=
 =?utf-8?B?SWhubnU0RXdEaXdNUnpEcWhSL3lRRklUUHgvVGhYTnJsNk8reFVEeWxHZjNG?=
 =?utf-8?B?L2tRVC95eE1DQXVjK0VGNmx2MlFaeHVPMW9HNVBHOU5Pc3JSdmRYRFZ4K1lp?=
 =?utf-8?B?TWpaRnN6NkE5MGJ0Z2lGM0JQeWoyeEFpZHQrOUJVYWxPck1tZUVwQ2VORWRV?=
 =?utf-8?B?aGY1c0FSMzhoYU81bzdlT1k4UjJoN0lPV0dXYnJ2V0RQK0o3Wm9KU2VQMUNL?=
 =?utf-8?B?WE91eFYrRmw1YUlycHpEM3B0V2VzZVoxbFhaL2J4Y2pWRWxrb01OMlpPYTlp?=
 =?utf-8?B?RXZuZUEzQUhCVWtlVWNvK2RyNVEzY3djRGJoUmVBcmpCUWRIbUVFMVBrbm4r?=
 =?utf-8?B?cjNacVpLQ2tPVFBHaVVFQittOS9oQlkrRjQ1d0gzMjI0dnRzU1J5cmlOcWV2?=
 =?utf-8?B?MWhPS3ZyajhSTTQ4TnVON3h3ajRwRjFHWlRQYkVJeGhQbnB1V2k2Rk44R09r?=
 =?utf-8?B?OVgyNWdXTHhEMGh3UjRldDVTNWFmaW5OdWdVbE11NGI3UzV4OWRVckZidkNi?=
 =?utf-8?B?RTY1K2tmaFdORU9YdkliblhPZzlkNG4xc0ZUaEUwMlhUYjlFNkwzcEhYYUhu?=
 =?utf-8?B?T2loQVRXWEFIV3ZxNk1hcnVwaHh6bExjbXlRS2dBK3RqcjIrT1FBOHJIckhU?=
 =?utf-8?B?NmxrVFl1OWQrZzlCK1ZlREs3a3pJR1Z3YmtRcmFyQ2QwYjVhc2tnUjByRUJN?=
 =?utf-8?B?Mk4wQ3pMdElRRVpLL2RBb2NaYXEzRVN3UVEwODBhMHViT2l3RWRYaGpyNjJl?=
 =?utf-8?B?ZS96SVJkay9CbzNtYmVsb1lrY1VLNEh4K3BGNWFGKzVLVWdaL1JydXV2VFBs?=
 =?utf-8?B?dnhxaUJjQy94b0paSzhTcW5zdWpFSWZueFNQcmdrcExxeWpkOHZLcTMwcllI?=
 =?utf-8?B?dW42VWkrU0NFaVU2dG05SElxSVpvZ3ZQcDJ6NE5yd0ZSTk1LK1VNSjlKeXlO?=
 =?utf-8?B?b2lwSytGNEx6SERLZmpiVzk5cFZWYXUyOTR3bnc5NFMvWmpKQVJ6QlQ4RHY0?=
 =?utf-8?B?ZW5Vd3BNVG84OWpWV3ZxbU1NZ2tEQTZzWFZvcnlqUVY2UzcyUXZWcFNKemNa?=
 =?utf-8?B?Ynhnb3hYb2pmSE9jM0tqVmFkdEFFVFhqR0M5RCtNTGE0aEl3ZDY3dm1zemQw?=
 =?utf-8?B?dlVWK1FiY0VKMTAzd3M4VlpEL1JldVkvbnZCVVhxNTZvTzlyUWtUK0JiS3Rn?=
 =?utf-8?B?YXRxV1Z6RE5IVkU3WmVRQUZNRDgvSFJnZGhRc0ZVMk5aMzZFOEFKU29Tc0g1?=
 =?utf-8?B?eFNKZ2x3Q29VT1labUZtY095bGtmMVgrVVNJMWkxSVpsOFc3c1k0bEkra1dU?=
 =?utf-8?B?bVJ3RmtWbHFtaU10WVowWFVvT2lOTlBNaUNVcTRGTkN3OFUrcndBUjgrdWw2?=
 =?utf-8?B?R3NDYzFFSExleWZHK3IvWkFSWWM5R0FueVFNZUt0dEVOTndQWmFVV3N3WlI0?=
 =?utf-8?B?MFhOZ25ITHEwa0owTmpnaDZES2Fwa2dGN1R0YUNNNlJYY1RVTHJOejR2MWxm?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ff24fa-f248-43c6-43db-08dd5aea5009
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 07:00:57.0770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +s8j2CHCaiWWs3HcrMXYnfT7r6IxEx0HnyZdiwDEzmKE38YuiiSgLpuYtkZ6Oxu84FHRntPaH3u9KcddntjxLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7923
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Mar 2025 07:01:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18009

On 27.02.25 00:28, alexander.heinisch@siemens.com wrote:
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
> - Added support to expand partitions with btrfs
> 
> Changes v2:
> - Reuse get_fstype from mkinitramfs scripts/functions. 
>   Therefore, we could also get rid of mounting the partition
> - Dropped support for btrfs (compared to v1) since crypt hook
>   does not support btrfs anyways
> 
>  .../files/local-top-complete                  | 37 +++++++++++++++++--
>  1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 5ef7ca4..fac6db6 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -102,6 +102,8 @@ reencrypt_existing_partition() {
>  }
>  
>  expand_partition() {
> +	key_file="$2"
> +
>  	boot_device="$(echo "${part_device}" | sed 's/p\?[0-9]*$//')"
>  	last_part="$(sfdisk -d "${boot_device}" 2>/dev/null | \
>  		     tail -1 | cut -d ' ' -f 1)"
> @@ -155,6 +157,33 @@ expand_partition() {
>  	# Inform the kernel about the partitioning change
>  	partx -u "${last_part}"
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
>  	log_end_msg
>  }
>  
> @@ -217,10 +246,6 @@ for partition_set in $partition_sets; do
>  		echo "ROOT=$decrypted_part" >/conf/param.conf
>  	fi
>  
> -	if [ "$partition_expand" = "expand" ]; then
> -		expand_partition $part_device
> -	fi
> -
>  	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
>  			| grep -q "luks2"; then
>  		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
> @@ -260,6 +285,10 @@ for partition_set in $partition_sets; do
>  		 ;;
>  	esac
>  
> +	if [ "$partition_expand" = "expand" ]; then
> +		expand_partition $part_device $tmp_key
> +	fi
> +
>  	finalize_tpm2_encryption "$part_device"
>  done
>  

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

