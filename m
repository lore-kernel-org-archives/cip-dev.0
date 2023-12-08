Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAA1C46CC5
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 17:49:15 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web10.42739.1702057745682423804
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Dec 2023 09:49:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=y9+sxYPD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6cb55001124so1628299b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 08 Dec 2023 09:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702057744; x=1702662544; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bE2ZJvlCZtO43TmJsdaA1Y2bEhQCYmG2fPe72WL7xWA=;
        b=y9+sxYPDRI/hXY8RgsYxaT5kfBbUHtKEdYFvV3cKiOlvWymcsVFe9W+YBcRkJga+1f
         51q+CRsqipiO3WXe0AQoBf8Y/PQewKIwdnBxdEbqkO0ad/2782jdCXkkdWh3BCsmEbhI
         sh1UlmfVJTUObPmYLHXGBiy9QCzKJ7CVDrMXebzFHltddVDdRSu4k0Uv3s3LKqdTf/Oc
         HEic4IzH0rd+Nmjyrk0MnZpgkzbk0yNNWnQSdo2acxhKBkbtzRfiHvhwzsbOS3dQzlgD
         bwqAKm4aDi+yO3Ftz+vRfqDl5e+BaPPmTN+uG31ya4PCgbgBNqlb9lp4RnPIm1n9kcQd
         CtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057744; x=1702662544;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bE2ZJvlCZtO43TmJsdaA1Y2bEhQCYmG2fPe72WL7xWA=;
        b=LtMGSyBeoqsDZ+C5SYquQHaWbzqzpjeA4m6tR4S4XYzCB5mpbAegD+zHw5X38NVSU9
         03kTVDnOU9mE6QPHfIholdbSfZzvTBwtqaGwhUzZw7UjBx024iL68K6eLSqpfkQu4yX5
         dERUBDQxzn6a+XM+0lgjqHXJstjSCwRaaMafw7wCvagrPNFAw/H09TAIpcXibvg9ctvS
         YusgLOdnVWjOzCb5xybrybozaitqE8Kq7QOJSbBaWvRLjAKvVmfDKzR9dord2kPKEWtV
         n/GL0cKzB5im6oFxXOpO7nSW2UHv2dyilLSMNIEpvbZFC8v8ehalkxiIs92VdMkNYlZa
         1O8Q==
X-Gm-Message-State: AOJu0YzxpZANJXHxEL8C/QmeeIayzaW6ydbUMByoKQarI5Rvy+LRWfHm
	R6l0qgGWYnmpZt/ZtuF+FiXcLkKy2bU7st8WMvk1/Q==
X-Google-Smtp-Source: AGHT+IEmL5rrq5wLlnnaqRSO9ub79oAmIViHzpeNj5FYQOXBpuoSuqvIWXK3XkgNsd4A+E1BYbuhZg==
X-Received: by 2002:a05:6a21:81a9:b0:18f:97c:3851 with SMTP id pd41-20020a056a2181a900b0018f097c3851mr475039pzb.43.1702057744580;
        Fri, 08 Dec 2023 09:49:04 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ks19-20020a056a004b9300b006ce7d0d2590sm1886104pfb.0.2023.12.08.09.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:49:04 -0800 (PST)
Message-ID: <65735710.050a0220.7d948.6a89@mx.google.com>
Date: Fri, 08 Dec 2023 09:49:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-46-g596f4c151d286
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 1 runs,
 1 regressions (v5.10.201-cip41-46-g596f4c151d286)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 17:49:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13981

cip/linux-5.10.y-cip kselftest-lkdtm: 1 runs, 1 regressions (v5.10.201-cip4=
1-46-g596f4c151d286)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-46-g596f4c151d286/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-46-g596f4c151d286
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      596f4c151d286c71a3612a2120ab33f4ac885d2e =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65734a9d932785492ae134ab

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65734a9d932785=
492ae134ac
        failing since 65 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

