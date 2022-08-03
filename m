Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D43C25B08
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 15:39:44 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.10203.1659541177527704938
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 08:39:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=x+GPQEbw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id w14so3688455plp.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 08:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=hyVlS/8QNv/8hhmzaD7hh8WLP9y1fu8o9bxA4kUojqE=;
        b=x+GPQEbwvyeEm3Lp64n6CGnjzwJ/XopuP6puxLh0lzI/8EoU7z3tVIUnEKSIUNLUPR
         2qpRLYaewHIfB3HrrNJHUzphSQnuLTlNeMugnwloWffMxvLeSu+qpSEy6xTIxJQ1Zfz0
         pN80C2noB3jyPgayoVaxUrobyGJabhL1eqUUSbUdPSzXFk20sWs5EQSjRwpahd67krqW
         3DP5UNnW+XlOi7JWK2f9DI6orpwjggtUVCNuS5QPNFNlnfEx2t6ZnicMYiOf1EUHEvp4
         Vs1362v88Agl85hIahtNJ4J36mMhtuU8hY2hkwSOpvLzex3KzKTwvOru6vL3brVg1DAK
         4fHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=hyVlS/8QNv/8hhmzaD7hh8WLP9y1fu8o9bxA4kUojqE=;
        b=FM9eFVz0niAhvboE1LkCxC7zDsr5D8h44B000t28Pg0oSJ26jXM4dCW2RyQ8eU8utB
         HLug31A3vezB4snuK1mjO5qI3V/ZfYNbKAbkjZ42mYS/cB+0jse8AXy8YX4YDzKyoiqF
         lQ00VZL2xgT5I4vtmiIWP0Q7+mhVR40Vc/mlHW+mTuiRkBf00PHMCkDPpLgp4y1+NYr6
         lY7L/cHr9DbU1+MAKYJzc06lZzCMxKfI7yFT5M3PsTvhxJl1pSVbS90ou56H/dsq+2IY
         DQn7+qPYuSDE4MNMSM2JKElX+7fi+78cpclncfmUeHOkHBIRH/sq10ibzLUw2PdD8wxa
         mIig==
X-Gm-Message-State: ACgBeo05N/rE1hOiayMvgaNBO0KDnhkuCB5oXxMKZdlIfCYt9pP/X/np
	7SbRBR6YIDtEheKv3akI03blPjNdipiFKs7qqhQ=
X-Google-Smtp-Source: 
 AA6agR5iyctgRNEDLJXilU0orVFo3toMoCXwsWXk5FdyeByi+L28HTaVXIEb9640k4Q287nv6+68xg==
X-Received: by 2002:a17:902:e886:b0:16e:d785:5a0 with SMTP id
 w6-20020a170902e88600b0016ed78505a0mr18812481plg.36.1659541176861;
        Wed, 03 Aug 2022 08:39:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 q3-20020a17090311c300b0016a4db13429sm2126584plh.192.2022.08.03.08.39.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 08:39:36 -0700 (PDT)
Message-ID: <62ea96b8.170a0220.5ac27.3663@mx.google.com>
Date: Wed, 03 Aug 2022 08:39:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip70-rt40
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs,
 3 regressions (v4.4.302-cip70-rt40)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 15:39:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9057

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs, 3 regressions (=
v4.4.302-cip70-rt40)

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
nux-test/kernel/v4.4.302-cip70-rt40/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip70-rt40
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6b137ed6ca3666fa2abde3e184426bbb203b5bfb

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  bda92ad659a52d38ac810099f69adff626b064c6 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea7ffc9a7ea1292bdaf0ae

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/62ea7ffc9a=
7ea1292bdaf0af
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea7ff49a7ea1292bdaf056

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/62ea7ff49a=
7ea1292bdaf057
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea80a41431f01924daf057

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/62ea80a414=
31f01924daf058
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =20

