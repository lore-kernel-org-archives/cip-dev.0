Return-Path: <SRS0=4KPl=BJ=lists.cip-project.org=bounce+64572+5059+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32693C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 05:59:08 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003CD2083E
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 05:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="IHEpB0JL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003CD2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5059+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id CAMgYY4521723xUkG8XDZK8l; Wed, 29 Jul 2020 22:59:07 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web11.2551.1596088746063708697
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jul 2020 22:59:06 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 06U5x30V000477
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2020 07:59:04 +0200
X-Received: from [167.87.91.228] ([167.87.91.228])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06U5x2R9007814;
	Thu, 30 Jul 2020 07:59:03 +0200
Subject: Re: [cip-dev] [PATCH 3/3] README: Add steps to build cip-security image
To: daniel.sangorrin@toshiba.co.jp, cip-dev@lists.cip-project.org
Cc: Venkata.Pyla@toshiba-tsip.com
References: <544b0f34-c55b-2be1-d672-6a5eb796403e@siemens.com>
 <30764.1595573908018751968@lists.cip-project.org>
 <OSBPR01MB20533E649110E28C3CB9B5E5D0710@OSBPR01MB2053.jpnprd01.prod.outlook.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <de6bb645-59dc-3ecb-82a6-078684e0a2a1@siemens.com>
Date: Thu, 30 Jul 2020 07:59:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB20533E649110E28C3CB9B5E5D0710@OSBPR01MB2053.jpnprd01.prod.outlook.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: J7UgE9Xzqog36xs207txEuk8x4520388AA=
Content-Type: multipart/mixed; boundary="fHjS8oRtsylsLiXAca9j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596088747;
 bh=fCmiOMjzg+RadXBeaLgkTbiSo/Gw+tu6NyHVMDZ6ruM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=IHEpB0JLzI7ATdwyZm6BkFOJ5dULOyQ+QOBV49zchcYTSqOrDWM7GF5CGMIC6AOsOi7
 cyFMCYu+Y4hHiXHQus7HQu/Wo8HL68jbvaIMvSnil4ozYVfIdgyLQPMx7QROnE7D/Rmt8
 l7WR7noMkkKmIo4FdR5ocV4l9buaVFbMPC8=

--fHjS8oRtsylsLiXAca9j
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 30.07.20 02:07, daniel.sangorrin@toshiba.co.jp wrote:
> Hi Venkata-san
> 
> Maybe Jan didn't see your e-mail because he wasn't in the CC.
> 
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Behalf Of Venkata Pyla
>> Sent: Friday, July 24, 2020 3:58 PM
>> To: cip-dev@lists.cip-project.org
>> Subject: Re: [cip-dev] [PATCH 3/3] README: Add steps to build cip-security image
>>
>> Hi Jan,
>>
>> On Thu, Jul 23, 2020 at 04:10 PM, Jan Kiszka wrote:
>>
>>>
>>> On 21.07.20 10:16, Venkata Pyla wrote:
>>>> From: venkata <venkata.pyla@toshiba-tsip.com>
>>>>
>>>> Signed-off-by: venkata <venkata.pyla@toshiba-tsip.com>
>>>> ---
>>>>    README.md | 10 ++++++++++
>>>>    1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/README.md b/README.md
>>>> index bbad1a0..b2c4166 100644
>>>> --- a/README.md
>>>> +++ b/README.md
>>>> @@ -36,6 +36,16 @@ card, run
>>>>        dd
>>> if=build/tmp/deploy/images/bbb/cip-core-image-cip-core-buster-bbb.wic.
>>> img \
>>>>           of=/dev/<medium-device> bs=1M status=progress
>>>>
>>>> +## Building Security target images
>>>> +Building images for QEMU x86-64bit machine
>>>> +
>>>> +    ./kas-docker --isar build --target cip-core-image-security
>>> kas.yml:board-qemu-amd64.yml
>>>> +
>>>> +Run the generated securiy images on QEMU (x86-64bit)
>>>> +
>>>> +    TARGET_IMAGE=cip-core-image-security ./start-qemu.sh amd64
>>>> +
>>>> +
>>>>    ## Community Resources
>>>>
>>>>    TBD
>>>>
>>>
>>> This patch is fine, but I'm missing 4/4: Add this image to CI (same
>>> comment as I had on the MR on gitlab).
>>>
>>
>> Adding cip security image to CI,
>> i need some suggestions to use the current format present in .gitlab-ci.yml
>>
>> Currently i have the below problem for using script deploy-cip-core.sh:
>> 1. image name formation in the script should have another variable
>>           .../$IMG_PREFIX-cip-core-$RELEASE-$TARGET
>>           where $IMG_PREFIX is default to "cip-core-image"  if not specified
>>            for security image it will be passed as 4th argument "cip-core-image-security"
>> 2. currently scrit is expecting the image format in *.wic.img so,
>>         for qemu i think we should have wks file to generate image with format .wic.img
>>
>> or for this security image do we need to deploy it seperatley?
>> please guide me
> 
> Sometimes it is better to send a patch instead of trying to explain it with words.
> 

I've replied on the deployment question already.

If there is a need for the security artifacts already, we need to 
enhance the deployment for that particular use case - but I doubt there 
is at this point, otherwise the series had carried CI in the first place.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--fHjS8oRtsylsLiXAca9j
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5059): https://lists.cip-project.org/g/cip-dev/message=
/5059
Mute This Topic: https://lists.cip-project.org/mt/75699595/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--fHjS8oRtsylsLiXAca9j--
