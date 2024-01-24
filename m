Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F47C46CD2
	for <webhook@archiver.kernel.org>; Wed, 24 Jan 2024 23:18:31 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
 by mx.groups.io with SMTP id smtpd.web11.2545.1706138301354011545
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Jan 2024 15:18:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=xELWVAYD;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.51, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-20451ecbb80so3108106fac.2
        for <cip-dev@lists.cip-project.org>; Wed, 24 Jan 2024 15:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1706138300; x=1706743100; darn=lists.cip-project.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LGTCUd4K4UtD/3Y4s7mA9kQZIMWXVj+nnBbXQRZMPW8=;
        b=xELWVAYDU99BzUP6MugZfuyPUFPUiSrdoerobsOTfWQH0Y0aqB2V4SXQZ9NEOJ82Vn
         bfu2jfTtvJ8yo0iWxa5HH8rJnKMNsQ7lHCaNO13M2T57/ltTmakDF+EIfIFKaDp1bntK
         Ws7nO0vndXxpTP/a4Pb+uOpYROgCkHsylfphjfVuNRolrurQOL2AhxwpGUvJOR7CZew7
         RZLnqe6tP3qYv7adwB/KjXUUbHpZO75IBeybIoSNqaVi2MdNIMifdbdWpp568yD7Lcd0
         bGdbUyBS7Uw95IAN/L93j/ya937Yek+M50L6AJJpUkImCYHgT949WzKjtMfirfqXTiTe
         R7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706138300; x=1706743100;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LGTCUd4K4UtD/3Y4s7mA9kQZIMWXVj+nnBbXQRZMPW8=;
        b=b3jCSkK0EAXKTkaXGl2/0iQW7RpgKyr44uj+hf6nMTuB8niz3r7zuJ8581WGPUF+ij
         V8UOFCwfN+czyjvmF3BI/dVicmxtedV41jrL3sB1x+waaO2TFVLJPBiuJOwGo6mvXMYs
         CAx1FzxUsTXJz3jR4MGsZj2399syfJ7qoPHuWuQz1ysC2YZZCAmJpjJTx0SR1MqpZPe6
         c3UO6vGK4j1scgWjnwDzrCZ0TbgaueD/0LVuLsObu57JzxwKdUtDxvpSOIQUw56k5x52
         /WUP7I55fE4hmm8ravB9hYx+FKhWx1LtRJGpFuSBUlRNNoFxhkGojObhDB97LDBi06Km
         xV9A==
X-Gm-Message-State: AOJu0Yx+9zdgaN+46idu9WJiplJvtOjJcP2SseGlZ4uTFHTUm1hg6xVr
	mdxdKN3FDdkVKhDJvJ17hBVN2j061e1mcCNJPsvNkfdToQx9aSgRaI2gMFBuXr5PqEfTlxMO+Ea
	FbjulX/PdWgAvubRWaJq14P0SpIneamv8toc413BND4yDbNn0j6s=
X-Google-Smtp-Source: AGHT+IEN6CMvvh1EJuejAWZx5mFlHtz42IBgipIhDUq0sTlwQEko1d27VjOTkrNLvn0PCNgJXaRZMvL3MnbMHrVNJy4=
X-Received: by 2002:a05:6870:f818:b0:213:aee1:6e67 with SMTP id
 fr24-20020a056870f81800b00213aee16e67mr25861oab.99.1706138300097; Wed, 24 Jan
 2024 15:18:20 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 25 Jan 2024 08:17:43 +0900
Message-ID: <CAODzB9rvbGVREi_HHLU4Ynd3+khL-vGWG3Ek=NtOrNt5dZDWXg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Jan 2024 23:18:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14455

Hi!

It's this week's CVE report.

This week reported 12 new CVEs and 4 updated CVEs.

* New CVEs

CVE-2024-0639: A deadlock bug causes DoS in the SCTP subsystem

