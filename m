Return-Path: <iwamatsu@nigauri.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A486C38A2D
	for <webhook@archiver.kernel.org>; Tue, 25 Oct 2022 12:53:29 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
 by mx.groups.io with SMTP id smtpd.web10.6546.1666702400346338967
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Oct 2022 05:53:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nigauri-org.20210112.gappssmtp.com header.s=20210112 header.b=wyuz9BWQ;
 spf=none, err=permanent DNS error (domain: nigauri.org, ip: 209.85.128.178, mailfrom: iwamatsu@nigauri.org)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-369c2f83697so104854757b3.3
        for <cip-dev@lists.cip-project.org>; Tue, 25 Oct 2022 05:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I06m73cFugnAszoxjVljG3VaFQTUVJ7RGvD1xCAhewo=;
        b=wyuz9BWQc3+Z4jhiwcq6dG0tRKew2LyoUHiK0879utW0keeYfO859yWkPT4s+wzeR4
         4HQ7ookq3gCKQ0m6If/h7jRdscezCBV8mOLrQot9x1DEx967mVui8ymT9AwgjSB6QmPm
         KgATWZRG345p4VSLPRUmDmBRVyt/kH/xzGn+/EYLLzP0NDWpjQaYjy51Knlc6nnMhO3I
         aKXbGCuWJl/AVjG3oKzob98IPnRCcSwH2PdO52psYxIy4f2EgMAcQkWbiC0w7cuH9YVT
         1SS7Z14h11zA7pcX/efUDo9H31D/O0niArg+dZhR1NSdjKJA3C/omudgdAjY8ByFglWM
         4jdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I06m73cFugnAszoxjVljG3VaFQTUVJ7RGvD1xCAhewo=;
        b=3toq1MrNZyFE6A5mebJbh2ywsfPxi8H8Wq4HXWIUa31Xgb6PjvwvM7OSxjy9hQoM8Z
         kNyHEFUeDO1nDhuy4aR76qclryyyH1HcDCD6pNWrCixY0KltMOVk1lCR2/3F2wZwLyDf
         1uBLz8vKVaXxfo6MV0ijI/gjSVV9Ui3t9osR7uM/ILH5GF+ZK4DFRJ8iP89Tgi10EDKq
         mVXHOADKdoP2o/yuuZqvgnz9kndPjcnAUK26bx1WUc/ozVNka+0Y/XwuL/zuL9W8fFEE
         uYUi40paFTUDFIeG266wlEWsQYw0GEB/DT03I7UeWPLbMwXc4q2uAk98zUMamzoFABvP
         ce4A==
X-Gm-Message-State: ACrzQf38Elhm18jHafr/rd+tpO5NstfscBI9lfVLE3kWQ9JceAxwmD2u
	6Ys1Z/XnEMxp2LzqIyDTIJutveGdYQh5RQgJ3tlm
X-Google-Smtp-Source: AMsMyM6IAI+JRphvwrEE58HmpnoINERSwP1hx6AngD2/btbtmGCMAU4keeJqctC0+XHHkQfthgOPeSXovv8zFxK37vU=
X-Received: by 2002:a0d:cb82:0:b0:36b:3015:cf0f with SMTP id
 n124-20020a0dcb82000000b0036b3015cf0fmr15332990ywd.255.1666702399518; Tue, 25
 Oct 2022 05:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221022145808.zuftgygxfkizeowp@debian> <CABMQnVLDc7h9o-w7QPH8JAqDT6uWREXQHBKjfukMaZL-JdtgRQ@mail.gmail.com>
 <20221025101413.uwvgp7jrv6sjztnn@debian>
In-Reply-To: <20221025101413.uwvgp7jrv6sjztnn@debian>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Tue, 25 Oct 2022 21:52:53 +0900
Message-ID: <CABMQnVLm+6ritcWAbk3a1-+voYN5sLX3arFrCd1frYZ4vsqjUA@mail.gmail.com>
Subject: Re: The brief status of Debian riscv porting --2022/10/22
To: Bo YU <tsu.yubo@gmail.com>
Cc: debian-riscv@lists.debian.org, cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Oct 2022 12:53:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9820

Hi!

2022=E5=B9=B410=E6=9C=8825=E6=97=A5(=E7=81=AB) 19:14 Bo YU <tsu.yubo@gmail.=
com>:
>
> Hi,
> On Tue, Oct 25, 2022 at 06:26:15PM +0900, Nobuhiro Iwamatsu wrote:
> >Hi!
> >
> >Thank you for sharing the porting status of RISCV64.
> >
> >When I make this a Debian official port, I'm worried about what is a blo=
cker.
> >Of course, there is a porting package coverage, but do you know what
> >the support status
> >such as infrastructure and others when it becomes an official port?
> >If possible, I would like to cooperate with this.
> >
> >According to architecture requalification[0] and other
> >information[1][2], Buildd-DSA[3] and
> >porterbox seem to be major blockers. Are you or other member working on =
these?
>
> Yeah, It seems we are stuck in setting up official buildd machines.
> Currently this is working by the Debian RISC-V buildd team.
> Unfortunately, haven't got the latest news from them for a long time.
> But there is no doubt that they are working hard on it.
>

Thank you for your comment.
I will ask the RISCV64 Buildd team about current status.

Best regards,
  Nobuhiro

--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org / kernel.org}
   GPG ID: 32247FBB40AD1FA6

