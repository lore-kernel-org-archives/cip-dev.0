Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACC4C761A6
	for <webhook@archiver.kernel.org>; Mon,  3 Apr 2023 13:11:05 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.69760.1680527458476125553
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 03 Apr 2023 06:10:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=atKD3GzU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id o11so27965133ple.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 03 Apr 2023 06:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680527458;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pa8aLsBU/K0wI4LoWgeGetZ0Gtfy5ouevFtKpQZ2k6M=;
        b=atKD3GzUbbEBVBSiKGroh+dy9mydj+A50Zy2soG02qQG+7/H3ZJdI7eaUNcUUPxJ4/
         /RrbmWf0tiQ+tSZF9CffuecJAXFxEHwyVlchBpeXbiIz/pQjaVNFMYpmqjMx6GBSs+7Y
         K7NBRL4Qjt/UurUaUC0qJLp12X/d5r6CtQt0ut6GZfqRPCxraPsMWLXV8p0cY4YPjHl4
         kXORRYfaDuS1RCgZ6fXtyqR6d36g5kfmq4sFXpEHEKkGtstSJ17PejrLywpWk77WDqY3
         xs9uczi6Ha91bBIc13OMQ750TVxfBeNhQzvWRuw5r0terOOqw0YtVY/RG58uoJIkppq0
         9vcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680527458;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pa8aLsBU/K0wI4LoWgeGetZ0Gtfy5ouevFtKpQZ2k6M=;
        b=7NscwLcT7cA7o5zsfMtpOPzuNl+9IWYwLDkW8QjjFOou0+ftCHhqvHDFlJvPW3Urn6
         UPHrqZ5k6Tw7u+792V8WniXxJLu9BpdeItwpKMEcIT0eBJkBi+MEbBpJ78fkXRaajnHG
         3lZuYRSwQE+4wI+Nwqi3umw5BpHT9LigCHash1n0E+K0ht6/M01gdgvta+SZSzwQJfrM
         E5Ipe2JuZVIWtIT7ywccOib5xwxs/A/Q1LEWl7Pv5N9r1V4FfqU0VxJ+ZhSNV3Sz8ogL
         vj8PuMVOCk9twLP5Mll27ZS6i6/H5HsB1akW8YbnwSB8tP9BbslyTGm+1wdRcLIu/4Br
         QYmg==
X-Gm-Message-State: AAQBX9cpg9zfmETfF5AKMoRT+9YNBDG10/+Hl8DQ9c8xEOMLnTd3LBVr
	zs9XJelerN1DMIj+T5XLPaF+EaywdIyu5Q8412w=
X-Google-Smtp-Source: AKy350ajnEXoqjtBtupNzcqHOOdHnScMRzwpUshW8bn4eO+fpsBeK5Jja58nejNW1p0wFtFotBYLfw==
X-Received: by 2002:a17:903:2312:b0:1a1:8fd4:251 with SMTP id d18-20020a170903231200b001a18fd40251mr44190360plh.55.1680527457771;
        Mon, 03 Apr 2023 06:10:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902bc4800b001a245b57963sm6568483plz.173.2023.04.03.06.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 06:10:57 -0700 (PDT)
Message-ID: <642ad061.170a0220.d1535.c5f1@mx.google.com>
Date: Mon, 03 Apr 2023 06:10:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-1097-g52d843097a439
Subject: cip/linux-4.4.y-st-rc ltp-fcntl-locktests: 3 runs,
 1 regressions (v4.4-st20-1097-g52d843097a439)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Apr 2023 13:11:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11157

cip/linux-4.4.y-st-rc ltp-fcntl-locktests: 3 runs, 1 regressions (v4.4-st20=
-1097-g52d843097a439)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1097-g52d843097a439/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1097-g52d843097a439
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      52d843097a439b3e38b2dde18a7c7fc256a94f4e

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  f41e8a2fa6f048d456ec2b136db9af50c7e42de8 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642ac2efeea57ecf3462f77f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1097-g52d843097a439/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1097-g52d843097a439/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230324.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/642ac2efee=
a57ecf3462f780
        failing since 4 days (last pass: v4.4-st20-938-gc773c630d0e4f, firs=
t fail: v4.4-st20-1097-gd51b0e04681f) =

 =20

