Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC68C433EF
	for <webhook@archiver.kernel.org>; Wed, 17 Nov 2021 11:37:00 +0000 (UTC)
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web11.5885.1637149019314867062
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Nov 2021 03:37:00 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.14, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AHBauYc012766
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 12:36:56 +0100
Received: from [139.25.69.254] ([139.25.69.254])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AHBat9d008276
	for <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 12:36:56 +0100
To: cip-dev@lists.cip-project.org
References: <20211117104012.xciipnpvpbb22ghn@MD1ZFJVC.ad001.siemens.net>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
Subject: Re: [cip-dev][isar-cip-core]RFC v2 9/9] swupdate: Backport patches
 from SWUpdate Master
Message-ID: <df72363b-5b34-98fe-b9b0-c6141931a98c@siemens.com>
Date: Wed, 17 Nov 2021 12:36:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211117104012.xciipnpvpbb22ghn@MD1ZFJVC.ad001.siemens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 11:37:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6942



On 11/17/21 11:40 AM, Christian Storm via lists.cip-project.org wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Backport the following patches to detect the correct partition to
>> update.
>> 388f1777 util: Add get_root source /proc/self/mountinfo
>> 3914d2b7 util: Extend get_root to find LUKS devices
> 
> Why not upgrade to a newer version of SWUpdate instead of backporting
> stuff? There's no real advantage to stay on a "release" as SWUpdate
> follows rolling releases -- granted, you have to do the qualification
> but that applies to "releases" as well...
>

The build of SWUpdate uses dpkg-gbp to follow the Debian build of 
SWUpdate with sources from [1].

As Debian only follows fixed release , currently 2021.04, I patched the 
version.
This patchset is no longer necessary after Debian uses the next Release
SWUpdate version.

[1]: https://salsa.debian.org/debian/swupdate.
> 
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .../0001-add-patches-for-dm-verity.patch      | 188 ++++++++++++++++++
>>   .../swupdate/swupdate_2021.04-1+debian-gbp.bb |   5 +
>>   2 files changed, 193 insertions(+)
>>   create mode 100644 recipes-core/swupdate/files/0001-add-patches-for-dm-verity.patch
>>
>> diff --git a/recipes-core/swupdate/files/0001-add-patches-for-dm-verity.patch b/recipes-core/swupdate/files/0001-add-patches-for-dm-verity.patch
>> new file mode 100644
>> index 0000000..f143207
>> --- /dev/null
>> +++ b/recipes-core/swupdate/files/0001-add-patches-for-dm-verity.patch
>> @@ -0,0 +1,188 @@
>> +From 4650883c2ffc4ed9e479e1eefdce044067c7de0b Mon Sep 17 00:00:00 2001
>> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +Date: Mon, 25 Oct 2021 14:43:07 +0200
>> +Subject: [PATCH] add patches for dm-verity
>> +
>> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +---
>> + ...d-get_root-source-proc-self-mountinfo.diff | 68 +++++++++++++++
>> + ...-Extend-get_root-to-find-LUKS-devices.diff | 83 +++++++++++++++++++
>> + debian/patches/series                         |  2 +
>> + 3 files changed, 153 insertions(+)
>> + create mode 100644 debian/patches/0001-util-Add-get_root-source-proc-self-mountinfo.diff
>> + create mode 100644 debian/patches/0002-util-Extend-get_root-to-find-LUKS-devices.diff
>> +
>> +diff --git a/debian/patches/0001-util-Add-get_root-source-proc-self-mountinfo.diff b/debian/patches/0001-util-Add-get_root-source-proc-self-mountinfo.diff
>> +new file mode 100644
>> +index 0000000..5db0e61
>> +--- /dev/null
>> ++++ b/debian/patches/0001-util-Add-get_root-source-proc-self-mountinfo.diff
>> +@@ -0,0 +1,68 @@
>> ++From 388f1777e3e9e7dfbe41768aa7ce86bc0ee25c37 Mon Sep 17 00:00:00 2001
>> ++From: Christian Storm <christian.storm@siemens.com>
>> ++Date: Thu, 10 Jun 2021 00:30:24 +0200
>> ++Subject: [PATCH 1/2] util: Add get_root source /proc/self/mountinfo
>> ++
>> ++Filesystems such as BTRFS report synthetic device major:minor
>> ++numbers in stat(2)'s st_dev value. Hence, such a root filesystem
>> ++won't be found by get_root_from_partitions().
>> ++
>> ++As /proc/self/mountinfo's information is subject to mount-
>> ++namespacing, it complements get_root_from_partitions() rather
>> ++than replacing it.
>> ++
>> ++Signed-off-by: Christian Storm <christian.storm@siemens.com>
>> ++Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Hm, why is your sign-off needed here as you've grabbed that directly
> from SWUpdate's repo?

