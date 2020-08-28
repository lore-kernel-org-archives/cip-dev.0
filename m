Return-Path: <SRS0=fh0z=CG=lists.cip-project.org=bounce+64572+5287+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6DDC433E2
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 04:44:10 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B89520CC7
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 04:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="QlDCcOaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B89520CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5287+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id lYYGYY4521723xPyR86XzYU4; Thu, 27 Aug 2020 21:44:09 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web11.36387.1598589847921326514
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Aug 2020 21:44:09 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 07S4i448017012
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2020 06:44:04 +0200
X-Received: from [167.87.79.124] ([167.87.79.124])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07S4i1MI015065;
	Fri, 28 Aug 2020 06:44:02 +0200
Subject: Re: [cip-dev] Everything failed in gitlab
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, cip-dev@lists.cip-project.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <12b9b0c0-7117-81fc-8360-a0bd858715a8@siemens.com>
 <20200827082132.ca3vmztk43723bas@kratos.fritz.box>
 <20200827131025.GA28744@duo.ucw.cz>
 <CABMQnVLyjmJSEBce_oJSgSTGU5muMEyy3iwhikjuAS=DT3o3Hw@mail.gmail.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <5e5a71ba-fbb0-99b0-126a-b11d51608309@siemens.com>
Date: Fri, 28 Aug 2020 06:44:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CABMQnVLyjmJSEBce_oJSgSTGU5muMEyy3iwhikjuAS=DT3o3Hw@mail.gmail.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by gecko.sbs.de id 07S4i448017012
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: JYzKpUiLmpsZKt3RN7ZrXCDmx4520388AA=
Content-Type: multipart/mixed; boundary="VRFp4QsykkOMmAKRhRUx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598589849;
 bh=/onL3Fjt5ATh42KGYTiEev3tlEMB9ibZWOnnqurVfio=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=QlDCcOaJmDH5LynlPk8Rvek/zWCwXS8lsmA2AO18qI/9XU3L4LZgfXHmVhRad52Xtbk
 h8zsbRSiqNt4fr3YrujhduM+hBjLnJryIt6RPl05NPKKnQPx6RFYGK5gqErZHlFwatRm2
 WtXSZ9Ky8vveAuZotBgMesCwRDMYdvCgtJg=

--VRFp4QsykkOMmAKRhRUx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.08.20 23:40, Nobuhiro Iwamatsu wrote:
> Hi all,
>=20
> This is happening not only in cip-testing (kernel test) but also in
> cip-core[0][1].
> I don't manage these runners. Has anyone changed permissions etc?

I do. Just restarted a build
(https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/707991738), =
and
it is apparently working.

Is there in issue with who is triggering the build and what permission
that person has? Just restarted [0], and that also works:

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/707992917

Jan

> Best regards,
>   Nobuhiro
>=20
> [0]:https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7057839=
16
> [1]:https://gitlab.com/cip-project/cip-core/deby/-/jobs/699772711
>=20
> 2020=E5=B9=B48=E6=9C=8827=E6=97=A5(=E6=9C=A8) 22:10 Pavel Machek <pavel@=
ucw.cz>:
>>
>> Hi!
>>
>>>> Michael, Quirin, any ideas?
>>>
>>> yes. I took a brief look at the logs and found the problem:
>>>
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>>> Aug 27 08:16:05 ip-172-20-42-140 kubelet[2152]: E0827 08:16:05.109337 =
   2152 kuberuntime_manager.go:784] container start failed: ErrImagePull: r=
pc error: code =3D Unknown desc =3D Error response from daemon: Get https:/=
/registry.gitlab.com/v2/cip-project/cip-testing/linux-cip-ci/manifests/buil=
d-v3: unauthorized: HTTP Basic: Access denied
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> =3D> HTTP Basic: Access denied
>>>
>>> Please check your setup/permissions?
>>
>> I believe that Chris is unavailable this week. Is there anyone else
>> that knows how this is supposed to work?
>>
>> Best regards,
>>                                                                 Pavel
>>
>> --
>> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
>> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>>=20
>=20
>=20
>=20

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--VRFp4QsykkOMmAKRhRUx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5287): https://lists.cip-project.org/g/cip-dev/message=
/5287
Mute This Topic: https://lists.cip-project.org/mt/76423839/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--VRFp4QsykkOMmAKRhRUx--
