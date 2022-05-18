X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.257.1652899230550402164
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 May 2022 11:40:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Do7kbLY9;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id l14so2913208pjk.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 May 2022 11:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=hyrfNhooFrWygy15jNkqBwGEHF/aHKcDkhLP5uXYZvo=;
        b=Do7kbLY9HCmBMdv+Nwnk68WFa6aaftpiU/YzSQ3zwd9knTBRyMerguGjPEC0isRmRx
         ffScc/hsw4/r5vEaH+EZ9ayjblcfSG0liUs2Ju6m5gG+foedhzk0MJx1ursBeRXs4P7m
         DIfPtdcK73blQWDMBPFEQ/xC6F3ZaARMO4nRI5He9RibupKg29Ga2SLU2Ea+9QWS5Eo2
         gaawCTjkWGRAXhACAka/jityrPCX3X9DFY/SGAmhGR5IJco/rxoKBdNEO6UNxecOAPk2
         4EKpY0Yvhf4JZ+KIF5jGeKflMI17dIZC8ZiqAJ/1sXZaM2g+uBqBImW6Q+KeCWy4TUo7
         9Raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=hyrfNhooFrWygy15jNkqBwGEHF/aHKcDkhLP5uXYZvo=;
        b=CX0rxgQflLAuDOt32XcznsFOlbNVmTtf3DPKShxifau28bDIKtG/4b6cK9Y3kEG6wQ
         afZVR5y0bKCEYXPATkdJD4rZnD1UINtisThGif2ltbnkxClc106lYi1iBwGRa/D6K5jZ
         5N28u7RGoeB25kf20q6suOygtuGV34LM7qGlefVKREkkuRI48Z7nD7JOQDUq5XPEfH21
         INzDisuxP0ptpDcN3gspq+gyoCEpaOqRx+OsN8li91+medYXoFT4+v9anxK+zFjeH997
         YPPW1XhkwUA/NxpFqzIgF7vBh7bALF7KSPZ8dIidoqdYBYmYqdbX2caQVvT6IBekay0G
         j/2g==
X-Gm-Message-State: AOAM532y55s/EhfgmlFQQaWF7zUWllgr1QVhHnMBDpi9E0V6Vbb7zh2P
	7of2Av1bbOfDtnfMYT8teJhyyM7xVNIku6N9fmk=
X-Google-Smtp-Source: ABdhPJz64m+cWLKE/gKPGCY0x6Ottxz0WIIvAvj9O5gI9Ydg1yTvFow92uObNo8/V0YZdoyNPszW9g==
X-Received: by 2002:a17:90b:2241:b0:1dc:d4d3:3047 with SMTP id hk1-20020a17090b224100b001dcd4d33047mr1415361pjb.128.1652899229813;
        Wed, 18 May 2022 11:40:29 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t12-20020a1709027fcc00b0015e8d4eb234sm2034351plb.126.2022.05.18.11.40.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 11:40:29 -0700 (PDT)
Message-ID: <62853d9d.1c69fb81.29b52.4bc1@mx.google.com>
Date: Wed, 18 May 2022 11:40:29 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.242-cip73-50-gd57bc44cb340
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 19 runs, 2 regressions (v4.19.242-cip73-50-gd57bc44cb340) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 19 runs, 2 regress=
ions (v4.19.242-cip73-50-gd57bc44cb340)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.242-cip73-50-gd57bc44cb340/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.242-cip73-50-gd57bc44cb340
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d57bc44cb3404e87a6fb3a587e605ae5d62017d9 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/628531934d8e33cbada39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.242-cip73-50-gd57bc44cb340/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.242-cip73-50-gd57bc44cb340/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/628531934d8e33cba=
da39bce
        new failure (last pass: v4.19.239-cip72-68-g407458469172) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62853a19e57a788c03a39bdb

  Results:     82 PASS, 6 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.242-cip73-50-gd57bc44cb340/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.242-cip73-50-gd57bc44cb340/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/62853a19e57a788c03a39c01
        failing since 65 days (last pass: v4.19.229-cip67-111-g5c3c0b39cf3b=
, first fail: v4.19.231-cip68-123-g92e3e7f3d4df)

    2022-05-18T18:25:11.799457  <8>[   37.935756] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-05-18T18:25:12.829083  /lava-6416648/1/../bin/lava-test-case
    2022-05-18T18:25:12.858306  <8>[   38.995377] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

