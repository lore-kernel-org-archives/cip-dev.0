Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F183E936F0
	for <webhook@archiver.kernel.org>; Wed,  4 Oct 2023 22:10:07 +0000 (UTC)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
 by mx.groups.io with SMTP id smtpd.web10.1788.1696457399524711811
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Oct 2023 15:10:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=uaYMoG2q;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.50, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-57ddde51033so730852eaf.1
        for <cip-dev@lists.cip-project.org>; Wed, 04 Oct 2023 15:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1696457398; x=1697062198; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r3k2M4jQ1Qp45w3ZqlhQz7Pb+Llj5UdciUKUcS7K4yE=;
        b=uaYMoG2qshwu8vPi6YMLDORQChjcDzJIaqGlw9quBLzWkA5EcV4MMNiMxsr4i/0ZrI
         3Pidi+YnjEMlajcSuqdM5cbLTymjd8YwO0FI3h5SyfvOTo/qwSs06ktkAwFL7aQ9wHSj
         ORdkiDm8qESfNOP/c1hz9Mjjf8/Dlwh0s5wUU4QRD2/Rq8zgImmVZNoYdDe2PjGmItyr
         0zz4XOnmiCNFbXUbiFHVusW9908O7nIJxkOD1cnEn1u3OZpv6Jbh1Fc+H5mzqGJwtMG/
         ojdcPqBLJvAiWE/wZCPkkVhZ65D9yZl4iXDUi3WAKRWpAhg4C6OmdO45oKWT7XAds8A2
         a3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696457398; x=1697062198;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r3k2M4jQ1Qp45w3ZqlhQz7Pb+Llj5UdciUKUcS7K4yE=;
        b=WxG9ukl2HC24ghHYZVBbwypxTUJqZ1ifnTpALcTqVAwiO9jxrH28K5VgPzFTvTOJK9
         902DVoabyiE99KDktBnw7zp6E1LP9600iV97CHui3ZEJAX4zbWEkmbtRjbqV4NClXiPT
         NlyB3Q8aePZP+XmsYxLquQLl2WVWMpVN+2K/JDslDWSFxb3TpQ5wiKhvCwR9063hs0J/
         ypRXSPLD4qtaVnmWkO1aIoa6UgCDINz/s15AWEUZV4iHOIhIsUuY95z2FcQ96ULJ2Ruc
         ShwpTTOk8O3yv+EmROcCCI40Xqi6uSm69nSL0XCXj5XX7DFWgSKuCGMkK664rk2xnYyY
         MoWg==
X-Gm-Message-State: AOJu0YyS0l9SP3hOoOwmRDCFA/Cih0Qf0c+S+/2nyYrUe/7MW69OHz41
	3oUMONHpU2vAPaAoP5FVY1aTEfs8f0viBsLOFF8b97MLqN/wbRczUQU=
X-Google-Smtp-Source: AGHT+IFKmvsung/RnNiKsJCrLwXWItv2rlSnQIBVNpWzaueAUrAbKHwqRVwaPoSpDB99JNBytz89yG3VDjN6wZ6BWzM=
X-Received: by 2002:a05:6870:7021:b0:1d7:1a69:5056 with SMTP id
 u33-20020a056870702100b001d71a695056mr490676oae.14.1696457398247; Wed, 04 Oct
 2023 15:09:58 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 5 Oct 2023 07:09:22 +0900
Message-ID: <CAODzB9qGjXFSyuKbeNNWKLarGQkWMsWj1q1bO0n53P9dwK4J+g@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Oct 2023 22:10:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13290

Hi !

It's this week's CVE report.

This week reported 6 new CVEs and 0 updated CVEs.

* New CVEs

CVE-2023-44466: libceph: harden msgr2.1 frame segment length checks

CVSS v3 score is 8.8 HIGH.

An issue was discovered in net/ceph/messenger_v2.c in the Linux kernel
before 6.4.5. There is an integer signedness error,
leading to a buffer overflow and remote code execution via HELLO or
one of the AUTH frames. This occurs because of an
untrusted length taken from a TCP packet in ceph_decode_32.

This bug was introduced by commit cd1a677 ("libceph, ceph: implement
msgr2.1 protocol (crc and secure modes)") in 5.11-rc1.
So, 4.4, 4.14, 4.19, 5.4, and 5.10 are not affected.

Fixed status
mainline: [a282a2f10539dce2aa619e71e1817570d557fc97]
stable/5.15: [db8ca8d9b4dfce6d8cded796f0e671ef2c782613]
stable/6.1: [183c0ae4fafcdcb95c06f40c0c35a39d89c1aa2d]

CVE-2023-42754: null pointer dereference in Linux kernel ipv4 stack

CVSS v3 score is not provided.

A null pointer dereference bug was found in the
ipv4_send_dest_unreach" function in the net/ipv4/route.c.
This bug was introduced by commit ed0de45 ("ipv4: recompile ip options
in ipv4_link_failure") in 5.1-rc6.
The commit ed0de45 was backported to 4.4, 4.14, and 4.19 so these
kernels are affected as well.

To abuse this bug, an attacker requires CAP_NET_ADMIN privilege.

Fixed status
mainline: [0113d9c9d1ccc07f5a3710dac4aa24b6d711278c]

CVE-2023-4732: mm/userfaultfd: fix uffd-wp special cases for fork()

CVSS v3 score is not provided (NIST).
CVSS v3 score is 4.7 MEDIUM (CNA).

A flaw was found in the Linux Kernel's memory management subsystem. A
task exits and releases a 2MB page in a vma (vm_area_struct) and hits
the BUG statement in pfn_swap_entry_to_page() referencing pmd_t x.

This bug was introduced by commit b569a17 ("userfaultfd: wp: drop
_PAGE_UFFD_WP properly when fork") in 5.7-rc1.
The commit b569a17 is not backported to older stable kernels.

Fixed status
mainline: [8f34f1eac3820fc2722e5159acceb22545b30b0d]
stable/5.10: [9e1cf2d1ed37c934c9935f2c0b2f8b15d9355654]

CVE-2023-5345: fs/smb/client: Reset password pointer to NULL

CVSS v3 score is not provided (NIST).
CVSS v3 score is 7.8 MEDIUM (CNA).

A use-after-free vulnerability in the Linux kernel's fs/smb/client
component can be exploited to achieve local privilege escalation. In
case of an error in smb3_fs_context_parse_param, ctx->password was
freed but the field was not set to NULL which could lead to double
free.

Fixed status
mainline: [e6e43b8aa7cd3c3af686caf0c2e11819a886d705]

CVE-2023-4610: slab-use-after-free Read in radix_tree_lookup

CVSS v3 score is not provided.

A use-after-free bug was found in lib/radix-tree.c which allows a
local attacker to crash the system, and lead to kernel infomation
leak.

Fixed status
Not fixed yet

* Updated CVEs

No update CVEs this week.

Fixed status

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

