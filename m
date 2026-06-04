Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EE2CD6E57
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 09:18:21 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7254.1780564699172707146
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Jun 2026 02:18:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=UBTlCBqt;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=hEJNOe1a;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.22, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1780564697; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gmUo8mmSLpLVpqMHft9dhJiZ2dNx9PEuzSpCMP3nM+GrJM/O52VDTupyv6ZSQh0hj5
    sdHh9/+B+y80ZiZ5vyNOPG/oMX3ZUBgSBUSJzVZZiMDczibGNxo2MZq3MgFVvltS/Two
    10Hah5uGYaFeNZFH7bm6an+ElmI2BtgxwPUKEeoSvTHeMuOiWVXGKc4+P1J/sb4AflGb
    UkRF5N9q2aBqx7IPuumM+oWA1+ZDZHWDO+Fx5OijPeKhPmb8B9IdOuMXFURfZmfJHCcr
    SAZRvq9JS7LWRfEcxrFYKHOUf2S9EbFscYqb8hFZlxv8g9NV9wYE7ipRp/kjsIBNtggu
    l8CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1780564697;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=rVI8k4SmJB/45iCBOCiRYAj4whRjqkiGk1GeZw4yEIw=;
    b=CeZsflQpN3s0Z5FoLHmSalDOSKUgiVIsfMMj4raOXfqHo23NgyJmbimFAAP1m96wvu
    y0RAyuYmybq49y4Xebts3LTQhFYNu7Xt7TLWlKUrfUkRAPiDW56gqtQvdff46xcxS2FX
    PZnRO7oVcnd0NuCgIqdJwhDUK7nQd/r0cMGfPX44XkbuhNieVAwol//hO5g/3aMl9G3V
    J8nEEZWaXeeWyqhhKxm+zoJkrLRLr9lbsbav9y9qPpTxkvBFv82BSLlEhZJ7hY5lFmJg
    2rtbHxd3a7Z7T05W9UKVBQ2vEBuDdqUp0SQ6rT1SiprKe9XAw/kzWaW+e0FxRwn2Gs53
    nKrw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1780564697;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=rVI8k4SmJB/45iCBOCiRYAj4whRjqkiGk1GeZw4yEIw=;
    b=UBTlCBqt5kw3o+5AMF55V8W2ODGShPTO+7bgfFqPegYk6NuVjyuC/zsyafEdlbsqFA
    ytMlCMtN0LCjNvbqclzSrHlMWe1ITQKQmFbhqSS25QKIAIqR5m5ESOi5JljnbSK9uIup
    kATl9kZ3gud21C0Epk9K0VP6Ng0MVJ3xChhkbNK0g+VYGpDOKIbzGGADSTQ/qhM1xB2u
    L2ltV6N9g9MYxjkSTI4LFhO5jQAxfnrZ03U6v8l55cPEzQOkSrudpc7yBBMISqZVx1kV
    jAoxcChBIFDijKR4iyFAQwCqzJ/3htkS8VYldseHy8uqvAPA96k3r6fDGAubp1XkXl2S
    OaRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1780564697;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=rVI8k4SmJB/45iCBOCiRYAj4whRjqkiGk1GeZw4yEIw=;
    b=hEJNOe1aVTIvj/Bj8hBdkMvef85ZntJ7SAs3T+oDcw/4pCbNSKW7WTqDp9rbtgLoDb
    yIg3kLFnKFuwrD5kTRCA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKDK+NL2bA=="
Received: from open-xchange-core-mw-gw-13.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z7806e2549IGup3
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 4 Jun 2026 11:18:16 +0200 (CEST)
Date: Thu, 4 Jun 2026 11:18:16 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: lnasby@intwineconnect.com, cip-dev@lists.cip-project.org
Message-ID: <456657683.453228.1780564696890@webmail.strato.de>
In-Reply-To: <CAJ6VbX+9vr3_KsyK59Pr3Nv3g_Tr8yN=ZQ=F78NH_wYxNmoo1w@mail.gmail.com>
References: <CAJ6VbX+9vr3_KsyK59Pr3Nv3g_Tr8yN=ZQ=F78NH_wYxNmoo1w@mail.gmail.com>
Subject: Re: [cip-dev] v4.19.325-cip133 pipeline failure question
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.139
X-Originating-Port: 33718
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Jun 2026 09:18:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23043


> On 06/03/2026 5:07 PM CEST Luke Nasby via lists.cip-project.org <lnasby=
=3Dintwineconnect.com@lists.cip-project.org> wrote:
> I noticed that one of the tests in the=C2=A0pipeline for v4.19.325-cip133=
 shows a failure that seems non-trivial:=C2=A0https://gitlab.com/cip-projec=
t/cip-kernel/linux-cip/-/pipelines/2558173750
>=20
> In particular, it seems like a handful of specific CVE-related tests are =
failing. Is this kernel considered stable for release though? It is quite p=
ossible that I do not understand something related to these failures, but I=
 am just curious to know if I should wait for this to be fixed, or if this =
version is currently safe to include in another project.

We have decided against backporting some speculation-related fixes to 4.4 a=
nd 4.19 due to their complexity and because we consider the vulnerabilities=
 to be outside our threat model. (We assume a trusted userspace.)

These issues will not be fixed in the 4.4 and 4.19 trees, and related test =
failures are ignored in our test pipelines.

Whether these branches are safe to use for your project depends on whether =
you allow execution of untrusted userland code. Generally speaking, if you =
are not already running 4.19-based systems in production we would recommend=
 to use more recent versions.

CU
Uli

