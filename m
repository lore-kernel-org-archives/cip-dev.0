Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187D4C36005
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 06:37:46 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.45])
 by mx.groups.io with SMTP id smtpd.web11.41979.1745822151270867632
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Apr 2025 23:35:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=aCPwNsQq;
 spf=pass (domain: siemens.com, ip: 40.107.130.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQkyxSV70mWDPyGneGitc1QVCj/d05nsn1yE32wGgQOBKYfuAUrU8KL9Ja6azizzos6pShHh58hh8DTIeKmHQtPU3IzG/Ptg7rFtm9knLynvrsSkyT0wN5GwvlGY+vEy6iLuAjMtzKIobF344Z7msb27hAix+9Zo8rDyedcy2bkogD2Mo/p1NrsSeEr3Sx7U094Z8ZvjS+QQ+uks9uebuJ1ZrA+IzUe/6PmLJNbWhfFGRjSKWSo6WmnmqvqtXIFstGQCUPrO464Ibivss672BWXxGVx7iGo73cMcMm+o9ioYxdpzd5HOALDSg663paBa2BrrHMcsxZdkoOczarzR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYhbqr3u/InKxBpDV8T/nNI3sGOnwHBKMikYQKFaDr4=;
 b=bgXyIjiN/1/KS5WhCrrkXRQh9JuKZmmZJH5N8zHpPkVUypyYmFzbC5PKawEZZhhPHCGvJ5aQQOcSxkPHCLwaxNP3j5G/JeQoPI/jV28tb5BzgBpeWyktxKVVEP7+rPeU/E3oYPnFYaNf9YI+PYctdEwhljxY4Jwb6BOYWve8Htt8yXJGkDSTAH+8iPQUtcPQmosTAAiP6x5aIk8WC22bU36/rfi4RgK1EvuAY5Y2DidyzA1qg0TOliygeQ5yQ1ZZqUrwxZ/SBjK5Fib2xhh4Py6rSaBGM/ySpGwJZHWS9iatsWz2u5Smc0QJBZORZog5LXnYrq8zQAqBq8ozuvOZ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYhbqr3u/InKxBpDV8T/nNI3sGOnwHBKMikYQKFaDr4=;
 b=aCPwNsQqmNIPQujiGHC72hZ4SK2M8ierifJfxLoqFV4+kQpFc92Uqs/2SzU+UKRYIuQzb/r/lzuM3xpp7Ngpuv3LngsnHApc1MFebO0Yy/9EhUo5cccEk/nq4EWfci1QZC1edRN6csiBjqqcx715Jg2x1/PfAMprcs53LQzOUqc13pBXjcUzlfBl+vk+ElhplJKw8qTwJxQFEyKnQVzsVgGOfQF9bc2UivQcwgleUyCUOgXmDe+TVUsQgR1fChgw6RN8tIuZfiJlFExt4Zw5E3hOmXyLajT4rO+c7sHsUBTvMuAqXnnhVsOd12oQZS/s++uPuYU5E35VvbKP1SiAiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB5933.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Mon, 28 Apr
 2025 06:35:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 06:35:46 +0000
Message-ID: <79b2bf60-e5f3-42b6-9542-e91ba0bed677@siemens.com>
Date: Mon, 28 Apr 2025 08:35:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] initramfs: add hook for data-reset
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250424092302.2066773-1-Quirin.Gylstorff@siemens.com>
 <20250424092302.2066773-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250424092302.2066773-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0424.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ce32a3-ffa4-42a2-2c6e-08dd861ee85b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?V1NSaEoyMFMvQzBOKzFvY3VvTjBJY2N0YWYwdC9hT0RoL0JPUHVCeE9GRy9l?=
 =?utf-8?B?UHlLYTFFWWdGdlBPUXRSbDFtcTV0NDByTmZqYmJoVGdvMDFoeWNucHF0aXN1?=
 =?utf-8?B?c3JuMk1lVmtCSmlVZUFzY2VoMFEyRVgyZytCS3prRmkyM2dTUlF6YUNsTE1S?=
 =?utf-8?B?Y3ZNRlRpcmozb0lIZnpodnRNZ1FFTW5IZEZFcTFzOTBScU1IbVBXR0JYMkZs?=
 =?utf-8?B?SFlpNDdJV2Fyd3BsNC81SGtNN0xSQXVtMzh2S3V4eGNnUHF4NDNBSzMyMk1v?=
 =?utf-8?B?MnIveEZDN0dzdm9DL1JpWm81WmVMVEdoZ1MrTVo0UThyOXhrditjeGtHVkZi?=
 =?utf-8?B?bGltMlQ1ejFpTWJQbDBTSjhSdEtBREZOQTUxbUxTa0RCWkkwdEZXTmlpMnpn?=
 =?utf-8?B?UUoxQ3I2ekh2MXhmY1NoeGc4cjhMb1ljdml2TWZON2NGLzU0TXQxaDdRVWJY?=
 =?utf-8?B?S2F1c09admhLemhnbitUQzlWUEpSQXJFWXdzSm5wV044YnBtN01xUlpmWmli?=
 =?utf-8?B?aktHUnVVRWk0bGlIa3RFQlJ4M0I1UG5SbWhleFpRaGE4Q2hjUHg2dzJWcC82?=
 =?utf-8?B?dmtHaWc2NDdIeXozZlpDRW0zSzJDSjczODFrRlUydjhoYmlPcHhVSVFFU1py?=
 =?utf-8?B?eE53eXhlcmpRL0V3bUU2Nzd2K3g0ZGZSem44UnZQbW45T3R5N0FyZ1Y2RWxr?=
 =?utf-8?B?bk5peG1yQmZjRWN2YnFyUm9MaFZOL2wwMTg1ZTZmWElJWFZVWU1DY0V4dS80?=
 =?utf-8?B?NmhCVXdrclpFQlJVZnZHRXdnK3hBekNLU1VGYTQyYU8yeWIwVS9ReEpPaTB0?=
 =?utf-8?B?T3hpNVJFcCtSdjFTODVNd2NVa0NZdGRLZWh3YTROSDJGUERMWldMK295eDdh?=
 =?utf-8?B?dDdWZEJUTEZiRElBenYyZktvOTNMVURpWklWbnJ2UUlzbFFzS2xkWUhpd2oz?=
 =?utf-8?B?N0s2Z2hVa2pjSThHZVhuMUtPcUtnd3ZselFtcTV6UU1Yd05OWTNKaC9LaEZq?=
 =?utf-8?B?OFF2dW5LSzhtdk51Yy9zNExaUWdMRlMybXpaUC9MU3JVZXBZcm9GTk5ERGw0?=
 =?utf-8?B?NUVUUHdnNm5UUVNiQ044MzRXMzBtNXMyVEw1K0ZEVzBjc1hIbFVGdGdYSWVF?=
 =?utf-8?B?dk15MVdNUDYvZE5pZlY0MzBtRGZxVHJMT3BXYjVWbGg4aGR4dHVlZ0syYnBm?=
 =?utf-8?B?S0RaUG5NNmJqZmh1N3A2Q2JPSElRd0N0VkJzb3QyMW9IZFBOdzFDbjFKRlJJ?=
 =?utf-8?B?cWdBSHhRV29NWDNEc3FETUpNTC83cmhnVW9jdm00cWlHTGxHRzhERlpEVjla?=
 =?utf-8?B?UDNaTWtHL3oxbVN0WFRrQkI5ZHRkb0hMYkd2cTBSTHdtazI4VGRFSThWRzRV?=
 =?utf-8?B?QkJvdHEvSG1HQi9CUGNHOExZS2FFQzh4QTE5eE4vaFhjNjVzeGhteTZkaHFP?=
 =?utf-8?B?cXlTc1dmeW9uQVBHRFgrQWsrQksyVVdDSVBFWVRVSFR6REZGdHpBYkE4dlFs?=
 =?utf-8?B?WHlDeW9IQlN2ZHFBNWtOVFRzc25CaTdsM2MxenhJWjhtNDNYbkJORDVqUnNX?=
 =?utf-8?B?Z3p4bXpSa3hiOVpaTHR4Rm12cVpZQnNNd3ZlZ2MwWVBmVUZ5dXpBSWRIWVcv?=
 =?utf-8?B?VDkxVG85Z0ZhSm9oV2pyS3luTkhOK0RodS9UNTlteDFOOVZtUnQxRndkektN?=
 =?utf-8?B?YU9Sc0p6eDRESUdoUVBWMVhXWWcwcEZyVTBIU0NHTXNLK3VaMTUyYktvM2k3?=
 =?utf-8?B?cXF2Y3NsZkdvZnNFdFZvS3E1WWxQL3p5czVJMEdLZERKRCtyRmZMY3RFZ0ww?=
 =?utf-8?B?eERGNWlORnJqakFUaTJZajJiTHFYWnBlSTVaSDRqTTRvY0gzcEhLTWtpRVNF?=
 =?utf-8?B?bFBGcE5YUnRiOUV5YWZVTWsza1poeEtEYjBCL05OVExSYkgrUzNGc1dTTzc5?=
 =?utf-8?Q?Tltl5tOJdeg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NklCOVpiN0dnSUxLajc5TldzNXdFanlsRGs4Q3MzdmxFbzVxanQ3QTgxS3VQ?=
 =?utf-8?B?N3BGNlQyd3puNHMzOStIZnN6SUROUkJiMG1UNDFKSE0walZ6S2hhZ1BYbUdz?=
 =?utf-8?B?MWEyc05BZmRQSVpWYlhyb3MyRFhZV2JHMlJla3FMY3phZlFVSXZmenV2Uy80?=
 =?utf-8?B?WFQxOVdMdWpmOGRPTWxFS1JZS1B2dFJDUnFJYlk0dmtlYmVUOWRHYXN3a2dS?=
 =?utf-8?B?UHliN3FXTGplY3ptNWdwNHp5VEpzVmVJU1hiUGJrM1dpemZIeHpBb2RWNUsv?=
 =?utf-8?B?SzMzdkJLWk1yTHZnWVpuVVJ4d0R3WmJDdmlvTFpNS1R6N3lTSGhNSjlmZzRV?=
 =?utf-8?B?dEd5c0NNeGJINzdMcEcrUVVuS3lDMmVZRjl3U0MvVU8xOHJNZ0NUVWY4cklZ?=
 =?utf-8?B?WTRXMkY1bk9SQjBHK1QydEZPY1ZiUC9wTlltejdYdWxqODFHZnlLdVVxZEk4?=
 =?utf-8?B?ZGlMM0t0VmhVZEoyYzNGdVQ4OHJuNHdNT2N6LzZkQ3MxSkYrZnNnSkdsOXpu?=
 =?utf-8?B?NHZsNjlpV2xGUmg0SmhmL3FYN21iR2s2WU9nck81cUJWYnlDd0VodjdrdjRC?=
 =?utf-8?B?RHdaQTgvWVR0U0VFd3dPMFF5eUxMYU1PRVRScVJuOE1mb2R5S08yRldYa055?=
 =?utf-8?B?NFVtSXZ4TzdUanoySmNuL0FkOUZhVnFLWnhjUW5LRlFWT1czTTZmZVJzaStl?=
 =?utf-8?B?amFjRVM1QlBxbGtPcXVEdVZyek1ZcmlMK1dHYmlCTE15dkgxeDN2SVIvcG9U?=
 =?utf-8?B?N2ZwRHU0UTRPRTNLUUNkMm9ONUFyQ2VaQzFLbUU4cXVwWTh2SWlFK3dtMW4z?=
 =?utf-8?B?N2twNnBrSWc1dUpwaFBRWm5qTndWSkIzR0JFOHNaeFlLQUYrdkpCM09vKzI0?=
 =?utf-8?B?cFVhVjRRY2hzeGpqSzFDQmxiVklrQnFwMjR3ZytSaFVUQWNSeHZjUzhpcUN2?=
 =?utf-8?B?RklxQjR5TnVYUzZEVmhwb3Y5TmROYjROdmFMN3NxU0dWVDRXY3FkSEs0RS9M?=
 =?utf-8?B?c1I3RC9IbUR3YXRqRUVid1BzU3hhRDlhYjhwemxNVXRsVThKVHcvWnh6VWdt?=
 =?utf-8?B?M0xjbzFEUEhIT0p1bnpGRG54a3I0Yjk1QmdLWVAvZlo3bzZWaDF2amszaVFQ?=
 =?utf-8?B?TlBQUTlwa3d6bUVreTduSnAzb1p1aklVSC9raFNrRTlhUGVOSWhxb25BUE1L?=
 =?utf-8?B?bU10WWhJbC9oS2FveVhtbWFhTk5tcDR5V2xKMlpOci9KWXdaMzhENnJRbE0y?=
 =?utf-8?B?VG85MFhjSjV0S3I5a3RzNnFlcFZUVUFERXhYOUJOUXBUWGdRY2hHbGhYVHBS?=
 =?utf-8?B?UlZwdnAxWTZ4UWI2ekZNMmtOMDRqYkErNWJ2SEhGMnZRVVpyR2RBRjZsWWFl?=
 =?utf-8?B?UlRrQ0VpbnpDWGtseHRvV29QK0haNjJHcm93WGI2UGFYN3V2eWcxRkU4SlB2?=
 =?utf-8?B?cjQ0amkwVkl3UnhUY0NSdStBS1ZsZDM0OEVMa1o0NVp4aHluT2Z5M0FVaWhy?=
 =?utf-8?B?UXJFUXY1Wm93SmFnalowbDZ2U1kyczBINUlKY0Nxbk1WMjJVWjJLbXBIdkQ2?=
 =?utf-8?B?eWlxZDN2QmNSbzFQLzlzRkxWSmJzU0xTYnVXS2pUVWlMMlhON1RnNFVzYkps?=
 =?utf-8?B?cXRqS1FISmU5NGU0UnlMc3I1R3dHZlZ1MlhwYVFiSzRmWkoyQ1dGZ2FhS2t4?=
 =?utf-8?B?bHl1aDk5OW5obGpDb2FJSzU1YUhLSUcrdVhJUHlLNnVxVk9QMTQwSDUzQVYv?=
 =?utf-8?B?UGp4QWoxb2ZsNkVoUk9EeFd5am43WXRxWHg0Y3FtL29qbWpBNG9OdXhiZVpm?=
 =?utf-8?B?MXVta2toREh0bUJKZEx3c0tublVFU1VnQWlMblF4UXFJdk1MOU1wSGJDSFZj?=
 =?utf-8?B?NmRMajdGWTg3RFkxbDZTaU5Cbnc3dWszYXkyQ2hFdnZ6azhTekRUdkMybUJR?=
 =?utf-8?B?cGNhS1FpV2pUMFowV2ROU0RLR0FMZVhFd21lRnhKSnZOT2VXQ21hVjZsT0lW?=
 =?utf-8?B?WVgwandYYXl3MG1FK01CeXV2ZytCdkdIY2NqOGtaSTc0RHl4Q1JyQ3pmdzNN?=
 =?utf-8?B?LzR4dGFTRnRuUUpxSGVQZXVteGNRTG0xelY5cWs1M2NiK1Nkb1NaTjZZa1Mz?=
 =?utf-8?Q?vVz3cp9QkfGE/kre0EUtgMDb8?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ce32a3-ffa4-42a2-2c6e-08dd861ee85b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 06:35:46.4216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLI7n23SETevSjJ62biD+lhUpx8Z4uZ7v8RiBJcMOU1SUc8gKlElFRL4YfWbYfI7bv3/L2PMIjjKR+YmJOu3qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5933
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 06:37:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18680

