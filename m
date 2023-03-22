Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6CAC77B6C
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 13:57:23 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web11.43293.1679493434759894540
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 06:57:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ffjGdB2B;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id u38so6352784pfg.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679493434;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Hn+xgD8O5lDrYmirKZtp+TvcagpPIIT/nGB159YGnvQ=;
        b=ffjGdB2BF14+Mfkpxb4nJGjGtrv2nuu+tATMijKChkNT0/zNHCUE2tMbZAUO588mhc
         Q46jTYL3NfSQicIzrPsHnVuShbkg3wJ8+QXo62EPs8nTWE31JVsOzS1RajYMK3PRPmhz
         WyMmOmRgThluewUPeu2AD9VVv6g3crLNF8Z8Cwv+7it57oz+OntH3NMjw8ZEnopUB7Dn
         j7YTfDwFUTNLM1nlbl5LHxEeTFxciaJEtvhfpupmnIj67kmHmIS0zjdALx/tY41RsAih
         3r64y7GoM4xVyAlGc6QAkhWi+DeimnI0xDTsyTEUajC66gLX7dy+DD2EUpDtUDMVDh6z
         yp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679493434;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hn+xgD8O5lDrYmirKZtp+TvcagpPIIT/nGB159YGnvQ=;
        b=xCw+/7czM92gWYLB0v6tup/IrPzYjCVQDaME/8m4fJ5X1Vznybuxd2Ttj5d+D7rICe
         C+x7AfiX5vZdEGujD/IWRMkfHj4IUkPjdl4XAGhPNcS571JIhqUhIjjeAfYx2KeVoANH
         00MQAy6KvgsRGlbNcWsQgLcVNibaytLCUtfATLTv1Za9dwAMSnZJBxjUSMmvYUcFCRms
         PSc+LjbGGAEuG2xtIEZVlRj1RvX1eGorBcVnrh8uBr2pjssF0u3Gpl1RNlHVTHBD+qVZ
         JFvXnQU4AaR+H/QLX1Re8/miqPLTwcw301be5s1O894VHe1Xy9OYty+lTOsiRIeytmmw
         0cUg==
X-Gm-Message-State: AO0yUKX2ncYq7Qixe+VL7ZC95P5dTCJEqxHOtSnb7r5xoRyUBHuZ6N4h
	wJK/HT0Er7VxVhCh6JFCtDoMUNIM6EGV+qcC+rGBOw==
X-Google-Smtp-Source: AK7set83RTK04vIJir0tfWRmkeiqJT3IARvrKOEOwrjGN/6gjKLv1Dn90zOXjMQgSFfOwSjTbBzjOw==
X-Received: by 2002:a62:1d54:0:b0:625:efa4:4c01 with SMTP id d81-20020a621d54000000b00625efa44c01mr2951973pfd.3.1679493434020;
        Wed, 22 Mar 2023 06:57:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u20-20020aa78394000000b00608dae58695sm10015103pfm.209.2023.03.22.06.57.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 06:57:13 -0700 (PDT)
Message-ID: <641b0939.a70a0220.7292c.2517@mx.google.com>
Date: Wed, 22 Mar 2023 06:57:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.175-cip29-rt12
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 7 runs,
 3 regressions (v5.10.175-cip29-rt12)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 13:57:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11088

cip-gitlab/ci/pavel/linux-test ltp-mm: 7 runs, 3 regressions (v5.10.175-cip=
29-rt12)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.175-cip29-rt12/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.175-cip29-rt12
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0a6a8df2de5a8e8f024b47926cff286c6ec0e31f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  f3463a347c37b44bafdf4e882cfb932f6888905d =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641af983107dd8079c9c953f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/641af983107dd8079c9c9540
        failing since 25 days (last pass: v5.10.167-cip26-2-g28bb49f7179b, =
first fail: v5.10.168-cip27-456-g42a59c4e5329) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aff3b4d065faa599c956e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/641aff3b4d065faa599c956f
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641b003b6e42e89bca9c9505

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/641b003b6e42e89bca9c9506
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =20

