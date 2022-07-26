Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BBBC48BE4
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 15:29:14 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web11.8000.1658849350408140402
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 26 Jul 2022 08:29:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=r6yRBCb7;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id f11so13440906pgj.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 26 Jul 2022 08:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=YYKfGuvv4BoAmMatlobQg6gEuLVR55eXLTeRsrH+92s=;
        b=r6yRBCb7I7R4nGJW682Kj0WT9OOuqxTxmaPNVe/wYxcJVmtW0QqfoRiO+hKjmFemPj
         lYEHqJjaBq+HlZdN7/9viiIENXcKhAjn6vS6dYT5mI1pqxb02Kb9bc8/r1RcqW9V6f/k
         C/0GoNVBlYmb+i/v11sgsxQbJSTVqU6uXXrwI1eSc4H6g1HNAgXIT3l6F8sD2i3LHg39
         BC0uLPnFkPl5uPNtr2/X4Sgz64rieE0S77cIswRxtd0y2hfwjmPC+M8XOr437n2Z4jmz
         MzNcuMqJsrT+n+7YGeKUtLUovaK0tINRJZTQjcnDDZWq7sRBXwDbTAMg+0iKSN3CkRsK
         L+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=YYKfGuvv4BoAmMatlobQg6gEuLVR55eXLTeRsrH+92s=;
        b=Viatb90d4CnOXaEx0bZNoXkBsqdjiL7q+t1561r4dj8848EES2K7L9TRdCyXSYNEV4
         2gAhbydyXVmJTdrW3LXD3bjZmiPrwPogBdLB+PScLzZZwwNYZxGWcwxVkgPKeujeES4D
         pknOsiGcWobwq4mp+9nWYhc92lcoP0FxjpqOd8p79janOUwNDDTB3Tj8iEOC7EtG9dLA
         2lVS1tINXNXYBXIGesN8lExuN6t4a7HxthmlBcC4aYcvY6waf/o6MmxEQG8q8+v85RvE
         r4C3mc1iRAz1FDj40aB0m0QeCrI7XNdZm8vNO0aee+/dgiJ32oekrblUX2x5mD30MQZW
         Ln5Q==
X-Gm-Message-State: AJIora95rHySnf0CHYMRM/yv963reMZ/S1OYw8pNObIENFbEsRNaoqYL
	8DYgLDBe9z9tVEMoYiSoyVx+LzkShiBkrw+X
X-Google-Smtp-Source: 
 AGRyM1slrHDgoCs3CDx6Z0kOy+rA3NdyDHazlafeU9OP/3GYXN05kqtFwUExGWs6E8Bu1Zgf+2PdZQ==
X-Received: by 2002:a63:6984:0:b0:40d:9ebe:5733 with SMTP id
 e126-20020a636984000000b0040d9ebe5733mr15405427pgc.170.1658849349609;
        Tue, 26 Jul 2022 08:29:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 m15-20020a17090a158f00b001f10b31e7a7sm10965058pja.32.2022.07.26.08.29.09
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:29:09 -0700 (PDT)
Message-ID: <62e00845.1c69fb81.76184.0b81@mx.google.com>
Date: Tue, 26 Jul 2022 08:29:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-586-geb97410e0086c
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 13 runs,
 7 regressions (v4.4-st5-586-geb97410e0086c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 15:29:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8941

cip-gitlab/ci/pavel/linux-test baseline-nfs: 13 runs, 7 regressions (v4.4-s=
t5-586-geb97410e0086c)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-586-geb97410e0086c/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-586-geb97410e0086c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      eb97410e0086c865c804bdc822e061764810486c =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62dffbd0b73ee60432daf08e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62dffbd0b73ee6043=
2daf08f
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0017f84531f90acdaf08c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62e0017f84531f90a=
cdaf08d
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e00673630e5f1c99daf064

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62e00673630e5f1c9=
9daf065
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62dffcb24c385526b1daf056

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62dffcb24c385526b=
1daf057
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/62dffe62c996e88c68daf080

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/62dffe62c996=
e88c68daf087
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a)
        1 lines

    2022-07-26T14:46:25.355399  / # =

    2022-07-26T14:46:25.360789  =

    2022-07-26T14:46:30.436631  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/352097/extract-nfsrootfs-qhkfsgej'
    2022-07-26T14:46:30.447159  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/352097/extract-nfsrootfs-qhkfsgej'
    2022-07-26T14:46:32.739688  / # export NFS_SERVER_IP=3D'192.168.56.123'
    2022-07-26T14:46:32.750260  export NFS_SERVER_IP=3D'192.168.56.123'
    2022-07-26T14:46:32.858570  / # #
    2022-07-26T14:46:32.862713  #
    2022-07-26T14:46:32.975477  / # export SHELL=3D/bin/sh
    2022-07-26T14:46:32.980046  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e005009d38caab66daf07a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62e005009d38caab6=
6daf07b
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e002a1efa1239ab8daf076

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62e002a1efa1239ab=
8daf077
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =20

