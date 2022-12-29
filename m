Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DBDC4332F
	for <webhook@archiver.kernel.org>; Thu, 29 Dec 2022 00:00:58 +0000 (UTC)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
 by mx.groups.io with SMTP id smtpd.web11.195216.1672272048557154622
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Dec 2022 16:00:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=exvk4fdf;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.47, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f47.google.com with SMTP id m7-20020a9d73c7000000b00683e2f36c18so5660836otk.0
        for <cip-dev@lists.cip-project.org>; Wed, 28 Dec 2022 16:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wkurkTNrNi4EhECWZAjlqEpBZLpk1hYO0AiKEoiRyng=;
        b=exvk4fdfky3eIyoL0BLxPbFyVRWR0GbeUeT18sh0mC3aI1Gucu1frSUo+T8oj4Wwc9
         wvB56aCmQ2i1JVQ8XaWQ3i3wq9Nk1OWcWfQ6wPNSDpp9JNTPzJ+dft5wxNWS51L5BQFY
         /Z5iv8QA0PUtrcpWHbgwvYSIWsDQdgIgdl6O8eRCW/BHULI0a4Z6q+fCvYLYdEaZSdSR
         xamtpEw0e4Wb61mnC8cAmEpRcZzr1pGU6/t6OhJWZ3YBeRerD9RUp0Iolk4b64ikg+Zg
         wBar5EcTG08VwIDhKR8+qW1i8rfnU9zX5O+PYbfk4bfkyKvU1DSkTp/A71FXaItJDar/
         8VBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wkurkTNrNi4EhECWZAjlqEpBZLpk1hYO0AiKEoiRyng=;
        b=VXqCmdW5N1dRWwl36res65gFX02oSFKYC2bGSn53hFwplL4wW8O1DAryE1aZj22GQN
         mG4RCetD8J5MP+lMY/5+8PExeRnpbkTUS/bW0aO2hnQMQ/eOA2+jOkEvHMxRqu5sDYTa
         huseLL9HaVdh0eBR9GCUdKsu7IvTBzXYnlSa1yxJAUNHYNvyIje9oR8aSvBnEi2uJe12
         v9lcaitkJ86171Cy4NRejshH7tp1Sbf9kaVjZJX/fKnHmmdm6o4XzHwJBuQC+OGHv9N6
         ZDehDEbGP2ihdpVRbFuz7hcDI29HACTlEz9ZxSYnwbyNL4m4g9HtBSLdEkopZUuYt8yT
         fNFw==
X-Gm-Message-State: AFqh2kppxBWr/hQ5xYS8b3xIrQYGwqOEsw77iH5CgtAc5VwUFkxbVH5u
	E2VQUj0OKDo7wDYJNHHVfB3pBSp2xlsmydtPNOmPGWOrbGfYEMZN
X-Google-Smtp-Source: AMrXdXu88WtxoDQsYvGoc3rtxPKkuyyUe2hdneBJGNEyNLM4IwFZC36G6vn0bhQDZtqv6Uds8tdw0u1F1FNRvGelo1s=
X-Received: by 2002:a9d:4e82:0:b0:66d:65a5:b0b3 with SMTP id
 v2-20020a9d4e82000000b0066d65a5b0b3mr1966442otk.170.1672272047288; Wed, 28
 Dec 2022 16:00:47 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 29 Dec 2022 09:00:11 +0900
Message-ID: <CAODzB9pn6Aa_UcgU3hTsMaZ_LR_+wFpjTJY3oDG7OamdTP2=Ew@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Dec 2022 00:00:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10271

Hi !

It's this week's CVE report.

This week reported 8 new CVEs and 0 updated CVEs.
The ksmbd subsystem got some CVEs which include RCE bug. These
vulnerabilities have been affected since 5.15.

* New CVEs

CVE-2022-4662: Nested device-reset call will cause deadlock in USB
core subsystem

CVSS v3 score is not provided

A flaw in incorrect access control in the Linux kernel USB core
subsystem was found in the way a user attaches an usb device. A local
user could use this flaw to crash the system.

stable and cip kernels are fixed.

