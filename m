Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC63C433F5
	for <webhook@archiver.kernel.org>; Tue, 15 Feb 2022 09:37:17 +0000 (UTC)
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (EUR03-AM5-obe.outbound.protection.outlook.com [40.107.3.89])
 by mx.groups.io with SMTP id smtpd.web09.7611.1644917834966923596
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Feb 2022 01:37:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tGcNpPDg;
 spf=pass (domain: siemens.com, ip: 40.107.3.89,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEzuQrMS/zUv9gE7UndxIppYf/YZcqVI9MdzW32J/+kQT2Wh5oK/xsaZ9wgjY9S+Xq42TRprasU/MqSftF70trnOqX545OyBv619FJ+6TRvvLQ0Ns9bnJUSpaEgW9VQIEue+W/vZHcmXdTGXhhd9O7Bm2AdAH5FZsGMx6bmRmTHg5ryO86xEyNDFvixB/7/38D8ckdNhP//eqkyBFVJfM9YawT3ykRsg0lmZvjIZlFiCl4oLxsZPWkP8LWepPasqd13X/mmDCxRXGM4rVOyW5PFcIFiBDmhl3cdK8USO77T/Ty1VeHr+is6rs2ywrT87ZKYtZrDoZ9mk//45jSGoTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/b7vYbPZ2krYY6orrl7XnE0BzNvjk9dSx9dJ1ChJKU=;
 b=cVfNfRQGfW55k2CrikTnH9eJibymdiEJf6VJTSmAgl/0c7TRypr6+WNaW+dd0+SLx9W05xhwLFC3btJti6e22JJVxLnrnWqTLin80s6o8Ej7T47TcsRivZlGIO9b9HM/hGUf7Jdx+VGxY87BMOgfYyKaKG+fuX8hgBbTjvQbXDlkLmLkkagu3tB2rd3U78zZZABLwa8gn0PLPZekNKutshYF38oA2J30BUCQPh5SH2MpcZOOjCh4ZaXZ0KEoN87OQ0/cy8VRLLRqjFepRxLpglrGeluKCktlP5HMIaisKjxFAdeQtPH22f2e8qmdRgKuKEgohysLwRXr5kswjXlVBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/b7vYbPZ2krYY6orrl7XnE0BzNvjk9dSx9dJ1ChJKU=;
 b=tGcNpPDg5b7kCE+QIXGL6ZQdOMq7kWUEMhqVQ/q59FASQ12OhUDX8gGB0TRWVAAFTRjMK1fUijvv+0Uc0Tg+d7gl9GpsBX36FRIv3mWamlCwNFCP5ycweT062T88ixvNpNnx7Cbe3GJrcb8UujudI5yRUJKMAU8Q6v3/o6gEoNeNHL2J4dmGZ9/LUAA9D/dkHsqdrpT0gX7PoPCwcHSU7XGsST8To3F4SeoTE/F5p+ZFN3GZWbL8WwrjGMzG7yJro2Ws55lBkiq/39M+TbJYS/lYY+/BKWKymrhESLJiiYCfqgnTUkcwUz3s+28a4J3wceqJDVFkRIGIlKmdvuCzEg==
Received: from AS9PR05CA0008.eurprd05.prod.outlook.com (2603:10a6:20b:488::28)
 by DB9PR10MB4538.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:222::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 09:37:11 +0000
Received: from VE1EUR01FT020.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:488:cafe::94) by AS9PR05CA0008.outlook.office365.com
 (2603:10a6:20b:488::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19 via Frontend
 Transport; Tue, 15 Feb 2022 09:37:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 VE1EUR01FT020.mail.protection.outlook.com (10.152.2.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 09:37:10 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 15 Feb 2022 10:37:09 +0100
Received: from [167.87.0.44] (167.87.0.44) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 10:37:09 +0100
Message-ID: <2a427486-b758-c8a8-d7b2-7c53d82255e0@siemens.com>
Date: Tue, 15 Feb 2022 10:37:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] swupdate: Add option to
 disable CONFIG_HASH_VERIFY
Content-Language: en-US
To: <Quirin.Gylstorff@siemens.com>, <cip-dev@lists.cip-project.org>
References: <20220214122805.262651-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220214122805.262651-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.44]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6184c680-cbd1-4810-48d1-08d9f066bd73
X-MS-TrafficTypeDiagnostic: DB9PR10MB4538:EE_
X-Microsoft-Antispam-PRVS: 
	<DB9PR10MB45389F16E8861EE25D51FB6595349@DB9PR10MB4538.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rzoRQ45pAj2rCB4UcH+nFPgqpVgVLK7mROhkDQ+ZvQFw9xMs8fReihzDMGl/VlsKD6NJkbXjnJvAATfUA6oHK7fZM1EepgTHXn2DbY1kN09MghKHNYg/gT63tnh74yhSfir7T23jsC+uHj16Nn/FG3w1FaoyZWOdktPGjGUlzd0O6YcSqU5pQhGnJA29uVCZCxYdAlKHkPmA5/YCqdJpg/2rwew9ghX+f0tjrJCHZGyn2GpsqQNxz5NlTY7GmHkNeXAc8v1sresk9pik78UcJGwP7zW+/G1/UfgEsC5SvCOb4+nwJf9HuQ611SovyaQdlp01dom7qsWGYoXFr1Le38npp4OTKBsOi7L/wqpgy/6Kotc06896VcR99gtoreLMUFfOnsHsHJct9J429NYiIYAlEToDJrFFPXAAAEDkVeU00byYY00+fAEv+05oZhpV94S9AbttIhLnj3mfxMNi0f3KvVyLtHOIK5iMduWwmbyYNPuIWJeUA5H0DHE5gkiGwCvAXenJnrENdOK7HYAazQa7W3a0HlMieSDh3mIiesLpeQyPGGPpTmzUWgPewcFx+fCCWb1tsUjL5RWgg93C/SibBvelR9dOwKqY7Aymbd0cdePOREsTM7SWrXsaeAuaovZnWnUOR7glABUYDFK8CiLydKJN/oUEqYnsf/AoFp+2+2rt2L62EeQYPT7kPyuZ/p3JlFXLo2iQ+wIRvgmh2qM2e1Nmv/ec1COpKQZFHt8=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(6706004)(40460700003)(110136005)(508600001)(31696002)(7596003)(8936002)(8676002)(70586007)(70206006)(36860700001)(31686004)(356005)(36756003)(82960400001)(47076005)(5660300002)(7636003)(53546011)(44832011)(336012)(16526019)(30864003)(19627235002)(186003)(26005)(2616005)(82310400004)(956004)(83380400001)(316002)(16576012)(2906002)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 09:37:10.4790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6184c680-cbd1-4810-48d1-08d9f066bd73
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT020.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4538
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Feb 2022 09:37:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7608

