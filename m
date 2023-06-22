Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD16EB64D8
	for <webhook@archiver.kernel.org>; Thu, 22 Jun 2023 11:27:06 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.82])
 by mx.groups.io with SMTP id smtpd.web11.8856.1687433221472175212
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Jun 2023 04:27:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uPx0dtRA;
 spf=pass (domain: siemens.com, ip: 40.107.21.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZycwG6vrwWuJYUCMUo4XyBNzfYUgRzttKFbk4pm932ldRxqxFDCtdqDJmd9tztXtm/IhETX0KFvygFx07VM/QUz9aU9t5e+U02YDYLF9shtGSlrnU6KxMAqOR2tpd43w6aUJUA7Lj6WzEOobO1G2rhwxV5w8YG8fiLr2Lk4YxsQYjHeBUXxZObx4JHji11twV5OnkwbBMU8w7wd5x62trR4wPhUCe9WhbN5Z12H5xj2eIqoKFrxPzTut3qKeQ6WIP2t8YN0U/wfWxw0tWw8YPLvrXXrtRLN5Z/ybhfuKj45bSD9SW4TWq0M1lz38fNtyYWMmokmN/5bla9z8SYxT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVysEh2IVYh2UzoZt8/QuxHRKQSEyLhMhHnroYsGTS4=;
 b=maylmv8xwkK2JNUW4wkzJg6hEkajC7Pk3Ush64IRbmNEPo56NOtkKw5KFcH5/7GEJO/J9My2GhvLoCz66uX9Mmi9pZLuzh0hHSKNCipsYBODAKHCZ5Y00KVwiXg+pQu0SDuFsNOxt4ItEv/Vu0x9uvaXg33MMriXo2nIGahaOXBgi9jQMRep8qgQRpqLIgjLq18cBo0/e+V6jfHPAywgTMGqxbRI9jx39zncKOSvuDNdySwE2UqfjND99bYz0NH9SM8uOY93d7QYf7JS/KTLG40gr83I3crOW3U8ty+XbjmJIlc5DsfZxe84KTNqyVToKe+NisBaSCVDhdxV0kOqNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVysEh2IVYh2UzoZt8/QuxHRKQSEyLhMhHnroYsGTS4=;
 b=uPx0dtRApXyfOVq4P7/Rbm1cnvejIy05O8ed3Hrz4ZU4sJcHvEf2VGyHSqIKWCByE78NrxvaNaBk+oXsXra4oWcM/l2o13yavhU8zZm7pBNL1422payIWV5MW5pge1jTLTdRpd6Co1GCmY9KHZZN+Oki8MnP2AVYgsGfzGAQMj8455nhQf7rddKtCvGnRSSQV/aydJuIaFMAnfciSCe6nSj6Iu4jdU5SGlDs3+2TvLeBBYhtWqgTP/cQwj/o1qtlCC41WcdAnofzNVKZGoG+fJqYaNpWlGUFIArltVxk0qj9fCTI8rziUhEfJpFDkHwGytxe+1YY3JIyRyU6gPpPpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5446.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:295::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Thu, 22 Jun
 2023 11:26:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 11:26:57 +0000
Message-ID: <597b4e28-ecfd-0985-9bbb-783761094631@siemens.com>
Date: Thu, 22 Jun 2023 13:26:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core][PATCH] recipes-kernel/linux: update cip-kernels
 to latest one
Content-Language: en-US
To: Srinuvasan Arjunan <srinuvasan_a@mentor.com>,
 cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
