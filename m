Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AD6CDE008
	for <webhook@archiver.kernel.org>; Thu, 25 Jun 2026 11:41:50 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9497.1782387705439566227
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jun 2026 04:41:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=XAFT+OG4;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=17pFsEnz;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.25, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1782387697; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iumMwMcerYNBZeUbbBk6jTycgB7no7dx4NQ8uMavxO1pZIpcT4+Z22U5tw71lvgafT
    ggNz5p0LhMJSfe2kVJiJIKNDHbPZ12A2EfNYCah1MRM7+2Y6G45lJigIg+wpEAdZca1O
    dF1gnyjLRgwcqMrzK0SrCYUCQMPfyxwV8E0dnWtOO3A7l1zcFzHNX+LCF1NHgC6P51vl
    DxBoqq00pT15YU/uh1beEjgFxFvOuXmqjJlQk6B9OKyCpjQDBN2epRHRFoArxocOAuUT
    2k3UP6aGNl+gLNoKq8/fvu5JDItC6qlyPXijDz77+Xiy6DtpHoqsVeUIXrybGyKT14xG
    7P6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1782387697;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=8e9FjQ+fc85YlUSeTattSDfdUw75rFSEddrUBr3oWdA=;
    b=hUe4ve0ExDfiRrtV9s40A+TXWmceRWBzzwxQq4RjR8+7Zm0abuJeIaCOYqzP8Y++C9
    i+QzK1f11KEeJQY5vy7e0mOPlG5VpIsDimVunY+kEHjw7zrpvkq5t/1bZbfivzKMHVAb
    MzuLjYvpHNDb3FYfHedTuhtsTfZGg52epnBrbGQK62GbAUBR/4ZLrheWmZx/Qgj1glsI
    arNol7u6f/xFsw008M1qylTyHl0+PkMpwZYQOOl2ffjxlD6MRNtUyBrdmdZdd6DDbn/+
    R9XuTs313xPeW1P1K4Nmf6jsE29CPLcjYZUq/wwNYbXk+oD6K8Me0lzx3XZUdUWTh7pO
    cmxA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1782387697;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=8e9FjQ+fc85YlUSeTattSDfdUw75rFSEddrUBr3oWdA=;
    b=XAFT+OG4y5VAxvUC3ihU9R4x75Dj4hve/gzOfngx2VnE5cWsvHoUD4nikMg1NZUn7N
    YWdeWsVNr26K6k9xiAvD9hkZpcxfkn2aaGbM4iSq5h/iYMa3EHIiVu5TRwuRsfng+8ci
    XdPCD7yVaFJtEEcSnInY+yI7mfRx7Hpfsosx31jUT9QIKlTAmKtpTnp8ZCaP5fiksQs3
    MXCFIQPbNIww6E1UiJ89Wc6iXK3aRHjU1bJRqmCt7drHlyPkYMaMvBsATVoqfu0ujIHA
    LBoMgo41mynlbjFVUJm95N+El3u4sk7SYoCyiAir2qvl+hKPGvSk5dIFOMpvbaLxpZwy
    ZTqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1782387697;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=8e9FjQ+fc85YlUSeTattSDfdUw75rFSEddrUBr3oWdA=;
    b=17pFsEnzKO6a0WpMGwUtRpfIqOpd3fo1ku5lAnbyCi2ZB98O6IPhZ/BuV1/PG44xcH
    mgh85Ee3LLZ7VOaJAOCA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKDK+NL2bA=="
Received: from open-xchange-core-mw-gw-8.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.5.6 AUTH)
    with ESMTPSA id z4c16d25PBfa4kZ
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 25 Jun 2026 13:41:36 +0200 (CEST)
Date: Thu, 25 Jun 2026 13:41:36 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: Pavel Machek <pavel@nabladev.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1499056909.441993.1782387696750@webmail.strato.de>
In-Reply-To: <ajlAxQVzhGGpBs0w@duo.ucw.cz>
References: <92480685.1219204.1781878850004@webmail.strato.de>
 <ajlAxQVzhGGpBs0w@duo.ucw.cz>
Subject: Re: Request for review for 4.19-st18, 4.19-cip134
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.142
X-Originating-Port: 52708
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Jun 2026 11:41:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23281

Thanks for the reviews!

> On 06/22/2026 4:03 PM CEST Pavel Machek <pavel@nabladev.com> wrote:
> ? why the null check > ac6678cb12932 batman-adv: clear current gateway during teardown
> 
> Why the added NULL check? Mainline patch does not have it, and it will
> not break anything, but I don't understand reasoning.

In mainline batadv_gw_node_put() does this check, but in 4.19 the caller is still expected to do it.
(Found by LLM.)

> a > 8a8f72ed32162 netfilter: ipset: stop hash:* range iteration at end
> a > 239972f582859 net/sched: netem: fix queue limit check to include reordered packets
> a just a interface fix> 290ca3d4cc0fe cdrom, scsi: sr: propagate read-only status to block layer via set_disk_ro()
> a > d09410f835071 btrfs: fix double-decrement of bytes_may_use in submit_one_async_extent()
> a > 8134eaf6adc42 tipc: fix double-free in tipc_buf_append()
> a > 02d2ac7f84d00 slip: reject VJ receive packets on instances with no rstate array
> a > 50beb65e59221 netfilter: nfnetlink_osf: fix potential NULL dereference in ttl check
> a > 602bc47c8749f crypto: ccp - copy IV using skcipher ivsize
> a > b9d8a2d537ce9 wifi: brcmfmac: Fix error pointer dereference
> a > 041440c0902f7 bpf: fix end-of-list detection in cgroup_storage_get_next_key()
> a > f43b5f55f017c crypto: authencesn - reject short ahash digests during instance creation
> a just a hw bug workaround > fa4149888d92f mmc: block: use single block write in retry
> a mostly a robustness > 0ecdcd07a75d2 crypto: ccp: Don't attempt to copy PDH cert to userspace if PSP command failed
> 
> Hmm. This is wrong. In case of argp->error, we'll return 0, even when
> we have failure. AFAICT same problem exists in mainline.
> 
> a mostly a robustness > c14d8dc588ad5 crypto: ccp: Don't attempt to copy CSR to userspace if PSP command failed
> 
> Same problem here, we'll return 0 on argp->error.

Looks like it. Since this is not a backport problem, and the code with the change is AFAICT less bad than the code without the change, I'm inclined to leave the patches as they are and assume that fixes will come from upstream if this turns out to be a real issue.

CU
Uli

