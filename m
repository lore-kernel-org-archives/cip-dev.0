Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC29C10F09
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 14:02:07 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.84739.1701957721561722816
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 06:02:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=fFwMRKuW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d05e4a94c3so8112295ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 06:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701957716; x=1702562516; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKZfQxheoPJOF1CKXYUeqG0INyaw/NL7dp0M6xWDI8Y=;
        b=fFwMRKuWG7OMN+yQqYe98+q0p3Vm8hpcc8ODBmZV8Lj+HBej6bPeCt7AN7lMTfi9OU
         YyLXa188O0lvetCbYzDjKn3A/IwHdwRR5nKX3GlPs47ZAYB9paaVSCEZdy1loOwC3sVc
         055IrTVDI6Ws40v4U07rt3MvDOz1FNWnWV44UzNfhuHpQgn+4zxVR0sTg76EcwmejK9E
         CcMWqfMJBsUliRWGkNOgioY8gAi+y3pWbbpA7EI9Mv6M2kSJz5Cal2oVWAv7NiudLvDr
         Uq2gUavsSVxstVtRNyOgjWkjqU+FjOvadybmPR8Oc1ip636CQtytQOfx4vRgVgVuz0YC
         1XHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957716; x=1702562516;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKZfQxheoPJOF1CKXYUeqG0INyaw/NL7dp0M6xWDI8Y=;
        b=s2I/Y6CLnT87fmYRcEj+GCtM95jUf2NLnNVWp2fpSfaLRAkudUweCeQ27zOjXUMdpa
         g6KQiDlggzedQlLKpweY6rx0hnVBg+7umLmo8ETQw9hqmVFxkBteN0E2LzeppEAWMzR8
         E1bbByulx81rFkJxH3DKJukGJRWdZP/X+o6bfmyWpMhpzaBVE+5FNLsik84r/Zte3bz7
         ryl81bG7OAvHyVLmUL54DGJLrbEeMmIVq+O47Ktgn0plY0D2c3+aIq59hY9JqK5p8Tb9
         6T5ODHEI/5YVh6cHj/6hTGwHkF/tTWQTTQH04xeyiN7sRZeHGXh2zogS9cxs5S15/ub+
         Sa5A==
X-Gm-Message-State: AOJu0YzKeVmr+UYIQlWxGYCNwdRlwyLP161qAo8GRI5zqiIoZGoyD1AC
	dzUiAHVk+3NPBFheRIWiaiIrfA3CunI67IqPhaYVrQ==
X-Google-Smtp-Source: AGHT+IEhCEGjjR0uX8GbKd4OiiuCgtDyKjdFFMxnZcTHggeXBHUuFMNF+ofucb2f7ef6E9uKngy1MA==
X-Received: by 2002:a17:902:e5cd:b0:1d0:9228:575e with SMTP id u13-20020a170902e5cd00b001d09228575emr3097394plf.43.1701957716106;
        Thu, 07 Dec 2023 06:01:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e19-20020a637453000000b005b32d6b4f2fsm1305647pgn.81.2023.12.07.06.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:01:55 -0800 (PST)
Message-ID: <6571d053.630a0220.adb24.310c@mx.google.com>
Date: Thu, 07 Dec 2023 06:01:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-16-g3c85fba3b6e5d
Subject: cip/linux-5.10.y-cip ltp-fcntl-locktests: 9 runs,
 3 regressions (v5.10.201-cip41-16-g3c85fba3b6e5d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 14:02:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13867

cip/linux-5.10.y-cip ltp-fcntl-locktests: 9 runs, 3 regressions (v5.10.201-=
cip41-16-g3c85fba3b6e5d)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig | r=
egressions
-------------------------+-------+---------------+----------+-----------+--=
----------
qemu_smp8_riscv64        | riscv | lab-broonie   | gcc-10   | defconfig | 1=
          =

qemu_smp8_riscv64        | riscv | lab-collabora | gcc-10   | defconfig | 1=
          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig | 1=
          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-16-g3c85fba3b6e5d/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-16-g3c85fba3b6e5d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3c85fba3b6e5da8b112e7ecd142649674648028f

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
qemu_smp8_riscv64        | riscv | lab-broonie   | gcc-10   | defconfig | 1=
          =


  Details:     https://kernelci.org/test/plan/id/6571ba2d19123ced9ae134fa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/riscv/defconfig/gcc-10/lab-broonie/ltp-fcntl-lockt=
ests-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/riscv/defconfig/gcc-10/lab-broonie/ltp-fcntl-lockt=
ests-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6571ba2d19=
123ced9ae134fb
        new failure (last pass: v5.10.201-cip41-11-ga539098fe70dd) =

 =



platform                 | arch  | lab           | compiler | defconfig | r=
egressions
-------------------------+-------+---------------+----------+-----------+--=
----------
qemu_smp8_riscv64        | riscv | lab-collabora | gcc-10   | defconfig | 1=
          =


  Details:     https://kernelci.org/test/plan/id/6571ba3219123ced9ae13500

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/riscv/defconfig/gcc-10/lab-collabora/ltp-fcntl-loc=
ktests-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/riscv/defconfig/gcc-10/lab-collabora/ltp-fcntl-loc=
ktests-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6571ba3219=
123ced9ae13501
        new failure (last pass: v5.10.201-cip41-11-ga539098fe70dd) =

 =



platform                 | arch  | lab           | compiler | defconfig | r=
egressions
-------------------------+-------+---------------+----------+-----------+--=
----------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig | 1=
          =


  Details:     https://kernelci.org/test/plan/id/6571bab1606f3f141ee13562

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests=
-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests=
-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6571bab160=
6f3f141ee13563
        failing since 175 days (last pass: v5.10.182-cip35-1-g7cde3fba93966=
, first fail: v5.10.182-cip35-8-gdba81ae6f2be) =

 =20

