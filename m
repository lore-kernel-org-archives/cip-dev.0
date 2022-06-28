Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907ADC43334
	for <webhook@archiver.kernel.org>; Tue, 28 Jun 2022 00:09:31 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web09.49451.1656374962390359472
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 27 Jun 2022 17:09:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=u3dFcR55;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.171,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f171.google.com with SMTP id 23so10559289pgc.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 27 Jun 2022 17:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=i5pMVQCIUDdu/jaUF3BPIxX/Od/FgfcapxIdWoTAA6E=;
        b=u3dFcR55EueMXitFW4ObW32dAG62Mht/6+hujD8cmOB+garA6Z/4cM1WoK5Zd2TPJS
         bFFd8FV8wnwh+CEC8h+eU7uymmZa/FiFngrqZkWwipWnY3WhU5A4vIdYCNqEOAXsk+K4
         09vfXSXXxSaA5wuAbcAVjspIHKoI2oiHDsj+UkWMhUAaGSfy1QxnvV9FVUdzJzGaN84S
         mQvo3pBx70lmtUnC+fwgw1KYZvpZuQbgHwtfohrz/xrXCwZjwgifQkeuZbAvtWhbBo3K
         YwhnL4xek0lSHZN7UCO3PmKZuDmOsE/XgFCuxhMe8zkr7T/3uJKlBErl0+F8RTrlgtFo
         mLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=i5pMVQCIUDdu/jaUF3BPIxX/Od/FgfcapxIdWoTAA6E=;
        b=2crHMU6+xiNqx+aniyVF+DgOWIBatuyOOckmSpawJksVy+f9MOHEzUKRbwDu22QD98
         AMAgIQre+J4NeDq9J9CuFplxXj3IuyM8C8ZjWrK4RB7lj8geBbSkkcVGPigT/PmkTqRJ
         Ee2+62nrN1MwzqojK4RNiKrqkC1Piyja8RH1gdB79GwiMDO+D2Clgk+IuAs8yB6+MGYH
         2YO1v4Q+pXGoVZqPgZixDaUYonxJ88S9LWjlUYcuCnR89wTENS3lezhtB0m6OdFMDDB6
         OXePXrTQnP6W1qs4e9yqeTX1B/RsBobt8Wc8MTednnWbaQNjmJ0tpoXeaPxfIbBm9vh9
         x37Q==
X-Gm-Message-State: AJIora80EJoX15atj/PMAaK9b9n54Gw3JbI5XCSEHRNIooL3n5/4Tpco
	QN0/olLzG3WU0YbuSqC9OTOcxWnQ0CiLl+BA
X-Google-Smtp-Source: 
 AGRyM1ttU6O/TJ+kb8beDzfq8lQpQP0N5tvFe6jgx9UEPstaxhV5AWNz/2bD3fqQ5rlpAHIBKm8Gcg==
X-Received: by 2002:a05:6a00:2410:b0:522:9837:581f with SMTP id
 z16-20020a056a00241000b005229837581fmr1759180pfh.11.1656374961425;
        Mon, 27 Jun 2022 17:09:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 q14-20020a63d60e000000b0040cf5cd74cdsm7528675pgg.19.2022.06.27.17.09.20
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 17:09:20 -0700 (PDT)
Message-ID: <62ba46b0.1c69fb81.ef125.a4c4@mx.google.com>
Date: Mon, 27 Jun 2022 17:09:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.121-cip9-287-ge9094c8446fc
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 43 runs,
 3 regressions (v5.10.121-cip9-287-ge9094c8446fc)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jun 2022 00:09:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8609

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 43 runs, 3 regress=
ions (v5.10.121-cip9-287-ge9094c8446fc)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
bcm2711-rpi-4-b              | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.121-cip9-287-ge9094c8446fc/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.121-cip9-287-ge9094c8446fc
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e9094c8446fcef728d675699ced39be2dbbfb8f7 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
bcm2711-rpi-4-b              | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62ba3b8c9840faa6f8a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-287-ge9094c8446fc/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-nfs-bcm2711-rpi-4-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-287-ge9094c8446fc/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-nfs-bcm2711-rpi-4-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62ba3b8c9840faa6f=
8a39bce
        failing since 3 days (last pass: v5.10.118-465-g0af29783a3c9, first=
 fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62ba3d851fd544cc74a39c40

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-287-ge9094c8446fc/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-287-ge9094c8446fc/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62ba3d851fd544cc7=
4a39c41
        new failure (last pass: v5.10.121-cip9-272-g3fb28d4c623b) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ba35feecf8fd8d83a39bcd

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-287-ge9094c8446fc/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-287-ge9094c8446fc/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/62ba35feecf8fd8d83a39bf3
        failing since 110 days (last pass: v5.10.100-cip2-319-gcbff87047566=
, first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-06-27T22:57:46.370406  /lava-6691960/1/../bin/lava-test-case   =

 =20

