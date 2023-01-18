Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF8EC32793
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 05:57:21 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
 by mx.groups.io with SMTP id smtpd.web11.9368.1674021438049573966
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Jan 2023 21:57:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=GNh+iWbX;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.220, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1674021435; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PjMjFmw0RMuzLXZ6fd9pgeQc+kOUyRL46ZiVor1hT899eVmqaAHLJwmLnK1XnhjpDK
    aWkrkn4AkFLAmZrz7SAkaLFjx76AWKLAY0wQy2YpfZ7xjHEPweKFbyz63gbSrtxl6k+4
    nWyHA5w8sNEdJv/+zzYHqdjLrl/hHgyILKVOw6sVnVLz1gQwpO4AK8+td/ax6urVPd/3
    WcYNZ95645etGoj06YZDQeVYSHnmgoOc4ZQHYr+hjApQQJcdDldmTXLeLgs6+YayfB8m
    lbUeAG6r77DcAq5qmHd4tOEyt+00V5+fdYPQO9aLt7H1z1jxAXrztX6hSIydPBm9x+cH
    gSQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1674021435;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=XpRJf4T6PUWb9wR3tkczWDJ8BihVLEmgRPLebMFcMZs=;
    b=SJB4TA53+vpxocVALeNjJtFE3IFwN6j0SYAua6NH8QMBO1XUhsl86oms6nfG3/SZFS
    9Gu9C3V/o5pQTsw1r9nr08rXt5ryPBy3JCpRvh5wPRJu/6S5XYc9IT24La7B5mY8eku8
    Crh2gSybV5FAZPq2RneMJB8/cmjk72EEr9IsITQYlAQ25av/Dj3SdP0KEEv0WQaZZBlv
    gbUq1+ePea9Z+34zFYLfJ/Uo3AgsksXShW+buTorPHq89smXbFtHcG0TQJYjp9XXdn5c
    dHZKv3BzP7jjQzExT0+m6/8TtkweNcByP2mIKytxotW2jw0vdMdSytU/WklS1RA0pRzA
    vnEg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1674021435;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=XpRJf4T6PUWb9wR3tkczWDJ8BihVLEmgRPLebMFcMZs=;
    b=GNh+iWbXYwjaB5oIICrvhR3gmd7X4eyAipu/AgV9Av46w1XGmZahIp6ZzP29G/fgNf
    wnQUT9JnvhQq9i9WvU0e0F9+JjWvGnA5na/N3IF1d1szjhWkVPW8ulhUJlQNUXnHF6p6
    /YbJUzINamnYEz+nrlDspTMYZ7FvK1drcKD9p6eJ4Wl04JJLty7pHbPBUcN4uc/mEgBg
    lyIAG9VTB2hCUm/davZnvSju4Qic65Gizdrg+ti2EWzbvPcBwO1LJJl/e6kahbWAbp3v
    qgBkNKoN+ZVH3R4YZ7DUnqAfaxF5FjY4qAnSdi1RjlbX9jqKcs6v/ogJSAngAXWdFCYo
    RPzg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCs/83N2Y0="
Received: from ox-live-app103.back.ox.d0m.de
    by smtp-ox.front (RZmta 48.6.2 AUTH)
    with ESMTPSA id x8c991z0I5vEIjE
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Wed, 18 Jan 2023 06:57:14 +0100 (CET)
Date: Wed, 18 Jan 2023 06:57:14 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Message-ID: <1038288592.1739244.1674021434811@webmail.strato.com>
In-Reply-To: <Y8cKLnKsp+jiHUna@duo.ucw.cz>
References: <Y7w4dfYgh7d10IdS@duo.ucw.cz>
 <588609118.480377.1673338487702@webmail.strato.com>
 <Y8cKLnKsp+jiHUna@duo.ucw.cz>
Subject: Re: [cip-dev] 4.4 steps towards release
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev33
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 05:57:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10379


> On 01/17/2023 9:50 PM CET Pavel Machek <pavel@denx.de> wrote:
> And these look okay to me, too.

Thank you very much. I have since included the few remaining patches from the final 4.9.377 release. There is one trivial backport in it that I'm mentioning here for the record:

** m | 0588b12c4 6b0d04 o+ | media: dvb-core: Fix double free in dvb_register_device()

I have also added a fix for CVE-2023-0047 that is in 4.9.291, but for reasons unknown to me wasn't backported to 4.4 before we took over:

39bdf0444b238 mm, oom: do not trigger out_of_memory from the #PF

CU
Uli

