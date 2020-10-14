Return-Path: <SRS0=q3fr=DV=lists.cip-project.org=bounce+64572+5578+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0895C43467
	for <cip-dev@archiver.kernel.org>; Wed, 14 Oct 2020 14:55:18 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70388212CC
	for <cip-dev@archiver.kernel.org>; Wed, 14 Oct 2020 14:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="maeQbRKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70388212CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5578+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id QKfEYY4521723xI1FebOObsF; Wed, 14 Oct 2020 07:55:16 -0700
X-Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
 by mx.groups.io with SMTP id smtpd.web10.172.1602687315511378356
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Oct 2020 07:55:15 -0700
X-Received: by mail-lj1-f194.google.com with SMTP id a5so3489212ljj.11
        for <cip-dev@lists.cip-project.org>; Wed, 14 Oct 2020 07:55:15 -0700 (PDT)
X-Gm-Message-State: iMCpnQM2Z8BkCfSQDljdvoTox4520388AA=
X-Google-Smtp-Source: ABdhPJyqiyuloE0FrQOvHbMt6dKr8tqZyPf+QuEO/KBHaoWj8VqsLVso17KUE01b3zOPNJG4DNTsIA==
X-Received: by 2002:a05:651c:103b:: with SMTP id w27mr1904731ljm.323.1602687313309;
        Wed, 14 Oct 2020 07:55:13 -0700 (PDT)
X-Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id t10sm1312903ljk.53.2020.10.14.07.55.12
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 07:55:13 -0700 (PDT)
X-Received: by mail-lj1-f169.google.com with SMTP id i2so3538073ljg.4
        for <cip-dev@lists.cip-project.org>; Wed, 14 Oct 2020 07:55:12 -0700 (PDT)
X-Received: by 2002:a05:651c:336:: with SMTP id b22mr589986ljp.75.1602687312403;
 Wed, 14 Oct 2020 07:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <TY2PR01MB49721EDA34600391409FFB07A00B0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <OSBPR01MB298313D24CA5EF5B0517AB4792080@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <d5baee23-9a71-6994-146d-1b54d42d1ef9@siemens.com> <20201014141355.GA16362@duo.ucw.cz>
In-Reply-To: <20201014141355.GA16362@duo.ucw.cz>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Wed, 14 Oct 2020 22:55:03 +0800
X-Gmail-Original-Message-ID: <CAGb2v66aPu3wn_0PwRsp3V=LV5aFPwxEO8Rhzsz-bCeF2PDv-g@mail.gmail.com>
Message-ID: <CAGb2v66aPu3wn_0PwRsp3V=LV5aFPwxEO8Rhzsz-bCeF2PDv-g@mail.gmail.com>
Subject: Re: [cip-dev] Backporting of security patches for Intel i40e drivers required?
To: Pavel Machek <pavel@denx.de>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="zxJmzFKq8UQUiatROn3R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602687316;
 bh=7L0KZQOzbchzHLKXNQHYqgulMs18hxeypYTvIcZh5to=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=maeQbRKbPe3uLIs+Zwl49j85BLK5O4Q78c19Bbgl3ngKXz6KZvLezFMvrTuYVVJ3ALY
 /keXQm+ZHaCcs2e1ibARWcaIuR2xCdbSqXwDMRX27GNSDCQ9wsj9RCCA9etcavAQG8rN0
 8Ixu6tmPxndNDtlp2W3YEMIwPwOOcsxZhPA=

--zxJmzFKq8UQUiatROn3R
Content-Type: text/plain; charset="UTF-8"

On Wed, Oct 14, 2020 at 10:14 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > given the exposure of such a device but also the fact that I can't tell
> > for sure if/where it's used (not only by us), I would recommend backporting.
>
> > > There are multiple patches fixed for 4.19, which can be separated by feature.
> > >
> > >  - i40e: add num_vectors checker in iwarp handler
> > >
> > >      This issue has been produced by e3219ce6a7754 ("i40e: Add support for client interface for IWARP driver").
> > >      e3219ce6a7754 is not included in 4.4.y and can be ignored.
>
> It is interesting this one is listed in both CVE-145, CVE-147 in
> cip-kernel-sec. Is that an error?

Given that Intel's security notice did not state which patches fixed which
issues, nor which commits caused them, I tried to guess which patch fixed
which issue, based solely on their descriptions. Then I looked at the history
of the driver to see which commit the patches fixed.

Grouping by feature is probably a better way to determine if the backport
is required or not.

ChenYu

> > >  - i40e: Wrong truncation from u16 to u8
> > >    This can be apply in 4.4.y.
> > >
> > >  - i40e: Fix of memory leak and integer truncation in i40e_virtchnl.c
> > >
> > >    This issue has been produced by e284fc280473b ("i40e: Add and delete cloud filter").
> > >    It is not included in 4.4.y. However, this patch has several different fixes, so some patches need to be applied.
>
> I see also
>
> - i40e: Set RX_ONLY mode for unicast promiscuous on VLAN
>
> which apparently allows people to listen to packets they should not
> see. But I assume this requires elevated priviledges to begin with...
>
> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>

--zxJmzFKq8UQUiatROn3R
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5578): https://lists.cip-project.org/g/cip-dev/message=
/5578
Mute This Topic: https://lists.cip-project.org/mt/77380165/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--zxJmzFKq8UQUiatROn3R--
