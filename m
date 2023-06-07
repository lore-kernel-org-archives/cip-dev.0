Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C60C7EE2F
	for <webhook@archiver.kernel.org>; Wed,  7 Jun 2023 15:24:25 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.1041.1686151461989540080
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Jun 2023 08:24:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=BYzlmfCt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1b039168ba0so64835145ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Jun 2023 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686151461; x=1688743461;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O7QB8JnvU4FjsHMMkCTLhUqC783lXWEn0Th+FvMIIrA=;
        b=BYzlmfCtxSMQPu3uHamjh7I8p+7V8R9bd1D5KgqGrAR5C1AE6UEK3NJQ5fn3Lb9qxA
         YR88ZIjS+QXbkfmQNHl+JA4jk8ZT27NGrA5DfHfwjytOD7iF3qwrDoKavF3mSGxuovpL
         XjlGG4P3geoVSxwy63+BmkG576LirY/jIqFXLdZKE6pCGHZozaOo84VyCC4Jzu5MzvXL
         Rb/uGKiY3qZHY86sIzhISNFbp6sS02U5MCV1Ys7EG3jy6P+RsFuzD3KENRIutSmhhiFj
         Q4cI0xembHENoElZ4xX7y86lULDdHPRoVnRbmQJaRyEWkRFkLqN2vuMmP74V6hclLl0l
         3z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151461; x=1688743461;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7QB8JnvU4FjsHMMkCTLhUqC783lXWEn0Th+FvMIIrA=;
        b=fbC59EotMdekeIU3CN9GwpEJ5PXZ/A8hGrkvtCxtQWe4zG1S7dqkz0i39yuP6CCeTu
         mL1GRgcHhqPpk4uqpP9BLwiKMF4ijn9+PBOESzzQPBzn9OoJeM2O4ZQQHdupgylt0Zb1
         dA30gc0II4iOKM8hHr3BpgKFG4pcd580C4u36YrSp4PHVgBvK2bmOXu/lXjW6xr1ohR0
         amTDjjSEw0odIer9XFC2KVJIg1MbeuK5Z06opxCWArEr9OURTyndkPLOtwc9s73+ac6Y
         AGiMEzxWdDEOFg2GY08497BoQBy9U45j2WEW3a2+kvuh78FYsiwVEXIQIQ/p0H2xRWhu
         c40w==
X-Gm-Message-State: AC+VfDz/qkeeS7hShg/X4m3dXHQEMCwcGLO83W0lluGBuE4Ped0IAm+o
	6cQnDThRDc+e0Kiy8JVlRk77rduZ1a54mbdTnsHRVQ==
X-Google-Smtp-Source: ACHHUZ51SVsmd0vwW/SPQ00JoobA8cmQEEbz3U3UpEYl05GJnoE5G25OSJKY6vO6jtMcV/0tS878Zg==
X-Received: by 2002:a17:902:ead5:b0:1a2:6257:36b9 with SMTP id p21-20020a170902ead500b001a2625736b9mr5516869pld.31.1686151460973;
        Wed, 07 Jun 2023 08:24:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w20-20020a170902c79400b001a980a23802sm10648655pla.111.2023.06.07.08.24.19
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:24:19 -0700 (PDT)
Message-ID: <6480a123.170a0220.44a4a.40a9@mx.google.com>
Date: Wed, 07 Jun 2023 08:24:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip74-rt43-218-g246f4be89a77
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 7 runs,
 4 regressions (v4.4.302-cip74-rt43-218-g246f4be89a77)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jun 2023 15:24:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11921

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 7 runs, 4 regressions=
 (v4.4.302-cip74-rt43-218-g246f4be89a77)

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
nux-test/kernel/v4.4.302-cip74-rt43-218-g246f4be89a77/plan/kselftest-filesy=
stems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip74-rt43-218-g246f4be89a77
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      246f4be89a7760f90649094cbfabcccfce7dafd1 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648091d6c31042a97e306132

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/648091d6=
c31042a97e306133
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648093946db05a20b33061fe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/kselftest-filesystems-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/kselftest-filesystems-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/64809394=
6db05a20b33061ff
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648092e044c991a25730612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/kselftest-filesystems-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/kselftest-filesystems-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/648092e0=
44c991a25730612f
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6480933eaac3bed9bb306131

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/kselftest-filesystems-hp-x360-12b-ca0010nr-n4020-oc=
topus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/kselftest-filesystems-hp-x360-12b-ca0010nr-n4020-oc=
topus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/6480933e=
aac3bed9bb306132
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =20

