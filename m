Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7115C433EF
	for <webhook@archiver.kernel.org>; Thu, 14 Oct 2021 20:22:22 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web12.370.1634242941628007876
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Oct 2021 13:22:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NBD844eB;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48,
 mailfrom: ncaidin@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id
 s198-20020a1ca9cf000000b0030d6986ea9fso515441wme.1
        for <cip-dev@lists.cip-project.org>;
 Thu, 14 Oct 2021 13:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=wOo/YR30K+rub9IvHbnqa1lT8S5mmkdrdJwAASDD/S4=;
        b=NBD844eBDCarqVL3jTvOmNMZTteqHUJd1VqSpd7JT69y2A0qd0b6IwFHgiOVg2HYks
         g/2oPVawhsQpUFFz47Fun2CaKljfTQuSCNsolWqImvqXem1CmyD6KH78kx/LklMRRxFG
         nLd4o3Z7pMJyRdPKYbYT3MGtlG4DK+VDq58o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=wOo/YR30K+rub9IvHbnqa1lT8S5mmkdrdJwAASDD/S4=;
        b=OXKCHpxqxtaiYGGwsdpAcDLrBBHinGRKkp2eBqu9SqnBWzRL60pJzXew91wzuV5S2W
         5xbQEMhu+8bdw6TjWLCN9tg4ZdwioBAdwxPq9oSAbNyXmHrkq/DbsmJ7QGljcVwzMgwa
         msC/A+FGuaxyGu/WaHLK2CJ2/xr5/7ah+3zLAeRcYY833mVcXvjOBUGa82yMFC9qbNGB
         8MyIMtKgq9hqP7/tJah+pvDu6G0HivbD3KTQH4JbFhVasZxUtQTb1F8WuJxADp8/wrMn
         YGMu68eDrrrCFFf5Z03MDCpfk/pLfYNZQTC/tque1eJdkSUvJPh1TppXkmouDDcAEAZY
         rjcQ==
X-Gm-Message-State: AOAM530AgsSF2HLBfcrO3TUa86WKuQOT0LXOE+7R0JZw4oW41/n6FLS5
	PhQN23SqsjForAQOJ8uZVJoksXdgOwK0koBz5v9gCPvUA0U19A==
X-Google-Smtp-Source: 
 ABdhPJwRkdBzaG3VSqtBpuaRC7qq4cCXYjY6M4cbPs+rFVP7IlflG2lRFocjEe7+ra6Y/SHs7tBkDCvsblUTKqfArtk=
X-Received: by 2002:a05:600c:350c:: with SMTP id
 h12mr21530758wmq.163.1634242939862;
 Thu, 14 Oct 2021 13:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <cb92b212-2b64-3517-0ab6-7300bd83f752@siemens.com>
In-Reply-To: <cb92b212-2b64-3517-0ab6-7300bd83f752@siemens.com>
From: Neal Caidin <ncaidin@linuxfoundation.org>
Date: Thu, 14 Oct 2021 16:22:03 -0400
Message-ID: 
 <CAODMxs+H1GP8SbdwVPHO6bbgsQ600MUjmE7F20AZXUXt3tU0QQ@mail.gmail.com>
Subject: Re: [cip-dev] Duplicate messages in archive
To: cip-dev@lists.cip-project.org
Content-Type: multipart/alternative; boundary="000000000000e8567d05ce55d50f"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Oct 2021 20:22:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6828

--000000000000e8567d05ce55d50f
Content-Type: text/plain; charset="UTF-8"

This should be fixed now. Please let me know if otherwise.

Thanks!

Neal

*Neal Caidin*
Program Manager, Program Management & Operations
The Linux Foundation
+1 (919) 238-9104 (w/h)
+1 (919) 949-1861 (m)
ncaidin@linuxfoundation.org




