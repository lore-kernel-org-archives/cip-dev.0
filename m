Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57896C71155
	for <webhook@archiver.kernel.org>; Mon, 16 Jun 2025 16:55:42 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
 by mx.groups.io with SMTP id smtpd.web11.2253.1750092934918718728
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Jun 2025 09:55:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=Ke66rvo8;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=YhZtUI01;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.25, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1750092923; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nDWHis4tOazG5sqLNInx5CUyTrKZFMTqd5T6R+Lxm11ZB9jPzistv1eK4LDVvXiyyI
    BroJm0lvu/I7Aw4pj5Cgy8z9Cri0FMedhBpbdihmGCXvMnl+byyBPL+ylmgYSWBLxtKe
    gjLSsE7JDDX78CZCCmeQ/miF689pLi9fFezoNp49mPDsB5EWkIcYuyjog3VbZH9ZAjOv
    hHsymWKQMexcxrX8nyi1Oebu9ir2ntCE4x81QI7Rj8NcqiZUYbkHWow+mrO3T51yK0tr
    VkIEfTFczCwtnu5PjQJL54cWZEIPfYVQKGisy7ZHRrPMhaPC4gSg4Zd39qQDo/EYLO0x
    fciA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1750092923;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=rB3P7WZ/sUNB+tCvp2vn6nh6aKcqq0hg5BKE3tw+ydg=;
    b=Y7MT9Xee4fM2VbUoDRaRaHR7oTqO8hvuSoQGOY5Pt/L1h1itbUQFPtLgeHN49bnNUU
    jZz4JfyGW1JGg3NaA4FjbUh+hkSY6E5GA4Fi94PxKplxdAfhMa5IGWVTPK2KMbqmXFSn
    hIGuI5eUNPyOih8sYu7FoWWANu861PWAHVfuu/bHWRi2Sxg9GQRi5SyfhFvSalS2HKqj
    fgKp9mjjripsvWoBAt2UHmAA0lzXFrvxROPN6KG/1QK9M/Ma8sVdXUWQbYIumhbCo7WZ
    oLZSyEBls9K2htb5TXq7CvYgRS2E4fWDJM5nMkzwnsRxepJol34QcpRvqykdNUMZ77tz
    +HQQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1750092923;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=rB3P7WZ/sUNB+tCvp2vn6nh6aKcqq0hg5BKE3tw+ydg=;
    b=Ke66rvo8aVtq0y+G3Bfc+lLH/sjb4L+DmpJ88rVR7ukQL+tN1aSVj1JoTCsh8DNuyg
    AwppJfEdIOMBl3jImjIyopkC4/ZGwvq4JYdJN8aonwBnx39aOtQsRYPpi5FRjjVism9s
    Ygbr5DXU4AL8v1TI57itTOg3gvaYljUMBlPuYojyhB01HSxq8B3IAIuiQ+ZaaPh9bsu1
    Qzr/kYPep+Bt2LXhUo3OlZeF3Ztzdie+e3+ti0slgFsD7XhQZTk+51kGpZdnP/f3OxsN
    e9DIuXxQ6s3Sl6WDHTYA6EzRIKe8DtRmJ0HOaH3Ohbn7aRuD+HXua1gUz7cImk5o7b00
    GhoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1750092923;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=rB3P7WZ/sUNB+tCvp2vn6nh6aKcqq0hg5BKE3tw+ydg=;
    b=YhZtUI01WPeYf0U3pW52HiF1O0M5LVHUZhMUz1T1vWIUjweGunqcVEKQPKdffdyJp0
    4wj/HEGWb0boRfQEswBQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hex6fd76vq"
Received: from open-xchange-core-mw-gw-27.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z2a34015GGtMMGi
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 16 Jun 2025 18:55:22 +0200 (CEST)
Date: Mon, 16 Jun 2025 18:55:22 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1652754680.135113.1750092922654@webmail.strato.de>
Subject: Request for review for 4.4-st65, 4.4-cip100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.36.53
X-Originating-Port: 53678
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Jun 2025 16:55:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19110

Hi!

Here's the manual backports for the upcoming 4.4 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

8dab9bb642b2e net_sched: hfsc: Fix a potential UAF in hfsc_dequeue() too
6f43c571bf094 of/irq: Fix device node refcount leakages in of_irq_init()
7f406a4c1fd70 mm: add missing release barrier on PGDAT_RECLAIM_LOCKED unlock
d24045205aaa7 media: streamzap: prevent processing IR data on URB failure

Thanks for having a look!

CU
Uli

