Return-Path: <SRS0=GUL1=6E=lists.cip-project.org=bounce+64572+4585+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_KAM_HTML_FONT_INVALID autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCC7C3A5A0
	for <cip-dev@archiver.kernel.org>; Mon, 20 Apr 2020 13:50:50 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687A42070B
	for <cip-dev@archiver.kernel.org>; Mon, 20 Apr 2020 13:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="r4m/tHJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687A42070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4585+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id c72IYY4521723xG3mnZQBMYf; Mon, 20 Apr 2020 06:50:50 -0700
X-Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
 by mx.groups.io with SMTP id smtpd.web11.2306.1587390649260967922
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Apr 2020 06:50:49 -0700
X-Received: by mail-il1-f175.google.com with SMTP id s10so9045584iln.11
        for <cip-dev@lists.cip-project.org>; Mon, 20 Apr 2020 06:50:49 -0700 (PDT)
X-Gm-Message-State: Glp2eNPw7g4nEgph4WAl4qFFx4520388AA=
X-Google-Smtp-Source: APiQypL7iAlTfzPWiOO6bbRPaUmVqOSNTxnTX+mTqkfo0z+PmAFi4rRnxhtPSabxYghrNUm/sYQcRzXTfgnoQm9xV0U=
X-Received: by 2002:a92:7301:: with SMTP id o1mr16210718ilc.104.1587390648631;
 Mon, 20 Apr 2020 06:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAODMxsK_vgo-=FikL1Z2iYXtetRh+KpRJNL4MchmfXvLMqBTUA@mail.gmail.com>
 <CAODMxsJ5anJK+heh9rnWtAsvCCFLhVnm40cffABgG686_312mQ@mail.gmail.com> <CAODMxsKB87WswBCwDHcpaB1TyO6QmTy_vy4qVzdni8OrmEwr7A@mail.gmail.com>
In-Reply-To: <CAODMxsKB87WswBCwDHcpaB1TyO6QmTy_vy4qVzdni8OrmEwr7A@mail.gmail.com>
From: "Neal Caidin" <ncaidin@linuxfoundation.org>
Date: Mon, 20 Apr 2020 09:50:32 -0400
Message-ID: <CAODMxsJSTM1KTziVc2EfwXuS4qJUJ7b0LjpK-_6pcuJR2Yq3cw@mail.gmail.com>
Subject: Re: [cip-dev] Migration complete - Re: Mailman2 to Groups.io reminder
To: cip-board@lists.cip-project.org, cip-members@lists.cip-project.org, 
	cip-security@lists.cip-project.org, cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="r5O4X1H7RVPfg1W5Dso1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1587390650;
 bh=aZxH/bXlOAI5if5Yp2bMQblBnAF/trKV9eG1AP2ZH24=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=r4m/tHJHA9iqtqSdG6oQaZBDuX52RF+8bYDcSh+ShGsROpJUFOeGlyiQG2bLTMtaDUD
 mkd+bVih5Y0aMMZtFcZtmcQUYPinkAryl5ttE6lqod3RwRRlklVLPhhmDcHsoUAkqTQUQ
 0FiZna0uN/MCKxGisr/Rf9UuHrlqdWIMFKI=

--r5O4X1H7RVPfg1W5Dso1
Content-Type: multipart/alternative; boundary="000000000000bb629c05a3b92faf"

--000000000000bb629c05a3b92faf
Content-Type: text/plain; charset="UTF-8"

In the original email (below), the links were incorrect, as I think someone
in the community had pointed out. For the sake of clarity and completeness,
I am reposting with the correct links. Thank you for your patience and
understanding.

Please do NOT unsubscribe from the "main" list. This would unsubscribe you
from all of the CIP lists. "main" is an administrative list used by
Groups.io as a parent list to manage the other lists. Please let me know if
you have any questions or issues.

Lists

https://lists.cip-project.org/g/main



