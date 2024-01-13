Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AEEC4707C
	for <webhook@archiver.kernel.org>; Sat, 13 Jan 2024 07:27:29 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web10.15245.1705130846136361942
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Jan 2024 23:27:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=gSVXayTl;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-28e1f11d300so595499a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 12 Jan 2024 23:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705130845; x=1705735645; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oGpEaVuv/N+5sgYbpxyilvIFY+hcwer9iMUnU7q8EBA=;
        b=gSVXayTlbXFPmCMnj+q/Waj1OUuVslyYC9CK00zCRcmYhT7mu411FrBUMB0mnzoE8+
         5Lt6k/URI3yAZvR4c7r1prAM2uS59/PsvnTwWP3/XhuLnjKdMjOpcNZkGt7m2LgoBGUG
         2HiaSWl+G6w7zzuPru0NNYZX/F6t4d65M8tIEbLcTU4FQ6RBTM85wugTsV+2O4v4T3Po
         IN43EvRH+5aLbWzhLisxkFiOTVROkQRvIdF/dzobdUXKHBgFSJfeYZpvVP6n0XVzxP+h
         Eoxn4Z+dYT18O9i+Us9luTIPRIlMR8YViFBs5e5fEtmXu7YQCJkfmxuml4L/jGBzUW+p
         4orQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705130845; x=1705735645;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oGpEaVuv/N+5sgYbpxyilvIFY+hcwer9iMUnU7q8EBA=;
        b=lv6vbDEkqatp4kvPnOAMXOjHUsapfxPhZdumJD9mOD0OsfQ14KW/Hlz1y+tZtN4RZV
         TmRs4Pm+vCieAJgccta8JF53go816mDEfdojiXPJRpRMHvE/gnP23OuKYuGw48MmYosy
         xougnkWgaXdxaHvk21dImSlPL3CLtTAPBqh8bzKC8ZrAaMSNn0qBOnsuXZWxbE8PnZeS
         diX+4IqYx5b9zaSdqYSedIB4Iwh7FiVzwpEjIqp7R8WXj8rB/S8e2m4cgpe7rxsO5+B7
         se8QwKr+geNKgF497Ch+oB8dwEFrD7eS7vog4wqeS0BtUUG8QsggdCF+lvFS0uOaEIR2
         Nm5Q==
X-Gm-Message-State: AOJu0YxuK0zcSe2O7axbDJjG1q06greutSeUPPkVQYVgyCj8CaVFmhWn
	2jlnDIBNlq2cOxzPuGYj5fMxbLMnNz/rmxldBvpo+Fvb31U=
X-Google-Smtp-Source: AGHT+IER++dT4hxSk/MnkZ5042N7falMcstzi1tvKUzWiII6yAzIhy22McWlS46qPs0ZaxlbgWdodw==
X-Received: by 2002:a17:90a:b111:b0:28b:6b90:3d69 with SMTP id z17-20020a17090ab11100b0028b6b903d69mr1974219pjq.76.1705130844985;
        Fri, 12 Jan 2024 23:27:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902c28600b001d5b87ee36dsm485836pld.33.2024.01.12.23.27.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 23:27:24 -0800 (PST)
Message-ID: <65a23b5c.170a0220.75f73.111e@mx.google.com>
Date: Fri, 12 Jan 2024 23:27:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.205-905-gb40421b142370
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 13
 runs, 2 regressions (v5.10.205-905-gb40421b142370)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Jan 2024 07:27:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14362

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 13 runs, 2 =
regressions (v5.10.205-905-gb40421b142370)

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
Flinux-5.10.y-cip-rc/kernel/v5.10.205-905-gb40421b142370/plan/ltp-fcntl-loc=
ktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.205-905-gb40421b142370
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b40421b142370404ab8c5dae183e5541de854979

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65a228da372b7c86f152a407

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook/=
gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook/=
gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65a228da37=
2b7c86f152a408
        failing since 71 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65a22d3a14d895f83b52a3f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-cip/lt=
p-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-cip/lt=
p-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65a22d3a14=
d895f83b52a3f2
        failing since 51 days (last pass: v5.10.194-cip39-915-g96fa7f16cf02=
, first fail: v5.10.200-cip40-188-g33d0b44cd71d) =

 =20

