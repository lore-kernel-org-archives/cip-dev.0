Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEFEC4332F
	for <webhook@archiver.kernel.org>; Fri, 11 Nov 2022 04:57:11 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web09.2101.1668142630571615095
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 10 Nov 2022 20:57:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=YcUDWXCE;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.54, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f54.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so6785076pjs.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 10 Nov 2022 20:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WLWWESIQ2irSXSovcHtd3TypQGwXIC1C2eJSM3EhptE=;
        b=YcUDWXCEp2HhKYfiJ6pkpw5trEaMWnhHJGr2AtHLzQa9lZdKIWjg1CToTdXWHlVJrm
         YTzAxMA/tg+ITjFVtFI0RIJYJmDtoQf/Ko73FdvuTDyN5b6nxZGV+hCLmOdakEO5wmjF
         +CG9YV+syBdDv+8iKJJh2LI9VJCp7loPUb+0CRsPiowK0WHeLedUPvxSUIketRrc7sAv
         rWH7T1zWpYZ3S946Ds91rUo3x/kl/+TSqK7GF7wZ8cjM5wb71oDgvb5xeFQNR6gOo+JP
         FSMi173KBXY9bFlnbHMM0GcZ7MxJhac+uXJ+/sHXqxJL6LsRZ8p80oHLleqoBy03+ht4
         r2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLWWESIQ2irSXSovcHtd3TypQGwXIC1C2eJSM3EhptE=;
        b=krOQFE71qVC+BKoRffFuPflVZ9gm0t7qrQbAT1Q+XJTFkPF7qOVrX7u/BJH5k3eTWK
         dVJfL+AcRHASEPdvOJLDI1qZgJRHvsDleaTS8bvk4mSfdlnczuXZkcWgQzv6mH9Mxk6Z
         xlZWhW2M+j/9QDLFCXNwuSvfipCRt5tfbznGkh1QdPxw/n3NkYEft+4xW3am5WyjCQ+L
         xZvSmeWi5h58tc5RhcJttnieOHvdG4qVTZrrDOU0JYRwDobFZw0oewi5HsISgKzyKF8u
         BGVFlMJe17a4SZeAyjbroUKInNgPmyb5POzOwypFYG7vjekJL56m5rfYKMVeNNHK9ISJ
         Yang==
X-Gm-Message-State: ANoB5pmOkkt6+1YGtW0WdNWltWqo3wJAGeM/pwuDEepm7IcUIsZz2zv0
	ys2U0CThOe0KXd8FpwBsv9SN0qB2YUlK/iYnjeE=
X-Google-Smtp-Source: AA0mqf5PDiDP+C205O/VKY7c0uNeyAjRlyaWza46BS4Mw2Bc8RrOY/E8DZ1ewqWD3RKC38/tLz9tNQ==
X-Received: by 2002:a17:902:7205:b0:186:9cf4:e53b with SMTP id ba5-20020a170902720500b001869cf4e53bmr680347plb.50.1668142629417;
        Thu, 10 Nov 2022 20:57:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h2-20020aa79f42000000b0056c2a85c097sm562100pfr.20.2022.11.10.20.57.08
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 20:57:09 -0800 (PST)
Message-ID: <636dd625.a70a0220.cd3a2.122b@mx.google.com>
Date: Thu, 10 Nov 2022 20:57:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19-122-g149fbc7cd21d
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 3 runs,
 1 regressions (v5.10.153-cip19-122-g149fbc7cd21d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Nov 2022 04:57:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10016

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 3 runs, 1 regre=
ssions (v5.10.153-cip19-122-g149fbc7cd21d)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.153-cip19-122-g149fbc7cd21d/plan/kselftes=
t-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.153-cip19-122-g149fbc7cd21d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      149fbc7cd21d7e3a412f88c0e29d060f55e237f6 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/636dc6ad3ddc9ae6d1e7db4f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.153-cip19-122-g149fbc7cd21d/arm64/defconfig/gcc-10/lab-b=
aylibre/kselftest-futex-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.153-cip19-122-g149fbc7cd21d/arm64/defconfig/gcc-10/lab-b=
aylibre/kselftest-futex-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/636dc6ad3ddc9a=
e6d1e7db50
        failing since 98 days (last pass: v5.10.126-cip11-116-gef362fbbff52=
8, first fail: v5.10.131-cip13-431-g420b8f43ddc46) =

 =20

