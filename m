Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4A3C433EF
	for <webhook@archiver.kernel.org>; Fri, 17 Dec 2021 15:17:52 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.84])
 by mx.groups.io with SMTP id smtpd.web09.7381.1639754270682144329
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Dec 2021 07:17:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TdulztgR;
 spf=pass (domain: siemens.com, ip: 40.107.6.84,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOHHR1a/56fm3mJnRfHPA30+aQUWz57qCRKgYSXD1gg7JIu0g01DziQe3znEbjPHefwjEzpZU9ZaOrDYdY2PVrcMLRLA6fjRwLjlvalgIm90YOviHobZBlj0sOrJS+QHEecZBceEKjirCM/6r9uMeZ4TL6cLOI/cPMgq2L4bpHdWN5KL0ZE1+JlKwHVGL5YOrwcwbGs4Lvl8fR79vRjEKyaBLfth6Muv5YrV7Rnlc9bJLt9r5/oypzeNeoyuQwtJIuDVB5Lag5favgithWQQWoM9GR9CS6aez56T1Oi8hs7suvyODKsBjnPhHg0UzL8kKgnET3FKjQs1SfyRecsXXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzCegkgsUoPRrYtrEAXUb2IG8QG71ZxwonuynDZnRzI=;
 b=cSL67UlMYqkmiBVlryJo/wJWDbFlQoLUjqTGdaGxLarxXOMviz6pA9MaMPEyosDfGrQZufS/BTOq1neisPfqS/xGMxAzatqj6hBFPBgpEr8Zq7PGGdFf5CCPp9gPV18r+uKNZ1e2ALXkWoJC8HV2YBJHz22n5SpqytDn1odirfxCheDzMm63WUzhIlWgo1EnAKeHaLVxbkCubTu0p5lVBrsLZ+v2TECXmsPAcjCVqhdhjSCbpio0BYbZySqFZCkXXhthUEOmIiAcCNTTJ/nrHB+J4mjlhSTdteXw+Mquj2goU+LgmeoOWahDfC6/VCB8fNbmMQe6ziroQDuxEQ6ZGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzCegkgsUoPRrYtrEAXUb2IG8QG71ZxwonuynDZnRzI=;
 b=TdulztgRvfFbOkzos7x/4+ZsdpTm8DFPUIKSnraoTPo166gDETENB/lOfMITEaARUjU0H1QzOGcI1/Rzfd/xTwjBf5tcqY70qtM+f47w6FfzbCHH1C5oYSQmkYvvFetRR8ch9yl+iM/0/nn0RI49wkbsCifQJCVR76jfPpi3x9mb/YIDhvQ4rVzhKa6bfFe0mKEQ7Kfb0lZ3jeGA7/eVi129E4MQgPb0IGcSomOeFOPH4cR5H69wkmN29hW8mdSr+0ZJClygCLLb4K1QSTKTnXPsAdhvQlGRDZOTplc+9OjNafkzDQ19MDIh7g1W0hUn+FRvgtDQOAbtWkw/RbwmLw==
Received: from AM5PR0201CA0013.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::23) by AM8PR10MB4628.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:362::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 15:17:48 +0000
Received: from VE1EUR01FT036.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:203:3d:cafe::cf) by AM5PR0201CA0013.outlook.office365.com
 (2603:10a6:203:3d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 15:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 VE1EUR01FT036.mail.protection.outlook.com (10.152.3.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 15:17:47 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Dec 2021 16:17:45 +0100
Received: from [167.87.72.12] (167.87.72.12) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 16:17:45 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] Make read-only rootfs a inc
 file
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20211217150510.1351713-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <bd82abd0-0306-fec3-e143-efd0f4f1ebbe@siemens.com>
Date: Fri, 17 Dec 2021 16:17:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211217150510.1351713-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.12]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f658308d-d89e-4e90-cdde-08d9c1706234
X-MS-TrafficTypeDiagnostic: AM8PR10MB4628:EE_
X-Microsoft-Antispam-PRVS: 
	<AM8PR10MB4628FE3462AADDCB653E889895789@AM8PR10MB4628.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2wJKQXv4K3aLNTfuXWlOXim0EEcBETFHt/8d2VMREy5m9A0i4wU6CgUTiHHbbbYlH6gwU+fz7EeFnKncyEArGRd57Nt2sK4lGGPgKwapuF4decYHHyTMciBCfTcB1H8mg0vhdn7rAyJBQihqvu5Vu7jLg2uCADf3MasaKtEHfq2aOm+oetSHqJkM93+IxzVknjX62Kr9nDRdFn6zN7GHEXmnbNBz7ECGlZlWT8zWYjX7TZbmnikOA6/dFIqPzZnzG+PlKeVSYBOhL2gVGyQDGrZvCoBnNSgT/1uDTsTo1JEgZspK9Gx8cp2dpBrxWo12H75qBoZBSdL09cXtH2e7ekZiDb3cTTWdPEzKAZSiZqo3gVhuBVKu3oBYsHFJiffIMzrFjI8VKnv8Ag3SvAnw6la0T54e3bIgK8HWX8pKiZJwrfOPJ8z9HNV9ytP7jXtuXGqSB7/A+ZeBJ/312n3YSeQeTgOrHC+4e/KnfveCITmlgKM+uzWdkOmbxOahpXvT6faIQyspmAqqGPyYbUQ4Gog2CLq6YWmus17tBdAg/DOUU6fwDTX/tNA5ACR3i9LbJWeb7LHHV2El1QonLZQzXhikU5HjrCbMLV4psbP2Dy5LxAzD6xBgQxn4MJHJe4+J8RzV9NOSIB+GuQULkiciMxcDTUDjzSLBhMkoxibQ1vYPqHcCKhdoitqkAvG9A+kFZEAukMpS5dbT7I5/SgOPofKYrgphRLGwHX9eLq3h3IOoIVCJ32lfRFWV0qcdb9Qg26qnFpRZb9bnZJhWPiAGmfdgPlFuRIHONpL97j29LPNbePYQdh2o2tTcWYsHJOcXtnwggvtKy31+qKzBlmlFJQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(16526019)(7596003)(5660300002)(7636003)(186003)(110136005)(82960400001)(16576012)(70586007)(70206006)(31686004)(44832011)(8676002)(6706004)(36756003)(956004)(2616005)(31696002)(53546011)(26005)(47076005)(2906002)(356005)(86362001)(336012)(83380400001)(498600001)(36860700001)(8936002)(40460700001)(82310400004)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 15:17:47.7136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f658308d-d89e-4e90-cdde-08d9c1706234
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT036.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4628
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Dec 2021 15:17:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7187

