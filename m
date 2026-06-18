Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BACCD98ED
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 12:49:48 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18626.1781786986294550522
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jun 2026 05:49:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=P5dSwotG;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=q6F9bozK;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.162, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1781786984; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=daQmLk/UDlxQ3Wz1ybYgMcygS4Fs7GpOpzLEMQ8aY3Nv57dMDlwKf86d91g7spZFk6
    WQmyEM5dBRKwwqljkUKaacl4+7+rBeP5usXNlRKZgPWwEnPcEN7eZizS/SXEpxSo0qu7
    H/7IqgDJsCK6IFwlObWQn3bMvXJvkgZe003ySaJvRIdJHP3+gKkL+k6+vdy/6yiDYPeT
    kplg9blFqDKIGvxKP4+OQixUKlgmCp1M8e8vLXSFpii+qeAtd09AvPfd6Gk7fYadGem2
    lvIPrf71/6sFIYjD6kWxNEbeNwZ72GvIVGELJiKuoaKxjrhYDRa+OJzj64WPH16kFnzr
    zO/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1781786984;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=k8yqAKsfuoM7ydphWmVW3hKi1mZfDL2oJWjrNCuOQBM=;
    b=ZwoEc+V8YmPlzZyswEmyVcrhOdUCAXF2MQss5HDHi3ho5NMQPJ2fc5BA3trUGfU+Qj
    eABVcTMrUtK+eiRfKNcgIA0hswN1elx7OmL9gntD5lo4T//tozW7oI5thM+wD10M8bpw
    easxeWMoLxk9lN7Bf3tPFNINgEk3HnqvjVVvMW4ZtOYNSPfebDYBQxUfs+T+guEJSUzO
    ug3/0UyqkOcsMjtouH2Q+lfh37tLRLftBXHv8FPX8ejpo4+5WroE/rPQckJlv3zJZUUR
    I7oVvT2JFZqBWUxbqpuN5DOVqu2kD5zKShqyvuDSkdA71dj/MLIMsGaMKLgwqUK/2d8R
    jCaw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1781786984;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=k8yqAKsfuoM7ydphWmVW3hKi1mZfDL2oJWjrNCuOQBM=;
    b=P5dSwotGlTdpxE9CtCiLWTHKCz5hE9ofMQUWfHJfT2FpBNv68bhgAfRvy36WcMEk3j
    JebTYq1LEEjxdiB7Xc9R2mrcDYqm/Ob6374QbJ14qauL3iYN63bJ0f8wuFK4L/ynPQvE
    qnoDgrZGDeKISu6nNkhHjaTcy0Ps10OgZx/G3GZSWbChTzqwVGjsQlXxvlxvN3EY7ecG
    XUYgiEpfIQ1abcmybPV29Yawm+Xf34wurgDlxv4A/r710UqoOQwsIjP8GrzcD5ZiM4T7
    ZmgRLuo6pCRFDMQc3vMZEYp4rVGu6U0i6VxDg8PFfvf+u89+Wwb2Rufz/8x5mezjTdTE
    6Rxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1781786984;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=k8yqAKsfuoM7ydphWmVW3hKi1mZfDL2oJWjrNCuOQBM=;
    b=q6F9bozKK3ftKkl1x00AXrspTCdFI+Hj7b74tH5lDPbbbQbezsfj/KOU23rZ2mTmao
    unU7haez5PW0QKujs+AA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKDK+NL2bA=="
Received: from open-xchange-core-mw-gw-4.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z7806e25ICnioc8
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 18 Jun 2026 14:49:44 +0200 (CEST)
Date: Thu, 18 Jun 2026 14:49:44 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: jan.kiszka@siemens.com, cip-dev <cip-dev@lists.cip-project.org>
Message-ID: <1982009719.1087233.1781786984111@webmail.strato.de>
In-Reply-To: <67675b0b-394b-4409-8462-a3bfbca20e6d@siemens.com>
References: <67675b0b-394b-4409-8462-a3bfbca20e6d@siemens.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.142
X-Originating-Port: 48360
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jun 2026 12:49:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23224


> On 06/18/2026 6:59 AM CEST Jan Kiszka via lists.cip-project.org <jan.kiszka=siemens.com@lists.cip-project.org> wrote:
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today.

I noticed too late, sorry. I'm currently working on the next 4.19 and cleaning up the LLM scripts.
I also submitted a talk about LLM patch review for OSS-EU.

CU
Uli

