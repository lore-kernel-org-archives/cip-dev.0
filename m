Return-Path: <SRS0=dosz=BJ=lists.cip-project.org=bounce+64572+5054+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD67C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 00:32:17 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 025D220809
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 00:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="CZUyQ25y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025D220809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mab-labs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5054+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jhNPYY4521723xBluuThVMO4; Wed, 29 Jul 2020 17:32:16 -0700
X-Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web12.4188.1596069135008493255
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jul 2020 17:32:15 -0700
X-Received: by mail-pg1-f172.google.com with SMTP id w2so15485006pgg.10
        for <cip-dev@lists.cip-project.org>; Wed, 29 Jul 2020 17:32:14 -0700 (PDT)
X-Gm-Message-State: evOzp45WlTCpIcA0sb44Npn0x4520388AA=
X-Google-Smtp-Source: ABdhPJw5jSVXRFwQKwiksBtLBYmUtVyvbJ2krEzL1Ld8N1ZHdT27F4TfkxsyP4d6CNxSQJQLyFiE+7suaaExk3GluWo=
X-Received: by 2002:a63:7b15:: with SMTP id w21mr33068697pgc.386.1596069134120;
 Wed, 29 Jul 2020 17:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <CALkjhPpZKd_qwAJhSdNTND_pLUv1LhnzKzRRRYxLCKP0-e+QpA@mail.gmail.com>
 <OSBPR01MB2053279D1019303875CB7767D0700@OSBPR01MB2053.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB2053279D1019303875CB7767D0700@OSBPR01MB2053.jpnprd01.prod.outlook.com>
From: "Mohammed Billoo" <mab@mab-labs.com>
Date: Wed, 29 Jul 2020 17:32:03 -0700
Message-ID: <CALkjhPpVaLj0um1DVVQaSBG7-i-8z4gcVZ1W0hWVMwLP+BziRA@mail.gmail.com>
Subject: Re: [cip-dev] CIP embedded platform Internet connection?
To: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="dFPu5E2Jh0PM6lFWbcOl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596069136;
 bh=h7xjCbiciCl0QJN7gQLCvBbIoAaABLM/AWVyK8ba+o0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=CZUyQ25yqMCUIxYtSusU7TpYO/9blz7MaGjtTQzSQZ3PA3tL7S3DObSzrsKUCw/6RG+
 4+Xl4MhqYckWw7N2Uc0esBzkJk3PBfrSfo0espwPEZ1JuZA+edFSg3gL8pjNYn29UBXGR
 GrTsQKdXeLL7RgmqOz8kf8utehauLaZwZJM=

--dFPu5E2Jh0PM6lFWbcOl
Content-Type: multipart/alternative; boundary="000000000000c6caa505ab9dcd14"

--000000000000c6caa505ab9dcd14
Content-Type: text/plain; charset="UTF-8"

Daniel,

Thanks for getting back. I realized that the configuration of the embedded
platform and Hawkbit server may be specific for the SWUpdate demo.
Suzuki-san, is that correct? If so, is it OK if these parameters are in
files or would you want them in a less permanent form (e.g. environment
variables)? The advantage of the latter would be that if I need to change
the network configuration for my own set up (since my localhost external IP
is different from what's in the BBB customization), I don't have to manage
two different network configurations. I can set the appropriate environment
variable (for example) and the build, if set up correctly, would pick up
the environment variables and configure the BBB image correctly. Is there
any strong conviction for either way?

Thanks

Mohammed A Billoo
Founder
MAB Labs, LLC
www.mab-labs.com
201-338-2022

On Wed, Jul 29, 2020, 7:52 PM Daniel Sangorrin <
daniel.sangorrin@toshiba.co.jp> wrote:

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

--000000000000c6caa505ab9dcd14
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"auto">Daniel,<div dir=3D"auto"><br></div><div =
dir=3D"auto">Thanks for getting back. I realized that the configuration of =
the embedded platform and Hawkbit server may be specific for the SWUpdate d=
emo. Suzuki-san, is that correct? If so, is it OK if these parameters are i=
n files or would you want them in a less permanent form (e.g. environment v=
ariables)? The advantage of the latter would be that if I need to change th=
e network configuration for my own set up (since my localhost external IP i=
s different from what&#39;s in the BBB customization), I don&#39;t have to =
manage two different network configurations. I can set the appropriate envi=
ronment variable (for example) and the build, if set up correctly, would pi=
ck up the environment variables=C2=A0and configure the BBB image correctly.=
 Is there any strong conviction for either way?</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">Thanks=C2=A0<br><br><div data-smartmail=3D"gmail_si=
gnature" dir=3D"auto">Mohammed A Billoo<br>Founder<br>MAB Labs, LLC<br><a h=
ref=3D"http://www.mab-labs.com" target=3D"_blank">www.mab-labs.com</a><br>2=
01-338-2022</div></div></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Jul 29, 2020, 7:52 PM Daniel Sangorr=
in &lt;<a href=3D"mailto:daniel.sangorrin@toshiba.co.jp" target=3D"_blank">=
daniel.sangorrin@toshiba.co.jp</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">Hi Mohammed,<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: <a href=3D"mailto:cip-dev@lists.cip-project.org" rel=3D"norefer=
rer" target=3D"_blank">cip-dev@lists.cip-project.org</a> &lt;<a href=3D"mai=
lto:cip-dev@lists.cip-project.org" rel=3D"noreferrer" target=3D"_blank">cip=
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
Daniel<br>
<br>
</blockquote></div>
<br>-- <br>Mohammed Billoo<br />MAB Labs, LLC<br />www.mab-labs.com

--000000000000c6caa505ab9dcd14--

--dFPu5E2Jh0PM6lFWbcOl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5054): https://lists.cip-project.org/g/cip-dev/message=
/5054
Mute This Topic: https://lists.cip-project.org/mt/75823534/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--dFPu5E2Jh0PM6lFWbcOl--
