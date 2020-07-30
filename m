Return-Path: <SRS0=tJMA=BJ=lists.cip-project.org=bounce+64572+5075+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0C7C433DF
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 11:35:39 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 319032072A
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 11:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="MSd1QP2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319032072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mab-labs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5075+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rjZDYY4521723x5eIo9cDSVO; Thu, 30 Jul 2020 04:35:38 -0700
X-Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.6275.1596108937262615185
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jul 2020 04:35:37 -0700
X-Received: by mail-pl1-f170.google.com with SMTP id p1so13830888pls.4
        for <cip-dev@lists.cip-project.org>; Thu, 30 Jul 2020 04:35:37 -0700 (PDT)
X-Gm-Message-State: b3YeKENkz5mtUTtfXCGTfmEgx4520388AA=
X-Google-Smtp-Source: ABdhPJxzLj87OxH+bsf5fJL/dARV9fmYHm764POcvrbs25FhiRNLqPxeju7ZEDsOHkaT13CYK1xnTpPjFktDLq1/Sis=
X-Received: by 2002:a62:7e88:: with SMTP id z130mr2994137pfc.14.1596108936631;
 Thu, 30 Jul 2020 04:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <CALkjhPpZKd_qwAJhSdNTND_pLUv1LhnzKzRRRYxLCKP0-e+QpA@mail.gmail.com>
 <OSBPR01MB2053279D1019303875CB7767D0700@OSBPR01MB2053.jpnprd01.prod.outlook.com>
 <CALkjhPpVaLj0um1DVVQaSBG7-i-8z4gcVZ1W0hWVMwLP+BziRA@mail.gmail.com> <OSYPR01MB5334F70BE4557DF466BC12D7D9710@OSYPR01MB5334.jpnprd01.prod.outlook.com>
In-Reply-To: <OSYPR01MB5334F70BE4557DF466BC12D7D9710@OSYPR01MB5334.jpnprd01.prod.outlook.com>
From: "Mohammed Billoo" <mab@mab-labs.com>
Date: Thu, 30 Jul 2020 07:35:18 -0400
Message-ID: <CALkjhPoKEBM=tNcpPHqjQoMTeBd6VBJhpkYj7EFBP7aWnr=b9A@mail.gmail.com>
Subject: Re: [cip-dev] CIP embedded platform Internet connection?
To: akihiro27.suzuki@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="xQ7d4aP0hGSBnjdxVCtY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596108938;
 bh=A/wN+gZo5XdmNQ/0Zmuo4Q/f5SWMKN9TO5a8BSc+r34=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=MSd1QP2qO6YoyiOSX9wLr6bvkdDasCXOeUxqPZkgcHDpdZqU7metefsp06psMVbNRqK
 4InoR/IWr4eeIUz/42ilg/XXRFNHyodTroEo5wRY2KsvjQtfK1H+EGi0NeTTb/ur4xHN7
 PIYOyQN94cTl759oWRPhHY7Tpi1yrn0Clig=

--xQ7d4aP0hGSBnjdxVCtY
Content-Type: multipart/alternative; boundary="00000000000030eb2105aba712a1"

--00000000000030eb2105aba712a1
Content-Type: text/plain; charset="UTF-8"

Hi Suzuki,

Sure. I can make the necessary changes.

Mohammed A Billoo
Founder
MAB Labs, LLC
www.mab-labs.com
201-338-2022

On Thu, Jul 30, 2020, 4:31 AM <akihiro27.suzuki@toshiba.co.jp> wrote:

