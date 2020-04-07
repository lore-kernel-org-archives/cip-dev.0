Return-Path: <SRS0=oS0j=5X=lists.cip-project.org=bounce+64572+4566+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CC0C2BA2B
	for <cip-dev@archiver.kernel.org>; Tue,  7 Apr 2020 15:40:40 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 957812076E
	for <cip-dev@archiver.kernel.org>; Tue,  7 Apr 2020 15:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="cpRa9U24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957812076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4566+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id K3JqYY4521723xgiJKLU9ntk; Tue, 07 Apr 2020 08:40:40 -0700
X-Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
 by mx.groups.io with SMTP id smtpd.web12.462.1586274039436037941
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Apr 2020 08:40:39 -0700
X-Received: by mail-il1-f172.google.com with SMTP id j9so3636222ilr.7
        for <cip-dev@lists.cip-project.org>; Tue, 07 Apr 2020 08:40:39 -0700 (PDT)
X-Gm-Message-State: oMikqbxOfMzac3HOjIbSNhQ6x4520388AA=
X-Google-Smtp-Source: APiQypJHeAlLzjS6uPVi0K4wIRkTKxGxc2u7omirjDyHUaf2Vn669X5sUjr+5ncSn6I64Bq24Bc2Q5pACI1JusxMe0I=
X-Received: by 2002:a92:d20e:: with SMTP id y14mr3237380ily.104.1586274038723;
 Tue, 07 Apr 2020 08:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAODMxsK_vgo-=FikL1Z2iYXtetRh+KpRJNL4MchmfXvLMqBTUA@mail.gmail.com>
 <CAODMxsJ5anJK+heh9rnWtAsvCCFLhVnm40cffABgG686_312mQ@mail.gmail.com>
 <CAODMxsKB87WswBCwDHcpaB1TyO6QmTy_vy4qVzdni8OrmEwr7A@mail.gmail.com>
 <20200406224358.GC14162@amd.ucw.cz> <874ktwysrj.fsf@kokedama.swc.toshiba.co.jp>
 <03bf3028-3ea5-55fa-cead-861db2f980ed@siemens.com> <20200407151223.5nj4433u3il264zk@chatter.i7.local>
 <eced03e3-465b-2b81-ee43-a78cce6ee35c@siemens.com>
In-Reply-To: <eced03e3-465b-2b81-ee43-a78cce6ee35c@siemens.com>
From: "Neal Caidin" <ncaidin@linuxfoundation.org>
Date: Tue, 7 Apr 2020 11:40:22 -0400
Message-ID: <CAODMxsK7xCTJW4NMTqjn_nZcm8JLEL87w2siTSggymGBxmbhnA@mail.gmail.com>
Subject: Re: [cip-members] [cip-dev] Migration complete - Re: Mailman2 to Groups.io reminder
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Konstantin Ryabitsev <mricon@kernel.org>, cip-members@lists.cip-project.org, 
	Pavel Machek <pavel@ucw.cz>, cip-dev@lists.cip-project.org, 
	cip-board@lists.cip-project.org, cip-security@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="tx7koGcSf91vIinglGSf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1586274040;
 bh=va7WvxNiSOvWkAMPwvLYzcJlgAJdI5cAUgp0f/Cvs4U=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=cpRa9U24z64DDwGIFIQSloouu1oztohYFu0os/Y6NopQUjG1BwIsQAkA41Uao2btlI+
 aBqH+aQZh76btjn60GkJ1cBsrZvKRAIU49IRlvI/cFTBdYlPBPclD0g/op9VaLkXoBZVH
 Pt3ji5MSpt3UgtrRqa+34Mnt8VppKFk29Kg=

--tx7koGcSf91vIinglGSf
Content-Type: multipart/alternative; boundary="00000000000098557205a2b5343b"

--00000000000098557205a2b5343b
Content-Type: text/plain; charset="UTF-8"

Sure!

I just set it for cip-dev . See if that is working now?

Happy to do it for other lists if needed.

