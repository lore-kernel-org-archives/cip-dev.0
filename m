X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web08.4843.1648549213652651724
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 29 Mar 2022 03:20:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=FrLVO0pG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id mr5-20020a17090b238500b001c67366ae93so1615244pjb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 29 Mar 2022 03:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=X5ZXS05hfmRamBVdyJRwq5y/wjxVEtnFnd4QkJVx8Yw=;
        b=FrLVO0pG0CrCVMgGaB4ljpHZTUctGfOr7TwLg4PHjI4wuhmUE0J39eSNI6VHytRTAR
         6yZR9eLr3zU+c1CkqmIlvCZEhinx+Gj2hojWkSnX0Q1VLgj3Ro/BhvQKIA74A4hJLQom
         KTNSh+BlJEJimjSEesIo2X5b6aYIICZiraVDMCcIxwKM2rFZmFGUkql5MVlYUxS9GGCC
         ZsZbtSXGZyvuvaYw5Y5DXEc1NMC/Ret1eDwnSGyw9FV/pFs4QkLg0ot1w6w9WKlPm8qX
         ls3PKyigQX11M9vUmGFqNG6r7iMhiqOjTPsMmrWSBgXhKtgS3F9jYtYjMJAfowXUPOVS
         /pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=X5ZXS05hfmRamBVdyJRwq5y/wjxVEtnFnd4QkJVx8Yw=;
        b=646sGkT539UZKd7cA+ZhLxRLP/b/IbQuc9A6DOoMVx2pYRC+4OlyXMvpffmAKepyQd
         hHpGt1pmSdNheHHi117MGhFlbYYqj66dENOqcZ0yYl0PkB8IvhNcvL/NJBQm/PwT5Rds
         78Tyv/U+XJpxDhJSqwTQ9E7V9vMxlqK6qcHYgTb5NGjx0fIzf+m4U1uLhFkxyzg9c8YG
         kPI5nxXlpMUunzA8G3WYdqbDnpZ+8bTn0mo1tndCWkSE5051UlwCiX2xWJRD1kDDXEjE
         8weBBGQDmALR9DMpDq2EovzBVrVU25uzqMcS8kraoP4Dnw8vkH9hAaKghUcmmDVg2HTf
         aDcQ==
X-Gm-Message-State: AOAM530y8hy9tyhgCEw0sTW8wjhgqyS2RfkDbJMqFPVrhVOQvHEEDrDk
	sN3MvnWYKhpqQv4u0p3Jdl4A9+3KvOPBLWcLpK0=
X-Google-Smtp-Source: ABdhPJwuI88lOrdqhQLxC35FA+1r2Grt99gLFz4ZKHAAdyHDsjxGrIInYpH7zilYH8fG0lD1ldrYBg==
X-Received: by 2002:a17:902:ca0b:b0:153:b9f5:83b6 with SMTP id w11-20020a170902ca0b00b00153b9f583b6mr30489209pld.166.1648549212900;
        Tue, 29 Mar 2022 03:20:12 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7982d000000b004fb199b9c7dsm15079743pfl.119.2022.03.29.03.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 03:20:12 -0700 (PDT)
Message-ID: <6242dd5c.1c69fb81.9eefe.432c@mx.google.com>
Date: Tue, 29 Mar 2022 03:20:12 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.235-cip70
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip baseline: 86 runs, 1 regressions (v4.19.235-cip70) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.19.y-cip baseline: 86 runs, 1 regressions (v4.19.235-cip70)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.235-cip70/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.235-cip70
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      91567a6adc2cb5217b6d7aabf7da3ac9ae6f1a79 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6242d681606a2910b1ae067c

  Results:     83 PASS, 7 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.235=
-cip70/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.235=
-cip70/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/6242d681606a2910b1ae069e
        new failure (last pass: v4.19.229-cip67)

    2022-03-29T09:50:50.951167  /lava-5968679/1/../bin/lava-test-case
    2022-03-29T09:50:50.959880  <8>[   36.756488] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

