Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AB5C4167D
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 16:15:49 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web11.26620.1702570549393494468
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Dec 2023 08:15:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=m5OHN3of;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d0a679fca7so2057088b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 14 Dec 2023 08:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702570547; x=1703175347; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rc6V7MyaFFZp2PIT7WGG8RUIRUDR72ZZ0dBxUKn5HWE=;
        b=m5OHN3ofv4TU9TKlGxQ+/m8D/SU7hBnv/l4eaGuHykj3S9h/BEwbLWspHddXXDSZAZ
         msV/bF+cGGhtC/zDICSwqg2qRmrA9DtvxtbStWj3vSr4KIR/XJQBylE1bHm5z7KHe0Iy
         Oxj6J8x1wOy6bQPeDV5LRiC2V7LsFWiivOmfnOW0XcS7xfO0qKnzMM88mPsX8UvkSJcN
         /QyKz45vKKwhoE5Bs7tPrLxu//Ndw2xaDQoDt6sy4Lv+31+FYGBAdbo5VheNdjshyGPA
         E7Bof6RgzQqZ5Y1/uwntu1fcDaPajX7TlAzd4WhCaSjAOt9Erwy94g3b8L0lIqXwJ2db
         FW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570547; x=1703175347;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rc6V7MyaFFZp2PIT7WGG8RUIRUDR72ZZ0dBxUKn5HWE=;
        b=YomkyxCDN9t2tnp52h1XadBoNR0XRrTBpJcoG7i78OunzJ+rpu+HNvCtM5wMBM02Fs
         011BrXKZURCcybHRDBorZRwJFdALn837lQbwodZu1p9hNB6TbeZl9jakGJkem5YtcoI3
         KGrvaoQFWA6bboRu/aYI0xCq63cY4TErGSZtoSO3n5FGWV3pSngwj8yAT83SekZRBZV2
         7335WHcVX2HsONQj0exYpqYSpZ/UyIU0S72YuKLkx/x3oKGo4pyyWcgnrOEdj87n/4Zu
         9yimqQIUQK0ctI7PXoO/rfEzur67KZJCf8CPdcR5LGQFmyBMVE1BEQ0rY4lxww9iZJl+
         suNw==
X-Gm-Message-State: AOJu0Yx49Hk1Gata6VOhM3rF78+fBq3DmDKALdlOJLgNTwDDzhnVR8Jt
	oIKUE15QFjj4WvTVbQ5aPSRl5s+a3HCregLMbb0=
X-Google-Smtp-Source: AGHT+IHUK2ob7+SDpFWLqhckiBAqXzJWIbzWL0SayyfQkrwL0VDZ89DC5HB9pnYVZMeR1Mu8EoD4OA==
X-Received: by 2002:a05:6a00:4601:b0:6cb:6a27:ab57 with SMTP id ko1-20020a056a00460100b006cb6a27ab57mr5298509pfb.14.1702570547249;
        Thu, 14 Dec 2023 08:15:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z19-20020aa78893000000b006cb884c0362sm11835086pfe.87.2023.12.14.08.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:15:41 -0800 (PST)
Message-ID: <657b2a2d.a70a0220.4351b.4cec@mx.google.com>
Date: Thu, 14 Dec 2023 08:15:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-69-g8f7b450fc28ed
Subject: cip/linux-5.10.y-cip ltp-timers: 13 runs,
 2 regressions (v5.10.201-cip41-69-g8f7b450fc28ed)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 16:15:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14121

cip/linux-5.10.y-cip ltp-timers: 13 runs, 2 regressions (v5.10.201-cip41-69=
-g8f7b450fc28ed)

Regressions Summary
-------------------

platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-69-g8f7b450fc28ed/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-69-g8f7b450fc28ed
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8f7b450fc28ed99196853536c98ae36c2567e160

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/657b262caaabe4e6cee13487

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu=
_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu=
_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/657b262caaa=
be4e6cee1348c
        failing since 6 days (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d,=
 first fail: v5.10.201-cip41-28-ga386bc478aa6b) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/657b262caaa=
be4e6cee1348c
        failing since 6 days (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d,=
 first fail: v5.10.201-cip41-28-ga386bc478aa6b) =

 =20

