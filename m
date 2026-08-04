Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B323C55822
	for <webhook@archiver.kernel.org>; Tue,  4 Aug 2026 13:42:46 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16587.1785850965203028575
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Aug 2026 06:42:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=Jf1Xz0UH;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=3oJX8tvV;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.220, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1785850958; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TdIcxU8nI6le4edCm+xWKWjdJg22EhgYfGeE2d7HgW16rqNfGs2vbFodJDRc+X76KG
    Nx42OXNNlBrJysWikcryro1OYhAorY56NtFwAF2uJii9VYSTou1NqipSQZ4rSMZ3QQ8o
    VRchRd19AatUC1cuHVv1QLeik/Zsaw0c3EvflydGe7nNifaNn0rxGTziSKvrUltZC5Sq
    gLWW96M9xIaP5LJNdPgglhV82llLgcCUcHWEA5OPB3E3dhNKXhqrndhWlJtwAQ0LpGPm
    vi6gAbM2klbZ5GLxSUgOQOVF0n9Y+ByS44EiPDRR4i2uj+ilheIIAA+voMNoICR81CgU
    BDZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785850958;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=4Y+a9P6uNSxVUkoNnA+X64uI90c8mHa/oseTs5NMyHI=;
    b=WCa7hHnhHcP2OdLurhV2QG6Og/0pXodwoXGA/G7HAGI7eDBGBa6TM/WMBVedgtoQzO
    4wNz0YGlYlIuRc0Ubx056hzcd7AZ+/x+qBOZyPdKYe+VTEX8A5I5NIDVX5QfOYIYP0ar
    5zXP9MNudPCYsrp+FZ5JUQmMN4k0iRNi5/QsCVMyVJVf/FpRS9EjEW4cz+yuoE8UIm1D
    hBYHolgM85reVMcmNt7qXQHGb1aLZdqqyNgJsUh+TRgNUgFBE8BqrohnSoRYXrFU/XfH
    hrbz28gDBl6VTDC6WSZkOqLODKW5SVa9vauT1Z4RAdmDLFw5ORBkOWl6egHgo0JzHQPU
    9yjQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785850958;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=4Y+a9P6uNSxVUkoNnA+X64uI90c8mHa/oseTs5NMyHI=;
    b=Jf1Xz0UHV5xawYgvr0HrRj9e45r0zcwPZA6SH5n78hz7prThtwQ8/JWoArhE/b7h41
    BddzuYZDs4IxcSDnOfzFEnjAZlQTIP6H9Y3B3HeMiKCist4HENUveMKJQUhM2p1tREjv
    JqKZLBurY3EdNtAM0xwo0VR5gi878BfE9ykkpj/GRWWZMPO4dpQoWV1gBv/ax+TJVye7
    F9u3n980+SuCoRhCAVic53m6w/Z5aomP5fAvL6P0isyanNatSBkjm6I96EYZ3LVgNZnO
    WMkIHvYsiVCbEKiXtLM+8eCB7U5Oj4zBcpkwfRwzckl5UEyPVHDYnqDdMh/p1LpGu32h
    XB7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785850958;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=4Y+a9P6uNSxVUkoNnA+X64uI90c8mHa/oseTs5NMyHI=;
    b=3oJX8tvV2ACnqZZvNyHgMGnexVWfV0zDxsd0vVFsYdudTOnWeyRijjClme/MjKMfqR
    T6FHUZGZBU/MJbJeeJCQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKfF+CjmMA=="
Received: from open-xchange-core-mw-gw-16.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.5.6 AUTH)
    with ESMTPSA id zec9ec274DgcBED
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 4 Aug 2026 15:42:38 +0200 (CEST)
Date: Tue, 4 Aug 2026 15:42:38 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: Pavel Machek <pavel@nabladev.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <481365448.888319.1785850958066@webmail.strato.de>
In-Reply-To: <amyxAb4e3E7u7EzE@duo.ucw.cz>
References: <527172097.345263.1785165473174@webmail.strato.de>
 <amyxAb4e3E7u7EzE@duo.ucw.cz>
Subject: Re: Request for review for 4.19-st19, 4.19-cip135
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.152
X-Originating-Port: 45944
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Aug 2026 13:42:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23864


> On 07/31/2026 4:28 PM CEST Pavel Machek <pavel@nabladev.com> wrote:
> > Here are the manual backports for the upcoming 4.19 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-st-rc
> 
> a > 9f05da0b8dcfb Bluetooth: serialize accept_q access
> 
> I can see nothing wrong here, but ... this is quite complex and redoes
> locking. I see quite a lot of bluetooth changes in stable, and we are
> not really testing Bluetooth.

I ran this through a new LLM, and it found two issues, one of which was introduced by me...
Considering everything I think dropping this one is the safest option.

CU
Uli

