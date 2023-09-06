Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E64BEB8FB4
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 09:30:51 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.62])
 by mx.groups.io with SMTP id smtpd.web10.4649.1693992644511675984
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Sep 2023 02:30:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cwP65car;
 spf=pass (domain: siemens.com, ip: 40.107.6.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHFLJdzK3q9nnfC3YiqHd34oy70XAH7yUrk1hs/EGJHcojkaUA23VtzFQQS8oRKVIJj9/RCACP08Le9cYmFvmSc0h/gyrZbD0RUaKKBW7/KnWhOpeuiLhI7V3ZMAJlngbuLka+OSwQqFqKvZ8bqGMcInijk7WXEKZgCa+6E5lbGDb5ejIjQ0q08VnKD/MGA+XkexJyTKZfZZo/a6G7veAGbXroVZgVCI9LJqbij7cLnbFC051tgMBiX4mK1RZVCL1TViVYhYUh3Q0jkS8bRj4xJELMToOGHbUqSltXLm7k2ybH5SkeiZw76Uon+zpbUtnsVwWBgQqZ3AFVX9iVwD+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujiIzhVmw6xl3RsBNUA9Nh5iKkrBlTrTENV2cQiw8FY=;
 b=T2w/xE4BsY/e+D1p2c30ps6wXwwROOjSo7Sln3Av8uk4JBy2KKLQ7pKe+iEbT9Dqq5OOKaPLnKctNQM302w/xzFacXIzEhavc4rZw3KGhj/wyEGVag5rzRHEcOOxqy3+jMN82L7yZpv3tc+VuGVb09+v/+NwZnOS0DuduDulkM1Op5n2I59gI84WCnMSM0exzZDVNyGw5PhS+DeSK0VgPTJ9oJLbP6QxtUPopfQg2nZqs7WoR0m6NXE3EAM6UodkNfjxKOC4R/AHaFQ1j7jkCHp8MqBb95+jDN0kO8nhbhMzJMuJSU4cnfJHfcrWgR8S84VjqYu1pS8vJdmDUwagSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujiIzhVmw6xl3RsBNUA9Nh5iKkrBlTrTENV2cQiw8FY=;
 b=cwP65carmzuwt66IsWB9O0Dj54vNVUMCgCFf3BPtUHz+bEl6svW7Pp1gYXb/fTnPWupRTezpJHzoROkw6LUomuDzSrxmDUbGmJmP89A6ZkJRJfoeBfmcVmRYSIuPtMAk8dZGe3IEF0MtYTxCK6uempDS+cIom9qO4VEsM4t22D/2XcPlSdsfnwy4nMB0GL3cNtLZWgLyi6U1V4PPGooIT5XNzKEDedbCRuQecHEYfGv6VXueK6jugRCwHGHK+K8lV9dCuMTDwITnvNk9jQSeMgW6cjKrh6CVZquXPmxAkFAdDvLLFMOOUaxITNBYUZyRMmxjVWGPRofbxZuiPdK7cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6166.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:389::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 09:30:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 09:30:39 +0000
Message-ID: <de753e79-fa78-44d8-a07f-cc297408e467@siemens.com>
Date: Wed, 6 Sep 2023 11:30:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core 2/3] .gitlab-ci.yml: Added a new variable to
 control deployment
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230906045643.2640096-1-Sai.Sathujoda@toshiba-tsip.com>
 <20230906045643.2640096-3-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230906045643.2640096-3-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: 5036b095-6acd-4fa0-e62a-08dbaebbeee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	S7YtGCao7LxyilxrPqQqt/tJhOWIJqf7s529cZp58xCmvayjfpz13uNBpzzPKov1IQ5cU1yd7jYu4FX9BYBdLDnYZAAagouk+k3AqDZZTsf5m1WMs3nmUS2IeMKR9G52tyB5Ddjd/saA5a7z2xszi56dVfiipdMRYRxl7iMq3OHfoOIgjv99QXEgH4UcuqtzYD1HOUq+6qMFB3atsFH4r/+QGWp/o+bIpQIUopamWSTiZ/ap+pcVF7ZB88tnGIDVvfv402rEUifm/YoL1gegT5IFwollMXi5c8hn89zDDgJivwKuK/6cGRBKIG8ACi8TAiuNlijlcyOmG+EbQoiJSutmDJP8XKKnJH1Y+puqcHC5JC3xtngz2JMM8VlfY/kMMaAPiwfmX27/lBXGVfwxYPWztxX7M1HH9cVsMkSUu16YE00JqtzkgpvVFEfYIslErZ7bkdEgxpNm8QgMaYXqAjnkW9aLuGNBnfUfVubHsRUY3MxJvCgKT/ZOU33/zL0JKKWl/GrB5gtpcnvf3jx1XlSTnydXHswP/XYqLQUwsnjf2RYTk61xuUJFhMamq++ViFt0bNJ7F3DB3EqK+mccde40b7ObVnsi4jDfuzUN7FESI47/CfG8PwARXf3+ICjC7fPlB91x9lSieO4270rBaQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199024)(186009)(1800799009)(31686004)(53546011)(6506007)(6486002)(82960400001)(31696002)(38100700002)(86362001)(2616005)(2906002)(26005)(6512007)(83380400001)(478600001)(41300700001)(8936002)(8676002)(5660300002)(4326008)(36756003)(66476007)(44832011)(66556008)(66946007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RkNXRlB5ZDNDT29lU3MwQ1ZUcERCcmMyQWNPaTJydXNzZFg0L1A5VStIV0JF?=
 =?utf-8?B?TDMzN2w4T0ljWWxLVzRKN0Y3K05vc1BiSU45UlVLM2RFYklBRUs5d0FzbHdQ?=
 =?utf-8?B?MVR4N0V1UjNFejQvT0FFM0ZwQlBPeVVxbFFCdXA4Y0dxcnorcUVqOFBzUCtv?=
 =?utf-8?B?cUIxeDkwcVROQlRkSUFzS1A0czVkSGFjbUc2czdQY3Fud3NMRTRxYkl4b2lY?=
 =?utf-8?B?a2tELzNNdFBOMlhRM0phTDZleVU4akRFY3Y4dnJjUVMydkpERVJzODRNVUVC?=
 =?utf-8?B?SmVOeUVUV05HdjcxY3BEOHNKUGlieEFXUUlhc3VEUzRhYTFrM1hnNjBFSHRB?=
 =?utf-8?B?NnMxdG1NQWhlcjErRktwb2Fua2ZVd2U2TFZQR050RjlxT2Yzcmk2dTBCcE4y?=
 =?utf-8?B?Z2JLN3hIM1YzNEhDVjJ2WkdMbXYvVlJYU3l1OGxJaU93WEJKaWQvTXJHNTVx?=
 =?utf-8?B?KzFxQWpDK05ySlIyQjRZcloyYnpnZzJZSWVvb0hNQ1g1ZGIxemtadk5RaTY4?=
 =?utf-8?B?bVkwd2FnazJoaWwxTXI2T3AzVUZFYnRubnMzQWhkdmJMSDBqdEJ1emdJN0li?=
 =?utf-8?B?RUNPU09OVzFmek0zQmtBMkYxSXdMeC9TR3lxZ0ZmYStzcGpHcldqaE80Skdu?=
 =?utf-8?B?YkNNem1EdzAzRVRGWFM0LzN0VUZreHBseXNiL0NQR0NlZHJUUkxZUlN5d0c0?=
 =?utf-8?B?UHc3YUM5WWlDZ0dVRVluSEE0Tkh3bEpTNFEyOXhxWkJzWnFEZ2dzYzVOb1hx?=
 =?utf-8?B?TGdUT25MZE5RVGhCUUdhWnlscjc1SEN4UDFnRUl1YlQyNVRkN29mS1dPK3N1?=
 =?utf-8?B?Qjd5YkhVdktYR2lKNWE4bjcyK1QrNXl4b0dQOEJaVWcxNTJQQ0wyWVVKRzRw?=
 =?utf-8?B?Q2xRYVVhbGljWDEwRjQzVS9Yb1NpK1p1SHBtOVFHTFlTNCszVys0RXhEa0x0?=
 =?utf-8?B?WVBuZUNEck5wWjk4b1A3bm9mR0ZIeSsybFQweUZWZW1qWlZwOHhzWWR6WUhp?=
 =?utf-8?B?Qmpkb2VzU2dhd2dRb0JwVlE1RHV5KzQrUnIvRVJvbkZ4TERqZ3VCdXBoWUQ2?=
 =?utf-8?B?VDZFam43SThRVDV4aGx5dURmNjZ2Z1dMTER3cUZMbXRkLzMyOE1VOWZLOXMx?=
 =?utf-8?B?ZlhRYUs5cjA5alFtWDRjMUZJcHcwQ1QyNE5QcTZ1M2JnUkN0OXN3TXFweSt5?=
 =?utf-8?B?bXFDWjdLL2xPbVVxTzZhOHNhMGJ5dVlRc3ZRTGhrR3loM3c1L01HTzRlNnFu?=
 =?utf-8?B?ZlN6WDNteVZrOUlKeFNZQVR4Yk9lSzV2QUhCWWJjRlVVa1FJL2pmNEY0ODls?=
 =?utf-8?B?RTRPUHcwaFRHOG02dCtYbzdXdGdWMTEweWVTUXBRZEhiNFI4RVhoU3Fib2JX?=
 =?utf-8?B?MDNwM3lyMEt6VCtSQUt1YlpYbmsrZDFaWjBBM3hpM09JMjNJSUVSMUVZbGtM?=
 =?utf-8?B?Z0FRc2dYN3hGNXJodGY4clRtNTFCTHg4dlBUZ1BWMVcrOE43bHVIU293UjBh?=
 =?utf-8?B?NWwvWTcrbHpudEYyUlNFYlAwbWxqdUJFWERTZGMvT0JYMWVITlhYWXpoMVpV?=
 =?utf-8?B?V3ZIRWR2TGRrZXZZbVdjVW9zQ3p6Z2FIS1F1Mk5OdWZhRTRZUTR0dmN3YmxN?=
 =?utf-8?B?a21MZjZPYWJmNFJNeTRIeks0elY5UTRFMUxxZkZZVTlOUWVFc1QweFFNYlJ0?=
 =?utf-8?B?VG9hNEk5aW9qeHo2YUtuclArMFJmeXBWTjR6aWFGZy80NloraFRHVjBwbk9Z?=
 =?utf-8?B?a0V2dHdON2t6OTBkVTZaRzFTdUtaRUo1RG1CdnVoejZmVy9OR1l3bmd4NVFu?=
 =?utf-8?B?UUFObG5kZ0s1eEtlUjE5MjdFMDBFOTBhNTM4RFpUR0xmK0hubXZ1Q0RoN21o?=
 =?utf-8?B?VGZYOWZIRTNmdmZlOEpoa3BheXB0dmVNSzhDYnZZdFdrS2RQdjNRUzZyRUdr?=
 =?utf-8?B?VnlhOElUbkgvNys2OFN2QS9HM2ZqREtBTDJKb25RanZvRE9WNmp1NkE1bU1B?=
 =?utf-8?B?RjROa2txUUxYRWFZZUhTUUZaMk85eXJHRjQyQnJpV0c3M2FaVjFEK3JibDBQ?=
 =?utf-8?B?UTIvVU91V1F6VlBVNTlQdi9EaGFMNUxzLzQrb3F5RTdiNDRuNHpmL1RYZWhE?=
 =?utf-8?B?OERaWVhwRmNQT29yMFQ5N1VtL2wzRWJYN1phbWtEaExxVXA1MGJBWHJjaXdN?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5036b095-6acd-4fa0-e62a-08dbaebbeee8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 09:30:39.4885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VTENfv+IRyQvQe0VAUmSM8yJMWUbWsqN6Rjjr+gzsvklDTQ4GFgpD3Dw3xcJ55HBO65G/ZijrpPUwuXjCYD6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6166
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 09:30:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12985

On 06.09.23 06:56, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
> 
> This "EXTRA_ARTIFACT" variable is enabled by default so that it can be
> disabled for targets where the uploading of only disk image is
> necessary.
> 
> As per the requirement, only disk image upload is sufficient for security
> image. So the EXTRA_ARTIFACT is disabled for the targets involving
> security extension.
> 
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  .gitlab-ci.yml             |  6 +++++-
>  scripts/deploy-cip-core.sh | 31 +++++++++++++++++--------------
>  2 files changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 8ccd617..f1308ee 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -25,6 +25,7 @@ variables:
>    dtb: none
>    deploy: enable
>    deploy_kernelci: disable
> +  extra_artifact: enable
>  
>  stages:
>    - build
> @@ -60,7 +61,7 @@ default:
>      - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-partitions.yml"; fi
>      - echo "Building ${base_yaml}"
>      - kas build ${base_yaml}
> -    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
> +    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} ${extra_artifact}; fi
>      - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
>  
>  # base image
> @@ -100,6 +101,7 @@ build:qemu-amd64-base:
>      use_rt: disable
>      wic_targz: disable
>      targz: enable
> +    extra_artifact: disable
>  
>  build:qemu-amd64-base-kernelci:
>    extends:
> @@ -122,6 +124,7 @@ build:qemu-arm64-base:
>      use_rt: disable
>      wic_targz: disable
>      targz: enable
> +    extra_artifact: disable
>  
>  build:qemu-arm64-base-kernelci:
>    extends:
> @@ -144,6 +147,7 @@ build:qemu-arm-base:
>      use_rt: disable
>      wic_targz: disable
>      targz: enable
> +    extra_artifact: disable
>  
>  build:qemu-arm-base-kernelci:
>    extends:
> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
> index eaa8974..76e80ce 100755
> --- a/scripts/deploy-cip-core.sh
> +++ b/scripts/deploy-cip-core.sh
> @@ -15,6 +15,7 @@ TARGET=$2
>  EXTENSION=$3
>  DTB=$4
>  REF=$5
> +EXTRA_ARTIFACT=$6
>  
>  BASE_FILENAME=cip-core-image-cip-core-$RELEASE-$TARGET
>  if [ "${EXTENSION}" != "none" ]; then
> @@ -36,20 +37,22 @@ if [ -f "${BASE_PATH}.wic" ]; then
>  	aws s3 cp --no-progress --acl public-read "${BASE_PATH}.wic.xz" "${S3_TARGET}"
>  fi
>  
> -if [ -f "${BASE_PATH}.tar.gz" ]; then
> -	echo "Uploading artifacts..."
> -	aws s3 cp --no-progress --acl public-read "${BASE_PATH}.tar.gz" "${S3_TARGET}"
> -fi
> +if [ ${EXTRA_ARTIFACT} == "enable" ]; then