On 24.04.25 11:22, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows to reset the device data by deleting
> all files in the persistent partitions.
> 
> The reset occurs if a file defined by the variable
> INITRAMFS_DATA_RESET_MARKER
> exists in the device INITRAMFS_DATA_RESET_MARKER_DEVICE.
> 
> This feature allows to add device specific trigger to restore
> the persistent file system to the first-boot state.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../files/local-bottom-complete.tmpl          | 76 +++++++++++++++++++
>  .../initramfs-data-reset-hook_0.1.bb          | 36 +++++++++
>  2 files changed, 112 insertions(+)
>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom-complete.tmpl
>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/initramfs-data-reset-hook_0.1.bb
> 
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom-complete.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom-complete.tmpl
> new file mode 100644
> index 0000000..f02f95c
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom-complete.tmpl
> @@ -0,0 +1,76 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +prereqs()
> +{
> +	# Make sure that this script is run last in local-top

But it is called "local-bottom-complete"...

> +	# but before overlay
> +	local req
> +	for req in "${0%/*}"/*; do
> +		script="${req##*/}"
> +		if [ "$script" != "${0##*/}" ] &&
> +			[ "$script" != "overlay" ] ; then
> +			printf '%s\n' "$script"
> +		fi

Will create undefined dependencies between this and the crypt hook.
Please sort that out.

