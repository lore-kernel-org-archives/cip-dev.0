Return-Path: <stephenecker240@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D99DE77197
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 15:32:29 +0000 (UTC)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
 by mx.groups.io with SMTP id smtpd.web11.51412.1736436742019444209
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Jan 2025 07:32:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=D9cKrE+e;
 spf=pass (domain: gmail.com, ip: 209.85.167.173, mailfrom: stephenecker240@gmail.com)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3ebb1652729so484046b6e.3
        for <cip-dev@lists.cip-project.org>; Thu, 09 Jan 2025 07:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736436741; x=1737041541; darn=lists.cip-project.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AQRD8ijEW22kCMi4fCYfmJvVw9UNrgDVVG+LpbOPM7U=;
        b=D9cKrE+eMJCj8KVDjG4a7gsIs5dbsg+IVjKNuo/REcuLTj813t8/tW2pHOgA7w2hZa
         +6i9tlLO5oo7lnokIhDhg3FlCJXJtmiswZcyZEcPot7whovm9qb+tv+GfTbn5too+Tgx
         10vC4rMkCCCwjXPNKtMiWm86MuwVj4TEBhI/cJNZfn9oUziil2JjW0uDyT44Emwvw/g1
         wN06/XQB/F6s/qPFhe3RHjQx5zG+j1yUk/uSCcu5OCcUPtiGcPzRmMzPrqZRAIrRAHOR
         9PD2+Lb/xMFdXOyfN6PKhWSVfI8GQ2I4zAaCSAzAEWOf/9i+fX2Z6KdFPRvvnxq+rGAx
         PeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736436741; x=1737041541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQRD8ijEW22kCMi4fCYfmJvVw9UNrgDVVG+LpbOPM7U=;
        b=DSpI+v4TB9G8kKZrkv5yYxnAUdz4Ygcx8ccyxV/8KlmeeU+x6risp8S5dnqTvJkPwF
         Qle0sv4iyxv0u6vyQ9KsXvWfYPYDK7Do5oz9JxP+JgelPHIeTs2G+fO6p+6pVdss470y
         SLKcpQAkGp+oXTrDt0LS4fJ2cvlLU9f31qDEkmUj4CCj59skiM6+FeFfufzqlDqwEAaO
         ai3P237Xq6a488qYy91YToeJqlvDsnooqlASuPP/cI0rm47CuwMxH7dbix+G6qoB9oh9
         eLM3od8ndd0R/JiGScZZ19KANgHS613iphYsB1g2GPr9HpNTrDpyEzNzbJVKR2R1JrUV
         8HsQ==
X-Gm-Message-State: AOJu0YxyMIbmzaeX0o3Y7OE6tMq09ITQM6A9I1kR6L0T0inP/Xixpa4h
	YO8yZeJK/NIeHqbaNgNIBEX9vpVmdrL8s20tofUDW0ChGoHdNIuGxfREZWUdhZF4QAtlKzvpQ9q
	vpfc6yUf/tQaQW+Pan3puL+kPzb4=
X-Gm-Gg: ASbGncvWIjY6kNwuDbcI8jlW7A2q2E0jiCpDp2FDfRnWUkR+pa3Xf1u/RxojEh6ICUd
	c06R/WcdbxjKyFicavY8BoRyvkyVtb/GwchD1
X-Google-Smtp-Source: AGHT+IEuAJs+ZT6qUR3DNA7DEURpcLpAOstqCag9082hf3Kb1OXcogshPCIOzfyqzZXNK26RI6Y4ydy71nwnMeYtubo=
X-Received: by 2002:a05:6808:2f1b:b0:3eb:4375:af61 with SMTP id
 5614622812f47-3ef2ebedb1cmr4784449b6e.14.1736436741235; Thu, 09 Jan 2025
 07:32:21 -0800 (PST)
MIME-Version: 1.0
References: <CAK9C7GBuqQsWQahLo1pkpmSRGUr-Xi9ncPF6=ZNgkWOBZBaKNQ@mail.gmail.com>
 <52d71d4f-784d-4f8e-8d66-18fe2a912503@siemens.com>
In-Reply-To: <52d71d4f-784d-4f8e-8d66-18fe2a912503@siemens.com>
From: Stephen Ecker <stephenecker240@gmail.com>
Date: Thu, 9 Jan 2025 09:32:09 -0600
X-Gm-Features: AbW1kvavTdqjkmXiYeMi8P5cpuUJQm4gmsfI6m_a8j1ciqCj5gwISFzILE0Vj3Q
Message-ID: <CAK9C7GCBMs8awjxzw5iCy0xUbu+1LJmnSBSv9YR7YA5mKHVUJg@mail.gmail.com>
Subject: Re: btrfs support in initramfs-crypt-hook
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org
Content-Type: multipart/alternative; boundary="00000000000022e916062b47af05"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Jan 2025 15:32:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17516

--00000000000022e916062b47af05
Content-Type: text/plain; charset="UTF-8"

Because the upstream version requires a bunch of libs that would have to be
added to the initramfs. I compiled the binaries static... The e2fs binaries
added were from a static package... There was no static equivalent for
btrfs.

On Thu, Jan 9, 2025, 9:27 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 09.01.25 13:37, Stephen Ecker wrote:
> > Is the reason for lack of support here due to not having a package for
> > btrfs-progs-static, or was there some other reason?
> >
> > I made my own recipe for building the btrfs-progs-static package.  Would
> > this be worth submitting a PR to add this support?
> >
>
> Primarily lack of use case so far - there are some operational
> challenges with btrfs for embedded and offline image building.
>
> But adding btrfs support is imaginable. It would "just" require at least
> some test coverage in-tree.
>
> BTW, why an own btrfs packages, why not picking from upstream
> btrfs-progs? That will need a strong reasoning.
>
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
>

--00000000000022e916062b47af05
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Because the upstream version requires a bunch of libs tha=
t would have to be added to the initramfs.  I compiled the binaries static.=
..  The e2fs binaries added were from a static package... There was no stat=
ic equivalent for btrfs.</div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 9, 2025, 9:27 AM =
Jan Kiszka &lt;<a href=3D"mailto:jan.kiszka@siemens.com">jan.kiszka@siemens=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 09.01.25 13:=
37, Stephen Ecker wrote:<br>
&gt; Is the reason for lack of support here due to not having a package for=
<br>
&gt; btrfs-progs-static, or was there some other reason?<br>
&gt; <br>
&gt; I made my own recipe for building the btrfs-progs-static package.=C2=
=A0 Would<br>
&gt; this be worth submitting a PR to add this support?<br>
&gt; <br>
<br>
Primarily lack of use case so far - there are some operational<br>
challenges with btrfs for embedded and offline image building.<br>
<br>
But adding btrfs support is imaginable. It would &quot;just&quot; require a=
t least<br>
some test coverage in-tree.<br>
<br>
BTW, why an own btrfs packages, why not picking from upstream<br>
btrfs-progs? That will need a strong reasoning.<br>
<br>
Jan<br>
<br>
-- <br>
Siemens AG, Foundational Technologies<br>
Linux Expert Center<br>
</blockquote></div>

--00000000000022e916062b47af05--

