Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3394DC41535
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 01:41:54 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
 by mx.groups.io with SMTP id smtpd.web11.12283.1702518108081957426
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Dec 2023 17:41:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=lGYihltj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.42, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-58d08497aa1so4875611eaf.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Dec 2023 17:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702518107; x=1703122907; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DdwmbUJ6Jc09mCEXrsMbr577arqd0ZOIAUZImUaLLPs=;
        b=lGYihltj9uYIfbVTCks3t1vM8t6OnaMOd17qGZj5meZC5fkD9RAz8B/2MSpi+3snTB
         aUYp+hh6i9JZlC4tvm4irJFsgv1k0i8iazhSpteG9/Dqvs1OAkV0Ljuw8uKofJsS5qWS
         Vby3BajN6+uNN5rNLm0nAmTF2gYzdjgWv9g2+X7CqWIUzCmGyDrFJqoOKWyyIHAgzQQb
         g3VYSgZbdCnnjwCiVCVYhA5jhQ1fnSRm0MQkEMe7Mo61c5kX8yumbaVy+EVIcrjxeloN
         R/yYQaonxI5qEC6/upvO8xpUvCcxvz5aNy2KsQdeLAWqcqrEPhpogSkT9IALvJvwXv3Q
         NZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702518107; x=1703122907;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DdwmbUJ6Jc09mCEXrsMbr577arqd0ZOIAUZImUaLLPs=;
        b=K+EexcPoVO5QQp6RJQ7KpGzeStLO23RP3kBfTZH4dryFT0tYMAIoTXrmbsNfmGls8g
         kMK8n+ezVJluA20b9uSb6Uh/1OPOLC3+XM5LMbVdiibKHRUnsFDLFJ9RFTpHUyHfoNqV
         LSmncXAFT6effSwbJ5DZHyreYM7HiHITXUZ5g4HRpuzsIjzhl9PXTRZcWYOJkHLGVL1+
         MhvYD9w/k7FQid8dXGTmvFKSVb0Uqtes4qv0gm16frQAlmwIGhf90iS7S5GrbPmeCuA6
         h/kXNKTha5ST1OzEIbMNWT/FVg1U8KMMl3yM8QG0HHxqz7lf8+AIMEBSJYxByeOVsSCj
         sO0w==
X-Gm-Message-State: AOJu0Yy/0TdKq1kurtu04X4HKzXzREoy7JtAqHczSMBumMZfRA0F5X3l
	9+/AqTjuq22Cb7t9FbYs5ZlGD7bRxWftfXHrl1jQ4A==
X-Google-Smtp-Source: AGHT+IGNelLgP5vEiKFISk4QDwpA4HTIqAmIOv4MLHDvbVK00OCPYd3CeRUY4JyFoLTo2uUaMR78Nw==
X-Received: by 2002:a05:6358:9047:b0:172:98ae:cd35 with SMTP id f7-20020a056358904700b0017298aecd35mr964301rwf.29.1702518106847;
        Wed, 13 Dec 2023 17:41:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902cece00b001d0c37a9ccdsm11231702plg.10.2023.12.13.17.41.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 17:41:42 -0800 (PST)
Message-ID: <657a5d56.170a0220.f69bd.31d5@mx.google.com>
Date: Wed, 13 Dec 2023 17:41:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-473-gc43d7b7bbe83a
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 11 runs,
 3 regressions (v5.10.201-cip41-473-gc43d7b7bbe83a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 01:41:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14083

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 11 runs, 3 re=
gressions (v5.10.201-cip41-473-gc43d7b7bbe83a)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+k=
selftest          | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-473-gc43d7b7bbe83a/plan/kselfte=
st-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-473-gc43d7b7bbe83a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c43d7b7bbe83ae0f7e001ac115b838d7cd1afe79 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/657a5386370e72becbe13494

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-broonie/kselftest-seccomp-meson-gxl-s905x-libret=
ech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-broonie/kselftest-seccomp-meson-gxl-s905x-libret=
ech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/657a5386370e=
72becbe13495
        failing since 15 days (last pass: v5.10.194-cip39-915-g96fa7f16cf02=
, first fail: v5.10.201-cip41-197-g2d08925b44e52) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/657a4e421077010219e13495

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+kselftest/g=
cc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+kselftest/g=
cc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/657a4e421077=
010219e13496
        failing since 41 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/657a4f0629e447062ce1347e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.t=
xt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/657a4f0629e4=
47062ce1347f
        failing since 41 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

