Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA0BC433F5
	for <webhook@archiver.kernel.org>; Thu, 25 Nov 2021 14:22:48 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 by mx.groups.io with SMTP id smtpd.web10.12652.1637850165969663373
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Nov 2021 06:22:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=ow6yPjuE;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.170,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f170.google.com with SMTP id s139so12804340oie.13
        for <cip-dev@lists.cip-project.org>;
 Thu, 25 Nov 2021 06:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=++4bVv0WV2D4jcgOgZ7GXlrcwHdndxxSNELLeLwllws=;
        b=ow6yPjuEN8Nkv6AmJ41QLToEe+76Jp+UrIyMY+S0dWWJWVxuWhFYDAW1eRshvDWChl
         ZfNEdB7CFow+Odl15kIyHE3cmm6Pn/fyPJJym+oxh1eVXPhbHRK6E2bmQmVyMn2Vk5H7
         W5nwWn107kYJeFC7fJigCkuHLNC5K/ZAZslFs0hXmLWR4ba8d1npcZzNz2TEUiT3SUZ1
         a1F9LekshvBFMACHMquu8dVEfLXdEFgJm1jjQCTTOqlx5+vnrJ6Ehtf8tJfIl4ZsyR6S
         +uKv9Pgrs4ubwnJ/Sd9CRcxf3lZLrN4KIOODE31yIqq97CKsMsh/Rw4jdYfL6J2lLXJN
         fe1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=++4bVv0WV2D4jcgOgZ7GXlrcwHdndxxSNELLeLwllws=;
        b=vrUCg6W9PYxftB4AiwC2gPnCVa9jIBfj6MJrF2roNnEVbb34Tpm8Q3L0F3dr7ENBDo
         Bbfd7gO2r37FY6NhqUzeUZVtbBYAMXkaphevnx3fkWIMLUp2ckLd0YbFdl7x9QDc/ZZT
         V7AJCToRWYwK7Zl9N4rvpYd/LE/ny+/JzY6zWTWPf3LmgsBqRA8ynPwz+veJosmqp8VA
         ZhLNj8PKoIrFmFA8OmeZ2t1kJN4Wf7ojQDpZp+4AmKIBax/cgpIRsLOk3J0wZe0owSxl
         Q5lN1gd8ZveXezoh2gukFW+SfcS7axEyqM9TxzLYekzCNrqS8EN3+9blMy6vxxbNMtvF
         S81w==
X-Gm-Message-State: AOAM533xe/sFqluUpL+GlYl3kvv4G0qs0n9PsqWKkY3iBTw5BnIk037i
	x3nvtThB8SSxyucu+qbpnpsO6GTylIZYKWiGNWFI4jd0DByX4g==
X-Google-Smtp-Source: 
 ABdhPJzLyT2q8LTyG2fNoSG5bccspVHJj0moqHuX4A/tSf+0M17JkhdzJfYBfDQ4T4CIgXjXBH/a+3vEBMlLzvoOJl4=
X-Received: by 2002:aca:b407:: with SMTP id d7mr15478886oif.116.1637850164770;
 Thu, 25 Nov 2021 06:22:44 -0800 (PST)
MIME-Version: 1.0
References: 
 <CAODzB9qEJUBAGggEaTmc27Lr0opreM8wv5D_HStKT6UH=+a_UA@mail.gmail.com>
 <16BABF37827ACD8B.14741@lists.cip-project.org> <20211125095339.GC3327@amd>
In-Reply-To: <20211125095339.GC3327@amd>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 25 Nov 2021 23:22:08 +0900
Message-ID: 
 <CAODzB9r4uBS5bBKGbZBPST6V7OppONToGqdB8HxhJD8Kh3Nruw@mail.gmail.com>
Subject: Re: CVE-2021-3640: UAF in sco_send_frame function was Re: [cip-dev]
 New CVE entries in this week
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Nov 2021 14:22:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7019

Hi !

