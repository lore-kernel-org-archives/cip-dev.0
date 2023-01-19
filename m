Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E55C00A5A
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 13:57:01 +0000 (UTC)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
 by mx.groups.io with SMTP id smtpd.web10.45491.1674136619990754119
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jan 2023 05:57:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=4czE1vgY;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.53, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1322d768ba7so2589740fac.5
        for <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 05:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6sOxTg5yFoX/h7K+1nBDf2KoEN6x5x02I29k60pJgF4=;
        b=4czE1vgYtJWdw13E99Qrf5CNyjLbdMkrfBF3Hb/e9iiFmHar1be0AH3lF9lGq6GURF
         Q0fikQ13a4QPL3TQFyPR6AKRi2X6dlGgSHwm9KJYE4cdNRBOBiFJjdVw/qcNOkElyNI2
         d0NrxETGmVsFdC0bhTVMxc0B4BHN9PYXeCwdQzBzBne0Ckq2tEmLIvfQFI8tbuetVsd7
         FYn11WMIuHU0HuavK1YiEocFVDcYZgXqAQfZKSX3OsxyWfNvhhtTKxJHVZ1tjngpgmBo
         HkHKohw9bJNqbT9eeuUv0ixtqGjhQ1uYDue0+Z3rUC900SjazFDE4S7fYrDyuERsRtMA
         MlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6sOxTg5yFoX/h7K+1nBDf2KoEN6x5x02I29k60pJgF4=;
        b=Nwp80v9FgtMaDVQkTPSGCrLUyguRU6DyTMV8HtPPwZ+7oKNsjI57uir6hnyJIrsiUZ
         JHjaoYeh/nbRE6cdpctrTHeRKbAri6MpeyoW+0wVj+yPW6DXcd2IC/WgcHqRc10NcfUO
         b6HSHDI3y5kW8kdKNUKve5078Wa8BM4e2lVmSW0uDONYQ/A529zs3vWU3S4TVNT9NmOO
         haB5gLZeKK+d8IaKtP2P26ndPew6RD2Q6B4K9JdAeCIjevzgqdTkNufk5Rt0cRQn/G7h
         2tckL17Q9tEmWp19nQcie4Jkvdw5rivzT/YFEB7Y23G+5V6L9F60JbVNp7xZiEna81Jn
         xheA==
X-Gm-Message-State: AFqh2kpVxlQFTBfU8jt3u2ZpI9+iv1BL+vgBiAYFnyWFSmRCo5idab1r
	uyk1X+d4O/gl8b551ZQW4o7Eb0vAM8nJGwoqljs9tg==
X-Google-Smtp-Source: AMrXdXszgwVb6liG0dcw247T7JtKyJKphzFKsunLAuGT2JlmLO//vvec/jwtJCA7zCtIjj0fxj2vIyeSuhfJAqz1eMU=
X-Received: by 2002:a05:6870:4513:b0:15b:8f97:237 with SMTP id
 e19-20020a056870451300b0015b8f970237mr828895oao.58.1674136619192; Thu, 19 Jan
 2023 05:56:59 -0800 (PST)
MIME-Version: 1.0
References: <CAODzB9oy2nCYdfa7vzG59nQ6owAKUv+jkqD4tpufn+k8_kjuaw@mail.gmail.com>
 <Y8j2dnYDZnw+DcEw@kili>
In-Reply-To: <Y8j2dnYDZnw+DcEw@kili>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 19 Jan 2023 22:56:22 +0900
Message-ID: <CAODzB9rHqzUTn1dmaP1j1SsiYh5UcJ5AKSjVL7PpxYE5ifRVCA@mail.gmail.com>
Subject: Re: New CVE entries this week
To: Dan Carpenter <error27@gmail.com>
Cc: cip-dev <cip-dev@lists.cip-project.org>, 
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 13:57:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10444

Hi.

On Thu, Jan 19, 2023 at 4:51 PM Dan Carpenter <error27@gmail.com> wrote:
>
> On Thu, Dec 15, 2022 at 12:25:18PM +0900, Masami Ichikawa wrote:
> > CVE-2022-4378: Linux kernel stack-based buffer overflow in __do_proc_dointvec
> >
> > CVSS v3 score is not provided
> >
> > A stack overflow bug was found in __do_proc_dointvec() which missed
> > checking on user input.
> > This bug affected all stable kernels. It seems as if 4.4 is affected too.
> >
> > Fixed status
> > mainline: [bce9332220bd677d83b19d21502776ad555a0e73,
> > e6cfaf34be9fcd1a8285a294e18986bfc41a409c]
>
> One thing that we used to do at Oracle was a bi-weekly meeting where we
> would go through these lists and try to be a bit proactive about
> preventing future bugs.  For me I'm trying to use Smatch for static
> analysis.
>
> There are some bugs which Smatch can't identify like race conditions or
> if there is an issue with the spec.  But for a lot of bugs can be
> prevented.  So it's often an issue of 1) There isn't a Smatch check for
> that.  2) The Smatch check exists but isn't working correctly.  3) The
> Smatch check prints a warning but there are too many warning for that
> check so I can't go through them all.
>
> First of all, why wasn't *size marked as user controlled?  It turned out
> that it comes from iov_iter_count() and that wasn't marked as user
> controlled.  Fix that:
> https://github.com/error27/smatch/commit/70ee7aa1ae8cc07767096e16fa2de68a62507a3e
>
> Once that was fixed, it turned out that I did have an unpublished check
> which printed a warning.
> kernel/sysctl.c:358 proc_get_long() warn: check 'tmp[len]' for negative offsets 'len' = s32min.  extra = 's32min-21'
>
> But it turns out that warning was because of a bug.  The check was
> asking can "*size" be user controlled and what is the minimum possible
> value negative, but it should have been asking if the minimum user
> controled value is negative.
>
> Fixing the check to as about user controlled values silenced the
> warning.  The issue with that is:
>
>         left -= proc_skip_spaces(&p);
>
> Subtractions are very hard to handle correctly because you need to keep
> track of the relationships between multiple variables.  Smatch
> deliberately assumes that this subtraction cannot underflow.  Otherwise
> you end up with too many false positives...
>
> I've been sitting on this check for the past ten years without
> publishing it.  May as well attach it now and also the results.  I don't
> know why the check has __per_cpu_offset stuff or why it ignores ntohl().
> I should probably delete that and see what happens.  Going through the
> results, a bunch of false positives are cause by subtraction (which is
> complicated).  Or because Smatch doesn't understand about
> array_index_nospec() (I should fix that).
>
> Anyway, even though I wasn't able to generate a warning for this bug,
> it was still useful to have the discussion and improve Smatch.
>

Thank you for the information about Smatch. It's really helpful. I
think it is important to learn from reported bugs then prevent future
bugs as you did.
I'll try to use Smatch.

> regards,
> dan carpenter
>

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

