Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D1AC369B1
	for <webhook@archiver.kernel.org>; Wed, 16 Apr 2025 09:07:03 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
 by mx.groups.io with SMTP id smtpd.web10.14661.1744794415247174039
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Apr 2025 02:06:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=sfi8pH5a;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=NdCakdHl;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.162, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1744794403; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Z8bLF4xXWjWCtIKlSEPbnZkc2FdqXe4X6ZrSBMbM5cFGxa1shYf3ZaatkEFtA0H2x1
    7rN/9L4jQt1Fj5B3wRk3KmfseGtQNwTJzJqHrz5/nblB83nf5Up9ahLN5C5WSe5z0DJM
    j532kNYQBRSnkZX4sTyjEkgitVnGa0exQY1pkAV1FZcKx1S/Z8A+jiDoMFJO5tx6siIh
    UMcDDkzfE6rBw/LQEzjj7fOLnn3uquQ1nvZfGrUFi51i7Ay2FI0xS/w2n3o5Lx2eXls1
    /QG20OvM4oI02nsFYYnsMu9nAkLOvNIaRutTsusvH2RhfjMRuLvOWxUU5hTKQ3KReAMN
    MA3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1744794403;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=zOW8y4ZxAdgKVdn2iWnJ2lX4C+0JOVQxYzNFRthSC1c=;
    b=HAhn0tGy0KRBTcWaPyeDWnSYWRwpU69Ug29oeWKEAxEbx26LP1pVtt9bgKqb4u5/8a
    8IJKB8PuxGLcx8poTIleEuecjK4qy8N2t2e3wQg6RoDsR1lioVSVaTl161s1zHnHhrSX
    /GsAjrl0okrY9wTVvv+KlGSYD/zQRWzSZVgk3h0mDjNvshFmfM3Z6+Dt4t6QCZ7Xb4qb
    AftY16TyLJaxblks9R+k/cPzSYYNZKwX/oIClkQAg3bhKQQZ5a9GoGkcmv2TTe7inFmd
    vtwrNM2dceh5Rmzv4M8V92wvtV+86crK0nOTaQqOZTcZ54SRnSfWOVkw1jhDZbhCT7qR
    BaLg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1744794403;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=zOW8y4ZxAdgKVdn2iWnJ2lX4C+0JOVQxYzNFRthSC1c=;
    b=sfi8pH5aAE40xnD+mS7K+Sv90NapfLE0jooN8UBZvUjqERRfTeeoeFjra67d3n5roN
    ad89UmALH+9oBeZAFr4mvwfhW4pliXxP0VdEXh6/GN8q6LV9aye7b7piZ6bO1kIH6vJ3
    /4J9rnNtAOoMsUS+8FFlA/bjlHDdEdnp0o7QC/DtT4ao2NXSuuegXL41RfCkeoL4tUuA
    WrVkI3gWuWCBEEHm4tRbX0NYf0ZznPK0Z+sY8TB/YNiP9dbXJX/rc5CHrBdgoIfkc0CJ
    2JrUQEO4ynw+hyi+ibPOhlI56OYJW8jYh84k0HBSohxSd8F5typRwItpprkfyagWFvPo
    W2/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1744794403;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=zOW8y4ZxAdgKVdn2iWnJ2lX4C+0JOVQxYzNFRthSC1c=;
    b=NdCakdHlhAYQqBLtAsxS8pCzBwFPnCsDvBMNdzQS6wJ9Jq9sdUjTqYAoQjtqMPCA+v
    nURA4J9VTV9GOGZyigCA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKbK+LsAASc="
Received: from open-xchange-core-mw-gw-6.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z2a34013G96hq0R
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 16 Apr 2025 11:06:43 +0200 (CEST)
Date: Wed, 16 Apr 2025 11:06:43 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1262728637.101069.1744794403686@webmail.strato.de>
Subject: Request for reviews for 4.4-st63, 4.4-cip98
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.33.60
X-Originating-Port: 54634
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Apr 2025 09:07:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18505

Hi!

Here's the manual backports for the upcoming 4.4 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

2a7220968ef9 nilfs2: handle errors that nilfs_prepare_chunk() may return
a19568ab17e4 wifi: nl80211: reject cooked mode if it is set along with other flags
8004e7ee132f acct: perform last write from workqueue
cb22ed056a63 pfifo_tail_enqueue: Drop new packet when sch->limit == 0
91ae321630a0 geneve: Fix use-after-free in geneve_find_dev().
89f949a9d75c ipv4: use RCU protection in inet_select_addr()
69c4abc86ee6 ptp: Ensure info->enable callback is always set
c9bd974f385b tg3: Disable tg3 PCIe AER on system reboot
08f7a045863a usb: xhci: Fix NULL pointer dereference on certain command aborts
76519d4fbe4b net: rose: lock the socket in rose_bind()
719d7bc8be0d rdma/cxgb4: Prevent potential integer overflow on 32bit
b3b9ee117046 team: prevent adding a device which is already a team device lower

Thanks for having a look!

CU
Uli

