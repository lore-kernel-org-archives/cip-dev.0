Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09EFC624A4
	for <webhook@archiver.kernel.org>; Thu,  3 Sep 2026 09:19:13 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3542.1788427143387320172
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2026 02:19:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=ZtZrkl/t;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=UnHTrhEq;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.217, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1788427136; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sqUo/0xp+XJ12HZnqABPW7N951sVzTwp96VDPnR0yHcYs+CUK9ueVERsaw9/8gXaRt
    RqZm4SZm2BuhnGS2f6CSVjKQ5oq3GuMOiyxgaMYUUFPkHrvff4dRPZSPqvWFc7eU5tF7
    LwEfWL0nTKHv8e8cYWfX6j+vxpQZ7DYnQTxtnPR48djVFqzXwpYxAnwnokKvs13n1gZb
    A/HBGe4hPsdJUpMMAMo3CyXYPDqdCOjht1RNWJfSC86tYDYh6wjuOVTgRRmydPW8/2aQ
    EvsXB1iFQ9aseUi/JWdt+l7m6Z5QPyLFs80kEAqp8KdRYeBy7RmHVzcN23jFaLe4ZUcm
    DpMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1788427136;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ks+lilr6vyj/h/3B4YwdfWf4Uu1c0htraNn1RXgMoEM=;
    b=Wmis6ElQz0W8v3fH2TYq2X5vKvjlg0Usd7hDezF1YeDBNy3hAOL2UUcSbXq2qilngd
    2fGmxzQD4olQth0Ko6BcWnpyh20xDATpl74Lsg54yLzYCu5ETWbe87CTLEhwSxI/e2E1
    vs1oQshaQAizzIFhnNhCU8/PFND41BvLoxirJNw0GtdDc4ovMWLJf5jTHeoOX6gFygSs
    Fr4vp9zAm+iotgDtIWutXZhC3sr0MJlPFW2mYcfyMRoLGS9gaNBxKkYt2z+encWN1LaE
    vu8TAtnevIOYWXHDt9VJGYTCmhWKJgB9JXKl2YJyKnxmu/oC3kEJo3Sf3tDRGqhGAEqT
    8+4A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1788427136;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ks+lilr6vyj/h/3B4YwdfWf4Uu1c0htraNn1RXgMoEM=;
    b=ZtZrkl/t+6xijbl6G0K0YVag366VX0JusvZeJEz33JiBjd8lHyhyOE9qh/vx3n1k/N
    O6v0C4AwlggDfivHNLLKZQMFnfaDeu4IekXGn8JdkW8vgyitKTRb5Crk4SYRWyX28H0L
    Ubqxry9mAMT86gEZlfiqGOK5DXzeLtte5YkNzqvPIl2f4yx40OFYImg0x0yOhlySOdtZ
    ZJ93hodL7ry3MQHSVAbSOFMDQ5AA1Dx3/Mb44tAIJQv1yYsHHd1K7yKRSDomLJfT2i7F
    d1vMCh9TxxxG2/kJuUIBy9JEdvKjtMMJ19VknigPnjqXPwO58yyP2AWs2C+NqoMwHY10
    UnWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1788427136;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ks+lilr6vyj/h/3B4YwdfWf4Uu1c0htraNn1RXgMoEM=;
    b=UnHTrhEqe8RoVo2LZ35Wzad8Eh2UrKNMfBI9evWh5s7IePw9//mC4ACGxQ4RhaSlbH
    afBQRPafrek+9HaPjvBg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKHK+AR2fLw="
Received: from open-xchange-core-mw-gw-10.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.6.2 AUTH)
    with ESMTPSA id ze24d92839It3Jy
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 3 Sep 2026 11:18:55 +0200 (CEST)
Date: Thu, 3 Sep 2026 11:18:55 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: Pavel Machek <pavel@nabladev.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <284291068.310120.1788427135517@webmail.strato.de>
In-Reply-To: <apk3GX_faRAev-Ta@duo.ucw.cz>
References: <588742173.259606.1788373971804@webmail.strato.de>
 <apk3GX_faRAev-Ta@duo.ucw.cz>
Subject: Re: Request for review for 4.19-st20, 4.19-cip136
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.154
X-Originating-Port: 39936
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Sep 2026 09:19:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24088


> On 09/03/2026 11:00 AM CEST Pavel Machek <pavel@nabladev.com> wrote:
> > Here are the "manual" backports for the upcoming 4.19 kernel
> >  release. There's a total of 68; 40 by me, and 28 by LLM. (The latter
> >  are labeled with "Assisted-by: SLTR:qwen-3.8".)
> 
> I'm not huge fan of "the more the better" here.

There were 1300 patches incoming this release cycle; the number of backports reflects that. If you see classes of fixes that should not be backported I can ignore those in the future. (I have sent you the prompt I'm using for triage.)

> We are not testing all
> of the kernel, we are not even compile testing all of it

I am doing the latter.

>, so bugs will
> eventually creep in.

Right now it looks to me as if this approach reduces the number of bugs. The LLM has more time to look into backports and was able to find differences in 4.x that I would have not found because of that.

> Can you clarify what role LLM had here, what goals you set for it, and
> how you reviewing the stuff?

- The added bit that produces the backports is simply "If applicable, write out a modified version of the patch that applies to the legacy code base."
- The patches marked with the Assisted-by tag have been applied by me as written by the LLM.
- I'm reviewing the auto-generated backports manually as well as using the review prompt as found in the SLTR repository.

CU
Uli

