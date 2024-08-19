Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69407C5320E
	for <webhook@archiver.kernel.org>; Mon, 19 Aug 2024 12:58:27 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.57])
 by mx.groups.io with SMTP id smtpd.web11.209797.1724072301931087897
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Aug 2024 05:58:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gbfcGdZc;
 spf=pass (domain: siemens.com, ip: 40.107.249.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x51teV5LN1GxR0gozD667w6ODrbBgS5lHUh39RtYm9oRk/heRK0euLVRA3JcV/wnhtvdKkySR34sRQ6wp8NvKJyGYJbkiePSv2L3XPU8InpMEMy252KZYFdRkt1t6B2lXArKJgxVAWf7O2BAdzb6xgYkViLgG5LRQeTHGUs9t4tuukp3r9rw2B5AI3KJwS08Hssbti4y/ZDRj2BkPQxpFTy+rPcU/OebdAiecwurlLjbT6vhkltCcaBjRusaOfvPU+PDRo/OD9nDb8LuLJxMqGkKRIG9B4Dkp9/YgE/rONYC3yDpaV+MG2LoP1dRUzPi3MXz6Q1PkS1Uqg0TaZnoPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FjXg6KPbWHAf2w90u5cf2mJP25ztVONvUOWbCXZoYg=;
 b=wgpAIsUlPIRwzPOApgzW0/lpK/Mh55ffEkgABFQrvmO9mQfSeSSbomsOHY0kXdXdiy+q4r1BSyo89VQnQ38zKRpIQdzSXHxujSoW51U4GTQkzbBS3WPbeCERQfMtqPlA0EKl+HnDkrTEuKBBNjvahHhHvictTY6eFXzJTShwY6+rPRcC1S/9j3kHe9zRoYsE9HtF/GLKH5sIG/Xiwu2p0yWIF3fl91icaiD/bwWOQihjFBTm+azupDvp2rLQfcQntKF4bEqJPBAL+hWkzQ8nPWQiglWb17sFHjjjUWSLNYeENoAt80J5jVbfYcJ8LqJLEhymVhcDle7D6bB4Lb2YNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FjXg6KPbWHAf2w90u5cf2mJP25ztVONvUOWbCXZoYg=;
 b=gbfcGdZcnT8swKGZj0sKz32bWZswT5KwDNJguBWFS8ilZytg8BWsiNKaV4zl3gV+VW9igZnFleZMEss5vzWv4XuRsqtqOev/KWpDwteUeiTug4zhT6hBQ4R0EJv09Y2IjCYdfUiUIsW3XjQIzpQASFjVj6+rGquTWf/7bNY/8SJP8wY9HhZjpG2gFLweLSsLGnWfzEr3wKvNcO4RyPMe8xFbw4NCZkMLei2+gOyosahhE7ba9LV6ZJ5J59I3bEjZjTvefhiUQ7n05QMzPZVIr4kPSJkYQgvYQBxV+5DqwIKjD586EN/3NpFx1Sf3Yl2JA2zwEuv9egiXpG3+LbnrPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8769.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Mon, 19 Aug
 2024 12:58:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 12:58:19 +0000
Message-ID: <8e97e886-8886-4a64-917c-471e6ea7dd2f@siemens.com>
Date: Mon, 19 Aug 2024 14:58:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 0/2] fixes overlay with
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp, Sai.Sathujoda@toshiba-tsip.com,
 florian.bezdeka@siemens.com
