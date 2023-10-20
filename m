Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA0CC07480
	for <webhook@archiver.kernel.org>; Fri, 20 Oct 2023 10:03:17 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web11.51002.1697796192334407892
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 20 Oct 2023 03:03:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=y9KgGvAP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6bf03b98b9bso1012049b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 20 Oct 2023 03:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697796191; x=1698400991; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S3Tv1zqilbyLOO515eu+Ma+56+4ZP5r7ixxiNl3KOFQ=;
        b=y9KgGvAPH6mjmzOnpO6yLSjZLzCBomqfKSV14vK6m8N+oe/MStKZiP4jHXn0d2bWbI
         ZK9wfUXv/gL+VlofFTl+Si8Cp1POVPw5rmaBMQClOwd6XWHB5PvBrypaEyy7p4ZIAP03
         jvrPrSWXjG1YQrmrPwgUlEmaXkwgDFMfrSYhWJ+uxEI/DdW9QVgaP4MmdqtLpk6Jz8IG
         3EnpET+u0ayrN/9w9oPMrRLaO+x7WElfRMUYk/iYycs7UY9hc/D38oxZISV44+ckS6oe
         SjQa1rCvbpwilaEAIsfW5A+4412Qib9FyLYpHZ+Jvc/dWLxyzKqycB4Al6QwN4Sd/yiF
         2ibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697796191; x=1698400991;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S3Tv1zqilbyLOO515eu+Ma+56+4ZP5r7ixxiNl3KOFQ=;
        b=t/LowonOMoTEv38XrZeoLrxEF6gJSJIW0PZ8AQNwHtn1p4AvNHsEpewh0N6KVj3Ap7
         IzlrRikVlBkf3baB0i8D0ZGLnUWBKisJt/PWzhhI6JVq9Q8ZxticD7U2bwtJKamOpi1C
         ESewK9URvLRmnFlkxu0SVvYPRekiJoI3+Ea/aIIToa3IuXSPZt+dgBdusZggZr8A5WEU
         U0fJi/qmL2sdaaRSVaARdm326CJSG+3zdh0olxolONul5eOoAtm9upRjOemFwFhESKfL
         LutWsBDbpJf6VJDtRCAjn+65OJsR0A/okIYYxqPuJssCEx2x9SuAxSOGj9pfX6t/Ry22
         9ZNA==
X-Gm-Message-State: AOJu0YwVCJBrJ2A4BqaBmT4yJjXT4b1D4S4nwla/myHLdKljViQQVIj0
	YJDBJAv3MuowxcpIUx3Q1w8vdrAkGlsjkxz3SHDEYw==
X-Google-Smtp-Source: AGHT+IFNOm6niTFK1pL0qIWfWQTL75mPZ+hcKD2VV7Y2XxFGPW4lkzdP/H9XdHNf4tQo4ibB0vueGg==
X-Received: by 2002:a05:6a20:1453:b0:174:32c:dfcb with SMTP id a19-20020a056a20145300b00174032cdfcbmr5565500pzi.31.1697796191117;
        Fri, 20 Oct 2023 03:03:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k9-20020aa79729000000b006b8ffc49ba5sm1168370pfg.38.2023.10.20.03.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:03:10 -0700 (PDT)
Message-ID: <6532505e.a70a0220.9547a.41e4@mx.google.com>
Date: Fri, 20 Oct 2023 03:03:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.58-cip7
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-6.1.y-cip baseline-nfs: 62 runs,
 3 regressions (v6.1.58-cip7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Oct 2023 10:03:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13408

cip/linux-6.1.y-cip baseline-nfs: 62 runs, 3 regressions (v6.1.58-cip7)

Regressions Summary
-------------------

platform         | arch | lab             | compiler | defconfig           =
| regressions
-----------------+------+-----------------+----------+---------------------=
+------------
imx6dl-riotboard | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig  =
| 1          =

imx6dl-udoo      | arm  | lab-broonie     | gcc-10   | imx_v6_v7_defconfig =
| 1          =

imx6q-udoo       | arm  | lab-broonie     | gcc-10   | imx_v6_v7_defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.58-cip7/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.58-cip7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      5608f0095a5ba83c76af0e5824c2e2d3f41231b5 =



Test Regressions
---------------- =



platform         | arch | lab             | compiler | defconfig           =
| regressions
-----------------+------+-----------------+----------+---------------------=
+------------
imx6dl-riotboard | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig  =
| 1          =


  Details:     https://kernelci.org/test/plan/id/653248b87a8224c693efcf59

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.58-ci=
p7/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-nfs-imx6dl-riotbo=
ard.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.58-ci=
p7/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-nfs-imx6dl-riotbo=
ard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/653248b87a8224c693efcf62
        new failure (last pass: v6.1.31-64-g93fc2d0f5008)

    2023-10-20T09:30:22.273770  + set[   28.244877] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1003756_1.6.2.3.1>
    2023-10-20T09:30:22.274177   +x
    2023-10-20T09:30:22.385556  / # #
    2023-10-20T09:30:22.487296  export SHELL=3D/bin/sh
    2023-10-20T09:30:22.487755  #
    2023-10-20T09:30:22.589002  / # export SHELL=3D/bin/sh. /lava-1003756/e=
nvironment
    2023-10-20T09:30:22.589445  =

    2023-10-20T09:30:22.690672  / # . /lava-1003756/environment/lava-100375=
6/bin/lava-test-runner /lava-1003756/1
    2023-10-20T09:30:22.691266  =

    2023-10-20T09:30:22.694285  / # /lava-1003756/bin/lava-test-runner /lav=
a-1003756/1 =

    ... (12 line(s) more)  =

 =



platform         | arch | lab             | compiler | defconfig           =
| regressions
-----------------+------+-----------------+----------+---------------------=
+------------
imx6dl-udoo      | arm  | lab-broonie     | gcc-10   | imx_v6_v7_defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/653249354f9b19e378efcef4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.58-ci=
p7/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.58-ci=
p7/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/653249354f9b19e37=
8efcef5
        new failure (last pass: v6.1.31-65-ge66be31505fa) =

 =



platform         | arch | lab             | compiler | defconfig           =
| regressions
-----------------+------+-----------------+----------+---------------------=
+------------
imx6q-udoo       | arm  | lab-broonie     | gcc-10   | imx_v6_v7_defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/65324937f7ce52e539efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.58-ci=
p7/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.58-ci=
p7/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65324937f7ce52e53=
9efcef4
        failing since 91 days (last pass: v6.1.31-65-ge66be31505fa, first f=
ail: v6.1.38-cip1-10-gf4eb42f19246) =

 =20

