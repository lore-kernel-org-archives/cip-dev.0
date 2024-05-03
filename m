Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D11C4345F
	for <webhook@archiver.kernel.org>; Fri,  3 May 2024 06:33:16 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.85])
 by mx.groups.io with SMTP id smtpd.web11.6613.1714717995510523004
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 May 2024 23:33:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TcFWLl2e;
 spf=pass (domain: siemens.com, ip: 40.107.7.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbLcH7S7Y25IxR8CTLvHBmVHuoJ+fwPehlw4CTrHlLVpAPkPiDCsmym52oBZ7jxD+xoodkiHbqdQWnVkjZDkNhMcip9AJR2LxOAnhXTWSZQ2rJ+EI9+hC3WtrN0NBdsbyNSlRDXksk6hAskX9Tq75CY1PrLPPBXTQmtiTJo4d3TrZhQcEOmlMrhl99ATLuiO1ffRvMRCe3oaYbE6kVA3abOKakN/lO/ZWDYQai9SVqz67Nm1Kftys9ZWEF8AwyBgwZgD7HBST0hK900gfKTuj9jGKBlldx47Z15aZYpE3ygMhlJaFBkJ+lMKSISoGHfTFh5JzfpLQOj0fYtJMbrKYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6g/HLaU/2h0I/QCQ/AVMI+igvgMV8hoJPBKj/RpZJY=;
 b=N8ClksZvQXDTvGEb/8bWINtqV0MszV1rkNbq4eVCyKs/nJ7wHbuNRa51MA3Pr1cU4pZumfaPhcEbl7jaDbs5gqd0ESElphWW15sOgHNh1/+SVdyqSyWe4I8W0ekA0HTV6o6ZbM2W1tYu1PNQsbg7tD+KtPkGOguasJEV83HqlMM/MRppooimG6KPWf/pFhaxbnJ8NxnRMFSGWE97CUKn+oxAa9rL4u8MQMT0jFYmChKCpeIe/518L8WmhPiUtkDVr9kH0tIB8oA4DoVpuILwoQq54hIu83tArbOuHqlK2BiSZxhClzpDLYbt+dIgv1pppWvZ51Lo2Ax/akCm9kgaGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6g/HLaU/2h0I/QCQ/AVMI+igvgMV8hoJPBKj/RpZJY=;
 b=TcFWLl2ex9S1GHAcgLmBlncij3FY5dmPX8AZg+/HqpnaoEqTeQYRpCFTEn2DIbqiOyJ0SQEIPR0WUK9IMYSCbuUyDy1q5Fpc0RkAiupQyk5HyG/XlNisGTJEnEz9YELWWcqvr8/tQBY/yYVjyvKlL3Xhgj1cmUaZB9/ug3mcbNW/uvEGLzbO0phMbyU2Twh7xyaV3cR4OCU2OWmlpapDOk0FYrnU97uaZH+lGIrIxQDXNXyLtqKu9JKv+h5mfFlpDbtO6EptMq86ggX/Xj2MXLpgPfA+ci8wunLuu4a6ZL6gqokDBghvEi1Rtz3affWYRgwbTUZSn51LTqV0yu8kTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8508.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 06:33:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 06:33:10 +0000
Message-ID: <aeb0495d-4428-469f-8bd6-bc6954f40c47@siemens.com>
Date: Fri, 3 May 2024 08:33:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 6/9] Kconfig: Add option to
 encrypt the rootfs
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, johnxw@amazon.com,
 felix.moessbauer@siemens.com
