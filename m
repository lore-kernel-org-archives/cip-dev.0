Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB33E7B60D
	for <webhook@archiver.kernel.org>; Wed,  4 Oct 2023 12:23:11 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web11.16802.1696422188206540292
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 04 Oct 2023 05:23:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=MGZsYxku;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6934202b8bdso1617277b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 04 Oct 2023 05:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696422187; x=1697026987; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ov+bkG5uis1r1M9aZ/mGpGDXB5HzRAEKn+MPjL/ndzI=;
        b=MGZsYxkuQsdI/JV/YFmBLzKDu3jUw2jG8wiiIHIEms3WGCVTGWZzOg2my6n+0ZZUOz
         OLozSLAwrJFOX/qT1OWQOgIuTixo5CWn6Wmcp/+n/7hLBwiUkHOEr+Wg86J4obTYJWUv
         pTdut5AH1i9sDJp8EyR+2uNKAVynL4h58JDXUm3HDkQSdOJO1AgrKi9CZtUObVwQWK8M
         vX+5HUdGdKGZ0AyeYHtqt71OaLspSHHZygRSbeUm+LDbZQ/7UBN2zyHOnp2RJ24Rlfag
         pQXvovqCVrmEAxXTKvf1F0tbage6mXBSmin80WKtJ1X48ATfD2Uv6ja9arWKoijXu2bA
         GFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696422187; x=1697026987;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ov+bkG5uis1r1M9aZ/mGpGDXB5HzRAEKn+MPjL/ndzI=;
        b=EGlR92ObGAvaGhMBVwy+fh39QnI6ucgYyKIV7B4bf1TRaUKtLBD3ZHOKBBEFtnn9TL
         UbhpBQGPxiWFxfkLeAKzxCoJj35nfT1I7xpXiymyxa8KceezepHjpaxzHumP+PeiBRAE
         rWme6dEkjpuNqhf4/oXQXzuyEvqCd7OFQOxX3pN5lpiEJQ4cL44xTs7rJ6H4CQfOEs/D
         O9UaInIUbYY8ULWR2ZahTZ8Vzia09tWTkhGORL7mtujSZ6XEAS8yRcGeP/SZgskHtWW8
         ar9uS2k63hSj07wzUdltVMFsgwQZO+j7NgAJHPAuBTkS/63wDvoI6Iv3yzZaTfXX0zFz
         LSSA==
X-Gm-Message-State: AOJu0YxRHHiv2JTEdfKCZxStsY0hax/fCpaFo1Agnp9N8B7L+S6qOsFk
	9dqxVsjy3e2KCfiV/9I0Ac5fxNNsrQbOB84GtO7aDg==
X-Google-Smtp-Source: AGHT+IE60QH4kHl3cvIDTCVNGlfpfMwZVTuOKRt822z4YS93ssLjoSJM2dVPka0C7Zn0nBiDocKqKw==
X-Received: by 2002:a05:6a21:71c1:b0:15d:ad11:748 with SMTP id ay1-20020a056a2171c100b0015dad110748mr2133367pzc.30.1696422187127;
        Wed, 04 Oct 2023 05:23:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jk12-20020a170903330c00b001c6189ce950sm3539811plb.188.2023.10.04.05.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 05:22:59 -0700 (PDT)
Message-ID: <651d5923.170a0220.3effe.919d@mx.google.com>
Date: Wed, 04 Oct 2023 05:22:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.194-cip39-1-g53e59f50ca3ff
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-timers: 17 runs,
 9 regressions (v5.10.194-cip39-1-g53e59f50ca3ff)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Oct 2023 12:23:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13288

cip/linux-5.10.y-cip ltp-timers: 17 runs, 9 regressions (v5.10.194-cip39-1-=
g53e59f50ca3ff)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_riscv64                 | riscv  | lab-broonie   | gcc-10   | defconfi=
g                    | 2          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.194-cip39-1-g53e59f50ca3ff/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.194-cip39-1-g53e59f50ca3ff
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      53e59f50ca3ff023b612a48397ad7e057a9fd408

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/651d4cd915226347c98a0a43

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/651d4cd9152=
26347c98a0a48
        failing since 140 days (last pass: v5.10.177-cip31, first fail: v5.=
10.179-cip32-4-gd8c029e4780f) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/651d4cd9152=
26347c98a0a48
        failing since 140 days (last pass: v5.10.177-cip31, first fail: v5.=
10.179-cip32-4-gd8c029e4780f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651d52c5f63419ce398a0a5b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/651d52c5f63419ce398=
a0a5c
        new failure (last pass: v5.10.184-cip36) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/651d4eb64fff4160528a0a42

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/651d4eb64ff=
f4160528a0a47
        failing since 334 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/651d4eb64ff=
f4160528a0a47
        failing since 334 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651d57f0f00f6918e88a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-broonie/ltp-timers-meson=
-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-broonie/ltp-timers-meson=
-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/651d57f0f00f6918e88=
a0a43
        failing since 103 days (last pass: v5.10.182-cip35-8-gdba81ae6f2be,=
 first fail: v5.10.184-cip36) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_riscv64                 | riscv  | lab-broonie   | gcc-10   | defconfi=
g                    | 2          =


  Details:     https://kernelci.org/test/plan/id/651d4ed6cc8ca44b6f8a0a42

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_=
riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_=
riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/651d4ed6cc8=
ca44b6f8a0a47
        failing since 14 days (last pass: v5.10.191-cip38-29-g9e1aa2001db8,=
 first fail: v5.10.194-cip39) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/651d4ed6cc8=
ca44b6f8a0a47
        failing since 14 days (last pass: v5.10.191-cip38-29-g9e1aa2001db8,=
 first fail: v5.10.194-cip39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/651d529309cc8f52028a0a44

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/651d529309cc8f52028=
a0a45
        new failure (last pass: v5.10.184-cip36) =

 =20

