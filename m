Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEFBC433F5
	for <webhook@archiver.kernel.org>; Thu,  6 Jan 2022 14:01:10 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.75])
 by mx.groups.io with SMTP id smtpd.web11.8885.1641477668367166415
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jan 2022 06:01:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ipejfLuB;
 spf=pass (domain: siemens.com, ip: 40.107.20.75,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VchitR0GiSXzvs5Mu7v/8r/4tI55mGyqv5EDDJsG6omLJu0fI4uH8dv5qEQArrOnrdny0Sr7Gt09iECrn7SDGmE0+ONcyKpio+Sf6CE+NBRuX0BjSBn9O6Blps4Dep+22HUvYkco0PMaXaN5xUxHI+9YuuBmhQdXStMDqBDe40gX/L9CJuKHchWLNVWb5G5H2arHLvUS0SEQQOGNEcjMjWWi25Zu3NliXSclqSLimX8S+/aUa5x3wvvurpwO5vs0qnN9pxGkjA7P+K/fRqKr9sc4PDHrsJR8lx8zfYb+z/yGV2ZbKeOTojLtAAh6PDoz8W0r5rLPHKL01Zg6wXvRkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3I7wJsZ0IUApIlS+NO6JNpLh99Gb8aAvvw6vOoDU2M4=;
 b=SPIUfK3xISJOsjCZgXwj0Npz1XPF2zxQqpfwExULjyMiYxhcYTgLKa8cYLFwbD9V9IhWWplYvIuwQZzKANL4sLgU+6AUN2QDN54orNtHOh1pJKeyr00lbCf89qlnWuaE7/sxysvhF/rPbY3fDZpoCraEk1UARGzAC7692mAYGf4zUmpthueSIZyHmgLp2V9Xwo4/MBYRT6ZOjnFSDLs+PxeQSC8bA2UntbHjI1DaxDqkFg33JlXMwCCDTvkWwnAHOKQoRs91+sc4ltGbVYJr6DFkqvcRqOjaEzMR2/p54ydsY14MBkuq5TlIx9qf00CzroOL7ItbE535JNDVsOC1eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 194.138.21.71) smtp.rcpttodomain=miraclelinux.com
 smtp.mailfrom=siemens.com; dmarc=temperror action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3I7wJsZ0IUApIlS+NO6JNpLh99Gb8aAvvw6vOoDU2M4=;
 b=ipejfLuBUsgZUkXC/J9MIiy33r8uLkM00H+fEUEivRMB5fubgHw7q/1QqXAIMDpgsqz2uOypx687lFwYLxmPavHRuYcHB7B1rSbxZOBpUq3I2PCTF9aOatB3gqQ/fMoEtTouiyER8WmVktkB8/8PaeWUu91rr9N5CKSH2i5x2okAxlrrEVNAlNY1Lt+Nlk6Z2udzBxUEKytZtU5BtxLvtFDN3GdYqWp5ymVfDX0ymr/UPv0D2Z17HEANCfqfAUwUGu6VA+0NYcqckD+tlvhyv3MwMEQ84DWVZMAFC/3VQlvZ69soeWsbmRXpGq03p4vFb6fv5KlxCb4xiuYNVubljA==
Received: from DU2PR04CA0080.eurprd04.prod.outlook.com (2603:10a6:10:232::25)
 by AM6PR10MB2743.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:a5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 14:01:05 +0000
Received: from DB5EUR01FT028.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:232:cafe::9f) by DU2PR04CA0080.outlook.office365.com
 (2603:10a6:10:232::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Thu, 6 Jan 2022 14:01:05 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 194.138.21.71) smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=siemens.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of siemens.com: DNS Timeout)
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT028.mail.protection.outlook.com (10.152.4.237) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Thu, 6 Jan 2022 14:01:04 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 6 Jan 2022 15:01:03 +0100
Received: from [167.87.72.7] (167.87.72.7) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 6 Jan
 2022 15:01:03 +0100
Message-ID: <e4a55c2b-64dd-6281-c9d9-bf568a6fb732@siemens.com>
Date: Thu, 6 Jan 2022 15:01:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [isar-cip-core][PATCH 1/4] Add cip-core-image-kernelci
Content-Language: en-US
To: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>,
	<cip-dev@lists.cip-project.org>
References: <20220106111614.218823-1-alice.ferrazzi@miraclelinux.com>
 <20220106111614.218823-2-alice.ferrazzi@miraclelinux.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220106111614.218823-2-alice.ferrazzi@miraclelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.7]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 205705bd-44d3-421c-2c89-08d9d11cfaa7
