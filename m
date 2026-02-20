Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F03C54F5F
	for <webhook@archiver.kernel.org>; Fri, 20 Feb 2026 06:39:01 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32969.1771569538011049582
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Feb 2026 22:38:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=P2wWNKK7;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=guqvdEC8;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.218, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1771569526; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mtq6zhl7Pot7rl+9CDsP23Qy5MRLCQM6XcDeQVBsPVd5F96rGgbdbndCJ1W6CiiqHu
    /iVhaZPKvwaOSfu0DDJ3p473T3JUyVXv62V6wHAX0JLnheZVuzw1IKNXux2xzPptOALD
    +iKGwpL4LzqQq+LnPd4hMf2v5je2bvkfR/dl2ewrHadJr3gOpjW2ZXuTwzLBuZoYBjRe
    vlPuE1pXJMWg9UT04OyVRziEkjGa5+dPaShUO3m71SMaUzKTOKtMS3vAibtu0UGVQIRR
    2p+1vHmSZsnHmHBgUH2NoQTEhp7U8jVW3GhScWuVXtLj3Rjy+fdLje2E4+8K+TFUN2ri
    BOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1771569526;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=z3srOgefzzJC0y3m63JU4TEy6kA9dkQyVQjXGKgF49g=;
    b=e9lh9lROjbQuDpJU7tGsWm43JP3dTo9gUSkUfyQ03ePBFLaUI/cGzVgw9tS3pw2J/f
    LcN5BnS7Q/y1/JRkxeDIbL+N0d8QGL4djdYpINZD1b61AKW0aPpr00esvEpFywBcBUq9
    TA7p3btmcqUZQ3wpHFnnomeB/ddgobBn7I5r+lXWyrUhd0k6PJzIX2q6lh4KMR35N6dE
    3Y5PdxIZJrpWemlGn2HhW5gxNrE9hkQbQWrGWfFg8AIOKWPgRz/j5I9j6PmqBRUvYr9k
    Cdn/bUnbags+in01py7ATeDY3ZTi6qeqNk3yFKGHIbIlvCejx7UtQEuh94EXR4YEbXLf
    dCRA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1771569526;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=z3srOgefzzJC0y3m63JU4TEy6kA9dkQyVQjXGKgF49g=;
    b=P2wWNKK7MvC5/4fQtl9B+Y+3/3u84u/JcbqmIidy6wrTyUZoiZksa9e568cWje8map
    43xR+M7aRnid3LVuVUwaBnba5A0DCnHddGrmfg5npCqe+IM0fUXqhz6trO4cVTlIlQvA
    E7RLzIraHTjtv19wsmDH8/Srz8FNKltnKg/+xt4fo3RYsaS4O51IE/J1anTz8gH/FNOY
    X2v6XF1LmZj1j0S2PzRJpMxkhYFKKg8Jp8t8/DWY9kWKft6sWYgRT+6xUFCB27uQpB3F
    bnRVcmbn5NEWb22IzCL2soWDMD+JE/tFSowbC/bCmoqWefNWIfNoHtJUHhtOfSh5J/+l
    i0bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1771569526;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=z3srOgefzzJC0y3m63JU4TEy6kA9dkQyVQjXGKgF49g=;
    b=guqvdEC88LbJ96YjsrJ9G96TCNxNT7bSfUj/8cKkHtbwlFLN5Nlehj4C6EBr1VdLLd
    ETdBjOKBfEHYtPEiv9AA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRxGvR+3JA=="
Received: from open-xchange-core-mw-gw-27.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z92cbd21K6ckB27
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 20 Feb 2026 07:38:46 +0100 (CET)
Date: Fri, 20 Feb 2026 07:38:46 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1504945381.404757.1771569526446@webmail.strato.de>
Subject: Request for review for 4.19-st13, 4.19-cip129
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.74
X-Originating-Port: 39790
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Feb 2026 06:39:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21902

Hi!

Here are the manual backports for the upcoming 4.19 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-st-rc

797ce10e2a2f1 macvlan: fix possible UAF in macvlan_forward_source()
85f1f9ce40bf7 HID: uclogic: Correct devm device reference for hidinput input_dev name
0c110bc67bd3d xfs: set max_agbno to allow sparse alloc of last full inode chunk
6a8957a06bc31 l2tp: avoid one data-race in l2tp_tunnel_del_work()

Thanks for having a look!

CU
Uli

