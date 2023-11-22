Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FCFC61D97
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 20:34:52 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web11.35386.1700685287199081772
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Nov 2023 12:34:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=AqAszdq4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6c4eb5fda3cso213132b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Nov 2023 12:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700685286; x=1701290086; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WmgusygaJH91hOQsbrWk3tQ7z9d6Skm4c/AFbJ4qp00=;
        b=AqAszdq4XsGl4IcjudpwvgKJ/ep8EHfljSXDCnMW/yfI5/tZHpPuLtplojP/WjXzwi
         Yv4Wmv5CQn4nHJXVqkQnHyO9W7YS0lIQSfZgsIOv7T7PYDQ/hzWQUt3T7kSrPU/XwSkK
         pE48xfrJ/Y9XyYR3QcwnrJgb0ZaPHFDd3G0DariiPDUu9Ax9ocT6enj/teGk1YuS2wc1
         Iwu3gXDfY5tu3W1mFfGZDcIgxZl8dLy3DfmG0O6B6mhQOKjI3urOXHxk2JFQj9iZIOam
         OxaIW4cekDgEKNgKUyyFb5YvDNQFVvEUFRIM3o45JsQ2Z6jk+Vk/G9s7WKlq3bHsOXHt
         0FtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700685286; x=1701290086;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WmgusygaJH91hOQsbrWk3tQ7z9d6Skm4c/AFbJ4qp00=;
        b=BmGUG7pWed33Wv8TcOzt0VIfvXgjklHzIxdRLNA/X8ZsPrtb1fxiSk/+sauPIil1TJ
         zqCXE9wKM9buX3FCXsX1MqYS848vAMg/XK9L47Dj6O7Nrw2ChkaiBkheoJWteAWwNEtb
         7T3hLX1m42mnPWAZgU+z+K0SsejJj4HM+DEKI3wjSIxZhDLkSpMqj31PpRQG6mlq+CWx
         S/BDdv/+ZWnJWXcLfgaNsxxjOyI0bgnff+EBoZG2mUr4UHF+35Gu7tQ++lCEp8Boh5Uj
         mtEk+uJy3JQmYlrsmA+26hWM/7rXSdli0OV8UxOaIhNJ3Y8KVc9jCgaMS8YSKmlNfEd+
         dVzQ==
X-Gm-Message-State: AOJu0Yz256grlWJQQTJT/ZntxB8RjSM9xtlsNeK71GzoLhsfPQU/bNEE
	mPAhf10WCZpWqWsO87wVwpnN+F/gFUfl8dr/Aiw=
X-Google-Smtp-Source: AGHT+IHWlehuZnVyLeJoXycwVLuf9Wb5Xt5Q2qg+Agd+RNgM7XLbfxINdMgIUnN7foD+zPjq+zYkhQ==
X-Received: by 2002:a05:6a20:1456:b0:18a:f462:5d3c with SMTP id a22-20020a056a20145600b0018af4625d3cmr4248853pzi.12.1700685286170;
        Wed, 22 Nov 2023 12:34:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x16-20020a62fb10000000b006c345e192cfsm133830pfm.119.2023.11.22.12.34.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 12:34:42 -0800 (PST)
Message-ID: <655e65e2.620a0220.d529e.0d1a@mx.google.com>
Date: Wed, 22 Nov 2023 12:34:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.200-cip40-188-g33d0b44cd71d
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 8 runs,
 1 regressions (v5.10.200-cip40-188-g33d0b44cd71d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 20:34:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13649

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 8 runs, 1 regressions (=
v5.10.200-cip40-188-g33d0b44cd71d)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.200-cip40-188-g33d0b44cd71d/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.200-cip40-188-g33d0b44cd71d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      33d0b44cd71d9f81944784e605bc1def7fa0b71e

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/655e5451d66f35c2717e4a7e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/655e5451d66f35c2717e4a=
7f
        failing since 20 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

