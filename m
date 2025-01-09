Return-Path: <stephenecker240@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B095E77197
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 16:39:06 +0000 (UTC)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
 by mx.groups.io with SMTP id smtpd.web10.1252.1736440736655860009
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Jan 2025 08:38:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Kt5OG2Xm;
 spf=pass (domain: gmail.com, ip: 209.85.210.52, mailfrom: stephenecker240@gmail.com)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71e2aa8d5e3so539339a34.2
        for <cip-dev@lists.cip-project.org>; Thu, 09 Jan 2025 08:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736440736; x=1737045536; darn=lists.cip-project.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MPEv4wcMUO8Ozsq12pINnBwQSXQz/mlQmu1cIqvbQ7c=;
        b=Kt5OG2XmvKtHRJZYyBerHyAoIBXafHgESKjIDVkUFnELzh1USyqXuv42WJkznMg/Rk
         HFPYlM8PcapQ7N7J3Cp9OeWDaztk7qX3hrwvdAKvbybIDWK+ajvUs1Vc5cfOUUi83MWi
         loycSxeP6lJgh4eSU+P3dLfjSYj7lPupFXHkGLoe+d1VPpkjWj9cVPiEGKxuq/XtHXaZ
         5UbBR5qsJ0+RQhpd+0c050TexulBdS9d/SELlQefK1L0CzrNbYSNvQOl7g/yecUwmKaB
         m9T7xSlFRrexScQrfO5PJ6T+JXXI0uxN5wogZqplD4lzP4+a5FnyMMuTx799LLDsJGK0
         3efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736440736; x=1737045536;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPEv4wcMUO8Ozsq12pINnBwQSXQz/mlQmu1cIqvbQ7c=;
        b=f9vXRgYfMR0Sm0oQ5J32lL4FOKyqhHhL+ymokiLbGwroYdNipZa9PfbFgf+IX//9cl
         Bio33qiIOVA3nOiLOn2CZC0SZgLHoM15kiUetC9a1mJ0t06KH3RBGpatCzElUnhV7xQG
         g4fHRWm1DkaE9EuBnKX3LCi2Rzz6yhhFm9gSJLIu0K8J97xL+gfwYr1HpIXmMWamIQf6
         AxOjfRr+QyIQXsNDfxciKvW59mnaRn4C7WxFU3YJGTy/ij6Ot+KNdPb/4EvTPKiv1anG
         +AgDOiYq+PU2RJPlRaf+f7PR3nhlPw3G/aFFay+JFnmC90s6f7dSJxee2nBO+0BkUWEZ
         394A==
X-Gm-Message-State: AOJu0Yy6CYeoUz6bgnAJ02sv1daepchUNk0fAGpBpAmcpvdGxqs4A4Ca
	E6HYOLwWcpwP057qv+tDffJOt+8sBhyvC22wku8gHF+qPJ4bn11oGT/R9RO6gE5QtDfZ9IT8y7X
	n0hAbgwBbA954kKQZtwZEnvGxCaE=
X-Gm-Gg: ASbGnctjlEJbNqdn6Bi7MO8bn7pGwxF8cDVp6vzc/St+bcfCBNVe5VqIbRwQEy/63O6
	mafuIFG8T94bNSsiqsg40EOD77g9XGnUy1BWS
X-Google-Smtp-Source: AGHT+IFXIrXjB+yMkRXoJGdP4iyou5W3etF1lCV/TtupdcmuuJb4uMXwpQjGbr3MI5kcjFk6VTM79cBb7iKYbGHk0cg=
X-Received: by 2002:a05:6871:a110:b0:29e:7067:4eac with SMTP id
 586e51a60fabf-2aa067199b7mr4145499fac.23.1736440735776; Thu, 09 Jan 2025
 08:38:55 -0800 (PST)
MIME-Version: 1.0
References: <CAK9C7GBuqQsWQahLo1pkpmSRGUr-Xi9ncPF6=ZNgkWOBZBaKNQ@mail.gmail.com>
 <52d71d4f-784d-4f8e-8d66-18fe2a912503@siemens.com> <CAK9C7GCBMs8awjxzw5iCy0xUbu+1LJmnSBSv9YR7YA5mKHVUJg@mail.gmail.com>
 <fe44dc91-7eae-4dde-8efd-de636eadf9be@siemens.com> <CAK9C7GDt9qvnRzy+hmHSfwTK7tHg6Zqirs3e6JYzz_XQGvTchA@mail.gmail.com>
 <7045885a-2ceb-4df8-997e-8f2b66ecaee2@siemens.com>
