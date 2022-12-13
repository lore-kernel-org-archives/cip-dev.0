Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84871C4332F
	for <webhook@archiver.kernel.org>; Tue, 13 Dec 2022 12:10:27 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.68])
 by mx.groups.io with SMTP id smtpd.web11.71945.1670933420753246600
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Dec 2022 04:10:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GZEb5lnP;
 spf=pass (domain: siemens.com, ip: 40.107.21.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=II/CGBcggkPzQxzlP9LovXQVOXGHcltMfV2gOfGED465hUyyHYlTd8fX/3X9LfHhNnv4O9Sftua2QR1THUeX+1ZBcWW7LyVgJi9Mo0d1odbUvPHiAGNkSbpxP/ifBLejNKYBM5f/MHv+N3so+hPYGow0tgE+pfzAiRmQL4gKKPvnwpNZnHHVfB3gNYf3XNItIKitxU4nCjglctgGGn44pk05F+rcn3JNFD4j409G2cxoJhdSlSCa0pCgdk3JTtzV2rMTsF74IcOuESwDo8pTVQUSK5gRjTur9r8pGxYWyZEf0kEZ02+WMF3BJQYHAuqjz9XYQoRljazxUbYbvxIO5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZ88TyFF2oqY/3hvt9kS811++ntxie9wBKSU+OY4v0M=;
 b=Nf6E3Vjmu/qBnhmhUe/tiYMS/hg5cFgMwV2ki0xC70pTDzs8AL/m+wwVM3odn54p3DRon9l6wYs8WvcCQoWFoECaTgs02n60o+u7yza9sVMjjIoju5kgGDiKY+Tb98jxNxE8ckvyuhGjGzn2QOuFxS0bhv/vGWYDp93edJ7aivtAzsTErl9e5ui86jeF0uLsJ2Ru5mUELhlduet36ZlazEvjeBnvwxlutjY2BciBT3T9xyh39EaiMdkfCaBqLyHMOfoiv08HAkXMbio3qxm0Wzvs3mjPCWiJXrPL5s5BGdrMQCLDjP4reh8DvVD2xl/uKnlxw56WEwqTP5vRSrIotg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZ88TyFF2oqY/3hvt9kS811++ntxie9wBKSU+OY4v0M=;
 b=GZEb5lnPv9MLGxKZPYkfbEzqmQb/LLLF5rCvSm+NAf9li8HN4cw1mO6vRcdCcHWx3Us3O6MjMGI6/OhlqbLHf++k0+00A51Vl+zlhd+kIuqI7CZ157opSSCkVsROq8eTGGGS3GsfVaCclcHL3Jo8uQzwT+bpHtmhFNjvaS6eoMooNkr/zgDb2lwyggQs0wT1PttWUa1+1VEZa4hDExmQmNOlJowLHEQ2uQC7QAgZkyGwQdx6o8w+3ELKW5+dd3+X5VTbgxz9vGhVV88qNLjlNVMpuCvmytASM11hl9O3005mMOv0iV+0UXMc4W19ba+WgBwVmzOYzwu/+nTHe0yhjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3839.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 12:10:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%8]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 12:10:16 +0000
Message-ID: <3ce10694-dd73-d97d-e738-65e9e2212771@siemens.com>
Date: Tue, 13 Dec 2022 13:10:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [isar-cip-core][PATCH] linux-cip: Update cip-kernels to latest
 one
