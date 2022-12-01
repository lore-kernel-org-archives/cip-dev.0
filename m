Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1860FC4321E
	for <webhook@archiver.kernel.org>; Thu,  1 Dec 2022 21:53:37 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web11.58739.1669931611743939437
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 01 Dec 2022 13:53:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=CnozwgjH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id cm20so3136071pjb.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 01 Dec 2022 13:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rgHwn5t5z6BKwFDsYrkH3Yykdl8Hz16Q707hddXLtE0=;
        b=CnozwgjHyB1ip1P+JLkSwr0pbeEGOAnf3IWyP0orGUODYLa15xAfEWJEjviVEfqGvB
         62BtZtmIrCfNC75YHckNHLD7O/+dbtCTO1ra6p8dS23IHBSERaZFY/WsHGgkOP8OCEeD
         tJhMPijkkCyYLPHP2UeXtwJVAr5PC2VDL/9XBL/kgIcVF30j55Qb8VJHDRmYWkIgNhFD
         9oexzuVJ9iW2nAYjIKvlx79FjVIMkimlQxX1XJSS/GHMqTK8InsM5UjQE/Uoa+3uQkAk
         Z4CGBiCinBANuRH4TtUUlt8uHVsLVAkOqsUdls6sXeTeGapF4peoscDnANRoHxaZN1RA
         XaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgHwn5t5z6BKwFDsYrkH3Yykdl8Hz16Q707hddXLtE0=;
        b=iOk+4ianJvb9EpEL2egr+O8sReIok5NyvNad6Kq82NDsfrwk1bwvAXlT8UeLFhzJLf
         WyYDB+7U4Hdkr61Ap6d7PnTINYF2EhmuPr/4zdL6SO6N1QhRiQMSdqUGyRCDJgET6N/8
         r7dYArwE/WAAc+0Kow5kDeKgJLynP1pcQ+YBhc9D6a/LYUZsgbCNI+oI6xPh11X4Ix3n
         QC9dLjF4LrawpY9Zia2vjZlCu2J8oN3NAgoeDRbzOZcyo846gejKcBx7PE1F5rHVl8eE
         hsMRUdnoXlhRx1BZ3wGzjoHWlKvR0E0EwNVeHqDVi/P4DNYQXOGh8cKD9IwZirLA+NWX
         e3pQ==
X-Gm-Message-State: ANoB5pma3Up3n11rlZR2PR29Zpy/gbov+t54JAeuG4e8DiD1Gqfl4fvQ
	CPkOGutGO8H2a/c9QycsPaTEeyKQhwNTEzOHxZg=
X-Google-Smtp-Source: AA0mqf6Szl1cKvaNgkwSGGlR7ZcVMH4ynVb8FQkxtWFZVuxBYHuyZ5u3M+Iwh1BUw3Zz1JgWuqvo5A==
X-Received: by 2002:a17:902:7b84:b0:189:6623:4c47 with SMTP id w4-20020a1709027b8400b0018966234c47mr35447781pll.170.1669931610670;
        Thu, 01 Dec 2022 13:53:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l6-20020a170903120600b001893efd3e03sm4156445plh.119.2022.12.01.13.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 13:53:29 -0800 (PST)
Message-ID: <63892259.170a0220.bf1b3.86f0@mx.google.com>
Date: Thu, 01 Dec 2022 13:53:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip71-1-g61333eee4869
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip baseline-nfs: 20 runs,
 2 regressions (v4.4.302-cip71-1-g61333eee4869)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Dec 2022 21:53:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10156

cip/linux-4.4.y-cip baseline-nfs: 20 runs, 2 regressions (v4.4.302-cip71-1-=
g61333eee4869)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip71-1-g61333eee4869/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip71-1-g61333eee4869
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      61333eee4869050c46b5f75ae6d337998d39f2a0 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/638916abc9976575bd2abd24

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71-1-g61333eee4869/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71-1-g61333eee4869/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221125.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/638916abc9976575b=
d2abd25
        failing since 2 days (last pass: v4.4.302-cip70-236-g69445bc0d420, =
first fail: v4.4.302-cip71) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63891bf2b7928025402abd18

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71-1-g61333eee4869/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71-1-g61333eee4869/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221125.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63891bf2b79280254=
02abd19
        new failure (last pass: v4.4.302-cip71) =

 =20

