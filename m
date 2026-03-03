Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736BFEB3650
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 02:19:14 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9370.1772504345346704415
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Mar 2026 18:19:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=oNwiIpp/;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=/FJtW/OY;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.160, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1772504336; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Ox35lpfQIs9nnSohJkEUHEesueQ8m+9FrMDcLXgI2OvrDZ5u5CixKLtjF5Of8+VwNz
    Ae+wmuR3vqLi6ldz+HhA40OuMLKZxRrH6xKckeiZxyHFmMHh5FPzv+ctI7Bw+WfHzlvb
    t+Ze4YWJO5xma7hUnBTtlvarEM5lLcND2/DXNzioKcsqFz2bYWCK4a3sA0hO8/kBqDyr
    Y4orclBk6KM6EwAKKD4dZ4GAxDNcWxRsWswY+y96+np7Ta4vcr5w3YXeMI717+EfzoBN
    1N0Y7H8sJQ0ckAG5szn108Tua3CFe8e4TH67hpP1E0SZ/v8TZccI+0ooLFrJIB/6fiMZ
    1UOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1772504336;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=oiFraZfxYZ0SuzloUt4Pzx3YT4IelNHCRWSp0NTeUlc=;
    b=RJyxqpnlJ1GKqUt/7DyW1FiVnhKtC9k7jB9Ox59+2HOCeVVmaXPQLIeGSJLpVutovu
    SOLb+H7Vk8Z3Qc/gfVyvv67N8pXmIFbcWFsp8eE+vleksQs1TBsiGpjOSYsp1UFi6yV0
    OO2btCrcxfVHG0EO9GlRHG1oDKRI1j6izGXW24Gc3M5h/5mJ+zBFLvqk7PBbQ1IfV43r
    AfrsQywjjOPmAshi5U4lTdeQPGH47K4vzjjwoKWpfx+UgE4OqxPdu+vhsVM0klZLcUkR
    zNbTg/JBaagTkDelKEUAMz1iYJL+07AiAS5xR9z4drRmuuJK1iFoneGx+oAFt/ExjYos
    k/1w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1772504336;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=oiFraZfxYZ0SuzloUt4Pzx3YT4IelNHCRWSp0NTeUlc=;
    b=oNwiIpp/MR6/zwpGVYHX0UcBusrdWlDgWjvNXyzHkSksTZGAqWnDWS+THuG9AZ6ts7
    74mnEx1Lge6Vu5anvOiMuousOFZAL1n8MRtvUsZdhWtvTHSsD3FSovSOyUTqqBGOA7Mj
    7FWK6164toZVM1K9a7xvtyHMJXyOz4oMM+Q/sJZldUduY4scyiKemuwT2dgw8tvcaNNM
    X/uuBCPY0KOUMjbeIQNe+h02YelqXy4+jbRhgv8aAcuacxTnXGxm4PAOKEFsKkAK4vKq
    C6YVCpC9+W1Dwj7Z1J4erpDJq1SuFOU7zuhAsQKSu3Ut6RRIC0WqUycibHfr1HEKYdkc
    rouQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1772504336;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=oiFraZfxYZ0SuzloUt4Pzx3YT4IelNHCRWSp0NTeUlc=;
    b=/FJtW/OYG4LBNaM6czmO3r00aiROddCUOl3tzXtSGPqTUYRzAIQbG4B9fnC+5A1LXQ
    jV39hc7OvYwINoxC3LBQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRxGvseMiA=="
Received: from open-xchange-core-mw-gw-16.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z92cbd2232IutZK
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 3 Mar 2026 03:18:56 +0100 (CET)
Date: Tue, 3 Mar 2026 03:18:56 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: pavel@nabladev.com
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <215520992.150669.1772504336203@webmail.strato.de>
In-Reply-To: <aaAo8TUKFDgI9j+f@duo.ucw.cz>
References: <440487134.6462.1771997574376@webmail.strato.de>
 <aaAo8TUKFDgI9j+f@duo.ucw.cz>
Subject: Re: [cip-dev] Request for review for 4.4-st73, 4.4-cip108
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.74
X-Originating-Port: 51904
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 02:19:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22039


> On 02/26/2026 12:05 PM CET Pavel Machek via lists.cip-project.org <pavel=nabladev.com@lists.cip-project.org> wrote:
> 
>  
> Hi!
> 
> > Here are the manual backports for the upcoming 4.4 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc
> > 
> a > dd2af1ff15baa macvlan: fix possible UAF in macvlan_forward_source()
> a > 6e7f9685b9d35 wifi: wlcore: ensure skb headroom before skb_push
> a > 1b847006e7141 sctp: move SCTP_CMD_ASSOC_SHKEY right after SCTP_CMD_PEER_INIT
> a> bf3c650dfddf3 btrfs: fix deadlock in wait_current_trans() due to ignored transaction type
> a> 9dbc25309be1c net/sched: sch_qfq: do not free existing class in qfq_change_class()
> >
> 
> Thank you, these look good to me.

Thanks!

> > Plus one fix for my convenience:
> > 
> > e0e89cfcf08df arm64: replace Sun/Solaris style flag on section directive
> 
> Pointer "mainline equivalent of this is XXX" would be nice here.

Normally yes, but in this case there is none. The offending line disappeared organically during post-4.4 mainline development before it could become an issue there.

CU
Uli

