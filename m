Return-Path: <SRS0=95Pp=DH=lists.cip-project.org=bounce+64572+5482+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D837C2D0A8
	for <cip-dev@archiver.kernel.org>; Wed, 30 Sep 2020 03:29:23 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFE4C20773
	for <cip-dev@archiver.kernel.org>; Wed, 30 Sep 2020 03:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="lqvg2Y60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE4C20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5482+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id PJalYY4521723xd9ndogeHz7; Tue, 29 Sep 2020 20:29:21 -0700
X-Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
 by mx.groups.io with SMTP id smtpd.web11.7277.1601436559177556114
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Sep 2020 20:29:19 -0700
X-Received: by mail-lj1-f180.google.com with SMTP id k25so332989ljk.0
        for <cip-dev@lists.cip-project.org>; Tue, 29 Sep 2020 20:29:18 -0700 (PDT)
X-Gm-Message-State: vlcPOirxMy21ciHi1lYMXSEux4520388AA=
X-Google-Smtp-Source: ABdhPJxjcvt1OIuyYjZw+1Ymum0HTbYzYP5mAx2aF5mX/LPdZqM241kImvSwbiUXFzf2GOv1apBBOQ==
X-Received: by 2002:a2e:87c7:: with SMTP id v7mr241838ljj.13.1601436556734;
        Tue, 29 Sep 2020 20:29:16 -0700 (PDT)
X-Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id f9sm29514ljc.129.2020.09.29.20.29.16
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 20:29:16 -0700 (PDT)
X-Received: by mail-lf1-f45.google.com with SMTP id m5so361694lfp.7
        for <cip-dev@lists.cip-project.org>; Tue, 29 Sep 2020 20:29:16 -0700 (PDT)
X-Received: by 2002:a19:4281:: with SMTP id p123mr121431lfa.398.1601436556069;
 Tue, 29 Sep 2020 20:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200925035927.1958987-1-daniel.sangorrin@toshiba.co.jp>
In-Reply-To: <20200925035927.1958987-1-daniel.sangorrin@toshiba.co.jp>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Wed, 30 Sep 2020 11:29:03 +0800
X-Gmail-Original-Message-ID: <CAGb2v65C_=w2zkL9caQbC4+YmfiBejx5TBTYPPZqqz=QqQrhyQ@mail.gmail.com>
Message-ID: <CAGb2v65C_=w2zkL9caQbC4+YmfiBejx5TBTYPPZqqz=QqQrhyQ@mail.gmail.com>
Subject: Re: [cip-dev] improve show-description results
To: cip-dev@lists.cip-project.org
Cc: =?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?= <sz.lin@moxa.com>, 
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="ZRjg7n4xv2aQHr0zAQZ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601436561;
 bh=/40aa5CWqfhvdQ/hwPvHtiN7jrl9bkFUllwvemMO4SU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=lqvg2Y60UtAZ5zAB34NtagYgO1y9zLxAKrM6e+2+sErqMp+OFUorn1tqDWf9EIeiFxf
 oqi94ogL2UVDCS8iTZXGGHdhbNzr1reSA66PFnocWS83/ZtVkB/wiwWl5AjnbHiXmMA64
 ipMU8jdPGbS6tHSX08HGWmmoOJ/9lzqUp88=

--ZRjg7n4xv2aQHr0zAQZ1
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, Sep 25, 2020 at 12:00 PM Daniel Sangorrin
<daniel.sangorrin@toshiba.co.jp> wrote:
>
> I had this in the backlog for a long time. These
> patches, improve the way CVEs' descriptions are displayed
> when calling scripts/report_affected.py with the option
> --show-description` enabled.
>
> [1/3] report_affected: word-wrap for the 'description'
> [2/3] report_affected: Delete extra blank lines
> [3/3] issues: fill in the description field of

Thanks for submitting these.

I'll take a look at them next week, after the long weekend here.

ChenYu

> Thanks,
> Daniel
>
>
> 
>

--ZRjg7n4xv2aQHr0zAQZ1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5482): https://lists.cip-project.org/g/cip-dev/message=
/5482
Mute This Topic: https://lists.cip-project.org/mt/77073039/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ZRjg7n4xv2aQHr0zAQZ1--
