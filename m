Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB86CC433F5
	for <webhook@archiver.kernel.org>; Thu,  2 Dec 2021 00:57:50 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 by mx.groups.io with SMTP id smtpd.web08.2173.1638406667706855764
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Dec 2021 16:57:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=jwggT17Q;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.175,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f175.google.com with SMTP id q25so52376456oiw.0
        for <cip-dev@lists.cip-project.org>;
 Wed, 01 Dec 2021 16:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=4czqZW0ueDw28L6ZKjuAfSeww+jUcAAGc7pwmSUO8/A=;
        b=jwggT17QuIcVdeF5MiuZ034nr2cS5nL0anNnsnEYdNzSb/TBorglx2mMmxj0ZNiDZ5
         mwTZvkvigbo3Ax1b3gVo3Deo57oJOcQ4T2+fOsZFF0uXzSbzIdgN3dAFcMdDs50fVKDb
         FdJIp9YPqAdYJVk2QhilTBRhzCMI05jJNi+vBwn8gBIj+4eYPxyzitQq/ESrQ2ZyGKdU
         lCxDEGuFT53HEo79olMnFGPeaw+S2Um3tbPYkA8z56BfaJBSi6HNXJViHJ86QUZAVG/8
         jZ7y5su52Hx1iKNzr+kHWnZqVGQBZ1piNy+S3Bk96Q5dbFniyTAP42ZEzwhW2twPdxAO
         WXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4czqZW0ueDw28L6ZKjuAfSeww+jUcAAGc7pwmSUO8/A=;
        b=mnjWiNXf2IeoJ7+K5D0QhJIhzAFTcHu/LyBsz/14dO9pejfBipcL2L2r8Vl9XJ/CET
         5TSDcBiYEyXFJbkmz+2Paz5gbayCoR0ZClomLV1qoifbOg27JI9rihtSK+OZCkeb0WRg
         zDgQ585EP+pq5MPPGUROd+8EwvEqOYbECgk127vfB5QBztF2+yIdNjiaE56zckcx9UjJ
         URszCvIHE+oPTa7gdW24/r14Aa2JUb8nPN/MtQYTnrdR7umuThmbs7UoSVuyFbiQUYmV
         SIp76Lr1xV5bw7892VliEE/La4pGsgiO2wmlsySZ8TrbHLErosYZc5p17g6qO+q7I14C
         uUsA==
X-Gm-Message-State: AOAM531N14M4WbaeUnkQkgw2aUhJERf2+IIKIaWKZbImd9IGd9K7uU7C
	MJiM0XOMFugAj4XqRItAe4HRVLdnOoc4xpLwvsCzWwL/cPhlhg==
X-Google-Smtp-Source: 
 ABdhPJzeGbUEvpMeil0hzPGKXtaeCG/n5U57QcjCCHJj4YfIcaih8JcOtqOIOwiVlA0pK81oWwYDN7Cpr6JEvkKoPnE=
X-Received: by 2002:aca:674a:: with SMTP id b10mr1882697oiy.66.1638406666703;
 Wed, 01 Dec 2021 16:57:46 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 2 Dec 2021 09:57:11 +0900
Message-ID: 
 <CAODzB9o-BAG8cK+nxDOK2eZm91t9fo838wPRXrmwSUh=meAM1Q@mail.gmail.com>
Subject: New CVE entries in this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Dec 2021 00:57:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7057

Hi !

It's this week's CVE report.

This week reported 5 new CVEs.

* New CVEs

CVE-2021-4002: hugetlbfs: flush TLBs correctly after huge_pmd_unshare

It's already been fixed in the mainline. This bug was introduced since
3.6-rc1 so that all stable kernels will be affected by this
vulnerability.

CVSS v3 score is not provided

Fixed status

mainline: [a4a118f2eead1d6c49e00765de89878288d4b890]
stable/5.10: [40bc831ab5f630431010d1ff867390b07418a7ee]
stable/5.15: [556d59293a2a94863797a7a50890992aa5e8db16]
stable/5.4: [201340ca4eb748c52062c5e938826ddfbe313088]

CVE-2021-4028: use-after-free in RDMA listen()

CVSS v3 score is not provided

A local attacker can escalate privileges on the system by using this ufa bug.

Fixed status

Not fixed yet.

CVE-2021-4023: Improper IO-uring request cancellation operation allows
local users to cause a crash

According to the red hat bugzilla #2026484, it was fixed by commit
713b982 ("io-wq: fix cancellation on create-worker failure"). This bug
was introduced and fixed in 5.15-rc1. Before 5.15 kernels aren't
affected by this issue.

CVSS v3 score is not provided

Fixed status

mainline: [713b9825a4c47897f66ad69409581e7734a8728e]

CVE-2021-4032: kvm: mishandling of memory error during VCPU
construction can lead to DoS

CVSS v3 score is not provided

According to the suce bugzilla, it was fixed by f7d8a19("Revert "KVM:
x86: Open code necessary bits of kvm_lapic_set_base() at vCPU
RESET""). This bug was introduced in 5.15-rc1 and fixed in 5.15-rc7.
so before 5.15 kernels aren't affected by this issue.

Fixed status

mainline: [f7d8a19f9a056a05c5c509fa65af472a322abfee]

CVE-2021-4037: kernel: security regression for CVE-2018-13405

CVSS v3 score is not provided

