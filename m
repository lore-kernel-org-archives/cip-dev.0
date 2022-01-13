Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8247EC433F5
	for <webhook@archiver.kernel.org>; Thu, 13 Jan 2022 12:41:53 +0000 (UTC)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by mx.groups.io with SMTP id smtpd.web12.8366.1642077711543570506
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jan 2022 04:41:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=X9kmpY0X;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.47,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f47.google.com with SMTP id
 s8-20020a0568301e0800b00590a1c8cc08so6046951otr.9
        for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jan 2022 04:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=J0UbZT82MC5+f+2G2ySFezoLEdyD6Ed5uQIMj8Q2Y2Y=;
        b=X9kmpY0XbJaW+Y5ol66fjY6z4EBUcZkRoSX/EzxrRtc0VDFedECANqOF/wuWy6lsFI
         6jzpa8DKSlwnfk/YU3ETRJ2jtr2wiOgPMS7TbS9izzFU8dyy54zMoMxXNFQER/RhDXNm
         5z4pNDXr5PWPtXs6nUSOOoITnU+6onf8Me0NeagM8aj/1W89zgZtbZnOYfpRZTw35mXG
         Rcl3H0w7pFYQL7Li8AsBOuDkhACFKBINebo7ZPL5tKIZB8hxg8/qSNkJW6y3Lb2RHTz7
         S4kY/LUgxnvtJ+5X04WFKBxSUeKJ/FljoPq9u35QYGGKr+3tVf/pkfOs/zWpGG+43P10
         0qRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=J0UbZT82MC5+f+2G2ySFezoLEdyD6Ed5uQIMj8Q2Y2Y=;
        b=StOdym6ZGS5GeKEtSEChsWgDicglOcACYplh9U0hySU5CPJC7ZYUyGl7cicXvrAtO+
         WnB+M91xaesoZ9Knjixq1TcN+jaStnW6dkfkxOOyHNjOH/jBGt4BX0ddgjsfvFTUpU4z
         YeTl2ctvo7VkwJehk/SYGzr1xZxp74Ofw9i/zawNgqR+YwxB6ljDbbIdHygfrkVrgQ8p
         uFDvlEQzCr2AAh3bgungOSdu4H1MSKGQqdtGDvgq4vO1Cg0nGYjlD0CZ/OGxevBrVQ4F
         s9k/MRNLc+h7ZC9BQm/yUmPb9yyTYLzWCcFhTUCjFDvGwnmyURDh54wloMhiQKkm4hdM
         AZIQ==
X-Gm-Message-State: AOAM533+No/EIhT8wTiZ9Ggu9eoMZRPKTAOEEIB2ov7fj5HHr28HxTPC
	q8C4+PgJLwQOQhiBxvTE/wDSkk7Ibv4IqcufI1BOSbs+q9GVWw==
X-Google-Smtp-Source: 
 ABdhPJyeg9khIKIUEb4tgglb5+GJhnQ0HNy0jvyJEO2G3XNIxA0cGp8HVPrPqCboF6Bz9fFdK7MdlkvZSDhdM4QgJOw=
X-Received: by 2002:a9d:7319:: with SMTP id e25mr598845otk.232.1642077710575;
 Thu, 13 Jan 2022 04:41:50 -0800 (PST)
MIME-Version: 1.0
References: 
 <CAODzB9ojKHaZ13TykpwVx3ot7Y45qQaZt7S0gCfag2E9Ad-Apw@mail.gmail.com>
 <20220113080742.GA15000@amd>
In-Reply-To: <20220113080742.GA15000@amd>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 13 Jan 2022 21:41:14 +0900
Message-ID: 
 <CAODzB9q0NVm5H_DDJA7XrmVpOFWNSrwhHFWMszU570OP9tgDyQ@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entries in this week
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jan 2022 12:41:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7458

Hi !

On Thu, Jan 13, 2022 at 5:07 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > * New CVEs
> >
> > CVE-2021-39633: ip_gre: add validation for csum_start
> >
> > CVSS v3 score is not provided
> >
> > An information leak bug was found in gre_handle_offloads() which is in
> > net/ipv4/ip_gre.c.
> > This fix uses skb_checksum_start() to check data but this function was
> > introduced at 4.6-rc1 commit 08b64fc ("net: Store checksum result for
> > offloaded GSO checksums") so applying this patch requires commit
> > 08b64fc too.
> >
> > Fixed status
> >
> > mainline: [1d011c4803c72f3907eccfc1ec63caefb852fcbf]
> > stable/4.9: [41d5dfa408130433cc5f037ad89bed854bf936f7]
>
> So this needs more investigation and possibly 4.4 port? 08b64fc looks
> quite small/simple.
>

I checked it.
It required following patches to apply commit 1d011c4 ("ip_gre: add
validation for csum_start")

1. 7644345 ("net: Move GSO csum into SKB_GSO_CB")
2. 08b64fc ("net: Store checksum result for offloaded GSO checksums")

Commit 1d011c4 required commit 08b64fc and  08b64fc required commit
7644345. Both commit 7644345 and 08b64fc are able to apply to
stable/4.4.y tree without any modification. Commit 1d011c4 needed an
easy fix.

> > CVE-2021-39634: epoll: do not insert into poll queues until all sanity
> > checks are done
> >
> > CVSS v3 score is not provided
> >
> > A local attacker could gain his privilege by abusing this bug. All
> > stable kernels and the mainline kernels have already been fixed.
> >
> > Fixed status
>
> ...and 4.19 and older is fixed, and 5.10 already contains
> f8d4f44df056c5b504b0d49683fb7279218fd207, so nothing to do here. Good.
>
> > CVE-2021-4204: eBPF Improper Input Validation Vulnerability
> >
> > CVSS v3 score is not provided
> >
> > A local attacker can escalate privileges via this bug.
> > This bug is affecting the 5.8 or later kernel. The commit 457f4436
> > ("bpf: Implement BPF ring buffer and verifier support for it")
> > introduced this issue.
> >
> > To mitigate this issue, set kernel.unprivileged_bpf_disabled to 1.
> >
> > Fixed status
> >
> > Not fixed yet.
>
> Apparently Ubuntu has a fix for this. But I guess we can wait till it
> hits mainline.
>
> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#7457): https://lists.cip-project.org/g/cip-dev/message/7457
> Mute This Topic: https://lists.cip-project.org/mt/88386186/4520416
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

