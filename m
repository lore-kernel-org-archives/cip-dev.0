Return-Path: <SRS0=Dymx=5Z=lists.cip-project.org=bounce+64572+4572+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=AC_DIV_BONANZA,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4097C2BA19
	for <cip-dev@archiver.kernel.org>; Thu,  9 Apr 2020 17:18:18 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ACD9206F7
	for <cip-dev@archiver.kernel.org>; Thu,  9 Apr 2020 17:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="WjGqgL22"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ACD9206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4572+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id WoWjYY4521723xLQj4H9GxJt; Thu, 09 Apr 2020 10:18:17 -0700
X-Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
 by mx.groups.io with SMTP id smtpd.web11.14089.1586452697129843008
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Apr 2020 10:18:17 -0700
X-Received: by mail-io1-f52.google.com with SMTP id y17so311701iow.9
        for <cip-dev@lists.cip-project.org>; Thu, 09 Apr 2020 10:18:17 -0700 (PDT)
X-Gm-Message-State: jdhuk96JbW1CmpllcOHG8Ldbx4520388AA=
X-Google-Smtp-Source: APiQypIdc8Yj03Loe+GYnDNNTboGrpSrZRwJ0hjRLS2Os8p9i1ZAPuaBgUf1NoSnmtIxo41dvcnuxUMXovErldPSdsw=
X-Received: by 2002:a05:6638:38e:: with SMTP id y14mr425680jap.123.1586452694731;
 Thu, 09 Apr 2020 10:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAODMxsK_vgo-=FikL1Z2iYXtetRh+KpRJNL4MchmfXvLMqBTUA@mail.gmail.com>
 <CAODMxsJ5anJK+heh9rnWtAsvCCFLhVnm40cffABgG686_312mQ@mail.gmail.com>
 <CAODMxsKB87WswBCwDHcpaB1TyO6QmTy_vy4qVzdni8OrmEwr7A@mail.gmail.com> <TYAPR01MB2285F51468AEBD8F87036A6FB7C10@TYAPR01MB2285.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB2285F51468AEBD8F87036A6FB7C10@TYAPR01MB2285.jpnprd01.prod.outlook.com>
From: "Neal Caidin" <ncaidin@linuxfoundation.org>
Date: Thu, 9 Apr 2020 13:17:58 -0400
Message-ID: <CAODMxsKyq8YCJVcTyhYyE80_T6d43Xu6CAn=pQu5sWGR_V5yfw@mail.gmail.com>
Subject: Re: [cip-dev] [cip-board] [cip-members] Migration complete - Re: Mailman2 to Groups.io reminder
To: cip-board@lists.cip-project.org
Cc: "cip-members@lists.cip-project.org" <cip-members@lists.cip-project.org>, 
	"cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>, 
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="JJ4Mxb1zIsTDMbwVIf8g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1586452697;
 bh=uEU+xqrqMKKOamB229sSZ/2uS1t4RFse38GSAexMYmo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=WjGqgL22kjCijDH58wzH11BmpMIwNs6DFQJ7artKWIp0HSKqEecagV3E3JMItx3h4oc
 wWP5u4Cp2Raln4laKk5Rd6jTPP5TC/3S2S8HocPmSOcNUqwQn87yr6ZpeDNJmMAJckYq0
 3li/giVmnwp0vu3j1W2Pex6RRPhJ5z4uL90=

--JJ4Mxb1zIsTDMbwVIf8g
Content-Type: multipart/alternative; boundary="00000000000052a30d05a2decd41"

--00000000000052a30d05a2decd41
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

Anything I can do to help?

-- Neal

*Neal Caidin*
Program Manager, Program Management & Operations
The Linux Foundation
+1 (919) 238-9104 (w/h)
+1 (919) 949-1861 (m)
ncaidin@linuxfoundation.org


On Thu, Apr 9, 2020 at 11:26 AM Chris Paterson <chris.paterson2@renesas.co=
m>
wrote:

