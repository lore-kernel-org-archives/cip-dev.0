Return-Path: <SRS0=ObVY=GV=lists.cip-project.org=bounce+64572+6100+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F59C433DB
	for <cip-dev@archiver.kernel.org>; Mon, 18 Jan 2021 14:34:25 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF27F20760
	for <cip-dev@archiver.kernel.org>; Mon, 18 Jan 2021 14:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF27F20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6100+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 2smdYY4521723xlaZgsELABv; Mon, 18 Jan 2021 06:34:24 -0800
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web10.34174.1610980463000348899
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Jan 2021 06:34:23 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 10IEYL8r009780
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 18 Jan 2021 15:34:21 +0100
X-Received: from [139.22.46.47] ([139.22.46.47])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 10IEYK4G019796;
	Mon, 18 Jan 2021 15:34:20 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/4] swupdate: use libubootenv
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
References: <20210118103558.18100-1-Quirin.Gylstorff@siemens.com>
 <20210118103558.18100-3-Quirin.Gylstorff@siemens.com>
 <48e4b57c-fcc8-0020-8417-20639ead2537@siemens.com>
 <89feea39-1151-192c-976a-55a4f68ab51c@siemens.com>
Message-ID: <ce3bd722-2acd-5d42-ec7d-b14e5df0c0c6@siemens.com>
Date: Mon, 18 Jan 2021 15:34:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <89feea39-1151-192c-976a-55a4f68ab51c@siemens.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by goliath.siemens.de id 10IEYL8r009780
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
X-Gm-Message-State: HJ4G3lOtKEP14m7YcCWJF3vNx4520388AA=
Content-Type: multipart/mixed; boundary="7WVFIGqyQpA1t34xCUla"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610980464;
 bh=pzzfFSQ4tBMqqf5DdzSofRrl+TAEqPk27Jog7aQy/GA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=QOUVrSEnFuoDTvsWJqitvK1KYg9vPv8Aw0I1yBb8rLpmWYDlusHv9JVL+Z9IJ1roBVK
 0+2OCBMpO7pUhNHcMRIhOHKKEAtpZ+AXCYrQyXC2Q4JhxTM4ML8MokKSgakZjKp8mh66n
 FPdZCmsA9b+ic3GfGW8bK+Wt0wXZCl5k9oU=

--7WVFIGqyQpA1t34xCUla
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 1/18/21 3:10 PM, [ext] Quirin Gylstorff wrote:
>=20
>=20
> On 1/18/21 12:23 PM, Jan Kiszka wrote:
>> On 18.01.21 11:35, Q. Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> libubootenv provides hardware independent access to u-boot environmen=
ts.
>>> This change conflicts with u-boot tools < 10.2019.
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 classes/swupdate-config.bbclass | 4 ++--
>>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/classes/swupdate-config.bbclass=20
>>> b/classes/swupdate-config.bbclass
>>> index 208d240..dd0317f 100644
>>> --- a/classes/swupdate-config.bbclass
>>> +++ b/classes/swupdate-config.bbclass
>>> @@ -46,8 +46,8 @@ KFEATURE_ubi[KCONFIG_SNIPPETS] =3D=20
>>> "file://swupdate_defconfig_ubi.snippet"
>>> =C2=A0 KFEATURE_DEPS[ubi] =3D "mtd"
>>> =C2=A0 KFEATURE_u-boot =3D ""
>>> -KFEATURE_u-boot[BUILD_DEB_DEPENDS] =3D "u-boot-${MACHINE}-dev"
>>> -KFEATURE_u-boot[DEBIAN_DEPENDS] =3D "u-boot-tools"
>>> +KFEATURE_u-boot[BUILD_DEB_DEPENDS] =3D "libubootenv-dev"
>>> +KFEATURE_u-boot[DEBIAN_DEPENDS] =3D "libubootenv-tool, u-boot-tools"
>>> =C2=A0 KFEATURE_u-boot[DEPENDS] =3D "${U_BOOT}"
>>> =C2=A0 KFEATURE_u-boot[KCONFIG_SNIPPETS] =3D=20
>>> "file://swupdate_defconfig_u-boot.snippet"
>>>
>>
>> The isar version we have at this point already supports that?
>=20
> Yes, since one next e77d030ed0ac5b122aa7b798131062946cb36699.
Isar supports libubootenv since e77d030ed0ac5b122aa7b798131062946cb36699
cip-core since 683866e2b0c5113b849ef82cf206b3bb5c6e3e30

Quirin

--7WVFIGqyQpA1t34xCUla
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6100): https://lists.cip-project.org/g/cip-dev/message=
/6100
Mute This Topic: https://lists.cip-project.org/mt/79920019/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--7WVFIGqyQpA1t34xCUla--
