Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C39C433EF
	for <webhook@archiver.kernel.org>; Fri, 17 Dec 2021 14:49:55 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.88])
 by mx.groups.io with SMTP id smtpd.web11.7037.1639752593453168629
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Dec 2021 06:49:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=k25W8rSd;
 spf=pass (domain: siemens.com, ip: 40.107.13.88,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRAxfn1q7A0LzpsxC2SpjxdbjZCeL9jtw/NlbwJRIB34jAHO5SanwBnD4FHwropyOZu3ylJBGNPrFbISgXjstbkEU4VZMcxtKqIe+V3BE2tSi7YEMqqghxeOOxX+AR4L1JdjkG90C6TyX4wQJXq95jNLsBiEbb5oIt08gFAVt3RKV0ILQC1oudtPsf2q8lxtmY+H04CdUHh7fZl6nEbdG/y29446ij6pD15blIzTr7QVOEyTZSgFjLihnraFcPwvykX+mWABN11bb7qO1VD53jJjiA76YUAaaQ/EFAvrUeeWhaC0JbMTpkjZjhXiYX/K9ejDMtnzdsZlqRuTjJfNgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nubL3I4yYIF57ZdgcTkdHGOx4isXFqkvK1R5NWwCqzc=;
 b=R/xkrmOwL1hPu2nFV12sKiiEE3C8XsaRNC1twGq7MA27Hjw6bOWLed4te6XZEbDLYAXO8MdP5a8e6zxeePCITwqW68BqVopmHbhgN5PPWi6Bx5JJZEwQ5hWJMSKZAV1x51i9//0IhfnWdyuLhjmUe7VCg/NtCBuGHyxf3iwkJzFdsGECI9e83VU951k6ERPRUX5FNC1Je5VlZkqQxNzWr742rtUtjM30DfmQNd9L/NYh5m2s+/gGBXdnaeeVJLT3gJL8nXCRISnSGRTrO4JDKnCeTMS3msxdGoZm1cdgcOpG/rY5MGicg6GJOc9C0rUCkwIRtKQod0B0Ovy/YTb78w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nubL3I4yYIF57ZdgcTkdHGOx4isXFqkvK1R5NWwCqzc=;
 b=k25W8rSdoCUPPeE1AJsFE9fbuqmDUCy6qCtVHX+ItclAm/uxyEjtPtRh4aBBDR21J8i5xGeyRSOwxL280oAarr14gDczhStP8Nc1l3tI7IYKpLE97pft5yPDQD+Kntqm1slLFS6nFosuJoUl+HDY5RpE1ndHnvCQ2DXh8D0AC+fpmibps56iw7NhalcPlK65WGcCTCgnbfn3N3WFgHr4TyL2BuQHdSS31QOkbMo7/UlCDVTIpZhACes4ZLOI2dHxVIYzitlAHkuNZg4C8tffzbX2PAxodokprcpUBSzXNBfbvFu9WnTmsLXBYsDaq0EasiYHsr/n9sVQ4VdCAcLMmw==
Received: from SV0P279CA0030.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:12::17)
 by AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:50::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 14:49:50 +0000
Received: from HE1EUR01FT034.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:12:cafe::e2) by SV0P279CA0030.outlook.office365.com
 (2603:10a6:f10:12::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 14:49:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT034.mail.protection.outlook.com (10.152.0.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 14:49:50 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Dec 2021 15:49:49 +0100
Received: from [167.87.72.12] (167.87.72.12) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 15:49:49 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH] Make read-only rootfs a inc file
From: Jan Kiszka <jan.kiszka@siemens.com>
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20211217135015.1189442-1-Quirin.Gylstorff@siemens.com>
 <6066ea89-53fb-98b6-9e4f-7e27486b6d97@siemens.com>
Message-ID: <12bda5b2-4bc4-2a93-ae1a-9d7fd5e42cdd@siemens.com>
Date: Fri, 17 Dec 2021 15:49:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <6066ea89-53fb-98b6-9e4f-7e27486b6d97@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.12]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a50524d0-ce74-4c73-b705-08d9c16c7a72
X-MS-TrafficTypeDiagnostic: AM6PR10MB2181:EE_
X-Microsoft-Antispam-PRVS: 
	<AM6PR10MB218129100010405DF948699C95789@AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EFBxc5DjcsKQHv3OgVh4H+50uknQUZvyiukZs31XYW2fvg8uw49FhBIh90ks5z0Rng7TkCTkjIYmDbJNuDSraKQxnWWahcKMSNTaMyY1RucfJJXUgG2LKsB+weYktZ9gNtvy5T2i44Z8lTvC+HwmFTJZKsMWjKGUn+YU0WgIAC0IS58mtnzw6dvc1vgupDDPTBAsBGOCKztmnSnHEFDDWP2MhmtADEFQBWUdLDIWj23C9L+3f8EnWcpAw58dBrQs47dadf9lxlZq8gMKFhbReyRnVjTSpw/IHzXssAP/HZhpkfFOU1k9PCrcsO6xh8Sp2wc7iif/rgxbplI9KXbg6yGxy5mVek98BzEXaglgCrSHjbyugknvGGOfz/UxKXwaD0m36LYha74w9JU+zTwvedwmnKCuuvr7f7hNNK99m+a0cx3As1vZw9y8f/pi2mMwaZSU5GJcpyZ8aJSYwOR6ndRrzW3BNshVx3VjwTbeR78+nR29qyeTqIg7uQ2tqfw4Yys0+hr305mduSiXJRxBosk/yDxh1p6nBommOo1imIAipYW8B3eCcwzKjG7563SUh4QUqWiLbekUX0qFfsnlCCVkrgCibScjn0AHvhWlkSFaCaTg6crUGxVwvG8+90YpdWz9NeF1Sav75E4aYWEOIIVr0upNsuRA5OJMmj7QHsEk/IJhgYBEYU92GtGSOUs6Ycm4jlboeTwf4EKk0IAfgz83vBuSZktfdkGpxu4JC9BBp1k0Se2XIUOBP+z94Ff0L/mIHeHA4RBar3XJt/UiUMmS4YSUungtvnJ0n7/QAD/INLeOXdlc24eeLvk1x3bM0nK3zW6a9YHX1lR9nFYbiIJsdrCmw2F/29x0XXhaGRQ=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(16576012)(316002)(47076005)(2906002)(336012)(53546011)(26005)(16526019)(40460700001)(6706004)(82960400001)(186003)(2616005)(86362001)(956004)(36860700001)(31686004)(36756003)(8676002)(82310400004)(5660300002)(70586007)(31696002)(44832011)(508600001)(110136005)(356005)(81166007)(70206006)(83380400001)(8936002)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 14:49:50.3821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a50524d0-ce74-4c73-b705-08d9c16c7a72
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT034.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2181
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Dec 2021 14:49:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7183

