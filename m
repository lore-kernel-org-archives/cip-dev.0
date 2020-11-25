Return-Path: <SRS0=bIEi=E7=lists.cip-project.org=bounce+64572+5877+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644F2C56201
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 09:02:06 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C3C206F9
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 09:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="dzSvwf2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C3C206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5877+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id EDlzYY4521723x6rxf6O4Jsg; Wed, 25 Nov 2020 01:02:04 -0800
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web11.4300.1606294923275412717
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Nov 2020 01:02:03 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 0AP921Hn013709
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 25 Nov 2020 10:02:01 +0100
X-Received: from [167.87.32.40] ([167.87.32.40])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0AP9205R026588;
	Wed, 25 Nov 2020 10:02:01 +0100
Subject: Re: [cip-dev] [isar-cip-core][PATCH] classes/image_uuid: Generate new uuid if a new package is added
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20200918080435.24136-1-Quirin.Gylstorff@siemens.com>
 <c02e7a38-5bc1-7e4a-61fe-77cce775acab@siemens.com>
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
Message-ID: <32a2f76f-eb9c-7be2-0ce0-db1b4d4016d8@siemens.com>
Date: Wed, 25 Nov 2020 10:02:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <c02e7a38-5bc1-7e4a-61fe-77cce775acab@siemens.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by david.siemens.de id 0AP921Hn013709
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7nbj90dKAqLPESNi0bmhSn6cx4520388AA=
Content-Type: multipart/mixed; boundary="i1YHoqWoGRp20y2vXbUb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606294924;
 bh=ArSHoai4kHveUzZYtNLpXLzKNHQu0fqgoSph7KWq+J4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=dzSvwf2zvlvu+8KarP087Rxxljw3tC8SAZCbvR7udtyTmhMoOiLPhjpkIsI7sijury3
 DM6eqsR3TsUrWWilZGP7ZveZqHs6jU8+i4WSPX+0DSk02sVQaURgEsj/D209oU87I06g8
 ogb0PG368ZW3VTZCPX0udATdTyZsaU9pADA=

--i1YHoqWoGRp20y2vXbUb
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 9/18/20 2:21 PM, Jan Kiszka wrote:
> On 18.09.20 10:04, Q. Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> BB_BASEHASH only includes the task itself and its metadata.
>> Dependencies are not taken into account when this hash is
>> generated which means updating a package will not generate a new
>> UUID.
>>
>> BB_TASKHASH takes the changes into account.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> =C2=A0 classes/image_uuid.bbclass | 20 ++++++++++----------
>> =C2=A0 1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
>> index d5337b8..873abc5 100644
>> --- a/classes/image_uuid.bbclass
>> +++ b/classes/image_uuid.bbclass
>> @@ -9,23 +9,23 @@
>> =C2=A0 # SPDX-License-Identifier: MIT
>> =C2=A0 #
>> -def generate_image_uuid(d):
>> -=C2=A0=C2=A0=C2=A0 import uuid
>> +IMAGE_UUID ?=3D "random"
>=20
> Why not using an undefined or empty IMAGE_UUID as "generate me one"=20
> indication?

I will try to use the previous version after testing it has the same=20
effect as this patch.

>=20
>> -=C2=A0=C2=A0=C2=A0 base_hash =3D d.getVar("BB_BASEHASH_task-do_rootfs=
_install", True)
>> -=C2=A0=C2=A0=C2=A0 if base_hash is None:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return None
>> -=C2=A0=C2=A0=C2=A0 return str(uuid.UUID(base_hash[:32], version=3D4))
>> -
>> -IMAGE_UUID ?=3D "${@generate_image_uuid(d)}"
>> +IMAGE_UUID_NAMESPACE =3D "6090f47e-b068-475c-b125-7be7c24cdd4e"
>=20
> Is that namespace random, or does that have specific meaning?
The namespace is random.
>=20
>> =C2=A0 do_generate_image_uuid[vardeps] +=3D "IMAGE_UUID"
>> =C2=A0 do_generate_image_uuid[depends] =3D "buildchroot-target:do_buil=
d"
>> +IMAGER_INSTALL +=3D "uuid-runtime"
>=20
> Please separate variable for job definitions be a blank line. Also the=20
> job specifications above should be visually separated from the code=20
> below that way. IOW:
>=20
> IMAGER_INSTALL +=3D "uuid-runtime"
>=20
> do_generate_image_uuid[vardeps] +=3D "IMAGE_UUID"
> do_generate_image_uuid[depends] =3D "buildchroot-target:do_build"
>=20
> do_generate_image_uuid() {
>

Replace with a sipmler version in v2.

>> =C2=A0 do_generate_image_uuid() {
>> +=C2=A0=C2=A0=C2=A0 image_do_mounts
>> +=C2=A0=C2=A0=C2=A0 if [ "${IMAGE_UUID}" !=3D "random" ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IMAGE_UUID_FINAL=3D"${IMAG=
E_UUID}"
>> +=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IMAGE_UUID_FINAL=3D"$(sudo=
 -E chroot ${BUILDCHROOT_DIR} uuidgen=20
>> -s -n "${IMAGE_UUID_NAMESPACE}" -N "${BB_TASKHASH}")"
>=20
> Why do we need to switch to uuidgen from the buildchroot, rather than=20
> using python's uuid?
>=20
> And what ensures that uuidgen is available there?

I switch back to python to avoid unnecassary package installations.
See v2.

>=20
>> +=C2=A0=C2=A0=C2=A0 fi
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sudo sed -i '/^IMAGE_UUID=3D.*/d' '${IM=
AGE_ROOTFS}/etc/os-release'
>> -=C2=A0=C2=A0=C2=A0 echo "IMAGE_UUID=3D\"${IMAGE_UUID}\"" | \
>> +=C2=A0=C2=A0=C2=A0 echo "IMAGE_UUID=3D\"${IMAGE_UUID_FINAL}\"" | \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sudo tee -a '${=
IMAGE_ROOTFS}/etc/os-release'
>> -=C2=A0=C2=A0=C2=A0 image_do_mounts
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # update initramfs to add uuid
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sudo chroot '${IMAGE_ROOTFS}' update-in=
itramfs -u
>>
>=20
> Jan
>=20
Quirin

--i1YHoqWoGRp20y2vXbUb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5877): https://lists.cip-project.org/g/cip-dev/message=
/5877
Mute This Topic: https://lists.cip-project.org/mt/76926695/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--i1YHoqWoGRp20y2vXbUb--
