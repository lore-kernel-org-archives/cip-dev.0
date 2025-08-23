Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B219CA0EE4
	for <webhook@archiver.kernel.org>; Sat, 23 Aug 2025 13:06:00 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
 by mx.groups.io with SMTP id smtpd.web10.6279.1755954354485884877
 for <cip-dev@lists.cip-project.org>;
 Sat, 23 Aug 2025 06:05:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=bGLwajx9;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=7CIekvoj;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.51, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1755954344; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ihvij+Gk+stKE5nT/MgdWw7C++3OLEB+UY7D5+Z9lUtNiyed/rxns+9nznLWtoqJEP
    v6cQWY9L517YKyCFN9EGcMWkNwiXqiTOSw6j5QG147TrSJ4eLMpGEceCeEhwq4ms5TpS
    fC1xmXUnyX9LrN1nXR5Kft26HgD6FXGmVvJ5EgsuAEqtNBPhHjrsIP7LUzsshBXQjMuL
    tf8PSqVG0R1xO/AjKlqdhx+hFxcoZPNfXfbyt8P+wxMFXG+3ZftCRm66HtGiL50+5Zwx
    2XO4wEI3GvwFgW8hiIzpdWUCksoTqc4lPSqy65ozjPhh5bVnNNOCYuJyAdf1rhhdYbW1
    Pyrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1755954344;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=hEJhdKmN2cWeFpJNpP6GKphwomDXaFw5BJtUB5gYwEc=;
    b=FHGMnG/O90PooQtaZpAvlH6q24sP3nCOjBmByHoWNpJrJbcgEhx+4yJzSVaG2Nweqo
    ZmsQpjhtXRnGDI4hiR5wI5WmzGsLFzVyqTZydoALqfprNeWCuAcJa0l2yg/21az8d/xH
    eVb/ijTrTElirWkIb0eSC5pjFYDzt4jbLqtqWjnaTjd8vIUgo7TZF5le8eHUWzL52Qil
    OOFwGgNBb5LpvLEYf6e0t6/3Tt+AsJi6VD4+FgOOFwb+tah7VCjakFwJC+tE8SSODMEs
    uzgyPfvGjmFSUPryv604prIOmCFnaa/s9jU6J2EYTqOAqmR0c6deWJLLjPrtZkISaUBA
    u9sg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1755954344;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=hEJhdKmN2cWeFpJNpP6GKphwomDXaFw5BJtUB5gYwEc=;
    b=bGLwajx9qskqie5ORcY4b3Fo1OvV7I4Ergo8d14gJ6gh8C2qaBf7NFs9zeIKlefz6h
    AE4o0TSfXtLFhHa9m1jxIRXDN8lP5NL5BvuCfchU1A3yGFk1PCaMv8dsm86XL2dWCpUS
    tgwJY7bUT5KEKNFot6H4wzfYM2e6xp0+hQKRb09nnTQwCcT+zX51LlodRmny6/gLaC+5
    1bWJswifZ2Jpyd/74jod1EOKbfHqbfczt1SUQuJWAiz+Ik6ZuY7eKbF2Za436o1rbrRS
    oD5AcaHGYlByUeKLcbrQsePMJ+PIkP14VkO79LyXdHr06Y6I1k528l3GsDNfXMtUEJXR
    eYzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1755954344;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=hEJhdKmN2cWeFpJNpP6GKphwomDXaFw5BJtUB5gYwEc=;
    b=7CIekvojXe/lOC9BgWaI4FtnberIIssMTdp/cYQ/A+YBYMzH9a4JzKq3rr4zwZerCa
    5JMpi/zzBCymY7w5v9Cg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKLG+KwQlg=="
Received: from open-xchange-core-mw-gw-31.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 52.1.2 AUTH)
    with ESMTPSA id z5ff6217ND5iA0O
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 23 Aug 2025 15:05:44 +0200 (CEST)
Date: Sat, 23 Aug 2025 15:05:43 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1277181115.2080.1755954343886@webmail.strato.de>
Subject: Request for review for 4.4-st67, 4.4-cip102
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.38.83
X-Originating-Port: 41124
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 23 Aug 2025 13:06:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19955

Hi!

Here are the manual backports for the upcoming 4.4 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

229eae116b5c0 mtk-sd: Prevent memory corruption from DMA map failure
06c0a5014dae5 btrfs: don't abort filesystem when attempting to snapshot deleted subvolume
f9842f07b9a20 net: ipv6: Discard next-hop MTU less than minimum link MTU
fc8b9ad41b46e atm: clip: Fix potential null-ptr-deref in to_atmarpd().
a527c7ac6068a mtk-sd: Fix a pagefault in dma_unmap_sg() for not prepared data
deaec106a3477 ceph: fix possible integer overflow in ceph_zero_objects()
d3fac163823b7 HID: wacom: fix kobject reference count leak

Thanks for having a look!

CU
Uli

