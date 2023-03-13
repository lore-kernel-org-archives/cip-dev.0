Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217D9C6FD19
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 14:06:25 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.20787.1678716375090830675
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 13 Mar 2023 07:06:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=PoERmogi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id a2so13066449plm.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 13 Mar 2023 07:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678716374;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YvsKYakSVEiL7pU7q4jBcXPVFhKw6O6NwuyeBwQZl7A=;
        b=PoERmogivEw8AYcZ84Y2ShbEtOJvgFft7Ow9A8oB4sMWal6mUdqzyhfchhxP3bHcBf
         AezGYcJWTKoTI/flTQe9MBO5kz+xoF52X8CvIJzWuuPMXHkvKy2y2Bq2e27czDp0MXKL
         AKqELPDL3XZ+QeuokMHGCc9cjaMVekVG+NUnAbgk4M+uLfCYq10dKX5JED4xh6fujTM1
         EKi98Y5NMUuHeR4X+mtIdkoZDlyjnt+W8jEtoP9nU7LoFX3fiwy/G7iZZk0WFm3KbM7T
         a7gARz55Zcwo1xLw+aewfKgucP6VnzwJVfskxoqEfxXWfo3eLufisp0XwsJTRLvL0bAB
         XkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678716374;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YvsKYakSVEiL7pU7q4jBcXPVFhKw6O6NwuyeBwQZl7A=;
        b=fZ1vo1xYFL3IBN751zfHT2279z/xelvuz1eVYzAQO0ZNldGtkOSOPvtg/TZVxSB+Mz
         Cxib2BOnR8nGBcgF4toeIkIYpp3zE44BplTCdOKLKCbGmBybpx/wt9uQxamqgZr3bhnq
         /1q8PiAdPjvy9dDTfv2mrzIqAdXWsw0tddihsWikyejVC4Qu9eDAXdChbTtX7Mk8C6z/
         wKiUV88qJtnuNchuOxdHAtgzuCe2g6c+w3r4VGaT03W0IJf8s/zhABttR73wlcQnGBYm
         4bUdjznsTvl5+rLuLqj5nagliam1bHU9auiYL9fQmitiaGCic/sQ+VRCzoVLIxuK1Oeu
         AmCA==
X-Gm-Message-State: AO0yUKWtt6eWFuzN6YmvjS7kn+oLObbPSx4LLumGDnHv8kZjonhzw4XG
	IEUmDW2IJHmbgS/FDh9vChPlO4pXx5PJz7L8yvKezib0
X-Google-Smtp-Source: AK7set8IKezdgOxAaJzb8DGVTFdBjgNKCWlbqH/rpV8j1T6XQ0pAViH3ymkoA+t83cZsBLTv43J6GA==
X-Received: by 2002:a17:90b:38c3:b0:234:159:4003 with SMTP id nn3-20020a17090b38c300b0023401594003mr34687424pjb.25.1678716374276;
        Mon, 13 Mar 2023 07:06:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id nl13-20020a17090b384d00b0023a9564763bsm1263014pjb.29.2023.03.13.07.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 07:06:13 -0700 (PDT)
Message-ID: <640f2dd5.170a0220.80c51.1f4d@mx.google.com>
Date: Mon, 13 Mar 2023 07:06:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-939-g5ff13a6decb9
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st ltp-timers: 5 runs,
 1 regressions (v4.4-st20-939-g5ff13a6decb9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Mar 2023 14:06:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11016

cip/linux-4.4.y-st ltp-timers: 5 runs, 1 regressions (v4.4-st20-939-g5ff13a=
6decb9)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st/kernel/=
v4.4-st20-939-g5ff13a6decb9/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.4.y-st
  Describe: v4.4-st20-939-g5ff13a6decb9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      5ff13a6decb9b0e64a7efe5e840b90b27be9150b

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3cbaaddf6f785d91aeb370beb75d0623f8c48624 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640f233423bca88ff08c8653

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-9=
39-g5ff13a6decb9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-9=
39-g5ff13a6decb9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230303.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/640f233423bca88ff08=
c8654
        new failure (last pass: v4.4-st20-821-g39bdf0444b23) =

 =20

