Return-Path: <SRS0=4ICY=AL=lists.cip-project.org=bounce+64572+4871+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E62DC433DF
	for <cip-dev@archiver.kernel.org>; Tue, 30 Jun 2020 11:15:56 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E86C206CB
	for <cip-dev@archiver.kernel.org>; Tue, 30 Jun 2020 11:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="I1x/Fc04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E86C206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mab-labs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4871+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id UBZnYY4521723xAdtF5EhZmD; Tue, 30 Jun 2020 04:15:55 -0700
X-Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
 by mx.groups.io with SMTP id smtpd.web11.13227.1593515753423190858
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2020 04:15:54 -0700
X-Received: by mail-lj1-f171.google.com with SMTP id q7so8735381ljm.1
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2020 04:15:53 -0700 (PDT)
X-Gm-Message-State: uTW3jHfdIx1UvQXFssKpLutkx4520388AA=
X-Google-Smtp-Source: ABdhPJywLsAGan3nkytuKWbJC3B/LeaZbdmVACpY69gpE05Wdra2SeIxOuAMC2Um2sEmOdGJ8Ds8WoVFe5rlpgQ6GaU=
X-Received: by 2002:a2e:a58a:: with SMTP id m10mr10511096ljp.347.1593515751147;
 Tue, 30 Jun 2020 04:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <CALkjhPpsdM8ZoC4QcT1EL8iQob4-pj3MWkesEvnNEFBOZ6LVOw@mail.gmail.com>
 <TY2PR01MB49724BCF6E48D3352A63BEC3A06E0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <OSYPR01MB5334A212C328E61997F50282D96F0@OSYPR01MB5334.jpnprd01.prod.outlook.com>
In-Reply-To: <OSYPR01MB5334A212C328E61997F50282D96F0@OSYPR01MB5334.jpnprd01.prod.outlook.com>
From: "Mohammed Billoo" <mab@mab-labs.com>
Date: Tue, 30 Jun 2020 07:15:39 -0400
Message-ID: <CALkjhPqM5rAVDA1drmzRw5qPpEM4TZN65w8Lva7hLC-+vuYJ9Q@mail.gmail.com>
Subject: Re: [cip-dev] Working on HTTPS connection
To: akihiro27.suzuki@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="jq9Hnj1X2lCdgdgHUNDY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593515755;
 bh=48vZ+nQeKRpCD6TEiJdthQT8q2XjtrBZ9NBveEmCD5A=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=I1x/Fc04P99HCHWuGDJakWUBZ11trdN5mFxJKAzUNo0sZPHIoQuh2xcHndPbSjJUAUX
 MHNbot82v+PvwyxS227JCgCrEatOb+YcfWakN72kxlsNlXwhpp04IdRxVyaB/kMu0KqEc
 kwaW/NePnTMaXE64yaHj8g7Z0oeGn+kDgvg=

--jq9Hnj1X2lCdgdgHUNDY
Content-Type: multipart/alternative; boundary="0000000000004d0d4205a94b4cd3"

--0000000000004d0d4205a94b4cd3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Suzuki, M. Kudo:

Thank you for getting back to me. I'll order the BBB, and start navigating
the codebase until it arrives. I will try my best to make the meetings on
Thursday, but it may be difficult since I'm in NYC and it will be 5AM. Is
it OK if I post updates to the IRC channel when I'm up in the morning (in
case I can't make it to the meeting) ?

Best,
Mohammed

On Tue, Jun 30, 2020 at 3:40 AM <akihiro27.suzuki@toshiba.co.jp> wrote:

