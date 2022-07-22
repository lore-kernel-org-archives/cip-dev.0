Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6410C3F2D4
	for <webhook@archiver.kernel.org>; Fri, 22 Jul 2022 18:14:17 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web11.11162.1658513653034850682
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 22 Jul 2022 11:14:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=ECI/e2fs;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id c3so5074831pfb.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 22 Jul 2022 11:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ITLHYcs6Exb2048L81U+RLxywamE/VvfYBk3C6laZ6A=;
        b=ECI/e2fsCu9Cja4yygpTwLZiPC/wwjdgu0VVsSdKcQDGtdnd1M5xPy9G+P3RGHT7Cp
         Z5WoNMnH0PtsQUVePO4ZgR3qMWZwmZGCWdeSd9S2AC8lL9lxfjkQtFyhLqTX8+4W7Uom
         n9yhWSQCH827JrXI7uB6p/GuBNH+ykOynGtwqgJiw0oI2GTLH0gt+l0zAyEwTMg/94St
         vnixyy9EeWkKTEReLn0doKXzmJdo2sy1uXe03cu1aUNZwRc5JeTfrzIFlzqKQym3katY
         RBkcPHleIU4/sHPa0Ky68+H+ShCbEPDF7V5xAM/9mZYliLL7DoPonFlzbFnZkhz/TzOW
         3Ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ITLHYcs6Exb2048L81U+RLxywamE/VvfYBk3C6laZ6A=;
        b=12iDmKNk4rVChH1rD0Y8sMld338zwB4wIpZNuip9rht45Y7FLnci2dd6qwEekLvU8c
         bI4Apr4TTTV10+u4N6wTNnG6AUCPzAhxZsCR1WK1WjqfRjPjL7EashG9AUBOwYCKR9Qj
         P4fjLl5v6I8fPpxx4tTE6MBCLMlybxwY9s5J71VPRy6/pNEqi9eZKZ7AGUGIocX4Ax73
         T9ph7gCAGMrB+cxOeaKADd1aug26sAGbLrqD7ibhyKXfDEvUtusnNQ36aZxi0o6zX/Iq
         OhFpMFsgC3/w/FPKrH3LNDQBVBVC5/MS7WaGYQMFbyO0t4yJ1eZ420Rp73ZUn72xnrax
         erbQ==
X-Gm-Message-State: AJIora8vKGeT8Z1SA+Br1AwkBWZOBd1VvwNSb21TRFCCMiNsrxtEqamI
	QfpD/n1KX8rsTC8NTT3HE/oM4ggUsmQhL0lL
X-Google-Smtp-Source: 
 AGRyM1uyz28SsZ8YMRuA6iPcvegp2qPhrAa/cfxroPcZBWsOB9nO3wDU4DeSE6pr8lKRmzoZPNxWRA==
X-Received: by 2002:a63:4045:0:b0:415:fcde:e64 with SMTP id
 n66-20020a634045000000b00415fcde0e64mr836731pga.344.1658513652200;
        Fri, 22 Jul 2022 11:14:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 q3-20020a170902dac300b0016892555955sm4120736plx.179.2022.07.22.11.14.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 11:14:11 -0700 (PDT)
Message-ID: <62dae8f3.1c69fb81.ac6a3.6e22@mx.google.com>
Date: Fri, 22 Jul 2022 11:14:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.251-cip77-82-g10c370b53152
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-fcntl-locktests: 7
 runs, 2 regressions (v4.19.251-cip77-82-g10c370b53152)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Jul 2022 18:14:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8887

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-fcntl-locktests: 7 runs, 2 r=
egressions (v4.19.251-cip77-82-g10c370b53152)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.251-cip77-82-g10c370b53152/plan/ltp-fcntl=
-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.251-cip77-82-g10c370b53152
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      10c370b53152e01c8282be083dc0943e33d50ead

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  bda92ad659a52d38ac810099f69adff626b064c6 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/62da57d58a94f379e5daf064

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig/gcc-10/lab-ci=
p/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig/gcc-10/lab-ci=
p/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/62da57d58a=
94f379e5daf065
        new failure (last pass: v4.19.249-cip76-57-gef3cc1b9e556) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62da62ed7c648f6f1edaf056

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/62da62ed7c=
648f6f1edaf057
        new failure (last pass: v4.19.249-cip76-57-gef3cc1b9e556) =

 =20