On 14.02.22 13:28, Quirin.Gylstorff@siemens.com wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This patch activate CONFIG_HASH_VERITY to ensure the integrity of the
> swu binary. To ensure simple example builds the option can be disabled
> by with the debian build profile `pkg.swupdate.nohashverify`.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> 
> Changes V2:
>  - add missing patch description
> 
>  ...onfig-Make-image-encryption-optional.patch |  2 +-
>  .../0002-debian-rules-Add-CONFIG_MTD.patch    |  2 +-
>  ...es-Add-option-to-disable-fs-creation.patch |  2 +-
>  ...ules-Add-option-to-disable-webserver.patch |  2 +-
>  ...Make-CONFIG_HW_COMPATIBILTY-optional.patch |  2 +-
>  ...ules-Add-Embedded-Lua-handler-option.patch |  2 +-
>  ...SWUpdate-USB-service-and-Udev-rules.patch} |  8 ++---
>  ...option-to-disable-CONFIG_HASH_VERIFY.patch | 29 +++++++++++++++++++
>  ...repare-build-for-isar-debian-buster.patch} |  6 ++--
>  .../swupdate/swupdate_2021.11-1+debian-gbp.bb |  5 ++--
>  10 files changed, 45 insertions(+), 15 deletions(-)
>  rename recipes-core/swupdate/files/{0008-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch => 0007-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch} (89%)
>  create mode 100644 recipes-core/swupdate/files/0008-Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch
>  rename recipes-core/swupdate/files/{0007-debian-prepare-build-for-isar-debian-buster.patch => 0009-debian-prepare-build-for-isar-debian-buster.patch} (94%)
> 
> diff --git a/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch b/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch
> index 8b186e0..c501e42 100644
> --- a/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch
> +++ b/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch
> @@ -1,7 +1,7 @@
>  From 20bb45563fe8f3ec95ef22d715d1add014156543 Mon Sep 17 00:00:00 2001
>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  Date: Wed, 29 Sep 2021 15:28:21 +0200
> -Subject: [PATCH 1/8] debian/config: Make image encryption optional
> +Subject: [PATCH 1/9] debian/config: Make image encryption optional
>  
>  This can be use to ease the setup with SWUpdate.
>  
> diff --git a/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch b/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
> index eb5067d..50cf805 100644
> --- a/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
> +++ b/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
> @@ -1,7 +1,7 @@
>  From 1d52fe25e72f9e33525bca7efa5efe901cb32c65 Mon Sep 17 00:00:00 2001
>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  Date: Wed, 29 Sep 2021 11:29:57 +0200
> -Subject: [PATCH 2/8] debian/rules: Add CONFIG_MTD
> +Subject: [PATCH 2/9] debian/rules: Add CONFIG_MTD
>  
>  if pkg.swupdate.bpo is set CONFIG_MTD is disable but not enabled.
>  
> diff --git a/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch b/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch
> index 3671709..c5815cb 100644
> --- a/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch
> +++ b/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch
> @@ -1,7 +1,7 @@
>  From 8b6f01b6126933723963497d0db0c256e5251c5b Mon Sep 17 00:00:00 2001
>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  Date: Mon, 4 Oct 2021 17:15:56 +0200
> -Subject: [PATCH 3/8] debian/rules: Add option to disable fs creation
> +Subject: [PATCH 3/9] debian/rules: Add option to disable fs creation
>  
>  Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  ---
> diff --git a/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch b/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch
> index 8fbb722..4a9076d 100644
> --- a/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch
> +++ b/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch
> @@ -1,7 +1,7 @@
>  From c1f46ecb2ac3aed3a711dec767321afa92b600d8 Mon Sep 17 00:00:00 2001
>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  Date: Mon, 4 Oct 2021 17:27:11 +0200
> -Subject: [PATCH 4/8] debian/rules: Add option to disable webserver
> +Subject: [PATCH 4/9] debian/rules: Add option to disable webserver
>  
>  Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  ---
> diff --git a/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch b/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
> index 96443f2..87eba2c 100644
> --- a/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
> +++ b/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
> @@ -1,7 +1,7 @@
>  From ccc6f5d04aba0f1270f7d6b6de298b2084ad3bfd Mon Sep 17 00:00:00 2001
>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  Date: Tue, 5 Oct 2021 10:56:25 +0200
> -Subject: [PATCH 5/8] debian: Make CONFIG_HW_COMPATIBILTY optional
> +Subject: [PATCH 5/9] debian: Make CONFIG_HW_COMPATIBILTY optional
>  
>  Add option for qemu.
>  
> diff --git a/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch b/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch
> index 324f079..5d7543b 100644
> --- a/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch
> +++ b/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch
> @@ -1,7 +1,7 @@
>  From 7107052e6aa1a35a2900070797ac013d49814f0b Mon Sep 17 00:00:00 2001
>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  Date: Wed, 29 Sep 2021 11:32:41 +0200
> -Subject: [PATCH 6/8] debian/rules: Add Embedded Lua handler option
> +Subject: [PATCH 6/9] debian/rules: Add Embedded Lua handler option
>  
>  Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  ---
> diff --git a/recipes-core/swupdate/files/0008-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch b/recipes-core/swupdate/files/0007-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
> similarity index 89%
> rename from recipes-core/swupdate/files/0008-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
> rename to recipes-core/swupdate/files/0007-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
> index 3cce24b..2779d8b 100644
> --- a/recipes-core/swupdate/files/0008-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
> +++ b/recipes-core/swupdate/files/0007-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
> @@ -1,7 +1,7 @@
> -From 93b9a179119394395c72e62e59a73d29e9bba735 Mon Sep 17 00:00:00 2001
> +From 625db939a1dec7d1aa6fbcb01c2c4cbd699bfe7b Mon Sep 17 00:00:00 2001
>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  Date: Mon, 7 Feb 2022 09:28:39 +0100
> -Subject: [PATCH 8/8] debian: Remove SWUpdate USB service and Udev rules
> +Subject: [PATCH 7/9] debian: Remove SWUpdate USB service and Udev rules
>  
>  The current implementation will install an abitrary SWUpdate binary
>  from a plug-in USB stick. This is a major security risk for devices
> @@ -19,10 +19,10 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>   delete mode 100644 debian/swupdate.udev
>  
>  diff --git a/debian/rules b/debian/rules
> -index e1c4a921..84ed55d4 100755
> +index 12eb0ba5..76fce010 100755
>  --- a/debian/rules
>  +++ b/debian/rules
> -@@ -103,7 +103,6 @@ override_dh_auto_install:
> +@@ -101,7 +101,6 @@ override_dh_auto_install:
>   override_dh_installsystemd:
>   	dh_installsystemd --no-start
>   	dh_installsystemd --name=swupdate-progress
> diff --git a/recipes-core/swupdate/files/0008-Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch b/recipes-core/swupdate/files/0008-Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch
> new file mode 100644
> index 0000000..a7c5ee7
> --- /dev/null
> +++ b/recipes-core/swupdate/files/0008-Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch
> @@ -0,0 +1,29 @@
> +From cddd3472aad2d8e48d557705b82ffcc0c7d14a02 Mon Sep 17 00:00:00 2001
> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +Date: Mon, 14 Feb 2022 12:27:43 +0100
> +Subject: [PATCH 8/9] Add Profile option to disable CONFIG_HASH_VERIFY
> +
> +This change also enables CONFIG_HASH_VERIFY by default.
> +
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +---
> + debian/rules | 3 +++
> + 1 file changed, 3 insertions(+)
> +
> +diff --git a/debian/rules b/debian/rules
> +index 76fce010..4dc9e170 100755
> +--- a/debian/rules
> ++++ b/debian/rules
> +@@ -42,6 +42,9 @@ endif
> + ifneq (,$(filter pkg.swupdate.hwcompatibility,$(DEB_BUILD_PROFILES)))
> + 	echo CONFIG_HW_COMPATIBILITY=y                   >> configs/debian_defconfig
> + endif
> ++ifeq (,$(filter pkg.swupdate.nohashverify,$(DEB_BUILD_PROFILES)))
> ++	echo CONFIG_HASH_VERIFY=y                   >> configs/debian_defconfig
> ++endif
> + ifeq (,$(filter pkg.swupdate.nowebserver,$(DEB_BUILD_PROFILES)))
> + 	echo CONFIG_WEBSERVER=y   >> configs/debian_defconfig
> + 	echo CONFIG_MONGOOSESSL=y >> configs/debian_defconfig
> +-- 
> +2.34.1
> +
> diff --git a/recipes-core/swupdate/files/0007-debian-prepare-build-for-isar-debian-buster.patch b/recipes-core/swupdate/files/0009-debian-prepare-build-for-isar-debian-buster.patch
> similarity index 94%
> rename from recipes-core/swupdate/files/0007-debian-prepare-build-for-isar-debian-buster.patch
> rename to recipes-core/swupdate/files/0009-debian-prepare-build-for-isar-debian-buster.patch
> index 0b08f25..8afef74 100644
> --- a/recipes-core/swupdate/files/0007-debian-prepare-build-for-isar-debian-buster.patch
> +++ b/recipes-core/swupdate/files/0009-debian-prepare-build-for-isar-debian-buster.patch
> @@ -1,7 +1,7 @@
> -From 123190b2aa72818186ba12a04d793ff7d4244828 Mon Sep 17 00:00:00 2001
> +From 5dda7f815dafdfbd1b187ccc912eca38e9aee7bb Mon Sep 17 00:00:00 2001
>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  Date: Wed, 29 Sep 2021 16:17:03 +0200
> -Subject: [PATCH 7/8] debian: prepare build for isar debian buster
> +Subject: [PATCH 9/9] debian: prepare build for isar debian buster
>  
>  Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  ---
> @@ -47,7 +47,7 @@ index 192c4a2a..9318fa12 100644
>                  libebgenv-dev <pkg.swupdate.efibootguard> | efibootguard-dev <pkg.swupdate.efibootguard>,
>                  libcmocka-dev,
>  diff --git a/debian/rules b/debian/rules
> -index 12eb0ba5..e1c4a921 100755
> +index 4dc9e170..370ca3d8 100755
>  --- a/debian/rules
>  +++ b/debian/rules
>  @@ -19,13 +19,15 @@ endif
> diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> index 2995d71..699dad3 100644
> --- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> +++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> @@ -22,7 +22,8 @@ SRC_URI += "file://0001-debian-config-Make-image-encryption-optional.patch \
>              file://0004-debian-rules-Add-option-to-disable-webserver.patch \
>              file://0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch \
>              file://0006-debian-rules-Add-Embedded-Lua-handler-option.patch \
> -            file://0008-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch"
> +            file://0007-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch \
> +            file://0008-Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch"
>  
>  # end patching for dm-verity based images
>  
> @@ -38,7 +39,7 @@ SWUPDATE_BUILD_PROFILES += "cross nocheck"
>  # SWUPDATE_BUILD_PROFILES += "pkg.swupdate.embeddedlua"
>  
>  # modify for debian buster build
> -SRC_URI_append_buster = " file://0007-debian-prepare-build-for-isar-debian-buster.patch"
> +SRC_URI_append_buster = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"
>  
>  # disable documentation due to missing packages
>  SWUPDATE_BUILD_PROFILES_append = " nodoc "

Thanks, applied. I suspect you already sent the embedded patch to Debian
as well, right?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

