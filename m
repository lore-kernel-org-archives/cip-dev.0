Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5336ACD80C7
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 12:21:08 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.89912.1696940464614159733
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 10 Oct 2023 05:21:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=dAb97dCD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1c7373cff01so48496095ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 10 Oct 2023 05:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696940464; x=1697545264; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zc8t2K2a4V/RN8wvVb1MCcyYBY88b8ifsWzHLjWUJ0U=;
        b=dAb97dCDmPIlljnPyIeEiPVD1LOmF6JcNsdxwRoDNxxuxxJ4beBKQeoQ2kPPdTH0q3
         yFirzG4V/cEqNkfbpqiyopM8fnOsGp2AD9LQgZ3HznKJGd6MW4SoWG6vyCNOlhSJ0eVx
         jPjE2r8jwvLl8Q/S8RCoirxii1UskfVqpAl0wn1ONtzwWrDl/8+MnpjsUIDBimAzsPGv
         sFZRRwXiwjVUrtJIhQki5pwOAcrjqQYitvQvDJq0aRGAvTvehr2Dke52VnNn7jW8ytGH
         yuF8cJV3sb8z09ZAvc3MPbE2bvnK+SV1L0AL34qHk9GilBtmMJaH5plXJ4OEWNfIxPgN
         sC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696940464; x=1697545264;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zc8t2K2a4V/RN8wvVb1MCcyYBY88b8ifsWzHLjWUJ0U=;
        b=KQf5iSb8HnS9Ue0OYtzF+m85E26bcSbjXM0MGw4LuDcjlmaoSQhkQ9a/fTeAfy8DPK
         eqwgtlJw5WP/K0ciz3nGL53BWsw1OI6P3apLrjEbrPoMzNFOJ9TM4FFOLmOY66x/iGio
         p4XtcJQbYucnNMLbSmW3tSAjSpFew2gkXHvW8Umb5STQlBsUX8b76uPVIr/TSGUMf43I
         2tSThgHj5mTZMC4tgw8bGUTp1mUj442THAamG6oWG83IJ2v/8pamKKeRjlhlcdK60pWr
         SkWiYiyS8MxJDJEo8ltLkRRGEnGsAQyYAawi2PfSP2EKf1H0fBS3M8iV8t5YanLF6NBc
         1/rQ==
X-Gm-Message-State: AOJu0YwtgJkHlgDVuSnzyxjZ98T0EiAvqw2C9Y+sxHBYdkjNmAxgUrAP
	4aLt944vbKtLzYPvHaTjvw8hTR1P93ca3Mqr/Gm+QA==
X-Google-Smtp-Source: AGHT+IHwIzyE5i0ohWT/qrrf6AnJFq4BFLD3EhS7OmH3vbr8fcnEmlotD5NqPPD1NBp1iGK6ZzeK0Q==
X-Received: by 2002:a17:903:32cd:b0:1c2:193e:1126 with SMTP id i13-20020a17090332cd00b001c2193e1126mr24017811plr.28.1696940463653;
        Tue, 10 Oct 2023 05:21:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ju8-20020a170903428800b001c72d694ea5sm11611357plb.303.2023.10.10.05.20.58
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 05:20:59 -0700 (PDT)
Message-ID: <652541ab.170a0220.4a3d6.e5b2@mx.google.com>
Date: Tue, 10 Oct 2023 05:20:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-553-gd498c00818b88
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 17 runs,
 3 regressions (v5.10.194-553-gd498c00818b88)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 12:21:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13367

cip-gitlab/ci/pavel/linux-test ltp-ipc: 17 runs, 3 regressions (v5.10.194-5=
53-gd498c00818b88)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-553-gd498c00818b88/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-553-gd498c00818b88
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d498c00818b8876a72d6eb6c2498058ec80d51bb

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65253301d3657481e6efcf05

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/ltp-ipc-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/ltp-ipc-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65253301d3657481e6efcf=
06
        failing since 117 days (last pass: v6.1.26-1320-g1ddf4b637f785, fir=
st fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652533b0ae183f4b7befcef7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/652533b0ae183f4b7befce=
f8
        failing since 6 days (last pass: v5.10.182-cip35-8-g2391124f19a70, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/6525355209daf9aa19efcefa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774=
a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774=
a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6525355209daf9aa19efce=
fb
        failing since 0 day (last pass: v5.10.194-cip39-1-g53e59f50ca3ff, f=
irst fail: v5.10.194-cip39-552-gc89b2c57483f0) =

 =20

