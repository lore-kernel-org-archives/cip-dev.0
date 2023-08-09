Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC239C001B0
	for <webhook@archiver.kernel.org>; Wed,  9 Aug 2023 06:10:34 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web10.82524.1691561424769657918
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 08 Aug 2023 23:10:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=sH5ag+j3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-563dc551518so3815802a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 08 Aug 2023 23:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691561423; x=1692166223;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ipGD6EYmm/9yqoknMSueO/q4dNEQOaccOCXzWK7OQb8=;
        b=sH5ag+j375fKmgZahWXWGAtptuIiOjwT+aCFQMSbl95DkUo1QpqK4ynOuzTKduB62E
         HcQPDWzKhiktBK69AFN8XwlgUCPKol/8yj0EIYafVXDS3HDPh2aRNDWQVLVVfaBS7mBO
         3bk/pUoFKCOUy7xgSuNZp8wiMTKtWKw5yz5L98aE3E9B3NqDWzMr0oFps8r7XDACd1fO
         bObQ1GOA4BO5IH2D6cOseExj1YMpB9erhv8EFAZF6ObWIHYCoiNozOenH7Q7ivkOZk5X
         Kh9vt6g4qgss/H7HfiZ61t1k3lzLUYeOgMyG1PHjAUn5p3mhZFWy6fpvVWU9/sOKRMGg
         QTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691561423; x=1692166223;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipGD6EYmm/9yqoknMSueO/q4dNEQOaccOCXzWK7OQb8=;
        b=IoVLEl9xctKwxCDjinBphzJi9EU5I71UnyLdVZGwIugIH9QAjQ/infacfq0G7LKsbd
         mlubU4Au4ZfCsRuEtmt/GDagyk7hP/DPYJ25i4kzHwKGX471kK/CUIbRNS1+PYuYlv5g
         7DKn1bJOG3C4M5HNHcYo6BnlCGivbNvt1rDzneAtym5yE9/ATnoDtKg87WziBEEEswrQ
         ECHWKJo4K9ih+UfwK4XJzUiS8lYV+qEYde6JRticBOvn0biW3CBARrcGbt6BsPtM1ej+
         YOkh5XhzC9qdGEnUl4EfbSwxu35nvf/v/XOmrMgF0ZOQcOp8lnHK+OQ7Isn4U4+kG9pV
         uiRQ==
X-Gm-Message-State: AOJu0Yz366e+zYhGdMM6jYl5e0YOr4OprsqFFXHBKPTT1FDd72HTqjpQ
	TB1q2ZvVgeEZYen7sKnwUMYN2I8y9KT4hqMJOaYerg==
X-Google-Smtp-Source: AGHT+IFFImFnqumWB16McEZOTa2h737A1RukOtaewS3dtk9AN4hQr4IdO1wok+uw93Ki9a0orh2zPw==
X-Received: by 2002:a17:90b:2281:b0:269:621e:a673 with SMTP id kx1-20020a17090b228100b00269621ea673mr1200178pjb.1.1691561423631;
        Tue, 08 Aug 2023 23:10:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m15-20020a17090a668f00b00262d079720bsm570117pjj.29.2023.08.08.23.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 23:10:22 -0700 (PDT)
Message-ID: <64d32dce.170a0220.dbb57.0f20@mx.google.com>
Date: Tue, 08 Aug 2023 23:10:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-13-g260094841fe1a
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip smc: 3 runs,
 2 regressions (v5.10.186-cip37-13-g260094841fe1a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Aug 2023 06:10:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12582

cip/linux-5.10.y-cip smc: 3 runs, 2 regressions (v5.10.186-cip37-13-g260094=
841fe1a)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.186-cip37-13-g260094841fe1a/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.186-cip37-13-g260094841fe1a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      260094841fe1a0a9e5ab7b9ae32450e8e4e0a4f4 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64d31ba0ff1420cc7d35b20c

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/64d31ba0ff1420cc7d=
35b218
        failing since 400 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-08-09T04:52:31.107163  <8>[   17.559795] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/64d31ba0ff1420cc7d=
35b219
        failing since 400 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-08-09T04:52:31.093499  <8>[   17.546165] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

