Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2602CE7B5F9
	for <webhook@archiver.kernel.org>; Wed,  4 Oct 2023 11:41:30 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web11.16084.1696419687400208337
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 04 Oct 2023 04:41:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=E+8yk8i6;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-694f3444f94so1572125b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 04 Oct 2023 04:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696419686; x=1697024486; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pq3nodkPGn+fhdODnLpyYXnmyxtmikq/BNooqUMpjbM=;
        b=E+8yk8i66l6Zytnpy/CM8Z9qoPCfXnNJfmssznNfZ6oWJSvTZkg4QApWynd6rkI2Xs
         AW+tei3fSF3T8jHBJJzwc/QBG2/bFdFDe2Dzb4BjCoS9ViWCZwV3seYjVT736VIhUDqG
         VqPTqepHBKYIc0VTU46c54k03J4lVvmW7zqME4z0ugkEdlk8JmiEuHsPIwDTOC9Z0xlm
         CP+FfiLVhxN5TqPKDFYbKIxP1iBrq7CzxmdZ6BRb5R0sni4WSINEypjxUlgZfqm8LQhc
         Dlm9a0tNRqN5OYiGQXzp7SbZ2hKNhhvSY/HCnDGxzLCiD06nHKtusbePtvEdYaLgqAFc
         A5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696419686; x=1697024486;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pq3nodkPGn+fhdODnLpyYXnmyxtmikq/BNooqUMpjbM=;
        b=w6qbKz0jba0DZsJZYvnMW0dBCKQDBxAAxdQ2tw6VcqKOxtgfmcrBefl7iZsni9vSDH
         vDMkOTvQwBdwXRG2HqFp+hOeSbpSLJBUP9kldDLOQLH7RLpXIWnGHOLjZAu0RepY/xfy
         gWBracE43H3vhd6r9PB/A3H1FJfjOLB5VcNCiuDp2CBzIXe9jpdzbU29OC/om5kIjD42
         7X4CxIrw3ev7JyVRGt3LvcBzATHYDUGETLm42ORwFuLZJkP3QlhICOTGdWvYSWvkmN50
         kSbu/ydg68aDwVwXCem+kWOyhKO58+oTm8aRtY8G0vpmBYf9bHrOte1AgeYt3qu9wepm
         33KA==
X-Gm-Message-State: AOJu0YxA7aiqhKDt0kVvW8xTYvqAzo8HMQ1S4MDomyPfV3ZpC7vTnOsn
	jDcs8VzvFYhxdxZXh3X1Lc/Z6PZmdxj9pz13ypaHUw==
X-Google-Smtp-Source: AGHT+IH1z/rSU+mzWUfdkNKqZ2jEDci4jAoY4oM/kF6HXmv6CxZd4du9OPeWIBnoTPJl6iaPoL7OEw==
X-Received: by 2002:a05:6a00:1956:b0:68c:1004:1feb with SMTP id s22-20020a056a00195600b0068c10041febmr2359685pfk.32.1696419686067;
        Wed, 04 Oct 2023 04:41:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gx13-20020a056a001e0d00b006934390d0c5sm3141421pfb.175.2023.10.04.04.41.25
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 04:41:25 -0700 (PDT)
Message-ID: <651d4f65.050a0220.c2216.82ee@mx.google.com>
Date: Wed, 04 Oct 2023 04:41:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.194-cip39-1-g53e59f50ca3ff
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 13 runs,
 2 regressions (v5.10.194-cip39-1-g53e59f50ca3ff)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Oct 2023 11:41:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13273

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 13 runs, 2 regressions =
(v5.10.194-cip39-1-g53e59f50ca3ff)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-cip39-1-g53e59f50ca3ff/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-cip39-1-g53e59f50ca3ff
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      53e59f50ca3ff023b612a48397ad7e057a9fd408

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651d421e4a064c5b7d8a0ae5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/ltp-fcntl-locktests-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/ltp-fcntl-locktests-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/651d421e4a=
064c5b7d8a0ae6
        failing since 111 days (last pass: v6.1.26-1320-g1ddf4b637f785, fir=
st fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4126fe00f676058a0a4f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-=
locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-=
locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/651d4126fe=
00f676058a0a50
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70) =

 =20

