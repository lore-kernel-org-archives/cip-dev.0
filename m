Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874C0C7EE2D
	for <webhook@archiver.kernel.org>; Wed, 17 May 2023 15:08:40 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.52788.1684336118085505375
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 17 May 2023 08:08:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=S3AK7Znb;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ae4baa77b2so7185755ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 17 May 2023 08:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684336117; x=1686928117;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eCOQx79smi8jg9RXzCHZvEv/lgAFg7JLMyOb1+QHbqA=;
        b=S3AK7ZnbLn6fBQ84r1eDDNL4Yi7W1EEtkCAwfC+SHPxU0q0G4IeEgNlA0yCtONuwXl
         dG8aiUQtUdolE+0E7rc+6o1XuJIFWKB+faq9R0tRthNRVxyWe1lSXCCmu+6Oas3wwQP8
         G2SVMMS+KHhGmeoe3v6lekSunjfdWH8kmKi5aDBXI/yu9afudNNOnq3WvVlb2s1f667u
         M+6/Dq+4kMsUqcH23HZDFJcs4c6CZ6Nmxfy0bOx1wQDGfnj9eab6ipykR6RwKAkYlo9q
         5FFklY4XTgGUrKyys6gfyMU4i+i2TYWn4m4KdrUmNoXrw5pG29l7ws4zqrbxlClvTQ7S
         yurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684336117; x=1686928117;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCOQx79smi8jg9RXzCHZvEv/lgAFg7JLMyOb1+QHbqA=;
        b=GGu5Op27TM+mJx3gyoG7N+EIfaWeUkryHVN2r4pvDjlV9XXlNg1Ih9b+kR3XyhU1Ud
         CTdWnJHoNcwmH5HFI7riUpTVps7ZzgkUBJv9JwDtyjMWAxj7dHJL5k3qkEO5A760ai+Q
         CuOIwb9nUGtFWX+btNAJm7YzpRY8+VfovkhZ6wiju0bYg7FVHz2hdI7Ukp/XH6Uv8qHP
         Wvx6SJk+wwJMZCrGfrJJ0PBtp8+RjhfZF0t/jm8zcRiXLwfJ+UvMIw2jaX6BpXUlWIlC
         ZIW9cf4/9vvI305tSPoYVMaXNUBkLDZRGtKbiLR9+Yivqqm1gtid/ECM7ySH1TYvE2q1
         Z8lA==
X-Gm-Message-State: AC+VfDyLaftfctjsI2dcymofMYj+JK3+vfzo2UJHMFuj7jCXTo8Pu8qe
	gOTd7iF7B467pBYzCPDPSFfkF3Hgt9bbyTRaSHh7Lw==
X-Google-Smtp-Source: ACHHUZ430c7lDvSE9AUhJxJSLrFn37/sQtVnjfHsJxWRlDOLXcIGfAGL2/VTlYVxU4Be0Mvzj8rL6A==
X-Received: by 2002:a17:902:d2c7:b0:1a9:90bc:c3c6 with SMTP id n7-20020a170902d2c700b001a990bcc3c6mr53086972plc.16.1684336117033;
        Wed, 17 May 2023 08:08:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e1-20020a170902b78100b0019a5aa7eab0sm3501531pls.54.2023.05.17.08.08.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 08:08:36 -0700 (PDT)
Message-ID: <6464edf4.170a0220.1447c.7019@mx.google.com>
Date: Wed, 17 May 2023 08:08:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.179-cip32-384-g291adc46abef0
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 7 runs,
 2 regressions (v5.10.179-cip32-384-g291adc46abef0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 May 2023 15:08:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11504

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 7 runs, 2 regression=
s (v5.10.179-cip32-384-g291adc46abef0)

Regressions Summary
-------------------

platform     | arch  | lab           | compiler | defconfig | regressions
-------------+-------+---------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.179-cip32-384-g291adc46abef0/plan/ltp-tim=
ers/

  Test:     ltp-timers
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



platform     | arch  | lab           | compiler | defconfig | regressions
-------------+-------+---------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/6464ddc36dd1474bca2e8732

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/riscv/defconfig/gcc-10/lab-=
collabora/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/riscv/defconfig/gcc-10/lab-=
collabora/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30512.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6464ddc36dd=
1474bca2e873e
        new failure (last pass: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-17T13:59:18.730114  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6464ddc36dd=
1474bca2e873e
        new failure (last pass: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-17T13:59:18.730114  =

   =

 =20

