Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D237DC27C76
	for <webhook@archiver.kernel.org>; Wed, 25 Jan 2023 04:02:03 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
 by mx.groups.io with SMTP id smtpd.web10.37640.1674619316139194587
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Jan 2023 20:01:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=gWfY98bW;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.22, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1674619312; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Q5YSOKcaQXlebg8LUOwiQdOXJpEEaNupgtYhF7l43cahXUb2J8XEdKRqixdCLWHWWa
    5BTG23nuv28WKyknJ0p2IZjlta0Zv2N11EjDENVgOswkGj8x4r5s/U+RxWPLmfPqBfWx
    lTEpORmKObC71glB/SWJgKMoQgMvx4N/JYTz/T9K0nA4Ejd1tSNN2Lrjldx1goPwVl38
    MWN04V0a7q1uTF2GHAn7okScZ0rpS3lI9kD6X10AFz7hEOgyKgtbA3K1EECg93OilXty
    MBnwNlVVL/RrEIV++N9t761KelwZ4yxbEQsqJua4XZ/j9rdDYD3escPe+sViFL5e8oZ6
    GCwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1674619312;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=E7LPfiM43yiathseFAiIMBvKlWSYKz+HsxMic0Vg5LU=;
    b=hWITu0WOfDcfNRVZQKroLeAI+qI7c0NQ+t1rfqQfnP9QS0fpSYyH4acfC/Qw2qFoYe
    kxLMPFBQ+Q2UkPizzRe/vmPQQ2XlWcBTxVH2U0wrxjNmwSuxOLWJigZ8HM953awvt5ta
    wWNdh6AVy/UveVED3esnYtfAjsD/pwckXmx8vRSRS2NDaCun94fRERAS+fFHMv/J+M/q
    T+SU0IV04eIzY/J3AvEt/iZ3FdR+r9kbXxjAMn+B3JFc9hSV95UcCMkvQaymYxfz9EEZ
    fyahdajkqhtw2JOP1QiJjDvsH8j6kHgQdcaqCxw3+3OfBASwrNrla1EGz9KdJhx3ht9E
    NpvA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1674619312;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=E7LPfiM43yiathseFAiIMBvKlWSYKz+HsxMic0Vg5LU=;
    b=gWfY98bWARORXniw7D5Nft2hJW5ALHt576jPzsK3GVslpBcvI/KEDawhs3HbUoZ24X
    Z7ptq9SprfylBfJvNh9qWacZxSry/2msO9EwtqIZunKr0zK9OCHWSk0n6SwzrrC9cx1J
    PQZSXs8YdjBf2fVGHL2Uu8UaWDnGC3uxn/q1Z4QSD2k510yjUiFQcJPrJCYLZ//mmVNX
    0qwJ/W27bLvsb+vKmnjIDmz1AKMZ3djteYU7ch9EbUh5ZsAhI7wo9YKcTbexzvoaTDho
    aYAJoP2OdUeHQ2qza3HvJwb5SbH59WAaYcm12Ndirb6gf/WqD0lMJbPvPoN3y2rMzYrx
    wYBg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCv/xi15g=="
Received: from ox-live-app104.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.2.2 AUTH)
    with ESMTPSA id vd711dz0P41q3jQ
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Wed, 25 Jan 2023 05:01:52 +0100 (CET)
Date: Wed, 25 Jan 2023 05:01:52 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "pavel@denx.de" <pavel@denx.de>
Message-ID: <1884973880.732707.1674619312339@webmail.strato.com>
Subject: 4.4-st37 is out, ready for cip release
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev35
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Jan 2023 04:02:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10477

Hi!

I have pushed the latest linux-4.4.y-st and tagged it v4.4-st37, then merged it into 4.4-cip. Tests look OK, it should be ready for release.

CU
Uli

