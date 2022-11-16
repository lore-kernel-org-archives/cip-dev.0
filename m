Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8028C43219
	for <webhook@archiver.kernel.org>; Wed, 16 Nov 2022 04:16:21 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web08.2907.1668572173544756128
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 15 Nov 2022 20:16:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=IKld+6+C;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso1217600pjc.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 15 Nov 2022 20:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Kkhq1ZR5oyWRLOGMrfQFRGv4BKohJWcnu7EwgWu/FxE=;
        b=IKld+6+CXDS2zL5q0WJFMrDoTRKM+52yAP1z7I5UnZorFCX7zQsdc1ekrJ6E3YebP1
         wgq2v16qPRFGdv+Z6cqkydjtqbmvHXH/mqu37OUNeDcMJeie89tDrwWO5hp6p7tI/GNF
         H+BjZIoZlyLMaaHNACvYNmZh9grChbmOf5pH9Sivln8ZZ8JZgVoMFB1lUN7EPub8LdOy
         ctynwaReajWRothARG3X16ayi/2g8N67iZczr/NG8dB8DLiAKWO/IzLZTBZ7QS5UaaSw
         jqoz8k3EjurqrBItfM5RKyHjCXhxPMh3epN8rN8mJgU8V8+ttCGJjPiMxNXn2i3BzLnn
         3PTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kkhq1ZR5oyWRLOGMrfQFRGv4BKohJWcnu7EwgWu/FxE=;
        b=0fSM4cEjVp8vDVnGne4N8yX4mNcvbl86uGSpOyI8py/RFbnsdwczlPVI0IgvvPzjj/
         7cNsjj6HwW+KEI1zYXHaETNIM6J61YSrb0BxCW3jHIybs9gztDt/pwoQNdecMgAVr/28
         ftrRm2NZYSt032tHE1dE3jod4tNReKHXsXmeeqlIhlmFRhYzeetk9445ZpiEj9u/Xo3E
         ha4dk+/DFvSv6jRW7z0NVlyeg8TkNTPzMH+N5rzkhJppF91F0GdSkxZ4RHC+hDYvnoQD
         ze0KubijVDz0eu5VhxAJ4C+odRgA7B612uZ2XdCQ7GdrVVyRWwvRcDR7GsQIDCh/ScF+
         dJuQ==
X-Gm-Message-State: ANoB5pmdIYJHIdVIaG5YE7kg/TfhlK8RamMTwvrUU4F5S2EBRVQhYtZd
	D8erUc82jV5qczyJE1KCOHTF1cbJtKLYlPG70CY=
X-Google-Smtp-Source: AA0mqf45XO3x225isobNO/vGf5/whA15e+43A9UPkrZeEt7sDBsvDxYxgXnY9MSadgLPTDIamQRzJw==
X-Received: by 2002:a17:90a:5aa6:b0:213:880:e931 with SMTP id n35-20020a17090a5aa600b002130880e931mr1705705pji.217.1668572172652;
        Tue, 15 Nov 2022 20:16:12 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a11-20020aa7970b000000b00560cdb3784bsm9681314pfg.60.2022.11.15.20.16.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 20:16:12 -0800 (PST)
Message-ID: <6374640c.a70a0220.42aa7.f32b@mx.google.com>
Date: Tue, 15 Nov 2022 20:16:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.265-cip85-rt27
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 4 runs,
 8 regressions (v4.19.265-cip85-rt27)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Nov 2022 04:16:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10043

cip-gitlab/ci/pavel/linux-test ltp-timers: 4 runs, 8 regressions (v4.19.265=
-cip85-rt27)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.265-cip85-rt27/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.265-cip85-rt27
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7b2b3defe99e6a33cd295c5120b96288f81f8bd7

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
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63745a1f13033e1db42abd0a

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63745a1f130=
33e1db42abd0f
        failing since 12 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b=
, first fail: v5.10.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63745a1f130=
33e1db42abd0f
        failing since 12 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b=
, first fail: v5.10.147-cip18-12-gcb2b164780be) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63745fdd7f7be37dfc2abd25

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63745fdd7f7=
be37dfc2abd2a
        failing since 12 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b=
, first fail: v5.10.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63745fdd7f7=
be37dfc2abd2a
        failing since 12 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b=
, first fail: v5.10.147-cip18-12-gcb2b164780be) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6374626c3996927d942abd12

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-t=
imers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-t=
imers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6374626c399=
6927d942abd1d
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6374626c399=
6927d942abd1d
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/63745a8387a2a899012abd00

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63745a8387a=
2a899012abd05
        failing since 7 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b,=
 first fail: v5.10.147-cip18-15-gef247a3cd0ad) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63745a8387a=
2a899012abd05
        failing since 7 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b,=
 first fail: v5.10.147-cip18-15-gef247a3cd0ad) =

 =20

