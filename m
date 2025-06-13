Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C3CC71136
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 16:30:46 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.15])
 by mx.groups.io with SMTP id smtpd.web11.1595.1749832241986878138
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 09:30:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=nlUoLp35;
 spf=pass (domain: siemens.com, ip: 52.101.66.15, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HX0hSgY4w7BTITs3XoJ6DemFtzassOhuPid27vsJ185v/YZmm2EuczgER0rr0HZzWVnlUEyJDofqTnIjWiyoQVQHnr7OY6HPK/F0k1KxRwKDoOmBo4rAgEUjNmYaQkz3u8PD4zvEw+LGSceiJXGvshFipZVVFWNWL8+m9aN9SeqMze/TFQVojw+smhahfL80UZ1FVeNCuos5CSl45RAsDVNF/zWNdfmMb10Krgt3OL4wFvAb2lQ5JMBmg03/5Ff38pdezloqflPyOPU9XcNkcn+IbhJ/4N915nLxxX+f5vatch7jd+oujr8tBJobz/QNCikH2RCTpUOK54PLPpv+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0v0FvEdGYXZ1/e5PXbSmDOWNVFjcxsMETA41iWWhdg=;
 b=pVJc25T9eSowdRg5fdf6RiU6HSsYReABPBodT75JveFkpyZ/kwYib8f6FxXosLpOO/29JgGP9sy/ulars1JC9ZdvluAqL2DjjZq/3DFthOfkOup8W1w6WGfY/YJJ9AU5rDcXTRDGav1nzt3ID92I2MrKDJckFqzziUPmAlMHOZJ0O6iWOGW3OWuAZCRYj5nvaZozBSd6/Sfj6EVfuALKfBgyPvd5AGJIvXq9HDCRGRt9a/COH92R/NS2iyjzHv42zAvU5jD+EwrJxHHpbV9R4E6NB8IE8c0StiVZvJxDtDLsOb1A+yKtKuh5EELdkcS99St9C73VVx0wN2lxZIx9zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0v0FvEdGYXZ1/e5PXbSmDOWNVFjcxsMETA41iWWhdg=;
 b=nlUoLp35iyiBChmoJvpbjB/Uff0aE/wFYhEGYKZSnqVPWvFsN5B6kKLPcs7Dn3zcz3WqIyAboBevC7MdQ6xjsp+8YlEeks07eeDldJHlrnmrpPGHLrBKs9lpLKdDkmX8S7VaYN0M0USqVTblPltB/egE/xSSqudRX0tBQoprk5Xvm+/EJGDJ6u1AKChWKp+YrH57hFWIbEFZPUopIEkZoisgo/Y8NQ+HmE1cGMqywKnKRGyLbzr45L9dTvkl+/LZ8L0MtZX+4caepoNqbLi6HqdfsyrIraKouUshKLy/g2R/dlWnWK2H3i9eSpJ256Kj8BVs/mvXnuRQ/83GXv5VkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3578.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:131::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.24; Fri, 13 Jun
 2025 16:30:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8813.024; Fri, 13 Jun 2025
 16:30:38 +0000
Message-ID: <bbb5595b-029f-489d-85d1-42b51df3bb70@siemens.com>
Date: Fri, 13 Jun 2025 18:30:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] fix: Shutdown the TPM after disk
 are decrypted
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250613135155.1440058-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250613135155.1440058-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3578:EE_
X-MS-Office365-Filtering-Correlation-Id: 20516a6d-3102-4a8d-5f0d-08ddaa97a16c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bTMwSC85aTFIS0l6TGpwZGNZaWg4KzVnODFkdnUxVHZOS0wwU2EwTXZuL2VL?=
 =?utf-8?B?Vll4V3JLRVZRWmZDQ2dwTTdyYktlQzVqcUZOYlRLVWEwK3B3UTRZSGNTQ2ls?=
 =?utf-8?B?ZXpJVHc1ZWtLWkZlTzZoN3ZVU21BMVVoNHBTT2VhME9qTU9xcnFYRTFhTys5?=
 =?utf-8?B?OFMxVHhKTzhZampLYTJRVitLcFlJSVpNS2NROUR6TnVMcXdLTFlROE9BeXAx?=
 =?utf-8?B?Y2V3VzJNdG9ENjQ4U01KVWVlajdMWlZPZWpjYmFFeVg1WG8zOFV4cU0rNFIw?=
 =?utf-8?B?Ry9jQ2MrMzcraGQxVy9xRlU2eVB2VGtPamdMRUhZS3huVDVMbk1yTlFtSUhY?=
 =?utf-8?B?QnM1bWNYOTFNZmhsV0xwblpla1FJdnU2UVlQOWtCYitURWQyeDFKWlNsT3Zv?=
 =?utf-8?B?UnVySDNiM1N3bHAzQlB3K0tZdW1FRmdVOVhUY2ZhTVg5RzhaTmlBZURNNEpl?=
 =?utf-8?B?d1Y1T2VTVnF3ZGZMWGo0YnBmamRHVkVBaFEzM2UyZ0RubFN3S2pHZ0RXaDl0?=
 =?utf-8?B?WHRwS0ZGcWNHOVZpVnpYbWE3N2ZVckFzWGc1M3NPN0h5d29KN3R5SHhmL2J3?=
 =?utf-8?B?czlYaFE2YjVzdUhLVFNCNlBHQURQdzhhOGY2cDlRQWtTYnVlQ3k0QjR4N2dJ?=
 =?utf-8?B?Z0pFdklROGRlcGE4WktSMFBRTy96NFhVR1pWODh1NUV0cWdSWW1CT1pLMWd4?=
 =?utf-8?B?OXRDTTFsamp2NTdsNG8zV2kwUlhxNnVMdkl5aTU4QnRBSWMyaHc3TzBNQ0h0?=
 =?utf-8?B?dmE2SVJ2STAzYXFWM0hWcWZpWEdxS0tsVmVscmlSVHYwbVNYNDZqV0w0aTVC?=
 =?utf-8?B?a0NMN2tQSFZjdklHeEVQUjN2bXhKaFhVT1Y1VENMUGVwRXNrREdjbmZHeCtj?=
 =?utf-8?B?bHZHNzJYTTRNZnNtRXBveWExSzF1SHBQeGVXUmlBRDJBOHROc3pQNEZrc2hx?=
 =?utf-8?B?Qm9CYmluN1dOVFByckxtNDdRMUdlc0FmYUQxNUwrV2hocm9xQnhiNzlIcVV6?=
 =?utf-8?B?Wkp5OEk1UDZUVWhLN0tyTGk1UHFHOFVsdzVyQ05aQUlzSy9KTFZ5SkVaY1Zm?=
 =?utf-8?B?aU5kaWd6NW0vekdsL1lUdlF4emprZmdaZlp0YVJkdWI1Y2NodWxCOGZnV3l3?=
 =?utf-8?B?YXpZQ3hlc2QxRE9ya013MFcrWERpdnRNNGJvM1VZYXZza2xiN3ZqQ2hGNVNv?=
 =?utf-8?B?eEQ2bTh2MlNCRWR0bkdFSEZFL1l6U0hTZ1RDNFYzZmhYSVJPbGt5ajVNdHhk?=
 =?utf-8?B?QzRjRWwwRE5mdnNQNlpZYWYvZm9LalduNlVFV3BFR25ZUCtyVUFVekxqM2lz?=
 =?utf-8?B?eEE5cmZqSHQ1cEZUaFNacWxOUlBCU1VaVGpVR1ovNDhXMVlyNWlIWTRqSmVI?=
 =?utf-8?B?dXd3Q1U4dDFjc0tsaElIbU80T0dPMEhKdU1YZldnVEE1ZTF6WWhQWm1qZlRo?=
 =?utf-8?B?YUZneWozd3hBY01tRk1Xb0dUOW5PNEZCblV3T2FVTEVKQXZZeVM4UjRtdVFE?=
 =?utf-8?B?eFQ3VVZzOXdmTGRPRnl5eTRwUW5QZWIvMEpxbFF2aXR1YnVNaUkxRlJNZFZP?=
 =?utf-8?B?c3c2Zkkzb1FaamhyRGxLT2tQNFJBaGtwbURjRjhkSTVUUnBSSGwyYlJiZ3ZW?=
 =?utf-8?B?ck5nT3VtTERSTGFtME1KQWpKT0JXTWFrL1pSeFJYRWtGLzRyOURMRjBrakVm?=
 =?utf-8?B?cHUzejJoQmwzNG9Hc0pVbS9WdEhGa3E4TkFYYjZRTzMzQ2JHcUloY2ZnTVgr?=
 =?utf-8?B?N3AwNmhvQ2MxN0RUYzc2OEk2QVBoc28zYlJDUldndkRVK2xSeU02ZnNCLzF2?=
 =?utf-8?B?TldEMW5FUjZ5SFlxaVBPOTJlT0tjUVNmK2tvSEpCSldEUGxlalhidnNFZHRj?=
 =?utf-8?B?SndUZ2JOdndtZkxSVGJRUjhNNEZ1dWRnSWFBTXBGc1VMNzdGQjFPNERJTnZR?=
 =?utf-8?Q?sIaWx7gNik4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SHYxK21vKzZuRlRTNnB3ajN1Ly8wdndDVThRVSt1QWhmOStzVFRHeU55OFhC?=
 =?utf-8?B?TXdQUnhxeHNvbGZJdlZJTEVVcU1qanhnODFBYk5uT1dGOU04d2JWd294RnFX?=
 =?utf-8?B?TlJPQUxOcnVUNWFSZ01RVHhkRjF0MlRjRkp6eGM2SzExS3ZNbGZWVFY4Y2d1?=
 =?utf-8?B?ZHNkKytqd1VpcFdIL2dYcTNlY0J3ak02alZ3M3ZYekJVRHNMOExmWitsWVBS?=
 =?utf-8?B?bjZCZHc1WktFanQ1a0V3NTN3NHg4a05zbkM5SFNsaWI4VXpRTi9tZUQwTi9T?=
 =?utf-8?B?NTdoaGRDQnhRYjBERUNUNDZ5aDA1UEUrT0tPUHdJK0loblRZSElVMTNVQ0dW?=
 =?utf-8?B?Wld2Mk1ZMGZDd1pXa3FndlhVTHl5TnBoRWIrV1hlbWl6cE40eVFwWFlacHVw?=
 =?utf-8?B?emtEWStCN1dnUVpTZ3JTOW9iNnhqYzRHMU9XYXNsMUEwTk9zOGJPVXl1SDUx?=
 =?utf-8?B?cVB2ay9vL1pFeE9MRmFCZnhWQk9YaEwraEMyVnd6RVMxWnNHcjJNUlR5T0FS?=
 =?utf-8?B?eEh3T3dRRkUxSnYvLy9uM1Y5K1h2Q3ZHNUN5Nm1MQzdUd3hWcTU3NGpaWWFt?=
 =?utf-8?B?L0JrZzEvbGhyeGJFOXplQ0RQWWhMb3Y4YUZHTGc2bGRuUXE5djFiK2Q5aHJT?=
 =?utf-8?B?c0hVQ2N6RUJSMVFGSXU4Y3BMeDFERG5BSVNzVjFNd2tJL0dSWDZSbDVRMnNT?=
 =?utf-8?B?c0V3QmdvUnB1S0RoY21sTnduT3FhRjg4WGk0aHl4NHhIb05HcUIxVDRHWGRH?=
 =?utf-8?B?b2lrQStDdUEvMmtCMUQ4MWl3ZC9YZVZQUXRGRnl4MFdxNi9CdTJxamxxTXla?=
 =?utf-8?B?dmxpb0VBbnM5aVFPVCtrRDJERlUwd2lURUdUcUhlS2hSa1l0QUxhMmxpTVQx?=
 =?utf-8?B?eCtPODdZekhyQU5WZm9ZMXNlVWRpeXBjVkRtT3hkVVFiT1ZabnBFeUZ2L1Zr?=
 =?utf-8?B?ZHVJRXhpck9VZE9TSHBQNEQyd1dYRGtOWHc1VjB4eG8yWGxGd1JTankxM05S?=
 =?utf-8?B?a2RUMU8wRXdFN0Y2ZWxPVjB5RjVveEhUZmxncEp5WE84ci9taHpNQ3NLRk9q?=
 =?utf-8?B?Q1V4M0hVNEJhYTRwTzZ6NzgwWitubjJjSG54MVR2L2pYK1lsTThkSjdPQXVN?=
 =?utf-8?B?NzR6QWQ4ajhuVFF5eTVraXc2NllVOGp1S2dIWjRocVFFRE9MbjM1MUQzbHNE?=
 =?utf-8?B?Um1JbEF4UlVmMjRoQXkzMDUzS0tmaGxXUDI3eFYzeVkzaWRWYkJacGlpRkdo?=
 =?utf-8?B?S0RZTjZaT080YmdUOGJWMlVzTlJmY3hqVWpZekRjYjBKcUFOK2VwaDg0YlZv?=
 =?utf-8?B?ZnU3WGplL1BURlBiRXc2NTUzYmEzYXNaTGlSZTlPRmJxZlNUK0xGamEwQ0lk?=
 =?utf-8?B?QXN2Q1Y2Z3Vucmg1Z2pjaWw4MkJIMEE2Z05uQ1paalBaZlY2WkZCM3hKRnhs?=
 =?utf-8?B?UFVyMHVSTWtsODQxMkVLQzhiTE1ibXVMd2ZSVWFvRHdhVklqWTF3dDBuVXNh?=
 =?utf-8?B?K21kZzhobjZHUFM3SDQ3TnZ6cFpWd2x1MG50OWdqOEw1RXQxYVBuR21VNUVU?=
 =?utf-8?B?WGFMVFVRUDJCOW1sSVBwU1dsSVF4bVVlREZmSUtzWDk3d0dKZlRPWitiUHB3?=
 =?utf-8?B?ZzVaYW43eCtCKzRLOFFBTXc4aWQrM3RDdUpBSk05Z1dyTW9IeGJEQ09vV2Fu?=
 =?utf-8?B?QThtU0pXZnUybEdLSWR2K01NRkhGek9sSzV4Nm9UaThOR1k1d2MrZzdsSnRv?=
 =?utf-8?B?enFrWjV2dkFuMmJVaktXekhKckZiQVFsTzFjWjVGL3FTYXFxdEVuL1Ivb1Az?=
 =?utf-8?B?eHJHOWdwRUtUdk1kUXd5dzYrR0FuRXMvb1RLM0N6ZTJqMm1pK3huNmRpUldt?=
 =?utf-8?B?Q2RRYWdWSXg4djluZjE0a0NmWDJpSXhoZTFjWFNpc0Y3ODZRc3dJWGQzaGFW?=
 =?utf-8?B?V0w5N0RHa0FnZzRLTEpTQ0d4RGl5amFJaXhGTEN0eEEzMzNhY3Rpd2FQMHBm?=
 =?utf-8?B?MklpRnIxUjQwMHVjK0xoU0x4RUFFaTZVdXUyWkdIMG1WdjJXSzFsais2SUhE?=
 =?utf-8?B?bVBJb2tFTm9MajBuZHMxMFhZMlpnNXI0VFB6eVJrbUdXWnhIdjRlU1JUSTJ4?=
 =?utf-8?Q?bYSF11sNUjo325lWnnQBg1Fsp?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20516a6d-3102-4a8d-5f0d-08ddaa97a16c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 16:30:38.3963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qMoO/ZVVADz0Ju1fASZ8ZnLGPIeq/nNHBSW9Vdf4CIzOyiUvmAW3b6tsVyxtUc26quc23GsOamwpUNrocyTQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3578
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 16:30:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19085

