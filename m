Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7978C54E71
	for <webhook@archiver.kernel.org>; Tue, 19 Mar 2024 18:37:21 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.73])
 by mx.groups.io with SMTP id smtpd.web10.23861.1710873439913565532
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Mar 2024 11:37:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rdJwZ8Ww;
 spf=pass (domain: siemens.com, ip: 40.107.6.73, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efy8SUWyI/DxuCq4pwHTjGGglJeSMFPAZfrd7abSlGwV5yLau1ZRH56JD4nGj/ITZ9L6/vl1koPBDjyDE5PWm+fZSfKHlhwpr78Rb6gvklhKg9jUUBSHzkwGF/P8hmSJY1qbjwAW3C27xqJTw8TNLD44P2mnS+TTT1arx+2pJUy10lQMQKhRV4Pt8cSePTylyf5VZOssqro1zvtWiFg2ns4h0wGDKEypKPZ4y8NvCFdZwEc6Rp32H6WJ+LCJFndPwB6xQQ9Ix0qIlrhaXhGvSUcDpL9JbHb4uB0e/OOvCnK70E9rf8Uqnp7CmLvgwTYfqswjtWbZO3asQmP/hifegw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cpACFOBssKpj6uuWlCd88Rqk2qbNDoPIG0M1VN2GMI=;
 b=ERglgptr10bUwFn4MxIlAhLM/TGgPWqHuj0qFhXkqjHM7uWC7UmSXFhK8WjEtXSuv4glHdX3Q2NhL9XtJR4SCfqdoUKYhY2AFnRI6zUZuZKGF++3mJOmlkkqRGx2vsxGYCVDQK+POV21PeJijUVQKDyJ7qfmQ/KffQmnR3tK9ewnFfD9L52evfzJBnKdlwCtMa/H7MNOOEeltyoTb5OqsDi02HW3l/GQaVQHdR3+4cwM5myuE7ofeztRwbHH++rdDwcXtOdSnm4I7zQMKCyXDKR9OjuVwMmR9W5JDuXSlcqEc7wVT8y2WEAb5Gn+jUWjd+g9OsYfLEo3/pyqSz2zGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cpACFOBssKpj6uuWlCd88Rqk2qbNDoPIG0M1VN2GMI=;
 b=rdJwZ8WwXUpnWwacqxUYANTU02XzjKR8Q7VYbYjTLJkDlKoh/3uZ561je8TyvzeRnp6WV+8ah/6TFAVGc/0ZCJSkPz4/Q8zZYsoVOF/rnPRf8GNL851KA8I3wWKDRehfYaXM4UAo7dJ6TBjlcIXL+iEh3izlfyHeCxKIN19T7BcFRFgEdgP+4bsUHIoVfeALnfUHVQ1cgZTwjGVK6PNrJkFR83w3KDd7ZBlgyqU//kz95x+gFNjH306FuB4FUE4loXiYQaiUBRSWLv72+y2OXYip3iBGEdf25Ylb1MKEnpuz9/D+x6ew1OwaY0pcY5XnKRePGOuFM4mFKD8ZoylzFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5393.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 18:37:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 18:37:16 +0000
Message-ID: <4ff78067-10ad-4715-93fc-578439f49ab1@siemens.com>
Date: Tue, 19 Mar 2024 19:37:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 6/8] initramfs-crypt-hook: add
 e2fsck to avoid resize error
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, johnxw@amazon.com
References: <20240319182026.1571362-1-Quirin.Gylstorff@siemens.com>
 <20240319182026.1571362-7-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240319182026.1571362-7-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5393:EE_