I will fix it in a new version.
> 
>> ++---
>> ++ core/util.c | 28 ++++++++++++++++++++++++++++
>> ++ 1 file changed, 28 insertions(+)
>> ++
>> ++diff --git a/core/util.c b/core/util.c
>> ++index 7d7673a..51a16b6 100644
>> ++--- a/core/util.c
>> +++++ b/core/util.c
>> ++@@ -883,6 +883,32 @@ static char *get_root_from_partitions(void)
>> ++ 	return NULL;
>> ++ }
>> ++
>> +++/*
>> +++ * Return the rootfs's device name from /proc/self/mountinfo.
>> +++ * Needed for filesystems having synthetic stat(2) st_dev
>> +++ * values such as BTRFS.
>> +++ */
>> +++static char *get_root_from_mountinfo(void)
>> +++{
>> +++	char *mnt_point, *device = NULL;
>> +++	FILE *fp = fopen("/proc/self/mountinfo", "r");
>> +++	while (fp && !feof(fp)){
>> +++		/* format: https://www.kernel.org/doc/Documentation/filesystems/proc.txt */
>> +++		if (fscanf(fp, "%*s %*s %*u:%*u %*s %ms %*s %*[-] %*s %ms %*s",
>> +++			   &mnt_point, &device) == 2) {
>> +++			if ( (!strcmp(mnt_point, "/")) && (strcmp(device, "none")) ) {
>> +++				free(mnt_point);
>> +++				break;
>> +++			}
>> +++			free(mnt_point);
>> +++			free(device);
>> +++		}
>> +++		device = NULL;
>> +++	}
>> +++	(void)fclose(fp);
>> +++	return device;
>> +++}
>> +++
>> ++ #define MAX_CMDLINE_LENGTH 4096
>> ++ static char *get_root_from_cmdline(void)
>> ++ {
>> ++@@ -936,6 +962,8 @@ char *get_root_device(void)
>> ++ 	root = get_root_from_partitions();
>> ++ 	if (!root)
>> ++ 		root = get_root_from_cmdline();
>> +++	if (!root)
>> +++		root = get_root_from_mountinfo();
>> ++
>> ++ 	return root;
>> ++ }
>> ++--
>> ++2.30.2
>> ++
>> +diff --git a/debian/patches/0002-util-Extend-get_root-to-find-LUKS-devices.diff b/debian/patches/0002-util-Extend-get_root-to-find-LUKS-devices.diff
>> +new file mode 100644
>> +index 0000000..a62d59c
>> +--- /dev/null
>> ++++ b/debian/patches/0002-util-Extend-get_root-to-find-LUKS-devices.diff
>> +@@ -0,0 +1,83 @@
>> ++From 3914d2b73bf80b24aba015d9225082c2965c7a02 Mon Sep 17 00:00:00 2001
>> ++From: Stefano Babic <sbabic@denx.de>
>> ++Date: Thu, 10 Jun 2021 16:14:44 +0200
>> ++Subject: [PATCH 2/2] util: Extend get_root to find LUKS devices
>> ++
>> ++This helps in case of encrypted filesystem or device mapper.
>> ++The returned device read from partitions is usually a dm-X device and
>> ++this does not show which is the block device that contains it. Look in
>> ++sysfs and check if the device has "slaves" entries, indicating the
>> ++presence of an underlying device. If found, return this instead of the
>> ++device returned parsing /proc/partitions.
>> ++
>> ++Signed-off-by: Stefano Babic <sbabic@denx.de>
>> ++Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Same question as above applies here.
> 

New version is in work

