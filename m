Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30094C19F29
	for <webhook@archiver.kernel.org>; Tue,  2 Aug 2022 21:00:49 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web08.882.1659474041238567261
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 02 Aug 2022 14:00:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=bXncRJyc;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id x10so13847362plb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 02 Aug 2022 14:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=27f347nfu3j46QUiZihX3sDPXU+LvTU80Vu2BaPyOXA=;
        b=bXncRJyc9lXQCs9Wy7hBh8N1XMYNDPg8Yv6/gBHK1oEKTKQqe43WZChO+2ReMx75vU
         ijjCl91rI6r9nPM4N03m/wlpBsllzS9goDs69gIngZp31lNFM5KkLOZ4gYRkH9W61dBE
         +pw1o82Of31ui6c3IZgz2C/v7j2gIfsgDBLBf2fhN6D1/54v9mKOF2LdjKBfcfZ6H11S
         W4sLvz0oBibRJk4jtPaBnpQaBeaQKPJsF5BoybnjonzIr18r69o219w8w14omEEO5S0S
         jbGkm3lkYbcVpEDXKYr0npSTSURzjARDyCNDLadApTMUnvDxr1c45cYBRxCpI1DXWNA4
         4UdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=27f347nfu3j46QUiZihX3sDPXU+LvTU80Vu2BaPyOXA=;
        b=q/qYkjfpWeP6XypK2r7k7uOJBsOeVm63ViBOImiAfZpQzYERwIzjIHysnYLSjDA+ZK
         F5B3RNDzAkELgGPtztYGPVT1Sfrx9ETrQlIgoUe+atGbEsZQ1xGmbDb9dlu5DYMOKhbq
         knPZ4u2emxrYdgZxfSa7Vw9QEfdRLku2YosGTtflV1/faMxv+Izr5eBffJF/crDKhTNp
         bI+1GjEBPwF0LOQ4aqMX6M36r+ttZRRO/hHT+wC6VR2ImChuT47h/uXzjm8y2jOlzuE/
         2TnzeTmIJ52zuYiFXYoQUHfsj6ZHNujFNb/3jlm2TljLPE2+1bl+5VgB91sdSq2YLARU
         ZwkA==
X-Gm-Message-State: ACgBeo1ujdgDWJ/UZ5POrCvDPYSsEzipYHu2wok+t7R6+McDAWYRUKEw
	QIDk16+00B+4dEun6Pw05vlpx12wAHbo8MYwtAs=
X-Google-Smtp-Source: 
 AA6agR5lY10HBRfBu3oz815qJMMZmJlsH52/1/EMA+YFWBvPqmTfZ1CDzDp6UtgwcWOaid2s+Tajvg==
X-Received: by 2002:a17:902:b78b:b0:16e:e5b1:d1bc with SMTP id
 e11-20020a170902b78b00b0016ee5b1d1bcmr12513235pls.118.1659474040453;
        Tue, 02 Aug 2022 14:00:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 q19-20020aa79613000000b0052d92ccaad9sm4495568pfg.131.2022.08.02.14.00.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 14:00:39 -0700 (PDT)
Message-ID: <62e99077.a70a0220.f005a.8299@mx.google.com>
Date: Tue, 02 Aug 2022 14:00:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13
Subject: cip-gitlab/ci/pavel/linux-test smc: 7 runs,
 1 regressions (v5.10.131-cip13)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Aug 2022 21:00:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9033

cip-gitlab/ci/pavel/linux-test smc: 7 runs, 1 regressions (v5.10.131-cip13)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.131-cip13/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.131-cip13
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e217bcd84090afd29c7a9ab120fb3c8ff8844478 =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e97f3e56dc7bd47fdaf078

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/smc-qe=
mu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/smc-qe=
mu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62e97f3e56dc7bd47fdaf079
        failing since 83 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =20

