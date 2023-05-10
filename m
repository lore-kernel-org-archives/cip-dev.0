Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1266EC7EE24
	for <webhook@archiver.kernel.org>; Wed, 10 May 2023 07:29:08 +0000 (UTC)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
 by mx.groups.io with SMTP id smtpd.web11.10770.1683703740037597992
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 May 2023 00:29:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=oiCNw+4M;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.169, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3942bcf62f3so147012b6e.2
        for <cip-dev@lists.cip-project.org>; Wed, 10 May 2023 00:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1683703739; x=1686295739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAXvB1fLwzNX30EXauaeVFiMDlO/pX8b9vUhHP/Lrlw=;
        b=oiCNw+4ML9qfHlJmFjnjBWvfQ4E67hUpzMvh4k7ly97uE2pMgbqz+EeTcWmAVMk6W9
         W4nhhlQDI1tifxuujmqiuWEZ0xEreXS89f/Li5udASYj58akKXR4nha9g9vBabpYItbP
         Av1VnFqqvMrW5cAK1C59xJH6kG1WvtMGXERWQ6sVCzo+9u0aANj5gaOuhQlMz9ClokeN
         rHZEPD59rbPHvldWOPjwQgcAlwzFTefkqVnyMfR+YlDV2QtbdbhysqcOyBJBlY2Ob85Q
         hDo/TK67GWYY97WDnqirsh3tmG5P0R49GnRWN5Sl8PYSMQAq4lE56TBUg2R9Ao5P5T7m
         OQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683703739; x=1686295739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAXvB1fLwzNX30EXauaeVFiMDlO/pX8b9vUhHP/Lrlw=;
        b=BM73UevraW9slNekEP9p1T/XDoXsCv4NZIPECAhXOECbkOfDU+YwFnu1fWxfAkMHuY
         +x/zMWk1MrlnWEcZtXq1+6CKZKl4yNe5UCGDWzAkVnvlANfWQLoZk4B6OdglbwxFlvfD
         uuSIsVWCAjHEIQVyF7YHUJyFyfD4ak+6x0Tc131s/CMYtWkCi+SoslmZmunKZ1Bs/cDu
         aqotC4UAy2KZMzVajUlB01czJl89MrUZHD2TakwJ9vUO/9J69ZqvaHBWBAyQpdrAqHsW
         ZwY+yRx/nDbY0T6cfnlP/A+nX3yyh6UYit0aWtnW3+e9k3RBk3ogZa+hn5SMRo0Kkxc0
         M13Q==
X-Gm-Message-State: AC+VfDzMuYaxW8zCTSVPIqQ9C59Zqm/1vYdiqvbzF4mDprKJa3uyerOs
	zXLRMjClMxR0bXomesmLrXpjNSjc984BaGftjT2rTg==
X-Google-Smtp-Source: ACHHUZ4Q0+Wb3zO/jcGYTc/eCRIGlqU4aZ+Aalaj+RGA8ScLnzB89Td52CjNiPZqXlOa9+LtTCyV/WCIgDb6nu8uenU=
X-Received: by 2002:a05:6808:2882:b0:378:2b0c:493f with SMTP id
 eu2-20020a056808288200b003782b0c493fmr3023719oib.19.1683703739302; Wed, 10
 May 2023 00:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAODzB9oaJ73uvgppYvcOBbM2xLNB1LQW34TZbjA3gd+bkAKaVg@mail.gmail.com>
 <63fb0d57-3550-1188-8243-7ea8c8b5ab5b@siemens.com> <TY2PR01MB37880583E930BBEC98A5803EB7769@TY2PR01MB3788.jpnprd01.prod.outlook.com>
 <CAODzB9rdcjQKhj9a0a6igrjHCbMwo0Qy=xenxmTXFryMkOhVUw@mail.gmail.com> <TY2PR01MB3788F4587077708C078522C1B7779@TY2PR01MB3788.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB3788F4587077708C078522C1B7779@TY2PR01MB3788.jpnprd01.prod.outlook.com>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Wed, 10 May 2023 16:28:23 +0900
Message-ID: <CAODzB9ptRRYqbuwVwf44z8tahcZ06Vjjz68BBACYpgYGQcp=pg@mail.gmail.com>
Subject: Re: Size limit in the cip-kernel-sec repository?
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev <cip-dev@lists.cip-project.org>, 
	Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	Ulrich Hecht <uli@fpond.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 May 2023 07:29:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11431

Hi.

On Wed, May 10, 2023 at 3:58=E2=80=AFPM Chris Paterson
<Chris.Paterson2@renesas.com> wrote:
>
> Hello,
>
> > From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
> > Sent: Wednesday, May 10, 2023 12:12 AM
>
> [...]
>
> > >
> >
> > The warning message disappeared today (Tue 09 May 2023 11:09:07 PM
> > UTC).
> >
> > Enumerating objects: 12, done.
> > Counting objects: 100% (12/12), done.
> > Delta compression using up to 4 threads
> > Compressing objects: 100% (8/8), done.
> > Writing objects: 100% (8/8), 1.02 KiB | 1.02 MiB/s, done.
> > Total 8 (delta 6), reused 0 (delta 0)
> > To gitlab.com:cip-project/cip-kernel/cip-kernel-sec.git
> >    92d679f5..ef1cf1be  master -> master
>
> Huzzah.
> FYI I went through and removed all the tags and branches we don't care ab=
out in our linux-stable-rc mirror, and set the mirror to only pull branches=
 we care about.
> So the repo is now only 4.1GB :)
>

Thank you for reducing the repository size.

> In the meantime GitLab got back to me and basically said there is no way =
to increase the storage quotas, unless CIP wants to pay.
>
> Kind regards, Chris

Regards,
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

