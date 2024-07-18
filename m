Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA22C3DA60
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 11:30:30 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.49])
 by mx.groups.io with SMTP id smtpd.web10.12990.1721302222151950408
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jul 2024 04:30:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HN7cIgv4;
 spf=pass (domain: siemens.com, ip: 40.107.21.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T12/ABqPSl32KfHOFI2Xx/LyjYQ+2AzIh5rX3KVbtw0sI+bTJcqL55JKdH2TJ6xa1uoDX1i9ZT/NbG3WzZscvPz1k+GrsOqmGMj1AEwhVRzNwUfOfHpYBuSOLjcxsyuK2zrTfiloUAHhsnoSCwOUaGxZ4gmtv+X9H3EHLzPe1Z2H40kglZSL43v4OrJCJ2okspdjAIMZ4rw+VEtZraQiy6H29E6COQpcHwdTTerTZEIRKiQdYVLFCsrjPSWcorMWmnpQosPh9asu2UHTUoml9iwvOWpmLmS/PAUwsGAkC7K00C0+8vO0Tp00UEU39mbSqN3u92JtjPsRjeMtcLm3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDu2Q316nyOfD1ar8graDtSKrx906Xy2t2Dg7BqwKA4=;
 b=X7shMEkJqTTGtZnpPpuMDscHRLX/o7u8C6aQ4ptE+xH18iGH28Gt56ph7BUrfgJdQTIVVNmFErF8YJSlY/rTfVe2ewSnQNlreYVUEG0Jeqj3eCj07/aystpxoFHk3cUc4VwZHoCl/TECM1cVEpi6PRvp9rowkdLaS63SdOIWRY2KYlMCw06gffpHx8fw6+7EulA3mP849ETjnbZZwOaZQ+K1r75lI7c+wjVcUMsQ3PDhuGHN2K2BoDIbHFBkpSFkurSYofKtA1Q3kARFdYrBfeq5N/n+T1PVDvfZShDtpDflzPVxsk+/8dQ00E9Td1Ew52dZ8cfhRqW1p+2eGuZpmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDu2Q316nyOfD1ar8graDtSKrx906Xy2t2Dg7BqwKA4=;
 b=HN7cIgv4l/BWV6TcfOMxL70tm0iWHkfWNSdIIEZ03X2X2/RIIsuwGB9tvM8f64I94shhJ7wa/BJHlVC5dQctMA9GO5Bai2LxjAGsGUcMpNTRl7Zm4TX15ekS3p2xEjjJRrL6w4aiPssbLu3Ob6mda1YDSHHFYwO8EY/3oHR9lPyhnzA4TinuMFgZrlwk3hJHjlSHgQdN8WRxsqrdy/Wpqhb2YuDQ19MmvfD9x3iTtdmA5r0GfrbvKwcQ7II2wKMQSmnP9lEpFna9VXz6GZodteYJ5NOvsXQOx9M4pzqQpuD9ib72GwFhoZirYwwEqEuIAxOfpxr23sifscnMe7zjQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6249.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 11:30:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 11:30:18 +0000
Message-ID: <a3d45b99-702e-4ecd-910e-4dc1f3ae6301@siemens.com>
Date: Thu, 18 Jul 2024 13:30:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] [PATCH] classes/squashfs: exclude boot dir during
 squshfs image creation
