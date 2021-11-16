Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A7CC433EF
	for <webhook@archiver.kernel.org>; Tue, 16 Nov 2021 07:26:02 +0000 (UTC)
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web11.6817.1637047561138259807
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 23:26:01 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.14, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AG7PvCH020606
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Nov 2021 08:25:57 +0100
Received: from [167.87.0.79] ([167.87.0.79])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AG7Putq011030;
	Tue, 16 Nov 2021 08:25:57 +0100
Subject: Re: [cip-dev] [PATCH] cip-core-image-security: remove unnecessary
 dependency package names
To: Venkata.Pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
References: <20211115161554.24270-1-venkata.pyla@toshiba-tsip.com>
 <f222455d-19e3-d047-a4b8-afa5ad6f7700@siemens.com>
 <OSYPR01MB5542E50807C642D356B91EFFA4999@OSYPR01MB5542.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <962c7ab8-0bf3-2d13-3ea0-af55e7c91ef5@siemens.com>
Date: Tue, 16 Nov 2021 08:25:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: 
 <OSYPR01MB5542E50807C642D356B91EFFA4999@OSYPR01MB5542.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by david.siemens.de id
 1AG7PvCH020606
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Nov 2021 07:26:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6923

On 16.11.21 06:11, Venkata.Pyla@toshiba-tsip.com wrote:
>=20
>=20
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On=
 Behalf Of
>> Jan Kiszka
>> Sent: 16 November 2021 00:16
>> To: pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0) <Venkata.Pyla@t=
oshiba-tsip.com>; cip-
>> dev@lists.cip-project.org
>> Subject: Re: [cip-dev] [PATCH] cip-core-image-security: remove unneces=
sary
>> dependency package names
>>
>> On 15.11.21 17:15, venkata.pyla@toshiba-tsip.com wrote:
>>> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>>
>>> It is not necessary to mention dependency package names when parent
>>> package is present, the dependency packages will automatically instal=
l
>>> by isar framework.
>>>
>>> so removing the dependency packages which are not necessary.
>>>
>>> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>> ---
>>>  recipes-core/images/cip-core-image-security.bb | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/recipes-core/images/cip-core-image-security.bb
>>> b/recipes-core/images/cip-core-image-security.bb
>>> index 61ddc39..6c41b00 100644
>>> --- a/recipes-core/images/cip-core-image-security.bb
>>> +++ b/recipes-core/images/cip-core-image-security.bb
>>> @@ -17,12 +17,12 @@ IMAGE_INSTALL +=3D "security-customizations"
>>>
>>>  # Debian packages that provide security features  IMAGE_PREINSTALL +=
=3D
>>> " \
>>> -	openssl libssl1.1 \
>>> +	openssl \
>>>  	fail2ban \
>>>  	openssh-server openssh-sftp-server openssh-client \
>>>  	syslog-ng-core syslog-ng-mod-journal \
>>> -	aide aide-common \
>>> -	libnftables0 nftables \
>>> +	aide \
>>> +	nftables \
>>>  	libpam-pkcs11 \
>>>  	chrony \
>>>  	tpm2-tools \
>>> @@ -30,7 +30,7 @@ IMAGE_PREINSTALL +=3D " \
>>>  	libtss2-esys0 libtss2-udev \
>>>  	libpam-cracklib \
>>>  	acl \
>>> -	libauparse0 audispd-plugins auditd \
>>> +	audispd-plugins auditd \
>>>  	uuid-runtime \
>>>  	sudo \
>>>  "
>>>
>>
>> Was the list possibly intended to list all packages explicitly that ar=
e security
>> related? If not or that was incomplete anyway, this is fine.
>=20
> The original intention of the package list is to mention it explicitly =
all the packages required to achieve the security functionality,  even th=
ough some of the packages are dependency packages of the main package.
>=20
> I Just want to remove the dependency packages because, their names are =
changed when different distribution version (buster, bullseye, etc) is us=
ed like below
> [buster]
>   Package: nftables
>        Dep: libnftables0
> [bullseye]=20
>   Package: nftables
>        Dep: libnftables1
> So, I have removed the dependency packages here and allowed package-man=
ager to install the correct dependency packages.

OK, would be good to document that in the commit message.

>=20
> But, still there is problem when the main package itself has different =
name in the other distribution version, in this case should we have diffe=
rent recipe for each distribution version? Please suggest if there is any=
 to resolve such scenarios.
> [buster]
>   Package: libtss2-esys0
> [bullseye]
>   Package: libtss2-esys-3.0.2-0

OVERRIDES_append =3D ":${BASE_DISTRO_CODENAME}"

IMAGE_PREINSTALL_append_buster =3D "libtss2-esys0"
IMAGE_PREINSTALL_append_bullseye =3D "libtss2-esys-3.0.2-0"

Jan

--=20
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

