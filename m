Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.38349.1793895270007404827
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Nov 2026 08:14:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gTKOQnnv;
 spf=pass (domain: siemens.com, ip: 40.107.130.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehli8MlJxdFZVAfQFygKcTswFH/36TTBXH11AIht1CdAvzQ8iI1C9UH19s0ysMC/R1Io3Uz+Bu7zY+H5OZEpZBIPDWYXi4cBNMGqkM9tGgSCr5mKGsc9pXyW3cWVKSnKUlMMdiVGD3aQNcpTkGjInr7dmhHKW/etf6Lc/+E/DBpTscXdafLWMJs0jwp0kVpcrWyaMra/StKqafxAdv0hUtlAgcsgmTUnGHl6qiBN6Pf2l2FRV1YTw3tokLSIJTZnS65jEaHQj5bB4abK2Dc/HgvI/DmrvWa4jqVZUkxKaJovO0hhfOpiTDI1CwoWNr81i5zrOZrtq5O8Oo44Cxh5Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0odEYh91veVm43LsAkSpR8g7ByTqi0medQRLw+Z0g4=;
 b=LJdfND4w3XVTb43wqmq++DHxMyyG3rZExXK4kbMLSMZKlvWBt9tEPv6AeGl56BnmG8J7ymKdaML5uAA/2NkzzX+8hi4JmoJo29CcVWU4asyKaO95GQqs6A2FhH+PXMv/LByQXZX0X6E7PlHZO1IOY/U4KoXbu9y+nzN/ELUEYF/eTDFhv2MXxuvlNNePMueOy3MqHBFav7JVK4OlG2TRK/c8jcXw1XzYd/eykD/5gKeasfMdaH66DCvubTiNWc8cRYlPMoJjO6Zvhox0lErBewY5ZIbH+abmk5Y97skbVHVudhsRY6nlN2kNQbz+3VYK494nHr2hb1t9xP7h3qA0xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0odEYh91veVm43LsAkSpR8g7ByTqi0medQRLw+Z0g4=;
 b=gTKOQnnvLrnJ7CqewudHV9tzlSfuMdmxpXGhTUK+adF2108nK3kjLPWuvr30WBCQgp+UitfHWdzCLTOfkmBOs/npgs6VK1Fy3uaIetkZ8PUlFoCWfN2qKsKLsB013PO6lWSWQqLxgRLIGopHZbuGoXpTmMAindN5aMkHo7rFdFnuH5kSLvNLpRYnPUfC3yTfDcU+99xvIPJuFGIG06Tm6JKL1r/tkVBllLiwGimpyMWRc3vK32irAQi8c7jtGG6mOiPFM1QFBHjzQlE2D7UTI1BTwTcDgJPVaLrbKCRePh3tQuOvNqMrGjkEcfhmn4CHy2t8wiKiDx4GwlcKDFX4bQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PRAPR10MB5321.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:296::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Thu, 5 Nov 2026
 16:14:25 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.003; Thu, 5 Nov 2026
 16:14:25 +0000
Message-ID: <3013916d-0b1c-4976-87fd-1bd2c8414ce6@siemens.com>
Date: Thu, 5 Nov 2026 17:14:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] u-boot: Change the mirror URL to
 u-boot-project.org
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Cc: cip-dev@lists.cip-project.org
References: <1793860204-10428-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <427d1f20-29a1-4772-81f0-35eadb4d7f81@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <427d1f20-29a1-4772-81f0-35eadb4d7f81@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::15) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PRAPR10MB5321:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e1909c-8d1d-4b6d-5a09-08df3b57dc42
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|6133799003|29003799003|10067099003|12006099003|55112099003|25016099003|3023799007|56012099006|261026140227099003|4143699003|11063799006|261028144727099003|261022075727099003|261021123027099003|261022105027099003|261021121427099003|261102123227099003|261022115727099003|261009223027099003|260925021911599003|260925022911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info: haIsNdwyWB+nVKIWiLzhbtzQfrZsI/qZkiJN1bB25ZpsyC3p61tKzaoCsl5CeKPtcbhTZToAYNTeXaDjF+f4yI/aTrviUE6W1DicbGB9MDdCaMXHNlru9Sn/pKhH5tLO2+D5AZmgcNyxK1MMU/18KW2qAx193Dry32Y5EeEyI5pLMb9zWuE8g9LsZxq8kF2K4HvgEVeYsMW3l682QL/qScFVysOuxCg8ZyjlvIUbPY8RR2LLifzgdyIkn8vU2wt25dtRebnMN6fDG0MIIU55HGUpyjG3mGpJTG1DbsbmqjKEs1rchGbq42P0ANHNt28fIqqhYWk//G/vxjIDHZa9YwsGBbitAFz7SZgnwbAcudpKtSs70gm6Wf7XtcXlHYg7PTbQoHlWnAhyLyiUOtgLooetFCIq7JGy3BFUcMtgVsUyvaNwNR/7uVU1i9dDDzyYVyVf94KpmEaNBoOSAvLj2ekI+uZnmP45b7Sg6nRS5pIK0l8Gxhxwq2VUjuuESQn2PV6K09h6iLIYD+tJu91iGyuy6RuimAipydKuoiHa7vxWs34WIBQ7gToPCUTUDPS8fqYnleG2YiEhHVmJx5hzfIyFCpZIPZe4MGxfUG21R+VU9zs6SBRgZU6PfMu1kbEf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(6133799003)(29003799003)(10067099003)(12006099003)(55112099003)(25016099003)(3023799007)(56012099006)(261026140227099003)(4143699003)(11063799006)(261028144727099003)(261022075727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261102123227099003)(261022115727099003)(261009223027099003)(260925021911599003)(260925022911599003)(260925021311599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUo0Y2N1MXJTUVJIUy9uTkVnSEtvUFRDdkpubC9SRTM4NFpueEk3UHhBWDlV?=
 =?utf-8?B?NW1wOVJuSXlvMWt4V05MdWpyR2pCOGE3TGx2RkZKcWJ1Y2ltcnZQbHV2eEtI?=
 =?utf-8?B?WlBMZG1jSngvL1hEZllSYTlFK0RpdGRzcnVlRGJNWFF3VklrMVI5Nkk2Zkly?=
 =?utf-8?B?Vk40ckV3K3RFek1yQm0wdzRVemF5Z0RBWmFOcVAyb284Tm8wdDhkc0dJaVQ3?=
 =?utf-8?B?akE1ZWYxdUNMVlY1RWdWUmE1NTI2bC9XYUNiNUJLVkZQdnlRSk1XOG1vaWdY?=
 =?utf-8?B?SUhwV0xvNFE2bFcvODVycW5iVk9RVEtXMnh6c1RyNVZGMUZvQXQvNnE4dkE5?=
 =?utf-8?B?WUt1YXJWQ3VJekpTcjIwUGZTaVFNQjZvWkJ0Vk0zMlp4QWlwWXdpRzZuaEJ3?=
 =?utf-8?B?WXg0OVk1Qlhod2g5VTR2SFExckxwNldTd1dTdk5MSkhjdVQ5bWJXTE5ucmo2?=
 =?utf-8?B?NktWT2t1NXJKQ3dPc3RBQ2FRRCtoamwvNE42TGFFSytVSmFWTkxDNXpsUzky?=
 =?utf-8?B?US9uUnZWWFMySk5Tb0hmM3BwaEE3OHVzMUFIcENvaUpaeUJFUU5wcXpneW55?=
 =?utf-8?B?MTlaY1lZU2Y2YzFpdERGRE42clNSUzdEU09mTlIyNU5VQWZjSGdhbkpVV3BL?=
 =?utf-8?B?OFdabXVPMGJ6clI2Yi9sMy8vRHNvcTRLTkVaQ2R0UlowWDhwVjhsQjE2OGx0?=
 =?utf-8?B?M0dWa1JiZWJkNmhQenhRVlBEelBLSS8yMHdTSkliUHdtOVNxTE15WlhXd21p?=
 =?utf-8?B?TGdEbjVFOVV5bys1eTQrNktQRjBSVUJUNGF1Y1pHQklnNUtVMTU5MFNPRGR4?=
 =?utf-8?B?VFpyanRhUnhSK0t3dTduaWVDb05QZXJXMENtSkM1UUh4bUVFVTUxYk9jS2Fy?=
 =?utf-8?B?aHRKN1VCZW9Ya252OGJGSFhmVXZyY3BiY0c5VXhVT3ppQ2RnZkQ1anZTYkxh?=
 =?utf-8?B?eG9SUkRRTlNJYXV3emdJODhydFhGQ1lEQ1E3WGp0Z2NJUGlINXZFRDJKaDhV?=
 =?utf-8?B?K3pzNXNvc0ZwRGp4M0dkclJ4MWFneXRGT0pvb3ArbVZiZVdoZGNFZmUvRTJN?=
 =?utf-8?B?d25wU1loUDg1K0dMT1hjMkdTM3Bqc0pJemRqaTU2OVVMM2RzU0VUbUhYTFoz?=
 =?utf-8?B?QitjNklkczFMZ0l5aG9rTWZtUy9weWVpcklldVRzVHhiMVRMNkJSYyszcldY?=
 =?utf-8?B?SDltUFFGZUZkQ3k5Z1RzejEyUi9pMG9McnQ1cEtBeFRmSDBGSFN2b1RzeHBt?=
 =?utf-8?B?ckcyMklnREJCS0tNVmdaVjNWcnh0Q1FreDFxOERkcHVQdzBNN1pTMjJyTmdZ?=
 =?utf-8?B?WHd4QkpacmQyb25OL0RCeVU4V3BZZFp2MXV4MG54NGhnM2NVMFZvbjRnbFJB?=
 =?utf-8?B?TVh4Rnk5clR2MHE4YTFzQUswdFQwZ0U3K2tsWXZSTEs0WlRGaTRSMEtlZ0VH?=
 =?utf-8?B?U1BBamhZK3NIR2huYWE2amNLQ1dUS2twNG1yOWkrTjRYNkZsRXpuM0FlM0dl?=
 =?utf-8?B?Qk5WeE5oQVdDZ25mU1hUU3M5b2FLL3k4SUJqY2o3dlVKOTRBbVFqa0NVMXNE?=
 =?utf-8?B?N2w1ZlBRSFlPQktPanA2UnlpSEs0L3RMRTRBNndiMEljUkxFTXAyOVF4SnlO?=
 =?utf-8?B?UXdEd0NtSnBzUHNqMmpYRFRaWk1wS2dIUHRreWtvV3N3dU9IQ2tDUmxQQnRC?=
 =?utf-8?B?UEF2Q0JHY3hLNWpLbmJnaUowSlNTMzcvSVFEYytlRG5sL2wyOHJzNkxZV255?=
 =?utf-8?B?YXMwaDRxNm1RMDdJbGFFc1BMRnkxTDA2M0VhL2Zybjd2S3F4QnpQaU9lOFda?=
 =?utf-8?B?TU9NZWgvSml0OVFIbjBFVWIwOThjSWJaMHg1UG1UYUppQnhXWWJ1NXVVTnY1?=
 =?utf-8?B?dTZzZkJHVU9nVllvSkM4ejNvaW5GQUNxczBneEVEM1ExbmlBUDVWc2ZLRCtm?=
 =?utf-8?B?MlJkZlBVbFpDREs1NS9tRVY3VVE3bW41N2s3dmphQ2hwR1l6ZU9NSFltNk0r?=
 =?utf-8?B?VHJUaktJaXNpK2NDN0lvanErRmV6WDdyVkJrYU4rNzRJVVpLb2hUakkwQjFS?=
 =?utf-8?B?b1laQ1ZKazdDQzNCZVBteVFLRzhCUi9iVEF0ZngvUUorazZ5QXdtNXZoQ2tn?=
 =?utf-8?B?eTRDTjdZc0ZES0F2WUU1VXBZbi8vZzFSNC9sOURhaWVleGtkM0hqQWtrV3dH?=
 =?utf-8?B?ZmZ2ZEovK3BLVHhPR2RZQ0RKZ0J1dUZlU1lWNjVCRTk3Nk5zekY2aDUvNCtm?=
 =?utf-8?B?aXRHQVpsdlU0U05sTTBrTDBQSUl3S2lRN1I3ejJKQm95MndjT2xjbjFuaG1x?=
 =?utf-8?B?YmV5TEo3bnhjWmhxUGJEVzV5elBKdG1na3JDZTBnOEhVbGJFRnNvQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e1909c-8d1d-4b6d-5a09-08df3b57dc42
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:14:25.4213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjQyj5uNnM0iRDVhWudJSnLWAFvqOVVMrFEoEXo8O+0SprnBP59vJEJAB3jU/hZSYKame7/FLqWfyD/xWwCB5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5321
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 05 Nov 2026 16:14:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24649

