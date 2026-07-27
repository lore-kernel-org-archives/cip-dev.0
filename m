Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56264C53209
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 17:10:56 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.69])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.36370.1785172251364991846
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 10:10:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oh6SYCdy;
 spf=pass (domain: siemens.com, ip: 52.101.66.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAvSFVCYvKwhW7+0tsjP+opNx7hDEFr9H/MWW5ctQw0khlvALKXBCeaVIe0mxmApFMjuXZ4g2P8xJovU+I47rC6GFm+li20+D0EKLrR+SUF4roNHBvu3R0NsIpc1jmazoJr/L65nYIBWlvmpDEpZzYAV5GBzYkywPYFgqqSbVnG1b1pa04ye9gNdMWYmLmk/hH7PgXiSvPCd5Dz6MPgotjSXfWmWDPbX2gUsY/lN/tp3L99SAIZRFhJ2AXPlLaQbwk8EQDU4ePb9OdDuk9AZI006EgLLm77fAEBalIsEkDm46LrhBoLaEgm/fPx040e6habqSpJSswa7QntSQp+tmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Lx4YR6/qAZjo7yedubAEwcbc9KW1pTfhUv9V+xhNMs=;
 b=hCyGj5bnSqbwMm6RbDvtI+8p+JxsaF6cpWB4go1YuDVblcHuaoX4+yflp9fQveQr7QSn1xG4KTI5La3cQn5nf2bQAoUmf42z73RMPADYZJqZmtN8SwQPXJYLX1r4SEH2DALdHfOCM989Rr/6egnZlz3TMTuFNKZSGEXAJHQA2ypNxWk/gp3lsNHA289Q4kSjGzYVWHDM4RzG9BnqSsN4BVEOY7zuaAX/Au26PUSf8gB5uQZ55ZC+o/jIWH9bbmqTw0eRwQb5iKmKXXbGds18gJyl+svlJ3sblwSf6g2oLPXJ2wMJZVZ1252UEDw6mIB4G4UZfp0ee3dCII0H53j/pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Lx4YR6/qAZjo7yedubAEwcbc9KW1pTfhUv9V+xhNMs=;
 b=oh6SYCdyJEx7fK2sIcafxqpt8ob4Jqo2VVocyp/dsq9m2TTnJ9/qB3h9MKEf8zYnoYz2LsYhF85TXWIbZIc1mAmy50kxhYBTsBGpTT/JSwSpsjPvR3iXyl0fkWTyGKl5QsrFLRfaG9O3GV3DuG8AHvGi+KtZlnyKVFeTAxSMJ1xlqYAWGuMn6LfKEjl+xKxbfS9chjdavm7z3qwt/JLJ546wrzTu+jANKiEzMixz32eRzBuzDn0/le5rpuHnOE18zurH49MAF9h4YoDvOnnoSnxp9HDVGofu4cmQE5R0ayO+BRjG2VfXRxeM+6xqeIVrveyXgpsLPFbPmR29sJpZBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5310.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 17:10:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 17:10:47 +0000
Message-ID: <8630a39b-ab0f-4754-a7ba-364be3cd6bc8@siemens.com>
Date: Mon, 27 Jul 2026 19:10:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1 2/2] Enable CI image build and test
 support for forky
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: kumar.dinesh.h95@mail.toshiba, kazuhiro.hayashi.f74@mail.toshiba
References: <20260727141136.1773671-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <20260727141136.1773671-3-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260727141136.1773671-3-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0282.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5310:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c734b1-d42f-4f40-ef8f-08deec020027
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|18002099003|55112099003|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	hlCiiplgRpI/c+XK736Rzqiz2gWHECdqBUBAELWXQnTEt/Xrs8+X6BzF74hRTGBS/DDpcvki8HAwoW4PMfgExfwTkRRDM9CXXPKOAgMYnFXHtQvD3jUodn+go80bb7anPgu95BLOouhHI0l4/pOml2sSFoCdHaUSXnscADhBxSCu5KSm+/7QyQtrHQK2i/ApBEt7cHmqugroAsjFwzNzOg5QmpG/drK+bjKJ9BpFZD9vdqYY0CqFfD8EF2d0A2g1jgDHpaH/rEq6DSjRhVuu1hessuj4HEc9+owldwsQrPIacbdfeXc6bA3OMvbGFBf3IgHnwv5L4+lFBEvN1XRU5TenZ5OWf8Kvxejiza0z+FYZmfRKKTci6Eb/winTR8KhAJQt96/1hyV2cZnbWABovdN/KsaLlNIAy/2m+8YOn+IVH0hHp9IJ1xf1eZFDRlUSPUfTTpX+tey22H7syYT3j8hLNuDDURsV+crcIpf+4NnPT2uoo8pLKxm5OJmMcse3F2lD7XJGY80KHqSYAegewrhpPeU+11b4YW76ilK+rzRbHsCmhM5mMLIR4Def7YeGDcoZraW9nIJbxDBmfFuIza8gr/83DbhyE6IClGXQZBvK/W9aW9JYD3nNiX3r3r+TGQ4m+aCeW7rEBGvsMcN5HUyof1BQB1lh0oxBsN9RNGA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(18002099003)(55112099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S3NCTDdCTjYxQ2dwcXBKNnB0SzY1QUUvNm5XQ0lmSTRhSjYzcHQrVW8vRjNV?=
 =?utf-8?B?NWczYTF5NGNpa0ltb3RhRk1OM0d1b3VCUWpkdzB3RnhmY0htR21QMGRobVVB?=
 =?utf-8?B?elpjbXBsSjdRZjNBZmoxYW1ZeEVVcktXZ0MxSFFoR0M1cTk3ODlrMWhiUlpv?=
 =?utf-8?B?a0ZQdEpsRWJzYWZOQlZQOFZCNkJDbTE4ZHd2ZFBoM0ZrU0NMQ3M5RGJBR0pa?=
 =?utf-8?B?MllKc0N2Yi9WRGExVjF2clhvMkdKRVFPUGhuOEJmUWNzNE5VRlluNFlMOXJw?=
 =?utf-8?B?ZDNrcW9oeTlOeW5VeFVQR2llMEN3QW4zOU9vZmk1enJwRURzcFpuTVlWS0NN?=
 =?utf-8?B?ckJUMHkxMUY0S3kwS1Vxajc0QUdrcFplMFBoZ0MvYW5WcUJHdFhObkN3Nzlv?=
 =?utf-8?B?ZlBnekxtOEY0SFdDTU4xWERjcDllQWpLUWFORWpncGFMTHEvSXJ3U1ljbjV0?=
 =?utf-8?B?REw2elo4NldGZkkvUXF3YUV1SWpWMFJoZFRDUlI2cWRJTTJOQjNQSDF4VTVF?=
 =?utf-8?B?UGhoNG93Nlh1dGJMVDBORy90MnB1NTB2MEVDL3ZXOVJzYUI5QTJjTzVlc05H?=
 =?utf-8?B?N2gvOUUzSVNpYkVqNy9OMmdEbkYrdHczSkZGUDIwYlNSY3ZYRERRTGNVZ21G?=
 =?utf-8?B?NmVHaVBFSVpoNlRCVjFYMm4vZUNLZDNpb3BMdCtxL3o1eS9nR3ByeU9OWUVM?=
 =?utf-8?B?QXgrMjdCY1BpdWFRS21td3hZNnY4aUdmVG54RDR3R1B2TnAyL2ZycDZobHNR?=
 =?utf-8?B?NW1DRHQ4ZUpwamJQZGdsNThpZjl3UEV1WWY3dDgyVVFHZXVPYW1ORGFHVGFj?=
 =?utf-8?B?RGZLMW5Ya21WVFBTK2hzUHYzeVJtbnVvOTVlenphT3I5V2piQ3VCckpVWWVL?=
 =?utf-8?B?V2ZERkkwL3hDYW5tL2tmcHBqZjBFWXRZVkRQTnErdElQekNmM3FXSm9zWFFs?=
 =?utf-8?B?UW1Kdkt5akJRR3NZenlmQnBBRnBkbllaaWpZU0VKS21waGFFSEdScUdxOTlw?=
 =?utf-8?B?Lzc1S3FEczdzNzY5bFpwTXVOMGExMVhnZEZBT09UTkFTUjdSSXkrdWh2Nm5V?=
 =?utf-8?B?c25pTFdKUVVDT0U4OHdjMGtESytWaVloaW9JWXZqYUpmRWcrbWh2dnlLODdl?=
 =?utf-8?B?eTZRVkd6dzJJTWZqcGtzTmliSzB6TkE0T0hpN3p5YzNuWERkR3lKVy9UWFU2?=
 =?utf-8?B?dStEVmhIZHNTOUx6cmRwNmJPcFRuT2hqbmJSekhCdm1LRWN1RGRnRkR2aW9i?=
 =?utf-8?B?M24yYi9lNTFuQUVyeHRybzVZaE9RNi94NzBGTXdwMDNlNHpXL0pwT2l2czha?=
 =?utf-8?B?eGduNzJ1YmdpVlRTeHNNYUs5cVNxbkswVDJzY21BeU5FRjdMTW1oZ000b0pW?=
 =?utf-8?B?Tk53RmpXQkNYbzV1dE5BL043UEZtMGdFTldQZ3p3NGpLKzREZ21YcHJkQ2pC?=
 =?utf-8?B?d2tFL3RYOVFibWN2b3JJRWc0RFZhQXVOSU1VRVJLUG1DZXUvY0YvR1FtTnBp?=
 =?utf-8?B?Z285S1poTGtlV05YQ21IbjNZZll3a1J2UEJjUitFL2xQdGRTZ1ZMcVFXRDcz?=
 =?utf-8?B?WnR1YWFKaUpaTmJuK3B5anQ3K0JXYy9ZdE13OU5CdzBLQkdGU0pOM1NHS3RW?=
 =?utf-8?B?a1JMbEQwWis0WXhXQS9oZVNmY1prVXJwaXVGU21DSnlpTUZKNTZhaGl4OC9H?=
 =?utf-8?B?cTdTa1ZXMjE1ZVZ5MENJMkFCaDd0S3BSOW0rOU5tOXZmeG5hUFA0d01sVGJa?=
 =?utf-8?B?ckFVUU1RbW8rN0hLMFBiMzlkclRERldycVdkaHFqNWJFTnVzSW4vYTdMd1ds?=
 =?utf-8?B?SGNvcUZwNU5ndTV4bFh1WkRuRlFiN0lFZzN6ZmlyaktIUWFoQnE2QVQySmc2?=
 =?utf-8?B?cmRBSWF4WWdPT2xzYmJvclgwRXdFOXJ0QjhGSE9KZG1qcllJUURmUkdETzNF?=
 =?utf-8?B?Nmd6cEhkWXhsMDZtRnA4bFdXQVg3Z0dQUmFSL0pMeExzUHp4YU5XbW9oeEdP?=
 =?utf-8?B?dllKUmZwMXVlSG90ZExsRXhkYkpjYU94VnM3Ly9JTysrWlJWZnovb0dqWW4r?=
 =?utf-8?B?anNjN3JVRXdjWUhVaFpYb09NNGtsRTdSc2dMcjM3UHV2RTlFSHlBREZBY0tP?=
 =?utf-8?B?RGhYVGoxQW01ZkhpK0FHK2FUUFc3SjRaeDI3a0poK2J1d3FCTk1NRk9Za29m?=
 =?utf-8?B?TEkrZys2K0MrWkk0K3NrVzVOUmltY2ZDVGxjcVVJczhveUp1WmlGb2VGSEVp?=
 =?utf-8?B?eTNBNHhhVGJnd2ZBQXlLK3dwd3Joc0ZxcG05ZUY0U2ExbUpJM1ZIakh5R3RD?=
 =?utf-8?B?UEkyV3dlNlBBNFp0MUVYL2lXZEdnM3k4WXk1OFpRd0hya2RoZkE5UENvMUJX?=
 =?utf-8?Q?Fli7eXqNgU0uTGqw=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c734b1-d42f-4f40-ef8f-08deec020027
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 17:10:47.1412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0vRve9zBgUM/j2qYK2zoRLZxCQ9AygxaoMUOPOUQ4/w58L9WfYzGmLxXMTGEgCldIJ7z5Ulr6+qlTZvlIEXyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5310
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 17:10:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23786

On 27.07.26 16:11, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> 
> Keep these jobs as scheduled and can be scheduled to run every week
> just to monitor and fix if there are any issues.
> Also set allow_failure:true for these jobs as forky is not officially
> released and there will always be some build & test issues.
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  .gitlab-ci.yml | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index b53def4..977ae01 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -64,6 +64,7 @@ default:
>      - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
>      - if [ "${release}" = "trixie" ]; then base_yaml="${base_yaml}:kas/opt/trixie.yml"; fi
>      - if [ "${release}" = "sid" ]; then base_yaml="${base_yaml}:kas/opt/sid.yml"; fi
> +    - if [ "${release}" = "forky" ]; then base_yaml="${base_yaml}:kas/opt/forky.yml"; fi

ordering

>      - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-data.yml"; fi
>      - if [ "${factory_reset}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/factory-reset.yml"; fi
>      - if [ "${watchdog}" = "disable" ]; then base_yaml="${base_yaml}:kas/opt/disable-watchdog.yml"; fi
> @@ -399,6 +400,57 @@ build:qemu-arm-base-sid:
>      separate_home_partition: enable
>      deploy: enable
>  
> +# forky image builds
> +.build_base_forky:
> +  extends:
> +    - .build_base
> +  rules:
> +    - if: $CI_COMMIT_TAG
> +      when: never
> +    - if: '$CI_PIPELINE_SOURCE == "schedule" && $CI_RUN_UNSTABLE_FORKY'

We should handle forky and sid identical for now, thus should likely use
generic CI_RUN_UNSTABLE for both. Forky can then be moved out of this
mode somewhere next year and become another regular test target in the
pipeline, sid will always remain there.

> +    - if: $CI_COMMIT_BRANCH != "master"
> +      when: never
> +  allow_failure: true
> +
> +build:qemu-amd64-base-forky:
> +  extends:
> +    - .build_base_forky
> +  variables:
> +    target: qemu-amd64
> +    use_rt: disable
> +    release: forky
> +    extension: security
> +    security_test: enable
> +    build_updates: enable
> +    separate_home_partition: enable
> +    deploy: enable
> +
> +build:qemu-arm64-base-forky:
> +  extends:
> +    - .build_base_forky
> +  variables:
> +    target: qemu-arm64
> +    use_rt: disable
> +    release: forky
> +    extension: security
> +    security_test: enable
> +    build_updates: enable
> +    separate_home_partition: enable
> +    deploy: enable
> +
> +build:qemu-arm-base-forky:
> +  extends:
> +    - .build_base_forky
> +  variables:
> +    target: qemu-arm
> +    extension: security
> +    security_test: enable
> +    use_rt: disable
> +    release: forky
> +    build_updates: enable
> +    separate_home_partition: enable
> +    deploy: enable
> +
>  .test-cip-core:
>    stage: test
>    image: $CI_REGISTRY_IMAGE/lavacli
> @@ -764,6 +816,47 @@ test:qemu-arm-IEC-sid:
>      test_function: IEC
>      iec_test_timeout: 40
>  
> +# Tests for forky images
> +.test-cip-core-forky:
> +  extends:
> +    - .test-cip-core
> +  rules:
> +    - if: $CI_COMMIT_TAG
> +      when: never
> +    - if: '$CI_PIPELINE_SOURCE == "schedule" && $CI_RUN_UNSTABLE_FORKY'
> +    - if: $CI_COMMIT_BRANCH != "master"
> +      when: never
> +  allow_failure: true
> +
> +test:qemu-amd64-IEC-forky:
> +  extends:
> +   - .test-cip-core-forky
> +  variables:
> +    target: qemu-amd64
> +    release: forky
> +    test_function: IEC
> +    iec_test_timeout: 40
> +
> +test:qemu-arm64-IEC-forky:
> +  extends:
> +   - .test-cip-core-forky
> +  needs: ["build:qemu-arm64-base-forky"]
> +  variables:
> +    target: qemu-arm64
> +    release: forky
> +    test_function: IEC
> +    iec_test_timeout: 40
> +
> +test:qemu-arm-IEC-forky:
> +  extends:
> +   - .test-cip-core-forky
> +  needs: ["build:qemu-arm-base-forky"]
> +  variables:
> +    target: qemu-arm
> +    release: forky
> +    test_function: IEC
> +    iec_test_timeout: 40
> +
>  cve-checks:
>    stage: cve-check
>    needs: []

I'm still wondering what the added value of testing sid for us is. I
would rather consider to invest our CI time into running more tests with
forky, like some more SWUpdate checks and/or reproducibility.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

