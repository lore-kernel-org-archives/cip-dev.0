Return-Path: <SRS0=+PUV=7R=lists.cip-project.org=bounce+64572+4701+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF771C433E0
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 09:22:09 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 732B920738
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 09:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="VULkpI9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732B920738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4701+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id tyhcYY4521723x3dgxHzpTYP; Thu, 04 Jun 2020 02:22:09 -0700
X-Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
 by mx.groups.io with SMTP id smtpd.web10.10352.1591262527500742407
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Jun 2020 02:22:07 -0700
X-Received: by mail-lj1-f194.google.com with SMTP id s1so6394188ljo.0
        for <cip-dev@lists.cip-project.org>; Thu, 04 Jun 2020 02:22:07 -0700 (PDT)
X-Gm-Message-State: fRTIjUcgOVgUrj9MF6WU4BsOx4520388AA=
X-Google-Smtp-Source: ABdhPJz1sbPcgIAF1SJ9e3ThJGWl+WqsM3GkzJN0ySugZ3iMW50mDrKnVoAo05Fe307/0/OnuycXEw==
X-Received: by 2002:a2e:96cd:: with SMTP id d13mr1592088ljj.251.1591262525259;
        Thu, 04 Jun 2020 02:22:05 -0700 (PDT)
X-Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id q4sm1331019lfm.93.2020.06.04.02.22.04
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 02:22:04 -0700 (PDT)
X-Received: by mail-lf1-f41.google.com with SMTP id e125so3155569lfd.1
        for <cip-dev@lists.cip-project.org>; Thu, 04 Jun 2020 02:22:04 -0700 (PDT)
X-Received: by 2002:ac2:5628:: with SMTP id b8mr2016389lff.186.1591262524658;
 Thu, 04 Jun 2020 02:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200604041745.28886-1-wens@csie.org> <20200604041745.28886-9-wens@csie.org>
 <20200604085625.GA18919@duo.ucw.cz> <20200604090331.GB18919@duo.ucw.cz>
In-Reply-To: <20200604090331.GB18919@duo.ucw.cz>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 4 Jun 2020 17:21:54 +0800
X-Gmail-Original-Message-ID: <CAGb2v66QZGYNbW=bbNUpnO7POr6fNhd=CKXNezKQ3VUDNUY0rg@mail.gmail.com>
Message-ID: <CAGb2v66QZGYNbW=bbNUpnO7POr6fNhd=CKXNezKQ3VUDNUY0rg@mail.gmail.com>
Subject: Re: [cip-dev] [PATCH RESEND 4.4.y-cip 08/15] PM / OPP: Parse 'opp-<prop>-<name>' bindings
To: Pavel Machek <pavel@denx.de>
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, cip-dev@lists.cip-project.org, 
	=?UTF-8?B?Sm9obnNvbiBDSCBDaGVuICjpmbPmmK3li7Mp?= <JohnsonCH.Chen@moxa.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="F0gxiukmiE8kyX8vZ2HX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591262529;
 bh=k919tExCiO1nMYH98tjX+iPtIr3GSQPO2Nnxn8dIwkA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=VULkpI9axafOJQ9P3uvRPtW+HQHb+DhHEpe1yBdhpSe1THySItfRsX0KQO+3uch2/J4
 bkmMmU0301ZcMxANEExYPVMLC5e7e2AzMjjjoDh0xvVSVzNok/G5PRzCAF4R2x1lIFGax
 RflZr4a/0kAc95t3OIVoHre94D1IPKtIz78=

--F0gxiukmiE8kyX8vZ2HX
Content-Type: text/plain; charset="UTF-8"

On Thu, Jun 4, 2020 at 5:03 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > >  /* TODO: Support multiple regulators */
> > > -static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev)
> > > +static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
> > > +                         struct device_opp *dev_opp)
> > >  {
> > >     u32 microvolt[3] = {0};
> > >     u32 val;
> > >     int count, ret;
> > > +   struct property *prop = NULL;
> > > +   char name[NAME_MAX];
> > > +
> > > +   /* Search for "opp-microvolt-<name>" */
> > > +   if (dev_opp->prop_name) {
> > > +           sprintf(name, "opp-microvolt-%s", dev_opp->prop_name);
> > > +           prop = of_find_property(opp->np, name, NULL);
> > > +   }
> > > +
> > > +   if (!prop) {
> > > +           /* Search for "opp-microvolt" */
> > > +           name[13] = '\0';
> > > +           prop = of_find_property(opp->np, name, NULL);
> >
> > If in !dev_opp->prop_name, it will pass uninitialized buffer to
> > of_find_property.
>
> This is fixed in the next patch. But I wonder if we should merge them
> into one for -cip... Unlike mainline, we already know about the
> bug. No need to prepare trap for people doing bisect.

That is a good argument. I suppose we just need to make sure the end
result records both upstream commits, and that all of our automated
tools can handle that.

ChenYu

--F0gxiukmiE8kyX8vZ2HX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4701): https://lists.cip-project.org/g/cip-dev/message=
/4701
Mute This Topic: https://lists.cip-project.org/mt/74665642/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--F0gxiukmiE8kyX8vZ2HX--
