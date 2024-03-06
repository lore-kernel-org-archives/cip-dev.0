Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4857C54E5E
	for <webhook@archiver.kernel.org>; Wed,  6 Mar 2024 22:46:55 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web11.9741.1709765209323271643
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 06 Mar 2024 14:46:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Ts2liQ3M;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dc13fb0133so2072475ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 06 Mar 2024 14:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709765208; x=1710370008; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5AydJw8FhZqi1zCQalAmfYrHkcjNoy9SYe9DRfsSAp8=;
        b=Ts2liQ3MHPGCzT2FHuP6fdmezvUq3IDPx/j4YPi0wsSSx+gy0fOz22snIA4n+XqAJO
         /9AigdkNj+GSzC5dsdnuO/vXPZBLDh+VSUn0jSYX+zvdxXuxPB3v7ciGf6E2Gg/RGjT8
         i0omCP7d672RG03Vxg3/tg7toTgt3d7XZF35ZVE4CnPz1yjBIPZFxbxMyQLVPJY5Fvnn
         fO6Iv3sLAjrpjjcJJnKeeXPyN0S3oFFQXD3r1LzOMIta+V+QIMIHzTv3JDNuoTfvYv41
         p0LcpR3EA8Bg6drpt+Ra6NegbuVdLf4DJaIhRIgdOVhMmGvLL3AqiRLMnatsDsKU7IFV
         zSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709765208; x=1710370008;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5AydJw8FhZqi1zCQalAmfYrHkcjNoy9SYe9DRfsSAp8=;
        b=HhAeqN9IEtK3TxTrDGdMFENvcXnjRiXAWZq+4m1oEMgBRghQWC7ClXZgQyaTo8YKuS
         nAP+phamGdf9V93GWD+EXKLpEsaR5mwPneiL3kbh5IxqwFD83di3LnljBNDL4/12jSMZ
         jHnFB0ts00dTkfZkjPprJzDrsz2y+CYGQTR9tcZAeA4D0oB5L6B8hkkVRREaP5Yg0V6T
         5tH1HNRGPqapq0u25ZoA0tuu4Cj7yQOfxNGzuka+dtkn6HLmUHe6pKscWQ4KqWnlHG2g
         QyAn/2Ss8OMO9FmrSt8mKiOIPX/okZGJzWH79RPa9v4IIVgk5lai+0pyEragch6Us06F
         R3Kg==
X-Gm-Message-State: AOJu0YyYU1In43DX3ERSdfs9d8lku3nARFN7B6SUvoVXmpxPcAdZfxH/
	VqswtqMQ7wiJViO2JZ1IX913TSH1MCUmpgZ5NBb4ZtohqeAc5bCchGLhYV4Pt638N7I+fkiMS8u
	4+bk=
X-Google-Smtp-Source: AGHT+IFJY9pFP25BQm45bysd2bJ/pHzGLXkzNLNeEDKKmPgRkKL2cW00b4R6+jU0h/EVZl2ilcUQbA==
X-Received: by 2002:a17:902:e88f:b0:1dc:b73b:ec35 with SMTP id w15-20020a170902e88f00b001dcb73bec35mr7396981plg.4.1709765207785;
        Wed, 06 Mar 2024 14:46:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m10-20020a1709026bca00b001db5ee597e8sm13086961plt.261.2024.03.06.14.46.46
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 14:46:46 -0800 (PST)
Message-ID: <65e8f256.170a0220.3bd0e.1ea9@mx.google.com>
Date: Wed, 06 Mar 2024 14:46:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.209-cip44-594-gb47da48f3bae7
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 11
 runs, 2 regressions (v5.10.209-cip44-594-gb47da48f3bae7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Mar 2024 22:46:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15245

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 11 runs, 2 =
regressions (v5.10.209-cip44-594-gb47da48f3bae7)

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
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-594-gb47da48f3bae7/plan/ltp-fcn=
tl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-594-gb47da48f3bae7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b47da48f3bae7f477104b0c214451338a6a343df =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e0c0ed9b3159cd4c432d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65e8e0c0ed=
9b3159cd4c432e
        failing since 125 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e63891334956614c430c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig/gcc-10/lab-=
cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig/gcc-10/lab-=
cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65e8e63891=
334956614c430d
        failing since 105 days (last pass: v5.10.194-cip39-915-g96fa7f16cf0=
2, first fail: v5.10.200-cip40-188-g33d0b44cd71d) =

 =20

