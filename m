Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2531C4332F
	for <webhook@archiver.kernel.org>; Tue, 15 Feb 2022 09:04:05 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.51])
 by mx.groups.io with SMTP id smtpd.web09.7405.1644915843056951315
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Feb 2022 01:04:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tTx+IRi+;
 spf=pass (domain: siemens.com, ip: 40.107.21.51,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpFtdEsozZJ3w8tnJ2+iugUAd0ZVDucMivljxSxGH+6wvb+1TLRSyEoJmjOf2HTBbrNY03hkZBRPvR2dOC6yd2P2aYr1MO/32aKvVyJKIalmfkDUr5V3JRA7qY3vwKo2LnX5gSN0R9gdLDhKZ/y1554hzzcJebST8pg8SOVrsiADW5p7cSn32znYOLY69exAINfAgDYCTbnnkA66DV0TtX2tf0lL8KzM3d6jYpxjyZ5QpQfI7vSseiB8Ucgk4itqX0xEcXvkWpe00LIKaSlalcihLtlMqr9uBRLj5XGR66E/vlYfwirJkBBnfLYQjWUTQ/Nzf6TeUSsZidaLWYvDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akFdqwjI71J/tjWUVJhdb+8r1UYV0njrRHCfNmGZCwI=;
 b=bec8QBFwiRMkYsTneomdgFvifd2TIaHk2noRTkx//SfqtvnANNuyX9DPAhjTSrubjax0O/I79IGE0uvOnVD1hvZDZRlelbi3V4G0Phzcz0qYfAIbN6AZ//QFjVjGz/c5XAIqE+AP3VXqYGk9PYmofLlGjR2rSmGOeOvtPLMIJHtn3SONDpPqbzJggG08NzEpFl/Lcxy8qJqiCdGEZTQML30uh5qtr617rvVbjlxRBU8lmlMkHd+ORYvZDumg/uq4wYJlcIWPyZ4V/UlCXoclvgPECcvFK8wsTQe7NItgsRASBal6QOtQZBDg60hMrxawROy53bFl14QVRRo+MjgvSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akFdqwjI71J/tjWUVJhdb+8r1UYV0njrRHCfNmGZCwI=;
 b=tTx+IRi+u58sClXtxPldHYnN5BJpwLGWftMeBkNKxB7ot0/cpUq6W0t2GsSjZOBuwz2MiFf5nVqEjol3a5nDmhTe3p4RFbYJKx8eLVXaPiOVyLCC0qOe7zl+B5UL5WJIInA0qf+kYyLCGXyMm0aEGxgMMwjmsjgrU1Xxs9lr4a1IyKUmuOpW+XBlW0VulXdWR9bPZsjIHNEOZNVqThosFKaAd6M5O+p+gUhy3RZEIJgohrcgby/DfejphFQtFyc2Xg96bdOaN8lvIELse6bfzX1kA/jfe4UTBxGx9o5ET5y6xLMyPhVZgVXf8gagIFSUkx5ExkRndeci3mz5k2aJUA==
Received: from AM5PR1001CA0072.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::49) by AM9PR10MB4989.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 09:03:59 +0000
Received: from VE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:206:15:cafe::68) by AM5PR1001CA0072.outlook.office365.com
 (2603:10a6:206:15::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Tue, 15 Feb 2022 09:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT059.mail.protection.outlook.com (10.152.3.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 09:03:58 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 15 Feb 2022 10:03:58 +0100
Received: from [167.87.0.44] (167.87.0.44) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 10:03:58 +0100
Message-ID: <7373c515-9a68-5595-69e3-3c755dca02d1@siemens.com>
Date: Tue, 15 Feb 2022 10:03:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [cip-dev][isar-cip-core][PATCH] efibootguard: Do not copy the efi
 binaries directly into DEPLOY_DIR
Content-Language: en-US
To: <Quirin.Gylstorff@siemens.com>, <cip-dev@lists.cip-project.org>,
	<ubely@ilbers.de>
References: <20220214162458.636845-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220214162458.636845-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.44]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 307c5117-98ae-4814-b497-08d9f0621a57
X-MS-TrafficTypeDiagnostic: AM9PR10MB4989:EE_
X-Microsoft-Antispam-PRVS: 
	<AM9PR10MB4989DA27B95FD5E7B503954595349@AM9PR10MB4989.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DS8vsgUWI52vxAX6aPMFt/BsM9W3h2RQ+lv994dY0fzHSbPWML1z4DoZNEM8kHnZbRDZHInRq2dRvLW/gPkR9CulrWdxcXMZwtMxIT1nqLaZyZlr0MhPs4/QkMBJWHr8Gr5Q0yI4Gksrushd/NgRN+lGIj/wX9dtxXgtON3dQmzrUUWI+rwF/p0yjntsI/yKK93ZCamS9aF4fOliUcuoVSJuHm5a50v0FJepBaEjz2wrJZmuW4owN6NUp3JFI/pWinf6bRU/oWd1Q0N0T/61+8S5oA2rbwdH9ulpEkXRgtzVrxMQFqG6VGIpKERI3v/Pt7tVP5l3dFbkIC+bg3qlAtPTbf8kQ7ch9jsiwiEWqm8c3raDm++vFh6XrtTNjv5GzfaizXQrJGgVknhxEHppsZZdHQtgrUydCqxlz256pIeprBk5rw34md3HBXz17cPZ1D1LdfqZSUqnTk0Y2S2WGKlTGRe5KhZrd6PfAWNoo0Z9cGCp7pWEyes0MByc8Gb6vnmwDSpwdOGgjBMtnjDcPoG0ycftJ4ypmuiXmSjCJ2CyWPCo+cg6dDztKJq8T7RbLOrio5bABQf8Syo2Q7CqhBYsFLMHtMPh5ctq3wilO9y2+TsWc7zeUOKAr1ni2+mpOk9xbcWpBjhY2ZzsDjj4gmPBIvhs+kbKKWnfIrzEfQjXhefl6UEi6Ilg7c0Rwv+pp/fN87BsfhTnLJjgI6Z+qUNMSxnI1ajgpFVJVsRsRF29Y9HCkv6WL6AMKS9MHln5BJ8eCbiRZy7upFOlEOuC+Q==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(508600001)(16526019)(8936002)(44832011)(53546011)(5660300002)(8676002)(86362001)(70206006)(70586007)(6666004)(26005)(186003)(336012)(2616005)(40460700003)(31696002)(2906002)(82310400004)(956004)(356005)(47076005)(82960400001)(36860700001)(81166007)(83380400001)(110136005)(31686004)(316002)(6706004)(36756003)(16576012)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 09:03:58.8583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 307c5117-98ae-4814-b497-08d9f0621a57
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4989
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Feb 2022 09:04:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7607

On 14.02.22 17:24, Quirin.Gylstorff@siemens.com wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows a rebuild with sstate after `build/tmp` was removed.
> 
> This patch makes efibootguardx64.efi binary to be included in .deb package.
> 
> Also bg_setenv and efibootguardx64.efi are now used from the wic build change root.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  kas/opt/efibootguard.yml                      |  1 +
>  .../efibootguard/efibootguard_0.9-git+isar.bb |  5 -----
>  .../files/debian/efibootguard.install         |  1 +
>  .../files/debian/efibootguard.links           |  1 +
>  .../wic/plugins/source/efibootguard-boot.py   |  3 +--
>  .../wic/plugins/source/efibootguard-efi.py    | 22 ++++++++++---------
>  wic/ebg-signed-bootloader.inc                 |  2 +-
>  wic/ebg-sysparts.inc                          |  2 +-
>  wic/qemu-amd64-efibootguard-secureboot.wks.in |  2 +-
>  9 files changed, 19 insertions(+), 20 deletions(-)
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
> index 9eb2353..613a350 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> @@ -53,9 +53,9 @@ class EfibootguardEFIPlugin(SourcePlugin):
>          """
>          deploy_dir = get_bitbake_var("DEPLOY_DIR_IMAGE")
>          creator.deploy_dir = deploy_dir
> -        bootloader_files = source_params.get("bootloader")
> +        bootloader_files = source_params.get("files")
>          if not bootloader_files:
> -            bootloader_files = "bootx64.efi"
> +            bootloader_files = "{}/bootx64.efi".format(deploy_dir)

DEPLOY_DIR is no longer used now.

Also, why do we need a parameter here? It's about the Isar way of
installing the Isar-built EBG binary. All we need is to probe the target
architecture. IIRC, we already run over that arch, thus can derive the
right bootXXX.efi name from that.

>          bootloader_files = bootloader_files.split(' ')
>          part_rootfs_dir = "%s/disk/%s.%s" % (cr_workdir,
>                                               part.label,
> @@ -63,18 +63,19 @@ class EfibootguardEFIPlugin(SourcePlugin):
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
> +            msger.debug("Copy %s to %s",
> +                        signed_bootloader, part_rootfs_dir)
>              # important the bootloader in deploy_dir is no longer signed
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
> @@ -113,6 +114,7 @@ class EfibootguardEFIPlugin(SourcePlugin):
>      def _sign_file(cls, name, signee, cr_workdir, source_params):
>          sign_script = source_params.get("signwith")
>          if sign_script and os.path.exists(sign_script):
> +            msger.debug("Sign %s to %s", name, cr_workdir)

Intentional addition or debug left-over?

>              work_name = name.replace(".efi", ".signed.efi")
>              sign_cmd = "{sign_script} {signee} \
>              {cr_workdir}/{work_name}".format(sign_script=sign_script,
> diff --git a/wic/ebg-signed-bootloader.inc b/wic/ebg-signed-bootloader.inc
> index 667e014..2fd5c0e 100644
> --- a/wic/ebg-signed-bootloader.inc
> +++ b/wic/ebg-signed-bootloader.inc
> @@ -1,2 +1,2 @@
>  # EFI partition containing efibootguard bootloader binary
> -part --source efibootguard-efi  --ondisk sda --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --sourceparams "signwith=/usr/bin/sign_secure_image.sh"
> +part --source efibootguard-efi  --ondisk sda --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --sourceparams "files=/usr/share/efibootguard/bootx64.efi,signwith=/usr/bin/sign_secure_image.sh"
> diff --git a/wic/ebg-sysparts.inc b/wic/ebg-sysparts.inc
> index dea99e8..18c8508 100644
> --- a/wic/ebg-sysparts.inc
> +++ b/wic/ebg-sysparts.inc
> @@ -1,7 +1,7 @@
>  # default partition layout EFI Boot Guard usage
>  
>  # EFI partition containing efibootguard bootloader binary
> -part --source efibootguard-efi  --ondisk sda --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active
> +part --source efibootguard-efi  --ondisk sda --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --sourceparams "files=/usr/share/efibootguard/bootx64.efi"
>  
>  # EFI Boot Guard environment/config partitions plus Kernel files
>  part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,root=PARTUUID:fedcba98-7654-3210-cafe-5e0710000001"
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

Nice cleanup, but I suspect we can clean even more :)

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

