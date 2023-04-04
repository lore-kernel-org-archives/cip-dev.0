Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D4DC6FD1D
	for <webhook@archiver.kernel.org>; Tue,  4 Apr 2023 11:18:11 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web10.98562.1680607088220492873
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 04 Apr 2023 04:18:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=AiyIeZod;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.172, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f172.google.com with SMTP id s72so3598636pgs.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 04 Apr 2023 04:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680607087;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=noDFezmE5nzrISBRF7wEdAPN/abE8cPj9AFvvGl3V7g=;
        b=AiyIeZodetI+vCp9zIr+DCbJ3hmww/8TG7vwtz8q2rf2EgEWNrzfHBrbyXvutRMQCy
         4rKOALru2//4ifdv8HIyEglG/4z4M70nf4bH8miE4N4bppV5zXEaZO4XGtOiqNjFa2Mq
         O7RRrQnfxEQTedr6qlpJBlveS8GJzKAkxbbuVlqiA8hY+1pUrUJNQk55lpSy2pE54e/F
         pbEA8c1hxEQeiDihCR9XcDlai/6X0ZAOqA9Jij+ueJtt1X/dG3rt14mv0xe41j/uk8tT
         GNNgvEKciJOHwE/puRzs1qoVe/R+9NYh8d9DhrsfA+mbTU1ktjKZTPjbHZUp9vK7ZLSa
         rLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680607087;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=noDFezmE5nzrISBRF7wEdAPN/abE8cPj9AFvvGl3V7g=;
        b=tnF9wZdVT/Mk07EtifIwJ+Jmn/FO/DjvlKTb4ULIMqopOsm+PWRbFezU4PBjeFOOza
         KDns00cvK64PyIuPIzGA9aJddnj754arcOhVB68VfsLZJW/tWsbr/Z7xDVKG+PY1SILN
         DVa0en0PsZrnJAGHdKEcZBz/isc9Z2FuhZg7W21s/o9eOpdK6We2EzMW/b4Tlk+SrS7H
         QILYVE089pl9eVY9kjBhhhnc/ksqNR34w5bmjJdshqEF++9NeHufx85HwLQhDrF/ci48
         21YnjZmqyj0qpsEh1OT1uMkddwzghnW9GW9dRdNte0+pPDTk/GhIZYseplwkmikgaPsC
         IqNg==
X-Gm-Message-State: AAQBX9c/oBBFTnWj9ro9CCvMnq0SQPS3ZbApVfgDFQo691AP0JG+O2MA
	lzpik9iBQdiTA32/tXhZ9HbytR8uu9xo3kVY0Ah7Gw==
X-Google-Smtp-Source: AKy350ZAJSL5lvd43XeN4ii0V2roRwKwNjHTm1I8aoAnRZ3OEHhN2wPY40eK+Pb4XvA2ykAD7gbdnA==
X-Received: by 2002:a62:6454:0:b0:626:7c43:7cb8 with SMTP id y81-20020a626454000000b006267c437cb8mr1819167pfb.20.1680607087222;
        Tue, 04 Apr 2023 04:18:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n2-20020aa79042000000b0062ddfce5cdbsm8413425pfo.45.2023.04.04.04.18.06
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 04:18:06 -0700 (PDT)
Message-ID: <642c076e.a70a0220.64583.fefd@mx.google.com>
Date: Tue, 04 Apr 2023 04:18:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip74-rt43
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 4 runs,
 2 regressions (v4.4.302-cip74-rt43)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Apr 2023 11:18:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11165

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 4 runs, 2 regressions=
 (v4.4.302-cip74-rt43)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip74-rt43/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip74-rt43
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      22456e8b8d35c6bd1313511bfa4dd945ce7a0c1e =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bfaa8ab701a01c079e922

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/kselftest-filesystems-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/kselftest-filesystems-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230331.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/642bfaa8=
ab701a01c079e923
        failing since 13 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642c03cfde4e20532979e949

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/kselftest-filesystems-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/kselftest-filesystems-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230331.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/642c03cf=
de4e20532979e94a
        new failure (last pass: v5.10.175-cip29-rt12) =

 =20

