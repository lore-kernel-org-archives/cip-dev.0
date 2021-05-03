Return-Path: <SRS0=q/IR=J6=lists.cip-project.org=bounce+64572+6413+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B99FC433B4
	for <cip-dev@archiver.kernel.org>; Mon,  3 May 2021 11:28:24 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A96610E6
	for <cip-dev@archiver.kernel.org>; Mon,  3 May 2021 11:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A96610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6413+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id DI3lYY4521723xkgQIGLhQpo; Mon, 03 May 2021 04:28:22 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web09.32146.1620041301952649500
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 May 2021 04:28:22 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 143BSGTu016285
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 3 May 2021 13:28:17 +0200
X-Received: from [167.87.38.194] ([167.87.38.194])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 143BSGJw002038;
	Mon, 3 May 2021 13:28:16 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] swupdate-config: add prefix to variables
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20210430122020.13407-1-Quirin.Gylstorff@siemens.com>
 <20210430130134.22257-1-Quirin.Gylstorff@siemens.com>
 <d8c95cb7-58ae-9947-8975-3bfe227aef8e@siemens.com>
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
Message-ID: <ec1332f7-6c1f-180c-7842-7f1ab9c15e11@siemens.com>
Date: Mon, 3 May 2021 13:28:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <d8c95cb7-58ae-9947-8975-3bfe227aef8e@siemens.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Po7yjzRPGVupgrSBbn7YYaGIx4520388AA=
Content-Type: multipart/mixed; boundary="plwMbvciPyOzywPGOvcs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620041302;
 bh=y162T7VKSBaectgGoIQHF0jBVkV3LZOt3r1nN9v3/AY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=U9pKoHLtLfl7Z2tj6Jl+0IWPjxmivHyeNxZH+lGckXbWgAU8tkoS/i04AyazE9ScDX/
 Kp+bnM7Sjx2+PWK24uQF78kzST/ayisCfoXYMxYjRIveXHhpxBlSJAHfc8rAPKL2XS3sY
 veh8OXZbl+5sKYgnzn7+sTElds/Bs3Tk7Nw=

