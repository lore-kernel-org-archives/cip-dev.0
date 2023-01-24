Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D08C38142
	for <webhook@archiver.kernel.org>; Tue, 24 Jan 2023 13:46:59 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web11.15069.1674568012010070648
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 24 Jan 2023 05:46:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=MolWvwP4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id 88so3361092pjo.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 24 Jan 2023 05:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5ES7VCh+HdEHYYL/O389vjXpL216OAaklh7t64wgdds=;
        b=MolWvwP4Bmad+EoRpV0CD85lI3HXueLVQ2H2uwu0y63gItY8CtWQxLqatYZ62xoYte
         NEzsX6qKGWnLUethOXG08IGStm795af6hjU7/8hqG0fNXG/KQGB+MzzTQBL2Jwuv18fy
         YRuUhvWPij52Zgu++lLIXRBcdrSzZ7yRfyyc/g65QvcVpFFyMtUdbHFEKrQIgoSL3i86
         WEf4pXFKczUtio/JZfOZ/G2rj42MmzrymQmgAXg6TywfWA+kIRMlBLDbFjGzEaW9idYI
         LtqG2CWEPB6HpJCDRNWZCLUWBhWcEeBkUH5jOCW87lGxA88g0zUPcxaB3i/jPJiSsfep
         eg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ES7VCh+HdEHYYL/O389vjXpL216OAaklh7t64wgdds=;
        b=gRr2lT7u+/0nEUbKJ5mthCrR7nkxwAy5xvKM2OIkzyB5WCQPCnh4cbqhTaAo4nqn1h
         H9VprlVz3KEoRQB24wao8m1jSp+8r55SedWAt9w6dfM3t89ALp6P5cs+ZiChUWzBcwEP
         8RoXhMMIYQL1edSR210d5gwaJpWjgP4S/oqsdeq18n0dFYGJiFvGko4x6EjKpQHr5zj5
         MsRujCxkpHFhB/iPXpewjFecwN1kOC1dJ7lvm70nIq8gI9ELK4JJzKIKZLSuiQLTm2hb
         bgalGTsuTK0SZSydQoPp5dihXJ+gHPzHKf3Yr/P1VXI7t2Zl9ITT1LPazGsxR+n3y/y0
         wnMQ==
X-Gm-Message-State: AFqh2kqEusXNOCaLQm0ZgigwxXzUCnFymhonLPVJ6V7Egc5JYkFItHtx
	ebMTJicGwIHTyHHOVKMoqmBXBrgCBXX6e+65qBM=
X-Google-Smtp-Source: AMrXdXtLsw3L11x9FSAHsAtz7FOY3RksDXIHkrTjDgUfadqzokgMPymcgf5kog9siSm+FCRGMvPTTw==
X-Received: by 2002:a05:6a20:d399:b0:b8:9086:4056 with SMTP id iq25-20020a056a20d39900b000b890864056mr31776111pzb.50.1674568011329;
        Tue, 24 Jan 2023 05:46:51 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g10-20020a63b14a000000b004ae6e97ed10sm1430352pgp.17.2023.01.24.05.46.50
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 05:46:51 -0800 (PST)
Message-ID: <63cfe14b.630a0220.d37c0.1f2d@mx.google.com>
Date: Tue, 24 Jan 2023 05:46:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.162-cip24-952-gf408044f5bad
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 9 runs,
 1 regressions (v5.10.162-cip24-952-gf408044f5bad)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Jan 2023 13:46:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10469

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 9 runs, 1 regress=
ions (v5.10.162-cip24-952-gf408044f5bad)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.162-cip24-952-gf408044f5bad/plan/kselftes=
t-lib/

  Test:     kselftest-lib
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.162-cip24-952-gf408044f5bad
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f408044f5bad2c96806e41c8eac61744913398d4 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfd53aa8b640ffe5915ec6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-952-gf408044f5bad/arm64/defconfig+kselftest/gc=
c-10/lab-baylibre/kselftest-lib-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-952-gf408044f5bad/arm64/defconfig+kselftest/gc=
c-10/lab-baylibre/kselftest-lib-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63cfd53aa8b640ff=
e5915ec7
        new failure (last pass: v5.10.162-cip24-853-g709bb3738fde) =

 =20

