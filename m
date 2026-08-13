Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242F3C5B572
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 10:05:28 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15730.1786615524528696155
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2026 03:05:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=khKTETjI;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=1CGr+4Ty;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.20, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1786615509; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=tmeBNXSyMsHX9X0CYHC1gbILnnkuNDWuVpHGLZy3afld1NPfhX7e25aqzHUKJCBEXB
    J99zIoAKjWOBPx801JaFU0ouyceC1XAI1Y9srYk4Sdcqeus1YVYwrCqcU/MYjmeUxBiZ
    shRJWzlbdC7TJYtjaL+JKYV3ARHRDlWxw0C4t+8UlmdkhOKuwsYIXHjmRERpWRvu1plr
    z6jgdc7g+qHrJEJgAag9hvrU+DEs3xPKHpEzMeGhj3JL0/wCpAqR3XkCYtzsSrRsGtPr
    fIngEnQQ9KiiGMehN+9im2Dgauk+gJ0RFsfq/Wn3TImL5LOlp1y+3/RsNLgpNiyesGtQ
    0WcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1786615509;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=Yv4+jG1BbU46t/+wB/JJwBBP/clun5pd1wXIKuuFGKI=;
    b=qnswxghyZMLBIYR+y9dINqyLEMyKjN0wxq96fDj4fzv29peSjjMkA2HsTTIqEGi1BQ
    AFxC529tVG5bylZtFXxsyxxeAbi6v3rQDZtYPVDmBECQ/t/QbnLG0zN+hDtxinckPFkf
    cmOsVDYbCUvEYhPkAZXTEwNjuQyN4GhTDDmck8fOINiNh+rmIQpwDg47KcH2xmtqJ2D2
    KDkOVXGOrljDIPFir6TwBKtjPP1JbdNLb+vpFtfVnchKI9X+cEkKrEp0tNLczYaROMC/
    LZHssae75MWrcKel1KpL0LmTFl+e/piHAx9EGgCwfQaDdOyKVmgbLY0s/EtEK2qrgIXY
    6/jA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786615509;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=Yv4+jG1BbU46t/+wB/JJwBBP/clun5pd1wXIKuuFGKI=;
    b=khKTETjI3N6scuNejNEthZctl8Lx+60Yhw+ukmzMggO7pAK6opTjwH8ol2xokPoW/k
    pCtFlV4GI0fnSpl7XJyxu8j12Ut6khRfG38tZhoYCovTolV82Fnk1IQCritPdAU2gei9
    oiURmAbL+WIKx8IttlZaQNoWjIOxuCqEPe8JQ1JNH9uYhwP3U23D0zyM4k+NBV2419D1
    HolLoxChg8y3wXRhM/APlK5Qp9UGfXl5lVVsTfGsvrwepVHcuB6xk8MbnDBpkOq4IZbf
    UdypIDcKCRdvYMmOgGDLa4sqaljW0q9GUQ6gIYSI2mFerfFhrbYzELt506Wc7hWVapN8
    uaXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786615509;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=Yv4+jG1BbU46t/+wB/JJwBBP/clun5pd1wXIKuuFGKI=;
    b=1CGr+4Tyi71vvVUzk+PlcuTaiPFcYLtcPLXlq0dumr2uDAUCEvRA3R7ZSbLKWkQ1EP
    CNa/WyqzW0xY1fjA0JAg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hex6zd5FloUw=="
Received: from open-xchange-core-mw-gw-28.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.5.6 AUTH)
    with ESMTPSA id zec9ec27DA59ghI
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 13 Aug 2026 12:05:09 +0200 (CEST)
Date: Thu, 13 Aug 2026 12:05:09 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1456594884.221583.1786615509120@webmail.strato.de>
Subject: Request for review for 4.4-st79, 4.4-cip114
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.154
X-Originating-Port: 49388
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Aug 2026 10:05:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23915

Hi!

Here are the manual backports for the upcoming 4.4 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

f43fffe93e6a8 nfsd: fix posix_acl leak on SETACL decode failure
5fe3e0f96cabc batman-adv: bla: annotate lasttime access with READ/WRITE_ONCE
9a9be3c47aa06 mtd: spi-nor: sst: Fix write enable before AAI sequence
840c7bea0c5e9 sched: Use u64 for bandwidth ratio calculations
aaf78df38c15f bnxt_en: Modify bnxt_disable_int_sync() to be called more than once.
5e572058a9346 f2fs: validate ACL entry sizes in f2fs_acl_from_disk()
5366a10a971a4 batman-adv: tvlv: enforce 2-byte alignment
5d687ed16afba batman-adv: dat: prevent false sharing between VLANs
3e77213407fe6 batman-adv: tt: track roam count per VID
3d81ed513fc9e batman-adv: frag: ensure fragment is writable before modifying TTL
92575ea68fa04 batman-adv: tt: reject oversized local TVLV buffers
07df65dd3eef3 f2fs: fix incorrect file address mapping when inline inode is unwritten
126982eee7c4f dm-thin: fix metadata refcount underflow
0275d20ddb91d btrfs: fix btrfs_ioctl_space_info() slot_count TOCTOU which can lead to info-leak
4f5d828b39324 fbcon: Avoid OOB font access if console rotation fails
3331822db4e85 ceph: only d_add() negative dentries when they are unhashed
045ec6aa429b5 wifi: mwifiex: fix use-after-free in mwifiex_adapter_cleanup()
b56b15a4c9ea2 thermal: core: Fix thermal zone governor cleanup issues
4cc65feb8ed2c fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync signaling
d1646af403aff mmc: sdhci: add signal voltage switch in sdhci_resume_host
dce100a688c8d USB: serial: digi_acceleport: fix memory corruption with small endpoints
052afb5d9f67b Bluetooth: hci_core: Fix use-after-free in vhci_flush()
8a733c1ac979a netfilter: conntrack: tcp: do not force CLOSE on invalid-seq RST without direction check
8ec3e1e63a29d xfrm: route MIGRATE notifications to caller's netns
10411ac1d277d HID: wacom: Fix OOB write in wacom_hid_set_device_mode()
e79c2c6a7dd5a ip6: vti: Use ip6_tnl.net in vti6_siocdevprivate().
d7893890c93c5 USB: serial: omninet: fix memory corruption with small endpoint
4d349853d3d4a Bluetooth: btusb: Allow firmware re-download when version matches
ccea3d2dd014f ALSA: usb-audio: fix null pointer dereference on pointer cs_desc

Thanks for having a look!

CU
Uli

