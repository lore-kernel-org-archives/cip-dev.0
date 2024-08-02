Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4837BC3DA4A
	for <webhook@archiver.kernel.org>; Fri,  2 Aug 2024 11:31:33 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by mx.groups.io with SMTP id smtpd.web11.90204.1722596432418127157
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Aug 2024 04:00:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=jan.kiszka@web.de header.s=s29768273 header.b=pe5pDitH;
 spf=pass (domain: web.de, ip: 212.227.15.14, mailfrom: jan.kiszka@web.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722596429; x=1723201229; i=jan.kiszka@web.de;
	bh=LMjiNXEP4Qgy488aWfV1gAzIaGr9JF5h4rRSGtr7Zhs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pe5pDitHdO3v7ka/UdX+4vLJ7y57jBkjK+hPXJIRMmAIaBT8zXEXUdhgErAFO7ec
	 7oWhQFNepjhDR23Yy5ANV6flvQCySBBHdm/KzfDH3/Eoxvguq+U93SoJo7jky71td
	 4dXcReH15gI6tAp4Jty2v3CUdHTiQSX143E7FDp4wGZMRO1ALWPNzuZ9/Fip0xyaA
	 K3FHtuowlj8YITPpFeCNxPhACGBPfK5DzL1R8hBcAtXDg1W7dN18NqmJtiCBeSyAl
	 gKLcq+rK+LIIaM6nEFJex0kW52S40YI/LcwQd7Hw/jGgY7xwnLGEswEfyJprVJsoP
	 xIOIwrp6hBmpGc586w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.31] ([82.83.168.54]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Igl-1sMHFb3pfr-00uGYu; Fri, 02
 Aug 2024 13:00:28 +0200
Message-ID: <307bf040-06cb-49f7-84eb-e1a06447fc53@web.de>
Date: Fri, 2 Aug 2024 13:00:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v5] initramfs-overlay-hook: Check file system of INITRAMFS_OVERLAY_STORAGE_DEVICE
To: Clara Kowalsky <clara.kowalsky@siemens.com>, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20240723125925.1253022-1-clara.kowalsky@siemens.com>
 <50add61f-23b5-4feb-9187-acc48049f12e@web.de>
 <f640d73c-8882-4267-ac13-715947002c5c@siemens.com>
From: Jan Kiszka <jan.kiszka@web.de>
Autocrypt: addr=jan.kiszka@web.de; keydata=
 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
In-Reply-To: <f640d73c-8882-4267-ac13-715947002c5c@siemens.com>
X-Provags-ID: V03:K1:9PWpoxoFCeQunbCVW7C4mLV/D/8dGrWCuxmueWrV5JNjhdiU7qq
 SPow+fWSDMZRGORBSpJnez+wDUjQScNs30KNOsx27FD4Gf6St60+EmAMmkpKUn2EEVhdxl6
 960/WMjkofWGPwFA0Yk8FKRidF17RhspqlIKaKmMoEte/LpLOvNWAI3Ggd1aghKiqtPXq0l
 sSKJmJF8qv/P2QLr1GIJA==
UI-OutboundReport: notjunk:1;M01:P0:MIkzqoNgmRI=;vk6xgLQvcpENsD64e3uCbl/oeCp
 VRX96oW5YPGx2HDnVEsP1P1SP6grQHbsLhfcSAdqvc6zVQ6sncvUqUMJME2KMuxmGjoU+oZGM
 sSEVmHmMbHKsWTsm+5FmwsXO2qcZ9rEx/AuxrVTKJWcppCymCwxgEQE52aKf5sX0ucvQRHNwW
 R6rLiJrQPcqZ0sAOIL3DdAnTvzb09W6l3wXdSCJ3+LxjcJSBXbCHJXtt9uSGM+jx66ZBn3U6t
 TQd/7FnGOlTFvLBDSpFSJYISBZrYjpcGp9ZaojUf6jHlgh/7SMVA9NbqfR5KSWmKH/3ggpqxu
 zNq7r0aOiKUnuJ+EVmK4c6lcg7FO3FA+KyscRYaeNCvRjheUW7aJTB553Vc7pdWtyk63Ye5XK
 GEwCpkY+rp/BcyPKcjNkXMrabP06sk/QL6Qn7NjRAOtHr2/zy8xtFDonc3WD2IwOTEO4p608A
 SGnoq1ElVj38ctSoBWyxyd6KGDWE2679yoGXRIyjXNJixh9pyfiJTgNJO4Ma6kvtGrQcSeAtW
 hURSHCz9om2pegxuJmGO0laoesJCyrF1fLthj5PuiUFU8pkilcKYnGCVWEH3ZqDyHItfrZAkR
 difwKfGa7kBcC0xT72A7hGX6CJFS98u/h4xXCp0IuYxHuNk0Mq6Ps5WLgAmsKG5LsLPgSgod+
 7x1dtADJAERNuSTNdC51k4tXMr220DMFqjJzB5v8vUWq61Vbm7x0OfZddG/KljwisiUdqY67P
 6VTR0grKQnlURww9U3+mH+ZMioE5zc0Tbx/mrcCKFReh31HSLGFL2NHr/KRdt9RCH8bv/EEiR
 yAW1Xcsfm7A3myW1YAvqgu7Q==
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Aug 2024 11:31:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16710

