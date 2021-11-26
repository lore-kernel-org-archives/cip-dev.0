Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E55FC433F5
	for <webhook@archiver.kernel.org>; Fri, 26 Nov 2021 13:39:59 +0000 (UTC)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by mx.groups.io with SMTP id smtpd.web12.23965.1637933996197690741
 for <cip-dev@lists.cip-project.org>;
 Fri, 26 Nov 2021 05:39:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=eYLre6K4;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.47,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f47.google.com with SMTP id
 n104-20020a9d2071000000b005799790cf0bso14025885ota.5
        for <cip-dev@lists.cip-project.org>;
 Fri, 26 Nov 2021 05:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=crKCpYKeJSywnbzAUsjQPKjsqVsS89x+MJxHZ/RkpYY=;
        b=eYLre6K4VeA0WK9r0GDYYMuUGb7/dzwg4d96JsVBukiY6+KGV/7YV4pPslLlVZsEPT
         SLhMX9pXfaxtPkznORvXVQ5rxyQpO9x14r/brQgLN5+Ur5Ch03S8qrpfYgBLweXmXSIm
         d96raszCYuMwdBM1FKpQc043+LTlfUkyBwtNEThBCIt0wsvYLdVbtVSgFVK2EqoEGQ7d
         bPlPfWa5XZ5McLnuVBTTdMHDkZ39RwPYEOsZTVh7ZGa9UzOrRqth/GBubCRVkJZwguX5
         v3vXt8lOUS308NEyJF1UP3AUs9NFKA6Z+ypDjdz0WzJnGM2jC5e32XtaM/oNODaCJcUa
         qPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=crKCpYKeJSywnbzAUsjQPKjsqVsS89x+MJxHZ/RkpYY=;
        b=B0KIq76JmifX7nu2S0Q/6YLHBG5G8VMTZvL5Wr/ey2Ne+kcyPZ6C3nxOq2lvVQcHNh
         r1qymi8HGkRs/BEsqFx3yA17UTePJAlrW+mMsPycV9bchzZ9A+R8E76HD5ViXnPMKwKz
         Dx/WSc3hKXfZn2WmWe4Z+jlRNkdWjXNuLpn6kuzOopQmAJNe5t9uYcbW01s6b+1O7pBq
         VDWXx+SwFpCp+c4Cj8iVE5IOt7wH3ASOH1HXfz83wvzLt9Gxib/6Gr2R6NXlUvbc8JnY
         bSWdB6oK94nkdnmuocGc5Yuiv2XnqZVffW10RarnZ1B1SvqyB9SFL96Fme+Ofp7abH1q
         ya2Q==
X-Gm-Message-State: AOAM530N5wZSAlJCZJLZOCxIHI5y9LOpZGpFfs/JGfm1sIeSOJUmzL8h
	zCrRVImw/Jq2PESgKOzlbJ0rPRvAWAT+G8DozN2fZ0TS1kk8oQ==
X-Google-Smtp-Source: 
 ABdhPJzMwsOaTX4+Y9U4qTdBucYg/La3TUeIjbTkav/JfZA3t+ouJuyw2U8ipOisvcEWnyrCPNImQj2/FG+IWfKcfWM=
X-Received: by 2002:a9d:5ccc:: with SMTP id r12mr28294541oti.67.1637933995055;
 Fri, 26 Nov 2021 05:39:55 -0800 (PST)
MIME-Version: 1.0
References: 
 <CAODzB9qEJUBAGggEaTmc27Lr0opreM8wv5D_HStKT6UH=+a_UA@mail.gmail.com>
 <16BABF37827ACD8B.14741@lists.cip-project.org> <20211125095339.GC3327@amd>
 <CAODzB9r4uBS5bBKGbZBPST6V7OppONToGqdB8HxhJD8Kh3Nruw@mail.gmail.com>
 <20211126100255.GA13434@duo.ucw.cz>
In-Reply-To: <20211126100255.GA13434@duo.ucw.cz>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Fri, 26 Nov 2021 22:39:19 +0900
Message-ID: 
 <CAODzB9otUzAUQUSfFNfT4cR95JdXz2fmCiG+0d_J_c=hvKpQbg@mail.gmail.com>
