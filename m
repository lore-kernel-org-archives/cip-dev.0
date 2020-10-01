Return-Path: <SRS0=rDDv=DI=lists.cip-project.org=bounce+64572+5487+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,WEIRD_PORT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B6CC4727C
	for <cip-dev@archiver.kernel.org>; Thu,  1 Oct 2020 04:37:38 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B03062184D
	for <cip-dev@archiver.kernel.org>; Thu,  1 Oct 2020 04:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Idii6Hy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03062184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5487+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Oy8lYY4521723xahmg0y2Gft; Wed, 30 Sep 2020 21:37:37 -0700
X-Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.web12.5153.1601527055905450459
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Sep 2020 21:37:36 -0700
X-Received: by mail-lf1-f52.google.com with SMTP id 197so4265627lfo.11
        for <cip-dev@lists.cip-project.org>; Wed, 30 Sep 2020 21:37:35 -0700 (PDT)
X-Gm-Message-State: tCbtgZjcNzjLvyQWxUaINQN4x4520388AA=
X-Google-Smtp-Source: ABdhPJw5QIYjntlRn4uj3eh/m69Fr/1fRHRaVCEWuvSr3Jw6l6kQMwYnK+y96c92wMUN7+Gf4vPP8Q==
X-Received: by 2002:ac2:5323:: with SMTP id f3mr1827251lfh.257.1601527053613;
        Wed, 30 Sep 2020 21:37:33 -0700 (PDT)
X-Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id h22sm325280ljl.101.2020.09.30.21.37.33
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 21:37:33 -0700 (PDT)
X-Received: by mail-lj1-f177.google.com with SMTP id k25so3487503ljk.0
        for <cip-dev@lists.cip-project.org>; Wed, 30 Sep 2020 21:37:33 -0700 (PDT)
X-Received: by 2002:a2e:7c03:: with SMTP id x3mr1633451ljc.190.1601527053133;
 Wed, 30 Sep 2020 21:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <TY2PR01MB49725DFFB3B4CD4E0A1777E0A0300@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB49725DFFB3B4CD4E0A1777E0A0300@TY2PR01MB4972.jpnprd01.prod.outlook.com>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 1 Oct 2020 12:37:22 +0800
X-Gmail-Original-Message-ID: <CAGb2v648QgCp_eUQtLQOyax5ej3+NA7kgUmmOMNZGXzjtRfsqQ@mail.gmail.com>
Message-ID: <CAGb2v648QgCp_eUQtLQOyax5ej3+NA7kgUmmOMNZGXzjtRfsqQ@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
To: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="diMeEEu7F2AVjm1tX7IE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601527057;
 bh=BuTJKilMtThNIfJTzH4+DjYZlj4a+VqCx4RrtkWYieM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Idii6Hy/b5zKj6CfwIkbodQx0WDnBgc36HJjmdDr08xNPH2HIhyoXigSKvcHN9jvbxd
 o6WsGL4J8mHFjcqGbqyt+e93yiytYVecEm1Wa3GXmk6m7C3tQxfS74oFwyhg24E9hxnEk
 XvVUohEwKx3YvJRWaMjIgWL6YzvOnerjzCE=

--diMeEEu7F2AVjm1tX7IE
Content-Type: multipart/alternative; boundary="00000000000019aecb05b09493c0"

--00000000000019aecb05b09493c0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

It's the Mid-Autumn Festival, and we have a long weekend here.
So I will not be attending today's meeting.

3 new CVEs this week. Please check the merge request
In cip-kernel-sec for details.


ChenYu

masashi.kudo@cybertrust.co.jp <masashi.kudo@cybertrust.co.jp> =E6=96=BC 20=
20=E5=B9=B410=E6=9C=881=E6=97=A5
=E9=80=B1=E5=9B=9B 08:54 =E5=AF=AB=E9=81=93=EF=BC=9A

> Hi all,
>
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today.
>
> *Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00
> starting from the first week of Apr. according to TSC meeting*
>
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&m=
onth=3D10&day=3D1&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D=
37&p5=3D241&p6=3D248
>
> USWest  USEast  UK      DE      TW      JP
> 02:00   05:00   10:00   11:00   17:00   18:00
>
> Channel:
> * irc:chat.freenode.net:6667/cip
>
> Last meeting minutes:
>
> https://irclogs.baserock.org/meetings/cip/2020/09/cip.2020-09-24-09.00.l=
og.html
>
> Agenda:
>
> * Action item
>   1. Combine root filesystem with kselftest binary - iwamatsu
>   2. Check whether CVE-2020-25284 needs to be backported to 4.4-rt
>       ->  Delete rbd ( Ceph block device ) from 4.4-rt x86 config -
> iwamatsu
>
> * Kernel maintenance updates
> * Kernel testing
> * Software update
> * CIP Security
> * AOB
>
> The meeting will take 30 min, although it can be extended to an hour if =
it
> makes sense and those involved in the topics can stay. Otherwise, the to=
pic
> will be taken offline or in the next meeting.
>
> Best regards,
> --
> M. Kudo
> Cybertrust Japan Co., Ltd.
>
>=20
>
>

