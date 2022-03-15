X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web10.5050.1647305469294362670
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Mar 2022 17:51:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=LTAA2sot;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id p8so16927179pfh.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Mar 2022 17:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ygqfPUs3u80kGBbFqv/0/0uOrfgm8MqoQAgaZYCsgiw=;
        b=LTAA2sotXga6ZrbX5JJEFL0VD6dac76zRLCk+TE4Tu+rr1+W2aMdIpjSRcRZBBXJ7x
         waE8Ivj2l/aXSjxuQrihjyL5HgwGXLK38AaQjIRW6YBlkHITUrXH05cD2YDEL1UhRIk7
         x9GvZwMRO99fylUV2PtpX2GzsJhJbWLBq7CTEYNCgauDiIHBWRANd3Ol1uCRt3z60FLh
         c8vyNcO8afsstAj/yUxoKwPC4Po3x9nSoODOhbGINgCSMlUASzoC/yHwqj3lgRglxpGU
         S9noxfZIzgVDBVvdciDGNX4dED0qrM/v1oqYHpiMLly7vDvETS3PRjmyeiPTfOcMJvUp
         b/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ygqfPUs3u80kGBbFqv/0/0uOrfgm8MqoQAgaZYCsgiw=;
        b=115XMWH78ATICkAnewASvvYscaloOwahsWpmhSqVJ6TxQkKNgQWV9mhonTZrIRhLX5
         JMWIaQTlxxmS2KcYSNRT6gUQaqe8IxSFx9oE8vv+aln0RrAgXx39UpDd90sVzobMm4Qw
         Xk9SPkGNIwPZ+bLbxQWx0r31aTP00LBn9j4SM6fg3+kqrBDQ4IubvIule7BNtmFw5Xy8
         ID+81+qH2V8mRNJqkktWI/e/sqjH1wXnt/AS7bi8ezKbOhBY2YMjDKnC1qALm7m5C2Rc
         wbb18U2JWWxR2/HPezNuJjYfvbpyqihxV5R0ChxhlppTEJ3MVhkfKz5UIckkf3XJwXC8
         sa5w==
X-Gm-Message-State: AOAM533lsNEiDtoPxKPFXb9TCOpnYCIU0vz7ag7TPxbeVOOq2wqQmTHQ
	lNfbMZjsnmwvSuLEBPoO2rd+XSQZaRrb2ITxnw8=
X-Google-Smtp-Source: ABdhPJzphr2wq3Ba3lVi6lBoz6qQrCgfpNXqhJVdMw4FkjzDGtBqTgnAN3+HDfFScrET44eIFQtG2w==
X-Received: by 2002:a63:235b:0:b0:380:5d91:6cc with SMTP id u27-20020a63235b000000b003805d9106ccmr22101841pgm.183.1647305467624;
        Mon, 14 Mar 2022 17:51:07 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q15-20020a63504f000000b0037425262293sm17918086pgl.43.2022.03.14.17.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 17:51:07 -0700 (PDT)
Message-ID: <622fe2fb.1c69fb81.73824.e69c@mx.google.com>
Date: Mon, 14 Mar 2022 17:51:07 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.104-cip3-rt3
Subject: cip/linux-5.10.y-cip-rt ltp-timers: 7 runs, 4 regressions (v5.10.104-cip3-rt3) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip-rt ltp-timers: 7 runs, 4 regressions (v5.10.104-cip3-r=
t3)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 2          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.104-cip3-rt3/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.104-cip3-rt3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1105279cf875fdf297e0225252cf3e595105a831

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  67eccca54eb68a1bc91cf1f140fc43fa8085d8ed =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/622fdfbcbcda248560c62999

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
104-cip3-rt3/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-timers-r8a=
774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
104-cip3-rt3/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-timers-r8a=
774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/622fdfbcbcd=
a248560c629a4
        failing since 18 days (last pass: v5.10.83-cip1-rt1, first fail: v5=
.10.100-cip2-rt2) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/622fdfbcbcd=
a248560c629a4
        failing since 18 days (last pass: v5.10.83-cip1-rt1, first fail: v5=
.10.100-cip2-rt2) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/622fcfa0926733a2eec62968

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
104-cip3-rt3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-time=
rs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
104-cip3-rt3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-time=
rs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/622fcfa0926=
733a2eec6296d
        new failure (last pass: v5.10.100-cip2-rt2) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/622fcfa0926=
733a2eec6296d
        new failure (last pass: v5.10.100-cip2-rt2) =

 =20