> Hi Mohammed,
>
>
>
> Thank you very much for your offer!
>
> I=E2=80=99m Akihiro Suzuki, a chair of SW Updates WG.
>
>
>
> Currently, we are using BeagleBone Black (BBB) for developing our initial
> software update mechanism.
>
> Of course we plan to port it to other reference hardware, but it is not
> done at the moment.
>
> So, could you prepare BBB for the development?
>
>
>
> Even if you can=E2=80=99t prepare it, you may work on the task you are in=
terested
> in because it is not a hardware-specific.
>
> The task aims to connect between client (SWUpdate) and server (hawkBit)
> via HTTPS.
>
>
>
> Best regards,
>
> Suzuki
>
>
>
> *From:* cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> *On
> Behalf Of *masashi.kudo@cybertrust.co.jp
> *Sent:* Tuesday, June 30, 2020 7:32 AM
> *To:* cip-dev@lists.cip-project.org
> *Subject:* Re: [cip-dev] Working on HTTPS connection
>
>
>
> Hi, Mohammed-san,
>
>
>
> Thanks very much for watching the talk, and welcome to cip-dev!
>
>
>
> Regarding SW Update WG, the followings are the their wiki pages.
>
>
>
>
> https://wiki.linuxfoundation.org/civilinfrastructureplatform/start#cip_so=
ftware_updates
>
> https://wiki.linuxfoundation.org/civilinfrastructureplatform/cip-sw-updat=
es
>
>
>
> Also, SW Update WG reports the latest status at IRC meetings which start
> at UTC (GMT) 09:00 every Thursday. Notifications of the meetings are sent
> 6-9 hours before the meetings.
>
>
>
> Hope it helps.
>
>
>
> Best regards,
>
> --
>
> M. Kudo
>
>
>
> *From:* cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> *On
> Behalf Of *Mohammed Billoo
> *Sent:* Tuesday, June 30, 2020 1:57 AM
> *To:* cip-dev@lists.cip-project.org
> *Subject:* [cip-dev] Working on HTTPS connection
>
>
>
> Hello!
>
>
>
> I joined the mailing list from the recommendation on the IRC channel
> (after viewing the CIP talk at ELC). I'd like to work on the following
> issue:
> https://gitlab.com/cip-project/cip-sw-updates/cip-sw-updates-tasks/-/issu=
es/8
>
>
>
> I've written applications + drivers for u-boot, have worked on SSL (albei=
t
> for Amazon FreeRTOS), and have HW handy to hit the ground running (I have=
 a
> DE1-SoC).
>
>
>
> Is there any update on this task that should I be aware of?
>
>
>
> Looking forward to contributing to this project!
>
>
> --
>
> Mohammed A Billoo
>
> Founder
>
> MAB Labs, LLC
>
> www.mab-labs.com
>
> 201-338-2022
>
>
> --
> Mohammed Billoo
> MAB Labs, LLC
> www.mab-labs.com
>


--=20
Mohammed A Billoo
Founder
MAB Labs, LLC
www.mab-labs.com
201-338-2022

--0000000000004d0d4205a94b4cd3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Suzuki, M. Kudo:<br><br><div>Thank you for getting back to=
 me. I&#39;ll order the BBB, and start navigating the codebase until it arr=
ives. I will try my best to make the meetings on Thursday, but it may be di=
fficult since I&#39;m in NYC and it will be 5AM. Is it OK if I post updates=
 to the IRC channel when I&#39;m up in the morning (in case I can&#39;t mak=
e it to the meeting) ?</div><div><br></div><div>Best,</div><div>Mohammed<br=
></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Tue, Jun 30, 2020 at 3:40 AM &lt;<a href=3D"mailto:akihiro27.suzu=
ki@toshiba.co.jp">akihiro27.suzuki@toshiba.co.jp</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">





<div lang=3D"JA">
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">Hi Mohammed,<u></u><u=
></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">Thank you very much f=
or your offer!<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">I=E2=80=99m Akihiro S=
uzuki, a chair of SW Updates WG.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">Currently, we are usi=
ng BeagleBone Black (BBB) for developing our initial software update mechan=
ism.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">Of course we plan to =
port it to other reference hardware, but it is not done at the moment.<u></=
u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">So, could you prepare=
 BBB for the development?<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">Even if you can=E2=80=
=
=99t prepare it, you may work on the task you are interested in because it=
 is not a hardware-specific.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">The task aims to conn=
ect between client (SWUpdate) and server (hawkBit) via HTTPS.<u></u><u></u>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">Best regards,<u></u><=
u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">Suzuki<u></u><u></u><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US"><u></u>=C2=A0<u></u><=
/span></p>
<div>
<div style=3D"border-color:rgb(225,225,225) currentcolor currentcolor;bord=
er-style:solid none none;border-width:1pt medium medium;padding:3pt 0mm 0mm=
">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11pt;font-family:&quot;=
Calibri&quot;,sans-serif" lang=3D"EN-US">From:</span></b><span style=3D"fon=
t-size:11pt;font-family:&quot;Calibri&quot;,sans-serif" lang=3D"EN-US"> <a =
href=3D"mailto:cip-dev@lists.cip-project.org" target=3D"_blank">cip-dev@lis=
ts.cip-project.org</a> &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org"=
 target=3D"_blank">cip-dev@lists.cip-project.org</a>&gt;
