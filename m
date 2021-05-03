Return-Path: <SRS0=DQEJ=J6=lists.cip-project.org=bounce+64572+6414+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF15C433B4
	for <cip-dev@archiver.kernel.org>; Mon,  3 May 2021 11:44:55 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B00061168
	for <cip-dev@archiver.kernel.org>; Mon,  3 May 2021 11:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B00061168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6414+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 9PyhYY4521723xVP5bOEyUdt; Mon, 03 May 2021 04:44:54 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web08.32327.1620042293758560070
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 May 2021 04:44:54 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 143BipnY031780
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 3 May 2021 13:44:52 +0200
X-Received: from [167.87.240.129] ([167.87.240.129])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 143Bipb9023184;
	Mon, 3 May 2021 13:44:51 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] swupdate-config: add prefix to variables
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20210430122020.13407-1-Quirin.Gylstorff@siemens.com>
 <20210430130134.22257-1-Quirin.Gylstorff@siemens.com>
 <d8c95cb7-58ae-9947-8975-3bfe227aef8e@siemens.com>
 <ec1332f7-6c1f-180c-7842-7f1ab9c15e11@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <95da2602-4572-56b8-b450-9c4f05ed5888@siemens.com>
Date: Mon, 3 May 2021 13:44:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <ec1332f7-6c1f-180c-7842-7f1ab9c15e11@siemens.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by gecko.sbs.de id 143BipnY031780
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uL31klilbH5AbAEqaL4ToHThx4520388AA=
Content-Type: multipart/mixed; boundary="d4EpI2r3Cqyew1Ss7z0B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620042294;
 bh=8hPRDdlsBkhbFhj03/KhMr/49iDAly+LknZovu0wCm4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=NWECj7SpfDm345nxTi489/W3TngD21tKhD27CAdjlE1V4YsKzvfYX0vn8DRBZ/CWT4y
 ELbckSKivwz3sp7M05ygMiTarZSEtyhJ3acjdNyARCSoL3GcwEq5ZGm67ov9fAA14h0Lp
 mFVwubAveDUWoGr+DfFKvlN5I3WcVQil4bU=

--d4EpI2r3Cqyew1Ss7z0B
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.05.21 13:28, Gylstorff Quirin wrote:
>=20
>=20
> On 4/30/21 4:50 PM, Jan Kiszka wrote:
>> On 30.04.21 15:01, Q. Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> The variables U_BOOT and BOOTLOADER are only used for swupdate.
>>> Add the prefix SWUPDATE to indicate the intended usage.
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> Changes in V2:
>>> =C2=A0 - fix typo in commit message
>>> =C2=A0 - use variable in kas/opt/*.yml
>>>
>>> =C2=A0 classes/swupdate-config.bbclass=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 10 +++++-----
>>> =C2=A0 kas/opt/ebg-secure-boot-snakeoil.yml |=C2=A0 2 +-
>>> =C2=A0 kas/opt/ebg-swu.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
>>> =C2=A0 kas/opt/qemu-swupdate.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>> =C2=A0 4 files changed, 9 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/classes/swupdate-config.bbclass
>>> b/classes/swupdate-config.bbclass
>>> index 9909113..0c1067a 100644
>>> --- a/classes/swupdate-config.bbclass
>>> +++ b/classes/swupdate-config.bbclass
>>> @@ -51,13 +51,13 @@ KFEATURE_u-boot[BUILD_DEB_DEPENDS] =3D
>>> "libubootenv-dev"
>>> =C2=A0 KFEATURE_u-boot[DEBIAN_DEPENDS] =3D "${@ 'libubootenv0.1,
>>> u-boot-${MACHINE}-config' \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if
>>> d.getVar("USE_U_BOOT_CONFIG", True) =3D=3D "true" \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else 'libubootenv0.1'}"
>>> -KFEATURE_u-boot[DEPENDS] =3D "${U_BOOT} libubootenv"
>>> +KFEATURE_u-boot[DEPENDS] =3D "${SWUPDATE_U_BOOT} libubootenv"
>>
>> Still leaves me and probably other users clueless what SWUPDATE_U_BOOT
>> should be. Simply "u-boot-${MACHINE}"?
>>
>> Jan
>>
>=20
> SWUPDATE_U_BOOT should be the name of the u-boot package.
>=20
> In case the layer (e.g. isar-cip-core) supplies the u-boot binary,
> `SWUPDATE_U_BOOT` should be defined as `u-boot-${MACHINE}`.
>=20
>=20
> Debian provides some as package, e.g. [1].
>=20
>=20
> I could add `u-boot-${MACHINE}` as default and a README section.
>=20
>=20
> [1]: https://packages.debian.org/buster/u-boot-imx
>=20

But does SWUpdate really depends on the U-Boot binary that is going to
be put on the device - or rather on u-boot-config? This looks fishy.

Jan

--=20
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--d4EpI2r3Cqyew1Ss7z0B
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6414): https://lists.cip-project.org/g/cip-dev/message=
/6414
Mute This Topic: https://lists.cip-project.org/mt/82480672/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--d4EpI2r3Cqyew1Ss7z0B--
