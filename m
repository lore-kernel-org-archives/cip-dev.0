Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB6CC25B0E
	for <webhook@archiver.kernel.org>; Tue, 16 Aug 2022 22:42:21 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web12.22232.1660689736481093845
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 Aug 2022 15:42:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=hBzVnTQI;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id c24so10500605pgg.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 Aug 2022 15:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=hHGKSaz4eeowR+98Eet91gDaSPWiszS33xWebtWrATc=;
        b=hBzVnTQIUSGeZ4xqZlKvHRCGsyAAr2xbY10WCR2xwNfO2BRgwjYWDNFoxSniQARvJG
         u3Xcedw3fPlBbFDgEExwuMzon8zOsNRRy6akZC9sMaFMsXY+ARaJxtpyqpjNawkHTsa6
         fUCrNhfeJYzASkl2KAyyyQaUkImHLyryiLjaFsqRdCR015IcXggOBgWIUlrJuyRuV8Mx
         Nn9GItY2buz/ZGk2MlRs4SYqBHe3aHRfjl7sb4H8VvSqeaiRTIwXzKq6jBduebDp+NUF
         GzoNWXmoZDD0gGqnTFl0lJpKJQ1SW0A+XkShfVcMprxaEDnOco1GgQIxAzYXEzEzO6FI
         8ddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=hHGKSaz4eeowR+98Eet91gDaSPWiszS33xWebtWrATc=;
        b=zAxjsttDJSQhzcl7ANmfe1JmMoSNlx7Hd3saYyCShIsPf6SfVLuHdvvvwcmQbX0Hg0
         Qlx6dDtvIuV+sbMUXn4ygvdLU/SaEizV3JBixC2s0aG4GBMmEJknptMeqFoQ598cEWUr
         9aYOOoUkhzUJ83PXhItiIYuB2WFyF5F3ZRRll0ZxX7XxGz0f5I4cjNabxqk12osbL1RJ
         KjOdMXpAwgwud6f8JWGgRkkgb1+d4uzKYr8sGjpwaaDE/bTvxlQ1wzkvcdPa4nTNUyc9
         pNCI1R0PVZOqtt3Io4+2fPSb2LF+8q7CdgDA9SS2deGMVA6Wb40HkgGYLq5if93Ilr3s
         Vyag==
X-Gm-Message-State: ACgBeo1XAMMiz3/JkcBzwtNcVWyyu1GgE7f7anavfugpDI3kV2AtPWGY
	+m2RUXsI7T2AE56/PXActxHcQF/pUB5oDNRg
X-Google-Smtp-Source: 
 AA6agR41PIB6Z3Q+URBoI5Wiyxcrci/e7y9QVXfOyUeH7kzOIPWSN9G/QhMVmdEPM8j9Wsyce3Eu+g==
X-Received: by 2002:a63:f941:0:b0:41b:ff8a:df69 with SMTP id
 q1-20020a63f941000000b0041bff8adf69mr19480619pgk.554.1660689735672;
        Tue, 16 Aug 2022 15:42:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 m18-20020a170902bb9200b0016dc44459a8sm9583458pls.12.2022.08.16.15.42.14
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 15:42:15 -0700 (PDT)
Message-ID: <62fc1d47.170a0220.3e7e3.0eaf@mx.google.com>
Date: Tue, 16 Aug 2022 15:42:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-49-g1145e9c6352e6
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 34 runs,
 3 regressions (v5.10.131-cip13-49-g1145e9c6352e6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Aug 2022 22:42:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9255

cip-gitlab/ci/pavel/linux-test baseline-nfs: 34 runs, 3 regressions (v5.10.=
131-cip13-49-g1145e9c6352e6)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
imx6q-udoo                   | arm   | lab-broonie  | gcc-10   | imx_v6_v7_=
defconfig | 1          =

imx6q-udoo                   | arm   | lab-broonie  | gcc-10   | multi_v7_d=
efconfig  | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
          | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.131-cip13-49-g1145e9c6352e6/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.131-cip13-49-g1145e9c6352e6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1145e9c6352e68c31b58d1035f4f1ff07b2f9c89 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
imx6q-udoo                   | arm   | lab-broonie  | gcc-10   | imx_v6_v7_=
defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62fc17e737e46866b935564c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-49-g1145e9c6352e6/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-49-g1145e9c6352e6/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220812.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62fc17e737e46866b=
935564d
        new failure (last pass: v4.4-st20-96-g74ff989472f09) =

 =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
imx6q-udoo                   | arm   | lab-broonie  | gcc-10   | multi_v7_d=
efconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/62fc193b65c657d666355674

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-49-g1145e9c6352e6/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-49-g1145e9c6352e6/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220812.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62fc193b65c657d66=
6355675
        failing since 4 days (last pass: v4.4-st20-96-g74ff989472f09, first=
 fail: v5.10.131-cip13-35-gab58aa0904675) =

 =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/62fc16317838b19fde355647

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-49-g1145e9c6352e6/arm64/defconfig/gcc-10/lab-baylibre/base=
line-nfs-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-49-g1145e9c6352e6/arm64/defconfig/gcc-10/lab-baylibre/base=
line-nfs-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220812.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62fc16317838b19fd=
e355648
        failing since 12 days (last pass: v5.10.112-cip6, first fail: v5.10=
.131-cip13-24-ga6f4ea41fe167) =

 =20

