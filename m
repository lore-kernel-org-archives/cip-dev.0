Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC67C5CFDB
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 08:14:31 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.23])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14403.1786608862544198427
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2026 01:14:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mEfpxqai;
 spf=pass (domain: siemens.com, ip: 52.101.83.23, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QitxBuzDpyxhjBdzEa6aJVK5D4jArPWAgQ0SwrxJD+biPaIkuy2EGxcPij2JfC6tTJWWP4aRRifuOyN1a3kCAR18h3k9F6+GLB8IwyLaeciQXuhx6p1sTWDnbJoU3ALAJBLvQlJbaJaY1KWPv73P6rjJKJ24IVMEnkzvU9UXfYYuyYnE4c5HePUO91hjN8vJHllEur+DWLnfVmh+jCqQlwZJMjFX2I9RC9P88QIl+3ko5HqLUks6doEJMMgkxuRnmNfPdlZ7Nt+vtaT9yUx0U789V0WIhoLa/GWAXtxoMAI8qUOEeH39tVy2BZPFQFKVKwd4ky+m58az1sIN94be8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVJ6dmhMVvDFs4yrKc9lBb+sVXtzRfZZxbq5iGufg58=;
 b=S00R2T9MbIv4phaSvHRzecNtsKk3AL1V6Tcr+Smfunnq1kYECHBDhj6qRdkNdVcUmoL4BGHsXyaR2sqYBRk4E0syeI8odzpaXLAEpCLqVS7PytST/TwX67uAnZpP5BPQqQL6LDuIMzgKxsA7g2hFMAfvZ/8lvaLIbSFEEc/36b/GQ/VW63Zv4J01rvrZUGkBoGCpJD98k3aYe+AxZ7/w6iTfOoUnwmOk6avcczcIk3L9kOOD+9eJ1tw4u8vN21fHdJT5C39KuvpVqwb2G861jm0myQZvTO5WyLAUam8FTkUqcPEPNpGzERL1CA8Vf4CLwY8BQUYutTWvZApk1tfi/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVJ6dmhMVvDFs4yrKc9lBb+sVXtzRfZZxbq5iGufg58=;
 b=mEfpxqaiwXsAs2Ka04cnKyKC2KRwpWimN0LhpT6MPLQaBHxMOZ2+ccougocOZ7STN2NOz2uwT5Ec8E6kGQ5TXkj0302z0N6Jp9hDoDP+XpB6v/rUwly6xJYHAKP6rKxAYO+BPQ8UU53JMJOOUOgs9l+xN/TcSOT+gHVfbnocYWZKlqceDtiWttkWGeEB6tqyCfDiSlNcUdP6GzHz3nKNG1Mb1UTjNqxaE/hoTmTlDOs3kDCyjdWQG8z5juYTxLJBbgPW3oi0n2uGrmHxvf7KQZEgGOyzJCEFJ1uDd5BgJNaC+kWXwqs9UZrcK5bJK3d8wN5Zlw/uL3t2xl4QOZTQvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6793.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 08:14:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 08:14:18 +0000
Message-ID: <aff77ff3-832a-421f-b73a-5c858c8c88c4@siemens.com>
Date: Thu, 13 Aug 2026 10:14:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] Update Isar revision
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260813070728.102577-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260813070728.102577-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 4575cf00-f44e-4670-c09f-08def912df0a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|55112099003|22082099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	MAeB4Y9Pvms8xK+Tdwiy08pMtQzGzGGaFZ4UhuziXestzhRJ1ZetVecXTgNjsbYm2/u+v7XLpPaL1yVLjviXS5QsZqVuAyoJKPyXS5MKSA2q+l74GK/+QJ3EBvznfPwLs1MviIPohW69umVlh+t/BF/zOTVPM0Z0DOJD6PYoP1gjLpK8egTIBFMFsZpbCPSTgw6kKq2zoUpm50dERhySALxZsw3AkccfWEGZjrrD1Uh2ULJCbRyz1Mr+eoTZXd/PI8Y9NwyEwucTWkM7eMiQsMgu/9M/sIW1xAAww4DyxjP7CPlcihip7VHQDuCLE7N6k9PyA/uJXjRw49a1s4Yz2lhSvKh5y3b09N3gh/8OH4FPMffP93gsoN1SzgPafDXkr8GJklg6NR6Qj3nzzIoIFxPhnQxiJYhwKRgdtC6iozFXBvrtkONvWUdB4pOt2qTS2+t5tDO9FgMW8UIO2VIZE8/dKsAG39J7M1GcRrFTxVqkOSnvjvvIw2yurq9EwXh+3L3vZUrO0E3EnEg4tMod/fc2zVhuyZPvKFYOUd2+aV8NVe96FKKhr9f29vXlzQEp9IH4i6gPKAyZ0LjUWMrZccPS5Cq7CXc/3ybeZ3fX+UEjfnG1a5ey6mdAZLxLerOr4j3OfRJe8U5x7/XhJtKzcONcb1Ddcv2+WS/WTMHx2qw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(55112099003)(22082099003)(56012099006)(6133799003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WHJLbDE2SEhIZHlhMWNEY3d4NVF3MWRFUEJXbzVZNUtWVEhVdVdNYzliRnhN?=
 =?utf-8?B?Rk9Gems5c3Y2NFd1SndaRCtqbFI1YzNsdWY4VlJpTlJNbTFIeWZJaDFXVk5D?=
 =?utf-8?B?c2pQSStEcDN5dG1MTXczaU1TUVRBVWhneFQvZVEzREVwLy9rUkhtbVQvS1g3?=
 =?utf-8?B?cjl4Q0psNVBjSUR2aGMyUStoajZaU05PckdpcFg3YVFRd0FTL053eVBMMk5F?=
 =?utf-8?B?ekd1UVdKdnVDQndGd1oxNnF5K3V5eG41Vm84bDhRRnhleDM0NnRoei96UWRJ?=
 =?utf-8?B?QnBycVJ1ZGY2TWEwTktBTnZIUmlXeTM4VVBWajBzMzBQTUU2d29DZUFNOUdn?=
 =?utf-8?B?VGpkUVIvbS9SR3ZHdjYzZjdhT1NXYXZDNFFnc1FLUC8wQUFpcXp4YzU1TGI4?=
 =?utf-8?B?QmYvM0k4eVUwWXdXWWhjNEUzQTIvdEdva09yTUdWdWRuZi9kZ1U3QzIrejNC?=
 =?utf-8?B?M1VwMENuZjJLcFJXUmZheFAxRERsaGkvaDhqVWc5a2VnOTQzekp1Wk41TmM1?=
 =?utf-8?B?emREdlBYakFOdmp0VlpyaXB4VkhpRnR6Y0VzUUcraWxZMWxyYTh4OUtPdmVZ?=
 =?utf-8?B?OXF2K2tNTlJjc1JSMmZmcStqbklmaHFkV2IraTE2SGUvajRuMTU0OTFaOVdP?=
 =?utf-8?B?dEM3VEhuNStWcktsaHQ3eHkzYUJtU240QXordFpONlFiU3BOdWtqV3oydlNP?=
 =?utf-8?B?Uk5pbDZ3M1hxanhHQ3RNQWRDeHEvR3BoVHdLdlFLbGp2NTFrb2Y3eGorVGE1?=
 =?utf-8?B?V09lOWVpQ0VrVVhHZzNxdDg1RitSeGNYb2dsNkVseUkybnB4alFoU3R3S2Yz?=
 =?utf-8?B?NGdwN012RjY5bm9tVFpVMWNGOTdwQUZtL0dOMGZrRmZlaTc3UE56azFhd0F5?=
 =?utf-8?B?QVplWENIMW16eXcwcjdVdkpkZUYxaDZ6bnR1SlY1Zm9ndjRNS3YyMnBjZmU3?=
 =?utf-8?B?Qms0L0trcUpjbnFhZXpuOVJGWVhQcThIV0xJZlpYV2l6NG5yczllVEQzVFpw?=
 =?utf-8?B?U0d3R2JWSG8yUHFjOXV1endpZE1oQjkwSjh6NWpZbnBXb3IvVENVQlhuelp3?=
 =?utf-8?B?ZkJBc3d4c0tSUkNibUZ6VTF0cHpodGNiZk1Ud1NPQTgvczJWeklVTnBKbUJt?=
 =?utf-8?B?UDJ0Yi9pVk9uR3pHQWNCZDRobUJOZDdYL2dwL0pTZ3laWk4zYlVUU3EwV0Vv?=
 =?utf-8?B?cE1pRVdsUFo0K0hpQWs1ekxicGx6bHlFL1dtcUVSbmtzaXlpZm8xRGVlT0lv?=
 =?utf-8?B?NGx6Rm1xNG12NkVFNW1oQjY2eHp3RUxEdUlxck1Oc25lK09GK01vaTBXUTcz?=
 =?utf-8?B?aXFNUUV3OEMvaG11ZTF3Q0pDRkRuOG9zdmQxamc5Y0ZHMytDVmthY3dHdS9I?=
 =?utf-8?B?bm80cWxJczlNQ2VEZXg1RDkyTUlGNnlnS1hMYm1SMmZxZUpTcXNqbHMwMzEz?=
 =?utf-8?B?RmhQcjlEN2hvYjNWWm1LMmx1YklrRGJMYjVOUkl0ckFFWGxWeEk2RUJydG5B?=
 =?utf-8?B?VnRwM2xXaVpJNWJVb0NybzBFZ2lGQU42QWZoeXdVT1BHTDVhY3lFS0xEUUFZ?=
 =?utf-8?B?QVFSOTRjYzBkNGlWRmpQWnpPbnRUYlUwVUN5b20ycGQ2ME5RaU5Kc2p4TGlk?=
 =?utf-8?B?RzVLZTZOKzZKeFQvNmZkcitQcC82S1VNRll5c1Jpa28zNEpidTRJQlBKUjF6?=
 =?utf-8?B?ZzN1Y0xQV2tSWlNRR253NENtemx1L0w3Zlg1VFhJTUlKUGtOU09seDVuRlk5?=
 =?utf-8?B?OTJKOUtsZzVTWkR2MTN6N041WGlDUXZodjV2ek80N3Y0QW1aU00va2VOejli?=
 =?utf-8?B?UndBRUlnSGtpMUhsNTZoRUQ3RHBQRERjNzRHV29kaUVzNTBOT1I5NVRxdHlB?=
 =?utf-8?B?SlJpd2lsdUVmUUg1eGE3dEpzQ1pibkttRkcwc2RjZkdwY0pOclViLzRjK1dt?=
 =?utf-8?B?Z2oxbkJPbXZnT1B0Q1JjL2FmRFBXSVJtN0l1R1VTWXM3WW1mYTVOWndMTjZy?=
 =?utf-8?B?ZGkrUG8rNjdXVEtuUmdEeDd1V2VlbDFpZ1czdERJYWxzbmxrUEZKSGFBd0J6?=
 =?utf-8?B?Q0V6djdlb3VERDF6bGlqUnh2ZXFKZ1kvaFhmY3F0NDllVC9QekQyOGQ3MTll?=
 =?utf-8?B?TnhWMVlGRkZKNzMrL3liY3ZlVExKUVJNakFScnBMSjFIRnM2cldGYlN4YjJw?=
 =?utf-8?B?bnpHOUZPUHUxNVg5dkp5OTgxVnZaZFJUTnhnOTZEN2lvanY1bjMreTBod3JG?=
 =?utf-8?B?QWZuTHBKTGN1SDRsdXlZNTgrdkZRTjREUWZZbjZxMEhLcDFpTGtZTUpiYW81?=
 =?utf-8?B?enBLekU3cURqd3h6WkFoMnlXUitabVFMMGd5bGxXZU9naUsweVRtRlZjR25M?=
 =?utf-8?Q?f+B0lYPc9zaZSEIQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4575cf00-f44e-4670-c09f-08def912df0a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 08:14:18.1613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ydy7msQF9Dx7EpEfs2o/hsoBngYwXS77AARPyC3Rjso9VVLj9c3bPS95S0SOLlbKV1Jb4nJet0dZEUSOfCuVPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6793
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Aug 2026 08:14:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23912

On 13.08.26 09:07, Felix Moessbauer wrote:
> By that, we also need to update the firmware deployment again, as the
> previous interface was incompatible with sstate in combination with
> hash equivalence.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  kas-cip.yml                                                   | 2 +-
>  recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb               | 2 +-
>  .../trusted-firmware-a-qemu-arm64_2.13.0.bb                   | 4 ++--
>  recipes-bsp/u-boot/u-boot-qemu-common.inc                     | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kas-cip.yml b/kas-cip.yml
> index 5ed7ad2..4fcdec6 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -22,7 +22,7 @@ repos:
>  
>    isar:
>      url: https://github.com/ilbers/isar.git
> -    commit: 481db3b2e8949336576e50a78aaf5d101f52c8d2
> +    commit: 86c761e45e446c01874c0a36394f8be1f7d938d3
>      layers:
>        meta:
>  
> diff --git a/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb b/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb
> index 9c2bece..3f51dc4 100644
> --- a/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb
> +++ b/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb
> @@ -14,7 +14,7 @@ OPENSBI_BIN = "fw_payload.bin"
>  OPENSBI_EXTRA_BUILDARGS = "FW_PAYLOAD_PATH=/usr/lib/u-boot/qemu-riscv64/u-boot.bin"
>  
>  do_deploy_firmware() {
> -    dpkg --fsys-tarfile "${DEPLOYDIR}/${PN}_${PV}_${DISTRO_ARCH}.deb" | \
> +    dpkg --fsys-tarfile "${DEPLOY_DIR_DEB}/${PN}_${PV}_${DISTRO_ARCH}.deb" | \
>          tar xOf - "./usr/lib/opensbi/${MACHINE}/${OPENSBI_BIN}" \
>          > "${DEPLOYDIR_FIRMWARE}/${OPENSBI_BIN}"
>  }
> diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb
> index 7fcd144..e07342d 100644
> --- a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb
> +++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb
> @@ -32,10 +32,10 @@ TF_A_EXTRA_BUILDARGS = " \
>  TF_A_BINARIES = "release/bl1.bin release/fip.bin"
>  
>  do_deploy_firmware() {
> -    dpkg --fsys-tarfile "${DEPLOYDIR}/trusted-firmware-a-${TF_A_NAME}_${PV}_${DISTRO_ARCH}.deb" | \
> +    dpkg --fsys-tarfile "${DEPLOY_DIR_DEB}/trusted-firmware-a-${TF_A_NAME}_${PV}_${DISTRO_ARCH}.deb" | \
>          tar xOf - "./usr/lib/trusted-firmware-a/${TF_A_NAME}/bl1.bin" \
>          > "${DEPLOYDIR_FIRMWARE}/firmware.bin"
> -    dpkg --fsys-tarfile "${DEPLOYDIR}/trusted-firmware-a-${TF_A_NAME}_${PV}_${DISTRO_ARCH}.deb" | \
> +    dpkg --fsys-tarfile "${DEPLOY_DIR_DEB}/trusted-firmware-a-${TF_A_NAME}_${PV}_${DISTRO_ARCH}.deb" | \
>          tar xOf - "./usr/lib/trusted-firmware-a/${TF_A_NAME}/fip.bin" | \
>          dd of="${DEPLOYDIR_FIRMWARE}/firmware.bin" seek=64 bs=4096 conv=notrunc
>  }
> diff --git a/recipes-bsp/u-boot/u-boot-qemu-common.inc b/recipes-bsp/u-boot/u-boot-qemu-common.inc
> index 18f871b..c20787a 100644
> --- a/recipes-bsp/u-boot/u-boot-qemu-common.inc
> +++ b/recipes-bsp/u-boot/u-boot-qemu-common.inc
> @@ -26,7 +26,7 @@ python() {
>  }
>  
>  do_deploy_firmware() {
> -    dpkg --fsys-tarfile "${DEPLOYDIR}/u-boot-${MACHINE}_${PV}_${DISTRO_ARCH}.deb" | \
> +    dpkg --fsys-tarfile "${DEPLOY_DIR_DEB}/u-boot-${MACHINE}_${PV}_${DISTRO_ARCH}.deb" | \
>          tar xOf - "./usr/lib/u-boot/${MACHINE}/${U_BOOT_BIN}" \
>          > "${DEPLOYDIR_FIRMWARE}/firmware.bin"
>  }

This is already in next.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