So, the logic is now:
 - deploy wic image if it exists
 - deploy rootfs tarball, kernel, etc. if EXTRA_ARTIFACT is enabled

I'm wondering if we have a case were both are true or if we could simply do

if exists wic
   deploy wic
else
   deploy tarball, kernel, etc.
endif

Would simplify the configuration back in .gitlab-ci.yaml

Jan

> +	if [ -f "${BASE_PATH}.tar.gz" ]; then
> +		echo "Uploading artifacts..."
> +		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.tar.gz" "${S3_TARGET}"
> +	fi
>  
> -KERNEL_IMAGE="$BASE_PATH-vmlinu[xz]"
> -# iwg20m workaround
> -if [ -f "build/tmp/deploy/images/$TARGET/zImage" ]; then
> -	KERNEL_IMAGE=build/tmp/deploy/images/$TARGET/zImage
> -fi
> -# shellcheck disable=SC2086
> -aws s3 cp --no-progress --acl public-read $KERNEL_IMAGE "${S3_TARGET}"
> -aws s3 cp --no-progress --acl public-read "${BASE_PATH}-initrd.img" "${S3_TARGET}"
> +	KERNEL_IMAGE="$BASE_PATH-vmlinu[xz]"
> +	# iwg20m workaround
> +	if [ -f "build/tmp/deploy/images/$TARGET/zImage" ]; then
> +		KERNEL_IMAGE=build/tmp/deploy/images/$TARGET/zImage
> +	fi
> +	# shellcheck disable=SC2086
> +	aws s3 cp --no-progress --acl public-read $KERNEL_IMAGE "${S3_TARGET}"
> +	aws s3 cp --no-progress --acl public-read "${BASE_PATH}-initrd.img" "${S3_TARGET}"
>  
> -if [ "$DTB" != "none" ]; then
> -	aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/"$DTB" "${S3_TARGET}"
> +	if [ "$DTB" != "none" ]; then
> +		aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/"$DTB" "${S3_TARGET}"
> +	fi
>  fi

-- 
Siemens AG, Technology
Linux Expert Center


