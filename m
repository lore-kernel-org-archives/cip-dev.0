Return-Path: <stephenecker240@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FABC02183
	for <webhook@archiver.kernel.org>; Mon, 13 Jan 2025 15:50:57 +0000 (UTC)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
 by mx.groups.io with SMTP id smtpd.web11.20309.1736783453428871142
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Jan 2025 07:50:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VJV4h57f;
 spf=pass (domain: gmail.com, ip: 209.85.161.52, mailfrom: stephenecker240@gmail.com)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5f2d7868ef0so1052053eaf.3
        for <cip-dev@lists.cip-project.org>; Mon, 13 Jan 2025 07:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736783452; x=1737388252; darn=lists.cip-project.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L61hD9IhGnas5DT3p3IWakGjh7eoZ03SutgMVRyg/jw=;
        b=VJV4h57f59PtZuFH25yI9lD1byP3u6gXXHSjZBB6c9GnvQhz2ht2MM6NHtUQcI+xWp
         y1jcf7RMnAqAEzwW3PCF/UbbEPwAFpvKGXkB3UDr9vrcTL9FYWTlA23VKH/WT4p2w2uu
         0/9YGQJ+9yCbCZeKacmYNwHomUH+HC/WccLnsOqT+IZI6pCD/3cdCyaV1u8L6GEDswQB
         J99mhrcHATC8+xXmtTtw1E0eY+vt/h+bT4kT/qXZrCulWWgXG/1HUncfVaSYqu1lhlco
         wMhmzgEUtL848xMWGUdSzQinubxoK4rmwM4iOdJHv9YvOd0JCczzGlNao/N6ElT8JP50
         gSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736783452; x=1737388252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L61hD9IhGnas5DT3p3IWakGjh7eoZ03SutgMVRyg/jw=;
        b=MWDXcCoWjfuZF5c25/zEJ6oM66ajpE7BnVb/xkoJzGEd8LuQmAl1BL/NVe/skO3UlE
         +ba4IERGeUCwisdUIC+ODTt9Ww6swtA8NQSWWzN9ZAkJpaetRfnxhA3vr9LyaXjwvTrc
         eATitfIW8wTaEvgQB4KjGTgd2zrDrgl0cjjtVZD777REyN5u04W1OlJYrJsCByZlRhzJ
         tIqu/OdEUeCJgkzjpWeYLUrymuZcyGmQGfK7q3JLLm+wj/u+cxmCfaHtj6O1dK19SM07
         YAKKBX90UcasjjZuMfdeYGnrecxH7JD/KrhI5ieE2o1ZsTFG73TeEz08NsfTNBnptLjl
         0s7Q==
X-Gm-Message-State: AOJu0YwHKAGFDjqh7qf2KDrnKUlLN2TCVqEH24zZwMlC8C++EFnZi1qD
	ZTgRmPg8qpeyie23xfOHu5s4+0DSkKcZ+UN91QlfmYUuCwrlGEg3rGq1Q0vsnGDD06zMvuCMOKP
	mCswk4IEZXRQAgDyOELmAHd0y648xKA==
X-Gm-Gg: ASbGncutF9GwzuyOfTrLEQm3XLFq9jdB09lvoqJOqLtnQBqBzaLMM8WXiwTuP2I9cot
	fizBpQaZpScjTtxN6P/WRppElG26suUZdG9xP
X-Google-Smtp-Source: AGHT+IFLZF8KEcNsW9ivwyUkh9JqqJobAhFUKPnFLThAGVPfZ3/1EXtzLgC9+rvTeN+J/NASEmbHq7xY/iQzy9SnxTY=
X-Received: by 2002:a05:6871:5387:b0:29e:20c4:2217 with SMTP id
 586e51a60fabf-2aa06922fbcmr13529268fac.33.1736783452424; Mon, 13 Jan 2025
 07:50:52 -0800 (PST)
MIME-Version: 1.0
References: <20250110165253.77676-1-Quirin.Gylstorff@siemens.com> <Z4UCKwNrHLXO7+V+@duo.ucw.cz>
In-Reply-To: <Z4UCKwNrHLXO7+V+@duo.ucw.cz>
From: Stephen Ecker <stephenecker240@gmail.com>
Date: Mon, 13 Jan 2025 09:50:39 -0600
X-Gm-Features: AbW1kvZihD4ZvcTlxKCc11kcQEwkncnGeco9uFyIUf0O8NBVetkfl_i72D323zg
Message-ID: <CAK9C7GBZ+XRv7Xt8Hyebs9VPnVBmPStjSwc4sQ-jgwz6Ug-0Rg@mail.gmail.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH v3] initramfs-crypt-hook: clarify
 resize error