https://lists.cip-project.org/g/cip-board

https://lists.cip-project.org/g/cip-dev

https://lists.cip-project.org/g/cip-testing-results

https://lists.cip-project.org/g/cip-members

https://lists.cip-project.org/g/cip-security



Best regards,


*Neal Caidin*
Program Manager, Program Management & Operations
The Linux Foundation
+1 (919) 238-9104 (w/h)
+1 (919) 949-1861 (m)
ncaidin@linuxfoundation.org


On Mon, Apr 6, 2020 at 5:45 PM Neal Caidin <ncaidin@linuxfoundation.org>
wrote:

> Dear CIP Community,
>
> The migration is complete.
>
> You should receive an email shortly asking you to log in with your email
> address and set a password.
>
> One important note, please do NOT unsubscribe from the "main" list. This
> would unsubscribe you from all of the CIP lists. "main" is an
> administrative list used by Groups.io as a parent list to manage the other
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
>> Reminder.  Mailman2 to Groups.io conversion about to kick off (about an 1
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
>> On Thu, Apr 2, 2020 at 4:56 PM Neal Caidin <ncaidin@linuxfoundation.org>
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
>>> It is expected to take several hours, but could be as much as a full 24
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
>>

--000000000000bb629c05a3b92faf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">In the original email (below), the links were incorrect, a=
s I think someone in the community had pointed out. For the sake of=C2=A0cl=
arity and completeness, I am reposting with the correct links. Thank you fo=
r your patience and understanding.<div><br></div><div>Please do NOT unsubsc=
ribe from the &quot;main&quot; list. This would unsubscribe you from all of=
 the CIP lists. &quot;main&quot; is an administrative list used by Groups.i=
o as a parent list to manage the other lists. Please=C2=A0let=C2=A0me know =
if you have any questions or issues.=C2=A0<br></div><div><br></div><div><di=
v>Lists</div><div dir=3D"ltr"><span id=3D"gmail-m_-2079379806582077348gmail=
-docs-internal-guid-2e999daf-7fff-5982-2a0c-fbd384e1d408"><p dir=3D"ltr" st=
yle=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><a href=3D"https:=
//lists.cip-project.org/g/main" target=3D"_blank" style=3D"text-decoration-=
line:none"><span style=3D"font-size:11pt;font-family:Arial;background-color=
:transparent;font-variant-numeric:normal;font-variant-east-asian:normal;tex=
t-decoration-line:underline;vertical-align:baseline;white-space:pre-wrap">h=
ttps://lists.cip-project.org/g/main</span></a></p><p dir=3D"ltr" style=3D"l=
ine-height:1.38;margin-top:0pt;margin-bottom:0pt">=C2=A0</p><p dir=3D"ltr" =
style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><a href=3D"http=
s://lists.cip-project.org/g/cip-board" target=3D"_blank" style=3D"text-deco=
ration-line:none"><span style=3D"font-size:11pt;font-family:Arial;backgroun=
d-color:transparent;font-variant-numeric:normal;font-variant-east-asian:nor=
mal;text-decoration-line:underline;vertical-align:baseline;white-space:pre-=
wrap">https://lists.cip-project.org/g/cip-board</span></a></p><p dir=3D"ltr=
" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><a href=3D"ht=
tps://lists.cip-project.org/g/cip-dev" target=3D"_blank" style=3D"text-deco=
ration-line:none"><span style=3D"font-size:11pt;font-family:Arial;backgroun=
d-color:transparent;font-variant-numeric:normal;font-variant-east-asian:nor=
mal;text-decoration-line:underline;vertical-align:baseline;white-space:pre-=
wrap">https://lists.cip-project.org/g/cip-dev</span></a></p><p dir=3D"ltr" =
style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><a href=3D"http=
s://lists.cip-project.org/g/cip-testing-results" target=3D"_blank" style=3D=
"text-decoration-line:none"><span style=3D"font-size:11pt;font-family:Arial=
;background-color:transparent;font-variant-numeric:normal;font-variant-east=
-asian:normal;text-decoration-line:underline;vertical-align:baseline;white-=
space:pre-wrap">https://lists.cip-project.org/g/cip-testing-results</span><=
/a></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-botto=
m:0pt"><a href=3D"https://lists.cip-project.org/g/cip-members" target=3D"_b=
lank" style=3D"text-decoration-line:none"><span style=3D"font-size:11pt;fon=
t-family:Arial;background-color:transparent;font-variant-numeric:normal;fon=
t-variant-east-asian:normal;text-decoration-line:underline;vertical-align:b=
aseline;white-space:pre-wrap">https://lists.cip-project.org/g/cip-members</=
span></a></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin=
-bottom:0pt"><span style=3D"text-decoration-line:underline;font-size:11pt;f=
ont-family:Arial;background-color:transparent;font-variant-numeric:normal;f=
ont-variant-east-asian:normal;vertical-align:baseline;white-space:pre-wrap"=
><a href=3D"https://lists.cip-project.org/g/cip-security" target=3D"_blank"=
 style=3D"text-decoration-line:none">https://lists.cip-project.org/g/cip-se=
curity</a></span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0p=
t;margin-bottom:0pt"><br></p><p dir=3D"ltr" style=3D"line-height:1.38;margi=
n-top:0pt;margin-bottom:0pt"><br></p><p style=3D"line-height:1.38;margin-to=
p:0pt;margin-bottom:0pt">Best regards,</p><p style=3D"line-height:1.38;marg=
in-top:0pt;margin-bottom:0pt"><br></p></span></div></div><div><div><div dir=
=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div =
dir=3D"ltr"><div><div dir=3D"ltr"><span><font color=3D"#888888"><div dir=3D=
"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div dir=
=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><b style=3D"color:rgb(136,136,13=
6)"><font color=3D"#666666"><font color=3D"#888888">Neal Caidin</font></fon=
t></b><br><div style=3D"color:rgb(136,136,136)"><span style=3D"border-colla=
pse:collapse"><div><font color=3D"#666666"><font>Program Manager, Program M=
anagement &amp; Operations</font></font></div><div><font color=3D"#666666">=
<font>The Linux Foundation</font></font></div><div><font color=3D"#666666">=
+1 (919) 238-9104 (w/h)<br>+1 (919) 949-1861 (m)</font></div><div><font col=
or=3D"#666666"><a href=3D"mailto:ncaidin@linuxfoundation.org" target=3D"_bl=
ank">ncaidin@linuxfoundation.org</a></font></div></span></div></div></div><=
/div></div></div></div></div></div></div></font></span></div></div></div></=
div></div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Mon, Apr 6, 2020 at 5:45 PM Neal Caidin &lt;<a href=
=3D"mailto:ncaidin@linuxfoundation.org">ncaidin@linuxfoundation.org</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div dir=3D"ltr">Dear CIP Community,</div><div dir=3D"ltr"><br></d=
iv><div dir=3D"ltr">The migration is complete.=C2=A0</div><div dir=3D"ltr">=
<br></div><div dir=3D"ltr">You should receive an email shortly asking you t=
o log in with your email address and set a password.</div><div dir=3D"ltr">=
<br></div><div>One important note, please do NOT unsubscribe from the &quot=
;main&quot; list. This would unsubscribe you from all of the CIP lists. &qu=
ot;main&quot; is an administrative list used by Groups.io as a parent list =
to manage the other lists. Please=C2=A0let=C2=A0me know if you have any que=
stions or issues.=C2=A0</div><div><br></div><div>Lists</div><div dir=3D"ltr=
"><span id=3D"gmail-m_-2079379806582077348gmail-docs-internal-guid-2e999daf=
-7fff-5982-2a0c-fbd384e1d408"><p dir=3D"ltr" style=3D"line-height:1.38;marg=
in-top:0pt;margin-bottom:0pt"><a href=3D"https://lists.cip-project.org/main=
" style=3D"text-decoration-line:none" target=3D"_blank"><span style=3D"font=
-size:11pt;font-family:Arial;background-color:transparent;font-variant-nume=
ric:normal;font-variant-east-asian:normal;text-decoration-line:underline;ve=
rtical-align:baseline;white-space:pre-wrap">https://lists.cip-project.org/m=
ain</span></a></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;m=
argin-bottom:0pt">=C2=A0</p><p dir=3D"ltr" style=3D"line-height:1.38;margin=
-top:0pt;margin-bottom:0pt"><a href=3D"https://lists.cip-project.org/cip-bo=
ard" style=3D"text-decoration-line:none" target=3D"_blank"><span style=3D"f=
ont-size:11pt;font-family:Arial;background-color:transparent;font-variant-n=
umeric:normal;font-variant-east-asian:normal;text-decoration-line:underline=
;vertical-align:baseline;white-space:pre-wrap">https://lists.cip-project.or=
g/cip-board</span></a></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-t=
op:0pt;margin-bottom:0pt"><a href=3D"https://lists.cip-project.org/cip-dev"=
 style=3D"text-decoration-line:none" target=3D"_blank"><span style=3D"font-=
