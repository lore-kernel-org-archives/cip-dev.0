Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E05C433EF
	for <webhook@archiver.kernel.org>; Fri, 18 Feb 2022 08:58:26 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.8725.1645174704591257854
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Feb 2022 00:58:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=quirin.gylstorff@siemens.com header.s=fm1
 header.b=eOP0WDh+;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-51332-20220218085821beb2d0e2ef4539d186-ymito0@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20220218085821beb2d0e2ef4539d186
        for <cip-dev@lists.cip-project.org>;
        Fri, 18 Feb 2022 09:58:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=quirin.gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=eyfxxG5nfDx9VyzdQV1WaXJ0QvCx69gTaQRstuC7Rjs=;
 b=eOP0WDh+f2f1Qc3GPB/vm9yUqWVZgOs/R8Gu63w62ao8wX2apsUL2e6hYHSAoxq4ZklU3U
 DuaulZ9iziRj3MKPG84skfcdCa3XRHpXIwDvg76icitoK9ZKGsArGacMsbtHf6QyZpglqQMm
 cV7wIJ1EjRurviLJawcrTm81Wuh8g=;
Message-ID: <6ea070e8-48a0-9a91-6b36-69c0b93ab4d1@siemens.com>
Date: Fri, 18 Feb 2022 09:58:18 +0100
MIME-Version: 1.0
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20220215150149.1748545-1-Quirin.Gylstorff@siemens.com>
 <3c48c8b1-7ced-1826-4ab7-1dba953f911e@siemens.com>
From: quirin.gylstorff@siemens.com
Organization: Siemens
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] efibootguard: Do not copy the
 efi binaries directly into DEPLOY_DIR
In-Reply-To: <3c48c8b1-7ced-1826-4ab7-1dba953f911e@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Feb 2022 08:58:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7631