> Hello all,
>
>
>
> Is anyone still receiving emails from
> cip-testing-results@lists.cip-project.org since the migration?
>
> I don=E2=80=99t seem to be.
>
>
>
> Thanks, Chris
>
>
>
> *From:* cip-members@lists.cip-project.org <
> cip-members@lists.cip-project.org> *On Behalf Of *Neal Caidin via
> lists.cip-project.org
> *Sent:* 06 April 2020 22:45
> *To:* cip-board@lists.cip-project.org; cip-members@lists.cip-project.org=
;
> cip-security@lists.cip-project.org; cip-dev@lists.cip-project.org
> *Subject:* [cip-members] Migration complete - Re: Mailman2 to Groups.io
> reminder
>
>
>
> Dear CIP Community,
>
>
>
> The migration is complete.
>
>
>
> You should receive an email shortly asking you to log in with your email
> address and set a password.
>
>
>
> One important note, please do NOT unsubscribe from the "main" list. This
> would unsubscribe you from all of the CIP lists. "main" is an
> administrative list used by Groups.io as a parent list to manage the oth=
er
> lists. Please let me know if you have any questions or issues.
>
>
>
> Lists
>
> https://lists.cip-project.org/main
>
>
>
> https://lists.cip-project.org/cip-board
>
> https://lists.cip-project.org/cip-dev
>
> https://lists.cip-project.org/cip-testing-results
>
> https://lists.cip-project.org/cip-members
>
> https://lists.cip-project.org/cip-security
>
>
>
>
>
> Email addresses
>
> cip-board@lists.cip-project.org
>
> cip-dev@lists.cip-project.org
>
> cip-testing-results@lists.cip-project.org
>
> cip-members@lists.cip-project.org <cip-members@lists.cip-projec.org>
>
> cip-security@lists.cip-project.org
>
>
>
> *Best regards,*
>
> *Neal*
>
>
>
> *Neal Caidin*
>
> Program Manager, Program Management & Operations
>
> The Linux Foundation
>
> +1 (919) 238-9104 (w/h)
> +1 (919) 949-1861 (m)
>
> ncaidin@linuxfoundation.org
>
>
>
>
>
> On Mon, Apr 6, 2020 at 3:34 PM Neal Caidin <ncaidin@linuxfoundation.org>
> wrote:
>
> Reminder.  Mailman2 to Groups.io conversion about to kick off (about an =
1
> 1/2 hours from now).
>
>
>
>
>
> Please see schedule below.
>
>
>
> Best Regards,
>
> Neal
>
>
>
>
>
>
> *Neal Caidin*
>
> Program Manager, Program Management & Operations
>
> The Linux Foundation
>
> +1 (919) 238-9104 (w/h)
> +1 (919) 949-1861 (m)
>
> ncaidin@linuxfoundation.org
>
>
>
>
>
> On Thu, Apr 2, 2020 at 4:56 PM Neal Caidin <ncaidin@linuxfoundation.org>
> wrote:
>
> [cross posted]
>
>
>
> Reminder.  Mailman2 to Groups.io email is scheduled to start on
>
>
>
> Pacific - 2 pm , Monday, April 6
>
> Eastern - 5 pm, Monday April 6
>
> CET - 11 pm, Monday April 6
>
> JST - 6 am, Tuesday, April 7
>
>
>
> It is expected to take several hours, but could be as much as a full 24
> hours.
>
>
>
> When the migration is completed, I will send out the links so that you c=
an
> access email archives.
>
>
>
> Best regards,
>
> Neal
>
>
>
>
> *Neal Caidin*
>
> Program Manager, Program Management & Operations
>
> The Linux Foundation
>
> +1 (919) 238-9104 (w/h)
> +1 (919) 949-1861 (m)
>
> ncaidin@linuxfoundation.org
>
>=20
>
>

--00000000000052a30d05a2decd41
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Chris,<div><br></div><div>Anything I can do=C2=A0to hel=
p?</div><div><br></div><div>-- Neal</div><div><br clear=3D"all"><div><div d=
ir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><di=
v dir=3D"ltr"><div><div dir=3D"ltr"><span><font color=3D"#888888"><div dir=
=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div=
 dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><b style=3D"color:rgb(136,13=
6,136)"><font color=3D"#666666"><font color=3D"#888888">Neal Caidin</font><=
/font></b><br><div style=3D"color:rgb(136,136,136)"><span style=3D"border-c=
ollapse:collapse"><div><font color=3D"#666666"><font>Program Manager, Progr=
am Management &amp; Operations</font></font></div><div><font color=3D"#6666=
66"><font>The Linux Foundation</font></font></div><div><font color=3D"#6666=
66">+1 (919) 238-9104 (w/h)<br>+1 (919) 949-1861 (m)</font></div><div><font=
 color=3D"#666666"><a href=3D"mailto:ncaidin@linuxfoundation.org" target=3D=
