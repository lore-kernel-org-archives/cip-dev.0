Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E6CC19F2B
	for <webhook@archiver.kernel.org>; Fri, 29 Jul 2022 08:59:12 +0000 (UTC)
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (EUR02-AM5-obe.outbound.protection.outlook.com [40.107.0.64])
 by mx.groups.io with SMTP id smtpd.web09.5947.1659085146230384625
 for <cip-dev@lists.cip-project.org>;
 Fri, 29 Jul 2022 01:59:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=occupDez;
 spf=pass (domain: siemens.com, ip: 40.107.0.64,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+UnJ8/I4y28U8n9exOpdke64HKbxw9Tx4xacC9Nb338c8PZgAnqycjBHN2e9rbLrlddKtXkJy5B2N017X7WVKO4hVlgoX9KufKlztvHCdS68tI7lrnGe/gEcMkjoCXSy5dGTIF5AY2kAmrEQBIAdGpzJWf0xa40x0CF4ad0etij7KwZUC1xxXB7s3GjaLg55dvni3NSGMh2UivHU9tgfQIdAFW8SA7WFvFzapYX8fC1M2aaAIenbMTHQw4irYGgqpj28H4TvDOx6WX9lQgqphlTeP4lxM0qCWSMzipjnhiibzUklGcwb8htl77szsQaufhOJ/tpdksaWRIQAnSMsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7ZRyA87qc+CQ7zhlNUSaL0MnZ+ELVWIwFJZfBIz9o4=;
 b=an0KZxpMkydQ2PatOSNB0EZ3B8qI3dzw6QiLGdDFgFCErcJo05UXF1A3agpRFWf7kLg2pyz19e9MFEkfMgM1KRqaIEvFRx0/JWAWxY1HbQg76TjeI0mNTdYR+ddS9nEiAmgbESa4LdInuMnQK5bVlYG0uJXSr9OLUVRqmJNayfj4oJX6PCe6Flpn3zUEBcOl/1XwzjAyprtgxjfEEau3/l8uv2ZKtlP8WXNlLJm5O0z2aBZu8pQFVUeYU+81JrK12ACFUSZ1zDYbj2t4TKBADihZ/ErVUQSUaVvHKcqpUdvNEAPORccOPr+oCu6Ch+t36m8dK3mm/bMWrNa/jMth5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7ZRyA87qc+CQ7zhlNUSaL0MnZ+ELVWIwFJZfBIz9o4=;
 b=occupDezylC5LR6qbYoOiHg5e68+E3srH8hnumpNqPXaor+69PsExYWe5MIXTDKtMtM+t7pvLPt8YNtYTdhQwaAuNTOhVURUz+Od2JaXj8oRia4VEvqromHB1C7Au9N8hf7lTVG1BDSJ7O/n5ICi6Zkl+OLaGUZPxmXKiNgQ4Os23XWn4lFnIR0cuiGQDB0NBYx3PaHPoMdNAZkbWMk4W9buNhaUY10G6azfsfJSj82pmKuNu55Z63Rmr9aT40BKCmYLSDqlTKzjSM6A4l+X8LxjnifLiFycNthW2Fr/sfOww5F7NMQXrAkVfWKfM7UsXC/olKsFsMcuk+Z8xOrMCg==
Received: from DB9PR06CA0016.eurprd06.prod.outlook.com (2603:10a6:10:1db::21)
 by AS1PR10MB5699.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 08:59:03 +0000
Received: from DB5EUR01FT056.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:1db:cafe::e) by DB9PR06CA0016.outlook.office365.com
 (2603:10a6:10:1db::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10 via Frontend
 Transport; Fri, 29 Jul 2022 08:59:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.70) by
 DB5EUR01FT056.mail.protection.outlook.com (10.152.5.101) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.10 via Frontend Transport; Fri, 29 Jul 2022 08:59:03 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 29 Jul 2022 10:58:57 +0200
Received: from [167.87.165.107] (167.87.165.107) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 29 Jul 2022 10:58:56 +0200
Message-ID: <d6ce2432-64b6-6527-2319-408266fb9b00@siemens.com>
Date: Fri, 29 Jul 2022 10:58:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/4] scripts/deploy-cip-core.sh:
 Use dtb from deploy dir
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220729083931.419731-1-Quirin.Gylstorff@siemens.com>
 <20220729083931.419731-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220729083931.419731-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.165.107]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.384500-8.000000
X-TMASE-MatchedRID: UgbjIbm2QqbrOhfRe676RwJfVW3wuXXEPg9yfk4YC0YaLqFbxdotGTBm
	BWlTIsc9RjHvrQ40NxYYfj4uQ0EvjCjwMHIe25XXXlG4YAM40y5htXrMw2PG7ZxVZzZr7+O7S1z
	wNuiBtITfUZT83lbkELKBpljvKsfOPRxYd0S1w+mi/AZhCNPH0BuJvDGlBoBG2K3acmlx/mnihJ
	3Xxt2bAlbDmwy31ULEtqY/0EO3UN0i2no2mxf/WDMO1T0fIOjpPlW4iFrgB0n27WtDgGBc8r/I3
	arxTrvikshAoFcG3yR7+nBu7fbl6ivn27+DO/kwtTOrxEGQm4ZJI5ZUl647UDl/1fD/GopdWQy9
	YC5qGvz6APa9i04WGCq2rl3dzGQ1YVY7U1JSkeCpEY3bFmFDTmGs2fn0PNBzYLOSTZs8Onbg7uw
	p2KIKmA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.384500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 9E80886AAD4CF2485C24B5C041BB4B088903BE3CECD63262B6B1C7DFDBAAA71E2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd4fd734-8086-4759-7caa-08da714095ea
