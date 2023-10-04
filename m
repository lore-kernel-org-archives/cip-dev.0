Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2129CE7B5F5
	for <webhook@archiver.kernel.org>; Wed,  4 Oct 2023 11:41:30 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web11.16083.1696419685261567853
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 04 Oct 2023 04:41:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=VrtVfrR1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-690d8c05784so1522725b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 04 Oct 2023 04:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696419684; x=1697024484; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HtLV0/cFrwsqSf2LLT8tXmL8ebPSWKTFA1bfHUmxUUU=;
        b=VrtVfrR15BdLke5figQdKt11kgkIchX/aZL+d5ZahuZomRpb0PQZ2hHDyFGiTAXgjQ
         nf/EbGaPr87/QYr299zNsPaBzd2Thv391YxaRBIKoNZVxabVaMRspK2T6bp0OLef0TcV
         BhM24pJSv92cmYH6ZNNAyTusM0aLUpVqEUCDWBZXphYD5tFHPsVH+DSpJdBfwA16S1w5
         U1e7crm8cjeISxmGzrkm88DhjgKTMHCFTZ4YU/c8FMLcF9X4w7KfjZazlSp6yAUuomgU
         laZNYJWGrVzLnumdpcNFnPtt3mFNfdU0b5oU0y97pDOP9Bhw+YSIoGbdCUKRH4sj6RmH
         13CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696419684; x=1697024484;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HtLV0/cFrwsqSf2LLT8tXmL8ebPSWKTFA1bfHUmxUUU=;
        b=ffw/47X06RciRpn/pi9pdcjmYavXMXxFU3bgDJp1znNo92PpjmZmAZoCDrti/L8auO
         +VSfjZHqmTlGvmm3vmpMjg0ztsM/M99owXg0P+smPMaeQgVGUtG/2O4+16CMU7HZdY4s
         1Y7E1TRsRWVJHCdRUoqW8vTAdec+Is4D+ZuL8gJg/wU7OM0iJfYEBbmt1lmrPKBZ5KvG
         cvSWa6PbCPJ0q5tuPH87NvdaB9JM39t1xbWfIKbdXWDQc2ilhhV4M4plv61NSo31JlSB
         FidvCh6XFlmuoinctNCJu4KEHrosTnGMIN/TBXUlJC9wLUYNykBHF81vWe9LLj/2w3Vo
         oMyw==
X-Gm-Message-State: AOJu0YzQ9BVRe1y+8hLyXe3eNcLxNB+8/G35hVbgN/PfzRVKqMZK+CXc
	Texi3fxPWvGfz6iJaBRhup6O/0PrlsiNhlgNXk3vDA==
X-Google-Smtp-Source: AGHT+IHJk+MzoYvADDId+JjXVJn0drk5az+4l0kRvSj3afgnh6opt8KVx+5rdkToRQYTRL7cCElcYA==
X-Received: by 2002:a05:6a20:441d:b0:153:353e:5e39 with SMTP id ce29-20020a056a20441d00b00153353e5e39mr2514077pzb.51.1696419683937;
        Wed, 04 Oct 2023 04:41:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x17-20020a62fb11000000b006829969e3b0sm3015362pfm.85.2023.10.04.04.41.22
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 04:41:23 -0700 (PDT)
Message-ID: <651d4f63.620a0220.e0cea.7e63@mx.google.com>
Date: Wed, 04 Oct 2023 04:41:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.194-cip39-1-g53e59f50ca3ff
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 11 runs,
 3 regressions (v5.10.194-cip39-1-g53e59f50ca3ff)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Oct 2023 11:41:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13271

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 11 runs, 3 regression=
s (v5.10.194-cip39-1-g53e59f50ca3ff)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-cip39-1-g53e59f50ca3ff/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-cip39-1-g53e59f50ca3ff
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      53e59f50ca3ff023b612a48397ad7e057a9fd408 =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651d42df88a49086038a0a5e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/kselftest-filesystems-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/kselftest-filesystems-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/651d42df=
88a49086038a0a5f
        failing since 111 days (last pass: v6.1.26-1320-g1ddf4b637f785, fir=
st fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/651d414efe00f676058a0aa1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-cip/kselftest-=
filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-cip/kselftest-=
filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/651d414e=
fe00f676058a0aa2
        new failure (last pass: v6.1.31-65-geef5a19d48f6) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651d47cb764dd781168a0a85

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/651d47cb=
764dd781168a0a86
        failing since 111 days (last pass: v6.1.26-1320-g1ddf4b637f785, fir=
st fail: v5.10.182-cip35-8-g2391124f19a70) =

 =20

