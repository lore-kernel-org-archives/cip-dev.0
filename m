Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D73AE64001
	for <webhook@archiver.kernel.org>; Sun, 12 Apr 2026 07:38:00 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.230221.1775979465359878074
 for <cip-dev@lists.cip-project.org>;
 Sun, 12 Apr 2026 00:37:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=KPuQ+54G;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=RcVQ2fBB;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.221, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1775979437; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VB68d9gWBOJ+LV6FURS9Wm/BRd+PWhxQ1nE9lRsK4/OvzwZqxfcnA7OQxmZmAOqfG0
    qciwd3UxkrVOeYbOXxjlL5+y6rXhKmAK8H6LlBaEO0egXnmY4aCYz9T4fZ5g95BuAbRT
    vV78go3nh7BTWpYKirQyQxFgfGauDBgucAdbT8uf6ymSIn6d/Ke3mhU/H9oz7zncFURG
    o5jEYlV6wzOWI6f32elqpKDZMdLZGOy0CBBbv0DGelrzQdy96O8vh/KFLYA9HIecviHV
    iVntX80wkTAoAHyQ594ACGU/8cMH7pOi2AdibAwjs8TrEcY3LlGh9p1oM4Rf8rifPobs
    2PJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1775979437;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=lWtGqalAb6maccBmgGsVNTq6o1ClLp2k+wVJEYYEJi8=;
    b=SsRRYKH6zkTDea1NoDrEg7uENVPtZqraWV6NOeHZHX0unDfKzsV993TSzxm+6SMkLA
    FfUzMOaq4oFEAwW2BaaiJSik6DYO2vGHHnT1OjxOGGqnSjjUFGo9pGCCCjtVDX1Idp9k
    dCwKFLX/eaQv1qSj4NTB1ASSSxtu49tVliyJaVxEO3bAuMEJCaYTE7F7Hqcx/rGibxmF
    nhuIf2SE7ZjsOS2Q0yypZf6inUSDh3rOmNWrSKGiA9JwPYJsi99IMc/U0HWsWkoFFEIj
    YnKkrps0oNmwzWN2wZWoTXNvjfav6DLuxs592irwytTOttyhqPArwxRVqkzvYxZPKH8E
    /mLg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1775979437;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=lWtGqalAb6maccBmgGsVNTq6o1ClLp2k+wVJEYYEJi8=;
    b=KPuQ+54GZ6hCw92EOWib47qEYtWZno+YSesl+5PnFMqZnrHXStVH7+uqQ6/AA75QZi
    hbvqf7OrgbWoCvEoxtIiWC+ippgEJxp6qXejxkmCBGEzKgtcBWcVZnqibEmHDs0ntNZG
    l3z7P8bsTypVchoJHFTL+QSuBlH14zUgXGvf9SBNa67wSD3qCpPQcsSG/0zENgKnFoGK
    +qfx2WX+N5fDbfURR4XlELBasUEHc5UIM67uZSTJak0TlLwC1GEq8YVizTFg1+IerBth
    99laM6nn2stslcZlAEC6lv7Z9zgd2DTNSxlcTXprPFVUMK8F6jExs4IsCqiYrvZXIFA3
    zJQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1775979437;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=lWtGqalAb6maccBmgGsVNTq6o1ClLp2k+wVJEYYEJi8=;
    b=RcVQ2fBBxTBB341b7Bs7Xwj+iQVWj+QUb0k9329ayyekB64Ng/muKWWc9q81H4mk+T
    EdzCXK3Z4AKMJxnYSVAg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvsX0yGC6oc7HiUIuWrQ=="
Received: from open-xchange-core-mw-gw-10.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z7806e23C7bGSVs
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 12 Apr 2026 09:37:16 +0200 (CEST)
Date: Sun, 12 Apr 2026 09:37:16 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <459507685.15146.1775979436923@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.19.325-cip131
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.88
X-Originating-Port: 56058
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 12 Apr 2026 07:38:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22675

Hi,

the CIP kernel team has released Linux kernel v4.19.325-cip131. The linux-4.19.y-cip tree's base version has been updated to v4.19-st15. The trees are up-to-date with kernel 5.10.252.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.19/

  v4.19.325-cip131:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      7aeff6c7984c582f96916d12bd33eefbd746459c
    Fixed CVEs:
      CVE-2025-39889: Bluetooth: l2cap: Check encryption key size on incoming connection
      CVE-2025-71239: audit: add fchmodat2() to change attributes class
      CVE-2026-23241: audit: add missing syscalls to read class
      CVE-2026-23243: RDMA/umad: Reject negative data_len in ib_umad_write
      CVE-2026-23273: macvlan: observe an RCU grace period in macvlan_common_newlink() error path
      CVE-2026-31411: net: atm: fix crash due to unvalidated vcc pointer in sigd_send()

Best regards,
Ulrich Hecht

