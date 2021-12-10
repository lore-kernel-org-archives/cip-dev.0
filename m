Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE96EC433F5
	for <webhook@archiver.kernel.org>; Fri, 10 Dec 2021 10:43:55 +0000 (UTC)
Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web08.5561.1639133034192784729
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Dec 2021 02:43:54 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.40, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 1BAAhpQ1030182
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 10 Dec 2021 11:43:51 +0100
Received: from [139.22.39.231] ([139.22.39.231])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1BAAhp6H006152;
	Fri, 10 Dec 2021 11:43:51 +0100
Message-ID: <45a6965e-b498-6671-18d7-0e3d7ae5418e@siemens.com>
Date: Fri, 10 Dec 2021 11:43:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [cip-dev][isar-cip-core][PATCH] conf/machine/*: Add variable to
 set version of kernel defconfig
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20211210093448.1860864-1-Quirin.Gylstorff@siemens.com>
 <c482fbfe-53b4-5d80-c84f-914343e224e5@siemens.com>
 <32192e47-078d-ddf5-35d4-68ca7d197616@siemens.com>
 <090f184f-056e-065d-4c82-242f59dcc186@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <090f184f-056e-065d-4c82-242f59dcc186@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by gecko.sbs.de id
 1BAAhpQ1030182
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Dec 2021 10:43:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7088



On 12/10/21 11:40, Jan Kiszka wrote:
> On 10.12.21 11:38, Gylstorff Quirin wrote:
>>
>>
>> On 12/10/21 10:58, Jan Kiszka wrote:
>>> On 10.12.21 10:34, Q. Gylstorff wrote:
>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>
>>>> This fixes an issue, that the defconfig from kernel 4.19.X does not
>>>> work with kernel 5.10.X. The kernel boots but cannot find any qemu h=
ard
>>>> disk.
>>>>
>>>> The fix adds the new Variable
>>>> KERNEL_DEFCONFIG_VERSION to select to correct path in [1].
>>>>
>>>> This fixes issue [17].
>>>>
>>>> [1]: https://gitlab.com/cip-project/cip-kernel/cip-kernel-config
>>>> [17]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues=
/17
>>>>
>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> ---
>>>>  =C2=A0 conf/machine/hihope-rzg2m.conf=C2=A0=C2=A0=C2=A0 | 3 ++-
>>>>  =C2=A0 conf/machine/qemu-amd64.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 3 ++-
>>>>  =C2=A0 conf/machine/qemu-arm.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 3 ++-
>>>>  =C2=A0 conf/machine/qemu-arm64.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 3 ++-
>>>>  =C2=A0 conf/machine/simatic-ipc227e.conf | 3 ++-
>>>>  =C2=A0 kas/opt/4.19.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 ++
>>>>  =C2=A0 kas/opt/4.4.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 ++
>>>>  =C2=A0 kas/opt/5.10.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 ++
>>>>  =C2=A0 8 files changed, 16 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/conf/machine/hihope-rzg2m.conf
>>>> b/conf/machine/hihope-rzg2m.conf
>>>> index 4f4ee81..74f03df 100644
>>>> --- a/conf/machine/hihope-rzg2m.conf
>>>> +++ b/conf/machine/hihope-rzg2m.conf
>>>> @@ -13,7 +13,8 @@ DISTRO_ARCH =3D "arm64"
>>>>  =C2=A0 =C2=A0 IMAGE_TYPE ?=3D "wic-img"
>>>>  =C2=A0 -KERNEL_DEFCONFIG =3D
>>>> "cip-kernel-config/4.19.y-cip/arm64/renesas_defconfig"
>>>> +KERNEL_DEFCONFIG_VERSION ?=3D "5.10.y-cip"
>>>
>>> This variable must be set by the kernel recipe, not the machine.
>>>
>>> Jan
>>
>> Ok, my reasoning was that I want the variable near it usage for
>> readability. It is only used when the KERNEL_DEFCONFIG is from [1].
>>
>=20
> The machine config has no knowledge about the kernel version that is
> going to be used.
>=20
> Jan
>=20

OK I will change it. I will also add it to the rt kernels.

Quirin




