Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79F5C433F5
	for <webhook@archiver.kernel.org>; Mon,  8 Nov 2021 15:23:34 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web09.46311.1636385013585848993
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Nov 2021 07:23:34 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 1A8FNUbc006010
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Nov 2021 16:23:30 +0100
Received: from [139.22.43.76] ([139.22.43.76])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 1A8FNUok002435;
	Mon, 8 Nov 2021 16:23:30 +0100
Subject: Re: [isar-cip-core][PATCH] swupdate: Remove superflous patch
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>,
        cip-dev@lists.cip-project.org
References: <20211108093259.3309527-1-Vijaikumar_Kanagarajan@mentor.com>
 <8d916034-dc58-8e19-9be4-1882bcb3445a@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
Message-ID: <cbd524ef-2226-e932-8a77-8e1f41f5bb35@siemens.com>
Date: Mon, 8 Nov 2021 16:23:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <8d916034-dc58-8e19-9be4-1882bcb3445a@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Nov 2021 15:23:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6870



On 11/8/21 4:14 PM, Jan Kiszka wrote:
> On 08.11.21 10:32, Vijai Kumar K wrote:
>> Same as 0008-debian-rules-Add-Embedded-Lua-handler-option.patch.
>>
>> Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
>> ---
>>   ...ules-Add-Embedded-Lua-handler-option.patch | 30 -------------------
>>   1 file changed, 30 deletions(-)
>>   delete mode 100644 recipes-core/swupdate/files/0005-debian-rules-Add-Embedded-Lua-handler-option.patch
>>
>> diff --git a/recipes-core/swupdate/files/0005-debian-rules-Add-Embedded-Lua-handler-option.patch b/recipes-core/swupdate/files/0005-debian-rules-Add-Embedded-Lua-handler-option.patch
>> deleted file mode 100644
>> index 84665cd..0000000
>> --- a/recipes-core/swupdate/files/0005-debian-rules-Add-Embedded-Lua-handler-option.patch
>> +++ /dev/null
>> @@ -1,30 +0,0 @@
>> -From 0200687ad67d6e5a0e9bbdf2e8c86e3f8e717c5e Mon Sep 17 00:00:00 2001
>> -From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> -Date: Wed, 29 Sep 2021 11:32:41 +0200
>> -Subject: [PATCH 5/6] debian/rules: Add Embedded Lua handler option
>> -
>> -Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ----
>> - debian/rules | 5 +++++
>> - 1 file changed, 5 insertions(+)
>> -
>> -diff --git a/debian/rules b/debian/rules
>> -index 69fd790..9ace348 100755
>> ---- a/debian/rules
>> -+++ b/debian/rules
>> -@@ -52,7 +52,12 @@ ifneq (,$(LUA_VERSION))
>> - 	echo CONFIG_LUAPKG=\"lua$(LUA_VERSION)\" >> configs/debian_defconfig
>> - 	echo CONFIG_LUASCRIPTHANDLER=y           >> configs/debian_defconfig
>> - 	echo CONFIG_HANDLER_IN_LUA=y             >> configs/debian_defconfig
>> -+ifneq (,$(filter pkg.swupdate.embeddedlua,$(DEB_BUILD_PROFILES)))
>> -+	echo CONFIG_EMBEDDED_LUA_HANDLER=y                              >> configs/debian_defconfig
>> -+	echo CONFIG_EMBEDDED_LUA_HANDLER_SOURCE=\"/usr/share/lua/$(LUA_VERSION)/swupdate_handlers.lua\" >> configs/debian_defconfig
>> - endif
>> -+endif
>> -+
>> - 	echo CONFIG_EXTRA_CFLAGS=\"$(CFLAGS) $(CPPFLAGS)\" >> configs/debian_defconfig
>> - 	echo CONFIG_EXTRA_LDFLAGS=\"$(LDFLAGS)\"           >> configs/debian_defconfig
>> - 	echo CONFIG_EXTRA_LDLIBS=\"$(LDLIBS)\"             >> configs/debian_defconfig
>> ---
>> -2.30.2
>> -
>>
> 
> Was this ever used, Quirin?

It was from a early iteration of the patchset. It was no longer in use 
in the recipe.
> 
> Applied, thanks.
> 
> Jan
> 
Quirin

