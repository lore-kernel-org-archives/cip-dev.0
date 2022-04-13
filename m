Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1529EC3A589
	for <webhook@archiver.kernel.org>; Thu, 14 Apr 2022 16:03:54 +0000 (UTC)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 by mx.groups.io with SMTP id smtpd.web09.5479.1649892572512138643
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 16:29:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=lzEJySLU;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.52,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f52.google.com with SMTP id
 b17-20020a0568301df100b005ce0456a9efso2231014otj.9
        for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 16:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V0oaY+f11TUYqTXHgBkGYptjPd7omR9JytXcLvnPgcQ=;
        b=lzEJySLUc60UHyC2BamRP8kHypDMWitnKs+NmPNytwPccaPHtcsEBjsYwBpIOdZzSr
         pCVMb4nevqrzlS3j72qMUECZnZc5NqkR31IcGXhbw8+qBFjLorbm5l5AFhjt+PwcM2Nc
         D2E4PXDN/4QCDFy9vMn9rDlMKG7ADjrmeIL1OTk7tVf/MWMpsrXmOBVK6YfsQEOU9RH5
         AosY0L691bAWEzY9wMrDgrpsU1EdhKCtTe/w/JDuj8ZhBPrTnTl2bdsUDTWzExqOg2hC
         MgJwMiCoUXoKCu3/WsZcXyxbM332rW2du3see48G6XGaDS8VlssgjBWti0CyHv1ZXDOO
         UPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V0oaY+f11TUYqTXHgBkGYptjPd7omR9JytXcLvnPgcQ=;
        b=0tNupZRSqPQaWL6OtaOkXnh7gTUTsoKycCgho2PWVm1gqKbFKnS8KQJfNggydWNZqk
         1MTpXUiciyI/aqRgV41sJ7f6xxf7+PCy8x24+IXN6TiP1rghuMQujLwkJaS2YDn47h1W
         MSrJ7+Tp7FzCtQzzZclc1aSdvtiG3oE0+Ab3Uy8agXsWYCS1+PTIKRLzAACOMMtoRfRt
         DGLaHeFmSH2GdAJqsex9IEDQOL/SllWU3CjcdezIeouY/KdA8hsnCsgQqoesjaBFjcqX
         c0vK9XoTtLyKW1Dvoc6DuYC/qdn4SnLXQVI12kdVKJRTlVc/fj/+mt0OhoB6g75yKm52
         T3BA==
X-Gm-Message-State: AOAM530bNTBj1gBnAg63+8+jowFvdZlM4mFPGJQyLnMW8Gf5PlkNKK2/
	Kj/YH+Ot7Xht22fS1DX/rHEZMbiuJgZ/h8YCSHShtzlfWINXWQ==
X-Google-Smtp-Source: 
 ABdhPJzkYcrau3CW2CZWluJrMWtTN8fF84ad7TM/w93t3a3DpykTGBbS2oeqh3DIvjK5LqvfqHvXP1IlY6on8ts6Ce8=
X-Received: by 2002:a05:6830:1b74:b0:5e6:97b2:4173 with SMTP id
 d20-20020a0568301b7400b005e697b24173mr23492ote.336.1649892571356; Wed, 13 Apr
 2022 16:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <76860af5-c727-1ca9-a572-ef505ed51aaa@siemens.com>
 <20220407090607.GA20233@duo.ucw.cz>
 <54e32f3a-cc78-2e6f-2414-9ee2e2791243@siemens.com>
In-Reply-To: <54e32f3a-cc78-2e6f-2414-9ee2e2791243@siemens.com>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 14 Apr 2022 08:28:55 +0900
Message-ID: 
 <CAODzB9rQq=eO1FgK80XO5_TAqsk5CLuicN9cfEw5Oh8Tx=Q4jw@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Apr 2022 16:03:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8084

Hi.

On Wed, Apr 13, 2022 at 6:12 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 07.04.22 11:06, Pavel Machek wrote:
> > Hi!
> >
> >> Kindly be reminded to attend the weekly meeting through IRC to discuss
> >> technical topics with CIP kernel today. Our channel is the following:
> >>
> >>     irc:irc.libera.chat:6667/cip
> >>
> >> The IRC meeting is scheduled to UTC (GMT) 13:00:
> >>
> >> https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=4&day=7&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248
> >>
> >> USWest    USEast    UK        DE        TW        JP
> >> 06:00     09:00     14:00     15:00     21:00     22:00
> >>
> >> Last meeting minutes:
> >> https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/03/cip.2022-03-17-13.00.log.html
> > ...
> >> IMPORTANT NOTE: I'm unfortunately not able to run the meeting myself
> >> today due to an appointment conflict (damn DST...). Could someone else
> >> from the kernel team take over again? Thanks in advance.
> >
> > After DST shift, 13 UTC is not really great time for me, either. 12
> > UTC would be better, 9 or 10 UTC would be even better. I don't propose
> > shifting today's meeting, but should we talk about shift?
> >
>
> Forgot to follow up on this:
>
> Are there any concerns among our participants to move this by one hour
> earlier?
>

I think it's okay.

> If no, the next logical question would then be:
>
> Stick with one hour earlier, or will this cause conflicts again on the
> end of DST in Autumn?
>
> Please raise you voice.
>

I prefer to move permanently an hour early, but it's okay to return to
the current time when the end of DST comes.

> Thanks,
> Jan
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#8072): https://lists.cip-project.org/g/cip-dev/message/8072
> Mute This Topic: https://lists.cip-project.org/mt/90307897/4520416
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

