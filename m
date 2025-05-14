Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7C3C3ABD9
	for <webhook@archiver.kernel.org>; Wed, 14 May 2025 09:31:29 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
 by mx.groups.io with SMTP id smtpd.web11.98592.1747215080161842904
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 May 2025 02:31:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=rn7oG3fh;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=7rKh6J4l;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.25, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1747215068; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lDZyg33krJrYn8uk7wScvkgpv3BXNsLNf/IJU5PjoSgl1P85VGipd536dSVU0X6SIX
    P3W+Rx3+GwnITq+kwufPUE1AUjpPeP+ILGM6xGz8ztD3xkWfKJc1ETPkoCyeVu65oILP
    oms9DrBcMlrwnL1gzjrFp+VZded8ZZ8zTgyWWbbOhWab8VD/HXiNRxFe8ei0KwFGYmij
    1TiG1aTbvHH3miScvxTg1KVozfA8sgb1FGfXn0I3FFbwRihUsWdaJqvXs+bIRN6EI8Dm
    mSe3RoD7tH64tXOj1L2xyn4+bqjzh9c1tXcRz8ebiodu66Bs+xGE2MC9FgFvVFULvXwv
    TmCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1747215068;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=Rvzf+/F0qCWPJSqPihCr2XG5SHOs811anDAC63Baei4=;
    b=KMluAqCpA5YHsWByMrwHwLDAgI03+Gc8pOrERAg1hOuAJMPzKuKUsl35KbD9PKBMiF
    xmwElUI/ty42CFq1NI6N8JPNETRq6K+CHkVeCC82eb9vKC4eEKs4rdsqzIEG3llL0btw
    9MefYCvJWftEJ4/S2uqXA3KCOJdKpNTeBDV1CAD7Wbw99Crbb6VP34O8Zb0bER22Sy4r
    ryuX/Lg0bzgeNsx4TKJIjN6mbadWfN4J7fnVZmzdRRCaEDoYHMPFiA6EAJEqgWFZuSPL
    4kySruefqFlDBzjYmClF56/xErxa1Zrgpl1G+vEiWM4YLF2IrbFBIqm3kcddTOEt8oY2
    f+Ug==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1747215068;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=Rvzf+/F0qCWPJSqPihCr2XG5SHOs811anDAC63Baei4=;
    b=rn7oG3fhk4RjXuEw+ebiqral0HkbmCDqMV5E6NvvLEaK/w/kumRVlORbQRDpOmPfEL
    VpvlXFErveclr9uaMCR0/+tYp2vp7x/6LtLwwaHlfhwavrdL9PS8+7wJ3SQIlyesQpMs
    hc2PoKNQKOLTlodnOj1SdB5wRrFctV8EkJLQ7Ucg28BASwwIzcgH4eo00AXirP8gn9zz
    LO4B5WETezw6oBu9Dy/A/iSnxmNeaJ24Xkk3BgMi2wObyDV+R6wJjGWrBOTGJcCxFHgO
    4QyXEb6xYz4Ov+G6EdlpqChml7Un/CP41gfFp7iL2MC+acKvL0EkITfV6Di7ob1IxmL0
    XCcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1747215068;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=Rvzf+/F0qCWPJSqPihCr2XG5SHOs811anDAC63Baei4=;
    b=7rKh6J4l5ZnG6o4yXQ/felqMnQ6nQLtmuj7aBbAOw2EE2nSVnhjFK6WSy6+B4oogWH
    hxlec5MLS15XRPaJPWDg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hex6fd76vq"
Received: from open-xchange-core-mw-gw-14.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z2a34014E9V8NAX
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 14 May 2025 11:31:08 +0200 (CEST)
Date: Wed, 14 May 2025 11:31:08 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <594897735.236352.1747215068214@webmail.strato.de>
Subject: Request for review for 4.4-st64, 4.4-cip99
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.33.60
X-Originating-Port: 40506
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 May 2025 09:31:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18904

Hi!

Here's the manual backports for the upcoming 4.4 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

21503a13375d5 qlcnic: fix memory leak issues in qlcnic_sriov_common.c
952bc6f3a0ebb HID: ignore non-functional sensor in HP 5MP Camera
ece0f8e21aa7f net_sched: Prevent creation of classes with TC_H_ROOT

There is also one new patch that I added mostly for my own benefit:

18a3ce42a20f0 mm/sparsemem: silence "'mem_section' will never be NULL" warning

Thanks for having a look!

CU
Uli

