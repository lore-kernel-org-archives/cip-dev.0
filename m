Return-Path: <SRS0=h3vY=5W=lists.cip-project.org=bounce+64572+4554+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_FONT_LOW_CONTRAST,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CCCC2BA1A
	for <cip-dev@archiver.kernel.org>; Mon,  6 Apr 2020 21:45:20 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27ED0206B8
	for <cip-dev@archiver.kernel.org>; Mon,  6 Apr 2020 21:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="TnPyRg6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27ED0206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4554+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id bwN3YY4521723xRhlCXPN3Lf; Mon, 06 Apr 2020 14:45:19 -0700
X-Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
 by mx.groups.io with SMTP id smtpd.web12.499.1586209518987582433
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Apr 2020 14:45:19 -0700
X-Received: by mail-il1-f177.google.com with SMTP id u15so821323ilm.2
        for <cip-dev@lists.cip-project.org>; Mon, 06 Apr 2020 14:45:18 -0700 (PDT)
X-Gm-Message-State: j0eO60JuGwE4CcCKoiYNzgPsx4520388AA=
X-Google-Smtp-Source: APiQypJjJ0N/BOywPRICCof3QCax5H8ovCX1e+tpGV/jABkASZAkd/dFq8wJTwN4bA2v+xwv2TlhNV/sRQmaqbPaLQ8=
X-Received: by 2002:a92:24f:: with SMTP id 76mr1607395ilc.178.1586209518315;
 Mon, 06 Apr 2020 14:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAODMxsK_vgo-=FikL1Z2iYXtetRh+KpRJNL4MchmfXvLMqBTUA@mail.gmail.com>
 <CAODMxsJ5anJK+heh9rnWtAsvCCFLhVnm40cffABgG686_312mQ@mail.gmail.com>
In-Reply-To: <CAODMxsJ5anJK+heh9rnWtAsvCCFLhVnm40cffABgG686_312mQ@mail.gmail.com>
From: "Neal Caidin" <ncaidin@linuxfoundation.org>
Date: Mon, 6 Apr 2020 17:45:02 -0400
Message-ID: <CAODMxsKB87WswBCwDHcpaB1TyO6QmTy_vy4qVzdni8OrmEwr7A@mail.gmail.com>
Subject: [cip-dev] Migration complete - Re: Mailman2 to Groups.io reminder
To: cip-board@lists.cip-project.org, cip-members@lists.cip-project.org, 
	cip-security@lists.cip-project.org, cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/alternative; boundary="000000000000e10df805a2a62e52"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1586209519;
 bh=nOiOjcZ8ljSWfqJ0w1XIOSBj9SRgBgiDjvKiOGT7QeI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=TnPyRg6D3VEhNkGsMjoaLubRBKzwJf4+Ugqq42wSVWLrjG/jmqnTkzzzARRmpAdVw8G
 zNPi4AdLjMkKiQYSYXWD+AgG++bxtpCKzL9KAOrkI3pyYr6kcVd0OEg/UEtHtSJ6pRVet
 H0rMb9fsqWccFCGZNhbARNftp5S9V1ydjw0=

--000000000000e10df805a2a62e52
Content-Type: text/plain; charset="UTF-8"

Dear CIP Community,

The migration is complete.

You should receive an email shortly asking you to log in with your email
address and set a password.

One important note, please do NOT unsubscribe from the "main" list. This
would unsubscribe you from all of the CIP lists. "main" is an
administrative list used by Groups.io as a parent list to manage the other
lists. Please let me know if you have any questions or issues.

Lists

https://lists.cip-project.org/main



https://lists.cip-project.org/cip-board

https://lists.cip-project.org/cip-dev

https://lists.cip-project.org/cip-testing-results

https://lists.cip-project.org/cip-members

https://lists.cip-project.org/cip-security



Email addresses

cip-board@lists.cip-project.org

cip-dev@lists.cip-project.org

cip-testing-results@lists.cip-project.org

cip-members@lists.cip-project.org <cip-members@lists.cip-projec.org>

cip-security@lists.cip-project.org

*Best regards,*
*Neal*

*Neal Caidin*
Program Manager, Program Management & Operations
The Linux Foundation
+1 (919) 238-9104 (w/h)
+1 (919) 949-1861 (m)
ncaidin@linuxfoundation.org


On Mon, Apr 6, 2020 at 3:34 PM Neal Caidin <ncaidin@linuxfoundation.org>
wrote:

