Return-Path: <srinuvasanasv@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60681C433F5
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 10:09:47 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.web08.24957.1646647781577698559
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Mar 2022 02:09:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=J54fvTXs;
 spf=pass (domain: gmail.com, ip: 209.85.222.174,
 mailfrom: srinuvasanasv@gmail.com)
Received: by mail-qk1-f174.google.com with SMTP id r127so450972qke.13
        for <cip-dev@lists.cip-project.org>;
 Mon, 07 Mar 2022 02:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yu7wdz5xSs6Kjeezn+38kfzTa1OhBgCu8tIfhcAbOqQ=;
        b=J54fvTXst8qDXTKPu9mBd1Uxye4AMUDJLU6d/6KBHk4mxA3eoeJdU5x+SJti2bJNkk
         TMApIf9LVhaL8mpnNp3m392c27cLg0jVN7eX4lXzmznky7Bg/i/0+l7Qe7d5O7En0D+J
         RU8UZG7mJcUEgrqpTiPQbinactJBv8/BUy2a0oI2TFiDxqrJKY02uiW7/t54ESy1kB/R
         ZVYl5NjKxBmWpoq7hBy3CQFPgFrs2U+mqNXIJK25NjTJtMaDWmVvXCBWTWU5qAPBv6R4
         VCIk7P0LUM8FTea8zZNQCOMtiSNxfrpatktLfDSI7HKlD9LG3xiRGpgZNQP+0B1WVM89
         eD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yu7wdz5xSs6Kjeezn+38kfzTa1OhBgCu8tIfhcAbOqQ=;
        b=LZGzSjkM42o/Kg2BBpBgw82JKLDyl8zkAZkLicTDjllOIzkHyWxTDaoDgcCJB8WI5L
         W8vE1ipu0KHz8S9i7wsw78FkmHFSAaE8RhFdpe7O/UEjWrhGVE7TMxemgXe5wbcHtGVM
         qyLy4EU3379M8ruP37OD59V+wHJmL3KnPIyK1AFJNfFftuXv3Fju7gbIWK4DVCkI77FI
         p5ZH2w9GGDWBXzXQ5mqctUYiplD83Nyor3x5VdhhxdvziMi8JyKDzbN2riUtVauCqs1l
         3o3sSVZBf9THp1byqxL4k5HWd9I/2YUpQGuKM5lL9gSC31OMo374jDPzmtFnFuk8S53u
         pBLw==
X-Gm-Message-State: AOAM532YoWUXTOOdZ8uvUpRhTENh9f9kbE1YgQ0ZI3zqlg7Mzi3NMlv2
	blqV5JjhfBpqJeacQ59Ny6MRksxUc0d2NU5/Rct5WQbfugo=
X-Google-Smtp-Source: 
 ABdhPJzkfMC+Um646Ec9CovNVsHyObopRSCXKrSwYO+gsdlDjLqJQRCvdmB0GTsOAPidt0md7xdAVgJedZaa+8rJqIw=
X-Received: by 2002:a05:620a:2591:b0:67b:3159:97f1 with SMTP id
 x17-20020a05620a259100b0067b315997f1mr1719420qko.530.1646647780581; Mon, 07
 Mar 2022 02:09:40 -0800 (PST)
MIME-Version: 1.0
References: <20220307093403.282069-1-Srinuvasan_A@mentor.com>
 <f824e211-66a5-e959-f31c-d54e5565c7a9@siemens.com>
In-Reply-To: <f824e211-66a5-e959-f31c-d54e5565c7a9@siemens.com>
From: Srinuvasan Arjunan <srinuvasanasv@gmail.com>
Date: Mon, 7 Mar 2022 15:39:29 +0530
Message-ID: 
 <CAB2Z2nO9yvUvnmcPhsgOsqvWAWEej9jUYiWqj_=yd3ra9ZfD+w@mail.gmail.com>
Subject: Re: [cip-dev][PATCH] Update to kas 3.0
To: cip-dev@lists.cip-project.org
Cc: Srinuvasan A <Srinuvasan_A@mentor.com>
Content-Type: multipart/alternative; boundary="0000000000000827f105d99e1091"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Mar 2022 10:09:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7663

