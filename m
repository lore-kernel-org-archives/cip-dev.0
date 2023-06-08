Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46711C7EE29
	for <webhook@archiver.kernel.org>; Thu,  8 Jun 2023 08:58:28 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
 by mx.groups.io with SMTP id smtpd.web11.4571.1686214704943650220
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jun 2023 01:58:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=JKchKsfR;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.24, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1686214701; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sLXueyTjTaCn9LoQLqz9S2TGOIeVeg74t0UiRoksW0pJTY7EqtqDdRWSftiqomsoJG
    U5iO0d+avfeu62+BRbzRpGD4X5si2SMJU/xs2jysW7JuchPTf6nIexlHx+I03ZgbbTMH
    h13MX30bczO6QtLzfie82YOjLwl1SECrbIrCpk+gnlWk2fDzWzzSe0HLo8dky0iQ4ZX7
    49xvmejJL9MquQcctXL+RuemI432+Csgahj4JprNzw4s6zakX7KFRxFbEHzPOO83N4Fc
    +77D6fjcae1np4wk1DkjSkBG6YaBfoA/tFfDnZYz7NTgZJmnYApltUHufPYKtGJD99yY
    mexA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686214701;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=1lCYhk+GbF0nrhmUxZqbgUUItdU8BjJkFK2+smQhCNo=;
    b=I4cybQE35G+MtV7Lv0hg2QBlivS6Qdyz7cWcmmFnAJ/TqEVyh4BXNdvnTY6qY/mWb/
    PQnR/elXIjwUqNpAhI1DXxTQnTy6ahPX/Q2SRckpTjkyG8J9RA5RdU3NSO04atEk/UmD
    CW/I+2De6QAua+j4g5yn8GjXJm/KSzIA7Cn2nkT1THun5qam00kj/QHRfb4EIZhWyRJp
    pryTew4kIcO/LowSHDcBU7zPUuahVsbD2ayFJ4WT5W0CNHuV6SXuAH7vy+dsiaC+kc8r
    ewRuHOoWcyzyVr9tUFFDvg6FI6QdpArwfI19HYFqrLjDN9g7tGyDlsO5KuHBbuD5zb5p
    oRoA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686214701;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=1lCYhk+GbF0nrhmUxZqbgUUItdU8BjJkFK2+smQhCNo=;
    b=JKchKsfRiLe1jOYXD/nkPcsupjRM9bURPe7S0TNd5IKLKn1w5uIWuV+OEllxpXD+nU
    SbtyPKNTJSiKq81vvSFMQ9DvwTWhodumzxoW7rWoYAonOWHsBNzmDU1PD+fSG7smOoV4
    EcxUKYEaSRP9qFkXp2xWq5CkDK1Yxw1aUgwAFKgHbmcnlbAqZfsT7vvy2H6XvwsElYoc
    XkMNfICNlYIBqCs+2Vkos1s96DSuYKbEz05g4F3uUM+FFTXP/l2Imsuu32/3rnGKzrNC
    ACunAkRglVRDuMlkKbop7AK8aDX907uj84PrleiRPjKCHrIWmOdCpP41MwhwWZh+jleN
    RAvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686214701;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=1lCYhk+GbF0nrhmUxZqbgUUItdU8BjJkFK2+smQhCNo=;
    b=eoTqwqMcwpS22AEP6tzieEbIvF29qhHarpY6St9OZ+FhvP3VydpHpxxn8x8pXx13oF
    f0qoIUlbJY+MF9msu6DQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCt/7N+Odk="
Received: from ox-live-app402.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.5.3 AUTH)
    with ESMTPSA id e63bb7z588wLNGR
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 8 Jun 2023 10:58:21 +0200 (CEST)
Date: Thu, 8 Jun 2023 10:58:21 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, "Jan Kiszka via lists.cip-project.org"
 <jan.kiszka=siemens.com@lists.cip-project.org>
Message-ID: <2038026583.3099764.1686214701693@webmail.strato.com>
In-Reply-To: <117e6320-f3b5-633c-98b1-f7f51e1333f3@siemens.com>
References: <117e6320-f3b5-633c-98b1-f7f51e1333f3@siemens.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev43
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jun 2023 08:58:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11930


> On 06/08/2023 8:08 AM CEST Jan Kiszka via lists.cip-project.org <jan.kiszka=siemens.com@lists.cip-project.org> wrote:
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
> 
>     irc:irc.libera.chat:6667/cip
> 
> The IRC meeting is scheduled to UTC (GMT) 12:00:

Unfortunately I won't be able to attend today.
My updates:

> * Kernel maintenance updates

- finally finished 6.1.28 review
- released 4.4

> * Kernel release status
>   - 4.4

4.4-st41 and 4.4.302-cip76 are out.

CU
Uli