References: <20240819125138.1543399-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240819125138.1543399-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: fe559c1d-53d7-4cbb-ee96-08dcc04e9934
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SlVJNjJhU2tHcUVFdlQ1VTAxcThDRnJNRU1pUmVYL2QwdGY3U2VDYWU2M2Zw?=
 =?utf-8?B?bWp0eFc2YVdYcXNyQmU2bU0yQ3R6bUpYZjhpaHFJUnZZSjdzNzFLQ1RndzNG?=
 =?utf-8?B?STJ6RWVsZ3VqL0xCSGQ0ZVdSWHBJWlFocUpRSCtEdUtxR0pMNmtuUkZEbHRP?=
 =?utf-8?B?bi9UdG01bVV3MXVhYVA0cFhSOEZ3Q0FmNHEraXdYYXF1eEdiL1YvbW5Od2w2?=
 =?utf-8?B?L1luSG8vSkJYOURubTZZR1BPWVhDdGFvZ1lTZmdkbEVUU0ZJMEo4V2I5S0R5?=
 =?utf-8?B?c1JOKy9Oc2YzUkU0L2U0dmo0dW05VDBEbXM3QzJGZWZBeFRNRzVvcE8ySDA0?=
 =?utf-8?B?ZHNZTjlBMzZIaDdIZFhtdnFKSmt4VmlvVTBOclZCeUVQZjhwcGZHVzFRVUV3?=
 =?utf-8?B?Z0NtOGs0cXAyakZIQURjN0RmN0VCWlh4VTVjeHRpU1VTTWE5T1RUZGFvY2VJ?=
 =?utf-8?B?Y1dtTzhPZjhEeUFYUU9Xb0FPNHQwUTRkK2RNVVlXTVgxVHFpaVdHNUdrekJ4?=
 =?utf-8?B?WFllM2Y0K3dWS3BpVFNncVJkaDVyQ2g1YVpJSTArcWR0ZHJZNDVHcjMzNkJW?=
 =?utf-8?B?V2crWXZjZkUyMmliWVdBREJzTUpjeHJtbFVLUkhtRmpKb0tvY0h0MVZSYTM1?=
 =?utf-8?B?WlVDWCtMN0U3akRweGpUSk8zMjFKL21NUzVJWXh5Y2l6L214MU5uQnZ5T1R6?=
 =?utf-8?B?aGsxUSt6MlYzYlkyUUxSKzhkejl4T3BnS2Fkd3ErWjJGS1psZXphRVlJMm15?=
 =?utf-8?B?aWdUaEJ6UkJMZnh1UDJSNkxYbjQvc1pyRTd4aFlPU3pSbjZobW9FN08rTUJi?=
 =?utf-8?B?M0wwczl5UDdkRzMwVU9WZDZBRGtIRllDY2dReDZhUGdCSlNnVHZtUzZYeGIr?=
 =?utf-8?B?Q202c28rb0JodmRSb3lGaW8zOHlHQkVQUWxnbmw3T1dDR3czSHJhU2FxSjBU?=
 =?utf-8?B?ZjI1VXQyWCtlOTFzWk1Rdjc1V0RUNCtGelF4RHdSRnJwb0FMSGNRVEErdmxr?=
 =?utf-8?B?cVprTzN1OFdoSUh3MTd2Yk9RWWVGb0FLcmhIYlgvNGdrcDBjVlVoTnpicDlZ?=
 =?utf-8?B?cjJXajU1V05kVW9sbUxpcEtFc3BXZm9LOG45bW9ENCsyUjQ5MElIZHpMUzRY?=
 =?utf-8?B?L2JRUklGRW1qK09xOVc2aEoxczZ2QzZpU3lyNjdDY3ZBN0dBcXppSXlmdHNs?=
 =?utf-8?B?SGRhMVVYbEVySU9uQUdONld2YUppOUNUajFnc3Vkbko1UUNyczdTaXpxcGxJ?=
 =?utf-8?B?YU9uRTdlWWFsODgwVjZZTzgzUzRPOE5QNVJpZjltN3NOdGIxM3pFWXhDZXRC?=
 =?utf-8?B?NHRndWk3a2JBWDFvdEdDMmhTTTRjWC9ZZmljdjQwVXpSRkFGK3R3aGlsNC90?=
 =?utf-8?B?NitvaE5Kd2RvbFNCc0VZc2JBRnE4d1dPNXgyOXRpVjNlMXJQdHQrTVZubG4v?=
 =?utf-8?B?b2J0ZEpYbkE3a2NwS2RmZVlMZnZGWGdvSXZZRVVpNG5MY2cxRnRDUTdHVU1u?=
 =?utf-8?B?a1NERUpReEgwTUV2ZnA3KzJGcllLNHpiaGZuZWNMbU1YbUhBbEtUWTR3bjd4?=
 =?utf-8?B?MzBTZC81MkJwZWk1K2pIanVINmJvRjdpQkNCR3NkREtIZW9SNUNTMDZnWi9X?=
 =?utf-8?B?TklnMlFqSVRHSmRHVnB1QkRqU1ZvcS9MQWh3WjlZYjVCWkIxTk5uZXdFeDJz?=
 =?utf-8?B?SmswRFZvdE5FWVJuTG5BSzNCcC82bWhIK1NDN25tZTJJRlU4RlQ1MFYwNWlt?=
 =?utf-8?Q?0MepJ7wHeuJ6J1/6Gk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dVQrZk1pV1VSNTEya3lxZ3JpOVVLdm91b0RoVzd3Q0lqV25JV1VFdkk0MWYw?=
 =?utf-8?B?ZlBzb2VsK2RDbiswNXE2K2R3Y1lQQzNoVmhQVDhtZzhDcVJWMkRtTzlxNzZR?=
 =?utf-8?B?VGJxaFY0UE1DeFJmeE52T1ZqUC93TlZjV3FLRHVwK1Z3YzBUK2pXNnMrRVBa?=
 =?utf-8?B?Rys2Z0VTTGF4YVQ4WUZVZmxGbnVmU28vamIrQTdsK0dMK2tWTXphRllHRjVn?=
 =?utf-8?B?R0lpWTZ2RmdkcGZtMzY1TTc0c093NUJXTzkwck9YQ21ZQXdzcEM4VjNZYUNq?=
 =?utf-8?B?cWwzRmhYOUZ6Y0dUWi9IaEhmYmYzaGlmUTRXUXo4Lzg0bWZzb3VGVFRYMklp?=
 =?utf-8?B?S2VvVmNOcGQyNS9pUUR5QlFQVlZlaHdYU1JCNEJ0U1I4Rlg2Uy9tWHBlb1Qv?=
 =?utf-8?B?Z3V6aGgwT0FQVUlQYkxWRldXbTlEKzk4ZDFEVlBSVlFBUVZqb3Zvbkc3c3hu?=
 =?utf-8?B?ZkFGNXRiNUU1SHVRd3dUc0Q5K1pBRFBQd3lPSWtaUUxkWmtZNWowNzludkQx?=
 =?utf-8?B?SGoyTHRVNE13Q001M2lpNU5aRzM4MXM1SVNmS1NoWUhCaTdEUlBIRTJyK00w?=
 =?utf-8?B?WlBKTENqcHdPbjdmdlZ1cjNNdk5SVGlOOTA4enpUU1dlQXFudmszWThmT0VN?=
 =?utf-8?B?NDJzaHc4OGh6aE9ScDd5dHdDaFpQckJ1OThJRGRaVVRzNWlpM0tMWnozTmNH?=
 =?utf-8?B?SVZ0M3czcEpKaXN0U2VtTHNxbUlrbXY0dmNEdHpVd1docFB6QlJUNlo5aGxL?=
 =?utf-8?B?VVpHUk91aHJwV2RYWFY5eTBTSEl5eWtzVHFFbjJ0djd3Z3RPZ25WYWl1UHhG?=
 =?utf-8?B?YVBCK3p4a1FEaE1SK0U3YXdzYkVJbVB5d0FTQkxPNSs5YzJ4RXJnSi9XK3FH?=
 =?utf-8?B?NkluUmtJL0JLd084dUR6WnhlcDJLRjFGQ2p4QzB3elR0L0xyVzlDOWx3Zks2?=
 =?utf-8?B?cnBWY1dISmtNcUp6d3J4bXREV0t4dWZBQzEveEFPM1ViSG1oMGlqL0hDYml2?=
 =?utf-8?B?TWhHbE0zQ3dCRWxGYnZMN1A0TkFtRUpqQ3o3NEFFaDZRaTlDL09GMGlmVG9D?=
 =?utf-8?B?Ulk4MnlOdGtPSjR3OVcvSUdWUCt4YWVweGw0L2N4REswcUgyVnBWejcyZnhj?=
 =?utf-8?B?YVhpRURqMUZNL2o2WGNQVXRJQVdac0hYOXh5WllnZUZPZlM4eUNoemphMnZh?=
 =?utf-8?B?YkpXM2NwVDRkY0ZyN2ZacXZaOFdhMTE3WFVMWTRTNU1EYk1PQVRXWDNQaDVw?=
 =?utf-8?B?dUdmTUp2U1dSditDU1QxQlBzUkhFR1o3d3JldElpY0ZiWTdSQ1FrbUxISGxH?=
 =?utf-8?B?VGxock9nNUZVSXcxSUo4clA1anlVRFphSkFpRjVJbUIzNWtBcFozZmNPZ3U2?=
 =?utf-8?B?MDdZMndVTiswTk9WVjNHRytEZHIxTE00cWduVzI2eGdqZ2s2dU1OVTRpd0hW?=
 =?utf-8?B?Q0FTLzlnZ2hxMjJIdUlGTTJwd1FUeUpDc1FoeGJDNWhhRHNEWFBWQmFFTGVz?=
 =?utf-8?B?RkJvcmQyVDhtRzVPY25SeXg2SHNzY2EvOXh0eWxIZ25UQ3dDWHN0MWNYKzB1?=
 =?utf-8?B?a0xyaXY3ZitKLzA2U2JXZHp1UW93NjJ3RTBXbHFRaFNyTVp3T0wwWTFKRkVR?=
 =?utf-8?B?NkZoay9tZXB0cU5jWm5pYmtFZGxycVlYajVjbWFSRGRwT3NacFNBWUxZRTk0?=
 =?utf-8?B?VS8rcitSNURnMEVmdlo3MWpSL0dXZHZKUWJkUUJEWFRYQm9tdWtzOEswV2FB?=
 =?utf-8?B?SU9qNnBYbW03bFNnbEROWGRMZzgzREMzMSs1enhONS9ZUVhteTFmR0xjSUNv?=
 =?utf-8?B?RFQ5dWJwUEo3UEM2OFdWd0RlblV6cmtFOUsxR3VlRlBPbVpzcWcxN2Z6dmxC?=
 =?utf-8?B?SloydkxKajFyWHY5V1l5MisyOEFFUUZMK2JIL0FWNjM0eXBIQUkyTERYQnZE?=
 =?utf-8?B?MlVQaHNkMUUzNlBMY0hYVjFhMVFtR2FPSW50RkxvTnIxVVJKTnc2MVlubTN5?=
 =?utf-8?B?NWpsaFlNYnNadVFza1Y5RG9qL3JGZTVVUURKOUI3N1lhbXd2eHNUVzNLVFE5?=
 =?utf-8?B?MkJRNEt3OENNekdqWjZSVzZQSmpmUTdIeGt2QURFenhDRTF1SmRzUFg2VU5K?=
 =?utf-8?B?M1pxKy9QNlJBaFpNZkNHWlZiang4Y1ZLZ3UvWDR1KzVSaTRSWlRucFZMbThQ?=
 =?utf-8?B?K2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe559c1d-53d7-4cbb-ee96-08dcc04e9934
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 12:58:19.1158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFhQfFOwx+TPZIyTrf7vXaFIz8Rc9ErblfQmKMkwFsMmoLLAdrWkYfQyZE+8gfyl/pmBOAGBtPzqGcVGfTWg+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8769
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Aug 2024 12:58:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16805

On 19.08.24 14:51, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This series checks for a e2fsck return value greater than 1 to avoid
> recovery in case of a repaired file system[1].
> Also it remove the interactive mode in case the recovery script is
> triggered.
> 
> This fixes issue
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/113.
> 
> [1]: https://man7.org/linux/man-pages/man8/e2fsck.8.html#EXIT_CODE
> 
> Quirin Gylstorff (2):
>   fix: Check return code value of e2fsck
>   fix: force mke2fs in overlay recovery action
> 
>  .../initramfs-overlay-hook/files/overlay.script.tmpl        | 6 +++++-
>  .../files/overlay_recovery_action.script                    | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 

Thanks, both applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


