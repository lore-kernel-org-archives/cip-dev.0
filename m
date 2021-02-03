Return-Path: <SRS0=HE+9=HF=lists.cip-project.org=bounce+64572+6160+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA660C433DB
	for <cip-dev@archiver.kernel.org>; Wed,  3 Feb 2021 08:14:03 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05C2964F69
	for <cip-dev@archiver.kernel.org>; Wed,  3 Feb 2021 08:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C2964F69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6160+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id tO3xYY4521723xIZIsXCBorR; Wed, 03 Feb 2021 00:14:02 -0800
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web12.6525.1612340041264572821
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Feb 2021 00:14:01 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1138Dwbw007995
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 3 Feb 2021 09:13:58 +0100
X-Received: from [167.87.48.237] ([167.87.48.237])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1138Dvp3018610;
	Wed, 3 Feb 2021 09:13:58 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/2] secure-boot: Move image-uuid to own file
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20210201162425.31726-1-Quirin.Gylstorff@siemens.com>
 <20210201162425.31726-3-Quirin.Gylstorff@siemens.com>
 <9c928bf2-092b-a032-d981-b84850ce4249@siemens.com>
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
Message-ID: <12726656-327d-0891-c04b-1fae5e1e1951@siemens.com>
Date: Wed, 3 Feb 2021 09:13:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <9c928bf2-092b-a032-d981-b84850ce4249@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: mxRyNKqDu8vLrY5htRMvDQbUx4520388AA=
Content-Type: multipart/mixed; boundary="OIiHCT0WOtTG77LEGmLX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1612340042;
 bh=EOUGw1h+n7WF0O2RuLez4St0Fc3L1L/7CSLGGylmt4U=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=XYlzcmLRgxQrZPUjhUz8ev/5TKgckbXlZBgk+ThbQ79ZpSolQZdKRvTUV5Yc3i1FanG
 1VjvEJFFCDDpLauM5BLOjpx0+KzvFAc6JeyFse6ZwuPbp92ndzKuHhM5a4obQWWXpbp+/
 9ZBf64/XbagfmYzq6tJmwTuMJLoJQcREPEY=

--OIiHCT0WOtTG77LEGmLX
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 2/1/21 5:47 PM, Jan Kiszka wrote:
> On 01.02.21 17:24, Q. Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> /etc/os-release is controlled by the Debian Package base-files
>> and will be silently overwritten if the package updates the file.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   classes/image_uuid.bbclass                                  | 4 +---
>>   .../initramfs-config/files/initramfs.image_uuid.hook        | 6 +++---
>>   .../initramfs-config/files/secure-boot-debian-local-patch   | 4 ++--
>>   3 files changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
>> index 2813ed9..a0ab202 100644
>> --- a/classes/image_uuid.bbclass
>> +++ b/classes/image_uuid.bbclass
>> @@ -22,9 +22,7 @@ IMAGE_UUID ?= "${@generate_image_uuid(d)}"
>>   do_generate_image_uuid[vardeps] += "IMAGE_UUID"
>>   do_generate_image_uuid[depends] = "buildchroot-target:do_build"
>>   do_generate_image_uuid() {
>> -    sudo sed -i '/^IMAGE_UUID=.*/d' '${IMAGE_ROOTFS}/etc/os-release'
>> -    echo "IMAGE_UUID=\"${IMAGE_UUID}\"" | \
>> -        sudo tee -a '${IMAGE_ROOTFS}/etc/os-release'
>> +    sudo sh -c 'echo "IMAGE_UUID=\"${IMAGE_UUID}\"" > "${IMAGE_ROOTFS}/etc/secureboot-image-uuid"'
>>       image_do_mounts
>>   
>>       # update initramfs to add uuid
>> diff --git a/recipes-support/initramfs-config/files/initramfs.image_uuid.hook b/recipes-support/initramfs-config/files/initramfs.image_uuid.hook
>> index 910ce84..bf39abb 100644
>> --- a/recipes-support/initramfs-config/files/initramfs.image_uuid.hook
>> +++ b/recipes-support/initramfs-config/files/initramfs.image_uuid.hook
>> @@ -22,12 +22,12 @@ esac
>>   . /usr/share/initramfs-tools/scripts/functions
>>   . /usr/share/initramfs-tools/hook-functions
>>   
>> -if [ ! -e /etc/os-release ]; then
>> -	echo "Warning: couldn't find /etc/os-release!"
>> +if [ ! -e /etc/secureboot-image-uuid ]; then
>> +	

echo "Warning: couldn't find /etc/secureboot-image-uuid!"
>>   	exit 0
>>   fi
>>   
>> -IMAGE_UUID=$(sed -n 's/^IMAGE_UUID="\(.*\)"/\1/p' /etc/os-release)
>> +IMAGE_UUID=$(sed -n 's/^IMAGE_UUID="\(.*\)"/\1/p' /etc/secureboot-image-uuid)
>>   echo "${IMAGE_UUID}" > "${DESTDIR}/conf/image_uuid"
>>   
>>   exit 0
>> \ No newline at end of file
>> diff --git a/recipes-support/initramfs-config/files/secure-boot-debian-local-patch b/recipes-support/initramfs-config/files/secure-boot-debian-local-patch
>> index cd2d271..82d325a 100644
>> --- a/recipes-support/initramfs-config/files/secure-boot-debian-local-patch
>> +++ b/recipes-support/initramfs-config/files/secure-boot-debian-local-patch
>> @@ -58,8 +58,8 @@
>>   +			# Mount root
>>   +			# shellcheck disable=SC2086
>>   +			if mount ${roflag} ${FSTYPE:+-t "${FSTYPE}"} ${ROOTFLAGS} "${ROOT}" "${rootmnt?}"; then
>> -+				if [ -e "${rootmnt?}"/etc/os-release ]; then
>> -+				image_uuid=$(sed -n 's/^IMAGE_UUID=//p' "${rootmnt?}"/etc/os-release | tr -d '"' )
>> ++				if [ -e "${rootmnt?}"/etc/secureboot-image-uuid ]; then
>> ++				image_uuid=$(sed -n 's/^IMAGE_UUID=//p' "${rootmnt?}"/etc/secureboot-image-uuid | tr -d '"' )
>>   +					if [ "${INITRAMFS_IMAGE_UUID}" = "${image_uuid}" ]; then
>>   +						return 0
>>   +					fi
>>
> 
> This one would work, though, if we fixed
> https://groups.google.com/d/msgid/isar-users/67e1fac9-5af5-29aa-de57-9a0de0cdd165%40siemens.com
> in Isar, right? Should we rather wait for that?

At the moment I would say yes, wait for it.


Quirin

> 
> Applied patch 1 for now.
> 
> Jan
> 

--OIiHCT0WOtTG77LEGmLX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6160): https://lists.cip-project.org/g/cip-dev/message=
/6160
Mute This Topic: https://lists.cip-project.org/mt/80289768/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--OIiHCT0WOtTG77LEGmLX--
