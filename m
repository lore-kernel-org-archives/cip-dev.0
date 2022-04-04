X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web08.33138.1649064762464141700
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Apr 2022 02:32:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=gU/S9IOM;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id i11so7626512plg.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 04 Apr 2022 02:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=iKakI3f/Qpg5kCOtuASO1r9vDNpgLyB6TGBZpUToMaQ=;
        b=gU/S9IOMeyq0IqO+cs/4as+lo7hIZzq2keTjb6NAHOYRsnOI7X09kgu2FhlY10gavr
         Ly0BqNHb6X19R5xESX/DBwrifphZ7Uiyu/3mXZPoQp5WtGA4UwGR7bHtziFwI97dJQDG
         SvNq0Y0yYhKZwsjMeBZuLtBSjnxdjJTr4Vt4R5euHSHKihjKAOC2rx+wXKvCe8Cpj5EL
         Nnw7kuB5vTw3S/vXmE8XZQofQEcnKhExeQkaA5Pf6PdB51BA8ii/lty4+RrgxsGiWldb
         myOX/rF3VFQ1qQkoHeTOj9AoLxAldBF3khJKv0KMufxljqspLrTk95+Q1fD6ssQwgrEV
         1UdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=iKakI3f/Qpg5kCOtuASO1r9vDNpgLyB6TGBZpUToMaQ=;
        b=uONkD+iechu/cKJTfdXklqm830je7gMXbJQoEfwRokDtct2CGG/pfMQ/p3ctC10Gil
         CUATT890o8XGxkPslXaYUfq/t5j5IgaeNOvolJsHmzN+6DwwiYcHE/1Vyyrvs5/dV4Qe
         J4WRI8UODgUvhqsZAVx1tRZu0wpsjSB3lGyW6GicDtPflFrbYLFhSuEVJxFQxYjFM0y5
         3xqQ1tjrERR9EaaKwiyPwagBFIhXQGPcLWQ80g4zZTW1Z0O/7gf8Z7HifrzngSWpDPme
         En0eG8cNf8xUPvwrffXxpbyKm2U10wzxQCJ6bABQtLjgwCmU6UZlUrdqdEHJi41phJrF
         bs2A==
X-Gm-Message-State: AOAM531oDKOYIB9O39CSwgrhfwLijzze/6IUCtedHJg28s3Mb5KvlnJn
	aXFgkZUUZG06hUlTAF9Jodf87ZXw9ObuWvJ1Y80=
X-Google-Smtp-Source: ABdhPJxPmJ1wqbLKMXomK9ePPFhq2FKCJf+7fAHTfvXfAm+SA2RuPuxjYo0iXIxRCz6dqsGIArBPpA==
X-Received: by 2002:a17:902:f682:b0:154:8500:80bf with SMTP id l2-20020a170902f68200b00154850080bfmr22571108plg.112.1649064761739;
        Mon, 04 Apr 2022 02:32:41 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c7-20020a17090ab28700b001ca9514df81sm3363347pjr.45.2022.04.04.02.32.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 02:32:41 -0700 (PDT)
Message-ID: <624abb39.1c69fb81.aef70.785e@mx.google.com>
Date: Mon, 04 Apr 2022 02:32:41 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-1479-ga84d0db6dfc6
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 3 runs, 2 regressions (v4.4-st5-1479-ga84d0db6dfc6) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 3 runs, 2 regressions (v4.=
4-st5-1479-ga84d0db6dfc6)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-1479-ga84d0db6dfc6/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-1479-ga84d0db6dfc6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a84d0db6dfc604c5de8b5446ea27ac9a039ae378 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62445035dccbf70f43ae068b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62445035dccbf=
70f43ae068c
        failing since 13 days (last pass: v4.19.233-cip69-1019-g2e5815777e9=
75, first fail: v4.4.302-18-ga78419826225) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/624451383403bc778dae06e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-cip-nfs-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-cip-nfs-hp-x360-12b-n4000-octopus.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/624451383403b=
c778dae06e7
        failing since 13 days (last pass: v4.19.233-cip69-1019-g2e5815777e9=
75, first fail: v4.4.302-18-ga78419826225) =

 =20

