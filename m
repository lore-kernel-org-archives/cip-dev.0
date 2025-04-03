Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414FDC3600C
	for <webhook@archiver.kernel.org>; Thu,  3 Apr 2025 09:44:00 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
 by mx.groups.io with SMTP id smtpd.web11.9537.1743673437108106202
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Apr 2025 02:43:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=XuCPZ4eu;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=JfZMt91H;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.217, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1743673424; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mL+jio85oik+G86gLVSRks0Yn6rlRsO1jjhaDuEV6BosBI472vAfytB2396v2jPZGp
    DrwJ5H/nOWgiJvCMgeRBZQ/pKsC8Pg1mGdxRgFe1Y5XdIw8rFQ5PQ+SUUfMKmgIJRTaj
    R53Y9PVbJvJTZzGOfirczcRW5NFCDs7oz4a73+z8FU8IRdoKTCgMlurT2UcRMkVThPCh
    VHXTypadPtx7AHU3IQvAFpdF1FhrAJWvzdNJ6jhUEG6sOL0mrzPEgeEWvGQOL8Qme+/D
    Y4fJK33Jm4efKglkoghOLJRfARuihgusa4fvK+AHhaoOFcIxiOwnLqQapX9XUPYdlPa4
    iOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1743673424;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=GmJ/HBQuoRf8bnyKSWwuzz/ob4Z4uu5o3Q++z/AOoKU=;
    b=inv/He5bzk06M4ZoNbfVZUOHcz/gqAA/yxgbuJlskE5mN6NCUDsoPfA0fKzAmvSGwr
    6H4ST2g+PDfS240rFiuYiWA5LRWISVjSOwrpBZomwWERvB8yLS8bPI5NblpToxrwqNjR
    bVB5GB10NgA+k20wIgkDt6mw94uqqj7Mny7/lVbFIbtRFfH3si18vz0ffU59irp2xIAA
    z/71Yiua7mASj/OFd6aBqOFtejk9rnR1t2pzk9HZcOlIYS6tV93oDTj/hKr83pp8e2dR
    cO1oNvdMjGIgnMyXoMKK+Zec9AJOSyN+cN2elJ8PHSkuWgpv28lQkrr9zTWeJJnLkyRL
    UlXA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1743673424;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=GmJ/HBQuoRf8bnyKSWwuzz/ob4Z4uu5o3Q++z/AOoKU=;
    b=XuCPZ4euMGvqlyac/TPwpGb+OrvAwD9RFNtSHNOC7c9hgYo1nJ/tBFw5ULXvKUIj3a
    tRAGW0A0sBUwBVYfzS9QoEAV7Y+9Cy014fqjlml5mHu9pXRAWW18nCl3j3iYJB37waE4
    fyCirr1H9hzSRqfjbTVTn58LVGVlM9rLKOOJfqfvt59aagETW8IoOtF6mouQ+yr4P/h4
    QeoIqFZIpPYkTD9ghztmPvhs9baYWKNecFzZB2gO0j42vGwC0gkyTjDS9CfQrTZx/Ps8
    IizNXnQDTAS6V6kTeoeJ3jdy9Q0CLyK/eScAVPXJPAWRcXl3K8eaDB2cu8uwL712yxLP
    mtfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1743673424;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=GmJ/HBQuoRf8bnyKSWwuzz/ob4Z4uu5o3Q++z/AOoKU=;
    b=JfZMt91HyiFwfy7GigNPZ9u2XWCAX49gt5WdsUUftZH/8ktKnueytawvyyNuEe6fRN
    iFmMNLuYKtsOGS+4k8Cg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzotGZsghGuz3zLu2Y2"
Received: from ox-live-app401.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z2a3401339hi1kU
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 3 Apr 2025 11:43:44 +0200 (CEST)
Date: Thu, 3 Apr 2025 11:43:44 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <717776371.819202.1743673424632@webmail.strato.de>
Subject: Request for reviews for 4.19-st3, 4.19-cip119
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev73
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Apr 2025 09:44:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18460

Hi!

Here's the manual backports for the upcoming 4.19 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-st-rc

1b1e6b6e3290 net: gso: fix ownership in __udp_gso_segment
6ba7acd180fd gpio: rcar: Fix missing of_node_put() call
d643f3984b9a batman-adv: Drop unmanaged ELP metric worker
b53c91a6173a tee: optee: Fix supplicant wait loop
e1705bb093cc pps: Fix a use-after-free
f3b89c9ef6c1 net: rose: lock the socket in rose_bind()
7b102256a506 btrfs: fix use-after-free when attempting to join an aborted transaction
c283df6d5cce media: lmedm04: Handle errors for lme2510_int_read
d4ddd1298e3b wifi: rtlwifi: remove unused check_buddy_priv
f71199fc4170 wifi: rtlwifi: rtl8192se: rise completion of firmware loading as last step
a63a48e6da4e x86/cpu: Properly parse CPUID leaf 0x2 TLB descriptor 0x63
4b60501002d7 usb: dwc3: Fix timeout issue during controller enter/exit from halt state

Thanks for having a look!

CU
Uli

