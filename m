Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F40EB64DD
	for <webhook@archiver.kernel.org>; Fri, 23 Jun 2023 13:13:55 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web10.41654.1687526034435213786
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Jun 2023 06:13:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=aE4Y6C3l;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.171, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-557564777f0so423959a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 23 Jun 2023 06:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687526033; x=1690118033;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/+3BU4AoT+VZC3BjMG5YOkNpu/nxCGdjVGT1GEJAVY4=;
        b=aE4Y6C3lgesMhVC6hos0W56esgMFJK8Eld1NddyL6DIL5uSKoLaNOOQnprnkZMqZo/
         EKbnpE8PX9dZ+EVKPCwtFWNLQ7IN26nx0As1Qr64gGu67veaI9KvT/dKbW9iaY7Rv6cM
         u2D2Rk7KN4wfFHxdGPvPsRegfst7b1vON993ssEtk0+PNlM5KVn5TJaFlMrzzIgERUtN
         j6DRmEq1vke2SOGEEAsfr0GCNAHlW+cShbs3bX/u+onj+O+iOLM74td+FcTCeMmlwivV
         mGpbzzG9wNAUdrSkMT5zT/ZpTSeDQXrt/R7miTXz1ytbr3XvyQoh1QrIUTQhNJyjATbe
         21aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687526033; x=1690118033;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+3BU4AoT+VZC3BjMG5YOkNpu/nxCGdjVGT1GEJAVY4=;
        b=Le3iwLD5J3J2OsiyvDyuLHj8OIDD512GhZvo5llvJdszQDtvC2Z1cj5qdZ4JeJhqQ2
         fJaUHVgsSuT63RtwtiCLJcglFmvc6LFVKZyqr/YlwyfVdaqFM3pTvayzvoswyc51DHrA
         rGrEVEavOyoREbdzHpoKjxdFXUZELdRbO/yRu+oC9LT/wBng1WlW/vQae5GLolWElPez
         a+Bs4EKyGCkcNBplXjuFcoI8RWa8NfijwJDt0VH+aRbhROHBLMDXYiXdxEwe/+d1IRLd
         ykuVLE2FoWiYeMW8dXL9H4bg5ENnWYYBkDYuhkuFVbT0NJ+R8wZY0tzR3waTY3g5we5J
         WW+Q==
X-Gm-Message-State: AC+VfDy5jvxhfQFnds5ki1Drp3O0K260OpjW5zdoqokmJEqLs0i0vlug
	86OtYAIL/vplxQSmp9WJo/QDjs3CoJLAPMMrITpTWw==
X-Google-Smtp-Source: ACHHUZ45IXujCJKyPFAN4bmWn7CjSvpXRT53nO/3SL7uaSKkMVoBZzFcvI6LuhHzlAr/WxSva3r7xw==
X-Received: by 2002:a17:90b:1081:b0:25b:ee97:5f7e with SMTP id gj1-20020a17090b108100b0025bee975f7emr14859189pjb.42.1687526033374;
        Fri, 23 Jun 2023 06:13:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n20-20020a17090ade9400b0025bfda134ccsm1481554pjv.16.2023.06.23.06.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 06:13:51 -0700 (PDT)
Message-ID: <64959a8f.170a0220.9a9e2.3202@mx.google.com>
Date: Fri, 23 Jun 2023 06:13:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.287-cip100
Subject: cip/linux-4.19.y-cip smc: 5 runs, 2 regressions (v4.19.287-cip100)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Jun 2023 13:13:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12142

cip/linux-4.19.y-cip smc: 5 runs, 2 regressions (v4.19.287-cip100)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.287-cip100/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.287-cip100
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      843423b3724d762d5593ab9aaeb68ac695871b44 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64958978c1ab2b493430613c

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/64958978c1ab2b4934=
306148
        failing since 349 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-06-23T12:00:52.640207  <8>[   11.970490] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/64958978c1ab2b4934=
306149
        failing since 349 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-06-23T12:00:52.630620  <8>[   11.960957] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

