Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6CDC19F2B
	for <webhook@archiver.kernel.org>; Tue,  2 Aug 2022 21:00:49 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web12.891.1659474039976244121
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 02 Aug 2022 14:00:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=S21525/6;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id t2so14561675ply.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 02 Aug 2022 14:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=GObBSPhNIDJWm+rLWryI3H7v84csnvwsmBIuYGzqL/4=;
        b=S21525/642PSTm1ds7Sk5dSB7QbHY/IliEAfO1DKzqzjdLtsNa5gPdlBYCHhRB4KfJ
         kIyyCtMa3FLQh9OfWoqneXWM6asATzeDutPXp2CWDKHX4ZWpVSTgAVBAY5Xy1YPUahBr
         P71neRZ/ZORRru7JnNJucI0Z4XiI7yrHxw47zRs4kUEuGHDpzcCBlQm49UHFE94mDkcY
         0yU8PygyTPNtQWMmyIx+1RDBa4vd6+E37Vv7Fbdh6h0BwxeNZpnw7AcXpvYI6vTWmDss
         8dlbnpKVPDcykZcMW8V4qW51vY2Ee5YW4HIz3nLFSqXVyx5J9OG1Mj67Vzkg4FZmLFgF
         IDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=GObBSPhNIDJWm+rLWryI3H7v84csnvwsmBIuYGzqL/4=;
        b=4Yb81IEGuCq8nNe0lisuFAhmV46qPX74QnAJD97A+5TGIr/NyMOX3Q+vfs6+abxqUA
         EiNaQOx7KC1KkkV1yZZZ9YW1hjI4CLQIfGaWJcE+i169agNukl9C8ya4PaFIYo8wwaAS
         rMszM06SyRBaHpauA6y5c7LunBOpQTA5tpOPvrBhX7k31hUDmHeJZTZ87utoV7Tof5xe
         vfRxwU2cIrCEqofwWrQaKcsROqipCtNQeBdz8o7faUUr1oC3Hb5YaadY+lsX2Sd6uf+t
         kMvNls9h3gJA5mqnvv8/wJx9Vf/UU58aAdsXQNtowseFb3UJ3On0ukE0ag+qRsXEB34I
         y0JA==
X-Gm-Message-State: ACgBeo1OrVPPjofLPocROozs1N+fV0yJ9AcY6Al80YcC99USO/bJZT6l
	oEMsl/fJVZZVcpt+VNyO9tTOnOC7uG9NJ0zrgvM=
X-Google-Smtp-Source: 
 AA6agR49FXB+/FFl/CqkXPW6ceEZYe0zYU1EtWdL3p/OuRB4Qe2dOcSHbuMlIRlpPL+22MrluMkDSw==
X-Received: by 2002:a17:902:c945:b0:16d:c318:4480 with SMTP id
 i5-20020a170902c94500b0016dc3184480mr23501881pla.147.1659474039153;
        Tue, 02 Aug 2022 14:00:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 p2-20020a625b02000000b0052d63fb109asm5519961pfb.20.2022.08.02.14.00.38
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 14:00:38 -0700 (PDT)
Message-ID: <62e99076.620a0220.f0c6d.8bd4@mx.google.com>
Date: Tue, 02 Aug 2022 14:00:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 7 runs,
 1 regressions (v5.10.131-cip13)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Aug 2022 21:00:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9031

cip-gitlab/ci/pavel/linux-test ltp-ipc: 7 runs, 1 regressions (v5.10.131-ci=
p13)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.131-cip13/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.131-cip13
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e217bcd84090afd29c7a9ab120fb3c8ff8844478

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  bda92ad659a52d38ac810099f69adff626b064c6 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e97d1ce4c9718ca0daf056

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/ltp-ipc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/ltp-ipc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62e97d1ce4c9718ca0daf0=
57
        failing since 7 days (last pass: v5.10.129-cip12-36-g21d9d56f4de5a,=
 first fail: v4.4-st5-586-geb97410e0086c) =

 =20

