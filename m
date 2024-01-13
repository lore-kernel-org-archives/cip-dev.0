Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A021C4707C
	for <webhook@archiver.kernel.org>; Sat, 13 Jan 2024 07:27:39 +0000 (UTC)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
 by mx.groups.io with SMTP id smtpd.web10.15248.1705130850537486588
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Jan 2024 23:27:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=R4sIWJxm;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.43, mailfrom: bot@kernelci.org)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ddf26eba3cso2285087a34.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 12 Jan 2024 23:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705130849; x=1705735649; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2aI06FftnQL7xxyUYXEcWZo1JtJkJgCEz+p8nDqII5Q=;
        b=R4sIWJxmLVbEWOac8owLTNcgK7J8v9OkOfuqj4VSFc9HHTLcbUGlPjsRAGZJ5QXeX6
         SCY+3fbN+kpXjV4RAOcxm+TUplhRT9UPZXlJbf78bygAeTIIp2ljaszyJlpseCI/1jYg
         E8tC8pzbi/zzfPkcBHl5vvoey8Uc1saIMxoZvYI4P1XFoQwLSUl3z7KPRSdBxdB2rt1R
         LwlYVWla79qoAeSVsjC9nXR5IjXdW5cbIs5wgq8A8PuxOvzmCovjg+DeRpVCVxcD/mc5
         GF3Aey2BajmYEzdOguBoBIOPrS1aM4c3PUrkYI7URW5CtSrCJ5G9FCxlH2FROzfZD87o
         ebXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705130849; x=1705735649;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2aI06FftnQL7xxyUYXEcWZo1JtJkJgCEz+p8nDqII5Q=;
        b=FAjkjCKQjIISK0/7OwFuP02noFbXVikykevqyZCuSmjxGl2evtQYGzfldwRuApYjtV
         s071svc0ZwdS9oMYpVOtNfvKorCLqjmr5JTXMuE25YrUJuI2vl4R1rKu7T+zUq/tDP1b
         IGBWdxYZECIjYqSUoczqJ+z7iwIhYfHeOWDngJ1WLbmGHk/z/fbEpfinTj4BGO+C04iM
         iKw+vrDs/0ECRcvsjiURxiccTzpVuuBVhKCXCi1xC2eQMpt4GMVIdS9trCTqoNkCdbiE
         BZkvn5Lx7NdHD9bwBXy981f6LrqcAh0oLQSozuAyA6uHI6OtIkLVaiCK0KYqzKuSVQY7
         cQNw==
X-Gm-Message-State: AOJu0YzlWEPtMQ6VZzYi1IyCLYsSVzHUFo8bibx+jyIAkXFiEDlrxntg
	5ePtzlqyUls2MrFh/mlRlprKZKZ7Ic/pzbTbmlzv/TERdts=
X-Google-Smtp-Source: AGHT+IH7HB3TfuzbP5r9YJjPYzzyuWAswz1O7Wd6iMr+Icp/f+WbpuAoIExGx98pXT7Z0FPfW94EmQ==
X-Received: by 2002:a9d:6857:0:b0:6dd:e530:8c12 with SMTP id c23-20020a9d6857000000b006dde5308c12mr2939005oto.4.1705130849327;
        Fri, 12 Jan 2024 23:27:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u24-20020aa78498000000b006d97f80c4absm4205402pfn.41.2024.01.12.23.27.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 23:27:25 -0800 (PST)
Message-ID: <65a23b5d.a70a0220.1b8ff.ebf1@mx.google.com>
Date: Fri, 12 Jan 2024 23:27:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.205-905-gb40421b142370
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 7 runs,
 2 regressions (v5.10.205-905-gb40421b142370)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Jan 2024 07:27:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14367

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 7 runs, 2 regre=
ssions (v5.10.205-905-gb40421b142370)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.205-905-gb40421b142370/plan/kselftest-lkd=
tm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.205-905-gb40421b142370
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b40421b142370404ab8c5dae183e5541de854979 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/65a22b19b7602d6ae752a40f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+kselftest/gcc-10/=
lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+kselftest/gcc-10/=
lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65a22b19b7602d=
6ae752a410
        failing since 71 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65a23019fb71fafeb852a3f2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook+=
kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook+=
kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65a23019fb71fa=
feb852a3f3
        failing since 71 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

