Return-Path: <SRS0=idMj=BG=lists.cip-project.org=bounce+64572+5028+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680FAC433DF
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 13:44:22 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 372732078A
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 13:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Sh6piuoH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372732078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mab-labs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5028+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id iNs0YY4521723xfJjWVnHdNk; Mon, 27 Jul 2020 06:44:21 -0700
X-Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web12.55808.1595857460552898467
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2020 06:44:21 -0700
X-Received: by mail-pj1-f46.google.com with SMTP id e22so2275651pjt.3
        for <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2020 06:44:20 -0700 (PDT)
X-Gm-Message-State: oLk7T8riQYuWFpeGMlxmi7nzx4520388AA=
X-Google-Smtp-Source: ABdhPJyhNFR/n1vibhcXW78Vyfq0SyG25h6rOyRNpzrJy5bwAukvPMy3FvjXAk58rkEsnj4m4Fs7/P/twOEZ8zRhWgE=
X-Received: by 2002:a17:90b:1287:: with SMTP id fw7mr2141469pjb.218.1595857459702;
 Mon, 27 Jul 2020 06:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <OSBPR01MB2053682B08257AC2230531FDD0720@OSBPR01MB2053.jpnprd01.prod.outlook.com>
 <7438.1595849548430257093@lists.cip-project.org> <OSBPR01MB20538C134703474587A50658D0720@OSBPR01MB2053.jpnprd01.prod.outlook.com>
 <CALkjhPqeTJQkuz3RPmm0W-xcZBS+xvofWq9R2RYxCpSMZNFVSQ@mail.gmail.com> <OSBPR01MB2053E68E6BB520655A3C7362D0720@OSBPR01MB2053.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB2053E68E6BB520655A3C7362D0720@OSBPR01MB2053.jpnprd01.prod.outlook.com>
From: "Mohammed Billoo" <mab@mab-labs.com>
Date: Mon, 27 Jul 2020 09:44:08 -0400
Message-ID: <CALkjhPo08QOSAg+yjVTmGw7A+nejAPR6CBj6rbZH21Yg=sRfpA@mail.gmail.com>
Subject: Re: [cip-dev] The security of NTP
To: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="KgDGV2LpyiLc1b12gOk1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595857461;
 bh=+OhPHLb9DKc2jx7HgyFT5cVQq5RhBqcrLYhNGABxDIE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Sh6piuoHT9x9HVoWiP9Kg4fwcwl92YIdhjqgMyrjBmgfBAlMDdYT6weACrrcZpkzgmk
 ybfzsLe8r/cQPipgDmrmtH2BktI65uKACsmL7SgoV12KONim9YN7PFFa3ziBGX4vGwxr2
 /VXVnbttekIzepB3Re1sT+0/RoyPgEfvXds=

--KgDGV2LpyiLc1b12gOk1
Content-Type: multipart/alternative; boundary="000000000000ff82ef05ab6c8413"

--000000000000ff82ef05ab6c8413
Content-Type: text/plain; charset="UTF-8"

Cool. I'll check out NTS and I'll just respond in this group with silly
questions as I stumble along (I'm new to CIP and am not a security expert
at all).

On Mon, Jul 27, 2020 at 9:40 AM Daniel Sangorrin <
daniel.sangorrin@toshiba.co.jp> wrote:

