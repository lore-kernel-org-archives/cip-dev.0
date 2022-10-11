Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F61CC4332F
	for <webhook@archiver.kernel.org>; Tue, 11 Oct 2022 11:25:10 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web08.5928.1665487503986612810
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 04:25:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=zTrEs2jC;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id i6so7851099pli.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 04:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CVaZtZJ2IXa0sVPw80BaJfyuOKVnPeecjHO2y6twv0Y=;
        b=zTrEs2jCk5eP6YXxXmEapRtEMVOCjRuV0CJJdtvkjYHb3HL+IHAj49EdDvXk+uLJ3M
         +g/qChQRvOFLR8yZ08Lsl18anJVXyK9TXjFDk5TdAuz+Sur250t+ogbqtyGrPPXTfLR0
         8MbSjqcAywRZlRhVmEZylhQDXYxIsFGRYOzjOL6RKVuRs0XrYpXuZOCfqfinmfCx5zjg
         OHmu5OYZWIez5eB8GVJPZHdYVHSL5yUSDelbqxXbFnxR7aglC0yM18caNpz0W6XabpVk
         ZqReL8NxErM7NPTXhcPq4WgfbtLKZwMi3BE6dwh05Qf7lmfm/+x3hSiq0tTIMRZ6bEAq
         0mlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CVaZtZJ2IXa0sVPw80BaJfyuOKVnPeecjHO2y6twv0Y=;
        b=sl3t1ptGCLnzxC+Km9ZGcR2X8hBHGRVInClx1Kw4Z1zJl0rDC7Z8+fhvfY9YmBN1pO
         wPw+Dq4x/hlWASX29GdKd/ed3aqDh/AtFZ0gbj8zqJVi04UCQhsVXhsgCVOFZ9oXOnBR
         ieIEAZ2QbvrLpS93LgVemTB4Udl0oXpJLvrcegc3egyAC23iGV45Uc9laLUOGGjl+eSe
         lp6Z3FtZwANEqKV3cgU6MJh+xEvXUVCvZZknLEPwmIHTLU1yOvHuVxMI0p9kynESN3Vz
         aHuRlomNCRjCSRP1VyC4x4lOnA/tQi4GMtX35mZ2WRHgot7W+vZpCDShRCKy9T2z0/M0
         9ZlA==
X-Gm-Message-State: ACrzQf0YYyBrewhQqmovCvtsfwt/52m4YmOjt9XC9RtjcLIQY50CqXvd
	YJEjdxj8Vxi7kqZweaYh+u7N3fVUBUCb0k3KhzA=
X-Google-Smtp-Source: 
 AMsMyM6vL+jMGwf6y1f7Btm4uIxvPagqiZT7fQgUu44mGspwJEp+gnJu7exMRY8x8bneG2ycdEwzTA==
X-Received: by 2002:a17:90b:48c9:b0:20a:e225:1afd with SMTP id
 li9-20020a17090b48c900b0020ae2251afdmr36611045pjb.21.1665487503178;
        Tue, 11 Oct 2022 04:25:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 x6-20020a628606000000b005601e974993sm8775553pfd.25.2022.10.11.04.25.02
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 04:25:02 -0700 (PDT)
Message-ID: <6345528e.620a0220.d12d9.ecc4@mx.google.com>
Date: Tue, 11 Oct 2022 04:25:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.145-cip17-1-g92b5279a8e1f
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 8 runs,
 1 regressions (v5.10.145-cip17-1-g92b5279a8e1f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 11:25:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9714

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 8 runs, 1 reg=
ressions (v5.10.145-cip17-1-g92b5279a8e1f)

Regressions Summary
-------------------

platform         | arch | lab     | compiler | defconfig                   =
 | regressions
-----------------+------+---------+----------+-----------------------------=
-+------------
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.145-cip17-1-g92b5279a8e1f/plan/kselftest-=
seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.145-cip17-1-g92b5279a8e1f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      92b5279a8e1f1dd8189276753604ca74c0f32a76 =



Test Regressions
---------------- =



platform         | arch | lab     | compiler | defconfig                   =
 | regressions
-----------------+------+---------+----------+-----------------------------=
-+------------
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/63453f6e7a5ed8d027cab5f7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-1-g92b5279a8e1f/arm/multi_v7_defconfig+kselfte=
st/gcc-10/lab-cip/kselftest-seccomp-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-1-g92b5279a8e1f/arm/multi_v7_defconfig+kselfte=
st/gcc-10/lab-cip/kselftest-seccomp-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63453f6e7a5e=
d8d027cab5f8
        failing since 17 days (last pass: v5.10.138-cip15-90-gd4130d0ee3c7,=
 first fail: v5.10.140-cip16-261-g8fa62effa305f) =

 =20

