Return-Path: <SRS0=Ha/X=OY=lists.cip-project.org=bounce+64572+6774+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5D4C433EF
	for <cip-dev@archiver.kernel.org>; Mon,  4 Oct 2021 12:46:08 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC1746124C
	for <cip-dev@archiver.kernel.org>; Mon,  4 Oct 2021 12:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EC1746124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id tG6xYY4521723x9PGgASBRuL; Mon, 04 Oct 2021 05:46:07 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web12.8723.1633351566369432398
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Oct 2021 05:46:07 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 194Ck3la017524
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Oct 2021 14:46:03 +0200
X-Received: from [139.22.41.233] ([139.22.41.233])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 194Ck2mH004059;
	Mon, 4 Oct 2021 14:46:03 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH 1/2] kas/opt/swupdate: Change assignment of IMAGE_TYPE and WKS_FILE
To: Jan Kiszka <jan.kiszka@siemens.com>
References: <20210928184948.737071-1-Quirin.Gylstorff@siemens.com>
 <20210928184947.AYjduU9bTolWO5fGM5sHK1KwOFt_xWwyNQv5uQOgPvk@z>
 <5da61997-9b25-d965-9d5b-0f148c8f4e5b@siemens.com>
 <be00776f-c1c5-9c84-c904-2d8e17cc298d@siemens.com>
Cc: "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
        "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
Organization: Siemens
Message-ID: <38973f2f-7d8f-65c5-b6f1-257732618292@siemens.com>
Date: Mon, 4 Oct 2021 14:46:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <be00776f-c1c5-9c84-c904-2d8e17cc298d@siemens.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: xKwqRvZelZd65Lp08zgodxkkx4520388AA=
Content-Type: multipart/mixed; boundary="byV8sjutVvzXk4YsdQ8I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633351567;
 bh=mFV0J5PDRVq63q/AwsC6n/1Nbqhc7n320RUTnSu+vZo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Vy+8fk0FPy3u/ypu+HRayIgZ9DSE8ts/5BZUvsKYhCoMF48hrgsWF9DyjXkddL7OIuc
 xV5Dfd8uVQGnLnvIq3j4GiQv4qQOiupFPBAU75dWHNztVPzcHs/aYs/E4Qi8/WZ/5FmZ5
 wN/hSslB5sdLQSYlMFNRqh3/dSuN/l3TZHw=
Message-ID: <20211004124602.39BZPOM8oM8lmou2q3JbLZmt3JzhTFnGwYQ46MOsOMI@z>

--byV8sjutVvzXk4YsdQ8I
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 10/4/21 12:37 PM, Jan Kiszka wrote:
> On 04.10.21 11:28, Jan Kiszka wrote:
>> On 28.09.21 20:49, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> Replace the default assignment to ensure the generation of the
>>> swu file. As stated in [1]: If multiple `?=` assignments are used
>>> the first of those assignments ends up getting used.
>>>
>>> This fixes [2].
>>>
>>> [1]: https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-metadata.html#setting-a-default-value
>>> [2]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/14
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>>   kas/opt/swupdate.yml | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
>>> index 7d86ad5..3cc02a3 100644
>>> --- a/kas/opt/swupdate.yml
>>> +++ b/kas/opt/swupdate.yml
>>> @@ -19,5 +19,5 @@ local_conf_header:
>>>       IMAGE_INSTALL_append = " swupdate"
>>>   
>>>     wic-swu: |
>>> -    IMAGE_TYPE ?= "wic-swu-img"
>>> -    WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
>>> +    IMAGE_TYPE = "wic-swu-img"
>>> +    WKS_FILE = "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
>>>
>>>
>>
>> Thanks, applied.
>>
> 
> Something seems to break:
> 
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/381889283
> 
> Could you have a look?
> 
> We also had fetching issues against gitlab, but those were "solved" by
> retrying and were surely not triggered by this patch.

Sure I will take a look.

Quirin

> 
> Jan
> 





--byV8sjutVvzXk4YsdQ8I
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6774): https://lists.cip-project.org/g/cip-dev/message/=
6774
Mute This Topic: https://lists.cip-project.org/mt/86062392/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--byV8sjutVvzXk4YsdQ8I--
