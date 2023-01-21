Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563B8C54EAA
	for <webhook@archiver.kernel.org>; Sat, 21 Jan 2023 20:12:58 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web10.5069.1674331970581546303
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 21 Jan 2023 12:12:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=eUbxBDrA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.54, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f54.google.com with SMTP id dw9so8531022pjb.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 21 Jan 2023 12:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rTr4/3vxkqCJ/fSZn8bb1POijE72aENGBoWtGoC8oFE=;
        b=eUbxBDrAklPSpQyWk5YtiAKCgM37Ce9tNM2Alx2gm5dI/JgNgyBT+KSrrS09iE40/q
         xEPKleeU7L9RTUwlryEL6Aq60OqOySPg57hTz/wPinX+546cVkY2QQl71ICLjJqI/NCV
         lJSiVBPikIMhUX0019wJQu1P9E/y7srJ883Y3NyHaJ1F2pvbnMO37jqFi9iE48y5Ahsd
         tQ55OFedpadgy+3DqDseV4ysPm+CRRshXx942eNDRGG9mmsvo2bAqkaBoC2WyRCuQbrb
         ZWD9NknAbZf8WMTQyjVi02wgid+noXnR559Raw6yrvy5EmMFc9JbjWUXBcLOwURTlr3E
         WWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rTr4/3vxkqCJ/fSZn8bb1POijE72aENGBoWtGoC8oFE=;
        b=O1jQbO7T7ujSq/+pdcKHQh7dT7KHp/oFoua02XsKMb6sMnTkGel0GNRNkk0tL5tJFG
         08XdDW0b6qhFNWBzffCZ+VbCHxQDT68ECyU8BC4aRHgL3utXxRL5ZgefEWWEPIkpKNAh
         ft2cC/+6w8+V8eZ5+g7Rbg/Qv7jQSc7ZSAd+a/xnseT/fzjap4Cn2ZUq8ZUPt818uata
         02p1008Y8Q1HylSwXDaQm/NOrxmSwTz4zSKqywj6asYW65FSbY41a+3C3gWLP1zJsJm/
         F0NabbqN6H7ncn9uDgnGTEocP5IM+013CKgRp71t1zeXuHFLe0tlh+SHmvuPSXrqAdMB
         yhrg==
X-Gm-Message-State: AFqh2kqa0vkyDNaF/edeMaDcRO0eN/tUtTCHNtwtbp7vYeDjvpJxOhTg
	47AbbuTdYZqwsYX1xLowhvTneb0GGKOG0S9n8Gk=
X-Google-Smtp-Source: AMrXdXtpldQde8QbmavXU5lw8Zx3dJIk3wT+Zylj1/oXMoJkDLg55S6Ilan27/hK21egUIC6RT7lFA==
X-Received: by 2002:a17:90b:4f8f:b0:22b:7882:8a61 with SMTP id qe15-20020a17090b4f8f00b0022b78828a61mr7622786pjb.21.1674331969774;
        Sat, 21 Jan 2023 12:12:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n5-20020a634005000000b004a737a6e62fsm24237024pga.14.2023.01.21.12.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 12:12:49 -0800 (PST)
Message-ID: <63cc4741.630a0220.2fefe.5a51@mx.google.com>
Date: Sat, 21 Jan 2023 12:12:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.270-cip89
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip ltp-timers: 7 runs,
 6 regressions (v4.19.270-cip89)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 21 Jan 2023 20:12:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10458

cip/linux-4.19.y-cip ltp-timers: 7 runs, 6 regressions (v4.19.270-cip89)

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

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.270-cip89/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.270-cip89
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8cbf38242b91f4f98d6fc776bae10cc74740eff2

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  cf59c1fb5f7181453b16171d75654ee9a1216dde =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63cc3a3aa6661392a1915eba

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.270=
-cip89/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.270=
-cip89/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63cc3a3aa66=
61392a1915ebf
        failing since 56 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63cc3a3aa66=
61392a1915ebf
        failing since 56 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63cc43ed48f9214d58915ed0

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.270=
-cip89/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.270=
-cip89/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63cc43ed48f=
9214d58915ed5
        failing since 56 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63cc43ed48f=
9214d58915ed5
        failing since 56 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/63cc3cdfe8daa98535915f3b

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.270=
-cip89/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.270=
-cip89/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63cc3cdfe8d=
aa98535915f40
        failing since 56 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86)

    2023-01-21T19:28:11.803578     =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63cc3cdfe8d=
aa98535915f40
        failing since 56 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86)

    2023-01-21T19:28:11.803578     =

 =20

