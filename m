Return-Path: <SRS0=nVdi=5X=lists.cip-project.org=bounce+64572+4563+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_FONT_LOW_CONTRAST,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FEBC2BB1D
	for <cip-dev@archiver.kernel.org>; Tue,  7 Apr 2020 11:39:45 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02DBF206F7
	for <cip-dev@archiver.kernel.org>; Tue,  7 Apr 2020 11:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="kfU9d6iS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DBF206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4563+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id FUntYY4521723xTNZi1EA6gn; Tue, 07 Apr 2020 04:39:44 -0700
X-Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
 by mx.groups.io with SMTP id smtpd.web11.7048.1586259583930376311
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Apr 2020 04:39:44 -0700
X-Received: by mail-il1-f174.google.com with SMTP id j69so2802598ila.11
        for <cip-dev@lists.cip-project.org>; Tue, 07 Apr 2020 04:39:43 -0700 (PDT)
X-Gm-Message-State: 9pr8xDAGiL6H1JdzRprRkTDKx4520388AA=
X-Google-Smtp-Source: APiQypJHn7WSv1vCZGX0UZhBS48HUXWkgPeJGttm6Yi+BzUYnPJMO/RMDQajYjwDPAlar+R93rx/pb2+d10vkVDNWoM=
X-Received: by 2002:a92:d20e:: with SMTP id y14mr2043490ily.104.1586259582930;
 Tue, 07 Apr 2020 04:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAODMxsK_vgo-=FikL1Z2iYXtetRh+KpRJNL4MchmfXvLMqBTUA@mail.gmail.com>
 <CAODMxsJ5anJK+heh9rnWtAsvCCFLhVnm40cffABgG686_312mQ@mail.gmail.com>
 <CAODMxsKB87WswBCwDHcpaB1TyO6QmTy_vy4qVzdni8OrmEwr7A@mail.gmail.com> <610BEDF6-E16A-48BC-B8EE-BDBEA1846583@siemens.com>
In-Reply-To: <610BEDF6-E16A-48BC-B8EE-BDBEA1846583@siemens.com>
From: "Neal Caidin" <ncaidin@linuxfoundation.org>
Date: Tue, 7 Apr 2020 07:39:26 -0400
Message-ID: <CAODMxsJE97HXV68Jpj6Wd0D2D-HJVriBs=2uAVHGbGepoA6gcw@mail.gmail.com>
Subject: Password reset - Re: [cip-dev] [cip-members] Migration complete - Re: Mailman2 to Groups.io reminder
To: cip-dev@lists.cip-project.org
Cc: "cip-members@lists.cip-project.org" <cip-members@lists.cip-project.org>, 
	"cip-board@lists.cip-project.org" <cip-board@lists.cip-project.org>, 
	"cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/alternative; boundary="000000000000f6669a05a2b1d640"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1586259584;
 bh=w37YfNEdhY/dq1trfpI6WYLoSTBhuHZJZqYiNIUmd+w=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=kfU9d6iSP8I/K/+pcj3A2buj3+DhOPAd3Yj3tOfXRXNSTci3bbzxDPix7k5AYwhRREJ
 6Y8zyKrDAJi8J9hlimL2ZbJbLkF6+fexLSgJ2kcRNLVWAqBAO+pNeOjGeaXhxXPigimCt
 +jH0oxDS60l/0UqO2NUSh//Uj+7Jn4mXVh4=

--000000000000f6669a05a2b1d640
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For anybody who did not get a password reset email, you can go to
https://lists.cip-project.org/ , choose Login , and click the Forgot
Password link.

Best,
Neal

*Neal Caidin*
Program Manager, Program Management & Operations
The Linux Foundation
+1 (919) 238-9104 (w/h)
+1 (919) 949-1861 (m)
ncaidin@linuxfoundation.org


On Tue, Apr 7, 2020 at 6:26 AM Urs Gleim <urs.gleim@siemens.com> wrote:

