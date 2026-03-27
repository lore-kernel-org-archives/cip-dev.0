Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765C510BA42F
	for <webhook@archiver.kernel.org>; Fri, 27 Mar 2026 06:00:50 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.10])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.66062.1774591243955217749
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Mar 2026 23:00:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tIRWvYQU;
 spf=pass (domain: siemens.com, ip: 52.101.69.10, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSOqCi+norNTZf8rFT4biI79J5XIqSmxT+d2FGMZT6dB8mzi5LNzgOht8o33j7/41AnnPpFt28VdpdX5MwPHs0XJ5BFirWM+YyqfDRELhqywSSuXl6BnbtMtVpXBh4+lT12My/ocssq72TbDzNU75SOOt3H7mBGKapqom8EQp6eHoEGEakh1cdbY1fb5QrZSwHSbQO7A1xMcLadedunK+9iFE5E2e9nqWRsdimjCxRNWnP3I1x7EudPn2XaAlIyMUFeonDIjJU7nIKcKeikiBIxWICRKPJ45LdN1mpCD14K1nEft5vL4xHONUTtBagZZwp2VDt5pQBK6F9PzKejfHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZd5laqmomEfacnxUyA9dolMvPpQ0yV9UHfRr4nziC8=;
 b=tj1tykMhgUjkiedZx5DrVu1/EHHHxkhG5rOugK//j2DNynUjHuVdybW2Fi+8csN9Mg1/q/kvajqxYmjrCYr3u01T4OGyfmMMp+VQ/hyVz1fzzTuvJHHgBWI7gmvYfoe2h3+Ins32+7Vhy/y1ofU5iq0LkcY0Cs4PEbiFqnQn5Nd1UWHUaRgYJ388TV1c5wfg2kaxddth0zY67mZ5PeXhFpmGDZ8rufORtArwxtMpVp+J5Ta0wD3fKzlMPSfnJq8gZUWgvXOp6l8Xtx1SCCguMng15FUmjx7D4aWjZEcYcKV0KsDZfy0Ag5O7TzL8KZm3cv0N0b4QcOha0RH13rpm+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZd5laqmomEfacnxUyA9dolMvPpQ0yV9UHfRr4nziC8=;
 b=tIRWvYQU6KmKgyxZjGbbnwaGE79zZuVz5UokNWmpV53KObcpTm+cKjMcmwLTz+YeDD50PxZH7z8RC8wfVq3Ij5GgYg33PeLSv6chPZEcdbjUeiaFOFxyHanpuL5lcnCYhQa5WNPnkKtRg7b2EvmwUkSVoleu7H7h3oK0MR6g3tLD0gD5DY7b+U5U0MVzCqOEIHAwn2/msmiWTjsP2fl0U49zAoSS5mJzJ5OAw3XW8ssV4annsCJWX5zc41vKcUeKk8Ycfcj3uX2FGTCe98DJkt/2Hr/8v61QmPv1xtbej3NqECZb7zJHdtl93hgDAUrMnT2gqrXuJzVauxsSfyFY2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB9000.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Fri, 27 Mar
 2026 06:00:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9745.023; Fri, 27 Mar 2026
 06:00:38 +0000
Message-ID: <aaebd634-d7f1-48e0-9e15-8ce38131166a@siemens.com>
Date: Fri, 27 Mar 2026 07:00:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] chore: Add a description to all
 packages
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260326094759.27940-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260326094759.27940-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0161.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: d19dc3cf-fc47-40a2-ab6d-08de8bc62b9e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|55112099003|13003099007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	uabGnqd0ux/OV2Z6Bmj/gjeFSSyMECXYOHFFN5cLUOipibafYuem/ECdfYKEYNOSNOAQm9Qnx+cFoZSnKwD5/IHK4IfcuOPBDvGdI31VonLpX0rJ+5Bm+ehFaFKNc5VTKWhl+zgas/iGqCUSfrog3ORHrqabW4lpq28ANBlI39YwXWeBc0a9qZBUnnfIri8HtGmyxMcgOdTH0gAMugsFWIuGOVCAsQQbLojZ7C/xmSrMwzLqaSTOAy099yZyeVnznaisf20Pnesq7+eTivC2wi+4MMHpgXuEoyOSySkNfDTypShc3z5JVKQW9gI5MN3X+XTdSclDzVN9cIsR1CvE/EFxHUaOmUxQK0X9i1rIy0CcT7VJZCQWMFL4dnW3A+M10f07W1TKSvqaGuz9fOoXL7RoZluwjTcT8bWiJ46mCJlwrG3ZloJSkbQTtQnWccvnk5dKXxYEf6W6tZh4TGFFKVjbmSkmBRBzvlSRJn70y9jOrS1vQvXoyQc9svqnaEwbeogKwN10XHOiHhzYs2nSLruIAa/4AHhM9Mq+d8vYHokSMZ5D3B6cOeoRssT969snsh4se5Czko2Kmv17SHLBOVzh3C6S+gSAwWow7mAeA+sgY35FlFAzncE6oXk6w8SYGXcsBO8q+wd3hKb7wF1SHXVxZjLKb/0zc7CkwsXgvEDYhHPHx/gwpY6+IkgNaLoZ6bbw0JQY1pnH3mxms8BcOA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(13003099007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RVYzOS9MMXUvaEFWcjdtYzBrMnluZWVSWUVmcWh1ZkZ2Yld3eDY2UVBXaER2?=
 =?utf-8?B?TmFVeFdJSmtFWjM5cFVEdzhDaWErNzZZNFhNN0FDeTN1ODdCSUM2ZEhWYlJ4?=
 =?utf-8?B?S3BMTGl5Tm5Dd3BwdUV6VWZGVUNJRmxxM2pUdkJDdVlPNW5MSmhrUkhta2c2?=
 =?utf-8?B?RkVVZkRCeGpMZVlLdEp6TzZJUHFFM2lpTFM0RytXYXRiSGp2WFM1Zk5qcGI1?=
 =?utf-8?B?bTE1Tk0wOHZncFpDNFB0YWg1NFZCQzgzZ3lUcFczdDl2QTVYK25ZZ0NOQ1lq?=
 =?utf-8?B?clA1NGpkcit2ZG9GQkVoQ2h6S1FLTG5YYVEra21RNE54R3k3Z1NnZERJWEh1?=
 =?utf-8?B?dXppdEphUG9EZG9meFZaWDRTYWNQbjc3WDFGSkNONndDQ0x0bmltSExTU1Nk?=
 =?utf-8?B?L2FHWjVEdllIbEVsVHhoVWJVbTBINzBoQ00rVzV0ODJsSHpyZzgwUmYwcGlO?=
 =?utf-8?B?NmR3K0F1aGxERkIzR2Nrb0J4VGhVZURNdXFVeFVwZlFSdjJhVjJuVDd4VG9i?=
 =?utf-8?B?UDZZSEdkVWd5SmF3WlZRSFpTTGgvTE8yWlFsczJnQ3hwckk0SUgrYVVla2Nn?=
 =?utf-8?B?T2tDc05YRkp4c2NBQWpwR1ZiZWZTUW44TFBDbVVRZVF4Wlltc1JqSFlScFhY?=
 =?utf-8?B?aUk0ZTVDdzlLOWMxVE9BUzdCOHpTWlE5dDBhWDBBTktLRU5ENE43WUhPUmU4?=
 =?utf-8?B?eHdVYmlSY1NzYjVHN3FEeC94M2RNWGJNZFRrelkxQld4eFVmOFJvVGhSVExS?=
 =?utf-8?B?RTlHcE5xa3NEL2d6Q3FyZm40UUpZSjZlRUpqVWo0ZlY2MUIwWXlackV1ODJj?=
 =?utf-8?B?THV3RlJiNHFTMzJna29sYVZPTU4yWFFRdndGSDlWWkk1RDBQL3Bkajk5MXlw?=
 =?utf-8?B?ak81WklJSUNhbUl6N25nTHFTVGZyYjRDU3oyT2NabnhPYkR6aGZ3VjBGS0F3?=
 =?utf-8?B?b21vRy9sSHVzTS96cEZrYjl5dUR0UjRUcmRXbFlSSkdGcy8xQUx3V3dsSnpz?=
 =?utf-8?B?SGxjL0YwaFU0V2pobFIyWXU4dEx3M2pEcjVIcFhXdmxWUnEzTVRHTGxmakcy?=
 =?utf-8?B?dWROVCtQVHZhYVBJbFo4RHBNeWdLUFpjRlV6ZC96ekZ1N3kvZDBjTUt6RGFx?=
 =?utf-8?B?VUdpN0IrcmtTd3VTeUxYOUR0bVBMZXdDTHl6RWJPSHFQekxremVLZU1BU0E0?=
 =?utf-8?B?SnI3WDF2NmNpSjhxV1BKMUx0QWQvQ1FDQ2ZzUzVTRTZOMnFXUVREVmlPMlgr?=
 =?utf-8?B?Yzk3dHpaa01CV1BPa1JOeXUvbjZ4Z1R1ZEtZa0FsWkRtTUI4eWYyYVdWcm5L?=
 =?utf-8?B?UlI4azE1R2dXZnpjY0RSYTR3MlJld2EzaFJiQnowMVN1OUFQNVlwOTBLOWlt?=
 =?utf-8?B?ZDlOWTNGRDJoNE9YZVIycDNzcnZQQUYzOVFGNTdNbk83c01sa0RUWkg0OHBv?=
 =?utf-8?B?WXdVajZYcE9DVDZRMWJ4YmMzY1ZhY2FZcnpYYlJITVU0ZnV5Nk1RUEhQNTV5?=
 =?utf-8?B?NzkxWXNkMG8xcWZHc1VYV2p4bGJDelFZVzIvNXhxTjJQMXZmRThkcElGZGVY?=
 =?utf-8?B?OXFvSU0wSDJxN3c5Z2RDKzFnWDhGVXQrWWlCUnI5VnRuRlFNUklpZmR1S29l?=
 =?utf-8?B?a29ybWYyZERXOTEyL2J3V2Z5SUJHOWo3UmVzMGUvQUJQQ1lxOUw3MGR2NVk4?=
 =?utf-8?B?b1dwZHlDV1ZRU1BRSVJET3I5VTAxN2Z0OFBweVV6cEdzaDhVeXlLMHN1N1k5?=
 =?utf-8?B?cjNKV2NSblFyR1h4U2dreW42U2tyN244UmdCVmJIS0pObnBDZlhGNFZGUm44?=
 =?utf-8?B?RFVtSUM2MWhXUVYwMmZpU0kvV0xnS2J2SldDdjdDMlRKZ2RQa1pVTklYY1Jo?=
 =?utf-8?B?TzBFdVpsZENuZE5TRWtWUGRVeitlbE1PU3Z1YnUvR0lKSno2Q1p0WXRpMG9i?=
 =?utf-8?B?cGtmc3NtTUhTcW1ORU9OYm00TXVhZ2tEcWpQZWg2dGVIdFNjd1hza05FNVpT?=
 =?utf-8?B?NFA2UEp6Nm9KLy9hT0VmRVRxaFRycVRNNzJ6c1hEWDFlZEVkOTgxaHFJVkFJ?=
 =?utf-8?B?K3YrbGp4MjQrUzd3MHAwWElTL0I1UHdQbFhHK3hoMHhJSnNVclliT1dGMURF?=
 =?utf-8?B?dWFPa212RGIwTE9mOUhpck1nWHJDTVpZM3ovVVhhYUdtSG5XOXFWbXVHTjRE?=
 =?utf-8?B?cm1YVGh0OElLalRtOGNRUDJjSU81ZDJJOTNUdEVaeGxwdXJZNHF0UUxLT21j?=
 =?utf-8?B?Tyt4ZXEyaUJ4VmhwTFdESXZpdDI0UnBFMitkTktMakQrUDFiWmUyZVd0V1do?=
 =?utf-8?B?bFdYbGdPUDVuWjUyWlFmSXJiYXZMQnVTSXBwOGdRUFFlV21UV09rZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19dc3cf-fc47-40a2-ab6d-08de8bc62b9e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 06:00:38.6883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12TFhWmvbTrWSEx8Hz9MFYaXcv9jAfjTwqKpa74hsTZPe3nSoELXdckaRC5+2Xjk53apmdFtoZTklLqy2lsMWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9000
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Mar 2026 06:00:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22587

On 26.03.26 10:47, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The description field is mandatory according to Debian policies and
> `deb_debianize` set it to "must not be empty"
> (https://github.com/ilbers/isar/blob/34c3cda51b46a2a2a405e472a3c4b88c820c765e/meta/classes-recipe/debianize.bbclass#L23).
> 
> As this description will be part of a sbom generated by `debsbom` it
> should contain valid information.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../hss-payload-generator/hss-payload-generator_2025.07.bb      | 1 +
>  recipes-bsp/opensbi/opensbi_1.7.inc                             | 2 ++
>  .../optee-ftpm/optee-ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb | 2 ++
>  .../optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb      | 2 ++
>  recipes-bsp/optee-os/optee-os-qemu.inc                          | 2 ++
>  recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc                   | 2 ++
>  .../trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb  | 2 ++
>  recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb | 2 ++
>  recipes-bsp/u-boot/u-boot-common-2026.01.inc                    | 2 ++
>  recipes-core/home-fs/home-fs_0.1.bb                             | 1 +
>  recipes-core/journald-config/journald-config_0.1.bb             | 1 +
>  recipes-core/move-homedir-var/move-homedir-var_0.1.bb           | 1 +
>  recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb     | 1 +
>  recipes-core/swupdate-config/swupdate-config_0.2.bb             | 1 +
>  .../swupdate-handler-roundrobin_0.1.bb                          | 1 +
>  recipes-core/tmp-fs/tmp-fs_0.2.bb                               | 1 +
>  recipes-devtools/dosfstools/dosfstools_latest.bb                | 1 +
>  recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc    | 1 +
>  .../swupdate-certificates/swupdate-certificates-key.inc         | 1 +
>  .../swupdate-certificates/swupdate-certificates.inc             | 1 +
>  recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb     | 1 +
>  recipes-devtools/swupdate-signer/swupdate-signer-empty.bb       | 1 +
>  recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb      | 2 ++
>  .../initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb      | 1 +
>  .../initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb           | 1 +
>  .../initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb            | 1 +
>  .../initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb        | 1 +
>  .../initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb      | 1 +
>  .../initramfs-verity-hook/initramfs-verity-hook_0.3.bb          | 1 +
>  recipes-kernel/linux/linux-cip-common.inc                       | 2 ++
>  30 files changed, 40 insertions(+)
> 
> diff --git a/recipes-bsp/hss-payload-generator/hss-payload-generator_2025.07.bb b/recipes-bsp/hss-payload-generator/hss-payload-generator_2025.07.bb
> index cfb821f..a0ca054 100644
> --- a/recipes-bsp/hss-payload-generator/hss-payload-generator_2025.07.bb
> +++ b/recipes-bsp/hss-payload-generator/hss-payload-generator_2025.07.bb
> @@ -11,6 +11,7 @@
>  
>  inherit dpkg
>  
> +DESCRIPTION = "Tool to generate HSS payload images for PolarFire SoC"
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
>  SRC_URI = " \
> diff --git a/recipes-bsp/opensbi/opensbi_1.7.inc b/recipes-bsp/opensbi/opensbi_1.7.inc
> index 885401d..f9760fd 100644
> --- a/recipes-bsp/opensbi/opensbi_1.7.inc
> +++ b/recipes-bsp/opensbi/opensbi_1.7.inc
> @@ -7,6 +7,8 @@ inherit opensbi
>  
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
> +DESCRIPTION = "RISC-V OpenSBI firmware"
> +

No added value over the prefilled text of opensbi.bbclass.

>  SRC_URI += "https://github.com/riscv/opensbi/archive/v${PV}.tar.gz;downloadfilename=opensbi-${PV}.tar.gz;name=opensbi"
>  SRC_URI[opensbi.sha256sum] = "2cf856a4e5e2e052948ddb54ba48232b1f698b7f52e0374fc7d17d51e8c8f7ce"
>  
> diff --git a/recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb b/recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb
> index 0dacd50..673aa00 100644
> --- a/recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb
> +++ b/recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb
> @@ -13,6 +13,8 @@ inherit optee-ftpm
>  
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
> +DESCRIPTION = "OP-TEE fTPM Trusted Application for QEMU arm64"
> +
>  SRC_URI += " \
>      https://github.com/OP-TEE/optee_ftpm/archive/${SRCREV}.tar.gz;downloadfilename=optee_ftpm-${SRCREV}.tar.gz \
>      https://github.com/microsoft/ms-tpm-20-ref/archive/${SRCREV_ms-tpm}.tar.gz;name=ms-tpm;downloadfilename=ms-tpm-20-ref-${SRCREV_ms-tpm}.tar.gz \
> diff --git a/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb b/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb
> index b28ea77..706d9e9 100644
> --- a/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb
> +++ b/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb
> @@ -11,6 +11,8 @@ inherit optee-ftpm
>  
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
> +DESCRIPTION = "OP-TEE fTPM Trusted Application for TI K3"
> +

Upstream has more information, just lacks the target platform (OPTEE_NAME).

>  SRC_URI += " \
>      https://github.com/OP-TEE/optee_ftpm/archive/${SRCREV}.tar.gz;downloadfilename=optee_ftpm-${SRCREV}.tar.gz \
>      https://github.com/microsoft/ms-tpm-20-ref/archive/${SRCREV_ms-tpm}.tar.gz;name=ms-tpm;downloadfilename=ms-tpm-20-ref-${SRCREV_ms-tpm}.tar.gz \
> diff --git a/recipes-bsp/optee-os/optee-os-qemu.inc b/recipes-bsp/optee-os/optee-os-qemu.inc
> index 3538d36..90067d1 100644
> --- a/recipes-bsp/optee-os/optee-os-qemu.inc
> +++ b/recipes-bsp/optee-os/optee-os-qemu.inc
> @@ -11,6 +11,8 @@
>  
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
> +DESCRIPTION = "OP-TEE OS for QEMU target ${MACHINE}"
> +

Close but not fully acurate: This is both used for the OT-TEE OS itself
as well as the TA devkit.

Please check for all recipe types that pull in some high-level class if
they aren't getting some description already. If that is improvable, go
to upstream.

>  SRC_URI += " \
>      https://github.com/OP-TEE/optee_os/archive/${PV}.tar.gz;downloadfilename=optee-os-${PV}.tar.gz \
>      "
> diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
> index 4e99949..f90f189 100644
> --- a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
> +++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
> @@ -9,6 +9,8 @@
>  
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
> +DESCRIPTION = "OP-TEE OS configuration for TI K3"
> +
>  SRC_URI += " \
>      https://github.com/OP-TEE/optee_os/archive/${PV}.tar.gz;downloadfilename=optee-os-${PV}.tar.gz \
>      "
> diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb
> index 4786f34..30a4f63 100644
> --- a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb
> +++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb
> @@ -14,6 +14,8 @@ inherit trusted-firmware-a
>  
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
> +DESCRIPTION = "Trusted Firmware-A BL1 and FIP image for QEMU arm64"
> +

Another example: Can't we enrich the automatic description in a way that
such lines are obsolete?

>  SRC_URI += "https://github.com/TrustedFirmware-A/trusted-firmware-a/archive/refs/tags/v${PV}.tar.gz;downloadfilename=trusted-firmware-a-v${PV}.tar.gz"
>  SRC_URI[sha256sum] = "28bc15daeeed000ecd30819ecc4851bf9ffc2d33e1d4553a71985c17f47a999e"
>  
> diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
> index 25b8889..a5aeab5 100644
> --- a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
> +++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
> @@ -11,6 +11,8 @@ inherit trusted-firmware-a
>  
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
> +DESCRIPTION = "Trusted Firmware-A BL31 for TI K3"
> +
>  SRC_URI += "https://github.com/ARM-software/arm-trusted-firmware/archive/v${PV}.tar.gz;downloadfilename=arm-trusted-firmware-${PV}.tar.gz"
>  SRC_URI[sha256sum] = "68333c8be57830e7430d7dd39064826729923d86d6bb7af38d713d4e9d15dcf9"
>  
> diff --git a/recipes-bsp/u-boot/u-boot-common-2026.01.inc b/recipes-bsp/u-boot/u-boot-common-2026.01.inc
> index 850847f..0633997 100644
> --- a/recipes-bsp/u-boot/u-boot-common-2026.01.inc
> +++ b/recipes-bsp/u-boot/u-boot-common-2026.01.inc
> @@ -13,6 +13,8 @@ inherit u-boot
>  
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
> +DESCRIPTION = "U-Boot bootloader for ${MACHINE}"
> +

Same for U-Boot.

>  FILESPATH:append := ":${FILE_DIRNAME}/files"
>  
>  SRC_URI += " \
> diff --git a/recipes-core/home-fs/home-fs_0.1.bb b/recipes-core/home-fs/home-fs_0.1.bb
> index fd88f21..fef673c 100644
> --- a/recipes-core/home-fs/home-fs_0.1.bb
> +++ b/recipes-core/home-fs/home-fs_0.1.bb
> @@ -10,6 +10,7 @@
>  
>  inherit dpkg-raw
>  
> +DESCRIPTION = "Systemd mount unit for a dedicated /home partition"
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
>  SRC_URI = "file://postinst \
> diff --git a/recipes-core/journald-config/journald-config_0.1.bb b/recipes-core/journald-config/journald-config_0.1.bb
> index 62fc0c7..6152cdb 100644
> --- a/recipes-core/journald-config/journald-config_0.1.bb
> +++ b/recipes-core/journald-config/journald-config_0.1.bb
> @@ -10,6 +10,7 @@
>  
>  inherit dpkg-raw
>  
> +DESCRIPTION = "Systemd journald config to enable persistent journal storage"
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
>  SRC_URI = "file://persistent-journal.conf"
> diff --git a/recipes-core/move-homedir-var/move-homedir-var_0.1.bb b/recipes-core/move-homedir-var/move-homedir-var_0.1.bb
> index 54e807a..ec4b19b 100644
> --- a/recipes-core/move-homedir-var/move-homedir-var_0.1.bb
> +++ b/recipes-core/move-homedir-var/move-homedir-var_0.1.bb
> @@ -10,6 +10,7 @@
>  
>  inherit dpkg-raw
>  
> +DESCRIPTION = "Redirect /home to /var via tmpfiles for overlay setups"
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
>  DEBIAN_CONFLICTS = "home-fs"
> diff --git a/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb b/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb
> index c800c84..1b722b2 100644
> --- a/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb
> +++ b/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb
> @@ -11,6 +11,7 @@
>  
>  inherit dpkg-raw
>  
> +DESCRIPTION = "SWUpdate suricatta WFX server configuration"
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
>  PROVIDES := "${PN}"
> diff --git a/recipes-core/swupdate-config/swupdate-config_0.2.bb b/recipes-core/swupdate-config/swupdate-config_0.2.bb
> index cdfd8b9..6c09952 100644
> --- a/recipes-core/swupdate-config/swupdate-config_0.2.bb
> +++ b/recipes-core/swupdate-config/swupdate-config_0.2.bb
> @@ -11,6 +11,7 @@
>  
>  inherit dpkg-raw
>  
> +DESCRIPTION = "Machine-specific SWUpdate configuration and hardware revision"
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
>  PROVIDES := "${PN}"
> diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> index 2ba192c..e3f1144 100644
> --- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> +++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> @@ -10,6 +10,7 @@
>  
>  inherit dpkg-raw
>  
> +DESCRIPTION = "SWUpdate Lua handler for A/B round-robin partition updates"
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
>  PROVIDES = "swupdate-handlers"
> diff --git a/recipes-core/tmp-fs/tmp-fs_0.2.bb b/recipes-core/tmp-fs/tmp-fs_0.2.bb
> index f2b7976..b8e4958 100644
> --- a/recipes-core/tmp-fs/tmp-fs_0.2.bb
> +++ b/recipes-core/tmp-fs/tmp-fs_0.2.bb
> @@ -10,6 +10,7 @@
>  
>  inherit dpkg-raw
>  
> +DESCRIPTION = "Configure /tmp as a tmpfs mount on the target"
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
>  SRC_URI = "file://postinst"
> diff --git a/recipes-devtools/dosfstools/dosfstools_latest.bb b/recipes-devtools/dosfstools/dosfstools_latest.bb
> index d0ac128..810ebdc 100644
> --- a/recipes-devtools/dosfstools/dosfstools_latest.bb
> +++ b/recipes-devtools/dosfstools/dosfstools_latest.bb
> @@ -11,6 +11,7 @@
>  
>  inherit dpkg
>  
> +DESCRIPTION = "FAT filesystem utilities rebuilt with reproducible-build fix"
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
>  CHANGELOG_V="<orig-version>+cip"
> diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
> index 38b57ee..850d421 100644
> --- a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
> +++ b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
> @@ -11,6 +11,7 @@
>  
>  inherit dpkg-raw
>  
> +DESCRIPTION = "Base include for Secure Boot key and certificate delivery"

The term "include" is wrong for the package built from this include.

>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
>  PROVIDES += "secure-boot-secrets"
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> index 4124b31..74dbacc 100644
> --- a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> @@ -11,6 +11,7 @@
>  
>  inherit dpkg-raw
>  
> +DESCRIPTION = "Base include for SWUpdate signing private key delivery"

Same here.

>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
>  FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> index 3c59887..0b34d18 100644
> --- a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> @@ -11,6 +11,7 @@
>  
>  inherit dpkg-raw
>  
> +DESCRIPTION = "Base include for SWUpdate signing certificate delivery"

And here.

>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
>  FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
> diff --git a/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb b/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
> index ee8d172..94361f8 100644
> --- a/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
> +++ b/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
> @@ -10,6 +10,7 @@
>  
>  inherit dpkg-raw
>  
> +DESCRIPTION = "SWUpdate image signer using OpenSSL CMS"
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
>  PROVIDES = "swupdate-signer"
> diff --git a/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb b/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
> index af9de76..baed2b7 100644
> --- a/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
> +++ b/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
> @@ -10,6 +10,7 @@
>  
>  inherit dpkg-raw
>  
> +DESCRIPTION = "No-op SWUpdate signer stub for unsigned builds"
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
>  PROVIDES = "swupdate-signer"
> diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
> index b686185..bf3741a 100644
> --- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
> +++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
> @@ -11,6 +11,8 @@
>  
>  inherit initramfs
>  
> +DESCRIPTION = "CIP Core initramfs assembling selected boot hooks"
> +
>  RO_ROOTFS_TYPE ??= "squashfs"
>  
>  INITRAMFS_INSTALL += " \
> diff --git a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb
> index 48f6458..f3a7b52 100644
> --- a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb
> +++ b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb
> @@ -11,6 +11,7 @@
>  
>  inherit initramfs-hook
>  
> +DESCRIPTION = "Initramfs hook for A/B root filesystem switching"

for unprotected root filesystems

>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
>  RDEPENDS += "initramfs-cip-functions"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
> index 18a10a8..6ad5204 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
> @@ -11,6 +11,7 @@
>  
>  inherit initramfs-hook
>  
> +DESCRIPTION = "Initramfs hook for TPM2-backed LUKS partition encryption"
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
>  RDEPENDS += "initramfs-cip-functions"
> diff --git a/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb b/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb
> index 2015503..2d8bec4 100644
> --- a/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb
> +++ b/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb
> @@ -11,6 +11,7 @@
>  
>  inherit initramfs-hook
>  
> +DESCRIPTION = "Initramfs hook to include the erofs filesystem module"
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
>  HOOK_ADD_MODULES = "erofs"
> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
> index 57b26ec..b6a8d24 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
> @@ -12,6 +12,7 @@
>  
>  inherit initramfs-hook
>  
> +DESCRIPTION = "Initramfs hook to mount an overlayfs over read-only paths"
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
>  INITRAMFS_OVERLAY_RECOVERY_SCRIPT ??= "overlay_recovery_action.script"
> diff --git a/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb b/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb
> index 9ff4cbf..b2516fb 100644
> --- a/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb
> +++ b/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb
> @@ -11,6 +11,7 @@
>  
>  inherit initramfs-hook
>  
> +DESCRIPTION = "Initramfs hook to include the squashfs filesystem module"
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
>  HOOK_ADD_MODULES = "squashfs"
> diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb
> index b2fb704..339e831 100644
> --- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb
> +++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb
> @@ -11,6 +11,7 @@
>  
>  inherit initramfs-hook
>  
> +DESCRIPTION = "Initramfs hook for dm-verity root filesystem integrity"

This is also an A/B switcher as it matches the given hash against
multiple verity partitions.

>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
>  SRC_URI += " \
> diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
> index 4569b89..961093b 100644
> --- a/recipes-kernel/linux/linux-cip-common.inc
> +++ b/recipes-kernel/linux/linux-cip-common.inc
> @@ -11,6 +11,8 @@
>  
>  FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
>  
> +DESCRIPTION = "Linux CIP kernel"
> +

This override fits.

>  inherit linux-kernel
>  
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"

As this is not really critical and could also benefit from Isar
improvements, let's postpone it after the release.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

