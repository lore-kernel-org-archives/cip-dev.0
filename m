Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA7DC5478C
	for <webhook@archiver.kernel.org>; Sat,  2 Mar 2024 23:37:08 +0000 (UTC)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
 by mx.groups.io with SMTP id smtpd.web10.63472.1709422621345588551
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 02 Mar 2024 15:37:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=n2s7gQtr;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.46, mailfrom: bot@kernelci.org)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7c8406e4745so14509139f.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 02 Mar 2024 15:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709422620; x=1710027420; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v0YBZ2Vq06u3qoTFgNWrMAbVoY/YmyWm8XuXM/LFR5I=;
        b=n2s7gQtrGg1mM0QmqJTl3EljquNMlDTl8ryLq/jxowoWK3S6+DU4R5GLE3CmJF9WE6
         OdhaHKix+8QkbHtHCkaAyzGJIuZFsIBvFxpa6R4kodvhMrmhSlPE6VaoHYxzXgD+2mij
         SaPFcxXUzR5gQqq+oTEon9dQ3k2Cx5tEZJpQcQHhvZSzeE7KDOjOVi0qxNOgIzoMOX5A
         VRFJ7j147EE2A+EInKWErhciqWB14xDcSwrk69E0weuZXWZ8744I5uEXhfgDIkKik/4j
         99RtKy8e3CPUAOKOtjwmBFqMM6uopx4RLULt9LxnplgAVNgv/mEeZUp3+8jXqhF/01O5
         iWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709422620; x=1710027420;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0YBZ2Vq06u3qoTFgNWrMAbVoY/YmyWm8XuXM/LFR5I=;
        b=YZ7Yp5sZmI9DDuL6JgBhwY3YozXq7ZRNVTJ/CrT8uJ02/zcIeOfoS6FoOxyiCVu5SE
         JOF34tXdYgUh++gICnw0X/p5ifqqdQKg5f468EaKdEbErxcr6fwkVuZ/4hdov1rnQCyF
         gPP7BlEH6warCYl0DP+M1cFSl4dzn8J+4qLq/OEuUcBjCZV9jaR1+QuWa4hZ6eBb4iQq
         C3eeNPKQIUbnZyPayU8MljZ/fgZkh4rXSxJ9Ph+AlDTgVylp6Uyg4IFRHRx5o36N+a6u
         MMpqkQ98yv/GA9SYnoX0/Zd48aZ9if+JzLoutq6V4G6b8qIkfi8zCbQL+DbBXSqdodDo
         Spuw==
X-Gm-Message-State: AOJu0YzUcQfCmxOxpLlyPK30aT1YL1GchZJ5MvgFXvXhh6RPOOwa14Xq
	T9jqlkTKAXt3FIDuj8zWs+ClD41gkt3DRIfzTEEUi2vDWPqz8VQFAA9FLgMt4Me1orM9Ut2wjIx
	qtfw=
X-Google-Smtp-Source: AGHT+IF0cvnFaFfzTC82tloJSsUoyXmv8LKfJWaFLyXmTePnGPfDzngu8owtgUrcXgQhHTT0gmRO7A==
X-Received: by 2002:a05:6e02:1a47:b0:365:c827:787b with SMTP id u7-20020a056e021a4700b00365c827787bmr6572293ilv.14.1709422619861;
        Sat, 02 Mar 2024 15:36:59 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s38-20020a63ff66000000b005d34cf68664sm5056804pgk.25.2024.03.02.15.36.57
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 15:36:57 -0800 (PST)
Message-ID: <65e3b819.630a0220.dbb01.6693@mx.google.com>
Date: Sat, 02 Mar 2024 15:36:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.78-cip15-404-gdddfc5d4f194
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 15 runs,
 4 regressions (v6.1.78-cip15-404-gdddfc5d4f194)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Mar 2024 23:37:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15172

cip-gitlab/ci/pavel/linux-test ltp-timers: 15 runs, 4 regressions (v6.1.78-=
cip15-404-gdddfc5d4f194)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
bcm2711-rpi-4-b | arm64 | lab-broonie   | gcc-10   | defconfig | 2          =

bcm2711-rpi-4-b | arm64 | lab-collabora | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.78-cip15-404-gdddfc5d4f194/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.78-cip15-404-gdddfc5d4f194
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      dddfc5d4f194925df6ee3d06e86b1d1e12412f06 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
bcm2711-rpi-4-b | arm64 | lab-broonie   | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/65e3b051ee11baf33b637016

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm64/defconfig/gcc-10/lab-broonie/ltp-tim=
ers-bcm2711-rpi-4-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm64/defconfig/gcc-10/lab-broonie/ltp-tim=
ers-bcm2711-rpi-4-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65e3b051ee1=
1baf33b63701b
        failing since 17 days (last pass: v5.10.209-cip44-526-gbbb905888ca8=
5, first fail: v5.10.209-cip44-51-gdb99ac443b0da) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65e3b051ee1=
1baf33b63701b
        failing since 17 days (last pass: v5.10.209-cip44-526-gbbb905888ca8=
5, first fail: v5.10.209-cip44-51-gdb99ac443b0da) =

 =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
bcm2711-rpi-4-b | arm64 | lab-collabora | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/65e3ae6684884089d9637015

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm64/defconfig/gcc-10/lab-collabora/ltp-t=
imers-bcm2711-rpi-4-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm64/defconfig/gcc-10/lab-collabora/ltp-t=
imers-bcm2711-rpi-4-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65e3ae66848=
84089d963701a
        failing since 17 days (last pass: v5.10.209-cip44-526-gbbb905888ca8=
5, first fail: v5.10.209-cip44-51-gdb99ac443b0da) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65e3ae66848=
84089d963701a
        failing since 17 days (last pass: v5.10.209-cip44-526-gbbb905888ca8=
5, first fail: v5.10.209-cip44-51-gdb99ac443b0da) =

 =20

