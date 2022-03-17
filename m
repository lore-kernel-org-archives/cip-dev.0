X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.7292.1647499441929537728
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Mar 2022 23:44:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=0Ozrqjjq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id q11so3675995pln.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Mar 2022 23:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=2sigzmRqCtBafCCzZzpTuPsGYS2F8Gx5uV+oL0+iNlM=;
        b=0OzrqjjqHgZG6KF5uvhfS+3i80RJoitvsVfmtbMbgIgUAB39G1fdQKbhMT05FE8EBn
         l72A+MZJSrJIVNBfOSbNWn48zfdx8SfIavQnqFQPejFSYA+hfbcLH4NlcAJIarGX/jT6
         XzPx+5l6gItUZnzlm9t6Fz4Ntyn2qRMeMhj3bCvoDW/PNB3bd50yljgem7wnGYitPEeY
         wdvNoAJK0QDn7ruCpiKMdogLB20lowBLL0XlYLRe4uMS0ovZK/9Ugmv1utUdpIYmoDEe
         kx6sJp9gXPpZCp2xvPA1H2P70DIFOzTNKRyc1TK82VTVk4A0W2ZvCQiQSEQjjrO4T8A8
         0d4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=2sigzmRqCtBafCCzZzpTuPsGYS2F8Gx5uV+oL0+iNlM=;
        b=DLD/WjNz4r0xqOCoSd7DAu3JGE2fPiie9Xt5Iti9LoPPKYpaSjw+7s6GYsn0E0PztD
         MY73Ee3gEQOzEyQ1S18E6nusPD6yw/0/hi/TSkoDD7Gf+d6JMTb3lX7MGhYfXe1UwDrF
         UPx974fv+HsvnspdgNxIUhJ7rxDcAdAj1hFKMJVv6ypK9pXUCsL6VQGGBVOX+AB4y/gm
         mjQwZ1nSJLTcvXAd5eRc/f08g5RgoTQwdzcBzbAkaEJfLIa+PwcEY2HybZBnO8itMM1L
         wnxHjQJWsFmDVS8xYLronoxIomh68eAZa12UqhvWNKxM37mJiyOpopj3DjqSsgHMJ9/1
         rhlg==
X-Gm-Message-State: AOAM532ff5BmyDWzkLUa4t0bmVzlaHVCZGWzTTfaTt/tYHbfEz2IpfEm
	ySNCzJNJSD3hlBKxHRpmhGmQXxK3qB4LAj3TNlU=
X-Google-Smtp-Source: ABdhPJxUxEuoYtOmm1fyud7C3n6iRj9CnUTorKOGLD0OucbOvgWY/BF44HJo6bpd/03fksCqd/VZdQ==
X-Received: by 2002:a17:90a:ab08:b0:1b9:c59:82c3 with SMTP id m8-20020a17090aab0800b001b90c5982c3mr14057981pjq.95.1647499440992;
        Wed, 16 Mar 2022 23:44:00 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ob13-20020a17090b390d00b001becfd7c6f3sm4861277pjb.27.2022.03.16.23.44.00
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 23:44:00 -0700 (PDT)
Message-ID: <6232d8b0.1c69fb81.d6f08.d0fe@mx.google.com>
Date: Wed, 16 Mar 2022 23:44:00 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4.302-cip68-19-gcfdd1ea3a7ba
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 3 runs, 1 regressions (v4.4.302-cip68-19-gcfdd1ea3a7ba) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 3 runs, 1 regressions (v4.=
4.302-cip68-19-gcfdd1ea3a7ba)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip68-19-gcfdd1ea3a7ba/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip68-19-gcfdd1ea3a7ba
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      cfdd1ea3a7bab80ea3e513f28e7aa423fedf5d61 =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6232d05350d84c4852b73951

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/6232d05350d84=
c4852b73952
        failing since 0 day (last pass: v4.19.233-cip69-1019-g2e5815777e975=
, first fail: v4.4.302-18-ga78419826225) =

 =20