On 01.08.24 09:26, Clara Kowalsky wrote:
>
>
> On 31.07.24 19:01, Jan Kiszka wrote:
>> On 23.07.24 14:59, Clara Kowalsky wrote:
>>> In case of ext*, this detects and fixes file system errors in the
>>> partition device before doing the partition mount.
>>> If the partition turns out to be broken, the factory state is recovere=
d.
>>>
>>> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>>> ---
>>> =C2=A0 .../initramfs-overlay-hook/files/overlay.hook=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 11 +++++++++--
>>> =C2=A0 .../files/overlay.script.tmpl=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 11 ++++++++++-
>>> =C2=A0 .../files/overlay_recovery_action.script=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 ++++++++++++++
>>> =C2=A0 .../initramfs-overlay-hook_0.1.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 8 +++++++-
>>> =C2=A0 4 files changed, 40 insertions(+), 4 deletions(-)
>>> =C2=A0 create mode 100644
>>> recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action=
.script
>>>
>>> diff --git
>>> a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
>>> b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
>>> index 8b00ecf..6f634c5 100644
>>> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
>>> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
>>> @@ -22,6 +22,13 @@ esac
>>>
>>> =C2=A0 . /usr/share/initramfs-tools/hook-functions
>>>
>>> +hook_error() {
>>> +=C2=A0=C2=A0=C2=A0 echo "(ERROR): $1" >&2
>>> +=C2=A0=C2=A0=C2=A0 exit 1
>>> +}
>>> +
>>> =C2=A0 manual_add_modules overlay
>>> -copy_exec /usr/bin/mountpoint
>>> -copy_exec /usr/bin/awk
>>> +copy_exec /usr/bin/mountpoint || hook_error "/usr/bin/mountpoint not
>>> found"
>>> +copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
>>> +copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
>>> +copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
>>
>> Is there no "copy_exec_and_complain+fail_if_missing"? This pattern look=
s
>> like it does not scale very well across all our scripts (including isar
>> upstream).
>>
> I have not found anything like this that covers both in one command.
>
>>> diff --git
>>> a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
>>> b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
>>> index 42eb59c..c6f69b9 100644
>>> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tm=
pl
>>> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tm=
pl
>>> @@ -31,12 +31,21 @@
>>> ovl_partition_device=3D"${INITRAMFS_OVERLAY_STORAGE_DEVICE}"
>>> =C2=A0 ovl_storage_path=3D"${INITRAMFS_OVERLAY_STORAGE_PATH}"
>>> =C2=A0 ovl_lower_dirs=3D"${INITRAMFS_OVERLAY_PATHS}"
>>> =C2=A0 ovl_mount_option=3D"${INITRAMFS_OVERLAY_MOUNT_OPTION}"
>>> +ovl_recovery_script=3D"/scripts/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}"
>>>
>>> =C2=A0 root_mount_storage=3D${rootmnt}${ovl_storage_path}
>>> =C2=A0 storage_mount_point=3D"$(echo "${ovl_storage_path}" | awk -F/ '=
{print
>>> FS$2}' )"
>>> +partition_fstype=3D$(get_fstype "${ovl_partition_device}")
>>>
>>> =C2=A0 if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
>>> -=C2=A0=C2=A0=C2=A0 if ! mount -t $(get_fstype ${ovl_partition_device}=
) \
>>> +=C2=A0=C2=A0=C2=A0 case $partition_fstype in
>>> +=C2=A0=C2=A0=C2=A0 ext*)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ! e2fsck -p -f "$ovl_pa=
rtition_device" && [ -f
>>> "$ovl_recovery_script" ] && [ -x "$ovl_recovery_script" ]; then
>>
>> Why testing both -f and -x?
>
> I was thinking, what if someone sets INITRAMFS_OVERLAY_RECOVERY_SCRIPT
> to an empty string? Then ovl_recovery_script would be a directory and
> the next line would give a permission denied.
>

OK - but in that case, "file://${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}"
will make things fail much earlier.

Jan


