Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC58EC61DA4
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 07:08:42 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.44])
 by mx.groups.io with SMTP id smtpd.web10.13892.1678691319321850945
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Mar 2023 00:08:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vnKky2UG;
 spf=pass (domain: siemens.com, ip: 40.107.13.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAiXTgsWCzCZ944HojY4h0SspCRQYSWh0JND+gCz+avADEJijTwvOWrHW3w97P6S35t0avrCREGE0QYMgVhoqOxGmsr4rs+8arKjHURMULj4YrXCoz7FehXcqaUXkyJWApXKOCyzKQ8UYt6YMKiufj9s6TiAGliPXTWTRa4MoY9XKynlCq3aXf0yNXgyruSJFKM8hmZxFYV1FMhdKaeT/C3ZxponLMpgfYNbX2B5gGrIn/AlyCq+GubZW33RJ405WVT6Yhvzjm3SQnYePNtXv4wL4gPzjBoPhcQ2ndekOaqUuF1PTDl8e2QsgmXCyP0yklolwLphNJr8uy2HEkUjgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OI96iTb25+gv/UrRld+hJpEwvcq747LnopyCs6SU2TY=;
 b=D3qhkhhwaHC/CeZ833u/vKAL399QInC5ixHAZTied8UAvw0hGQc73gtglwvyeKP0jTMCSUZoUrw299v2dnG/M4tSx9ykTkicBkzg6xfTiHsSnKJm8nuUuPYxKg472oRNPAVZDb2WE+8ZuNZdDq1yqraZpty+MKhVec1O8Pvw0FfQap+J5yx/A7jthtLvGbmcAN5jFFDJT91i5PUnyRsVYVD4d+3+vtPuTUSwTG1yECxZVeFRFIDUOXlYArQwY5X/fauUZnEgFIizXSBi/nLuIWCs78x3PhWyLezAhnec9CQ68crNGCE0MJChHZEnVVq6B8sEM9mAeuQwh9GIX8/pgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OI96iTb25+gv/UrRld+hJpEwvcq747LnopyCs6SU2TY=;
 b=vnKky2UGBemaNpv4GsvVIxw6x7PjX3FGthHa8QAT2vtF5rHdurn+wvJyqDslMY+Z+BIm9YpoPOKpEr56QO2VcZaqqEQcAjFZQu/3ML+BYVpkjGZpNb++0P7oXtiE6Vt8dEqpTiZMisnzxfgIxiSR+nk/Rbw8OPoFDFfuPYVN0FGIcebjYoX/BqRUIah9kTy8X66Ms5UbxGpzaAA+Uuq2h9FI6y8UCqIvlq+eSZQRcW4NjsrsN3znRCLR3l8zGS1oVi9ZKhFZhnpM2Bzc9hewv/54yTedsOhD/BsdDnDxupfXy2S4wFX09ALLVgSQvkBCFCe0FXaIxXF/ZO03p5PNbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:451::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 07:08:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 07:08:35 +0000
Message-ID: <7f82c0c5-bd5d-09fb-3a9b-ed6c7237f74e@siemens.com>
Date: Mon, 13 Mar 2023 08:08:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v6 3/7] start-qemu.sh: Create a
 tpm2 device
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, christian.storm@siemens.com
References: <20230309102821.307140-1-Quirin.Gylstorff@siemens.com>
 <20230309102821.307140-4-Quirin.Gylstorff@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230309102821.307140-4-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c075dfd-90e7-487b-5cd3-08db2391c2df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	35nVhKItyWNad+YLdyk1OThWPBm7eTbreSlBeKWNukVnikqAMevvm0QnHClgpwpaD8Uug2WkWP4RZ3jCXlAiLf1g8KHAX7Vp7vtey33fBbtheBBYZDMC0NLFf6imr6wERWWMW5KVlQkunFb+Z4zrGVCpaYZvTC0ksRkBDwKwT37WSCzZiBMB3DTFn+fJyqd/dx10Ox+Nd+dYeCTj7x2A2Ep6jOCN+rfIJNI5rPgslIAla/bXOMHVOBFeBvLdlvcCr3sKnM5HS9G+rRGdfoZBUpWzknTxcBsECv+sa02KUtKtloHxC7tSHmiTyFJngcUeNQPz9oOS2E6GyuEqc2Ubk3RpAuTws66N4jwbYEuB5QrK/FbasgCs1PeK6mDhEh6kq1+9PreExhEprNGBlvBDZpJp4ecuLF/nnNZLXIK+jbuzR3gBh2G6o0JNKDKuElY6s24eKOJrbSlR6R5hSCOKJQJXJt38eL3uNPOONVEP6Ici9H0TnjNFVDujW8vUaN3SqA0KL8VgB7iAI2r8bbxon3k+XoYfP4xWLUJyNaxcufE3jjh5z/t7+1vdAbNxq5RbD5M7SgqrGOlNTgXnBr+fNHvlwobF0JAwF9RNBvLICiVlnCJYJIu62iZsZJuSVJArQ1HS+rmDfXYbrBCHMlCpPPh6FPU2zq75YGbMhQSOpwCJosPH2tVZCOYPw/L8LpzxAktOs7AaFpeEIWIYk+KODATEsrEYHATALkZK9ektyOc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199018)(31686004)(6636002)(41300700001)(478600001)(8936002)(66476007)(8676002)(66556008)(66946007)(31696002)(36756003)(86362001)(316002)(38100700002)(82960400001)(6512007)(6506007)(186003)(26005)(6666004)(53546011)(5660300002)(44832011)(2906002)(83380400001)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OGdVdU04QTk0TWp6UVN3OGFCNzBqOFoyWUZVR3FBTUx5bnRIYk1YeHlMbk9V?=
 =?utf-8?B?ZGFRcTZwTHJkMkE3TkFiZ25NS2w0SUEwaTMrZDZ3Z1ZaVlptMVFnbklNWXF4?=
 =?utf-8?B?RElFQmpUak1aZDQ1MlMrdWhrcE1aYmIzOU5aUWZ3TDQ2STBsN1M2d05aaC9z?=
 =?utf-8?B?cW1oMUV2Nk5vMEp1WWpHaXEwT29JTmVCOGFLcnNZNDJvckhMQnJyZWlQdjlw?=
 =?utf-8?B?ejFVYlo0K0tkNkU1STRkK3FrKzFPZDdHRHB3dXBYZllHME5qbkxqZloyUTJJ?=
 =?utf-8?B?TFkwekxCbFpYaWg1aDZIUGlHMW1PN3A2RTBGbmUzZXl6S2dvZHJNbGZOcGV6?=
 =?utf-8?B?c04vUHczMVBuUEs0QnJxUGIxczU0ZWpvNU9QRnhmMW9ZSytLT1FjUnJiOXdz?=
 =?utf-8?B?TW1VekYxeGdkcXR1QU5VVWZQT2puZGhGVTJFUGFTUUp1TE5SL2ROYVYvR3V4?=
 =?utf-8?B?K1BQN3VvbjdiOHJCNW1QS0JiQy9yMnhjeEVKSFJHclBKRGxWTFNmTitzUDJu?=
 =?utf-8?B?dE1tRWZ6U0ZROG1KQk52VnhNcGNPbHVPMklaOGRGcGdJQ1RrTnEzUTdJbWU1?=
 =?utf-8?B?ajdFRjRveEhYRmFDL29hTGQ5SEt3UzBvN2krK2Vua29uS2s3RVgrM0tWWjlq?=
 =?utf-8?B?YjJBM29pRWdVK094dkZDY2VKdCs3MzhtTVJOTmpXUldxTE1oY0FxVk9EYWRQ?=
 =?utf-8?B?R0NwWW9OckhQQlNPdGR6SnhyMXFkSWJKVVErYTNVY2UxMXE0YklPM3l3d2sv?=
 =?utf-8?B?aW1yTUZRZ3FEc0wrMEp0RDlKdlhRYjR6ZlJKMWdzM3JnblZndDlwbVY3czZs?=
 =?utf-8?B?cjVndmlwR3UzSmZzOEtyZmt3bEpodDVxVHY2aW8yRHBpSTRORUtDS08yWTNp?=
 =?utf-8?B?dm9GZkxYTUkrS29LeGh4OWVncWRCRkVITmFvKzVZTjNHcjE4MGpDNmtscEJT?=
 =?utf-8?B?aXhFWWNVUklqZ1pFZkFYVGRzWW9QN3BLTlJDdTBSNHlyVTE3VU13Ymd5RVl0?=
 =?utf-8?B?V28xOGtTYWFQekpRMFJRR2IvMldrbFJKSSsyYm9NRWZlcHo5QjJIb01NK1h4?=
 =?utf-8?B?NmdCamtoZFJUSXF0OElnbWFIVHA3MEZtQlJUYkxoNmFHVnhpVHArdzVocVJz?=
 =?utf-8?B?QjBLTVpXRmpNc1NvRldpZHdPTFZMejdLcndmTm1xTVpZS2hpOTZudVhLMnNE?=
 =?utf-8?B?ZmViWHpzUnBGZUpBQUNNQXlHMTBJYzZnaFRwaGliSDRJTGJZbFJNVXN0R29V?=
 =?utf-8?B?Ti9KZTZjTHpvK0cvK2kyNW8rVWJXckFjdnRlYXhpcCtVejdLS2VEWm9nU3R5?=
 =?utf-8?B?dS9id2g1RUNGdUh6L1AwS0FKUVBWTk9YUCtVbmU3L3hrVjg5Q1h4Q3NQV05N?=
 =?utf-8?B?dkV1WnlhbHFEbkdjQ3dSMWt3NEgrVXo0TENxYmdiV2E1bzYvV0RocDU1QjRl?=
 =?utf-8?B?STByM2t1cUNOYjdzeUY0OWdtaXJDUGozSEhLLzRXZE83T0x0cG5Bdm8wN1dP?=
 =?utf-8?B?MWFUME1VOEpYVGpxeWNKYTR6TVhwYksyTm1US0F5RVozbDZjSk1LWXJIN2Fv?=
 =?utf-8?B?V1JkZXBLRUxYSytVdm8yL0VrR1NQdFJ6SmU1S2QrTkEzZ2xTRzc5YXY0emVv?=
 =?utf-8?B?WHI5czhCZ2E5MnBEazJadWEzeU9SOEFVUnk1OFAzZkRuTDZFZ1NVZTNJSnVi?=
 =?utf-8?B?b2phZ0lpNjFZejhKZW9BeTl0Nmw4VDV2SHVMb3dCMkduak1lZzMzRVB3amR6?=
 =?utf-8?B?bnNSUXZDVHlGLzdUVllMUEM2ZzRjekhzdUUvdHExNHQ1ZXU4blhSWURkTjll?=
 =?utf-8?B?RDRIRk1EVUw1Rmd5RldKejV3Q1BRRGJ5SVpHcjlpdHRBYW01T3BFa1haaGhF?=
 =?utf-8?B?N0Q0cW1MNnduaS96bnp3cE8vYmdXdkptb3kwR0l5MnJSaVNWdjFMdFJ6N05q?=
 =?utf-8?B?bUxJcVZuSDlqNFV4VDlqWXZvOTZBZVgwbmlRSEp2UGFtWnN2ZGcxRFRDSTFP?=
 =?utf-8?B?K2NXb3d4VVc0dFEzazBUU20wQUU1Um1kMDR2ZWYyWU5uL3I0UDl0Q3B5NlNR?=
 =?utf-8?B?RlpVYThJSW5TQlJSaHZZbGdlT2p1UGcwMWZwSDJWWGFYTnhTKzRMSDhtUEs1?=
 =?utf-8?B?OE9CYlVqWkRmV0xLZUxUc25BcTdiZVdlZ1lEMGRiUW4zM2tVZm9oMlB3aXlO?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c075dfd-90e7-487b-5cd3-08db2391c2df
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 07:08:35.2517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyjX3S+nAdIZLwn6UAXYCPfLvncZ0oz1KbTve5U8QwnjJ9PTRs9Bb6mNF/zlgJSKIg2n6AiFbi3DWCBkA5nYKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7172
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Mar 2023 07:08:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10992