-- Neal

*Neal Caidin*
Program Manager, Program Management & Operations
The Linux Foundation
+1 (919) 238-9104 (w/h)
+1 (919) 949-1861 (m)
ncaidin@linuxfoundation.org


On Tue, Apr 7, 2020 at 11:17 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 07.04.20 17:12, Konstantin Ryabitsev wrote:
> > On Tue, Apr 07, 2020 at 08:58:31AM +0200, Jan Kiszka wrote:
> >>
> >> Konstantin, could you have a look or organize help? This is a blocker
> for
> >> us, groups.io must not mess with messages.
> >>
> >> But given that other projects are using this workflow as well, I
> strongly
> >> suspect there is a way to fix it.
> >
> > On each list's "Settings" page there is an option called:
> >
> > Separate Message Footers
> > (Place message footers in a separate MIME part)
> >
> > That's the one you want enabled.
>
> Perfect! Neal, you are admin? Can you change that?
>
> Thanks,
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>

--00000000000098557205a2b5343b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sure!=C2=A0<div><br></div><div>I just set it for cip-dev .=
 See if that is working now?</div><div><br></div><div>Happy to do it for ot=
her lists if needed.</div><div><br></div><div>-- Neal</div><div><br clear=
=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"=
gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><span><font color=
=3D"#888888"><div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><=
div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><b style=
=3D"color:rgb(136,136,136)"><font color=3D"#666666"><font color=3D"#888888"=
>Neal Caidin</font></font></b><br><div style=3D"color:rgb(136,136,136)"><sp=
an style=3D"border-collapse:collapse"><div><font color=3D"#666666"><font>Pr=
ogram Manager, Program Management &amp; Operations</font></font></div><div>=
<font color=3D"#666666"><font>The Linux Foundation</font></font></div><div>=
<font color=3D"#666666">+1 (919) 238-9104 (w/h)<br>+1 (919) 949-1861 (m)</f=
ont></div><div><font color=3D"#666666"><a href=3D"mailto:ncaidin@linuxfound=
ation.org" target=3D"_blank">ncaidin@linuxfoundation.org</a></font></div></=
span></div></div></div></div></div></div></div></div></div></div></font></s=
pan></div></div></div></div></div><br></div></div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 7, 2020 at 11:17 AM=
 Jan Kiszka &lt;<a href=3D"mailto:jan.kiszka@siemens.com">jan.kiszka@siemen=
s.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On 07.04.20 17:12, Konstantin Ryabitsev wrote:<br>
&gt; On Tue, Apr 07, 2020 at 08:58:31AM +0200, Jan Kiszka wrote:<br>
&gt;&gt;<br>
&gt;&gt; Konstantin, could you have a look or organize help? This is a bloc=
ker for<br>
&gt;&gt; us, <a href=3D"http://groups.io" rel=3D"noreferrer" target=3D"_bla=
nk">groups.io</a> must not mess with messages.<br>
&gt;&gt;<br>
&gt;&gt; But given that other projects are using this workflow as well, I s=
trongly<br>
&gt;&gt; suspect there is a way to fix it.<br>
&gt; <br>
&gt; On each list&#39;s &quot;Settings&quot; page there is an option called=
:<br>
&gt; <br>
&gt; Separate Message Footers<br>
&gt; (Place message footers in a separate MIME part)<br>
&gt; <br>
&gt; That&#39;s the one you want enabled.<br>
<br>
Perfect! Neal, you are admin? Can you change that?<br>
<br>
Thanks,<br>
Jan<br>
<br>
-- <br>
Siemens AG, Corporate Technology, CT RDA IOT SES-DE<br>
Corporate Competence Center Embedded Linux<br>
</blockquote></div>

--00000000000098557205a2b5343b--

--tx7koGcSf91vIinglGSf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4566): https://lists.cip-project.org/g/cip-dev/message=
/4566
Mute This Topic: https://lists.cip-project.org/mt/72845465/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--tx7koGcSf91vIinglGSf--