> Hi Mohammed,
>
>
>
> > I realized that the configuration of the embedded platform and Hawkbit
> server may be specific for the SWUpdate demo. Suzuki-san, is that correct?
>
> Yes. It is specific for the SWUpdate demo.
>
>
>
> > is it OK if these parameters are in files or would you want them in a
> less permanent form (e.g. environment variables)?
>
> If possible, I prefer the latter.
>
> Current cip-sw-updates-demo repository has many inconvenient points.
>
> If you have time, could you fix them?
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
> *Sent:* Thursday, July 30, 2020 9:32 AM
> *To:* cip-dev@lists.cip-project.org
> *Subject:* Re: [cip-dev] CIP embedded platform Internet connection?
>
>
>
> Daniel,
>
>
>
> Thanks for getting back. I realized that the configuration of the embedded
> platform and Hawkbit server may be specific for the SWUpdate demo.
> Suzuki-san, is that correct? If so, is it OK if these parameters are in
> files or would you want them in a less permanent form (e.g. environment
> variables)? The advantage of the latter would be that if I need to change
> the network configuration for my own set up (since my localhost external IP
> is different from what's in the BBB customization), I don't have to manage
> two different network configurations. I can set the appropriate environment
> variable (for example) and the build, if set up correctly, would pick up
> the environment variables and configure the BBB image correctly. Is there
> any strong conviction for either way?
>
>
>
> Thanks
>
> Mohammed A Billoo
> Founder
> MAB Labs, LLC
> www.mab-labs.com
> 201-338-2022
>
>
>
> On Wed, Jul 29, 2020, 7:52 PM Daniel Sangorrin <
> daniel.sangorrin@toshiba.co.jp> wrote:
>
> Hi Mohammed,
>
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Mohammed Billoo
> > This question stems from the thread titled "The security of NTP". If we
> do go with NTS, it looks like we're going to need an Internet
> > connection to the embedded platform. Is that acceptable? The work that
> I've seen so far related to CIP SWUpdate has assumed that the
> > Hawkbit server is on the local network. It isn't obvious if that has
> been an intentional decision (due to security requirements) or just to ease
> > development.
>
> There is nothing in CIP SWUpdate that assumes the Hawkbit server is on a
> local network.
> Perhaps the README is using a local serve for demonstration purposes?
>
> Thanks,
> Daniel
>
>
> --
> Mohammed Billoo
> MAB Labs, LLC
> www.mab-labs.com
>

--00000000000030eb2105aba712a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi Suzuki,</div><div dir=3D"auto"><br></div><div dir=
=
=3D"auto">Sure. I can make the necessary changes.<br><br><div data-smartma=
il=3D"gmail_signature" dir=3D"auto">Mohammed A Billoo<br>Founder<br>MAB Lab=
s, LLC<br><a href=3D"http://www.mab-labs.com">www.mab-labs.com</a><br>201-3=
38-2022</div><br><div class=3D"gmail_quote" dir=3D"auto"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Thu, Jul 30, 2020, 4:31 AM  &lt;<a href=3D"mailto:ak=
ihiro27.suzuki@toshiba.co.jp">akihiro27.suzuki@toshiba.co.jp</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">





<div lang=3D"JA" link=3D"blue" vlink=3D"purple">
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font=
-family:=E6=B8=B8=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF">Hi Mohammed,<u></u><=
u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font=
-family:=E6=B8=B8=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF"><u></u>=C2=A0<u></u>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font=
-family:=E6=B8=B8=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF">&gt; I realized that=
 the configuration of the embedded platform and Hawkbit server may be speci=
fic for the SWUpdate demo. Suzuki-san, is that correct?<u></u><u></u></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font=
-family:=E6=B8=B8=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF">Yes. It is specific =
for the SWUpdate demo.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font=
-family:=E6=B8=B8=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF"><u></u>=C2=A0<u></u>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font=
-family:=E6=B8=B8=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF">&gt; is it OK if the=
se parameters are in files or would you want them in a less permanent form =
(e.g. environment variables)?<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font=
-family:=E6=B8=B8=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF">If possible, I prefe=
r the latter.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font=
-family:=E6=B8=B8=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF">Current cip-sw-updat=
es-demo repository has many inconvenient points.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font=
-family:=E6=B8=B8=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF">If you have time, co=
uld you fix them?<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font=
-family:=E6=B8=B8=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF"><u></u>=C2=A0<u></u>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font=
-family:=E6=B8=B8=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF">Thanks,<u></u><u></u=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font=
-family:=E6=B8=B8=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF">Suzuki<u></u><u></u>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font=
-family:=E6=B8=B8=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF"><u></u>=C2=A0<u></u>=
</span></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;f=
ont-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"EN=
-US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">=
 <a href=3D"mailto:cip-dev@lists.cip-project.org" target=3D"_blank" rel=3D"=
noreferrer">cip-dev@lists.cip-project.org</a> &lt;<a href=3D"mailto:cip-dev=
@lists.cip-project.org" target=3D"_blank" rel=3D"noreferrer">cip-dev@lists.=
cip-project.org</a>&gt;
<b>On Behalf Of </b>Mohammed Billoo<br>
<b>Sent:</b> Thursday, July 30, 2020 9:32 AM<br>
<b>To:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org" target=3D"_bla=
nk" rel=3D"noreferrer">cip-dev@lists.cip-project.org</a><br>
<b>Subject:</b> Re: [cip-dev] CIP embedded platform Internet connection?<u=
></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p=
>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Daniel,<u></u><u></u></span></=
p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks for getting back. I rea=
lized that the configuration of the embedded platform and Hawkbit server ma=
y be specific for the SWUpdate demo. Suzuki-san, is that correct? If so, is=
 it OK if these parameters are in files
 or would you want them in a less permanent form (e.g. environment variabl=
es)? The advantage of the latter would be that if I need to change the netw=
ork configuration for my own set up (since my localhost external IP is diff=
erent from what&#39;s in the BBB customization),
 I don&#39;t have to manage two different network configurations. I can se=
t the appropriate environment variable (for example) and the build, if set =
up correctly, would pick up the environment variables=C2=A0and configure th=
e BBB image correctly. Is there any strong
 conviction for either way?<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p=
>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US"=
>Thanks=C2=A0<u></u><u></u></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Mohammed A Billoo<br>
Founder<br>
MAB Labs, LLC<br>
<a href=3D"http://www.mab-labs.com" target=3D"_blank" rel=3D"noreferrer">w=
ww.mab-labs.com</a><br>
201-338-2022<u></u><u></u></span></p>
</div>
</div>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p=
>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">On Wed, Jul 29, 2020, 7:52 PM =
Daniel Sangorrin &lt;<a href=3D"mailto:daniel.sangorrin@toshiba.co.jp" targ=
et=3D"_blank" rel=3D"noreferrer">daniel.sangorrin@toshiba.co.jp</a>&gt; wro=
te:<u></u><u></u></span></p>
</div>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0=
mm 0mm 0mm 6.0pt;margin-left:4.8pt;margin-right:0mm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US"=
>Hi Mohammed,<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: <a href=3D"mailto:cip-dev@lists.cip-project.org" target=3D"_bla=
nk" rel=3D"noreferrer">cip-dev@lists.cip-project.org</a> &lt;<a href=3D"mai=
lto:cip-dev@lists.cip-project.org" target=3D"_blank" rel=3D"noreferrer">cip=
-dev@lists.cip-project.org</a>&gt; On Behalf Of Mohammed Billoo<br>
&gt; This question stems from the thread titled &quot;The security of NTP&=
quot;. If we do go with NTS, it looks like we&#39;re going to need an Inter=
net<br>
&gt; connection to the embedded platform. Is that acceptable? The work tha=
t I&#39;ve seen so far related to CIP SWUpdate has assumed that the<br>
&gt; Hawkbit server is on the local network. It isn&#39;t obvious if that =
has been an intentional decision (due to security requirements) or just to =
ease<br>
&gt; development.<br>
<br>
There is nothing in CIP SWUpdate that assumes the Hawkbit server is on a l=
ocal network.<br>
Perhaps the README is using a local serve for demonstration purposes?<br>
<br>
Thanks,<br>
Daniel<u></u><u></u></span></p>
</blockquote>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><br>
-- <br>
Mohammed Billoo<br>
MAB Labs, LLC<br>
<a href=3D"http://www.mab-labs.com" target=3D"_blank" rel=3D"noreferrer">w=
ww.mab-labs.com</a> <u></u><u></u></span></p>
</div>
</div>

</blockquote></div></div></div>
<br>-- <br>Mohammed Billoo<br />MAB Labs, LLC<br />www.mab-labs.com

--00000000000030eb2105aba712a1--

--xQ7d4aP0hGSBnjdxVCtY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5075): https://lists.cip-project.org/g/cip-dev/message=
/5075
Mute This Topic: https://lists.cip-project.org/mt/75823534/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--xQ7d4aP0hGSBnjdxVCtY--
