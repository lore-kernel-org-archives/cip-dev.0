X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web11.11866.1652278178852116521
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 11 May 2022 07:09:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=xrKnMu5l;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.170, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f170.google.com with SMTP id a191so1908574pge.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 11 May 2022 07:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=p5Wj+r8RUExWADfP/eLYc7JL80iZ8JRtcb80vo1SJ4s=;
        b=xrKnMu5lI2ttQVGEHa8bI76RX0tBjK3eP8PErowcrbdZHKNT3weMydR8DKI532q2A4
         rRzgx4jWYG7niuXQPBmnmYbRRWwxwGY6K5pqHBT6pLGOcdhiKFb1AKkbpCXMahKuH9rH
         +6BJevtjI7t9JBHbQ3Ed4ZkB5oR4JGok4jJ0qqr6dDskDHM05srAwP/dpcUGFn7n0t82
         Ja6Irv7DP1JhA1tjltVCqNHCcfPmK5iS1FcP3168WAoJOybuvsp19EKKVNnZA2cPwlAm
         1oH2foZ2sIkVcy6TpUwZiPhhyw15+drf3cejVHwHdJ9AoZxpkL5H26CXMPrk9yFxV2t+
         zJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=p5Wj+r8RUExWADfP/eLYc7JL80iZ8JRtcb80vo1SJ4s=;
        b=Q/2OHxsRukr7/11KxsqC+9qifKztWitK1nmJgI18OQ/BzXMYt3802NWczcoEXXPDMJ
         wr7eexmtp35qNNQsOhg4OzT1vWbX8AC2FeXyhEr5B4QEjWUwLXSjdxBfmS4G6rioFGMB
         iypSyoL4uUQOm2uMmmPJP1PwnsCwHGCdQR8T0oUrUvZ0u+x42Rxe3zYvphvgl5gW+I49
         73Mua8uz4pSFBSokBh1oltzltWNFVhLJgbN3ZutNBdNz0nNz4DvMtpdUsiHn+QzIgEKA
         WYLqTDq7clE+KzE53vkpvMemotz6C9pKKda+a98j8nkpZiTMj/go6BhnDAuIBUXY18xh
         fKhQ==
X-Gm-Message-State: AOAM533/ztxAwAE6zHnH3ut5McNaKz3Kzbe73Di3rPngCUpmXnmBxCu9
	NGqpjIihjxpCDMKMfvKYFxuiQi8kE7dq1/HeW/A=
X-Google-Smtp-Source: ABdhPJzKRAqcZM4AHW3CBO4Ds1baFCCMRKrsdDQOjI0riDzGPIgvX/O51Q1mnkXqYogDLENK6TUeog==
X-Received: by 2002:a05:6a02:113:b0:3c6:4389:cd6e with SMTP id bg19-20020a056a02011300b003c64389cd6emr20605907pgb.414.1652278178125;
        Wed, 11 May 2022 07:09:38 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a191900b001cd4989ff42sm1899745pjg.9.2022.05.11.07.09.37
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:09:37 -0700 (PDT)
Message-ID: <627bc3a1.1c69fb81.41e53.4033@mx.google.com>
Date: Wed, 11 May 2022 07:09:37 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-17-g04a3c17cb526f
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 6 runs, 4 regressions (v4.4-st5-17-g04a3c17cb526f) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-ipc: 6 runs, 4 regressions (v4.4-st5-17-=
g04a3c17cb526f)

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

asus-cx9400-volteer      | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-17-g04a3c17cb526f/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-17-g04a3c17cb526f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      04a3c17cb526ff31d466407f119fa9692b4cee08

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  0f67c9851a9043d0ad68cef4648d103ba7908480 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb9a9276bd8a6178f5725

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/627bb9a9276bd8a6178f57=
26
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bba90e578b5bb818f5723

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/627bba90e578b5bb818f57=
24
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-cx9400-volteer      | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb63748934a227d8f57d2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/627bb63748934a227d8f57=
d3
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb92a968149a1458f5729

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/627bb92a968149a1458f57=
2a
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

