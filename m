Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD654C7EE29
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 08:06:42 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web10.45066.1685347599628003846
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 29 May 2023 01:06:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=kJ36RwzY;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-64d1e96c082so2235209b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 29 May 2023 01:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685347599; x=1687939599;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tVndhOcyb7xzUdmvflsV+w4+n74ai213pWEBINK5RlE=;
        b=kJ36RwzYZKIHrjrMeajI9v5oy92XAaG4W/SjCrcJhnGj+ZYNCY565P4sRQsC8L+IWL
         9CeTV5PZ2PrtJ4D5tQRUZ+8qDDjBs/rf8nVDYrExJr+w3J78zhRKbDsXUGuVthRAMGU3
         1ajiMciGDqKH4tF/Crnf+Qw1G/iEONt6ni8DDVFwMAcNy36UEAXRZ6JZ9RHTi41yTYqg
         QGrq4fkEgOLoFmAZXrM+m4CEMFN4jNePvxx20jM3SygC36DMVtrOTnSo9pzbWylmkCVf
         eyhTH+Rv6ulQtsoUpOlMXIn2hNaJVDQMT1BYxHwPZu/X5M+SYbM1t83yN4JPppA5h+q1
         hNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685347599; x=1687939599;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVndhOcyb7xzUdmvflsV+w4+n74ai213pWEBINK5RlE=;
        b=h9Dsj81SJbyXREFqv4ukLGHqhjwKL5He2U4obo/D5kJdncmSF794/KemZKse69uBeu
         9XYW0liAWaSNIh1n9pBTrUwNu4mTt8hJ3UszD3HNV8q5AwYw9QA+ycnIjExw5uC1g3ZY
         X8RsGU6OTmTzQ+wA9gaNrPSypl4MEaBcQ5ePYWTWcKBNHcdBOoI5fvHx+U3KZDlv+oz3
         H5ax2eaCSPI63hkh6ov4ebvrWda1NjfZ7nUKAiALYhG1pBcn6D4Sc9/BAcClYZOfi1ip
         eFOmIaEvzyPoI4PfSY+e0bRmuLgyA4rl6CbPK8uKEbPylwT+Lo2Kh3BaCygFfb3ZJfVv
         ZduA==
X-Gm-Message-State: AC+VfDxWO9g09HG2BYsxjSjOTLfKR2oUAK4H8lJmxv1e1clmnIDGP+a4
	pfOCO+IZPmci++kRu2MxDDstTlTsEIC2r/iTW5y5/g==
X-Google-Smtp-Source: ACHHUZ4anFMhhl6d3l+cP+I5ruuOfCxwjDRSVSbvsDzvACSHOt0YfwXfJ7Vfuobl1qSh5tsJzUOipg==
X-Received: by 2002:a05:6a00:218f:b0:64a:fa71:a98f with SMTP id h15-20020a056a00218f00b0064afa71a98fmr13477236pfi.13.1685347599126;
        Mon, 29 May 2023 01:06:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v5-20020aa78505000000b0063a04905379sm6246992pfn.137.2023.05.29.01.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 01:06:38 -0700 (PDT)
Message-ID: <64745d0e.a70a0220.6a176.c693@mx.google.com>
Date: Mon, 29 May 2023 01:06:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip34
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-pty: 11 runs, 1 regressions (v5.10.180-cip34)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 May 2023 08:06:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11691

cip/linux-5.10.y-cip ltp-pty: 11 runs, 1 regressions (v5.10.180-cip34)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip34/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip34
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      aa80091745d6b40c944d419c12ba8cb65b1a57a5

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  04e8f2f4fd9493f595b34320403cf6b4f1f6789d =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647456de00666b9f2f2e85f8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-pty-rk3399=
-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-pty-rk3399=
-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230519.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/647456de00666b9f2f2e85=
f9
        new failure (last pass: v5.10.180-cip33-21-g8eb0cdf459a2) =

 =20