"_blank">ncaidin@linuxfoundation.org</a></font></div></span></div></div></d=
iv></div></div></div></div></div></div></div></font></span></div></div></di=
v></div></div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Apr 9, 2020 at 11:26 AM Chris Paterson &lt;=
<a href=3D"mailto:chris.paterson2@renesas.com">chris.paterson2@renesas.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">





<div lang=3D"EN-GB">
<div class=3D"gmail-m_850370888494414381WordSection1">
<p class=3D"MsoNormal"><span style=3D"color:rgb(112,48,160)">Hello all,<u>=
</u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"color:rgb(112,48,160)"><u></u>=C2=A0=
<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"color:rgb(112,48,160)">Is anyone sti=
ll receiving emails from
<a href=3D"mailto:cip-testing-results@lists.cip-project.org" target=3D"_bl=
ank">cip-testing-results@lists.cip-project.org</a> since the migration?<u><=
/u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"color:rgb(112,48,160)">I don=E2=80=
=99t seem to be.
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"color:rgb(112,48,160)"><u></u>=C2=A0=
<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"color:rgb(112,48,160)">Thanks, Chris=
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"color:rgb(112,48,160)"><u></u>=C2=A0=
<u></u></span></p>
<div style=3D"border-top:none;border-right:none;border-bottom:none;border-=
left:1.5pt solid blue;padding:0cm 0cm 0cm 4pt">
<div>
<div style=3D"border-right:none;border-bottom:none;border-left:none;border=
-top:1pt solid rgb(225,225,225);padding:3pt 0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US">From:</span></b><span lang=
=3D"EN-US"> <a href=3D"mailto:cip-members@lists.cip-project.org" target=3D=
"_blank">cip-members@lists.cip-project.org</a> &lt;<a href=3D"mailto:cip-me=
mbers@lists.cip-project.org" target=3D"_blank">cip-members@lists.cip-projec=
t.org</a>&gt;
<b>On Behalf Of </b>Neal Caidin via <a href=3D"http://lists.cip-project.or=
g" target=3D"_blank">lists.cip-project.org</a><br>
<b>Sent:</b> 06 April 2020 22:45<br>
<b>To:</b> <a href=3D"mailto:cip-board@lists.cip-project.org" target=3D"_b=
lank">cip-board@lists.cip-project.org</a>; <a href=3D"mailto:cip-members@li=
sts.cip-project.org" target=3D"_blank">cip-members@lists.cip-project.org</a=
>; <a href=3D"mailto:cip-security@lists.cip-project.org" target=3D"_blank">=
cip-security@lists.cip-project.org</a>; <a href=3D"mailto:cip-dev@lists.cip=
-project.org" target=3D"_blank">cip-dev@lists.cip-project.org</a><br>
<b>Subject:</b> [cip-members] Migration complete - Re: Mailman2 to Groups.=
io reminder<u></u><u></u></span></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal">Dear CIP Community,<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">The migration is complete.=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">You should receive an email shortly asking you to l=
og in with your email address and set a password.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">One important note, please do NOT unsubscribe from =
the &quot;main&quot; list. This would unsubscribe you from all of the CIP l=
ists. &quot;main&quot; is an administrative list used by Groups.io as a par=
ent list to manage the other lists. Please=C2=A0let=C2=A0me know
 if you have any questions or issues.=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Lists<u></u><u></u></p>