--00000000000019aecb05b09493c0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi,<div dir=3D"auto"><br></div><div dir=3D"auto">It&#39;s=
 the Mid-Autumn Festival, and we have a long weekend here.</div><div dir=3D=
"auto">So I will not be attending today&#39;s meeting.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">3 new CVEs this week. Please check the merge=
 request</div><div dir=3D"auto">In cip-kernel-sec for details.</div><div di=
r=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto">ChenYu</=
div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr"><a href=3D"mailto:masashi.kudo@cybertrust.co.jp">masashi.kudo@cybertrus=
t.co.jp</a> &lt;<a href=3D"mailto:masashi.kudo@cybertrust.co.jp">masashi.ku=
do@cybertrust.co.jp</a>&gt; =E6=96=BC 2020=E5=B9=B410=E6=9C=881=E6=97=A5 =
=E9=80=B1=E5=9B=9B 08:54 =E5=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">Hi all,<br>
<br>
Kindly be reminded to attend the weekly meeting through IRC to discuss tec=
hnical topics with CIP kernel today.<br>
<br>
*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 start=
ing from the first week of Apr. according to TSC meeting*<br>
<a href=3D"https://www.timeanddate.com/worldclock/meetingdetails.html?year=
=
=3D2020&amp;month=3D10&amp;day=3D1&amp;hour=3D9&amp;min=3D0&amp;sec=3D0&am=
p;p1=3D224&amp;p2=3D179&amp;p3=3D136&amp;p4=3D37&amp;p5=3D241&amp;p6=3D248"=
 rel=3D"noreferrer noreferrer" target=3D"_blank">https://www.timeanddate.co=
m/worldclock/meetingdetails.html?year=3D2020&amp;month=3D10&amp;day=3D1&amp=
;hour=3D9&amp;min=3D0&amp;sec=3D0&amp;p1=3D224&amp;p2=3D179&amp;p3=3D136&am=
p;p4=3D37&amp;p5=3D241&amp;p6=3D248</a><br>
<br>
USWest=C2=A0 USEast=C2=A0 UK=C2=A0 =C2=A0 =C2=A0 DE=C2=A0 =C2=A0 =C2=A0 TW=
=
=C2=A0 =C2=A0 =C2=A0 JP<br>
02:00=C2=A0 =C2=A005:00=C2=A0 =C2=A010:00=C2=A0 =C2=A011:00=C2=A0 =C2=A017=
:00=C2=A0 =C2=A018:00<br>
<br>
Channel:<br>
* irc:<a href=3D"http://chat.freenode.net:6667/cip" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">chat.freenode.net:6667/cip</a><br>
<br>
Last meeting minutes:<br>
<a href=3D"https://irclogs.baserock.org/meetings/cip/2020/09/cip.2020-09-2=
4-09.00.log.html" rel=3D"noreferrer noreferrer" target=3D"_blank">https://i=
rclogs.baserock.org/meetings/cip/2020/09/cip.2020-09-24-09.00.log.html</a><=
br>
<br>
Agenda:<br>
<br>
* Action item<br>
=C2=A0 1. Combine root filesystem with kselftest binary - iwamatsu <br>
=C2=A0 2. Check whether CVE-2020-25284 needs to be backported to 4.4-rt<br=
>
=C2=A0 =C2=A0 =C2=A0 -&gt;=C2=A0 Delete rbd ( Ceph block device ) from 4.4=
-rt x86 config - iwamatsu <br>
<br>
* Kernel maintenance updates<br>
* Kernel testing<br>
* Software update<br>
* CIP Security <br>
* AOB<br>
<br>
The meeting will take 30 min, although it can be extended to an hour if it=
 makes sense and those involved in the topics can stay. Otherwise, the topi=
c will be taken offline or in the next meeting.<br>
<br>
Best regards,<br>
--<br>
M. Kudo<br>
Cybertrust Japan Co., Ltd.<br>
<br>
<br>
<br>
</blockquote></div>

--00000000000019aecb05b09493c0--

--diMeEEu7F2AVjm1tX7IE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5487): https://lists.cip-project.org/g/cip-dev/message=
/5487
Mute This Topic: https://lists.cip-project.org/mt/77230659/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--diMeEEu7F2AVjm1tX7IE--