--0000000000000827f105d99e1091
Content-Type: text/plain; charset="UTF-8"

On Mon, Mar 7, 2022 at 3:11 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 07.03.22 10:34, Srinuvasan A wrote:
> > From: Srinuvasan A <srinuvasan_a@mentor.com>
> >
> > Update to kas 3.0.
> >
> > Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> > ---
> >  .gitlab-ci.yml | 2 +-
> >  README.md      | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index c06c783..f573da6 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -1,4 +1,4 @@
> > -image: ghcr.io/siemens/kas/kas-isar:2.6.2
> > +image: ghcr.io/siemens/kas/kas-isar:3.0
> >
> >  variables:
> >    GIT_STRATEGY: clone
> > diff --git a/README.md b/README.md
> > index f7cb86e..fc4ddbf 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -12,7 +12,7 @@ from scratch.
> >
> >  Install `kas-container` from the [kas project](
> https://github.com/siemens/kas):
> >
> > -    wget
> https://raw.githubusercontent.com/siemens/kas/2.6.2/kas-container
> > +    wget
> https://raw.githubusercontent.com/siemens/kas/3.0/kas-container
> >      chmod a+x kas-container
> >
> >  Furthermore, install docker and make sure you have required permissions
> to
>
> Please test before you submit: We have an open issue with kas-isar:3.0.
>

  I did a build and verified the pipeline in KAS github, It seems okay, but
when i trigger the build i was able to see some logs related to sbuild
Adding user `builder' to group `sbuild' ...
Adding user builder to group sbuild
Done.

# Setup tasks for sudo users:

# BUILD
# HOME directory in chroot, user:sbuild, 0770 perms, from
# passwd/group copying to chroot, filtered
# Maybe source 50sbuild, or move into common location.

Next, copy the example sbuildrc file to the home directory of each user and
set the variables for your system:

  cp /usr/share/doc/sbuild/examples/example.sbuildrc /builder/.sbuildrc

Now try a build:

  cd /path/to/source
  sbuild-update -ud <distribution>
  (or "sbuild-apt <distribution> apt-get -f install"
       first if the chroot is broken)
  sbuild -d <distribution> <package>_<version>

 Might be i missed the open issue things

thanks,
Srinuvasan.A


> Jan
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#7662):
> https://lists.cip-project.org/g/cip-dev/message/7662
> Mute This Topic: https://lists.cip-project.org/mt/89608460/5367685
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe:
> https://lists.cip-project.org/g/cip-dev/leave/9347598/5367685/1965380532/xyzzy
> [srinuvasanasv@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--0000000000000827f105d99e1091
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 7, 2022 at 3:11 PM Jan Ki=
szka &lt;<a href=3D"mailto:jan.kiszka@siemens.com">jan.kiszka@siemens.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 07.03.22 10:34, Srinuvasan A wrote:<br>
&gt; From: Srinuvasan A &lt;<a href=3D"mailto:srinuvasan_a@mentor.com" targ=
et=3D"_blank">srinuvasan_a@mentor.com</a>&gt;<br>
&gt; <br>
&gt; Update to kas 3.0.<br>
&gt; <br>
&gt; Signed-off-by: Srinuvasan A &lt;<a href=3D"mailto:srinuvasan_a@mentor.=
com" target=3D"_blank">srinuvasan_a@mentor.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 .gitlab-ci.yml | 2 +-<br>
&gt;=C2=A0 README.md=C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 2 files changed, 2 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml<br>
&gt; index c06c783..f573da6 100644<br>
&gt; --- a/.gitlab-ci.yml<br>
&gt; +++ b/.gitlab-ci.yml<br>
&gt; @@ -1,4 +1,4 @@<br>
&gt; -image: <a href=3D"http://ghcr.io/siemens/kas/kas-isar:2.6.2" rel=3D"n=
oreferrer" target=3D"_blank">ghcr.io/siemens/kas/kas-isar:2.6.2</a><br>
&gt; +image: <a href=3D"http://ghcr.io/siemens/kas/kas-isar:3.0" rel=3D"nor=
eferrer" target=3D"_blank">ghcr.io/siemens/kas/kas-isar:3.0</a><br>
&gt;=C2=A0 <br>
&gt;=C2=A0 variables:<br>
&gt;=C2=A0 =C2=A0 GIT_STRATEGY: clone<br>
&gt; diff --git a/README.md b/README.md<br>
&gt; index f7cb86e..fc4ddbf 100644<br>
&gt; --- a/README.md<br>
&gt; +++ b/README.md<br>
&gt; @@ -12,7 +12,7 @@ from scratch.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Install `kas-container` from the [kas project](<a href=3D"https:=
//github.com/siemens/kas" rel=3D"noreferrer" target=3D"_blank">https://gith=
ub.com/siemens/kas</a>):<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 wget <a href=3D"https://raw.githubusercontent.com/sieme=
ns/kas/2.6.2/kas-container" rel=3D"noreferrer" target=3D"_blank">https://ra=
w.githubusercontent.com/siemens/kas/2.6.2/kas-container</a><br>
&gt; +=C2=A0 =C2=A0 wget <a href=3D"https://raw.githubusercontent.com/sieme=
ns/kas/3.0/kas-container" rel=3D"noreferrer" target=3D"_blank">https://raw.=
githubusercontent.com/siemens/kas/3.0/kas-container</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 chmod a+x kas-container<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Furthermore, install docker and make sure you have required perm=
issions to<br>
<br>
Please test before you submit: We have an open issue with kas-isar:3.0.<br>=
</blockquote><div><br></div><div>=C2=A0 I=C2=A0did a build and verified the=
 pipeline in KAS github, It seems okay, but when i trigger the build i was =
able to see some logs related to sbuild</div>Adding user `builder&#39; to g=
roup `sbuild&#39; ...<br>Adding user builder to group sbuild<br>Done.<br><b=
r># Setup tasks for sudo users:<br><br># BUILD<br># HOME directory in chroo=
t, user:sbuild, 0770 perms, from<br># passwd/group copying to chroot, filte=
red<br># Maybe source 50sbuild, or move into common location.<br><br>Next, =
copy the example sbuildrc file to the home directory of each user and<br>se=
t the variables for your system:<br><br>=C2=A0 cp /usr/share/doc/sbuild/exa=
mples/example.sbuildrc /builder/.sbuildrc<br><br>Now try a build:<br><br>=
=C2=A0 cd /path/to/source<br>=C2=A0 sbuild-update -ud &lt;distribution&gt;<=
br>=C2=A0 (or &quot;sbuild-apt &lt;distribution&gt; apt-get -f install&quot=
;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0first if the chroot is broken)<br>=C2=A0 sb=
uild -d &lt;distribution&gt; &lt;package&gt;_&lt;version&gt;<br><div>=C2=A0=
</div><div>=C2=A0Might be i missed the open issue things</div><div><br></di=
v><div>thanks,</div><div>Srinuvasan.A</div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
Jan<br>
<br>
-- <br>
Siemens AG, Technology<br>
Competence Center Embedded Linux<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#7662): <a href=3D"https://lists.cip-project.org/g/cip-d=
ev/message/7662" rel=3D"noreferrer" target=3D"_blank">https://lists.cip-pro=
ject.org/g/cip-dev/message/7662</a><br>
Mute This Topic: <a href=3D"https://lists.cip-project.org/mt/89608460/53676=
85" rel=3D"noreferrer" target=3D"_blank">https://lists.cip-project.org/mt/8=
9608460/5367685</a><br>
Group Owner: <a href=3D"mailto:cip-dev%2Bowner@lists.cip-project.org" targe=
t=3D"_blank">cip-dev+owner@lists.cip-project.org</a><br>
Unsubscribe: <a href=3D"https://lists.cip-project.org/g/cip-dev/leave/93475=
98/5367685/1965380532/xyzzy" rel=3D"noreferrer" target=3D"_blank">https://l=
ists.cip-project.org/g/cip-dev/leave/9347598/5367685/1965380532/xyzzy</a> [=
<a href=3D"mailto:srinuvasanasv@gmail.com" target=3D"_blank">srinuvasanasv@=
gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--0000000000000827f105d99e1091--

