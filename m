Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56602C433FE
	for <webhook@archiver.kernel.org>; Wed, 19 Oct 2022 10:44:32 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.59])
 by mx.groups.io with SMTP id smtpd.web11.6289.1666176262327511404
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Oct 2022 03:44:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=byZRI7ID;
 spf=pass (domain: siemens.com, ip: 40.107.7.59, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieQRQYo3Z3iZR3XfqR+bG3ewWl2ySLQ7w1hL+sPLsHWVAMQLaatO36bAzOzUe71xfe0gK90Kyof2vSmw+scO354yr7nwhEp8E0PWz61mQJHh1FclaIifYWwk202AMtEzRpWJ58qPp1FAGgLnZlTzRXYVTTP/t4i0dqB5ZSrpUTWiHIIArIbGZreoE8yFrEDyBRdZZYuDAP4b4lN4dkjVtjiSrV0AMm0El3RDDs+QOdCPOhqlx3BdU5mMGxyC9TMehGdQL26/8bfFtDBDEIoUrx7lf0AaP0sAc61mPRqhjkuV/voH5y+8Ic0tL43BfgE68E2xwbORzm/KmNnoQyPfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhuteMpLJAEFZG5Y8/of33bJ5oi3T+2594Pg5QvvxPs=;
 b=jlRctTNhwO2L4M5rVH1HKXGFsP+RnwaYDQLjGDJMDeuUcYFHDN2Qc6NAvkN1D/rwxULnZ85mkzJpKu76Carlaj32j8F+C/+/nKcEBtwnlnPPwfxUDBxdBBpAfssZxva9FNb6rWpm8Nvj8XwfP+zWjAFTm3psEJJ3UExZFLHP1RqvweGloCCJA0YKBXIP7ka7f0kPiy4vk5O7ke2ivFW6UrKhEBioEQuZCSk3gtnzdJeB5prBdGnGCD+RFciejp+V3KvnN22Vnv/fwrdw6duDYYwGzgFXjaaNdppe5pkPXHzK0uX6MRe1SJNhoOLoak04WgVZI5QShI2gOxfYdLslbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhuteMpLJAEFZG5Y8/of33bJ5oi3T+2594Pg5QvvxPs=;
 b=byZRI7ID2lUKyqaw4pv0FJsEFQHlcSinNC+YQL3w5OJn22W5EvDbA8urlL9eXXmyhkZ1I3xaoGSBCl+juZh8O+fCLgn77UnDQZNxdzOkOfi+5rRRL5tfLaFlJ/mRJ/1+tbSswQiTzR23ayQG3Yh72lVmHbqKS7PWwWkBeF5F0KIHfIBpldOZmYc/dx1ojgBE77U3utWkwzCdYn+PJDwKsAI8PqKYFun8sKIaJb2QWObePj62mFQYg8R+gw9M1RFdlgwjhLguLqyQEzUqgCRbgapUdci3Z5lEGKxcRVfAi4OOz3g3xi4s4ag87t+QXZ/6v9ao5VObSE1awP09dBGRCQ==
Received: from OS6P279CA0171.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:38::18)
 by DB9PR10MB7218.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:454::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 19 Oct
 2022 10:44:19 +0000
