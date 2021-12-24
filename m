X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web12.47985.1640366228664824970
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Dec 2021 09:17:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=e/5O2cpw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id m1so8197653pfk.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Dec 2021 09:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=UMKb1fuaHPe/KeJ75RMY4INc7K+CU5Y0nP7PCrM7c0o=;
        b=e/5O2cpw1B1HGJJiSHBw201KtOEfYVvGECzmYOm+EXo01+/+sX5lM70uaiH6kzXhS+
         LHNnqMXekSQRxgUFraJCZ2H18SuDp7kX+ajkd+K4Du7CcCpoGZQF8Tp67mkm+hrV0cNJ
         vqnzywE6r8TIj8640dTNXTueOK+jenK5NZUewaaf1QSd1O213IpYnFoBOtlQFFxlLJZg
         W6rj3uJId3n26/Fg66uyZtajMYL4i2hFP+N/h8MjS42uu/telJXeJcwiYtWd8MP6Nwsi
         o6RMwT0wb2QtXC3RIZF8GX/3Gv5g/wCEEZHK0WPOt1x6TUkTX1/YPqFN0H22Mb91JLJF
         w3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=UMKb1fuaHPe/KeJ75RMY4INc7K+CU5Y0nP7PCrM7c0o=;
        b=3F3WJeZcw5d+Rb2HskZ1NgtDd7tpqccn90/EuO5y6vA0zClS1l07P6PzsdIW6SWP1P
         B7cjeryTElO8YC/1+dyrrrfgib2UlVitquG9hXw0clPqc+kE8IbUQAn+MvEOHlS5CBcO
         4vDLXgIKUBSFpS5TJdGWU1ylHzfj+DSjFNZz9GcNFmU1qKWildaESUhcNkUuB9IN1zYe
         Yr4hgMZ+bU/C6J78eDkWyo3v4rk9uVrqxH6LssLSyIdxlQii2uflx61/wPR1pIuLBXI2
         H8qPyL1DjYEtmL+TCD4R/GhMKPtmpaelERgYO7diB5CmsPcOffzKuMEnyjXrrOTubxzD
         d6sw==
X-Gm-Message-State: AOAM530CLZlhU0BCfKEZusYK9RA5E84YPS34wnCuhYqyrkAkBjLRi968
	9Piq/sLEY8Tt97RTsZBxUL3W/8gwBROJNEwb
X-Google-Smtp-Source: ABdhPJzuG24D4pk02Y+Lzged3oTV4yp/GCw83OJuQcwKDPXLXE6EbnHzd/+sJ72BlJxeKXhscGHjug==
X-Received: by 2002:a05:6a00:ccf:b0:4ba:ea96:dff with SMTP id b15-20020a056a000ccf00b004baea960dffmr7563983pfv.82.1640366227969;
        Fri, 24 Dec 2021 09:17:07 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id nn16sm13254140pjb.54.2021.12.24.09.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 09:17:07 -0800 (PST)
Message-ID: <61c60093.1c69fb81.c39bf.48b8@mx.google.com>
Date: Fri, 24 Dec 2021 09:17:07 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Kernel: v4.19.222-cip64
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip ltp-ipc: 3 runs, 1 regressions (v4.19.222-cip64) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.19.y-cip ltp-ipc: 3 runs, 1 regressions (v4.19.222-cip64)

Regressions Summary
-------------------

platform         | arch | lab     | compiler | defconfig          | regress=
ions
-----------------+------+---------+----------+--------------------+--------=
----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.222-cip64/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.222-cip64
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3cc384e269b518ae60e439249ece8ae4c189a810

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  871079f097443ac21fb5fcb3590e70370b84e9b4 =



Test Regressions
---------------- =



platform         | arch | lab     | compiler | defconfig          | regress=
ions
-----------------+------+---------+----------+--------------------+--------=
----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/61c5ee2ca6a664d8e0397131

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.222=
-cip64/arm/multi_v7_defconfig/gcc-10/lab-cip/ltp-ipc-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.222=
-cip64/arm/multi_v7_defconfig/gcc-10/lab-cip/ltp-ipc-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster-ltp/=
20211210.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/61c5ee2ca6a664d8e03971=
32
        new failure (last pass: v4.19.220-cip63) =

 =20

