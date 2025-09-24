Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D51CAC5A5
	for <webhook@archiver.kernel.org>; Wed, 24 Sep 2025 15:19:09 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
 by mx.groups.io with SMTP id smtpd.web10.16648.1758727140597849135
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Sep 2025 08:19:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=EhcNTYjk;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.221, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1758727129; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=didvGkLWhQdeu5ztMpnkMGaASf6G5olGX7CfeHCwfwLUlg9ZCf7ucLEpuhlHt/f11Q
    3ci0KhVj6hSBOJeux6FuhgA0z/F1KeIcE5WnD8USCFpomcuo8D8pGoaF29/7U4x1kKQF
    VHJMhoeB3kkGFI43LRNEPJTuAWlMOLjQ/cY7ToQx/n8X/GftmNPJVlb72TFNxRF1md1N
    73pLN+WNKFh7vKZB9XBnmoL0VPjw0s3kCQiyi9hiRUOhj5sHO4fYnmizr9wro2qj8ryr
    ESgakwVTBOtaAit/bizDjkpmsp5inmxNcGA2nJvMcNtBvEHrpKYBNU8y6u2H7DA56DlQ
    f/ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1758727129;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=+2wGT9exwHkD4iumBN6VBuFhI9KPZNNCqsu26MM/lQs=;
    b=kl5D7P65jth+4wcBWyZdergecoS6eXXLE6xnfkAhOztjI60jEnj2G5v8JJe8zK0F5y
    +XIq5rU+ZZzUtveH9cY3g+/t88zcjakNeK9pDsrVeuiH7QZ8Dd6gyiQEm5wDakXbmBLK
    xGLUMeHMmXvnWAzNgUnPOIQi2/uy2TETQ1r22lRwZ8hQECU/WL4rGYk+dLwruuyBT9sw
    92lI0kv8WHFBwTGRTXoiK+ewC94WcnLE/NXVOEMmAmaC1pxijglTEft8aKEG02PoAlVh
    044uFNIxTyBfmVJExAowuxK8ZIToWYTPBCS5UHesrCrQvyP0L2o5CzDaMd2WqpcS1HWx
    91+A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1758727129;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=+2wGT9exwHkD4iumBN6VBuFhI9KPZNNCqsu26MM/lQs=;
    b=EhcNTYjkH6BwSNGJOa0K+RbHlUz/ZMRztSeYHjclfcoY6FGcRjaoaRFHXVa3rEFfpV
    I50xV0HiJUNqBSJVeHUPInMHxlv90ZnR3Ak5gmM763Hcze65+6NKKQBz1vv/fAufHoh+
    T3tKuUnflGkSXfimsFAL5pnq8qq4jINYyoP6n03TqY2CIBkHn1MGIbtMsKgm/PkqQa9J
    D4nU/Lgqgtkgd/KeJOcnL6lTMlRMXaTZzK0+3G8FRxS0iUVCst48L8R2SbuYfXrPxbtJ
    tnOqK+y70W9M6RvhS5zdycmHdehvG/JZHELcGb3KLMM882qhsinPr+daAr+25Dzcl0d0
    jiEw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKzK+A+UOEY="
Received: from open-xchange-core-mw-gw-15.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 53.3.2 AUTH)
    with ESMTPSA id z9d9a518OFIm7cF
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 24 Sep 2025 17:18:48 +0200 (CEST)
Date: Wed, 24 Sep 2025 17:18:48 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <886040472.424568.1758727128905@webmail.strato.de>
Subject: Request for review for 4.4-st68, 4.4-cip103
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.38.83
X-Originating-Port: 53192
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Sep 2025 15:19:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20118

Hi!

Here are the manual backports for the upcoming 4.4 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc
(Probably. I still get stuck in an endless Anubis loop...)

159bdce6d6b70 net: dlink: fix multicast stats being counted incorrectly
457628f8cb01d atm: atmtcp: Prevent arbitrary write in atmtcp_recv_control().
0fe446c3739a9 usb: musb: omap2430: fix device leak at unbind
98463a4924f3f cdc-acm: fix race between initial clearing halt and open
3d068492060e1 usb: hub: Don't try to recover devices lost during warm reset.
5f55f645b658f usb: hub: avoid warm port reset during USB3 disconnect
d96c623bf8136 net: usbnet: Avoid potential RCU stall on LINK_CHANGE event
42e0edaf813d5 rtc: ds1307: remove clear of oscillator stop flag (OSF) in probe
d4532e8667c07 pNFS: Fix uninited ptr deref in block/scsi layout
2f838b922217b net: fec: allow disable coalescing
237504b56084d securityfs: don't pin dentries twice, once is enough...
0d7cd3075bfab netfilter: ctnetlink: fix refcount leak on table dump
ab712c7a36c55 fs: Prevent file descriptor table allocations exceeding INT_MAX
6b5d680b684d2 usb: gadget : fix use-after-free in composite_dev_cleanup()
84e1d7c1d29c3 net/packet: fix a race in packet_set_ring() and packet_notifier()
45aa0cdcd2901 netfilter: xt_nfacct: don't assume acct name is null-terminated
9812a62c6fcbb iwlwifi: Add missing check for alloc_ordered_workqueue
efdf5a1cdd46d usb: hub: fix detection of high tier USB3 devices behind suspended hubs
538d08a48cee4 net_sched: sch_sfq: move the limit validation
9424395985175 net_sched: sch_sfq: annotate data-races around q->perturb_period
8d28e6639a4c5 net_sched: sch_sfq: don't allow 1 packet limit

Thanks for having a look.

CU
Uli

