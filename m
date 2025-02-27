Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DEAC19F2E
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 09:14:18 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.41])
 by mx.groups.io with SMTP id smtpd.web11.7017.1740647657225636598
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 01:14:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=b9chTtTB;
 spf=pass (domain: siemens.com, ip: 40.107.247.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IE0ChQR2RsbhwkyIadBbAK6Eo3hwo2h0ZZlW2T7OrYP9bSvjV4Ltk01q8NsH8VbGeYXEW1J05CxmGTySOVgWdg/wD6wj25CSHSL53bTKzzWagLg+6yLgqZH0V8W7UMcND/sEUZE0w0LEwgz2iRvRmYFIHqqk116fGTJsl+aEf2ZA4MX8kmxB2bWbb7sceiqGlL0ECiiZFLrI5REMfG4myHaECdyCbZuCnZCdM4cblYAhF5VOK0+9Al4VNlGeFSK0t4E3/sohaY9g1aaIM3yPJ3Gqhd4vpguJMBfOqQFmPrImg2HlRrQUE+BcyU8UwThPntrlnEKkF8OrIz/k0dslSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Kb0N6odicURPg5DfDN2VjB2eQomiSUGSWkALvw3WT4=;
 b=hhMDpJ9es0V+rQM4+mglATXrsdGdHaRUaLBIq+bRszMBAp34piTvDS/ipxYyVFYFFbuRnUrafB77WghNHstyPO8x8r49Nkd6JD7SiIGOhNHXAOgF+1sjNl4HuKoL/2QavfhH31u0mq+0vW8oO6FUxLWsXcd7uXNOPR7xGIM+RCnewRXbeNDSVsbhu3VOv+kYRJmo5+rfS4jkHYWZaJ6icjqfCWdD16LtEbKhhNxVfnUl1IRPgGArtff9YTwJvyWbpfclXGZ9ZC/vKgw67P2ew4z8TsUXqPt6GKgjXKB5eeinj7o4SirKfMFgLE7yRtpMQ/vW6ns6YYxKAeqtvAe+YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Kb0N6odicURPg5DfDN2VjB2eQomiSUGSWkALvw3WT4=;
 b=b9chTtTB/e/3D88MUC010Hhjj+C5/imB+Z0JAAOtSCtKTkmWF++56pdhkNIbTw/m13fKPt2m53LTxoTyuC4cTE4hp++HxlUXpHW52vw1MTN29uled1szJzcrKCs28E98TkJ6lZkih8Uo8wsHp8aF/arzXE29++4gSCbGGcnehs11yPPOhImHTy5IoyrMc5Z3zGoY4Qnhd4dp6qi37B27MyrSNRP998Th1LZ4A2/ygS4sfel3vLQNWPLRvC5gFD1N/3rWv1v5zyyYWYiygxLLysDUj7Yvk9/pc/D7n3abHzfvVli3C8JgH24FXX58ZjwhOItEdJVXM/wkz+Ip3oIXHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB3988.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Thu, 27 Feb
 2025 09:14:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 09:14:14 +0000
Message-ID: <83a283b5-0ebd-45c4-a655-7457e361fc41@siemens.com>
Date: Thu, 27 Feb 2025 10:14:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] initramfs-crypt-hook: fix inconsistent whitespace
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org
References: <20250226095921.168962-1-ch@denx.de>
 <20250226095921.168962-3-ch@denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250226095921.168962-3-ch@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB3988:EE_
