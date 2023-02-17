Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F7EC6379F
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 14:49:54 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.69])
 by mx.groups.io with SMTP id smtpd.web10.8073.1676645391604296395
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Feb 2023 06:49:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uzTiJMCC;
 spf=pass (domain: siemens.com, ip: 40.107.20.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmOsLfCeW7uFjBaS+L9K3fka10jGlZr+MVoshGUR2kF8qIGbvywjSQTBC+RFxizKJPXrCK8MBrmr+4iFqlOT4WpmVxqo773aye/ri1Qi3dZ4usIH+Vc1E4BqQRYV24qgYkNBBS5lv20x/wJGOc4wKgu4pS56k4tUV5BicPwDbEUO0WUT5kFe9KxgYdKjHanfwO0qA5bl9pomX1opEKdFF5ZsqE/AzTda849/dZlpffDdy+ytE0Fu1cuiMmUNKcobh9G+HQJ+ThR4lu5jD40T+672VSSUnmv7yCigRZNu24PAyCsxruOIaDHspdDlH4U+cgNOZuUt2YGzyxDaN9f92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+t1qHP+bycLzAuaLGmJ9Vrc5Dkif5+O7KrVZVq0OxjQ=;
 b=Ruq5FntP42iIwnkFG7b3R5v+kpuolRursVOjAfACJ7s3mEf5cN/slIebKuBIp2Fc37YNat292aIde5577bvTuTTE2YBI494dfsXU+1H9J4SM8ZcG9n7aspoZ2XSHTiGwoSb9pkRrpujjVlCIBKWr6znSJJV40t24uAjn8xAr/DGfEtrDsvvfkhiBZkq3NAPjXij5oD5S1bALfbrqvfcDp8aHmsaTRTR5Qq6A7/7tqOApuGccVd2p5TfmtL1u8yh41OObG6k9JvlncWEZnGaWazpYCkhRS57s72ZV+Tq2+54AaMP/YboVQIgny+ZfxukIwWDC/btYs51QSKYiOfY0uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+t1qHP+bycLzAuaLGmJ9Vrc5Dkif5+O7KrVZVq0OxjQ=;
 b=uzTiJMCCjxMrDBxh5ou/Me5rtSZWAcKhEV+tLFki3dthk9n/3Bab5KKhYSeR7x6N2FvqeI8XRy0aB2HBPHeNjzcz9UTRoVKfz5kIxtrUGjGmitONqAQ/wp3QHvXNABiQNqYBnV0TXMHv3ndFRUBP42vBLQBdqEojSKKuqd02TC6LPEau+c8KBxe0WvrQn0Iz/0aogyQksjdurAMxvuCcYyMqOkJJJ49z6i9V62CtVDw9qbaeblvZvLDz+AQt5svOPFRIsFwheP1sJPZ8oGplQAoB3NXquXe0JrfhxA3vp+2OOHZtVnWr0R1meHaOMV3rc7Jk+h+Cz2tqEZEHnUkuag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7642.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:631::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 14:49:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.026; Fri, 17 Feb 2023
 14:49:49 +0000
Message-ID: <6fca94a3-1350-872c-ce6e-dd93abef654e@siemens.com>
Date: Fri, 17 Feb 2023 15:49:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [cip-dev][isar-cip-core][RFC v2 3/7] start-qemu: If swtpm is
 available create a tpm2 device
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, christian.storm@siemens.com
References: <20230217130540.509910-1-Quirin.Gylstorff@siemens.com>
 <20230217130540.509910-4-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230217130540.509910-4-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0272.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c57b85-3f18-4d47-af1a-08db10f637c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	q02B67PuyfGiXStlkJBR7NxKs0/P+6EN++TZVNMMpR7VG/a+bJiHSoBGH54qdh9xebVnQ+qurTx5S1/wiyJU/5JE8sB0ofIKUodY6OhL6QxTrD+FsCnyHfK7O1c1buV9ZbrUxV852Ld2dgAGco/1c+Uci09vvcBMMd6Z04VsOR/2IOr6uhw/NixySTFYbhjEHJDc/HsPLI3jjIV+rWw1u492Cl75VRzdIuXQ+vvwKEvRSQDLd0eyS4ECGqpg6MaS7i9CwYSQlXhfeK2kFRL+X3Xrs8fM7jtEDSIa/mR5BHPeeUaq4bMIi9FNXmctHcMB2fbBY4bySDA48PVYUPO1eHQdZp9Lx7zrwfiAGCw4BYIwPAwP661cab68bCgXonqz4ryL34ZfLW1RpuemjYza5iQgCgQ+MUfq3ZbNVLy7bNf+pOLZt/bAHFQt7j0iXYHQ+PObemjMxZV0AqsYqknmFPveGd5lzbXWKKeF72G0OEHpDEt9gtDM4ekOSN7rcuaYIm+lNNjTfsjNKl4DX12ny1+NG7TmaCjpmPKEGuzPCVkdYVYWjriGovlRP43Xar7iufRZ898P/9LAI9kBN8/dTGUgaTvj7qSiTSduZ8Qt7TlwtQ6PHSWuODrC2AuZqDuH6tj9LmUyeHERCwh5kgpPMEkeV3JOxAjsGkATAkLLSmqIs/MGAAkuq1ljsH5CFX+DVwIcU5GWyXhbUqR3iAguE6duh7UL49IDJbARLqJGd4M=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199018)(2906002)(44832011)(31696002)(86362001)(83380400001)(36756003)(2616005)(82960400001)(66556008)(8676002)(66476007)(316002)(6636002)(41300700001)(5660300002)(8936002)(66946007)(38100700002)(53546011)(26005)(6666004)(6512007)(186003)(6506007)(478600001)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MFhIeGk1VzF6K0xiVk93Z0l2NEg2Z2ZDRWp4N3J5ZkZ2ZTNHKzBGdXAxUUhV?=
 =?utf-8?B?ck1WcWdzWHNrVlFZRWl0cU1IaXdXSXRGckNvcjl3d2k0TmN4SzlyN0VkSUtP?=
 =?utf-8?B?NW5NenNLWDZ0NDR4OWh5SzA4K3RWTUdaa2ZPajhDZERONTg2bDg4Z2o0K0Qx?=
 =?utf-8?B?dUY5SGcvenI0NHlWTVNXUHBlQnh5Yk5WajhoanlQcDRrSHlsL1pDUEZNK1Ns?=
 =?utf-8?B?dnU1Zi9jMTBhalBGMVFudXhzS3Nrc3IvY0ZBaWp6b2tNN2tGb0IwaUU0ZGVK?=
 =?utf-8?B?b2YwUHNsZ2t1MmJ2V1RRUTFPMTIycEFGT0w0UXlSaVV4ZlRBMWw0cnRKd3Nt?=
 =?utf-8?B?VGU3RWtCWUVlZmVFYlZJd01HY2tmd3NkeTNPeERQVE5UQkhTeHo3ejdnbEI4?=
 =?utf-8?B?dXJRazl3ZFBMQThES3h0L2hPMGtUK2tsN2JTaDU2YXpiQStkcGUvVHVFOEFm?=
 =?utf-8?B?SGhBdTBlTFdVVENaRVFOKzJ6RkpUc29yUHIrbllUK296ZlRXZERTYTlNSWxX?=
 =?utf-8?B?YzRQMmhxUDZtWUxJTXpneVlNdyt4MFMxdWNnczd0VW1vU0g5aVBQL1FYbW9X?=
 =?utf-8?B?ZEV3SEI4ZlVtaWowRW0rdTNHOGxYbWF3M0xZSDFhVlFJVjJmRjdKN0VMZXRh?=
 =?utf-8?B?QWJiVU8zRG5DMmlhQk50NE9RRUdvZFFFVjdJMjhnZzRRTmRHZ25JQXpVcjh6?=
 =?utf-8?B?REZoU1dhQ3BMZmZjcE44RStnS3pIajRHcDliZEZuelA1d1lSQmFxcnZmODdP?=
 =?utf-8?B?OUNmd0JmNGltOWxsTjNQQzBSMTR2NFREZm1kdkZaUW8xbUQ5WERscC9NNnR2?=
 =?utf-8?B?b0dvWkVmcElISERzSUVKdE1tUEs2WnVCbUc2MjF3K0JNUjF4UnJmT2RiWnNj?=
 =?utf-8?B?K1NHOUdicEVESFBveFErclFySzNQQ0MvVHFZNi9ocG5pZlNOcjczKzB4QzZq?=
 =?utf-8?B?ZW9EYndnZXhlcktsSldsNVJ5MkltV20wZ0JwZFRFY2dJcm5IblN0WHgrRFFD?=
 =?utf-8?B?N1lSWGxqTHVTc2VESGFIVEFoM2cvbitNbkZUZ0FGTFc2OW5pV1NPcFgvL3lv?=
 =?utf-8?B?eU9OSWltUEhDS25lY01DMU9xVzJzY3RudnJOaTIwT3hIYldaVmJjRi9wZVBl?=
 =?utf-8?B?RVAvOWlMUXBudzAvZXBqcWgza05EZ2xoSzhZL0t2emswUjBQZlBMaUxrSGtV?=
 =?utf-8?B?dWhKVVh1SjByRGhzay9wYUJXYVU2eDlkZDJXaEtnTnZCbWN4SzJ5ckczc3hq?=
 =?utf-8?B?Y1hkai9WY0crL2lIQ014WkxMUXVHV0dtd3I4VTFNZTRrNUZ2a1BYSnNYZDVW?=
 =?utf-8?B?aDhBM3phcktKbG1HSksxZmVYSkwwSmNYQVB6VnhCQlQzWHVXOGRMTCs1dTll?=
 =?utf-8?B?c2RaT24xa05Hdm9lL1pnalhwdTBFcFUvR0dZUURIOVA1SnM4ZGVTWDNHWHBa?=
 =?utf-8?B?Mzk0bXpOOTFrNGRqOEV5b2hnVHlxTENkZW5KeXFMQ0JYcEV1aEEySXZxQytk?=
 =?utf-8?B?KzNUVHd2TzhyY0YzTlRyQzMvem54Ykl1RUFuc0E2K3B5eXJGRCtZMS9jd1Zp?=
 =?utf-8?B?LytORzZQT0Rzd0NuN0NOYUNCU0lzY1FXZ1ByT3cyTWh4Z0hoM0ZYbUdLMFhR?=
 =?utf-8?B?OTRhdXdQNEVER0ltL2hXYjJTcjR2MGZqc21rRTlvY0hlaVJjcXZkOXVJMGJQ?=
 =?utf-8?B?Uk4wQkJ6T3lSZ2RwUkR4OUowcnRyY0ZqeU1BM3JTZEVJWEd6ZUMvbTgyTXBQ?=
 =?utf-8?B?dDVkUGFSMjV0UUM0Ny9BU3N6eHdCeldkVmpCTENiTWhaUmVmNVZwQ1pib1lU?=
 =?utf-8?B?c1dXY3J4ci9FR3NhSVljeGZacVV4MzE5YTYzVjFOdC82MjJtTzU1czJWbDNj?=
 =?utf-8?B?K2xMbzFDTy9YUFJxMjY3YTZKcXlOMFVTYTJrNVpkeWhUYzB5MnBqTkphQkZl?=
 =?utf-8?B?NnZPRkJ6K2NXeVZaNUNFWmFSNG9XcjhRYkd2ZytGV1M2OVl3cWlkQXJ2bi9x?=
 =?utf-8?B?OVNwVEdWRFlYTHU2SG1UNDhkRmloalF5YnZkVWRvTTh4eFkxeDl2Q0NIbFVH?=
 =?utf-8?B?N1ZTUC92VGdNTlJkYVZMMkZSczZtc1RtWDRMeGlYRlRGTSszeXNvbnpLcHBR?=
 =?utf-8?B?aFpOU3pVVXNOdHhGSkswNEJSY0dBVHF1ejl4Mkh3OWhDQkg0dm1CU211QjZG?=
 =?utf-8?B?NHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c57b85-3f18-4d47-af1a-08db10f637c9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:49:48.7958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vucMIDUJ0ZdlyNGTl8RHPW8domcyN/aJ/0KoLwjVAzRwzYZd2aESv8HIlS3uA6mUdltP7wvwlsInC8qf52b1PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7642
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Feb 2023 14:49:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10722

