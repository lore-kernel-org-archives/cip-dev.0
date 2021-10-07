Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04CEC433F5
	for <webhook@archiver.kernel.org>; Thu,  7 Oct 2021 11:39:33 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51])
 by mx.groups.io with SMTP id smtpd.web12.10298.1633606772037692008
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Oct 2021 04:39:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=4Xqs0d85;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.51,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f51.google.com with SMTP id
 r43-20020a05683044ab00b0054716b40005so7113431otv.4
        for <cip-dev@lists.cip-project.org>;
 Thu, 07 Oct 2021 04:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=SbPAEEEWPBarAJtVkymy5KyOmJPL1G9r3YSyhBiz02E=;
        b=4Xqs0d85Y7YAi0TNdLrvC2NJzYpQDYtAooGWnPjBVqrMWu2QtXRELT6/5B3Id2qX75
         g/uMLSmoFwMHwO1FJYTJ9mP4cTSRt2oDfEbi+wLj82+10X5Yn6ja76Bpldct7GK1b87r
         RPAYBrwN9917RGGjalMXI9rOI54HLWsrodgPF6A9pcPNLhLePFntG5RMzrJHgnb0JAVe
         Y5gOyw8VajbLmnXxbVD3w99XiUFTZJeWirQYXsQkU9iJ18QJ+WNam2IwIqvLguweW6/c
         WcQNisARZFoZhXOtGHwszeIMf1M51nUNQUg37r4ALBUsNX8INMpyvuAhJkpRVzcKMTH6
         fgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=SbPAEEEWPBarAJtVkymy5KyOmJPL1G9r3YSyhBiz02E=;
        b=nAq4HlZCvbhKeet/7YOvj1UJQw2XBZ9B2N511JHkPJz2hLWa5d2KyRPmdpkqLJt02E
         kT1zvVD5cv/weo0ET3i8QPT8eoFVv7voaE8b6n6Azmp9wQ8L5c+uaj9+nzDROyIlD6LT
         L83JJOjW0SPB0hKtqNOXfeHi+Q2eUQi2X+rh0CfSWVoWmsaZnKDtLuii31lPpfucTKtg
         qKI2csLPHFEBapCubQz3I3bzbcKrOX1CRAFR9BrfGEjxosL++lc/YD/BHmH0sBVyiGpT
         SF2o+55XOCaKjUFalf2Rpiv0LRe25yAV0FQJ/n/SspCfbRZlSPcGcA3BqljThX+lyzMN
         PK6A==
X-Gm-Message-State: AOAM531kTub0nTS0RJBmtJZfGhoVlq8NjEo/7/Jphbx6Kw3X026UqWMU
	lj8HsR1zl2To96rSm5o9TCRn4OAQt6hIR76rIme4UeD/fec=
X-Google-Smtp-Source: 
 ABdhPJx+3HOlsv/JcgNO+fCoWr+7Mw0TBcmfSQnD2cnZd7Go8qrCUS79LHKNZ6VXI/8AVp7K/Lk90WUSCztovn6M1/c=
X-Received: by 2002:a05:6830:4411:: with SMTP id
 q17mr2890834otv.67.1633606770814;
 Thu, 07 Oct 2021 04:39:30 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CAODzB9rKixC0p_tFV=qR7sTgPqS1ZxuXJJnkPufW+z-m8NFHxA@mail.gmail.com>
 <20211007073054.GA10302@duo.ucw.cz>
In-Reply-To: <20211007073054.GA10302@duo.ucw.cz>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 7 Oct 2021 20:38:55 +0900
Message-ID: 
 <CAODzB9omMdRDC9JxfJie63w0SA5-LKGRaPuNAAe8WbexFMsw7w@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entry this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Oct 2021 11:39:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6804

Hi !

On Thu, Oct 7, 2021 at 4:31 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > It's this week's CVE report.
> >
> > This week reported  new CVEs.
> >
> > * New CVEs
> >
> > CVE-2021-41864: bpf: Fix integer overflow in prealloc_elems_and_freelist()
> >
> > CVSS v3 score is not provided.
> >
> > Patch 30e29a9a2bc6 (bpf: Fix integer overflow in
> > prealloc_elems_and_freelist()
> ...
> > Fixed status
> >
> > Fix patch has been merged into bpf tree, but not in the mainline yet.
>
> I guess we can wait for this to be merged through normal channels.
>

Yes. I'll track the patch goes into the mainline.

> > * Updated CVEs
> >
> > CVE-2019-19449: mounting a crafted f2fs filesystem image can lead to
> > slab-out-of-bounds read access in f2fs_build_segment_manager in
> > fs/f2fs/segment.c
> >
> > This patch has been merged since 5.10-rc1.
> > For 5.4, patch can be applied via git-am. For 4.4 and 4.19, patch can
> > be applied via git-am with -3 option.
> >
> > Fixed status
> >
> > mainline: [3a22e9ac71585bcb7667e44641f1bbb25295f0ce]
> > stable/5.10: [3a22e9ac71585bcb7667e44641f1bbb25295f0ce]
>
> It may make sense to help with this backport.
>
> > CVE-2021-37159: net: hso: do not call unregister if not registered
> >
> > 4.14, 4.19, and 5.4 have been fixed. 4.4 and 4.9 haven't been fixed
> > yet. However, patch can be applied to 4.4 and 4.9 without any
> > modification. According to cip-kernel-config, no CIP member use HSO
> > module.
>
> Not sure why this has CVE number. We probably need not care.

I agree.

>
> > CVE-2021-38300: bpf, mips: Validate conditional branch offsets
> >
> > This vulnerability is only affected to MIPS architecture. No cip
> > member use MIPS architecture.
> >
> > 5.10 has been fixed. Applying this fix to 4.4, 4.9, 4.19, and 5.4, it
> > needs to modify the patch.
> >
> > Fixed status
> >
> > mainline: [37cb28ec7d3a36a5bace7063a3dba633ab110f8b]
> > stable/5.10: [c61736a994fe68b0e5498e4e84e1c9108dc41075]
>
> I guess we don't care about MIPS.
>

I see. We don't have to track this CVE.

> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#6802): https://lists.cip-project.org/g/cip-dev/message/6802
> Mute This Topic: https://lists.cip-project.org/mt/86134956/4520416
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

