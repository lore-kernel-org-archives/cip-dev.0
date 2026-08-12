Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131DBC5AD5A
	for <webhook@archiver.kernel.org>; Wed, 12 Aug 2026 22:31:25 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7027.1786573878375747634
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Aug 2026 15:31:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=a+2kDvan;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.171, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-80bb41f7f3cso16601277b3.2
        for <cip-dev@lists.cip-project.org>; Wed, 12 Aug 2026 15:31:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786573877; cv=none;
        d=google.com; s=arc-20260327;
        b=ehyEJayd2ZRDxDiTJ/f1tMuxP3k9j3C70ODDbT5xjSsS3LhoTC264QZoZbx+S/dMJG
         w5nktgfosKBYQz9KE2HI+vvwj5sRPtEt9AnhPyntE+XLuF3YVLPRLHDFHwz1+Mutqk0H
         96gLG21cx8lwZrtV4jwg6H79Ym1mfxTyFwf3xBW/D5kuwYVCrwxNqyd1YgSwzpzIEw58
         dW3XBYdqnd38/Q7/EFjlsSIlt185PgncYInG7+LKD65C3y0zSsKRL3V3rYwfb0XJnf8b
         WrSWihG5dOu3JhTOHeKpzmqiPyAWBDDlVtq+gQrx6CZa5wo+iLQ3gk9yxfcZB4yuuKn+
         enNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/HlzxIdLvTN2TCEYxe+2bLc4LN2WJQCElUDmjiPquRI=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=q2nR0cqlW/6DIhQBfwowRwVFQSavuEBcQUbB1L36I58/a8lrdTPss3SFMwX3DJ0QFG
         Qk8F5tgS5OD5wdG/3L7GVGoH5G927T5bagxW9OXjmOLr5x70e8s5tnyGioCHPd/eOFwj
         Qggs69h1BBv3kdaK57spaKU/YocdH5O+SuguWPQjyqxk7AhOKBQrNjvBdHvWhIWGgONo
         Tor5eq+mtKVnWRnCxyU3XuGHRJPb9LhnMPf7j8yqnprXjGWmdSCnr0F2k8i6OYKOgGy5
         B5wHkAqcna61VJDuW1y1TuDuTLHZuAAeFBB6VVgWix7S/lpKK5nSv8GYa3S0FuwkTKzv
         bCJQ==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1786573877; x=1787178677; darn=lists.cip-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/HlzxIdLvTN2TCEYxe+2bLc4LN2WJQCElUDmjiPquRI=;
        b=a+2kDvan37BA/W/lyhXj49ENsEYjTC4aGcXtBB/PiANf6nsP3l/jCtWn99J5K49y3k
         UdBzBgjm0hckRLIe2L9FJlXwiO1a7t8Mp0kSnAJwo7K6HZFFK+I3f6YFaSLKUb9UuPQo
         stL7EXvqmrUrA9YifHGVvxo99+I/SfQRYlWGv/WlKm4pcXtiDPu7c4p0q6kKRhOLCJU3
         fiZA5SKHqIeD9irmWOZNEw2OSXn99jfvi5aPI268dF0G0dubHaSRxGezI5e/fMGNHEHA
         8I4NAzkSzEhMZKosU7AloZVz6OqEjqfn1S45sHrYIU4SPx821IoGieMmc5Zmc/1+lKFr
         VbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786573877; x=1787178677;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/HlzxIdLvTN2TCEYxe+2bLc4LN2WJQCElUDmjiPquRI=;
        b=a/VY2qsYbvvWDXPgkKn9jbEYNgLcQDmYhZKs/ntfkOD0zxi2sjAF5TcaQJPSxh3UQw
         6TWbSMCj6wziGdBSdQnltq6E9PTEx2/wAdojB2EqITRTtdrVXPbwCVYD1j5TjxIvuYcG
         AKJDdsqPzuMXASb+Fa99jFttYI3V9oa7VvQ5X9CxZy0SvtOy2moTVcuggxqTk+5xxlOm
         mTfZz5ddE9MdCUc1C5Eca1rrVEz7Pl2BVEVO5mWLt//Xa3AhYGFX4q0jsUFAm6xSvN4x
         B3lpaqCGwzCS+GA0cPsaPhfCzBJ9Negvv9YyTIpuUQt//D/bLTmWmYmQuCmyUlCTgpZP
         jKfA==
X-Gm-Message-State: AOJu0YwNCFxuMpPlJMa4QHpYTrYLYx9fVxFTgMTgjcVMUqS2p0OFuru5
	bZ/Vw//fOILgiY5r1g0COOec9+vZutx1bCnI8jhU8OKmY8gc6f6RHMy9oQhQtbfUYsg5FafLTu2
	dlRVxwWlbL08Xso9BkVLifmFC+XAxIpmdzQhBLwllRLyucj6/sK7H6blmKA==
X-Gm-Gg: AR+sD11WgTTqENlDLy1LBrty4zUXr74U9ux1RKIBcGqFxODHDeN/A0H5IxT5S1EBIVu
	3IvsmxWcxR+weTZ7E3f+bchqF7Kv529GJuxQYADsMfrEB1unBqdHwT2znrn1SEgI3SCyXXxoBN2
	1s0va3+bUgBX58Ed6mTFxD77sWF96gzB9iq7OgJOyZgGxH38CPna+prrYFfNdkAhSGskake+0hr
	f7Am+a5yXa19zpme7Dg6Eci2HSBm/niNTmLvtm0YLjvqGkVhfmtClzGgZ5GZrh2kQ3Iq7TpCsu3
	6WmOIPOXYtz4VV6Pjswp9owY4TfAmDYMSOdt1cR5AeQbaYYDc03xBmjqwwkWqJEqkaqDIEcRoec
	iLD8L+9CyHu6zYSgC
X-Received: by 2002:a53:cb0d:0:b0:667:ba5f:e32e with SMTP id
 956f58d0204a3-66c5141145fmr535239d50.14.1786573870728; Wed, 12 Aug 2026
 15:31:10 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 13 Aug 2026 07:30:34 +0900
X-Gm-Features: AUfX_mx55Gi8Y3VfdRqL2zebQiKWYpqR1OTEm1mC6B0lCdI1_au8QJtqVsm0z6s
Message-ID: <CAODzB9o-8bxd+ScpjUv=zn1dZDTZcRzD6WpfdcBg1ZZyem2J0Q@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Aug 2026 22:31:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23906

Hi!

It's this week's CVE report.

This week reported 392 new CVEs and 8 updated CVEs.

* New CVEs
CVE-2026-64583: usb: gadget: udc: bdc: free IRQ and drain
func_wake_notify before teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64583

