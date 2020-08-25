Return-Path: <SRS0=WY//=CD=lists.cip-project.org=bounce+64572+5237+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E646C433DF
	for <cip-dev@archiver.kernel.org>; Tue, 25 Aug 2020 05:17:32 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB8120737
	for <cip-dev@archiver.kernel.org>; Tue, 25 Aug 2020 05:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="oD2+Mlmx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB8120737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5237+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id pnOXYY4521723xklR0aIXJYT; Mon, 24 Aug 2020 22:17:31 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web12.7603.1598332649390328486
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Aug 2020 22:17:30 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 07P5HP5I019846
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2020 07:17:26 +0200
X-Received: from [167.87.131.58] ([167.87.131.58])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07P5HMMu016846;
	Tue, 25 Aug 2020 07:17:24 +0200
Subject: Re: [cip-dev] [isar-cip-core][PATCH 1/2] ci: Rewrite using extends
From: "Jan Kiszka" <jan.kiszka@siemens.com>
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        cip-dev@lists.cip-project.org
References: <20200820082434.1302460-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <4f1fd7b8-4fc0-714b-8205-e6a6b93929d8@siemens.com>
 <997dba20-23b6-a170-6a89-b6a894b13e69@siemens.com>
Message-ID: <d696dd0e-5e47-7927-ea5f-0843195fcd47@siemens.com>
Date: Tue, 25 Aug 2020 07:17:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <997dba20-23b6-a170-6a89-b6a894b13e69@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: avUXGKGWgPcW6T7Z6buGJz8Vx4520388AA=
Content-Type: multipart/mixed; boundary="HdmTQXnUDRkXkULb726u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598332651;
 bh=JKYaWMeLkQIQSyvP3anAMpoxBlsI9IQRCoEycYBtwKg=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=oD2+Mlmx9ePD819JYOHIFVwsKWkPd5DwGwigcRvsqUjTPNq+ZEASz2N8VIkLmImhXdz
 7Je3eBj5Dd5I+gLa9UhJA0/RxIhglHbi8OxEkmA7mSwvbqHFWs/73RNh2GhULQD98uxWO
 ktkb1XLJydK7Z1idhFCSZEK3AAekbkozxtw=

