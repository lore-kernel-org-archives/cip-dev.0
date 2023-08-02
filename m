Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5148C001DE
	for <webhook@archiver.kernel.org>; Wed,  2 Aug 2023 23:39:14 +0000 (UTC)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
 by mx.groups.io with SMTP id smtpd.web11.3020.1691019543535177880
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Aug 2023 16:39:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=23e/BB5b;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.52, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1bb782974f4so228626fac.3
        for <cip-dev@lists.cip-project.org>; Wed, 02 Aug 2023 16:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1691019542; x=1691624342;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rY5gwFRAj6DmX7B7xYY3BwuOBgUJ8bLpApBcNlO2ix0=;
        b=23e/BB5bnOKayrLHHHnoYdQRf0MT2fIIhwYuY3bSAJUot+RkJxZAETMejM9cgWB9Zg
         iQYHr+dQ0OeL0lvqQiRWEMcbyaDopWd5OD2tvxrfIvkjuEDZqdiW05Ej6bZGLrNzrqxN
         URg8Okrdfnk01N+hGdUvCd2PqTUfZFwqpn4z9s37jkaEQ/rWscB1ycgHjZgFVxk5kD3G
         ab6norMwhGrQ5yjyNE+dxaCBrwrSMV7a+lfGGvs50XJuBCOLWXTIO4MCLeBeG/Doxu4z
         ZgJSdjYEOCtR1XD+G+YX9WhKZWTY6LN7DgV+9R3a1lBljsBgF1qSY/An4Z8KLZ/ZppHC
         1PHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691019542; x=1691624342;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rY5gwFRAj6DmX7B7xYY3BwuOBgUJ8bLpApBcNlO2ix0=;
        b=av7jEbOUHIXbACzoXVE2jI65eN8SxAiesNlPEchv8EVN094HMmu06s3iNrMsN1PUTu
         r8rFwpoG773ys1BYq5lKkovtbUKRgpiEjAf37iQV36QXhOA/JqeCVdSsYwKsmy0Si766
         S9huPAHFgX66t8OMDSo71MjeZ0Jve4RI42GcAmcdx3554C2zOwvIU0evDU227Elu219K
         0qB4GAUAr3Swk++qtJ9gZzgVyj3tz8CcjvDLxM4Zqblnm6O7hi5qFnkW0grlKqaLrCJ5
         b1tgli64vMkcTFnyhz3URsMr7irBPzhEbTLIh8Lj0fMhtfIZIJABvVGjv64apEm8o0zm
         EcmQ==
X-Gm-Message-State: ABy/qLbzm+qT4BYSD2zJwa29uy2DRljIGRIJQLZquzwJbadcumT/AGtZ
	/lyTpzQEO26Se7pnYwJ203DK42hHCUpVn1CyJPhxAJUIZy0v/0o3Y8Y=
X-Google-Smtp-Source: APBJJlFkyMIjwVIbf10jNhnnQrDrXfwhxlWeXah8mPT/LtQ01G+sKQVfNwb8Vn0Fq7wy6YVVFYJlhALk9hl1VOiLeDw=
X-Received: by 2002:a05:6870:f695:b0:1b7:60aa:43f1 with SMTP id
 el21-20020a056870f69500b001b760aa43f1mr20794645oab.11.1691019542035; Wed, 02
 Aug 2023 16:39:02 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 3 Aug 2023 08:38:25 +0900
Message-ID: <CAODzB9ppRV992Erf4QnGh9poKGSxyUNgxGdEPMn+cA4taDNsQg@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Aug 2023 23:39:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12540

Hi !

It's this week's CVE report.

This week reported 3 new CVEs and 10 updated CVEs.

* New CVEs

CVE-2023-3812: An out-of-bounds memory access flaw was found in the
TUN/TAP device driver

CVSS v3 score is not provided(NIST).
CVSS v3 score is 7.8 HIGH.

An out-of-bounds memory access flaw was found in the Linux kernel=E2=80=99s
TUN/TAP device driver functionality in how a user generates a
malicious (too big) networking packet when napi frags is enabled. This
flaw allows a local user to crash or potentially escalate their
privileges on the system.