To: srinuvasan.a@siemens.com, cip-dev@lists.cip-project.org
References: <20240718105718.11562-1-srinuvasan.a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240718105718.11562-1-srinuvasan.a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: 1769de84-cbcd-45a0-0eda-08dca71d0037
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TWRnS0lFTFJKbmJEcFUycEQwNzB0RUZKUUg1SmI4SkFuM0Nsa0FtZ0JVU2d2?=
 =?utf-8?B?Nk9kSEJYQlZvZmlvSUh5SlNnMFVDanhoSkJkNTN4d3I5d0lrd1ZKMDVpVDNF?=
 =?utf-8?B?eU1RT3hCcTA3bGxOb0RwSGorZkExNDJJWU01NzUvdUFFUFRTVFU1RU44Y3Ns?=
 =?utf-8?B?dWIxNW0rNmttQm14eldJWlJtNjdXWUZsdWUvd05XOGw4RnRyS2lxWnh4d1pD?=
 =?utf-8?B?SjJGUGdWV0tlQjFCMGprUGN2alo5SmRkWUxVVGlVSjRnVTNhSlBBRHpuNTBr?=
 =?utf-8?B?SFk3MS9ndjVCY01Md2F5WVNDdDk0UTRUWjFnVE8relNlN2tlQkxGdVkxc2hI?=
 =?utf-8?B?WUl1K0QydCszeHFMVHM4cDI5VGZmUFVXTlRyWllQQ0U1cG5sQ2V3dG5OUXkx?=
 =?utf-8?B?OS94T29oTkRHYnhpOWFzYlVXS2VOaWpxU1A1ei91eW5pRTdaT082cmFBMjha?=
 =?utf-8?B?MkNsTUZjR2NCV2liTjZ6UDBuTk5IVHozRlBYUVdGUGdLQTd3dWdvY3ovbGhh?=
 =?utf-8?B?YjlZVlFMbDdSRHY0VDZ1QXNqbU1YM2NYR1o4cmo1L3Y5NWZnaFBrSFFudHcx?=
 =?utf-8?B?bXF0aThtR2cvcVJ0Wmprb3ZXNFJnT1g3Qjk4Znpyc1lWU1g2aFl3T1lJYncz?=
 =?utf-8?B?VXdNS3NnSCtZcEJHdWhERWJjYWNiRlo4dnZZN24rTkpkYkhjeUxUdEtXSzJI?=
 =?utf-8?B?d2tWL2NwOEtac0M0L0NKZW1OTkFwekFObWZYeTRvREFrOVpRQWZyNERrZWVL?=
 =?utf-8?B?SmlDTThrWFRENDdyK3QyZnJCSnNvZDhoL1hQRWU2eVo2Zkh2a1dEZjhZaW1H?=
 =?utf-8?B?cXFJV0xLNWN3R2tNa1VyYUtQRDZRR0xHZEdac1Jnb1VkNnJxYXdhUzQ4OTRk?=
 =?utf-8?B?d2RpeVR0bkxBaTE2NGJNUFg0KzMwTkI0cVNCakpzQm1pM0FGNnFDTDJWamlr?=
 =?utf-8?B?QkJRTWw4a1BkQ0twMVd3V3NHU2hUTVJlNmk0UktsOGtZS1ZoQ0FldGpEcHE0?=
 =?utf-8?B?amRRZ0VwdG5XRVkvU3F3aThmclR0ajU4RWNyd0xxTGlvY0ZxTGJoVER6UmlZ?=
 =?utf-8?B?eWl2Q3NYNFdGZTh1d3B0d2pvdmVYTWRjQ29EaExRTEE1NFM4eWFLN2lRSjc5?=
 =?utf-8?B?V2w2T084ZlpUZnQ0V2NnWHhNdmVjOGVYT3VZVHFYcVJ0TllwT1g4NWx0Z3JU?=
 =?utf-8?B?aEdNTVk4eEd2ZkdWKzQ2dkl5YkxMVS9MNlhZTjBwVzd5N2ZET2VpVjhHellD?=
 =?utf-8?B?SXV2a1NZOU1uOU4zeHc4ZDJhL1p5ak5TckRIZWR5Uld0bFdzdTdrZXVyNklo?=
 =?utf-8?B?dndNbmdxbEQ3eklSZUxXbG44cm1OWXdjU2I4ODJUb1BDazI3dXlZTEVTU01O?=
 =?utf-8?B?UGJTZEQ4T0E1ZGpPL0xVN3RwNjc1Y2l4Z01GMERHT2M5K1dUN3gzWWRwSnla?=
 =?utf-8?B?eHFLTHdMSENmNVpCMGRoSDNDdTlkQTdMcGZSMURYbzJHRmwvYjZ5bW0yYnM3?=
 =?utf-8?B?QWlpRG1yOXl5TnlCekoyclcwdTFSYnlSSjVnUXJ2OForbzVhdlZuNkcyb0tj?=
 =?utf-8?B?ZVZCa0hCY0IwanpRQzdHcUlsbWdHY1NkU0libVA3L2lDazJLSHh3cFQ4emUr?=
 =?utf-8?B?cmRnQkxPVGxPUFM2amhPVExIQXJqakJnM0ZibndEM3YrcUhPRUlhTW9xUUN6?=
 =?utf-8?B?QlJVdVVqNmxIQzFLeklGdjZka2NWT3ZqNlhUTmpCQWpLWCt4eU51WEdWejVW?=
 =?utf-8?B?Ukhrb0drQktIWG5GSjA4QStoQmVLSWxwWWYyZUhrZmVycjVXbU9KcDZDRjJH?=
 =?utf-8?B?SUpWZytmVkJwamdYUndjdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N0wza25PdFFJdUxCaEttVUpaQkdtaGlrME0vNGhEeklDdHNEME45c0h0c1BB?=
 =?utf-8?B?K0Z2RDhjVy9Ed2VGcHNPN254VmxZUGJhS0ZhMkVtU2ptRW9zZXl1Tkw3ZU1X?=
 =?utf-8?B?bU05M0M2SnozYTVGeWp5VE9BaE1QbnZpelNaVFU1ZTJvemJlKzIxMGZxSWcw?=
 =?utf-8?B?OEVCMGlkb0QwNXVKcXlRaXZ3SWUzSmZNVG9jenRlUEt2eHErY3JMUHVtd0ds?=
 =?utf-8?B?OEo3dit2cUtlZlNhOXlETEhPYU1hb3kyWm0rTjVrbnN0UVU0ekYvQVd1a0k1?=
 =?utf-8?B?bTgvMlNRV2l4RVMxcFFzU244d3JjY3pUQmkyc3dQTTVsVWErakFwL3EycWdI?=
 =?utf-8?B?SkViYzloanpJMjVwZkY0c3NtQVBwNk96VzdNQmRIMml0Zms2UkJOSTVCUUFn?=
 =?utf-8?B?YnQ1L2FpRktXMGhRa2hrN3Nla3g0MHZWbEx1M3VhTm01QjBFYkJMaWg2VFc3?=
 =?utf-8?B?aUQrS2VVbnVHNjdtc0lwdVp4Q3RVb01oTDIxeXduUkxNUmlBdjdpS2M3emFQ?=
 =?utf-8?B?WEpRR0lJS2JXZGNzR1FBQWM3TiswanJ1bUJJOVVUa0lSc2l3UEg4dGE3blgx?=
 =?utf-8?B?alUvaEdwVVlFTHNNTk1kV3U3dVB4aXA5TnVMNkpqcnZ6TGRESWlFUVhpeVhu?=
 =?utf-8?B?LzBoRXhsK3QrQ01BWjNIVXk4aC91cit1NEtQTjlnNjFKN3UxL0xmSVczd3la?=
 =?utf-8?B?eEV3UzNNVERLWS8ycnVVSXc1K3RSTGdFT2F5RXZZK0Z6V2Ryamh6NVpVMGtG?=
 =?utf-8?B?NkwxbW94emZuSnJZdHdhWDRIK3NXR0IxK3Q4Wjl3QUVCQ243SHNod1lUdXBw?=
 =?utf-8?B?d0VWcXc5c3RCV3Q0ZVpjUHJ0QXVZV1I5dWlmNFg1ajFkLzhLQmtxM0lkVVlv?=
 =?utf-8?B?WE4zUUtMVmtBUXZpL2RCcldJQVd1bUxwUHI2d3BCMlBPMW1PZ2gxcURibVZy?=
 =?utf-8?B?bGNDU3VGTnVBbEhqUHI1aFZ1SnVHdFhPWTZtRnFjaFRaTjJLTy9YNitxUm5S?=
 =?utf-8?B?Wmx0WWgxdHdBZkFVTjFheUxNZHVlUHpseFhUbW9UUVBDYytTODlNa1UzNEJW?=
 =?utf-8?B?em1QOXFOM1pwcFM3Z3ZURG1MYm9qQ1BMTlpYZHFBcWNYN21tejNpaW5tZG4w?=
 =?utf-8?B?UnArUGZnOWFtV2VDR1ovd3UxakUraGNIRERJNzB0eW9kZ29taGNsZjU1SGRy?=
 =?utf-8?B?ZnFLUFg0cEZsREs4N0ZBRVlnd1JIaU1QQ0gveEZvbmh6YnJGWUVzVHhRaVpF?=
 =?utf-8?B?NUJNWnNmQlNRWmR4bVN4UnZWUVA3czB1d0JxQW1ZOXdXaWZ6anUzc2ZWWnEy?=
 =?utf-8?B?cHpZVFFkMzZHdDJndWV2N0lSYTF0M2pFT0lYQ3ZoeWFndXlJTlhvRFJ0RE02?=
 =?utf-8?B?KzkwSnA1WFhiWnIxeXIrY0luUEoxNU1acmd4K3BaeUpQeHdoeXlIQ085RllH?=
 =?utf-8?B?aFJoUVlUMHNGbHhKZjJVVGtFTjkrcWMzS3hGMzV5cGREVjNER0MrRllsLzlN?=
 =?utf-8?B?Q2QrRVZGVENSSE9TYWZSMjZ5MjZMcmdRMm95VUhuVEtTLzI5eVNaV1NwVGZx?=
 =?utf-8?B?czR6YjUyaFhUb3E1QzB2ZHp2dG80clpvMlJCM2FDbnJTTG1aWVg0YUlkajQw?=
 =?utf-8?B?UXdrQTlvTmhtNXM3c0JiR3lFWWdzODYzOXdGVVExcS9zVVJpK0tIOVpSYytT?=
 =?utf-8?B?bWZ2M3BxUU5oenIxNkQ2WW5YSjFSaEwwMHliYzVlbnJYMlp2dUtnakt0ZUpm?=
 =?utf-8?B?NnE4SFVWazZZTG9mcm9DdVc3ZC9SbFJSMEJ0UkdleFhSKzZXc0NkTEw2bXhO?=
 =?utf-8?B?VUl3YmxXaTlEU0UwSXNXNmJ0WG91cjhrdlZBMDQxdUk3Ym0xb3ZZdUV1dXcy?=
 =?utf-8?B?SUZjNWJKd1hWd0RROXVpOWZYVmlkWEtOV1BGa1ovWlpnQTkvSWI5TkJVSGpW?=
 =?utf-8?B?bXlCd0dpdHNvS1lqWVZEVStIeFFmODh0cjNnRG9mTDB2djNDZTk2NzUxR29n?=
 =?utf-8?B?Q0FnNkhsYnNPOHZhVFY1MHorQnRnUDh5NmkzUVNndkZQMlBsTHc5d2RpN3c5?=
 =?utf-8?B?cnMvYzg2RHlkN3Q5NWx2NTBmYmZwS3Q2Zys2OTBDTmpIWTBNQkVhcjc3SVhm?=
 =?utf-8?B?SjZldU5QSlF6VUZldkl6NGZvekYydDdvdklRc2x5bTdSL2V2eEJFU3FmM1JO?=
 =?utf-8?B?Z1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1769de84-cbcd-45a0-0eda-08dca71d0037
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 11:30:18.0493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBqC0dNoVmXyfCdSCPPA8DFDBTDfTelCDHa41DSGO18JxpOrDvCvms+C7ixrl6eoc7rHKq8MCpRadKRJv/9tSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6249
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jul 2024 11:30:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16587

On 18.07.24 12:57, srinuvasan.a@siemens.com wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> For all the UEFI based bsps we used bootloader as efi bootguard, this
> linux.efi contains necessary boot files to boot the system, hence remove
> the boot content from squash root filesystem.
> 

I can understand the goal, but the squashfs class is not logically
coupled with UEFI booting. I suspect we need a better place to add "boo"
to SQUASHFS_EXCLUDE_DIRS, a place where it is clear what the class is
packaging.

Jan

> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  classes/squashfs.bbclass | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
> index b39be0c..f9c7bf4 100644
> --- a/classes/squashfs.bbclass
> +++ b/classes/squashfs.bbclass
> @@ -22,7 +22,7 @@ def get_free_mem():
>  
>  IMAGER_INSTALL:squashfs += "squashfs-tools"
>  
> -SQUASHFS_EXCLUDE_DIRS ?= ""
> +SQUASHFS_EXCLUDE_DIRS ?= "boot"
>  SQUASHFS_CONTENT ?= "${PP_ROOTFS}"
>  SQUASHFS_CREATION_ARGS ?= ""
>  

-- 
Siemens AG, Technology
Linux Expert Center


