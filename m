Return-Path: <SRS0=MfP1=EL=lists.cip-project.org=bounce+64572+5738+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,WEIRD_PORT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ED7C2D0A3
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 01:46:35 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFD1D206F9
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 01:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="u/36gqdf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD1D206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5738+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 4pphYY4521723xoGIQoBRzBH; Wed, 04 Nov 2020 17:46:33 -0800
X-Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
 by mx.groups.io with SMTP id smtpd.web12.1685.1604540792319911013
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Nov 2020 17:46:32 -0800
X-Received: by mail-lj1-f178.google.com with SMTP id d24so504253ljg.10
        for <cip-dev@lists.cip-project.org>; Wed, 04 Nov 2020 17:46:32 -0800 (PST)
X-Gm-Message-State: 9mjbAnsz4Ji1yKinsIflreC9x4520388AA=
X-Google-Smtp-Source: ABdhPJw5m6FjVAG089zl2sOtwx6A+ZXJbRIuO27OIacrxKkPRioj+CZ3KHHrslYFrLjlPBTS0GPLyw==
X-Received: by 2002:a2e:3915:: with SMTP id g21mr15912lja.18.1604540789965;
        Wed, 04 Nov 2020 17:46:29 -0800 (PST)
X-Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id n15sm13731ljm.24.2020.11.04.17.46.29
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 17:46:29 -0800 (PST)
X-Received: by mail-lf1-f46.google.com with SMTP id b1so471232lfp.11
        for <cip-dev@lists.cip-project.org>; Wed, 04 Nov 2020 17:46:29 -0800 (PST)
X-Received: by 2002:a19:8353:: with SMTP id f80mr183677lfd.348.1604540789662;
 Wed, 04 Nov 2020 17:46:29 -0800 (PST)
MIME-Version: 1.0
References: <TY2PR01MB4972AB11B2F26872FFA47FD2A0EF0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB4972AB11B2F26872FFA47FD2A0EF0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 5 Nov 2020 09:46:18 +0800
X-Gmail-Original-Message-ID: <CAGb2v67np1aB7R5M-pgvCDHkAJD9YprPsWwjY__ptsSOdbFx1g@mail.gmail.com>
Message-ID: <CAGb2v67np1aB7R5M-pgvCDHkAJD9YprPsWwjY__ptsSOdbFx1g@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
To: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="TcZqnnQjV9epE9sJAUed"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604540793;
 bh=CW8hLaI7R2GEaiGFU7YW2DKldg16eAACYe6SMWG2WaI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=u/36gqdfOUValaES2ldtenbIdXY277M/hVuZMQLlKG5JsN+nicPr7JeUxGZ7mKCOV03
 gtvhBcksX2NoQJpKzGR9bkwCFeGymFxd2ZM6XI4Xh38MM/FI1L/lT1HQs7G2rho43OLl9
 LjnzVnNnxp5T6HBIrsq3+BpIcIqd53ha6mU=

--TcZqnnQjV9epE9sJAUed
Content-Type: multipart/alternative; boundary="000000000000cbaa6d05b3524374"

--000000000000cbaa6d05b3524374
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I will not be able to attend today's meeting.
I will send out this week's CVE report this evening, likely after the
meeting.


Regards,
ChenYu


masashi.kudo@cybertrust.co.jp <masashi.kudo@cybertrust.co.jp> =E6=96=BC 20=
20=E5=B9=B411=E6=9C=885=E6=97=A5
=E9=80=B1=E5=9B=9B 07:20 =E5=AF=AB=E9=81=93=EF=BC=9A

> Hi all,
>
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today.
>
> *Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00
> starting from the first week of Apr. according to TSC meeting*
>
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&m=
onth=3D11&day=3D05&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=
=3D37&p5=3D241&p6=3D248
>
> USWest  USEast  UK      DE      TW      JP
> 02:00   05:00   10:00   11:00   17:00   18:00
>
> Channel:
> * irc:chat.freenode.net:6667/cip
>
> Last meeting minutes:
>
> https://irclogs.baserock.org/meetings/cip/2020/10/cip.2020-10-22-08.59.l=
og.html
>
> Agenda:
>
> * Action item
>   1. Combine root filesystem with kselftest binary - iwamatsu
>   2. Check whether CVE-2019-0145, CVE-2019-0147, CVE-2019-0148 needs to =
be
> backported to 4.4 - Kernel Team
>
> * Kernel maintenance updates
> * Kernel testing
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

