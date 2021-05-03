Return-Path: <SRS0=U9kM=J6=lists.cip-project.org=bounce+64572+6416+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1C7C433ED
	for <cip-dev@archiver.kernel.org>; Mon,  3 May 2021 17:32:46 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7CAE610A6
	for <cip-dev@archiver.kernel.org>; Mon,  3 May 2021 17:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CAE610A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6416+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 7OEhYY4521723xrL114XhKey; Mon, 03 May 2021 10:32:45 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web10.287.1620063164282299232
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 May 2021 10:32:44 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 143HWfb1026488
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 3 May 2021 19:32:42 +0200
X-Received: from [167.87.240.129] ([167.87.240.129])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 143HLi0b015790;
	Mon, 3 May 2021 19:21:45 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] swupdate-config: add prefix to variables
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20210430122020.13407-1-Quirin.Gylstorff@siemens.com>
 <20210430130134.22257-1-Quirin.Gylstorff@siemens.com>
 <d8c95cb7-58ae-9947-8975-3bfe227aef8e@siemens.com>
 <ec1332f7-6c1f-180c-7842-7f1ab9c15e11@siemens.com>
 <95da2602-4572-56b8-b450-9c4f05ed5888@siemens.com>
 <990afee6-bbc6-2f65-7a73-59ad8ae6b423@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <bebc037e-654a-ea94-70a2-7f8502cbb17d@siemens.com>
Date: Mon, 3 May 2021 19:21:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <990afee6-bbc6-2f65-7a73-59ad8ae6b423@siemens.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by gecko.sbs.de id 143HWfb1026488
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: bXrnJE8uJxQHMJN7wkHarZvfx4520388AA=
Content-Type: multipart/mixed; boundary="mCCosWKufjFOIrHAKnt2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620063165;
 bh=406jugzlPc98yCwzwuF15fUARoWtKDv/NzcQ1yE3Ho8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Cjwz50P4stLEamL9AzKibE6bWXCQOWeWP21orjq+J1y9/d0ZqxyyjAFBiTJEZCA64+p
 BxIwD36tOpEzWs3ftaXkYiYHG/8UXajBBZkP4G/JLCatpEnIJXdqaAvLbKQ1x5c+w8gqp
 kIJuQnse2rePDz3wabRxACC+2EfLBLI0qcA=

--mCCosWKufjFOIrHAKnt2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.05.21 17:45, Gylstorff Quirin wrote:
>=20
>=20
> On 5/3/21 1:44 PM, Jan Kiszka wrote:
>> On 03.05.21 13:28, Gylstorff Quirin wrote:
>>>
>>>
>>> On 4/30/21 4:50 PM, Jan Kiszka wrote:
>>>> On 30.04.21 15:01, Q. Gylstorff wrote:
>>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>>
>>>>> The variables U_BOOT and BOOTLOADER are only used for swupdate.
>>>>> Add the prefix SWUPDATE to indicate the intended usage.
>>>>>
>>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>> ---
>>>>> Changes in V2:
>>>>> =C2=A0=C2=A0 - fix typo in commit message
>>>>> =C2=A0=C2=A0 - use variable in kas/opt/*.yml
>>>>>
>>>>> =C2=A0=C2=A0 classes/swupdate-config.bbclass=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 10 +++++-----
>>>>> =C2=A0=C2=A0 kas/opt/ebg-secure-boot-snakeoil.yml |=C2=A0 2 +-
>>>>> =C2=A0=C2=A0 kas/opt/ebg-swu.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 4 ++--
>>>>> =C2=A0=C2=A0 kas/opt/qemu-swupdate.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>>>> =C2=A0=C2=A0 4 files changed, 9 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/classes/swupdate-config.bbclass
>>>>> b/classes/swupdate-config.bbclass
>>>>> index 9909113..0c1067a 100644
>>>>> --- a/classes/swupdate-config.bbclass
>>>>> +++ b/classes/swupdate-config.bbclass
>>>>> @@ -51,13 +51,13 @@ KFEATURE_u-boot[BUILD_DEB_DEPENDS] =3D
>>>>> "libubootenv-dev"
>>>>> =C2=A0=C2=A0 KFEATURE_u-boot[DEBIAN_DEPENDS] =3D "${@ 'libubootenv0=
.1,
>>>>> u-boot-${MACHINE}-config' \
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if
>>>>> d.getVar("USE_U_BOOT_CONFIG", True) =3D=3D "true" \
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else 'libubootenv0.1'}"
>>>>> -KFEATURE_u-boot[DEPENDS] =3D "${U_BOOT} libubootenv"
>>>>> +KFEATURE_u-boot[DEPENDS] =3D "${SWUPDATE_U_BOOT} libubootenv"
>>>>
>>>> Still leaves me and probably other users clueless what SWUPDATE_U_BO=
OT
>>>> should be. Simply "u-boot-${MACHINE}"?
>>>>
>>>> Jan
>>>>
>>>
>>> SWUPDATE_U_BOOT should be the name of the u-boot package.
>>>
>>> In case the layer (e.g. isar-cip-core) supplies the u-boot binary,
>>> `SWUPDATE_U_BOOT` should be defined as `u-boot-${MACHINE}`.
>>>
>>>
>>> Debian provides some as package, e.g. [1].
>>>
>>>
>>> I could add `u-boot-${MACHINE}` as default and a README section.
>>>
>>>
>>> [1]: https://packages.debian.org/buster/u-boot-imx
>>>
>>
>> But does SWUpdate really depends on the U-Boot binary that is going to
>> be put on the device - or rather on u-boot-config? This looks fishy.
>>
>> Jan
>>
>=20
> SWUpdate does not depends on the u-boot-binary. SWUpdate needs
> 'fw_env.config'(u-boot-config) to interact with the u-boot environment.

And for that, it needs u-boot-config as package, not u-boot-<machine>.

> As libubootenv does not request or provide 'fw_env.config' the code
> above is necessary. SWUPDATE_U_BOOT is only used for creating a build
> order.

Build order is meaningless if you are not consuming the output - which I
assume is the case via fw_env.config from u-boot-config /
u-boot-<machine>-config.

>=20
> Another way would be add u-boot-config as dependency to libubootenv in
> isar upstream. This would also mean that we maintain that package build
> instead of using the one provided by Debian bullseye and later.

Is libubootenv useless without some u-boot-config package? If so, it
would also be Debian upstream bug, and both sides needed fixing.

But I still don't get the full picture: With self-built U-Boot, we
generate u-boot-<machine>-config, providing fw_env.config. That file is
required during runtime or build time by SWUpdate?

But who is providing that file if we wanted to use an upstream Debian
U-Boot? It's not packaged with any of those. So, depending on a Debian
U-Boot package seems totally pointless. In fact, using a Debian U-Boot
seems impossible with our SWUpdate requirements, no?

Jan

--=20
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--mCCosWKufjFOIrHAKnt2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6416): https://lists.cip-project.org/g/cip-dev/message=
/6416
Mute This Topic: https://lists.cip-project.org/mt/82480672/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--mCCosWKufjFOIrHAKnt2--
