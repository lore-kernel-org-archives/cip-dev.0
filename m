Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD45C61D85
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 23:49:01 +0000 (UTC)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
 by mx.groups.io with SMTP id smtpd.web10.120104.1700783333932090657
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Nov 2023 15:48:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=xwTmYzs2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.49, mailfrom: bot@kernelci.org)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6d7eca548ccso778987a34.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Nov 2023 15:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700783332; x=1701388132; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vYYTxLV/gcboczbi9PuW3sG7h4OOA3AtXaGu5v5GYWg=;
        b=xwTmYzs2RcObK22oTi1AZtHuJRUdWeODTFipD7jb4dmTfK0pifKoZHWPkQCb5NbCEJ
         gMbZ/ZUcR1MS4WThugEQhM2VnZ3VIr0JSTe94fm+9rfqK9db0Kp7G3/faNwLLFsY1OHL
         d81pRrtoVJYo+00I6/QPlGgu1pNmI7j5+cCzFy+9z2roRJu4XeH796EWcMVFjM3POl5H
         WPTkmHLRadicCuTGfqTrGoDwzEJ1vvMT6vdTCf0sVH87i/cZIGTLYeP0igCV6dJgv65c
         9P+GQQisT8lKwyAjgZvkWPYs+N2QJLel09eEVCdOG9ySKI53seYlBuS1TzEaFwITCEf0
         2ZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700783332; x=1701388132;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYYTxLV/gcboczbi9PuW3sG7h4OOA3AtXaGu5v5GYWg=;
        b=nQh6ctlm0GkFx5RF6jrGwEfqoxEXviTJyZco1NUYHAkQETGdZrQdInnSuUuvVAmtLI
         fHI8pXutOhMWP6s26dsoXQTp0r1f2gtDvnVn3xkO+cPzqc9/Ayr5Kj2Y+j/yDu2mPaj+
         7+0PhXDJ1Al4hwfWmS/GDabPIX0aydtkhDovZM84MCA+O7NGt7UkG6zeSkL/0q6idSar
         JwMx7oCxmD4yKozXHkqT0gFnCifkTW2KLc1EFrh8BzysnUECYtRok6OZS74zPJMh0rQl
         hp6TERAisQE1xgFCjkhnL9vT/N0zhGrDoq5yf/5dvVzPDG0OaYIsBc6BtQqylq/T6l6Y
         4qjA==
X-Gm-Message-State: AOJu0YzDNYHVHAZEOFGFRH8+he9q6HGam3ZzLWmzwW/rTnJvsXI2iz4H
	NIJU2twlLMMwVqMX6HdYfszfn3zRVkQ7E4/QPDc=
X-Google-Smtp-Source: AGHT+IFDPighMfHnpUb/JOWg787TBQoLDqSEhmYwnpZIIzOhWzSf0pWCfCXEr5tiuqwhpnYwAZNeZQ==
X-Received: by 2002:a9d:5e04:0:b0:6bc:de95:a639 with SMTP id d4-20020a9d5e04000000b006bcde95a639mr970181oti.16.1700783332327;
        Thu, 23 Nov 2023 15:48:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r13-20020a63fc4d000000b005bd980cca56sm1922630pgk.29.2023.11.23.15.48.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 15:48:51 -0800 (PST)
Message-ID: <655fe4e3.630a0220.cc78e.50de@mx.google.com>
Date: Thu, 23 Nov 2023 15:48:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.201-rt98-828-g27523c64bc5dd
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 8 runs,
 6 regressions (v5.10.201-rt98-828-g27523c64bc5dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Nov 2023 23:49:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13691

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 8 runs, 6 regressions (v5.=
10.201-rt98-828-g27523c64bc5dd)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig  | 1          =

beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig  | 1          =

beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-rt98-828-g27523c64bc5dd/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-rt98-828-g27523c64bc5dd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      27523c64bc5dd6f1af1b227b80017fea69e616b6 =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig  | 1          =


  Details:     https://kernelci.org/test/plan/id/655fdeeae9c09f3c097e4a74

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/655fdeeae9c09=
f3c097e4a75
        failing since 431 days (last pass: v4.4-st20-229-gb433f12afe250, fi=
rst fail: v4.4-st20-231-g7349cef09ddd2) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig  | 1          =


  Details:     https://kernelci.org/test/plan/id/655fe3c1645c89a78f7e4a6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/655fe3c1645c8=
9a78f7e4a6e
        failing since 431 days (last pass: v4.4-st20-229-gb433f12afe250, fi=
rst fail: v4.4-st20-231-g7349cef09ddd2) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/655fdfb13216ab12e87e4ae9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/655fdfb13216a=
b12e87e4aea
        failing since 3 days (last pass: v4.4-st20-231-g7349cef09ddd2, firs=
t fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/655fdd8e621ba265787e4a7f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-cip/baseline-=
cip-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-cip/baseline-=
cip-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/655fdd8e621ba=
265787e4a80
        failing since 443 days (last pass: v5.10.131-cip13-84-g5fcbe4a63ab4=
d, first fail: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/655fdd8c621ba265787e4a75

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-cip/baseline-=
cip-nfs-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-cip/baseline-=
cip-nfs-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/655fdd8c621ba=
265787e4a76
        failing since 3 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543e,=
 first fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/655fdd8d621ba265787e4a79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-cip/baseline-=
cip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-cip/baseline-=
cip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/655fdd8d621ba=
265787e4a7a
        failing since 3 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543e,=
 first fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =20

