X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web10.463.1649866938056284968
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Apr 2022 09:22:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=agoy4LrG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id 2so2525929pjw.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Apr 2022 09:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=beW4JQSO0mFRZhphK0eVj9g/9u7S3SqD27iRCuk8k3s=;
        b=agoy4LrGPlUEbS3M62rtC3M4SlIG6rbdFL0hkysc672htIOnYI7lU9EcX3pWa9WuXL
         LsOqI9wF+9CoYePqLuSuSXPugml6bXKfTvyF0g6/cMP69DPXq9SJMf3u7GRMfJtDbnj8
         Hv2bRAD/lMoIUXTBnplc4HdswloVPCF4G65cVYNBZc1QHgYNet8Qgcti3kXU+YjIaBNu
         wjaNeESuOnW/QYFdH2jpWVlpVldmSl0dauR+uHWLqMCy5yHdauf/7FRlp1nVRo7eOXSt
         FSerHC5gdCuzQAT5J5UXxPMmB2ub4ohPB9u8DenxzlJFi+MDYeNMUWvXR0t9qtQH7K8V
         240g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=beW4JQSO0mFRZhphK0eVj9g/9u7S3SqD27iRCuk8k3s=;
        b=gsV3t6jTK3pATrR1VO7DWZ064+RXYMB5DS5RrqOFStw7uGKQKYcGZbOYgHoz4mVrKP
         8lrJszD32CGeIpMi10yvf6Icz9RgwKe+goy6lRJ9LNpjq7t1zDAHWGN3H1qK5NwGTB31
         EszS+mIgC7NGOOUpDyAKYhKlqTTeOM2sX9eXVKcVO66hObhbaPi1PPpm75ApI3La01T/
         FwIf9hFQseym4V4qgDAJIuXwYqNXB2E/jSaq13AplceJsOHzu9z0XJF8ZK6YU9uq2YpM
         XUVYudKJjqQnDowfXdjH2YNFxRpbKwk0mHa1cqJCNBgBLkM9ITTBlaahRck7PMsYea+J
         HClw==
X-Gm-Message-State: AOAM532ZZdPOVa/siawS3QnGqeaba14mSCHJWrDXnZ2DA7hiE+Uq+44q
	NGT62I0BOD8PCQ3QJ/rC5JwTVfD8v48aY/KK
X-Google-Smtp-Source: ABdhPJzLDJJbgyvSlQodYykNaqkPz5oCo0hwqyXfmVtvH/qvfpaiG25UgvG8pxvh0FtcfZi1L67kDg==
X-Received: by 2002:a17:902:dad0:b0:154:740a:9094 with SMTP id q16-20020a170902dad000b00154740a9094mr43309008plx.107.1649866937469;
        Wed, 13 Apr 2022 09:22:17 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y3-20020a63de43000000b0039d1172b90fsm6670149pgi.76.2022.04.13.09.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 09:22:17 -0700 (PDT)
Message-ID: <6256f8b9.1c69fb81.2161a.15e8@mx.google.com>
Date: Wed, 13 Apr 2022 09:22:17 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.109-cip5
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-lib: 6 runs, 1 regressions (v5.10.109-cip5) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip kselftest-lib: 6 runs, 1 regressions (v5.10.109-cip5)

Regressions Summary
-------------------

platform             | arch  | lab          | compiler | defconfig         =
  | regressions
---------------------+-------+--------------+----------+-------------------=
--+------------
meson-g12b-odroid-n2 | arm64 | lab-baylibre | gcc-10   | defconfig+kselftes=
t | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.109-cip5/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.109-cip5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      9c39c65c57028fa2c58fb7579c15f9cb67571acc =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig         =
  | regressions
---------------------+-------+--------------+----------+-------------------=
--+------------
meson-g12b-odroid-n2 | arm64 | lab-baylibre | gcc-10   | defconfig+kselftes=
t | 1          =


  Details:     https://kernelci.org/test/plan/id/6256ec3e949cc1a87cae06a6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.109=
-cip5/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-lib-meson-g12=
b-odroid-n2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.109=
-cip5/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-lib-meson-g12=
b-odroid-n2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220401.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6256ec3e949cc1a8=
7cae06a7
        new failure (last pass: v5.10.106-cip4) =

 =20