> Hi Neal,
>
> Thanks. However I was not requested to set a password.
>
> Best regards,
> Urs
>
> --
> Urs Gleim | Siemens AG | Corporate Technology
>
> Am 06.04.2020 um 23:45 schrieb Neal Caidin <ncaidin@linuxfoundation.org>=
:
>
> =EF=BB=BF
> Dear CIP Community,
>
> The migration is complete.
>
> You should receive an email shortly asking you to log in with your email
> address and set a password.
>
> One important note, please do NOT unsubscribe from the "main" list. This
> would unsubscribe you from all of the CIP lists. "main" is an
> administrative list used by Groups.io as a parent list to manage the oth=
er
> lists. Please let me know if you have any questions or issues.
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
> *Best regards,*
> *Neal*
>
> *Neal Caidin*
> Program Manager, Program Management & Operations
> The Linux Foundation
> +1 (919) 238-9104 (w/h)
> +1 (919) 949-1861 (m)
> ncaidin@linuxfoundation.org
>
>
> On Mon, Apr 6, 2020 at 3:34 PM Neal Caidin <ncaidin@linuxfoundation.org>
> wrote:
>
>> Reminder.  Mailman2 to Groups.io conversion about to kick off (about an=
 1
>> 1/2 hours from now).
>>
>>
>> Please see schedule below.
>>
>> Best Regards,
>> Neal
>>
>>
>>
>> *Neal Caidin*
>> Program Manager, Program Management & Operations
>> The Linux Foundation
>> +1 (919) 238-9104 (w/h)
>> +1 (919) 949-1861 (m)
>> ncaidin@linuxfoundation.org
>>
>>
>> On Thu, Apr 2, 2020 at 4:56 PM Neal Caidin <ncaidin@linuxfoundation.org=
>
>> wrote:
>>
>>> [cross posted]
>>>
>>> Reminder.  Mailman2 to Groups.io email is scheduled to start on
>>>
>>> Pacific - 2 pm , Monday, April 6
>>> Eastern - 5 pm, Monday April 6
>>> CET - 11 pm, Monday April 6
>>> JST - 6 am, Tuesday, April 7
>>>
>>> It is expected to take several hours, but could be as much as a full 2=
4
>>> hours.
>>>
>>> When the migration is completed, I will send out the links so that you
>>> can access email archives.
>>>
>>> Best regards,
>>> Neal
>>>
>>>
>>> *Neal Caidin*
>>> Program Manager, Program Management & Operations
>>> The Linux Foundation
>>> +1 (919) 238-9104 (w/h)
>>> +1 (919) 949-1861 (m)
>>> ncaidin@linuxfoundation.org
>>>
>>=20
>
>

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4563): https://lists.cip-project.org/g/cip-dev/message=
/4563
Mute This Topic: https://lists.cip-project.org/mt/72848146/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--000000000000f6669a05a2b1d640
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">For anybody who did not get a password re=
set email, you can go to=C2=A0<a href=3D"https://lists.cip-project.org/">ht=
tps://lists.cip-project.org/</a> , choose Login , and click the Forgot Pass=
word link.</div><div dir=3D"ltr"><br></div><div dir=3D"ltr">Best,</div><div=
 dir=3D"ltr">Neal</div><div dir=3D"ltr"><br clear=3D"all"><div><div dir=3D"=
ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><div dir=3D"ltr"><span><font color=3D"#888888"><div dir=3D"l=
tr"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div dir=
=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><b style=3D"color:rgb(136,136,1=
36)"><font color=3D"#666666"><font color=3D"#888888">Neal Caidin</font></fo=
nt></b><br><div style=3D"color:rgb(136,136,136)"><span style=3D"border-coll=
apse:collapse"><div><font color=3D"#666666"><font>Program Manager, Program =
Management &amp; Operations</font></font></div><div><font color=3D"#666666"=
><font>The Linux Foundation</font></font></div><div><font color=3D"#666666"=
>+1 (919) 238-9104 (w/h)<br>+1 (919) 949-1861 (m)</font></div><div><font co=
lor=3D"#666666"><a href=3D"mailto:ncaidin@linuxfoundation.org" target=3D"_b=
lank">ncaidin@linuxfoundation.org</a></font></div></span></div></div></div>=
</div></div></div></div></div></div></div></font></span></div></div></div><=
/div></div><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Apr 7, 2020 at 6:26 AM Urs Gleim &lt;<a href=3D"ma=
ilto:urs.gleim@siemens.com">urs.gleim@siemens.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">



