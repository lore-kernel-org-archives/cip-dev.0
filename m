Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57008C46CA0
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 14:02:07 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web11.84307.1701957717334674572
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 06:01:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=N8YniyA1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ce72faf1e8so537211b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 06:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701957716; x=1702562516; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=93nwWXu2NOKZaN6Pj17MzoJIKKiO2XZPQgYjrbrlZxM=;
        b=N8YniyA13qaCPoCdgw83jOeVFuNEhqJJrBDKmImk6mSgjG3EiD+a8eARoB5N4QCwhR
         d7WS5MNFDxynWFGd/4HMR2kdRSKJI5+LbR88nDaFFdnM6qkIf0LjjWDAosOrRHUfDm8z
         2YIMXQ80M+/6v4ffGtHz6dWPnV5+LCNVl4ciUH2PdYpazdO2/4trPGAE1jV7vDnZ7/g9
         vxEMwN4kgv2CtNLtd3xnpw3syyZHay/zUS/Xs6PgsqyCaPhTjbOx41rCNOhgIIc8SMQW
         tSqacjXfhbfagHCl/hqdyHtLIvnHWbKh0H6oSMaTwIEJzYyOez+nP5MMjC4NvtPnkX42
         TINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957716; x=1702562516;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=93nwWXu2NOKZaN6Pj17MzoJIKKiO2XZPQgYjrbrlZxM=;
        b=pSHbqK9yR1opgqkNutP25ZHJLzupdQOeb8Nsh5GgmfAwuCSaS4NbBiz9W1VblWI+YZ
         rNLScLma9jFYWb5vxF0HrrXuRhpPZ3T05xp7sT3DOI2BWpQq6ERw6yq0wBNyCmzJnPKk
         LRBF5XB0X/qZH93dMrvqtFtIIa4Vqj7W4NL9ncufFm/TohhtvkXMq9WENQzvulVtgUcw
         GV9O9ui7l2QD1oev7cJ6sKoxVvoSrBvwqj1QVZJFsaY1G+s/s2+7pSAQpbhcoQ3lNQB3
         tu7YZ/xiFgSdvSZBx2scTsxRs9q7f7DmVdpYCnHGIR6a9uitLwEwlk5uCzzrB54R59G5
         SI8Q==
X-Gm-Message-State: AOJu0YylhnXSfJ9XTmvg51PqlsNdA1/grutwROqv++EKvwr9I5e0kqBH
	3OqmxFc5lOfHhUnA+/d1U/XCnOWNxQM8+4CbiJ0eDg==
X-Google-Smtp-Source: AGHT+IGWF6n797ehNHz8UcDBz1IabJLPv8oHsqupz71numCXPb6rGkveMe//pEAI6Bh0c6iZ/yaPtQ==
X-Received: by 2002:a05:6a20:cea7:b0:18c:ba47:74e7 with SMTP id if39-20020a056a20cea700b0018cba4774e7mr2164107pzb.52.1701957715652;
        Thu, 07 Dec 2023 06:01:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o9-20020a056a0015c900b0069346777241sm1365031pfu.97.2023.12.07.06.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:01:55 -0800 (PST)
Message-ID: <6571d053.050a0220.8b97e.373b@mx.google.com>
Date: Thu, 07 Dec 2023 06:01:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-16-g3c85fba3b6e5d
Subject: cip/linux-5.10.y-cip kselftest-filesystems: 8 runs,
 1 regressions (v5.10.201-cip41-16-g3c85fba3b6e5d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 14:02:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13863

cip/linux-5.10.y-cip kselftest-filesystems: 8 runs, 1 regressions (v5.10.20=
1-cip41-16-g3c85fba3b6e5d)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-16-g3c85fba3b6e5d/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-16-g3c85fba3b6e5d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3c85fba3b6e5da8b112e7ecd142649674648028f =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6571bbab6e434d0ca5e13477

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-cip/kselftest-filesyste=
ms-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-cip/kselftest-filesyste=
ms-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/6571bbab=
6e434d0ca5e13478
        failing since 64 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

