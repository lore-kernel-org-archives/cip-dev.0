Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BFDC7EE23
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 23:59:34 +0000 (UTC)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
 by mx.groups.io with SMTP id smtpd.web10.268.1686009565063376919
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 16:59:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=TaByyQQq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.47, mailfrom: bot@kernelci.org)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6af6df7f93aso5052342a34.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 16:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686009564; x=1688601564;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=on3C52dv8PPu4/U/WU1ZAtSw2SDjEGcXqM9PmRLR/dw=;
        b=TaByyQQqIDkS8Zv5vJQ8YbA9uEsoGw6rHHCORr3BJW68nYFNKo/Rc0csSp9dHRy8FI
         /GfnNpq7quHEXrbtgyV1rwwp0GOpei2VhyH+ZgUyqRFGyouDhtY9n9wd+w6gygV4dqH1
         Eo41w32odgOF3R64KKle5l0IHAmmKdURD5qS+le27z7OimE4PoHQWMTRpAH4uT4e2crj
         p44chACUj9/x/xdgJUaDnuBOG/t74BOZ7UGCBxEycR2DNwNvPdfoOhlMbvxgASx7B7Il
         8kDkt3LL7CxUClMHSIRy7ivSmk/BnGyXVDjB2WUEDzK/eb8cDLp8rRQwWWcPrV1pKlnH
         Q/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686009564; x=1688601564;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=on3C52dv8PPu4/U/WU1ZAtSw2SDjEGcXqM9PmRLR/dw=;
        b=VwiySXgPMpLh6xCZMdSmnI8XpNeW5ZCS3LvutfMoB3J5MnknqO5hhyzYKG7fxVZdk5
         yzlE07neE8LCSL4cEXPhFWxnuAq1zXviZXo7IEc30KAzn27Q1UZMN/EwKZhL7RoxtR2T
         yCyrsZNhnWTBNek2NvsRvDD4u8/kYbq4ufmallvUBT/DHuiLYZXW84VuLMruOOVHQmQg
         KfpI86yuyndrptG8NNIHMVz6lG9GE5DrJgF4VHMiam963HEV4nyb6diH7gLGY5PLZH1r
         8ihVTnkQXiYcQScjc0wEDkjjSsQlJ7e9VSJ+ciALG5kxpys+iDyvJPKiy4ETv/MGxNl9
         QEbA==
X-Gm-Message-State: AC+VfDycM9DZ/RqVDOANk4n1PbECa6OTQApkFjTVjKN3HFzQ00UB+AjV
	ZaSx+Pmz8zJT+KqJPbyGYmiPhvvFKmdAhJCeAu3gog==
X-Google-Smtp-Source: ACHHUZ7BrgPSdZhgS4g4hElgMcMNkb/4L6Qx8A0i+wKH0YnqUaktMwWVxk7K0UE95Kdy6zGChgJxUQ==
X-Received: by 2002:a9d:6d0a:0:b0:696:1583:642 with SMTP id o10-20020a9d6d0a000000b0069615830642mr266817otp.21.1686009563892;
        Mon, 05 Jun 2023 16:59:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w7-20020a634907000000b0052c3f0ae381sm4517970pga.78.2023.06.05.16.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 16:59:23 -0700 (PDT)
Message-ID: <647e76db.630a0220.18c6b.7a0c@mx.google.com>
Date: Mon, 05 Jun 2023 16:59:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1314-g1ab0ac1d7e2e3
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-6.1.y-cip ltp-timers: 14 runs,
 5 regressions (v6.1.26-1314-g1ab0ac1d7e2e3)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 23:59:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11835

cip/linux-6.1.y-cip ltp-timers: 14 runs, 5 regressions (v6.1.26-1314-g1ab0a=
c1d7e2e3)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 2          =

qemu_x86_64            | x86_64 | lab-collabora | gcc-10   | x86_64_defconf=
ig             | 2          =

rk3399-gru-kevin       | arm64  | lab-collabora | gcc-10   | defconfig+arm6=
4-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.26-1314-g1ab0ac1d7e2e3/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.26-1314-g1ab0ac1d7e2e3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1ab0ac1d7e2e3aeca50f8616b469772a5f010acc

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/647e64b51ec6111a3ff5de2c

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
14-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
14-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647e64b51ec=
6111a3ff5de31
        new failure (last pass: v6.1.26-1281-g84d5372e0f314) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647e64b51ec=
6111a3ff5de31
        new failure (last pass: v6.1.26-1281-g84d5372e0f314) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
qemu_x86_64            | x86_64 | lab-collabora | gcc-10   | x86_64_defconf=
ig             | 2          =


  Details:     https://kernelci.org/test/plan/id/647e640d622c8a0688f5de9d

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
14-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig/gcc-10/lab-collabora/ltp-timers-q=
emu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
14-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig/gcc-10/lab-collabora/ltp-timers-q=
emu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647e640d622=
c8a0688f5dea2
        failing since 0 day (last pass: v6.1.26-1281-g84d5372e0f314, first =
fail: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T22:39:03.304069  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647e640d622=
c8a0688f5dea2
        failing since 0 day (last pass: v6.1.26-1281-g84d5372e0f314, first =
fail: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T22:39:03.304069  =

   =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
rk3399-gru-kevin       | arm64  | lab-collabora | gcc-10   | defconfig+arm6=
4-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/647e72c14f5efee036f5de25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
14-g1ab0ac1d7e2e3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp=
-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
14-g1ab0ac1d7e2e3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp=
-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/647e72c14f5efee036f=
5de26
        new failure (last pass: v6.1.26-1298-g61395b9756bd5) =

 =20

