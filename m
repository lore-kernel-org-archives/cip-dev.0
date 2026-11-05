Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.20])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28786.1793861146328803076
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Nov 2026 22:45:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=u1Ch4YRg;
 spf=pass (domain: siemens.com, ip: 52.101.83.20, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjGPDR5pHRUHM7z3MVfjo2msJeah0ix16qhmFPRmZ7aR4LtMwb+w8HhUsSty1QC6CxIPDug38I9Mp99W/ifRP8gQQKrfMMJfGpyGIqi43tegyb9huQwBOBQ2MrNKsLTGbnleLoPaYqqdFe0V/+Vd/Qk1hmGksWN9BBut3g/1f+oymd1YjkLoxdtd4s2/iJsgY9Q+xF2/kD1Lxhnm8fU//Ur+cMgawOlKSFTp9mu+9qyhime+BHIjFlUO3Gph12Cwv2coQzAhmO/8TFnpiqA77hThxIbczs85x3MEGb3P41Xlv6RCUQ1q3Fcz6PkjmIU/+2yJAQpVK+1QbDXt3n+thA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXnG2KbywzgI12SIB7TCpl5wF7cdTRF1KgR3KeQw6Iw=;
 b=OStbc9ruo+40Zb/kapyPhbK0c7auqV7T+XnV8k91wNLk/HSCgOtTGx1l1lklkVVPs+6LVvMBx7GRnJsRAq5XJBTXSifBJj0Mu8IiXxFXoUDb4mtNm1JEjWLD1Yst6Uwqlrh0DDS2QPNvGhxNEWqA2g4Mk8JXLbczGML9zaruhJwT8Za850TilcWpKrsd50FDSPTu0CP0fv5ItR/FMR9e8d3unz4PHCekCt9Gkg5qgHf9Cj2vyLC4NG25VVAlKYrPnmLKievoJiYpfCVb2OvZVjP2j5t88tIIk5oMavEmE/QesTb+6WnXs3kz/CHqEofXFYjo/GrVGHUme+0nOqkO8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXnG2KbywzgI12SIB7TCpl5wF7cdTRF1KgR3KeQw6Iw=;
 b=u1Ch4YRgoxRHa3daVClORJhjVBB34dc6JWAnxBKTdt7fYKjJhRCQs3ZmBIF/MBTkYNjmVP2YiUAIIgPk4I1YUgkfMolKOUEvVJuIyuWv8nw6iDhLpPsZG84MmzTX9+vznila3cyUAI3/GyrxxCANWM18akanI0QDAnh/IFbsUeF+jipcqQpFZ/56M+/rVaklTAcmsz+oSzRpKk4soS3MyxbpoMQ9f2sSNb+b0vd22Wefw9jPR0mY30Rjy1B8S7+xDeEBrVWpzGNn2wHSGlsLirQDMSCRL8kDUnOiH4pOIiP5hID5tkqWzfvGACwi0zFf6er1tomFyfyD/aFfCkgzpw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by VI0PR10MB9100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:214::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Thu, 5 Nov 2026
 06:45:40 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.003; Thu, 5 Nov 2026
 06:45:39 +0000
Message-ID: <39b84e6e-ad85-4714-bd88-787333d7a41a@siemens.com>
Date: Thu, 5 Nov 2026 07:45:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 01/12] swupdate: add
 RO_ROOTFS_VERITY to select a dm-verity rootfs
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
 <20261019102541.672620-2-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261019102541.672620-2-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::14) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|VI0PR10MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b01f922-a76a-47b9-9d32-08df3b0867c8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|4143699003|56012099006|261022105027099003|261022075727099003|261009223027099003|261021123027099003|261028144727099003|261026140227099003|261026121527099003|261022115727099003|261102123227099003|261021121427099003|18002099003|55112099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: ebGoahS+QHIdZK4hcO2CaFpAg0Y5nm8ubWWS+u080eVBa43tptRPe2jUiWIjwdOKT7kFXIbm8yOuRi68NO7eKhwNRd9gOIjlAxZJgsE3YglMPJP38NOkFC6Vt8vLpsvvO2x/DuN6ef66JHaJKLz8BS2Bel/A1c7YGTYUYjN2a9+WpKwtGv6cckofVSoOE/hh+0WgsvGErudPH97QTXuW96XXU1jxIPk9pkHfc8TkyQ8YLF7gLlUuMat6i+sMCOm2JQyhzfWqE9o8GO1/ohsUBcNRBDxcmL/tQT5XVE88DpqFx1+Kkb1rJ+YU8TfH/FX6InQ2IDf3cnMnxkbYIZdaSCLSz3w84o5Yz3rntx8PpIDRYkcdhSNNInwviWl1JvKW8X0vjbjNiBi+qb16oO3LG9/tiF6SfLUzo7DWQJwRJt2xHfBSqc+oytvxOVsyg8GlB9yDwialJLhoF+JGHmtGIe/DD3JPJvB9f7DBB7JXPryhH/QOj/w2/XfBS9o7gX6P6J1oq7Gajupte/Ib+7tOOdqqmgOTGTaSuz4qz4CJOtvRMYXbv0A6Y0PgPyJrdiKkUfCVFdI1OsKLVLgB2AKPk4mnBWaNISkgOwW2ubxPAujWekuRgYWca00nc9irTF8dRMs2mQXDHD2Y3rWSRFltCo28EQJePsXorqSapnWHplE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261009223027099003)(261021123027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022115727099003)(261102123227099003)(261021121427099003)(18002099003)(55112099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnI4Ykl1L21JRlh0dzhZZ2FxeVNuYndQaFU3aEh4eUljOENFem5iVXU1cjMr?=
 =?utf-8?B?RUtqaXg1WGpGNFluZWtQbUNmNUZSKzB0dWlxTmc4MFBmV1dDcVVCTnVoRmF2?=
 =?utf-8?B?YlYxbC80Tkp6NS9ud2N3TUozYU5yT2VFOG9tRGoydU9idGlkZ1pxdjRqbTlQ?=
 =?utf-8?B?TkpxYmxuYzFOZkp1NlpwUVlDUU9XUEpPSmg0NTBCS2VEU016MTdHM1ZvUzhG?=
 =?utf-8?B?cjd0V1RRTEdiUDBYajl3V1FGelhKeU56eXg1Q2FnVFpIZTV4R25SYmRGMWUy?=
 =?utf-8?B?QWhOTlpHNVZwdy9TbjFLTXRxWmIwL2VyaGdnd3ZLWUFHZWx1NGVrVlBMOXF4?=
 =?utf-8?B?UHRZMUh5dlhTWUQ3VWhkR1F0WTBkT3NWbmk3UGRkejhZUHpFTVF4dEwyMXFI?=
 =?utf-8?B?NW90MC80MXF2K0daWlpONmo3VDF2WGxaOXdrelZmNFRLRVhXQndtbllVQ2xa?=
 =?utf-8?B?UHVsSVFPSWwzb2Z2dTk1bXFYMEk5aG55SlE0VTFUcHhXcnUwNUlMYTAyaVBB?=
 =?utf-8?B?TWo3d2MvWjgvaHZDTStyVU9pSG04ajROczJtZ1A3Zy8zR2N1ZElQZVhsNlV6?=
 =?utf-8?B?YzRzM29ubDhxQkNlS3VOV3k5N3FVM05ySVN2VVJraG9nT0wrN3NnS203OXNx?=
 =?utf-8?B?M2ZFWHdwNUlTTzhRMnY5c2N5YWxidWxSb0dkQ1NlT01KVFlud21TamovTmV4?=
 =?utf-8?B?UExBN3hOVHNPNmRTVGdicFVTZWE1NFcxalRaOURLM2IzZGhYLy9JTFdBa3BM?=
 =?utf-8?B?NWFNYWlPWlA4L0pja3dDMWEwbThkMFk4RlBPNjlJTElKaVFOOEdlSEt4K2hk?=
 =?utf-8?B?Mmw0OTZKWUdMSVlqZjdaS3BxckI0d2h1TmQ2Y01GbjRENGk1SjFpeW1DdGh5?=
 =?utf-8?B?SkFleFkzN0tMWkg2Y2dKZGhxajcyZ0tGUXd1ZjcvRlZUVlBiUHNZYm80SnNq?=
 =?utf-8?B?dnJRTzFwcU5GZGMyRWh2c09zS1lTbFhUTXZzSWtVUkdtTUNBRHZHNmc3SHlZ?=
 =?utf-8?B?YjNaNDVuUDNGbTNOWjdsbEV1S3BaTm5SemxHOW5ZREdsanRMVHBDNXFKMWNX?=
 =?utf-8?B?clNGOEdvUVRTRERlN2NwY2JpbkRxTDFJNm5JY1AwKzRsVzY1dG9HTWJqNmlo?=
 =?utf-8?B?bkozRkdDMHRGdkhoRUFJQmt3RzNBU0ZuSzRVVlJibkdjQmJZYVVmWkFadjlq?=
 =?utf-8?B?OE9PcUp5MkI5c2JQWHpmc1hsWmk5NFgwTGZHcVZWYTJzd090WXdzWU02Y3Nz?=
 =?utf-8?B?WEc5R1l6RnpkUUV3eUQvRUJITU5DVTI3SXAxc0JTcjJ2RmhRNUV1NmlXRFpR?=
 =?utf-8?B?NzZ2N1MwVkpsZUZja1lkazhVc09mRFFrc05pREsxZUNiUFVuTm9DbUxOZ3M0?=
 =?utf-8?B?eUs5cUhkQlQ3QVVyS1R1cXd4cDdOcUpKS1pyb01vY2x4ajdWU2NKQmVGU3oy?=
 =?utf-8?B?UU9KWlJHbFRMUkN6RUVZRFI4REw0RlJFMjFRNEtiQmtXWldFTWVrdVZoY3F4?=
 =?utf-8?B?L0lOTzhpOXhUNTQ1bWZCYUtkYWxYWExIb0ZBNU9VK0VHRGxnczA5NnBhamhP?=
 =?utf-8?B?MCtWOE9FWCtnWmhFNHFEYU9hTmlqcE8zanlpeFN6WWxxai9GeGZIZE00M1Ni?=
 =?utf-8?B?aXZObVVvZjI3WXhQaWd0NXgzS2IzZHQrZjVFVnFhVmtaMW0wSFlBVWlobWNx?=
 =?utf-8?B?Y0ZoQlJMYzJQM0JudnFnWUg2Nm9qM05Cem9xTkpidDg5UE9udVNpRENuT3Ra?=
 =?utf-8?B?aG02cERlYk5ObHNkamJ1eXRGNExycHBrQUl1UVQ0QTVrbE5HRzFtVnF5ZFM2?=
 =?utf-8?B?WXNRSDJIeFZxV2FlZU1mWEZKejZGbG16aHZJM2txbUFjQWRWZG5rOFkvTmFQ?=
 =?utf-8?B?VXlXRVVoekhrbVM4L2NwRk5wTW5qK2VaYzhBWjNBYWZnZUp4ME1vRUxBdXVh?=
 =?utf-8?B?U29jcE1zSmUySGJFN0VUTXRzS3VLNGFJeTYvdmZkSHhFdE1Yc0RaM2hzMlhN?=
 =?utf-8?B?UVJLZ0ZacVZLL28vUHRhb2YzOEF1Y0hIZkVKdTBHbjl0NytBOTVqakFITFl5?=
 =?utf-8?B?N3RvL0kveDlBSVZNMXMxb04zZi9wNkVMck1tVkJsVys0bnF4bUxtRTlSdEx4?=
 =?utf-8?B?RDl4NDIvZU9lOUFwYVVoZG5rZUpzM3ZLSCs0VmcvMGxoSEVxVHdTNXZiUHRx?=
 =?utf-8?B?TitqZGlJaEVvOFpDS1QyNUxKaU9WTXZNTFJaZXpMS3oycFBTbkRGL0V3UmpQ?=
 =?utf-8?B?Uk5makhqQU9VQnViV3V3U3FTTW9TQS82aS85N3d0RW02dWRhODl0cThpVGNz?=
 =?utf-8?B?UkJkTzZ4aDU1ZWdMV1ZGR25sOGlKNjI5M051UmtFQ09VNkFXaU00dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b01f922-a76a-47b9-9d32-08df3b0867c8
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 06:45:39.7438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+ERlUhhk1OdEy6dY4ERkM6G1gGmNwI9hxyBv1dzDjEBKivB/t7RboeDSxemijtNwtjBgBPofZUqZjkZr2M7cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9100
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 05 Nov 2026 06:45:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24640

On 19.10.26 12:25, Quirin Gylstorff wrote:
> RO_ROOTFS_VERITY replaces setting IMAGE_TYPEDEP and SWU_ROOTFS_TYPE in
> the kas option files. If set, the wic image depends on the verity image
> and SWU_ROOTFS_TYPE defaults to verity.
> 

Looks like a step backward to introduce a binary control, rather than
having a more flexible type. And there is no reason for this change
provided as well.

Jan

> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes-recipe/read-only-rootfs.bbclass | 3 +++
>  classes-recipe/swupdate.bbclass         | 3 ++-
>  doc/README.secureboot.md                | 3 +--
>  kas/opt/ebg-secure-boot-snakeoil.yml    | 3 +--
>  recipes-core/images/swupdate.inc        | 1 +
>  5 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-only-rootfs.bbclass
> index 1690ecb2..70152de2 100644
> --- a/classes-recipe/read-only-rootfs.bbclass
> +++ b/classes-recipe/read-only-rootfs.bbclass
> @@ -9,6 +9,9 @@
>  # SPDX-License-Identifier: MIT
>  #
>  
> +# Protect the read-only rootfs with dm-verity.
> +RO_ROOTFS_VERITY ??= "0"
> +
>  INITRAMFS_RECIPE ?= "cip-core-initramfs"
>  IMAGE_INITRD = "${INITRAMFS_RECIPE}"
>  
> diff --git a/classes-recipe/swupdate.bbclass b/classes-recipe/swupdate.bbclass
> index b5b5273b..ba0ddd7d 100644
> --- a/classes-recipe/swupdate.bbclass
> +++ b/classes-recipe/swupdate.bbclass
> @@ -11,7 +11,8 @@
>  # SPDX-License-Identifier: MIT
>  
>  RO_ROOTFS_TYPE ??= "squashfs"
> -SWU_ROOTFS_TYPE ?= "${RO_ROOTFS_TYPE}"
> +RO_ROOTFS_VERITY ??= "0"
> +SWU_ROOTFS_TYPE ?= "${@'verity' if bb.utils.to_boolean(d.getVar('RO_ROOTFS_VERITY')) else d.getVar('RO_ROOTFS_TYPE')}"
>  SWU_ROOTFS_NAME ?= "${IMAGE_FULLNAME}"
>  SWU_KERNEL_NAME ?= "linux.efi"
>  # compression type as defined by swupdate (zlib or zstd). Set to empty string to disable compression
> diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
> index 2b14bfb2..2d107a07 100644
> --- a/doc/README.secureboot.md
> +++ b/doc/README.secureboot.md
> @@ -158,8 +158,7 @@ header:
>  local_conf_header:
>    secure-boot-image: |
>      IMAGE_FSTYPES = "wic"
> -    IMAGE_TYPEDEP:wic += "verity"
> -    SWU_ROOTFS_TYPE = "verity"
> +    RO_ROOTFS_VERITY = "1"
>      WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
>      INITRAMFS_INSTALL:append = " initramfs-verity-hook"
>      # abrootfs cannot be installed together with verity
> diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
> index 569d2a5f..e1665187 100644
> --- a/kas/opt/ebg-secure-boot-snakeoil.yml
> +++ b/kas/opt/ebg-secure-boot-snakeoil.yml
> @@ -17,8 +17,7 @@ header:
>  local_conf_header:
>    secure-boot-image: |
>      IMAGE_FSTYPES = "wic"
> -    IMAGE_TYPEDEP:wic += "verity"
> -    SWU_ROOTFS_TYPE = "verity"
> +    RO_ROOTFS_VERITY = "1"
>      WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
>  
>    secure-boot: |
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 006d6220..361dd5e0 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -22,6 +22,7 @@ python __anonymous() {
>  include recipes-core/images/swupdate-${SWUPDATE_BOOTLOADER}.inc
>  
>  IMAGE_TYPEDEP:wic += "${RO_ROOTFS_TYPE}"
> +IMAGE_TYPEDEP:wic += "${@'verity' if bb.utils.to_boolean(d.getVar('RO_ROOTFS_VERITY')) else ''}"
>  IMAGE_FSTYPES:append = " swu"
>  # input is already compressed
>  SWU_COMPRESSION_TYPE = ""


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
