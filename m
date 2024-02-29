Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EE9C54798
	for <webhook@archiver.kernel.org>; Thu, 29 Feb 2024 09:57:02 +0000 (UTC)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
 by mx.groups.io with SMTP id smtpd.web11.20891.1709200616507367054
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 29 Feb 2024 01:56:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=DRIx6LNG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.171, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c1a1e1e539so682577b6e.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 29 Feb 2024 01:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709200615; x=1709805415; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6e8O7hT6OqHnxOcPKYwxaVXz6qFRCvun4z9K5RXLgiw=;
        b=DRIx6LNGQuI0YcbjdHPlWsiJiKa+M2lBPkf+1VRNk2h033qtll6w5JWde2KGGYHdPy
         XtDbXgUv15msiKLBUacLMcOG7KDty/OYuhqvw7k7cumsMEkD1fbff9NfyfjS7bovuij6
         rV7our5/eDHWlYn0EJz5Aq0gMLHHvWLfkEyM6GRJInI8UuJ5rPsFkoE2Bcyq+Mx0KBkj
         CUGCBBp8d908HkKYIeMaeUme9wDqecRXkGgFWi28iWm2FEteFrgkaADEkeBM6nJRl3ph
         YGMOd4yBzEbjdB81qMvhjdMj/cKW4HkZtXCm73IbExzey5usC1SoAshKc5I83W8XVrYB
         JP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709200615; x=1709805415;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6e8O7hT6OqHnxOcPKYwxaVXz6qFRCvun4z9K5RXLgiw=;
        b=P+a/lZNlYcKUCin4tVoQSAlbx/fjsHEVuYpE8qO2LUFfZEQPOnLRFWZVtnieqa8YQZ
         WI51vhTaa1IZoQ4wL3xI6zTkyH14qrMYVJ6xJvRp5i5FCzYVJfJUiXHxWeVeIrUOem2l
         kuRYmqABtNI0hH+kq4aqBv30n+7l5y1LUXdrP6uWo5EGzXdNYl2zH4bbZNv0ulmgzxCk
         w4WQdzmDhuF5VIX0cyoTxvUZZ4amz17Mb/rd1zz1+vt8Vs5TIR5C4GCFcTvUOyYhZyBU
         KhmT2IXhK2JrrO+Jp7WVia8zjS68Uh5B5LvK0KL4kIKnLwDAViM4vUrEjpuheYNbOMCz
         jEfQ==
X-Gm-Message-State: AOJu0Ywhftk9TL7hzci9mGKwBs37vJB7uUokQfjDpE1Xx8GoYp2htetw
	Y0fxo4ZtPLqgOWFmbS4Ks2uPTXn+hwLTLYYv7z/a+ly4LaDT5+KAisJILUYe/BT5/MlAd4d7tk6
	n2hs=
X-Google-Smtp-Source: AGHT+IHz1CzLsNPLInXpgyPs+FiOq07DUHlI1OkIluiQgXMT/Fsu0mNHBK4+x2CpvzhIYmlH5+JUYQ==
X-Received: by 2002:a05:6808:2014:b0:3bf:f1e9:2199 with SMTP id q20-20020a056808201400b003bff1e92199mr1950510oiw.46.1709200615350;
        Thu, 29 Feb 2024 01:56:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 23-20020a630d57000000b005dc87f5dfcfsm900952pgn.78.2024.02.29.01.56.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 01:56:52 -0800 (PST)
Message-ID: <65e054e4.630a0220.672a1.289d@mx.google.com>
Date: Thu, 29 Feb 2024 01:56:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-56-g55117716ac0fd
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 8 runs,
 2 regressions (v5.10.209-cip44-56-g55117716ac0fd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Feb 2024 09:57:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15108

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 8 runs, 2 reg=
ressions (v5.10.209-cip44-56-g55117716ac0fd)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-56-g55117716ac0fd/plan/kselftes=
t-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-56-g55117716ac0fd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      55117716ac0fd541adb5a35e66eb21c45107b040 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65e03e49982e57df8e637014

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65e03e49982e=
57df8e637015
        failing since 47 days (last pass: v5.10.205-897-gcc9858ae2881, firs=
t fail: v5.10.205-905-gb40421b142370) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/65e044180c5617d12663701f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig+kselftest/gc=
c-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig+kselftest/gc=
c-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65e044180c56=
17d126637020
        failing since 118 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

