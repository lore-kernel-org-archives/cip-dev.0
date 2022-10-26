Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7D1FA373D
	for <webhook@archiver.kernel.org>; Wed, 26 Oct 2022 09:38:12 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web12.5558.1666777085011651687
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 26 Oct 2022 02:38:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Xw/PKVDd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id b185so8523446pfb.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 26 Oct 2022 02:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=urBQCUQj3fMYZyZi2IedHDo3FAIa1zEufN92lpjnUEw=;
        b=Xw/PKVDdLr/WENA9byabdQx5DxNjMFwtYdYAXas7jVbKO21BQOkrmDKa03HMpdcJhs
         jYT5e7yEC2MT25clQa0Fb8zQC4ab377qiDvp5h2vWOSd4k2mQVZqmGLD9jGnBNaCejMZ
         9rhobuk9LOPrEp4dQAIjbUIgn/J7BdZhWFWdcJHD6V4Edox5zY7pWCsvNtOQPu4akEnY
         Y5s+NdGpYoJffxUMh69RsfK4Nq6jgnQeL1T+S+hKNGA1l587uEb7aGUy28qKZk8VKezH
         asC+rF0qApOWj0ZM16hptP9hO0rkxxFCiHjv/CirfL4aI1S3BzIUPWEsvQIGOnPNDGhT
         XGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urBQCUQj3fMYZyZi2IedHDo3FAIa1zEufN92lpjnUEw=;
        b=fNFiiznyl3d04+vdSZ411b2gXxJa0ZyPfGQ54wYj2ryPQ2kTuqkvHv8vpH57cDIiOL
         3WUiNJD0oLKwmNJOFO9QMQJ2tYOkz7sX/R8/oQpel6tYKITDQyPTK7he7TN19X4tpwbz
         GfrukI5YyJBo2N1kVpC8W+TrG1MROsAE3cdRZwvJM3wIJh+1jI398nEuOIqkWFVM9NDc
         VCp5XQPmz9Sv7eXBS3+cZfj8eIdCH6JFXSIFa3hSMZgnRIKvlg8GMX2pkeLvkooHUq97
         cYHCmoRuoZhAd1B76UYOBF4Lz7lBIoWM9uYOzvR5KQ0J8u9McNpSlzPMMna6Ti/7wgo4
         RNEw==
X-Gm-Message-State: ACrzQf2ZeNCEQ48pqgPQ0Ot2gpBq8j7HM7FSQ+EJ2Y43+VcdTqZ381SP
	noaGLV3iJ7tQ9IVdTQxY2BoD6FQUZ763EIMk
X-Google-Smtp-Source: AMsMyM436vgW2fxHtFmwBw8/oVio01neVM44NJlzF4xCvSuXgr4zzL9NF37sNCmM1sFPcKzv+C8q5A==
X-Received: by 2002:a63:ea04:0:b0:43a:b17f:cd12 with SMTP id c4-20020a63ea04000000b0043ab17fcd12mr36616792pgi.109.1666777084233;
        Wed, 26 Oct 2022 02:38:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090311ce00b001754fa42065sm2544505plh.143.2022.10.26.02.38.03
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 02:38:03 -0700 (PDT)
Message-ID: <6358fffb.170a0220.6411e.5aba@mx.google.com>
Date: Wed, 26 Oct 2022 02:38:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-11-ge6d27ea102c3b
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 38 runs,
 4 regressions (v5.10.147-cip18-11-ge6d27ea102c3b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Oct 2022 09:38:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9851

cip-gitlab/ci/pavel/linux-test baseline-nfs: 38 runs, 4 regressions (v5.10.=
147-cip18-11-ge6d27ea102c3b)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 3          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.147-cip18-11-ge6d27ea102c3b/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.147-cip18-11-ge6d27ea102c3b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e6d27ea102c3bf928bd8f3a0815361cca9797bfb =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/6358f8b4a6ddf64c0f5e5b52

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-11-ge6d27ea102c3b/arm64/defconfig/gcc-10/lab-cip/baseline-=
nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-11-ge6d27ea102c3b/arm64/defconfig/gcc-10/lab-cip/baseline-=
nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221007.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6358f8b4a6ddf64c0=
f5e5b53
        new failure (last pass: v5.10.145-518-gc75907dbbb95a) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 3          =


  Details:     https://kernelci.org/test/plan/id/6358f81a4106fdbee95e5b3b

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-11-ge6d27ea102c3b/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-11-ge6d27ea102c3b/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221007.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.cros-ec-sensors-gyro0-probed: https://kernelci.org/=
test/case/id/6358f81b4106fdbee95e5b82
        failing since 168 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a)

    2022-10-26T09:04:11.074019  /lava-7724279/1/../bin/lava-test-case
    2022-10-26T09:04:11.107275  <8>[   93.837656] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-gyro0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-sensors-accel1-probed: https://kernelci.org=
/test/case/id/6358f81b4106fdbee95e5b83
        failing since 168 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a)

    2022-10-26T09:04:10.013426  /lava-7724279/1/../bin/lava-test-case
    2022-10-26T09:04:10.040547  <8>[   92.770950] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-accel1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-sensors-accel0-probed: https://kernelci.org=
/test/case/id/6358f81b4106fdbee95e5b84
        failing since 168 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a)

    2022-10-26T09:04:07.899288  <8>[   90.628326] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-driver-present RESULT=3Dpass>
    2022-10-26T09:04:08.946011  /lava-7724279/1/../bin/lava-test-case
    2022-10-26T09:04:08.977792  <8>[   91.708017] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-accel0-probed RESULT=3Dfail>   =

 =20

