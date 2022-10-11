Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20147C433FE
	for <webhook@archiver.kernel.org>; Tue, 11 Oct 2022 11:25:10 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.6038.1665487505956758655
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 04:25:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=BJOcoOvZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id b2so12896626plc.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 04:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7CdDd4qvZIly+nsrAd9ZOyKkKU2bjKFUVBw2dG3YcAE=;
        b=BJOcoOvZlIpQaq3T/Z1sPpuGPF15l3+zVdqsGXDfn2nV2Vpp4ti+mm6PoSKfVN8+6V
         q4slJaJPZsScACcXQlUKSmiyfKzrDS1u74BdGyDOSXEoxGZdDmMF4ilU/NOeK6XOkAnZ
         w+Kuc7mYkAocCtGLRNKjTuDdHp1Imo1oLTMUqpQbDQ04+aJ5niBSVRQAjsO5q7vDBup5
         P/MidNWhTQ3irO3Yn6h9jLMAbICsaiwehWdcKBwNjNYREwCB0lOr1F4QQhM10oR40YJX
         gpSfkTiyho2UhDRFOng2v9PPYlhBbXn3H0B1nsdKomTgD9+AsiXQjC7pEfPARl9G1IXB
         izNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7CdDd4qvZIly+nsrAd9ZOyKkKU2bjKFUVBw2dG3YcAE=;
        b=cqRSCPbzA8+m/c1aHv9r73WuJfoBlMEQ01fX5WRlDIC7jAQ2+SqDe1UOpWyHuWF49w
         sxoWCDQ5MClyp2iJnxYxQW5cGsocupaXmTudKfGJj4amTzyHTAI8NLiKw2D+ECdlOyRF
         kIIE3aEQ4MTY99MecUNhkZvC17Csc2Vyku+dOrLwb3vV/tnZBp9Mlzynv7lMdY2LYLq4
         7IQcGlRL02pFhD6x+cou/uZAz+yZ5eMtYAPJWczD/x0S8TIP6mi32AT+a08b/pbzLG0b
         1UOsHY/aZWXN5iBM0wihyOfRVrpxP8JQ/ZGYolwMQFxZuZY+OcEI8T4AzpW2i2xiHZnM
         UrJA==
X-Gm-Message-State: ACrzQf31RAZlZXlh5XIyMUkK5Re/mnBxQpPDZhg7ChBNEEGHhN3eBguM
	vnVK+F7dW21uCC/2T/4CN/lNK7OMM7E5pw1G29w=
X-Google-Smtp-Source: 
 AMsMyM5pfkCrIH+/GBZBj890NZKcw3cRjy8zSFk5PbHw0mT4BfrYOMYLZp3bL4adzQm/uwwKHsRqKA==
X-Received: by 2002:a17:90b:2246:b0:205:97a5:520e with SMTP id
 hk6-20020a17090b224600b0020597a5520emr37873419pjb.244.1665487505300;
        Tue, 11 Oct 2022 04:25:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 x6-20020a170902ec8600b0017f95efe62esm8491521plg.13.2022.10.11.04.25.04
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 04:25:04 -0700 (PDT)
Message-ID: <63455290.170a0220.ca64f.e56b@mx.google.com>
Date: Tue, 11 Oct 2022 04:25:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.145-cip17-1-g92b5279a8e1f
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 7 runs,
 3 regressions (v5.10.145-cip17-1-g92b5279a8e1f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 11:25:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9716

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 7 runs, 3 regressions (v5.1=
0.145-cip17-1-g92b5279a8e1f)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =

qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.145-cip17-1-g92b5279a8e1f/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.145-cip17-1-g92b5279a8e1f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      92b5279a8e1f1dd8189276753604ca74c0f32a76 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63453e168f0ae82dd3cab60d

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-1-g92b5279a8e1f/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-1-g92b5279a8e1f/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/63453e168f0ae82dd3=
cab619
        failing since 98 days (last pass: v5.10.121-cip9-287-ge9094c8446fc,=
 first fail: v5.10.125-cip10-119-g603acbe1aceb)

    2022-10-11T09:57:31.407824  <8>[   12.279368] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/63453e168f0ae82dd3=
cab61a
        failing since 98 days (last pass: v5.10.121-cip9-287-ge9094c8446fc,=
 first fail: v5.10.125-cip10-119-g603acbe1aceb)

    2022-10-11T09:57:31.389560  <8>[   12.261297] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63453d40f78f4387b8cab627

  Results:     15 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-1-g92b5279a8e1f/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/smc-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-1-g92b5279a8e1f/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/smc-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/63453d40f78f4387b8=
cab629
        failing since 40 days (last pass: v5.10.136-cip14-542-g97767707d3d0=
, first fail: v5.10.138-cip15-90-gd4130d0ee3c7) =

 =20