--000000000000cbaa6d05b3524374
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi,<div dir=3D"auto"><br></div><div dir=3D"auto">I will n=
ot be able to attend today&#39;s meeting.</div><div dir=3D"auto">I will sen=
d out this week&#39;s CVE report this evening, likely after the meeting.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto=
">Regards,</div><div dir=3D"auto">ChenYu</div><div dir=3D"auto"><br></div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"><=
a href=3D"mailto:masashi.kudo@cybertrust.co.jp" target=3D"_blank" rel=3D"no=
referrer">masashi.kudo@cybertrust.co.jp</a> &lt;<a href=3D"mailto:masashi.k=
udo@cybertrust.co.jp" target=3D"_blank" rel=3D"noreferrer">masashi.kudo@cyb=
ertrust.co.jp</a>&gt; =E6=96=BC 2020=E5=B9=B411=E6=9C=885=E6=97=A5 =E9=80=
=B1=E5=9B=9B 07:20 =E5=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">Hi all,<br>
<br>
Kindly be reminded to attend the weekly meeting through IRC to discuss tec=
hnical topics with CIP kernel today.<br>
<br>
*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 start=
ing from the first week of Apr. according to TSC meeting*<br>
<a href=3D"https://www.timeanddate.com/worldclock/meetingdetails.html?year=
=
=3D2020&amp;month=3D11&amp;day=3D05&amp;hour=3D9&amp;min=3D0&amp;sec=3D0&a=
mp;p1=3D224&amp;p2=3D179&amp;p3=3D136&amp;p4=3D37&amp;p5=3D241&amp;p6=3D248=
" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">https://www.ti=
meanddate.com/worldclock/meetingdetails.html?year=3D2020&amp;month=3D11&amp=
;day=3D05&amp;hour=3D9&amp;min=3D0&amp;sec=3D0&amp;p1=3D224&amp;p2=3D179&am=
p;p3=3D136&amp;p4=3D37&amp;p5=3D241&amp;p6=3D248</a><br>
<br>
USWest=C2=A0 USEast=C2=A0 UK=C2=A0 =C2=A0 =C2=A0 DE=C2=A0 =C2=A0 =C2=A0 TW=
=
=C2=A0 =C2=A0 =C2=A0 JP<br>
02:00=C2=A0 =C2=A005:00=C2=A0 =C2=A010:00=C2=A0 =C2=A011:00=C2=A0 =C2=A017=
:00=C2=A0 =C2=A018:00<br>
<br>
Channel:<br>
* irc:<a href=3D"http://chat.freenode.net:6667/cip" rel=3D"noreferrer nore=
ferrer noreferrer" target=3D"_blank">chat.freenode.net:6667/cip</a><br>
<br>
Last meeting minutes:<br>
<a href=3D"https://irclogs.baserock.org/meetings/cip/2020/10/cip.2020-10-2=
2-08.59.log.html" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank=
">https://irclogs.baserock.org/meetings/cip/2020/10/cip.2020-10-22-08.59.lo=
g.html</a><br>
<br>
Agenda:<br>
<br>
* Action item<br>
=C2=A0 1. Combine root filesystem with kselftest binary - iwamatsu <br>
=C2=A0 2. Check whether CVE-2019-0145, CVE-2019-0147, CVE-2019-0148 needs =
to be backported to 4.4 - Kernel Team<br>
<br>
* Kernel maintenance updates<br>
* Kernel testing<br>
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

--000000000000cbaa6d05b3524374--

--TcZqnnQjV9epE9sJAUed
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5738): https://lists.cip-project.org/g/cip-dev/message=
/5738
Mute This Topic: https://lists.cip-project.org/mt/78041044/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--TcZqnnQjV9epE9sJAUed--