References: <20240502093240.364093-1-Quirin.Gylstorff@siemens.com>
 <20240502093240.364093-7-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240502093240.364093-7-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 51dc24a1-3ed4-4e46-9b7e-08dc6b3ae67c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dVdnT2dxenRFWmpsSTRxTEFsNnYwL2ZmN2NmSnkvVGgrZW9CTTN0eklnVFdt?=
 =?utf-8?B?UnJwMWlyZko3TDdNMkhyY0Jpc0F2Z1EvdG9ZREVJbjIyQ3MrQndEN3U4ZG92?=
 =?utf-8?B?R2hDTUJhdW1TTGNBRS9tNW84Y1F3TEZvMnkzaWVsRnJQRkI0S2pDeG1ZKy80?=
 =?utf-8?B?M2hmTy8rcjIrVGJJVGFKV3hyWlRCZ3VQSDdyU2RmQUZWSlVYNEpXaWl0Mm5z?=
 =?utf-8?B?aTRNbjU2aHhUUzAySkJ2WEcrNlJLQXQ3UmFVQlBiVWFGV0RRQ2lwcW1sbWY4?=
 =?utf-8?B?MFFScmtYblJFd014aTM5UjRWWExEbkk5SmlJcGNGR3dQYkhESU1XTGlvblla?=
 =?utf-8?B?cWFIdG9TL3Q1ME9WSkxpVWNLUHVDcHVHRFNRbWRxcWl1Q0g4dFo0Q0JVZFN5?=
 =?utf-8?B?MDBqL3Jick1WVGVQMGl1VGtIeEkwc3M5bnVFL1hKaStCLzl0aTlyMzVNNEFW?=
 =?utf-8?B?NGZZc3hMK1kyS3huQ0NoSnVhWkxWVXI5SkswWWw2U0h0M1NUSU1zOHVINC8x?=
 =?utf-8?B?Skh0VDYwalFvVGdlc0hHV2MyZzdaYVNORU9VVnJVZ0I3UXdCaWg4TXVHR0dS?=
 =?utf-8?B?RFVtbENFdG9USFZza3c2ak5sY3NHbE1hV1U5eldodW52aGw0dkhrTFlqdWN3?=
 =?utf-8?B?SlZIaGJ2d1Q4eVFsR3Q0ek9rejllZWloc0FEbUxyaWNsZEZ2SVB2cUc3SHFV?=
 =?utf-8?B?VjZMSHErcmFiT3dFT0RGSHJVenhsUnozQ29sVEFkT1lNam54TUdWeTU5dERo?=
 =?utf-8?B?djhIdTRlT1BXc21zRDJBdTBTZ2xaTW5FVG00NjZPNWtxT2d4SlUyRjQrQXdM?=
 =?utf-8?B?Y0EwcDRCT0F1b1NERDgvS095T0luaG5peWZGU0FWWkV4L05tb0hmeEoySGtH?=
 =?utf-8?B?cDFjYnB2N0o4K3N6WnY2bGZ6Ykt4QzJQNVR2ZG5STkdzaTFmWVhSRG8vdXpq?=
 =?utf-8?B?VWUvd0JiblpGZ3pmRGNrUmxnbjFjU2VGczE1T2lNblhPUllEekFkd3drelVo?=
 =?utf-8?B?d1IrN1B3TzBYSE5kK2RLOW11RUFkMk1vbk9Tb1JFSGlNSmRNcWZweEMwL0tJ?=
 =?utf-8?B?ZUVOU0JaRlVERGdDSzlBZFlLY24xejZqQXdYcHNkTk9YWk9XMnRLRDEzZG1K?=
 =?utf-8?B?aG04SDdQOUtSd0gzUmhoY1ptb05oTlpRWE1nLzVFMGE3bVpGd0I0YkNYcnp1?=
 =?utf-8?B?NlUvY1hTeU5XckNYQzNRWXRXdnVraVphS01rQkFBNS9XeGh2TTdvWmRYbVgz?=
 =?utf-8?B?aTFnVEtYRERlZENtakt6RzJYc2ZMK3JKYytoWWVxOXRpVmIvS3VBQ1ZpcXRO?=
 =?utf-8?B?dVl2eEN0Z0hQSlZlNzBDcGFOTTdybmI2Rm96Q2F6WTV1aEVQaUxPUktZaXp5?=
 =?utf-8?B?QTRmVllxMHU4NEJMNk9nTnArUDM0ZVl5bTVEWWlIaFliU2pXd0R0NnY4QTRs?=
 =?utf-8?B?Qm1kb0J4UjNHMURWNmg5VENTTXA2eXFkTGVYQ25RUWErU0d0U1FiR3cwcmFJ?=
 =?utf-8?B?RlZFa0QzSmE5Y0dGTVdjdHRwc09rWmFlR1p6MTRtZUlObVI2dUlDL0tkTjdj?=
 =?utf-8?B?a0hjZlBBZFZmTHNpUXA0MWp1V3BZR3BTTlBveVRVdVJNNkhUVFQ1eGt2Uy9o?=
 =?utf-8?B?SktFYnN5QXRFWkNrb3RNNjY5N1VVWHZNdjFyeGpESk5hRkVJQ2FyKzNQMTZN?=
 =?utf-8?B?TVJ6cUxTTW1TVUdCaWl2RjhLelFGdFovVUxxRnFkUlF2ekVwMXlWSmtRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZGRZTnhlNWJ0YkE2dlZoMGpsVDBERVNtcTRKWGMwYUxrbGxFQlY0MEVYQUpj?=
 =?utf-8?B?Y0J4Q0Vla1BHRmFOMEJHWlRZUVF6dTZ5UTlqd0lpY3JXU3FxbnBSMjdhUHFK?=
 =?utf-8?B?ZlNzaWVqcm1wc1ZxSGZ1QWRQZnNlVFgzaXRvU3NqVWhjMHBCaEVXWTlhS2t5?=
 =?utf-8?B?Z1VpbFZ2LzQ3Vm1aZW9pVjBMVk5FMlE0YWpwcTVyUi9iSlpDc1RxZk5ONmJm?=
 =?utf-8?B?ZS9weGZacXJxYUNLekVmdHpGekdWcmFtb1NHOTVCNEVaaEtHbjhwdDNTOHlu?=
 =?utf-8?B?bmpqQ2VxVFkvUkI3RXFwMVBwVWNZZkJzL1h6WXBERUhkRTlFWUMrc3NkQ0kz?=
 =?utf-8?B?cEJVZkdRckVLMVNzVHg4ZjYyUzRHSzFWY0gxSm9YNjVQd203NjJteUE5VFB2?=
 =?utf-8?B?UTRTMzNXVGlWaTRGNUtxc1AxUUdjL3Z5Sjg3S2NxNytsZTltVUwydzByVDFZ?=
 =?utf-8?B?M3pKWDVJRHNkVHBKeFlLZnBOOXcwdHI2VmVRYWx0Z2V6TW5EVzZIKzRzS0FK?=
 =?utf-8?B?N2lOZ3piMFRjS0UydUhVbCsreFV1WHdEZkNBb01iYUEzRFdyOG9PclVib2ZR?=
 =?utf-8?B?NHBwcjg2T1IzZHpkbVlTejc1czlITERpUDFKUGNPdnJ2dFQxWjNybmM2SDZT?=
 =?utf-8?B?ak5EQVVaZGhlRE80S3NROWZzcjRQU3hnd29ncTFPYVk3UTZOYUlhMVJPNlBk?=
 =?utf-8?B?NGs5K295dTdhRENSa2V3bTFmUFRUZmxnekVpWHFaU0IxWEdMWjNoR3MyV1Qr?=
 =?utf-8?B?c2xrTnlrWXhMd01TVG1vazFocGlob2w2UU1VNTNzdFRjRTNseC9iYmtXeExx?=
 =?utf-8?B?enB0RVYvbDNxY3FCUndBaXhUSjdrRWp2SHNPLy9NdXZxdzBiVjR3SUNNQjl4?=
 =?utf-8?B?cDRtcXYwUUxrR3pVVVBtQUhaempRSGZlM0w4OWRDTWwwSFNRbWRmY3p6c05k?=
 =?utf-8?B?djVYSE5SamNqM2tSbjVPcmcrNS9tY2NXdlVYWUx5K2s0czFLTmZFNXpZN09s?=
 =?utf-8?B?aitHTGtaYitFUDV4TnJQWUFDNk9BNjNsOXBrSTY3UHNVZm85WmJmYit6dHgr?=
 =?utf-8?B?Y2pFaTAwSmRjYmt6SFJpZ3BOV0M1RERBZEVuOUl2YjZZK0NWQU05NktyUktU?=
 =?utf-8?B?dWJVcG1Qd3BmZ2xONXRWOS8vOUYwUUJvTjU4aytnc1B4SDE5dytJTHZ0QVFq?=
 =?utf-8?B?VlJhaml4UFpIdWE1QVpIaVhUNkVoME94YlBHZDRrRXUrV2QwdGtickFRZFV0?=
 =?utf-8?B?Nkpxa29oZzVwd01DekQwSEpvU3d5Y3pWTnFDb216WW9CU01wdjZtOVRvbUsz?=
 =?utf-8?B?QXdyU1Vpdk90Z1JyeC9hT3pWWktuS2FEdTBDLzNWY3Q0bGdFOUNseFVPNE9Y?=
 =?utf-8?B?eStkdTgvYmhIdUp0cnp2c2ljWmdIaTJlSCtFa2VwekhJQksyTnp5bVVqUWhq?=
 =?utf-8?B?Z2ErMjNoSkg5M3NxbzZER0JFOXhWRkFlczhkNVlMM3lUSjhWd3BybWl3U0da?=
 =?utf-8?B?S0F5UEltRk9DMTJwdktqL2FOc1hiRWQ1ZUlXOUo1ZEF3eS94QXVKc1hRUnBt?=
 =?utf-8?B?OFFwbTY4WmV2SWxtNmxGbTdITFAxa2RnRFlRd1lDTGtaQzBCM0lxNU5VYVFu?=
 =?utf-8?B?cUZCTjF0Qmhmd29iZDdqV1RHRnB0VFg0ZVdEd3p2QkJXNTNRc3gyUkUvd3hR?=
 =?utf-8?B?MVNjcWhlcVk5OW0relhNUVdrWWF1TjRoRWpjWkFGZE9yL3MzOUFxNGVZcDVS?=
 =?utf-8?B?a3pST2hKc29HMHZ0SitidDZTMUJ6Sm4rSkl6a2NxV1lWSytoVnVuM3RyUHlE?=
 =?utf-8?B?N0pucmhKcnFuM29keXlIRHpEanhSNnlGOFJWc1FtaHZOTWJNMlhDUFVHOFR6?=
 =?utf-8?B?STdFalVJSlg3VElUZ1NFT0Q3eVhVZ0ErOU81aTh5VW1TWS84aFNOcW5tR29u?=
 =?utf-8?B?alMwSWdIbjFGSW94Z0lOMXNOQUhUZVlhcGFrMTQzMTBiOGJ2OVhhQU53dmIw?=
 =?utf-8?B?QmI1TDhkNlJIT3N5TitrckIyQk5uZFFmVmkrZ2RoNmJ0OE9UZFMyam8xQ1li?=
 =?utf-8?B?WkVyWHY2MGNzcklkOGdjVFhFUWtkMmdWS0RUT0FvNk9ZcVUreEJMcnlyTjBv?=
 =?utf-8?B?am5LZWZodEg1WjIvaDM5ZjFrTkRET3FSMTMrRTl6ZitYOFlKeHNKZ3pjN1dL?=
 =?utf-8?B?SkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51dc24a1-3ed4-4e46-9b7e-08dc6b3ae67c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 06:33:10.0387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpfgGvbg3pnuj3qIhjbJ/bxhHaowz2GjQ64vOEvGZLWWpjEEgWLYbgrFnLdLK4nhvkqzC5E+IHqCNrA1uPI4hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8508
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 May 2024 06:33:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15811

