Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C14C3DA4A
	for <webhook@archiver.kernel.org>; Fri,  2 Aug 2024 14:45:44 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
 by mx.groups.io with SMTP id smtpd.web11.94266.1722609942897565788
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Aug 2024 07:45:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=pv3vsYBG;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=GNzD7iCy;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.160, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1722609934; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Xwe9W3jGuxqU1ZzqDYZJatDbJ1ym7pUxk3OIYEHihc96f1/kV/hnSup6R74TLO81Ce
    QtljzvMFAcy3o7/rKQb8porWtOwy6hcMNhGG6as/EXnBJwbomTDPpxeaYplrAYRNgx6s
    vH5gibjtOtemLxBvDgpzAywAl3RdBcXzRx3xaP76rd8k90fJyc+Zn6FbY4HocKrNT8bD
    4Gdko1xOV5OR23ZAICEy7RHaRnmQh4H/T4qR47kHPBzmoehY350QJZqaDyot7AcDXv2v
    hnWGyf+wS4ekjwYV/zsNC++atq42ciJHPM5q6c1RX/kmMvWwWcuwLgjfr9K7hL3ZWRWk
    8+1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1722609934;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=kuu1+Z2sjuwH3TEfdQ5VH1dIxf29ayo2Wmprx/dx0hM=;
    b=g6fjlsvbUjJ/1zww4gNCuy6TVHzSvLomCLbiRWSpmb+FIxYGF0UldmgHK9n16oOfLU
    pfibEfLUycxOG2D2G2WgDhq6G61R4OPQw9mNpFDqfnoRL4HWZKJpoNCClW22Bmslwbnc
    S75PaZRa7kPXbSJV8BFJf3SfRM6fWJ4cAQi2f5Rvh4DJOpQ82s+WG8MolGN8K91LsNgy
    xzbNmh+bA/mNEuKrqDk1NCcEh4bEMTR2ukAummvfjlIQAYVpWArzxrN5LQxzR0uzgFWu
    LHGPjA8DgFA0118W7sq8Fskir+KzbuquLQZQp90uyuYXKfb2HLv2ModQz5lHMPP2/Z7e
    BHMA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1722609934;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=kuu1+Z2sjuwH3TEfdQ5VH1dIxf29ayo2Wmprx/dx0hM=;
    b=pv3vsYBGb8i73+cSdHwjCBHeTywSXyKA44mozqY9YnOf0oSjTsCBRObEKsiEuwJpV6
    0Mab/BszOPg+aNJ49w+FDHOIKM33l3Z3DaS8N9TS+ADduHr5ceu4L2EZah5dGKSACgLL
    LT5DW7/nPps5UQW9/OmaupXw1W4gKh6JZkxOrBPP/83zGtOQv+h3pjbWGj1lqG7d4gpQ
    Whk9JcoNdWnXhpL3FXFQwSYk1/i8QFEJGptddDqVY/QuUEbjBf+zXiwYyF7exzmR2jGM
    0jTipw29gyhfRSST6TBr1PRiyIu/dwqIbuECdRcpMV9yCqMWpK779Nh7uzptFhVi1dIS
    qgVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1722609934;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=kuu1+Z2sjuwH3TEfdQ5VH1dIxf29ayo2Wmprx/dx0hM=;
    b=GNzD7iCy8KHIvSvjqTTaSBsg4OKyEl1iLLm+UXlurfpgbGAZq+AyuwO7XkKBTa9YRS
    VfzC9ob3U2ji2PhppmDg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzstnjV5GU9c7oKNYMuRfGHqdez7mZQjqCOMPS13Ww2eFsaIxefx6BY"
Received: from ox-live-app104.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.1.0 AUTH)
    with ESMTPSA id z5d8cb072EjYoKf
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Fri, 2 Aug 2024 16:45:34 +0200 (CEST)
Date: Fri, 2 Aug 2024 16:45:34 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <706736547.3348482.1722609934265@webmail.strato.com>
Subject: Request for reviews for 4.4-st55, 4.4-cip90
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev67
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Aug 2024 14:45:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16712

Hi!

Here's the manual backports to review for the next 4.4 release which, as always, can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

f419702e01650 media: mc: mark the media devnode as registered from the, start
65ea5a47714a3 nilfs2: fix nilfs_empty_dir() misjudgment and long loop on I/O errors
dff699deb3395 HID: core: remove unnecessary WARN_ON() in implement()
5e5344dac2f00 usb: misc: uss720: check for incompatible versions of the Belkin F5U002
f13500b98a507 udf: udftime: prevent overflow in udf_disk_stamp_to_time()
2efb5ca24b08f net: usb: rtl8150 fix unintiatilzed variables in rtl8150_get_link_ksettings
3ffc17009d168 ARM: dts: samsung: smdkv310: fix keypad no-autorepeat
cccb925ba214a ARM: dts: samsung: exynos4412-origen: fix keypad no-autorepeat
a666ac1afa8ca ARM: dts: samsung: smdk4412: fix keypad no-autorepeat
a950059ab72ae netfilter: nf_tables: fully validate NFT_DATA_VALUE on store to data registers
9a626ec9815e8 batman-adv: Don't accept TT entries for out-of-spec VIDs
18df69aa504b6 ftruncate: pass a signed offset
0ca4b05662224 ipv6: annotate some data-races around sk->sk_prot
b04d56f62c5dd ipv6: Fix data races around sk->sk_prot.
9193eb58d4dc0 UPSTREAM: tcp: fix DSACK undo in fast recovery to call tcp_try_to_open()
d467eda9f8982 nilfs2: fix inode number range checks
0c5c578a19ef6 i2c: pnx: Fix potential deadlock warning from del_timer_sync() call in isr
8267db6d29ea8 nilfs2: fix incorrect inode allocation from reserved inodes
1df198bc10b67 libceph: fix race between delayed_work() and ceph_monc_stop()
66d3371a26e02 SUNRPC: Fix RPC client cleaned up the freed pipefs dentries
e2be94637020f fs/file: fix the check in find_next_fd()
d469b14c3f2ad fs: better handle deep ancestor chains in is_subdir()

There is also a fix-up for an error in a previous backport:

3ffe90bcdadb8 nilfs2: fix incorrect use of nilfs_error()

Thanks for having a look.

CU
Uli