According to the redhat bugzilla #2027239, patch for CVE-2018-13405
isn't sufficient when fs is XFS. It looks commit 01ea173("xfs: fix up
non-directory creation in SGID directories") is fixed commit. This
commit was merged in 5.12-rc1-dontuse. The mainline and stable/5.15
contains this patch but it haven't backported to other stable kernels.

Fixed status

Not yet.

* Updated CVEs

CVE-2020-27820: use-after-free in nouveau kernel module

5.10 and 5.15 were fixed this week.

Fixed status

mainline: [aff2299e0d81b26304ccc6a1ec0170e437f38efc,
abae9164a421bc4a41a3769f01ebcd1f9d955e0e,
  f55aaf63bde0d0336c3823bb3713bd4a464abbcf]
stable/5.10: [c81c90fbf5775ed1b907230eaaa766fa0e1b7cfa,
9221aff33edb627ea52a51379862f46e63e7c0c9,
  82de15ca6b5574fc0e2f54daa1de00b5b2dcf32f]
stable/5.15: [0b1a35d63995497a9186113c60a16e7ae59642c1,
4ee6807a1ad756ca151eaa4ac57c96ffbbac926f,
  c3d06f6067bf4a6bb3e988251e1b718a295bb60b]


CVE-2021-4001: bpf: Fix toctou on read-only map''s constant scalar tracking

stable/5.15 was fixed this week.

Fixed status

mainline: [353050be4c19e102178ccc05988101887c25ae53]
stable/5.15: [a5d1d3522232b4af1f5dee02d381e6fa86be8e2d]

CVE-2021-3640:

Fixed status

mainline: [99c23da0eed4fd20cae8243f2b51e10e66aa0951,
e04480920d1eec9c061841399aa6f35b6f987d8b,
  734bc5ff783115aa3164f4e9dd5967ae78e0a8ab,
49d8a5606428ca0962d09050a5af81461ff90fbb,
  ba316be1b6a00db7126ed9a39f9bee434a508043,
27c24fda62b601d6f9ca5e992502578c4310876f]
stable/4.19: [c1c913f797f3d2441310182ad75b7bd855a327ff,
3719acc161d5c1ce09912cc1c9eddc2c5faa3c66,
  3f7b869c1b44108a8cbf3e4a763ddac9df548d73,
728ff4b213cb6d66505e545ab820f3de5be1662a,
  48669c81a65628ef234cbdd91b9395952c7c27fe]
stable/4.9: [9bbe312ebea40c9b586c2b07a0d0948ff418beca,
0e77f979a97d3d517fad0b51249ba6fb8ae2d365,
  2240cbbd0d710c3b07ef5380fb6a1dfaedaf980b]
stable/5.10: [4dfba42604f08a505f1a1efc69ec5207ea6243de,
f2f856b65ac4b77049c76c0e89ecd3a177e9fcd1,
  98d44b7be6f1bcfd4f824c5f8bc2b742f890879f,
c20d8c197454068da758a83e09d93683f520d681,
  a1073aad497d0d071a71f61b721966a176d50c08 ]
stable/5.14: [2c2b295af72e4e30d17556375e100ae65ac0b896,
e04480920d1eec9c061841399aa6f35b6f987d8b,
  9ebb5a7757073da64d10a12621d0cedaca3aa215,
db63399389bc3f6b0d146f8020ca243a6b700d9d,
  b657bba82ff6a007d84fd076bd73b11131726a2b]
stable/5.15: [b990c219c4c9d4993ef65ea9db73d9497e70f697,
e04480920d1eec9c061841399aa6f35b6f987d8b,
  734bc5ff783115aa3164f4e9dd5967ae78e0a8ab,
11080de0a75cba7e00c1060d60ea484615d7a3d3,
  ba316be1b6a00db7126ed9a39f9bee434a508043,
27c24fda62b601d6f9ca5e992502578c4310876f]
stable/5.4: [d416020f1a9cc5f903ae66649b2c56d9ad5256ab,
ff29fe26ab8679bc13a3f0bf5b2911535a1cfc35,
  0d563020b8a3b835afa5c902610de700808546ec,
6237a1685c28c93b6477db46fbf67b7f0a0139e6,
  37d7ae2b0578f2373674a755402ee722e96edc08]

CVE-2021-33098: Improper input validation in the Intel(R) Ethernet
ixgbe driver for Linux before version 3.17.3 may allow an
authenticated user to potentially enable denial of service via local
access

The mainline and some of stable kernels are fixed in this week. This
bug was introduced since v3.8-rc1(872844d ("ixgbe: Enable jumbo frames
support w/ SR-IOV")) and fixed in 5.13-rc4. v4.4 contains commit
872844d but this commit requires ETH_MIN_MTU value which is introduced
by commit a52ad51 ("net: deprecate eth_change_mtu, remove usage")
which doesn't exist in 4.4 tree.

Fixed status

mainline: [63e39d29b3da02e901349f6cd71159818a4737a6]
stable/4.14: [5217f9cab7dd28e9c7626cd795e51da98ecb2af4]
stable/4.19: [938ffd6d2dd78fb83b9346c9b689e2a3a6fe7174]
stable/5.10: [3cfd11506ed032446358eedf7e31b4defd819d91]
stable/5.4: [cf20c704a26eb763daf6bfb10369a4f11fef2d9a]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2020-26555: BR/EDR pin code pairing broken

No fix information

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

