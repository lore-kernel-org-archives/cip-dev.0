Return-Path: <SRS0=IX9V=EL=lists.cip-project.org=bounce+64572+5751+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27007C4741F
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 13:49:25 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E5E206B6
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 13:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Ki7/T3EY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E5E206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5751+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id n4UyYY4521723x9C0eiVff3x; Thu, 05 Nov 2020 05:49:22 -0800
X-Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.web09.7615.1604584161860096257
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Nov 2020 05:49:22 -0800
X-Received: by mail-lf1-f50.google.com with SMTP id i6so2407932lfd.1
        for <cip-dev@lists.cip-project.org>; Thu, 05 Nov 2020 05:49:21 -0800 (PST)
X-Gm-Message-State: tgurBExzzF6utGsGEX5MPqJwx4520388AA=
X-Google-Smtp-Source: ABdhPJx1RIeddQ39fCYVUrGKMJr15ek/OhiGnL7mZfUGIQtbADLlb0FVQVMa1oX/4FUYA7P1MAmMGg==
X-Received: by 2002:a19:740a:: with SMTP id v10mr961774lfe.315.1604584159534;
        Thu, 05 Nov 2020 05:49:19 -0800 (PST)
X-Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id u18sm186303lfl.304.2020.11.05.05.49.18
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 05:49:18 -0800 (PST)
X-Received: by mail-lf1-f52.google.com with SMTP id 74so2379774lfo.5
        for <cip-dev@lists.cip-project.org>; Thu, 05 Nov 2020 05:49:18 -0800 (PST)
X-Received: by 2002:ac2:46fc:: with SMTP id q28mr965420lfo.551.1604584158519;
 Thu, 05 Nov 2020 05:49:18 -0800 (PST)
MIME-Version: 1.0
References: <CAGb2v65-9JX36eScv7_ZUo7Yx69cpb331qYrLaUTvda7H3cf6A@mail.gmail.com>
 <20201102113906.GC9840@duo.ucw.cz> <20201102211225.GA2874@duo.ucw.cz>
In-Reply-To: <20201102211225.GA2874@duo.ucw.cz>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 5 Nov 2020 21:49:09 +0800
X-Gmail-Original-Message-ID: <CAGb2v64DFZNnuR3Y_m2h5XVyHQXAqh+fKvNhnwBX2FGW=qWr7A@mail.gmail.com>
Message-ID: <CAGb2v64DFZNnuR3Y_m2h5XVyHQXAqh+fKvNhnwBX2FGW=qWr7A@mail.gmail.com>
Subject: Re: [cip-dev] cip-kernel-sec Updates for Last Week of October
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org, 
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="esn2bFTGMthYI8jipaVg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604584162;
 bh=OCaiq2C+jsFwjksI43OOmuMHlM1wDqHAy3CC+4Ozai0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Ki7/T3EYZw1dL3az0f2L4fmSPyF252HX1gTbOxUWoQOICryt17P0lpDzNK2acH+fk6K
 nm6XfXA1yBV5bhR0Yt80eo9bTOLWDR1Wewy4Q5ZJihz9kFrdVjwSilBfSG1W93mKMvvu6
 aWucNy2ASQ70OJls8pXhCqSA9MZ0Bqs60H0=

--esn2bFTGMthYI8jipaVg
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 3, 2020 at 5:12 AM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > > - Fix for CVE-2020-27673 has not been backported yet.
> >
> > Some kind of Xen issue, not really relevant to us, and fix is not
> > easy.
> >
> > I'd say we can ignore this one.
>
> This is queued for 4.19.155:
>
>  | a9d6e970261d 0891fb39ba67 o: | xen/events: don't use chip_data for legacy IRQs
>  | d103e667bb8c 073d0552ead5 o: | xen/events: avoid removing an event channel while handling it
>  | ed86a5182306 4d3fe31bd993 o: | xen/events: add a proper barrier to 2-level uevent unmasking
>  | 6e894d279f4e f01337197419 o: | xen/events: fix race in evtchn_fifo_unmask()
>  | 0279bd8ca365 54c9de89895e o: | xen/events: add a new "late EOI" evtchn framework
>  | adc67cdf742f 01263a1fabe3 .: | xen/blkback: use lateeoi irq binding
>  | 322a5dc88d82 23025393dbeb .: | xen/netback: use lateeoi irq binding
>  | 515827d40949 86991b6e7ea6 .: | xen/scsiback: use lateeoi irq binding
>  | f2db1b870c08 c8d647a326f0 .: | xen/pvcallsback: use lateeoi irq binding
>  | 8b0ac9a498d2 c2711441bc96 .: | xen/pciback: use lateeoi irq binding
>  | 757d54717fae c44b849cee8c o: | xen/events: switch user event channels to lateeoi model
>  | c3c580896847 7beb290caa2a o: | xen/events: use a common cpu hotplug hook for event channels
>  | 7835cdf92784 e99502f76271 o: | xen/events: defer eoi in case of excessive number of events
>  | f8bf3977d67c 5f7f77400ab5 o: | xen/events: block rogue events for some time
>
> "defer eoi" should be fix for this bug.
>
> So..we don't need to do anything here, and it will get fixed.

Confirmed. The fixes for CVE-2020-27673 and 27675 are part of 4.19.155.

Looks like there is no backport for older LTS branches though.

ChenYu

--esn2bFTGMthYI8jipaVg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5751): https://lists.cip-project.org/g/cip-dev/message=
/5751
Mute This Topic: https://lists.cip-project.org/mt/77879900/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--esn2bFTGMthYI8jipaVg--
