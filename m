Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2A5C02198
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 13:33:59 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.58])
 by mx.groups.io with SMTP id smtpd.web10.20934.1739540037334771008
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Feb 2025 05:33:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oORkXfrr;
 spf=pass (domain: siemens.com, ip: 40.107.159.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIF43FBn0ho14Pdy7E27eKD4ZPA+21DWzavg27BHwa89iGKjn2m3gbOK1sNBt6vmeyHEo0GD7m6chqXeDxyps9iufEm+8yZS1MxhJ2fm0gevzr2dD2pqSYRC4Re9aorj0e0H2/ceTqNPCed9h7+iwBIuIxo02r93SFUqjlUDvdVwwGOqKwHP4QYXNp3b3YVJGXKU06LesXK5VcBexWba3odi2LzdyedQbuuDE9fZvGovrHhAX2NJRZCyGycpqDLaVxpM9Y7uJxIkf8344kZLpLO7XzPo9GxmRLRS0CxNeJeoXXmjTNonIb/YShIqfA6spiQCquQbY16EaRG3t3G+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16HyZiEAF5d/kWBGTrJOyMKhU7e89xnZJffjZOLUjbE=;
 b=yC8Q1+wL63XoLiVEu2Yxo1Ld6ciN+gjh6gtmKXXL8y25v20/LmCwlYKp40qHd7XPHUWOZjAx/Vy9+/TrU6f/1E9h7Ee9wZ90D+0tjwlJyisXOqoJtPLykiKeeYKbZatn5c+wcuqZpFkr3gYn13PqHKCSlRNiSag/GSC++++mQPTxjHKzq0ai/AmTrwiZJ9Z07pgnjORbhUHfVugBBrNFGtdhIOS9NnNCBS3zRvSEaEAWWAyWCcfzhP9Rxo8mRXJFg4TuTP/cikbrYuKX539Gq9Sk7Bh/m0u97fp/qd6gvvU1sUhZu5kkp4ULWyHzD9y4C2htR02oTH7ugCqzlrUP/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16HyZiEAF5d/kWBGTrJOyMKhU7e89xnZJffjZOLUjbE=;
 b=oORkXfrr6R/AO3an8f5L7tDwCNM4l/pJTsanljQeaqUYu9G0MulgxV24h3sz2/Q0MqSiH+EjzNCv/bTNMAYBrjzH8jsL/4yeo724x//MXnj7bouUdfuK1XgF1uLA6UqmLxT/7NPFuzHUYolXZyJGbAN1be/5LxLHu61ouX3RbWloQ0gwVrZeD0oYnCCIIcxynlR33BevlJQ9ZGS+ath7xcGib1hjQOfKRh0JSzZH5lyKr7dFK0fbcptlAjnCxxIGerPbYxfaVMDNMT1wNjx14iT3Dq8FIoQ9b/dgxLTlBcgcqBWOHZv6sxN86hPaV8szgT1Qqz8BeNLpPkJpzToIcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7056.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.5; Fri, 14 Feb
 2025 13:33:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 13:33:52 +0000
Message-ID: <3c4f96c9-20ac-4529-9d34-7c3f3f147a9c@siemens.com>
Date: Fri, 14 Feb 2025 14:33:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] Update isar revision
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
References: <50913583-4cdd-494e-bac1-1cbe8c0f761b@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <50913583-4cdd-494e-bac1-1cbe8c0f761b@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0443.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a6fa05-7bb0-4a8b-48b7-08dd4cfc38c0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Z2Vnem96T3c2SnVCSWI4bDNHSFdLcURSVS9JdGFhZkhOS1RoN2ptSS8xM3ox?=
 =?utf-8?B?VW5lM1RJSW5penBQNmJnR3haeG1zTW1teGliTnJQaEM3SENUQVFNNFBSV3ZT?=
 =?utf-8?B?SUpDTHVidmV3VE90SjFEdFp4dmxRWnQvRlBsTmZCcDdnMVdlYjBhamJSay8z?=
 =?utf-8?B?Tkk4QmwzUTJKbzBsVXhhbWxhanVuWFB3UVkrT2J0VlpqTzBZek1RaG9qRW1o?=
 =?utf-8?B?UXVnTFJFMGRVWlpUd3JDa21aODNBSVBCakpVdkR2eGtzalh0ZEo0UERBYkJ0?=
 =?utf-8?B?Qjh1OG9aeEJyYVEwMnZCYUJVZlJJcUlRU3Y1SWlXVUxwUkw4WkY0R2JmRXVX?=
 =?utf-8?B?ZjFrbC95L1VmL3pwM3EvUjNKdTBBWW0zMlBaWk5RT0tENFZqSFVLZnFNcUdK?=
 =?utf-8?B?VVM3OGU0aXpuNFZTREJBSnI1dU1kbjdNVTJiZUQ4THRCdzdtZ3Qrd3hYMkhl?=
 =?utf-8?B?NEpURzdKMEE4MHZhVnhrVjJoRFV6ejlBS3d0WlZzT2xUeDhPbXBXS3JVQ3RB?=
 =?utf-8?B?MExEcnR1R0ordFdDTG1CQTFEL3ZYMHArM3BiVzhRWW41ajhTVEdPNUxGSjF4?=
 =?utf-8?B?QnlSZUx3dE1aU1VscW85SUhrVWNQcVRPclpiK2xpdzZPZHFkd3A4UGMyMkNx?=
 =?utf-8?B?aHdTeGNFUTVscVNJaVJ6cTRoeGhJRDNCQVVYZG1VQTFSa1ZiZklYVHV2TkFk?=
 =?utf-8?B?eDNvQXpCMGZNeEsxeEFXY3dJcStVMHo5Z0J6bXl3Y3I0eUtkM09UN3dwRGU5?=
 =?utf-8?B?OVpQU3dxWVpWaGhtemxSNERlZnhlR2N3SnV6L1R0SG9JdlVVdmRmbHlKV1ZT?=
 =?utf-8?B?cWhaTmVuaG5uL2J1RExxUzU5OXNMVVdjRFNBV3dkUS81SVBzWGN2SWpTeEVj?=
 =?utf-8?B?N2JCYThONExLalNBRmxqK2s0aDVYVkNHSmdmWXVta1o5WmpzaE5ab1VrcXQw?=
 =?utf-8?B?ZTRhT09aV0g0bzVYRFpuRjhmTERCd0RIRHZuekFoZ1Y2TnZZMTBnSit0aE81?=
 =?utf-8?B?Q2kvTXIvQUxtRDRQZHY2TjRnVVQ3c2pxdFpKK0t1azR4a2RSa0IxeFZjbzdQ?=
 =?utf-8?B?R2YrN0FqQXhDZENwbnpoRUZqSzkzT3M4YWVBa25aT2NWUWl1dEFHVkNNVStJ?=
 =?utf-8?B?aFpBdjZ4ZXVhSEMrSmxSYkZqcnNtc2J5UUZVNmRKdkpMYWhBNTh1N0JPQ1FV?=
 =?utf-8?B?UVRmZjYxRENvKzZ3TDJiMjhCZitnSGxzOVZXc284dExYVDJndk5UMXV4UFJ3?=
 =?utf-8?B?RG56cUdzcEMvVWRLeVpkODh3T01qL1o2bTh1c1kwYW4yMjNMRDhMYTVjWlNG?=
 =?utf-8?B?ckZ0QjBHMFdkRHdxbk9aV0FCYXhwNDV6UVc3cGc5NzlHV2tZZkgraTNQZkRs?=
 =?utf-8?B?Q3UzV0FkWEhrZFpjcTFuMVFuK1A5Lzl0ODVnbDF3Qk0zM3FRcUp6RzdYNjB4?=
 =?utf-8?B?YkRNR0xzRStMRm1xd0ZnZERFMWpwQzEzYy9XbXI4NkFTVm9YVFJtSDhDZFc3?=
 =?utf-8?B?ME4yai9GUnJUQ0NwUEFQMU02bXBreGM3dUIxcUtTVHBIWk1DQ1Jkak1Fdm1s?=
 =?utf-8?B?VythbWhyY2huZVZYaHgxWTFTZHNVbTFHcUNzR2haUzd3SnRFK2NNS0FybVBj?=
 =?utf-8?B?YXlURmdNb3k5MTBTUnFBWnpuZjk5Sm83VWg0UWN5WlpFRDBmcEFWcmxtS3Mz?=
 =?utf-8?B?OTJhajI3K0RiTU0rQktSN3d5OFRWUTFMbXNiTVN1UlIwc2kwaTlyaDR6RzRS?=
 =?utf-8?B?VnZpYWpKd25vRHJjRHovZE9IbXFSbzgyWGNLN3NTRTBtdjBDQXdYeTBDczhx?=
 =?utf-8?B?QXM3cmFSMDlSc0pPNWJRMTc3VXdhQ3N4NXRCYlFBTFUyQnEyT1c4R3dMOCtm?=
 =?utf-8?Q?5MJsmti9ivf02?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bXkwSFl1RTFLLzltNXIwQTFGQ1NsSDZ5Nm5WQlF6S3NGNDVhNWw1YitIVk5J?=
 =?utf-8?B?c3ZHMWRXWVc4dmRWNUpFcTRoY2ZjMUdkNExSTTEzYlhvb0YweWY5QzBVSGxE?=
 =?utf-8?B?M2dXdTJQRElFN1R1TVRlNWlKMFJ5blNsK0xaZ3BmYmdnbS9UVS8xMTl4dFk5?=
 =?utf-8?B?OUZpYjhDR1NRWldGd2lxUnZHcTJMeXBKTnFITHJrYXpRQ3ByNFQ4bEpSeEV2?=
 =?utf-8?B?WEpKUXphS2ZYVmd3UDJoOEJRK0dzK2Q1bXZXY3pCbDNBd012WE95a0ZkK1Z4?=
 =?utf-8?B?eC9hdGVhMVdldWhwMXJSajBHbUowUlhOdXF5S0hGL3dhcTNkRVcxRXVpSXpS?=
 =?utf-8?B?WFR2R0l4ZXFvVmQ2ZGMvS3pEQnRQandmUEN6SnlPK0ZFNEFuQUo5b1orcWNS?=
 =?utf-8?B?VkZFb0t5RW0rNnBXNUI5S1VEU0MzL2hkNmRNYkRSZU5JV3E0SGsyaThJTkZm?=
 =?utf-8?B?STRHUmc1SVdwaTljR2duM3d6Qm5JTFF4U0x4MU9YbnpUSGg1MksrK3Q4R01K?=
 =?utf-8?B?QmdKLzJGQ3BqRXhaMkh3UEFVYktuWE52Qkw1cTd5UUg4QkVVNnllaEo0TVZ1?=
 =?utf-8?B?OGxzM044ZVA4MlBUdmljNmFZN044bTNTMmtTaGhNdDZ4bzJmekVBUEZvTFF5?=
 =?utf-8?B?bU4ybmRQUEUrUFV2aHpzTnhydUlBSUtCdXNoQzZoWFVYNzNrcXRMZlh1UXJp?=
 =?utf-8?B?YVRrdjBGZDNjWHQyclI3MEdoWHU5U284aGU0WE4zZitFbjY2dk1WVGptNGlF?=
 =?utf-8?B?cmR0V0RnMWIwQnhySFlrenYrdjJtSnJ1ek55bDNPaGF5cEEyVE9MVFFqVEFo?=
 =?utf-8?B?eTQyYmhsMmxVd2hhZFZod09XWFFxWmo0RXEvTUJqSFV0NkZnMGYrMjQ3Vzdm?=
 =?utf-8?B?YjZvanRMdXljM28ra3FMQVFid0FMUDNMTmlWbTh6Sk5YTU1KWlJXKytBQUlw?=
 =?utf-8?B?Vm8zS0dWNmJ0VzJaNlhqVWEwdG1KNVpIaXBRSzJkeUdNSFliVnkySVVsZzNP?=
 =?utf-8?B?TUs0QjBQZ3JsTTZWVFNQMGdjZ2FLWWFhUDQ5TURJaUR5aDEwRDlQeEFpQWZR?=
 =?utf-8?B?RTBhNU4yRDB3WDhUVk1pSVBWNTlZY0pLdEd4QWh2TS9xMFZsTmUvbU5QVmM5?=
 =?utf-8?B?SzVpM243alRQUnZaSjJkblM0YjNML0tnYWpRTWUxQUh4cXZyclJ4Q0FQcDFC?=
 =?utf-8?B?SmpYRFVSMWpnc0o0K2lYUjJFTmdZaW5rREpGRUlEUUUrVm56dnN1OThXV0M1?=
 =?utf-8?B?bjBsLzZOZVd1Ty8zSVhIRDUrQnZjV2Jsem53QmR4R0xpaHJGY2xhemFjYjI4?=
 =?utf-8?B?VE5KVW1NQ3ZCNDVFc2VHUU5lUFhzSnEwcXpUaHRhK1RjMmkybG9od3RJVHpx?=
 =?utf-8?B?TUE5bmxFTmlWTEJQWUczbXlpenBvdzZOZEpUMnlqTyt3VDlrVDZwMVluS2ow?=
 =?utf-8?B?Y0huZGpjWmRhdlg3TmZBWGRFd1luaFVvcFRLbXhYcmhvb2RWOVJxVURodGNG?=
 =?utf-8?B?ZlJ6WWk4OU1VZ3VrMkQwRm9DNzZSZWV5RDdJR1V1djFOSjV6Unk5a0c3UUNO?=
 =?utf-8?B?cDNpbzJWaEJVNjlXTkcvaVJoTjY3VVY5Ym1LSzlsbFhEOUpGR3FBSHFKR1kr?=
 =?utf-8?B?MzRDMlp6V2d2cVg4eG82WW1DZDIvUU9LbGI2R1FWdm04VkJxTlB0cTc0ZGRw?=
 =?utf-8?B?VklYQkQxdXhuNFpmUHM3OXduSHEzSDN1OVRHMGFLMVkxOVlsZmdJVG5IS3kw?=
 =?utf-8?B?d1dzZmd0RnVnSnBxblgybHhrdzVwNTIxalNrRjBiMlNCa2JVeHhma0o0M3Y1?=
 =?utf-8?B?VFNHU0N6Slg1eGQ0bzUvbXcvNWVvTWg4aVZSc3B3UlcvQ1hndmFaY2ZGUVdy?=
 =?utf-8?B?R05aL0N5bHlkeS95ay9lOWxodG9PZ2k1TUUvOXQ1c2hhaXYyTjEvU3NCcys5?=
 =?utf-8?B?UDlyKy84dC95TzFreVRXSE1Cb0tENFhkVFoveHBVV1hZclBCZ0pORnBDRmFp?=
 =?utf-8?B?Q3lhMmdCbC9TRzRUTURXaTlHeVJTc010c1pPcVNWTGcxb0s4UmMvS1ZrQXVO?=
 =?utf-8?B?U0QrYWpSTjkzaE5ld1dRUlBwU2RlMTMxd21KUlF4ajN6SU53N0FGNGZkM0JC?=
 =?utf-8?B?cTF4S0xEUWFXVmMrK252L3cvd1NzRnM2SFpYMlFnM3FXM2FUbUo4RmNsemYx?=
 =?utf-8?B?RlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a6fa05-7bb0-4a8b-48b7-08dd4cfc38c0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 13:33:52.5269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6qr4LY7F7EH806NYncXCZRkkg8kc8T6Y5OQpqOSPqsSzJmw6cDgw3WnxD8AvSRKqU9O/+c4HJgQx4U7WbbIKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7056
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Feb 2025 13:33:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17846

On 14.02.25 12:01, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This brings our squashfs class from isar upstream. So, drop it here.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> While there are still known issues in isar that are waiting for fixes to 
> be merged, key problems for us are solved now.
> 

Argh, missed that the linux kernel build fix is still not merged. Strike
this.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

