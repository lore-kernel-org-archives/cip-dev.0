Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495A2C5478C
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 19:50:26 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web10.33380.1709322625359667874
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 11:50:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=t9lX8Twt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e59bbdd8c7so1902945b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 11:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709322624; x=1709927424; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iGQ+ZKuGx36oVhJwln6ou1++r7VdKF2cJNaqcbZwn9Y=;
        b=t9lX8TwtigW52LG0MKfM367EB7HagEtie2wlJLsSEEimS019ySaAQmKh2Hrbyj/Stn
         Ugp4fvpfPJv+2qMma9BFeKI7tG7IF5llaS1pdTZMsGkdUcIBZOqychuKoKcKD7tzU8NT
         ScL+trF8ImYx8NsLuH832PuB2jNbLeIyv0YmAl3f1CAj7WG9r/BTAksJYCwyfChZRWys
         1Gf85m5OE1HIRapl4//0bmL32RWFBgNXaGjOKqL6/Uq6x96qkKeIKB57WSsKCR7yBpFz
         dgToLAKsDXweg/iIRjj5RnDDrrsJH/GZuJPK2qZiinmv6WGfdDTo3QE10n9ctoGBtrnj
         Xejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709322624; x=1709927424;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iGQ+ZKuGx36oVhJwln6ou1++r7VdKF2cJNaqcbZwn9Y=;
        b=CtT226CE7Qx2hn7T2v9cMCqUmJ8wajmXVYe3FZcnwwqAfe8gJjkUlWgOiBMqpKUQkU
         jqQFfZ7j9KjM76+QkOF/NQTs++//UNfMQqwXgwehKssTIpiPqupjc6seaNmAyUWktUyD
         FXP++j2mdFGdXwWXuT5iwW92O6MrW8BE7mzs/AAhvpL3fMdWkML2iqVnLJPsYonoVOvj
         MKgvYa5X6fjLEygprvLGHwGQDx83jkCLzp5oqz2vIXQ+4BLNW4zp0/hQUEi7YBuruyHm
         eQc/b7ykdRihcuDfU0pAzE3+mx0LrAG9rJqxAOm6Kn9m/+2ukASL7Ff5EOpegC4jd+qI
         +b5g==
X-Gm-Message-State: AOJu0YzFBcx6QJ294RIgyZxX3H5S4UABtTx1mm069Ru5OkGSfe8aMjm1
	08AY4x7L80pR4XbPwZ9W9mj78Ul2nLT0k7XS9rJOQxi9QccCesQFg6FW1RRK91Ps/uhjcG4K8fO
	Ql1Q=
X-Google-Smtp-Source: AGHT+IF0xt9O3F6yWA8Ky5TK1n8jQ3D8C4RA2hXluNMW5CMPeuEHswsWGTcmwFcHFTMwfO2PzaR2+A==
X-Received: by 2002:aa7:8885:0:b0:6e5:6cb2:a68c with SMTP id z5-20020aa78885000000b006e56cb2a68cmr3750463pfe.8.1709322624421;
        Fri, 01 Mar 2024 11:50:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r8-20020aa79ec8000000b006e50cedb59bsm3406088pfq.16.2024.03.01.11.50.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 11:50:23 -0800 (PST)
Message-ID: <65e2317f.a70a0220.1dc00.0c07@mx.google.com>
Date: Fri, 01 Mar 2024 11:50:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.306-cip107-254-gfeae08b50ac51
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 36 runs,
 1 regressions (v4.19.306-cip107-254-gfeae08b50ac51)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 19:50:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15136

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 36 runs, 1 regress=
ions (v4.19.306-cip107-254-gfeae08b50ac51)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
hp-x360-14-G1-sona | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig+x=
86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.306-cip107-254-gfeae08b50ac51/plan/baseli=
ne-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.306-cip107-254-gfeae08b50ac51
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      feae08b50ac51891b1ac8f457acdb2bcd62fdc22 =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
hp-x360-14-G1-sona | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig+x=
86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e2245bce0c1e4c5d637051

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-254-gfeae08b50ac51/x86_64/x86_64_defconfig+x8=
6-board/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-254-gfeae08b50ac51/x86_64/x86_64_defconfig+x8=
6-board/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e2245bce0c1e4c5=
d637052
        new failure (last pass: v4.19.306-cip107-201-gc2afc54e2d6bb) =

 =20