size:11pt;font-family:Arial;background-color:transparent;font-variant-numer=
ic:normal;font-variant-east-asian:normal;text-decoration-line:underline;ver=
tical-align:baseline;white-space:pre-wrap">https://lists.cip-project.org/ci=
p-dev</span></a></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt=
;margin-bottom:0pt"><a href=3D"https://lists.cip-project.org/cip-testing-re=
sults" style=3D"text-decoration-line:none" target=3D"_blank"><span style=3D=
"font-size:11pt;font-family:Arial;background-color:transparent;font-variant=
-numeric:normal;font-variant-east-asian:normal;text-decoration-line:underli=
ne;vertical-align:baseline;white-space:pre-wrap">https://lists.cip-project.=
org/cip-testing-results</span></a></p><p dir=3D"ltr" style=3D"line-height:1=
.38;margin-top:0pt;margin-bottom:0pt"><a href=3D"https://lists.cip-project.=
org/cip-members" style=3D"text-decoration-line:none" target=3D"_blank"><spa=
n style=3D"font-size:11pt;font-family:Arial;background-color:transparent;fo=
nt-variant-numeric:normal;font-variant-east-asian:normal;text-decoration-li=
ne:underline;vertical-align:baseline;white-space:pre-wrap">https://lists.ci=
p-project.org/cip-members</span></a></p><p dir=3D"ltr" style=3D"line-height=
:1.38;margin-top:0pt;margin-bottom:0pt"><a href=3D"https://lists.cip-projec=
t.org/cip-security" style=3D"text-decoration-line:none" target=3D"_blank"><=
span style=3D"font-size:11pt;font-family:Arial;background-color:transparent=
;font-variant-numeric:normal;font-variant-east-asian:normal;text-decoration=
-line:underline;vertical-align:baseline;white-space:pre-wrap">https://lists=
.cip-project.org/cip-security</span></a></p><br><p dir=3D"ltr" style=3D"lin=
e-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:12=
pt;font-family:Arial;color:rgb(29,28,29);font-variant-numeric:normal;font-v=
ariant-east-asian:normal;vertical-align:baseline;white-space:pre-wrap">=C2=
=A0</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margi=
n-bottom:0pt"><span style=3D"font-size:12pt;font-family:Arial;color:rgb(29,=
28,29);font-variant-numeric:normal;font-variant-east-asian:normal;vertical-=
align:baseline;white-space:pre-wrap">Email addresses</span></p><p dir=3D"lt=
r" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><a href=3D"m=
ailto:cip-board@lists.cip-project.org" style=3D"text-decoration-line:none" =
target=3D"_blank"><span style=3D"font-size:11pt;font-family:Arial;backgroun=
d-color:transparent;font-variant-numeric:normal;font-variant-east-asian:nor=
mal;text-decoration-line:underline;vertical-align:baseline;white-space:pre-=
wrap">cip-board@lists.cip-project.org</span></a></p><p dir=3D"ltr" style=3D=
"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><a href=3D"mailto:cip-d=
ev@lists.cip-project.org" style=3D"text-decoration-line:none" target=3D"_bl=
ank"><span style=3D"font-size:11pt;font-family:Arial;background-color:trans=
parent;font-variant-numeric:normal;font-variant-east-asian:normal;text-deco=
ration-line:underline;vertical-align:baseline;white-space:pre-wrap">cip-dev=
@lists.cip-project.org</span></a></p><p dir=3D"ltr" style=3D"line-height:1.=
38;margin-top:0pt;margin-bottom:0pt"><a href=3D"mailto:cip-testing-results@=
lists.cip-project.org" style=3D"text-decoration-line:none" target=3D"_blank=
"><span style=3D"font-size:11pt;font-family:Arial;background-color:transpar=
ent;font-variant-numeric:normal;font-variant-east-asian:normal;text-decorat=
ion-line:underline;vertical-align:baseline;white-space:pre-wrap">cip-testin=
g-results@lists.cip-project.org</span></a></p><p dir=3D"ltr" style=3D"line-=
height:1.38;margin-top:0pt;margin-bottom:0pt"><a href=3D"mailto:cip-members=
@lists.cip-projec.org" style=3D"text-decoration-line:none" target=3D"_blank=
"><span style=3D"font-size:11pt;font-family:Arial;background-color:transpar=
ent;font-variant-numeric:normal;font-variant-east-asian:normal;text-decorat=
ion-line:underline;vertical-align:baseline;white-space:pre-wrap">cip-member=
s@lists.cip-project.org</span></a></p><p dir=3D"ltr" style=3D"line-height:1=
.38;margin-top:0pt;margin-bottom:0pt"><a href=3D"mailto:cip-security@lists.=
cip-project.org" style=3D"text-decoration-line:none" target=3D"_blank"><spa=
n style=3D"font-size:11pt;font-family:Arial;background-color:transparent;fo=
nt-variant-numeric:normal;font-variant-east-asian:normal;text-decoration-li=
ne:underline;vertical-align:baseline;white-space:pre-wrap">cip-security@lis=
ts.cip-project.org</span></a></p></span><br><div><div dir=3D"ltr"><div dir=
=3D"ltr"><div dir=3D"ltr"><span><font color=3D"#888888"><div dir=3D"ltr"><d=
iv dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=
=3D"ltr"><div><b>Best regards,</b></div><div><b>Neal</b></div><div><b><br><=
/b></div><div dir=3D"ltr"><b style=3D"color:rgb(136,136,136)"><font color=
=3D"#666666"><font color=3D"#888888">Neal Caidin</font></font></b><br><div =
style=3D"color:rgb(136,136,136)"><span style=3D"border-collapse:collapse"><=
div><font color=3D"#666666"><font>Program Manager, Program Management &amp;=
 Operations</font></font></div><div><font color=3D"#666666"><font>The Linux=
 Foundation</font></font></div><div><font color=3D"#666666">+1 (919) 238-91=
