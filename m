Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE49FC00140
	for <webhook@archiver.kernel.org>; Thu, 18 Aug 2022 08:43:10 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [85.215.255.24])
 by mx.groups.io with SMTP id smtpd.web08.39751.1660812184482455282
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Aug 2022 01:43:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=np92I8xM;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.24,
 mailfrom: uli@fpond.eu)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1660812182;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=MqiSSRx1rCeY7nT+ds94ICM8vFLsQJ7J9mkGmm2FSz0=;
    b=np92I8xM42sXttEk3aqOcCFxSQaQmP5zpiEC5Qbfv7Rj961iyO2QkrvY5YyhjOviGA
    hQr4dzVv2vmzFvoa2XOKLtoogi/XCj2IgHD9Esbd06PEr6kezyTe0wWtu/Gnx9cYy0Th
    nZV7P4UYOC2PvpLD8Eo1yRUuqdQv3C0H03N1jwUIWpoFZaDm9P4jDE7qk35ljNmqUAjf
    hBOT7ffeq/5pqPT1OtUmbPUFmc1QVbrEiaZya1L91+SLsBgG8sZfq1knUFcLQQefd8sy
    h59hmWB31Q1XlVLvwuFWLJRhM1NKUGo0VJVFNMC60ZPFdZHLZQi66xvyUm1QfGGoXd+/
    1wTg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGl/w2B/oo="
X-RZG-CLASS-ID: mo00
Received: from oxapp02-05.back.ox.d0m.de
    by smtp-ox.front (RZmta 47.47.0 AUTH)
    with ESMTPSA id 401f7fy7I8h2ABr
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve
 X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 18 Aug 2022 10:43:02 +0200 (CEST)
Date: Thu, 18 Aug 2022 10:43:02 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org,
	Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Message-ID: <280608984.553592.1660812182251@webmail.strato.com>
In-Reply-To: 
 <CAODzB9r+9wpAoNphjgqF8cDjq+BvnPjJ-LxnK3db9JGkAeZ34w@mail.gmail.com>
References: 
 <CAODzB9r+9wpAoNphjgqF8cDjq+BvnPjJ-LxnK3db9JGkAeZ34w@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev22
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Aug 2022 08:43:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9291


> On 08/18/2022 2:44 AM CEST Masami Ichikawa <masami.ichikawa@miraclelinux.com> wrote:
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
> 
>     irc:irc.libera.chat:6667/cip
> 
> The IRC meeting is scheduled to UTC (GMT) 12:00:
> 
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=8&day=4&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248
> 
> USWest    USEast    UK        DE        TW        JP
> 05:00     08:00     13:00     14:00     20:00     21:00
> 
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/07/cip.2022-07-28-12.03.log.html
> 
> * Action items
>   1. Resolve/ignore failures of KernelCI on 4.4-cip - alicefm
>   2. Check cip devices on kernelci old pull request - patersonc
> * Kernel maintenance updates

I might be on the road when today's meeting starts. I'm reviewing 5.10.137 ATM.

CU
Uli

