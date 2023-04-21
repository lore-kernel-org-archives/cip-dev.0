Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65058C77B75
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 07:28:20 +0000 (UTC)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
 by mx.groups.io with SMTP id smtpd.web10.6387.1682062092159730934
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 00:28:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=O0OeXE61;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.54, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-187b70ab997so9561897fac.0
        for <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 00:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1682062090; x=1684654090;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVIUi7ww3YS3Rf5GyNI8KDKImgc/oQOQMTKk25CahS0=;
        b=O0OeXE61ojeK6YY0wrXDjY9A3MvsA2CZ7V9uLqZvkxJO7HojxRzhCKGaW4074UAArW
         PI72/EZQPzTa2BGVWrYTXiMUbR7pjV5qCC8v8SlMztSkqxpKzElSWAz5lv+x82jihz8+
         rfFg4usZ7vT+wj9jx7PVTM+Gm544a36VW+1PiAVxVcahoounV48mOVE/vSkU7pRpQwZy
         ThFI6+lISpWiRPeuTs4ctJYf7B/UJNIYeg7AnrvcSEv8NvBGEjwcWPQbYep1AbPgtZey
         0fbkjqEUcur9SRw2FhRQ8kvdVHSYg5WOmLZbX+otoWIv18KgzDB6mY4qkym+4mKODmSh
         cIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682062090; x=1684654090;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVIUi7ww3YS3Rf5GyNI8KDKImgc/oQOQMTKk25CahS0=;
        b=GnZqWGf+1y5U4PGaq12K3vyh2177dwAlCHiHbx0S7mH63vs+LotmCIotUM/z8fx340
         U8qNgmxZxO0s6NyNkWSxq5jJuKhrdRCe7xd//eeQIr3XBC/LJhTBNmcEApbKlmJVgngo
         coagvR74S+vQ0BtRs5iZLq6fo0L+nZgnCkZfOzaZeCgypbn3WkhiP7ohb4gkjqvznh7r
         GO0ARq6SLrfi23w2/6bV7zS2NzuxmhciftfmyE3EnKuEMvo3a3A4IwS4xNqZBUOgfQTb
         iNwF7jXB27/XLOvG5j0bAA2J7W3HXiMSJT60ICAqpQzf1JJGdh++a9kwS0oI97zsJJFd
         dHGQ==
X-Gm-Message-State: AAQBX9eh/ZEogtgkjx0jQrrixAFHlB+xXQdZ5Om80ZpMO0STUjT76M9r
	Ae1aKjVwKmrVwwwTd4O0nf72/Nh5HEmdsIvyADsqU6a+ITIcs3ZPAl4=
X-Google-Smtp-Source: AKy350auQJola15tu+WBelvXrHboAvMcAYTdPlqHru3CyBW9CuHGv3vvL32HQYQoC7EOOmPpZvw4KyQthg6o+XA/ToM=
X-Received: by 2002:a4a:c48b:0:b0:541:87fe:5b75 with SMTP id
 f11-20020a4ac48b000000b0054187fe5b75mr1031101ooq.1.1682062090458; Fri, 21 Apr
 2023 00:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAODzB9p6MuyqPJeiEpun8CDR9+ZJ9PHhhWG-wyM7f7C0d=krwA@mail.gmail.com>
 <ZEGcHOWAk8S0zEBz@duo.ucw.cz>
In-Reply-To: <ZEGcHOWAk8S0zEBz@duo.ucw.cz>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Fri, 21 Apr 2023 16:27:33 +0900
Message-ID: <CAODzB9pWyCxW4uSFA_NZZmztTzp2fEbSam+Kw5nO5UPg1XxAJw@mail.gmail.com>
Subject: Re: CVE-2023-0459: Spectre-v1 Usercopy Hardening was Re: [cip-dev]
 New CVE entries this week
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 07:28:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11307

Hi.

On Fri, Apr 21, 2023 at 5:10=E2=80=AFAM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > CVE-2023-0459: Spectre-v1 Usercopy Hardening
> >
> > CVSS v3 score is not provided.
> >
> > Missing speculation barriers causes a leaking kernel memory.
> > The 4.4 kernel _copy_from_user() implementation is different from
> > 4.19 and later. So this patch can not be applied.
> > It seems as if the 4.4 kernel needs some barrier to prevent
> > speculation bug in other ways.
>
> I have this, and it passes basic testing,

Nice!

> but no good way to really
> test it or asses performance impact.
>

Umm, we need to write a test driver and check performance by perf or someth=
ing?
I found the Linux Test Project write a test driver to test
copy_[from|to]_user and [put|get]_user.  We may need the same thing.
https://github.com/linux-test-project/ltp/tree/master/testcases/kernel/devi=
ce-drivers/uaccess

>     Attempt to fix CVE-2023-0459. Inspiration from
>     e0fbff18bbcee4f07d46bee172803fad63f6f4dd, but we simply add the check
>     to access_ok, as it is used in about gazillion places.
>
> Best regards,
>                                                                 Pavel
>
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/ua=
ccess.h
> index 829fa6d3e5611..ce45b6dcb6293 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -101,6 +101,7 @@ static inline void set_fs(mm_segment_t fs)
>                 : "1" (__addr), "Ir" (size),                            \
>                   "r" (current_thread_info()->addr_limit)               \
>                 : "cc");                                                \
> +       barrier_nospec();                                               \
>         flag;                                                           \
>  })
>
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uacces=
s.h
> index ac6932bf1a016..ea1e4ef4a4d8e 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -95,8 +95,11 @@ static inline bool __chk_range_not_ok(unsigned long ad=
dr, unsigned long size, un
>   */
>  #define access_ok(type, addr, size)                                    \
>  ({                                                                     \
> +       bool ret;                                                       \
>         WARN_ON_IN_IRQ();                                               \
> -       likely(!__range_not_ok(addr, size, user_addr_max()));           \
> +       ret =3D likely(!__range_not_ok(addr, size, user_addr_max()));    =
 \
> +       barrier_nospec();                                               \
> +       ret;                                                            \
>  })
>
>  /*
> diff --git a/include/linux/nospec.h b/include/linux/nospec.h
> index 0c5ef54fd4162..207ef2a20e485 100644
> --- a/include/linux/nospec.h
> +++ b/include/linux/nospec.h
> @@ -9,6 +9,10 @@
>
>  struct task_struct;
>
> +#ifndef barrier_nospec
> +# define barrier_nospec() do { } while (0)
> +#endif
> +
>  /**
>   * array_index_mask_nospec() - generate a ~0 mask when index < size, 0 o=
therwise
>   * @index: array element index
>
>
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#11264): https://lists.cip-project.org/g/cip-dev/messa=
ge/11264
> Mute This Topic: https://lists.cip-project.org/mt/98397283/4520416
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129101/452041=
6/1465703922/xyzzy [masami.ichikawa@miraclelinux.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

Regards,
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

