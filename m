Return-Path: <SRS0=TZpN=GQ=lists.cip-project.org=bounce+64572+6066+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FAAC433DB
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 12:51:51 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04A7A233EA
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 12:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A7A233EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6066+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id fHyXYY4521723xdOLO6ggdi5; Wed, 13 Jan 2021 04:51:49 -0800
X-Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by mx.groups.io with SMTP id smtpd.web08.6426.1610535178228540897
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jan 2021 02:52:58 -0800
X-Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4DG46F0RNsz1s8Nq;
	Wed, 13 Jan 2021 11:52:53 +0100 (CET)
X-Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
	by mail.m-online.net (Postfix) with ESMTP id 4DG46D6zRSz1tSQD;
	Wed, 13 Jan 2021 11:52:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
X-Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
	with ESMTP id hwzAhpNZ9fiu; Wed, 13 Jan 2021 11:52:51 +0100 (CET)
X-Auth-Info: qDLO97BLCnveBjvJxF/yiDq4VEhNTP2QiB0DTo/lNm8=
X-Received: from [10.88.0.186] (dslb-002-207-026-175.002.207.pools.vodafone-ip.de [2.207.26.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Wed, 13 Jan 2021 11:52:51 +0100 (CET)
Subject: Re: [cip-dev] [isar-cip-core] [PATCH] swupdate-img.bbclass: add checksum in non signed case as well
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 Henning Schild <henning.schild@siemens.com>
References: <20210111154856.6636-1-henning.schild@siemens.com>
 <59f30d0b-d20a-8087-4b28-5c0fd1f7853c@siemens.com>
From: Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
Message-ID: <5e854316-1b0c-face-c11f-380b556da8d2@denx.de>
Date: Wed, 13 Jan 2021 11:52:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <59f30d0b-d20a-8087-4b28-5c0fd1f7853c@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: xHNRcE74oZIc8yfsceNHZdrGx4520388AA=
Content-Type: multipart/mixed; boundary="0HLcsuNANZ8TiYXfSt06"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610542309;
 bh=wZUTqVtEfICoovNnPtIvoElUSdfi563LPyIupeb7wTc=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=MW1pLxVJfKZ82HyTqCw5M9+cTdWsmvDBNRKAUifyWBYpNg+QjqIRD3YaC5VYq5jHvuE
 AeR8iP4DOkZG8y4+yNvyUb9eKzWEQEo49YxuNwPy+vkq/0mU4tTsUSeywhuZsAq+koHXd
 o7AVqEr7cweVijL97QFwSG+vO5dEI7WaZNY=

--0HLcsuNANZ8TiYXfSt06
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi Jan,

On 2021-01-13 11:46, Jan Kiszka wrote:
> On 11.01.21 16:48, Henning Schild wrote:
>> From: Claudius Heine <ch@denx.de>
>>
> 
> Can you also provide a reasoning here?

I can, but I guess you mean that a commit message should be added here.

Our swupdate has `DISABLE_CPIO_CRC=y` (because our images might be >2GB) 
and we also currently support update via usb stick without any 
signatures. So the only checksum that we have would be the sha256sum 
inside the swdescription.

regards,
Claudius

> 
>> Signed-off-by: Claudius Heine <ch@denx.de>
>> Signed-off-by: Henning Schild <henning.schild@siemens.com>
>> ---
>>   classes/swupdate-img.bbclass | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/classes/swupdate-img.bbclass b/classes/swupdate-img.bbclass
>> index a21d6ec..a7a70f6 100644
>> --- a/classes/swupdate-img.bbclass
>> +++ b/classes/swupdate-img.bbclass
>> @@ -39,14 +39,14 @@ do_swupdate_image() {
>>           image_do_mounts
>>           cp -f '${SIGN_KEY}' '${WORKDIR}/dev.key'
>>           test -e '${SIGN_CRT}' && cp -f '${SIGN_CRT}' '${WORKDIR}/dev.crt'
>> -
>> -        # Fill in file check sums
>> -        for file in ${SWU_ADDITIONAL_FILES}; do
>> -            sed -i "s:$file-sha256:$(sha256sum '${WORKDIR}/swu/'$file | cut -f 1 -d ' '):g" \
>> -                '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
>> -        done
>>       fi
>>   
>> +    # Fill in file check sums
>> +    for file in ${SWU_ADDITIONAL_FILES}; do
>> +        sed -i "s:$file-sha256:$(sha256sum '${WORKDIR}/swu/'$file | cut -f 1 -d ' '):g" \
>> +            '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
>> +    done
>> +
>>       cd "${WORKDIR}/swu"
>>       for file in '${SWU_DESCRIPTION_FILE}' ${SWU_ADDITIONAL_FILES}; do
>>           echo "$file"
>>
> 
> Jan
> 

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de

            PGP key: 6FF2 E59F 00C6 BC28 31D8 64C1 1173 CB19 9808 B153
                              Keyserver: hkp://pool.sks-keyservers.net

--0HLcsuNANZ8TiYXfSt06
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6066): https://lists.cip-project.org/g/cip-dev/message=
/6066
Mute This Topic: https://lists.cip-project.org/mt/79598691/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--0HLcsuNANZ8TiYXfSt06--