CVSS v3(NIST): 5.5 (MEDIUM)
CVSS v3(CNA): 4.7 (MEDIUM)

A denial of service vulnerability due to a deadlock was found in
sctp_auto_asconf_init in net/sctp/socket.c in the Linux kernel=E2=80=99s SC=
TP
subsystem.
This flaw allows guests with local user privileges to trigger a
deadlock and potentially crash the system.

Introduced by commit 34e5b01 ("sctp: delay auto_asconf init until
binding the first addr") in 5.13-rc1. Fixed in 6.5-rc1.
The commit 34e5b01 is not backported to 4.19 and 4.4 so these kernels
are not affected.

Fixed status
cip/4.4-st: [bda06654a7e8d5d572c4df906e888a00d5d9c8a1]
mainline: [6feb37b3b06e9049e20dcf7e23998f92c9c5be9a]
stable/4.19: [0ad0e8b0cb0e28626ab6dffe3da883941b9cbc4b]
stable/5.10: [6d2243ab783bf79d1d674ff0ca26229233c56508]
stable/5.15: [1fba2510b52f0bb9f408700e78db6d8d0ed6bcd5]
stable/5.4: [4d8fc6137749471ba0f64c9bc64e98113c015ed7]
stable/6.1: [1aa5a6a6d28c77e364feaba35ff7f12d2d74fec1]

CVE-2024-0641: A DoS vulnerability was found in the TIPC subsystem

CVSS v3(NIST): 5.5 (MEDIUM)
CVSS v3(CNA): 4.7 (MEDIUM)

A denial of service vulnerability was found in tipc_crypto_key_revoke
in net/tipc/crypto.c in the Linux kernel=E2=80=99s TIPC subsystem.
This flaw allows guests with local user privileges to trigger a
deadlock and potentially crash the system.

Introduced by commit fc1b6d6 ("tipc: introduce TIPC encryption &
authentication") in 5.5-rc1. Fixed in 6.6-rc5.

Fixed status
mainline: [08e50cf071847323414df0835109b6f3560d44f5]
stable/5.10: [6a24d0661fa389c241d935da38e0f6a5ee8eb1ae]
stable/5.15: [24fb22bddb71c6bfbe0fe25e1b7f793c5b580918]
stable/6.1: [143e72757a902abcecd5f487553f44dc19a56cfc]

CVE-2023-46838: Linux: netback processing of zero-length transmit fragment

CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Transmit requests in Xen's virtual network protocol can consist of
multiple parts.
While not really useful, except for the initial part any of them may
be of zero length,
i.e. carry no data at all.  Besides a certain initial portion of the
to be transferred data, these parts are
directly translated into what Linux calls SKB fragments.  Such
converted request parts can,
when for a particular SKB they are all of length zero, lead to a
de-reference of NULL in core networking code.

According to the commit log c7ec4f2d ("xen-netback: don't produce
zero-size SKB frags") it said that

"""
While frontends may submit zero-size requests (wasting a precious
slot), core networking code as of at least 3ece782
("sock: skb_copy_ubufs support for compound pages") can't deal with
SKBs when they have all zero-size fragments.
"""

the commit 3ece782 ("sock: skb_copy_ubufs support for compound pages")
is not back ported to Linux 4.4.

Fixed status
mainline: [c7ec4f2d684e17d69bbdd7c4324db0ef5daac26a]

CVE-2024-0775: A use-after-free bug was found in the ext4 file system

CVSS v3(NIST): N/A
CVSS v3(CNA): 6.7 (MEDIUM)

A use-after-free flaw was found in the __ext4_remount in
fs/ext4/super.c in ext4 in the Linux kernel. This flaw allows a local
user to cause
an information leak problem while freeing the old quota file names
before a potential failure, leading to a use-after-free.

It was fixed in 6.4-rc2.

Fixed status
cip/4.4-rt: [801ba552e9546571d60c628f98cd2db2301fca49]
mainline: [4c0b4818b1f636bc96359f7817a2d8bab6370162]
stable/4.19: [37302d4c2724dc92be5f90a3718eafa29834d586]
stable/5.10: [37c69da3adc45fc34df0b8d07a158a6fa5b2a3f7]
stable/5.15: [b2f1314e6e36e2322554e5e6e9598eedd349d942]
stable/5.4: [2dda2029067106f0835655a0417f1a5eaf3ba0b0]
stable/6.1: [25c9fca7b71c5045d6dc537430af5b2e79598fa1]

CVE-2023-46343: NULL pointer dereference bug was found in net/nfc/nci/spi.c

CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel before 6.5.9, there is a NULL pointer dereference
in send_acknowledge in net/nfc/nci/spi.c.

Introduced by commit 391d8a2 ("NFC: Add NCI over SPI receive") in
3.11-rc1. Fixed in 6.6-rc7.

Fixed status
cip/4.4-st: [bee47349504c09414e9602292a87af6fadc1a583]
mainline: [7937609cd387246aed994e81aa4fa951358fba41]
stable/4.19: [5622592f8f74ae3e594379af02e64ea84772d0dd]
stable/5.10: [c95fa5b20fe03609e0894656fa43c18045b5097e]
stable/5.15: [ffdc881f68073ff86bf21afb9bb954812e8278be]
stable/5.4: [76050b0cc5a72e0c7493287b7e18e1cb9e3c4612]
stable/6.1: [d7dbdbe3800a908eecd4975c31be47dd45e2104a]

CVE-2023-51042: A use-after-free bug was found in
drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c

CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel before 6.4.12, amdgpu_cs_wait_all_fences in
drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c has a fence use-after-free.
It was fixed in 6.5-rc1.

Fixed status
mainline: [2e54154b9f27262efd0cb4f903cc7d5ad1fe9628]
stable/4.19: [f9da11d96bde3db277f061ac5a665c234d505787]
stable/5.10: [b870b9a47fdba29bd6828f690e4817c950fa3430]
stable/5.15: [ef568da1fd843581e855c79a368209b752dea2c1]
stable/5.4: [c6059af6bf5ed436b4aa5229e8113bd2546322d4]
stable/6.1: [dd0b3b367c3839e439f36af908b39c98929a5e54]

CVE-2023-51043: A use-after-free bug was found in drivers/gpu/drm/drm_atomi=
c.c

CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel before 6.4.5, drivers/gpu/drm/drm_atomic.c has a
use-after-free during a race condition between a nonblocking atomic
commit and a driver unload.
It seems as if it would be nice to call drm_dev_ref() in
drm_atomic_state_init() and call drm_dev_unref() in
drm_atomic_state_free() to put/get instance of dev in Linux 4.4.

It fixed in 6.5-rc3.

Fixed status
mainline: [4e076c73e4f6e90816b30fcd4a0d7ab365087255]
stable/4.19: [73a82b22963defa87204f0f9f44a534adf7f831a]
stable/5.10: [f09c0ac142c59495262dd80545f261b2aeeba538]
stable/5.15: [30580f3a3301173b1413a7b6d6ea100ec8c75da0]
stable/5.4: [380c7ceabdde0ea5b4e709620f299bcd5c1c8abc]
stable/6.1: [e4a0e09b79bd2c0895c508cdc5e0265a083cc05d]

CVE-2024-22705: ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()

CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

An issue was discovered in ksmbd in the Linux kernel before 6.6.10.
smb2_get_data_area_len in fs/smb/server/smb2misc.c can cause an
smb_strndup_from_utf16 out-of-bounds access because the relationship
between Name data and CreateContexts data is mishandled.
It was fixed in 6.7-rc8.

Fixed status
mainline: [d10c77873ba1e9e6b91905018e29e196fd5f863d]
stable/5.15: [d739f2b6d8f57aa9377362cd8c0b1152a4dd6bd5]
stable/6.1: [7a3bbbadac4be9d30b45e9f1134e94294f79ce77]
stable/6.6: [7d5f219f1ef69f27eb8cbfb794d634fc9c4d24ac]

CVE-2024-23848: A use-after-free bug was found in
drivers/media/cec/core/cec-adap.c

CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel through 6.7.1, there is a use-after-free in
cec_queue_msg_fh, related to drivers/media/cec/core/cec-adap.c and
drivers/media/cec/core/cec-api.c.

Fixed status
Not fixed yet.

CVE-2024-23849: An oob access bug was found in net/rds/af_rds.c

CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In rds_recv_track_latency in net/rds/af_rds.c in the Linux kernel
through 6.7.1, there is an off-by-one error for an
RDS_MSG_RX_DGRAM_TRACE_MAX comparison,
resulting in out-of-bounds access.

It was introduced by commit 3289025aedc0 ("RDS: add receive message
trace used by application") in 4.11-rc1.

Fixed status
Patch is in the netdev tre.

CVE-2024-23850: btrfs: do not ASSERT() if the newly created subvolume
already got read

CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In btrfs_get_root_ref in fs/btrfs/disk-io.c in the Linux kernel
through 6.7.1, there can be an assertion failure and crash because a
subvolume can be read out too
soon after its root item is inserted upon subvolume creation.

It was introduced by commit 2dfb1e43f57d ("btrfs: preallocate anon
block device at first phase of snapshot creation") in 5.9-rc1.

Fixed status
Patch is available
(https://lore.kernel.org/all/6a80cb4b32af89787dadee728310e5e2ca85343f.17057=
41883.git.wqu%40suse.com/)
but it hasn't been merged yet.

CVE-2024-23851: Kernel crash in drivers/md/dm-ioctl.c when allocate
memory more than INT_MAX bytes

CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

copy_params in drivers/md/dm-ioctl.c in the Linux kernel through 6.7.1
can attempt to allocate more than INT_MAX bytes, and crash, because of
a missing
param_kernel->data_size check. This is related to ctl_ioctl.

Fixed status
Not fixed yet.

* Updated CVEs

CVE-2023-50431: habanalabs: fix information leak in sec_attest_info()

The mainline was fixed.

Fixed status
mainline: [a9f07790a4b2250f0140e9a61c7f842fd9b618c7]

CVE-2023-6915: ida: Fix crash in ida_free when the bitmap is empty

stable 6.1 and 6.6 are fixed.

Fixed status
mainline: [af73483f4e8b6f5c68c9aa63257bdd929a9c194a]
stable/6.1: [9efdc0081ccae62c44a929e21d32bacc5f2e113f]
stable/6.6: [ffcaafdb8be64555e9928d943a3655c755dba92b]

CVE-2023-6610: OOB Access in smb2_dump_detail

stable 6.1 and 6.6 are fixed.

Fixed status
mainline: [567320c46a60a3c39b69aa1df802d753817a3f86]
stable/6.1: [5411e3292792be7dafd1fe948a87e3ca29c1f550]
stable/6.6: [c5e0ed716c52fddea5e625668e75658c3b81d3fc]

CVE-2022-36402: An integer overflow vulnerability was found in vmwgfx drive=
r

The mainline, 5.10, 5.15, and 6.1 are fixed.
This vulnerability was introduced by commit d80efd5 ("drm/vmwgfx:
Initial DX support") in 4.3-rc1.
It was fixed in 6.5.

Fixed status
mainline: [14abdfae508228a7307f7491b5c4215ae70c6542]
stable/5.10: [8735d1c66c7cf54e7b265a2911891f75674db342]
stable/5.15: [c8aab333d41a4ed6c5e7987c6cc5505ab86b5652]
stable/6.1: [115f2ccd3a998fe7247f59f8fb5feffc878bcbb7]

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