This issue was introduced by commit 90e33d4 ("tun: enable
napi_gro_frags() for TUN/TAP driver") in 4.15-rc1.
This patch is not backported to 4.14 and 4.4.

Fixed status
mainline: [363a5328f4b0517e59572118ccfb7c626d81dca9]
stable/4.19: [aa815bf32acf560dad63c3dc46bc7b98ca9a9672]
stable/5.10: [3583826b443a63681deaa855048d3f2b742af47e]
stable/5.15: [dcc79cf735b8ec4bedaa82c53bed8c62721c042b]
stable/5.4: [ca791952d42c5b40d548ff6c4a879216039b0ca1]

CVE-2023-4004 :A use-after-free flaw was found in the netfilter subsystem

CVSS v3 score is not provided(NIST).
CVSS v3 score is 7.8 HIGH(CNA).

A use-after-free flaw was found in the Linux kernel's netfilter in the
way a user triggers the nft_pipapo_remove function with the element,
without a NFT_SET_EXT_KEY_END. This issue could allow a local user to
crash the system or potentially escalate their privileges on the
system.

Introduced by commit 3c4287f ("nf_tables: Add set type for arbitrary
concatenation of ranges") in 5.6-rc1.
This patch is not backported to older stable kernels.

Fixed status
mainline: [87b5a5c209405cb6b57424cdfa226a6dbd349232]
stable/5.10: [3a91099ecd59a42d1632fcb152bf7222f268ea2b]
stable/5.15: [706ce3c81b5c8e262a8bcf116ea689d0710c3a13]
stable/6.1: [90c3955beb858bb52a9e5c4380ed0e520e3730d1]
stable/6.4: [48dbb5d24c667bf26bc2fea8caa7fe51fcc6aa62]

CVE-2023-4010: A bug was found in the usb_giveback_urb function causes DoS.

CVSS v3 score is not provided(NIST).
CVSS v3 score is 4.6 MEDIUM.

A flaw was found in the USB Host Controller Driver framework in the
Linux kernel. The usb_giveback_urb function has a logic loophole in
its implementation. Due to the inappropriate judgment condition of the
goto statement, the function cannot return under the input of a
specific malformed descriptor file, so it falls into an endless loop,
resulting in a denial of service.

A reporter described this bug on the
github(https://github.com/wanrenmi/a-usb-kernel-bug) that said the
vulnerability is in the usb_giveback_urb(). But that function is not
found in any kernel versions. There is a usb_giveback_urb_bh() in
drivers/usb/core/hcd.c instead.

Fixed status
Not fixed yet.

* Updated CVEs

CVE-2023-2898: f2fs: fix to avoid NULL pointer dereference f2fs_write_end_i=
o()

Stable 5.10 was fixed.

Fixed status
mainline: [d8189834d4348ae608083e1f1f53792cfcc2a9bc]
stable/5.10: [b39ef5b52f10b819bd0ceeb22e8f7df7800880ca]
stable/5.15: [982c29e0d27a48d65fd0fa0d1bcee501eeb06e76]
stable/6.1: [ebe83e9bb8a6b3db28603fe938ee80ccaa01ed53]
stable/6.4: [5619e9aabbd2b369cde2114ad6f55f6eb3e0b5be]

CVE-2023-3117: A use-after-free flaw was found in the Netfilter subsystem

Stable 5.10 was fixed.

Fixed status
mainline: [1240eb93f0616b21c675416516ff3d74798fdc97]
stable/5.10: [8180fc2fadd48dde4966f2db2c716c2ce7510d0b]
stable/5.15: [44ebe988cb38e720b91826f4d7c31692061ca04a]
stable/6.1: [4aaa3b730d16c13cc3feaa127bfca1af201d969d]

CVE-2023-31248: nf_tables UAF when using nft_chain_lookup_byid

Stable 5.10 was fixed.

Fixed status
mainline: [515ad530795c118f012539ed76d02bacfd426d89]
stable/5.10: [4ae2e501331aaa506eaf760339bb2f43e5769395]
stable/5.15: [041e2ac88caef286b39064e83e825e3f53113d36]
stable/6.1: [fc95c8b02c6160936f1f3d8d9d7f4f66f3c84b49]
stable/6.4: [5e5e967e8505fbdabfb6497367ec1b808cadc356]

CVE-2023-3212: gfs2: Don''t deref jdesc in evict

Stable 5.10 was fixed.

Fixed status
mainline: [504a10d9e46bc37b23d0a1ae2f28973c8516e636]
stable/5.10: [d03d31d3a206093b9b8759dddf0ba9bd843606ba]
stable/5.15: [fd8b4e28f400a067e6ef84569816967be1f0642b]
stable/5.4: [23f98fe887ce3e7c8bd111f37e62735c5018c534]
stable/6.1: [5ae4a618a1558d2b536fdd5d42e53d3e2d73870c]
stable/6.3: [14c454764a37b194dc916c07488ce7339c82bc4f]

CVE-2023-3390: netfilter: nf_tables: incorrect error path handling
with NFT_MSG_NEWRULE

Stable 5.10 was fixed.

Fixed status
mainline: [1240eb93f0616b21c675416516ff3d74798fdc97]
stable/5.10: [8180fc2fadd48dde4966f2db2c716c2ce7510d0b]
stable/5.15: [44ebe988cb38e720b91826f4d7c31692061ca04a]
stable/6.1: [4aaa3b730d16c13cc3feaa127bfca1af201d969d]
stable/6.3: [bdace3b1a51887211d3e49417a18fdbd315a313b]

CVE-2023-35001: nf_tables nft_byteorder_eval OOB read/write

Stable 5.4 and 5.10 were fixed.

Fixed status
stable/5.10: [ea213922249c7e448d217a0a0441c6f86a8155fd]
stable/5.15: [870dcc31c0cf47cb15a568ade4168dc644b3ccfb]
stable/5.4: [b7d636c924eb275651bfb036eb8eca49c3f7bc24]
stable/6.1: [40f83dd66a823400d8592e3b71e190e3ad978eb5]
stable/6.4: [b79c09c2bf2d7643902a6ef26152de602c5c5e4b]

CVE-2023-3610: netfilter: nf_tables: fix chain binding transaction logic

Stable 5.10 was fixed.

Fixed status
mainline: [4bedf9eee016286c835e3d8fa981ddece5338795]
stable/5.10: [d53c295c1f43b7460d28ba0f0f98a602084fdcb6]
stable/5.15: [314a8697d08092df6d00521450d44c352c602943]
stable/6.1: [891cd2edddc76c58e842706ad27e2ff96000bd5d]

CVE-2023-3611: net/sched: sch_qfq: account for stab overhead in qfq_enqueue

Stable 5.10 was fixed.

Fixed status
mainline: [3e337087c3b5805fe0b8a46ba622a962880b5d64]
stable/5.10: [8359ee85fd6dabc5c134ed69fb22faadd8a44071]
stable/5.15: [91d3554ab1fc2804c36a815c0f79502d727a41e6]
stable/6.1: [70feebdbfad85772ab3ef152812729cab5c6c426]
stable/6.4: [bd2333fa86dc520823e8c317980b29ba91ee6b87]

CVE-2023-3776: net/sched: cls_fw: Fix improper refcount update leads
to use-after-free

Stable 5.4 and 5.10 were fixed.

Fixed status
mainline: [0323bce598eea038714f941ce2b22541c46d488f]
stable/5.10: [80e0e8d5f54397c5048fa2274144134dd9dc91b5]
stable/5.15: [5b55f2d6ef403fcda93ae4eb4d8c1ba164c66e92]
stable/5.4: [808211a8d427404331e39e3b8c94ab5242eef8f5]
stable/6.1: [c91fb29bb07ee4dd40aabd1e41f19c0f92ac3199]
stable/6.4: [0a2e3f49febda459252f58cec2d659623d582800]

CVE-2023-3863: net: nfc: Fix use-after-free caused by nfc_llcp_find_local

Stable 5.4 and 5.10 were fixed.

Fixed status
mainline: [6709d4b7bc2e079241fdef15d1160581c5261c10]
stable/5.10: [96f2c6f272ec04083d828de46285a7d7b17d1aad]
stable/5.15: [fc8429f8d86801f092fbfbd257c3af821ac0dcd3]
stable/5.4: [dd6ff3f3862709ab1a12566e73b9d6a9b8f6e548]
stable/6.1: [425d9d3a92df7d96b3cfb7ee5c240293a21cbde3]
stable/6.4: [e5207c1d69b1a9707615ab6ff9376e59fc096815]

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
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
      :masami.ichikawa@miraclelinux.com

