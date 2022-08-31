Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183A3ECAAD1
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 18:51:48 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web11.2847.1661971898217332521
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 11:51:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=J/ORGWkP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id
 i7-20020a17090adc0700b001fd7ccbec3cso4204378pjv.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 11:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=gFrmorH4zfesNHmxSWny3o0Zbq4rOMsO6beezcQFR+o=;
        b=J/ORGWkPli7tBc8IE/CRJ4rwFg8ugAFA21XJw8zdHZc9b2hHrZqsjCe0gaRzTmyDPQ
         IPFXZC4AzKVZS90fs4UQB11Ukdw3nhAveAYarvC7EQkF7NKi+4guC+LuXGjalSSyBP5/
         wUpdXr2YJ0F6yH0bPNahD5LKL1jcmtQVk1xzDox/PcYKW3MkGJQKvoKIibJnuvCm/Goo
         Oys2IwA2S0P11h99TkTUDWKOrfOr+VUwWJnKU1gZbHDWw9Yp4GFGjGRKGWFVk8ElW1q+
         yWZvaGAZDmmikK3H4xtl0zAtmmnJFaq/eZSOM4rlDYpVY6dyh3RO5VFZPrLLB68TXwOp
         SE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=gFrmorH4zfesNHmxSWny3o0Zbq4rOMsO6beezcQFR+o=;
        b=rhUev8UH93pJXBbSb+3w3mlTRS1K1z62ZK3EAcuZd86dl/vlpAzvUPNaKyrpMcpsJz
         RzGFYqU2ZZk/ruwgtv2pIKvJkYLnoR7WxbZzuLy4yc9sfg5Yx2ZPdBQq/2UhXp61vLTR
         zt20mgUieP5GmxYcWAJKUtJfQQppAT4lxL9C2Ap4pbtVfoUytGdQxLxEM+AzR5T2i0Cc
         jmr+wl4BIZ3800gRdvDR9giXctk3sHn1ye15iPiT4VdQWIP9gYn2OPBQo9DIOfhRrE/C
         KUDGGNdQlmbV++zI89oR/a9Kz+3ECb48EjoMzGup7dPD6C9lO6tyt+mQL5qvBnqy266L
         SY9w==
X-Gm-Message-State: ACgBeo0W3QPsfmSpTRgkgo4Ku+BCD0xuyIkkfkIqy1U6agco9mRYkS+0
	eULrQ+pH1yFCNoINt/qGdRpdOmOGZi8f5ct0Q1k=
X-Google-Smtp-Source: 
 AA6agR5uJmU+HlLYMSpqRAr2jdUjmYLl6likP3fn71Q5wBI52ANtv1gXbs6Xw1caYpnN6yoXwAebxQ==
X-Received: by 2002:a17:90a:e384:b0:1fd:59fd:845a with SMTP id
 b4-20020a17090ae38400b001fd59fd845amr4633408pjz.165.1661971897582;
        Wed, 31 Aug 2022 11:51:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 p12-20020a635b0c000000b0042a713dd68csm3693756pgb.53.2022.08.31.11.51.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 11:51:37 -0700 (PDT)
Message-ID: <630fadb9.630a0220.93fea.72dc@mx.google.com>
Date: Wed, 31 Aug 2022 11:51:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.138-cip15-90-gd4130d0ee3c7
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 7 runs,
 1 regressions (v5.10.138-cip15-90-gd4130d0ee3c7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 18:51:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9392

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 7 runs, 1 regre=
ssions (v5.10.138-cip15-90-gd4130d0ee3c7)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.138-cip15-90-gd4130d0ee3c7/plan/kselftest=
-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.138-cip15-90-gd4130d0ee3c7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d4130d0ee3c72fc50c48ae861863e85537802c47 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/630fa5858173990934355642

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.138-cip15-90-gd4130d0ee3c7/arm64/defconfig/gcc-10/lab-ba=
ylibre/kselftest-futex-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.138-cip15-90-gd4130d0ee3c7/arm64/defconfig/gcc-10/lab-ba=
ylibre/kselftest-futex-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/630fa585817399=
0934355643
        failing since 27 days (last pass: v5.10.126-cip11-116-gef362fbbff52=
8, first fail: v5.10.131-cip13-431-g420b8f43ddc46) =

 =20