Fixed status
mainline: [9c6d778800b921bde3bff3cff5003d1650f942d1]
stable/4.14: [1b29498669914c7f9afb619722421418a753d372]
stable/4.19: [cc9a12e12808af178c600cc485338bac2e37d2a8]
stable/4.9: [d90419b8b8322b6924f6da9da952647f2dadc21b]
stable/5.10: [abe3cfb7a7c8e907b312c7dbd7bf4d142b745aa8]
stable/5.15: [c548b99e1c37db6f7df86ecfe9a1f895d6c5966e]
stable/5.4: [df1875084898b15cbc42f712e93d7f113ae6271b]

CVE-2022-47938: Linux Kernel ksmbd Out-Of-Bounds Read
Denial-of-Service Vulnerability

CVSS v3 score is not provided

An issue was discovered in ksmbd in the Linux kernel before 5.19.2.
fs/ksmbd/smb2misc.c has an out-of-bounds read and OOPS for
SMB2_TREE_CONNECT.

The specific flaw exists within the handling of SMB2_TREE_CONNECT
commands. The issue results from the lack of
proper validation of user-supplied data, which can result in a read
past the end of an allocated buffer. An attacker can
leverage this vulnerability to create a denial-of-service condition on
the system.

This bug was introduced by commit e2f3448 ("cifsd: add server-side
procedures for SMB3") in 5.15-rc1.
Kernel version less than 5.15 isn't affected.

Fixed status
mainline: [824d4f64c20093275f72fc8101394d75ff6a249e]
stable/5.15: [577619605556a90e64abc759ca3ad9d86bf51176]

CVE-2022-47939: Linux Kernel ksmbd Use-After-Free Remote Code
Execution Vulnerability

CVSS v3 score is not provided

An issue was discovered in ksmbd in the Linux kernel before 5.19.2.
fs/ksmbd/smb2pdu.c has a use-after-free and OOPS for
SMB2_TREE_DISCONNECT.

This vulnerability allows remote attackers to execute arbitrary code
on affected installations of Linux Kernel.
Authentication is not required to exploit this vulnerability, but only
systems with ksmbd enabled are vulnerable.

The specific flaw exists within the processing of SMB2_TREE_DISCONNECT commands.
The issue results from the lack of validating the existence of an
object prior to performing operations on the object.
An attacker can leverage this vulnerability to execute code in the
context of the kernel.

This bug was introduced by commit e2f3448 ("cifsd: add server-side
procedures for SMB3") in 5.15-rc1.
Kernel version less than 5.15 isn't affected.

Fixed status
mainline: [cf6531d98190fa2cf92a6d8bbc8af0a4740a223c]
stable/5.15: [a54c509c32adba9d136f2b9d6a075e8cae1b6d27]

CVE-2022-47940: Linux Kernel ksmbd Out-Of-Bounds Read Information
Disclosure Vulnerability

CVSS v3 score is not provided

An issue was discovered in ksmbd in the Linux kernel 5.15 through 5.18
before 5.18.18. fs/ksmbd/smb2pdu.c lacks length validation in the
non-padding case in smb2_write.

This vulnerability allows remote attackers to disclose sensitive information
on affected installations of Linux Kernel. Authentication is required
to exploit this vulnerability.

The specific flaw exists within the handling of SMB2_WRITE commands.
The issue results from the lack of proper validation of user-supplied data,
which can result in a read past the end of an allocated buffer.
An attacker can leverage this in conjunction with other
vulnerabilities to execute arbitrary code in the context of the
kernel.

This bug was introduced by commit e2f3448 ("cifsd: add server-side
procedures for SMB3") in 5.15-rc1.
Kernel version less than 5.15 isn't affected.

Fixed status
mainline: [158a66b245739e15858de42c0ba60fcf3de9b8e6]

CVE-2022-47941: Linux Kernel ksmbd Memory Exhaustion Denial-of-Service
Vulnerability

CVSS v3 score is not provided

An issue was discovered in ksmbd in the Linux kernel 5.15 through 5.19
before 5.19.2. fs/ksmbd/smb2pdu.c omits a kfree call in certain
smb2_handle_negotiate error conditions, aka a memory leak.

This vulnerability allows remote attackers to create a
denial-of-service condition on affected installations of Linux Kernel.
Authentication is not required to exploit this vulnerability.

The specific flaw exists within the handling of SMB2_NEGOTIATE commands.
The issue results from the lack of memory release after its
effective lifetime. An attacker can leverage this vulnerability to
create a denial-of-service condition on the system.

This bug was introduced by commit e2f3448 ("cifsd: add server-side
procedures for SMB3") in 5.15-rc1.
Kernel version less than 5.15 isn't affected.

Fixed status
mainline: [aa7253c2393f6dcd6a1468b0792f6da76edad917]
stable/5.15: [dd4e4c811898410e6a3ae3b63207b7c542860907]

CVE-2022-47942: Linux Kernel ksmbd Heap-based Buffer Overflow Remote
Code Execution Vulnerability

CVSS v3 score is not provided

An issue was discovered in ksmbd in the Linux kernel 5.15 through 5.19
before 5.19.2.
There is a heap-based buffer overflow in set_ntacl_dacl, related to
use of SMB2_QUERY_INFO_HE after a malformed SMB2_SET_INFO_HE command.

This vulnerability allows remote attackers to execute arbitrary code
on affected installations of Linux Kernel.
Authentication is required to exploit this vulnerability.

The specific flaw exists within the handling of file attributes.
The issue results from the lack of proper validation of the length of
user-supplied
data prior to copying it to a heap-based buffer.
An attacker can leverage this vulnerability to execute code in the
context of the kernel.

This bug was introduced by commit e2f3448 ("cifsd: add server-side
procedures for SMB3") in 5.15-rc1.
Kernel version less than 5.15 isn't affected.

Fixed status
mainline: [8f0541186e9ad1b62accc9519cc2b7a7240272a7]
stable/5.15: [cb69d4d6f709f87c94afa28ae64c501576692171]

CVE-2022-47943: Linux Kernel ksmbd Out-Of-Bounds Read Information
Disclosure Vulnerability

CVSS v3 score is not provided

An issue was discovered in ksmbd in the Linux kernel 5.15 through 5.19
before 5.19.2.
There is an out-of-bounds read and OOPS for SMB2_WRITE, when there is
a large length in the zero DataOffset case.

This vulnerability allows remote attackers to disclose sensitive
information on affected installations of Linux Kernel.
Authentication is required to exploit this vulnerability.

The specific flaw exists within the handling of SMB2_WRITE commands.
The issue results from the lack of proper validation of user-supplied
data, which can result in a read past the end of an allocated buffer.
An attacker can leverage this in conjunction with other
vulnerabilities to execute arbitrary code in the context of the
kernel.

This bug was introduced by commit e2f3448 ("cifsd: add server-side
procedures for SMB3") in 5.15-rc1.
Kernel version less than 5.15 isn't affected.

Fixed status
mainline: [ac60778b87e45576d7bfdbd6f53df902654e6f09]
stable/5.15: [c76b216753c9eb2950a091037c9976f389e73529]

CVE-2022-47946:  A use-after-free in io_sqpoll_wait_sq in fs/io_uring.c

CVSS v3 score is not provided

An issue was discovered in the Linux kernel 5.10.x before 5.10.155. A
use-after-free in io_sqpoll_wait_sq in fs/io_uring.c allows an
attacker to crash the kernel, resulting in denial of service.
finish_wait can be skipped. An attack can occur in some situations by
forking a process and then quickly terminating it. NOTE: later kernel
versions, such as the 5.15 longterm series, substantially changed the
implementation of io_sqpoll_wait_sq.

Commit 0f54435 ("io_uring: kill goto error handling in
io_sqpoll_wait_sq()") is based on mainline's commit 70aacfe
("io_uring: kill sqo_dead and sqo submission halting") in 5.12-rc2.

5.4 kernel doesn't contain io_sqpoll_wait_sq().

Fixed status
stable/5.10: [0f544353fec8e717d37724d95b92538e1de79e86]

* Updated CVEs

No update this week.

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

