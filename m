Return-Path: <SRS0=lN7f=DP=lists.cip-project.org=bounce+64572+5511+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FA6C43467
	for <cip-dev@archiver.kernel.org>; Thu,  8 Oct 2020 08:01:03 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7382193E
	for <cip-dev@archiver.kernel.org>; Thu,  8 Oct 2020 08:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="rpQhP8t6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7382193E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5511+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id GYpEYY4521723xSYA1svjMnr; Thu, 08 Oct 2020 01:01:02 -0700
X-Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
 by mx.groups.io with SMTP id smtpd.web12.7040.1602144061501368433
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Oct 2020 01:01:01 -0700
X-Received: by mail-lf1-f68.google.com with SMTP id g2so5409714lfr.10
        for <cip-dev@lists.cip-project.org>; Thu, 08 Oct 2020 01:01:01 -0700 (PDT)
X-Gm-Message-State: UdaOXeOraHBowYv1iGXrLMxXx4520388AA=
X-Google-Smtp-Source: ABdhPJzoVlfQvWdR+rtyFBKYJg+N3gOUXYwlVm6yTRQmq5QU2EEWx3IZcWZBXDJxTiUe+j1AGQhVqw==
X-Received: by 2002:a19:4151:: with SMTP id o78mr2096906lfa.408.1602144059375;
        Thu, 08 Oct 2020 01:00:59 -0700 (PDT)
X-Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id u3sm743270lfm.57.2020.10.08.01.00.59
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 01:00:59 -0700 (PDT)
X-Received: by mail-lj1-f178.google.com with SMTP id i2so4748029ljg.4
        for <cip-dev@lists.cip-project.org>; Thu, 08 Oct 2020 01:00:59 -0700 (PDT)
X-Received: by 2002:a05:651c:1205:: with SMTP id i5mr2716973lja.47.1602144058997;
 Thu, 08 Oct 2020 01:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200925035927.1958987-1-daniel.sangorrin@toshiba.co.jp>
 <20200925035927.1958987-3-daniel.sangorrin@toshiba.co.jp> <CAGb2v67PutE3wGTOnQMy3FSzWD9uUGth1PF6=wJNY0nRfrn-bg@mail.gmail.com>
In-Reply-To: <CAGb2v67PutE3wGTOnQMy3FSzWD9uUGth1PF6=wJNY0nRfrn-bg@mail.gmail.com>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 8 Oct 2020 16:00:47 +0800
X-Gmail-Original-Message-ID: <CAGb2v64stEN1_Y-v=AbgepmdGvbRNOYe73EyNNhVQyisZs+6xw@mail.gmail.com>
Message-ID: <CAGb2v64stEN1_Y-v=AbgepmdGvbRNOYe73EyNNhVQyisZs+6xw@mail.gmail.com>
Subject: Re: [cip-dev] [cip-kernel-sec 2/3] report_affected: Delete extra blank lines between CVEs
To: cip-dev@lists.cip-project.org
Cc: =?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?= <sz.lin@moxa.com>, 
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="YXLZvy0tRdR17BQ0iCsm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602144062;
 bh=ccah3ml9kWvWNJC9IG3+t5bjE+jUprinQWnrO6UNntw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=rpQhP8t60ZYGe5qOKrBWrmpNalrQ4cn5f6f4xNlBWjTrAz9WSfN2c4KC7s2V7LJkgCs
 R9lXV/1sgFO6MnraPugTltGqQjukgy6EnPiHBp2valkBY/PicWnA/UyiOf+FJ4A8I7I1a
 P6JVaq/J9htauXL0HMZmz650wmGpll3MRzY=

--YXLZvy0tRdR17BQ0iCsm
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 8, 2020 at 3:59 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Fri, Sep 25, 2020 at 12:00 PM Daniel Sangorrin
> <daniel.sangorrin@toshiba.co.jp> wrote:
> >
> > From: nguyen van hieu <hieu2.nguyenvan@toshiba.co.jp>
> >
> > When using the --show-description option CVEs had blank
> > lines between them. Remove them to make it more compact.
> >
> > Signed-off-by: nguyen van hieu <hieu2.nguyenvan@toshiba.co.jp>
> > Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
>
> Reviewed-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
>
> Though these occurrences seem to be very rare.

Jumped the gun. This patch is no longer needed if you use join()
to combine the lines.

--YXLZvy0tRdR17BQ0iCsm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5511): https://lists.cip-project.org/g/cip-dev/message=
/5511
Mute This Topic: https://lists.cip-project.org/mt/77073065/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--YXLZvy0tRdR17BQ0iCsm--
