X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web10.1730.1652906475234759096
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 May 2022 13:41:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=7QZqyF8V;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id oe17-20020a17090b395100b001df77d29587so6744155pjb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 May 2022 13:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=esm2exIPxEibblzxcHteYdwl1uykYoQxgoJJ4KVkH8k=;
        b=7QZqyF8Vmgfl3d+LJgKT8bZ0SeiXzDiItDoYsQSZ34zU6bw7eSN9pj5NCd4Uis6zUT
         qfHvl+zIS3YKfYZc5ALjRXuMS1DqOgqQM8pBa2P3qC5aUwv40nkD/a62FUSI5bXXU+O3
         PxZE5o5ihP29l0qe39uWi1B86EQZqLxGEeADbDdvqLewyqNVy6biJY/SdSrV3mf0WfLF
         7uC2XIpLa/WZT4TIqJnWn0EVenfOpTtT4LFvBzIfNdSJrsjkbmmPLR1+4MaTVQArssEU
         1hMDf2kXl0FLnj2bG7ZJyxvEY94mVhNd+BYP4+HoHdb6rxZZMjnO+/bMf+bVEq/ZjNlw
         EoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=esm2exIPxEibblzxcHteYdwl1uykYoQxgoJJ4KVkH8k=;
        b=lK/UYioH/lrCVjh+9JwpL7hMiE0q0e0CMNG6ek6fgKGhtlutZ8w0sUDn35ZcRsmjIf
         Yjes137yGnQsjgB88VJZVq436nUoOPkLVBM2uVVS9Ri5JVM70D+O6vYgzyLmjtviqMQL
         Ayr9cVOhVy2YHyPg7Zces3hy5tGHK+0EQpOl4WSjFxI/EU6QRhtMIywrJfRBQNYsTRDz
         rQtC4gvvB+DLQ/Z0ok9vRpo3mReC4Z4mmF+uE1HXMp4K0siQlHevNEgaIgyVSfVtPf7q
         L7bLfUftLpPZP9ovRpy0lSPotbD2U40wqfIPZfMnIRkm1BI7M2oc/Yvm8weodKcLYREE
         UyJA==
X-Gm-Message-State: AOAM531+9zaZbCBTI747yNC3m96JRRJiC5N08pZ/uX58+0J6C8ZJ0LG/
	mWrtsxlxZISof5kbrNUbAdJ96szIxya40satJIQ=
X-Google-Smtp-Source: ABdhPJwTNUtMPEufuBH2bjLQMepUIxx2e2r0Djgemqz9ESi14G17AIas2PSKu7jB2E5OPhaj5HeMdA==
X-Received: by 2002:a17:90b:3b90:b0:1df:c9d1:beb0 with SMTP id pc16-20020a17090b3b9000b001dfc9d1beb0mr1611830pjb.188.1652906474650;
        Wed, 18 May 2022 13:41:14 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p2-20020a62d002000000b0050dc7628153sm2379829pfg.45.2022.05.18.13.41.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:41:13 -0700 (PDT)
Message-ID: <628559e9.1c69fb81.c7dec.5bdd@mx.google.com>
Date: Wed, 18 May 2022 13:41:13 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.115-cip7-81-gd05f72e501084
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 9 runs, 1 regressions (v5.10.115-cip7-81-gd05f72e501084) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 9 runs, 1 regre=
ssions (v5.10.115-cip7-81-gd05f72e501084)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.115-cip7-81-gd05f72e501084/plan/kselftest=
-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.115-cip7-81-gd05f72e501084
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d05f72e501084803c8658a71668fc1aadb075165 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/628549a622fad9f6eca39be6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.115-cip7-81-gd05f72e501084/arm64/defconfig/gcc-10/lab-ba=
ylibre/kselftest-futex-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.115-cip7-81-gd05f72e501084/arm64/defconfig/gcc-10/lab-ba=
ylibre/kselftest-futex-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220513.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/628549a622fad9=
f6eca39be7
        failing since 6 days (last pass: v5.10.112-cip6-218-g8253434cd56a, =
first fail: v5.10.112-cip6-289-g2969e096d186) =

 =20

