Return-Path: <SRS0=Qjw8=AM=lists.cip-project.org=bounce+64572+4876+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB8DC433DF
	for <cip-dev@archiver.kernel.org>; Wed,  1 Jul 2020 11:56:52 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8511D2067D
	for <cip-dev@archiver.kernel.org>; Wed,  1 Jul 2020 11:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="rK+3GDs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8511D2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mab-labs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4876+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id wI3YYY4521723xyS3GEQmpxw; Wed, 01 Jul 2020 04:56:48 -0700
X-Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
 by mx.groups.io with SMTP id smtpd.web10.19740.1593604606446219030
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Jul 2020 04:56:47 -0700
X-Received: by mail-lj1-f180.google.com with SMTP id f8so14292109ljc.2
        for <cip-dev@lists.cip-project.org>; Wed, 01 Jul 2020 04:56:46 -0700 (PDT)
X-Gm-Message-State: UN9lzZGeiKsm0J50Ffgbk6AYx4520388AA=
X-Google-Smtp-Source: ABdhPJxdr5sgTQ5nD5v1w4ovqLa6jW3zPcFX0ZJJoqI8l/TEa5ldjyftg1eTsxCHnrIkHmAZjjfw5r2yZo/wjXvfdnA=
X-Received: by 2002:a2e:b4b6:: with SMTP id q22mr12058645ljm.53.1593604604457;
 Wed, 01 Jul 2020 04:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <CALkjhPqjz9E22YtzR+QkjmiMRE_w-jQdfgawmAsaZECfSLEgRQ@mail.gmail.com>
 <OSYPR01MB5334D919E8CA6060F4332346D96C0@OSYPR01MB5334.jpnprd01.prod.outlook.com>
In-Reply-To: <OSYPR01MB5334D919E8CA6060F4332346D96C0@OSYPR01MB5334.jpnprd01.prod.outlook.com>
From: "Mohammed Billoo" <mab@mab-labs.com>
Date: Wed, 1 Jul 2020 07:56:33 -0400
Message-ID: <CALkjhPpuc-U2LepVHCdqj=SN8EfgHgRjuiKym-kBhivOmOHAiA@mail.gmail.com>
Subject: Re: [cip-dev] Setting up SWUpdate
To: akihiro27.suzuki@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="22geoBbfOea1j8yUMoKP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593604608;
 bh=LfbEyakieUCUvIp+6OYYl8ddDprc9xBPZ+j+MHU1gn8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=rK+3GDs61ooO5my/Upp7MqRQZ4fjvJtIUv9fd+wEDwoGBuDQAHMoutD88zVyDjfvV4/
 2iEzMGy/Z473ymcgSSUNiw8lDodqB1+OR8cEVRDbbGN311oRnJoCxBuafJfP42Bypj0VY
 +k8aQoYylkAQbpRtI8FPU5WXVxQDLupB6lg=

--22geoBbfOea1j8yUMoKP
Content-Type: multipart/alternative; boundary="0000000000005c82c805a95ffc67"

--0000000000005c82c805a95ffc67
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Suzuki,

I can look into this issue as well (when my BBB comes in). It's focused
enough that I can learn enough about SWUpdate and how it fits into CIP.

Let me know what you think.

Mohammed

On Wed, Jul 1, 2020 at 5:40 AM <akihiro27.suzuki@toshiba.co.jp> wrote:

