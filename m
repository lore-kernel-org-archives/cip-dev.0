Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF636CE8D6B
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 11:13:12 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7124.1763377985434176204
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Nov 2025 03:13:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=gtnPxbMb;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=dP41/sas;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.21, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1763377975; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Jh7IlI5wwa3s7ZEz6swjsrXVsWe5s0QAv8xfqiV0MbhtcRQv24fKxRBJ0fadkurNMm
    jCRLmC8U44a5JwARxQXwb6ute1voArV22z7xUKGaqjGrl4V0cfBlmg7ch4H3EgeMsUD0
    mwZYVndolD8iTuM3UEtHx853YIM8LpiDD7kBRcsGIKnAciw/MTQEH7GGqw1Nnu9X7MrH
    PPFcq+iz5ept5rbdSWXXWJdBmnmnmtc8/QmzJwNSZL/u9Fi0x7DwsqNyzLUKvYKADoRp
    F5YHJo94uROdpIFVnKjfIXpv/L04xuwvsV89YLZ9na4Oi9/k7xYol78WOcvzDor1HI/s
    g8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763377975;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=TKOHOv/rplxieL+uxopHBN4okr4zxnxLBbGYhyV0YmY=;
    b=KDys6LityBQDWG7MEtHpomvFxAUeN+812l22OX+yWgdy6yzGD6gNrv3fKi2Eig+LZy
    6YVAe/O0QqYczQMczyPSTmbQv3oQwzAIC+drVNnLxzZa1o0NrKuGvYDPGNWCUL++mrHy
    HixMEwFA2pGC8vJhErNo6OSvHxpPId8qyC1+qG57atKx++iFyo7YpjwSLM0wyVAPm29q
    pfNFx/wzHqm8pNOF3lbJXFy1g2CgJt/uM8ObbxyKwIccRFk4F2EvWHP7Ihf/UWP0NngG
    gtoRf92IyYRT1sm6nAx0U4TN/FSZuClvyhk6tJqE4Aqu0fxiJm2T2A4e7YPGmrZwJbmS
    rMEQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763377975;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=TKOHOv/rplxieL+uxopHBN4okr4zxnxLBbGYhyV0YmY=;
    b=gtnPxbMbcz943dfXJRwt7rJaF9PTGJmFjQ/iXeVZjfC4Wg9i4tkJlT+RNZ9nJt160B
    KAFJbQVQd0M7umMMZ6ROJiYQr5CiMzUFKb1o+nmH/p5D/E5Y9/T24VVGDNFisvDu4UQ9
    Kol0pZ6sMAQqee+NM6B0WNiQsXHGlqg/Vqbs5FzArEB4L8iJYrpby/IIUGpmPJmNybzj
    2xesZmDuVLC+dzmaDhbsG7YtQAqNFMWaizsSz9bsijt5vst+P0R/rxLbgs549xcX3Hvb
    g2MxiXhBfSsW7BKEXQxQsKnnNAg58z/2/H8NVppG2LWXe1yL36P62KsSrEnT8mvIHyfk
    1Sgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763377975;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=TKOHOv/rplxieL+uxopHBN4okr4zxnxLBbGYhyV0YmY=;
    b=dP41/sasu2XEyS7Jcy7MqtwllN5EC/zsgW/q5nvUpMV2RfoF6SRT9pdm+Kbru5Flsm
    vItQOa2kUfmonYwiOeDA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKPA+Dxtkn4="
Received: from open-xchange-core-mw-gw-28.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 54.0.0 AUTH)
    with ESMTPSA id zd62e41AHBCthRG
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 17 Nov 2025 12:12:55 +0100 (CET)
Date: Mon, 17 Nov 2025 12:12:55 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <2007204340.35590.1763377975626@webmail.strato.de>
Subject: Request for review for 4.19-st10, 4.19-cip126
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.38.93
X-Originating-Port: 45188
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Nov 2025 11:13:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20576

Hi!

Here are the manual backports for the upcoming 4.19 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-st-rc

047c1ac84d5e8 net: ravb: Ensure memory write completes before ringing TX doorbell
1308591f9614f net/ip6_tunnel: Prevent perpetual tunnel growth
fe026547bb822 tracing: Fix race condition in kprobe initialization causing NULL pointer dereference
c9c5642eb5eed rtc: interface: Ensure alarm irq is enabled when UIE is enabled
b25bf5615ed6f tpm_tis: Fix incorrect arguments in tpm_tis_probe_irq_single
69fb0056f8312 nfsd: nfserr_jukebox in nlm_fopen should lead to a retry
ee1eb7fcc4b27 scsi: mvsas: Fix use-after-free bugs in mvs_work_queue
9255f4f0f7088 scsi: pm80xx: Fix array-index-out-of-of-bounds on rmmod

Thanks for having a look!

CU
Uli

