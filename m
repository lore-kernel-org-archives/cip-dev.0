Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B68E9B25A
	for <webhook@archiver.kernel.org>; Wed, 25 Feb 2026 05:33:19 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39641.1771997588334426431
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Feb 2026 21:33:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=gZNGKfIj;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=H6yxA1zo;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.221, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1771997575; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=esFEyw4j8rnrLwN1ziJ9AfsZI5lp6axi5FjabdgoIP6EgAnZ3HuDtARXT9fl3a0UWF
    JY3zaySQjd4XyKNHE/pvYAPG5CIqUZtzh4LL2SqrGKQqfm429/LnttzVJsxIDq68PHI7
    ZBWKxmNcNoWfSokeTSEe4uDn5YIfRT3UQfSX1CC/vWaMY4wvpDDwSSmcEmfdlyKGZG3i
    GJRTCkOHGdWd4zMGLS1vjQ+OGgY36QpL6Z+P/2gU3H/3NQ+fODcO93iW0iMnaWHhWCoy
    +aGj/ohddlgJ/G7Q2vHUN3JZlkmIjZVKSZuJWHAYN/DLzKmDthEFTiElPq11Ui7PXikX
    YfiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1771997575;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=1XS+SeUSGWaU+5ovkyRovf70gcwJA1kgwmkHMX+/wDM=;
    b=lpnOSuSdkPHTm2kYpW+GGIJALP/qs38OZ7+raorNdxYIeTiXeQmUxdZM1B7qwf7S5G
    mj3FnbdFlXD8lJ5q1zUyMBnxDYlZ8jw/4nZKTJN/mJOLte/EeBWPsXh4jNRs1R+L5GAe
    oQS6bMJ9cLtTMZa+JdrtncvZA+zjqMRsPijRuSYU/woFRLwrBFeiDMxe420MvOjRQZVP
    QfMV2C2Nkew51CThhw/12/YSzaLgGHptClCYQUj6gA9kXXf1EJc56r4rR0and/2Of0G3
    ak70BzsGwS7rT8/mFzJgVoSjdLTBTeB3ynt2KO1TfZMngE5YUfQs64gO7FF7QE43nGNA
    mGwA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1771997575;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=1XS+SeUSGWaU+5ovkyRovf70gcwJA1kgwmkHMX+/wDM=;
    b=gZNGKfIjGE1UNzPZ7HnRllKdVnILfjSJjNe+UpMLaMBPM+vHA95psqlYhRPgs0Dqbm
    ocTdXcy1zsy+F3feUU04jtEOg15flT7937Yp6uQBoIKJZMZxoQJ9/Vd2rJEsXtZfdsKl
    /af+ujHs2pFgVuzdnZYw7SMRFOfakdCODUVjf1rrKA1V/v6sufhfpezeJVmccvcQ/CNc
    1MOIEXrBc3ViD9QPAHlBFqzEkIZQdtoyJTeRI5/zBUA7P3K97h88/bgclpkNZrj3l42e
    4YI6Mf+YArOVdZKzMwybNCsSvAObzSM2WNgN5maCTgq0HGmNm3/RSjBpxOMsFp6w2+jk
    jImw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1771997575;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=1XS+SeUSGWaU+5ovkyRovf70gcwJA1kgwmkHMX+/wDM=;
    b=H6yxA1zojdgjmsfhQc6gjnBF7pRjdTFMxOrJjx8AxXsq+WSaar350OyHfb2V65rTPR
    6Z6kRgiOIrTrv+e6A1Bw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRxGvRq2JA=="
Received: from open-xchange-core-mw-gw-32.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z92cbd21P5WsUlz
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 25 Feb 2026 06:32:54 +0100 (CET)
Date: Wed, 25 Feb 2026 06:32:54 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <440487134.6462.1771997574376@webmail.strato.de>
Subject: Request for review for 4.4-st73, 4.4-cip108
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.74
X-Originating-Port: 54056
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Feb 2026 05:33:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21928

Hi!

Here are the manual backports for the upcoming 4.4 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

dd2af1ff15baa macvlan: fix possible UAF in macvlan_forward_source()
6e7f9685b9d35 wifi: wlcore: ensure skb headroom before skb_push
1b847006e7141 sctp: move SCTP_CMD_ASSOC_SHKEY right after SCTP_CMD_PEER_INIT
bf3c650dfddf3 btrfs: fix deadlock in wait_current_trans() due to ignored transaction type
9dbc25309be1c net/sched: sch_qfq: do not free existing class in qfq_change_class()

Plus one fix for my convenience:

e0e89cfcf08df arm64: replace Sun/Solaris style flag on section directive

Thanks for having a look!

CU
Uli

