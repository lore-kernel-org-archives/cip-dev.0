X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web11.5166.1648551975751191378
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 29 Mar 2022 04:06:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=fEdOA+aa;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.54, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f54.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so2483846pjm.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 29 Mar 2022 04:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=VKAMUuR8idbNRWpFgpCxJYOvCGg0S2eEYGOR98C2aBQ=;
        b=fEdOA+aaoU8/U5trn2AJfJtA4HvG0Q4C2KRoviiQhHUmT4cP5I0Gp7SSnIQM2wqSHC
         aDkz5M1bRjKNPsItwzMHsbSe1CrZh69+YjdePL5u66Yp/96ISRCFoZhhJnbguZ8wgJvD
         Y+2IR74Ks3aat3TiElAURDWMzGibODX7xel0h8pFnJdCc2iAHdLabGAxAUwfaKJuDjuh
         sFKpEScorUDQV7CCH5b5t7hKBWrrb80xzMqh8RyXa7pwLyTw4rZFaa6alAmChVBkOoLS
         SGCZ0ibZYFLShIQCeeaICSx4p6HCxNs07XVkXWumv5m0mR7vPTQma3xxmOr+lEUnV4EC
         7vaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=VKAMUuR8idbNRWpFgpCxJYOvCGg0S2eEYGOR98C2aBQ=;
        b=SM52W4ZWS/7FOGbxAh2C4S+NC4xf2izu5LUSbi0ahq9d1hb33oDPzxsx+tTEF6Fn7I
         ENzyX3IiPlcV6lqlXAoDO9uZkqfRsrxmGwo+pTrK1MS8wfm2YA/AFS9lTRSMhrtDcyM2
         lsK8U+3Ymy7F7WHe5lyXmrffqXTBhdkkeGPh680YmEa7jRvtRUFnWwKF0o6E1kzgzbBo
         zob9/lEOoGwYz3pR3kUHD/gqUFt93K95Y1RM3x3qINA7BcqIgksr3DhxPmw5BpCwqDWF
         gAHNBdkGO8ZUuyC/tYaH+i3TevWU/kUHG5yLBH8nGqEt2+IRyjYA70/dpPoA3FUaaXe7
         DStg==
X-Gm-Message-State: AOAM531H8EdMiZGDOhWUPB4aLHlduT2WbUj8DV1KjGA2Y/6MS5CenOwl
	QMU2ovGXHGKF2EwXEEZAIr1rQt65z3Cade9rWXI=
X-Google-Smtp-Source: ABdhPJyuSXnSaqXuwVV4PwPNfbTf9BP0dTlf2ubQUIPn3b425tocmbQuccfsBPdrTDD2nJpcvHIImA==
X-Received: by 2002:a17:90b:4f4d:b0:1c7:5324:c6a0 with SMTP id pj13-20020a17090b4f4d00b001c75324c6a0mr4059390pjb.160.1648551974953;
        Tue, 29 Mar 2022 04:06:14 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k4-20020a17090a910400b001bd171c7fd4sm2511654pjo.25.2022.03.29.04.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 04:06:14 -0700 (PDT)
Message-ID: <6242e826.1c69fb81.b6d0f.6ac1@mx.google.com>
Date: Tue, 29 Mar 2022 04:06:14 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.106-cip4
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline: 104 runs, 1 regressions (v5.10.106-cip4) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip baseline: 104 runs, 1 regressions (v5.10.106-cip4)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.106-cip4/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.106-cip4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8bb6e30b765989a3c0924158316d689e16317cd1 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6242e0491b50cdb27fae06b5

  Results:     90 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399=
-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399=
-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/6242e0491b50cdb27fae06d6
        new failure (last pass: v5.10.83-cip1-178-g2cf1d12aab81)

    2022-03-29T10:32:20.576387  /lava-5969080/1/../bin/lava-test-case
    2022-03-29T10:32:20.586558  <8>[   34.578035] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

