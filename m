Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02F5C4829E
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 03:10:12 +0000 (UTC)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
 by mx.groups.io with SMTP id smtpd.web11.13869.1707189011398328457
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 19:10:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=jlqm7qb6;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.47, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-214ca209184so3649767fac.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 19:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707189010; x=1707793810; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f86gR4q5Na9UOlbMcdS5samf28rhfVrYw3JhhXV9JLU=;
        b=jlqm7qb6YhaiF8w4Q2Hwuudm73Pe4SczxE7vT7R2sLxpFqOpoo++ALyJNL6ZTK2kzN
         CiA6/Pu54oV9d9UOOXPjzd3tfbLmUqdd8b6Jk8OWE/V+PK+8hBbGOerndWrz8rGXHnC9
         0qDrZxoEL+U8bdTjl9DsrDgtGBNa23HX1SFYo2QPmkCj7el3hUmKhEpbNL97fwrKR3Y3
         m+YJhGMyaWzUiTSm6YziVEXtzXVxnmUBANXRBP99Etk2pJ5NmRF10QxUlH4ZLM67cOl9
         B/vIxutM4cRNjUlv+TCCB4Nfm97xJNDMPB9uT24ea9SxegZnaUXKhbUJR5t0VIbETNsZ
         8s2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707189010; x=1707793810;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f86gR4q5Na9UOlbMcdS5samf28rhfVrYw3JhhXV9JLU=;
        b=XsoYeOYrvA1Xi/bzOaFj3LGU90Bda2l6PFry0w4BdmH6t/aMmJYpeEaXt3sWE+Fnlf
         NjkdBgmqOft72dSk7nS4EJlfOkmkkJkYs87I34XeXObJvYv3so2/j7+FWS1BkWTMam0f
         e5BG/gdb7g8qh6rzrCvszG8PwLdJsvaz9TI8xD+foLmgqYmdR/ocFjK19DHJ3pXkUUBs
         2yl3a7gKTJzlFQn6mPd/BileLoUEqWgZYSMbxH8kmcswHL0OnCKXv7+bHuyFOYD4ekc0
         LikYR9nGKzMEij/rlT9FhDQ9l3su15QtEx4HLhmWYCdv5ZJ7P3rweDT2BfFCKAMNBa3D
         DZTQ==
X-Gm-Message-State: AOJu0YxjTa9NnOIqE1eobeOUVaRJb7ZABBOddrLv9rCSPtmGIrJSRJQ3
	wxEwDwnZu3qQMeLoAU8MWqrAdV1Q+wlxniuM0cn6WpDHjkTu1BYyYCOQux6YoyFof0QYBDVWUla
	b
X-Google-Smtp-Source: AGHT+IF5WfqDxJLfMZ02fABGWMHjHV1Lxb6v7GeXPqS7KC5RvTtuDM0cOn3XFVqazzXisQicVCqlsA==
X-Received: by 2002:a05:6870:46ab:b0:218:d374:9b7b with SMTP id a43-20020a05687046ab00b00218d3749b7bmr1394539oap.38.1707189010414;
        Mon, 05 Feb 2024 19:10:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVSMHIXqsXff0eAH2nYafv/wLTGNC2004hp8LH+26IElXvyWAeCtHnwPSSbhvUW8MWJR+OVfl74HP+g7MfFGcRek9H5e0uayEOAtX43V+Vp+2QQ/tTKrcWiKZaUo3Bapy41LESkIwLxmdLDx2MzR0piuA==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b5-20020a636705000000b0058ee60f8e4dsm823898pgc.34.2024.02.05.19.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 19:10:09 -0800 (PST)
Message-ID: <65c1a311.630a0220.d4d54.4924@mx.google.com>
Date: Mon, 05 Feb 2024 19:10:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.209-cip44-rt18
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt ltp-timers: 24 runs,
 4 regressions (v5.10.209-cip44-rt18)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 03:10:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14773

cip/linux-5.10.y-cip-rt ltp-timers: 24 runs, 4 regressions (v5.10.209-cip44=
-rt18)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
      | regressions
-------------------------+-------+-------------+----------+----------------=
------+------------
qemu_riscv64             | riscv | lab-broonie | gcc-10   | defconfig      =
      | 2          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+preem=
pt_rt | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
      | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.209-cip44-rt18/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.209-cip44-rt18
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d814befd12dcf6c81b483cb36f507d70112c1097

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
      | regressions
-------------------------+-------+-------------+----------+----------------=
------+------------
qemu_riscv64             | riscv | lab-broonie | gcc-10   | defconfig      =
      | 2          =


  Details:     https://kernelci.org/test/plan/id/65c1999b508d3eb41b00a054

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_riscv64.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_riscv64.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65c1999b508=
d3eb41b00a059
        new failure (last pass: v5.10.201-cip41-rt17) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65c1999b508=
d3eb41b00a059
        new failure (last pass: v5.10.201-cip41-rt17) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
      | regressions
-------------------------+-------+-------------+----------+----------------=
------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+preem=
pt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65c194d4628cfe21ed00a16f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig+preempt_rt/gcc-10/lab-cip/ltp-timers-r8a774a=
1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig+preempt_rt/gcc-10/lab-cip/ltp-timers-r8a774a=
1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c194d4628cfe21ed0=
0a170
        failing since 74 days (last pass: v5.10.184-cip36-rt14, first fail:=
 v5.10.201-cip41-rt17) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
      | regressions
-------------------------+-------+-------------+----------+----------------=
------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/65c197c48801f7b3ce00a039

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rz=
g2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rz=
g2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c197c48801f7b3ce0=
0a03a
        failing since 74 days (last pass: v5.10.179-cip32-rt13, first fail:=
 v5.10.201-cip41-rt17) =

 =20

