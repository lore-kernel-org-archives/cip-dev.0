Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0CCD14896
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 02:58:40 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23709.1767841114293206114
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 18:58:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=C+x5vWz2;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=wLSPIbmU;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.50, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1767841108; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZplwQZCKRZctpk8oKbH2zEChxda9nadNhtiplgikrQ/qssUZS1yM6VEpiVfuoGf0V0
    KUD7XEu8wIKfL+ilvjO5WRUoxo5JpmeBxRjj/dXUG6zUnYBfhMeJXSB6ErKTQQ3lObm8
    veA8RDQb+KR2Ouy1apa7RZuEgZXqy4XM309Vi1dXaBJevYik+VYyX5KRtm1p+4x6KgpH
    1Yro78lT6FRSm1LKax/O95ppFpLy9qItBRs6RiqyHhHE9g4QdkboLArWm5jLazYM3W2j
    CkmdgDnx/P0wCDJpeACHT7D3DV92Fh61Ohvr7cVQlyDr7AvTwfHL5baMvQyCM9f10nNk
    GGlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767841108;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=x3eQ462Fwh8NwDv6smhStM5X7/lPFEDM7sSWj1JBAZA=;
    b=UHEMdGLQTDlvW7mlnLUNv0DkLVmzIaUdPuwyct3zGWRI+2Um1f16VnApMYPg8aftbh
    ZWrePVVYfk+0TFf8wMNPmS/PSxVWfWaZqu13mGv0NqfkpxzMStdYYlCObHWw9HvowmUJ
    npynaDX5DOvuVc1memltIGkNoFNL4T8RD6bJ+jla0MtC/HNmG02uazSO9MGCpjiZz4+v
    3FojjiXCMSyziTYn6xRDU9BlCXdl9VAKLyi4+KaxQLx5HYb/uTm3RA+5S4wcfT4m+nJI
    LUCkXFzOPSroFgtOpQtHwlJmqkqnskomYgJhrG1Q+tg2sEitWQRXkfqIXbYr6B+zGOaB
    oVBw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767841108;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=x3eQ462Fwh8NwDv6smhStM5X7/lPFEDM7sSWj1JBAZA=;
    b=C+x5vWz2zw6a5GV3B0hMKUfCSC2fZeHsDhy7vDqsotAvbuYGAjvO42MfUnG8V9W5Tm
    uLrALYlc7ToyNzMadCpOxLnAuEaOm2W4qSwKDR/wV1hvdmoTawOoQyXJTyFK9UnrD5/7
    pjEosMO+G4KSNRHAwEPKhQVwdgESDBCBrPCzTihyNk72+t2HCPvpWsJkASzCd16iE3LM
    +2GoopdR3XGgEJQHSVgFQeRqyPlhq9pBLY0Hilj9LceGTkh1L165KTaKs6N2taJpDTWv
    48sxJcBJ4ORqZpfNtvHXiH/3meEumy8DbbLwd1tTrVD71IPdikqCkrN01OMI2uaoZeRz
    78tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767841108;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=x3eQ462Fwh8NwDv6smhStM5X7/lPFEDM7sSWj1JBAZA=;
    b=wLSPIbmUoleqyQlJ8RMq1hPsW5UEG4AGaJhyQ4klBkyFstmbBgaXvTIKdh5BWsVxPu
    4Y50TZ3/SdDt08C7dOBQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRxGvRy6JA=="
Received: from open-xchange-core-mw-gw-33.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 54.1.0 AUTH)
    with ESMTPSA id zfda172082wSVkF
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 8 Jan 2026 03:58:28 +0100 (CET)
Date: Thu, 8 Jan 2026 03:58:28 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	"Nobuhiro Iwamatsu via lists.cip-project.org"
 <nobuhiro.iwamatsu.x90=mail.toshiba@lists.cip-project.org>,
	cip-dev@lists.cip-project.org, pavel@denx.de
Message-ID: <1228347751.426259.1767841108457@webmail.strato.de>
In-Reply-To: <TY7PR01MB14818BAA5CD71ACE6FAAB4236CD84A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <1675394165.12181.1766987804067@webmail.strato.de>
 <TY7PR01MB14818BAA5CD71ACE6FAAB4236CD84A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Subject: Re: [cip-dev] Request for review for 4.4-st71, 4.4-cip106
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.74
X-Originating-Port: 54276
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 02:58:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21430


> On 01/07/2026 1:40 AM CET Nobuhiro Iwamatsu via lists.cip-project.org <nobuhiro.iwamatsu.x90=mail.toshiba@lists.cip-project.org> wrote:
> f0a41ac1bb6fd iio: adc: spear_adc: mask SPEAR_ADC_STATUS channel and avg sample before setting register
> bitfield.h does not provided 4.4.y kernel. Please drop this commit.

Dropped.

> The other commits seem to be fine.

Thanks!

CU
Uli

