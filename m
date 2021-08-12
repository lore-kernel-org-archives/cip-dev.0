Return-Path: <SRS0=dhBD=ND=lists.cip-project.org=bounce+64572+6675+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C923CC4338F
	for <cip-dev@archiver.kernel.org>; Thu, 12 Aug 2021 08:41:13 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AFB760C3E
	for <cip-dev@archiver.kernel.org>; Thu, 12 Aug 2021 08:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2AFB760C3E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8UrGYY4521723xG0zZXC7OMH; Thu, 12 Aug 2021 01:41:12 -0700
X-Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
 by mx.groups.io with SMTP id smtpd.web09.19585.1628757669791501604
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Aug 2021 01:41:11 -0700
X-Received: by mail-oi1-f176.google.com with SMTP id bf25so415058oib.10
        for <cip-dev@lists.cip-project.org>; Thu, 12 Aug 2021 01:41:09 -0700 (PDT)
X-Gm-Message-State: cs8mLI5gdJb9WHUVQ7qxzhmfx4520388AA=
X-Google-Smtp-Source: ABdhPJwD04LApQfjnOlSRtsFG0tHmzrk28qLiw4HIyqYMUi5GZ6rAzvSRWonaR7637VfG69OuZWLKLzdRN6g04CGqGY=
X-Received: by 2002:aca:ab8b:: with SMTP id u133mr2501100oie.116.1628757668827;
 Thu, 12 Aug 2021 01:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAODzB9q2GjB-rsuq-Ro43yZvVKHY-joQKiXWYx_iqowfwexVCA@mail.gmail.com>
 <20210812054337.GA26920@duo.ucw.cz>
In-Reply-To: <20210812054337.GA26920@duo.ucw.cz>
From: =?UTF-8?B?5biC5bed5q2j576O?= <masami.ichikawa@miraclelinux.com>
Date: Thu, 12 Aug 2021 17:40:32 +0900
Message-ID: <CAODzB9p0uk5rg9ctkoXyD7VJVAzVQxqqdWwQmOhZYK=7UyShXw@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="m5W62UTBciXjYDVKxC42"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1628757672;
 bh=ors5D8/VvBmXlev4zPRXGjIW5dx0Lu5PAHhusbjTLG8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=j5yGx+PoetmfbvWysPttGmPgIRgx3XE/iPf09W1Awdpu9huAuJIvLzzqQfzofTxTXz8
 /+on9o98ewgPwMh75hh/BsoikWkVbRcObvOO8HTJ3K+21ngLKch3+xHIvkwIu0zc/ivyq
 Sg2jT7d0kqVlkV6XY8jwgibYbUO9ppy8MhM=

--m5W62UTBciXjYDVKxC42
Content-Type: text/plain; charset="UTF-8"

Hi !

On Thu, Aug 12, 2021 at 2:43 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > * CVE detail
> >
> > New CVEs
>
> > CVE-2021-38205: net: xilinx_emaclite: Do not print real IOMEM pointer
> >
> > xemaclite_of_probe() in drivers/net/ethernet/xilinx/xilinx_emaclite.c
> > leaks kernel memory layout.
> >
> > Fixed status
> >
> > mainline: [d0d62baa7f505bd4c59cd169692ff07ec49dde37]
> > stable/5.13: [8722275b41d5127048e1422a8a1b6370b4878533]
>
> This affects our kernels (I looked at 5.10.57 and 4.4.277). On one
> hand we could ask for backport, on the other... I'm not sure it is
> serious enough to warrant any action.
>

I think this vulnerability seems to be low priority because an
attacker needs another vulnerability to abuse this vulnerability.
However, it would be nice to backport the patch too.

> Best regards,
>                                                                 Pavel
>
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

--m5W62UTBciXjYDVKxC42
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6675): https://lists.cip-project.org/g/cip-dev/message/=
6675
Mute This Topic: https://lists.cip-project.org/mt/84830495/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--m5W62UTBciXjYDVKxC42--
