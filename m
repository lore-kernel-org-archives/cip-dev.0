Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FC6C636CB
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 03:00:23 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web11.128558.1700794816748890465
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Nov 2023 19:00:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=S4u++Zmj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1cf8b6eb13bso8769985ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Nov 2023 19:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700794815; x=1701399615; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sgQuzgDqjccXgq/Pu6xD80zy0D0O0PBVjoI8ZZkTVpI=;
        b=S4u++Zmjt1XDg9hx3aP/67aZQlMOeHKEIIkof1wNe4D6mSqccZQ03IkSGTZVaildWE
         4AF2SBFC+DxsF1e1Gf5yXvmmYxsd/7GFGVu7uHi4isIrjt3CY6g5A0+mCFgEtPNIRo1C
         gJ/zcBgKtrSNf0OgYH2h//IV4rvUcMxajq9qp8JUlrZacKER1IUyLvOblIOaAgZpfbeC
         dNcdajxf6biNyJkkmFo1/z2orb3frRrnwQlPXJvhNWTpXZ260MHclBlxkr/Ly3Px4ue/
         ZPSHtQd9QrvKa5h+Cv8E7b8M6gLfebxo9sLQr4vVA1tAoYyDTMNhZafNil2/HgzTiNWj
         l2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700794815; x=1701399615;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sgQuzgDqjccXgq/Pu6xD80zy0D0O0PBVjoI8ZZkTVpI=;
        b=aULBthigLEZjrfD1NszobJst86EZ+B312GmbuLsniLgjoJhzfKiHvIwlspkWTU9nQq
         oznbV7rEZW7RsoZ30bhZPNHF0MKGQrV3dWqcuM63JMiutrsoODaCM6gCQmY+6dSovzq+
         kk0Ov5Nys/oNM9ExArUfpIjOGtfXFrAatL+fQwnpN/oxW+EjI6lo1u/5I2kaBrvPGDSG
         Gmobmv1YYqi8B5AesOYT4wUC9A62oImnVzo8HNmlJd80zw/Bo81AKj4saHLht2gOm56r
         q+J57DX3ShlNoZidV0y1h11Htwm+6QZYa3iY78ExUf2jEXyRUzUrO2hzX60yLI+uMHni
         DqMA==
X-Gm-Message-State: AOJu0YxduTcQ8dXztyYc2F1J7FYH2KMpBzJ0HW9A+YpXg/SNMJOIK2UR
	H2pK2EPza5Meb1CafxBIKuUNiVtNYGc8zWTM6+w=
X-Google-Smtp-Source: AGHT+IEkuS65m7/O21JhzkcuQRcr2aN4ryd7AuQFT/SNAptNjtIOgXqUjvcnqievVF9D7QZ6V57H4g==
X-Received: by 2002:a17:902:b7c1:b0:1cc:52ca:2e01 with SMTP id v1-20020a170902b7c100b001cc52ca2e01mr1124713plz.16.1700794815214;
        Thu, 23 Nov 2023 19:00:15 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902ff0f00b001bdeb6bdfbasm1404991plj.241.2023.11.23.19.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 19:00:13 -0800 (PST)
Message-ID: <656011bd.170a0220.3a220.3d72@mx.google.com>
Date: Thu, 23 Nov 2023 19:00:13 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.201-cip41-rt17
Subject: cip/linux-5.10.y-cip-rt ltp-timers: 16 runs,
 2 regressions (v5.10.201-cip41-rt17)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 03:00:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13709

cip/linux-5.10.y-cip-rt ltp-timers: 16 runs, 2 regressions (v5.10.201-cip41=
-rt17)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
  | regressions
-------------------------+-------+---------+----------+--------------------=
--+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+preempt_r=
t | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
  | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.201-cip41-rt17/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.201-cip41-rt17
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      78ed1354cecc021db9a1d8a8b4755fdfcd826e33

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
  | regressions
-------------------------+-------+---------+----------+--------------------=
--+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+preempt_r=
t | 1          =


  Details:     https://kernelci.org/test/plan/id/656001c345bc72128a7e4a9e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-cip/ltp-timers-r8a774a=
1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-cip/ltp-timers-r8a774a=
1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/656001c345bc72128a7=
e4a9f
        new failure (last pass: v5.10.184-cip36-rt14) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
  | regressions
-------------------------+-------+---------+----------+--------------------=
--+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
  | 1          =


  Details:     https://kernelci.org/test/plan/id/656006f733079089f87e4a83

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rz=
g2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rz=
g2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/656006f733079089f87=
e4a84
        new failure (last pass: v5.10.179-cip32-rt13) =

 =20

