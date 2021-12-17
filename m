Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C82DC433F5
	for <webhook@archiver.kernel.org>; Fri, 17 Dec 2021 14:09:00 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web08.6507.1639750138800502495
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Dec 2021 06:08:59 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1BHE8u44005604
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 17 Dec 2021 15:08:56 +0100
Received: from [139.22.39.215] ([139.22.39.215])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 1BHE8tI8006413;
	Fri, 17 Dec 2021 15:08:55 +0100
Message-ID: <3eea5ccc-9af9-a21f-20fa-d58660619c9f@siemens.com>
Date: Fri, 17 Dec 2021 15:08:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [cip-dev][isar-cip-core][PATCH] Make read-only rootfs a inc file
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20211217135015.1189442-1-Quirin.Gylstorff@siemens.com>
 <21aa70ad-9ffe-aee2-0883-ca6baee66626@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <21aa70ad-9ffe-aee2-0883-ca6baee66626@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Dec 2021 14:09:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7179



On 12/17/21 14:53, Jan Kiszka wrote:
> On 17.12.21 14:50, Q. Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This allows downstream recipes to include the kas option
>> and use the include as base without recreating some parts
>> of the recipes.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   kas/opt/ebg-secure-boot-snakeoil.yml                  |  4 ++--
>>   recipes-core/images/cip-core-image.bb                 |  3 ++-
>>   .../{cip-core-image-read-only.bb => read-only.inc}    | 11 ++++++++++-
>>   .../initramfs-verity-hook_0.1.bb                      |  2 +-
>>   start-qemu.sh                                         |  3 ---
>>   5 files changed, 15 insertions(+), 8 deletions(-)
>>   rename recipes-core/images/{cip-core-image-read-only.bb => read-only.inc} (78%)
>>
>> diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
>> index 1cfbacc..807b0d7 100644
>> --- a/kas/opt/ebg-secure-boot-snakeoil.yml
>> +++ b/kas/opt/ebg-secure-boot-snakeoil.yml
>> @@ -14,16 +14,16 @@ header:
>>     includes:
>>      - kas/opt/ebg-secure-boot-base.yml
>>   
>> -target: cip-core-image-read-only
>>   
>>   local_conf_header:
>> +  image-options: |
>> +    CIP_IMAGE_OPTIONS += "read-only.inc"
>>     swupdate: |
>>       IMAGE_INSTALL_append = " swupdate"
>>       IMAGE_INSTALL_append = " swupdate-handler-roundrobin"
>>   
>>     verity-img: |
>>       SECURE_IMAGE_FSTYPE = "squashfs"
>> -    VERITY_IMAGE_RECIPE = "cip-core-image-read-only"
>>       IMAGE_TYPE = "secure-swupdate-img"
>>       WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
>>   
>> diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
>> index 2cecde3..9bf21ff 100644
>> --- a/recipes-core/images/cip-core-image.bb
>> +++ b/recipes-core/images/cip-core-image.bb
>> @@ -18,4 +18,5 @@ IMAGE_INSTALL += "customizations"
>>   
>>   # for swupdate
>>   SWU_DESCRIPTION ??= "swupdate"
>> -include ${SWU_DESCRIPTION}.inc
>> +CIP_IMAGE_OPTIONS ?= "${SWU_DESCRIPTION}.inc"
>> +include ${CIP_IMAGE_OPTIONS}
> 
> Is just
> 
> include
> 
> an valid bitbake statement? I think this is what will happen when
> CIP_IMAGE_OPTIONS is empty, right?

It should not fail according to [1] and my testing.

[1]: 
https://www.yoctoproject.org/docs/1.6/bitbake-user-manual/bitbake-user-manual.html#include-directive

Quirin

> 
>> diff --git a/recipes-core/images/cip-core-image-read-only.bb b/recipes-core/images/read-only.inc
>> similarity index 78%
>> rename from recipes-core/images/cip-core-image-read-only.bb
>> rename to recipes-core/images/read-only.inc
>> index 79cd6bf..604caa0 100644
>> --- a/recipes-core/images/cip-core-image-read-only.bb
>> +++ b/recipes-core/images/read-only.inc
>> @@ -1,4 +1,13 @@
>> -require cip-core-image.bb
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2021
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <Quriin.Gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>   
>>   SQUASHFS_EXCLUDE_DIRS += "home var"
>>   
>> diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
>> index a7fbf5a..f0d2d68 100644
>> --- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
>> +++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
>> @@ -24,7 +24,7 @@ TEMPLATE_VARS += "VERITY_BEHAVIOR_ON_CORRUPTION"
>>   
>>   DEBIAN_DEPENDS = "initramfs-tools, cryptsetup"
>>   
>> -VERITY_IMAGE_RECIPE ?= "cip-core-image-read-only"
>> +VERITY_IMAGE_RECIPE ?= "cip-core-image"
>>   
>>   VERITY_ENV_FILE = "${DEPLOY_DIR_IMAGE}/${VERITY_IMAGE_RECIPE}-${DISTRO}-${MACHINE}.verity.env"
>>   
>> diff --git a/start-qemu.sh b/start-qemu.sh
>> index 4ab3861..24df490 100755
>> --- a/start-qemu.sh
>> +++ b/start-qemu.sh
>> @@ -45,9 +45,6 @@ if [ -z "${TARGET_IMAGE}" ];then
>>   	if grep -s -q "IMAGE_SECURITY: true" .config.yaml; then
>>   		TARGET_IMAGE="cip-core-image-security"
>>   	fi
>> -	if [ -n "${SECURE_BOOT}" ]; then
>> -		TARGET_IMAGE="cip-core-image-read-only"
>> -	fi
>>   fi
>>   
>>   case "$1" in
>>
> 
> Otherwise, helpful cleanup.
> 
> Jan
> 