> Hi Mohammed,
>
>
>
> > NOTE: Now I have a problem with the demo. I=E2=80=99ll make the issue a=
bout it
> in cip-sw-updates-tasks repository later.
>
> I=E2=80=99ve made the issue about it:
> https://gitlab.com/cip-project/cip-sw-updates/cip-sw-updates-tasks/-/issu=
es/14
>
> It might be better to wait for trying cip-sw-updates-demo until the issue
> is resolved.
>
>
>
> Thanks,
> Suzuki
>
>
>
> *From:* suzuki akihiro(=E9=88=B4=E6=9C=A8 =E7=AB=A0=E6=B5=A9 =E2=96=A1=EF=
=BC=B3=EF=BC=B7=EF=BC=A3=E2=97=AF=EF=BC=A1=EF=BC=A3=EF=BC=B4)
> *Sent:* Wednesday, July 1, 2020 2:09 PM
> *To:* Mohammed Billoo <mab@mab-labs.com>
> *Cc:* cip-dev@lists.cip-project.org
> *Subject:* RE: [cip-dev] Setting up SWUpdate
>
>
>
> Hi Mohammed,
>
>
>
> > Should I be using the instructions outlined in
> https://gitlab.com/cip-project/cip-sw-updates/cip-sw-updates-demo to run
> a basic update of the CIP image on a BBB from hawkBit? Can the update
> process be verified using hawkbit and/or the BBB?
>
> Yes, you can verify a basic update process via README.md in
> cip-sw-updates-demo repository.
>
> It uses BBB and hawkBit.
>
> Please let me know if you have a problem about the instructions written i=
n
> the README.md.
>
> NOTE: Now I have a problem with the demo. I=E2=80=99ll make the issue abo=
ut it in
> cip-sw-updates-tasks repository later.
>
>
>
> > Also, there looks to be a patchset to bring in swupdate to cip-core (
> https://patchwork.kernel.org/project/cip-dev/list/?series=3D309741). Shou=
ld
> I wait for this patchset to be approved?
>
> The patchset is for x86 with UEFI to provide updatable secure boot for
> UEFI.
>
> It uses EFI Boot Guard (https://github.com/siemens/efibootguard) instead
> of u-boot.
>
> It will be able to cover the main use cases for software update on device=
s.
>
> Although cip-sw-updates-demo repository doesn=E2=80=99t include the demo =
for x86
> with UEFI at the moment,
>
> you can try basic update features using BBB.
>
>
>
> Thanks,
>
> Suzuki
>
>
>
> *From:* cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> *On
> Behalf Of *Mohammed Billoo
> *Sent:* Wednesday, July 1, 2020 7:49 AM
> *To:* cip-dev@lists.cip-project.org
> *Subject:* [cip-dev] Setting up SWUpdate
>
>
>
> Hello,
>
>
>
> Should I be using the instructions outlined in
> https://gitlab.com/cip-project/cip-sw-updates/cip-sw-updates-demo to run
> a basic update of the CIP image on a BBB from hawkBit? Can the update
> process be verified using hawkbit and/or the BBB?
>
>
>
> Also, there looks to be a patchset to bring in swupdate to cip-core (
> https://patchwork.kernel.org/project/cip-dev/list/?series=3D309741). Shou=
ld
> I wait for this patchset to be approved?
>
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

--0000000000005c82c805a95ffc67
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Suzuki,</div><div><br></div><div>I can look into this=
 issue as well (when my BBB comes in). It&#39;s focused enough that I can l=
earn enough about SWUpdate and how it fits into CIP.</div><div><br></div><d=
iv>Let me know what you think.</div><div><br></div><div>Mohammed<br></div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Wed, Jul 1, 2020 at 5:40 AM &lt;<a href=3D"mailto:akihiro27.suzuki@toshib=
a.co.jp">akihiro27.suzuki@toshiba.co.jp</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">





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
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">&gt; NOTE: Now I have=
 a problem with the demo. I</span><span style=3D"font-size:11pt;font-family=
:=E6=B8=B8=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF">=E2=80=99<span lang=3D"EN-U=
S">ll make the issue about it in cip-sw-updates-tasks repository
 later.<u></u><u></u></span></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">I=E2=80=99ve made the=
 issue about it:
<a href=3D"https://gitlab.com/cip-project/cip-sw-updates/cip-sw-updates-ta=
sks/-/issues/14" target=3D"_blank">
https://gitlab.com/cip-project/cip-sw-updates/cip-sw-updates-tasks/-/issue=
s/14</a><u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">It might be better to=
 wait for trying cip-sw-updates-demo until the issue is resolved.<u></u><u>=
</u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">Thanks,<br>
Suzuki<u></u><u></u></span></p>
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
t-size:11pt;font-family:&quot;Calibri&quot;,sans-serif" lang=3D"EN-US"> suz=
uki akihiro(</span><span style=3D"font-size:11pt">=E9=88=B4=E6=9C=A8</span>=
<span style=3D"font-size:11pt;font-family:&quot;Calibri&quot;,sans-serif">
</span><span style=3D"font-size:11pt">=E7=AB=A0=E6=B5=A9</span><span style=
=
=3D"font-size:11pt;font-family:&quot;Calibri&quot;,sans-serif" lang=3D"EN-=
US"> =E2=96=A1</span><span style=3D"font-size:11pt">=EF=BC=B3=EF=BC=B7=EF=
=BC=A3</span><span style=3D"font-size:11pt;font-family:&quot;Cambria Math&=
quot;,serif" lang=3D"EN-US">=E2=97=AF</span><span style=3D"font-size:11pt">=
=
=EF=BC=A1=EF=BC=A3=EF=BC=B4</span><span style=3D"font-size:11pt;font-famil=
y:&quot;Calibri&quot;,sans-serif" lang=3D"EN-US">)
<br>
<b>Sent:</b> Wednesday, July 1, 2020 2:09 PM<br>
<b>To:</b> Mohammed Billoo &lt;<a href=3D"mailto:mab@mab-labs.com" target=
=3D"_blank">mab@mab-labs.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org" target=3D"_bla=
nk">cip-dev@lists.cip-project.org</a><br>
<b>Subject:</b> RE: [cip-dev] Setting up SWUpdate<u></u><u></u></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">Hi Mohammed,<u></u><u=
></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&gt; Should I be using the ins=
tructions outlined in
<a href=3D"https://gitlab.com/cip-project/cip-sw-updates/cip-sw-updates-de=
mo" target=3D"_blank">https://gitlab.com/cip-project/cip-sw-updates/cip-sw-=
updates-demo</a> to run a basic update of the CIP image on a BBB from hawkB=
it? Can the update process be verified using hawkbit
 and/or the BBB? <u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">Yes, you can verify a=
 basic update process via README.md in cip-sw-updates-demo repository.<u></=
u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">It uses BBB and hawkB=
it.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">Please let me know if=
 you have a problem about the instructions written in the README.md.<u></u>=
<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">NOTE: Now I have a pr=
oblem with the demo. I</span><span style=3D"font-size:11pt;font-family:=E6=
=B8=B8=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF">=E2=80=99<span lang=3D"EN-US">=
ll make the issue about it in cip-sw-updates-tasks repository
 later.<u></u><u></u></span></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&gt; Also, there looks to be a=
 patchset to bring in swupdate to cip-core (<a href=3D"https://patchwork.ke=
rnel.org/project/cip-dev/list/?series=3D309741" target=3D"_blank">https://p=
atchwork.kernel.org/project/cip-dev/list/?series=3D309741</a>).
 Should I wait for this patchset to be approved?<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">The patchset is for x=
86 with UEFI to provide updatable secure boot for UEFI.<u></u><u></u></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">It uses EFI Boot Guar=
d (</span><span lang=3D"EN-US"><a href=3D"https://github.com/siemens/efiboo=
tguard" target=3D"_blank">https://github.com/siemens/efibootguard</a>)
</span><span style=3D"font-size:11pt;font-family:=E6=B8=B8=E3=82=B4=E3=82=
=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">instead of u-boot.<u></u><u></u></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">It will be able to co=
ver the main use cases for software update on devices.<u></u><u></u></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">Although cip-sw-updat=
es-demo repository doesn</span><span style=3D"font-size:11pt;font-family:=
=E6=B8=B8=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF">=E2=80=99<span lang=3D"EN-U=
S">t include the demo for x86 with UEFI at the moment,<u></u><u></u></span>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">you can try basic upd=
ate features using BBB.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">Thanks,<u></u><u></u>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">Suzuki<u></u><u></u><=
/span></p>
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
<b>Sent:</b> Wednesday, July 1, 2020 7:49 AM<br>
<b>To:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org" target=3D"_bla=
nk">cip-dev@lists.cip-project.org</a><br>
<b>Subject:</b> [cip-dev] Setting up SWUpdate<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p=
>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hello,<u></u><u></u></span></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Should I be using the instruct=
ions outlined in
<a href=3D"https://gitlab.com/cip-project/cip-sw-updates/cip-sw-updates-de=
mo" target=3D"_blank">https://gitlab.com/cip-project/cip-sw-updates/cip-sw-=
updates-demo</a> to run a basic update of the CIP image on a BBB from hawkB=
it? Can the update process be verified using hawkbit
 and/or the BBB? <u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Also, there looks to be a patc=
hset to bring in swupdate to cip-core (<a href=3D"https://patchwork.kernel.=
org/project/cip-dev/list/?series=3D309741" target=3D"_blank">https://patchw=
ork.kernel.org/project/cip-dev/list/?series=3D309741</a>). Should
 I wait for this patchset to be approved?<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-- <u></u><u></u></span></p>
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

--0000000000005c82c805a95ffc67--

--22geoBbfOea1j8yUMoKP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4876): https://lists.cip-project.org/g/cip-dev/message=
/4876
Mute This Topic: https://lists.cip-project.org/mt/75224479/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--22geoBbfOea1j8yUMoKP--
