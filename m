Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB4CEB64DD
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 08:26:08 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
 by mx.groups.io with SMTP id smtpd.web11.182327.1692260757479189638
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Aug 2023 01:25:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=EXEXNfXL;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=ylKSrh2o;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.23, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1692260755; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Z3jc5TTy+Aq5OM72Xxwe8+EdXSkjanzHcZUGr2WCTRn9dpopBnrxmjGw1yY9iqnmn9
    6yc3U6jzv5yHFywBnCS6ErmMN0e5ImtgBHjhgFE1YrcQ3ELapcNMGDfT5u4usTj724Fb
    ek9/c82B4J2NhGbRPzPIeJ3XsXgXtT67K3r2/J7l4JlpaxE8l/qE5xYqsBSKJGb0eqx0
    hK0WRCgnuWRDxKxuYxBvYcOF/Ppep0Vk1iZw7De2YBvbRnqscoSyvXKXXF/+JEBth7hY
    VZ2lyxE8qUdRZ0hW0Y1xXhvfgKmGnkrYSluyZktThsMaZ2ZI5ARZRQ+YA7Z+LrxstptN
    oXeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1692260755;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=xg1cufJMdX7NyWWjPJ7D4wcuh2BMrKr594YtwEEuioU=;
    b=Z8aTyYAWRNJQ8H/gSYKRavo+1cpA9AbPTeNl3SpaWDovBbOAhf1rwlZZeHgK7KF3LF
    Ah44D0pdokyFyjv2IQy2sXoo+dGz7oEhgyiLgcuNp/5rIU9s0U4uufc8QpsMy+7eEXSE
    /bGNgWHpgdmEQtlsEHy50LL8ED/nd5ZHW+KLLAHx3jviDYlmdGm4o1Fb0DaewB3ccAHS
    sEV8aqSXpzGcVIL6ZWRN+a6Qp9GnmqCE2Jx7hIXeKs25bqbgRBTzopwXn+xJFELws3CG
    YNgIVh9RCou3IpAyCUFYcEWPnIL35hS95bKpQd7fgAHhE8O0HxcYSo9979LWUwRZWtlz
    QsCA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1692260755;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=xg1cufJMdX7NyWWjPJ7D4wcuh2BMrKr594YtwEEuioU=;
    b=EXEXNfXL3r0zOhRyn44Zl8rGzSo2O6l0CqkTKztt60aI4PriLlTWwiw7I813gUPDD0
    9j54i/6UlPIrHTINbZOKEjoJXYkfePXSpO0n/f+sYeds+Bw5rUJ3upTsEDAIP2zn5q+K
    vWeQk7oaYnaSeKr8XFF6QNoNb7q7JQSDP1QvUQ+R6fxh1oiBUDmk4MFhoufsaQbepuDE
    yitX1+ov6dofqSZ4fuvIdotOVF3MV2LMj+lQTR2qIYM0tsUb9VASaMUPL/WIFn6DmnRx
    L/5efmeDGnneqlV74LLEe8PUzuHTN9+tP32nj6QDjkgjyujHDSt0UxS6HnfmPG5kGEp+
    RBHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1692260755;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=xg1cufJMdX7NyWWjPJ7D4wcuh2BMrKr594YtwEEuioU=;
    b=ylKSrh2oJFrWe4Jxzb/izgV57eGSpGihueYuexG4DVeXu10nsTYKByyz6mBeD6W/5W
    DB9OtkOLliul781X20Aw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtmYHK6dxNAtycTo="
Received: from ox-live-app304.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.6.6 AUTH)
    with ESMTPSA id mbf131z7H8Pt2Jm
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 17 Aug 2023 10:25:55 +0200 (CEST)
Date: Thu, 17 Aug 2023 10:25:55 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, "Jan Kiszka via lists.cip-project.org"
 <jan.kiszka=siemens.com@lists.cip-project.org>
Message-ID: <962522758.1387605.1692260755664@webmail.strato.com>
In-Reply-To: <77f53f58-41c1-43f1-9fa1-a1f1e0861925@siemens.com>
References: <77f53f58-41c1-43f1-9fa1-a1f1e0861925@siemens.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev49
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Aug 2023 08:26:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12749


> On 08/17/2023 8:04 AM CEST Jan Kiszka via lists.cip-project.org <jan.kiszka=siemens.com@lists.cip-project.org> wrote:
> The IRC meeting is scheduled to UTC (GMT) 12:00:

Unfortunately I won't be able to make it today. My updates:

> * Kernel maintenance updates

reviewing 6.1.45

> * Kernel release status
>   - 4.4

on track, no updates

CU
Uli