> Hi Mohammed
>
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Mohammed Billoo
> > Sent: Monday, July 27, 2020 9:55 PM
> > To: cip-dev@lists.cip-project.org
> > Subject: Re: [cip-dev] The security of NTP
> >
> > Daniel,
> >
> > Thanks for pointing that out. Since CIP is reliant on available packages
> on particular versions of Debian, would the process/workflow then
> > be to wait for tlsdate to be available in Buster and then pull it into
> CIP and continue working on this issue? Or, should I just go ahead and try
> > to get tlsdate incorporated into Buster by following the contribution
> guidelines in Debian?
>
> That would be something that needs to be decided by the whole CIP project,
> but I read that tlsdate depends on a timestamp that has been removed on TLS
> 1.3.
>
> https://www.feistyduck.com/bulletproof-tls-newsletter/issue_54_network_time_security_nts_could_finally_bring_support_for_authenticated_network_time
>
> Personally, I think that CIP should focus on NTS (already included in
> chrony for example)
> https://www.iana.org/assignments/nts/nts.xhtml
>
> Thanks,
> Daniel
>
> > On Mon, Jul 27, 2020 at 8:41 AM Daniel Sangorrin <
> daniel.sangorrin@toshiba.co.jp <mailto:daniel.sangorrin@toshiba.co.jp> >
> wrote:
> >
> >
> >
> >       > -----Original Message-----
> >       > From: cip-dev@lists.cip-project.org <mailto:
> cip-dev@lists.cip-project.org>  <cip-dev@lists.cip-project.org <mailto:
> cip-
> > dev@lists.cip-project.org> > On Behalf Of Mohammed Billoo
> >       > Sent: Monday, July 27, 2020 8:32 PM
> >       > Daniel, Pavel:
> >       >
> >       > Thanks for the feedback. Is tlsdate a better alternative (
> https://github.com/ioerror/tlsdate/)? The only caveat if using tlsdate (or
> > any sort of
> >       > time mechanism that relies on a "well-known" server) is that an
> Internet connection is necessary. It isn't obvious to me whether
> > this is
> >       > acceptable or not. Can someone chime in?
> >
> >       It seems that that project is dead, but there is a fork for
> ChromiumOS remaining that seems to be well maintained (for
> > ChromiumOS)
> >       https://github.com/ioerror/tlsdate/issues/199
> >       https://chromium.googlesource.com/chromiumos/third_party/tlsdate
> >
> >       There are some packages in Debian
> >       https://packages.debian.org/search?keywords=tlsdate
> >       but not for Buster.
> >
> >       Thanks,
> >       Daniel
> >
> >
> >
> >       >
> >       > Thanks
> >       > --
> >       > Mohammed Billoo
> >       > MAB Labs, LLC
> >       > www.mab-labs.com <http://www.mab-labs.com>
> >
> >
> >
> >
> >
> > --
> >
> > Mohammed A Billoo
> > Founder
> > MAB Labs, LLC
> > www.mab-labs.com <http://www.mab-labs.com>
> > 201-338-2022
> >
> >
> > --
> > Mohammed Billoo
> > MAB Labs, LLC
> > www.mab-labs.com
> 
>


-- 
Mohammed A Billoo
Founder
MAB Labs, LLC
www.mab-labs.com
201-338-2022

--000000000000ff82ef05ab6c8413
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Cool. I&#39;ll check out NTS and I&#39;ll just respond in =
this group with silly questions as I stumble along (I&#39;m new to CIP and =
am not a security expert at all).<br></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 27, 2020 at 9:40 AM Daniel=
 Sangorrin &lt;<a href=3D"mailto:daniel.sangorrin@toshiba.co.jp">daniel.san=
gorrin@toshiba.co.jp</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">Hi Mohammed<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: <a href=3D"mailto:cip-dev@lists.cip-project.org" target=3D"_bla=
nk">cip-dev@lists.cip-project.org</a> &lt;<a href=3D"mailto:cip-dev@lists.c=
ip-project.org" target=3D"_blank">cip-dev@lists.cip-project.org</a>&gt; On =
Behalf Of Mohammed Billoo<br>
&gt; Sent: Monday, July 27, 2020 9:55 PM<br>
&gt; To: <a href=3D"mailto:cip-dev@lists.cip-project.org" target=3D"_blank=
">cip-dev@lists.cip-project.org</a><br>
&gt; Subject: Re: [cip-dev] The security of NTP<br>
&gt; <br>
&gt; Daniel,<br>
&gt; <br>
&gt; Thanks for pointing that out. Since CIP is reliant on available packa=
ges on particular versions of Debian, would the process/workflow then<br>
&gt; be to wait for tlsdate to be available in Buster and then pull it int=
o CIP and continue working on this issue? Or, should I just go ahead and tr=
y<br>
&gt; to get tlsdate incorporated into Buster by following the contribution=
 guidelines in Debian?<br>
<br>
That would be something that needs to be decided by the whole CIP project,=
 but I read that tlsdate depends on a timestamp that has been removed on TL=
