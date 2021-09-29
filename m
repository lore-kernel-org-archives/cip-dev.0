Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151E3C433EF
	for <webhook@archiver.kernel.org>; Wed, 29 Sep 2021 07:53:28 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web08.5786.1632902005620636057
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Sep 2021 00:53:26 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 18T7rMRj022042
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Sep 2021 09:53:22 +0200
Received: from [167.87.36.92] ([167.87.36.92])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 18T7rMTX004004;
	Wed, 29 Sep 2021 09:53:22 +0200
To: Jan Kiszka <jan.kiszka@web.de>, cip-dev@lists.cip-project.org,
        dinesh.kumar@toshiba-tsip.com
References: <20210928184948.737071-1-Quirin.Gylstorff@siemens.com>
 <20210928184948.CyweMK8GgelNPuFVMaTF1OrJUCtJ1G-3X9DeSeSKkUE@z>
 <15ad275a-a9f4-9e8e-149d-e09c17a196c4@web.de>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/2] kas/opt/efibootguard: Move
 setting of IMAGE_TYPE
Message-ID: <495fd44a-3d4c-e83a-0389-7d8516962000@siemens.com>
Date: Wed, 29 Sep 2021 09:53:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <15ad275a-a9f4-9e8e-149d-e09c17a196c4@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Sep 2021 07:53:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6760
Message-ID: <20210929075322.fW54FTVR-9jCF_EWyMEeZNPx971g1va1relfH4IGp-0@z>



On 9/29/21 12:09 AM, Jan Kiszka wrote:
> On 28.09.21 20:49, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This seperates the image type from the boot loader.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   kas/opt/efibootguard.yml |  1 -
>>   kas/opt/wic-img.yml      | 19 +++++++++++++++++++
>>   2 files changed, 19 insertions(+), 1 deletion(-)
>>   create mode 100644 kas/opt/wic-img.yml
>>
>> diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
>> index 705a76d..4e8be69 100644
>> --- a/kas/opt/efibootguard.yml
>> +++ b/kas/opt/efibootguard.yml
>> @@ -23,6 +23,5 @@ local_conf_header:
>>     efibootguard-wic: |
>>       WDOG_TIMEOUT ?= "60"
>>       WICVARS += "WDOG_TIMEOUT"
>> -    IMAGE_TYPE ?= "wic-img"
>>       WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
>>
>> diff --git a/kas/opt/wic-img.yml b/kas/opt/wic-img.yml
>> new file mode 100644
>> index 0000000..2b02b42
>> --- /dev/null
>> +++ b/kas/opt/wic-img.yml
>> @@ -0,0 +1,19 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2021
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +# This kas file set the IMAGE_TYPE to wic-img
>> +# The device specific WKS_FILE needs to be set seperately.
>> +
>> +header:
>> +  version: 10
>> +
>> +local_conf_header:
>> +  image-type: |
>> +    IMAGE_TYPE = "wic-img"
>>
> 
> What's the purpose of this file? When should a user specify this option?
> I think we already have too many option files and rather need to reduce
> them than adding more.

My idea was to split the selection of efibootguard from the usage of 
wic-img so that we can generate other image formats together with 
efibootguard - in hindsight this is not necessary -  you can skip this 
patch as patch 1 of this set solves the issue alone.


Quirin
> 
> Jan
> 
> PS: Something is currently off with archiving on lore.kernel.org.
> Messages from this thread but also others appear twice there:
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fcip-dev%2F20210928184946.GHmZQFBkA_wEzR1iQiB_04frBV52DnaYGHOSYtAdjok%40z%2FT%2F%23t&amp;data=04%7C01%7C6549bcd2-981c-4c06-8e1b-b5c6cc3441b4%40ad011.siemens.com%7Cc59cf4afa01c4ef24ff208d982ccb240%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C637684637933939193%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=kNC4hyC3dM8p%2BUVHMpaGjs7O%2BmC76P4UKCXcIHMStO8%3D&amp;reserved=0
> 


