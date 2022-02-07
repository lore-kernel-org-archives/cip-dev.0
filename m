Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D4AC433EF
	for <webhook@archiver.kernel.org>; Mon,  7 Feb 2022 09:23:08 +0000 (UTC)
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (EUR03-VE1-obe.outbound.protection.outlook.com [40.107.5.64])
 by mx.groups.io with SMTP id smtpd.web08.20022.1644225786690664625
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Feb 2022 01:23:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=awhunwRK;
 spf=pass (domain: siemens.com, ip: 40.107.5.64,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQvFn8JUhU9rPVf+xskkjVCxg0ZZ0UgYGBz6HD6WRrK0fLbBaD7rz1WNbvOBhuTTD/cN4WlGabvSFtCgRwrtmgvAq8ImoaPOtXTtWsVnlqWWxZxm0MKDTmSDEAS6WvQUZDPROPYqQMPQrgoP4mj1WdYSKMsdJF8s54uM2okm4gw38uxvV1rKy+rWNdfy+Hds6yXADWV4ZxwJjkAs0HBzCBiUVTEq2VfF0Z48NqrVBvXhG+nLEHxLzr/SQ7+8Dq7CNIIGBeX3U1BNfURbxCDgOVHHi5iDaLz6vehPRx+nZsInHG9a0yD15JvjpgXdnJIIql+olkmmTPPsAr47CnUqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoQKlr464rzWQJafLtNY0BcFy+vruL5tK9d9/vhrm2s=;
 b=W5iV1JBa9M5s+76tUJH+HdQKcoS/qVx3i1ni3B0LlOGFsqTfHMJ6Pf7QhhFCRWEdG0VtqsvH3A9MO1MeBr1qEYQEKkSJwWeRWgf0FygVLq8q9+8VUli6e+Vnr2CPIYIf1GH8kkbAFpAaMec6bvQFnWaV9kK4e01xEV2p6sBo9U/Yvy9TCA5iGkInRE8+O2VsztJ7wevtsV7UyEiBhd27+5lf7PSkm+khRwnagzRnYTU4lPeTzhJ4+cjWItuTm+tBaZWodCT40F+hlm9KTY9MKCp9AzXN6s4IO80RnmceUHAlZiZI4xHFu7JN6QzBSSmwTEDk6jDrj7+5azqWh0KCrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoQKlr464rzWQJafLtNY0BcFy+vruL5tK9d9/vhrm2s=;
 b=awhunwRKCquMhBOlN34dHyxFs3Khk2JvHNVki8/tuAMBW+B57IpJ67H13TtRiXxlWN24hit5F+O65C7fn8ytGnrITosBBEAJp/narmqYIX5qLF4UFlTY4JImV19S+fBtTGRJPjyvbTD9uvH4wqkznKOkXzjc7Bcz0iSRIBmfmhXOx3i5lV5hW4A6Tu5qelTtSi44p4UeFb9zH1O8TXalYdyd2lRb/pUCRH+vrX9h4t+Hv6h+bjk7NknypcnGxw0Y6lkAicfDZdqD99c7Sdmk6vPSJn7/fiki0n/V+lTsyoDlcJkSbZb+MhKZiU+ULC8Oaz5mMogyLquRkofFokwq0g==
Received: from AM5P194CA0015.EURP194.PROD.OUTLOOK.COM (2603:10a6:203:8f::25)
 by AM9PR10MB4449.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:269::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 09:23:02 +0000
Received: from VE1EUR01FT030.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:203:8f:cafe::c1) by AM5P194CA0015.outlook.office365.com
 (2603:10a6:203:8f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Mon, 7 Feb 2022 09:23:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 VE1EUR01FT030.mail.protection.outlook.com (10.152.2.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 09:23:01 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 7 Feb 2022 10:23:01 +0100
Received: from [167.87.32.62] (167.87.32.62) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Feb
 2022 10:23:00 +0100
Message-ID: <04b70079-b02d-b81e-5598-1c874702f813@siemens.com>
Date: Mon, 7 Feb 2022 10:22:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate: Remove usb.service
Content-Language: en-US
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220207091752.190490-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220207091752.190490-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.32.62]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47bd2bd8-f9c2-4c78-a6b4-08d9ea1b7065
X-MS-TrafficTypeDiagnostic: AM9PR10MB4449:EE_
X-Microsoft-Antispam-PRVS: 
	<AM9PR10MB444973847662B2DF3350E9B8952C9@AM9PR10MB4449.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7vrQHAvsEPJQL/+WxeTRj5rSZhKdc8XYHASLJxUo5IlziPxsIgzE/W9/YxmBahlpo2iij0bHBW+yjZfTn0/G6jnBEfJSaNZPJ13miiGduGbPvVO16aITyymrzyf0ZOqRUfiP2XI3AWH1GeFjdPBhy/wLnjuPe32eV6DeULkEhxdQX43DNEDjWwd/eYW8k9JiNoX87gUo2ZpuWPjbz2HsKAnV2VratkK1XfvPjTSaqouPz14bCCRy2N9SqwmLyRwR42jHpIJzHLNuxqjsEs4461A78Clmj0Ae1GmheG+BvJBYq25rFZNb1n94YCrcvxAZ75fegIXl+qh6drYfxAus9q/WqayoVeh1XC2mQseEfPHEvb308iKMk1hO19Yca/SFKZTOzLAMPMy/CZ3cDBKiURTzbTcvXrC/cju17M3LTkBf1TJL/ERhVSd5E8lfB2CfDqNJ72BWGBPnETHYW/vjLNRJ55O4RXgTq3Oiv3V3Ni7giqNSH6y3xO+tqQ1ESsjBFSpu/EimtesimE+mUOPaq6j4lYirkcCmeLH7YCjuHpCaWtrhGkOOXM9QL+gwc6q6KqE/YpSmMy2Vd8o/J4HMTt476NFhpWJzIWbVzmSSsfNN2f7BncqpTNZE670Uu6q6gQv8Vn/ZwwcYinh6QSUHweBS0AD7yjcqowMT08tcIhTT0YSdO6LT1nB/TQK9HzZms/vOEyW28Zk6Oe6NhXfpduYbn/TliCZjyHKmHRlBP61+yAdPvNvp8SnLD8gbrpzXYobJkpZg1EOQSiZ9XFHQww==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(31696002)(8936002)(70206006)(70586007)(44832011)(8676002)(81166007)(36756003)(5660300002)(83380400001)(53546011)(31686004)(336012)(356005)(2616005)(26005)(40460700003)(110136005)(47076005)(6706004)(36860700001)(86362001)(16526019)(2906002)(30864003)(82960400001)(508600001)(82310400004)(186003)(316002)(956004)(19627235002)(16576012)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 09:23:01.9737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 47bd2bd8-f9c2-4c78-a6b4-08d9ea1b7065
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT030.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4449
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Feb 2022 09:23:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7578

On 07.02.22 10:17, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Upstream adds an udev-rules and systemd service to install a swu from
> a plug-in USB stick.
> 
> If the signing of the SWUpdate binary is deactivated
> (current default in isar-cip-core) this service allows the installation
> of a abitrary SWUpdate binary from a plug-in USB stick.
> 
> Remove the installation and the files from the debian folder to
> deactivate the possibility to install from USB.
> 
> Reported-by: Lisicki, Raphael <raphael.lisicki@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  ...onfig-Make-image-encryption-optional.patch |  2 +-
>  .../0002-debian-rules-Add-CONFIG_MTD.patch    |  2 +-
>  ...es-Add-option-to-disable-fs-creation.patch |  2 +-
>  ...ules-Add-option-to-disable-webserver.patch |  2 +-
>  ...Make-CONFIG_HW_COMPATIBILTY-optional.patch |  2 +-
>  ...ules-Add-Embedded-Lua-handler-option.patch |  2 +-
>  ...prepare-build-for-isar-debian-buster.patch |  2 +-
>  ...-SWUpdate-USB-service-and-Udev-rules.patch | 57 +++++++++++++++++++
>  .../swupdate/swupdate_2021.11-1+debian-gbp.bb |  3 +-
>  9 files changed, 66 insertions(+), 8 deletions(-)
>  create mode 100644 recipes-core/swupdate/files/0008-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
> 
> diff --git a/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch b/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch
> index c07b103..8b186e0 100644
> --- a/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch
> +++ b/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch
> @@ -1,7 +1,7 @@
>  From 20bb45563fe8f3ec95ef22d715d1add014156543 Mon Sep 17 00:00:00 2001
>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  Date: Wed, 29 Sep 2021 15:28:21 +0200
> -Subject: [PATCH 1/7] debian/config: Make image encryption optional
> +Subject: [PATCH 1/8] debian/config: Make image encryption optional
>  
>  This can be use to ease the setup with SWUpdate.
>  
> diff --git a/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch b/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
> index 8ebd09e..eb5067d 100644
> --- a/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
> +++ b/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
> @@ -1,7 +1,7 @@
>  From 1d52fe25e72f9e33525bca7efa5efe901cb32c65 Mon Sep 17 00:00:00 2001
>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  Date: Wed, 29 Sep 2021 11:29:57 +0200
> -Subject: [PATCH 2/7] debian/rules: Add CONFIG_MTD
> +Subject: [PATCH 2/8] debian/rules: Add CONFIG_MTD
>  
>  if pkg.swupdate.bpo is set CONFIG_MTD is disable but not enabled.
>  
> diff --git a/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch b/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch
> index 876e164..3671709 100644
> --- a/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch
> +++ b/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch
> @@ -1,7 +1,7 @@
>  From 8b6f01b6126933723963497d0db0c256e5251c5b Mon Sep 17 00:00:00 2001
>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  Date: Mon, 4 Oct 2021 17:15:56 +0200
> -Subject: [PATCH 3/7] debian/rules: Add option to disable fs creation
> +Subject: [PATCH 3/8] debian/rules: Add option to disable fs creation
>  
>  Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  ---
> diff --git a/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch b/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch
> index 66e48e6..8fbb722 100644
> --- a/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch
> +++ b/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch
> @@ -1,7 +1,7 @@
>  From c1f46ecb2ac3aed3a711dec767321afa92b600d8 Mon Sep 17 00:00:00 2001
>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  Date: Mon, 4 Oct 2021 17:27:11 +0200
> -Subject: [PATCH 4/7] debian/rules: Add option to disable webserver
> +Subject: [PATCH 4/8] debian/rules: Add option to disable webserver
>  
>  Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  ---
> diff --git a/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch b/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
> index 4cca3bf..96443f2 100644
> --- a/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
> +++ b/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
> @@ -1,7 +1,7 @@
>  From ccc6f5d04aba0f1270f7d6b6de298b2084ad3bfd Mon Sep 17 00:00:00 2001
>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  Date: Tue, 5 Oct 2021 10:56:25 +0200
> -Subject: [PATCH 5/7] debian: Make CONFIG_HW_COMPATIBILTY optional
> +Subject: [PATCH 5/8] debian: Make CONFIG_HW_COMPATIBILTY optional
>  
>  Add option for qemu.
>  
> diff --git a/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch b/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch
> index 447f6ad..324f079 100644
> --- a/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch
> +++ b/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch
> @@ -1,7 +1,7 @@
>  From 7107052e6aa1a35a2900070797ac013d49814f0b Mon Sep 17 00:00:00 2001
>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  Date: Wed, 29 Sep 2021 11:32:41 +0200
> -Subject: [PATCH 6/7] debian/rules: Add Embedded Lua handler option
> +Subject: [PATCH 6/8] debian/rules: Add Embedded Lua handler option
>  
>  Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  ---
> diff --git a/recipes-core/swupdate/files/0007-debian-prepare-build-for-isar-debian-buster.patch b/recipes-core/swupdate/files/0007-debian-prepare-build-for-isar-debian-buster.patch
> index 3ff4ca9..0b08f25 100644
> --- a/recipes-core/swupdate/files/0007-debian-prepare-build-for-isar-debian-buster.patch
> +++ b/recipes-core/swupdate/files/0007-debian-prepare-build-for-isar-debian-buster.patch
> @@ -1,7 +1,7 @@
>  From 123190b2aa72818186ba12a04d793ff7d4244828 Mon Sep 17 00:00:00 2001
>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  Date: Wed, 29 Sep 2021 16:17:03 +0200
> -Subject: [PATCH 7/7] debian: prepare build for isar debian buster
> +Subject: [PATCH 7/8] debian: prepare build for isar debian buster
>  
>  Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  ---
> diff --git a/recipes-core/swupdate/files/0008-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch b/recipes-core/swupdate/files/0008-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
> new file mode 100644
> index 0000000..3cce24b
> --- /dev/null
> +++ b/recipes-core/swupdate/files/0008-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
> @@ -0,0 +1,57 @@
> +From 93b9a179119394395c72e62e59a73d29e9bba735 Mon Sep 17 00:00:00 2001
> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +Date: Mon, 7 Feb 2022 09:28:39 +0100
> +Subject: [PATCH 8/8] debian: Remove SWUpdate USB service and Udev rules
> +
> +The current implementation will install an abitrary SWUpdate binary
> +from a plug-in USB stick. This is a major security risk for devices
> +using the SWUpdate package from Debian.
> +
> +Remove the installation and the files from the debian folder.
> +
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +---
> + debian/rules                          | 1 -
> + debian/swupdate.swupdate-usb@.service | 8 --------
> + debian/swupdate.udev                  | 2 --
> + 3 files changed, 11 deletions(-)
> + delete mode 100644 debian/swupdate.swupdate-usb@.service
> + delete mode 100644 debian/swupdate.udev
> +
> +diff --git a/debian/rules b/debian/rules
> +index e1c4a921..84ed55d4 100755
> +--- a/debian/rules
> ++++ b/debian/rules
> +@@ -103,7 +103,6 @@ override_dh_auto_install:
> + override_dh_installsystemd:
> + 	dh_installsystemd --no-start
> + 	dh_installsystemd --name=swupdate-progress
> +-	dh_installsystemd --no-start --name=swupdate-usb@
> + 
> + ifeq (,$(filter pkg.swupdate.bpo,$(DEB_BUILD_PROFILES)))
> + override_dh_gencontrol:
> +diff --git a/debian/swupdate.swupdate-usb@.service b/debian/swupdate.swupdate-usb@.service
> +deleted file mode 100644
> +index eda9d153..00000000
> +--- a/debian/swupdate.swupdate-usb@.service
> ++++ /dev/null
> +@@ -1,8 +0,0 @@
> +-[Unit]
> +-Description=usb media swupdate service
> +-Requires=swupdate-progress.service
> +-
> +-[Service]
> +-ExecStartPre=/bin/mount /dev/%I /mnt
> +-ExecStart=/bin/sh -c "swupdate-client -v /mnt/*.swu"
> +-ExecStopPost=/bin/umount /mnt
> +diff --git a/debian/swupdate.udev b/debian/swupdate.udev
> +deleted file mode 100644
> +index b4efd0b7..00000000
> +--- a/debian/swupdate.udev
> ++++ /dev/null
> +@@ -1,2 +0,0 @@
> +-ACTION=="add", KERNEL=="sd*", SUBSYSTEM=="block", ENV{ID_BUS}=="usb", ENV{ID_FS_USAGE}=="filesystem", TAG+="systemd", ENV{SYSTEMD_WANTS}+="swupdate-usb@%k.service"
> +-
> +-- 
> +2.34.1
> +
> diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> index 48a6cc1..2995d71 100644
> --- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> +++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> @@ -21,7 +21,8 @@ SRC_URI += "file://0001-debian-config-Make-image-encryption-optional.patch \
>              file://0003-debian-rules-Add-option-to-disable-fs-creation.patch \
>              file://0004-debian-rules-Add-option-to-disable-webserver.patch \
>              file://0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch \
> -            file://0006-debian-rules-Add-Embedded-Lua-handler-option.patch"
> +            file://0006-debian-rules-Add-Embedded-Lua-handler-option.patch \
> +            file://0008-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch"
>  
>  # end patching for dm-verity based images
>  

Thanks, applied to next as quick-fix.

Wouldn't it be more useful to make this configurable (opt-in via
/etc/something on the device), possibly also in Debian?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

