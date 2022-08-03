Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4133C19F28
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 15:10:03 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web09.9961.1659539397722388163
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 08:09:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=eZVUKmUg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id
 h21-20020a17090aa89500b001f31a61b91dso2319568pjq.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 08:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=NMxKCwBbjlSzlvqktDXYdbqRvqU452EOY8BlLvyYIvk=;
        b=eZVUKmUgzs0ekmAFbAP2L8/wSLOypduexEVGr36XitipKGbi8bEKxJNskXPAk0lAoI
         YRFrB0ImXGnlpGzUNXkcpBT2oEL95zGpDWvlV0KntSl5qFW0nrMpWSvqViRkEhmGi4N+
         QkrkwVi++PZow5m6Itp0PNbjRNYvEjglFSY9HFlKkqTaaTQaiXgxct9YrF196Z1GG/qq
         P1sbTdFm9OpY90tOA0gGBS3tjO1+JMhkKSm1mKN5Pbqbf7OEl+BF14MtYSI+j2mjm7/m
         o6PbaUJoSp3BL086LWpWUlHvyAO9lmmBNEMSvxE9FDEVZLPut/jtpsKx269PVOgNH0Jz
         5Wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=NMxKCwBbjlSzlvqktDXYdbqRvqU452EOY8BlLvyYIvk=;
        b=Ebz/cSniceWA3zmb3bol1ByWUSAhFzzeSlMgvH/xbozXlz8RHP+Lql5ff6cVfgjZEN
         YrhgDUBtsy2fIQbwrX7BGeIkznaSgcYewEv5WsRnoV5NfbVr1jHdDF+awwCFAQKilrhf
         ufBYc9hRqsKkBcoc2h+VLxr2VUa4Jx8jUrSHpaMVL50+AXo+3q+kMEqvyOXMBfHs2LlT
         3FHqbKbod8PpoZZrRmP19tMHq170fUZTzYw//UsK1diNLbnjE4UDTW+pzIcvE1wSJfUr
         ulNz6ph8t5W+AutvTm3BUbcbamkfm3tzxSJUfF8N4NsQUbjds2jeBzt7CAtmgg+KVp0o
         R+vg==
X-Gm-Message-State: ACgBeo0YcOWhxW6sQoOsn8/sSQA4TWVuOb7yD3FP63z02h20iJHA7H0D
	dwyx3fA9vCBUyKT1D6ZXVCVicMvOmL8++L8QI18=
X-Google-Smtp-Source: 
 AA6agR54uWd5hJvrilVJVpf8mUw5bXWY3ZDMC6Zf6Qv/gMn6BG+mjPLwM+3k7fCvoqB6EDslwv74Ng==
X-Received: by 2002:a17:90b:1b08:b0:1f5:b65:9654 with SMTP id
 nu8-20020a17090b1b0800b001f50b659654mr5339993pjb.77.1659539396889;
        Wed, 03 Aug 2022 08:09:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 l11-20020a170903244b00b0016bedcced2fsm2116362pls.35.2022.08.03.08.09.34
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 08:09:46 -0700 (PDT)
Message-ID: <62ea8fba.170a0220.320a9.37f5@mx.google.com>
Date: Wed, 03 Aug 2022 08:09:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip70-rt40
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 5 runs,
 5 regressions (v4.4.302-cip70-rt40)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 15:10:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9053

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 5 runs, 5 regressions (v4.=
4.302-cip70-rt40)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip70-rt40/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip70-rt40
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6b137ed6ca3666fa2abde3e184426bbb203b5bfb =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea850a52e887343cdaf056

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-cip=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-cip=
-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62ea850a52e88=
7343cdaf057
        failing since 84 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea81841fa0c23f1fdaf056

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-cip-nfs=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-cip-nfs=
-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/62ea8184=
1fa0c23f1fdaf059
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167)
        1 lines

    2022-08-03T14:08:55.139254  / # =

    2022-08-03T14:08:55.141627  =

    2022-08-03T14:09:00.160980  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/720464/extract-nfsrootfs-o1u3czbv'
    2022-08-03T14:09:00.171686  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/720464/extract-nfsrootfs-</lib/lava/dispatcher/tmp/720464/extract-nf=
srootfs-o                         1u3czbv'
    2022-08-03T14:09:02.340517  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-08-03T14:09:02.351206  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-08-03T14:09:02.456531  / # #
    2022-08-03T14:09:02.458894  #
    2022-08-03T14:09:02.574552  / # export SHELL=3D/bin/sh
    2022-08-03T14:09:02.576860  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea806a982db1e128daf05c

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-cip-nf=
s-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-cip-nf=
s-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/62ea806a=
982db1e128daf05f
        new failure (last pass: v5.10.131-cip13)
        1 lines

    2022-08-03T14:03:57.345050  / # =

    2022-08-03T14:03:57.356698  =

    2022-08-03T14:04:02.383987  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/720457/extract-nfsrootfs-tw8v39ah'
    2022-08-03T14:04:02.394491  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/720457/extract-nfsrootfs-</lib/lava/dispatcher/tmp/720457/extract-nf=
srootfs-t                         w8v39ah'
    2022-08-03T14:04:04.465407  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-08-03T14:04:04.476376  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-08-03T14:04:04.603967  / # #
    2022-08-03T14:04:04.614074  #
    2022-08-03T14:04:04.754367  / # export SHELL=3D/bin/sh
    2022-08-03T14:04:04.762017  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea80a5044e1c07e3daf05e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-cip-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-cip-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62ea80a5044e1=
c07e3daf05f
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea81119f4cbe982edaf064

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-cip-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-cip-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62ea81119f4cb=
e982edaf065
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =20