> +	done
> +}
> +case $1 in
> +prereqs)
> +	prereqs
> +	exit 0
> +	;;
> +esac
> +
> +. /scripts/functions
> +
> +marker="${INITRAMFS_DATA_RESET_MARKER}"
> +marker_storage_device="${INITRAMFS_DATA_RESET_MARKER_STORAGE_DEVICE}"
> +target_devices="${INITRAMFS_DATA_RESET_DEVICES}"
> +
> +storage_mnt="$(findmnt "${marker_storage_device}")"
> +factory_reset=false

I thought you didn't want to call it "factory reset"?

> +tmp_mount=$(mktemp -d)
> +# check for marker
> +if [ -z "${storage_mnt}" ]; then
> +	if ! mount -t "$(get_fstype "${marker_storage_device}")" \
> +		 "${marker_storage_device}" \
> +		 "${tmp_mount}"; then
> +		panic "Can't mount ${marker_storage_device}!"
> +	fi
> +	storage_mnt="$tmp_mount"
> +fi
> +if [ -e "${storage_mnt}${marker}" ]; then
> +	factory_reset=true
> +fi
> +if mountpoint -q "$tmp_mount"; then
> +	umount "$tmp_mount"
> +fi
> +if [ "${factory_reset}" = "true" ]; then
> +	log_begin_msg "Factory Reset"
> +	for target in ${target_devices}; do
> +		target_mnt="$(findmnt "${target}")"
> +		if [ -z "$target_mnt" ]; then
> +			if ! mount -t "$(get_fstype "${target}")" \
> +		 		"${marker_storage_device}" \
> +		 		"${tmp_mount}"; then
> +				panic "Can't mount ${target}!"
> +			fi
> +			target_mnt="$tmp_mount"
> +		fi
> +
> +		# delete all files in the target mount point
> +		find "${target_mnt}" ! -wholename "${target_mnt}" \
> +			! -name "lost+found" -exec rm -rf {} +

