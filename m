Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B394C32774
	for <webhook@archiver.kernel.org>; Tue, 23 Aug 2022 05:31:09 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web12.27974.1661232664704099040
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 Aug 2022 22:31:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=rAM1m6mG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id p13so488046pld.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 Aug 2022 22:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=3bKrFGxFOoG54ZifrUQfjBVZjxHOxN30YwKegdThrOE=;
        b=rAM1m6mGi71o0fATvaUt9ZtcV7h9Yv78LwtuyXnn4hSBzUcfm2N3hxBW6JGxfdKn+6
         qbdISyx17wqHVtOgcwdEJ/jg5NCg0JY8cVfY4wjDL58jRgUT8xLa5AgL/ZTtQsy1iSQf
         6+wRpRtNNhblSRtm3sMOJX6Fe7Lg8SlOS454azBkICgV/uvR1PdtJzetQMrRXgoZOZuF
         pietBuxB9Uaf7MtagGc1QKEiIg37rQAf5hCmi3RCDwKVhJl+hzvVWdFBMysNbSEPbn4g
         QKSGaEEQZc/kw8w25Yq+SuG1zCDIbuOGXBuO83GvAiH9wzNMgWwo4zP9i32QmNYXyHZR
         GuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=3bKrFGxFOoG54ZifrUQfjBVZjxHOxN30YwKegdThrOE=;
        b=KxmZa+2dGnozHwysfBXfpmUh0cNj0bocF1kRQe8G/TjHppYoGOA43swgkl4BCYDrWl
         u+aU0Zm6q0MUZ7ddQa9XqgXWpREUzyyyeOz0UBCUQtlpjxIcpLvz6r/HVM/zE7Hl3/Ck
         xMHbQnNoMzYavC+lc2ytNH6vXRpOq4EDqgP36UhvULAcck7nev4oZ7dMBRWXosdCN/Dc
         7NM+dm+wwqNOeeDl96grhLTv5JD1CIeeIVTY9e2yGX6NAA0dk7Q2OBgLVX6lDDC/7eIP
         mCCKraxOSMG/Z6+doWcrCi4eKAJUUxrj8mAKSj83JJKo6jk1+9seOIvTTSZHodbIrnKU
         EVDw==
X-Gm-Message-State: ACgBeo2ETY6CZXXWMv28ucsup09yw9WRHxj0lLwyGbqqTgmIx8HPn0Yg
	WEH+x430KqcHVts1AhAq6rjctXTgH9MyBn0E
X-Google-Smtp-Source: 
 AA6agR4cMI8RgezGSYCnBDBI5AMUqXALnQYXagv5UUrbwYtx/U3nvnBrhSDB8NRKERnheyLr5JM+/g==
X-Received: by 2002:a17:903:1ce:b0:16f:1c1f:50e5 with SMTP id
 e14-20020a17090301ce00b0016f1c1f50e5mr23767328plh.132.1661232664000;
        Mon, 22 Aug 2022 22:31:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 u3-20020a170902e80300b0017272667a56sm9409248plg.196.2022.08.22.22.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 22:31:03 -0700 (PDT)
Message-ID: <63046617.170a0220.acc8c.1403@mx.google.com>
Date: Mon, 22 Aug 2022 22:31:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.255-cip79
Subject: cip/linux-4.19.y-cip baseline-nfs: 17 runs,
 1 regressions (v4.19.255-cip79)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Aug 2022 05:31:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9308

cip/linux-4.19.y-cip baseline-nfs: 17 runs, 1 regressions (v4.19.255-cip79)

Regressions Summary
-------------------

platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre | gcc-10   | defconfig | 1    =
      =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.255-cip79/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.255-cip79
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d48af81b093ff24e12907e79ce476e6efc4f7e4f =



Test Regressions
---------------- =



platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre | gcc-10   | defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/63045e9209f7cd318d3556ba

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson-gxm-khadas-vi=
m2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson-gxm-khadas-vi=
m2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220812.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63045e9209f7cd318=
d3556bb
        new failure (last pass: v4.19.233-cip69) =

 =20

