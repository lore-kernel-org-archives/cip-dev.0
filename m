Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902FCC433F5
	for <webhook@archiver.kernel.org>; Tue, 15 Feb 2022 16:17:09 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.51])
 by mx.groups.io with SMTP id smtpd.web09.11609.1644941827450939584
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Feb 2022 08:17:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=u6qZFnhg;
 spf=pass (domain: siemens.com, ip: 40.107.7.51,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBj3XA/iUOmgcbSMJIm5qE5pIcgeysg5yIKLXghIjtkn51SCUXNhHpbjKr27vnqRtANLKRcPHilbYwt4ZTwgE96ILQCwk+uHJ0uIxYg2dZi3QDpV1guayA6mmUWwxE91kU0YhrGY8yv9ss4AsDrpcexH2jsDlAJoYlWw71rXmz3qyouP8pIKwCrZfoPQQ/ujslmTtWfD9nG9Xd0Va239pVrSQc3CQ2QeNSBF9FaPbUapDj4A+iT8nsot6zXRScHAizpPinxKD/Dz4BHlElOhrcpcOoz1WWQHjvEY2H7qUxzfEdsBP+TREC3fHh7Gyiwi4D/4w6h0wC+p6CzgQePWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APdeckwuzJOjQ1h83IKxCNcmvdSB8n3MbNzwL5SjEXc=;
 b=T4ilX6vSlqw7cbs81S9/eLyuLNyitS4poOMwTiw1W5OzP7AmReLJhaQfnWe6v7TwuXyA42m1TqsrU6hRO17auhvy6eTFYbY2py07BmITW1wi/bffzoy8fYl3VNZSx2jupTla11UJOj8aPwYtJKALS1XKEzTWeZzjsVhQByWqo13kRlm9BxeBWHSjyJ9rQF7lE/u6CAuahOKFJoqoxycOa3sEOZxz1wZbj5CKWEZUlgY0zpj+2D5a906IwSF/ew7VIsrqJiQIXi1ly0s7JYvijc2OY/uvd9oEhFFm3x0Y6iLIoWT3aUPFn0JJ1i3xQfZHI+mukxW/2nbQfUH0ifaLAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APdeckwuzJOjQ1h83IKxCNcmvdSB8n3MbNzwL5SjEXc=;
 b=u6qZFnhgQ9ytd1gU6TqqnAeo7RAsMUFeRQPatEMc97HiqHFps2gh5bs8JeyThsyHmnLasLJoTKSSTfDT1QoIg1j9gbl1q9h12pdkzXKxKP4hyQD0RCfZ7j4apVBTEC/Xv/aREEr58qU+XMWoSskQCz3ZCk1RKQhrQfd6DcqFEGFa51cl15BSLMsZ8BJIfAeNMtorN1seGqZR4SB/77gitfIDAesiN7/TWoii4KXCauxPy6XY+na7FsjWxd7228d57DEvWxoPk84FEvQ2y7EafLr4HAvaT4phi8Z4w1yanrMAJpDOvhtNZ3Qz5Sj0d5QZyp5g1Gq4DbjwqVCazJkICg==
Received: from AM0PR10CA0022.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::32)
 by DB7PR10MB1884.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:5:6::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Tue, 15 Feb 2022 16:17:03 +0000
Received: from VE1EUR01FT034.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:208:17c:cafe::87) by AM0PR10CA0022.outlook.office365.com
 (2603:10a6:208:17c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Tue, 15 Feb 2022 16:17:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 VE1EUR01FT034.mail.protection.outlook.com (10.152.2.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 16:17:03 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 15 Feb 2022 17:17:02 +0100
Received: from [167.87.0.44] (167.87.0.44) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 17:17:02 +0100
Message-ID: <3c48c8b1-7ced-1826-4ab7-1dba953f911e@siemens.com>
Date: Tue, 15 Feb 2022 17:17:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] efibootguard: Do not copy the
 efi binaries directly into DEPLOY_DIR
Content-Language: en-US
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220215150149.1748545-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220215150149.1748545-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.44]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 752de45b-095a-4524-b095-08d9f09e9a24
X-MS-TrafficTypeDiagnostic: DB7PR10MB1884:EE_
X-Microsoft-Antispam-PRVS: 
	<DB7PR10MB18842CE94E092C08036543F695349@DB7PR10MB1884.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xLaKBcoGhEdSHFMfd283DTBAlBFhp9rG1+YvLuxum61rf9aaZpdDiDhQ+HIIFuaBSqhFgNrhFhwgLFWTpJ90FzkV1WDXT2dVxlWehndYSf+oj/8+aWXvMYJ/BIDUffBKJA2h9IUTcS8TJK7PRVfVS+BE6WNk/5TJ1dqsBEcllhSwwcrQExxHzyjJHw1Cv931LyBKnar/pe8Ji1dOz9oCRbah9RG/V8q9mbcFWV+I54ceTKeu38AN6LM9yR/UiemgNswJjJ+fW3yoVFHA6B8yMl4HIvI25y5YPIdyQnhI6+a4IhyosYBL/B9wDIF04/IOM2F5OgBeJpaQAdXQZeYjPIfI8bJ8ZhnJk8oovkKPUL7IZrZcQ48KodJq3VybUj3rVLkEkjzrCAAZBV3m25p5pHSdCCGP8cGb3oCi6ok5BLEctu6iGACdPv9tNL7vlZ9bpxyjfb/t9D8qrMz9F7fd19Ms8mABkEAUmHlQxKkm/jle7aDMP/7ybihCsY9aThukJetnxeqbgPveXJ/R+cD1rpXHkbJpPYGdUU4kuIjV4iLFsxwBwmTzXHyG1/mOI8XMsSD6bCiodJAcfPk8XFc8PNXFNR1roGXMOzvzkLa0uJOVNbKRDtyWp+T5kWfEDiHjFBAdiSZ/iQ2N39L464WyBYpljRp919nNbGN45WMJ5sKHCVrBPbD+28UwLe70KXwN7DpuM4EAmMzCCTh9tq1R2bXXipMs7DDvdNE+nmK7S22E2inKCZUg8cml1yHlJU39Ob/X42VNThKwzH5zOUI+Eg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(40460700003)(86362001)(31696002)(6706004)(8676002)(16576012)(316002)(110136005)(31686004)(356005)(70586007)(36756003)(70206006)(81166007)(5660300002)(82960400001)(8936002)(508600001)(53546011)(336012)(186003)(26005)(83380400001)(36860700001)(16526019)(44832011)(956004)(82310400004)(47076005)(2906002)(2616005)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 16:17:03.0605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 752de45b-095a-4524-b095-08d9f09e9a24
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT034.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB1884
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Feb 2022 16:17:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7612

