Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6DCC43217
	for <webhook@archiver.kernel.org>; Fri,  7 Oct 2022 11:37:44 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web10.3310.1665142659593751001
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 07 Oct 2022 04:37:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=jrfwMiiD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id
 g1-20020a17090a708100b00203c1c66ae3so4514638pjk.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 07 Oct 2022 04:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LoERT4VeZ84XLVAAJqKjKSDHY4ZRhL8p0LOmbxF/FrQ=;
        b=jrfwMiiDrClEBVzBKrzjZTa+tXQlBLYE6btScV5no/fSSefAxOcxuS0DQo4RMC/IRL
         MUHnzra8u/lRB9IcNvC1mhtanx/lYvsmLaNJA94rckwHsyRBnzMs76T/+ejkn/6lY2F6
         fiiWx/h42rB+ztbJ/JUpmtQnJPGny7zlq7ZSbQ8tmfcHOVs42aGr9arAJjHoD7NxyXr6
         KTtzW+P5n/MBP1b0Zn9gR4INBnpnLWKumy6Xg/FbE2A14MLs5fFb6idyaKNZhHZZG8MZ
         Za3W/lM80DFJUWujAjeB5ysG6Ut8BFStwoqBcUlev6jlrepAeskKeqI4gUvSNR1ma7Lk
         wGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LoERT4VeZ84XLVAAJqKjKSDHY4ZRhL8p0LOmbxF/FrQ=;
        b=fMWYm68xTzU2DoW6wKRUvK+LqQjiAV38dPQBEIqswqXGxNEpJp4Bm1db1flVOSHxC2
         Wj0NBCYphwd9okas81svDy3NPsD7MenHLy9q9aTK9oP5jtAH1jrkmcdoypbuStus33rQ
         zA6EdBvwLxO5+5NPrU1ua2bA7CzHL8LBHmfzZSszNxKZbzEnYsCbggl6R15Mieepnehb
         H26/vrwMFhsDLsB8qnylNO+Az/eeqRq2WHLVm+xXtmYPixdNEjP6g+hGgqPHQLBOxU5f
         sg2MV6QRsywaXPa5MQiK7eDeO7i6BmRhb04n2no6VOIncGEzCHEtjA52SjVUzzDHObt4
         OlGg==
X-Gm-Message-State: ACrzQf0l5h5tGwYqeCOFdDQhgl8Fr2Lb7ilDb1lftG9MeQJVUSTjNt+r
	WXI4oG/sXoEk0a6VRYRXB1QciHDFqVWWBCklihI=
X-Google-Smtp-Source: 
 AMsMyM7BkQ1WUGDwx0HnVSzH7+Lzn//JljGB08Cvb2m51Oj6GcKHQsOV0oNpCD14cYUFn0vB2TdNZQ==
X-Received: by 2002:a17:90a:f3ca:b0:20a:d4ee:3859 with SMTP id
 ha10-20020a17090af3ca00b0020ad4ee3859mr5072727pjb.70.1665142658796;
        Fri, 07 Oct 2022 04:37:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 w123-20020a623081000000b00562b3bda233sm1369954pfw.120.2022.10.07.04.37.38
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 04:37:38 -0700 (PDT)
Message-ID: <63400f82.620a0220.b9f02.27f3@mx.google.com>
Date: Fri, 07 Oct 2022 04:37:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.145-cip17-rt7
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 6 runs,
 1 regressions (v5.10.145-cip17-rt7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Oct 2022 11:37:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9682

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 6 runs, 1 regressions=
 (v5.10.145-cip17-rt7)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.145-cip17-rt7/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.145-cip17-rt7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      411cd76b5afe81569858976d0e9819ab48717fcb =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/634003bf2b02f46ccdcab643

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-rt7/arm64/defconfig/gcc-10/lab-baylibre/kselftest-filesyst=
ems-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-rt7/arm64/defconfig/gcc-10/lab-baylibre/kselftest-filesyst=
ems-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/634003bf=
2b02f46ccdcab644
        failing since 31 days (last pass: v5.10.131-cip13-84-g5fcbe4a63ab4d=
, first fail: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =20

