Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514DDC77B61
	for <webhook@archiver.kernel.org>; Wed, 29 Mar 2023 16:30:26 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web10.1129.1680107424886130454
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 29 Mar 2023 09:30:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=jsZmY2cc;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so19116095pjp.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 29 Mar 2023 09:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680107424;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OFuLKbVCoJ0E9WjTow1XX39OMVf+/3Wf58FfmORDioI=;
        b=jsZmY2cc+ruZpiw1xNQ0gGAcwXS7RkK7o/oxgR/4Bm5qIeNr2zbmmD9EerzXfTE9GF
         iPuMC46CApF0fpKtNNxqiwsolnBvz7/LehMGfOnzPDjOkSmdV+imLhS4U548g06h6QV0
         co6qXaRAqPabJjVKKWh/ewTIPLr1tmVJwGE/2oIC58pIQesQRz12DZDmI3DrinaKFXkk
         LP9ol7TSRV0TeDuPBeFn+YLtSHun+zqIrG2lILW9brWXocQ2ZqeGdbj75U+Ld7wUEC7q
         R1233NVUsiNpXTXOh0vTeTGnyF7wvguI0/HdS1uRx1QPvXw8NKNYwMkSg9eNiM7/gpHN
         E9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680107424;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OFuLKbVCoJ0E9WjTow1XX39OMVf+/3Wf58FfmORDioI=;
        b=Sxauc5GuE3wtnd6j2Oryez/N8oSjV5OLDY7PlwIBRaSqMNkOxr6VPPnvmVD7nzt0sr
         pz4IXTEeXhTT7Iccq8Th0O+4sQVIg0peFozCL3uvb71Ut0HuPDNwmIoo0sanjNkomewe
         Cl15itlhrUsrTPD5zEqHmr7rkYa84/EvX8eURG5jUeL5S2L47cS8UHK7CH2AZByomDQu
         BcUM1nLd9SJfAT+8OK6dFzTz83yRdbtU6wlfMDK/MJCSvwH/9t2uJoBeeJz3UVa1G2Tf
         bbKY+C08IWfMdIAAH9bxAbGTAbFPjuCap7417gSOwEt42CsHAXK3S9D6ad3CeKtw3oYw
         Rfww==
X-Gm-Message-State: AO0yUKWQAppk+iS8r2R83+7FvtEa7HY+ICp/mon6hqP04WomYKSk60br
	BiDMLyc6KYkLv3dM8oOt3XSBte+eFqgXr59EWh2hBA==
X-Google-Smtp-Source: AK7set+TxLpShLxW4PFti0jiPQZVc3XSuoJFw2R6yVTFow8+das7oGNx+mTYPVPG4SXyGON0tNkDGQ==
X-Received: by 2002:a05:6a20:3509:b0:cc:606a:4330 with SMTP id d9-20020a056a20350900b000cc606a4330mr14246928pze.55.1680107423774;
        Wed, 29 Mar 2023 09:30:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 15-20020aa7910f000000b0062c0cfbb264sm9564444pfh.93.2023.03.29.09.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 09:30:23 -0700 (PDT)
Message-ID: <6424679f.a70a0220.d57d2.12e5@mx.google.com>
Date: Wed, 29 Mar 2023 09:30:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-1097-gd51b0e04681f
Subject: cip/linux-4.4.y-st-rc kselftest-futex: 5 runs,
 1 regressions (v4.4-st20-1097-gd51b0e04681f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Mar 2023 16:30:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11127

cip/linux-4.4.y-st-rc kselftest-futex: 5 runs, 1 regressions (v4.4-st20-109=
7-gd51b0e04681f)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1097-gd51b0e04681f/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1097-gd51b0e04681f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d51b0e04681f73604e7ebc991f6a63833a70d3c5 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64245358d4947246c662f77f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1097-gd51b0e04681f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/kselftest-futex-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1097-gd51b0e04681f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/kselftest-futex-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230324.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/64245358d49472=
46c662f780
        failing since 70 days (last pass: v4.4-st20-799-g1229c813bcd9, firs=
t fail: v4.4-st20-821-g39bdf0444b23) =

 =20

