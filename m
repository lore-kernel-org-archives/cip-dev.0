Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C202AC982CD
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 07:19:19 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34047.1789629547149470134
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 00:19:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=IRjkMlvT;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=y6kGn/Gl;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.161, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1789629545; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=X/E3vufKGKdJN3qfUdXog0OBiFL+b0J7SCvn36vghj/nbxtV0G/wuIRVQP7Y0F+FTb
    bG2OpmHsu3nYhzkHEpO8XKShsJyfukPREHTO5HfIUbWEBWg+DxzEtv6S/CmF0quAZYAp
    946OjfI1AEmg/v9zUfUG6W5eMEdd0gjpqok2FnDZ3zrySlzJSfrFQZriE9JDIjpLZN1N
    OUyFL0HMh7+OZA5IEsAMu9Kj9aboqUHCcvmshXKHeBGKt8gj4ZcsioKkdEEpbb2pNYb+
    3k/gG2ep+9qAhMnibkZk8SJi7d7NJU5QnU3CBdcYpgzjskDnlAwNKvvKDP1qXCKX0OJH
    T6eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1789629545;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:References:In-Reply-To:Subject:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=ZntjHDDCHHTCV7BS0Wlix4vyUju1ToY3qMfosMhx2a0=;
    b=O+9UsUEkas/sMXLaKgNPfarBbpW/G/EPFhR8trY/0Qiu624LDHBAYgwdzdBDMQtc+d
    M5cWp2e8wt2h1iWQ/74xyZKO1l38C0iiDKF3NFR+h3X3XP0TH4GJr9h0AfBLpD/Y3Ixt
    VyJUpFSDGEFn20qYh8ZuuCQ29OQRCG93PdCpWR1Mox1r0Ine7Fjs53nGv26mN1a1UGcs
    8YPN2XNEo2syx9I2w5scuhm1iwgq7OZg+AuSWdChJuFjxVFUWH9BEEtkpiI5AkNNHvVF
    +nzEenwn1jIYK8XI8Kc5S/T8bmd1QS2QswHjPJEyfDt7Hp+1UEjlHj9zKt61Ixawlk7e
    hTdg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1789629545;
    s=strato-dkim-0002; d=fpond.eu;
    h=Message-ID:References:In-Reply-To:Subject:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=ZntjHDDCHHTCV7BS0Wlix4vyUju1ToY3qMfosMhx2a0=;
    b=IRjkMlvTnnKVZjdGMUoup95/iyDMah3ejfULO+ERaAlS2IvFUNwakj5EdnFY7cdBHK
    CFGbtjE/q26XMCiLfgCQUHX/eaY14KsneG59KwDw1wZhnNHa/csA1uU553C+Ez6GBmKx
    O+dWmLYA4h7unDU3QDykMPfcOSpp6ANVB5WgAYPDqdTbd/2+3f9z5iJ2HHbfZuBQtrnj
    hJaxexAau8/n+F1Intgx9yLrjkDuF9TKtgUi9gRtvJykdGHeXMCwQiCbIFerNRmx61zo
    G19HAabkhrlUfM8mnGV8jT1wP5jbVNB/WAWfD1MQ4AwrG2rSMVuo6dLmVMYMTRIWy5sK
    VamA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1789629545;
    s=strato-dkim-0003; d=fpond.eu;
    h=Message-ID:References:In-Reply-To:Subject:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=ZntjHDDCHHTCV7BS0Wlix4vyUju1ToY3qMfosMhx2a0=;
    b=y6kGn/GlT6iGVYQummLYMRkl8Luq8+q39HFkd/Z6AmVpPNIRnH26QeljjGejtMfSx1
    WhXTAwJeyro7jJVdkCAA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73dmm4I5W0/AvA6bOTObvRNvgQolDM"
Received: from ehlo.thunderbird.net
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id ze24d928H7J49y9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 17 Sep 2026 09:19:04 +0200 (CEST)
Date: Thu, 17 Sep 2026 09:19:02 +0200
From: Ulrich Hecht <uli@fpond.eu>
To: jan.kiszka@siemens.com,
 "Jan Kiszka via lists.cip-project.org" <jan.kiszka=siemens.com@lists.cip-project.org>,
 cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
User-Agent: Thunderbird for Android
In-Reply-To: <8ac636e4-e300-4f80-aec7-e32bc880699b@siemens.com>
References: <8ac636e4-e300-4f80-aec7-e32bc880699b@siemens.com>
Message-ID: <2A6B8DC8-5C57-4514-8872-6D3BD27C5DCD@fpond.eu>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary=----SW0JC4363W1Z4RHSW3P242AVS1AR49
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 07:19:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24196

------SW0JC4363W1Z4RHSW3P242AVS1AR49
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

I won't be able to attend today=2E I'm off this week, so there are no updat=
es from me=2E

CU
Uli


