Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CA8FF885A
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 18:28:26 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21720.1777919296148779583
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 May 2026 11:28:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=bDLkJauZ;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=em17Qn2S;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.218, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1777919284; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DU/eDoJNzrBF7SXpssw4dIAruYUNvK8SJh7CMQ9srPPZLlXt/OMch+rsQobir+M9vW
    qpoay/ZTDRE2KQ6DIQyWW+P6sFuEASqvE15deGii4JMHeLLRASce7cendhmKzZZWun4f
    QHUSWw2MJxEePLO9ErtMt0+2FpIbFcFTT6umevjxmh3lxALhqGyk4BV7IztSj51YABwO
    eGVYyrCs3W87kyqgckNiuixV3vX19NvX/daHz0fM4WwTrUYMLp9m5KZ+frL27wJ9abYF
    WyYjAnR2PSuO1cGGg0SXjcwHRQ2OF7ZPXEZhRk8KZtoGuz9wgjBu6UDx6iMdxSiLPxZc
    cZoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1777919284;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=s/6Cfr/J9UrNH3Oexh+pZnmTiFCMX5QHBoT/cbhjoVQ=;
    b=jvHc9IhZWKVoBDDELf0n9emcI9Qq9ONfO6H2SDyDnwUO0yP/SEXawEZ8Pc+h6I9w0m
    9wtS/jeYtqbvkV/IQ2bKPs2saLWfIg7hUmZL3LdxkUqYJkaSRwNpCfV/YSWlwSwjak1g
    rkQTANeFIU92SYGbOUmrqt3JyA43iiXA4Il4j0dbYFMJCe7gckrQ0NvR9ey9mimdwnvx
    KCNB+3ACsPx/96jYfQ5M6wrpEJq7yoGuAJWktMhYop1Z9uWMNqDA6do9CLhvAVHXBWY3
    7oBl7BdjPtLDxPHCx7bH4G343EiwYYySKp7JwSwhfb/Nyx+uVlIEFRGdEZjn2DcQxR4K
    BF0A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1777919284;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=s/6Cfr/J9UrNH3Oexh+pZnmTiFCMX5QHBoT/cbhjoVQ=;
    b=bDLkJauZn7ihDCWmDaQoxrSZCFm/5rv29kEt0Ry5iSDtCjqw692ckOY6nFOO3RNWa9
    I1sfn5w9kcOTQnGjsArds13mgaC4JHU0/G+LK3ix2RiCt9lWTY47Kau9cBxpGMMkkk6J
    xVHR28LjjlO/4Pe+iMBz7n4jUEJ2vdO+U58p46jww+Hs7cV5/Kh74MT6RxF3noTB3EZc
    eSsBGDOV1gMs9ICrhKiEpcYcPRIXDN4okP5OQds6FYirZJO8ezfD1LN03dJwZEWL7IqW
    sI4GpH8CObQ82x5IftUObUVwfaVOipPfyLaRcDULxNIVEyXpVLpvsrfVO+uCN7a0OkIW
    TtVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1777919284;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=s/6Cfr/J9UrNH3Oexh+pZnmTiFCMX5QHBoT/cbhjoVQ=;
    b=em17Qn2SLa6nmQxs9bK4Z5/GX/V4pFMK0sIeIuL7+LCtSPna26vUfUXVgslElHAR1M
    X5sWWdfYoVOWe1aYG6Bw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKDG+LdTmA=="
Received: from open-xchange-core-mw-gw-8.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z7806e244IS36pT
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 4 May 2026 20:28:03 +0200 (CEST)
Date: Mon, 4 May 2026 20:28:03 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <483138290.348854.1777919283323@webmail.strato.de>
Subject: Request for review for 4.19-st16, 4.19-cip132
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.88
X-Originating-Port: 44438
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 May 2026 18:28:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22864

Hi!

Here are the manual backports for the upcoming 4.19 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-st-rc

c2d401e101f6f x86/CPU: Fix FPDSS on Zen1
f6b624b78e703 seg6: separate dst_cache for input and output paths in seg6 lwtunnel
5e61028ae2137 netfilter: nft_ct: fix use-after-free in timeout object destroy
f7c9c8b6a3c7e apparmor: fix differential encoding verification
48287285f14b5 apparmor: fix missing bounds check on DEFAULT table in verify_dfa()
91c9727179f31 ext4: convert inline data to extents when truncate exceeds inline size
ffa20b32fd35c virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELEASE is cleared and napi_tx is false
2ae9ce04a67ad ipv6: fix NULL pointer deref in ip6_rt_get_dev_rcu()
29acc58f3339c crypto: authenc - use memcpy_sglist() instead of null skcipher
65888314e8d59 crypto: algif_aead - use memcpy_sglist() instead of null skcipher
1ace4d448870d crypto: doc - fix kernel-doc notation in chacha.c and af_alg.c
5b3a91c42591d xen/privcmd: fix double free via VMA splitting

Most copy-fail-related patches did not require a manual backport from 5.10, but in case somebody wants to give them a quick look anyway:

ebdc118c0b26e crypto: af_alg - Fix page reassignment overflow in af_alg_pull_tsgl
c179b717b58fe crypto: authencesn - Fix src offset when decrypting in-place
7b115c6573f4d crypto: authencesn - Do not place hiseq at end of dst for out-of-place decryption
3a3b130398dee crypto: algif_aead - snapshot IV for async AEAD requests
0bf0afd65c4bd crypto: algif_aead - Revert to operating out-of-place
02b8603f1d1c9 crypto: algif_aead - Fix minimum RX size check for decryption
ab59e176f0f35 crypto: scatterwalk - Backport memcpy_sglist()

Thank you!

CU
Uli

