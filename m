Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0F6C71136
	for <webhook@archiver.kernel.org>; Thu, 12 Jun 2025 12:19:44 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.11607.1749730777444551489
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Jun 2025 05:19:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=smTC5NFr;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=
	1749730762;x=1750940362;bh=6+lnSgI6lmZ8ZFTJGSbQdMknvihNbxyM/Msy0ENYCks=;b=smT
	C5NFrOClcObjK5EtnI3PYnyb7nm8ZjDGFQAuWoCNU/ivDJIyYA8AvO24E4s8Zn1r1/terwdfp2LBw
	4wl2+Lb6I72DNRLTDTXlgRiY1KgJK6IJR8SxFfK327q1oe3zn1Avw2tzZOt1XfTDD68Er2owZuIsb
	6alqnMd2YXLvXdZaY5ES/LFVnW0BRddJ3tYfTB/7IgM9O3KdolBOfbjlr9AbmF98FFoB0n7jiEt7U
	iB+TgCzOiTUVbwlQNz21mZOLTRS4InOF2MG7B09Ai9tnHl3JM4LDrUgb5DzuRyehSIB0LwWwLf1+l
	/FZeVLMoxknJPTcAulSME++HDRUUrpw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 55CCJMDJ1212445; Thu, 12 Jun 2025 21:19:22 +0900
X-Iguazu-Qid: 2yAbpfLvIe3gqxA4XL
X-Iguazu-QSIG: v=2; s=0; t=1749730761; q=2yAbpfLvIe3gqxA4XL; m=XRycCN6cDMEh76OQSeQFUy+GxitJzkm6RzgHpaLaAYA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 55CCJK8D307800
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 21:19:20 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org, pavel@denx.de
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH for 5.10.y-cip 0/1] Fix build on rzg2l-video.c
Date: Thu, 12 Jun 2025 21:19:09 +0900
X-TSB-HOP2: ON
Message-Id: <1749730750-6914-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Jun 2025 12:19:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19039

Hi all,

This fixes a build error in rzg2l-video.c[0].

```
drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c:532:8: error: unknown type name 'irqreturn_t'
```

The main cause of this error is that linux/interrupt.h is missing. And
linux-5.10.y-cip needs the following commit.
  
  media: mc: Provide a helper for setting bus_info field

Adding this commit will also fix linux/interrupt.h.

Best regards,
  Nobuhiro

[0]: https://dashboard.kernelci.org/issue/maestro%3Abad69ae5a6031018d1b7534daa1623f5b6bc4cef?iv=1

Sakari Ailus (1):
  media: mc: Provide a helper for setting bus_info field

 include/media/media-device.h | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

-- 
2.25.1



