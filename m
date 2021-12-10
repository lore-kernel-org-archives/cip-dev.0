Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD39C433EF
	for <webhook@archiver.kernel.org>; Fri, 10 Dec 2021 10:38:47 +0000 (UTC)
Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web08.5521.1639132723735603283
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Dec 2021 02:38:44 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.39, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 1BAAcfe6029819
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 10 Dec 2021 11:38:41 +0100
Received: from [139.22.39.231] ([139.22.39.231])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1BAAce1O002842;
	Fri, 10 Dec 2021 11:38:40 +0100
Message-ID: <32192e47-078d-ddf5-35d4-68ca7d197616@siemens.com>
Date: Fri, 10 Dec 2021 11:38:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20211210093448.1860864-1-Quirin.Gylstorff@siemens.com>
 <c482fbfe-53b4-5d80-c84f-914343e224e5@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
Subject: Re: [cip-dev][isar-cip-core][PATCH] conf/machine/*: Add variable to
 set version of kernel defconfig
In-Reply-To: <c482fbfe-53b4-5d80-c84f-914343e224e5@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Dec 2021 10:38:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7086



On 12/10/21 10:58, Jan Kiszka wrote:
> On 10.12.21 10:34, Q. Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This fixes an issue, that the defconfig from kernel 4.19.X does not
>> work with kernel 5.10.X. The kernel boots but cannot find any qemu hard
>> disk.
>>
>> The fix adds the new Variable
>> KERNEL_DEFCONFIG_VERSION to select to correct path in [1].
>>
>> This fixes issue [17].
>>
>> [1]: https://gitlab.com/cip-project/cip-kernel/cip-kernel-config
>> [17]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/17
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   conf/machine/hihope-rzg2m.conf    | 3 ++-
>>   conf/machine/qemu-amd64.conf      | 3 ++-
>>   conf/machine/qemu-arm.conf        | 3 ++-
>>   conf/machine/qemu-arm64.conf      | 3 ++-
>>   conf/machine/simatic-ipc227e.conf | 3 ++-
>>   kas/opt/4.19.yml                  | 2 ++
>>   kas/opt/4.4.yml                   | 2 ++
>>   kas/opt/5.10.yml                  | 2 ++
>>   8 files changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-rzg2m.conf
>> index 4f4ee81..74f03df 100644
>> --- a/conf/machine/hihope-rzg2m.conf
>> +++ b/conf/machine/hihope-rzg2m.conf
>> @@ -13,7 +13,8 @@ DISTRO_ARCH = "arm64"
>>   
>>   IMAGE_TYPE ?= "wic-img"
>>   
>> -KERNEL_DEFCONFIG = "cip-kernel-config/4.19.y-cip/arm64/renesas_defconfig"
>> +KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
> 
> This variable must be set by the kernel recipe, not the machine.
> 
> Jan

Ok, my reasoning was that I want the variable near it usage for 
readability. It is only used when the KERNEL_DEFCONFIG is from [1].

Quirin

[1]: https://gitlab.com/cip-project/cip-kernel/cip-kernel-config

> 
>> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/renesas_defconfig"
>>   USE_CIP_KERNEL_CONFIG = "1"
>>   DTB_FILES = "r8a774a1-hihope-rzg2m-ex.dtb"
>>   IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILES}"
>> diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
>> index c90d957..af20bf4 100644
>> --- a/conf/machine/qemu-amd64.conf
>> +++ b/conf/machine/qemu-amd64.conf
>> @@ -10,4 +10,5 @@ DISTRO_ARCH = "amd64"
>>   
>>   IMAGE_TYPE ?= "ext4-img"
>>   USE_CIP_KERNEL_CONFIG = "1"
>> -KERNEL_DEFCONFIG = "cip-kernel-config/4.19.y-cip/x86/cip_qemu_defconfig"
>> +KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
>> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_qemu_defconfig"
>> diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
>> index 81a22c1..f9e665d 100644
>> --- a/conf/machine/qemu-arm.conf
>> +++ b/conf/machine/qemu-arm.conf
>> @@ -11,4 +11,5 @@ DISTRO_ARCH = "armhf"
>>   
>>   IMAGE_TYPE ?= "ext4-img"
>>   USE_CIP_KERNEL_CONFIG = "1"
>> -KERNEL_DEFCONFIG ?= "cip-kernel-config/4.19.y-cip/arm/qemu_arm_defconfig"
>> +KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
>> +KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/qemu_arm_defconfig"
>> diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
>> index eb34703..1a48093 100644
>> --- a/conf/machine/qemu-arm64.conf
>> +++ b/conf/machine/qemu-arm64.conf
>> @@ -10,4 +10,5 @@ DISTRO_ARCH = "arm64"
>>   
>>   IMAGE_TYPE ?= "ext4-img"
>>   USE_CIP_KERNEL_CONFIG = "1"
>> -KERNEL_DEFCONFIG ?= "cip-kernel-config/4.19.y-cip/arm64/qemu_arm64_defconfig"
>> +KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
>> +KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/qemu_arm64_defconfig"
>> diff --git a/conf/machine/simatic-ipc227e.conf b/conf/machine/simatic-ipc227e.conf
>> index 3c9638f..d8c7fec 100644
>> --- a/conf/machine/simatic-ipc227e.conf
>> +++ b/conf/machine/simatic-ipc227e.conf
>> @@ -11,4 +11,5 @@ DISTRO_ARCH = "amd64"
>>   IMAGE_TYPE ?= "wic-img"
>>   IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
>>   USE_CIP_KERNEL_CONFIG = "1"
>> -KERNEL_DEFCONFIG = "cip-kernel-config/4.19.y-cip/x86/siemens_ipc227e_defconfig"
>> +KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
>> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/siemens_ipc227e_defconfig"
>> diff --git a/kas/opt/4.19.yml b/kas/opt/4.19.yml
>> index 5ff1683..581ea93 100644
>> --- a/kas/opt/4.19.yml
>> +++ b/kas/opt/4.19.yml
>> @@ -16,3 +16,5 @@ local_conf_header:
>>     kernel-version: |
>>       PREFERRED_VERSION_linux-cip = "4.19.%"
>>       PREFERRED_VERSION_linux-cip-rt = "4.19.%"
>> +  defconfig: |
>> +    KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
>> diff --git a/kas/opt/4.4.yml b/kas/opt/4.4.yml
>> index 65a4775..dae1b52 100644
>> --- a/kas/opt/4.4.yml
>> +++ b/kas/opt/4.4.yml
>> @@ -16,3 +16,5 @@ local_conf_header:
>>     kernel-version: |
>>       PREFERRED_VERSION_linux-cip = "4.4.%"
>>       PREFERRED_VERSION_linux-cip-rt = "4.4.%"
>> +  defconfig: |
>> +    KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
>> diff --git a/kas/opt/5.10.yml b/kas/opt/5.10.yml
>> index 612b7f9..e048450 100644
>> --- a/kas/opt/5.10.yml
>> +++ b/kas/opt/5.10.yml
>> @@ -16,3 +16,5 @@ local_conf_header:
>>     kernel-version: |
>>       PREFERRED_VERSION_linux-cip = "5.10.%"
>>       PREFERRED_VERSION_linux-cip-rt = "5.10.%"
>> +  defconfig: |
>> +    KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
>>
> 

-- 




With best regards,
Quirin Gylstorff

Siemens AG
Technology
Research in Digitalization and Automation
Smart Embedded Systems
T RDA IOT SES-DE
Otto-Hahn-Ring 6
81739 Muenchen, Germany
Mobile: +49 173 3746683
mailto:quirin.gylstorff@siemens.com <mailto:quirin.gylstorff@siemens.com>
www.siemens.com <https://siemens.com>

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim
Hagemann Snabe; Managing Board: Roland Busch, Chairman, President and
Chief Executive Officer; Cedrik Neike, Matthias Rebellius, Ralf P.
Thomas, Judith Wiese; Registered offices: Berlin and Munich, Germany;
Commercial registries: Berlin-Charlottenburg, HRB 12300, Munich, HRB
6684; WEEE-Reg.-No. DE 23691322

Important notice: This e-mail and any attachment thereof contain
corporate proprietary information. If you have received it by mistake,
please notify us immediately by reply e-mail and delete this e-mail and
its attachments from your system. Thank you.




