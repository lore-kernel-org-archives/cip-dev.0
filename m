Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9BCC35FFC
	for <webhook@archiver.kernel.org>; Sat, 22 Mar 2025 23:49:31 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
 by mx.groups.io with SMTP id smtpd.web10.7439.1742687368600990456
 for <cip-dev@lists.cip-project.org>;
 Sat, 22 Mar 2025 16:49:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GoqzWvkk;
 spf=pass (domain: gmail.com, ip: 209.85.160.170, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47690a4ec97so33708941cf.2
        for <cip-dev@lists.cip-project.org>; Sat, 22 Mar 2025 16:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742687367; x=1743292167; darn=lists.cip-project.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=opGYxJrE+0eV64y1ioQSHXAnQNwOftKPx9ID6pEvY8Y=;
        b=GoqzWvkkNots8UID0CxsQ1syCx/X0Vb6lMkxYAw33Naq1VxVFbjyTccye0cPvljy0/
         efOMTBMYHQonHRAsSGrybMEw9EjYXKY0WCR09V5osDd3oqVfSHDHVFpAFHVmuHmBKROG
         udfjyFyOsyePLJ+BdS9lrB+uldk7ak4mxtDBiPW/3uhDNguu3iAt5NxK/Qow702QXdOa
         ZJU8SY13m0ebB8eRJ2AR9jeFJkmOC3fqqzmkQ/sA0jYeZoelikJqLfUNtMdWuGI7oKW3
         37W+hxsvlE+r6XlrPA8B//zkZIY4Fj38eQBzW3uaeGtePUjcmqaYQaveX1kXora2QtxI
         jHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742687367; x=1743292167;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=opGYxJrE+0eV64y1ioQSHXAnQNwOftKPx9ID6pEvY8Y=;
        b=rkrY4BwrRHZZk7ARNZrqBDMvtDPHGzKJsacUfmKT4MVFO7mD+1JzPqLjJUMpix+zKF
         OZ7SjIQfvJWRLg2jJOj07kRdv/wEqsnfdzvXFV5OTCSNFgyjXaTuaFL+3z+01jM6yQKm
         Ch7vR/ynKW/YMLxyTo8RPMCkqshyDsASfokySCLm/WT69vA1ojdIYSFqt0/ro4osH4ZN
         Mya718IXU2Xa82m7pkUD2sypyfaCq34YKCKkZ+nGAwxHTvmKiVABGffWPNBc4T1HFRQF
         Z2lnjwF3UdyTXMuu4qgcSaDPE98H905CXOc7fkP26YUGoKpe28wFmNnTxhctUv2+0iD7
         zcEg==
X-Gm-Message-State: AOJu0Yze3CfZxTBVsFdMwbNsH91BRCpG359B9rN5YUbv6ILoZJXT2EiD
	XPH6VQqnqhpTP+PZGBp29GU00qRxOENlEKYbfGvF45Qey4s2SIhzbpTz2Ex8x94lxYg5YZsK6sQ
	V48Ju4bFvdvHmIaICLsKbdmYgroY4Q9hm
X-Gm-Gg: ASbGncvRlhrT0l5hyBZRloc61Zi3qNaI6jaoDrxyF8meV5CTSF7N/1//pBXSc6Xzq+c
	hK54yRstaa973PWa1EJxj9nDA9RYvdGnUkcQxJ9SiWga2cGB48JNo5idtjGJkY5DrslJzXP8vCu
	HWlyLRdqjOpE568xTWFM+eUkQGN19k1F6hvIlAT+ExbbmXXCtCnd8hE5VLNg==
X-Google-Smtp-Source: AGHT+IG779g74JAa4JQX1nYslqaru5Ea+1orhthjmTq8Wce+O1Ct8bjs0tVTT9/QwOzvLO84Vdy5Ye19r9YGHHInUCQ=
X-Received: by 2002:a05:622a:1144:b0:476:7b0b:30fb with SMTP id
 d75a77b69052e-4771dd943e7mr124650191cf.22.1742687367370; Sat, 22 Mar 2025
 16:49:27 -0700 (PDT)
MIME-Version: 1.0
From: Nobuhiro Iwamatsu <iwamatsu@gmail.com>
Date: Sun, 23 Mar 2025 08:49:16 +0900
X-Gm-Features: AQ5f1JqNWN4aM6ZG-avPDzWaGsoYOm9mADnqvbWIuMsalEKiBH8P2Xb8yh0g3ZM
Message-ID: <CACe6DC4oSV6vkD8mq+YPAmf1Dgdu+jiKjKd1Pt2s1X-FF2DUSQ@mail.gmail.com>
Subject: [ANNOUNCE] Release v6.1.131-cip39
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, jan.kiszka@siemens.com, masami.ichikawa@cybertrust.co.jp, 
	Chris Paterson <Chris.Paterson2@renesas.com>, uli@fpond.eu
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 22 Mar 2025 23:49:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18332

Hi all,

CIP kernel team has released Linux kernel v6.1.131-cip39.
The linux-6.1.y-cip tree has been updated base version from v6.1.129
to v6.1.131.
This release also applpied updates to the RZ/G3E SCIF.

You can get this release via the git tree at:

  v6.1.131-cip39:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      82d42b8475bb4748ab569c58038cd768efc6ba81
    fixed CVEs:
      CVE-2024-47754: media: mediatek: vcodec: Fix H264 multi
stateless decoder smatch warning
      CVE-2024-40973: media: mtk-vcodec: potential null pointer deference in SCP
      CVE-2025-21855: ibmvnic: Don't reference skb after sending to VIOS
      CVE-2025-21862: drop_monitor: fix incorrect initialization order
      CVE-2023-52927: netfilter: allow exp not to be removed in
nf_ct_find_expectation
      CVE-2024-26982: Squashfs: check the inode number is not the
invalid value of zero
      CVE-2024-58002: media: uvcvideo: Remove dangling pointers
      CVE-2025-21858: geneve: Fix use-after-free in geneve_find_dev().
      CVE-2025-21859: USB: gadget: f_midi: f_midi_complete to call queue_work
      CVE-2025-21848: nfp: bpf: Add check for nfp_app_ctrl_msg_alloc()
      CVE-2024-57977: memcg: fix soft lockup in the OOM process
      CVE-2024-26767: drm/amd/display: fixed integer types and null
check locations
      CVE-2025-21838: usb: gadget: core: flush gadget workqueue after
device removal
      CVE-2025-21712: md/md-bitmap: Synchronize bitmap_get_stats()
with bitmap lifetime
      CVE-2025-21846: acct: perform last write from workqueue
      CVE-2024-58005: tpm: Change to kvalloc() in eventlog/acpi.c
      CVE-2025-21865: gtp: Suppress list corruption splat in
gtp_net_exit_batch_rtnl().
      CVE-2025-21844: smb: client: Add check for next_buffer in
receive_encrypted_standard()
      CVE-2024-58079: media: uvcvideo: Fix crash during unbind if gpio
unit is in use
      CVE-2025-21864: tcp: drop secpath at the same time as we
currently drop dst
      CVE-2024-53166: block, bfq: fix bfqq uaf in bfq_limit_depth()
      CVE-2025-21866: powerpc/code-patching: Fix KASAN hit by not
flagging text patching area as VM_ALLOC
      CVE-2025-21702: pfifo_tail_enqueue: Drop new packet when sch->limit == 0
      CVE-2024-24855: NULL pointer dereference bug was found in scsi
device driver
      CVE-2025-21721: nilfs2: handle errors that nilfs_prepare_chunk()
may return
      CVE-2025-21756: vsock: Keep the binding until socket destruction
      CVE-2024-43831: media: mediatek: vcodec: Handle invalid decoder vsi
      CVE-2024-50246: fs/ntfs3: Add rough attr alloc_size check
    added commits:
      CIP: Bump version suffix to -cip39 after merge from stable
      serial: sh-sci: Increment the runtime usage counter for the
earlycon device
      serial: sh-sci: Clean sci_ports[0] after at earlycon exit
      serial: sh-sci: Move runtime PM enable to sci_probe_single()
      serial: sh-sci: Check if TX data was written to device in .tx_empty()
      serial: sh-sci: Use plain struct copy in early_console_setup()
      serial: sh-sci: Add support for RZ/V2H(P) SoC
      serial: sh-sci: describe locking requirements for invalidating RXDMA
      dt-bindings: serial: renesas: Document RZ/G3E (r9a09g047) scif
      dt-bindings: serial: Add documentation for Renesas RZ/V2H(P)
(R9A09G057) SCIF support
      dt-bindings: serial: renesas,scif: Make 'interrupt-names'
property as required
      dt-bindings: serial: renesas,scif: Validate 'interrupts' and
'interrupt-names'
      dt-bindings: serial: renesas,scif: Move ref for serial.yaml at the end

Best regards,
   Nobuhiro

-- 
Nobuhiro Iwamatsu (Toshiba)

