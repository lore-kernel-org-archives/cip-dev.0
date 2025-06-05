Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F388CC5B543
	for <webhook@archiver.kernel.org>; Thu,  5 Jun 2025 09:23:48 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
 by mx.groups.io with SMTP id smtpd.web11.3149.1749115418134739991
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Jun 2025 02:23:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=VrDW2+i2;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=QkMVd941;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.22, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1749115407; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QaZxtFbPUc2jAVBt0wdlOwyyRJUAPniQY4o0ZswGq32uTuYx+BKkVe4QfgSC/FH4rU
    R7asxKN3kYe0ZJ49ByP/sQuu3DvCDT6s7XO90uujK5AJRQMu68qXHFNoAv5jlt9sJyb5
    9HJ/yoSzE9RSfmFu3t8FkpaSgIvMrV8A8su05Ed9TsDcrbw5yRIxQgC+DDy7Y+bA2T3h
    RzssXLE9wUkkFEHTCqylTOG2BysAg+qZuKWmTc7wyO4LVZa7w+CNeGyI2l+xu4bc4VHV
    RrFQs3JlFpMJZwyvRZ2f7XhF4dzIudvnXZ5T2M6f2AcURoyKTUBCWddGDnBmOiyLDmTe
    95iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1749115407;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=RAqFGwfsu0KaQ8AOOe2T7jQfbz1AjgHMUK/Om7NyONQ=;
    b=P4P462E+VzbX/88+ur/H/2fBMGVmkiTuH60cS1rPB8yLmT1hjEzNQqX6sUxmINYSDO
    J8gydGcNZZ4IBZh0KuYJ2TVB2VBeJKZWMLr2/9atzuCfvjsCTgBMZtaxipfnc44OI+4e
    Z4YDRphOTq9kHZWwN60N91tvY5ZSnJPeCzjNg33hajZWTz1HBiPCqHXNIfJqJ2CatJgk
    4yBgqkM30yQTwVUKWTtNCYuub7oAcQQcmBkx5fMQAp4z9zX2gKssDQb2gKB0L8Qz7AJN
    dTBDE9G7M4shRmlI0PnSd5VvG+yLS67+2Ozr0DJo2oxj/kgtupko1wjvQnmtUiafB2Mb
    FQ4A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1749115407;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=RAqFGwfsu0KaQ8AOOe2T7jQfbz1AjgHMUK/Om7NyONQ=;
    b=VrDW2+i2dlJDudZj7mVOVtzNkYtFj8qHvQdlLTW5SMyIebdRuFIugeZXGi9FTYOgN2
    xgBksk022GooYYZo9zFVtj8W9v4r5CnrmfVl3D5o75dBQaHGvCPwKWZTZBVXc9solVXV
    TZeHMumPciwTdbOQnZBkdat5M4BUFrHh5goj1yoZti+9zt/WMOvww23YmtoPg6S7dlw9
    ut6H2G/6RYg457Fpe7PEF0UOVZ2+CoKW0tin0HYwShVRa6PLLB+jdvZYzMDAu4gsLdrs
    wU23neTagg2fLJIyXjWvEyCd5LtW2s9OSXUYB8WUAaFAVupDSnVKp2HpTIjqO7h2HUto
    l1UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1749115407;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=RAqFGwfsu0KaQ8AOOe2T7jQfbz1AjgHMUK/Om7NyONQ=;
    b=QkMVd9414LFbGXk5d9y1G1vGvzhvvyPoxsSHoEEv2QRIElePIFHD5KLVT3fWlvgXiy
    4pmsaXRELT/CQtkpG0Dw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hex6fd76vq"
Received: from open-xchange-core-mw-gw-32.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z2a3401559NRkP0
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 5 Jun 2025 11:23:27 +0200 (CEST)
Date: Thu, 5 Jun 2025 11:23:27 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1295692742.168185.1749115407487@webmail.strato.de>
Subject: Request for review for 4.19-st5, 4.19-cip121
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.36.53
X-Originating-Port: 59276
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Jun 2025 09:23:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19020

Hi!

Here are the manual backports for the upcoming 4.19 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-st-rc

4e1c5d6453080 x86/bugs: Don't fill RSB on VMEXIT with eIBRS+retpoline
97dc5628cba1a clk: check for disabled clock-provider in of_clk_get_hw_from_clkspec()
43222f234ff0b PCI: Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX

(The last one is not a fix, but backporting it saved me from having to backport three other patches.)

Thanks for having a look!

CU
Uli

