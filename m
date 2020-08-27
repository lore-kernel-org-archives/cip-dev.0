Return-Path: <SRS0=CesS=CF=lists.cip-project.org=bounce+64572+5286+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC62C433E2
	for <cip-dev@archiver.kernel.org>; Thu, 27 Aug 2020 21:41:06 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE7F20848
	for <cip-dev@archiver.kernel.org>; Thu, 27 Aug 2020 21:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="PBIJPc0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE7F20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5286+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id BTw7YY4521723x0Pr65HUN30; Thu, 27 Aug 2020 14:41:05 -0700
X-Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
 by mx.groups.io with SMTP id smtpd.web12.29873.1598564464244885407
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Aug 2020 14:41:04 -0700
X-Received: by mail-oi1-f195.google.com with SMTP id e6so5961684oii.4
        for <cip-dev@lists.cip-project.org>; Thu, 27 Aug 2020 14:41:04 -0700 (PDT)
X-Gm-Message-State: D3YYg8DJA1Gm3XncGSlmveA0x4520388AA=
X-Google-Smtp-Source: ABdhPJzMydltPjgnRHuIWKohnO6EOtFhiYjKS3o85XyGpcYN7TNkWmVxGggujNvuOD5k0x/2n+xBO0ZzPgDtC3D6z3Q=
X-Received: by 2002:a05:6808:204:: with SMTP id l4mr616139oie.62.1598564463343;
 Thu, 27 Aug 2020 14:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <12b9b0c0-7117-81fc-8360-a0bd858715a8@siemens.com>
 <20200827082132.ca3vmztk43723bas@kratos.fritz.box> <20200827131025.GA28744@duo.ucw.cz>
In-Reply-To: <20200827131025.GA28744@duo.ucw.cz>
From: "Nobuhiro Iwamatsu" <iwamatsu@nigauri.org>
Date: Fri, 28 Aug 2020 06:40:37 +0900
Message-ID: <CABMQnVLyjmJSEBce_oJSgSTGU5muMEyy3iwhikjuAS=DT3o3Hw@mail.gmail.com>
Subject: Re: [cip-dev] Everything failed in gitlab
To: cip-dev@lists.cip-project.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	Chris Paterson <Chris.Paterson2@renesas.com>, 
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="yhc850qphRqvF99OFDkr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598564465;
 bh=XtswV3qnwS97OtvO+PI8fSW5X3FyWtf6MDyVb5solj8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=PBIJPc0ZH+V2GX+GxWEv186tuzpI5rltQ3i5ULcEeT+m9wthIzsDC5hd17N0EMcmF9j
 T4nZKs0C2mfUGzs8evSGvFG7tcTpJQbTzUnt4jXJGrchmSm/fU+yyRVR7wd+0BJG4noMn
 X8hnECPXLFoLKRcKAPuYRb6+hCEmAXL8DiU=

--yhc850qphRqvF99OFDkr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

This is happening not only in cip-testing (kernel test) but also in
cip-core[0][1].
I don't manage these runners. Has anyone changed permissions etc?

Best regards,
  Nobuhiro

[0]:https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/705783916
[1]:https://gitlab.com/cip-project/cip-core/deby/-/jobs/699772711

2020=E5=B9=B48=E6=9C=8827=E6=97=A5(=E6=9C=A8) 22:10 Pavel Machek <pavel@uc=
w.cz>:
>
> Hi!
>
> > > Michael, Quirin, any ideas?
> >
> > yes. I took a brief look at the logs and found the problem:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > Aug 27 08:16:05 ip-172-20-42-140 kubelet[2152]: E0827 08:16:05.109337 =
   2152 kuberuntime_manager.go:784] container start failed: ErrImagePull: r=
pc error: code =3D Unknown desc =3D Error response from daemon: Get https:/=
/registry.gitlab.com/v2/cip-project/cip-testing/linux-cip-ci/manifests/buil=
d-v3: unauthorized: HTTP Basic: Access denied
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > =3D> HTTP Basic: Access denied
> >
> > Please check your setup/permissions?
>
> I believe that Chris is unavailable this week. Is there anyone else
> that knows how this is supposed to work?
>
> Best regards,
>                                                                 Pavel
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>=20



--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6

--yhc850qphRqvF99OFDkr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5286): https://lists.cip-project.org/g/cip-dev/message=
/5286
Mute This Topic: https://lists.cip-project.org/mt/76423839/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--yhc850qphRqvF99OFDkr--
