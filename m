Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB09CC00140
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 11:22:15 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web12.9460.1660303320914121036
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Aug 2022 04:22:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=kRI3Lwfw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id o3so513949ple.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Aug 2022 04:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=NJhnBbHdHORQT7mkbw3XCuvhHZMHYaUP2RQ6bw2i65c=;
        b=kRI3LwfwfQNdwKizh+aD1rNQK/YSFHiFVeALb/VBPkywsiCKUqtHy2GF02aHx8Hskh
         j/jKxtBtXp826eTi6qkGViz/OVhQ25jqMuqVIWmKp/okE4A8nj7DX9PFskwMzad0Nfnj
         tOVkqEiaZQdRZee+MQApTFRfyGtjhGz2gsPX9TdxeSZdfyg7maeeAvrUmYZj/FLQ5PHV
         0JwN2J/uebz1tjc474Ij0xtx0JB1GK7FvugSJ4iRJMs2BsiXKj/2kdYQ5FtAdzufgDK3
         WLoXKjOO4UjcRybzuSCYfED6/R44z8wqgqGZBNV6O+fGw+Viwc4F6do6LwdDaMYbJJDl
         Yebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=NJhnBbHdHORQT7mkbw3XCuvhHZMHYaUP2RQ6bw2i65c=;
        b=LVEkZI57oReUQP86N6ZJcCRcC81TBjx23ItYWEOCVmsGcE4vpISVEz/AxBe4hmA0u3
         j7SfgOue6b+nYoZnxf2QRKbqD6VUSJ7+1r5+1Lh0XthSZPl6j5780rjsLR4tyPP1gIxO
         tdzB2OnJVREbM2pcV6++FcwdmDHToN/Q/F99ta5ISGmGx37Fw+Z9awL7ykCoyqM69+Pj
         oubr/dYia+xRRjHpdz8nAunjtmQtIywtVwhnZsWDaOK/4H6PLZxSVBXGQy/FwGWMeSB2
         Ry5dkCUJMONNfwf0rLU06VibDXnrGwM+uU0xjGGwxWnM9qDcciP7dLGGSRa/EIjoJPrK
         l8IQ==
X-Gm-Message-State: ACgBeo0of3yT/ld4OHhMQUZ58TJ+KDEqCrWCt9qRRHHRwLHWui+GvQ8J
	8tKMmuo/5hQjlQFDCVUtXe7i3jLxeSkSWEkG
X-Google-Smtp-Source: 
 AA6agR7ajz8ztc6DsxRwkOj4tl8tLThjhjD4W7HP5EFEvechuUHluPtmqKozxDtluJho0ZLASBRvAA==
X-Received: by 2002:a17:90a:8a8d:b0:1f3:155:3324 with SMTP id
 x13-20020a17090a8a8d00b001f301553324mr3582107pjn.89.1660303320027;
        Fri, 12 Aug 2022 04:22:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 u13-20020a170903124d00b0016c1e006b63sm1530067plh.64.2022.08.12.04.21.59
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 04:21:59 -0700 (PDT)
Message-ID: <62f637d7.170a0220.7e2a2.261b@mx.google.com>
Date: Fri, 12 Aug 2022 04:21:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-96-g74ff989472f09
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 6 runs,
 4 regressions (v4.4-st20-96-g74ff989472f09)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Aug 2022 11:22:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9188

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 6 runs, 4 regressions=
 (v4.4-st20-96-g74ff989472f09)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-96-g74ff989472f09/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-96-g74ff989472f09
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      74ff989472f092eb06514e780a28645e8310d183 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62f624410ca6a44586daf086

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220805.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62f62441=
0ca6a44586daf087
        failing since 8 days (last pass: v5.10.131-cip13-24-ga6f4ea41fe167,=
 first fail: v4.4.302-cip70-rt40) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62f6229b252c2dcb1bdaf059

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220805.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62f6229b=
252c2dcb1bdaf05a
        failing since 8 days (last pass: v5.10.131-cip13-24-ga6f4ea41fe167,=
 first fail: v4.4.302-cip70-rt40) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62f62238d2d3b3a0ccdaf075

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220805.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62f62238=
d2d3b3a0ccdaf076
        failing since 8 days (last pass: v5.10.131-cip13-24-ga6f4ea41fe167,=
 first fail: v4.4.302-cip70-rt40) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62f62426aba515596adaf074

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220805.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62f62426=
aba515596adaf075
        failing since 8 days (last pass: v5.10.131-cip13-24-ga6f4ea41fe167,=
 first fail: v4.4.302-cip70-rt40) =

 =20

