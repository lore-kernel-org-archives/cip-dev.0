Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F1BC4725D
	for <webhook@archiver.kernel.org>; Fri,  5 Jan 2024 21:08:58 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web10.35088.1704488935819535928
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 05 Jan 2024 13:08:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=YrWwOJts;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3f2985425so12355935ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 05 Jan 2024 13:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704488935; x=1705093735; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+N1tn7X0ACBJknfGJWVIQ/a+MaJK7hMyn7R/m9uWUwg=;
        b=YrWwOJtsI0AwYyc1b1z4mWdJM6QDkQxLzGCJo/a60VrsS1ViN3E933QkX4I+q2k0jX
         yFJk54m6zG3+T8ie2s08HIRP+5SG1N+v+xYwPmL/v75+JA3KKu1BWX0xUitWvfVn6dF8
         attz2LOvbrVb1rIsP1be7JxEeQigyxWji/0yCw4pT6lldMM+t12u7vpahAdsFy5pTFkB
         I60D0C6pbLwas7VRsNVeWuFlhWVm3Ya3IpDYeRcICD9UTt84mDfS7qThktjRRbb7AYgw
         CxAvtyVRsHSzkWSOb2cgWTZvgz3+vTV2j2ct/l8FTzGZhr6tbcuIGWpSw0rY6DWwZ11c
         A7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704488935; x=1705093735;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+N1tn7X0ACBJknfGJWVIQ/a+MaJK7hMyn7R/m9uWUwg=;
        b=bPAEKbi/p2G7saICjpvQCz4ti+CVKRKkJXHRi0Fwjtez3hUWDSI1oWfZrhXSOdJg4L
         blhG43kbqyLSFCbSBSUtqLmktYOQqMXnJPuljv5RWYw9zlGnw4NHK+rZvSMswEQrZhfz
         B0kZQN/R0NT8+dPijSa2+YvaLsNTjIXhyUmhftwE911sKjKAzHAhCSb0jYwVw2ysyXz5
         +mrgv1TsAsnBmh6B7mwwyPbvaTHzrNAKnWC2s/iO/bctpJfB0eK9DpTZnR9kzQNHLPKh
         T/WTGyAVW1JbCT6ufupNGplOzEArgS77QNNhG+76IV60ECw+KrU2d6O8LW9CrZO/hqT2
         bsfw==
X-Gm-Message-State: AOJu0YzEyKq9IVfq+Kdopy1ND2WWfsOblFwotvELoDbk7jYnhpjCZsPR
	dT1tPdmeSY0nZnV+P4CamMmVtf+jhJHVhoK45uBxsvMaJao=
X-Google-Smtp-Source: AGHT+IEdEVUDxlbsm8+UN4v0aZfjymYXrOaCKTta4X9OK6ccrXsPUTGKJ0jsjORSiAPHYPrwm26idg==
X-Received: by 2002:a17:902:ce8a:b0:1d0:6ffd:837f with SMTP id f10-20020a170902ce8a00b001d06ffd837fmr41033plg.138.1704488934684;
        Fri, 05 Jan 2024 13:08:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bf8-20020a170902b90800b001cff353696asm1814864plb.302.2024.01.05.13.08.50
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 13:08:51 -0800 (PST)
Message-ID: <65986fe3.170a0220.2c039.4266@mx.google.com>
Date: Fri, 05 Jan 2024 13:08:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.205-897-gcc9858ae2881
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 9 runs,
 3 regressions (v5.10.205-897-gcc9858ae2881)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jan 2024 21:08:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14265

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 9 runs, 3 regressions (=
v5.10.205-897-gcc9858ae2881)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
qemu_smp8_riscv64        | riscv | lab-collabora | gcc-10   | defconfig    =
              | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.205-897-gcc9858ae2881/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.205-897-gcc9858ae2881
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      cc9858ae2881ce2dd7cb1eab9e7038ce843f1bfe

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
qemu_smp8_riscv64        | riscv | lab-collabora | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/6598614a16118b66f352a3f2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/riscv/defconfig/gcc-10/lab-collabo=
ra/ltp-pty-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/riscv/defconfig/gcc-10/lab-collabo=
ra/ltp-pty-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6598614a16118b66f352a3=
f3
        new failure (last pass: v5.10.201-cip41-540-g3640150b3b169) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65986085ed01fd9f2952a41d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65986085ed01fd9f2952a4=
1e
        failing since 64 days (last pass: v5.10.182-cip35-289-g3c0549540706=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/659860faf007e083c952a3f2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig/gcc-10/lab-cip/ltp=
-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig/gcc-10/lab-cip/ltp=
-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/659860faf007e083c952a3=
f3
        failing since 15 days (last pass: v5.10.201-cip41-69-g8f7b450fc28ed=
, first fail: v5.10.201-cip41-540-g3640150b3b169) =

 =20