References: <20230622111728.1436562-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230622111728.1436562-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5446:EE_
X-MS-Office365-Filtering-Correlation-Id: 440f53b8-8c62-4e9e-d60d-08db731396e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pA4kQbV/rZz0PrzP0HVeISUgqYT/ezVmVc9iqLB3ycV0RDSSMOvw7F0KfOcc4/XQiPZBGfrb+glITLjlbYK5jfLipB5ffq0lV/SK/Vm9oPImHIB4cX5Mf2dvVrD4XFfbIOtcs7qgcZ0mK96DhXENuq5nOPGiXBBCnwHJUIC1qSma2FhXH5hLFcHHSDvNglwypL4U7qpMT2rbsTHzbUSr+xT+k/0YSwU31gd8DYo3hpgcIpBb1IYAab6N1T2Zw/LT3XWNUjnfp3NhptPnB7nMj1x137YmwDkmlVrgoXxuDy9Xr+KrdYURPRHE4Qr+0Z6O2ab9q8ENqGNx9NGReuqf8wL1g77B6ID3IJgeJ1BXXlBlG2AoNlbyhea0eay383MQ7Yufn9uXb/Zg5mXsh48ZOyL6Pm9J/Anp8Smrdlf3pOh+fjSypI8ZYN96cmokZqDkeKtQMtayNVyWVhuV6a/Ypt0o0HA2KHPyFIpvkrUtEAfO1hJDO29PBeKipRm1mMrGTcBPxurITqZ67CL+EnMontmC2CQTFg3Qo5WF2unw7gmhq6oOoYgzKC4V4/juCGXpBfX59+PJQt57tkQcaMUwSgFSOB181+VTIzmNisJ+15+lz0OHF5d4bUHYfFbu9L2ggCY9aqpE/XGI/f7/Y0Y/6w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(107886003)(2906002)(6512007)(6506007)(26005)(15650500001)(186003)(53546011)(6486002)(4326008)(66946007)(41300700001)(66556008)(2616005)(316002)(478600001)(44832011)(5660300002)(38100700002)(8676002)(66476007)(8936002)(36756003)(82960400001)(31696002)(86362001)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OUx1dkkzeElIVHVnOXpTOVhDUmZaRDhqU2dpL2VPMjI4bHZ5UWFvSmRBNFY2?=
 =?utf-8?B?V3oyeHU0Rm85UHRzY0N6ODVkdk94MlVkTXllRjVGODAzYXN4dGFQRUpMYjVH?=
 =?utf-8?B?QUk3M2s0Vy9GTU5xOVI4ZHNXUGV6MCs2UFpHSS9BcUZEYnFvU21DN1JLeUJK?=
 =?utf-8?B?SkZTVjFQNFFxSVBib0g4amhRNUdLZTYyUGFYNjhzSFBUWDBzZ2EyejNGNVFD?=
 =?utf-8?B?Z1NxbG5ndnE0bDcxUHNwVEtUU0piSEVraEtkVVVmQ3JPZ3QydnliazlkQjRV?=
 =?utf-8?B?TVl6ODZqcitTVjRiMEVOU296N1dzUEFWMWlhMHpoWk5lcWVNaGdkNTFHWFF1?=
 =?utf-8?B?cXpjZkJqbE5zV3hvYzNWL0xsc3A3VzZnNXNxMHVJcU5oQnErNmY4MXhici90?=
 =?utf-8?B?UnlkZ2dCL1ZVa1FDcXIvVlV1Nzg0OVdNbkRnT2pNUnNkTUZobzZ3bkN6emtw?=
 =?utf-8?B?T29WNC9OMjFXQzZZSnFseFlPOVdmV3FPVEozaEF5cjVXc2V6RHh6bG9DdUZh?=
 =?utf-8?B?V0lFQlFMaGtNVURHL3FPSFZqL2xEWHlVckw4YUN3YlBSN1dOUTZrMVRERDlm?=
 =?utf-8?B?aTJBSzVHamxGYjI3a3ZGMUFkZGVRSVVXUE1DTTlNQ1ZrQXNnOW5pb08vdms3?=
 =?utf-8?B?RWE0blZEQTdJeWxuZzB5QW5aWE04OFBCa2Yrd3duVlV4eTVXSWVCYllHdW1H?=
 =?utf-8?B?RGZBdkdBNVluRmU1cGNSeDUrUTdNTWVscnRnMjQ3RDlGSTUzMU9SNmg3dE9r?=
 =?utf-8?B?Uzl3M1V0UzZ2YzNidkNmNFRJcnB0Q1FnL0lTeXhkRDYwUjdpc3ZUaFJnWjl0?=
 =?utf-8?B?Vk5xc1lKV01Ed1hEdUtTQkxINmZINXVhb3JUMk5wclFrWnFQYjFkaE00dkNw?=
 =?utf-8?B?eVZNQzczSFdvekhGMlVVT1crUXJIaHdTOENPWEJpMUplNHF2bGMra1d3bjBn?=
 =?utf-8?B?b3Y3REhWUFpxU1drWDM0OVF5S3lETDFJelpld3VHckhLOWprSS94dWJ3MHRZ?=
 =?utf-8?B?dUIvVkRyL0tDZHI3K1U2eUpEbHZRR3lFelRleTVYa3EvTmlHcmptRHFFWnZ5?=
 =?utf-8?B?SjZpb1JaWXZ0R2JidnJjbGVIaTNtTnQ1LzhnTnpJRklDQ0ZIMXQ1L0NURnI2?=
 =?utf-8?B?Yy9hNWxmRHdtNmlxWDB6MnM1bVJSUjlIQzY0ZEQwZDRnZVlQZ0RZV3RwZXVW?=
 =?utf-8?B?NUIyc0R0V0x2bXdQOGpTZTNKc0MyT0dLMGV2Q3JaKzRWdTFJWmNFbm9LakQ5?=
 =?utf-8?B?dHgxRlVBMVdjaGRmLzBPRmVRZVp4eVJ3WnEyNXZTWmwvd21DN2Y5Mi9HL0xS?=
 =?utf-8?B?cWRpRzhlVkN5aVJzYWJEWDV3dWRYVXlnTVArbkZtNjR1aWE4K2dNRytEcXRX?=
 =?utf-8?B?V2x2Y2ttMDFNOXA0c2ROMUNtem8yUkdNWHJWSWFNL0JOWFVJdGRQc20zNjBE?=
 =?utf-8?B?bXl5Umh5a0l4aXpVRWxGSHExMFlHWUpTMHZQSXVLUGpoRUpEZS91SyszYkZn?=
 =?utf-8?B?OWplMUxpZXlpK25ZRUFUdnJ0cENwNDFEbkxXV0R1bGFyZ29PZDBMcWNaRFNF?=
 =?utf-8?B?VThZckI3UlZXODVwZVlyTFpZUTdaRVZsd3laTGJlOUlqK1lDbjdZRjhuV1Ft?=
 =?utf-8?B?NldLd21KZkQ0T2F2QnJmS3pPUkRJbnNTT3JJdmgrcnJHSGxNL09LUmgwbGpC?=
 =?utf-8?B?ckc5ZEF1TDlVQng4TWdDbllPSnBsUkQ2TTZUSnhuR2U0YStWYVorWGNpbzB5?=
 =?utf-8?B?dmkzWTMvc1JqZHZHSUhZMDRhTHRIRmdHL3ZPMmtrbjErL1BuTURYZmpISXAz?=
 =?utf-8?B?NmUvcHBaUi9mRml6djd5c21UdTJtUVAxZ2I4M3VXKzM1RmI3dUZYU3J2dHNS?=
 =?utf-8?B?dWRjUGxmbmgwQk5tZjF6VEplYy9DSHlUTEo3Y29rM2JUS3NTNERTSjVkV0RQ?=
 =?utf-8?B?SXZldnE3YUF5ajNMWmJVTHhTdmhRTXJ3R25BbEQrNXBrU3Z1QURZcU5FRlFD?=
 =?utf-8?B?bURWZ0N1L3NtNFFVUjk2aVpwbGFaQXNtaHJZcjZ4UXpvcUFjZWIvTy90NFpn?=
 =?utf-8?B?TlNwMEV0NTdsYUV1R3ZHRXFuSEU5dnJ0MHZnVmk2V0FLZ2MrU2VSamh5K2dv?=
 =?utf-8?B?YkZ5ekZyWkwzMkNUUC9OVjFUSVFaWm51OXV5eFQrYTBTY3ExQ1FsT2N2cm9D?=
 =?utf-8?B?eEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 440f53b8-8c62-4e9e-d60d-08db731396e2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 11:26:57.7210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztx7QLOqZMIPwyEx2Prcx8pDfiyI4G05ue+zx4eCRQjU/wtoaJ5W5XTRKtlDVqTDXKEmd32nfepDFSiuK8cOZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5446
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jun 2023 11:27:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12121

