Return-Path: <SRS0=a6FC=GY=lists.cip-project.org=bounce+64572+6124+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC09C433DB
	for <cip-dev@archiver.kernel.org>; Thu, 21 Jan 2021 04:17:02 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A3F221FD
	for <cip-dev@archiver.kernel.org>; Thu, 21 Jan 2021 04:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A3F221FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6124+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id OXTNYY4521723xewfhxom2yl; Wed, 20 Jan 2021 20:17:01 -0800
X-Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.web12.2606.1611202620606708441
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Jan 2021 20:17:01 -0800
X-Received: by mail-lf1-f43.google.com with SMTP id o13so684992lfr.3
        for <cip-dev@lists.cip-project.org>; Wed, 20 Jan 2021 20:17:00 -0800 (PST)
X-Gm-Message-State: jTZitcB17Impp6PGLk4VaDgxx4520388AA=
X-Google-Smtp-Source: ABdhPJw27VlmymidQuakUPBmkhC+5qmsLPFsiBr2H0COsGOATE5deJEiHLs1v87f6VrHPJFqqtbNTg==
X-Received: by 2002:ac2:51c9:: with SMTP id u9mr4389731lfm.276.1611202618318;
        Wed, 20 Jan 2021 20:16:58 -0800 (PST)
X-Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id z6sm432441ljz.71.2021.01.20.20.16.57
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 20:16:57 -0800 (PST)
X-Received: by mail-lj1-f174.google.com with SMTP id i17so995489ljn.1
        for <cip-dev@lists.cip-project.org>; Wed, 20 Jan 2021 20:16:57 -0800 (PST)
X-Received: by 2002:a2e:80da:: with SMTP id r26mr2154198ljg.78.1611202617777;
 Wed, 20 Jan 2021 20:16:57 -0800 (PST)
MIME-Version: 1.0
References: <CAGb2v66bGEX3sCBNnYdv07cuojOjNe1Gf-D3Mb4Kik-He3nt0w@mail.gmail.com>
 <OSBPR01MB20533FBEE9901A816B78204FD0A10@OSBPR01MB2053.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB20533FBEE9901A816B78204FD0A10@OSBPR01MB2053.jpnprd01.prod.outlook.com>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 21 Jan 2021 12:16:45 +0800
X-Gmail-Original-Message-ID: <CAGb2v65O8RxbFjgME90NKfVTw6w54rwP0BhCGzDqKOeiRrxtQg@mail.gmail.com>
Message-ID: <CAGb2v65O8RxbFjgME90NKfVTw6w54rwP0BhCGzDqKOeiRrxtQg@mail.gmail.com>
Subject: Re: [cip-dev] Cip-kernel-sec Updates for Week of 2021-01-21
To: cip-dev@lists.cip-project.org
Cc: Jonathan Sambrook <jonathan.sambrook@codethink.co.uk>, 
	=?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?= <sz.lin@moxa.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="P2UiOP9qEVygN1lDMXJB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611202621;
 bh=CkOSosudPx8L7MmRtO3dXKMGWJZlU41wdo7U9ugnBW0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=TnyRRGxAVBHVOXFguUwNtF9+8B90+sZ+C6Es9uz+8HCvDsnUfwO8xdflsBplrBjmdLp
 RphnthSoT98Yajrm7gWp2UuBFmNuAQAZK0HjkvfDlPmaBB54KKqcKj2HBbw+SLOLlodV8
 hXtbxh2PuPbsDX427rQ1IlUXi+qZ91+ySXo=

--P2UiOP9qEVygN1lDMXJB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2021 at 12:15 PM Daniel Sangorrin
<daniel.sangorrin@toshiba.co.jp> wrote:
>
> Hello ChenYu san
>
> It seems that there is a problem with merge requests to cip-kernel-sec
> https://lore.kernel.org/cip-dev/0282a51a-682c-bb5e-4a68-e020ac0e76d5@cod=
ethink.co.uk/T/#u
>
> Did you look into that?

I tried again yesterday and the issue still persists.
SZ said he would look into it today.


ChenYu

> Thanks,
> Daniel
>
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On=
 Behalf Of Chen-Yu Tsai (Moxa)
> > Sent: Thursday, January 21, 2021 12:51 PM
> > To: cip-dev@lists.cip-project.org
> > Cc: Pavel Machek <pavel@denx.de>; iwamatsu nobuhiro(=E5=B2=A9=E6=9D=BE=
 =E4=BF=A1=E6=B4=8B =E2=96=A1=EF=BC=B3=EF=BC=B7=EF=BC=A3=E2=97=AF=EF=BC=A1=
=EF=BC=A3=EF=BC=B4) <nobuhiro1.iwamatsu@toshiba.co.jp>;
> > masashi.kudo@cybertrust.co.jp
> > Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2021-01-21
> >
> > Hi everyone,
> >
> > One new issue this week:
> > - CVE-2021-3178 [nfsd4: readdirplus returns parent of export] - fixed =
in mainline
> >
> > The fix was only merged into Linus's tree a couple days ago, so we sho=
uld see the backports in a few days.
> >
> > I've also added the 5.10-cip branch to the tracker.
> >
> >
> > Regards
> > ChenYu
>
>=20
>

--P2UiOP9qEVygN1lDMXJB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6124): https://lists.cip-project.org/g/cip-dev/message=
/6124
Mute This Topic: https://lists.cip-project.org/mt/79996445/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--P2UiOP9qEVygN1lDMXJB--
