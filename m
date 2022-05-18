X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web09.1758.1652855032206506096
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 17 May 2022 23:23:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=zGlHCiOl;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id i24so1229437pfa.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 17 May 2022 23:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=muw+nuEnb7fzH/xEA7+ge80gPJi52HYK/ys51eJL5TU=;
        b=zGlHCiOl14/IQcJ4Xqtx/r89RRrb6HNcPUBhf+ZL/318baX1CVRB/QU0eUW94MwObc
         mW/Dm2PWONiRRL8XvJ6RzNrw0TMaQ21+F6ND3aR94zz5zvqLK3/j2ymSxo2XyXPOqCJ7
         Hpt9doDuC60Wpjn5etjBPQDG6foyezt7JcjvUmlaFysv4XjQPQoOuggf/MKTtEH+LhQ5
         Z33TzmAy9ikSfkhnGpfmiViMFftb0y+aHMQzKPMEXPUth14MYvm/ScxkMAiSprFqdzif
         h4/24bOcy8SW81VKim7FMh6pjA9xEhc5pBR1RMq1vl69CcPJJcqg2BH9Fur/p0xWxDzW
         sX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=muw+nuEnb7fzH/xEA7+ge80gPJi52HYK/ys51eJL5TU=;
        b=hOiyBk8oWCLk9LmYa0qDy9zG0zT1nu+8Rg6OLY+GxH7nL/AKVlb87U0YvuWf4GjVou
         cLo1escrd1yekWf0pxzOoKqjSQ1n7JvuqwA7WISUJrtD3OXpLmKKi4tZSJnrHpkwFBYq
         CbXd8g8YifD6MlSlNKbKgmOAVw8rrULR+hqAEodSAbwWwUQQsYaMdvhKPPjlKszUTlSo
         HP0Cx8ImIklH0CsFmnU2xYAsFk/3CIM38Nfsqv3vmtRqaV8DLJY3PsCeAWlNcUQ/a5La
         16sFiOz000E/FTyliz5fu1SUYvtByENtggNFLHRWfihzoiZhYNXea5iEU4Ac9/HomNDa
         sRaA==
X-Gm-Message-State: AOAM532Hg74r0JoQTRwtiFMhXt73luPkcV2AADmDArtj4f1MV9C3iApI
	axNbsvMB6QV8m2tTachsFV4a7IYDAjL1hfLD05A=
X-Google-Smtp-Source: ABdhPJxeuLzp2vpmiGoYoRPz198t9RNW/fNkr9U2nRFYbwRvqiRydSTERxniENfbqD61582y1+87Pw==
X-Received: by 2002:aa7:90d5:0:b0:4e1:307c:d94a with SMTP id k21-20020aa790d5000000b004e1307cd94amr26101455pfk.38.1652855031524;
        Tue, 17 May 2022 23:23:51 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090331c800b001618645a902sm695336ple.155.2022.05.17.23.23.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 23:23:51 -0700 (PDT)
Message-ID: <628490f7.1c69fb81.486bd.1ffc@mx.google.com>
Date: Tue, 17 May 2022 23:23:51 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip69-296-g52de9431d314
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs, 3 regressions (v4.4.302-cip69-296-g52de9431d314) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs, 3 regressions (=
v4.4.302-cip69-296-g52de9431d314)

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
nux-test/kernel/v4.4.302-cip69-296-g52de9431d314/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip69-296-g52de9431d314
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      52de9431d314a28c4aa66d8f81144c9958c11168

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


  Details:     https://kernelci.org/test/plan/id/6284173e58d88f9722a39bfa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6284173e58=
d88f9722a39bfb
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6284199f4b7be1c9bda39bd3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6284199f4b=
7be1c9bda39bd4
        failing since 5 days (last pass: v4.4-st5-17-g04a3c17cb526f, first =
fail: v4.4-st5-49-g02cbcd6511d4) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62841d5ec925569dcfa39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/62841d5ec9=
25569dcfa39bce
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