04 (w/h)<br>+1 (919) 949-1861 (m)</font></div><div><font color=3D"#666666">=
<a href=3D"mailto:ncaidin@linuxfoundation.org" target=3D"_blank">ncaidin@li=
nuxfoundation.org</a></font></div></span></div></div></div></div></div></di=
v></div></div></font></span></div></div></div></div><br></div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 6, 2020=
 at 3:34 PM Neal Caidin &lt;<a href=3D"mailto:ncaidin@linuxfoundation.org" =
target=3D"_blank">ncaidin@linuxfoundation.org</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"l=
tr">Reminder.=C2=A0 Mailman2 to Groups.io conversion about to kick off (abo=
ut an 1 1/2 hours=C2=A0from now).</div><div dir=3D"ltr"><br></div><div dir=
=3D"ltr"><br></div><div dir=3D"ltr">Please see schedule below.</div><div di=
r=3D"ltr"><br></div><div dir=3D"ltr">Best Regards,</div><div>Neal</div><div=
><br></div><div dir=3D"ltr"><div><br></div><div><br clear=3D"all"><div><div=
 dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr"><span><font color=3D"#8=
88888"><div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><b style=3D"co=
lor:rgb(136,136,136)"><font color=3D"#666666"><font color=3D"#888888">Neal =
Caidin</font></font></b><br><div style=3D"color:rgb(136,136,136)"><span sty=
le=3D"border-collapse:collapse"><div><font color=3D"#666666"><font>Program =
Manager, Program Management &amp; Operations</font></font></div><div><font =
color=3D"#666666"><font>The Linux Foundation</font></font></div><div><font =
color=3D"#666666">+1 (919) 238-9104 (w/h)<br>+1 (919) 949-1861 (m)</font></=
div><div><font color=3D"#666666"><a href=3D"mailto:ncaidin@linuxfoundation.=
org" target=3D"_blank">ncaidin@linuxfoundation.org</a></font></div></span><=
/div></div></div></div></div></div></div></div></div></div></font></span></=
div></div></div></div></div><br></div></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 2, 2020 at 4:56 PM Neal C=
aidin &lt;<a href=3D"mailto:ncaidin@linuxfoundation.org" target=3D"_blank">=
ncaidin@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><div dir=3D"ltr">[cross posted]<div><br></div><d=
iv>Reminder.=C2=A0 Mailman2 to Groups.io email is scheduled to start on=C2=
=A0</div><div><br></div><div>Pacific - 2 pm , Monday, April 6</div><div>Eas=
tern - 5 pm, Monday April 6</div><div>CET - 11 pm, Monday April 6</div><div=
>JST - 6 am, Tuesday, April 7</div><div><br></div><div>It is expected to ta=
ke several hours, but could be as much as a full 24 hours.=C2=A0</div><div>=
<br></div><div>When the migration is completed, I will send out the links s=
o that you can access email archives.</div><div><br></div><div>Best regards=
,</div><div>Neal</div><div><br></div><div><br clear=3D"all"><div><div dir=
=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr"><span><font color=3D"#88888=
8"><div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D=
"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><b style=3D"color:=
rgb(136,136,136)"><font color=3D"#666666"><font color=3D"#888888">Neal Caid=
in</font></font></b><br><div style=3D"color:rgb(136,136,136)"><span style=
=3D"border-collapse:collapse"><div><font color=3D"#666666"><font>Program Ma=
nager, Program Management &amp; Operations</font></font></div><div><font co=
lor=3D"#666666"><font>The Linux Foundation</font></font></div><div><font co=
lor=3D"#666666">+1 (919) 238-9104 (w/h)<br>+1 (919) 949-1861 (m)</font></di=
v><div><font color=3D"#666666"><a href=3D"mailto:ncaidin@linuxfoundation.or=
g" target=3D"_blank">ncaidin@linuxfoundation.org</a></font></div></span></d=
iv></div></div></div></div></div></div></div></div></div></font></span></di=
v></div></div></div></div></div></div>
</blockquote></div>
</div>
</blockquote></div></div>
</blockquote></div>

--000000000000bb629c05a3b92faf--

--r5O4X1H7RVPfg1W5Dso1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4585): https://lists.cip-project.org/g/cip-dev/message=
/4585
Mute This Topic: https://lists.cip-project.org/mt/72837893/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--r5O4X1H7RVPfg1W5Dso1--
