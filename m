Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587E1C07E98
	for <webhook@archiver.kernel.org>; Wed, 29 Nov 2023 00:16:59 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web10.15085.1701217018046369907
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 28 Nov 2023 16:16:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=wjQstsjc;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6cb749044a2so6089981b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 28 Nov 2023 16:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701217017; x=1701821817; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CHTyMke4loSrK+MBU3SvQatkyLa2UYi8AI+6bo8kygY=;
        b=wjQstsjcfLEdOQhaL8nREpLjSENOaMzafciGlSaj4zca1K8qQoGSudyO5HharIviH6
         cY7B645eV8ECvE4fIj7a//8VHC3fnYAHdl/UVdRy2QIQCqGuybwwr93Oy8eTdJBfHph0
         t+HAWGvw/f6d9whnv3TeJ1b1UAIyCrYFc7/eaJBg8+uJ4t41EWl7CL+Q09PWPE7LWtXn
         cCFrn/8Ih3yvhhcjdHZg/FaqpKlfU0JKpeaOSw3ooU7Qzftujbb0pvNuXjVqazBMOT9O
         bOFuqT6b1854onuft4NY4l37QK34FeVNQW1KSGEewhXQYsdA5AMqVQPHg5hephj6WLS6
         4r5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701217017; x=1701821817;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHTyMke4loSrK+MBU3SvQatkyLa2UYi8AI+6bo8kygY=;
        b=QbRb9n8Ua62asGNDvu1Z2GNuv+9QCcq15Knf7CMKTACXTkBg+7Fp9JTp25kJT/x4UO
         PcGRFJPvi8fYwwNZQyP5d9qXz7WX3JzNfm0FDoQbIC0Q4ST6kgFe5stAGapoP4cOG81J
         cczqyVBRbT2jJXQw0v4hS7/XOSI0w7ZRcjM4UcO9kBNwe5OLQDRP+aJBkWgpzfx3bU2H
         segkvbSR3fjoFhNazoUxevoAd6Jm1mH+SKyrbI5J48AmZJbMqVz/wVKH2cMRHGCchAYZ
         +sz+Re9RPjXT1v0BEWuQTdOLSBBrKewEQb7An5o1IwcqY3UfkorW/ox9PWYhrFfOKTkG
         ndwQ==
X-Gm-Message-State: AOJu0YyuVxQbJmR/OCrQeQYWFQMhbS7cu9cyusgLZSBxxPp/9Gdxy27M
	3FBvSjo0aZnF+t2sEaAfUFPjd3ZUzHDGJLL+PBA=
X-Google-Smtp-Source: AGHT+IF5DTNkUj07IIw9nRvxP7yVGf4jD4UiM6hFgSb3i6MeTnj+7t2ltivCEWUq/8fvG6BL3lzxLg==
X-Received: by 2002:a05:6a21:99a6:b0:18c:63cb:e86e with SMTP id ve38-20020a056a2199a600b0018c63cbe86emr15373327pzb.2.1701217017045;
        Tue, 28 Nov 2023 16:16:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t18-20020a62ea12000000b006cb94825843sm9571125pfh.180.2023.11.28.16.16.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 16:16:56 -0800 (PST)
Message-ID: <656682f8.620a0220.5b97d.8060@mx.google.com>
Date: Tue, 28 Nov 2023 16:16:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.201-cip41-197-g2d08925b44e52
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 13
 runs, 2 regressions (v5.10.201-cip41-197-g2d08925b44e52)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Nov 2023 00:16:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13755

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 13 runs, 2 =
regressions (v5.10.201-cip41-197-g2d08925b44e52)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-197-g2d08925b44e52/plan/ltp-fcn=
tl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-197-g2d08925b44e52
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2d08925b44e52ce450bf165f843637412f9c979b

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/656671e53c6af134e07e4aa9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/656671e53c=
6af134e07e4aaa
        failing since 26 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/656675e853143487617e4a6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/656675e853=
143487617e4a6e
        failing since 6 days (last pass: v5.10.194-cip39-915-g96fa7f16cf02,=
 first fail: v5.10.200-cip40-188-g33d0b44cd71d) =

 =20

