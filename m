Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E454EC433F5
	for <webhook@archiver.kernel.org>; Thu,  9 Dec 2021 14:12:49 +0000 (UTC)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by mx.groups.io with SMTP id smtpd.web08.11809.1639059164768556760
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Dec 2021 06:12:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=RRBKWdBG;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.169,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f169.google.com with SMTP id r26so8847776oiw.5
        for <cip-dev@lists.cip-project.org>;
 Thu, 09 Dec 2021 06:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=0t1CNZ4qdzrdnBSfFCotyZ304AsHNWiHUK/fS1Mjsnc=;
        b=RRBKWdBGU6IRdpDwriy4X1zL5MyttpMFzpVFTX8Tfq0b+o2byfbcEQfrDUn5QpA87m
         Q+Alf9YTGPEQ+gqtWr3n4TSjPmyEUOiMVeI9x7yoyuxFXBrUFUyscTsAVMSUXcY9Le+z
         CwBORYF/aaHVqjVWs/u8k0aQ28Vahg89qze/V6hYCVDR29rkzuqcIKURx8oCApFfVf7S
         TV2GipwmJ8dAVJ7GkJEF80k/+3fV9XEWguaABoHTtkZM5H0s1GCTzoBxJi/IqePEillC
         wkb5nuT9WoE0nasO3DaKSGz+a63hiYYLRezIBCHf5Gwt2jqQKjrFbg8DdlAAkqlUUsE/
         v3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=0t1CNZ4qdzrdnBSfFCotyZ304AsHNWiHUK/fS1Mjsnc=;
        b=KEF1Sj8rnd3q8KA0dfrm4JMZBMby2hKP/MREHpBiOkDDoHzHfaNjxyU7KCfuWfu083
         rOv4QEw8wNvhPDHMPsfObUQD4PNornOvw46YkqRx8EIXrvG/tQRGJhIVIi3rvT3mApx7
         c68mhLTEQgoHJF0eibJzO/qf3IavEdx1GWnrvCfhGD3W0kH+dsy8HlZkLPWlL5Y6f8mR
         V81dFGGKfp11VJeBghuyQdQyP1hOht69T+FHTdkF8nlvM/1BBNN//EDQIbWg34jSLNPw
         fi+Tjkz7DzzllLZlv4OirrTMk6tV38V77zupx0xJ5scV6/rGB2jG/iPP25uSfqsQ+zcP
         aySQ==
X-Gm-Message-State: AOAM531e10m5vkbzhxktwrNc05WSDsPdXaoqeKAAoI5mGdnGqnCp3nge
	b2A8qC5zYwmGSr6iLMrZmEIzgoAnDjNO+WHCLdeluSloGy8=
X-Google-Smtp-Source: 
 ABdhPJxESF8Nfq044OgtJrfV6R9CicUSjlkXuucDTw13qgEsvTYs6DeeHNIxSATtCnrJHeXwvY/c3o66lRUct8/y+ZY=
X-Received: by 2002:aca:674a:: with SMTP id b10mr6081926oiy.66.1639059163519;
 Thu, 09 Dec 2021 06:12:43 -0800 (PST)
MIME-Version: 1.0
References: 
 <CAODzB9om4QmKLw-ABYqwWSBKL0Sndapov8FWLmhPQKtq1ZvQKA@mail.gmail.com>
 <20211209092052.GA14638@amd>
In-Reply-To: <20211209092052.GA14638@amd>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 9 Dec 2021 23:12:07 +0900
Message-ID: 
 <CAODzB9qxwVDVCosFY6LU9iXxqBTOFcjoANgj9-cLkzoc6mam4Q@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entries in this week
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Dec 2021 14:12:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7083

Hi !

On Thu, Dec 9, 2021 at 6:21 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > * New CVEs
> >
> > CVE-2021-39636: "no details"
> >
> > CVSS v3 score is not provided
> >
> > There is no vulnerability details yet. However, there is five patches
> > are addressed so the bug is in the netfilter module.
> >
> > f32815d ("xtables: add xt_match, xt_target and data copy_to_user
> > functions"): merged in 4.11-rc1
> > f77bc5b ("iptables: use match, target and data copy_to_user helpers"):
> > merged in 4.11-rc1
> > e47ddb2 ("ip6tables: use match, target and data copy_to_user
> > helpers"): merged in 4.11-rc1
> > ec23189 ("xtables: extend matches and targets with .usersize"): merged
> > in 4.11-rc1
> > 1e98ffe ("netfilter: x_tables: fix pointer leaks to userspace"):
> > merged in 4.16-rc1. This fixes commit ec23189 ("xtables: extend
> > matches and targets with .usersize") that was merged in 4.11-rc1.
> >
> > Fixed status
> >
> > mainline: [f32815d21d4d8287336fb9cef4d2d9e0866214c2,
> > f77bc5b23fb1af51fc0faa8a479dea8969eb5079,
> >   e47ddb2c4691fd2bd8d25745ecb6848408899757,
> > ec23189049651b16dc2ffab35a4371dc1f491aca,
> >   1e98ffea5a8935ec040ab72299e349cb44b8defd]
> > stable/4.14: [f32815d21d4d8287336fb9cef4d2d9e0866214c2,
> > f77bc5b23fb1af51fc0faa8a479dea8969eb5079,
> >   e47ddb2c4691fd2bd8d25745ecb6848408899757,
> > ec23189049651b16dc2ffab35a4371dc1f491aca,
> >   ad10785a706e63ff155fc97860cdcc5e3bc5992d]
>
> Hmm. Fun. 1e98ffea5a8935ec040ab72299e349cb44b8defd may have a clue:
>
>     This leads to kernel pointer leaks if a match/target is set
>     and then read back to userspace.
>
> So that sounds like KASLR workaround? iptables are normally limited to
> priviledged users, and KASLR is just a technology to make exploitation
> hard. I don't think we care too much here.
>

I got it.

> > CVE-2018-25020: bpf: fix truncated jump targets on heavy expansions
> >
> > CVSS v3 score is not provided
> >
> > Fixed status
> >
> > The BPF subsystem in the kernel through 4.17-rc7 has overflow bug.
> >
> > mainline: [050fad7c4534c13c8eb1d9c2ba66012e014773cb]
>
> Fun. JITs are hard to get right. I guess "avoid BPF" and "certainly
> don't allow unpriviledged access to BPF" is good advice.
>

Yeah, I agree.

> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#7079): https://lists.cip-project.org/g/cip-dev/message/7079
> Mute This Topic: https://lists.cip-project.org/mt/87601555/4520416
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

