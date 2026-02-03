Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DD3E83051
	for <webhook@archiver.kernel.org>; Tue,  3 Feb 2026 05:01:42 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10009.1770094897701860003
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Feb 2026 21:01:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=Fj6tvaAe;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=pWqAMl7h;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.25, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1770094885; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZuMVa6Sx+GCAQoUtvWTL0u1PCLkA3uKsO6emyUSMyIApoy+5UI15PfjeWqGHAYV45K
    /dwoQYDKPwEKCKBWqFqe5Zz0vmoERK22SC4zyuiTqexVh9u3uDnCPLZ//W2NnOK8UgLJ
    y2Smhk2FDMIAs5girSQf81J2X7kE7WUlAXeDNsf2Qw7dnL3Eu9mNuWpOu2KIeOvD1uIq
    B30pX46IZA+hRUHHr3/LxP/FLSeMcrbkucdeJU5hl6IebHK2rA3aSCZmbbs+HkQHngas
    +p6vNUUsdMK2jzNwbhPXaeiBWExV0+QAFKtndR9U1xd7Xl+QEKDWp5eTBjNq8M4EQTMG
    eB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1770094885;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=ecR8OdIovdFHLH+NXl6vbm3CAbfvYNlyEIB3nd7Jtmo=;
    b=nCRYhZQb4ER1aWNR0C7ZOeWC+SK8ZJLwcQiX5/IxpW+/71INbm4cKNPI1bv6nID6o8
    PAcbHjuMaYw+lLbbQJ3uC/KRjnjUgCO5Q0ZLFduawjVeS41ItYPTQpHNQd/1QjkF3xKM
    6CHT+utWEKC/m7GE9yIp+wSaR7VW2XjCSmWPWO7XQ6LLRC4UGJGOMk9DbDqxOT9MEalS
    PJtO8/1XT2s0B+eB033zcID9y3ucQnX0LLSisDL2afp6neYo3rUmBhmMYTvTLGEicVfS
    OfW553atBRIeiXPYsjmZAkuzodR40ggQ18L5XEFDwRg0wvkYwCwg34mwzejYns7H3QLw
    nmRA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1770094885;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=ecR8OdIovdFHLH+NXl6vbm3CAbfvYNlyEIB3nd7Jtmo=;
    b=Fj6tvaAe5d8qkI3CX0zx/djdHRxqx1vx70G52jVMiUmc2y+2xwX77q/IQTMI4WOqEP
    4llYVgmKlN8c/s7DlziF8nzeKOdyJi466/h2lzKzZVqCxbiX/Jcu8Q21vKuU9cmD0vL8
    VPHykRsAFAN9xplP2fen2v9ND/R//CNGFGmAT2d2Hfg2uwluZdTPvJGRyVcbrcjqvMPl
    QBQxnzAieKONm+I1TCAKZVcJbi5NiDmf7to/TYWuwMURiH3vUsT8vLYiBdKRuTbgWaUX
    gEuoJ4oXVijTUXgv5dsGkUglfXvGRO+qrEXPtkANnSVKT/2GSN4BfOif9j3cu8gwrjE3
    iVBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1770094885;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=ecR8OdIovdFHLH+NXl6vbm3CAbfvYNlyEIB3nd7Jtmo=;
    b=pWqAMl7hTmWI8qR013mN+gvXeYwDg50BEyR1DF9kf9KcgadtywPGV47TXNhNauo0PD
    dCB/CVsm+ZiszU2jswAQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRxGvRje"
Received: from open-xchange-core-mw-gw-21.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z92cbd21351PEnM
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 3 Feb 2026 06:01:25 +0100 (CET)
Date: Tue, 3 Feb 2026 06:01:25 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1873813255.141036.1770094885595@webmail.strato.de>
Subject: Request for review for 4.4-st72, 4.4-cip107
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.74
X-Originating-Port: 59998
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Feb 2026 05:01:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21815

Hi!

Here are the manual backports for the upcoming 4.4 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

9fdef2a6b53b3 jbd2: fix the inconsistency between checksum and data in memory for journal sb
7d0ef9b50d5d3 f2fs: fix return value of f2fs_recover_fsync_data()
bb471f70de075 ip6_gre: make ip6gre_header() robust
6eaf989ce1c09 KVM: x86: WARN if hrtimer callback for periodic APIC timer fires with period=0
1a0a3e2a74b85 f2fs: invalidate dentry cache on failed whiteout creation
cdfaae22c3796 usb: renesas_usbhs: Fix a resource leak in usbhs_pipe_malloc()

Thanks for having a look!

CU
Uli

