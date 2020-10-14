Return-Path: <SRS0=ANuv=DV=lists.cip-project.org=bounce+64572+5573+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3B0C433DF
	for <cip-dev@archiver.kernel.org>; Wed, 14 Oct 2020 04:21:54 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B6002222A
	for <cip-dev@archiver.kernel.org>; Wed, 14 Oct 2020 04:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="kXGTfjOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6002222A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5573+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id kxKxYY4521723xtwh9SyzkaH; Tue, 13 Oct 2020 21:21:52 -0700
X-Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
 by mx.groups.io with SMTP id smtpd.web10.4127.1602649311941925113
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Oct 2020 21:21:52 -0700
X-Received: by mail-lj1-f174.google.com with SMTP id p15so1692105ljj.8
        for <cip-dev@lists.cip-project.org>; Tue, 13 Oct 2020 21:21:51 -0700 (PDT)
X-Gm-Message-State: sYUUsu0LncXwl61oFG0GIbUnx4520388AA=
X-Google-Smtp-Source: ABdhPJxKY3AdGeYKWA0KJGNtcw2m0tZyDpXVvnkvxwbraq3yYdz5LHxxk9B/vXNi+Z4pG8yDIcZ6ZQ==
X-Received: by 2002:a2e:b531:: with SMTP id z17mr1095678ljm.28.1602649309920;
        Tue, 13 Oct 2020 21:21:49 -0700 (PDT)
X-Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id l9sm653414lfh.285.2020.10.13.21.21.49
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 21:21:49 -0700 (PDT)
X-Received: by mail-lf1-f46.google.com with SMTP id j30so2182699lfp.4
        for <cip-dev@lists.cip-project.org>; Tue, 13 Oct 2020 21:21:49 -0700 (PDT)
X-Received: by 2002:a05:6512:31d5:: with SMTP id j21mr678002lfe.348.1602649309236;
 Tue, 13 Oct 2020 21:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200925035927.1958987-1-daniel.sangorrin@toshiba.co.jp>
 <20200925035927.1958987-4-daniel.sangorrin@toshiba.co.jp> <CAGb2v66v0N=eC_1-2kFbdYp=mLFTd69mRJ_BeBhw3HXyOya2Rg@mail.gmail.com>
 <OSBPR01MB2053976D2C2708EC5A906FDCD0050@OSBPR01MB2053.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB2053976D2C2708EC5A906FDCD0050@OSBPR01MB2053.jpnprd01.prod.outlook.com>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Wed, 14 Oct 2020 12:21:37 +0800
X-Gmail-Original-Message-ID: <CAGb2v66veK5kpCZD-h2b8qBJox_qpDXn7_WZeZisv25d5Wu0Kg@mail.gmail.com>
Message-ID: <CAGb2v66veK5kpCZD-h2b8qBJox_qpDXn7_WZeZisv25d5Wu0Kg@mail.gmail.com>
Subject: Re: [cip-dev] [cip-kernel-sec 3/3] issues: fill in the description field of remaining CVEs
To: cip-dev@lists.cip-project.org
Cc: =?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?= <sz.lin@moxa.com>, 
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="6CtaHfLMVMu8zqYueKfX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602649312;
 bh=wdfrFF8KMkE6oryKyFcj7n9oGbun1zj1xE2DmtjkP+M=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=kXGTfjOyvBvpELowEIRNKHrvvqqLV/0Rs34m889eVXO77KmPbwNjok0hmYRseNzYlsh
 SOeK/jMGCRg+LtKhnXPRwk7ly0KXpsz1gB6uZHPPwYPOHsVZ7c+94J+Zb6AZ5fn9pA1Ob
 2sCsPZI+shZ35gw0qk9D60OI7hKaw3GBL90=

--6CtaHfLMVMu8zqYueKfX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2020 at 12:16 PM Daniel Sangorrin
<daniel.sangorrin@toshiba.co.jp> wrote:
>
> Hello Chen-yu,
>
> Thanks for your check.
>
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On =
Behalf Of Chen-Yu Tsai (Moxa)
> > Sent: Thursday, October 8, 2020 5:19 PM
> > To: cip-dev@lists.cip-project.org
> > Cc: SZ Lin (=E6=9E=97=E4=B8=8A=E6=99=BA) <sz.lin@moxa.com>; Ben Hutchin=
gs <ben.hutchings@codethink.co.uk>
> > Subject: Re: [cip-dev] [cip-kernel-sec 3/3] issues: fill in the descrip=
tion field of remaining CVEs
> >
> > On Fri, Sep 25, 2020 at 12:01 PM Daniel Sangorrin <daniel.sangorrin@tos=
hiba.co.jp> wrote:
> > >
> > > From: nguyen van hieu <hieu2.nguyenvan@toshiba.co.jp>
> > >
> > > I noticed that some issues have the description field empty when usin=
g
> > > the --show-description option.
> > >
> > > Signed-off-by: nguyen van hieu <hieu2.nguyenvan@toshiba.co.jp>
> > > Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> >
> > Looks like all the new descriptions were copied from MITRE.
> >
> > Reviewed-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
>
> Is there a problem with that?
> The MITRE license is included in the COPYING file as far as I know.

Not at all. I'm merely stating that the descriptions match a known source.

ChenYu

--6CtaHfLMVMu8zqYueKfX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5573): https://lists.cip-project.org/g/cip-dev/message=
/5573
Mute This Topic: https://lists.cip-project.org/mt/77073076/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6CtaHfLMVMu8zqYueKfX--