<div dir=3D"auto">
Hi Neal,
<div><br>
</div>
<div>Thanks. However I was not requested to set a password.=C2=A0</div>
<div><br>
</div>
<div>Best regards,</div>
<div>Urs<br>
<br>
<div dir=3D"ltr"><span style=3D"background-color:rgba(255,255,255,0)">--<b=
r>
Urs Gleim | Siemens AG | Corporate Technology</span></div>
<div dir=3D"ltr"><br>
<blockquote type=3D"cite">Am 06.04.2020 um 23:45 schrieb Neal Caidin &lt;<=
a href=3D"mailto:ncaidin@linuxfoundation.org" target=3D"_blank">ncaidin@lin=
uxfoundation.org</a>&gt;:<br>
<br>
</blockquote>
</div>
<blockquote type=3D"cite">
<div dir=3D"ltr">=EF=BB=BF
<div dir=3D"ltr">
<div dir=3D"ltr">Dear CIP Community,</div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">The migration is complete.=C2=A0</div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">You should receive an email shortly asking you to log in =
with your email address and set a password.</div>
<div dir=3D"ltr"><br>
</div>
<div>One important note, please do NOT unsubscribe from the &quot;main&quo=
t; list. This would unsubscribe you from all of the CIP lists. &quot;main&q=
uot; is an administrative list used by Groups.io as a parent list to manage=
 the other lists. Please=C2=A0let=C2=A0me know if you have any
 questions or issues.=C2=A0</div>
