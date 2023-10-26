Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86540C25B67
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 14:42:47 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web11.72565.1698331363744625914
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 26 Oct 2023 07:42:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=XCuh45JK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6b9af7d41d2so929734b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 26 Oct 2023 07:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698331362; x=1698936162; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VUn2AC+w4ya4bjz8Un791SHNeVbN+Ez6fp82RwP/h0s=;
        b=XCuh45JK10Cr1jKZFgwzy5Y9FvxZ9y6UaD0egDeWFsBi7bggB/WhxN52IPxXPUmHU2
         G6IzMXgPORB/TLaqu+IsEDUc1c+NjMS95MXFzMPWmHCtqhH+3nIILA4yzdwBisBtDyxA
         6aNXITVmjPjc2HQ5XOyO0fvh6n4IT6SYi/Q6W+ybZp076dpQyHjB+6HKFJCDGJ1zNgU3
         JTbgQZW+pBNpwK3x+jdVgmmOHJE4Tq8LsTODAbf7wN45iRjR0TgVg3BzjMhZ0g5qKWTG
         1XGz08S8l1+i7XQMPUrr1V63l05/wAXmNX76ZZCdJ2GpNOeT7XkxyPBK4bDUw7gl3nGW
         cgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698331362; x=1698936162;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUn2AC+w4ya4bjz8Un791SHNeVbN+Ez6fp82RwP/h0s=;
        b=U66YdkEy/R5CSWdRfnKtx6Twf9MIVf1Q/yHCAFkrVpEs2eLWcRhNr3feTYO4J+LWbo
         rRaJ8747E0tmZLe3+XR72QzKoRKJ41BT460TJgJABUeXGgk7+YGHzenSscpKtjOksVzI
         wyKSBUNTd+Ds7uFNTSnX3ITXGOge+CZ3Vvvn6sj4bvN8SJZytUu0sMyzlnvPmkAdok14
         wMMCXz6RSNOVwZDTWu3LCtgKtwCi2QV/gTo6Bd+HfMCDBNU3t194IipftD/9OFHrEZNP
         PLJ62WXfKITpiNFY7Mw1mbIob3gkqVsAA5FAUlNWe2brqJ+D9O5dOajaUX+goa7BWXkK
         MB+Q==
X-Gm-Message-State: AOJu0YwalQGLW/QjWpADlUwNPZJXle7BIcOVgHxOEx2zY+kYjWhchfNo
	Z6jkCdBXMbbv42qiSWur1AVuyr9qZxbU67FJFl0=
X-Google-Smtp-Source: AGHT+IHIxJDdQCr6slyQxEHKK0YJT7b0y9bURklEQ8jA3tk8/AS/T8k5644IrtqA4bMuVC8rE4060w==
X-Received: by 2002:aa7:8f33:0:b0:6b1:704f:2078 with SMTP id y19-20020aa78f33000000b006b1704f2078mr16357728pfr.33.1698331362428;
        Thu, 26 Oct 2023 07:42:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w7-20020a63f507000000b005b92ba3938dsm1330521pgh.77.2023.10.26.07.42.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 07:42:41 -0700 (PDT)
Message-ID: <653a7ae1.630a0220.61e7b.3aa8@mx.google.com>
Date: Thu, 26 Oct 2023 07:42:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-3596-g73e7f2b880d98
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 7 runs,
 4 regressions (v4.4-st20-3596-g73e7f2b880d98)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Oct 2023 14:42:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13467

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 7 runs, 4 regressions=
 (v4.4-st20-3596-g73e7f2b880d98)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-3596-g73e7f2b880d98/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-3596-g73e7f2b880d98
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      73e7f2b880d98bcbacb997959b6c7b220f7fe382 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e262f7837aeecefcf48

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/653a6e26=
2f7837aeecefcf49
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6de3868d7366aeefcf04

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/kselftest-filesystems-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/kselftest-filesystems-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/653a6de3=
868d7366aeefcf05
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e6744cb5ba705efcfc7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/kselftest-filesystems-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/kselftest-filesystems-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/653a6e67=
44cb5ba705efcfc8
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6f962178e26e67efcf05

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/kselftest-filesystems-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/kselftest-filesystems-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/653a6f96=
2178e26e67efcf06
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =20

