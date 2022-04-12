X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web08.5008.1649722250034909190
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 11 Apr 2022 17:10:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=JldrN/xF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id h15-20020a17090a054f00b001cb7cd2b11dso982531pjf.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 11 Apr 2022 17:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=3oviVB2g6cD+Tq7PcfZebDrqw1rIfrduzljwAZ3F1rI=;
        b=JldrN/xFPRrW5cN5dDgBNggBI4oY6yOdSb6yf0c9l/3bPdWAqQsJ1/29y0623MdNiI
         3z0lhQnwaA9nj43R2c4th4AUVpszWWHSNS2tSePOpuA50IgjMaz4vcKiXUxvnkq+KWQk
         tN3VU97uIYBQ6KT7SflKwp667l1BMk1culjdmm8N/neuvIVRl5doonzo+kaZfze2b0BZ
         /BINZedJmTFyliuYVFbzSeWwUh5cxU66niwVvFCXsDXXhDzPfcCnypF/WyVTnvg3rxLf
         FnafJfWhI/HwYxTRrXVJTyQ4PErl1Px80DOFdoVxRp8PktJkYnokoPhnesvFAztfDkfl
         KxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=3oviVB2g6cD+Tq7PcfZebDrqw1rIfrduzljwAZ3F1rI=;
        b=k+XkiWYKhcnWvoiCBmdVXQ2uPW8haIHpX9B+GlhyaUGngAJbIZm3WSy+Bk96DtCx/r
         LoiKEtUNc9EHObx4oJu3ZfYaagO0O8+ekqtcPEZoixAap4WAQAFx6Nsx/ENDMPKBYq7/
         SMFP/3YmksomRF1eyFaYkE+1cwdUaBsaeS5KjavoPYLjQzi0eEjKpSVO82ThePmMewq6
         A/NFYbseiwEb/JaPkouG6HNM8qwmTw0SB4ZtThemkr4KjCDktv5TX4S2/gEnfpvWIY6j
         GN0seDO8VpX4u8Fc9o+O/oKnAodzDttQXWrZG6D1GqrwjZm7Tv8ioL+gLXF5BWScld+T
         U6Pw==
X-Gm-Message-State: AOAM5316nU1tVu3/UfqxOH/CmvMcHmPmfnQcskQ0urR/lx9o0SdPl8ME
	vJgDLCOAcegf87ElU4MF6WehoDdjBFB7mdfH
X-Google-Smtp-Source: ABdhPJzqr2YicrQiz2sVJH8PEAgzi9ywAKHakFvUgc1hUjXl6MFtdbeX2cq7LjQBKfGoy5ofmKlWxw==
X-Received: by 2002:a17:902:c412:b0:158:642f:bb13 with SMTP id k18-20020a170902c41200b00158642fbb13mr7415727plk.18.1649722249315;
        Mon, 11 Apr 2022 17:10:49 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z16-20020a637e10000000b00382b21c6b0bsm777970pgc.51.2022.04.11.17.10.48
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 17:10:48 -0700 (PDT)
Message-ID: <6254c388.1c69fb81.8b511.2cf7@mx.google.com>
Date: Mon, 11 Apr 2022 17:10:48 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.106-cip4-757-gd8c01ae8a4bc9
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 129 runs, 1 regressions (v5.10.106-cip4-757-gd8c01ae8a4bc9) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 129 runs, 1 regression=
s (v5.10.106-cip4-757-gd8c01ae8a4bc9)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.106-cip4-757-gd8c01ae8a4bc9/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.106-cip4-757-gd8c01ae8a4bc9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d8c01ae8a4bc9d22111adb18d50f655db7432e10 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6254bdc4accdf915d9ae06b4

  Results:     90 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.106-cip4-757-gd8c01ae8a4bc9/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.106-cip4-757-gd8c01ae8a4bc9/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220401.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/6254bdc4accdf915d9ae06d6
        failing since 33 days (last pass: v5.10.100-cip2-319-gcbff87047566,=
 first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-04-11T23:45:51.613221  <8>[   32.729527] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-04-11T23:45:52.635672  /lava-6067280/1/../bin/lava-test-case
    2022-04-11T23:45:52.646228  <8>[   33.764271] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

