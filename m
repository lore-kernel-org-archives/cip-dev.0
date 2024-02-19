Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86824C5475B
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 06:41:18 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web10.36058.1708324873974274742
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 18 Feb 2024 22:41:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=2rikZ/KU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso2252082a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 18 Feb 2024 22:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708324873; x=1708929673; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Od/fvLahoG4LElKGPZeUZYefXRQ4PnaH4L2f9PRFs40=;
        b=2rikZ/KUSKEza6Bow3nWzHMUzLCHogrncYKYGlKWv9s4+eIVGRt6XAoeiVZ/pJf0bF
         dDAc3bkYkZDQoCC7Kj8B3S3vhzSQdA38MASlpWXOz5UEkcW/MvZqsglojM2ZVRXqSQgw
         vfWk/Inbhw+YnaAx8jJ8Kc8xdcL+/fT3pyDPx0oniSlFe3VEoXGfU3fxqXoOSc5ryp81
         NyCbqaqeI3YEtrWs/qyplI7RW26KoYXqP9l+KwGhXl8ptNKkZB/0OmFzsdgOnolPROTl
         yl0ipd5Ak5blTTv3FIS3Q8X2/vUrPUG8hNd+Z0tMTXx6C4PQmQOs75aEPcDkkQR7tp6X
         dkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708324873; x=1708929673;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Od/fvLahoG4LElKGPZeUZYefXRQ4PnaH4L2f9PRFs40=;
        b=hTnPCEyYponykTuwASAeRJKE+mwLTSAYrme1KFvoV8hqZes+ccLxGNZaywlDv9TVBp
         3/JLDQ6KsSbFUcrde3S23GF8QW715oHkASSmuaSDp1n6r1pnhWz1S/A6QJDx7cek+AJ6
         SYRkzk4/J7m+/xfdZ5adaf5bbOWFOUP+CG1Ukiegmzc/fW74HoM1RRi5OIG1WLzwAyAr
         gni9dwHo8E8uUHod52ejflrUOM71hFY3ROSr6LzgRn8Rg6XWFMJ8xXGOkHFpL8FJeFaT
         jtBEODja4vDyaGmbq/ui8CCb1UwPwoCP42CgEJYevxSyhU+X/JfAitezKF7QLIf9JnvY
         +ATQ==
X-Gm-Message-State: AOJu0YyqYs7Fg02o+ZdK/JHoMgNSoos5QYqMafoqeNUtEiZvyk4Mk9Oc
	xMC9z1TgGez2YHWmgn4ro2hea0eF+nweQmecVVU1t75WH19TQT0cbMmK99OznOxRluil0uCNz7z
	A
X-Google-Smtp-Source: AGHT+IHn9/ktD/HdXZ9EuOn/DRIh93xnIO6mEjoqb5in1sQly/5ivhB6jM2vzcgtunbkCRDpTBj82A==
X-Received: by 2002:a05:6a21:3a86:b0:19a:4935:458 with SMTP id zv6-20020a056a213a8600b0019a49350458mr11474347pzb.35.1708324873103;
        Sun, 18 Feb 2024 22:41:13 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090aec8300b002904cba0ffbsm4339978pjy.32.2024.02.18.22.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 22:41:11 -0800 (PST)
Message-ID: <65d2f807.170a0220.7fc21.d195@mx.google.com>
Date: Sun, 18 Feb 2024 22:41:11 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.306-cip107
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip ltp-timers: 11 runs,
 2 regressions (v4.19.306-cip107)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Feb 2024 06:41:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15030

cip/linux-4.19.y-cip ltp-timers: 11 runs, 2 regressions (v4.19.306-cip107)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =

rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.306-cip107/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.306-cip107
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      800dfc28d1a90b195d50f75fa7711d00cc1825bf

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65d2ef1087b7105987637013

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.306=
-cip107/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/ltp-timers-a=
sus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.306=
-cip107/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/ltp-timers-a=
sus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65d2ef1087b71059876=
37014
        new failure (last pass: v4.19.304-cip106-2-g5723c66be3b0) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65d2f29699121e00eb637022

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.306=
-cip107/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk=
3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.306=
-cip107/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk=
3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65d2f29699121e00eb6=
37023
        new failure (last pass: v4.19.304-cip106-3-gaf120b32b886e) =

 =20