To: cip-dev@lists.cip-project.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: multipart/alternative; boundary="000000000000bbd0b8062b9868cd"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Jan 2025 15:50:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17535

--000000000000bbd0b8062b9868cd
Content-Type: text/plain; charset="UTF-8"

Since you're in there, it would be great if you allowed a directive that
passed a resize command, so we can support filesystems this doesn't

On Mon, Jan 13, 2025, 6:08 AM Pavel Machek via lists.cip-project.org <pavel=
denx.de@lists.cip-project.org> wrote:

> Hi!
>
> > From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> >
> > Add context to the resizing error as it is was unclear why the
> > encryption can not continue.
>
> or fstype: '$partition_fstype'"
> >               ;;
> >       *)
> > -             panic "cannot resize parition. unsupport fstype:
> $partition_fstype"
> > +             panic "cannot resize partition. unsupport fstype:
> $partition_fstype"
> >               ;;
>
> Should this say "unsupported"?
>
> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17532):
> https://lists.cip-project.org/g/cip-dev/message/17532
> Mute This Topic: https://lists.cip-project.org/mt/110538292/9242556
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe:
> https://lists.cip-project.org/g/cip-dev/leave/13820419/9242556/92422264/xyzzy
> [stephenecker240@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--000000000000bbd0b8062b9868cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Since you&#39;re in there, it would be great if you allow=
ed a directive that passed a resize command, so we can support filesystems =
this doesn&#39;t=C2=A0</div><br><div class=3D"gmail_quote gmail_quote_conta=
iner"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 13, 2025, 6:08 AM P=
avel Machek via <a href=3D"http://lists.cip-project.org">lists.cip-project.=
org</a> &lt;pavel=3D<a href=3D"mailto:denx.de@lists.cip-project.org">denx.d=
e@lists.cip-project.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">Hi!<br>
<br>
&gt; From: Quirin Gylstorff &lt;<a href=3D"mailto:quirin.gylstorff@siemens.=
com" target=3D"_blank" rel=3D"noreferrer">quirin.gylstorff@siemens.com</a>&=
gt;<br>
&gt; <br>
&gt; Add context to the resizing error as it is was unclear why the<br>
&gt; encryption can not continue.<br>
<br>
or fstype: &#39;$partition_fstype&#39;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0panic &quot;cannot re=
size parition. unsupport fstype: $partition_fstype&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0panic &quot;cannot re=
size partition. unsupport fstype: $partition_fstype&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>
<br>
Should this say &quot;unsupported&quot;?<br>
<br>
Best regards,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Pavel<br>
-- <br>
DENX Software Engineering GmbH,=C2=A0 =C2=A0 =C2=A0 =C2=A0 Managing Directo=
r: Erika Unter<br>
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#17532): <a href=3D"https://lists.cip-project.org/g/cip-=
dev/message/17532" rel=3D"noreferrer noreferrer" target=3D"_blank">https://=
lists.cip-project.org/g/cip-dev/message/17532</a><br>
Mute This Topic: <a href=3D"https://lists.cip-project.org/mt/110538292/9242=
556" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.cip-proj=
ect.org/mt/110538292/9242556</a><br>
Group Owner: <a href=3D"mailto:cip-dev%2Bowner@lists.cip-project.org" targe=
t=3D"_blank" rel=3D"noreferrer">cip-dev+owner@lists.cip-project.org</a><br>
Unsubscribe: <a href=3D"https://lists.cip-project.org/g/cip-dev/leave/13820=
419/9242556/92422264/xyzzy" rel=3D"noreferrer noreferrer" target=3D"_blank"=
>https://lists.cip-project.org/g/cip-dev/leave/13820419/9242556/92422264/xy=
zzy</a> [<a href=3D"mailto:stephenecker240@gmail.com" target=3D"_blank" rel=
=3D"noreferrer">stephenecker240@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000bbd0b8062b9868cd--

