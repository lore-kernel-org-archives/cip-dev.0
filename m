Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BC7C6FA92
	for <webhook@archiver.kernel.org>; Sat, 17 Sep 2022 16:45:35 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web11.429.1663433131995223424
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 17 Sep 2022 09:45:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=qBqz+gvZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id 9so13032438pfz.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 17 Sep 2022 09:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=L75hrhYEj56tjyzN/M0ORaBbGYUNz+pdAqVtBdw5a6Q=;
        b=qBqz+gvZVphtvd7EtXSA6amonB+PZ76Xg8H9/d6b9beV6stCMtMvvn4lCoU0c/9kQ2
         6zSvIu97LuasuT0BfqjZKCU2LzYWD8Xc76o29ZpoSkKB2cfq8G+zREw1eK+2UxAkqxmc
         hPrkVT5tMGOnhgNgNNJ8W6A7Y+zVp0IqaSHk/d2zdb0tFN+CaZ7/BzNoXzZnQnqelk5K
         fae6OhYMTlg6QSlOAPlSHMaQDZNOMV5ZXPUi1hk51hvIM57vQABfH6SOuHiOSr/lpN+1
         VqY/pK0TPV2TuGiLrv2RmqszD0df5T8aRQp58JRd4JKymwhuljZ/8n9PO3AMWKTXqw7m
         xLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=L75hrhYEj56tjyzN/M0ORaBbGYUNz+pdAqVtBdw5a6Q=;
        b=5DkESKd2GYxhv6SkKdZAvqOB82hH7v3Gbk1GiQrOlFoX9qMXLCujizr/WVNqPVjBdl
         jNVr1jLZHQ1KaIQuzKn7sJM8NQinMKH7WjGbrq2Ho6pzMF0+vJZCQANWG0JfJAiAnZfu
         DH/9KOlZT+zcsdUVopW7GR3fkF3TePSwph88x/wvUWBavbU+wJ63Og3vzZpwIZ56SdqC
         3oFbFvIifQjIO8conmPvQopTkAs5yeS3uefSzHiEdocLW7REh8PdiezWPVBSVEommJkC
         6vXcRCM5LB0loXJCNbZY42D8mdrPqM2ZkM7NVkqWefPc0jw80VY6MFoNzv7cc43fYPDL
         B4mA==
X-Gm-Message-State: ACrzQf0x3P8qS5fEjmBueer01/vVODpjdfaa24vmC2vhuiMfNqqpxl83
	0+iY+7Opnk2lj3mKaH/evf/+XCLFFd99UwVT5CM=
X-Google-Smtp-Source: 
 AMsMyM7WNrNPlfwfDeUvsZGy3j5CpHCw53S6Ew07UhCUsR7+zs5prxT4e2ZbpCAeYU0kzAcIbqv4CQ==
X-Received: by 2002:a05:6a00:248b:b0:542:6ae2:24d5 with SMTP id
 c11-20020a056a00248b00b005426ae224d5mr11116198pfv.65.1663433130897;
        Sat, 17 Sep 2022 09:45:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 i6-20020a17090a718600b00202b5053481sm3376787pjk.57.2022.09.17.09.45.30
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 09:45:30 -0700 (PDT)
Message-ID: <6325f9aa.170a0220.669de.6139@mx.google.com>
Date: Sat, 17 Sep 2022 09:45:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-229-gb433f12afe250
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 7 runs,
 3 regressions (v4.4-st20-229-gb433f12afe250)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 17 Sep 2022 16:45:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9503

cip-gitlab/ci/pavel/linux-test kselftest-futex: 7 runs, 3 regressions (v4.4=
-st20-229-gb433f12afe250)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-229-gb433f12afe250/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-229-gb433f12afe250
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b433f12afe2506afd30066f5b2b826129a20bc03 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ec79823e7de34f355654

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6325ec79823e7d=
e34f355655
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ebd2f77bbf7a2b355642

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-futex-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-futex-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6325ebd2f77bbf=
7a2b355643
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ec7867f1a3db55355642

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-futex-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-futex-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6325ec7867f1a3=
db55355643
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =20

