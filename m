Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6ACC4332F
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 16:16:00 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web10.26662.1702570550611421497
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Dec 2023 08:15:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Ql1PY3Oi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28b011857f0so885913a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 14 Dec 2023 08:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702570545; x=1703175345; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mtnrC0OL0iBH65nNuqMxgISUZvOAG8K2qBa1vJ5izdk=;
        b=Ql1PY3OikHSWIBP/pbsiLXsKOgnRsoWDPcasOW1G3EVZUTSgB6D2R5nS1fDjy+gD2Q
         xoTjwhJF+4/eFGWD/KHkWj7y6kA6OI8nOA4v+zHO/nKOvq77kYNfd60VzLwJxVwWxBwn
         GU3KfltBpEtHhrhyG4tAskRDDz0BL3kkTrVhq6JXl3DH2omhzgm+5/9gBZfuZFma8LDA
         g5FjDeiK7cFlwnNznuLFOvMP549ubGlNcYCI5OydlBx//wBSO4/MZzdQa8X/n1ry3wu1
         PcF8YR/VhmlxGx7zJcxSnwYwrrnbJB9qrNseHm2qn6Xfg5Vuww9lRFoqCXU6ERpw6cjp
         vgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570545; x=1703175345;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtnrC0OL0iBH65nNuqMxgISUZvOAG8K2qBa1vJ5izdk=;
        b=wD5zMWh3q0eZPo/aVwTnJmEBbRLEYAL5i7dCIFq3WRtBaXHpulgCL8Iz728pnTWkZA
         fNx5A9g8eiqyXpR5v4Kf0crdQGD5koVCPpplQiemuRlgxMYbfynSPfpt2W+UAfqWXomj
         co2Xb9Otd8IU3GGgFg8iVYkgr9hu2GukZxadk6p7leOEj7ioBO+GEgQWndttV0PIyvJe
         ORT/Z0JeOICJYHIjoIWHIbASI5nx+VLDB8hbeElfT24HPROpaE05K/12k2L/nyTvuNbD
         LPM+MPA/ymw63ZQskAXfe68qqjm8C2hvIF4YL9iEXBH2e1zmldAthaT7kAj9lcORzt79
         wpYA==
X-Gm-Message-State: AOJu0Yy2TSRIjuRpVTT/PP8pSeVrLSeZ8bUw4ING5zog2wqBAv473eKs
	WaFF+eic1qJYFX5HtGTcfHYfATB9CcujypgSGsw=
X-Google-Smtp-Source: AGHT+IG3SBovXUZ37v33zHXlli4ZGQHVNFXFl8H5Iddjqqq/6wI7z8gnvoKhI21RFUbAOsoad9tk7w==
X-Received: by 2002:a17:90b:f18:b0:28b:6f7:f868 with SMTP id br24-20020a17090b0f1800b0028b06f7f868mr583800pjb.56.1702570545096;
        Thu, 14 Dec 2023 08:15:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090ab30800b0028591079e6fsm14672091pjr.24.2023.12.14.08.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:15:41 -0800 (PST)
Message-ID: <657b2a2d.170a0220.b2361.c595@mx.google.com>
Date: Thu, 14 Dec 2023 08:15:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-69-g8f7b450fc28ed
Subject: cip/linux-5.10.y-cip ltp-fcntl-locktests: 9 runs,
 2 regressions (v5.10.201-cip41-69-g8f7b450fc28ed)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 16:16:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14122

cip/linux-5.10.y-cip ltp-fcntl-locktests: 9 runs, 2 regressions (v5.10.201-=
cip41-69-g8f7b450fc28ed)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig | r=
egressions
-------------------------+-------+---------------+----------+-----------+--=
----------
qemu_smp8_riscv64        | riscv | lab-collabora | gcc-10   | defconfig | 1=
          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig | 1=
          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-69-g8f7b450fc28ed/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
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



platform                 | arch  | lab           | compiler | defconfig | r=
egressions
-------------------------+-------+---------------+----------+-----------+--=
----------
qemu_smp8_riscv64        | riscv | lab-collabora | gcc-10   | defconfig | 1=
          =


  Details:     https://kernelci.org/test/plan/id/657b1a048f1d74df70e1348e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/riscv/defconfig/gcc-10/lab-collabora/ltp-fcntl-loc=
ktests-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/riscv/defconfig/gcc-10/lab-collabora/ltp-fcntl-loc=
ktests-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/657b1a048f=
1d74df70e1348f
        new failure (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6) =

 =



platform                 | arch  | lab           | compiler | defconfig | r=
egressions
-------------------------+-------+---------------+----------+-----------+--=
----------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig | 1=
          =


  Details:     https://kernelci.org/test/plan/id/657b1c669c17b38b48e134a0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests=
-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests=
-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/657b1c669c=
17b38b48e134a1
        failing since 182 days (last pass: v5.10.182-cip35-1-g7cde3fba93966=
, first fail: v5.10.182-cip35-8-gdba81ae6f2be) =

 =20

