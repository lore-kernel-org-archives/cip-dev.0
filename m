Return-Path: <SRS0=lp8l=JU=lists.cip-project.org=bounce+64572+6387+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75735C433B4
	for <cip-dev@archiver.kernel.org>; Fri, 23 Apr 2021 13:06:10 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC69660BD3
	for <cip-dev@archiver.kernel.org>; Fri, 23 Apr 2021 13:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC69660BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6387+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id zT8gYY4521723xzmS9GiBH3I; Fri, 23 Apr 2021 06:06:09 -0700
X-Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
 by mx.groups.io with SMTP id smtpd.web08.9326.1619183168200396728
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Apr 2021 06:06:08 -0700
X-Received: by mail-yb1-f171.google.com with SMTP id c195so55510120ybf.9
        for <cip-dev@lists.cip-project.org>; Fri, 23 Apr 2021 06:06:08 -0700 (PDT)
X-Gm-Message-State: RBRpmZAg02F3q1RcfnMHWcb4x4520388AA=
X-Google-Smtp-Source: ABdhPJxsPT6Y5m4s3viJla43OrJmbR18owNfP13URiXRhP790FyZ/FBOELDjdxVTaX4ZUsO+AcgKzQ+yPCEHQz8u3Vg=
X-Received: by 2002:a05:6902:1141:: with SMTP id p1mr5138033ybu.125.1619183165308;
 Fri, 23 Apr 2021 06:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210423105756.GA22991@duo.ucw.cz>
In-Reply-To: <20210423105756.GA22991@duo.ucw.cz>
From: "Neal Caidin" <ncaidin@linuxfoundation.org>
Date: Fri, 23 Apr 2021 09:05:47 -0400
Message-ID: <CAODMxs+xAquxDmtbC_4OUk=34HEm3HBAxbZ00kaeVYMZgHnrzg@mail.gmail.com>
Subject: Re: [cip-dev] umn.edu situation and its effects on stable/cip
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, wens@csie.org
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="RVM9j0ySC7EirAWJwKH9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1619183169;
 bh=C7fq/RcpYYrQ55EkTjq25XkNguVWhSzPIGM/PrfXHe4=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=xF6T5iBNROpCAvheLKDt3QzVmNUdlF5y1IXR4BQUvlN3v8LTAAlNSgUqP9iHzA2xvI9
 mxkjX8hJP4kSay6ZsjaUtAbvHaVmk4KPjWPkm7qiaddvLAAj9o0XKIE/hwcjJ4xVKLAF/
 YRTYrDGCRzlg/WuKFEhfm71ar96zxy3BH1Y=

--RVM9j0ySC7EirAWJwKH9
Content-Type: multipart/alternative; boundary="0000000000006515bf05c0a37534"

--0000000000006515bf05c0a37534
Content-Type: text/plain; charset="UTF-8"

A Linux Foundation colleague has offered to do an analysis for projects to
assess the situation.

"I can run an analysis of ... source code looking for commits from the two
PhDs who are currently known, and also look for any commits from an @umn.edu
email address."

If this is of interest, I'll look into this offer further.

Please let me know.

Best,
Neal

*Neal Caidin*
Program Manager, Program Management & Operations
The Linux Foundation
+1 (919) 238-9104 (w/h)
+1 (919) 949-1861 (m)
ncaidin@linuxfoundation.org




On Fri, Apr 23, 2021 at 6:58 AM Pavel Machek <pavel@denx.de> wrote:

> Hi!
>
> You may have noticed in the news something funny is going on with
> umn.edu commits.
>
> Researchers at umn.edu did 3 bad-faith patches to kernel, sent them
> from gmail.com addresses, and tried to get them reviewed (but
> prevented them from being merged):
>
>
> https://github.com/QiushiWu/QiushiWu.github.io/blob/main/papers/OpenSourceInsecurity.pdf
>
> That somehow led to Greg trying to revert all patches from umn.edu:
>
>
> https://github.com/QiushiWu/QiushiWu.github.io/blob/main/papers/OpenSourceInsecurity.pdf
>
> And indeed there are some patches that do not fix any problem in
> mainline (I identified one during stable review), but I don't see
> evidence they were done in bad faith.
>
> This is developing news, discussed on linux-kernel and ksummit-discuss
> mailing lists (at least), but it should not affect us till middle of
> May, and in my view it is likely that impact will be minor in the end.
>
> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> 
>
>

