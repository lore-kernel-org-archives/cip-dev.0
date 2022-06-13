Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BF0C433EF
	for <webhook@archiver.kernel.org>; Mon, 13 Jun 2022 09:32:06 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.64])
 by mx.groups.io with SMTP id smtpd.web08.3901.1655112720785986646
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Jun 2022 02:32:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yLIf/3vE;
 spf=pass (domain: siemens.com, ip: 40.107.20.64,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmKtG0bcYbTS/HY8wD93EmFT7NMn01P2ezDJ3WQpOSqmnktOqFJ3RqIDRjSIGtY1fAj+KwzJG2E6PuQwrPXSo4mgFaeF82tjhvqF4NnSF3luFaJCgNdSxJP5gRGZ1xRd9y6p/glOqaqcjAcqv1pNhLML9xUqhkkZQlPZ95Gmrd7ycQn+Iu9glokmY4mLlxmIhOe6qmkn50/RU8/pnBF9ZE5szYQzbZubDdzFOYIbykFEUPASmadsOIwsHKh9480Wozyn2TzgAQmG38oHwm9mLyJzgpBEEV7m3L9Y3zYkYyUviLTCbWj6LyVTg/sH8QHqDUq3av/K6IS59mRxAXk8BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCR+05nPY07h7RG/CdTuno+/qsnj+sxm7tmnz8T4ZwU=;
 b=EH4dySMKo/k+a4JEwTDpyWMRJrxXCaRp56yTr4E0dwy8UsjeBDk++yhSniLYA5xiM6XsiABig3WsPyHBIITmkTiDzxnjcvvDhHXl93kQA8jGiC54YblNq19w1YLoKGgk5dS6lFOJ0IxiW45suxupj6cYGrrL4S4FYpjetcLNWxw2bJsyTl0dI/mfngAU5OR+nelelUpAXzzf+BHudu8goyecNqsXFzWWdaXya8OC4UaTSDr92XPS5KeIq/0+enSVbw92bosL6djqWPm5MZT3LhL3OIo8bdJdqRievFrzbp2vpMHFOnBituxZ9gXL3gjYf7lCOOiI+0IYx5VMScShAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCR+05nPY07h7RG/CdTuno+/qsnj+sxm7tmnz8T4ZwU=;
 b=yLIf/3vEzhXOsmZ8Kr5+g5RmDZtv+ws7NcfK7yzB7bqslIERSvP1lrSRkDy7AvCN0c4Ny5wnuhlmAltq1FKjbwwIs0CnkN/uJsCJ1LcIBT1MlD+4q2wz8fpECtMizNoiYVvOaVAJeAs5T3w6Dne2p6P4n8irhr4Ar7D6LV8dFQ9Uv13NoL2hrBYxdDL0JPn8PzfMlwIq1N5vfDRIGUDHwzS8H8fC8nMnCuk+n+nS6ha0mP/nVL86RwsdgXtvgzYxzrONeQEItybqGR6We4L2QFa9KJpjrY9zE/EPt8HPm5nt0imZwwb8kiuz4W05wXfmC95fbukys9JzZ46uMjYL4w==
Received: from DB6P18901CA0015.EURP189.PROD.OUTLOOK.COM (2603:10a6:4:16::25)
 by AM6PR10MB2456.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:46::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Mon, 13 Jun
 2022 09:31:58 +0000
Received: from DB5EUR01FT065.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:16:cafe::35) by DB6P18901CA0015.outlook.office365.com
 (2603:10a6:4:16::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12 via Frontend
 Transport; Mon, 13 Jun 2022 09:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.70) by
 DB5EUR01FT065.mail.protection.outlook.com (10.152.5.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 09:31:57 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 13 Jun 2022 11:31:57 +0200
Received: from [167.87.5.173] (167.87.5.173) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Mon, 13 Jun
 2022 11:31:56 +0200
Message-ID: <34a53fee-6dd6-f32f-c819-024ce98761b9@siemens.com>
Date: Mon, 13 Jun 2022 11:31:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/2] .gitlabci: switch to bullseye
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220610072524.910925-1-Quirin.Gylstorff@siemens.com>
 <20220610072524.910925-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220610072524.910925-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.5.173]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--14.940000-8.000000