On 2/15/22 17:17, Jan Kiszka wrote:
> On 15.02.22 16:01, Q. Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This preparing isar-cip-core to integrate the upcomming ISAR features
>> sstate and sbuild. Sbuild doesn't allow the extraction of build results.
>>
>> sstate doesn't populate the deploy dir from packages in case of a rebuild.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> Changes v2:
>>   - use distro_arch to determine binary name
>>   - remove additional debug message
>>   - remove deploydir
>>
>>   kas/opt/efibootguard.yml                      |  1 +
>>   .../efibootguard/efibootguard_0.9-git+isar.bb |  5 ----
>>   .../files/debian/efibootguard.install         |  1 +
>>   .../files/debian/efibootguard.links           |  1 +
>>   .../wic/plugins/source/efibootguard-boot.py   |  3 +--
>>   .../wic/plugins/source/efibootguard-efi.py    | 26 +++++++++----------
>>   wic/qemu-amd64-efibootguard-secureboot.wks.in |  2 +-
>>   7 files changed, 18 insertions(+), 21 deletions(-)
>>   create mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard.links
>>
>> diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
>> index 75d4ab1..f5f9169 100644
>> --- a/kas/opt/efibootguard.yml
>> +++ b/kas/opt/efibootguard.yml
>> @@ -21,6 +21,7 @@ local_conf_header:
>>       SWUPDATE_BOOTLOADER = "efibootguard"
>>   
>>     efibootguard-wic: |
>> +    WIC_IMAGER_INSTALL_append = " efibootguard"
>>       WDOG_TIMEOUT ?= "60"
>>       WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE"
>>       IMAGE_FSTYPES ?= "wic-img"
>> diff --git a/recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb b/recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb
>> index 2817e5b..171d8d4 100644
>> --- a/recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb
>> +++ b/recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb
>> @@ -39,8 +39,3 @@ do_prepare_build() {
>>       deb_add_changelog
>>   }
>>   
>> -dpkg_runbuild_append() {
>> -    install -m 0755 -d ${DEPLOY_DIR_IMAGE}
>> -    install -m 0755 ${S}/efibootguardx64.efi ${DEPLOY_DIR_IMAGE}/bootx64.efi
>> -    install -m 0755 ${S}/bg_setenv ${DEPLOY_DIR_IMAGE}/bg_setenv
>> -}
>> diff --git a/recipes-bsp/efibootguard/files/debian/efibootguard.install b/recipes-bsp/efibootguard/files/debian/efibootguard.install
>> index 8a8d9d3..0239953 100644
>> --- a/recipes-bsp/efibootguard/files/debian/efibootguard.install
>> +++ b/recipes-bsp/efibootguard/files/debian/efibootguard.install
>> @@ -1,2 +1,3 @@
>>   bg_setenv usr/bin
>>   bg_printenv usr/bin
>> +efibootguardx64.efi usr/share/efibootguard
>> diff --git a/recipes-bsp/efibootguard/files/debian/efibootguard.links b/recipes-bsp/efibootguard/files/debian/efibootguard.links
>> new file mode 100644
>> index 0000000..97bab21
>> --- /dev/null
>> +++ b/recipes-bsp/efibootguard/files/debian/efibootguard.links
>> @@ -0,0 +1 @@
>> +usr/share/efibootguard/efibootguardx64.efi usr/share/efibootguard/bootx64.efi
>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>> index 882729a..05cef4e 100644
>> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
>> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>> @@ -111,9 +111,8 @@ class EfibootguardBootPlugin(SourcePlugin):
>>   
>>           cwd = os.getcwd()
>>           os.chdir(part_rootfs_dir)
>> -        config_cmd = '%s/bg_setenv -f . -k "C:%s:%s" %s -r %s -w %s' \
>> +        config_cmd = '/usr/bin/bg_setenv -f . -k "C:%s:%s" %s -r %s -w %s' \
>>               % (
>> -                deploy_dir,
>>                   part.label.upper(),
>>                   boot_image,
>>                   '-a "%s"' % cmdline if cmdline else "",
>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>> index 9eb2353..cb3a37a 100644
>> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
>> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>> @@ -51,11 +51,13 @@ class EfibootguardEFIPlugin(SourcePlugin):
>>           populate an EFI boot partition containing the EFI Boot Guard
>>           bootloader binary.
>>           """
>> -        deploy_dir = get_bitbake_var("DEPLOY_DIR_IMAGE")
>> -        creator.deploy_dir = deploy_dir
>> -        bootloader_files = source_params.get("bootloader")
>> +        distro_arch = get_bitbake_var("DISTRO_ARCH")
>> +        # we need to map the distro_arch to uefi values
>> +        if "amd64" in distro_arch:
>> +            distro_arch = "x64"
> 
> How about ia32 and aarch64 (even if the debian package does not support
> them yet)?

I will add a dict for them.
> 
>> +        bootloader_files = source_params.get("files")
>>           if not bootloader_files:
>> -            bootloader_files = "bootx64.efi"
>> +            bootloader_files = "/usr/share/efibootguard/boot{}.efi".format(distro_arch)
> 
> Why making this configurable? Why making this a list? Do you see use
> cases beyond current EBG releases and recipes already?

I remember a downstream(internal) usecase which had multiple bootloaders 
added.
I will ask around.
> 
>>           bootloader_files = bootloader_files.split(' ')
>>           part_rootfs_dir = "%s/disk/%s.%s" % (cr_workdir,
>>                                                part.label,
>> @@ -63,18 +65,16 @@ class EfibootguardEFIPlugin(SourcePlugin):
>>           create_dir_cmd = "install -d %s/EFI/BOOT" % part_rootfs_dir
>>           exec_cmd(create_dir_cmd)
>>   
>> -        for bootloader in bootloader_files:
>> -            signed_bootloader = cls._sign_file(bootloader,
>> -                                               "{}/{}".format(deploy_dir,
>> -                                                              bootloader
>> -                                                              ),
>> +        for bootloader_path in bootloader_files:
>> +            name = os.path.basename(bootloader_path)
>> +            signed_bootloader = cls._sign_file(name,
>> +                                               bootloader_path,
>>                                                  cr_workdir,
>>                                                  source_params)
>> -            # important the bootloader in deploy_dir is no longer signed
>>               cp_cmd = "cp %s/%s %s/EFI/BOOT/%s" % (cr_workdir,
>> -                                                signed_bootloader,
>> -                                                part_rootfs_dir,
>> -                                                bootloader)
>> +                                                  signed_bootloader,
>> +                                                  part_rootfs_dir,
>> +                                                  name)
>>               exec_cmd(cp_cmd, True)
>>           du_cmd = "du --apparent-size -ks %s" % part_rootfs_dir
>>           blocks = int(exec_cmd(du_cmd).split()[0])
>> diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
>> index 81fd4fe..72a6f8c 100644
>> --- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
>> +++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
>> @@ -1,5 +1,5 @@
>>   # EFI partition containing efibootguard bootloader binary
>> -part --source efibootguard-efi  --ondisk sda --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --sourceparams "signwith=/usr/bin/sign_secure_image.sh"
>> +include ebg-signed-bootloader.inc
>>   
>>   # EFI Boot Guard environment/config partitions plus Kernel files
>>   part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,unified-kernel=y,signwith=/usr/bin/sign_secure_image.sh"
> 
> Jan
> 

Quirin

