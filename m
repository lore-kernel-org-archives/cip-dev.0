Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BFDCD343F
	for <webhook@archiver.kernel.org>; Mon, 18 May 2026 20:40:13 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7159.1779136810795283448
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 May 2026 13:40:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=LehMjFGG;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=PmxgKdUG;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.21, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1779136795; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kgaf0sKuFK9hM0YMRRHPfCtDBCKwK+0WmqLofS2qNbcB4OY4NbKYn98AVZL8EBjQff
    uA6Y/pxxpA122THF7CnbE71zFmL11g05ZiPKQ91GOr6PUoYt/zeGpLonLm7Tu1tD9pOs
    kVuvYwPNTF17jdfv99a/+bzpRZRd4ctbz8sLwXWtANubKQM0YptuL5JoWQXymJZHAaGc
    rT/fziSAtxRnfV62EaKflGAnmbUNBd1YfB7MnKg2xSYGkR0qaD5XnbIQv8ebgfgD3pJc
    Qwr6SXHOlzKO6QR+bd8z1L1ZWbo4KTo92IbuOY7i4LvP50o5rwfksPVVms+WbVV/CYhW
    MnAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1779136795;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=0gbVokiqe65r9J4NmEdtfxiTXs3Z1ZnY5Uh6Y58srQ0=;
    b=tA9AjdbEbHp4RaHnCrLyw6TOxWRqc80/WbUmaemx6/32E4PvEbIWdj7WNrx9Nlxba6
    eWFPVdsp16sNhCJEVEVe69fHOCR/eA8vyWKWEhdvsgOD0Uz9Qi5VUnw9/hzwmFqY7OdL
    Y+ZRS1kiB/rciwIBx07v0YIp4kPBbRrowpMotFbF4ljlO7WiIPH0Z2BhHhT7G0VUor6J
    JCePgF9AFiZE0vZeyVz+OHW/rlLskqRf1wQeLrcNOjatulDUbgHayB8jUU9RUGzDv28T
    k6D/BrV8IxDj9nGNQJbk6rhmCP7C4l+oojrNfmeCGm02sxx4dM4CZkOHXne3gYZBnxaW
    7jbg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1779136795;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=0gbVokiqe65r9J4NmEdtfxiTXs3Z1ZnY5Uh6Y58srQ0=;
    b=LehMjFGGF32a7eL948w92oprsnAbHE8pMqjhf+z/D3WIwu0hFQ0ZMbUwMXCGZuCyMm
    6w2QsmwE1kczNVdLqoMC04D7klNOGk+A1e9WAApEO3bd+TD2jEcQCGvm3O/Q2D1zQq8b
    Hz6RO3FMux+vCKN1gmTeUU5M6q9Uy9mvaAk889r6JCfURqxNkAYoS9NWILxzuzRiBYU8
    TZfi1quHQ3mAtKTYrprFgTRhnRDMlsUN21ToB0UYk2hYLcZHjgB0jwr9Dih+aPqpNeoo
    JI+p9DGsZMZxyWZicn1du/xrX1NsxCBy7uBzErBHZkow7Pz5JnnhknbEw2Z2ZRh8ncVo
    N+Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1779136795;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=0gbVokiqe65r9J4NmEdtfxiTXs3Z1ZnY5Uh6Y58srQ0=;
    b=PmxgKdUGPoo7f7jn/pngAQEtUvB5ZX29+CdDbv4DPC0ox3+T/VYE4eUQdDgh+Gh8PB
    JfPaFi8Gs5FLMXVUVYAw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKDG+LdTmA=="
Received: from open-xchange-core-mw-gw-36.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z7806e24IKdszA0
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 18 May 2026 22:39:54 +0200 (CEST)
Date: Mon, 18 May 2026 22:39:54 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <596572994.133475.1779136794242@webmail.strato.de>
Subject: Request for review for 4.4-st76, 4.4-cip111
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.88
X-Originating-Port: 50802
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 May 2026 20:40:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22976

Hi!

Here are the manual backports for the upcoming 4.4 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

1369f9bda4b79 x86/CPU: Fix FPDSS on Zen1
3f64e9548b885 virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELEASE is cleared and napi_tx is false
4a2616a1bc204 net: stmmac: fix integer underflow in chain mode
bcbb001290534 netfilter: nfnetlink_log: fix uninitialized padding leak in NFULA_PAYLOAD
0e368cfcb8d95 PM: runtime: Fix a race condition related to device removal
596467b2c8a25 netfilter: ctnetlink: fix use-after-free in ctnetlink_dump_exp_ct()
5964034f67b50 netfilter: ctnetlink: remove refcounting in expectation dumpers
20b9c909f5106 net/tcp-md5: Fix MAC comparison to be constant-time
f8f81dfa5ec62 btrfs: abort transaction on failure to update root in the received subvol ioctl
f949f9c5b025a usb: class: cdc-wdm: fix reordering issue in read code path
031802bdc81c9 net: usb: lan78xx: fix silent drop of packets with checksum errors
e2402f11daafc xen/acpi-processor: fix _CST detection using undersized evaluation buffer
d46bd876ce21f drbd: fix "LOGIC BUG" in drbd_al_begin_io_nonblock()
8a344e750e899 media: dvb-core: fix wrong reinitialization of ringbuffer on reopen
0ca67aeb9a9d5 wifi: libertas: fix use-after-free in lbs_free_adapter()

Thanks for having a look!

CU
Uli

