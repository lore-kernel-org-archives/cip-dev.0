Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6671C48BC1
	for <webhook@archiver.kernel.org>; Wed, 14 Feb 2024 12:35:51 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.84])
 by mx.groups.io with SMTP id smtpd.web11.40552.1707914147581215651
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Feb 2024 04:35:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sToyVNOv;
 spf=pass (domain: siemens.com, ip: 40.107.8.84, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOZDPzlyr0al7bfFSDthflqR5wKuKw7Tb32xwcHR57OITdXBUlEiW0yJ/0UaHdnykwwVwrCnhtnI9uFje+0PxzomSb1t4uuoC1WAzn8j2HfoEy7sa1UsgN9cMvTkb6dk1Vh/ikDIxXnJxesYiQyQ2UHyjbJOfY0cK5UaF6keTPMEBU/n7joO+QUVgcGPqXbD/YDTUaV1mvj8X1n8Jbj3nRKL1sboR5jlCxiCr4Oba0sN13raBKhl+8N9sPxmX15gUXA9ywLcmpQ+wuVpAOTgaHecLgVHJ7UiiA96FAsywxA3lOwdsTZdGTz4pDpuTKMLCWFNtmGrPC8qmodlmLqhBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrTSCeqKztYoWIDS4rdPx1Yys7HPW/erzszsNUBMXUw=;
 b=gcynnUpAhvC4RdhnhH/XQtcaCIAQdsH4XQmhAXrMFW8FDJ537pB2aUjJ3wwZPGCOiRRIzIZVqXdg0PIHkcurq6TAs6/Mpz4dsG+642JoDm4cKC1td83RZ9TPuxfMQmqTpBghOXrDsR2vXtU4SGieG+Qjq2HfUv4JrMRzF5btRhqKce3o3XlYrNDGfireczWHPWvPE80KKUK7rMKmAADRpBEb4ooccft+ptcwLCnyx7Cn8XDr0Enh1+TvW4Yf+/3hNKnYcaxLUDXoDJKaC+iH7nycvZQn9eJdn81ysOLI2LiXz+KJ/Vn56iQJoKy32qg6uYkx6mWRyWP1r/dHDx4n7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrTSCeqKztYoWIDS4rdPx1Yys7HPW/erzszsNUBMXUw=;
 b=sToyVNOvdurNhRE6+dI2P8y6gzZ2CdYDcThkquKL6564yxWL3pBPq2Qcge9tH+FpBxb/xzctgPk3CPmFTDh8H0sceZiqLJo4XfqjiOUESVVnGYOT12eNL4UmcD7FetHe/qZI6FBzVvIW7P5Fnl8rlp3n3etsM2Y+RQowAstIJItoT+QoWCJm4k7SRXQWnoYOCmnbhPlrDD4pPWNQzt/e4M2dl3kxR79cNvF/szdewJD2yClJlgtSeVzxwQJV81BqxITitZ3KwVpfQ7HEFIvpAiwJb5b+5CuDKkFjnAxB8qlgY4PzV8v6FkbOAvq2QNsIx97ncKDQzUM0d4Jqm9hyxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8088.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 12:35:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 12:35:44 +0000
Message-ID: <43b79499-8726-48bf-8c66-27768f63cc69@siemens.com>
Date: Wed, 14 Feb 2024 13:35:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core 1/2] deploy-cip-core.sh: Upload only .swu file for
 v2 QEMU security targets
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20240214122809.3541505-1-Sai.Sathujoda@toshiba-tsip.com>
 <20240214122809.3541505-2-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240214122809.3541505-2-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f05c04b-5fc7-4ca1-e2bf-08dc2d597678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	F2Tob2tmeiLaQnD/TJq26yQXhoQOZ12y7YZyVm4+/zD5fKxqNDp1zY43jDr91R7LnPzyge/4BqWLRYdt/DsPjeAS078lk55uZad8NEpdQQ28y8H0zXq26GfU7xve/krExIPP96CvxNLaAan4NjE3lJqQDSC0OUED4ZjYtOABHK1zSWGmhh6L6CNOO7wJeGC1+altMrSU8boMt7ps1J1S2mHr/BIsOqu5vHJzGUDk6NUuo2AcnlXS9cj7kQ3W5zGihYe2ZaweOl/2gQSJ6bQPy5lGbPAOF+pntIftJusbiYpaUZmrtBQx60+vVyODE774DFL81SX6X5qVgXowzgFP7Sv9c9IEySv5A5YpHf8iHUvW+qzIsdRuEA0G9w4MRlu9uaGIEsQqvJga2cc6aSpAS1a8Ku0+2dRAjmLaNiZxGPZu+mBttx9Hn+1No7wm3caYtS9o1MnUuEi4kJR8YHFKMDvkd/g0NoYacc32nHALg8EQKnIkvMAZ1QD8KhXfxJAbrZCd/bhnWLb2NY/92KdJfdcI4xrvv4ACyaXSoON/LiGJJ45z6oARdcGKCyQWe00D
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(36756003)(86362001)(31686004)(15650500001)(82960400001)(66946007)(5660300002)(66556008)(66476007)(44832011)(4326008)(2906002)(8676002)(8936002)(31696002)(83380400001)(38100700002)(478600001)(53546011)(316002)(6512007)(6486002)(6506007)(26005)(107886003)(41300700001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YVVkZ29uc1htR3N1OEVIbmxiOWhDNFgvVU84dnQwN2E0ZVZBRnBRQ2xJdHkr?=
 =?utf-8?B?SVNtdDQxaWlFQXYxdVMybTNKc0wwYnNVTVIvN0o4aDNaOFNmL0g3ZzhtNmhx?=
 =?utf-8?B?WG80bzA4Yk9QWVU3VkUzQklhaTBHb09GbURLM1hDK2tMK1ZxU2lnU2l3QVd3?=
 =?utf-8?B?SzhJbHJyamdaN1l5TVdIVDIyVjFwekdDY3IzZE1qNi9RVEFaK3JxeGxPUk9K?=
 =?utf-8?B?ZjI0cmx1cnZYZzFLZ3B5R3dtaHBHYkFIcVM5R0RVc2pCQnMxMXJMTU91aFlX?=
 =?utf-8?B?Vkl5VXJtQ081WHpuMFdDUE5CWVQ5VCtUSkoxY2VDbE54ZjJXbEp6RlVxM1Fr?=
 =?utf-8?B?eTdKU1VlMWJhMDFjTTlBOWVCU0hzaTk3UzlyTGkzVVBDcnAzSGhCUkhKL1pX?=
 =?utf-8?B?Mm5jNFUzakMvekkxRzRSaHNTTXdNYWliWnZKaVh2aGt6clF2U0w0SWw0cUgy?=
 =?utf-8?B?Q1ZHQWtpSElEMGE1WXBYZUNFbXhqNUlIaVpZYVRMQzVRLzB4TU5pVndxU3VB?=
 =?utf-8?B?UUtJWWJJSGpqcHgrWFB2RXhiNmFuN2lzblBLaFM3Y1hheFl5TERXbnpXMHlm?=
 =?utf-8?B?ZkpMUFZMcVlNZysxTXN3c1B2N1VHQWRsMmlsYytESVRnczFZRk1XUm91S0I3?=
 =?utf-8?B?T2dWWEhtYTUxZmxHcmk4Rm5rWks5TStkaGlwd0Qra0dCVUxaVVdPWkc5OEpO?=
 =?utf-8?B?QXpDY09nV0VldXd4QTlQVXJyZmtxM1pIQVE5UVBod095ckNNaENOOWtLOVBD?=
 =?utf-8?B?bW4rRnIrdnNJZ1ppUTdIa3lVUjE2NTJuOHFuKzZpZGdtRXFyRytmRXhWd25G?=
 =?utf-8?B?emxkelVveEJFQ2RDRzdiZklIblFzWUx5RjJkc0plTVBFVTk0SEc4NWtHbnVl?=
 =?utf-8?B?NG1GTmltU1k5bU1Ub1VQVTRZdXNHQjlGMm1jcnZ0QS85eTJkOWh2NlE5TStn?=
 =?utf-8?B?eWZ5QTZFQVJSdk1lRlFvcHYzc1NJM1VOSUpQQVBBdlRrR29ZVjJOQlZZSHFx?=
 =?utf-8?B?RmhrVWF0QVN6bzduUXNJWlJBazBMSTY5UzVhdm10WEVObnJZLzQrOHAxQldH?=
 =?utf-8?B?ekRuOVhhRnZLa2xMZVdra0RLNmRxbHpzdDRoOWFPc2I0SGR2TGRXclpoZFY1?=
 =?utf-8?B?N0VjOXVOZ0pIVzFOdGFmbnpBemdvUVhzZlNlTnAxWXBaenhldGF5OWxHNXd6?=
 =?utf-8?B?TXFWTUlGUFdLTlZiWkZVdFd5MVk1cWpmd1lpVTU3KzJKa2szdzFtTCtQeWx6?=
 =?utf-8?B?WjlNY3o1WFRrclQ0bFdKeThlN1doUWY1QUFsMExzVmdmNEhzMXNYK3hiSWps?=
 =?utf-8?B?SHM2WmIrV2VaR0tGc1hjNUdub0xwSXkvOXBBNk5OanFaSVNab2RRK1F3MU42?=
 =?utf-8?B?T2JHVVU0VVpSQURmYzEycnJUZ2xsRk5CMW1aMloySmxRTWZLY2pvd3NNTm1r?=
 =?utf-8?B?aVN5eHhQOU94V1JXd1NDNGJOSkgrRk1EaGRxMm9uZUJJNXJUSlczN2RtUnV1?=
 =?utf-8?B?ZzRHYnhLd3lqLy81ekdjV3ZtTmM4eVBjY2tjNFNUU2l6M013Qm4xdU5uUE1K?=
 =?utf-8?B?U1cvWjRqRGR3aVZteUdpVFlXNDVOTi9oQm9leDgxYTZZLzFQVEdyN2ZMSkVM?=
 =?utf-8?B?SElLTGV1NnJBZEtHVTFoVTdLdWlEbjdHTUg5VUZIN2JmWkJkbDJlWUgxb0J6?=
 =?utf-8?B?TXBMSXN0L2JiY2NuRldPVkhtRk9MNDJyVlhLOTQxWmR1WnRERTJqWnY2b3F2?=
 =?utf-8?B?TUdpZ1RtV3pPYXhWVHM5NE5jSExpeWVQaVNRR1NzREtUVGhVVGtSMkF4YkxU?=
 =?utf-8?B?Z1dxempqU0V4Skk4MVJLcll5MEpLRDVLUHBDbzk2ZFNoOWp5emRTU0ZsdHo5?=
 =?utf-8?B?RTBlanVlQjF1RHlITGFPblYxNUZEOGRSZ29raTN2SXhhQk9SSXV0akp6TXZZ?=
 =?utf-8?B?Q3ZFNEVoZ0Y1N1ZjMG8yQythT0pRbEZobVJHN0hqc3RueTJDZkpVcTBNMENX?=
 =?utf-8?B?NllJYnE4YitSbHNmQU54MXdjbWc1NXVydVoyM0doUEtBWmlxNTUwbTA3dHd1?=
 =?utf-8?B?TkRsejFWSzc2cXUzZXdwTldtSFQvZVlMVkxnWVZJdEJJM0oySUF3Z2ptTmVU?=
 =?utf-8?B?M09xVXErY0RjYVZuUFlEZ3ZMYWVBajhKY0VGNTBTWVZWL0RGNnNWTFpLcmNR?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f05c04b-5fc7-4ca1-e2bf-08dc2d597678
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 12:35:44.3791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JInmvIZizSsoAsi0NHSqGtiT4rY9+F2Yd40rRVIU/ThOp34cLNXJix2Wmr6gKXErqXD1wZ+vN3jvcfofIlFMcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8088
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Feb 2024 12:35:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14966

On 14.02.24 13:28, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
> 
> Currently software update testing is enabled for QEMU security targets,
> so if "USE_SWU" switch is enabled then only the .swu file is uploaded
> ignoring the v2 .wic image. U-boot binaries for qemu-arm64 and qemu-arm
> targets are also uploaded for usage in LAVA job definitions.
> 
> Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  scripts/deploy-cip-core.sh | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
> index 7f6cbe9..17d4ed0 100755
> --- a/scripts/deploy-cip-core.sh
> +++ b/scripts/deploy-cip-core.sh
> @@ -15,6 +15,7 @@ TARGET=$2
>  EXTENSION=$3
>  DTB=$4
>  REF=$5
> +USE_SWU=$6
>  
>  BASE_FILENAME=cip-core-image-cip-core-$RELEASE-$TARGET
>  if [ "${EXTENSION}" != "none" ]; then
> @@ -33,7 +34,16 @@ if [ -f "${BASE_PATH}.wic" ]; then
>  	xz -9 -k -T0 "${BASE_PATH}.wic"
>  
>  	echo "Uploading artifacts..."
> -	aws s3 cp --no-progress --acl public-read "${BASE_PATH}.wic.xz" "${S3_TARGET}"
> +	# Condition check to avoid deploying v2 base image and prefer only it's .swu artifact
> +	if [ "$USE_SWU" = "enable" ]; then
> +		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.swu" "${S3_TARGET}"
> +	else
> +		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.wic.xz" "${S3_TARGET}"
> +	fi

So, there is no case where we want both base image and SWU? What about
testing version rollbacks (or their prevention)?

> +	# Upload firmware for arm64 & armhf security targets required to boot security image in LAVA environment

riscv64 should be added to this already, even if the build is currently
broken again. Feature-wise, it is on eye-level with the other archs.

> +	if [ "$EXTENSION" = "security" ] && { [ "$TARGET" = "qemu-arm64" ] || [ "$TARGET" = "qemu-arm" ]; } then

How about uploading firmware.bin if it exists? Then we would not even
have to maintain this long list (+riscv).

> +		aws s3 cp --no-progress --acl public-read "build/tmp/deploy/images/$TARGET/firmware.bin" "${S3_TARGET}"
> +	fi
>  else
>  	if [ -f "${BASE_PATH}.tar.gz" ]; then
>  		echo "Uploading artifacts..."

Jan

-- 
Siemens AG, Technology
Linux Expert Center