On 22.06.23 13:17, Srinuvasan Arjunan wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> Now downstream layer needs the base version of 5.10 should be same for RT and
> Non-RT kernels, hence update to the very latest one.
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  ...10.179-cip32-rt13.bb => linux-cip-rt_5.10.184-cip36-rt14.bb} | 2 +-
>  ...{linux-cip_5.10.182-cip35.bb => linux-cip_5.10.184-cip36.bb} | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>  rename recipes-kernel/linux/{linux-cip-rt_5.10.179-cip32-rt13.bb => linux-cip-rt_5.10.184-cip36-rt14.bb} (72%)
>  rename recipes-kernel/linux/{linux-cip_5.10.182-cip35.bb => linux-cip_5.10.184-cip36.bb} (72%)
> 
> diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.179-cip32-rt13.bb b/recipes-kernel/linux/linux-cip-rt_5.10.184-cip36-rt14.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip-rt_5.10.179-cip32-rt13.bb
> rename to recipes-kernel/linux/linux-cip-rt_5.10.184-cip36-rt14.bb
> index 83f387e..044f55b 100644
> --- a/recipes-kernel/linux/linux-cip-rt_5.10.179-cip32-rt13.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_5.10.184-cip36-rt14.bb
> @@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
>  
> -SRC_URI[sha256sum] = "2106be5c70ee7d0074fb6767265a3613ce593dc4a5a46dcc6bf98697f251ebfd"
> +SRC_URI[sha256sum] = "f45c47c9944c53920d483eb9b9be205e42c7d0af89f8c8c9bc0d3fb56a95e5c8"
> diff --git a/recipes-kernel/linux/linux-cip_5.10.182-cip35.bb b/recipes-kernel/linux/linux-cip_5.10.184-cip36.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip_5.10.182-cip35.bb
> rename to recipes-kernel/linux/linux-cip_5.10.184-cip36.bb
> index 86020b6..433a6ad 100644
> --- a/recipes-kernel/linux/linux-cip_5.10.182-cip35.bb
> +++ b/recipes-kernel/linux/linux-cip_5.10.184-cip36.bb
> @@ -13,4 +13,4 @@ require linux-cip-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
>  
> -SRC_URI[sha256sum] = "cc25a9303eb46f39ae882df646ba3c544494ae136e05812b1d1e7ebf9e8db28a"
> +SRC_URI[sha256sum] = "a6405d852023099891f8d0530bf332c6cdba7654d6497ce83452df6ec1293152"

Thanks, applied.

I've sneaked it in before the swupdate update so that downstream can
take the newer kernel without having to take the still rather fresh
(from our testing coverage) swupdate version.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


