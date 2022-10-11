Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA79C433F5
	for <webhook@archiver.kernel.org>; Tue, 11 Oct 2022 11:25:10 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web09.6201.1665487503741695776
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 04:25:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=IViHpjAy;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id
 n18-20020a17090ade9200b0020b0012097cso1384552pjv.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 04:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rgA1jhVN9l06cnJBcivdTWwOtXJmaCAGGEMei/Ub3Ao=;
        b=IViHpjAytaWNzFW7Q1A0DTwAU4hvFD2tiZRfMqDUD0UNWKUYjApDSwwUQHxnOPQ2Om
         LB+DohulKFGdnOolWLIDpZKljYtwfxFMvVzc09Pa+h6CtjPaEo5+njFrV3QObMWi+SlD
         WnKS/nr2Cdt/yCHkBIkf/0c+pLagCF5IvwdVN7we/+tI3gpNuPdEFIUaZfOscluHCDoo
         hPjtj5k6brJyeX05GAccUVVTOh44JYk7ZhwYaDEwEZzsjVP5Zu1Ui9CvdA3q+00Tyyxz
         kWfy8U6BkZD5lEqBIj6dSdoQ/uq9+W5TsmWLUj+oLxm3pX3PTk/UZH3vN/goxZOxHKIk
         alcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgA1jhVN9l06cnJBcivdTWwOtXJmaCAGGEMei/Ub3Ao=;
        b=Y6md8bhqXEGtc1g5t2ncWvH+GZlAZSLzvvn92StR7mZSYt+hKK+mE0DZFkU1ltByZp
         kz0R1bR3YrHRoZTmNRsZffAOyCdVXgw/QPxBtQYPTzxjbtcmKrALzUnnBemaV6oLrW0A
         5xkG50wwEO+nLjVAuJvlW0S8gF81Ch1EwlZaS5YpxDwSlHdPzRY3lKhxrYecEETTTzof
         Od3p0tXauqAABxRbUSU4pVpLxyeAepzgR/lCvAu3rbSA5Ok+1IokwIcOBt2j7UlQ+fk2
         gQAYGSrW+5rYocuCQJwvKEtG7nqnxpjFZh7IIpmzl0oW4zy1i29jopGmAzDITUa1oFpt
         6GVA==
X-Gm-Message-State: ACrzQf3ULWAwULJ1dFje5iqzmIZP2FAGgDF/gcRKGrEE8qhEMipDvLl7
	JOhSMgLr2p1qy5dQ7YuM1rF5QqJNrhzlhmyAbxM=
X-Google-Smtp-Source: 
 AMsMyM43ibvWTxOkcuPpCKuNS8VTeGdlxEo3h0Twyrx6rR16BQIP7wW5XsnvP4wsJxX/2Esxy475XQ==
X-Received: by 2002:a17:902:ef96:b0:17e:e7f3:31db with SMTP id
 iz22-20020a170902ef9600b0017ee7f331dbmr23715733plb.127.1665487502783;
        Tue, 11 Oct 2022 04:25:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 l12-20020a170903244c00b00174fa8cbf31sm8354545pls.303.2022.10.11.04.25.02
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 04:25:02 -0700 (PDT)
Message-ID: <6345528e.170a0220.1d8c9.e5a4@mx.google.com>
Date: Tue, 11 Oct 2022 04:25:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.145-cip17-1-g92b5279a8e1f
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 5 runs,
 3 regressions (v5.10.145-cip17-1-g92b5279a8e1f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 11:25:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9713

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 5 runs, 3 regre=
ssions (v5.10.145-cip17-1-g92b5279a8e1f)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.145-cip17-1-g92b5279a8e1f/plan/kselftest-=
lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.145-cip17-1-g92b5279a8e1f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      92b5279a8e1f1dd8189276753604ca74c0f32a76 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63453d7df2b789c308cab666

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-1-g92b5279a8e1f/x86_64/x86_64_defconfig+x86-ch=
romebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005-=
rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-1-g92b5279a8e1f/x86_64/x86_64_defconfig+x86-ch=
romebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005-=
rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/63453d7df2b789c308cab66c
        failing since 108 days (last pass: v5.10.118-465-g0af29783a3c9, fir=
st fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63453d68f2b789c308cab5ee

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-1-g92b5279a8e1f/x86_64/x86_64_defconfig+x86-ch=
romebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grunt.=
txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-1-g92b5279a8e1f/x86_64/x86_64_defconfig+x86-ch=
romebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grunt.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/63453d68f2b789c308cab5f4
        failing since 108 days (last pass: v5.10.118-465-g0af29783a3c9, fir=
st fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/634540ff5653df08e0cab5f0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-1-g92b5279a8e1f/arm64/defconfig+kselftest/gcc-=
10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-1-g92b5279a8e1f/arm64/defconfig+kselftest/gcc-=
10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/634540ff5653df=
08e0cab5f1
        new failure (last pass: v5.10.145-cip17-192-gbe875d9d93504) =

 =20

