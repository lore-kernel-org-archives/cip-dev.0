Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AEDC4332F
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 10:39:44 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.81])
 by mx.groups.io with SMTP id smtpd.web11.24854.1699612777462657569
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Nov 2023 02:39:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=m5QCVXnz;
 spf=pass (domain: siemens.com, ip: 40.107.20.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oflTVv3SIypQVDU0uWyI2LBBIK5J3l79YjrceYxhfmsCO4v9Sj+t7PuqhIV2oFrOF0IPE8NI2ShzzTpU3OJPzjMtxAWm4op8Wr7vr/2Hd6wcQt2DHgGxO8CWS2X7wXdHHybucEqgxR2ip+e/xoHJK6rT2jDI9rhwg7vxNsU/vyn9X29j2zUma/ilnAQ84nUBRlNzXh+CgaOxlJgoUM+rOYlDUtmlKrBIVhLm5CyBuXgimTXVwXwg5oLnqcWpbnuBWGaWkXzJ6Nxm1GdwTjd2SFs3OO7VgVyWlSA55pVzG5rjbA/53U0LgX15CSKX32jlG6JAzcLhXha3cvHwQCZJGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SZNWgSCJeeC6y7/gT8/JGuqnk81zBvbSnUmNHAXKMI=;
 b=VlY6aex2NZMxiODGBAkEQ8K1Dekah856++yfb67lW/SBXBJdJbGijd24JsyEIFfQd9MFHiSVPbUqpyJl2pOgh+XCcTS8zE1/kWHATcRLkz48bDkKWvyBX2wMlD7P2EKzZUJh0KRsSpTEG7+SPSMdWCShjmlMx7F+L89wEp/v48Bao2JBti0DoyFlF2S3WoY8vnGXl5/qK8mCjkDEK/gfBLIf0OfAN39Ycc84ci1oUpVgkMZj+Nxid6St7ngrT72Gmk1Yr9hdNkT8bAPAMHsHaqjAAlQ8gpdCom91EuhquaX13sXkgE9ZpdP2QEfhHmJqMFTusMLLG1ZAyX3a+/UCnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SZNWgSCJeeC6y7/gT8/JGuqnk81zBvbSnUmNHAXKMI=;
 b=m5QCVXnzMew6tT7xpQbUvMRoJ6Z7YLltXzym/hW1QyhxgPI0nBDUZKEK4mGLJYA9Kst07LOfY8m5MGyKKxBvtNHwuAp7xovcGmj7J1P7PXFtvqH+RD8PvwhC4S3FwRiZBCk7308tsnvpDnO37a+NMU5SyrRPISd8yIfCJyTk1mNjpXdSmdV+awtDRtgLplViqA8K/R1HtO1bpRE6n4/gPgE2b5NnNOOH+lM3AwBY9CXeY8391Cmxkqv8+qHq+OeLGJgqbJ67mSNwEU3l6DATciStJKWqHWYPqRq/p8L2qFWvRYpA4WTX6lFr7aPJrrf690PQLA8ZjZdlOXxSrrTvgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6626.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:564::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 10:39:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 10:39:34 +0000
Message-ID: <e2bc7abe-2a5a-4293-84ae-4ddc40fa457c@siemens.com>
Date: Fri, 10 Nov 2023 11:39:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] ebg-secure-boot-signer: sign artifiacts
 reproducibly
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20231110080508.20807-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231110080508.20807-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:610:cd::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d3fac2f-7a5c-4120-a156-08dbe1d95469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KlA2BNHHYCsIMBNq0XxTspwnPN8ZgCI4HPY9F/2s2AOYCal/fxd1kE+rF2zTd9THhFSso3cp4M2KpRzQ67NDrqBfzS9PFQKyk57t09WGAV9+UvE65kKIm/A1vf+ygBsWNSt9ZN2tnoFy7JmxozM4Heya05iXKHx8O0xNAICs4yDIFIa1pgT0J6aNtSR7J9lLzWS4N0h/on6nxWPCNSwY91v2oZs3yJczQ3zOHq9FddaJht+0sYOU2hy0wiY1WfFxa0Jz572LjGUhnvWeBqXMN85JfjNXzYOhgWXFXPwSM1Y8bCzF+wlXqwq+kHo3pk5l+fyemr9awaLk8qmXnDnQSwolIB4/f4DerKYsTBqMhbYu/q8gwjNCIyx3NLE4I6pLClgI0YJV7eEIOMkfTy2T7/aHDI9d876S+RKbhQBIzCubg6P3ZljeFTAVa4bBrCrNHvvXQsLgf/J+nRsWxwXQV7zWCCMwc5FOjYzTdHYKPvqxR5Gg0pEjDxsq4PpBFO/DSeElrNbbqYFJMdA4fflQPW4pb5xRF/tRzIUswHgN6lvw/IJ19ry/E68VV7uLB3aK1xfUf3hU5QZwSJ1YiRgjcV21SlwsUZmIPLleIUmlY/WJ58f8zY+t0zvd8d4kAwFdH0DAuvofMsqFwolEvmP/5Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31686004)(6506007)(6486002)(2616005)(53546011)(478600001)(44832011)(6666004)(5660300002)(36756003)(31696002)(38100700002)(6512007)(82960400001)(86362001)(83380400001)(66556008)(41300700001)(66946007)(6636002)(2906002)(26005)(37006003)(316002)(6862004)(4326008)(8676002)(8936002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VnpXaWJpWkZKZm5ISGVGcVJNMGZTUGlES05Nb05GNng4dVloVWhTVTZjSWNE?=
 =?utf-8?B?T3MrRjVIdVllV2xvbGJtL0EvTk1JM1VFWW53MTNaRGN1QTN4NmRNYzhrbVhS?=
 =?utf-8?B?N0lYcHV2VUVuamw1TWlPQmlSMnE4bUxZanRkVU9PV1lrc3ZPcGJ1dnl2Vm02?=
 =?utf-8?B?MFNVcm1CSU5yYVZkSWtRTGE0c1FwQTVBTXM4VzVjL0pTSS80NklwbzVZSTVT?=
 =?utf-8?B?MEltNGdsVWE3OXBuaXRBWHlCRGZncHQ2SkgyR3Zva1F5QUxKbXJBNy9jbEYz?=
 =?utf-8?B?YTlKS3dGbWh3WUVxMFVDSGJPN1hnR1Vjd3RRaklPWVIxSjRZMHVoSFR0ejhX?=
 =?utf-8?B?cldoczIzWGtsSDBEMks1Uys1M045ckI5Q0cyN1plVnJIL052MFJYVFpOZnI0?=
 =?utf-8?B?WDdTS1ZVcXhka3A2a3ZBL0dPNmtlbjNJUlRwL1FQYW9hamVvcnR0ejlwSHd4?=
 =?utf-8?B?M29JMVMzai8xOTFaM1BaNUs3NFI2R3hVMjNZeHdHYkZJNGdJMm1UQUZsWGpO?=
 =?utf-8?B?RFNJNm9sWmpGQkJZaWNFOFFHTlpramY2TWt1N0lwbEZEZW0veVdEYURhSnpU?=
 =?utf-8?B?N2hQSkJRRFdqTkFwV2czTzJxMTJKdm9vR0hRemlkcytWZGxHT1lEWERoQVNv?=
 =?utf-8?B?M2lMQi9seE5qZGNYb0MvY084MTVNS0drVXdGMjdwdVp6STNNTGQ5UUhVajBX?=
 =?utf-8?B?Z2Rra09DcFdTa0FQK2hmVXNNbHhPMVIyVVFBeEZ0ZUZaV2taMXpURWJhTU9z?=
 =?utf-8?B?bjVNSXNlUTc2VVV5YmMzclFLSnh2cittemY5OGNkS3ZySVNGYVpLakJUZ3dQ?=
 =?utf-8?B?a2tEZko0RGUyN256WnEzRmczUGFwblZ5RytDOW5SUForcHJyMmlWRk1GQzNB?=
 =?utf-8?B?eGtjQzBuMzRKaFhWTTZYbndqUDFUQ21aSE1GbnZPMlhqMDI0K0JyaGRxbHRv?=
 =?utf-8?B?L1lZcGh2c2RRL1V3Mlp6TFd3M1dIQm9mcEdqMDVnUlVxMHJHNi9iaXNkNWgr?=
 =?utf-8?B?QzdmWXZRU1dBVUF5RDA3blF6dGVMcTlWeGN1KzJObVQzS2tRVk1KNmhaeW5W?=
 =?utf-8?B?TEROU1NJTVBIeGhtK05Gb3NhOTB5NHRVcTdHWjgwS2VBSm95bkh4bTZ1SWtH?=
 =?utf-8?B?UDQ5RDJBeWNlU3BLTC9hV2dBaHJFUWE0NnVyc1UwbnhvR3JqSVhzY2ExeHRD?=
 =?utf-8?B?enVFb1gvMm55MGltWlh3ajRIY2Z2cGQ5S2JCblI1MmoydUVvWnEvcFRBLytO?=
 =?utf-8?B?UzZmT1lUNzF1dmdqUjFqbktlZHZEOTZtcFFaTkZaUiszaGppTWd5c0U3MmJn?=
 =?utf-8?B?YmxOdVFaWWRvU2dYMWk3cXNoNkZuZGgxUWtRMTVnbmdTV1FGeHIvUHpST1R3?=
 =?utf-8?B?OUhJZHAvTWh1K3c3dGo4SDNRcHo3TFZkRVcvMFdWNTkwWGEvd0ZnM1hndzJu?=
 =?utf-8?B?bEdONlV3aEFWN3BJZkNTblVyY2w2dTVTMEt2SmU1bzZ1QjVXeFdZcmVVUytI?=
 =?utf-8?B?U1paOHo1ZTNIbEE5QWlRN3dveWRRVU5ZbzFtOXNacDh4WXYyT2pZbEJxOXJT?=
 =?utf-8?B?SDdZa0RxdjFzd3RJakdXNmhRNVJqdE5SMlNhakFzUGVNeFBMNVhORTBUVzFH?=
 =?utf-8?B?ZGkyZG9SQlVlU01UNWVOajhYc1g5algrdXRUWEVEYmFzaVZTbDNjVEIwOVQ2?=
 =?utf-8?B?UHc4TTVVZWxhc2ZjcG1uRnFrOEZ0UndFRnVmeEtDZm1iWUErTWxOVFRVL2xn?=
 =?utf-8?B?U0RjQ2dmRjdab01naDZXU1JLMDVDMVpTSllDd0VaVEVnWlFXT2Nvb2tzV2tO?=
 =?utf-8?B?SVYzQktLLzluSmtoeUJPTEdlc0loVGpUeXJ0OTcydlQrcFJaWThxc0N5Vm4x?=
 =?utf-8?B?WXd3R0Y5M0hra2d3cU5COGM4VXpha21yMWs4c2drc1F2ZHhwbUR2MWJvam9L?=
 =?utf-8?B?amVrdXlXcFp6bkppN1ZkZ2VEbHRydXcyQVFHTUtkRXdsWDBvKzlnU0M0WmVy?=
 =?utf-8?B?SEZRZVdFV1JFdjJpYnNSS3dDcTZ5MTgvSnpPNlJmRFR2QkRSTmRTSEtGQjZI?=
 =?utf-8?B?anJoU294OC9XbkhNUUphTUpWV1UzQy9tbWJpYklQU2NuRzZZVzVHczF4cDdh?=
 =?utf-8?B?ZTdsS2VZdnhLOGxqWFlnRDZBb2F5RjVyZHJiZmUxYWI2ZExOOUtqbWlXU1Jh?=
 =?utf-8?B?dEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3fac2f-7a5c-4120-a156-08dbe1d95469
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 10:39:34.5461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45zn8EoVvAqR0HTvJ+S05l4dOZCXxcAuzN4CQ+1WCd11Ujm5OgzkbEfr1x6rbQ1jDLV1eqVaWIEhRBjz6M8FDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6626
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Nov 2023 10:39:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13566

On 10.11.23 09:05, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> When artifacts are signed with sbsign the images are not reproducible
> because the signatures includes build time-stamps.
> 
> This can be avoided by creating the signatures on fixed time-stamp
> (SOURCE_DATE_EPOCH) using faketime.
> 
> Fixes: #83
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  .../ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb   | 2 +-
>  .../ebg-secure-boot-signer/files/sign_secure_image.sh      | 7 ++++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb
> index 546fded..57ad1be 100644
> --- a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb
> +++ b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb
> @@ -15,7 +15,7 @@ inherit dpkg-raw
>  DESCRIPTION = "Signing script for EFI Boot Guard setups"
>  
>  DEPENDS = "secure-boot-secrets"
> -DEBIAN_DEPENDS = "sbsigntool, secure-boot-secrets"
> +DEBIAN_DEPENDS = "sbsigntool, secure-boot-secrets, faketime"
>  
>  SRC_URI = "file://sign_secure_image.sh"
>  
> diff --git a/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh b/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh
> index 0c9b898..213cf8a 100644
> --- a/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh
> +++ b/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh
> @@ -30,4 +30,9 @@ fi
>  
>  keydir=/usr/share/secure-boot-secrets
>  
> -sbsign --key ${keydir}/secure-boot.key --cert ${keydir}/secure-boot.pem --output $signed $signee
> +faketime_cmd=""
> +if [ -n "$SOURCE_DATE_EPOCH" ]; then
> +    faketime_cmd="faketime -f \"$(TZ=UTC date -d @$SOURCE_DATE_EPOCH +'%Y-%m-%d %H:%M:%S')\""
> +fi
> +
> +eval $faketime_cmd sbsign --key ${keydir}/secure-boot.key --cert ${keydir}/secure-boot.pem --output $signed $signee

Looks good to me. Quirin, any remarks?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


