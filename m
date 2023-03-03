Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58713C64EC4
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 16:39:37 +0000 (UTC)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
 by mx.groups.io with SMTP id smtpd.web10.27346.1677859802664499938
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Mar 2023 08:10:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=ML28dBIV;
 spf=pass (domain: gmail.com, ip: 209.85.217.49, mailfrom: rogerheflin@gmail.com)
Received: by mail-vs1-f49.google.com with SMTP id a3so2877797vsi.0
        for <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 08:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677859801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbMp3DLztwglwPUt7HBJ0cjsz/tRxK7DzxpYTAHxTog=;
        b=ML28dBIVhIA+sQYhd7Ehdi/7U3cqkApmAI5j55/z0qQLa4iBLtB4Hbq7BUgrvtgpgC
         7dQe9+OsP1ycEo32weVZmNEDylAn5H3JShAGOlmFlT8HYEj9sh6kxp7cFK+CKYJ52pD9
         8wPJ0nDVK2iY6QtBVOiKmA8egpAk2K6qj78SSz3dLrMuaBeAe/9RUXw8ExZmP1VyDEle
         beP9qOf1QarYvlEvd8/+QapZcS9Y57NZoq3GytItD1p3FCOanu2JoTdb+tfqhswl0Y+L
         JABWh127WijAIZRDMvg7k3kufvj34BQwWRB2c2z38e9a+UjXQ1ludMMjt11NzcDNAd6T
         Ijzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677859801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbMp3DLztwglwPUt7HBJ0cjsz/tRxK7DzxpYTAHxTog=;
        b=zAD0hPHmNrTMsOhk5n2u4qdTNE/ftgbg/OdIyFs/FDPINgc6xAfYllHupZUfxYGFBp
         C8JvyPRx6tJhhKjV56pXQd3nXj8YMaVD/X6CjupEd1nVlAw5d4OP3QdZUCm1e9y7APoy
         UOyz0vG80bTs+J9e//m67vFFA24AFAFIfDg25KzBqKRi99g+jk4lAIXH+wuhDUTttUvs
         qGGT38ItljvhHY8StBVLg/3ucxv1KdKguFuy61e8XMlIzxclxq6sRgMLXJo6mwOtK/jP
         umAH8MHGtLffysPu+Yx2txZQOjIRvZFqJdRcPAJq/RoHdpEpfx0ZAsrELooLCEcFybex
         hIPA==
X-Gm-Message-State: AO0yUKUTYOO6eeboYkMztJLds6gQPH7Xkn2IyUtUMi58eV2eyEA1wquh
	05cTS3i2MHcFjgdOEHCOMEh747c5SYfmflajabA=
X-Google-Smtp-Source: AK7set/1VwKLUlBky/Xz3u03Fq/tfM1z2EQ9+cmAIzD/zrnvIPqvhN8xJSU/dqKxLimr8CajcPXD4j4xRewi2fyte24=
X-Received: by 2002:a05:6102:21ae:b0:412:364c:68be with SMTP id
 i14-20020a05610221ae00b00412364c68bemr1482986vsb.7.1677859801578; Fri, 03 Mar
 2023 08:10:01 -0800 (PST)
MIME-Version: 1.0
References: <e664f254-90a0-42df-8fc8-ad808f6dedeb@kili.mountain>
In-Reply-To: <e664f254-90a0-42df-8fc8-ad808f6dedeb@kili.mountain>
From: Roger Heflin <rogerheflin@gmail.com>
Date: Fri, 3 Mar 2023 10:09:50 -0600
Message-ID: <CAAMCDedsGtWcwe4KY9SgdciXoHYeM+YO4U7v-QCRnL5PqQTs9A@mail.gmail.com>
Subject: Re: [bug report] md: range check slot number when manually adding a spare.
To: Dan Carpenter <error27@gmail.com>
Cc: neilb@suse.de, linux-raid@vger.kernel.org, 
	cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 16:39:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10920

On Fri, Mar 3, 2023 at 8:31=E2=80=AFAM Dan Carpenter <error27@gmail.com> wr=
ote:
>
> [ Ancient code, but you're still at the same email address...  -dan ]
>
> Hello NeilBrown,
>
> The patch ba1b41b6b4e3: "md: range check slot number when manually
> adding a spare." from Jan 14, 2011, leads to the following Smatch
> static checker warning:
>
> drivers/md/md.c:3170 slot_store() warn: no lower bound on 'slot'
> drivers/md/md.c:3172 slot_store() warn: no lower bound on 'slot'
> drivers/md/md.c:3190 slot_store() warn: no lower bound on 'slot'
>
> drivers/md/md.c
>     3117 static ssize_t
>     3118 slot_store(struct md_rdev *rdev, const char *buf, size_t len)
>     3119 {
>     3120         int slot;
>     3121         int err;
>     3122
>     3123         if (test_bit(Journal, &rdev->flags))
>     3124                 return -EBUSY;
>     3125         if (strncmp(buf, "none", 4)=3D=3D0)
>     3126                 slot =3D -1;
>     3127         else {
>     3128                 err =3D kstrtouint(buf, 10, (unsigned int *)&slo=
t);
>
> slot comes from the user.
>
>     3129                 if (err < 0)
>     3130                         return err;
>     3131         }

kstrtouint is string to unsigned int, it has this code:

if (tmp !=3D (unsigned int)tmp)
return -ERANGE;

And so will not return a negative number without an error, so 0 is the
lower limit as enforced by the function.

