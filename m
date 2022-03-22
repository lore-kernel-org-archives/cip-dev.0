X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web12.6257.1647926298491925741
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 21 Mar 2022 22:18:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=OfZ5iTq1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id u17so17241984pfk.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 21 Mar 2022 22:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=68AMcJU4k6jqBt1sjQd0b8uX36IFFi/stR5V60ZzEgA=;
        b=OfZ5iTq1Z7bepzojpklPYOhY6owzCcTwIOFsJ1H4bGtjMnKBx4eDpLUggCE+f/8o0i
         UPqHUYRJkyKhMpGUK1s735krtYzq5dzZ0cPBK1axR4UzXQNDnIr6kiRMh55vb6ohzrMv
         dyqGFpxGz+lcVPfDFU96p0HQ0Dt/rfhSJXrOFp5ESXS6a6lbs/HzKF9jpEFfnv36FK8A
         PTvgZuJz2HOcY37OeZIAx3pzxs//7ilrnOr1AsEIfiCl+BnXxXZ3LmNZ6O6B9nEJPaVM
         1qzrOHvl/yS3avQ3dPvI/9TEHdXu+2z1tosy2h5IwVFK3UxTdOiaZLmvNIiubwzKopc3
         3WIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=68AMcJU4k6jqBt1sjQd0b8uX36IFFi/stR5V60ZzEgA=;
        b=5L3Ss1ZAy1QgZ/xpVc4D0PlObRB21yvuLM/FRzR1hc+XHytQiNbrR8b0n+WM0O6ktX
         SM9Qc/lMEq0v8/KZZddUtTrW4WiZyTeS2mcjbu1pNwWpbxGlt+qdgyDDx4lS4kRbUeKd
         DWD0Ty3XLc+q4JsQvqVGBYHpoGBTSP3CXAQ1fsb6USViiQYvEDYHmlCod3al8j1U6XkS
         Ayyn8dlrpLfqVGU8f4Ddk4kQjiZi1+PrsFLeiRdzMUfEhC9GVr3NIKnqOPCK4tiw1bqP
         vDBfkrauWmeopWf25oABypkx5vMCpex/dzdRvakPYaz1t15k0VyKRYGfTogz45fa82iR
         tGAw==
X-Gm-Message-State: AOAM531ErXN6SkipNfUYmOuDbUCkhj0wxuWu3hsAVk01WT6NC4sO/z9h
	4xQzS9VWdsLlriiCAAVJbZTpfxJTWKhryes+0UU=
X-Google-Smtp-Source: ABdhPJwPe7Qhw9Z16mFfiNPg5PSFLxFq1Bpe1+4ZvxNrvNt77cEjeBeVgYmEDUm4TQUb+LffWRGIyA==
X-Received: by 2002:a63:6c4:0:b0:382:8506:c127 with SMTP id 187-20020a6306c4000000b003828506c127mr6335050pgg.279.1647926297653;
        Mon, 21 Mar 2022 22:18:17 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d16-20020a17090ad99000b001bcbc4247a0sm1076495pjv.57.2022.03.21.22.18.17
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 22:18:17 -0700 (PDT)
Message-ID: <62395c19.1c69fb81.78b59.4523@mx.google.com>
Date: Mon, 21 Mar 2022 22:18:17 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.104-cip3-155-g4f07dbd2df49e
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 51 runs, 1 regressions (v5.10.104-cip3-155-g4f07dbd2df49e) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 51 runs, 1 regressions=
 (v5.10.104-cip3-155-g4f07dbd2df49e)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.104-cip3-155-g4f07dbd2df49e/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.104-cip3-155-g4f07dbd2df49e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4f07dbd2df49ee61f77347287ba5837888067f02 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62395185a85ac489ca2172c7

  Results:     90 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-155-g4f07dbd2df49e/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-155-g4f07dbd2df49e/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/62395186a85ac489ca2172e9
        failing since 13 days (last pass: v5.10.100-cip2-319-gcbff87047566,=
 first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-03-22T04:32:58.569784  /lava-5920611/1/../bin/lava-test-case
    2022-03-22T04:32:58.579807  <8>[   34.196932] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

