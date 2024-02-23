Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261B1C54E4F
	for <webhook@archiver.kernel.org>; Fri, 23 Feb 2024 12:06:57 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web10.9113.1708690010157507624
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Feb 2024 04:06:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=3at4mwtL;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e471caaa71so509288b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 23 Feb 2024 04:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708690008; x=1709294808; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8orfb/d8DQ/gJOvqjUkxgBMXlMYa1EqY0o45Qcr4JdI=;
        b=3at4mwtL2khwiorPJGXbAz/4kuOjUmVEgCdqN/OfdrlplBiwUd281PTxOcNB3MS59e
         g2k+MA9Wa6lzgJ2FExfwl2yqL+9VHrJskY9v+Vgkac6cQllSyniBO9CU2OLDD5tvWRmm
         +GJjdih/j43I6diENpWuiK2Rd0edof8EOGseTseAqwndG7rvWmyvtz+L+fGDAZT1ty8v
         OS30YPruH8ySwzFhK8f2IdKDR64t3SdjhdOv0Sckne9TrM7fl9JYMiul2Sf0ybhGQuvo
         vvl8zKCoEWpdU4OLM7P6/Wecv+kK+2DExwhw3jemTv9+Zmkun1khUztp77wYnc2rH6tr
         gU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708690008; x=1709294808;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8orfb/d8DQ/gJOvqjUkxgBMXlMYa1EqY0o45Qcr4JdI=;
        b=hkWVjwMEvIc2ec7ME8r8jXpHH57WJJ25ngKdnZypDuvab6pExtHv67+jgFjtoHzcXT
         JV4Gt7OARjmkPepOvXialEOR3GUiyh6FxPd2JJqiYa39c4KJM4yCC51JtO7bJVO2/Sma
         25fJfumBzeZLBIK1NVdLXH/qVQtxsOjHST6dNjhL61lOB3Sb44AJpb4rvzTkEIhDkzCL
         O8t4FWa4TXDru80N+AuztC1qPtlJhbN/QT5yjbp+VfjaPF2IPcNz2VpGSOUW5QMiXIbn
         lISM+G/ut25CyxgEwfJVUXrXcwKf/nJJCxcz2iMj8mk9rzkwkHGPBN+uI/U37GTCT2Cb
         Np0A==
X-Gm-Message-State: AOJu0YyxXrbEuldEHdGXz7UoL+fgZS+DppzYkhGMy9JmMzJSjlY4Q7gK
	r5ZhCZfLvdUYy6OGGJOb94/pufNxRfbCtqlAbiLalVr2jbMtj6WfWh5ipiAIBUOGJMjXtryySqz
	ce7E=
X-Google-Smtp-Source: AGHT+IH3EpTWgPbHLw/iRBZDAddOhbKbyAmvXB0Y1THnIfi2Zi64WweyO21ix/lzRicZVHW8GTP2+Q==
X-Received: by 2002:a05:6a20:ce49:b0:1a0:e4af:3c11 with SMTP id id9-20020a056a20ce4900b001a0e4af3c11mr606194pzb.54.1708690008588;
        Fri, 23 Feb 2024 04:06:48 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x26-20020a056a000bda00b006e482a238b7sm6618288pfu.31.2024.02.23.04.06.47
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 04:06:47 -0800 (PST)
Message-ID: <65d88a57.050a0220.1265d.8e73@mx.google.com>
Date: Fri, 23 Feb 2024 04:06:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-424-g38943e302f8c8
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 10 runs,
 2 regressions (v5.10.209-cip44-424-g38943e302f8c8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Feb 2024 12:06:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15073

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 10 runs, 2 re=
gressions (v5.10.209-cip44-424-g38943e302f8c8)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-424-g38943e302f8c8/plan/kselfte=
st-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-424-g38943e302f8c8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      38943e302f8c8bda23c2853f688afa5e35cae90d =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65d87893eacd764b0163704d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-broonie/kselftest-seccomp-meson-gxl-s905x-libret=
ech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-broonie/kselftest-seccomp-meson-gxl-s905x-libret=
ech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65d87893eacd=
764b0163704e
        failing since 86 days (last pass: v5.10.194-cip39-915-g96fa7f16cf02=
, first fail: v5.10.201-cip41-197-g2d08925b44e52) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65d8786ce6edbe8641637016

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.t=
xt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65d8786ce6ed=
be8641637017
        failing since 41 days (last pass: v5.10.205-897-gcc9858ae2881, firs=
t fail: v5.10.205-905-gb40421b142370) =

 =20

