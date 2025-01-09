Return-Path: <stephenecker240@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999A3E77197
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 15:41:49 +0000 (UTC)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
 by mx.groups.io with SMTP id smtpd.web11.51693.1736437306465399343
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Jan 2025 07:41:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gRfkilTY;
 spf=pass (domain: gmail.com, ip: 209.85.160.49, mailfrom: stephenecker240@gmail.com)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2a88c7fabdeso475988fac.1
        for <cip-dev@lists.cip-project.org>; Thu, 09 Jan 2025 07:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736437306; x=1737042106; darn=lists.cip-project.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=47onfKmX3egVaP4wfTjqv/5CN7+JS3kcg/1ZKf3SUuk=;
        b=gRfkilTYwgenXC4beweD0L31d2omGRD3bk+uDv4Qx5hiSstyt+mW2I81GBvNuQ9zFZ
         vU0bcMETXnoa0SvbDz3xWRxK2D/HUE5b+cwQjar+SLMNocbj/6q70X/LwAwu0zsQNZIO
         EFcFtEAXJz2Gh0uGZzBY0onGQHqOCg/2JisRoU+bBS3llyRUuNmdsvT9C/rLyqmfwr64
         ml1pXuHUWRUNs5kqYP4amxcxQgj7eJ1MXXdjwZvuHFAtbkfUeKDAvivTxCgAxKSCGc8H
         QTsLpmo9pbrp3ZO8dIAymxKTDdIz0LxBlEoCnPhfEyF4r89Q3UjW7ODgen6uAh8gj+GE
         RQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736437306; x=1737042106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47onfKmX3egVaP4wfTjqv/5CN7+JS3kcg/1ZKf3SUuk=;
        b=sTa9IwKvFM+j2XDFTB+EgQ/Z9TskZP90sex5MYf61WczMZ0AXHWHBSkT2CGVxFcOLH
         3id6m8O/EIpI3SuUZXa5ka6fLkV77QPuJx0APOgPNdwoKSZe/wIo71gvHmVQgTQEcl8o
         39+IsQtIh0jKlo5+SdXyoWax7SqmjEkFCaosNp+f3plfDS0AbZE8j6Id4XTCFkAQ2E6Q
         2iVG25DzxR1Y7eGQub71U+1S1KxWIaqUawblSZsnZpPuwuyifgqW7pCj6pVia52Dq0Ea
         dnyQ6/uwV4flfoyqGk3hkAxSnCPMCZw6curhnbJ2Im1KgYY7MfFGitjK865nkKZHJfaq
         tFyw==
X-Gm-Message-State: AOJu0Yy5e/wVa+15CLcTduoch0DKubDgIICJxHqEz/D7h8i7QD6qLDb9
	mf01LzE6IgyMSZfczWBIzt42cfNOAk+fl2bnCJVsDt+4ZAJWNyYnYzKTdjn1JWLEJFgx8uA9iBN
	iUiqGIShuLLmjl14bJS2KnsT+ZfVkIQ==
X-Gm-Gg: ASbGncu/vNZbNiRa8XXFwjA9x2OzwjcbezvdlEaJvn4kbdSlH1AEJoTa/8CnzBUvVnv
	AL3i8kJPkNSK7SvKoI5dcuMWBnOepDr7z5+gc
X-Google-Smtp-Source: AGHT+IH861oDLetfsaiQJ3dJGUOYlRWhBv5LT3L2X9svjXiw5qiIYxliW5cKZidPtHxYikFh/PAZOr5pPQXfS+1wnIo=
X-Received: by 2002:a05:6871:3790:b0:29e:4985:fef with SMTP id
 586e51a60fabf-2aa0654020amr3738519fac.3.1736437305746; Thu, 09 Jan 2025
 07:41:45 -0800 (PST)
MIME-Version: 1.0
References: <CAK9C7GBuqQsWQahLo1pkpmSRGUr-Xi9ncPF6=ZNgkWOBZBaKNQ@mail.gmail.com>
 <52d71d4f-784d-4f8e-8d66-18fe2a912503@siemens.com> <CAK9C7GCBMs8awjxzw5iCy0xUbu+1LJmnSBSv9YR7YA5mKHVUJg@mail.gmail.com>
 <fe44dc91-7eae-4dde-8efd-de636eadf9be@siemens.com>
In-Reply-To: <fe44dc91-7eae-4dde-8efd-de636eadf9be@siemens.com>
From: Stephen Ecker <stephenecker240@gmail.com>
Date: Thu, 9 Jan 2025 09:41:33 -0600
X-Gm-Features: AbW1kvYf2YQkCJ9n5y5Vf3bkVau2ulrlzvZSUSPvIB1q0seGRfgKww_BDgVzQ_U
Message-ID: <CAK9C7GDt9qvnRzy+hmHSfwTK7tHg6Zqirs3e6JYzz_XQGvTchA@mail.gmail.com>
Subject: Re: btrfs support in initramfs-crypt-hook
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org
Content-Type: multipart/alternative; boundary="000000000000c8ac3f062b47d058"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Jan 2025 15:41:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17518