On 17 September 2026 08:10:15 CEST, "Jan Kiszka via lists=2Ecip-project=2E=
org" <jan=2Ekiszka=3Dsiemens=2Ecom@lists=2Ecip-project=2Eorg> wrote:
>Hi all,
>
>Kindly be reminded to attend the weekly meeting through IRC to discuss
>technical topics with CIP kernel today=2E Our channel is the following:
>
>    irc:irc=2Elibera=2Echat:6697/cip
>
>The IRC meeting is scheduled to UTC (GMT) 12:00:
>
>https://www=2Etimeanddate=2Ecom/worldclock/meetingdetails=2Ehtml?year=3D2=
026&month=3D9&day=3D17&hour=3D12&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136=
&p4=3D37&p5=3D241&p6=3D248
>
>USWest    USEast    UK        DE        TW        JP
>05:00     08:00     13:00     14:00     20:00     21:00
>
>Last meeting minutes:
>https://ircbot=2Ewl=2Elinuxfoundation=2Eorg/meetings/cip/2026/09/cip=2E20=
26-09-10-12=2E01=2Elog=2Ehtml
>
>* Action items
>* Kernel maintenance updates
>* Kernel release status [*]
>* Kernel testing
>* AOB
>  - SECURITY=2Emd
>  - LLM review tool: updates, feedback
>
>Jan
>
>[*]
>Date the data is created: Thu Sep 17 06:07:43 AM UTC 2026
>linux-4=2E4=2Ey-cip: interval 30 day
>  latest version: v4=2E4=2E302-cip114
>  latest version release date: Wed Aug 19 08:54:45 AM UTC 2026
>  limit date: Fri Sep 18 08:54:45 AM UTC 2026
>  Status: On track
>linux-4=2E4=2Ey-cip-rt: interval 60 day
>  latest version: v4=2E4=2E302-cip113-rt62
>  latest version release date: Thu Jul 30 09:07:13 AM UTC 2026
>  limit date: Mon Sep 28 09:07:13 AM UTC 2026
>  Status: On track
>linux-4=2E19=2Ey-cip: interval 30 day
>  latest version: v4=2E19=2E325-cip136
>  latest version release date: Fri Sep 11 08:53:07 AM UTC 2026
>  limit date: Sun Oct 11 08:53:07 AM UTC 2026
>  Status: On track
>linux-4=2E19=2Ey-cip-rt: interval 60 day
>  latest version: v4=2E19=2E325-cip134-rt49
>  latest version release date: Wed Jul 22 07:47:57 PM UTC 2026
>  limit date: Sun Sep 20 07:47:57 PM UTC 2026
>  Status: On track
>linux-5=2E10=2Ey-cip: interval 30 day
>  latest version: v5=2E10=2E268-cip77
>  latest version release date: Fri Sep 11 06:54:50 AM UTC 2026
>  limit date: Sun Oct 11 06:54:50 AM UTC 2026
>  Status: On track
>linux-5=2E10=2Ey-cip-rt: interval 60 day
>  latest version: v5=2E10=2E260-cip75-rt33
>  latest version release date: Mon Jul 13 07:40:40 AM UTC 2026
>  limit date: Fri Sep 11 07:40:40 AM UTC 2026
>  Status: *Late*
>linux-6=2E1=2Ey-cip: interval 30 day
>  latest version: v6=2E1=2E187-cip60
>  latest version release date: Fri Sep 11 10:35:49 PM UTC 2026
>  limit date: Sun Oct 11 10:35:49 PM UTC 2026
>  Status: On track
>linux-6=2E1=2Ey-cip-rt: interval 60 day
>  latest version: v6=2E1=2E182-cip59-rt31
>  latest version release date: Wed Aug 19 06:16:01 PM UTC 2026
>  limit date: Sun Oct 18 06:16:01 PM UTC 2026
>  Status: On track
>linux-6=2E12=2Ey-cip: interval 15 day
>  latest version: v6=2E12=2E108-cip31
>  latest version release date: Fri Sep  4 12:46:01 PM UTC 2026
>  limit date: Sat Sep 19 12:46:01 PM UTC 2026
>  Status: On track

