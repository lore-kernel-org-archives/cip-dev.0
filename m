X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web08.24255.1647251581829686065
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Mar 2022 02:53:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=th038f4E;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id f8so13847567pfj.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Mar 2022 02:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=DQkAMqWUSkx0mnqbgPN23WP2j+FLZvIA0pZsxzxqe1c=;
        b=th038f4EXC3SbEhiEpouM0JvsUdnPpLycecYexCB0i3e46o39fJPHe3zLsh4FOr5BP
         PSeXuHul1feWEfDUpNHcACOlw9pfltrSWODwFtWlfCeLMimzjoBv6j1uovmEkqRW5LQc
         dOySJqohh8mc5R5vnGxxnzcPuGsB/8hbwhVMsysQgk/qnf09wF1IT8Zx7/5GplgbDtQm
         gEc0L9bAtnqSCpPkQ1utr/vUFE8SOP3t6fXhdIH1kcxuNxxRXyMioJppXBJBatkVTcGZ
         K1Bq8zRGU0sjjj6t6nK66UnFfKJToMSjN9lYhDInG5zdZvxb9G9iwCJe2baOZsLtwX5Z
         Vagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=DQkAMqWUSkx0mnqbgPN23WP2j+FLZvIA0pZsxzxqe1c=;
        b=O2kG4KJIoCoUiC/O8gC1DjJDEmZ8WiL/udE2FFhiTtzRDC29ZXI3gJPVSEsI62TAaI
         bCsK2FLAKnA2FDBo2mbJWv9H8E9jeSCRSyIUjoAN+RLq38wW5FOVMO6DKo4v/UsFIOXJ
         QzSiZyuRLwQDv0XbaqpDHasPaSrq6pPuR3misj3MISecx1AB+x2oAeOY01NBnhPRGj7y
         Z08+qWZNuMzJsJusL905fLStrjhnqwQpWEhl9JfEBddkRac1oQ1BD13E0tS9pdZ0Ih69
         w88qzOCvkl8LaNF5uAkAntn+ro4EcvssdHFeckDdrprFCjNoIlJmfha4yVkRa0hg+Peb
         yMJg==
X-Gm-Message-State: AOAM533CzpSCD9/R6KjNLMh3/w6ODGcDRFjZ8ywv3hUlKvyiKK04MyGw
	ULo83oPxU1b1R2suRCY9oIPGS8mZk4L8eIcZP/c=
X-Google-Smtp-Source: ABdhPJy6u2bKJyGQELtaNQ56p+6gMIbVPB16KIH+VVtoh357QtlikdfnJCj+l767JxNaE1XXFIjHQQ==
X-Received: by 2002:a05:6a00:2481:b0:4f6:b71f:3330 with SMTP id c1-20020a056a00248100b004f6b71f3330mr22906990pfv.47.1647251580974;
        Mon, 14 Mar 2022 02:53:00 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o5-20020a056a0015c500b004f76735be68sm17261810pfu.216.2022.03.14.02.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 02:53:00 -0700 (PDT)
Message-ID: <622f107c.1c69fb81.f7ecf.bb2b@mx.google.com>
Date: Mon, 14 Mar 2022 02:53:00 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.104-cip3
Subject: cip/linux-5.10.y-cip kselftest-filesystems: 3 runs, 1 regressions (v5.10.104-cip3) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip kselftest-filesystems: 3 runs, 1 regressions (v5.10.10=
4-cip3)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.104-cip3/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.104-cip3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      811c07d2359f700f05d08c49b9d8c4333322bf90 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/622f009a85c65c60e5c62970

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.104=
-cip3/arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-cip/kselftest-f=
ilesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.104=
-cip3/arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-cip/kselftest-f=
ilesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220228.1/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/622f009a=
85c65c60e5c62971
        new failure (last pass: v5.10.83-cip1-178-g2cf1d12aab81) =

 =20

