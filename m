Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F05DEB64D9
	for <webhook@archiver.kernel.org>; Thu, 15 Jun 2023 12:56:51 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web10.17416.1686833805051404022
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 15 Jun 2023 05:56:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=DuR6yT1r;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6667c54839bso1215093b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 15 Jun 2023 05:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686833804; x=1689425804;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qft4Uky6GwxC0S75J0JHRVe8uDJnZ+NjUoPvNnxUoHA=;
        b=DuR6yT1rKB6Craf72RtPOaNbyuYVi409MqEcKao3BK25KUf6541+o74eBYTI/HifmA
         humxokTJP+bHISYH2PKsUSZF/w9kdrGZ0U8xsnu/YC8pEjmZbel9WQD40qpViWS8AtGn
         eOHR2VRHog27gQgJHFRED/i35aOWnxhyQL84GNe4DR5olJXPgVrt90ke3SRKfLkSbtr6
         rn6KD24kn3C22mS+zB4qzPrf1y6XWK/b5WEi084+KdJkYtTenjd+5Q/xCLmna1ZbP1Yu
         8x/WNglxKO1w3Ya3SqD9OtsU0LTVM5apbdoFmKT9jcwN0BEm6dcbLh6j/nJxxh8gb1vl
         ar7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686833804; x=1689425804;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qft4Uky6GwxC0S75J0JHRVe8uDJnZ+NjUoPvNnxUoHA=;
        b=SZLSblvAw//e9IBE3OD9RvKhzsgEhPJtxJ2F0ClvdtdSLuz7VthJdKytLvsoyNrqZc
         dkqHkz7Fi2bk1FMz+mKwpAGJFx5f1WATfUq6IYrtBN/d8clEA79TeFDpierjUfhbD1eR
         SCc/AnTteZmYyO0ESkii4LZhSElCXiVucjj7BPzXG8ofABoMnFcG7gCPQzMvHm8BDyv1
         iBE6cr7Tb4rjjt0wkUq7eFlzswdnRNr+vS7UxnI4pWzYLTugqOTAaz9ObOJuHyB+6tip
         axv+faJVgDCGh9JhuRrlXMwBoJiegnoJc8NRCOG7hN1UrsMnyHKlKD3yXkE7p6YkHs/W
         UyGw==
X-Gm-Message-State: AC+VfDySH4mIptHgSDp2ME5gBaiVPHYctKdO4U2RNHihNy8fuAkzy4V/
	KsKLgiQke74n6bFtGMRpYxSjXFoHa1GMMFi82fKPLw==
X-Google-Smtp-Source: ACHHUZ6GjxsZeKcqRkC9kTey5RaLqBNk0QEgemZg8MrwGW6MjPsqc0ru9sSilGrkVBgkIR7teyHS2Q==
X-Received: by 2002:a05:6a20:4387:b0:11d:1f5a:d707 with SMTP id i7-20020a056a20438700b0011d1f5ad707mr4597974pzl.56.1686833804082;
        Thu, 15 Jun 2023 05:56:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b001b3df595582sm6378565plb.124.2023.06.15.05.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 05:56:41 -0700 (PDT)
Message-ID: <648b0a89.170a0220.fea79.d86d@mx.google.com>
Date: Thu, 15 Jun 2023 05:56:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.31-53-g486caac40d06
Subject: cip/linux-6.1.y-cip ltp-mm: 5 runs,
 1 regressions (v6.1.31-53-g486caac40d06)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jun 2023 12:56:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12063

cip/linux-6.1.y-cip ltp-mm: 5 runs, 1 regressions (v6.1.31-53-g486caac40d06)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.31-53-g486caac40d06/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.31-53-g486caac40d06
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      486caac40d06a2c987e5514b550d341cf6791b17

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  97c2fdb137a68e1eefed07c900db1a862edcdbf8 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648afd32db7ce70c89306259

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-53=
-g486caac40d06/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-53=
-g486caac40d06/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/648afd32db7ce70c8930625a
        new failure (last pass: v6.1.31-46-g4cc1cc26e90f) =

 =20

