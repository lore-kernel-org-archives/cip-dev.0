Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C6ECD691B
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 09:39:27 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
 by mx.groups.io with SMTP id smtpd.web10.87397.1696930758528043803
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Oct 2023 02:39:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=J0Q6cvim;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=P/xUtfOV;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.164, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1696930740; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fhDbkaMAR5adoBv2JBYnjQkV/kZmoUoSwLj38WipR5x/8hkmdKA5lIRjloeDHGQpDt
    1hakpYOVKLzfiZKKQIwy5UQMcVj6QREZuTa2K9+bQCuW4o34c+EdHjLZg0SgBvAZ227u
    43bNm/kVameIae7oqjxCeU6rIdzwA1A/ep++nNslGwD83I3tVFEQElez/EMbEJW77uec
    N6C+c+aF8dZxinRrmg3C3CQHoMbsR6MPvHgiK4LnSrhH5xbUvyqY7/QEmFW35G+MQQhY
    vo+TY1HWpH/dnUGViQjvU5IBxiU9+oZlr0yfTRlJ8JpnHBu1RGj2Rt+LprKuCOo1daLB
    JyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696930740;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=VTGUilM7//a5GT2TDNmy/G8SmP+7te4OUqYfJqCZt4s=;
    b=VgIaQchoBn8sagD1ldvFmx+cBmhNqN2IAdAbu7x8gLnQ7KGlndJc6OaJUGTYUS36tH
    CwynTx1Y1r1NKxGB5ruUJTscYyazC7p4rDY211JFL5fXayOQz2hRD8XTP5NyqmrSHaDh
    7migIqPCfX8tgl4ZU6qACCYSPoSRXG9aouT6G+/BDpQ31wYHlW2FeP5Nhh005J8VKUnd
    LLAHNVoCUEdUm+rIBU/O1aSYx83ifIqhvquIiX6717bs859CGKdABfMajTiBCjokUA/3
    lm+KAlD5FnYUjm6Fl8d4zznVaO+z0Vv1kPcrm21ufcpRC9NtRmtPGM9Gcv+WSmbN/67E
    3+2w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696930740;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=VTGUilM7//a5GT2TDNmy/G8SmP+7te4OUqYfJqCZt4s=;
    b=J0Q6cvimOmvpztc6dLa4ooWZnG2CfeBG/omQRqdvjscggZZC3G0rNs2763C/YbWYDe
    itL2bu4415QmMr3mZkcsdLTM4v/ZovPdbYLUahu5S7kmqFCfsdvgK/1uVIq+9cPxtXJo
    lJ/JY9ryMFWKGYkSZdwYyfYWYOF/dp52wG+lO/cZmGqPKYsPtd/HLKpJfGnJgll/gicE
    kYqnC+u0/n4m1fFnSRwR0mGYocV/EOLlZSy2JCVFBkoENtSyJE5vRPDC6L7Wu6fIx9Ps
    sfrm4g7qQ7IqWgmW8tHQV8tAcd2UfZBhdLQGR2FqBMcgRr7coHU8YQj5+bwbpzbxcG9a
    ikcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696930740;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=VTGUilM7//a5GT2TDNmy/G8SmP+7te4OUqYfJqCZt4s=;
    b=P/xUtfOVtiISIHOvOdu8cfj5WeuIZdlWTER6Mv9glHzFTaspEpiD2bNQMnTDS9Tqqn
    b9tI8YCzCg5Em25ouBAg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGl/w2B/oo="
Received: from ox-live-app204.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.8.2 AUTH)
    with ESMTPSA id L04889z9A9d0v6k
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 10 Oct 2023 11:39:00 +0200 (CEST)
Date: Tue, 10 Oct 2023 11:39:00 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1006992986.1561214.1696930740389@webmail.strato.com>
In-Reply-To: <1080488313.1558493.1696930231259@webmail.strato.com>
References: <1080488313.1558493.1696930231259@webmail.strato.com>
Subject: Re: [ANNOUNCE] Release v4.4.302-cip80
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev52
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 09:39:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13348


> On 10/10/2023 11:30 AM CEST Ulrich Hecht <uli@fpond.eu> wrote:
> the CIP kernel team has released Linux kernel v4.4.302-cip80. The linux-4.4.y-cip tree's base version has been updated to v4.4-st45.
> 
> You can get this release via the git tree at:
> 
>   v4.4.302-cip80:
>     repository:
>       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>     branch:
>       linux-4.4.y-cip
>     commit hash:
>       9d8a98baf1746169e44d49ee6955a14ae35cc993
>     Fixed CVEs:
>       CVE-2023-1989: Bluetooth: btsdio: fix use after free bug in btsdio_remove due to unfinished work
>       CVE-2023-4128: net/sched: Use-after-free vulnerabilities in the net/sched classifiers: cls_fw, cls_u32 and cls_route

Sorry, this list of fixed CVEs is incomplete. Here's the corrected version:

    Fixed CVEs:
      CVE-2023-1989: Bluetooth: btsdio: fix use after free bug in btsdio_remove due to unfinished work
      CVE-2023-39192: netfilter: xt_u32: validate user space input
      CVE-2023-39193: netfilter: xt_sctp: validate the flag_info count
      CVE-2023-4128: net/sched: Use-after-free vulnerabilities in the net/sched classifiers: cls_fw, cls_u32 and cls_route
      CVE-2023-4207: net/sched: cls_fw: No longer copy tcf_result on update to avoid use-after-free
      CVE-2023-42752: integer overflows in kmalloc_reserve()
      CVE-2023-42753: netfilter: ipset: add the missing IP_SET_HASH_WITH_NET0 macro for ip_set_hash_netportnet.c
      CVE-2023-4921: net: sched: sch_qfq: Fix UAF in qfq_dequeue()

My apologies for any confusion that may have caused.

Best regards,
Ulrich Hecht