On 09.03.23 11:28, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows testing the partition encryption with qemu.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  start-qemu.sh | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/start-qemu.sh b/start-qemu.sh
> index fcfbc5b..b46b066 100755
> --- a/start-qemu.sh
> +++ b/start-qemu.sh
> @@ -28,6 +28,9 @@ if grep -s -q "IMAGE_SECURE_BOOT: true" .config.yaml; then
>  elif grep -s -q "IMAGE_SWUPDATE: true" .config.yaml; then
>  	SWUPDATE_BOOT="true"
>  fi
> +if grep -s -q "IMAGE_DATA_ENCRYPTION: true" .config.yaml; then
> +	TPM2_ENCRYPTION="true"
> +fi
>  
>  if [ -n "${QEMU_PATH}" ]; then
>  	QEMU_PATH="${QEMU_PATH}/"
> @@ -143,7 +146,21 @@ QEMU_COMMON_OPTIONS=" \
>  	-m 1G \
>  	-serial mon:stdio \
>  	-netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 \
> -	${QEMU_EXTRA_ARGS}"
> +	"
> +
> +if [ "$TPM2_ENCRYPTION" = "true" ] && [ -x /usr/bin/swtpm ]; then
> +	swtpm_dir="/tmp/qemu-swtpm"
> +	mkdir -p "${swtpm_dir}"
> +	rm "${swtpm_dir}"/*

This kills the previous TPM state, preventing to power-cycle the VM. We
rather need to persist it aside the disk image. I'm massaging the script
in that direction.

Unfortunately, the unix socket can't be pushed there as well - path
string becomes too long...

Jan

> +	if swtpm socket -d --tpmstate dir="${swtpm_dir}" \
> +			 --ctrl type=unixio,path="${swtpm_dir}"/sock \
> +			 --tpm2; then
> +		QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} \
> +			 -chardev socket,id=chrtpm,path=${swtpm_dir}/sock \
> +			 -tpmdev emulator,id=tpm0,chardev=chrtpm \
> +			 -device tpm-tis,tpmdev=tpm0"
> +	fi
> +fi
>  
>  if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
>  	case "${arch}" in
> @@ -158,14 +175,14 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
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
> @@ -174,7 +191,7 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
>  			${QEMU_PATH}${QEMU} \
>  				-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
>  				-bios ${u_boot_bin} \
> -				${QEMU_COMMON_OPTIONS} "$@"
> +				${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
>  			;;
>  		rv64|riscv64)
>  			opensbi_bin=${FIRMWARE_BIN:-./build/tmp/deploy/images/qemu-${QEMU_ARCH}/fw_payload.bin}
> @@ -199,5 +216,5 @@ else
>  			-drive file=${IMAGE_FILE},discard=unmap,if=none,id=disk,format=raw \
>  			-kernel ${KERNEL_FILE} -append "${KERNEL_CMDLINE}" \
>  			-initrd ${INITRD_FILE} \
> -			${QEMU_COMMON_OPTIONS} "$@"
> +			${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
>  fi

-- 
Siemens AG, Technology
Competence Center Embedded Linux