</div>
<div>
<p style=3D"margin:0cm 0cm 0.0001pt"><a href=3D"https://lists.cip-project.=
org/main" target=3D"_blank"><span style=3D"font-family:Arial,sans-serif">ht=
tps://lists.cip-project.org/main</span></a><u></u><u></u></p>
<p style=3D"margin:0cm 0cm 0.0001pt">=C2=A0<u></u><u></u></p>
<p style=3D"margin:0cm 0cm 0.0001pt"><a href=3D"https://lists.cip-project.=
org/cip-board" target=3D"_blank"><span style=3D"font-family:Arial,sans-seri=
f">https://lists.cip-project.org/cip-board</span></a><u></u><u></u></p>
<p style=3D"margin:0cm 0cm 0.0001pt"><a href=3D"https://lists.cip-project.=
org/cip-dev" target=3D"_blank"><span style=3D"font-family:Arial,sans-serif"=
>https://lists.cip-project.org/cip-dev</span></a><u></u><u></u></p>
<p style=3D"margin:0cm 0cm 0.0001pt"><a href=3D"https://lists.cip-project.=
org/cip-testing-results" target=3D"_blank"><span style=3D"font-family:Arial=
,sans-serif">https://lists.cip-project.org/cip-testing-results</span></a><u=
></u><u></u></p>
<p style=3D"margin:0cm 0cm 0.0001pt"><a href=3D"https://lists.cip-project.=
org/cip-members" target=3D"_blank"><span style=3D"font-family:Arial,sans-se=
rif">https://lists.cip-project.org/cip-members</span></a><u></u><u></u></p>
<p style=3D"margin:0cm 0cm 0.0001pt"><a href=3D"https://lists.cip-project.=
org/cip-security" target=3D"_blank"><span style=3D"font-family:Arial,sans-s=
erif">https://lists.cip-project.org/cip-security</span></a><u></u><u></u></=
p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p style=3D"margin:0cm 0cm 0.0001pt"><span style=3D"font-size:12pt;font-fa=
mily:Arial,sans-serif;color:rgb(29,28,29)">=C2=A0</span><u></u><u></u></p>
<p style=3D"margin:0cm 0cm 0.0001pt"><span style=3D"font-size:12pt;font-fa=
mily:Arial,sans-serif;color:rgb(29,28,29)">Email addresses</span><u></u><u>=
</u></p>
<p style=3D"margin:0cm 0cm 0.0001pt"><a href=3D"mailto:cip-board@lists.cip=
-project.org" target=3D"_blank"><span style=3D"font-family:Arial,sans-serif=
">cip-board@lists.cip-project.org</span></a><u></u><u></u></p>
<p style=3D"margin:0cm 0cm 0.0001pt"><a href=3D"mailto:cip-dev@lists.cip-p=
roject.org" target=3D"_blank"><span style=3D"font-family:Arial,sans-serif">=
cip-dev@lists.cip-project.org</span></a><u></u><u></u></p>
<p style=3D"margin:0cm 0cm 0.0001pt"><a href=3D"mailto:cip-testing-results=
@lists.cip-project.org" target=3D"_blank"><span style=3D"font-family:Arial,=
sans-serif">cip-testing-results@lists.cip-project.org</span></a><u></u><u><=
/u></p>
<p style=3D"margin:0cm 0cm 0.0001pt"><a href=3D"mailto:cip-members@lists.c=
ip-projec.org" target=3D"_blank"><span style=3D"font-family:Arial,sans-seri=
f">cip-members@lists.cip-project.org</span></a><u></u><u></u></p>
<p style=3D"margin:0cm 0cm 0.0001pt"><a href=3D"mailto:cip-security@lists.=
cip-project.org" target=3D"_blank"><span style=3D"font-family:Arial,sans-se=
rif">cip-security@lists.cip-project.org</span></a><u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<p class=3D"MsoNormal"><b><span style=3D"color:rgb(136,136,136)">Best rega=
rds,</span></b><span style=3D"color:rgb(136,136,136)"><u></u><u></u></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><b><span style=3D"color:rgb(136,136,136)">Neal</spa=
n></b><span style=3D"color:rgb(136,136,136)"><u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:rgb(136,136,136)"><u></u>=C2=
=A0<u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><b><span style=3D"color:rgb(136,136,136)">Neal Caid=
in</span></b><span style=3D"color:rgb(136,136,136)"><u></u><u></u></span></=
p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:rgb(102,102,102)">Program Mana=
ger, Program Management &amp; Operations</span><span style=3D"color:rgb(136=
,136,136)"><u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:rgb(102,102,102)">The Linux Fo=
undation</span><span style=3D"color:rgb(136,136,136)"><u></u><u></u></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:rgb(102,102,102)">+1 (919) 238=
-9104 (w/h)<br>
+1 (919) 949-1861 (m)</span><span style=3D"color:rgb(136,136,136)"><u></u>=
<u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:rgb(102,102,102)"><a href=3D"m=
ailto:ncaidin@linuxfoundation.org" target=3D"_blank">ncaidin@linuxfoundatio=
n.org</a></span><span style=3D"color:rgb(136,136,136)"><u></u><u></u></span=
></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal">On Mon, Apr 6, 2020 at 3:34 PM Neal Caidin &lt;<a h=
ref=3D"mailto:ncaidin@linuxfoundation.org" target=3D"_blank">ncaidin@linuxf=
oundation.org</a>&gt; wrote:<u></u><u></u></p>
</div>
<blockquote style=3D"border-top:none;border-right:none;border-bottom:none;=
border-left:1pt solid rgb(204,204,204);padding:0cm 0cm 0cm 6pt;margin-left:=
4.8pt;margin-right:0cm">
<div>
<div>
<p class=3D"MsoNormal">Reminder.=C2=A0 Mailman2 to Groups.io conversion ab=
out to kick off (about an 1 1/2 hours=C2=A0from now).<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Please see schedule below.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Best Regards,<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Neal<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><br clear=3D"all">
<u></u><u></u></p>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<p class=3D"MsoNormal"><b><span style=3D"color:rgb(136,136,136)">Neal Caid=
in</span></b><span style=3D"color:rgb(136,136,136)"><u></u><u></u></span></=
p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:rgb(102,102,102)">Program Mana=
ger, Program Management &amp; Operations</span><span style=3D"color:rgb(136=
,136,136)"><u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:rgb(102,102,102)">The Linux Fo=
undation</span><span style=3D"color:rgb(136,136,136)"><u></u><u></u></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:rgb(102,102,102)">+1 (919) 238=
-9104 (w/h)<br>
+1 (919) 949-1861 (m)</span><span style=3D"color:rgb(136,136,136)"><u></u>=
<u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:rgb(102,102,102)"><a href=3D"m=
ailto:ncaidin@linuxfoundation.org" target=3D"_blank">ncaidin@linuxfoundatio=
n.org</a></span><span style=3D"color:rgb(136,136,136)"><u></u><u></u></span=
></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal">On Thu, Apr 2, 2020 at 4:56 PM Neal Caidin &lt;<a h=
ref=3D"mailto:ncaidin@linuxfoundation.org" target=3D"_blank">ncaidin@linuxf=
oundation.org</a>&gt; wrote:<u></u><u></u></p>
</div>
<blockquote style=3D"border-top:none;border-right:none;border-bottom:none;=
border-left:1pt solid rgb(204,204,204);padding:0cm 0cm 0cm 6pt;margin-left:=
4.8pt;margin-right:0cm">
<div>
<p class=3D"MsoNormal">[cross posted]<u></u><u></u></p>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Reminder.=C2=A0 Mailman2 to Groups.io email is sche=
duled to start on=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Pacific - 2 pm , Monday, April 6<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Eastern - 5 pm, Monday April 6<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">CET - 11 pm, Monday April 6<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">JST - 6 am, Tuesday, April 7<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">It is expected to take several hours, but could be =
as much as a full 24 hours.=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">When the migration is completed, I will send out th=
e links so that you can access email archives.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Best regards,<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Neal<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><br clear=3D"all">
<u></u><u></u></p>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<p class=3D"MsoNormal"><b><span style=3D"color:rgb(136,136,136)">Neal Caid=
in</span></b><span style=3D"color:rgb(136,136,136)"><u></u><u></u></span></=
p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:rgb(102,102,102)">Program Mana=
ger, Program Management &amp; Operations</span><span style=3D"color:rgb(136=
,136,136)"><u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:rgb(102,102,102)">The Linux Fo=
undation</span><span style=3D"color:rgb(136,136,136)"><u></u><u></u></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:rgb(102,102,102)">+1 (919) 238=
-9104 (w/h)<br>
+1 (919) 949-1861 (m)</span><span style=3D"color:rgb(136,136,136)"><u></u>=
<u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:rgb(102,102,102)"><a href=3D"m=
ailto:ncaidin@linuxfoundation.org" target=3D"_blank">ncaidin@linuxfoundatio=
n.org</a></span><span style=3D"color:rgb(136,136,136)"><u></u><u></u></span=
></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</blockquote>
</div>
</div>
</blockquote>
</div>
</div>
<div>
<p class=3D"MsoNormal"><u></u></p>
</div>
</div>
</div>
</div>




<p></p><p></p></blockquote></div>

--00000000000052a30d05a2decd41--

--JJ4Mxb1zIsTDMbwVIf8g
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4572): https://lists.cip-project.org/g/cip-dev/message=
/4572
Mute This Topic: https://lists.cip-project.org/mt/72901916/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--JJ4Mxb1zIsTDMbwVIf8g--