Content-Language: en-US
To: Srinuvasan A <Srinuvasan_A@mentor.com>, cip-dev@lists.cip-project.org
References: <20221213090617.401794-1-Srinuvasan_A@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221213090617.401794-1-Srinuvasan_A@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:610:53::24) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3839:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d546c97-fd16-44eb-9e56-08dadd02fdd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+N3XyksskCTsB/VzfY+Hhv3FHyZndkABM13chkuDWGLYCBrPGhaxMKjkGNJWZcSLQW2Cmke1AVvwVxCv6pFNauF7rjVKZYF4xdYAGJ2qI552vW4qLsYXaDjshrcNDubhWcYfW7H6lcVVJEm3AJ/bbeTUAf4Q1skFqarmG2Ro6cJZwV/2CmYo6eJ2W/hzAb3I/nhySXTiAt8729jJ6nECuVJPW6SP3F2L1v/2mm2HMpkLSb/IkrU6ac8JUIrw7VqO9ifi2iKyp1wXad7mN0KJwc3Cy9Vqmi+1IUDa9ARtQpaYj7JxwdMKGdHzto8+C2FNy5LFXhI3O6LlbA5k3mKP+Ey4GQAgSJx7docZbeioaxb3T0JaRapt66aUdrUFgB9b/Q/bB2yEJwYjiSXEn+TpDlmQR/p7IOyg/923UrDLvVaIQ3aEBYTVfaDJE/7PpvG8Xh6x2Z8Pwzj6Q92dU7vTYEH/3kCCip+INJV2UQFU48w9SAiME1Dpnw7LqLfT+dkNHayZBAyv2dIIS4I0z5zP3i856jWPFhapABt/4xjd9wWwZWZTc6dw7JLKQHOvK+dx6C3W2mLTx+UNJ0GTbUSNaKKNI07WR7Tyalwhi45VsO5mMvrvaXYzO878a9efWXnlm39xOdU8ZGny85F3vv2DsPOFz9WxB7LCInwcjM2cM2CWGGO2Rf8ERQp4v7dDbjlDti/NKiRYCA2LhdIY+ciX9LQkYAm9zjsmhpd9bXkFKQQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199015)(31696002)(41300700001)(8936002)(316002)(66556008)(5660300002)(86362001)(26005)(36756003)(6512007)(6506007)(8676002)(2616005)(66946007)(53546011)(66476007)(38100700002)(31686004)(82960400001)(186003)(44832011)(478600001)(15650500001)(83380400001)(6666004)(6486002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aVVaaExiQlNZSDE0Nnh6UGVHUzcvdURJQTVnVUR1cUlWdnRTS2dMYTBpak5D?=
 =?utf-8?B?MklJZzdjOWJSSnFaZ1I4bWpCRW1TUGxpT2k3cGFIeFg2UGp0bnFYMkN2WC91?=
 =?utf-8?B?WkFMaGI4cE5tekRCTm9XLzZld1E3YmMxY2UwZ1JXV1RQb1hyejBac084M0tW?=
 =?utf-8?B?VWFxTm5zYXM0cUhqeGFOTFN4Rk5Ea210WlZPcE9zWjlMUXJLZnhUQmV3SGhT?=
 =?utf-8?B?VEFwRzVER3FLZ2t2Q25qOVM5c0NnM0NSUVFXSXc0dHBCMzZ5aFZJQlA0dklH?=
 =?utf-8?B?WFVSSkNEc05mZ1V2aWh3YzRINXEvemdQclBNQzNXYWQ3aThvRStSSFlKNEFZ?=
 =?utf-8?B?RndrZjFXNVdVb1EybDcvREJ4bDh4Tm5oVUxXcDZCeU1nWXhoUXp6NmpZY0tw?=
 =?utf-8?B?SmVxQWwvSVpxaTY3UHdHVTFxMlhlR1RaU1J5ZHJSQUhLSGNyZjNvNTh4aGMv?=
 =?utf-8?B?angyeERlWE1lWVUrd0ZtUlhQZ1JPd010NHR5VjBzTlV3QnRuR2tHNU41WFpX?=
 =?utf-8?B?NE9YYXlOcUx6OVJpZUVrWjNmeXFjL2dqd0FiSWJUZi9hY3FlK284UjBUWnNN?=
 =?utf-8?B?WEdtbmJQZFQ3WGlWTVRmclU4WG9zSXl5TzlCbnFwUzNzaFZjWDdaakFQampI?=
 =?utf-8?B?U3g1dmJ5aUtPUVplS25sTk0wc2oyZVlDMEEwSUw2MGRwNzBYRVpXcW5RbnlN?=
 =?utf-8?B?Y3k4cU04TnpvN1pjTGQrYnNlaXkzRUNDQW5sUG9CalArQWsvUzE0Ykxkd0Z4?=
 =?utf-8?B?UzRvMlU2NUZTY3czK0VwQ3BPSHlCcGZYdU4xSGV5dHhhaUx6VHB1MnRUdlg4?=
 =?utf-8?B?LzUxbHFYWmZRNm5TbzRRbW5wcm9ndmhUd2tDbFhLNUd3ZDc2ODBId1gyamE3?=
 =?utf-8?B?THZiVHZpM3R6Q0Vsc21sVnpTZjVKU0QxYzB2U1RmdjRvYjVoVGFHTllhTEVG?=
 =?utf-8?B?L1MxSTRleldDN2VBKy9kdlI1ZWk1ZWJBTUhHVmxLVUs4YmE5dXM4NXdtcThX?=
 =?utf-8?B?UHdabWFHTzhaNjNoU1QrdFZ2ZzZkV2xmVVZsRFJXcVhMTE0rR3RadWxPRnZN?=
 =?utf-8?B?MThqVW1MbmdXM2dZYitvVEoyMGhmcml6dTBHK3dUU3FPM3VtY0c3cWk2aFNZ?=
 =?utf-8?B?WHB4bzZBU1Q5RmhQNnRuTStiODBDUExCbFhYc25VU0FnVHluSmlBZGpEV0gz?=
 =?utf-8?B?WUphRzN0ZlBTdkg2SDNrNWphTFBjNk5qN2xRbjVXeDBBNVlrUElZUVBwOTRZ?=
 =?utf-8?B?Z1U1SlpuQnh2VUl4aVdSZDFDc1cxV2RERSsyb1BFRmpIYm1LY2liY2lpeDdR?=
 =?utf-8?B?VnJLcks4aUdLNGE2MitDMlFFSHM2RUd6Y0hSeUw0UUJHZHF1QTZJWHR2b0JG?=
 =?utf-8?B?Z3hUWktuSDhwMHdXdFNVS3AvSHVnMkRCaStyWFVXZVZiQncyRWpSUTl4WXlY?=
 =?utf-8?B?K3JDSXBYNGZ1dWRqaHF4QS8weCtxMlVPOEh1V3IwZldka21DUkRUbklmSVkv?=
 =?utf-8?B?dk1NbVZaYWJGT1JRSzJ4NDR5d1BVT2VyVkxGb0czVjBIVS8ySW80Rmt3TmVB?=
 =?utf-8?B?cXNPemc2d1RaUGQyaGY5MU0yL1dOaFhrcnNVN1VPQ0pKaElySnpkazZNMjJs?=
 =?utf-8?B?bng5Zjg2L2ZETlRFOUdBc3RHWVNNdGRwdDM0ZmIzb2dmWlJJVU82RWJqdDNi?=
 =?utf-8?B?VVg0QU5LRTNIbVRUa28vRVNQOGYyVGpTQTN4YkFPTXpoemtsd29jdGl5eDQ3?=
 =?utf-8?B?d0FQQnRCbmt0cUpkckNaRXVISXdGN1lXYlZab3BoV1EvT3hhZ2Vqek00YTc1?=
 =?utf-8?B?dTc4MHo0aC9UckJSSkNuNjdHaDgySXBkeVhvYlR6Wk85SWlDMWI1bXYxeGxQ?=
 =?utf-8?B?NjEvdmw2azdtTE9zQlRTakpDYlB4Y082b1ZGNGNiYm5ZTllPVXdmT2s5Y25V?=
 =?utf-8?B?eDh5aStZdVNaMXBGN1VvQUUxZVlIRC9ZSUFwZmtrQ1pMVVdBRlVJQkRHZk9K?=
 =?utf-8?B?Q3BLWGNvSEFCejA2M2I4SS9YN3lXUFBIQXY4UlNGVTk1dldJZnYxUDI1M1pE?=
 =?utf-8?B?cXQwb3laNUw0bm1NcSsxdWtKNDAvcGhPQU1xOXRHb0FKS013YjhGMVY3clow?=
 =?utf-8?B?TkFxRndQMmMrdzM3L2IzeGJWeWwzbXlQZWdlUHpOUnNMd3kvTTRnZEJpazJn?=
 =?utf-8?B?eEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d546c97-fd16-44eb-9e56-08dadd02fdd0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 12:10:16.5117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7foCH/SuIP9TmwDnHiipCBo7OPqpYPJb9pEe37Wl4K3qaVUe2FXrw+yj5fOHXR27vzXR7zpow6D9v/9PkhvyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3839
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Dec 2022 12:10:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10212

On 13.12.22 10:06, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
> 
> Update cip-kernels to latest one.
> 
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>  ....252-cip78-rt26.bb => linux-cip-rt_4.19.265-cip85-rt27.bb} | 4 ++--
>  ...4.302-cip70-rt40.bb => linux-cip-rt_4.4.302-cip71-rt41.bb} | 2 +-
>  ...10.153-cip19-rt8.bb => linux-cip-rt_5.10.158-cip22-rt9.bb} | 2 +-
>  ...inux-cip_4.19.264-cip84.bb => linux-cip_4.19.268-cip87.bb} | 2 +-
>  ...{linux-cip_4.4.302-cip70.bb => linux-cip_4.4.302-cip71.bb} | 4 ++--
>  ...inux-cip_5.10.153-cip19.bb => linux-cip_5.10.158-cip22.bb} | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)
>  rename recipes-kernel/linux/{linux-cip-rt_4.19.252-cip78-rt26.bb => linux-cip-rt_4.19.265-cip85-rt27.bb} (60%)
>  rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip70-rt40.bb => linux-cip-rt_4.4.302-cip71-rt41.bb} (72%)
>  rename recipes-kernel/linux/{linux-cip-rt_5.10.153-cip19-rt8.bb => linux-cip-rt_5.10.158-cip22-rt9.bb} (72%)
>  rename recipes-kernel/linux/{linux-cip_4.19.264-cip84.bb => linux-cip_4.19.268-cip87.bb} (72%)
>  rename recipes-kernel/linux/{linux-cip_4.4.302-cip70.bb => linux-cip_4.4.302-cip71.bb} (59%)
>  rename recipes-kernel/linux/{linux-cip_5.10.153-cip19.bb => linux-cip_5.10.158-cip22.bb} (72%)
> 
> diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.252-cip78-rt26.bb b/recipes-kernel/linux/linux-cip-rt_4.19.265-cip85-rt27.bb
> similarity index 60%
> rename from recipes-kernel/linux/linux-cip-rt_4.19.252-cip78-rt26.bb
> rename to recipes-kernel/linux/linux-cip-rt_4.19.265-cip85-rt27.bb
> index f27be73..3747cf2 100644
> --- a/recipes-kernel/linux/linux-cip-rt_4.19.252-cip78-rt26.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_4.19.265-cip85-rt27.bb
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2019 - 2021
> +# Copyright (c) Siemens AG, 2019 - 2022
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
>  
> -SRC_URI[sha256sum] = "770db530cb68f0eb022757fde73774b7312d420fcfc3d86d906f37208bdbce2d"
> +SRC_URI[sha256sum] = "5d93f08f6a4371e90eced62207a14e58c3751b3acbfdf76f20bbf237f12dd547"
> diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip70-rt40.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip71-rt41.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip70-rt40.bb
> rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip71-rt41.bb
> index 9310dda..5635eea 100644
> --- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip70-rt40.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip71-rt41.bb
> @@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
>  
> -SRC_URI[sha256sum] = "186949d20d7ca0856d666665d66782805c39d6811a6baab1b88af1690c6c73e1"
> +SRC_URI[sha256sum] = "324f821e4df5f2b364e318e37266274432f3057334f5bc841d7bf49a9dcc78c1"
> diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.153-cip19-rt8.bb b/recipes-kernel/linux/linux-cip-rt_5.10.158-cip22-rt9.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip-rt_5.10.153-cip19-rt8.bb
> rename to recipes-kernel/linux/linux-cip-rt_5.10.158-cip22-rt9.bb
> index bee0661..571e840 100644
> --- a/recipes-kernel/linux/linux-cip-rt_5.10.153-cip19-rt8.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_5.10.158-cip22-rt9.bb
> @@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
>  
> -SRC_URI[sha256sum] = "075a95f357008133f999a037e0827f0d55fd1264b421b45548d9ab1be30df726"
> +SRC_URI[sha256sum] = "98a83e5727b64081e6a90b9713b182ac5ef0a3957a76c695a9d71822d6a70d86"
> diff --git a/recipes-kernel/linux/linux-cip_4.19.264-cip84.bb b/recipes-kernel/linux/linux-cip_4.19.268-cip87.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip_4.19.264-cip84.bb
> rename to recipes-kernel/linux/linux-cip_4.19.268-cip87.bb
> index 860fa84..94f9f98 100644
> --- a/recipes-kernel/linux/linux-cip_4.19.264-cip84.bb
> +++ b/recipes-kernel/linux/linux-cip_4.19.268-cip87.bb
> @@ -13,4 +13,4 @@ require linux-cip-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
>  
> -SRC_URI[sha256sum] = "2176f15e9126499e9336fdd8ac1b560d41ca2d42f96b2492fbce7e8ccf7ba31f"
> +SRC_URI[sha256sum] = "49c0acce195c42b9d987be48ada6e64bb7226e6acd0fe9e257d1b0470dc8279f"
> diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip70.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip71.bb
> similarity index 59%
> rename from recipes-kernel/linux/linux-cip_4.4.302-cip70.bb
> rename to recipes-kernel/linux/linux-cip_4.4.302-cip71.bb
> index 2fd314c..8d6ab64 100644
> --- a/recipes-kernel/linux/linux-cip_4.4.302-cip70.bb
> +++ b/recipes-kernel/linux/linux-cip_4.4.302-cip71.bb
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2019 - 2021
> +# Copyright (c) Siemens AG, 2019 - 2022
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -13,4 +13,4 @@ require linux-cip-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
>  
> -SRC_URI[sha256sum] = "0c59f3b3859c309a9a74d9709d70a35ea449868ebfa2fc56a0cc9d533f351000"
> +SRC_URI[sha256sum] = "864d7e10e123bd0888018279d5f61257eae2c11465fb1ef2d0b10dc42b81d513"
> diff --git a/recipes-kernel/linux/linux-cip_5.10.153-cip19.bb b/recipes-kernel/linux/linux-cip_5.10.158-cip22.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip_5.10.153-cip19.bb
> rename to recipes-kernel/linux/linux-cip_5.10.158-cip22.bb
> index 317dfb6..54dd870 100644
> --- a/recipes-kernel/linux/linux-cip_5.10.153-cip19.bb
> +++ b/recipes-kernel/linux/linux-cip_5.10.158-cip22.bb
> @@ -13,4 +13,4 @@ require linux-cip-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
>  
> -SRC_URI[sha256sum] = "95bd235f131a1ab37a58dff85d4498bcc93bb189b04723923febd52d8566687b"
> +SRC_URI[sha256sum] = "00745cadd0c555f69acd48174ddd484bdf6f9db2cac39429c7b7352134187abd"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


