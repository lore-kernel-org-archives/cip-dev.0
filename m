Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229C2C6FA8E
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 17:40:32 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.48])
 by mx.groups.io with SMTP id smtpd.web10.24699.1677260421283476937
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Feb 2023 09:40:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jlsF8SDq;
 spf=pass (domain: siemens.com, ip: 40.107.14.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOz383G3NnU5u/kmT4+wM3Pge04D55Zj1N4AlEBXh01dAcOnRtvdkeTg/PIQPoD8pt4agcpIumAnUsbRLuXQMAnBbGz1VKDvP0jJT8RIyEJk+01OaSjz18tt6QBxETYqX30LgcL1gYnybke7tv4lb/S7j88NkOwAnjzBa05qE+MAqWiai3Ja4E66D7kk9cbViuh0XtM2AnUtnnobPhEPvRRI2CE6Y4A1WmLmNGp2hAnpc/imlgqD4ZrUgtYgWZD9jHsOIBIoGWDH7xwKk6LBGFQlyjD46Uddt2FNfR+zDQ6wvBqtehRPjoDqHj6dvwkzXDp4Ows60ZQoWn+DDwZ+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OId6tNW+a0Twbh+ETcJScjMgftmaOdLVFvu+fkfYWzQ=;
 b=ArqvKl9yQaTNMkR9Oi4scQ1ehOUpIREDr9dTyhbdpVO85B6ATC0Nu2W9FWZ4kV11JkXekZu0rf+4G4Uwdk0DcyFLoIkJQAiNijaucROtsbHC/mcTcnOL6iXl9fdhR3VoMXEZgSmA+2E8xfqzJvWsDR4QnDdFBs5jLkvBb9DDBOOoE1ofr7llQ8r/+gWZtgv0i3ipGxHqE8KkksQ81gXJs69YGZ4iUAJ9Iya1e2CCJ79BbrbJZ6uL0rIu/a4juWqw/PcpbtU8E3JA18tBdSZXA9l/e/GObdNFvbe2cME5OVsY6ZD+Uz3g7heZkgy8LvluAALPnCR2FrRLPahaFUAG6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OId6tNW+a0Twbh+ETcJScjMgftmaOdLVFvu+fkfYWzQ=;
 b=jlsF8SDqi1BY09uKk9o7F0dsAKgmfsDs2+hCWVRKpofHvmHbQEJy/9ELyiqnX7x9yjAXHjGpsuRVoWosWIfW1O98WujCc2ZmCJZYtLXKbw1NnyxY7ey0KjtKnGRayFQ2zAKmXfljhw15BDPLFlJl6mf7nDUCgObpr8uNOmefb+lQun6SClQoPmcN0Tn78vaw9oAPihJM/xGxb36hrYUW9w4diZnPlYEuiABqNblvumbkoKkpOjqNFEDWDb7pxiDw8qenG0X2N9Y3PEgyesTf43RRbegyi6M2DQzO2ZzOQI3gyaQ0Hj3Q/bjxMEtQyCGszw9Zg29QNsX97pcrFOmZvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7321.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:607::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 17:40:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 17:40:17 +0000
Message-ID: <797e1eac-eb09-bd36-b687-24e0a52acd2d@siemens.com>
Date: Fri, 24 Feb 2023 18:40:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [cip-dev][isar-cip-core][PATCH 3/3] .gitlabci: add riscv64
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20230217152556.516948-1-Quirin.Gylstorff@siemens.com>
 <20230217152556.516948-4-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230217152556.516948-4-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0147.eurprd07.prod.outlook.com
 (2603:10a6:207:8::33) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0b30b6-f671-4864-f06d-08db168e3181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CgJC2o4l9ZP2prw9JNNvfB8GXsXfVlQKmmCf6eyjE5sZLjlDYDQ3VW5YUJqtvG0I0+RHxR0ziWyvQXs/SRy4cfB0oBqu4lK2ytGSPSAatZxge1MZiEQSEeVkf/iil1bTuzVGCiHbLNtKb9mZ2iLpDIgakj6GhDN4Avg6/stXrD7/mGBHESZ2m0ihzgOY3DWpHnhljPeiJQCqKJd+C/aEKv3lQW54KDfIW3A0VfgZ3qf3jcg7Vxsl1K4C7sMLFWLISUieUp6IzfuGOOvFLhsLcLde4Vbym7Ef5zWGYKlse/p1IqHGjzLKQccO6h+OgLDb8aKsvgltW+oinVR8pJ1UXzrHw65wUXyk9f3vH3Q31DgatnSXyBIotLizkiFiATNdRz/qNqchNb+mdNRnItU745y+Fc4+ntgbKJSnDqf2yi0Kkpm9bgsYEY+a9781pf6ggF4y+znTCpNmQJWoMfZF16GUrbuNgtZa/A1P4qRqVMSfZ57cALiL2XNHOvxmKi7JD2Pm30xiJW+VNsswIdNyElopSwzH8Ix/SKeRTSFpw+kqu8tqPEtkVHVt0WBIAB8hXH8vJl5X3EfpJKsW09+zY4qbASOF38EXp/d8SEdc5zLh1lJFe26KgoagS4ZlhWenHT/n43UQFGSo0Koocqtx15+r5a9mtjCNkXtJYG1kvXprmIUhzUudwAY93rfTxA3VKG08qpbcw+RaHvoZ8gU7MOP47hiAvN5Afod0xK6BNYk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199018)(2616005)(6512007)(6506007)(26005)(6666004)(478600001)(53546011)(186003)(82960400001)(31686004)(86362001)(31696002)(38100700002)(8936002)(41300700001)(8676002)(44832011)(5660300002)(36756003)(2906002)(316002)(6486002)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a3RLRFhNRkswMXhsNUtpTUkzZmZHN2g5NGQ1TTNBemFqUUIzbkZTQkY4Sk5X?=
 =?utf-8?B?YzJ6VEl0a2tJUnhXV0NZRkYwbjZ4YTYyVWtRdXJKbFBvc3JocGMwN1pkc1JW?=
 =?utf-8?B?UWxycUVKQStHTHZUc0dXOVRlOWxnaEtETno5TFFpOTZKZDZSQnU2eU9oak9H?=
 =?utf-8?B?OTBmRmsxeUs3aEttQUZOdEh2SDc1cHJjZldHRVIzUWpkOGdHSnh3MXZlaHZp?=
 =?utf-8?B?VG9wWWJFYnZmSWdkajh6dmw5aDVWWXNqcHRvdnlWbVBDdjJ6RFlqaHNsQ2Yz?=
 =?utf-8?B?TlhvMURqWENZZ05nUkZyR09zVVJaRnNPRUVDV2hLdGdHUVZXRDYzc2IwT1RM?=
 =?utf-8?B?RTdyU2JkVGhXTWlhdko0d0NrT2VPZ0w4RFlUU3hDb0ZPVlJnQ2VoL3pmVncw?=
 =?utf-8?B?cmFKZTBjbXdXRUU3eG14MFM3WisycEhzcmxBci9BWGhKUGswbXhXTUM5cGJL?=
 =?utf-8?B?NFVXTlQzZ0Q0ajdUK1RpUlBvU093TUUva1cvdEJERSt4dHkraG9ET2pXQkNy?=
 =?utf-8?B?WFp4TlFSZkZWTzZ6NEdadndIL3h2YWhkRGpWbkw5NkZjWmVPMjdwOThlU21i?=
 =?utf-8?B?V3lpTS91NHgwc1pmU2FtTHpVUGU0MldQMjJWeWNwb3BHWEE1clduZGc4M3JJ?=
 =?utf-8?B?K1Zpc1RCYmxFOHZXTDZEdVNaUzVHdHNPMitnWkJkR1pZUm91c2ZmSnI0dEM1?=
 =?utf-8?B?R2YrMVEybExkS1V1NE40QXhNNnk4VDRrMVNSWHZUWi9lUC9wNTBRWkxhSEhz?=
 =?utf-8?B?dU5wa1luOTc3eHRjOEVpQ3M1UlJneHdNcGViWEZCM0puWWxYSmtKSDV6TElQ?=
 =?utf-8?B?SHNNTTJPOHlLWnBaOE5EbEx3czdSTnR5SnY2dW1ERy9UZUNWYjVMT3NWK3pB?=
 =?utf-8?B?LzBZbmZDZTgyZWxtQ1NHdzNlRS9BckVYZ1VQMkNNOC9ZNFIvVEw3VW5uODBx?=
 =?utf-8?B?c3pGM2txZXI1NTR2Rzd5bUJHUUl0Um9sejBuTmdoaDlHTVZMMkY0ck53Z2Iv?=
 =?utf-8?B?T0h5QWhpMStOemorTnFpb2tXLzlHZ3ZXVXh6NW1WdEVGTDJaY1dhdzRwQmVG?=
 =?utf-8?B?bVZtM0d3b1pSMTFzN3dQWHNUVURYcWk1cS9Qd2FKb1EyQ3hTTFFkcjdFL0lu?=
 =?utf-8?B?eURGd0lod2VWWnI3bU5xM3QwNUpEbGRPblJ2MEpoOXQvZWRVdVNvcytGTjJu?=
 =?utf-8?B?M3gyM2lMM3o0VUd0WXhybnk1aC9IQm4wbTBEcW5Jc0pEUHRTUy92NVRkSXBJ?=
 =?utf-8?B?SVlxNkh4NUJEQ1hZQUZRbmlDalZQbnlRR2tTUnBHcm9yS2pLS25sVkIxdGg5?=
 =?utf-8?B?aFh4YW1GcllIRUpGTGlHZXVPVUdUNFR0M250VXNCeDQyZDRaNHBpYnBrM3Iy?=
 =?utf-8?B?eHhzS1A5bXl3L1A3aTJsSTRLblBheExFbit2RWdva2dsNVcrQnA5clJxNGYz?=
 =?utf-8?B?VnJvYjQxaXVJTkRLd2RUT2FxTTFOQ2VBbUROQURLblZDdXdGVE9UcHZYK28v?=
 =?utf-8?B?K2RhQ2lMU1hmelVJRm83Q3pKZDM1UTF3SjFnbG5adlowdHFxZG4zVmsybkRW?=
 =?utf-8?B?UHJCWDNjOWpsVEJrOXRmbTVuQVZPS3liZW9YS05ZVDhKYmFzbG5mZmdNdGFD?=
 =?utf-8?B?c2ppL0s3c3hDOFQzWkNCUU5QbUF6ODZCT21JVlJ6NGpZK0cyYWduNkNOc1JO?=
 =?utf-8?B?ZnpQZ0Vtck84QnJEdmpla1poL3BoSDRnZXRpRUFhYU0zVEZtb3lqaUVYallk?=
 =?utf-8?B?OUQ1eHkzWkx0N0c3NDV4V2RVQUJOc3FUSjNnOXlwMGN2R0p2VURVWUlYNkUy?=
 =?utf-8?B?N0dnY0ZaVHc5U3NobDlKZllmS3RWOGUvUWV0bGFGcHZMTFY0MUVSUHZydEkw?=
 =?utf-8?B?Q2Q2dk1RZUhlMnBmcTVxRmdiMXRGcS85ekRHOXdJZWUwWFJlWmVGZnRnRFpB?=
 =?utf-8?B?bllKVGxmcVJjcEFsWmwycTdPb1k4emM2bVlVUkdvbXp1UFN2WkFXSnpLWWFM?=
 =?utf-8?B?TXNscEN1ZUhRbVVmd2oweHAwVVJzQVFURFdYS1VWRWIwT3pRc1c2TVQ5VEFw?=
 =?utf-8?B?N25tM0VGY0Q4cmdjNW9Nd1VZZ015TXVSZWlLd3QyL2pjRml6ZHlHdmZwcCtw?=
 =?utf-8?B?dTRZRXRrOVZXRVhvVnd3SWJaaldFb3MxTXk3cVFmcmo4UDBNd2FBd3ZFb2do?=
 =?utf-8?B?RHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0b30b6-f671-4864-f06d-08db168e3181
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 17:40:17.6698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnRFtsnDfki7y9K6HXQPgsVxCFHxR5SQfBkBkPamZn2IUKBphvJK6m+z0uLyu7XRrRC6EVmrK8gXAtkhXkM7Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7321
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Feb 2023 17:40:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10827

On 17.02.23 16:25, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .gitlab-ci.yml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 311702f..95adad5 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -38,6 +38,7 @@ default:
>      - if [ "${release}" = "buster" ]; then base_yaml="${base_yaml}:kas/opt/buster.yml"; fi
>      - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
>      - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
> +    - if [ "${release}" = "sid-ports" ]; then base_yaml="${base_yaml}:kas/opt/sid-ports.yml"; fi
>      - echo "Building ${base_yaml}"
>      - kas build ${base_yaml}
>      - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
> @@ -326,3 +327,17 @@ build:qemu-amd64-secure-boot-bookworm:
>      use_rt: disable
>      wic_targz: disable
>      deploy: disable
> +
> +# riscV
> +
> +build:qemu-risv64:
> +  extends:
> +    - .build_base
> +  variables:
> +    base_yaml: "kas-cip.yml:kas/board/${target}.yml"
> +    release: sid-ports
> +    target: qemu-riscv64
> +    use_rt: disable
> +    wic_targz: disable
> +    deploy: disable
> +

I'm taking this already. Rebased it and simplified the variables list.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


