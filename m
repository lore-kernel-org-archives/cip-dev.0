Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC57C64ED8
	for <webhook@archiver.kernel.org>; Mon, 27 Feb 2023 10:00:41 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
 by mx.groups.io with SMTP id smtpd.web11.86709.1677492033038615840
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Feb 2023 02:00:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=EJV544bb;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.20, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1677492030; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cOEZ6pEzTtVxl3VuawKCbJkBlktoGyEJzJpfku6UPFMoiytztBnLNxj+HJwIp6pv8E
    sdxtFh44XWdQQgvQjlY2xB4Q7bVItjfdcJcylwDNXLsHFavMSy3ilKU/dkhziDX7GSJV
    xXdf8Am67n8YPGvd21GjVr9TWMzSM0z9hIoRZ9VehJW2QASmwQWQxaS9PdkccIkZ1D0P
    V53xKmbbkuNgp+NDOO152z1gaGfZpt58CD5zfInYuf1BdbXmgYlFopxsX6uJ5gQEY78A
    bPwEWqbDplJysFMLDCBa3vvOEjFJkjrhJALPdCb9Iq6oYVffSXXr3bIObnqm25TqPpng
    Z6WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1677492030;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=vzUsqPLGyn2r98IM99EAfLfzdvJG6ZLq2N1qLUmj+6o=;
    b=DFmK8vi/LCSRhLmfZjGA+SKOiG01FPykF49aniSHcd8A2Rwe1sWDizQ23W8nDFSYZz
    h+VUw15WKcdhyPaxkYtUSBF7oooZIF29W7IxPrZthGanFbveT46BmjtBn5RNwczs09LC
    Ja3WCDIDMUsRlKgZnm84jOJHZAXN/SLJvPg0UKur7MHKx3XqS3L4lb1WprjTM52zAQ+C
    iWg3q20H3vO6el1unxInOCkF9cn4DL3C7NrdULwcEAd6VttBNahCzGNwQRH9fedwKs9y
    ybPpjscVjjH45tkjaFILFgZGBjkWVpQdZoqIpfvmDx6YLO5Y+aNQiL+IWIbo9w0G5LF5
    y1bw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1677492030;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=vzUsqPLGyn2r98IM99EAfLfzdvJG6ZLq2N1qLUmj+6o=;
    b=EJV544bbVwYzXpbTIXkse9MBMMGwyEXcEkHSGebelV3XH0uGOT1v7nZlgZTr8EsrNo
    ZGXXBAuYykA3nBqgQDQL5qr1Le05pAr3BPRP3sPRMUWGtEvifoQ73TpqDXiz3m2OAx59
    oZytnK6SrHRmsxkNyqE0kXmTp8jPKDqXl0557OKJN8Oj8pGqAfqucbubnL28MqNsDV5G
    U/CXe7t80zl6IhkJH8TOLp/Ztdp7JpOjRxk3MHy9ruTqhPIar+mmj6I9ANnVCR85COYP
    +Qb+TkPmLzDqkAEVmXZaSJHGnc7Sc5pPaey+mGf7M9fO7qrpry9r3EvpJTQk3mppQ7T1
    FwOA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGl/wuMlg=="
Received: from ox-live-app101.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.3.0 AUTH)
    with ESMTPSA id 6b619cz1RA0Uwrn
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 27 Feb 2023 11:00:30 +0100 (CET)
Date: Mon, 27 Feb 2023 11:00:30 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Message-ID: <1010789948.2703824.1677492030810@webmail.strato.com>
Subject: Request for reviews for 4.4-st38/4.4-cip73
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev38
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Feb 2023 10:00:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10863

Hi!

Here are the manual backports for the upcoming 4.4-st38/4.4-cip73 release that should be reviewed, and can currently be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc :

ff1d923b1cbd mm/swapfile: add cond_resched() in get_swap_pages()
c2242a203f81 fbcon: Check font dimension limits
0697f3908a1c ipv6: ensure sane device mtu in tunnels
6e1a18831ef9 net: ravb: Fix possible hang if RIS2_QFF1 happen
e15755dd0185 EDAC/device: Respect any driver-supplied workqueue polling value
1e5047422011 net: mlx5: eliminate anonymous module_init & module_exit
8f0e3e6f2ec8 amd-xgbe: TX Flow Ctrl Registers are h/w ver dependent
30a61de78f81 usb: gadget: f_ncm: fix potential NULL ptr deref in ncm_bitrate()
70ccdf253245 usb: core: hub: disable autosuspend for TI TUSB8041
9c336605666d USB: hub: Fix the broken detection of USB3 device in SMSC hub
57059c01a09d nfc: pn533: Wait for out_urb's completion in pn533_usb_send_frame()
93215b524bdf hvc/xen: lock console list traversal
7672af7c726f ALSA: pcm: Move rwsem lock inside snd_ctl_elem_read to prevent UAF
e6f2bae11168 net: sched: disallow noqueue for qdisc classes
e22ac280fe43 qlcnic: prevent ->dcb use-after-free on qlcnic_dcb_enable() failure
f38b21843014 nilfs2: fix underflow in second superblock position calculations
9a977a3c8fab mm: hugetlb: proc: check for hugetlb shared PMD in /proc/PID/smaps
f09f686242e2 SUNRPC: ensure the matching upcall is in-flight upon downcall
97494d49b7e0 NFSv4.x: Fail client initialisation if state manager thread can't run

That's more than I anticipated because a bunch of patches that seemed to apply cleanly had to be fixed up to actually make sense in 4.4. Nevertheless, most backports are minor adjustments to fit the 4.4 context.

The ones that need closer attention, IMO, are "ipv6: ensure sane device mtu in tunnels" and "nfc: pn533: Wait for out_urb's completion in pn533_usb_send_frame()". Additional notes can be found in https://gitlab.com/cip-project/cip-kernel/lts-commit-list/-/blob/master/v4.4.org . Thanks.

CU
Uli

