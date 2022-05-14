X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web09.3824.1652514671450862396
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 14 May 2022 00:51:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=PmdWA7Av;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id s14so9992849plk.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 14 May 2022 00:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=sFJrg2hOJ/uQpIkOPWX7L4kKH/njHKYFZPVQveBpVy4=;
        b=PmdWA7Av0NClnyBP/w7IocV9sWsMHCOFzILI3O5iY1huhyC1QxbEkEoL5f4FNFXTka
         bgDcQdcprGXfW2bd2zEXOIYTDHmJk8bLnN1TmbCQ4rDIiQYmKWVFfNJ/y770q5MSIh4b
         Ff95P5y53fpAQfW1yT4+QqOkQENR3OIsVAE7rhz3TyA9JsBrYs1iE30j8ytQh4hEkOII
         k5yWu9Rep7qmamdZtzokl3nwzSc0KDU8MThlZzGHh8Gj2MsHosnDPXDSxg1W4rwcrqQ5
         PYeYAkqRbNG4KsFJv/t/3KL5sOUnxBaUNKttif9/03St/bAES+Xx5rrzOrin/Dq+cqzg
         XD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=sFJrg2hOJ/uQpIkOPWX7L4kKH/njHKYFZPVQveBpVy4=;
        b=a+HsmhGaf6+cFhcABEWGfxFFqysZq0gcJg5Wqtz+GU6vGGwJ0kahWuOsdfFw9OuEQJ
         X9RtM4ZRl4bnmH49RVzTpA/NT2abKI87cgfK43dKWyomKmkIQQacBgneIkZuznZCwmxc
         TBjRyjtBV/Z5fu8bmBarv6AmSFVLsUPXck6+eQIqIFuyT9sW/SZtc6OAmI1RnRPUVgYG
         se/JkUmJsGXpPN1vhsmAXqgTU2WJxb+X/Z9SQedehhtZ2YxIapjY7jriOviRvsMQ9rBl
         ChYPAKKF+5YpEPvYrwkfPAkq96ocUJMXFH2yZ8fPNU1fUSMoE5pLb9KNEShewkKxd05w
         cE9A==
X-Gm-Message-State: AOAM531l+w0WkX3d0S4q3sQkItHL7+5/fCHuNDUaafyIgA3ZnQ8cYoxg
	hJTuBRbAPpmCKBRmaxQDfz9QFHxXMV/nCPcaYPI=
X-Google-Smtp-Source: ABdhPJwULKHrcv3QH6zxtGt2aBcxJ6gufWAJx6xDZ6IJDpkHwNR8SL1KWzxXhbdAzTlg2HPaekoexA==
X-Received: by 2002:a17:903:2c1:b0:158:f9d0:839c with SMTP id s1-20020a17090302c100b00158f9d0839cmr8326451plk.118.1652514670790;
        Sat, 14 May 2022 00:51:10 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p1-20020a62d001000000b0050dc762813fsm2960077pfg.25.2022.05.14.00.51.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 00:51:10 -0700 (PDT)
Message-ID: <627f5f6e.1c69fb81.ee4d9.79a8@mx.google.com>
Date: Sat, 14 May 2022 00:51:10 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4.302-cip69-50-gba851b77071ca
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs, 3 regressions (v4.4.302-cip69-50-gba851b77071ca) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs, 3 regressions (=
v4.4.302-cip69-50-gba851b77071ca)

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
nux-test/kernel/v4.4.302-cip69-50-gba851b77071ca/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
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


  Details:     https://kernelci.org/test/plan/id/627f50375ef5c8721a8f573e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/627f50375e=
f5c8721a8f573f
        failing since 2 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627f511a255e90895f8f577f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/627f511a25=
5e90895f8f5780
        failing since 1 day (last pass: v4.4-st5-17-g04a3c17cb526f, first f=
ail: v4.4-st5-49-g02cbcd6511d4) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627f573a19adda9b1f8f5718

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/627f573a19=
adda9b1f8f5719
        failing since 2 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