On 13.06.25 15:51, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> If an power failure occurs and the TPM was open/in-use the DA lockout
> counter will be increased. If enough shutdowns occur the device will go
> into lock down mode.
> 
> This error occurs on real hardware and in QEMU.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-initramfs/initramfs-crypt-hook/files/local-top-complete | 2 ++
>  .../initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb            | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index ae0dcef..113f44c 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -293,6 +293,8 @@ for partition_set in $partition_sets; do
>  	finalize_tpm2_encryption "$part_device"
>  done
>  
> +# shutdown the TPM to avoid DA lockout due to powerfailure
> +tpm2 shutdown

tpm2_shutdown - or is there also a wrapper installed that translate that
call?

>  if [ -n "$watchdog_pid" ]; then
>  	kill "$watchdog_pid"
>  fi
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
> index 80a4755..41a3c83 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
> @@ -42,7 +42,7 @@ HOOK_ADD_MODULES = " \
>  HOOK_COPY_EXECS = " \
>      openssl mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
>      e2fsck resize2fs cryptsetup \
> -    tpm2_pcrread tpm2_testparms tpm2_flushcontext \
> +    tpm2_pcrread tpm2_testparms tpm2_flushcontext  tpm2_shutdown \
>      /usr/lib/*/libgcc_s.so.1"
>  
>  HOOK_COPY_EXECS:append:clevis = " \

So this should also resolve the issues we saw with testing on the MCOM
in our CIP lab, right?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

