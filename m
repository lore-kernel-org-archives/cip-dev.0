Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.770.1793316309981700590
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Oct 2026 16:25:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20260707.gappssmtp.com header.s=20260707 header.b=SpPAaWS8;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.53, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-679965fb848so131664d50.1
        for <cip-dev@lists.cip-project.org>; Thu, 29 Oct 2026 16:25:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793316309; cv=none;
        d=google.com; s=arc-20260327;
        b=e8bQ4MOvCsXOKLBwk3nRW92MyhyzonVry41zoELNIrPTWmWI4jHQxGJTGJtNkHS5dq
         HEYa2b1Yxay5A2lZGaMU8JZpLUXKSKyJa2G1yzpfSW9XgPnLNzXi3OJygsuUEWhzLXuo
         +thISZNP1aLjCLTa4oSIeD/hwSEEc/3daU2kLwcxqNEVkULRzCw13vV9DlKmYBBtFKOU
         L/lNRAoS37Pw8UVnh2MX1mdJROfGTO01JpOmegp0FbMfmLS2RK3/NQqOH/oAqJ9aDFtI
         aNBbP6s929H164i3rNDpFC8pQrrYcBk6jouq0xGjrX0QKf4pJDCV2hgTVUJJpNAKpKT7
         fRdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=RaDpNpADj4zVqZ3ktOkQQA4RQzX5/gPSVxFQb/8NaSc=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=JNCS002a2qcLoOUTtd2diNHQGX1c6NBIAXzx39kR1cJZtbbJhtJ2JLJUz34XNRH44Q
         CnuVg67t1eUU0DlhImD0fZKFg1GM77j4jZiFma1I+kDIHczkZlj5CGB1tOrydlzSeGOe
         /CMuPyewrMGjzAlzx4D91FEyL1InGkKGtWa3XUxjK7XH69FMA+4lW8earRHMBK+XNJ2H
         qAVn2FGnzO3QoCXW1c5d5ZyQSf3pdof+IJR9wLQwn6zlF3EHZ1Ey9x0fdxFSxR7EKf46
         jfS1uW7E9AMPuG8cxgCw0prt1fFKKz+ibVtmK9066F9Mx8rf+GQz6sGCBohb2tXbCG0u
         obvQ==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20260707.gappssmtp.com; s=20260707; t=1793316309; x=1793921109; darn=lists.cip-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RaDpNpADj4zVqZ3ktOkQQA4RQzX5/gPSVxFQb/8NaSc=;
        b=SpPAaWS8foSnjs/FhoOVTlNYdyBGpLTpS12+yLJsvKHhWuSnfxxhCwDZIdPoBrvhP2
         Kba5mV2NU5n95Xv6FPsjp56iF0FMgHUdo0RqL3QuewAZ1Yix1rQywyVJC6g4aroeJd0k
         mUvy/TXQrRs9Ml7TlE1wZ5102ZYepelkEBPPxneUnT2+yBbbFybnrRtN3QvcLwBfR6+0
         7Pk4qmIsw+NyPXEi8GvuppPf3JmczzSbOEXQK/HuMOUJMdsYH9W0r2raQ2Gr1RZb6EqB
         LEMPJnxjB9qTjxmd5V46qeBf3YhuY5b4Fn/5fJqWRuNVGazjHV0yaQXdSpbvOVUm1FCd
         15WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793316309; x=1793921109;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RaDpNpADj4zVqZ3ktOkQQA4RQzX5/gPSVxFQb/8NaSc=;
        b=134eEyi/X2K6OsHp7e1ApCnCmjVrKTxaHrl4DFLyMj1euRQlghOOLMimwxVjjotoHn
         n/cgmu4KZrCE5M5dsIR4jcItnIt0SOeekvkPOos+oYpAKdqKHzek76f2nl8K3hsQZQFs
         O0h70pZsvnc33Bi0RREvPAocucO7c/SS7CN1JVcsxWd8GT49WM/nsANyXN928IZ+Yfda
         +K3kosYr2GIEhcf+yEpREm6H58W+IZaNUiVlgyK9GNW+sR6rjRaW94Ne99ysjpCBEfdn
         M3DrGj98E46DtTX0x1NhZG1UOD1ievNd+juhe7n6dKKu/MYtoUyO8S0K/z69A+1X5ZfO
         7bzw==
