Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95C8C41535
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 07:16:52 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web11.23087.1699600606404359893
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 09 Nov 2023 23:16:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=TNpOPfvR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1cc1ee2d8dfso15806485ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 09 Nov 2023 23:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699600605; x=1700205405; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xfgmd66Y8nXK8+xJUzi7BTJhPraj4g8SvOdlp1Fsd70=;
        b=TNpOPfvRBWKr88QhVSk167AHlK9eSurRKyabTZ31ZN/3mNNY7vKQw7CRZB4kEI4H3J
         W9GHlp2miBmwJi2XCZRfOZrvSZkdzv9veynvZilTgyzrV2Pq8qM92QSS3XZ9M2a6rDld
         pT5LhR4zQlBlOTevBhFfy2twJ/B3W+6tdAzyr5FJaKlyIOtK/xarhtlrrxg+JdhBBVM6
         jyMnzK6GynNldYG3FBA8ZI201M0x6//qvTs8+2ecJz6GOU3C2gX+6GDMcF1cGiT6gnSq
         bIDK2IYirZobehxzj0gP4HS11nAqYwYioR+zEm+MS22ek+6Jh74PP4rP+Z2Vo/PbWPxo
         IxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699600605; x=1700205405;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xfgmd66Y8nXK8+xJUzi7BTJhPraj4g8SvOdlp1Fsd70=;
        b=cEfGDsZD6DzwllrCoRLbn+pFEZd9EQh4ECPZPsxoEI4jF3f0J7pfEc2xjTgYo0uSnR
         uXpRlQvEcwhs4kFesC4vukmjZVMqHiLVm1g65qa89YIXmuKr6t0LgH5m7iC06LAtQbz0
         Wa5q9QJpO+/HUU92iQWAxJsW91k8ZYxjpbo4UDxNX4LqkAFgdrV3ejWaJ7THN4zQrtwO
         sRSn9lAK8F9Zye0HFhM07t8jfjOjMU7WWV/tnAskSVTMQCQVxBTtrG9HjWsRSXgTDNIA
         IKSuj7+jJb5he/o9hAZ7NThBldyGhbOPnCrlN7c05uTHHwvhKKbwqI8E9xtBb0InTYhT
         og2g==
X-Gm-Message-State: AOJu0YyOMGPawIWw5G7QVzzaTwlZK48DEKg6oHmy9H+KpINbvicpeNO9
	rTjMOVeLBu5i8gS5wLmCSy+8uAw4Lw8+wApfCf/idA==
X-Google-Smtp-Source: AGHT+IFBu9P3vVMJp1tj4K7Ddp57476qmZdeulszf9VzpkJjpL2Q0DPhRg192bzXh5F4ZRCILnGuGg==
X-Received: by 2002:a17:902:c1c6:b0:1cc:29ed:96ae with SMTP id c6-20020a170902c1c600b001cc29ed96aemr6784659plc.41.1699600604912;
        Thu, 09 Nov 2023 23:16:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jb5-20020a170903258500b001bf5e24b2a8sm4708661plb.174.2023.11.09.23.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 23:16:40 -0800 (PST)
Message-ID: <654dd8d8.170a0220.4cb23.e86a@mx.google.com>
Date: Thu, 09 Nov 2023 23:16:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.200-cip40
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip ltp-pty: 6 runs, 1 regressions (v5.10.200-cip40)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Nov 2023 07:16:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13561

cip/linux-5.10.y-cip ltp-pty: 6 runs, 1 regressions (v5.10.200-cip40)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.200-cip40/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.200-cip40
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      166400a23a22e665f5d880a99149b73abede402d

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


  Details:     https://kernelci.org/test/plan/id/654dcc99985810062aefcf48

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/654dcc99985810062aefcf=
49
        new failure (last pass: v5.10.184-cip36) =

 =20

