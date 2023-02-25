Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E51C7EE2E
	for <webhook@archiver.kernel.org>; Sat, 25 Feb 2023 19:56:00 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web10.51914.1677354957041077647
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 25 Feb 2023 11:55:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=x7bUFAOP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so8600565pjn.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 25 Feb 2023 11:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c/+HXkCSZOn0oThzmXmzfJJbHhm3OfF9v26l6ohkUiE=;
        b=x7bUFAOPIFgpWLtMyvYyi1u2Ji/WnhR/Z7uN6dSa4XRVpjPKKNNqv92HpuiPAQzKAv
         ZFtsgMTHvH0n64fnXqCOPsrR8qrfahKC/o9Gej8PeRAjCPZnOOd6I71UD0P1k4IPjzKt
         BmDOsoAVfPaco1r9w7NJtIhvG17wj18N/p+eI9k+E1J6EDuriDVUzqQgjbIoala3Wmrl
         1ixkACLPdo57Zwx9gpNJIM967a+pqiJw6mjdqhJ6Y4m2jJSFs081APqqI4rQVjvjUjEK
         Pig8LRqF6RYdy3f54KhNr09WGApw08hJJ/rA6uVh1HVS0s9RJ1/ga3C7rg6PjcIesDhw
         qO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/+HXkCSZOn0oThzmXmzfJJbHhm3OfF9v26l6ohkUiE=;
        b=msjVgvOmvs/4VcHaJ7ZvpqPcybwEt5xHLGBqgZXeRK0oo6dmc6gqEFG/FYgOAPR3V/
         geJur5jfnkOKKQdhlml8fNwpoNWx+daFXzsAv6zUim2dhIZFV2jh6HY0RxCb4fN7HYM+
         qq6Eiz6qCmyf87+fKixMBfAcz2R13d8AEdYnwA/si5Wb3h//f25pBlkSglssYvmeWT8m
         j6LtkYn1G6TYsVK8T/krfnh0lzzSA9VHcZoyKRcNRYT66Dj4O3eB3nGXxMvK+pmwkRHz
         dPtxNHikPbyrJ3gvmcCycsyf6fI33oq9V1pV1EepapJM0XPlkPlb4WvHJ67L7KuQ6Cmk
         +a/A==
X-Gm-Message-State: AO0yUKWlOP5YBZ+ZXVqbTicjgfWINAIlcwS8oI0fapr5haDZTOXtwxCL
	9rzGBEZc5JYlD0ES1VZHTbxDwUjn+PQs6qrQL6I=
X-Google-Smtp-Source: AK7set8JJ8espIFSlXTV0yijd5xLjxbTpdGZO2zHViJAgY39fSn6NWBKUOcC33SY5tjUxB0nafSWWw==
X-Received: by 2002:a17:90b:1b4e:b0:22c:5360:684e with SMTP id nv14-20020a17090b1b4e00b0022c5360684emr21722074pjb.29.1677354956316;
        Sat, 25 Feb 2023 11:55:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090a1d4600b0023739b75710sm1602562pju.10.2023.02.25.11.55.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 11:55:56 -0800 (PST)
Message-ID: <63fa67cc.170a0220.98531.2df7@mx.google.com>
Date: Sat, 25 Feb 2023 11:55:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.168-cip27-86-g19cf8cd2dd993
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 8
 runs, 1 regressions (v5.10.168-cip27-86-g19cf8cd2dd993)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 25 Feb 2023 19:56:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10849

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 8 runs, 1=
 regressions (v5.10.168-cip27-86-g19cf8cd2dd993)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.168-cip27-86-g19cf8cd2dd993/plan/kselftes=
t-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.168-cip27-86-g19cf8cd2dd993
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      19cf8cd2dd99376e3a8b44aa56fbc1e1f7bfb770 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/63fa5b137e8bb0b1a08c8637

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/arm64/defconfig/gcc-10/lab-c=
ip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/arm64/defconfig/gcc-10/lab-c=
ip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230217.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63fa5b13=
7e8bb0b1a08c8638
        failing since 2 days (last pass: v5.10.167-cip26-2-g1e87e7748b91, f=
irst fail: v5.10.167-cip26-192-ga2cd4acb16b2) =

 =20

