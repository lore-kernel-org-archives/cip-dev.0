Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A1BC433FE
	for <webhook@archiver.kernel.org>; Thu, 10 Nov 2022 07:28:48 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.web08.4209.1668065321287517479
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Nov 2022 23:28:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=Pr8+eEK6;
 spf=pass (domain: miraclelinux.com, ip: 209.85.218.45, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ej1-f45.google.com with SMTP id k2so2827829ejr.2
        for <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 23:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X/UYWSaiMBcOUWOVlLKG8c7itdqj33pB+BR9EW3IM5U=;
        b=Pr8+eEK6GfkYOXe9IU6SeGmEpeUPgBi7gKsuoniyCFjg1v5bBqVmdOsLJRGi2abIZm
         GldC568s5ckCv8fNl44oWeGtB1wLvjZMBwiwlxk6LfmQYhzLZkdE6OY+GtEqdPZ+++wQ
         LM0jwNOjATNjwdI5017GH1fTJdVC02L6Zys0u64myY1hfVneF8B80ZeNrWpYAWRXE+cL
         uwohbvN7sJZCixM0ygs1rvPMdp+TKQ8V25+jNAYXRaVOYZErQNVFfjAEMyj/hiCSkqqf
         W0gUl1UF0nMiMat15TX6fyqldyh7aFVzuzj+xcoY0TfJlug+lhKggphcjtJQ2EIXfvYI
         y4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/UYWSaiMBcOUWOVlLKG8c7itdqj33pB+BR9EW3IM5U=;
        b=iLMIn3vuqFaF6Q+XvMxXeI51ZkXHFf3o3avfAbAGqhCXrZAjoomCMdzkpKrPCkzoVw
         8IKfEqEvo9nzoWOJWImi1joH4xeUcSomerIPVAecLpbh/Lgb2rIwqPCf00TlGkI07J8F
         igWtSE4zZT4XTqd+CMiAH51NQUi+rSBQ2PGqrlMxtP31VWtYNWC78XvVP0xtH6tB4b77
         KFTisvYRl9X5ksfghoydajp4pKB/YsL8e/guVpCYjsqysW5zKQMRiywqboOK4z2N/WiN
         bJ/1WX/wtgLXAtLOlpnNTY3mLjxNEPAT1UNJEi+Wo5omIMmE61arDb9bjgnuMHsPFb/D
         l8qw==
X-Gm-Message-State: ACrzQf3044lnkXWs+8vy2u8FgcWDNb5TnDTBL3C9QnXeaTv1PZ+Wek5F
	SAk4xFJF070a2dW76LEKOBwbgBiHpCcGIx5aPgzdYzBACkVp3w==
X-Google-Smtp-Source: AMsMyM6KwlplpFY1Bh+MTMzfExDg0ydwz1Kl61qVshbcb076prIzSZDxryRUzEdDorPAB+2h34P1vkbTe+tIm0wHv34=
X-Received: by 2002:a17:906:8a7c:b0:7ad:ad3a:b206 with SMTP id
 hy28-20020a1709068a7c00b007adad3ab206mr58321725ejc.345.1668065318908; Wed, 09
 Nov 2022 23:28:38 -0800 (PST)
MIME-Version: 1.0
References: <43e3ee09-7756-d356-df2d-d674d7da3404@siemens.com>
In-Reply-To: <43e3ee09-7756-d356-df2d-d674d7da3404@siemens.com>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 10 Nov 2022 16:28:03 +0900
Message-ID: <CAODzB9q3ahZ5gei0aeMtK6M1kUR0rU3Bqw9AR09+Nk=hbSbqdA@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Nov 2022 07:28:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9993

Hi !

On Thu, Nov 10, 2022 at 4:16 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> Hi all,
>
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
>
>     irc:irc.libera.chat:6667/cip
>
> The IRC meeting is scheduled to UTC (GMT) 12:00:
>
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=11&day=10&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248
>
> USWest    USEast    UK        DE        TW        JP
> 05:00     08:00     12:00     13:00     20:00     21:00
>
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/11/cip.2022-11-03-12.02.log.html
>
> * Action items
>   1. Add qemu-riscv to cip-kernel-config - patersonc
>   2. Create MR for disabling smc test in qemu - iwamatsu
> * Kernel maintenance updates
> * Kernel testing
> * AOB
>   - actively communicating deviations from the kernel release schedule
>

I can't make it today, sorry.

> Jan
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#9992): https://lists.cip-project.org/g/cip-dev/message/9992
> Mute This Topic: https://lists.cip-project.org/mt/94931535/4520416
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

