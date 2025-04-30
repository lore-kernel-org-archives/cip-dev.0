Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AC7C369D9
	for <webhook@archiver.kernel.org>; Wed, 30 Apr 2025 22:15:56 +0000 (UTC)
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
 by mx.groups.io with SMTP id smtpd.web11.7212.1746051354531679457
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Apr 2025 15:15:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=z+bqwNjq;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.195, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-e573136107bso271597276.3
        for <cip-dev@lists.cip-project.org>; Wed, 30 Apr 2025 15:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1746051353; x=1746656153; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y40hKxEAjf1te7STbTYn5SIpTxoa3KN7Jzw0NXhEc6o=;
        b=z+bqwNjqYZCluUabOCWFICvaKYFUzYKaCDAQvIW7535Wn5i9q0G/FQ+3Aseb3MXtxd
         VKYrJp5zX2ZgLdb2tJKo+2ycar/fnNF9TKpaSKJiiL0/MN8BfH8f8JWSiBeTPAflSD7b
         mA4j+2hxwNylyLiLAUhmTJiTeTVLFyPNkcnEkCkyzLEGn7UThzKANn88I/sFhza9BX6H
         sUGiSwAM+ofot9d0Nm8xmpvjatBZpvori2ccX5Vws3uFaFjZ5A+d75uitzjnCYuKEkJW
         zk645JU5dXOLe3bCk7kjKCaPNkhgFAl1T+z1VJyJl6vyDt2DDO8v3BnYyLe+ZVYkvUbV
         bB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746051353; x=1746656153;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y40hKxEAjf1te7STbTYn5SIpTxoa3KN7Jzw0NXhEc6o=;
        b=mcENPyxcOsolLiz+1t3vllvrRDESCoArL3eDSHPccI01osYahK3pqUL1A4r9CapSS1
         rNytGzMo1yFV3Ymw/UiZDj4EZDP9xIGDBkxbIXwBnnHN4qXfMgjM9PeS09ym/nVdkVxg
         eNqPhU96XbRhyJD4p02os7UEVNaB8IiaQms6j9D+qwVRPb8YdkanKQTtiB28VRIDCaOr
         2YOn8Sb2ry/4nlOIqBTilsn51OhVBBp2DWqfS4Poc1zX8yTgcOR+5gBx2Su5klAO+8k2
         sUAl0B+nMJ/4CcqKaDVHTaGi65iGyPBpFYavW/q76wCmooUrY4qFrTr3Zl9ZWy4vZVxZ
         o58w==
X-Gm-Message-State: AOJu0Ywu8yOYJGMlf9cPZ0Oxxllc0WJA1Bq7e2N8qU5JWYI2gQhm7+ri
	wjTOzWWSjoNWLzqkd0J2EEq1BbOdX/bNHn32c15lfP7N1BgS/TBMt8EM/ArFLs7eUyRomelAc8p
	QTYeS8ugPXdA55oFp2iVfA5pROvhvyfzrsDdoXMh1+LyB7os/xR3ravOG
X-Gm-Gg: ASbGnctwguqkrt6LleRGiy/DYka4zM4Q5NSxgly1DkIg5zVV4NWDvO9YapXNrlKhbrT
	RbCxKBUtIhIcZTxBxvwVVYRXzYfHbbaT+eYu1OCm4wST++BSYZ0CL9mO8VJcZqYXM8SrSE+FdnP
	G6IKN3dG4acdAFIRHv4gE08vA=
X-Google-Smtp-Source: AGHT+IFF61srRQiY36bt2LavTJXmAsAskejQCg+blfxW5jM3ouySm77PvpWdRAggrA6+aB43O60EqSL02/y3O/05qxk=
X-Received: by 2002:a25:aa30:0:b0:e73:1ff1:ca2f with SMTP id
 3f1490d57ef6-e75328db7ddmr7539276.32.1746051353303; Wed, 30 Apr 2025 15:15:53
 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 1 May 2025 07:15:17 +0900
X-Gm-Features: ATxdqUFyktE-2YPSydnAakY_yO3WOyXbt4JauLekdHgZNY_-yQhT_hE5-HiHSAA
Message-ID: <CAODzB9qCakbZjQXCA3v6sh8JvFN3PX+_0SjMyUyQkQZeZE-yCw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Apr 2025 22:15:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18743

Hi!

It's this week's CVE report.

This week reported 1 new CVEs and 13 updated CVEs.

* New CVEs

CVE-2024-58099: vmxnet3: Fix packet corruption in vmxnet3_xdp_xmit_frame

Announce: https://www.cve.org/CVERecord?id=CVE-2024-58099

Introduced by commit 54f00cc ("vmxnet3: Add XDP support.") in v6.6-rc1.
Fixed in v6.12-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4678adf94da4a9e9683817b246b58ce15fb81782]
stable/6.6: [59ba6cdadb9c26b606a365eb9c9b25eb2052622d]

* Updated CVEs

CVE-2022-45884: A use-after-free bug was found in
drivers/media/dvb-core/dvbdev.c

stable/5.10, stable/5.15, stable/5.4, stable/6.1 were fixed.

