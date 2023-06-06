Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13504C77B7A
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 12:47:11 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
 by mx.groups.io with SMTP id smtpd.web10.7791.1686055629629476638
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 05:47:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=ME6SoObU;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.221, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1686055611; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GM9oJDg3d+kcwZ6Ik5Ihc6VQKBfrf3mVPTvpU8SrmjaEUGDAxh4yUH9w+FWcBWHEMI
    ckA/KVVrg183XR0Jnor2CVo1sm5MjpyCWlaiyYEmfkEnFhjRj2CdmvmKxhWL9IzsuiZQ
    uK5XzGkX++W3xA5v+q6Klbb41UqKhgKzv3Tgf6QkRp+jDiA2eCepUnOtwRqCw2T0aJJY
    Rvsvet/RDLmSiEiRRN3EBnUtlbtERQsWiK2TS3sY4Q9YBBzIpmZFGugNTqzaMhosLtfV
    4sknqxS2mTmvUeqdhR3JIuo9cqf0XUPtN1l/Dqngw1Z6T2Wu4Q+xzZJbMoVTRC8D4Yka
    LATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686055611;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=ZIoRX5Bo1N+I9QtcNb2h+8f3zpRfLndZxd3n3Cn4H8s=;
    b=h+jeLEj5s7ovDGr8g8rR4ii5qn3K4fUKFORRSL5ZjyAz8wjU0kpuShn2UNqTbZW3Gg
    peyMuDO68NJ4+MKk+6u8k9464ajyqTDjEIqCZB8r+Hh5Z5pwJ9zCiO44cQbExYsuWHPI
    SAqULRU4E9PYMq3OHGCMGlflgjQ6F9UrUw/YmIg0gfV24m5f8ujrbdVt4aKpgsTsdL3o
    sxHHWHDJWen+0eNiaqY2YTpCjsThdxmOI0WbSojb1nvA5WlQGnjIAJf/N+HsBv8Vv0yi
    aMpRwnzEpA3f5r5vGT5edKQkD/pcxrnj+BIqX8ugcGBCuQKAEsSDK/rqbgQb0GbZM3+E
    ANpQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686055611;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=ZIoRX5Bo1N+I9QtcNb2h+8f3zpRfLndZxd3n3Cn4H8s=;
    b=ME6SoObU/3teWPZgTP1n2QUuF9DLEVruKF4kOf5RaqrUR5QbZ3i6yakNnZCg70iA3P
    +VQk+TwBQZvo/4oaDQSF9WTNNBfcnQsItKC5k3rmXEwpd18dgXsmu8dyAkorGN2PNwns
    FPkLygRYac/KT/BDWT6fZ+v0fa2IAP4NYAYceLjWLEEDiDxrwdmznL65ZjB9QbqGxvMb
    3hReRxLurYvTLRsSHlPKbVLAGXcrPxCaCkzgFuCDNLyIfVn5kUD+a6g13m5Xp0emsdoq
    kT4SrwyEE5wj33nGtTJ7PDeuOY9oMzT0FHnXvus6ElhaxtQZimZlTY/UwFP8NcjnkJIp
    AT4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686055611;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=ZIoRX5Bo1N+I9QtcNb2h+8f3zpRfLndZxd3n3Cn4H8s=;
    b=3+iyXOCRJDque2FZ5uItlEf8M5p8ew7dCOUbO5VEHIfzpzqHUgAnJI/pkJp2lrTme1
    5a3t/4yYANY2a9doAECA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCt/7N+Odk="
Received: from ox-live-app402.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.5.3 AUTH)
    with ESMTPSA id e63bb7z56CkpGvc
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 6 Jun 2023 14:46:51 +0200 (CEST)
Date: Tue, 6 Jun 2023 14:46:51 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <2068736803.2855270.1686055611152@webmail.strato.com>
Subject: [ANNOUNCE] Release v4.4.302-cip76
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev43
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 12:47:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11881

[ANNOUNCE] Release v4.4.302-cip76

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip76. The linux-4.4.y-cip tree's base version has been updated to v4.4-st41.

You can get this release via the git tree at:

  v4.4.302-cip76:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      a0a97337aff8d76931b459e84792717c3bf6d6b4
    Fixed CVEs:
      CVE-2023-1989: Bluetooth: btsdio: fix use after free bug in btsdio_remove due to unfinished work
      CVE-2023-2269: A possible deadlock in dm_get_inactive_table in dm- ioctl.c leads to dos
      CVE-2023-1380: wifi: brcmfmac: slab-out-of-bounds read in brcmf_get_assoc_ies()
      CVE-2023-34256: ext4: avoid a potential slab-out-of-bounds in ext4_group_desc_csum

Best regards,
Ulrich Hecht

