Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A1EC77B7A
	for <webhook@archiver.kernel.org>; Wed, 17 May 2023 10:27:49 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.40])
 by mx.groups.io with SMTP id smtpd.web10.46009.1684319259752559799
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 May 2023 03:27:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CNVtBIzp;
 spf=pass (domain: siemens.com, ip: 40.107.249.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e30UCMNzR0Z3D8gDYMDMKYHWGRfpr3z526/5NpuVhuzHz3f3rBYe20Pwz++TlIp//K9WidyyYd+kBHvbue14Lky8JHhqRlAiD2rhWVAS2zI5BXtuzOITyuUrQHXRiR5gZwizVwWs5HCjAPqcGKlVMHBzB/7/cAgZ3kEtms90KIT1xtbYxSLWyhOZ57/WAg9yNrNiuIBpmolpdLhPECnOaFl2gHVi6ecmC8HltYxL0zToShvbZyhHc8i/u8zpkZaFque1l7bP2AyrNt5rQ9St44vbGf142X9hoXMu/HBX/ONH5L4K5bDpMEBQZcv9qknfavTmCcRRYcF3F4OW9r1HmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/wxnpcYr0brSfKGLUQ6ApQDwyBCLUFCoH/5H4STtOw=;
 b=KL8ZeRawZP0aZMKyNRIUWiCKpuT74FVQthE8AXlJgh9GIS2JUHYTxmPfLInw8BQRgPJYnOjjG8sBbYxDj1i1ha8IKTXomLT2KTXbJUD+KkqW4BxGkKrVC+VDnYc87HxtE3hdheGiJDtO7UaVwr8XA0mgrVGDJXFxfTkDP/Bor0s9hakjI+O+hLMq65kIUh8dU9LmwR7nakb0xOh/gG5GsC3Sd8m4ap3dWK++29pAWgFgsCUsqLodHwCMNTp5Hw8zu5sv+vyrE9gjC+qrluw5At/sooLOBIzv4d/LIsDodig3/fWMnr8eIP6aHJwxtGciTJmRA9Te3M2zBRfnPmpGaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/wxnpcYr0brSfKGLUQ6ApQDwyBCLUFCoH/5H4STtOw=;
 b=CNVtBIzpBpdi69LIsKQz2+FfeMPlIuSdN1cBg4qRkaAadWv1XsBPojOs/sAW/7Pz9XSzuPz1UmPMQP1Z0/3PrJwbJxB40Fg1wdP+C1g5gLFTa+8PZRsbh71bbCyNYV62Koi7xbbu6OkyJWfjZCCdOYAwZYGL5NEPHDJZQYLJx+NEmlGWsYYl7YeOKtgVxxEaxcoh+S6IYeLlS61m4VnswPql0M1EOqqhQ0x0vAXBbA5EFsxmsqJjG/a1ttjsY/9412h0vtq5E3S+22jTVNqFkHA2N4Xxj5kbrB4CS85ETxlBdTF4uXQe+N5KRuUqpZbv55fR7wn6Z9YCmOCLWW0/SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6557.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34; Wed, 17 May
 2023 10:27:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%6]) with mapi id 15.20.6387.032; Wed, 17 May 2023
 10:27:36 +0000
Message-ID: <c2e2ac19-99a0-9012-7806-e7f656ff5a95@siemens.com>
Date: Wed, 17 May 2023 12:27:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [isar-cip-core][PATCH] kas/opt/6.1-mainline: use KERNEL_DEFCONFIG
 from cip-kernel-config
Content-Language: en-US
To: Srinuvasan Arjunan <srinuvasan_a@mentor.com>,
 cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
