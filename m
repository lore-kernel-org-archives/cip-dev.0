Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D6AC433FE
	for <webhook@archiver.kernel.org>; Tue, 22 Nov 2022 12:01:39 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web10.16811.1669118493487990677
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 22 Nov 2022 04:01:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=HnmipCJx;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.178, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f178.google.com with SMTP id 62so13840730pgb.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 22 Nov 2022 04:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ru/SDrjS6BN+JDucw4Ep31DMEzERuGwLdnYIyw5VEyI=;
        b=HnmipCJxijWGyNAWAZUWBGLx8jy5q/rDxrfJN/HXzQV+uRj75ECcJetGmgEH+m45hk
         amx4V4XYXET10T782ro6F1L+sPSWHTgEyhjFjd8t27LIZP3YTPLXTF8th0lt1VRqJqBg
         RxrHNhMEriv1bwnD9m8n85ptspBFNbL7nn3QQslRrPl1RxQejz3ZXP6RCN/92bQ4yWti
         bl5RbQ4b+E/maCGCL3Ocd8xH+cVf9ekWm+1OqkwKqUFB5sGThDNsy50QbJ9gPLXefUoF
         kAG7WOii51YoVQjBcircQ2sB9lUgkOTk9Ui5/VKghw+BFRjZokhfaG9RnLGM+i+aeAM1
         dkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ru/SDrjS6BN+JDucw4Ep31DMEzERuGwLdnYIyw5VEyI=;
        b=I9JmSv/gE9dcQTxhqDLnW9oLvlft8GxJLfsG9V5n7AIj2yy1R/V0ScQpCdoSwJg6Bh
         FGcrkgDqvzcGLt5tX1clUQ2dYlDScOPgmTBu/FsIGOAhc5lYgaB+5+GMIbQiPdHOeBcT
         pGMf9jmki9XLB541kEau67x4w9NjPaKcNz+6TCA3IPpd+vJfzYp41osLe9PAfcXMkLzV
         LkRXQb7tVZh9X49qTyuP/mgmuOK6a69R7sr8vcAVVHc5X3TFcTg+1LaWCaYpldH4Vz4E
         WEcCuTgtL4MI0t+lyKYs2aRx8JegyrbBylO+2iKpKvi0XZv7krs4tHCY1bRmRHrWsM79
         VJFQ==
X-Gm-Message-State: ANoB5pkNQJV3zuSn5M2nyDPcz6JgAGXAQFLrfaigJ+X6096+tW/FEpoI
	b1FDnLAQErjkPtCQTC4sKWwEWthpLOcGxlMIFMs=
X-Google-Smtp-Source: AA0mqf6+jljDMbBU3I0ph1QNNEi7dm5mommLQcKSTm/akCn6BTliHxvNcNndixvWneXC4gMwuorykQ==
X-Received: by 2002:a63:4626:0:b0:434:b8ef:1ec6 with SMTP id t38-20020a634626000000b00434b8ef1ec6mr21875585pga.246.1669118492517;
        Tue, 22 Nov 2022 04:01:32 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id cp5-20020a170902e78500b00188c04258c9sm11792002plb.52.2022.11.22.04.01.30
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 04:01:30 -0800 (PST)
Message-ID: <637cba1a.170a0220.3618c.1df7@mx.google.com>
Date: Tue, 22 Nov 2022 04:01:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4.302-cip70-236-g69445bc0d4209
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 4 runs,
 4 regressions (v4.4.302-cip70-236-g69445bc0d4209)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Nov 2022 12:01:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10084

cip-gitlab/ci/pavel/linux-test ltp-timers: 4 runs, 4 regressions (v4.4.302-=
cip70-236-g69445bc0d4209)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip70-236-g69445bc0d4209/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip70-236-g69445bc0d4209
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      69445bc0d4209b0634d1f43657fd58f708cadf81

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  a15eb3cdfa3556203167572e15754f1f59ba26bf =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637caba2d28b7c20bf2abcfb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/637caba2d28b7c20bf2=
abcfc
        new failure (last pass: v4.19.265-cip85-rt27) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637cae5e8c57b2db042abd1e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/637cae5e8c57b2db042=
abd1f
        failing since 6 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f6,=
 first fail: v4.19.265-cip85-rt27) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637cb26e7a39df50362abcfd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/637cb26e7a39df50362=
abcfe
        new failure (last pass: v4.19.265-cip85-rt27) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637cab412a34f666fe2abd34

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/637cab412a34f666fe2=
abd35
        new failure (last pass: v4.19.265-cip85-rt27) =

 =20

