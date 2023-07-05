Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225FBEB64DA
	for <webhook@archiver.kernel.org>; Wed,  5 Jul 2023 08:58:35 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
 by mx.groups.io with SMTP id smtpd.web11.12675.1688547509331183709
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Jul 2023 01:58:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=W/4VKbuH;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.22, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1688547507; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GAQhQz9srIcCx3ipx/n5DybvGDmZZ3nra46MRTyEGhlfHNXUlndqfX4gME3Cu/1ovG
    SxprcGo5V64w1YQVFKINCBH8Lbs9+nUH7ozjkVQao1Sly3cFsobaFAl+/jnmQuqqQKe4
    zdMXsbxO3381cjcieHKsR0bNBUDhhTb2XYJ+gyDFHGni6A4KLsm0A6uDNvZ1n2sa76SB
    hHgKIvuucPTd/2LF522GqhF/XUhYrj1PtCAShffrH0PlLLtsybbQrbsxBO+IfL06zeY6
    00v11iEuKKuwcDilbQYQsMMyy77hIcLx+THRdir91EiIvwffP0qkLJQyKonLjqUXSAMx
    59mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1688547507;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=FgRDoE0gGl5KMxI6zRRRdNLqP1Q3y/ha4B7hNoQzYhs=;
    b=e07/5WD4C2F8k1IgYgKnQLF/WU4xg8tG6qCJx/Fynu9YpdbmC3+pmO/SNtTEYUpPJ/
    0/1AP6GuLyWNmhQHUxh+657F/zHA+VVha3nOr9IrdgrbQQfk35IqQtoT38kZ1khotnbJ
    HkkN4AK4LQYBwLVlUMbtP21JB4DU9QNARrQrOUBBj2kqxBQs7a7EUkAsuiPD+IsOiFAc
    oqShI37MkYqXZwT0YJ3QlpMFYebBrODhGEIDTdENtyFV9OJrRd5ddbqXqfQNYhqe+F4j
    BA3YWXKiy8m0ZR6fhbTIu5VnQzxpKXA1ebM2EtOPbd9whtAx52Sx6Qbc2xe4WCZWagZB
    ZkiA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1688547507;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=FgRDoE0gGl5KMxI6zRRRdNLqP1Q3y/ha4B7hNoQzYhs=;
    b=W/4VKbuH2C69Xo5fMct4CH9j3XT/LPSMqvYVDmbXkSTQ6DMarujLSD2KpxtQf8JbmW
    Caq1ADQNiTKOvfrmKudN5WuCCuFpzMidLPYB0fZTfxplCA54ZLjmiaYIhsOpqFZTY2SO
    kWNG0sAGijBNj0HgJXSfgsbe2JB4xc9mO3ana9H88xer0zIL3G7vxvs8ZZqBSyMVAuPx
    G8tIj+sQuwgLBC1hP1nz2UsZZM+SnIblBh67crJbw4FqGIL0kY0KDT+px7yMU9U4A8mm
    oQrTVXFv8ae/R8aHE9TH1MAagRYz/UnhVnnjy71gXaX+FH54ylFpAiMD312TscVPX98B
    SEyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1688547507;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=FgRDoE0gGl5KMxI6zRRRdNLqP1Q3y/ha4B7hNoQzYhs=;
    b=lzSNmW0biBUZK512KYrr/eqBcIQqJUZQPwhgPsPXJ+9ug4Q9jtmJRcYCBfXJ7rZ7qm
    mNKysebC/cdFU6T/fHAw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCs/87J3I0="
Received: from ox-live-app203.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.6.0 AUTH)
    with ESMTPSA id K29863z658wQAZJ
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Wed, 5 Jul 2023 10:58:26 +0200 (CEST)
Date: Wed, 5 Jul 2023 10:58:26 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Message-ID: <721088923.1980911.1688547506942@webmail.strato.com>
Subject: Request for reviews for 4.4-st42, 4.4-cip77
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev47
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Jul 2023 08:58:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12229

Hi!

Here are the manual backports for the upcoming 4.4-st42 and 4.4-cip77 releases that should be reviewed, and that can currently be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

trivial backports:

** m | 61256d2d6 None o+ | netfilter: nft_dynset: do not reject set updates with NFT_SET_EVAL
** m | 42ca9589c 138906 o  | USB: core: Add routines for endpoint checks in old drivers
** m | 72197f21d b8c75e o  | media: dvb-core: Fix kernel WARNING for blocking operation in wait_event*()
** m | 66e262ad9 280a8a o  | media: dvb-core: Fix use-after-free due to race condition at dvb_ca_en50221
** m | 22fb46cc1 2474e0 o+ | tty: serial: fsl_lpuart: use UARTCTRL_TXINV to send break instead of UARTCTRL_SBK
** m | 1a5353475 fb686c o  | btrfs: check return value of btrfs_commit_transaction in relocation
** m | ff0e8ed8d 85f02d o  | btrfs: unset reloc control if transaction commit fails in prepare_to_relocate()
** m | 1ba0925b4 b6ebaa o  | xen/blkfront: Only check REQ_FUA for writes
** m | 2b88ccb93 50d927 o  | ocfs2: fix use-after-free when unmounting read-only filesystem
** m | 6f40a2503 7651e2  + | IB/isert: Fix possible list corruption in CMA handler
** m | 5304616a6 48bfd0 .  | drm/exynos: fix race condition UAF in exynos_g2d_exec_ioctl

slightly more interesting backports with non-trivial differences in context:

** m | 4e0dbab57 None o+ | netfilter: nf_tables: do not allow SET_ID to refer to another table
** m | 6119cae79 5c34c0 F+ | power: supply: bq27xxx: Fix bq27xxx_battery_update() race condition
** m | 3bd7816c9 efb6b5 o+ | usb: gadget: f_fs: Add unbind event before functionfs_unbind
** m | 4bb5329c7 1e5c64 o+ | rfs: annotate lockless accesses to sk->sk_rxhash
** m | b221b7189 409e87 o  | ceph: fix use-after-free bug for inodes when flushing capsnaps

Thank you!

CU
Uli

