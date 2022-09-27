Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278D1C6FA90
	for <webhook@archiver.kernel.org>; Tue, 27 Sep 2022 09:39:43 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web08.8735.1664271576236517851
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 27 Sep 2022 02:39:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=xW7aBqxK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id c198so9164161pfc.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 27 Sep 2022 02:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=XFNIQscYNuiJpbXPVKjzxDmQ6EQQn5U7wm17u8/3i04=;
        b=xW7aBqxKw0nzg4vkagYMFPyTP7FIPQ0jEWrgK6pQMXO1IrP4/8sdztF6UN1ucAuwSH
         MTZ1tJ5uMqQT7doiqu9257cGxw4HwN7ySUK5F5fZj5rpfx6Re0iXN/t4tEn0sE6lNa8w
         0y0XzvHo0bde4VgRp2Gq+xr+IHSabBn9M3GLs0gv5Zd97SXk8S747zchrZwaOSzrrsn6
         NkKE/kicYJQ+LvdpzqshmG4/2/6WZ3HFXF8SeCYJldWqY0tFjF2p3qghVgloVdzk/Ire
         c4OxzkU4ANyrhSCk/LU+fjdoBLZLrgcnGwoXRjU3BPbQf7KGJys4mT5se9rqQGPLZjlY
         WYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=XFNIQscYNuiJpbXPVKjzxDmQ6EQQn5U7wm17u8/3i04=;
        b=Y9CspG7R5ffm/U+hQ6UhDRGeri4ZeLInGmVF3IdEjdiNAV3YfMjXzn8ggYojp04xLp
         2NaLMFppLOo8u/WDEdXvDSh24gCioAbhBiWhw3jM2hna6jBjwAEvgbiwGMlqoc6QSP79
         c9k4WnKEp99tY2DtpPJXfWrgToHDb2SCkrb0/CP9p3Sq9/0O5koMG4h7sou6lHBVQj5S
         3bkYk9nU9z9NV/Rgh4rRujTBl9YS7AbRAvUN5DJESPRGE0zRsgctpDgKXbdQbbXWVWF9
         KYZN43aerte7pQzARGrkZPJ6HUFm8eluG8vcRB/Jy15G46JlUuEzwZbTUwLdG74rA+2p
         Prnw==
X-Gm-Message-State: ACrzQf1dIIwh0SzoKmlb094IfDhFgL8RplMroI8TufLPm7JnlFOnIY7p
	xQNa/kFnmUkD22VFIQYFZUKikPgQXTrA1NI/
X-Google-Smtp-Source: 
 AMsMyM4aOw5a7SoAL0OjBqNV2/6FDzrg6snH51TbTgpD6HoB8KiG6hnO6dw8QhDq3gPywDA8rqaKNw==
X-Received: by 2002:a05:6a00:2181:b0:51b:560b:dd30 with SMTP id
 h1-20020a056a00218100b0051b560bdd30mr28553562pfi.44.1664271575606;
        Tue, 27 Sep 2022 02:39:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 y9-20020aa793c9000000b0053e0d6f353esm1229530pff.27.2022.09.27.02.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 02:39:35 -0700 (PDT)
Message-ID: <6332c4d7.a70a0220.7f607.1f2e@mx.google.com>
Date: Tue, 27 Sep 2022 02:39:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-cip17
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip ltp-mm: 6 runs, 2 regressions (v5.10.145-cip17)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Sep 2022 09:39:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9554

cip/linux-5.10.y-cip ltp-mm: 6 runs, 2 regressions (v5.10.145-cip17)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.145-cip17/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.145-cip17
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      93a53e86925ce8c2e0608e173e2c7b952ee61cdd

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  48cfd7a9977e6268b4aa2600608cebad7e0e42b8 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6332b87e658016287fec4eb2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6332b87e658016287fec4eb3
        failing since 258 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6332bf0ce9a99de33eec4ec7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6332bf0ce9a99de33eec4ec8
        failing since 258 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

