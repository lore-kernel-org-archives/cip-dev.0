Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0312CA100E
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 14:51:30 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
 by mx.groups.io with SMTP id smtpd.web11.277.1694011884874933631
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Sep 2023 07:51:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=hjZXnJlJ;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=WiyxnZo3;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.161, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1694011866; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oGLyWEt0/VD2QnjJD7hDmXASF+FgqDq/RPshJsu9rLuhB8+bbE2SWZqDW3M1rU2NHB
    QslEN8LwYov0NogeZsb3jnwOZxWbdD5JC3i9y5A1uFYELcIjKrucXtbTsShKfzUNUEyG
    9h0LlFwbKSEHqULsepOI5ja1QVcNiPT/IJozPDJGRjL3A1RAMsgZ90qwxY+K4LbqV6mF
    WUOvQicpKH24acdrrOVntwc+uBzsv621URsy0bW5jIlhyBpg0FziOXKinF8ZNjNtoFDq
    MO3d0nL9tx4iwOFCKX+NofHGuUn/dlnyUrXAInk9po5/b/9/pSXykXKOqYyuPVbPDrR4
    q0aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694011866;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=WC8KU4t2faB5lgIW93f61jFr2xHFqj7uxgC0//F7md4=;
    b=I1rBvSZRdwnbM6pd61TLZQCVCxoAeKqrJqLVxchllOaPoniBHUneZBrbDNpbOuPoL1
    k0mN2YzoxlWr/BdoBKtmmDvjtbhHvI7Dd0deYvlCDFjNADkQd13kqWfT8hqm973zN1qA
    LTImhfpPW7olvZ/qhY3+VV9B6CtNHaB3wKqtLLSCPAUNHnT50T9PRPmZbIrBEQL4Ig2N
    oos3PZ3jDIq0IYeSfrAJAu2VH1w3G8o4a9TCdJ1AJhWY5neTS665i8vJfbGVoHpFRlun
    iKbSlBR3ML+zhWUq0wEBcZ+0RVa/dhrcr64rlMppSbse2ZemntYZzHt8ZORnHQzEVePE
    njpA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694011866;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=WC8KU4t2faB5lgIW93f61jFr2xHFqj7uxgC0//F7md4=;
    b=hjZXnJlJEl7zy3RQWz5MrtxxcZLugQhU1DKBZefrYXRU/xtRUuysKozSYFznYr4Mpq
    +/jZ4AFNuE8sYaH1xAPYHfuzegYoiTNSNGpA0yabakpR9fFo51xw3PYnpthkakvBkmhp
    35Yt1iSB9reRA/2Dyv16MZdqCWzbU4Z+8ifGaC9G9Rd6cLwZiJbhPbPPCM/cwI1HkHTa
    SZN5/qfzfEPoqvTtfXssw2nISMac7c+gar49Nij9+VQz1Kx077wbuK9bSoFgD3g+FJKV
    7EpBI6q8SRnRjpkGtGoT8wHqesw4B3JNUnqIdq9fGyNvBCBWf272jSHasqP6nUtywYmo
    WYyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694011866;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=WC8KU4t2faB5lgIW93f61jFr2xHFqj7uxgC0//F7md4=;
    b=WiyxnZo3JksgK5QZXh2gXMSk9YAgINkjzw6eLceihzV4TOGGVuOULj399b0GWVB9VB
    7L49bec8vSWBnAdaDUBA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCs/83N2Y0="
Received: from ox-live-app103.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.8.2 AUTH)
    with ESMTPSA id eb482fz86Ep6PAD
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Wed, 6 Sep 2023 16:51:06 +0200 (CEST)
Date: Wed, 6 Sep 2023 16:51:06 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <396663016.453698.1694011866201@webmail.strato.com>
Subject: [ANNOUNCE] Release v4.4.302-cip79
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev50
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 14:51:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12993

[ANNOUNCE] Release v4.4.302-cip79

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip79. The linux-4.4.y-cip tree's base version has been updated to v4.4-st44.

You can get this release via the git tree at:

  v4.4.302-cip79:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      202f2689d81b96b16bdc48aca2a2446568135a0c
    Fixed CVEs:
      CVE-2023-3212: gfs2: Don't deref jdesc in evict
      CVE-2023-35001: nf_tables nft_byteorder_eval OOB read/write
      CVE-2023-1206: hash collisions in the IPv6 connection lookup table
      CVE-2023-34319: xen/netback: Fix buffer overrun triggered by unusual packet
      CVE-2023-3611: net/sched: sch_qfq: account for stab overhead in qfq_enqueue
      CVE-2023-3772: xfrm: add NULL check in xfrm_update_ae_params
      CVE-2023-3776: net/sched: cls_fw: Fix improper refcount update leads to use-after-free
      CVE-2023-40283: Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_cb
      CVE-2023-4128: net/sched: Use-after-free vulnerabilities in the net/sched classifiers: cls_fw, cls_u32 and cls_route

Best regards,
Ulrich Hecht