<div><br>
</div>
<div>Lists</div>
<div dir=3D"ltr"><span id=3D"gmail-m_949794559876372670gmail-docs-internal=
-guid-2e999daf-7fff-5982-2a0c-fbd384e1d408">
<p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"=
><a href=3D"https://lists.cip-project.org/main" style=3D"text-decoration-li=
ne:none" target=3D"_blank"><span style=3D"font-size:11pt;font-family:Arial;=
background-color:transparent;font-variant-numeric:normal;font-variant-east-=
asian:normal;text-decoration-line:underline;vertical-align:baseline;white-s=
pace:pre-wrap">https://lists.cip-project.org/main</span></a></p>
<p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"=
>=C2=A0</p>
<p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"=
><a href=3D"https://lists.cip-project.org/cip-board" style=3D"text-decorati=
on-line:none" target=3D"_blank"><span style=3D"font-size:11pt;font-family:A=
rial;background-color:transparent;font-variant-numeric:normal;font-variant-=
east-asian:normal;text-decoration-line:underline;vertical-align:baseline;wh=
ite-space:pre-wrap">https://lists.cip-project.org/cip-board</span></a></p>
<p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"=
><a href=3D"https://lists.cip-project.org/cip-dev" style=3D"text-decoration=
-line:none" target=3D"_blank"><span style=3D"font-size:11pt;font-family:Ari=
al;background-color:transparent;font-variant-numeric:normal;font-variant-ea=
st-asian:normal;text-decoration-line:underline;vertical-align:baseline;whit=
e-space:pre-wrap">https://lists.cip-project.org/cip-dev</span></a></p>
<p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"=
><a href=3D"https://lists.cip-project.org/cip-testing-results" style=3D"tex=
t-decoration-line:none" target=3D"_blank"><span style=3D"font-size:11pt;fon=
t-family:Arial;background-color:transparent;font-variant-numeric:normal;fon=
t-variant-east-asian:normal;text-decoration-line:underline;vertical-align:b=
aseline;white-space:pre-wrap">https://lists.cip-project.org/cip-testing-res=
ults</span></a></p>
<p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"=
><a href=3D"https://lists.cip-project.org/cip-members" style=3D"text-decora=
tion-line:none" target=3D"_blank"><span style=3D"font-size:11pt;font-family=
:Arial;background-color:transparent;font-variant-numeric:normal;font-varian=
t-east-asian:normal;text-decoration-line:underline;vertical-align:baseline;=
white-space:pre-wrap">https://lists.cip-project.org/cip-members</span></a><=
/p>
<p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"=
><a href=3D"https://lists.cip-project.org/cip-security" style=3D"text-decor=
ation-line:none" target=3D"_blank"><span style=3D"font-size:11pt;font-famil=
y:Arial;background-color:transparent;font-variant-numeric:normal;font-varia=
nt-east-asian:normal;text-decoration-line:underline;vertical-align:baseline=
;white-space:pre-wrap">https://lists.cip-project.org/cip-security</span></a=
></p>
<br>
<p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"=
><span style=3D"font-size:12pt;font-family:Arial;color:rgb(29,28,29);font-v=
ariant-numeric:normal;font-variant-east-asian:normal;vertical-align:baselin=
e;white-space:pre-wrap">=C2=A0</span></p>
<p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"=
><span style=3D"font-size:12pt;font-family:Arial;color:rgb(29,28,29);font-v=
ariant-numeric:normal;font-variant-east-asian:normal;vertical-align:baselin=
e;white-space:pre-wrap">Email addresses</span></p>
<p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"=
><a href=3D"mailto:cip-board@lists.cip-project.org" style=3D"text-decoratio=
n-line:none" target=3D"_blank"><span style=3D"font-size:11pt;font-family:Ar=
ial;background-color:transparent;font-variant-numeric:normal;font-variant-e=
ast-asian:normal;text-decoration-line:underline;vertical-align:baseline;whi=
te-space:pre-wrap">cip-board@lists.cip-project.org</span></a></p>
<p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"=
><a href=3D"mailto:cip-dev@lists.cip-project.org" style=3D"text-decoration-=
line:none" target=3D"_blank"><span style=3D"font-size:11pt;font-family:Aria=
l;background-color:transparent;font-variant-numeric:normal;font-variant-eas=
t-asian:normal;text-decoration-line:underline;vertical-align:baseline;white=
-space:pre-wrap">cip-dev@lists.cip-project.org</span></a></p>
<p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"=
><a href=3D"mailto:cip-testing-results@lists.cip-project.org" style=3D"text=
-decoration-line:none" target=3D"_blank"><span style=3D"font-size:11pt;font=
-family:Arial;background-color:transparent;font-variant-numeric:normal;font=
-variant-east-asian:normal;text-decoration-line:underline;vertical-align:ba=
seline;white-space:pre-wrap">cip-testing-results@lists.cip-project.org</spa=
n></a></p>
<p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"=
><a href=3D"mailto:cip-members@lists.cip-projec.org" style=3D"text-decorati=
on-line:none" target=3D"_blank"><span style=3D"font-size:11pt;font-family:A=
rial;background-color:transparent;font-variant-numeric:normal;font-variant-=
east-asian:normal;text-decoration-line:underline;vertical-align:baseline;wh=
ite-space:pre-wrap">cip-members@lists.cip-project.org</span></a></p>
<p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"=
><a href=3D"mailto:cip-security@lists.cip-project.org" style=3D"text-decora=
tion-line:none" target=3D"_blank"><span style=3D"font-size:11pt;font-family=
:Arial;background-color:transparent;font-variant-numeric:normal;font-varian=
t-east-asian:normal;text-decoration-line:underline;vertical-align:baseline;=
white-space:pre-wrap">cip-security@lists.cip-project.org</span></a></p>
</span><br>
<div>
<div dir=3D"ltr">
<div dir=3D"ltr">
<div dir=3D"ltr"><span><font color=3D"#888888">
<div dir=3D"ltr">
<div dir=3D"ltr">
<div dir=3D"ltr">
<div dir=3D"ltr">
<div dir=3D"ltr">
<div dir=3D"ltr">
<div><b>Best regards,</b></div>
<div><b>Neal</b></div>
<div><b><br>
</b></div>
<div dir=3D"ltr"><b style=3D"color:rgb(136,136,136)"><font color=3D"#66666=
6"><font color=3D"#888888">Neal Caidin</font></font></b><br>
<div style=3D"color:rgb(136,136,136)"><span style=3D"border-collapse:colla=
pse">
<div><font color=3D"#666666"><font>Program Manager, Program Management &am=
p; Operations</font></font></div>
<div><font color=3D"#666666"><font>The Linux Foundation</font></font></div=
>
<div><font color=3D"#666666">+1 (919) 238-9104 (w/h)<br>
+1 (919) 949-1861 (m)</font></div>
<div><font color=3D"#666666"><a href=3D"mailto:ncaidin@linuxfoundation.org=
" target=3D"_blank">ncaidin@linuxfoundation.org</a></font></div>
</span></div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</font></span></div>
</div>
</div>
</div>
<br>
</div>
<br>
<div class=3D"gmail_quote">
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 6, 2020 at 3:34 PM Neal =
Caidin &lt;<a href=3D"mailto:ncaidin@linuxfoundation.org" target=3D"_blank"=
>ncaidin@linuxfoundation.org</a>&gt; wrote:<br>
</div>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
<div dir=3D"ltr">
<div dir=3D"ltr">Reminder.=C2=A0 Mailman2 to Groups.io conversion about to=
 kick off (about an 1 1/2 hours=C2=A0from now).</div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Please see schedule below.</div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Best Regards,</div>
