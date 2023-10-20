Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583B3CDB474
	for <webhook@archiver.kernel.org>; Fri, 20 Oct 2023 15:22:39 +0000 (UTC)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
 by mx.groups.io with SMTP id smtpd.web11.57279.1697815355761783182
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 20 Oct 2023 08:22:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=SVOVWyo1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.50, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-57de6e502fcso517707eaf.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 20 Oct 2023 08:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697815354; x=1698420154; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iXiG9G5Kz/cwkUHUhYfWMkmnyZAd0f9EMjmMaOGh3WU=;
        b=SVOVWyo1Wz3Pm0r7//VfDYg8ygbLLAqt3miPx9vIkzkjsufS27lnVFP9/qWep5Wonr
         0zbhn0KCWckvtiiKKThUwbDyW8qHemLId8xMg3WF5ZCkp8VmFo9p8/8C9aN/gA9fYJpR
         K+iOSI4HRiJ1mzXNrPPz+P/Vxg9SJC9ni24LLcqwxTyfgZoem1nEuPLZxi9qWPrkb8A9
         Q/gvMpDew5fwZWTdQak6kvsabd7nFDQDRlunffEc5WQFF8V74XKzCR3Pt0FOWIjdXSBr
         RSBZCl+hLGW16dW19ZeM8WuHNO0CaUTB9f8HN4TNQvOEhzG5YhxqfRrr+T2apjDtiKu7
         f3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697815354; x=1698420154;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXiG9G5Kz/cwkUHUhYfWMkmnyZAd0f9EMjmMaOGh3WU=;
        b=NCa1EkXc/KsEVrfd/C2PpPFaTIYbHR0jWSIaWzbUUNuSDA6eAjC6/5uNrLiYCuDDsj
         XA5vSbAHP4bj+qh1/E3aMWFvVglPOezzEvjufdGR7a1R00FooTooWWU4vl6vBAHF4Dfo
         BOmzIzl6UQK5j9lV7d/0/NCbKPHiE2mNpxTsmRf1BoZUiiDJAXA8qUEPOpGwci7K7z++
         UBCFIOi2BEhVZABda47ob9mD71ZsxGYcz2ymCmO85TMmw0gcD49w9eQXo3QMXLhvWG6j
         vNj0lB8VPEa+dTuxM6P6rCpYSaM/AGhhoP9lwcwarCq11SiRYtS/9NJCSMaHsKj5jBp0
         5M4w==
X-Gm-Message-State: AOJu0YzkDXakqqVKDyAVKEx2PYRqSFfmiEYw9DI1zzpFoNxmAwu20vtH
	BiiebhbDKy4oM5E5Y5tdS7VpGyCB+VlCSfxEUB32qA==
X-Google-Smtp-Source: AGHT+IHCeZR9WJavkbO015ao6hhWbPf/puzzwf4bC8NyqKioo1tr83TuJgNp30nkHi1tsljkPohWqA==
X-Received: by 2002:a05:6358:9986:b0:166:c218:e517 with SMTP id j6-20020a056358998600b00166c218e517mr1979696rwb.24.1697815354575;
        Fri, 20 Oct 2023 08:22:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m33-20020a635821000000b005af9dcb4756sm1580053pgb.42.2023.10.20.08.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 08:22:33 -0700 (PDT)
Message-ID: <65329b39.630a0220.c34ec.577f@mx.google.com>
Date: Fri, 20 Oct 2023 08:22:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.295-cip103-rt33
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip-rt ltp-pty: 8 runs,
 1 regressions (v4.19.295-cip103-rt33)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Oct 2023 15:22:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13417

cip/linux-4.19.y-cip-rt ltp-pty: 8 runs, 1 regressions (v4.19.295-cip103-rt=
33)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
              | regressions
--------------------------+--------+---------------+----------+------------=
--------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.295-cip103-rt33/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.295-cip103-rt33
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      28d064262557c550e33da563b323e56c214e60fd

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
              | regressions
--------------------------+--------+---------------+----------+------------=
--------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65328e055fcdd631d0efcf21

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pt=
y-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pt=
y-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65328e055fcdd631d0efcf=
22
        failing since 212 days (last pass: v4.19.269-cip88-rt28, first fail=
: v4.19.277-cip94-rt29) =

 =20

