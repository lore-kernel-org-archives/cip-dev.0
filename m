Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD1BC47422
	for <webhook@archiver.kernel.org>; Sat, 13 Jan 2024 07:27:29 +0000 (UTC)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
 by mx.groups.io with SMTP id smtpd.web10.15244.1705130844604233580
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Jan 2024 23:27:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=sGAUOMmW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.179, mailfrom: bot@kernelci.org)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3606e2120bdso47401655ab.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 12 Jan 2024 23:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705130843; x=1705735643; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MzPSlMeuJ6wSZCTqfii9TJWuZ/NnottMuvcQ7xyukiE=;
        b=sGAUOMmWu0LtowkyoKRE+y4OgBHUwDYHOPeBEoPg72HxGvatea43gbAg3VMuAUV1hS
         iN8UYAYIrkcHROGi8fwEQS2JoJGaResngj5jhNGa49DcVjx7K30rRyixNmlKioBeshm6
         6HtUNAy5aEFuZ6QGvvYjvZK7LyUNYrVrRvxTJfdwlih3esN4x/HQR7O60892MRI9YKJB
         CA9x2vz/zA3j2QUa+QFVSmb0o2zZgU3oorjRHBtWMgcwzYurt6FMOrSfaSlyEWgDR+KZ
         J03nCDJJt+EQUmBME8Tnl2XRpVe4PPRrmqT5q2KE2Osjcko0GZEKqXtZ0yQVlaR0vt8w
         YsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705130843; x=1705735643;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzPSlMeuJ6wSZCTqfii9TJWuZ/NnottMuvcQ7xyukiE=;
        b=D9LZok40Tx0fOskvYMxg+lrQdvvSQL648OHEfIo39pC6u3fUeDBeet8aQ8Pg7Q1Yvq
         uFxZLplnYGbAfdxrn32oqc7gO0aVBP6skE0SJMSY1sYIhkL0x79T5v9moN0MSAUpZK9T
         g/teDABZefzuJoYm6lxNAmJtx0NN8wJOwyGqabInoeACMpg/At2/4eqoeXgukVODu9At
         G7Zhh4f0tMzGVRdM9i0zqIZd7gat4p4I1wtBJc+fOnwd/e/TXDA7niRNx12bOdM2FwTp
         vGM0kyFcbnRxi9acD3TofLIq200uhgsIXa/f66bZuaXVJ+jsvs27j+efRaGvDrUG2NNu
         mNOw==
X-Gm-Message-State: AOJu0Yw8zo8xJ9SzVXTOCIN7rtq6xIhrpl6ufQcLJKzr6ZG0FacnZ0T7
	U3IXmJJFGQLOMVKv89NZOsWX+yII3p8Ia4bysVW3bOt1PMo=
X-Google-Smtp-Source: AGHT+IFsMQ6At695dOVLimG4yzice/Ajr41TN5oP/eH4ivujidVK9L2ok0NtN0kVNxF++UgZIy9KLw==
X-Received: by 2002:a05:6e02:1a2e:b0:360:8e6f:22c0 with SMTP id g14-20020a056e021a2e00b003608e6f22c0mr2979377ile.111.1705130843264;
        Fri, 12 Jan 2024 23:27:23 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f2-20020a170902ce8200b001d4c6a9ca2dsm4282355plg.208.2024.01.12.23.27.22
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 23:27:22 -0800 (PST)
Message-ID: <65a23b5a.170a0220.a5ca7.ead4@mx.google.com>
Date: Fri, 12 Jan 2024 23:27:22 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.205-905-gb40421b142370
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 11
 runs, 2 regressions (v5.10.205-905-gb40421b142370)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Jan 2024 07:27:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14361

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 11 runs, =
2 regressions (v5.10.205-905-gb40421b142370)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.205-905-gb40421b142370/plan/kselftest-fil=
esystems/

  Test:     kselftest-filesystems
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
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65a22a8eaab3d2b14952a3fb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook/=
gcc-10/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook/=
gcc-10/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/65a22a8e=
aab3d2b14952a3fc
        failing since 205 days (last pass: v5.10.182-cip35-191-gf4efde51295=
9, first fail: v5.10.182-cip35-289-g3c0549540706) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65a22cb1116cdb353452a409

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-cip/ks=
elftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-cip/ks=
elftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/65a22cb1=
116cdb353452a40a
        failing since 51 days (last pass: v5.10.194-cip39-915-g96fa7f16cf02=
, first fail: v5.10.200-cip40-188-g33d0b44cd71d) =

 =20

