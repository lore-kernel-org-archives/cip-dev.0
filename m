Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3B1C7EE23
	for <webhook@archiver.kernel.org>; Wed, 31 May 2023 23:55:36 +0000 (UTC)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
 by mx.groups.io with SMTP id smtpd.web10.1754.1685577331982740018
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 May 2023 16:55:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=PptjX3u4;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.50, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-55554c33bf3so209543eaf.2
        for <cip-dev@lists.cip-project.org>; Wed, 31 May 2023 16:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1685577330; x=1688169330;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XeKZzkd31o/eBzBkjGSi3m9WRDIu5TeB+5Baz6MLiNs=;
        b=PptjX3u4OEr8GUOpgL/IL6QLydQG6ORnCZfDpmpkRD7t7VwQSmfJhzA5C6Nj4xx7EV
         swadoDIsoGCP9hg/q6wc1EJ4g6P+xzj19rxcE9PNcGi7XLGddrOY2BnXiAQ7sIbgz9I7
         ePZ6+DonfJC2fLvxYaxMyxXN/zMBHfWFjcFCcwvHIuXNUuIuKGMxxweRDx8i6bo646Jf
         qoGHXGWofkg/5i3Imj7XsVFw8mDBRu/NJvZkt2iCKF2Gu/wGFVniJ9lqi6ZsF87cDu4W
         41Djrh+tZhX3rxgv2YyH5rn6Au0gYwG91B2b51yI+AtVJU412T8farPmlYMonL0ajGrB
         HF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685577330; x=1688169330;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XeKZzkd31o/eBzBkjGSi3m9WRDIu5TeB+5Baz6MLiNs=;
        b=aS6njQpDiSC4wgbLCJWZw/D8tX5iseyKE6LmXnjv+fnQtTLNYGl6v+fPrwQIAcGiY0
         mRdQoQ3dZYtGL04GQ6dnBObnW1w8GacvTlXOjOZxe1FjjRBeSHRDc35UzNWvFP3GpGsI
         sTYWaogjVFvycWD27a/XATU/qdy7T3NHyQ57eoszIKn4SOwXgfVRZk03NU/PGUNTT5nR
         siBSj10NDp/7kcdT3OjK8fKkBJWMBarKPzmZtysvfxAfrKNx0//laevXny6KSWrOIyHm
         xMaXTTObY8f4AOIJZZlCdWeTDloJ+bYJ+Y/tu1bprQqXadcPqnQW7oivBch16YnO8moQ
         uCFg==
X-Gm-Message-State: AC+VfDzO6zcOpSzvaE1C9IFM0FOP6QX+2WYKdWtP3rR0eFwk8pSGrEBn
	F2j/sJVXk4hcnlMe8ylLvMX2OkeBvn5yS+7oRji9amWBgBeQm+wJqnw=
X-Google-Smtp-Source: ACHHUZ4VsClLSZxHVJNBRvaxjJJ/pI+O/SzWG+KjEwus6VvjsfZnoFf8gNV9e8HzBeCejyCIStf233IH/31f+o+PfuE=
X-Received: by 2002:a4a:45d2:0:b0:555:ccd3:6ea0 with SMTP id
 y201-20020a4a45d2000000b00555ccd36ea0mr3857245ooa.7.1685577330405; Wed, 31
 May 2023 16:55:30 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 1 Jun 2023 08:54:54 +0900
Message-ID: <CAODzB9pnPbijaBU_dS+mc5tSJsn=z_WkKXsuZf+mKr70mh0WXQ@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 May 2023 23:55:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11714

Hi !

It's this week's CVE report.

This week reported 5 new CVEs and 3 updated CVEs.

* New CVEs

CVE-2023-2898: f2fs: fix to avoid NULL pointer dereference f2fs_write_end_io()

CVSS v3 score is not provided.

There is a null-pointer-dereference flaw found in f2fs_write_end_io in
fs/f2fs/data.c in the Linux kernel. This flaw allows a local
privileged user to cause a denial of service problem.

