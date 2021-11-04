Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B1CC433F5
	for <webhook@archiver.kernel.org>; Thu,  4 Nov 2021 13:04:48 +0000 (UTC)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com
 [209.85.167.177])
 by mx.groups.io with SMTP id smtpd.web09.11306.1636031086101628570
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Nov 2021 06:04:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=pvrEZJO2;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.177,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f177.google.com with SMTP id l15so9101466oie.8
        for <cip-dev@lists.cip-project.org>;
 Thu, 04 Nov 2021 06:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Py1k/allBNQTdsR0RqulaLbowDciJ7HEYxkMiBG1EXE=;
        b=pvrEZJO2IQQUvJVqx9XxxC2GXBUMM1Q3JDzauyJS+FOOxv6aaTJeV4v8xTKfTgTsbY
         dRGejRFA+yt0bTdT8N59xrzcaCVLQm+gKrZJm6MKkKEcddROHp11wKvVsfoFEi+rNvyt
         VGz3fGfnqelQlb61aoWzlGjUp7cUvGr5q1uDsJ0jUjsKwfiwYastxJhQLzjS3zAgPvPC
         5ku52B2J4uGmRw/i0DxKH57NjqZZw+cqfe5kP+ljOsoQzbmMupLv55Kv6XqkE9dUZqPg
         Ml5rHuBUiJ7h+L8WrtcDKjfAX5OzhhghwcOiY1EaNvFYyf/xE+Fl+58qvY9wqg4IQmQ6
         wS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Py1k/allBNQTdsR0RqulaLbowDciJ7HEYxkMiBG1EXE=;
        b=p74RIQ6IJkSxMOm8z0NTAUvaeo99Plr4DLbk24FvzA/DMMdVvki6996BZ6EjeTuu3c
         SYG84oNWRQiwsNyDdEWUrXvwktuhdakw7UYcCXtq3cTbmkt9kaus4LLXncI1IlVlRmwN
         9FR1YJMRCJXgh6a+4O5d2M0NABQQZgfFVDROqQj2VtBXYpGJMeuUvxvlOiKO99d7wmFp
         nNPMWepJ9CISyD+7hpiW9ubUqDk1nXlCwOgC/TqndI6TgIiE6JrcVUekHUKdfegiF+SC
         Cln6h9+axmOYqQpX/ef+pe0Qqy1xGCuzjPP6R6No7ZCDsBGk3OHVvkuG2V7NgxFoQ1UP
         mzRw==
X-Gm-Message-State: AOAM5326/OqgwTuHGLV3TU9yott+TXOYTcOmrOYi3wj9QFWYDDCb0nJU
	qNzLmWkORqyiQXNTrp+NlvGwPMZ5FU7VPyleWqc2+8Ijv/qZ9g==
X-Google-Smtp-Source: 
 ABdhPJw2oEFAcM8TuZ1nPTp8tTVe4TcwQIcG/dFB9g+7rwVJKQT5s2qL7leW/FdYsIdkyeXQYQyd8hC+EASskzqHeuI=
X-Received: by 2002:aca:c654:: with SMTP id w81mr5329431oif.66.1636031085103;
 Thu, 04 Nov 2021 06:04:45 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CAODzB9rc8Y_kUnMfYebK_sHt5tOSvf+qr0pgYkZy+N0zqudu4g@mail.gmail.com>
 <20211104095723.GA2592@amd>
In-Reply-To: <20211104095723.GA2592@amd>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 4 Nov 2021 22:04:09 +0900
Message-ID: 
 <CAODzB9p+1-t=OK1kC0pJxmnLn-tGqFd1fdfh52HY554sZs58ug@mail.gmail.com>
Subject: Re: [cip-dev] New CVE Entries in this week
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Nov 2021 13:04:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6861

Hi!

On Thu, Nov 4, 2021 at 6:57 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > CVE-2021-34981: Bluetooth CMTP Module Double Free Privilege Escalation
> > Vulnerability
> >
> > This CVE is fixed in 5.14-rc1.
> >
> > Fixed status
> >
> > mainline: [3cfdf8fcaafa62a4123f92eb0f4a72650da3a479]
> > stable/4.19: [f8be26b9950710fe50fb45358df5bd01ad18efb7]
> > stable/4.9: [77c559407276ed4a8854dafc4a5efc8608e51906]
> > stable/5.10: [1b364f8ede200e79e25df0df588fcedc322518fb]
> > stable/5.4: [fe201316ac36c48fc3cb2891dfdc8ab68058734d]
>
> This seems to be fixed in stable/4.4, too, as
> 61a811e8f5229264b822361f8b23d7638fd8c914. And cip-kernel-sec says so,
> good.
>

Thanks. I accidentally removed stable/4.4 from the above list.
CVE-2021-34981.yml contains stable/4.4 too.

> > CVE-2021-43267: tipc: fix size validations for the MSG_CRYPTO type
> >
> > This vulnerability was introduced since 5.1-rc1 so before 5.10 kernels
> > aren't affected by this issue.
> > The mainline and stable kernels have been fixed.
>
> AFAICT the vulnerability was introduced by 1ef6f7c9390f in
> 5.9-rc3. But that does not change anything for us.
>
> > * Updated CVEs
> >
> > CVE-2021-3772: Invalid chunks may be used to remotely remove existing
> > associations
> >
> > This bug is in SCTP stack that attacker may be able to send packet
> > with spoofed IP address if attacker knows IP address and port number
> > being used.
>
> AFAICT it is more of "if attacker can send packets with spoofed IP
> addresses, he can...". Many of our configs use SCTP.
>

NVD hasn't given CVSS v3 Scores yet. However Red Hat and SUSE both
give it a score of 5.9. So it looks like it's not too serious issue.
Of course, it'd be nice to have patches.

https://access.redhat.com/security/cve/CVE-2021-3772
https://www.suse.com/security/cve/CVE-2021-3772.html

> > CVE-2021-42327: drm/amdgpu: fix out of bounds write
> >
> > The parse_write_buffer_into_params() was introduced since 5.9 so
> > before 5.9 kernels aren't affected by this vulnerability.
> >
> > This CVE was fixed by 5afa7898ab7a ("drm/amdgpu: fix out of bounds
> > write"), however next commit 3f4e54bd312d ("drm/amdgpu: Fix even more
> > out of bound writes from debugfs") said that amdgpu_dm_debugfs.c
> > contains same issues so it'd be nice to apply 3f4e54bd312d
> > ("drm/amdgpu: Fix even more out of bound writes from debugfs") too.
>
> This looks quite easy to fix, OTOH CIP configs do not use amdgpu and
> it is not too serious in the fist place.
>

I agree.

> > CVE-2021-20322: new DNS Cache Poisoning Attack based on ICMP fragment
> > needed packets replies
> >
> > Update stable/5.4 and stable/4.19 fixed revisions.
> > It seems like stable/4.4 and stable/4.9 need backport following patches.
> > - 4785305c05b2 ("ipv6: use siphash in rt6_exception_hash()")
> > - a00df2caffed ("ipv6: make exception cache less predictible")
> > - 6457378fe796 ("ipv4: use siphash instead of Jenkins in
> > fnhe_hashfun()")
>
> It would not be bad to understand the problem in the first place. Yes,
> I guess different hashes have different qualities, but...
>
> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#6860): https://lists.cip-project.org/g/cip-dev/message/6860
> Mute This Topic: https://lists.cip-project.org/mt/86807104/4520416
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129101/4520416/1465703922/xyzzy [masami.ichikawa@miraclelinux.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>


-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