S 1.3.<br>
<a href=3D"https://www.feistyduck.com/bulletproof-tls-newsletter/issue_54_=
network_time_security_nts_could_finally_bring_support_for_authenticated_net=
work_time" rel=3D"noreferrer" target=3D"_blank">https://www.feistyduck.com/=
bulletproof-tls-newsletter/issue_54_network_time_security_nts_could_finally=
_bring_support_for_authenticated_network_time</a><br>
<br>
Personally, I think that CIP should focus on NTS (already included in chro=
ny for example)<br>
<a href=3D"https://www.iana.org/assignments/nts/nts.xhtml" rel=3D"noreferr=
er" target=3D"_blank">https://www.iana.org/assignments/nts/nts.xhtml</a><br=
>
<br>
Thanks,<br>
Daniel<br>
<br>
&gt; On Mon, Jul 27, 2020 at 8:41 AM Daniel Sangorrin &lt;<a href=3D"mailt=
o:daniel.sangorrin@toshiba.co.jp" target=3D"_blank">daniel.sangorrin@toshib=
a.co.jp</a> &lt;mailto:<a href=3D"mailto:daniel.sangorrin@toshiba.co.jp" ta=
rget=3D"_blank">daniel.sangorrin@toshiba.co.jp</a>&gt; &gt; wrote:<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; -----Original Message-----<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; From: <a href=3D"mailto:cip-dev@lists.=
cip-project.org" target=3D"_blank">cip-dev@lists.cip-project.org</a> &lt;ma=
ilto:<a href=3D"mailto:cip-dev@lists.cip-project.org" target=3D"_blank">cip=
-dev@lists.cip-project.org</a>&gt;=C2=A0 &lt;<a href=3D"mailto:cip-dev@list=
s.cip-project.org" target=3D"_blank">cip-dev@lists.cip-project.org</a> &lt;=
mailto:<a href=3D"mailto:cip-" target=3D"_blank">cip-</a><br>
&gt; <a href=3D"mailto:dev@lists.cip-project.org" target=3D"_blank">dev@li=
sts.cip-project.org</a>&gt; &gt; On Behalf Of Mohammed Billoo<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Sent: Monday, July 27, 2020 8:32 PM<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Daniel, Pavel:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Thanks for the feedback. Is tlsdate a =
better alternative (<a href=3D"https://github.com/ioerror/tlsdate/" rel=3D"=
noreferrer" target=3D"_blank">https://github.com/ioerror/tlsdate/</a>)? The=
 only caveat if using tlsdate (or<br>
&gt; any sort of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; time mechanism that relies on a &quot;=
well-known&quot; server) is that an Internet connection is necessary. It is=
n&#39;t obvious to me whether<br>
&gt; this is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; acceptable or not. Can someone chime i=
n?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0It seems that that project is dead, but the=
re is a fork for ChromiumOS remaining that seems to be well maintained (for=
<br>
&gt; ChromiumOS)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://github.com/ioerror/tlsda=
te/issues/199" rel=3D"noreferrer" target=3D"_blank">https://github.com/ioer=
ror/tlsdate/issues/199</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://chromium.googlesource.co=
m/chromiumos/third_party/tlsdate" rel=3D"noreferrer" target=3D"_blank">http=
s://chromium.googlesource.com/chromiumos/third_party/tlsdate</a><br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0There are some packages in Debian<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://packages.debian.org/sear=
ch?keywords=3Dtlsdate" rel=3D"noreferrer" target=3D"_blank">https://package=
s.debian.org/search?keywords=3Dtlsdate</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0but not for Buster.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Thanks,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Daniel<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Thanks<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; --<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Mohammed Billoo<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; MAB Labs, LLC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; <a href=3D"http://www.mab-labs.com" re=
l=3D"noreferrer" target=3D"_blank">www.mab-labs.com</a> &lt;<a href=3D"http=
://www.mab-labs.com" rel=3D"noreferrer" target=3D"_blank">http://www.mab-la=
bs.com</a>&gt;<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; --<br>
&gt; <br>
&gt; Mohammed A Billoo<br>
&gt; Founder<br>
&gt; MAB Labs, LLC<br>
&gt; <a href=3D"http://www.mab-labs.com" rel=3D"noreferrer" target=3D"_bla=
nk">www.mab-labs.com</a> &lt;<a href=3D"http://www.mab-labs.com" rel=3D"nor=
eferrer" target=3D"_blank">http://www.mab-labs.com</a>&gt;<br>
&gt; 201-338-2022<br>
&gt; <br>
&gt; <br>
&gt; --<br>
&gt; Mohammed Billoo<br>
&gt; MAB Labs, LLC<br>
&gt; <a href=3D"http://www.mab-labs.com" rel=3D"noreferrer" target=3D"_bla=
nk">www.mab-labs.com</a><br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"=
gmail_signature"><div dir=3D"ltr"><div>Mohammed A Billoo</div><div>Founder<=
/div><div>MAB Labs, LLC</div><div><a href=3D"http://www.mab-labs.com" targe=
t=3D"_blank">www.mab-labs.com</a></div><div>201-338-2022<br></div></div></d=
iv>
<br>-- <br>Mohammed Billoo<br />MAB Labs, LLC<br />www.mab-labs.com

--000000000000ff82ef05ab6c8413--

--KgDGV2LpyiLc1b12gOk1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5028): https://lists.cip-project.org/g/cip-dev/message=
/5028
Mute This Topic: https://lists.cip-project.org/mt/75814887/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--KgDGV2LpyiLc1b12gOk1--
