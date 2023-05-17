Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A254C7EE2A
	for <webhook@archiver.kernel.org>; Wed, 17 May 2023 15:08:40 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web11.52784.1684336116732253417
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 17 May 2023 08:08:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=17GDJZjJ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6439bbc93b6so653529b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 17 May 2023 08:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684336115; x=1686928115;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DqpcAul/lFoT09vpqkh0vsXRCdK0RKZoXj1CA/beWGw=;
        b=17GDJZjJ0XzSpUpi/LQZVVxyNQM3tCEnHxTRRVHTjrpJQL+hncVNQyau0/ibqOtydY
         aekijJfmImaXKc456m2O1Ra5EsUUGHLCXLXQqUrSJ/uTNuogdmZcVDMQw1xeGN2//EPx
         j4VQm962vZiETemE/ipamJo4JIjkb2ZyCnJrhiUqig4rrsXwHVG/hqclQ9G6KhvLIsP1
         p252wJx0BbtQ5SGrM6f6lzcB6wSNho3IZ2+HjM/z37raRpPpWFXNKYteZVKl196Grd14
         2EI2LF+S3iZ9a7g+GYEUtjKXTdRJJSc39aiSlukqCKJlIEPVFqf6jonPCFOZ/6k6qjL+
         RNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684336115; x=1686928115;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DqpcAul/lFoT09vpqkh0vsXRCdK0RKZoXj1CA/beWGw=;
        b=iNJaQv1QUIOp9HkTgSbLjxH1S18xmwTf+kjfx8M6J9cz/PqNKrgL+eoCGsUzFRA3K6
         kmS1EsDMymACkXAPkeD803vU5MY32zmDYuX2ewQ+AsaBHhIktQZF9ujXz2sHYEpOwEZR
         zV/abkFwOfkNRxV/Npw2zw0KnVpArnhDN0Gsc2MgNfW59HkuH5tby13Wat5palG0tsck
         vVd3JhqsN0I8Kb1BhmtYSUNQo91Dr/DjPR6w1uAS4IEudL3FjRFZySMkzn8E8E95r4jn
         pVXrbq6KFEln4L5xFwr9WOhfQlMTvNTTqGLIl8t8jEBuslbQRejw2nX1NqtzT0ZGrQd0
         qo1g==
X-Gm-Message-State: AC+VfDwflsTSHWcRYrN496j8/HToTVArHcj4ZYoGc8pYLNdQaDkeBk3w
	489mSB3n++/LdbPEDJwL/uYkP9592bqz25dEyKPCUg==
X-Google-Smtp-Source: ACHHUZ5Zu9wCxBvau52R1N4rBZe4qSqmZBlVARP41Usol9K0UK1JiehmHpgiacITAlu3bMF+M9gp7g==
X-Received: by 2002:a05:6a20:a691:b0:106:5915:e88d with SMTP id ba17-20020a056a20a69100b001065915e88dmr10443262pzb.41.1684336115373;
        Wed, 17 May 2023 08:08:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c8-20020a170902b68800b001aaecc15d66sm12069214pls.289.2023.05.17.08.08.34
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 08:08:34 -0700 (PDT)
Message-ID: <6464edf2.170a0220.8481d.6945@mx.google.com>
Date: Wed, 17 May 2023 08:08:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.179-cip32-384-g291adc46abef0
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 12 runs,
 2 regressions (v5.10.179-cip32-384-g291adc46abef0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 May 2023 15:08:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11503

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 12 runs, 2 regressions =
(v5.10.179-cip32-384-g291adc46abef0)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_riscv64      | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =

qemu_smp8_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.179-cip32-384-g291adc46abef0/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.179-cip32-384-g291adc46abef0
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      291adc46abef012487ba16bb07999af85de2d34d

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_riscv64      | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/6464dcd3f163c365a92e8655

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/riscv/defconfig/gcc-10/lab-=
collabora/ltp-ipc-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/riscv/defconfig/gcc-10/lab-=
collabora/ltp-ipc-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30512.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6464dcd3f163c365a92e86=
56
        new failure (last pass: v5.10.177-cip31-122-gfb6ca504156b4) =

 =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/6464dedf510852009f2e85ea

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/riscv/defconfig/gcc-10/lab-=
broonie/ltp-ipc-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/riscv/defconfig/gcc-10/lab-=
broonie/ltp-ipc-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30512.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6464dedf510852009f2e85=
eb
        new failure (last pass: v5.10.177-cip31-122-gfb6ca504156b4) =

 =20

