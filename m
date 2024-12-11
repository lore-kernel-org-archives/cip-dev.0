Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D299E7717D
	for <webhook@archiver.kernel.org>; Wed, 11 Dec 2024 08:15:33 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.70])
 by mx.groups.io with SMTP id smtpd.web11.5850.1733904925211904909
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Dec 2024 00:15:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TnZJl2qY;
 spf=pass (domain: siemens.com, ip: 40.107.103.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATzGbGjwNKayzv8tz5t8YABfEysTUzRND673DTobL6lSPk/bALek8KXS3tdwMgk2J3+A0OHq0izmjiUxXGzWx0E7fDBq9Vvjomqi5p/rxD4o2RZnTqAX+DlzDNLRDcZJiH0vsluj3HxI453/wWHmA7dMNBHnUT7j3ImVeTEQJlgEa2i/jCyJcSS3DBEdFJmgMGzwKz1lACLC/i0Or1M38mg1ZAVKYTA0D/go8HrUt/ZOwzEL4pQojN/aA4wTX7KJjgs9XNjo7viSc7IbBZ4pQgT/9DyOSo9mNVBpCi1JDObfNU+MMwqlRZgWniaSNnDdr8Cm4Hx7DbTRLBjsW5SnJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsV2twantq5vQjsA5ztnulFBQ4R0EVmNbWgYUm52HG4=;
 b=aXZOmADc4v4j9awihZzemgZ71w7NXmOPPOWo0qVbW9PbkOFTScPyHy1BnxY/lVm+P4Rb5Rkq7hgY2BHNTfCOpvA3pLXUTFfbXFJ2Bnw+UW+UDzhKSgv80P26jJOMY10gqwxfRbdXTvK1Eb48BX5tjIYQd9oS+/8+ECL4qa0wusaGAot49mi2CwALPpR3Yuz0BM1jVrphvWSSwIHN4rZisWnKEJYMpIGmrnvEVTouH4s+kCOzhMusU/pX4jgwEBTDAj3oFFq9lSrIJ5aZ6lejvFCHokQ27PvIglb+gCb+fz6yZW4cs2Ya++v2ngvLGLMUrJlj/YXJd/zmkejcHB+t4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsV2twantq5vQjsA5ztnulFBQ4R0EVmNbWgYUm52HG4=;
 b=TnZJl2qYoFr5wi59MRClNUt5hOaiCb9Gs2fbV1fmo3mnj5FUVYFDU4J6k8VtgYR+I0YcFDKBV/GrIkV1BaK3aQrA3Tfy/zSIOCQXQc4cpnCKLGDeor4xObvdW0v3hiUJyHex7X7AX7tKwzxUF8of/01v07dvHhuJaSG+X4khZCW1tzIMzy5Nl6wDZ4ujBwIdQ/D3RLXXA23W5KZ4PzkuzDX6SNwlyURvu8PRpElr+DVOY/Ep05yGgEmIS6OY3axOY0RIOvnbvYqHGxdwn7neZHoFnMaaBnrxEqe2Avn1ejNbt5bqobKoepsowmnNgBnfaliyyFtNJJb3hTKt/nnl5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6179.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.10; Wed, 11 Dec
 2024 08:15:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8251.011; Wed, 11 Dec 2024
 08:15:21 +0000
Message-ID: <ec0f8d94-d288-42e8-a747-bdec50077986@siemens.com>
Date: Wed, 11 Dec 2024 09:15:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/1] exclude boot and var in squashfs
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20241210164256.2674390-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241210164256.2674390-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea0e9c0-1bee-46a1-6cc9-08dd19bbf49d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eC9FNHJHWGJVemJkbEV4aUQyZVl0TFBSMExCekl4ck5KblAwWnVXa2ZWa0dx?=
 =?utf-8?B?cHhleWVhdzQ3QXpQWE9HaW5IMlhJRGtzbGFiTWYvMkQzdnhCeTE4R2puaEVm?=
 =?utf-8?B?MEtPeHVHaXdJU0VjSHRxUm9idFFVUFdoOXA5SjJkcWRneFViMWN3TWFpOVEw?=
 =?utf-8?B?NFJmTzR4ZzN0RWVHalNGVW5jSmxHSWZ2OVd5YXRsclJ1aWJVS0U1Ymp1SjJj?=
 =?utf-8?B?UHVFTjRSRXVjT1daN0Vtbi9tMERtaldCZEJPSktkRnU4dThBaWdMSzFvYzZr?=
 =?utf-8?B?UXpkK1hrRkhaSGVDd3huR1VlQy9PRU5ZN3ZKM2tuV3g2c3NQNERXNnNjZUww?=
 =?utf-8?B?NmppR0Yyb3R2Rm1wcEF3ZXlLaUZ0V0RkcmtGaVlKVXhMd09OUWNPaTRZZEQx?=
 =?utf-8?B?UXBrMFdkdjA4eFcyc1lmenUvbGRQQ1RCNWlFeXc5eXNhVGFqMmtuUi9uWDZh?=
 =?utf-8?B?a28wQ1FEdWNBRlVnNjIzL2ZxZ24wMHRNNWJKWGZrMnBlK29uc1NPN2RxRHpj?=
 =?utf-8?B?YjlydnlpSzRabVpYV3V6MGJwc1F4ZGhkVFg2RnluUG54LzYyN1B1SmU0V25Y?=
 =?utf-8?B?eDExeWFCUmtlRkdCcU5PendZckZxMjlrcXV4M2lEMFR5OEhOUk83VE1DcXEx?=
 =?utf-8?B?YWFURFlKbHNDZ0laVCthTDlVOUpNSnVYQUhLLzMrRTdRODJEaU1EL1pJT1ZV?=
 =?utf-8?B?SUtIL2Q3NUx3cmIybEJ3c29mL2pVNEd4bFByWTRtT0JjSFJsbE9zZGFuQnMr?=
 =?utf-8?B?QWNtSWNrOUdRN01XbEhVMXdTekEzZmtzUTlrYUFvQ1hmS1VjcG5acGptOTlR?=
 =?utf-8?B?TkNLSFJQME1YNzBmOVVaWGthZXVkSWg4L2tlcyt1S2hYZ3cxY0V4K0FrQzRE?=
 =?utf-8?B?ZWluZzFQVVczSkQ4SEd2QlFaa3pIRWlHTUN5eU5nK2MvTzU5MXhpTm9MYXh6?=
 =?utf-8?B?dGdZWEpHczh6a0NIS1g4aWhYdm5KYmxibXR6MkxsS252aGhBaVkrejRwRWFB?=
 =?utf-8?B?enZIa0lxby9Wb3lETzhwQml5ZEluR0VBZlhwaDBkTDhMYjhiY3lSK0NxTERM?=
 =?utf-8?B?dXBiNThYcTRJMDVqcElMUWRDc3VueFBwb1RXNHBlanNWaEgvMjZwQldxejZo?=
 =?utf-8?B?WUNLKzRmN3l3VHl3Q08yNnh2REhtL2kvbXhhL3dmVEcwWWZ2ZzlOQ3NXNWVX?=
 =?utf-8?B?bFFCcUh0SmQ5OVN1RndZeWdmMS81YkI1ZFBWVGJpV2FCU0RxbnhFaEtnY2RU?=
 =?utf-8?B?RHFMWmVsRWJvUHhyNUZjU3FObjNrLzB1ZEwvUUJLSEZhNjd5VG0vSW1ndUJx?=
 =?utf-8?B?ajdIU05tNXh6WkpUdjhDR1RHbk5VWDNXMEdERTl5QkM5YWhaTTVkd0F5V3hE?=
 =?utf-8?B?NmJIOW5GbmY4SUVMNkN2ZkltN01UcnI5R1laUmdMaGVtNjU4cUNNUFBkN0ND?=
 =?utf-8?B?b2hER2x1T3NHSFRHV0VWRG1BUkpPV2t2ekphNEVCdEFGaWF1T1E2Q0dGaG9x?=
 =?utf-8?B?SzN5bjlMODBIOGJWV0xPYUNQWnVHYTJ6N1E1Y2QzYTFsbERxd2xNVysvMUYx?=
 =?utf-8?B?OWxURjR0eEtPNm1aYlhXN1M5QWFDNFgrbWkzTXBnK0pIT3d4VlFQMGlxTHVa?=
 =?utf-8?B?WWhDSWhHdXZjWXVoMDRsWWdNbHZmZEpmQWJ4Y0l4ZXVMTUkwbzJramRIZWZ0?=
 =?utf-8?B?aXdhS2tEYmtRSkFqRy9xbldPVWlUM2NwZm0zbjBCR0RJclpFcE1sVFJPOXhK?=
 =?utf-8?B?SW1ycHFpMkp6NXVFYXM1VDBBanRHcG15ckh4M3VyQ3RlNTZCZDRUTDhCanc5?=
 =?utf-8?B?UytuSGp4SUhGQnVvMFRVUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?clc4MU9yRXFhUzVmbTZJY0RCU094aTUwOG9leko4anBtNGhPRWh2N2V2M0Vq?=
 =?utf-8?B?QUJzYW9kT21HK3hOVzQ4cEhtMUpBc3dJdTltSUI5TUZGZFRQdzYwblFCRHpI?=
 =?utf-8?B?d3dTL3dwMlpmYzZvdmRhNmpjQUN1QUZadk53QmdEWmhHekc5eEJXTFNBTFli?=
 =?utf-8?B?Y1VRN1VTN2lsK2JEcWpoSEpIYXJCMjd1di9lTks2eWtWNkE4djlXTkFZRjhK?=
 =?utf-8?B?R0hSMzRpRGZHTVhjVDltZjZEWFpyQW96c1RCTjA5VnVicjJQS2M5SHd5Q2k2?=
 =?utf-8?B?NkNxRXJsUCt6RDhzWHlEbDBTLzBKR1hmdVh0djVIVnBqcER2YXRqWVpBNjky?=
 =?utf-8?B?OElQd3ZsY09EbUdEVFQ5OXc0SHZvYnd0Y1BUNmRGN0oxV2NrbUl1ZUl5ZkpO?=
 =?utf-8?B?TmlGRUp2a1NLK3NEMUFaWmNBVDFKWUVROVhld0N4alo1VkZ6Y3R4RzZSZFJB?=
 =?utf-8?B?dW5vUjNFa1VBbGp2QlpkZTlHRm9nb2E3aU5KOCtuZkZxbnMzL2R4S2tjR2JW?=
 =?utf-8?B?TWtUdjFVY2tRTjhFdDI3KzZuMk5TL1ZaeHlseWwzRVFzUXdieTc4cm1MUklO?=
 =?utf-8?B?QWNFY3Azd2VZZ3FzR1dVQ1NkT3NlU3RKR0NlQzk4NzBvZG9LVEhVc0JhcUR0?=
 =?utf-8?B?NVRQa3lFVHE4TUNteVkwbWpFb0Y3b2NFUjV0YkJPTXpua2lpTFZGMjAwTWdo?=
 =?utf-8?B?cUxKeHhZUkJRbnovb3NxNEtiQzVWUDVyRTRjVVdMa3RrU3o0cHF4NkJ2QlVj?=
 =?utf-8?B?d1dsc1d5Yzl4TU9LQk40elY0SkpZYVhDUkFwT2R0SWlaSld3eXlodFl0Q0hX?=
 =?utf-8?B?NVl3b05CaW1pVHZTRUZyK3YzUTh6dXlBUEt1K1NEOWZFdy9lQlk3d0RFR1NY?=
 =?utf-8?B?SmVpWlZRYXBsM2JPaUVHdXdPbFhTMkhtRnArN1FucEZwd2pvYWY5OTRkbDBq?=
 =?utf-8?B?QnBNejhaSUlBWk1keU5yVW1yT3lNbk40cUtWeVgwOWozRHZDNVV3NDJOSXY1?=
 =?utf-8?B?MG9xU3hOSEUzSW9SVm1EaktOemlLZHYvamMyVzFLeDNkNkxOaUwxSXF5TURG?=
 =?utf-8?B?YkhpMGhPSURXSVU0ZWw0Y0NhYmVoSjlrZ1cwRjFSTGRFTXJZcG9JUlJhbndU?=
 =?utf-8?B?c1NCNnJOdzJUYWRyNUVPbGdzSWpaYy9POGYwY2tTTTY1TGZFaEdBWlZYRVNY?=
 =?utf-8?B?NWNXM0I5TW9kcnRmeW9Sb3FhOW9BL2duNm1udG50TGsrUUJscTQ0UjRGTmx2?=
 =?utf-8?B?S2VCdnc2dXQ1aUFGL1FBMnE1U2t6enhWd29ORlVkNlFXWDFQV09MMlJnaUtK?=
 =?utf-8?B?T2R0bXZBVjVMRVprTzZtZ1cyMUJXWUpyRTg5citraUJxbytIWmNKako2U0xv?=
 =?utf-8?B?eUMxdEM2a3NVYlJhd0paajVaRHkwaTBUc2E4VjZpYXg2QzFaY1JGVTdlSjBr?=
 =?utf-8?B?VHJCcGtBZE4wV1JjOGUvQVNkWVZYUTMyN3hoajlxRmVNVDVKWmZPNmplMm1T?=
 =?utf-8?B?azZnVFE3aEhmK2YzOHNmVmw4d3dPVE5hRlVObXBSeTBTUGJURllqRmdBRW9K?=
 =?utf-8?B?aTBkYTRYQit4ZHZ2WVA2UnM2TVpoMTlQVEJPcHBDQklsb0MvVUwwMUtvSlZL?=
 =?utf-8?B?b0ZxUmRHQ3dlSGQ4dTZoNkpJNmZJNHpIN0liWVE2ZGVlVmFRSldvY2s3VWpy?=
 =?utf-8?B?T0p2ZVJGbkF3OVBxakYyOVppbFZFeTJmTDFMSGRvZFBROTlIV2NqWk9TVTB0?=
 =?utf-8?B?Y0RXL05HbVhkRXBtNFpIZkcxc1pJazd5N0ZORnhZVnk3Y0d0L2dORisyeCti?=
 =?utf-8?B?ZDdjSUdiWW1PSkZvdWxhaHZkdXY5d0FXQytaUkU2K2lHNEo3K1VrcUx0cmt1?=
 =?utf-8?B?YWhyeTNOWHZJNG5CZnZJNkRwcTlLd3czckNCK0J5UG9xYmZ4T0xhTFhENktw?=
 =?utf-8?B?REt1SW9RaldWZlU0Q25sN2YwNS9aNFlyTnN6SFlUUzNWZkx6OUdjK0paQm9W?=
 =?utf-8?B?N3RqeXpsdDlNaFdBUFZzZlBaQnlaa2JtVkprNWN1N3d6bHZ3ck5PZ3FxTW8y?=
 =?utf-8?B?Z3NTMDA4dG9rYS9WWUxBbkFtMXY2bjF5MytteWFKSXlWNVFZSE1DN0pyaCtr?=
 =?utf-8?B?c1VDVWI0MVRPSHNsVDZyWURRZ01aQlhjWE1teHJ3ZXlpTTJ5TDNLdHVUT0Rj?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea0e9c0-1bee-46a1-6cc9-08dd19bbf49d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 08:15:21.1148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqTpvn8VFbD2PX+SbNew56fMWJy8veQw6HYbXCipqtcyDkNYWhAsesfYCrJF7N3MCl632ezIODsP7EYxGndIyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6179
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Dec 2024 08:15:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17397

On 10.12.24 17:42, Felix Moessbauer wrote:
> These dirs are anyways not used in a ro-rootfs. boot is over-mounted by
> systemd via sd boot protocol, implemented by EBG. var is deployed empty.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  classes/squashfs.bbclass | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
> index b39be0c..cebda70 100644
> --- a/classes/squashfs.bbclass
> +++ b/classes/squashfs.bbclass
> @@ -22,7 +22,7 @@ def get_free_mem():
>  
>  IMAGER_INSTALL:squashfs += "squashfs-tools"
>  
> -SQUASHFS_EXCLUDE_DIRS ?= ""
> +SQUASHFS_EXCLUDE_DIRS ?= "boot var"
>  SQUASHFS_CONTENT ?= "${PP_ROOTFS}"
>  SQUASHFS_CREATION_ARGS ?= ""
>  

I will consider this post-release. For that, please adjust erofs as well.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

