Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063FDC47073
	for <webhook@archiver.kernel.org>; Thu, 28 Dec 2023 00:37:35 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web11.114054.1703723851609205116
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 27 Dec 2023 16:37:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=IpsnYRJ9;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d9b267007fso882990b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 27 Dec 2023 16:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703723850; x=1704328650; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uqrYWjomzyHGArNTf9LEMIA6KSuH4+96+g7eJ/7OOXQ=;
        b=IpsnYRJ9bUiBgncjFxSWOjkRIebyXbuim6BGAqexwlIZJ0PyDJY+pgNNDucgwgf/FQ
         b0dp1z/lK6PqexJBdvKG7i45pjl2/qypZ24L2IHRXEhaFIr5GINaQxv801DeUYRAnmbB
         nQpiEcnkhX4CyzV06FkgHgSbvulnT25eyGelElk3A9+u4iCjq/Lo0TlYxTxw5sV/t02w
         CugdNBza8CJiZ3j/MVZc4HkI5BjaFhQc1tzTmCJOI/wWTiT86DU48t+V/JOXXOB4C8m8
         gzw4iZ8+D+3wmUB5hNiVK+Eqt9zFJOWWexah9Jltf/c7tM/OMWciygPmjpHbM1si07xI
         zK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703723850; x=1704328650;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uqrYWjomzyHGArNTf9LEMIA6KSuH4+96+g7eJ/7OOXQ=;
        b=oSdFN2eD/WAx/aBOCGRq+2X/s33oWWsB3kci/yy/4saZzeRA/y0xvp7e1dB6UQAWRw
         IVVQcDwf9feSN3h5i6H+JWn2pS1tiJA1duWhIIZgNKn5DM596Uj5UVYDUyYJ/mrneu77
         PfhrbEN2DEXaQhF5fKgosVUIZA1DDm27MWucaiYg62ympswv5yB4aofGb+g33pbKGD7B
         jLxqwxlHfyfKR8pTGJnYvUna3RoOxT5AIBd0GafPTtAlRC4bxO7RDwl7Gilisa0087GR
         WQCqT/iV2V/eogzsYHImMaPAwIiceA5cGGYe4xE8C9kHgh3GaByuYeSIlTqtugWwJFAw
         bcXA==
X-Gm-Message-State: AOJu0YzCEeBiTg85k9en2ciddwfYCTpjDvyefjeNaaSlMddsKSCxDK75
	Pp/xkj+Rf7pfN1AM+aFQSBFx2muTIlJOCHDkprER6yArVnQ=
X-Google-Smtp-Source: AGHT+IHhhA3C6KlgyDEZYIp5RbaZvslhOgoBm4u1gCRFjV0zznc2McOKs3sBlL2vGngqmWbbcnrvvQ==
X-Received: by 2002:a05:6a20:da:b0:194:dbd6:9c35 with SMTP id 26-20020a056a2000da00b00194dbd69c35mr3766689pzh.24.1703723850110;
        Wed, 27 Dec 2023 16:37:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jk15-20020a170903330f00b001d1c96a0c63sm12701024plb.274.2023.12.27.16.37.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 16:37:29 -0800 (PST)
Message-ID: <658cc349.170a0220.510dc.de5a@mx.google.com>
Date: Wed, 27 Dec 2023 16:37:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.66-cip11-rt6-10-g38253b8903b4
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 12 runs,
 3 regressions (v6.1.66-cip11-rt6-10-g38253b8903b4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Dec 2023 00:37:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14212

cip-gitlab/ci/pavel/linux-test kselftest-futex: 12 runs, 3 regressions (v6.=
1.66-cip11-rt6-10-g38253b8903b4)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
    | regressions
-------------------------+-------+-------------+----------+----------------=
----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig | 1          =

beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.66-cip11-rt6-10-g38253b8903b4/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.66-cip11-rt6-10-g38253b8903b4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      38253b8903b46da162814048c6f555bba4399ca8 =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
    | regressions
-------------------------+-------+-------------+----------+----------------=
----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb1339f98a0dfbde134ce

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/kselftest-futex-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/kselftest-futex-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/658cb1339f98a0=
dfbde134cf
        new failure (last pass: v5.10.201-cip41-77-g545d45774209f) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
    | regressions
-------------------------+-------+-------------+----------+----------------=
----+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb3a55b26b21147e134db

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/multi_v7_defconfig/gcc-10/lab-cip/k=
selftest-futex-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/multi_v7_defconfig/gcc-10/lab-cip/k=
selftest-futex-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/658cb3a55b26b2=
1147e134dc
        new failure (last pass: v5.10.201-cip41-77-g545d45774209f) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
    | regressions
-------------------------+-------+-------------+----------+----------------=
----+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb3dd314effa6b6e13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig/gcc-10/lab-cip/kselftes=
t-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig/gcc-10/lab-cip/kselftes=
t-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/658cb3dd314eff=
a6b6e13476
        new failure (last pass: v5.10.201-cip41-77-g545d45774209f) =

 =20

