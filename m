Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636AFC433EF
	for <webhook@archiver.kernel.org>; Tue, 15 Feb 2022 09:47:11 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.7559.1644918429416640585
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Feb 2022 01:47:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=quirin.gylstorff@siemens.com header.s=fm1
 header.b=WTHnDkbE;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228,
 mailfrom: fm-51332-202202150947066a0a46edd6a03b187f-zb0awc@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 202202150947066a0a46edd6a03b187f
        for <cip-dev@lists.cip-project.org>;
        Tue, 15 Feb 2022 10:47:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=quirin.gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=/hVQdjjeACfMiWj+KT+CDPUduV10Hp/az83dMkcKQoI=;
 b=WTHnDkbEkczi+lYRHrtIWSuaev+PpOnWVyGgwWE4ReyNXLc9lna3jqYujc4ajaB+gp0gTu
 durTaJUInt+y91sgu8/Qsx/mpN8Kjsbjv+QtBK0H9KygVdfh0TFyOggJ0aVhGwfsBkR8VhBh
 3gfC/hjR8TKpz41f8blHSg+myL3vM=;
Message-ID: <3e70c777-f70d-ba4d-ef20-d95303df6101@siemens.com>
Date: Tue, 15 Feb 2022 10:47:04 +0100
MIME-Version: 1.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] swupdate: Add option to
 disable CONFIG_HASH_VERIFY
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20220214122805.262651-1-Quirin.Gylstorff@siemens.com>
 <2a427486-b758-c8a8-d7b2-7c53d82255e0@siemens.com>
From: quirin.gylstorff@siemens.com
Organization: Siemens
In-Reply-To: <2a427486-b758-c8a8-d7b2-7c53d82255e0@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Feb 2022 09:47:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7610