On Thu, Nov 25, 2021 at 6:53 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > > CVE-2021-3640: UAF in sco_send_frame function
> > >
> > > 5.10 and 5.15 are fixed this week.
> > >
> > > Fixed status
> > >
> > > mainline: [99c23da0eed4fd20cae8243f2b51e10e66aa0951]
> > > stable/5.10: [4dfba42604f08a505f1a1efc69ec5207ea6243de]
> > > stable/5.14: [2c2b295af72e4e30d17556375e100ae65ac0b896]
> > > stable/5.15: [b990c219c4c9d4993ef65ea9db73d9497e70f697]
> > > stable/5.4: [d416020f1a9cc5f903ae66649b2c56d9ad5256ab]
> >
> > Interesting.
> >
> > commit 99c23da0eed4fd20cae8243f2b51e10e66aa0951
> > Author: Takashi Iwai <tiwai@suse.de>
> >
> > Says:
> >
> >     This should be the last piece for fixing CVE-2021-3640 after a few
> >     already queued fixes.
> >
> > Which means more than 99c23da0eed is needed to fix this one,
> > unfortunately it does not give us good way to identify what commits
> > are needed.
>
> Aha, but we have required information in
> cip-kernel-sec/issues/CVE-2021-3640.yml. It lists patches that should
> be fixing this.
>
> Some searching in the trees reveals that one of those patches is buggy
> itself, and additionaly 49d8a5606428ca0962d09050a5af81461ff90fbb is
> needed.
>
> The patches fixing this are:
>
> ~  stable/5.10: [4dfba42604f08a505f1a1efc69ec5207ea6243de,
>                 f2f856b65ac4b77049c76c0e89ecd3a177e9fcd1,
>                 98d44b7be6f1bcfd4f824c5f8bc2b742f890879f,
>                 c20d8c197454068da758a83e09d93683f520d681,
>                 a1073aad497d0d071a71f61b721966a176d50c08]
>
> But we still miss backport of 27c24fda62b6 ("Bluetooth: switch to
> lock_sock in SCO") to 5.10, which has its own prerequisites
> according to the changelog. AFAICT those prerequisites are
> 734bc5ff783115aa3164f4e9dd5967ae78e0a8ab and
> ba316be1b6a00db7126ed9a39f9bee434a508043, and both are in 5.10.
>
> I'm not sure how to express this in yml cleanly. I came with this:
>
> diff --git a/issues/CVE-2021-3640.yml b/issues/CVE-2021-3640.yml
> index fb52d5a..d386093 100644
> --- a/issues/CVE-2021-3640.yml
> +++ b/issues/CVE-2021-3640.yml
> @@ -23,9 +23,23 @@ comments:
>      there is no fixed information as of 2021/07/26.
>      Fixed in bluetooth-next tree. commit 99c23da0eed4fd20cae8243f2b51e10e66aa0951.
>    ubuntu/sbeattie: Possibly addressed by Desmond Cheong Zhi Xi's patchset.
> +  pavel: We are one patch away from fixing this 5.10, 27c24fda62b6 is needed.
>  fixed-by:
> -  mainline: [99c23da0eed4fd20cae8243f2b51e10e66aa0951]
> -  stable/5.10: [4dfba42604f08a505f1a1efc69ec5207ea6243de]
> +  mainline: [99c23da0eed4fd20cae8243f2b51e10e66aa0951,
> +            e04480920d1eec9c061841399aa6f35b6f987d8b,
> +            734bc5ff783115aa3164f4e9dd5967ae78e0a8ab,
> +            49d8a5606428ca0962d09050a5af81461ff90fbb,
> +            ba316be1b6a00db7126ed9a39f9bee434a508043,
> +            27c24fda62b601d6f9ca5e992502578c4310876f,
> +            734bc5ff783115aa3164f4e9dd5967ae78e0a8ab,
> +            ba316be1b6a00db7126ed9a39f9bee434a508043]
> +  stable/5.10: [4dfba42604f08a505f1a1efc69ec5207ea6243de,
> +               f2f856b65ac4b77049c76c0e89ecd3a177e9fcd1,
> +               98d44b7be6f1bcfd4f824c5f8bc2b742f890879f,
> +               c20d8c197454068da758a83e09d93683f520d681,
> +               a1073aad497d0d071a71f61b721966a176d50c08,
> +               98d44b7be6f1bcfd4f824c5f8bc2b742f890879f,
> +               a1073aad497d0d071a71f61b721966a176d50c08]
>    stable/5.14: [2c2b295af72e4e30d17556375e100ae65ac0b896]
>    stable/5.15: [b990c219c4c9d4993ef65ea9db73d9497e70f697]
>    stable/5.4: [d416020f1a9cc5f903ae66649b2c56d9ad5256ab]
>

Thank you for your analysis result ! I applied it.

I checked 27c24fda62b601d6f9ca5e992502578c4310876f is able to apply
cleanly to stable/5.10 tree or not.  Unfortunately it need to fix
conflicts. git-am shows following two errors.

Applying: Bluetooth: switch to lock_sock in SCO
Checking patch net/bluetooth/sco.c...
error: while searching for:

        BT_DBG("sock %p state %d", sk, sk->sk_state);

        bh_lock_sock(sk);
        sk->sk_err = ETIMEDOUT;
        sk->sk_state_change(sk);
        bh_unlock_sock(sk);

        sco_sock_kill(sk);
        sock_put(sk);

error: patch failed: net/bluetooth/sco.c:93
error: while searching for:

        if (sk) {
                sock_hold(sk);
                bh_lock_sock(sk);
                sco_sock_clear_timer(sk);
                sco_chan_del(sk, err);
                bh_unlock_sock(sk);
                sco_sock_kill(sk);
                sock_put(sk);


error: patch failed: net/bluetooth/sco.c:193


> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#7015): https://lists.cip-project.org/g/cip-dev/message/7015
> Mute This Topic: https://lists.cip-project.org/mt/87299556/4520416
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

