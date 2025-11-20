Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC46DCF8854
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 12:47:45 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33440.1763642858475874490
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Nov 2025 04:47:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=mx6HSpRS;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=dhvWpUac;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.220, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1763642846; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oC4LAkIJQ6LzNPS9PXbABmEggXW1hll/F8AuRlB8aOUemAX7JiIjvdy/3/FfxpKC0Y
    6BzGvvb2Kje6ej1w5ND+FOsicD9E4I/oW6mIY45VB+CtF4/EjTd/eNrcrDNwsIaNkozs
    BbTMYHGSyoAtgji01Xn3eeQ1qyHaCQuSjbvGc7xVRsrSwoKgsH4Z4aBQxzDGepm70X8k
    qTZvhwqDz4pqCbbhRzT5tMJ8e0e4j4lQxVuxEPJTbFdk4JTRW+WN58n0QbAVGaABPKz3
    aV0SBhfjXBiYqhFIQs317Qi0sct0WXof+qWArxdj0PKAphpX83x6oWxy6UU3ws+5bJKw
    mMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763642846;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=Mj4W8oIQzV68ug8bYgGj3yyOA+OxcMNcq4Kk8OeTZnM=;
    b=epI9ph8PNlsN+gpHTbVZjCwl6v5fthMCUEp7mMozCqK87GwvSQstSNQC7feeGV8ifN
    EkPfcXWIGf6zEmAFMZY/YTbfcS11X8Q4dFzRi+tFIUkk8TCLogBoTgcag3ENgidnSRxo
    HRSGweSDESZVZb0feRSES6+RK5XJ/cohlaQ3fB2UUHfG+3DWkQ77aTrkd5Qcqr7iUueq
    RTwZqMTAzV03eG7Ot+jjswsXBxlfBH62KkNGem7XKjzcgjHFPb02+5u4AEBydA/2Y/U/
    ZEZL+hgtyK/vcvMSdEPRv5PcJWovoqd7O6dWaAShoxoMapuat7S5JJQ5KnkHxfARw3EX
    5uhw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763642846;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=Mj4W8oIQzV68ug8bYgGj3yyOA+OxcMNcq4Kk8OeTZnM=;
    b=mx6HSpRStXkKHHWkPde5s0XTBAoFkS4wk4edi4cnAKhjjVt9vdt+39ATr6g9KarBaN
    8yLpzDmE4WlOm5bSmbciYEbw2pJqkPbnprPsF2wYxeyqncxnTmDSHkBFaggHAg0N9FmA
    4NPtbFVg8aRGzIRSi3MOClyOYj0xhy9w/vBQ/osPIa5X0W+od8IF7Ri+crK94riquNnp
    IdQQz4rT7/ZCMgKoXYUndxe+1lSde/8Dx6R/Qxb13HFUv9mddos1oa55R6Gco/oLVmXC
    VdNDzDF1HahKfYt1hNHQlvi8i4YlP+S8MKJY7waae/BMTejwmrxGAFnmLE/lQhUOfioZ
    lEVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763642846;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=Mj4W8oIQzV68ug8bYgGj3yyOA+OxcMNcq4Kk8OeTZnM=;
    b=dhvWpUac2PJyxP2/4YQRa5JG94QwXSnIIDDrg3fHlhrMwiE6xHiqE9aMwxKB6Tfvj5
    I0p9YgCkh0v1FLsodsBw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKPA+Dxtkn4="
Received: from open-xchange-core-mw-gw-21.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 54.0.0 AUTH)
    with ESMTPSA id zd62e41AKClQy2T
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 20 Nov 2025 13:47:26 +0100 (CET)
Date: Thu, 20 Nov 2025 13:47:26 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <88055065.32862.1763642846447@webmail.strato.de>
Subject: Request for review for 4.4-st70, 4.4-cip105
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.38.93
X-Originating-Port: 49626
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Nov 2025 12:47:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20636

Hi!

Here are the manual backports for the upcoming 4.4 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

54c5af41f0647 net: ravb: Ensure memory write completes before ringing TX doorbell
697d8a82e0984 tracing: Fix race condition in kprobe initialization causing NULL pointer dereference
21116d340963b KEYS: trusted_tpm1: Compare HMAC values in constant time
b804b894ade38 mfd: vexpress-sysreg: Check the return value of devm_gpiochip_add_data()
319a1a1ce7366 KVM: x86: Don't (re)check L1 intercepts when completing userspace I/O
5e4cb116f19af rtc: interface: Fix long-standing race when setting alarm
8c9a884e8adf5 pwm: tiehrpwm: Fix corner case in clock divisor calculation
0894b95293ccd media: tuner: xc5000: Fix use-after-free in xc5000_release
9d5dd367ddc15 ext4: increase i_disksize to offset + len in ext4_update_disksize_before_punch()

Thanks for having a look!

CU
Uli

