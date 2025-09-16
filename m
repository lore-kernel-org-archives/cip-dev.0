Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE03CAC598
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 15:04:06 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
 by mx.groups.io with SMTP id smtpd.web11.703.1758035040652584238
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Sep 2025 08:04:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=ltmDVzBt;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.165, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1758035031; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GPk5/QyPrkIpOz/w7zBeLDuJqcDc27Uk81b6XlqIFSMyROo1/Dp/L8orY/s76Bf41B
    42qDTVhZRECCV6dYmesM3V7zul/HNqRdG0Gx2OY1uwLBmm4UT/qCW99to1iSTP9E83z8
    A4or2qRbOazxFIV/hNosAx/7ogA2fhcXPXYevOhHTrpKNUjt8gWh1l9z2vG4zTBRjOVg
    TeqkqtU1oo97uq9D6T2Xy382upe9SD7QlGgqMp+qVqXrsYwbjEK0kgLLJNkgn4WjhXHg
    YbvE40fqLToHnHbXuwgrQ9/wsmnvl6144afE7hw+gy7yfm4bqdCBKOFkmnhUH6uIZDuC
    tkMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1758035031;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=NZMlOq9/7iTe+bWgta2SK1MrK0gZivnP8Oj7GUa760c=;
    b=UYvQC4acYKGW7PiBfuuIfrvdCFoderxrxPF22ogCYuUzqjqOUg8v64nMZ466ldp69u
    RYrhLjdL9Lo+aw3J7fcJNfDr7aRhfpS5auoZ4bzr8WtxIhLkpN2PQEXZWvqt2BP/qdbN
    a81jcMmIdlUAqvIgnbRrxhXLak0mEY/PLlOojMG/nAyX0AMHRMjs8Os9aGbBcXuHK7dt
    IJZrPO3E6DXpY3qs8V10o9/4qh7Oczx3a2CubbfA3bDJpy4kZthLz6Pt+NAH7mMsaqxv
    jOlddt0+2Fb86ZMhWzmSz1GQ8JTXKoyGOcEFxT70ci0Ea1LTH+ouWbPszPmwr0bvmyFa
    bVHA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1758035031;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=NZMlOq9/7iTe+bWgta2SK1MrK0gZivnP8Oj7GUa760c=;
    b=ltmDVzBt9zkBmNqzWVFLHvXBPT9s0mRzzf1UQPKMzKDjlgb2PJVOeVuNfB18KshWsF
    muaPkJryTngNpLqNHjplgShJy7ULq3Yd5ju+qNMD11C93MNTz06+hoUOeEwJ4bHH0jwH
    kJZJHNb5fqMSNSmsMdbEBA8zbv8WwXgqhAPaJxVEg3WMmbbDFM9AW3xPP2qmSveH0N/E
    xIsl4U0hF7OTp0Evijj6eG9oxmTX/M3tOHCqcDJPUeRvj2+PjHjC9ZW8zmfkD7FdPWyj
    Rk9bvkytOlI40dbKZ/MEjP/2QmpynzFNiJ0JvkOhCp/22UOQoqP/Rd1fTbHPeTjd09Di
    8LeA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKzK+A+UOEY="
Received: from open-xchange-core-mw-gw-7.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 52.1.2 AUTH)
    with ESMTPSA id z025ba18GF3p7QM
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 16 Sep 2025 17:03:51 +0200 (CEST)
Date: Tue, 16 Sep 2025 17:03:51 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1522250355.247103.1758035031215@webmail.strato.de>
Subject: Request for review for 4.19-st8, 4.19-cip124
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.38.83
X-Originating-Port: 58218
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Sep 2025 15:04:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20059

Hi!

Here are the manual backports for the upcoming 4.19 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-st-rc
(At least that's what I assume; I'm no longer able to get past the bot protection...)

c50175dd232f1 f2fs: fix to do sanity check on ino and xnid
c5da7386ca038 squashfs: fix memory leak in squashfs_fill_super
8004a014004f3 pNFS: Handle RPC size limit for layoutcommits
73d1fa319709c wifi: iwlwifi: fw: Fix possible memory leak in iwl_fw_dbg_collect
a2cab05b5667d usb: core: usb_submit_urb: downgrade type check
ddc44ffdaa7d8 udf: Verify partition map count
68def4bf2c714 f2fs: fix to avoid panic in f2fs_evict_inode
a2f0f298a3bc6 usb: hub: Fix flushing and scheduling of delayed work that tunes runtime pm
0f86291316a33 f2fs: fix to avoid out-of-boundary access in dnode page

Thanks for having a look!

CU
Uli

