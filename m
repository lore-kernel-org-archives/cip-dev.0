Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3765C38A2D
	for <webhook@archiver.kernel.org>; Wed, 26 Oct 2022 10:08:12 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web09.5878.1666778887694199060
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 26 Oct 2022 03:08:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=spHA6W0W;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id d10so14785411pfh.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 26 Oct 2022 03:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gaGqakyTJ+AGhZsH7BJlSJAvmJ6Ra5k1IxQ3Ixt2sUk=;
        b=spHA6W0WUZOkhd1/oe4tHHk76KJ5z/kAqO7AQMFK4TLAn0G0D+nxY3UQT+XIlmS+m6
         +xF8u2BJaImBrCJ4JGfYP+Rz7DsykpVbTaik4uZw0Jp8HyYpL7+5rq/0qbT7WSpmIkK7
         Z8cZuf5nraqGC6nqAUU6rHwCMD9odXNZuCNPnFZyWIh8mAyAIUzmSN5UtcT8SnJXCfFq
         DWeU8uDKIxk+g5cDUjkqBXHo/cmK/+wUPFR60ouoS98LIpXuSB3ib9NGw3uO1A5r/2uS
         pb+QGeazqsvNW4d7JqR/jQyGIzpzpj1a6tT4Nl9BCgmx77fj+emq18YPYRZ/7i6RX5Da
         RAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gaGqakyTJ+AGhZsH7BJlSJAvmJ6Ra5k1IxQ3Ixt2sUk=;
        b=tQqJHlSQZjjCtZvjpH+xOr/HsTabo0hE+MzgNWLapyfhKpze124plb/z1ol/P7nFr8
         Tf+Rmd9zMq9MXOG4Hb6+fFEVH+k9P/rro0TZgocbLOTejhv82wnTc0PfDF4Slvk/upCp
         VOL54Ur0qt6itTfl5XpO0gtSZtk3EOOmqz7p4uRkqNsYJaQTn9gl7rssOKny48UeS36R
         THDyX4DERg82+uYgA2NkTOP8OXdtxJybHm8F1vnqOcQQHSn1qdmQqiTjyJTNB5N6EBWr
         5+XJLzp9DvRqhmYHSOsDg92Xg60xDNrzjsxf/M/NOs/LYHza/bhyYSW8bHoVPPpyvpxW
         YwgQ==
X-Gm-Message-State: ACrzQf1YtICp9wy5/LNJVpZV8raagFjWhNB7BnOSv1WNLiVN0SkRDQew
	Uk6o3fbj0iYndk2gf/pm5KR+v7AZ0IHYf2RN
X-Google-Smtp-Source: AMsMyM5oWE9bZSN7AXaEUHXQul/DazRJ9i4zOELU82HJXGf16q6uOHY7dFXOILODgOSyedhBhmIwlQ==
X-Received: by 2002:a63:1e10:0:b0:439:3c93:25ab with SMTP id e16-20020a631e10000000b004393c9325abmr37376274pge.317.1666778886939;
        Wed, 26 Oct 2022 03:08:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i5-20020aa796e5000000b0056b8181861esm2832360pfq.19.2022.10.26.03.08.06
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 03:08:06 -0700 (PDT)
Message-ID: <63590706.a70a0220.f9b2e.6470@mx.google.com>
Date: Wed, 26 Oct 2022 03:08:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-11-ge6d27ea102c3b
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 10 runs,
 2 regressions (v5.10.147-cip18-11-ge6d27ea102c3b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Oct 2022 10:08:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9854

cip-gitlab/ci/pavel/linux-test ltp-ipc: 10 runs, 2 regressions (v5.10.147-c=
ip18-11-ge6d27ea102c3b)

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


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.147-cip18-11-ge6d27ea102c3b/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.147-cip18-11-ge6d27ea102c3b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e6d27ea102c3bf928bd8f3a0815361cca9797bfb

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  48cfd7a9977e6268b4aa2600608cebad7e0e42b8 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6358f8dad31624e8f15e5b54

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-11-ge6d27ea102c3b/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r=
8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-11-ge6d27ea102c3b/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r=
8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6358f8dad31624e8f15e5b=
55
        new failure (last pass: v5.10.145-518-gc75907dbbb95a) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6358ff2eaa109a5ba85e5b55

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-11-ge6d27ea102c3b/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-11-ge6d27ea102c3b/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6358ff2eaa109a5ba85e5b=
56
        new failure (last pass: v5.10.145-518-gc75907dbbb95a) =

 =20

