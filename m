Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17F7C25B41
	for <webhook@archiver.kernel.org>; Fri, 20 Oct 2023 18:39:20 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.62476.1697827158038480944
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 20 Oct 2023 11:39:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ObgmMB0E;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1c9a1762b43so9424705ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 20 Oct 2023 11:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697827156; x=1698431956; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7cNPu9j7VYwgAEblccXmHmdSSdU+N68+063sBMaS/Eg=;
        b=ObgmMB0ElRRIjM2q2wiHY8ik0c+EO1ayGpzZt12hhxHyguPeLVM+CkdXcV2cn7yqyJ
         y0FkEC8LSJ6fkgGwBZg2eRMPXGbW6kURtMrlXTaAC1oWCCPNurQIrcSo18Ipbbi88Rr4
         ub7fU449NJpxY6sev4PVy1FPmZehDPfkVXnBDhb7I0mmU3gAGVeStUUGw1UA1uBm4HQ/
         PJh2yj7VIRiexXWlqOPL5U+zDdGbL01sEO3DOXK/A2NdJqDkg+5rP7IpeloHJj+MZI+n
         kl1y4QL/7JxGrjxpevTJrGTgYWTRxJZIafp9hn2xGfb4aJdw9g9uIfxZ2pDgj12vvR2Z
         7RTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697827156; x=1698431956;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7cNPu9j7VYwgAEblccXmHmdSSdU+N68+063sBMaS/Eg=;
        b=VNsffVvltQlPpV6r5UgVTo4I5/fpYMSo2h8bQeGcyiw9sIIBFzP405Ix071MeRXIq9
         txl1MBT2H6oTHJsA7+dAskMkxkN94RW+mXQmrdO5+2l7vgPVC2Jq7jS2HKCGHzmREIO4
         marFjvvOhsv1863dPCJZQp9YEmeeMiL2WejrLC00ZR8T21gnGXTWv5PEqaaE6zugsvCo
         CL9Xn3rrEyL3Hk7fSFxLb4Rfa21ABksjgpiV3UKMONOaJMy1L199XRTZ/7FweWaHgYCu
         59Lj0OCxG6KjMLeWz0Mu+FpvEoJCH4c0LeXVtiH/YGxuwbVu581/toJi1tC4ZMTEH6vP
         tlgQ==
X-Gm-Message-State: AOJu0YzVozoEO5mlf5v0xTWxv401A84Qfuyl7gGgXs18VzA9qs6eCHZE
	gfOxeZ/JE3iIOLPU87NPtF3bH3GL0jlArij5gaWv2A==
X-Google-Smtp-Source: AGHT+IFbNDwEx0xlh5YQNZLpFfrArfBOycdx/TiCQfD9yIA0S2GLt1WpXoDLNJ9gwmUrWbSIAgUuBg==
X-Received: by 2002:a17:902:f9c3:b0:1c5:f0fd:51be with SMTP id kz3-20020a170902f9c300b001c5f0fd51bemr2524827plb.69.1697827155864;
        Fri, 20 Oct 2023 11:39:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902eacb00b001c9ad9470a5sm1828006pld.253.2023.10.20.11.39.09
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:39:10 -0700 (PDT)
Message-ID: <6532c94e.170a0220.bfc0f.6c61@mx.google.com>
Date: Fri, 20 Oct 2023 11:39:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4.302-cip78-rt45-338-gf468de833aa13
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 5 runs,
 3 regressions (v4.4.302-cip78-rt45-338-gf468de833aa13)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Oct 2023 18:39:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13429

cip-gitlab/ci/pavel/linux-test kselftest-futex: 5 runs, 3 regressions (v4.4=
.302-cip78-rt45-338-gf468de833aa13)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip78-rt45-338-gf468de833aa13/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip78-rt45-338-gf468de833aa13
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f468de833aa13aa639d147055db4edf9931b6811 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532c017e294134ef8efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6532c017e29413=
4ef8efcef4
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532c28f92187cb83cefcef5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/kselftest-futex-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/kselftest-futex-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6532c28f92187c=
b83cefcef6
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bd3bdc8c29222cefcfee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/kselftest-futex-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/kselftest-futex-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6532bd3bdc8c29=
222cefcfef
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =20