X-MS-Office365-Filtering-Correlation-Id: df1585a3-3108-41ae-f1aa-08dc48439a34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	a6DSTanUi9DyL23OznP/zhNW3uW1UepXPFx1yAhCCXxz1mJRXedIa58Ldzub2MgTjI0s7Kw/YrlBgf/N6ruHEc5dvJ+1e5Skh4C64tOcpTA+M4pNH02E11XLPvJYaQh/WLe7O945CTAFPABcOWQJTt/d+qjqH1q3OQDFs2hbncqiezV5RsxJj9H1DhCdGARBvWyxp+8er3zYmrs8c8yHoh0ysVm/GcezE3jN+JhWj/Rg9+n5D/iyFlo9GbnxmqrHNeiyMaC6YGTaT9uZk07oLLwQ3UX5Uwj3tsBKg9bGWOiEcD9Nv5TtmkpzpgYrDmGyC2QIAK01w67R2iRQcJcP/5hwEOhz8DYsCoeRSF1CQRunzfLLBD+JP12324OEysJHN/lDdJ6adH5tKkVhX+VyCNzguSTAwzPfCwEbCfYFP4s7jjPBzh/VNogVHpVDv55yzGgiRuAmdCIO+7W7+fUwQV1gyrUIv3bgE6nJtfzWCZZyAgxp+gd9AGYGEOgiduRfKgUmI9uWBTg5FTfDij1KnXcYZ1qUQj1aHxsxy/hrFCzDgfs+E00KZSFKagQqsTSopmvzGE8W3rdrKnuHQym4KhsDSoDNBFZZCuwlRsjMdbsRzEyeKEwCu2xPCF9mV2hoxoIQdRVlD2XIjlXw2HTT+IlYyJSR+lQbRL6jHPZdJLw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M1RIQmcwR0gwVkkyNDNnQnlyRU1heXFZcmswZ21TcFNZNWUyRFpJd21hYXdk?=
 =?utf-8?B?NlJBMVJVdnVCTVVVNlc4d3QzSVQ4d2lDSXZJT1VFaWMxeTRMVk1ZbXpyendl?=
 =?utf-8?B?NitqQm1UWUJ5Q1ZkaER2d1FZd01mY1MyRHZFSDUwS05IMW5vak1PYXZGbHRO?=
 =?utf-8?B?c213aVl5a1NycnRyb01IdkdKTmw5OVpBUE9mSEVYWUhwUkhNSndNWEdNT1BJ?=
 =?utf-8?B?WC9GVVFlb25KN0dyV1NkZWgxbURBeDFnTUlwaW4rZVBpM3JLeklNZFZheEdC?=
 =?utf-8?B?bC9JYWg5aWZlbSttbDJkcFRhZzFWeDJqYmFvQURqaktJTW5qa3czdEpmVW9w?=
 =?utf-8?B?bmR1R3YzTEZ0MEpSUmhHbGxpL0o0MlVqVU81Rm9ocnl4Tll0bC8yblFQMHhI?=
 =?utf-8?B?OTY5eVpDMUNlcVpaVGRnZW5qTXB4eXZMWjExcmF5d0hKejdaNXpNamVHMGdi?=
 =?utf-8?B?OEVYUm96QkZVaE01a05KRkNjYVNCSWtwa09QUzY2bk1sRkZaOEtBdnI4cTRZ?=
 =?utf-8?B?dzRsdEhva3ZGQi9yK3pXNFQ0QURnSVU1dWlMVm9jTHMvb2N1d01VZHBTV1lB?=
 =?utf-8?B?NDhHdTVhQnZkaXpwNVdkUUFRb1NVVWJNTTNwMnpHSm5EOUtWZUFlMEtETHJT?=
 =?utf-8?B?NmJadzlsSWhhUkNaZVFqZHdlaWtVSm9tZ3ZJc3pBZkdmOGhCa1NtWWpiYU1a?=
 =?utf-8?B?cnNvVHhhL0xjQjlnMW14dFIyQmJoSlJtODhIZER4eFM4aS91aHJZVWQvOEF1?=
 =?utf-8?B?WTljMW11blRLMmJLUURqR0pCdTR0U3duOFFiTi91S0NCOVpEUVhMakgzZWpH?=
 =?utf-8?B?eFdvN1pTQ0JqTXdkaFBjY1g5c2pkOW8zdzRzZ2FKNTczaE5STmgzVXoxRjFa?=
 =?utf-8?B?SER3VVo4aTcyUmc0eFJhUWwzbnFLOEgzRWNKamtORHhDaDhOOTZXOGRGbURM?=
 =?utf-8?B?RVczNjZBTDZNdm8wczk1WFlxM3ZJb05Bd1BDdHUrWVNMNVNEd1FyRDJTRWhh?=
 =?utf-8?B?MFFlM1BlSXJBWUhFd1dxaEYrRlgyM1NWU3FmVTZWT0ppVTVZMWZFVUI0L2wx?=
 =?utf-8?B?WVg3QnJRejVacW1UMEt2T1Faa0JiWS9uQlRsc1IyVVZGYXdQSW15VXBuTUsv?=
 =?utf-8?B?cE9GZWtydXdmdTY4SG9DM0ExYVoxMXcyeld0dGJ1RitQWGMrMlg4eFYzY0RV?=
 =?utf-8?B?dHpRcmIyTVZRWlpvTGVtOTlMZ2VjejBUSWh1ejUxMVBjWTByUjErTU0vTnd2?=
 =?utf-8?B?WDV4K0tIaThBdE9OSDQyalRDUzlDNzR3aWFSdkRtL3hiVy9oVlZJODBvdnov?=
 =?utf-8?B?d0xiWW5IN3RyNVlHeWpQd2JzWFVUT1dKNDlNVEh1b1R6M0dEOFVmN1ZCa2Zi?=
 =?utf-8?B?Y1JzVnd6dC9BalczT1FGWERLcDdMTW83VmcxSC82YmN6RDhnOTRtcExNWGtS?=
 =?utf-8?B?R1ZuS2x2N0hGUkk1RVhBbkJhaThEWHhFeVUwZU45S3ljYkZOQU83Q1lsM2dU?=
 =?utf-8?B?aGJLV3FGVncxbFVHY1ZEVGlrOWtZM0lRYWpBNCt5NkJLM0c0M1NMTi9uM2Na?=
 =?utf-8?B?Rm0yNWZTQzk2WHN5ZVpGTzNzZ1lqU1NWb0V1TytsbExwUnVNS1diSU1YNEdz?=
 =?utf-8?B?K05OUFhMd3NPZ0lsTTFJbkZOc3FudHRGdzV5LzhvT3EwVUxzZWNzRlF4aGxY?=
 =?utf-8?B?djFKdS96VEIrSGFqTVlHamZNclhsekI3MWV0OWIzcEk2emQ3T3FVWGgydWpM?=
 =?utf-8?B?UTRYV2IwWEZUaERNMVFOUUwxOXlQMVVqSWt3dlU2MFRnME5yTnlHM2NoWWdm?=
 =?utf-8?B?cGdtYUJtVzRRdFBtV1JFRjFCbVp0a3FFRmFXM0tFVGJMZ09ZUi9yTTE5bHJq?=
 =?utf-8?B?eWxtMmROS0YzcHNIRGNtMWFXblE2QS9ORlFuMkdjRGplYUxaaWlGNUhzNDdP?=
 =?utf-8?B?OWJUK0pKMzhnNHZlZC9vRlVuQXpiVFNueHRNYkplYTB3NHBDL2RPakQreFhu?=
 =?utf-8?B?SG51cmdiNVRERWVDWUVzMUlDby9WdDhPeG54V3BxWXNmak10enFsaFVIRzFk?=
 =?utf-8?B?U3BYRWdGRE1uTmx1c1lzRkk1Y2ViMUJrSTE1Q05Pcm1qUkRSTmNqOHJxdmlr?=
 =?utf-8?B?ZUJhbHFSSDRHUFRDLzhzRXVZbGF4dDNRbTd2ZEZZMGdNL2R3Qi9tNjZNdi9h?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df1585a3-3108-41ae-f1aa-08dc48439a34
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 18:37:16.7776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4BvhlAWp44aDzU2mFD+t+eN9Z4z8CWY0k59ZTegPtRcdKAp1IVwAXwIFHoGv85aEBIHkjv3UMnHw1BlM+Kr4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5393
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Mar 2024 18:37:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15377