X-MS-TrafficTypeDiagnostic: AS1PR10MB5699:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CT79Lzf/hdgE+CN0rDWYBoZCC/T2pELW4Nw8MeK7uHi8nGOhauSbW2GjKGMQ4IL6ZBXHCAMHZF1Up8ig1yQ0ViULWTJ22S8ZtMB03m8v+ANBzZeTZSV90Wc27S41vOghvQOm8vcghAcrHffsyv48+D1d+Dw5Oe8kzm8E21Z7ovEnKAHQP+Yg79vSK5W+nd0oq/9Ag0+8wtVdr+m3i3JDtpIHr484u82xPdCgt1vc66spQMNsSWoGooqFc7XT/E/397AIfHCCBvsq22N9Pu9C1rDOaP1MFXldPf4a5Ez5h7eHWZc2xBnWevg+pS+InWm4Whj7fAxYilsVNyOO45oupVLreROlqFyq0B/B1Qi7EOO5EA6SVbn2T5Gl1HU3g3c8tiapwZYFDwp1t00H9oqV6d4hdaQsxfDtBwtxBnuVBzJ8iTajElKq9UlAEBHD9im9iSZwIX1LuWfferb5lnvXo3qUulcbHkrlTKwwbE73D0/ZMrgC/765iZQzf2C7eV7p71cpCrvTWRaitsHn+PsG2ESFvFqr8UE2QMhr0jHVMV2Shx6bAw05dZImgmtt7A6hj9BTrClSBO10szUT7YFaADuRd70D35KwTNhMsvLQ0F7onofvX/cEyPz4l8oyhCjj17B8YeIFYnIfTG8ldnLPQ7u57DET+Fh+MIoGZb2i3AdzsIN+xPKrpkXzv21GspaABq2fV8dSRul12mmSeSDlu/8+n3WP4UjIgzRvWLAGIsHkMggLgTGOmE+42awfBIL1DKmRRxlEVwj8nB73ANrZ3WTB/kdxURafcIHYKZUonHWRddqKSWRN3/X3gaOxC/gGeADNPsaCaQnIGRPgEpR8a5UfuASOOQsr5EtDQAkADTkXcJQ5nzIxGZcYOOC4HbZU
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(136003)(40470700004)(46966006)(36840700001)(2906002)(5660300002)(82960400001)(41300700001)(86362001)(47076005)(316002)(82310400005)(36860700001)(16576012)(36756003)(6706004)(16526019)(186003)(110136005)(31686004)(2616005)(956004)(8676002)(336012)(82740400003)(478600001)(31696002)(70206006)(7636003)(7596003)(70586007)(40480700001)(8936002)(26005)(44832011)(356005)(40460700003)(53546011)(83380400001)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 08:59:03.2583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 bd4fd734-8086-4759-7caa-08da714095ea
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT056.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5699
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Jul 2022 08:59:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8976

On 29.07.22 10:39, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This fixes the build errors after sbuild migration as the build
> artifacts are no longer available after the build.
> 
> This adds the DTB file for the beagle bone black to the deploy
> dir to fix the CI pipeline after using sbuild.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .gitlab-ci.yml             | 6 +++---
>  conf/machine/bbb.conf      | 1 +
>  scripts/deploy-cip-core.sh | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 3d39d1f..41af3e9 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -68,7 +68,7 @@ build:hihope-rzg2m-base:
>      - .build_base
>    variables:
>      target: hihope-rzg2m
> -    dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
> +    dtb: r8a774a1-hihope-rzg2m-ex.dtb
>  
>  build:qemu-amd64-base:
>    extends:
> @@ -166,7 +166,7 @@ build:hihope-rzg2m-test:
>    variables:
>      target: hihope-rzg2m
>      extension: test
> -    dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
> +    dtb: r8a774a1-hihope-rzg2m-ex.dtb
>  
>  build:qemu-amd64-test:
>    extends:
> @@ -271,7 +271,7 @@ build:hihope-rzg2m-buster:
>      - .build_base
>    variables:
>      target: hihope-rzg2m
> -    dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
> +    dtb: r8a774a1-hihope-rzg2m-ex.dtb
>      release: buster
>  
>  build:qemu-amd64-secure-boot-buster:
> diff --git a/conf/machine/bbb.conf b/conf/machine/bbb.conf
> index b592f4d..ea87ed8 100644
> --- a/conf/machine/bbb.conf
> +++ b/conf/machine/bbb.conf
> @@ -7,6 +7,7 @@
>  #
>  
>  DISTRO_ARCH = "armhf"
> +DTB_FILES = "am335x-boneblack.dtb"
>  
>  IMAGE_FSTYPES ?= "wic"
>  IMAGER_INSTALL += "u-boot-omap"
> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
> index 203ab1d..01aa494 100755
> --- a/scripts/deploy-cip-core.sh
> +++ b/scripts/deploy-cip-core.sh
> @@ -50,5 +50,5 @@ aws s3 cp --no-progress --acl public-read $KERNEL_IMAGE ${S3_TARGET}
>  aws s3 cp --no-progress --acl public-read $BASE_PATH-initrd.img ${S3_TARGET}
>  
>  if [ "$DTB" != "none" ]; then
> -	aws s3 cp --no-progress --acl public-read build/tmp/work/cip-core-*/linux-cip*/*/linux-cip-*/debian/linux-image-cip*/usr/lib/linux-image-*/$DTB ${S3_TARGET}
> +	aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/$DTB ${S3_TARGET}
>  fi

Can't we do that before patch 1?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

