Return-Path: <SRS0=K2V1=GQ=lists.cip-project.org=bounce+64572+6067+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6CBC433E0
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 12:51:50 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA88F233CE
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 12:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA88F233CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6067+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id irm2YY4521723xf1VCH312Ss; Wed, 13 Jan 2021 04:51:49 -0800
X-Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 by mx.groups.io with SMTP id smtpd.web08.6496.1610535735017636390
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jan 2021 03:02:15 -0800
X-Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4DG4K01C0Pz1qv9x;
	Wed, 13 Jan 2021 12:02:12 +0100 (CET)
X-Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
	by mail.m-online.net (Postfix) with ESMTP id 4DG4K01489z1qqkw;
	Wed, 13 Jan 2021 12:02:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
X-Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
	with ESMTP id 63WMl0BD7oQr; Wed, 13 Jan 2021 12:02:11 +0100 (CET)
X-Auth-Info: Z2YG2eOfZwN3Wp4IYOnTSZ+IlFPKJDh72RJPxYJUJM0=
X-Received: from [10.88.0.186] (dslb-002-207-026-175.002.207.pools.vodafone-ip.de [2.207.26.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Wed, 13 Jan 2021 12:02:11 +0100 (CET)
Subject: Re: [cip-dev] [isar-cip-core] [PATCH] swupdate-img.bbclass: add checksum in non signed case as well
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 Henning Schild <henning.schild@siemens.com>
References: <20210111154856.6636-1-henning.schild@siemens.com>
 <59f30d0b-d20a-8087-4b28-5c0fd1f7853c@siemens.com>
 <5e854316-1b0c-face-c11f-380b556da8d2@denx.de>
 <e63169ec-9054-8a8f-730e-8de2addbb259@siemens.com>
From: Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
Message-ID: <2d5779df-0f43-4041-5ce2-c5a736364182@denx.de>
Date: Wed, 13 Jan 2021 12:02:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <e63169ec-9054-8a8f-730e-8de2addbb259@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: MElDcYtHOvv5SrYm2MFqUje7x4520388AA=
Content-Type: multipart/mixed; boundary="mQIJ2Go6C2vpOT2QFpzU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610542309;
 bh=zzfvxQqey/j9aaCV5598PmafeNZugTIe0mqvihh7E2Y=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=PoS/gNFhDGz32U0myMZtiEqjKJaaPPA1/S1oPt/OW1NzfeQPbm5R4PsKI8XHTqX5b2G
 83xU8u7dRu+WiWWM1tvTu05+c68cpbVCQ5SdFf+tVJmElmiWo/k3xf5uwBokrP7HHvhxc
 MEJ3UCAQOewkR/pHgAH4nsCEyEO6b9QPEYM=

--mQIJ2Go6C2vpOT2QFpzU
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2021-01-13 11:55, Jan Kiszka wrote:
> On 13.01.21 11:52, Claudius Heine wrote:
>> Hi Jan,
>>
>> On 2021-01-13 11:46, Jan Kiszka wrote:
>>> On 11.01.21 16:48, Henning Schild wrote:
>>>> From: Claudius Heine <ch@denx.de>
>>>>
>>>
>>> Can you also provide a reasoning here?
>>
>> I can, but I guess you mean that a commit message should be added here=
.
>>
>=20
> ...or that you provide me a text I can fill in on merge.

Ok here is my take:

```
Also unsigned images should contain a checksum in the swdescription, for=20
instance in case `DISABLE_CPIO_CRC=3Dy` is set in swupdate and a USB stic=
k=20
is used for update delivery, only such a checksum would protect against=20
file corruption.
```

regards,
Claudius

>=20
> Jan
>=20
>> Our swupdate has `DISABLE_CPIO_CRC=3Dy` (because our images might be >=
2GB)
>> and we also currently support update via usb stick without any
>> signatures. So the only checksum that we have would be the sha256sum
>> inside the swdescription.
>>
>> regards,
>> Claudius
>>
>>>
>>>> Signed-off-by: Claudius Heine <ch@denx.de>
>>>> Signed-off-by: Henning Schild <henning.schild@siemens.com>
>>>> ---
>>>>  =C2=A0 classes/swupdate-img.bbclass | 12 ++++++------
>>>>  =C2=A0 1 file changed, 6 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/classes/swupdate-img.bbclass b/classes/swupdate-img.bbc=
lass
>>>> index a21d6ec..a7a70f6 100644
>>>> --- a/classes/swupdate-img.bbclass
>>>> +++ b/classes/swupdate-img.bbclass
>>>> @@ -39,14 +39,14 @@ do_swupdate_image() {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 image_do_mou=
nts
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cp -f '${SIG=
N_KEY}' '${WORKDIR}/dev.key'
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test -e '${S=
IGN_CRT}' && cp -f '${SIGN_CRT}'
>>>> '${WORKDIR}/dev.crt'
>>>> -
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Fill in file check sum=
s
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for file in ${SWU_ADDITI=
ONAL_FILES}; do
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
sed -i "s:$file-sha256:$(sha256sum
>>>> '${WORKDIR}/swu/'$file | cut -f 1 -d ' '):g" \
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 done
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>>>  =C2=A0 +=C2=A0=C2=A0=C2=A0 # Fill in file check sums
>>>> +=C2=A0=C2=A0=C2=A0 for file in ${SWU_ADDITIONAL_FILES}; do
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sed -i "s:$file-sha256:$=
(sha256sum '${WORKDIR}/swu/'$file |
>>>> cut -f 1 -d ' '):g" \
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
'${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
>>>> +=C2=A0=C2=A0=C2=A0 done
>>>> +
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cd "${WORKDIR}/swu"
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for file in '${SWU_DESCRIPTION_FILE}=
' ${SWU_ADDITIONAL_FILES}; do
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "$file"
>>>>
>>>
>>> Jan
>>>
>>
>=20
>=20

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de

            PGP key: 6FF2 E59F 00C6 BC28 31D8 64C1 1173 CB19 9808 B153
                              Keyserver: hkp://pool.sks-keyservers.net

--mQIJ2Go6C2vpOT2QFpzU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6067): https://lists.cip-project.org/g/cip-dev/message=
/6067
Mute This Topic: https://lists.cip-project.org/mt/79598691/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--mQIJ2Go6C2vpOT2QFpzU--
