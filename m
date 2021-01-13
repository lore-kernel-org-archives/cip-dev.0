Return-Path: <SRS0=DgK0=GQ=lists.cip-project.org=bounce+64572+6064+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3069BC433DB
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 10:55:12 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3811623136
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 10:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3811623136
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6064+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id tbuIYY4521723xuR3mzoBBTa; Wed, 13 Jan 2021 02:55:10 -0800
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web10.6333.1610535308686276423
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jan 2021 02:55:10 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 10DAt6it006670
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Jan 2021 11:55:06 +0100
X-Received: from [167.87.43.185] ([167.87.43.185])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 10DAt5qd025757;
	Wed, 13 Jan 2021 11:55:05 +0100
Subject: Re: [cip-dev] [isar-cip-core] [PATCH] swupdate-img.bbclass: add checksum in non signed case as well
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org,
        Henning Schild <henning.schild@siemens.com>
References: <20210111154856.6636-1-henning.schild@siemens.com>
 <59f30d0b-d20a-8087-4b28-5c0fd1f7853c@siemens.com>
 <5e854316-1b0c-face-c11f-380b556da8d2@denx.de>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <e63169ec-9054-8a8f-730e-8de2addbb259@siemens.com>
Date: Wed, 13 Jan 2021 11:55:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <5e854316-1b0c-face-c11f-380b556da8d2@denx.de>
X-MIME-Autoconverted: from 8bit to quoted-printable by david.siemens.de id 10DAt6it006670
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: elA6vgjemfSROdNhGYhHwQigx4520388AA=
Content-Type: multipart/mixed; boundary="pAZvjs5mTPdGcTrQbNDI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610535310;
 bh=jL8E1V+7SlH7CSfg0IYKIQADsHyq0Z5UREC8KDtnmdA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=PyWBoE2fXqfn1nmfGCYYKC30SuHzaYy46tvS3XZsHWlNR3CEdU2PwKlAdWkOPcQlyZ4
 flRHPPljNjiFgBMFzbLU5rNt6+uKKEyjB/G7j3C8QiwV82VoYYzccBNI4tuHAL7rRnnRu
 tjmq+efn3+/BB3fkbO/r0jqBaXP+Pa2lWSU=

--pAZvjs5mTPdGcTrQbNDI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.01.21 11:52, Claudius Heine wrote:
> Hi Jan,
>=20
> On 2021-01-13 11:46, Jan Kiszka wrote:
>> On 11.01.21 16:48, Henning Schild wrote:
>>> From: Claudius Heine <ch@denx.de>
>>>
>>
>> Can you also provide a reasoning here?
>=20
> I can, but I guess you mean that a commit message should be added here.
>=20

...or that you provide me a text I can fill in on merge.

Jan

> Our swupdate has `DISABLE_CPIO_CRC=3Dy` (because our images might be >2=
GB)
> and we also currently support update via usb stick without any
> signatures. So the only checksum that we have would be the sha256sum
> inside the swdescription.
>=20
> regards,
> Claudius
>=20
>>
>>> Signed-off-by: Claudius Heine <ch@denx.de>
>>> Signed-off-by: Henning Schild <henning.schild@siemens.com>
>>> ---
>>> =C2=A0 classes/swupdate-img.bbclass | 12 ++++++------
>>> =C2=A0 1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/classes/swupdate-img.bbclass b/classes/swupdate-img.bbcl=
ass
>>> index a21d6ec..a7a70f6 100644
>>> --- a/classes/swupdate-img.bbclass
>>> +++ b/classes/swupdate-img.bbclass
>>> @@ -39,14 +39,14 @@ do_swupdate_image() {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 image_do_mount=
s
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cp -f '${SIGN_=
KEY}' '${WORKDIR}/dev.key'
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test -e '${SIG=
N_CRT}' && cp -f '${SIGN_CRT}'
>>> '${WORKDIR}/dev.crt'
>>> -
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Fill in file check sums
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for file in ${SWU_ADDITIO=
NAL_FILES}; do
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
ed -i "s:$file-sha256:$(sha256sum
>>> '${WORKDIR}/swu/'$file | cut -f 1 -d ' '):g" \
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 done
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 # Fill in file check sums
>>> +=C2=A0=C2=A0=C2=A0 for file in ${SWU_ADDITIONAL_FILES}; do
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sed -i "s:$file-sha256:$(=
sha256sum '${WORKDIR}/swu/'$file |
>>> cut -f 1 -d ' '):g" \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '=
${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
>>> +=C2=A0=C2=A0=C2=A0 done
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cd "${WORKDIR}/swu"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for file in '${SWU_DESCRIPTION_FILE}' =
${SWU_ADDITIONAL_FILES}; do
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "$file"
>>>
>>
>> Jan
>>
>=20


--=20
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--pAZvjs5mTPdGcTrQbNDI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6064): https://lists.cip-project.org/g/cip-dev/message=
/6064
Mute This Topic: https://lists.cip-project.org/mt/79598691/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--pAZvjs5mTPdGcTrQbNDI--