--000000000000c8ac3f062b47d058
Content-Type: text/plain; charset="UTF-8"

I'm thinking the best way to make the crypt hook more modular would be to
break out the support with recipes that add binaries to the initramfs for
mkfs.${fstype} and resizefs.${fstype}

On Thu, Jan 9, 2025, 9:39 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 09.01.25 16:32, Stephen Ecker wrote:
> > Because the upstream version requires a bunch of libs that would have to
> > be added to the initramfs. I compiled the binaries static... The e2fs
> > binaries added were from a static package... There was no static
> > equivalent for btrfs.
>
> We do maintain a few custom recipes for packages, primarily to handle
> backports of patches that won't hit Debian (very-old-)stable anymore.
> This one would be more of a feature recipe, and we would have to look at
> that carefully because of extra maintenance efforts.
>
> Please split up your patch queue, adding this as optimization on top
> (unless that is already the case) while starting with regular
> btrfs-progs. And please open a bug with btrfs-progs in Debian to trigger
> a discussion there as well. If this optimization is important, it should
> become an upstream feature eventually.
>
> Jan
>
> >
> > On Thu, Jan 9, 2025, 9:27 AM Jan Kiszka <jan.kiszka@siemens.com
> > <mailto:jan.kiszka@siemens.com>> wrote:
> >
> >     On 09.01.25 13:37, Stephen Ecker wrote:
> >     > Is the reason for lack of support here due to not having a package
> for
> >     > btrfs-progs-static, or was there some other reason?
> >     >
> >     > I made my own recipe for building the btrfs-progs-static package.
> >     Would
> >     > this be worth submitting a PR to add this support?
> >     >
> >
> >     Primarily lack of use case so far - there are some operational
> >     challenges with btrfs for embedded and offline image building.
> >
> >     But adding btrfs support is imaginable. It would "just" require at
> least
> >     some test coverage in-tree.
> >
> >     BTW, why an own btrfs packages, why not picking from upstream
> >     btrfs-progs? That will need a strong reasoning.
> >
> >     Jan
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

--000000000000c8ac3f062b47d058
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I&#39;m thinking the best way to make the crypt hook more=
 modular would be to break out the support with recipes that add binaries t=
o the initramfs for mkfs.${fstype} and resizefs.${fstype}</div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Thu, Jan 9, 2025, 9:39 AM Jan Kiszka &lt;<a href=3D"mailto:jan.kiszk=
a@siemens.com">jan.kiszka@siemens.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">On 09.01.25 16:32, Stephen Ecker wrote:<br>
&gt; Because the upstream version requires a bunch of libs that would have =
to<br>
&gt; be added to the initramfs. I compiled the binaries static... The e2fs<=
br>
&gt; binaries added were from a static package... There was no static<br>
&gt; equivalent for btrfs.<br>
<br>
We do maintain a few custom recipes for packages, primarily to handle<br>
backports of patches that won&#39;t hit Debian (very-old-)stable anymore.<b=
r>
This one would be more of a feature recipe, and we would have to look at<br=
>
that carefully because of extra maintenance efforts.<br>
<br>
Please split up your patch queue, adding this as optimization on top<br>
(unless that is already the case) while starting with regular<br>
btrfs-progs. And please open a bug with btrfs-progs in Debian to trigger<br=
>
a discussion there as well. If this optimization is important, it should<br=
>
become an upstream feature eventually.<br>
<br>
Jan<br>
<br>
&gt; <br>
&gt; On Thu, Jan 9, 2025, 9:27 AM Jan Kiszka &lt;<a href=3D"mailto:jan.kisz=
ka@siemens.com" target=3D"_blank" rel=3D"noreferrer">jan.kiszka@siemens.com=
</a><br>
&gt; &lt;mailto:<a href=3D"mailto:jan.kiszka@siemens.com" target=3D"_blank"=
 rel=3D"noreferrer">jan.kiszka@siemens.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 09.01.25 13:37, Stephen Ecker wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Is the reason for lack of support here due to =
not having a package for<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; btrfs-progs-static, or was there some other re=
ason?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I made my own recipe for building the btrfs-pr=
ogs-static package.=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0Would<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; this be worth submitting a PR to add this supp=
ort?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Primarily lack of use case so far - there are some =
operational<br>
&gt;=C2=A0 =C2=A0 =C2=A0challenges with btrfs for embedded and offline imag=
e building.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0But adding btrfs support is imaginable. It would &q=
uot;just&quot; require at least<br>
&gt;=C2=A0 =C2=A0 =C2=A0some test coverage in-tree.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0BTW, why an own btrfs packages, why not picking fro=
m upstream<br>
&gt;=C2=A0 =C2=A0 =C2=A0btrfs-progs? That will need a strong reasoning.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Jan<br>
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

--000000000000c8ac3f062b47d058--