> Reminder.  Mailman2 to Groups.io conversion about to kick off (about an 1
> 1/2 hours from now).
>
>
> Please see schedule below.
>
> Best Regards,
> Neal
>
>
>
> *Neal Caidin*
> Program Manager, Program Management & Operations
> The Linux Foundation
> +1 (919) 238-9104 (w/h)
> +1 (919) 949-1861 (m)
> ncaidin@linuxfoundation.org
>
>
> On Thu, Apr 2, 2020 at 4:56 PM Neal Caidin <ncaidin@linuxfoundation.org>
> wrote:
>
>> [cross posted]
>>
>> Reminder.  Mailman2 to Groups.io email is scheduled to start on
>>
>> Pacific - 2 pm , Monday, April 6
>> Eastern - 5 pm, Monday April 6
>> CET - 11 pm, Monday April 6
>> JST - 6 am, Tuesday, April 7
>>
>> It is expected to take several hours, but could be as much as a full 24
>> hours.
>>
>> When the migration is completed, I will send out the links so that you
>> can access email archives.
>>
>> Best regards,
>> Neal
>>
>>
>> *Neal Caidin*
>> Program Manager, Program Management & Operations
>> The Linux Foundation
>> +1 (919) 238-9104 (w/h)
>> +1 (919) 949-1861 (m)
>> ncaidin@linuxfoundation.org
>>
>

-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.

