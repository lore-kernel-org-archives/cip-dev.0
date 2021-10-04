Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5526FC433EF
	for <webhook@archiver.kernel.org>; Mon,  4 Oct 2021 10:37:42 +0000 (UTC)
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web08.7439.1633343861233115130
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Oct 2021 03:37:42 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.14, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 194Abcrt022398
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Oct 2021 12:37:38 +0200
Received: from [167.87.3.213] ([167.87.3.213])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 194Abb64030996;
	Mon, 4 Oct 2021 12:37:38 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH 1/2] kas/opt/swupdate: Change
 assignment of IMAGE_TYPE and WKS_FILE
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Cc: dinesh.kumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
References: <20210928184948.737071-1-Quirin.Gylstorff@siemens.com>
 <20210928184947.AYjduU9bTolWO5fGM5sHK1KwOFt_xWwyNQv5uQOgPvk@z>
 <5da61997-9b25-d965-9d5b-0f148c8f4e5b@siemens.com>
Message-ID: <be00776f-c1c5-9c84-c904-2d8e17cc298d@siemens.com>
Date: Mon, 4 Oct 2021 12:37:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5da61997-9b25-d965-9d5b-0f148c8f4e5b@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Oct 2021 10:37:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6772

On 04.10.21 11:28, Jan Kiszka wrote:
> On 28.09.21 20:49, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Replace the default assignment to ensure the generation of the
>> swu file. As stated in [1]: If multiple `?=` assignments are used
>> the first of those assignments ends up getting used.
>>
>> This fixes [2].
>>
>> [1]: https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-metadata.html#setting-a-default-value
>> [2]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/14
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  kas/opt/swupdate.yml | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
>> index 7d86ad5..3cc02a3 100644
>> --- a/kas/opt/swupdate.yml
>> +++ b/kas/opt/swupdate.yml
>> @@ -19,5 +19,5 @@ local_conf_header:
>>      IMAGE_INSTALL_append = " swupdate"
>>  
>>    wic-swu: |
>> -    IMAGE_TYPE ?= "wic-swu-img"
>> -    WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
>> +    IMAGE_TYPE = "wic-swu-img"
>> +    WKS_FILE = "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
>>
>>
> 
> Thanks, applied.
> 

Something seems to break:

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/381889283

Could you have a look?

We also had fetching issues against gitlab, but those were "solved" by
retrying and were surely not triggered by this patch.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