On 02.05.24 11:31, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows to setup a system with all non-boot partitions encrypted.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  Kconfig                 | 22 ++++++++++++++++++++--
>  kas/opt/encrypt-all.yml | 23 +++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 2 deletions(-)
>  create mode 100644 kas/opt/encrypt-all.yml
> 
> diff --git a/Kconfig b/Kconfig
> index 9478a06..d0a9bea 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -202,15 +202,33 @@ config KAS_INCLUDE_SWUPDATE_SECBOOT
>  	default "kas/opt/ebg-swu.yml" if IMAGE_SWUPDATE && !IMAGE_SECURE_BOOT
>  	default "kas/opt/ebg-secure-boot-snakeoil.yml" if IMAGE_SECURE_BOOT
>  
> +
> +menuconfig DISK_ENCRYPTION
> +	bool
> +	prompt "disk encryption"
> +	select IMAGE_SECURE_BOOT
> +

A menu is overkill here, specifically as...

>  config IMAGE_DATA_ENCRYPTION
>  	bool "Encrypt data partitions on first boot"
> -	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM
> -	select IMAGE_SECURE_BOOT
> +	depends on DISK_ENCRYPTION && (TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM)
>  	help
>  	  This enables LUKS encryption for the partitions /var and /home.
>  
> +config IMAGE_FULL_ENCRYPTION
> +	bool "Encrypt rootfs and data partitions"
> +	depends on DISK_ENCRYPTION && (TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM)
> +	select IMAGE_DATA_ENCRYPTION
> +	help
> +	  This enables LUKS encryption for all non-boot partitions on first boot.
> +	  If the partitions contain secrets the first boot must occur in a secure
> +	  location.
> +

