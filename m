Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5112CA0ED1
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 15:15:28 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
 by mx.groups.io with SMTP id smtpd.web10.78060.1755530127592587091
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Aug 2025 08:15:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=sww9CZw0;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=JJPsRQES;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.218, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1755530119; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XwjhuLSqUWEDJuD0ZJpuBW8Ps5/8xPB5N619oYE902EvYZR8DQwTr8B5lVVkuWmqpc
    3I9SYM9u4SDM8B4z4qbBT88kOuqXf78z0X/ruAOIN8UDf7EEqTJ0BdAOyyY2hBQEgcz2
    9PCxkTzEpTkNqNUujIuPge3wmK+1OiJjV+zCf/2gDHhWYeK9QN9ZKjiMBJmlNlN1qZK3
    /SHx/zP/Pff3rRdk8FIppyZWkM3IK1izX+IWxI0kmgHHj8652vrQ2AuUYeLXFODitBdS
    A+DYzGMqykn29eBbU486xF79UcTFa3xBJUPRrvmHXgwt8Cv7X6pNDtO0YB04ul3VFJfw
    ahUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1755530119;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=J7woHMo6T9H87gsjZD7iH9sjv77xumOJ33l17iiXBpg=;
    b=FUnTK3O8rRyCpiVav1M9e1TPd1BsSuj7jyJx5quqs+JmVgic/TbFDmtffuDXfycsD/
    zcdvipj2qHWqBclXEvkfuaUwh8wrLKwNUP59KmM4FYBLZtiFhodmDV4izmBNIJ3gMDtl
    otP2c7b4lecakpbOwwOkMDuYsZ14qmWNXpVyluGS8RWpCHCTBRaMoN2fKuIuqE6sC4pO
    pe6Qa4XY5aZmkF8Ywys1td3G17x0vbkbqPel0IOC0J5DjudKSXeRV5iht0PaaetVsaX6
    O34q7XuXNlNZ36WfMYhbmJoIUUq50ghvTJ5iBA1elBkyCkKynTAs5a7APJo73ERcaC52
    yEiw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1755530119;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=J7woHMo6T9H87gsjZD7iH9sjv77xumOJ33l17iiXBpg=;
    b=sww9CZw0CpcumOZXMCJS+VMhTqHmWFebgGWbzdQOmHJIzS+KTxqAyygjir6QDlhNft
    MjnIbeY9gnncmLb61b2VKTW0yS+uB/Qn86k/4j83ersWxE+i+If3xDq86swjB+pfzY63
    mGJQXD83WctGY/NtOJg5qeGXzU7NXchTgp++gd+w01A9VBTdj+MPEGuig10NsHb8VSJA
    v2DbwQN875ZVn6akP67Ye/cNtC1rwQxzVLzY/W5ohEknoe/iBGrNDBShJcPro4qVifGm
    /J3opUnAaSIiqMi3GZVkL9bniL2M/hFMZWnrkd5zkICn0DZg1Ap0MOt0BDgkT3xh4u8H
    tHBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1755530119;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=J7woHMo6T9H87gsjZD7iH9sjv77xumOJ33l17iiXBpg=;
    b=JJPsRQESLAOtgNdtNqH8TYMCnfH9TTozRghF4sUwGNfB02M9wY94ux+UVk0Fd5xx5s
    sm1280LF9HSkba33g5DA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKLG+KwQlg=="
Received: from open-xchange-core-mw-gw-29.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 52.1.2 AUTH)
    with ESMTPSA id z5ff6217IFFJsH3
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 18 Aug 2025 17:15:19 +0200 (CEST)
Date: Mon, 18 Aug 2025 17:15:19 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: pavel@denx.de
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <197709866.83564.1755530119370@webmail.strato.de>
In-Reply-To: <aJ78NuGofKFATgv+@duo.ucw.cz>
References: <2044856947.285232.1755072787301@webmail.strato.de>
 <aJ78NuGofKFATgv+@duo.ucw.cz>
Subject: Re: [cip-dev] Request for review for 4.19-st7 4.19-cip123
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.38.77
X-Originating-Port: 53950
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Aug 2025 15:15:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19752


> On 08/15/2025 11:21 AM CEST Pavel Machek via lists.cip-project.org <pavel=denx.de@lists.cip-project.org> wrote:
> !! > 466ceb3aaec13 tty: serial: uartlite: register uart driver in init
> 
> As far as I can tell:
> 
> ulite_init() is just a cleanup. No real change.
> 
> ulite_exit() simply removes "-if (ulite_uart_driver.state)".
> 
> I don't see how it matches changelog, and not sure how to verify
> this. I'd be inclined to just drop this one.

Dropped, thanks.

CU
Uli

