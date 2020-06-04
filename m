Return-Path: <SRS0=u3YH=7R=lists.cip-project.org=bounce+64572+4699+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646E1C433DF
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 09:03:17 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B39206C3
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 09:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="GOIOf5Th"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B39206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4699+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id iHntYY4521723xZhlQ5wBq7B; Thu, 04 Jun 2020 02:03:16 -0700
X-Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
 by mx.groups.io with SMTP id smtpd.web12.9772.1591261395372788627
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Jun 2020 02:03:15 -0700
X-Received: by mail-lj1-f194.google.com with SMTP id a9so2743787ljn.6
        for <cip-dev@lists.cip-project.org>; Thu, 04 Jun 2020 02:03:15 -0700 (PDT)
X-Gm-Message-State: oGSUgE4j65G3QQnbmrfGe6ofx4520388AA=
X-Google-Smtp-Source: ABdhPJzrgk2+QOaQ/urT3IUJXiZvh4RbtR445ceL9+M6AWmM1Kd6PKjF0Ru9Ta+hWlbkGTsDZ96GIQ==
X-Received: by 2002:a05:651c:c1:: with SMTP id 1mr1568271ljr.292.1591261393047;
        Thu, 04 Jun 2020 02:03:13 -0700 (PDT)
X-Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id g5sm1068707ljk.93.2020.06.04.02.03.12
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 02:03:12 -0700 (PDT)
X-Received: by mail-lf1-f48.google.com with SMTP id j12so3115846lfh.0
        for <cip-dev@lists.cip-project.org>; Thu, 04 Jun 2020 02:03:12 -0700 (PDT)
X-Received: by 2002:ac2:5cd1:: with SMTP id f17mr1864920lfq.4.1591261392269;
 Thu, 04 Jun 2020 02:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200604041745.28886-1-wens@csie.org> <20200604041745.28886-4-wens@csie.org>
 <20200604084601.GA18541@duo.ucw.cz>
In-Reply-To: <20200604084601.GA18541@duo.ucw.cz>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 4 Jun 2020 17:03:01 +0800
X-Gmail-Original-Message-ID: <CAGb2v67JzgA3KkpkEirTLNs2yTaZho3rBvHSJepBUCTL0KaCxw@mail.gmail.com>
Message-ID: <CAGb2v67JzgA3KkpkEirTLNs2yTaZho3rBvHSJepBUCTL0KaCxw@mail.gmail.com>
Subject: Re: [cip-dev] [PATCH RESEND 4.4.y-cip 03/15] PM / OPP: Add {opp-microvolt|opp-microamp}-<name> binding
To: Pavel Machek <pavel@denx.de>
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, cip-dev@lists.cip-project.org, 
	=?UTF-8?B?Sm9obnNvbiBDSCBDaGVuICjpmbPmmK3li7Mp?= <JohnsonCH.Chen@moxa.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="RM0Zyk6LCdO4pXxZQ2Oi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591261396;
 bh=vDgl4BnyjvB8j2H24MQY1hJlPjc9IotzVYqgklQcUyA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=GOIOf5Th/83knqctJCBiV1Z4qzYq+rybNnnMwydPN4HIaKHVGJKfxpwdPO/WjVIbpSW
 +WPZK1+kmaXZI75K7/yDGMThlZ+F/ZP6yXCSO/icKgTUDYqM7SjVhkT2FG9kvqDWAtzde
 PNwgRopjp+zxVPcjBrZa7ruYLPsC9Jm1DvE=

--RM0Zyk6LCdO4pXxZQ2Oi
Content-Type: text/plain; charset="UTF-8"

On Thu, Jun 4, 2020 at 4:46 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > From: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > commit ffdb8cc7a27c89175e541e68e2a73f1f63ab8c6b upstream.
> >
> > Depending on the version of hardware or its properties, which are only
> > known at runtime, various properties of the OPP can change. For example,
> > an OPP with frequency 1.2 GHz, may have different voltage/current
> > requirements based on the version of the hardware it is running on.
> >
> > In order to not replicate the same OPP tables for varying values of all
> > such fields, this commit introduces the concept of opp-property-<name>.
> > The <name> can be chosen by the platform at runtime, and OPPs will be
> > initialized depending on that name string. Currently support is extended
> > for the following properties:
> > - opp-microvolt-<name>
> > - opp-microamp-<name>
>
> That's really quite "interesting" design. I wondered if devicetree
> people are okay with that.
>
> > If the name string isn't provided by the platform, or if it is provided
> > but doesn't match the properties present in the OPP node, we will fall
> > back to the original properties without the -<name> string, if they are
> > available.
> >
> > Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
>
> But, interestingly, their review tag is missing...?
>
> As this is mainline, I don't think we need to do anything here. I
> wonder how this kind of "wildcard" property names will play with new
> yml format or automatic device tree checks.

The new bindings format can take regex for node names and property
names, so that itself shouldn't be an issue. The name itself is
likely hardware specific so there's not much the automatic checker
can do either.

ChenYu


> Best regards,
>                                                                 Pavel
>
> > +++ b/Documentation/devicetree/bindings/opp/opp.txt
> > @@ -100,6 +100,14 @@ Optional properties:
> >    Entries for multiple regulators must be present in the same order as
> >    regulators are specified in device's DT node.
> >
> > +- opp-microvolt-<name>: Named opp-microvolt property. This is exactly similar to
> > +  the above opp-microvolt property, but allows multiple voltage ranges to be
> > +  provided for the same OPP. At runtime, the platform can pick a <name> and
> > +  matching opp-microvolt-<name> property will be enabled for all OPPs. If the
> > +  platform doesn't pick a specific <name> or the <name> doesn't match with any
> > +  opp-microvolt-<name> properties, then opp-microvolt property shall be used, if
> > +  present.
> > +
> >  - opp-microamp: The maximum current drawn by the device in microamperes
> >    considering system specific parameters (such as transients, process, aging,
> >    maximum operating temperature range etc.) as necessary. This may be used to
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--RM0Zyk6LCdO4pXxZQ2Oi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4699): https://lists.cip-project.org/g/cip-dev/message=
/4699
Mute This Topic: https://lists.cip-project.org/mt/74665629/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--RM0Zyk6LCdO4pXxZQ2Oi--
