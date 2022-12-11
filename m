Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364C6C4332F
	for <webhook@archiver.kernel.org>; Sun, 11 Dec 2022 20:20:25 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web10.26087.1670790016600353551
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 11 Dec 2022 12:20:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=uRY2EyWv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so10070669pjd.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 11 Dec 2022 12:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Dy9xfQxrfy+6jBP5R3eueMeuhez+vCsnVfoCvb2fMx8=;
        b=uRY2EyWvp3ZWB1nZ7dPFctqZTdATgXVOkKPBPGN65SaDYVLYjWiL5/c0QIONG5ejpx
         Nt7ON+9hqp5iZtbhlWgVYy7zLXdvuJBT6CFvbvO4qHkRJlBfBsqAcOVkPsWSKNmxzYDf
         6RcfuFCcTNaqQxTGp8lixaOo+4bacG23YR9IP7/QEiCYfJJN5XhbiHBdNNpdJ1HYfVax
         NPN80EhBoh8G1lwNjhsyfLjxcoaHAeQtJfFLhS3+VAxr8EtVUw5czwL5lNqPm4sgLGXg
         O8iSMgVH13Nr1NR78wyWXpPWGPjDbBj0QqANmVuhfCO3zD/fRJVtIoebat3wE8QTfNTi
         oJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dy9xfQxrfy+6jBP5R3eueMeuhez+vCsnVfoCvb2fMx8=;
        b=EGz/QRuGRYEV6d9GhOQ1UjULi0hGDz25m7NoBe0OHmJrG8fBakIeEbidmIgFnWAvqq
         cLPXaq1YIowWE2iIk2RM2fdZcV4wnORY3DJxY9DOSaaigQZB4lYiqtP2t605fW/9e0Ov
         7tRk4JAZapFIiGtDmzTXEdcv9E7KDU7X6SjFRLN0ZCHYJ6ryYdP5QyLvPlvmiF3w5b61
         LpGoIRW9To9CIpUwATYTmsyVEGvH6hz29RZu2S5xU/sko55BOxA41whenDT9gbkpNzNp
         0TRUiFmF1o/rnfQxWlf/z8xU/C9NCZt+gNZ6+reGCV91QhIT+cVURWNLIqXP/T6CJArQ
         mQkA==
X-Gm-Message-State: ANoB5pn8D/d6C1Y98q5/g36YxN3GTBl2QPPGWf/UJBjsVh4/hSwdHSIf
	Sdzlxe0wtU5JJlBEbUjDJkzMKL5+koORB5nSDCI=
X-Google-Smtp-Source: AA0mqf6NnpFZpmQeG/w7XKZ/rYV4CFfSZONN+2eqXyc1nIkUGqMvGwCUqp98z19OdGv0p5NeImQopw==
X-Received: by 2002:a17:902:b406:b0:189:e711:173 with SMTP id x6-20020a170902b40600b00189e7110173mr13875484plr.33.1670790015135;
        Sun, 11 Dec 2022 12:20:15 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e14-20020a17090301ce00b00188c9c11559sm4728484plh.1.2022.12.11.12.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 12:20:14 -0800 (PST)
Message-ID: <63963b7e.170a0220.81273.8080@mx.google.com>
Date: Sun, 11 Dec 2022 12:20:14 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.158-cip22-rt9
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip-rt kselftest-filesystems: 4 runs,
 1 regressions (v5.10.158-cip22-rt9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 11 Dec 2022 20:20:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10205

cip/linux-5.10.y-cip-rt kselftest-filesystems: 4 runs, 1 regressions (v5.10=
.158-cip22-rt9)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.158-cip22-rt9/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.158-cip22-rt9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2c52868ae1cbccd8bfb24f6b41a5fd024c1ca7e8 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/63962759587e78f15a2abd23

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/arm64/defconfig/gcc-10/lab-baylibre/kselftest-filesystems-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/arm64/defconfig/gcc-10/lab-baylibre/kselftest-filesystems-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221202.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63962759=
587e78f15a2abd24
        failing since 70 days (last pass: v5.10.109-cip5-rt4, first fail: v=
5.10.145-cip17-rt7) =

 =20

