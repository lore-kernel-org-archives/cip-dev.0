Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD699C4167B
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 17:49:19 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web11.38289.1698947352044146519
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 02 Nov 2023 10:49:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=JbWUidet;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1cc30bf9e22so9848745ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 02 Nov 2023 10:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698947351; x=1699552151; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8oKJEPrMiBosaVAGkUaz+mWrhbvHJBvetr4Drdh0BGc=;
        b=JbWUidetIdoxNzQd2mSSMYUmTQgm/e2VyB3msx7W6Xs07DhW7LONP22XyEqDsvVLyp
         P+PiqAYym7Ln0/4B0nxilK8w/ySlV8prIV48G8eKvfJNerh9Rc/Ecx+5GE0AaazjfatU
         +yFJqpABtAmfQ9W1sIuf0w7tRfHenIL7Yg8hdVBpPacL9HLfyTeWhNragYw6ZLUaSNcu
         Xpb/2CS3F6dy3ER1xqaNaSL42KuqOKQOgPd2F/F/UKZLYiKuWBlt2AMn0F7X1vnuo3w3
         CK3WNxI3LAXIRlIFKdoX4Pb7hCJmX44JkcxjN+HTNrOtprv79KFhk6VsKe9SgdiU/CDC
         qOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947351; x=1699552151;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8oKJEPrMiBosaVAGkUaz+mWrhbvHJBvetr4Drdh0BGc=;
        b=qPZhQwVi/ujxpf9ZbI4iTaLBUeWjV4qg003a4GjYq/w60g4PqF9Ln8ubo3WFwY3WUW
         k+1YLkh0TlZKTQ5aN2riv04P0MLe1lW4IopFZKGgY5Nbqe5R7KN72VpzSXn9BBGNMg/7
         yfzDnqf2J6BzMIiVB3phiX88LjGx5MH8AVo8W1zTuQqmJus7pxrOxQbu5BWe5KjR70zm
         7Fab2lKU+to0t0+BLMeauqOyEI3S8PkwgF8AjJLhAKNkp1knphKxKAJR+KAKOLO+FH1B
         qankUcYq8L4lZgE7HntnepFkMsYfOvu32kas7gYKnG26W7rLIdmEBu7mBDy1yO/JjRA+
         rJ9A==
X-Gm-Message-State: AOJu0YyRx0Uhr2Zk+JfAspYeTuRmocS9M840n8kvXhjBF4PXyy82b5fy
	qmhbFfhAHx9ZfHrYP6qNGsaRbkW2b6JU3+qYZnvtEQ==
X-Google-Smtp-Source: AGHT+IF50Hj4DZxQflH2EqEBdejWNLLq4ZTr9cUx5gv47Uy493bEbvBl1EAauBzQNZwKpqDx/ABjug==
X-Received: by 2002:a17:902:f68f:b0:1cc:6101:2094 with SMTP id l15-20020a170902f68f00b001cc61012094mr503814plg.14.1698947350978;
        Thu, 02 Nov 2023 10:49:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902ec8e00b001c6187f2875sm18733plg.225.2023.11.02.10.49.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 10:49:10 -0700 (PDT)
Message-ID: <6543e116.170a0220.4ba51.0180@mx.google.com>
Date: Thu, 02 Nov 2023 10:49:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-cip39-915-g96fa7f16cf02
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 10
 runs, 1 regressions (v5.10.194-cip39-915-g96fa7f16cf02)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Nov 2023 17:49:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13522

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 10 runs, =
1 regressions (v5.10.194-cip39-915-g96fa7f16cf02)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.194-cip39-915-g96fa7f16cf02/plan/kselftes=
t-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.194-cip39-915-g96fa7f16cf02
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      96fa7f16cf0228e65eeaeaeef1b73f242f4e169e =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6543cefc9a21c01371efcf1b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/6543cefc=
9a21c01371efcf1c
        failing since 133 days (last pass: v5.10.182-cip35-191-gf4efde51295=
9, first fail: v5.10.182-cip35-289-g3c0549540706) =

 =20

