Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C45C433EF
	for <webhook@archiver.kernel.org>; Thu, 20 Jan 2022 02:27:39 +0000 (UTC)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 by mx.groups.io with SMTP id smtpd.web08.6521.1642645656194947447
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jan 2022 18:27:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=DA+foPO+;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.182,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f182.google.com with SMTP id s22so7326388oie.10
        for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jan 2022 18:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SJfu7QStq5ynEbkUx7EQPRjX00mRv90lMKsVqzsd08s=;
        b=DA+foPO+YOWeIKy5w94sLOvV5vEp3LkPh+d6MP2jaupYqMCYDKrcthnIJfYw+vtl/P
         0lVeBQHqIak3S6/Q2xSNahhVld1khqexvzs06/XMO7t8HyzpYhJHAV7tX20KXNRZyvVy
         LwSARIPrIPCa5Gn3bJRzulJB0730O4vmTBtzYOKHiUSwVOjzC9QeLCQLdFarjOluTJZr
         VWwfNVt0Ka4JTKhIT51dc3gJp/lIghQ3kbERGBnMKJ1sKCJf4mW9DHvOHni2NDfIOWsK
         gAanKGOZwNzhL7/iyx1oDG4CLIKV1hRVGWCPoxEItI0NNEbtmUkeiWTXj/NjahohUv3a
         /oEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SJfu7QStq5ynEbkUx7EQPRjX00mRv90lMKsVqzsd08s=;
        b=WhxCsfJbo+rJbLmT8hNBNxN+O3XCeR0/T1DigFASSj07doEE4TGR6srYITII+9Trpu
         Lk3a8O3IW5yQozpRolBYI8wy/gukK2We39ZD1I8Qx9tFnhwL6v6HMiKHuzZRGNuO1Bfz
         Wofk64Cd7/gEPVF42ubLu6cJVgqukQXdujJjDbOOAa19UsC8i8HtcT6z1HjOcvUxMk4c
         rXzqJSVNf6ZMCIM27UDONnQ9qEWNyW9R4kIyx0xy3WuJUP0Hj+nS7YtbIyBhxF+OSuJu
         pKdqZxVnkDmalfJOBk9AuhkzrzyeCuHx2/rVbM5l3gCRs8YbO32FGz1njYXRpG9M2gPb
         FtYA==
X-Gm-Message-State: AOAM531Nao+HalUE7FCIX93my5C4M2zXHclg9cWNSQoNrh+6/e/dren+
	hFU7DjUin1Z+jHLIXz+d66llI98FhM1FM9G7Pp1JxssaADUaiA==
X-Google-Smtp-Source: 
 ABdhPJxjMvqin1tuHsvKtDDob7jtFLktJiooNo0n41yXLNFcDftMGJvScdiA5fB9wZgxeOVTLqv1HSayrt1TCMDR768=
X-Received: by 2002:a05:6808:128f:: with SMTP id
 a15mr5746260oiw.116.1642645655195;
 Wed, 19 Jan 2022 18:27:35 -0800 (PST)
MIME-Version: 1.0
References: <20220119141210.GA2310@duo.ucw.cz>
In-Reply-To: <20220119141210.GA2310@duo.ucw.cz>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 20 Jan 2022 11:26:59 +0900
Message-ID: 
 <CAODzB9r+R2hKi2_Au17JLMG4us4W7jrzQhBXVdSBXm_ub+CDhg@mail.gmail.com>
Subject: Re: [cip-dev] 4.4.X-stable and 4.4.X-rt maintainance ends in less
 than two weeks
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jan 2022 02:27:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7469

On Wed, Jan 19, 2022 at 11:12 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> It looks like stable 4.4.X maintainence ends real soon now:
> https://www.kernel.org/category/releases.html . I talked to Greg and
> it seems like plan is to end it at the beggining of month, rather than
> end.
>

Thank you for asking the actual EOL date.

> That means we'll be on our own maintaining -cip and -cip-rt versions.
>
> To review our 4.4 branch:
>
> git log --pretty=oneline linux-4.4.y-cip-rebase
>
> We have 757 patches on top of 4.4.216, and there are some 14000
> patches between 4.4 and 4.4.216. Going forward, most new patches will
> come from upstream.
>
> We do some compile testing, but we only run run-time tests on two
> targets:
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/448669210
> .
>
> Given that most of work we'll be doing will be maintaining -stable
> patches, anyway, I believe it would make sense to step up as official
> maintainers of 4.4.X-stable and 4.4.X-rt series. We'll need to do the
> work, anyway, keeping -stable and -cip split will not result in much
> overhead for us, and this way we'll get a lot of visibility for the
> project, and hopefully a lot of additional testing.
>
> Any thoughts?
>

I agree. The split -stable and -cip work sounds reasonable.
I think it would be helpful, if AUTOSEL system continues to pick
patches for 4.4 series.

> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#7467): https://lists.cip-project.org/g/cip-dev/message/7467
> Mute This Topic: https://lists.cip-project.org/mt/88534661/4520416
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129101/4520416/1465703922/xyzzy [masami.ichikawa@miraclelinux.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

