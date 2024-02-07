Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553E2C4829C
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 18:11:49 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web11.5138.1707329507878974824
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Feb 2024 10:11:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Zq9u8vdC;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d3907ff128so709173a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Feb 2024 10:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707329507; x=1707934307; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J6RFnR6ZekwHYSV4nzAHURA3WJgwh4QPzfCwtWrco8I=;
        b=Zq9u8vdCKJjPa1onhtpna6h59yceL6sfniapVPiszvsGzug3sUdh5fHkzoTLh6GMdK
         KOGAUj6iA+VFeOVzyCOcX5ZjtUfPivJPn5fGYCLIfRA04TX0CshoHn2NFKlUlrrQ351M
         w17D6+Tm2W/qpzrwIzS95P3Ntb8AicH5PMEH87O5EnynHEeZFXvGVZWfGCLMxALOcJaO
         aZ838sGvkaCtXlD9orhwfjT78EpTQy4jCMB1vvu3e9xPXIo6i5gkP5KZ3f7w8ignVPYq
         6AKXg2SwUpPaEIJqjjgwRab5vBKm6X+d759CzVMgnenqKXDDTgLBJCk7yx/l5aFpfN1Y
         djZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707329507; x=1707934307;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6RFnR6ZekwHYSV4nzAHURA3WJgwh4QPzfCwtWrco8I=;
        b=N2IPY7SLkOpl6Nw96hMFmKTypuNAhucz3aj+Njf6UMiL5MaMQCEfqLO+LympV5Du0f
         ntSdPHLSOitEUfpjQzGwp/epr1oo79mAm07hkdyoq1Phwa56BXtc8xd9lxkPNFlu++Kh
         EpLRpGWd8RvXafIWkV+To769Ty8gIr+138LFL8mkU3D/vNbuSeChURhZylcCAvy7Bn8V
         g4yPrEoObkOVQLCNObpMQYA6q3fQZl62fRZyTWJ9RVR2Qk3RpEXJK1LcmQ+77H6/XdDz
         rp1wQVFzu2fDJbqvQ2ZzCYOcfvjDNYZ8FRN0YzVaqALzRirIxqzfA4bPWF29r694TlGO
         ZGrQ==
X-Gm-Message-State: AOJu0YxGUS1wbDJU7TzG8d+zbWvm8kW6dqED0pb48ohLVMFIf8uzeqaS
	BiGqZ8C1R+USzNtCTOYwL9qGmc5efhFg+YnUfY7FAyxVj4obiY+z+XOhy8r7k/2UuVs3dGtOWuH
	ZChM=
X-Google-Smtp-Source: AGHT+IH1ZVjQoqwc/AEJ4Bi/184bknTAdjS4atfq4phZeiCVs6Fw5QOULcFPmb6pzwnckj/Cubasgw==
X-Received: by 2002:a05:6a20:4ba9:b0:19e:3093:9b89 with SMTP id fu41-20020a056a204ba900b0019e30939b89mr4132009pzb.25.1707329506946;
        Wed, 07 Feb 2024 10:11:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXwuyoND8F4XZ32UpLHWT0ZIp2l9rc8YBNF9xCNCR4hXoqUIIYHxJ72T4rGBMON09sa736BsnXPSCQOY5tICjf6ZlkXUDheHQ5RxR2dQgQPTR/k90w70Ew2Z6d9lFXiHEWhNpP8HSRv/M36NtwAbuS1Sg==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r6-20020a17090aad0600b0029020be4298sm4282552pjq.0.2024.02.07.10.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 10:11:45 -0800 (PST)
Message-ID: <65c3c7e1.170a0220.c7ac2.ea48@mx.google.com>
Date: Wed, 07 Feb 2024 10:11:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.304-cip106-3-gaf120b32b886e
Subject: cip/linux-4.19.y-cip baseline-nfs: 34 runs,
 3 regressions (v4.19.304-cip106-3-gaf120b32b886e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 18:11:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14899

cip/linux-4.19.y-cip baseline-nfs: 34 runs, 3 regressions (v4.19.304-cip106=
-3-gaf120b32b886e)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
at91sam9g20ek    | arm   | lab-broonie   | gcc-10   | multi_v5_defconfig   =
      | 1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.304-cip106-3-gaf120b32b886e/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.304-cip106-3-gaf120b32b886e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      af120b32b886ebb728032aa594bafc1d152eb9f5 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
at91sam9g20ek    | arm   | lab-broonie   | gcc-10   | multi_v5_defconfig   =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3bba1772e518c898e1e9f

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c3bba1772e518c898e1ed1
        failing since 131 days (last pass: v4.19.287-cip100, first fail: v4=
.19.295-cip103)

    2024-02-07T17:18:47.656011  + set +x<8><LAVA_SIGNAL_ENDRUN 0_dmesg 5542=
16_1.6.2.4.1>
    2024-02-07T17:18:47.823901  #
    2024-02-07T17:18:47.926095  / # #export SHELL=3D/bin/sh
    2024-02-07T17:18:47.926895  =

    2024-02-07T17:18:48.028917  / # export SHELL=3D/bin/sh. /lava-554216/en=
vironment
    2024-02-07T17:18:48.029710  =

    2024-02-07T17:18:48.131981  / # . /lava-554216/environment/lava-554216/=
bin/lava-test-runner /lava-554216/1
    2024-02-07T17:18:48.133245  =

    2024-02-07T17:18:48.137147  / # /lava-554216/bin/lava-test-runner /lava=
-554216/1
    2024-02-07T17:18:48.491538  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65c3bafc3552c942408e1e7a

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/65c3bafc3552c942408e1e80
        failing since 322 days (last pass: v4.19.276-cip93, first fail: v4.=
19.277-cip94)

    2024-02-07T17:16:19.596384  /lava-12713721/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/65c3bafc3552c942408e1e81
        failing since 322 days (last pass: v4.19.276-cip93, first fail: v4.=
19.277-cip94)

    2024-02-07T17:16:18.532569  /lava-12713721/1/../bin/lava-test-case

    2024-02-07T17:16:18.558083  <8>[   39.330522] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