Introduced by commit efed421 ("usb: gadget: Add UDC driver for
Broadcom USB3.0 device controller IP BDC") in v3.19-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0583f2fbf8f86ae3a0ce054f96783dd83e65d9bb]
stable/6.12: [f6fc21ec7ccd83726ba766d73d0b8cc03e726475]
stable/6.18: [dcf3e2f164435b5844706cb8eefef29ebee0eedb]
stable/6.6: [1a1d7158420df6b8fa1efc0cdd6ab704801a4fc8]
stable/7.1: [d4964a74717107697999f48bcb4e80a9c0679a27]

CVE-2026-64584: usb: gadget: f_midi: cancel pending IN work before
freeing the midi object

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64584

Introduced by commit 8653d71 ("usb/gadget: f_midi: Replace tasklet
with work") in v5.12-rc1.
Fixed in v7.2-rc5.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [5650c18d93a1db7e27cb5a40b394747eb4686d5b]
stable/6.12: [87bc316dd6fc90072297c635e10b9aa6075ecda1]
stable/6.18: [f45089eaad0a083d71d84ff175741d7e157d9b69]
stable/6.6: [380b4bef46c2eb260c7a9c6bb2c5be33ce5a38f9]
stable/7.1: [ac9a51d910bb7465c554c45320cb6c09f3d0b49d]

CVE-2026-64585: can: esd_usb: kill anchored URBs before freeing netdevs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64585

Introduced by commit 96d8e90 ("can: Add driver for esd CAN-USB/2
device") in v2.6.36-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c43122fef328a70045fe7621c06de6b2b8e19264]
stable/6.1: [aa1d005927db38af783c1a4a8a00a39e0229ab2d]
stable/6.12: [a3314f10369df70925140f59bbe069718f65a0b9]
stable/6.18: [765ba1c91823a296447528791b89a6504947fd5c]
stable/6.6: [a02e1d8f191324583599544d54e59e6a2b74bb0e]
stable/7.1: [5832c55b3c824ba2fe9c36ac3c411baddcce053e]

CVE-2026-64586: wifi: brcmfmac: drain bus_reset work on device removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64586

Introduced by commit 4684997 ("brcmfmac: reset PCIe bus on a firmware
crash") in v5.2-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [43b25879f004c98defa2776bedc6ca4763c51945]
stable/6.12: [e3815d1ffbb9be4f1605ddc3b427557893461683]
stable/6.18: [02d378828af8bb74f6c2f4d2bee3c77cf16c861e]
stable/6.6: [c268331845ee00dbdbccb000826bb612dff2bee7]
stable/7.1: [177a25be1195f8bdc6160ba5f1a5699f7041c985]

CVE-2026-64587: net: ethernet: arc: emac: quiesce interrupts before
requesting IRQ

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64587

Introduced by commit e4f2379 ("ethernet/arc/arc_emac - Add new
driver") in v3.11-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [92802fae45a0a7048e60cecf20efaf8820b4fe7d]
cip/4.4-st: [0c56d53fcb25862869b4c3af6cb55858aec86a1f]
mainline: [2503d08f8a2de618e5c3a8183b250ff4a2e2d52c]
stable/5.10: [abd338da658d7faa8e26cfefc8f83f0066707564]
stable/5.15: [5f29dd540fe5ea3c826fc8ec759ba488b31f9707]
stable/6.1: [6fc7449773748c7b904235a09a67054d78ab1172]
stable/6.12: [d0f2386f529807826e7404d40a245ee428f89f62]
stable/6.18: [8efd5dcd31e22a9308b16b107a052fcd568c0a99]
stable/6.6: [81431da777924dddaefa5c9b0ca9da4a93f9df96]

CVE-2026-64588: fuse-uring: fix data races on ring->ready

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64588

Introduced by commit c2c9af9 ("fuse: Allow to queue fg requests
through io-uring") in v6.14-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [46725a0056c884cf58a6897f222892807327d82d]
stable/6.18: [b156bb9966972122b148acab8bdf415cdb8176a3]
stable/7.1: [d01a09b442cb786cd44ccc7c84d57e2856d6737c]

CVE-2026-64589: i2c: core: fix NULL-deref on adapter registration failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64589

Introduced by commit 3f8c4f5 ("i2c: core: fix reference leak in
i2c_register_adapter()") in v6.13.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [2295d2bb101faa663fbc45fadbb3fec45f107441]
stable/5.10: [dfccc79e5095bd0b017ae093077e3d7853b9e1e5]
stable/5.15: [9b49b2c4e39cef71819548fea841d3fe0fc0e170]
stable/6.1: [01326c7d1453f19f552b09eccb5776fbf2b91ed5]
stable/6.12: [2ce0a74bfa3acdfcdb00cf02f181f2754b451f42]
stable/6.18: [3351c5e77749a0c8a1e252b95420c143ebcf07ac]
stable/6.6: [ad4322d84ebf766914489233153b10b0519efdb4]
stable/7.1: [034e307428119b67f5f18a35e4f4e7d15a2b9774]

CVE-2026-64590: dma-buf/udmabuf: skip redundant cpu sync to fix
cacheline EEXIST warning

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64590

Introduced by commit 284562e ("udmabuf: implement
begin_cpu_access/end_cpu_access hooks") in v5.6-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [504e2b4ab97a51d56d966cd36d0997ad30b65b2d]
stable/6.12: [d6552f5cff795d60e629f37513ecf23d88fd2f82]
stable/6.18: [34696563461c9a23177feb6d8aff43f4c0510278]
stable/6.6: [0db56e7eae932f8e2f3eb44ad1a63633d8f504f8]
stable/7.1: [0449a6583c0ee76778d314e4e82f166fc97fa9d8]

CVE-2026-64591: iommu/vt-d: Avoid WARNING in sva unbind path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64591

Introduced by commit 39c20c4 ("iommu/vt-d: Only handle IOPF for SVA
when PRI is supported") in v7.0-rc5.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [534b5f98ab7319d8004bbc7dab6481462243e883]
stable/6.18: [bb354384f40bb087e7c44f0f0743a23fc945f91d]
stable/7.1: [477f8dec3b5ae54e8ef3c33bdd2257e47896512e]

CVE-2026-64592: riscv: mm: Unconditionally sfence.vma for spurious fault

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64592

Introduced by commit 503638e ("riscv: Stop emitting preventive
sfence.vma for new vmalloc mappings") in v6.12-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1b2c6b56a9fa0dcbef461039937de22b1cbecc7d]
stable/6.12: [c4df24702bfc3cd2bed7746b94dc6139a3fa5428]
stable/6.18: [4d730cab96e6b75e4a07c4baf37294ebc07f795e]
stable/7.1: [ede985ff4b569ed2454024f8bb107a6729fe08aa]

CVE-2026-64593: btrfs: do not trim a device which is not writeable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64593

Introduced by commit 499f377 ("btrfs: iterate over unused chunk space
in FITRIM") in v4.3-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1b1937eb08f51319bf71575484cde2b8c517aedc]
stable/5.10: [f41ae7e6664f3c4361129728f2c4d5f3ed995251]
stable/5.15: [210af872eafa0cf572a84cb303c0f9d2914c1226]
stable/6.1: [3d8fa4b828a86b33c60858e58aaab6df273ede05]
stable/6.12: [02c903fc6fc7e16c5d1f22d18784f1208acf43e3]
stable/6.18: [7a64521802997257b144e6edfb4e278dbeb972dd]
stable/6.6: [9c894159c5b8adc84072e3af0e55b0473a69564e]
stable/7.1: [b4af31b898a948e29861cb0bae734058f9a49d9b]

CVE-2026-64594: usb: gadget: f_fs: initialize reset_work at allocation time

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64594

Introduced by commit 18d6b32 ("usb: gadget: f_fs: add "no_disconnect"
mode") in v4.0-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3137b243c93982fe3460335e12f9247739766e10]
stable/5.10: [7fe895e0a9651518c4fc082487da770ff9c14c7f]
stable/5.15: [0de6ebbabfbbc9c28350283dc97d8a519d5c6dd7]
stable/6.1: [cb19e54ebe9baf3c3243083ade65c937339ccb7b]
stable/6.12: [c36393b0d14e1e9783888f821ffe29381b8f46dc]
stable/6.18: [69faa3779250df14f51d5084f938a99809546e52]
stable/6.6: [d5631081be07f20e764d3cb5c98ac0a1004fba51]
stable/7.1: [ba1867999dbc4085e6d8c52ac5266005b8b2bf07]

CVE-2026-64595: HID: hid-lenovo-go: cancel cfg_setup work in hid_go_cfg_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64595

Introduced by commit d69ccfc ("HID: hid-lenovo-go: Add Lenovo Legion
Go Series HID Driver") in v7.1-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [73fde0cbff7d9d618591774a12c23434232752c1]
stable/7.1: [3e7761f7bf9f0187bb18cf52b5119bdf4940e686]

CVE-2026-64596: libfs: set SB_I_NOEXEC and SB_I_NODEV by default in
init_pseudo()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64596

Introduced by commit 1e7ab6f ("anon_inode: rework assertions") in v6.16-rc5.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6de2aeffabaafaeda819e60ec8d04f199711e11a]
stable/6.18: [b9d45d328fcda4f0d3d281b7d6f12d3f181d9381]
stable/7.1: [8e931557b317f0fb414839fa51fae1d5feb0ad97]

CVE-2026-64597: smb: client: fix double-free in SMB2_close() replay

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64597

Introduced by commit 4f1fffa ("cifs: commands that are retried should
have replay flag set") in v6.8-rc2.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [f96e1cdcb63ed3321142ff2fcdf784e32cda8fee]
stable/6.12: [0aa97edf7c347c0f54e7e60c4740574b8120c66a]
stable/6.18: [d15d83125007f673aec4323e1bbbaaffbe87ea13]
stable/6.6: [037511726228aaf165c7067ff2bfc88eaecdf1f3]
stable/7.1: [b18ed621dbfceecea5539848cddcb9272c9a61e1]

CVE-2026-64598: smb/client: Fix error code in smb2_aead_req_alloc()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64598

Introduced by commit d08089f ("cifs: Change the I/O paths to use an
iterator rather than a page list") in v6.3-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [61f28012e5650c619223decdb7970e0d3162e949]
stable/6.12: [cad756733dc3985188983f3e2eb77e2927209099]
stable/6.18: [a187883cc1dc784a4d32537f5d316f1b7b9ad76f]
stable/6.6: [aa37f5fef78dd11cbf983269da2031e12625c56d]
stable/7.1: [a1cc432cb0b0a1f74f98a0db3b94ca880c7947ac]

CVE-2026-64599: crypto: amlogic - avoid double cleanup in meson_crypto_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64599

Introduced by commit 48fe583 ("crypto: amlogic - Add crypto
accelerator for amlogic GXL") in v5.5-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d827ade51a24e18d81afb9f32756d339520a14c]
stable/5.10: [c2c48aa7a6be36d4c93da75d14d4b4f2f4168c81]
stable/5.15: [c80360b4e85099fc3835378a96a59c0a2480fb07]
stable/6.1: [5b452019a4127f63c1f2147237fc287d1581f606]
stable/6.12: [6effdbaca3cd8354540bdf42c7f5fb84412afeb7]
stable/6.18: [84a00be9b736aa5dce902a290f62cbbbdcfab9ed]
stable/6.6: [f30e2b879bda14bc3e1524fba6f8ab9ec119da90]
stable/7.1: [6dda8406d8a3da2519c8b388d443d7357839cb63]

CVE-2026-64601: ALSA: us144mkii: capture_urb_complete: redundant
usb_anchor_urb corrupts anchor list on each resubmission

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64601

Introduced by commit c1bb0c1 ("ALSA: usb-audio: us144mkii: Implement
audio capture and decoding") in v6.18-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5cff1529a2f9b3461a7f5a6e36a86682fc290534]
stable/6.18: [16f14f55141d4c55c3f321f93c328fff7cd6860a]
stable/7.1: [ab1db64912428cdf06a4f9542e16e0575e9ad59f]

CVE-2026-64602: iio: adc: spear: Initialize completion before requesting IRQ

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64602

Introduced by commit b586e5d ("staging:iio:adc:spear rename device
specific state structure to _state") in v3.16-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3ee2128b6f0eb0be7b6cb8f6e0f1f113a65201a0]
stable/5.10: [aea8ae6c4d3ed58d9223360f758df6bd8b90c608]
stable/5.15: [67a49ab41320b3f721ce4be7447754ff040acbd5]
stable/6.1: [a50757398794aaa25f908b96c6733e045466cba4]
stable/6.12: [37077d8271b1f24894fbc21bca1c4cd337525d31]
stable/6.18: [bbfebae473ac2c8a194523b29ccb9b45f02f134c]
stable/6.6: [f3f90bc7b38ba3ff14f131cea0f8eb77624787a8]
stable/7.1: [eb5b07c9d0ec1a9d4b6871b14793c19967d79dc4]

CVE-2026-64603: platform/x86: intel-hid: Protect ACPI notify handler
against recursion

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64603

Introduced by commit e2ffcda ("ACPI: OSL: Allow Notify () handlers to
run on all CPUs") in v6.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c085d82613d5618814b84406c8b2d64f1bc305e7]
stable/6.12: [a6402808e552e44e9c26a9fe8395ac11703d5800]
stable/6.18: [86df6499dfd232fbc1c82c0d6eb9322ca67b8cd0]
stable/7.1: [eace3b3e729d5ba11794d69acfafb58a7950217c]

CVE-2026-64604: KVM: VMX: Grab vmcs12 on CR8 interception update iff
vCPU is in guest mode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64604

According to the .vulnerable file, this bug was introduced by commit
a7c0b07 in v3.18-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ef78d71ca713d8c00f7c34ddcf276c808143f77]
stable/5.10: [c7cd3605244c924249dea32632e1bc3e89bda543]
stable/5.15: [9a21f1defd96c6301c5fb462a78eb51b191bd2dd]
stable/6.1: [570af5db081b87374594a00711ac5760d2ea6844]
stable/6.12: [258ec63c0f281bf7b50f9de67c8e93b5b7be5ed4]
stable/6.18: [3dcfb04dd43b16fa1240fc6487fff578ad57264c]
stable/6.6: [ffaaff82336db84e9b58e7a3e81c2fd64e05ed7a]
stable/7.1: [db8407b9fd06d857a4a5e8bcff1d086d13007711]

CVE-2026-68480: x86/bugs: Make Safe-RET robust against interrupt injection

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68480

Introduced commit is not determined.


Fixed status
mainline: [7e7f81cf6f5ca3311e526308f55d7c54d3ba71f9]
stable/5.10: [9de1a49e8f1fbf7c372902573a27a97d4ab4d0af]
stable/5.15: [9c0b8105e919be5208c81d5516a194a28c58fe1e]
stable/6.1: [95b08cdd603fe79d2e9d5212fbb13d577c835f4f]
stable/6.12: [e262f28a69ae9e0791248f93b0173c1d1f3e1d5d]
stable/6.18: [bfe7f9993467ba431b2731437949ac1e2634e771]
stable/6.6: [608c8f5dccaaf8b8d2b28c0fbdd439d144be62b0]
stable/7.1: [61649a2d61cb0dbc673f0f232f0f0c298bf50442]

CVE-2026-68081: KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails
due to invalid guest state

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68081

Introduced by commit 96c66e8 ("KVM/nVMX: Use kvm_vcpu_map when mapping
the virtual APIC page") in v5.2-rc1.
Introduced by commit 3278e04 ("KVM/nVMX: Use kvm_vcpu_map when mapping
the posted interrupt descriptor table") in v5.2-rc1.
Introduced by commit fe1911a ("KVM: nVMX: Use kvm_vcpu_map() to
get/pin vmcs12's APIC-access page") in v6.0-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f2312c422fd2695da772cecb30c69994b795964]
stable/6.18: [7996013b85687034d2e820cef94d6404192e3a3d]
stable/7.1: [2c87a087c20632d68920272173b5d7c47f9bcf70]

CVE-2026-68082: libceph: fix two unsafe bare decodes in decode_lockers()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68082

Introduced by commit d4ed4a5 ("libceph: support for lock.lock_info")
in v4.9-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a109a556115271ca7896dcda7b4b7e45e156c227]
stable/7.1: [a54be593d0b749161b08a1e56189b2cb9114267a]

CVE-2026-68083: ksmbd: fix path resolution in ksmbd_vfs_kern_path_create

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68083

Introduced by commit 265fd19 ("ksmbd: use LOOKUP_BENEATH to prevent
the out of share access") in v5.15-rc3.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c8951963d8ed357f70f59e0ad4ddce2199d2016]
stable/6.12: [489d1ded01425c0fb33418172c0e4e588467526b]
stable/6.18: [c7c884a1305aa4540eb7942a50bd356b34120e1f]
stable/7.1: [98185b3025beeae92d1fe700d5db26b9ac4bf025]

CVE-2026-68084: staging: vme_user: fix location monitor leak in tsi148 bridge

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68084

Introduced by commit d22b8ed ("Staging: vme: add Tundra TSI148 VME-PCI
Bridge driver") in v2.6.32-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [151edde741f8bc7f2931c5f44ab376d32b0c8beb]
stable/6.1: [18be0ad31b161a8b6fbc90d14355ad40c061b6b0]
stable/6.12: [36902ab588ccc2fa07994adf6c5f51cbfe379177]
stable/6.18: [e3ceafa6d8ee6b3a0f7fabe7a551fda909edbd46]
stable/6.6: [eef048dd77ebfbf99d7c28f9e9dd331d2af7b6f6]
stable/7.1: [c6cda17e98545980e42291fc4282daa8a8ebe384]

CVE-2026-68085: Bluetooth: hci_uart: clear HCI_UART_SENDING when
write_work is canceled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68085

Introduced by commit c1bb933 ("Bluetooth: hci_uart: fix UAFs and race
conditions in close and init paths") in v7.1-rc5.
Fixed in v7.2-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.18 stable/6.6

Fixed status
mainline: [1b0d946d6f08bd39211385bc703a440911b41e46]
stable/6.12: [d52446b3e735cfdbdc2a58342163803bc2e64249]
stable/6.18: [b9dd39cf1667e378b25a082ca796d495d578c5d3]
stable/7.1: [714d861d35d937f23375a4517569b13917bbbe51]

CVE-2026-68086: mm/khugepaged: write all dirty file folios when collapsing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68086

The code was removed from upstream by 044925f ("mm: fs: remove
filemap_nr_thps*() functions and their users"). So, this fix is not
backported from upstream.

Bug introduced commit is not backported to older stable kernels.

Fixed status
stable/7.1: [2dfe9f5c91d0963058f8a5e46e1c2a908382cc46]

CVE-2026-68087: HID: wacom: use GFP_ATOMIC in wacom_wac_queue_flush()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68087

Introduced by commit 5e013ad ("HID: wacom: Remove static
WACOM_PKGLEN_MAX limit") in v6.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [55f1ad573e34abf9a0443c34bc5a63d74edba7d7]
stable/6.18: [bbe1e55629bfaabd4b2e8125b48dd3503d74ac8b]
stable/7.1: [27c4dad1b7917b747bf080792a527997e3147c69]

CVE-2026-68088: usb: gadget: function: rndis: add length check to response query

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68088

According to the .vulnerable file, this bug was introduced by commit
340600a in v2.6.13-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [95f90eea070837f7c72207d5520f805bdefc3bc5]
stable/5.10: [efcf4e4eeea0d69d8da72a7bc5cbd49b6192260e]
stable/5.15: [bb2b4402b4571b0c989b977779f7be01107ca425]
stable/6.1: [585921866d2d7d65d4b0d89927c78f784668cf5f]
stable/6.12: [f5870777458d8be65d7cd08bc750a03f17998350]
stable/6.18: [e01e7814b4223560eab0513b7c15b8c82bdc83f3]
stable/6.6: [caea8b120604312bab2bfeb1a972f9cd17019e93]
stable/7.1: [b09716040f3fa4a252eeda3ceb5295ea0e39c1fb]

CVE-2026-68089: iio: core: fix uninitialized data in debugfs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68089

Introduced by commit 6d5dd48 ("iio: core: make use of
simple_write_to_buffer()") in v6.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab92ed206d41fd171ebd37bc46360d9f2140d043]
stable/6.18: [e166a8cfb28a3d0da260dd70cae274eb8c7cec8d]
stable/7.1: [89fbd3e32dffb6227f936a9578e6eb4632aa4580]

CVE-2026-68090: debugobjects: Plug race against a concurrent OOM disable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68090

Introduced by commit b84d435 ("debugobjects: Extend to assert that an
object is initialized") in v3.3-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b81dde13cc163450dcb402dcc915ef13ba241e01]
stable/5.10: [2d5e320b7ab9b25229ac4331541964a58b5e1d29]
stable/5.15: [203a965bf2ab43130778d8214fb0c3c8c2d19cdf]
stable/6.1: [23da32e88627e63e0864f59f4c63a2dc0ab851a3]
stable/6.12: [e2e255d07723c330dded8e576ce28a8d23a692ce]
stable/6.18: [c00164c9e7fa6145886ad666806cb5347895de5c]
stable/6.6: [d663fbf28b2eebe665bb9cf828d7d528e5a8707e]
stable/7.1: [1f4f02b336c3be125c8fcf87df73db2e0e028b8b]

CVE-2026-68091: HID: wacom: stop hardware after post-start probe failures

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68091

Introduced by commit c1d6708 ("HID: wacom: Do not register input
devices until after hid_hw_start") in v6.8-rc5.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [ec2612b8ad9e642596db011dd8b6568ef1edeaa1]
stable/5.10: [5a7ca028facf04921b2c1c2e4d1ee7f282510555]
stable/5.15: [3e6473a4f0596182acdda5219b4bebfbee76514f]
stable/6.1: [46d8b8c85ae0589fb85746a64e8908160e52aac3]
stable/6.12: [75eb2173b63ab41c24d80cd641af18f3c117a267]
stable/6.18: [416095e9a6037b4b39fcadd0d2bd77a8852211ec]
stable/6.6: [1a1ebdcb56ae58a0ee2c54dd15d75121e30424e3]
stable/7.1: [e2cc711a9df37f359159b21db56cea9c21f58a9c]

CVE-2026-68092: time/jiffies: Register jiffies clocksource before usage

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68092

Introduced by commit 76031d9 ("clocksource: Make negative motion
detection more robust") in v6.13-rc2.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [f24df84cbe05e4471c04ac4b921fc0340bbc7752]
stable/6.12: [fe9bdea65ba231fcfb155031628bb1e8491b5fe0]
stable/6.18: [cd25e9819620aa1325897912cfb4dd89303325fe]
stable/7.1: [75b478096c6bbf57fe366f7f0a8cd5365043ffaa]

CVE-2026-68093: KVM: SVM: Bump asid_generation on CPU online to avoid
ASID collision after hotplug

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68093

Introduced by commit 774c47f ("[PATCH] KVM: cpu hotplug support") in
v2.6.21-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25f744ffa0c8e799e06250ce2e618367b166b0d4]
stable/6.12: [7508916b4b55d6f5ecc68cd09774dabd3a6b4440]
stable/6.18: [0f33b1c457c2199ed130b92cc2ff363a3f7b9415]
stable/6.6: [60283726f2845bd78b95efbd0e50b93944780477]
stable/7.1: [6b542d116acecb83a1ca34e8eace304cff6a4ec9]

CVE-2026-68094: sched_ext: Preserve rq tracking across local DSQ dispatch

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68094

Introduced by commit 7fb39e4 ("sched_ext: Save and restore
scx_locked_rq across SCX_CALL_OP") in v7.1-rc2.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [18d62044cda7a2b40f59d910659c0b0d6accad37]
stable/7.1: [97c09c9f5739b8757ee29dabb0af30069137e286]

CVE-2026-68095: fuse-uring: fix race between registration and
connection abortion

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68095

Introduced by commit 24fe962 ("fuse: {io-uring} Handle SQEs - register
commands") in v6.14-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [952b5d36f6a298f57c52a59e72076c69386a8aaf]
stable/6.18: [3bca70235a706de76fe9a81defd37d987062c686]
stable/7.1: [2cd945492bc5b472e814272e88b731bb9bb17629]

CVE-2026-68096: audit: fix recursive locking deadlock in audit_dupe_exe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68096

Introduced by commit 34d99af ("audit: implement audit by executable")
in v4.3-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [81905b5acbe77284734438df3fbec1158e6429a3]
stable/6.12: [7d1f66c69898ffb1a718926c32a777ecc471caca]
stable/6.18: [40879c39d6740f3dddfb52b5d6ba7fb8cceb84d8]
stable/6.6: [36eb77f14b4e6f2dc1008c1fabe31236397be27a]
stable/7.1: [3b601938314c24fcd1afb6659cad92fe96c9c2f8]

CVE-2026-68097: ksmbd: validate ACE size against SID sub-authorities

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68097

According to the .vulnerable file, this bug was introduced by commit
e2f3448 in v5.15-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5152c6d49e3fd4e9f2e857c57527aead752f1f87]
stable/6.12: [62d80d7c2d9428085e7458ad4c06ca8c0984039b]
stable/6.18: [337022d9dfac441c3b35e4455a51aa981996e02e]
stable/6.6: [b7cb5bf0855470799f12da825de91e48951b3876]
stable/7.1: [61fd3559199f7fa693dcbff35e59477e24af041a]

CVE-2026-68098: ksmbd: bound DACL dedup walk to copied ACEs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68098

According to the .vulnerable file, this bug was introduced by commit
e2f3448 in v5.15-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [58d97fcd0bf1aee694e244cc28635b9df95b543b]
stable/6.12: [b057a851129c6a084e7e393b62ca3abf6c2660bc]
stable/6.18: [f1eba60db813ec28732bf18b5f0a67ebac9c3100]
stable/6.6: [6d9d7aa4a2c99c31acfa28921c30b684110cf66c]
stable/7.1: [a0ebdaa79e10210d4e8ed9fe138e8f4d569719e3]

CVE-2026-68099: ksmbd: restore DACL size on check_add_overflow() to
avoid malformed ACL

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68099

Introduced by commit 299f962 ("ksmbd: use check_add_overflow() to
prevent u16 DACL size overflow") in v7.1-rc1.
Fixed in v7.2-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [bbf0a8e931204ecdab494a88d43b0a24a04285c5]
stable/6.12: [0bf38372821b1526f31538a7d9811844c55c7f38]
stable/6.18: [847ecd4eb3c117c3d2f13f1e7ab506543aad8183]
stable/6.6: [f4fcd0c1a243d449307b887fafee23921e9db5ab]
stable/7.1: [bc90144ce8bb7fcf05ad9417c7adb4e9509d9e13]

CVE-2026-68100: ksmbd: validate num_subauth when copying ACE in set_ntacl_dacl

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68100

According to the .vulnerable file, this bug was introduced by commit
e2f3448 in v5.15-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47f0b34f6bc98ed85bfdc293e8f3e432ec24958d]
stable/6.12: [fb3dc8e6da46a1ccad1956cda57de29d9b3033e0]
stable/6.18: [b6d3cc6a524416dfdb2b47e4bba2e7e20011d056]
stable/6.6: [e31fada5143784bc05c7ae44c79eed9b7a2e147e]
stable/7.1: [5acbd3012fd4a7ccfebd91ea6f784120084eb897]

CVE-2026-68101: drm/amdgpu: fix check in amdgpu_hmm_invalidate_gfx

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68101

Introduced by commit 9125089 ("drm/amdgpu: fix waiting for all
submissions for userptrs") in v7.2-rc1.
Fixed in v7.2-rc2.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [52f650963d8825e97a0ccdd2b616f8a01d9d3d38]
stable/6.18: [15a7cb71a5748a718453f3b01e1da3b52349c043]
stable/7.1: [be354ea7261c2fa43d2c78fc1192ddae08bdbffc]

CVE-2026-68102: drm/amdgpu: fix aperture mapping leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68102

Introduced by commit 9d0af8b ("drm/amdgpu: pre-map device buffer as
cached for A+A config") in v5.13-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea772a440d56b285f4d491affac50ecd41f6b402]
stable/6.12: [a343d028ad6c174da8dc6af560c51e6d140a6727]
stable/6.18: [6405c4e75b3bcf0e72bd7a0ff5f1ed0c475e23aa]
stable/6.6: [67bc3647e418e23dc0d17604bdba634a73de809f]
stable/7.1: [f5988b5c300a32ff751724ffd33d5a8d5873e4a7]

CVE-2026-68103: drm/amdgpu: reject mapping a reserved doorbell to a new queue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68103

According to the .vulnerable file, this bug was introduced by commit
8949843 in v6.16-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a609b6278bf3cde17eeee6620091465521e4b02c]
stable/7.1: [1050d258c7c56066d2dcaedf8d0ef66364062adc]

CVE-2026-68104: drm/amdgpu: invoke pm_genpd_remove() before freeing genpd

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68104

According to the .vulnerable file, this bug was introduced by commit
2503032 in v4.6-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [28c9b3c5dc35cc790d11e26ca3fc6e068be63998]
stable/6.12: [5c0a82283271759fff445ac27182072f200a888c]
stable/6.18: [08fee493e0261f9e4120a5c8e7e42e8a723574e8]
stable/6.6: [bdfc7f1e0900ef1361b828c4f69b72701f8a0a86]
stable/7.1: [930a5dc3df4aa5e10393134bd5313d616dbebaf6]

CVE-2026-68105: drm/amdgpu: Fix kernel panic during driver load failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68105

According to the .vulnerable file, this bug was introduced by commit
52cb80c in v6.11-rc1.
Fixed in v7.2-rc2.
The gfx_v12_0.c was added by 52cb80c ("drm/amdgpu: Add gfx v12_0 ip
block support (v6)") in v6.11-rc1. The gfx_v12_1.c was added by
ad5f1ee ("drm/amdgpu: Add initial support for gfx v12_1") in v7.0-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a279bd143b3c184358b658e43a057e31ee8c4de5]
stable/7.1: [5bc93f907bad7e076d814664dfab8fc230efca3d]

CVE-2026-68106: drm/amdgpu: fix division by zero with invalid uvd dimensions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68106

According to the .vulnerable file, this bug was introduced by commit
d38ceaf in v4.2-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c01c811be47e6b146552dd59bfedbea8f09b8f4]
stable/6.12: [a00946b5ab7c25da5685ca9c58f50ff6f43c0fdf]
stable/6.18: [ffb33d466a68cea3e8a3dbed04d79037a3cbabd1]
stable/6.6: [52f9a588296432accf2982f7d258192a37562f4f]
stable/7.1: [be725ab23aa45c11a5afef3e2a9f6d8c084ae5dc]

CVE-2026-68107: drm/amdgpu/vcn4: avoid rereading IB param length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68107

According to the .vulnerable file, this bug was introduced by commit
2b10cb5 in v6.17-rc6.
Fixed in v7.2-rc2.
The vcn_v4_0.c was added by 8da1170 ("drm/amdgpu: add VCN4 ip block
support") in v5.19-rc1.
Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [3b4082fabc67c9780b06eb959e59dd92fa79c0f0]
stable/6.12: [ff6aa542d91d76a185f69bd1997b94a560ff5f6b]
stable/6.18: [bd868c077f67589ed2a714307ceaade5f246e302]
stable/6.6: [bbbe6a2a8d8dc87243438d3ffea2083b52d882d9]
stable/7.1: [c309626bf91fa0a0b583575654e6e14e81f818a3]

CVE-2026-68108: drm/amdgpu/vce: fix integer overflow in image size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68108

According to the .vulnerable file, this bug was introduced by commit
f1689ec in v4.2-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [186bfdc4e26d019b2e7570cb121964a1d89b2e5b]
stable/6.12: [a6d7065b91a14790980ce6f4960db0ca8c3c9940]
stable/6.18: [7eebef042c12dfe0568593ee6a8926d16505925e]
stable/6.6: [a07430abd556de3707adfcadcc60db3fa64e4b2b]
stable/7.1: [00c311a13d225266800c712f2b7db2711c6897de]

CVE-2026-68109: drm/amdgpu/sdma7.1: replace BUG_ON() with WARN_ON()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68109

According to the .vulnerable file, this bug was introduced by commit
4ed5116 in v7.0-rc1.
Fixed in v7.2-rc2.
Affected file was added by 4ed5116 ("drm/amdgpu: Add sdma v7_1_0
support") in v7.0-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [767648c18d7872bbf54481ba846e055f7e1c0213]
stable/7.1: [253b1401862b9eb2be54f63546505a40a14672dd]

CVE-2026-68110: drm/amdgpu/sdma4.4.2: replace BUG_ON() with WARN_ON()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68110

According to the .vulnerable file, this bug was introduced by commit
7138fc8 in v6.4-rc1.
Fixed in v7.2-rc2.
Affected file was added by 7138fc8 ("drm/amdgpu: add sdma v4_4_2
support (v4)") in v6.4-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [40cdbe9fa424cc6264a7aed93a04bd7d69109d9e]
stable/6.12: [ca50e541191fab519ed628182e1472e21d60e2ce]
stable/6.18: [dc3f5da1ba8e280d31676ce15b937e4302235b03]
stable/6.6: [256d6f4803a93df96579c1ffdcb56518b9304f76]
stable/7.1: [cbe3b293d0ee926e595f53513d7c027d1c3e5be5]

CVE-2026-68111: drm/amdgpu/gfx9: replace BUG_ON() with WARN_ON()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68111

According to the .vulnerable file, this bug was introduced by commit
b102357 in v4.12-rc1.
Fixed in v7.2-rc2.
Affected code were added by b102357 ("drm/amdgpu: implement GFX 9.0
support (v2)") and 72408a4 ("drm/amdgpu: enter rlc safe mode before
set cgpg").
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6302be10b521f5106ce01eb5a724b9e7945a5061]
stable/6.12: [d74a6351d3f64e1f8a0fba28b369c0eeecf517f1]
stable/6.18: [042c047e8bc9c9ada7574028a8e4592102e2e1fd]
stable/6.6: [6c8b9c1f03c7169c9577098b0c3035617606f8d4]
stable/7.1: [43768ad42b8f1a91652b86e0731ac14d6853cebb]

CVE-2026-68112: drm/amdgpu/gfx9.4.3: replace BUG_ON() with WARN_ON()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68112

Introduced commit is not determined.Fixed in v7.2-rc2.
Affected code was added by 8630112 ("drm/amdgpu: split gc v9_4_3
functionality from gc v9_0") in v6.5-rc1.

Fixed status
mainline: [00f4050f7c367d7bdce347ca279ce467c434cf15]
stable/6.12: [cfb02825277526bd216b56be555a97a9e8612682]
stable/6.18: [05aea3344c422fe95299bb1b21a04de30c7ea198]
stable/6.6: [c59b57c2e0c8cced4350ff7792361ba2a79ee85c]
stable/7.1: [ac89ea915e8b848c7cbe97b1aad2dc4f5770c6d7]

CVE-2026-68113: drm/amdgpu/gfx12: replace BUG_ON() with WARN_ON()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68113

Introduced commit is not determined.Fixed in v7.2-rc2.
Affected code was added by 52cb80c ("drm/amdgpu: Add gfx v12_0 ip
block support (v6)") in v6.11-rc1.

Fixed status
mainline: [cd3b3efa1ced05528d9128755338baa62a6b562d]
stable/6.12: [eef69b826b2036314b59020dfa6083fc859bfcc1]
stable/6.18: [987bedd3ea89d747d1c5ab708ce3293e2f033b6c]
stable/7.1: [81597685c0d73b9c2e1a89c12c576ab80d1c00f4]

CVE-2026-68114: drm/amdgpu/gfx12.1: replace BUG_ON() with WARN_ON()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68114

Introduced commit is not determined.Fixed in v7.2-rc2.
Affected code was added by ad5f1ee ("drm/amdgpu: Add initial support
for gfx v12_1") in v7.0-rc1.

Fixed status
mainline: [6560e6bd76127844e39f09fa591c2791dc7932e8]
stable/7.1: [1c27e889fa162bc3590de0942237d2ccec96b765]

CVE-2026-68115: drm/amdgpu/gfx10: replace BUG_ON() with WARN_ON()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68115

Introduced commit is not determined.Fixed in v7.2-rc2.
Affected code was added by a644d85 ("drm/amdgpu: add gfx v10
implementation (v10)") in v5.3-rc1.

Fixed status
mainline: [d06c4173a7c38c7a39e98859f839ce714c7af2c9]
stable/6.12: [6c8cfdc2321c1284dc4320ac148867ea8f6419bd]
stable/6.18: [7e22de67e545d0f72595514d3a66675e9d074adc]
stable/6.6: [793cdf17ddf9dc662a94cae86ce005565ef3c1c2]
stable/7.1: [2929a932b0d70f481dbcb6994181544b07913de0]

CVE-2026-68116: vxlan: mdb: Fix source list corruption on a failed replace

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68116

Introduced by commit a3a48de ("vxlan: mdb: Add MDB control path
support") in v6.4-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dcd9b465965422b9654f6026e8a2fa8984f74c3c]
stable/6.12: [2c54dff57606590fa4abec46bab6bea3133f1539]
stable/6.18: [79370b573e92e8f190eb5f9a511fa5398340d8b2]
stable/6.6: [5bc8fc1d2ff802eec839e03adef5df597421898d]
stable/7.1: [54a3c27b357dfb34f327f89bfadeb998bef8051e]

CVE-2026-68117: tipc: clear sock->sk on the failed-insert path in
tipc_sk_create()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68117

Introduced by commit 00aff35 ("net: tipc: fix possible refcount leak
in tipc_sk_create()") in v5.19-rc5.
Fixed in v7.2-rc5.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [ba0533fc163f905fe817cfabdf8ed4058da44800]
stable/6.12: [dd29891ed840f6b8d020b759d0dc4a00b1d6e4ea]
stable/6.18: [5f5a41a48dbf9eda57b67ce23e548602cf7195a6]
stable/6.6: [b07d87b31631edb6529e6cdcca790a7489d1250d]
stable/7.1: [f9596b1566616a8be0592dbceccb6344a7c6f6bb]

CVE-2026-68118: tcp: challenge ACK for non-exact RST in SYN-RECEIVED

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68118

Introduced by commit 282f23c ("tcp: implement RFC 5961 3.2") in v3.6-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a28c4fcbf774e23b4779cae468e3497a5ad1f4a1]
stable/6.18: [234f9ffbd9b2c1b24ec67200ea3cff07401bec48]
stable/7.1: [22cec809b048495310f206d9abbcdbbfbdce3ae3]

CVE-2026-68119: tcp: initialize standalone TCP-AO response padding

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68119

Introduced by commit decde25 ("net/tcp: Add TCP-AO sign to twsk") in v6.7-rc1.
Introduced by commit da7dfaa ("net/tcp: Consistently align TCP-AO
option in the header") in v6.7-rc5.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e1a9d3cc11829c5414a75eb39c704f461936eb24]
stable/6.12: [bbb7db8c74b0b5d17a695136f0f0806ecd0118f6]
stable/6.18: [fadaff3f66e124c3a62237f9c881819a8ac90309]
stable/7.1: [a859b280441fb02f64ed4037f03d5c0c34a7a595]

CVE-2026-68120: rtase: Workaround for TX hang caused by hardware packet parsing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68120

Introduced by commit d6e882b ("rtase: Implement .ndo_start_xmit
function") in v6.12-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c50efa1faf3a1a96e100b07ec7a2f3164d90bee]
stable/6.12: [fe3a7320711eec6537e4890892f7ab9776d8618f]
stable/6.18: [4a4f3aa6af205bee539b5670afa2cd4e4953750e]
stable/7.1: [0f54f5048615e4e2802697855ea6374613548301]

CVE-2026-68121: pppoe: reload header pointer after dev_hard_header()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68121

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e9c238f6fe42fb1b4dba3a578277de32cb487937]
stable/6.12: [7e9fbd7f96bcde63a7c798fe16b38cedee7a1501]
stable/6.18: [6866abf59976d273164a6624234d96a967280223]
stable/6.6: [e6493a4d1ee17595766165fa446d45b7e0c318d0]
stable/7.1: [bed4caecd723693f750e13adbb2c42ca1249a3fd]

CVE-2026-68122: ovpn: fix peer refcount leak in TCP error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68122

Introduced by commit a6a5e87 ("ovpn: avoid sleep in atomic context in
TCP RX error path") in v6.16-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63bbe18fc03062f483c627838a566a707b62da79]
stable/6.18: [b08526bf0bbf84ceebd29033783e8e0c9f451286]
stable/7.1: [f08f39c1f43f3980d46b06af8ed99ffe84ac294a]

CVE-2026-68123: openvswitch: fix GSO userspace truncation underflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68123

Introduced by commit f2a4d08 ("openvswitch: Add packet truncation
support.") in v4.8-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4032f8ed10fcb84d41c508dfb04be96589f78dfe]
stable/6.12: [fbfa3ad2ad6f3a5624aba5211c46290fb98cc9dc]
stable/6.18: [100a23b1613e9218e0af654ef102352c713f0263]
stable/6.6: [a16eaaf7c0b0ccdef6166707d90ffbc6eebf6855]
stable/7.1: [ea85dbcbe8d4056ecb54352f97743d138ea4c407]

CVE-2026-68124: mctp: serial: handle zero-length frames to prevent rx
buffer overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68124

Introduced by commit a0c2ccd ("mctp: Add MCTP-over-serial transport
binding") in v5.17-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [793b9b729f1e8de57be8c8daf1a9838be96cabed]
stable/6.12: [68819427bc07eca7963a9e8be19e5272cc29186c]
stable/6.18: [f80ba170d7b3a44e3d244a2c8e06031d61bf3b23]
stable/6.6: [36dc6d6964a3b90411cc7944cd9b8b6f67b9807b]
stable/7.1: [06a6b606129c8a25cd457760f5370f3ff01fe05d]

CVE-2026-68125: mac802154: llsec: reject frames shorter than the
authentication tag

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68125

Introduced by commit 4c14a2f ("mac802154: add llsec decryption
method") in v3.16-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd3a3f28ed60c6af4b2a39933b151d6b27842c3b]
stable/6.12: [de80808f37d99c6dc67bb6f97eea00c8f57a8821]
stable/6.18: [f20dedce0429b293d4bad604e0d3f65d8ac96c83]
stable/6.6: [5bbf0cd9b6a7076af86c75e87e180099be2e11ae]
stable/7.1: [e09e0301d616c1ef38a5e64e8e4326fd39df13cc]

CVE-2026-68126: mac802154: hold an interface reference across the scan worker

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68126

Introduced by commit 57588c7 ("mac802154: Handle passive scanning") in v6.3-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [234e5e898b713bc0b3a631b6f002897f43d046c8]
stable/6.12: [dd4754194a706163294b6141460101b99082c8c7]
stable/6.18: [59c1d5463b7bc5a2cdaae27108d1dfd67edc7d1b]
stable/6.6: [bd7110f0caa32426140ff302a209c53294ef2cfd]
stable/7.1: [5f303f622f6bb8907c405e5123a0ab0f70fb0065]

CVE-2026-68127: ila: reload IPv6 header after pskb_may_pull in checksum adjust

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68127

Introduced by commit 33f11d1 ("ila: Create net/ipv6/ila directory") in v4.5-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [92d3817649df2b0b6a008a686c8275c88d7ef594]
stable/6.12: [7097a0280b178237265681be66d1bef11d15894b]
stable/6.18: [472aba2603ca74c4f7722cb0c0296942b0776b8d]
stable/6.6: [896a9512d0d83c2a4b357e5585b7b62a8e3f95c1]
stable/7.1: [c6a13ae00dab3a1a8c7cf2f843f0fc9e8d4b0ccc]

CVE-2026-68128: ice: reject out-of-range ptype in ice_parser_profile_init

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68128

Introduced by commit e312b3a ("ice: add API for parser profile
initialization") in v6.12-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [59abb87159c53605c063f6e2ceb215b5eba43ee6]
stable/6.12: [fe2f8d5a77adea38e889fe3d6cde1b76d4a635bf]
stable/6.18: [5e496f2b615cec4b45537cfb5b54f36a51dc8753]
stable/7.1: [33cc15aaf2491166dddc018b24b3b7db53ec01b2]

CVE-2026-68129: gve: fix Rx queue stall on alloc failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68129

Introduced by commit 9b8dd5e ("gve: DQO: Add RX path") in v5.14-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b65352a1bac64442ad95e64f385b40ccb9f1b0db]
stable/6.12: [0c317349b4baa5038d1fc373bf46d5a2419d1710]
stable/6.18: [91e0249f3ef62b75fe8c9c9372eaba32876e4b3a]
stable/6.6: [299d5728a7312fdd02059b074aebbe4ebbd391e4]
stable/7.1: [689b9f588d2d7323dc66293fe594a68d030f400f]

CVE-2026-68130: ksmbd: defer destroy_previous_session() until after
NTLM authentication

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68130

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c74801ee524f477c174a1899782b6c3b6918d407]
stable/6.12: [243f1614ef2aca2d62a744575f1c24b07cd42757]
stable/6.18: [18705cace0619fd2123737dcd028147774f38181]
stable/6.6: [5c833074b549e5db125436a6f681af682261f785]
stable/7.1: [0ff12308c8a6c16ab68f0a487ffa93d69001dc18]

CVE-2026-68131: rbd: Reset positive result codes to zero in object map
update path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68131

Introduced by commit 22e8bd5 ("rbd: support for object-map and
fast-diff") in v5.3-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a6c4250b81bd30beae94e1b7a4b26fa1193ad2e4]
stable/6.12: [2419aa74081007dc4d14ff5640659052dfdfd69a]
stable/6.18: [34f2a2f32af570dfcc532ad70c080629ee1c32b0]
stable/6.6: [14995c4250f04b58bf6fc00e0e973a2e1b3cfb9b]
stable/7.1: [b1a61366933224b3ad80975c4d01ac2cc6931ecf]

CVE-2026-68132: super: fix emergency thaw deadlock on frozen block devices

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68132

Introduced by commit 08fdc8a ("buffer.c: call thaw_super during
emergency thaw") [1] in v4.17-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [749d7aa0377aae32af8c0a4ad43371e7bf830ab5]
stable/6.18: [63d78b546eefc38ad9898dc839bfc94811ede547]
stable/7.1: [4c483644d1a7709efe7d1be7dbf88cf4008a7864]

CVE-2026-68133: ice: fix PTP Call Trace during PTP release

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68133

Introduced by commit 8293e4c ("ice: introduce PTP state machine") in v6.9-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f6a7e00b81e35ef1325234925f2fe1e53b466f92]
stable/6.12: [7d517b255f669cedd09830214d55f2f413b34481]
stable/6.18: [e4406cbdd915f702d2ed9ee8b30683a16b06c6ac]
stable/7.1: [14fceda28069fdbe1bb49cdb6e1774892b583348]

CVE-2026-68134: ptp: ptp_s390: Add missing facility check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68134

Introduced by commit 2d7de7a ("s390/time: Add PtP driver") in v6.13-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e78f1ac37afcb16cb6fef8a2c92591eab6558956]
stable/6.18: [b3efb4744abf493c9782eae713b861a80d9bbeca]
stable/7.1: [545a7fdbc110c82933d448db2695abff07536f08]

CVE-2026-68135: net: hip04: fix RX buffer leak on build_skb failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68135

Introduced by commit 701a0fd ("hip04_eth: fix missing error handle for
build_skb failed") in v4.5-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [14fa65d10f5696b063a7d8d26e8291ea84a2c6ed]
stable/6.12: [67a7614bde310da006ab259f4f163d3fb0f9e253]
stable/6.18: [80d977f280b4eccd4ac5369871d0ecb2b9c9a49d]
stable/6.6: [e054dcd990d8180cde529ea28ce0838e76a5ad5e]
stable/7.1: [a0f247d63489a107bbc3b712a77b302af2a2a173]

CVE-2026-68136: net: gro: fix double aggregation of flush-marked skbs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68136

Introduced by commit 3a1296a ("net: Support GRO/GSO fraglist
chaining.") in v5.6-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e751256486d0ded20f5a9f9863467f1dce65142f]
stable/6.12: [107e1a469f53a2a70874f3f12bf6fcd23925da1d]
stable/6.18: [a4dfd46cc8f08a29c6183794790547d0945f3d45]
stable/7.1: [fc0c0f7a207f0cd2d2aa725696c907f7d03af9e0]

CVE-2026-68137: net/x25: fix use-after-free in x25_kill_by_neigh()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68137

Introduced by commit 7781607 ("net/x25: Fix null-ptr-deref caused by
x25_disconnect") in v5.18-rc1.
Fixed in v7.2-rc5.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [5499e0602d2faafd42c580d25f615903c3fbe11b]
stable/6.12: [610678d4be94b619c751572e8a58de705592cd07]
stable/6.18: [ec6d91a1bf2ebd767d3d43f6d249ee0ed3f4558a]
stable/6.6: [3f4fe26c20c30bd5a2e2583e80685def0b27858c]
stable/7.1: [9aabda553184346f74810e2ee1d96920b4612e3f]

CVE-2026-68138: net/sched: serialize qdisc_rtab_list against concurrent get/put

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68138

Introduced by commit 470502d ("net: sched: unlock rules update API")
in v5.1-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f43ee0c0730d6191629b5ee1ceae27b1ebfdc047]
stable/7.1: [fb29e1b41052488ee3f2d115d4a870497ebd7f7d]

CVE-2026-68139: net/mlx5e: Use sender devcom for MPV master-up

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68139

Introduced by commit bf11485 ("net/mlx5: Register mlx5e priv to devcom
in MPV mode") in v6.7-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e32649b4bad90a6216d8e93cd7dd050af8ac9740]
stable/6.12: [c698b2735613f1f35c55688bd2252f75f31c49ad]
stable/6.18: [40f9a124ebbe0d60fe165fb3f87515c35b2d72f5]
stable/7.1: [a60c81f168c9fe4f5d84302d1e32b717f5a8a933]

CVE-2026-68140: net/iucv: fix use-after-free of a severed iucv_path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68140

Introduced by commit f0703c8 ("[AF_IUCV]: postpone receival of
iucv-packets") in v2.6.24-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be7cc4656eb1f54029610e82d1f0fdd3f9b5ec0a]
stable/6.12: [a5bbaddf69853117f28173c3f5c8fc14c6b2ec82]
stable/6.18: [900cd6d8119b7f3ae5c4bf82f922ff5957df43db]
stable/6.6: [23658b350b4107e8292045c2044983fd426fa15d]
stable/7.1: [f579582c03ed526281a8450159baf1d35099a85f]

CVE-2026-68141: net/af_iucv: fix NULL deref in afiucv_hs_callback_syn()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68141

Introduced by commit 3881ac4 ("af_iucv: add HiperSockets transport")
in v3.2-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47a5116e56a6b6fe1e909f244e39cd0fc26ceee4]
stable/6.12: [46453b16f38ec7147351f7447e2aec6ea330f7b3]
stable/6.18: [33736ff5e7c97d3348ce812e8bd2e125d840743c]
stable/6.6: [8bb111f87ded6acb9837ec9b45d6f02cda94c51f]
stable/7.1: [0e857185591fe79934427c9c0c1c31dc776be134]

CVE-2026-68142: geneve: require CAP_NET_ADMIN in the device netns for changelink

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68142

Introduced by commit 5b861f6 ("geneve: add rtnl changelink support")
in v4.14-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8efb8f8bbb353b8f2fdf4f37534c6d96c9f69e01]
stable/6.12: [9de5518fc1fab583526a8f66b8e505c4864dc60a]
stable/6.18: [f8c498585d2a08aa623748353c3e61467b7e9fd2]
stable/6.6: [2abdacc927c92fa6a9cc8341e8c9b88dcb561553]
stable/7.1: [95f45e20f1b2cec13823f0f68060ab4b2261b2c1]

CVE-2026-68143: net: slip: serialize receive against buffer reallocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68143

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee7f9bb9320add61f7b367d7e6cd55e3a3a4d65d]
stable/6.12: [44401f7dd9940ced7098930ef64f5a332f279fc2]
stable/6.18: [5d07b178bef511d69558cfc89fe1129258dc39f8]
stable/6.6: [eb3836eab47487823f362e6985e170a1e15f20fd]
stable/7.1: [0e37bbd6d617eb52bace49390e99eaedc1af73ce]

CVE-2026-68144: phonet: pep: fix use-after-free in pep_get_sb()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68144

Introduced by commit 9641458 ("Phonet: Pipe End Point for Phonet Pipes
protocol") in v2.6.28-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0f71f852a96af9685858ce59fda34ecbf85c283d]
stable/6.12: [17f78c0c0d41d738ee236eb6e841e39395188054]
stable/6.18: [a48a889b60f73edb0399a8b08284a2ab0bd0295f]
stable/6.6: [8d931a75a38b9bb584a4071f5ebbd52755fc35ee]
stable/7.1: [25e3641beb51333bfbb155af2fd2573a61113af2]

CVE-2026-68145: iomap: fix out-of-bounds bitmap_set() with zero-length range

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68145

Introduced by commit 4ce02c6 ("iomap: Add per-block dirty state
tracking to improve performance") in v6.6-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9c7d8f7c8994c790fca501dc45ce66e7356cbe05]
stable/6.12: [fb4fad9105c88b1d82f1b3c39e3b6abea8249af6]
stable/6.18: [7037e7bdcd26f46c080b8ce307dee5cb471c4b7c]
stable/7.1: [c5b6a48a8a716a7730e39af1cad083dc4ec955ce]

CVE-2026-68146: ftrace: Add global mutex to serialize trace_parser access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68146

Introduced by commit e704eff ("ftrace: Have set_graph_function handle
multiple functions in one write") in v4.11-rc1.
Introduced by commit 689fd8b ("tracing: trace parser support for
function and graph") in v2.6.32-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7720b63bcef3f54c7fe288774b720a227d54a306]
stable/6.12: [90be137813e1a5bdfd671e40fe28004fb959d3e4]
stable/6.18: [65bf73bee1a4f3722208ae46afc0fa5de76b9a0a]
stable/6.6: [3d0dd138a06c782f8b755cd1b6f9909494514ce1]
stable/7.1: [e807c9193d9493c7a0d039158ebb955050a76df1]

CVE-2026-68147: fscrypt: Avoid dynamic allocation in fscrypt_get_devices()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68147

Introduced by commit 22e9947 ("fscrypt: stop holding extra
request_queue references") in v6.1-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6fe4e4b8259e1330945b5f3c9476e08473b8e0e8]
stable/6.12: [97a688563be71ec6fefc071aff69a66c69dbe244]
stable/6.18: [81ea8e8221853950c47dac7164f27c63a96f8f86]
stable/6.6: [4462ac3d90e897dda52ce4b6af2d526ddae835a8]
stable/7.1: [bc2d630296e0e049210ec05ff08459a6893ae749]

CVE-2026-68148: fscrypt: Add missing superblock check in
find_or_insert_direct_key()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68148

Introduced by commit 22e9947 ("fscrypt: stop holding extra
request_queue references") in v6.1-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b5fa40226e71c17847b9ff2816c6ca4133d0d994]
stable/6.12: [deff41898a5ae3a47db5fa1896a494aa95efda5d]
stable/6.18: [95376fe9c145be35566991df99c53134943d992f]
stable/6.6: [330249609b70778094a7a36f5b6bcfa6362121d4]
stable/7.1: [466f187b501a5ac8e1ea2ccf3ccd5c46108d8830]

CVE-2026-68149: fs: preserve ACL_DONT_CACHE state in forget_cached_acl()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68149

Introduced by commit facd610 ("fuse: fixes after adapting to new posix
acl api") in v6.2-rc6.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b9a5458d02e214ef2b384124ca626e3e381d778]
stable/6.12: [834ddf899484a2f23129080e8773bc04f4691d07]
stable/6.18: [a019b074903b3ad0a9726087efd0e8291452023b]
stable/6.6: [b98fad81f1202b0eb26aacf3ff4cc7a21ed3b5bf]
stable/7.1: [ca03a7984a34f48085fd013e0d2cf4e6420b4acf]

CVE-2026-68150: fs/super: fix emergency thaw double-unlock of s_umount

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68150

Introduced by commit 2992476 ("super: use a common iterator (Part 1)")
in v6.16-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [503d67fbaec6fdeaba391cb497675071db9d16ea]
stable/6.18: [c78e38745ff1b0457c4551e7f75ea15842df1169]
stable/7.1: [64017df6e61a3ce7159cee284109b92009985361]

CVE-2026-68151: binfmt_elf_fdpic: only honour the first PT_INTERP

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68151

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3349ef6a366a61d631f6a263d12cea240957719d]
stable/6.12: [21eaf5594a33d16343a011c752624099c30e918f]
stable/6.18: [89b9121c3b0162655fc2f190b714ae64f1aa8cae]
stable/6.6: [e4563e07ef5c938d5332c5c44721db976f214bc6]
stable/7.1: [69ecc199880bf7e8d06224c82dc411d18f9285f8]

CVE-2026-68152: amt: fix use-after-free in AMT delayed works

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68152

Introduced by commit cbc21dc ("amt: add data plane of amt interface")
in v5.16-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea20c44935d6142daecfa9b39d635033a7553e1b]
stable/6.12: [a46bfa01e01df0f6f6dc4b0be18db002d6d2dbd2]
stable/6.18: [1a644db2cf59f164cdf3c75995bab5aadc097528]
stable/7.1: [006340cf06881b6ff49767d8b6f3c4f7b892670c]

CVE-2026-68153: libceph: remove debugfs files before client teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68153

Introduced by commit 76aa844 ("ceph: debugfs") in v2.6.34-rc2.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e4c804726c4afce3ba648b982d564f6af2cfa328]
stable/6.12: [d3dc8889d39a676bf840132bd5c5c48cb0daba23]
stable/6.18: [8f5a3abc54ba24dbceb14cc3a719908c4f688091]
stable/6.6: [fc1010e7e0204ece6cc0f9af4f473e9553535eab]
stable/7.1: [b9fedda2f628e030384228de0dafc574b7fb0c2f]

CVE-2026-68154: libceph: reject zero bucket types in crush_decode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68154

Introduced by commit f24e998 ("ceph: OSD client") in v2.6.34-rc2.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [05f90284223381005d6bcddab3fda4a97f9c3401]
stable/6.12: [826cd1de5802fd392922785f9b64d76e65d2a100]
stable/6.18: [3b2f1937f5fce8b7dd5432e7693e3cc8b5eece56]
stable/6.6: [b8a9fb6bf806f9c4891e71ae1beab0c07c23a877]
stable/7.1: [70998f91030ee083ecb336a1dff0701c20a38081]

CVE-2026-68155: libceph: Reject monmaps advertising zero monitors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68155

Introduced commit is not determined.Fixed in v7.2-rc5.


Fixed status
mainline: [40480eee361ed9676b3f844d532ac28b47251634]
stable/6.12: [cd0d41bc569632eaaeccde9d2a6bc919ec00c407]
stable/6.18: [e67e8b694872c9bc66996040f9de9242f6236ed9]
stable/6.6: [0591a15815b498be628a937146e44487d599ba33]
stable/7.1: [3b249546f59c3d6d3592c10657f82bc3f1faa07c]

CVE-2026-68156: libceph: refresh auth->authorizer_buf{,_len} after
authorizer update

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68156

Introduced by commit 0bed9b5 ("libceph: add update_authorizer auth
method") in v3.10-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [937d61f86d377a3aa578adae7a3dfcecdddf9d89]
stable/6.12: [75e82e8944ac1efe9fdb88bd2f14d9a031282bdf]
stable/6.18: [0060ec912292a550198d8d18ac95b433c92a7091]
stable/6.6: [9d37aec9ffe4e743dabc3f84502e9723e17a30d4]
stable/7.1: [5ecfcd5c05866f185357700b81b461dae4f5ebb2]

CVE-2026-68157: libceph: guard missing CRUSH type name lookup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68157

Introduced by commit 117d96a ("libceph: support for balanced and
localized reads") in v5.8-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bbeae12fda3384a90fbebc8a19ba9d33f85b5361]
stable/6.12: [3767c9f0c1bbd98dd25cb088356a0fc6c1f09f50]
stable/6.18: [4716a64b7cc2797741f7be4e283ace78a9dff37d]
stable/6.6: [c46d82c47afc968d6ee8ef4470fa2dd35b765c21]
stable/7.1: [db9cc9fd9660b2d69ee66f5a4cbec83c21a1c64d]

CVE-2026-68158: libceph: Fix multiplication overflow in
decode_new_up_state_weight()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68158

Introduced by commit 930c532 ("libceph: apply new_state before
new_up_client on incrementals") in v4.7.
Fixed in v7.2-rc5.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [98917a499ec7064c14fc56d180a4fd636fc2784c]
stable/6.12: [143ba49ead77ec483c0326f8aaad8649874e99c4]
stable/6.18: [1732d89dfcd74f6fde9ce70900d316c4a151c153]
stable/6.6: [05c90e059269f087becfcce23348496085835c29]
stable/7.1: [bee4b5b53e7bff0467fd916cc44c9b190733c6bd]

CVE-2026-68159: libceph: bound pg_{temp,upmap,upmap_items} length to
CEPH_PG_MAX_SIZE

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68159

Introduced by commit a303bb0 ("libceph: introduce and switch to
decode_pg_mapping()") in v4.13-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f00f9cf2be293efe899db67dc5272e3a9c62717]
stable/7.1: [e36663145abd7024f0281dfb22fdef65f185845b]

CVE-2026-68160: ceph: fix pre-auth out-of-bounds read on snaptrace in
ceph_handle_caps()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68160

Introduced by commit a8599bd ("ceph: capability management") in v2.6.34-rc2.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4dbc71bcaf9a30abf3920a4e2cc4ed33bba78c02]
stable/6.12: [03b417afce19ee6b6e61f1bbbbebac924c9f36d1]
stable/6.18: [a4228b93706fb74a484e6ffb271c1cc2af3a2ddb]
stable/6.6: [9081c71796724ffe96cba253f68fbe42363c5295]
stable/7.1: [71893c342a26bcff92eaab0b2b75d64aed19308a]

CVE-2026-68161: sctp: close UDP tunnel sockets during netns teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68161

Introduced by commit 046c052 ("sctp: enable udp tunneling socks") in v5.11-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ffb2bd7ade36ec4da32c46a6eddbf4515316d08c]
stable/6.12: [8ff78591d309c50a4fdab683b68dd8d512a270dd]
stable/6.18: [3bf0e349cbb4f975f35eb22753acc346b89c66a0]
stable/6.6: [c6eb2d615210b80339548ab07c0230edaab9a6c7]
stable/7.1: [37ff9794be48d0caa37687e04d09675f9c849121]

CVE-2026-68162: sctp: avoid auth_enable sysctl UAF during netns teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68162

Introduced by commit 15649fd ("sctp: sysctl: auth_enable: avoid using
current->nsproxy") in v6.13-rc7.
Fixed in v7.2-rc5.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [f8d5e7846025f4ab15a461235f8ebae9094a361a]
stable/6.12: [626bda8cfe43dff19a9833ff6ba055a817b5455c]
stable/6.18: [be6aae9d1b91c603adb35872d37d40e83daf8758]
stable/6.6: [66700c0719675e0e118ae83b2d7168dacd69dd3d]
stable/7.1: [a50e73488e0bbdd262b3be3c9a1d8dd078382381]

CVE-2026-68163: mm/page_vma_mapped: fix device-private PMD handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68163

Introduced by commit 65edfda ("mm/rmap: extend rmap and migration
support device-private entries") in v6.19-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f84ca9b1888d8fce7dfefe0e750fa971f8797486]
stable/7.1: [ab6209f4b48a98ef14d6766acdb62aa9bb32e670]

CVE-2026-68164: mm/damon/core: disallow overlapping input ranges for
damon_set_regions()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68164

Introduced by commit 97d482f ("mm/damon/sysfs: reuse
damon_set_regions() for regions setting") in v5.19-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [954157679ec34661c2e87e7eb796104a797c32db]
stable/6.12: [06a4beeeec8f03f0b3e9c78a98f1ae4f0f18cfbd]
stable/6.18: [6ce0db97fb37ab8cf8596edca0e3de8618ab009a]
stable/6.6: [4b4a3e7ef7bb622237495db9ba4dfd7417d6530e]
stable/7.1: [e33adf96afb5883f84b0d98747976bde293e33cb]

CVE-2026-68165: mm/damon/core: validate ranges in damon_set_regions()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68165

Introduced by commit 43b0536 ("mm/damon: introduce DAMON-based
Reclamation (DAMON_RECLAIM)") in v5.16-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1292c0ecb1caefb8ca064a3639d5673991e8810c]
stable/6.12: [c927b73a5694c735314ea10e7c81c07f9bd51ad7]
stable/6.18: [4b6f1d6d5d07855bd1bb9e64922b049062138bfa]
stable/6.6: [b585facbafbb5cf117b37b1c75819ac046646c27]
stable/7.1: [43aaddd0fa92010a68adeda7744c7cf497a1c8e9]

CVE-2026-68166: userfaultfd: prevent registration of special VMAs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68166

Introduced by commit 54007f8 ("mm: Introduce VM_SHADOW_STACK for
shadow stack memory") in v6.6-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c58f641e813c3c71039f8fd4d4e2a3aab713288]
stable/6.18: [165613191ad9d034bf17c00e3a142f9561597ec5]
stable/7.1: [0c26202b157f1efc3cd2f26f5c30f59b508a6a5d]

CVE-2026-68167: btrfs: do not try compression for data reloc inodes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68167

Introduced by commit 3eaf5f0 ("btrfs: extract inlined creation into a
dedicated delalloc helper") in v7.1-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae4316f332e03e628712e9dfb89f2b7d3c70c21a]
stable/7.1: [31a62e4ad66313cf1ebaa00c2a17d644a4b87d22]

CVE-2026-68168: afs: Fix afs_edit_dir_remove() to get, not find, block 0

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68168

Introduced by commit a5b5bee ("afs: Use the contained hashtable to
search a directory") in v6.14-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [62d9853aa4ce6e9797b6949804891be14b219752]
stable/6.18: [f2b293359924117736218701ebd8b40618d73e6f]
stable/7.1: [bfdfc7782ada6f3a4df7182889b66039f8e4131c]

CVE-2026-68169: mptcp: pm: userspace: fix use-after-free in get_local_id

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68169

Introduced by commit f012d79 ("mptcp: check addrs list in
userspace_pm_get_local_id") in v6.8-rc5.
Fixed in v7.2-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [9bc6d5e4ca9f3cbb41d43400b3a31cb0403796c9]
stable/6.12: [31ce5af66891f79998fb2e8b8df08e3c98fd72e3]
stable/6.18: [d64f6c02495f3fad674038cfa7ec049671b59e7b]
stable/6.6: [d2c3760b45f2f481a4dd4c5adef4a29dfabd948f]
stable/7.1: [40dde4b5d98279471a70e5c8bb713182738c00d9]

CVE-2026-68170: mptcp: fix stale skb->sk reference on subflow close

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68170

Introduced by commit ee458a3 ("mptcp: introduce mptcp-level backlog")
in v6.19-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bd7aae448f6ee9d82599a4474664de1e6e91a535]
stable/7.1: [625fc6060864889fe3d370cdeffbbab762af3cb4]

CVE-2026-68171: [REJECTED]: arm64: syscall: Ensure saved x0 is kept
in-sync with tracer updates

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68171

This CVE was rejected. Introduced by commit a5cd110 ("arm64/ptrace:
run seccomp after ptrace") in v4.8-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e057b94772328221405b067c3a85fe479b915dc8]
stable/6.12: [b7afd2a80593dde3f4a68c9a9f73752f9c340e85]
stable/6.18: [64ab0964c7db949abbd3c56268a220e2b77f7b9e]
stable/6.6: [8000a5f4d1d192f5bb3e4f29e7606a9460d376df]
stable/7.1: [e59c2476ef755221da31f4e26f6b89712ecf50f1]

CVE-2026-68172: arm64: make huge_ptep_get handled unaligned addresses

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68172

Introduced by commit 29cb805 ("arm64: hugetlb: Cleanup huge_pte size
discovery mechanisms") in v6.16-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f73a8edc2ccc6ec72c37d5c578e7592d2e1f9922]
stable/6.18: [9cd4b1a52eff330798d668c1775f8bc450776280]
stable/7.1: [f3530aec26563f4d483ff31402392961362e9bc6]

CVE-2026-68173: ublk: wait on ublk_dev_ready() instead of ub->completion

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68173

Introduced by commit 728cbac ("ublk: move device reset into
ublk_ch_release()") in v6.15-rc3.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [432a9b2780c0a01caf547bd1fc2fcf28aeb8d173]
stable/6.18: [7dd26adf7e7d482af524e3a0cca4a81ef7c159d0]
stable/7.1: [8f188dd11a1c2ad94caeaee36ef68bb8221d4a12]

CVE-2026-68174: tracing: Fix union collision of module and refcnt for
dynamic events

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68174

Introduced by commit 4c86bc5 ("tracing: Add :mod: command to enabled
module events") in v6.14-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b4eb07bde606c2096b24252be589e735eff6d413]
stable/6.18: [b6a4575f22925da7e6aa00171e9fc0e5029c0bc9]
stable/7.1: [43a23dfe0024afd3d2b0232e987d0292919a9b24]

CVE-2026-68175: tracing: Fix resource leak on mmiotrace trace_pipe close

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68175

Introduced by commit c521efd ("tracing: Add pipe_close interface) in
v2.6.33-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c1d87e724ae55e781b7cc7ccafb34d9e668582b2]
stable/6.12: [594e1cf3f736779a535873fd5988162d827bfe4f]
stable/6.18: [cf5a82bef623b969a609f2b7e392d06dbae34aa6]
stable/6.6: [f9e6dfe341fb31c95b9655eb6b1db8b3ae090817]
stable/7.1: [cb459fec4f7b13caf646101ff076e94ef38434d8]

CVE-2026-68176: tracing: Fix mmiotrace possible NULL dereferencing of hiter->dev

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68176

Introduced by commit f984b51 ("ftrace: add mmiotrace plugin") in v2.6.27-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [144f29e85702234b23d2a62abf723e6a17eb5427]
stable/6.12: [201a01102c529772168181190cb084471082cf5c]
stable/6.18: [8464427e1c177809a9488a97dfa2807d9dcf323b]
stable/6.6: [faaf95135184208ee3ac6f33175c8d1800669dfc]
stable/7.1: [724cd84b0546c07806840fa658714488553d13a2]

CVE-2026-68177: tracing: Delay module ref count for "enable_event" trigger

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68177

Introduced by commit 61d445a ("tracing: Add bulk garbage collection of
freeing event_trigger_data") in v6.19-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e091351b38818ef620d27f44f4bfd625f13afbff]
stable/7.1: [159fdc3e01dca5fdbc412fcd8b239895733a270d]

CVE-2026-68178: misc: nsm: pin the module while the device is open

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68178

Introduced by commit b987375 ("misc: Add Nitro Secure Module driver")
in v6.8-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b231f1e9990f4c21220d0a69733ce2105891ff9]
stable/6.12: [1996639f824ce9468395cdb7bcb8f467fa787e77]
stable/6.18: [1da310b94504d42001e9c32c43c5dc105b777e5f]
stable/7.1: [9e9a82d00c3d10129fc310a7547b24a679d5d920]

CVE-2026-68179: misc: nsm: only unlock nsm_dev on post-lock error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68179

Introduced by commit b987375 ("misc: Add Nitro Secure Module driver")
in v6.8-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce1fed11d18e163baf7f875152a33bf80f625c1a]
stable/6.12: [4aa3f7d48e91eb74a363c1b4d7dbdd28f5b341fb]
stable/6.18: [8f068342096b027181b168d91fef7ac7a2c64b25]
stable/7.1: [f318f5a872cb9096536e759b23ae5c9873bb80ed]

CVE-2026-68180: intel_th: fix MSC output device reference leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68180

Introduced by commit 95fc36a ("intel_th: fix device leak on output
open()") in v6.19-rc7.
Fixed in v7.2-rc5.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [761b785a0cfbce43761227bc42a7f984f31f8921]
stable/6.12: [26e27b8dcef1e4df6f30d8f25b3304a506d482b3]
stable/6.18: [caba30eb8bd321c465ecfc7d850ee85f5b353496]
stable/6.6: [ddcf2064d7ec5a8c9afa7cb74442320e443502bc]
stable/7.1: [c3a28f9cb82425fe0835048ed3677f321e780691]

CVE-2026-68181: mei: bus: access mei_device under device_lock on cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68181

Introduced by commit 35e8a42 ("mei: bus: Check for still connected
devices in mei_cl_bus_dev_release()") in v6.17-rc1.
Fixed in v7.2-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [f112ea910e554d58b4b39a4492b7d302f0f4204f]
stable/6.12: [c88c030a324c9018b77894a19b2564eb66862020]
stable/6.18: [59dd34854202d9a3faaa87a85205e553fe7150e1]
stable/6.6: [441559d4c595f839b39f0ab6a4ae628427c2fd9e]
stable/7.1: [7cf79e8d682fe93777268f029668ce5e214237fd]

CVE-2026-68182: comedi: comedi_parport: deal with premature interrupt

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68182

Introduced by commit 241ab6a ("Staging: comedi: add comedi_parport
driver") in v2.6.29-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [17221216ae8ce6a24e8a4e787382e3ebc81b88a8]
stable/6.12: [086a9ae3c5df63ec11033a8c0b3f6a1fd295ddd1]
stable/6.18: [cf26dd2d841583c54a87005c4934b92fddb930c3]
stable/6.6: [b061bb4dca49fd93063359d3805387235818778c]
stable/7.1: [5d059ce0e6a2f6f8b97273499d47b8f917097b48]

CVE-2026-68183: firmware: stratix10-svc: fix memory leaks and list
corruption bugs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68183

Introduced by commit 7ca5ce8 ("firmware: add Intel Stratix10 service
layer driver") in v5.0-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9119ceb76e987c2ec2b549ea100e3268ce3a1c7c]
stable/6.12: [fff6e5ff0318315998b540896537eaaa2ebf9f7b]
stable/6.18: [4f2db41a09eba7a45abd140bb86ffc519c191886]
stable/6.6: [95f702e372964aff486338783f49e28a40a53127]
stable/7.1: [8e93a083456d78f6b0aa1f58d2b0c7071a2a7a47]

CVE-2026-68184: cdrom: fix stack out-of-bounds read in CDROMVOLCTRL

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68184

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b27e195d4db8dea263050bdbeb11881b2999c9c6]
stable/6.12: [35b68e24c5a69fa4545f46f05f6c849223034cb6]
stable/6.18: [d43c5c0c935522deae7339e0c2399365f3bf0016]
stable/6.6: [7344c84e32413e5c8832f74b8a612b0194e5c051]
stable/7.1: [f3e2715a150066f09aa82c30fa983fb184ad6dd5]

CVE-2026-68185: LoongArch: Move jump_label_init() before parse_early_param()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68185

Introduced commit is not determined.Fixed in v7.2-rc5.


Fixed status
mainline: [ea68d444a658783234a06f05414e41cf93a18fb2]
stable/6.12: [4b40e590efb350c54480d7e883f054d3609a94c6]
stable/6.18: [38b025fcdc45bdf5140a5726a1fbb2e694ea047b]
stable/7.1: [881e9f3c4e117b100880b1c5de3a0da8e455a78f]

CVE-2026-68186: binfmt_misc: set have_execfd only once the interpreter is opened

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68186

Introduced by commit bc2bf33 ("exec: Remove recursion from
search_binary_handler") in v5.8-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bbf5f639918dc011aaf60aab8480218758ee68c5]
stable/6.12: [2dd0298905e97795a9c5ec30cf5b41975f821632]
stable/6.18: [1cd4e9b7967dab48c9f79a00b06ffff7208c0993]
stable/6.6: [0f19d54e2524f0bf183b82f365ae4e49b4a2f788]
stable/7.1: [5ccc99d58f94fad258c9c375715b3974e48620e8]

CVE-2026-68187: exec: fix unsigned loop counter wrap in transfer_args_to_stack()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68187

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [16cc4f5c1c4b9e45eca7f7deefa5410a292db599]
stable/6.12: [dfc2a00742af4cb7251c1a8fbce4fbae3cc0de4e]
stable/6.18: [2bc6bf70d41055377f390d06f0f3521deb62fd3b]
stable/6.6: [c62bb00caba66e01fb578d5f0302f247dc64930a]
stable/7.1: [55fa2c7f2b15583d1a2fe1b5abcc24377359339f]

CVE-2026-68188: Bluetooth: RFCOMM: Fix session UAF in set_termios

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68188

Introduced by commit 3a5e903 ("[Bluetooth]: Implement RFCOMM remote
port negotiation") in v2.6.20.16.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c783399efc22d035443f1dfbf2a09bf9562aaa5e]
stable/6.12: [a82a9d3891f5607030b0672c255087a12bb9837b]
stable/6.18: [780b04d09c941262ee2a2b4a09906451b69df8a6]
stable/6.6: [2894bd8c68e97accd758ca6e5fc375d7e9e8882c]
stable/7.1: [98bc68194e37bfa5e8ddc80b5c1eb0be4dc607ea]

CVE-2026-68189: Bluetooth: hci_sync: Protect UUID list traversal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68189

Introduced by commit 161510c ("Bluetooth: hci_sync: Make use of
hci_cmd_sync_queue set 1") in v5.17-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e9027ffbf5a0f3c12ca8900822e884eae9f0821b]
stable/6.12: [a351f68fb24828b23a971e00b8238ee0e8a40380]
stable/6.18: [a42f5536ea9c00e13f0c0fbb330feed95e2365ca]
stable/6.6: [e4fa2c5c261d736b8e58759fdef3a968d510630c]
stable/7.1: [fe13adc258df88d95789e5673c7ba5178b5f8b28]

CVE-2026-68190: staging: rtl8723bs: fix OOB reads in rtw_get_wps_ie()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68190

Introduced by commit 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in v4.12-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0e95ff792ae0aa6fbad9455943e9e1e4062670e9]
stable/6.12: [630fdca3f2437fee3ffd437c4b646ccf84c7be87]
stable/6.18: [875479f18835ac11e21a83e88f3d4dc7ccdcd0c4]
stable/6.6: [b9d9a4cd2e59df7281992a076464d2536e80c674]
stable/7.1: [23c31f107b4f8f420a754a45d12599bdb78f9bb8]

CVE-2026-68191: wifi: ath12k: fix NULL pointer dereference in rhash
table destroy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68191

Introduced by commit 57ccca4 ("wifi: ath12k: Add hash table for
ath12k_link_sta in ath12k_base") in v7.0-rc1.
Introduced by commit a88cf5f ("wifi: ath12k: Add hash table for
ath12k_dp_link_peer") in v7.0-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [70231dcd782201579990ded73e0435d18bb524ca]
stable/7.1: [17a4298f7794843af0094035723dc5e7311c7453]

CVE-2026-68192: wifi: brcmfmac: make release_scratchbuffers idempotent

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68192

Introduced by commit 4684997 ("brcmfmac: reset PCIe bus on a firmware
crash") in v5.2-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [538c51e9d124cf656f2dd0c0394a8545efc7102d]
stable/6.12: [5a045c2f0fbf029873d2295178fa0785ade35af0]
stable/6.18: [044fca8f45ba9ab6ca526163155234cf88287ff5]
stable/6.6: [b7d1d8cb1bdca56aecebacd2896615da0acc126a]
stable/7.1: [0ca80328df23f851c86866720d4977783c919ee6]

CVE-2026-68193: wifi: mt76: mt7925: drop TXRX_NOTIFY on non-mmio buses

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68193

Introduced by commit c948b5d ("wifi: mt76: mt7925: add Mediatek Wi-Fi7
driver for mt7925 chips") in v6.7-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [feeff151c83e7f0ffcdedcad5343852d23d1f6e1]
stable/6.12: [0c8c4cd0ca60b45c4b05a39e3769b8473d6836eb]
stable/6.18: [9cb72f67e1502aabba51aab9ac04ae7c386ee194]
stable/7.1: [9677e86a5f7d680fe280a5f8999bc57353e360d7]

CVE-2026-68194: wifi: mt76: mt7921: drop TXRX_NOTIFY on non-mmio buses

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68194

Introduced by commit 48fab5b ("mt76: mt7921: introduce mt7921s
support") in v5.16-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da4082e91acabc1498611ed8ccc53f0610baefc6]
stable/6.12: [ecf995b828191829ba4a87169bccabcbeb5c9c32]
stable/6.18: [263816e92e8d66c81c98ccab2b5d2191ed08ec71]
stable/6.6: [ef2ee5f820c3ef87643b51e960c20b4a14d8336b]
stable/7.1: [24475d2ddc8d8dfd82f4d2be0d951401f86911a6]

CVE-2026-68195: wifi: mt76: mt7615: drop TXRX_NOTIFY on non-mmio buses

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68195

Introduced by commit eb99cc9 ("mt76: mt7615: introduce mt7663u
support") in v5.8-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [39afc46c0243d10b7795e6e6cf4ae91f41732120]
stable/6.12: [88c98ef247a3126fea9bbbda953a18a2f36c3ea7]
stable/6.18: [ab4d213393e846baa6437497f94dda7553cbeda7]
stable/6.6: [f2a72f47c5fb4ba6887e85bbe809d7e5b318d9d5]
stable/7.1: [b2ab73b8123ce6cf2bc32634bfee4928676ffa66]

CVE-2026-68196: wifi: wilc1000: validate assoc response length before
subtracting header

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68196

Introduced by commit c5c77ba ("staging: wilc1000: Add SDIO/SPI 802.11
driver") in v4.2-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c4c97b60a5e978121d9ee8cb0ab3916e5d6a8de]
stable/6.12: [4d410320e8ae5933e651660c9fadc1d380309e23]
stable/6.18: [e511e93abd6eeedcd5b3c55516241f414fbde64a]
stable/6.6: [584c8954ad55f8b09b475be6db710fe40ceb988c]
stable/7.1: [8ccdf8c8de87a9580df37c3c1ec53ba88cedef65]

CVE-2026-68197: wifi: mwifiex: fix NULL dereference when the AP has
HT-cap but no HT-oper

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68197

Introduced by commit 396939f ("mwifiex: add HT operation IE in TDLS
setup confirm") in v3.16-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c3d68e294cbb6a4090bb219d3dcaca85a011809b]
stable/6.12: [45011e4d9ba3f2182e5df64be65888044fa20771]
stable/6.18: [9375a4ea4121625ef27a46b74781cda66a5cc61b]
stable/6.6: [eb42c3c8fd479166c42984728754cd779c71fd60]
stable/7.1: [cca4398aa305c22016d1714f388e2fa6ea4e5ad4]

CVE-2026-68198: wifi: ath6kl: fix use-after-free in aggr_reset_state()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68198

Introduced by commit bdcd817 ("Add ath6kl cleaned up driver") in v3.2-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba7debb4dd6427386862220e8335a53a4bfc235d]
stable/6.12: [b5d618fd61b9069b4c0a6b487022dd3117ad5acc]
stable/6.18: [18965470d41e69d3fc10eb62afae29d10f4cdfd1]
stable/6.6: [64af6534a085f49d6ed33338a19ab9cf0d0523c9]
stable/7.1: [a3313111b5d9046af60b370c93eec105b27380c1]

CVE-2026-68199: wifi: ath6kl: fix OOB access from firmware ADDBA window size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68199

Introduced by commit bdcd817 ("Add ath6kl cleaned up driver") in v3.2-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [44126b6994eeb28f2103b638e698f40a1244f327]
stable/6.12: [5a65fd4722416061698b0a3277222381efbc4882]
stable/6.18: [58c6c8dc2e022e1b4f3dc58725a1ca49ff470f9c]
stable/6.6: [d4558c140782180e2c80a7588a4af9f8675adfc4]
stable/7.1: [cec0a487cf38ac1f9bca240ffe8a94c5014b72f2]

CVE-2026-68200: ALSA: timer: don't re-enter an instance callback that
is still running

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68200

Introduced by commit 3774591 ("ALSA: timer: Introduce virtual
userspace-driven timers") in v6.12-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [70d28bfcd6224eed75986b3b987b997e59643fa4]
stable/6.12: [996c24377eea4d4506b7c3ccbbf1e490440b5e0b]
stable/6.18: [1395327a96614885552bae5fbb650e6dd182d49b]
stable/7.1: [c1078130a4cd7e738f4b73afe99b3e68cbfbf884]

CVE-2026-68201: ALSA: timer: drain a slave's callback before its
master detaches it

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68201

Introduced by commit 3774591 ("ALSA: timer: Introduce virtual
userspace-driven timers") in v6.12-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bdefe1346a8e6b8dc8593406dc2617e985fcbcab]
stable/6.12: [cd461bcfcdf8d6b6b5365941c1d3859f8bc77aa0]
stable/6.18: [426c0ff1c433d6030610ad4f9375746dfe931caa]
stable/7.1: [2b298997786876b225cff2446e11a0fa6f602f6d]

CVE-2026-68202: ALSA: seq: close a re-opened queue timer in the destructor

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68202

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c4dc0ed50b05cd847a4b34b8cebf0775f19aeb9]
stable/6.12: [24f0cabf173539f048946c8fc221131dc221f277]
stable/6.18: [6a10025c7fd09a7d2af37a3ae1da188569fce470]
stable/6.6: [fb40d03ed792a8a8bf77aa0ee15df57b0ff78b07]
stable/7.1: [31a6163e301d832060f8236f1ed17cbc1ca198df]

CVE-2026-68203: media: vivid: fix cleanup bugs in vivid_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68203

Introduced by commit f46d740 ("[media] vivid: turn this into a
platform_device") in v4.1-rc1.
Introduced by commit d7c969f ("media: vivid: Add 'Is Connected To'
menu controls") in v6.11-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a07c179a92e949172ca52f6d4a13202ea88cd4b7]
stable/6.12: [4385092a86b94e1f332db35a3766108978c0722f]
stable/6.18: [1349af7f87df57940619f5b87990b799dac9ed8a]
stable/7.1: [6d51ad8f1c50c50d1abcc97fd243179967184c6a]

CVE-2026-68204: media: vivid: check for vb2_is_busy() when toggling caps

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68204

Introduced by commit 73c3f48 ("[media] vivid: add the control handling
code") in v3.18-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c2d1a2130c93f6d758af58590b86b2254c7a1dec]
stable/6.12: [abaec6747304581f8d4a9936352fa10e13325f07]
stable/6.18: [492c97cb50feaa60ccd7792d3d6b904ed8ec61bf]
stable/6.6: [a9cd0e8fb0b21faaa71199d9d3feb305c18ff576]
stable/7.1: [daf2d92669b4a659d805d88d811161c70cd325ee]

CVE-2026-68205: media: v4l2-fwnode: Fix subdev owner overwritten in
v4l2_async_register_subdev_sensor()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68205

Introduced by commit aef69d5 ("media: v4l: fwnode: Add a convenience
function for registering sensors") in v4.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [06cb687a5132fcffe624c0070576ab852ac6b568]
stable/6.12: [caea6bc68c925d63ca33d21b2255f47181943d61]
stable/6.18: [cf9732fd6c4f2f803ccfc46d89489b6635590270]
stable/6.6: [47ef04cd13d38010b580056a9d8840aaab944841]
stable/7.1: [067887ff93fddbb3a3fb84c900bc654ecfe5ba61]

CVE-2026-68206: media: v4l2-ctrls: validate HEVC active reference counts

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68206

Introduced by commit d395a78 ("media: hevc: Add decode params
control") in v5.14-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [afbe4bc252d90a6f8fad869b06d5430f615f22f9]
stable/6.12: [dbaf0e0023e2f9332c5164822def7f80b7d2c5ef]
stable/6.18: [3068ab802fc98b121dcb451e1f7f4d338ffc7a19]
stable/6.6: [9a998cc1c348769262d433acb7d238c5fac4b2e0]
stable/7.1: [b01df98a6669d2b67d8aed816021b327fd905998]

CVE-2026-68207: media: ti: vpe: unwind v4l2 device registration on probe error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68207

Introduced by commit 4d59c7d ("media: ti-vpe: vpe: Add missing null
pointer checks") in v5.5-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0f1c9a90ef665f2587c274a8fed59f2dfc575a6]
stable/6.12: [7d383357905de975e1dbde639e5fa7477075d104]
stable/6.18: [7e6521dd747eca3cb3d4cd3ddcf20f266494f63d]
stable/6.6: [4ecf0cc0cf59032a89bcdf36fbbb03bff5455fd9]
stable/7.1: [fcbbaf9cb9722a82f0221c56114037fc537f4ada]

CVE-2026-68208: media: ti: vpe: Fix the error code of devm_kzalloc()
in vip_probe_slice()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68208

Introduced by commit fc2873a ("media: ti: vpe: Add the VIP driver") in v7.0-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e8f319eae96a3d718e810d52432020a2b77f5f60]
stable/7.1: [956879b173c2cf782fbc3d18947fd1da286359cf]

CVE-2026-68209: media: sun4i-csi: Return queued buffers on
start_streaming() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68209

Introduced by commit 577bbf2 ("media: sunxi: Add A10 CSI driver") in v5.4-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bbba3e260a62810a717b4442a3bb96d0ec0f6309]
stable/6.12: [a8abecc638a7feb20b78fabd563b05e30c071331]
stable/6.18: [b5184b3f0e9d4cc47059ba1138c9a73d43d2493f]
stable/6.6: [4872161e6fbe4e1783daea8bff79caddfae0fb82]
stable/7.1: [668face37fdb6b6900645dc8777195498541c9a7]

CVE-2026-68210: media: stm32: dcmi: unregister notifier on probe failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68210

Introduced by commit d079f94 ("media: platform: Switch to
v4l2_async_notifier_add_subdev") in v4.20-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [084973ebd67b28f0945c5d45408f86c58b540110]
stable/6.12: [6c6f22b7e6cbc4e8c1e359fc9b190419391c3db7]
stable/6.18: [931abe1deb65b919d23fa203d7f6d6fbd4fccd8e]
stable/6.6: [37ff63c5d7119cbc5c6bacdcc658add6008a8e1f]
stable/7.1: [4b7ee504969e074725e439c949f2483e5fa5572a]

CVE-2026-68211: media: stm32-dcmipp: Return queued buffers on
start_streaming() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68211

Introduced by commit 28e0f37 ("media: stm32-dcmipp: STM32 DCMIPP
camera interface driver") in v6.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ffc8eec06378a340d708c889184ab3e14b57d540]
stable/6.18: [ed342a86bb2f9c1b44a0fc4f6b08c14073946e4f]
stable/7.1: [624af2d4b5e9d3dd366538e4fb4a2a037792a7e3]

CVE-2026-68212: media: saa7134: Fix a possible memory leak in
saa7134_video_init1

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68212

Introduced by commit a00e688 ("[media] saa7134: move saa7134_pgtable
to saa7134_dmaqueue") in v3.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f86ed548386e3050e5f8f25b450d09dc009d9a88]
stable/6.12: [e1ef361ee31d1dba5dcae2cdd50f9c1352df0c23]
stable/6.18: [b7936e8cbec1b96b126058eeb005e5b9111df38e]
stable/6.6: [134c979dd721e22f196d71026432ee37d1f5cc38]
stable/7.1: [1731dd61b6c0b7435c139951d2b7eada6c9667a8]

CVE-2026-68213: media: rtl2832_sdr: Return queued buffers on
start_streaming() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68213

Introduced by commit 7711389 ("[media] rtl2832_sdr: Realtek RTL2832
SDR driver module") in v3.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [33ca0aab6f4bd90921fc1395478f38f72c4d19af]
stable/6.12: [0b08c0403cf672a121ace4eff647a9b240bd4e1b]
stable/6.18: [894e83509c66910112b9eaeaa8cd66cd9806db91]
stable/6.6: [465dc8e71d2db2ed603e749fa71392bcdccf07eb]
stable/7.1: [fc0b18782aab4e35078efe72863df8eab46560a8]

CVE-2026-68214: media: rtl2832: fix use-after-free in rtl2832_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68214

Introduced by commit cddcc40 ("[media] rtl2832: convert to use an
explicit i2c mux core") in v4.7-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [680daf40a82d483949f87f0d8f98639dc47e610c]
stable/6.12: [24bef237eef8dd1ebcffb129ba21891ddad0d309]
stable/6.18: [2c71bda6edc630a1f8c3c45d8df5fc22d234e042]
stable/6.6: [9acd5bbbe1df8e487e49488692c224496d4c9e16]
stable/7.1: [90d781711418881f8c836c2a859cc2886625d750]

CVE-2026-68215: media: radio-si476x: Unregister v4l2_device on probe failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68215

Introduced by commit b879a9c ("[media] v4l2: Add a V4L2 driver for
SI476X MFD") in v3.10-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [436a693af04ffb889aaf87cb69ec1f2b21d3569c]
stable/6.12: [7ef9f1659404544a8dddd68842bafcb4a38197af]
stable/6.18: [64cb15878b35e5574ff4f80a0b613a79e47867ba]
stable/6.6: [4ca9c9f12b1bc341a0a3bbbd2090fd182db53771]
stable/7.1: [730c235d7d2c80a401dac56b0f5066c889aa442d]

CVE-2026-68216: media: pwc: Return queued buffers on start_streaming() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68216

Introduced by commit ceede9f ("[media] pwc: Fix locking") in v3.5-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [975b2ee20e569d47821e4f6c9761b4664d48a6a4]
stable/6.12: [5d7cc2634c3843a1414a0f6407aa17f1f91dee60]
stable/6.18: [cb16b79a2be2cec9c3ebe4147490817c4d8b1de3]
stable/6.6: [f2f9fcacd81953dde6cb86312ab13ca13e689664]
stable/7.1: [a4f8f629983f643333e49df90557805469bcbb25]

CVE-2026-68217: media: pwc: Drain fill_buf on start_streaming() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68217

Introduced by commit 885fe18 ("[media] pwc: Replace private buffer
management code with videobuf2") in v3.1-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [906e410dcffbbd99fb4081abab817a830033aa28]
stable/6.12: [acc789b2173070638cad89c2b61d33ed338be0dd]
stable/6.18: [9afd605dcd96c7a45f338eded1de16679b30e1df]
stable/6.6: [a56e7641e09bd80b976e944ae759109b86fd5b38]
stable/7.1: [5d4812668b03f823b5044789d6aa77fe56b42587]

CVE-2026-68218: media: pci: dm1105: Free allocated workqueue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68218

Introduced by commit 519a4bd ("V4L/DVB (11984): Add support for yet
another SDMC DM1105 based DVB-S card.") in v2.6.31-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1a65db225b25bb8c8febf16974c060e0cc242eb9]
stable/6.12: [8d753c8c37afc0910ed5ddc014645b05d6266add]
stable/6.18: [08ddfd628a2dbd9d385da677afccd893d0ab37e1]
stable/6.6: [46715fecc38a2d341c3ff680f295de6e8aec72c0]
stable/7.1: [0c2b4c45fce012e88904b8c66b5cd786535c0b8c]

CVE-2026-68219: media: nxp: imx8-isi: Fix potential out-of-bounds issues

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68219

Introduced by commit cf21f32 ("media: nxp: Add i.MX8 ISI driver") in v6.4-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [57a7ec5c9f38ce6c4d6209c4b75c8e57e1fea6cf]
stable/6.12: [ba7e1b06cbdad3b7c3314390cca22aff42f655d4]
stable/6.18: [28ae75dba701d7aa69a36802c398582933d3e0e6]
stable/6.6: [690cdda752f3dc6b7a8b2d4a243e0207b66a1f37]
stable/7.1: [75cdfaa7c908ca06d564170da9c80fb579f149a5]

CVE-2026-68220: media: nxp: imx8-isi: Add missing
v4l2_subdev_cleanup() in crossbar and pipe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68220

Introduced by commit cf21f32 ("media: nxp: Add i.MX8 ISI driver") in v6.4-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [567418eedd25b3d86d489807682030b4b98b73d9]
stable/6.12: [f04ec98605420e7c2c1ad6d2f6fb26692d4f218a]
stable/6.18: [9e61258fbc3cfc053e4c2ed72254c2de76772354]
stable/6.6: [549dd1afce2cf79a826d1f9742effb4565d52871]
stable/7.1: [9c5ddbabc31fda93a508d9b8f0c776a4a08e49f5]

CVE-2026-68221: media: nuvoton: npcm-video: fix memory leaks in probe and remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68221

Introduced by commit 46c15a4 ("media: nuvoton: Add driver for NPCM
video capture and encoding engine") in v6.7-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [50cc0e547da50b887e63dfa1ad203cd5b735d01e]
stable/6.12: [b092d690a9b28795ab2db083023e8a5368cddb22]
stable/6.18: [181a0aeefd56f9285325b84789aa348aba0508bf]
stable/7.1: [65ddc021d39d6383635ee8b0970b2d1c7947e447]

CVE-2026-68222: media: msi2500: Return queued buffers on
start_streaming() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68222

Introduced by commit 977e444 ("[media] Mirics MSi3101 SDR Dongle
driver") in v3.12-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7201c17786a498497bca57752883b90914d405ac]
stable/6.12: [bab9d5a67d4db96ae8c187b92b37979911302a10]
stable/6.18: [264b5380c4f8aa92dbc2983ecd2b627f1d5e0061]
stable/6.6: [1d58229b330b7f67fbfa07e0f2a8a51fbeafaa9a]
stable/7.1: [3673cb0a5711e910074d69201da9e1535c03f97a]

CVE-2026-68223: media: meson: vdec: Fix memory leak in error path of vdec_open

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68223

Introduced by commit 3e7f51b ("media: meson: add v4l2 m2m video
decoder driver") in v5.3-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [940f161f734b25f175a95d2684c2021f6323693a]
stable/6.12: [2cf0171ad594860e31723c671e37824ce12c01ea]
stable/6.18: [1391b75bf0119b5d37f1c1c3078d452a01967f9b]
stable/6.6: [c6cd08a71a630f19b10c318e76e3c56e1dd10e00]
stable/7.1: [99f3527bd1a27ff798d59177ed045b0dd87deaef]

CVE-2026-68224: media: mali-c55: Fix possible ERR_PTR in enable_streams

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68224

Introduced by commit d5f281f ("media: mali-c55: Add Mali-C55 ISP
driver") in v6.19-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [94c6402e423d36a2bd6f62055a65a0d439d84da7]
stable/7.1: [65d4424275845e9f9012b40b5cbff4572771d768]

CVE-2026-68225: media: i2c: alvium: fix critical pointer access in
alvium_ctrl_init

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68225

Introduced by commit 0a7af87 ("media: i2c: Add support for alvium
camera") in v6.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f6f28ff24709710c08557c127b3e4c3fb1b4159]
stable/6.12: [4bacfda44d36f165f6cb57bea408912886400ffa]
stable/6.18: [7337c88205ed0ffc654f40266be0d3c3eb15fb29]
stable/7.1: [eb2f934646aefb06314cecd1deb020794829b207]

CVE-2026-68226: media: cx23885: add ioremap return check and cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68226

Introduced by commit d19770e ("V4L/DVB (6150): Add CX23885/CX23887
PCIe bridge driver") in v2.6.24-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a0701e387b46e2481c05b47f1235b954bfc2af3e]
stable/6.12: [83540d86d717735b52a43e4ba1b784da5cc2310a]
stable/6.18: [c68c4ce72feb6fcccc843eb3baa7af60189ed567]
stable/6.6: [8fbdca4c99f68734e9b6c030973fb61a11bede15]
stable/7.1: [ff3c670a1de3a714f5644e37b9446fe7c3299fd3]

CVE-2026-68227: media: cx231xx: fix devres lifetime

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68227

Introduced by commit 184a827 ("[media] cx231xx: use devm_ functions to
allocate memory") in v3.17-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d6358ab02866e5b7ed8d3a00805297617bbb0ec]
stable/6.12: [c5ccb01eb1107acb6aab8ce8fe5a523f215c837e]
stable/6.18: [f468b7ee5d6332b01e6c538179a4c720e6dae93b]
stable/6.6: [a373f1a5137e96549a795e7fb9efb5de0ae1d065]
stable/7.1: [e797e252bfb3d0d4b3d38e4faef817e05869c240]

CVE-2026-68228: media: chips-media: wave5: Move src_buf Removal to finish_encode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68228

Introduced by commit 9707a62 ("media: chips-media: wave5: Add the v4l2
layer") in v6.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b20157147089a9c16a38c7810e2fe6f2df8e3277]
stable/6.12: [1ee2b2b189ddc7b23c8eee1145de42b8bd19fb06]
stable/6.18: [f24ca8b53fe15db40957bdaa40c9aa68e1557bbe]
stable/7.1: [d681227ce43bfd74b6eb69beecd9b0bec1fd8b48]

CVE-2026-68229: media: cedrus: skip invalid H.264 reference list entries

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68229

Introduced by commit e000e1f ("media: uapi: h264: Update reference
lists") in v5.10-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [10358ea986c3c85516d1c8206486464f79d36e76]
stable/6.12: [0af8945fcae742d099f59f3c725eb67235953a31]
stable/6.18: [9924cb548ee7753a6473997949c3ec48092de0b0]
stable/6.6: [2ee8327c85b3ac7b532d2d6a1e3a295d5ad7414a]
stable/7.1: [e53112c2de88982e66c369aee2120d5efd78df30]

CVE-2026-68230: media: amlogic-c3: Add validations for ae and awb config

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68230

Introduced by commit fb2e135 ("media: platform: Add C3 ISP driver") in
v6.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9724164f71974a2a44a5e026614fbcc05bab6d91]
stable/6.18: [391fe3e36e59f3c6e3d46edfb3a5de51e00cd216]
stable/7.1: [32cbe5474e74817aa8a576b94135cc45e59f5e07]

CVE-2026-68231: media: airspy: Return queued buffers on
start_streaming() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68231

Introduced by commit 634fe50 ("[media] airspy: AirSpy SDR driver") in v3.17-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [04344d0b4929caa94c0df72f767752aa0935ef5d]
stable/6.12: [cd42623d698b59f1fe5768f78a4101c28d5feb2e]
stable/6.18: [73bd2779865372b1017d4f555b45270aa2d0d710]
stable/6.6: [877686a74ecdc93dcaee09dbac566e819059c9e7]
stable/7.1: [170fcc945bc094b1c956bf555c070692826a3eff]

CVE-2026-68232: drm/gpusvm: Fix MM reference leak in drm_gpusvm_range_evict

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68232

Introduced by commit 99624bd ("drm/gpusvm: Add support for GPU Shared
Virtual Memory") in v6.15-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [847b371debf3c8c72384ab7b9a0c4123a74cc925]
stable/6.18: [a2212fef8e18724e06432fce01fa257296d9f053]
stable/7.1: [adf0542659c783c962f4a8f2adcb3532ed54821c]

CVE-2026-68233: drm/vc4: Shut down BO cache timer before teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68233

Introduced by commit c826a6e ("drm/vc4: Add a BO cache.") in v4.5-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6273dd3ffb54ec581855b82ae77331b66028249c]
stable/6.18: [a38f2724eb93a78ba250b01e0caf3468df4d3956]
stable/7.1: [bac4c1a9af690b8635c6924872075c41d8763ed9]

CVE-2026-68234: drm/amdgpu: fix bo->pin leaking in amdgpu_bo_create_reserved

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68234

Introduced commit is not determined.Fixed in v7.2-rc4.


Fixed status
mainline: [a2f895f3c852063258d62e9f74b081de07ca95df]
stable/6.12: [2f390b4c83011452753fd84972f657d2b00a952b]
stable/6.18: [ba7b6444097a73ccd3d3ac9e2be4ebb73d226460]
stable/6.6: [51eeef1949c11d3dcb5f422a5d9b3f09ebe8a1bc]
stable/7.1: [9743f60013273987abf415dc47474683d22aaee9]

CVE-2026-68235: drm/amd/display: dce100: skip non-DP stream encoders for DP MST

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68235

Introduced commit is not determined.Fixed in v7.2-rc4.


Fixed status
mainline: [d340cba0df4cf327c7e89c7c1a4e79d4771d7dd5]
stable/6.12: [bfe28ce019c2d667d98071262da33d8bba122919]
stable/6.18: [51ea665c30c424c98959101f3bf6f48ab42949c8]
stable/7.1: [ed2d86aef9fa4c43f82da0fca91a60f7326d7d03]

CVE-2026-68236: drm/amd/display: set new_stream to NULL after release

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68236

Introduced by commit 9b690ef ("drm/amd/display: Avoid full modeset
when not required") in v4.15-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9fa26b9eed6195bf840f39ac183b9a6237548755]
stable/6.12: [5182e442e61397d446c36995b8f5676942d35b82]
stable/6.18: [679f23f0a3606afcef1ffabd72222f00a54ad9e3]
stable/6.6: [ba8bf1dcbb44773e7a0fd13b42925c644e0d5e76]
stable/7.1: [0676fecbb5242aa22c057e78326d6d6041db034c]

CVE-2026-68237: drm/amdgpu/userq: fix indefinite fence wait during GPU reset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68237

Introduced by commit 290f46c ("drm/amdgpu: Implement user queue reset
functionality") in v6.19-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d75ec2e5f1736c2f10c7d6f4565bf1bf29f29a7]
stable/7.1: [3085ae8695e025b39d208f288c6265edc75abbe8]

CVE-2026-68238: drm/amdgpu: Release VFCT ACPI table reference

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68238

Introduced commit is not determined.Fixed in v7.2-rc4.


Fixed status
mainline: [65bff26617607c1331283232016c0e89088c5b78]
stable/6.18: [312278b3091912fa56a6a587609f17dcb33465c2]
stable/7.1: [9b7de3ee5d2c5ee2a706e5f7ca0126f4fbea4da8]

CVE-2026-68239: drm/ttm: Account for NULL and handle pages in ttm_pool_backup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68239

Introduced by commit b63d715 ("drm/ttm/pool, drm/ttm/tt: Provide a
helper to shrink pages") in v6.15-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5b7b3b6595ee77d01c7463757baed114786094dd]
stable/6.18: [22aa7fb4e7d0b3ab41d1240ed743167980912970]
stable/7.1: [9ddaabf38f7a45b329e34358b98d2968d8649d21]

CVE-2026-68240: drm/gpusvm: publish dpagemap early to avoid device
mapping leak on error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68240

Introduced by commit f70da6f ("drm/gpusvm: pull out drm_gpusvm_pages
substructure") in v6.18-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f708f51e3955bda0d77a0b67ab9bea6c97fea99]
stable/6.18: [e8362523fd1b61712f7d996802f9b5dee545c7e6]
stable/7.1: [72e4fca5529e45b5beebad79d804de442f632324]

CVE-2026-68241: drm/i915/mst: limit DP MST ESI service loop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68241

Introduced by commit 3c0ec2c ("drm/i915: Flatten
intel_dp_check_mst_status() a bit") in v5.8-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [005771c18c5b2c98cb4e7517661aea460990fd3f]
stable/6.18: [e3bcd3bf7eeca9570b9fa0b2f8a602c7bcc6b0d0]
stable/7.1: [9061fbf2230b6fcef042a6f637beae57c2fc93a5]

CVE-2026-68242: drm/i915/gt: Fix NULL deref on sched_engine alloc failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68242

Introduced by commit 3e28d37 ("drm/i915: Move priolist to new
i915_sched_engine object") in v5.15-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [82ec992c404c3dc774c5e9f3d4aa858e97187675]
stable/7.1: [edd4804f07b8369ed472de19272974e2bf2a6271]

CVE-2026-68243: drm/i915/gem: Fix NULL deref in I915_CONTEXT_PARAM_SSEU

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68243

Introduced by commit d4433c7 ("drm/i915/gem: Use the proto-context to
handle create parameters (v5)") in v5.15-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b56757a9a7456825eb668fde92299e01c5e2721]
stable/6.12: [9923c223d38fcd9602f41cc31d480e5299d9a38e]
stable/6.18: [726f27bca93e6c83b263542669132ee1d0eb693e]
stable/6.6: [edd2edaca52ada833c341c8b264aaea9dd93369c]
stable/7.1: [97f236379f06a5082d37c6a764edd56bb58a94cd]

CVE-2026-68244: drm/i915/gem: Do not leak siblings[] on proto context error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68244

Introduced by commit d4433c7 ("drm/i915/gem: Use the proto-context to
handle create parameters (v5)") in v5.15-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eed3de2acf6aa5154d49098b026710b646db67ee]
stable/6.12: [8431a4d7ff95c7f9c6fb1dbbbc9cdadf29d4f6d5]
stable/6.18: [37951ce1567ccf8c86c7a1b8fb7d55a32c821b87]
stable/6.6: [f014702fbd48d06a3d7a06e4bb4075d406376cf0]
stable/7.1: [6cdbef8f60f313684e641628d64aa85960080d3f]

CVE-2026-68245: drm/amdgpu: fix lifetime issue of
amdgpu_vm_get_task_info_pasid()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68245

Introduced commit is not determined.Fixed in v7.2-rc3.
Affected code was added by b8f67b9 ("drm/amdgpu: change vm->task_info
handling") in v6.9-rc1.

Fixed status
mainline: [04cc4aa3617b0ed67e859f91f09de5d896a46f3a]
stable/6.12: [fe16a7e5336ae888751984e30c451fbf7cfa5df7]
stable/6.18: [1173190412fb9d12e7efce76734118d9712ff970]
stable/7.1: [5d5fb9124a2bba96a7807086d8fe0f7ce810d546]

CVE-2026-68246: drm/amdgpu/gfx11: replace BUG_ON() with WARN_ON()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68246

Introduced commit is not determined.Fixed in v7.2-rc2.
Affected code was added by 3d879e8 ("drm/amdgpu: add init support for
GFX11 (v2)") in v5.19-rc1.

Fixed status
mainline: [0eebcab1ea2a77f086a04108f386f82ee3496022]
stable/6.12: [7aeef42b657d930f3b639220e62120ac1bf058a1]
stable/6.18: [dfd9bf09fd8fe81f113a5c7e88bfd99f2499542f]
stable/6.6: [96b6d68f2b5a208e4d8f1e4a932ec424655e1267]
stable/7.1: [625f301e01bf89694466fdaa1f9904e2c62eb8f2]

CVE-2026-68247: drm/i915/bios: range check LFP Data Block panel_type2

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68247

Introduced by commit 6434cf6 ("drm/i915/bios: calculate panel type as
per child device index in VBT") in v6.0-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2084503f2d087bf956198e7f6eb25b03a7049cb2]
stable/6.12: [e7b5694645b03e80830dc141b59fc65aac693c70]
stable/6.18: [8b2da44446f9dce2ae50fee78bac2734d4277143]
stable/7.1: [8887b94d2fc93071bf6ff09c39d474510e6f582f]

CVE-2026-68248: drm/i915: Return NULL on error in active_instance

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68248

Introduced by commit bfaae47 ("drm/i915: make lockdep slightly happier
about execbuf.") in v5.13-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e33f0de5fdcd09e51fdec1e5822448970b6420f]
stable/6.12: [b238d86e7f43afde8e830ef5b8d89ffedbbc7613]
stable/6.18: [cbec6a57959ab503e3ad4ad6edd51efb585dce92]
stable/6.6: [32c1a2afa90dd07df931f0b12578de1dbb751f0c]
stable/7.1: [58b7e63ca0cd964190957ddd169c899256acaee9]

CVE-2026-68249: drm/amdgpu/sdma5.0: replace BUG_ON() with WARN_ON()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68249

Introduced commit is not determined.Fixed in v7.2-rc2.
Affected code was added by fef6e24 ("drm/amdgpu: add initial support
for sdma v5.0 (v6)") in v5.3-rc1.

Fixed status
mainline: [9e98ed3113943257ad6e5c1e6beddbdb482a70ad]
stable/6.12: [28337e5d7df429bac7de64b17f1a595147778caa]
stable/6.18: [d20b5c139b2906bcd8ab4bfe5b8be500318161d1]
stable/6.6: [f6212bc1bbd936fd9f7d77168b0c8b0019477b64]
stable/7.1: [0027cb19b0449ad6babedb1af285a713ab05c97f]

CVE-2026-68250: drm/amdgpu/sdma5.2: replace BUG_ON() with WARN_ON()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68250

Introduced commit is not determined.Fixed in v7.2-rc2.
Affected code was added by 157e72e ("drm/amdgpu: add sdma ip block for
sienna_cichlid (v5)") in v5.9-rc1.

Fixed status
mainline: [b9dd618a635d39fbb211454b6e8837b2a7f10fb0]
stable/6.12: [b665c1845488c6cd869da3d31b5978015977f898]
stable/6.18: [09da54636bac146c1a3c461c4e7eb08d355bb86e]
stable/6.6: [01dfea84df919cfbec4064151d327480ae5c120d]
stable/7.1: [2051bbbfbd44ff51637b01a5a3dbee6630f90d57]

CVE-2026-68251: drm/amdgpu/sdma6.0: replace BUG_ON() with WARN_ON()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68251

Introduced commit is not determined.Fixed in v7.2-rc2.
Affected code was added by 61a039d ("drm/amdgpu: add initial support
for sdma v6.0") in v5.19-rc1.

Fixed status
mainline: [ec42c96c322e5cc48099ab5e67b5cbe236cb1949]
stable/6.12: [e7f31c9a61533062a704f90b9f63064045249693]
stable/6.18: [51fd52087165180967cf7d5ee99badee7e172ea0]
stable/6.6: [2eb06c88426b6c8de602c608959f3a56ac51861e]
stable/7.1: [9df8a7f09e305249872b536555793b28e77b7de9]

CVE-2026-68252: drm/amdgpu/sdma7.0: replace BUG_ON() with WARN_ON()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68252

Introduced commit is not determined.Fixed in v7.2-rc2.
Affected code was added by b412351 ("drm/amdgpu: Add sdma v7_0 ip
block support (v7)") in v6.11-rc1.

Fixed status
mainline: [e80e28f398f5d9f6e361ffb56382d2e74fc87556]
stable/6.12: [395bf099ef7153227600a2d8cb087f45c4a277b6]
stable/6.18: [4c09483325360373656214cc7a2fd29dc73037a5]
stable/7.1: [bcbd53d25da879bbce75faad9888c9a56e942fec]

CVE-2026-68253: drm/i915/hdcp: check streams[] bounds before overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68253

Introduced by commit e03187e ("drm/i915/hdcp: MST streams support in
hdcp port_data") in v5.12-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bbb15a6b042d02e5508a02b4847e02d2579ee7bc]
stable/6.12: [2106fb490b2c6003e23ad6ff36ce823a2170e138]
stable/6.18: [3d2ef8d389495e7889c6062d8bddc46d2a5fbdef]
stable/6.6: [84351f12390349ba010920fc247e1a0b12e41eb3]
stable/7.1: [984085c5b53572e2e03fd5fc4817e86ef1effc6e]

CVE-2026-68254: drm/i915/vrr: require valid min/max vfreq for VRR

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68254

Introduced by commit 117cd09 ("drm/i915/display/dp: Compute VRR state
in atomic_check") in v5.12-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8a9262c7a6fc2de9802e14b0228114f0333869e]
stable/6.12: [f16218689b41efcbc491207cd7716477b1223879]
stable/6.18: [df1582c0a101e2e2f133dd331d2a3258bb6a7518]
stable/6.6: [6598ac1721c3a5543efdbcab579a8561268d7ce1]
stable/7.1: [c726c8bbee5115dad37fa7867136ebaa50690331]

CVE-2026-68255: drm/virtio: bound EDID block reads to the response buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68255

Introduced by commit b4b01b4 ("drm/virtio: add edid support") in v5.0-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e1a53892ba7f8a3e1da6bfc53c83ae7c812dccd]
stable/6.12: [2757e6e803092cf0aeaf4b735e16b5d3bdc705c5]
stable/6.18: [35be0e2c6862abcd5e5f5445261f1fd910d4a9b4]
stable/6.6: [9fc2a017c5d597937e0c28b9a9669844aa796c42]
stable/7.1: [375c1934ef0196d3b6d3a1eae3232bef8dae7bf7]

CVE-2026-68256: drm/amd/display: detect_link_and_local_sink: DP alt
mode timeout path leaks prev_sink reference

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68256

Introduced by commit 5461888 ("drm/amd/display: break down dc_link.c")
in v6.3-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a6e14b976be48eebd8769cb5b883a6af7fc5ade1]
stable/6.12: [a59e493567d18ef3858be9368acd132a01ebfa09]
stable/6.18: [4ee77643e6194f2deb62fe62f04396f9825e27d8]
stable/6.6: [f9922828a4ebd26286fbe0286cc61695e7d9b07b]
stable/7.1: [58ea24dd96848626039296e9e8510270ec8dc4bf]

CVE-2026-68257: drm/amdkfd: fix 32-bit overflow in CWSR total size calculation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68257

Introduced commit is not determined.Fixed in v7.2-rc4.


Fixed status
mainline: [2b0386d4293920e690c0e017708f999b93cc729b]
stable/6.12: [b88ffe6593607364a8c06a48c6f29e55437cdf8e]
stable/6.18: [abce3276c57e36c955627307469b9f009057a467]
stable/7.1: [865532d54eb57b660b1cb1b0e1755776ce21b849]

CVE-2026-68258: drm/amdkfd: Check bounds on CRIU restore queue type and mqd size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68258

Introduced commit is not determined.Fixed in v7.2-rc3.


Fixed status
mainline: [47ea05f246bebc81c7796f56265cffd812cf0601]
stable/6.18: [fd1691ec62701c982ea32e749678988c67fd4c21]
stable/7.1: [cc10a5839756982504ee8568fc1e1625962ab7f8]

CVE-2026-68259: drm/amdkfd: Check bounds in allocate_event_notification_slot

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68259

Introduced commit is not determined.Fixed in v7.2-rc3.


Fixed status
mainline: [bb52249fbbe948875155ccd45cd8d74bf4ae747b]
stable/6.12: [4622214f0542f64b02c250db0f9c677eeb032d9b]
stable/6.18: [50319efb865f72db45f191c8709511746d58ee0a]
stable/6.6: [85eedff5f0c4aba5a66bc37a1bd6bcecd0d77b53]
stable/7.1: [abeeb1947d81610c65349db4d89c6151f270e136]

CVE-2026-68260: drm/imagination: acquire vm_ctx->lock before mapping
memory to GPU VM

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68260

Introduced by commit ff5f643 ("drm/imagination: Add GEM and VM related
code") in v6.8-rc1.
Introduced by commit 4bc736f ("drm/imagination: vm: make use of
GPUVM's drm_exec helper") in v6.8-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [17e2030f37600994440f875dc410615d5c66ee6d]
stable/6.12: [1f1f2618e44b21a7d4eb30d3bbd7e015ffbbbadf]
stable/6.18: [6253bb56bb2ebdf317d8b599ce737a2510cc2e17]
stable/7.1: [15f58d44c24477a6ebffa44ec05207b81cfa55d9]

CVE-2026-68261: drm/imagination: fix error checking of pvr_vm_context_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68261

Introduced by commit d2d79d2 ("drm/imagination: Implement context
creation/destruction ioctls") in v6.8-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf385cf6e713eba0720651174dac0b2d2f5bb8f8]
stable/6.12: [ce97192087c659f2e0c0c2a627330c7edcc9eeb3]
stable/6.18: [c45fafa69fe3f79e319369cf665da89868e3ef98]
stable/7.1: [401fbe3b6bbb6c94c24ee8843b7beed5111491ac]

CVE-2026-68262: drm/imagination: Fix user array stride in pvr_set_uobj_array()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68262

Introduced by commit f99f5f3 ("drm/imagination: Add GPU ID parsing and
firmware loading") in v6.8-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8dc8f3f4c2382fb7d1b1986ba8f33a2466cd3d7a]
stable/6.12: [bbebc39a70f6fc9b02637c8624349e30325873cb]
stable/6.18: [b983a35dad3701399c692d7c6eb57d8b6ffc0929]
stable/7.1: [09beaf4aec05b0525f2153dce693f3eb3166697a]

CVE-2026-68263: drm/imagination: Fix double call to drm_sched_entity_fini()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68263

Introduced by commit eaf01ee ("drm/imagination: Implement job
submission and scheduling") in v6.8-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4af24c27a39ba147a613a09e10b9e0f7294524c0]
stable/6.12: [9be3f4bd6f514f69c51a8c77ea64fce2729dc7f4]
stable/6.18: [c88fdbf3da26e0179629530cae7768cd3d4ead85]
stable/7.1: [c1136d907fd04ca5c62ba11c1159b5fe65a1760c]

CVE-2026-68264: drm/xe/pt: Reset current_op in xe_pt_update_ops_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68264

Introduced by commit e8babb2 ("drm/xe: Convert multiple bind ops into
single job") in v6.12-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6384271ac1ac0099198d15df79212a19ebdb929d]
stable/6.12: [be5c39730ab8f1dfe59983bf7d8e3705541d1fee]
stable/6.18: [157b1e3384d7d37f59c0c2b2ff2af8f557db1daa]
stable/7.1: [90e4fd331b980259c40118d05b89b0ec514e7c48]

CVE-2026-68265: drm/xe/vm: Fix BO prefetch with CONSULT_MEM_ADVISE_PREF_LOC

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68265

Introduced by commit c1bb69a ("drm/xe/svm: Consult madvise preferred
location in prefetch") in v6.18-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7bc597ce74bab4153b2009c92eccf889e9d74044]
stable/6.18: [d256dac008d1d9e6378aa1a5454e89a8292d174c]
stable/7.1: [c4affa4e8bc8086b4d3e8d6cf1055a624f813d72]

CVE-2026-68266: drm/xe: Hold a dma-buf reference for imported BOs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68266

Introduced by commit dd08ebf ("drm/xe: Introduce a new DRM driver for
Intel GPUs") in v6.8-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [62775525a27c3b0d56382e08ba81ee2d322058b6]
stable/6.12: [c22d65d62b3318e237c0e5b1177d90ab83d9fe06]
stable/6.18: [c1954c66662de477a8f4309335b775f7b07bd28b]
stable/7.1: [ba8c4cbb31c6f81fa5b12d6e28f1f706040aff48]

CVE-2026-68267: drm/xe/rtp: Add RING_FORCE_TO_NONPRIV_DENY to OA whitelists

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68267

Introduced by commit 828a8ea ("drm/xe/oa: Add MMIO trigger support")
in v6.11-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e70086a3a06d276b4a5d9a2c51c9330c6cf72780]
stable/6.12: [9852aa87ecba95d7bf9fb94a9d6c4f69312c9682]
stable/6.18: [7982678fa21eda02a9111d2646be6762b5e3a64d]
stable/7.1: [1e6d07abbc0c41cb3259042794ad3deca79dd14e]

CVE-2026-68268: drm/xe: Return error on non-migratable faults requiring devmem

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68268

Introduced by commit 4208fac ("drm/xe: Add more SVM GT stats") in v6.18-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [136fb61ba8571076dc5d49350a0e6d002d740b74]
stable/6.18: [90a8a938e0caecc9ee9dec3eb9eda92d66ba02a3]
stable/7.1: [7445e1b85159baf40d56b9557f344f131f924dd0]

CVE-2026-68269: drm/i915/gem: Add missing nospec on parallel submit slot

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68269

Introduced by commit e5e3217 ("drm/i915/guc: Connect UAPI to GuC
multi-lrc interface") in v5.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [914a76a9f08366434bf595700f62026b7a19a9cc]
stable/6.12: [be393175306694de5da1d1a23a8ea4149baa09f1]
stable/6.18: [45db277b2e1e34bcc99a0852026791108339ec3e]
stable/6.6: [4a27275d275971c9ea29d3d240ea4a224ad368a2]
stable/7.1: [c41a54619e95f860bf2950dd679ab353380ecd2b]

CVE-2026-68270: drm/sysfb: Avoid possible truncation with calculating
visible size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68270

Introduced by commit 32ae90c ("drm/sysfb: Add efidrm for EFI
displays") in v6.16-rc1.
Introduced by commit a84eb6a ("drm/sysfb: Add vesadrm for VESA
displays") in v6.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b771974988ec7ce077a7246fa0fa588c246fe581]
stable/6.18: [154795885e8f0033c918c815aece543168bee670]
stable/7.1: [9d58a811739a365cd693192f4b5344d736967a88]

CVE-2026-68271: drm/nouveau: fix reversed error cleanup order in ucopy functions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68271

Introduced by commit b88baab ("drm/nouveau: implement new VM_BIND
uAPI") in v6.6-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab99ead646b1b833ecd57fe577a2816f2e848167]
stable/6.12: [e15c25c7972d38a9f6bf8c3f7f29179a67263eba]
stable/6.18: [4e109faa9ea2b6c04cc5a99e76db3126575a59d1]
stable/6.6: [2473ac314387a5def7244eb6d6a345934ed140bf]
stable/7.1: [ebbaf64d2635d1e78196c067fa8fa582a7dc17f7]

CVE-2026-68272: drm/amdgpu: validate CP_GFX_SHADOW chunk size in CS pass1

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68272

Introduced by commit ac92870 ("drm/amdgpu: add gfx shadow CS IOCTL
support") in v6.5-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [84c4c36acd5c4b2558b5069f869a165b2c655c84]
stable/6.12: [2aa9ea2bd5146d237c8cc16d8737d878b0298a94]
stable/6.18: [315d2e5741a81b0be763e80413a2677e22b7e596]
stable/6.6: [3f190956404da55560056ce20606010e18bc059c]
stable/7.1: [24668ca3ec19434d7a9574bf9112f2b0614c3a4e]

CVE-2026-68273: drm/amdgpu: Fix context pstate override handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68273

Introduced by commit 79610d3 ("drm/amdgpu: fix pstate setting issue")
in v6.1-rc3.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c1dc4ccb82c9e56325d8e7514ca4c90bd1efb351]
stable/6.12: [23a8726e1d7597fe7c9a59d5dc42ba8b7d345b8a]
stable/6.18: [e06c39cc1c48dca68a5ffd971c23025a52d46634]
stable/7.1: [9f9c88eb298c54348be3ca4087f4f4c615065b87]

CVE-2026-68274: drm/xe/guc: Fix buffer overflow in steered register
list allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68274

Introduced by commit b170d69 ("drm/xe/guc: Add XE_LP steered register
lists") in v6.13-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [632ecc90e1ca5d3b6822bb4d08f84a175b6c42c0]
stable/6.18: [b485bfb45555163bfa5f565d6a3415fcb3035b02]
stable/7.1: [a9a020f3c11eba6573b699f9cf9245a51b025ade]

CVE-2026-68275: drm/amdgpu: check amdgpu_vm_bo_find() result in GET_MAPPING_INFO

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68275

Introduced by commit 4d82724 ("drm/amdgpu: Add mapping info option for
GEM_OP ioctl") in v6.18-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [93475c34111916df71c63e510fc52db01351f809]
stable/6.18: [ddba17b3dfa0efc80d6c98621c2fb7af66adb622]
stable/7.1: [9faf4c66edb6bcb8ca0465c3a4868bb7f278cd31]

CVE-2026-68276: drm/amdgpu/gfx: fix cleaner shader IB buffer overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68276

Introduced by commit d361ad5 ("drm/amdgpu: Add sysfs interface for
running cleaner shader") in v6.12-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e864bf2a32a1cbdf1e0f9c5a5a4176e8575f4a3]
stable/6.12: [201633f47b542a99bb7baafdfcda7781249fb3d9]
stable/6.18: [e28420e36542ae8b66a5bdcec419525f521bddf8]
stable/7.1: [9cd9a983769a4d0e9cc80a287316ee79685d38b3]

CVE-2026-68277: drm/dp/mst: fix OOB reads on 2-byte fields in sideband
reply parsers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68277

Introduced by commit ad7f8a1 ("drm/helper: add Displayport
multi-stream helper (v0.6)") in v3.17-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6b89ba3dba2f583626fb693e47e951ffb8bf591f]
stable/6.12: [0bcd7675c69a2462a8531fcd9e4d096e9c7ec5df]
stable/6.18: [d5c70523cafa26ad2c7a37b612849abe2683baa8]
stable/6.6: [bdf0508b1e6785d4a8982c637e97e68d60b47d7b]
stable/7.1: [68a624416d1dd481b3e5b7ea0e8a070a9b8a2c73]

CVE-2026-68278: drm/dp/mst: fix buffer overflows in sideband chunk accumulation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68278

Introduced by commit ad7f8a1 ("drm/helper: add Displayport
multi-stream helper (v0.6)") in v3.17-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [55bd5e685bda455b9b50c835f8c8442d52a344a3]
stable/6.12: [ef0dbcc200c3389f1f781ab181932a97e54b51af]
stable/6.18: [1e5827839ad0ceb0079d1560c321fa3656b54f21]
stable/6.6: [53937a2787d29c7a460e984dc4f20ff6ac91dc65]
stable/7.1: [a6366b551079c79bf7bdbadd74c97358bcfe2d58]

CVE-2026-68279: drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband
reply parsers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68279

Introduced by commit ad7f8a1 ("drm/helper: add Displayport
multi-stream helper (v0.6)") in v3.17-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1a8f537f5a1eeac941f262fe73078d6b08ba83c0]
stable/6.12: [04d953f50d61e542e94a5977822cc53735f8c0ce]
stable/6.18: [533d9e2bede4aeefdc2a0561d7071cfede95958f]
stable/6.6: [22d9f7fc1aaabaf73d5f30e8b0c9aa814ecd6ed2]
stable/7.1: [e6ef5455b06cb4e5d181aabcd723791587c79f12]

CVE-2026-68280: drm/bridge: cdns-dsi: Replace deprecated UNIVERSAL_DEV_PM_OPS()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68280

Introduced by commit e192339 ("drm/bridge: Add Cadence DSI driver") in
v4.18-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d8b08844c0ecc6f2002fa68711e779aa18c8585]
stable/6.12: [347bc3a6a4d968c403d2292e5ad986294d919dfc]
stable/6.18: [c0384d6872f4dc2701960048a0be1a12a8d2dc6e]
stable/6.6: [c18d46d9830c29677be5213a067daafe1ac80e43]
stable/7.1: [1f9c6b74e79639179e90ad0c0fbeae26e31e044b]

CVE-2026-68281: drm/imagination: Count paired job fence as dependency
in prepare_job()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68281

Introduced by commit eaf01ee ("drm/imagination: Implement job
submission and scheduling") in v6.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9cd74f935306cd857f46686975c43383e1d95f94]
stable/6.12: [02b0da249c8f78d2bbf9f498bbd371c66142b0af]
stable/6.18: [943fa73ea0efa335d9c1800fcfac47915de4ff89]
stable/7.1: [a673171502e87acb5a9e2923f4cf9dce521fd05e]

CVE-2026-68282: drm/rockchip: analogix_dp: Add missing error check for
platform_get_resource()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68282

Introduced by commit 718b3bb ("drm/rockchip: analogix_dp: Expand
device data to support multiple edp display") in v6.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [45895f4d4d5f222d07412f90664f88b059627859]
stable/6.18: [6ab29a86835721566f0c26bd7bebcdcdcb0cb093]
stable/7.1: [ba34d197ebf2552cf10d279e076c58a22c9ecf73]

CVE-2026-68283: tracing: Fix use-after-free freeing trigger private data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68283

Introduced by commit 61d445a ("tracing: Add bulk garbage collection of
freeing event_trigger_data") in v6.19-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79097812153b826fc156a2930ec8a90ed9edf4a2]
stable/7.1: [b9c8a1400a3bf633f32820d184f3e05fed0f4af7]

CVE-2026-68284: bpf, sockmap: Fix cork use-after-free in tcp_bpf_sendmsg()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68284

Introduced by commit 604326b ("bpf, sockmap: convert to generic sk_msg
interface") in v4.20-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d66a033864e27ab8d5e44cb36f31d9d2413bee4]
stable/6.12: [cde4d6bcd9b73073c66498f6723c7b364c4dbc18]
stable/6.18: [786d690257ec7a0c839f8710456e444ce3f1348b]
stable/6.6: [ee762f684eefa59de34d9ed93cab08336e834f47]
stable/7.1: [752b1159ed5d0c48fe169a3721b96660a9822aa1]

CVE-2026-68285: LoongArch: BPF: Fix memory leak in bpf_jit_free()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68285

Introduced by commit 4ab17e7 ("LoongArch: BPF: Use BPF prog pack
allocator") in v7.0-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47e20d4b3da97ef3881d1e55e43545c22424f3fc]
stable/7.1: [f1557e0a64736b63aed24e285108a7bc3b7de294]

CVE-2026-68286: drop_monitor: perform u64_stats updates under
IRQ-disabled section

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68286

Introduced by commit e9feb58 ("drop_monitor: Expose tail drop
counter") in v5.4-rc1.
Introduced by commit 5e58109 ("drop_monitor: Add support for packet
alert mode for hardware drops") in v5.4-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd098a23bf8fda7eae48db9b06e7c34fc4d228fa]
stable/7.1: [d5e2cd2bc8ae36617346b3a54ee9da61d866bf92]

CVE-2026-68287: drop_monitor: fix size calculations for 64-bit attributes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68287

Introduced by commit ca30707 ("drop_monitor: Add packet alert mode")
in v5.4-rc1.
Introduced by commit 5e58109 ("drop_monitor: Add support for packet
alert mode for hardware drops") in v5.4-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7089f7ab99c89f443c92d8fcc585e63f2727f0b3]
stable/7.1: [4a9e30764e80693bcf875c776170edce20f94fe0]

CVE-2026-68288: net: drop_monitor: fix info leak in NET_DM_ATTR_PAYLOAD

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68288

Introduced by commit ca30707 ("drop_monitor: Add packet alert mode")
in v5.4-rc1.
Introduced by commit 5e58109 ("drop_monitor: Add support for packet
alert mode for hardware drops") in v5.4-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5e9c8baee0329fbefe7c67aea945e2a07f15e98b]
stable/7.1: [8fd6975d2aecc36b25ee82b6aef88e62a3527ccb]

CVE-2026-68289: tipc: fix integer overflow in tipc_recvmsg() and
tipc_recvstream()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68289

Introduced by commit e9f8b10 ("tipc: refactor function
tipc_sk_recvmsg()") in v4.12-rc1.
Introduced by commit ec8a09f ("tipc: refactor function
tipc_sk_recv_stream()") in v4.12-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47f42ff521b4eeb46e82f9a46a4783a99f7570d7]
stable/7.1: [fe9bf32bb18f2d35789d4960fb007d1059bbaa38]

CVE-2026-68290: rds: tcp: unregister sysctl before tearing down listen socket

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68290

Introduced by commit 7f5611c ("rds: sysctl: rds_tcp_{rcv,snd}buf:
avoid using current->nsproxy") in v6.13-rc7.
Fixed in v7.2-rc5.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [167e54c703ccd4fa028feb568b0d1002020cff86]
stable/6.12: [80fffed08dc1c10e971066941d2daa56253f1552]
stable/6.18: [16df2d154ec82e2f7e7585b4fa154751ba37729a]
stable/7.1: [3aa13fe0c1bb7bc5312f878e61523e5d8cf3f85d]

CVE-2026-68291: idpf: fix max_vport related crash on allocation error
during init

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68291

Introduced by commit 0fe4546 ("idpf: add create vport and netdev
configuration") in v6.7-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [237f1f7653b8729169af11fae79f01b90d00b87e]
stable/7.1: [9fbe22b7aff0a65984d78ee6b93e2f8179abd1f5]

CVE-2026-68292: ice: prevent tstamp ring allocation for non-PF VSI types

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68292

Introduced by commit ccde82e ("ice: add E830 Earliest TxTime First
Offload support") in v6.18-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [144539bbfd3cea1ab0fb6f5216d6004c1f4f029b]
stable/6.18: [684d4d0bda95a3fb21b3e29ff0f668f657707b54]
stable/7.1: [d0a21604c6abfa4956f3a511a1de174cec77a812]

CVE-2026-68293: net/mlx5: Fix MCIA register buffer overflow on 32 dword reads

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68293

Introduced by commit 271907e ("net/mlx5: Query the maximum MCIA
register read size from firmware") in v5.18-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [11c057d23465c7a5817a7284c896d19d54c0b616]
stable/6.12: [5be4eebd5a3a198dab0adcd550e1cadca79bdfed]
stable/6.18: [87b39a8c875ca744b7de69af0a8ef8874cffccf1]
stable/7.1: [88b2a16ddac3357e3f1d528e758b51e2c945d546]

CVE-2026-68294: net: qrtr: restrict socket creation to the initial
network namespace

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68294

Introduced by commit bdabad3 ("net: Add Qualcomm IPC router") in v4.7-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b536db8fb32da9e9c62f2bb45e2e319331f0426]
stable/6.12: [f488116df769bdaf89c93371350e49e12133e70f]
stable/6.18: [8150c48fb978e01689f94ed80148f8a7499ae571]
stable/6.6: [4b95e1f0d6e6342c427cb341ee18a894b146b789]
stable/7.1: [659b9b4f194bb56b9903cc95e786ef1d438baa7d]

CVE-2026-68295: LoongArch: BPF: Zero-extend signed ALU32 div/mod results

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68295

Introduced by commit 2425c9e ("LoongArch: BPF: Support signed div
instructions") in v6.7-rc1.
Introduced by commit 7b6b13d ("LoongArch: BPF: Support signed mod
instructions") in v6.7-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dacd348b8a993373576fe2ee2d8b114740ba57a6]
stable/7.1: [716cb29dbed4d62e9e108950a1a82bcba4cc2d45]

CVE-2026-68296: net: gre: fix lltx regression for GRE tunnels with SEQ/CSUM

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68296

Introduced by commit 00d066a ("netdev_features: convert NETIF_F_LLTX
to dev->lltx") in v6.12-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [675ed582c1aa4d919dd535490de08c015005c653]
stable/6.12: [9f948e9aede9678f4103457daf2bc9dd54c65a06]
stable/6.18: [15a1c5f2ed2eeb3daad8d5766fd506aeda4710f3]
stable/7.1: [2bffe379023512d280337c70faeb6a8cc435db5e]

CVE-2026-68297: tipc: fix u16 MTU truncation in media and bearer MTU validation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68297

Introduced by commit 901271e ("tipc: implement configuration of UDP
media MTU") in v4.18-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f29cd8a8e7901a2617c8064ce9f50fc67b97cb8]
stable/6.12: [f4013598b69457dbea350df52e52daea6faef8eb]
stable/6.18: [1b8fb5a20508bfb0db854e01214888c761b3a911]
stable/6.6: [f02334a9e378f7e07232b26dc3d2ab353339f040]
stable/7.1: [c1cda72f6acec02ebd45d913bf8527ff77336ba6]

CVE-2026-68298: drm/xe/vm: Fix SVM leak on resv obj alloc failure in
xe_vm_create()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68298

Introduced by commit 9e97874 ("drm/xe/userptr: replace xe_hmm with
gpusvm") in v6.18-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2c6800ad1802bed72a6de1416536737f114f1d6]
stable/6.18: [279339aa8bdcf9db40094cf2bcbd495c53dbe817]
stable/7.1: [9ac92736030f3395d970c300eaeb59ac258a0c3e]

CVE-2026-68299: vmxnet3: fix BUG_ON in vmxnet3_get_hdr_len() for Geneve packets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68299

Introduced by commit 45dac1d ("vmxnet3: Changes for vmxnet3 adapter
version 2 (fwd)") in v4.2-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [34a71f5361fc3adb5b7138da78750b0d535a8252]
stable/6.12: [28cb5d8d13b4c1faf3f688f62e5df82fe7b438d8]
stable/6.18: [4fdb0f162ccdbe9626863b10003855703253fa29]
stable/6.6: [667b6e52048eaf4dbcf1707ed87ffd44abb9cb38]
stable/7.1: [b28596baf87e25a078789f1c05817c8a3bf71257]

CVE-2026-68300: sctp: auth: verify auth requirement when auth_chunk is NULL

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68300

Introduced by commit bbd0d59 ("[SCTP]: Implement the receive and
verification of AUTH chunk") in v2.6.24-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e04823c120b376ef7dab14b60ebf6823aa16c14]
stable/6.12: [28c5fdce9dd955d2baf5e28987819b6d7cfaf646]
stable/6.18: [18957373920caf5cdaf5cf32e5d1d7a99ca7700a]
stable/6.6: [ec2e157fc9678a9bc411305a25aec3fd337d7efb]
stable/7.1: [83f5031f2a6a49d696eb4cc0898345d12f9c6451]

CVE-2026-68301: net: hsr: fix memory leak on slave unregistration by
removing synced VLANs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68301

Introduced by commit 1a8a63a ("net: hsr: Add VLAN CTAG filter
support") in v6.13-rc1.
Fixed in v7.2-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [dcf15eaf5641812f1cfc5e96537380132a7da89d]
stable/6.12: [21d48408479a17eb65568a765930adea37e4d804]
stable/6.18: [b5ded444621b6180df9f3d4e07045fc1fc1e8cd9]
stable/6.6: [f72c312af6c7897ab0f8a2b5a63f917a207a4143]
stable/7.1: [ae995b8002d3af134560a706c0e111a89e26317c]

CVE-2026-68302: amt: re-read skb header pointers after every pull

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68302

Introduced by commit cbc21dc ("amt: add data plane of amt interface")
in v5.16-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3656a79f94c471827a08f2cacce5f94ad5e52c24]
stable/6.12: [7746d588d42a4ac0117b68ed8e9b22a9da53dfb7]
stable/6.18: [ca0e8b661957f777591efe874cd9d9a63619cd99]
stable/6.6: [9005b221cb1f9c3c1a2ef656fb0e8fa80c0a187e]
stable/7.1: [7f48e3ddad8e97545b25788b8203b3a539df1621]

CVE-2026-68303: drm/vc4: hvs/v3d: Fix null dereference in unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68303

Introduced by commit d3f5168 ("drm/vc4: Bind and initialize the V3D
engine.") in v4.5-rc1.
Introduced by commit c8b75bc ("drm/vc4: Add KMS support for Raspberry
Pi.") in v4.4-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7dc3680b7ffe01add3e9299fde8471d2dd53a8ae]
stable/7.1: [261f0a3f0ac03248284f5116d3258f89c9642215]

CVE-2026-68304: wifi: brcmfmac: fix 802.1X-SHA256 call trace warning

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68304

Introduced by commit 2526ff2 ("brcmfmac: support 4-way handshake
offloading for 802.1X") in v4.13-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7cb34f6c4fe8a68af621d870abe63bfca2275dd6]
stable/6.12: [d3ac5b35ec85c41ccf8ec524d47b520e72edaca1]
stable/6.18: [00ebbf030d8c4a1cb89cbbae15e28332373649db]
stable/6.6: [137e4710da626290495b174e2eb1d5e889a4b165]
stable/7.1: [bd4fac033bb95fcad898cf6734e869991b2561cb]

CVE-2026-68305: drm/xe/vf: Add drm_dev guards when detaching CCS
read/write buffers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68305

Introduced by commit 864690c ("drm/xe/vf: Attach and detach CCS copy
commands with BO") in v6.18-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c92afb4c143526d340545ca581e88e6952ea511]
stable/7.1: [523ed2831ee55b2a1edabdea96781651f9df9685]

CVE-2026-68306: wifi: mt76: mt7996: fix possible NULL-pointer deref in
mt7996_mcu_sta_bfer_eht()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68306

Introduced by commit ba01944 ("wifi: mt76: mt7996: add EHT beamforming
support") in v6.3-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2fffc472bec490c8357defcee9c075ca74467352]
stable/6.12: [3e4f848f4a620e1d77c38459e73cf3b362f7bc6b]
stable/6.18: [d5628f39fccc107dca00b98a491d9848898599f7]
stable/6.6: [2b1882cf313ae44181146629b3578a7826c672c9]
stable/7.1: [45c496756c6f6df6c3aeb5b2cb996993d2f14687]

CVE-2026-68307: wifi: mt76: mt7925: fix crash in reset link replay

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68307

Introduced by commit 1406199 ("wifi: mt76: mt7925: add link handling
in mt7925_vif_connect_iter") in v6.11-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bd8b2ec838184236c3fcbf738a926328836adf12]
stable/6.12: [d9326796a378f80be5f9fd60983c62fdccdf2f0b]
stable/6.18: [95b0cf02731c74e073ef8937f5526bd4442a0326]
stable/7.1: [89d03bda560d635f66d495f37b46a187fd4edfdf]

CVE-2026-68308: wifi: mt76: mt7996: check pointer returned by
mt76_connac_get_he_phy_cap()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68308

Introduced by commit 98686cd ("wifi: mt76: mt7996: add driver for
MediaTek Wi-Fi 7 (802.11be) devices") in v6.2-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e858cf6bf99880343348ff1e8c942aaff1d9d592]
stable/6.12: [8b8a079e22ce9fc3c0d05b148ef67e4c6e576678]
stable/6.18: [d14238523ca4c6f5fcb54d1920eb2f8525a7711f]
stable/6.6: [4fd85fd2373501b7386e93a5ce4a549d7c4e64e3]
stable/7.1: [8bc7167e8a86489b7cb96a69cf1fb671d6df014b]

CVE-2026-68309: wifi: mt76: connac: fix possible NULL-pointer deref in
mt76_connac_mcu_uni_bss_he_tlv()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68309

Introduced by commit d0e274a ("mt76: mt76_connac: create mcu library")
in v5.12-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c1fb2335f5e3afb34f91bc07ecb63517c328090]
stable/6.12: [2afc2d5098866518a5c446a2e647b1b3f43daaf4]
stable/6.18: [c058786b09cfab080125bc3ee7928a181dcbd37a]
stable/6.6: [b09508dd7bc4a8948ea00603041a918c09788502]
stable/7.1: [8709c66e665a2a09192853d4f3d0fb4bd0f76403]

CVE-2026-68310: wifi: mt76: mt7915: guard HE capability lookups

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68310

Introduced by commit e6d557a ("mt76: mt7915: rely on
mt76_connac_get_phy utilities") in v5.18-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e9db062654a388d0fa587acbeeae68dd33eba41]
stable/6.12: [a031f454f14e3e76ad03bcb23918e1a82b4b0869]
stable/6.18: [871549814eb4da081f1e93cc0c7ea626a310a966]
stable/6.6: [23a2b98e754da04e0e90314d5fa8ca44349590fb]
stable/7.1: [6f99a5667c6c7c3e0da1d3c4dc8dfb103042609e]

CVE-2026-68311: wifi: mt76: mt7925: guard link STA in decap offload

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68311

Introduced by commit b859ad6 ("wifi: mt76: mt7925: add link handling
in mt7925_sta_set_decap_offload") in v6.11-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [96ea44f2269f30364cffa054ee3a87e595bef0d4]
stable/6.12: [1e608cae1ba0b4a600b752efa223fd2be376b143]
stable/6.18: [f1ee53e08fdd2906e90c6a6d71e1368fcd52bfc3]
stable/7.1: [d86883f7e8f03a5b81b4e59f2c0b6c05f79e01fd]

CVE-2026-68312: cifs: fix cifsFileInfo leak on kmalloc failure in
deferred close drain paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68312

Introduced by commit e3fc065 ("cifs: Deferred close performance
improvements") in v5.15-rc3.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c2f2e83e3bbc5483730fd4ee903182761f1ae50f]
stable/7.1: [32390b3f06f26e366cfb27dbac4bc0196c321535]

CVE-2026-68313: tipc: fix infinite loop in __tipc_nl_compat_dumpit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68313

Introduced by commit d0796d1 ("tipc: convert legacy nl bearer dump to
nl compat") in v4.0-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [22f8aa35964e8f2ab026578f45befc9605fd1b28]
stable/6.12: [1ab78af2140189b735b8d3b889b0284128cb2013]
stable/6.18: [e740e90ca8e7f70d9eac1aa31a8b3e0e4d32b2ef]
stable/6.6: [f9c669d9f4cac832fe31193cdbc24c6a9d99398b]
stable/7.1: [b8f3b8efa5f99081b14de1a7ffa68a81bf01bd48]

CVE-2026-68314: net: mctp i3c: clean up notifier and buses if driver
register fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68314

Introduced by commit c8755b2 ("mctp i3c: MCTP I3C driver") in v6.7-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [03d1057305ef17ac3f5936ac1580bc9a1a826e14]
stable/6.12: [49d15cfab247c0f60ce1800bdcd66850beea7b3a]
stable/6.18: [a8bd8c109da5a87f0c5db0c23cf550d039fde77c]
stable/7.1: [a40e83a34eaa2be64372286040696f04eabcd09f]

CVE-2026-68315: sctp: validate stream count in sctp_process_strreset_inreq()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68315

Introduced by commit 7f9d68a ("sctp: implement sender-side procedures
for SSN Reset Request Parameter") in v4.11-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [18ae07691d43183d270de8be9dc8e027906015d9]
stable/6.12: [6f0e39d180cd7cced647381b6fa14fd83d261047]
stable/6.18: [1a10fe1aa9c01f41b389a31906a77d538637c9d9]
stable/6.6: [b255d8cd6cc68045ae9eecbac3b3c14e1f176c9b]
stable/7.1: [00ae679cb21a035491fdad8d58dc6d79cc68b675]

CVE-2026-68316: accel: ethosu: Fix element size accounting for cmd
stream validation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68316

Introduced by commit 5a5e9c0 ("accel: Add Arm Ethos-U NPU driver") in v6.19-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [18a551482a4a326790698b273e76d7575a51a57d]
stable/7.1: [b4ae748f8e6cb65bb86e5a281bbb5b5e5f106527]

CVE-2026-68317: pds_core: fix auxiliary device add/del races

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68317

Introduced by commit b699bdc ("pds_core: specify auxiliary_device to
be created") in v6.15-rc1.
Fixed in v7.2-rc5.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [bfa33cd513c7ceb93c5a4c30e5662acd73c0a916]
stable/6.12: [ef194751fed50cf3452017b63f00142a0ab40c70]
stable/6.18: [cf0ed2ba202f5c3b300ec1bf7ff0b5d555f7d518]
stable/6.6: [646b58b543f3bb1641e9123b75ff7799fe7b42f1]
stable/7.1: [bdeab32a7a91acd295d52a2d4ab1cc3f2da5e454]

CVE-2026-68318: pds_core: fix use-after-free on workqueue during remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68318

Introduced by commit 01ba61b ("pds_core: Add adminq processing and
commands") in v6.4-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ad134881508c36b65c1a8864f8bec53adbd3327]
stable/6.12: [224214eb4182ff20a665b615a90b66017539dd75]
stable/6.18: [9e0f80fac50ab95dd75537c8ecaf5051d01f19b5]
stable/7.1: [ecc7a7d7569ec1d6a61e18372696b9de97635156]

CVE-2026-68319: pds_core: fix deadlock between reset thread and remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68319

Introduced by commit 81665ad ("pds_core: Fix pdsc_check_pci_health
function to use work thread") in v6.9-rc4.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab0eec0ff0a421737a37f510ceab5c6ea59cd05a]
stable/6.12: [90d9f3ef28843e6c35149324b8eefb427a7435c2]
stable/6.18: [19ef775c91c6bf4bd2b60f6616f4e28b621cdd6a]
stable/7.1: [54f905821f26d385fba407a920b51f0a752c76dc]

CVE-2026-68320: sctp: fix auth_chunk_list capacity check in
sctp_auth_ep_add_chunkid

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68320

Introduced by commit 1f48564 ("[SCTP]: Implement SCTP-AUTH internals")
in v2.6.24-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff04b26794a16a8a879eb4fd2c02c2d6b03850e9]
stable/6.12: [886e28e14ab655012779016d251fef53d103aa12]
stable/6.18: [11092d79eb2b7c0068382f72fc2416d1786bb2e0]
stable/6.6: [5a365f1e423444c5da7eb689a8661633dad43e48]
stable/7.1: [b6ea3dda09eb4d5caf7bbc00f857688cf9e98255]

CVE-2026-68321: net: txgbe: fix FDIR filter leak on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68321

Introduced by commit 4bdb441 ("net: txgbe: support Flow Director
perfect filters") in v6.11-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ecaa37826340520664a4e5522f803ff48fc3f564]
stable/6.12: [5c2f04258be2645cdd8f87553990948e7054e7fb]
stable/6.18: [2d34421bfa261f7e83bea2f2f75fa75e0c3037d1]
stable/7.1: [4946dea2386333e5d93bfb36df803fefb5a8c635]

CVE-2026-68322: rds: Fix inet6_addr_lst NULL dereference when IPv6 is disabled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68322

Introduced by commit eee2fa6 ("rds: Changing IP address internal
representation to struct in6_addr") in v4.19-rc1.
Introduced by commit 1e2b44e ("rds: Enable RDS IPv6 support") in v4.19-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9c805e592a29be9e4e61ff1bd567da04aa8fd6f9]
stable/6.12: [a8302e758050e6a922765aee8d220a4fd350f52d]
stable/6.18: [f6787fdffcae5490c779f0f3f33b11597525d1ae]
stable/6.6: [8e48d7ab1e01936a172ff31531904b003895fd8c]
stable/7.1: [00d5707217b5972554898ff734ae7b71bce704e6]

CVE-2026-68323: tipc: serialize udp bearer replicast list updates

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68323

Introduced by commit ef20cd4 ("tipc: introduce UDP replicast") in v4.9-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [350e592ff4e30e48ffb55e142d11a73e63f4869c]
stable/7.1: [d70c81001df9320d3445e664428a1d408b5ba896]

CVE-2026-68324: iommu/intel: Fix out-of-bounds memset in dmar_latency_disable()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68324

Introduced by commit 55ee5e6 ("iommu/vt-d: Add common code for dmar
latency performance monitors") in v5.14-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [754f8efe45f87e3a9c6871b645b2f9d46d1b407b]
stable/6.12: [866a35735e56b9dc81cbc33899255134adf6d8b3]
stable/6.18: [d06fea9b85f038690f55e72fe0c45e113715a85a]
stable/6.6: [3078d82e7fe9048a2b90a992e71af7cd7ef881fa]
stable/7.1: [0e28ca1c3204b51068579defc904a0dfba5e5c57]

CVE-2026-68325: iommu/amd: Bound the early ACPI HID map

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68325

Introduced by commit ca3bf5d ("iommu/amd: Introduces ivrs_acpihid
kernel parameter") in v4.7-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fb80117fddb5b477218dc99bb53911b72c3847f8]
stable/6.12: [abe5d7962f09adada9c4fb25b816dddd3f97c55d]
stable/6.18: [e5ebe8544df1a1c3611739a8622156094fe470df]
stable/6.6: [1e31d2394e0db69541b1591d46c5ad6431c81db3]
stable/7.1: [030a8e84f8f1b6e96f469c84a13a225c3699910b]

CVE-2026-68326: wifi: mwifiex: bound uAP association event IEs to the
event buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68326

Introduced by commit e568634 ("mwifiex: add AP event handling
framework") in v3.5-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0858bfc7d3cab411a447b88e3ef970e575032c9]
stable/6.12: [ad26c75ae25749313248f06510ebe43b5bf4adcc]
stable/6.18: [d21464d93f8ba464dc3d7b4b31c6e0adcd9f659c]
stable/6.6: [a3f47d7c75ddad1a14621a309286f9fae3cba191]
stable/7.1: [b6766d7ea43edf5de9d5a572bc58b631d09efe4b]

CVE-2026-68327: wan: wanxl: Only reset hardware after BAR mapping

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68327

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [91957b89da995607cb654b1f9a3c126ddbaee10f]
stable/6.12: [b9e2ff70e96acf83693b27987e0390bad9f83efa]
stable/6.18: [59cbe6cfa0fa23c192351cc284e30707309f6741]
stable/6.6: [f4834132773f15ffb255127499c8443947fa7d0f]
stable/7.1: [2fe22d58b3797d741570f9873b26653fd511576c]

CVE-2026-68328: nfp: Check resource mutex allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68328

Introduced by commit f01a216 ("nfp: add support for resources") in v4.11-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a61b4db34a753bdf5c9e77a7f3d3dddd41dcfacc]
stable/6.12: [cfa119aa781c4044dab5b4c1e5864600f53a26bc]
stable/6.18: [3b1d4fc3b73ea6faf008a0996ce6190c6e43efc3]
stable/6.6: [6dbd428119cb1fd1b73cf6968c711f4ea964dc8b]
stable/7.1: [a7dc30b6828c3a30252892827b12b676749f250f]

CVE-2026-68329: iommu/amd: Wait for completion instead of returning
early in iommu_completion_wait()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68329

Introduced by commit 815b33f ("x86/amd-iommu: Cleanup completion-wait
handling") in v3.0-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e75a8255f11c81fb07e81e5029cfd75804350a0]
stable/6.12: [93494bd446396c257fb589f59894577e96e406e2]
stable/6.18: [d053eb7e09e10cbdca3fca8b35c1017d438091b2]
stable/6.6: [ab7faf5a172ebfdc423ebb3eea4d472740de82f9]
stable/7.1: [02f8cefa2ad95ea3754f0cfd6fbae7f866202ccb]

CVE-2026-68330: net: airoha: Fix DMA direction for NPU mailbox buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68330

Introduced by commit c529187 ("net: airoha: npu: Move memory
allocation in airoha_npu_send_msg() caller") in v6.16-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f884eb87a79e0c482baef2ad96c96b81d024235]
stable/6.18: [76fc5604308a109bf5838c2a0a0eb3ac6819f1ea]
stable/7.1: [4c4d866a64f36718cbcdf20add372a599dd44311]

CVE-2026-68331: dpaa2-eth: put MAC endpoint device on disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68331

Introduced by commit 7194792 ("dpaa2-eth: add MAC/PHY support through
phylink") in v5.5-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b4b201cc93ff70150853aba03e14d314d1980ca0]
stable/6.12: [e23e4a3b9dfd893469c731318d409cdf04fb1ddf]
stable/6.18: [f112df0744e2d77baa68eeebb860021bbaaa022a]
stable/6.6: [915012e923316b8b5d5bf8fc771617b47bd7572d]
stable/7.1: [a3cecf169cc652b558d08661bb6ce55e4c933ec0]

CVE-2026-68332: net: airoha: Fix potential use-after-free in airoha_ppe_deinit()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68332

Introduced by commit 6abcf75 ("net: airoha: Fix schedule while atomic
in airoha_ppe_deinit()") in v6.19-rc5.
Fixed in v7.2-rc5.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [2484568a335cd7bda951c75b3a7d95ea36161ae7]
stable/6.18: [46e3bed4b071095ecc9384a7b349e1908728531f]
stable/7.1: [ad28c4f9e0eae4993cb3fde3e7cea330acd8b97c]

CVE-2026-68333: dpaa2-switch: put MAC endpoint device on disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68333

Introduced by commit 84cba72 ("dpaa2-switch: integrate the MAC
endpoint support") in v5.15-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c1eabbef7a1707635652e956e39db1269c3af2b]
stable/6.12: [680eecc850d36a280df9780496bc603fec17b2d6]
stable/6.18: [26ac2d3602347f0377fbcd5214bc28a9d735ae68]
stable/6.6: [1f4ca61b7a93de3dfa5161bcd38ecb99bb091c38]
stable/7.1: [c27694ff6748e08fcd2fdba89018439d75b8198f]

CVE-2026-68334: rxrpc: fix io_thread race in rxrpc_wake_up_io_thread()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68334

Introduced by commit 5800b1c ("rxrpc: Allow CHALLENGEs to the passed
to the app for a RESPONSE") in v6.16-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [745fb794c3e933c023af9dbb5876a5e16ad2dc71]
stable/6.18: [c9165e199f56997f2f2deb5d3ec2dfab98dfa288]
stable/7.1: [092b42cf3f6013eec43607ecbcad674723649514]

CVE-2026-68335: rds: drop incoming messages that cross network
namespace boundaries

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68335

Introduced by commit c809195 ("rds: clean up loopback rds_connections
on netns deletion") in v4.18-rc4.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5521ae71e32a8069ed4ca6e792179dc57bc43ab2]
stable/6.12: [cfb3ce07b705e486e022a2f2b1242b48f13981ff]
stable/6.18: [9591042533140dfe6608d9344806d567dcd39d02]
stable/6.6: [1e2e2d9806944fe485824d617c8b7c78116c22db]
stable/7.1: [0f8690e3869109cd5803ccb400889d20a0b54e0e]

CVE-2026-68336: bonding: fix devconf_all NULL dereference when IPv6 is disabled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68336

Introduced by commit 4e24be0 ("bonding: add new parameter ns_targets")
in v5.18-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c975de3343cdef506f2eecc833cc1f14b0401c4]
stable/6.12: [690ce66782778e8c4b1fdd79c0b0890a100e9522]
stable/6.18: [992dce02bdabbd9883255ea9b36494e34a7821d7]
stable/6.6: [2a4bad24ac5296b262ad821aa5e08bb265e6b154]
stable/7.1: [738039ad21e20ca2c5bbde2f5a4f5ad5fb718038]

CVE-2026-68337: bpf: Reject redirect helpers without a bpf_net_context

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68337

Introduced by commit 401cb7d ("net: Reference bpf_redirect_info via
task_struct on PREEMPT_RT.") in v6.11-rc1.
Introduced by commit 3625750 ("net: sched: Introduce helpers for
qevent blocks") in v5.9-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f4920d165b29052255527d8ae7619e7ec132ece]
stable/7.1: [cabfacbd5af09d3ae898ca224c4a1459e9bba15d]

CVE-2026-68338: net/packet: avoid fanout hook re-registration after unregister

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68338

Introduced by commit dc99f60 ("packet: Add fanout support.") in v3.1-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [50aff80475abd3533eef4320477037e6fcc6b56e]
stable/6.12: [0a052e0808e015e68144a9877e6ef42b952c49fa]
stable/6.18: [1bc55c29cd85818e9052f17deb287d5a11fb817f]
stable/6.6: [80ec024d53a05c60ad1d08968dcf745f10c1665c]
stable/7.1: [a885387dae7986a55bae5c77a15bdd447f64e9b9]

CVE-2026-68339: Bluetooth: btusb: validate Realtek vendor event length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68339

Introduced by commit 044014c ("Bluetooth: btrtl: Add Realtek
devcoredump support") in v6.6-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [df541cd485ff80a5ddc579d99687bc7506df9851]
stable/6.12: [400267bab0f4076088e163e58cad2bb41c3cf5e7]
stable/6.18: [8881daaafadbe7fb2b7341d16a3949114409c90c]
stable/6.6: [8de58bfa26e028f99271dde5a92107cd07f5e063]
stable/7.1: [24b0758193d70da47ef8b979153d2a181dbdf34e]

CVE-2026-68340: hwmon: occ: validate poll response sensor blocks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68340

Introduced by commit aa195fe ("hwmon (occ): Parse OCC poll response")
in v5.0-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [70e76e700fc6c46afb4e17aec099a1ea089b4a22]
stable/6.12: [54cb78eceb4e286ccd5a5c01a4632157860d47f0]
stable/6.18: [538d862cc0dbd5c732fe26d5aad98eae039e6676]
stable/6.6: [112525534ab5cff482d35897ca4ca11fd3a76f46]
stable/7.1: [b042e538e98b939fccfffc464e2c34c29f0e96ef]

CVE-2026-68341: ovpn: fix use after free in unlock_ovpn()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68341

Introduced by commit 80747ca ("ovpn: introduce the ovpn_peer object")
in v6.16-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e1ad6fe5db719874efa45b2caf9934552e09fc43]
stable/6.18: [5b96227c0e8b212b74838424c929fc889aedb555]
stable/7.1: [4cdb209f12a89c5faf9be0c45edb90ccdf65db0c]

CVE-2026-68342: ovpn: avoid putting unrelated P2P peer on socket release

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68342

Introduced by commit f6226ae ("ovpn: introduce the ovpn_socket
object") in v6.16-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b52c5103f64ee825996ca1ab8df7283cde8c5f86]
stable/6.18: [c5bf6b39be235ef578af4d39872f0c68cda3b937]
stable/7.1: [016a50379d17b886d12a4efa5211a418e035fe70]

CVE-2026-68343: smb: client: validate DFS referral PathConsumed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68343

Introduced by commit 4ecce92 ("CIFS: move DFS response parsing out of
SMB1 code") in v4.11-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f6f5ee2aa33b350c671721b965251c42cebb962e]
stable/6.12: [285bd4a5f3f156aa5869843b47a1b1380b774241]
stable/6.18: [2fdd6d196c656b376cc251e1e9ff110b3ed522e1]
stable/6.6: [5b439f39f33ec15d319ced3b025e122346fba987]
stable/7.1: [9f88a99ed511651b2dc2177d6854b2d1b8322e75]

CVE-2026-68344: usb: atm: ueagle-atm: reject descriptors that confuse
probe and disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68344

Introduced by commit e2674df ("usb: atm: ueagle-atm: wait for
pre-firmware load in .disconnect()") in v7.2-rc3.
Fixed in v7.2-rc5.

Bug introduced commit was backported to following branches.
cip/5.10 cip/6.1 cip/6.12 stable/5.10 stable/5.15 stable/6.1
stable/6.12 stable/6.18 stable/6.6 stable/7.1

Fixed status
mainline: [71132cedd1ecbc4032d76e9928c18a10f7e39b80]
stable/6.12: [9904a46401198872ab3de34fd11f383831ef3428]
stable/6.18: [d0a57f19fe2865b9747484f5f9c631f944ed9a0f]
stable/6.6: [c035b1198906dd5bd3df9a3045b59254bad1ea7a]
stable/7.1: [0cc0c4c14150bb5a16b88dd61368f96cd4caa9ce]

CVE-2026-68345: arm_mpam: guard MBWU state before adding it to garbage

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68345

Introduced by commit 41e8a14 ("arm_mpam: Track bandwidth counter state
for power management") in v6.19-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [977f52909c624210178a1247fab0b02b110c1106]
stable/7.1: [ca1f96334267ab8d47b2c9d535cdc9920fdde269]

CVE-2026-68346: ALSA: hda: cs35l41: validate and free ACPI mute object

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68346

Introduced by commit 447106e ("ALSA: hda: cs35l41: Support mute
notifications for CS35L41 HDA") in v6.7-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b597d24dc0455ae926f1053f97c2725038fc3cd]
stable/6.12: [7fea0c89ed39a13d9a31163a74f8c62de30a4ffc]
stable/6.18: [08433c71f15984ddd5f5a307cf3f0aa9b84583aa]
stable/7.1: [d5dfdf43259ad9d054052012095b1630e7366dcf]

CVE-2026-68347: iommu/amd: Fix IRQ unsafe locking in gdom allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68347

Introduced by commit 757d2b1 ("iommu/amd: Introduce gDomID-to-hDomID
Mapping and handle parent domain invalidation") in v7.0-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0db3a430d9681fdb29890bef6934cd89cd1745d0]
stable/7.1: [e0c78cdf35af3ada05f9309f4641e9f83c945dbd]

CVE-2026-68348: ASoC: tas2781: bound firmware description string parsing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68348

Introduced by commit 915f5ea ("ASoC: tas2781: firmware lib") in v6.5-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc889dfcea9294a1eae7f8e2f3573a90764ae4d0]
stable/6.12: [0ec45e80a82785ee147516fdecf5c93707dec119]
stable/6.18: [41ae2b7d37c3dd82302167496836cca9f0328374]
stable/6.6: [3ddb0d3e36507615e5ef010a879357a54870adf5]
stable/7.1: [e75ef37d83c90b09bedb601624b47e168202b226]

CVE-2026-68349: wifi: carl9170: fix buffer overflow in rx_stream failover path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68349

Introduced by commit a84fab3 ("carl9170: 802.11 rx/tx processing and
usb backend") in v2.6.37-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1a21995c2e1cc2ca6b2226cfe4f5f018370182a]
stable/6.12: [b9dfee5e63ee9b5c47be9e344ebc5bd3f43fca78]
stable/6.18: [4503829843353dbb18b879c35be1cdfc9af677b7]
stable/6.6: [5acfa18de66b6089b81c1c0bf1a3ae3c940ec39e]
stable/7.1: [21f59906ea75618fdd46a7e32754d54fbee083ea]

CVE-2026-68350: wifi: carl9170: fix OOB read from off-by-two in TX
status handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68350

Introduced by commit a84fab3 ("carl9170: 802.11 rx/tx processing and
usb backend") in v2.6.37-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3f42f1049ad80c65560d2b078ad426c3134f78d]
stable/6.12: [e8a862a3da457ddc50633c346dc645d559da09ae]
stable/6.18: [fab6ff91d5b8c4af62e2ced42fb357fa3eb9fd59]
stable/6.6: [7ed0dce8613c92111d2a3836ced2ab03190ba20e]
stable/7.1: [423c836f934814b8fdbe53b24a79d021a0ee8454]

CVE-2026-68351: wifi: carl9170: bound memcpy length in cmd callback to
prevent OOB read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68351

Introduced by commit a84fab3 ("carl9170: 802.11 rx/tx processing and
usb backend") in v2.6.37-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4cde55b2feff9504d1f993ab80e84e7ccb62791c]
stable/6.12: [500c36649f270de05a56591fcc1aaaa36687958e]
stable/6.18: [9aee949c68dc6dccbc54333537b109c53fe2079f]
stable/6.6: [f74e34e66379e487a09009a4f2d42470051672bd]
stable/7.1: [cb7a38810cf25738176dac32dec7a146b3f959cf]

CVE-2026-68352: wifi: ath6kl: fix OOB read from firmware IE lengths in
connect event

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68352

Introduced by commit bdcd817 ("Add ath6kl cleaned up driver") in v3.2-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6b47b29730de3232b919d8362749f6814c5f2a33]
stable/6.12: [d70c0a850c21b57a6f46ce363860203389bbeaa6]
stable/6.18: [33b5342d2080657054ddf89ef1199b426a37dae8]
stable/6.6: [1c690f7c4c5b37108ac8c98b94ce1b3c655a4f5e]
stable/7.1: [94e1bfcefe8264a207c2fda2febb954e70a34b42]

CVE-2026-68353: wifi: ath6kl: fix OOB read from firmware num_msg in TX
complete handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68353

Introduced by commit bdcd817 ("Add ath6kl cleaned up driver") in v3.2-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a21c89215cc18f1a97c5e5bfd1da6d4f3d44495]
stable/6.12: [289edc3c71344b89e6522891147cfb8f61b088bb]
stable/6.18: [eb636fbc443149b3501c3f97e26225ddcb314a0f]
stable/6.6: [69ac7ba3a3df6654e7daa82674575a8c4a1a63ea]
stable/7.1: [c38b0d5c661951b5dd082bdf31f8a57a0ce6e540]

CVE-2026-68354: firewire: net: Fix fragmented datagram reassembly

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68354

Introduced by commit c76acec ("firewire: add IPv4 support") in v2.6.31-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d52a13adbb8ccbab99cd3bad36804e87d8b5c052]
stable/6.12: [22e05b8ddbcf7d22c7f1598786e86635547e554d]
stable/6.18: [0177e578d7a885037b0fb82286c12e9d0360cc10]
stable/6.6: [b7d633c7c92321be98724b1d365e8ce507f2f349]
stable/7.1: [2a5aa4e9b89227d1a1690fb8d5b81e5f3b261999]

CVE-2026-68355: wifi: ath11k: fix potential buffer underflow in
ath11k_hal_rx_msdu_list_get()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68355

Introduced by commit d5c6515 ("ath11k: driver for Qualcomm IEEE
802.11ax devices") in v5.6-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f11e70629650ff6ea140984e5ce188b775b2683]
stable/6.12: [904367381a922aa2dc3e8bd2488e6c9180516c7a]
stable/6.18: [a154ca3c441a67d36b3a9ea63a4f11b06abe6223]
stable/6.6: [69a6a4f60b2da92c0bdfd9264b8ffe053f51f52a]
stable/7.1: [725c1c3a8c5d920a7d3f5887412f2ad8e95a74f5]

CVE-2026-68356: watchdog: airoha: Prevent division by zero when clock
frequency is zero

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68356

Introduced by commit 3cf67f3 ("watchdog: Add support for Airoha EN7851
watchdog") in v6.13-rc2.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bcfcd7619f277842430d197556463b401b839ee9]
stable/6.18: [8681e5addf7171602616e256a09057697dcc75ca]
stable/7.1: [57c3f5bd5be008cd5b4ff6a45b7cb90f5ca45a37]

CVE-2026-68357: watchdog: pretimeout: Fix UAF in watchdog_unregister_governor()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68357

Introduced by commit da0d12f ("watchdog: pretimeout: add panic
pretimeout governor") in v4.9-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7362ba0f9c96ac3ad6a2ca3995bd9fc9a28a8661]
stable/6.12: [0ca252720f0e38411cfec3431db9bb1aed0a412c]
stable/6.18: [7d1658b066de30f4b23afc14814d22416a971e6e]
stable/6.6: [2e47b91b9b4020fcc01def14d6b6556d66074cf4]
stable/7.1: [7993d626983cc58fbde9607333cfd2d57725c197]

CVE-2026-68358: hwmon: (nzxt-kraken3) Stop device IO before calling hid_hw_stop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68358

Introduced by commit f3b4b14 ("hwmon: Add driver for NZXT Kraken X and
Z series AIO CPU coolers") in v6.9-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f151d0143ac4e086f92f52328ebdbdc50933d8ef]
stable/6.12: [8cb282c34d582afcca7b1bae7c7bcd5204fd03d6]
stable/6.18: [305c23993e43db9a3681978691b1f9f2a1b26299]
stable/7.1: [dc73b0dfeab8dc0fe73e29c4401d032279e23efd]

CVE-2026-68359: hwmon: (nzxt-smart2) Stop device IO before calling hid_hw_stop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68359

Introduced by commit 53e68c2 ("hwmon: add driver for NZXT RGB&Fan
Controller/Smart Device v2") in v5.17-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [59d104b54b0b42e30fd2a68d24ee5c49dcc54d1e]
stable/6.12: [a2a15de020597efbff84b4281dd472e5860b7e3e]
stable/6.18: [205cff797a94757ec88ba299c8e2bf2e1e3f4bbf]
stable/6.6: [185c0880397aee9def0af5a59ea65f22f37ad658]
stable/7.1: [18d7c523891004226bccdba39dd681eca22ceb8a]

CVE-2026-68360: hwmon: (corsair-cpro) Stop device IO before calling hid_hw_stop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68360

Introduced by commit 40c3a44 ("hwmon: add Corsair Commander Pro
driver") in v5.9-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [94c87871b051d7ad758828a805215a2ec194512a]
stable/6.12: [c7757db58957ac20cdec6ce575dbd44a6375664e]
stable/6.18: [56d2deb6448378118dbe68c4fbb3fbae5f65b18c]
stable/6.6: [0975c42ed2a3bf32125a920e5d19194289126210]
stable/7.1: [1a634f464d6153dfa4d7e73a3d78236b65a64ee9]

CVE-2026-68361: hwmon: (corsair-psu) Stop device IO before calling hid_hw_stop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68361

Introduced by commit d115b51 ("hwmon: add Corsair PSU HID controller
driver") in v5.11-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ab8656548cd737b98d0b19c4253aff8d68e97f4]
stable/6.12: [c0aae8d24f5e52d6910f97d59bc624e131f3ae1a]
stable/6.18: [ec477af3a7e8d3964e62fd24ef01cdebb96b8e4e]
stable/6.6: [e6e1e0f3050d1a1a3ea1c9d6253363e87fdad67a]
stable/7.1: [bb25bd980f2d9bd34558e1b1d16636e4945baf14]

CVE-2026-68362: wifi: ath11k: fix NULL pointer dereference in
ath11k_hal_srng_access_begin

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68362

Introduced by commit 6fe62a8 ("wifi: ath11k: Add cold boot calibration
support on WCN6750") in v6.1-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e8d85672dd7e2523f774caafba8f858384e18df7]
stable/6.12: [d6bba659ac30d862ee7bab92862cd6e514f07521]
stable/6.18: [e5394605f9a985cc3a8263e610ba84b33cbe7b0c]
stable/6.6: [e517e207300edcf7f3a8f6c45f9155c0e419ffb9]
stable/7.1: [4abb4e284d8897176e91d7a3168ee29ed876bb41]

CVE-2026-68363: wifi: ath9k: hif_usb: don't dereference hif_dev after
re-arming firmware request

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68363

Introduced by commit e904cf6 ("ath9k_htc: introduce support for
different fw versions") in v4.4-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dad9f96945d77ecd4708f730c06ef54dcd8cc057]
stable/6.12: [10b0ce629123a3737b4eda50188f73bb7be7b68b]
stable/6.18: [48a69cedde7388294e4ea6fd804156cd62bc04fc]
stable/6.6: [7f184ca38a90889f3f6665ff96748b95da39dbee]
stable/7.1: [7c9046d92c4b9789c9d9d775e4fd5f34be64cb0a]

CVE-2026-68364: drm/amd/display: Fix ISM dc_lock deadlock during suspend

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68364

Introduced commit is not determined.Fixed in v7.2-rc1.


Fixed status
mainline: [3714fe242592e3699ac5e2c19d68b275a210be7d]
stable/7.1: [95776812e6b8f908563e8994d5d947b68baf68a6]

CVE-2026-68365: USB: serial: io_edgeport: cap received transmit credits

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68365

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [faaddd811c5099f11a5f52e68a6b31a5898cda4f]
stable/6.12: [64b687f9694777754285d489abbefa3784bc78da]
stable/6.18: [cbe00048b69d67c8a78293cb7681b4c9963b26c7]
stable/6.6: [ee57992c053a6d395e98ced2d4c9cc3b42d8c27a]
stable/7.1: [1e47d8228b8767c8ac722aedb388f70adeeda43d]

CVE-2026-68366: usb: gadget: uvc: clamp SEND_RESPONSE length to the
response buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68366

Introduced by commit a5eaaa1 ("usb: gadget: uvc: use capped length
value") in v3.10-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b70dc75e85ba968b7b76eebfe5d63000080b875b]
stable/6.12: [662f6c6c6ff8a6c508e1646c09cae74e28f3cca6]
stable/6.18: [1f03658f3e9b2f8fd1d1003ba389a0390b49a350]
stable/6.6: [4e116372b7a4f87df0dc0ed4b0ab5b0bb0cc5796]
stable/7.1: [c8510fbbea09ef0170b56b14dc2b5890dc75be07]

CVE-2026-68367: usb: gadget: f_tcm: synchronize delayed set_alt with teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68367

Introduced by commit c52661d ("usb-gadget: Initial merge of target
module for UASP + BOT") in v3.5-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79e2d75725c85607f8a9d87ae9cace62a19f767d]
stable/6.12: [a6eb5a0ae7cd313cfd7df78decd8f43b64c68703]
stable/6.18: [f282242906c12fd476b86757afba51f211d4f959]
stable/6.6: [3118bb872c7dff653294f193d5328a476619e04d]
stable/7.1: [4c6c6a5588b9a2f8437fb794e852d05fa60ebe53]

CVE-2026-68368: usb: gadget: f_ncm: validate datagram bounds in ncm_unwrap_ntb()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68368

Introduced by commit 427694c ("usb: gadget: ncm: Handle decoding of
multiple NTB's in unwrap call") in v6.6-rc6.
Introduced by commit 2b74b0a ("USB: gadget: f_ncm: add bounds checks
to ncm_unwrap_ntb()") in v5.9-rc3.
Fixed in v7.2-rc5.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [1febec7e47cdcd01f43fb0211094e3010474666e]
stable/6.12: [fff1059d139ef798bab917990524faaf25854ca8]
stable/6.18: [40c706a0224bde194667e3378c689b542fec4b44]
stable/6.6: [e07751d0527ccc2a1c32eb0b0b7da3b4b9b5381f]
stable/7.1: [41fd5f2fb0027d3773ae949e3247c2e0a2a7fe5c]

CVE-2026-68369: usb: gadget: printer: fix infinite loop in printer_read()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68369

Introduced by commit b185f01 ("usb: gadget: printer: factor out
f_printer") in v4.1-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c2e819be6a5c7f34344926b4bd7e3dfca58cf48a]
stable/6.12: [e03597ad9494b500344076589aeaa6c6d2d381d3]
stable/6.18: [4cde0b38cc0cb8b7dc17295801015148de37d1d2]
stable/6.6: [994afccfdcceb73be33f69a8a8ea71e260c9eca5]
stable/7.1: [e41bbbbb1740ce4d7270ab1cdeca13892d6a8d2e]

CVE-2026-68370: usb: gadget: dummy_hcd: prevent fifo_req reuse during giveback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68370

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5e5cd3654d2b5359a12ea6586120f05b28634ee]
stable/6.12: [67b589d09a96882d56842dced5698ed8dd06ce45]
stable/6.18: [e239ea91b48180ed48a86ac25643832a02c88456]
stable/6.6: [e2b2740f1242bc70b5b46da2cdbbaa419f490e59]
stable/7.1: [e24b33618231034bf01dfaff4fd3409d4b4d5b2e]

CVE-2026-68371: usb: musb: omap2430: Do not put borrowed of_node in probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68371

Introduced by commit ffbe2fe ("usb: musb: omap2430: Fix probe
regression for missing resources") in v6.2-rc1.
Fixed in v7.2-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [c947360ae63eee1c9eacc030dd6f5a53f717addf]
stable/6.12: [58d1c81c0b54a0b9aa6d6af077b09aa2f1bd2193]
stable/6.18: [0950ac52426b0ab32d3b8cf4afe1711668b19cb8]
stable/6.6: [eed56f105a7f70cbcfceb4df6deb6870fc58214d]
stable/7.1: [6c525c851e5912b9753622d796f2bc55c4913b04]

CVE-2026-68372: usb: core: port: Deattach Type-C connector on component unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68372

Introduced by commit 1111078 ("usb: Inform the USB Type-C class about
enumerated devices") in v6.7-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0b291fe117964037e0ba382eff4bb365d531c3a]
stable/6.12: [78d361e60caf1999d51bda0e1b1004f5d39fcfbc]
stable/6.18: [7714fb896ed308cf13d32d317040adc4f200b8e4]
stable/7.1: [e00109b5adf71635919248e9ab6300a662e6a3e8]

CVE-2026-68373: wifi: at76c50x-usb: avoid length underflow in at76_guess_freq()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68373

Introduced by commit 1264b95 ("at76c50x-usb: add driver") in v2.6.30-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [61a799ffd1e5a4fd3702d547828b7ff3d161468e]
stable/6.12: [bcde7249d45f52f994a9872bedf45994472ade77]
stable/6.18: [fb1b50ab699211e777dca5ccfb648788b6a6e519]
stable/6.6: [e165a1d295e7e814e13b0f92c86e5d48309509ce]
stable/7.1: [f742d9c98b5c504fc9e6744eef13a721c2aea486]

CVE-2026-68374: usb: core: sysfs: add lock to bos_descriptors_read()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68374

Introduced commit is not determined.Fixed in v7.2-rc5.


Fixed status
mainline: [4e0197fbb0eec588795d5431716a244d9ac8fa93]
stable/6.12: [c07caee449c968842a350bfefa049889923b8240]
stable/6.18: [217774e143d7b5a88739193284b6421be3978601]
stable/7.1: [ab82adf5e63b2d89ead7933ab753b9cedbe028e9]

CVE-2026-68375: bnxt_en: Handle partially initialized auxiliary devices

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68375

Introduced by commit 194fad5 ("bnxt_en: Refactor
bnxt_rdma_aux_device_init/uninit functions") in v6.10-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1cb8553c02e93e5a150cebd42f9ee3db0ece4707]
stable/7.1: [4e1caa5fdd0dea36938fe39cceb1522e9d86c937]

CVE-2026-68376: sctp: fix auth_hmacs array size in struct sctp_cookie

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68376

Introduced by commit 1f48564 ("[SCTP]: Implement SCTP-AUTH internals")
in v2.6.24-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0b5252a59383b77d1b8dbeda00b7184dd95f4d3]
stable/6.12: [d0a59ba58578e2b330fff80a44fe519f3ba7d8c7]
stable/6.18: [a8d20ba0ab518c9ccbcde258f25fc1ee6e51d5db]
stable/6.6: [0b4414e43e0861d67276031cc21401d7e87de3da]
stable/7.1: [3aa40c3bccac2312ea7cf97f329190637f972b5d]

CVE-2026-68377: net/sched: act_tunnel_key: Defer dst_release to RCU callback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68377

Introduced by commit 9174c3d ("net/sched: act_tunnel_key: fix memory
leak in case of action replace") in v5.0-rc3.
Fixed in v7.2-rc4.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [f1f5c8a3955f8fda3f84ed883ac8daa1847e724c]
stable/6.12: [2200a00ff247f70f5dcdb4e6f14b0d48ddac5467]
stable/6.18: [fed1b1ddab41a0e7a462ac690a0c8af6ff793624]
stable/6.6: [531dbb5bb98e52ad26be7e90f9f8bec707c5bd0e]
stable/7.1: [2791a501da508b704a617b4dba29db54a65bc9f7]

CVE-2026-68378: dpll: fix NULL pointer dereference in
dpll_msg_add_pin_ref_sync()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68378

Introduced by commit 58256a2 ("dpll: add reference sync get/set") in v6.17-rc1.
Fixed in v7.2-rc4.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [d2e914a4a0d0f753dbae830264850d044026167c]
stable/6.12: [66fbe0499ef517ab161b96c49886a891851f6481]
stable/6.18: [51c2fcc4cd2e4c52bd1970558f6e5356fdc51154]
stable/7.1: [4b3e6b9fdaeb40c6a2f7c41db3888b6ee628bdd2]

CVE-2026-68379: tcp: fix TIME_WAIT socket reference leak on PSP policy failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68379

Introduced by commit 659a289 ("tcp: add datapath logic for PSP with
inline key exchange") in v6.18-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c1931a81122c3cdc4c89448fe0442c69e21c0d5]
stable/6.18: [e666af5dcc905ba694745963174d232deb478c55]
stable/7.1: [374742a961becbbfc7fbfd1382d978a05e492741]

CVE-2026-68380: accel/amdxdna: Fix use-after-free of mm_struct in job scheduler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68380

Introduced by commit aac2430 ("accel/amdxdna: Add command execution")
in v6.14-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [faebb7ba1ac65fa5810b640df02ce04e509fdc11]
stable/6.18: [6875ee2bef48f5d9f045d81a8a4d68893f768a8a]
stable/7.1: [e8fadbffc19a233d1eedebfb8df0f522d1388280]

CVE-2026-68381: ksmbd: pin conn during async oplock break notification

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68381

Introduced by commit 3aa660c ("ksmbd: prevent connection release
during oplock break notification") in v6.14-rc7.
Fixed in v7.2-rc4.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [aa5d8f3f96aa11a4a54ce993c11ce8af11c546f9]
stable/6.12: [793e1c7041b93af96ff87e678329bc16aee7ba88]
stable/6.18: [6ecb252efa0b413ac3d9979fb4eec247f8fc1258]
stable/6.6: [0f72fc9659d7f585460d43c158055df5afdcffb6]
stable/7.1: [14062c74e5b25c27edcff7a2fe0dc701c930b372]

CVE-2026-68382: drm/xe/guc: Hold device ref until queue teardown completes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68382

Introduced by commit 2d2be27 ("drm/xe: fix UAF around queue
destruction") in v6.12-rc2.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b7e60184f4b22e893d4ae95234d5f26261a430c]
stable/7.1: [03d6f83979b0d75a0b0893dfe1735ec93facf515]

CVE-2026-68383: drm/xe/guc: Keep scheduler timeline name alive

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68383

Introduced by commit 6bd90e7 ("drm/xe: Make dma-fences compliant with
the safe access rules") in v6.17-rc1.
Fixed in v7.2-rc4.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [299bc6d50b1bed7d1f408391736712f01a0855e2]
stable/7.1: [77fd62412431e8c80ef2ad61466bc76fe425f80a]

CVE-2026-68384: drm/xe/vf: Fix VF CCS attach/detach race with in-flight BO moves

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68384

Introduced by commit 864690c ("drm/xe/vf: Attach and detach CCS copy
commands with BO") in v6.18-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56441f9e08ad68697295b8835266d2bc48ab59b5]
stable/6.18: [35ba43b541117bfb595e4b807ba447cf4335cc7d]
stable/7.1: [f2ebfd5cc87f1393a30c8b8b0a6c20cb22cffa97]

CVE-2026-68385: s390/checksum: Fix csum_partial() without vector facility

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68385

Introduced by commit dcd3e1d ("s390/checksum: provide
csum_partial_copy_nocheck()") in v6.9-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4bb06b60d982355e22647b3d12d6619419f8c1fa]
stable/6.12: [5fc0a2a6eeb99cac991242bb48796c7749ce3261]
stable/6.18: [1d9a2f01b3c4e5c88e06b2db4b5460c2ec884722]
stable/7.1: [898bb2814f38399108bdd2113f38d97383a7036a]

CVE-2026-68386: bpf, sockmap: Reject unhashed UDP sockets on sockmap update

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68386

Introduced by commit 0c48eef ("sock_map: Lift socket state restriction
for datagram sockets") in v5.15-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66efd3368ae10d05e08fbe6425b50fdec7186ac7]
stable/6.12: [17b7ef6b86112a4e61cee1e9009a4b318e3225c5]
stable/6.18: [250474c69bc3fc48a5fc21d7c349f279caad947a]
stable/6.6: [7ffe529e7127411806c8692fb1490f552c629dc2]
stable/7.1: [8692655da369961128658cf8539334b6a960ecb0]

CVE-2026-68387: can: raw: add locking for raw flags bitfield

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68387

Introduced by commit 890e519 ("can: raw: use bitfields to store flags
in struct raw_sock") in v6.18-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e5185c090589f4146d728ab36417d8a5419f127]
stable/6.18: [00ba4bf8798242253fefc1fa6a78db1d445fd024]
stable/7.1: [57791aab1129c9405f84bb0882de58967d8b44cd]

CVE-2026-68388: smb/client: handle overlapping allocated ranges in fallocate

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68388

Introduced by commit 966a3cb ("cifs: improve fallocate emulation") in v5.14-rc1.
Fixed in v7.2-rc4.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [b09ae45d85dc816987a71db9eebc54b0ae288e94]
stable/6.12: [377fe3e583e46369ee1004d5cfe12271d6589a68]
stable/6.18: [7e08ab7a061b17ac1989a225c6afb53f44a86808]
stable/6.6: [437637f5ff3f573b2edf8571de91fb00a21eb4e6]
stable/7.1: [a4a09e5142835633fffbde68bd0a039ba4d4bf97]

CVE-2026-68389: Bluetooth: hci_qca: Clear memdump state on invalid dump size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68389

Introduced by commit 06d3fdf ("Bluetooth: hci_qca: Add qcom
devcoredump support") in v6.6-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf587a10c33e5571a299742e45bc18960b9912e7]
stable/6.12: [069258d5111eed9ac9586bee42d03d38e2975715]
stable/6.18: [cefb44c367b2b52e50f97bc8526d39df9bcf5e60]
stable/6.6: [5a3945e8dea6c9a8ec9e981169ac9487e1d6ad6a]
stable/7.1: [2363a757694752426fc47f3eadde15cf5f791fa5]

CVE-2026-68390: Bluetooth: hci_sync: hold hdev->lock for hci_conn_params lookups

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68390

Introduced by commit c530569 ("Bluetooth: hci_core: Introduce
HCI_CONN_FLAG_PAST") in v6.19-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c363202ec841df36421ec280eea3d5f94f556143]
stable/7.1: [8d892bec1dd134761cabec6ba23fe315d0f20f98]

CVE-2026-68391: Bluetooth: mgmt: hold reference for hci_conn in
mgmt_pending_cmds

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68391

Introduced by commit 7b445e2 ("Bluetooth: MGMT: Fix holding hci_conn
reference while command is queued") in v6.0-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da55f570191d5d72f10c607a7043b947eb05ea46]
stable/6.12: [f915e74b6f18293d1d69a2a3305ef321ff7c0172]
stable/6.18: [d5b3b484b62bb0f4542e7622789d28871626cdf0]
stable/6.6: [b56f2ecafc08f372bf0529f9c4f3f429cb1702dc]
stable/7.1: [ecdcb55ea1c01dda074406f38058785a69526734]

CVE-2026-68392: Bluetooth: mgmt: fix locking in unpair_device/disconnect_sync

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68392

Introduced by commit 227a0cd ("Bluetooth: MGMT: Fix not generating
command complete for MGMT_OP_DISCONNECT") in v6.11-rc7.
Fixed in v7.2-rc4.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [16cd66443957e4ad42155c6fec401012f600c6f8]
stable/6.12: [579faba5ede6df6b7f36777c431dc8dcf9d272e7]
stable/6.18: [ca58ad287bfc5b9d31a72ecb8650289df2b57250]
stable/6.6: [8bc83f9ef6789571f399ff631a2a14a12b6d8585]
stable/7.1: [b11511006f9e17000de3f4cadee451364f658ca3]

CVE-2026-68393: Bluetooth: hci_sync: extend conn_hash lookup critical sections

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68393

Introduced by commit 6d0417e ("Bluetooth: hci_conn: Fix not setting
conn_timeout for Broadcast Receiver") in v6.15-rc5.
Fixed in v7.2-rc4.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [d5efd6e4b8b0634af6843178fe1a7dd2b2178a3d]
stable/6.18: [83b7e67698d0b93f685875ce82c8d335436834f7]
stable/7.1: [38326774df6198df0cc2744cc73bf77cb741c538]

CVE-2026-68394: Bluetooth: MGMT: revalidate LOAD_CONN_PARAM queued update

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68394

Introduced by commit 0ece498 ("Bluetooth: MGMT: Make
MGMT_OP_LOAD_CONN_PARAM update existing connection") in v6.11-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2bf282f8f715f5d05d6f4c49ffb3bd241c5e667e]
stable/6.12: [65ce6fe1b92112ba9064ded932c03180da3dd230]
stable/6.18: [57059ff14d81df4a970b2ea8d8f54431bb91a025]
stable/7.1: [b82802b5ab26a7c69fc2e7a0f2baa3c13a6c21aa]

CVE-2026-68395: ata: sata_dwc_460ex: enable SATA interrupts only after
IRQ handler is registered

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68395

Introduced by commit 6293600 ("[libata] Add 460EX on-chip SATA driver,
sata_dwc_460ex") in v2.6.36-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4bbc16a353a98023e5ddfca7c1fc0e49971cf4d0]
stable/6.12: [23d4c50fdc0dfe3ad4f9647a3b7d486de807dcda]
stable/6.18: [daa80b422ed920a3c0c45153020b0ad7af7fb5a5]
stable/6.6: [fbe7df5d3a3aed2456667a4825e4ff98d6df6ca4]
stable/7.1: [5d0797d6940b8dc894f950c52f7af0b42cb55ed0]

CVE-2026-68396: scsi: core: wake eh reliably when using scsi_schedule_eh

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68396

Introduced by commit 6eb045e ("scsi: core: avoid host-wide host_busy
counter for scsi_mq") in v5.5-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dccf3b1798b70f94e958b3d00b83010399e6fb05]
stable/6.12: [866efe8ae8b8b4d095501001b026e1022734be28]
stable/6.18: [c7a15091237205770bd9bd4d14eb1f3029d97a34]
stable/7.1: [24d7abda6a2a19e113334accc10029f6a4b57257]

CVE-2026-68397: net/iucv: take a reference on the socket found in
afiucv_hs_rcv()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68397

Introduced by commit 3881ac4 ("af_iucv: add HiperSockets transport")
in v3.2-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4fa349156043dc119721d067329714179f501749]
stable/6.12: [1801cb20a5025a787d6853e19c38db138344b4b4]
stable/6.18: [c75a950e77356e526672cba4584080c6c8b793b6]
stable/6.6: [4dc0e63abf8bc7ba8892e617c1fb8b204361e022]
stable/7.1: [5595ea59cdf29182cf6a270cacc1426c57b603de]

CVE-2026-68398: ppp: defer channel free to an RCU grace period to fix
pppol2tp RX UAF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68398

Introduced by commit ee40fb2 ("l2tp: protect sock pointer of struct
pppol2tp_session with RCU") in v4.15-rc1.
Fixed in v7.2-rc4.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [ec4215683e47424c9c4762fd3c60f552a3119142]
stable/6.12: [3ab32218d7182705dae5c86f13925f458072da2c]
stable/6.18: [c9574b8a8edeb4edd3ac6472c27ef7184bdb2baa]
stable/6.6: [4bb84e964ff0fe0a171c965362de72f9820dbce9]
stable/7.1: [06213c85d8c0994f786c093b8b2a517987943ca6]

CVE-2026-68399: bpf: Fix UAF in sock clone early bailouts

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68399

Introduced by commit 6ac99e8 ("bpf: Introduce bpf sk local storage")
in v5.2-rc1.
Introduced by commit f12dd75 ("bpf: net: Set sk_bpf_storage back to
NULL for cloned sk") in v5.2-rc6.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7cbd0c4cebe4c9f678d15e6b9ba975e1155a107f]
stable/7.1: [14b49b5ab29979552c219a09e569b424fbbf4a6e]

CVE-2026-68400: firmware: arm_ffa: Fix Endpoint Memory Access
Descriptor offset calculation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68400

Introduced by commit 1135805 ("firmware: arm_ffa: Update memory
descriptor to support v1.1 format") in v6.7-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b4d961351aa84fdf0148783fb1f3a1391b8a0adb]
stable/6.18: [b39b08e6bee812514b449dc874076890e6b871a0]
stable/7.1: [8ef18f0ab3c0ec1eac77289f5a542bd96a8a6d66]

CVE-2026-68401: firmware: arm_ffa: Fix out-of-bound writes in
ffa_setup_and_transmit()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68401

Introduced by commit 111a833 ("firmware: arm_ffa: Set reserved/MBZ
fields to zero in the memory descriptors") in v6.4-rc4.
Fixed in v7.2-rc4.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [3383ffb7ef937317361713ffcc21921a7848511a]
stable/6.18: [cf5708c9d78c98214c62b1e5d049cd527a543b8e]
stable/7.1: [27abdaf0c5c89b06694e4c3d8318e8d6a60c1d1b]

CVE-2026-68402: wifi: cfg80211: bound element ID read when checking
non-inheritance

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68402

Introduced by commit f7dacfb ("cfg80211: support non-inheritance
element") in v5.2-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb8afea4655ff004fa7feee825d5c79783525383]
stable/6.12: [84bd907361c56fbd5523eceb2682cb39da059bd5]
stable/6.18: [11ac7a5e75f5132f1778e0c60981d30dc29fb869]
stable/6.6: [20c308d9a57722801961f816395bf825f7bde6bc]
stable/7.1: [ddf2773bcc8e49a43c561f22ec1e7924215d7947]

CVE-2026-68403: wifi: brcmfmac: initialize SDIO data work before cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68403

Introduced by commit 9982464 ("brcmfmac: make sdio suspend wait for
threads to freeze") in v4.1-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a665946e0407a05a3f81bd56a08553c446498e0]
stable/6.12: [6bd21ec8549a5854dd64204a66289952917a924c]
stable/6.18: [5c342437ea44bb829680ca9e4f683dd5b325b219]
stable/6.6: [f50a2b9e57a751e70ae9a272875d80d39eaccd6a]
stable/7.1: [c73c3fc1c7ca5a927639f0884624cb244ba791e4]

CVE-2026-68404: wifi: cfg80211: use wiphy work for socket owner autodisconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68404

Introduced by commit bd2522b ("cfg80211: NL80211_ATTR_SOCKET_OWNER
support for CMD_CONNECT") in v4.11-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c2ed186bbe14304415476d6707b747dddcd8583]
stable/7.1: [6d6123fef5a4af175cc6b6b12a03dd0f3c240b79]

CVE-2026-68405: wifi: mac80211: free AP_VLAN bc_buf SKBs outside IRQ lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68405

Introduced by commit 397a7a2 ("mac80211: free ps->bc_buf skbs on vlan
device stop") in v3.9-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f3858d5b1432098c1936e03d6e03dd0e33facf60]
stable/6.12: [962f755a47d7ec3bbf6c709697d7f4c5f798441d]
stable/6.18: [a424985c3ef2a87ce6057a853e18d0c441a86be8]
stable/6.6: [be9dfcb0654c1f6c0fce7ba2a909683bb6f1e0ef]
stable/7.1: [4b8abf43bf34791c99d99dc3be13f897adefc461]

CVE-2026-68406: wifi: cfg80211: validate PMSR FTM preamble range

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68406

Introduced by commit 9bb7e0f ("cfg80211: add peer measurement with FTM
initiator API") in v5.0-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [36230936468f0ba4930e94aef496fc229d4bb951]
stable/6.12: [922d71fbaf99c1d5318151a0cb0a42ad448d07d9]
stable/6.18: [cfbda103aeae61071a122a6fc2bfe98cffbd7165]
stable/6.6: [44ea65d779e2d23b2264fea6af2d0c666a3ec9fb]
stable/7.1: [58320cb47df2accc7a20bb72c0150280732fa58f]

CVE-2026-68407: wifi: nl80211: free RNR data on MBSSID mismatch

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68407

Introduced by commit dbbb27e ("cfg80211: support RNR for EMA AP") in v6.4-rc1.
Fixed in v7.2-rc4.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [07a95ec2b54774201fdf4ef7ffb0ca2ab19ed29c]
stable/6.12: [312c8b9d7836ef58e552619a8c19be08b04032bb]
stable/6.18: [fb052a6e2fa866384d8edc237746583ec94c15af]
stable/6.6: [fa9592ef7de11f8c7042315d9bc20e91a97f679e]
stable/7.1: [6f919f29e9b75793104709987131b8d910d7800a]

CVE-2026-68408: wifi: cfg80211: convert pmsr_free_wk to wiphy_work to
fix deadlock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68408

Introduced by commit 6dccbc9 ("wifi: cfg80211: cancel pmsr_free_wk in
cfg80211_pmsr_wdev_down") in v7.0-rc5.
Fixed in v7.2-rc4.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [2b0eab425e1f658d8fe1df7590e3b9af5959505e]
stable/6.12: [21512b5f7a74fd18c996c22e6854efe57d570816]
stable/6.18: [133684982dd0c24359fcc641d19d89cc17d6e5ef]
stable/7.1: [0a77d9fb4d5c0e01306cd406ffdee8f1fe955c0e]

CVE-2026-68409: wifi: mac80211: defer link RX stats percpu free to RCU

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68409

Introduced by commit c71420d ("wifi: mac80211: RCU-ify link STA
pointers") in v6.0-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa2eb62525188269cdd402a583b9a8ed94657ff0]
stable/6.18: [2aa1789880fa5e41049b0f6a74a4fc2fa1997610]
stable/7.1: [a03fceae0c65b31ce31840dac5e26684ceecb65b]

CVE-2026-68410: wifi: libertas: fix memory leak in helper_firmware_cb()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68410

Introduced by commit 1dfba30 ("libertas: move firmware lifetime
handling to firmware.c") in v3.13-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63c2391deefb31e1b801b7f32bd502ca4808639b]
stable/6.12: [eaeb1d74a47fc4864f2c754c0b9d654a9b7dc55c]
stable/6.18: [6cda91bbb8dc3d22ef0323008a12dcf73a5129da]
stable/6.6: [d497b7566e74920acfe283dd6b2cbf1682890796]
stable/7.1: [644640cde2fb216e6567de5eee780a38dbc95928]

CVE-2026-68411: wifi: mac80211_hwsim: clamp virtio RX length before skb_put

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68411

Introduced by commit 5d44fe7 ("mac80211_hwsim: add frame transmission
support over virtio") in v5.7-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [10a2b430f8f06ae14b9590b6f6faa6b588ef0654]
stable/6.12: [fade308845c89f784da8a6780c1e77258488f1b6]
stable/6.18: [6dc76371a9a360c29de00df5b11563102d9d675a]
stable/6.6: [82c5a30a66e2a7337d99476c67d6fc1a99c4250e]
stable/7.1: [99dc05c75acc3c8cde8d89c5371f4b569de5ac62]

CVE-2026-68412: wifi: cfg80211: Fix an error handling path in
cfg80211_wext_siwscan()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68412

Introduced by commit 2a51931 ("cfg80211/nl80211: scanning (and
mac80211 update to use it)") in v2.6.30-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c6659f66d4ee4841aafae5659d2ef5e4c5c63cb6]
stable/6.18: [e67dc2b8d5ac4bb804000b6732768a9ae678912f]
stable/7.1: [99d2e850c643e2c70fa165b722a1ad28347a8b3a]

CVE-2026-68413: wifi: ipw2100: fix potential memory leak in
ipw2100_pci_init_one()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68413

Introduced by commit 2c86c27 ("Add ipw2100 wireless driver.") in v2.6.20.16.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0d388f62031dbabcba0f44bb91b59f10e88cac17]
stable/6.12: [836a19c654dcb1b01878a70090af016fbd0fd7e5]
stable/6.18: [f442e581a88937671a22ceb3806c186265ef6254]
stable/6.6: [f75b9a2a9d8334ae0f9c5e47df7b31f7aeb1fdbe]
stable/7.1: [7cbda50eebcd9aa00b0de382f776287cf7a36cf8]

CVE-2026-68414: wifi: cfg80211: cancel sched scan results work on unregister

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68414

Introduced by commit 807f8a8 ("cfg80211/nl80211: add support for
scheduled scans") in v3.0-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [edf0730be33696a1bd142792830d392129e495cc]
stable/6.12: [308ffdf575560d7e7b8b21f1e3ca6276630f73bf]
stable/6.18: [9293574ac208d18c11073538851fb69355beb3b5]
stable/6.6: [3368457b4871ae8f0f88d19c9a3e6270e850ede6]
stable/7.1: [b119c70b24776c8ab2a2c0515397b3b0ad4e66cd]

CVE-2026-68415: xfrm: clear mode callbacks after failed mode setup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68415

Introduced by commit 4b3faf6 ("xfrm: iptfs: add new iptfs xfrm mode
impl") in v6.14-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2538bd3cd1ff5af655908469544ac7b7ae259386]
stable/6.18: [9845a35986a658816f7752f7ebd7c455a4c7dfdf]
stable/7.1: [c37a079230128a5237f45fb4e181bc069a5c2955]

CVE-2026-68416: mtd: fix double free and WARN_ON in add_mtd_device() error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68416

Introduced by commit 19bfa9e ("mtd: use refcount to prevent
corruption") in v6.6-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9d4af746af8ce27eefc2338b2feaa1e01f28b6c3]
stable/6.12: [e1e96aca1bdf391e2f49531c270ffc134e5b49a5]
stable/6.18: [f98ae09c727dcf34f745c875661c64b642e4abfa]
stable/6.6: [ffe21a3545b439e7b11578a701c22a847c149561]
stable/7.1: [820f983d641937a787e841ee4b93501f69f5683e]

CVE-2026-68417: RDMA/siw: publish QP after initialization

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68417

Introduced by commit f29dd55 ("rdma/siw: queue pair methods") in v5.3-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bb27fcc67c429d97f785c92c35a6c5adebb05d7f]
stable/6.12: [74912ad168f87d6b2b670a87987bb302d6e64aa1]
stable/6.18: [fcc9d50022bcdb1f9f7ed04955c72b4a7355af3d]
stable/6.6: [36e91a58397ca8c978e38a0bf389f0c6113fa8ca]
stable/7.1: [52f9fcb191143448df55fd215ff09c5207fed43e]

CVE-2026-68418: RDMA/irdma: Prevent user-triggered null deref on QP create

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68418

Introduced by commit b48c24c ("RDMA/irdma: Implement device supported
verb APIs") in v5.14-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b9b0889071569d43623c260074e159cd8f26adb1]
stable/6.18: [ec675b4cdfd378d8c9dd8c93126c024f2469bd79]
stable/7.1: [728211c815f6eef28dd3df2a5b6297483185aa20]

CVE-2026-68419: RDMA/irdma: Prevent rereg_mr for non-mem regions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68419

Introduced by commit 5ac388d ("RDMA/irdma: Add support to re-register
a memory region") in v6.7-rc1.
Fixed in v7.2-rc4.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [a846aecb931b4d65d5eafa92a0623545af46d4f2]
stable/6.12: [b5029e91c63406e4f4c8d58161048b41b6f0bd8c]
stable/6.18: [ca1c29f05274b737dc964e28b97803750d7cf7ec]
stable/6.6: [fb46d134e1b8690bed2da9005b36d32d2efd34ac]
stable/7.1: [dbaa37e060918c45517786e37ecab0f300b48fa9]

CVE-2026-68420: xfrm: reject optional IPTFS templates in outbound policies

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68420

Introduced by commit d1716d5 ("xfrm: add generic iptfs defines and
functionality") in v6.14-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea528f18231ec0f33317be57f8866913b19aba6e]
stable/6.18: [d7fc6f351c478586980a521d63b0214d9c055e78]
stable/7.1: [9333f4b6f44858fc98eb12bf26b8d2959eb975d5]

CVE-2026-68421: sched_ext: Don't warn on core-sched forced idle in
put_prev_task_scx()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68421

Introduced by commit 7c65ae8 ("sched_ext: Don't call
put_prev_task_scx() before picking the next task") in v6.12-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b7d9c359e5cf867f7eb23df3bb1c6b9e58af24da]
stable/6.18: [2907e9d0f05b506dfd58aec589a23042a56ef36b]
stable/7.1: [e2f188cdbf8312289532c36eb4e9eb1c9544d43a]

CVE-2026-68422: btrfs: fix root leak if its reloc root is unexpected
in merge_reloc_roots()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68422

Introduced by commit 24213fa ("btrfs: do proper error handling in
merge_reloc_roots") in v5.13-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce6050bafb4e33377dc17fcc357736bfc351180c]
stable/6.12: [72f673d1c1deb819554d3e7e154f6d84301eb735]
stable/6.18: [60a23d4ea169e27403f3bb023bb98036797c0206]
stable/6.6: [b3d39b03799600c76c33486e2d29b73a771023db]
stable/7.1: [7591d1727067d6063247901ad25c4bdc4e5695c4]

CVE-2026-68423: mtd: virt_concat: fix use-after-free in
mtd_virt_concat_destroy()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68423

Introduced by commit 43db636 ("mtd: Add driver for concatenating
devices") in v7.1-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b45d7836b9526b8776af5f29219615be9417230]
stable/7.1: [d36520e5da8bf87265b334def0daaadf3603cc62]

CVE-2026-68424: mtd: virt_concat: fix use-after-free in
mtd_virt_concat_destroy_joins()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68424

Introduced by commit 43db636 ("mtd: Add driver for concatenating
devices") in v7.1-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [75c0c09541b49daa08fddbc2c18c2232f4eab7d8]
stable/7.1: [4d91d783f93430c0efa834daff6640c07d87ebbc]

CVE-2026-68425: IB/mad: Drop unmatched RMPP responses before reassembly

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68425

Introduced by commit fa619a7 ("[PATCH] IB: Add RMPP implementation")
in v2.6.13.4.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2e52d610b9b09694261632340b801a421e0b0c5]
stable/6.12: [6e1bd7f590b0ccfee07f7fe1d48b92059bd37d72]
stable/6.18: [98d2d468b4faa1fdc68c0c6c238389906ee3490c]
stable/6.6: [dfa535c94406c03d3f0c869ef3ba5528e395737c]
stable/7.1: [ad9c9ad3204f63a46f0f7de29687a8e512f05e29]

CVE-2026-68426: xfrm: fix stale skb->prev after async crypto steals a
GSO segment

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68426

Introduced by commit f53c723 ("net: Add asynchronous callbacks for
xfrm on layer 2.") in v4.16-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f4c3919baf0944ad96580467c302bc6c7758b00]
stable/6.18: [33e1b0d25ca0d2818c635ff80e6aa0d295e08a98]
stable/7.1: [bbca7cc3b2b4b10afbfee99b81d9ee78f5423046]

CVE-2026-68427: gpu: host1x: Fix use-after-free in
host1x_bo_clear_cached_mappings

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68427

Introduced commit is not determined.Fixed in v7.2-rc4.
Affected code was added by 3cbf5e3 ("gpu: host1x: Allow entries in BO
caches to be freed") in v7.2-rc1.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.6 stable/7.1

Fixed status
mainline: [266cddf7bd0f6c79b6c0633aef742a22bf70265b]
stable/6.12: [5b7e5f84d3d4cea10c3764d2da274810a7934228]
stable/6.18: [5f4de3c717d34a24d555af581947742980778c02]
stable/6.6: [abeff53233b984571b87582bb588b4b38ef4ea50]
stable/7.1: [b773faa32b0a98c3eb2b50d96de631681e5d1157]

CVE-2026-68428: KVM: x86/mmu: Fix use-after-free on vendor module reload

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68428

Introduced by commit cb498ea ("KVM: Portability: Combine kvm_init and
kvm_init_x86") in v2.6.25-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [52f2f7c30126037975389aa04d24c506a5177c35]
stable/6.12: [32b9f89ed9e6d7a45075d64089c254a7f6e13695]
stable/6.18: [ec9daa8fd1b6f45545c9839dca55bd867fad9e13]
stable/6.6: [6f4be73880302d5642c83a0813fdfe1f5fd4b6e3]
stable/7.1: [43cfb20d62ffe49626d62beecfc32eb6f262191c]

CVE-2026-68429: drm/dp_mst: Handle torn-down topology gracefully in
drm_dp_mst_topology_queue_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68429

Introduced by commit dbaeef3 ("drm/dp_mst: Add a helper to queue a
topology probe") in v6.12-rc1.
Fixed in v7.2-rc2.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [613059875958e7b217b250ed14c3b189f9488421]
stable/6.12: [4ed6d08c4a59ee6a8cb806347f6d9873de5d229e]
stable/6.18: [8c6d84a54823cd839e6ce22af559925f1320c310]
stable/6.6: [b1d05cc61dfa6c4bd5e67855bec6a03e955f512d]
stable/7.1: [afdff9103818656627920c21822e48a6dae2906f]

CVE-2026-68430: drm/amdgpu/gfx8: drop unecessary BUG_ON()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68430

Introduced commit is not determined.Fixed in v7.2-rc2.
Affected code was added by 4e638ae ("drm/amdgpu/gfx8: add support
kernel interface queue(KIQ)") in v4.11-rc1.

Fixed status
mainline: [84a1a8a952ab4b8c23c5dd1f2eea4049cb4914f5]
stable/6.12: [2404600dca5c0979485c6f2d9c62bd356a98870a]
stable/6.18: [f70bd5235d9efc2ee2f70293eea51888c5f2a54d]
stable/6.6: [ab05af6c345bc8460052c60de657ce6d4a2386f7]
stable/7.1: [db85aa861b8214fa0d1d8405c01488f604a455a0]

CVE-2026-68431: ksmbd: validate minimum PDU size for transform requests

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68431

Introduced by commit 368ba06 ("ksmbd: check the validation of pdu_size
in ksmbd_conn_handler_loop") in v6.4-rc6.
Fixed in v7.2-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [cfc0b8e5080aec87700774e8568765eaa4b7b92b]
stable/7.1: [b62c510f59803f82f9b4c76ead2a56833b2984c7]

CVE-2026-68432: vxlan: require CAP_NET_ADMIN in the device netns for changelink

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68432

Introduced by commit 8bcdc4f ("vxlan: add changelink support") in v4.11-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a61bd9637f3d929aa846e4eb3d98b48c26fcb0e]
stable/6.12: [32d10c46bfde3e9b274e9e1bd6399d0ebea8f60f]
stable/6.18: [730c7e5fea7f06e0cdf21c547222ec93234fd1d6]
stable/6.6: [b3793d7dccb192ffff29894d11824db6251acdd5]
stable/7.1: [e8ad0d311e225939a9a6c745d6cc384c7364ec87]

CVE-2026-68433: libceph: bound get_version reply decode to front len

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68433

Introduced by commit 513a824 ("libceph: mon_get_version request
infrastructure") in v3.16-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3c32939fa0e3ee9b883b9a0fd1972c5c444e3d0]
stable/6.12: [d60de8253c85a02d0e6194b0735e7a562981a04c]
stable/6.18: [4e7ebfaa0d14cf50e44041bfde38070d6dbc019f]
stable/6.6: [340e0386aa39da181015bee38f309018c335ce16]
stable/7.1: [0d934c934ec746d53fc7e4f53239792647bbae63]

CVE-2026-68434: serial: 8250_mid: Fix NULL function pointer
dereference on DNV/ICX-D/SNR platforms

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68434

Introduced by commit b1b4efe ("serial: 8250_mid: Disable DMA for
selected platforms") in v7.2-rc3.
Fixed in v7.2-rc5.

Bug introduced commit was backported to following branches.
cip/5.10 cip/6.1 cip/6.12 stable/5.10 stable/5.15 stable/6.1
stable/6.12 stable/6.18 stable/6.6 stable/7.1

Fixed status
mainline: [7fb13fd7e9a59a37cd911efff83abe19e3ee029d]
stable/6.12: [600dcd548fb2b00a69f447684f52ba45d5a3540e]
stable/6.18: [b2a3eeb57ba24f8a0e34a69d40adcc63e5b9ca56]
stable/6.6: [1096397c31f6bffa95e77bdd18fbca085be83e10]
stable/7.1: [8cbad52ccfa6a7f089cfab34979bc6cc3bff25be]

CVE-2026-68435: LoongArch: Fix address space mismatch in kexec command
line lookup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68435

Introduced by commit 4a03b2a ("LoongArch: Add kexec support") in v6.1-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [485ed44db5694d8d2e5027f63ad608e705286f30]
stable/6.18: [a94d6726ec8680a2b0c453fc782a543f68a1ea06]
stable/7.1: [7a54e0cbaad4a5a09e7cc7a4f05d181048e98ca7]

CVE-2026-68436: drm/amd/display: use kvzalloc to allocate struct dc

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68436

Introduced commit is not determined.Fixed in v7.2-rc2.


Fixed status
mainline: [75050390151a14802be433c3856ddcb483cecd24]
stable/7.1: [dbad70d40cad9c5e7586953275287fe7531fb811]

CVE-2026-68437: drm/imagination: Fit paired fragment job in the correct CCCB

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68437

Introduced by commit eaf01ee ("drm/imagination: Implement job
submission and scheduling") in v6.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4baf9e70cb756d78dd56419f8baee2978a72d0c3]
stable/6.12: [15a9863929206911a08b6f62de9c5da6931dbc9e]
stable/6.18: [e2c29d51c0f65459ae5bbf7ccc302df4c359c473]
stable/7.1: [4ddf82c18ee4b3d14ec7fa002c4039b46c961abc]

CVE-2026-68438: smp: Make CSD lock acquisition atomic for debug mode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68438

Introduced by commit b0473dc ("smp: Improve smp_call_function_single()
CSD-lock diagnostics") in v7.1-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [35551efb155e3b83445a6c3f66cb498d5efc182c]
stable/7.1: [282d220bae5fbfc90cf0e3d5b5e42c00ad79f989]

CVE-2026-68439: wifi: mt76: mt7925: fix possible NULL-pointer deref in
mt7925_mcu_bss_he_tlv()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68439

Introduced by commit c948b5d ("wifi: mt76: mt7925: add Mediatek Wi-Fi7
driver for mt7925 chips") in v6.7-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8d1b6738c1ab48c086b17e7994034aca94258931]
stable/6.12: [42288cca984fb72ad3ebe43d4e7fdce9dcabfdb5]
stable/6.18: [313343ab8cab7417973e7bdd43d3c3e93044b447]
stable/7.1: [856f1588a2590e70b119e76c15315615a36aebc8]

CVE-2026-68440: net: txgbe: fix heap overflow when reading module EEPROM

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68440

Introduced by commit 9b97b6b ("net: txgbe: support getting module
EEPROM by page") in v6.19-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6a905a71fd43ce8b45f05044b11491337f232c9d]
stable/7.1: [febcced6958158e7e90a55a8567b3f5c3639c0b9]

CVE-2026-68441: net/sched: Handle TC_ACT_REDIRECT from qdisc filter chains

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68441

Introduced by commit 27b29f6 ("bpf: add bpf_redirect() helper") in v4.4-rc1.
Introduced by commit 401cb7d ("net: Reference bpf_redirect_info via
task_struct on PREEMPT_RT.") in v6.11-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec48b3be2c8595dd290be883dbd4fb8b2f9f5d5e]
stable/7.1: [c8fd74445e86f88096d2f6cf0f9e4d54d8ed1781]

CVE-2026-68442: btrfs: don't propagate EXTENT_FLAG_LOGGING to split extent maps

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68442

Introduced by commit f86f7a7 ("btrfs: use the flags of an extent map
to identify the compression type") in v6.8-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5eff4d5b17fa1950e80bfd1ba43dc0699e61a644]
stable/6.12: [2a9246a424f45f33a1b8367052611ebe874868ad]
stable/6.18: [9304713b70e7e1450e3a76e758836fe5391bfa95]
stable/7.1: [0e465c63f103a5ce6849614d6bda048d70eebec8]

CVE-2026-68443: hwmon: (gigabyte_waterforce) Stop device IO before
calling hid_hw_stop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68443

Introduced by commit 42ac68e ("hwmon: Add driver for Gigabyte AORUS
Waterforce AIO coolers") in v6.8-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff0c5c53d08274e200b48a4d53aa078265e873cb]
stable/6.12: [a855f678ba37ef82c4dd22926ad740ecfb8dbedf]
stable/6.18: [f36e12cc8cfe996d627b8a82bd9df9e43270f6e2]
stable/7.1: [0842e9faab04f784d01125085195031252ff9695]

CVE-2026-68444: firmware: arm_ffa: Fix NULL dereference in
ffa_partition_info_get()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68444

Introduced by commit d0c0bce ("firmware: arm_ffa: Setup in-kernel
users of FFA partitions") in v5.14-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ae5f8e4836667fcaffdf2e3c6068b0a8b364dd8]
stable/6.12: [7201e56e52d18abf4cd0a2fee45daf9dc08b5b97]
stable/6.18: [996c5c19d5b5ac5b98a7b5a406b548305841c301]
stable/6.6: [86f5ea90f73bb7154593bb96f3411e197f3d4fbe]
stable/7.1: [12a42c610e4432e7708cc48d607e5903fffe0aad]

CVE-2026-68445: drm/vc4: Prevent shader BO mappings from becoming writable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68445

Introduced by commit 463873d ("drm/vc4: Add an API for creating GPU
shaders in GEM BOs.") in v4.5-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c9e6367639548307d3f578f6943ce72c9d39087]
stable/6.12: [019e6ad247f7fd038d2e009789f6d9bfcccb1ae7]
stable/6.18: [6deaa317201851c644c431b57682e54d06b35838]
stable/6.6: [9f0ee411fc2d76333d6087c5862ffa907cf7a175]
stable/7.1: [fe168ef1d232d734d9998fd74822e2e20930dfff]

CVE-2026-68446: drm/vmwgfx: Validate vmw_surface_metadata::array_size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68446

Introduced by commit 504901d ("drm/vmwgfx: Refactor surface_define to
use vmw_surface_metadata") in v5.7-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a4f55260f7f7d4dc4d0ee55063dfb0c457b77991]
stable/6.12: [71779fe8bf403a9b3e28dc59229fa556db32d35d]
stable/6.18: [b1379f0c42b88cb60b9f3757eb5d1e73ad460ed8]
stable/6.6: [5ff94e1279176b539d451e3e754fdcbd1a8d520a]
stable/7.1: [6910ccaf41678f7761ba2e57d72b77d056320b4d]

CVE-2026-68447: drm/amdkfd: clamp v9 CRIU control stack checkpoint
copy to BO size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68447

Introduced commit is not determined.Fixed in v7.2-rc2.
The kfd_mqd_manager_v9.c was added by b91d43d ("drm/amdkfd: Add GFXv9
MQD manager") in v4.18-rc1.

Fixed status
mainline: [426ffae6ecc7ec77d32bf8be065c21a1b881b084]
stable/7.1: [a0d87beb2660a5098b2b0ecdc1e96810a9074ea9]

CVE-2026-68448: ovl: check access to copy_file_range source with src
mounter creds

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68448

Introduced by commit 5dae222 ("vfs: allow copy_file_range to copy
across devices") in v5.3-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1e0eb8f55cfe09bb31a202a388babc411292656]
stable/6.18: [9ec22c8113d8cf72ed7197bb61037dcad09e50d8]
stable/7.1: [1f4a107439d2e43db176e34919933e617cb7f2c5]

CVE-2026-68449: ata: sata_dwc_460ex: fix infinite loop in NCQ tag
completion bit-scanning

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68449

Introduced by commit 6293600 ("[libata] Add 460EX on-chip SATA driver,
sata_dwc_460ex") in v2.6.36-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c2130f6553f4a5cbdc259de069600117a995f197]
stable/6.12: [8c5de0d8ab6824cfdadcbbe1be4c6c9d9f4c1f80]
stable/6.18: [1842d45f461a78988254631893329bdf4596e954]
stable/6.6: [4c6e64cae2b2dab32ad9099faa339f6a72c0ce16]
stable/7.1: [29b916d3556bd12a95be7c56ca391b8cd572f8be]

CVE-2026-68450: btrfs: free mapping node on duplicate reloc root insert

Announce: https://www.cve.org/CVERecord?id=CVE-2026-68450

Introduced by commit 57a304c ("btrfs: do not panic in
__add_reloc_root") in v5.13-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6a8269b6459ed870a8156c106a0f597383907872]
stable/6.12: [14a8be9428435ee17f17fae7991215c246b7fd43]
stable/6.18: [797dc567146c7e3c4f8d9680e4fbc76e0a6d9151]
stable/6.6: [92bedc0455552b42ada1a1f42b0e3a8593cdfccc]
stable/7.1: [ae0629ff9ccb836416ada129f4edc7efea6eaaad]


* Updated CVEs

CVE-2025-38525: rxrpc: Fix irq-disabled in local_bh_enable()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [8ac0b3baa7d8f732bd9e5cbf1d8b57e4802c6b36]
stable/6.6: [d94b82d452ca27a200cd67660dc48476386651d8]

CVE-2026-23385: netfilter: nf_tables: clone set on flush only

stable/6.6 was fixed.

Fixed status
stable/6.6: [e38f054f0af98224003e600545726fbd96379cfb]

CVE-2026-43197: netconsole: avoid OOB reads, msg is not nul-terminated

stable/6.12 was fixed.

Fixed status
stable/6.12: [8fe132c4873f9eb1b86ddbf31216e9d961a0b8b9]

CVE-2026-63978: net/handshake: Drain pending requests at net namespace exit

stable/6.18 was fixed.

Fixed status
stable/6.18: [2bf24a7e190aae0ea47c78099938ae056c622e44]

CVE-2026-63979: net/handshake: hand off the pinned file reference to accept_doit

stable/6.18 was fixed.

Fixed status
stable/6.18: [68eba6519cbd6359fb554a9720f3a3b6b2eba23f]

CVE-2026-64427: HID: logitech-dj: Fix maxfield check in DJ short
report validation

stable/6.12, stable/6.18, stable/6.6 were fixed.

Fixed status
stable/6.12: [80c1e18473f63fd7c6a2bc9ad6f3d0a6cc4fb500]
stable/6.18: [2b70bebc709489d29a31ac2935aeffb8d5228395]
stable/6.6: [95b3f23d632490b5eb285b9fcf7284f2ac8f9872]

CVE-2026-64523: net/handshake: Take a long-lived file reference at submit

stable/6.18 was fixed.

Fixed status
stable/6.18: [b913801ad9b9a51437d84d030ec6843e08976bd6]

CVE-2026-64563: rhashtable: clear stale iter->p on table restart

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [042fda5c088015f18838e5c692659a7be60aeb26]
stable/6.6: [c39643ad99fea749be50615550e8f0e6d6e60694]



Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