View/Reply Online (#4554): https://lists.cip-project.org/g/cip-dev/message/4554
Mute This Topic: https://lists.cip-project.org/mt/72837893/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/727948398/xyzzy  [cip-dev@archiver.kernel.org]
-=-=-=-=-=-=-=-=-=-=-=-


--000000000000e10df805a2a62e52
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Dear CIP Community,</div><div dir=3D"ltr"=
><br></div><div dir=3D"ltr">The migration is complete.=C2=A0</div><div dir=
=3D"ltr"><br></div><div dir=3D"ltr">You should receive an email shortly as=
king you to log in with your email address and set a password.</div><div di=
r=3D"ltr"><br></div><div>One important note, please do NOT unsubscribe from=
 the &quot;main&quot; list. This would unsubscribe you from all of the CIP =
lists. &quot;main&quot; is an administrative list used by Groups.io as a pa=
rent list to manage the other lists. Please=C2=A0let=C2=A0me know if you ha=
ve any questions or issues.=C2=A0</div><div><br></div><div>Lists</div><div =
dir=3D"ltr"><span id=3D"gmail-docs-internal-guid-2e999daf-7fff-5982-2a0c-fb=
d384e1d408"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-=
bottom:0pt"><a href=3D"https://lists.cip-project.org/main" style=3D"text-de=
coration-line:none"><span style=3D"font-size:11pt;font-family:Arial;backgro=
und-color:transparent;font-variant-numeric:normal;font-variant-east-asian:n=
ormal;text-decoration-line:underline;vertical-align:baseline;white-space:pr=
e-wrap">https://lists.cip-project.org/main</span></a></p><p dir=3D"ltr" sty=
le=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt">=C2=A0</p><p dir=
=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><a hr=
ef=3D"https://lists.cip-project.org/cip-board" style=3D"text-decoration-lin=
e:none"><span style=3D"font-size:11pt;font-family:Arial;background-color:tr=
ansparent;font-variant-numeric:normal;font-variant-east-asian:normal;text-d=
ecoration-line:underline;vertical-align:baseline;white-space:pre-wrap">http=
s://lists.cip-project.org/cip-board</span></a></p><p dir=3D"ltr" style=3D"l=
ine-height:1.38;margin-top:0pt;margin-bottom:0pt"><a href=3D"https://lists.=
cip-project.org/cip-dev" style=3D"text-decoration-line:none"><span style=3D=
"font-size:11pt;font-family:Arial;background-color:transparent;font-variant=
-numeric:normal;font-variant-east-asian:normal;text-decoration-line:underli=
ne;vertical-align:baseline;white-space:pre-wrap">https://lists.cip-project.=
org/cip-dev</span></a></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-t=
op:0pt;margin-bottom:0pt"><a href=3D"https://lists.cip-project.org/cip-test=
ing-results" style=3D"text-decoration-line:none"><span style=3D"font-size:1=
1pt;font-family:Arial;background-color:transparent;font-variant-numeric:nor=
mal;font-variant-east-asian:normal;text-decoration-line:underline;vertical-=
align:baseline;white-space:pre-wrap">https://lists.cip-project.org/cip-test=
ing-results</span></a></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-t=
op:0pt;margin-bottom:0pt"><a href=3D"https://lists.cip-project.org/cip-memb=
ers" style=3D"text-decoration-line:none"><span style=3D"font-size:11pt;font=
-family:Arial;background-color:transparent;font-variant-numeric:normal;font=
-variant-east-asian:normal;text-decoration-line:underline;vertical-align:ba=
seline;white-space:pre-wrap">https://lists.cip-project.org/cip-members</spa=
n></a></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bo=
ttom:0pt"><a href=3D"https://lists.cip-project.org/cip-security" style=3D"t=
ext-decoration-line:none"><span style=3D"font-size:11pt;font-family:Arial;b=
ackground-color:transparent;font-variant-numeric:normal;font-variant-east-a=
sian:normal;text-decoration-line:underline;vertical-align:baseline;white-sp=
ace:pre-wrap">https://lists.cip-project.org/cip-security</span></a></p><br>=
<p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt">=
<span style=3D"font-size:12pt;font-family:Arial;color:rgb(29,28,29);font-va=
riant-numeric:normal;font-variant-east-asian:normal;vertical-align:baseline=
;white-space:pre-wrap">=C2=A0</span></p><p dir=3D"ltr" style=3D"line-height=
:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:12pt;font-=
family:Arial;color:rgb(29,28,29);font-variant-numeric:normal;font-variant-e=
ast-asian:normal;vertical-align:baseline;white-space:pre-wrap">Email addres=
ses</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margi=
n-bottom:0pt"><a href=3D"mailto:cip-board@lists.cip-project.org" style=3D"t=
ext-decoration-line:none"><span style=3D"font-size:11pt;font-family:Arial;b=
ackground-color:transparent;font-variant-numeric:normal;font-variant-east-a=
sian:normal;text-decoration-line:underline;vertical-align:baseline;white-sp=
ace:pre-wrap">cip-board@lists.cip-project.org</span></a></p><p dir=3D"ltr" =
style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><a href=3D"mail=
to:cip-dev@lists.cip-project.org" style=3D"text-decoration-line:none"><span=
 style=3D"font-size:11pt;font-family:Arial;background-color:transparent;fon=
t-variant-numeric:normal;font-variant-east-asian:normal;text-decoration-lin=
e:underline;vertical-align:baseline;white-space:pre-wrap">cip-dev@lists.cip=
-project.org</span></a></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-=
top:0pt;margin-bottom:0pt"><a href=3D"mailto:cip-testing-results@lists.cip-=
project.org" style=3D"text-decoration-line:none"><span style=3D"font-size:1=
1pt;font-family:Arial;background-color:transparent;font-variant-numeric:nor=
mal;font-variant-east-asian:normal;text-decoration-line:underline;vertical-=
align:baseline;white-space:pre-wrap">cip-testing-results@lists.cip-project.=
org</span></a></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;m=
argin-bottom:0pt"><a href=3D"mailto:cip-members@lists.cip-projec.org" style=
=
=3D"text-decoration-line:none"><span style=3D"font-size:11pt;font-family:A=
rial;background-color:transparent;font-variant-numeric:normal;font-variant-=
east-asian:normal;text-decoration-line:underline;vertical-align:baseline;wh=
ite-space:pre-wrap">cip-members@lists.cip-project.org</span></a></p><p dir=
=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><a hr=
ef=3D"mailto:cip-security@lists.cip-project.org" style=3D"text-decoration-l=
ine:none"><span style=3D"font-size:11pt;font-family:Arial;background-color:=
transparent;font-variant-numeric:normal;font-variant-east-asian:normal;text=
-decoration-line:underline;vertical-align:baseline;white-space:pre-wrap">ci=
p-security@lists.cip-project.org</span></a></p></span><br class=3D"gmail-Ap=
ple-interchange-newline"><div><div dir=3D"ltr" class=3D"gmail_signature" da=
ta-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><span><f=
ont color=3D"#888888"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><d=
iv dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div><b>Best regards,</b><=
/div><div><b>Neal</b></div><div><b><br></b></div><div dir=3D"ltr"><b style=
=3D"color:rgb(136,136,136)"><font color=3D"#666666"><font color=3D"#888888=
">Neal Caidin</font></font></b><br><div style=3D"color:rgb(136,136,136)"><s=
pan style=3D"border-collapse:collapse"><div><font color=3D"#666666"><font>P=
rogram Manager, Program Management &amp; Operations</font></font></div><div=
><font color=3D"#666666"><font>The Linux Foundation</font></font></div><div=
><font color=3D"#666666">+1 (919) 238-9104 (w/h)<br>+1 (919) 949-1861 (m)</=
font></div><div><font color=3D"#666666"><a href=3D"mailto:ncaidin@linuxfoun=
dation.org" target=3D"_blank">ncaidin@linuxfoundation.org</a></font></div><=
/span></div></div></div></div></div></div></div></div></font></span></div><=
/div></div></div><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Mon, Apr 6, 2020 at 3:34 PM Neal Caidin &lt;<a href=
=
=3D"mailto:ncaidin@linuxfoundation.org">ncaidin@linuxfoundation.org</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div di=
r=3D"ltr"><div dir=3D"ltr">Reminder.=C2=A0 Mailman2 to Groups.io conversion=
 about to kick off (about an 1 1/2 hours=C2=A0from now).</div><div dir=3D"l=
tr"><br></div><div dir=3D"ltr"><br></div><div dir=3D"ltr">Please see schedu=
le below.</div><div dir=3D"ltr"><br></div><div dir=3D"ltr">Best Regards,</d=
iv><div>Neal</div><div><br></div><div dir=3D"ltr"><div><br></div><div><br c=
lear=3D"all"><div><div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr"><=
span><font color=3D"#888888"><div dir=3D"ltr"><div dir=3D"ltr"><div><div di=
r=3D"ltr"><div><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=
=3D"ltr"><b style=3D"color:rgb(136,136,136)"><font color=3D"#666666"><font=
 color=3D"#888888">Neal Caidin</font></font></b><br><div style=3D"color:rgb=
(136,136,136)"><span style=3D"border-collapse:collapse"><div><font color=3D=
"#666666"><font>Program Manager, Program Management &amp; Operations</font>=
</font></div><div><font color=3D"#666666"><font>The Linux Foundation</font>=
</font></div><div><font color=3D"#666666">+1 (919) 238-9104 (w/h)<br>+1 (91=
9) 949-1861 (m)</font></div><div><font color=3D"#666666"><a href=3D"mailto:=
ncaidin@linuxfoundation.org" target=3D"_blank">ncaidin@linuxfoundation.org<=
/a></font></div></span></div></div></div></div></div></div></div></div></di=
v></div></font></span></div></div></div></div></div><br></div></div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 2=
, 2020 at 4:56 PM Neal Caidin &lt;<a href=3D"mailto:ncaidin@linuxfoundation=
.org" target=3D"_blank">ncaidin@linuxfoundation.org</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">[cross =
posted]<div><br></div><div>Reminder.=C2=A0 Mailman2 to Groups.io email is s=
cheduled to start on=C2=A0</div><div><br></div><div>Pacific - 2 pm , Monday=
, April 6</div><div>Eastern - 5 pm, Monday April 6</div><div>CET - 11 pm, M=
onday April 6</div><div>JST - 6 am, Tuesday, April 7</div><div><br></div><d=
iv>It is expected to take several hours, but could be as much as a full 24 =
hours.=C2=A0</div><div><br></div><div>When the migration is completed, I wi=
ll send out the links so that you can access email archives.</div><div><br>=
</div><div>Best regards,</div><div>Neal</div><div><br></div><div><br clear=
=3D"all"><div><div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr"><spa=
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
/a></font></div></span></div></div></div></div></div></div></div></div></di=
v></div></font></span></div></div></div></div></div></div></div>
</blockquote></div>
</div>
</blockquote></div></div>

<div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>
<hr>
Links:<p>


You receive all messages sent to this group.



<p>

<a target=3D"_blank" href=3D"https://lists.cip-project.org/g/cip-dev/messa=
ge/4554">View/Reply Online (#4554)</a> |


  <a target=3D"_blank" href=3D"mailto:cip-dev@lists.cip-project.org?subjec=
t=3DRe:%20%5Bcip-dev%5D%20Migration%20complete%20-%20Re%3A%20Mailman2%20to%=
20Groups.io%20reminder">Reply To Group</a>
  
    | <a target=3D"_blank" href=3D"mailto:ncaidin@linuxfoundation.org?subj=
ect=3DPrivate:%20Re:%20%5Bcip-dev%5D%20Migration%20complete%20-%20Re%3A%20M=
ailman2%20to%20Groups.io%20reminder">Reply To Sender</a>
  


|


  
    <a target=3D"_blank" href=3D"https://lists.cip-project.org/mt/72837893=
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


--000000000000e10df805a2a62e52--