On 2/15/22 10:37, Jan Kiszka wrote:
> On 14.02.22 13:28, Quirin.Gylstorff@siemens.com wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This patch activate CONFIG_HASH_VERITY to ensure the integrity of the
>> swu binary. To ensure simple example builds the option can be disabled
>> by with the debian build profile `pkg.swupdate.nohashverify`.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>
>> Changes V2:
>>   - add missing patch description
>>
>>   ...onfig-Make-image-encryption-optional.patch |  2 +-
>>   .../0002-debian-rules-Add-CONFIG_MTD.patch    |  2 +-
>>   ...es-Add-option-to-disable-fs-creation.patch |  2 +-
>>   ...ules-Add-option-to-disable-webserver.patch |  2 +-
>>   ...Make-CONFIG_HW_COMPATIBILTY-optional.patch |  2 +-
>>   ...ules-Add-Embedded-Lua-handler-option.patch |  2 +-
>>   ...SWUpdate-USB-service-and-Udev-rules.patch} |  8 ++---
>>   ...option-to-disable-CONFIG_HASH_VERIFY.patch | 29 +++++++++++++++++++
>>   ...repare-build-for-isar-debian-buster.patch} |  6 ++--
>>   .../swupdate/swupdate_2021.11-1+debian-gbp.bb |  5 ++--
>>   10 files changed, 45 insertions(+), 15 deletions(-)
>>   rename recipes-core/swupdate/files/{0008-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch => 0007-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch} (89%)
>>   create mode 100644 recipes-core/swupdate/files/0008-Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch
>>   rename recipes-core/swupdate/files/{0007-debian-prepare-build-for-isar-debian-buster.patch => 0009-debian-prepare-build-for-isar-debian-buster.patch} (94%)
>>
>> diff --git a/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch b/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch
>> index 8b186e0..c501e42 100644
>> --- a/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch
>> +++ b/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch
>> @@ -1,7 +1,7 @@
>>   From 20bb45563fe8f3ec95ef22d715d1add014156543 Mon Sep 17 00:00:00 2001
>>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   Date: Wed, 29 Sep 2021 15:28:21 +0200
>> -Subject: [PATCH 1/8] debian/config: Make image encryption optional
>> +Subject: [PATCH 1/9] debian/config: Make image encryption optional
>>   
>>   This can be use to ease the setup with SWUpdate.
>>   
>> diff --git a/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch b/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
>> index eb5067d..50cf805 100644
>> --- a/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
>> +++ b/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
>> @@ -1,7 +1,7 @@
>>   From 1d52fe25e72f9e33525bca7efa5efe901cb32c65 Mon Sep 17 00:00:00 2001
>>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   Date: Wed, 29 Sep 2021 11:29:57 +0200
>> -Subject: [PATCH 2/8] debian/rules: Add CONFIG_MTD
>> +Subject: [PATCH 2/9] debian/rules: Add CONFIG_MTD
>>   
>>   if pkg.swupdate.bpo is set CONFIG_MTD is disable but not enabled.
>>   
>> diff --git a/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch b/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch
>> index 3671709..c5815cb 100644
>> --- a/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch
>> +++ b/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch
>> @@ -1,7 +1,7 @@
>>   From 8b6f01b6126933723963497d0db0c256e5251c5b Mon Sep 17 00:00:00 2001
>>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   Date: Mon, 4 Oct 2021 17:15:56 +0200
>> -Subject: [PATCH 3/8] debian/rules: Add option to disable fs creation
>> +Subject: [PATCH 3/9] debian/rules: Add option to disable fs creation
>>   
>>   Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   ---
>> diff --git a/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch b/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch
>> index 8fbb722..4a9076d 100644
>> --- a/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch
>> +++ b/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch
>> @@ -1,7 +1,7 @@
>>   From c1f46ecb2ac3aed3a711dec767321afa92b600d8 Mon Sep 17 00:00:00 2001
>>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   Date: Mon, 4 Oct 2021 17:27:11 +0200
>> -Subject: [PATCH 4/8] debian/rules: Add option to disable webserver
>> +Subject: [PATCH 4/9] debian/rules: Add option to disable webserver
>>   
>>   Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   ---
>> diff --git a/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch b/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
>> index 96443f2..87eba2c 100644
>> --- a/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
>> +++ b/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
>> @@ -1,7 +1,7 @@
>>   From ccc6f5d04aba0f1270f7d6b6de298b2084ad3bfd Mon Sep 17 00:00:00 2001
>>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   Date: Tue, 5 Oct 2021 10:56:25 +0200
>> -Subject: [PATCH 5/8] debian: Make CONFIG_HW_COMPATIBILTY optional
>> +Subject: [PATCH 5/9] debian: Make CONFIG_HW_COMPATIBILTY optional
>>   
>>   Add option for qemu.
>>   
>> diff --git a/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch b/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch
>> index 324f079..5d7543b 100644
>> --- a/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch
>> +++ b/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch
>> @@ -1,7 +1,7 @@
>>   From 7107052e6aa1a35a2900070797ac013d49814f0b Mon Sep 17 00:00:00 2001
>>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   Date: Wed, 29 Sep 2021 11:32:41 +0200
>> -Subject: [PATCH 6/8] debian/rules: Add Embedded Lua handler option
>> +Subject: [PATCH 6/9] debian/rules: Add Embedded Lua handler option
>>   
>>   Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   ---
>> diff --git a/recipes-core/swupdate/files/0008-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch b/recipes-core/swupdate/files/0007-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
>> similarity index 89%
>> rename from recipes-core/swupdate/files/0008-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
>> rename to recipes-core/swupdate/files/0007-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
>> index 3cce24b..2779d8b 100644
>> --- a/recipes-core/swupdate/files/0008-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
>> +++ b/recipes-core/swupdate/files/0007-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
>> @@ -1,7 +1,7 @@
>> -From 93b9a179119394395c72e62e59a73d29e9bba735 Mon Sep 17 00:00:00 2001
>> +From 625db939a1dec7d1aa6fbcb01c2c4cbd699bfe7b Mon Sep 17 00:00:00 2001
>>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   Date: Mon, 7 Feb 2022 09:28:39 +0100
>> -Subject: [PATCH 8/8] debian: Remove SWUpdate USB service and Udev rules
>> +Subject: [PATCH 7/9] debian: Remove SWUpdate USB service and Udev rules
>>   
>>   The current implementation will install an abitrary SWUpdate binary
>>   from a plug-in USB stick. This is a major security risk for devices
>> @@ -19,10 +19,10 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>    delete mode 100644 debian/swupdate.udev
>>   
>>   diff --git a/debian/rules b/debian/rules
>> -index e1c4a921..84ed55d4 100755
>> +index 12eb0ba5..76fce010 100755
>>   --- a/debian/rules
>>   +++ b/debian/rules
>> -@@ -103,7 +103,6 @@ override_dh_auto_install:
>> +@@ -101,7 +101,6 @@ override_dh_auto_install:
>>    override_dh_installsystemd:
>>    	dh_installsystemd --no-start
>>    	dh_installsystemd --name=swupdate-progress
>> diff --git a/recipes-core/swupdate/files/0008-Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch b/recipes-core/swupdate/files/0008-Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch
>> new file mode 100644
>> index 0000000..a7c5ee7
>> --- /dev/null
>> +++ b/recipes-core/swupdate/files/0008-Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch
>> @@ -0,0 +1,29 @@
>> +From cddd3472aad2d8e48d557705b82ffcc0c7d14a02 Mon Sep 17 00:00:00 2001
>> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +Date: Mon, 14 Feb 2022 12:27:43 +0100
>> +Subject: [PATCH 8/9] Add Profile option to disable CONFIG_HASH_VERIFY
>> +
>> +This change also enables CONFIG_HASH_VERIFY by default.
>> +
>> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +---
>> + debian/rules | 3 +++
>> + 1 file changed, 3 insertions(+)
>> +
>> +diff --git a/debian/rules b/debian/rules
>> +index 76fce010..4dc9e170 100755
>> +--- a/debian/rules
>> ++++ b/debian/rules
>> +@@ -42,6 +42,9 @@ endif
>> + ifneq (,$(filter pkg.swupdate.hwcompatibility,$(DEB_BUILD_PROFILES)))
>> + 	echo CONFIG_HW_COMPATIBILITY=y                   >> configs/debian_defconfig
>> + endif
>> ++ifeq (,$(filter pkg.swupdate.nohashverify,$(DEB_BUILD_PROFILES)))
>> ++	echo CONFIG_HASH_VERIFY=y                   >> configs/debian_defconfig
>> ++endif
>> + ifeq (,$(filter pkg.swupdate.nowebserver,$(DEB_BUILD_PROFILES)))
>> + 	echo CONFIG_WEBSERVER=y   >> configs/debian_defconfig
>> + 	echo CONFIG_MONGOOSESSL=y >> configs/debian_defconfig
>> +--
>> +2.34.1
>> +
>> diff --git a/recipes-core/swupdate/files/0007-debian-prepare-build-for-isar-debian-buster.patch b/recipes-core/swupdate/files/0009-debian-prepare-build-for-isar-debian-buster.patch
>> similarity index 94%
>> rename from recipes-core/swupdate/files/0007-debian-prepare-build-for-isar-debian-buster.patch
>> rename to recipes-core/swupdate/files/0009-debian-prepare-build-for-isar-debian-buster.patch
>> index 0b08f25..8afef74 100644
>> --- a/recipes-core/swupdate/files/0007-debian-prepare-build-for-isar-debian-buster.patch
>> +++ b/recipes-core/swupdate/files/0009-debian-prepare-build-for-isar-debian-buster.patch
>> @@ -1,7 +1,7 @@
>> -From 123190b2aa72818186ba12a04d793ff7d4244828 Mon Sep 17 00:00:00 2001
>> +From 5dda7f815dafdfbd1b187ccc912eca38e9aee7bb Mon Sep 17 00:00:00 2001
>>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   Date: Wed, 29 Sep 2021 16:17:03 +0200
>> -Subject: [PATCH 7/8] debian: prepare build for isar debian buster
>> +Subject: [PATCH 9/9] debian: prepare build for isar debian buster
>>   
>>   Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   ---
>> @@ -47,7 +47,7 @@ index 192c4a2a..9318fa12 100644
>>                   libebgenv-dev <pkg.swupdate.efibootguard> | efibootguard-dev <pkg.swupdate.efibootguard>,
>>                   libcmocka-dev,
>>   diff --git a/debian/rules b/debian/rules
>> -index 12eb0ba5..e1c4a921 100755
>> +index 4dc9e170..370ca3d8 100755
>>   --- a/debian/rules
>>   +++ b/debian/rules
>>   @@ -19,13 +19,15 @@ endif
>> diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>> index 2995d71..699dad3 100644
>> --- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>> +++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>> @@ -22,7 +22,8 @@ SRC_URI += "file://0001-debian-config-Make-image-encryption-optional.patch \
>>               file://0004-debian-rules-Add-option-to-disable-webserver.patch \
>>               file://0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch \
>>               file://0006-debian-rules-Add-Embedded-Lua-handler-option.patch \
>> -            file://0008-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch"
>> +            file://0007-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch \
>> +            file://0008-Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch"
>>   
>>   # end patching for dm-verity based images
>>   
>> @@ -38,7 +39,7 @@ SWUPDATE_BUILD_PROFILES += "cross nocheck"
>>   # SWUPDATE_BUILD_PROFILES += "pkg.swupdate.embeddedlua"
>>   
>>   # modify for debian buster build
>> -SRC_URI_append_buster = " file://0007-debian-prepare-build-for-isar-debian-buster.patch"
>> +SRC_URI_append_buster = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"
>>   
>>   # disable documentation due to missing packages
>>   SWUPDATE_BUILD_PROFILES_append = " nodoc "
> 
> Thanks, applied. I suspect you already sent the embedded patch to Debian
> as well, right?

Most of them - we still have the Embedded lua handler which will stay as 
it make no sense for upstream.

And as long as we support Buster - these patches will also stay.

> 
> Jan
> 
Quirin


