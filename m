Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECBFC433F5
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 13:51:55 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web12.10686.1639662714175324206
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 05:51:54 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 1BGDpoxf010145
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Dec 2021 14:51:50 +0100
Received: from [167.87.32.230] ([167.87.32.230])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1BGDpmZ3029691;
	Thu, 16 Dec 2021 14:51:49 +0100
Message-ID: <1f80d4eb-93b1-1d40-33a1-893b93585baf@siemens.com>
Date: Thu, 16 Dec 2021 14:51:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [cip-dev] [isar-cip-core][PATCH v2 2/2] swupdate: Drop
 conditional includes for buster
Content-Language: en-US
To: cip-dev@lists.cip-project.org,
        Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
References: <20211216133617.3403412-1-Vijaikumar_Kanagarajan@mentor.com>
 <20211216133617.3403412-3-Vijaikumar_Kanagarajan@mentor.com>
 <2ce1cbe9-8950-f136-d7a5-b97b455e8105@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <2ce1cbe9-8950-f136-d7a5-b97b455e8105@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 13:51:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7159



On 12/16/21 14:38, Jan Kiszka via lists.cip-project.org wrote:
> On 16.12.21 14:36, Vijai Kumar K wrote:
>> Stretch in now dropped. The conditional includes for buster is now not
>> needed. Those includes are applicable to buster as well as bullseye.
>>
>> Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
>> ---
>>   .../swupdate/swupdate_2021.04-1+debian-gbp.bb        | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
>> index a4d67fe..51aacfe 100644
>> --- a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
>> +++ b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
>> @@ -44,12 +44,12 @@ SWUPDATE_BUILD_PROFILES += "cross nocheck"
>>   # modify for debian buster build
>>   SRC_URI_append_buster = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"
>>   
>> -# disable documentation due to missing packages in debian buster
>> -# disable create filesystem due to missing symbols in debian buster
>> -# disable webserver due to missing symbols in debian buster
>> -SWUPDATE_BUILD_PROFILES_append_buster = " nodoc \
>> -                                          pkg.swupdate.nocreatefs \
>> -                                          pkg.swupdate.nowebserver "
>> +# disable documentation due to missing packages
>> +# disable create filesystem due to missing symbols
>> +# disable webserver due to missing symbols
>> +SWUPDATE_BUILD_PROFILES_append = " nodoc \
>> +                                   pkg.swupdate.nocreatefs \
>> +                                   pkg.swupdate.nowebserver "
>>   # In debian buster the git-compression defaults to gz and does not detect other
>>   # compression formats.
>>   GBP_EXTRA_OPTIONS += "--git-compression=xz"
>>
> 
> So these things were actually broken for bullseye so far?

 From my testing only the option nodoc is necessary for bullseye.


Quirin
> 
> Jan
> 
> 