X-MS-Office365-Filtering-Correlation-Id: f90fd757-703c-46e5-7c65-08dd570f1b03
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MHhPUnprL09QYjdGRzZOYS9kQUlmTlRodVBqNTZrem9NcWN4L25Vdk4zWExy?=
 =?utf-8?B?em1IQXRhcTBsOTJqMjNvNHhjTDJTVXRUUkNZbGFVVGRKQmtLeTVUU3Q0MG45?=
 =?utf-8?B?dWp4QUF1dk9NV1VhcDRTTTBsa1JjNjdkR2cyYm5qcEtJL0pQVFhNQTl3S2x6?=
 =?utf-8?B?aFJ2dFlXSVBWc2lSNC9RODRibkszRFJ1MkM0TWxzbTY3ZjJlZnE1N1cvdVF0?=
 =?utf-8?B?Ymx1Nzk2dmorTFZsMTlGcStiOVVCRWtBZ1dHNnlRVXlFdzdiSWwzYWh2M3hw?=
 =?utf-8?B?S2tubkFodzhibjZkOEZMWDVIanQ4NiszZ1dDSUFmSFhGaWs1bFh2M1ZVdHRC?=
 =?utf-8?B?S3h0UE1mSXpMUkNwU3JiL3JCd0tTWnV3Mlk4aGZXQ2tmbXBEMk90VGxlT1lv?=
 =?utf-8?B?NmNLdU00ejNaU2ZCamd6MjVVZUZzL1FQZHBMaitHT3VhS3RDUHViWnpwTmRZ?=
 =?utf-8?B?QTlMc09IbGJmanJ6Z2s5Z05LVXYyVDRObGNBRnNaWGRSNzFXWkcydVpQTUFy?=
 =?utf-8?B?V3hzNXlsc2hySTdwdGNKbjZUMWRjSFlha3c1SGUvUHArTDNldTlSUXhnZlJQ?=
 =?utf-8?B?N3AwYk5KNmNFSjltN2hKbDR4YVFreFpXcFdBdjZBbzRodE9FcHhlSlkxRnd4?=
 =?utf-8?B?ODdUUlRDVnRWWE1wTUFjNXdwck5LdnphbUsvbWwvajZmcXJYVlEwSWEwamZm?=
 =?utf-8?B?R1VMd3IvR21WaDN4RUZZTDZMNnV0ZHlPUjA3NlF1L01JV01WZjMzQW5QNktH?=
 =?utf-8?B?b3FaRWdBSE1DQ1BxeW1pLzRSMFhKR0RRdGhEQlJiNnRaQkxoSUs0OUJaWU5T?=
 =?utf-8?B?amQvU05jWEphdGhKRElPZVJNSGE5YUgraEEzcGVkY08vMkV1dVdLeUVOWklB?=
 =?utf-8?B?K2JOVWlIdXZkODZHaFlZaUpxVTJKSnJVUmJIa3NaWXAzazB4L0pOcWNpZnQy?=
 =?utf-8?B?alZoS0pxTXMvSkJyckVMMTZTUE9pODRpVG8yVXZGTHJLcjFLaGQzZVB5c044?=
 =?utf-8?B?SG4xOGRjWDV6TkxLR3IzcjZGKzg3SFo5L1BqMU1TRm9FZmZMdVBONFZmU0Y0?=
 =?utf-8?B?cDNoK2RRUnFtSzVLdStrdjF1UUVLcFZGYk02S0xCNkFFZ1Q0TWRkRWd5b0dB?=
 =?utf-8?B?a041M1Ayb1RMOExCN3B6bEgwY1lhV2FyR05IZ3RIT2Y4ZEw4RHlNeFpadUsr?=
 =?utf-8?B?VkZUeThLZzNSYVEwdS9OLzEvY3gzTWhLdTgvR0NmZXJ5QmtEMVdXTmFuNVFN?=
 =?utf-8?B?NGh5R2NGSXNDVkR6Z1dBY2hIWUF5U25JeW1BY1J6WFduSjBaMmU1cGM1SGI2?=
 =?utf-8?B?RFdLRXEzOE9RN2Zxend5TE83SEpwNDhaZzJtaDVoRzFIT0NFeVl1d21aT29E?=
 =?utf-8?B?eEd1dDdEMmtIbThzS0lEVXFsSmpiVFVGZ0s3ZmR3LzRHcDRzTndhY0g1eFF3?=
 =?utf-8?B?NzBiMXdpd1RvZTJ4aHEwMENsM2MzUlQyanpZL3lQQW84YkJiVkJaNUEvYlRa?=
 =?utf-8?B?dEVkR2JjQW9iZ0QwZmZCU3N2RXk5NUhUbXBxM0x6OVdsZUwrOFFlRTloWHZz?=
 =?utf-8?B?Z3pNdlVFZ0pRT0dkWVdMYUoyaHF0QVBMakZWbGQ5ZG94SmVrUGQ5T0tTdUtC?=
 =?utf-8?B?bGxkb1JRN3hnN3hESnZobW55ZEorMVNFcHdXdk1kT0I3U0VwdnRRM1FGYmhW?=
 =?utf-8?B?QUZMUUtIbnhXdzIxMW43d1lTcnM5elJLS29kNVJqa0hXTTBwcjRBYXV4RmdI?=
 =?utf-8?B?S3FIbzJiV3hZRXhrcktRWnFDL2R4QjZudmxSYkNlME41WmYxSWQ1S241NHRE?=
 =?utf-8?B?aGJUZ1c0Z1Q3L2doYlc0aHp4WEYyM3hRT1NjWWV0UVpoeTFVZFNDeXlZTFQz?=
 =?utf-8?Q?IZoDp8J+UVBHl?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?czRJWFB6K3RraTVSRFRneHBlSXhZNEtEdmZpcWJVMDVkS3M2R3Ftc0kvU2xJ?=
 =?utf-8?B?aU5YcUtpK21RVDVaU2NVbTJKWEhxWlFUYVMrZXVnQTJWTDIvWCtjaXM4L0dV?=
 =?utf-8?B?eThWMnNvRlVKS0NFRXM3c0NwZ21rZTl3VmtNclZ2a0NPRC8zenBhbGRFN09J?=
 =?utf-8?B?Q0RQV01ya2w5ODNEWjdhdi9EMEltSVVMbzIxUHdPd2pMc2tPaW5WOG5NdENm?=
 =?utf-8?B?RTM5dU5WTmhTWG9PMWF1aFZnWWp5amd4anNoTHRpZzMxNFRQcXZyc3EzSVNI?=
 =?utf-8?B?eGV0bURpQnpOb0ZmRDhkTHpEU1o1aDhmQzZieHBucTFPbHJMVUd5WFROWkVs?=
 =?utf-8?B?cGJQazJWNkNHdk83NlVsbmhWRHNlWXRQay9yQ0w4dUtnSlJWUGRiZ3A3NWdt?=
 =?utf-8?B?SkIrZXNQUEllWEEwbjg4N29YRld2OVhUaUdja3Rjd3lnTVJTZ3FyeHk4WlZF?=
 =?utf-8?B?c0pIRm02VFROM1A3Q0lxTWo1Ti9QNGpjSFhtYzZXRHVreTVpZmkwQjRGdFFi?=
 =?utf-8?B?TngyakRvU3NQU2xrMTVnV2crUTY3b1BQV1lyK05uNEJYZlcvWW9UOTNlUWp3?=
 =?utf-8?B?OUVUb0h2ek1tVjFOT1F2dmx1VmlhTlRtRFd4aVJaREg1SHYvdFpXQ1pBVzZy?=
 =?utf-8?B?TnB0dE11dW9HbU1Sek52Tk8zN2Fod2FQS0hiSC91MGkwSFpRRitqN0FvZElG?=
 =?utf-8?B?cFY5QnZCNXdyN3R4WW5sL245dzBtUitFOStSeXcxbC9jR0ZJN3oyaEF1cHlF?=
 =?utf-8?B?TG9oSjdhc1hsRW15NytwMXc1QWd2WjVWaXVJNHFuRGgrVkNISjNNQXFMc3U4?=
 =?utf-8?B?THpMQzdTSGFoNGNRUFRPa0xERkdGY3hLb0lnRG9vdGZBUkUwUFlKWDlienk1?=
 =?utf-8?B?a0RFbVVraDFaSlBKQnNaNmtCcS9TbmZ4anlkbE55cTYzZVFqVHJGRlpURG8v?=
 =?utf-8?B?eEFTNVlUZWRiYkt2RGU2a0MvWHJ3T3VrMUdpMSt5U2xqMEJ3Ti9ndEk4RThx?=
 =?utf-8?B?QXFialVna0V0UFpvcG0vNTJ2YkVwckdFdkdVWldFeVRpSXBicTMrRDdldy9U?=
 =?utf-8?B?Ly9QZ0dHSzI3eC9EcWZKVFI5ZmVIQml5VWg2TGhPSzZxSkZHOEw1OWsyKzgz?=
 =?utf-8?B?YlFzeW9qbmgwS3dRODNzM1VTYkpYTjNzckhBTjhrdlM3VFpESHpFcnVlOTU0?=
 =?utf-8?B?aHFmTlNQS0NHRDNxSUZTK250MjJ2MEc0eVdNNGVzK3ZxOC9UaVF5d1hSMkow?=
 =?utf-8?B?OUFXU1lUZVRPOUxJYmhCdTl5d01Gc3dHdm4rbU1qYzZmRXl3ZEdkMEtsdTc5?=
 =?utf-8?B?Qkw5MzBRSksvelNjZWYxY3FiY2tKU2FJcHVoUnM1L0QvWEExRk1kTkpWM09X?=
 =?utf-8?B?aUNPN2pnV2VXUTd5VGhIMGt1ZXdvdjRRSWJnL1FZNURHRlFZcE5pVHRQdXFJ?=
 =?utf-8?B?ZDBQR1ZkdDJ2Ty8rR2pVNmRLd0dwcDkzYmU2WWhORnNmUVhYODgxdG1CT0Fi?=
 =?utf-8?B?ZFdrd3A3OFlYZ2VxSnRnS3BOVGNjMGhyWld5bVA2TDhlZDlZMTNLMGtDL0lm?=
 =?utf-8?B?cnp1c0tIa2RPWGU5SmVaRVhqMXI1Vlg1TVNybXRGbWNBRWl5Wmc0bTh3TjI5?=
 =?utf-8?B?Rm03YUIzYk9OSC9CV0oxZUVTbXdqcHdUNXR5YTJHY1AzNnltVTl0TWZkc1oy?=
 =?utf-8?B?ZDBwTWNUc0pFaDRJU1NyL1ZoUmVpdGVkSVJSQ2xzVTEwMkZsUGhkTWVFdmMv?=
 =?utf-8?B?NGkrVUZnQm5JNlFWZnhNTDlzcEM4WXlzRWVWUG9mMTBvNHRsWGlYdWZ5RUFu?=
 =?utf-8?B?dmk0Tm5iTGxjVVozRkpYYzYvK1F3azg1NXhBOTNmaVJHTzh5MUE2SG5PY0h6?=
 =?utf-8?B?UUVhQzljOFBXbllndllUK2oyTURmLzlXVkJzS2g2MmhYdlc2d0pxSUhUY3c4?=
 =?utf-8?B?L1VWdFFFMVVWd0dPQ2t4ZHo0eW5CWlkyNThSOTZkdTNrUnR6T21wZFJBYU5S?=
 =?utf-8?B?SytGNEk0TjFsM29WU3R1dklub2NsNHl5VmlYWmVPbVZ4V3NmZmlJLzJwVHFF?=
 =?utf-8?B?UjgxL2tXMVY5Um1SdlhvekVIMW9mRk41ZmlJRVNxWE5SRDAyWlFGVUlFMUpL?=
 =?utf-8?B?MHBGWC9IYm92NkRoemx2NXM0VVhzUkpNUUtRSzZpRHFjWFdvWE40RXhCT2gr?=
 =?utf-8?B?bVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f90fd757-703c-46e5-7c65-08dd570f1b03
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 09:14:14.7626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++a899r17qNE9GnvV1yEoXFwRbUsmtKVidRPAXoZWQRR7RQNNABXgpBJoON7h+C0RlkUBwd16OTPCoFls7WlAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB3988
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 09:14:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17931

On 26.02.25 10:59, Claudius Heine wrote:
> Signed-off-by: Claudius Heine <ch@denx.de>
> ---
>  recipes-initramfs/initramfs-crypt-hook/files/local-top-complete | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 54b8a6e..f1aa0d7 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -262,7 +262,7 @@ for partition_set in $partition_sets; do
>  		;;
>  		*)
>  			panic "Unknown value ${partition_format}. Cannot create a encrypted partition !"
> -		 ;;
> +		;;
>  	esac
>  
>  	finalize_tpm2_encryption "$part_device"

Thanks, applied already.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

