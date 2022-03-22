X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web11.6276.1647926298620711100
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 21 Mar 2022 22:18:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=I2XmmIha;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id t5so17300474pfg.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 21 Mar 2022 22:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=9XKkl7RwhGZh2I+WvqTC0HZqum96TUC+DgXsF2By3Rs=;
        b=I2XmmIhabkdk4j0jNF4fQFsLsRJih/tvuHcJqGs7cCwLl1jOWhIdPyqzWEanH0sEVr
         03un6B47WRx5nyqSLJapceAZhqWUaDJ82b8YPhnEGoqYR2b9XsTduSs6o2JOxImh3JjJ
         Oegkk+auMaLGoWP7O6xC2qGIRZXmcBvjVJll60yNse6PcNJ8hSPgrX1g9ctvW9j3ZhAn
         GuyhkDPX1KqLY/kK+GOZ6iO6e2D1i8rYLf15DR8fd9QMkwZuusUE4pr7e15mhYirMYtc
         jNc2Yk3jg3Z5MvqwbdhVOkMiodd0Vd+755J4ly6YUCILOY5z9Ql+VmiGYvlzR0e7coBl
         LS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=9XKkl7RwhGZh2I+WvqTC0HZqum96TUC+DgXsF2By3Rs=;
        b=5iB9TJw2WwS+sYgk6160MFPYlwsserEs3PQStcXlqEVFX6ag4r4KmyGXM/fJ82MoUx
         gmnzRwm8GuM94jt0P3fnh3cZMwaaK0zA4/a6zkvko7TxWJzChXTgrQXItjz0JKwd4Uo/
         Syz3FpzOj42bIcLzOMuzVBwgfkjzzxE6muGwU21Gu2Aydh1mY/v8pbnFTYnW98cpg/T+
         1MNKM5y/jrhYJm9tczigZb1ScYxYZZlO+645QP93KWum4u1FfOa02S4i6aYT+IlPCVxe
         ObdhiBG+9xsCsL5Z4DxBELNxGY69tV1gDc31s7prDONvhAkK6kk5QQ+1Zv7G3ajRIWF4
         AYoQ==
X-Gm-Message-State: AOAM530+oTv+qGaJE6lqZ3qh8NA0j1TI+aV585Z9Sy73Bbq3y87rHl4Y
	OAYra/kjjXolI6JNwBvYd4FAJzidQWJrk8npZ5Y=
X-Google-Smtp-Source: ABdhPJyNUElukKgdAMcPtwlJkp8WuUev8BMkKXrwGPoYG+U6gfduzPryNBbM+ufMy4pkwKU9UIpIpg==
X-Received: by 2002:a05:6a00:1695:b0:4f7:decc:506b with SMTP id k21-20020a056a00169500b004f7decc506bmr27401674pfc.7.1647926297985;
        Mon, 21 Mar 2022 22:18:17 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t18-20020a17090ad51200b001c71bec7b22sm1107821pju.23.2022.03.21.22.18.17
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 22:18:17 -0700 (PDT)
Message-ID: <62395c19.1c69fb81.4a705.4696@mx.google.com>
Date: Mon, 21 Mar 2022 22:18:17 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.104-cip3-155-g4f07dbd2df49e
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 11 runs, 1 regressions (v5.10.104-cip3-155-g4f07dbd2df49e) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 11 runs, 1 regress=
ions (v5.10.104-cip3-155-g4f07dbd2df49e)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.104-cip3-155-g4f07dbd2df49e/plan/baseline=
-nfs/

  Test:     baseline-nfs
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


  Details:     https://kernelci.org/test/plan/id/623953888e37da4a6a2172d6

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-155-g4f07dbd2df49e/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-155-g4f07dbd2df49e/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220311.1/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/623953888e37da4a6a2172f5
        failing since 13 days (last pass: v5.10.100-cip2-319-gcbff87047566,=
 first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-03-22T04:41:34.616721  /lava-5920624/1/../bin/lava-test-case
    2022-03-22T04:41:34.653414  <8>[   38.414833] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