------SW0JC4363W1Z4RHSW3P242AVS1AR49
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div dir=3D"auto">I won't be able to attend today=
=2E I'm off this week, so there are no updates from me=2E<br><br>CU<br>Uli<=
br></div><br><br><div class=3D"gmail_quote"><div dir=3D"auto">On 17 Septemb=
er 2026 08:10:15 CEST, "Jan Kiszka via lists=2Ecip-project=2Eorg" &lt;jan=
=2Ekiszka=3Dsiemens=2Ecom@lists=2Ecip-project=2Eorg&gt; wrote:</div><blockq=
uote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0=2E8ex; border-lef=
t: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<pre class=3D"net-thunderbird-android__plain-text-message-pre"><div dir=3D=
"auto">Hi all,<br><br>Kindly be reminded to attend the weekly meeting throu=
gh IRC to discuss<br>technical topics with CIP kernel today=2E Our channel =
is the following:<br><br>    irc:irc=2Elibera=2Echat:6697/cip<br><br>The IR=
C meeting is scheduled to UTC (GMT) 12:00:<br><br><a href=3D"https://www=2E=
timeanddate=2Ecom/worldclock/meetingdetails=2Ehtml?year=3D2026&amp;month=3D=
9&amp;day=3D17&amp;hour=3D12&amp;min=3D0&amp;sec=3D0&amp;p1=3D224&amp;p2=3D=
179&amp;p3=3D136&amp;p4=3D37&amp;p5=3D241&amp;p6=3D248">https://www=2Etimea=
nddate=2Ecom/worldclock/meetingdetails=2Ehtml?year=3D2026&amp;month=3D9&amp=
;day=3D17&amp;hour=3D12&amp;min=3D0&amp;sec=3D0&amp;p1=3D224&amp;p2=3D179&a=
mp;p3=3D136&amp;p4=3D37&amp;p5=3D241&amp;p6=3D248</a><br><br>USWest    USEa=
st    UK        DE        TW        JP<br>05:00     08:00     13:00     14:=
00     20:00     21:00<br><br>Last meeting minutes:<br><a href=3D"https://i=
rcbot=2Ewl=2Elinuxfoundation=2Eorg/meetings/cip/2026/09/cip=2E2026-09-10-12=
=2E01=2Elog=2Ehtml">https://ircbot=2Ewl=2Elinuxfoundation=2Eorg/meetings/ci=
p/2026/09/cip=2E2026-09-10-12=2E01=2Elog=2Ehtml</a><br><br>* Action items<b=
r>* Kernel maintenance updates<br>* Kernel release status [*]<br>* Kernel t=
esting<br>* AOB<br>  - SECURITY=2Emd<br>  - LLM review tool: updates, feedb=
ack<br><br>Jan<br><br>[*]<br>Date the data is created: Thu Sep 17 06:07:43 =
AM UTC 2026<br>linux-4=2E4=2Ey-cip: interval 30 day<br>  latest version: v4=
=2E4=2E302-cip114<br>  latest version release date: Wed Aug 19 08:54:45 AM =
UTC 2026<br>  limit date: Fri Sep 18 08:54:45 AM UTC 2026<br>  Status: On t=
rack<br>linux-4=2E4=2Ey-cip-rt: interval 60 day<br>  latest version: v4=2E4=
=2E302-cip113-rt62<br>  latest version release date: Thu Jul 30 09:07:13 AM=
 UTC 2026<br>  limit date: Mon Sep 28 09:07:13 AM UTC 2026<br>  Status: On =
track<br>linux-4=2E19=2Ey-cip: interval 30 day<br>  latest version: v4=2E19=
=2E325-cip136<br>  latest version release date: Fri Sep 11 08:53:07 AM UTC =
2026<br>  limit date: Sun Oct 11 08:53:07 AM UTC 2026<br>  Status: On track=
<br>linux-4=2E19=2Ey-cip-rt: interval 60 day<br>  latest version: v4=2E19=
=2E325-cip134-rt49<br>  latest version release date: Wed Jul 22 07:47:57 PM=
 UTC 2026<br>  limit date: Sun Sep 20 07:47:57 PM UTC 2026<br>  Status: On =
track<br>linux-5=2E10=2Ey-cip: interval 30 day<br>  latest version: v5=2E10=
=2E268-cip77<br>  latest version release date: Fri Sep 11 06:54:50 AM UTC 2=
026<br>  limit date: Sun Oct 11 06:54:50 AM UTC 2026<br>  Status: On track<=
br>linux-5=2E10=2Ey-cip-rt: interval 60 day<br>  latest version: v5=2E10=2E=
260-cip75-rt33<br>  latest version release date: Mon Jul 13 07:40:40 AM UTC=
 2026<br>  limit date: Fri Sep 11 07:40:40 AM UTC 2026<br>  Status: *Late*<=
br>linux-6=2E1=2Ey-cip: interval 30 day<br>  latest version: v6=2E1=2E187-c=
ip60<br>  latest version release date: Fri Sep 11 10:35:49 PM UTC 2026<br> =
 limit date: Sun Oct 11 10:35:49 PM UTC 2026<br>  Status: On track<br>linux=
-6=2E1=2Ey-cip-rt: interval 60 day<br>  latest version: v6=2E1=2E182-cip59-=
rt31<br>  latest version release date: Wed Aug 19 06:16:01 PM UTC 2026<br> =
 limit date: Sun Oct 18 06:16:01 PM UTC 2026<br>  Status: On track<br>linux=
-6=2E12=2Ey-cip: interval 15 day<br>  latest version: v6=2E12=2E108-cip31<b=
r>  latest version release date: Fri Sep  4 12:46:01 PM UTC 2026<br>  limit=
 date: Sat Sep 19 12:46:01 PM UTC 2026<br>  Status: On track<br></div></pre=
></blockquote></div></body></html>
------SW0JC4363W1Z4RHSW3P242AVS1AR49--