Fixed status
cip/4.19: [dc04ff778b4f8ff4560f1c42993417359e74d36a]
cip/4.19-rt: [dc04ff778b4f8ff4560f1c42993417359e74d36a]
cip/4.19-st: [dc04ff778b4f8ff4560f1c42993417359e74d36a]
stable/5.10: [2d1c19597d1eb7f18c9d906aa7e144733eccdcc8]
stable/5.15: [a47a3f7a9bf6a350d41f06c232d7c3468bce1b9a]
stable/5.4: [a93ae93e9f1bcd098f21e94ce649f0994eab213b]
stable/6.1: [4a8ecfb2207c498b1d25915919631e2195f9e524]

CVE-2024-36908: blk-iocost: do not WARN if iocg was already offlined

stable/6.1 was fixed.

Fixed status
stable/6.1: [aed0aac18f039dd4af13c143063754efca358cb0]
stable/6.6: [1c172ac7afe4442964f4153b2c78fe4e005d9d67]

CVE-2024-46733: btrfs: fix qgroup reserve leaks in cow_file_range

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [159f0f61b283ea71e827dd0c18c5dce197de1fa2]
stable/6.10: [e42ef22bc10f0309c0c65d8d6ca8b4127a674b7f]
stable/6.6: [84464db2ec2a55b9313d5f264da196a37ec80994]

CVE-2024-46742: smb/server: fix potential null-ptr-deref of
lease_ctx_info in smb2_open()

stable/6.1 was fixed.

Fixed status
stable/6.1: [ec28c35029b7930f31117f9284874b63bea4f31b]
stable/6.10: [3b692794b81f2ecad69a4adbba687f3836824ada]
stable/6.6: [07f384c5be1f8633b13f0a22616e227570450bc6]

CVE-2024-46774: powerpc/rtas: Prevent Spectre v1 gadget construction
in sys_rtas()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [b137af795399d8b657bad1646c18561530f35ed1]
stable/6.10: [68d8156480940b79227d58865ec5d2947b9384a8]
stable/6.6: [1f1feff02e9da0dd0cdb195c428c42b5f9b6c771]

CVE-2024-46816: drm/amd/display: Stop amdgpu_dm initialize when link
nums greater than max_links

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [13080d052c995aee14695a5b740c245121eb2bcc]
stable/6.10: [36c39a8dcce210649f2f45f252abaa09fcc1ae87]
stable/6.6: [c84632096722fd31251f0957fafc9e90d9a247fd]

CVE-2024-49569: nvme-rdma: unquiesce admin_q before destroy it

stable/6.6 was fixed.

Fixed status
stable/6.12: [05b436f3cf65c957eff86c5ea5ddfa2604b32c63]
stable/6.6: [427036030f4d796533dcadba9b845896cb6c10a7]

CVE-2024-50063: bpf: Prevent tail call between progs attached to different hooks

stable/6.1 was fixed.

Fixed status
stable/6.1: [d9a807fb7cbfad4328824186e2e4bee28f72169b]
stable/6.11: [88c2a10e6c176c2860cd0659f4c0e9d20b3f64d1]
stable/6.6: [5d5e3b4cbe8ee16b7bf96fd73a421c92a9da3ca1]

CVE-2024-53203: usb: typec: fix potential array underflow in
ucsi_ccg_sync_control()

stable/6.6 was fixed.

Fixed status
stable/6.12: [56971710cd541f2f05160a84b3183477d34a1be9]
stable/6.6: [0e66fd8e5a2e45c7dacfc9178ba702153f4a61a8]

CVE-2025-21853: bpf: avoid holding freeze_mutex during mmap operation

stable/6.1 was fixed.

Fixed status
stable/6.1: [4759acbd44d24a69b7b14848012ec4201d6c5501]
stable/6.12: [d95607a5f2f9bb08194c9deaf4a5f3e8ba59a9d4]
stable/6.13: [271e49f8a58edba65bc2b1250a0abaa98c4bfdbe]
stable/6.6: [29cfda62ab4d92ab94123813db49ab76c1e61b29]

CVE-2025-22013: KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state

stable/6.1 was fixed.

Fixed status
stable/6.1: [04c50cc23a492c4d43fdaefc7c1ecc0ff6f7b82e]
stable/6.12: [79e140bba70bcacc5fe15bf8c0b958793fd7d56f]
stable/6.13: [900b444be493b7f404898c785d6605b177a093d0]
stable/6.6: [806d5c1e1d2e5502175a24bf70f251648d99c36a]

CVE-2025-22126: md: fix mddev uaf while iterating all_mddevs list

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [ca9f84de76723b358dfc0606668efdca54afc2e5]
stable/6.12: [e2a9f73ee408a460f4c9dfe03b4741d6b11652b8]
stable/6.14: [5462544ccbad3fc938a71b01fa5bd3a0dc2b750a]
stable/6.6: [d69a23d8e925f8052d657652a6875ec2712c7e33]

CVE-2025-37838: HSI: ssi_protocol: Fix use after free vulnerability in
ssi_protocol Driver Due to Race Condition

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [d58493832e284f066e559b8da5ab20c15a2801d3]
stable/6.12: [ae5a6a0b425e8f76a9f0677e50796e494e89b088]
stable/6.13: [834e602d0cc7c743bfce734fad4a46cefc0f9ab1]
stable/6.14: [4b4194c9a7a8f92db39e8e86c85f4fb12ebbec4f]
stable/6.6: [58eb29dba712ab0f13af59ca2fe545f5ce360e78]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

