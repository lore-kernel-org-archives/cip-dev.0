Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B421C48BC3
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 06:41:18 +0000 (UTC)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
 by mx.groups.io with SMTP id smtpd.web11.36339.1708324873227047715
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 18 Feb 2024 22:41:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=jJ9WjHGd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.178, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bb9b28acb4so2881626b6e.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 18 Feb 2024 22:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708324872; x=1708929672; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0E2aWK1atc9f5Da6j/7tiCUACNBHAzE+yoHZguDxkx4=;
        b=jJ9WjHGdce9iLeD8MV6EGDh3RBAe6jYSZG0R8Vb7Jxnzk/eKtoNC/0qTRKTdUOXwEc
         Y3LT65w985tlnvT7Co5n9APiweL+WB8npUalZQQLgpGtUFKn5Q9GQ57qaSuVPHE5NySg
         Ryx71qxMiHWVQNkYIEomJ/KgUNeLOJh0KRcL2+ZNTmC2pMyGCZYYFj32F14sl3hctZ6b
         6J8uwcswGte5aZb1JP3tsvCaBN10YcKiVhZi8r8GspqiSLeL4aK1gumzKj4Vw5BVWuJR
         Qyxg47Zf1GZDHNsGIZ4TvKBAOEgjZ/PeWMNfMIcUB3mFLYur/Qly8KBH+orT1yN1EkF/
         l5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708324872; x=1708929672;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0E2aWK1atc9f5Da6j/7tiCUACNBHAzE+yoHZguDxkx4=;
        b=pQhyRUPmbjlWNeWl2F9tFkRL5RFNbP804DkNzr9f7r+EMtblUyXXg5Nxgiqd2dN3+x
         mw0spSSW+ndLfpWuvnGCLV4IGkQ+6EPdh0hhQV4CaCsXsGZS5RNmZni8Rt18d+XrMfrL
         4d2dPzsx9Q5bAWbmMYcaKGDzJhqIw1BKCGA3UbIbf+wsbaDqRXUCLkF++IxSr/X9fZXg
         F2kLXuXLAPUgEUlFaKGS6pTQl4pf1rtbu24q6Fx62TUgB7KAmbAt174c0ykM00HDOd3/
         Uqit+bRv2LV5c88PkQyY8jUndUtwWhOyk8/wnV00W2LPPlhH2w4kmLOqAs0eB//Jo19Y
         6J2g==
X-Gm-Message-State: AOJu0YyJ9rri0lI6boygQAAsugEG/d6f20WGyy2O6yGK8sdFrCOnoOJh
	OqZ8yNioZq8KZKZnzfebbVIajwk2mCi9Kr8VsxZPDAep11Gk5KSTcgkugM1uf26V4cSlT/obrFL
	3
X-Google-Smtp-Source: AGHT+IEeNdM+sMFSZkZh/YArzhGhK8KztVsOjg9Mjx4j9uVSy9cCyIaZ7a6hQ6LaBvBySdtDMy5LnA==
X-Received: by 2002:a05:6808:1493:b0:3c1:50ef:d49e with SMTP id e19-20020a056808149300b003c150efd49emr6187278oiw.56.1708324871784;
        Sun, 18 Feb 2024 22:41:11 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d24-20020aa78158000000b006e146124ae7sm3983020pfn.186.2024.02.18.22.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 22:41:11 -0800 (PST)
Message-ID: <65d2f807.a70a0220.47807.bcf4@mx.google.com>
Date: Sun, 18 Feb 2024 22:41:11 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.306-cip107
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip ltp-mm: 6 runs, 2 regressions (v4.19.306-cip107)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Feb 2024 06:41:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15029

cip/linux-4.19.y-cip ltp-mm: 6 runs, 2 regressions (v4.19.306-cip107)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.306-cip107/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.306-cip107
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      800dfc28d1a90b195d50f75fa7711d00cc1825bf

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
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65d2ece380cf18434e63701a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.306=
-cip107/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.306=
-cip107/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65d2ece380cf18434e63701b
        failing since 764 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65d2f43b30d797e3c7637053

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.306=
-cip107/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.306=
-cip107/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65d2f43b30d797e3c7637054
        failing since 764 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =20

