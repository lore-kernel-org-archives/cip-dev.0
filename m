Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7AAC3F6B0
	for <webhook@archiver.kernel.org>; Thu, 11 Aug 2022 15:40:40 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web12.7928.1660232438999995054
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 11 Aug 2022 08:40:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=khH8xM6M;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id
 d65-20020a17090a6f4700b001f303a97b14so5461527pjk.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 11 Aug 2022 08:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=V02Ka0lp1ZyhBjmZ/DFKYZtejuSEee7ObO1Aeh4ZRFc=;
        b=khH8xM6MirHw9cRs4v6ui0i88D+VpAZ88C5o8bkI7JpgFqs5ZVT3j3hG6VMZiJuzGd
         A4Dja0oOVf8Hb12AouD9l/3rJhDBEZai0LqpzPEmdw+PoC/J8sp/qSvXQzifxTfNUVnY
         nutJhMNDSQbwucZYoI0fwKIifQBy9i2WXDpGkxeyRkoaJ7kCPWH48ccKc3soDXmC4XTW
         YS0GiVuOQcdK78faY9m4xZV6CqXba7JOAQdI7eL5nmGqe1mnfdeUyNwsXunLR1gIfF9p
         g+IlTsIgmdDa4LwuggaaZRAqhCBP+BkFpl9JCYIXvv1LTwGmNDvcQZs8NszSJeH4FhvG
         KYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=V02Ka0lp1ZyhBjmZ/DFKYZtejuSEee7ObO1Aeh4ZRFc=;
        b=t7jgBa9J9LWig1/0QZRuLkjHzt/ECIlmYQD7Bp0nmwWY7nZJ9aoeKm8LTi+gQv9CJ+
         PAAOYvX1k1qh7Q/7RTtG/kMmGQw7/Yu1L/KiMxchfJAxKBrEqHz8FGZL1UNZQswktRym
         Jg7eMAKxeG1u/ojXQbEJ5dkaxhbL3M4QWDj/CWrlwS/DIxpn6gy25M/77pYDtLu12gJY
         iNVli7wdFZfljf9hNlrGol+/9hA+NSl4XlHyN7QQQnf5CDDTf2x1Ila1SDXs+9YgXyhY
         ww0fxqqD4dtPy+6357TZ1cWSd4e/WvsHMiSLYa5emfbi5Hoe6Evhdf1/SDslX2YWZKgq
         fqiw==
X-Gm-Message-State: ACgBeo29O8QnNs6puqi6YkLolVmJa6AS4+ypKZxrbJ10QLC6l4xD+EHK
	vwcoVqjDN1hh93z11c6/iNmAfvV3Qp22492Sgzs=
X-Google-Smtp-Source: 
 AA6agR4POPApV+YLZSaW7eFXgq4erTAL+lhlMS/e742TgMCu4UIvL9ttQLXIy9RsjNAlGPNPh/HlLw==
X-Received: by 2002:a17:902:ef47:b0:16c:60df:3a7c with SMTP id
 e7-20020a170902ef4700b0016c60df3a7cmr32690594plx.9.1660232436682;
        Thu, 11 Aug 2022 08:40:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 u132-20020a62798a000000b0052d1341a2c6sm2280915pfc.177.2022.08.11.08.40.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 08:40:36 -0700 (PDT)
Message-ID: <62f522f4.620a0220.dc374.450b@mx.google.com>
Date: Thu, 11 Aug 2022 08:40:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-493-ge129308279043
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 9 runs,
 1 regressions (v5.10.131-cip13-493-ge129308279043)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Aug 2022 15:40:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9164

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 9 runs, 1 regre=
ssions (v5.10.131-cip13-493-ge129308279043)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.131-cip13-493-ge129308279043/plan/kselfte=
st-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.131-cip13-493-ge129308279043
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e12930827904334316a5d7407de3f9a7126f9892 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/62f5109fd76ebc7df2daf06f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-493-ge129308279043/arm64/defconfig/gcc-10/lab-=
baylibre/kselftest-futex-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-493-ge129308279043/arm64/defconfig/gcc-10/lab-=
baylibre/kselftest-futex-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220805.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62f5109fd76ebc=
7df2daf070
        failing since 7 days (last pass: v5.10.126-cip11-116-gef362fbbff528=
, first fail: v5.10.131-cip13-431-g420b8f43ddc46) =

 =20