On Mon, Oct 4, 2021 at 8:13 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> Hi all,
>
> did anyone already examined or reported that all messages to cip-dev now
> seem to get archived twice on lore.kernel.org? See e.g.
>
> https://lore.kernel.org/cip-dev/TYAPR01MB6252C6286EDCA87D7DB8B10892AE9@TYAPR01MB6252.jpnprd01.prod.outlook.com/T/#t
>
> They also appear twice via nntp, that's how I noticed, but are likely
> not sent twice to subscribers.
>
> Jan
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#6773):
> https://lists.cip-project.org/g/cip-dev/message/6773
> Mute This Topic: https://lists.cip-project.org/mt/86064692/4445066
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe:
> https://lists.cip-project.org/g/cip-dev/leave/8129111/4445066/1365699277/xyzzy
> [ncaidin@linuxfoundation.org]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--000000000000e8567d05ce55d50f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This should be fixed now. Please let me know if otherwise.=
<div><br></div><div>Thanks!</div><div><br></div><div>Neal</div><div><br cle=
ar=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=
=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><span><font col=
or=3D"#888888"><div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr"><div=
><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><b sty=
le=3D"color:rgb(136,136,136)"><font color=3D"#666666"><font color=3D"#88888=
8">Neal Caidin</font></font></b><br><div style=3D"color:rgb(136,136,136)"><=
span style=3D"border-collapse:collapse"><div><font color=3D"#666666"><font>=
Program Manager, Program Management &amp; Operations</font></font></div><di=
v><font color=3D"#666666"><font>The Linux Foundation</font></font></div><di=
v><font color=3D"#666666">+1 (919) 238-9104 (w/h)<br>+1 (919) 949-1861 (m)<=
/font></div><div><font color=3D"#666666"><a href=3D"mailto:ncaidin@linuxfou=
ndation.org" target=3D"_blank">ncaidin@linuxfoundation.org</a></font></div>=
<div><br></div><div><br></div></span></div></div></div></div></div></div></=
div></div></div></div></font></span></div></div></div></div></div><br></div=
></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"=
>On Mon, Oct 4, 2021 at 8:13 AM Jan Kiszka &lt;<a href=3D"mailto:jan.kiszka=
@siemens.com">jan.kiszka@siemens.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Hi all,<br>
<br>
did anyone already examined or reported that all messages to cip-dev now<br=
>
seem to get archived twice on <a href=3D"http://lore.kernel.org" rel=3D"nor=
eferrer" target=3D"_blank">lore.kernel.org</a>? See e.g.<br>
<a href=3D"https://lore.kernel.org/cip-dev/TYAPR01MB6252C6286EDCA87D7DB8B10=
892AE9@TYAPR01MB6252.jpnprd01.prod.outlook.com/T/#t" rel=3D"noreferrer" tar=
get=3D"_blank">https://lore.kernel.org/cip-dev/TYAPR01MB6252C6286EDCA87D7DB=
8B10892AE9@TYAPR01MB6252.jpnprd01.prod.outlook.com/T/#t</a><br>
<br>
They also appear twice via nntp, that&#39;s how I noticed, but are likely<b=
r>
not sent twice to subscribers.<br>
<br>
Jan<br>
<br>
-- <br>
Siemens AG, T RDA IOT<br>
Corporate Competence Center Embedded Linux<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#6773): <a href=3D"https://lists.cip-project.org/g/cip-d=
ev/message/6773" rel=3D"noreferrer" target=3D"_blank">https://lists.cip-pro=
ject.org/g/cip-dev/message/6773</a><br>
Mute This Topic: <a href=3D"https://lists.cip-project.org/mt/86064692/44450=
66" rel=3D"noreferrer" target=3D"_blank">https://lists.cip-project.org/mt/8=
6064692/4445066</a><br>
Group Owner: <a href=3D"mailto:cip-dev%2Bowner@lists.cip-project.org" targe=
t=3D"_blank">cip-dev+owner@lists.cip-project.org</a><br>
Unsubscribe: <a href=3D"https://lists.cip-project.org/g/cip-dev/leave/81291=
11/4445066/1365699277/xyzzy" rel=3D"noreferrer" target=3D"_blank">https://l=
ists.cip-project.org/g/cip-dev/leave/8129111/4445066/1365699277/xyzzy</a> [=
<a href=3D"mailto:ncaidin@linuxfoundation.org" target=3D"_blank">ncaidin@li=
nuxfoundation.org</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000e8567d05ce55d50f--

