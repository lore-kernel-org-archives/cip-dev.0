Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A788E7B609
	for <webhook@archiver.kernel.org>; Wed,  4 Oct 2023 12:23:11 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web11.16801.1696422187745807138
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 04 Oct 2023 05:23:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=V67NF3Q7;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1c60f1a2652so7138365ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 04 Oct 2023 05:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696422186; x=1697026986; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5mIfoSnS82VX9dXic9JWI5OFRdzk9znVdeoZgIR5jho=;
        b=V67NF3Q7W6dPT7QKsEq4tbVQO8vuQEk+wUAt/fkLfoFS950xOqZIzOGDvk/66ZEiNg
         hlGBDINlabFu5Hg0CsLs1NEhlzsuGBbBeOgqf/c5fqhHdSbgvmSkZ6Caxcf5T+8Es9p6
         IkNPOiQu7VkVpsgHnnmiVkZChsQxrBmCJGMQIPWY3vl7FPzniPm0VVizs84b2y3PRoLz
         7BcfPHeoUcm1VPqgSdBO4hXeYjkbCcicOg62LY9X6OnocI/pOhJooC5L3QMWRmEjhDdy
         vMZcByuzL2WxCFPGxC7+O8N3ZwV6lEgK/sz7Cn42nrrlM9KWZYInE3rV9HHT9is7iKbT
         qM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696422186; x=1697026986;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5mIfoSnS82VX9dXic9JWI5OFRdzk9znVdeoZgIR5jho=;
        b=K+l9nG86MpOQz65l6/Cv74jsp9sXu8q+yBOHlxa/xnW2Q83EDXmNyLlGr0zINF9bQK
         C9Z1bP98aM3QQDlhRvcngn3SD3vLVREeHYaD+w+qjBmyZv7ETRHR0posCmDRAShCokke
         TDgIkcdELJt53khlbIOWIU6LMOrypBftL8teBQfMQXDeCZQXRWiyeW/BZ/C158y3vyXG
         pIwYNSe86rR4bOpR9p3Qu5HCH6GoVoYBpX81ElkcudWTW+eHSoZhrvjJlDvKCaMJP7Jc
         9rEdigNqdWUrUHBz9A1WGq+6GcphNaNazNfvCMzs/QLwD/Z/gP38TONyYfsy4+AtIUy2
         JQCA==
X-Gm-Message-State: AOJu0YztFoyq3kFWXE07mpZOGg8R+TMTP9Hppe9wi3RuHYkvveAj5wbx
	+sxfeyHbAQN2H+mHJVso8sMhQDV3v2sZ76u0m0BWQw==
X-Google-Smtp-Source: AGHT+IGYcIixgXIlE1zTe4gywmqrmViWmCm7ELZkuQIYMA/JQCZtgKVstVRUGFZBK3TOW0aq2nXZ/g==
X-Received: by 2002:a17:902:d491:b0:1c7:2e8f:c3b5 with SMTP id c17-20020a170902d49100b001c72e8fc3b5mr3301044plg.20.1696422186606;
        Wed, 04 Oct 2023 05:23:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b001b87bedcc6fsm3533955plh.93.2023.10.04.05.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 05:22:59 -0700 (PDT)
Message-ID: <651d5923.170a0220.c9e0e.8e86@mx.google.com>
Date: Wed, 04 Oct 2023 05:22:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.194-cip39-1-g53e59f50ca3ff
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-mm: 7 runs,
 2 regressions (v5.10.194-cip39-1-g53e59f50ca3ff)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Oct 2023 12:23:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13287

cip/linux-5.10.y-cip ltp-mm: 7 runs, 2 regressions (v5.10.194-cip39-1-g53e5=
9f50ca3ff)

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


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.194-cip39-1-g53e59f50ca3ff/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.194-cip39-1-g53e59f50ca3ff
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      53e59f50ca3ff023b612a48397ad7e057a9fd408

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
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4d5729597ca4608a0b3a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/651d4d5729597ca4608a0b3b
        failing since 630 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651d545e2e44a617de8a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/651d545e2e44a617de8a0a43
        failing since 630 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

