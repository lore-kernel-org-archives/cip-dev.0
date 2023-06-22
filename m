Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6813DEB64D8
	for <webhook@archiver.kernel.org>; Thu, 22 Jun 2023 11:45:16 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web11.9106.1687434313948494376
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 22 Jun 2023 04:45:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=iIZim6jY;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-666fb8b1bc8so5247071b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 22 Jun 2023 04:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687434313; x=1690026313;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UBzMwWB8KaIutBYjXZgJLM9+uqxryQG3BQbZcj7Ka+Y=;
        b=iIZim6jYCxlr9/zSzK0KcicGfKwFmixqueo7iwPhWNUdJNHlOMsW953nE68JpxX9F5
         jE55phcOiDpR80Cu12M/mrZ1G38thA4z95xRgfikhk4BqPxoHo8UryZ6W8sP98T2CSLl
         5w/q67CkDczOuEYM2sg22/+o8JUlND1aVz4n5gKdIDyYzwbGCfdlZVeI2hyVlL78IZEL
         zyYeL5sNyYlO2yfascT61BBU+xJJtQjVloZX2gJ5nDTeXotVtaWj5Lp8uLNBQ4zTPZoa
         blYLKXq9JMgq0wFNV3kZByQ2dK/S1DJVLsEq8lKOOhxr5qp5IhvnUB/s1WJBqjl7tLPz
         F3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687434313; x=1690026313;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UBzMwWB8KaIutBYjXZgJLM9+uqxryQG3BQbZcj7Ka+Y=;
        b=denb+oEZl1MDtzg7+fWEqENaYqx726M4An/HXVrscrLaHphvoINCBSvf/XKQ/Rm2TD
         BSePlvUqQHjAzI81MbEi+riI7JTkod4gmryMhtjy8olpjUxtIGFW5viMayx/fdfjIAu7
         tyOlTj9bLQoeB4cq+omPv/hJO8jNIRjaJNWFsnxcwsSYnnTUMUgvjiJn/eD2a5nKvQx+
         m6Pe+iz9laDV7mqlE+P4Ts2ixL45zV3ZUiKsW//5tx/PgumoM64FrhRMvcRXsvp6wii7
         tnd5KBnBkE7Zp4gaysDfQFxoVR0cVgVbdJ1IyrDgRbFuwytCn+C8MG2rNxHBuyykNMhI
         +Rtg==
X-Gm-Message-State: AC+VfDyxjQVTOUA/0oB9SJOi/oJuoYI+/jDde6h3y6dRCXT17HkC/XPV
	NhMWMLUUfTFGejkaiPmCcfm+y+CIXLfmgf+XbCgL5A==
X-Google-Smtp-Source: ACHHUZ7JhQ1zLmCMeBt0qqQ1dNbDryMSsAVSRIovvVSmg60VNHS8GZXEjq1qByZJZHxLCfKIksF9DQ==
X-Received: by 2002:a05:6a20:429f:b0:122:24ed:f77e with SMTP id o31-20020a056a20429f00b0012224edf77emr11847682pzj.33.1687434312981;
        Thu, 22 Jun 2023 04:45:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e15-20020a17090301cf00b001993a1fce7bsm5176712plh.196.2023.06.22.04.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 04:45:12 -0700 (PDT)
Message-ID: <64943448.170a0220.ba390.b881@mx.google.com>
Date: Thu, 22 Jun 2023 04:45:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.184-cip36-rt14
Subject: cip/linux-5.10.y-cip-rt ltp-mm: 9 runs,
 3 regressions (v5.10.184-cip36-rt14)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jun 2023 11:45:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12123

cip/linux-5.10.y-cip-rt ltp-mm: 9 runs, 3 regressions (v5.10.184-cip36-rt14)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.184-cip36-rt14/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.184-cip36-rt14
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1b650b4c826dc15118c34e6c891e42858f3367e0

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  97c2fdb137a68e1eefed07c900db1a862edcdbf8 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/649429b6fed1fe21dc306155

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-=
asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-=
asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/649429b6fed1fe21dc306156
        new failure (last pass: v5.10.179-cip32-rt13) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64942b8073aedbeaa7306148

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/64942b8073aedbeaa7306149
        failing since 34 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v5.10.179-cip32-rt13) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64942a4807802f792b306151

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/64942a4807802f792b306152
        failing since 34 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v5.10.179-cip32-rt13) =

 =20