<div>Neal</div>
<div><br>
</div>
<div dir=3D"ltr">
<div><br>
</div>
<div><br clear=3D"all">
<div>
<div dir=3D"ltr">
<div dir=3D"ltr">
<div>
<div dir=3D"ltr"><span><font color=3D"#888888">
<div dir=3D"ltr">
<div dir=3D"ltr">
<div>
<div dir=3D"ltr">
<div>
<div dir=3D"ltr">
<div dir=3D"ltr">
<div dir=3D"ltr">
<div dir=3D"ltr"><b style=3D"color:rgb(136,136,136)"><font color=3D"#66666=
6"><font color=3D"#888888">Neal Caidin</font></font></b><br>
<div style=3D"color:rgb(136,136,136)"><span style=3D"border-collapse:colla=
pse">
<div><font color=3D"#666666"><font>Program Manager, Program Management &am=
p; Operations</font></font></div>
<div><font color=3D"#666666"><font>The Linux Foundation</font></font></div=
>
<div><font color=3D"#666666">+1 (919) 238-9104 (w/h)<br>
+1 (919) 949-1861 (m)</font></div>
<div><font color=3D"#666666"><a href=3D"mailto:ncaidin@linuxfoundation.org=
" target=3D"_blank">ncaidin@linuxfoundation.org</a></font></div>
</span></div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</font></span></div>
</div>
</div>
</div>
</div>
<br>
</div>
</div>
<br>
<div class=3D"gmail_quote">
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 2, 2020 at 4:56 PM Neal =
Caidin &lt;<a href=3D"mailto:ncaidin@linuxfoundation.org" target=3D"_blank"=
>ncaidin@linuxfoundation.org</a>&gt; wrote:<br>
</div>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
<div dir=3D"ltr">[cross posted]
<div><br>
</div>
<div>Reminder.=C2=A0 Mailman2 to Groups.io email is scheduled to start on=
=C2=A0</div>
<div><br>
</div>
<div>Pacific - 2 pm , Monday, April 6</div>
<div>Eastern - 5 pm, Monday April 6</div>
<div>CET - 11 pm, Monday April 6</div>
<div>JST - 6 am, Tuesday, April 7</div>
<div><br>
</div>
<div>It is expected to take several hours, but could be as much as a full =
24 hours.=C2=A0</div>
<div><br>
</div>
<div>When the migration is completed, I will send out the links so that yo=
u can access email archives.</div>
<div><br>
</div>
<div>Best regards,</div>
<div>Neal</div>
<div><br>
</div>
<div><br clear=3D"all">
<div>
<div dir=3D"ltr">
<div dir=3D"ltr">
<div>
<div dir=3D"ltr"><span><font color=3D"#888888">
<div dir=3D"ltr">
<div dir=3D"ltr">
<div>
<div dir=3D"ltr">
<div>
<div dir=3D"ltr">
<div dir=3D"ltr">
<div dir=3D"ltr">
<div dir=3D"ltr"><b style=3D"color:rgb(136,136,136)"><font color=3D"#66666=
6"><font color=3D"#888888">Neal Caidin</font></font></b><br>
<div style=3D"color:rgb(136,136,136)"><span style=3D"border-collapse:colla=
pse">
<div><font color=3D"#666666"><font>Program Manager, Program Management &am=
p; Operations</font></font></div>
<div><font color=3D"#666666"><font>The Linux Foundation</font></font></div=
>
<div><font color=3D"#666666">+1 (919) 238-9104 (w/h)<br>
+1 (919) 949-1861 (m)</font></div>
<div><font color=3D"#666666"><a href=3D"mailto:ncaidin@linuxfoundation.org=
" target=3D"_blank">ncaidin@linuxfoundation.org</a></font></div>
</span></div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</font></span></div>
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