This bug was introduced by commit b4b10061ef98 ("f2fs: refactor
resize_fs to avoid meta updates in progress") in 5.8-rc1.
5.4, 4.19, 4.14, and 4.4 kernels are not affected by this issue.

Fixed status
Patch available on the f2fs-devel mailing list but it hasn't been merged yet.
https://lore.kernel.org/linux-f2fs-devel/20230522124203.3838360-1-chao@kernel.org/

CVE-2023-2612: A race condition bug was found in shiftfs file system

CVSS v3 score is not provided (NIST).
CVSS v3 score is 4.4 MEDIUM (CNA).

Jean-Baptiste Cayrou discovered that the shiftfs file system in the
Ubuntu Linux kernel contained a race condition when handling inode
locking in some situations. A local attacker could use this to cause a
denial of service (kernel deadlock).

The shiftfs is out of tree kernel module so that mainline kernels are
not affected.

Fixed status
Fixed in ubuntu kernels.

CVE-2022-48502: fs/ntfs3: Check fields while reading

CVSS v3 score is not provided.

An issue was discovered in the Linux kernel before 6.2. The ntfs3
subsystem does not properly check for correctness during disk reads,
leading to an out-of-bounds read in ntfs_set_ea in fs/ntfs3/xattr.c.

The NTFS3 file system was introduced in 5.15 so that before 5.15
kernels aren't affected.

Fixed status
mainline: [0e8235d28f3a0e9eda9f02ff67ee566d5f42b66b]

CVE-2023-34255: xfs: verify buffer contents when we skip log replay

CVSS v3 score is not provided.

An issue was discovered in the Linux kernel through 6.3.5. There is a
use-after-free in xfs_btree_lookup_get_block in
fs/xfs/libxfs/xfs_btree.c because fs/xfs/xfs_buf_item_recover.c does
not perform buffer content verification when log replay is skipped.

The xlog_recover_buf_commit_pass2() was introduced in 5.8-rc1 by
commit 1094d3f1 ("xfs: refactor log recovery buffer item dispatch for
pass2 commit functions"). This commit changed the function name
xlog_recover_buffer_pass2() to xlog_recover_buf_commit_pass2().
So, it looks like before 5.8 kernels need to be patched to the
xlog_recover_buffer_pass2().

Fixed status
mainline: [22ed903eee23a5b174e240f1cdfa9acf393a5210]

CVE-2023-34256: ext4: avoid a potential slab-out-of-bounds in
ext4_group_desc_csum

CVSS v3 score is not provided.

An issue was discovered in the Linux kernel before 6.3.3. There is an
out-of-bounds read in crc16 in lib/crc16.c when called from
fs/ext4/super.c because ext4_group_desc_csum does not properly check
an offset.

This bug was introduced by commit 717d50e ("Ext4: Uninitialized Block
Groups ") in 2.6.24-rc1.

Fixed status
mainline: [4f04351888a83e595571de672e0a4a8b74f4fb31]
stable/4.14: [64b7487e3769e013fc7edb3804d1a769747f0228]
stable/4.19: [a733c466cedd1013a41fd8908d5810f2c161072f]
stable/5.10: [0dde3141c527b09b96bef1e7eeb18b8127810ce9]
stable/5.15: [6d9a705a653eb146b4991dbd198b258f787c70b1]
stable/5.4: [4f4fd982d972a55dee129f7da517b81fa16c408d]
stable/6.1: [1fffe4750500148f3e744ed77cf233db8342603f]
stable/6.3: [be7b6374a2ee8a59c1ff5addcbe25ebc1b4efd9f]

* Updated CVEs

CVE-2020-36694: A use-after-free bug was found in the netfilter

Commit 7f5c6d4f ("netfilter: get rid of atomic ops in fast path") was
merged in 5.12-rc5.
This commit fixes commit 7f5c6d4 ("netfilter: get rid of atomic ops in
fast path") in 3.0-rc in 3.0-rc1.

Fixed status
mainline: [175e476b8cdf2a4de7432583b49c871345e4f8a1]
stable/4.14: [f1fd7a174018f1107881150c6c2ce00e49a1e643]
stable/4.19: [81bc258370c6eeb1f41d350325e8a2c8e20fafad]
stable/5.10: [3fdebc2d8e7965f946a3d716ffdd482e66c1f46c]
stable/5.4: [19a5fb4ceada903e692de96b8aa8494179abbf0b]

CVE-2022-39189: KVM instruction emulation doesn't clear
KVM_VCPU_PREEMPTED, breaking guest's TLB flushing

Kernel 5.4 was fixed.

Fixed status
mainline: [6cd88243c7e03845a450795e134b488fc2afb736]
stable/5.10: [529f41f0eb1ef995bfa83c121c3cfe3a0720119a]
stable/5.15: [92343314d34e04da0923cefd3be67521d706fa35]
stable/5.4: [1eb3e32de7b1f6ed927dfff3ab3651ce25f3d516]

CVE-2022-4269: kernel: net: CPU soft lockup in TC mirred
egress-to-ingress action

Kernel 5.10 was fixed.

Fixed status
mainline: [ca22da2fbd693b54dc8e3b7b54ccc9f7e9ba3640]
stable/5.10: [53245103786312f21fb9785327a4367cf10f0dbb]
stable/5.15: [169a41073993add6b0cfdc44e168e75f92f4834d]
stable/6.1: [4c8fc3fe28e47e2a495444347375f7354c24b018]
stable/6.2: [8c9e553c58a491ad328c622441e08178373442dc]

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

