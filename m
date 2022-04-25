X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web08.33453.1650909207946797093
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Apr 2022 10:53:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=UXi/bV1L;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso41953pjj.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 25 Apr 2022 10:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=b4Qr+Hxg3a5wweI0xLl5J7kxSldZuvluM6fLMw4Mb70=;
        b=UXi/bV1Ldpb4uC2vOaLGCWzinBvaR0fAfEbkm5T3BAyc/UorFfNjwu6n6OHUdfE4NM
         vSNoxhbELXTVWchRpUhggb1mj42cRgI0ELifdkYTh7Shf7UPtBFBd6fiTKkGSQV5npTZ
         YirlmLuQxGesw2j3E+Aa65e3oepjlgXSJT7LceDeriLxZll+tx+ipjugzqM3lcLXCRLW
         8G00i2qeQF2BR3sYpq/8izRXYKRjKVnUaXcd6GLr65/j9/N4gWBjfVcnvLLLwtNr9Kkd
         qX8POyaPVmi5PRjtZED52z1V2iCwZQqeO0UgMgFxWh7kpmrR7saI4lBFXCHI8eLj7N4n
         9+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=b4Qr+Hxg3a5wweI0xLl5J7kxSldZuvluM6fLMw4Mb70=;
        b=jLr3faagGqPBGm4RbNPVaidNQ3HIU+eYBn8/QMXXHATIgcHN5GJZ5HUzf5h+lFwVAL
         k4hCsSZomSSDSiMHAgJYkrxD3EGrW7xW9PphPa79obPid3TUD5xXtuTn7DgMIkZ2F0v/
         FIIHcrs/GON1WSd1IgyqR7KwN+qr0CwvVcIuWrW9KNBb1yc+MQTJq3orN9WtDXM7+30F
         xMV/j55k+4AZWf13eEeSwB6iFdrhSBShB0EGJhryWOBpiDAqiFruXL5DYpU9ju5er3A/
         vfD7zqtBoOfMeTazpeQTEAu/6uABpidJDZyRl6Rb8Ctm+L2e7CP8LbhBtcdbokkQWLk4
         DKaQ==
X-Gm-Message-State: AOAM532H0n/GjUQS5L1FeGWzI/usPrCLIk8uhUwjWQ0yCdr+Tv4PENrs
	na/CG57CgWZ6FEXfT5WpNBnIO3hr3Z3jyM071M0=
X-Google-Smtp-Source: ABdhPJzOTms0STvgxsGG2KVi4W9fEK/LszHIaS00zDpeyM8KA46WXJZr9q83DV2+a8wP7maM/bxuMw==
X-Received: by 2002:a17:902:ccc9:b0:15b:c265:b7a0 with SMTP id z9-20020a170902ccc900b0015bc265b7a0mr18491614ple.107.1650909207360;
        Mon, 25 Apr 2022 10:53:27 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 8-20020a056a00070800b004e14ae3e8d7sm11700146pfl.164.2022.04.25.10.53.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:53:26 -0700 (PDT)
Message-ID: <6266e016.1c69fb81.b6b0e.c086@mx.google.com>
Date: Mon, 25 Apr 2022 10:53:26 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.109-cip5-899-g234e7e7d5bd3
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-mm: 3 runs, 1 regressions (v5.10.109-cip5-899-g234e7e7d5bd3) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-mm: 3 runs, 1 regressions (v=
5.10.109-cip5-899-g234e7e7d5bd3)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.109-cip5-899-g234e7e7d5bd3/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.109-cip5-899-g234e7e7d5bd3
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      234e7e7d5bd36004288823dfb36ce5e3d2f6e940

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  4e132c1f9e14f9eaeb4f9875eee3f97a4a1ac987 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6266dd4a77972776f1ff948d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-899-g234e7e7d5bd3/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-mm-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-899-g234e7e7d5bd3/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-mm-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220422.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6266dd4a77972776f1ff948e
        new failure (last pass: v5.10.109-cip5-875-g6ed0fe2c3e8b) =

 =20

