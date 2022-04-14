X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web08.6943.1649901149885775616
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Apr 2022 18:52:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=zljopmTn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id bo5so3549131pfb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Apr 2022 18:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=D/0A1Ji6koIV5wz+s2zPk1EhmKyRsIebbQDikPOP9fc=;
        b=zljopmTnabPXBT6wFuYwK/gQizPpnHy8wbvdi5quNr8U5z9LABBOTqxuks9pTw3tPg
         an/NfvygGXbv6ib4taB9APEQz2RNTndFvZlT87bytY5s00nYejO3AZ9yCoNzJFmPpWym
         arVGaxsC63FfztP4vyGzfUF708/ItVgAoKQM2JwJs5UPxOwix4+k5DMv6Nx0rJs07Jjw
         JcDYVLUW713DNkkpundjiNpF67lRH4116B252UQG06UQv7b56aoFEX/mPoTT/YACRcJG
         aUZDIGqPR/AmE8+pvfJ0YmdZVVbWH5C/WGNkxu+BtPzYEbpSZatkoulVQ896Fl+h1jQe
         UwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=D/0A1Ji6koIV5wz+s2zPk1EhmKyRsIebbQDikPOP9fc=;
        b=jbmK+jgDWr6NXoAIu1swAUuaQ+x6BdkLD1VO9iatRXOqBSkLvhJEsB0TgZiOBTborS
         BMdg69jOl7Nn5W8X6x3JNiv76FvKhradCkMEUqTsCN0q2hl34n+nVFYdr0zNMaId53wx
         4ykPsfw/aeZzJwKv6Z8UjQbb9FMeP6yKC2B7N8L2ofOZjt7erbFd/LnGLMNbScOGH5zD
         HIJ3FLZI950Qjd1tXVCbbD4Bbmghqn0FP2ALwOSa8CWkAy/Im8uNxNPzRMnbkmgvRso/
         +idZrRjdBNwKCl1+wLtR0c89RKcU7+5IgGnxPiRoRH58hgrE6hgkcip2qlTce+3HDezc
         BsLg==
X-Gm-Message-State: AOAM530I8KLe7vYe+iIVNN7o7Wj+y1X19cw/duvgjRbelLj3p8yiACVI
	1v4Ngyyx9zX7XE+NXZXIVaKd7R6kZrbGfUTS
X-Google-Smtp-Source: ABdhPJy0sW2hYzKqp0TMNdMBQmG1E+/eujIgHwALjOm/+vizReJ4YxQE6KvRlaelhw+mXG/aIk4FjA==
X-Received: by 2002:a63:2263:0:b0:399:561e:810b with SMTP id t35-20020a632263000000b00399561e810bmr363728pgm.615.1649901149112;
        Wed, 13 Apr 2022 18:52:29 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090a6c9000b001c993d935e7sm301360pjj.56.2022.04.13.18.52.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 18:52:28 -0700 (PDT)
Message-ID: <62577e5c.1c69fb81.6f838.13f6@mx.google.com>
Date: Wed, 13 Apr 2022 18:52:28 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.109-cip5-770-g2801336f0f208
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 4 runs, 3 regressions (v5.10.109-cip5-770-g2801336f0f208) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 4 runs, 3 regressions (=
v5.10.109-cip5-770-g2801336f0f208)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.109-cip5-770-g2801336f0f208/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.109-cip5-770-g2801336f0f208
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2801336f0f2089b0d935efe67d93eccaa85e4bec

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  163cca9acb71d06492836a667a53554ceec37639 =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/625775aa51fbe8d80eae067c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-770-g2801336f0f208/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-770-g2801336f0f208/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/625775aa51fbe8d80eae06=
7d
        failing since 22 days (last pass: v5.10.100-cip2-484-gede5006fb276,=
 first fail: v5.10.104-cip3-155-g4f07dbd2df49e) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/62577e3ab9cf431125ae068f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-770-g2801336f0f208/arm64/defconfig/gcc-10/lab-c=
ip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-770-g2801336f0f208/arm64/defconfig/gcc-10/lab-c=
ip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62577e3ab9cf431125ae06=
90
        failing since 22 days (last pass: v5.10.104-cip3-132-g46c091c34fabb=
, first fail: v5.10.104-cip3-155-g4f07dbd2df49e) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62576f3f0a0e41b11cae068d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-770-g2801336f0f208/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-770-g2801336f0f208/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62576f3f0a0e41b11cae06=
8e
        failing since 22 days (last pass: v5.10.100-cip2-484-gede5006fb276,=
 first fail: v5.10.104-cip3-155-g4f07dbd2df49e) =

 =20

