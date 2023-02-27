Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3763BC64ED8
	for <webhook@archiver.kernel.org>; Mon, 27 Feb 2023 07:12:01 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.66])
 by mx.groups.io with SMTP id smtpd.web11.84928.1677481919709337823
 for <cip-dev@lists.cip-project.org>;
 Sun, 26 Feb 2023 23:12:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vr7AC/YU;
 spf=pass (domain: siemens.com, ip: 40.107.6.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0+e7JJRoqkfSyfyrMdK4piINDFKNEODDo7hKHjpDB2eFEWLJYXXTMJwOdP2DNhmEfXBatu1Fqm7IfoDFPpd5rccjjw6640uokHGjHZOQzuvLPl3bTp5KWReXnp+57DTf4fyh0lgCqiiVQGZKnDntORkOjvSE+/lBbv/7HsP6JxfsztBjKGYplxx+ltkyJ2GH812Juy6G3AscHDRt22eNAA9wHWmeOdbU4mM5KQgBKLsrDx5NZPW6Ci8MTW9ADSUTZSkdMsXMgwNzv0Pyp8RcOc56essntjTjc5gooMrYZPQHZjiv+mrbWdZi4eMhRNUjutuJbOFftbwcrltbtwp/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ei4wyntcpp3ZgaJtttjeIaQ7StfhkG93/TEBSo6kJzY=;
 b=cC2yXaOCfkZSGNcuF0EXR7J/pJCS46ijDQ+ZxtMyCy9uO4uKpyjfduex8l1djx+PZ5qIvE66EBzSwElHd7O55Q6zTxyl3RiRgP9fZDSiFDPdtxb+p6WvAQK/zLTPaeznXLjNw1p1YDf9FG1twsbEelBMiDvSX7FxCHW+GulnSiojQBOJsfS4V7ZsdUIWmSwJkFoS6sry3wvkTukYhtZAsuABO3c5uWOUcdhvzgvxtbOdAXYucj7VflSEK6ufFyYyFOGCjo604DVu8Jv60DYOQUJT2cJ67VyuQAb6ZjZNebYGAQMAVsQm7xgUQ+P8We6ls98vC6o9bhEW/lzcZB/6YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ei4wyntcpp3ZgaJtttjeIaQ7StfhkG93/TEBSo6kJzY=;
 b=vr7AC/YUjRSk23BaF/1QBJf/FynCKj3TXNzVktVswo+YtJ2Z5R6XsK3yj8heNzj6QC3v02Y4DiRHqCO8lpQTpnpRWvjK+gYbiJCQPVJsKDP9PvIRA+E9Y/JsHe9ruOKxKUsqfOslcr7QiSAgRbXAft4loQWXlisuLHh8n12fLJOuHXNCc3w9Vi9UM/HIIUugedhd6TMyqT5sx69h5qNtslTUQrmLMDmAWP8p2i3We9VV7GKd23oj4XW0nOjjsB3H82RtaOr/uLyIn8mFfhkU62aocCG/YV+cEgHRPr5FEdmWHvXrDfKGS151lQpaO0VYTh/AaL6zVWaC7XeAXQL3EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5176.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 07:11:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 07:11:56 +0000
Message-ID: <bfe8cfd4-95cc-f09d-200f-1c0e98d59c47@siemens.com>
Date: Mon, 27 Feb 2023 08:11:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 4/8] start-qemu.sh: Create a
 tpm2 device
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, christian.storm@siemens.com
References: <20230224162832.327030-1-Quirin.Gylstorff@siemens.com>
 <20230224162832.327030-5-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230224162832.327030-5-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5176:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c8c24d1-69d3-40ad-998c-08db1891e90c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+u3rr/HXexaD8P98iYmJgNUV+O6GogLqjpHcPr9Vl6Bn9ZHQpcgRLPotyg9gygRPcEMB1QVHC4mHS4NSOIMb6Rx0AcrvPmQUh5QzGMTxqyW9Zli2NNvouVN5WofAFE3UHzYyIKXwOCpaRTQUsspoi4Etm6NimE3CD5CesqvusUh7Kwl4zsScesfF2NxCFQYpm/1Aa91jsaNWC8aIneuwFqRQrj3gvHUTMUMVLxE5txVwNEXCOmidiAY50H6olW1LAOBXpH2k87C9E/F3rkXeJYuA1clo4DbIM2pBLZUeCUoa5weTgIZDVGnXSia35GYpc/D8Cez9KsfEMmVysnzN/Rf2JYWkBdAVppY2WShdzrXw5JR5AGz3rIJSRWy6WSG5vbd0wsjvPdpWdduCNmbhJlDX5PA2MQgttyaiWfu4VjT1ssUOmp3dGbDs60JuKGqeys9RuFFyHG5dw7RY7jgt4jvE1ilywaub6xv62NOJin9BAWkHvVQt2Ncl9cHywa/59GRKpVu4wo6M6nJa+lKvlregDfyW7YtJNucf4NUinSqEtEU1RR+9IOXjju3QXlIR4I+v+Pu9qtSCCCtf7k/LsCSBcmwtnOMnTO2PCX5zjquqZYc+DoPfp9kSAmp40BkQ/yq8FfmAlpeAYXBTeYH8mdSE/mjGwDwbLbJEZgrLdvmUKYeHvu4GKeJ0V0yyFSdSnwaNa6vXU9a+xsZRFFXSQZeFrL63rVcE9ULhHA1M/aI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199018)(2906002)(31686004)(44832011)(5660300002)(8936002)(36756003)(41300700001)(66476007)(66946007)(316002)(86362001)(31696002)(6636002)(6486002)(8676002)(66556008)(478600001)(82960400001)(38100700002)(6506007)(6512007)(53546011)(26005)(186003)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OWNIQk1jMFVZNUV5NzlVV2JUM3pvOVNYZHVHeU11a1AyU2YxYU9VejVpQ0Jy?=
 =?utf-8?B?d2lCMU0zNGRaL05mbmtiWFpGaTZHN1lHalVob0NNb2phKzhyM1VYS1lJbDJu?=
 =?utf-8?B?bXB1a1VXVlpLUWJjSnVXbDQyOUVMUklXSUpFaUtXMUlnNFRtZG1SSGcrNFVP?=
 =?utf-8?B?VS9RNXJUR2F4OURVWHFPQ1pucVRJTWFOdXNyM0FPODRzeGN0YzlNQ1ArSlhp?=
 =?utf-8?B?ckd6VGw4Q1BDNUVKbXVaOVlUQWVtL000c0NiSi9zS3YwcTVpalNWNWF0Vlkv?=
 =?utf-8?B?bVdUU1I2QkQrTk14dW1ZZVE1Yit6c1B3c01UTUZEaG4yMXRkUHE1TC9kMGQw?=
 =?utf-8?B?MGlpQ0lmbEZYZ3NaVkhhcnJjQnhQdFN0c0xKRDVtbEV2VDViV1B4Q3N0ZkJk?=
 =?utf-8?B?ZUxqYnhOem4yLzVNWmorL3A1VWZJbkRxUkErM0xlbjZXeDg2MVJYVEpkZ05o?=
 =?utf-8?B?NzUzeHBkUGwyQXo5NjhLaTZKd1hqZlNvMUJ1OHZEaTR6MWpmbno5WnBVNjNz?=
 =?utf-8?B?dXN3dWE0emZzVSttNGtzV1RYVFZobkNBdC9XbXhqT1d1RjJGZ1Z6NTFSeUtC?=
 =?utf-8?B?Z2x2WFJBSUpuTlM3Vk5aODFLa3pwaSs1c0tWcWdTRWZjaGdvclhSMWt2c1ZY?=
 =?utf-8?B?VjhlTGxXRGpMVVpWbzZxc3ZiRDYyYit0RXZSaFdpb0hmaFZWN2ZKL1V2SWdy?=
 =?utf-8?B?U3ZaZUFRQVVTN3FqbmpKeUR6eXhKUmc4bEFBUy9iZlkzM05aYVlreDBJc0Fu?=
 =?utf-8?B?d1NiSmhkUmN6Q1VGcm9DektpK3BrQjBMQVEweUViTnJqUlg4b1hHL1dvMklw?=
 =?utf-8?B?aXZRYnNNTjgxMytPWGU2am5GQmZoUktxSEhXbklTd2FQL3FNQndsL3RoUkZM?=
 =?utf-8?B?WVZraGNIaFNKbnBjaGZEa0xqczNVS1E1dk5SYk1UUTdxaXhKRzk5THZwTkJP?=
 =?utf-8?B?TjVMOVlZWFF6b1FqMVBNRmdNaUJ1SWdmMFNKL3FxM3BpbldDSzRreVd4NWpP?=
 =?utf-8?B?NUFnaHA1VDc4a25uR1ZEaFVKQmNkMzRDaHRZRDlnOElPUXFmUTBDclJiRGtP?=
 =?utf-8?B?UGJJdk5Ca280M1h1NW05V2xyenc5THdWMkNhNFEyck1rNXlhQUw5OCtoalBx?=
 =?utf-8?B?WjZ0V2tMVi9wdkhqYzJpMzB5bXUxYmlJVTIrUE1VY2h2MVVsaXNXTm9lZmxi?=
 =?utf-8?B?SDNQVjZCc2x1eU5wQ1V2TUptRXZDNXJ1NWRFTVVKcDNxekltMGNqeWxiMnlX?=
 =?utf-8?B?cHJtSHUzQ1A3aldNWkdIeEZQQnRQSjR2UkIzM2tISXRGM1kxdU5lVmdJRThq?=
 =?utf-8?B?STY5Rms1U3cveWZGTlRKNW5CMkRSc3FXSm1vTzRUYXM0ZUNsMzFZYUhadk1L?=
 =?utf-8?B?bjM3WWNDMkREbXpFWTZNaWhXYnhhclJwY1hLK0hvcFV5SlprV2doR3EvUW50?=
 =?utf-8?B?M0drb0NNbk1nNE9XaWVxNWRlbnJRUlNONXlwNVM1T1l5YmJZRWlNYmthaDhm?=
 =?utf-8?B?Y1V5eGc0Ky8zaHhWN1JpSGFJbXUzSE1Bb1crSEwzTjV6NjlGU3gvZDlNa0ZM?=
 =?utf-8?B?VlhJL1A4K1JFb0NWaXcrWDdxczNlUnNaaVhWc1FvZVVzL0tOK1VXcWp5OE1C?=
 =?utf-8?B?Yjc5R3M4Y0RNRG9VQTBEN3pPL29CSEtUTHY5TlZheXFZMVZQZVU4SVFjeUtQ?=
 =?utf-8?B?NS9jV0o2QU1qbDJpODJHRjRiUlo5WFVmY1BkeDJzTC9zdG5rZm1rZWpmS0xD?=
 =?utf-8?B?a0lKOTA1SUluTmxqeEpmS1c1RDYydVNuNWx6ejVLaGRacm9adG1qR0ZvbzE0?=
 =?utf-8?B?eXhBazBiOG9iWi9OTlQyeTB1eFc2U3hUQjJGK08yZmJYSmEydlVPSHZ6cm5U?=
 =?utf-8?B?RjVBNGpFZmJJL0FsNlRWK0RNUDRyUnh1Vzl6UjJNM2xGbDc0S2Z1N2YyOFo3?=
 =?utf-8?B?QzBCbWxvcW9peXdseVhZNCthOWN5SHlGOFFYV2RqLzJzTG1hSHNkbjVrTkdO?=
 =?utf-8?B?eUJJTVFvdmdXcURuWnE2TWZOU2hiekhEM2lSalhJTXZTTDE3bHVrb0lPRUZI?=
 =?utf-8?B?ZytYMEhxblVGOHdNZ0VuSENHQ2JqS2Irc2J3ZGVQUFd2WWVqL290eFc0Zmpn?=
 =?utf-8?B?dTcwdlVnWVpoMDM2WVBFT0hYQnZ6dU9yaGk3QTEwblBmUnV1cGJMY0RzOUZX?=
 =?utf-8?B?dHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8c24d1-69d3-40ad-998c-08db1891e90c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 07:11:56.3861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsgEUHdWwbRpf5dbWDsIoPiVWObh8brayv4qtu4HK8OE/9ceNYz6nQ60KN0chr18MBWDhJoZ6eRPcJn7I80EIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5176
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Feb 2023 07:12:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10859