Subject: Re: CVE-2021-3640: UAF in sco_send_frame function was Re: [cip-dev]
 New CVE entries in this week
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 Nov 2021 13:39:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7022

Hi !

On Fri, Nov 26, 2021 at 7:03 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
> > > > Interesting.
> > > >
> > > > commit 99c23da0eed4fd20cae8243f2b51e10e66aa0951
> > > > Author: Takashi Iwai <tiwai@suse.de>
> > > >
> > > > Says:
> > > >
> > > >     This should be the last piece for fixing CVE-2021-3640 after a few
> > > >     already queued fixes.
> > > >
> > > > Which means more than 99c23da0eed is needed to fix this one,
> > > > unfortunately it does not give us good way to identify what commits
> > > > are needed.
> > >
> > > Aha, but we have required information in
> > > cip-kernel-sec/issues/CVE-2021-3640.yml. It lists patches that should
> > > be fixing this.
> > >
> > > Some searching in the trees reveals that one of those patches is buggy
> > > itself, and additionaly 49d8a5606428ca0962d09050a5af81461ff90fbb is
> > > needed.
> > >
> > > The patches fixing this are:
> > >
> > > ~  stable/5.10: [4dfba42604f08a505f1a1efc69ec5207ea6243de,
> > >                 f2f856b65ac4b77049c76c0e89ecd3a177e9fcd1,
> > >                 98d44b7be6f1bcfd4f824c5f8bc2b742f890879f,
> > >                 c20d8c197454068da758a83e09d93683f520d681,
> > >                 a1073aad497d0d071a71f61b721966a176d50c08]
> > >
> > > But we still miss backport of 27c24fda62b6 ("Bluetooth: switch to
> > > lock_sock in SCO") to 5.10, which has its own prerequisites
> > > according to the changelog. AFAICT those prerequisites are
> > > 734bc5ff783115aa3164f4e9dd5967ae78e0a8ab and
> > > ba316be1b6a00db7126ed9a39f9bee434a508043, and both are in 5.10.
> > >
> > > I'm not sure how to express this in yml cleanly. I came with this:
> > >
> > > diff --git a/issues/CVE-2021-3640.yml b/issues/CVE-2021-3640.yml
> > > index fb52d5a..d386093 100644
> > > --- a/issues/CVE-2021-3640.yml
> > > +++ b/issues/CVE-2021-3640.yml
> > > @@ -23,9 +23,23 @@ comments:
> > >      there is no fixed information as of 2021/07/26.
> > >      Fixed in bluetooth-next tree. commit 99c23da0eed4fd20cae8243f2b51e10e66aa0951.
> > >    ubuntu/sbeattie: Possibly addressed by Desmond Cheong Zhi Xi's patchset.
> > > +  pavel: We are one patch away from fixing this 5.10, 27c24fda62b6 is needed.
> > >  fixed-by:
> > > -  mainline: [99c23da0eed4fd20cae8243f2b51e10e66aa0951]
> > > -  stable/5.10: [4dfba42604f08a505f1a1efc69ec5207ea6243de]
> > > +  mainline: [99c23da0eed4fd20cae8243f2b51e10e66aa0951,
> > > +            e04480920d1eec9c061841399aa6f35b6f987d8b,
> > > +            734bc5ff783115aa3164f4e9dd5967ae78e0a8ab,
> > > +            49d8a5606428ca0962d09050a5af81461ff90fbb,
> > > +            ba316be1b6a00db7126ed9a39f9bee434a508043,
> > > +            27c24fda62b601d6f9ca5e992502578c4310876f,
> > > +            734bc5ff783115aa3164f4e9dd5967ae78e0a8ab,
> > > +            ba316be1b6a00db7126ed9a39f9bee434a508043]
> > > +  stable/5.10: [4dfba42604f08a505f1a1efc69ec5207ea6243de,
> > > +               f2f856b65ac4b77049c76c0e89ecd3a177e9fcd1,
> > > +               98d44b7be6f1bcfd4f824c5f8bc2b742f890879f,
> > > +               c20d8c197454068da758a83e09d93683f520d681,
> > > +               a1073aad497d0d071a71f61b721966a176d50c08,
> > > +               98d44b7be6f1bcfd4f824c5f8bc2b742f890879f,
> > > +               a1073aad497d0d071a71f61b721966a176d50c08]
> > >    stable/5.14: [2c2b295af72e4e30d17556375e100ae65ac0b896]
> > >    stable/5.15: [b990c219c4c9d4993ef65ea9db73d9497e70f697]
> > >    stable/5.4: [d416020f1a9cc5f903ae66649b2c56d9ad5256ab]
> > >
> >
> > Thank you for your analysis result ! I applied it.
> >
> > I checked 27c24fda62b601d6f9ca5e992502578c4310876f is able to apply
> > cleanly to stable/5.10 tree or not.  Unfortunately it need to fix
> > conflicts. git-am shows following two errors.
>
> As far as I can tell, logic is quite simple there and the patch would
> look like this. Whether the final result works and closes the security
> hole is different question.
>

Thank you for the patch !
Yes, applying code and works properly is different question. however,
your patch is LGTM.

> Best regards,
>                                                                 Pavel
> commit e077740ddfa22385d53700898ea325068ca4cc6b
> Author: Pavel Machek <pavel@ucw.cz>
> Date:   Thu Nov 25 14:14:04 2021 +0100
>
>     Cherry pick 27c24fda62b6 ("Bluetooth: switch to lock_sock in SCO") to
>     close CVE-2021-3640.
>
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 2f2b8ddc4dd5..cf165b0d15f2 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -93,10 +93,10 @@ static void sco_sock_timeout(struct work_struct *work)
>
>         BT_DBG("sock %p state %d", sk, sk->sk_state);
>
> -       bh_lock_sock(sk);
> +       lock_sock(sk);
>         sk->sk_err = ETIMEDOUT;
>         sk->sk_state_change(sk);
> -       bh_unlock_sock(sk);
> +       release_sock(sk);
>
>         sock_put(sk);
>  }
> @@ -193,10 +193,10 @@ static void sco_conn_del(struct hci_conn *hcon, int err)
>
>         if (sk) {
>                 sock_hold(sk);
> -               bh_lock_sock(sk);
> +               lock_sock(sk);
>                 sco_sock_clear_timer(sk);
>                 sco_chan_del(sk, err);
> -               bh_unlock_sock(sk);
> +               release_sock(sk);
>                 sock_put(sk);
>         }
>
> @@ -1108,10 +1108,10 @@ static void sco_conn_ready(struct sco_conn *conn)
>
>         if (sk) {
>                 sco_sock_clear_timer(sk);
> -               bh_lock_sock(sk);
> +               lock_sock(sk);
>                 sk->sk_state = BT_CONNECTED;
>                 sk->sk_state_change(sk);
> -               bh_unlock_sock(sk);
> +               release_sock(sk);
>         } else {
>                 sco_conn_lock(conn);
>
> @@ -1126,12 +1126,12 @@ static void sco_conn_ready(struct sco_conn *conn)
>                         return;
>                 }
>
> -               bh_lock_sock(parent);
> +               lock_sock(parent);
>
>                 sk = sco_sock_alloc(sock_net(parent), NULL,
>                                     BTPROTO_SCO, GFP_ATOMIC, 0);
>                 if (!sk) {
> -                       bh_unlock_sock(parent);
> +                       release_sock(parent);
>                         sco_conn_unlock(conn);
>                         return;
>                 }
> @@ -1152,7 +1152,7 @@ static void sco_conn_ready(struct sco_conn *conn)
>                 /* Wake up parent */
>                 parent->sk_data_ready(parent);
>
> -               bh_unlock_sock(parent);
> +               release_sock(parent);
>
>                 sco_conn_unlock(conn);
>         }
>
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#7021): https://lists.cip-project.org/g/cip-dev/message/7021
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

