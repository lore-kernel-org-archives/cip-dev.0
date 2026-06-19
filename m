Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0367CD98F2
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 14:21:15 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43588.1781878865458704609
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Jun 2026 07:21:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=EymmjEcw;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=vEa1EE+b;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.25, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1781878850; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Qjym7GVAroLjXyP1XZK7I5wLy2E3neHN0ZB62FhC/nqJYECPOkqXHok3jywKSXA1sP
    HwYL1Te0qF0eQXGQLJmHtfhguPze1OFcZGj72AqEK5HQ+sOFm+GiVvzkJJX23xPaEyhM
    VMfT42LdAt5awTYcn5+HCQMF5Bm4kWzzBa0k0JEoqxHJm3KcoR0KVY56kVZSBMVRHsP8
    d+4fvvazsmSK4vdnMCwQpI1ZbCUtx0GpJ20B7CIXMTycOe3MMXqZh/rtKmBJ3+l3r3jb
    q2+AgmoBNsRVZpJlKhrXbXFUcZ1jmsY38A/KBA3/5GPbv0y3JsE7UAd3SteWWJ9ObfHJ
    fueQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1781878850;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=JUA80XlrVrvBwnJHYaQq67O/gjHG0/7O30m7cMqDnXE=;
    b=WFtMaxNoqX5Y/6xX/lS3w0fPVGTmq0+6oVpk8ALvlOwldmbBcDzK/j2pGDGgz4yJPA
    MeQO4jIRJVcjnScQJ/i/HQRF56vA9VOGTnlrUBbysRTTvUTiD2OynOEIdUbmGz1Og8e9
    lpA4Y08dPkLHwHop3wowqBD1c5sL7FJMSco71aWW/f9aQxfuGCNBavyY+G+DXJCn9aeh
    p61+npUrkz3cW4YQFkhIXv6Mg2j60n7i2SJF2W/zgABCAPPnnyBP3aubPS0N0+Z7s+CB
    H/JnfZvI6LHUKZLD7ayt0lejp2x3/2oIOPBwOTabz+Pkg1ONkmo/nACLZ6ZePFZ21oK8
    8yeQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1781878850;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=JUA80XlrVrvBwnJHYaQq67O/gjHG0/7O30m7cMqDnXE=;
    b=EymmjEcw6aBE/hVIbNvOfx/HEd017SrVRgR8G1ZscvcbjNHab/BUDQnMsac5y7pB6Y
    xyPB2oq9lEffZfk8u0RQ4S+9hQ/nvbqncxQmJ1INbXXQCWXYuIAvRlgGu/jTXuCOSTdK
    Ty4ItYa3dmV2qrB9VZ2vPu08FivqNjaGmBWFQRNnSiZlwLxx/noUkqtmsB4ulDwRoFKn
    u0xwTt4BABQaiiRzwbQI06X4FEqGw2qiC2dBduCqZLJzUHWTFjBv8oVQe/TXquj063g8
    EhJET5zYMVEwy3AjVcGfvZnWHredTuPeMPwPmiQRRc5qHxc1TXHD9SIIEcKWhrqMckAa
    zZ+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1781878850;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=JUA80XlrVrvBwnJHYaQq67O/gjHG0/7O30m7cMqDnXE=;
    b=vEa1EE+b+FGfsKzUuBLu+f8IiW2/ORzQ4+/IFo8vfwGj9QxUdmfLxBBAikTU57MhEZ
    87uuID09tu80lzzioyDQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKDK+NL2bA=="
Received: from open-xchange-core-mw-gw-4.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z7806e25JEKotvF
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 19 Jun 2026 16:20:50 +0200 (CEST)
Date: Fri, 19 Jun 2026 16:20:49 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <92480685.1219204.1781878850004@webmail.strato.de>
Subject: Request for review for 4.19-st18, 4.19-cip134
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.142
X-Originating-Port: 51724
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jun 2026 14:21:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23237

Hi!

Here are the manual backports for the upcoming 4.19 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-st-rc

ac6678cb12932 batman-adv: clear current gateway during teardown
8a8f72ed32162 netfilter: ipset: stop hash:* range iteration at end
239972f582859 net/sched: netem: fix queue limit check to include reordered packets
290ca3d4cc0fe cdrom, scsi: sr: propagate read-only status to block layer via set_disk_ro()
d09410f835071 btrfs: fix double-decrement of bytes_may_use in submit_one_async_extent()
8134eaf6adc42 tipc: fix double-free in tipc_buf_append()
02d2ac7f84d00 slip: reject VJ receive packets on instances with no rstate array
50beb65e59221 netfilter: nfnetlink_osf: fix potential NULL dereference in ttl check
602bc47c8749f crypto: ccp - copy IV using skcipher ivsize
b9d8a2d537ce9 wifi: brcmfmac: Fix error pointer dereference
041440c0902f7 bpf: fix end-of-list detection in cgroup_storage_get_next_key()
f43b5f55f017c crypto: authencesn - reject short ahash digests during instance creation
fa4149888d92f mmc: block: use single block write in retry
0ecdcd07a75d2 crypto: ccp: Don't attempt to copy PDH cert to userspace if PSP command failed
c14d8dc588ad5 crypto: ccp: Don't attempt to copy CSR to userspace if PSP command failed
3bffafe5e8975 x86/uprobes: Fix XOL allocation failure for 32-bit tasks
2008358d97f17 blk-mq: use quiesced elevator switch when reinitializing queues
e336fb23c682a scsi: ufs: core: Improve SCSI abort handling
6f7e7878e3c89 bcache: fix cached_dev.sb_bio use-after-free and crash
a33e2701e85c8 rxrpc: proc: size address buffers for %pISpc output
7a2d6e91f43a6 can: raw: fix ro->uniq use-after-free in raw_rcv()
5553ed48c310e batman-adv: hold claim backbone gateways by reference
781ff3428d09f l2tp: Drop large packets with UDP encap
b741e14915ee3 xsk: tighten UMEM headroom validation to account for tailroom and min frame
9eddb82dc26e4 wifi: brcmfmac: validate bsscfg indices in IF events
b03bfcc22433c can: mcp251x: add error handling for power enable in open and resume
133952b84ff40 net: skbuff: propagate shared-frag marker through frag-transfer helpers

Thank you!

CU
Uli

