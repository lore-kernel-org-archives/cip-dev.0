Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C411C3DA6E
	for <webhook@archiver.kernel.org>; Thu,  4 Jan 2024 03:05:19 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
 by mx.groups.io with SMTP id smtpd.web11.46390.1704337514002940576
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jan 2024 19:05:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=Xf4uzjNb;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=MO8QclmW;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.217, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1704337489; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NANSFvOTkxRJYkbdw88tOIQtBEMFjG0FI86pR+FVG2NEkjNJRNdIbWbdU87KJKSLg/
    mAgZ89ZKRvYDs1tBeggc31wHmW+wyOZwJSLZX2Jh60MtfhaQyC+sSbjtkxg01L//0TJW
    1UBKXXARUpZVderbylIfjrmzpr8ddrqpMGsddGBWxdGMepVDjL9YE4+9p+iXxtzYbFcj
    RLQ0MKkvYctCeNQbGor9FjKw20XojWZV/99wcsYIXrq4F14rIVdiU0KlERt/wsbtFCTs
    ZlHckcxrUCQ/DHvfO4MGET5ekSHopwrtbVBd+IA13ecVvwssK9wI9bk7vsmmx9GwAxrl
    ChmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1704337489;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=hB1plfuROvN5RjojzvhDfZ00BtchBrfYATPvTHyaElg=;
    b=om6k10yK5SECgfYLQf0qMPix7yNIxwLVuvsx/tZ58oqQxFvSdI115CmgCBg5n0AiwV
    uHGnP6c6fjj/IqoFY+OzzaxVFmcXjgLvmb/lxhDdWIx809AUHePPKzH+1EHTyV1LOjU8
    Tm+vjb4Jg7TrPkZ2lhLV5ewQLG6ngDXe3DncNVuy62eCb40UUpkSv1KQkE1g8DWHGF6R
    DfUWT5nBTHg/G7ncSt/cDza+nuAt3NapfdzSNfjDHUnrvyfU7ji+WOk7DxBGZnrW0ugf
    +unDOCebHal3Hwct7ehcjHx7YoqxDpNpqCkBDmlf5cQZV7EJsI+PZDH+EqICelmKmyJU
    npJg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1704337489;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=hB1plfuROvN5RjojzvhDfZ00BtchBrfYATPvTHyaElg=;
    b=Xf4uzjNbSW5nWRxqYxUTXYH/aJeV9puLz22FRXFmjOTTFEUr1L7cxZsfolrKdtW39L
    kwK0gd9qDPL43qloXvb4N4e+bWSg/QNfpAmVJ1Gm6wAhw1RWFpsQDT83jOJm251dUSC7
    PyQzeRuMvJZYnjTMtWBO4fM3qedmEU7h+wvIbh8ySWkJsx7mWNMGBRWR8wdgNTofEUMS
    P1huvroPQHSP3jbqvFOYgPgBwrvJiQLNlCHiF4GDEszTIfNs4CINUaMXyjBA7/CJmBIW
    44q0thXJpOAponQfN9Q8An0z+zX3i7OtyWlUKrljRTNxVjqVh2gHB1yBThLXGc0z/8yY
    N5Kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1704337489;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=hB1plfuROvN5RjojzvhDfZ00BtchBrfYATPvTHyaElg=;
    b=MO8QclmWtQcuRal9Mh0IGnMsLch2BurkvrJvS0F8UiLIf2lqwr1qN8K3j85L2Sz6mC
    LNnGwa35WSpbZC8Y87DQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCs/87J3I0="
Received: from ox-live-app203.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.10.0 AUTH)
    with ESMTPSA id d26e7800434nim3
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 4 Jan 2024 04:04:49 +0100 (CET)
Date: Thu, 4 Jan 2024 04:04:49 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Cc: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1745673333.2006251.1704337489198@webmail.strato.com>
In-Reply-To: <ZZU2gnuaNlO8/Cqj@duo.ucw.cz>
References: <388403084.1872261.1704264616877@webmail.strato.com>
 <ZZU2gnuaNlO8/Cqj@duo.ucw.cz>
Subject: Re: [cip-dev] [ANNOUNCE] Release v4.4.302-cip83
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev56
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Jan 2024 03:05:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14253


> Could we get a note in form "it should be up-to-date with bugfixes
> from v4.14.XXX"?

Sure, I will add that in the future. For this release, it's 4.14.334-rc1.

CU
Uli

