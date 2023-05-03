Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82184C77B75
	for <webhook@archiver.kernel.org>; Wed,  3 May 2023 15:01:20 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web11.21839.1683126073531348172
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 May 2023 08:01:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=NHqfVN9+;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-642f5394651so2369063b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 03 May 2023 08:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683126072; x=1685718072;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u4TmjgOMGjzIczDjlzO8caqA2ZELx4mCbDJa7F3WNAc=;
        b=NHqfVN9+c24i6wLlp9TaSK2jzyzScy+nUg9Bc/mXkP08M/tlSwqJyD80l8VvocDUOB
         bKW01CgTmZ2gxAgKNU4NxQvCTtCeNvZmdA7XP75duToagWt+i4KuVPejp9jSwXT9L6Fd
         XiQnpRfRyr/rSL1XCdNZsKvZUTDxl2h2JeD9UpGteeVAnotc1e4ITZE5B92gEnqOkIr+
         +OgsRXQ4E4a1Z27vcS7HurG0EZWF52WkSh25yhKmrh8PSCz9I4Ts90JHA/2IPMNl96II
         fRqTbnudPmrw2i+36Ng23sJNYKstiMMhsoeO5bOPzdZON2rgRYByasux7E5MXxiAP6e+
         SlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683126072; x=1685718072;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u4TmjgOMGjzIczDjlzO8caqA2ZELx4mCbDJa7F3WNAc=;
        b=jkgohTyvEXpw57Homua+s7Mp18iBCaUW+DnIT0pLghzSxRXv5l82U+zR09QnrC5J9G
         rd8NOU6zjTXysDaMhke1o5Jea6zM/axLy0GWdovGvkzEKAfXhNj16Tmohsz20/D1OyDv
         wqPqKba3XOcBtlWVhei2I9LAs0wvn+w7fXSpTU+dCsb9Ep7/rYCgrvPMd62IcQbPF202
         0FSP7MOBwbSl5P80nCiPMXAJt7xQFPx7KWZ29axMNEWKU/IzXdMXH42vA2UgKlGp/K/5
         9QyQjfc+quBv0x9rxx7Nr9M5MDWJZOqt0agROj/eywUspSB+jEcB+yNs7KDOK3SPqDPC
         3uPg==
X-Gm-Message-State: AC+VfDzP1RxF8CGZMen53Kg8XbYahUo2QlMNqRcIJdfHWjacmiIPqim0
	rzWh8hvF/9Cvckt0HW8kU5uMniR0djnyuh3JPcmxbA==
X-Google-Smtp-Source: ACHHUZ7+bwoX70YQfA0IPIfHkZCdskg/BaGLekTuU1FVlvDSJsQEwpGGpj9OuchfLBhqlTaV+BNetw==
X-Received: by 2002:a05:6a00:ac6:b0:63b:2320:a39f with SMTP id c6-20020a056a000ac600b0063b2320a39fmr31515872pfl.19.1683126072652;
        Wed, 03 May 2023 08:01:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t12-20020a63dd0c000000b00513973a7014sm19944786pgg.12.2023.05.03.08.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 08:01:11 -0700 (PDT)
Message-ID: <64527737.630a0220.96528.87b6@mx.google.com>
Date: Wed, 03 May 2023 08:01:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-1187-g8497d3390dc2
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st kselftest-futex: 4 runs,
 1 regressions (v4.4-st20-1187-g8497d3390dc2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 May 2023 15:01:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11401

cip/linux-4.4.y-st kselftest-futex: 4 runs, 1 regressions (v4.4-st20-1187-g=
8497d3390dc2)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st/kernel/=
v4.4-st20-1187-g8497d3390dc2/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-4.4.y-st
  Describe: v4.4-st20-1187-g8497d3390dc2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8497d3390dc25bbe1606a8188178942016d00a67 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64526a271a734962672e85ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
187-g8497d3390dc2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/kselftest-futex-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
187-g8497d3390dc2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/kselftest-futex-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230421.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/64526a271a7349=
62672e85ed
        new failure (last pass: v4.4-st20-1098-g8d34bf42efd9b) =

 =20

