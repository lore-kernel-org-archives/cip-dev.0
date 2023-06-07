Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23850C77B7A
	for <webhook@archiver.kernel.org>; Wed,  7 Jun 2023 02:32:19 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
 by mx.groups.io with SMTP id smtpd.web11.360.1686105026884999019
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 19:30:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@163.com header.s=s110527 header.b=ogJGmyGY;
 spf=pass (domain: 163.com, ip: 220.181.12.216, mailfrom: baocheng_su@163.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=n1r7JSju8aVJ/TK1xgH9lnmaIHXc3m8LzQTzzuKYfRs=;
	b=ogJGmyGYkka3bcDj2FkDRg9foa6UNeY3FQMJdfbgcLmBSf+faQpAChqzMHPD09
	rN+TUxWSuIpmlIOOTsT2WuV/xwxzwtb44dTpoU7U6V4aDrPGJOqaBqlbz6JAfgA3
	FfM2Ge81zQwdKdhsAnrZ7yZBHN6tYCdWIHG8W4vsspdhM=
Received: from [192.168.11.55] (unknown [171.221.26.215])
	by zwqz-smtp-mta-g1-1 (Coremail) with SMTP id _____wCnjka8639ksMnCBg--.26944S2;
	Wed, 07 Jun 2023 10:30:21 +0800 (CST)
Message-ID: <781c9d35-110b-67c4-9331-f2b55f28e73e@163.com>
Date: Wed, 7 Jun 2023 10:30:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [isar-cip-core][PATCH v2 1/2] Add recipe for optee-client
To: Jan Kiszka <jan.kiszka@siemens.com>,
 "Su, Bao Cheng (DI FA CTR IPC CN PRC4)" <baocheng.su@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "MOESSBAUER, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>
Cc: "Storm, Christian (T CED SES-DE)" <christian.storm@siemens.com>,
 "Gylstorff, Quirin (T CED SES-DE)" <quirin.gylstorff@siemens.com>
References: <20230606035506.10354-1-baocheng_su@163.com>
 <20230606035506.10354-2-baocheng_su@163.com>
 <15c4bbac-145e-f826-9c48-778531a1a403@siemens.com>
 <36fc108fed304bcfca50fd11656ecb0fef79f09f.camel@siemens.com>
 <bcbddc6b-0058-8c04-303b-82b1f16dbb57@siemens.com>
From: Su Baocheng <baocheng_su@163.com>
In-Reply-To: <bcbddc6b-0058-8c04-303b-82b1f16dbb57@siemens.com>
X-CM-TRANSID: _____wCnjka8639ksMnCBg--.26944S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AF13Gr4xGr18KF47Xr4kCrg_yoWfCw4fpr
	y5CF43Ars5Jr17WwsFg3ZxWrZ3tw48Arn5XrnFgw1UArn2vFn7KF4UKF15CFZaqr1xAw12
	qr1qqayxWr15ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UnXoxUUUUU=
X-Originating-IP: [171.221.26.215]
X-CM-SenderInfo: pedrux5hqjs2rx6rljoofrz/1tbiLB+HJ1sph4a4YwAAs7
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jun 2023 02:32:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11902



On 2023/6/6 18:29, Jan Kiszka wrote:
> On 06.06.23 12:24, Su, Bao Cheng (DI FA CTR IPC CN PRC4) wrote:
>> On Tue, 2023-06-06 at 07:37 +0200, Jan Kiszka wrote:
>>> On 06.06.23 05:55, baocheng_su@163.com wrote:
>>>> From: Baocheng Su <baocheng.su@siemens.com>
>>>>
>>>> This brings the libteec1, optee-client-dev and most important,
>>>> tee-supplicant.
>>>>
>>>> Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
>>>> ---
>>>>   recipes-bsp/optee-client/files/control.tmpl   | 51
>>>> +++++++++++++++++++
>>>>   recipes-bsp/optee-client/files/rules.tmpl     | 20 ++++++++
>>>>   .../optee-client/files/tee-supplicant.service |  9 ++++
>>>>   .../optee-client/optee-client_3.20.0.bb       | 47
>>>> +++++++++++++++++
>>>>   4 files changed, 127 insertions(+)
>>>>   create mode 100644 recipes-bsp/optee-client/files/control.tmpl
>>>>   create mode 100755 recipes-bsp/optee-client/files/rules.tmpl
>>>>   create mode 100644 recipes-bsp/optee-client/files/tee-
>>>> supplicant.service
>>>>   create mode 100644 recipes-bsp/optee-client/optee-client_3.20.0.bb
>>>>
>>>> diff --git a/recipes-bsp/optee-client/files/control.tmpl b/recipes-
>>>> bsp/optee-client/files/control.tmpl
>>>> new file mode 100644
>>>> index 0000000..b0c3756
>>>> --- /dev/null
>>>> +++ b/recipes-bsp/optee-client/files/control.tmpl
>>>> @@ -0,0 +1,51 @@
>>>> +Source: optee-client
>>>> +Priority: optional
>>>> +Maintainer: Unknown maintainer <unknown@example.com>
>>>> +Build-Depends: pkg-config, uuid-dev
>>>> +Standards-Version: 4.1.3
>>>> +Section: libs
>>>> +Homepage:
>>>> https://github.com/OP-TEE/optee_client
>>>> +Rules-Requires-Root: no
>>>> +
>>>> +Package: optee-client-dev
>>>> +Section: libdevel
>>>> +Architecture: arm64
>>>> +Multi-Arch: same
>>>> +Depends: libteec1 (= ${binary:Version}),
>>>> +         ${misc:Depends}
>>>> +Description: normal world user space client APIs for OP-TEE
>>>> (development)
>>>> + OP-TEE is a Trusted Execution Environment (TEE) designed as
>>>> companion to a
>>>> + non-secure Linux kernel running on Arm; Cortex-A cores using the
>>>> TrustZone
>>>> + technology. OP-TEE implements TEE Internal Core API v1.1.x which
>>>> is the API
>>>> + exposed to Trusted Applications and the TEE Client API v1.0,
>>>> which is the
>>>> + API describing how to communicate with a TEE. This package
>>>> provides the TEE
>>>> + Client API library.
>>>> + .
>>>> + This package contains the development files OpTEE Client API
>>>> +
>>>> +Package: libteec1
>>>> +Architecture: arm64
>>>> +Multi-Arch: same
>>>> +Depends: ${misc:Depends}, ${shlibs:Depends}
>>>> +Description: normal world user space client APIs for OP-TEE
>>>> + OP-TEE is a Trusted Execution Environment (TEE) designed as
>>>> companion to a
>>>> + non-secure Linux kernel running on Arm; Cortex-A cores using the
>>>> TrustZone
>>>> + technology. OP-TEE implements TEE Internal Core API v1.1.x which
>>>> is the API
>>>> + exposed to Trusted Applications and the TEE Client API v1.0,
>>>> which is the
>>>> + API describing how to communicate with a TEE. This package
>>>> provides the TEE
>>>> + Client API library.
>>>> + .
>>>> + This package contains libteec library.
>>>> +
>>>> +Package: tee-supplicant
>>>> +Architecture: arm64
>>>> +Depends: ${misc:Depends}, ${shlibs:Depends}
>>>> +Description: normal world user space client APIs for OP-TEE
>>>> + OP-TEE is a Trusted Execution Environment (TEE) designed as
>>>> companion to a
>>>> + non-secure Linux kernel running on Arm; Cortex-A cores using the
>>>> TrustZone
>>>> + technology. OP-TEE implements TEE Internal Core API v1.1.x which
>>>> is the API
>>>> + exposed to Trusted Applications and the TEE Client API v1.0,
>>>> which is the
>>>> + API describing how to communicate with a TEE. This package
>>>> provides the TEE
>>>> + Client API library.
>>>> + .
>>>> + This package contains tee-supplicant executable.
>>>> diff --git a/recipes-bsp/optee-client/files/rules.tmpl b/recipes-
>>>> bsp/optee-client/files/rules.tmpl
>>>> new file mode 100755
>>>> index 0000000..a8f2afd
>>>> --- /dev/null
>>>> +++ b/recipes-bsp/optee-client/files/rules.tmpl
>>>> @@ -0,0 +1,20 @@
>>>> +#!/usr/bin/make -f
>>>> +
>>>> +ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
>>>> +export CROSS_COMPILE=$(DEB_HOST_GNU_TYPE)-
>>>> +endif
>>>> +
>>>> +%:
>>>> +       dh $@ --exclude=.a
>>>> +
>>>> +override_dh_auto_build:
>>>> +       dh_auto_build -- LIBDIR=/usr/lib/$(DEB_HOST_MULTIARCH) \
>>>> +               CFG_TEE_FS_PARENT_PATH=${TEE_FS_PARENT_PATH}
>>>> ${RPMB_EMU_BUILD_OPT}
>>>> +
>>>> +override_dh_auto_install:
>>>> +       dh_auto_install -- LIBDIR=/usr/lib/$(DEB_HOST_MULTIARCH) \
>>>> +               CFG_TEE_FS_PARENT_PATH=${TEE_FS_PARENT_PATH}
>>>> ${RPMB_EMU_BUILD_OPT}
>>>> +
>>>> +override_dh_auto_clean:
>>>> +       dh_auto_clean
>>>> +       rm -rf $(CURDIR)/out
>>>> diff --git a/recipes-bsp/optee-client/files/tee-supplicant.service
>>>> b/recipes-bsp/optee-client/files/tee-supplicant.service
>>>> new file mode 100644
>>>> index 0000000..7148515
>>>> --- /dev/null
>>>> +++ b/recipes-bsp/optee-client/files/tee-supplicant.service
>>>> @@ -0,0 +1,9 @@
>>>> +[Unit]
>>>> +Description=TEE Supplicant
>>>> +
>>>> +[Service]
>>>> +Type=simple
>>>> +ExecStart=/usr/sbin/tee-supplicant
>>>> +
>>>> +[Install]
>>>> +WantedBy=multi-user.target
>>>> diff --git a/recipes-bsp/optee-client/optee-client_3.20.0.bb
>>>> b/recipes-bsp/optee-client/optee-client_3.20.0.bb
>>>> new file mode 100644
>>>> index 0000000..b760a2c
>>>> --- /dev/null
>>>> +++ b/recipes-bsp/optee-client/optee-client_3.20.0.bb
>>>> @@ -0,0 +1,47 @@
>>>> +#
>>>> +# CIP Core, generic profile
>>>> +#
>>>> +# Copyright (c) Siemens AG, 2023
>>>> +#
>>>> +# Authors:
>>>> +#  Su Bao Cheng <baocheng.su@siemens.com>
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>> +
>>>> +inherit dpkg
>>>> +
>>>> +DESCRIPTION = "OPTee Client"
>>>> +
>>>> +PROVIDES = "libteec1 optee-client-dev tee-supplicant"
>>>> +
>>>> +SRC_URI +=
>>>> "https://
>>>> github.com%2FOP-
>>>> TEE%2Foptee_client%2Farchive%2F%24&data=05%7C01%7Cbaocheng.su%40ad0
>>>> 11.siemens.com%7C4165545a244e4709dbe608db66500fee%7C38ae3bcd95794fd
>>>> 4addab42e1495d55a%7C1%7C0%7C638216266262554942%7CUnknown%7CTWFpbGZs
>>>> b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
>>>> %3D%7C3000%7C%7C%7C&sdata=wpVB2SbJ1kQ2znZPG62J9EvJd7C4Bk%2FQT1EsqAi
>>>> E%2FVY%3D&reserved=0{PV}.tar.gz;downloadfilename=optee_client-
>>>> ${PV}.tar.gz \
>>>> +    file://control.tmpl \
>>>> +    file://rules.tmpl \
>>>> +    file://tee-supplicant.service"
>>>> +SRC_URI[sha256sum] =
>>>> "69414c424b8dbed11ce1ae0d812817eda2ef4f42a1bef762e5ca3b6fed80764c"
>>>> +
>>>> +S = "${WORKDIR}/optee_client-${PV}"
>>>> +
>>>> +TEE_FS_PARENT_PATH ?= "/var/lib/optee-client/data/tee"
>>>> +# To use the builtin RPMB emulation, empty this
>>>> +RPMB_EMU_BUILD_OPT ?= "RPMB_EMU=0"
>>>> +
>>>> +TEMPLATE_FILES = "rules.tmpl control.tmpl"
>>>> +TEMPLATE_VARS += "TEE_FS_PARENT_PATH RPMB_EMU_BUILD_OPT"
>>>> +
>>>> +do_prepare_build[cleandirs] += "${S}/debian"
>>>> +do_prepare_build() {
>>>> +    deb_debianize
>>>> +
>>>> +    cp -f ${WORKDIR}/tee-supplicant.service \
>>>> +        ${S}/debian/tee-supplicant.service
>>>> +    echo "/usr/sbin/*" > ${S}/debian/tee-supplicant.install
>>>> +    echo "lib/optee_armtz/" > ${S}/debian/tee-supplicant.dirs
>>>> +    echo "usr/lib/tee-supplicant/plugins/" >> ${S}/debian/tee-
>>>> supplicant.dirs
>>>> +
>>>> +    echo "usr/lib/*/libteec*.so.*" > ${S}/debian/libteec1.install
>>>> +
>>>> +    echo "usr/include/*" > ${S}/debian/optee-client-dev.install
>>>> +    echo "usr/lib/*/lib*.so" >> ${S}/debian/optee-client-
>>>> dev.install
>>>> +}
>>>
>>> Looks like optee-client is part of bookworm, but version 3.19.0 only.
>>> Latest is 3.21.0. Please make sure we aren't colliding.
>>>
>>
>> That is a point, I will test it from my side.
>>
>>> And did you use the official debianization? If not, please do.
>>>
>>
>> I borrowed something from the official debianization when I was writing
>> it.
>>
>> Or should we use the `apt://${PN}` and add our modification on top?
>> That may bind us to the 3.19 version for a pretty long time.
> 
> Check is some salsa branch is holding what you need, maybe even already
> 3.21.0. Otherwise, it would be nice to contribute and pull again from
> there, at least midterm.
> 

No salsa repo for this optee-client. The patch and the debian files are 
hosted on https://packages.debian.org/source/bookworm/optee-client 
directly. And the latest version is still 3.19 on it.

> And, as we just realized during your private discussion about [1], we
> likely also need a separate initrd hook for tee-supplicant to ensure
> that this service is running before systemd mounts efivarfs.
> 
> Jan
> 
> [1]
> https://lore.kernel.org/lkml/4ff09002-e871-38b9-43ec-227a64bac731@siemens.com/T/#u
> 


