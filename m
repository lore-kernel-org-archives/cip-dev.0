X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web12.3942.1652514673161156590
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 14 May 2022 00:51:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=gW0JmX+o;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id y41so9586287pfw.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 14 May 2022 00:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=RcnhvF5qiXfhvfCfVIyIsInSA2l90B2TpvxjZ5bdaCc=;
        b=gW0JmX+oIWBuUGcGpjwyL5pn4J6hHP+XXp4ijh6E0G75cAbKxc+OnhnR+74v5Oxw8C
         Ep6RfJ2TRWvjCE6zKikX8MNSCODOakELyFtEGvNB6mGz43+q6/jktwdepbnkbWLXBnXV
         OxIiyKFo/qwoGkX1GVS5VhSJj0DAiwqXQSCByylweJYKh59+wN+uh60RFTSoHjQjNP7e
         U4zid8jr31l0GWWKBu2unMncs8cJ9zkUF5u0YVqtWmr7AtYb2br0+wLrQuWmAaUTFsi1
         KHFcJ6O67EQC373GkZ7Hs03EaSUE4R86dV2Ux/aiAWYFkdz+CmRHZO33ehIbKOgmPVoc
         mQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=RcnhvF5qiXfhvfCfVIyIsInSA2l90B2TpvxjZ5bdaCc=;
        b=Ojel4SNBTM8q0VHREG4j2TCmTvZyHRhfQxuTcC7OlV6/Q8MASeazHp9j1z65GvnbSa
         AnBLjq7LTKZO0ZIUT8wHxRjlfeaUg7n8baold7T1N00XFEpQ00UT9vwjoVTDpxuRhPTj
         igpEmWJC2HaNolsxfd6u+UtGe7J0ouuGiRgwjf4T3DD09Pkjyx+HpYkYnXnCJw9FO5x1
         aC/mvQvyq7/YIQZmuRuX4PbdKKsH1ScAAq9KG2aIgv+u5tQz2K1VZtqJNXhwHOUhxhr1
         MVIeleEl6o7ABvUKBK2ExM+a4yKSA/M4p+GsZiYlTZ54V0xqEzHDTCF1UMvzgcTXVtUt
         IbCg==
X-Gm-Message-State: AOAM533zQsX3JeO4vz5Q6ylt/2TWxD78w3p5YzdEa5vhcxfjYU3aTzjp
	Pq6E9rDxJoLtugeo6y5Y8yYsRnJRKGHcxAgy6l8=
X-Google-Smtp-Source: ABdhPJwANxo5UJcLoM8YO6KLwUXHzfQhWlY3Euqyun0iFNQM66Deovvfv3RREayuBzJaCPv16DKeoQ==
X-Received: by 2002:a65:41c3:0:b0:363:5711:e234 with SMTP id b3-20020a6541c3000000b003635711e234mr6942938pgq.386.1652514672464;
        Sat, 14 May 2022 00:51:12 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f66-20020a623845000000b0050dc76281edsm2881742pfa.199.2022.05.14.00.51.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 00:51:11 -0700 (PDT)
Message-ID: <627f5f6f.1c69fb81.b410e.7acb@mx.google.com>
Date: Sat, 14 May 2022 00:51:11 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4.302-cip69-50-gba851b77071ca
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs, 3 regressions (v4.4.302-cip69-50-gba851b77071ca) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs, 3 regressions (v4.4.302-cip=
69-50-gba851b77071ca)

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
nux-test/kernel/v4.4.302-cip69-50-gba851b77071ca/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip69-50-gba851b77071ca
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ba851b77071ca2f6d6a35b5758aa276c8af6306d

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  0f67c9851a9043d0ad68cef4648d103ba7908480 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627f50395ef5c8721a8f5742

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/627f50395ef5c8721a8f57=
43
        failing since 2 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627f504f56f1887aaa8f571c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/627f504f56f1887aaa8f57=
1d
        failing since 2 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627f573afecca84b8a8f5734

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/627f573afecca84b8a8f57=
35
        failing since 2 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

