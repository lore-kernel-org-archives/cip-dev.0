Return-Path: <SRS0=OYl/=MV=lists.cip-project.org=bounce+64572+6641+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85515C4338F
	for <cip-dev@archiver.kernel.org>; Thu, 29 Jul 2021 08:11:54 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1DBD61077
	for <cip-dev@archiver.kernel.org>; Thu, 29 Jul 2021 08:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A1DBD61077
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id lPotYY4521723xuLvda4Rrgf; Thu, 29 Jul 2021 01:11:53 -0700
X-Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
 by mx.groups.io with SMTP id smtpd.web08.6847.1627546310934496778
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Jul 2021 01:11:52 -0700
X-Received: by mail-oo1-f46.google.com with SMTP id e3-20020a4ab9830000b029026ada3b6b90so1392461oop.0
        for <cip-dev@lists.cip-project.org>; Thu, 29 Jul 2021 01:11:50 -0700 (PDT)
X-Gm-Message-State: VMenWGP3zfte1No747cLA5Gyx4520388AA=
X-Google-Smtp-Source: ABdhPJwd2R+NP8q1qXG2XQul360endVfE5AHojUpWJLKfkaXl95h3BW0i+krZRQGrwcdS37O8UZMpwVhgmpXGYTAt/E=
X-Received: by 2002:a4a:e28e:: with SMTP id k14mr2191952oot.63.1627546310034;
 Thu, 29 Jul 2021 01:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAODzB9o8xwbKB7i1vDfQx0SSZa84+nPh+9kZDKj7LRvpO9R0mg@mail.gmail.com>
 <20210729074703.GA14232@amd>
In-Reply-To: <20210729074703.GA14232@amd>
From: =?UTF-8?B?5biC5bed5q2j576O?= <masami.ichikawa@miraclelinux.com>
Date: Thu, 29 Jul 2021 17:11:14 +0900
Message-ID: <CAODzB9q_2RC84Jt1joU8-FG7kaECsZtMn2uq7Zn8mXF6eC38tg@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="BEqowjOh2wyPvQfSP5qX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1627546313;
 bh=YvfdPrv+XaWTIvFkUQE6alB8x9WRl1vLZnL9HrMmttE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=VK1Ms8gjQaA+RCrUCAhvceHxQvalIbreGYutSUhbWJVeZl2QkDudoR4639jQtvVM1k+
 S+Wch0HzsHCq7uF2W1W04+Yp/ypssg1b0gCKXcp3hBF9iVkE053h8K+oW9B9NX4Y7qgyT
 Tpxc5l/8k8RqWusdJ2k4OTaECOTsl+2Ulls=

--BEqowjOh2wyPvQfSP5qX
Content-Type: text/plain; charset="UTF-8"

Hi !

On Thu, Jul 29, 2021 at 4:47 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > ** Traking CVEs
> >
> > CVE-2021-21781: v4.4 is not fixed as of 2021/07/29
>
> This is basically missing memset. Does not look evil to backport.
>

Thanks.

> > CVE-2021-3655: v4.4 is not fixed as of 2021/07/29
>
> This may need more careful look. There are 4 patches fixing this in
> mainline, but only two in
> 5.10. c7da1d1ed43a6c2bece0d287e2415adf2868697e should be easy to
> backport to 4.4.
>

Okay. I'll take another look.

> > CVE-2021-31829: Linux kernel protection of stack pointer against
> > speculative pointer arithmetic can be bypassed to leak content of
> > kernel memory
> >
> > Fixed status
> > mainline: [f8be156be163a052a067306417cd0ff679068c97]
> > stable/4.19: [117777467bc015f0dc5fc079eeba0fa80c965149]
>
> Strange, this talks about CVE-2021-22543 in the changelog.
>

ok, I'll check again.

> > CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
> > Bluetooth Core Specifications 4.0 through 5.2
> >
> > Not fiexd in mainline yet
>
> > CVE-2021-3655: missing size validations on inbound SCTP packets
> >
> > According to cip-kernel-sec's scripts v4.4 is not fixed as of 2021/07/29
> >
> > One of a patch 50619dbf8db77e98d821d615af4f634d08e22698 is included.
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/net/sctp?h=linux-4.4.y&id=48cd035cad5b5fad0648aa8294c4223bedb166dd
>
> I guess this should be listed in stable/4.4: ... then?
>

Yes, it is. I'll add it.

> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> 
>

Regards,

-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--BEqowjOh2wyPvQfSP5qX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6641): https://lists.cip-project.org/g/cip-dev/message=
/6641
Mute This Topic: https://lists.cip-project.org/mt/84519830/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--BEqowjOh2wyPvQfSP5qX--