On 19.03.24 19:18, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This avoids the following error during resizing a file system:
> 

"Error: Success"? Or what should be here? :)

> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../initramfs-crypt-hook/files/encrypt_partition.clevis.script   | 1 +
>  .../initramfs-crypt-hook/files/encrypt_partition.systemd.script  | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> index 6e2713f..0bb6720 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> @@ -81,6 +81,7 @@ reencrypt_existing_partition() {
>  	reduced_size="$(expr "$part_size_blocks" - 65536 )"
>  	reduced_size_in_byte="$(expr "$reduced_size" \* 512)"
>  	reduced_size_in_kb="$(expr "$reduced_size_in_byte" / 1024)K"
> +	e2fsck -f "$1"
>  	if ! resize2fs "$1" "${reduced_size_in_kb}"; then
>  		panic "reencryption of filesystem $1 cannot continue!"
>  	fi
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> index 2e6691a..9809c87 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> @@ -94,6 +94,7 @@ reencrypt_existing_partition() {
>  	reduced_size="$(expr "$part_size_blocks" - 65536 )"
>  	reduced_size_in_byte="$(expr "$reduced_size" \* 512)"
>  	reduced_size_in_kb="$(expr "$reduced_size_in_byte" / 1024)K"
> +	e2fsck -f "$1"
>  	if ! resize2fs "$1" "${reduced_size_in_kb}"; then
>  		panic "reencryption of filesystem $1 cannot continue!"
>  	fi

Jan

-- 
Siemens AG, Technology
Linux Expert Center


