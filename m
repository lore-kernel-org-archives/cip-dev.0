Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6470DC761A6
	for <webhook@archiver.kernel.org>; Tue,  4 Apr 2023 11:18:11 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web11.98637.1680607090501250621
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 04 Apr 2023 04:18:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=8Kq7RzfK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id x15so30145805pjk.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 04 Apr 2023 04:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680607089;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0wdahUP4SODEuPqe/l4yfoe5q0gLE70VH3w38TOGdJs=;
        b=8Kq7RzfK57UfRnEDtxkcviAQGLE6i+nqKpyNpWWOGmiIHmnQ+kzccbybFknIQoGHsI
         KDjzDaV6X47Z8kOlaVPAOcETXueptxdpyqhpakcHbEiOsvvA5E077AhNwNr4suUyOQ9u
         wLxiGapFEhxGvbfMDFfuhx5Q77QDjA6trL0uuRVLz29BFUtLtYnijcl1suXZukDn1WUQ
         5dD8dsv8z+tXHbaqREZ86rCLORdQK7D7BYyQBeesGEaKcmNgL610eHKwi3YOCobsybEP
         n85bWwj6VQzOexxRUJZ5dGOSFHRWNamKhOSeACTil6gM3eO6zHEbwck/EzjHdBykRx/n
         iAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680607089;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wdahUP4SODEuPqe/l4yfoe5q0gLE70VH3w38TOGdJs=;
        b=dNQXo39zJgRTiwLiIiphGYVTy8H6dyc8ZVQpdVTimmaDu8Jy2i+/ej+9evVrAvpOCV
         Ro3VdJI7oNtK9pXEYJuF55SIhjRCV43FdnslpGFVN7LBWHUIUu8l4127AdFKwZEqQ7W2
         aoRR3MyDyI0x6zMG2OAREODP0s/ORb7BicFdG77yJlgLMcNBBcalRKyHbgiwLqnPMdjO
         fxv8mN2BxHOfjiyL/MpaWQbRvn6KeGN+TSH+Gl2dIismI5TB03OS1IN6MeTZ2nlku41F
         YLUkvElTrUrY6jHyWUbxpVjilT0zz2aLZw28AKos0X6iuYBa7zJXDsQHKI76ZxA/Y3tS
         wFEw==
X-Gm-Message-State: AAQBX9ccB76zIxiT291+V0YPbRcLkjeCGlLYkP63kvk6UOrbGryGOCzn
	6BWXwkgPOYi2jx4ed3WJBFGFcKnMwyHSkixLDpNBBw==
X-Google-Smtp-Source: AKy350b6cMAYVoIawbr4MPoPbqOHkpXrY2D7skLA6XWNFLeCmhdCi/EWa4vFQ4JId2bM42+0T8QzSA==
X-Received: by 2002:a05:6a20:b21e:b0:da:f3cb:764e with SMTP id eh30-20020a056a20b21e00b000daf3cb764emr1795939pzb.23.1680607089484;
        Tue, 04 Apr 2023 04:18:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w7-20020a631607000000b00513955cc174sm7468601pgl.47.2023.04.04.04.18.09
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 04:18:09 -0700 (PDT)
Message-ID: <642c0771.630a0220.6455f.ed12@mx.google.com>
Date: Tue, 04 Apr 2023 04:18:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip74-rt43
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 4 runs,
 4 regressions (v4.4.302-cip74-rt43)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Apr 2023 11:18:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11168

cip-gitlab/ci/pavel/linux-test ltp-ipc: 4 runs, 4 regressions (v4.4.302-cip=
74-rt43)

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

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip74-rt43/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip74-rt43
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      22456e8b8d35c6bd1313511bfa4dd945ce7a0c1e

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  70199ce4f0c498bfc7d0d9e0440f54b97b373b26 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf97f4a50717a3f79e922

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-ipc-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-ipc-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230331.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/642bf97f4a50717a3f79e9=
23
        failing since 13 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bfc491c993ad25a79e956

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-ipc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-ipc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230331.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/642bfc491c993ad25a79e9=
57
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf9804a50717a3f79e925

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-ipc-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-ipc-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230331.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/642bf9804a50717a3f79e9=
26
        failing since 13 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642c05bec37758223079e937

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-ipc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-ipc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230331.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/642c05bec37758223079e9=
38
        new failure (last pass: v5.10.175-cip29-rt12) =

 =20

