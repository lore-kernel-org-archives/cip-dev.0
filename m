X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.32771.1650907405403206788
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Apr 2022 10:23:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=EdA4RH+P;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so9057823pjn.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 25 Apr 2022 10:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=1XX18jvF47gfVMlZZ6bkyZMj7ry73MvYYw5ic4mNbFw=;
        b=EdA4RH+PGMfx8P9RTarIqpzUA5ZC3MB1RmDPPaCMGyn7cP+pTlrioyiiwEajklc2ZQ
         +dPGHeuo3nnIT5YTlrc32ntS/Q+C9bHg1H63zvmePGKAsS1H2kzxKpa33pTq3tKzfiq7
         /ifGosyWnOqIPvJ2PCVKmqbVLdhuWtVQpW1mmECNsmk6vw0Zcnvmv+DXZQvCMqdFREv3
         ofkrhzVU7mGsiCGyKnDmOKm0Plrbav5Zx9hmVqxsjipTYauOuOxqH4Rz1HJteelXAspT
         GDqiyQv6xUsCI94FyW/pRTFooi//kuSPSdXnxrPgtvpGWqbKOGdpRSjLX1ULaKczOeFr
         T+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=1XX18jvF47gfVMlZZ6bkyZMj7ry73MvYYw5ic4mNbFw=;
        b=ZA6bEYgFe50AU6m6BY4ee/C/TxuS36hHhq4P4d0VSIk08Zezkgh86WJ5CUtMacNG5J
         tVO7fjU5hcjN74MdaNoDf3gXRQnyOosKuxAlRlBz2S1jKw/aX9xb14mWxDxfYAmHc0Ba
         M+E8uOFH8UB6jOpkkdOr7Y58XsZgs7Y9W/o+J0QL0QXZUf7M2wdFMtSSC0x7JW0JgqF3
         xIwCjM7K1Lyvt376DVhByNkIn0Hcmf6p0KglTAOkzjFBs55NF1JEr/ZxPrCK5I5p9+vu
         svYdiWb6Wq7MlQ+bkTun6ibAsfdrlJjcRXPq1pwb5x0G90+2t3PAHg+DfN61LCU6350v
         599A==
X-Gm-Message-State: AOAM530m4FBUbKCH2s58ijrt4V9ozigwlTt7zVaB8pMJmN19b/jagOLm
	3fyM+w2UWwdW1czQ0rQgAQwmjAx6UfKjqyVxYsQ=
X-Google-Smtp-Source: ABdhPJxEOALSKcK9Bkf0Pn6hGJ6b1/JZbSC2YrD9AF7/SX7MrCbMdB/uBbbkWuwhiV9MXpVKl7p1Ag==
X-Received: by 2002:a17:90a:a081:b0:1d8:de21:1714 with SMTP id r1-20020a17090aa08100b001d8de211714mr17259215pjp.147.1650907404677;
        Mon, 25 Apr 2022 10:23:24 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b11-20020a621b0b000000b00505c6892effsm11822924pfb.26.2022.04.25.10.23.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:23:24 -0700 (PDT)
Message-ID: <6266d90c.1c69fb81.3e434.c575@mx.google.com>
Date: Mon, 25 Apr 2022 10:23:24 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.109-cip5-899-g234e7e7d5bd3
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 98 runs, 1 regressions (v5.10.109-cip5-899-g234e7e7d5bd3) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 98 runs, 1 regressions=
 (v5.10.109-cip5-899-g234e7e7d5bd3)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.109-cip5-899-g234e7e7d5bd3/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.109-cip5-899-g234e7e7d5bd3
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      234e7e7d5bd36004288823dfb36ce5e3d2f6e940 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6266d27d418093f3a2ff945c

  Results:     90 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-899-g234e7e7d5bd3/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-899-g234e7e7d5bd3/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220422.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/6266d27d418093f3a2ff9484
        failing since 47 days (last pass: v5.10.100-cip2-319-gcbff87047566,=
 first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-04-25T16:55:08.115600  /lava-6173335/1/../bin/lava-test-case   =

 =20

