Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549BEC433EF
	for <webhook@archiver.kernel.org>; Sat,  2 Jul 2022 21:12:49 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web09.54905.1656796368496915179
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 02 Jul 2022 14:12:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=hx915eIv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id
 89-20020a17090a09e200b001ef7638e536so1536144pjo.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 02 Jul 2022 14:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=V8M1rGprMuKGz2LSwHHNE+v006R7jCrxkcNsFr/aBJQ=;
        b=hx915eIv6Cd8XQQdep4Eh5wBd+bR3Bc7wHXefBXuUrgwdPqpw+OIHjU9VaCKp6u60+
         hljkN0QiDamVNHaYWPk9SoFUel87vDi9d+MCEidZmsBmvPFgsgHN+Ek6fEPn8iPNbkoX
         4bSn2CB1b9zAK2w9zD5GFPTM0A9c7XC6pCs+gS9DDPDI7uv+GtcN/FpwXrbZNKT7fJx9
         CRix9791ps2LlvMUOjfEiwkGvXOFao/TDvTCTeYCFWcy0VUk6Qojlh5aHC+OY+KoGnxY
         AsQ5DeH5Ra1N43UnwE7xyMhxn9w6+tSqIdErL5ddbje5yGhecm5F2UmIy5VcyuRf9i6O
         acOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=V8M1rGprMuKGz2LSwHHNE+v006R7jCrxkcNsFr/aBJQ=;
        b=3ABGlXXkbrAr9OnZ/TpzDmoOHaAf1RHdFZ8LXMaOsqpN19MA91lOFFVzahlhsdwIY3
         h1M1xSbbxyekuGqqU8CAjBh1f2BoZUN/Ea5Z0ZoNpMLJMf1xkgid1x43+/nAOHeOS7Ot
         DcYDD2BFIhOyCD17Bc2+fFyzcIZxod7KhudSEWC2yxaMaATlrVZWfoOHIIMdZwAxnB+z
         bzB027XZ5HBivpuqgpEiuylqFSZhYhjJSl8GfTy/jH6Y15/SLhEjy6rffadDbELeaTR3
         wR4xMRtrtdSDGla+eSdWR7Bpl5NrrpxCDcS2lIhh43MSCpwPedndqTW78B6lZUQPseAd
         t2ng==
X-Gm-Message-State: AJIora/CLzz2YPqc4mT1B+4EEEhDEuGxhBSUR6J8d5Bj7+WaJfknN6rO
	FQwuSkgQbtIKGLkJ1esQFO3ZVtKLNueVninc
X-Google-Smtp-Source: 
 AGRyM1t5vHN6VJqJteDlOJU8okGBr+4wsyxzv7kUFKZXTu9yUoUKlH/SwwxXptXIYzkumHVyUq4R9Q==
X-Received: by 2002:a17:902:8e85:b0:16a:380b:13a9 with SMTP id
 bg5-20020a1709028e8500b0016a380b13a9mr27144688plb.109.1656796367833;
        Sat, 02 Jul 2022 14:12:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 q9-20020a17090a1b0900b001ec2b1b7d8asm6629941pjq.10.2022.07.02.14.12.46
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 14:12:46 -0700 (PDT)
Message-ID: <62c0b4ce.1c69fb81.99042.a0fa@mx.google.com>
Date: Sat, 02 Jul 2022 14:12:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.125-cip10-118-gb03e159be974
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 8 runs,
 1 regressions (v5.10.125-cip10-118-gb03e159be974)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Jul 2022 21:12:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8639

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 8 runs, 1 reg=
ressions (v5.10.125-cip10-118-gb03e159be974)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.125-cip10-118-gb03e159be974/plan/kselftes=
t-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.125-cip10-118-gb03e159be974
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b03e159be9746a2cba92777632dfc469e7cdecf3 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62c0a5cf1336c81a4da39bce

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm64/defconfig+kselftest/gc=
c-10/lab-baylibre/kselftest-seccomp-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm64/defconfig+kselftest/gc=
c-10/lab-baylibre/kselftest-seccomp-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/62c0a5cf1336=
c81a4da39bcf
        failing since 4 days (last pass: v5.10.118-465-g0af29783a3c9, first=
 fail: v5.10.121-cip9-287-ge9094c8446fc) =

 =20