--HdmTQXnUDRkXkULb726u
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 21.08.20 18:44, Jan Kiszka wrote:
> On 21.08.20 17:04, Jan Kiszka wrote:
>> On 20.08.20 10:24, Nobuhiro Iwamatsu wrote:
>>> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>>> ---
>>>  .gitlab-ci.yml             | 70 +++++++++++++++++++++++++++++---------
>>>  scripts/deploy-cip-core.sh |  8 +++--
>>>  2 files changed, 60 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>>> index 3fe7af2..e23345f 100644
>>> --- a/.gitlab-ci.yml
>>> +++ b/.gitlab-ci.yml
>>> @@ -2,10 +2,17 @@ image: kasproject/kas-isar:1.1
>>>  
>>>  variables:
>>>    GIT_STRATEGY: clone
>>> +  release: buster
>>> +  extention: base
>>> +  use_rt: enable
>>> +  targz: enable
>>> +  dtb: none
>>>  
>>> -all:
>>> -  stage: build
>>> -  script:
>>> +stages:
>>> +  - build
>>> +
>>> +default:
>>> +  before_script:
>>>      - export http_proxy=$HTTP_PROXY
>>>      - export https_proxy=$HTTPS_PROXY
>>>      - export ftp_proxy=$FTP_PROXY
>>> @@ -13,20 +20,51 @@ all:
>>>      - export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
>>>      - export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
>>>  
>>> -    - kas build kas-cip.yml:kas/board/simatic-ipc227e.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
>>> -    - scripts/deploy-cip-core.sh buster simatic-ipc227e
>>> -
>>> +.build_base:
>>> +  stage: build
>>> +  variables:
>>> +    base_yaml: "kas-cip.yml:kas/board/${target}.yml"
>>> +  script:
>>>      - sudo rm -rf build/tmp
>>> -    - kas build kas-cip.yml:kas/board/bbb.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
>>> -    - scripts/deploy-cip-core.sh buster bbb am335x-boneblack.dtb
>>> +    - if [ "${use_rt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/rt.yml"; fi;
>>> +    - if [ "${extention}" != "base" ]; then base_yaml="${base_yaml}:kas/opt/${extention}.yml"; fi;
>>> +    - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi;
>>> +    - kas build ${base_yaml}
>>> +    - scripts/deploy-cip-core.sh ${release} ${target} ${extention} ${dtb}
>>>  
>>> -    - sudo rm -rf build/tmp
>>> -    - kas build kas-cip.yml:kas/board/iwg20m.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
>>> -    - scripts/deploy-cip-core.sh buster iwg20m r8a7743-iwg20d-q7-dbcm-ca.dtb
>>> +# base image
>>> +build:simatic-ipc227e-base:
>>> +  extends:
>>> +    - .build_base
>>> +  variables:
>>> +    target: simatic-ipc227e
>>>  
>>> -    - sudo rm -rf build/tmp
>>> -    - kas build kas-cip.yml:kas/board/rzg2m.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
>>> -    - scripts/deploy-cip-core.sh buster hihope-rzg2m renesas/r8a774a1-hihope-rzg2m-ex.dtb
>>> +build:bbb-base:
>>> +  extends:
>>> +    - .build_base
>>> +  variables:
>>> +    target: bbb
>>> +    dtb: am335x-boneblack.dtb
>>>  
>>> -    - sudo rm -rf build/tmp
>>> -    - kas build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/security.yml
>>> +build:iwg20m-base:
>>> +  extends:
>>> +    - .build_base
>>> +  variables:
>>> +    target: iwg20m
>>> +    dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
>>> +
>>> +build:hihope-rzg2m-base:
>>> +  extends:
>>> +    - .build_base
>>> +  variables:
>>> +    target: rzg2m
>>> +    dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
>>> +
>>> +build:qemu-amd64-base:
>>> +  extends:
>>> +    - .build_base
>>> +  variables:
>>> +    target: qemu-amd64
>>> +    extention: security
>>> +    use_rt: disable
>>> +    targz: disable
>>> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
>>> index 4c8d4c9..5b7eab9 100755
>>> --- a/scripts/deploy-cip-core.sh
>>> +++ b/scripts/deploy-cip-core.sh
>>> @@ -16,9 +16,13 @@ fi
>>>  
>>>  RELEASE=$1
>>>  TARGET=$2
>>> -DTB=$3
>>> +EXTENSION=$3
>>> +DTB=$4
>>>  
>>>  BASE_PATH=build/tmp/deploy/images/$TARGET/cip-core-image-cip-core-$RELEASE-$TARGET
>>> +if [ "${EXTENSION}" != "base" ] ; then
>>> +	BASE_PATH=build/tmp/deploy/images/$TARGET/cip-core-image-cip-core-$RELEASE-$TARGET-$EXTENSION
>>> +fi
>>>  
>>>  echo "Compressing cip-core-image-cip-core-$RELEASE-$TARGET.wic.img..."
>>>  xz -9 -k $BASE_PATH.wic.img
>>> @@ -38,6 +42,6 @@ fi
>>>  aws s3 cp --no-progress $KERNEL_IMAGE s3://download.cip-project.org/cip-core/$TARGET/
>>>  aws s3 cp --no-progress $BASE_PATH-initrd.img s3://download.cip-project.org/cip-core/$TARGET/
>>>  
>>> -if [ -n "$DTB" ]; then
>>> +if [ "$DTB" != "none" ]; then
>>>  	aws s3 cp --no-progress build/tmp/work/cip-core-*/linux-cip*/*/linux-cip-*/debian/linux-image-cip*/usr/lib/linux-image-*/$DTB s3://download.cip-project.org/cip-core/$TARGET/
>>>  fi
>>>
>>
>> Unfortunately, this scale out to multiple jobs seem to cause download
>> issues, see e.g.
>>
>> - https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/697844276
>> - https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/696946649
>>
>> First thought it was a sporadic hic-up, but it reoccurs, now with
>> master. Is kernel.org throttling us here?
>>
> 
> And I'm afraid there is more broken, namely in the deployment that is
> only triggered over master. Please have a look at the failing jobs.
> 

Ping - or should I revert those two for now?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--HdmTQXnUDRkXkULb726u
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5237): https://lists.cip-project.org/g/cip-dev/message=
/5237
Mute This Topic: https://lists.cip-project.org/mt/76304024/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--HdmTQXnUDRkXkULb726u--