--0000000000006515bf05c0a37534
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">A Linux Foundation colleague has offered to do an analysis=
 for projects to assess the situation.<div><br></div><div>&quot;I can run a=
n analysis of ... source code looking for commits from the two PhDs who are=
 currently known, and also look for any commits from an @<a href=3D"http://=
umn.edu">umn.edu</a> email address.&quot;</div><div><br></div><div>If this =
is of interest, I&#39;ll look into this offer further.</div><div><br></div>=
<div>Please let me know.</div><div><br></div><div>Best,</div><div>Neal</div=
><div><br clear=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signature" dat=
a-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><spa=
n><font color=3D"#888888"><div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=
=3D"ltr"><div><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=
=3D"ltr"><b style=3D"color:rgb(136,136,136)"><font color=3D"#666666"><font=
 color=3D"#888888">Neal Caidin</font></font></b><br><div style=3D"color:rgb=
(136,136,136)"><span style=3D"border-collapse:collapse"><div><font color=3D=
"#666666"><font>Program Manager, Program Management &amp; Operations</font>=
</font></div><div><font color=3D"#666666"><font>The Linux Foundation</font>=
</font></div><div><font color=3D"#666666">+1 (919) 238-9104 (w/h)<br>+1 (91=
9) 949-1861 (m)</font></div><div><font color=3D"#666666"><a href=3D"mailto:=
ncaidin@linuxfoundation.org" target=3D"_blank">ncaidin@linuxfoundation.org<=
/a></font></div><div><br></div><div><br></div></span></div></div></div></di=
v></div></div></div></div></div></div></font></span></div></div></div></div=
></div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Fri, Apr 23, 2021 at 6:58 AM Pavel Machek &lt;<a href=
=3D"mailto:pavel@denx.de">pavel@denx.de</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">Hi!<br>
<br>
You may have noticed in the news something funny is going on with<br>
<a href=3D"http://umn.edu" rel=3D"noreferrer" target=3D"_blank">umn.edu</a=
> commits.<br>
<br>
Researchers at <a href=3D"http://umn.edu" rel=3D"noreferrer" target=3D"_bl=
ank">umn.edu</a> did 3 bad-faith patches to kernel, sent them<br>
from <a href=3D"http://gmail.com" rel=3D"noreferrer" target=3D"_blank">gma=
il.com</a> addresses, and tried to get them reviewed (but<br>
prevented them from being merged):<br>
<br>
<a href=3D"https://github.com/QiushiWu/QiushiWu.github.io/blob/main/papers=
/OpenSourceInsecurity.pdf" rel=3D"noreferrer" target=3D"_blank">https://git=
hub.com/QiushiWu/QiushiWu.github.io/blob/main/papers/OpenSourceInsecurity.p=
df</a><br>
<br>
That somehow led to Greg trying to revert all patches from <a href=3D"http=
://umn.edu" rel=3D"noreferrer" target=3D"_blank">umn.edu</a>:<br>
<br>
<a href=3D"https://github.com/QiushiWu/QiushiWu.github.io/blob/main/papers=
/OpenSourceInsecurity.pdf" rel=3D"noreferrer" target=3D"_blank">https://git=
hub.com/QiushiWu/QiushiWu.github.io/blob/main/papers/OpenSourceInsecurity.p=
df</a><br>
<br>
And indeed there are some patches that do not fix any problem in<br>
mainline (I identified one during stable review), but I don&#39;t see<br>
evidence they were done in bad faith.<br>
<br>
This is developing news, discussed on linux-kernel and ksummit-discuss<br>
mailing lists (at least), but it should not affect us till middle of<br>
May, and in my view it is likely that impact will be minor in the end.<br>
<br>
Best regards,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Pavel<br>
-- <br>
DENX Software Engineering GmbH,=C2=A0 =C2=A0 =C2=A0 Managing Director: Wol=
fgang Denk<br>
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany<br>
<br>
<br>
<br>
</blockquote></div>

--0000000000006515bf05c0a37534--

--RVM9j0ySC7EirAWJwKH9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6387): https://lists.cip-project.org/g/cip-dev/message=
/6387
Mute This Topic: https://lists.cip-project.org/mt/82307678/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--RVM9j0ySC7EirAWJwKH9--