X-Gm-Message-State: AFq9FYLlYF7jH1LKQstIF6YbUoXc7zszNPvUg7uXPZXhuZeWtDsAekez
	w31/pzaCuKusTuJeK2jF01+Nxv6fRkpk7xRGbTo4v9yDDLlS7FKbwijVWO8Vjv1MICGD3jLq9Gg
	Xg17WSubJDPQA5nV33wMFw/ELrhKKc4JUWwoCIBXffn6meGYjDP6xm+Gk8g==
X-Gm-Gg: AYBFou3ufP+ZaXTr0iEQB9JKsYny6VauXii/P+/TQhczpznK0mw+zpBxIti+vFsFv+x
	CgDI6/XTs6v4d0+hNwt22TkBGB7KDZ+yIWBXmh4kyQMHVrxRB0hgLjvwLIw7e1P8EJoMalDHp4H
	TKDLyUR2QcadWZilpCyw+yRPWnWic1VLKSESNZ9PYcgEQMuI6lGW7vUVELL3AndOn7TMgxwi0j0
	XwaYNg5jqbotWa77ZqB5CesCkZo7dCN7zx1gp7qlD0vJi+R1ZLiacu8cZ1K2GzTbOtqsLcR2xxe
	bAOL4G+qe5eQYkTsL8drsxvjQTwWoeGps/mbuuTLiC2mzWlzmGhuzLSpbaBSYl+YwOhnsaIFjUV
	RacGZAPfM6qbceqIrsayyfuUOtML2vhE7GJL/kXAG3yw5K81vnFk/vsB/ZD1K3a9HwgDhUU1Z5+
	E0RYDBNpy46w==
X-Received: by 2002:a05:690e:12cd:b0:67a:8c43:753 with SMTP id
 956f58d0204a3-67ba504891emr333959d50.97.1793316308484; Thu, 29 Oct 2026
 16:25:08 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Fri, 30 Oct 2026 08:24:31 +0900
X-Gm-Features: AclHuK8u7El_m0ampsHBw2Y8KMBrbJwm2xqG85PispXR1ElwD-IQwxBhDrqPR-4
Message-ID: <CAODzB9rMsTzkUBdus6m6u2Aa_5vu-7GUhjdKskk88akgo1JpUQ@mail.gmail.com>
Subject: CVE-2026-98432: Remote code execution in Linux MPTCP feature
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 29 Oct 2026 23:25:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24577

Hi,

Anthropic reported CVE-2026-98432 as remote code execution in Linux
MPTCP feature[1].
They said that "After initial prompting, Claude wrote an exploit that
allows a remote attacker to send packets to Linux servers with a
multipath TCP listener to run arbitrary commands as root, without any
credentials or user interaction. The underlying vulnerability is a
race condition-induced UAF bug in the kernel networking stack." so
that an attacker can attack anywhere without any credentials.
The CVSS is 9.8 by Linux CNA[2].
It seems as if PoC has not been published yet.

This vulnerability is introduced in Linux 4.4.
The mainline and stable trees are fixed by following commits.

mainline: e3f33b0a1d89d738e2b913dab519226eaf76e15b
stable/5.10: b3b027ef0cd322bfa839b9aaf5b27551eea54cf6
stable/5.15: 95a8c8fa9f27dce64c40c41c062de7728bf34ab5
stable/6.1: 89b5b1eb7d633c33832b7ff2c02e19a144705036
stable/6.12: 11a03ce3c4a62d84c10ccdfe47f8075006498568
stable/6.18: a47406c769f72c070386985488f1c4d057df86b2
stable/6.6: 742f73df544e03744f2981c467d6542fe8172a2a
stable/7.2: 26d4c36d318cffbbd160884a0e4cec0da4da4936

For more information, you can read an article by thehackers.com[3].

[1]: https://www.anthropic.com/research/discovering-vulnerabilities-with-claude
[2]: https://www.cve.org/CVERecord?id=CVE-2026-98432
[3]: https://thehackernews.com/2026/10/linux-kernel-tcp-flaw-with-98-cvss.html

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com