<b>On Behalf Of </b><a href=3D"mailto:masashi.kudo@cybertrust.co.jp" targe=
t=3D"_blank">masashi.kudo@cybertrust.co.jp</a><br>
<b>Sent:</b> Tuesday, June 30, 2020 7:32 AM<br>
<b>To:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org" target=3D"_bla=
nk">cip-dev@lists.cip-project.org</a><br>
<b>Subject:</b> Re: [cip-dev] Working on HTTPS connection<u></u><u></u></s=
pan></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">Hi, Mohammed-san,<u><=
/u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">Thanks very much for =
watching the talk, and welcome to cip-dev!<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">Regarding SW Update W=
G, the followings are the their wiki pages.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><a href=3D"https://wiki.linuxf=
oundation.org/civilinfrastructureplatform/start#cip_software_updates" targe=
t=3D"_blank">https://wiki.linuxfoundation.org/civilinfrastructureplatform/s=
tart#cip_software_updates</a></span><span style=3D"font-size:11pt;font-fami=
ly:=E6=B8=B8=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US"><u></u><u>=
</u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><a href=3D"https://wiki.linuxf=
oundation.org/civilinfrastructureplatform/cip-sw-updates" target=3D"_blank"=
>https://wiki.linuxfoundation.org/civilinfrastructureplatform/cip-sw-update=
s</a></span><span style=3D"font-size:11pt;font-family:=E6=B8=B8=E3=82=B4=E3=
=
=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US"><u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">Also, SW Update WG re=
ports the latest status at IRC meetings which start at UTC (GMT) 09:00 ever=
y Thursday. Notifications of the meetings are sent 6-9 hours before the mee=
tings.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">Hope it helps.<u></u>=
<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">Best regards,<u></u><=
u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">--<u></u><u></u></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">M. Kudo<u></u><u></u>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:11pt;font-family:&quot;=
Calibri&quot;,sans-serif" lang=3D"EN-US">From:</span></b><span style=3D"fon=
t-size:11pt;font-family:&quot;Calibri&quot;,sans-serif" lang=3D"EN-US">
<a href=3D"mailto:cip-dev@lists.cip-project.org" target=3D"_blank">cip-dev=
@lists.cip-project.org</a> &lt;<a href=3D"mailto:cip-dev@lists.cip-project.=
org" target=3D"_blank">cip-dev@lists.cip-project.org</a>&gt;
<b>On Behalf Of </b>Mohammed Billoo<br>
<b>Sent:</b> Tuesday, June 30, 2020 1:57 AM<br>
<b>To:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org" target=3D"_bla=
nk">cip-dev@lists.cip-project.org</a><br>
<b>Subject:</b> [cip-dev] Working on HTTPS connection<u></u><u></u></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p=
>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hello!<u></u><u></u></span></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I joined the mailing list from=
 the recommendation on the IRC channel (after viewing the CIP talk at ELC).=
 I&#39;d like to work on the following issue:
<a href=3D"https://gitlab.com/cip-project/cip-sw-updates/cip-sw-updates-ta=
sks/-/issues/8" target=3D"_blank">
https://gitlab.com/cip-project/cip-sw-updates/cip-sw-updates-tasks/-/issue=
s/8</a><u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I&#39;ve written applications =
+ drivers for u-boot, have worked on SSL (albeit for Amazon FreeRTOS), and =
have HW handy to hit the ground running (I have a DE1-SoC).
<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Is there any update on this ta=
sk that should I be aware of?<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Looking forward to contributin=
g to this project!<u></u><u></u></span></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><br>
-- <u></u><u></u></span></p>
<div>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Mohammed A Billoo<u></u><u></u=
></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Founder<u></u><u></u></span></=
p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">MAB Labs, LLC<u></u><u></u></s=
pan></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><a href=3D"http://www.mab-labs=
.com" target=3D"_blank">www.mab-labs.com</a><u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">201-338-2022<u></u><u></u></sp=
an></p>
</div>
</div>
</div>
</div>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><br>
-- <br>
Mohammed Billoo<br>
MAB Labs, LLC<br>
<a href=3D"http://www.mab-labs.com" target=3D"_blank">www.mab-labs.com</a>=
 <u></u><u></u></span></p>
</div>
</div>

</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"=
gmail_signature"><div dir=3D"ltr"><div>Mohammed A Billoo</div><div>Founder<=
/div><div>MAB Labs, LLC</div><div><a href=3D"http://www.mab-labs.com" targe=
t=3D"_blank">www.mab-labs.com</a></div><div>201-338-2022<br></div></div></d=
iv>
<br>-- <br>Mohammed Billoo<br />MAB Labs, LLC<br />www.mab-labs.com

--0000000000004d0d4205a94b4cd3--

--jq9Hnj1X2lCdgdgHUNDY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4871): https://lists.cip-project.org/g/cip-dev/message=
/4871
Mute This Topic: https://lists.cip-project.org/mt/75196049/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--jq9Hnj1X2lCdgdgHUNDY--
