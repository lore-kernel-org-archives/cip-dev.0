Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9457B109447F
	for <webhook@archiver.kernel.org>; Sat, 21 Mar 2026 14:43:17 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12107.1774104195503513781
 for <cip-dev@lists.cip-project.org>;
 Sat, 21 Mar 2026 07:43:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=R/QSMGz6;
 spf=pass (domain: siemens.com, ip: 52.101.66.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0kCjRlH4fG5rj25FIA+QuNIFW46jfkvyUuZ8ySs3TmpDtxhmuU4IkPvtvGtwUytwvm3yqcMpRN0yhe9FLkcV1d+PQW73cuBL942fR4ImQDH183s0dcnRUl+zTYsJQ+eCVERigm999KrBsswKYpodiHziYKBDiPNtvI4VnUD8PrgaJKIT8aYtEyQSVkeuKWoBET/FyH9Xn4AYyuq/qpOkHG20zOpX8QToHhq9rR7Vt6z6lPsk6UZ83fOucnl4F1etmr1YRU+1vu9hPddmwgJi6ASfuhxhgtA20w1FzPq4+Z8JndvQuRFbJTW0dhzi6orlcKTHJxDe5yq/YKpaB8NeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JV4QfXponXQRH+tapWQTCiYHbQru/MqhDH7SFMaO7hw=;
 b=tO8c0RAb+xIV5/MmIiVRIK12xDH0Sf9FazsvEoDKkh1IPsR0WhdwfHR6PwJ/m4nT1Oeqw/jTgZWXr1dCsg6IMkSCrPC2kE8bZ9qPGupHb/sYt42DHCRo7Kl0zGJEVjPSIMuAj1AmRPVCKdN8buLim9EKCCKrCHzBKNrTYSCvIxtYr+OxWTNYF1rbZSuPa/JAc4KD9vfHYkpLBXUOQQEvulfWqdFGWWokcCidyRI39bjugDzoGXvaBI7aoHnnOxse/7kUynCS6Cq37qlCqec1z+Ro6tXuL+ANDHh3b1M/+nwbLJY8A/J5nv3EihfVF0EEmxgtwBgghs8vaiIdL/EOyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JV4QfXponXQRH+tapWQTCiYHbQru/MqhDH7SFMaO7hw=;
 b=R/QSMGz65/mlRfAvC/ag486LBSETB6GbkpXyjU3mJtOkY7pIHphlpRIgZ2yiiig26TjAYRXG/uFUkV6+TC+mB1MZNsxiFNKh4OI/uUqNmlrS/TLxrVrLJXWILbjkHvb/YA22fkwUafcAfoiqS8dyPvsTk6khMukv0O7KqLJxxKYfv1qiYMUQY60/KYpugT9xrb8QpJozFoYfwFidiyw8JWJjpLYoVy4C3Ltrzxl0tQJI7crx3abOgia+pGqUHb3kdwekJz2zAWOKXXroVXjUG6bq5ztuDdvLPImum2j2DyOz8M/a+nvgyZTF7iFPopYuhilHgV4kk6uU8Re11jIZsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8503.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:442::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Sat, 21 Mar
 2026 14:43:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9723.019; Sat, 21 Mar 2026
 14:43:11 +0000
Message-ID: <ca460c60-093c-49f8-a4b8-11f93d784196@siemens.com>
Date: Sat, 21 Mar 2026 15:43:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] start-qemu: allow more variable injections
To: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260320101020.2534001-1-benedikt.niedermayr@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260320101020.2534001-1-benedikt.niedermayr@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: 7043562e-09a1-4e81-94bc-08de87582cbd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	UbkDN0s+AGkXePOoKMOq9lNvlPCMsPcvLIImDiihrBY5ELOIz9Gl/Z/ubFaF6H14KpxIyr5RIJbvjVTL8C+5sVnWUmUkkgWa1qnyHrZklsJGewM8UH4obvhM5NlVk+H7SszvzXVjOw/BnnnBC/mtiLF064fdLKFKIwkmEShtpQ23qzX0ivlO7bbV1AOdwyb5YoCXE5Mbnr+ZarZJ3r5alSG2Nfkaz0xpv8k5Y5D7di/LvSi+gNKkiz4OmXUg4NqIFtdFYY5e0vVfD8cFnDnqeAaGGPWx8RqVIcyAVyI8FlADQVUP7YlCGFsZzAlwPKBgk76bkXZKGqYhNf2XegzDczWXiPZ7BfzPZ16FWFklM6vmmlRs2PJ3kuyXAwykDDxEzn8VMD4q/kMhU7h4ZbhUneoNcIxdLKZ/f1tFv4etfRTJ1wGe7M/X63QlsCtBnecDdLk0btnXwVJN0k08izyuXfKwyhtQs0wIojKzejEOM6muDKRxlXMCpuTo/Kh6M+mkDvdV7IOka7zloTlKb25Jhkor0VYqDz5FTkHm2yJi+bOdV7HCwuTBElE/j2C4QkpJpGK4D3BTCoRr8C6pbNowiMvzX9E5TmH3UhjtHQAckKfEKQY9lbQAuoV5fo8vg09573D7wl9JFH20sAj2miqPIT+3XB5hWdAhOmNRCi8Q+knDX5c+ibE7vjXP6Papa1WmO/owTW/g/D3Uym/mRNbHqsLgmd+ROiQktzCRZfLhobs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OTJuaTVTZmVyZDJIblRnczdKdk95dk1aS0laSG1sN3BteXZ2b0hlVUU4dFVR?=
 =?utf-8?B?OW8rYmpITHJkb0dCZS9nTmx3RHMzOEkyaEtmeCtKc2VWeUt1cmh1N1BjZGRy?=
 =?utf-8?B?YzE3cHI1M3k4NDZ3S3FIdUdhRkpuMHdlbWNPZjg1ay9DUzlOSmZadkZDcWJH?=
 =?utf-8?B?OHRsOVhONEE0OGUxY3AvZmFRaER5OUlUcWZmN3Z6ei9BSkZvQjh0N0U3R1Aw?=
 =?utf-8?B?ZHRFVmUvUExZZUJON0tiVjBMN0ZyU2VBbmVBMHpwUHR0UmpnK1BGSTNRWndj?=
 =?utf-8?B?MG5JOGI3RFhQYjRRUVVyaVZBU016WVNwbU83QzgyTUNKRjBWSW0rTktQUWw5?=
 =?utf-8?B?M1hRRUovWGpvdFRnckF1Q2FOM1ZTN05lU05sZDZyVXlYRDQ1RXZ1Z1VRVm1K?=
 =?utf-8?B?VThUN2RPaWQzK01zaXNyUGlOdnlidk11L2N5Q2dybGtDRXpjbHNhQTVtSnJC?=
 =?utf-8?B?c2x1MDNzUVI5L1lDbUpSM3dsSGt4aWVlV0tTdzVtRXl6MnlCKzAwalFmd3pN?=
 =?utf-8?B?WitreFBnR2VRbTFWbXZIN2tlOGVPT3Rpd1JaVUYwMFJtVjNsK0hjSEdvWExU?=
 =?utf-8?B?NGxuVDdaaXNEVnlLWVJRcTFuSXhFWm53SW54cWw0WGdvRm1jNi81dmhlQ1VI?=
 =?utf-8?B?M0MyMG5JUTErL0RQeHRFQkUwOGxtclcvcDVyQTA1RU5ZQmRTM1VIdUZWWFdU?=
 =?utf-8?B?ZVdyWnNndzZZdjJESnFDa3hEOStmN2JnZTg1RU4rTGtKY21GaUFaZFZhMnFn?=
 =?utf-8?B?YVNOOFlWdGVYa0ZXbmpydkJXaUFmdVdFWkgrbzNFdlQ5L01HUW1EQWsrSnBn?=
 =?utf-8?B?ZnBPTjNza3RFMURuKzEydFBPTzk1T2xoQ21TclVpekwvWGR4bXp4L1Y0ckgy?=
 =?utf-8?B?MTNkakJSTUFxUGxYUHZPQVg3a01jcFYyMUVYM3FEdkZKZlVoRGxTNTFLRzBZ?=
 =?utf-8?B?aHZwa0pLQVZ1aDNYeHNQWG5MU2ZrcGlYZEdPNld5RTgwT2VLMVU1bURuSTFs?=
 =?utf-8?B?MHVPaUxycWJPdE9nYk5kN20xcFJjOWJGSGtqek9wRThRc1BkMHd5V0Vlekph?=
 =?utf-8?B?alFQbDdCZmpyb0ErcWRqQ2U2L2N2eWNKcGRCVXJRb3Y2R3Job25wVm5MVFBZ?=
 =?utf-8?B?em1aSGc5UTNjaklzOUdqYWpGUXR6WTg1UHFFNmdjRlcvOGNBRE5HdXo0KzNW?=
 =?utf-8?B?RHFQTUZDZHN2S1RMVlFQOUxEdGJPbStKZGxRZ2ZHTjkzR3IyeEFZMklCZDUy?=
 =?utf-8?B?N3ZGc2pLRUp1K282dU1MTkg1QzQ4cW55MUd6K1FwdmloVklwdkczLzRZU2dL?=
 =?utf-8?B?RVM2bXdjbDBnRjhwS1VVa3V0QWEvNmJKR0NSNHZQWVJvVFRlM0liVnI4YS9u?=
 =?utf-8?B?R05GNFFJOHR2SlBMRUVrdnZNU0JVaTZMSHZJU25Zb2lvTjBnSUU4YXFhK3Vs?=
 =?utf-8?B?eVVhbUM5QjE1RjhLWWxrTUIwVjVlRDI4ckxTZFdmdmpsVDZ1aHAvTGJKeUhK?=
 =?utf-8?B?cVpYTEt3anYzNjBJeEFQWXc5NTBmVkRzYW9OUE5PYmtKTUZmbjhVYzExMFNH?=
 =?utf-8?B?bWVxSDlxSUxNYXR4dkQxYTFWaXpwSDlhUGxGRVhkU3Bva3RLSU1nazE3S0lU?=
 =?utf-8?B?N0JxemhzN1R0TkgrRG9MYjRZekRNNmpSNTIwSnNVWTJBeXpVTnphZ3Y1U1J0?=
 =?utf-8?B?ekJkODltMG96elgwNFRUcnNNTE9vcjAvSUxzdlRyRzIyUUxNVTZ3aC9HUklv?=
 =?utf-8?B?NzMwOWw2WG56UG5vbEgzdStoSWRjSVVoSzhySm15YWZxL05DYlVVc0pYekhJ?=
 =?utf-8?B?ZCtmZm0vL2lkTnpYbU1LemZBcy8rSFJWcVlLWUo2RkdnUEhqa09FMFUrTk5m?=
 =?utf-8?B?aUFCTWxwdTNxTXpUVE9QUU5tY2NpMFE3UTIyeHR0MXdxb3NwUjVLWWp5ZVBK?=
 =?utf-8?B?b2YrRlNDdi9yV1NuNWlsQ0Z2NTFIYk1MaWIyTUxhdzFaU3kvcHFCOEo5WTRP?=
 =?utf-8?B?ajlNSXhzMWMzT2RXc2pRcllzVzZBMUp2SjZqUjgyeXg1YlMyTzlMcjdHZklO?=
 =?utf-8?B?VUplcGRzTmMyMHExdjNQYUEvYnpPQ083RU0wK3lBMnFFYXcwL09TR1U1Q25O?=
 =?utf-8?B?aG1sMlFWZDErSTNvNlFpV2M2N0FpRVZIb0hpQW5kT3dVSFdUVVMrWXA5Z1Fz?=
 =?utf-8?B?ODJPTTJKMHNIeFgrbkdOUXFTYzB6clJOS21FYitYU25ZaE90elFqRHFCeWEy?=
 =?utf-8?B?aTZuaGpHdzdSODRlSEROQTRCUTVOL2hPMWFqanVvaGZBQ3RESllRWExENFVP?=
 =?utf-8?B?Y3ZMbUkzQ2d4a3FJR1gvSitqYmsxc2F6dGIvamFzalBGUWpCRkxlUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7043562e-09a1-4e81-94bc-08de87582cbd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 14:43:11.5915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLFs5nmwod5SFEdHAmPTKKvcC/5RwXrVi8N8IhGAGIZCwgp46XTJH/3EXQrJJYAq6/cR84lvnEfGr1w9xOdObA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8503
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 21 Mar 2026 14:43:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22519