References: <20230517102256.1511870-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230517102256.1511870-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d53b18-46fb-4ef5-c093-08db56c15552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8m0CYYWWccI0OF2LIb28OkVKpjGjMoVfONiq8MQXMANiW/ZSStr3IoigyP1UtT1vcH94a/wWy1KDN/wgodK9iWKvwalv3a26+Y6Wfn2lb0RFxgu8GRtzJMcNj44x1WSt3V5nVOeGFJIFr8VgfFh0R5DxKIo5cKLRwDzMYpZ9N9hNo8LtqMxoAmjwYSvX6PnJWhOYUOviK0du3djRoJh3kWhgUMP7Zw53gUw7dJNrENMalIRM6UUoQ4gbQoV8c3HJJNm+7cfjXUGjlvb5jxp4xWJ7V9kvpE3xv9g/VUNdrZRvJlESYGPAnvb4qS605d48T1CJudN90MBqXnp/h4MLKv7Il2Jl68OHe774SoD1xd/z5caB4UybfhAGr/VOYZNgtia6snD60iWzxAq9UYKA5MZlr4FF+wW6AFOeV5FbPhdkJ0B37nMNMckfMr8kjy3GawMxcQZc+WdUcLJZfDTDl7Nq7SJ6NMWlJ80NHU2dujymMzJc6KppKWXcVc+Ke1D3uIAtlEq6WFhDVyqUNINA/aeCdg2PbPw0idDdLc63h0W3fbfxQElO50J8+GU9JzV6eDGf02DaTpt8qzQ5VvpfDqh4FgPEx1yBkT8uYsHuAmnaQbsPvSACH7sfeF/ycth8VpN0oF7jJ6hx3wF7XVzzdA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(6506007)(53546011)(6512007)(107886003)(26005)(966005)(83380400001)(36756003)(2616005)(38100700002)(86362001)(31696002)(82960400001)(186003)(2906002)(478600001)(4326008)(66556008)(8936002)(66476007)(31686004)(8676002)(66946007)(316002)(5660300002)(44832011)(41300700001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NFlHbVVaWVZheGxrVXp0WHpsOEpJZ1hzZERwTEZldGY3azNOQSs1eW5LMTVX?=
 =?utf-8?B?ZGxLLzdxWXhyYktyZ003eVNsNll0emRJV2RJeHI2UTNqR3d2VDV5bGtlbmJT?=
 =?utf-8?B?UjJkMHZ2ckJ4ZWtEelBBMzZjRVhxaTFnRy9QMis1enMraGJMNGt0RFhQWktI?=
 =?utf-8?B?Qi9QSllUY3NTQzhkeDdCb3FocnNwYURuQnh0S1F4aTVzenV4bUduNzNuaWJu?=
 =?utf-8?B?NW9JWlJ0ZXhmalBoL3FkY05UWU5Ia2oyWnBOUzhUZm93SUlpaXkyS3kyb1FP?=
 =?utf-8?B?bXhKMGJqbEgybW5BZ3FsdjFlNDhETzdYTE45MnYwamk3UzAwOVpZNVVXL0RG?=
 =?utf-8?B?OE83MC9xRWhNYmVOc0hwV2ZSWFNEMGRoOHdwd3FCcmxzbkY0L1B0ZnA1dTda?=
 =?utf-8?B?Q2dpbFIvVU1hZkVqQnNuYm12YUdxRmttYVlYalJsTGZrOVhORVJnMHdZS3Zo?=
 =?utf-8?B?eEdKZVVqMk1jYytxai81UVV1TkE0OUtoTkkrZGE1MWdDOW5ORFRhMk13cE4z?=
 =?utf-8?B?cCsvblp1TUhidWlPUTZjcDZENzdGSk1tQ3VuclZGM0M4Q1ZTY1lLS0QvYnhF?=
 =?utf-8?B?R3BSeTRSRjJTc0Zxd0hQdFNueUU4ZjhWWU9UNmErQmhiT2hQeXZqTnhFVXNh?=
 =?utf-8?B?THhJUDlvSlpwZnJxK0JYdW83T21yRXRZdWlTM3lsNW5scDNxYmNHY3RnRUdx?=
 =?utf-8?B?TWxtRmVLRUkzcTVvK2RYaEU1aFN1SEhjYTdGbk12RE14ZGdOd0drQXlXcmZM?=
 =?utf-8?B?RGdFcDhwUWszb3FoeitSSUJ4eVAzSGFsNzZDTHQ0c1dnL3J1dGxCcURlc0dF?=
 =?utf-8?B?d2ZVVndpb25ZVFljSXk2UnVjdDhTU0ZVeHlMWkFXQndveWRoUlBNY0JZSjRQ?=
 =?utf-8?B?UkxMUGJZcXFiOTB4aElzZXc0VnVGRjNVNzNtKy94d0ZDQUZOTFFocXgyMVlZ?=
 =?utf-8?B?QnNZeDVQblZkUFNjVG5Od29NNmpZbWd6allGZUFEM3ZhMXRERDBQK21IWEZn?=
 =?utf-8?B?RTlHUGl3K2VFdkY4VmxhYzR3OStpaWJ1NXVFS2xaQjg4L1o5bCtMT21IenU5?=
 =?utf-8?B?dFlVQ3NaRTVGcGxlaEwxR3M2T2pzTVM4OHNacGk1Z1l3a0k5TU1LZmlCQUhK?=
 =?utf-8?B?ZDAxeENxMUppUFFveWlHSXh5Y2wxZVgzM3FnUHJJdjlXbmVCcCtmN0M5c2dX?=
 =?utf-8?B?MlNHYUJLY3Z2ZEQ5cVRqbGovUnZRTU5TV2U5a1ZlT0hJOVNtSG80RVVQSzlo?=
 =?utf-8?B?V1ZYd2VxaHkxN21YWVB4TDJSYTU1ci9SK3R1eHlOWkYvdi8xalI3VktiNldM?=
 =?utf-8?B?QkpSaC93WTg4OEIxd1pwODQraDhYVTJQZTZjWUhOWTBYZFNiMmNhcXJVWnpm?=
 =?utf-8?B?dmlMdU05TzgwU0FOTFk0eUczWnN3WWN1bUY1M1NaTG9iN3BUNUhMb2IyMGNG?=
 =?utf-8?B?ZGovaThNcTI5cTc5U0swTTFZTDA2TkptVmRKeHhySnE0VHdtU2wrMTJieHVP?=
 =?utf-8?B?aWdGNGFYTHRZZytEYmFhU1BWb2JWZ2FBQ2xmZnZPT2kyUXlBTjlPWSsxeWpI?=
 =?utf-8?B?Z3hZZmQyNGZSSkFzN3kzVUIrZXUvTWFXUnRFZURTMEc2elRlb05lTTZyYzdr?=
 =?utf-8?B?bTVmM090TnQrMUtJeCt4aUJZUFRJVC91SkdxdExPdWhUMHorRVBkRy9RelZT?=
 =?utf-8?B?bWpqblV3NSs2MERxZmxSOEtnV3luZnh3c1dwOGtMdHdCNzJJNmdCTzA0eExn?=
 =?utf-8?B?K251QlN3T0VIT2tjaTZEWklvenUrTjM4dnpqTlVBTEZoQ21CQ3VlK1l4NEhr?=
 =?utf-8?B?SjMrZE9Qcm55Mk9xTy8wOGdLYnZHTWYwV0xyWEpKTjg4N05HL2tMWktxalZV?=
 =?utf-8?B?NHVHSUFhVXdrcEdZZE9OQkJ5OHZpZy9PNkk1RHRVRzVpcmU4VytCVVhJNUda?=
 =?utf-8?B?aEZBRVNtdEZmN2prWWVDNVZaOFBWbUFnZms3MG5TcVpNekdyQWdkVW1FREdC?=
 =?utf-8?B?alJ6Mi9saTliUXRRdURJTUhCWkpUQmJnbHh2UlNEWHl2RmFHenRxdHNVQzM2?=
 =?utf-8?B?a0ljeW1ETkpXVkJrcTN2OGxrY1lrdURRa0lhbjNiRmp5WE9ubXYxU05WSDc0?=
 =?utf-8?B?TE1OSjY4Y2JRUVQ3UWtWZU1rSXpnVWNncm1YZjMxR0tsYUNQWjZubnc1bFFI?=
 =?utf-8?B?c0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d53b18-46fb-4ef5-c093-08db56c15552
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 10:27:36.4940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXJCcyMbTPq23pO966V7/f7owe/2XMbq6M3wv+i4BgEK6GUZtxQFOf169997gLOyq+sYp8OMOb/viFMcROm82w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6557
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 May 2023 10:27:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11488

On 17.05.23 12:22, Srinuvasan Arjunan wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> Presently 6.1 mainline kernel uses it's internal configuration, now cip
> provides the defconfig for 6.1 LTS, hence use that one, this config
> already conatins the CONFIG_SQUASHFS, so remove this one from recipe.
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  kas/opt/6.1-mainline.yml                      | 1 -
>  recipes-kernel/linux/files/squashfs.cfg       | 1 -
>  recipes-kernel/linux/linux-mainline_6.1.15.bb | 3 +--
>  3 files changed, 1 insertion(+), 4 deletions(-)
>  delete mode 100644 recipes-kernel/linux/files/squashfs.cfg
> 
> diff --git a/kas/opt/6.1-mainline.yml b/kas/opt/6.1-mainline.yml
> index 84d12b0..0dcf336 100644
> --- a/kas/opt/6.1-mainline.yml
> +++ b/kas/opt/6.1-mainline.yml
> @@ -14,5 +14,4 @@ header:
>  
>  local_conf_header:
>    kernel-version: |
> -    KERNEL_DEFCONFIG = ""

That was actually missing from my patch to finally use the
cip-kernel-config - good point.

>      KERNEL_NAME = "mainline"
> diff --git a/recipes-kernel/linux/files/squashfs.cfg b/recipes-kernel/linux/files/squashfs.cfg
> deleted file mode 100644
> index 7a89d00..0000000
> --- a/recipes-kernel/linux/files/squashfs.cfg
> +++ /dev/null
> @@ -1 +0,0 @@
> -CONFIG_SQUASHFS=y
> diff --git a/recipes-kernel/linux/linux-mainline_6.1.15.bb b/recipes-kernel/linux/linux-mainline_6.1.15.bb
> index 690f6dd..9b45f28 100644
> --- a/recipes-kernel/linux/linux-mainline_6.1.15.bb
> +++ b/recipes-kernel/linux/linux-mainline_6.1.15.bb
> @@ -12,8 +12,7 @@ ARCHIVE_VERSION = "${@ d.getVar('PV')[:-2] if d.getVar('PV').endswith('.0') else
>  KERNEL_DEFCONFIG_VERSION ?= "6.1.y-cip"
>  
>  SRC_URI += " \
> -    https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-${ARCHIVE_VERSION}.tar.xz \
> -    file://squashfs.cfg"
> +    https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-${ARCHIVE_VERSION}.tar.xz"
>  
>  SRC_URI[sha256sum] = "2c16dfe2168a2e64ac0d55a12d625ebfb963818bb48b60c1868c7c460644c4fd"
>  
If you don't mind, I'll fold that into [1] and send it as v2.

Jan

[1]
https://lore.kernel.org/cip-dev/f1be8d8c-d58d-715f-b6c0-39d76826450e@siemens.com/T/#u

-- 
Siemens AG, Technology
Competence Center Embedded Linux


