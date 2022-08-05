Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17A0C00140
	for <webhook@archiver.kernel.org>; Fri,  5 Aug 2022 10:34:49 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.50])
 by mx.groups.io with SMTP id smtpd.web08.5350.1659695685826945235
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Aug 2022 03:34:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=shLI/wpD;
 spf=pass (domain: siemens.com, ip: 40.107.20.50,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjVGCGz4D3NWtbK2//6T3Es+1i3nVexmatG4gX1GJ94MiDBqXPWDNffQGrW2C1oBEtzvi6D73qHiSdKXUOQFWbmpwlyP481Sd9VClY5oB8b0qVuny7dYMaTAnXxHerks1IhlGFH3EpFpvJgNyye/vwGdHx/7WA3xtENql4IRwCbDIjf23b5JKrkXnnCmbPTf6V2UlBUC6rFZgelwzH9jWwnK7PAF1OGcvspoHdaLVx6DjMDG6xamcdaiaaiQLULYft5hDQqsfLOvkun8wiNYsO+B9ZZ/VKHsM+8f19iR6K+Lvx3KT2oihatcmwDA6Eqq1HTatEMTdRABcXYRca7EEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWIgF5EDBWxCYdyw0tu055VBBfGL7e3JaY9k4ZrljoY=;
 b=PnStc1Mnfd2PWvh9DfLavNf5WuXWmUP4dHAadr/4dI4mqDXOeDl/lvUvbA+w6Vqv9MsarJs5lL8+NI9pZmxksyJAm15LHhPZxfbzgWzK/8CD6XWloQr5xrpOBvL3qjaMMRm2lzKhJAqdnrQdYUlaYYh4xc6FI0h8zATazIN1DQfugQ+T+HHA2wFa9ZGA7fyEWzk0U6TkUj1fGRiPk+EyfhVndJMncFatVpsofDXxLnDnNX53o5xJFxlygAxz0JulltEB63SOtpcujRDsGETUsMqMvYZ10mUHEP1sFv1bDTl//bN9CzE+ieMPpLnt8xpIqF9pBo5TEvXkDe35BLnvMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWIgF5EDBWxCYdyw0tu055VBBfGL7e3JaY9k4ZrljoY=;
 b=shLI/wpDmCaqaCyWHIvFlsJ+6P/3pihDzyhptDdvZqgUGy3uydU/fd7u+53tAjC9lPQyYhY/bhM06ZSAtbBt5LZyPZ4OHTNPljfwsJGja3LweThCx3Bhtze39RtHTd8vlPuTc1BhOqPdt3OqWBP3B7NKIprCOMJGDkUHO5wfITN3bkB3w2WsDNQ+m6TrydGvb0mrwp5EezN6WB6hfe/dic0xinn2hy0JYhquR/ARgy8f261tf1UVgCEXP3uQcDLvjv0iCVh85IW7RpnUL5U4H3ooneGWpKSzFHGaCOOyYoCOrJB8OqFcE0oGWsb9tfEzDvyLFbJflPfSewGtvShZLg==
Received: from DU2PR04CA0278.eurprd04.prod.outlook.com (2603:10a6:10:28c::13)
 by VI1PR10MB2029.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:32::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 10:34:42 +0000
Received: from DB5EUR01FT071.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:28c:cafe::c3) by DU2PR04CA0278.outlook.office365.com
 (2603:10a6:10:28c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15 via Frontend
 Transport; Fri, 5 Aug 2022 10:34:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT071.mail.protection.outlook.com (10.152.5.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 10:34:42 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Fri, 5 Aug 2022 12:34:41 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Fri, 5 Aug 2022
 12:34:41 +0200
Message-ID: <46031a90-a401-278d-92a8-464015ecc4e3@siemens.com>
Date: Fri, 5 Aug 2022 12:34:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 1/2] kas: Remove
 efibootguard.yml
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220804100409.163990-1-Quirin.Gylstorff@siemens.com>
 <20220804100409.163990-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220804100409.163990-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--14.002400-8.000000
X-TMASE-MatchedRID: Cc2Ao8tLfKA5QaOxwNGfvo9bHfxDWoibR/oM2cgUsZr/XfgEFWz6XEKJ
	5iyNYGPpBph69XjMbdmVKkReE4K0FOtq38W/Yl/coJpneC8uzLwCVvo5Hft/7k+zv2ByYSDQS1z
	wNuiBtITfUZT83lbkEB8JzarG9NM5nfoWnW72UhwFyyCJaJoibt5MntES9XX7cxMkBeI9K3dL9x
	4FCuBLUQytGucsJkSafjcdX7WMS/Ba0onndjAYYuDcAHv31uCXxrW3OZZ/rLZff79rzPd1mHqTi
	LZEbYB6WAuSz3ewb21PHvLiqwIXKCvn27+DO/kwtTOrxEGQm4Zw1ghGV72CB54CIKY/Hg3AtOt1
	ofVlaoLUHQeTVDUrItRnEQCUU+jzjoczmuoPCq2o6svCmOJpQqkuanPs4fkOJkmv3oly7Nbeooh
	mB0N1shk7C5uDfrUQ
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.002400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 E2CEECB17F375FCB8BD136164A1C4EB63AE36238D6FD9FE34B5573BC8A2A1F882000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d41a7e65-6307-4e75-3c0e-08da76ce1b6c
X-MS-TrafficTypeDiagnostic: VI1PR10MB2029:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	x2EvtJs8OJNA09kiTt8oqo8v5dwkgon8QF89LtnXL9+Ss8UrQ2jXEYoEt6HTMDG1bl+waGuNJ2Eo7SMq7NzYT+0peTrtQ7nnh9dyW6QEaj7C2I8zyY66aeRsc5vo91kPa4sr7pP6qX/Va4F+1Z5LpTpg3siOFrpdfPPx4i7lKvRwR1mo7UrCTqDt3kVxkN1ekYLKXvkcnEVLayuEKM5WbqfA+9i6ntzIFWRN/tDJWVu7EDT22F/BiXC58wD1aelpAZGFbGUVNj6T9rXVRDPRg6OQkCN7h0whKjC6T39oMrdiVzEzdjUoj6EmERolLIpCFjCy8hvv5C0KAYFPFHVfoPY6i9UuJ1ltkcyfiJR7i7LuBz/0R9cHlgJl9pwpWUo5W9GGpW7kWQwWtgngruA+aau1mG4gL/NvqPY+vxSU50lv/JEA7hSv0MS1iLWYEJWSsqefXD/9tpmiub3+poAQeD+es7YYESuwHWR5rjM2MjNT6ZD0kMp4nkXlO9SPnxjF9cpyGK/0vT6r5xiE+KHcK/kdMdXTHtWTi7vxlcx7MRjOfHpFchL2tC82nDZdZ5ACxX0xhEn4pH5ndqxXT6Yb/pwsnZjM0GeBzWdMGDOfQLPB+Zq8+XennfzSIssLDlUzpPIMkOBY+XH9YM02uKBGo3zk7jCSqgMIDV2b+TSCZjE8d5IfEu5YXtGW3Gc4qMT5EEfOSLxBCj+Wt5swLq4Ed+u4mgyMdxLXRUxwPIRMLkb2bhPWRA+inQ7hIzfca+YYJRLO+5aJJ4UqR1vB0t2MhVlMsTZx6p1qNEwORP8E3NoR8WIPa8MmjrNOqcd2M7ruO/+CcsZT5GmRgWkjQxeKxDXvRLckA04NYW6jauFaThO9SGqu4dXF5YREMYrjcEteiOFa2K7QdFAWKQFK/e0SDw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(136003)(396003)(40470700004)(36840700001)(46966006)(26005)(36756003)(31696002)(31686004)(82960400001)(186003)(82310400005)(86362001)(82740400003)(16526019)(70206006)(956004)(2616005)(110136005)(6706004)(356005)(8676002)(316002)(70586007)(16576012)(53546011)(478600001)(81166007)(41300700001)(44832011)(2906002)(47076005)(336012)(40480700001)(83380400001)(8936002)(36860700001)(5660300002)(40460700003)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 10:34:42.0983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d41a7e65-6307-4e75-3c0e-08da76ce1b6c
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT071.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2029
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Aug 2022 10:34:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9134

On 04.08.22 12:04, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> A build with only the option `kas/efibootguard.yml` will not succeed.
> Move the content to a include in the image directory and the adapt the kas
> files.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  kas/opt/ebg-secure-boot-snakeoil.yml |  9 +++----
>  kas/opt/ebg-swu.yml                  |  7 ++---
>  kas/opt/efibootguard.yml             | 39 ----------------------------
>  recipes-core/images/efibootguard.inc | 28 ++++++++++++++++++++
>  4 files changed, 36 insertions(+), 47 deletions(-)
>  delete mode 100644 kas/opt/efibootguard.yml
>  create mode 100644 recipes-core/images/efibootguard.inc
> 
> diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
> index 2822cef..0791ea3 100644
> --- a/kas/opt/ebg-secure-boot-snakeoil.yml
> +++ b/kas/opt/ebg-secure-boot-snakeoil.yml
> @@ -11,16 +11,15 @@
>  
>  header:
>    version: 10
> -  includes:
> -   - kas/opt/efibootguard.yml
>  
>  local_conf_header:
> -  image-options-swupdate: |
> -    CIP_IMAGE_OPTIONS_append = " swupdate.inc"
> +  ebg_secureboot_bootloader: |
> +    SWUPDATE_BOOTLOADER = "efibootguard"
>  
> -  swupdate: |
> +  image-options-swupdate: |
>      IMAGE_INSTALL_append = " swupdate"
>      IMAGE_INSTALL_append = " swupdate-handler-roundrobin"
> +    CIP_IMAGE_OPTIONS_append = " swupdate.inc efibootguard.inc"
>  
>    secure-boot-image: |
>      IMAGE_CLASSES += "verity"
> diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
> index 5e4e771..9c50358 100644
> --- a/kas/opt/ebg-swu.yml
> +++ b/kas/opt/ebg-swu.yml
> @@ -12,12 +12,13 @@
>  header:
>    version: 10
>    includes:
> -   - kas/opt/efibootguard.yml
>     - kas/opt/swupdate.yml
>  
>  local_conf_header:
> +  ebg_swu_bootloader: |
> +    SWUPDATE_BOOTLOADER = "efibootguard"
> +  ebg_swu_image_options: |
> +    CIP_IMAGE_OPTIONS_append = " efibootguard.inc image-uuid.inc"
>    initramfs: |
>      INITRAMFS_INSTALL_append = " initramfs-abrootfs-hook"
>  
> -  image-option-uuid: |
> -    CIP_IMAGE_OPTIONS_append = " image-uuid.inc"
> diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
> deleted file mode 100644
> index cee9c78..0000000
> --- a/kas/opt/efibootguard.yml
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Siemens AG, 2020
> -#
> -# Authors:
> -#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> -#
> -# SPDX-License-Identifier: MIT
> -#
> -# This kas file adds efibootguard as the bootloader to the image
> -
> -header:
> -  version: 10
> -
> -local_conf_header:
> -  efibootguard: |
> -    IMAGE_INSTALL_append = " efibootguard"
> -
> -  efibootguard-swupdate: |
> -    SWUPDATE_BOOTLOADER = "efibootguard"
> -
> -  efibootguard-wic: |
> -    WIC_IMAGER_INSTALL_append = " efibootguard"
> -    WDOG_TIMEOUT ?= "60"
> -    WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE DTB_FILES"
> -    IMAGE_FSTYPES ?= "wic"
> -    WKS_FILE ?= "${MACHINE}-efibootguard.wks.in"
> -
> -  firmware-binaries: |
> -    # Add ovmf binaries for qemu
> -    IMAGER_BUILD_DEPS_append_qemu-amd64 += "ovmf-binaries"
> -    # not needed for Debian 11 and later
> -    OVERRIDES_append_qemu-amd64 = ":${BASE_DISTRO_CODENAME}"
> -    DISTRO_APT_SOURCES_append_qemu-amd64_buster = " conf/distro/debian-buster-backports.list"
> -    DISTRO_APT_PREFERENCES_append_qemu-amd64_buster = " conf/distro/preferences.ovmf-snakeoil.conf"
> -    # Add U-Boot for qemu
> -    IMAGER_BUILD_DEPS_append_qemu-arm64 += "u-boot-qemu-arm64"
> -    IMAGER_BUILD_DEPS_append_qemu-arm += "u-boot-qemu-arm"
> diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
> new file mode 100644
> index 0000000..fc3879f
> --- /dev/null
> +++ b/recipes-core/images/efibootguard.inc
> @@ -0,0 +1,28 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2020
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +IMAGE_INSTALL_append = " efibootguard"
> +
> +WIC_IMAGER_INSTALL_append = " efibootguard"
> +WDOG_TIMEOUT ?= "60"
> +WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE DTB_FILES"
> +WKS_FILE = "${MACHINE}-efibootguard.wks.in"
> +IMAGE_FSTYPES += "wic"
> +
> +# Add ovmf binaries for qemu
> +IMAGER_BUILD_DEPS_append_qemu-amd64 += "ovmf-binaries"
> +# not needed for Debian 11 and later
> +OVERRIDES_append_qemu-amd64 = ":${BASE_DISTRO_CODENAME}"
> +DISTRO_APT_SOURCES_append_qemu-amd64_buster = " conf/distro/debian-buster-backports.list"
> +DISTRO_APT_PREFERENCES_append_qemu-amd64_buster = " conf/distro/preferences.ovmf-snakeoil.conf"
> +# Add U-Boot for qemu
> +IMAGER_BUILD_DEPS_append_qemu-arm64 += "u-boot-qemu-arm64"
> +IMAGER_BUILD_DEPS_append_qemu-arm += "u-boot-qemu-arm"

Still breaks qemu-arm64 secure boot config, probably the U-Boot build
for that. Try to boot the image and you will see the error.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