</div>
</blockquote>
</div>
</div>




<p></p><p></p></blockquote></div></div>

<div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>
<hr>
Links:<p>


You receive all messages sent to this group.



<p>

<a target=3D"_blank" href=3D"https://lists.cip-project.org/g/cip-dev/messa=
ge/4563">View/Reply Online (#4563)</a> |


  <a target=3D"_blank" href=3D"mailto:cip-dev@lists.cip-project.org?subjec=
t=3DRe:%20Password%20reset%20-%20Re%3A%20%5Bcip-dev%5D%20%5Bcip-members%5D%=
20Migration%20complete%20-%20Re%3A%20Mailman2%20to%20Groups.io%20reminder">=
Reply To Group</a>
  
    | <a target=3D"_blank" href=3D"mailto:ncaidin@linuxfoundation.org?subj=
ect=3DPrivate:%20Re:%20Password%20reset%20-%20Re%3A%20%5Bcip-dev%5D%20%5Bci=
p-members%5D%20Migration%20complete%20-%20Re%3A%20Mailman2%20to%20Groups.io=
%20reminder">Reply To Sender</a>
  


|


  
    <a target=3D"_blank" href=3D"https://lists.cip-project.org/mt/72848146=
/4520388">Mute This Topic</a>
  

| <a href=3D"https://lists.cip-project.org/g/cip-dev/post">New Topic</a><b=
r>



<br>

<a href=3D"https://lists.cip-project.org/g/cip-dev/editsub/4520388">Your S=
ubscription</a> |
<a href=3D"mailto:cip-dev+owner@lists.cip-project.org">Contact Group Owner=
</a> |

<a href=3D"https://lists.cip-project.org/g/cip-dev/leave/8129055/727948398=
/xyzzy">Unsubscribe</a>

 [cip-dev@archiver.kernel.org]<br>
<div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>


--000000000000f6669a05a2b1d640--
