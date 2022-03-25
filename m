Return-Path: <srinuvasanasv@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F4AC433EF
	for <webhook@archiver.kernel.org>; Fri, 25 Mar 2022 11:53:53 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mx.groups.io with SMTP id smtpd.web12.4214.1648209232452746442
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Mar 2022 04:53:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=HxV4myfQ;
 spf=pass (domain: gmail.com, ip: 209.85.160.180,
 mailfrom: srinuvasanasv@gmail.com)
Received: by mail-qt1-f180.google.com with SMTP id t19so6265540qtc.4
        for <cip-dev@lists.cip-project.org>;
 Fri, 25 Mar 2022 04:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ml/ID6/qh0/sJThjw/tw4anmn8KsVansEAFqXNUYhi0=;
        b=HxV4myfQAzAbOViPLuiu2v2ZW2S4oxz4pGQGU1kMziZwt+lP+84c0A2va6aK/HH1UR
         zLhoK6+9w+HwH3MRCFkmba+WOMqIv0ZN1kvCFaJnG0i0PjXEob0UZ+Y7xVFwUmGzuch9
         ZnbyeuRUj2cKa3RH24KHDPX1XmcBolxwtvN1pj9VylNXnhesG8vxoVnh92WGDkdDmMxo
         5RjLGzqwtXPcLdk0hXq6adeGn0jOlWGtWko5LKgxuY1SDIBMJ70OKoPlz7GlDp14/WSt
         GEza13+bUbOzKUaLG8vb9eCom4JzMiSRHG8kqWjXm8I/mzN69NHar1+MNFAux9Q+MeD+
         kB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ml/ID6/qh0/sJThjw/tw4anmn8KsVansEAFqXNUYhi0=;
        b=VMvPPrqwsbVhKSKAd5hSyRUWf4S6+OBGFJFsEaBocab7FnGeauXNlPvlCMh96yp+sl
         ewzCs/yoXmpmCXBMWiwdhChqIR/+HX8ij48CLPUteTBYeg5VJpEnf6pDS8+qoyQv1ZRz
         xDveoiwPLq7joywV7TycylLUP0VX/0y/oC+uPoPBVf2V09kw/pnXfRivTZYL32zVeWqF
         OibAsp2H99Cw+pDMEGNQp/9CkmNCTY5RSoKxLsBOT1QB2yjNmbWWUywzK4fZVDgLAT4l
         NAmZnCAqCJTQgmcTU14i2srSYdI/hHRfT2j8eCWVIdLoRCO854LtyhaQKCVsCQVvFf7r
         TAbw==
X-Gm-Message-State: AOAM5329nO3hP0mYOu6OLKalSkpqLAkHJlH2xYdJqB7igipz/yjkrlXe
	e3w17NPdfyahPjpG4ylbWN8ZoL6Z3qetbAunHWi2J6VD
X-Google-Smtp-Source: 
 ABdhPJzSWcW+NqDwL++HEa+xEaqOutMQ6hbNcChhRS4rZVfbbEtvsJsKYnTcC9Zmx6/QfjoJdQz/WyMVOPcu3I1U9OM=
X-Received: by 2002:a05:622a:1b91:b0:2e2:1ed2:311e with SMTP id
 bp17-20020a05622a1b9100b002e21ed2311emr8730605qtb.192.1648209231493; Fri, 25
 Mar 2022 04:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220325083408.4080473-1-Srinuvasan_A@mentor.com>
 <b126a869-b4f9-4468-2e76-4bb4fe895632@siemens.com>
In-Reply-To: <b126a869-b4f9-4468-2e76-4bb4fe895632@siemens.com>
From: Srinuvasan Arjunan <srinuvasanasv@gmail.com>
Date: Fri, 25 Mar 2022 17:23:40 +0530
Message-ID: 
 <CAB2Z2nMR+GLMqW1GWabK=AGeVWrEjD6n3tKN8Oe=i+6kcGwDkA@mail.gmail.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH] python3-shtab: add export to the
 DEB_BUILD_PROFILES
To: cip-dev@lists.cip-project.org
Cc: Srinuvasan A <Srinuvasan_A@mentor.com>,
	"Moessbauer, Felix (T CED SES-DE)" <felix.moessbauer@siemens.com>
Content-Type: multipart/alternative; boundary="000000000000c23f5605db099d56"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Mar 2022 11:53:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7824

--000000000000c23f5605db099d56
Content-Type: text/plain; charset="UTF-8"

