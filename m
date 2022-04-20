X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web11.9883.1650471607007008522
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 20 Apr 2022 09:20:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=IEY7ntDc;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.174, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f174.google.com with SMTP id q12so2020303pgj.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 20 Apr 2022 09:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=bRI44DQYIc7fFWDwIscKrlwb8Bsl173fWuf5riTymVY=;
        b=IEY7ntDcfZ3AvF4Fowt66Fpv3uURDTZRGhBYelqotka92umKwlq0THH4TPkZo7ut8w
         QyJ0RR8zJH0NKV6ZGS+mTtIEXUTKyTWWXaq7pnULfEgRhaU9p9VJOLEZkKPLfmSEZu+k
         cs5121xrcwPWQ60rcGdUDgR/BkFCT4XvCxDzW2doY498mWyiRoWaGee3jluW8EbnuURy
         pKEigyi4eMLt8t8iFMx7jaOg+ofzk/mZhn/LHyfmvzra3RjN8kaLlFGrJLd7cf/g1x/P
         FRuFVGKiRrIfyx8h1HtAutqetKUWeq9rjI07fXDKV/G6N3l9nqBud5MT7CY5Y7P0TQ2r
         xWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=bRI44DQYIc7fFWDwIscKrlwb8Bsl173fWuf5riTymVY=;
        b=4f8zFV+gTZBnTAxBFuj04YOvYR7wqtq+2wXb3YbI7MIEj6ZZHKec9fUKpZYTI29Hbh
         hGXCIsQkDPB2WX/AVUk/4UI9PGdwGsgQhz9kE7qHksQ2Lj3JZctFwKRIQfWZN9r/7Mxd
         aY2OGOxGLhHKB18pXUJbc1xQIo1h4K4CR2HwTREhR6IiYBM48QG9mz7os+mqgp5PHUHL
         T2OkhZtTOLvyXkQx6EIEVveuhqwOCYDzYhSZ0qLW/U3bYOKUFxRgGg7Yrlm43NfXXRtP
         6itr5SEA+03SEdbxoWXRcP/B487679/vJxSmfDx0h9fGOeRI8VwdojEtjNfhNXe4PPzM
         gzeA==
X-Gm-Message-State: AOAM530e/X7PpCH7dRHXR3dAozUwBjYt0iDMcnYtHRmjA2DqeG0b/hKM
	eGWJJgDKJyShQm1kqcfksi/q92Hao6jc5bj4gao=
X-Google-Smtp-Source: ABdhPJyHG390gXdgboZkWJlhTVPTpbEMUCjTJmnqaQMTGb0us8XnkGewFojBdPieJZSjzdzfk2dung==
X-Received: by 2002:a63:5f93:0:b0:3aa:624b:8225 with SMTP id t141-20020a635f93000000b003aa624b8225mr4688567pgb.544.1650471606282;
        Wed, 20 Apr 2022 09:20:06 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x71-20020a62864a000000b0050ad2c24a39sm446973pfd.205.2022.04.20.09.20.05
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 09:20:05 -0700 (PDT)
Message-ID: <626032b5.1c69fb81.2c912.1285@mx.google.com>
Date: Wed, 20 Apr 2022 09:20:05 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.109-cip5-875-g6ed0fe2c3e8b
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 21 runs, 1 regressions (v5.10.109-cip5-875-g6ed0fe2c3e8b) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 21 runs, 1 regress=
ions (v5.10.109-cip5-875-g6ed0fe2c3e8b)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.109-cip5-875-g6ed0fe2c3e8b/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.109-cip5-875-g6ed0fe2c3e8b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6ed0fe2c3e8b47b471924ff54d5cdb9d0afb1200 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/626027dae08543cb01ae0690

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-875-g6ed0fe2c3e8b/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-875-g6ed0fe2c3e8b/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220411.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/626027dbe08543cb01ae06b2
        failing since 42 days (last pass: v5.10.100-cip2-319-gcbff87047566,=
 first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-04-20T15:33:27.428165  /lava-6133206/1/../bin/lava-test-case
    2022-04-20T15:33:27.461132  <8>[   96.816169] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

