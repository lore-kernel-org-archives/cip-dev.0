Return-Path: <SRS0=gEHf=BG=lists.cip-project.org=bounce+64572+5026+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A51C433E0
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 12:54:58 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EB262074F
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 12:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Q8FlOpSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB262074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mab-labs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5026+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 6XGwYY4521723xLscGCwEFA0; Mon, 27 Jul 2020 05:54:58 -0700
X-Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
 by mx.groups.io with SMTP id smtpd.web10.54824.1595854495873791499
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2020 05:54:56 -0700
X-Received: by mail-pf1-f194.google.com with SMTP id f185so4089266pfg.10
        for <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2020 05:54:55 -0700 (PDT)
X-Gm-Message-State: 4vEkQISEIS10l6s1Vs2F41zUx4520388AA=
X-Google-Smtp-Source: ABdhPJwd7z9Axxdl3khaega/dXNU/XZIinsLkSZcMDLQt6ArcAah1XHgU0DIhff4rhG9+sjU3YcGkpJuzmbOCeXavLQ=
X-Received: by 2002:a62:6dc3:: with SMTP id i186mr20017628pfc.104.1595854495023;
 Mon, 27 Jul 2020 05:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <OSBPR01MB2053682B08257AC2230531FDD0720@OSBPR01MB2053.jpnprd01.prod.outlook.com>
 <7438.1595849548430257093@lists.cip-project.org> <OSBPR01MB20538C134703474587A50658D0720@OSBPR01MB2053.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB20538C134703474587A50658D0720@OSBPR01MB2053.jpnprd01.prod.outlook.com>
From: "Mohammed Billoo" <mab@mab-labs.com>
Date: Mon, 27 Jul 2020 08:54:43 -0400
Message-ID: <CALkjhPqeTJQkuz3RPmm0W-xcZBS+xvofWq9R2RYxCpSMZNFVSQ@mail.gmail.com>
Subject: Re: [cip-dev] The security of NTP
To: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="ys7Jp22z98xedO2DQTKf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595854498;
 bh=cFD5kLBgpYPlYrqAcgtDLw8q7ScGYAmpNB1hadv43SQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Q8FlOpSRX17f1NQGR9UvHAqhDZSwJVYSbVC24DFJUSS8Hvp/Z615Lt5REIP3l6QW/mi
 4p+QJPNR1y+p9W6E7ZbJfJ3nh/lv4KXWui16KP5ZSBEbyWXeZzCXAWe08v3WkX4Wm7C7J
 akCLSs3Lgqtovo1SCItLC9zABTrcSODSNIQ=

--ys7Jp22z98xedO2DQTKf
Content-Type: multipart/alternative; boundary="0000000000004a1a4005ab6bd4c5"

--0000000000004a1a4005ab6bd4c5
Content-Type: text/plain; charset="UTF-8"

Daniel,

Thanks for pointing that out. Since CIP is reliant on available packages on
particular versions of Debian, would the process/workflow then be to wait
for tlsdate to be available in Buster and then pull it into CIP and
continue working on this issue? Or, should I just go ahead and try to get
tlsdate incorporated into Buster by following the contribution guidelines
in Debian?

Thanks


On Mon, Jul 27, 2020 at 8:41 AM Daniel Sangorrin <
daniel.sangorrin@toshiba.co.jp> wrote:

>
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Mohammed Billoo
> > Sent: Monday, July 27, 2020 8:32 PM
> > Daniel, Pavel:
> >
> > Thanks for the feedback. Is tlsdate a better alternative (
> https://github.com/ioerror/tlsdate/)? The only caveat if using tlsdate
> (or any sort of
> > time mechanism that relies on a "well-known" server) is that an Internet
> connection is necessary. It isn't obvious to me whether this is
> > acceptable or not. Can someone chime in?
>
> It seems that that project is dead, but there is a fork for ChromiumOS
> remaining that seems to be well maintained (for ChromiumOS)
> https://github.com/ioerror/tlsdate/issues/199
> https://chromium.googlesource.com/chromiumos/third_party/tlsdate
>
> There are some packages in Debian
> https://packages.debian.org/search?keywords=tlsdate
> but not for Buster.
>
> Thanks,
> Daniel
>
>
>
> >
> > Thanks
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

--0000000000004a1a4005ab6bd4c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Daniel,</div><div><br></div><div>Thanks for pointing =
that out. Since CIP is reliant on available packages on particular versions=
 of Debian, would the process/workflow then be to wait for tlsdate to be av=
ailable in Buster and then pull it into CIP and continue working on this is=
sue? Or, should I just go ahead and try to get tlsdate incorporated into Bu=
ster by following the contribution guidelines in Debian?</div><div><br></di=
v><div>Thanks</div><div><br></div></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 27, 2020 at 8:41 AM Daniel Sa=
ngorrin &lt;<a href=3D"mailto:daniel.sangorrin@toshiba.co.jp">daniel.sangor=
rin@toshiba.co.jp</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex"><br>
&gt; -----Original Message-----<br>
&gt; From: <a href=3D"mailto:cip-dev@lists.cip-project.org" target=3D"_bla=
nk">cip-dev@lists.cip-project.org</a> &lt;<a href=3D"mailto:cip-dev@lists.c=
ip-project.org" target=3D"_blank">cip-dev@lists.cip-project.org</a>&gt; On =
Behalf Of Mohammed Billoo<br>
&gt; Sent: Monday, July 27, 2020 8:32 PM<br>
&gt; Daniel, Pavel:<br>
&gt; <br>
&gt; Thanks for the feedback. Is tlsdate a better alternative (<a href=3D"=
https://github.com/ioerror/tlsdate/" rel=3D"noreferrer" target=3D"_blank">h=
ttps://github.com/ioerror/tlsdate/</a>)? The only caveat if using tlsdate (=
or any sort of<br>
&gt; time mechanism that relies on a &quot;well-known&quot; server) is tha=
t an Internet connection is necessary. It isn&#39;t obvious to me whether t=
his is<br>
&gt; acceptable or not. Can someone chime in?<br>
<br>
It seems that that project is dead, but there is a fork for ChromiumOS rem=
aining that seems to be well maintained (for ChromiumOS)<br>
<a href=3D"https://github.com/ioerror/tlsdate/issues/199" rel=3D"noreferre=
r" target=3D"_blank">https://github.com/ioerror/tlsdate/issues/199</a><br>
<a href=3D"https://chromium.googlesource.com/chromiumos/third_party/tlsdat=
e" rel=3D"noreferrer" target=3D"_blank">https://chromium.googlesource.com/c=
hromiumos/third_party/tlsdate</a><br>
<br>
There are some packages in Debian<br>
<a href=3D"https://packages.debian.org/search?keywords=3Dtlsdate" rel=3D"n=
oreferrer" target=3D"_blank">https://packages.debian.org/search?keywords=3D=
tlsdate</a><br>
but not for Buster.<br>
<br>
Thanks,<br>
Daniel <br>
<br>
<br>
<br>
&gt; <br>
&gt; Thanks<br>
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

--0000000000004a1a4005ab6bd4c5--

--ys7Jp22z98xedO2DQTKf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5026): https://lists.cip-project.org/g/cip-dev/message=
/5026
Mute This Topic: https://lists.cip-project.org/mt/75814887/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--ys7Jp22z98xedO2DQTKf--
