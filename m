Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843F2C46CD2
	for <webhook@archiver.kernel.org>; Wed, 27 Dec 2023 22:47:54 +0000 (UTC)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
 by mx.groups.io with SMTP id smtpd.web11.112053.1703717266000451529
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Dec 2023 14:47:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=amt8YH8g;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.46, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2041e117abaso2927557fac.0
        for <cip-dev@lists.cip-project.org>; Wed, 27 Dec 2023 14:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1703717264; x=1704322064; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lmD+T2DKe/eQcF7oALYWvyStg+/UpLiVF4+oUSWICk0=;
        b=amt8YH8gSQtflLoXVevcxk7yIA7uXWURdgq5l8YvjSUTAUsM+mfOgWRoBsw9FI1IRl
         Ihy9fVffSLy4aNhNCxZNZ7jStYX40SFpFt6EF33XpFtcccyk4ZRrsraumxwfzrwTvo9Q
         uf9HWHo2N9mOEoIRwMjR2ss5C98mg5CsrbXT1gfS9nbWybC/BqwYrhdNRHRyUlwmp+bH
         zf4r63BBFVosdPQtKh/Hbs3nJ5DFWujbcNCzRFbD1FHADmmVP7KiDRswG70JBMTN7I5I
         4RBu9g8vwi345UqwDpDcCc8veQt7xkMLVDiM5+8FKG7ji4+6ZdrGa1TNqoKrs+s+nJ1G
         w8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703717264; x=1704322064;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lmD+T2DKe/eQcF7oALYWvyStg+/UpLiVF4+oUSWICk0=;
        b=U/zPaKCHGypLeJEytw6b8LuBZj52e4do7qC7D/av3PQ7ibb34NpSRaDL9fiYWx2H2Y
         FYz+jAWA34uElGnZsWHb8fGeNAZTHQUwpk0JodheEOJSQwu5XzG91lEGCrJ+/aDw53jh
         GeqBVYCevHW1U0egN/NtBMT6OMNT9Dsah3XgavMmA29PvQgiFQsEFPFKRrSkW5M+S/hE
         wl/1nVTtl7t9aRguYi56prohOI8FsBQZfU97D5l2A1q6n9JGJmfljQiZAuAI636Zl77Y
         M+M+Zd9dxbCDOzyCuofN8u3wkv1KDyQDtW6e9TLXuOQFqBA0PVOdnYI2sxCJwl4VAMj+
         X4/Q==
X-Gm-Message-State: AOJu0YwUGGc4Tu7Ek08PtBwH8bbO4Jpf/SyxUZFFlhX8AOc39yqUbzBD
	A0Oz9vlbbIzqnq+aovQwfEEYlfYmluUoWSfWpERbccw5UzAlHPPfG7XLSjOVo5o=
X-Google-Smtp-Source: AGHT+IHRN1uQBXLvmq8TlMjr3i7DFw082pesCy6knF1+gLY3kGnE6Nkh4rPXC8nGWjKNNT7E7WL8tss2X99s9wjFhqk=
X-Received: by 2002:a05:6871:68a:b0:203:e346:b8ec with SMTP id
 l10-20020a056871068a00b00203e346b8ecmr6865063oao.85.1703717264186; Wed, 27
 Dec 2023 14:47:44 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 28 Dec 2023 07:47:08 +0900
Message-ID: <CAODzB9oG5tCL_fuX_QMhM14MqqUPDL+4+yfy7XNNrn3NsBuQFw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Dec 2023 22:47:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14205

Hi!

It's this week's CVE report.

This week reported 5 new CVEs and 16 updated CVEs.

There was a big change in the ksmbd sub system in 5.15 that backported
lots of patches between 5.16 and 6.7-rc5 kernel to 5.15.
https://lore.kernel.org/stable/2023122045-snuggle-rocky-b3f8@gregkh/T/#t

This patchset fixes the following CVEs.
CVE-2022-47490, CVE-2023-1193, CVE-2023-1194, CVE-2023-32247, CVE-2023-32250
CVE-2023-32252, CVE-2023-32254, CVE-2023-32257, CVE-2023-32258, CVE-2023-38427
CVE-2023-38430, CVE-2023-38431, CVE-2023-3867

* New CVEs

CVE-2023-7042: wifi: ath10k: fix NULL pointer dereference in
ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev()

CVSS v3(NIST): N/A
CVSS v3(CNA): 4.4 (MEDIUM)

A null pointer dereference vulnerability was found in
ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev() in
drivers/net/wireless/ath/ath10k/wmi-tlv.c in the Linux kernel. This
issue could be exploited to trigger a denial of service.

