X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web11.6199.1651121163214699730
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 27 Apr 2022 21:46:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=pg4estR1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id bd19-20020a17090b0b9300b001d98af6dcd1so6659648pjb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 27 Apr 2022 21:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=9l7UMvybnnshyaGOSZSb50Ws7sRKmQDiWbAz5B+2S9w=;
        b=pg4estR1eoWz4RMnisH5H6+8SF6aWmdZtcVXEp+GyBgWjKixh4sy/6kxZVYHwrC67O
         tbP4jb+CVIhLTVrsgtPg633L6X0KEwLikxwOYMGnD/3juPUp8ZQ1ccI04oOP7exjkdNz
         BYbN8/J9wcR0NbmzV2jQ7MskkFMQbVDZlbMXBf81PDvmrG72GCfh31dfnmv+XGPn1Owf
         uRK7gawMALVnaDjNh/GceTsnDnXqAjZyQl2nYnmQ8zQaz0lg1ZZh3hgj56H6xYAs33RG
         uJhyWD1clXjvv9gH3av+weJPZIevYGBSohQogRp8G6hLj6xC7OoUr2kGn22soza43jUv
         g+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=9l7UMvybnnshyaGOSZSb50Ws7sRKmQDiWbAz5B+2S9w=;
        b=1jsXPQCClfnJyognrzeL5Y8bInsXwMp3ARXUnWisCRkv8x1kPANPT8M+WYH9HoerQz
         fq4eAyY4ajm1asBACFHnUdYIUfNnvwBjVFaxFqq+IkBbfKmrCdmQGUiuanT9HzTMNN0x
         oF8+IdJi/zfsx80HoW/68VPCf2e0vkrraK7JsgQnJruoSfOj4Pa3fAZDavvuDCJIsVCQ
         D6nmc0TotD8iQAiqmCoOmiSfANt61JIxCwuYquxyvl5tIRGRrxXxS4ECvkHL0I6sC9YZ
         EVavCBShMc1LSw4kp6ScM3FekaoTGuoC8KAuJoQP0Z0KLpXF5smo5SaJLdpHgwg62Sne
         o+0w==
X-Gm-Message-State: AOAM533tf0qdseH0Zt+jURPwvh8xs4gEPK3bvY4j/iRpG/3bD8Qg8cxP
	4UH8NRUNvsPCynGOYshFDnWOjDV3nwyAe2C9qTg=
X-Google-Smtp-Source: ABdhPJw2I/jBLQZ9foL92EhmRneVyYhU4xJuznwg89SlOY2gQI7nzdgT1KxOoUjcDM13Odme4vlxrA==
X-Received: by 2002:a17:90b:4c85:b0:1d4:bc0b:90eb with SMTP id my5-20020a17090b4c8500b001d4bc0b90ebmr36770889pjb.171.1651121162575;
        Wed, 27 Apr 2022 21:46:02 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090a734200b001cd4989febcsm8841146pjs.8.2022.04.27.21.46.01
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 21:46:01 -0700 (PDT)
Message-ID: <626a1c09.1c69fb81.e2b1b.593c@mx.google.com>
Date: Wed, 27 Apr 2022 21:46:01 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.112-cip6-88-gf3397cadb2dd6
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 109 runs, 1 regressions (v5.10.112-cip6-88-gf3397cadb2dd6) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 109 runs, 1 regression=
s (v5.10.112-cip6-88-gf3397cadb2dd6)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.112-cip6-88-gf3397cadb2dd6/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.112-cip6-88-gf3397cadb2dd6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f3397cadb2dd665a16905355cbc6717f52d196a3 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/626a14eeed4df4623dff946d

  Results:     90 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-88-gf3397cadb2dd6/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-88-gf3397cadb2dd6/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220422.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/626a14eeed4df4623dff9492
        failing since 50 days (last pass: v5.10.100-cip2-319-gcbff87047566,=
 first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-04-28T04:15:34.147723  <8>[   32.987449] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-04-28T04:15:35.170326  /lava-6196830/1/../bin/lava-test-case   =

 =20