--plwMbvciPyOzywPGOvcs
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 4/30/21 4:50 PM, Jan Kiszka wrote:
> On 30.04.21 15:01, Q. Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> The variables U_BOOT and BOOTLOADER are only used for swupdate.
>> Add the prefix SWUPDATE to indicate the intended usage.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> Changes in V2:
>>   - fix typo in commit message
>>   - use variable in kas/opt/*.yml
>>
>>   classes/swupdate-config.bbclass      | 10 +++++-----
>>   kas/opt/ebg-secure-boot-snakeoil.yml |  2 +-
>>   kas/opt/ebg-swu.yml                  |  4 ++--
>>   kas/opt/qemu-swupdate.yml            |  2 +-
>>   4 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/classes/swupdate-config.bbclass b/classes/swupdate-config.bbclass
>> index 9909113..0c1067a 100644
>> --- a/classes/swupdate-config.bbclass
>> +++ b/classes/swupdate-config.bbclass
>> @@ -51,13 +51,13 @@ KFEATURE_u-boot[BUILD_DEB_DEPENDS] = "libubootenv-dev"
>>   KFEATURE_u-boot[DEBIAN_DEPENDS] = "${@ 'libubootenv0.1, u-boot-${MACHINE}-config' \
>>                                             if d.getVar("USE_U_BOOT_CONFIG", True) == "true" \
>>                                             else 'libubootenv0.1'}"
>> -KFEATURE_u-boot[DEPENDS] = "${U_BOOT} libubootenv"
>> +KFEATURE_u-boot[DEPENDS] = "${SWUPDATE_U_BOOT} libubootenv"
> 
> Still leaves me and probably other users clueless what SWUPDATE_U_BOOT
> should be. Simply "u-boot-${MACHINE}"?
> 
> Jan
> 

SWUPDATE_U_BOOT should be the name of the u-boot package.

In case the layer (e.g. isar-cip-core) supplies the u-boot binary, 
`SWUPDATE_U_BOOT` should be defined as `u-boot-${MACHINE}`.


Debian provides some as package, e.g. [1].


I could add `u-boot-${MACHINE}` as default and a README section.


[1]: https://packages.debian.org/buster/u-boot-imx

Quirin

>>   KFEATURE_u-boot[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_u-boot.snippet"
>>   
>>   SWUPDATE_LUASCRIPT ?= "swupdate_handlers.lua"
>>   
>>   def get_bootloader_featureset(d):
>> -    bootloader = d.getVar("BOOTLOADER", True) or ""
>> +    bootloader = d.getVar("SWUPDATE_BOOTLOADER", True) or ""
>>       if bootloader == "efibootguard":
>>           return "efibootguard"
>>       if bootloader == "u-boot":
>> @@ -68,11 +68,11 @@ SWUPDATE_KFEATURES ??= ""
>>   KFEATURES = "${SWUPDATE_KFEATURES}"
>>   KFEATURES += "${@get_bootloader_featureset(d)}"
>>   
>> -# Astonishingly, as an anonymous python function, BOOTLOADER is always None
>> +# Astonishingly, as an anonymous python function, SWUPDATE_BOOTLOADER is always None
>>   # one time before it gets set. So the following must be a task.
>>   python do_check_bootloader () {
>> -    bootloader = d.getVar("BOOTLOADER", True) or "None"
>> +    bootloader = d.getVar("SWUPDATE_BOOTLOADER", True) or "None"
>>       if not bootloader in ["efibootguard", "u-boot"]:
>> -        bb.warn("swupdate: BOOTLOADER set to incompatible value: " + bootloader)
>> +        bb.warn("swupdate: SWUPDATE_BOOTLOADER set to incompatible value: " + bootloader)
>>   }
>>   addtask check_bootloader before do_fetch
>> diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
>> index 8a72084..c0ed1a2 100644
>> --- a/kas/opt/ebg-secure-boot-snakeoil.yml
>> +++ b/kas/opt/ebg-secure-boot-snakeoil.yml
>> @@ -20,7 +20,7 @@ local_conf_header:
>>       # Add snakeoil and ovmf binaries for qemu
>>       IMAGER_BUILD_DEPS += "ebg-secure-boot-snakeoil ovmf-binaries"
>>       IMAGER_INSTALL += "ebg-secure-boot-snakeoil"
>> -    WKS_FILE = "${MACHINE}-${BOOTLOADER}-secureboot.wks"
>> +    WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks"
>>   
>>     ovmf: |
>>       # snakeoil certs are only part of backports
>> diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
>> index aa3aed1..63dda09 100644
>> --- a/kas/opt/ebg-swu.yml
>> +++ b/kas/opt/ebg-swu.yml
>> @@ -15,7 +15,7 @@ header:
>>   local_conf_header:
>>     swupdate: |
>>       IMAGE_INSTALL_append = " swupdate efibootguard"
>> -    BOOTLOADER = "efibootguard"
>> +    SWUPDATE_BOOTLOADER = "efibootguard"
>>   
>>     efibootguard: |
>>       WDOG_TIMEOUT = "0"
>> @@ -23,4 +23,4 @@ local_conf_header:
>>   
>>     wic: |
>>       IMAGE_TYPE = "wic-swu-img"
>> -    WKS_FILE ?= "${MACHINE}-${BOOTLOADER}.wks"
>> +    WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
>> diff --git a/kas/opt/qemu-swupdate.yml b/kas/opt/qemu-swupdate.yml
>> index 3f5fedf..daebd2c 100644
>> --- a/kas/opt/qemu-swupdate.yml
>> +++ b/kas/opt/qemu-swupdate.yml
>> @@ -16,4 +16,4 @@ header:
>>   local_conf_header:
>>     qemu-wic: |
>>       IMAGE_TYPE ?= "wic-swu-img"
>> -    WKS_FILE = "qemu-amd64-${BOOTLOADER}.wks"
>> +    WKS_FILE = "qemu-amd64-${SWUPDATE_BOOTLOADER}.wks"
>>
> 

--plwMbvciPyOzywPGOvcs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6413): https://lists.cip-project.org/g/cip-dev/message=
/6413
Mute This Topic: https://lists.cip-project.org/mt/82480672/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--plwMbvciPyOzywPGOvcs--