On 17.02.23 14:05, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows testing the tpm2 encryption with qemu.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  start-qemu.sh | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/start-qemu.sh b/start-qemu.sh
> index dd16aed..3ef2acc 100755
> --- a/start-qemu.sh
> +++ b/start-qemu.sh
> @@ -139,11 +139,24 @@ QEMU_COMMON_OPTIONS=" \
>  	-m 1G \
>  	-serial mon:stdio \
>  	-netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 \
> -	${QEMU_EXTRA_ARGS}"
> +	"
>  
>  if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
>  	case "${arch}" in
>  		x86|x86_64|amd64)
> +			if [ -x /usr/bin/swtpm ]; then
> +				swtpm_dir="/tmp/qemu-swtpm"
> +				mkdir -p ${swtpm_dir}
> +                rm ${swtpm_dir}/*
> +				if swtpm socket -d --tpmstate dir=${swtpm_dir} \
> +						 --ctrl type=unixio,path=${swtpm_dir}/sock \
> +						 --tpm2; then
> +					QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} \
> +                            -chardev socket,id=chrtpm,path=${swtpm_dir}/sock \
> +					 		-tpmdev emulator,id=tpm0,chardev=chrtpm \
> +					 		-device tpm-tis,tpmdev=tpm0"
> +				fi
> +			fi

There are some space-based indentions in this block, messing things up
visually.

Jan

>  			if [ -n "${SECURE_BOOT}" ]; then
>  				ovmf_code=${OVMF_CODE:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE_4M.secboot.fd}
>  				ovmf_vars=${OVMF_VARS:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_VARS_4M.snakeoil.fd}
> @@ -154,14 +167,14 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
>  					-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
>  					-drive if=pflash,format=raw,file=${ovmf_vars} \
>  					-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
> -					${QEMU_COMMON_OPTIONS} "$@"
> +					${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
>  			else
>  				ovmf_code=${OVMF_CODE:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE_4M.fd}
>  
>  				${QEMU_PATH}${QEMU} \
>  					-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
>  					-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
> -					${QEMU_COMMON_OPTIONS} "$@"
> +					${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
>  			fi
>  			;;
>  		arm64|aarch64|arm|armhf)
> @@ -170,7 +183,7 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
>  			${QEMU_PATH}${QEMU} \
>  				-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
>  				-bios ${u_boot_bin} \
> -				${QEMU_COMMON_OPTIONS} "$@"
> +				${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
>  			;;
>  		*)
>  			echo "Unsupported architecture: ${arch}"
> @@ -187,5 +200,5 @@ else
>  			-drive file=${IMAGE_FILE},discard=unmap,if=none,id=disk,format=raw \
>  			-kernel ${KERNEL_FILE} -append "${KERNEL_CMDLINE}" \
>  			-initrd ${INITRD_FILE} \
> -			${QEMU_COMMON_OPTIONS} "$@"
> +			${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
>  fi

-- 
Siemens AG, Technology
Competence Center Embedded Linux