>> ++---
>> ++ core/util.c | 26 ++++++++++++++++++++++++--
>> ++ 1 file changed, 24 insertions(+), 2 deletions(-)
>> ++
>> ++diff --git a/core/util.c b/core/util.c
>> ++index 51a16b6..3b81c09 100644
>> ++--- a/core/util.c
>> +++++ b/core/util.c
>> ++@@ -24,6 +24,7 @@
>> ++ #include <libgen.h>
>> ++ #include <regex.h>
>> ++ #include <string.h>
>> +++#include <dirent.h>
>> ++
>> ++ #if defined(__linux__)
>> ++ #include <sys/statvfs.h>
>> ++@@ -851,6 +852,10 @@ size_t snescape(char *dst, size_t n, const char *src)
>> ++ /*
>> ++  * This returns the device name where rootfs is mounted
>> ++  */
>> +++
>> +++static int filter_slave(const struct dirent *ent) {
>> +++	return (strcmp(ent->d_name, ".") && strcmp(ent->d_name, ".."));
>> +++}
>> ++ static char *get_root_from_partitions(void)
>> ++ {
>> ++ 	struct stat info;
>> ++@@ -858,11 +863,28 @@ static char *get_root_from_partitions(void)
>> ++ 	char *devname = NULL;
>> ++ 	unsigned long major, minor, nblocks;
>> ++ 	char buf[256];
>> ++-	int ret;
>> +++	int ret, dev_major, dev_minor, n;
>> +++	struct dirent **devlist = NULL;
>> ++
>> ++ 	if (stat("/", &info) < 0)
>> ++ 		return NULL;
>> ++
>> +++	dev_major = info.st_dev / 256;
>> +++	dev_minor = info.st_dev % 256;
>> +++
>> +++	/*
>> +++	 * Check if this is just a container, for example in case of LUKS
>> +++	 * Search if the device has slaves pointing to another device
>> +++	 */
>> +++	snprintf(buf, sizeof(buf) - 1, "/sys/dev/block/%d:%d/slaves", dev_major, dev_minor);
>> +++	n = scandir(buf, &devlist, filter_slave, NULL);
>> +++	if (n == 1) {
>> +++		devname = strdup(devlist[0]->d_name);
>> +++		free(devlist);
>> +++		return devname;
>> +++	}
>> +++	free(devlist);
>> +++
>> ++ 	fp = fopen("/proc/partitions", "r");
>> ++ 	if (!fp)
>> ++ 		return NULL;
>> ++@@ -872,7 +894,7 @@ static char *get_root_from_partitions(void)
>> ++ 			     &major, &minor, &nblocks, &devname);
>> ++ 		if (ret != 4)
>> ++ 			continue;
>> ++-		if ((major == info.st_dev / 256) && (minor == info.st_dev % 256)) {
>> +++		if ((major == dev_major) && (minor == dev_minor)) {
>> ++ 			fclose(fp);
>> ++ 			return devname;
>> ++ 		}
>> ++--
>> ++2.30.2
>> ++
>> +diff --git a/debian/patches/series b/debian/patches/series
>> +index 8c5564a..f3bd00e 100644
>> +--- a/debian/patches/series
>> ++++ b/debian/patches/series
>> +@@ -1 +1,3 @@
>> + use-gcc-compiler.diff
>> ++0002-util-Extend-get_root-to-find-LUKS-devices.diff
>> ++0001-util-Add-get_root-source-proc-self-mountinfo.diff
>> +--
>> +2.30.2
>> +
>> diff --git a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
>> index 7a0fb9b..90854a4 100644
>> --- a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
>> +++ b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
>> @@ -25,6 +25,11 @@ SRC_URI += "file://0001-debian-Add-option-to-build-with-efibootguard.patch \
>>               file://0007-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch \
>>               file://0008-debian-rules-Add-Embedded-Lua-handler-option.patch"
>>   
>> +# Patch for dm-verity based images - can be removed with SWUpdate 2021.10
>> +SRC_URI += "file://0001-add-patches-for-dm-verity.patch"
>> +
>> +# end patching for dm-verity based images
>> +
>>   # deactivate signing and encryption for simple a/b rootfs update
>>   SWUPDATE_BUILD_PROFILES += "pkg.swupdate.nosigning pkg.swupdate.noencryption"
>>   
>> -- 
>> 2.30.2
>>
> 
> 
> Kind regards,
>     Christian
> 
Quirin

