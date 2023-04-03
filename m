Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C07BC77B62
	for <webhook@archiver.kernel.org>; Mon,  3 Apr 2023 13:11:05 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web11.69757.1680527457210739778
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 03 Apr 2023 06:10:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=wxFNKUBj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso32520717pjb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 03 Apr 2023 06:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680527456;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XHib0HFdtVtiM1Opg/cnK+BCgVMW27WNdDEsqZ8stSk=;
        b=wxFNKUBjo+mN3691kI3HkgPVoSAN2XSUxWqcaHOi0ja/Wlg/oRz9UfYVkBlX7CG8mg
         YqQ8SkmY3ovSCjSE7ddPmQ7+GL0ZOE0WBlLmiNCEABw78sOBIvTORFuTN5Kkfchjnr8/
         yOPudHYD1+1xG/JzxSI1/USut6Z/chHPz9BDkQVTvLE2IZUgj5EgARQJaEtsFC5wtAeJ
         derav77DvTc+qlBfH0lh/urLwV7FGBfCJx0AYmehmg2oyI5czWgAXrkB9lyYBVrTcPbf
         zID9a0azVK+fF4PtaxRp/IH9s1QsC/bz/AFEJJhjhoJLW/HxjJaN2cHWgQD/JCaQzo0q
         Qiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680527456;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XHib0HFdtVtiM1Opg/cnK+BCgVMW27WNdDEsqZ8stSk=;
        b=bt9QjYxegxuWIFhAH/aW3hWq02tcSUhRJKbflQ1LGzJHGbHkW8NlqerqpAN/+IWQKM
         tJ5TOpeC6viKOT6kK31kyLa5k4jDKs+8Is0ldWQDlN7usQXkrmVeYBY+scQXFIkCVtp+
         Gq19wLJSGO6PEeHW8ikmx0StkGUBJ8VpeWEfyZRdeiOxMB6QRYwT59I504URBiMcBdZn
         ny3CxbftzM8zpcsZz/pK/uA+HGHle65351m6/qtJq6FpiiU1AxDZ64LU3GLn1NXxQFRK
         y/nOVGEDFjyWNQaG+3Ty2RhxUtKz++adMKL6TeM3eR/ZSDb/c7uj3zMo0zWrLVQH1tjh
         pLZQ==
X-Gm-Message-State: AAQBX9dDrEyBG1oXeHNq8pQddpgSFoGChJ5OtsWEF2WAuqR6YJSD+y7e
	sJhvrYEYa84YGiPl5xlLsueu6LEX4f1L6mZMqyE=
X-Google-Smtp-Source: AKy350aMitfOqwWRKEi6L3Yca0/TQoM7/XK7VKc4ulxlG14nTripPbypBTp5Qn+rKIUNfbFUYHIoKw==
X-Received: by 2002:a17:903:283:b0:19f:e9e7:4cb with SMTP id j3-20020a170903028300b0019fe9e704cbmr44380111plr.45.1680527456429;
        Mon, 03 Apr 2023 06:10:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v8-20020a170902e8c800b001a1adbe215asm6608370plg.142.2023.04.03.06.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 06:10:56 -0700 (PDT)
Message-ID: <642ad060.170a0220.3abfd.bd40@mx.google.com>
Date: Mon, 03 Apr 2023 06:10:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-1097-g52d843097a439
Subject: cip/linux-4.4.y-st-rc kselftest-futex: 4 runs,
 1 regressions (v4.4-st20-1097-g52d843097a439)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Apr 2023 13:11:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11156

cip/linux-4.4.y-st-rc kselftest-futex: 4 runs, 1 regressions (v4.4-st20-109=
7-g52d843097a439)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1097-g52d843097a439/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1097-g52d843097a439
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      52d843097a439b3e38b2dde18a7c7fc256a94f4e =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642ac30feea57ecf3462f795

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1097-g52d843097a439/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/kselftest-futex-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1097-g52d843097a439/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/kselftest-futex-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230324.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/642ac30feea57e=
cf3462f796
        failing since 75 days (last pass: v4.4-st20-799-g1229c813bcd9, firs=
t fail: v4.4-st20-821-g39bdf0444b23) =

 =20

