Return-Path: <SRS0=5RxE=CG=lists.cip-project.org=bounce+64572+5289+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD64CC433E2
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 07:51:21 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 347EC2078A
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 07:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="obi4RH0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347EC2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5289+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qTHxYY4521723xyoKKNTsUTU; Fri, 28 Aug 2020 00:51:20 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web10.38453.1598601079006191594
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 00:51:20 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 07S7pEPv019051
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2020 09:51:15 +0200
X-Received: from [167.87.19.148] ([167.87.19.148])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07S7pCLj009037;
	Fri, 28 Aug 2020 09:51:12 +0200
Subject: Re: [cip-dev] Everything failed in gitlab
To: nobuhiro1.iwamatsu@toshiba.co.jp, iwamatsu@nigauri.org,
        cip-dev@lists.cip-project.org
Cc: Chris.Paterson2@renesas.com, quirin.gylstorff@siemens.com
References: <12b9b0c0-7117-81fc-8360-a0bd858715a8@siemens.com>
 <20200827082132.ca3vmztk43723bas@kratos.fritz.box>
 <20200827131025.GA28744@duo.ucw.cz>
 <CABMQnVLyjmJSEBce_oJSgSTGU5muMEyy3iwhikjuAS=DT3o3Hw@mail.gmail.com>
 <5e5a71ba-fbb0-99b0-126a-b11d51608309@siemens.com>
 <OSBPR01MB29838DB1D31267F8BBC0A91392520@OSBPR01MB2983.jpnprd01.prod.outlook.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <d985a86c-97fb-f1c2-9b91-2bfba8185cd5@siemens.com>
Date: Fri, 28 Aug 2020 09:51:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB29838DB1D31267F8BBC0A91392520@OSBPR01MB2983.jpnprd01.prod.outlook.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by goliath.siemens.de id 07S7pEPv019051
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 31h2teCEdbmrwel5ycQjo6TFx4520388AA=
Content-Type: multipart/mixed; boundary="Ww5LlKtOVS8foHsZ2igb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598601080;
 bh=0sAckZKeamH3+WMY2FxKgymMstbA75dA1RZBE9DZljE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=obi4RH0LjqjF3QxGsGtwHywTDrsWnZS9jbfj9QgbkWUjHDZsM8fs3AyI0iMlmJps8pj
 lQOX6fgOVNNoJxBWSSwVKT97Ms5+SrDLQxSZehZjm/YNfASHSsQxgIgwTa67P/7ebkzUr
 YMix3nOElWU7SlU1q5HWfT3KD2MXrM9LZZc=

--Ww5LlKtOVS8foHsZ2igb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.08.20 09:11, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi Jan,
>=20
>> -----Original Message-----
>> From: Jan Kiszka [mailto:jan.kiszka@siemens.com]
>> Sent: Friday, August 28, 2020 1:44 PM
>> To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>; cip-dev@lists.cip-projec=
t.org
>> Cc: iwamatsu nobuhiro(=E5=B2=A9=E6=9D=BE =E4=BF=A1=E6=B4=8B =E2=96=A1=EF=
=BC=B3=EF=BC=B7=EF=BC=A3=E2=97=AF=EF=BC=A1=EF=BC=A3=EF=BC=B4) <nobuhiro1.=
iwamatsu@toshiba.co.jp>; Chris Paterson
>> <Chris.Paterson2@renesas.com>; Quirin Gylstorff <quirin.gylstorff@siem=
ens.com>
>> Subject: Re: [cip-dev] Everything failed in gitlab
>>
>> On 27.08.20 23:40, Nobuhiro Iwamatsu wrote:
>>> Hi all,
>>>
>>> This is happening not only in cip-testing (kernel test) but also in
>>> cip-core[0][1].
>>> I don't manage these runners. Has anyone changed permissions etc?
>>
>> I do. Just restarted a build
>> (https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/70799173=
8), and
>> it is apparently working.
>>
>> Is there in issue with who is triggering the build and what permission
>> that person has? Just restarted [0], and that also works:
>>
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/707992917
>=20
> Gitlab runner is now working on all repositories.
> Thanks!
>=20

...but I didn't change anything for that. I guess is was a temporal hick-=
up.

Jan

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--Ww5LlKtOVS8foHsZ2igb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5289): https://lists.cip-project.org/g/cip-dev/message=
/5289
Mute This Topic: https://lists.cip-project.org/mt/76423839/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Ww5LlKtOVS8foHsZ2igb--
