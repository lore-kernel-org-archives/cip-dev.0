Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8CCEBFD17
	for <webhook@archiver.kernel.org>; Mon, 13 Apr 2026 08:17:40 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.266869.1776068252110967206
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Apr 2026 01:17:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=dH+UDfU0;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=PekD/+s2;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.164, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1776068230; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oEXB64ioSk9BrFBhBmO+Z2YPCqzG64YUp72DiJmVbK+asBdvYtJIY/iyoQMdMGzNo5
    h6IZ0R/1EzMrf1igXRo7lG8bUMgAB+3LSgaxyLjFSmXlglFmKg0KWAygTRg2lYmd0Uiy
    c0c0d0YRRAHStDs4odFUF6OBXJZcg39/inAejrPKs3ykMgZGcltUxDyZ0ZIzehZFMHHC
    xtVZ8a6jiZYajCgB/RkEQ9Uv/9lb4396CCm+bfa+uW+rUyXPnQ3G8GVGD1q7XvlxEJKE
    o3oUneOcv1mcmb522llu9c7eJNPpmh64xQCNM+HQhKiDJlt4rb6uV0rDpcqsfKxoauNL
    45AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1776068230;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=zXjZgvnNykVDEoMrKkrcWOrVoyboLnkI/UDE37JDn3M=;
    b=BkjR0CpLu+6tXniVbLuXmMK1SztZHgxW5CzDO0jWAxO8YaF4nz5QTH/7jvJAGImQW0
    6N6FuOMEKKgBtG7HADgkDgX9zCoP5jQzxy0TYvMiMI3cyevr27/ddJ3mCGZ72uVdA+7/
    QF5AmZjbSPenOswiJo01P1guwWPcgWU3h+KdOGHPQ98YFRH1PWZPUTB1KCbzepatW58m
    XBODczHycimkvOCCkpNfQViIZjzZwyYmp+t8/h3M5LP7BiJNCSAq3JOBQoTmw7gqU/PN
    2FlTfUS/7kIhqkAdiR6/P8jVKM6NJI/G0B8Aaj+u8rUGH9c7xIsRJPkdIFMWZBFZN/d/
    jgAQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1776068230;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=zXjZgvnNykVDEoMrKkrcWOrVoyboLnkI/UDE37JDn3M=;
    b=dH+UDfU0bsoCw/dxLn7SDm8Cetf6046fhdqp1ZBRFvIfCWJDtJ/YRYpkeq8uWmvVhP
    pBJatWPHlzJHKEfhKpTincd1EtEMAnxcxsa1Gt9qbqVHNmYXk8m5scwWkc5g1xqDaIgk
    E9OkBFKzKAzzSedQVJgPHyYwQjZvCoLsVBywDrpI9phoBUt6t+kbhv2vru679Xb1J4LX
    gB8wFdUMCK0vXStu8V/xQaF/0B/LH9cVQN6PmWJ6AxMUV4zoJrrrDOXcU3xlkb8aDatU
    3ZNFv3lA/PGrgKABTLdacW5toc03IE9RFg8wo9uV0lV5U6G4F9cK1eimh3xHyDyGbmx5
    aFxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1776068230;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=zXjZgvnNykVDEoMrKkrcWOrVoyboLnkI/UDE37JDn3M=;
    b=PekD/+s2tPDyni5QqCb32d4m9fBm3F0ojPTA65SxKsR4oWmsYKlRNkRKGvGjGKZRZo
    2dh6EkuugVBoe1b1VCDA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvsX0yGC6oc7j8T9m/7Q=="
Received: from open-xchange-core-mw-gw-10.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z7806e23D8H9VQJ
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 13 Apr 2026 10:17:09 +0200 (CEST)
Date: Mon, 13 Apr 2026 10:17:09 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: jan.kiszka@siemens.com, "Jan Kiszka via lists.cip-project.org"
 <jan.kiszka=siemens.com@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1743542625.76882.1776068229391@webmail.strato.de>
In-Reply-To: <52d1c70f-ac3e-4f4c-9593-c20f08d60e9e@siemens.com>
References: <459507685.15146.1775979436923@webmail.strato.de>
 <52d1c70f-ac3e-4f4c-9593-c20f08d60e9e@siemens.com>
Subject: Re: [cip-dev] [ANNOUNCE] Release v4.19.325-cip131
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.88
X-Originating-Port: 51720
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Apr 2026 08:17:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22677


> On 04/13/2026 7:36 AM CEST Jan Kiszka via lists.cip-project.org <jan.kiszka=siemens.com@lists.cip-project.org> wrote:
> Looks like we are phase-shifted on 4.19 between regular (-cip131) and RT
> (-cip130-rt47) again. Was there a particular reason for timing things
> like this?

The release dates kept slipping towards the end of the month because of large 5.10 releases. 5.10.251 was very small, however, so I used the opportunity to release cip130 early to correct for that, and now try to keep release dates in the first half of the month if possible.

CU
Uli