X-MS-TrafficTypeDiagnostic: AM6PR10MB2743:EE_
X-Microsoft-Antispam-PRVS: 
	<AM6PR10MB2743170452E9B57FF66B2A3A954C9@AM6PR10MB2743.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WxlkQbpdSSnSL16hDAnWUf2FdpjBZzMOdIRQBHSt8+7IPDGrLon4llH8AiEtJdi6s9LLMQSWsCy2wKpcWXd6ZUxd2XRUB24JQ2CxtTjTts7CLs4MVxy2jbyo3RXPnbq3JL+OTUzYRCGxcr73gOyW20EkzI68veBBf0at1jhVCW2xHOF+Rmhfn4ezX9w7fJBorEHbHUOD4WMTXOuSVtHrfBQn0kYrIOX4xixR6FGQD/nkIw0Gh+npph4XZpNEn7lyQ6DU/z8UVbGe7HgVbx/ti44cdmepqtc+E+cgdMxGrIqaz+cB1tXDx935euycDSdjtQSKkgXpKwxl7YABCEqbBe2p/8jaezLXVgk+N5n9SFjCwgcBT7z1NlW6zAkZwEMn4/rCrrxcFR+8pIj5aeOnRmhPLywSWox+ybzJjzsGu/81ss5UZgn9I3gPhElD7+a3vebxveT1kBMMCFakTLK0usIRSbJMeGxXi1WJOYCM84NJ+g3F+Gedj1zt6c9DqHD6TtvKg6B+97rf6N4wUhr+F7g0Hbmm8BN0zrpV78xoPaso4+k6qHtbKIPVQZ0Dr7HRamjDmrMn3SF+O9AFkWbJuQQCXDLcUFPN/eUMhLUDRszoEinn96ANvFt10LHRKW33xfNvfS6uarYgsOPmBYHVKOw1qEVFIlk6yR9hGxkIykYaMbW2g/Npe54cbHQ4XyhTNJ8o48kGqrDWs4Hf6ejcs5hoyMW8oSlU5hDBFto7SgEkXjm9seBv/aL7Rhbyj+RiglOovmWDnEogXwDuBc2VB2GTB6eJOAFBIkZwakJHLyop20C5pG6F4HThXmV9H/0Dz8KGkqdWeVUEqrfCTB5dGp5Sik6zWdVLz6VkzEu8N9E=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700002)(5660300002)(82310400004)(336012)(63350400001)(956004)(63370400001)(70586007)(47076005)(16526019)(186003)(8936002)(110136005)(6706004)(16576012)(2906002)(2616005)(316002)(36860700001)(40460700001)(26005)(83380400001)(36756003)(86362001)(82960400001)(356005)(81166007)(8676002)(53546011)(70206006)(44832011)(31696002)(508600001)(31686004)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 14:01:04.3451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 205705bd-44d3-421c-2c89-08d9d11cfaa7
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT028.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2743
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jan 2022 14:01:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7333

