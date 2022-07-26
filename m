Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B6DC19F28
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 15:59:14 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web10.8545.1658851153048434597
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 26 Jul 2022 08:59:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=zAB6B03O;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id 23so13477837pgc.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 26 Jul 2022 08:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Zyhz2FkckCWVdnYlrMQdMFs1olX+zKiOeL5BFEsbsU0=;
        b=zAB6B03OD01bLXFSloGZe/tPqk06Wj7Fm2q+U2r81i4YZEBBtqPOV07K9D5OOfmTxK
         7x9+WeSio0qKeKMdstF1NrXeRWc3HP43PuFBBewfuf9FJlIs6rKXmTUU28BR+j6eKB5g
         EHuG3Z9GajjA1DIVxKTZ0QHBT6Gi90vVdZjnblux92LN8zOAsGEH0o7fMqnXmKOt8FCt
         LefWH/A1hywNNjxivcQlDB8owHRjjMalDb7M7D7rVqeSc0OvkRtuUatr35+iBDfjmYVU
         vJfTamat7q3QLcB8wrx6DEYOm8QzNmfBU1MpHje4tmGLPsfubtSr+1mnPzaBQNPm09jk
         J18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Zyhz2FkckCWVdnYlrMQdMFs1olX+zKiOeL5BFEsbsU0=;
        b=CCpMPsA+wYrZgPUkbLdNO0IsjHS0cxrHYLE1fGXOiowAtvi3WB0Dj914fVkiafFc7Z
         VC9NsSlCT564WON660wCOGZ3EEX9KOtvi+z1kCYGEQ6k8fSxRN1bnNwPw5Q2S2B2+hJf
         jBNaP5gdHDscQxa+h6mY+AW9JpkEt4G2ZycNO9NJ56AwDEs9V/FSIdtrgUWpHnluLrBI
         FnHBBWoZfZ8nnRhvztuNwSNoZ6ESpiqJITpvsXaCip9ULx7xMOZOt+qSqlq7X56OtZZg
         b3zFQtMeT/y8NumFeNsWOVBT2YlE/xO4Y9ObNXGzss/+pRDo9WXMusonhP9M381/9jij
         I4Uw==
X-Gm-Message-State: AJIora/37cSXM2eeL3jfQEME8PbidPia/4ICsI2vmMSr6rVvRbV8pMhM
	mlqEQAFprwPmGKt+rn89chLZfeRciPQ8wIiF
X-Google-Smtp-Source: 
 AGRyM1u7er7PdlpatunGFEQ2tMMbsVH3YBJI+wXhQbt0BitjkN7NMNkazDx8F1ULPNYCbIxYMIxs0Q==
X-Received: by 2002:aa7:8286:0:b0:52b:5ccd:f6bb with SMTP id
 s6-20020aa78286000000b0052b5ccdf6bbmr17825506pfm.34.1658851152081;
        Tue, 26 Jul 2022 08:59:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 cp12-20020a170902e78c00b0016d95380e8esm2525728plb.140.2022.07.26.08.59.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:59:11 -0700 (PDT)
Message-ID: <62e00f4f.1c69fb81.2f95.48c5@mx.google.com>
Date: Tue, 26 Jul 2022 08:59:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-586-geb97410e0086c
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 2 runs,
 2 regressions (v4.4-st5-586-geb97410e0086c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 15:59:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8946

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 2 runs, 2 regressions (=
v4.4-st5-586-geb97410e0086c)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-586-geb97410e0086c/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-586-geb97410e0086c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      eb97410e0086c865c804bdc822e061764810486c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  bda92ad659a52d38ac810099f69adff626b064c6 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62dffbc9b73ee60432daf085

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/62dffbc9b7=
3ee60432daf086
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e005acd72db456e1daf0ca

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/62e005acd7=
2db456e1daf0cb
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =20

