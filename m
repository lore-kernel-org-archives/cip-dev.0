Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C3AD35670
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 03:51:19 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5719.1769572276256899444
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Jan 2026 19:51:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=F0JKd7b1;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=0Iiu8lTc;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.217, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1769572263; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PIeICmt7zBuDySwjG03Nd3rzM9v0X26lvhUPUk/VqLNe0r0lBju+AIUUpcdDht5oQE
    Gr18PrjXbganRCjs2y1erF6yl+CboLFuVSNX3DuQnliHunpEHpDUAgdRsH0JyA/WUNkt
    U3gmWiOcrYGfbmQXY52tf6z939hE2myZgPXkddd6IKoYL9+UBhjP8PoafHgqMzJG+2Un
    0eK9k6CZ26RmGyWEJ4iD5SjPPCowJUdBMDQJLYvoBOlJZGkVtGYAJuP1VZ+euscXdE/X
    CLJio+owoLAiFhNZE6mVgCCiGdh4PuE8uO7Dh38aQlBorQEJ58WSCjcekRMIfc20L9e9
    T8NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769572263;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=lSY0hMNS/qjNO0jz8zHOEoqjMtSh9Gu8+UTRLIA6IAs=;
    b=F7cTOfwRE6+1z9FrGZtzn40LSlxKzywxWp6tbBuWUwNtJ1l2gMYwQcChhj57tMwNvf
    9QHE/9edfX6IW1Sw61vpllzSAG/wJRoe78ClRYEzxVqga2hM4sVxpmYsucLTNwSNt2ri
    nHixBL1i2PbKossOe6UKw0XdGmFKv0Vsd47bxUdj/v3IA36UddZlLPKPhS8RRUvp3VGh
    3kwpleHRE7txSrFkka5LoLDzJhxnTYm04tcQxM1wHekE4ZV/CK+ERVTy2nDeWezpinS7
    CrAoboEtluA9cmB2v2JONBmRWK7woeEoKJ5nsbNCLSoQMQ7yChh7DDnUWaiyReqGTm/k
    3FgQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769572263;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=lSY0hMNS/qjNO0jz8zHOEoqjMtSh9Gu8+UTRLIA6IAs=;
    b=F0JKd7b1Z4G78WSLwO1cRic8c34ZI9Nz1gYD2d4/4Mnyqj8FlyFqq2CT4fAhHrGkUT
    WpwE6x2rlfjM0ns/SocQZtRC1GUJJGn2mhI3kx1EawWgRW7xyFFHokKgSyvtqJto4P2o
    Bu9PVLpMiicTaGXjOcOfhhyKbaJsxba0Nh4xAVXj5qc96qQm7Q3bresqlf04vkP9lFoW
    Yhpc88zp3DA6HMjUjM2bKVdXrcoTIZS9YfqdhRO7qMkArOD+AxeXG4UEaJVwSxlVNSwZ
    btiW5DbVtPucy38T9eJnrAoqtHentOejJZr844NAwBZZc7Zb5BQPamFX5DEn9SN9DbN+
    hOgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769572263;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=lSY0hMNS/qjNO0jz8zHOEoqjMtSh9Gu8+UTRLIA6IAs=;
    b=0Iiu8lTcjds8MnxRtas9HQjGx1ZWkXZwcRwJM64jvmHcw7hexHpAt6OanmSGZ9En1q
    Gc5nz7uQsj4yIdsVV7BA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRxGtr3BjA=="
Received: from open-xchange-core-mw-gw-38.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 54.1.0 AUTH)
    with ESMTPSA id zfda1720S3p3o9N
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 28 Jan 2026 04:51:03 +0100 (CET)
Date: Wed, 28 Jan 2026 04:51:03 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <604968144.210835.1769572263316@webmail.strato.de>
Subject: Request for review for 4.19-st12, 4.19-cip128
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.74
X-Originating-Port: 55758
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 03:51:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21732

Hi!

Here are the manual backports for the upcoming 4.19 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-st-rc

121401e5518ea NFSv4: ensure the open stateid seqid doesn't go backwards
bac7d26012926 libceph: make calc_target() set t->paused, not just clear it
2c6059deee2ea crypto: af_alg - zero initialize memory allocated via sock_kmalloc
829f2fc2a8274 jbd2: fix the inconsistency between checksum and data in memory for journal sb
0bbbb40b6c0bd f2fs: fix to detect recoverable inode during dryrun of find_fsync_dnodes()
dd8bfd7aed8c6 iommu/omap: fix device leaks on probe_device()
fd2c1fac2d53a crypto: seqiv - Do not use req->iv after crypto_aead_encrypt
d8e936ec8cc01 f2fs: fix return value of f2fs_recover_fsync_data()
f32fa18502fed ext4: remove unused return value of __mb_check_buddy
7f128710dc0ad clk: renesas: r9a06g032: Fix memory leak in error path
6bfdb8fc2cea5 nbd: defer config put in recv_work
d81df85afdfef jbd2: avoid bug_on in jbd2_journal_get_create_access() when file system corrupted
2a606c6fd4baa NFS: Label the dentry with a verifier in nfs_rmdir() and nfs_unlink()

Thanks for having a look!

CU
Uli

