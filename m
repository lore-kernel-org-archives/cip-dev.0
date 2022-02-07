Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8DDC433F5
	for <webhook@archiver.kernel.org>; Mon,  7 Feb 2022 09:27:18 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web12.20274.1644226036848238131
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Feb 2022 01:27:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=quirin.gylstorff@siemens.com header.s=fm1
 header.b=l2ruQRjI;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226,
 mailfrom: fm-51332-20220207092713b632882c56718d0afd-u2xaea@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 20220207092713b632882c56718d0afd
        for <cip-dev@lists.cip-project.org>;
        Mon, 07 Feb 2022 10:27:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=quirin.gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=ZHWzzoU/mQlkjmfxaXnipMg1E7lUC5gxIFQtOxhaDpk=;
 b=l2ruQRjIjqncnCd6CtFsIWv5z6ehR/pkONzYpbewSYbz5+HbRu0+RgRa+DDPFhljhpjp+v
 qt+r+amrr4PUMKnxLNPtTZcYegIZZlNqkxg5o20UhJQnL7TPF+B+p9xlr1JH+Jg1G3SDwmNH
 3NdMMXQSbXCVbolDZjxYV0r7nBbkE=;
Message-ID: <3c18d47a-dad2-349d-847f-ce315cea36ce@siemens.com>
Date: Mon, 7 Feb 2022 10:27:12 +0100
MIME-Version: 1.0
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate: Remove usb.service
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20220207091752.190490-1-Quirin.Gylstorff@siemens.com>
 <04b70079-b02d-b81e-5598-1c874702f813@siemens.com>
From: quirin.gylstorff@siemens.com
Organization: Siemens
In-Reply-To: <04b70079-b02d-b81e-5598-1c874702f813@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Feb 2022 09:27:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7579



