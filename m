Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF6EC433EF
	for <webhook@archiver.kernel.org>; Tue,  8 Mar 2022 11:07:53 +0000 (UTC)
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (EUR03-AM5-obe.outbound.protection.outlook.com [40.107.3.40])
 by mx.groups.io with SMTP id smtpd.web10.7005.1646737671933612510
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Mar 2022 03:07:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LwK9YN7m;
 spf=pass (domain: siemens.com, ip: 40.107.3.40,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7xLlE5PlWkSWcMF0cX3XG89xZ6KwM3AcVJqGDhekIVew3OACjGQb4TRxDHuAxzbjLmkhGqoXLge3+WKbhXl1VLZz+s3Ndb8NKXy/nmamyWA5y2FLDtgDNY4V+qsgcoixBOKrPQvtfK9RE7v1WhsBrO4uFcEXat2lp1C4tQsRjFp3ZMJvRV02bmm/hJeK+wtqQERqVTZsA+h1SapOeES0z458yF1mri7FDTni/NzAVXlkT2OQCa8XlFauGTkglSsKl6RKiFMp2PmyJUHNaAia06Xc0xx8QSCz37kwIPJJFgLQhw8ipsSnh8BiF6IpwICrv7Oyi8ftK213LXUyHwz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mck2kJHDfowIiLvMIG/pixxdcR/duNnr7NGyBqqoPw8=;
 b=SJ49S4YgcZBKsp3kfQXlcjPkEeTdYkoklgKRKjtxkHEDKmHI1BxPUMu25qoVoTHik8Upi7qJQF61Qwb/bGZF/Y9syQA4uH4EcpV1CvRaTw4rR9ruWnhgJusHncNgM+6la9+J6CTprRS+KVEOVFHPS8f1F5Fp9jOjT3FBORcpKufKqQXDJX9zYHVokvLAJJLZwW6pUZKArXmFFZwm7gg0jPDMc9sKWnlAZE6jKikh2qWTin9ohe882K9zjGQC2HZZTQImrahKeCGifoRYsGk1vh0iiMHw+heH9jCbh/zHKoKDnYo5I9pGxuolSY0AoHMPMOAVBbtGhr+FfEbi79/Edg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=mentor.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mck2kJHDfowIiLvMIG/pixxdcR/duNnr7NGyBqqoPw8=;
 b=LwK9YN7mLPEIT3hPn7IuotbRnhPGkgCBH/B6PNmbZmDNpwbVLkvaeuqtoHPiC2VxzesqKffA8RXdfDMxRxalyWAcy2PZW8HENzfc981tmtjkWJzlD3xmr1ZAm9BKphgwEkvqNDEPCM2L8e8xQMOpHjuHO7YWa2UYcnu5ntTOsCya638Wb0hxLFW80SR6PKskPUj+BinATzr9Q5QveSNzISEobklu+h+6HD8tMVIswceUnjzkMKQCXBuqDRlLgAsvW1vFcb81Xc9j0HrswmiK0iAv8gbEZ7vHIojBCLTUeMkp7tU42gHIdAuNP4sv+pOPN4LPLBTDKMb3fWwyr2/0nQ==
Received: from DB6PR0801CA0064.eurprd08.prod.outlook.com (2603:10a6:4:2b::32)
 by AM6PR10MB2728.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 11:07:48 +0000
Received: from DB5EUR01FT038.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:2b:cafe::3e) by DB6PR0801CA0064.outlook.office365.com
 (2603:10a6:4:2b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 11:07:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT038.mail.protection.outlook.com (10.152.4.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 11:07:48 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 8 Mar 2022 12:07:48 +0100
Received: from [139.22.141.219] (139.22.141.219) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 8 Mar 2022 12:07:47 +0100
Message-ID: <2c68e8f4-0157-c03f-16eb-ba6ea794b492@siemens.com>
Date: Tue, 8 Mar 2022 12:07:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [cip-dev][PATCH] linux-cip: Update kernel versions
Content-Language: en-US
To: Srinuvasan A <Srinuvasan_A@mentor.com>, <cip-dev@lists.cip-project.org>
References: <20220308104407.780804-1-Srinuvasan_A@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220308104407.780804-1-Srinuvasan_A@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.141.219]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4f2f868-330c-4be9-0480-08da00f3e171
X-MS-TrafficTypeDiagnostic: AM6PR10MB2728:EE_
X-Microsoft-Antispam-PRVS: 
	<AM6PR10MB272807BE9F8ECAC08BB3352D95099@AM6PR10MB2728.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5Zsq26K/Iu2mamETNZJW+MFIWaUk9pRsPJfmExMJ8Vo7ToPUQlTgRkzpm3zVU8PQv3ZNUvPd9I06spt8Y+n7i7iRCwmFu4AswYLav9HkqEnI40olZ9HEqwuVd58H/gwZ2N4Lizla8SUZ65bhyY7zypDQXqpA4W8ACUXk/deKwNvJp5cwwlCir9lXWyPf5a7Y5QQXKbCD9ULu+wATLYco6RaSfsoAm3m4RSfYgqtTXaLi9c6trhmKXDZo7/fmtV6uBaBD1dvEV/rRdkfVd/MUXIgZl2GBYYOmJH4swZ6Y1sKb9lKRBXb6syb+mKsLpisRax9jxhCZRLNd3lb8M8DiiJ7WUbQW5+IcHqINZYzTSC+33HN1+YJrPKx6wyV7koKyaKbMFDHbCUmVIbE9LmC8zKzgOxg3xevIyjQFA21MFXoerBUqryZM3BCU38WBCvYmYqWzQMPipBuoVrYdkZT3tls6MUbW7L61EL6aG0HmibbIku4jtPKkk+Rh5guc3M7NN9EHUH/XXahnrofS83h9Dh4qypjapfLvxeXNOPgqvSjHPLOCPbBQFcMdg/05Dyt7EK81gpqLPr8M/SGGvPZHjWWdbiNNsR4mLiAIVB8XcizQtdKf9vVbqoRFUxERVtT2/YiVJAFaVDBk3blaxbc7jFvhnW6x6b+qwWOTEBbCUMizFaFV2rnWYTCLSiDpE8qew/fObrVDsGCoihDviyE6h5eh0QTtt9ei+U/p+bhPxnkz+hInCtkDzzJv0GEZoSSO5TVQpA6luVAm21VElMKhoQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(356005)(82960400001)(47076005)(5660300002)(8936002)(8676002)(70206006)(70586007)(36860700001)(44832011)(82310400004)(2906002)(81166007)(508600001)(53546011)(86362001)(110136005)(6706004)(31686004)(36756003)(16576012)(316002)(83380400001)(336012)(186003)(26005)(16526019)(956004)(2616005)(31696002)(40460700003)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 11:07:48.4891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b4f2f868-330c-4be9-0480-08da00f3e171
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT038.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2728
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Mar 2022 11:07:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7669

On 08.03.22 11:44, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
> 
> Bump kernel versions for linux-cip-kernel 4.4,4.19 and 5.10.
> 
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>  ...4.4.285-cip63-rt36.bb => linux-cip-rt_4.4.302-cip68-rt38.bb} | 2 +-
>  ...rt_5.10.83-cip1-rt1.bb => linux-cip-rt_5.10.100-cip2-rt2.bb} | 2 +-
>  ...{linux-cip_4.19.217-cip62.bb => linux-cip_4.19.231-cip68.bb} | 2 +-
>  .../{linux-cip_4.4.291-cip65.bb => linux-cip_4.4.302-cip68.bb}  | 2 +-
>  .../{linux-cip_5.10.83-cip1.bb => linux-cip_5.10.100-cip2.bb}   | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>  rename recipes-kernel/linux/{linux-cip-rt_4.4.285-cip63-rt36.bb => linux-cip-rt_4.4.302-cip68-rt38.bb} (72%)
>  rename recipes-kernel/linux/{linux-cip-rt_5.10.83-cip1-rt1.bb => linux-cip-rt_5.10.100-cip2-rt2.bb} (72%)
>  rename recipes-kernel/linux/{linux-cip_4.19.217-cip62.bb => linux-cip_4.19.231-cip68.bb} (72%)
>  rename recipes-kernel/linux/{linux-cip_4.4.291-cip65.bb => linux-cip_4.4.302-cip68.bb} (72%)
>  rename recipes-kernel/linux/{linux-cip_5.10.83-cip1.bb => linux-cip_5.10.100-cip2.bb} (71%)
> 
> diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.285-cip63-rt36.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip68-rt38.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip-rt_4.4.285-cip63-rt36.bb
> rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip68-rt38.bb
> index 41342b3..fae4125 100644
> --- a/recipes-kernel/linux/linux-cip-rt_4.4.285-cip63-rt36.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip68-rt38.bb
> @@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
>  
> -SRC_URI[sha256sum] = "c2fe6bcf44fc7a8ee9785adc4dc41d07c50d803883add859648cbbb0461854fa"
> +SRC_URI[sha256sum] = "bbcc9af1b08a1285a9fc5ba57cba74dcc9fb6511dd74029576ca82629d04cad7"
> diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.83-cip1-rt1.bb b/recipes-kernel/linux/linux-cip-rt_5.10.100-cip2-rt2.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip-rt_5.10.83-cip1-rt1.bb
> rename to recipes-kernel/linux/linux-cip-rt_5.10.100-cip2-rt2.bb
> index b20ac56..96c4d07 100644
> --- a/recipes-kernel/linux/linux-cip-rt_5.10.83-cip1-rt1.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_5.10.100-cip2-rt2.bb
> @@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
>  
> -SRC_URI[sha256sum] = "e10b3ab1ad09ed7650883c5357b68660ac1c56f6d71b3b82feb0d69ed182ea54"
> +SRC_URI[sha256sum] = "e642fc604b611dc6f3e8382447fb2bc4047d129a14cba3996d34b85e07ae9d3a"
> diff --git a/recipes-kernel/linux/linux-cip_4.19.217-cip62.bb b/recipes-kernel/linux/linux-cip_4.19.231-cip68.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip_4.19.217-cip62.bb
> rename to recipes-kernel/linux/linux-cip_4.19.231-cip68.bb
> index 0147313..91ef5f6 100644
> --- a/recipes-kernel/linux/linux-cip_4.19.217-cip62.bb
> +++ b/recipes-kernel/linux/linux-cip_4.19.231-cip68.bb
> @@ -13,4 +13,4 @@ require linux-cip-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
>  
> -SRC_URI[sha256sum] = "00b22f2e7b3d4f5787ca92f2e182211ac2c1391c09435174c2b4670b2837b23c"
> +SRC_URI[sha256sum] = "f39146555dcee1e9f76c4b6e000e0d6f42d4a6a56d95d415ac1442b1f99d0465"
> diff --git a/recipes-kernel/linux/linux-cip_4.4.291-cip65.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip68.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip_4.4.291-cip65.bb
> rename to recipes-kernel/linux/linux-cip_4.4.302-cip68.bb
> index 4e32031..160b7ed 100644
> --- a/recipes-kernel/linux/linux-cip_4.4.291-cip65.bb
> +++ b/recipes-kernel/linux/linux-cip_4.4.302-cip68.bb
> @@ -13,4 +13,4 @@ require linux-cip-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
>  
> -SRC_URI[sha256sum] = "9ed7782c067793e684691e99388608ff746f04121cc35dbbbfc2fa5ed6f9e88e"
> +SRC_URI[sha256sum] = "d49e1fd2df419279a8595db6e68311cbb91399a92e6d71672543c4eb2088b317"
> diff --git a/recipes-kernel/linux/linux-cip_5.10.83-cip1.bb b/recipes-kernel/linux/linux-cip_5.10.100-cip2.bb
> similarity index 71%
> rename from recipes-kernel/linux/linux-cip_5.10.83-cip1.bb
> rename to recipes-kernel/linux/linux-cip_5.10.100-cip2.bb
> index 236358a..e2bb298 100644
> --- a/recipes-kernel/linux/linux-cip_5.10.83-cip1.bb
> +++ b/recipes-kernel/linux/linux-cip_5.10.100-cip2.bb
> @@ -13,4 +13,4 @@ require linux-cip-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
>  
> -SRC_URI[sha256sum] = "85af8f809b2505c6434266d6658d977d62d383889b3a4f9968b2764794108d4f"
> +SRC_URI[sha256sum] = "0fe532c7900299888160a740ed70c1daaa9536fe545bee4f754043e1e0a09c16"

Thanks for taking care! Applied to next.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

