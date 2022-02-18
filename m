Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21443C433EF
	for <webhook@archiver.kernel.org>; Fri, 18 Feb 2022 16:15:43 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.57])
 by mx.groups.io with SMTP id smtpd.web09.12913.1645200941563190881
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Feb 2022 08:15:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iWI2Iz6Z;
 spf=pass (domain: siemens.com, ip: 40.107.20.57,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsE8BCInZ1AqHpwcZx0ob0hCZh6jKVwJsZXkT5cY1OsPqi8njDh15vICSktxTRRV/x+Hle2upNJ8za68mHwsy08gpDFaTmWnDOgcPBMRLixHzMHjX1r20VcMfe2u5QyZthfCYO5J1vyqA9dxuRWEczjnA4qBDKERAU53bSlgnN+Ivuuw1Uk9Bx6VpKz7oA0v2yUOfMD0KjpCPVxHAfKEbRhGl4mq2vAPbwnoCsKKr61JBk5/XrZz27cJi/4FlNuWY7dEL2pNDWeX90Y+YVo3YCIxdgNkS3R0vASXtyyQbBKba2Qsc4Kvn1X0WSz2lfGtqizNTTiBRfxWbol4AVzNtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKVpYIz1BN9yk+qXs/00AKLHZD7cFvRwQ/b5GWMPlE4=;
 b=Zo1WQBXwO+vGcbZgjIUuPhB6r6mKGKlp3FRCA/e5xGznrJ6Ap/o21PDZVKRroa7l/pKHqI8yy629teMkig0rdQD2IfjkUXLzr7vQBrZQ54L3tHz8SRrzGVLkBMCNL0tEKw2qRRqjYDOCPM9H19K0MGTB0Hv59fRijtJq3zgKB6z7mpCrXd2/Eywea5uhi5f5QjOgfKgESyLF5XWT9XRqsFoPO1DHocQ8967GrM38hUne+Kdw7c+xP+DigWrLCkir0nFQUSYsn6Wnm7OFu7WTKnRx3xQZufFR+wDzYF0+LDLhkPQ1rV6wauiVbcfc42XxysJkLUeIq2Qu/ZXlZ7Pt7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKVpYIz1BN9yk+qXs/00AKLHZD7cFvRwQ/b5GWMPlE4=;
 b=iWI2Iz6ZYKMPbuAauIhJkohCm8NNpc5CXwDxl6EMyVnrI4hJLDrBfWyn7ARXuSgN8QgHTPqDpv/vKsKk+9Q5X4QAaoAYdeEERHvdsLS4mF2SF3IsXZnsq7RBwpU7FqBMGEl+UItAOFh1Sj/4tG35PyZafTPgjR8HnjG/1AL/ssbpEKMst47tuXSu4sYw0XG/7IzMrrkNJA1o4KhoCuKUiQb+16YlHGY2OpDznl4cnvOwNjH8szGUOqSxSGHOHA8Q0hSKmQW1wo6PvAEm6UGIg/cihTA52/4zM9qJDJOz+SVdQKukfvoWBD2rOwguu+WXI/vTmIr9mtQ3Qe4BvFCGeA==
Received: from DU2PR04CA0178.eurprd04.prod.outlook.com (2603:10a6:10:2b0::33)
 by AS8PR10MB4613.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:2e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Fri, 18 Feb
 2022 16:15:36 +0000
Received: from DB5EUR01FT043.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:2b0:cafe::38) by DU2PR04CA0178.outlook.office365.com
 (2603:10a6:10:2b0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.22 via Frontend
 Transport; Fri, 18 Feb 2022 16:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT043.mail.protection.outlook.com (10.152.5.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 16:15:35 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 18 Feb 2022 17:15:35 +0100
Received: from [167.87.0.165] (167.87.0.165) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 17:15:35 +0100
Message-ID: <17559118-fa0f-59b3-c761-76851bd6c28f@siemens.com>
Date: Fri, 18 Feb 2022 17:15:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v3] efibootguard: Do not copy the
 efi binaries directly into DEPLOY_DIR
Content-Language: en-US
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220218152842.1031311-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220218152842.1031311-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.165]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae94984d-a52e-4ada-67a0-08d9f2f9e555
X-MS-TrafficTypeDiagnostic: AS8PR10MB4613:EE_
X-Microsoft-Antispam-PRVS: 
	<AS8PR10MB46138CB40D950B697BB83D7195379@AS8PR10MB4613.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	czyKl/9XvTZL9f5IG1V+rfjWgBnLXuBhtmNGhHG8A7vvjZWM6JhDdRO25Veci2LwUTV3sITG8jwFUGHSXNsb0FfxySrDmoR4J7TbwpqhtVHIps6xLjFnQWUFKjd1RTEJSA/DdbsuppZgXw3E8t2L6sQQ2KvLCTIuSHDpK5xTUZHBTUYy98cbfRDXBFHIv2+XY4NdcaveVG289Q6hHSYzNeTtKASeM1lPkw9OblW5lOVT8PAX7RFxkNOZpjtqqxCGgkqbEvlajWJOV9bUDQWZFG1x2mtW0EfoDN3wxAtg0+hifbkgREc20XnS2O/DY0Q3J/8ZYcGiMCNvAFstdkScpGRaq2CRRt+2Oob0esAJlrHTAmQr/CEyTCOZsKvF5hQv/zgpTGEwT3S+S+5Zxvu3kIXP3kkEnkh5tYwHrCEesMEyW44GnMfWTj5hZuULSnrl9RkDmSo/sIO00xo4oiRqxQZ7L+dvd+YtyvYzQrzDe0/EHuMGTnu8maW6XKm+GUQWKJZmLJTH6u7iZMSgDuamXpqoBlIizE2zYvYYXCKCJLHxUGM9SsQ82DAsnW96cgCWrdaY6LwvFjEiu2nF23uGnppq1tA9TykkmLNyeRZkmk83ex+eikCo4hZsb+ARU0SR9a0542PIAHm27AxT+1gVNcy4eqlE4LTJgCIt8DLGVRNXvuy6TFuni/4Dehxi7OJDY/+WBQBDYpoXPNND4rhgcZdXKum4c9tEEH5tRAPD28PEpgMokfQBMAblYYBbHzh+NsFbELfapv4kWk28eU5AGg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(26005)(5660300002)(186003)(53546011)(81166007)(86362001)(82960400001)(82310400004)(36756003)(356005)(44832011)(8676002)(2906002)(8936002)(31696002)(83380400001)(16526019)(40460700003)(47076005)(316002)(956004)(336012)(36860700001)(2616005)(508600001)(70586007)(70206006)(31686004)(16576012)(110136005)(6706004)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 16:15:35.7212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ae94984d-a52e-4ada-67a0-08d9f2f9e555
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT043.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB4613
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Feb 2022 16:15:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7633

