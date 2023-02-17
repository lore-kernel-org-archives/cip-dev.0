Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9821CC64ED8
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 14:56:04 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.54])
 by mx.groups.io with SMTP id smtpd.web10.8225.1676645756918582165
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Feb 2023 06:55:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HaYRiNRC;
 spf=pass (domain: siemens.com, ip: 40.107.7.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nx+5LLOh4FSFeU0QtNkN+zvvn0KhDH9ii9B0gtnQq/yCitYdP7rY5ssko0zkcjvbg0edka+rRABoze41eHzn4DcTyptmxn2qGLfcs3g1iUc4GI21IZ+gin45OmqJSot9zH5vZf1ABXSScE/tIqRiwQzm2rWDdW44Pt3gO0UJQo2pZmnHgwStOQtlDN4ROLNzXUx0+wAZUPjae6hv57/RCznPOZTSH2Y4LnEFFCAyozoQjDT+VoQEyuI2Muq9N7lMBoOa9rqyNnszoetBB/zxbRwXTFO4yWR4zlp3Tf1s2yzVpitAHFkBeTPt+Z5gRnvq/W2++uJ+RNP5W+4pkFaqiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3UeNyFCgwqyrlkgmcuWYVkIj5x5Lnhn5tKyIP+o+iU=;
 b=khw6y9+cjiUEb9tQWNJRwbEWXaiSNdaIDz0Js4cNzduDtFTeu2+S/CEezg0OKRw3yYNIrQDvjixqJgVNbtbWBhjpCcCoX2Byh1SX+UHjtY4uRnW5drmRFXl9XHz4/lKHRDTRsdyjxzM0a5UM3BQaI04SIBpTJhrfM91aZc/BQ58WHG+vDkRYwMvKjYHYwiRQAqQJoFoc/yEEPD0CdI5+oHOMdZHc/EhASEgjo0irS2V9PykMazEEgI4ESWyTJTUVEykL+YHrgx1Iv0tjMUPIc6k34HuaGT1MUFQ9pdBf+5Jg2iwCe6XEdEPWahEsn6mlnNbRK8fpfzjNgPEgcXFwiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3UeNyFCgwqyrlkgmcuWYVkIj5x5Lnhn5tKyIP+o+iU=;
 b=HaYRiNRCcBeNcabF1W8VW7ySH/CyVkqq6l9dJePf6t8MdpIp3rJciSzgCjDaCzDlpFH6NjDIROe5pPfWamjb3YyGLGFTHt6mBvii9SbDjCBOPpxglP8BRcfDk9cv5cCgQSx2e8CMTLQw4lf1ptaYOIehJfurj6SzNJpUjgCj/EqMiVsMKazxtzOhLaMoi4Nr2U7u0p2K4EeibJs15vsqY+oCFM7h764EM1rjwTZius5OEvNsxjjr2NJjbVAFIva+ooCMTojaTXPfo2AxR83NG7sMUitHhY6/YUtbF262hCIO6DhlVnCvv0z6GxeDQVAh0+J0ryCcGcAeGcFBWqhIMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB7571.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Fri, 17 Feb
 2023 14:55:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.026; Fri, 17 Feb 2023
 14:55:54 +0000
Message-ID: <787c809c-35ba-d9cc-0fa2-0deee3e3288f@siemens.com>
Date: Fri, 17 Feb 2023 15:55:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [cip-dev][isar-cip-core][RFC v2 7/7] .gitlabci: Add ci build
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, christian.storm@siemens.com
References: <20230217130540.509910-1-Quirin.Gylstorff@siemens.com>
 <20230217130540.509910-8-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230217130540.509910-8-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0624.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: 1edfcd87-c60b-4583-384e-08db10f71173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gDZiBKEtmkUrGIH5qJGpNE/7w2M6HQfpbs5iICMAx5vLlA974TS8lDMeSTyZ77WITEyRaRbFeNHpc5k8FqmzC4/VCuCRHJ+5nQloZUwHhjpSrk0NdtD38duGSBvf3Q1i/9Ob997X4TZLL2gHsK9Kwl4rFlMMx+b7IaA13mOA0YDaxhL6GV+/8S92fnv3380jRn2Vg9CGxQ24hAdEq8k85A2CiVqop0nlpeisHK4Zh4IMsM/F/AW9tl13osIBZvcpUtUCGV97tNWJKHxwPnYh0WgfeV2EcrCjkQwPkXXk+SiEYncaDk5Apkc3MOvl0uu8c499RYb7QMHmXRhZd5CAS8wQCSJqRQiCJWwgEvEXQtUlTigQUop+LXdfRzWEv6AuYTmkO2BHCHRlazr0TjBZGhOUKwPWic44wKgHR8DjmtGLq0hXddfoeUbacsdLchLCDQ/tJB9cF5126J9WMLVEVUcQIbsJ/OawFKmSMJENcocNUPApayoee8j3PcBWyCTr5FPohqhbPXDu2ovdFlTjMphy6B7gtXwqX591LInS9jBGHM+SwQIx/EaT0UCbWrgSvU5DqofjQnPGH8WlX+PGGjAbnKoNrXZfXED4LUnPqMwZb/QckJ/6fRja8CjAbp2PqxzlCZAGkoNB62yFjbzaDe0RY4KDjzzYHhxoIFu6/siu+hGpU51Frol4IsjJc1d7Lfu5n7ifxybWhlAgbQ6hOQ4vDnxz1F/TMo/QGfdpHEc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199018)(8676002)(83380400001)(82960400001)(41300700001)(53546011)(36756003)(44832011)(26005)(186003)(8936002)(2906002)(6506007)(478600001)(6512007)(6666004)(6486002)(86362001)(31696002)(5660300002)(66476007)(66946007)(66556008)(6636002)(38100700002)(2616005)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TmZzOUJXLy81R05YWExVV3JQTG1Rc3ZqQnNmeS92QWwwS0psSVJJYXJkLzZy?=
 =?utf-8?B?MjRsMGsrMHhIVmhoWCtUelh3NUZSZ2ZtUzdWUmRYNWNLMU56UXdLb2RoM3NS?=
 =?utf-8?B?WFdNVHdjc3dOTHpkYzVHY1NWRlZhMzlBaDFSdE5DTkhndHFDREZqdFVlMDFU?=
 =?utf-8?B?My92M2dTaGFHSWQ3cHlybk9tVzBkWEFMZlVPa1hLQndMTjZwNGlqcFo0eFBY?=
 =?utf-8?B?ekNUazBzUGJNeUJLL3IyODQ2SC8wOWhOT0xWM09rbUVTU0E2U2gzSFJxVDdN?=
 =?utf-8?B?REVHL3E3WHdaU2pLajgwcGRKdERGK0htLytZdDZQZ0UxaytjVlJNT1dxcll1?=
 =?utf-8?B?WFlvVGs1Nm1YazFjQXlPc1JpVUxaY1B2T2dUT1g1SDFIRWo5NkpDeDd0WW00?=
 =?utf-8?B?Vnp4VkhxUGVWS2lEazB3L1laZ3MzVzNEcVUwRlE4LzRuRXZScHVGOWdRcy8y?=
 =?utf-8?B?bUNFbVozSXVLSWlWTCtLSDl5QjRON1lpOVdLSTBhTzgvMW1rMnlXUWRVMlJo?=
 =?utf-8?B?OHNCeFM4RGFzYWQzbXFvSmdEOEExK3o4bnltY3JJVnUrRlUybDRhOVBsM2tq?=
 =?utf-8?B?bmRMcUJkZ1FCWGEvSUZtNzZmc3NzU3A1aFprcGo1dGk0WmtVaWtqRjJXaC9N?=
 =?utf-8?B?UVZCRFpIRlBtYmU3QXFVK0hlK0x0bzQ5LzR3elAvS0NxNGlZWFBNYml4Ync4?=
 =?utf-8?B?S3kzbW1ZaDBnTkZhdElPbGk1bDlTUERZTk16TnNDN3ZTZVkxLzEwTUNzSG1U?=
 =?utf-8?B?WE9NQklqb2ZVWVFwcjRSQWM3YmdqczRSMmhNYkxqVXhjR3NyWXlPQ05JZEcx?=
 =?utf-8?B?UTREQ2FxRS9UNjNibWs3LzFSb0hyN0I4cVFOVlhWUVBLVFM2am9GNTJGY05x?=
 =?utf-8?B?ZDZoMGIzL04xY1AxWU81Ymt2QlI4Q3BYUFI5Vk9PMVhJeU90WXpTeU9PTTlk?=
 =?utf-8?B?cTEycU1jNVljSWtCSUI5ZUN1NllpOEFPNVZuQXhySmhURDFoam43K2ZvZThN?=
 =?utf-8?B?M01KUVF2Y1RwbFcwRXg3SWZXdVU2bUd2VFd2bmo4NnZreVgrdnJwSzIxS0ZB?=
 =?utf-8?B?LzFEOERSTFdWUGxzdW5jOEhVRXZMN3ZldUhNVkFHWm54YzZsUUtuQVNmRUtD?=
 =?utf-8?B?Rk5HTXJidjZqQWVDN3VReFlGUUF5Vjljc0xHRUVBQmd6Q1BISko1TGpyKzk2?=
 =?utf-8?B?VTJjeVNBMEhWTGttMGVPcGcza1Y3dCttaDkwQ1RsK3lBTGRzZ21MbXVueHlV?=
 =?utf-8?B?UmpXOTlyMTV0QVV2QjZXalFiQkhEZzlNendPa0lSQjFhRlg5Y01GV3ptVENY?=
 =?utf-8?B?S09qYXZKcFpWTVZhLzc0Q3BneWZ2MEZudWZkZ21Kb0ZtWVVpaVFnTWFEbGl3?=
 =?utf-8?B?RGdqbkJySTMrQ04wcE94ZlRRWmhiWmJXeDBaOGVod1g2VFR2OGFhSVZmeWdr?=
 =?utf-8?B?K1NrTlZZc0pKZExBSGpSVDJrWXZHdkdOaTJmSFR1cFBXemlQSERPOVFtV3Iw?=
 =?utf-8?B?cWdEVjNNU1lxc3JNVEJpVDlMUXZTM0JBajhwZW56MjlSbGRDTklHdE1yTjZp?=
 =?utf-8?B?cWhvZWxnalpFUzBSWG9KdGJwTnhyWDVSRFJXZ3lzNDZtbmdrSkFWYUlkekV0?=
 =?utf-8?B?REJQbU1sM2h4WkRnS1dneFJrOE1WcDVBcGRaN2N4UGtYaTQ4TDNOSHMwS2dY?=
 =?utf-8?B?UzZvdzhFWDdmUTljUjY1WU9vZjNKbXpXMnJKQmxta0VVQ0NXNG44WGoydFBY?=
 =?utf-8?B?aDBnTUtWZllDVVk4Q3hkY09DcHB6VGlCNDVIS1RSUHc1bkV4ZGhIY3QxZlM5?=
 =?utf-8?B?bFlTWFhOclZCQjJoL3R2Q1pqV1ZnSDNmeXFHakZJWjRNcjFqZWN3Zm5kUUdO?=
 =?utf-8?B?SVlkcDlISjJPL3Z6dFRBdCtFanFtZ3EwMzc1K2dRZ1FyaWhJQkF5SjcwSVBr?=
 =?utf-8?B?WmpqZktPL2RmSm5JTjJXQ3A2WkJnY2tGUUIxRXhEd3dqamV4bk9odTBmZXha?=
 =?utf-8?B?RXJUU213dU43RTFFREh6eERleC9vbkdLeTNvTU14QWNKZU9kZ2gxU1VoVTVL?=
 =?utf-8?B?SnEwUmZSU084SGJ4VzBNazVZMjU0WjJwTnFLcmE0Q3lrNmpZbU9sem9naXl5?=
 =?utf-8?B?YVFxcis4alRrQllxMkpUamFTc0M3Qy9LaDVuNFFleGZEUjdab240WDdxbVdM?=
 =?utf-8?B?U3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1edfcd87-c60b-4583-384e-08db10f71173
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:55:53.9584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+iL/iXoW1vAOeG60Xgrp5kWfRv/03+zfDo2V9xx0s9/OXhaE9OEQummSAqu4UPlMSxA7+MFEoF/VGeycKDu3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB7571
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Feb 2023 14:56:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10724

On 17.02.23 14:05, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .gitlab-ci.yml | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index f7c8c88..c6dcab6 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -5,6 +5,7 @@ variables:
>    release: bullseye
>    extension: none
>    use_rt: enable
> +  tpm: disable
>    wic_targz: enable
>    targz: disable
>    dtb: none
> @@ -37,6 +38,7 @@ default:
>      - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi
>      - if [ "${release}" = "buster" ]; then base_yaml="${base_yaml}:kas/opt/buster.yml"; fi
>      - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
> +    - if [ "${tpm}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/tpm.yml"; fi
>      - echo "Building ${base_yaml}"
>      - kas build ${base_yaml}
>      - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
> @@ -206,6 +208,17 @@ build:qemu-amd64-secure-boot:
>      wic_targz: disable
>      deploy: disable
>  
> +build:qemu-amd64-secure-boot-tpm:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: qemu-amd64
> +    extension: ebg-secure-boot-snakeoil
> +    use_rt: disable
> +    wic_targz: disable
> +    deploy: disable
> +    tpm: enable
> +

Do we then still need to build-test the non-tpm swupdate variant of
qemu-amd64?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