Received: from HE1EUR01FT014.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:38:cafe::c0) by OS6P279CA0171.outlook.office365.com
 (2603:10a6:e10:38::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Wed, 19 Oct 2022 10:44:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT014.mail.protection.outlook.com (10.152.0.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Wed, 19 Oct 2022 10:44:18 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.15; Wed, 19 Oct 2022 12:44:18 +0200
Received: from [139.22.133.243] (139.22.133.243) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Wed, 19 Oct 2022 12:44:17 +0200
Message-ID: <c020dd31-5cc6-4be8-bee1-f313e816a817@siemens.com>
Date: Wed, 19 Oct 2022 12:44:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [isar-cip-core][PATCH 1/7] add recipe for optee qemu arm64
Content-Language: en-US
To: <sven.schultschik@siemens.com>, <cip-dev@lists.cip-project.org>
References: <20221019092117.5291-1-sven.schultschik@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221019092117.5291-1-sven.schultschik@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.133.243]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.399900-8.000000
X-TMASE-MatchedRID: J3RqQtrrI5k5QaOxwNGfvo9bHfxDWoibATaHBwVHy/1qZ6OipRp3ejlb
	BhAKzgGf31GU/N5W5BB2DX7fiwsbtuV6Ukjo9KrLWP7S1AyiPEAsaaYlMvaOHA97mDMXdNW3AZn
	/4A9db2Tvrj2fROADiX+YLBuR+SHBzd9D/IRLjmkQea4Si8omsgK1I3/RsWjTaDCzqDR7DPabOw
	nwKxlhTqFIbih0s/42TxSugU04anvJvHAVwrvMvCUskOAallgBOiyyh0NN44NwGgR8fjmhmExBQ
	tM1e2ykBO9W+Ur4NIBu5QV/9+0eKfial1lqTpQaUYB7V58oVjjMgfjGGlvykAXGi/7cli9jgcsV
	ZH3dOCQznjnsX+epgNnoquRwHY3Bstq2oQPQBaR2w9nBs56maHZDfiFP1tnyvHKClHGjjr0BDya
	2JbH/+qEBi7RBcbi8RDLxu3JRGrQTev6ffZr1JeF45apSJW4bAGVQK2qiF3nVsW2YGqoUtMKaBY
	cV17jQA8FfY2Fm0lMtPdMtqK0cn+mAB8kTq9W5dBi1avXuVWyv32t0t0cTKIh/ebSxR/Hn2FA7w
	K9mP9eUAUfla+IhaLKXWmEvaG3ECxvAgaTHFy+Rk6XtYogiau9c69BWUTGwVnRXm1iHN1bEQdG7
	H66TyH4gKq42LRYkEWM4+A1psvxBwRbU4ptdWmFbdjngJROxlDwEMJgakml+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.399900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: EDEBEFD20F5A414178E8C5E777F67BB01B4E3405A105EAA8D62875E5B3374AC72000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT014:EE_|DB9PR10MB7218:EE_
X-MS-Office365-Filtering-Correlation-Id: 67114d47-2cfd-4f1e-9809-08dab1bee02b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SNfw318rAUgvTOwWiShZRXz5+YUaElgKBD+IKhm1znJUBC/0xnuQwVBWXwMAWg/Jfylrl45tjsNleynnaokTwqLtkYx05VH3Nwo/c68uPnpH32WlI1ouzkZ6kE/vXotpRTDz8C2+U7ZNjrfQtdXfvudCzc4scRl8YV0WbmbQDe3xLI59vxUy5zoghS/2df9TIBRQVnAJZNom7QR3cVqpsoS5Fqd14aoreJp42ccs1Do08D3x8jNUoHoHnkxhUGhpU5mVA8lr/g7l0d8VwTAcBP5p0bMEcVBvyKXrAqp4p3nXQLy0tt7zbbbuLnM8BldkzTPJZghZYN0u95AjZ9sSYNmS3qQR9NoHF5ALTgSWgoErrpeMMRLb+EOGInp3tB/z/9/U6GhklHW2f9PpXwqxVLGoNHpU+FMSsnCb0QjJxXw0w/GQs71yx5cSE0xGgeC4CUjwEgALjkZAu/6Rzdfh789Q7C49o3ZIqx140WY/YY1vxLiA2liN/WSt7Obj+b4aOZPi27acXKS1qSohROEZ2T7W1f41lL960x+z2STq8T98sGqVtCTe9aL1maaTwEezoTPSQyzkX+YiQ0j/9Pxj0Hx9VBoisvdASO8QlYSdEW0q7Bebagi9ShcY6AQ8t0+Nx5OndkdXj+rzh2wwipkBTuBrlgpOz2peg3CI+cV/X9fu1d1IyhUbcv//003FVdJp17zAEnPBcDh1/qgn9BLagfFQPZjueLek7SBDfDnaFV6U7WSLgYKX457qwlRGmqfBKSCczbCuTEDOKJJcGHy+w9DUc13usv71GiwYGI73oPoyYUcqPwQPwgsTQPc8rPxqwlnkvQshNdlYhabpCz0ePp+DZ13E0pDFo/GqXIcOKpzDDulM7Ydo6ys6xAth/RbZNz0fVlwS+iJPeBNl1UJCKN7PVbUM6gi8lsmGhVHraIQ=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199015)(46966006)(40470700004)(36840700001)(110136005)(478600001)(53546011)(6706004)(26005)(8676002)(70206006)(70586007)(44832011)(41300700001)(5660300002)(956004)(8936002)(186003)(82740400003)(82960400001)(82310400005)(336012)(316002)(2616005)(47076005)(2906002)(16576012)(83380400001)(31686004)(81166007)(31696002)(36756003)(356005)(16526019)(40460700003)(86362001)(40480700001)(36860700001)(34020700004)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 10:44:18.8264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67114d47-2cfd-4f1e-9809-08dab1bee02b
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT014.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7218
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Oct 2022 10:44:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9782

On 19.10.22 11:21, sven.schultschik@siemens.com wrote:
> From: Sven Schultschik <sven.schultschik@siemens.com>
> 
> The recipe provides the possibility to create optee-os binaries for use inside of an qemu secureboot setup with edk2, rpmb, u-boot and uefi
> 
> Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
> ---
>  .../op-tee/optee-os-qemu-arm64_3.17.0.bb      | 57 +++++++++++++++++++
>  recipes-bsp/u-boot/files/secure-boot.cfg.tmpl |  7 +++
>  recipes-bsp/u-boot/u-boot-common.inc          |  6 +-
>  3 files changed, 67 insertions(+), 3 deletions(-)
>  create mode 100644 recipes-bsp/op-tee/optee-os-qemu-arm64_3.17.0.bb
> 
> diff --git a/recipes-bsp/op-tee/optee-os-qemu-arm64_3.17.0.bb b/recipes-bsp/op-tee/optee-os-qemu-arm64_3.17.0.bb
> new file mode 100644
> index 000000000..5e60041af
> --- /dev/null
> +++ b/recipes-bsp/op-tee/optee-os-qemu-arm64_3.17.0.bb
> @@ -0,0 +1,57 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2022
> +#
> +# Authors:
> +#  Sven Schultschik <sven.schultschik@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +HOMEPAGE = "https://github.com/OP-TEE/optee_os"
> +MAINTAINER = "Sven Schultschik <sven.schultschik@siemens.com>"
> +LICENSE = "BSD-2-Clause"
> +
> +require recipes-bsp/optee-os/optee-os-custom.inc
> +
> +SRC_URI += " \
> +            gitsm://github.com/OP-TEE/optee_os.git;branch=master;protocol=https;destsuffix=git;rev=${PV}"

Do we really need the second-class supported gitsm fetcher here? Also,
destsuffix and rev are both redundant (they are defaults).

Oh, indention by 4 spaces would be sufficient.

> +
> +S = "${WORKDIR}/git"
> +
> +OPTEE_PLATFORM = "vexpress-qemu_armv8a"
> +
> +OPTEE_BINARIES = "tee-header_v2.bin \
> +    tee-pager_v2.bin \
> +    tee-pageable_v2.bin"
> +
> +DEPENDS = "edk2"
> +DEBIAN_BUILD_DEPENDS += " ,\
> +    debhelper(>= 11~), \
> +    build-essential, \

Redundant.

> +    cpio, \
> +    python3-cryptography, \
> +    python3-pycryptodome, \
> +    python3-serial, \
> +    device-tree-compiler, \
> +    edk2, \

Do we need Debian's edk2 here?

> +    gcc-arm-linux-gnueabihf,"
> +
> +OPTEE_EXTRA_BUILDARGS = "CFG_STMM_PATH=/usr/lib/edk2/BL32_AP_MM.fd CFG_RPMB_FS=y \
> +        CFG_RPMB_FS_DEV_ID=0 CFG_CORE_HEAP_SIZE=524288 CFG_RPMB_WRITE_KEY=1 \
> +        CFG_CORE_DYN_SHM=y CFG_RPMB_TESTKEY=y \
> +        CFG_REE_FS=n\
> +        CFG_TEE_CORE_LOG_LEVEL=1 CFG_TEE_TA_LOG_LEVEL=1 CFG_SCTLR_ALIGNMENT_CHECK=n \
> +        CFG_ARM64_core=y CFG_CORE_ARM64_PA_BITS=48"
> +
> +ISAR_CROSS_COMPILE = "0"

This looks wrong, specifically as you are installing a 32-bit
cross-compiler and calling a 64-bit one as well below.

> +
> +dpkg_runbuild_prepend() {
> +    # $(ARCH) is the CPU architecture to be built. 
> +    # Currently, the only supported value is arm for 32-bit or 64-bit Armv7-A or Armv8-A. 
> +    # Please note that contrary to the Linux kernel, $(ARCH) should not be set to arm64 for 64-bit builds. 
> +    export ARCH="arm"
> +    export CROSS_COMPILE32=arm-linux-gnueabihf-
> +    export CROSS_COMPILE64=aarch64-linux-gnu-

That is a deprecated style, and sbuild will complain. Move into the
rules file.

> +}
> \ No newline at end of file

Please have a "newline at the end of file".

> diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl b/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
> index 956dcbfed..8e6428238 100644
> --- a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
> +++ b/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
> @@ -4,3 +4,10 @@ CONFIG_USE_BOOTCOMMAND=y
>  CONFIG_BOOTCOMMAND="setenv scan_dev_for_boot 'if test -e ${devtype} ${devnum}:${distro_bootpart} efi/boot/boot${EFI_ARCH}.efi; then load ${devtype} ${devnum}:${distro_bootpart} ${kernel_addr_r} efi/boot/boot${EFI_ARCH}.efi; bootefi ${kernel_addr_r} ${fdtcontroladdr}; fi'; run distro_bootcmd; echo 'EFI Boot failed!'; sleep 1000; reset"
>  CONFIG_EFI_VARIABLES_PRESEED=y
>  CONFIG_EFI_SECURE_BOOT=y
> +### OPTEE config
> +CONFIG_CMD_OPTEE_RPMB=y
> +CONFIG_MMC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_TEE=y
> +CONFIG_OPTEE=y
> +CONFIG_EFI_MM_COMM_TEE=y
> diff --git a/recipes-bsp/u-boot/u-boot-common.inc b/recipes-bsp/u-boot/u-boot-common.inc
> index 60f0da361..7fe4d3fad 100644
> --- a/recipes-bsp/u-boot/u-boot-common.inc
> +++ b/recipes-bsp/u-boot/u-boot-common.inc
> @@ -25,12 +25,12 @@ DEBIAN_BUILD_DEPENDS += ", libssl-dev:native, libssl-dev:${DISTRO_ARCH}"
>  
>  DEBIAN_BUILD_DEPENDS_append_secureboot = ", \
>      openssl, pesign, secure-boot-secrets, python3-openssl:native"
> -DEPENDS_append_secureboot = " secure-boot-secrets"
> +DEPENDS_append_secureboot = " secure-boot-secrets optee-os-${MACHINE}"

Nope, this must go into qemu-specific U-Boot bits. We don't have
optee-os for the rest yet.

>  
>  TEMPLATE_FILES_append_secureboot = " secure-boot.cfg.tmpl"
>  TEMPLATE_VARS_append_secureboot = " EFI_ARCH"
>  
>  do_prepare_build_append_secureboot() {
>      sed -ni '/### Secure boot config/q;p' ${S}/configs/${U_BOOT_CONFIG}
> -    cat ${WORKDIR}/secure-boot.cfg >> ${S}/configs/${U_BOOT_CONFIG}
> -}
> +    cat ${WORKDIR}/secure-boot.cfg >> ${S}/configs/${U_BOOT_CONFIG}    
> +}
> \ No newline at end of file

Spurious change. Please cross-read your diffs for such things.

When you resend, I would suggest to split up the optee recipe
introduction and the U-Boot changes.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


