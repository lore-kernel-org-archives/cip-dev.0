Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D57C67861
	for <webhook@archiver.kernel.org>; Mon,  8 Apr 2024 08:34:30 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
 by mx.groups.io with SMTP id smtpd.web11.101710.1712565265599965135
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Apr 2024 01:34:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=pPqKtFev;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=0Foy2BRh;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.21, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1712565257; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OBAQf5v6doEAWZEkNOBAooR0A4o6lTqESTWjFZpVJxxOnUR02TIJ4JbyGIgggzqngw
    kIaIFa3wJX7sPmn/UqdkvCwBjJV0ZCU+wEIZALr/JtoxbaIf2otnf6tlcV8rHiKnq4eL
    /Drfb97KuSCiKa8fLNJMbVuv5TkV5A5CRL4jWqHFafD5RfT5hCEYhalMYG8z7yYjEbZA
    VtbEY4anLRAEdoZy9GQ8eH9e1RHvFJede9qX8qA0bYRiAbhkhKkVIUzk32Y9Ol7+OOKX
    Otdy8lczmZp+zAm8wES96CQZQ/5RznH4CEP5d17KE5558eqtdyTOjZYOgIiicOGqg1a8
    a6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1712565257;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=gX7PZ+GTVg7IRODJzpzxz4AE10A0b4nBYITURpHZohI=;
    b=EgETRkV58ZcMy54P68WpxnmmSs+YNjaVBQNSVtkpoYFP+o5odGCGCYp2dRMKZclMK4
    hYDbFECLqHXrOixvtgigC9+zIMlW5lVWSuMS4UfpP3sygLo+qwugjTDv2jlK+B7KqVqh
    zrs+l1berYtZx+oyq+m88o4TosLzGZd7iz/qqdz4CZhDQhHiidDqgljqFEULdfRGzSfz
    kawUgSO9MuYqperCry1ST2+wpQqKp4R6S7kb4PlwJQwKPhyEfyZo67OlcPS+mG0aprVS
    /BUNlJtNlfFc0dmTqoBuuKcc7+LBMDQHX9/1114mg4/zlSWrM+rlh9XWeqBR069sksGx
    QqAw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1712565257;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=gX7PZ+GTVg7IRODJzpzxz4AE10A0b4nBYITURpHZohI=;
    b=pPqKtFevnjpKxzfQive+Jtk16swWXoUIlsLQu3Ko5TIF2Bj1tkmxwJBC26s5n1Q5Q6
    HZHyCFjFvURJbzh1D2CsEtyAVJxzSCJl922fO6O3wUnAnsygdaZvVMBcdxQ3qz81wdii
    VJFCutU5a4JFbRoUpDNunyttEjf96eH+Gk1X66NAOjwtESHuBbTx6LNblyMkWq6EApzL
    zLUXXFbF+HMPsTzMqLzfQBHf8BoZxTOz0RlzMhsyL/F0B1GGvlTnByv+KaLDRhrbVOC7
    2/qpZXUHwl1LbSjwFFQHCenF5ZBRfI3LSKOlj8Mm5mtQnLXqHkRtg0Z0fHL84L1mths2
    b82w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1712565257;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=gX7PZ+GTVg7IRODJzpzxz4AE10A0b4nBYITURpHZohI=;
    b=0Foy2BRhoQ1fNnYYSp5njhh6TQbItRBy5at+zi92gtpOoCmxuP7qMe48fEy5FIIja4
    1C8H17bnPV/snTFODWCw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzstnjV5GU9c7oKNYMuRvGHqNa13GvhtWeC6CRd93ajscjvWFwDo3mP"
Received: from ox-live-app101.back.ox.d0m.de
    by smtp-ox.front (RZmta 50.3.2 AUTH)
    with ESMTPSA id zaeee60388YGro1
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 8 Apr 2024 10:34:16 +0200 (CEST)
Date: Mon, 8 Apr 2024 10:34:16 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1155634901.1549797.1712565256786@webmail.strato.com>
Subject: Request for reviews for 4.4-st51, 4.4-cip86
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev61
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Apr 2024 08:34:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15498

Hi!

Here's the manual backports to review for the next 4.4 release which, as always, can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc :

** m | 575689f40 1eecc7 o+ | net: lan78xx: fix runtime PM count underflow on link stop
** m | 98db42191 767146 o+ | netfilter: nf_conntrack_h323: Add protection for bmp length out of range
** m | c96f49d3a f7ec1c o  | getrusage: use sig->stats_lock rather than lock_task_sighand()
** m | 70a33a629 3693bb .  | x86/xen: Add some null pointer checking to smp.c
** m | 6cc96148d ee0017 o  | scsi: mpt3sas: Prevent sending diag_reset when the controller is ready
** m | a215f042a 963465 o  | Input: gpio_keys_polled - suppress deferred probe error for gpio
** m | d619f175f 96e202 .  | ASoC: wm8962: Fix up incorrect error message in wm8962_set_fll
** m | cffd4a7c9 efd402 o+ | sock_diag: annotate data-races around sock_diag_handlers[family]
** m | 085f36c31 167faa o  | media: dvbdev: Fix memleak in dvb_register_device
** m | d0f5c2833 8c64f4 o+ | media: edia: dvbdev: fix a use-after-free
** m | 578eb0d0f 0f7352 F+ | wifi: brcmfmac: Fix use-after-free bug in brcmf_cfg80211_detach
** m | 1fac009e1 3d75b8 o+ | KVM: Always flush async #PF workqueue when vCPU is being destroyed
** m | dbc478390 097d9d o  | PCI: Drop pci_device_remove() test of pci_dev->driver
** m | 8ef8bdb2b 269cdf o+ | nilfs2: prevent kernel bug at submit_bh_wbc()
** m | 114fd53bc 6b959b o  | perf/core: Fix reentry problem in perf_output_read_group()
** m | 1830e5b0b f45812 o  | efivarfs: Request at most 512 bytes for variable names

Thanks for having a look!

CU
Uli