X-TMASE-MatchedRID: Am/bhnZHfiM5QaOxwNGfvo9bHfxDWoibLGmmJTL2jhwD2WXLXdz+ARqD
	rPipLA7BXjbObVmL4wk1OD0eEspJWJpi2sIlCYcAvlT8lbK+OU4X9I6oPIIpaSAI8aJmq0jw8bo
	ZEVitthjW4BShNeq/e89R2gopioGxcgUCahdneE/a++rCI4JwzZXvqupO0P3ML8y5bOx03xnLQx
	8PUawjW5soi2XrUn/JyeMtMD9QOgChMIDkR/KfwI2j49Ftap9EOwBXM346/+zkkQSxKYbOwh6/f
	wWNzQoPsG78gmB+5ytk3Hd6GdU31xqH7WNxXyOo
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.940000-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 0E40B3ABE5EEF65183E44786A2FF06E26317B58D926D7085521C12B6E46503B22000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e61fb8c-4e43-40a7-ad43-08da4d1f8fd0
X-MS-TrafficTypeDiagnostic: AM6PR10MB2456:EE_
X-Microsoft-Antispam-PRVS: 
	<AM6PR10MB24568394260B5B525BE697FE95AB9@AM6PR10MB2456.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ilVcyWCwS1Y/N7jB0JtiS2Npsw+LRFPylx/ym7Ot1lG/HFfYEj1Do5cvLUz+Swag7AbaGuM26vZ4OQ+YONNeowFrOhW62jo0Y76y4wCxbRBg/GNrMPxPRMcM46Si3AJ7R2G5sOXcuv8iOWiFnZ/xy4okz0yZkOlbyWicPK2jfS8Npl6V9JeJQHsiuo2URSfIu9jnz/MZEc1Fl30xL9qC8Lm4SwCqFgbrpR+KdfVN6Z94iqeofVgGcIHnJAtsXR4nSKxNVZdMWorzIVzU6mn5yszOZg6AF+thoHt3U71qYGyNwx57kmNkOuhAyiGq9l86gD9qUsm20SorUSCAjPe62F9kCA1gCxTsow3pZwcl363/vNB8VtmD9+MwbbtTNyRyT0DHtLzTsWtsHuuouER3sGkXNJCXxWKaURWVCFZDmpDLwOKWvIg+v75CSwF8uCzgMyAxZocysS/LsZxJCm6lbFtyEfop0iUBs8kt8iqz3Q35lHwM/p1lRTdxAyWAswwS+Aa4dfxBFIv9iIiXwV11lwLUnGL7PGm9UMJw0//YHCVHS4vsirTPcjkR9BJ31Yzt/na8RpxH2WfgiWkB1lu6RTBFCz6JfmZrT2L9M7J7LQXQvoYE9yO0wM5edBPRUiFH7A05eLG3WF3Zk34PYaonXDzY+VKhVcjMZ/oI0hRBMzNmnqn6H+fjMmOFxdTqpaA+485UWC+SLV87kiYwoSIh9JjLOrMY2iLGIuWVfjK0K/hXGuxavu2cvxX50UL61SfAo2maAm0yuuJxkCCo7/pYFyVo/ceYtR1nWsyleUy77DcuaLFo9fO3aumeud8RZ5zN
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(86362001)(84970400001)(31686004)(31696002)(8676002)(70206006)(7636003)(356005)(316002)(82960400001)(40460700003)(16576012)(110136005)(6706004)(7596003)(2906002)(8936002)(70586007)(5660300002)(44832011)(47076005)(16526019)(186003)(336012)(956004)(2616005)(508600001)(82310400005)(36756003)(83380400001)(26005)(53546011)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 09:31:57.7708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 4e61fb8c-4e43-40a7-ad43-08da4d1f8fd0
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT065.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2456
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Jun 2022 09:32:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8548

On 10.06.22 09:25, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .gitlab-ci.yml | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 23ab1cb..7c28ea1 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -2,7 +2,7 @@ image: ghcr.io/siemens/kas/kas-isar:3.0.2
>  
>  variables:
>    GIT_STRATEGY: clone
> -  release: buster
> +  release: bullseye
>    extension: base
>    use_rt: enable
>    wic_targz: enable
> @@ -241,34 +241,34 @@ build:qemu-arm64-swupdate:
>      targz: disable
>      deploy: disable
>  
> -# bullseye images
> -build:simatic-ipc227e-bullseye:
> +# buster images
> +build:simatic-ipc227e-buster:
>    extends:
>      - .build_base
>    variables:
>      target: simatic-ipc227e
> -    release: bullseye
> +    release: buster
>  
> -build:bbb-bullseye:
> +build:bbb-buster:
>    extends:
>      - .build_base
>    variables:
>      target: bbb
>      dtb: am335x-boneblack.dtb
> -    release: bullseye
> +    release: buster
>  
> -build:iwg20m-bullseye:
> +build:iwg20m-buster:
>    extends:
>      - .build_base
>    variables:
>      target: iwg20m
>      dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
> -    release: bullseye
> +    release: buster
>  
> -build:hihope-rzg2m-bullseye:
> +build:hihope-rzg2m-buster:
>    extends:
>      - .build_base
>    variables:
>      target: hihope-rzg2m
>      dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
> -    release: bullseye
> +    release: buster

Thanks, applied to next.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

