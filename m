Return-Path: <SRS0=vYrL=NA=lists.cip-project.org=bounce+64572+6666+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA10C432BE
	for <cip-dev@archiver.kernel.org>; Mon,  9 Aug 2021 15:25:36 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC13860E52
	for <cip-dev@archiver.kernel.org>; Mon,  9 Aug 2021 15:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DC13860E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HPeWYY4521723xri6ImHmwb8; Mon, 09 Aug 2021 08:25:35 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web08.24272.1628522734217219919
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Aug 2021 08:25:34 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 179FPVZI031201
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 9 Aug 2021 17:25:31 +0200
X-Received: from [139.22.37.37] ([139.22.37.37])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 179FPUXD010286;
	Mon, 9 Aug 2021 17:25:31 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate-config: Remove runtime dependency efibootguard-dev
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20210809102945.17824-1-Quirin.Gylstorff@siemens.com>
 <6a7d4672-f517-f33a-a54d-e48776d1c6c4@siemens.com>
 <5582fe4d-810f-9206-0abc-f88a756edc80@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <5b7466e9-b110-fd2f-71a0-7d762596e58d@siemens.com>
Date: Mon, 9 Aug 2021 17:25:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <5582fe4d-810f-9206-0abc-f88a756edc80@siemens.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by lizzard.sbs.de id 179FPVZI031201
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 8QEFCFWBAKSHw6buAf1D9lKhx4520388AA=
Content-Type: multipart/mixed; boundary="unYFWaQ6IGaLYGlfGfkU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1628522735;
 bh=fjZbUilHuAVcWsbZ4gpM37JFYvbR89xpwrU2moJYKBg=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=lVcAN2LjUOPgu5TAUz2GE9f0UFHEgPEkr6TF4sKCC58QNxUN1sdOpUx3mlLK5gQ78sa
 PuEJv8wAJezJFrrFOrRkNg05j33LOxqlXE6KabYIwOoBCcLmDTdMwbjIT/Tqn20nFKezl
 GYiWGt/Whcu15F89C83APjcKbZEotfjJFF0=

--unYFWaQ6IGaLYGlfGfkU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.08.21 15:49, Gylstorff Quirin wrote:
>=20
>=20
> On 8/9/21 2:54 PM, Jan Kiszka wrote:
>> On 09.08.21 12:29, Q. Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> efibootguard-dev is only a build time dependency and
>>> not an runtime dependency.
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 classes/swupdate-config.bbclass | 2 +-
>>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/classes/swupdate-config.bbclass
>>> b/classes/swupdate-config.bbclass
>>> index dfa3579..e4879c7 100644
>>> --- a/classes/swupdate-config.bbclass
>>> +++ b/classes/swupdate-config.bbclass
>>> @@ -38,7 +38,7 @@ KFEATURE_DEPS[luahandler] =3D "lua"
>>> =C2=A0 =C2=A0 KFEATURE_efibootguard =3D ""
>>> =C2=A0 KFEATURE_efibootguard[BUILD_DEB_DEPENDS] =3D "efibootguard-dev=
"
>>> -KFEATURE_efibootguard[DEBIAN_DEPENDS] =3D "efibootguard-dev"
>>> +KFEATURE_efibootguard[DEBIAN_DEPENDS] =3D ""
>>> =C2=A0 KFEATURE_efibootguard[DEPENDS] =3D "efibootguard-dev"
>>> =C2=A0 KFEATURE_efibootguard[KCONFIG_SNIPPETS] =3D
>>> "file://swupdate_defconfig_efibootguard.snippet"
>>> =C2=A0
>>
>> -dev makes no sense, but don't we have any dep on libs? Or are they
>> statically linked?
>=20
> It is statically linked - efibootguard-dev contains only libebgenv.a.
>=20

Ah, yeah, part the SWUpdate's problems...

Thanks, applied.

Jan

--=20
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--unYFWaQ6IGaLYGlfGfkU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6666): https://lists.cip-project.org/g/cip-dev/message/=
6666
Mute This Topic: https://lists.cip-project.org/mt/84765287/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--unYFWaQ6IGaLYGlfGfkU--