On 2/7/22 10:22, Jan Kiszka wrote:
> On 07.02.22 10:17, Q. Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Upstream adds an udev-rules and systemd service to install a swu from
>> a plug-in USB stick.
>>
>> If the signing of the SWUpdate binary is deactivated
>> (current default in isar-cip-core) this service allows the installation
>> of a abitrary SWUpdate binary from a plug-in USB stick.
>>
>> Remove the installation and the files from the debian folder to
>> deactivate the possibility to install from USB.
>>
>> Reported-by: Lisicki, Raphael <raphael.lisicki@siemens.com>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   ...onfig-Make-image-encryption-optional.patch |  2 +-
>>   .../0002-debian-rules-Add-CONFIG_MTD.patch    |  2 +-
>>   ...es-Add-option-to-disable-fs-creation.patch |  2 +-
>>   ...ules-Add-option-to-disable-webserver.patch |  2 +-
>>   ...Make-CONFIG_HW_COMPATIBILTY-optional.patch |  2 +-
>>   ...ules-Add-Embedded-Lua-handler-option.patch |  2 +-
>>   ...prepare-build-for-isar-debian-buster.patch |  2 +-
>>   ...-SWUpdate-USB-service-and-Udev-rules.patch | 57 +++++++++++++++++++
>>   .../swupdate/swupdate_2021.11-1+debian-gbp.bb |  3 +-
>>   9 files changed, 66 insertions(+), 8 deletions(-)
>>   create mode 100644 recipes-core/swupdate/files/0008-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
>>
>> diff --git a/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch b/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch
>> index c07b103..8b186e0 100644
>> --- a/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch
>> +++ b/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch
>> @@ -1,7 +1,7 @@
>>   From 20bb45563fe8f3ec95ef22d715d1add014156543 Mon Sep 17 00:00:00 2001
>>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   Date: Wed, 29 Sep 2021 15:28:21 +0200
>> -Subject: [PATCH 1/7] debian/config: Make image encryption optional
>> +Subject: [PATCH 1/8] debian/config: Make image encryption optional
>>   
>>   This can be use to ease the setup with SWUpdate.
>>   
>> diff --git a/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch b/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
>> index 8ebd09e..eb5067d 100644
>> --- a/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
>> +++ b/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
>> @@ -1,7 +1,7 @@
>>   From 1d52fe25e72f9e33525bca7efa5efe901cb32c65 Mon Sep 17 00:00:00 2001
>>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   Date: Wed, 29 Sep 2021 11:29:57 +0200
>> -Subject: [PATCH 2/7] debian/rules: Add CONFIG_MTD
>> +Subject: [PATCH 2/8] debian/rules: Add CONFIG_MTD
>>   
>>   if pkg.swupdate.bpo is set CONFIG_MTD is disable but not enabled.
>>   
>> diff --git a/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch b/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch
>> index 876e164..3671709 100644
>> --- a/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch
>> +++ b/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch
>> @@ -1,7 +1,7 @@
>>   From 8b6f01b6126933723963497d0db0c256e5251c5b Mon Sep 17 00:00:00 2001
>>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   Date: Mon, 4 Oct 2021 17:15:56 +0200
>> -Subject: [PATCH 3/7] debian/rules: Add option to disable fs creation
>> +Subject: [PATCH 3/8] debian/rules: Add option to disable fs creation
>>   
>>   Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   ---
>> diff --git a/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch b/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch
>> index 66e48e6..8fbb722 100644
>> --- a/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch
>> +++ b/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch
>> @@ -1,7 +1,7 @@
>>   From c1f46ecb2ac3aed3a711dec767321afa92b600d8 Mon Sep 17 00:00:00 2001
>>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   Date: Mon, 4 Oct 2021 17:27:11 +0200
>> -Subject: [PATCH 4/7] debian/rules: Add option to disable webserver
>> +Subject: [PATCH 4/8] debian/rules: Add option to disable webserver
>>   
>>   Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   ---
>> diff --git a/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch b/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
>> index 4cca3bf..96443f2 100644
>> --- a/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
>> +++ b/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
>> @@ -1,7 +1,7 @@
>>   From ccc6f5d04aba0f1270f7d6b6de298b2084ad3bfd Mon Sep 17 00:00:00 2001
>>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   Date: Tue, 5 Oct 2021 10:56:25 +0200
>> -Subject: [PATCH 5/7] debian: Make CONFIG_HW_COMPATIBILTY optional
>> +Subject: [PATCH 5/8] debian: Make CONFIG_HW_COMPATIBILTY optional
>>   
>>   Add option for qemu.
>>   
>> diff --git a/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch b/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch
>> index 447f6ad..324f079 100644
>> --- a/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch
>> +++ b/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch
>> @@ -1,7 +1,7 @@
>>   From 7107052e6aa1a35a2900070797ac013d49814f0b Mon Sep 17 00:00:00 2001
>>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   Date: Wed, 29 Sep 2021 11:32:41 +0200
>> -Subject: [PATCH 6/7] debian/rules: Add Embedded Lua handler option
>> +Subject: [PATCH 6/8] debian/rules: Add Embedded Lua handler option
>>   
>>   Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   ---
>> diff --git a/recipes-core/swupdate/files/0007-debian-prepare-build-for-isar-debian-buster.patch b/recipes-core/swupdate/files/0007-debian-prepare-build-for-isar-debian-buster.patch
>> index 3ff4ca9..0b08f25 100644
>> --- a/recipes-core/swupdate/files/0007-debian-prepare-build-for-isar-debian-buster.patch
>> +++ b/recipes-core/swupdate/files/0007-debian-prepare-build-for-isar-debian-buster.patch
>> @@ -1,7 +1,7 @@
>>   From 123190b2aa72818186ba12a04d793ff7d4244828 Mon Sep 17 00:00:00 2001
>>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   Date: Wed, 29 Sep 2021 16:17:03 +0200
>> -Subject: [PATCH 7/7] debian: prepare build for isar debian buster
>> +Subject: [PATCH 7/8] debian: prepare build for isar debian buster
>>   
>>   Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   ---
>> diff --git a/recipes-core/swupdate/files/0008-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch b/recipes-core/swupdate/files/0008-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
>> new file mode 100644
>> index 0000000..3cce24b
>> --- /dev/null
>> +++ b/recipes-core/swupdate/files/0008-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
>> @@ -0,0 +1,57 @@
>> +From 93b9a179119394395c72e62e59a73d29e9bba735 Mon Sep 17 00:00:00 2001
>> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +Date: Mon, 7 Feb 2022 09:28:39 +0100
>> +Subject: [PATCH 8/8] debian: Remove SWUpdate USB service and Udev rules
>> +
>> +The current implementation will install an abitrary SWUpdate binary
>> +from a plug-in USB stick. This is a major security risk for devices
>> +using the SWUpdate package from Debian.
>> +
>> +Remove the installation and the files from the debian folder.
>> +
>> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +---
>> + debian/rules                          | 1 -
>> + debian/swupdate.swupdate-usb@.service | 8 --------
>> + debian/swupdate.udev                  | 2 --
>> + 3 files changed, 11 deletions(-)
>> + delete mode 100644 debian/swupdate.swupdate-usb@.service
>> + delete mode 100644 debian/swupdate.udev
>> +
>> +diff --git a/debian/rules b/debian/rules
>> +index e1c4a921..84ed55d4 100755
>> +--- a/debian/rules
>> ++++ b/debian/rules
>> +@@ -103,7 +103,6 @@ override_dh_auto_install:
>> + override_dh_installsystemd:
>> + 	dh_installsystemd --no-start
>> + 	dh_installsystemd --name=swupdate-progress
>> +-	dh_installsystemd --no-start --name=swupdate-usb@
>> +
>> + ifeq (,$(filter pkg.swupdate.bpo,$(DEB_BUILD_PROFILES)))
>> + override_dh_gencontrol:
>> +diff --git a/debian/swupdate.swupdate-usb@.service b/debian/swupdate.swupdate-usb@.service
>> +deleted file mode 100644
>> +index eda9d153..00000000
>> +--- a/debian/swupdate.swupdate-usb@.service
>> ++++ /dev/null
>> +@@ -1,8 +0,0 @@
>> +-[Unit]
>> +-Description=usb media swupdate service
>> +-Requires=swupdate-progress.service
>> +-
>> +-[Service]
>> +-ExecStartPre=/bin/mount /dev/%I /mnt
>> +-ExecStart=/bin/sh -c "swupdate-client -v /mnt/*.swu"
>> +-ExecStopPost=/bin/umount /mnt
>> +diff --git a/debian/swupdate.udev b/debian/swupdate.udev
>> +deleted file mode 100644
>> +index b4efd0b7..00000000
>> +--- a/debian/swupdate.udev
>> ++++ /dev/null
>> +@@ -1,2 +0,0 @@
>> +-ACTION=="add", KERNEL=="sd*", SUBSYSTEM=="block", ENV{ID_BUS}=="usb", ENV{ID_FS_USAGE}=="filesystem", TAG+="systemd", ENV{SYSTEMD_WANTS}+="swupdate-usb@%k.service"
>> +-
>> +--
>> +2.34.1
>> +
>> diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>> index 48a6cc1..2995d71 100644
>> --- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>> +++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>> @@ -21,7 +21,8 @@ SRC_URI += "file://0001-debian-config-Make-image-encryption-optional.patch \
>>               file://0003-debian-rules-Add-option-to-disable-fs-creation.patch \
>>               file://0004-debian-rules-Add-option-to-disable-webserver.patch \
>>               file://0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch \
>> -            file://0006-debian-rules-Add-Embedded-Lua-handler-option.patch"
>> +            file://0006-debian-rules-Add-Embedded-Lua-handler-option.patch \
>> +            file://0008-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch"
>>   
>>   # end patching for dm-verity based images
>>   
> 
> Thanks, applied to next as quick-fix.
> 
> Wouldn't it be more useful to make this configurable (opt-in via
> /etc/something on the device), possibly also in Debian?
> 
> Jan
> 
I currently looking into it to make it configurable in upstream.
I will also try to add a warning to the upstream build.


Quirin


