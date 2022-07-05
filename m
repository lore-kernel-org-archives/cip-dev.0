Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386F0CCA481
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 03:04:45 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web12.80079.1656990282547881682
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 20:04:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=ATtz2r0A;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.177,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f177.google.com with SMTP id 145so10243509pga.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 20:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=DpGKQmDSHYVjGJrJ1jsutDeuEd6NRLt4MJgeBfEGdpc=;
        b=ATtz2r0Aa+A543dbyoASHaHZl8exjk7thnqNRfMuAsIzu/RgE/UxrxyVpIBVmNL/UC
         Qfttwg7ooLXiuEHjJD8PkvQK8qCQ47FlLBsy5zaRPTCkMC+vugbP9CUUTyMfjrHrV2UW
         epGcH0/ywJRqyKs7/PhXGlE2eFkadq44lthxHOqdguoaM7PI/ylfqE4z6ysmoyfcRjGP
         3oVroyOoaVgxWOjcQMrNOX+ujduJHE8zh2H8bn2tX0b8OBzsFldZX8BU2pjmDy8Q+5VU
         9mLleO2Gr+g+d+Mm4fPTCfcXq8k2raloM53cXuOZzRfzsW4kQtbnZsyANk2QJ++Vi62Q
         7WPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=DpGKQmDSHYVjGJrJ1jsutDeuEd6NRLt4MJgeBfEGdpc=;
        b=cwoVhdExIcKjY9bcOIzPYPubrQA+tF02my7gO2fOLMOeCdjuzzb4EINCHGDAtqa2tx
         RWtLs63fwXQfL8aTIF1An6k54DUhxhbbTfVaZWQo7H4hNhe8ny9oTNKykq5kzM4W27t+
         iO7SwR7xIS1GlqzNDG4xjxUml/7nnOTCoWeaiQOSA1EynQwant2Hh3FD/n1pOUitL+u2
         ilmqHHw1aaei3etvYNaC/iBy97QirIT1g/d4MwnKOq0KbZfkn+aunyreZR86y4+dUFqo
         6gqxJiOyUSZ92L/u6qLgc5/838o9ZfF6Vkt5tOeEdZDf/39oqnf7+3ITBHW21zyIYA9O
         vXgA==
X-Gm-Message-State: AJIora+6iHbTI+CnY3oEfI0m65SMiGG92GJlN8EVb/SsMH8AQOCy0/Ag
	aYKac1M8yFZ1+iA8do+6OjfQ0BbDmUo5hZVV
X-Google-Smtp-Source: 
 AGRyM1t+ja6gikB4xXPpiGpkCRtMRGLkRGGdYxfKcCju0mbS9v5XPppLEFzm6DN1E8dv2gAWBvhQbg==
X-Received: by 2002:a05:6a00:9a2:b0:505:974f:9fd6 with SMTP id
 u34-20020a056a0009a200b00505974f9fd6mr39916027pfg.12.1656990281786;
        Mon, 04 Jul 2022 20:04:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 y15-20020a17090a600f00b001ef8ac4c681sm2788468pji.0.2022.07.04.20.04.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 20:04:41 -0700 (PDT)
Message-ID: <62c3aa49.1c69fb81.12f7f.43bb@mx.google.com>
Date: Mon, 04 Jul 2022 20:04:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.125-cip10-119-g603acbe1aceb
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 8 runs,
 1 regressions (v5.10.125-cip10-119-g603acbe1aceb)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 03:04:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8658

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 8 runs, 1 reg=
ressions (v5.10.125-cip10-119-g603acbe1aceb)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.125-cip10-119-g603acbe1aceb/plan/kselftes=
t-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.125-cip10-119-g603acbe1aceb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      603acbe1acebe85cab7f594d9952a493be976262 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62c39c66a05c56480ca39be8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-119-g603acbe1aceb/arm64/defconfig+kselftest/gc=
c-10/lab-baylibre/kselftest-seccomp-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-119-g603acbe1aceb/arm64/defconfig+kselftest/gc=
c-10/lab-baylibre/kselftest-seccomp-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/62c39c66a05c=
56480ca39be9
        failing since 7 days (last pass: v5.10.118-465-g0af29783a3c9, first=
 fail: v5.10.121-cip9-287-ge9094c8446fc) =

 =20