This bug was introduced by commit dc405152bb64 ("ath10k: handle mgmt
tx completion event") in 4.19-rc1.

Fixed status
Patch has been merged into ath-next branch.

CVE-2023-51779: Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg

CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

bt_sock_recvmsg in net/bluetooth/af_bluetooth.c in the Linux kernel
through 6.6.8 has a use-after-free because of a bt_sock_ioctl race
condition.
This bug was introduced in less than or equal to 2.6.12-rc2.

Fixed status
mainline: [2e07e8348ea454615e268222ae3fc240421be768]

CVE-2023-51780: atm: Fix Use-After-Free in do_vcc_ioctl

CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

An issue was discovered in the Linux kernel before 6.6.8. do_vcc_ioctl
in net/atm/ioctl.c has a use-after-free because of a vcc_recvmsg race
condition.
This bug was introduced in less than or equal to 2.6.12-rc2.

Fixed status
mainline: [24e90b9e34f9e039f56b5f25f6e6eb92cdd8f4b3]
stable/4.14: [3ddeb55deec5e0e324d0ab8cc2ddd528518ea12d]
stable/4.19: [bff7ddb0d9d515170dcf133d239dba87c47c8cdb]
stable/5.10: [64a032015c336ca1795b3e1b1d1f94085ada3553]
stable/5.15: [3bb41dc361bfd938041a1d17a3768aa788a36a3c]
stable/5.4: [b099c28847cfa33854731eeec9c64619d99a1255]
stable/6.1: [2de2a6cbe14f7e949da59bddd5d69baf5dd893c0]
stable/6.6: [531fd46f92895bcdc41bedd12533266c397196da]

CVE-2023-51781: appletalk: Fix Use-After-Free in atalk_ioctl

CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

An issue was discovered in the Linux kernel before 6.6.8. atalk_ioctl
in net/appletalk/ddp.c has a use-after-free because of an
atalk_recvmsg race condition.
This bug was introduced in less than or equal to 2.6.12-rc2.

Fixed status
mainline: [189ff16722ee36ced4d2a2469d4ab65a8fee4198]
stable/4.14: [0686da1ada51c787610185de6289d8a5006ad263]
stable/4.19: [580ff9f59ab6537d8ce1d0d9f012cf970553ef3d]
stable/5.10: [a232eb81c7cb5d4dbd325d4611ed029b7fa07596]
stable/5.15: [5b87ac25e8cfeb2d3d27574cdc077b09e8ceca82]
stable/5.4: [9112bd107208cd6a4f0175ca36289ed170622cce]
stable/6.1: [1646b2929d5efc3861139ba58556b0f149c848f6]
stable/6.6: [e15ded324a3911358e8541a1b573665f99f216ef]

CVE-2023-51782: net/rose: Fix Use-After-Free in rose_ioctl

CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

An issue was discovered in the Linux kernel before 6.6.8. rose_ioctl
in net/rose/af_rose.c has a use-after-free because of a rose_accept
race condition.
This bug was introduced in less than or equal to 2.6.12-rc2.

Fixed status
mainline: [810c38a369a0a0ce625b5c12169abce1dd9ccd53]
stable/4.14: [02af3c8ab5cda2633b187bd18b5dc2b9f0af0859]
stable/4.19: [6c9afea8827dde62c4062185d22ac035090ba39b]
stable/5.10: [7eda5960a5332654b10d951e735750ed60d7f0a9]
stable/5.15: [3f1f6a94d8858706863fe90da35663f6e24be274]
stable/5.4: [3df812627e7d0bf557f3781c3448d42c8fe8313e]
stable/6.1: [01540ee2366a0a8671c35cd57a66bf0817106ffa]
stable/6.6: [63caa51833e8701248a8a89d83effe96f30e4c80]

* Updated CVEs

CVE-2023-6606: Out-Of-Bounds Read vulnerability in smbCalcSize

Fixed in the mainline.

Fixed status
mainline: [b35858b3786ddbb56e1c35138ba25d6adf8d0bef]

CVE-2023-6610: OOB Access in smb2_dump_detail

Fixed in the mainline.

Fixed status
mainline: [567320c46a60a3c39b69aa1df802d753817a3f86]

CVE-2022-47940: Linux Kernel ksmbd Out-Of-Bounds Read Information
Disclosure Vulnerability

stable/5.15 was fixed.

Fixed status
mainline: [158a66b245739e15858de42c0ba60fcf3de9b8e6]
stable/5.15: [6bb4399303383c2c06bce33f2335c39fbf35d979]

CVE-2023-1193: use-after-free in setup_async_work()

stable/5.15 was fixed.

Fixed status
mainline: [3a9b557f44ea8f216aab515a7db20e23f0eb51b9]
stable/5.15: [9494242c8e76e6a98c8ab5f6aed0fa4bd56ac6d5]

CVE-2023-1194: use-after-free in parse_lease_state()

stable/5.15 was fixed.

Fixed status
mainline: [fc6c6a3c324c1b3e93a03d0cfa3749c781f23de0]
stable/5.15: [55ceeb4e1c71793e852c20ad01ffd31515303546]
stable/6.1: [8f2984233c87a1d08f4c45f077130590c7a2c991]

CVE-2023-32247: Linux Kernel ksmbd Session Setup Memory Exhaustion
Denial-of-Service Vulnerability

stable/5.15 was fixed.

Fixed status
mainline: [ea174a91893956450510945a0c5d1a10b5323656]
stable/5.15: [a6a9601ba995d0fec635324cb9fd8d14f9bea14e]
stable/6.1: [1fc8a2b14ef5223f8e0b95faba2ee0a6e4d0f99d]
stable/6.3: [6775ee7ef4b37c521aa4cf3730f54554c4875542]

CVE-2023-32250: ksmbd: fix racy issue from session setup and logoff

stable/5.15 was fixed.

Fixed status
mainline: [f5c779b7ddbda30866cf2a27c63e34158f858c73]
stable/5.15: [708c304b583d789957399dd8237f212cf8ad1e4d]
stable/6.1: [f623f627ad2b1dc215ab3b0df53fb05cfd3a1c3b]
stable/6.3: [02f41d88f15d6b7d523e52cc3f87488f57e9265b]

CVE-2023-32252: Linux Kernel ksmbd Session NULL Pointer Dereference
Denial-of-Service Vulnerability

stable/5.15 was fixed.

Fixed status
mainline: [f5c779b7ddbda30866cf2a27c63e34158f858c73]
stable/5.15: [708c304b583d789957399dd8237f212cf8ad1e4d]
stable/6.1: [f623f627ad2b1dc215ab3b0df53fb05cfd3a1c3b]
stable/6.3: [02f41d88f15d6b7d523e52cc3f87488f57e9265b]

CVE-2023-32254: ksmbd: fix racy issue under cocurrent smb2 tree disconnect

stable/5.15 was fixed.

Fixed status
mainline: [30210947a343b6b3ca13adc9bfc88e1543e16dd5]
stable/5.15: [b36295c17fb97424406f0c3ab321b1ccaabb9be8]
stable/6.1: [bd80d35725a0cf4df9307bfe2f1a3b2cb983d8e6]
stable/6.3: [39366b47a59d46af15ac57beb0996268bf911f6a]

CVE-2023-32257: Linux Kernel ksmbd Session Race Condition Remote Code
Execution Vulnerability

stable/5.15 was fixed.

Fixed status
mainline: [f5c779b7ddbda30866cf2a27c63e34158f858c73]
stable/5.15: [708c304b583d789957399dd8237f212cf8ad1e4d]
stable/6.1: [f623f627ad2b1dc215ab3b0df53fb05cfd3a1c3b]
stable/6.3: [02f41d88f15d6b7d523e52cc3f87488f57e9265b]

CVE-2023-32258: Linux Kernel ksmbd Session Race Condition Remote Code
Execution Vulnerability

stable/5.15 was fixed.

Fixed status
mainline: [abcc506a9a71976a8b4c9bf3ee6efd13229c1e19]
stable/5.15: [ae06b798f72d6cc792cfa1745490be65da90eb03]
stable/6.1: [4aba9ab6a007e41182454f84f95c0bddf7d6d7e1]
stable/6.3: [920d5dd2d041484bf001c9713c2e3bcc6de79726]

CVE-2023-38427: OOB read bug was found in deassemble_neg_contexts()

stable/5.15 was fixed.

Fixed status
mainline: [f1a411873c85b642f13b01f21b534c2bab81fc1b]
stable/5.15: [4adb4fbd74812aeada97e7cc6de3dad41952443e]
stable/6.1: [bf12d7fb63b365fb766655cedcb5d5f292b0c35e]

CVE-2023-38430: OOB read bug was found in the ksmbd subsystem

stable/5.15 was fixed.

Fixed status
mainline: [1c1bcf2d3ea061613119b534f57507c377df20f9]
stable/5.15: [0d1a3f97efbe73fe6d6c18574e6ac94cd2492c11]
stable/6.1: [e01fc7caac9ce9ad76df9f42f7f61ef4bf1d27c9]

CVE-2023-38431: OOB read bug was found in the ksmbd subsystem

stable/5.15 was fixed.

Fixed status
mainline: [368ba06881c395f1c9a7ba22203cf8d78b4addc0]
stable/5.15: [df3a4518aee64f21bcafa891105b468413f27431]
stable/6.1: [543c12c2644e772caa6880662c2a852cfdc5a10c]

CVE-2023-3867: ksmbd: add missing compound request handing in some commands

stable/5.15 was fixed.

Fixed status
mainline: [7b7d709ef7cf285309157fb94c33f625dd22c5e1]
stable/5.15: [97f5c1e3086c8ba1473c265d9a5523cc9ef5579e]
stable/6.1: [869ef4f2965bbb91157dad220133f76c16faba9b]
stable/6.4: [ffaa0c85edd9245594a94918c09db9163b71767a]

CVE-2023-6679: dpll: sanitize possible null pointer dereference in
dpll_pin_parent_pin_set()

Fixed in the mainline.

Fixed status
mainline: [65c95f78917ea6fa7ff189a2c19879c4fe161873]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh
Provisioning Leads to MITM

No fix information.

CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provisioning

No fix information.

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