On Fri, Mar 25, 2022 at 5:09 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 25.03.22 09:34, Srinuvasan A wrote:
> > From: Srinuvasan A <srinuvasan_a@mentor.com>
> >
> > When we build this recipes in downstream layer the DEB_BUILD_PROFILES not
> > able to find by rule file hence it is not set the required build
> > profiles.
> >
> > Here we disable the tests `PYBUILD_DISABLE=test`, but due to this
> > unavailability of DEB_BUILD_PROFILES in rule file it is building along
> > with the test hence it's getting failed like "Not able to import module
> > pytest"
> >
> > Exported this one to access from rule file.
> >
> > Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> > ---
> >  recipes-python/shtab/python3-shtab_1.4.2.bb | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/recipes-python/shtab/python3-shtab_1.4.2.bb
> b/recipes-python/shtab/python3-shtab_1.4.2.bb
> > index ce83d6b..554afd3 100644
> > --- a/recipes-python/shtab/python3-shtab_1.4.2.bb
> > +++ b/recipes-python/shtab/python3-shtab_1.4.2.bb
> > @@ -27,7 +27,7 @@ DEBIAN_BUILD_DEPENDS = " \
> >      python3-setuptools-scm:native, \
> >      "
> >
> > -DEB_BUILD_PROFILES = "nocheck"
> > +export DEB_BUILD_PROFILES = "nocheck"
> >
> >  do_prepare_build[cleandirs] += "${S}/debian"
> >  do_prepare_build() {
>
> I lost overview: Do we need to export now (but Isar does not)? Will we
> have to with upcoming sbuild? If we only had to with past Isar, this
> would remain a downstream topic.


  Thanks jan for the confirmation, yes still we were using old ISAR in our
downstream layer, let me create a patch in the downstream layer.

>
> Jan
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#7823):
> https://lists.cip-project.org/g/cip-dev/message/7823
> Mute This Topic: https://lists.cip-project.org/mt/90018409/5367685
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe:
> https://lists.cip-project.org/g/cip-dev/leave/9347598/5367685/1965380532/xyzzy
> [srinuvasanasv@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--000000000000c23f5605db099d56
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 25, 2022 at 5:09 PM Jan K=
iszka &lt;<a href=3D"mailto:jan.kiszka@siemens.com">jan.kiszka@siemens.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n 25.03.22 09:34, Srinuvasan A wrote:<br>
&gt; From: Srinuvasan A &lt;<a href=3D"mailto:srinuvasan_a@mentor.com" targ=
et=3D"_blank">srinuvasan_a@mentor.com</a>&gt;<br>
&gt; <br>
&gt; When we build this recipes in downstream layer the DEB_BUILD_PROFILES =
not<br>
&gt; able to find by rule file hence it is not set the required build<br>
&gt; profiles.<br>
&gt; <br>
&gt; Here we disable the tests `PYBUILD_DISABLE=3Dtest`, but due to this<br=
>
&gt; unavailability of DEB_BUILD_PROFILES in rule file it is building along=
<br>
&gt; with the test hence it&#39;s getting failed like &quot;Not able to imp=
ort module<br>
&gt; pytest&quot;<br>
&gt; <br>
&gt; Exported this one to access from rule file.<br>
&gt; <br>
&gt; Signed-off-by: Srinuvasan A &lt;<a href=3D"mailto:srinuvasan_a@mentor.=
com" target=3D"_blank">srinuvasan_a@mentor.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 recipes-python/shtab/<a href=3D"http://python3-shtab_1.4.2.bb" r=
el=3D"noreferrer" target=3D"_blank">python3-shtab_1.4.2.bb</a> | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/recipes-python/shtab/<a href=3D"http://python3-shtab_1.4.=
2.bb" rel=3D"noreferrer" target=3D"_blank">python3-shtab_1.4.2.bb</a> b/rec=
ipes-python/shtab/<a href=3D"http://python3-shtab_1.4.2.bb" rel=3D"noreferr=
er" target=3D"_blank">python3-shtab_1.4.2.bb</a><br>
&gt; index ce83d6b..554afd3 100644<br>
&gt; --- a/recipes-python/shtab/<a href=3D"http://python3-shtab_1.4.2.bb" r=
el=3D"noreferrer" target=3D"_blank">python3-shtab_1.4.2.bb</a><br>
&gt; +++ b/recipes-python/shtab/<a href=3D"http://python3-shtab_1.4.2.bb" r=
el=3D"noreferrer" target=3D"_blank">python3-shtab_1.4.2.bb</a><br>
&gt; @@ -27,7 +27,7 @@ DEBIAN_BUILD_DEPENDS =3D &quot; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 python3-setuptools-scm:native, \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;<br>
&gt;=C2=A0 <br>
&gt; -DEB_BUILD_PROFILES =3D &quot;nocheck&quot;<br>
&gt; +export DEB_BUILD_PROFILES =3D &quot;nocheck&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 do_prepare_build[cleandirs] +=3D &quot;${S}/debian&quot;<br>
&gt;=C2=A0 do_prepare_build() {<br>
<br>
I lost overview: Do we need to export now (but Isar does not)? Will we<br>
have to with upcoming sbuild? If we only had to with past Isar, this<br>
would remain a downstream topic.=C2=A0</blockquote><div><br></div><div>=C2=
=A0 Thanks jan for the confirmation, yes still we were using old ISAR in ou=
r downstream layer, let me create a patch in the downstream layer.=C2=A0=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Jan<br>
<br>
-- <br>
Siemens AG, Technology<br>
Competence Center Embedded Linux<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#7823): <a href=3D"https://lists.cip-project.org/g/cip-d=
ev/message/7823" rel=3D"noreferrer" target=3D"_blank">https://lists.cip-pro=
ject.org/g/cip-dev/message/7823</a><br>
Mute This Topic: <a href=3D"https://lists.cip-project.org/mt/90018409/53676=
85" rel=3D"noreferrer" target=3D"_blank">https://lists.cip-project.org/mt/9=
0018409/5367685</a><br>
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

--000000000000c23f5605db099d56--

