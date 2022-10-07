Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486FFC4332F
	for <webhook@archiver.kernel.org>; Fri,  7 Oct 2022 11:07:44 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web09.3169.1665140858633870155
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 07 Oct 2022 04:07:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=lkAS3xF4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id 3so3059877pfw.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 07 Oct 2022 04:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h+D3UwrCX3sn+pxjH7T5SZWlzpQ7tjcmlB0KXOC/VPo=;
        b=lkAS3xF4xBDdjDg9lYxIeMZYwXzaYHiQ42Mp05y0vDcTRY85IP+/w81zxLwcvo35+g
         tnR45+8Ypyz8OUxKRRXpA9Yp+/1prZEkrBzfVwOVRYcwWtfiUAARKgZTWb9eI0nTqN5l
         Cytc0qp2fCD/hsqLgF7OCfLJh/c7jRR9pIlIiy/lSZo5Gjea6sNm1To+Mr5do91M9FR4
         sJdTJ9Y7XGPmDwZuXsNKUY4+cBlX+jPwZN2LHmtX9ZiDKwV7vaVPt8i56kjmX40xfVuG
         w/SZaOkxt5cIjzNSMLn0Eu0o5FjFNjzRYElPpqrlqE5pjPBMtl42cQNjC1r8Cc/JscFJ
         FKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+D3UwrCX3sn+pxjH7T5SZWlzpQ7tjcmlB0KXOC/VPo=;
        b=YDliSAJ1SxyJAiTIBpD6iS0OA439OLDBEBSOEt6M3xSlLvF26tRgpcyJAkWKQT1ugK
         CoAslvjzRbBGJviIKLgNOCx4MEpEiymP8M3d1Ox68dM4RgympFex9syBP917ZnO8S6NN
         YoJEJdQsKEbbQMNyB21+BVcnEOrkPiLE0iZmhStMuE8hGZm0pvuS54ScKHHJmKJi3zCL
         TOY9W+IRvwWYkOlTbKoSdJ+YMoTPAlNmqoQBLNFOWHB8alyUEU/HI7xB6uJX/n6iBPjo
         /0LbRtKaaPhc8vWI5Ta3h6HYzKUfefxvZg8+s5Bp/jwPbrURLDeSKhCMg1yonNLL9BIU
         o74g==
X-Gm-Message-State: ACrzQf1Iwt3lpv54UlEm1ch+tN03uBHA9YeaXqlrRGUWLuKhxuTJ2DRs
	2Fxl4ARwglskI9trKIgt3rABdePuD+z4bu1Et/s=
X-Google-Smtp-Source: 
 AMsMyM4LzVOxYDGbTXfafejhpQuN6nJnGhvx6amwirFKx8XX91ErJ+W56025cNK+JjM5Seo22ppPZw==
X-Received: by 2002:a05:6a00:234d:b0:561:ec04:e77e with SMTP id
 j13-20020a056a00234d00b00561ec04e77emr4774460pfj.14.1665140857890;
        Fri, 07 Oct 2022 04:07:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 h131-20020a628389000000b00562641bc0b5sm1324418pfe.132.2022.10.07.04.07.37
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 04:07:37 -0700 (PDT)
Message-ID: <63400879.620a0220.3664d.23b2@mx.google.com>
Date: Fri, 07 Oct 2022 04:07:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.145-cip17-rt7
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 72 runs,
 3 regressions (v5.10.145-cip17-rt7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Oct 2022 11:07:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9680

cip-gitlab/ci/pavel/linux-test baseline: 72 runs, 3 regressions (v5.10.145-=
cip17-rt7)

Regressions Summary
-------------------

platform      | arch  | lab         | compiler | defconfig                 =
 | regressions
--------------+-------+-------------+----------+---------------------------=
-+------------
imx6dl-udoo   | arm   | lab-broonie | gcc-10   | imx_v6_v7_defconfig       =
 | 1          =

zynqmp-zcu102 | arm64 | lab-cip     | gcc-10   | defconfig                 =
 | 1          =

zynqmp-zcu102 | arm64 | lab-cip     | gcc-10   | defconfig+arm64-chromebook=
 | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.145-cip17-rt7/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.145-cip17-rt7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      411cd76b5afe81569858976d0e9819ab48717fcb =



Test Regressions
---------------- =



platform      | arch  | lab         | compiler | defconfig                 =
 | regressions
--------------+-------+-------------+----------+---------------------------=
-+------------
imx6dl-udoo   | arm   | lab-broonie | gcc-10   | imx_v6_v7_defconfig       =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/633fffd0cf2378fee7cab5ee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-rt7/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-im=
x6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-rt7/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-im=
x6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/633fffd0cf2378fee7cab=
5ef
        failing since 2 days (last pass: v4.4.302-cip70-98-gb2bfffe124dae, =
first fail: v5.10.145-cip17-421-g0d804ef4a611) =

 =



platform      | arch  | lab         | compiler | defconfig                 =
 | regressions
--------------+-------+-------------+----------+---------------------------=
-+------------
zynqmp-zcu102 | arm64 | lab-cip     | gcc-10   | defconfig                 =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/633fff9fcedccfa7a7cab5fd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-rt7/arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.=
txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-rt7/arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/633fff9fcedccfa7a7cab=
5fe
        failing since 149 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform      | arch  | lab         | compiler | defconfig                 =
 | regressions
--------------+-------+-------------+----------+---------------------------=
-+------------
zynqmp-zcu102 | arm64 | lab-cip     | gcc-10   | defconfig+arm64-chromebook=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/634001bb0c4af9183fcab601

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-rt7/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-rt7/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/634001bb0c4af9183fcab=
602
        failing since 149 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a) =

 =20

