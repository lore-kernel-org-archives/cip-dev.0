Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A679C64ED8
	for <webhook@archiver.kernel.org>; Sat, 25 Feb 2023 02:01:34 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web11.36450.1677290485224800840
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Feb 2023 18:01:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=7CxZQKHj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id u10so859492pjc.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Feb 2023 18:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TEYfKEwNuAjagoLrOY1/WN6EC1JBB1NgrbRHE1cqTQI=;
        b=7CxZQKHjJZSWOWFVMT7y9pTq+O92F+BjR4al7LYmCJIAI99RZL22tbIcIlqsUalxjW
         Xa1J8kGCiy2SJ/1nNdeHaAuQEpvOmY65QE/tfdp9lsZ4agLzYdv/rU0eZ3C6Ad05PKR2
         t0No6MLNRnjqgbaHTuoDPEFw5VX7HK/vWzckdnHBSLmcSzfatT0loFFe147+W1xskFq8
         m7E0LXoru71Y9+OfSTOPdB8QvpiIYTq6hqPEAlAznH/AwJ4Y47mmsYunWz4kXtE3pI+6
         ev0pkPu5NTuI5p8SWspbA33hvDDHoJKhuARP1l+a73qmdkzebnxLeJxu2t2VgAiGDDir
         q2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TEYfKEwNuAjagoLrOY1/WN6EC1JBB1NgrbRHE1cqTQI=;
        b=lWQ03BJfdHFJ0Q8RTwB+oZw3uP8RwTgjf7LCFA3GAlcsr0H+6o34Z7rOClUI4t6KzM
         61CCv+miYwPIEKJjERM56GqxxB1CXIbIkTTS/Wv1UlJZjPe57zTRfPg/PFihHvBvcSW6
         CwduoLvk4uNXLWuK874t0iyJcbPJ72Pvo1NPV9LW1C9Ze463g5Hl2ainTDhQz5CohDKv
         b9Nv1s0yBV1IgYAiDq4BBWIY8huBxVrvW9mmHj5rR/7t+r330Y+dAilbEuVJJAk+aGbg
         NbtgU46Ta2Ja48KAgRp4AuqxUMNXo4I7gJ7li0xoTc7DiUduZd+nt4bmzn4Y4JqlVIrU
         hFWw==
X-Gm-Message-State: AO0yUKW6gwZlTi47/LUE8au7gNfzjice4vxRvn7X8S/lk+gR3ZadB+zj
	vtg2zDOFhkxTFXiwloK7vbnGVAy0ap4CN8vzZnieIA==
X-Google-Smtp-Source: AK7set+8JJsiNueYgT0oSwiYUpY5DKhFusTP9ni1K5whlGIE3XduNqo2qy/5N3VIa+GEvuDZnML1wQ==
X-Received: by 2002:a17:902:6b83:b0:19c:df6e:6ada with SMTP id p3-20020a1709026b8300b0019cdf6e6adamr1886964plk.25.1677290484423;
        Fri, 24 Feb 2023 18:01:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v8-20020a170902b7c800b001948ff5cc32sm130065plz.215.2023.02.24.18.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 18:01:24 -0800 (PST)
Message-ID: <63f96bf4.170a0220.a2556.05cf@mx.google.com>
Date: Fri, 24 Feb 2023 18:01:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.273-cip92
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip ltp-timers: 5 runs,
 6 regressions (v4.19.273-cip92)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 25 Feb 2023 02:01:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10839

cip/linux-4.19.y-cip ltp-timers: 5 runs, 6 regressions (v4.19.273-cip92)

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
l/v4.19.273-cip92/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.273-cip92
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      13b591404faff8a66449dfa80682930f5325b869

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  86f0584539eb1567f009f3e38be6940830649b92 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63f96123474d987e818c8654

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.273=
-cip92/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.273=
-cip92/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f96123474=
d987e818c8659
        failing since 90 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f96123474=
d987e818c8659
        failing since 90 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63f961dc7efc90fb948c862f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.273=
-cip92/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.273=
-cip92/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f961dc7ef=
c90fb948c8634
        failing since 90 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f961dc7ef=
c90fb948c8634
        failing since 90 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/63f962b22d79e7c2838c864e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.273=
-cip92/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.273=
-cip92/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f962b22d7=
9e7c2838c8653
        failing since 90 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f962b22d7=
9e7c2838c8653
        failing since 90 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =

 =20

