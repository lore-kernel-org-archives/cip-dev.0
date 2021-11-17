Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9A3C433EF
	for <webhook@archiver.kernel.org>; Wed, 17 Nov 2021 11:41:10 +0000 (UTC)
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web08.6007.1637149269790912752
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Nov 2021 03:41:10 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.14, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AHBf82A019269
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 12:41:08 +0100
Received: from [139.25.69.254] ([139.25.69.254])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AHBf7js013620
	for <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 12:41:08 +0100
Subject: Re: [cip-dev][isar-cip-core]RFC v2 8/9] kas: Patch isar for correct
 permissions in var and home
To: cip-dev@lists.cip-project.org
References: <20211117102733.3xr22krlkwrhc5od@MD1ZFJVC.ad001.siemens.net>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
Message-ID: <731aadb8-ba54-743b-ef7a-b2fb79f8eabe@siemens.com>
Date: Wed, 17 Nov 2021 12:41:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211117102733.3xr22krlkwrhc5od@MD1ZFJVC.ad001.siemens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 11:41:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6943



On 11/17/21 11:27 AM, Christian Storm via lists.cip-project.org wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> 
> A note where this comes from, where it's supposed to go in oder to get
> rid of this patch here eventually would be helpful.
> 
I will add a link to the discussion of the Patch on the ISAR mailing 
list[1] in the next version.

[1]: https://groups.google.com/g/isar-users/c/wlanc7f7UnQ

Kind regards
Quirin

> 
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   kas-cip.yml                                   |  4 +++
>>   ...when-splitting-rootfs-folders-across.patch | 35 +++++++++++++++++++
>>   2 files changed, 39 insertions(+)
>>   create mode 100644 patches/isar/0001-Fix-permissions-when-splitting-rootfs-folders-across.patch
>>
>> diff --git a/kas-cip.yml b/kas-cip.yml
>> index dc56729..8226954 100644
>> --- a/kas-cip.yml
>> +++ b/kas-cip.yml
>> @@ -25,6 +25,10 @@ repos:
>>       refspec: ceb7e21154fc4862f704bb5c7739e87a26db6eb3
>>       layers:
>>         meta:
>> +    patches:
>> +      fix-pseudo:
>> +        repo: cip-core
>> +        path: patches/isar/0001-Fix-permissions-when-splitting-rootfs-folders-across.patch
>>   
>>   bblayers_conf_header:
>>     standard: |
>> diff --git a/patches/isar/0001-Fix-permissions-when-splitting-rootfs-folders-across.patch b/patches/isar/0001-Fix-permissions-when-splitting-rootfs-folders-across.patch
>> new file mode 100644
>> index 0000000..34704f0
>> --- /dev/null
>> +++ b/patches/isar/0001-Fix-permissions-when-splitting-rootfs-folders-across.patch
>> @@ -0,0 +1,35 @@
>> +From 34b37fccd5e454d29d6d4d002d48a9619782b1bb Mon Sep 17 00:00:00 2001
>> +From: Felix Moessbauer <felix.moessbauer@siemens.com>
>> +Date: Wed, 3 Nov 2021 13:53:00 +0100
>> +Subject: [PATCH] Fix permissions when splitting rootfs folders across
>> + partitions.
>> +
>> +This patches ensures that the file database containing the file and
>> +folder usernames and permissions is always located relative to the
>> +source and not to the appended rootfs-dir.
>> +
>> +Prior to this patch, the database was not found when using
>> +-rootfs-dir in the WIC script, leading to erronous file
>> +permissions and ownership.
>> +
>> +Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>> +---
>> + scripts/lib/wic/plugins/source/rootfs.py | 2 +-
>> + 1 file changed, 1 insertion(+), 1 deletion(-)
>> +
>> +diff --git a/scripts/lib/wic/plugins/source/rootfs.py b/scripts/lib/wic/plugins/source/rootfs.py
>> +index 96d940a9..5ab771e5 100644
>> +--- a/scripts/lib/wic/plugins/source/rootfs.py
>> ++++ b/scripts/lib/wic/plugins/source/rootfs.py
>> +@@ -95,7 +95,7 @@ class RootfsPlugin(SourcePlugin):
>> +
>> +         part.rootfs_dir = cls.__get_rootfs_dir(rootfs_dir)
>> +         part.has_fstab = os.path.exists(os.path.join(part.rootfs_dir, "etc/fstab"))
>> +-        pseudo_dir = os.path.join(part.rootfs_dir, "../pseudo")
>> ++        pseudo_dir = os.path.join(krootfs_dir['ROOTFS_DIR'], "../pseudo")
>> +         if not os.path.lexists(pseudo_dir):
>> +             logger.warn("%s folder does not exist. "
>> +                         "Usernames and permissions will be invalid " % pseudo_dir)
>> +--
>> +2.30.2
>> +
>> -- 
>> 2.30.2
>>
> 
> 
> 
> Kind regards,
>     Christian
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#6936): https://lists.cip-project.org/g/cip-dev/message/6936
> Mute This Topic: https://lists.cip-project.org/mt/87092663/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 