On 05.11.26 07:43, Jan Kiszka wrote:
> On 05.11.26 07:30, Nobuhiro Iwamatsu wrote:
>> It is no longer possible to retrieve the U-Boot source from denx.de. This
>> change updates the mirror to u-boot-project.org.
>> Since the mirror has been updated, the hash value for the tarball has also
>> been changed.
>>
>> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
>> ---
>>  recipes-bsp/u-boot/u-boot-common-2026.01.inc | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/recipes-bsp/u-boot/u-boot-common-2026.01.inc b/recipes-bsp/u-boot/u-boot-common-2026.01.inc
>> index 9038dc7..60dffe0 100644
>> --- a/recipes-bsp/u-boot/u-boot-common-2026.01.inc
>> +++ b/recipes-bsp/u-boot/u-boot-common-2026.01.inc
>> @@ -16,7 +16,7 @@ MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>>  FILESPATH:append := ":${FILE_DIRNAME}/files"
>>  
>>  SRC_URI += " \
>> -    https://ftp.denx.de/pub/u-boot/u-boot-${PV}.tar.bz2 \
>> +    https://git.u-boot-project.org/u-boot/u-boot/-/archive/v${PV}/u-boot-v${PV}.tar.bz2 \
>>      file://0001-spl-Kconfig-Add-missing-SPL_LOAD_BLOCK-for-SYS_MMCSD.patch \
>>      file://0002-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch \
>>      file://0003-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch \
>> @@ -34,7 +34,7 @@ SRC_URI += " \
>>      file://0006-mmc-Call-back-to-optee-after-a-successful-mmc_init.patch \
>>      file://0007-mmc-Make-MMC-Device-not-found-a-debug-output.patch \
>>      file://rules.tmpl;subdir=debian"
>> -SRC_URI[sha256sum] = "b60d5865cefdbc75da8da4156c56c458e00de75a49b80c1a2e58a96e30ad0d54"
>> +SRC_URI[sha256sum] = "536c2204bb875236dcba41f5a5802090039a4b7a704dd284fcb9640e66a84a8a"
>>  
>>  SRC_URI:append:ftpm-stmm = " \
>>      file://ftpm-stmm.cfg"
>> @@ -42,7 +42,7 @@ SRC_URI:append:ftpm-stmm = " \
>>  SRC_URI:append:secureboot = " \
>>      file://secure-boot.cfg"
>>  
>> -S = "${WORKDIR}/u-boot-${PV}"
>> +S = "${WORKDIR}/u-boot-v${PV}"
>>  
>>  DEBIAN_BUILD_DEPENDS += ", libssl-dev:native, libssl-dev:${DISTRO_ARCH}, \
>>      libgnutls28-dev:native, libgnutls28-dev:${DISTRO_ARCH}"
> 
> Thanks, applied.
> 

I additionally had to drop the out-of-sync and actually redundant S
assigning in u-boot-ti-am62px-sk_2026.01.bb. Now it should build.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
