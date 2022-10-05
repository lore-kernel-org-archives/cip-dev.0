Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3A3C4332F
	for <webhook@archiver.kernel.org>; Wed,  5 Oct 2022 13:19:15 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.23380.1664975951098778334
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 05 Oct 2022 06:19:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=MhN2MK+j;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id n7so15383841plp.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 05 Oct 2022 06:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=vI8kkzT0ICrFJo3h0ELtivJ6RGthLJv6ZHDkxDFiU30=;
        b=MhN2MK+jTf8q3td5VlAWtyuI4jcbf3UflrRWgUXM89bB6UsaqMyDM6jPU2j4pJlB4p
         Rowyip7Yu1nVi8ruPff7EvYdZcyk9xrA65HkvY8+Qf95qv5S8m2BRL651hL6Yloxszfj
         AXMH1eyxaq8ybOn8WJ3RPYpk9rqpba1iDC9DW2t1j1YuLmds4FMUbAWSNceFOmq7i+he
         s22+COshs+nOoJaqnG5FjY/tLtl8xM6UNp00msS1Glfm+JzEKPVWTLoGv0HTy7+zHuLl
         KhLabZFikrMh3tRwlyky++sy6WJqcIYi0QE9WMxBSGfiSokVUGRwnXXPev4KQZjPuF8h
         EEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=vI8kkzT0ICrFJo3h0ELtivJ6RGthLJv6ZHDkxDFiU30=;
        b=6gwJRbzMB6cKFA6oVkrZrz7IZCaGQVDNt0wZU5U0mgH/ZFLEep1UTnAM1UJZOjE62s
         Rfiz06WMCydxyQjJeNxKvfBUbx/prV55HkRryRkn2p7hEAEMqk6YuQ/K3Dt0DGWWzulR
         X4ZOGG/+2fkmOeAprFbsaqS1ANQD4tfrdtUFtSc1Li/bzzuNn0xOr3ttwmUAqYq+WKOF
         3xudaHN3WNvhwIqSzNBJkxHcJDBbFBC9kRfate3EA+hGjiKNU7LBOV8c2JpeT4+5fzc7
         iMla3HxY8hQRsra6qPl3494vQOPKhZEbFbhWLZ724MzVz2Q4gLBdYIWwKLQ2D+ZYlBjz
         IO9Q==
X-Gm-Message-State: ACrzQf0B2bcMtmpkYZPyOcdFlgCpyFNqSHz8HeIUl7Bf6X9m5wN8e4dd
	e5ceHiWSmDlVlGzpblJ5x8WBMj0g/3PdC0BZsLY=
X-Google-Smtp-Source: 
 AMsMyM57Rm24oPUY2obgSN1E2z5YtGo1u7t0FFSF1CHGmD2PBbBnmA0ts7wy7ruO5h+4sMePZXGwhQ==
X-Received: by 2002:a17:902:c40b:b0:17e:9bde:ace2 with SMTP id
 k11-20020a170902c40b00b0017e9bdeace2mr17899017plk.91.1664975950418;
        Wed, 05 Oct 2022 06:19:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 30-20020a630f5e000000b00459a36795cbsm531093pgp.42.2022.10.05.06.19.09
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:19:10 -0700 (PDT)
Message-ID: <633d844e.630a0220.4e844.0e59@mx.google.com>
Date: Wed, 05 Oct 2022 06:19:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.145-cip17-192-gbe875d9d93504
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 6 runs,
 2 regressions (v5.10.145-cip17-192-gbe875d9d93504)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Oct 2022 13:19:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9649

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 6 runs, 2 regressions (v5.1=
0.145-cip17-192-gbe875d9d93504)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.145-cip17-192-gbe875d9d93504/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.145-cip17-192-gbe875d9d93504
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      be875d9d93504a4ac9c5dfc8d0bed7cc4197ab75 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/633d79f6402a6f582bcab611

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-192-gbe875d9d93504/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-192-gbe875d9d93504/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/633d79f6402a6f582b=
cab61d
        failing since 92 days (last pass: v5.10.121-cip9-287-ge9094c8446fc,=
 first fail: v5.10.125-cip10-119-g603acbe1aceb)

    2022-10-05T12:34:50.173815  <8>[   12.861229] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/633d79f6402a6f582b=
cab61e
        failing since 92 days (last pass: v5.10.121-cip9-287-ge9094c8446fc,=
 first fail: v5.10.125-cip10-119-g603acbe1aceb)

    2022-10-05T12:34:50.155885  <8>[   12.843110] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =20

