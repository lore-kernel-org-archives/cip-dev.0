Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3438EC4828E
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 04:45:56 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
 by mx.groups.io with SMTP id smtpd.web10.16362.1706849146367360307
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Feb 2024 20:45:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=XKssrKbl;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=54/+TkST;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.50, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1706849126; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YGCR0UzvSlO1qna5LFQtBmA5KkZokPnCvkKkTu6a3ZTYe329UhMKUvMvH1RF3ElXxv
    5NSvNNVtAp0Sr1Dk2VnG8WBxAWoSRMjPrUwnv2eUJxEOhPv2xrsY9ZcRGxPDqobG8XQi
    A3v/kUIaNejLwssctMt8pKCdfkiTgZlNNw2X+HlhVoboZAUctUbZ1cDw3Xe2shxMTnpb
    dJgeQCnf7//3jFwFImM87dAL/Fnd46GxN4f3xEAgnEFQnz0cD4WKqs+Q6yDL2RtTpRcr
    hxXhRnYP0DP/CGWI73A0UJadbtGnADVsUJzZu0e3Bbzrfeuwcch7vZlN11sSY9DeicGz
    kmAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1706849126;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=7tZtS36bQpUC8Ek1sUoZRPGwBZ6vlDcPIuiByvneENY=;
    b=gSyrtcMDb61qisePaGF1BduIAL2dctzu4kcf/jwMiTZg6hgTJjb5dHUM+PLbEkWOJF
    VSFZILhAaiANR9PlVO3mYq/HtjRzcxpOACbMdwQB6TXYeot1FrdkXWgDIEQbYjUE9TKk
    pEkUo9lVTdSYvT1NdB8vL0Q8xrh6LLzEJdWFyuj1xMjc4U/F4t9ANzK9nRukUSLsEd2+
    IHhb73vDT18wIrY0I4/4wXbzqPiBQv5iBxNLAco+Qm9k8IM272964eJ0HeXHYYuJrDhs
    XXz8PqBu0/tKU3/wGfsXgitjtX2GAWjPAMb4zBh1DgeeslEWhmA6GKTFsvi/RSG8+jvp
    ig5Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1706849126;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=7tZtS36bQpUC8Ek1sUoZRPGwBZ6vlDcPIuiByvneENY=;
    b=XKssrKblSLgMDNIrV5C9ssBJfA/ecTBlTTVOnJMVfypG88wW42wN7pwiMHmVsClqCa
    1HEUvI8ETzi32DIT+Yr6PTeIsUUAauxlArQ3/N4EBlHF9YBthRk2gz7aNCfFCIKD/MNy
    knRqWI3JwaZOLQuXkN0ISDH82hlHW8uOVeeNfa9KfXhEOTYWUcJcTF6NsFOkdOHNABzm
    h/0CNmWi4DWIqRrGQijw+nSevQqMFi75vRnf+Bxk7l+TILEMyv1j9IIcyQnEwci6i96a
    sPyP6oiKldPyCA6CAIcjx2vvrGzBB9t/58QM2GIbY9rKomHQuPuBQG84aeVjtR5jcoOY
    3LUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1706849126;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=7tZtS36bQpUC8Ek1sUoZRPGwBZ6vlDcPIuiByvneENY=;
    b=54/+TkSTOXcs0x4ZOOPdlwLL8DyBz/3DcDZEGMq1nivkWUGRkV8Bz/puZ5g+2L6M+l
    3z7Z7LxM1a9nxE+uKcCQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGl/wuMlg=="
Received: from ox-live-app101.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.11.2 AUTH)
    with ESMTPSA id Z7ddde0124jPXUo
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Fri, 2 Feb 2024 05:45:25 +0100 (CET)
Date: Fri, 2 Feb 2024 05:45:25 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1043550080.65973.1706849125840@webmail.strato.com>
Subject: [ANNOUNCE] Release v4.4.302-cip84
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev57
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Feb 2024 04:45:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14600

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip84. The linux-4.4.y-cip tree's base version has been updated to v4.4-st49. The trees are up-to-date with kernel 4.14.336. This is the last release based on the 4.14.y patch stream.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip84:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      779dae67e799dfb8a0267e26038ab74c58261f24
    Fixed CVEs:
      none

Best regards,
Ulrich Hecht

