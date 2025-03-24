Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3763AC36005
	for <webhook@archiver.kernel.org>; Mon, 24 Mar 2025 11:28:32 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.69])
 by mx.groups.io with SMTP id smtpd.web10.37079.1742815706768952521
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Mar 2025 04:28:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Awd4ZOCW;
 spf=pass (domain: siemens.com, ip: 40.107.21.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YA9W612I3zAhIay47u/XGpd0EtQqo46P7v0m6rBOkq1L4TOx85l9KNYXXs3pMXV/89BEiE9aVu99/3wTRC5saSIvSko5i1i8cfjVS6G1AFtfNcQDPRSLEOOVC7MN+h1GCjlIoFccl/yXGLFrGNslioQ8wDfJzKBZDON5vJANALIL4Dv/nbnikV6i/B7JBWPFF+8HyRhIcrFfey1bUwiiNYzRN3zz+XPZyguNqN4FMPP4LgvFr6wY70FelpvTAG2RWdYJ7TPFowaLMxHwN9CGDiTtGmTDfMGX+qXYxdhcTvl+mv3JxYNEcJhrO6lH0Un1hyklLuTFNO5XyEB2PNTIag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wEriWTSXnedQOr2FGoLPRi0c9JU33dWU7MzGnT/Ry8=;
 b=WCMWC+qGqyjpJbqn7GYHBD6SaOCNiuFkEK5E7abB3pq+AmwMnGaziAJOAcS9r4GZA0W2YKt9lBz+BCN2i6W2/TLibDy9ycNxLVDyXtSdpgbwW2yA1TWvLZCY1NKuc2W7hV7VKE5JcEDAQ1bA8ODcB/TKQwFxOsXIAFgQmBm3v1xA5GYp+Vk9/1ehIcHnGVvUIA2s+2PkktJbaYupjw8AY/z7o7RNB5GnZ9K3xBTZ1r56NmZcCfqVBi3w0Nza9RmRMWO5IIOl5DgP2tMrVfUscXL1kOSeFaShchGpaUL2mN2h+T1r6itNcB2HJfNM3XuJB9ZFnhSEkDJf1lS4BXzBIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wEriWTSXnedQOr2FGoLPRi0c9JU33dWU7MzGnT/Ry8=;
 b=Awd4ZOCWDyXPEF0pgFANRgW6Tp5kOlT85tMW133hQEsjetRcnr2MIalnstTzLWRcOVws/mDfdvQP2z9d0a0jQMrXoYvbOFxy4Y422/9yC+QDYhWX5jwfVbmckNEqRk5BQHsOQzqD+SslfS39YYrSTVHbUlN8u4FIUq807HmQJySmKVwywmudtrfNpJA5FtG/GfFXFB7NVPyMmRQcDV1dfoowm1emOCWOaCCkcp6i6iqWmOkjqlQYUMR7fQq9+8CDjYFMdKdwel3+IYWMHf3fX2f5xXBwoACgi4Z3eYro4watRg+Jh+v72wWvMLFVymCmMXSFn3tPFbE+6WQWRKa71g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3249.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:186::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 11:28:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 11:28:23 +0000
Message-ID: <37053ef1-be2b-442d-b4a9-9da99e75671f@siemens.com>
Date: Mon, 24 Mar 2025 12:28:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v1] .gitlab-ci.yml: Deploy seperate home partition
 for qemu security targets
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250324112155.3051460-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250324112155.3051460-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3249:EE_
X-MS-Office365-Filtering-Correlation-Id: 055954f3-2f99-4892-9fa5-08dd6ac6fc2a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bTNRY3YrSE9NdWgrOGluYm5pbmRiQU5lYXV0OFJRd0ZqbWFSdlduNFJKZWxE?=
 =?utf-8?B?S0pYbmFYbDk4b3BZbVNpWENkeGN3bDU0QjFPYkNqajU4SU9TaGl0cHBJcUFI?=
 =?utf-8?B?cXRpUm9vbzhYZnBBeEFIeVdoSlY0M0VPR1I4RU8rNjZyeTBFOTNKTFcwYVFo?=
 =?utf-8?B?dlRKSy91b0UwbUc0a0Q2c3BlWWRTRTFNSmx3YVV1akFCYWUwbDljb1MrU3VY?=
 =?utf-8?B?YVJtMVVEQm1mZG04UVJkQW5PVVgvVzFKbkM4eXV5dG4zTEdQYVFiU2d1ZjI5?=
 =?utf-8?B?QXJHeHEvNTJPZG9hcE1vZGJYbzh6Q2dFOERMYkFNMmRtWmEvcVAxaE1TSm5I?=
 =?utf-8?B?dFMrRWlmaEZZMXpFOUNTcWt0dkVvQWNVSElBUVp1OHJmYm1xQm9WWmpKUFBB?=
 =?utf-8?B?aHNjV3AwYm01WHJxR2J4NFFTMUZXWm5la2xDQ1pRTmJWYUJkOHVVVGhLc1JC?=
 =?utf-8?B?QlVHNE5EbFVORnVDVmVRRW1BN0pFOExlWmtFWGQ0Ry9Vc0hXN053T2F4RlM2?=
 =?utf-8?B?Zjh0QkpyOGZDTlljckxOZVZDVXEyUXZGT1BaQStVbkwvcnpGL3RQK053eThY?=
 =?utf-8?B?bzNqVXVQQnp1dy9ZOHhFbFZsZ0c0NGxkSWQyeHpUZEpHbnZYNUtrRWVaeEJv?=
 =?utf-8?B?MFFkQXAzUWFkVVUyT3lTbnZ0WWxsbUVtdHJkQzRvb0dzK1YrSzd0cU15Witx?=
 =?utf-8?B?OUVPM01FcGdJM0libVVHOTlRcWNrTVExTzJsYzZPR2JjbUZ2ZnVvandDS0FP?=
 =?utf-8?B?Zm9uM0MzTUZRWWkwT0lQOG1VL2QxLy9sWWlsTXNVOTJMeHg1RHZyakZnTlpj?=
 =?utf-8?B?R3pPV2k1QWcvQmo4TTZtRXdZQ2MzZVozY1Y3WmJKZFJBVnlmdXBxbU9BK2cv?=
 =?utf-8?B?Vy9wcUVhNlVWcWxKVW5WY1czMnAyMUFmNXZYZHZEcWplYjBDTnNmNTJPQllE?=
 =?utf-8?B?TDl0M2RKckFNS3gvUkM5SEoxWnp3S3N2ZzlIUHdZZHlneVdzWS9ha0l1U3RR?=
 =?utf-8?B?cU9PSXQ2elIyWFlNKzBOTHlqZGNMYlluczc4OTRRTTNKVHZ4Tk5pbnpwM3Jx?=
 =?utf-8?B?S0Vyd1pnQzlodHM2SG4vbFVTQTNtQkZIN0M5WjVXcTNxeEc3WUJsTXJBSk9C?=
 =?utf-8?B?QkVTS1V5blg2TEZMeHhKb1U3VFJ5Uktva09lZTR2NGNoVklUODE3QU1ZbVgx?=
 =?utf-8?B?M3FPQ3pzTjJjT1BEZkx2VlZ4aGYrOXI1MWk5U2lDaHpuS2k3YWNkcGVyeU5I?=
 =?utf-8?B?L2U4cjNOVk1YOEJIQU5paGhCNU1tZmZvY1VBQWFZY3Jmc1Q4My9tWE9iTzFZ?=
 =?utf-8?B?eXdDUlF0Nll4RzBMM3JoSVpmQmVMMWwwTnFoVUE5Nm9EZlBYZjZiQTUvbzBz?=
 =?utf-8?B?cTFmRTUrMjQ0MmJsL2RKMlpBd3ZVeVBubGVKL3hxNXRhZlRtbjVhSjdyd0Mr?=
 =?utf-8?B?VVJIVEk1U1QxWnFiSkdnazRoSTgvSlBTQ1dtcTZGdi9JcWNEaWVOeHQxRDl3?=
 =?utf-8?B?T3pPYUxmVXp0elY3NW9qZmJJc0kxSEljeVQ0SU9QMTI5VytmbG84Q245SmYr?=
 =?utf-8?B?Z3hFT09MeTBiS1piM3d5TzRZTlhhNlZUSW1sZ21uQmU1dVhzdktyL1NNSWxp?=
 =?utf-8?B?Rnk5MEhxcldVbjBJTlMyaEZIcE1zTUhnVWZ0OE5mcDJRUUY3Y2t3bzc0cjlU?=
 =?utf-8?B?WjFpdUNXRTNMOXpPeFgrL2FKdDYvVWNKU2NEYXQrR3BweDRkRTRBZXZXQnJK?=
 =?utf-8?B?Y2U2dXBNYUNZVkN0cmlYRWQ0SzhYaGh0SG1rV0pRS0NRMEFrem9lWmk4T0Qy?=
 =?utf-8?B?Q3FJczA5dEtYek5FSC90dWZPOGFoQ3NvdGR5Zm9yK29sS2cwOW1xaFNVajgw?=
 =?utf-8?Q?7RC/zdb/A2Pi7?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eXVEUkFYVWpOTGdaSURqMlhBZGlPcFNNK0hHYmZaRnJCdi9kTklIYnd1K2NS?=
 =?utf-8?B?YTVFTTJZYWJBUEpXOVROcGcrK0lNcXc3SkZKRG5EYzRvZk4zZUUzVmxWeXpw?=
 =?utf-8?B?QUNEQlE3ejRMN1lCcUJ3RE40Z3hCd0VsbjhLRmxTcDluOFI5bmcxMmIwZU5t?=
 =?utf-8?B?UUFUMVB6bTBSaHJMc05hSldHZFJUamlwT2hLazNHb0pTZlAzMVNHOFN3WWJa?=
 =?utf-8?B?K29mL2lDYzFRcWtqNER2WVE5dWUwQ2gxYTE5bWRPcGZqWGYyOUVEZlVmRVA0?=
 =?utf-8?B?SVVOT2hIL01kVFhWYTBTZk5JVGF6aWczQi9jQkFTV3JwVlZxL2JrOFRnUmd0?=
 =?utf-8?B?WkJHRFk5V1IrR3BYdjRObFNnd2M3bm5iQkxKdnFrbUlzek9VYUlyb1Y0aU1t?=
 =?utf-8?B?NTRvSnhIUFhSTnY5RkpwWmp2WHZkT3FRa2p4WWNCRDMrWEsxSzBGWGNkZkxT?=
 =?utf-8?B?T01QaSthenZyUkRjcTg4OVBVSnIvOVdiWEFRM1kvakh0TWVvR0s3akZvTkwx?=
 =?utf-8?B?cDdCanYwQ0UyejU4WkhoSkVQUk1tSlNQK041KzhQekN4OTBFbDJWa013TDlz?=
 =?utf-8?B?RUJ6MU5FZnZYeFFiZUNqSkZjUnEyZDBNMEVpOXc1VmVnRTVkTklKc3RjR0F6?=
 =?utf-8?B?ZWo4MCtzSUNSVG1DVEh3VkpDK2xnWHBKZGtjODd6dDc4ak5Tcld1Wk80WEVl?=
 =?utf-8?B?SHFSRTFiK3g0MDhxUDR5RDZ4Z0RnUThVa3FyUnp5QU9KbnZVeGpMVWdtUWFY?=
 =?utf-8?B?Wk8yWExIK0FlRHExa2VoUXFlSnV4VVcxV2xYWC9qcy9EaHpsUE5SbjJIRnM2?=
 =?utf-8?B?VTBsLzVKWC9ZbUNYWkx1aHcyWnJ0bjRPNFd5aU9RMlEwc211emEzQkZhM3pS?=
 =?utf-8?B?TTRRWTBDeWltQWF6WUJRUGFpSUNFRmZwRk0xNUcvUTh6SWx4L2w1YUlyS0Ey?=
 =?utf-8?B?Ny9hcG5HVDR2VXNLTUZnelVGanlQY1F0TFBKVnRRTFF2UFBvUWpQMmo1bHRz?=
 =?utf-8?B?cFJ2bFlQQ0o2MjRjMjlzd0o3OVkzVURHQU55OEJmSmh2Yyt3aVdsZTBPSVZG?=
 =?utf-8?B?K0dsMTVCLzdNSytlemc2RFhPUkRYNTM0bU83OElKaDJSWU12bVVxWENDWGtV?=
 =?utf-8?B?STVqWE85U3U3MlFELzIwS3I1OFB2NWxPN2pPY0YyVTZnSHdtcitrUWRqYkhH?=
 =?utf-8?B?Ti9RcEFtV05yVWN1T1VDcWZ6NnRJVXZWbmRSUHJUdWhrbEVVWlEwOW51ZnhJ?=
 =?utf-8?B?WGNLclFzQ0hLaDhKdGRNSmRGMSt6eHpuanRyNnVaanlWWU1SVnMrYzlOczl5?=
 =?utf-8?B?QzJHNkNSek51a0t6aVVJTEtKUTlybGQ1VG8zcHozUmJXY3E4U0NqUXlyb1lk?=
 =?utf-8?B?R1p5c3lsSEVlRXRjTTdvSDYxbUl3b3dxVlptekhaazNyMkE5VWNZRGtCY1Ba?=
 =?utf-8?B?OUcxZU9OaHd4VW5xTDFrcHFZUTVhc2NUQ3NteXNLZEJsaHlGajJZcStod0RN?=
 =?utf-8?B?ckoyaVp0QVNZQjQrclRsOG9Md3ErSWIzM1E1TmxPMld4NW9Hck42NnQ1clN6?=
 =?utf-8?B?bXEyZUZEalFvOTBQY0NYVHd5Q3BzLzNGVVJhZ01QR3F3UnRUZ3E5K2tKSEs2?=
 =?utf-8?B?THhEdFVTWkhzNHJNNVp2bitsczB6bXhpc1hmN0FLbFlYSWxDNTI1WVVzRStJ?=
 =?utf-8?B?dWVxYkpSais5MUwyRk5JYlkvZVd5cUpmekd1dUVsY0h3YU41cWhudEo5eW5X?=
 =?utf-8?B?ZitaV0QzeVF5V2pDQk1pZWxGTG1rY2J1eDRsdExaTzg5dXkvbU5Ed1ZwR2Vs?=
 =?utf-8?B?d25wU2hjcXVLN2QyNjBDRGMzWUpkK3FWT1RRZ2tYbkFzWTljcGtHcU94L3hE?=
 =?utf-8?B?b1VNS3A5eE5ya2tLcXpTRStVWkNXbHdiMU5hMjJYbnhqQUIxT09IRUc0bVBP?=
 =?utf-8?B?cGtOdkhESmg1NXkvNEM4V0FybGl5TG1tNGpWNkYvOGhnTVNoTVBJNmdrME45?=
 =?utf-8?B?RTREMjJiU2oyVzBrblBZM2RPZUh5VmpGYUFZa0pVaWozUG9wWTNJZjc2Y0No?=
 =?utf-8?B?TCs0eEJQajhLMDh0a3o3NDh2YmxmSlNHM1FXcmxyT0lYS3FJVTI5YldjNkox?=
 =?utf-8?Q?A5A3QmUh7XBwxKDTDCRntWVyT?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 055954f3-2f99-4892-9fa5-08dd6ac6fc2a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 11:28:23.6409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W410qlzYHOiM2uhLt2DKWJNh/GzsPrJdG+C9HnC8jmv6iHXfl7vViToHlQBnFeVVO4rDsH3N3JuvqIx0NwTKCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3249
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Mar 2025 11:28:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18342

On 24.03.25 12:21, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 
> IEC layer tests run with /home as working directory. aide is unable to

aide?

> detect changes made to a temporary file created under /home which is
> now symlinked to /var/home. This resulted in failure of the following test cases
> TC_CR3.4-RE2_1, TC_CR3.4_1, TC_CR6.2_1.
> 

Is this a limitation of test cases or an issue of our merged home
partition approach?

Jan

> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> ---
>  .gitlab-ci.yml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index ec9ec2e..146eb33 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -122,6 +122,7 @@ build:qemu-amd64-base:
>      security_test: enable
>      use_rt: disable
>      build_swu_v2: enable
> +    separate_home_partition: enable
>  
>  build:qemu-amd64-base-kernelci:
>    extends:
> @@ -142,6 +143,7 @@ build:qemu-arm64-base:
>      security_test: enable
>      use_rt: disable
>      build_swu_v2: enable
> +    separate_home_partition: enable
>  
>  build:qemu-arm64-base-kernelci:
>    extends:
> @@ -162,6 +164,7 @@ build:qemu-arm-base:
>      security_test: enable
>      use_rt: disable
>      build_swu_v2: enable
> +    separate_home_partition: enable
>  
>  build:qemu-arm-base-kernelci:
>    extends:

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

