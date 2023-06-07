Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07920C7EE23
	for <webhook@archiver.kernel.org>; Wed,  7 Jun 2023 14:19:48 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web10.9827.1686147581467998422
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Jun 2023 07:19:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=ytgAFBWi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-651f2f38634so7009743b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Jun 2023 07:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686147580; x=1688739580;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gV9iJsxqOLBkbPLwgi/ZLLSl/Y4REvMiX5WDfGZQCEY=;
        b=ytgAFBWifqVMuDJvbeZZxCC5lcWLKX1gySY0UIAPnkW1Uoel2k11BiIzci2+Er4Fmc
         LxiVLudhRus13jyuFfJUTvhJdkAVCoHQTsnI+JWJyp8bxW/d1n21S1/73/uCe/5Blqiz
         oIHq1etALIKzVpx7f2yna9xePTxYB+zKRROBO4z2kuByK1hHHGZnkFSBqTiKr/XqRBui
         QFleKynPsKfD4kiDxwur+lBB2PkrV3ZlZhSYag1rHVLWQplEhwm2bW3cXSQrNA4AphsQ
         FR3qRf9rPOCwJHV+QoiA07jZaRg/mkD9TScjcARjfvfc+9liklF5ZHhMZxYQmDjWF5ZV
         KVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686147580; x=1688739580;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gV9iJsxqOLBkbPLwgi/ZLLSl/Y4REvMiX5WDfGZQCEY=;
        b=XtN+y1OEph8F409O1CTiF5WOOMxZs1wDi2wdcYoKF468Vc3rX3LqHvdpKJGri9jbY2
         X7U9Xije4G0bAJmOCS2BATkF2YHRZZAX7mUeq7sjXWfzCGcWocZE15l+icWlkB46V0I3
         DHf4AcooMRKbV9g7XVHskJC4VLDtlAD4rZ6bDsUTjMLOoghKkvc+Ahf39NlvtvAjry6e
         PxAUNPEl8t8qEFtkX8+rsbOwlIFXEgAU459DVa0isjtHtU2kOFIPCf4f41uenZYB56nx
         0EKqvl8xt4YUv72z6o4zLLnSnk6o4p+eP4kQzy0bkPT+NkESnvPGcw77GIizDInwo4L5
         rKsg==
X-Gm-Message-State: AC+VfDxidtWtKye2FgR6Y5fwUbLO5KNC4z0oXV5UzftoGDETUyKhSruY
	GVBl53PTcTU+dtKJSdxV3UAX9O1mEQALET8ug/k49w==
X-Google-Smtp-Source: ACHHUZ4n/EkSoMQLuqdcADYDkrZsCNTeU3Q4rC/JSyHS36U6JzCqwlvxC/opsoneB0kqXOTf8104Qg==
X-Received: by 2002:a05:6a00:88c:b0:657:bdf1:cce1 with SMTP id q12-20020a056a00088c00b00657bdf1cce1mr7361769pfj.25.1686147580354;
        Wed, 07 Jun 2023 07:19:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w7-20020aa78587000000b0064d681c753csm8447764pfn.40.2023.06.07.07.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 07:19:39 -0700 (PDT)
Message-ID: <648091fb.a70a0220.30b2c.f7bf@mx.google.com>
Date: Wed, 07 Jun 2023 07:19:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rt
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-2172-gb3363b986efb
Subject: cip/linux-4.4.y-st-rt baseline-nfs: 29 runs,
 1 regressions (v4.4-st20-2172-gb3363b986efb)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jun 2023 14:19:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11911

cip/linux-4.4.y-st-rt baseline-nfs: 29 runs, 1 regressions (v4.4-st20-2172-=
gb3363b986efb)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rt/kern=
el/v4.4-st20-2172-gb3363b986efb/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st-rt
  Describe: v4.4-st20-2172-gb3363b986efb
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      b3363b986efb791c4506119c9fbab1b52628f0c7 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648082f9b0440fdb8c30615c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rt/v4.4-st2=
0-2172-gb3363b986efb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rt/v4.4-st2=
0-2172-gb3363b986efb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/648082f9b0440fdb8=
c30615d
        new failure (last pass: v4.4-st20-1684-gd04aea87b5a3) =

 =20