On 18.02.22 16:28, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This patch prepares isar-cip-core to integrate the ISAR features
> sstate and the upcoming sbuild feature. The features introduce the
> following changes: 
>  - Sbuild doesn't easily allow the extraction of build results
>  - sstate doesn't populate the DEPLOY_DIR from packages in case of a rebuild.
> 
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v2:
>  - use distro_arch to determine binary name
>  - remove additional debug message
>  - remove deploydir
> 
> Changes v3:
>  - add dictionary to map between DISTRO_ARCH and efi architecture idenitifer
>  - remove handling of source_param `files`
>  - reword commit message
> 
>  kas/opt/efibootguard.yml                      |  1 +
>  .../efibootguard/efibootguard_0.9-git+isar.bb |  5 ---
>  .../files/debian/efibootguard.install         |  1 +
>  .../files/debian/efibootguard.links           |  1 +
>  .../wic/plugins/source/efibootguard-boot.py   |  3 +-
>  .../wic/plugins/source/efibootguard-efi.py    | 39 ++++++++++---------
>  wic/qemu-amd64-efibootguard-secureboot.wks.in |  2 +-
>  7 files changed, 25 insertions(+), 27 deletions(-)
>  create mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard.links
> 
> diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
> index 75d4ab1..f5f9169 100644
> --- a/kas/opt/efibootguard.yml
> +++ b/kas/opt/efibootguard.yml
> @@ -21,6 +21,7 @@ local_conf_header:
>      SWUPDATE_BOOTLOADER = "efibootguard"
>  
>    efibootguard-wic: |
> +    WIC_IMAGER_INSTALL_append = " efibootguard"
>      WDOG_TIMEOUT ?= "60"
>      WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE"
>      IMAGE_FSTYPES ?= "wic-img"
> diff --git a/recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb b/recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb
> index 2817e5b..171d8d4 100644
> --- a/recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb
> +++ b/recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb
> @@ -39,8 +39,3 @@ do_prepare_build() {
>      deb_add_changelog
>  }
>  
> -dpkg_runbuild_append() {
> -    install -m 0755 -d ${DEPLOY_DIR_IMAGE}
> -    install -m 0755 ${S}/efibootguardx64.efi ${DEPLOY_DIR_IMAGE}/bootx64.efi
> -    install -m 0755 ${S}/bg_setenv ${DEPLOY_DIR_IMAGE}/bg_setenv
> -}
> diff --git a/recipes-bsp/efibootguard/files/debian/efibootguard.install b/recipes-bsp/efibootguard/files/debian/efibootguard.install
> index 8a8d9d3..0239953 100644
> --- a/recipes-bsp/efibootguard/files/debian/efibootguard.install
> +++ b/recipes-bsp/efibootguard/files/debian/efibootguard.install
> @@ -1,2 +1,3 @@
>  bg_setenv usr/bin
>  bg_printenv usr/bin
> +efibootguardx64.efi usr/share/efibootguard
> diff --git a/recipes-bsp/efibootguard/files/debian/efibootguard.links b/recipes-bsp/efibootguard/files/debian/efibootguard.links
> new file mode 100644
> index 0000000..97bab21
> --- /dev/null
> +++ b/recipes-bsp/efibootguard/files/debian/efibootguard.links
> @@ -0,0 +1 @@
> +usr/share/efibootguard/efibootguardx64.efi usr/share/efibootguard/bootx64.efi
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> index 882729a..05cef4e 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -111,9 +111,8 @@ class EfibootguardBootPlugin(SourcePlugin):
>  
>          cwd = os.getcwd()
>          os.chdir(part_rootfs_dir)
> -        config_cmd = '%s/bg_setenv -f . -k "C:%s:%s" %s -r %s -w %s' \
> +        config_cmd = '/usr/bin/bg_setenv -f . -k "C:%s:%s" %s -r %s -w %s' \
>              % (
> -                deploy_dir,
>                  part.label.upper(),
>                  boot_image,
>                  '-a "%s"' % cmdline if cmdline else "",
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> index 9eb2353..858fcbf 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> @@ -51,31 +51,32 @@ class EfibootguardEFIPlugin(SourcePlugin):
>          populate an EFI boot partition containing the EFI Boot Guard
>          bootloader binary.
>          """
> -        deploy_dir = get_bitbake_var("DEPLOY_DIR_IMAGE")
> -        creator.deploy_dir = deploy_dir
> -        bootloader_files = source_params.get("bootloader")
> -        if not bootloader_files:
> -            bootloader_files = "bootx64.efi"
> -        bootloader_files = bootloader_files.split(' ')
> +        # we need to map the distro_arch to uefi values
> +        distro_to_efi_arch = {
> +            "amd64": "x64",
> +            "arm64": "aarch64",
> +            "i386": "ia32"
> +        }
> +
> +        distro_arch = get_bitbake_var("DISTRO_ARCH")
> +        bootloader = "/usr/share/efibootguard/boot{}.efi".format(
> +            distro_to_efi_arch[distro_arch])
>          part_rootfs_dir = "%s/disk/%s.%s" % (cr_workdir,
>                                               part.label,
>                                               part.lineno)
>          create_dir_cmd = "install -d %s/EFI/BOOT" % part_rootfs_dir
>          exec_cmd(create_dir_cmd)
>  
> -        for bootloader in bootloader_files:
> -            signed_bootloader = cls._sign_file(bootloader,
> -                                               "{}/{}".format(deploy_dir,
> -                                                              bootloader
> -                                                              ),
> -                                               cr_workdir,
> -                                               source_params)
> -            # important the bootloader in deploy_dir is no longer signed
> -            cp_cmd = "cp %s/%s %s/EFI/BOOT/%s" % (cr_workdir,
> -                                                signed_bootloader,
> -                                                part_rootfs_dir,
> -                                                bootloader)
> -            exec_cmd(cp_cmd, True)
> +        name = os.path.basename(bootloader)
> +        signed_bootloader = cls._sign_file(name,
> +                                           bootloader,
> +                                           cr_workdir,
> +                                           source_params)
> +        cp_cmd = "cp %s/%s %s/EFI/BOOT/%s" % (cr_workdir,
> +                                              signed_bootloader,
> +                                              part_rootfs_dir,
> +                                              name)
> +        exec_cmd(cp_cmd, True)
>          du_cmd = "du --apparent-size -ks %s" % part_rootfs_dir
>          blocks = int(exec_cmd(du_cmd).split()[0])
>  
> diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
> index 81fd4fe..72a6f8c 100644
> --- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
> @@ -1,5 +1,5 @@
>  # EFI partition containing efibootguard bootloader binary
> -part --source efibootguard-efi  --ondisk sda --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --sourceparams "signwith=/usr/bin/sign_secure_image.sh"
> +include ebg-signed-bootloader.inc
>  
>  # EFI Boot Guard environment/config partitions plus Kernel files
>  part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,unified-kernel=y,signwith=/usr/bin/sign_secure_image.sh"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

