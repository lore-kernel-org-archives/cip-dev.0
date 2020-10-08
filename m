Return-Path: <SRS0=2Tm8=DP=lists.cip-project.org=bounce+64572+5512+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF47C43467
	for <cip-dev@archiver.kernel.org>; Thu,  8 Oct 2020 08:18:54 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7835215A4
	for <cip-dev@archiver.kernel.org>; Thu,  8 Oct 2020 08:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="NMvA0XgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7835215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5512+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id I1aYYY4521723xPyv9E9f7fc; Thu, 08 Oct 2020 01:18:52 -0700
X-Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
 by mx.groups.io with SMTP id smtpd.web12.7289.1602145131760250719
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Oct 2020 01:18:52 -0700
X-Received: by mail-lj1-f179.google.com with SMTP id d24so1812788ljg.10
        for <cip-dev@lists.cip-project.org>; Thu, 08 Oct 2020 01:18:51 -0700 (PDT)
X-Gm-Message-State: JPU5Gi94Hht1Hhwmcgbgzndnx4520388AA=
X-Google-Smtp-Source: ABdhPJwvICycvYlLkP2ka+Z/rEP7O6NxGxdXRi3/raZl/uhTPSSHarx8JFY6+1tb5OU4uhG136FlQA==
X-Received: by 2002:a2e:808a:: with SMTP id i10mr2356115ljg.427.1602145129538;
        Thu, 08 Oct 2020 01:18:49 -0700 (PDT)
X-Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id f11sm745652lfc.146.2020.10.08.01.18.49
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 01:18:49 -0700 (PDT)
X-Received: by mail-lj1-f180.google.com with SMTP id a23so3995365ljp.5
        for <cip-dev@lists.cip-project.org>; Thu, 08 Oct 2020 01:18:49 -0700 (PDT)
X-Received: by 2002:a05:651c:104:: with SMTP id a4mr2885666ljb.273.1602145129143;
 Thu, 08 Oct 2020 01:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200925035927.1958987-1-daniel.sangorrin@toshiba.co.jp> <20200925035927.1958987-4-daniel.sangorrin@toshiba.co.jp>
In-Reply-To: <20200925035927.1958987-4-daniel.sangorrin@toshiba.co.jp>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 8 Oct 2020 16:18:36 +0800
X-Gmail-Original-Message-ID: <CAGb2v66v0N=eC_1-2kFbdYp=mLFTd69mRJ_BeBhw3HXyOya2Rg@mail.gmail.com>
Message-ID: <CAGb2v66v0N=eC_1-2kFbdYp=mLFTd69mRJ_BeBhw3HXyOya2Rg@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="wDdaOhKvbt16R0QQsZtw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602145132;
 bh=anKeiUGp6bfjRmrH4eYtOMyPUyDX8k0K7mgRyG4xYWw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=NMvA0XgKIEsDkyYAXnMsfIGJCr1vrFuGOZqWlDF4gJ3fE0gPGY10+taiY7nwIP+kIwz
 qMTCaE69wlkjhoLfdaRYqtcO6EJkcyRdSc7hE1Ftgtsnrsxja0Lxhoqeb4L/eQIT+9Lu/
 0gKafMPwj2cwA0XS3+eZExid4QKYoMuUa6s=

--wDdaOhKvbt16R0QQsZtw
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 25, 2020 at 12:01 PM Daniel Sangorrin
<daniel.sangorrin@toshiba.co.jp> wrote:
>
> From: nguyen van hieu <hieu2.nguyenvan@toshiba.co.jp>
>
> I noticed that some issues have the description field empty
> when using the --show-description option.
>
> Signed-off-by: nguyen van hieu <hieu2.nguyenvan@toshiba.co.jp>
> Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>

Looks like all the new descriptions were copied from MITRE.

Reviewed-by: Chen-Yu Tsai (Moxa) <wens@csie.org>

--wDdaOhKvbt16R0QQsZtw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5512): https://lists.cip-project.org/g/cip-dev/message=
/5512
Mute This Topic: https://lists.cip-project.org/mt/77073076/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--wDdaOhKvbt16R0QQsZtw--
