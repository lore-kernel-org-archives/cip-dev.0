Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE179C48BC3
	for <webhook@archiver.kernel.org>; Wed, 14 Feb 2024 12:36:11 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.88])
 by mx.groups.io with SMTP id smtpd.web11.40558.1707914164690901154
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Feb 2024 04:36:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wWTblW9A;
 spf=pass (domain: siemens.com, ip: 40.107.8.88, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndDyx0Of++y6EazsVzgrr2DgylSEwedlGEzOYDTuyKkMqwK0jlzRRd0c/lThwjBQWIJQRytu5/M8Z0Ag/4UgG3ifuxBjPu3iYLnlUQ62i9B8F8QOv2jwspE69guQaga5GoAtBWxcu821ZKLRM12TbCLb3YzjzjusQ+tdbjnUh/jWJUvPd1tTegi8rBAO3RyLBB+ox4NWhZqhnALS2zJDHjBOlWJxNdf8yLcnE9jI4F6o9h10ifpNVhfmvVC+CcxyRToUzIgIKOem3RX0CVVpHNQOqmFn8kihZdJxS98rXJh6n3ExYCjnSkcZR5VxyZDkQ/N0Q76rSMdwYe074yvE9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YO3UvfT/IzBdPARvDySkdd/GMVsS51j9O8QqMqy/+cs=;
 b=nV86F1FLkpLruKetMh4bqFIoeZ1OgDMB7DJ6MnSrtiw/7oB9F2H2KdgZzHg0T00i+tskL7ReZ8uljiRGs/mo1d4oYSDMHqvCt0SjaTVN+2MaW06wRPUaA7y4xsKlNhYnPMRbJzjVSn03DEpvvnSTBBx4D1jgA0I/2C/ij+ZNn6puTtG+nfgMsySSjZqPHmfSt2Zn8eT/HoxZVG5Lp7qIiVwHRbOOtB3Bzoc2m+Nco27zb/RpJA3C8RyImuOVm4t/653p2H6VEMSo2OAhbAC6kWkmqRxcHywReJSgtg+APSTyFCMh/Uk5hNOrgkH23vMcnvhq51yjtMLaBfKQPX9ZRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YO3UvfT/IzBdPARvDySkdd/GMVsS51j9O8QqMqy/+cs=;
 b=wWTblW9AuxmbzW42e8xy7bykjDOLc+bFWg5qBD3CoaOAHRo6LoURB4nRZOtLd4p4fyWauBXrC4Fk8wiT2sfskIwMG8i/9TEEjaSh7pZG559cOFW/ELG0PYUJlR8/BbceD8iQHneirDP6bi8uIdSn8bML0Lt8BkVh9f6TFARgn4Zq0SEJlxHAeMvdmoeeBBZvBvnXbHgZSxx1C5PyYYw6TYEOojpw5zTmIKxrc+0R0kn0bfJExFszNMVej4yzLWLmp4Zy8QcYf/6kO6sKJGvsfITUq17HrkExK0L9KolGqN85+y1bPUDJO8cu/UrSAUDWPrccWUT+B0dJ4Dp0DcExAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8088.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 12:36:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 12:36:01 +0000
Message-ID: <aeeaf536-bfd4-43ff-a4ff-f4f19819a27d@siemens.com>
Date: Wed, 14 Feb 2024 13:36:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core 2/2] .gitlab-ci.yml: Add v2 QEMU security targets
 for swupdate testing
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20240214122809.3541505-1-Sai.Sathujoda@toshiba-tsip.com>
 <20240214122809.3541505-3-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240214122809.3541505-3-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc06bc3-dd01-4409-a7aa-08dc2d598078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qBbpYHAc4quS2D1xAqfhKB6ztMMDEEKSWtMZnFzeachfaqdTPhWudF1S1tSMZ90AZg6HmHf8Qurwwamt4Ivo9Y5JXE0rQsSaFAtTU0QZ6j+522a6dg75rqvF2Zi7JUJBzDL7rP+vAkyGp+SYadcueNmTR/F/y/RL1R9c5Pj9H2nlxgVhB0JGOK7pIT2rGTp3Uxj923Qa8Hj6Q01myG03NbgsxyayT4LQUgghUeB1mvJdUh0lC0dT/3T36AlDSRFqzbS8yTtOBgbRk07Igm2GvfQC6NxmRmswSlNTpsYEoTAI7JF1rp9bqVP7bYxQTE9a1tUwTv7NtsdPXgZdIh13bPWFSaYpsPlqp+qwrDxm+YYXjaj7fCR2T45M7GV6ak5whdo9IwjqI0fMrl6imaROMg27+d1dOr8WDZb2lQVH0yX/5tvNy0whAfKxdQIjiDsub+dV8bg3mpZoBd7Fnd1sXPjeCDYiaiw6q494oQGFMNKkthEhzXqBMk3PH5HKN4pRvU9WfK/bhDsSngj+vTz/sJNlf+CHbvKU6eFfOHdMXDFakZwjG31ALC0ZpyHS6tIV
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(36756003)(86362001)(31686004)(15650500001)(82960400001)(66946007)(5660300002)(66556008)(66476007)(44832011)(4326008)(2906002)(8676002)(8936002)(31696002)(83380400001)(38100700002)(478600001)(53546011)(316002)(6512007)(6486002)(6506007)(26005)(107886003)(41300700001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YVJRR0I0NFhtVVB4NXZXekw5MkZ4RmxsbUQ0K0lwMGpQMmtpRWgrbmhwY0x1?=
 =?utf-8?B?QTRHNDUrWUR1QkEyclpoazhvMHgvNVBIM21yRVlvT0pkTVZ0bDV0TDlEcE1Y?=
 =?utf-8?B?NGJWYUQ3blg5cXVJdXljMGM4OU0zcjgwVkE2UnlKaCsyeEdCcG5rMjBzUFNF?=
 =?utf-8?B?L0xFeEF4WDVjUG9yZVhkUFdjRUFiM05McmFvOTY3R1IwUVROV0l3b0FwMkpF?=
 =?utf-8?B?RFR3WldHQWdId3h2QTAyTFJlcUwrSTB2eHgyei83eHVtRTc1YzVwdmJyb2Nk?=
 =?utf-8?B?Szk0RmFtU1VTTFJLVHNGOVRhSjNGN1pQdXJjcFdhUVE0NllxRjZjYmllcUU1?=
 =?utf-8?B?dERxZndzbzhJaEI2OWJubkNCUUVRSUtsai9jU1licndaOXVoTDk5dHpIQnZ4?=
 =?utf-8?B?d1ZLT1FyRlJYTnpKcnFab2Q4WEpsODNIUVJqbTFsOUpkK0cxWXdtaFUwL1Bh?=
 =?utf-8?B?UlZxd3VzeU1yVlUyMGlnM3dwZkRIbmhPQ01DV29KZkpBMVZQRnN5cUxTVnFM?=
 =?utf-8?B?by83THdOTXIyMUluZ0VIMXNzR0pUQ0YzWGExQ0R6Tmh4Y1BMeEl3VTB5L09l?=
 =?utf-8?B?WTBXVy8rRmUzdEwxOFRCUC8wdjFYWU5zclpRcjF2YUZ3WFRjUWJjMWtjN2Iv?=
 =?utf-8?B?OCt0UGxLazFpUm0zRkZyUU9qTlFwOE5NQitCeUhBd1J1TngwUzMrRlFrVU5U?=
 =?utf-8?B?Y1UzVTRpbzU2QnJRU05wamt1djRxRkR4TElCcWZSK1R1NW8zMVU0Y0Fqd1VJ?=
 =?utf-8?B?ektkNU1JT054ZFZ3Ym5MbzE3YThCNnE2eFVDSXpXNmgvT3pYRmpRQ1dFUldB?=
 =?utf-8?B?Nmt4aE8vNWFsWC9LdDVtNENYZXhvNnhBeHlKRkcreXhtUElOSTI1dDJNeDlz?=
 =?utf-8?B?akREeEVVaE96OFJ0T1lCcnNRV0VOZmQvb1dmallCMXA3bDQwU2VXb0h2VXBZ?=
 =?utf-8?B?RG95YVhjeHNOY09kbiswU0EvVHRpdWE3cTRFZWxjQVdmT01GYTVGOVRiZEEv?=
 =?utf-8?B?anB2U2laQ3FGWVd1dUloem9aTDN5VmtqcGJ5T293eGJKUjlQemdhZ2hsQ1ZO?=
 =?utf-8?B?bTA5SjVjWVZCM1liWHZUb3VQZXhLS2I3dWJMSlBBOWhOdGJ6QzI1WC9YVW5p?=
 =?utf-8?B?enhTOFp1eE9aeU1ZQ1hhS2tiWCtXVVJhNmR4VXN2SjQ2ejZ3NTA1amQyb0da?=
 =?utf-8?B?Nm9GMU0vbkFJVkI2TDlRMWxoNjYxWExudXorVVp4MVpmMm83V0IxdVRzcWEy?=
 =?utf-8?B?S1FWNkhrTldlTFdydVZjaU9mV2V5c0dUV0ZQZWdaVlMzRER3S2ZGQ21LWllP?=
 =?utf-8?B?UUdrSHRzcUNZdXd6cHZnNVJZa3c1SjdaN3BRd0haUGpYclVQQk5BenBURXA4?=
 =?utf-8?B?dGYrTUV4eFNYak5EcUQ1ak9CZllEdEMvb2NEaVMrK0hwaWxGcUcrSEtrMmdM?=
 =?utf-8?B?Z2Vrd0ZuTUR0eDNvcWJtZTRjNDAvMXg0MS9DVmZzQlR2RU11aytYY2g0ODly?=
 =?utf-8?B?OHZObTI0eHZPN21OUUExZk1lbkNhK2w5dEQzYlNUbEFqT1JlWUE3ZWZoaG0y?=
 =?utf-8?B?cnpSNjA1bEMxTlRqZDAxYjJ4anJPVVpXZmFaSWlKSG9CR0ZnR3lvOTh3QnFT?=
 =?utf-8?B?VzVzWVJqVEd3Rmt2WlVKRGdFNDM0K3hySW5zZkh3RFlsM0UvTHFkeVA4bnR5?=
 =?utf-8?B?TlVSdjRjaHpXdFF5eVVhNDNFM3M2UXdXL2lOdWp6cFNuZHVyUVV0di9CS0Jv?=
 =?utf-8?B?S2hTQjhJM0FqM1hVZDB5bVQ4dnB2RlhhOGxJQVNOUWhhdDNwd3ErWWN3Tkxk?=
 =?utf-8?B?ZnY1YStHTnMySWE0V28wdkc1WnRpL1JKcmRidmFZR0YwU1lNTCtxRm5RM3E5?=
 =?utf-8?B?UDJSQk9qTCtWR2JnUnV3d095enRuYlRLQ0ZvSjdDUmJoK0grMFE3eUg2dzlV?=
 =?utf-8?B?VkJqdEo4UzZEOCs3bVVDNjlkemUreWt2NTFNdFVPN2oxT3pERkx6cW0valQ3?=
 =?utf-8?B?c0E1WktYcGxvdVBod3FEYW00N0txMStvWnBxMVdQZ0RVSUx4c0htZjMyMldz?=
 =?utf-8?B?LzZlM3g1ajF3eDJGNTdRSUdUeUZ2b3VWMFhoSXZDU3dWaWpvVm5FZUd4eWpy?=
 =?utf-8?B?NTZFbkM3R3czWjErdzIzZWNlZWJxVlUzV3lYZWVqMmpXb1pWSzg0b3c5UkxL?=
 =?utf-8?B?ZWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc06bc3-dd01-4409-a7aa-08dc2d598078
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 12:36:01.2091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KS2pLssli5JSI8D6pqYKTOaWO7kHbuejlgkS8Bx3+TuhzPjb4/CTKGAwHsjBzy1TFieWw+hwN5YXlZvUIZWh0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8088
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Feb 2024 12:36:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14967

On 14.02.24 13:28, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
> 
> For LAVA swupdate testing, v2 QEMU security targets are built with a
> minor change in cip-core-image-security.bb. and their .swu artifacts
> are deployed to s3 buckets for using in LAVA job definitions.
> 
> Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  .gitlab-ci.yml | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 4f87ec3..c7837f4 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -25,6 +25,7 @@ variables:
>    dtb: none
>    deploy: enable
>    deploy_kernelci: disable
> +  use_swu: disable
>  
>  stages:
>    - build
> @@ -63,9 +64,10 @@ default:
>      - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
>      - if [ "${release}" = "sid" ]; then base_yaml="${base_yaml}:kas/opt/sid.yml"; fi
>      - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-partitions.yml"; fi
> +    - if [ "${use_swu}" = "enable" ]; then echo "PV = \"2.0\"" >> recipes-core/images/cip-core-image-security.bb; fi
>      - echo "Building ${base_yaml}"
>      - kas build ${base_yaml}
> -    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
> +    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} ${use_swu}; fi
>      - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
>  
>  # base image
> @@ -106,6 +108,18 @@ build:qemu-amd64-base:
>      wic_targz: disable
>      targz: enable
>  
> +build:qemu-amd64-base-v2:
> +  extends:
> +    - .build_base
> +  needs: [build:qemu-amd64-base]
> +  variables:
> +    target: qemu-amd64
> +    extension: security
> +    use_rt: disable
> +    wic_targz: disable
> +    targz: enable
> +    use_swu: enable
> +
>  build:qemu-amd64-base-kernelci:
>    extends:
>      - .build_base
> @@ -128,6 +142,18 @@ build:qemu-arm64-base:
>      wic_targz: disable
>      targz: enable
>  
> +build:qemu-arm64-base-v2:
> +  extends:
> +    - .build_base
> +  needs: [build:qemu-arm64-base]
> +  variables:
> +    target: qemu-arm64
> +    extension: security
> +    use_rt: disable
> +    wic_targz: disable
> +    targz: enable
> +    use_swu: enable
> +
>  build:qemu-arm64-base-kernelci:
>    extends:
>      - .build_base
> @@ -150,6 +176,18 @@ build:qemu-arm-base:
>      wic_targz: disable
>      targz: enable
>  
> +build:qemu-arm-base-v2:
> +  extends:
> +    - .build_base
> +  needs: [build:qemu-arm-base]
> +  variables:
> +    target: qemu-arm
> +    extension: security
> +    use_rt: disable
> +    wic_targz: disable
> +    targz: enable
> +    use_swu: enable
> +
>  build:qemu-arm-base-kernelci:
>    extends:
>      - .build_base

This will build v2 in a separate job, no? Means, you will not be able to
reuse the 99% of the build artifacts from the v1 build. Or am I missing
something?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