On 20.03.26 11:10, Benedikt Niedermayr wrote:
> This allows to inject specific variables into the script so a local kas
> menu run isn't mandatory anymore and thus it could be reused in
> different environments by adjusting related environment variables only.
> 
> Currently the script parses the .config.yaml which is only available
> after running kas menu locally. In cases the isar-cip-core is included into
> custom layers where it mostly happens that the kas menu of the
> including custom layer is called rather than kas menu of isar-cip-core,
> (in some cases the including custom layer doesn't use kas menu at all)
> one might still want to reuse the start-qemu.sh script.
> 
> This patch specifically allows to inject the BASE_DIR and FTPM_STMM variables
> via environment variables from now on.
> 

Did you check what is left afterwards? Would be good the solve things
completely, rather then adding another layer on top later on.

Please also document the variables under usage().

> Signed-off-by: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
> ---
>  start-qemu.sh | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/start-qemu.sh b/start-qemu.sh
> index 7ccbefeb5f47..5a0924257b37 100755
> --- a/start-qemu.sh
> +++ b/start-qemu.sh
> @@ -80,8 +80,12 @@ else
>  	fi
>  fi
>  
> +if grep -s -q "FTPM_STMM: true" .config.yaml; then
> +	FTPM_STMM="true"
> +fi
> +
>  if grep -s -q "IMAGE_DATA_ENCRYPTION: true" .config.yaml && \
> -   ! grep -s -q "FTPM_STMM: true" .config.yaml; then
> +   [ -z "${FTPM_STMM}" ] ; then
>  	case "${arch}" in
>  		x86|x86_64|amd64)
>  			TPM2_DEVICE="tpm-tis"
> @@ -124,7 +128,7 @@ case "${arch}" in
>  			-device virtio-serial-device \
>  			-device virtconsole,chardev=con -chardev vc,id=con \
>  			-device virtio-net-device,netdev=net"
> -		if grep -s -q "FTPM_STMM: true" .config.yaml; then
> +		if [ -n "${FTPM_STMM}" ]; then
>  			QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} \
>  				-machine virt,secure=on \
>  				-device sdhci-pci -device emmc,drive=disk,rpmb-partition-size=2097152 \
> @@ -175,7 +179,8 @@ case "${arch}" in
>  		;;
>  esac
>  
> -BASE_DIR=$(readlink -f $(dirname $0))
> +BASE_DIR_DEFAULT=$(readlink -f $(dirname $0))
> +BASE_DIR=${BASE_DIR:-$BASE_DIR_DEFAULT}
>  IMAGE_PREFIX="${BASE_DIR}/build/tmp/deploy/images/qemu-${QEMU_ARCH}/${TARGET_IMAGE}-cip-core-${DISTRO_RELEASE}-qemu-${QEMU_ARCH}${TEST_IMAGE}"
>  
>  if [ -z "${DISPLAY}" ]; then

Wouldn't it make more sense to export IMAGE_PREFIX? A downstream layer
may have a completely different image name.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

