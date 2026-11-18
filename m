Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.67])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11888.1795006656876923403
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 04:57:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XZRDUG6L;
 spf=pass (domain: siemens.com, ip: 40.107.130.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIuxLgJhJY0c57uq5EieNb8GMxScS5bLm3+jx9wU9r8NPqLjp53H1kPwSveypgghnxEFvsyPZM8CXmwc9dfUnkZtiotXMz2b/ZURnYpW/FUJJvjCcwIouxFJEuBxBRp5g5VWx27EQC3RG6ngv3pQvrYwRs3uIi8eEPLSuj7rHxFBCd49RGgB7k+M1jRMC5u+d8X8bSY+lR7pgZyjNJqiSpiA2z+3TeuTBNX/Kla9hayaYzuhiRVAvsYP5eWFFC/0wzeBm7itI19Tjl385nz2ehy+lhdRimSZwUFuQuD5nqxjfHXyB0NQLih96OOQTesiiaTZsMzhEPXKS4oZ1n/6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wh1XXEig1/nGtc1r8O5SP+/5f+bUxTyCKy/AJa028Fw=;
 b=RBiMgOAic/ynG0QWCpygLjw7qFG3i8x1Pxev7KvZzFXIj3xDF4xl3uARpIMHaXz8TrJvY+JmoDuWHuPfgfN2UQ+qjTLrUrKIc31i/MdW1BInMItngCoiKg3HH4SM83J+auQ5EpCLaeM7xyHcNaBXipwoZ85LemJoJlpBdLFCDR/kK10DD8m93zaTG7sDGWRWHl1J1YI3mOEMTfJ0pOFH00h2BqhwYh1bfPMmDodCf/bpbbuKv6FZUx8PV92aqXuHuwE27UGkn3zXuPo60+1mudtgLsH5lp77w2rEAVQzYTu0M8H/J4Y+3Pxrt8GlPZQQRUhtcGigBThTS3ODENwH/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wh1XXEig1/nGtc1r8O5SP+/5f+bUxTyCKy/AJa028Fw=;
 b=XZRDUG6LSB3HmRHNIi0GudVl2yX1GOEmJVKnfVWVnksSoSYasNhH+aNXXvQdXxRx3Mm1FMLI9vS+zIBbaYhRplG6uIbPyiQnuaWV2751q67SLkzujA81bQ6Qv10vELiTGQfC5UfWEYQVB96f5RR4lbxJBe4sn9jIIyHOfBkd+LjubjEFKSW99wjBDCNaoQ9rhYzWKhqP0pgm1KdvTcgiYSDhEly7NdALOdkttSQJX8zM/+MhmpjaDSbexeIlkaQt4I0E5IzRqJoxtyTjU3jc84YUkxUlEfc6GpMhMAoY1FrfvZNe28HVuhPq32m/FtHRUpsqBz13enMil1fKw1d+iw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by VE1PR10MB3903.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:16a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Wed, 18 Nov
 2026 12:57:30 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Wed, 18 Nov 2026
 12:57:30 +0000
Message-ID: <8906c84c-2b82-4a3b-a83d-844dbc061936@siemens.com>
Date: Wed, 18 Nov 2026 13:57:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] Drop ext4 build as default
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: chris.paterson2@renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp
References: <20261118125450.620231-1-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261118125450.620231-1-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:208:239::6) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|VE1PR10MB3903:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c1548a3-d73f-41ab-af23-08df4573812f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|6133799003|55112099003|11063799006|56012099006|10067099003|261022105027099003|261026121527099003|261026140227099003|261022115727099003|261028144727099003|261021121427099003|261021123027099003|261022075727099003|261102123227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: FbW1j7WOwCIYKaXRU0ssbAq+b5gn8SGWf+/0YtStv4hJCRsRIge6DCULqS8067wP32JjiK80KP9vb2uOQjmYCYJQddAujwKuir3nGNic5PqIwtK09BEdpiBHoBeLvJmA/179phbMk4aOg/c8jnobWm1q45QMEpp/ReHu3fPrtuHsqs1T24vVGOmvnXtL0w5m1OxKs1frpJfVheuL0UT2H5iSqIw8497MI/ieCCsNGn2hhxWUwXkHNP0yq2yX7J3CUZpzHQIrWv+v1pTgRBcCXqk6id2jw642sHVQZRfVAleefoz1DEulKqIh1NHz1g8IE89r9YryqqJD2kKrLVocrmqCEhL0wr07iHJr4zghYxjnTEUT4zk7oJ1H3akvp2pWKjwfDFftNENZX1LS3NusODT/l8On/F4xGWDikB0stFGnM+Wo7Mtpvif2a4r1ggOM85iJ/esfXb90+SDbxtazKzg3bYTT2LhA6PEyjJqNa9Uu+MMCSTn5TV4HxNcO5st/ErIxeeQH3LooQjDD0wguAId/YSLvkh+1QPlcTvJaALEvgTkACGMYC2dcAz6Pc4FDChov09EPXgeKfYsfbYxoU+DlFuCInI9IqCzcGOY3ay6EAhl59sU42Fw2ix02+Y/wenW/hUtz4FvNzblTcMRXtEsQLSx7fLbYR82ce9eNQLc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(55112099003)(11063799006)(56012099006)(10067099003)(261022105027099003)(261026121527099003)(261026140227099003)(261022115727099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022075727099003)(261102123227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTEvT2pmK3pQVUc4N3RuNDc5cUIvd2NjNXJUbVBuVVlRcFVjU3ZheDVwREp1?=
 =?utf-8?B?djg2Y0M4aXpsRDhyZWNTaG9PdVVEYU1QN2l0TDluT2VkbC8wQWdvSG5Celcy?=
 =?utf-8?B?UFdlbm5UdU1NRGcrcVhoN0ZIdHlLdmN3SGE2TkZ0RnhxM2ZhbER3aWZlNWNJ?=
 =?utf-8?B?dVNBVlV4bG93Q3VrUHNZM1N1d0NyRXVwd29lY0xmcU55UWpERkt0YVJMMFRl?=
 =?utf-8?B?QmpheDZMNWhmbzg4OTFRU0NUVFovNi9VY0UvM2tqQllrWnhOK256VklSL3Fw?=
 =?utf-8?B?QTNjWEszeGlhYVZZNG85RXg0d3VFWDEzMzUvNGJTWXN2amorQWxYcFRmOXNQ?=
 =?utf-8?B?Q2lJOXRaQlFrRWkrc3EwNFhDN21LRitKbUNqMERLRjZQdzRIR3lDVDJsTHRu?=
 =?utf-8?B?YzlxRjJHK2xvbWhqcDRpOGFIRklnSFNjMHVxK1pFTDFYMzhFQ3AzU3ZEckVK?=
 =?utf-8?B?MG10ME5HeTJickJzUURRMHBCMElQSDRiak5RUTBSYWVVZ1IwdkVla2VZSWxT?=
 =?utf-8?B?RGZIMTFqSi9xYXB1WDdmTTBRc2xJeVhHSjk4RXNZbHRZY21aejVEMVdOYUpW?=
 =?utf-8?B?Nkt5VjRUUDVpOCtGSk55MWwyOUFtK1FTY2pob2wzR280QkdGWVROcFB6bkxQ?=
 =?utf-8?B?a09zTmphT0t5R3p6b2JMSng5dHVoZ2EwamRYNDAzOGxpOFZ6VmJRbmpublpZ?=
 =?utf-8?B?dEV0SVdEMjRSd3EzeEl3M0lBOHNVNiszT1lsUTJnRDlBck0vbjRqOEFTOTFk?=
 =?utf-8?B?ckdBb1hoVUtMeVJPWnNHbFNvdW1QbklLeGplTUFWTjlZNmhveU9VbWFRQ3Fk?=
 =?utf-8?B?MVNLQTNjNXQzMlE1MVdRb09iOThhTlRPVnowRjRtaWpobU5XYWR2SFAwTFlF?=
 =?utf-8?B?bFJLZnNBZFdQZ0RjeDBQazlhdXZQdUZ1aDcxa3JKQURKYWErZFFORUZkL0hk?=
 =?utf-8?B?YTBJcGFIRFZHZTh4YTV6UzROY2xqTnNoOWdPdzI3dXU1Znp2QmZkMWxub3hr?=
 =?utf-8?B?TnhpSVU0K0FhQU9xRDRLM3NqS0hjNW1yU3lieStuSHRrdUxBMUh3WENtaEVY?=
 =?utf-8?B?WXFjZis2TGZxUEYwa2ltUDVZbWVUQkxsVytCYWtCWHJMeHJZTzk1UjhNMGRu?=
 =?utf-8?B?K25JNWs1Tm15Q0ZqSDV5cUxVeUNkYlNCbkJITnk1dGlLN0RCV3pXbWVtNm92?=
 =?utf-8?B?cDhLRFo4N2RabFhGWm0rb2tqR21EK3QwRldYYUZSa1dPWS9kZFhhTUc0TFUr?=
 =?utf-8?B?NXhlMnRNRXhXUTVidEEzSUM5UCtDQm0wZW9IMXhpYjZabTR3c0pXdDFESVNC?=
 =?utf-8?B?MmdPV01mNHlFVS9nNXQ1dkl6bXJIVmZ5NWxHbjB5RXNieUE0bENtR0J3bDh4?=
 =?utf-8?B?b3BueXlmSU5ORG0zczUwMWpJSnEwbUN0WEwvOFI3dHM5UGVlalBuOTNMb1da?=
 =?utf-8?B?NjRjTGNjQ0xGWTJ6cElDS2ZDQWRXNjRJV3JuUVM4Vm0vaFNYMTI1Zk54c2tr?=
 =?utf-8?B?MTNXV1Bpc1JNbjVFdjNSN0NmMXpyOFNYc0hicHdRWEx0RDdoS1d6VTdIWWxR?=
 =?utf-8?B?RitydHBoNDNYT2Z1ZXVKYnBxNDJEb1V0K0l1TjVQSXg4K2thZmpCQW9qRWpL?=
 =?utf-8?B?MXhpZWppQUdNamEvZWxKMTJzWGtDTUpuMnowMDF0NktBcXF4MFdXbDJ0dUdT?=
 =?utf-8?B?ejc2ZFR2WlhNVWdIamZQcWlhTUR2UjdHZ1RDSm9RaDBYdTlXOUkyeVByZVRH?=
 =?utf-8?B?ekhWcWJodzB4QUtuaGM4M1Z1Qm9PSmdndlo3YmR1QTdnNXlaU1BjZGJyeExL?=
 =?utf-8?B?bStqRE5MR3BaYjFxQ252YjdaSWhMbGE1dnlvQmJIT1V5ZWJ4YTd0dEJzSnh6?=
 =?utf-8?B?R1QxUnhua0htcCtPYUlUNU9keTd5bGhuWnd1QlNpNytmajVSenhyOEN4VGln?=
 =?utf-8?B?NzlqbjkwSy9VdHovemZZNHZWQTd4RHpyNDg3Ulk2VnV2MHpkYktvTVNMWU1V?=
 =?utf-8?B?MUdrMHJMS0tud1VxTHpNMjhvb0JHS2NFMzN5Q2ZlK3R6VDNucFFidXo0V0Nk?=
 =?utf-8?B?citKZGJqeGRxR3Uza3FWR1JaOUkvR042S09PY3haaTdlY0loVFVXMUx5RjNl?=
 =?utf-8?B?UGFzZEQ3N25rZXp1QTFpN244dGN0cFcxWUU2MFBlcWtUSkwrV1EwL1BJSmxl?=
 =?utf-8?B?S1g2aVRqbk9mL3ZDVjRDV1J2bEtYZ0pjY2JManRhWlRudVE2QnFpMWNaUDFQ?=
 =?utf-8?B?UitONWovZ2V6a2FqKzlYQzd6M0N0TjVqS2dWWnF5dTh4QnBKZiszUWd2UEFX?=
 =?utf-8?B?ZkIzNzJTcEk5c2J1YjhnV0tQNmhRbDhQZWhNc0t6Y1U0VjJ4UG9ZZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1548a3-d73f-41ab-af23-08df4573812f
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 12:57:30.2489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VttXS26DMDeURilKvYcLAfkuuvGur4U66eT/ymxguTX7ivOmhssknSOY7EQYrLXxqslqpqm3TiGzqHkf4qVNFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3903
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 12:57:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24955

On 18.11.26 13:54, Quirin Gylstorff wrote:
> Only the no-kernel builds and qemu-risc64 require the ext4 build.
> Make wic the default and set ext4 via a kas option.
> 

What would be the benefit? Or is anything broken with the current setup?
Not voting against the chance, just looking for a reasoning in the
commit message.

Jan

> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> 
> This needs an ack from Chris and/or Iwamatsu-san
> 
>  .gitlab-ci.yml                 |  3 ++-
>  conf/machine/qemu-amd64.conf   |  2 +-
>  conf/machine/qemu-arm.conf     |  2 +-
>  conf/machine/qemu-arm64.conf   |  2 +-
>  conf/machine/qemu-riscv64.conf |  2 +-
>  kas/opt/ebg-swu.yml            |  5 -----
>  kas/opt/ext4.yml               | 18 ++++++++++++++++++
>  7 files changed, 24 insertions(+), 10 deletions(-)
>  create mode 100644 kas/opt/ext4.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index bf21e744..b9a2895e 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -71,7 +71,7 @@ default:
>      - if [ "${watchdog}" = "disable" ]; then base_yaml="${base_yaml}:kas/opt/disable-watchdog.yml"; fi
>      - if [ "${security_test}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/security_test.yml"; fi
>      - if [ "${swupdate_version}" = "2022.12" ]; then base_yaml="${base_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
> -    - if [ "${no_kernel}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/no_kernel.yml:kas/opt/targz.yml"; fi
> +    - if [ "${no_kernel}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/no_kernel.yml:kas/opt/targz.yml:kas/opt/ext4.yml"; fi
>      - echo "Building ${base_yaml}"
>      - kas build ${base_yaml}
>      - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_PIPELINE_ID} wic; fi
> @@ -173,6 +173,7 @@ build:qemu-riscv64:
>    variables:
>      target: qemu-riscv64
>      use_rt: disable
> +    extension: ext4
>  
>  build:beaglev-fire:
>    extends:
> diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
> index 748aaa33..09b322b6 100644
> --- a/conf/machine/qemu-amd64.conf
> +++ b/conf/machine/qemu-amd64.conf
> @@ -8,7 +8,7 @@
>  
>  DISTRO_ARCH = "amd64"
>  
> -IMAGE_FSTYPES ?= "ext4"
> +IMAGE_FSTYPES ?= "wic"
>  USE_CIP_KERNEL_CONFIG = "1"
>  
>  PREFERRED_PROVIDER_factory-reset-helper:swupdate = "factory-reset-helper-efi"
> diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
> index e0fe9603..f689a85b 100644
> --- a/conf/machine/qemu-arm.conf
> +++ b/conf/machine/qemu-arm.conf
> @@ -9,7 +9,7 @@
>  
>  DISTRO_ARCH = "armhf"
>  
> -IMAGE_FSTYPES ?= "ext4"
> +IMAGE_FSTYPES ?= "wic"
>  USE_CIP_KERNEL_CONFIG = "1"
>  
>  # watchdog is not yet supported in our QEMU executor for this platform, disable it
> diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
> index 314d1430..24afedfa 100644
> --- a/conf/machine/qemu-arm64.conf
> +++ b/conf/machine/qemu-arm64.conf
> @@ -8,7 +8,7 @@
>  
>  DISTRO_ARCH = "arm64"
>  
> -IMAGE_FSTYPES ?= "ext4"
> +IMAGE_FSTYPES ?= "wic"
>  IMAGE_FSTYPES:append:ftpm-stmm = " qemu-emmc"
>  
>  USE_CIP_KERNEL_CONFIG = "1"
> diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu-riscv64.conf
> index 2158a964..44975e29 100644
> --- a/conf/machine/qemu-riscv64.conf
> +++ b/conf/machine/qemu-riscv64.conf
> @@ -11,7 +11,7 @@
>  
>  DISTRO_ARCH = "riscv64"
>  
> -IMAGE_FSTYPES ?= "ext4"
> +IMAGE_FSTYPES ?= "wic"
>  USE_CIP_KERNEL_CONFIG = "1"
>  
>  # watchdog is not yet supported in our QEMU executor for this platform, disable it
> diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
> index bf540796..e28f523a 100644
> --- a/kas/opt/ebg-swu.yml
> +++ b/kas/opt/ebg-swu.yml
> @@ -30,8 +30,3 @@ local_conf_header:
>      IMAGER_BUILD_DEPS:append:qemu-arm64 = " ${QEMU_ARM64_FIRMWARE}"
>      IMAGER_BUILD_DEPS:append:qemu-arm = " u-boot-qemu-arm"
>      IMAGER_BUILD_DEPS:append:qemu-riscv64 = " opensbi-qemu-riscv64"
> -  drop-ext4-images: |
> -    IMAGE_FSTYPES:remove:qemu-amd64 = "ext4"
> -    IMAGE_FSTYPES:remove:qemu-arm64 = "ext4"
> -    IMAGE_FSTYPES:remove:qemu-arm = "ext4"
> -    IMAGE_FSTYPES:remove:qemu-riscv64 = "ext4"
> diff --git a/kas/opt/ext4.yml b/kas/opt/ext4.yml
> new file mode 100644
> index 00000000..b9a3a80e
> --- /dev/null
> +++ b/kas/opt/ext4.yml
> @@ -0,0 +1,18 @@
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
> +  version: 23
> +
> +local_conf_header:
> +  ext4-image: |
> +    IMAGE_FSTYPES = "ext4"
> +


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