On 15.02.22 16:01, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This preparing isar-cip-core to integrate the upcomming ISAR features
> sstate and sbuild. Sbuild doesn't allow the extraction of build results.
> 
> sstate doesn't populate the deploy dir from packages in case of a rebuild.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v2:
>  - use distro_arch to determine binary name
>  - remove additional debug message
>  - remove deploydir
> 
>  kas/opt/efibootguard.yml                      |  1 +
>  .../efibootguard/efibootguard_0.9-git+isar.bb |  5 ----
>  .../files/debian/efibootguard.install         |  1 +
>  .../files/debian/efibootguard.links           |  1 +
>  .../wic/plugins/source/efibootguard-boot.py   |  3 +--
>  .../wic/plugins/source/efibootguard-efi.py    | 26 +++++++++----------
>  wic/qemu-amd64-efibootguard-secureboot.wks.in |  2 +-
>  7 files changed, 18 insertions(+), 21 deletions(-)
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
> index 9eb2353..cb3a37a 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> @@ -51,11 +51,13 @@ class EfibootguardEFIPlugin(SourcePlugin):
>          populate an EFI boot partition containing the EFI Boot Guard
>          bootloader binary.
>          """
> -        deploy_dir = get_bitbake_var("DEPLOY_DIR_IMAGE")
> -        creator.deploy_dir = deploy_dir
> -        bootloader_files = source_params.get("bootloader")
> +        distro_arch = get_bitbake_var("DISTRO_ARCH")
> +        # we need to map the distro_arch to uefi values
> +        if "amd64" in distro_arch:
> +            distro_arch = "x64"

How about ia32 and aarch64 (even if the debian package does not support
them yet)?

> +        bootloader_files = source_params.get("files")
>          if not bootloader_files:
> -            bootloader_files = "bootx64.efi"
> +            bootloader_files = "/usr/share/efibootguard/boot{}.efi".format(distro_arch)

Why making this configurable? Why making this a list? Do you see use
cases beyond current EBG releases and recipes already?

>          bootloader_files = bootloader_files.split(' ')
>          part_rootfs_dir = "%s/disk/%s.%s" % (cr_workdir,
>                                               part.label,
> @@ -63,18 +65,16 @@ class EfibootguardEFIPlugin(SourcePlugin):
>          create_dir_cmd = "install -d %s/EFI/BOOT" % part_rootfs_dir
>          exec_cmd(create_dir_cmd)
>  
> -        for bootloader in bootloader_files:
> -            signed_bootloader = cls._sign_file(bootloader,
> -                                               "{}/{}".format(deploy_dir,
> -                                                              bootloader
> -                                                              ),
> +        for bootloader_path in bootloader_files:
> +            name = os.path.basename(bootloader_path)
> +            signed_bootloader = cls._sign_file(name,
> +                                               bootloader_path,
>                                                 cr_workdir,
>                                                 source_params)
> -            # important the bootloader in deploy_dir is no longer signed
>              cp_cmd = "cp %s/%s %s/EFI/BOOT/%s" % (cr_workdir,
> -                                                signed_bootloader,
> -                                                part_rootfs_dir,
> -                                                bootloader)
> +                                                  signed_bootloader,
> +                                                  part_rootfs_dir,
> +                                                  name)
>              exec_cmd(cp_cmd, True)
>          du_cmd = "du --apparent-size -ks %s" % part_rootfs_dir
>          blocks = int(exec_cmd(du_cmd).split()[0])
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

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