In-Reply-To: <7045885a-2ceb-4df8-997e-8f2b66ecaee2@siemens.com>
From: Stephen Ecker <stephenecker240@gmail.com>
Date: Thu, 9 Jan 2025 10:38:43 -0600
X-Gm-Features: AbW1kvZqhU5GP0dDHRujjnak-s4iaN4_9aUO6r6KIL9JoooogWh1KhTv2HXfTm0
Message-ID: <CAK9C7GC1=s4ucNxscsCoBAo50=Qe9Ry=H-26fTPrmam2+dZuTQ@mail.gmail.com>
Subject: Re: btrfs support in initramfs-crypt-hook
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org
Content-Type: multipart/alternative; boundary="0000000000003ac75c062b489ddd"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Jan 2025 16:39:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17520

--0000000000003ac75c062b489ddd
Content-Type: text/plain; charset="UTF-8"

In this context, I was referring to the encrypt script from the
initramfs-crypt-hook... It is hard coded to support only the ext filesystem
(I suspected because it's the only one that it can resize)... but anyway, I
will submit a patch to continue this discussion.
Thanks

On Thu, Jan 9, 2025, 10:33 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 09.01.25 16:41, Stephen Ecker wrote:
> > I'm thinking the best way to make the crypt hook more modular would be
> > to break out the support with recipes that add binaries to the initramfs
> > for mkfs.${fstype} and resizefs.${fstype}
> >
>
> I suspect we are not yet on the same page. Anyway, please propose your
> changes in form of patches, then we can continue the discussion in a
> more concrete context.
>
> Jan
>
> > On Thu, Jan 9, 2025, 9:39 AM Jan Kiszka <jan.kiszka@siemens.com
> > <mailto:jan.kiszka@siemens.com>> wrote:
> >
> >     On 09.01.25 16:32, Stephen Ecker wrote:
> >     > Because the upstream version requires a bunch of libs that would
> >     have to
> >     > be added to the initramfs. I compiled the binaries static... The
> e2fs
> >     > binaries added were from a static package... There was no static
> >     > equivalent for btrfs.
> >
> >     We do maintain a few custom recipes for packages, primarily to handle
> >     backports of patches that won't hit Debian (very-old-)stable anymore.
> >     This one would be more of a feature recipe, and we would have to
> look at
> >     that carefully because of extra maintenance efforts.
> >
> >     Please split up your patch queue, adding this as optimization on top
> >     (unless that is already the case) while starting with regular
> >     btrfs-progs. And please open a bug with btrfs-progs in Debian to
> trigger
> >     a discussion there as well. If this optimization is important, it
> should
> >     become an upstream feature eventually.
> >
> >     Jan
> >
> >     >
> >     > On Thu, Jan 9, 2025, 9:27 AM Jan Kiszka <jan.kiszka@siemens.com
> >     <mailto:jan.kiszka@siemens.com>
> >     > <mailto:jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>>>
> >     wrote:
> >     >
> >     >     On 09.01.25 13:37, Stephen Ecker wrote:
> >     >     > Is the reason for lack of support here due to not having a
> >     package for
> >     >     > btrfs-progs-static, or was there some other reason?
> >     >     >
> >     >     > I made my own recipe for building the btrfs-progs-static
> >     package.
> >     >     Would
> >     >     > this be worth submitting a PR to add this support?
> >     >     >
> >     >
> >     >     Primarily lack of use case so far - there are some operational
> >     >     challenges with btrfs for embedded and offline image building.
> >     >
> >     >     But adding btrfs support is imaginable. It would "just"
> >     require at least
> >     >     some test coverage in-tree.
> >     >
> >     >     BTW, why an own btrfs packages, why not picking from upstream
> >     >     btrfs-progs? That will need a strong reasoning.
> >     >
> >     >     Jan
> >     >
> >     >     --
> >     >     Siemens AG, Foundational Technologies
> >     >     Linux Expert Center
> >     >
> >
> >
> >     --
> >     Siemens AG, Foundational Technologies
> >     Linux Expert Center
> >
>
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
>

--0000000000003ac75c062b489ddd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">In this context, I was referring to the encrypt script fr=
om the initramfs-crypt-hook... It is hard coded to support only the ext fil=
esystem (I suspected because it&#39;s the only one that it can resize)... b=
ut anyway, I will submit a patch to continue this discussion.<div dir=3D"au=
to">Thanks</div></div><br><div class=3D"gmail_quote gmail_quote_container">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 9, 2025, 10:33 AM Jan Kis=
zka &lt;<a href=3D"mailto:jan.kiszka@siemens.com">jan.kiszka@siemens.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 09.01.25 16:41, Ste=
phen Ecker wrote:<br>
&gt; I&#39;m thinking the best way to make the crypt hook more modular woul=
d be<br>
&gt; to break out the support with recipes that add binaries to the initram=
fs<br>
&gt; for mkfs.${fstype} and resizefs.${fstype}<br>
&gt; <br>
<br>
I suspect we are not yet on the same page. Anyway, please propose your<br>
changes in form of patches, then we can continue the discussion in a<br>
more concrete context.<br>
<br>
Jan<br>
<br>
&gt; On Thu, Jan 9, 2025, 9:39 AM Jan Kiszka &lt;<a href=3D"mailto:jan.kisz=
ka@siemens.com" target=3D"_blank" rel=3D"noreferrer">jan.kiszka@siemens.com=
</a><br>
&gt; &lt;mailto:<a href=3D"mailto:jan.kiszka@siemens.com" target=3D"_blank"=
 rel=3D"noreferrer">jan.kiszka@siemens.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 09.01.25 16:32, Stephen Ecker wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Because the upstream version requires a bunch =
of libs that would<br>
&gt;=C2=A0 =C2=A0 =C2=A0have to<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; be added to the initramfs. I compiled the bina=
ries static... The e2fs<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; binaries added were from a static package... T=
here was no static<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; equivalent for btrfs.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0We do maintain a few custom recipes for packages, p=
rimarily to handle<br>
&gt;=C2=A0 =C2=A0 =C2=A0backports of patches that won&#39;t hit Debian (ver=
y-old-)stable anymore.<br>
&gt;=C2=A0 =C2=A0 =C2=A0This one would be more of a feature recipe, and we =
would have to look at<br>
&gt;=C2=A0 =C2=A0 =C2=A0that carefully because of extra maintenance efforts=
.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Please split up your patch queue, adding this as op=
timization on top<br>
&gt;=C2=A0 =C2=A0 =C2=A0(unless that is already the case) while starting wi=
th regular<br>
&gt;=C2=A0 =C2=A0 =C2=A0btrfs-progs. And please open a bug with btrfs-progs=
 in Debian to trigger<br>
&gt;=C2=A0 =C2=A0 =C2=A0a discussion there as well. If this optimization is=
 important, it should<br>
&gt;=C2=A0 =C2=A0 =C2=A0become an upstream feature eventually.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Jan<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; On Thu, Jan 9, 2025, 9:27 AM Jan Kiszka &lt;<a=
 href=3D"mailto:jan.kiszka@siemens.com" target=3D"_blank" rel=3D"noreferrer=
">jan.kiszka@siemens.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:jan.kiszka@siemens.com=
" target=3D"_blank" rel=3D"noreferrer">jan.kiszka@siemens.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &lt;mailto:<a href=3D"mailto:jan.kiszka@siemen=
s.com" target=3D"_blank" rel=3D"noreferrer">jan.kiszka@siemens.com</a> &lt;=
mailto:<a href=3D"mailto:jan.kiszka@siemens.com" target=3D"_blank" rel=3D"n=
oreferrer">jan.kiszka@siemens.com</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0On 09.01.25 13:37, Stephen =
Ecker wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; Is the reason for lack=
 of support here due to not having a<br>
&gt;=C2=A0 =C2=A0 =C2=A0package for<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; btrfs-progs-static, or=
 was there some other reason?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; I made my own recipe f=
or building the btrfs-progs-static<br>
&gt;=C2=A0 =C2=A0 =C2=A0package.=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Would<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; this be worth submitti=
ng a PR to add this support?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Primarily lack of use case =
so far - there are some operational<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0challenges with btrfs for e=
mbedded and offline image building.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0But adding btrfs support is=
 imaginable. It would &quot;just&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0require at least<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0some test coverage in-tree.=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0BTW, why an own btrfs packa=
ges, why not picking from upstream<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0btrfs-progs? That will need=
 a strong reasoning.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Jan<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Siemens AG, Foundational Te=
chnologies<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Linux Expert Center<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A0Siemens AG, Foundational Technologies<br>
&gt;=C2=A0 =C2=A0 =C2=A0Linux Expert Center<br>
&gt; <br>
<br>
<br>
-- <br>
Siemens AG, Foundational Technologies<br>
Linux Expert Center<br>
</blockquote></div>

--0000000000003ac75c062b489ddd--

