Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33D0C433F5
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 15:59:31 +0000 (UTC)
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web09.12347.1639670370578670993
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 07:59:31 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.14, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 1BGFxQZq013703
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 16:59:27 +0100
Received: from [167.87.32.230] ([167.87.32.230])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1BGFxQWA019147;
	Thu, 16 Dec 2021 16:59:26 +0100
Message-ID: <ce48294f-784f-efdd-f32e-d000295dcd1d@siemens.com>
Date: Thu, 16 Dec 2021 16:59:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [cip-dev] [isar-cip-core][PATCH v2 2/2] swupdate: Drop
 conditional includes for buster
Content-Language: en-US
To: cip-dev@lists.cip-project.org, Jan Kiszka <jan.kiszka@siemens.com>
References: <20211216133617.3403412-1-Vijaikumar_Kanagarajan@mentor.com>
 <20211216133617.3403412-3-Vijaikumar_Kanagarajan@mentor.com>
 <2ce1cbe9-8950-f136-d7a5-b97b455e8105@siemens.com>
 <518bb7da0c0a4e70912e3dcbcdcad06b@svr-orw-mbx-01.mgc.mentorg.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <518bb7da0c0a4e70912e3dcbcdcad06b@svr-orw-mbx-01.mgc.mentorg.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 15:59:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7163



On 12/16/21 15:23, Kanagarajan, Vijaikumar via lists.cip-project.org wrote:
> 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: 16 December 2021 19:09
>> To: Kanagarajan, Vijaikumar <Vijaikumar_Kanagarajan@mentor.com>; cip-
>> dev@lists.cip-project.org
>> Subject: Re: [isar-cip-core][PATCH v2 2/2] swupdate: Drop conditional
>> includes for buster
>>
>> On 16.12.21 14:36, Vijai Kumar K wrote:
>>> Stretch in now dropped. The conditional includes for buster is now not
>>> needed. Those includes are applicable to buster as well as bullseye.
>>>
>>> Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
>>> ---
>>>   .../swupdate/swupdate_2021.04-1+debian-gbp.bb        | 12 ++++++------
>>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
>>> b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
>>> index a4d67fe..51aacfe 100644
>>> --- a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
>>> +++ b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
>>> @@ -44,12 +44,12 @@ SWUPDATE_BUILD_PROFILES += "cross nocheck"
>>>   # modify for debian buster build
>>>   SRC_URI_append_buster = " file://0009-debian-prepare-build-for-isar-
>> debian-buster.patch"
>>>
>>> -# disable documentation due to missing packages in debian buster -#
>>> disable create filesystem due to missing symbols in debian buster -#
>>> disable webserver due to missing symbols in debian buster
>>> -SWUPDATE_BUILD_PROFILES_append_buster = " nodoc \
>>> -                                          pkg.swupdate.nocreatefs \
>>> -                                          pkg.swupdate.nowebserver "
>>> +# disable documentation due to missing packages # disable create
>>> +filesystem due to missing symbols # disable webserver due to missing
>>> +symbols SWUPDATE_BUILD_PROFILES_append = " nodoc \
>>> +                                   pkg.swupdate.nocreatefs \
>>> +                                   pkg.swupdate.nowebserver "
>>>   # In debian buster the git-compression defaults to gz and does not
>>> detect other  # compression formats.
>>>   GBP_EXTRA_OPTIONS += "--git-compression=xz"
>>>
>>
>> So these things were actually broken for bullseye so far?
> 
> Yes. Atleast, the nodoc is needed because of sphinx dependency issue in bullseye.
> 
> Thanks,
> Vijai Kumar K
> The flags `pkg.swupdate.nocreatefs` and `pkg.swupdate.nowebserver` are 
for Debian Buster.

A build for Debian Bullseye can use the webserver and createfs option as 
the are active in the Debian provided package on salsa.

Only `nodoc`  needs to applied to buster and bullseye.


Quirin

