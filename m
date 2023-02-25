Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F156DC7EE23
	for <webhook@archiver.kernel.org>; Sat, 25 Feb 2023 19:56:09 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web11.51925.1677354960436383163
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 25 Feb 2023 11:56:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=7C/YiQEW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id k21-20020a17090aaa1500b002376652e160so2583903pjq.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 25 Feb 2023 11:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DhmUcorWXQ3JryGexKlFAbvekLFsmgFHMLDBWdifM+w=;
        b=7C/YiQEWLyt1AZfonjxpaQOlI5fhdAz9Uis86sprbNWFZFogW+CQHhFgvCpr4vK7DK
         XfTIhEJebx/AtacPYykwR/wKC3aU2BFDVk18lQTtahomDr22ORh2SMNdC7CFRjfEJwRM
         JFPZN9S6d/zKywSck5Ujj9ek+GfjSDJUOWuZGExFkNeZfTgYCfqfiT5v+sFQrGE/JnVK
         tAr04yHIyG6HNAgQ+jnjFkdc89nCKMpQBX8wJPNCOP2ygoODSYMDk11zq2SFBEyBjmxr
         NiXaPkM1oy/UxNI/NATTqXReF/ZOZM15bCiC2DxtK+f5cpkvcdk/6uWjENF46CZm5fH4
         gC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DhmUcorWXQ3JryGexKlFAbvekLFsmgFHMLDBWdifM+w=;
        b=N3kKKe25AHdPg1tSypLijDEYcXuxJJQRxpnzIN1uSndHUTSL5yEsdHC0C7hA4cgs03
         HtUsc2h9OOPhVKfB1qCk5NWWfyN9DAcHVbtI+SjNYslm3ynrGANs0GTJ9Snn5NoPR21z
         WLsOquUCDK8UID3/XgVc3CjPJ5VyVppFTEOxtd5ILQzsH5nEsiM+2v30XKh3t57BEfx9
         FBZ0SKHkKngx0m8nUzCMzt6rO2lKp4YGaeD6iNIrvNjAW1E0RFOqwSAcOhM2c01fVDjK
         1SiRXOT8oVK6eWoR0CfcJb/uvwrRttwbbK0RVyayvu3TQEWaUt+8dwerGY2FiyPBBMup
         XD7A==
X-Gm-Message-State: AO0yUKVB6vVnfQnlR+rXvQzZ55MCRQUfm6jHNMeZk7LYzUrschHRF/db
	fDZv9VWOdjflvko0rJODRYSQPm1M9A3PJjDDrIg=
X-Google-Smtp-Source: AK7set9ujKN4Q/p/ZNi5uPKp8EHAITh2g2xjtOAEJuYm8LNeHHYCdDi6ua27+GEX8tqtf7jjgdOMWQ==
X-Received: by 2002:a05:6a20:ba4:b0:cb:c276:58b6 with SMTP id i36-20020a056a200ba400b000cbc27658b6mr11617844pzh.22.1677354959628;
        Sat, 25 Feb 2023 11:55:59 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 19-20020a630c53000000b0050310e4bcabsm1358203pgm.90.2023.02.25.11.55.59
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 11:55:59 -0800 (PST)
Message-ID: <63fa67cf.630a0220.8752e.1f24@mx.google.com>
Date: Sat, 25 Feb 2023 11:55:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.168-cip27-86-g19cf8cd2dd993
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 12 runs,
 10 regressions (v5.10.168-cip27-86-g19cf8cd2dd993)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 25 Feb 2023 19:56:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10852

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 12 runs, 10 regressi=
ons (v5.10.168-cip27-86-g19cf8cd2dd993)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.168-cip27-86-g19cf8cd2dd993/plan/ltp-time=
rs/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.168-cip27-86-g19cf8cd2dd993
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      19cf8cd2dd99376e3a8b44aa56fbc1e1f7bfb770

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  86f0584539eb1567f009f3e38be6940830649b92 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63fa5739a354b099a08c8631

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63fa5739a35=
4b099a08c8635
        failing since 122 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63fa5739a35=
4b099a08c8635
        failing since 122 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63fa566aa5c8f2086e8c867b

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63fa566aa5c=
8f2086e8c8680
        failing since 122 days (last pass: v5.10.147-cip18-56-g87bd4289362b=
e, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63fa566aa5c=
8f2086e8c8680
        failing since 122 days (last pass: v5.10.147-cip18-56-g87bd4289362b=
e, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63fa585e303158e61c8c863c

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63fa585e303=
158e61c8c8641
        failing since 121 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63fa585e303=
158e61c8c8641
        failing since 121 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63fa65f83d9b56e2de8c865c

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63fa65f83d9=
b56e2de8c8661
        failing since 3 days (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2=
, first fail: v5.10.167-cip26-2-g1e87e7748b91) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63fa65f83d9=
b56e2de8c8661
        failing since 3 days (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2=
, first fail: v5.10.167-cip26-2-g1e87e7748b91) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 2          =


  Details:     https://kernelci.org/test/plan/id/63fa5bc7b7823ea3958c863e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/arm64/defconfig/gcc-10/lab-b=
roonie/ltp-timers-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/arm64/defconfig/gcc-10/lab-b=
roonie/ltp-timers-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63fa5bc7b78=
23ea3958c8643
        failing since 105 days (last pass: v5.10.131-cip13-493-ge1293082790=
43, first fail: v5.10.153-cip19-122-g149fbc7cd21d) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63fa5bc7b78=
23ea3958c8643
        failing since 105 days (last pass: v5.10.131-cip13-493-ge1293082790=
43, first fail: v5.10.153-cip19-122-g149fbc7cd21d) =

 =20

