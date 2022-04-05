X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web11.374.1649181344633641837
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Apr 2022 10:55:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=x0uQUk1a;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.178, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f178.google.com with SMTP id d185so6323pgc.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 05 Apr 2022 10:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=lv3UsB1xS7TQF3DoEaOiMLQu0fXJF7hEfZq0VaQ3sVQ=;
        b=x0uQUk1aT6+akICBaC7U46zxUxj8aOR/5afiuyCKlSKk2EIvXe1nleg06q0Sc4VkgY
         9I0faHfa/JUrFpEh93gqTjJcwPQz3Y66FiQixaQjB3GXl940ZXUmIEFeIEEbY1tF/gaM
         r61nUEtvCN8mLK1eDbvIpE3oGWZDws2MvHEcv0mayfLkM67beSrYgDHFrT6FriQ+BvIQ
         1RzLGRTCc5HMTB49CxYcPqFF0pwgd3mhQphi1VVwFBmy/p92OwRUmbwahJG8rTIbpPgg
         fMbn8Qi/JbknvFzdeZU8dvtGgEvu/ozkfg/Qy5ysuVklQ96onoEcZ0gpjEdS1iGsbeeK
         EpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=lv3UsB1xS7TQF3DoEaOiMLQu0fXJF7hEfZq0VaQ3sVQ=;
        b=A69mE5SJIAE8nmOCLTbKKAgqaPjlZiMzPB/YrrQS0MEhEXXYCfqtcvgruRbo8dCuyI
         /KMwxE27ZH5TWq3DGD6M0esq0vCaM6hY8GBBKSgAIxrVV+2RGp7K3i2kptcL89WXZVnS
         eji/S51Cy5hD+RHk5aWebCaiHt4r8vzNG4jmblUkPjI/84mCEMI4P88VerO/q6l/c7Cx
         T033lKVEoerV1ryU3mr8q68EZbF/7iIKffUcplLystqdrYfduiDsKCMtI04huBuMlMkM
         E9XfoMSQpgS4fmIP5k7RnQGmV1EKLJJG9Ug5k2bP1b9uH3/wUsnH3hZFeCS05hmu3w4n
         ffqA==
X-Gm-Message-State: AOAM532nTiQgAdv8KyWzJaFs73lKXmWGrD/tAvQpnGeoPIBpmplMmJA3
	kBvzS13CtoekI9Pu73hKvbSh0EinNOfPK7ZN584=
X-Google-Smtp-Source: ABdhPJylAxYh9BdvQU2cVz94onqxBDRZDEMwxD42UzXP+q5bDPtYIn7CYlzUc/EXSLs1kekcauJD+g==
X-Received: by 2002:a05:6a00:1145:b0:4f6:3ebc:a79b with SMTP id b5-20020a056a00114500b004f63ebca79bmr4680051pfm.41.1649181343748;
        Tue, 05 Apr 2022 10:55:43 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f12-20020a056a001acc00b004fb37ecc6b2sm16231191pfv.29.2022.04.05.10.55.43
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 10:55:43 -0700 (PDT)
Message-ID: <624c829f.1c69fb81.cfb41.ab59@mx.google.com>
Date: Tue, 05 Apr 2022 10:55:43 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.106-cip4-69-g05f5682c2c593
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 50 runs, 1 regressions (v5.10.106-cip4-69-g05f5682c2c593) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline: 50 runs, 1 regressions (v5.10.106-=
cip4-69-g05f5682c2c593)

Regressions Summary
-------------------

platform      | arch  | lab     | compiler | defconfig | regressions
--------------+-------+---------+----------+-----------+------------
zynqmp-zcu102 | arm64 | lab-cip | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.106-cip4-69-g05f5682c2c593/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.106-cip4-69-g05f5682c2c593
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      05f5682c2c59377ada2908abab911e0718b50f7c =



Test Regressions
---------------- =



platform      | arch  | lab     | compiler | defconfig | regressions
--------------+-------+---------+----------+-----------+------------
zynqmp-zcu102 | arm64 | lab-cip | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/624c7b9d223a163e3eae067c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.106-cip4-69-g05f5682c2c593/arm64/defconfig/gcc-10/lab-cip/baseline-z=
ynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.106-cip4-69-g05f5682c2c593/arm64/defconfig/gcc-10/lab-cip/baseline-z=
ynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220401.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/624c7b9d223a163e3eae0=
67d
        new failure (last pass: v4.19.233-cip69-1019-g2e5815777e975) =

 =20