On 17.12.21 15:19, Jan Kiszka wrote:
> On 17.12.21 14:50, Q. Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This allows downstream recipes to include the kas option
>> and use the include as base without recreating some parts
>> of the recipes.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  kas/opt/ebg-secure-boot-snakeoil.yml                  |  4 ++--
>>  recipes-core/images/cip-core-image.bb                 |  3 ++-
>>  .../{cip-core-image-read-only.bb => read-only.inc}    | 11 ++++++++++-
>>  .../initramfs-verity-hook_0.1.bb                      |  2 +-
>>  start-qemu.sh                                         |  3 ---
>>  5 files changed, 15 insertions(+), 8 deletions(-)
>>  rename recipes-core/images/{cip-core-image-read-only.bb => read-only.inc} (78%)
>>
>> diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
>> index 1cfbacc..807b0d7 100644
>> --- a/kas/opt/ebg-secure-boot-snakeoil.yml
>> +++ b/kas/opt/ebg-secure-boot-snakeoil.yml
>> @@ -14,16 +14,16 @@ header:
>>    includes:
>>     - kas/opt/ebg-secure-boot-base.yml
>>  
>> -target: cip-core-image-read-only
>>  
>>  local_conf_header:
>> +  image-options: |
>> +    CIP_IMAGE_OPTIONS += "read-only.inc"
>>    swupdate: |
>>      IMAGE_INSTALL_append = " swupdate"
>>      IMAGE_INSTALL_append = " swupdate-handler-roundrobin"
>>  
>>    verity-img: |
>>      SECURE_IMAGE_FSTYPE = "squashfs"
>> -    VERITY_IMAGE_RECIPE = "cip-core-image-read-only"
>>      IMAGE_TYPE = "secure-swupdate-img"
>>      WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
>>  
>> diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
>> index 2cecde3..9bf21ff 100644
>> --- a/recipes-core/images/cip-core-image.bb
>> +++ b/recipes-core/images/cip-core-image.bb
>> @@ -18,4 +18,5 @@ IMAGE_INSTALL += "customizations"
>>  
>>  # for swupdate
>>  SWU_DESCRIPTION ??= "swupdate"
>> -include ${SWU_DESCRIPTION}.inc
>> +CIP_IMAGE_OPTIONS ?= "${SWU_DESCRIPTION}.inc"
>> +include ${CIP_IMAGE_OPTIONS}
>> diff --git a/recipes-core/images/cip-core-image-read-only.bb b/recipes-core/images/read-only.inc
>> similarity index 78%
>> rename from recipes-core/images/cip-core-image-read-only.bb
>> rename to recipes-core/images/read-only.inc
>> index 79cd6bf..604caa0 100644
>> --- a/recipes-core/images/cip-core-image-read-only.bb
>> +++ b/recipes-core/images/read-only.inc
>> @@ -1,4 +1,13 @@
>> -require cip-core-image.bb
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2021
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <Quriin.Gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  
>>  SQUASHFS_EXCLUDE_DIRS += "home var"
>>  
>> diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
>> index a7fbf5a..f0d2d68 100644
>> --- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
>> +++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
>> @@ -24,7 +24,7 @@ TEMPLATE_VARS += "VERITY_BEHAVIOR_ON_CORRUPTION"
>>  
>>  DEBIAN_DEPENDS = "initramfs-tools, cryptsetup"
>>  
>> -VERITY_IMAGE_RECIPE ?= "cip-core-image-read-only"
>> +VERITY_IMAGE_RECIPE ?= "cip-core-image"
>>  
>>  VERITY_ENV_FILE = "${DEPLOY_DIR_IMAGE}/${VERITY_IMAGE_RECIPE}-${DISTRO}-${MACHINE}.verity.env"
>>  
>> diff --git a/start-qemu.sh b/start-qemu.sh
>> index 4ab3861..24df490 100755
>> --- a/start-qemu.sh
>> +++ b/start-qemu.sh
>> @@ -45,9 +45,6 @@ if [ -z "${TARGET_IMAGE}" ];then
>>  	if grep -s -q "IMAGE_SECURITY: true" .config.yaml; then
>>  		TARGET_IMAGE="cip-core-image-security"
>>  	fi
>> -	if [ -n "${SECURE_BOOT}" ]; then
>> -		TARGET_IMAGE="cip-core-image-read-only"
>> -	fi
>>  fi
>>  
>>  case "$1" in
>>
> 
> Thanks, applied to next.
> 

We have a regression, you already saw it. Dropping this, waiting for v2.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

