Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BEEC4332F
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 01:41:44 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web10.12286.1702518102539271130
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Dec 2023 17:41:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ecy9y5w4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d2350636d6so142525b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Dec 2023 17:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702518101; x=1703122901; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3mN33jjghaRatcdoa4csPOD2rcZLy0msF0zXK6W315M=;
        b=ecy9y5w4TihWxm1OTFZZlGk5U3XdR8WsT8Wv6MkfvI3ObEra9KKhVcSG22/5JcGSWl
         XkYdhE1chwJ4abSr/Kc8mUkS9O09q/UiGTxdMmeKRSMgjB0Pb9MpmjT9lP2fUAttcFMe
         dzBS77ARDr3igGK9ISBflbaFYEZOS5mXu4xiLASDwYNKoUV0eAOEkbyHfF9WJmddpbiu
         QMgKfhEbi9mtunZl/smBblMjuuhrvt1uese1GYw9AY/4Rybugl3FTiT9kUvBC17vTVqR
         drhCZlZ10+/XN/NH0f7QXZvUh0YUJXez6y3R/7wXvbOTxlrZ7FWzpBhlqnZji5MJjaqb
         lkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702518101; x=1703122901;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mN33jjghaRatcdoa4csPOD2rcZLy0msF0zXK6W315M=;
        b=NewwPpg2zuSQBAuoxaBctsn5DSHJQ4uSuKfnIZpBf22JqgpC9nVYytxmf+KqzH16Mk
         N/zNxpoIUlUeVStVJv0QZhgzju+w3U6tPfXgCC1kKAqvAIUFYXJ2WxXBtgpw0qxzegs+
         2X61k6JbpRZ5aDLkhtrCo5q/sTBk+MlhyEF2qDnD+dzYdC7D3BoPR0AVO6p6ZSFSDdaf
         uGhxMQAUQb93rYYmRRUB4Zha2LedjNkVmp2BSJzstmek62KDO7je1A6vrPRqxPL9Yvqf
         Sgx5Tr5Uqqv/5bZ6WfKzHussQAi+Xn1rAzVfnOgGNpSkf/V1X8hiqY4pquZPBMkIIAsj
         GYng==
X-Gm-Message-State: AOJu0Yygli5AOfA4CN3Mg+fcyldbhIunQfLuczGar5TBddm+2mSg28TJ
	3f3HHUaQn/kfR0Jgo/H3VqiNrcihVsEmE1RUYz6ogw==
X-Google-Smtp-Source: AGHT+IFoYayKsZt3875Zh8aN8WOk4YzYiBCAhQURoEBbCqDsKVO79OmMkjEmkWvEEC5GoMszCRM3Yw==
X-Received: by 2002:a05:6a20:c329:b0:18f:97c:8a2d with SMTP id dk41-20020a056a20c32900b0018f097c8a2dmr8403858pzb.88.1702518100892;
        Wed, 13 Dec 2023 17:41:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i4-20020a62c104000000b006ce6b0d76d1sm11042270pfg.69.2023.12.13.17.41.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 17:41:39 -0800 (PST)
Message-ID: <657a5d53.620a0220.8e352.39e7@mx.google.com>
Date: Wed, 13 Dec 2023 17:41:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-473-gc43d7b7bbe83a
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 9 runs,
 1 regressions (v5.10.201-cip41-473-gc43d7b7bbe83a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 01:41:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14078

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 9 runs, 1 regre=
ssions (v5.10.201-cip41-473-gc43d7b7bbe83a)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-473-gc43d7b7bbe83a/plan/kselfte=
st-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-473-gc43d7b7bbe83a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c43d7b7bbe83ae0f7e001ac115b838d7cd1afe79 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/657a50fe2b438c4ad7e1348d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/657a50fe2b438c=
4ad7e1348e
        failing since 41 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