On 06.01.22 12:16, Alice Ferrazzi wrote:
> This image is currently used by KernelCI production for testing purpose.
> The purpose of this image is that KernelCI need to be able to autologin
> without password and to detect the login shell using special characters.
> Currently added are the default settings used by KernelCI images.
> 
> Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> ---
>  kas/opt/kernelci.yml                          | 16 +++++++++
>  .../images/cip-core-image-kernelci.bb         | 16 +++++++++
>  .../files/99-silent-printk.conf               |  1 +
>  .../kernelci-customizations/files/ethernet    | 23 +++++++++++++
>  .../kernelci-customizations/files/postinst    | 34 +++++++++++++++++++
>  .../kernelci-customizations.bb                | 34 +++++++++++++++++++
>  6 files changed, 124 insertions(+)
>  create mode 100644 kas/opt/kernelci.yml
>  create mode 100644 recipes-core/images/cip-core-image-kernelci.bb
>  create mode 100644 recipes-core/kernelci-customizations/files/99-silent-printk.conf
>  create mode 100644 recipes-core/kernelci-customizations/files/ethernet
>  create mode 100644 recipes-core/kernelci-customizations/files/postinst
>  create mode 100644 recipes-core/kernelci-customizations/kernelci-customizations.bb
> 
> diff --git a/kas/opt/kernelci.yml b/kas/opt/kernelci.yml
> new file mode 100644
> index 0000000..9c67864
> --- /dev/null
> +++ b/kas/opt/kernelci.yml
> @@ -0,0 +1,16 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation, 2020
> +# Copyright (c) Cybertrust Japan Co., Ltd., 2021
> +#
> +# Authors:
> +#  Venkata Pyla <venkata.pyla@toshiba-tsip.com>
> +#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +header:
> +  version: 10
> +
> +target: cip-core-image-kernelci
> diff --git a/recipes-core/images/cip-core-image-kernelci.bb b/recipes-core/images/cip-core-image-kernelci.bb
> new file mode 100644
> index 0000000..479c14c
> --- /dev/null
> +++ b/recipes-core/images/cip-core-image-kernelci.bb
> @@ -0,0 +1,16 @@
> +#
> +# A reference image for KernelCI
> +#
> +# Copyright (c) Cybertrust Japan Co., Ltd., 2021
> +#
> +# Authors:
> +#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit image
> +
> +DESCRIPTION = "CIP Core image for KernelCI"
> +
> +IMAGE_INSTALL += "kernelci-customizations"
> diff --git a/recipes-core/kernelci-customizations/files/99-silent-printk.conf b/recipes-core/kernelci-customizations/files/99-silent-printk.conf
> new file mode 100644
> index 0000000..ad24d3a
> --- /dev/null
> +++ b/recipes-core/kernelci-customizations/files/99-silent-printk.conf
> @@ -0,0 +1 @@
> +kernel.printk = 3 4 1 3
> diff --git a/recipes-core/kernelci-customizations/files/ethernet b/recipes-core/kernelci-customizations/files/ethernet
> new file mode 100644
> index 0000000..fa47d1a
> --- /dev/null
> +++ b/recipes-core/kernelci-customizations/files/ethernet
> @@ -0,0 +1,23 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2019
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +allow-hotplug eth0
> +allow-hotplug enp0s2
> +allow-hotplug enp2s0
> +
> +# used on BBB
> +iface eth0 inet dhcp
> +
> +# used on qemu-amd64
> +iface enp0s2 inet dhcp
> +
> +# used on simatic-ipc227e
> +iface enp2s0 inet dhcp
> diff --git a/recipes-core/kernelci-customizations/files/postinst b/recipes-core/kernelci-customizations/files/postinst
> new file mode 100644
> index 0000000..7ae30e8
> --- /dev/null
> +++ b/recipes-core/kernelci-customizations/files/postinst
> @@ -0,0 +1,34 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2019
> +# Copyright (c) Cybertrust Japan Co., Ltd., 2021
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +echo "CIP Core Demo & Test Image" > /etc/issue
> +
> +# permit root login without password
> +echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
> +echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config
> +passwd root -d
> +
> +# serial getty service for autologin
> +mkdir -p /etc/systemd/system/serial-getty@.service.d/
> +echo "[Service]" > /etc/systemd/system/serial-getty@.service.d/override.conf
> +echo "ExecStart=" >> /etc/systemd/system/serial-getty@.service.d/override.conf
> +echo "ExecStart=-/sbin/agetty --autologin root --keep-baud 115200,38400,9600 %I $TERM" >> /etc/systemd/system/serial-getty@.service.d/override.conf
> +
> +# set the profile for KernelCI
> +echo "PS1='\$(pwd) # '" > /root/.profile
> +echo "cd /" >> /root/.profile
> +
> +HOSTNAME=demo
> +echo "$HOSTNAME" > /etc/hostname
> +echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
> diff --git a/recipes-core/kernelci-customizations/kernelci-customizations.bb b/recipes-core/kernelci-customizations/kernelci-customizations.bb
> new file mode 100644
> index 0000000..dca0891
> --- /dev/null
> +++ b/recipes-core/kernelci-customizations/kernelci-customizations.bb
> @@ -0,0 +1,34 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2019
> +# Copyright (c) Cybertrust Japan Co., Ltd., 2021
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit dpkg-raw
> +
> +DESCRIPTION = "CIP Core image demo & customizations"
> +
> +SRC_URI = " \
> +    file://postinst \
> +    file://ethernet \
> +    file://99-silent-printk.conf"
> +
> +DEPENDS += "sshd-regen-keys"
> +
> +DEBIAN_DEPENDS = " \
> +    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-keys"
> +
> +do_install() {
> +  install -v -d ${D}/etc/network/interfaces.d
> +  install -v -m 644 ${WORKDIR}/ethernet ${D}/etc/network/interfaces.d/
> +
> +  install -v -d ${D}/etc/sysctl.d
> +  install -v -m 644 ${WORKDIR}/99-silent-printk.conf ${D}/etc/sysctl.d/
> +}

This is duplicating the default customization package, IIUC, for the
purpose of adding further things. And you already miss some things due
to this (WIRELESS_FIRMWARE_PACKAGE, INSTALL_WIRELESS_TOOLS).

How about installing both and carrying in kernelci-customization only
the delta? Or at least reuse artifacts from customizations package, e.g.
via symlinks?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

