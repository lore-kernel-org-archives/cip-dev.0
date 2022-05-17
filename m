X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web12.7043.1652793363581981071
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 17 May 2022 06:16:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=jIIDhxx8;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id oe17-20020a17090b395100b001df77d29587so2406817pjb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 17 May 2022 06:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=1e8cObsPJ1BCbalGENn2syrjiUnMVci/VQqR+zTzIMo=;
        b=jIIDhxx8AUthLFdG1kgiKGG7lfaXyeaDZ2ivY4AM+EOXqqSRYomJWrCMyO1jYKc6yr
         0rtLgcJp+JNPfBzTtksH2HS+Rit7UDnL42WSgumoUOIHxvCBfIMBKQg1NGdTelPDuR93
         uCNx6omMEXb35g6vJ4SawHZXth8eoB13pfhF+ts4ZT1Exycn/TOkLQoR+lGcXFmxHLyz
         QEqk7sMF5/w9X9cvO9l+SKS/1/svlK/UD7cPv9H2HKt0fpSAplqqF/y008sj91/DQ7s0
         nrGuo6kNEWMLuqtkUajKvJbi08PhqFtDogjbC0yBB6UhtKW733cXVcRoZG2FVot4lZm+
         G2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=1e8cObsPJ1BCbalGENn2syrjiUnMVci/VQqR+zTzIMo=;
        b=8IrDPPQchwR0vaSjdzV4JUZEq+qO/Z0i4Ljl6InXLBlstf2V0wSyJtq5gLghVnzA2c
         lALEHvNlaSNsBhnne5qSQ+odovsTm8OYRA4SwuhJwaIM4VYHH4qKqjBs4VOi+LAqigFj
         4M4XG0+lYzL4oeVJ12sDOfp/EXPYbVmJCT9dZRNyDCQ31vsjOv6Fba1aRSINQ9AhKgKx
         cZLQQ0202RTugmj8vyRpKKmUXkKrZ6Wy6HVeqErFRp+Ee1n0WtTl2ylDdihwlms1N+Uv
         JZfhExa6brcKuaB7SerpKEu2J111DCqnEXwkzjQ4zsJoL4wK5lUiiXVWB4LVidboa93+
         TMbw==
X-Gm-Message-State: AOAM532goq/vAUciW3FLjoaKRZVNbF9gZci6RMTlA9EsEFdItxqwtfj5
	c/UD0cUECM0jN7GkXlaip9Zzh6Vsr2S+t5pyzT8=
X-Google-Smtp-Source: ABdhPJw14kK26rE+DjvtBWq/M+7iVyj3KL+tGc93evaxhAMpOKI9mUWhVHDliiYk2qSaGXZe/eDOfA==
X-Received: by 2002:a17:902:c714:b0:161:64fa:97b6 with SMTP id p20-20020a170902c71400b0016164fa97b6mr12546958plp.40.1652793362756;
        Tue, 17 May 2022 06:16:02 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d19-20020a656b93000000b003db8bc8db64sm8603877pgw.35.2022.05.17.06.16.02
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 06:16:02 -0700 (PDT)
Message-ID: <6283a012.1c69fb81.2cd80.5105@mx.google.com>
Date: Tue, 17 May 2022 06:16:02 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-293-gbfc4bd11718e1
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs, 3 regressions (v4.4-st5-293-gbfc4bd11718e1) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs, 3 regressions (=
v4.4-st5-293-gbfc4bd11718e1)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-293-gbfc4bd11718e1/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-293-gbfc4bd11718e1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      bfc4bd11718e111c2344c45b9237855beb947e3c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  17e9ae697a340242c49188ace12a60cd3bc95a53 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6283918ca3f4a8e958a39bf6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6283918ca3=
f4a8e958a39bf7
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62839e2211e44a12a8a39bdb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/62839e2211=
e44a12a8a39bdc
        failing since 5 days (last pass: v4.4-st5-17-g04a3c17cb526f, first =
fail: v4.4-st5-49-g02cbcd6511d4) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62839433e9c2765958a39bd3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/62839433e9=
c2765958a39bd4
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

