Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9242.1793271811938735524
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Oct 2026 04:03:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=AsLaDX4j;
 spf=pass (domain: gmail.com, ip: 209.85.160.181, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53669f7b518so23894121cf.2
        for <cip-dev@lists.cip-project.org>; Thu, 29 Oct 2026 04:03:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793271811; cv=none;
        d=google.com; s=arc-20260327;
        b=lNbiXtrgIUMzGbXr1gKbMd+0owt1xz2x2F8eJVF0VZEHr/LYrYc17028AQ6rvCQ1NI
         5j1erEX7yRz1C6VRGntrYWOURZ9goLO55KthdnogTt09SrBeSb24Vpp/1s/1jlMCu/Cn
         DSwe2Ud03Lkf2pk7P2owhLqJxxI7TPUrPHmLglYUspk6jRl4MDlalATeKMHrp9Lsr3w4
         FOSwTpZ+zwq7+u/jE8m5d4hbfShmsG+fFEWD35S/9jIylOHVVapzUlMmRx9CKqmSD0hP
         KpLOUc3OHAGvu7N97n+KL1DdMCYYzkG//o4BmuqAWtPtQwUwgXBC2gX1KoyijmbaXq1G
         uBCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NRTw4m9MF9oL7aMd/Tf0+HzCCbhUgsizZ7lT1HFGgjo=;
        fh=ktz2l7+dtadX2nTEGtMr+xa6tVraC1agvo0dQVAy7S0=;
        b=YsSLPgKPM9MtjtzsgD3BZorNmAqEF0rFRhO0JKi7VChnl8w6PTBJoqlpArMi41dm6Y
         Uj7GaDnU40qU+AnT/RNM2qBc8rvRpv6F/rnTCy3jhfkp1UKGXg7Zq24gLb1UutEdKVR3
         Jp2HFZSsJ2tLH8KUU88LHfJBrUZ97WRrnzL6xeSTqfBq1DtiKmYb4zu8/uSc8bUsqDTv
         SlcQ/ptdOQ2fEN3zpLSq1w2gV6tBRbn1xqIZFp2tZoGa0jm+cWCJbq4lrDv3cRtQlecd
         jZMKIxrckBqGZHVWRqAweiNMltAxQAt+uvndXsrkWEHh6JLWdNS/c7nHetHv2IZIWrx0
         pzVg==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793271811; x=1793876611; darn=lists.cip-project.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NRTw4m9MF9oL7aMd/Tf0+HzCCbhUgsizZ7lT1HFGgjo=;
        b=AsLaDX4j/wo80VHyTPwC5oZiYURFLSttjJvA8cScGRrijg4S/dIxf+YYhpW93vUgOb
         3hQziv79pcEPEgTffQ1i/DAJtLhz+DglEO2cEKWqmhz5BbsXlDyCL/3xE3Tz0GAy5uZq
         KucvNmYbIBA0r8ijhNIdsAUZ0p31aa5KZg9jbk9QFC3Wmcxxcrx9pPGB/PquhDW7XA6q
         x24OYJgJ5WLXmDhzyUYomcnHQJrQKb85awhoshN91c5EmpLQ4jd3+AKWfsTny/Wj0uis
         Vromnkd7fJeMnYLwwhnSdEVy1zyf18TGdyiAMLxLU48Zlu5DqdoGttCgVEeiE/fRhi8b
         oXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793271811; x=1793876611;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NRTw4m9MF9oL7aMd/Tf0+HzCCbhUgsizZ7lT1HFGgjo=;
        b=tjambFvfjzp/814uIRCxVqxJ3cpQbyQVBMPDcPnMw/9qjCVFigi0Gtwmj/Rgydu4Y+
         6OybpFNAtXTlg6dwk6z6SB/8aFSpOKNBnqETlAIMuEHYn6SHzZhx003Y3GjWv3HsIPlF
         FO8mTjpNCM4lHJdU/cfVbarI2EvIG6T4IoV6F2pgBF73PQrkUMbt3LWqUWdupMaqLi17
         isVHuMzO+/FiXmVyIewPF05Dhbya3IIUxOQdYs899lKVlpwT0ijH/1sDzPMqixKtiZ5V
         EyM1yfEwCzC7gAHRfMVajwKvXN2fvfuPyFbe0jzBK4SEMhxY3fCC46KFIAEx1NdOl8n8
         9JSw==
X-Forwarded-Encrypted: i=1; AKwUvBzG2IV8+dmyA6aEJeNE+3qZ/T78SHQ9ibD8Iv7bxe37oXMdEn9R4cA84KYjO7M3+Ny3nXh1VkQM@lists.cip-project.org
X-Gm-Message-State: AFq9FYKbbVQvG2zJYANRQ0swU4qwjEyjRlRK7KoP3F7NR4RSmCzHi2XO
	EFI504r8Es0IC/lBp4ww8QNzL+HTKf27GSiYWWZXnNTAs1eNMfpTjauPK0GfXklV/5Hg1JiKgmC
	dExzgK37bb2ogbtSS4LUdhsepYZnXu+A=
X-Gm-Gg: AYBFou0NZArbhMFSa0OQCt+QwgNopTXleJ9C4/4NOATxh718GA09vEYbZC48Lvxla12
	Yjr1h5NHmGLQxjL1WrZW1pG3e5Nd+DU/Z9bKuAjyUaU2Ve7lfZEDmp3At8usICCdj6FLyyRXiGc
	xLIcl/jvZtHQT2HmjF3XSLZI29AteRsrWfd9HtrkNF+B6tYgMMtOqn5PLDgpukwV/+rodUqKP4W
	zMTiNAQqGh7xPWz6Wt82O66me9lSpLCdkfBudYZvnf0CnVPGrnjzXwNzPJSvlGJJiT2eTrNy9oh
	dIL03AQXT/TDoXoQ/1k6HIEqF5HzmdSKV7OCn9/vH7OIG/GevzNt/0l6696bHhmjhUIu6q7x6cu
	KsYfdM0t68NsvTf2rznXnTmHCcHMk/FosHw==
X-Received: by 2002:a05:620a:8393:b0:93a:11a4:223c with SMTP id
 af79cd13be357-944089385damr670499185a.9.1793271810770; Thu, 29 Oct 2026
 04:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <TY7PR01MB14818B13FA2A81593C33A4DFCCD6E2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <auMhnCWA5XBg9vln@duo.ucw.cz>
In-Reply-To: <auMhnCWA5XBg9vln@duo.ucw.cz>
From: Nobuhiro Iwamatsu <iwamatsu@gmail.com>
Date: Thu, 29 Oct 2026 20:03:19 +0900
X-Gm-Features: AclHuK9Mbz5LZ_iVrZjz5F4ZdBEvGhQOpDBH2gREEpMaMRYt5v17gkyQmq-UeTg
Message-ID: <CACe6DC4h=wq8f9ryZuXcrSaOMPWaZD_p2A277r=Ayi1Q0ALWYQ@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: pavel@nabladev.com
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 29 Oct 2026 11:03:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24566

Hi Pavel,

Thanks for pointing out.

> > USWest    USEast    UK        DE        TW        JP
> > 05:00     08:00     13:00     14:00     20:00     21:00
>
> Note this is no longer correct. Daylight savings changed, and 12 UTC
> is 13 MET.

USWest    USEast    UK        DE        TW        JP
04:00     07:00     12:00     13:00     20:00     21:00

Is this correct?

Best regards,
  Nobuhiro

2026=E5=B9=B410=E6=9C=8829=E6=97=A5(=E6=9C=A8) 19:36 Pavel Machek via lists=
.cip-project.org
<pavel=3Dnabladev.com@lists.cip-project.org>:
>
> Hi!
>
> Please note changes for Europe.
>
> > Kindly be reminded to attend the weekly meeting through IRC to discuss =
technical topics with CIP kernel today. Our channel is the following:
> >
> >     irc:irc.libera.chat:6697/cip
> >
> > The IRC meeting is scheduled to UTC (GMT) 12:00:
> >
> > https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2026&=
month=3D7&day=3D30&hour=3D12&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=
=3D37&p5=3D241&p6=3D248
> >
> > USWest    USEast    UK        DE        TW        JP
> > 05:00     08:00     13:00     14:00     20:00     21:00
>
> Note this is no longer correct. Daylight savings changed, and 12 UTC
> is 13 MET.
>
> Best regards,
>                                                                         P=
avel
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#24565): https://lists.cip-project.org/g/cip-dev/messa=
ge/24565
> Mute This Topic: https://lists.cip-project.org/mt/121990349/4520494
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [iwamatsu@gmai=
l.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


--=20
Nobuhiro Iwamatsu