...you can't select IMAGE_FULL_ENCRYPTION without IMAGE_DATA_ENCRYPTION 
(for good reasons). It's also strange when one only selects the menu but 
not any items of it. Therefore:

config IMAGE_DATA_ENCRYPTION
	bool "Encrypt data partitions"
	select IMAGE_SECURE_BOOT
	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM
	help
	  This enables LUKS encryption for the partitions /var and /home.
	  Encryption is done with a device-specific key on first boot.

config IMAGE_FULL_ENCRYPTION
	bool "Encrypt rootfs and data partitions"
	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM
	select IMAGE_DATA_ENCRYPTION
	help
	  This enables LUKS encryption for all non-boot partitions on first boot.
	  If the partitions contain secrets the first boot must occur in a secure
	  location.

Jan

>  config KAS_INCLUDE_DATA_ENCRYPTION
>  	string
>  	default "kas/opt/encrypt-data.yml" if IMAGE_DATA_ENCRYPTION
>  
> +config KAS_INCLUDE_FULL_ENCRYPTION
> +	string
> +	default "kas/opt/encrypt-all.yml" if IMAGE_FULL_ENCRYPTION
> +
>  endif
> diff --git a/kas/opt/encrypt-all.yml b/kas/opt/encrypt-all.yml
> new file mode 100644
> index 0000000..b6d4041
> --- /dev/null
> +++ b/kas/opt/encrypt-all.yml
> @@ -0,0 +1,23 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +  includes:
> +    - kas/opt/encrypt-data.yml
> +local_conf_header:
> +  encrypted_root: |
> +    # Do not set mount points for systema and systemb as they are mounted by the
> +    # abrootfs/verity initramfs
> +    # As we use a weak default assignment in the intramfs-crypt-hook recipe we need
> +    # to set all partitions
> +    CRYPT_PARTITIONS = "${ABROOTFS_PART_UUID_A}::reencrypt ${ABROOTFS_PART_UUID_B}::reencrypt \
> +                         home:/home:reencrypt var:/var:reencrypt"

-- 
Siemens AG, Technology
Linux Expert Center