rm --one-file-system

But wouldn't reformatting be simpler?

> +
> +		if mountpoint -q "$tmp_mount"; then
> +			umount "$tmp_mount"
> +		fi
> +	done
> +	log_end_msg "Factory Reset"
> +fi
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-data-reset-hook_0.1.bb b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-data-reset-hook_0.1.bb
> new file mode 100644
> index 0000000..6dfd896
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-data-reset-hook_0.1.bb
> @@ -0,0 +1,36 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +require recipes-initramfs/initramfs-hook/hook.inc
> +SRC_URI += " \
> +    file://local-bottom-complete.tmpl"
> +
> +DESCRIPTION = "Delete the content of the given Devices"
> +
> +# if this file exists execute a factory reset for the given
> +# list of factory-reset targets.
> +INITRAMFS_DATA_RESET_MARKER ?= "/.data-reset"

Hmm, not really a working default if you have a read-only rootfs, no?

> +
> +# use labels as crypt setup replaces the label links if
> +# an partition is encrypted
> +INITRAMFS_DATA_RESET_MARKER_STORAGE_DEVICE ??= "/dev/disk/by-label/var"
> +
> +# list of partitions by label
> +INITRAMFS_DATA_RESET_DEVICES ??= "/dev/disk/by-label/var"
> +
> +TEMPLATE_FILES += "local-bottom-complete.tmpl"
> +TEMPLATE_VARS += " INITRAMFS_DATA_RESET_MARKER \
> +                   INITRAMFS_DATA_RESET_MARKER_STORAGE_DEVICE \
> +                   INITRAMFS_DATA_RESET_DEVICES"
> +
> +DEBIAN_DEPENDS .= ", coreutils, util-linux"
> +
> +HOOK_ADD_MODULES = "factory-reset"

What's that module?

> +HOOK_COPY_EXECS = "mountpoint findmnt mktemp rm find"

Should we already prepare alternative reset triggers by sticking the
file-based variant here into some callback?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