On 24.02.23 17:28, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows testing the tpm2 encryption with qemu.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  start-qemu.sh | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/start-qemu.sh b/start-qemu.sh
> index dd16aed..c06d21e 100755
> --- a/start-qemu.sh
> +++ b/start-qemu.sh
> @@ -28,6 +28,9 @@ if grep -s -q "IMAGE_SECURE_BOOT: true" .config.yaml; then
>  elif grep -s -q "IMAGE_SWUPDATE: true" .config.yaml; then
>  	SWUPDATE_BOOT="true"
>  fi
> +if grep -s -q "IMAGE_TPM2_ENCRYPTION: true" .config.yaml; then
> +    TPM2_ENCRYPTION="true"

Inconsistent indention with spaces.

> +fi
>  
>  if [ -n "${QEMU_PATH}" ]; then
>  	QEMU_PATH="${QEMU_PATH}/"
> @@ -139,7 +142,21 @@ QEMU_COMMON_OPTIONS=" \
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
> +	if swtpm socket -d --tpmstate dir="${swtpm_dir}" \
> +			 --ctrl type=unixio,path="${swtpm_dir}"/sock \
> +			 --tpm2; then
> +		QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} \
> +					 		-chardev socket,id=chrtpm,path=${swtpm_dir}/sock \
> +					 		-tpmdev emulator,id=tpm0,chardev=chrtpm \
> +					 		-device tpm-tis,tpmdev=tpm0"

A bit over-indented.

> +	fi
> +fi
>  
>  if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
>  	case "${arch}" in
> @@ -154,14 +171,14 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
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
> @@ -170,7 +187,7 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
>  			${QEMU_PATH}${QEMU} \
>  				-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
>  				-bios ${u_boot_bin} \
> -				${QEMU_COMMON_OPTIONS} "$@"
> +				${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
>  			;;
>  		*)
>  			echo "Unsupported architecture: ${arch}"
> @@ -187,5 +204,5 @@ else
>  			-drive file=${IMAGE_FILE},discard=unmap,if=none,id=disk,format=raw \
>  			-kernel ${KERNEL_FILE} -append "${KERNEL_CMDLINE}" \
>  			-initrd ${INITRD_FILE} \
> -			${QEMU_COMMON_OPTIONS} "$@"
> +			${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
>  fi

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


