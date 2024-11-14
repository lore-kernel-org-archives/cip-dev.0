Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A96D65C63
	for <webhook@archiver.kernel.org>; Thu, 14 Nov 2024 09:24:08 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
 by mx.groups.io with SMTP id smtpd.web10.33710.1731576237778341474
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Nov 2024 01:23:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=N97410qn;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=+ENiUzYD;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.217, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1731576235; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kgGr1uBi7/swA3M60Tdig7AQfwSnWVN41dB5f11nsB5dWnJvxk/R5ZiOMqApu8T1Ss
    eItQUM/dmD271SvccinquP5YT3Z1J5/jObmxbvVTbn7Ey5ucN2WiJr6BKET0TyO/O8Bg
    Ssh4pztRgl75F2UvrpmKeoMAJxwPxbIjglWgtN2a9o4GUA/W0gr3lKahMfQnObQuGlG+
    vF36syu5+6OfWlERK8dbZIpgPdgZpiKAJtSe9GkdZEuNVzQw64bqfStPJxhmuZlzVm1Q
    hQaf7dmQvm5ULFudnZizYIGI/mxLYOi9vAP47ZmH7fSOD30duyiVi7vC7ZHYVkHkuq+A
    PLBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1731576235;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=4JB5yNgBqMOMLyTSITAHIK1CXAeUpzzo0+7aKnlKt80=;
    b=RC4jSSZRyM0DOilZptDjxoTRopOCHTUTf7/oGK1TE2L6Sv0Clcsq5cFfe43OWcBIhE
    xOBhLYjngAZ9W2YytC0pJowz0SoF5VTLFdxj75jyyeHhbZ9igqcuvwzpLHH3hS/oqxvJ
    itkax3BkqdGt5YW0jLJH1wCizRKg+iE3xU6BkB+1MlZ3pNS/aRZF0zae5GoE3FgT4pBP
    zqXqeaEuGrhknhlFYM2d82bGSiwnubZNQ4Bfka0zZjPkmDcJR+qhQ2Xrqvl+IKuWhTPp
    yzsW/9QtHyDqql0vWDOyibnTGPLJUV118t4Gebmrt8vOeWN6ZHPp+6P+530TkADRH00k
    txnw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1731576235;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=4JB5yNgBqMOMLyTSITAHIK1CXAeUpzzo0+7aKnlKt80=;
    b=N97410qn2bz5hzre9OUMDyswLmFlJT6Xr65D2LeZ3jkt3CSAcN7Yy2/wSDkWcobhWI
    IUyTYIQzB6TI3b+VCcbhnfoxRCipDidU1jm1wcu3uzqLW2xMZCNTPO/GtOf5wIvy4PVK
    +cg4yrxnzte1buIRCljRYD4znGKbukerid6myQxmquRPQGaMZz1LfkyjzezB6CTbhwUY
    uqe1WayW3UFv8/iud9hZLVXtUmVsCVEwNeX0RjdQ58NY5wKsHpN6B9+lRa6YFHMyJxYo
    N9aj7gavzrMe/VmjsX0i4ZETD2smaBmu4wxm6pK72mwWaYpBkB2HjCMPujsY/juRtQhM
    jClQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1731576235;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=4JB5yNgBqMOMLyTSITAHIK1CXAeUpzzo0+7aKnlKt80=;
    b=+ENiUzYDiTu95bXpELGbNiW5frFtcj44q4vD7qqxd+4w7h3ndLrvhvvejG87xTWwCO
    D5dR3+iY++Ssxk1VqJAw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaR1GvtKuIw=="
Received: from ox-live-app405.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.2.11 AUTH)
    with ESMTPSA id z9fbae0AE9Nto87
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 14 Nov 2024 10:23:55 +0100 (CET)
Date: Thu, 14 Nov 2024 10:23:55 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, "Jan Kiszka via lists.cip-project.org"
 <jan.kiszka=siemens.com@lists.cip-project.org>
Message-ID: <541657649.3907720.1731576235768@webmail.strato.de>
In-Reply-To: <401e58c1-1359-43d2-a65e-67e3f9b97c85@siemens.com>
References: <401e58c1-1359-43d2-a65e-67e3f9b97c85@siemens.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev69
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Nov 2024 09:24:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17253


> On 11/14/2024 9:48 AM CET Jan Kiszka via lists.cip-project.org <jan.kiszka=siemens.com@lists.cip-project.org> wrote:
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
> 
>     irc:irc.libera.chat:6667/cip
> 
> The IRC meeting is scheduled to UTC (GMT) 13:00:
> 
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=11&day=14&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248
> 
> USWest    USEast    UK        DE        TW        JP
> 06:00     09:00     13:00     14:00     21:00     22:00
> 
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/11/cip.2024-11-07-13.01.log.html
> 
> * Action items
>   - prepare blog entry on SLTS kernel state and challenges [Jan]
> * Kernel maintenance updates

I probably won't be able to attend today. I just returned from vacation, so there are no updates. I'll take care of the 4.4 release next.

CU
Uli

