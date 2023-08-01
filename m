Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC20C0015E
	for <webhook@archiver.kernel.org>; Tue,  1 Aug 2023 11:51:29 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.10694.1690890684403831707
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 01 Aug 2023 04:51:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=vsb6m++U;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1b9cdef8619so34251055ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 01 Aug 2023 04:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690890683; x=1691495483;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=23OITYUB3ckHVKWtsSgSMmZteB7P/yuKnzaZ5qiQVFE=;
        b=vsb6m++UBuJUtJ2b+Ij+40v8khtFoaWa1gSYWp0g56geNVmxAcjO0JTzZu0TwQueH6
         +Bb+00fAtKWVX62K3NgNy1w/vExmAQbgS6pzXzclPy1O1r85TRU7v4OJyJgiBaMYRxOj
         qTrYWddajmXKkwRQnmDTw3mEEx6eqvU5P+zs3WA/n/LBF2xCDiNf/vANk+JpdGiJx3aC
         iI+c5z1KYzU9seY7mwm+mvdSy3mT/XZ5rI3iL7FUiXZQRIjSM0aiIoWkznG+//fCfQkT
         A11ihclnEWb1zz5o74bJx7wZYaG6VIrJ2YXMYC9P1v1aWzOqceDH9OjCMdkllEjL+gNM
         q1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690890683; x=1691495483;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23OITYUB3ckHVKWtsSgSMmZteB7P/yuKnzaZ5qiQVFE=;
        b=lS6s9gkBC6LBFxggfIjYRYRyVVXuG1QPqnYaqmM/pDT6p8SLbAl3TrNcubZcPFz+5N
         Ek3YTJC1fH2dH2wfEd1ELQ927bFYQzQr/uG+XBP644oMUDqd0VkS8QT5obZH9cteX9tS
         u6kGZBX10+EdTLhS0B/AEo+klZpf0+3PWFC/Qr9EPA6+vGonf1oSTEh/f008n7utVRUX
         Amq0SVRnF37c3PYatxJCdhybnrCakY7GcbmyonhZl5VF25XaiU20TmzqSjdqRoZmDuPy
         GKb5GzMBwr5AZUsiraRT91gp31dMOF8TjHlzo/9iuOg7adVIlb8fRM5/3fJt4QgggxeD
         dbVg==
X-Gm-Message-State: ABy/qLYsxDiZ3UydMUmIgguRzK+xJEYYK460KVonFWQcLRou681Y3nAs
	d1VwDUKm3AZfWBrDjMjFChdisaV7LvJERfZ+FsWpXA==
X-Google-Smtp-Source: APBJJlEHBBZGZd7+BXmf9B2SfiNmYo5JH84UFSJu8yYqUbQnS28SwQaJ0Ff2mHmlvp7scVz3shLbiA==
X-Received: by 2002:a17:903:41cf:b0:1b8:ae8c:7bfb with SMTP id u15-20020a17090341cf00b001b8ae8c7bfbmr12584991ple.17.1690890683278;
        Tue, 01 Aug 2023 04:51:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ix17-20020a170902f81100b001b3d0aff88fsm10378529plb.109.2023.08.01.04.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 04:51:22 -0700 (PDT)
Message-ID: <64c8f1ba.170a0220.c11c3.374b@mx.google.com>
Date: Tue, 01 Aug 2023 04:51:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Kernel: v4.4-st20-1446-g679130ec67b34
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc baseline-nfs: 12 runs,
 2 regressions (v4.4-st20-1446-g679130ec67b34)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Aug 2023 11:51:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12530

cip/linux-4.4.y-st-rc baseline-nfs: 12 runs, 2 regressions (v4.4-st20-1446-=
g679130ec67b34)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

hp-x360-14-G1-sona       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1446-g679130ec67b34/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1446-g679130ec67b34
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      679130ec67b34c822902926135425ce7f97f9960 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8e9505af8529f148ace37

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1446-g679130ec67b34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1446-g679130ec67b34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64c8e9505af8529f1=
48ace38
        failing since 96 days (last pass: v4.4-st20-1097-g52d843097a439, fi=
rst fail: v4.4-st20-1186-g2516b357b2e3a) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-x360-14-G1-sona       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8ea60517ea6f8a78ace2f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1446-g679130ec67b34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1446-g679130ec67b34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64c8ea60517ea6f8a=
78ace30
        failing since 203 days (last pass: v4.4-st20-234-g4e6ec7162c8e, fir=
st fail: v4.4-st20-799-g1229c813bcd9) =

 =20

