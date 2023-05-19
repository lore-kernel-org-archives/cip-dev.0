Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57837C77B75
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 15:12:09 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.28954.1684509127510426389
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 19 May 2023 08:12:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=MI+bChH6;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ae557aaf1dso28625465ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 19 May 2023 08:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684509126; x=1687101126;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RyBIQU9jVNVCzT8684sq7XvTTH8bs07OizSWNpVZufg=;
        b=MI+bChH6/LQP2ky5Vf1oNyn734tJvy9AYWZYhGc2dwEYagaHMuoE7sKS75t+pyQTcu
         PR6I/RNmf7QhJEaYJriIj5bYoaOy5dqCKKMJPFx3tAjodU1NfFFyON/TcLvHZLoVpKf/
         crBiCz4k42HzzaWWYZZgpMIJVdpCu5dT2CLsNFGQ76/DqbQp3lxtln3i5S6pm5RSnmMe
         FTK40uRQf3v7AlVmNU8rI8ylE7LOwI1q2Wt+ElwWY2wjBeu41SS2XvAAJ7XueG0WDlDB
         Ph2KfMc9lMeOJllvPXTqXRBOgl00xQLi/bdYgqdRdxEVUwLPv7JEIg7NkuIjmNvJH2cN
         tigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684509126; x=1687101126;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RyBIQU9jVNVCzT8684sq7XvTTH8bs07OizSWNpVZufg=;
        b=LiOa1DERa9i6+iz6OFAnqb8TB8MYfEfWn0L+Nqbxr7WvCXdPi4gblYSJGyBO2o7wrJ
         Px86whtt7g4Co4hS69kDzcAJqjbMAhy4qpI9v/4GvoLWojGBSAL+ig6JN+TwuDrPNbNO
         09uHRuqiprMrTzgE6EdYw9kEnyyeem2miPpzdt2hyTYA5QpdvKRS6QzlwIsZWj8V7hah
         u5O6MqXvVmabNnXQAsD7qs/44uBYK2PksUETIBKhC4GXXsxsEnseOf7zlNEGGloYxB4r
         akeOGRBbWwDM6PJ3MYg6zTdVY+ishEXQiAwZ3BsyfmXqMCJgo2yUhsciBXtmPbxc4DVs
         9s4A==
X-Gm-Message-State: AC+VfDzpfFlj4meztfGETNOCMqD5bpeXX3GBYa4u1BEc3i3EHCwWUJfs
	ZDax7ZyQ99BVLrAuJmveMHofOqSnjvxk30GRjx7XOg==
X-Google-Smtp-Source: ACHHUZ5BUQ1XqsC/NaqwUIXsqhxK1XCDbSh73M9aTh1PxQsX9F80a4JAt7CDf2d4fm832KJzP6LeAA==
X-Received: by 2002:a17:903:2303:b0:1ac:a61c:7a14 with SMTP id d3-20020a170903230300b001aca61c7a14mr3260866plh.62.1684509126386;
        Fri, 19 May 2023 08:12:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902f7c700b0019a7d58e595sm3591331plw.143.2023.05.19.08.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 08:12:05 -0700 (PDT)
Message-ID: <646791c5.170a0220.5aa75.6b4a@mx.google.com>
Date: Fri, 19 May 2023 08:12:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip33
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-timers: 16 runs,
 10 regressions (v5.10.180-cip33)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 15:12:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11566

cip/linux-5.10.y-cip ltp-timers: 16 runs, 10 regressions (v5.10.180-cip33)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =

rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip33/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip33
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7f6b02104eb287caf662ade9a67f11896ab01fde

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6467839f610da23c6d2e860d

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6467839f610=
da23c6d2e8618
        failing since 2 days (last pass: v5.10.177-cip31, first fail: v5.10=
.179-cip32-4-gd8c029e4780f) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6467839f610=
da23c6d2e8618
        failing since 2 days (last pass: v5.10.177-cip31, first fail: v5.10=
.179-cip32-4-gd8c029e4780f) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64678a4c96dd74519b2e8600

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64678a4c96d=
d74519b2e8605
        failing since 97 days (last pass: v5.10.165-cip25, first fail: v5.1=
0.167-cip26) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64678a4c96d=
d74519b2e8605
        failing since 97 days (last pass: v5.10.165-cip25, first fail: v5.1=
0.167-cip26) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6467881d477f286f262e8609

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6467881d477=
f286f262e860e
        failing since 196 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6467881d477=
f286f262e860e
        failing since 196 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64678eefaa871375062e861f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-timers-r8a774a1-=
hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-timers-r8a774a1-=
hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64678eefaa8=
71375062e862a
        new failure (last pass: v5.10.179-cip32-4-gd8c029e4780f) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64678eefaa8=
71375062e862a
        new failure (last pass: v5.10.179-cip32-4-gd8c029e4780f) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64678a4596dd74519b2e85e6

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64678a4596d=
d74519b2e85eb
        failing since 196 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64678a4596d=
d74519b2e85eb
        failing since 196 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =

 =20