On 17.12.21 16:05, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows downstream recipes to include the kas option
> and use the include as base without recreating some parts
> of the recipes.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  kas/opt/ebg-secure-boot-snakeoil.yml                  |  4 ++--
>  recipes-core/images/cip-core-image.bb                 |  3 ++-
>  .../{cip-core-image-read-only.bb => read-only.inc}    | 11 ++++++++++-
>  .../initramfs-verity-hook_0.1.bb                      |  2 +-
>  start-qemu.sh                                         |  3 ---
>  5 files changed, 15 insertions(+), 8 deletions(-)
>  rename recipes-core/images/{cip-core-image-read-only.bb => read-only.inc} (78%)
> 
> diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
> index 1cfbacc..9f3eae9 100644
> --- a/kas/opt/ebg-secure-boot-snakeoil.yml
> +++ b/kas/opt/ebg-secure-boot-snakeoil.yml
> @@ -14,16 +14,16 @@ header:
>    includes:
>     - kas/opt/ebg-secure-boot-base.yml
>  
> -target: cip-core-image-read-only
>  
>  local_conf_header:
> +  image-options: |
> +    CIP_IMAGE_OPTIONS_append = " read-only.inc"
>    swupdate: |
>      IMAGE_INSTALL_append = " swupdate"
>      IMAGE_INSTALL_append = " swupdate-handler-roundrobin"
>  
>    verity-img: |
>      SECURE_IMAGE_FSTYPE = "squashfs"
> -    VERITY_IMAGE_RECIPE = "cip-core-image-read-only"
>      IMAGE_TYPE = "secure-swupdate-img"
>      WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
>  
> diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
> index 2cecde3..9bf21ff 100644
> --- a/recipes-core/images/cip-core-image.bb
> +++ b/recipes-core/images/cip-core-image.bb
> @@ -18,4 +18,5 @@ IMAGE_INSTALL += "customizations"
>  
>  # for swupdate
>  SWU_DESCRIPTION ??= "swupdate"
> -include ${SWU_DESCRIPTION}.inc
> +CIP_IMAGE_OPTIONS ?= "${SWU_DESCRIPTION}.inc"
> +include ${CIP_IMAGE_OPTIONS}
> diff --git a/recipes-core/images/cip-core-image-read-only.bb b/recipes-core/images/read-only.inc
> similarity index 78%
> rename from recipes-core/images/cip-core-image-read-only.bb
> rename to recipes-core/images/read-only.inc
> index 79cd6bf..604caa0 100644
> --- a/recipes-core/images/cip-core-image-read-only.bb
> +++ b/recipes-core/images/read-only.inc
> @@ -1,4 +1,13 @@
> -require cip-core-image.bb
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2021
> +#
> +# Authors:
> +#  Quirin Gylstorff <Quriin.Gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  
>  SQUASHFS_EXCLUDE_DIRS += "home var"
>  
> diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
> index a7fbf5a..f0d2d68 100644
> --- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
> @@ -24,7 +24,7 @@ TEMPLATE_VARS += "VERITY_BEHAVIOR_ON_CORRUPTION"
>  
>  DEBIAN_DEPENDS = "initramfs-tools, cryptsetup"
>  
> -VERITY_IMAGE_RECIPE ?= "cip-core-image-read-only"
> +VERITY_IMAGE_RECIPE ?= "cip-core-image"
>  
>  VERITY_ENV_FILE = "${DEPLOY_DIR_IMAGE}/${VERITY_IMAGE_RECIPE}-${DISTRO}-${MACHINE}.verity.env"
>  
> diff --git a/start-qemu.sh b/start-qemu.sh
> index 4ab3861..24df490 100755
> --- a/start-qemu.sh
> +++ b/start-qemu.sh
> @@ -45,9 +45,6 @@ if [ -z "${TARGET_IMAGE}" ];then
>  	if grep -s -q "IMAGE_SECURITY: true" .config.yaml; then
>  		TARGET_IMAGE="cip-core-image-security"
>  	fi
> -	if [ -n "${SECURE_BOOT}" ]; then
> -		TARGET_IMAGE="cip-core-image-read-only"
> -	fi
>  fi
>  
>  case "$1" in
> 

Thanks, taken to next in favor of v1.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

