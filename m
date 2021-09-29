Return-Path: <SRS0=Vgir=OT=lists.cip-project.org=bounce+64572+6760+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB87C433F5
	for <cip-dev@archiver.kernel.org>; Wed, 29 Sep 2021 07:53:27 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50388613D0
	for <cip-dev@archiver.kernel.org>; Wed, 29 Sep 2021 07:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 50388613D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id bOawYY4521723xMnA4TWpEAq; Wed, 29 Sep 2021 00:53:26 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web08.5786.1632902005620636057
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Sep 2021 00:53:26 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 18T7rMRj022042
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Sep 2021 09:53:22 +0200
X-Received: from [167.87.36.92] ([167.87.36.92])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 18T7rMTX004004;
	Wed, 29 Sep 2021 09:53:22 +0200
To: Jan Kiszka <jan.kiszka@web.de>, cip-dev@lists.cip-project.org,
        dinesh.kumar@toshiba-tsip.com
References: <20210928184948.737071-1-Quirin.Gylstorff@siemens.com>
 <20210928184948.CyweMK8GgelNPuFVMaTF1OrJUCtJ1G-3X9DeSeSKkUE@z>
 <15ad275a-a9f4-9e8e-149d-e09c17a196c4@web.de>
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
Organization: Siemens
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/2] kas/opt/efibootguard: Move setting of IMAGE_TYPE
Message-ID: <495fd44a-3d4c-e83a-0389-7d8516962000@siemens.com>
Date: Wed, 29 Sep 2021 09:53:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <15ad275a-a9f4-9e8e-149d-e09c17a196c4@web.de>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 8PX0ikdKix5Ta6Q7ZpqHXyWox4520388AA=
Content-Type: multipart/mixed; boundary="Jw77VSo1PhmqABgx6Xgm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1632902006;
 bh=6o0HgmdIK9Ks/KMMB77dBU9uMhFxTpaCKNlOqWrtQo4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=E5r4/PXuaxdUaFqEc+mhlQdVqvexFVzgVYjA2R3PjUGS04rryw9QAeHbNsq97VOOkBx
 nJVQmPesthuMb20UhdMGI4BYoETNCsPvgMcAmmRmwIW4yrOyOt2I6FuYVsbHNTYvBDGpo
 D+A50AJpYcls+sB9MibWaQRU1Cn2jrT1avE=

--Jw77VSo1PhmqABgx6Xgm
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit



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


--Jw77VSo1PhmqABgx6Xgm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6760): https://lists.cip-project.org/g/cip-dev/message/=
6760
Mute This Topic: https://lists.cip-project.org/mt/85936916/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Jw77VSo1PhmqABgx6Xgm--
