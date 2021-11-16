Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA182C433F5
	for <webhook@archiver.kernel.org>; Tue, 16 Nov 2021 10:43:09 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web08.8199.1637059384465894505
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Nov 2021 02:43:05 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AGAh1CM001112
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Tue, 16 Nov 2021 11:43:01 +0100
Received: from [167.87.1.223] ([167.87.1.223])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AGAh1b8003635;
	Tue, 16 Nov 2021 11:43:01 +0100
Subject: Re: [cip-dev][isar-cip-core][RFC 3/8] linux-cip-common: Add options
 necessary for dm-verity
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20211112115017.401779-1-Quirin.Gylstorff@siemens.com>
 <20211112115017.401779-5-Quirin.Gylstorff@siemens.com>
 <3d36e221-8750-39da-0774-e5bf3bbcc17d@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
Message-ID: <8a704de1-d76e-6bb5-edc3-bb6a3fa0da7b@siemens.com>
Date: Tue, 16 Nov 2021 11:43:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <3d36e221-8750-39da-0774-e5bf3bbcc17d@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Nov 2021 10:43:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6925



On 11/12/21 1:46 PM, Jan Kiszka wrote:
> On 12.11.21 12:50, Q. Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> CIP Kernel Config does not contain support for dm-verity
>> squashfs. Overlay_FS support is added for etc-overlay.
>>
> 
> This should be quickly addressed by expanding the configs of all boards
> we want to enable this way. Start with QEMU and the IPCs. Otherwise, we
> risk to ignore this subsystem /wrt CVEs.

I send a patch series for qemu and ipc to the mailing list.

Quirin
> 
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   recipes-kernel/linux/files/verity.cfg     | 5 +++++
>>   recipes-kernel/linux/linux-cip-common.inc | 6 ++++++
>>   2 files changed, 11 insertions(+)
>>   create mode 100644 recipes-kernel/linux/files/verity.cfg
>>
>> diff --git a/recipes-kernel/linux/files/verity.cfg b/recipes-kernel/linux/files/verity.cfg
>> new file mode 100644
>> index 0000000..35d8208
>> --- /dev/null
>> +++ b/recipes-kernel/linux/files/verity.cfg
>> @@ -0,0 +1,5 @@
>> +CONFIG_BLK_DEV_DM=y
>> +CONFIG_DM_VERITY=y
>> +CONFIG_DM_CRYPT=y
>> +CONFIG_SQUASHFS=y
>> +CONFIG_OVERLAY_FS=y
>> diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
>> index 1afec88..0792371 100644
>> --- a/recipes-kernel/linux/linux-cip-common.inc
>> +++ b/recipes-kernel/linux/linux-cip-common.inc
>> @@ -28,3 +28,9 @@ SRC_URI_append_bbb = "file://${KERNEL_DEFCONFIG}"
>>   SRCREV_cip-kernel-config ?= "cd5d43e99f4d5f20707d7ac1e721bb22d4c9e16e"
>>   
>>   S = "${WORKDIR}/linux-cip-v${PV}"
>> +
>> +SRC_URI += "file://verity.cfg"
>> +
>> +do_prepare_build_prepend() {
>> +    cat ${WORKDIR}/verity.cfg >> ${WORKDIR}/${KERNEL_DEFCONFIG}
>> +}
>>
> 
> This should be appended conditionally, when building a secure image, I
> would say.
> 
> Jan
> 


