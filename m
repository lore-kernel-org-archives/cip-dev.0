Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BA6C25B08
	for <webhook@archiver.kernel.org>; Tue, 23 Aug 2022 04:00:09 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web10.28124.1661227198989633061
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 Aug 2022 20:59:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=N7MqpznA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f175.google.com with SMTP id 202so11194413pgc.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 Aug 2022 20:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=O7k15z/Pr57xma4t8aWzcSXTIn6BhLTne5+eVxaVxf0=;
        b=N7MqpznAsJ4hixT1v/+0AWL4pzGnro1DdnrncVn8W+/XgVvd/BuIoB7uWuk83ZjE0G
         RWu8gPA44nUhyrvSoT1dvrnvJv4ZV/KYCHGkJ/1wOikeGlkVcVXsQbaprOZGVDdmKPFD
         7bKWX0okdGnndvceQbyC8WF/v/t9RtfY5GCBgcts89y7MDsHTrlzRmiLTVoTbi6BF3wZ
         //PYDWpGCKxnUXcLImFe1sSUpiEE0yGc75lp/9QTyEfgoUjDcshYGlGQx/Me1VWxhVIX
         tlcBaNGtYKNLHljgSE8VhNqa6QiFgri3v1dkyIrATc7CB7aJDCiyjrqUDOiON6s6ScoR
         xOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=O7k15z/Pr57xma4t8aWzcSXTIn6BhLTne5+eVxaVxf0=;
        b=FRQzrv/nN6qR5du/LlkN/KLZG13qiyqIAEqKej1pPzwgV4OfJ7/DQquTeQCAUqSEoY
         pF3Cv5sKKJDR11R2jFFGBjvaWC0SU054BkFllIvIjmXXcvKbqPO0wtbUYHD+5ZZojVX2
         giaxAzFAT6DoVjI/d1bSufSdxAJOpcXLziPHoqox0T3O7oRdPm/xy4xmlf72eWDsRVMS
         Ze2stfiZEfjq+ydGdgBn99LqAU74P86XIWAdv2b8SAGKmXm92oHh7UEysj3x2tlAnJFr
         EZrLdn25LT25qwFhs5vJHjvw9WrMstXPnsfiF0DBg8jKE4F5QnMdiVOHRUrTY7kaLH9v
         /aMg==
X-Gm-Message-State: ACgBeo21qBbnEonXUe3iUJ9PiD8sD2/EEoYl0QcqF5PBf0pd5CUlFVBc
	sTvzOFtCL1JwIIWY+/8oeO3XBIj1Dlm2GJO+
X-Google-Smtp-Source: 
 AA6agR5HEYApcRyWOb6+6xqFj72BMZjYqC6s9+7DpKFke/ErCfmopBX8BCy337DtaqOelzrnskMt/A==
X-Received: by 2002:a05:6a00:a19:b0:535:49ee:da43 with SMTP id
 p25-20020a056a000a1900b0053549eeda43mr23539844pfh.53.1661227198220;
        Mon, 22 Aug 2022 20:59:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 b3-20020a1709027e0300b0016d72804664sm4115018plm.205.2022.08.22.20.59.57
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 20:59:57 -0700 (PDT)
Message-ID: <630450bd.170a0220.a36c6.7e68@mx.google.com>
Date: Mon, 22 Aug 2022 20:59:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.136-cip14-542-g97767707d3d0
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 6 runs,
 1 regressions (v5.10.136-cip14-542-g97767707d3d0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Aug 2022 04:00:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9304

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 6 runs, 1 reg=
ressions (v5.10.136-cip14-542-g97767707d3d0)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.136-cip14-542-g97767707d3d0/plan/kselftes=
t-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.136-cip14-542-g97767707d3d0
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      97767707d3d0aa36cbf6620b216d0d19b9314417 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6304407c07ac16fd7d355649

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.136-cip14-542-g97767707d3d0/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.136-cip14-542-g97767707d3d0/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220812.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6304407c07ac=
16fd7d35564a
        new failure (last pass: v5.10.131-cip13-431-g420b8f43ddc46) =

 =20

